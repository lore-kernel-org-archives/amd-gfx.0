Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E4C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 02:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A68222E9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 02:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvlXnWJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A68222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1466EC03;
	Tue, 20 Oct 2020 02:15:51 +0000 (UTC)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923086EC03
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 02:15:50 +0000 (UTC)
Received: by mail-il1-x144.google.com with SMTP id t12so389918ilh.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 19:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=Tk8oXdIUbW4pBQZvBy8Lbwq+Hqbuajep26zveAqO7v4=;
 b=LvlXnWJ2Z2I7VSbzERZ2vnT59xVPSl4nJmItfMeah821qMy8zs9XGYSVs23GNUP0C8
 n0BBYfp9vX5/IINZLJjoEK39GJFHIOtcK7sMrrQ3N3NSCS5hVZ1CvNqYj1FPK66PGT9W
 aN4ak1zMlCq2qfHl7ZvL/3W/Ibt5Lhlk1fJJ4zTKcWTItSOPpGTJzCe9jKCE5OMJWOCm
 TOsS1/6gFiYyF9/eCJ2rnxh0a1k5ExSpau6KhNpMdtSkVwbWsTjMKiFgV/1ndAAkjwhf
 Aqq5Q0eTuoSh0G8dXknyOnfvCBa6zqYqUrfjzE66AI3AWZv6HUkLU7OGnqyr+wMrMBzP
 WzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=Tk8oXdIUbW4pBQZvBy8Lbwq+Hqbuajep26zveAqO7v4=;
 b=r0yLuVJriX+HVFNrV4WuLRRcstd0BvCJkLzYOSb5GYfjbmgv9vSZm6wd8GagH+LOwv
 yfzaLxjcUWkIqCe7ySNvZgQ0tKNV4NQQFkSYArOJFeJ1ZiAG4GGcrn+ETDj5r/pKAOW9
 3mid3uhOzaLR/pkJr1M7vDvuFjYrr1dywhiuG3+T91stYF4bqL1EoWbTjuXyPtwnuf3y
 azFL/YPyZi8CddXZAIPcGdS9gJxqCv2gHmd/WKSEYRL/OHBvDX7rXmpIALnEeY4eUEZE
 lxY5pqyJaVYUAiwkho/pWOFHm1xg7Eypc3GQfxKMMl/oJ9e4u8imtWEYIdstQPc6GkJ7
 Ko9A==
X-Gm-Message-State: AOAM530MeM8x1fpvur3uaqrvCM0k8oICvh3bTNDAhcpoMsSoevenfi2L
 uy3obhyCj1Jns4rDThM45eNyuReCGc0o5tHc
X-Google-Smtp-Source: ABdhPJzLCvoA5DgZY5Epoddv6vC4maasgqp6H87AtDzGTogulSJ4Q6y3nPC2g5UnZbjaWUpZC9BGbg==
X-Received: by 2002:a92:5a08:: with SMTP id o8mr327927ilb.32.1603160149681;
 Mon, 19 Oct 2020 19:15:49 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:aa5e:45ff:fed0:7395?
 ([2602:4b:a6ae:c000:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id e12sm446349ilq.65.2020.10.19.19.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 19:15:48 -0700 (PDT)
From: Matt Coffin <mcoffin13@gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: setup system context in dm_init
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201014070431.32207-1-yifan1.zhang@amd.com>
 <2ee6e905-ea6f-ded8-d72f-b14aac541b76@amd.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 H0qwCIawk+A+IV3Jri8YZx+EJ1F10DxXcsQJdA==
Message-ID: <319d2166-e998-7a7d-b4ee-e7cf158afda3@gmail.com>
Date: Mon, 19 Oct 2020 20:15:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2ee6e905-ea6f-ded8-d72f-b14aac541b76@amd.com>
Content-Type: multipart/mixed; boundary="------------936362EB0C0817366C7FB4C7"
Content-Language: en-US
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: sunpeng.li@amd.com, harry.wentland@amd.com, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------936362EB0C0817366C7FB4C7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello all,

I just bisected an issue introduced recently for me where I get screen
corruption before even getting a TTY, and it came down to this commit.

I've got a Navi10 card, and after this commit all that is displayed is a
blank screen (with some obvious corruption artifacts), before I even get
to a tty.

If you'd rather a GitLab issue, just let me know in a reply and I can
file one, but I thought it would be easier to ping those involved since
I already bisected the issue.

I've attached a log of a boot/shutdown sequence from this commit on
amd-staging-drm-next to aid with debugging.

Let me know if you need help reproducing, or fixing. I haven't had my
hands in the display/dc code at all yet, so it would take me some time
to ramp up but I'd be more than willing to help if necessary.

Thanks in advance,
Matt

On 10/14/20 7:20 AM, Kazlauskas, Nicholas wrote:
> On 2020-10-14 3:04 a.m., Yifan Zhang wrote:
>> Change-Id: I831a5ade8b87c23d21a63d08cc4d338468769e2b
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 61 +++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 3cf4e08931bb..aaff8800c7a0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -887,12 +887,67 @@ static void
>> amdgpu_check_debugfs_connector_property_change(struct amdgpu_device
>>       }
>>   }
>>   +static void mmhub_read_system_context(struct amdgpu_device *adev,
>> struct dc_phy_addr_space_config *pa_config)
>> +{
>> +    uint64_t pt_base;
>> +    uint32_t logical_addr_low;
>> +    uint32_t logical_addr_high;
>> +    uint32_t agp_base, agp_bot, agp_top;
>> +    PHYSICAL_ADDRESS_LOC page_table_start, page_table_end,
>> page_table_base;
>> +
>> +    logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start)
>> >> 18;
>> +    pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
>> +
>> +    if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>> +        /*
>> +         * Raven2 has a HW issue that it is unable to use the vram which
>> +         * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
>> +         * workaround that increase system aperture high address (add 1)
>> +         * to get rid of the VM fault and hardware hang.
>> +         */
>> +        logical_addr_high = max((adev->gmc.fb_end >> 18) + 0x1,
>> adev->gmc.agp_end >> 18);
>> +    else
>> +        logical_addr_high = max(adev->gmc.fb_end, adev->gmc.agp_end)
>> >> 18;
>> +
>> +    agp_base = 0;
>> +    agp_bot = adev->gmc.agp_start >> 24;
>> +    agp_top = adev->gmc.agp_end >> 24;
>> +
>> +
>> +    page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) &
>> 0xF;
>> +    page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
>> +    page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
>> +    page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);
>> +    page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
>> +    page_table_base.low_part = lower_32_bits(pt_base);
>> +
>> +    pa_config->system_aperture.start_addr =
>> (uint64_t)logical_addr_low << 18;
>> +    pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high
>> << 18;
>> +
>> +    pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
>> +    pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
>> +    pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
>> +
>> +    pa_config->system_aperture.fb_base = adev->gmc.fb_start;
>> +    pa_config->system_aperture.fb_offset = adev->gmc.aper_base;
>> +    pa_config->system_aperture.fb_top = adev->gmc.fb_end;
>> +
>> +    pa_config->gart_config.page_table_start_addr =
>> page_table_start.quad_part << 12;
>> +    pa_config->gart_config.page_table_end_addr =
>> page_table_end.quad_part << 12;
>> +    pa_config->gart_config.page_table_base_addr =
>> page_table_base.quad_part;
>> +
>> +    pa_config->is_hvm_enabled = 0;
>> +
>> +}
>> +
>> +
>>   static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   {
>>       struct dc_init_data init_data;
>>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>>       struct dc_callback_init init_params;
>>   #endif
>> +    struct dc_phy_addr_space_config pa_config;
>>       int r;
>>         adev->dm.ddev = adev_to_drm(adev);
>> @@ -1040,6 +1095,12 @@ static int amdgpu_dm_init(struct amdgpu_device
>> *adev)
>>           goto error;
>>       }
>>   +    mmhub_read_system_context(adev, &pa_config);
>> +
>> +    // Call the DC init_memory func
>> +    dc_setup_system_context(adev->dm.dc, &pa_config);
>> +
>> +
> 
> The dc_setup_system_context should come directly after dc_hardware_init().
> 
> With that fixed this series is
> 
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> There's the vmid module as well that could be created after if needed
> but for s/g suport alone that's not necessary.
> 
> Regards,
> Nicholas Kazlauskas
> 
>>       DRM_DEBUG_DRIVER("KMS initialized.\n");
>>         return 0;
>>
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------936362EB0C0817366C7FB4C7
Content-Type: application/x-xz;
 name="screen-corruption-before-tty.log.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="screen-corruption-before-tty.log.xz"

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
--------------936362EB0C0817366C7FB4C7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------936362EB0C0817366C7FB4C7--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543E4C77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAADC10E11E;
	Wed,  3 May 2023 15:25:43 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A2B10E11E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:25:42 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-50bd2d7ba74so7831200a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683127541; x=1685719541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JdifjPX4m3vMFO75Ga4xDAyJjLR0nbUUlfR6FICggYg=;
 b=WWTyXJGCi8t54EaRSn8L3NVFX/B2g1JGIeTqFk+Ee0OLMN2pP3Za/B5u/Q6FeTmHfn
 4zqr2jISwzLjRuFv/gHh8o3JIoz+TalnlLMgyeRyVzLlEENP0H3uDjtfGMeQVoESVXEH
 QAyUC6oljCom/4oXrZdO7EV7EPdfW2FozGfRf3iiAzCJTztktwr9BB7shcFBGPeHJAwt
 GG892iGtoQq0y2aIa5FmczXlYbm5ljCcTqkPhGiem2Jff44ufpdcbm+GlP2cfRIKYyhx
 0itDutGj1BfWm/tpC+9x0V3qCTZjHa+8XsTw1Rl/bAUwthR5fLV2Z3ubBHnF7lNYnWPh
 iOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683127541; x=1685719541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JdifjPX4m3vMFO75Ga4xDAyJjLR0nbUUlfR6FICggYg=;
 b=eUhUsWp53bZzqpHYT8RAf9XvE93pWoYAwn9rnn8n/pP2jEew565gZsBFVIEia4Asq7
 5cF9Al7h6K/NkFJ0hB5Hmr91GyXr/KEUWz1XR9bHy+Y1Qe47PcQHWA/fRDde1Mruh6Xx
 l3ggYZXqag4DcXPZjRhSzehy+V1QGs9nd+FngGks81XYUd+R7YsM9CMrIXnxuQsLsios
 PPQ+rhrAz/ZuCXpUzzEq1tMElTilnIccmbSyuL6Dq/RkY/DHd0Y1lQ5L2oNMqcZv7can
 YBy7VHWurWHSfl8eaH3MN5jDKplFkz+XdP6ll1mBluD3tLP4AYLRUbDqFwuRRHdOGrET
 VD6g==
X-Gm-Message-State: AC+VfDx5if7Ms/8Zpoon1GzYYNb6meFAIvXBgR7R8Kfgf1MnR5k+kPWS
 otgRPXQFc6Q/cV+X0aj1wpo=
X-Google-Smtp-Source: ACHHUZ6G9HsNp2lfDLHI1p2WA5krnAta4jXZ1aU3sh4+z7XMTNeWUchFMBdXqOMoDpKSJwBvL4GHiA==
X-Received: by 2002:a17:907:72d1:b0:94f:1d54:95d2 with SMTP id
 du17-20020a17090772d100b0094f1d5495d2mr2535505ejc.15.1683127540688; 
 Wed, 03 May 2023 08:25:40 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:130a:3ed0:3dbc:854b?
 ([2a02:908:1256:79a0:130a:3ed0:3dbc:854b])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a17090648c500b008c16025b318sm17492207ejt.155.2023.05.03.08.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 May 2023 08:25:40 -0700 (PDT)
Message-ID: <dc6b5702-f7eb-f86c-2cad-5b67b3668865@gmail.com>
Date: Wed, 3 May 2023 17:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] drm/amdgpu: drop unused function
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230427183429.599578-1-alexander.deucher@amd.com>
 <20230427183429.599578-2-alexander.deucher@amd.com>
 <CADnq5_MAiEcCAE79NoeC5FU9eh+kgYBjD0azagRyaDvuXSEGcA@mail.gmail.com>
 <7a3221a9-242a-7a83-f380-c1d0bd8d8c9f@gmail.com>
 <CADnq5_POJ5ULX8WeiTkxwRiTDxaG8uh_BqCKmcmHOsEddUx_Pg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_POJ5ULX8WeiTkxwRiTDxaG8uh_BqCKmcmHOsEddUx_Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.05.23 um 17:24 schrieb Alex Deucher:
> On Wed, May 3, 2023 at 11:20 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Reviewed-by: Christian König <christian.koenig@amd.com> for this one.
>>
>> Can't say much about the first one. That was just the hack because some
>> bit in the IP version was re-used on SRIOV, wasn't it?
> Yes, the high 2 bits of the revision number were reused for additional
> information so they needed to be masked out when considering the IP
> revision.  We already track those extra bits elsewhere and mask out
> those bits so that IP version is never seen anymore in practice.

In this case rb for that one as well.

Christian.

>
> Alex
>
>> Christian.
>>
>> Am 03.05.23 um 17:02 schrieb Alex Deucher:
>>> Ping?
>>>
>>> On Thu, Apr 27, 2023 at 2:34 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>> amdgpu_discovery_get_ip_version() has not been used since
>>>> commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
>>>> so drop it.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 48 -------------------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 -
>>>>    2 files changed, 50 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> index 76ceca05452e..b58d94dc1924 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> @@ -1208,54 +1208,6 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>>>           return 0;
>>>>    }
>>>>
>>>> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>>>> -                                   int *major, int *minor, int *revision)
>>>> -{
>>>> -       struct binary_header *bhdr;
>>>> -       struct ip_discovery_header *ihdr;
>>>> -       struct die_header *dhdr;
>>>> -       struct ip *ip;
>>>> -       uint16_t die_offset;
>>>> -       uint16_t ip_offset;
>>>> -       uint16_t num_dies;
>>>> -       uint16_t num_ips;
>>>> -       int i, j;
>>>> -
>>>> -       if (!adev->mman.discovery_bin) {
>>>> -               DRM_ERROR("ip discovery uninitialized\n");
>>>> -               return -EINVAL;
>>>> -       }
>>>> -
>>>> -       bhdr = (struct binary_header *)adev->mman.discovery_bin;
>>>> -       ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>>>> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>>>> -       num_dies = le16_to_cpu(ihdr->num_dies);
>>>> -
>>>> -       for (i = 0; i < num_dies; i++) {
>>>> -               die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
>>>> -               dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
>>>> -               num_ips = le16_to_cpu(dhdr->num_ips);
>>>> -               ip_offset = die_offset + sizeof(*dhdr);
>>>> -
>>>> -               for (j = 0; j < num_ips; j++) {
>>>> -                       ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
>>>> -
>>>> -                       if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
>>>> -                               if (major)
>>>> -                                       *major = ip->major;
>>>> -                               if (minor)
>>>> -                                       *minor = ip->minor;
>>>> -                               if (revision)
>>>> -                                       *revision = ip->revision;
>>>> -                               return 0;
>>>> -                       }
>>>> -                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>>>> -               }
>>>> -       }
>>>> -
>>>> -       return -EINVAL;
>>>> -}
>>>> -
>>>>    static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>>>>    {
>>>>           int vcn_harvest_count = 0;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>>>> index 8563dd4a7dc2..63ec6924b907 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>>>> @@ -28,8 +28,6 @@
>>>>    #define DISCOVERY_TMR_OFFSET    (64 << 10)
>>>>
>>>>    void amdgpu_discovery_fini(struct amdgpu_device *adev);
>>>> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>>>> -                                    int *major, int *minor, int *revision);
>>>>    int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>>>>
>>>>    #endif /* __AMDGPU_DISCOVERY__ */
>>>> --
>>>> 2.40.0
>>>>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AC7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 08:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF17A10E51D;
	Thu, 16 Dec 2021 08:38:59 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D71710E3D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 08:38:58 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id i12so18410433wmq.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 00:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=ucet4WcQz5FeLWjJSV8i0KhS6SQRy2a36CF/KMAh9Mw=;
 b=qLyV96KTxaeZ44mER6q0ZpHnX9YYIz+zANBvYuckVnfLBqD0g8dPQtqgqkb7OdQAZr
 f4VFMoV6s4rU3wJ4J6x3mV6sg2WaQ7u6uZWgTNyWDgymgh2uUkiUA+C3hk7RaPeyl83n
 JAb3plC8KOx1Jv+xMP0URj9OY5gy35ButnWtoq5F7MZZSaDs2lm+fnUaqfpDLsJn4BpT
 eJ04CTIPoCbcOw5xTulH8elaY50uZa+3LeHlgB3FbcWvqu3xb2z83YMhb5czqE0EpeOH
 hHUsYQV1ED50pTbFI+r6kS0EyTmOqn5r0J7EOXxa7SfmsEMOgVBFCwKqhdYRu3Q9zh50
 e+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ucet4WcQz5FeLWjJSV8i0KhS6SQRy2a36CF/KMAh9Mw=;
 b=AKw3YsmACt1PtAnLjWCAE88uDLixoVgvhFkY1NO1TVKYJcK66kL7ftNlmv04XCpqNy
 ieLF7VO5/PJYkuB4PIFmOdeR3ahEUhVGXWdl4tH0KEF40iFg6Q6tIN8ieMhBETkvZZU8
 4u3vOi4CELd7AMahHaKSVPKGPQhOqR1I9WOsnKFiK8vG2M2buPj7X9mUS3QGxweh/tJ6
 5e/UxwxsMgh6/oyYHck3nUQntaY2h9htBSm/OblcMUfly06qNzg2oQDin+7w5KzWkfLT
 In/9MclyfSf0XShO5zkrReH1xoCANjmsU/Cm89NaWA4Af8ltEO6ZDBVmBZu4UdtvLlii
 wXAg==
X-Gm-Message-State: AOAM531tqk90cUMIFD3v6//yX5fqG3LTLJdxabqQjIN7p9IOus7xIgac
 xHBur0z6Q6ImAeDcyh8a89RhNoBxLVo=
X-Google-Smtp-Source: ABdhPJwfjMWPQHppY/PQ0/ikXu3XsajB+XjwvfTDRjZi+SXksfOPU6Ax7XfScyRV4iTcaFcmtS/Q5g==
X-Received: by 2002:a7b:c1c9:: with SMTP id a9mr3881136wmj.152.1639643936820; 
 Thu, 16 Dec 2021 00:38:56 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id l8sm7726003wmc.40.2021.12.16.00.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 00:38:56 -0800 (PST)
Subject: Re: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device
 is unplugged to prevent crash in GPU initialization failure
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Shi, Leslie"
 <Yuliang.Shi@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211216061342.2385661-1-Yuliang.Shi@amd.com>
 <DM5PR12MB2469859E35394E34AC2A7A01F1779@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CO6PR12MB545814E39E2A95074E7924CCE0779@CO6PR12MB5458.namprd12.prod.outlook.com>
 <DM5PR12MB246983C6BC18ECA5EAC2F86FF1779@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2a61cafc-408e-f228-3349-f97d6005c4e4@gmail.com>
Date: Thu, 16 Dec 2021 09:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB246983C6BC18ECA5EAC2F86FF1779@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The !drm_dev_enter() is quite unusual and deserves a comment explaining 
what's going on here.

Apart from that it looks good with the typos fixed I think.

Christian.

Am 16.12.21 um 08:27 schrieb Chen, Guchun:
> [Public]
>
> My BAD to misunderstand this.
>
> There are both spell typos in patch subject and body, s/iff/if.
>
> The patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>
> Please wait for the ack from Andrey and Christian before pushing this.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Shi, Leslie <Yuliang.Shi@amd.com>
> Sent: Thursday, December 16, 2021 3:00 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device is unplugged to prevent crash in GPU initialization failure
>
> [Public]
>
> Hi Guchun,
>
> As Andrey says, "we should not call amdgpu_device_unmap_mmio unless device is unplugged", I think we should call amdgpu_device_unmap_mmio() only if device is unplugged (drm_dev_enter() return false) .
>
> +if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	amdgpu_device_unmap_mmio(adev);
> + else
> # 	drm_dev_exit(idx);
>
>
> Regards,
> Leslie
>
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, December 16, 2021 2:46 PM
> To: Shi, Leslie <Yuliang.Shi@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device is unplugged to prevent crash in GPU initialization failure
>
> [Public]
>
> Hi Leslie,
>
> I think we need to modify it like:
>
> +if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	amdgpu_device_unmap_mmio(adev);
> +	drm_dev_exit(idx);
> +}
>
> Also you need to credit Andrey a 'suggested-by' in your patch.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Shi, Leslie <Yuliang.Shi@amd.com>
> Sent: Thursday, December 16, 2021 2:14 PM
> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device is unplugged to prevent crash in GPU initialization failure
>
> [Why]
> In amdgpu_driver_load_kms, when amdgpu_device_init returns error during driver modprobe, it will start the error handle path immediately and call into amdgpu_device_unmap_mmio as well to release mapped VRAM. However, in the following release callback, driver stills visits the unmapped memory like vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.
>
> [How]
> call amdgpu_device_unmap_mmio() iff device is unplugged to prevent invalid memory address in
> vcn_v3_0_sw_fini() when GPU initialization failure.
>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fb03d75880ec..d3656e7b60c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3845,6 +3845,8 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>    */
>   void amdgpu_device_fini_hw(struct amdgpu_device *adev)  {
> +	int idx;
> +
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
>   	if (adev->mman.initialized) {
> @@ -3888,7 +3890,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   	amdgpu_gart_dummy_page_fini(adev);
>   
> -	amdgpu_device_unmap_mmio(adev);
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		amdgpu_device_unmap_mmio(adev);
> +	else
> +		drm_dev_exit(idx);
> +
>   }
>   
>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> --
> 2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160B4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 10:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E0310E7F2;
	Thu, 10 Mar 2022 10:06:15 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB43F10E7F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 10:06:13 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id b24so6239591edu.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=m9Wj6LjfKHjK78zdpRDCFD9ongSbSK/FwetYHUpAStY=;
 b=UrajsquZoyrD/RqzEt+AU9Miicn5yd1vF87rJhSRObkfV+7jaEujEbYk7JdnzjWZVe
 JKhGzy3qK8MKG0haFDhg9hzXi4SVWIzMUpwzOW6T/qOj2BysN/i9zOtooXEHVTwtD2RN
 6CROPuf6mG8FjEVs8dnwoUIXK3o9QVDcflSi5MJ7i3LQiN/O/pKxHWz41T77OjBjMDT8
 4hZD02rD1/znL18qEqsi1jLFK1UV2mq0bM4KqRft2XYWtmmeXxwTB1bEWXCoM9Nw5H/U
 fn8+N+Kke9n4ij9opm/sDqHF3lmm3Rx+REpYlUtZMGqxI4sau7xdhjIxINOVSNUQy0f2
 fyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=m9Wj6LjfKHjK78zdpRDCFD9ongSbSK/FwetYHUpAStY=;
 b=rpsobxnCbE7QdQzTe4Mtx026LSUHrYGTQMKlBlrO+/0+PmB+KeRHPFAPPnUC0hemVm
 u7BmLHzQlDzqG63yL1hk4wkVd9NW37z9DL6yhR4i93nwCgUfMXw8BhruDEs3Nuti7F3D
 B8zS5OqezN3zWQswkoC3pX/NU4qGmNIdK4jt1Xsh/uYoQn/UdRgeTrAq6GjAT7U+ZfkI
 85VHGA8ceQQ5NnSKsqmYPAmcHRaoO0thTX7pM6PEwJ95Ms288eyQ+zL1pn1AzNW/bjt/
 ZLknz8JmSCXhIvE01lUwPgRDBkkmA92zCOKyvj3TRy3iFaxGAQeBK9s85c/Ep5eCeGTK
 GOCQ==
X-Gm-Message-State: AOAM532zQnrU8UpUH0eGyOjUeJJDIv+wl5lxVK31rYpKN9nIYFS0G/9O
 8f9ujk5cIV2UqYP0awrcwHs=
X-Google-Smtp-Source: ABdhPJwpyQ09qWBnUNiM73Z4/SvpiO7Gn7mi6Sub0PW3uMjf4/kDxU1I199CuDZdEMagyOjitY5EfA==
X-Received: by 2002:a05:6402:5146:b0:415:fd95:6afa with SMTP id
 n6-20020a056402514600b00415fd956afamr3523121edd.200.1646906772351; 
 Thu, 10 Mar 2022 02:06:12 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:87b1:f8fa:c08e:8bd0?
 ([2a02:908:1252:fb60:87b1:f8fa:c08e:8bd0])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a50d982000000b00410dc0889b9sm1845734edj.63.2022.03.10.02.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 02:06:11 -0800 (PST)
Message-ID: <deb521dc-9c77-1fb2-18b4-c62a640b052c@gmail.com>
Date: Thu, 10 Mar 2022 11:06:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] drm/amdgpu: add sdma v5_2 soft reset
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
 <20220310061155.39292-4-Victor.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220310061155.39292-4-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.03.22 um 07:11 schrieb Victor Zhao:
> enable sdma v5_2 soft reset
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 79 +++++++++++++++++++++++++-
>   1 file changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 4d4d1aa51b8a..f9f978d8fe8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -806,6 +806,80 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static bool sdma_v5_2_check_soft_reset(void *handle, struct amdgpu_job *job)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	if (job) {
> +		if (!strncmp(job->base.sched->name, "sdma", 4))

That's a really big NAK, please no string comparison in the kernel if it 
isn't absolutely necessary.

Regards,
Christian.

> +			return true;
> +		else
> +			return false;
> +	} else {
> +		u32 tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
> +
> +		if (tmp == 0xffffffff)
> +			return false;
> +
> +		if (tmp & GRBM_STATUS2__SDMA_BUSY_MASK)
> +			return true;
> +		else
> +			return false;
> +	}
> +}
> +
> +static int sdma_v5_2_pre_soft_reset(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i, j;
> +	uint32_t tmp, f32_cntl;
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++)
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), 0x10);
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		for (j = 0; j < 10; j++) {
> +			tmp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
> +			DRM_DEBUG("SDMA%d_FREEZE=0x%x", i, tmp);
> +			if (tmp & SDMA0_FREEZE__FROZEN_MASK) {
> +				WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), 0);
> +				break;
> +			} else {
> +				udelay(10);
> +			}
> +		}
> +		if (j == 10) {
> +			DRM_ERROR("SDMA%d_FREEZE frozen not set", i);
> +			return -1;
> +		}
> +	}
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdma_v5_2_post_soft_reset(void *handle)
> +{
> +	int i;
> +	uint32_t f32_cntl;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 0);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> +	}
> +
> +	sdma_v5_2_gfx_resume(adev);
> +	udelay(10);
> +
> +	return 0;
> +}
> +
>   static int sdma_v5_2_soft_reset(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -831,7 +905,7 @@ static int sdma_v5_2_soft_reset(void *handle)
>   		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
>   		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>   
> -		udelay(50);
> +		mdelay(2);
>   	}
>   
>   	return 0;
> @@ -1655,6 +1729,9 @@ const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
>   	.resume = sdma_v5_2_resume,
>   	.is_idle = sdma_v5_2_is_idle,
>   	.wait_for_idle = sdma_v5_2_wait_for_idle,
> +	.pre_soft_reset = sdma_v5_2_pre_soft_reset,
> +	.post_soft_reset = sdma_v5_2_post_soft_reset,
> +	.check_soft_reset = sdma_v5_2_check_soft_reset,
>   	.soft_reset = sdma_v5_2_soft_reset,
>   	.set_clockgating_state = sdma_v5_2_set_clockgating_state,
>   	.set_powergating_state = sdma_v5_2_set_powergating_state,


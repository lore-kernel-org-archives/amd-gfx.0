Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD270C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 06:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E7D10E025;
	Thu, 20 Oct 2022 06:00:06 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE5F10E025
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 05:59:58 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id g27so28326746edf.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VNedVAVlDPvZlbnTiChgngo3Mh45Ap1sV+sZ+ksGGQE=;
 b=CEPFcGO7P3EEySeqawrfEMD3Ei1D886Icv4/S5wFoUMCk6guORy+nJgHHOdJkxduuB
 lBeyfpCuX2hOaTl+f6G6ZUA3yR92NyJ5wg7jZK3PMtOSS4JAUKCIPU91PJKzaj+OtaID
 4Y4Bgj5CYx3IIIb3GqKT1LtLqfcJD9f79LKcCUjbabFf6vVhYoqgzSOngs+b1VwIid2p
 iNMkue2mfdbKVVUFTbVQok2oIcImN74c833PXUq8vjtQ4fvRieCYDnOJ/UH/w+2s4wDI
 SqRO+W52VLyI+iXM62N5iCu3c+KwbKvcuoOqBXahd5EEKLPnKu/S5XsfxNoftEnUQ43y
 9lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNedVAVlDPvZlbnTiChgngo3Mh45Ap1sV+sZ+ksGGQE=;
 b=IxptZhT7j7/eqH2nGFqzj/QGKbnHTKyuQ5FXNp7IcndVgEtwmiVgPADR0+UTalEGen
 eys3Bi7cA7DsS4DUUi32NLYLBfDIC2+gbZKsBiatJIGM5kC8k4COcY8csz7ADurwmxWI
 9cr/FcaWh1lQ+XrJiXpTb59bx9RU8fnREp2VhIvBStD+SikcORgSrD+Y1ClGt6rNr8zv
 mt3TYYX2uCwc/S/qqqKLSh2c2bS0eJ9KdxrW91jOapgkEzadOlMCyn9DqN4uz4yV8VDg
 AVu77A2DdJ2JIR3eYskobE0OBu39EcdiMgTFkPOaNH+1Ad23EXQLvOthuVLhOhQ9WX9K
 gH0g==
X-Gm-Message-State: ACrzQf1YH3zNQIOXWvafQQOZMq9Lk0KaS3SvFjCSeV7IoXF0nDLjv73Z
 HvGQKuRu5jkcBRRRoGQVxIrfHeIl1X4=
X-Google-Smtp-Source: AMsMyM6JNybUNUzD/vUq0EarydoT6B3m2qabYdj4UIVs//Gqqg0vRjjqh2E4AhZjSxtGU1TwgfPl7Q==
X-Received: by 2002:a05:6402:2546:b0:45d:8bff:7afc with SMTP id
 l6-20020a056402254600b0045d8bff7afcmr10442485edb.302.1666245597083; 
 Wed, 19 Oct 2022 22:59:57 -0700 (PDT)
Received: from [192.168.178.21] (p5b0eacfe.dip0.t-ipconnect.de.
 [91.14.172.254]) by smtp.gmail.com with ESMTPSA id
 b7-20020a1709064d4700b007824c5fe95esm9901498ejv.50.2022.10.19.22.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Oct 2022 22:59:56 -0700 (PDT)
Message-ID: <0b00c679-5c60-7324-40ad-1cbf8607666c@gmail.com>
Date: Thu, 20 Oct 2022 07:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: fix sdma doorbell init ordering on APUs
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221020034809.506525-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221020034809.506525-1-alexander.deucher@amd.com>
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
Cc: skhan@linuxfoundation.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.10.22 um 05:48 schrieb Alex Deucher:
> Commit 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
> uncovered a bug in amdgpu that required a reordering of the driver
> init sequence to avoid accessing a special register on the GPU
> before it was properly set up leading to an PCI AER error.  This
> reordering uncovered a different hw programming ordering dependency
> in some APUs where the SDMA doorbells need to be programmed before
> the GFX doorbells. To fix this, move the SDMA doorbell programming
> back into the soc15 common code, but use the actual doorbell range
> values directly rather than the values stored in the ring structure
> since those will not be initialized at this point.
>
> This is a partial revert, but with the doorbell assignment
> fixed so the proper doorbell index is set before it's used.
>
> Fixes: e3163bc8ffdfdb ("drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: skhan@linuxfoundation.org

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  5 -----
>   drivers/gpu/drm/amd/amdgpu/soc15.c     | 21 +++++++++++++++++++++
>   2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 298fa11702e7..1122bd4eae98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1417,11 +1417,6 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
>   		WREG32_SDMA(i, mmSDMA0_CNTL, temp);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
> -			ring = &adev->sdma.instance[i].ring;
> -			adev->nbio.funcs->sdma_doorbell_range(adev, i,
> -				ring->use_doorbell, ring->doorbell_index,
> -				adev->doorbell_index.sdma_doorbell_range);
> -
>   			/* unhalt engine */
>   			temp = RREG32_SDMA(i, mmSDMA0_F32_CNTL);
>   			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 183024d7c184..e3b2b6b4f1a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1211,6 +1211,20 @@ static int soc15_common_sw_fini(void *handle)
>   	return 0;
>   }
>   
> +static void soc15_sdma_doorbell_range_init(struct amdgpu_device *adev)
> +{
> +	int i;
> +
> +	/* sdma doorbell range is programed by hypervisor */
> +	if (!amdgpu_sriov_vf(adev)) {
> +		for (i = 0; i < adev->sdma.num_instances; i++) {
> +			adev->nbio.funcs->sdma_doorbell_range(adev, i,
> +				true, adev->doorbell_index.sdma_engine[i] << 1,
> +				adev->doorbell_index.sdma_doorbell_range);
> +		}
> +	}
> +}
> +
>   static int soc15_common_hw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1230,6 +1244,13 @@ static int soc15_common_hw_init(void *handle)
>   
>   	/* enable the doorbell aperture */
>   	soc15_enable_doorbell_aperture(adev, true);
> +	/* HW doorbell routing policy: doorbell writing not
> +	 * in SDMA/IH/MM/ACV range will be routed to CP. So
> +	 * we need to init SDMA doorbell range prior
> +	 * to CP ip block init and ring test.  IH already
> +	 * happens before CP.
> +	 */
> +	soc15_sdma_doorbell_range_init(adev);
>   
>   	return 0;
>   }


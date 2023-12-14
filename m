Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB41C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 10:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0C110E0BD;
	Thu, 14 Dec 2023 10:28:53 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041CF10E0BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 10:28:49 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so51100525e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702549727; x=1703154527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WS74u1YdM90ymuqPvvVgOyS833lPLTSZYme54xVkA7U=;
 b=MkHhOQeZko9VB1FRVCrZzSdb8beWhhnpdtLBoLgG+MSNHORIgkOCl0QAK6E9dj+TNU
 wWGB3/SDgxSw1y/S05dVLEpWfgOolj/XBVp0WtCp0emOmbT5rS/O9mepe3tyt9F8VwhS
 tWO8vphYc+C0LxKY2W7bKeumhxdJ9WqOpWSxIdVrbutQQLAm8snSpWC8AO7/GBTHojZM
 2+74Adii1+OQOxX0awZd/SQJ20HNLQGrL7Iu1dizyiTm8kNkQ3lKDWn1n0RkBXd3tE7K
 xLMRvfke0wQGcSo+efAOgM4rlfjzTxYOWeTIwpv9MhBMLkr+eH90An6YvRn8bffU/hkR
 WLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702549727; x=1703154527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WS74u1YdM90ymuqPvvVgOyS833lPLTSZYme54xVkA7U=;
 b=PXtPwcFo7D/gvR6k5Pz8PVnC/gVuvm8eWOGMBZNGgJMu6+xyujL0OJ7lROWPiSTDfR
 lp4VOSxKKLwge55RNZVK4WOpu6uMR4XharQaZigVgHEK1BvaX/XVQvMjEQg+kQelplUn
 4a+frtDYuhxiIAqqOVCUjdlEFCuildOkYXghOuSK9E/90Vr02FtHoYZfywger3bM+OOG
 Tp4rdYzFnSGrAT32MaKjEOaguwz+hYbvOKIlu4Z350vRWx/P+5Pkx+xIGTIVR9dCtRiK
 oisUrwlUbTKJe2kVcnXgXdFj0t3giYoz+sqNIDQ/FuBPx87q2a+8rUvbkQJ5VxXlP2IO
 I/7Q==
X-Gm-Message-State: AOJu0YzBOH5u/dABL5UiJXdVkfNoD0a+0cvh1BFu6+ymO0zh5WL72/T4
 5liJ0Px4Avdw4Yy9pqnoJ5f6mTZVBww=
X-Google-Smtp-Source: AGHT+IGpjNTqP78grQMH2esWNz5HtAtJeBqniKJY+bGKLx7I0iIiSGuMdU2ShuAoEsYjnTCqL8wZBw==
X-Received: by 2002:a05:600c:ac7:b0:40b:5e21:ec1e with SMTP id
 c7-20020a05600c0ac700b0040b5e21ec1emr4890414wmr.80.1702549727257; 
 Thu, 14 Dec 2023 02:28:47 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 he15-20020a05600c540f00b0040b5517ae31sm26287917wmb.6.2023.12.14.02.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 02:28:46 -0800 (PST)
Message-ID: <184fa52b-2546-4ab3-b11d-3b58e5562b32@gmail.com>
Date: Thu, 14 Dec 2023 11:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail
 to flush TLB
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231213203118.6428-1-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231213203118.6428-1-mario.limonciello@amd.com>
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
Cc: Tim Huang <Tim.Huang@amd.com>, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 13.12.23 um 21:31 schrieb Mario Limonciello:
> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
> causes the first MES packet after resume to fail. Typically this
> packet is used to flush the TLB when GART is enabled.
>
> This issue is fixed in newer firmware, but as OEMs may not roll this
> out to the field, introduce a workaround that will add an extra dummy
> read on resume that the result is discarded.
>
> Cc: stable@vger.kernel.org # 6.1+
> Cc: Tim Huang <Tim.Huang@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Add a dummy read callback instead and use that.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 19 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>   4 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 9ddbf1494326..cd5e1a027bdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -868,6 +868,25 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
>   	return r;
>   }
>   
> +void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev)
> +{
> +	struct mes_misc_op_input op_input = {
> +		.op = MES_MISC_OP_READ_REG,
> +		.read_reg.reg_offset = 0,
> +		.read_reg.buffer_addr = adev->mes.read_val_gpu_addr,
> +	};
> +
> +	if (!adev->mes.funcs->misc_op) {
> +		DRM_ERROR("mes misc op is not supported!\n");
> +		return;
> +	}
> +
> +	adev->mes.silent_errors = true;

I really think we should not have hacks like that.

Let's rather adjust the error message to note that updating the firmware 
might help.

Regards,
Christian.

> +	if (adev->mes.funcs->misc_op(&adev->mes, &op_input))
> +		DRM_DEBUG("failed to amdgpu_mes_reg_dummy_read\n");
> +	adev->mes.silent_errors = false;
> +}
> +
>   int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index a27b424ffe00..d208e60c1d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>   
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
> +
> +	bool				silent_errors;
>   };
>   
>   struct amdgpu_mes_process {
> @@ -356,6 +358,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
>   				  u64 gpu_addr, u64 seq);
>   
>   uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
> +void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev);
>   int amdgpu_mes_wreg(struct amdgpu_device *adev,
>   		    uint32_t reg, uint32_t val);
>   int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 23d7b548d13f..a2ba45f859ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -960,6 +960,17 @@ static int gmc_v11_0_resume(void *handle)
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +	case IP_VERSION(13, 0, 4):
> +	case IP_VERSION(13, 0, 11):
> +		/* avoid a lost packet @ first GFXOFF exit after resume */
> +		if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900 && adev->in_s0ix)
> +			amdgpu_mes_reg_dummy_read(adev);
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	r = gmc_v11_0_hw_init(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 4dfec56e1b7f..71df5cb65485 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>   		      timeout);
>   	if (r < 1) {
> -		DRM_ERROR("MES failed to response msg=%d\n",
> -			  x_pkt->header.opcode);
> +		if (mes->silent_errors)
> +			DRM_DEBUG("MES failed to response msg=%d\n",
> +				  x_pkt->header.opcode);
> +		else
> +			DRM_ERROR("MES failed to response msg=%d\n",
> +				  x_pkt->header.opcode);
>   
>   		while (halt_if_hws_hang)
>   			schedule();


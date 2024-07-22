Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8FBC3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 13:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36E58920D;
	Mon, 22 Jul 2024 13:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZ+b9Nsh";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18D58920D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 13:46:23 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso28660265e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721655982; x=1722260782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WWpQnC9TrFIYO0AUZ5AeJUSclLtAfX3dEtLCBmuvxyo=;
 b=FZ+b9NshzZsnyS2L2bSOxZhG/8qRlK1BItshUrqVgdDvXmjfEk6fYK3pWI6kNXvp4q
 DazkbA1Qnd8YPjiG4vyqwtum49ecwUcsPUJekCA5zuiPcJ3jmFlKrPo/zkobrWkLTbjQ
 d0xHUlzcrAUClZ1KOyW6/oDFDew/boeuJinUhmsbvKg2/lnJ1Iq8UuYj2A6YD9U/N7am
 DVW/WYmLvo3jQyK+xCm6hgir+CDgK0e9ysko1f8gMZB2OhTVngGIliRD3OINoXTsxdvn
 FOY1qsg0z6cmiZHwB8Sx80beSoAzRS/v82LTyIlMqtyuzvWJoSSth0I9jdBQVru/0SAR
 3F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721655982; x=1722260782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WWpQnC9TrFIYO0AUZ5AeJUSclLtAfX3dEtLCBmuvxyo=;
 b=aQQIMJYDqlbCrQOu/l8wekhudPHe88uGg12exQE+SJffvtVUJpWdNG4/+VtCOz92sm
 /DqLi79KiUW7RHFqy3a3+5eY8LJoCy4nVE5NS5tmsnndoJEVdytbEVa/g06sSsSs3y6F
 XZ7FmMZKR2otkf9criXe2VlEyMbxeZjQJQTaUwXhZNWwGq/+Q7/c/7M3uwHjeXJBhKKs
 zQgI1dv7MWE/gfBhjkyjkM+NgIoUJN+rSPb4VeGpnQCbA85r12g81i1gU6s3nBoo/hVY
 sDSIYfF6SIAm9HluKG71FfELgBj7eJpc2QILvL1w+O+HdnuErDL4VOAbSms/fewKIIvF
 rrPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA3CXf2iOS0+bYsmAW2OoPsUtzVrWtaXrGgHVdDZbGTyII/xGKi8jrGxn2RHfsK/VbeZlYrJ0HOPGGEyuNUJGLIr82WRwsERpm6oFyCQ==
X-Gm-Message-State: AOJu0YwZ1KHKCHP1IBFAEUJcqdjJ5O6l9zz1JrUKzB0Wc5Drdr105IE1
 SWv6M/4tkMwv9Xf6doT1Bijcy2HepebCIBtxmIcx5f+UcauNkYSg
X-Google-Smtp-Source: AGHT+IHKb1iGkf6B6r13CPYzcRkd0keB/T/8xGbSreIyp1inY9ZpYpuE4fufxx1O0182lvBx9Rye2A==
X-Received: by 2002:a05:600c:1914:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-427daa60cf1mr44558465e9.30.1721655981685; 
 Mon, 22 Jul 2024 06:46:21 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b7cesm8587029f8f.37.2024.07.22.06.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 06:46:21 -0700 (PDT)
Message-ID: <704734b0-f96a-432e-aa31-df296837ae31@gmail.com>
Date: Mon, 22 Jul 2024 15:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx10: properly handle error ints on all
 pipes
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240717203847.14600-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240717203847.14600-1-alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.07.24 um 22:38 schrieb Alex Deucher:
> Need to handle the interrupt enables for all pipes.
>
> v2: fix indexing (Jessie)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 130 +++++++++++++++++++++----
>   1 file changed, 109 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c4002db6e569..66d80f3dc661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5212,26 +5212,74 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
>   
>   }
>   
> +static u32 gfx_v10_0_get_cpg_int_cntl(struct amdgpu_device *adev,
> +				      int me, int pipe)
> +{
> +	if (me != 0)
> +		return 0;
> +
> +	switch (pipe) {
> +	case 0:
> +		return SOC15_REG_OFFSET(GC, 0, mmCP_INT_CNTL_RING0);
> +	case 1:
> +		return SOC15_REG_OFFSET(GC, 0, mmCP_INT_CNTL_RING1);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static u32 gfx_v10_0_get_cpc_int_cntl(struct amdgpu_device *adev,
> +				      int me, int pipe)
> +{
> +	/*
> +	 * amdgpu controls only the first MEC. That's why this function only
> +	 * handles the setting of interrupts for this specific MEC. All other
> +	 * pipes' interrupts are set by amdkfd.
> +	 */
> +	if (me != 1)
> +		return 0;
> +
> +	switch (pipe) {
> +	case 0:
> +		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
> +	case 1:
> +		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE1_INT_CNTL);
> +	case 2:
> +		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE2_INT_CNTL);
> +	case 3:
> +		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE3_INT_CNTL);
> +	default:
> +		return 0;
> +	}
> +}
> +
>   static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
>   					       bool enable)
>   {
> -	u32 tmp;
> +	u32 tmp, cp_int_cntl_reg;
> +	int i, j;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return;
>   
> -	tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
> -
> -	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
> -			    enable ? 1 : 0);
> -	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
> -			    enable ? 1 : 0);
> -	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
> -			    enable ? 1 : 0);
> -	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
> -			    enable ? 1 : 0);
> -
> -	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
> +	for (i = 0; i < adev->gfx.me.num_me; i++) {
> +		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +			cp_int_cntl_reg = gfx_v10_0_get_cpg_int_cntl(adev, i, j);
> +
> +			if (cp_int_cntl_reg) {
> +				tmp = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
> +				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
> +						    enable ? 1 : 0);
> +				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
> +						    enable ? 1 : 0);
> +				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
> +						    enable ? 1 : 0);
> +				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
> +						    enable ? 1 : 0);
> +				WREG32_SOC15_IP(GC, cp_int_cntl_reg, tmp);
> +			}
> +		}
> +	}
>   }
>   
>   static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
> @@ -9073,12 +9121,39 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>   					      unsigned int type,
>   					      enum amdgpu_interrupt_state state)
>   {
> +	u32 cp_int_cntl_reg, cp_int_cntl;
> +	int i, j;
> +
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
>   	case AMDGPU_IRQ_STATE_ENABLE:
> -		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
> -			       PRIV_REG_INT_ENABLE,
> -			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +		for (i = 0; i < adev->gfx.me.num_me; i++) {
> +			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +				cp_int_cntl_reg = gfx_v10_0_get_cpg_int_cntl(adev, i, j);
> +
> +				if (cp_int_cntl_reg) {
> +					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
> +					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
> +								    PRIV_REG_INT_ENABLE,
> +								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
> +				}
> +			}
> +		}
> +		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> +			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +				/* MECs start at 1 */
> +				cp_int_cntl_reg = gfx_v10_0_get_cpc_int_cntl(adev, i + 1, j);
> +
> +				if (cp_int_cntl_reg) {
> +					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
> +					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
> +								    PRIV_REG_INT_ENABLE,
> +								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
> +				}
> +			}
> +		}
>   		break;
>   	default:
>   		break;
> @@ -9092,12 +9167,25 @@ static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>   					       unsigned int type,
>   					       enum amdgpu_interrupt_state state)
>   {
> +	u32 cp_int_cntl_reg, cp_int_cntl;
> +	int i, j;
> +
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
>   	case AMDGPU_IRQ_STATE_ENABLE:
> -		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
> -			       PRIV_INSTR_INT_ENABLE,
> -			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +		for (i = 0; i < adev->gfx.me.num_me; i++) {
> +			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +				cp_int_cntl_reg = gfx_v10_0_get_cpg_int_cntl(adev, i, j);
> +
> +				if (cp_int_cntl_reg) {
> +					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
> +					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
> +								    PRIV_INSTR_INT_ENABLE,
> +								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
> +				}
> +			}
> +		}
>   		break;
>   	default:
>   		break;
> @@ -9121,8 +9209,8 @@ static void gfx_v10_0_handle_priv_fault(struct amdgpu_device *adev,
>   	case 0:
>   		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>   			ring = &adev->gfx.gfx_ring[i];
> -			/* we only enabled 1 gfx queue per pipe for now */
> -			if (ring->me == me_id && ring->pipe == pipe_id)
> +			if (ring->me == me_id && ring->pipe == pipe_id &&
> +			    ring->queue == queue_id)
>   				drm_sched_fault(&ring->sched);
>   		}
>   		break;


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A57FC54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 08:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F124A11295A;
	Tue,  5 Mar 2024 08:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RJU7lgnD";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C9811295A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 08:52:58 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5101cd91017so7495015e87.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Mar 2024 00:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709628776; x=1710233576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oMW905YwmTMhigZFn3zFSpQ/PV7eOCjgvPcobGAtauU=;
 b=RJU7lgnDcRFugkQLz4ZSWFcCtO3VcYeW2Cg4G/375iD4xu6cqdxwjYe0qassQjsW1T
 zfJo5Z6bnyRePZoVkTYzM2FUQfLvxt1pkiDa82EMf3Nc0vOCa6gbLX24GnV9Ysl0svmg
 lFiFd2wg9C5JOxCsQQVjucuwacgDuw9KE+4ZvnVP2bINWl9gpdiuJ5cQMuffUkF610GJ
 iYHQ3tSmU6L4tV2duwuozGG7XON2Eo9v2Cr8UbBlJ/iAjAzlkKS5Yy7xHGv7050SF1JE
 Pwxlvgtg7RBVlGGu/eLo3ZCSOe80/9gl4L9YAs4KccEjB18hjW+5U9yYNBWg2xdGZYo3
 d8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709628776; x=1710233576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oMW905YwmTMhigZFn3zFSpQ/PV7eOCjgvPcobGAtauU=;
 b=jgTYg6/ebTHJrViG0viEK1UwDwoMoPAO4R9FrU3wAHKa3wLq9p493rQtMPERmX8cCc
 uMxzt7sQuxlbNqlkEPXlNhwr/AjgjwFRordN4QxLbkfLMcOFxIAURTBeXWJfFgBgGyDN
 JzeVQvXOt2JYaty/qQYi2ZHGuVkIeorlvnVYONLhLYmOiYKws2RA+T7lufP926GiF7Rg
 NNtB14zRpuzyCA0dOXOtJ6L7uwuRrijWrWm3rhjb7Lt/nr4gyqqEFCdJvsPI8IjkzfMP
 shcxLWtcUi6uhqZ121R8/aUxWp4aonOL4viVV+sQXGqP6ZO5jiwZUrQPxNZTECDKeKrk
 D7IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrV+56H81q0y5TTlkui+dlcoTU63WaCr6n3wlwTkXWZFl4Un+Fis3sgOaWjkrwGIRXXcIp2mXS1mFywhFf3qlObUVW0tzl55Tg99VTDQ==
X-Gm-Message-State: AOJu0Yzwr3n5k7qvSp0me+5Dcp0AHR31sOubF3VwA5ZNtbXe2KAavERl
 EAw/Ddpjk76E9o5tx+I97+Oj+tGS84T3dzCBuHJdhzg2CF+zfz1k
X-Google-Smtp-Source: AGHT+IF0N9jKyl0ldtYRaXV8ju9siC+pJMSwejaFN0B6cqDmkCTBBzskI8g3hTp/yKZspq2E+VckWw==
X-Received: by 2002:ac2:5206:0:b0:513:1817:189e with SMTP id
 a6-20020ac25206000000b005131817189emr755205lfl.9.1709628775234; 
 Tue, 05 Mar 2024 00:52:55 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 r12-20020adfe68c000000b0033df5710fabsm14327881wrm.44.2024.03.05.00.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:52:54 -0800 (PST)
Message-ID: <ea7e75ed-0060-4c40-b43a-1baecadd4ef9@gmail.com>
Date: Tue, 5 Mar 2024 09:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add HDP flush to VCN v4.0.3
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, samir.dhume@amd.com,
 leo.liu@amd.com
References: <20240305064031.548905-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240305064031.548905-1-lijo.lazar@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.03.24 um 07:40 schrieb Lijo Lazar:
> VCN 4.0.3 cannot trigger HDP flush with RRMT enabled. Instead, trigger
> HDP flush from host side before ringing doorbell.

Well that won't work like that.

The HDP flush is supposed to be emitted into the ring buffer of the 
engine. If you just "emulate" it by a register write than that write 
comes at the wrong time.

This code here is seriously broken.

Regards,
Christian.

>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 810bbfccd6f2..7b5ad13b618e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -36,6 +36,7 @@
>   #include "vcn/vcn_4_0_3_offset.h"
>   #include "vcn/vcn_4_0_3_sh_mask.h"
>   #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
> +#include <uapi/linux/kfd_ioctl.h>
>   
>   #define mmUVD_DPG_LMA_CTL		regUVD_DPG_LMA_CTL
>   #define mmUVD_DPG_LMA_CTL_BASE_IDX	regUVD_DPG_LMA_CTL_BASE_IDX
> @@ -1380,6 +1381,26 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>   				    regUVD_RB_WPTR);
>   }
>   
> +static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> +{
> +	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
> +	 * This is a workaround to avoid any HDP flush through VCN ring. Instead
> +	 * HDP flush will be done by driver while submitting doorbell.
> +	 */
> +}
> +
> +static void vcn_v4_0_3_flush_hdp(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +#ifdef CONFIG_X86_64
> +	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
> +		return;
> +#endif
> +	if (ring->wptr)
> +		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> +}
> +
>   /**
>    * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
>    *
> @@ -1394,6 +1415,9 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>   	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
>   		DRM_ERROR("wrong ring id is identified in %s", __func__);
>   
> +	/* Flush HDP before ringing doorbell */
> +	vcn_v4_0_3_flush_hdp(ring);
> +
>   	if (ring->use_doorbell) {
>   		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
>   		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
> @@ -1420,6 +1444,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>   	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
>   	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
>   	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
> +	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>   	.test_ring = amdgpu_vcn_enc_ring_test_ring,
>   	.test_ib = amdgpu_vcn_unified_ring_test_ib,
>   	.insert_nop = amdgpu_ring_insert_nop,


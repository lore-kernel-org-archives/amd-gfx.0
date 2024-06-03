Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A24C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 18:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A784189A86;
	Mon,  3 Jun 2024 18:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQg6IZBb";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE19A89A86
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 18:09:08 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso66551731fa.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Jun 2024 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717438147; x=1718042947; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7RtkoTgGHv/tY1Yvmq6E1/Gukht1kWuUv9uWbeoJo34=;
 b=QQg6IZBbUC1ecg/Y0XU0u/EMZYfYyy3Ad+Tb1T5Mk9ER7PrXCAefshhFmhzaykum4E
 KyUBVxK2x0+RuQanhdidCKVVmVOxPxhMiyhQAm+OnCoFmFZnGv8+4CJuyRISd3kxYOk0
 B2FpUzJMlbdgdUfYThy/P+2N5TbHahWPujo+lw+gJQ1S7OKWoc9Ms5Rb5JP5ckbJ6g1e
 fki+qjMvBYrX76QipYSmS+HHrYUnW2patWyA9hyNJOvTZvA8LHcbwKeTZ5ATap2os5iL
 tabbHF+R3cdwlKqMH7TgUOhLMPMUgFp1DfC0BlPYYDdO4cpx2U8q4iBGkTgGVWbtxdL1
 Gh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717438147; x=1718042947;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7RtkoTgGHv/tY1Yvmq6E1/Gukht1kWuUv9uWbeoJo34=;
 b=WmeEqOUq/YO76KT2ecJG8YqKTsfAyUf65K2cyHT3qjYx06X2mDuLn1HCDy146/Ti4a
 05GwPAMstU1fEI+2UU/V2ZfdcO55vlthKKcehW2L96YU/C3rlLFZacy8HydAx/08Kmqv
 NzWbF0aMpIwYBfX96sp7pFPdhuln+OZxGMb+nOv9aPbFCUjUIGbTYeqyRmgNxjdTj1ZA
 h7+zkF6RZ8lOk1qETvhsXmZcHwwdRa+IaCw6xH+M6L9iWKf2Q4Yh3GzQLgCBuxRHpCVb
 dW2fN6MQB+Lc7+I5QEPVkD33icpb0RcHHiK4dwmEB96CLNk2DLhEGkZA4+Foo6/1suVx
 8MMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhcwtVzWjNwWUl076G5BW67E5I4o0N3bvYPCwag/W6FOk6LJi4bSDXA++D7NxW/vLJmk+zOkueMwmlShQi3rftQY6CuPzKc6tvSmwqXg==
X-Gm-Message-State: AOJu0YwAAj9fgDrodLlDAgi3UrO8t2re27YLs+sH8XpS7aJR7y3s5oy1
 ZkPDn+iE60RJC47DOgijQcloQy7TlVvo0G+0CpQJx1KyixsQAvzHYhmIy7O9
X-Google-Smtp-Source: AGHT+IH5fD8s7bCwxVa4eF4yevYlftqEdj6cy98EjNp/mu/JT1Gi1C4qFbYF2+Rg/4RihoqOAatVeQ==
X-Received: by 2002:a2e:9796:0:b0:2ea:7a0b:7935 with SMTP id
 38308e7fff4ca-2ea9515f4bcmr65176081fa.24.1717438146323; 
 Mon, 03 Jun 2024 11:09:06 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062edbcsm9403860f8f.84.2024.06.03.11.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 11:09:05 -0700 (PDT)
Message-ID: <29d354ec-2cbf-4249-8769-031e93183cb5@gmail.com>
Date: Mon, 3 Jun 2024 20:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use local xcc write to flush tlb
To: Yiqing Yao <YiQing.Yao@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 haijun.chang@amd.com, horace.chen@amd.com
References: <20240603114607.4143848-1-YiQing.Yao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240603114607.4143848-1-YiQing.Yao@amd.com>
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

Am 03.06.24 um 13:46 schrieb Yiqing Yao:
> When flushing gpu tlb using kiq from gfxhub, kiq ring is always
> local as xcc instance is selected for it. Thus using lower 18 bits
> to access mmregs inside local xcc instead of full address used
> when accessing regs outside of local xcc.
>
> Remove redundent code.
>
> Signed-off-by: Yiqing Yao <YiQing.Yao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 350f6b6676f1..864fea31c354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if (adev->gfx.kiq[inst].ring.sched.ready &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +		/* Select lower 18 bits to write in local xcc */
> +		if (vmhub < AMDGPU_MMHUB0(0))
> +			req = req & 0x3ffff;

A bit more explanation would be good here, e.g. what you have in the 
commit message.

Apart from that why do we need that in the first place? Isn't the KIQ 
able to access the register anyway?

Regards,
Christian.

>   
>   		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>   						 1 << vmid, inst);


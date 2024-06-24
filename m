Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A06C2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 09:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 168B510E3D7;
	Mon, 24 Jun 2024 09:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LvVD/ed6";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9228F10E3D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 09:31:28 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-363bd55bcc2so3335084f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719221487; x=1719826287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oi2v/mlFHjTPwPbvkXZZuqwM3fwTIMx6YuEedDtTKDg=;
 b=LvVD/ed6dCwUGctiogPZ53GNnJDkEnUyFPJF7CB+tjF5w3hKAmxFAhPGnjKRbvuntP
 IK+UhdPt+otrp9E7VaGUZtcS3rEanDlGUCk75NImTyZ8nF1udzP2dJNGx0+9+W/k3yC2
 GtA8Y7zpbh+Vifqnju/GRwT8JFsnLcIJASe7851hPFjiJ7EuAsbGNIyWu9QScS7GSQDs
 Y3JRUdwAiQsYJpGyr9/aKrJm2YvYUFo48WJIVnDbqjsPj/dh06xkpj2+TeQki9O9Igrd
 G88u9oNgymlS8bRIaodmdmw6LnAuU6Cf5NpH2e+gcgIywPZwwmdROAjIS4RHZ1T9hyhc
 YJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719221487; x=1719826287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi2v/mlFHjTPwPbvkXZZuqwM3fwTIMx6YuEedDtTKDg=;
 b=dvOU0+ktRKxHoJk42AGMkAdNnJbW1oi8Un5UIB39w/gdmmR0ASp6KwCvN75vBrzPFX
 gKcbj6RlFldg2eOu2akcQUpDUPROjNbJDmWt0KOKbQeL0tQ4GmzmFfLr6/j8pg+1uA8h
 GlgIKnYEaUGm39MhfurqsPMjpS+6RpkvWLhhY4qNcf5FSx3tqgzmHUvTYFgcsDBSu87C
 IGK7abxA2JLI9hU92BGjfyG2H4TF0cXgdGIs71KLdjiAZptEh0dZIUpvPTsGOs1+Tb2c
 OutdMfMo8NetA7sxeg9TBRKUS+Fgffpa1dFnttF/arTCCSc0cj3/f+j32E7ah6Vx8Na7
 hgng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG1pWu2OadFYPaMM2Wwfb3SmQfVcliRUlZyKDowALyeDFw2L59NAnHk/zFLklNYK7hxS3iqpWTVntV0YJ6Hy8zYenl3KjHR2rTeW1rug==
X-Gm-Message-State: AOJu0Yx1kOlAH/caegaHd+yP+jm8dlbivrAec7/wiRRWWruSLzp8g8Ya
 KSyVTRFYrAiVmOc8uq+StUqu4EF/gbgKPB+mKgVyO0yUf9yKh3H+
X-Google-Smtp-Source: AGHT+IFG46kFK5dUEUbuuCO+BuEwZTzxxYgfQXrJceb9zMySQ4HaACZK0AbVqTJctLLsPxhCbD1KXQ==
X-Received: by 2002:a05:6000:14a:b0:34d:ae98:4e7 with SMTP id
 ffacd0b85a97d-366e94db5ffmr2492202f8f.41.1719221486370; 
 Mon, 24 Jun 2024 02:31:26 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101a955sm177046925e9.0.2024.06.24.02.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 02:31:25 -0700 (PDT)
Message-ID: <29f9f8f1-5fb0-43d1-89f4-744682e852fd@gmail.com>
Date: Mon, 24 Jun 2024 11:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit if detected when
 enabling interrupts
To: Danijel Slivka <danijel.slivka@amd.com>, amd-gfx@lists.freedesktop.org,
 nikola.prica@amd.com
References: <20240624065854.17711-1-danijel.slivka@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240624065854.17711-1-danijel.slivka@amd.com>
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

Am 24.06.24 um 08:58 schrieb Danijel Slivka:
> Why:
> Setting IH_RB_WPTR register to 0 will not clear the RB_OVERFLOW bit
> if RB_ENABLE is not set.
>
> How to fix:
> Set WPTR_OVERFLOW_CLEAR bit after RB_ENABLE bit is set.
> The RB_ENABLE bit is required to be set, together with
> WPTR_OVERFLOW_ENABLE bit so that setting WPTR_OVERFLOW_CLEAR bit
> would clear the RB_OVERFLOW.
>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 3cb64c8f7175..44872a8ce6a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -135,6 +135,29 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
>   
>   	tmp = RREG32(ih_regs->ih_rb_cntl);
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
> +
> +	if (enable && REG_GET_FIELD(RREG32_NO_KIQ(ih_regs->ih_rb_wptr), IH_RB_WPTR, RB_OVERFLOW)) {

Please completely drop that extra read of the WPTR and just always try 
to clear the overflow bit.

> +		/* Clear RB_OVERFLOW bit if detected */
> +		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);

I think we should have a sequence which writes 0, then 1 and then 0 again.

Apart from that looks good to me.

Regards,
Christian.

> +		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
> +				return -ETIMEDOUT;
> +		} else {
> +			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +		}
> +
> +		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +		 * can be detected.
> +		 */
> +		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
> +				return -ETIMEDOUT;
> +		} else {
> +			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +		}
> +	}
> +
>   	/* enable_intr field is only valid in ring0 */
>   	if (ih == &adev->irq.ih)
>   		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));


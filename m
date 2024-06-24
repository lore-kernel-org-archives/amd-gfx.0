Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66187C2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 11:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E62810E40E;
	Mon, 24 Jun 2024 11:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PSooKfEY";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CD610E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 11:54:43 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-366de090da9so1609585f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719230082; x=1719834882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pMUBqk3UvnJ7R3kK++HYhtQRYgY0xU45PUP1uIs59GQ=;
 b=PSooKfEY1I63pSuSrPCB3oUnWlHpsdeqoCXCmt3QM+SOo/D2uBqUYegy5m1/wNDmEM
 3Hf1DC5G+nJUCH0qvD4oGPXFm+Y5Ml1Xl2Hr3V4ofNSxcr0vEjA1tyL/P0mV/JuE1jEM
 O3SldIozo0iZTrvtQXH2vOQTWGPIn1HVM66IsWAVRcUJJmzZQBryBHhwb/uLy8ObJH84
 LmkkD3whd+9hydET1SElAwW3n9hAfQ35/47rqeLoOSkukUV5dtw4p4f66d0PxtlOWvvw
 JSYiJLpcaTxattWFlIIOhNwu4W0c8FXWR4PmPG49padfrF049mzJMgRboh8D8ut4KSqZ
 +wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719230082; x=1719834882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pMUBqk3UvnJ7R3kK++HYhtQRYgY0xU45PUP1uIs59GQ=;
 b=KmBJI0U++abfLoO1SwyUXjeZAqe3JcZQ+sfmMjfCTc4md4JJNeTk0WgjBVj+4U5jqG
 MOtEzSk2hdLKba2CmoXcXM6Takwlv3g21KyBbK3tpiEulHeJzN2b4Gbc7zdkQpkkyEsW
 mjTNVTGZIGfjLEmqV68Zz4zerN5FKxkAl1W75NfvRQ7lsBkL4K3cIknNecWo8anGNDc9
 tz/Iva2JBvd3UlrpcI0m78C9Rm06TFF7HdUgEwsNHrHT2PXxbzmI+t8mG1AMuzD+9Jer
 BCt4W+YqmcDK6fDE5sF+mAmTY1ryX9RDdy964r8x5I9LjXTtLn3jTBTAAO8aVtgeROM3
 4/Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDYRh7PnQOuqcTfreOHgQyA4LSe+YIJiHdyMk8N3ZYNfJWsoSs4CPBQwIrXJNi9TF4I8Apu8NEEgqbAXd2e6+apUoO/GeiKl9wb9qPCg==
X-Gm-Message-State: AOJu0Yyf52XSsEYQqFG5Gses2fkxamB/igEu8Dr4QgDeM5Nf4RDoqyeW
 7EmCy4BwniLlHRtQHczd01J7yLbbmMqZLEdzamtjHzU2oH7t3/1+ZNKaqw==
X-Google-Smtp-Source: AGHT+IHU8FaNitFU3lcC5mtAt8noPF0TUE1mMHl1ldMVY+HWALqjulU4ee+JgnWCQlwQkPgn4ab69g==
X-Received: by 2002:adf:e646:0:b0:364:8e3f:89f8 with SMTP id
 ffacd0b85a97d-366e96307b9mr2623541f8f.67.1719230081737; 
 Mon, 24 Jun 2024 04:54:41 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f675esm9862291f8f.22.2024.06.24.04.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 04:54:41 -0700 (PDT)
Message-ID: <143bb050-b698-4673-b280-b07bdb97aa44@gmail.com>
Date: Mon, 24 Jun 2024 13:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts
To: Danijel Slivka <danijel.slivka@amd.com>, amd-gfx@lists.freedesktop.org,
 nikola.prica@amd.com
References: <20240624100649.14971-1-danijel.slivka@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240624100649.14971-1-danijel.slivka@amd.com>
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

Am 24.06.24 um 12:06 schrieb Danijel Slivka:
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
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 34 ++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 3cb64c8f7175..cbc70016f479 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -135,6 +135,40 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
>   
>   	tmp = RREG32(ih_regs->ih_rb_cntl);
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
> +
> +	if (enable) {
> +		/* Unset the CLEAR_OVERFLOW bit to make sure the next step
> +		 * is switching the bit from 0 to 1
> +		 */
> +		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
> +				return -ETIMEDOUT;
> +		} else {
> +			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +		}
> +
> +		/* Clear RB_OVERFLOW bit */
> +		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
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

The last write can be merged with the one below to eventually enable the 
interrupt. So this chunk here can be dropped.

With that fixed feel free to add Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> +	}
> +
>   	/* enable_intr field is only valid in ring0 */
>   	if (ih == &adev->irq.ih)
>   		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));


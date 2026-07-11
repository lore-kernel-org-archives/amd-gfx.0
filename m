Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555E9C44509
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FCA10E4BE;
	Sun, 12 Jul 2026 15:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oPesYcM1";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0BC10E30D
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 08:41:36 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so1098679f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783759295; x=1784364095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V6EtDjfFX/wsIJgz4N5ldSWx9PPXT0Y4/MdltpptGMY=;
 b=oPesYcM1lVepzQkHkf2zmdJcCIxkP5cyHr6PLmOFZRG0yTxTe9y37eMLbGRBOjOUPE
 m7NeFWjIsQnEHFEEGA0xBS7VJL3hxw7LLyaF51gPWm4iSj7d7XEuYf1VY4kfzSzrAG7a
 adCBkFp99XjkaujRe53SCrwuph/zBQfYfrcqAF7klqEj8vtwqjVDyhcfMPRCz/Sm5vAg
 a0BYyv1Bc+DrZKO1gv/lWat7YKMjdMb7OAYsOLvMt8F5B1z3ENGV4sHeMsVfSR2jZ8EZ
 TrmbP8A066cZImcd8F8MD3pQeV2CgYj/Z0fg6OvRNE20HlEP8jrXspkMANjS0zZHzuOS
 wjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783759295; x=1784364095;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V6EtDjfFX/wsIJgz4N5ldSWx9PPXT0Y4/MdltpptGMY=;
 b=GUUQ9x9Oj/6MVcSEFImJT8lyhAWB+fjNqqzFSnhnmr2Y/FByExDnWxfVI58Z2/v78/
 JxhxkyJ4TRyzc3+ZYQ/xNgdHMXyXX9djYiRUfLOkJCDItl1i5rm593KbCW4qnZ36QcW4
 44csSMlR8C71KT+eWEl/8EUsMjRT7k+xbQ9jTUfAroNjtc0H6eagsPtfuDognfDAH9p2
 WPYxGWbowqmYmmjA6nc1Z8A/Apo9i0Vk5+ZqyjFyr26bAGWIz3C1aCn2xqUA/cbNxD9X
 9CXeLpoCdUzVlUIFrnpxOUsQdy61ttMJn+yQS5J2DpwbliLtaB6T7PZqlFFC2NuQn5Ls
 IYQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVfB+QdXMHWy0JESPJZIhX5/c0oZMqvxqWth43ZpKil7NIDCCgnVvSAhj0cCnggVKLucox2h8d@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGeKuSco8OgJmu0o21g9zRnS0xX/HOoOCk8PHaxGLZ9tmeZhxT
 5vnNzt1V19AZ1IQOwMCsAdTATx9OAnWCFYvc6IqmGl/TTRZs0957rz62
X-Gm-Gg: AfdE7cnwRRfUSYSahPYATmBI2tz8mp3mMF3Gls1PgsJ8GA5smpcdW+Eod3TbiTl3C7r
 GSDADZelnuE2VQLH3ADa9bPL8EFp+mDf7uhjTKXHVYYLIuVhe3Ein1UkpQ2AXNYBXs/HQXE5Szu
 0eJMa8nTMSGCq4GzyIKzY0FqwcGouO8KWTxC2QCTjThnpTe8U6xxQ/PthVQowVjExmo4Q7zX5Zk
 xtjAcld9fHO/vImUNrSDrVdx0FmRgJx/hCRa+mCTuQ9AZBg+oKZ48oT9ixT+Woi9t1uRDG4+Cme
 o4ympP2ciUs27OxRRjEKeHvxIwGDX/oUD3XxSO7M6T5KWZqn/WKCBk+PwKwSDkCsTDawm/9D8fZ
 89iOuzaJuMSKoavPihFSS91G6xVJSi9MuSqBYDw6AGQZn7ZeRBcn6vQGV+Pj90eaCl0/qt7rsMa
 OaJYXy1Iki1FPsX6hVqNNh+V/eLSP96DfZmqX6VJ0zVkLHyXuLkZ7e3TgGuPX7cJEzbuM=
X-Received: by 2002:a05:6000:250d:b0:47f:28d6:27ab with SMTP id
 ffacd0b85a97d-47f2dc8d72cmr2097181f8f.8.1783759295139; 
 Sat, 11 Jul 2026 01:41:35 -0700 (PDT)
Received: from ?IPV6:2a06:4944:10fb:f400:509b:3e86:dfb4:f404?
 ([2a06:4944:10fb:f400:509b:3e86:dfb4:f404])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm63435639f8f.10.2026.07.11.01.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 01:41:34 -0700 (PDT)
Message-ID: <180318e7-0432-403a-b87b-6f9a455bb86a@gmail.com>
Date: Sat, 11 Jul 2026 10:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/radeon: fix internal display on iMac11,1
 (RV770/DCE3.1)
To: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <CADnq5_Os2Bk8Dd9d8m_CkK9nYSporzUqbiRA=YD85nRBB6XjMw@mail.gmail.com>
 <20260601211931.2837-2-gilles.risch@gmail.com>
Content-Language: en-US
From: Gilles Risch <gilles.risch@gmail.com>
In-Reply-To: <20260601211931.2837-2-gilles.risch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 12 Jul 2026 15:22:44 +0000
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

Hello,

gentle ping on this v5 patch — is there anything else needed to get this 
merged?

Regards,
Gilles


On 01.06.26 23:19, Gilles Risch wrote:
> The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> DisplayPort path. Without this fix the display stays dark under KMS.
>
> This machine suffers from the same issue as iMac10,1 and iMac11,2:
> Apple routes the internal display through Link B of the DIG encoder
> instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> the Apple-specific encoder assignment into its own block, independent
> of the DCE version check.
>
> Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
> and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
> to avoid affecting other boards.
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> ---
>   drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
>   drivers/gpu/drm/radeon/atombios_encoders.c | 23 ++++++++++++----------
>   2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
> index 2fc0334e0..075eba2d4 100644
> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> @@ -24,6 +24,8 @@
>    *          Alex Deucher
>    */
>   
> +#include <linux/dmi.h>
> +
>   #include <drm/drm_fixed.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
> @@ -594,7 +596,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
>   		if (((rdev->family == CHIP_RS780) || (rdev->family == CHIP_RS880))
>   		    && !radeon_crtc->ss_enabled)
>   			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
> -		if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
> +		if ((ASIC_IS_DCE32(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
> +		    && mode->clock > 165000)
>   			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
>   	} else {
>   		radeon_crtc->pll_flags |= RADEON_PLL_LEGACY;
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
> index 5cfd8fcfa..8b3f8303a 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
>   		if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connector) {
>   			/* DP_SET_POWER_D0 is set in radeon_dp_link_train */
>   			radeon_dp_link_train(encoder, connector);
> -			if (ASIC_IS_DCE4(rdev))
> +			if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
>   				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0);
>   		}
>   		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
> @@ -2123,17 +2123,20 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
>   	}
>   
>   	/*
> -	 * On DCE32 any encoder can drive any block so usually just use crtc id,
> -	 * but Apple thinks different at least on iMac10,1 and iMac11,2, so there use linkb,
> -	 * otherwise the internal eDP panel will stay dark.
> +	 * Apple routes the internal eDP panel through Link B of the DIG encoder
> +	 * instead of Link A on the iMac10,1, iMac11,1 and iMac11,2.
> +	 * Use linkb to avoid a dark display.
>   	 */
> -	if (ASIC_IS_DCE32(rdev)) {
> -		if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> -		    dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
> -			enc_idx = (dig->linkb) ? 1 : 0;
> -		else
> -			enc_idx = radeon_crtc->crtc_id;
> +	if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> +	    dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
> +	    dmi_match(DMI_PRODUCT_NAME, "iMac11,2")) {
> +		enc_idx = (dig->linkb) ? 1 : 0;
> +		goto assigned;
> +	}
>   
> +	/* on DCE32 and encoder can driver any block so just crtc id */
> +	if (ASIC_IS_DCE32(rdev)) {
> +		enc_idx = radeon_crtc->crtc_id;
>   		goto assigned;
>   	}
>   



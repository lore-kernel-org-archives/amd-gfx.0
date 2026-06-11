Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14D5CD98DE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 07:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C242010F2D5;
	Fri, 12 Jun 2026 07:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="mz0U/R6Q";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B9810F112
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 19:53:02 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-59c2a81ca92so105385e0c.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207581; x=1781812381; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kl0PihJjT2cGJtkbSlUyWrO5HuupFJs+Hgir6NLMdyg=;
 b=mz0U/R6QsmJyDkXm5SebXiP/jKGLfSeq0jNVEgt7u6dbAPpmk+O8884lwCKACO+5Ak
 P3tZnRMN+Wx/xmhHVBi4sNNvdpvACodEWXj8o2h5UEITK8axBQlR2m6PBSUZv/fND2Vh
 DRmWQdEspec/3hWUp1hxANfrY3Nd61UQcRXXLYWmrtqy6yrDgmK6IbYF/YRLb7lEuxql
 3izx8CJSXzyW4nM5J1xy6j79hvnq+DrRSObu29B73ku0m8qV0mRR5qJgtVMJtLQYFzRi
 uMvgXpV5l6FlwPnkT1ND2GdJYyePacvcJ6G6c+cowESq53d6ZkBpkG9GOPH1I9YNpTg5
 mwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207581; x=1781812381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kl0PihJjT2cGJtkbSlUyWrO5HuupFJs+Hgir6NLMdyg=;
 b=DLoknOF5RnCazaNgJFw75ejjakWd8AJk/YjUAluIN83Fxje/8Y9hQi9lOYpQRO43Co
 btiZWbPsow2ZU5+lbVRjMEV+IwZnGCYIx5vxAl/1B2FATHwpD6bQi+NmelqD/t+apzrt
 UWRPOAyx+X8D7JbtvvA4FQt2+mtewpHs1oBSa/TL9x4lvyKsdc/oCzOkvzqhIc02ha0+
 r1/fRNYG1RGXktciCtq+pBaPPWbU8SWi29sw8Tlt3qAzwznLVgw33r/7bwuhaaR9FU0S
 zwnHertfjZYUIKhToTmDCB/988QwFN3Tc6sPhjxz9lh2XkjKSu1SPuA2nPnMUC+uajdT
 5BZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D8lodyzeH0e+vaMj4gSq9l77Ii7Av3DqhVhvsby9Naq0yRwLko5nZXzcBwdE6X8Or11XetAJr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3f3D2OYsujax6LHX5fJHZL3oiv/FTvcJ/6JMbKlZmgW90hfkp
 Ha+TBe++4dkRGsst9D3DkaLxFNpzxGqhqkJT5JlNHWzZUMN3I2grvz5ohFvJQ1fQfCs=
X-Gm-Gg: Acq92OETOyMe+P4N5gB6dPGu6iA7vMUdXQ49BG+zcg88D9OwABGDlUQev0ymhzLLOds
 Y0sDhjO7cfhJjyco+vV0N9bCeutqNegWXsu9PpeGpkAq/SPM021HTjsAiUG9Opz8ZW9uFmQvZ+H
 UsMwSeyppTOSF/+i6GGc++NltLqkK17QnloJERy03tlItgxlLLaQ7rheF5mpDh25PpsszkAKuFt
 +JQmVoNg9WnHAzjSd3xtvyvRd+QmxCjWmOuuEalvPR9x4LNc+V4l2DM2vCy34kmALJUe5AA0BD2
 jwsXbPdKz9VDWdidPL9HdfNTNR0/1IOcBKyFFY+SyGCHztV3asBUTukN92PLL1ayDSBPyD0uiHO
 ItN/yvdyGx+4vxAtqys0Q+n9Loj4HH59/fVilXv4Ej4GqnYpLRQv4x/b9eMT28RuHBdT0jwMv9w
 czv3hUXov/zrWO7aryLe7hByL3drQjULABkHnGHwfxgdGT4nfNTaFZQi4cOopqYZ+Z6nZdNOh4F
 wMQp9oBwRiL3So3JwrTTnP5lT3y4Vf4W6SIxvbcyWD5EdVYBQ==
X-Received: by 2002:a05:6122:310e:b0:5a4:6b77:2da9 with SMTP id
 71dfb90a1353d-5bb0165dcdemr3088421e0c.11.1781207581013; 
 Thu, 11 Jun 2026 12:53:01 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:53:00 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 8/9] drm/amd/display: convert dcn401 GPIO translation
 to lookup tables
Date: Thu, 11 Jun 2026 16:49:08 -0300
Message-ID: <20260611195026.25125-9-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611195026.25125-1-guilherme.bozi@usp.br>
References: <20260611195026.25125-1-guilherme.bozi@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 07:46:58 +0000
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

Replace dcn401 GPIO translation switch statements with the
generic table-based translation helpers.

This simplifies the GPIO mapping logic and reduces duplicated
translation code.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 ++++++------------
 1 file changed, 137 insertions(+), 255 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_translate_dcn401.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_translate_dcn401.c
index ea416f01f888..7aa97f09955c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_translate_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_translate_dcn401.c
@@ -35,119 +35,145 @@
  * end *********************/
 
 
+static const struct gpio_id_offset_entry gpio_offsets[] = {
+	/* GENERIC */
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_A),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_B),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_C),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_D),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_E),
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_F),
+	/* HPD */
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_1),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_2),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_3),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_4),
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_5),
+	/* GSL */
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_GENLOCK_CLOCK),
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_GENLOCK_VSYNC),
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_A),
+	GPIO_MASK_ENTRY(DC_GPIO_GENLK_A,
+		DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK,
+		GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_B),
+};
+
+
+/* DDC */
+static const struct gpio_ddc_offset_entry ddc_offset_map[] = {
+	{ REG(DC_GPIO_DDC1_A), GPIO_DDC_LINE_DDC1 },
+	{ REG(DC_GPIO_DDC2_A), GPIO_DDC_LINE_DDC2 },
+	{ REG(DC_GPIO_DDC3_A), GPIO_DDC_LINE_DDC3 },
+	{ REG(DC_GPIO_DDC4_A), GPIO_DDC_LINE_DDC4 },
+	{ REG(DC_GPIO_DDCVGA_A), GPIO_DDC_LINE_DDC_VGA },
+};
+
+
+/*
+ * GSL is intentionally omitted here.
+ * id_to_offset() for GSL is not implemented on this ASIC.
+ */
+static const struct gpio_pin_entry gpio_pins[] = {
+	/* DDC */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	/* GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK), */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	/* GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK), */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	/* GENERIC */
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_B,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_C,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_D,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_E,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_F,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK),
+	/* HPD */
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_1,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_2,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_3,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_4,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_5,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK),
+};
+
+
 static bool offset_to_id(
 	uint32_t offset,
 	uint32_t mask,
 	enum gpio_id *id,
 	uint32_t *en)
 {
-	switch (offset) {
-	/* GENERIC */
-	case REG(DC_GPIO_GENERIC_A):
-		*id = GPIO_ID_GENERIC;
-		switch (mask) {
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK:
-			*en = GPIO_GENERIC_A;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK:
-			*en = GPIO_GENERIC_B;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK:
-			*en = GPIO_GENERIC_C;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK:
-			*en = GPIO_GENERIC_D;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK:
-			*en = GPIO_GENERIC_E;
-			return true;
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK:
-			*en = GPIO_GENERIC_F;
-			return true;
-		default:
-			ASSERT_CRITICAL(false);
-			return false;
-		}
-	break;
-	/* HPD */
-	case REG(DC_GPIO_HPD_A):
-		*id = GPIO_ID_HPD;
-		switch (mask) {
-		case DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK:
-			*en = GPIO_HPD_1;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK:
-			*en = GPIO_HPD_2;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK:
-			*en = GPIO_HPD_3;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK:
-			*en = GPIO_HPD_4;
-			return true;
-		case DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK:
-			*en = GPIO_HPD_5;
-			return true;
-		default:
-			ASSERT_CRITICAL(false);
-			return false;
-		}
-	break;
-	/* REG(DC_GPIO_GENLK_MASK */
-	case REG(DC_GPIO_GENLK_A):
-		*id = GPIO_ID_GSL;
-		switch (mask) {
-		case DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK:
-			*en = GPIO_GSL_GENLOCK_CLOCK;
-			return true;
-		case DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK:
-			*en = GPIO_GSL_GENLOCK_VSYNC;
-			return true;
-		case DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK:
-			*en = GPIO_GSL_SWAPLOCK_A;
-			return true;
-		case DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK:
-			*en = GPIO_GSL_SWAPLOCK_B;
-			return true;
-		default:
-			ASSERT_CRITICAL(false);
-			return false;
-		}
-	break;
-	/* DDC */
-	/* we don't care about the GPIO_ID for DDC
-	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
-	 * directly in the create method
-	 */
-	case REG(DC_GPIO_DDC1_A):
-		*en = GPIO_DDC_LINE_DDC1;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(DC_GPIO_DDC2_A):
-		*en = GPIO_DDC_LINE_DDC2;
-		return true;
-	case REG(DC_GPIO_DDC3_A):
-		*en = GPIO_DDC_LINE_DDC3;
-		return true;
-	case REG(DC_GPIO_DDC4_A):
-		*en = GPIO_DDC_LINE_DDC4;
-		return true;
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
 		return true;
 
-/*
- *	case REG(DC_GPIO_I2CPAD_A): not exit
- *	case REG(DC_GPIO_PWRSEQ_A):
- *	case REG(DC_GPIO_PAD_STRENGTH_1):
- *	case REG(DC_GPIO_PAD_STRENGTH_2):
- *	case REG(DC_GPIO_DEBUG):
- */
-	/* UNEXPECTED */
-	default:
-/*	case REG(DC_GPIO_SYNCA_A): not exist */
-		ASSERT_CRITICAL(false);
-		return false;
-	}
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 
@@ -156,158 +182,14 @@ static bool id_to_offset(
 	uint32_t en,
 	struct gpio_pin_info *info)
 {
-	bool result = true;
-
-	switch (id) {
-	case GPIO_ID_DDC_DATA:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-/*		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break; */
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_DDC_CLOCK:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-/*		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break; */
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_GENERIC:
-		info->offset = REG(DC_GPIO_GENERIC_A);
-		switch (en) {
-		case GPIO_GENERIC_A:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK;
-		break;
-		case GPIO_GENERIC_B:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK;
-		break;
-		case GPIO_GENERIC_C:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK;
-		break;
-		case GPIO_GENERIC_D:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK;
-		break;
-		case GPIO_GENERIC_E:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK;
-		break;
-		case GPIO_GENERIC_F:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK;
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_HPD:
-		info->offset = REG(DC_GPIO_HPD_A);
-		switch (en) {
-		case GPIO_HPD_1:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK;
-		break;
-		case GPIO_HPD_2:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK;
-		break;
-		case GPIO_HPD_3:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK;
-		break;
-		case GPIO_HPD_4:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK;
-		break;
-		case GPIO_HPD_5:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK;
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_GSL:
-		switch (en) {
-		case GPIO_GSL_GENLOCK_CLOCK:
-				/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-		break;
-		case GPIO_GSL_GENLOCK_VSYNC:
-			/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-		break;
-		case GPIO_GSL_SWAPLOCK_A:
-			/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-		break;
-		case GPIO_GSL_SWAPLOCK_B:
-			/*not implmented*/
-			ASSERT_CRITICAL(false);
-			result = false;
-
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_SYNC:
-	case GPIO_ID_VIP_PAD:
-	default:
-		ASSERT_CRITICAL(false);
-		result = false;
-	}
-
-	if (result) {
-		info->offset_y = info->offset + 2;
-		info->offset_en = info->offset + 1;
-		info->offset_mask = info->offset - 1;
-
-		info->mask_y = info->mask;
-		info->mask_en = info->mask;
-		info->mask_mask = info->mask;
-	}
+	if (dal_hw_translate_id_to_offset(
+			gpio_pins,
+			ARRAY_SIZE(gpio_pins),
+			id, en, info))
+		return true;
 
-	return result;
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 
-- 
2.47.3


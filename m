Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5225CD4F3E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 07:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07C010ED28;
	Wed, 13 May 2026 07:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="OHYwsdlb";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D659410EBF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:01:37 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so10267332eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778612497; x=1779217297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jof1WXBiQIpUZP0H5xbzYx8qG5/LRvX0Y48UC2BrLSI=;
 b=OHYwsdlb1DXHmmUfiR3aqQmVVRGU5kr8VRhGaaxV/rhNclrQVFH0Fbz2YFFOjiQXvF
 5rLMVq778imdkQs1FJVSgug9q8AQJdsAYgG0lCrA18DHaevVX1pLOsfmWZxGThBF5X2q
 +Y5s7KEsCL5Oc23t35YelGj1V8F8G7nzLrflgunD3hGA8qThrM8CfnxebihMw241l+r2
 x/XkvupJSfLGW/5SnXL5NnwTlEnUDnapN/rsbH5J6pdFxfF0UFpctBWRcQYE6lemwlyW
 G+Fp1BBhdrImZPZqT14NA7yAfEdE+HE+r5SkY9gpf2EzlG2C3OWGEdZ/IYYlTKdsxDLQ
 3kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612497; x=1779217297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jof1WXBiQIpUZP0H5xbzYx8qG5/LRvX0Y48UC2BrLSI=;
 b=qhJAgAA2ysl8lClByxaRrB4gZZktpRB2XD5AgdldNin9WmgDXPRr6AlXjpUFOpJrGE
 4RdKY7aHjrBmAsdsU+gX2D6ATay0P/QFmZPxQ1Yw77DGoKKw0Q9OeSaf9nOsdSQsr+bO
 xZc5MUW+tzOJpN8NzSKp6pkJ1wsz+lVIstRIlUzxt42UBC1C9O42k0txWXjthIsYCE5a
 Hr7Q9dNJUVepFWN+zrxyy4K3ldVSwvL0sGHkIXKz3Knq5mcFvwi/vLGPyRoWd10hyNqe
 RYEASHJmK1VS4xfdPN60X6+rRHS7LdgM8PbaLiy8s+qQA29Pkn2HM5o8Xg03MSGi52oC
 vkCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xfx31d4pHAZL19fLxIQR9t1m87EszpUoFNQvmZicLOeO8kvJrZV5gwlmuklLsOyo0a97C9PTx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLZfaIAKcnqav/wgJiMR576OAVDTWXbRKUeDZHjquh9fCq1eXp
 QIEzMU2iA6mJG+vBKXdrmwOzJpS5wItrCEDKT31P2ktJC1lVEgVweIVCYamqDMRfcYg=
X-Gm-Gg: Acq92OEWD5YfxB/DW3EMoaD9uiPG+jCCouYQo8UhnVYd/DsL+ZfFkaVJ12m1vqIL/Uf
 BUcxWa/PX6UzkaL8z0k0Lg6m0l+fEeh3EkbMsCOLSEYMh3G7EjEWIsUNoqkFbX3l8aLC9sGvoGa
 mg690FPVqWqZbvKRYyOVUT0PP1br1tLev2D6l88oN+/Cpc8qjSHw2t+pPD+MixbCGu+10Ia1uJN
 9ZwbEVUljchYi74KHM3Y7xdaADEywBWGjRpZyxNdRpSuTPE996PS8lvoQbM9rwFbwgJYiAEY9m1
 2ACWqS4gC68ZBrltBizzkdWHvJCt9OTNiEgWKXBoLZh4R5quupq/ayKlmp1eVI/lWBA16WSGERY
 tj8ozID9vWpcpiRATcuOyHD62tY17cWVnErNjf6VEaLWphjXQRgwjuS9ce2Q2B/R8fy9vzF2Xrc
 O3213H/3aX4/2Zz7/zy/ufRkwgb6CScnPMdZIVn19l37oYy91uB75+EcJFK5ndpBsI5Xb40wd+c
 AmpF3Wh0ramvjYocnR5PeBzAgP8Z1hHLqFT0y2DsTF9h+QZ
X-Received: by 2002:a05:7301:688c:b0:2f2:8857:180a with SMTP id
 5a478bee46e88-301187b5512mr172242eec.7.1778612496861; 
 Tue, 12 May 2026 12:01:36 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88914523csm18716616eec.29.2026.05.12.12.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:01:35 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amd/display: convert dcn315 GPIO translation to
 lookup tables
Date: Tue, 12 May 2026 15:59:49 -0300
Message-ID: <20260512190019.228440-7-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512190019.228440-1-guilherme.bozi@usp.br>
References: <20260512190019.228440-1-guilherme.bozi@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:56:32 +0000
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

Replace dcn315 GPIO translation switch statements with the
generic table-based translation helpers.

This simplifies the GPIO mapping logic and reduces duplicated
translation code.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 +++++++-----------
 1 file changed, 148 insertions(+), 270 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c
index fbdaba57f718..aa507f7f4ef9 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c
@@ -62,128 +62,156 @@
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
+	GPIO_MASK_ENTRY(DC_GPIO_GENERIC_A,
+		DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK,
+		GPIO_ID_GENERIC, GPIO_GENERIC_G),
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
+	GPIO_MASK_ENTRY(DC_GPIO_HPD_A,
+		DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK,
+		GPIO_ID_HPD, GPIO_HPD_6),
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
+	{ REG(DC_GPIO_DDC5_A), GPIO_DDC_LINE_DDC5 },
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
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
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
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
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
+	GPIO_PIN_ENTRY(GPIO_ID_GENERIC, GPIO_GENERIC_G,
+		DC_GPIO_GENERIC_A, DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK),
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
+	GPIO_PIN_ENTRY(GPIO_ID_HPD, GPIO_HPD_6,
+		DC_GPIO_HPD_A, DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK),
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
-		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK:
-			*en = GPIO_GENERIC_G;
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
-		case DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK:
-			*en = GPIO_HPD_6;
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
-		return true;
-	case REG(DC_GPIO_DDC2_A):
-		*en = GPIO_DDC_LINE_DDC2;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(DC_GPIO_DDC3_A):
-		*en = GPIO_DDC_LINE_DDC3;
-		return true;
-	case REG(DC_GPIO_DDC4_A):
-		*en = GPIO_DDC_LINE_DDC4;
-		return true;
-	case REG(DC_GPIO_DDC5_A):
-		*en = GPIO_DDC_LINE_DDC5;
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
 
 static bool id_to_offset(
@@ -191,164 +219,14 @@ static bool id_to_offset(
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
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
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
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
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
-		case GPIO_GENERIC_G:
-			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK;
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
-		case GPIO_HPD_6:
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK;
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
 
 /* function table */
-- 
2.47.3


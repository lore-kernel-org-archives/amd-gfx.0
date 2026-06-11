Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46ADCD98E3
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 07:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5765810F2FB;
	Fri, 12 Jun 2026 07:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="nbT5dJn1";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087C610F0F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 19:52:00 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-59ebde7d704so51531e0c.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207519; x=1781812319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hizmGFeGIKLsiG1PAA8nrLlhLcFzv1q22RtftzUoG94=;
 b=nbT5dJn1HqRB3X8Rd8+zczJM3Btv4speLZhqKootfWh3QtAv7eWQysfgqaU0q8X0wo
 40QjNTXGJ3/feEFXWjYoW6JQctHkVAarzF3ZaD7t2GKNXKo+aIYKNjpDXTlr8AXAQziY
 daFQ3+UZV4uHboU8Wml9OOW+srFwWwC8X6qYuFTZ4uOMtyMOXCK5uC6z98JcmMOvRMdX
 vpR0DvFCUgOQoJtwrcTssbJ4lUHJSNvMab+16vP0yvvKEbyAGwvTaSW4AhEODS4QvOoD
 rYVN55xrTKSThjtNT4gEW56YZR1FuuhnvBr76mH3jYBncocfm/NFuM54HVr2rHTuWMEH
 6Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207519; x=1781812319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hizmGFeGIKLsiG1PAA8nrLlhLcFzv1q22RtftzUoG94=;
 b=rMI8wnqkkK7bitoyywcmDlCJyOMrV1XFCc1fCiQbk/qwmxf7vdRJPXUWfu/9HZd/XM
 t7T2lWRvtRXSzVEgXOYJAT1gH17++y4YdA00/JXisC3mMCqMfnw8ume5yZJiHu5b3Ayf
 yB1jAOX7SmEucI2NjNwDq6WQioLFJ29gXiQSftQxXTOcI1V4hM1z/2pztN1cAD7k1HO7
 HcEp7SHQgKfMfiMxfHohBgvusnsdGEn1HhFu9AtkfXBkbNs/dz2SUtM9Zf7HmYKMr4LM
 6/PxZqwyn5v81cjZxE4x6xufkdNJcTUfAzgzVeeHuGA7KfKmbN87pgRhNu/IYDfWWVGn
 7ZBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JkkwmmkWKDnQdt8k2vO6+FZru59x/fiWaeUB21ORKdF8kaSo9qL71lA6+fOzxPmQ89tKBSz4g@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx55fqh5lpMteVBXqjM/NH/Cb5ABC5nlzGOajcVBhfOzyjSCTUS
 /lxg82HuB4nUmXox/7WeA1AN6Iay0pSQ4D8BTSm2HYRIqeRtLq81hOeCWvDJWO5nWcs=
X-Gm-Gg: Acq92OHfpoIMo7xYwy4lPzC6JLbvk84Yuo+r+aHAWzN4ZsW55PdFrmfgOzebThVqOSF
 LFuCFT2NZGwM1fLppX2AhJIKrVXhZepBmB1PzHV2HoGihwJpkj0DJm5TIJMuyMSAoTwXFI9KoUV
 VAwCQ0O2QA3bbQVRBrP0vySNy0obTEEJmO2Yy1BGv8sVtNPhECesJ/D0hujVjVANlWEXHewnuMr
 wo04XZZNh2ah2FbggqfC1TKPBTWVQLm5Bpvke8mlYNZfyYQlWPZkVEOa/NnXvNSc6GxGaz21we6
 9pO5Ss7fIcN7lTiSOa4H24vqTNoaFycU4ZfIrfhVmzGmbD3AJ7e2Vwv59UMyNTjrqfde+geeHdS
 XRJ4ohWJsPOSUTui0qan5UJUVIF/KexTjVuYlDIMEJJvEC2TgtVUs7UfXyQEjtJ/wWAikF5anJW
 chDM5yR1tZ114l/qMC/O4z8f5Hla+yn5QXA5DYjZYsZEmV60Hn6rgc5ME9tNkae4rlr7VBZP26z
 qZPKm3GA7Ubf6cMwLgoef6sP8OZXz+P6fhMuX+LBjJCV0HYFQ==
X-Received: by 2002:a05:6122:1d03:b0:56e:f071:d4ef with SMTP id
 71dfb90a1353d-5baffcd4b47mr2443887e0c.8.1781207518846; 
 Thu, 11 Jun 2026 12:51:58 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:51:58 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 2/9] drm/amd/display: convert dcn10 GPIO translation to
 lookup tables
Date: Thu, 11 Jun 2026 16:49:02 -0300
Message-ID: <20260611195026.25125-3-guilherme.bozi@usp.br>
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

Replace dcn10 GPIO translation switch statements with the
generic table-based translation helpers.

This simplifies the GPIO mapping logic and reduces duplicated
translation code.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
 1 file changed, 173 insertions(+), 311 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c
index fecc8688048d..000f603def58 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_translate_dcn10.c
@@ -58,146 +58,180 @@
 /* macros to expend register list macro defined in HW object header file
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
+	/* SYNCA */
+	GPIO_MASK_ENTRY(DC_GPIO_SYNCA_A,
+		DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK,
+		GPIO_ID_SYNC, GPIO_SYNC_HSYNC_A),
+	GPIO_MASK_ENTRY(DC_GPIO_SYNCA_A,
+		DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK,
+		GPIO_ID_SYNC, GPIO_SYNC_VSYNC_A),
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
+/* DDC */
+static const struct gpio_ddc_offset_entry ddc_offset_map[] = {
+	{ REG(DC_GPIO_DDC1_A), GPIO_DDC_LINE_DDC1 },
+	{ REG(DC_GPIO_DDC2_A), GPIO_DDC_LINE_DDC2 },
+	{ REG(DC_GPIO_DDC3_A), GPIO_DDC_LINE_DDC3 },
+	{ REG(DC_GPIO_DDC4_A), GPIO_DDC_LINE_DDC4 },
+	{ REG(DC_GPIO_DDC5_A), GPIO_DDC_LINE_DDC5 },
+	{ REG(DC_GPIO_DDC6_A), GPIO_DDC_LINE_DDC6 },
+	{ REG(DC_GPIO_DDCVGA_A), GPIO_DDC_LINE_DDC_VGA },
+	{ REG(DC_GPIO_I2CPAD_A), GPIO_DDC_LINE_I2C_PAD },
+};
+
+static const struct gpio_pin_entry gpio_pins[] = {
+	/* DDC */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC6,
+		DC_GPIO_DDC6_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_I2C_PAD,
+		DC_GPIO_I2CPAD_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC6,
+		DC_GPIO_DDC6_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_I2C_PAD,
+		   DC_GPIO_I2CPAD_A, DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK),
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
+	/* SYNCA */
+	GPIO_PIN_ENTRY(GPIO_ID_SYNC, GPIO_SYNC_HSYNC_A,
+		DC_GPIO_SYNCA_A, DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_SYNC, GPIO_SYNC_VSYNC_A,
+		DC_GPIO_SYNCA_A, DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK),
+	/* GSL */
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_GENLOCK_CLOCK,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_GENLOCK_VSYNC,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_A,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_GSL, GPIO_GSL_SWAPLOCK_B,
+		DC_GPIO_GENLK_A, DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK),
+};
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
-	/* SYNCA */
-	case REG(DC_GPIO_SYNCA_A):
-		*id = GPIO_ID_SYNC;
-		switch (mask) {
-		case DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK:
-			*en = GPIO_SYNC_HSYNC_A;
-			return true;
-		case DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK:
-			*en = GPIO_SYNC_VSYNC_A;
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
-	 * directly in the create method */
-	case REG(DC_GPIO_DDC1_A):
-		*en = GPIO_DDC_LINE_DDC1;
-		return true;
-	case REG(DC_GPIO_DDC2_A):
-		*en = GPIO_DDC_LINE_DDC2;
-		return true;
-	case REG(DC_GPIO_DDC3_A):
-		*en = GPIO_DDC_LINE_DDC3;
-		return true;
-	case REG(DC_GPIO_DDC4_A):
-		*en = GPIO_DDC_LINE_DDC4;
-		return true;
-	case REG(DC_GPIO_DDC5_A):
-		*en = GPIO_DDC_LINE_DDC5;
-		return true;
-	case REG(DC_GPIO_DDC6_A):
-		*en = GPIO_DDC_LINE_DDC6;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
-		return true;
-	/* GPIO_I2CPAD */
-	case REG(DC_GPIO_I2CPAD_A):
-		*en = GPIO_DDC_LINE_I2C_PAD;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
 		return true;
-	/* Not implemented */
-	case REG(DC_GPIO_PWRSEQ_A):
-	case REG(DC_GPIO_PAD_STRENGTH_1):
-	case REG(DC_GPIO_PAD_STRENGTH_2):
-	case REG(DC_GPIO_DEBUG):
-		return false;
-	/* UNEXPECTED */
-	default:
-		ASSERT_CRITICAL(false);
-		return false;
-	}
+
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 static bool id_to_offset(
@@ -205,186 +239,14 @@ static bool id_to_offset(
 	uint32_t en,
 	struct gpio_pin_info *info)
 {
-	bool result = true;
-
-	switch (id) {
-	case GPIO_ID_DDC_DATA:
-		info->mask = DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK;
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
-		case GPIO_DDC_LINE_DDC6:
-			info->offset = REG(DC_GPIO_DDC6_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-			info->offset = REG(DC_GPIO_I2CPAD_A);
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_DDC_CLOCK:
-		info->mask = DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK;
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
-		case GPIO_DDC_LINE_DDC6:
-			info->offset = REG(DC_GPIO_DDC6_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-			info->offset = REG(DC_GPIO_I2CPAD_A);
-		break;
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
-	case GPIO_ID_SYNC:
-		switch (en) {
-		case GPIO_SYNC_HSYNC_A:
-			info->offset = REG(DC_GPIO_SYNCA_A);
-			info->mask = DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK;
-		break;
-		case GPIO_SYNC_VSYNC_A:
-			info->offset = REG(DC_GPIO_SYNCA_A);
-			info->mask = DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK;
-		break;
-		case GPIO_SYNC_HSYNC_B:
-		case GPIO_SYNC_VSYNC_B:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_GSL:
-		switch (en) {
-		case GPIO_GSL_GENLOCK_CLOCK:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask = DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK;
-		break;
-		case GPIO_GSL_GENLOCK_VSYNC:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask =
-				DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK;
-		break;
-		case GPIO_GSL_SWAPLOCK_A:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask = DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK;
-		break;
-		case GPIO_GSL_SWAPLOCK_B:
-			info->offset = REG(DC_GPIO_GENLK_A);
-			info->mask = DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK;
-		break;
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45861CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 07:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F43C10ED21;
	Wed, 13 May 2026 07:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="l9Cee67z";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F6D10EBFD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:01:55 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f7020a928eso8270823eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778612514; x=1779217314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbId00WAHp2KabBC0vsQBfXuDPvPFs92EuJ0J29qKqs=;
 b=l9Cee67z5aYnP60lWKkpoOt2MQZaHq/MxwECJSzb1s59Frsjn456atnAe2iZGwmOJi
 lo6+bJMXGVAwuPCoGL15HQBX0LH/gS3J1tzphl1bMqZkh/lOEYhBpZoaJdzZURAaCz/s
 HHjrooBr2tlmWi2FlztHe5wnVdD3pbjVOU9O2VGuFuxB6iMYxylCUwqcX5wu0WoX8JJX
 /xTGY0ySat6TUhMfpHpvoj8DkFMGg8Fy/Z3den8Lzl//N+uAkVVpZS29FZZoHCByLcIx
 fWIu1QQgFWjGIAc7wdLoH5UyW32dvtM4Ac2fa7CfByP0K1IgjSJm6ibFfBHH1bIl+atg
 186A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612514; x=1779217314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbId00WAHp2KabBC0vsQBfXuDPvPFs92EuJ0J29qKqs=;
 b=X2N5ZZODrjF2sD28uPvBAR3UehqOFoPb4J5E1au1KRe0DHEz3e+BXCa6aOJqRv+W4p
 Qj6iKdNwl/Xndm45Vns5LOYDH0O1fYn3306d1HkUzgh2SwioBx0bKrqquNcZZyvd3MvK
 ptdm1S5z5Hq/94MEAy9JBtiiJjyaDMa0WTsESFthrcsl5ISo7II31hVVQNWuZRwMvBEA
 P3rLoqQry109kOWE+2OdgS4uIOQNLCNkYwlWfmZuBdL73S7+CwyiXfsd0Q6ZyZdumwJd
 e/pKV3Yog054XREAQa+IPDADdI5EXL/11LJtBhazYx5zoV25RT0XQpgX//RgVxIEidSr
 IGcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3VQOEGzapSlI+X74W5LXPJIXJRe3rWSIBMib+gUXEunnAV6wxFcD8pBA141gqTplnKRLMwMF8@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3Z+xgFEKPkI1XJUD1pykHOAxDnbubaaVbi7ssFw0KpotuIgRs
 f5TEtpuPCQY0PK1bPkl+qiBvbgLj9XhdB7ihI4GJaQU0rjbuELaOhr9Aoax/FTxBkK0=
X-Gm-Gg: Acq92OE7IJhD23Y62BlrPfWvBJFJmoJZXX5B5T9ycmbbg+BvfsfYP62mrTQaFR/2flt
 HxqCnEYLGqRFpNL0xwPNg4sD+1i50bgoSmrP5mxm8aXDByDWZOLhJ9KejDuvG/7mUKKZK0HkEcZ
 eyxrqmHWFWNmXL1/ec8rjC78Wl60zraC+mmfB5wgzqazqYFxRdb7YXTFnX6/1uf2VKrqecQ0kXS
 /qjiGb12d8AB7sMMWD6aA6eFNOa1XgM6tVkrW4FOMm8gGHMwNZHOdnv9BQSEAZ8zky0p5tyiuWP
 nDeVhsL5sxARNYby8zMwXTaxA1P3TUqeW0dPIDBZj2uSBO6OtYH4ydFKbw9ceD82F1MAFbE4eeT
 xri7fSQTG7Nyl9MLui0xbQbMa3hphoHfYl5UgJr1s5Jg993Y5nIwdqHQf1bMcd8dvA5hbiNHRZX
 LizObB91f1zlZJvDwLRETS9p3GMpR8AqfPr49xjOOK9GG0foUIzBWZaM7Y1Dtt4waPr0PuEe67C
 C4H8bvGXFY3deKAoG7yUFaBZf8nM2UIxpNiNTa4QCTf8QeP
X-Received: by 2002:a05:7301:19a9:b0:2e1:e5c0:7992 with SMTP id
 5a478bee46e88-301180af715mr200225eec.8.1778612514275; 
 Tue, 12 May 2026 12:01:54 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88914523csm18716616eec.29.2026.05.12.12.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:01:53 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amd/display: convert dcn42 GPIO translation to lookup
 tables
Date: Tue, 12 May 2026 15:59:52 -0300
Message-ID: <20260512190019.228440-10-guilherme.bozi@usp.br>
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

Replace dcn42 GPIO translation switch statements with the
generic table-based translation helpers.

This simplifies the GPIO mapping logic and reduces duplicated
translation code.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++++++-----------
 1 file changed, 70 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
index e7e1d9979876..7b2c4cd42450 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
@@ -39,62 +39,76 @@
  * end *********************/
 
 
+static const struct gpio_id_offset_entry gpio_offsets[] = {
+	/* HPD */
+	GPIO_ENTRY(HPD0_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_1),
+	GPIO_ENTRY(HPD1_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_2),
+	GPIO_ENTRY(HPD2_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_3),
+	GPIO_ENTRY(HPD3_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_4),
+	GPIO_ENTRY(HPD4_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_5),
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
+};
+
+
 static bool offset_to_id(
 	uint32_t offset,
 	uint32_t mask,
 	enum gpio_id *id,
 	uint32_t *en)
 {
-	(void)mask;
-	switch (offset) {
-	/* HPD */
-	case REG(HPD0_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_1;
-		return true;
-	case REG(HPD1_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_2;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(HPD2_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_3;
-		return true;
-	case REG(HPD3_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_4;
-		return true;
-	case REG(HPD4_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_5;
-		return true;
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
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
 		return true;
-	default:
-		ASSERT_CRITICAL(false);
-		return false;
-	}
+
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 
@@ -103,81 +117,14 @@ static bool id_to_offset(
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
-
-	return result;
+	if (dal_hw_translate_id_to_offset(
+			gpio_pins,
+			ARRAY_SIZE(gpio_pins),
+			id, en, info))
+		return true;
+
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 
-- 
2.47.3


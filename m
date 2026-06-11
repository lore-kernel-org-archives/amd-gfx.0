Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0866CD98E7
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 07:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674DB10F30C;
	Fri, 12 Jun 2026 07:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="zR/vVR3s";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4557210F118
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 19:53:12 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-59b074ec7ceso58296e0c.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781207591; x=1781812391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbId00WAHp2KabBC0vsQBfXuDPvPFs92EuJ0J29qKqs=;
 b=zR/vVR3s28rokfeO9IwHQGra815A13g/K5JJSmopcW0Homrl0Icp+S/iSbEJaYDakQ
 +cH6P7/kwWrnIGaUaliiivtkEEAw1swb/qHpWONTLnj0srwrn9MMRukCpvykLf2/rwMt
 0dPS7EqEpQwJliIZbGErpqG8PWLqqF0UTCsMAnYB7+bs7BYeaKeJEkLgAXKPHJSR2xHR
 97TTucayWq5qWCaLglfA2A+gMOj9He/v0M1NyQrLKUt0H+cOlKx8Z4LfCyvp2L8FHntJ
 FuMSSWQtURC1KxFE5VCkKXanE3Fkp5rHuo20RnW+eDoF71ObY7liifE45YKe7qihAeUX
 9fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207591; x=1781812391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbId00WAHp2KabBC0vsQBfXuDPvPFs92EuJ0J29qKqs=;
 b=EtYhJhrcxHfQcX/JsTH2PbrdMiQ3KpgDfATnNZDSlNTt8VsUTQCrruXa+2Wjx3qtat
 FHjzi4DqTf/6+8j3MHWnbb1weJ7kGfiuP+YNdyDX13rs9ALmi9TjgValDbL+oIIELlMo
 +KHx+Is50q9wc7IWsRDh9u4SGBgqg9/xzvbKJxj56KNenZ0syGGfzulNkJt7UwADSFgH
 E3yNzZh5+V6DeE3n+AN2knbvdmY7n2gr0yyAjiCPP0/QNKjzX6OypCA3tXHF6UvaJbeA
 FFyUpfMLjgzFdicbMyP2h+LjUghXw2e3PMLz6xkGGkEVU+BI7WJpvkwnE0YgkG5knCfz
 iSsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DCmWJ7Clh+1Syz63xBec0G0G84IKPXWgPfHLY57b/6U7+pP/W9UqC/yXdgYB07CZNQ+0x4bnJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxb4DHMZOT0sayQiaU7+aYqc66HG5XVTP1k6B848L0XTQW6KKWa
 WwQSCUZ3GBIQ0PYrz7oZntjO2Asad7K3CV1QYZNqqxXSAD9lAX+rp9cJkEyMaf/EYRA=
X-Gm-Gg: Acq92OHaTe2aLpbZDpars7aRdsvhE8MRsAQ373MU/SmoEUtWDAfY4Mvv6mn6CgXEzRh
 jQH6ckseCTuHqQyqly+GoXtgHAdKv2f9sYVMA4fRO/S3LxXljOkiKKLJzjeK2MpJ23i+OjJGaKj
 kkC5lsM6pdb2LGPJq8IY9LY3FlAujTWaKUzRN7WUBzY43PztP2TMFYOVxzk0gM7ixOa85dTxaUH
 lP7Gb2btPnIJ++ZX96Z0p1ysdHiFIx2XWh967u26NMPI+pu3Ed4A6OlMvqWS0LZsOR85aVcu81W
 R7he6iD9XMIhS4ia45/Y1Wx9yUSBWJU/buacXvLcRa7OKUOlbxhl9kMRR09jRRfZqkz7yCAlkhn
 c0Mls2NhsXPASyWG7JAAb3SozeV7JX5lQngmyVXhFFyMzG2TqRltK03JFIy37iVFOwwZaeQD0GB
 LcHo2+uYB/CuhvC3aUBqqMwieKLFw3oulo33Zj7c0IlmwTJ/igwFTEijeN6V62v+H+7bdhtzF+M
 qA9r+HqV1sUbe7VnL5ofdcml8Ze/kNd+FpiI0Qv0T3FYoXO+w==
X-Received: by 2002:a05:6122:21a6:b0:583:5e28:17b1 with SMTP id
 71dfb90a1353d-5bb01c400a0mr2865749e0c.12.1781207591262; 
 Thu, 11 Jun 2026 12:53:11 -0700 (PDT)
Received: from gui-host.Dlink ([186.220.219.98])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691bb8a4sm345359e0c.10.2026.06.11.12.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:53:10 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 9/9] drm/amd/display: convert dcn42 GPIO translation to
 lookup tables
Date: Thu, 11 Jun 2026 16:49:09 -0300
Message-ID: <20260611195026.25125-10-guilherme.bozi@usp.br>
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


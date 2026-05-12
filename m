Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64A4CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 07:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0ED10ED24;
	Wed, 13 May 2026 07:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="zfmqfX0E";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CC110E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:01:02 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ff5472f263so1988600eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778612462; x=1779217262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mtB9iQDbC1TK2yGUTmHv+9UWkJZ55RDgRtxQiWv2Ig=;
 b=zfmqfX0E1gt/hfPCwm0loK+f98KfmUJ2bWvCxAadOQ3Zj/lqC2qFbae430r+lWLieC
 0StMlnpHkq/A6BAH4OnxMXWB0Pe1qF7In88Oc2NV3m9Pi2vTbgvVjrvsSEjJ5BpYpVax
 +8RweTZqOmWyybHXACNOV9juRdmDbFxVgNaQ9VUCVN7ngKPoIo9LvNg0drHyxlImv35b
 xM+y1/NMgfmqKjrSAg5csR5ce41L7MfDOXELPyeqFmBKmXr14uwxEZ4ysW77qoG97k8c
 7TpISZC1RiWwcIjkxpOCNApdBWve7zswxhf3Ksmz8TxLPI+/BgHh8e+e+06UWclocmh6
 N2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612462; x=1779217262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9mtB9iQDbC1TK2yGUTmHv+9UWkJZ55RDgRtxQiWv2Ig=;
 b=Q3UlP5emDaWRI2OLPBA5atkdXrs2tZUg5QkLPYCepmRNa80vPkg0fyj38BPea2i5kN
 EvBT9g1YQ0wcpggfLG+liyqW3yRsKSYKtO43jBSnQozi2L9N/d12o3VoJatZxLEyz3FJ
 LRcC/7O98EbhKAXjSePKW8XGxophxJzg0eJtBmuAILWROL5QdXCuc2fygn85wWNQwT3b
 6lI/+QApasH5WxiPrpWzep/QgTdQ42GpHxqy3DU1S1lIdz2BbgKccjuY2FniDPUQoS+r
 CqmbiEtxn4ez1ipRu4GRq/qxnNdlOx+eiHWNY25lp+nP1WnywVS/4i1CXz8FpSNcuyHQ
 0E0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ87KcBo+3NMDlrU9F/CBaX/kJU0mKJZB9JsvwzM14RwStfdu5GBgmuG7skCBYqYUva1IZ4c6kAu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuG0X/+MVIax76n6kbU8m5slaUxgqHZ9SurpCiQ0peOKMc/sLU
 CARPqTSmK/aWigArIeiBYLSiCZ+XmhFRr7zvfUWQB/Kh4ETanhHQLvxMAygRbOMzZzI=
X-Gm-Gg: Acq92OE1s47w8Iw7MiDAkNCwCL7XTr8Ojp5TVbZx5FfH3l6uO/MV4R6mWHSLVoziXZR
 kCIXwxO9JUoh5xhZBfQ/iUIKP9//gQBmy+CFiR10Iw8+FSvDgI9ra+lMy1ED4GuTl1m/Dt3tlXJ
 rCTk+1L89CtdhIL787OmkBGJZWltG8Ec8v7GZz4ix+cfyi2/tUarqf67x4mgGsKpJLq1x6yDzos
 l8RHSxdX0aGXuSyjmvcsF38NGJxXtbPNPoFJcTlmLBnz3eYRiOqO+j6fVkWbWBy58d6R0NhEdhj
 f5TV7ICACFoKV2St3v3Qr3eQQ+JZR2+0LC42y44zL9Tx8PyORZwAQEd0cmPdOYd5CfUwB3/tdKb
 4WTrevRFAkZfxsgUgRwOwqKIZBlv0yVNLjcrnRibr0XrNOLQnHgSIfxN/JshcxabKYWgmspD2hw
 v+j8ctERdd/FQBpzC0s5eX8LuUFBHFBTPDtI3Ul+8U2gt3xx1bhRf2S3EkFta/yutvVX8xBpLe/
 RS6Cug/OZOM6biatzHVomYce7z0T2koFuQ32nkW05D0un9+lFw7ZRvFYSE=
X-Received: by 2002:a05:7300:c618:b0:2ff:c611:82c7 with SMTP id
 5a478bee46e88-301174807e8mr222994eec.12.1778612461972; 
 Tue, 12 May 2026 12:01:01 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88914523csm18716616eec.29.2026.05.12.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:01:01 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amd/display: add GPIO HW translation helpers
Date: Tue, 12 May 2026 15:59:44 -0300
Message-ID: <20260512190019.228440-2-guilherme.bozi@usp.br>
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

Add generic helpers and lookup table types for GPIO hardware
translation.

The new helpers provide reusable conversions between GPIO IDs,
register offsets and DDC lines, allowing ASIC-specific drivers
to replace large switch statements with static lookup tables.

No functional changes intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 .../drm/amd/display/dc/gpio/hw_translate.c    | 86 +++++++++++++++++++
 .../drm/amd/display/dc/gpio/hw_translate.h    | 21 +++++
 .../gpu/drm/amd/display/include/gpio_types.h  | 48 +++++++++++
 3 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index e6e36a912b13..18f14f9f244c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -129,3 +129,89 @@ bool dal_hw_translate_init(
 		return false;
 	}
 }
+
+bool dal_hw_translate_gpio_offset_to_id(
+	const struct gpio_id_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en)
+{
+	uint32_t i;
+
+	for (i = 0; i < table_size; i++) {
+		const struct gpio_id_offset_entry *entry = &table[i];
+
+		if (entry->offset != offset)
+			continue;
+
+		if (entry->check_mask && entry->mask != mask)
+			continue;
+
+		*id = entry->id;
+		*en = entry->en;
+
+		return true;
+	}
+
+	return false;
+}
+
+/* we don't care about the GPIO_ID for DDC
+ * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
+ * directly in the create method
+ */
+bool dal_hw_translate_gpio_ddc_offset_to_id(
+	const struct gpio_ddc_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t *en)
+{
+	uint32_t i;
+
+	for (i = 0; i < table_size; i++) {
+		const struct gpio_ddc_offset_entry *entry = &table[i];
+
+		if (entry->offset != offset)
+			continue;
+
+		*en = entry->en;
+
+		return true;
+	}
+
+	return false;
+}
+
+bool dal_hw_translate_id_to_offset(
+	const struct gpio_pin_entry *table,
+	uint32_t table_size,
+	enum gpio_id id,
+	uint32_t en,
+	struct gpio_pin_info *info)
+{
+	uint32_t i;
+
+	for (i = 0; i < table_size; i++) {
+		const struct gpio_pin_entry *entry = &table[i];
+
+		if (entry->id != id || entry->en != en)
+			continue;
+
+		info->offset = entry->offset;
+		info->mask = entry->mask;
+
+		info->offset_y = info->offset + 2;
+		info->offset_en = info->offset + 1;
+		info->offset_mask = info->offset - 1;
+
+		info->mask_y = info->mask;
+		info->mask_en = info->mask;
+		info->mask_mask = info->mask;
+
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h
index 3a7d89ca1605..339e381f8fde 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.h
@@ -47,4 +47,25 @@ bool dal_hw_translate_init(
 	enum dce_version dce_version,
 	enum dce_environment dce_environment);
 
+bool dal_hw_translate_gpio_offset_to_id(
+	const struct gpio_id_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en);
+
+bool dal_hw_translate_gpio_ddc_offset_to_id(
+	const struct gpio_ddc_offset_entry *table,
+	uint32_t table_size,
+	uint32_t offset,
+	uint32_t *en);
+
+bool dal_hw_translate_id_to_offset(
+	const struct gpio_pin_entry *table,
+	uint32_t table_size,
+	enum gpio_id id,
+	uint32_t en,
+	struct gpio_pin_info *info);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/include/gpio_types.h b/drivers/gpu/drm/amd/display/include/gpio_types.h
index 8dd46ed799e5..afd3fc73a911 100644
--- a/drivers/gpu/drm/amd/display/include/gpio_types.h
+++ b/drivers/gpu/drm/amd/display/include/gpio_types.h
@@ -277,6 +277,49 @@ enum gpio_config_type {
 	GPIO_CONFIG_TYPE_I2C_AUX_DUAL_MODE
 };
 
+struct gpio_id_offset_entry {
+	uint32_t offset;
+	uint32_t mask;
+
+	bool check_mask;
+
+	enum gpio_id id;
+	uint32_t en;
+};
+
+#define GPIO_ENTRY(_offset, _id, _en) \
+	{ \
+		.offset = REG(_offset), \
+		.check_mask = false, \
+		.id = (_id), \
+		.en = (_en), \
+	}
+
+#define GPIO_MASK_ENTRY(_offset, _mask, _id, _en) \
+	{ \
+		.offset = REG(_offset), \
+		.mask = (_mask), \
+		.check_mask = true, \
+		.id = (_id), \
+		.en = (_en), \
+	}
+
+struct gpio_pin_entry {
+	enum gpio_id id;
+	uint32_t en;
+
+	uint32_t offset;
+	uint32_t mask;
+};
+
+#define GPIO_PIN_ENTRY(_id, _en, _offset, _mask) \
+	{ \
+		.id = (_id), \
+		.en = (_en), \
+		.offset = REG(_offset), \
+		.mask = (_mask), \
+	}
+
 /* DDC configuration */
 
 enum gpio_ddc_config_type {
@@ -293,6 +336,11 @@ struct gpio_ddc_config {
 	bool clock_en_bit_present;
 };
 
+struct gpio_ddc_offset_entry {
+	uint32_t offset;
+	uint32_t en;
+};
+
 /* HPD configuration */
 
 struct gpio_hpd_config {
-- 
2.47.3


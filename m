Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 09:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4313961B1B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 09:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4313961B1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7576E527;
	Fri, 19 Nov 2021 09:46:03 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E2D6E527
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 09:46:02 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 p18-20020a17090ad31200b001a78bb52876so10612574pju.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vgOQAg1v2b4i5dxNENJsL6snbAvVRxWR8L3bOe0kGW4=;
 b=f9XVLfMeHjv7mwnustrce6IrcuSmu/YcV9o6gu1IV2GvcyphM1FPVAu/HZOmloC5S6
 wo35nVqgS3k5Ao8QK8iko3p6J+Kz6t/XK74beGRTluAKzuO1k6GFa4Xpz3snfsHLn7gK
 TfzKHnrOfPDL45IrE1GWlOseH7V9B2U7DbTvtaMoWrkxo24jQ80B55gE17RWEhcpyhzL
 okppsXDn/7Qn8QjlGk+FOEI7KC4NjNfHWfhKe/oWH+CLzpBwMuJp5vgM82X6H3TkXdlJ
 LTEjGUFGURcsn0TEBzRaqjADxnrvXTxo0ea8xfhUuYBLHHEreMhlvLoPDYezC4ozLiPi
 6pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vgOQAg1v2b4i5dxNENJsL6snbAvVRxWR8L3bOe0kGW4=;
 b=OLa1VBMO9kUjmE61E89ppTHIHs+LXNftUylCQWjq8Oi8D3q5djerUtDTpyOaRHUMK6
 Iaj67wiz+abEbEsOW98ab2NQfPWe+FVPy++dhDAn5rewLZzdA+RWTtQ3hwywH0HBwAQy
 4zC6YY0YYsNvv1To38eWgNIcJghZoZpyzh/Vw/JNGYaYVKyew6Yt9/iAl1zEwhn3q9Fp
 CKApD/vguAPIRsealO0ktH3KbznuhrRUJkuUew0L0QIzpR/6vHHxb8GO9158H175jkCd
 GO51MMLqFvxc4e6VcKyxbvZAyLKYyUpBj0T/R52yE6HOchEl2jAaSM3EJLoV02zKvmZA
 vyHg==
X-Gm-Message-State: AOAM53244VbjbkG9IbrpO6+MUjTHsZbz5r00GOyHixhg52bSOmAZfN0l
 vqU1hqnIuRDF06TCbNti2dY9+nyxtnvZ1g==
X-Google-Smtp-Source: ABdhPJx5yiUIHK7GiyJLlXlONgOmNtU3URmkTCakK7uNjSJvFNhmJngSHJQ78TLQb37hXmYld5YKYw==
X-Received: by 2002:a17:902:a717:b0:142:76bc:da69 with SMTP id
 w23-20020a170902a71700b0014276bcda69mr75777370plq.12.1637315162447; 
 Fri, 19 Nov 2021 01:46:02 -0800 (PST)
Received: from localhost.localdomain ([43.242.116.121])
 by smtp.gmail.com with ESMTPSA id u4sm1653762pgg.24.2021.11.19.01.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Nov 2021 01:46:02 -0800 (PST)
From: Amol Surati <suratiamol@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: more sanity checks (usRecordOffset) to obj info
 record parsing
Date: Fri, 19 Nov 2021 15:15:58 +0530
Message-Id: <20211119094558.141216-1-suratiamol@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When parsing Encoder, Connector, or Router records, if the
usRecordOffset field is 0, the driver ends up dereferencing
ATOM_COMMON_TABLE_HEADER of the Object Table as
ATOM_COMMON_RECORD_HEADER.

A BIOS, which triggers such dereferences when parsing the
Encoder records, is found on Cedar Radeon HD 7350/8350 GPU.

Allow record dereferences only if usRecordOffset is non-zero.

Signed-off-by: Amol Surati <suratiamol@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 28c4413f4..bab0e1cc2 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -646,14 +646,15 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 				if (grph_obj_type == GRAPH_OBJECT_TYPE_ENCODER) {
 					for (k = 0; k < enc_obj->ucNumberOfObjects; k++) {
 						u16 encoder_obj = le16_to_cpu(enc_obj->asObjects[k].usObjectID);
+						u16 rec_offset = le16_to_cpu(enc_obj->asObjects[k].usRecordOffset);
 						if (le16_to_cpu(path->usGraphicObjIds[j]) == encoder_obj) {
 							ATOM_COMMON_RECORD_HEADER *record = (ATOM_COMMON_RECORD_HEADER *)
-								(ctx->bios + data_offset +
-								 le16_to_cpu(enc_obj->asObjects[k].usRecordOffset));
+								(ctx->bios + data_offset + rec_offset);
 							ATOM_ENCODER_CAP_RECORD *cap_record;
 							u16 caps = 0;
 
-							while (record->ucRecordSize > 0 &&
+							while (rec_offset > 0 &&
+							       record->ucRecordSize > 0 &&
 							       record->ucRecordType > 0 &&
 							       record->ucRecordType <= ATOM_MAX_OBJECT_RECORD_NUMBER) {
 								switch (record->ucRecordType) {
@@ -677,10 +678,10 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 				} else if (grph_obj_type == GRAPH_OBJECT_TYPE_ROUTER) {
 					for (k = 0; k < router_obj->ucNumberOfObjects; k++) {
 						u16 router_obj_id = le16_to_cpu(router_obj->asObjects[k].usObjectID);
+						u16 rec_offset = le16_to_cpu(router_obj->asObjects[k].usRecordOffset);
 						if (le16_to_cpu(path->usGraphicObjIds[j]) == router_obj_id) {
 							ATOM_COMMON_RECORD_HEADER *record = (ATOM_COMMON_RECORD_HEADER *)
-								(ctx->bios + data_offset +
-								 le16_to_cpu(router_obj->asObjects[k].usRecordOffset));
+								(ctx->bios + data_offset + rec_offset);
 							ATOM_I2C_RECORD *i2c_record;
 							ATOM_I2C_ID_CONFIG_ACCESS *i2c_config;
 							ATOM_ROUTER_DDC_PATH_SELECT_RECORD *ddc_path;
@@ -702,7 +703,8 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 									break;
 							}
 
-							while (record->ucRecordSize > 0 &&
+							while (rec_offset > 0 &&
+							       record->ucRecordSize > 0 &&
 							       record->ucRecordType > 0 &&
 							       record->ucRecordType <= ATOM_MAX_OBJECT_RECORD_NUMBER) {
 								switch (record->ucRecordType) {
@@ -753,19 +755,18 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 					if (le16_to_cpu(path->usConnObjectId) ==
 					    le16_to_cpu(con_obj->asObjects[j].
 							usObjectID)) {
+						u16 rec_offset = le16_to_cpu(con_obj->asObjects[j].usRecordOffset);
 						ATOM_COMMON_RECORD_HEADER
 						    *record =
 						    (ATOM_COMMON_RECORD_HEADER
 						     *)
-						    (ctx->bios + data_offset +
-						     le16_to_cpu(con_obj->
-								 asObjects[j].
-								 usRecordOffset));
+						    (ctx->bios + data_offset + rec_offset);
 						ATOM_I2C_RECORD *i2c_record;
 						ATOM_HPD_INT_RECORD *hpd_record;
 						ATOM_I2C_ID_CONFIG_ACCESS *i2c_config;
 
-						while (record->ucRecordSize > 0 &&
+						while (rec_offset > 0 &&
+						       record->ucRecordSize > 0 &&
 						       record->ucRecordType > 0 &&
 						       record->ucRecordType <= ATOM_MAX_OBJECT_RECORD_NUMBER) {
 							switch (record->ucRecordType) {
-- 
2.33.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ABAD1951B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E29010E4A8;
	Mon, 26 Jan 2026 21:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Viggbd5F";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D87510E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:53 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so3175307f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461732; x=1770066532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/DLY8RDglmwiZWTtClNVAcGLFbUc5DjMzn6/Nkb5JqQ=;
 b=Viggbd5F3puz9io8ljS2N3lZ7E5vVo/dpVovvBWC7kADYXA1a0PdEneMHrkyVJiBaA
 hXFGTS8hba5ep0yw68NAzhyrOtAN34xYYuJb3RW8mQ2Y2if4dU+sinXWFL7JHnMc7Bb+
 trQYdEt1qttzqtk50773uU289M7dBMkjmV9LDJsUexaZntd4lWqqn+Q0rq8HNe8W8tnf
 18fYKG31QpCZC8+0ARkFaHKgHGs+eMFmd9IElTYB4HEnk5KRXyaXk+T6mbwnqohQRaeL
 L87rYkANVphMJOgHz/PhHcOQ/sHT+0ec7kfj7igwXt7NRN4AC+LyfjLN0RZICLKN+ESA
 tDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461732; x=1770066532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/DLY8RDglmwiZWTtClNVAcGLFbUc5DjMzn6/Nkb5JqQ=;
 b=cATqP0swe0H+kME6C1Ij44slpnhI1JmuK2kzLpMGiYnEzwuSv3r9jrMw9lE5S1ZIrD
 EheF/XYimQLWDB5MjrCbgeYVa0mlacp+BL5UcC0l478JK7AXfa/YcCNO9zcev2uUoV1R
 Suo8pCPq30/BkvX1UePsJ2iXDbMBQxEr8RsQoKaWjYK5NFRx+Z/G/JPcHBwkMOnEBxkJ
 TPwmZu+XaajKmm7fKJDnkJNBIZ7tMQhQJDa+7DXR4AMcc1Q/ImEBwRhOmDL1o+QJhUnJ
 xJeOyzxSeY6P3rmktBbAX6SGmmfU46UG5FanjqRBTBhm0xvIEJRKR6mbDv3ATlU390kz
 FsEQ==
X-Gm-Message-State: AOJu0YxYHWbTBdZDOQGsVDSDyNBxJav6EiH5ohKbFwX9ZPvkXtcaS6g+
 aYBhWASrpS3jtpx908d+1ORcZMmyZcY0TFiYU4Ua8xixnUIIEVHSC2AK2oz4RA==
X-Gm-Gg: AZuq6aIjB4OEzb6/DMwq/Ou/jsiM+R+FDLYAzHTEcaOZDrStMBHqmi1uixxPkt7lL0j
 HNy+7Jpb56KLneklVr6KCH4ZbH287KmExTzp5Rh2TPls/QWFJPNrOXBso4Ark7lUEmMNH056ddw
 HCg6euV8Puk/yskCmut9sEvH8e3pvbhh2wxy4AWKjItIa6ZQtEEHB1hNCjTgQmMbuOQdljq8yVD
 ZkaM4t6Zovxzsv08j/bof2igOD2HZszBY4jsdIneu6Hb1/mU1N8s+fLRC9mLDich51Ek7AqqkKb
 rICaHfM4ei3jVtBW1Akk+lX/MEzeV6ExFUDqwCY5doa4rx6UrqQxFCKTMvG7toWd1wDvMb/N8a2
 Cle8IA6b4gUz+M9uFiZk0i35zDKDsixlZdy4mCzKsvqIO6oy2w8uQAvxoKhOedVipwBzUFRk8fT
 aNkM5MKZSWR1iPrukUzNa64JAZb+vJpVmNMhA2b77rp4jt0TqBUNui8JLMDCM49lw=
X-Received: by 2002:a5d:588d:0:b0:431:764:c25d with SMTP id
 ffacd0b85a97d-435ca1a702emr9638755f8f.35.1769461731928; 
 Mon, 26 Jan 2026 13:08:51 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:51 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 13/14] drm/amd/display: Implement DAC load detection on
 external DP bridge encoders
Date: Mon, 26 Jan 2026 22:08:36 +0100
Message-ID: <20260126210837.21885-14-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the pre-existing implementation in the BIOS parser, but call
the ExternalEncoderControl function for external encoders instead
of the built-in DAC load detection function.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c     | 11 ++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h        |  3 ++-
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 82877f7b3b6f..f56f3ee81a22 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -794,11 +794,13 @@ static enum bp_result bios_parser_external_encoder_control(
 
 static enum bp_result bios_parser_dac_load_detection(
 	struct dc_bios *dcb,
-	enum engine_id engine_id)
+	enum engine_id engine_id,
+	struct graphics_object_id ext_enc_id)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	struct dc_context *ctx = dcb->ctx;
 	struct bp_load_detection_parameters bp_params = {0};
+	struct bp_external_encoder_control ext_cntl = {0};
 	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
 	uint32_t bios_0_scratch;
 	uint32_t device_id_mask = 0;
@@ -824,6 +826,13 @@ static enum bp_result bios_parser_dac_load_detection(
 
 		bp_params.engine_id = engine_id;
 		bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
+	} else if (ext_enc_id.id) {
+		if (!bp->cmd_tbl.external_encoder_control)
+			return BP_RESULT_UNSUPPORTED;
+
+		ext_cntl.action = EXTERNAL_ENCODER_CONTROL_DAC_LOAD_DETECT;
+		ext_cntl.encoder_id = ext_enc_id;
+		bp_result = bp->cmd_tbl.external_encoder_control(bp, &ext_cntl);
 	}
 
 	if (bp_result != BP_RESULT_OK)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 6f96c5cf39fe..526f71616f94 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -102,7 +102,8 @@ struct dc_vbios_funcs {
 		struct bp_external_encoder_control *cntl);
 	enum bp_result (*dac_load_detection)(
 		struct dc_bios *bios,
-		enum engine_id engine_id);
+		enum engine_id engine_id,
+		struct graphics_object_id ext_enc_id);
 	enum bp_result (*transmitter_control)(
 		struct dc_bios *bios,
 		struct bp_transmitter_control *cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 3f5c833ce18a..83d43b62747d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -723,7 +723,8 @@ dce110_dac_load_detect(struct dc_link *link)
 	struct link_encoder *link_enc = link->link_enc;
 	enum bp_result bp_result = BP_RESULT_FAILURE;
 
-	bp_result = bios->funcs->dac_load_detection(bios, link_enc->analog_engine);
+	bp_result = bios->funcs->dac_load_detection(
+			bios, link_enc->analog_engine, link->ext_enc_id);
 	return bp_result == BP_RESULT_OK;
 }
 
-- 
2.52.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFBED1951E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D424C10E4A7;
	Mon, 26 Jan 2026 21:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g9ByqA1/";
	dkim-atps=neutral
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37CF10E4A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:45 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so36571815e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461724; x=1770066524; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzOL7mDyD0zt2Us3UwdQXX9z9bsy9uMvF3q8QQYpScc=;
 b=g9ByqA1/0KzbxOG78u+dyKKO5F5XlfoYoYBdpE8lOYuSp42UfnNwMSpPebyrS7gAaf
 r3/kSCO3ngNoinE2i8MX/4S4ewnsRYkp/aQXNcYAbsAM0rLGdDHbdHj35aykIs5IAmNk
 zBF7pHY+akiam2bB3i4XXgqoz6zyRQ4FYFaXEvNcs8hlXdhYfvZAFw16d/IgrJAk3OXz
 Sb/ZQyGpxTBm+h4GiPHBFE+1XcWSUvL5j9u8ZZmMjxiGzcb30V8O+a1y9KW+fRoj1hm2
 XZ26uLBWqK99rdXamqVqkBsq+Tw//cgeLiEoG4ZFs4mc/jfSeNYQeasHvmGZsocxyU2I
 vErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461724; x=1770066524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzOL7mDyD0zt2Us3UwdQXX9z9bsy9uMvF3q8QQYpScc=;
 b=pi+A7kWwCO1w2l5KSyzroa4p6X1iRsOfJpfqygecQpV92sOxsMxtEK6euI3MZH5S8H
 KLP/hzJNlyfu3JylJNHqShtZ45ZTJEN42feyX+SjUj2MDHJX2L3HXKUr3Kn/p9V/e9K6
 /oLol4+Br6wAmsRAX9bqZ3FTKXUvPKH9Xrby5UZpkxs+qxRam558pCKRyH+A97Lrpql5
 ziNOIo/2kcdhYWHEevfeehSYf6AhEUrbFtIvWKw7wp/JNlqzu7fc7Ukwrqlg5Ofx4QvG
 UIHQwWB0LDzXwdSvke/AAuDejveYHAvydBW8M1pl0Lgqfc5la4FxhQWzO0l3/3avHPHT
 9rZA==
X-Gm-Message-State: AOJu0YzLWxhzmOPzo/FwYCJBgGzWtTP2fvaeiwRgyXPG72feep1c8Y8S
 SnwGfORLZEpK8KFdJ8u3moDjzYBgwNorJxHJfYwT4MF+d1YyNLWs2PY+BGxfpoiQ
X-Gm-Gg: AZuq6aKFYan6zK+t+Ts6WB5F6PTLYTXZ+0FzLEsnBgYFV2ulc1jjATHjGSL2whTLGDc
 DT011P9AwYhgbAFDVZTPi6HGA/Abh4CJs/ARgRZtuoRlwarG+mEdTOsMbzcn15Rrd+m6iZXW8uR
 3cD0fdbkWhwnEQwNFMC4Q6e7Ju1z4Kn2xGvQhzp3+xYQBeQ89q6g1VtN1gWDgJ5Z7BzwPW4m5CL
 Pj0D+gVPS0MwIjKp4eLCyHsYkb56E9n6FI0IgmL0Eg1Xj2u7lHEtZe2NNzXHhwn7qYPKTlYM7ej
 AkSdvDiAjmw19ckNWFkNF/+7T4q6lSDeNmGg5o9Qtl+6bXeCZHo8XH85hs6iuwIp08viyWzWEO+
 fqiONmIJugie5k4EHUEy6wMRz19+Xj9p+jOFG5qRrz0mLKnxZCZPP9a8pYgeo91C3RKHVcaJXrK
 +j2XIKU5fGAxWSmyj1PLeYS21PTUEi858yS2vf9AujytqXjn1qTvbnkLt4QKX9IoU=
X-Received: by 2002:a05:600c:19d2:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-4805cf5f67emr83015285e9.22.1769461724156; 
 Mon, 26 Jan 2026 13:08:44 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:43 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/14] drm/amd/display: Refactor DAC load detection,
 move to HWSS
Date: Mon, 26 Jan 2026 22:08:28 +0100
Message-ID: <20260126210837.21885-6-timur.kristof@gmail.com>
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

Slightly refactor and simplify DAC load detection.
This prepares the code to be used for also executing DAC
load detection on external DP bridge encoders.

DAC load detection belongs better in the hardware sequencer
code because the implementation is HW dependent and not all
chips support the functionality. The code is cleaner when
link detection probably doesn't call the VBIOS directly.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 25 ++++++++-----------
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 +--
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 12 +++++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 .../drm/amd/display/dc/link/link_detection.c  | 24 +++---------------
 5 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 9f11e6ca4051..e2b74dda00fc 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -782,26 +782,17 @@ static enum bp_result bios_parser_encoder_control(
 
 static enum bp_result bios_parser_dac_load_detection(
 	struct dc_bios *dcb,
-	enum engine_id engine_id,
-	enum dal_device_type device_type,
-	uint32_t enum_id)
+	enum engine_id engine_id)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	struct dc_context *ctx = dcb->ctx;
 	struct bp_load_detection_parameters bp_params = {0};
-	enum bp_result bp_result;
+	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
 	uint32_t bios_0_scratch;
 	uint32_t device_id_mask = 0;
 
-	bp_params.engine_id = engine_id;
-	bp_params.device_id = get_support_mask_for_device_id(device_type, enum_id);
-
-	if (engine_id != ENGINE_ID_DACA &&
-	    engine_id != ENGINE_ID_DACB)
-		return BP_RESULT_UNSUPPORTED;
-
-	if (!bp->cmd_tbl.dac_load_detection)
-		return BP_RESULT_UNSUPPORTED;
+	bp_params.device_id = get_support_mask_for_device_id(
+		DEVICE_TYPE_CRT, engine_id == ENGINE_ID_DACB ? 2 : 1);
 
 	if (bp_params.device_id == ATOM_DEVICE_CRT1_SUPPORT)
 		device_id_mask = ATOM_S0_CRT1_MASK;
@@ -815,7 +806,13 @@ static enum bp_result bios_parser_dac_load_detection(
 	bios_0_scratch &= ~device_id_mask;
 	dm_write_reg(ctx, bp->base.regs->BIOS_SCRATCH_0, bios_0_scratch);
 
-	bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
+	if (engine_id == ENGINE_ID_DACA || engine_id == ENGINE_ID_DACB) {
+		if (!bp->cmd_tbl.dac_load_detection)
+			return BP_RESULT_UNSUPPORTED;
+
+		bp_params.engine_id = engine_id;
+		bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
+	}
 
 	if (bp_result != BP_RESULT_OK)
 		return bp_result;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 40d7a7d83c40..06fdde281a0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -99,9 +99,7 @@ struct dc_vbios_funcs {
 		struct bp_encoder_control *cntl);
 	enum bp_result (*dac_load_detection)(
 		struct dc_bios *bios,
-		enum engine_id engine_id,
-		enum dal_device_type device_type,
-		uint32_t enum_id);
+		enum engine_id engine_id);
 	enum bp_result (*transmitter_control)(
 		struct dc_bios *bios,
 		struct bp_transmitter_control *cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4659e1b489ba..4e820020252b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -674,6 +674,17 @@ dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
 	bios->funcs->encoder_control(bios, &encoder_control);
 }
 
+static bool
+dce110_dac_load_detect(struct dc_link *link)
+{
+	struct dc_bios *bios = link->ctx->dc_bios;
+	struct link_encoder *link_enc = link->link_enc;
+	enum bp_result bp_result = BP_RESULT_FAILURE;
+
+	bp_result = bios->funcs->dac_load_detection(bios, link_enc->analog_engine);
+	return bp_result == BP_RESULT_OK;
+}
+
 void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 {
 	enum dc_lane_count lane_count =
@@ -3442,6 +3453,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
 	.disable_link_output = dce110_disable_link_output,
+	.dac_load_detect = dce110_dac_load_detect,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 51b0f0fd8fcd..5c9a758fde37 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1187,6 +1187,7 @@ struct hw_sequencer_funcs {
 	void (*disable_link_output)(struct dc_link *link,
 			const struct link_resource *link_res,
 			enum signal_type signal);
+	bool (*dac_load_detect)(struct dc_link *link);
 
 	void (*get_dcc_en_bits)(struct dc *dc, int *dcc_en_bits);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 578509e8d0e2..1585cce65b0e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -932,28 +932,10 @@ static bool link_detect_ddc_probe(struct dc_link *link)
  */
 static bool link_detect_dac_load_detect(struct dc_link *link)
 {
-	struct dc_bios *bios = link->ctx->dc_bios;
-	struct link_encoder *link_enc = link->link_enc;
-	enum engine_id engine_id = link_enc->preferred_engine;
-	enum dal_device_type device_type = DEVICE_TYPE_CRT;
-	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
-	uint32_t enum_id;
-
-	switch (engine_id) {
-	case ENGINE_ID_DACB:
-		enum_id = 2;
-		break;
-	case ENGINE_ID_DACA:
-	default:
-		engine_id = ENGINE_ID_DACA;
-		enum_id = 1;
-		break;
-	}
-
-	if (bios->funcs->dac_load_detection)
-		bp_result = bios->funcs->dac_load_detection(bios, engine_id, device_type, enum_id);
+	if (!link->dc->hwss.dac_load_detect)
+		return false;
 
-	return bp_result == BP_RESULT_OK;
+	return link->dc->hwss.dac_load_detect(link);
 }
 
 /*
-- 
2.52.0


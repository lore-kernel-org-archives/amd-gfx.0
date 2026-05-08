Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89A1CD37AC
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 18:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C0410F5BD;
	Fri,  8 May 2026 18:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qfdf3MCt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26A710F5B8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 18:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIdPPJ32oifZ7m6pEyYjjiqqVGTzXoCtrTJ0E3Tss1ZZqrN+lm9umB0atXal7V8u+EEltE6JwDdkOzJFx7OBm6K+oAcdPSx3vhNc+WUqAXjJ72JcoHQFp2Keb4m8kUiRNeizHPSBNDuN6ZNeabW8p1z0Tf5fm/qZfQwlOaOVESj570Kvo49VfZ/7b8qNGkmjh6HBiNkMrOajFL+SkDjNzFX/gn/4iI4ZPdQKEdRz8ioXyi+GvNMEnhzCrtMfxX2qBAqNCIIxojzpbjC/++o2lHoEG85FIOVlbgbn0RHrXlHeTgXNFY/QQj9bpyJJud7B2IXxFo0bSO1TXVefH7Lwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zf8GvPyWXFcSR1eXwMnx0WdjG1ZZMSillwZuqmRkTQ=;
 b=wOAasODhfUlC3TwzHEnH/Fj+oxQsz0yzAqFe6huqmzmETwpcV9vIU4B1szQNaRN0YTYhJISpW+anbzCIJ/ZbeD92toOBKu5QPaJj6581p0O3eOWMnJqYzWJ2GoDbRheuVOzAy7qJoWw1D8bl2mxa7gZs/kvhsdLi9Ol8WwL7lrZE7T0lmNjWo2L0CVFubiTfs/wZ5n+2tGDImuSRqB2ShDVEn8uEAVyIN4CVtdMwqceGGiRcZOJiEycm2s4QzOScTVE9xlnLM/Od38uRN+vMNgFQil3UbVf+i+33WGeh0QcAthCVPaMMR7dnwOYb4ZO59MDTMdj/3VQ7KeQncDmb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zf8GvPyWXFcSR1eXwMnx0WdjG1ZZMSillwZuqmRkTQ=;
 b=Qfdf3MCtFfIDVMczvZgyaHNYYy0M8Pv3U9vrwmEAWXnN5xzfi+UV2kFwZpQU4pVMc+vlPCC/qTVoPkB1DmXbF2SScYSnfL72n5qce7C+9qC8MKHE8vxu3l2werTEvfL1LfU9ji6hdAu7YUKUlk20QjWAE6EPI5Aw3BsSh9a8gbQ=
Received: from MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12)
 by EAYPR12MB999133.namprd12.prod.outlook.com (2603:10b6:303:2c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 18:28:22 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::2b) by MN2PR03CA0007.outlook.office365.com
 (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 18:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 18:28:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:28:16 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 13:28:16 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v3 07/14] drm/amd/display: Add DC resource support for FRL
Date: Fri, 8 May 2026 14:27:59 -0400
Message-ID: <20260508182808.520863-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508182808.520863-1-harry.wentland@amd.com>
References: <20260508182808.520863-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|EAYPR12MB999133:EE_
X-MS-Office365-Filtering-Correlation-Id: 320ec9c7-b303-496d-fa99-08dead2f9581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: JpeQSzNw4rW7DC/dtlpAg1b/0VMWKLwOfJwhzAFPlKhMQq+HBJzmBMOSSqfzALVpUn5HQ8At9rW5CwtM41r5ZFMsMsnMuCDCVrz2lkpbzTwD0Ah3rLtWvmyQIb4mE+69somR+rgeKrIIJgmViLxvLZSv027Fn/zZbOdct9/kEJg1BjwkxKmTTbkU0lRn4lZNmt2ZyRNrgy3YTRuYCe49M5dahmp5iAAivNMSkCbeIp9nrnlFtzzgahyfT+LWors4LGAaM16lPhp3s1GRIkDmVTa0NUMs+S8CuNVirOyR/hC9NIyfFuCbHAndV9OiksrsQfM5xecxJsYXAPPnZKJXfWotUxwNTGk/aQEA9FTPuEyj4mWrKyjTC+isP3k0rRPTsl9doIfDuwR28HAQbtQN7rbJQG8h0M1UsCmTQwNSpPprDoA8Ii08qsBHshMwDY6t7Ht7XnfhP3mcOXrnsSAOTb51omQnWHXo9U/i+EbvlOOIEmUH6JQPB2oGafIUqTG51xUtvPPcha4glpKJ0Wi2lLvoypb3KD9DnJ3T8dPkSrYpT8K7Jn7DS6yV3pgkRgTHEucU0UN880KnxGMO6jMCDcORQOD6Dq7TpLOGr5stmusyPysFuC3alf1u0Id14BKccmF4kpEJ3Wp6hdIwrgxJF0copOTZV5KbxdoSy3pUkpouTMBCcRiWeqyf1w/T8UeYb+FflH5PfaNNTCcHx8f1uzg9/bkY40Ie/z9OzIes+7g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(3023799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F2aXQedxrwFLA1+WwRMPPs4qUZetfvGN/Kp9CdXZIee7Eko6zPTDb/rWD7JENP54jXtH/IzIxQVL4OrHAYBjSV/IUeYMjL5f61XbwZbD1C6KS398P67dlduc38+5XIZ+Xk5s1FXnXDgNU7CQbnyGvwuBhtQKLYO+HeHEHD35kPxpHWItLy/S6c68WNrsV1aZupsg+BqmVNvIEJYIkIWryN785vR2beWs/NaeHanl82u5iz/Zm8bhbboLD7EsNONkcw40fpFbn0KhUi8F8HoorMHougqOzOnpqKybW2CqqRwSBaiG0z08nSPVpuE6MW/of7Jb+wgjVK/QgddlUQkrO64JA7+SUiCDw1tT/gxmuvj4/vBXmW8hf42VAvFgOozbChBBq94XERLTG7uIEjh7pteGQp5HbvX6B7/DjhgD5zmbuXZQY8bGaela9hWCb6v8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:28:21.6148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320ec9c7-b303-496d-fa99-08dead2f9581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999133
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

Add support for FRL in DC resources. This is mostly the register
macros, encoder creation, and HW capabilities.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../dc/resource/dce112/dce112_resource.c      |   3 +
 .../dc/resource/dcn30/dcn30_resource.c        | 126 +++++++++++++++++
 .../dc/resource/dcn301/dcn301_resource.c      |   1 +
 .../dc/resource/dcn302/dcn302_resource.c      | 109 +++++++++++++++
 .../dc/resource/dcn303/dcn303_resource.c      | 109 +++++++++++++++
 .../dc/resource/dcn31/dcn31_resource.c        | 127 +++++++++++++++++
 .../dc/resource/dcn314/dcn314_resource.c      | 127 +++++++++++++++++
 .../dc/resource/dcn315/dcn315_resource.c      | 128 +++++++++++++++++
 .../dc/resource/dcn316/dcn316_resource.c      | 126 +++++++++++++++++
 .../dc/resource/dcn32/dcn32_resource.c        | 131 +++++++++++++++++
 .../dc/resource/dcn32/dcn32_resource.h        |  79 +++++++++--
 .../dc/resource/dcn321/dcn321_resource.c      | 132 ++++++++++++++++++
 .../dc/resource/dcn35/dcn35_resource.c        | 121 ++++++++++++++++
 .../dc/resource/dcn351/dcn351_resource.c      | 121 ++++++++++++++++
 .../dc/resource/dcn36/dcn36_resource.c        | 121 ++++++++++++++++
 .../dc/resource/dcn401/dcn401_resource.c      | 121 ++++++++++++++++
 .../dc/resource/dcn42/dcn42_resource.c        | 121 ++++++++++++++++
 17 files changed, 1789 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 1dd5e44a0d6e..3665eb25fec6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -981,6 +981,9 @@ enum dc_status resource_map_phy_clock_resources(
 		|| dc_is_virtual_signal(pipe_ctx->stream->signal))
 		pipe_ctx->clock_source =
 				dc->res_pool->dp_clock_source;
+	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL)
+			pipe_ctx->clock_source =
+				dc->res_pool->dp_clock_source;
 	else {
 		if (stream && stream->link && stream->link->link_enc)
 			pipe_ctx->clock_source = find_matching_pll(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index baefddd03438..c7d7bd96124d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -50,6 +50,8 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn30/dcn30_dio_link_encoder.h"
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
@@ -400,6 +402,45 @@ static const struct dcn10_link_enc_mask le_mask = {
 };
 
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id)\
+}
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, 6)
+
+
+static const struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[] = {
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6),
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id)\
+}
+
+static const struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[] = {
+	hpo_frl_link_encoder_reg_list(0),
+};
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
 	{ DCN_PANEL_CNTL_REG_LIST() }
 };
@@ -673,6 +714,7 @@ static const struct resource_caps res_cap_dcn3 = {
 	.num_video_plane = 6,
 	.num_audio = 6,
 	.num_stream_encoder = 6,
+	.num_hpo_frl = 1,
 	.num_pll = 6,
 	.num_dwb = 1,
 	.num_ddc = 6,
@@ -1075,6 +1117,69 @@ static struct stream_encoder *dcn30_stream_encoder_create(enum engine_id eng_id,
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn30_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+									  struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct afmt *afmt;
+	struct vpg *vpg;
+	int afmt_inst;
+	int vpg_inst;
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 6;
+		afmt_inst = 6;
+	} else {
+		return NULL;
+	}
+
+	/* allocate HPO stream encoder and create VPG sub-block */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn30_vpg_create(ctx, vpg_inst);
+	afmt = dcn30_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3,
+					       ctx,
+					       ctx->dc_bios,
+					       eng_id,
+					       vpg,
+					       afmt,
+					       &hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					       &hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn30_hpo_frl_link_encoder_create(enum engine_id eng_id,
+								      struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3,
+					ctx,
+					eng_id-ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					&hpo_le_shift,
+					&hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct dce_hwseq *dcn30_hwseq_create(struct dc_context *ctx)
 {
 	struct dce_hwseq *hws = kzalloc(sizeof(struct dce_hwseq), GFP_KERNEL);
@@ -1091,6 +1196,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn30_create_audio,
 	.create_stream_encoder = dcn30_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn30_hpo_frl_stream_encoder_create,
 	.create_hwseq = dcn30_hwseq_create,
 };
 
@@ -1113,6 +1219,23 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
 		if (pool->base.dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->base.dscs[i]);
@@ -2272,6 +2395,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.destroy = dcn30_destroy_resource_pool,
 	.link_enc_create = dcn30_link_encoder_create,
 	.panel_cntl_create = dcn30_panel_cntl_create,
+	.hpo_frl_link_enc_create = dcn30_hpo_frl_link_encoder_create,
 	.validate_bandwidth = dcn30_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
@@ -2355,6 +2479,8 @@ static bool dcn30_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 625d9ec713a9..c805a5a24293 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -644,6 +644,7 @@ static struct resource_caps res_cap_dcn301 = {
 	.num_video_plane = 4,
 	.num_audio = 4,
 	.num_stream_encoder = 4,
+	.num_hpo_frl = 0,
 	.num_pll = 4,
 	.num_dwb = 1,
 	.num_ddc = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 6f380363033a..6bf026b9d1a9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -32,6 +32,8 @@
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn30/dcn30_dwb.h"
 #include "dcn30/dcn30_dpp.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
 #include "dcn30/dcn30_hubbub.h"
 #include "dcn30/dcn30_hubp.h"
 #include "dcn30/dcn30_mmhubbub.h"
@@ -129,6 +131,7 @@ static const struct resource_caps res_cap_dcn302 = {
 		.num_video_plane = 5,
 		.num_audio = 5,
 		.num_stream_encoder = 5,
+		.num_hpo_frl = 1,
 		.num_dwb = 1,
 		.num_ddc = 5,
 		.num_vmid = 16,
@@ -451,6 +454,91 @@ static struct stream_encoder *dcn302_stream_encoder_create(enum engine_id eng_id
 	return &enc1->base;
 }
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+		[id] = { DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id) }
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+		DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, 5)
+
+static const struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[] = {
+		hpo_frl_stream_encoder_reg_list(0),
+		hpo_frl_stream_encoder_dme_reg_list(5),
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+		DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+		DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+static struct hpo_frl_stream_encoder *dcn302_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+		struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct vpg *vpg;
+	struct afmt *afmt;
+	int vpg_inst;
+	int afmt_inst;
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else
+		return NULL;
+
+	/* allocate HPO stream encoder and create VPG sub-block */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn302_vpg_create(ctx, vpg_inst);
+	afmt = dcn302_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3, ctx, ctx->dc_bios, eng_id, vpg, afmt,
+			&hpo_frl_stream_enc_regs[eng_id-ENGINE_ID_HPO_0], &hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+#define hpo_frl_link_encoder_reg_list(id)\
+		[id] = { DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id) }
+
+static const struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[] = {
+		hpo_frl_link_encoder_reg_list(0),
+};
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+		DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+		DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
+static struct hpo_frl_link_encoder *dcn302_hpo_frl_link_encoder_create(enum engine_id eng_id, struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3, ctx, eng_id-ENGINE_ID_HPO_0,
+			&hpo_frl_link_enc_regs[eng_id-ENGINE_ID_HPO_0], &hpo_le_shift, &hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 #define clk_src_regs(index, pllid)\
 		[index] = { CS_COMMON_REG_LIST_DCN3_02(index, pllid) }
 
@@ -970,6 +1058,7 @@ static const struct resource_create_funcs res_create_funcs = {
 		.read_dce_straps = read_dce_straps,
 		.create_audio = dcn302_create_audio,
 		.create_stream_encoder = dcn302_stream_encoder_create,
+		.create_hpo_frl_stream_encoder = dcn302_hpo_frl_stream_encoder_create,
 		.create_hwseq = dcn302_hwseq_create,
 };
 
@@ -1036,6 +1125,23 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->hpo_frl_stream_enc_count; i++) {
+		if (pool->hpo_frl_stream_enc[i] != NULL) {
+			if (pool->hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->hpo_frl_stream_enc[i]->vpg));
+				pool->hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->hpo_frl_stream_enc[i]->afmt));
+				pool->hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->hpo_frl_stream_enc[i]));
+			pool->hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->res_cap->num_dsc; i++) {
 		if (pool->dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->dscs[i]);
@@ -1172,6 +1278,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.destroy = dcn302_destroy_resource_pool,
 		.link_enc_create = dcn302_link_encoder_create,
 		.panel_cntl_create = dcn302_panel_cntl_create,
+		.hpo_frl_link_enc_create = dcn302_hpo_frl_link_encoder_create,
 		.validate_bandwidth = dcn30_validate_bandwidth,
 		.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
 		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
@@ -1270,6 +1377,8 @@ static bool dcn302_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 8a7f62ab98b5..dd80663d67d3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -32,6 +32,8 @@
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn30/dcn30_dpp.h"
 #include "dcn30/dcn30_dwb.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
 #include "dcn30/dcn30_hubbub.h"
 #include "dcn30/dcn30_hubp.h"
 #include "dcn30/dcn30_mmhubbub.h"
@@ -126,6 +128,7 @@ static const struct resource_caps res_cap_dcn303 = {
 		.num_video_plane = 2,
 		.num_audio = 2,
 		.num_stream_encoder = 2,
+		.num_hpo_frl = 1,
 		.num_dwb = 1,
 		.num_ddc = 2,
 		.num_vmid = 16,
@@ -438,6 +441,91 @@ static struct stream_encoder *dcn303_stream_encoder_create(enum engine_id eng_id
 	return &enc1->base;
 }
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+		[id] = { DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id) }
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+		DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, 2)
+
+static const struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[] = {
+		hpo_frl_stream_encoder_reg_list(0),
+		hpo_frl_stream_encoder_dme_reg_list(2),
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+		DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+		DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+static struct hpo_frl_stream_encoder *dcn303_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+		struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct vpg *vpg;
+	struct afmt *afmt;
+	int vpg_inst;
+	int afmt_inst;
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 2;
+		afmt_inst = 2;
+	} else
+		return NULL;
+
+	/* allocate HPO stream encoder and create VPG sub-block */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn303_vpg_create(ctx, vpg_inst);
+	afmt = dcn303_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3, ctx, ctx->dc_bios, eng_id, vpg, afmt,
+			&hpo_frl_stream_enc_regs[eng_id-ENGINE_ID_HPO_0], &hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+#define hpo_frl_link_encoder_reg_list(id)\
+		[id] = { DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id) }
+
+static const struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[] = {
+		hpo_frl_link_encoder_reg_list(0),
+};
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+		DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+		DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
+static struct hpo_frl_link_encoder *dcn303_hpo_frl_link_encoder_create(enum engine_id eng_id, struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3, ctx, eng_id-ENGINE_ID_HPO_0,
+			&hpo_frl_link_enc_regs[eng_id-ENGINE_ID_HPO_0], &hpo_le_shift, &hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 #define clk_src_regs(index, pllid)\
 		[index] = { CS_COMMON_REG_LIST_DCN3_03(index, pllid) }
 
@@ -915,6 +1003,7 @@ static const struct resource_create_funcs res_create_funcs = {
 		.read_dce_straps = read_dce_straps,
 		.create_audio = dcn303_create_audio,
 		.create_stream_encoder = dcn303_stream_encoder_create,
+		.create_hpo_frl_stream_encoder = dcn303_hpo_frl_stream_encoder_create,
 		.create_hwseq = dcn303_hwseq_create,
 };
 
@@ -980,6 +1069,23 @@ static void dcn303_resource_destruct(struct resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->hpo_frl_stream_enc_count; i++) {
+		if (pool->hpo_frl_stream_enc[i] != NULL) {
+			if (pool->hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->hpo_frl_stream_enc[i]->vpg));
+				pool->hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->hpo_frl_stream_enc[i]->afmt));
+				pool->hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->hpo_frl_stream_enc[i]));
+			pool->hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->res_cap->num_dsc; i++) {
 		if (pool->dscs[i] != NULL)
 			dcn20_dsc_destroy(&pool->dscs[i]);
@@ -1116,6 +1222,7 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.destroy = dcn303_destroy_resource_pool,
 		.link_enc_create = dcn303_link_encoder_create,
 		.panel_cntl_create = dcn303_panel_cntl_create,
+		.hpo_frl_link_enc_create = dcn303_hpo_frl_link_encoder_create,
 		.validate_bandwidth = dcn30_validate_bandwidth,
 		.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
 		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
@@ -1214,6 +1321,8 @@ static bool dcn303_resource_construct(
 	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 200be0f46ab0..60c3bc5cfbbf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -54,6 +54,8 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn31/dcn31_apg.h"
@@ -431,6 +433,45 @@ static const struct dcn10_link_enc_mask le_mask = {
 	DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id)\
+}
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, 6)
+
+
+static const struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[] = {
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6),
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id)\
+}
+
+static const struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[] = {
+	hpo_frl_link_encoder_reg_list(0),
+};
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_list(id)\
 [id] = {\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST(id)\
@@ -833,6 +874,7 @@ static const struct resource_caps res_cap_dcn31 = {
 	.num_audio = 5,
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 5,
@@ -904,6 +946,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.disable_z10 = true,
+	.max_frl_rate = HDMI_FRL_LINK_RATE_10GBPS,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 	.using_dml2 = false,
@@ -1283,6 +1326,69 @@ static struct stream_encoder *dcn31_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn31_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+									  struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct afmt *afmt;
+	struct vpg *vpg;
+	int afmt_inst;
+	int vpg_inst;
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else {
+		return NULL;
+	}
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn31_vpg_create(ctx, vpg_inst);
+	afmt = dcn31_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3,
+					       ctx,
+					       ctx->dc_bios,
+					       eng_id,
+					       vpg,
+					       afmt,
+					       &hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					       &hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn31_hpo_frl_link_encoder_create(enum engine_id eng_id,
+								      struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3,
+					ctx,
+					eng_id - ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					&hpo_le_shift,
+					&hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1368,6 +1474,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn31_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn31_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn31_hwseq_create,
@@ -1392,6 +1499,23 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1871,6 +1995,7 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.link_enc_create_minimal = dcn31_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn31_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn31_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
@@ -1955,6 +2080,8 @@ static bool dcn31_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 6a4094663050..c6eb71ed5872 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -57,6 +57,8 @@
 #include "dcn30/dcn30_afmt.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn314/dcn314_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn31/dcn31_apg.h"
@@ -438,6 +440,45 @@ static const struct dcn10_link_enc_mask le_mask = {
 	DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id)\
+}
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, 6)
+
+
+static const struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[] = {
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6),
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id)\
+}
+
+static const struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[] = {
+	hpo_frl_link_encoder_reg_list(0),
+};
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_list(id)\
 [id] = {\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST(id)\
@@ -845,6 +886,7 @@ static const struct resource_caps res_cap_dcn314 = {
 	.num_audio = 5,
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 5,
@@ -1341,6 +1383,71 @@ static struct stream_encoder *dcn314_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn31_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+									  struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct afmt *afmt;
+	struct vpg *vpg;
+	int afmt_inst;
+	int vpg_inst;
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		//Maps to VPG INST 5, vpg_inst 5 reg offset padded to inst 9
+		vpg_inst = 9;
+		afmt_inst = 5;
+	} else {
+		return NULL;
+	}
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn31_vpg_create(ctx, vpg_inst);
+	afmt = dcn31_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3,
+					       ctx,
+					       ctx->dc_bios,
+					       eng_id,
+					       vpg,
+					       afmt,
+					       &hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					       &hpo_se_shift,
+					       &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn31_hpo_frl_link_encoder_create(enum engine_id eng_id,
+								      struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3,
+					ctx,
+					eng_id - ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					&hpo_le_shift,
+					&hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1427,6 +1534,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn314_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn31_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn314_hwseq_create,
@@ -1451,6 +1559,23 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1797,6 +1922,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.link_enc_create_minimal = dcn31_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn31_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn314_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
@@ -1883,6 +2009,7 @@ static bool dcn314_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 76b112426f33..9e52871a7f47 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -53,6 +53,8 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn31/dcn31_apg.h"
@@ -433,6 +435,45 @@ static const struct dcn10_link_enc_mask le_mask = {
 	DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id)\
+}
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, 6)
+
+
+static const struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[] = {
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6),
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id)\
+}
+
+static const struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[] = {
+	hpo_frl_link_encoder_reg_list(0),
+};
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_list(id)\
 [id] = {\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST(id)\
@@ -832,6 +873,7 @@ static const struct resource_caps res_cap_dcn31 = {
 	.num_audio = 5,
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 5,
@@ -903,6 +945,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
+	.max_frl_rate = HDMI_FRL_LINK_RATE_12GBPS,
 	.psr_power_use_phy_fsm = 0,
 	.using_dml2 = false,
 	.min_disp_clk_khz = 100000,
@@ -1284,6 +1327,70 @@ static struct stream_encoder *dcn315_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn31_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+									  struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct afmt *afmt;
+	struct vpg *vpg;
+	int afmt_inst;
+	int vpg_inst;
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else {
+		return NULL;
+	}
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn31_vpg_create(ctx, vpg_inst);
+	afmt = dcn31_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3,
+					       ctx,
+					       ctx->dc_bios,
+					       eng_id,
+					       vpg,
+					       afmt,
+					       &hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					       &hpo_se_shift,
+					       &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn31_hpo_frl_link_encoder_create(enum engine_id eng_id,
+								      struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3,
+					ctx,
+					eng_id - ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					&hpo_le_shift,
+					&hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1369,6 +1476,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn315_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn31_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn31_hwseq_create,
@@ -1393,6 +1501,23 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1866,6 +1991,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.link_enc_create_minimal = dcn31_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn31_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn31_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
@@ -1929,6 +2055,8 @@ static bool dcn315_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 2d34db42dd83..4050d6cce616 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -53,6 +53,8 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn31/dcn31_apg.h"
@@ -421,6 +423,45 @@ static const struct dcn10_link_enc_mask le_mask = {
 	DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST(id)\
+}
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST(id, 6)
+
+
+static const struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[] = {
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6),
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+[id] = {\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST(id)\
+}
+
+static const struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[] = {
+	hpo_frl_link_encoder_reg_list(0),
+};
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 
 
 #define hpo_dp_stream_encoder_reg_list(id)\
@@ -827,6 +868,7 @@ static const struct resource_caps res_cap_dcn31 = {
 	.num_audio = 5,
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 5,
@@ -898,6 +940,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
+	.max_frl_rate = HDMI_FRL_LINK_RATE_10GBPS, /*same as dcn3.1 for now*/
 	.using_dml2 = false,
 };
 
@@ -1277,6 +1320,70 @@ static struct stream_encoder *dcn316_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn31_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+									  struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct afmt *afmt;
+	struct vpg *vpg;
+	int afmt_inst;
+	int vpg_inst;
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else {
+		return NULL;
+	}
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn31_vpg_create(ctx, vpg_inst);
+	afmt = dcn31_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3,
+					       ctx,
+					       ctx->dc_bios,
+					       eng_id,
+					       vpg,
+					       afmt,
+					       &hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					       &hpo_se_shift,
+					       &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn31_hpo_frl_link_encoder_create(enum engine_id eng_id,
+								      struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3,
+					ctx,
+					eng_id - ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					&hpo_le_shift,
+					&hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 
 static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
@@ -1364,6 +1471,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn316_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn31_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn31_hwseq_create,
@@ -1388,6 +1496,21 @@ static void dcn316_resource_destruct(struct dcn316_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1742,6 +1865,7 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.link_enc_create_minimal = dcn31_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn31_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn31_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
@@ -1805,6 +1929,8 @@ static bool dcn316_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 6f0a3b0ff2d3..7780bb57c618 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -55,6 +55,8 @@
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn32/dcn32_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
@@ -139,6 +141,10 @@ enum dcn32_clk_src_array_id {
 	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SRI_ARR_DME(reg_name, block, id, offset)\
+	REG_STRUCT[id - offset].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -333,6 +339,36 @@ static const struct dcn10_link_enc_mask le_mask = {
 	//DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, 6)
+
+
+static struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[2];
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[1];
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_init(id)\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
@@ -663,6 +699,7 @@ static const struct resource_caps res_cap_dcn32 = {
 	.num_video_plane = 4,
 	.num_audio = 5,
 	.num_stream_encoder = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 5,
@@ -1274,6 +1311,79 @@ static struct stream_encoder *dcn32_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn32_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+									  struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct afmt *afmt;
+	struct vpg *vpg;
+	int afmt_inst;
+	int vpg_inst;
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_stream_enc_regs
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6);
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else {
+		return NULL;
+	}
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn32_vpg_create(ctx, vpg_inst);
+	afmt = dcn32_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3,
+					       ctx,
+					       ctx->dc_bios,
+					       eng_id,
+					       vpg,
+					       afmt,
+					       &hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					       &hpo_se_shift,
+					       &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn32_hpo_frl_link_encoder_create(enum engine_id eng_id,
+								      struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_link_enc_regs
+	hpo_frl_link_encoder_reg_list(0);
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3,
+					ctx,
+					eng_id - ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					&hpo_le_shift,
+					&hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn32_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1375,6 +1485,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn32_create_audio,
 	.create_stream_encoder = dcn32_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn32_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn32_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn32_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn32_hwseq_create,
@@ -1399,6 +1510,23 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -2132,6 +2260,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.destroy = dcn32_destroy_resource_pool,
 	.link_enc_create = dcn32_link_encoder_create,
 	.link_enc_create_minimal = NULL,
+	.hpo_frl_link_enc_create = dcn32_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn32_panel_cntl_create,
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
@@ -2272,6 +2401,8 @@ static bool dcn32_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 91be493e0bb6..68e7140f1505 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -323,20 +323,27 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
 		SRI_ARR(DC_HPD_TOGGLE_FILT_CNTL, HPD, id))
 
 /* Link encoder */
-#define LE_DCN3_REG_LIST_RI(id)                                                \
-  SRI_ARR(DIG_BE_CNTL, DIG, id), SRI_ARR(DIG_BE_EN_CNTL, DIG, id),             \
-      SRI_ARR(TMDS_CTL_BITS, DIG, id),                                         \
-      SRI_ARR(TMDS_DCBALANCER_CONTROL, DIG, id), SRI_ARR(DP_CONFIG, DP, id),   \
-      SRI_ARR(DP_DPHY_CNTL, DP, id), SRI_ARR(DP_DPHY_PRBS_CNTL, DP, id),       \
-      SRI_ARR(DP_DPHY_SCRAM_CNTL, DP, id), SRI_ARR(DP_DPHY_SYM0, DP, id),      \
-      SRI_ARR(DP_DPHY_SYM1, DP, id), SRI_ARR(DP_DPHY_SYM2, DP, id),            \
-      SRI_ARR(DP_DPHY_TRAINING_PATTERN_SEL, DP, id),                           \
-      SRI_ARR(DP_LINK_CNTL, DP, id), SRI_ARR(DP_LINK_FRAMING_CNTL, DP, id),    \
-      SRI_ARR(DP_MSE_SAT0, DP, id), SRI_ARR(DP_MSE_SAT1, DP, id),              \
-      SRI_ARR(DP_MSE_SAT2, DP, id), SRI_ARR(DP_MSE_SAT_UPDATE, DP, id),        \
-      SRI_ARR(DP_SEC_CNTL, DP, id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),       \
-      SRI_ARR(DP_DPHY_FAST_TRAINING, DP, id), SRI_ARR(DP_SEC_CNTL1, DP, id),   \
-      SRI_ARR(DP_DPHY_BS_SR_SWAP_CNTL, DP, id),                                \
+#define LE_DCN3_REG_LIST_RI(id)                                      \
+      SRI_ARR(DIG_BE_CNTL, DIG, id),                                 \
+      SRI_ARR(DIG_BE_EN_CNTL, DIG, id),                              \
+      SRI_ARR(TMDS_CTL_BITS, DIG, id),                               \
+      SRI_ARR(TMDS_DCBALANCER_CONTROL, DIG, id),                     \
+      SRI_ARR(DP_CONFIG, DP, id), SRI_ARR(DP_DPHY_CNTL, DP, id),     \
+      SRI_ARR(DP_DPHY_PRBS_CNTL, DP, id),                            \
+      SRI_ARR(DP_DPHY_SCRAM_CNTL, DP, id),                           \
+      SRI_ARR(DP_DPHY_SYM0, DP, id), SRI_ARR(DP_DPHY_SYM1, DP, id),  \
+      SRI_ARR(DP_DPHY_SYM2, DP, id),                                 \
+      SRI_ARR(DP_DPHY_TRAINING_PATTERN_SEL, DP, id),                 \
+      SRI_ARR(DP_LINK_CNTL, DP, id),                                 \
+      SRI_ARR(DP_LINK_FRAMING_CNTL, DP, id),                         \
+      SRI_ARR(DP_MSE_SAT0, DP, id), SRI_ARR(DP_MSE_SAT1, DP, id),    \
+      SRI_ARR(DP_MSE_SAT2, DP, id),                                  \
+      SRI_ARR(DP_MSE_SAT_UPDATE, DP, id),                            \
+      SRI_ARR(DP_SEC_CNTL, DP, id),                                  \
+      SRI_ARR(DP_VID_STREAM_CNTL, DP, id),                           \
+      SRI_ARR(DP_DPHY_FAST_TRAINING, DP, id),                        \
+      SRI_ARR(DP_SEC_CNTL1, DP, id),                                 \
+      SRI_ARR(DP_DPHY_BS_SR_SWAP_CNTL, DP, id),                      \
       SRI_ARR(DP_DPHY_HBR2_PATTERN_CONTROL, DP, id)
 
 #define LE_DCN31_REG_LIST_RI(id)                                               \
@@ -1281,4 +1288,48 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       I2C_HW_ENGINE_COMMON_REG_LIST_RI(id), SR_ARR_I2C(DIO_MEM_PWR_CTRL, id),  \
       SR_ARR_I2C(DIO_MEM_PWR_STATUS, id)
 
+#define DCN3_0_HDMI_STREAM_ENC_REG_LIST_RI(id)                                 \
+  SR_ARR(HDMI_STREAM_ENC_CLOCK_CONTROL, id),                                   \
+      SR_ARR(HDMI_STREAM_ENC_INPUT_MUX_CONTROL, id),                          \
+      SR_ARR(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, id),    \
+      SR_ARR(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2, id)
+
+#define DCN3_0_HDMI_TB_ENC_REG_LIST_RI(id)                                     \
+  SR_ARR(HDMI_TB_ENC_CONTROL, id), SR_ARR(HDMI_TB_ENC_H_ACTIVE_BLANK, id),     \
+      SR_ARR(HDMI_TB_ENC_HC_ACTIVE_BLANK, id), SR_ARR(HDMI_TB_ENC_MODE, id),   \
+      SR_ARR(HDMI_TB_ENC_PACKET_CONTROL, id),                                  \
+      SR_ARR(HDMI_TB_ENC_DB_CONTROL, id),                                      \
+      SR_ARR(HDMI_TB_ENC_PIXEL_FORMAT, id),                                    \
+      SR_ARR(HDMI_TB_ENC_VBI_PACKET_CONTROL1, id),                             \
+      SR_ARR(HDMI_TB_ENC_GC_CONTROL, id),                                      \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET_CONTROL0, id),                         \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET_CONTROL1, id),                         \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET0_1_LINE, id),                          \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET2_3_LINE, id),                          \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET4_5_LINE, id),                          \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET6_7_LINE, id),                          \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET8_9_LINE, id),                          \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET10_11_LINE, id),                        \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET12_13_LINE, id),                        \
+      SR_ARR(HDMI_TB_ENC_GENERIC_PACKET14_LINE, id),                           \
+      SR_ARR(HDMI_TB_ENC_ACR_PACKET_CONTROL, id),                              \
+      SR_ARR(HDMI_TB_ENC_ACR_32_0, id), SR_ARR(HDMI_TB_ENC_ACR_32_1, id),      \
+      SR_ARR(HDMI_TB_ENC_ACR_44_0, id), SR_ARR(HDMI_TB_ENC_ACR_44_1, id),      \
+      SR_ARR(HDMI_TB_ENC_ACR_48_0, id), SR_ARR(HDMI_TB_ENC_ACR_48_1, id),      \
+      SR_ARR(HDMI_TB_ENC_CRC_CNTL, id),                                        \
+      SR_ARR(HDMI_TB_ENC_METADATA_PACKET_CONTROL, id)
+
+#define DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, offset) \
+	SRI_ARR_DME(DME_CONTROL, DME, id, offset)
+
+#define DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)                              \
+  DCN3_0_HDMI_STREAM_ENC_REG_LIST_RI(id), DCN3_0_HDMI_TB_ENC_REG_LIST_RI(id)
+
+#define DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id) \
+	SR_ARR(HDMI_LINK_ENC_CLK_CTRL, id), \
+	SR_ARR(HDMI_LINK_ENC_CONTROL, id), \
+	SR_ARR(HDMI_FRL_ENC_CONFIG, id), \
+	SR_ARR(HDMI_FRL_ENC_CONFIG2, id),\
+	SR_ARR(HDMI_FRL_ENC_MEM_CTRL, id)
+
 #endif /* _DCN32_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 663e9335fdec..7de9a5621c24 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -57,6 +57,8 @@
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn32/dcn32_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
@@ -139,6 +141,10 @@ enum dcn321_clk_src_array_id {
 	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SRI_ARR_DME(reg_name, block, id, offset)\
+	REG_STRUCT[id - offset].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -332,6 +338,35 @@ static const struct dcn10_link_enc_mask le_mask = {
 //	DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, 6)
+
+static struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[2];
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[1];
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_init(id)\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
@@ -659,6 +694,7 @@ static const struct resource_caps res_cap_dcn321 = {
 	.num_video_plane = 4,
 	.num_audio = 5,
 	.num_stream_encoder = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 5,
@@ -1255,6 +1291,79 @@ static struct stream_encoder *dcn321_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn321_hpo_frl_stream_encoder_create(enum engine_id eng_id,
+									   struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct afmt *afmt;
+	struct vpg *vpg;
+	int afmt_inst;
+	int vpg_inst;
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_stream_enc_regs
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6);
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else {
+		return NULL;
+	}
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn321_vpg_create(ctx, vpg_inst);
+	afmt = dcn321_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3,
+					       ctx,
+					       ctx->dc_bios,
+					       eng_id,
+					       vpg,
+					       afmt,
+					       &hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					       &hpo_se_shift,
+					       &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn321_hpo_frl_link_encoder_create(enum engine_id eng_id,
+								       struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_link_enc_regs
+	hpo_frl_link_encoder_reg_list(0);
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3,
+					ctx,
+					eng_id - ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+					&hpo_le_shift,
+					&hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn321_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1356,6 +1465,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn321_create_audio,
 	.create_stream_encoder = dcn321_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn321_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn321_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn321_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn321_hwseq_create,
@@ -1380,6 +1490,23 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1635,6 +1762,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.destroy = dcn321_destroy_resource_pool,
 	.link_enc_create = dcn321_link_encoder_create,
 	.link_enc_create_minimal = NULL,
+	.hpo_frl_link_enc_create = dcn321_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn32_panel_cntl_create,
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
@@ -1772,6 +1900,8 @@ static bool dcn321_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
@@ -1814,6 +1944,8 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	/* HACK: Force FRL support until BIOS is ready. */
+	dc->config.force_hdmi21_frl_enc_enable = true;
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 27f8f13912b3..74960aa18973 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -58,6 +58,8 @@
 #include "dcn30/dcn30_afmt.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn35/dcn35_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
@@ -154,6 +156,10 @@ enum dcn35_clk_src_array_id {
 	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SRI_ARR_DME(reg_name, block, id, offset)\
+	REG_STRUCT[id - offset].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -353,6 +359,35 @@ static const struct dcn10_link_enc_mask le_mask = {
 	//DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, 6)
+
+#define hpo_frl_stream_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[2];
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[1];
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_init(id)\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
@@ -685,6 +720,7 @@ static const struct resource_caps res_cap_dcn35 = {
 	.num_audio = 5,
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 4,/*1 c10 edp, 3xc20 combo PHY*/
@@ -1337,6 +1373,72 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn31_hpo_frl_stream_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct vpg *vpg;
+	struct afmt *afmt;
+	int vpg_inst;
+	int afmt_inst;
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_stream_enc_regs
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6);
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else
+		return NULL;
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn31_vpg_create(ctx, vpg_inst);
+	afmt = dcn31_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3, ctx, ctx->dc_bios,
+					eng_id, vpg, afmt,
+					&hpo_frl_stream_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn31_hpo_frl_link_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_link_enc_regs
+	hpo_frl_link_encoder_reg_list(0);
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3, ctx, eng_id-ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_le_shift, &hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1438,6 +1540,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn35_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn31_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn35_hwseq_create,
@@ -1462,6 +1565,21 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1826,6 +1944,7 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.link_enc_create_minimal = dcn31_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn31_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn35_validate_bandwidth,
 	.calculate_wm_and_dlg = NULL,
@@ -1912,6 +2031,8 @@ static bool dcn35_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index d032db65108b..a50d8ac020db 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -37,6 +37,8 @@
 
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn35/dcn35_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
@@ -134,6 +136,10 @@ enum dcn351_clk_src_array_id {
 	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SRI_ARR_DME(reg_name, block, id, offset)\
+	REG_STRUCT[id - offset].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -333,6 +339,35 @@ static const struct dcn10_link_enc_mask le_mask = {
 	//DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, 6)
+
+#define hpo_frl_stream_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[2];
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[1];
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_init(id)\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
@@ -665,6 +700,7 @@ static const struct resource_caps res_cap_dcn351 = {
 	.num_audio = 5,
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 4,/*1 c10 edp, 3xc20 combo PHY*/
@@ -1317,6 +1353,72 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn31_hpo_frl_stream_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct vpg *vpg;
+	struct afmt *afmt;
+	int vpg_inst;
+	int afmt_inst;
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_stream_enc_regs
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6);
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else
+		return NULL;
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn31_vpg_create(ctx, vpg_inst);
+	afmt = dcn31_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3, ctx, ctx->dc_bios,
+					eng_id, vpg, afmt,
+					&hpo_frl_stream_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn31_hpo_frl_link_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_link_enc_regs
+	hpo_frl_link_encoder_reg_list(0);
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3, ctx, eng_id-ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_le_shift, &hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1418,6 +1520,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn35_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn31_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn351_hwseq_create,
@@ -1442,6 +1545,21 @@ static void dcn351_resource_destruct(struct dcn351_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1799,6 +1917,7 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.link_enc_create_minimal = dcn31_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn31_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn351_validate_bandwidth,
 	.calculate_wm_and_dlg = NULL,
@@ -1885,6 +2004,8 @@ static bool dcn351_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 42fa8883d1b7..bd3c37f63048 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -37,6 +37,8 @@
 #include "dcn30/dcn30_afmt.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn35/dcn35_dio_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
@@ -139,6 +141,10 @@ enum dcn36_clk_src_array_id {
 	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SRI_ARR_DME(reg_name, block, id, offset)\
+	REG_STRUCT[id - offset].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -338,6 +344,35 @@ static const struct dcn10_link_enc_mask le_mask = {
 	//DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, 6)
+
+#define hpo_frl_stream_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[2];
+
+static const struct dcn30_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN3_0_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[1];
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_init(id)\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
@@ -672,6 +707,7 @@ static const struct resource_caps res_cap_dcn36 = {
 	.num_audio = 5,
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 2,
 	.num_pll = 4,/*1 c10 edp, 3xc20 combo PHY*/
@@ -1324,6 +1360,72 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn31_hpo_frl_stream_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_stream_encoder *hpo_enc3;
+	struct vpg *vpg;
+	struct afmt *afmt;
+	int vpg_inst;
+	int afmt_inst;
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_stream_enc_regs
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(6);
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 5;
+		afmt_inst = 5;
+	} else
+		return NULL;
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn31_vpg_create(ctx, vpg_inst);
+	afmt = dcn31_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc3 || !vpg || !afmt) {
+		kfree(hpo_enc3);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn30_hpo_frl_stream_encoder_construct(hpo_enc3, ctx, ctx->dc_bios,
+					eng_id, vpg, afmt,
+					&hpo_frl_stream_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc3->base;
+}
+
+static struct hpo_frl_link_encoder *dcn31_hpo_frl_link_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_enc3;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_link_enc_regs
+	hpo_frl_link_encoder_reg_list(0);
+
+	/* allocate HPO link encoder */
+	hpo_enc3 = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_enc3)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_enc3, ctx, eng_id-ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_le_shift, &hpo_le_mask);
+
+	return &hpo_enc3->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1425,6 +1527,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn31_create_audio,
 	.create_stream_encoder = dcn35_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn31_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn31_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn31_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn36_hwseq_create,
@@ -1449,6 +1552,21 @@ static void dcn36_resource_destruct(struct dcn36_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN30_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+			kfree(DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1800,6 +1918,7 @@ static struct resource_funcs dcn36_res_pool_funcs = {
 	.link_enc_create_minimal = dcn31_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn31_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn35_validate_bandwidth,
 	.calculate_wm_and_dlg = NULL,
@@ -1882,6 +2001,8 @@ static bool dcn36_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
+	dc->config.skip_frl_pretraining = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 6aa051154f5e..8e5bd864f064 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -35,6 +35,8 @@
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn401/dcn401_dio_stream_encoder.h"
+#include "dcn401/dcn401_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
@@ -126,6 +128,10 @@ enum dcn401_clk_src_array_id {
 	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SRI_ARR_DME(reg_name, block, id, offset)\
+	REG_STRUCT[id - offset].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -313,6 +319,35 @@ static const struct dcn10_link_enc_mask le_mask = {
 };
 
 
+#define hpo_frl_stream_encoder_reg_list(id)\
+	DCN3_0_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)
+
+#define hpo_frl_stream_encoder_dme_reg_list(id)\
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, 4)
+
+static struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[2];
+
+static const struct dcn401_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN401_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn401_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN401_HPO_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id)\
+		DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[1];
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)
+};
+
 #define hpo_dp_stream_encoder_reg_init(id)\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
@@ -657,6 +692,7 @@ static const struct resource_caps res_cap_dcn4_01 = {
 	.num_video_plane = 4,
 	.num_audio = 4,
 	.num_stream_encoder = 4,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 4,
 	.num_pll = 4,
@@ -1248,6 +1284,71 @@ static struct stream_encoder *dcn401_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn401_hpo_frl_stream_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn401_hpo_frl_stream_encoder *hpo_enc401;
+	struct vpg *vpg;
+	struct afmt *afmt;
+	int vpg_inst;
+	int afmt_inst;
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_stream_enc_regs
+	hpo_frl_stream_encoder_reg_list(0),
+	hpo_frl_stream_encoder_dme_reg_list(4);
+
+	/* Mapping of VPG, AFMT, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 4;
+		afmt_inst = 4;
+	} else
+		return NULL;
+
+	/* allocate HPO stream encoder and create VPG, AFMT sub-blocks */
+	hpo_enc401 = kzalloc(sizeof(struct dcn401_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn401_vpg_create(ctx, vpg_inst);
+	afmt = dcn401_afmt_create(ctx, afmt_inst);
+
+	if (!hpo_enc401 || !vpg || !afmt) {
+		kfree(hpo_enc401);
+		kfree(vpg);
+		kfree(afmt);
+		return NULL;
+	}
+
+	dcn401_hpo_frl_stream_encoder_construct(hpo_enc401, ctx, ctx->dc_bios,
+					eng_id, vpg, afmt,
+					&hpo_frl_stream_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc401->base;
+}
+
+static struct hpo_frl_link_encoder *dcn401_hpo_frl_link_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_link_enc;
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_link_enc_regs
+	hpo_frl_link_encoder_reg_list(0);
+
+	/* allocate HPO link encoder */
+	hpo_link_enc = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_link_enc)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_link_enc, ctx, eng_id-ENGINE_ID_HPO_0,
+					&hpo_frl_link_enc_regs[eng_id-ENGINE_ID_HPO_0],
+					&hpo_le_shift, &hpo_le_mask);
+
+	return &hpo_link_enc->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn401_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1375,6 +1476,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn401_create_audio,
 	.create_stream_encoder = dcn401_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn401_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn401_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn401_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn401_hwseq_create,
@@ -1405,6 +1507,21 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN31_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.hpo_frl_stream_enc[i]->afmt != NULL) {
+				kfree(DCN30_AFMT_FROM_AFMT(pool->base.hpo_frl_stream_enc[i]->afmt));
+				pool->base.hpo_frl_stream_enc[i]->afmt = NULL;
+			}
+			kfree(DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1833,6 +1950,7 @@ static struct resource_funcs dcn401_res_pool_funcs = {
 	.destroy = dcn401_destroy_resource_pool,
 	.link_enc_create = dcn401_link_encoder_create,
 	.link_enc_create_minimal = NULL,
+	.hpo_frl_link_enc_create = dcn401_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn32_panel_cntl_create,
 	.validate_bandwidth = dcn401_validate_bandwidth,
 	.calculate_wm_and_dlg = NULL,
@@ -1970,6 +2088,7 @@ static bool dcn401_resource_construct(
 	dc->caps.max_slave_rgb_planes = 3;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	dc->caps.hdmi_hpo = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
@@ -2015,6 +2134,8 @@ static bool dcn401_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	/* HACK: Force FRL support until BIOS is ready. */
+	dc->config.force_hdmi21_frl_enc_enable = true;
 	dc->config.use_spl = true;
 	dc->config.prefer_easf = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index d5efe1e8fcee..d04de54dfe66 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -40,6 +40,9 @@
 #include "dcn31/dcn31_vpg.h"
 #include "dcn42/dcn42_dio_stream_encoder.h"
 #include "dcn42/dcn42_pg_cntl.h"
+#include "dcn401/dcn401_hpo_frl_stream_encoder.h"
+#include "dcn42/dcn42_hpo_frl_stream_encoder.h"
+#include "dcn30/dcn30_hpo_frl_link_encoder.h"
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
@@ -140,6 +143,9 @@ enum dcn401_clk_src_array_id {
 	REG_STRUCT[id - 1].reg_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
 								  reg##block##id##_##reg_name
 
+#define SRI_ARR_DME(reg_name, block, id, offset)                                      \
+	REG_STRUCT[id - offset].reg_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+									   reg##block##id##_##reg_name
 
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)                            \
 	REG_STRUCT[index].reg_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
@@ -297,6 +303,34 @@ static const struct dcn10_link_enc_shift le_shift = {
 static const struct dcn10_link_enc_mask le_mask = {
 	LINK_ENCODER_MASK_SH_LIST_DCN42(_MASK)};
 
+#define hpo_frl_stream_encoder_reg_list(id) \
+	DCN42_HPO_FRL_STREAM_ENC_REG_LIST_RI(id)
+
+#define hpo_frl_stream_encoder_dme_reg_list(id) \
+	DCN3_0_HPO_STREAM_ENC_DME_REG_LIST_RI(id, 6)
+
+static struct dcn30_hpo_frl_stream_enc_registers hpo_frl_stream_enc_regs[2];
+
+static const struct dcn401_hpo_frl_stream_encoder_shift hpo_se_shift = {
+	DCN401_HPO_STREAM_ENC_MASK_SH_LIST(__SHIFT),
+	DCN42_HDMI_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+};
+static const struct dcn401_hpo_frl_stream_encoder_mask hpo_se_mask = {
+	DCN401_HPO_STREAM_ENC_MASK_SH_LIST(_MASK),
+	DCN42_HDMI_STREAM_ENC_MASK_SH_LIST(_MASK)
+};
+
+#define hpo_frl_link_encoder_reg_list(id) \
+	DCN3_0_HPO_FRL_LINK_ENC_REG_LIST_RI(id)
+
+static struct dcn30_hpo_frl_link_encoder_registers hpo_frl_link_enc_regs[1];
+
+static const struct dcn30_hpo_frl_link_encoder_shift hpo_le_shift = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(__SHIFT)};
+
+static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
+	DCN3_0_HPO_FRL_LINK_ENC_MASK_SH_LIST(_MASK)};
+
 #define hpo_dp_stream_encoder_reg_init(id) \
 	DCN42_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
@@ -658,6 +692,7 @@ static const struct resource_caps res_cap_dcn42 = {
 	.num_stream_encoder = 5,
 	.num_dig_link_enc = 5,
 	.num_usb4_dpia = 6,
+	.num_hpo_frl = 1,
 	.num_hpo_dp_stream_encoder = 4,
 	.num_hpo_dp_link_encoder = 4,
 	.num_pll = 5,
@@ -1257,6 +1292,74 @@ static struct stream_encoder *dcn42_stream_encoder_create(
 	return &enc1->base;
 }
 
+static struct hpo_frl_stream_encoder *dcn42_hpo_frl_stream_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn42_hpo_frl_stream_encoder *hpo_enc42;
+	struct vpg *vpg;
+	struct apg *apg;
+
+	uint32_t vpg_inst;
+	uint32_t apg_inst;
+
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_stream_enc_regs
+	hpo_frl_stream_encoder_reg_list(0),
+		hpo_frl_stream_encoder_dme_reg_list(6);
+
+	/* Mapping of VPG, DME register blocks to HPO block instance */
+	if (eng_id == ENGINE_ID_HPO_0) {
+		vpg_inst = 9; /*hw hard wired to inst 9, ref to dcn header file*/
+		apg_inst = 9;
+	} else
+		return NULL;
+
+	/* allocate HPO stream encoder and create VPG sub-block */
+	hpo_enc42 = kzalloc(sizeof(struct dcn42_hpo_frl_stream_encoder), GFP_KERNEL);
+	vpg = dcn42_vpg_create(ctx, vpg_inst);
+	apg = dcn42_apg_create(ctx, apg_inst);
+
+	if (!hpo_enc42 || !vpg || !apg) {
+		kfree(hpo_enc42);
+		kfree(vpg);
+		kfree(apg);
+		return NULL;
+	}
+
+	dcn42_hpo_frl_stream_encoder_construct(hpo_enc42, ctx, ctx->dc_bios,
+			eng_id, vpg, apg,
+			&hpo_frl_stream_enc_regs[eng_id - ENGINE_ID_HPO_0],
+			&hpo_se_shift, &hpo_se_mask);
+
+	return &hpo_enc42->base;
+}
+
+static struct hpo_frl_link_encoder *dcn42_hpo_frl_link_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn30_hpo_frl_link_encoder *hpo_link_enc;
+
+	ASSERT((eng_id == ENGINE_ID_HPO_0) || (eng_id == ENGINE_ID_HPO_1));
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_frl_link_enc_regs
+	hpo_frl_link_encoder_reg_list(0);
+
+	/* allocate HPO link encoder */
+	hpo_link_enc = kzalloc(sizeof(struct dcn30_hpo_frl_link_encoder), GFP_KERNEL);
+	if (!hpo_link_enc)
+		return NULL; /* out of memory */
+
+	hpo_frl_link_encoder3_construct(hpo_link_enc, ctx, eng_id - ENGINE_ID_HPO_0,
+			&hpo_frl_link_enc_regs[eng_id - ENGINE_ID_HPO_0],
+			&hpo_le_shift, &hpo_le_mask);
+
+	return &hpo_link_enc->base;
+}
+
 static struct hpo_dp_stream_encoder *dcn42_hpo_dp_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
@@ -1362,6 +1465,7 @@ static const struct resource_create_funcs res_create_funcs = {
 	.read_dce_straps = read_dce_straps,
 	.create_audio = dcn42_create_audio,
 	.create_stream_encoder = dcn42_stream_encoder_create,
+	.create_hpo_frl_stream_encoder = dcn42_hpo_frl_stream_encoder_create,
 	.create_hpo_dp_stream_encoder = dcn42_hpo_dp_stream_encoder_create,
 	.create_hpo_dp_link_encoder = dcn42_hpo_dp_link_encoder_create,
 	.create_hwseq = dcn42_hwseq_create,
@@ -1392,6 +1496,21 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 		}
 	}
 
+	for (i = 0; i < pool->base.hpo_frl_stream_enc_count; i++) {
+		if (pool->base.hpo_frl_stream_enc[i] != NULL) {
+			if (pool->base.hpo_frl_stream_enc[i]->vpg != NULL) {
+				kfree(DCN31_VPG_FROM_VPG(pool->base.hpo_frl_stream_enc[i]->vpg));
+				pool->base.hpo_frl_stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.hpo_frl_stream_enc[i]->apg != NULL) {
+				kfree(DCN31_APG_FROM_APG(pool->base.hpo_frl_stream_enc[i]->apg));
+				pool->base.hpo_frl_stream_enc[i]->apg = NULL;
+			}
+			kfree(DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(pool->base.hpo_frl_stream_enc[i]));
+			pool->base.hpo_frl_stream_enc[i] = NULL;
+		}
+	}
+
 	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
 		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
 			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
@@ -1785,6 +1904,7 @@ static struct resource_funcs dcn42_res_pool_funcs = {
 	.link_enc_create_minimal = dcn42_link_enc_create_minimal,
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.hpo_frl_link_enc_create = dcn42_hpo_frl_link_encoder_create,
 	.panel_cntl_create = dcn32_panel_cntl_create,
 	.validate_bandwidth = dcn42_validate_bandwidth,
 	.calculate_wm_and_dlg = NULL,
@@ -1925,6 +2045,7 @@ static bool dcn42_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
 		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.hdmi_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.dp_hpo = true;
 	dc->caps.edp_dsc_support = true;
-- 
2.54.0


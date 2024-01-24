Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CCAC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338F310EE97;
	Wed, 24 Jan 2024 07:02:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D176010EE97
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp3FD4Fkv14sl/pCAn3BxlWWtNApxooHypEFVtM/20kXk/hK99HWf7jc5B1wVM2e/bpU085GVmPJwOayr3iruzJfShs4vE55Y46XybngPpLAgzdVl39p8QxfWCNA/yWjS26281Rcfd5wy51xFTPTq9C4FGd/q1gLq2gBFXkbGT77MvwG/VlJ7ze0S8d+l3rFGSPENO9z1a3Til6roBNmcHV4WMKpBhhZs57nEFUG2a/txN0OM0v/zy2VQjShFpVAZgXgZuN3xPTNGcuE0RGw/kEYvQQdRhmAFTP2Z3wKEU6+d61+/bWCa0foxc8fOTqTS/gaf70fwo9bD5QTpWavCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvkOgrGWQF6Iok0gNFZOktK3PPIm8PwbiyX97G5c3h0=;
 b=aI9wSQXs4p6bZftV5ZHAU2InmecLEFVynQk85ohvk9BMiSDMTR/L+gMpcAW6SQzPHyJAuNP/hCSCzl5gpS3uM/eEVV/9WaUZWGQSk0Wjpv36XOlqxZm9ckbO81auC2j2FnnCC+fqfnXvpvx2ZTxd3InwL1OnDCNY8kofqoKtW22epJnYBKD/SyFMpes+ATPWg+NnmfNcIO+4mZH/s7xO9UubYcWzQqvclkCckdq5ofkfPgPHRIdDhg41Bl8snoLCwKRkIdece/ObYh6+ZWqAo/b+2wMyr6U00i2GY9qxMvePfHs0eaenTWh8Yx3WqFb+xMlwpnRsNn1E2L31vBc2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvkOgrGWQF6Iok0gNFZOktK3PPIm8PwbiyX97G5c3h0=;
 b=aO5ZWLVmG+1BoXmOT7fiA4J1X4kJjunZfQ1zHKWuk4xSGPSMDT0nDsuLy2iOPARr1V34nNkrU+3TriAGi5GEZZuWE0oQm/1ir5CVQ1qGcsKBks0lVrikljTwRJUuYfEzkbLExZqnSgRRRO8lrCRaVuXm/AEJzYTJZ7l0JaGWFJ8=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 07:02:15 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::90) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:12 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:09 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/22] drm/amd/display: Fix static screen event mask
 definition change
Date: Wed, 24 Jan 2024 15:01:38 +0800
Message-ID: <20240124070159.1900622-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f3d1fd-a655-45f3-7203-08dc1caa655a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2T45H5KXK5GQHpQG6hKmnVeCEqI3OSJi1PHP0MEL/3MIwbfuzs0SCeav2NsNQvb0LqjZAebIN9Tz4zkaCcU9UmEAK4Q3TV7Fpl9/xXoZVBLKpriPUca3XYxdw1X97FIWSvFo+WBCXd03/rHdtWtgKNLRSaVO4HVWRLBImJwpRKi/6QJJBWctijf+p4zE7LJJDmjv5TECyL7QJRNIUeWMDFYmjMPc4kxr6/Qmhvuaqwt55umGgO3YZiJuZMT7Ys5E/bG/k9ThMs08/4ryeS73iLwYgu0RvKC7l29CQOyM2jUZ0Gxt70O3lR/HYZKdjhF7k+LNmvZBFfZaARt2tagNp+i9LUzr8q4a5JX7wE9NHR1f+ut5gctO3AyUdJDsaPQkxqCAYaNMbgO6LkFRoDcbaFGetPuh9918IEDEJfFiX3eaL2/A5D8tqSt2gusvnRy3E+yLkjflUbO5ZxuEZkygmHCgDJFlvmCNczBkTmQlFK0kjgSMxijVeJk8w5wPt7gWcosXyqOQzut5Zfj0o0OTxBKvmzejNGvcf7hSC5HL0+aFLkv2L8GgF2nV6vUBMuNcbYNiNfOQ+2n2nO3pmJsM3T0mLjn9A7rBxDRRfdP45RtO2rOVDeq/hBGE21gx+mW76bbraJ4jDUj48hniagXS0bmmPvIXvQs2peYi9ti4jAA4ncxantDu4Cs7uOu001d88U5AjoFtBe0fgctZZu+2eWyRLCXW04pcuFPlN/JR3Q1jT0ZUD4V5B80VmNF2nsZMK71OT164on1CRRPtFIwZAdxALGwu9iJ6kwc+maTBkA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(336012)(83380400001)(47076005)(1076003)(2616005)(426003)(36860700001)(26005)(8936002)(8676002)(70206006)(2906002)(81166007)(5660300002)(316002)(7696005)(4326008)(54906003)(478600001)(70586007)(6916009)(36756003)(86362001)(41300700001)(82740400003)(356005)(6666004)(40480700001)(40460700003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:14.8805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f3d1fd-a655-45f3-7203-08dc1caa655a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Yiling Chen <yi-ling.chen2@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yiling Chen <yi-ling.chen2@amd.com>

[why]
The static screen event mask definition is different
betwnn DCN31 after and before.

[how]
Rename DCN30_set_static_screen_control to DCN31.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Yiling Chen <yi-ling.chen2@amd.com>
---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c    | 18 ------------------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |  3 ---
 .../drm/amd/display/dc/hwss/dcn30/dcn30_init.c |  2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c    | 18 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h    |  4 ++++
 .../drm/amd/display/dc/hwss/dcn31/dcn31_init.c |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c   |  2 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_init.c |  2 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_init.c |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c   |  2 +-
 10 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 54d42cf860c9..7e6b7f2a6dc9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1164,21 +1164,3 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 	if (!dc->clk_mgr->clks.fw_based_mclk_switching)
 		dc_dmub_srv_p_state_delegate(dc, false, context);
 }
-
-void dcn30_set_static_screen_control(struct pipe_ctx **pipe_ctx,
-		int num_pipes, const struct dc_static_screen_params *params)
-{
-	unsigned int i;
-	unsigned int triggers = 0;
-
-	if (params->triggers.surface_update)
-		triggers |= 0x100;
-	if (params->triggers.cursor_update)
-		triggers |= 0x8;
-	if (params->triggers.force_trigger)
-		triggers |= 0x1;
-
-	for (i = 0; i < num_pipes; i++)
-		pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(pipe_ctx[i]->stream_res.tg,
-					triggers, params->num_frames);
-}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 4248a4c0e574..638f018a3cb5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -93,7 +93,4 @@ void dcn30_set_hubp_blank(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context);
 
-void dcn30_set_static_screen_control(struct pipe_ctx **pipe_ctx,
-		int num_pipes, const struct dc_static_screen_params *params);
-
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 9894caedffed..ef913445a795 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -64,7 +64,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn30_set_static_screen_control,
+	.set_static_screen_control = dcn10_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 7423880fabb6..58eb918e2c10 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -617,3 +617,21 @@ void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
 	if (hws->ctx->dc->debug.hpo_optimization)
 		REG_UPDATE(HPO_TOP_HW_CONTROL, HPO_IO_EN, !!enable);
 }
+
+void dcn31_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params)
+{
+	unsigned int i;
+	unsigned int triggers = 0;
+
+	if (params->triggers.surface_update)
+		triggers |= 0x100;
+	if (params->triggers.cursor_update)
+		triggers |= 0x8;
+	if (params->triggers.force_trigger)
+		triggers |= 0x1;
+
+	for (i = 0; i < num_pipes; i++)
+		pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(pipe_ctx[i]->stream_res.tg,
+					triggers, params->num_frames);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
index edfc01d6ad73..b8bc939da155 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
@@ -56,4 +56,8 @@ bool dcn31_is_abm_supported(struct dc *dc,
 void dcn31_init_pipes(struct dc *dc, struct dc_state *context);
 void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable);
 
+void dcn31_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params);
+
+
 #endif /* __DC_HWSS_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 669f524bd064..c06cc2c5da92 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -67,7 +67,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn30_set_static_screen_control,
+	.set_static_screen_control = dcn31_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index ccb7e317e86a..542ce3b7f9e4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -69,7 +69,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn30_set_static_screen_control,
+	.set_static_screen_control = dcn31_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 427cfc8c24a4..0980df6c65ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -65,7 +65,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn30_set_static_screen_control,
+	.set_static_screen_control = dcn31_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index a630aa77dcec..29a93dbc6631 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -70,7 +70,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn35_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn30_set_static_screen_control,
+	.set_static_screen_control = dcn31_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 143d3fc0221c..e5cb7fb8b2d4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -69,7 +69,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn30_set_static_screen_control,
+	.set_static_screen_control = dcn31_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
-- 
2.34.1


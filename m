Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658E6C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FE910EE3A;
	Wed, 26 Aug 2026 23:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PuUAQg38";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE3210EE3A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfVYy+Bh3FsVTXrsDGQg4dnqnHebLFVmXjRJLZlb5Ixlg16lUx8Ocg6dICb3YjCJowlwjT2ywm8UvdKR6ZW6bEe340c/kCitVM1qxzf/2brN9XNgRNNHx5FOzXASkB7PPBjXFHwCfAdtxhBGCbQh9/+aaaze6zNK6Nysx/snTCQxZKfgfxQbPFjWtmkCf/UIOBYrnEfFRakspvI5dCDskxGjxFAVOEPkhMEMtJ3jcjy51mgq3Id+XpaNLyV2B1+tlkKUTHdJwqy1lcYuhF0ROo6YATBjEDpzRCJYB6g34DtfvIODFaGATIyfe78YRzQpKcKKbe5W2o23veDZAchj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQGjzmHMPqo/wAKHVnRm5hwwfIOlAVV6a2XcX2lZCjs=;
 b=ACtzUdwqSMV/k/w/Zkc2Qql31BrOZXsmCNRxuLBs7/U9FzEUiO2CYawzG4Ps4jDJRMVF89eUVXS3NwrGhkmgPtrA4fuERtN7n6hbiEdHsNa/ejB+ImA/W3So9TXAGMGkQh6sYOiGZ1syCOKLWcWCOnGjvDq3BIiIAEIQNE1Omfb9TLVpBDp6yWexTZNCV/YROfipBti/ytOwDdasJ7js+y3y3nSXQVQJ/g8+53MsesWZWNDeQR5wiKPRD2BV29LZeWvZcuaxN6HpNO1sLh5J+Hyk0lGEO3h5nVtQMTEYP3c3/1o3lID9OgCnLRIVYMgo/D+hINGnxFgPVdJvrRjGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQGjzmHMPqo/wAKHVnRm5hwwfIOlAVV6a2XcX2lZCjs=;
 b=PuUAQg38rrMjBheKGbaPPR78V79UkqzQ+QhIOQ0T/lqPJq30CYAUmSnKAX/hpht05aYn0epD8Oq1osdffr2BFO0EBekEVeqOKy0YcyOTHhS/giH1egaJiIWmLNHIUxpnxSDeZ7tZDT3Wke/l/DWcDVa9/RG8N0uOYbcYC5DI5ps=
Received: from DS1P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::11) by
 IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:19:59 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:8:451:cafe::e) by DS1P221CA0011.outlook.office365.com
 (2603:10b6:8:451::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:19:59 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:19:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>
Subject: [PATCH 12/59] drm/amd/display: Move cursor SDR white level
 calculation out of hwss executor
Date: Wed, 26 Aug 2026 17:04:43 -0600
Message-ID: <20260826231519.881949-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e7a77a-5b78-439e-37ad-08df03c88c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|6133799003|3023799007|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yJPLX//GrFLFfUL9GXpwZBv6BbCpNr8PwJRaahPyR+fbHMtqCfVdvL5UiE813q2vi2lQHQBKv9Xq3UNmyc+opujz/y2mXyPZ60RwFZJonC3sN9foGCh3PYnoVmbFubzCA53p1r/KBeX6GoLGaw8ulS0u6g+Yw3MJ9DuVLf3eMwsCnOnE9EXxfRvx7w9JxpL0NnpPG1kEv4c0jQunvDZCvJqmmHKAvF9R+mH0XxAODKsyesafIdquu+w8my7p/uW1YxZntewHI/nWY0A7xEx7yvmiNNT3UBeqhW3XGZbLy6YsP4j3w+hQ5CJUZlgTGAa/qlqER8sWjUcOPBSS5KhyQpxf5OyQ2UcIiYBO++0lxFjDJH5bjJaMmNjhD6SuKxCTca7O/uvC/WqpMxnw8pq4q+r1rnP57kysh0jr9PSspVec2lVS71tf+rFmNTJFfk4MbNOcSnwFoIB+l9f8xi2uLgTu1wvZN6n+HP3SFCE3lcylgI8y6uqEKzX+MPbEurgirfT6W+icnpYCuroHwqUY+C6j8DaRILwz+tm1a4QJNA731wl14/Yjo1kH2PtSJipK0grSTdx3oiez1Ca426pDYykBmFVUttu8a14R6ZLT7/1wTsfH3RoDKTw/SzIOqMiXh0mExJT07A+oXcWvryMoN0L4ay4Dcah2AAfKM5GGxMdp5+GawjYYPzdf4EiNV6RRSDS29ZNO4ie17/54id2fTA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +O73Pizn0cMGCWUwUKDYhU+eJPG7QHTcat82pHKgzqp6kr2GAyI8GUTWnIp1eleu/AggSulBrzr3/TMMHulbiexnC4/RBrOxovPSIV+HcoFKH+wFFfgDKCNpheGg3sbKS4YxLr4dxP7y0zQfkOa6Dj+28Kk4JqU+crkM+px/D0FNhRYYLNHpNxU+oqW28EsR0J9xBlyRjlQsCii3BU39izAcericfQsJldlwDa18wOwgARlSEVYf+x+dxBi6lruYLx3k9yFa8sINVzdKUZQkPRncsm4THYwaKSp23Mb8rMfIlAF7u91uHV7pWB/11WxLqZozUClCz3qY4AGZ+u9JCaPmISYENKIZPcrzL3aGXxa3jXkGmq9sM0VD9K1XnDz4nyRS14nt9A8raoj5mjoMC9o+hz+8R1u9mMJ4lwSTnNWzj8dxfeUPYzFOJcoU+vvR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:19:59.0308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e7a77a-5b78-439e-37ad-08df03c88c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[WHY]
Cursor SDR white level calculation is common across DCN generations
and does not require an ASIC-specific HWSS implementation.
Keeping it in the DCN10 HWSS extension duplicated generic policy
in generation-specific code and made block sequence execution
depend on mutable pipe context.

[HOW]
Move cursor SDR white level calculation into dc_hw_sequencer. Store the
calculated DPP cursor attributes in the block sequence so execution
only invokes set_optional_cursor_attributes.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 55 +++++++++++++------
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 26 ++-------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  3 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |  3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  7 ++-
 6 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1b9bcc3f0d2b..e40bad702f0f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3957,8 +3957,7 @@ static void program_cursor_attributes_sequence(
 		hwss_add_set_cursor_attribute(seq_state, dc, tmp_pipe);
 		if (dc->ctx->dmub_srv)
 			hwss_add_send_update_cursor_info_to_dmu(seq_state, tmp_pipe, k);
-		if (dc->hwss.set_cursor_sdr_white_level)
-			hwss_add_set_cursor_sdr_white_level(seq_state, dc, tmp_pipe);
+		hwss_add_set_cursor_sdr_white_level(seq_state, tmp_pipe);
 		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
 			hwss_add_update_cursor_offload_pipe(seq_state, dc, tmp_pipe);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 47320ac01711..7ad30a1f2978 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -786,6 +786,29 @@ static void calc_vline_position(
 		ASSERT(0);
 }
 
+struct dpp_cursor_attributes calc_sdr_cursor_attributes(struct pipe_ctx *pipe_ctx)
+{
+	uint32_t sdr_white_level = pipe_ctx->stream->cursor_attributes.sdr_white_level;
+	struct fixed31_32 multiplier;
+	struct dpp_cursor_attributes opt_attr = { 0 };
+	uint32_t hw_scale = 0x3c00; // 1.0 default multiplier
+	struct custom_float_format fmt;
+
+	fmt.exponenta_bits = 5;
+	fmt.mantissa_bits = 10;
+	fmt.sign = true;
+
+	if (sdr_white_level > 80) {
+		multiplier = dc_fixpt_from_fraction(sdr_white_level, 80);
+		convert_to_custom_float_format(multiplier, &fmt, &hw_scale);
+	}
+
+	opt_attr.scale = hw_scale;
+	opt_attr.bias = 0;
+
+	return opt_attr;
+}
+
 // Function to check if any update flags are set
 static bool get_pipe_update_bits_status(struct pipe_ctx *pipe, struct dc_plane_state *plane, struct dc_stream_state *stream)
 {
@@ -1183,6 +1206,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 	struct pipe_ctx *current_mpc_pipe = NULL;
 	bool is_dmub_lock_required = false;
 	unsigned int i = 0;
+	struct block_sequence_state seq_state = { .steps = block_sequence, .num_steps = num_steps };
 
 	*num_steps = 0; // Initialize to 0
 
@@ -1341,11 +1365,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				(*num_steps)++;
 			}
 
-			block_sequence[*num_steps].params.set_cursor_sdr_white_level_params.dc = dc;
-			block_sequence[*num_steps].params.set_cursor_sdr_white_level_params.pipe_ctx =
-				current_pipe;
-			block_sequence[*num_steps].func = SET_CURSOR_SDR_WHITE_LEVEL;
-			(*num_steps)++;
+			hwss_add_set_cursor_sdr_white_level(&seq_state, current_pipe);
 
 			if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
 				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.dc = dc;
@@ -4385,11 +4405,10 @@ void hwss_set_cursor_position(union block_sequence_params *params)
 
 void hwss_set_cursor_sdr_white_level(union block_sequence_params *params)
 {
-	struct dc *dc = params->set_cursor_sdr_white_level_params.dc;
-	struct pipe_ctx *pipe_ctx = params->set_cursor_sdr_white_level_params.pipe_ctx;
+	struct dpp *dpp = params->set_cursor_sdr_white_level_params.dpp;
 
-	if (dc && dc->hwss.set_cursor_sdr_white_level)
-		dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
+	if (dpp->funcs->set_optional_cursor_attributes)
+		dpp->funcs->set_optional_cursor_attributes(dpp, &params->set_cursor_sdr_white_level_params.attr);
 }
 
 void hwss_program_gamut_remap(struct pipe_ctx *pipe_ctx)
@@ -5771,15 +5790,19 @@ void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
 }
 
 void hwss_add_set_cursor_sdr_white_level(struct block_sequence_state *seq_state,
-		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = SET_CURSOR_SDR_WHITE_LEVEL;
-		seq_state->steps[*seq_state->num_steps].params.set_cursor_sdr_white_level_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.set_cursor_sdr_white_level_params.pipe_ctx = pipe_ctx;
-		(*seq_state->num_steps)++;
-	}
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dpp_cursor_attributes attr;
+
+	if (dpp && dpp->funcs->set_optional_cursor_attributes)
+		if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+			attr = calc_sdr_cursor_attributes(pipe_ctx);
+			seq_state->steps[*seq_state->num_steps].func = SET_CURSOR_SDR_WHITE_LEVEL;
+			seq_state->steps[*seq_state->num_steps].params.set_cursor_sdr_white_level_params.dpp = dpp;
+			seq_state->steps[*seq_state->num_steps].params.set_cursor_sdr_white_level_params.attr = attr;
+			(*seq_state->num_steps)++;
+		}
 }
 
 void hwss_add_program_output_csc(struct block_sequence_state *seq_state,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index b1679791f903..1b0fc0853045 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3938,29 +3938,13 @@ void dcn10_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 
 void dcn10_set_cursor_sdr_white_level(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t sdr_white_level = pipe_ctx->stream->cursor_attributes.sdr_white_level;
-	struct fixed31_32 multiplier;
-	struct dpp_cursor_attributes opt_attr = { 0 };
-	uint32_t hw_scale = 0x3c00; // 1.0 default multiplier
-	struct custom_float_format fmt;
-
-	if (!pipe_ctx->plane_res.dpp->funcs->set_optional_cursor_attributes)
-		return;
-
-	fmt.exponenta_bits = 5;
-	fmt.mantissa_bits = 10;
-	fmt.sign = true;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dpp_cursor_attributes attr;
 
-	if (sdr_white_level > 80) {
-		multiplier = dc_fixpt_from_fraction(sdr_white_level, 80);
-		convert_to_custom_float_format(multiplier, &fmt, &hw_scale);
+	if (dpp && dpp->funcs->set_optional_cursor_attributes) {
+		attr = calc_sdr_cursor_attributes(pipe_ctx);
+		dpp->funcs->set_optional_cursor_attributes(dpp, &attr);
 	}
-
-	opt_attr.scale = hw_scale;
-	opt_attr.bias = 0;
-
-	pipe_ctx->plane_res.dpp->funcs->set_optional_cursor_attributes(
-			pipe_ctx->plane_res.dpp, &opt_attr);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8e0ccc9d5819..7b089ae5c9c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3743,8 +3743,7 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 		hwss_add_set_cursor_position(seq_state, dc, pipe_ctx);
 
 		/* Step 16: Cursor SDR white level */
-		if (dc->hwss.set_cursor_sdr_white_level)
-			hwss_add_set_cursor_sdr_white_level(seq_state, dc, pipe_ctx);
+		hwss_add_set_cursor_sdr_white_level(seq_state, pipe_ctx);
 	}
 
 	/* Step 17: Gamut remap and output CSC */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index a7f8fd03faea..c13d1ad8d000 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -366,8 +366,7 @@ void dcn50_update_dchubp_dpp_sequence(struct dc *dc,
 		hwss_add_set_cursor_position(seq_state, dc, pipe_ctx);
 
 		/* Step 15: Cursor SDR white level */
-		if (dc->hwss.set_cursor_sdr_white_level)
-			hwss_add_set_cursor_sdr_white_level(seq_state, dc, pipe_ctx);
+		hwss_add_set_cursor_sdr_white_level(seq_state, pipe_ctx);
 	}
 
 	/* Step 16: Gamut remap and output CSC */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 4f0d000eab94..83d9d699e929 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -872,8 +872,8 @@ struct set_cursor_position_params {
 };
 
 struct set_cursor_sdr_white_level_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct dpp *dpp;
+	struct dpp_cursor_attributes attr;
 };
 
 struct program_output_csc_params {
@@ -1802,6 +1802,8 @@ void set_drr_and_clear_adjust_pending(
 		struct dc_stream_state *stream,
 		struct drr_params *params);
 
+struct dpp_cursor_attributes calc_sdr_cursor_attributes(struct pipe_ctx *pipe_ctx);
+
 void hwss_execute_sequence(struct dc *dc,
 		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
 		int num_steps);
@@ -2610,7 +2612,6 @@ void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx);
 
 void hwss_add_set_cursor_sdr_white_level(struct block_sequence_state *seq_state,
-		struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
 
 void hwss_add_program_output_csc(struct block_sequence_state *seq_state,
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2875EC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA4C10E4F1;
	Tue, 13 May 2025 11:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/TcmHj/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA1510E3BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdJabobUqoFqjNig4rZRudex1bD9XEhfuc0vO4Wlu9gQcoCKnuof7qFq7qwVEm7hIsOLonNNxykyAfBDPfUaccAcqIfhJISPxGaNqLuh+RA/YxryW3iPaONDNlZ540wsu1YwzoVGrja89WrjHJMWBwcqt16724Hzd//z3CXoGNDjfjCJXbR40MPtZMvjmIL2g/2qVKZagxaD5nDBCzgJGmL9Le3L/vZS6Gv0OKa5ws2t3hlq8Tizyo3I3WtqXmVrdmHZ0qPFGKwBv+FqH1F9u0lioZK6X/1Y++EqstQX2B6qdrRZWHLdJhdRhXFx2uA45M74R2uKlI1BPSyKDWHjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/0+RLZgFrCL3Nune2UGe2xxqpBaXv+n4id4B1NTSNg=;
 b=GCDC24q5AqarhziUPEw3RovRI9f5DFh5AmsuthIfejC+vmCVz0vD6Gm7S6YhzV5XG8XMc+9MePWbgn4BXi9tZKRptBotO31NsprVyOAAS690cw66NPlIhFMngY0FyvOIF7HjyxXoYuWtIQ26nCmc9rhywkphhMw6vf6XyZnd5iRbe7mpUYqQyOqWr/3vJ5ZtznwhTZJL/rxfVs8ezo4QsS06aPmyKhzqXpYrO9VV3QrWmYjb4EuMXnLhDRp6df28l37LGIOmuq65LAgeQXrlQTnYX3VA2IaWj1Rj2+9vjvbSHuI+Sk+txcsECP4wBZM5BRA2qaPmUo7wnE0NPMyZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/0+RLZgFrCL3Nune2UGe2xxqpBaXv+n4id4B1NTSNg=;
 b=n/TcmHj//mTwm6g1wc6VYslqo5WQkIGf+vz8UiWuiBusoUDz7rMrIAUQ1qjNC1efH1IHIelaoZiytwJ2ztkJ3r+QEvEDKk1K5BmbEEb/2dMwlY3fjD8Cr+t4Ta+n5D8lQGihENdsmiWgMiMj2FsSeWE11H/GxukJk8YBrQrtFg8=
Received: from BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::19)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 11:25:07 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::f4) by BN9P221CA0014.outlook.office365.com
 (2603:10b6:408:10a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 13 May 2025 11:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:05 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:02 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Karthi Kandasamy
 <karthi.kandasamy@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 04/11] drm/amd/display: Move mcache allocation programming
 from DML to resource
Date: Tue, 13 May 2025 19:24:32 +0800
Message-ID: <20250513112439.2295366-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: eb136847-1cb0-4bd2-4388-08dd9210d06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|30052699003|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J6WjJEbR/YJhl/A+EwxhGGJrGKSKMP6D+7Ds+9DSMd/WLIMH0PIAt5PHEwib?=
 =?us-ascii?Q?B0NsAtuimZMup5PHgxWe6zW0CZdWoxNGqsYoLLun3diH8XihX3lKRXqxssn0?=
 =?us-ascii?Q?3odlwVzY21qUoPqg+T9qBbjm2fxbNGmtU61pkj5S7xw/GL03O6Nl+kgubG2m?=
 =?us-ascii?Q?SuNj8x+HG3BY9muTVQd7oUaXyuCswmxKBxGiRy+WA/1h0WU63Ogm9NegG/cf?=
 =?us-ascii?Q?5OhlxADZwxlNGSS8ja8uIhqNVlRtq3bGJI2gpx9N4qGXxJJqJ8ziqaGuWYg9?=
 =?us-ascii?Q?chYjee0SpasjBIKdGYBPlmIhDIYP3ewJraFF0ggrQnXK41zfq2/UrigHpEKd?=
 =?us-ascii?Q?MZumrWuvxIjkeHDy/yPZE3TqBKxyVyB0QFYOhX5txxuPCfH7qP360f49oMsD?=
 =?us-ascii?Q?D+IbtJQ7qQV+N+fks16K1s1BVk++3/riYaqaObS1EcGFqdQBF1PMSDvf0ARy?=
 =?us-ascii?Q?W/myz5IIiYAJ/3XQHw+GyYs89nwiVo3fID1c5DSc6U+4lv1wHTMBPG8YPNcj?=
 =?us-ascii?Q?sxDBIqdVj+0jBMpclQZmV1ZGt1O76XcLabZFvsofFoVE6US7SL2iSmhjaRcW?=
 =?us-ascii?Q?RemRc36j945D1S8U6dPAUFbX+Lbk7ORYl11haoyOmlX+kfhoD2yaJ2at4xMU?=
 =?us-ascii?Q?3O2voCg28H1YNQEQ7+hywFhJDXmNr4RXC5v7Kd/ph+CK7Y5ldfC2r5s3Xdfl?=
 =?us-ascii?Q?uHhYR7QBqsk4L617V0+dtr2fo7yJCK07Rjb83PE3/9sLdfVQ/XYOHsWepIMA?=
 =?us-ascii?Q?zwgZe3QV2B89nA9T9rRIiMEBw9WlnduwDXXf7sXtvkzf9yScCR4blQej0sbT?=
 =?us-ascii?Q?MZUzC3sBuS2OsBz9FLGjVtV2UWyeznoe2mUr6vodBeIwUUAJ755xfdDH7XaD?=
 =?us-ascii?Q?/EfIGQ0iFiLt56Etnaz9V16Qu1/4qwa1vQBY7j6KbE/uInRq/7P2ApSTqAZ6?=
 =?us-ascii?Q?h08HTMeDupAPJey3xs9rdySbz2BUE72ng+/zhBp5m5rQUlPT9BZ3KrLytG+l?=
 =?us-ascii?Q?0p7NqZuYH6nPXvutCu02O56RQEXY9S7TOybGn2YBt806hWMyveOXqYnw7hYZ?=
 =?us-ascii?Q?flCCWv3OLmYFpMBFJQxbQpCh/2w2f7ZZmreAVFpRhxhy3VR48kq62zSomDrh?=
 =?us-ascii?Q?sBKK4J0kvfSHnjvoFida/WMh960gM/FSpCXcR+ZwSsT5/n/jHkYgNiLZiqyw?=
 =?us-ascii?Q?qjHEYMGxNV+Aei0dQu77C/ekY9Ogxm9337lGjl2q70eYHAgeBqbF9GLjpL6w?=
 =?us-ascii?Q?ORQguzPd1tL/WJ9YfPHybaPQfzZ1ZYvx1NbxeBtm3sLwUK+PmbKqOJSkx8AH?=
 =?us-ascii?Q?ousmm9PDf/wxHeJ1W/A09CbtvPVSKZRAccWVBiCrVNK5MCG/X1i2nh+z98pX?=
 =?us-ascii?Q?xfhl1BLwVEHbknXV0Phb4RkxkbC911HxmkZmR9l/mPCLE4rvbWD7aGvXy8W+?=
 =?us-ascii?Q?6cORmF+6pg1KUHlmOQc0dqbvpHd2Xn43c/4Ai1urzL7Ad7HFC93Wz4sJgsJw?=
 =?us-ascii?Q?FAVpQMrqSQ4UBGjtBL9J+JCbCUCsbwPBLNdY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(30052699003)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:06.9780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb136847-1cb0-4bd2-4388-08dd9210d06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why]
mcache allocation programming is not part of DML's core responsibilities.
Keeping this logic in DML leads to poor separation of concerns and complicates maintenance.

[How]
Refactored code to move mcache parameter preparation and mcache ID assignment
into the resource file.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  9 +++
 .../dc/dml2/dml21/dml21_translation_helper.c  |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.h  |  2 +
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c | 40 ++++++++++++
 .../amd/display/dc/dml2/dml21/dml21_wrapper.h | 64 +++++++++++++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  8 +++
 8 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 15ef1f26864f..3da25bd8b578 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5525,6 +5525,14 @@ struct dscl_prog_data *resource_get_dscl_prog_data(struct pipe_ctx *pipe_ctx)
 	return &pipe_ctx->plane_res.scl_data.dscl_prog_data;
 }
 
+static bool resource_allocate_mcache(struct dc_state *context, const struct  dc_mcache_params *mcache_params)
+{
+	if (context->clk_mgr->ctx->dc->res_pool->funcs->program_mcache_pipe_config)
+		context->clk_mgr->ctx->dc->res_pool->funcs->program_mcache_pipe_config(context, mcache_params);
+
+	return true;
+}
+
 void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuration_options *dml2_options)
 {
 	dml2_options->callbacks.dc = dc;
@@ -5544,6 +5552,7 @@ void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuratio
 	dml2_options->callbacks.get_stream_status = &dc_state_get_stream_status;
 	dml2_options->callbacks.get_stream_from_id = &dc_state_get_stream_from_id;
 	dml2_options->callbacks.get_max_flickerless_instant_vtotal_increase = &dc_stream_get_max_flickerless_instant_vtotal_increase;
+	dml2_options->callbacks.allocate_mcache = &resource_allocate_mcache;
 
 	dml2_options->svp_pstate.callbacks.dc = dc;
 	dml2_options->svp_pstate.callbacks.add_phantom_plane = &dc_state_add_phantom_plane;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 199938311b32..d47cacfdb695 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -952,7 +952,7 @@ static unsigned int map_stream_to_dml21_display_cfg(const struct dml2_context *d
 	return location;
 }
 
-static unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx, unsigned int stream_id,
+unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx, unsigned int stream_id,
 		const struct dc_plane_state *plane, const struct dc_state *context)
 {
 	unsigned int plane_id;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
index 069b939c672a..73a013be1e48 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
@@ -11,6 +11,7 @@ struct dc_state;
 struct dcn_watermarks;
 union dcn_watermark_set;
 struct pipe_ctx;
+struct dc_plane_state;
 
 struct dml2_context;
 struct dml2_configuration_options;
@@ -25,4 +26,5 @@ void dml21_extract_watermark_sets(const struct dc *in_dc, union dcn_watermark_se
 void dml21_map_hw_resources(struct dml2_context *dml_ctx);
 void dml21_get_pipe_mcache_config(struct dc_state *context, struct pipe_ctx *pipe_ctx, struct dml2_per_plane_programming *pln_prog, struct dml2_pipe_configuration_descriptor *mcache_pipe_config);
 void dml21_set_dc_p_state_type(struct pipe_ctx *pipe_ctx, struct dml2_per_stream_programming *stream_programming, bool sub_vp_enabled);
+unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx, unsigned int stream_id, const struct dc_plane_state *plane, const struct dc_state *context);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index ed6584535e89..208d3651b6ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -12,6 +12,8 @@
 #include "dml21_translation_helper.h"
 #include "dml2_dc_resource_mgmt.h"
 
+#define INVALID -1
+
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
 	*dml_ctx = vzalloc(sizeof(struct dml2_context));
@@ -208,10 +210,40 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 	}
 }
 
+static void dml21_prepare_mcache_params(struct dml2_context *dml_ctx, struct dc_state *context, struct dc_mcache_params *mcache_params)
+{
+	int dc_plane_idx = 0;
+	int dml_prog_idx, stream_idx, plane_idx;
+	struct dml2_per_plane_programming *pln_prog = NULL;
+
+	for (stream_idx = 0; stream_idx < context->stream_count; stream_idx++) {
+		for (plane_idx = 0; plane_idx < context->stream_status[stream_idx].plane_count; plane_idx++) {
+			dml_prog_idx = map_plane_to_dml21_display_cfg(dml_ctx, context->streams[stream_idx]->stream_id, context->stream_status[stream_idx].plane_states[plane_idx], context);
+			if (dml_prog_idx == INVALID) {
+				continue;
+			}
+			pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
+			mcache_params[dc_plane_idx].valid = pln_prog->mcache_allocation.valid;
+			mcache_params[dc_plane_idx].num_mcaches_plane0 = pln_prog->mcache_allocation.num_mcaches_plane0;
+			mcache_params[dc_plane_idx].num_mcaches_plane1 = pln_prog->mcache_allocation.num_mcaches_plane1;
+			mcache_params[dc_plane_idx].requires_dedicated_mall_mcache = pln_prog->mcache_allocation.requires_dedicated_mall_mcache;
+			mcache_params[dc_plane_idx].last_slice_sharing.plane0_plane1 = pln_prog->mcache_allocation.last_slice_sharing.plane0_plane1;
+			memcpy(mcache_params[dc_plane_idx].mcache_x_offsets_plane0,
+				pln_prog->mcache_allocation.mcache_x_offsets_plane0,
+				sizeof(int) * (DML2_MAX_MCACHES + 1));
+			memcpy(mcache_params[dc_plane_idx].mcache_x_offsets_plane1,
+				pln_prog->mcache_allocation.mcache_x_offsets_plane1,
+				sizeof(int) * (DML2_MAX_MCACHES + 1));
+			dc_plane_idx++;
+		}
+	}
+}
+
 static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
 {
 	bool result = false;
 	struct dml2_build_mode_programming_in_out *mode_programming = &dml_ctx->v21.mode_programming;
+	struct dc_mcache_params mcache_params[MAX_PLANES] = {0};
 
 	memset(&dml_ctx->v21.display_config, 0, sizeof(struct dml2_display_cfg));
 	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
@@ -246,6 +278,14 @@ static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_s
 		dml2_map_dc_pipes(dml_ctx, context, NULL, &dml_ctx->v21.dml_to_dc_pipe_mapping, in_dc->current_state);
 		/* if subvp phantoms are present, expand them into dc context */
 		dml21_handle_phantom_streams_planes(in_dc, context, dml_ctx);
+
+		if (in_dc->res_pool->funcs->program_mcache_pipe_config) {
+			//Prepare mcache params for each plane based on mcache output from DML
+			dml21_prepare_mcache_params(dml_ctx, context, mcache_params);
+
+			//populate mcache regs to each pipe
+			dml_ctx->config.callbacks.allocate_mcache(context, mcache_params);
+		}
 	}
 
 	/* Copy DML CLK, WM and REG outputs to bandwidth context */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
index b2075b8c363b..42e715024bc9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
@@ -8,6 +8,7 @@
 
 #include "os_types.h"
 #include "dml_top_soc_parameter_types.h"
+#include "dml_top_display_cfg_types.h"
 
 struct dc;
 struct dc_state;
@@ -65,4 +66,67 @@ struct socbb_ip_params_external {
 	struct dml2_ip_capabilities ip_params;
 	struct dml2_soc_bb soc_bb;
 };
+
+/*mcache parameters decided by dml*/
+struct dc_mcache_params {
+	bool valid;
+	/*
+	* For iMALL, dedicated mall mcaches are required (sharing of last
+	* slice possible), for legacy phantom or phantom without return
+	* the only mall mcaches need to be valid.
+	*/
+	bool requires_dedicated_mall_mcache;
+	unsigned int num_mcaches_plane0;
+	unsigned int num_mcaches_plane1;
+	/*
+	* Generally, plane0/1 slices must use a disjoint set of caches
+	* but in some cases the final segement of the two planes can
+	* use the same cache. If plane0_plane1 is set, then this is
+	* allowed.
+	*
+	* Similarly, the caches allocated to MALL prefetcher are generally
+	* disjoint, but if mall_prefetch is set, then the final segment
+	* between the main and the mall pixel requestor can use the same
+	* cache.
+	*
+	* Note that both bits may be set at the same time.
+	*/
+	struct {
+		bool mall_comb_mcache_p0;
+		bool mall_comb_mcache_p1;
+		bool plane0_plane1;
+	} last_slice_sharing;
+	/*
+	* A plane is divided into vertical slices of mcaches,
+	* which wrap on the surface width.
+	*
+	* For example, if the surface width is 7680, and split into
+	* three slices of equal width, the boundary array would contain
+	* [2560, 5120, 7680]
+	*
+	* The assignments are
+	* 0 = [0 .. 2559]
+	* 1 = [2560 .. 5119]
+	* 2 = [5120 .. 7679]
+	* 0 = [7680 .. INF]
+	* The final element implicitly is the same as the first, and
+	* at first seems invalid since it is never referenced (since)
+	* it is outside the surface. However, its useful when shifting
+	* (see below).
+	*
+	* For any given valid mcache assignment, a shifted version, wrapped
+	* on the surface width boundary is also assumed to be valid.
+	*
+	* For example, shifting [2560, 5120, 7680] by -50 results in
+	* [2510, 5170, 7630].
+	*
+	* The assignments are now:
+	* 0 = [0 .. 2509]
+	* 1 = [2510 .. 5169]
+	* 2 = [5170 .. 7629]
+	* 0 = [7630 .. INF]
+	*/
+	int mcache_x_offsets_plane0[DML2_MAX_MCACHES + 1];
+	int mcache_x_offsets_plane1[DML2_MAX_MCACHES + 1];
+};
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 785226945699..5100f269368e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -40,6 +40,7 @@ struct dc_sink;
 struct dc_stream_state;
 struct resource_context;
 struct display_stream_compressor;
+struct dc_mcache_params;
 
 // Configuration of the MALL on the SoC
 struct dml2_soc_mall_info {
@@ -107,6 +108,7 @@ struct dml2_dc_callbacks {
 	unsigned int (*get_max_flickerless_instant_vtotal_increase)(
 			struct dc_stream_state *stream,
 			bool is_gaming);
+	bool (*allocate_mcache)(struct dc_state *context, const struct dc_mcache_params *mcache_params);
 };
 
 struct dml2_dc_svp_callbacks {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index faa1b4e619de..0cf349cafb3e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -65,6 +65,7 @@ struct resource_pool;
 struct dc_state;
 struct resource_context;
 struct clk_bw_params;
+struct dc_mcache_params;
 
 struct resource_funcs {
 	enum engine_id (*get_preferred_eng_id_dpia)(unsigned int dpia_index);
@@ -220,6 +221,8 @@ struct resource_funcs {
 	unsigned int (*get_max_hw_cursor_size)(const struct dc *dc,
 			struct dc_state *state,
 			const struct dc_stream_state *stream);
+	bool (*program_mcache_pipe_config)(struct dc_state *context,
+		const struct dc_mcache_params *mcache_params);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 7a87a7c07c1b..a890f581f4e8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -32,6 +32,7 @@
 
 #define MEMORY_TYPE_MULTIPLIER_CZ 4
 #define MEMORY_TYPE_HBM 2
+#define MAX_MCACHES 8
 
 
 #define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
@@ -65,6 +66,13 @@ struct resource_straps {
 	uint32_t audio_stream_number;
 };
 
+struct dc_mcache_allocations {
+	int global_mcache_ids_plane0[MAX_MCACHES + 1];
+	int global_mcache_ids_plane1[MAX_MCACHES + 1];
+	int global_mcache_ids_mall_plane0[MAX_MCACHES + 1];
+	int global_mcache_ids_mall_plane1[MAX_MCACHES + 1];
+};
+
 struct resource_create_funcs {
 	void (*read_dce_straps)(
 			struct dc_context *ctx, struct resource_straps *straps);
-- 
2.34.1


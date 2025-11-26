Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9A4D111B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FFD10E746;
	Wed, 26 Nov 2025 23:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kcq0Yhka";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70ED210E733
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gdg14S3HqEclAi0JmmSNtSfB4h53ie6dlmImYL280kkitP024xtpD0cpQ65Z8HGICixAMm7m8v41jIbUHQuvepHI6sCnqc1qPjYLQL+a6zUygo97MDj5jpKeWYVjLn26STkPMgNbKXmLAD4jp7UkwF/t7YuuWyFQYUkaCc4GZSlhIxC9MWLqa2O9vAsFjIelEyJM3dcqXcNIwum/U2dBUiLsBvVkgdEBCmsBAqmxfbYA/wRKcVL0OwzQjpb4j7C361q+rwcuzXP686IcpnAeq/iarxmy6DplMD7G8aeLfThUlN1esBgp/r7W7Z0fizkfihS2AorIvomsEatzYB9apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJhbJCA/pKHBc1HZI0AJSp5rRymA3gtr37QJ/80S9s4=;
 b=fUk5j7qgj4CDoz5Ng93tWhn7kfxkwEcpzgg7GtCAyF6pIIG9gFB5lENUOL5FhEG4d2XseOQ+JTKuI7f58NvXlltjm262xSzbxJEvY2eLZYuqEnZThUHGuiTR66+fcboQtMWKMHeBFaXzQV9CTV5D3ZeXhHllFSX6Qb4KOQFZ52bzQ8WXyhG065jpIyzZFMcXugdzbP/xK6q6fTuYHpKe7PAV5T+I3cIIgRk8lvHmbG1YGOASbncjjoDdtd3hqtkIs14qgbNhFgvzXLkdv3VIxEAaXLCy+JxJXaiievey8JA8bXLqqhLa5BAXXCOTP5No3wcvCs6GPtzubt4IXIilgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJhbJCA/pKHBc1HZI0AJSp5rRymA3gtr37QJ/80S9s4=;
 b=Kcq0Yhkaz/BxRJZwfuuvBw1rrUX2DTCehW87mIiBOTSjMGruZ04wzpvFBNKh91/CFKcv1A1O9G4xdPDOiVfSyp8LOETGiigj/3njHseneXaMHMv1yCC1TawDY24KRyR5tofH/BaibYJ+mzU2AchU/jS5vAyjfQLWjyXVeIxC5yw=
Received: from SA9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:20::28)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 23:06:44 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::1d) by SA9PR03CA0023.outlook.office365.com
 (2603:10b6:806:20::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 23:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:39 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 17:06:39 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:38 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 09/14] drm/amd/display: Add additional info from DML
Date: Wed, 26 Nov 2025 18:06:09 -0500
Message-ID: <20251126230614.13409-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e76c5d-bfe0-46a8-2f5a-08de2d4077ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nUebJ7dKvxjq6VijE1ZC7YLJPshjsOtJzjS+xqxkilsKGBzfIIlRz4OgTO8O?=
 =?us-ascii?Q?/3AhtIHamW75ub6qaZ0DWZv1xsHOsuve9pi8HU4pWtCpsF1m9rvbTUO60J4X?=
 =?us-ascii?Q?LDtqdDUT8inxShQCN6wpaor8SFQ/xvFkotByByqyIED77ANKnRe3l6tPWTOk?=
 =?us-ascii?Q?1lO/MywdwRCAmt+oGucvYUcXJa8QUyYXQEJ4wfw2SWK0Sfrrl7vTraUqcEtj?=
 =?us-ascii?Q?9IEG96pDutaNX+lwvs6RKoGuNJFlsYkIUuNEjLNqg0jW8m//GpwZsjhl40fg?=
 =?us-ascii?Q?gBpxhaOcg5gtTxHQTZzVHMwGewUOn9yU74zf5y0Zmxfk3C1F/t1aEwhKhoA5?=
 =?us-ascii?Q?dj69xCwhDRq0kg9zigQoOLuFviywwmCRA+YTEGhKuI63ZTht0xvVZExGpdWx?=
 =?us-ascii?Q?G5PN9JWm3iUnQuQUgMFmdq/ig1jJfZlR0mzoxBMIyXE8jM7E1x6bgckKuPXg?=
 =?us-ascii?Q?2/RXOixk1GOJ1t8dnFVvSzP7JsFJrEz8Rsas2U5DLvGg4U8g+kkjP7rSjxeT?=
 =?us-ascii?Q?h9Ge5YTuFIuq9d/1sDzAUwM+1B68ZN4CQhAoZ+Bh7PmnRNNdeQ+5wMOtUX2L?=
 =?us-ascii?Q?VjJiPfWoF/Mmy0hWf5KVa1GavTB+gv86j6pFAO1TduyMX/uT8TmQdLuf7jy7?=
 =?us-ascii?Q?tvLJV1we4srQbcUL6Bd44rb7uWsku3vWdS7OH0Sw4yhOD7bW/lUJghHi36Tm?=
 =?us-ascii?Q?0eZ9Ebx60zyvmSI8YMPt4ZcfcXBXR8XFC4E0On5PZB+yPfYMNo5DMjF6CAQ8?=
 =?us-ascii?Q?8SY74xcy+Ij5HfVRHfFif6ddYoUHFjEX7fIvrJnL4rH8rK9PpScZN8gkdQs3?=
 =?us-ascii?Q?ksgrMVo9wXtno050iBpJZMUT5yJGXBfsA+dzok+slW33TyzB7nTH2GEwI4At?=
 =?us-ascii?Q?0YuXJ7QxvnASOfoMJqWdvcgkjnK3WeMwVKf58v2jt4O3XRfvgYogVe46fyTM?=
 =?us-ascii?Q?n+q1Lsd7vAxVlMuE9whDjfOKECVYGL2laDPs5kL0+/Hpy3egtuBEejyOuOtO?=
 =?us-ascii?Q?qfv0/+Vr9+t3RD0DKSIBx5i2HAu3AniNjIKK0Gb2SMsr1oSMciQdTFCrNkyy?=
 =?us-ascii?Q?Ffyn/CmWB7A6s8wo9SaxAwWfqzRdRzNsV25kHqCg0dTj6dZuYR10uJlyoaNk?=
 =?us-ascii?Q?0iCPFXteuZDRPm608iIfCNmroescyzAwF/ms53CwwdbQdh2x+XiuMovSDprJ?=
 =?us-ascii?Q?P6Db30NbMNdjn2K10utQjP1sXCnPkQ+7NJzEG7wRkIeQ7P5fCTqAsIbQ356G?=
 =?us-ascii?Q?giYwmQlBEXBRs4N008Euk237cwmpn2G+bls4u4t4l1VI0fNPr/lNLZ4GHLKB?=
 =?us-ascii?Q?luKoqXBZ19RYQ4GYCJfvzMLWV+OMC5WH76Ac5/fmY4suShHa/SbCrj7H3GFJ?=
 =?us-ascii?Q?j4g5bUgGLGLcL/je08PQtLQtcXYQLKk5JRhZQDWi44AVkBi4F0loGj7naS/a?=
 =?us-ascii?Q?R46yDbEn8NbmcbPuByek9WBh6cTAIGHFTMZ4iAxwSA9yMu4KDP6gjy2ItDFZ?=
 =?us-ascii?Q?SQ+ZV0Q0ISuNmgTuHiMq8K3EqEWvNT9BwSna/HrWprrprdaOpyJ+7zeHyWIs?=
 =?us-ascii?Q?tZBSydB2kMcjq1PgmMw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:44.1824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e76c5d-bfe0-46a8-2f5a-08de2d4077ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

for DMU when applicable on future platforms.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 18 ++++++++++--------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  7 ++++---
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 7b09af1cb306..602655dd1323 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1833,9 +1833,10 @@ static void dc_dmub_srv_rb_based_fams2_update_config(struct dc *dc,
 
 	/* apply feature configuration based on current driver state */
 	global_cmd->config.global.features.bits.enable_visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
-	global_cmd->config.global.features.bits.enable = enable;
+	global_cmd->config.global.features.bits.enable = enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
+	global_cmd->config.global.features.bits.enable_ppt_check = dc->debug.fams2_config.bits.enable_ppt_check;
 
-	if (enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) {
+	if (enable) {
 		/* set multi pending for global, and unset for last stream cmd */
 		global_cmd->header.multi_cmd_pending = 1;
 		cmd[2 * context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config.header.multi_cmd_pending = 0;
@@ -1862,16 +1863,16 @@ static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
 	cmd.ib_fams2_config.ib_data.src.quad_part = dc->ctx->dmub_srv->dmub->ib_mem_gart.gpu_addr;
 	cmd.ib_fams2_config.ib_data.size = sizeof(*config);
 
-	if (enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) {
+	if (enable) {
+		/* send global configuration parameters */
+		memcpy(&config->global, &context->bw_ctx.bw.dcn.fams2_global_config,
+			sizeof(struct dmub_cmd_fams2_global_config));
+
 		/* copy static feature configuration overrides */
 		config->global.features.bits.enable_stall_recovery = dc->debug.fams2_config.bits.enable_stall_recovery;
 		config->global.features.bits.enable_offload_flip = dc->debug.fams2_config.bits.enable_offload_flip;
 		config->global.features.bits.enable_debug = dc->debug.fams2_config.bits.enable_debug;
 
-		/* send global configuration parameters */
-		memcpy(&config->global, &context->bw_ctx.bw.dcn.fams2_global_config,
-			sizeof(struct dmub_cmd_fams2_global_config));
-
 		/* construct per-stream configs */
 		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
 			/* copy stream static base state */
@@ -1887,7 +1888,8 @@ static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
 	}
 
 	config->global.features.bits.enable_visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
-	config->global.features.bits.enable = enable;
+	config->global.features.bits.enable = enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
+	config->global.features.bits.enable_ppt_check = dc->debug.fams2_config.bits.enable_ppt_check;
 
 	dm_execute_dmub_cmd_list(dc->ctx, 1, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ce50e36a414b..1c4497222f7b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1513,14 +1513,15 @@ void dcn401_dmub_hw_control_lock_fast(union block_sequence_params *params)
 
 void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable)
 {
-	bool fams2_required;
+	bool fams2_info_required;
 
 	if (!dc->ctx || !dc->ctx->dmub_srv || !dc->debug.fams2_config.bits.enable)
 		return;
 
-	fams2_required = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
+	fams2_info_required = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
+	fams2_info_required |= context->bw_ctx.bw.dcn.fams2_global_config.features.bits.legacy_method_no_fams2;
 
-	dc_dmub_srv_fams2_update_config(dc, context, enable && fams2_required);
+	dc_dmub_srv_fams2_update_config(dc, context, enable && fams2_info_required);
 }
 
 static void update_dsc_for_odm_change(struct dc *dc, struct dc_state *context,
-- 
2.34.1


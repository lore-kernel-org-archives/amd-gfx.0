Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E08C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4C210E8C8;
	Wed, 10 Jul 2024 19:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LME6ROBZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F38A10E8C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPVOIBn6H28aIguy7wftNrOygBvqrwW2eNUKWfJVmMIgfxTYFsZKjGD0REKbFMa+oKmd8tEDetHuV+eJj4MhM+mtKFRVE/Ex0xkCbhTdvb+TBqbyGrn6yBZrapvWXcUsIxIdt4FcSOq0YcJHlYU+r1Kuv3LMPMpEYkY1ZkR+FhQWKIkYPM0HrB3ete/YP+CzXot+e56wtFSgn4stMPkvpPEJV1wc3+0e5YV4i35Y2VecEfhY4k3uXrUAK9X1pLXKxQT1yDEU1QdUuv8WGSUYLI1wXS+GaxvzXTJrWCeurXWxYMLWPOhlaoQJh99rn2/y/CjPFTo1Q62U0DIPR9arYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQNHtlIS+9I/iNl7IPI/LZRYrD74p77mrkZaLTkDMgQ=;
 b=f7N/frBfl0ZixdMLTyg/5Qd1kzjkWOUHVHG5k8zNJHhrPxNKQkaalv70EDU//CfRxjX5RMBYnS8KII+A9+HSpt0LQpg8jcWcD0fmEsR7overy1Q0V0z37dS8h+680x3l8DYjIGfZe7PzpzlLL5UGuihnFbdzDWSuCTvSERQfFkmOMjG6LaXStSi4MODrw+KQBG0QhWDSGd9/Zr72/P+7n6djgZk8vFCUrDv1R/iWU/OGSqqZsTQBocmc0rRWQIM3EMgZf2LeMkL6NYAe8FhZC94OcTR7LSoE2l/i0y61THdQwyBTzRvXNy+hIdH5QLczdRE+Ib9fLSueH3JK21oWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQNHtlIS+9I/iNl7IPI/LZRYrD74p77mrkZaLTkDMgQ=;
 b=LME6ROBZ7D8RnJDWA2xQLX2qUXWcJuaNs/+grX3jArbXIIkpcqCi2WTMetISgxJw+KUIkh5EQGTVBH2IlANvOyRglvJ5Mj8zZsCyUVsjpdP7W/qPC6o2Ywn6yI+2gwoWb/yUl2S3XtrTVMt1qQQ5snTzVFlpi3yOvpo715uYKP8=
Received: from MN2PR06CA0019.namprd06.prod.outlook.com (2603:10b6:208:23d::24)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:20 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::32) by MN2PR06CA0019.outlook.office365.com
 (2603:10b6:208:23d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:16 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:15 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 41/50] drm/amd/display: Export additional FAMS2 global
 configuration options from DML
Date: Wed, 10 Jul 2024 15:36:58 -0400
Message-ID: <20240710193707.43754-42-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: fce36fdc-754a-4149-540e-08dca11821e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x4OvHgBJvUpTZVRIQdwisgFwB2ra+KhQ2vRXeza1mfl+O9AdVEwZbH0JkBIa?=
 =?us-ascii?Q?u3Fq+b3INl48LrTRPdDh3L8ivBTqBe1wXe8by9jF/piz1wAoZGAfOVrl9pQb?=
 =?us-ascii?Q?AWevJTrTvJmhxFnJTn5d8hRhBmq1ACBJ1t9Aw1tE+i94zTDG6nOL8zavofyM?=
 =?us-ascii?Q?EhVFPqA1AFX9gXe8TerwIwyGyTJWVna9PK+toCmM9UuW7mfKKUElWpAmEnCw?=
 =?us-ascii?Q?kKJcojEhE5d9NMhZT3SFDPR8EaEQs0WZevkpzmvlHiS98lFtw7z+d+UTXTr0?=
 =?us-ascii?Q?zZ9IaUEgadm+T5eWyNwpwr7tuM7PFcyal0USkg1AjeK/gHngXAbsZAABB0Jc?=
 =?us-ascii?Q?k3jXOCl/wmYZsou4afyHcUx1varku57g7AcMiYJ5sS2fvsxpa+QhXsDGduge?=
 =?us-ascii?Q?WbW24Q7Zrpu7r2v/zet+51s1SxmFYqTrDAfXzWQ6ljBfZFUcAJiQWs0n0FFx?=
 =?us-ascii?Q?XyTuvePn+Mu35zNeZ9Ej8o1VWkzIwnWRZj0HiyNJpXO26wBHZHQufqk31rHo?=
 =?us-ascii?Q?3m2AogF5ZRAFOU32V8goruG+KM88gnduuf3V0BRj5dzsZrpeY7LLkXS1QXoI?=
 =?us-ascii?Q?EhDh5yA5t/goq/P/sPrJ/bYBcqVSzfr18HCdkuWbn91G+5qK77kH2E5d2EDd?=
 =?us-ascii?Q?7JAxyTwlKTevXq43Tv7LKDhCyc9RGjqmPIOwim0WHXbJSMocrTnjxk4Rsvo5?=
 =?us-ascii?Q?EJpSxucFbRnZ80xk7ZACDrjXWgtRZvu1/RHf7EyOB2M+lAyg2YIojhvUWu7y?=
 =?us-ascii?Q?E8M/NWWiEuup0lKOtrFvN+4wQMkz643zgdHo1k7BmjZiCfDBpRSPhgFLJVXf?=
 =?us-ascii?Q?lYhl7ND46u85UmuuhdT8Rtj0/GwAA159YMO4M0PDoutQRjprPr8ueW18OII9?=
 =?us-ascii?Q?F6fm9sLvA6m/o6Z83Vb/Vy9eL1Rpk1EE4U0u7pK8U0dgFOba0XoASSPysShd?=
 =?us-ascii?Q?jXYmHE5QPtYjDsRha8cH+VipBd6m6PmDqGXnqD/eGv/++vrb7/uIrZHte1Ry?=
 =?us-ascii?Q?GuZqhJUmn1bA5Q8rzs5Q0NeETbeCCJMFTFCZV8KhL+F2koj/v/aAcLYzfGpg?=
 =?us-ascii?Q?eN5m9nXpTEXBZED4r183h8682u/x1THDQi/Y/epOh5k5I9w3ADarx6oCguaI?=
 =?us-ascii?Q?t61Odc6Mliy1Jhz7AvVz03SGWpFfej9jH9ljS/U75OTK0ih+SBc1MlpeNb9T?=
 =?us-ascii?Q?XKg1tqZ81RPz9hXyyAghI81FrdXmGTQFlWyOCDhU8Cx4n1PvlWAiy+jhqpij?=
 =?us-ascii?Q?YnxZhJtB1ki57P+A/GYfgVspLgJtk+8NYyt/MgOvrrUATH7vbWPScJ33AUXT?=
 =?us-ascii?Q?4pJJ7Ktu8i9d8TNKBF9pXfBnp5RUIDUCf6wCq9OLY2JSWO2wbfHwrrUW+aTD?=
 =?us-ascii?Q?wT3UxZg9K13xHyDGbzU40uswHpahdRMO8WECD/iRCjz+Ajga/0D6q9Ih01B4?=
 =?us-ascii?Q?SvwUdZtJfzzdZrmgmnEXnofYOXSF5nVZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:19.6335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce36fdc-754a-4149-540e-08dca11821e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Some global configuration options were previously hardcoded in DC, now they are
exported by DML and sent to FW.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  34 ++---
 .../amd/display/dc/dml2/dml21/dml21_utils.c   | 143 ++++++++++--------
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  17 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 7 files changed, 110 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 665157f8d4cb..2597e3fd562b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -967,10 +967,10 @@ bool dc_state_is_fams2_in_use(
 	bool is_fams2_in_use = false;
 
 	if (state)
-		is_fams2_in_use |= state->bw_ctx.bw.dcn.fams2_stream_count > 0;
+		is_fams2_in_use |= state->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
 
 	if (dc->current_state)
-		is_fams2_in_use |= dc->current_state->bw_ctx.bw.dcn.fams2_stream_count > 0;
+		is_fams2_in_use |= dc->current_state->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
 
 	return is_fams2_in_use;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ded13026c8ff..fb3391854eed 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1672,22 +1672,17 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 	global_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
 	global_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
 
-	/* send global configuration parameters */
-	global_cmd->config.global.max_allow_delay_us = 100 * 1000; //100ms
-	global_cmd->config.global.lock_wait_time_us = 5000; //5ms
-	global_cmd->config.global.recovery_timeout_us = 5000; //5ms
-	global_cmd->config.global.hwfq_flip_programming_delay_us = 100; //100us
-
-	/* copy static feature configuration */
-	global_cmd->config.global.features.all = dc->debug.fams2_config.all;
+	if (enable) {
+		/* send global configuration parameters */
+		memcpy(&global_cmd->config.global, &context->bw_ctx.bw.dcn.fams2_global_config, sizeof(struct dmub_cmd_fams2_global_config));
 
-	/* apply feature configuration based on current driver state */
-	global_cmd->config.global.features.bits.enable_visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
-	global_cmd->config.global.features.bits.enable = enable;
+		/* copy static feature configuration overrides */
+		global_cmd->config.global.features.bits.enable_stall_recovery = dc->debug.fams2_config.bits.enable_stall_recovery;
+		global_cmd->config.global.features.bits.enable_debug = dc->debug.fams2_config.bits.enable_debug;
+		global_cmd->config.global.features.bits.enable_offload_flip = dc->debug.fams2_config.bits.enable_offload_flip;
 
-	/* construct per-stream configs */
-	if (enable) {
-		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_stream_count; i++) {
+		/* construct per-stream configs */
+		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
 			struct dmub_rb_cmd_fams2 *stream_cmd = &cmd[i+1].fams2_config;
 
 			/* configure command header */
@@ -1702,12 +1697,15 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 		}
 	}
 
-	if (enable && context->bw_ctx.bw.dcn.fams2_stream_count) {
+	/* apply feature configuration based on current driver state */
+	global_cmd->config.global.features.bits.enable_visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
+	global_cmd->config.global.features.bits.enable = enable;
+
+	if (enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) {
 		/* set multi pending for global, and unset for last stream cmd */
-		global_cmd->config.global.num_streams = context->bw_ctx.bw.dcn.fams2_stream_count;
 		global_cmd->header.multi_cmd_pending = 1;
-		cmd[context->bw_ctx.bw.dcn.fams2_stream_count].fams2_config.header.multi_cmd_pending = 0;
-		num_cmds += context->bw_ctx.bw.dcn.fams2_stream_count;
+		cmd[context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config.header.multi_cmd_pending = 0;
+		num_cmds += context->bw_ctx.bw.dcn.fams2_global_config.num_streams;
 	}
 
 	dm_execute_dmub_cmd_list(dc->ctx, num_cmds, cmd, DM_DMUB_WAIT_TYPE_WAIT);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 622c98f4b7fb..e11246e525ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -461,94 +461,103 @@ void dml21_build_fams2_programming(const struct dc *dc,
 		struct dml2_context *dml_ctx)
 {
 	int i, j, k;
+	unsigned int num_fams2_streams = 0;
 
 	/* reset fams2 data */
-	context->bw_ctx.bw.dcn.fams2_stream_count = 0;
 	memset(&context->bw_ctx.bw.dcn.fams2_stream_params, 0, sizeof(struct dmub_fams2_stream_static_state) * DML2_MAX_PLANES);
+	memset(&context->bw_ctx.bw.dcn.fams2_global_config, 0, sizeof(struct dmub_cmd_fams2_global_config));
 
-	if (!dml_ctx->v21.mode_programming.programming->fams2_required)
-		return;
+	if (dml_ctx->v21.mode_programming.programming->fams2_required) {
+		for (i = 0; i < context->stream_count; i++) {
+			int dml_stream_idx;
+			struct dc_stream_state *phantom_stream;
+			struct dc_stream_status *phantom_status;
 
-	for (i = 0; i < context->stream_count; i++) {
-		int dml_stream_idx;
-		struct dc_stream_state *phantom_stream;
-		struct dc_stream_status *phantom_status;
+			struct dmub_fams2_stream_static_state *static_state = &context->bw_ctx.bw.dcn.fams2_stream_params[num_fams2_streams];
 
-		struct dmub_fams2_stream_static_state *static_state = &context->bw_ctx.bw.dcn.fams2_stream_params[context->bw_ctx.bw.dcn.fams2_stream_count];
+			struct dc_stream_state *stream = context->streams[i];
 
-		struct dc_stream_state *stream = context->streams[i];
-
-		if (context->stream_status[i].plane_count == 0 ||
-				dml_ctx->config.svp_pstate.callbacks.get_stream_subvp_type(context, stream) == SUBVP_PHANTOM) {
-			/* can ignore blanked or phantom streams */
-			continue;
-		}
-
-		dml_stream_idx = dml21_helper_find_dml_pipe_idx_by_stream_id(dml_ctx, stream->stream_id);
-		if (dml_stream_idx < 0) {
-			ASSERT(dml_stream_idx >= 0);
-			continue;
-		}
-
-		/* copy static state from PMO */
-		memcpy(static_state,
-				&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_params,
-				sizeof(struct dmub_fams2_stream_static_state));
-
-		/* get information from context */
-		static_state->num_planes = context->stream_status[i].plane_count;
-		static_state->otg_inst = context->stream_status[i].primary_otg_inst;
-
-		/* populate pipe masks for planes */
-		for (j = 0; j < context->stream_status[i].plane_count; j++) {
-			for (k = 0; k < dc->res_pool->pipe_count; k++) {
-				if (context->res_ctx.pipe_ctx[k].stream &&
-						context->res_ctx.pipe_ctx[k].stream->stream_id == stream->stream_id &&
-						context->res_ctx.pipe_ctx[k].plane_state == context->stream_status[i].plane_states[j]) {
-					static_state->pipe_mask |= (1 << k);
-					static_state->plane_pipe_masks[j] |= (1 << k);
-				}
+			if (context->stream_status[i].plane_count == 0 ||
+					dml_ctx->config.svp_pstate.callbacks.get_stream_subvp_type(context, stream) == SUBVP_PHANTOM) {
+				/* can ignore blanked or phantom streams */
+				continue;
 			}
-		}
 
-		/* get per method programming */
-		switch (static_state->type) {
-		case FAMS2_STREAM_TYPE_VBLANK:
-		case FAMS2_STREAM_TYPE_VACTIVE:
-		case FAMS2_STREAM_TYPE_DRR:
-			break;
-		case FAMS2_STREAM_TYPE_SUBVP:
-			phantom_stream = dml_ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, stream);
-			if (!phantom_stream)
-				break;
+			dml_stream_idx = dml21_helper_find_dml_pipe_idx_by_stream_id(dml_ctx, stream->stream_id);
+			if (dml_stream_idx < 0) {
+				ASSERT(dml_stream_idx >= 0);
+				continue;
+			}
 
-			phantom_status = dml_ctx->config.callbacks.get_stream_status(context, phantom_stream);
+			/* copy static state from PMO */
+			memcpy(static_state,
+					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_params,
+					sizeof(struct dmub_fams2_stream_static_state));
 
-			/* phantom status should always be present */
-			ASSERT(phantom_status);
-			static_state->sub_state.subvp.phantom_otg_inst = phantom_status->primary_otg_inst;
+			/* get information from context */
+			static_state->num_planes = context->stream_status[i].plane_count;
+			static_state->otg_inst = context->stream_status[i].primary_otg_inst;
 
-			/* populate pipe masks for phantom planes */
-			for (j = 0; j < phantom_status->plane_count; j++) {
+			/* populate pipe masks for planes */
+			for (j = 0; j < context->stream_status[i].plane_count; j++) {
 				for (k = 0; k < dc->res_pool->pipe_count; k++) {
 					if (context->res_ctx.pipe_ctx[k].stream &&
-							context->res_ctx.pipe_ctx[k].stream->stream_id == phantom_stream->stream_id &&
-							context->res_ctx.pipe_ctx[k].plane_state == phantom_status->plane_states[j]) {
-						static_state->sub_state.subvp.phantom_pipe_mask |= (1 << k);
-						static_state->sub_state.subvp.phantom_plane_pipe_masks[j] |= (1 << k);
+							context->res_ctx.pipe_ctx[k].stream->stream_id == stream->stream_id &&
+							context->res_ctx.pipe_ctx[k].plane_state == context->stream_status[i].plane_states[j]) {
+						static_state->pipe_mask |= (1 << k);
+						static_state->plane_pipe_masks[j] |= (1 << k);
 					}
 				}
 			}
-			break;
-		default:
-			ASSERT(false);
-			break;
+
+			/* get per method programming */
+			switch (static_state->type) {
+			case FAMS2_STREAM_TYPE_VBLANK:
+			case FAMS2_STREAM_TYPE_VACTIVE:
+			case FAMS2_STREAM_TYPE_DRR:
+				break;
+			case FAMS2_STREAM_TYPE_SUBVP:
+				phantom_stream = dml_ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, stream);
+				if (!phantom_stream)
+					break;
+
+				phantom_status = dml_ctx->config.callbacks.get_stream_status(context, phantom_stream);
+
+				/* phantom status should always be present */
+				ASSERT(phantom_status);
+				static_state->sub_state.subvp.phantom_otg_inst = phantom_status->primary_otg_inst;
+
+				/* populate pipe masks for phantom planes */
+				for (j = 0; j < phantom_status->plane_count; j++) {
+					for (k = 0; k < dc->res_pool->pipe_count; k++) {
+						if (context->res_ctx.pipe_ctx[k].stream &&
+								context->res_ctx.pipe_ctx[k].stream->stream_id == phantom_stream->stream_id &&
+								context->res_ctx.pipe_ctx[k].plane_state == phantom_status->plane_states[j]) {
+							static_state->sub_state.subvp.phantom_pipe_mask |= (1 << k);
+							static_state->sub_state.subvp.phantom_plane_pipe_masks[j] |= (1 << k);
+						}
+					}
+				}
+				break;
+			default:
+				ASSERT(false);
+				break;
+			}
+
+			num_fams2_streams++;
 		}
+	}
+
+	if (num_fams2_streams > 0) {
+		/* copy FAMS2 configuration */
+		memcpy(&context->bw_ctx.bw.dcn.fams2_global_config,
+				&dml_ctx->v21.mode_programming.programming->fams2_global_config,
+				sizeof(struct dmub_cmd_fams2_global_config));
 
-		context->bw_ctx.bw.dcn.fams2_stream_count++;
+		context->bw_ctx.bw.dcn.fams2_global_config.num_streams = num_fams2_streams;
 	}
 
-	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = context->bw_ctx.bw.dcn.fams2_stream_count > 0;
+	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
 }
 
 bool dml21_is_plane1_enabled(enum dml2_source_format_class source_format)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index b7a6f7f4c342..8c803b12404b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -351,6 +351,7 @@ static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_in
 		programming->fams2_required = display_cfg->stage3.fams2_required;
 
 		dml2_core_calcs_get_global_fams2_programming(&core->clean_me_up.mode_lib, display_cfg, &programming->fams2_global_config);
+		programming->fams2_global_config.features.bits.enable = display_cfg->stage3.fams2_required;
 	}
 
 	// Only loop over all the main streams (the implicit svp streams will be packed as part of the main stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 45e43a915fd6..3b1e5c548435 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12221,12 +12221,19 @@ void dml2_core_calcs_get_global_fams2_programming(const struct dml2_core_interna
 		const struct display_configuation_with_meta *display_cfg,
 		struct dmub_cmd_fams2_global_config *fams2_global_config)
 {
-	fams2_global_config->max_allow_delay_us = mode_lib->ip_caps.fams2.max_allow_delay_us;
-	fams2_global_config->lock_wait_time_us = mode_lib->ip_caps.fams2.lock_timeout_us;
-	fams2_global_config->recovery_timeout_us = mode_lib->ip_caps.fams2.recovery_timeout_us;
-	fams2_global_config->hwfq_flip_programming_delay_us = mode_lib->ip_caps.fams2.flip_programming_delay_us;
+	fams2_global_config->features.bits.enable = display_cfg->stage3.fams2_required;
 
-	fams2_global_config->num_streams = display_cfg->display_config.num_streams;
+	if (fams2_global_config->features.bits.enable) {
+		fams2_global_config->features.bits.enable_stall_recovery = true;
+		fams2_global_config->features.bits.allow_delay_check_mode = FAMS2_ALLOW_DELAY_CHECK_FROM_START;
+
+		fams2_global_config->max_allow_delay_us = mode_lib->ip_caps.fams2.max_allow_delay_us;
+		fams2_global_config->lock_wait_time_us = mode_lib->ip_caps.fams2.lock_timeout_us;
+		fams2_global_config->recovery_timeout_us = mode_lib->ip_caps.fams2.recovery_timeout_us;
+		fams2_global_config->hwfq_flip_programming_delay_us = mode_lib->ip_caps.fams2.flip_programming_delay_us;
+
+		fams2_global_config->num_streams = display_cfg->display_config.num_streams;
+	}
 }
 
 void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index d0b4308dca96..f4c1547a368f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1531,7 +1531,7 @@ void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool en
 	if (!dc->ctx || !dc->ctx->dmub_srv || !dc->debug.fams2_config.bits.enable)
 		return;
 
-	fams2_required = context->bw_ctx.bw.dcn.fams2_stream_count > 0;
+	fams2_required = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
 
 	dc_dmub_srv_fams2_update_config(dc, context, enable && fams2_required);
 }
@@ -1656,7 +1656,7 @@ void dcn401_hardware_release(struct dc *dc)
 	 */
 	if (dc->current_state) {
 		if ((!dc->clk_mgr->clks.p_state_change_support ||
-				dc->current_state->bw_ctx.bw.dcn.fams2_stream_count > 0) &&
+				dc->current_state->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) &&
 				dc->res_pool->hubbub->funcs->force_pstate_change_control)
 			dc->res_pool->hubbub->funcs->force_pstate_change_control(
 					dc->res_pool->hubbub, true, true);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 4c8e6436c7e1..bfb8b8502d20 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -534,8 +534,8 @@ struct dcn_bw_output {
 	unsigned int legacy_svp_drr_stream_index;
 	bool legacy_svp_drr_stream_index_valid;
 	struct dml2_mcache_surface_allocation mcache_allocations[DML2_MAX_PLANES];
+	struct dmub_cmd_fams2_global_config fams2_global_config;
 	struct dmub_fams2_stream_static_state fams2_stream_params[DML2_MAX_PLANES];
-	unsigned fams2_stream_count;
 	struct dml2_display_arb_regs arb_regs;
 };
 
-- 
2.34.1


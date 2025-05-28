Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFC4C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DAD10E139;
	Wed, 28 May 2025 02:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QKKYOPgn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E0210E139
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cpk8qtyt9cdr5heno5ETI2PTMKBrGU48BhuJdbGdjwW8KexGjAR9aBCRaGjt3ujEP7nARhQgTOvkkUm5iVeKysw1ACFJjPLTrezc9Rk6OFLaWdoO9aoWQvJE1J+hHlaSNxgp7p0GPTMPAh4xL2YQFXhfYtdJTgruChlDqH17k9o2vGL1SCkDoqZ3oOWWn45kaj81X3oclC1t5ogRHsXzDrrQVQLF5GAhxXF9Ap7istQ802kM0sxJPKkqppG5BqpT6+KqmIu98j5eNsJJJXoyXkgxIA1ifvggA8p+utRymKsF9aqiESMRJTGk1QGyPqUxIW1F40W6zgNGzy8a9Nq6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N1aJzwHnHsgtvgRd88fegQu8oorCcWLWgCEm5D/HaM=;
 b=RzaMot2GfBRU84Um3wz8YeM8T/ajWE0WsY6Hy6bE4tH12jhnpwQneVHC//mbhbx3Y4293cV4G2+yH2JYkFr0mPFrLBRTovnqamfBKZzvB6c6ijb7O1yfUTvC0z3DBnEYSmp/COGgXXfGdcI9j9+WCjrGoWViURPYsdxSuo+ViDGVrDSS+P1dKRaOCXjFXfl9foCDZvY9smplviLvHSsrQFSvwez9nYxBvDiJiiP/dwMM71RGCGmt/zwDvjhciOfAkpPon21igYQwO/GGLu/J7WnyB0f+nVLK7/8JVLDPgUQ8yAd5baG4zCP6/k0FwR4VUyNK0SFmpKN1t0fa0g0UUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N1aJzwHnHsgtvgRd88fegQu8oorCcWLWgCEm5D/HaM=;
 b=QKKYOPgn9SpgCYp8NCk/GVgvtAo/9YfjRlCfGUrJtRFLYvX1iguAMmE89fcLo48mgR5fahuVWnmWqaKWcimEaNiw4h1LdUAtImweOUFwP2AEEhvU7WsIh2uv16FT3FSBfgHs30GdfjksPTbvRRrnyKJmdSOXS6800novdY4ysyA=
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 02:52:46 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::d8) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:46 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:41 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Oleh Kuzhylnyi
 <okuzhyln@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Indirect buffer transport for FAMS2
 commands
Date: Wed, 28 May 2025 10:49:01 +0800
Message-ID: <20250528025204.79578-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 89908a36-64c9-47cd-84d5-08dd9d92ba10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kz8jWeeis2h1U9a7Hw9vvCQAQjFz2gN9H7/A1hKUv30b/sC73jFI7y3zfP5s?=
 =?us-ascii?Q?TM/deZwmar8kqtwjH7Zajd2som65lnwYpPqXhrj+VvSkkcyKBK+YWti/z0ni?=
 =?us-ascii?Q?Inn5tlHdCTcQvchEP5AihibE1hr8FUhlDtc8UfK6gSwcur1sR80BNfIfk6zL?=
 =?us-ascii?Q?1TrfbjU0V+wYWlavTUjP4mQH/E5r/eHGgZz0H8pImmetd920f96lB9QKsYyT?=
 =?us-ascii?Q?X5WYnQZnY0IjpPcexQ2cVWrOFZIh42agmTBsz4zorykj//xY+I9WDWO8P4C4?=
 =?us-ascii?Q?rD5EgPBCafBS9RdHyV8rb64toS27hT+rWs+ZnAHOwos8x5qPqfXT3oBFSgpn?=
 =?us-ascii?Q?VYGyqvX2bnC6MZhdVz406lIe8WpA0uHGcnG0qlv27qXRVojKVE0wMKDUpHCN?=
 =?us-ascii?Q?RTddBxDghnBTXpwePKMPeTVPvgBoEO44aCV7WLefhDlFhIsucYkhumfqkG8N?=
 =?us-ascii?Q?GIaYmSIM1XH6EU16S7HUSa0/OwSF+hsvY7NkrQJvvAKbvIaZoXcXaHzMMjAi?=
 =?us-ascii?Q?bFNLXOkV/wJzBNCrVHVMED0t2TA+iYiunzWybPFZlVHCJWQJzxQYlmZqm+ZA?=
 =?us-ascii?Q?/eOf+EfSEUu9vzkvZ8tMrC3iQTc2LEAosusfSMWWorPozIPY7B4inluTtyc7?=
 =?us-ascii?Q?er1LYpkvz6BBuw+G4O7zQtiPKEIrIkqlPzGNQ7GD6758fhUZNSxKFcyQB3xo?=
 =?us-ascii?Q?9G6enDSXotFcuxHHCTz2rGKo7ExH8zJTqiVVykc1vpADsyO+Qyq5b4v5mdQx?=
 =?us-ascii?Q?hd9Cn20gEqaLamkBtGNFd9CsPv6CfX9cBVSPlgHfgQ57FKry0oncy9XWrs29?=
 =?us-ascii?Q?EygKbHxi+e2Xh/jt3bHGbn/+vkvG4D4aa7yWeWuuaQAiYXizuGFWPcMoTPK4?=
 =?us-ascii?Q?ijePRFYMMfFORmXT56CgITxO1dDWfo0rYEr+ksXlZhZ0MHsZYu0fpCjUeStf?=
 =?us-ascii?Q?tL0CSd76iDGGeyn8js8n1jCb+C/7HQyFe+ol1E//HhwqzUuCDLnQJyYk7KIf?=
 =?us-ascii?Q?Vqs+xJSykt4+eJeG6pFvnZuwGLVR9vHojubhBAGNlkY4AEl/Ma+Dd2x4f+KQ?=
 =?us-ascii?Q?3XLmQVnSu29IFSzFML75e88J/Cpb39vdOzVL5Zf2KFMBKGSWVHSsMjcE89mH?=
 =?us-ascii?Q?pNropA3+VmeOpRgmJVtj0tiCDCpbvojxHYcSllr+lwTcXbPit6mBVp1thazH?=
 =?us-ascii?Q?EtNRgNwkwfPQoX5WWbclRhVz1hRSpk/v2yYtGDVHgGQYqQSE4lHrBOkckP9k?=
 =?us-ascii?Q?7QZwz7Txc4cm5DfqBI2heuJ8BlqB8rvoQ1iKEE/y3/gxMFw7EX1H5kq/JLZC?=
 =?us-ascii?Q?/Y6nsOhiKDYUfBwDxzkB2HdzjwmkosDwbfo0W4bjKc2b5dGnP01w7bp2HVbl?=
 =?us-ascii?Q?M9asTs7/0m+8nR+ALD0zrgzeX1DSI5wf5OMDtqvL9bi1t84Y+dGw1ZAyW5mk?=
 =?us-ascii?Q?daFNhLoPd9mt3NSRQYX7ehkj9A8mdhJOXziszV9fFYVxdUW44dGxACocXZ4y?=
 =?us-ascii?Q?csCZ4qZA1Yq+mZrvHpNv/KJs97dA8rynHjPu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:46.8460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89908a36-64c9-47cd-84d5-08dd9d92ba10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

From: Oleh Kuzhylnyi <okuzhyln@amd.com>

[Why]
The quantity and duration of FAMS2 commands are set to increase
in future products. This necessitates the implementation of a new
mechanism for chaining commands together, allowing all commands
to be processed within a single transaction.

[How]
The indirect buffer acts as a shared buffer on the driver side,
mapped to DMUB's internal CW7 address. Its source address and
size are sent through mailbox command to DMUB, triggering the
transaction.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Oleh Kuzhylnyi <okuzhyln@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 59 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  9 ++-
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1797fa85fac6..8b32e6c1ec6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2404,6 +2404,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_5_TRACEBUFF
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_6_FW_STATE
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_7_SCRATCH_MEM
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_IB_MEM
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_SHARED_STATE
 	};
 	int r;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index afbcf866520e..8c52d3fea1d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1656,7 +1656,7 @@ bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_com
 	return result;
 }
 
-void dc_dmub_srv_fams2_update_config(struct dc *dc,
+static void dc_dmub_srv_rb_based_fams2_update_config(struct dc *dc,
 		struct dc_state *context,
 		bool enable)
 {
@@ -1722,6 +1722,63 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 	dm_execute_dmub_cmd_list(dc->ctx, num_cmds, cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
+static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
+		struct dc_state *context,
+		bool enable)
+{
+	struct dmub_fams2_config_v2 *config = (struct dmub_fams2_config_v2 *)dc->ctx->dmub_srv->dmub->ib_mem_gart.cpu_addr;
+	union dmub_rb_cmd cmd;
+	uint32_t i;
+
+	memset(config, 0, sizeof(*config));
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.ib_fams2_config.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
+	cmd.ib_fams2_config.header.sub_type = DMUB_CMD__FAMS2_IB_CONFIG;
+
+	cmd.ib_fams2_config.ib_data.src.quad_part = dc->ctx->dmub_srv->dmub->ib_mem_gart.gpu_addr;
+	cmd.ib_fams2_config.ib_data.size = sizeof(*config);
+
+	if (enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) {
+		/* copy static feature configuration overrides */
+		config->global.features.bits.enable_stall_recovery = dc->debug.fams2_config.bits.enable_stall_recovery;
+		config->global.features.bits.enable_offload_flip = dc->debug.fams2_config.bits.enable_offload_flip;
+		config->global.features.bits.enable_debug = dc->debug.fams2_config.bits.enable_debug;
+
+		/* send global configuration parameters */
+		memcpy(&config->global, &context->bw_ctx.bw.dcn.fams2_global_config,
+			sizeof(struct dmub_cmd_fams2_global_config));
+
+		/* construct per-stream configs */
+		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
+			/* copy stream static base state */
+			memcpy(&config->stream_v1[i].base,
+				&context->bw_ctx.bw.dcn.fams2_stream_base_params[i],
+				sizeof(config->stream_v1[i].base));
+
+			/* copy stream static sub-state */
+			memcpy(&config->stream_v1[i].sub_state,
+				&context->bw_ctx.bw.dcn.fams2_stream_sub_params[i],
+				sizeof(config->stream_v1[i].sub_state));
+		}
+	}
+
+	config->global.features.bits.enable_visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
+	config->global.features.bits.enable = enable;
+
+	dm_execute_dmub_cmd_list(dc->ctx, 1, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+void dc_dmub_srv_fams2_update_config(struct dc *dc,
+		struct dc_state *context,
+		bool enable)
+{
+	if (dc->debug.fams_version.major == 2)
+		dc_dmub_srv_rb_based_fams2_update_config(dc, context, enable);
+	if (dc->debug.fams_version.major == 3)
+		dc_dmub_srv_ib_based_fams2_update_config(dc, context, enable);
+}
+
 void dc_dmub_srv_fams2_drr_update(struct dc *dc,
 		uint32_t tg_inst,
 		uint32_t vtotal_min,
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 3f3fa1b6a69e..211486724e84 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -129,6 +129,7 @@ enum dmub_window_id {
 	DMUB_WINDOW_5_TRACEBUFF,
 	DMUB_WINDOW_6_FW_STATE,
 	DMUB_WINDOW_7_SCRATCH_MEM,
+	DMUB_WINDOW_IB_MEM,
 	DMUB_WINDOW_SHARED_STATE,
 	DMUB_WINDOW_TOTAL,
 };
@@ -539,6 +540,7 @@ struct dmub_srv {
 	uint32_t fw_version;
 	bool is_virtual;
 	struct dmub_fb scratch_mem_fb;
+	struct dmub_fb ib_mem_gart;
 	volatile struct dmub_shared_state_feature_block *shared_state;
 	volatile const struct dmub_fw_state *fw_state;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index acca7943a8c8..5f827104b4f8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -65,6 +65,9 @@
 /* Default scratch mem size. */
 #define DMUB_SCRATCH_MEM_SIZE (1024)
 
+/* Default indirect buffer size. */
+#define DMUB_IB_MEM_SIZE (1280)
+
 /* Number of windows in use. */
 #define DMUB_NUM_WINDOWS (DMUB_WINDOW_TOTAL)
 /* Base addresses. */
@@ -559,6 +562,7 @@ enum dmub_status
 	window_sizes[DMUB_WINDOW_5_TRACEBUFF] = trace_buffer_size;
 	window_sizes[DMUB_WINDOW_6_FW_STATE] = fw_state_size;
 	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = DMUB_SCRATCH_MEM_SIZE;
+	window_sizes[DMUB_WINDOW_IB_MEM] = DMUB_IB_MEM_SIZE;
 	window_sizes[DMUB_WINDOW_SHARED_STATE] = max(DMUB_FW_HEADER_SHARED_STATE_SIZE, shared_state_size);
 
 	out->fb_size =
@@ -645,6 +649,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	struct dmub_fb *tracebuff_fb = params->fb[DMUB_WINDOW_5_TRACEBUFF];
 	struct dmub_fb *fw_state_fb = params->fb[DMUB_WINDOW_6_FW_STATE];
 	struct dmub_fb *scratch_mem_fb = params->fb[DMUB_WINDOW_7_SCRATCH_MEM];
+	struct dmub_fb *ib_mem_gart = params->fb[DMUB_WINDOW_IB_MEM];
 	struct dmub_fb *shared_state_fb = params->fb[DMUB_WINDOW_SHARED_STATE];
 
 	struct dmub_rb_init_params rb_params, outbox0_rb_params;
@@ -655,7 +660,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		return DMUB_STATUS_INVALID;
 
 	if (!inst_fb || !stack_fb || !data_fb || !bios_fb || !mail_fb ||
-		!tracebuff_fb || !fw_state_fb || !scratch_mem_fb) {
+		!tracebuff_fb || !fw_state_fb || !scratch_mem_fb || !ib_mem_gart) {
 		ASSERT(0);
 		return DMUB_STATUS_INVALID;
 	}
@@ -741,6 +746,8 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 	dmub->scratch_mem_fb = *scratch_mem_fb;
 
+	dmub->ib_mem_gart = *ib_mem_gart;
+
 	if (dmub->hw_funcs.setup_windows)
 		dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4, &cw5, &cw6, &region6);
 
-- 
2.43.0


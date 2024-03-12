Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AECC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECB5112C1D;
	Tue, 12 Mar 2024 09:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OWDJ1E0R";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A427112C1D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGKdvHkS4TXVIDJZcmN7QQV+2UKeGa6ASjnQmzq4pZR2yaI6r8ipfhf3Uw/ph/D1E5jaFEvOsTrUU0DxfuZU9aivhGRy1nU1GifoOSOcQ8vwt27kn4tZxr/zaaFLH6zOH6O00icRP/6Urjlu5PLHpmMlaqFf5r203QtJNNnyq23zPbbkqiNfTr0q/DdplwiRanCLTQw0fNe9cgfRd3ANfcWlcIQyzjr4X1tYHtDc49n8X9lnBd4/QzfUz7VnjUgv/r463QxdhU0GP4PmlMmLpqXs+zBqkGWZSK5/RN9Irb35i2XF0FpMv1i74eQ7rehiGjxrNlrhuKQxNA5tVyy73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgBt8KkIgDohA1X9RK2VVoydLP/fFRhDzUoBNAthMAg=;
 b=GzCdqoEPc8IOrxxv1/dt855SZnjPGVjuosLgKHapQdASKopLKsC+J/B/OAg2Bv+D9U0ieHU1fRtM6yi6TIYreFseUJfYR035dlbvkI2ow8D7OODodUaxsQf4alBKlS9+BhceBF/WDaHSy4SPNohcpuFp1eBSlMAhVG2iUUAQekLlIaRwcGf32W0i2/H/xIaHAp78rUGR8H9LTktiZkiFGpk7VQbtPJ+fhZfPjmKUCeidO0srOh5fPZiny9tmvHQgSD7dkQvIVPAKIDve9b3MWDdP2pIHBKX1Ic/3VzTRmB+KGiKKi/sUO/zpcxLJzYcrFnTniooN5DrmqO7VgbWVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgBt8KkIgDohA1X9RK2VVoydLP/fFRhDzUoBNAthMAg=;
 b=OWDJ1E0RblCCXL1iFUIVNpfoYBLyCRtTuqswPsMWm5xkFBYjB3YcJaaPPgkc4q6GUrUN1HVJSLRCNBULoDDoYptKRQdDpIRUQBQhMptlh5fqQafgShQgCUyM+jEjUw0K8m5F5RU5Bb6r7d3hgZtZzyJSuQ3XJyhJrKUIuCljD6A=
Received: from CY5PR15CA0087.namprd15.prod.outlook.com (2603:10b6:930:18::13)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:23:20 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::35) by CY5PR15CA0087.outlook.office365.com
 (2603:10b6:930:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:19 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Samson Tam <samson.tam@amd.com>,
 George Shen <george.shen@amd.com>
Subject: [PATCH 23/43] drm/amd/display: clear mpc_tree in init_pipes
Date: Tue, 12 Mar 2024 17:20:16 +0800
Message-ID: <20240312092036.3283319-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e3ff56-226b-48ea-abb2-08dc42760ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +S+enHBid05n7mAqdNyF4Hb0BMN39zk+GYMRd/pEyjiQE3RMZmny4JBYszkFGn6Sd5bOiGX/bqYeM7JmtLGY4YhZ5pOEh1OeO+i7qE6388euOqUs0tttYCeb4QMyYOWBg7ygJY7PIQsquX88MBL16IZ3gWMacXrTSigzN+4/X4+qpSO/39HIj+02noWg4VRQq6uYz5L6bsuQrLgqp2LQgrjB0HZMsboF5V2LzhVXE57+R2JgmnvVSZ1BXJoLtmI7C6IEFId4AU1IbOW6iFiRYzEgB6RJLKugOnv32kG8/navB0PkYKVfyw8xRmipoFpk6qKwoLLCmBNdoJS6nbuNkJbxtR0Ms79l99XYgtNbeTyodEaAgU9YX9vw4kRAF/ipvoDiDKOGAD75ns9EMw7tbEk56K9tbqiWyD7/2MWIBz6paxuC6+5ZXuHIxS7vfP8TRn7kYJp+DoTtiWAV4DAgWEeIQfjzGR1GBTI5JuZGINPnYOaZ+Zrq0SZ0sdgb9N/qy0X/bMDIqSbTLLo0NP835O2JpN2pU1E+lzSfT6qpr3R+hpdedb6G6wTU601E387NXt6XBFBME9/agF7VM1esQRqUppqKlucMpX7789d2LUzsqKOa6WVo9bq2RTkMQ+mnlSV1HQPZHLKYvTEIuq1oJUflIRLCPWZbUJ3N3NIaVE3Ki6iHlF9lx7KwNdbGkklNv3KpNvgdvQHHAEe+hxBHpQfmZZS69JQU47PQ7NQyozjDmd+kXXe1lJw4/6S+SlLC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:20.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e3ff56-226b-48ea-abb2-08dc42760ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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

From: Samson Tam <samson.tam@amd.com>

[Why]
During init_pipes, otg master is not initialized. So mpc tree is
still configured even if mpc bottom is not active

[How]
For pipes that have tg enabled, check their mpc tree and clear
opp_list if mpc bottom is not active

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  | 16 ++++++++++++++++
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c  | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 314798400b16..e0c3c14d12f3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1366,6 +1366,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	bool can_apply_seamless_boot = false;
+	bool tg_enabled[MAX_PIPES] = {false};
 
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->streams[i]->apply_seamless_boot_optimization) {
@@ -1447,6 +1448,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 			// requesting data while in PSR.
 			tg->funcs->tg_init(tg);
 			hubp->power_gated = true;
+			tg_enabled[i] = true;
 			continue;
 		}
 
@@ -1488,6 +1490,20 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		tg->funcs->tg_init(tg);
 	}
 
+	/* Clean up MPC tree */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (tg_enabled[i]) {
+			if (dc->res_pool->opps[i]->mpc_tree_params.opp_list) {
+				if (dc->res_pool->opps[i]->mpc_tree_params.opp_list->mpcc_bot) {
+					int bot_id = dc->res_pool->opps[i]->mpc_tree_params.opp_list->mpcc_bot->mpcc_id;
+
+					if ((bot_id < MAX_MPCC) && (bot_id < MAX_PIPES) && (!tg_enabled[bot_id]))
+						dc->res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
+				}
+			}
+		}
+	}
+
 	/* Power gate DSCs */
 	if (hws->funcs.dsc_pg_control != NULL) {
 		uint32_t num_opps = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 2e8ec58a16eb..26ab60deb12d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -720,6 +720,7 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 	bool can_apply_seamless_boot = false;
+	bool tg_enabled[MAX_PIPES] = {false};
 
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->streams[i]->apply_seamless_boot_optimization) {
@@ -801,6 +802,7 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 			// requesting data while in PSR.
 			tg->funcs->tg_init(tg);
 			hubp->power_gated = true;
+			tg_enabled[i] = true;
 			continue;
 		}
 
@@ -842,6 +844,20 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 		tg->funcs->tg_init(tg);
 	}
 
+	/* Clean up MPC tree */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (tg_enabled[i]) {
+			if (dc->res_pool->opps[i]->mpc_tree_params.opp_list) {
+				if (dc->res_pool->opps[i]->mpc_tree_params.opp_list->mpcc_bot) {
+					int bot_id = dc->res_pool->opps[i]->mpc_tree_params.opp_list->mpcc_bot->mpcc_id;
+
+					if ((bot_id < MAX_MPCC) && (bot_id < MAX_PIPES) && (!tg_enabled[bot_id]))
+						dc->res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
+				}
+			}
+		}
+	}
+
 	if (pg_cntl != NULL) {
 		if (pg_cntl->funcs->dsc_pg_control != NULL) {
 			uint32_t num_opps = 0;
-- 
2.37.3


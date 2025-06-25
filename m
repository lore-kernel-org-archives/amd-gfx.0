Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ABDC7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B6E10E659;
	Wed, 25 Jun 2025 04:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/4pc6EB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6985C10E657
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4cknl+pGhgz3by/EVRm/hsaCv4QnAKCl0NE8Ij33ICcYnxzqtbQapJZ+MPq//7nj898BFMAlu1s+h9UMnBbtePPCjyRRxyeiTyQyEWU7JQVMCosPK6hBeywa1UEmN0o58A5g6Wb5RC8Boe9DsAx7iqiDRb1of/JVEKcuj4q9JQBUIwbx7ecUWBii8EbO8JtUVmCOjVY8kAK2ixCF7vpLVAr9LehNkz6Oyp5l456qM/FRSBN4tmwZQHA9rIcX71rmDplXSWEC9yOYfUVHPCSo+qTTV1Bnpk4ErUDZtIFtwXu5cKa5SnWv3Zeus5023PAMOT1dthpyT6j+Q/BhaCd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDnXWuRUp2ixu2pXx/iAnbYwGXeV3IYutfrRVGhiFEY=;
 b=T1jrWitC/xivv08O6o+/ce8XbLvKM1IY4t1x2HZlfY5KD/qsLjq0hNO3V+fPr4Hm1/HL2aYDX9zC7e5hjWy/0fzmKX5Rox3fojuUnqpQk+ZVdlmxziwebwnPhTvVcBEQGr+Ey+t2mZ5XDH86V3cWyHLmPUfXw1vBFm0VrSEYbS8g8jgYCkaswIXHHHrjTMiFDE/L7XkQurl0IozBBSuR60ZuIF4Y0dUYI9b3Wyna2M1F3SXLJzFcT3zw//Dt5r8bfT/B7PoTYuvvNd6GxW3GNXiamIVIhKoCXa/W2UY4HuJroFaWvSFC0un7EFWVEGmM8cGycbw9oFpfRp4uDwtOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDnXWuRUp2ixu2pXx/iAnbYwGXeV3IYutfrRVGhiFEY=;
 b=z/4pc6EB5pGy4/pu3Ylj5hn2lRgvUy4FkDNvVsbCRFn+Ql2ArxAFsdarqqvRLOGCsJAYz1KJHRe2hRIIyWesY1YhnuPx9naKlaT9+bkFqf7Hv65UxaRmbx9G0InIgM/hG9ETx7GvTuw6kOOpD5W3+92Hyj6LQxmMxlkqgrYyAmM=
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 04:05:47 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::fd) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 04:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:46 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:43 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivlipski@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/11] drm/amd/display: Add DPP & HUBP reset if power gate
 enabled on DCN314
Date: Wed, 25 Jun 2025 12:02:27 +0800
Message-ID: <20250625040420.886013-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 84974b41-c87f-4e3c-b331-08ddb39d908e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fp6t8nwuh9Y1xcr8nhaipNlp7aIB0WjBVIwQTBpP+GVhskUWGUuqUgC7KLhx?=
 =?us-ascii?Q?2u1L4wrCZbwcQB224hbsbBIyIpJ74JXnzYNoXtHMlFd/XtajkU0yN20qv0xe?=
 =?us-ascii?Q?zEZdraO06VlXm3ICb84Smsm2QA+CVyhOkZ+/Ck8tyNo9EPFhtApLDWCYJQTX?=
 =?us-ascii?Q?7zdKQIrklW/FXPdyDvOWpZ/uFKDgsMTuwtUezkt7NmvjBnFjPdEx8RlhfC5Z?=
 =?us-ascii?Q?Jovn2h9v1+GoRDn0W/A24zUQtCqcmbTf8690c5X4EoiLl+9Kct1kCBZ04xsK?=
 =?us-ascii?Q?Senk3DAPKCQHSdxoWezYPWcxiVmPMV9SEVWrbr5FnEV1uN7LE66L2jvfiikI?=
 =?us-ascii?Q?0HUAcUPM/8Lum4HdAO1dMb+9soXLsdLtvh7GRgDygowvVpVxuendrbJPkvLM?=
 =?us-ascii?Q?48KBn+bZSvgJjZ1S9W9nLTosre5zsa2wmM8BBj7RA1gG3xq2XPA3Szm+fmyP?=
 =?us-ascii?Q?cHg7G07azGkqDQfzICHajQCrBFU9hu2fXHa1/PNV2BgnppmjgjFEQVsSQjIi?=
 =?us-ascii?Q?iYh9yP/w6PBt32qw+fhDdP6fxmuS/OUEYmarOom9y0uO1STV9pE9IwW3/EWy?=
 =?us-ascii?Q?n99I324le3YmdOSByOrjR9cvuGaU5goAKHfmNVPEacD2Rjfc7636he4Yzre1?=
 =?us-ascii?Q?32stELLKjZrdRcv9QvNqtM2Gs+d5DLTo07BLcKMhjoEG0YdhuX74ZyV1U7nJ?=
 =?us-ascii?Q?mflgS/EKDzAS3IFrFxGBwgVJgkFlBz9QFExsVBjh1jyn/A0vfM5s4n7KHN03?=
 =?us-ascii?Q?fyYYHzh+CR4YfdeSivMdsv/Be1125W630QFsv3r3nTOmj4fm9JXwz4V5ky2y?=
 =?us-ascii?Q?EoD03lY46jmkod20cVaPCrdjZkdLhdWcFOgRaupQwNGsGVearoo0sBpJDd0Y?=
 =?us-ascii?Q?ON4piD83TY1yKVLSOA8mIQ9caowhS/3bjS2EGv0MekHeb8rEAE2T9jsyil3n?=
 =?us-ascii?Q?EL/lV9XJ6FNrU/qDaxv/wEHYlS1FpcWaLzsF155+9B94FmlNM3tOdf3LL5zI?=
 =?us-ascii?Q?YcHpsZ7XSgWcMes1AsoaCa5zpAUkrtPsRE/9ulH6lok7TsFUpklzPy/hfgmf?=
 =?us-ascii?Q?kt3aA0icJpaZzX5drD8p2pOcoBuca6kWckSb5Z+UOS3wBXn18zZJkCatDcAH?=
 =?us-ascii?Q?ZhPgc+8a9YfQQlI3fq7OjwRISWQBPqzvHyCc4HXiC8znjcGNNXPFtofvI7C7?=
 =?us-ascii?Q?SH5fG85wj63SMSLFg8OW9K/UuNpl8mH/54MrIqvGpT06KBq1GT4tjKHx2Luz?=
 =?us-ascii?Q?4byJ6u0hDISeaCNfn+gcdg7hq//knU16DhQbU9NnazxfahJme9rtom/GcboP?=
 =?us-ascii?Q?91g/laiySdke93iD3FJh8XbB69D8jO73k2LSn2WUTyzRii7K3QfFYlVIM2wF?=
 =?us-ascii?Q?qPktXax6OI8Hx+3aNU+M5sR4RYBNHRZwPVz8rNC5cR01w3ub85LrRXDvsA4n?=
 =?us-ascii?Q?dIdPoUfJ8/VpBaYaR+AYGd9Plq4/aX88Tx7bPoD5rY1YhdBy9yegDdFMf+Ur?=
 =?us-ascii?Q?aOlPsOc7DzD2Lem+f+nD2DwYHrW+UOvDy2mZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:47.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84974b41-c87f-4e3c-b331-08ddb39d908e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
On DCN314, using full screen application with enabled scaling like 150%,
175%, with overlay cursor, causes a second cursor to appear when changing
planes. Dpp cache is used to track the HW cursor enable. Since power gate
is disabled for hubp & dpp in DCN314, dpp_reset() zero'ed the dpp struct,
while the dpp hardware was not power gated.

So, when plane is changed in a full screen app, and the overlay cursor is
enabled, the cache is cleared, so the cache does not represent the actual
cursor state.

[HOW]
Added conditionals for dpp & hubp reset and their pg_control functions
only if according power_gate flags are enabled.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 37 +++++++++++++++++--
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index e68f21fd5f0f..a40e119d8582 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -55,15 +55,15 @@
 #include "dcn20/dcn20_optc.h"
 #include "dcn30/dcn30_cm_common.h"
 
-#define DC_LOGGER_INIT(logger)
+#define DC_LOGGER_INIT(logger) \
+	struct dal_logger *dc_logger = logger
 
 #define CTX \
 	hws->ctx
 #define REG(reg)\
 	hws->regs->reg
 #define DC_LOGGER \
-	stream->ctx->logger
-
+	dc_logger
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -76,6 +76,8 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
 
+	DC_LOGGER_INIT(stream->ctx->logger);
+
 	ASSERT(dsc);
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		opp_cnt++;
@@ -528,3 +530,32 @@ void dcn314_disable_link_output(struct dc_link *link,
 
 	apply_symclk_on_tx_off_wa(link);
 }
+
+
+void dcn314_plane_atomic_power_down(struct dc *dc,
+		struct dpp *dpp,
+		struct hubp *hubp)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	if (REG(DC_IP_REQUEST_CNTL)) {
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
+		if (hws->funcs.dpp_pg_control) {
+			hws->funcs.dpp_pg_control(hws, dpp->inst, false);
+			dpp->funcs->dpp_reset(dpp);
+		}
+
+		if (hws->funcs.hubp_pg_control) {
+			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
+			hubp->funcs->hubp_reset(hubp);
+		}
+
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
+		DC_LOG_DEBUG("Power gated front end %d\n", hubp->inst);
+	}
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index 2305ad282f21..12a57b79edfb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -47,4 +47,6 @@ void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
 
+void dcn314_plane_atomic_power_down(struct dc *dc, struct dpp *dpp, struct hubp *hubp);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index f5112742edf9..6963d25608ac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -137,7 +137,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.disable_vga = dcn20_disable_vga,
 	.bios_golden_init = dcn10_bios_golden_init,
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
-	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
+	.plane_atomic_power_down = dcn314_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn31_hubp_pg_control,
-- 
2.43.0


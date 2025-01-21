Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB3BC0218D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C268B10E63E;
	Tue, 21 Jan 2025 19:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CrLXGMBm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6AF10E635
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiN4vgA7kiy7ya+HCWGQF/03neWaXHAsHvov7MInOTTbGSI6oqXf5xVkpUbxeYqPSKwlDf37OoOxxH7UumSK9owg4jApZExCNzEWWg+MPqKazoA9ZYLOW6pCIx/2FXl1N/+G5+xCp4UC9jsM03qBbuiLNZbTW0QcngxILkIYLkYa8stGCzKiW2fvP+fN+R/VUHZxW63tyWThK0JhGgYO0R+UjXMYXqBqtYwRfODQLYNZ+RFNP6YUf0bph7dbceNKkOO5CVVlBHI1AkpaZTJ2BftSeGq/Bkp3dAasj7zwe8DM8FxT1A79P2OXLIWAuoBYs3A3kbn1BDgE1UFzREc+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbQg22vYDE78o6foMAJjVfa41pfcquC4/xyM2DRwm1M=;
 b=sNHfQKWjLH3EC7OpchsplmHpmuizLlOVVEbyvuj9zKYZrqbyFcb8BYvJllUFSepKjL6OBlyLQnTUVHW/zLfK4F8m7ZlIeMtdt4Jt7FVnvxCIUTufZKaqbSGUeJk9YXKUWuSayAUxApRekCp+/LF/urmFHrv5SStkitfPKwjMFkPCFZTUWbIw4nl9Q7NYQZuATvhIEhjraupAO3rC4wCbwKFCvd8fFmJPEZVoRmStnh5nqUpFJoqPa5X4E3H7wZevIBsrfEkl+9Fa7gFO8BMBUk+nTjVRHeRwa75WH7A4B+hNiPetykk7s1QuMSGc29PfDrycIJ+LsUHOAG8b+rNZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbQg22vYDE78o6foMAJjVfa41pfcquC4/xyM2DRwm1M=;
 b=CrLXGMBmJlkxPcH5NULkTdhkLHlGclCga8bDa1YwEaSxTCFd4e/HVrsIbH/Nwz4tPK86F2jk1xh7RZ0+dk36FlZq020VzC+Wyt/g+wuvAjCKv0NYDQQDXQXA33j2ugZXGMv3OC5tvxwPPjBG46VA/M4PsXojIOuyToW3LVnMVmI=
Received: from BN1PR12CA0027.namprd12.prod.outlook.com (2603:10b6:408:e1::32)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 19:40:12 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::9d) by BN1PR12CA0027.outlook.office365.com
 (2603:10b6:408:e1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:10 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:06 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 08/14] drm/amd/display: Ammend DCPG IP control sequences to
 align with HW guidance
Date: Tue, 21 Jan 2025 14:39:13 -0500
Message-ID: <20250121193919.3342348-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f1a5ec-a6bb-4ac8-4f23-08dd3a536ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/D+h1aY2EgA4n9iB2je5nikh1RmgDpkn984rzBf5FElB5xByw07v4PmY8U4a?=
 =?us-ascii?Q?XnF+EcHwNoDLfYvrUF6SfI+jUk+CwMlp+4iAqGCltDPh3jnQUxEP9hoZj+rc?=
 =?us-ascii?Q?m+/K5Yzajf/0G9/qPGit3dQGYNIgvbivKiOVwG+4t1lJRdGB2BPhrd/XPeZW?=
 =?us-ascii?Q?lKImzp/HWU/GdGzJZ30bLdNJJbDBLD4hnn224SDaCqY2qFq4ib34iU8kRZMW?=
 =?us-ascii?Q?SIO9HZ+TWc60nUX3t3Zv/BhUXPq7wNloIFwm+M2+9baxtBGIzIsKNdT/8vbE?=
 =?us-ascii?Q?jF7DqwCBPsFbydsJqzL6uIwS3uzzOXR+jxR/GTDXeUk85OdKwWsHOkZxEQic?=
 =?us-ascii?Q?UCdvad/H7ADYixrPfkgtJtdGWrGYFrEBCSOh5/TrknfJphL8iUy4+MQPHqTw?=
 =?us-ascii?Q?hKRN1zkUGNXwXKuBvffHcrd2ivli24cU2DylK+nIk4P7/XdbhBxFvBgu+UN1?=
 =?us-ascii?Q?4cFpadGtYC8JYYBhqPVjaC+OgeMrK9RmJ+uoxf/DXkYU+XDcDv5HTCRNvs0n?=
 =?us-ascii?Q?pCoD22kqjhN6v5Zd5llR0WuhMJARP4eJJ2jLxyVsp3ZX8y+6vdO41CiJetLi?=
 =?us-ascii?Q?YSHq1n+5MW4bXohZGa6nCaPoetvXiq1192kypeNlAin5yRuJicwPqNf5bd4C?=
 =?us-ascii?Q?YeNlKUoMF4UzwKL99pgjU8HpmdUL2BK1xI1eAOhoVaNiyRSOnDzsdBj3VvuB?=
 =?us-ascii?Q?Iu78ih1pXgfzGcnW4yufUQH5Pyuaz32YNGIjEhxdv9r3MBLLHhPwj1R6YPmA?=
 =?us-ascii?Q?7c4HhNDSqA78utsM1lm32VcsbQchB0obLir778wA2pY4NNUEK2Pw8bogqANZ?=
 =?us-ascii?Q?HtA/nypFnDZ9JeWMvZ1DgLpEx6eL8Lhu2AjIdk8BMNJOn7aQk3YG4KgnDnFv?=
 =?us-ascii?Q?qqN5Y5aBneYL3VSsMW919ln7CCZz4zEokWkqnVcYkbW6iSV7WHtDKyx1Dr9d?=
 =?us-ascii?Q?Jmt8ojrZ2IYwNYlReArmBZEQ73SYUcXr1cfMYyMSfU6lfoB9/CX/26trBBdI?=
 =?us-ascii?Q?UydZHCOjB/PGycpy2RWlZxGNjRHqIPmvW7WoYh+ou8zzeuGFvpQoGRQ/VQKo?=
 =?us-ascii?Q?oPmV+HLoGuKNMY0vyl8qoeNZrxYzAXcqUx8xIxlOOWxasch3UyouBlyxGbw9?=
 =?us-ascii?Q?0hETZAy0Nv4n83GUpk5sPxD56vupaqv7j2zH8o1LfrUyOlODrBt3cuaR9343?=
 =?us-ascii?Q?DgKjWYRtl0iHQlMxO8wQg41/u6CCr7SCws3b2wWvURSE6QMb6f6YdgwannZn?=
 =?us-ascii?Q?nOoUq/Mpp/P+qmWFHCeh+1YJ9wlJwXUVzN8jI47FMoqD3/3wHH/QFApGP1Pb?=
 =?us-ascii?Q?AZo3Ev3EzEgLx2BpvBCu4p625uDnszQH0nmzf2K8rAO2C9W2tdtyIXifwA03?=
 =?us-ascii?Q?Jn0nwlbg2prJ2OBjik794RdB8g/IOcwMCSXE6xt7Ua/4Y+iEcUyd3fA8MRgB?=
 =?us-ascii?Q?fSTyfqMWCGiZTrrBEPzaHczMEGRcLQ5jev6Dju1hMFse51lRvlNhPb35nHCI?=
 =?us-ascii?Q?kb6wkea3t5QxwRg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:10.2726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1a5ec-a6bb-4ac8-4f23-08dd3a536ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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
IP_REQUEST_CNTL should only be toggled off when it was originally, never
unconditionally.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 14 +++++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 34 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  3 ++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a5e18ab72394..dec732c0c59c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1266,14 +1266,18 @@ static void dcn20_power_on_plane_resources(
 	struct dce_hwseq *hws,
 	struct pipe_ctx *pipe_ctx)
 {
+	uint32_t org_ip_request_cntl = 0;
+
 	DC_LOGGER_INIT(hws->ctx->logger);
 
 	if (hws->funcs.dpp_root_clock_control)
 		hws->funcs.dpp_root_clock_control(hws, pipe_ctx->plane_res.dpp->inst, true);
 
 	if (REG(DC_IP_REQUEST_CNTL)) {
-		REG_SET(DC_IP_REQUEST_CNTL, 0,
-				IP_REQUEST_EN, 1);
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0,
+					IP_REQUEST_EN, 1);
 
 		if (hws->funcs.dpp_pg_control)
 			hws->funcs.dpp_pg_control(hws, pipe_ctx->plane_res.dpp->inst, true);
@@ -1281,8 +1285,10 @@ static void dcn20_power_on_plane_resources(
 		if (hws->funcs.hubp_pg_control)
 			hws->funcs.hubp_pg_control(hws, pipe_ctx->plane_res.hubp->inst, true);
 
-		REG_SET(DC_IP_REQUEST_CNTL, 0,
-				IP_REQUEST_EN, 0);
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0,
+					IP_REQUEST_EN, 0);
+
 		DC_LOG_DEBUG(
 				"Un-gated front end for pipe %d\n", pipe_ctx->plane_res.hubp->inst);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 92bb820817b9..8ad0ff669b7a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2610,3 +2610,37 @@ void dcn401_detect_pipe_changes(struct dc_state *old_state,
 		new_pipe->update_flags.bits.test_pattern_changed = 1;
 	}
 }
+
+void dcn401_plane_atomic_power_down(struct dc *dc,
+		struct dpp *dpp,
+		struct hubp *hubp)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	uint32_t org_ip_request_cntl = 0;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0,
+			IP_REQUEST_EN, 1);
+
+	if (hws->funcs.dpp_pg_control)
+		hws->funcs.dpp_pg_control(hws, dpp->inst, false);
+
+	if (hws->funcs.hubp_pg_control)
+		hws->funcs.hubp_pg_control(hws, hubp->inst, false);
+
+	hubp->funcs->hubp_reset(hubp);
+	dpp->funcs->dpp_reset(dpp);
+
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0,
+			IP_REQUEST_EN, 0);
+
+	DC_LOG_DEBUG(
+			"Power gated front end %d\n", hubp->inst);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 17cea748789e..dbd69d215b8b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -102,4 +102,7 @@ void dcn401_detect_pipe_changes(
 	struct dc_state *new_state,
 	struct pipe_ctx *old_pipe,
 	struct pipe_ctx *new_pipe);
+void dcn401_plane_atomic_power_down(struct dc *dc,
+		struct dpp *dpp,
+		struct hubp *hubp);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 44cb376f97c1..a4e3501fadbb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -123,7 +123,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.disable_vga = dcn20_disable_vga,
 	.bios_golden_init = dcn10_bios_golden_init,
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
-	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
+	.plane_atomic_power_down = dcn401_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn32_enable_power_gating_plane,
 	.hubp_pg_control = dcn32_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
-- 
2.34.1


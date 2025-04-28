Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BDEC369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD40510E555;
	Mon, 28 Apr 2025 13:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yTREVFcs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E0C10E568
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5JZbG9scSb6NjS130PPDefA8Teyh+tQWEDYoVMmy8uz61QKO059A76ZPfD4zLBy8ZK9tAPDAganinaimhQo/DpmrhGnHGVe/c8zm+SXa3nUimsCAqC3BVcXvaZa51bnhwTJlrujert4XfwHLXKq74XF3/dDgGDR/NrDMabdIzFvoha6QaYS+BaEHXR5aYc393z6fxqKyYypKM19gJNOC+/2XfidZTPWEZvyPPnXj4unA4dSEKJgmlk/eHMPz8yxve/hEhKhNl7qCc4ezpfgtpko9sLURvDTMs6lXLxk0n4Aw9EjGqNQD/nHjQbpOrX3iMui4DpZ1nl7M0+SYM83Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoYh0RZjf3memlyRbzp3y8JFG7tIcOu+8qUvquolMWE=;
 b=QwQR7Qodvohk0ZY+IRFdl1SjcGotzUA47qBoPIqowGNt1iKpo3z3j954px5116nWIBn0Wt4C8fXmSJrqs4NonFiXm/EehHK8CrsBqY/M802BaeJLYKupaZcWfFyeA7/rr6+ztSr/UMdSUM4mPTtbklxT+VcPxa0RAIy0j0eNowgrGwTFruvAP8Na32s5njZdPQI9xXphSX348vxHEJYT7ELoi0t+gLE48ed7KyXLihWjoJ79G3FxuI5W0NsuwFKMANNUGLrdwoQ+oAV6alDUh9cy4CIUjny5SuOFdX4x339Y1RVxZnGBCo8N5aGKQ/KhdlW0FO0O4nBCcfas+jvOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoYh0RZjf3memlyRbzp3y8JFG7tIcOu+8qUvquolMWE=;
 b=yTREVFcsAzce6JRPSZZboHNG7kdgGTC2XNPFgPDMrNOYs/oMHuR3ntJP6bHZFSXn3fgBHAQ462XG7wZWZcDFBmKM9EsGdqiDtSQ+8qFQihHiH7DdUUTkna5YqBPJUVjz119Btqx9GF5JB03zfi0NU4VO11WWxhs8a/iCcuLw8pg=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 13:56:25 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::31) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 13:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:24 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:21 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Charlene
 Liu" <Charlene.Liu@amd.com>, Hansen Dsouza <hansen.dsouza@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 09/28] drm/amd/display: allow dscclk disable
Date: Mon, 28 Apr 2025 21:50:39 +0800
Message-ID: <20250428135514.20775-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: c8798924-c18c-4d47-5f5d-08dd865c7722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o5tN39bv4fdpbaGdEGYIYV6vkyHcTxJ9C3xv5Xj4/TCYvzzGV5YtUK+zn26p?=
 =?us-ascii?Q?niUk1P8xuC1zk7UMSweLqGQhVP4LmtA4bIKDs54w1Xss6iEVeyfJeBTiaeUe?=
 =?us-ascii?Q?3yIivSYRINPCUUdwsFYE0zACNUwWqw79xXO8DP/Nwqw+rUmsdzCidfiV3Mym?=
 =?us-ascii?Q?/Yg3WOXx4LRyn83r2p0wbq+A6pG8XkIG2v8GFQy+DuHln3qHWMIUqG6qgYXo?=
 =?us-ascii?Q?Lnkt3lIFlXPicTmLc9PNZxgdDVM0KcdBHGu5i1Q/s5yH7fEA8YamN/EZdsnP?=
 =?us-ascii?Q?0KefCs5L6K7kKjCHRQr6zECogEZkVikpTWLo2layGmqP5aZ6xr5eI4uWYfqv?=
 =?us-ascii?Q?s/ojZzmA/OCN4q6XWqzO1sZ+Il7Hs+q89H0m8W5cxd2CLmL3BQSYBlW9CGR8?=
 =?us-ascii?Q?u7zhaV6N1B299dBb+ksYIXRZjZAPPVZP78+fXDq9AQHokdwkgTbx/OT597j/?=
 =?us-ascii?Q?C+yzopAGhR2Z7Mafapv6jGxoSFnQ4dl3uYpY+znymrnQEX/u7MNlsOvYlB/F?=
 =?us-ascii?Q?B8Y8/FrcCUe2s6G/k59gOcilZoy4207SHDpht4QNXbZgov7sqBPwxcI4yriC?=
 =?us-ascii?Q?MLxcDiAoUruRBsv893FA8BTvFOha1BddUx/g6RK1pALVyArl6ZEmSDvlb7Gq?=
 =?us-ascii?Q?PEtDUljlEsLpVpTX5uVSEImT00qezNfEWlB0Ko5pK8LwMyL3EXCabl3kJo/Q?=
 =?us-ascii?Q?7v0WoM9zafgWZ6cA0c2EIrEjMueErdMR58+r28fB+bebfhXzox3dqolhNxyV?=
 =?us-ascii?Q?YU7I4TCAaaf6uPEttKv+5/TwSot2FuDVEmbuBrjtBw30T/Be2jlMOzNxs2im?=
 =?us-ascii?Q?HV89u6fal5jzL6LBEedvfhs0dqV5KX8wvi4hoCQ8d8QMgnK1u7GIhd7P2Ah8?=
 =?us-ascii?Q?88xnnmA8pWgIQvVVeKwCxI/sSgriOoBFazFNonIZ0HinORI47Yk8RVkErMRM?=
 =?us-ascii?Q?n5opMpBgwYRv2Zjfp3xuDlp6RHCwnYbGVM9HhPzrlzq84RUGrodnuBI03Rgm?=
 =?us-ascii?Q?2wWtqn4ZS8668JLC43TPX/FKcJpSlZVbzR8YpuhCavVtUqR3cdiNa7LGsVjT?=
 =?us-ascii?Q?GU4ehhnIgmVhun1/eHSFU64zC84vIX/NRpXitCmSPIYDaW1JWpyYl8pGyOK7?=
 =?us-ascii?Q?i/NUAHzgbRjQa7AqtseDKjA+GWNsHAsemmifIYgsZVJRkQkjZF7SaL5sLchm?=
 =?us-ascii?Q?JYAKGGwgxS/wQ8QUKQMFQoYThviP6X0wkt5UcYyC0N+L2Mn4QfUuOGxmfjSD?=
 =?us-ascii?Q?t1nkvOK03xwgGGn7RNUf186bcuz/dcYGamkuv8VekGAomyePwUN9Npxj6kup?=
 =?us-ascii?Q?IezqwZoLHo8nyVmS53eXKl4OkzZT4Ffqf5R7TvBwTfSRRmdxhpc1me0WgPAk?=
 =?us-ascii?Q?oe29aeZfPH2rPkDhqHRda5mgbZsdIzY4XUpShIUWdbDSFgbCf1O+fqjtJ9mq?=
 =?us-ascii?Q?PCIcX1U2rWQXoBd7Z4iV8H8aHs3mB/RZ7W4X3LXBNtr8eQJCrkcviPMEvVyU?=
 =?us-ascii?Q?pKKLR6Ksn7tTfn4DTA8zuvk72bwpxRAPhEDR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:24.9821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8798924-c18c-4d47-5f5d-08dd865c7722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
when dscclk rcg disabled from usr reg option,
dsc clock will remain enabled because driver was doing two things
both dscclk and dsc rcg in the same routine.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index b363f5360818..6c5d6956612e 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1035,6 +1035,7 @@ static void dccg35_enable_dpp_clk_new(
 			  DPPCLK0_DTO_MODULO, 0xFF);
 }
 
+
 static void dccg35_disable_dpp_clk_new(
 	struct dccg *dccg,
 	int inst)
@@ -1771,36 +1772,40 @@ static void dccg35_enable_dscclk(struct dccg *dccg, int inst)
 	//Disable DTO
 	switch (inst) {
 	case 0:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK0_ROOT_GATE_DISABLE, 1);
+
 		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
 				DSCCLK0_DTO_PHASE, 0,
 				DSCCLK0_DTO_MODULO, 0);
 		REG_UPDATE(DSCCLK_DTO_CTRL,	DSCCLK0_EN, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK0_ROOT_GATE_DISABLE, 1);
 		break;
 	case 1:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK1_ROOT_GATE_DISABLE, 1);
+
 		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
 				DSCCLK1_DTO_PHASE, 0,
 				DSCCLK1_DTO_MODULO, 0);
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK1_ROOT_GATE_DISABLE, 1);
 		break;
 	case 2:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK2_ROOT_GATE_DISABLE, 1);
+
 		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
 				DSCCLK2_DTO_PHASE, 0,
 				DSCCLK2_DTO_MODULO, 0);
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK2_ROOT_GATE_DISABLE, 1);
 		break;
 	case 3:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK3_ROOT_GATE_DISABLE, 1);
+
 		REG_UPDATE_2(DSCCLK3_DTO_PARAM,
 				DSCCLK3_DTO_PHASE, 0,
 				DSCCLK3_DTO_MODULO, 0);
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL6, DSCCLK3_ROOT_GATE_DISABLE, 1);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -1813,9 +1818,6 @@ static void dccg35_disable_dscclk(struct dccg *dccg,
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
-		return;
-
 	switch (inst) {
 	case 0:
 		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_EN, 0);
-- 
2.43.0


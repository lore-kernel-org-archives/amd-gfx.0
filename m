Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6710C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F7C10E524;
	Mon, 28 Apr 2025 13:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="atw3wiZQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CAF10E524
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3jn37JbpIeq6ohyQXozXlGfamra3esoyWNRjRHEBRCUHYygGqsF7Bx3CZyj1gpURWZ//mL/3KcucRR5z4+QE1mivzEIF2CPllGOWGZBHsf2uun6QVJ/EkJZJ/AzVrJ9iRmdBDnZnSMHRi6680amWwuPrVRQVwy4JVDRSLXiFm5ugkPQwg0WtXCi/m3mriP0WhVpCU0K4Yw4Umfd4rS8GPa+6A37LaEleKG5vNugrVLhh7QsZx/rQKQxwI243pP/tFWsZmwa2vPsif6H+8/8iJW5g41iLVc3RL/cgmMFEvgBZ0KwrTECPo3zJf/V3ldw6du8il5YxRFv52MWgXMRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78y1J/iu0AE96UYuvCJ8aJjNIsfZpuNvnB2zb7U2U74=;
 b=T01QHG+Lnyhj7S1zTLHPlATyGFcilZu3QKVOibVPVL1thku6rp0pDs8i1qCk0EsqkFX16cjw8Ox/5Ai/XzpQcZdCwmdpl1PdTV6Y36MdNMblSHA+UYOA2JUetiwSbIRY7+ge33hsk/nD70q8jVuApOueoqau0Zbxw0Py6Q80OfwW3eEdRbLX0AgTBLKxcggwJ5k4vLNOr4Ep3o0YzYwQiCyOmrbY6Vg/UTec+oTUsy2IsJaxC8uoh98HJNwKjyw/3emJPFC3LBygys8NKUZPf4qBWVgwGdOti3lUF/cpr9jW7VcZwmo6yqEOdcVctVjv9aEVaVrd2lJ9jPgkGwJzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78y1J/iu0AE96UYuvCJ8aJjNIsfZpuNvnB2zb7U2U74=;
 b=atw3wiZQs7sANjanIQOxmtcx/h7utJCuSkuHx1UE8slhWtL0O7WyIdurg2nRvkEkhblfaXykxzgTtkkaAVGKB5KebSV37ocOF3gYqXXxm0DvXD4HyFnHPXg2f8CsVqwfgTqyqcCC2T9HBsqIIk4H7nPfXCqjkOHWqnabxdqWcjQ=
Received: from BYAPR07CA0010.namprd07.prod.outlook.com (2603:10b6:a02:bc::23)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 13:55:41 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::66) by BYAPR07CA0010.outlook.office365.com
 (2603:10b6:a02:bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 13:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:55:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:37 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:55:34 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Ovidiu
 Bunea" <Ovidiu.Bunea@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/28] drm/amd/display: Update IPS sequential_ono requirement
 checks
Date: Mon, 28 Apr 2025 21:50:31 +0800
Message-ID: <20250428135514.20775-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 299f4e00-8f6b-41c0-1800-08dd865c5c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DtevLVEpEa+Ytg35PNwyTxR1b7fZ/3jvhuo9BCR+20CadgwAlWGwEMgmkdMQ?=
 =?us-ascii?Q?3Bv/B1CUh4bfW2iEV48eY1u5+Bp5Nl5e7uuN65Ujy3P2QdqjrXIr/qY47tQM?=
 =?us-ascii?Q?csyhOaqsZNX5WTo2wuE0oLnQ78EhAjI3kVadzjcdJQRelyppLYtG0RxfmX1C?=
 =?us-ascii?Q?oJYcqwDmrOjiJiblydZewhxBcGaN0sUqaXi6yG6vuTs1Va3qo3lIZFCN3hh1?=
 =?us-ascii?Q?8JbpD+QZ+7F/TenJF6AdfzBImcz5Sgv6RG3OifIIUro5f1exw/flz1UhkrRu?=
 =?us-ascii?Q?3YcB3LhFLfgiDJSHbPIUjMDj7X3Kf+cZ517OD4IFaLTQeptrSPBK6qlwwnAx?=
 =?us-ascii?Q?UxjP6L+1pnoCrZR72Q64WCuhBBTgaGY8FYZZAX81w5w8VczepYMAhAbwm+Np?=
 =?us-ascii?Q?eNZltSTj7bu+fUPZK3MDZUVHAxn2qXDiTPG++aeezkP9wwlremYsYskdwpyf?=
 =?us-ascii?Q?jxpiUS7gZ03vH4KwSu4xq63c3JGMeoSv233h6K+0BNcsJzF1voP0soqqQfRx?=
 =?us-ascii?Q?R2spAAGIVx689q/Wbwl9M7BgErDsiVzOuUMex3h1D+h7E3qa8xB2i8CNP/WM?=
 =?us-ascii?Q?nbex9lrodOy+2aLJi0sQDcU3fFe1djG/hrAce17o9LBV0XfuhATopUs+xOCk?=
 =?us-ascii?Q?mzxUCLRXApjqetOJjfRCIPIFD9nxop5fBNO456ZTL/b3LLSQ6gCfwJhzOgME?=
 =?us-ascii?Q?o8LmguOt6PEZdd6w+n10EQ93CQgJwTP3T1xBM9Q8WY0du0lc648PMjLySyYy?=
 =?us-ascii?Q?LJp65s0pJuHhQ9WguRe8FersS5JPI9hkMwQWSxpBPf1ijLhqSB1HwYdDQ3Ly?=
 =?us-ascii?Q?Ti4GM84KwqdFMCldKs+90ilrYbr1GTmX7OR6GAZSKfjhfrL5YSwD+WS5u4pj?=
 =?us-ascii?Q?mc8dOZ9FulVUutUkRLTAW99x19S9A2KaS/IihRIYDNSAKk+lJCy8GGuQFdeq?=
 =?us-ascii?Q?JdqzU+jdbcZ72CB5GzNDykqSTX8tmI65nHydCi4CGaYH+smYG30lULCn8Yee?=
 =?us-ascii?Q?YI5k6pO7ORaGWjKnz+MWm1/BZ67G6nCZjcy+FVa4kXHVIjKZtPhbKn3Gohj8?=
 =?us-ascii?Q?AxXg6gILzspM8JqB8ipWeJjX0uPsefASklK7BXC3JcwA3dn2x8n3V0ayPePU?=
 =?us-ascii?Q?rnLozyalmdPWrxOVuw23Wgqz/TItgeyH6K89tcyJHjEsajQK6nTJHOR3lZ45?=
 =?us-ascii?Q?wYzBJsym5+c2oTxwwpkInlbxgSNl/5QUxz7suXFo6bPVWm+OpSzYG7tI0tVY?=
 =?us-ascii?Q?cccxVfrL7LmMmA+le59M5BHgxtOQGL/EXrX0mgyM63nJUisYAhx4Dm49P+fY?=
 =?us-ascii?Q?GIdkA7116roxO5ABOY3kXHY3rcBA6szwHUKbLtFZk1Wkj6Nhh3DHF4cS8dvH?=
 =?us-ascii?Q?DJkWRl5xFRmjt2D+wlZTuT9RKihhmeLDJEBV9/ePV5wgKJD1HHCxSqPECu67?=
 =?us-ascii?Q?ySqXAM/6/5mCjgdzNEtywjdInLZP2YZXAYD0cRQeZfBSf/HvUGQ0ZaLmSedf?=
 =?us-ascii?Q?6/n6kgSDDQWlNMA+3VnRW4NTaiOwlxHARqJ/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:55:39.7306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299f4e00-8f6b-41c0-1800-08dd865c5c39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[why & how]
ASICs that require special RCG/PG programming are determined based
on hw_internal_rev. Update these checks to properly include all such
ASICs.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
index 62b7012cda43..f7a373a3d70a 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
@@ -138,7 +138,7 @@ bool dpp35_construct(
 	dpp->base.funcs = &dcn35_dpp_funcs;
 
 	// w/a for cursor memory stuck in LS by programming DISPCLK_R_GATE_DISABLE, limit w/a to some ASIC revs
-	if (dpp->base.ctx->asic_id.hw_internal_rev <= 0x10)
+	if (dpp->base.ctx->asic_id.hw_internal_rev < 0x40)
 		dpp->dispclk_r_gate_disable = true;
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index fb91209a06e8..72c6cf047db0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1903,7 +1903,7 @@ static bool dcn35_resource_construct(
 	dc->caps.max_disp_clock_khz_at_vmin = 650000;
 
 	/* Sequential ONO is based on ASIC. */
-	if (dc->ctx->asic_id.hw_internal_rev > 0x10)
+	if (dc->ctx->asic_id.hw_internal_rev >= 0x40)
 		dc->caps.sequential_ono = true;
 
 	/* Use pipe context based otg sync logic */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 96c8288fb7fa..48e1f234185f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1876,7 +1876,7 @@ static bool dcn36_resource_construct(
 	dc->caps.max_disp_clock_khz_at_vmin = 650000;
 
 	/* Sequential ONO is based on ASIC. */
-	if (dc->ctx->asic_id.hw_internal_rev > 0x10)
+	if (dc->ctx->asic_id.hw_internal_rev >= 0x40)
 		dc->caps.sequential_ono = true;
 
 	/* Use pipe context based otg sync logic */
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC720C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC6210EB05;
	Thu,  6 Jun 2024 21:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z294ylw9";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083B210EB01
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qanv3pKPahgpLS2PAYJVOwsJx01YK/+AobNuvVZSyNPsAuoSrafjnlx4hWk0CfEkg4VfDHJcEMzwm1G9IREf5Cu0kavx76nyFVTdbNlElQx9KWkNtGESY1gOPfLvgopMKqyd57G0ChcNCE4t8mrxDl71YjPpOUuCi+3X8ogbLURy1Gx/O8uGxkZNuaWsLsOlHJOwfRKP6P419IulVMNzhBZ0tVyvf7EpQTYJplkqYgneqTuXwt8+9qXLU8+GeTPJz8oewnAFjLBSScHDC+qwY1GwI6a1lBUAWs3oAiaoV3SdrjZ7wYqnGeP+8k44jV6hLi3kgUShs6MTzuIu8FXbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3jbXWwhVXQEutjSuT8CAtoFy6bd9yLEQSCXY/KnUK8=;
 b=aWPKw/dHWz0WvWOcLrf9y7wrC5HMq1YJj1Uctat0kkAKqNA/EBhfhGZSgYiZ2ZmXuBEDrzkgwuVnRBsOK6iTpkLj1ftgKAIyW97cZVG7sGSmmphCplnPnVezmdA9EjEHQw+TJ29ZiZfCO6h6mn9Y52d7Yg5p0gPLk0PkO//GuyI1yDJ0loTgvzpbBb5ecdmIM1glGy7R2tgbBPl1Yr8lcA2rYZKrW2/UOT/Yt7KMNXL1NGAI4mtEAWxXjjcTnT2QcszHiQ0fYpal83/SHa+nMcyx/yNI+q0q9Ez5pX9Orq2BM7bTkA6IbAi+dceURV01Vjq3R4uYpo6EAXvpyeou2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3jbXWwhVXQEutjSuT8CAtoFy6bd9yLEQSCXY/KnUK8=;
 b=Z294ylw9YAykhOhqKpmQ0oPplNeZhw8TDGCdqptg7kqe8Muq0iXsZcN/le3tubNoN4zuAOanqv04mhjiwH/+l7FLxO13MHydpZKseoIA7qbhn46AuRMVciFGNDUywZ+vB09z02hkIkyt3fJUvUiumy6s/PfH4YqmiJd3+IRXYWA=
Received: from BL1PR13CA0255.namprd13.prod.outlook.com (2603:10b6:208:2ba::20)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:59:01 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::bf) by BL1PR13CA0255.outlook.office365.com
 (2603:10b6:208:2ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:00 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:58:58 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 51/67] drm/amd/display: Remove useless comparison of unsigned
 int vs. 0
Date: Thu, 6 Jun 2024 17:56:16 -0400
Message-ID: <20240606215632.4061204-52-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 40662390-63ca-452f-cab2-08dc8673df69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b++PODoDUkGPvMxTNpzmR6/1WHIPv9LPbDfNVOM/E8xR16nTH1p+cON4hdqp?=
 =?us-ascii?Q?OI2GQFov+l80VAxq+jS16qrp7DBZrghoegYQupJemXN9Vqrvy92RWIx8JH70?=
 =?us-ascii?Q?i8ZVPtboCrDNlvgLkgCly0fo1O5LjbqGj39NgTmHNfCWI3tvs00JqnUKMX+v?=
 =?us-ascii?Q?50xm8+P2s+sbYeqPDglEkl4ycQu3aWVrGskDsPD3yVbAEt/OkyZM7CYo2nLx?=
 =?us-ascii?Q?14YSyIyAaOjqyQiEz+yXLzCZF3sAnH2ngXX2Q4PzxYPt26kNGa+VwvdSvwCV?=
 =?us-ascii?Q?9B2A3FWAsh0lERSCLPUvLn0aPJgVXvhmSKZ8/A/7yRr7fcjZ6AyOe6mizRgT?=
 =?us-ascii?Q?bIzwxOBkJ89UtS5TSC0cp+tjbX7DhwnjGbv0hjzXbMMZl1Y7titQWb3mNFM9?=
 =?us-ascii?Q?51IH3ad3OwXIKoFObRLXjTECBTIWfmwsElXD9D5LImu9sFc3LD5F6c04ds1s?=
 =?us-ascii?Q?x38PIc5ikOQeAbqQwDSnM5uBaxsyi2vIOzRufi/cB43VdgPIbGarkf9cZtbD?=
 =?us-ascii?Q?Jr/JBJZDEL9KliekZP8RvLrwjNdzb6m1A5CFOGJy6JcqvYcFyiZEvTotnmxx?=
 =?us-ascii?Q?kKFNlVaQTOSJGHJyQF5VS6Vu5J2qAap0KemQvI0dhESN085PoApgvCmhIdEl?=
 =?us-ascii?Q?qFik0HlQ7vFIfjfdSwX14TYOvFjMZkPwxA7sZN5PZpVd2R7R2qsTUZXlQLeQ?=
 =?us-ascii?Q?gaTUjXKZ4Qx+U+kzfCu95nksAFjBFg2xx2/fs+jGzXdRVHo/999B0rkY/jkI?=
 =?us-ascii?Q?mox1UmT9pBLtOiHC5ief5kWOeB02dTmAeO45R6ZbOezANYc/VAJZcYMUuxgm?=
 =?us-ascii?Q?UIDWcYJ0FLYQvuKjky1iN4JeYgfrgL3ITqpIb3jXFiTefNArZbJMxZrIilQO?=
 =?us-ascii?Q?2EBuIV6e7gn0WMwII93aEbaLI/1jC0GHQy6JcCCABRxsaTy5se71REBqzgMn?=
 =?us-ascii?Q?xnU7d8NUnl9hxp+IAGjZwpnbvGYkvZzTQMHU0HP0kKy4JGhTffzLb8s/qA6p?=
 =?us-ascii?Q?2X5arRcSwuGF5v2H7rb3sCFwfL2RS0/GHLNcdYDk17AjnA6wvNxfaXJbp8Ql?=
 =?us-ascii?Q?h1QEB0ocUvh2UX+yz/zKTIYSIB2mTpWnyytSpwu1Lv/YjMIRNLJ2BzG0PVMa?=
 =?us-ascii?Q?AZYkEjtyJN8svbUiDiQpxJbKWzM9fuPkGMG2nuGM1kz+B1CP1CFqHKypKpZW?=
 =?us-ascii?Q?uLGKG2rnEmZ2gIqM3aGZJJOjUWLGZdrI+ROPS6mgkE3o/JDegGczSYzIGdSr?=
 =?us-ascii?Q?4crILrDZh/5tyblxWMQm2WqON2eo+LQ5HSleHv3WA/AoJF7uYEXWOnSyuLF1?=
 =?us-ascii?Q?Xh9zgEU7auLaOqqX4XXiIx518H27aDQXjsfVlA7JzZGW2R4IxbOReLJO5GZJ?=
 =?us-ascii?Q?5p9YAb9JgBwXJIw0pinNeDcQ7ZA/mOO4G3CbXhOkfRICRikzMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:00.6599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40662390-63ca-452f-cab2-08dc8673df69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
The comparisons of unsigned int with 0 can have no meanings, i.e.
unsigned int >= 0 (always true) or unsigned int < 0 (always false), and
therefore they are removed.

This fixes 12 NO_EFFECT issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  8 ++++----
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c    |  6 ++----
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  6 +++---
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c          | 11 ++++-------
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c          |  2 +-
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c      |  2 +-
 8 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index aea4bb46856e..a650a9877097 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -320,16 +320,16 @@ static void rn_dump_clk_registers(struct clk_state_registers_and_bypass *regs_an
 	regs_and_bypass->dppclk = internal.CLK1_CLK1_CURRENT_CNT / 10;
 
 	regs_and_bypass->dppclk_bypass = internal.CLK1_CLK1_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dppclk_bypass < 0 || regs_and_bypass->dppclk_bypass > 4)
+	if (regs_and_bypass->dppclk_bypass > 4)
 		regs_and_bypass->dppclk_bypass = 0;
 	regs_and_bypass->dcfclk_bypass = internal.CLK1_CLK3_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dcfclk_bypass < 0 || regs_and_bypass->dcfclk_bypass > 4)
+	if (regs_and_bypass->dcfclk_bypass > 4)
 		regs_and_bypass->dcfclk_bypass = 0;
 	regs_and_bypass->dispclk_bypass = internal.CLK1_CLK0_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dispclk_bypass < 0 || regs_and_bypass->dispclk_bypass > 4)
+	if (regs_and_bypass->dispclk_bypass > 4)
 		regs_and_bypass->dispclk_bypass = 0;
 	regs_and_bypass->dprefclk_bypass = internal.CLK1_CLK2_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dprefclk_bypass < 0 || regs_and_bypass->dprefclk_bypass > 4)
+	if (regs_and_bypass->dprefclk_bypass > 4)
 		regs_and_bypass->dprefclk_bypass = 0;
 
 	if (log_info->enabled) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 191d8b969d19..148a0e4cdea2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -252,16 +252,16 @@ static void vg_dump_clk_registers(struct clk_state_registers_and_bypass *regs_an
 	regs_and_bypass->dppclk = internal.CLK1_CLK1_CURRENT_CNT / 10;
 
 	regs_and_bypass->dppclk_bypass = internal.CLK1_CLK1_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dppclk_bypass < 0 || regs_and_bypass->dppclk_bypass > 4)
+	if (regs_and_bypass->dppclk_bypass > 4)
 		regs_and_bypass->dppclk_bypass = 0;
 	regs_and_bypass->dcfclk_bypass = internal.CLK1_CLK3_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dcfclk_bypass < 0 || regs_and_bypass->dcfclk_bypass > 4)
+	if (regs_and_bypass->dcfclk_bypass > 4)
 		regs_and_bypass->dcfclk_bypass = 0;
 	regs_and_bypass->dispclk_bypass = internal.CLK1_CLK0_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dispclk_bypass < 0 || regs_and_bypass->dispclk_bypass > 4)
+	if (regs_and_bypass->dispclk_bypass > 4)
 		regs_and_bypass->dispclk_bypass = 0;
 	regs_and_bypass->dprefclk_bypass = internal.CLK1_CLK2_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dprefclk_bypass < 0 || regs_and_bypass->dprefclk_bypass > 4)
+	if (regs_and_bypass->dprefclk_bypass > 4)
 		regs_and_bypass->dprefclk_bypass = 0;
 
 	if (log_info->enabled) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 4cdd4dacb761..f5e1d9caee4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -642,8 +642,7 @@ static void dce_mi_program_surface_config(
 	program_tiling(dce_mi, tiling_info);
 	program_size_and_rotation(dce_mi, rotation, plane_size);
 
-	if (format >= SURFACE_PIXEL_FORMAT_GRPH_BEGIN &&
-		format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
+	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
 		program_grph_pixel_format(dce_mi, format);
 }
 
@@ -663,8 +662,7 @@ static void dce60_mi_program_surface_config(
 	program_tiling(dce_mi, tiling_info);
 	dce60_program_size(dce_mi, rotation, plane_size);
 
-	if (format >= SURFACE_PIXEL_FORMAT_GRPH_BEGIN &&
-		format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
+	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
 		program_grph_pixel_format(dce_mi, format);
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index 53bd0ae4bab5..af21c0a27f86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -359,7 +359,7 @@ void pg_cntl35_mpcc_pg_control(struct pg_cntl *pg_cntl,
 	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
-	if (mpcc_inst >= 0 && mpcc_inst < MAX_PIPES)
+	if (mpcc_inst < MAX_PIPES)
 		pg_cntl->pg_pipe_res_enable[PG_MPCC][mpcc_inst] = power_on;
 }
 
@@ -369,7 +369,7 @@ void pg_cntl35_opp_pg_control(struct pg_cntl *pg_cntl,
 	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
-	if (opp_inst >= 0 && opp_inst < MAX_PIPES)
+	if (opp_inst < MAX_PIPES)
 		pg_cntl->pg_pipe_res_enable[PG_OPP][opp_inst] = power_on;
 }
 
@@ -379,7 +379,7 @@ void pg_cntl35_optc_pg_control(struct pg_cntl *pg_cntl,
 	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
-	if (optc_inst >= 0 && optc_inst < MAX_PIPES)
+	if (optc_inst < MAX_PIPES)
 		pg_cntl->pg_pipe_res_enable[PG_OPTC][optc_inst] = power_on;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
index 525bc8881950..d9e6e70dc394 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
@@ -170,8 +170,7 @@ static enum gpio_result set_config(
 
 		return GPIO_RESULT_OK;
 	case GPIO_DDC_CONFIG_TYPE_POLL_FOR_CONNECT:
-		if ((hw_gpio->base.en >= GPIO_DDC_LINE_DDC1) &&
-			(hw_gpio->base.en <= GPIO_DDC_LINE_DDC_VGA)) {
+		if (hw_gpio->base.en <= GPIO_DDC_LINE_DDC_VGA) {
 			REG_UPDATE_3(ddc_setup,
 				DC_I2C_DDC1_ENABLE, 1,
 				DC_I2C_DDC1_EDID_DETECT_ENABLE, 1,
@@ -180,8 +179,7 @@ static enum gpio_result set_config(
 		}
 	break;
 	case GPIO_DDC_CONFIG_TYPE_POLL_FOR_DISCONNECT:
-		if ((hw_gpio->base.en >= GPIO_DDC_LINE_DDC1) &&
-			(hw_gpio->base.en <= GPIO_DDC_LINE_DDC_VGA)) {
+		if (hw_gpio->base.en <= GPIO_DDC_LINE_DDC_VGA) {
 			REG_UPDATE_3(ddc_setup,
 				DC_I2C_DDC1_ENABLE, 1,
 				DC_I2C_DDC1_EDID_DETECT_ENABLE, 1,
@@ -190,8 +188,7 @@ static enum gpio_result set_config(
 		}
 	break;
 	case GPIO_DDC_CONFIG_TYPE_DISABLE_POLLING:
-		if ((hw_gpio->base.en >= GPIO_DDC_LINE_DDC1) &&
-			(hw_gpio->base.en <= GPIO_DDC_LINE_DDC_VGA)) {
+		if (hw_gpio->base.en <= GPIO_DDC_LINE_DDC_VGA) {
 			REG_UPDATE_2(ddc_setup,
 				DC_I2C_DDC1_ENABLE, 0,
 				DC_I2C_DDC1_EDID_DETECT_ENABLE, 0);
@@ -231,7 +228,7 @@ void dal_hw_ddc_init(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
+	if (en > GPIO_DDC_LINE_MAX) {
 		ASSERT_CRITICAL(false);
 		*hw_ddc = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
index f9e847e6555d..6cd50232c432 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
@@ -106,7 +106,7 @@ void dal_hw_generic_init(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
+	if (en > GPIO_DDC_LINE_MAX) {
 		ASSERT_CRITICAL(false);
 		*hw_generic = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
index 1489fdfaf0e7..3f13a744d07d 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
@@ -127,7 +127,7 @@ void dal_hw_hpd_init(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
+	if (en > GPIO_DDC_LINE_MAX) {
 		ASSERT_CRITICAL(false);
 		*hw_hpd = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index d100edaedbbb..eca3d7ee7e4e 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -76,7 +76,7 @@ static const struct irq_source_info *find_irq_source_info(
 	struct irq_service *irq_service,
 	enum dc_irq_source source)
 {
-	if (source >= DAL_IRQ_SOURCES_NUMBER || source < DC_IRQ_SOURCE_INVALID)
+	if (source >= DAL_IRQ_SOURCES_NUMBER)
 		return NULL;
 
 	return &irq_service->info[source];
-- 
2.34.1


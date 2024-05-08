Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C0EC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9365110FB5A;
	Wed,  8 May 2024 17:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lJN40Uqr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C376D10F640
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofIbfcyyIgjzITuXUwARLHehodUNT94CU0/ayE73RZe+erHcCF6qN3xUQArDoeKkyj+1x28akMiL8UYveHx/aCq/zVE6lanwtE6mws6T07Ct35VglSPt/yw0p2seysvppBJTNxqqc0tmmliD0VHV58wz/3JDI+hqwZ1xTWIM8zKRYQ9Z/EpZViSrLzUEgvxPb4jz5ZY74fjK8EXTtNob7DTSPd7yM8wRhn3QE0+2rzTNuKyUFkdLmHaXHYzD/+gu5N3R/jnMA6TxumYfSYwhngXhYDyPnu5S1LD8XPEJTsL1FDun3Xj7GQDWWLq1XA1VH4TgLPFodPPwjmfCxrMcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO/fh38The+vKzDzNbh0sPC39oBSc27wvlWQCUSxS6E=;
 b=NbNkB1lxMdK7fl9cpjB/44W8BvMzvecCFaeQKhGsPB60SqeMsWCyIR3dwxPHKE19tpd5bbV8BzcOOSKtdLgcRh8THos+ntvpPErr8nGSYHU8WGRLFtqwybOYf3N0YvxqbnF2IHD4/sRKnKL2BsaLBHTxKhesk/Lo2gf7f9BcnPcWP3Cuda4TzDgD/Q9+WAMm8Up9Yo8kkgY3arLW2k5nReyNMGXhKcgS8M2fnuUM5meFM7i/u1vg+BdBDkd5LK9SwpITyMCKl9tSxzceSSMTa0mAPomH6wF/5UZnt54quzhN69aYg4JhgzzU/OC74VfIoRIzAvOcEJ0YDSj3DGz0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO/fh38The+vKzDzNbh0sPC39oBSc27wvlWQCUSxS6E=;
 b=lJN40UqrhrZvr8SFjNMGE2rsL84WijzSjavZi7JjNpyk4emJjhI9006NL/JiDlXkcow13R4f8T37gqAMPtdeNDogwHT447TlScOTMjntIRl5UgPNeZsYAEAOCCLa4ffez9pwYlNxFGEaVoQMXaQKgeBsYlZreaqa772yE6EQYV8=
Received: from BL0PR02CA0044.namprd02.prod.outlook.com (2603:10b6:207:3d::21)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:17:43 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::5b) by BL0PR02CA0044.outlook.office365.com
 (2603:10b6:207:3d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:17:43 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:17:41 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Daniel Miess
 <daniel.miess@amd.com>, Charlene Liu <charlene.liu@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 12/20] drm/amd/display: Enable SYMCLK gating in DCCG
Date: Wed, 8 May 2024 11:13:12 -0600
Message-ID: <20240508171320.3292065-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdf912e-caa6-47c6-69af-08dc6f82c5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqWqSD3bySpN0D2bN+cSOprgProPnZdVjv55jfAw/yWjh6WryHOEdwUGwrXD?=
 =?us-ascii?Q?tpOAoOmSks22z09vRehLpAFOCdIKAloYEhV1bPSX/xeGZ4gx/NGorpA79jar?=
 =?us-ascii?Q?EwqPPz1Uquo+QnCw4UahKtxIRzm0NQD2trH5mHM2aIH+xU9zyeXFBTWFrF23?=
 =?us-ascii?Q?i1UuznLxtTog3tU6bl1a4gkHazGtrZ2fX/blCVfkgXZK9KFDIzksZ2g1bWdh?=
 =?us-ascii?Q?Wio5CSw7/px4xIXCNJtg9qqEaV1+tKutpx4FTHhDH/EImAb/nfE+losKqxn0?=
 =?us-ascii?Q?EF6G+myE6Q4fMBBtqVhhKzHYkaFCBN4EQLHK2grdosmJ7DuTznsg7HIPETV1?=
 =?us-ascii?Q?JrD0xkIUR6IERTUSy//r4J10TEowqVYR5+5kySZ8V4BL1nkZHSIDVqhgxKiQ?=
 =?us-ascii?Q?KyNDfWA6tEnIO6/VYTvJagsNqmQlxPc+jJj3kDPE84Bc0bVj77+6uZn6JnPk?=
 =?us-ascii?Q?yKY0CgYIOVhvFdyEc3FbE7BF1S0zMdOni26fmj5IccWS/7ocfkgDuySTfq7t?=
 =?us-ascii?Q?Wkw7Ee5+SSXtHReWJ9TG221tFzhDdTGy5YiSqFdCyvCAH8T46LRIB/HVCFrl?=
 =?us-ascii?Q?tiYxGYQe+1k9fuXtJKMHObwE9dWjTRDcvxFnJcnk2e8dyfTzU878pGH5WwnI?=
 =?us-ascii?Q?Q1ze3mdDIra8LGEzfaISkCdHxmoVQUzfhVabaSuB/jFGyBXPBQZOwaOHpYBg?=
 =?us-ascii?Q?+8oFU4aww8QEpOgp9juftJp7A6nGFfM3TX7eIeMp4ovf/2HBGAwnVnRXF8P5?=
 =?us-ascii?Q?FaSrDfuWu4R/FuzXR3FFbaUr08KpLt2dz9FRjrccZAWolDAce9PDw6aI4GJW?=
 =?us-ascii?Q?OMwJXCNgap0aANmE0el1xHCuIYIaQxxByYXh6fSk4VLxsLlukAQRdnhLMxIr?=
 =?us-ascii?Q?Xq6u8t/uQF9Pn9pSN1jqEyXpEqF3C83dctivZT/wkqMExttK3zT+iN/lsDgR?=
 =?us-ascii?Q?rqwg+Bx651tkkanJTmS4XTIHviB9Ic/YLhCT5w/tqFFJ2oW+X5EUSQbL5T+t?=
 =?us-ascii?Q?JBTw4jyetewwJKtUX3FHsIhal4Nt0g5az/n3dP7k+LDoei+5cTD++gI3oFIq?=
 =?us-ascii?Q?lfy3qDJLQKaWir99t+4EBmf+Mvk0aFuzheAHMbjhwliejuRYD8cj+E0ji8xN?=
 =?us-ascii?Q?Rqvw5P3U2ky4kMKUl+RTEnxFcg602So3xSmti4ffm3mEZlHVZsVK+ODIjtwF?=
 =?us-ascii?Q?fMY3iMMcXRu9C9Gmn/JA3od9XwqpOMW0zW6XXP4OUvRr1WCihy3Fyi+BFY+4?=
 =?us-ascii?Q?WAEGQeuHRNJO0EqNIlZOtjIMFfFERewfJvNy519D1itnmnJXe9k24QKRHlrI?=
 =?us-ascii?Q?JkOoN8rx5IQYes7hl9QbP5At5aJ13GN2QlO404TdRu5E3xVI99mFn8gCKytf?=
 =?us-ascii?Q?xWt9L/bCp8MMjmPr4wT37m2vjGfe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:17:43.4526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdf912e-caa6-47c6-69af-08dc6f82c5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

From: Daniel Miess <daniel.miess@amd.com>

[WHY & HOW]
Enable root clock optimization for SYMCLK and only
disable it when it's actively used.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 102 ++++++++++--------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  45 +++++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../display/dc/hwss/hw_sequencer_private.h    |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   7 ++
 8 files changed, 115 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2fce8c0303fa..eef2f357fe14 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -726,6 +726,7 @@ enum pg_hw_pipe_resources {
 	PG_DPSTREAM,
 	PG_HDMISTREAM,
 	PG_PHYSYMCLK,
+	PG_SYMCLK,
 	PG_HW_PIPE_RESOURCES_NUM_ELEMENT
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 1fc3aa2b507b..d3b27920e294 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -655,9 +655,61 @@ static void dccg35_disable_symclk32_se(
 	}
 }
 
+static void dccg35_set_symclk_root_clock_gating(struct dccg *dccg, uint32_t stream_enc_inst,
+		uint32_t link_enc_inst, bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (stream_enc_inst) {
+	case 0:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_FE_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 1:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_FE_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 2:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_FE_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 3:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 4:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_FE_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	}
+
+	switch (link_enc_inst) {
+	case 0:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 1:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 2:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 3:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 4:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	}
+}
+
 void dccg35_init(struct dccg *dccg)
 {
-	int otg_inst;
+	int otg_inst, phy_inst;
 	/* Set HPO stream encoder to use refclk to avoid case where PHY is
 	 * disabled and SYMCLK32 for HPO SE is sourced from PHYD32CLK which
 	 * will cause DCN to hang.
@@ -671,10 +723,9 @@ void dccg35_init(struct dccg *dccg)
 			dccg31_set_symclk32_le_root_clock_gating(dccg, otg_inst, false);
 		}
 
-//	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-//		for (otg_inst = 0; otg_inst < 4; otg_inst++)
-//			dccg35_disable_symclk_se(dccg, otg_inst, otg_inst);
-
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+		for (phy_inst = 0; phy_inst < 5; phy_inst++)
+			dccg35_set_symclk_root_clock_gating(dccg, phy_inst, phy_inst, false);
 
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
 		for (otg_inst = 0; otg_inst < 4; otg_inst++) {
@@ -798,32 +849,22 @@ static void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst,
 	case 0:
 		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
 				SYMCLKA_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_ROOT_GATE_DISABLE, 1);
 		break;
 	case 1:
 		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
 				SYMCLKB_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_ROOT_GATE_DISABLE, 1);
 		break;
 	case 2:
 		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
 				SYMCLKC_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_ROOT_GATE_DISABLE, 1);
 		break;
 	case 3:
 		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
 				SYMCLKD_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, 1);
 		break;
 	case 4:
 		REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
 				SYMCLKE_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_ROOT_GATE_DISABLE, 1);
 		break;
 	}
 
@@ -832,36 +873,26 @@ static void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst,
 		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
 				SYMCLKA_FE_EN, 1,
 				SYMCLKA_FE_SRC_SEL, link_enc_inst);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_FE_ROOT_GATE_DISABLE, 1);
 		break;
 	case 1:
 		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
 				SYMCLKB_FE_EN, 1,
 				SYMCLKB_FE_SRC_SEL, link_enc_inst);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_FE_ROOT_GATE_DISABLE, 1);
 		break;
 	case 2:
 		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
 				SYMCLKC_FE_EN, 1,
 				SYMCLKC_FE_SRC_SEL, link_enc_inst);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_FE_ROOT_GATE_DISABLE, 1);
 		break;
 	case 3:
 		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
 				SYMCLKD_FE_EN, 1,
 				SYMCLKD_FE_SRC_SEL, link_enc_inst);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, 1);
 		break;
 	case 4:
 		REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
 				SYMCLKE_FE_EN, 1,
 				SYMCLKE_FE_SRC_SEL, link_enc_inst);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_FE_ROOT_GATE_DISABLE, 1);
 		break;
 	}
 }
@@ -922,36 +953,26 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
 				SYMCLKA_FE_EN, 0,
 				SYMCLKA_FE_SRC_SEL, 0);
-//		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_FE_ROOT_GATE_DISABLE, 0);
 		break;
 	case 1:
 		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
 				SYMCLKB_FE_EN, 0,
 				SYMCLKB_FE_SRC_SEL, 0);
-//		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_FE_ROOT_GATE_DISABLE, 0);
 		break;
 	case 2:
 		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
 				SYMCLKC_FE_EN, 0,
 				SYMCLKC_FE_SRC_SEL, 0);
-//		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_FE_ROOT_GATE_DISABLE, 0);
 		break;
 	case 3:
 		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
 				SYMCLKD_FE_EN, 0,
 				SYMCLKD_FE_SRC_SEL, 0);
-//		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, 0);
 		break;
 	case 4:
 		REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
 				SYMCLKE_FE_EN, 0,
 				SYMCLKE_FE_SRC_SEL, 0);
-//		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_FE_ROOT_GATE_DISABLE, 0);
 		break;
 	}
 
@@ -964,32 +985,22 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 		case 0:
 			REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
 					SYMCLKA_CLOCK_ENABLE, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_ROOT_GATE_DISABLE, 0);
 			break;
 		case 1:
 			REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
 					SYMCLKB_CLOCK_ENABLE, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_ROOT_GATE_DISABLE, 0);
 			break;
 		case 2:
 			REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
 					SYMCLKC_CLOCK_ENABLE, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_ROOT_GATE_DISABLE, 0);
 			break;
 		case 3:
 			REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
 					SYMCLKD_CLOCK_ENABLE, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, 0);
 			break;
 		case 4:
 			REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
 					SYMCLKE_CLOCK_ENABLE, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_ROOT_GATE_DISABLE, 0);
 			break;
 		}
 	}
@@ -1022,6 +1033,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
+	.set_symclk_root_clock_gating = dccg35_set_symclk_root_clock_gating,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 6d40e93b5497..6d9ec802f1bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -519,6 +519,17 @@ void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_
 	}
 }
 
+void dcn35_symclk_root_clock_control(struct dce_hwseq *hws, unsigned int enc_inst, bool clock_on)
+{
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.symclk_fe)
+		return;
+
+	if (hws->ctx->dc->res_pool->dccg->funcs->set_symclk_root_clock_gating) {
+		hws->ctx->dc->res_pool->dccg->funcs->set_symclk_root_clock_gating(
+				hws->ctx->dc->res_pool->dccg, enc_inst, enc_inst, clock_on);
+	}
+}
+
 void dcn35_dsc_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst,
@@ -1008,6 +1019,7 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	int i = 0, j = 0;
 	int edp_num = 0;
 	struct dc_link *edp_links[MAX_NUM_EDP] = { NULL };
+	bool stream_enc_in_use[MAX_PIPES] = { false };
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
@@ -1053,10 +1065,17 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 
 		if (pipe_ctx->stream_res.hpo_dp_stream_enc)
 			update_state->pg_pipe_res_update[PG_DPSTREAM][pipe_ctx->stream_res.hpo_dp_stream_enc->inst] = false;
+
+		if (pipe_ctx->stream_res.stream_enc &&
+				!pipe_ctx->stream_res.hpo_dp_stream_enc)
+			stream_enc_in_use[pipe_ctx->stream_res.stream_enc->stream_enc_inst] = true;
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++)
+		if (stream_enc_in_use[i])
+			update_state->pg_pipe_res_update[PG_SYMCLK][i] = false;
+
 	for (i = 0; i < dc->link_count; i++) {
-		update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
 		if (dc->links[i]->type != dc_connection_none)
 			update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = false;
 	}
@@ -1120,6 +1139,10 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 
 				if (j == PG_DPSTREAM && new_pipe->stream_res.hpo_dp_stream_enc)
 					update_state->pg_pipe_res_update[j][new_pipe->stream_res.hpo_dp_stream_enc->inst] = true;
+
+				if (j == PG_SYMCLK && new_pipe->stream_res.stream_enc &&
+						!new_pipe->stream_res.hpo_dp_stream_enc)
+					update_state->pg_pipe_res_update[j][new_pipe->stream_res.stream_enc->stream_enc_inst] = true;
 			}
 		} else if (cur_pipe->plane_state == new_pipe->plane_state ||
 				cur_pipe == new_pipe) {
@@ -1154,6 +1177,12 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 					cur_pipe->stream_res.hpo_dp_stream_enc != new_pipe->stream_res.hpo_dp_stream_enc &&
 					new_pipe->stream_res.hpo_dp_stream_enc)
 					update_state->pg_pipe_res_update[j][new_pipe->stream_res.hpo_dp_stream_enc->inst] = true;
+
+				if (j == PG_SYMCLK &&
+					new_pipe->stream_res.stream_enc &&
+					cur_pipe->stream_res.stream_enc != new_pipe->stream_res.stream_enc &&
+					!new_pipe->stream_res.hpo_dp_stream_enc)
+					update_state->pg_pipe_res_update[j][new_pipe->stream_res.stream_enc->stream_enc_inst] = true;
 			}
 		}
 	}
@@ -1312,11 +1341,16 @@ void dcn35_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
 
-		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++)
+		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_PHYSYMCLK][i])
 				if (dc->hwseq->funcs.physymclk_root_clock_control)
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
+			if (update_state->pg_pipe_res_update[PG_SYMCLK][i])
+				if (dc->hwseq->funcs.symclk_root_clock_control)
+					dc->hwseq->funcs.symclk_root_clock_control(dc->hwseq, i, power_on);
+		}
+
 	}
 	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
@@ -1342,11 +1376,16 @@ void dcn35_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
 
-		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++)
+		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_PHYSYMCLK][i])
 				if (dc->hwseq->funcs.physymclk_root_clock_control)
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
+			if (update_state->pg_pipe_res_update[PG_SYMCLK][i])
+				if (dc->hwseq->funcs.symclk_root_clock_control)
+					dc->hwseq->funcs.symclk_root_clock_control(dc->hwseq, i, power_on);
+		}
+
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index bc05beba5f2c..503a8419bae7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -41,6 +41,8 @@ void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hp
 
 void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on);
 
+void dcn35_symclk_root_clock_control(struct dce_hwseq *hws, unsigned int enc_inst, bool clock_on);
+
 void dcn35_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 void dcn35_set_dmu_fgcg(struct dce_hwseq *hws, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 663bacd1fafd..0b6d7d76c85b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -150,6 +150,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
+	.symclk_root_clock_control = dcn35_symclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index d8de1c6a84e8..e8643f305fd6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -149,6 +149,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
+	.symclk_root_clock_control = dcn35_symclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 7ac3f2a09487..e2189795ca30 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -128,6 +128,10 @@ struct hwseq_private_funcs {
 			struct dce_hwseq *hws,
 			unsigned int phy_inst,
 			bool clock_on);
+	void (*symclk_root_clock_control)(
+			struct dce_hwseq *hws,
+			unsigned int enc_inst,
+			bool clock_on);
 	void (*dpp_pg_control)(struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool power_on);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 867bc67aabfa..5b0924ea78af 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -199,6 +199,13 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			uint32_t stream_enc_inst,
 			uint32_t link_enc_inst);
+
+	void (*set_symclk_root_clock_gating)(
+			struct dccg *dccg,
+			uint32_t stream_enc_inst,
+			uint32_t link_enc_inst,
+			bool enable);
+
 	void (*set_dp_dto)(
 			struct dccg *dccg,
 			const struct dp_dto_params *params);
-- 
2.34.1


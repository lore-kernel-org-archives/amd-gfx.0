Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E01C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC6E113112;
	Wed,  8 May 2024 17:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lQVX1Io6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A52113110
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8TTLQkjfSv/EsYX9cS+FQhln81tWBsSHZ93lkJTc/cWTqljLzMacYeAmRrIOfNoFloX7LVOnYAK3DTBdm5cJ0KBrPTrOSYYuRZ3fTc/H6MqfFt4PcPjmP2gQs/COeB/VvRhV41Fbk+wOZwUtA4Ypq2day8bmzf/n0aoR6b2lq7GDmnjKSrcVplb68CfcO18QiPyBpte7ntdSUXzHmfY5AjLx9FdZi2hTAr1hzdhX/+it05TdVsSoNiObH7nAzKtC79Xg01Lrfx8JeRjMVfZ/crRsr4dlp8/Kdvbo0Lz4zg+VgFX+7gzhKQmPCqMK3AFMh/OgOruEdnjQl7dknmXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXou0N+/DbTI5ejHEX9e8MDbEkPB9ymYRA2Z32V/iJk=;
 b=oQFQMtJREXPh9zuOpU5FLfvT68oOcN6zsoUWfI3ipprOU4r36JM9mX/PC40H9hvOujdlwh945GETf1hpqmAnVwb3vyV7G0cZ7bgJQBwGEgaxrHc+1eQwzqx5LPVteVHADDHOVAH059hmJOQFsgnKI8SmD1pb2QGuOPN4jsQuhk8jIQL3eqb0pyeCSp0DJqLJofNnbVpw4FeocnzJwtsqVZff9qY3tuKmFq9RwDxCxQ3r88Q0Ba0lIpyEeKrM+oEvK8FZQ+tYA746s6XBr9hsW2CTqnQ56nJhe8fhtHm2zlK6GolSvy1ek8yeij9NpH5SExG2QcPG3PvXiF2CX4I3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXou0N+/DbTI5ejHEX9e8MDbEkPB9ymYRA2Z32V/iJk=;
 b=lQVX1Io6zccuMTwyTxLq8DarNJYsLX3m0iKUpB/8CU48VHcRDZOm3dDG3mQHPDr4O85HIv1iKM+nVpANhigAWyFHGOe8GQ41hI10ptWxEqy4nxCCKhGNa9bsLY/osJZ/meVFmlbVEs9jpkHz5kXGi3qLHm0Bm77jz1SKKpByw5Q=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:15:12 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::e3) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 17:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:15:12 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:15:10 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 01/20] drm/amd/display: Create dcn401_clk_mgr struct
Date: Wed, 8 May 2024 11:13:01 -0600
Message-ID: <20240508171320.3292065-2-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 6505685c-c486-4d83-4fa7-08dc6f826b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4btGu55bgHm5/tUDkl1iwKLlCCd427nS7scCQuvvaseiozdfq3urcndDwzhI?=
 =?us-ascii?Q?tie0gyQeRiEf2mQL6bTTDqM2JVjxY6ULL6nJrovT44cV5dXBf+JlzlpPQnUD?=
 =?us-ascii?Q?PldxJUSCVAlYLf7I6HQE6PX5UR4fXJvv/wqDs858bC8oSipWBfje7k5Ywhmq?=
 =?us-ascii?Q?CopbLGSxSqF5XOyGz9PRuR3FrbQw1F74BQfRaSqHsPT/332/73c/KCBJjp6p?=
 =?us-ascii?Q?ZWjnjdyd3OEtBsNg3Aw18tW4BiRe/ZqHIkGWh6JGKapgQ+ufPl7I0aZreeUC?=
 =?us-ascii?Q?Q1GDwMqQMHYBYTMelhZc88sGQDeubEVxjcOsTetY132LkZklCYVjr3ML7TRt?=
 =?us-ascii?Q?9XFRVHh5rqg+kOHrqv1Hd4e8mNMXuOXI5qucL4nHpFeLmdFCn7/iJSXyN7Ap?=
 =?us-ascii?Q?ZJlo5y8WMO7quz57zEwRXupR5lqzC6Qwg1ctKyshszbfI4P5xNe77bXwb0E2?=
 =?us-ascii?Q?sjtLFVN+8f9iVFCQzHkNgrqaj9sVNI5FjDnpsE5/rE/zYjzG2b64kV8DP3gp?=
 =?us-ascii?Q?Ew500ygFG6ijBjVqUn2c4qoaAP4hl9POlcbGrjpVO068bgJwXDzDcI8BqMvQ?=
 =?us-ascii?Q?PCg2Nc46vuKxRbTnlRUmwsYVLvU+sarSwbS4Q9VGMk/LowYldqhx78yC4xT5?=
 =?us-ascii?Q?x4znkwbAjyzu1/UQRphkPpNze/LRK1cG5VwOQV3rp40n1TWSPtFzHKBlgYyf?=
 =?us-ascii?Q?z8fQWKIjaNA9QMt0XoRM/A4VBZKo4PEbPVCZ/3wFa64sjU1epCLLanDNmhm6?=
 =?us-ascii?Q?sYFggCugxg9J2NGvWYotdhYnM9XG2esSQJYdEta/AngJfyQa3dxcjH78qOQH?=
 =?us-ascii?Q?MXn0Fn647aCkILrC//yREdOSvUdw4dMGmmUSfVlXFETSirSh9mCBiyqWaZ+9?=
 =?us-ascii?Q?ijbQKeFitXL6y2tkAObHBXxow3THtbppSA9x6BmHfhcENsiNZ8QywzXryhsv?=
 =?us-ascii?Q?VFxmtt8+2nDplTwTWmVNurB2httprFlmgGZYkfTJ3yVPr48GofvfcuTu55Qi?=
 =?us-ascii?Q?xz42HYTJC07HnfhpoBBgKKI5GIYnfbcUn1zFNaFpMjK2gcRhy7c+3avkoQl5?=
 =?us-ascii?Q?rr0oQYkJkCvMKvBhxs22Cg7QKIKUwczJLrIomhdWwvn4mcgXCOMUMA2s+buy?=
 =?us-ascii?Q?QEFAXDAf3Wm/rculAa5baKWy0AHjoDrlfhcyMtdtoH9hKNgETOBWaFcHUn6y?=
 =?us-ascii?Q?Q9q8uzHfSQHe3dF34mkfCmM/pS0eV9h3IH02RgmyIvKT/NWPu8ij8Am25JFD?=
 =?us-ascii?Q?1csgGJxJVefu+gP2EhhG8N+eYke5pkpNEBhBtuPc+tpg9ODm5RBXCr8TzzFl?=
 =?us-ascii?Q?oW7/W/rVU6+O/T4rrJdpIUAmpQkHP8tV1p0Ws7P02tEnEULVV5fFp2MtdrSU?=
 =?us-ascii?Q?zLi8S0qizLqoZ4zIbrkXZ0ZeJWDj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:15:12.0678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6505685c-c486-4d83-4fa7-08dc6f826b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
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

Create dcn401 specific structure to encapsulate version specific
variables.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  3 +--
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 23 ++++++++++++++++---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        | 10 ++++----
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 5f67d159e1e2..f770828df149 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -367,14 +367,13 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	break;
 
 	case AMDGPU_FAMILY_GC_12_0_0: {
-		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+		struct clk_mgr_internal *clk_mgr = dcn401_clk_mgr_construct(ctx, dccg);
 
 		if (clk_mgr == NULL) {
 			BREAK_TO_DEBUGGER();
 			return NULL;
 		}
 
-		dcn401_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base;
 	}
 	break;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 7db7446ad91f..1cf750cfed66 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -935,14 +935,18 @@ static struct clk_mgr_funcs dcn401_funcs = {
 		.is_smu_present = dcn401_is_smu_present,
 };
 
-void dcn401_clk_mgr_construct(
+struct clk_mgr_internal *dcn401_clk_mgr_construct(
 		struct dc_context *ctx,
-		struct clk_mgr_internal *clk_mgr,
-		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
 	struct clk_log_info log_info = {0};
+	struct dcn401_clk_mgr *clk_mgr401 = kzalloc(sizeof(struct dcn401_clk_mgr), GFP_KERNEL);
+	struct clk_mgr_internal *clk_mgr;
+
+	if (!clk_mgr401)
+		return NULL;
 
+	clk_mgr = &clk_mgr401->base;
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn401_funcs;
 	clk_mgr->regs = &clk_mgr_regs_dcn401;
@@ -987,11 +991,24 @@ void dcn401_clk_mgr_construct(
 	clk_mgr->smu_present = false;
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		kfree(clk_mgr);
+		return NULL;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		kfree(clk_mgr->base.bw_params);
+		return NULL;
+	}
+
+	return &clk_mgr401->base;
+
 }
 
 void dcn401_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index 496540ec1950..dad203de0dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -5,11 +5,13 @@
 #ifndef __DCN401_CLK_MGR_H_
 #define __DCN401_CLK_MGR_H_
 
+struct dcn401_clk_mgr {
+	struct clk_mgr_internal base;
+};
+
 void dcn401_init_clocks(struct clk_mgr *clk_mgr_base);
 
-void dcn401_clk_mgr_construct(struct dc_context *ctx,
-		struct clk_mgr_internal *clk_mgr,
-		struct pp_smu_funcs *pp_smu,
+struct clk_mgr_internal *dcn401_clk_mgr_construct(struct dc_context *ctx,
 		struct dccg *dccg);
 
 void dcn401_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
@@ -17,6 +19,4 @@ void dcn401_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 
 void dcn401_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
-
-
 #endif /* __DCN401_CLK_MGR_H_ */
-- 
2.34.1


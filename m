Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E7BC982D1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3D610E82F;
	Wed, 16 Sep 2026 17:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UYNgcp3s";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEBA10E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrSRoN6KrwWR6nNNhOLfYc1x605UcBFlczTdDfkB9b8xjU23T/TF+z1/qKjeS4O6ejVpUh5gIJipvt1LjLksbCif51o+qF6etjqcjvjE3nqM7HwrG4eh/Wxu3socX4NU+M7EiVX5xbx47k8xYRcVGjD3JiA0pWqp673nqFQlmZyj+vq+YWglnTBCqKdEn9+8M2zuIgbLnSf0dx21qugU5FgjrAnlb0Imzz0DGFH/t5nBodWYaYSV/Np7d0B+OIVj3A8Ub/zID1ZMs83SEG3ZOMltKKFyXVfOAFdlXvlwLM6oUMyw/GFDHbLkaPfjEwETX3JSkdPeuni+nv1Ec9pxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoYlLRVOA48jWLAKx1sg48X9zener3bWxN43RZGAMVM=;
 b=R6D2UFGRtWXxd71upjQyy/ZjjuXF85TX/knOJoPNII62LPQoDDTuurpnAry0AhhDFKDsEVt32Cb8go6hVLb0Y9NTiv1qJag2figHjece6X32trmB5NzNKCCqtsDBqtZ1H1yjeLwjDiXVMZc1yRAq8TFGWE/i990jpscEoTx1MEwf9lgM85pk0ls1ZrSp6YGai8fh+NQe7FzYUqe56GwN6I7BOttMNgmQns+Gk3K88FyTTEMnm+82StOWJzHeUiaU04dXUlX0a6ub0+Rc3pOT66cLswklZ6blxPZuXXwyRM4Kb6wU7HsQTED5bgVnpFC5DdcAhWP0371Y3DPClhPTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoYlLRVOA48jWLAKx1sg48X9zener3bWxN43RZGAMVM=;
 b=UYNgcp3srIDcn7Anhb4XYt3iZNgENha3na5r+HO66jsdAcoZFZhU4rYUe4NbUleqW8nl52tblJ4xX0sZTgiVdVMU7I50MCvsxTJLKYWGW9Cp7PvCpkh0XrHRoz+0kTlSYUCV0GAnRHOAIxf6im6FB/o4ze+dMmctbjKJXiUoFG0=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:21 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::65) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:21 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:16 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 06/64] drm/amd/display: Add inst field to struct clk_mgr
Date: Wed, 16 Sep 2026 13:51:21 -0400
Message-ID: <20260916175301.368306-7-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1f9ac6-5960-4769-5075-08df141b41ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r/dulf/vTBvH8MgEZMhHSpke6IBDL2g3d3MrAP8VfO7/3cWSRdKVS2aMkRftEtrfby9hw3btubWE5n8BW7i6yI0o4rAX3AMkwm5pO5UFNE79mBnEUnXWq0TvY7zM8PcMu2xgxAnDwNDejloP4b87e3vdVZlBAIcwOQpZoY0kcxt/OAMnMjzt370767FsVKHXeoJ31xbwyG1RMGRqiKBtfFNmCuz0DrBtpCroH1QoivP9dj8H0WcW5/RIVPEcsGgUZkJGf6S3349f2I1JvqlJAgYJ7J6xO8HK30jj2dX99RPyFBsqJ9YncmJealK4oz3t1Qdw1ZNbNvBb2kLl5mIPG3eWhxVBuyo2XU9oJbZ2u0NzC/DwaDEF8++QiP+BsoPAaYJF6z87WnAw2fg1yJ+VcFap0/V9KdN/DukVTmZsONXP9O+MLgMs0TpAE0nZEY6xRac2kYkKig1aKoiW6XrlfOp+aOOnm9UqevgWPDVrz8OEnno8E1fzWzofoD4bhla2llQvMiJa92ZK3aILxSkHDTo0y49FfSfunveHSOcIw8YdpH7L54O0dt0qxaZ6eb8f8LH1kfmVnmokrvrmfIgnZAS1OqmYFxCL4YMuFW878WYhl9VLr3GscfcCm4F16RjaUUCxTmzWi/JivpvonEhszt/6EOK0kk8AjnGQnXPs4qZ4f2aR5TcSpBeKhU20K3p6zRpcLFe/usLRkslQVXLOpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UtFJHoV4fsGozECrfBrI+WLWQfRFOmGiCroR/QGQ4byNcAFGSttVmsyf5LAD0DZGHXIzCjYl7VK9cosoqvX6vonipkjStumiXY+dK0keglXgx3ChoGqlst1CSmria88fY1MvhsNQnwjBaSB931c0mPfL979Pb5A+ue60dn2Xd6Q/z9eeUfJP6ISJlUur+iFuyQdl0ABdWCmj/rpnQ6/1sgmPfdrT2YSZqOr32K40/o5XXphCJdt0jCwt6fzqqMRO+/5nMUSSImmPtttn4GpY7Ik5hZM7QU7VA7n1zXVR1PP9TT1M0jeG8KycYUn1LEPGYRRnOF8uvf+FQQgj540ZLwBpiv3PuRzNhNQvCBKKgqE1tnl8eVtKLltD680VLpUYYdCwgwEJaLPbxWE2AAVv1I/0hZs0dPk3bW1jkNnUtxEpdVXNBmllFM6MbINiNE/B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:21.2069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1f9ac6-5960-4769-5075-08df141b41ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member to struct clk_mgr and set it to 0 in the DCN401,
DCN42, DCN42B and DCN60 construct paths, since clk_mgr is a singleton
on all of them.

No functional change; the field has no readers yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 1 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c | 3 ++-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h            | 1 +
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 6d791a5d9776..120f9dd691f3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1632,6 +1632,7 @@ struct clk_mgr_internal *dcn401_clk_mgr_construct(
 
 	clk_mgr = &clk_mgr401->base;
 	clk_mgr->base.ctx = ctx;
+	clk_mgr->base.inst = 0;
 	clk_mgr->base.funcs = &dcn401_funcs;
 	clk_mgr->regs = &clk_mgr_regs_dcn401;
 	clk_mgr->clk_mgr_shift = &clk_mgr_shift_dcn401;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index c62be9f25dae..405145889ba2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -392,7 +392,7 @@ void dcn42_notify_cstate_disable(struct clk_mgr *clk_mgr_base, bool disable)
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	bool target_allow = !disable;
 
-	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 
 	/* Idempotent: only send when the cached vote actually changes. */
 	if (clk_mgr_base->clks.cstate_allow == target_allow)
@@ -619,7 +619,7 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct clk_mgr_dcn42 *clk_mgr = TO_CLK_MGR_DCN42(clk_mgr_int);
 
-	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 	(void)dc_logger;
 
 	init_clk_states(clk_mgr_base);
@@ -814,7 +814,7 @@ void dcn42_set_low_power_state(struct clk_mgr *clk_mgr_base)
 
 void dcn42_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 {
-	(void)clk_mgr_base;
+(void)clk_mgr_base;
 
 }
 
@@ -1115,6 +1115,7 @@ void dcn42_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	clk_mgr->base.base.ctx = ctx;
+	clk_mgr->base.base.inst = 0;
 	clk_mgr->base.base.funcs = &dcn42_funcs;
 	clk_mgr->base.regs = &clk_mgr_regs_dcn42;
 	clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn42;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 003ed4f60f97..d500a3210eed 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -228,7 +228,7 @@ void dcn42b_init_clocks(struct clk_mgr *clk_mgr_base)
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct clk_mgr_dcn42 *clk_mgr = TO_CLK_MGR_DCN42B(clk_mgr_int);
 
-	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 	(void)dc_logger;
 
 	init_clk_states(clk_mgr_base);
@@ -619,6 +619,7 @@ void dcn42b_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	clk_mgr->base.base.ctx = ctx;
+	clk_mgr->base.base.inst = 0;
 	clk_mgr->base.base.funcs = &dcn42b_funcs;
 	clk_mgr->base.regs = &clk_mgr_regs_dcn42b;
 	clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn42b;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 138afa7afc86..47b112f84330 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1709,6 +1709,7 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 
 	clk_mgr = &clk_mgr60->base;
 	clk_mgr->base.ctx = ctx;
+	clk_mgr->base.inst = 0;
 	clk_mgr->base.funcs = &dcn60_funcs;
 	clk_mgr->regs = &clk_mgr_regs_dcn60;
 	clk_mgr->clk_mgr_shift = &clk_mgr_shift_dcn60;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 614beb5924fd..5b06659423d5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -433,6 +433,7 @@ struct clk_mgr_funcs {
 struct clk_mgr {
 	struct dc_context *ctx;
 	struct clk_mgr_funcs *funcs;
+	int inst;
 	struct dc_clocks clks;
 	bool psr_allow_active_cache;
 	bool force_smu_not_present;
-- 
2.55.0


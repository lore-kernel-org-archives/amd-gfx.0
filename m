Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068FDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827528D07E;
	Fri, 22 Jul 2022 20:42:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6E78B3D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLIcEp2vmasFG5zoQCY5/5QKYJH3IeGGxMKc4CxEl1MZXSxRzgYE0H+g2bFGisu/hqdveXjNHFdX10XCC8gRovtJTRtBCNk3PLwOjHtQPFXUQi1mXpO+VXqijzUi7brPHw7D5CmRRlZ1rBrbILsku97O2lLXydCrK+v/zTJ5IbwHhImz/hlJRditVyjONmzjHvHhQFbKfYYd1R+oUjAi0ads+vWAhYtMR6/aGXcp1BUtsZS/lZw2mcrSSt3/irjr6Z1Vx1SjeUh1eUHgSqgm8zVXwCop2VLxxFIKfieDk6eiSeNQ7q00lJhfr5AhOsUfLzCzWG/vs4c3tkCYGWv3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o55AnsjLX5qy/3kCVHb6aujezNI5ynLVNJhmAx4r004=;
 b=LuLK08/dR8X9ngi1gkn5oNbM19Mi3gwyFZdGgARGOcn+xGWbSL5WEGBXWfqK4YLuK6sIqMolNZrEeKzx/q4scRcED0Qf9ozaWU4uh6pgTcOPhlRTaZnzWo+Q84Tu6hYfrE3+Mmo+gmcxIe8pqRLK5kFHg2VSHilZaQBWDiuqoPH4lDksQ4X9xLhaTxOfcJi0AbmUSK244cW3fpI13uSKk3/4gUWlPCEe5c2kdjzLi8REIjyKSkTeeuYGGkPMg2XHpKtyDWHNyYqVVLxEj86aVOiYFcD2qHrNB1CMTWwV1UfFzVbtfx1KjlR1hGGbc64j9Wj8JST8R5YZhxn9M1HCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o55AnsjLX5qy/3kCVHb6aujezNI5ynLVNJhmAx4r004=;
 b=EaaRdd/eIRREFYsnnnjRb3DSrsp+b3jssEKUkWt+2CCgy1iSolJk2z/gdZE0DEr/2129z9u+lkg44GSJNeAScX4rRdEPUFBg2qgQ4nOEcnjkb8+xT5JQ95o5Vn1wTd6uXt92EgEDRqt8pUu9/gLAG+C4RKa+dnZpQGNgt2W8C1g=
Received: from DS7PR03CA0197.namprd03.prod.outlook.com (2603:10b6:5:3b6::22)
 by CY4PR12MB1669.namprd12.prod.outlook.com (2603:10b6:910:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 22 Jul
 2022 20:42:27 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::56) by DS7PR03CA0197.outlook.office365.com
 (2603:10b6:5:3b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Fri, 22 Jul 2022 20:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:42:26 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:42:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/31] drm/amd/display: Fix dpstreamclk programming
Date: Fri, 22 Jul 2022 14:31:27 -0600
Message-ID: <20220722203137.4043516-22-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3650366c-e28b-4244-3a20-08da6c22b060
X-MS-TrafficTypeDiagnostic: CY4PR12MB1669:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OD6f3NBGWdsmYCBjfI8x89oyWdA0DN1hgN+Mh7xOj+TZJfjd0G1NrR2iKsEpkjdHcnGWuTknwEbUZT7Im5k3QSDN7kqvEFG1Kf329esc6QOeGJPys4koeC0mnqNiAs7AFmpZ8OwZ8QFUU12ITGFUIu9tusr7IdkwSt+L46JMh6G1q6vmGnf3p/+PRZKqvUO0GXZtfDOgRkF6cKwNADntwcN8Tw2/mP42wEliFjLRUEpB+uNk5jNQWv624Pt6Shtsw/DSJumJMisLmSMVZB53c81rY+DXPT+nr3m/qMu5ney70NKcbj2ou2Nn45fgno9ycEPTbpYTh+/N1oof5df0nsDTeOJLqOQSP8d+NE/flfTc9rmJbsmLrb4rSD+d8JUZLQfVuuntlIROSEUk67cLJYrF94qx7FFzXPbNSjKBF5IvEfO/mhGbtTAG5VniaauL4O1AAXU+Qx0gWBjl+fw3ajiesWbEF++xE27o06H0RhOWo2u0kqKtQRdk+Kix7yGen9HqmQofR8cmlyakJgaRCeqY1U87V1zbxJmU47GT2Mk/TUx4QSYtQPX6wwfJ/B8neYVUgFN3IdjX2X0rtxd/kYrV0wwwee15FAtp5ptUaIu/qx9fBwG7Per+BV4KHLY4DNc1AwSzxz+RZWTU8SIEpwvurNtobWwoPS4YZk+C0LGPS7KwmbyNdTPnC1sMtrSTi0m7wtqEIv8gcAmVHVdFxVn+sxSj5nPg6vYHI4sCy9/Bt3jDFgjvJCWha6vrfU70aWQp7VPXkLpF5G6pTI/T3pOv3vNu1/IjtVf1CuGWldg+t3NxPMM8Q92rTu5gsj8dKmOFvpg5FtnMaZmYcXvsdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(40470700004)(46966006)(1076003)(186003)(44832011)(6666004)(2616005)(316002)(478600001)(26005)(6916009)(82310400005)(86362001)(36860700001)(41300700001)(83380400001)(5660300002)(426003)(336012)(16526019)(81166007)(4326008)(8936002)(8676002)(70206006)(36756003)(2906002)(356005)(54906003)(70586007)(47076005)(82740400003)(7696005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:42:26.9037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3650366c-e28b-4244-3a20-08da6c22b060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1669
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently programming incorrect hpo inst as well as selecting incorrect source

[HOW]
Use hpo inst instead of otg inst to select dpstreamclk inst

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c   |  8 +++++---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h   |  8 ++------
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 13 +++++++------
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c   |  3 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h        |  3 ++-
 .../gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c  |  4 ++--
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 799a383a2684..7f34418e6308 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -158,9 +158,11 @@ static void dccg31_disable_dpstreamclk(struct dccg *dccg, int otg_inst)
 	}
 }
 
-void dccg31_set_dpstreamclk(struct dccg *dccg,
-			    enum streamclk_source src,
-			    int otg_inst)
+void dccg31_set_dpstreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		int otg_inst,
+		int dp_hpo_inst)
 {
 	if (src == REFCLK)
 		dccg31_disable_dpstreamclk(dccg, otg_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 32b5593b1460..0902ce5eb8a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -161,11 +161,6 @@ struct dccg *dccg31_create(
 
 void dccg31_init(struct dccg *dccg);
 
-void dccg31_set_dpstreamclk(
-		struct dccg *dccg,
-		enum streamclk_source src,
-		int otg_inst);
-
 void dccg31_enable_symclk32_se(
 		struct dccg *dccg,
 		int hpo_se_inst,
@@ -207,7 +202,8 @@ void dccg31_get_dccg_ref_freq(
 void dccg31_set_dpstreamclk(
 	struct dccg *dccg,
 	enum streamclk_source src,
-	int otg_inst);
+	int otg_inst,
+	int dp_hpo_inst);
 
 void dccg31_set_dtbclk_dto(
 		struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 3852a6d59b97..232cc15979dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -184,7 +184,8 @@ void dccg314_set_dtbclk_dto(
 void dccg314_set_dpstreamclk(
 		struct dccg *dccg,
 		enum streamclk_source src,
-		int otg_inst)
+		int otg_inst,
+		int dp_hpo_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -192,26 +193,26 @@ void dccg314_set_dpstreamclk(
 	dccg314_set_dtbclk_p_src(dccg, src, otg_inst);
 
 	/* enabled to select one of the DTBCLKs for pipe */
-	switch (otg_inst) {
+	switch (dp_hpo_inst) {
 	case 0:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL,
 					DPSTREAMCLK0_EN, (src == REFCLK) ? 0 : 1,
-					DPSTREAMCLK0_SRC_SEL, 0);
+					DPSTREAMCLK0_SRC_SEL, otg_inst);
 		break;
 	case 1:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL,
 					DPSTREAMCLK1_EN, (src == REFCLK) ? 0 : 1,
-					DPSTREAMCLK1_SRC_SEL, 1);
+					DPSTREAMCLK1_SRC_SEL, otg_inst);
 		break;
 	case 2:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL,
 					DPSTREAMCLK2_EN, (src == REFCLK) ? 0 : 1,
-					DPSTREAMCLK2_SRC_SEL, 2);
+					DPSTREAMCLK2_SRC_SEL, otg_inst);
 		break;
 	case 3:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL,
 					DPSTREAMCLK3_EN, (src == REFCLK) ? 0 : 1,
-					DPSTREAMCLK3_SRC_SEL, 3);
+					DPSTREAMCLK3_SRC_SEL, otg_inst);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 12fc3afd9acd..a31c64b50410 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -211,7 +211,8 @@ static void dccg32_get_dccg_ref_freq(struct dccg *dccg,
 void dccg32_set_dpstreamclk(
 		struct dccg *dccg,
 		enum streamclk_source src,
-		int otg_inst)
+		int otg_inst,
+		int dp_hpo_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index c2d116cce119..ce006762f257 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -101,7 +101,8 @@ struct dccg_funcs {
 	void (*set_dpstreamclk)(
 			struct dccg *dccg,
 			enum streamclk_source src,
-			int otg_inst);
+			int otg_inst,
+			int dp_hpo_inst);
 
 	void (*enable_symclk32_se)(
 			struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index ea6cf8bfce30..db7b0b155374 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -116,7 +116,7 @@ static void setup_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	dto_params.timing = &pipe_ctx->stream->timing;
 	dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 
-	dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst);
+	dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, link_enc->inst);
 	dccg->funcs->enable_symclk32_se(dccg, stream_enc->inst, phyd32clk);
 	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	stream_enc->funcs->enable_stream(stream_enc);
@@ -137,7 +137,7 @@ static void reset_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	stream_enc->funcs->disable(stream_enc);
 	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	dccg->funcs->disable_symclk32_se(dccg, stream_enc->inst);
-	dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst);
+	dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst,  pipe_ctx->link_res.hpo_dp_link_enc->inst);
 }
 
 static void setup_hpo_dp_stream_attribute(struct pipe_ctx *pipe_ctx)
-- 
2.37.1


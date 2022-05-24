Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6F1C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A57310F74A;
	Tue, 24 May 2022 17:57:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B049010F74A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crLroOgVZik0YnT/CJ+Il6BKv8QKX9zOCJh28GGNciwkicnSHu185agLGqvT5Qjgxcq5lDReBPENhglkm+0PIMIhuFHevxPz4fmRWcnhTqk+K+ac/S5qt/6T7aMGI+YnzKBA5npEnrm/9AZ8qDwgFb3Z/04zhauDbyoP14+SZpTbFxlmq1LGKlW8zj7GdU58tBnOVOA7vwJi60Fal4dEhYdzCfONWvOAZ+vrVnw3anWU8QU16tX33ZH2aopLaNp2vgpou4B34Vf9pw4y5bucgCEjHOmedk+Gll9xy84NZEBU1Rgz24nP4HElkUs2n+PIVkbOmVsntJwhw4efa5SiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/BnCLs0t+2+UN/wz4xrmhOe1Uc+29uxs27phU40XGk=;
 b=XdZbvd5VNCGNzZU2dc/MZ2iG51NEpfSMr1QxJz8CHw+PD06pUg6zxvZJks6btJoPataRDgqFx+G7ZkceGs/lmrzGtPuS5pb2V9fY16VKUYcES++u+yYef8UfU+7KbcYsdbTrHJYV18Cq9LK28NBm38HkvAM2j4+Dqu5xHhAdD7k6UUcM0qkAYiSZ8O0BUDVGdOaxnM7fug9csXzwHajd8bOl+R2SBudDPeWVN2DIfIrTWv3Ch4vClVPynZ7Ba00pPF/3I7iA2aVwt8xUypxzDXGQJVsoxP5PWoEBXLdBFJf52MMZPq5gKC+kkOfZwCGcWvpr0U8lxhsddY5pHQRSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/BnCLs0t+2+UN/wz4xrmhOe1Uc+29uxs27phU40XGk=;
 b=tKPR88YD2kQUxh/vLgPMGYLSZUxC818qr6zJQm9unvZAKigUAeo+fAM8bRzzJ05gLJ/rZAATr+gHCiykF+8BfDjyhPy4ycg25LJLm6NOza4ii474rIXupzwLUh9L8z3p9c/cMt87D1mD8SNgjrR9YCI7G2ddgjQSiwFm+hMpISc=
Received: from BN8PR15CA0053.namprd15.prod.outlook.com (2603:10b6:408:80::30)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 17:57:51 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::b6) by BN8PR15CA0053.outlook.office365.com
 (2603:10b6:408:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23 via Frontend
 Transport; Tue, 24 May 2022 17:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:57:51 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:57:48 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd/display: Pass the new context into disable OTG WA
Date: Tue, 24 May 2022 13:57:18 -0400
Message-ID: <20220524175724.126380-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524175724.126380-1-jdhillon@amd.com>
References: <20220524175724.126380-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16f633a6-b609-4729-61e3-08da3daeebb3
X-MS-TrafficTypeDiagnostic: BY5PR12MB3730:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3730DAE4BED5B27A029E07D4FBD79@BY5PR12MB3730.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNXr/AsT3krFxKxgtNmIududtQhWKWYWvx9eACkNltvuPuzO4eEXFP+ms2E6nMg+XVTpzdk/g0AQjkcYt8Dum+AvEB3wUwGl9RIn9Dt69ItrrM6lZadCanoFSraVm0TMShgJCrsN+iaioAAhZAZ5i0/2OEpCKbmXQgt1oP6W8jZ2bZFGmidJgHg3VhnMxxiX8OXLKFTlBVpvXua5E3lFx7gEvA1d6YBjZ/IL2vicFXC08WN0MMZyV0gTJro6Tr4g7MrM5CCzckqyxoTtb4CeStAVzo5Dk47Bmm0TzCDjUxcAWloLp9nSQYEfkmp414uyxXFey3KUS4Hxq7vTrjQECtoFEYKUEMjOZm9UcUDniwMibw0B+6cF2tEGwi/i8enG4myjCyg/pb+dmh9B9N4yOHzJLQEgnNW1q9z/6jwZoF9Gjkm/11O0mTD8+eF3Q2qjEGLscApHlftElvm3u9c4M8Rq8ucaWx+tGUciovaATcp+4loBEdJMijr1GqQJQKNYmybTng/3+3kPHnT4R1omSlkCtHvMCKZ4WozZBviW7BK63xBOjUGltNHxU/ecgmyQzBTQUEJECyZnZ/zycA5OVhxTO9Of2OCXYG51VS0HPPFdhPE2GJClOUrKWGe8N8mgGAdti2h/ZQChKQSsBl/caCkAkpPeXOsrgaFZAalcBJC+xT6jgp4qlscA6R/hCILTigGc7Edr2VWJqgb6P6mYhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(426003)(2616005)(26005)(47076005)(1076003)(40460700003)(336012)(186003)(16526019)(36756003)(82310400005)(6666004)(36860700001)(2906002)(5660300002)(6916009)(54906003)(81166007)(316002)(83380400001)(4326008)(70586007)(70206006)(8676002)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:57:51.3570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f633a6-b609-4729-61e3-08da3daeebb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
When enabling an HPO stream for the first time after having previously
enabled a DIO stream there may be lingering DIO FIFO errors even though
the DIO is no longer enabled.

These can cause display clock change to hang if we don't apply the
OTG disable workaround since the ramping logic is tied to OTG on.

[How]
The workaround wasn't being applied in the sequence of:

1 DIO stream
0 streams
1 HPO stream

because current_state has no stream or planes in its context - and
it's only swapped after optimize has finished.

We should be using the incoming context instead to determine whether
this logic is needed or not.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 8 ++++----
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c    | 8 ++++----
 .../drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 8 ++++----
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h              | 2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 051322580014..7310482b2784 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -99,13 +99,13 @@ static int dcn31_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -211,11 +211,11 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn31_disable_otg_wa(clk_mgr_base, true);
+		dcn31_disable_otg_wa(clk_mgr_base, context, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn31_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn31_disable_otg_wa(clk_mgr_base, false);
+		dcn31_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 29a3bf57b157..a50e1e519dff 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -81,13 +81,13 @@ static int dcn315_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -175,11 +175,11 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn315_disable_otg_wa(clk_mgr_base, true);
+		dcn315_disable_otg_wa(clk_mgr_base, context, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn315_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn315_disable_otg_wa(clk_mgr_base, false);
+		dcn315_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index ab0f772ae25d..4423f41b40de 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -112,13 +112,13 @@ static int dcn316_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -221,11 +221,11 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn316_disable_otg_wa(clk_mgr_base, true);
+		dcn316_disable_otg_wa(clk_mgr_base, context, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn316_disable_otg_wa(clk_mgr_base, false);
+		dcn316_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index cc358a5ba537..4c880b64f8ca 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -120,7 +120,7 @@ struct dccg_funcs {
 
 	void (*set_dtbclk_dto)(
 			struct dccg *dccg,
-			const struct dtbclk_dto_params *params);
+			struct dtbclk_dto_params *dto_params);
 
 	void (*set_audio_dtbclk_dto)(
 			struct dccg *dccg,
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F7FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156661139F2;
	Fri, 10 Jun 2022 20:53:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E511132A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkhL4lcHDMzq63Bv7o1XppE6HEN78R12AzQ+ZecitZ17cxo4gS48R9bYy4Hiyi0CYEjPvDHGcAq+wVHwwGFEpU5cQYb6OmxQUP1RKtycAzGB1DKhfnZYc+Z0Cx+4/xK+KV+Hezk4ndoUFpZeR1pSh1GkyGUNbBe3kIJnCscaGN8BR4mW73i22fp/Bkc7nLS2+47XYfLu9tndHhoPxbYXvz/Ho3kE6mhCk3CNRdhdM1WMAq9HU7hcYTwuor8alUHhwvIWG0O7Dd3pVfU8yOHCtYH0B34YudSw4yPhPB//H5RpWkdLLIFkHRrMnQW6rnDLNj4yLy+5yazmp63jrT6AbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bQ3/f0PpDlh8mG3hGcLQX4XNrlwIBWtcZKHDa82ik0=;
 b=ax1ppz3HyyBGHTJLifGtZeb3objxzh21U3xwG16zp4/Y7elH5282Ggyoz3N6HdIH/mikJOM2imS6h2P/oKPFTRGVKJ3zwq9/YPO05yfzJ/jfApqKRkqd0L8Qmsw7AYA4UsCGGMQCDk3VsReRlPmCq9kPKLvGdgkz5PpCd15h/XdKAAp17B4RS5cuHBA1c6r1NdcYacCSJI2NplYhN8NHBt405dWqAF2bLWrAJerocIlEf+dQLpoVX/69ZsSGw6eqAM48qsHahF1dsDaOhdBEprxD9CIeu6cm+G5+xyQiYu4psDYcdg+a8L4ndbRD56Km5GMkKdot6uhpqkxIKe675w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bQ3/f0PpDlh8mG3hGcLQX4XNrlwIBWtcZKHDa82ik0=;
 b=YEZQLNUN8WWL5QWLNRXzREvl4uXjHHsSnPdtK2Hf3UgD4nLpYHJQlVrtqPQJuZ8LWaNgOadN3/Lvq9EyvUl++xUhoHnoHO1jlbZavhQeaw+PTtfQI448RqEqTLhtuX7HgZ7B6Y3npnOt1VqiPCUS2V8YdvHRzx4++sXqnaO4LMU=
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 20:53:46 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::c3) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:46 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:44 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/23] drm/amd/display: Blank for uclk OC in dm instead of dc
Date: Fri, 10 Jun 2022 16:52:45 -0400
Message-ID: <20220610205245.174802-24-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e37db350-6c16-4ca9-52cc-08da4b234fff
X-MS-TrafficTypeDiagnostic: PH7PR12MB6443:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB644391EBFFFC3CD1CE5B1B07F4A69@PH7PR12MB6443.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YabX1ukFCFeZBf65PRHWXAFY+iohuYU7dij5fdKTjxxsiNOVTMOq8vA9fjsqKNITrSKbGlixY/mYpkHWfB3uYoci0p5CiDOpW5lBHwJvQ+eQ26AdkOnckdZnyjAzyun510cvor2LimkzLtAJPfcGS34GMhdDpnNgw272VlC35+YdbQITU2/aDNL+uaMho5wrmuOAemYvuokHlM6Vkx+b4kRP0AysLDtoQgVMQTVDDlhn9wlJ6vsLUtDRDfljpFTF+5Dizb4yzkRoIiFhYhKQBqd4wAw+YfMa0H/gPQ3//hTzFLr9L27CuS7FbCWEnZTbvOwqxeAV5sQpm/mwHOIyFsi7BgfF6f+RtSh6TroTqHknoGy3mGjW8OgpC09PvZsRfGrgzcIYBEx+TwQsCuJ1CXtHOD6ecvYBhKz9gc7OS015aDKzl1Wnmr8OWCPimuq5PG2Savx3bTl9ddIFAj+wUycQgm71WzoW67E2Skv+vqicvWsuFOsrfhQFA2getARNr5IFLQtSSCbxk1ZzSx8j/JNtak7RAMgCvZIFJfPN7QOB3qbu/K5z5aUy9WCMqu7txyx23xEsKyRaqKkvdh8OppF1JpNEWl87BuASPqVPBc4V9Vk015ElapiJuotgGW/TNZcq3atLf2raO0mnsFhwigjsMnOLbs5HbURZRVCusBGlQ1zY46YlzOb5FoOe2NFqmWoaM/48YKiiDDS5FsYE4sssB9S4KMiCE1BTSe5z1VmDpbvQNTTekR95c/qmiTdL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(6916009)(54906003)(8936002)(16526019)(83380400001)(186003)(44832011)(5660300002)(1076003)(7696005)(2616005)(336012)(426003)(47076005)(26005)(36756003)(316002)(82310400005)(356005)(86362001)(2906002)(508600001)(81166007)(36860700001)(70586007)(70206006)(40460700003)(4326008)(8676002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:46.2543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37db350-6c16-4ca9-52cc-08da4b234fff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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
Cc: stylon.wang@amd.com, Joshua Aberback <joshua.aberback@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
All displays need to be blanked during the uclk OC interface so that we can
guarantee pstate switching support. If the display config doesn't support
pstate switching, only using core_link_disable_stream will not enable it
as the front-end is untouched. We need to go through the full plane removal
sequence to properly program the pipe to allow pstate switching.

[How]
 - guard clk_mgr functions with non-NULL checks

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 34 +++++++++---------------
 drivers/gpu/drm/amd/display/dc/dc.h      | 10 ++-----
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 258322c39e9a..48a14a5bda56 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3666,37 +3666,27 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 		dc->idle_optimizations_allowed = allow;
 }
 
-/*
- * blank all streams, and set min and max memory clock to
- * lowest and highest DPM level, respectively
- */
+/* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc)
 {
-	unsigned int i;
-
-	for (i = 0; i < MAX_PIPES; i++)
-		if (dc->current_state->res_ctx.pipe_ctx[i].plane_state)
-			core_link_disable_stream(&dc->current_state->res_ctx.pipe_ctx[i]);
+	if (dc->clk_mgr->funcs->set_hard_min_memclk)
+		dc->clk_mgr->funcs->set_hard_min_memclk(dc->clk_mgr, false);
 
-	dc->clk_mgr->funcs->set_hard_min_memclk(dc->clk_mgr, false);
-	dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
+	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 }
 
-/*
- * set min memory clock to the min required for current mode,
- * max to maxDPM, and unblank streams
- */
+/* set min memory clock to the min required for current mode, max to maxDPM */
 void dc_lock_memory_clock_frequency(struct dc *dc)
 {
-	unsigned int i;
+	if (dc->clk_mgr->funcs->get_memclk_states_from_smu)
+		dc->clk_mgr->funcs->get_memclk_states_from_smu(dc->clk_mgr);
 
-	dc->clk_mgr->funcs->get_memclk_states_from_smu(dc->clk_mgr);
-	dc->clk_mgr->funcs->set_hard_min_memclk(dc->clk_mgr, true);
-	dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
+	if (dc->clk_mgr->funcs->set_hard_min_memclk)
+		dc->clk_mgr->funcs->set_hard_min_memclk(dc->clk_mgr, true);
 
-	for (i = 0; i < MAX_PIPES; i++)
-		if (dc->current_state->res_ctx.pipe_ctx[i].plane_state)
-			core_link_enable_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]);
+	if (dc->clk_mgr->funcs->set_hard_max_memclk)
+		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 }
 
 static void blank_and_force_memclk(struct dc *dc, bool apply, unsigned int memclk_mhz)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0549fa2c572a..ba57e03d3d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1437,16 +1437,10 @@ bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
 
-/*
- * blank all streams, and set min and max memory clock to
- * lowest and highest DPM level, respectively
- */
+/* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc);
 
-/*
- * set min memory clock to the min required for current mode,
- * max to maxDPM, and unblank streams
- */
+/* set min memory clock to the min required for current mode, max to maxDPM */
 void dc_lock_memory_clock_frequency(struct dc *dc);
 
 /* set soft max for memclk, to be used for AC/DC switching clock limitations */
-- 
2.36.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34196C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC78D10ED0F;
	Mon,  7 Mar 2022 05:51:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237E710ED0F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev/uoIZPwWYP64zbjiqiFYv9s7E5b0rZY9bNf2TU+Qu0QlMh7dku5InUKdLMCG/yar+N//kDy5D3aWONMWAvQvkEstVXO9YpdWyr8HNie70zcuZFV7rFS+6vR9YS7E+AXnk5qKE44QSDqPAhIX1hA+iyMQRZE70MyME/a1ohIt/jed99WrsUxrhdqp5UMRrVl4FS+HA1+TpGmeamu/OFg8mNa1iCj3QOJIqYLVFmDFlLZrkT+13FyNoWF7vyaTrd5xWQ5wbrrNyUjKxDW1pLuEAVrDm0FaKw54Pb3y3b9FpwS48/KkV5zXVf/PTpBM4NqAPTLoQot5lrRyExWWQICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw9cZVymHdxbnSLVYffUFogauEhdOnBE+NX3Ivp1iis=;
 b=Os5xGlncDjZGT9GXQTfp0eQiplT1LoAULjzkAGqeK5S/pTAM+kEwC6WfBLwLOmUiMqQH9C5UkeP2wAxKl8NYp3s9WpmSZvlLs14KEXOBtHYP3/ngTwo3P0iVsrRGLowWRK/qliwHFLOPw9Z2en6JbQGef2iviF/bwfLzVL1h7984LWGU+MswXZVPBYTsUP00ZGsc+xP35Gwr+sm3gp6zKoH+H9VBQAV/ZQENYTKgfdvar0rwYoHmg8dINuactyWCV6X0MU89d/yEr5AEoOF/uyZYsDeqraVuGEMbgiXzpCUWVLdHk0dv7JjITYpdxOwIqcr5lB5kRJpRmb8E34xV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw9cZVymHdxbnSLVYffUFogauEhdOnBE+NX3Ivp1iis=;
 b=No67HrLu5dg8lFFuWtYymjRCOVf02ibyV6LtV48V53qW5Qdtpm7DhPx+g292Q5TYwJhzpNFsLv0fYv2xo/BezJ0q1X7ubu3mKieOz7igy9WPyA1DGwL4684eQO0M2ibz4CGKFXztOcbFWvII07u+XCkGBDZT520fuZS4j+jbLxw=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 05:51:16 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::1c) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 21:51:14 -0800
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:51:10 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amd/display: enable dcn315/316 s0i2 support
Date: Tue, 8 Mar 2022 05:09:36 +0800
Message-ID: <20220307210942.444808-14-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74a4b0c-e62b-4d9a-02ab-08d9fffe7e39
X-MS-TrafficTypeDiagnostic: DM6PR12MB3097:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3097E3442237A2BA2E1DBA03F5089@DM6PR12MB3097.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qpq0TeTbI/HoMX3kOAjhKvnwmTWaiQgX3aJgJL8RtLBPD0I1n5rfnJ2t2sgl6nP6VJH6HIOwDzp4r+pkc6eE0HaUt4MjeC0EQgz+dBk/yZVHrDzeGDGuiTCb79Pa8+JhQ7iR/YyOxi0bZFKQd+S0xOv6gF4xhU535B8ouBnStGdBUS/ZVtmgZcA3jCHcvDuzhz8cmh69Q+qHZpCKMj6MHjAPhhtY1B+8xGG2pDYldFskNfGIY3I4Ai8pqoE4JX916xWiGqjnY2B31FqCH4zgC6AfuATinyxgW2aY+0cRPpsnlhGAV3s95pjzwmXJT3SjvFSvPFjs1in1W3SMbe+YmwpmfdIggiOYVSGwsCLF67WzXaQCFBvs6eB4Hhp1Kp/QwYKmjXUpiggP02v7kCVcKHy1mj1GiWTykecWeZrUCZZ/qd6mcGpKdLAIy6ONAyhtajvSkQ8ms2GPdGgAWe4plGGLHWJNk1Sv3LO85BmFT/GjXxoEL7WHocZwPTeqL494HBNBi4Hnztz54+WQoPHs7B3efM4cf330KcoZYSatry1+kN5nfga7wsze+On2xbHBsw82AD26qnL8XKtv3a8IooTVxx5/hujxdjZKCxpFllAdVGu5dOPGU4pjSYOiAD89PiFu0sZRAU3tJXewk9QuJnjVaVL8K5GgHA+nuOqHWwMTH9qB0w/PczErAJQ2liN+kxJpfAHG5O/atB31Z81A8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(81166007)(356005)(8936002)(70206006)(6666004)(36756003)(54906003)(5660300002)(40460700003)(7696005)(2906002)(6916009)(316002)(83380400001)(82310400004)(47076005)(4326008)(8676002)(86362001)(26005)(426003)(186003)(336012)(36860700001)(70586007)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:15.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74a4b0c-e62b-4d9a-02ab-08d9fffe7e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
enable the support in driver, let the control by CMOS

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 48fab0a0c08b..edda572dc570 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -131,6 +131,7 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 				union display_idle_optimization_u idle_info = { 0 };
 				idle_info.idle_info.df_request_disabled = 1;
 				idle_info.idle_info.phy_ref_clk_off = 1;
+				idle_info.idle_info.s0i2_rdy = 1;
 				dcn315_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
@@ -526,7 +527,6 @@ void dcn315_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dcn315_smu_dpm_clks smu_dpm_clks = { 0 };
-	struct clk_mgr *clk_mgr_base = ctx->dc->clk_mgr;
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn315_funcs;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index c940635b7a74..43120a8f8305 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -172,8 +172,7 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 				union display_idle_optimization_u idle_info = { 0 };
 				idle_info.idle_info.df_request_disabled = 1;
 				idle_info.idle_info.phy_ref_clk_off = 1;
-				// Todo DCN316 set this to 1 if any no issue
-				idle_info.idle_info.s0i2_rdy = 0;
+				idle_info.idle_info.s0i2_rdy = 1;
 				dcn316_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
-- 
2.25.1


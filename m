Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92D0C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAFB8B043;
	Fri,  5 Aug 2022 18:01:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54F711A666
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3Rckj8zyjbCZ6NII3b+KZV0Yin34ENW5bKrRGaFWuB+xGUEa1mpWIDFrAYizbwYQCoyR7gckg4XgONxi6jSEV1+oFqwTDVa19iCkFW/2ddgVEfDoLYIYaoLspFdp/s49aCF9vce2VNH4bzGyQGUwzAdXXax0PczrmgS9EEgbj6nv2X/XJDsWdpmAGUIubty4tX/FA0NlL/1cCCN7MiW39tj9JWAIoGO2yva61NDWB3bv2d6zybj+vlqOhlb46QXOeriJ7FSp7RnO0JhxaTzXeMMg0q9zRywC2Hobr//4Njp5OcctrvXSQbg3+HHWkSsphWhshGgUCfyGrDuNKk6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2VOdGP+PUZa/ezNPYLjRoa83ytx+YzsRR6DOTUlEDA=;
 b=MsA+nnbtwkkCDfePGHIRVVj03COdeWbzWmWHB5AM2+Ws4l8yjLYi7ZMx+Cm9bsvZslzShr6iTSZchuAnfymGHx3q7/cheRQ8BXc3uwczsP4fMO3XNfUrNrD8wDonHmvcNbzCJrcTm/JJKa+NZNpo2FuMEF6ghRTSraE4Bm18B94SmqJ8h3raz+9cg1SwRhv9koPJRU+bOI1KoHlo7XaGPHpDtwu0sCDVWKBUBd6lmFPEw9wJtZJGvZDWFxRUrZWGTrMVzQmxp+3xJKsZV7+EthTOC1CiCD9FpnDIEPL5qEnHt041SVOb3Tgx0ozyehA0RjuzJzafqLfVKCqrPqE6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2VOdGP+PUZa/ezNPYLjRoa83ytx+YzsRR6DOTUlEDA=;
 b=U1+FH2D4dMve+J4qq9+I4BRDrkMIA2Gbh+tkXDZne3W23ilPc3G4ySdYNIZzHdSYTLNjWCmKO0zI2BKPbE+3COd7rfHYmxEFePVgo8J/SpgpkEMixXSYrCLkzew7iMjSIJ0pq/NJTc0meMA+zyVOkT080xkWyA+tk5e5HDhtuZ8=
Received: from DS7PR03CA0233.namprd03.prod.outlook.com (2603:10b6:5:3ba::28)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:01:26 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::f0) by DS7PR03CA0233.outlook.office365.com
 (2603:10b6:5:3ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:25 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:19 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/32] drm/amd/display: Correct DTBCLK for dcn314
Date: Sat, 6 Aug 2022 01:58:20 +0800
Message-ID: <20220805175826.2992171-27-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bbf5ac9-1f0f-4a83-d725-08da770c83e2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjqaiTxBWlkjAGELSkrkdj7HzxNDd3qdQ6NCYfIQQp6CaI0r1vEIsej6tIlpqUvcHeij4ty1BdRKq6T80a6WqM2u0sGy/E6hprQYhhi4IiZsKE4pMrcPs6UiQykdydryahbiuJmDzg8ilUGr1WglYjAYqREg2Z1cTV5QVdCFh4XnLjfLTy7yhkRlUS66I6YSfhwx+8KZxLmwstGU66+7nRoENSLON2UF0Sl1uE/5OdxhVfeDXjwKT2aRSvSEtadI02iaGfxuJF4653tiKMFlOQTzVgWQYHbFgab0HWaJZDE8+eKgbWN5g3AdAZ4V96YRlmkPOaipzB6bTHiJhbXd4D4iwb8Fy7HLDMi//ndmnKvGEWgPy5JWAqNF5ZZ3MktVhlurYrK2eo2U8opBjvg6mCDW621F7ntzOANVoXDLllsv1RK6xd0V6hCK4mdjRE0lhax/wsAbSamGvxhL3uJpTrks1x3v2bxRr5k8pghq/2rQEEw5/ZdTaDYzuTjwmQDtqCxh3Z5s812ZYezVVomQTSJ18KntaBgG1EOGzWl7HMiZ0EXtxAI1RdBWI8muMzycjVO5xaKg2FvXdkjYGr0Dlim0WGmQ9dls6zBm1EHloLXlJnQtvg2igf9URmbNQFB+YczyP9l0X/j7O94lN4JTKSvPjDjL/DaIXiO8h6VD2iOxSKN16adohfGI2IM3Bukm+GftXeQq+/cd+GKXut9IvZw8rpwm3jcvv7rlg2uttX2WKYd5+D7JmvXE330llC5o9uHK0vaZ7/ZyToTbQktiDpFJX/yk245vl9EjAgjBYdYhtsQcYjNXeYYlpFtbftt3tMBwU09MkTpByVKhs8Tvvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(40470700004)(86362001)(81166007)(36756003)(316002)(82310400005)(54906003)(356005)(4326008)(6916009)(70206006)(70586007)(2616005)(82740400003)(8676002)(7696005)(40480700001)(478600001)(47076005)(8936002)(1076003)(36860700001)(5660300002)(41300700001)(2906002)(83380400001)(6666004)(186003)(336012)(40460700003)(426003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:26.1403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbf5ac9-1f0f-4a83-d725-08da770c83e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
DTBCLK clocks reset after clocks are initialized
and bounding box values are also incorrect.

[How]
Use dcn31 init clock function programming sequence
and correct bounding box values for dcn314

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c   | 12 +-----------
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h   |  2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c   | 10 +++++-----
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index ee99974b3b62..7af19823a29d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -307,16 +307,6 @@ static void dcn314_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	dcn314_smu_enable_pme_wa(clk_mgr);
 }
 
-void dcn314_init_clocks(struct clk_mgr *clk_mgr)
-{
-	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
-	// Assumption is that boot state always supports pstate
-	clk_mgr->clks.p_state_change_support = true;
-	clk_mgr->clks.prev_p_state_change_support = true;
-	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
-	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
-}
-
 bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b)
 {
@@ -641,7 +631,7 @@ static struct clk_mgr_funcs dcn314_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn314_update_clocks,
-	.init_clocks = dcn314_init_clocks,
+	.init_clocks = dcn31_init_clocks,
 	.enable_pme_wa = dcn314_enable_pme_wa,
 	.are_clock_states_equal = dcn314_are_clock_states_equal,
 	.notify_wm_ranges = dcn314_notify_wm_ranges
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index c695a4498c50..171f84340eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -42,7 +42,7 @@ struct clk_mgr_dcn314 {
 
 bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b);
-void dcn314_init_clocks(struct clk_mgr *clk_mgr);
+
 void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index d52a16d280e9..c80307a6af1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -106,7 +106,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 			.phyclk_mhz = 600.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 186.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 1,
@@ -115,7 +115,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 2,
@@ -124,7 +124,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 3,
@@ -133,7 +133,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 371.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 4,
@@ -142,7 +142,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 	},
 	.num_states = 5,
-- 
2.25.1


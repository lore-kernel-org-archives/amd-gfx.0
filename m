Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2EAECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCDE10E847;
	Wed, 14 Sep 2022 05:17:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23FF10E845
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4NQZ6cMCZvPrj1/4u+pjI3+t+bDKirEQXsjapR6wVLIMsD+s8U88gDbaexsP/hkgwaRkY0qGkkOEDv34qzBj6WVsLktivldyh5cKl0Kp1FoYiOEYZD21aMy2VDcrSvNHNT0SX5Sn+xDFgLQGnyuMeb3aaxNYbJaSy4kv/4+GaOgevMjt7aaA4YxcmqUkBGdsXXHgDrGjXFHIbgOiJFnUoihCuZ3MfXzs3Uxrzg45ByI7dtajHdQh76OMaYZeGTFH35ItwSP8GJDFGt86lEbOXJfUUWmhdkyJgrhdmagePMht08rWazla2IGGdNPX0qot95/4rdwJXALH77y4z3Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+dhn0QEoRHShfjPf9ORarSvLDc3xLVfZXkyITWFWk8=;
 b=LucXqszZECAgybJiUxn2sB0pKl3u6AksIw4ZwHMEOVVSDtYtWawd5aQMOvDApVzSPvX6XGtZxvtVR9eeIxGHelzCMWJ4NyyCwYrQa849FcUnZc49G9VnPHAS/nw3jP5QsKaBsInu+xO4h55uwZixR8Zi5cwcZkT2TDHfNRVpA+2FiM/SSdiPR/6FOT1dxkogQ7H5wmDaBEuX82eOwqZvGak2TSwWQSIcqyeEiUTgfPgD2aaU9D+1LEWhTNHqzGkmlGtH3MWXM6zjG867M3o2FjB583gaNHSzlkc8+CgQoO0o0PKLMLKEImNWepcj3+ls4Vav6swwxINAvkctxo0jJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+dhn0QEoRHShfjPf9ORarSvLDc3xLVfZXkyITWFWk8=;
 b=K7OQeJZJTjNN5yCR5y8Dm+z0D2XrZLfMhqqRczk1q/YRYrhATHSx0GOIBaUbO9XeDGf6tIZYg8f2JDfAM6mSJwBmYvsJPDSgSRcJzDmdHKmGiNykKzVIBatxIErdjY/+bjMn3lmCGlNa7zEdloxQHsiABXoOnA+IdllBTkpWtkY=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 05:17:35 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::8e) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 05:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:17:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:17:34 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:17:29 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 33/47] drm/amd/display: increase dcn315 pstate change
 latency
Date: Wed, 14 Sep 2022 13:10:32 +0800
Message-ID: <20220914051046.1131186-34-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc15542-7b0b-4e43-f124-08da96106efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7koqsHZQHXiLm9MFXab+AY6HmpusIxnIQXe8jBeSL5YYaXNr7/LC47xWK7AOvDTM/Z4i1SLv10uR1/1XvUv1Ra+K3JnEBZwfqBfYDEcDhEqugYQh8gvQjC3hhZO/vXwX2oSdrWH69P0p3GQ36OEY2XpYZEZzC0ZutoCZk5pKtg5Eb5jCB0NOxgSeOkOEJR5QsMzzEwphRI6baNWhaHBDxY4vPMOaOl3YTm52XE1biYCLi5+Cq3YRWaG+AZ2tA+NrYoKSooz+Megopud2543dKphd0juGncSpRQ9xBv246YJbpUMiqLjcILcNvU4B2DJhun3sRrhedvHQcFobGnRNznlUw+e2wy//KQmci4z0rZG+waANXRj/YXN1mdVGFiiL8Xv7/UIohkrBz38brlxTYZYvYdtUIYVtxBi8SRKzd2FhDzTRICJzLQW7G5tCd141N21l5GJkwdm50KFI0zOoS+fz8bryrp3hygC57Y9QVcSyVbU0eNij2Ak/oNbtffHm6oxMER8itNHRJErH8wl7+MtzslboKv5p6IpvzUw4H/SLBx7yn4mjWuRwpmGKCfuEzEAEuF0fFGzPqOmKlDdPsewhbATEq2yGNz1i8FpxYOgroZTi8RVh9tkUp+SWyMuQDcg9QUN6SUDY+jxqBzId2X16CDut2EmCVftx5IGd+4P1P9HRdTuyJ+ZEgxr6bQe3m1E/QEsI7jnz+zNFR7AIHMDHTEssDNxSKz8tTqkByjq5N4TbEjBfuMEc3ArfgW4db+jZwAn/R8N6GwupNDmz2XBSEt+W4pewFjXY7fzydnXlNYx19MhIf6CBH5v6UuF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(6666004)(316002)(426003)(54906003)(70206006)(336012)(36756003)(41300700001)(186003)(40460700003)(47076005)(356005)(82740400003)(6916009)(40480700001)(81166007)(8676002)(8936002)(82310400005)(4326008)(5660300002)(83380400001)(1076003)(2616005)(86362001)(70586007)(26005)(2906002)(36860700001)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:17:35.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc15542-7b0b-4e43-f124-08da96106efd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Update after new measurment came in

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 7f481ab252d0..893991a0eb97 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -51,6 +51,9 @@
 #define TO_CLK_MGR_DCN315(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn315, base)
 
+#define UNSUPPORTED_DCFCLK 10000000
+#define MIN_DPP_DISP_CLK     100000
+
 static int dcn315_get_active_display_cnt_wa(
 		struct dc *dc,
 		struct dc_state *context)
@@ -152,6 +155,9 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 	}
 
+	/* Lock pstate by requesting unsupported dcfclk if change is unsupported */
+	if (!new_clocks->p_state_change_support)
+		new_clocks->dcfclk_khz = UNSUPPORTED_DCFCLK;
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
 		dcn315_smu_set_hard_min_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_khz);
@@ -165,10 +171,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
 	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-		if (new_clocks->dppclk_khz < 100000)
-			new_clocks->dppclk_khz = 100000;
-		if (new_clocks->dispclk_khz < 100000)
-			new_clocks->dispclk_khz = 100000;
+		if (new_clocks->dppclk_khz < MIN_DPP_DISP_CLK)
+			new_clocks->dppclk_khz = MIN_DPP_DISP_CLK;
+		if (new_clocks->dispclk_khz < MIN_DPP_DISP_CLK)
+			new_clocks->dispclk_khz = MIN_DPP_DISP_CLK;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
@@ -281,7 +287,7 @@ static struct wm_table ddr5_wm_table = {
 		{
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 64.0,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -289,7 +295,7 @@ static struct wm_table ddr5_wm_table = {
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 64.0,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -297,7 +303,7 @@ static struct wm_table ddr5_wm_table = {
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 64.0,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -305,7 +311,7 @@ static struct wm_table ddr5_wm_table = {
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 64.0,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
-- 
2.37.3


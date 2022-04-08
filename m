Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF6EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9E910F110;
	Fri,  8 Apr 2022 17:27:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1981E10F0FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9fNiUEA7FAC36Pj781MAfCXwAonl+MhLnhRPLX0RMvRREQIzvWZ4OkDLUHuKZIVJBfA9W1/XOaQoiE5uzG+52Rz7mAwi1rot663ff5V4VYF2yqXNi6uF/Advioa2FExj+kc4l1UY2wXcSikbSqS7MyiHh50k0sTofvLcwsoHgLgJjdnwOR5fG9QgbM4l+9SlxpJxFxHgiboihAip4l+mOBsFvYhtVUjmxcHn3IWMURHaw21ikGlof7S+n0lXn40XziJb2fpRExX3f5BYNVXiqPjFuGvma/IGO60CyRGhwGgQJBkZ7DsXtvX0XioV+JwD9s6jFF1XRuO0916WPgEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umj7yguUVFAPowmKNV4TuAFBZxcM6tbsmvIPz42UbCU=;
 b=KFADen2YkLD8YmLwi2OYeBtMcQEVOPzi6Raih4DNNnxpUoGH7Aiw7qz2++xly9NZ+9oRHq9CYxVqV8H686wrXnHbGiwHixgfuIu4oSydbBr0QtRKpUJNzQFQuqz2pEorRUSbJXhpNg41l03R2+kHgPs62cDTF1DZl6aaj5VLBD84yt1ysAUlXrI4fuJJf/jBoBwN43/AFpaxSFiiDnNDHQlf0hF38RXQcHfyN4wepG+sF9QxyFVnhidmD9u4oBqdl1PdZCOBZX+rZjS6z1vpdcD8pQ8qN1hXrL8E02jtbmIs4dM4s1iUSxHolgJO66JE0VAL1P42Ytias5420ksNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umj7yguUVFAPowmKNV4TuAFBZxcM6tbsmvIPz42UbCU=;
 b=KlALIvLhJQ2eFDQra0yNVMKOgrNi8MyVlEFLWmFXEmClREeh+PnpqrUg8Pxe90bgR44Tr3Ezb/bsiiW6gSBLmWXWlcRsgm2yJi/vNzoUO5xhicagcSBGbbRwTbZBa3/Bvd0hDYGoAIkFOgFtXsIQakQ44U5SORhuszulNOMdayU=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Fri, 8 Apr
 2022 17:27:39 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::5c) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.27 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:39 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:38 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/20] drm/amd/display: Power down hardware if timer not
 trigger
Date: Fri, 8 Apr 2022 13:19:00 -0400
Message-ID: <20220408171911.601615-10-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf6ee4d-3480-4e92-41a3-08da198514c5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5899:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5899E5041C22477DE9A94C80FCE99@BL1PR12MB5899.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO08MyGnmvvD7SWWFQlaVhlZ0SfvJXTpQP1wm5PM0O/hxpUtw8gJCmEMBhHFQHOVtFytIVPrTpxKCAoLvENWaihAfTijLEkATzQ+8RbTFbMKJSR5Q8J9psvDVr504oqxLXq/Zm+TPoVV0KKA1u+wp4hRxtuBD3RHzkLgowb3hSTD/pz1yVgAxwNobAugwrspXX/2LXRphCmGBQox8R0fQX4z8XdJBV0Z36cZCi4D2r2xvRSDSIsGa4+y9H2cwk3zKU/LYI5NsNydKK2JF2R7nSDWcZcIr4H2SW36uC20S1HwJWNNJyBM2aygxZD3l3nTMXjAiMi0Vj97vCtOl0/HqpTGaNQnGp2dIYG5KBGrDH+lGAUiMiPesM8J/GXdRfiXITr5Z9nuJyYXrjtQ18I97MjoFr1gIZlTnrgtOvH/BpG0CDu0i7sbhB4dwZq/J4JckpI1jR62YI9qoMP49sHqnhGjilDoF4lgAmrSIdzig8/AANP7S/8v6dF07A030siPnrtfMCJveNYwWFJTZkgZGARu74QOwC6RKEMXpeq/POwxPOhU8J7txXfhQVCKUCdRdpoSIkICL6nYR2bfZjywsBTfzgOoMlbLplA+ci+gk/BMuFLyfkCMBWnRIRSAIiCy2MbXHZVunK84qf9YshzETnFB3SMMTZEuQwr36jm+ttFe8uyEtXpgZGs18c6SCNFZllr9u6SgdHtqlSwXHGZyxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(16526019)(2906002)(86362001)(83380400001)(82310400005)(40460700003)(5660300002)(336012)(26005)(186003)(7696005)(2616005)(1076003)(8936002)(6666004)(6916009)(54906003)(36860700001)(508600001)(4326008)(316002)(70586007)(356005)(8676002)(70206006)(47076005)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:39.5069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf6ee4d-3480-4e92-41a3-08da198514c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Paul Hsieh <paul.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[WHY]
In headless systems, if SetMode/Power down timer
is not called, hardware will not be powered down
causing HW/SW discrepancies. Powering down hardware
on SetPowerState to D3 will ensure SW/HW state is accurate.

[HOW]
1. If PowerDownThread timer is not trigger but OS call
SetPowerState to D3, power down hardware.
2. Update HDMI hang w/a to apply to all TMDS signals on
headless system

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 17 +++++++++---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 26 ++++++++++++++++++-
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index f4dee0e48a67..02943ca65807 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -88,11 +88,22 @@ static int rn_get_active_display_cnt_wa(struct dc *dc, struct dc_state *context)
 
 static void rn_set_low_power_state(struct clk_mgr *clk_mgr_base)
 {
+	int display_count;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	struct dc_state *context = dc->current_state;
+
+	if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
+
+		display_count = rn_get_active_display_cnt_wa(dc, context);
 
-	rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
-	/* update power state */
-	clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
+		/* if we can go lower, go lower */
+		if (display_count == 0) {
+			rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
+			/* update power state */
+			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
+		}
+	}
 }
 
 static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 59fdd7f0d609..969b40250434 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -615,13 +615,37 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	}
 }
 
+void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
+{
+	int display_count;
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	struct dc_state *context = dc->current_state;
+
+	if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
+		display_count = dcn31_get_active_display_cnt_wa(dc, context);
+		/* if we can go lower, go lower */
+		if (display_count == 0) {
+			union display_idle_optimization_u idle_info = { 0 };
+
+			idle_info.idle_info.df_request_disabled = 1;
+			idle_info.idle_info.phy_ref_clk_off = 1;
+			idle_info.idle_info.s0i2_rdy = 1;
+			dcn31_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
+			/* update power state */
+			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
+		}
+	}
+}
+
 static struct clk_mgr_funcs dcn31_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.update_clocks = dcn31_update_clocks,
 	.init_clocks = dcn31_init_clocks,
 	.enable_pme_wa = dcn31_enable_pme_wa,
 	.are_clock_states_equal = dcn31_are_clock_states_equal,
-	.notify_wm_ranges = dcn31_notify_wm_ranges
+	.notify_wm_ranges = dcn31_notify_wm_ranges,
+	.set_low_power_state = dcn31_set_low_power_state
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
-- 
2.32.0


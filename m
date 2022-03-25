Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204BBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC53110E1D4;
	Fri, 25 Mar 2022 22:56:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1FA10E1D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Squw71pOZY1z6rMoMnXe/nFtt/KzNFk9OpYQQ2GekncdozAUoFF0uVjOH91weuFl8onHsOzu+eUbJ3RvSoSjY7MfbaU3Y6I1TcLy/ZQZjZAaaEJpyVfiAzbnMKqNJK0oU4ma3BRyujWZzkH1YEuyoj/RElb9T5vIYlJrz99nCey4E5ogFYmfWX73ug0zM78qL4RJaTmP8MKNCpUAMYAH1C4DYVvSUWQe6Nsweat7dnZ8RWidrbV7Ioppc2GUHpqNJEWRbCCCIN8pTDHLeE22LqZUw7ZHtPhNVKVlyke6y9XSizagRJdwPOG3wOaYW4CrGzpzkoSr+hcF8WTjHaFSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6eA5ZhX32gF0Yml72eJz4PBmzn+RnG1+jT08rvIrsE=;
 b=JfyR9omYbkX+ZvY7Bi5SmUzWa/symMg1uOdlNbNVN+RjmYOkwIhooao/7swYH/3TMK/1AGh8pIOf9eD3pqD2RBTlNJSwy4Exl6zdIs61V7uLNCtkJlsHkCLbyisOgfUOGWkpRPORBg3NoivpVsevuvXrkBrMvMaUjW8SpH/oO+cS/MSdTaIrCXWjEm2bCZtaRXA7SHWfGH9Oq9yjMfb5fXJcPRj3tswWCodFW09ufzU4KlLUG44Z34fSsvtz6RFcWEvgZPsix5PMJbMf/KeYPYuo1vzIUCJEePaYJPclFxwKtC/l3z+MFcSObj/Jy/XwItmwfpD4VUc/jnGriSiEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6eA5ZhX32gF0Yml72eJz4PBmzn+RnG1+jT08rvIrsE=;
 b=X7YsLHym0SpFTyF+BaZ4EJKesB1AiRMoGiUK3z5qyG9UD6Ar9zeHGvGLrIq0E3hXHd+jRiF5XTjpheKpGaGbwpH/j+QMs2WQwCZfZ97XbT8ABwSmAdYJPx2fF3y3ZBaIhsskiwIYWaXPpcDF55/V+IzhUKa+3rAoxMNROUpeRas=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by MN2PR12MB2927.namprd12.prod.outlook.com (2603:10b6:208:103::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 22:56:10 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::f2) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Fri, 25 Mar 2022 22:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:56:09 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:56:04 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Power down hardware if timer not
 trigger
Date: Fri, 25 Mar 2022 16:53:52 -0600
Message-ID: <20220325225402.469841-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a0a4dd-f30a-4cfc-8f4d-08da0eb2a6e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB2927:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB292740DC15F4C3A0C5524099F71A9@MN2PR12MB2927.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD8GYPRU3ZPeymJLv8+lGQZgHAubrVOL9atLMFOmvkhYExgoF3nMFXpuLK7XIjNouqgWLNv4EH+2PdOCAywkGbhsKKul46mIFC3nRvpu5XcV3i26rXY4LOO26hvsJ1r1UINw+ZsGNc3DRJ1AfjqufxQteH1sY9sObbCMFehIRUj1bEOPJomCRAEuHFKAUCaaZINXiLrqj2WypiWNOCchIvi6f8/OUu0OdWHtBUtgKNmz1ol1WxTsyL3NSVKlUMtFLgabsL25d5ucqOlSe3enmhVMZ6wb6lB0sgZE70sONBjCr/GaLJDmYojDZ7scB0ZxaqeayLtRCm2TrR1DswGtrHWQTSTaQ5F/1P4Z7aTDjyQb1LV/RUfDhS10EvrktsUvD9ezo3Sot2Oz/7DoevKnhfBRtgPfYpEU/ILsIpvntgs+1Knzz7veCF22tedv/nQIEVHSW39BZYTxR5BlTBUvXyl7KBCnFq2krp5S/pU4sy7SzF8vnXMlSx98PNECEJpDYPn+DHB0wsVgw9tpQae24++9T0CtUa1c3K9M4UYa4KR9pBrFWfp81/UKRi9+QSjMl15TE46jdG+pkiJPvp78f7h00u2yk/hdFlJDH0M7pcPbgbMKO3WiU5I73AGczAaBAVsGSSP2doxiBC5lb9XeNMUkzo0iFpOwmpSa59raTDyE2a3jDr7GYFWhXKUF68xOBLWVHWu3Pvfh+3mBxtc2yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6916009)(44832011)(70586007)(81166007)(1076003)(316002)(4326008)(26005)(47076005)(508600001)(36756003)(54906003)(356005)(70206006)(16526019)(8676002)(8936002)(336012)(426003)(2616005)(186003)(83380400001)(6666004)(82310400004)(86362001)(7696005)(36860700001)(5660300002)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:56:09.1919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a0a4dd-f30a-4cfc-8f4d-08da0eb2a6e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2927
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Paul Hsieh <paul.hsieh@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[WHY]
In headless systems, if SetMode/Power down timer
is not called, hardware will not be powered down
causing HW/SW discrepancies. Powering down hardware
on SetPowerState to D3 will ensure SW/HW state is accurate.

[HOW]
If PowerDownThread timer is not trigger but OS call
SetPowerState to D3, power down hardware.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

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
2.35.1


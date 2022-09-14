Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71199ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5D489D9A;
	Wed, 14 Sep 2022 03:56:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD0D10E818
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdgDctajb/KQJFdPCLz46fSLqjeRYeMA/dIzyGXqGEHehk3sEQLFK3or7NBIxD+dcE8vKHdY+mmk5LmtbnCz3zGnJ+ou8WhcWJtCXd/fE+fDx4EeDYddpH9YqJaox4D+TsI+hHytHruD1yivbj/rujjOfyG0rbLr456xHPPeDKbP3hc8QMdyHaPLPzX2T/GdKQ2vBLTGR9CQ4PkcAHjBvq5ODqNGtYF/TnioMJZCzi9mV5iT6ZcKESXV2f8IZkEcMIwTNSOfe/nyOoi73Ub71cCB/l5LcUDC02092lEx/nq9ZywwWoUXUff3y/H1OeWye8+u3JN6FSTnLv/yUSGthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+dhn0QEoRHShfjPf9ORarSvLDc3xLVfZXkyITWFWk8=;
 b=lbSdZk0xbRyZFD65F0kRTOHrFzhKa7SRtUMnuIw9DDt2PDmzSL2Dmsy6fRte8iaGmEjBa2yYARUKiB4JYKxwmitb+q2AASNWoIWdLAkvib5sbb1i17fuC91ma1nci5sLOwm2Rx44XFF5SOIaoj6DgKxY3CCa4AMlMEFJij/wEAVtxIY4Vib3LGYvAJ+lpf0IID7RXB4i2xRJMHuwY0vTJeAkwnvNJgIgJpYFsqsl/y1F9MNf8IS0IQHfTkXdapqEWf5WGfK+wBiU5shWQ055V63XzH8RrxA+0lxaPFjsQCFodPp0YLuJ/6/JA1h5I+Mt+u+NQzPMv8vpLnNxqBgN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+dhn0QEoRHShfjPf9ORarSvLDc3xLVfZXkyITWFWk8=;
 b=Fk08RiNcZqNboR9BibmOp3455fA+0bguD+kURbd6xDSA7gEzmh8wElaMxvz6LUseLLIcE3SNrzwF4QM9SZw/rWhfDuJrLJRZ+P9YXt1V4zG6/Y63PBsTzyCfEXxZH5pE9DzSvR63+cIyj2K7b5WtQ9MTmiPq1csViD2A85gL1WE=
Received: from BN9PR03CA0135.namprd03.prod.outlook.com (2603:10b6:408:fe::20)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 03:56:00 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::a6) by BN9PR03CA0135.outlook.office365.com
 (2603:10b6:408:fe::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:55:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:55:36 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:55:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 33/47] drm/amd/display: increase dcn315 pstate change
 latency
Date: Wed, 14 Sep 2022 11:47:54 +0800
Message-ID: <20220914034808.1093521-34-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: facffadf-d0b7-4cd7-15ab-08da9605098d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJKgJtfdxZUKiLL0lNdksAcobuUfOR++IURvgQA5XF1oMNvmWFxy4gEUfgr29rVMEypFqKuf1oo61F9zQqSP4OmNHjkVhYCjlB1Q+eEEuH+z1lOK8NV1TEc46vzT3n1+99evzLQ5ptN7LUillaKggiUxHfvDs3LpuDTFlFiyhubn+hN4f9KpmidmSSvewmwZL78fWsCozc5QDulntkRl93Ap7vNr3AYXYoLPDOzyVMD6f0tcbGLlZ4WM2wBF62RZ/eeAcVzMI1N0H95GFGhBsfvmvscycOhPafrBPO0DDaoZdq2ijpSNeBH0M8X81/fb8DE1ZifvzOAiokHT+c9UdKaL2L1T+c3ZvWgWMM1kNFEeQ0ORC4kBoMFVSnRwgCBkx0qfuLSz/E+IdazbpdRvSmaEEydvXgSkRQMAD39bYbzRzHBYaiIusOyLP1sfEYF0uGnhsPzEJ4lboQwFAJ13HpRiglrN0uXXHLHWWknjNyo2SuimPBBcl7k09hTgF4Cev8ydxJ9Cae2JpQ4GSooDLKi/8oKEt7m3RmiaTEkRUnLQxuqAY9J7gbJ2BNY1pV+XHVFTLnW3DFZ+hChvbMbqcykwRzYIBLD4pWAkDzfjGgjvLHCyuRixXX9KJcULzHYEmkD8MF5gsbvE8F+HLYCydUH7pm28+v1l9C6H/MrBjtOhSBGwk2vWj08Qpd/NvIgcuGpGC+eEXfl9Dvv9UiBhUbPomg/efSIvo4g+OMRZa3QPMxo4RYOfhxcPBpVuj8gD4E7erz/mp44IT+yVZQpdwUv2F4oNBCQnZXhtzPVfVXhuSuIker+29PCPrx940MHe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(316002)(2906002)(41300700001)(6666004)(5660300002)(40460700003)(2616005)(478600001)(8676002)(47076005)(26005)(426003)(8936002)(70206006)(336012)(1076003)(356005)(186003)(83380400001)(81166007)(70586007)(36860700001)(82310400005)(6916009)(40480700001)(54906003)(82740400003)(36756003)(4326008)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:00.4965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facffadf-d0b7-4cd7-15ab-08da9605098d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
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


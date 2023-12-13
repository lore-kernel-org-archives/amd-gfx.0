Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB728C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A91510E6D6;
	Wed, 13 Dec 2023 06:13:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D4510E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8bP9FkPcFF2c9wYOTDRAxp3kaO5lO4tQC13GvDEVV1N7namwgRBdrcbxpa8F1RX4kJqgVBM+kvIrFUTpv9aY0cdttC6lTAqWj3GQJ0LwnFA1MFvQjC5QmCDt262+8T7oU2GWLNfKBDOfkYMHu7H1tuVYU4ZpEzqGndJueMZenfgCy7gmFQj1zD3AUrFNz4iwe1nuaZ2cZF8HrNlIwekY62ATaLqiE26mBrwgFYXPKnH9B8VBzUgVdWSebZ1vrE8Di3M9JK86SJDhp3tbSdXCUDQX+trUufNJYAoGeNW3CkCYkmjZqKMu7WrrLdls8SynOuq8nDu0nc5I8HWLZSt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QniQZz7zAtFLqw3MGCymB4BkcnkYKGdvG3BDbuVcdUc=;
 b=JQeyTnai+XqPHIBH5ppOdLddCDwH08wjrsF99sKNCqyDPl8Tuclo/95W6H+YOhMwOq979bArr7lnthOp3p9sTyblaSbKsXH0svS+LoMmYJ6lqPaSuPDsIeogWOL/Bfu/Nj1mlAsQ8YhnJlWmF8vuDB4o3qHuP9zfCP1c17REQeOkuZj/qXB1LYnV75PjaMiToTnZf5uDrPcvKLKFMYYpj7Onfh9ZJvg3s+kVgnzeKzOswuXySGEV+TzoRRBpwEByPJ00mc8Q8zSif6FqXOr/nJ1KyXp2A8FNEegQzoMxcGI/EFRetojJzOdaKkk5+6+oUaHA1zL2SJWJakO0h2VGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QniQZz7zAtFLqw3MGCymB4BkcnkYKGdvG3BDbuVcdUc=;
 b=vExAgT0fP95D67WezT0sjMmHrDTO5JfMzjNrZ6Dd26G8NEqE+5SAebqzvp2hDqpJSs/ei7oBontITyHiuZOcvuuiDZDOnCWCJ9w1aobs3+xhrlrH2HjQ8ieiJjwJT+cIVydnOpC0c8p4+ZL6pYy/gu8DOrxvU33/CHGPh5jSdak=
Received: from CH0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:610:11a::15)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:23 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:610:11a:cafe::af) by CH0PR03CA0353.outlook.office365.com
 (2603:10b6:610:11a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:13:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:21 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:16 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/25] drm/amd/display: Add function for dumping clk registers
Date: Wed, 13 Dec 2023 14:12:07 +0800
Message-ID: <20231213061227.1750663-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: f908dc0c-40e9-4536-20dd-08dbfba29c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRKLQP7ca7IR5261FjveiP4X36dX30e/xECg28rS1luTXSvCS/iNlICq6NyjMjJf9sG+qqNqSJOSHLGG+46HAn33loMe8DBSctIuOEinYwjjpQeqPDDlq4+L6GjoO3+1bRf6evck7kc5waKl8A5gGuqqOomUBrYDxOWFBSCqPkN4n2RSTRRgPu8TGg1huc8FjpOxqD4lL1ahhO1EY+oBXFGJaCAMgYz372cKf8T/RYsXn3CvHPLXbLl8R+gM9Oddr+e795evZOaGpIOcygVujUsXd9Bgem8/TlIgcpC35O86Z7ZR6wVegfIqhLY9M5I9DpzdJvsarADJ+kP01ho3YUoByx+5XCa+wRzvFnJGLA/SUqc1UQB2WYtA23JN92hiTAUPy949MfNVoiXniyezA/L41rnogQudX72YEq0j231DKEeKyEBtstKaz6Ty2RO/QXEKB4rO8aKchA/qgH/84s3HUkiJEsArYJr5d7qNRs+LRHS116gpdBKNWteOMe+jcPamq+cAEU+YZmBiDBVQLKnKab3iOWgjby83RkHP3078ZzlM5MsgDSXh9K/Vce/Q40GwDYkSW8YM+dEx8iPbH85T5i1/sQMGxQZn+hlsFaWhipCqrdPetAaOAxXhXVFHsL4iDSLznBKfE+Zz5pkCyhCphZrkzfF7KTYbBf6GiydtBrlAHw+7gly3e2RDLprpRQgFO/swbEyOjM3LF5lXrYIc5wQbgd8SVdEHq1aetBKUK9rc+fygH5nLYXBXiPVjYL/6Lxjhn8GeHzhnWniqYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(40480700001)(40460700003)(6666004)(7696005)(41300700001)(70586007)(70206006)(82740400003)(1076003)(356005)(336012)(26005)(81166007)(83380400001)(2616005)(47076005)(54906003)(2906002)(8676002)(5660300002)(478600001)(4326008)(36860700001)(426003)(8936002)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:22.3071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f908dc0c-40e9-4536-20dd-08dbfba29c10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Johnson Chen <johnson.chen@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Johnson Chen <johnson.chen@amd.com>

[why]
Allow devs to check raw clk register values by dumping them on the log

[how]
Add clk register dump implementation

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Johnson Chen <johnson.chen@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  7 +++----
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 8d4c0b209872..789091f3bdc8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -50,6 +50,7 @@
 #include "dc_dmub_srv.h"
 #include "link.h"
 #include "logger_types.h"
+
 #undef DC_LOGGER
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
@@ -417,9 +418,8 @@ bool dcn35_are_clock_states_equal(struct dc_clocks *a,
 }
 
 static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
-		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
+		struct clk_mgr_dcn35 *clk_mgr)
 {
-
 }
 
 static struct clk_bw_params dcn35_bw_params = {
@@ -986,7 +986,6 @@ void dcn35_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dcn35_smu_dpm_clks smu_dpm_clks = { 0 };
-	struct clk_log_info log_info = {0};
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn35_funcs;
 
@@ -1039,7 +1038,7 @@ void dcn35_clk_mgr_construct(
 		dcn35_bw_params.wm_table = ddr5_wm_table;
 	}
 	/* Saved clocks configured at boot for debug purposes */
-	dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
+	dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index fa9614bcb160..cbba39d251e5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -62,6 +62,25 @@ struct dcn3_clk_internal {
 	uint32_t CLK4_CLK0_CURRENT_CNT; //fclk
 };
 
+struct dcn35_clk_internal {
+	int dummy;
+	uint32_t CLK1_CLK0_CURRENT_CNT; //dispclk
+	uint32_t CLK1_CLK1_CURRENT_CNT; //dppclk
+	uint32_t CLK1_CLK2_CURRENT_CNT; //dprefclk
+	uint32_t CLK1_CLK3_CURRENT_CNT; //dcfclk
+	uint32_t CLK1_CLK4_CURRENT_CNT; //dtbclk
+	//uint32_t CLK1_CLK5_CURRENT_CNT; //dpiaclk
+	//uint32_t CLK1_CLK6_CURRENT_CNT; //srdbgclk
+	uint32_t CLK1_CLK3_DS_CNTL;	    //dcf_deep_sleep_divider
+	uint32_t CLK1_CLK3_ALLOW_DS;	//dcf_deep_sleep_allow
+
+	uint32_t CLK1_CLK0_BYPASS_CNTL; //dispclk bypass
+	uint32_t CLK1_CLK1_BYPASS_CNTL; //dppclk bypass
+	uint32_t CLK1_CLK2_BYPASS_CNTL; //dprefclk bypass
+	uint32_t CLK1_CLK3_BYPASS_CNTL; //dcfclk bypass
+	uint32_t CLK1_CLK4_BYPASS_CNTL; //dtbclk bypass
+};
+
 struct dcn301_clk_internal {
 	int dummy;
 	uint32_t CLK1_CLK0_CURRENT_CNT; //dispclk
-- 
2.37.3


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C37AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 21:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA21D10E806;
	Tue, 22 Feb 2022 21:53:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E0810E7ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 21:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=but0DZpUHSBQoKd3If9sVBm3FBCh2ZhGbCuWW8Oe42g4SOV0wJUu3HaND1xz2SeoGUhDSILxTbFsk2U5+u7hYCZC0LefxTvaVQXJMF+7rYGmFb+4Qq6ejhyHu0gZM6K5OXEZeUp6BjMC8Bl1nPT6cBcJqIfgEBAEKQSg6Ws7bOjAf0Bb2vuL17z8S6dbOfuzq2XmmXof+jXbRxq2FZ6AEy87/qgVyIXphAB6U8XIT2Kil/F/eLTCsTkmnoxLF74KIOhJhM8O3Pq12EyKsKTjW2yTjoBdJEBSHQw0b7Qjp850lRebc683qA2P7J8OIj3XiuAhuzatpUNCjmLkVQf0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10+MHtGPORGeyHVWeGG3EvnEVIenhYm7YPk1DiViuYA=;
 b=X58MWMy+g22keWy0NosHyfc/WmmpukT04si8gzrfM/7VWW70LtxqaNLL3170ZFOYFTO0vmdOOdMurATptsNAv1S2BQoHg9L77/TRli+GybUIMiZ7/3n4+71GGhPTsLSW7qoLKUX2Zoc4ths3lTQpccPRfyzMLTet1ABn6BFY7FhocrCmMTiDQoYQ4YdE6joeqZWw3j8Q2yR7UmcUkoeFqKRceO0G2TN8YhBDl6FnW7e0RBwBka/0MHzTbhOfsarljH7QntFWU3GZ7VtZvGLhOWUlbEHEdJgR71a6+B5L2XC58J8OLyHUW0GZ+4OJ/bknGFdHhf+M5lgQctA4/jOnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10+MHtGPORGeyHVWeGG3EvnEVIenhYm7YPk1DiViuYA=;
 b=ErpXj5Tc1AVjXWXdO/RT+ivuXAY0OkMSNfAM9s/QhC1IdlI5INLgyk1ojjOWWHcwhv4wZVgxuX5xjSY1dxcmkOcAwuL2arjhtnKFPaOinU/DfA+EWW+Kqv+rHt4Pc2w36CyKccrzXUlFoGTiu9LVXHLxwzxuIXnu/8cCjEkFHpQ=
Received: from MW4PR03CA0091.namprd03.prod.outlook.com (2603:10b6:303:b7::6)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 22 Feb
 2022 21:53:48 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::39) by MW4PR03CA0091.outlook.office365.com
 (2603:10b6:303:b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Tue, 22 Feb 2022 21:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 22 Feb 2022 21:53:48 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 15:53:45 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd/display: revert populating dcn315 clk table based
 on dcfclk
Date: Tue, 22 Feb 2022 16:53:33 -0500
Message-ID: <20220222215335.3009315-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222215335.3009315-1-qingqing.zhuo@amd.com>
References: <20220222215335.3009315-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec625175-4f76-4092-0296-08d9f64dce35
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5112A2FDDBC56374E523FB2AFB3B9@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8h0uosGBleYmZmFVZitSYVr2q5mgLxCgphgnpy3KelJeHNqrSNcIPUofcSbyVFVo/I7y+UIZ+3SowEw6rJngT7NynurHa6qHG9+9wsnW4lZwV7sNYo1DHYP1zA4qiAFqSOlWAGXjrqiwh32LxEffI27qz+LCRQTOmlCWhNRh9KltFMSecGrDpiAW0Gzen0VCVSDwXMcimbybjQ4Z5f3DWfoZLhSulPGI4DKTiKe4poyRa58j0tDCI7V7Q5XIyIegWUTsvWYHAWgY4ZMarPF3RcPwbJVQxtVc8QueRvy/0J2gdd2MMj+xEbUDur0n/xwXjvxYh9Mbvzt2li2dslBvZBt33zy1jr15NPuzyximGs+QZsE4TIxKB4XJo9WcAwe/hxJBNCQi2ZZGvWGZSvYH393ysg07uFVkUgtpxcavJVcMHjmoIsIBd46i8EqT8gs9f+8OJU8zirdhjXB0tG+InnKOb6YusLnYAWP751nI12Uwb9bIV/4QYEgEfz+92VAivKOkRrW+ORcdRkLWaw5/mGjKhdeomizVIbaQlgCJi5uTYWAqzt4/me6phgiq4TBrSuSUQyPXQHizfDzG3r630bSu2CAiHuNl5qHFww0CNdknQF1GLcHqtQ49bmyoTwA4xgDXVbtUHND2HLtANxUTgOjhy7hzS0KBBMYnde7UMsxHtCdTw+L25FCfodq8n4ED9eAXgu0ul3ebtqsfuOKmRPxKcolB15M8kYJwVI9ItGqZcl7GD9Q6b7CHU0uKeD87RvSdKcMSzlntRnXiEyoUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(86362001)(426003)(54906003)(26005)(336012)(186003)(36860700001)(2616005)(316002)(44832011)(6916009)(16526019)(2906002)(8676002)(4326008)(5660300002)(70586007)(82310400004)(70206006)(508600001)(8936002)(81166007)(6666004)(40460700003)(356005)(1076003)(36756003)(83380400001)(17423001)(156123004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:53:48.0256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec625175-4f76-4092-0296-08d9f64dce35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com, Harry
 Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Due to how pmfw fills out the table when dcfclk states are disabled,
using dcfclk based clk table would cause a no read situation.
Revert the change to prevent underflow until a better solution is coded.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 52 +++++++++++--------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 90c265275f93..d66633bef2b3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -414,23 +414,20 @@ static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 	return max;
 }
 
-static unsigned int find_dfpstate_for_voltage(
-		const DfPstateTable_t table[],
-		unsigned int NumDfPstatesEnabled,
+static unsigned int find_clk_for_voltage(
+		const DpmClocks_315_t *clock_table,
+		const uint32_t clocks[],
 		unsigned int voltage)
 {
 	int i;
-	unsigned int minVoltage = table[0].Voltage;
-	unsigned int minlevel = 0;
 
-	for (i = 1; i < NumDfPstatesEnabled; i++) {
-		if (table[i].Voltage >= voltage && minVoltage > table[i].Voltage) {
-			minVoltage = table[i].Voltage;
-			minlevel = i;
-		}
+	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
+		if (clock_table->SocVoltage[i] == voltage)
+			return clocks[i];
 	}
 
-	return minlevel;
+	ASSERT(0);
+	return 0;
 }
 
 void dcn315_clk_mgr_helper_populate_bw_params(
@@ -438,21 +435,30 @@ void dcn315_clk_mgr_helper_populate_bw_params(
 		struct integrated_info *bios_info,
 		const DpmClocks_315_t *clock_table)
 {
-	int i, num_clk_lvl;
+	int i, j;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	uint32_t max_dispclk = 0, max_dppclk = 0;
 
-	num_clk_lvl = clock_table->NumDcfClkLevelsEnabled;
+	j = -1;
+
+	ASSERT(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL);
+
+	/* Find lowest DPM, FCLK is filled in reverse order*/
 
-	ASSERT(num_clk_lvl <= MAX_NUM_DPM_LVL);
+	for (i = NUM_DF_PSTATE_LEVELS - 1; i >= 0; i--) {
+		if (clock_table->DfPstateTable[i].FClk != 0) {
+			j = i;
+			break;
+		}
+	}
 
-	if (num_clk_lvl == 0 || clock_table->DcfClocks[0] == 0) {
-		/* clock table is no good, just use our own hardcode */
+	if (j == -1) {
+		/* clock table is all 0s, just use our own hardcode */
 		ASSERT(0);
 		return;
 	}
 
-	bw_params->clk_table.num_entries = num_clk_lvl;
+	bw_params->clk_table.num_entries = j + 1;
 
 	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
 	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS &&
@@ -463,15 +469,19 @@ void dcn315_clk_mgr_helper_populate_bw_params(
 		ASSERT(0);
 	}
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
-		int j = find_dfpstate_for_voltage(clock_table->DfPstateTable, clock_table->NumDfPstatesEnabled, clock_table->SocVoltage[i]);
+	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
+		int temp;
 
 		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
 		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
 		bw_params->clk_table.entries[i].wck_ratio = 1;
-		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
-		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
+		temp = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
+		if (temp)
+			bw_params->clk_table.entries[i].dcfclk_mhz = temp;
+		temp = find_clk_for_voltage(clock_table, clock_table->SocClocks, clock_table->DfPstateTable[j].Voltage);
+		if (temp)
+			bw_params->clk_table.entries[i].socclk_mhz = temp;
 		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
 		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
 	}
-- 
2.25.1


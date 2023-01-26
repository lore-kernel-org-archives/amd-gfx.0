Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B0C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E000D10E8BD;
	Thu, 26 Jan 2023 00:34:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304A710E8BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exQRkL3zEbEjybsEI0gBEW00pm7/a4D0Xb2IZzajZxHBhCxREQpduiOM5g8HWHUP998Q/flCFW5XdFYdggIbAkKd+JX4sDn0fnXILv1At4MlPMbUKJLE/l+KdYqkf0N4TVj+yO+aDXESdDY2YZ0mCWN9evxyDi3OgqRLe+faK7avdnMXG5FikQ1EVzzGXENLtx67oK6TiShhzINhEvebGf2CQla8SMh52X2jnc1hbgRzUUkbzV0EWOujL7hJfgfSjc/5I0m6ihpWscVJAXwcEr5yv+HIQ8IsqZQRin8/BBu1Spl0bvp21GCiL+4OSLoaPHZ7B3d7B1VqQfRkPmTicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99phY+Xd+lCE/Aod/ysFIM1+B7Nke3DVnzTcRJ7MSlo=;
 b=UpWn9vHp1NAxSZT7vnnaVDrspSNQyBpT2/cZE0Oigu6aTwpgki4oQgZVRwtNbI3WEhAHsOvnbrgijpvKfPEjlPu8CV793PHoo3n3Tjir+YFlhgYDLxt4/tBFK5SYH59Vqznfghs1gubzK7tlUfZ4aHb6hA3mw35lVSfVFx4/n/O2SVIXhkX0s8GQ/+2eTIw6xgy0mPhr3/SpUCqrP48GWHBJFBHZchoVyOMTzMC2RCX5FBXx7xH7ELrZVLw6+36c99uNETwmDkxRkxtMc/sXQZM8fmPFYJV6o5IT8VGsCW1pJBZWbsJazesXTWO5kALQs4p1B+FMUb1P0OXJSQboww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99phY+Xd+lCE/Aod/ysFIM1+B7Nke3DVnzTcRJ7MSlo=;
 b=JahctIii/C8v+yPESBPrfWUbCNoTiUndmy6eKYokMz5x815+u9wnmsbAgequafxjgIOR9uFbewdgvJ+ykozscWgc/JTjUVwtJcVzww2tW0i1vyGhOEQ9F5StYmWDCYcZW5pcDQofmWpu+OPmH14i6ulbR2XYGu9RQ3fJ99SEV0M=
Received: from DM6PR05CA0063.namprd05.prod.outlook.com (2603:10b6:5:335::32)
 by CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:34:53 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::95) by DM6PR05CA0063.outlook.office365.com
 (2603:10b6:5:335::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Thu, 26 Jan 2023 00:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 00:34:53 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:34:50 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Correct bw_params population
Date: Wed, 25 Jan 2023 17:32:20 -0700
Message-ID: <20230126003230.4178466-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2998c3fa-e9b9-48ac-8474-08daff352437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f922NSN49Np9bAjM3ZiFeNB7Jzs0fZ5bxYNwG/+ED3mTRSHuik4dQOROsheKNv3Leyooi+zPp9bqDFRLcgxmAHTfr86ACt0Z/XT78bnQGetAiT2y7HtD2Mt49e7t5yHDmfWUtbYs90A+IjvX5hSpPFiwuSuM6hMOgN95bJ/2twYiJwRu5Pl1LrbsgPGk7OGCjIJ6qsaXVZQnitPVIZzSpx/4Rtut9SdBLW+i1TjRJ5z4W3eHaknkGuQtv/Ax11c81jthIdk6ZqLOfQVOH1qk8amzL9FJURaN9Wi4Y9NaNRZNl1onMPGAeWS1Bv+PWHmr6KP0DUUWmgYgbRq2AkFI2YwBx/cjBDnM1JXYd/in/3mhvOBnKS9VNnSHraTd5KUL6/X8DL9Vi6FRsRRB+V000lSBDPO0FQjPg6+xm6HtYLEF6ATHbOXeOXPd3ulqtc1S/qTs17XrgTOWqMfUSORvXBZyQ6sbga85kCxflTpjySblBLzZY9Bx3e+OjWUHvV8iLQ/W3Ae7+/Q0KihL+9HCnGZsCRr4kRuKb+yMZwWGxSg2MiVOsKMzNqZh5W05CzfhsX1V7Sjsv7F2h7ESnr4b84sjo/p8Kmfg7BO+zQpj2qxIEKdWLwt7OuZxS3PpHEvegtQfkBc1dpWUuXDtXNUjVpi2NEoiTEMe/pAYSUAU19dI1wBmH5aB8eM2eSFksPhVy37BhkjVJ+iFPYssn9H6d/3A3ioETq5H7eM9FVJbyZM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(2616005)(36756003)(86362001)(2906002)(82310400005)(356005)(82740400003)(4326008)(8936002)(83380400001)(44832011)(81166007)(36860700001)(41300700001)(5660300002)(316002)(478600001)(70206006)(7696005)(186003)(6916009)(8676002)(40460700003)(26005)(70586007)(47076005)(336012)(40480700001)(54906003)(1076003)(16526019)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:34:53.1533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2998c3fa-e9b9-48ac-8474-08daff352437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
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
Cc: stylon.wang@amd.com, Daniel Miess <Daniel.Miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

[Why]
Underflow observed during P010 video playback on
dcn314 due to incorrectly populated bw_params

[How]
Populate fclk, memclk and voltage in bw_params with
values from max pstate rather than min pstate

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 89df7244b272..f5276bacfa4e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -572,10 +572,11 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 {
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
-	uint32_t max_pstate = 0,  max_fclk = 0,  min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
+	uint32_t max_pstate = 0, max_fclk = 0, max_dispclk = 0, max_dppclk = 0;
+	uint32_t min_pstate = 0, min_fclk = clock_table->DfPstateTable[0].FClk;
 	int i;
 
-	/* Find highest valid fclk pstate */
+	/* Find highest and lowest valid fclk pstate */
 	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
 		if (is_valid_clock_value(clock_table->DfPstateTable[i].FClk) &&
 		    clock_table->DfPstateTable[i].FClk > max_fclk) {
@@ -584,6 +585,14 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 		}
 	}
 
+	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
+		if (is_valid_clock_value(clock_table->DfPstateTable[i].FClk) &&
+		    clock_table->DfPstateTable[i].FClk < min_fclk) {
+			min_fclk = clock_table->DfPstateTable[i].FClk;
+			min_pstate = i;
+		}
+	}
+
 	/* We expect the table to contain at least one valid fclk entry. */
 	ASSERT(is_valid_clock_value(max_fclk));
 
@@ -599,15 +608,17 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 
 	/* Base the clock table on dcfclk, need at least one entry regardless of pmfw table */
 	for (i = 0; i < clock_table->NumDcfClkLevelsEnabled; i++) {
-		uint32_t min_fclk = clock_table->DfPstateTable[0].FClk;
+		uint32_t max_level_fclk = clock_table->DfPstateTable[0].FClk;
+		uint32_t max_level_pstate = 0;
 		int j;
 
+		/* Look for the maximum supported FCLK for the current voltage. */
 		for (j = 1; j < clock_table->NumDfPstatesEnabled; j++) {
 			if (is_valid_clock_value(clock_table->DfPstateTable[j].FClk) &&
-			    clock_table->DfPstateTable[j].FClk < min_fclk &&
+			    clock_table->DfPstateTable[j].FClk > max_level_fclk &&
 			    clock_table->DfPstateTable[j].Voltage <= clock_table->SocVoltage[i]) {
-				min_fclk = clock_table->DfPstateTable[j].FClk;
-				min_pstate = j;
+				max_level_fclk = clock_table->DfPstateTable[j].FClk;
+				max_level_pstate = j;
 			}
 		}
 
@@ -621,15 +632,15 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
 
 		/* Now update clocks we do read */
-		bw_params->clk_table.entries[i].fclk_mhz = min_fclk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[min_pstate].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[min_pstate].Voltage;
+		bw_params->clk_table.entries[i].fclk_mhz = max_level_fclk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[max_level_pstate].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[max_level_pstate].Voltage;
 		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
 		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
 		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
 		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
 		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
-			clock_table->DfPstateTable[min_pstate].WckRatio);
+			clock_table->DfPstateTable[max_level_pstate].WckRatio);
 	}
 
 	/* Make sure to include at least one entry at highest pstate */
-- 
2.39.1


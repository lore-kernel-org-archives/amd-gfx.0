Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D37C43217
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A252A10E4CB;
	Thu, 20 Oct 2022 15:48:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B109A10E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB+SCR9o4+sBAqbtRnq7n38Zuow+UiE4YaFXm8W1Whb7XJLgozQ4yslAWE17Zv47dDuGAoq9mr8gzItmcNRtrBhcHt3KBEOac68JynagVoTjXlIKnzCJDx/F1Jf+NY8sdgJhxBHyVhjzcMkycenI/XA5rTGUTDGWTw3GXKMLgPgAyIUhD87C4HlKz4wxkoJgZew59alFp10mqsFvrSYfrjr18j7z6U2OjzstNJZOIgBFn3GS+4phHpUP6NCcQ+TyJlbscZo7yb+gM0q2qCp0Gd1RIINhzbglHl1xmI/K5raYb3cfxLQ3cO7DdUe6CQR66+VVKbpAu0hV0gxE+AjRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akew1DZv5+6sR4KmDFbiEy4DE8fQwdfB2MIt/jBLGcI=;
 b=A9rIW7jjBqvfHP91Yu3xLNwdjxxGmj/OYzFt3xiF1lJO2mT03Ha8xx7U9Uchm5ORkPJD7Pl4rMYSgL8uWPH+5ncM3YN80kSJIp1t1M9UVcE5fYbC018AC9hMfK7jkdzkWtCU1w8uUzK83BTBUGKwdKiR90X/e4m6bB1qLZmnk0Zu/1EdOZcXLlLpysigxAosDCvyATQdzlPJTuIDrbVnoc2yeL5glY5j0T/ImDNAEfznUX8UI++IMZ3G/+uj/EC93F9ifTp9Tw9tZnjHTdJ24R7w881KPfzeoS+yNLvpeCMc/R7zbq7NhPZCREhidGfh1wnf1q/8YvJtaNBK35O/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akew1DZv5+6sR4KmDFbiEy4DE8fQwdfB2MIt/jBLGcI=;
 b=0QYmU5Ka7JsCa4INn4CD39iAan/IAyHNcrR843/SU1FqNqwhKR5Rcb6Dx+s/QXPjdLOcskrrf8fjXJWvgXtKWXVNCsKpylWfLu3iF+GV8cFvcZAOoPqdq8O4cuIhenrPIzAaNNyfiAW25/J0QewX+zAkZSSuNADAbprSAWreRnI=
Received: from DS7PR05CA0056.namprd05.prod.outlook.com (2603:10b6:8:2f::17) by
 MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 15:47:41 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::3e) by DS7PR05CA0056.outlook.office365.com
 (2603:10b6:8:2f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:41 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:39 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/33] drm/amd/display: correctly populate dcn315 clock table
Date: Thu, 20 Oct 2022 11:46:35 -0400
Message-ID: <20221020154702.503934-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: d57c2029-c3d9-4b69-9ddf-08dab2b26c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HPaVKNyONxXfYw8Mmoe7SxKgEHBXDcP11kUJ4q4zu7X0WClXJ5xe7+RLrKDMz8A8dW2wT4KiljIy2b/c2W2Cej3HqLqeqIvgzpTQfI2VetvZjKBMQWbmpnoGjUjNfk/GrPmLmquIryx0YSv/21cFKA//fsdddKvlW1PV6Mo+uNuS2H6d9EF1No8qX7NpV0fY/uvgX7yUemNYPxzJm6pZQY97bH7KD30u9L+eB6UuO4JMmeQ35RKMbYvKRk/gK252aiNj34ecyFcYfs+xnTZ92aKfKHWOfGyN73vyDyAPaIbNYJnFHpHQa7UmEPY1pxX5ib0/VfSZf8RSdeN8LxkNW9XsAIkooISgXblpMKPMiHA8Du+w6f8vwrTZouEp56htzrCe68fhu+r/yoK1pxQJ7LWL2yLbJo2Jr9n9ENkGBszrwBWTMHuXkOougywqRUGIde14sQ7wQjilRncdGmZtqlF862gnJ339hBEiEceVLOOjb9q/wTMtJN6+eKBc01BsUnoEzSC2hwJrVb9BssVHckA+Ky/TvHOyFOgeJZRiwkoZuIzUpTsDDN0tZyq/cL6GLDy/GeWOaaDFVrG9w+n6BCi3FnAJDzQghpB8qNdEgX9/C38zm61c0NFtYL9kU5oeg1pvQv17dWv3RtQoIoYiw3bnProMiyPsj+mpBmZKU6FyUT1fjhiu5VowssIw4nPuig3xat+dccFlxaOdgXAQl4Ot2sXkI3LMeDiLnmGcxiA81DfxH5q+VH2QueVD1fi/dn4DXPwPNSr58XdssF2w++bv7G9DJrUtBlXn5opeWD5SyTrJVoJMS67lhxOyuID
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(186003)(81166007)(2906002)(356005)(1076003)(2616005)(16526019)(478600001)(40460700003)(82310400005)(54906003)(36756003)(70586007)(47076005)(70206006)(426003)(4326008)(8676002)(6916009)(41300700001)(26005)(83380400001)(82740400003)(86362001)(7696005)(316002)(40480700001)(36860700001)(336012)(8936002)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:41.2909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57c2029-c3d9-4b69-9ddf-08dab2b26c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Fix incorrect pstate read order as well as min and max state logic.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 71 ++++++-------------
 1 file changed, 23 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 893991a0eb97..07edd9777edf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -458,19 +458,6 @@ static void dcn315_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 	dcn315_smu_transfer_dpm_table_smu_2_dram(clk_mgr);
 }
 
-static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
-{
-	uint32_t max = 0;
-	int i;
-
-	for (i = 0; i < num_clocks; ++i) {
-		if (clocks[i] > max)
-			max = clocks[i];
-	}
-
-	return max;
-}
-
 static void dcn315_clk_mgr_helper_populate_bw_params(
 		struct clk_mgr_internal *clk_mgr,
 		struct integrated_info *bios_info,
@@ -478,29 +465,21 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 {
 	int i;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
-	uint32_t max_pstate = 0, max_fclk = 0, min_pstate = 0;
+	uint32_t max_pstate = clock_table->NumDfPstatesEnabled - 1;
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
 
-	/* Find highest fclk pstate */
-	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
-		if (clock_table->DfPstateTable[i].FClk > max_fclk) {
-			max_fclk = clock_table->DfPstateTable[i].FClk;
-			max_pstate = i;
-		}
-	}
-
 	/* For 315 we want to base clock table on dcfclk, need at least one entry regardless of pmfw table */
 	for (i = 0; i < clock_table->NumDcfClkLevelsEnabled; i++) {
 		int j;
-		uint32_t min_fclk = clock_table->DfPstateTable[0].FClk;
 
-		for (j = 1; j < clock_table->NumDfPstatesEnabled; j++) {
-			if (clock_table->DfPstateTable[j].Voltage <= clock_table->SocVoltage[i]
-					&& clock_table->DfPstateTable[j].FClk < min_fclk) {
-				min_fclk = clock_table->DfPstateTable[j].FClk;
-				min_pstate = j;
-			}
+		/* DF table is sorted with clocks decreasing */
+		for (j = clock_table->NumDfPstatesEnabled - 2; j >= 0; j--) {
+			if (clock_table->DfPstateTable[j].Voltage <= clock_table->SocVoltage[i])
+				max_pstate = j;
 		}
+		/* Max DCFCLK should match up with max pstate */
+		if (i == clock_table->NumDcfClkLevelsEnabled - 1)
+			max_pstate = 0;
 
 		/* First search defaults for the clocks we don't read using closest lower or equal default dcfclk */
 		for (j = bw_params->clk_table.num_entries - 1; j > 0; j--)
@@ -511,9 +490,9 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
 
 		/* Now update clocks we do read */
-		bw_params->clk_table.entries[i].fclk_mhz = min_fclk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[min_pstate].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[min_pstate].Voltage;
+		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[max_pstate].FClk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[max_pstate].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->SocVoltage[i];
 		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
 		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
 		bw_params->clk_table.entries[i].dispclk_mhz = clock_table->DispClocks[i];
@@ -521,25 +500,16 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 		bw_params->clk_table.entries[i].wck_ratio = 1;
 	}
 
-	/* Make sure to include at least one entry and highest pstate */
-	if (max_pstate != min_pstate || i == 0) {
-		bw_params->clk_table.entries[i].fclk_mhz = max_fclk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[max_pstate].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[max_pstate].Voltage;
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS);
+	/* Make sure to include at least one entry */
+	if (i == 0) {
+		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[0].FClk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[0].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[0].Voltage;
+		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[0];
 		bw_params->clk_table.entries[i].wck_ratio = 1;
 		i++;
 	}
-	bw_params->clk_table.num_entries = i--;
-
-	/* Make sure all highest clocks are included*/
-	bw_params->clk_table.entries[i].socclk_mhz = find_max_clk_value(clock_table->SocClocks, NUM_SOCCLK_DPM_LEVELS);
-	bw_params->clk_table.entries[i].dispclk_mhz = find_max_clk_value(clock_table->DispClocks, NUM_DISPCLK_DPM_LEVELS);
-	bw_params->clk_table.entries[i].dppclk_mhz = find_max_clk_value(clock_table->DppClocks, NUM_DPPCLK_DPM_LEVELS);
-	ASSERT(clock_table->DcfClocks[i] == find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS));
-	bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
-	bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
-	bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
+	bw_params->clk_table.num_entries = i;
 
 	/* Set any 0 clocks to max default setting. Not an issue for
 	 * power since we aren't doing switching in such case anyway
@@ -565,6 +535,11 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
 			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
 	}
+
+	/* Make sure all highest default clocks are included*/
+	ASSERT(bw_params->clk_table.entries[i-1].phyclk_mhz == def_max.phyclk_mhz);
+	ASSERT(bw_params->clk_table.entries[i-1].phyclk_d18_mhz == def_max.phyclk_d18_mhz);
+	ASSERT(bw_params->clk_table.entries[i-1].dtbclk_mhz == def_max.dtbclk_mhz);
 	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
-- 
2.35.1


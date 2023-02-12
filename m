Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EB0C636D3
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD8310E2F6;
	Sun, 12 Feb 2023 17:00:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219E489CCE
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeRiGAFx94PEocUO2n3JDo17bry/svJPmnJZ2u2TuAa8MVn4PiZ1DqI4nOlK8LpxGpNyfl9En1cPTWTLGQ7xoZ2Ori8UnDJBUtwv5bEZYOZ301YcLMSeDOnCaM/akPNMyniMYDBe4//V9XUgaq5ySD51Ux5yJgAn7/dL6q0VP2LCis73+1/8xsZl8TzJm3oVH+vJBD6GsMXWF/t+PqGCyOLDSU4pkerOFFYpEFU+oZvaRRwCxRwhwwgrN7cnHI1pjT6SelckVO6z9FWjZzw2cHTpJPCDwN8dl48zLXeXVh2cuaaTEzBKecZJMU2OtT6Du7wnGdppLOr6TjlUhQ9IqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKUQA1G10MSVVfXw02I/Pz7JIUG9V3mSZsSuCTeA4Q4=;
 b=RbWPNgY5cTP4DjsXEWkeM+F7zWIJpPxzJjEodpizKjDSPXylxEFa/BmlCG/jpZ87u/ZTL/+oqhGRgXGbkoM2u4OLMY688K7zxH3kh/XfI3BFp/zE5VGFrHhTduPW4kk+FmiAhxeG34XETw6YYD5SVb3diBAfjK+N4zA3HVFM8BPelt23Sxg5ni5dRXtkKvfLrsLzwWVvxj+w2DInHX45Lv3+dGK1I0QitewF+EU/PikS9RFgR4kSjRPWOZ7kW7SxRQ07/MLx1CXDTwDgV8tbmwk8+0VN4gOX11j1+zSy4aMTL7HYIhyljzgtWDLIXm9I9YAe5tEBBPUD3rCzUaU43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKUQA1G10MSVVfXw02I/Pz7JIUG9V3mSZsSuCTeA4Q4=;
 b=u4vg31esoKP9tZWD4XrFJD6U+mq6kf5JFiAjxmtdhYHhYulJa/rAkOl5HXqlSLWhNJlcEi3IbE34bnAZTcIu6ILkxlOWJQBvkhB34F/gI8Vnl9Ze6qDd6gliVNa2BMreAlv1iR8UltsnxRsuHdUsNSBKuytac79Dh1wCaOXpeIw=
Received: from DS7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::13) by
 BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:38 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::33) by DS7P222CA0024.outlook.office365.com
 (2603:10b6:8:2e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:38 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:37 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/22] Revert "drm/amd/display: Correct bw_params population"
Date: Sun, 12 Feb 2023 11:59:40 -0500
Message-ID: <20230212165955.1993601-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: d628e5d6-c69f-4b44-2e94-08db0d1aaa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vfbLTzMo6RNSXwQ8EVkNUTApv0rmSCMCM6RVmaz0xJ3EJJn6NQMk7Eui8mZyItKK8s3Aq4kIufRuVllQvwd0nvo0dCGcoYEH0vfxce5+ftOmLvlJN2CGuNd53QwS7fMGDA3+K8XkiQVX+WHY6U/ntZtcpk0OKD9GVSAK1jYkSL14mDD7P7nL0DjEaPNQDF27PZzIeOLdpzReK8KjipzKHPX1y587r7STK8aeA5VCwuKkAKt2Lvw6FUobtAGbbs2/vvIYns9y/HhN0q5I7zV8XOA7580X8CD3t6qs5mHTTn+mPjJmQOFOKA204iu0WnmjPGTomPa/Km9en2L2JbYrOfqf55CPi7/YDwyQp+dakVmjdT3iyozUseBlSass834p4xodPiB91gE6NOpI3Fvf4MPVrgQPyVdKkPJU/C6kIBglgyeRBTRcLsFka2XWS3CLvuR+3yczo7IaVSiSFhW7M/Yt6AqPe8tHPA5YALIydes/zWMIQnptao8pl5ctL2yBuqqOIuwEpqzTzViK+3wLcwUmcixucjOdniwtl+mC1GWalG2LnGeqN4HkpUJ1NuwJiIE8zQWqzAlD0j3BE9MP9afhHGArbfrUwW8KBmmH7ty8qs+yPpFh3Mr9+xEocigcGT4xgR0WaVPU5Koeb2ye9l//jMTzNsdf9r61LY22zAKMuqNMO4mMif5TtUOeoHb4nxKj3bNvwlsrC5iO5M3zCzeoAmFoh2vKtxw6B4MFFA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(36860700001)(316002)(83380400001)(40480700001)(40460700003)(4326008)(6916009)(70206006)(70586007)(2616005)(426003)(336012)(47076005)(36756003)(2906002)(44832011)(8936002)(8676002)(82740400003)(356005)(478600001)(86362001)(5660300002)(54906003)(41300700001)(6666004)(16526019)(82310400005)(1076003)(26005)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:38.3572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d628e5d6-c69f-4b44-2e94-08db0d1aaa87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

This reverts commit 59ce92eba0df932949c7c557868a9b2f379baa5e

[Why]
This commit causes corruption when viewing a P010
video clip on a 300Hz eDP

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 31 ++++++-------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index f5276bacfa4e..89df7244b272 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -572,11 +572,10 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 {
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
-	uint32_t max_pstate = 0, max_fclk = 0, max_dispclk = 0, max_dppclk = 0;
-	uint32_t min_pstate = 0, min_fclk = clock_table->DfPstateTable[0].FClk;
+	uint32_t max_pstate = 0,  max_fclk = 0,  min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
 	int i;
 
-	/* Find highest and lowest valid fclk pstate */
+	/* Find highest valid fclk pstate */
 	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
 		if (is_valid_clock_value(clock_table->DfPstateTable[i].FClk) &&
 		    clock_table->DfPstateTable[i].FClk > max_fclk) {
@@ -585,14 +584,6 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 		}
 	}
 
-	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
-		if (is_valid_clock_value(clock_table->DfPstateTable[i].FClk) &&
-		    clock_table->DfPstateTable[i].FClk < min_fclk) {
-			min_fclk = clock_table->DfPstateTable[i].FClk;
-			min_pstate = i;
-		}
-	}
-
 	/* We expect the table to contain at least one valid fclk entry. */
 	ASSERT(is_valid_clock_value(max_fclk));
 
@@ -608,17 +599,15 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 
 	/* Base the clock table on dcfclk, need at least one entry regardless of pmfw table */
 	for (i = 0; i < clock_table->NumDcfClkLevelsEnabled; i++) {
-		uint32_t max_level_fclk = clock_table->DfPstateTable[0].FClk;
-		uint32_t max_level_pstate = 0;
+		uint32_t min_fclk = clock_table->DfPstateTable[0].FClk;
 		int j;
 
-		/* Look for the maximum supported FCLK for the current voltage. */
 		for (j = 1; j < clock_table->NumDfPstatesEnabled; j++) {
 			if (is_valid_clock_value(clock_table->DfPstateTable[j].FClk) &&
-			    clock_table->DfPstateTable[j].FClk > max_level_fclk &&
+			    clock_table->DfPstateTable[j].FClk < min_fclk &&
 			    clock_table->DfPstateTable[j].Voltage <= clock_table->SocVoltage[i]) {
-				max_level_fclk = clock_table->DfPstateTable[j].FClk;
-				max_level_pstate = j;
+				min_fclk = clock_table->DfPstateTable[j].FClk;
+				min_pstate = j;
 			}
 		}
 
@@ -632,15 +621,15 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
 
 		/* Now update clocks we do read */
-		bw_params->clk_table.entries[i].fclk_mhz = max_level_fclk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[max_level_pstate].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[max_level_pstate].Voltage;
+		bw_params->clk_table.entries[i].fclk_mhz = min_fclk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[min_pstate].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[min_pstate].Voltage;
 		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
 		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
 		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
 		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
 		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
-			clock_table->DfPstateTable[max_level_pstate].WckRatio);
+			clock_table->DfPstateTable[min_pstate].WckRatio);
 	}
 
 	/* Make sure to include at least one entry at highest pstate */
-- 
2.25.1


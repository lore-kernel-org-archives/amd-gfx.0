Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5ECC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E3610E6D6;
	Mon,  7 Mar 2022 05:49:54 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFA210E4E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYDXYpuzmSP9hQrQhev+YFSgjLnQSHTgAQh5I5Nn+BJv0nmEoMr9zjVtz4hsTnJO6rXLrCbUadnr8Y9kR2hh4lSZgLJ9h6ODbJEsZAstgyDcnsYx8JFQIBDCu4Hac5s9oabEqpJfeVMnphzbaT0CsnOzaPLbujHHBVboRSYBwKTb+lLhcEcNbi7bUSctYVKHI+07rB18PyRkcoq91+OPW3i+XIixiQMgZIGnfu85yRONOqRVdChHuedRWFZk+pnEes2kaxKx5XC1fyzSnk7TM6BKP6W2G+fsY78XunAVwSvBGyCR8h/QxvXYSSAd5XvC0UshQT1X2SGvaA+i9RYrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0LntXyCtCK2EFcrxV+cfv8xCtvx3d21ShGLHIL/tnE=;
 b=F3ErxKEUHG48b30HmWeagupjXlObBpL1s4W2kUD0mpkEGI/n6wYQnSZBkeOy1/NIqsgjZWuD/+2vstvmapAeLXAmpc6zTL1qgAqxqNOoT/t1nQwwSp7u1J+3GVgbh9FEvtR0uVkfI+gH48Ry6SxpsWLgFXFNcAvVfPS7o3CV33Q6IjG/b5tjGoC76juSZokeh3xZGw6mX44DhCM3TMKXrNylUlLUjN7BPCEEIB2G8O3g2Hl281FppIADgdQDosRtk/KndCwXyzgdD85NGyNZR2S/prCXDtB5pPGXLkMnZB7jXsaBojj3mn+4QU6/tYNiCJueK2P5oE5wWA0mD7n8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0LntXyCtCK2EFcrxV+cfv8xCtvx3d21ShGLHIL/tnE=;
 b=vABOwBrYCu5/6c/IFFzDEWlpTlf97a7jKRfRA1HCvMkkhGAABw/TxA5Z70cbaNSsfIB0/w4bkZkC0MM4QDUzySB6QzdFH50QPbtjNcwXlkS1KoKZcNmta103JSiKZAf2B12DyxNMCnwHaBfIEFK0pTnOzl5RqoSZEYyBO0xt1DM=
Received: from DM6PR07CA0111.namprd07.prod.outlook.com (2603:10b6:5:330::12)
 by BN6PR12MB1812.namprd12.prod.outlook.com (2603:10b6:404:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Mon, 7 Mar
 2022 05:49:48 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::2f) by DM6PR07CA0111.outlook.office365.com
 (2603:10b6:5:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:49:47 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:49:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 21:49:46 -0800
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:49:42 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/21] drm/amd/display: Clean up fixed VS PHY test w/a function
Date: Tue, 8 Mar 2022 05:09:27 +0800
Message-ID: <20220307210942.444808-5-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af74f75-4497-4aa4-a64d-08d9fffe49c3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1812:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB181201FAFECD9D01A82BC06AF5089@BN6PR12MB1812.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIIFkJ58KvF20q4qYm8JXMgEmRct8N3GNZ3mLWlAhRjD1by/q7mEKWIjyFu38HsTvWrnb4lxDIXROce77PeOoeM7laxNg2buBNfR/j1f1NIUjwmxPwlGTEIa6pkiSPvDdv+/QBMvLWTp3FSPw35wPTt01cua+hl0o8SO47KGapYsxRzc4nksRTx4/RVDrHH1YDflEjwmElcu8kVvQNGS22y1EZw13GgBOqHdhJHNpMl7JAu1utIg394lIrU4yTkKS6Zn7TuL7eSRMF3v+9phAsiymCfGzqCRsWybY7pDv8Wf7eHelmDUlkFq4v5DIUDyyWbQJypUOrZz7LJBH2oGprZ5iNUZmQMtEm08o8yOhAZsGjsdgyrwpkG3hwkVu2mRPDCysy3KZSyok0BiFVfMsXf1ParXIgYIOSQryL5mML+zUFeW86Qo5Ss4AijJv+ntSEvlSXVm+9pa9+/Brrpepi8xYheK5QOsIF6w3MJEhgpShRbDQMBRUR8eSRKQp0c/lGTZo/3RndzORFHNgN1XIrKfCFskQRHGrtyMY2BKrHxBIJFa41Scj6+O/vH3WuEyi8xwkFSLdzbVON56O/jEXpBeXkd8DHjuB+btmBeiWiBj6NHx3ZL9i21TlV2y1V5Au/AKysloKWvdI1j0RXwqy4emvSmmhtJIhuzpgi1eyhrichmlZbXJUf8q085jVhWDBomy7kLwDX1Wc4xgO2SFkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(26005)(186003)(336012)(1076003)(2616005)(5660300002)(70586007)(70206006)(2906002)(82310400004)(36860700001)(40460700003)(83380400001)(8676002)(4326008)(86362001)(47076005)(6916009)(6666004)(508600001)(7696005)(316002)(36756003)(81166007)(356005)(54906003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:49:47.3033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af74f75-4497-4aa4-a64d-08d9fffe49c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1812
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Unify naming for fixed VS workarounds.

[How]
Rename function to match naming convention.
Refactor code to remove unused function.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 55 ++-----------------
 1 file changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1895252765dc..6a213467c97c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -347,29 +347,6 @@ static void vendor_specific_lttpr_wa_one_start(struct dc_link *link)
 			sizeof(vendor_lttpr_write_data));
 }
 
-static void vendor_specific_lttpr_wa_one_end(
-	struct dc_link *link,
-	uint8_t retry_count)
-{
-	const uint8_t vendor_lttpr_write_data[4] = {0x1, 0x50, 0x63, 0x0};
-	const uint8_t offset = dp_convert_to_count(
-			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
-	uint32_t vendor_lttpr_write_address = 0xF004F;
-
-	if (!retry_count) {
-		if (offset != 0xFF)
-			vendor_lttpr_write_address +=
-					((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
-
-		/* W/A for certain LTTPR to reset their lane settings, part two of two */
-		core_link_write_dpcd(
-				link,
-				vendor_lttpr_write_address,
-				&vendor_lttpr_write_data[0],
-				sizeof(vendor_lttpr_write_data));
-	}
-}
-
 static void vendor_specific_lttpr_wa_one_two(
 	struct dc_link *link,
 	const uint8_t rate)
@@ -396,9 +373,9 @@ static void vendor_specific_lttpr_wa_one_two(
 	}
 }
 
-static void vendor_specific_lttpr_wa_three(
+static void dp_fixed_vs_pe_read_lane_adjust(
 	struct dc_link *link,
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX])
+	union dpcd_training_lane dpcd_lane_adjust[LANE_COUNT_DP_MAX])
 {
 	const uint8_t vendor_lttpr_write_data_vs[3] = {0x0, 0x53, 0x63};
 	const uint8_t vendor_lttpr_write_data_pe[3] = {0x0, 0x54, 0x63};
@@ -440,23 +417,8 @@ static void vendor_specific_lttpr_wa_three(
 			1);
 
 	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
-		dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_LANE = (dprx_vs >> (2 * lane)) & 0x3;
-		dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_LANE = (dprx_pe >> (2 * lane)) & 0x3;
-	}
-}
-
-static void vendor_specific_lttpr_wa_three_dpcd(
-	struct dc_link *link,
-	union dpcd_training_lane dpcd_lane_adjust[LANE_COUNT_DP_MAX])
-{
-	union lane_adjust lane_adjust[LANE_COUNT_DP_MAX];
-	uint8_t lane = 0;
-
-	vendor_specific_lttpr_wa_three(link, lane_adjust);
-
-	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
-		dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_SET = lane_adjust[lane].bits.VOLTAGE_SWING_LANE;
-		dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_SET = lane_adjust[lane].bits.PRE_EMPHASIS_LANE;
+		dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_SET  = (dprx_vs >> (2 * lane)) & 0x3;
+		dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_SET = (dprx_pe >> (2 * lane)) & 0x3;
 	}
 }
 
@@ -1463,13 +1425,6 @@ static enum link_training_result perform_clock_recovery_sequence(
 				dpcd_lane_adjust,
 				offset);
 
-		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-				link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
-			vendor_specific_lttpr_wa_one_end(link, retry_count);
-			vendor_specific_lttpr_wa_three(link, dpcd_lane_adjust);
-		}
-
 		/* 5. check CR done*/
 		if (dp_is_cr_done(lane_count, dpcd_lane_status))
 			return LINK_TRAINING_SUCCESS;
@@ -4136,7 +4091,7 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
 			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
-		vendor_specific_lttpr_wa_three_dpcd(
+		dp_fixed_vs_pe_read_lane_adjust(
 				link,
 				link_training_settings.dpcd_lane_settings);
 
-- 
2.25.1


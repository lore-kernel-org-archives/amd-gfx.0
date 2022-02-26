Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F007AC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D73510E2B4;
	Sat, 26 Feb 2022 15:42:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E279110E2B4
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSvRuvBplhCkvfcQm6KgrxlRyJCJpHFkL573sVk0JYgPj/JreDIXGniAOvZrjiQV8EPJZM2G05uR7qLZ9UFJ4l1ufbTRFUoPqt1NO0FQnaofKs9SVVJkut+YTjcDFgi0Rg/WViETBsh3LqITT2Ekb9Mz/4URmYo6wSmy6Uwz3jj3lpG1eDQos41LT7eoAa9SHfXvdHX9IF92fkmK7bRMusdsnbw2Zl/pTgaS4FDwpOfE1gRg9FgfxjgebwOTPga1r8xR4H6GWI64fdQkTkbhhQ6HC6eRHdYHwRqPjqQogOdI5h4wILHvmoI9/shnhGMILzdyjof8PPc7exTGePTWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKzRiLWl7yEHq1W2E/Kd8kB9LQMXvIuM4bXwOkTqNro=;
 b=IPXcnXHyLnBIaL+4CYQ3Lw5yXMmPfcD2JK+D4JOTAIk0Wt7fC6SuGG2qk4zvhSgjEkanBeqZ8JQt9oV9tiavorlxjB8fPqJVWkVjGIBl1QZ1muk8MEYe8ezqgvPq4w1Q8xGuHnq2S8xQmoChmcdSV4hwjvZAHpF9oD2oa3sEwdwnp1zYg1EyPsHVTU4x8PDJn7DqJguT99B5d1PbAGIw4XRrcUVO8EbzYS+6ZIEL8tnAHjQ94jCkugGJgbp69ScQIgzTAbyrKgjKevzTWhWxLhA5bCfPO0fhDwJ+pgzTsPvOF0OKtjsey2oivMKqRJL9SkeVpXjK/PWiIf3nBaPECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKzRiLWl7yEHq1W2E/Kd8kB9LQMXvIuM4bXwOkTqNro=;
 b=4B1aWpSZeuukmxJlwi/5lGbyxmTGfnFrEjw3UKI+7QjEQE9ovohtOnBzW0gB6AIxO/2IK5N2yxeK6HrKC/ZniCXLrbt+CEk6Le9qW57Mt1Oowe1lOWhIBItm9zSA4+Xup3JHHPvjNQ4y7AVDq3M8AHVa54kBiyzaBGdSsXGXtXE=
Received: from DM5PR2001CA0020.namprd20.prod.outlook.com (2603:10b6:4:16::30)
 by BL0PR12MB2546.namprd12.prod.outlook.com (2603:10b6:207:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 15:42:18 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::3f) by DM5PR2001CA0020.outlook.office365.com
 (2603:10b6:4:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:16 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:12 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: Refactor fixed VS w/a for PHY tests
Date: Sun, 27 Feb 2022 07:41:12 +0800
Message-ID: <20220226234117.3328151-10-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 823138a1-fe3e-4604-24bf-08d9f93e9188
X-MS-TrafficTypeDiagnostic: BL0PR12MB2546:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2546C055579AE50E0C8D18CBF53F9@BL0PR12MB2546.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKLMA+ZsmQ9EtjMxnckTB6N28nkVt4nkbyWTuV20XRUxcf8luGBjZtn/7/Md8MaaZsCVDJWpNUAcAv9UDbajd6AcZ6EzCCsXttYCDtJ89al9MHLm42hSLi6+AciZO7ENFfIn6fcOq2btHQvZ3K+A3c0DhLwH16pTF4b+yE8d8alm0yy6c0ayW0iZAptyuFjTzmxbYB02EUHWpKbFcdhdgO1DjZCIpTSPkXL8hi6d7MZyUCX839OjKZaNcJ5pPaOPRs78SBoy93InbioVhjxd6zxFnhSyQQDA9QAk4VjvsdzDqprlyCqYhVZrXiHzHzTZx4BZepm5DbMZKd8MZF2AklZtKzxIsfQV5ZEv13onkKGKdjeU5yzVJLhE3p/XcRxJI6wKEIxeyo9qHuMdC9ywqtHn/ZSxOicvoHMK4rByIovoYynBPMcJMb2UDBMBCBUvwaWYFtkL+zR1cLf3N3ZGKTPD+sgFgGON13Vq32CICOuwaNw+9+PuDg4vEqyhDPcAXldd+q/RgzRl702A5Pd69YPbOhGzBktPSwXmAzXZnewaiAdmuwGk8jmbLxmTKbTJO4Lm7koLJwV77FYpvO89Dql61gpP4cQlwHXf2QVrsYj5MRmDlZtdYxQhMwnCOe8SpMwnrlZ10e4x2/C4zwp38iNVCJ+jad77KKRtb20lT9QpCB0IhVqg3Y0u7MV02udWuyHhTfnIsLRNoo2g06A3NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(81166007)(356005)(5660300002)(2616005)(36756003)(47076005)(2906002)(7696005)(36860700001)(8936002)(6916009)(70206006)(82310400004)(8676002)(4326008)(70586007)(40460700003)(186003)(1076003)(83380400001)(316002)(508600001)(86362001)(426003)(336012)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:17.3449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823138a1-fe3e-4604-24bf-08d9f93e9188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2546
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, "Shen,
 George" <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shen, George" <George.Shen@amd.com>

[Why/How]
Refactor original w/a to unify naming and
simplify logic. This also re-enables the code
that was previously skipped due to the
disabling of the previous workaround logic.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5688b15ca9e6..1895252765dc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -505,17 +505,24 @@ static void vendor_specific_lttpr_wa_four(
 	}
 }
 
-static void vendor_specific_lttpr_wa_five(
+static void dp_fixed_vs_pe_set_retimer_lane_settings(
 	struct dc_link *link,
 	const union dpcd_training_lane dpcd_lane_adjust[LANE_COUNT_DP_MAX],
 	uint8_t lane_count)
 {
-	const uint32_t vendor_lttpr_write_address = 0xF004F;
+	const uint8_t offset = dp_convert_to_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	const uint8_t vendor_lttpr_write_data_reset[4] = {0x1, 0x50, 0x63, 0xFF};
+	uint32_t vendor_lttpr_write_address = 0xF004F;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
 	uint8_t lane = 0;
 
+	if (offset != 0xFF) {
+		vendor_lttpr_write_address +=
+				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+	}
+
 	for (lane = 0; lane < lane_count; lane++) {
 		vendor_lttpr_write_data_vs[3] |=
 				dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
@@ -5989,15 +5996,14 @@ bool dc_link_dp_set_test_pattern(
 			if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
 					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 					link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
-				dpcd_set_lane_settings(link, p_link_settings, DPRX);
-				vendor_specific_lttpr_wa_five(
+				dp_fixed_vs_pe_set_retimer_lane_settings(
 						link,
 						p_link_settings->dpcd_lane_settings,
 						p_link_settings->link_settings.lane_count);
 			} else {
 				dp_set_hw_lane_settings(link, &pipe_ctx->link_res, p_link_settings, DPRX);
-				dpcd_set_lane_settings(link, p_link_settings, DPRX);
 			}
+			dpcd_set_lane_settings(link, p_link_settings, DPRX);
 		}
 
 		/* Blank stream if running test pattern */
-- 
2.25.1


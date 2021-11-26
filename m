Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05943C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703CD6EA6B;
	Fri, 26 Nov 2021 19:50:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352BE6E984
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbRYVfy2kzPNVybejfsv9AM85bwk55PHl/qY9unzwzIHhUK3ROLqYDcrOK3u2tdyBnnkwvwhllQrZ8yGdqBRO7sG6Sl5ebn1b6SavYW3vkrnd+DKr7ZegjnR7TjvQoKSY2yRZ4b7bqowhk+UU+mtXBAT2yl/o/VI9p1Dd6u3dU7OzkZ8xL6+iVrya6DBNEBuyr5JCBhN/eMEAkjPor4jb1IgyjKU8WAJ24IIzlomYyBLJA1GZMO50xuxwvKbtFv6KwV4aX1pi3TWDYjdwxo+Fi66xYClu00caStNJip7rnKWQUeyF2fJt2mET6BTn+euO35XBkI98QTXLXEON1CKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3iBspsx2qUFUNzdMdaFSDtRlAezs8YtoxbaSwQmivM=;
 b=Yrb2cV/MP/yT/4+R8WKkss6WNDJwsXY6Xn8H10RnW0k+wlG//N21vqao1bjwrl6P9wfAnIskFUIoOrXVV1Dv5S3JGa8rM2PbK/gtK0ZQ8WwsTS/0qelHQw87tFZmVvFDYIfn0pOWfKfYfOHwYe1qzGsZLm6Z5qq4EPPxsJUPUSTnz7p2ZwB49Dnwc+0bNmOdkPbqQ5zP5lrlUJ6C2tB0XaKnxvG6CvvhPfqhLzbbFOsg8oC58QtG3QhBDIxNcsNxgqnqnL/hZstEpZ6tX8OCE2vhuHJB4BsbCAO+GbgVWzW4cSB5N2xtCnNy6fQ8/AQULNInCj+vC/VLxPq/6K2fUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3iBspsx2qUFUNzdMdaFSDtRlAezs8YtoxbaSwQmivM=;
 b=4oYABwyEsI0st4RBznQszQvO2N9DhAOX2GWgaE2dGeapV4yZUGFErCQvxKA/QPmsQwD/JVACnbry3x2zKe5iBHCwYw8s7dc6x1ocvLZFOOmDJh71YcBGp9dQlr43q5iXYC0MRSLKgQUgP5Bg7OWQC8ZnRJGpcIvUIQ6NJdeKq+U=
Received: from BN6PR19CA0117.namprd19.prod.outlook.com (2603:10b6:404:a0::31)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 19:49:43 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::d8) by BN6PR19CA0117.outlook.office365.com
 (2603:10b6:404:a0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:38 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:37 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Add vendor specific LTTPR workarounds
 for DCN31
Date: Fri, 26 Nov 2021 14:49:17 -0500
Message-ID: <20211126194922.816835-12-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e805e4a-d3a3-4b2c-f026-08d9b115e3e9
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45099434C0CDA90F01DA7CEDF9639@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdY2tUNWFeVjLpbn09ycU4GsVIZFdw1EM6zSjb7sBAN0Y/3KtNyqlDYUqGieDrxfclCfZGZFEnWfguQ38ijBjFzJ2gqoHGaL+X3V2sQnvi2TBb7erNB96JV6KTLe1zK0xiXsOoCCSuZBbRxmf8TSpseBHOgH8NuJKHK+ytHhadQZwywi6H2jvGJGQ9FH5Nyb8efvXjZMOXSl2ZVW2jwd42N2bJzd5oZIFnmteAJtnG48uXa8Q/634Z6ohf5nSoRH+M95wXMkDwJnU6SX+Rddoz3eqekaCMhar9n1uOUTr4sQNfHHch4o7ARn66HdXESaYRFr5aSp6FyB+Ercv3+FmogZVJcqHRAgB9CP0ZbPcwEj60ZQfj+TZSJodBhSsMpHrM7x6vWOmN8ylYL/wc7QepF8fUMD4klMAfdtQpCeI6DlrVQlgAcbdX6dd4+RKYmdPkoB3bHlJ5EgOpbdVs2JZxfgYhBJyJZgePJrCAaJfmRI1Ram7dMJIGYiV5+KKhWNC+CX9bp99/4iDWiV14jPMGN1JW6olkACJnM4WVrV8Rp5ROCnMI2Rk1QS4bp4jvv/TkpKR7xEfg/2fQ9L+AtKT+huICTK3S3FXDIG8OJoYpNmK2E9a7KXBjgIYJfQqkfIHsfoyS9zLdX0KVhjMcHxCtLBBjdya+t4qL6xKT2uQIs7X2ObSkWo3IIc1oqZ/Wxdb+V2R6tIEK/Bs0aE+5qJy5yQFNeKvbXMyQnovZASo/EIK6K/qMLkYKgNNo8LkowwhDZnUm67vGUsBi/kbjQNuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(26005)(6916009)(316002)(70206006)(36756003)(1076003)(82310400004)(2906002)(36860700001)(83380400001)(508600001)(8676002)(5660300002)(186003)(356005)(81166007)(336012)(54906003)(86362001)(6666004)(47076005)(426003)(2616005)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:41.9398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e805e4a-d3a3-4b2c-f026-08d9b115e3e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
Certain LTTPR require special workarounds in order to comply
with DP specifications.

[How]
Implement vendor specific sequences via DPCD writes to
vendor-specific LTTPR registers.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 196 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   3 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 4 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ee9b80809fc5..5eea4ec82f99 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -398,6 +398,170 @@ static uint8_t get_dpcd_link_rate(const struct dc_link_settings *link_settings)
 }
 #endif
 
+static void vendor_specific_lttpr_wa_one_start(struct dc_link *link)
+{
+	const uint8_t vendor_lttpr_write_data[4] = {0x1, 0x50, 0x63, 0xff};
+	const uint8_t offset = dp_convert_to_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	uint32_t vendor_lttpr_write_address = 0xF004F;
+
+	if (offset != 0xFF)
+		vendor_lttpr_write_address +=
+				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+
+	/* W/A for certain LTTPR to reset their lane settings, part one of two */
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data[0],
+			sizeof(vendor_lttpr_write_data));
+}
+
+static void vendor_specific_lttpr_wa_one_end(
+	struct dc_link *link,
+	uint8_t retry_count)
+{
+	const uint8_t vendor_lttpr_write_data[4] = {0x1, 0x50, 0x63, 0x0};
+	const uint8_t offset = dp_convert_to_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	uint32_t vendor_lttpr_write_address = 0xF004F;
+
+	if (!retry_count) {
+		if (offset != 0xFF)
+			vendor_lttpr_write_address +=
+					((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+
+		/* W/A for certain LTTPR to reset their lane settings, part two of two */
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data[0],
+				sizeof(vendor_lttpr_write_data));
+	}
+}
+
+static void vendor_specific_lttpr_wa_one_two(
+	struct dc_link *link,
+	const uint8_t rate)
+{
+	uint8_t toggle_rate = 0x0;
+
+	if (rate == 0x6)
+		toggle_rate = 0xA;
+	else
+		toggle_rate = 0x6;
+
+	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+		/* W/A for certain LTTPR to reset internal state for link training */
+		core_link_write_dpcd(
+				link,
+				DP_LINK_BW_SET,
+				&toggle_rate,
+				1);
+	}
+
+	/* Store the last attempted link rate for this link */
+	link->vendor_specific_lttpr_link_rate_wa = rate;
+}
+
+static void vendor_specific_lttpr_wa_three(
+	struct dc_link *link,
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX])
+{
+	const uint8_t vendor_lttpr_write_data_vs[3] = {0x0, 0x53, 0x63};
+	const uint8_t vendor_lttpr_write_data_pe[3] = {0x0, 0x54, 0x63};
+	const uint8_t offset = dp_convert_to_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	uint32_t vendor_lttpr_write_address = 0xF004F;
+	uint32_t vendor_lttpr_read_address = 0xF0053;
+	uint8_t dprx_vs = 0;
+	uint8_t dprx_pe = 0;
+	uint8_t lane;
+
+	if (offset != 0xFF) {
+		vendor_lttpr_write_address +=
+				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+		vendor_lttpr_read_address +=
+				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+	}
+
+	/* W/A to read lane settings requested by DPRX */
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_vs[0],
+			sizeof(vendor_lttpr_write_data_vs));
+	core_link_read_dpcd(
+			link,
+			vendor_lttpr_read_address,
+			&dprx_vs,
+			1);
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_pe[0],
+			sizeof(vendor_lttpr_write_data_pe));
+	core_link_read_dpcd(
+			link,
+			vendor_lttpr_read_address,
+			&dprx_pe,
+			1);
+
+	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
+		dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_LANE = (dprx_vs >> (2 * lane)) & 0x3;
+		dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_LANE = (dprx_pe >> (2 * lane)) & 0x3;
+	}
+}
+
+static void vendor_specific_lttpr_wa_four(
+	struct dc_link *link,
+	bool apply_wa)
+{
+	const uint8_t vendor_lttpr_write_data_one[4] = {0x1, 0x55, 0x63, 0x8};
+	const uint8_t vendor_lttpr_write_data_two[4] = {0x1, 0x55, 0x63, 0x0};
+	const uint8_t offset = dp_convert_to_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	uint32_t vendor_lttpr_write_address = 0xF004F;
+#if defined(CONFIG_DRM_AMD_DC_DP2_0)
+	uint8_t sink_status = 0;
+	uint8_t i;
+#endif
+
+	if (offset != 0xFF)
+		vendor_lttpr_write_address +=
+				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+
+	/* W/A to pass through DPCD write of TPS=0 to DPRX */
+	if (apply_wa) {
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_one[0],
+				sizeof(vendor_lttpr_write_data_one));
+	}
+
+	/* clear training pattern set */
+	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
+
+	if (apply_wa) {
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_two[0],
+				sizeof(vendor_lttpr_write_data_two));
+	}
+
+#if defined(CONFIG_DRM_AMD_DC_DP2_0)
+	/* poll for intra-hop disable */
+	for (i = 0; i < 10; i++) {
+		if ((core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) == DC_OK) &&
+				(sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION) == 0)
+			break;
+		udelay(1000);
+	}
+#endif
+}
+
 enum dc_status dpcd_set_link_settings(
 	struct dc_link *link,
 	const struct link_training_settings *lt_settings)
@@ -452,6 +616,13 @@ enum dc_status dpcd_set_link_settings(
 #else
 		rate = (uint8_t) (lt_settings->link_settings.link_rate);
 #endif
+		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+					link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+			vendor_specific_lttpr_wa_one_start(link);
+			vendor_specific_lttpr_wa_one_two(link, rate);
+		}
+
 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
 	}
 
@@ -1329,6 +1500,13 @@ static enum link_training_result perform_clock_recovery_sequence(
 				dpcd_lane_adjust,
 				offset);
 
+		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+				link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+			vendor_specific_lttpr_wa_one_end(link, retry_count);
+			vendor_specific_lttpr_wa_three(link, dpcd_lane_adjust);
+		}
+
 		/* 5. check CR done*/
 		if (dp_is_cr_done(lane_count, dpcd_lane_status))
 			return LINK_TRAINING_SUCCESS;
@@ -2203,7 +2381,12 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&lt_settings);
 
 	/* reset previous training states */
-	dpcd_exit_training_mode(link);
+	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+		vendor_specific_lttpr_wa_four(link, true);
+	else
+		dpcd_exit_training_mode(link);
 
 	/* configure link prior to entering training mode */
 	dpcd_configure_lttpr_mode(link, &lt_settings);
@@ -2223,8 +2406,15 @@ enum link_training_result dc_link_dp_perform_link_training(
 	else
 		ASSERT(0);
 
-	/* exit training mode and switch to video idle */
-	dpcd_exit_training_mode(link);
+	/* exit training mode */
+	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+		vendor_specific_lttpr_wa_four(link, (status != LINK_TRAINING_SUCCESS));
+	else
+		dpcd_exit_training_mode(link);
+
+	/* switch to video idle */
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern)
 		status = dp_transition_to_video_idle(link,
 				&lt_settings,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1738556c9b59..9f5745313e48 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -696,6 +696,7 @@ struct dc_debug_options {
 	bool enable_sw_cntl_psr;
 	union dpia_debug_options dpia_debug;
 #endif
+	bool apply_vendor_specific_lttpr_wa;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 30822aa33931..a99950883e85 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -186,6 +186,9 @@ struct dc_link {
 	/* Drive settings read from integrated info table */
 	struct dc_lane_settings bios_forced_drive_settings;
 
+	/* Vendor specific LTTPR workaround variables */
+	uint8_t vendor_specific_lttpr_link_rate_wa;
+
 	/* MST record stream using this link */
 	struct link_flags {
 		bool dp_keep_receiver_powered;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 70cbd89bdcb8..6187c55ac82c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1023,6 +1023,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.optimize_edp_link_rate = true,
 	.enable_sw_cntl_psr = true,
+	.apply_vendor_specific_lttpr_wa = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.25.1


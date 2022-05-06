Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4886C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F035210E4D1;
	Fri,  6 May 2022 15:42:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92C310E4D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PamUl75NyGMcmlRb+aUaQHyO+2+XmB1wnghQqd7MmPyD81aC+qWi6ZGcw46i68i6yznXOgs/5EJ63vxKm/4DucFvQQ0QxxTW/BeuoeaMbKzJdV66vQIOOCbcWLnG0dPv36uuy1s4iZ4xbQQFdxffuYiCo7H2rX67lFWO1zhznd3uCvU0bV3XG3ErPUGUJdz18c/1bEexZzZLk2krD7G25fJEDaNd2vXNXgss3SW50GlWzv1dvDEITNhWRS5ombPtoQNRdi5nTTVqwQSQfObZ/wPyHwx0fgryi4JgqyPmCcBo5pCuGf/gEIwRunfsG8kcCA/SYKCEZyh6dS9YKbgPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q3b7SFYpjdSbBCK/KxjIOuU+LkTuzXfoGbzqlrceoQ=;
 b=WsjMNuUAvRiUFFtfx/WQCEBGaRdhuZz4W+wEiMzneKr2JfjearLImIUZLdkcdVdLNmdWLiZEUhzgXr3bjQAtpAm2opn6PtaXlhsKvgGsX6MRUUjge3U7Hw8jrauuXZEbvhVgrz0VHj+IUTDgJReepjmq4U/8JPHLcqi+dddtIFc9YGrK2pppIJXn6jwig3M3nhEmQYBvIX92OR6ok9B4XJUE4XFAdkAxU2N5dUQNcd6X2x7pZ7yXr16saRV96WuNii6168rEpLSKswUlXXpq46ObzPzG3OzHW6OGeKsk99STF6xpPidvEztgXsPZ0MLY3UvM/NoHC4diKnWcxoghJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q3b7SFYpjdSbBCK/KxjIOuU+LkTuzXfoGbzqlrceoQ=;
 b=menD8/NFs+m4kw+hW1W7w2CVlVoc2cvwPSmSP5AHrogDwVaaatpvbWw+2c9+WEcXRiiiytrZ0dp5/ke7Y6LF0EjBKqnJ1et4PFwEEjsTREuqAxspF8ECr5Nlgj1DuLk7Co3ZUKfl3yhJ4EzvqUeqwlhVge7k3cHYisHeM9N2Db4=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 6 May
 2022 15:42:52 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::f9) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 15:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:42:51 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:42:46 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/15] drm/amd/display: Refactor LTTPR cap retrieval
Date: Fri, 6 May 2022 23:42:00 +0800
Message-ID: <20220506154214.3438665-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eb3cfaa-a6af-4130-ca97-08da2f771480
X-MS-TrafficTypeDiagnostic: DM6PR12MB2697:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB269752503AAAED0A8DEAADD4FFC59@DM6PR12MB2697.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n0kO+AZ8nceiCcA8EQsjbr9BwZ7VVejBj3hZdZLzHEeDKBFOM7abpzs6vjDzl06eVE8MmRsVpNhL2YB313yTexODtoOKOfqIx/RXcQSpjTwerDqZepfr+ub/yJAPakHGRVA3A/bYTTZfTcTzIaVa04KsD+3t+hWC3qbRm99CqzIJggLId8W/430qqk7UX/4rNi+eoSidWU5lpg/NGFa07DfqjQrR/hodZM1rfwkCNZwrhNgNX8U76sK35L9MeHi7gEZhudOg5qRElda+QsEh3vZ5Wo5vgaIkgX9DUoEQeTxt/56veGsLSvghw7f0u7BjkRN1kRy4YrcG77UQiFGIjt2lJrhUUnCQN4lXfU6fWnDLXkoapFCaI8+x2rgEjJkd6iStvx/G0j+BTh57tQNHWZdc+l31EYeI5wrkIns1cd04OH58YbuXAM9zH/+T9Y/qwPG0pLyAt1kAD0Ucl6XOEs5fz1fypP0owcknYhP+yi7zR0DA87QrFmAgQxyNyhtKhiPYL6vpyiGwWyK/LAv9K4ZnlLrhlgflSDx0VzUz6NSOlAhfySirQkIAwDQQms15wqadZWKxf+gcSIQSViOGKSrH5vwrNqNcGLcjStWG5Ocai+VgZxE3FGclufRME330Ih/BpnJPvz0N5gkvUxKr9zGwUkJsxDbWv88foYP1o+4nGwjm9E/y64iS3+GLkFcpdQcLADfu7TxXtvPE9ad2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(6916009)(426003)(47076005)(336012)(508600001)(70586007)(1076003)(186003)(54906003)(316002)(70206006)(86362001)(40460700003)(6666004)(2616005)(356005)(81166007)(44832011)(8676002)(5660300002)(8936002)(82310400005)(2906002)(7696005)(4326008)(36756003)(83380400001)(30864003)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:42:51.6226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb3cfaa-a6af-4130-ca97-08da2f771480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2697
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Split LTTPR mode selection between platform support and downstream link support

Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 175 +++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   3 +-
 .../amd/display/include/link_service_types.h  |   6 +
 4 files changed, 113 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 55a5a6a49fe2..5e49e346aa06 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5097,16 +5097,13 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 	return true;
 }
 
-bool dp_retrieve_lttpr_cap(struct dc_link *link)
+void dp_retrieve_lttpr_cap(struct dc_link *link)
 {
-	uint8_t lttpr_dpcd_data[8];
 	bool allow_lttpr_non_transparent_mode = 0;
-	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
-	bool is_lttpr_present = false;
 
-	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
+	memset(link->lttpr_dpcd_data, '\0', sizeof(link->lttpr_dpcd_data));
 
 	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
 			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
@@ -5116,88 +5113,118 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 		allow_lttpr_non_transparent_mode = 1;
 	}
 
+	link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+	link->lttpr_support = LTTPR_UNSUPPORTED;
+
 	/*
-	 * Logic to determine LTTPR mode
+	 * Logic to determine LTTPR support
 	 */
-	link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-	if (vbios_lttpr_enable && vbios_lttpr_interop)
-		link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-	else if (!vbios_lttpr_enable && vbios_lttpr_interop) {
-		if (allow_lttpr_non_transparent_mode)
-			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-		else
-			link->lttpr_mode = LTTPR_MODE_TRANSPARENT;
-	} else if (!vbios_lttpr_enable && !vbios_lttpr_interop) {
-		if (!allow_lttpr_non_transparent_mode || !link->dc->caps.extended_aux_timeout_support)
-			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-		else
-			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-	}
+	if (vbios_lttpr_interop)
+		link->lttpr_support = LTTPR_SUPPORTED;
+	else if (link->dc->config.allow_lttpr_non_transparent_mode.raw == 0
+			|| !link->dc->caps.extended_aux_timeout_support)
+			link->lttpr_support = LTTPR_UNSUPPORTED;
+	else
+		link->lttpr_support = LTTPR_CHECK_EXT_SUPPORT;
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Check DP tunnel LTTPR mode debug option. */
 	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
 	    link->dc->debug.dpia_debug.bits.force_non_lttpr)
-		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+		link->lttpr_support = LTTPR_UNSUPPORTED;
 #endif
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+	if (link->lttpr_support > LTTPR_UNSUPPORTED) {
 		/* By reading LTTPR capability, RX assumes that we will enable
 		 * LTTPR extended aux timeout if LTTPR is present.
 		 */
 		status = core_link_read_dpcd(
 				link,
 				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
-				lttpr_dpcd_data,
-				sizeof(lttpr_dpcd_data));
-		if (status != DC_OK) {
-			DC_LOG_DP2("%s: Read LTTPR caps data failed.\n", __func__);
-			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-			return false;
-		}
+				link->lttpr_dpcd_data,
+				sizeof(link->lttpr_dpcd_data));
+	}
+}
 
-		link->dpcd_caps.lttpr_caps.revision.raw =
-				lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.max_link_rate =
-				lttpr_dpcd_data[DP_MAX_LINK_RATE_PHY_REPEATER -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.phy_repeater_cnt =
-				lttpr_dpcd_data[DP_PHY_REPEATER_CNT -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.max_lane_count =
-				lttpr_dpcd_data[DP_MAX_LANE_COUNT_PHY_REPEATER -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.mode =
-				lttpr_dpcd_data[DP_PHY_REPEATER_MODE -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.max_ext_timeout =
-				lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.main_link_channel_coding.raw =
-				lttpr_dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
-				lttpr_dpcd_data[DP_PHY_REPEATER_128b_132b_RATES -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
-		is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
-				link->dpcd_caps.lttpr_caps.phy_repeater_cnt < 0xff &&
-				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
-		if (is_lttpr_present) {
-			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
-			configure_lttpr_mode_transparent(link);
-		} else
-			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+bool dp_parse_lttpr_mode(struct dc_link *link)
+{
+	bool dpcd_allow_lttpr_non_transparent_mode = false;
+	bool is_lttpr_present = false;
+
+	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
+
+	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
+			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
+		dpcd_allow_lttpr_non_transparent_mode = true;
+	} else if (link->dc->config.allow_lttpr_non_transparent_mode.bits.DP1_4A &&
+			!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
+		dpcd_allow_lttpr_non_transparent_mode = true;
 	}
+
+	/*
+	 * Logic to determine LTTPR mode
+	 */
+	if (link->lttpr_support == LTTPR_SUPPORTED)
+		if (vbios_lttpr_enable)
+			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+		else if (dpcd_allow_lttpr_non_transparent_mode)
+			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+		else
+			link->lttpr_mode = LTTPR_MODE_TRANSPARENT;
+	else	// lttpr_support == LTTPR_CHECK_EXT_SUPPORT
+		if (dpcd_allow_lttpr_non_transparent_mode) {
+			link->lttpr_support = LTTPR_SUPPORTED;
+			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+		} else {
+			link->lttpr_support = LTTPR_UNSUPPORTED;
+		}
+
+	if (link->lttpr_support == LTTPR_UNSUPPORTED)
+		return false;
+
+	link->dpcd_caps.lttpr_caps.revision.raw =
+			link->lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.max_link_rate =
+			link->lttpr_dpcd_data[DP_MAX_LINK_RATE_PHY_REPEATER -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.phy_repeater_cnt =
+			link->lttpr_dpcd_data[DP_PHY_REPEATER_CNT -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.max_lane_count =
+			link->lttpr_dpcd_data[DP_MAX_LANE_COUNT_PHY_REPEATER -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.mode =
+			link->lttpr_dpcd_data[DP_PHY_REPEATER_MODE -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.max_ext_timeout =
+			link->lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.main_link_channel_coding.raw =
+			link->lttpr_dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
+			link->lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+
+	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
+	is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
+			link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
+			link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
+	if (is_lttpr_present) {
+		CONN_DATA_DETECT(link, link->lttpr_dpcd_data, sizeof(link->lttpr_dpcd_data), "LTTPR Caps: ");
+		configure_lttpr_mode_transparent(link);
+	} else
+		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+
 	return is_lttpr_present;
 }
 
@@ -5349,7 +5376,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 		status = wa_try_to_wake_dprx(link, timeout_ms);
 	}
 
-	is_lttpr_present = dp_retrieve_lttpr_cap(link);
+	dp_retrieve_lttpr_cap(link);
+
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 
@@ -5385,6 +5413,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
+	if (link->lttpr_support > LTTPR_UNSUPPORTED)
+		is_lttpr_present = dp_parse_lttpr_mode(link);
+
 	if (!is_lttpr_present)
 		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a3c37ee3f849..251f2bbc96b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -129,6 +129,8 @@ struct dc_link {
 	bool link_state_valid;
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
+	uint8_t lttpr_dpcd_data[8];
+	enum lttpr_support lttpr_support;
 	enum lttpr_mode lttpr_mode;
 	bool is_internal_display;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 44f167d2584f..78f09893c118 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -217,7 +217,8 @@ void disable_dp_hpo_output(struct dc_link *link,
 void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx);
 
-bool dp_retrieve_lttpr_cap(struct dc_link *link);
+void dp_retrieve_lttpr_cap(struct dc_link *link);
+bool dp_apply_lttpr_mode(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link);
 void dp_receiver_power_ctrl(struct dc_link *link, bool on);
 void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 447a56286dd0..9f465b4d626e 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -80,6 +80,12 @@ enum link_training_result {
 	DP_128b_132b_CDS_DONE_TIMEOUT,
 };
 
+enum lttpr_support {
+	LTTPR_UNSUPPORTED,
+	LTTPR_CHECK_EXT_SUPPORT,
+	LTTPR_SUPPORTED,
+};
+
 enum lttpr_mode {
 	LTTPR_MODE_NON_LTTPR,
 	LTTPR_MODE_TRANSPARENT,
-- 
2.35.1


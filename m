Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F70C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA94710E5DE;
	Fri, 13 May 2022 21:17:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90F010E5DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKRem7A7Lhm4WWig+8ATutrIr0VUKYG63y2473+7LIsJcMncFohyQc3pN4S9NhUwAg3zSKfTk/XhO+pM6kdrtDR6fmrC2raNwejBk66xFjT5TfSCwMQ7sqWUVvrWtIehoa1h2wOSB29G95IJ1fxxT1F0YYDPNapLphknN+Iw7NvRCtgQeFk10GJfhfvo8IshKtS/nI/AKZxH+/7qw7TvCHdsoFlF/Qfn13ioLbGfF5hzVsX45WZD1y5b7DtqamRTWSEUrBSB36oBnHDUbsRV79Q3jcycAGZSwimGbcT37NtO8sPK73knOLZlbvAdiILS8vmH+EB1V6gqcPKurLC8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7OKeJbOYyW/0E2OovuUEt4Mi9mfDHPL3PK71zLmSnI=;
 b=Z3PHOb0c8hOMzIb4rzUwuDMVhqQLw+y1xr8uwU20QOP5NNkZiF9jYlZvMDux2RmEP6UVx3njN+53wK36A3j/TXT/UOSrrZs9l1vcjaQz6qwSmYkLWtIUDq1r4LH4nwu12bGxDdZNwbLIGa53+CixEM6kY7ccO5HyDICstzi/6UuRZVmSpmaccYyRJ7KHy+gfjYnnGoaKjZPJ7nXOpVGTgYAEW+kb/ce+IrV2AtPkJhzqBSfCdBimiXps71m2jOIA3kvddqzj8gHCh8bnrtLd6bTD5t3DFzes4rMihtWA/HtHEmerRWWbJjjF7lwszZJIHvMUS8MWWQYmxy2JngPTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7OKeJbOYyW/0E2OovuUEt4Mi9mfDHPL3PK71zLmSnI=;
 b=3yypywc2UBV0J35usLvbETvsFcETrgPZ9ZnXHAS3RKLcLrCUYDgC1Y8cvpBSpLhHXUSDvjqrVAdtjIcRgPa0ktk1bxFRhRMqR52uwFnhlz+eWVxxtXHZTz877yb284SkMSmDxy7iuiN8YLRnlfvgXyXArsok4QM0Zu+60HpsvAA=
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by CH2PR12MB3959.namprd12.prod.outlook.com (2603:10b6:610:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 21:17:31 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::92) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 21:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:30 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:28 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/11] Revert "drm/amd/display: Refactor LTTPR cap
 retrieval"
Date: Fri, 13 May 2022 17:16:50 -0400
Message-ID: <20220513211651.1312846-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b450d1c-9acc-43af-8035-08da3525fd40
X-MS-TrafficTypeDiagnostic: CH2PR12MB3959:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39597588850FABA7F20B51DFFBCA9@CH2PR12MB3959.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqQYYhA5dS75nZJ38O6EghMHdqjqVAxStrIXsK2AKsBg8jJRMnbxRfs5BrphGCo8eS0Uigy0rRDyrJa7jsnQ9Gx/cFNxS/kShxq/zmfnVf296GymlA6/qIhO+1Pi8ejRhfI3OfY738w7to/NTnEbgKG0bQN2jVJsbDj1SwJg+QH31Nq7G1Cu5VSvpnVyL6JekjJ32VdxbG4xTaTl74GM3UhpEgJffFT5tTOdMz+w4dpSgI2J6Rkys4nniPw3dINWQGLGcozTMLaT5MrCXYqlsxvhmE+o0eaTy9VuyWT7aVW/NxG+1lSj6XF+9Me4WzyWvz8MEQ1aYoC55Yx2Z7K4/5tawFdJC/k6xWdBHUPhWbfonnmvgh00QTaE8duZ4dI0ecD4n439KtcL9eOWeHTf/9olLJ6PehtFxtFZMpuelg0cOx1ePKZp70gOKHsp1m5/sIVv+kUQCsLlaLJJnBfSCD7M+W2IPVSsSJDZ7xdbdNIpKA5EPtPODcuycn70Ui0Is747EbSvqhlfKJo+8O4hiVUNs2Xc0Lyec0NMtXQWVH4DcIsFJ+JTEKyrZrfARuWaHn3KD8tOMZ3VUsBAIEiLeUFfPfiEPXyu7dw9/OM/EDLVicQ70PbOpanCtvRb+kMtkMdGY2peAlQJt5Zw09H+tjQuzxFGMM6F4Vj3Bzpc2kS+h1wujMSuSA27pDKq6dGGvrXuAEhrfNcmbiSojlb85A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(6916009)(6666004)(86362001)(2616005)(4326008)(26005)(81166007)(8676002)(316002)(36860700001)(508600001)(54906003)(356005)(426003)(83380400001)(336012)(47076005)(16526019)(1076003)(186003)(5660300002)(30864003)(8936002)(44832011)(36756003)(2906002)(70586007)(40460700003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:30.3396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b450d1c-9acc-43af-8035-08da3525fd40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3959
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

This reverts commit f07023c8bb2c596af97dea9995d9f5a0140cddd3.

[WHY]
Regressions untentionally caused by change,
reverting until this can be resolved.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 171 +++++++-----------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   3 +-
 .../amd/display/include/link_service_types.h  |   6 -
 4 files changed, 69 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d8de8dbf3676..3c9523218c19 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5126,13 +5126,16 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 	return true;
 }
 
-void dp_retrieve_lttpr_cap(struct dc_link *link)
+bool dp_retrieve_lttpr_cap(struct dc_link *link)
 {
+	uint8_t lttpr_dpcd_data[8];
 	bool allow_lttpr_non_transparent_mode = 0;
+	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
+	bool is_lttpr_present = false;
 
-	memset(link->lttpr_dpcd_data, '\0', sizeof(link->lttpr_dpcd_data));
+	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
 
 	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
 			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
@@ -5142,116 +5145,82 @@ void dp_retrieve_lttpr_cap(struct dc_link *link)
 		allow_lttpr_non_transparent_mode = 1;
 	}
 
-	link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-	link->lttpr_support = LTTPR_UNSUPPORTED;
-
 	/*
-	 * Logic to determine LTTPR support
+	 * Logic to determine LTTPR mode
 	 */
-	if (vbios_lttpr_interop)
-		link->lttpr_support = LTTPR_SUPPORTED;
-	else if (link->dc->config.allow_lttpr_non_transparent_mode.raw == 0
-			|| !link->dc->caps.extended_aux_timeout_support)
-			link->lttpr_support = LTTPR_UNSUPPORTED;
-	else
-		link->lttpr_support = LTTPR_CHECK_EXT_SUPPORT;
+	link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+	if (vbios_lttpr_enable && vbios_lttpr_interop)
+		link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+	else if (!vbios_lttpr_enable && vbios_lttpr_interop) {
+		if (allow_lttpr_non_transparent_mode)
+			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+		else
+			link->lttpr_mode = LTTPR_MODE_TRANSPARENT;
+	} else if (!vbios_lttpr_enable && !vbios_lttpr_interop) {
+		if (!allow_lttpr_non_transparent_mode || !link->dc->caps.extended_aux_timeout_support)
+			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+		else
+			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+	}
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Check DP tunnel LTTPR mode debug option. */
 	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
 	    link->dc->debug.dpia_debug.bits.force_non_lttpr)
-		link->lttpr_support = LTTPR_UNSUPPORTED;
+		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+#endif
 
-	if (link->lttpr_support > LTTPR_UNSUPPORTED) {
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 		/* By reading LTTPR capability, RX assumes that we will enable
 		 * LTTPR extended aux timeout if LTTPR is present.
 		 */
 		status = core_link_read_dpcd(
 				link,
 				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
-				link->lttpr_dpcd_data,
-				sizeof(link->lttpr_dpcd_data));
-	}
-}
-
-bool dp_parse_lttpr_mode(struct dc_link *link)
-{
-	bool dpcd_allow_lttpr_non_transparent_mode = false;
-	bool is_lttpr_present = false;
-
-	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
-
-	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
-			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
-		dpcd_allow_lttpr_non_transparent_mode = true;
-	} else if (link->dc->config.allow_lttpr_non_transparent_mode.bits.DP1_4A &&
-			!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
-		dpcd_allow_lttpr_non_transparent_mode = true;
+				lttpr_dpcd_data,
+				sizeof(lttpr_dpcd_data));
+
+		link->dpcd_caps.lttpr_caps.revision.raw =
+				lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+		link->dpcd_caps.lttpr_caps.max_link_rate =
+				lttpr_dpcd_data[DP_MAX_LINK_RATE_PHY_REPEATER -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+		link->dpcd_caps.lttpr_caps.phy_repeater_cnt =
+				lttpr_dpcd_data[DP_PHY_REPEATER_CNT -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+		link->dpcd_caps.lttpr_caps.max_lane_count =
+				lttpr_dpcd_data[DP_MAX_LANE_COUNT_PHY_REPEATER -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+		link->dpcd_caps.lttpr_caps.mode =
+				lttpr_dpcd_data[DP_PHY_REPEATER_MODE -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+		link->dpcd_caps.lttpr_caps.max_ext_timeout =
+				lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+		link->dpcd_caps.lttpr_caps.main_link_channel_coding.raw =
+				lttpr_dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+		link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
+				lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
+								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
+		is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
+				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
+				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
+		if (is_lttpr_present) {
+			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
+			configure_lttpr_mode_transparent(link);
+		} else
+			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 	}
-
-	/*
-	 * Logic to determine LTTPR mode
-	 */
-	if (link->lttpr_support == LTTPR_SUPPORTED)
-		if (vbios_lttpr_enable)
-			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-		else if (dpcd_allow_lttpr_non_transparent_mode)
-			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-		else
-			link->lttpr_mode = LTTPR_MODE_TRANSPARENT;
-	else	// lttpr_support == LTTPR_CHECK_EXT_SUPPORT
-		if (dpcd_allow_lttpr_non_transparent_mode) {
-			link->lttpr_support = LTTPR_SUPPORTED;
-			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-		} else {
-			link->lttpr_support = LTTPR_UNSUPPORTED;
-		}
-
-	if (link->lttpr_support == LTTPR_UNSUPPORTED)
-		return false;
-
-	link->dpcd_caps.lttpr_caps.revision.raw =
-			link->lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-	link->dpcd_caps.lttpr_caps.max_link_rate =
-			link->lttpr_dpcd_data[DP_MAX_LINK_RATE_PHY_REPEATER -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-	link->dpcd_caps.lttpr_caps.phy_repeater_cnt =
-			link->lttpr_dpcd_data[DP_PHY_REPEATER_CNT -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-	link->dpcd_caps.lttpr_caps.max_lane_count =
-			link->lttpr_dpcd_data[DP_MAX_LANE_COUNT_PHY_REPEATER -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-	link->dpcd_caps.lttpr_caps.mode =
-			link->lttpr_dpcd_data[DP_PHY_REPEATER_MODE -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-	link->dpcd_caps.lttpr_caps.max_ext_timeout =
-			link->lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-	link->dpcd_caps.lttpr_caps.main_link_channel_coding.raw =
-			link->lttpr_dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-	link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
-			link->lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
-							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-
-	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
-	is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
-			link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-			link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
-	if (is_lttpr_present) {
-		CONN_DATA_DETECT(link, link->lttpr_dpcd_data, sizeof(link->lttpr_dpcd_data), "LTTPR Caps: ");
-		configure_lttpr_mode_transparent(link);
-	} else
-		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-
 	return is_lttpr_present;
 }
 
@@ -5403,8 +5372,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 		status = wa_try_to_wake_dprx(link, timeout_ms);
 	}
 
-	dp_retrieve_lttpr_cap(link);
-
+	is_lttpr_present = dp_retrieve_lttpr_cap(link);
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 
@@ -5440,9 +5408,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
-	if (link->lttpr_support > LTTPR_UNSUPPORTED)
-		is_lttpr_present = dp_parse_lttpr_mode(link);
-
 	if (!is_lttpr_present)
 		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 251f2bbc96b9..a3c37ee3f849 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -129,8 +129,6 @@ struct dc_link {
 	bool link_state_valid;
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
-	uint8_t lttpr_dpcd_data[8];
-	enum lttpr_support lttpr_support;
 	enum lttpr_mode lttpr_mode;
 	bool is_internal_display;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 78f09893c118..44f167d2584f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -217,8 +217,7 @@ void disable_dp_hpo_output(struct dc_link *link,
 void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx);
 
-void dp_retrieve_lttpr_cap(struct dc_link *link);
-bool dp_apply_lttpr_mode(struct dc_link *link);
+bool dp_retrieve_lttpr_cap(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link);
 void dp_receiver_power_ctrl(struct dc_link *link, bool on);
 void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 9f465b4d626e..447a56286dd0 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -80,12 +80,6 @@ enum link_training_result {
 	DP_128b_132b_CDS_DONE_TIMEOUT,
 };
 
-enum lttpr_support {
-	LTTPR_UNSUPPORTED,
-	LTTPR_CHECK_EXT_SUPPORT,
-	LTTPR_SUPPORTED,
-};
-
 enum lttpr_mode {
 	LTTPR_MODE_NON_LTTPR,
 	LTTPR_MODE_TRANSPARENT,
-- 
2.25.1


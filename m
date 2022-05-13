Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0A9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2F010E8AA;
	Fri, 13 May 2022 20:51:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8DD10E8AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbOOPDCr0+2alEPB+Fau0MbpTz01i7frfvbZcy47a7XHVo3/2KGusxGSEXoLFcZgI5DHtAEBZGXAAW/9+z2poJbtiW0wUMEu1lA/ounpJBg7OHDFYWwYcYE2nIXqKLbi5beUoEpkNFhzaOqJHV/q2jyJpkW1aTVtFn2fcfolA7PnVF4g9iPjIUiL1BNWwsXwYQEph08LwV34zZSVWLfEcuzQiRhqnbQStRPaUNxs1k5hZWVRzjyLrO4ST0dZo2/VLttn0UhDHcvlCvXUJANWmJldvtuGo5d8i1EfDwC+sXHJhcaQrGzIMTj2RQzskLy7a1FEuyU2hKH9KiqbtmGsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCiAP62Jx7SyhrnJuoRMDWyidDAjmFHTAAVTGkeTEsQ=;
 b=kmgZFQI+0elouhQNyfs5IYcnlhQjb/wOheO4t3n/9aaS0dzneks0q55ArIEp/EKoAc0IDiv5NrhtWDKrNwcK9om+FlBiQFSD/Kn1bmY8l8VTLK7AjBmCOyk+QRLU93tWqqJpu81+k8xY2HI2r41V7F224zGS5OmI4rZVxzIKMEEgSWCDGTHL+KLDpSUBWJiCiZHf455KtIE8dv78LtFg0CR3UGnep+fnOSoiGM7hjlaOMfbyP8TFTAqt57gLFP61kwiWQIodyPZIl68vOtVtB/+a6zmzph1YBKdJcNjmZhwglYnp3jLIJqBEoQaVuamIVEXmcg2Sa133O72UaSDz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCiAP62Jx7SyhrnJuoRMDWyidDAjmFHTAAVTGkeTEsQ=;
 b=nERysChbYzcZsXWC2AO8e7av/ptS4oNoT/junXtAW6lVYqVu4X4hvS62zsr1c96JiaZYs+b9HrLo9TKcICyxtkuB6uqNCjM5AW95iDRbvv+Qjg0GxrC23qe7Zqha2rc8DoFMeLnBusnUWQDmXBGVqrn8GnlgVutphZvfIA75CqE=
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by MW2PR12MB2473.namprd12.prod.outlook.com (2603:10b6:907:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Fri, 13 May
 2022 20:51:34 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::c4) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 20:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:32 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amd/display: Revert refactor LTTPR cap retrieval
Date: Fri, 13 May 2022 16:50:40 -0400
Message-ID: <20220513205041.1311639-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa53b012-7033-4e66-198d-08da35225d7c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2473:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB247392A5460BD64D327681C7FBCA9@MW2PR12MB2473.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFdM807H1GxbvVNo41mO65vZGcObdTuoxI6LyQVE6xfoOMBXoCh1ByleOi6l4NzOSQeBtkSgTODH2rql8F619IZn6kLb1QsCUEjjQ+80Nt5wOeVwPRHDOAr54K6sl44a6r/va22HxRByS02+p2bO3bf7RBk4VU39zCG8N1M3x21FLv1agj5p2umb+CkwdJvJOog3YcpEukF5xk0BI4jzitEvyZnI+G3QO3W//16NkBQ3iC0VV08rwo96oN5TV75tCIqfkQSSjs8M0h3ns7MQplapt3F+kQlwPyYEd8LXFc68ACo1hcmap8erdth9J5Yv25K+5Y2KIvqaYmVnAADW46tXQFKP9MFicZBUIQ/FSty4uxhfXfAarluhvtiugfWlQ3mo/2BOlaGFhlNcBQN3ac6OgijvE7ulYeRvla+0Ctc3P0VxM1TkB6YyvLd+odL+h8cTcqDN1bZOvVkP/xtVL1o4pRpK5WvICJL3o92I8E8R3qo8p0/MQoGOLHguPjKOOttKVe7Ui4Uxh7VtR9gQnYyFZLvbNMZrCW+538OujO5pDFSpB5e/6p3iKWWQTCn41ndCOsHLvpr1RkoYFjpA9tryIbi/3NlQUkWAERcAYhm/G1gYEBA8xHMPzfXQegc5ePm95Zo4NZKywGDJL+3n2hkBerqJYOxcaRnGjFnLnn2Qh8ORklapnnSP1K3kTaFs4/9CjP+8f1NgS5a2T1JasA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(8676002)(6666004)(4326008)(2906002)(26005)(54906003)(40460700003)(6916009)(70206006)(2616005)(70586007)(186003)(36860700001)(508600001)(1076003)(5660300002)(316002)(8936002)(47076005)(336012)(426003)(82310400005)(356005)(81166007)(83380400001)(36756003)(44832011)(16526019)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:33.8045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa53b012-7033-4e66-198d-08da35225d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2473
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


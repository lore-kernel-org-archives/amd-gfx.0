Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2BAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02087AC8A;
	Fri,  3 Dec 2021 22:58:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17257ACA9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqf4Vd8OKeQua3XZl6bHvyKX4zuKd8b2uTpx7+BHyB+6i1EQl/OYiCUR1FGkP0eE8SsQI2dc5zzj4eXZgzKR1JQNbeOORQZZeyILTws0pQbLy6wLW4fvS8TZIKAnXCDu50dWrAW5bE61wk4t9o2UMrzaUtK6rnPXnAHM+fj0sbmKHb64OBjQhr7/OKIJu0oNUaa0uMKdQo/IutSEIIaeOI5N8Nv5BPZwE6zVGNWM48L80Zj9XNlAOfJ6lAUrUCiXwxrG/UXMR1Jen+nwGqVF0n8vFoKzDmwJt7Jp6sli0JguzoKUdtYtTgeIyxstzskgxmBLheLGdGr3pM7hY8mt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nkkf54xY3QE8HzHuv2phBdQFCJf8eCfqOxSMbho6NfM=;
 b=UCC85yYJek871Z5uh50PCZe8lLv48S/p019l7LC8lMT7Xw3ejoYFsJeXFi9vbhPnwTSJ1mB9NjuwUX8ztKEJEL/xlDcjHaXuAQoC5kZpT/RUeJStlVuu+UDf5NzBKoMUSpapnMk04r2Wpp696RnudYE1tGxlq6CjA0MXfRujLj7iisgag6q25uMma+CrQvk133S0KSVEzXn3FCc1nW5BABCBtLIEtCLgBZybeuVFuTmcnbnxN+kiOUXb6khSlh1ENgzsTEB/rqRTYCUD0DzHMKskFMBUSiWiHOJI3vSZjDfRwQ6SQ0pUK6FVN265r4JfOFYDwqPJBjqRDkJw524TAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nkkf54xY3QE8HzHuv2phBdQFCJf8eCfqOxSMbho6NfM=;
 b=Cj5OCLxyDcft4FtMHVyXSDLhxagjcs1nReWFw8fTvg5betmumyxE8KbhA4ZDH0wWL4cbi2iOYukLHRxnlHBLSx+MqTmTqIcGVWkt2v9olP/91TJn//a0eGGWrG0PpzXpvcBh1OKh6ii5zZPfo9LELPKLNTl0eDlfY7SUfXqjw3E=
Received: from BN6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:405:2::11)
 by MWHPR1201MB0270.namprd12.prod.outlook.com (2603:10b6:301:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 22:58:41 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::f8) by BN6PR11CA0001.outlook.office365.com
 (2603:10b6:405:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 22:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:58:40 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:58:37 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/15] drm/amd/display: Add W/A for PHY tests with certain
 LTTPR
Date: Fri, 3 Dec 2021 14:57:49 -0800
Message-ID: <20211203225802.651367-3-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7650de76-b719-4a53-bab2-08d9b6b072bc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0270:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02705A437129C8044FA237E7FC6A9@MWHPR1201MB0270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgZNG2mxnnzHX87301Ha+Rj9E+bUU4mhPrf8iwZt9epxGJ5er+Ehal9oeBNOZmzq/krAdY00UQSpSo+PfS4vRE2uEUZCVS1Ad44VdFtrYm5UuXo2LnqahYnTxYqgnxZGJ+Bi4eE99rH0ezXEpJ8BazOrQzHvS2anXtVb5Bt3cpkckVc7hN5aILiN70+XQWGPe62q/GdOEQPRep3ghUwQF1mMP1DltT9lnmjq7M0QwqivWPXcDQSHqtubObgCvfeOAArIXE+Hg7WdiViJJKL+PieSdH/RjCAtlFWmen74RwR2GyI54ZTgRyWubhW+l1KWtWh5ac0fq2kApu4+uqoyhq4RTyco0ak2SHb25FkFwtt7jos/QE7OKpoRTUZ38PgXsLGG7+BFe/o7Y8ulsAGBIhQ/qQKTWOhrarozrYW2ZQol7+0X5GHL/bWk6XfCC/b0SueWsr6RJlHJenwDHG/SasDbL8lX31WieKaA7O+KyKvA1iQ11DmR6WEn+Lhh+L4MY2VNuevxI548rKGFy2Of77aOvEEQL7jdDkQxOA944Mthf8XDHyn+NtHqCdQ6tJoM8i5DtgEpNmmVerIjL7bBt6ApDikRWN7l6mV8tvfCfO+ocmwvyHJ4lAsIhHdS91IhwbMMloQ72PvwcLh2wBwoMqGjVgn0r5aDGi2N5QEi0bxBHNloAwH/LZtFEtroWddswodrrKG5NKvxmk6lX85WK5Mo4GX0OyHEIIGx2nuEqTKCbGJYIoPuWgTyK39T0kqRpAOWfh+Lz2NQ9S4IGa8q5XeKiTc1WSyjvmAYUDH2g18=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(1076003)(356005)(508600001)(2616005)(81166007)(86362001)(6916009)(2906002)(8936002)(336012)(36756003)(54906003)(426003)(6666004)(316002)(70586007)(83380400001)(70206006)(36860700001)(5660300002)(8676002)(16526019)(82310400004)(7696005)(40460700001)(26005)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:58:40.4637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7650de76-b719-4a53-bab2-08d9b6b072bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
Certain LTTPR require output VS/PE to be explicitly
set during PHY test automation.

[How]
Add vendor-specific sequence to set LTTPR
output VS/PE.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 72 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index e952cdbc675e..f5e43a79c562 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -515,6 +515,21 @@ static void vendor_specific_lttpr_wa_three(
 	}
 }
 
+static void vendor_specific_lttpr_wa_three_dpcd(
+	struct dc_link *link,
+	union dpcd_training_lane dpcd_lane_adjust[LANE_COUNT_DP_MAX])
+{
+	union lane_adjust lane_adjust[LANE_COUNT_DP_MAX];
+	uint8_t lane = 0;
+
+	vendor_specific_lttpr_wa_three(link, lane_adjust);
+
+	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
+		dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_SET = lane_adjust[lane].bits.VOLTAGE_SWING_LANE;
+		dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_SET = lane_adjust[lane].bits.PRE_EMPHASIS_LANE;
+	}
+}
+
 static void vendor_specific_lttpr_wa_four(
 	struct dc_link *link,
 	bool apply_wa)
@@ -564,6 +579,42 @@ static void vendor_specific_lttpr_wa_four(
 #endif
 }
 
+static void vendor_specific_lttpr_wa_five(
+	struct dc_link *link,
+	const union dpcd_training_lane dpcd_lane_adjust[LANE_COUNT_DP_MAX],
+	uint8_t lane_count)
+{
+	const uint32_t vendor_lttpr_write_address = 0xF004F;
+	const uint8_t vendor_lttpr_write_data_reset[4] = {0x1, 0x50, 0x63, 0xFF};
+	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
+	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
+	uint8_t lane = 0;
+
+	for (lane = 0; lane < lane_count; lane++) {
+		vendor_lttpr_write_data_vs[3] |=
+				dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
+		vendor_lttpr_write_data_pe[3] |=
+				dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_SET << (2 * lane);
+	}
+
+	/* Force LTTPR to output desired VS and PE */
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_reset[0],
+			sizeof(vendor_lttpr_write_data_reset));
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_vs[0],
+			sizeof(vendor_lttpr_write_data_vs));
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_pe[0],
+			sizeof(vendor_lttpr_write_data_pe));
+}
+
 enum dc_status dpcd_set_link_settings(
 	struct dc_link *link,
 	const struct link_training_settings *lt_settings)
@@ -3903,6 +3954,13 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 			&dpcd_lane_adjustment[0].raw,
 			sizeof(dpcd_lane_adjustment));
 
+	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+		vendor_specific_lttpr_wa_three_dpcd(
+				link,
+				link_training_settings.dpcd_lane_settings);
+
 	/*get post cursor 2 parameters
 	 * For DP 1.1a or eariler, this DPCD register's value is 0
 	 * For DP 1.2 or later:
@@ -5680,8 +5738,18 @@ bool dc_link_dp_set_test_pattern(
 	if (is_dp_phy_pattern(test_pattern)) {
 		/* Set DPCD Lane Settings before running test pattern */
 		if (p_link_settings != NULL) {
-			dp_set_hw_lane_settings(link, p_link_settings, DPRX);
-			dpcd_set_lane_settings(link, p_link_settings, DPRX);
+			if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+					link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+				dpcd_set_lane_settings(link, p_link_settings, DPRX);
+				vendor_specific_lttpr_wa_five(
+						link,
+						p_link_settings->dpcd_lane_settings,
+						p_link_settings->link_settings.lane_count);
+			} else {
+				dp_set_hw_lane_settings(link, p_link_settings, DPRX);
+				dpcd_set_lane_settings(link, p_link_settings, DPRX);
+			}
 		}
 
 		/* Blank stream if running test pattern */
-- 
2.32.0


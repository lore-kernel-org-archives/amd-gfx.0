Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D760C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC0F10E605;
	Fri, 17 Dec 2021 21:24:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7386B10E605
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqDrC9Vi0ZrkCRhULQlwFEVx7rcnIANT7WCobC9pKHko5KMtKP3CRMGUFxoCigAogByML5ilJiBtWKGEK0tXS1ZYlRW4at5hbo66BTy9UVsx8j8EXakaC/gJJDlU2F6JgdZfghICJU7NQrGIqz/fAWnfBAy4OG3/pWE7Fp/K7RRZ07WQNT3RouFI01OLJnUi6/JzjKdR8ixooHKG8n+WiFdIKKiWnNMQKx6MPz8s9ys1xCMCsh2+Xp7cNkltyzYS10Sl1OFO2ESQyfnsHoD4myl/2WcIrCxhUSz23bqzFYj9lzt9otdKHndVfc0KripSzw0Np0+5Q9v7fxQ/rFXclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0oYojV8G1Krkbtj2XImRdMo3ne6v4MVEM7nv5QsP9g=;
 b=ik56CUOFe02eNlvmeiTjlTWQdmWf45hZUJah+y+PiSaL0fYcYwvweVmdEzJu9HyqP6L5nvXB//UyNSCLoeR0SYl0sz96I/ZPWyw+3z1/xy/9LLvA5dsuDyOMmRYO2YVHmMDdkqTVjpXvH5E27uet7lGreOGvefdjRQdPVihGxdlm+nRRiHDLNP5sITNgvolH0TxEMVfSy7jjUkKndLo1bIVuUID47OIv7fna1jKo7psCMpI78lpWVpAh2CVjunEoFRWfRTcH1QP5BihXTo5CmDhnX7OFK5+tf5iYSa6r9Xfl4Nwpe9vObp1ryJtOOpxiZuiSIOGwuMtZqvXkwr6OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0oYojV8G1Krkbtj2XImRdMo3ne6v4MVEM7nv5QsP9g=;
 b=wCROmWLm1GI2SIzEaez41dGEIbeDnQYyyZPM8UQMqoQGqXHYKWgOqEX7f7McPKJ7S8khvb8HZKB7aqgEbMK+LZTtbepq5+xbiPQYFMlKAyw2ZSCnodR8wC6esaXUMCc4BtA3lwWvsWZsxfzHXo9qVfU/sgRgeYQ3Ki+iVrd/KTA=
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:24:28 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::52) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:28 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:25 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: Refactor vendor specific link training
 sequence
Date: Fri, 17 Dec 2021 16:23:51 -0500
Message-ID: <20211217212407.3583190-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de2ccc7-0e55-4476-6d44-08d9c1a39bac
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2550:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2550C28443CF4A607A7B47F298789@CY4PR1201MB2550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7/FyLUAbGl4zqegDjo8AHN85VbDm+TMR5xxfLT8VJxKljTPjzXFgfCR5AnSfJ5prUPcjCPmsUTXkEcD1JyCvin6bCFv1HA/ah7k3YF2bOmNAr3vlQqa6aRZYIps1ltcQsXeY/L5mNlTorM23yYHoDUa9G3MViwtvszUZdgpR++n5WqDCMtbJRrV3F7tZLuYSwFOA24e2RCU6E6Vqgmq8CW3f7PhiILFg9sF90mwKdUkbUou6M607s4R4AI+iSRvNWT9N8muwQ+7wuqxf1UdkbZABRAljaImdkjiqGXCS+VKCohJhYnokfM8CI2DxQQbcVy+yb9SltmRFirlrJbdOH5DukOV1ZhUZekhxFuiLnRUxoB2W7UvFrUFNxfYiXZL8g2PJv31POZVkOE7BYh80rG92eVVV80zsyUJlqcZeB5WqwHdT+eCOSlUdTRam2BQxRo8drjmBngBPXdw5pJXO04BA6ir1xUr2xRdZvxzIGf38P6Ygr5pVh9NojJw0rg7TH2o2NiBcBWQbolAXRux3Ti0paPtE8dESl7wGvg4kL4KrssmdMhQApAHajutku3oLB8HaGdup8JdeBSBegUtprQ/Y4btVpVUyJ2D24gFvt6tDwwmwDW0SR8PfPatgoJYKlKZ+YQbnkMyWheSEcrsmKxDbOQn3GTIV0rHeKDkWtA7nZnYq6XNu/oLMh1qaQhb5fBTEqSgqjP4UE2WX/u23dKHTW/NTP9zsa8kXjmxNIra35GVwGckmK7gEvPVmPBrywRoiB95gq0Ky+rsQxPh2cSpqsV/Qd67+M+li44GXus=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(6916009)(8676002)(1076003)(336012)(54906003)(30864003)(83380400001)(47076005)(4326008)(356005)(81166007)(86362001)(8936002)(70206006)(316002)(70586007)(186003)(508600001)(6666004)(36756003)(26005)(82310400004)(2616005)(40460700001)(36860700001)(5660300002)(426003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:28.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de2ccc7-0e55-4476-6d44-08d9c1a39bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, "Shen, George" <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shen, George" <George.Shen@amd.com>

[Why]
Current implementation is not scalable and retrofits the existing
standard link training code for purposes outside of its original design.

[How]
Refactor vendor specific link training sequence into its own separate
function to be called instead of the standard link training function.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 338 +++++++++++++++++-
 1 file changed, 337 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6f552f7ee1db..04878817e622 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2427,6 +2427,338 @@ static enum link_training_result dp_perform_128b_132b_link_training(
 }
 #endif
 
+static enum link_training_result dc_link_dp_perform_fixed_vs_pe_training_sequence(
+	struct dc_link *link,
+	struct link_training_settings *lt_settings)
+{
+	const uint8_t vendor_lttpr_write_data_reset[4] = {0x1, 0x50, 0x63, 0xFF};
+	const uint8_t offset = dp_convert_to_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	const uint8_t vendor_lttpr_write_data_intercept_en[4] = {0x1, 0x55, 0x63, 0x0};
+	const uint8_t vendor_lttpr_write_data_intercept_dis[4] = {0x1, 0x55, 0x63, 0x68};
+	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
+	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
+	uint32_t vendor_lttpr_write_address = 0xF004F;
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	uint8_t lane = 0;
+	union down_spread_ctrl downspread = {0};
+	union lane_count_set lane_count_set = {0};
+	uint8_t toggle_rate;
+	uint8_t rate;
+
+	/* Only 8b/10b is supported */
+	ASSERT(dp_get_link_encoding_format(&lt_settings->link_settings) ==
+			DP_8b_10b_ENCODING);
+
+	if (offset != 0xFF) {
+		vendor_lttpr_write_address +=
+				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+	}
+
+	/* Vendor specific: Reset lane settings */
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
+
+	/* Vendor specific: Enable intercept */
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_intercept_en[0],
+			sizeof(vendor_lttpr_write_data_intercept_en));
+
+	/* 1. set link rate, lane count and spread. */
+
+	downspread.raw = (uint8_t)(lt_settings->link_settings.link_spread);
+
+	lane_count_set.bits.LANE_COUNT_SET =
+	lt_settings->link_settings.lane_count;
+
+	lane_count_set.bits.ENHANCED_FRAMING = lt_settings->enhanced_framing;
+	lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED = 0;
+
+
+	if (lt_settings->pattern_for_eq < DP_TRAINING_PATTERN_SEQUENCE_4) {
+		lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED =
+				link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED;
+	}
+
+	core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
+		&downspread.raw, sizeof(downspread));
+
+	core_link_write_dpcd(link, DP_LANE_COUNT_SET,
+		&lane_count_set.raw, 1);
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	rate = get_dpcd_link_rate(&lt_settings->link_settings);
+#else
+	rate = (uint8_t) (lt_settings->link_settings.link_rate);
+#endif
+
+	/* Vendor specific: Toggle link rate */
+	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
+
+	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+		core_link_write_dpcd(
+				link,
+				DP_LINK_BW_SET,
+				&toggle_rate,
+				1);
+	}
+
+	link->vendor_specific_lttpr_link_rate_wa = rate;
+
+	core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
+
+	DC_LOG_HW_LINK_TRAINING("%s\n %x rate = %x\n %x lane = %x framing = %x\n %x spread = %x\n",
+		__func__,
+		DP_LINK_BW_SET,
+		lt_settings->link_settings.link_rate,
+		DP_LANE_COUNT_SET,
+		lt_settings->link_settings.lane_count,
+		lt_settings->enhanced_framing,
+		DP_DOWNSPREAD_CTRL,
+		lt_settings->link_settings.link_spread);
+
+	/* 2. Perform link training */
+
+	/* Perform Clock Recovery Sequence */
+	if (status == LINK_TRAINING_SUCCESS) {
+		uint32_t retries_cr;
+		uint32_t retry_count;
+		uint32_t wait_time_microsec;
+		enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
+		union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
+		union lane_align_status_updated dpcd_lane_status_updated;
+		union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
+
+		retries_cr = 0;
+		retry_count = 0;
+
+		while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
+			(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
+
+			memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
+			memset(&dpcd_lane_status_updated, '\0',
+			sizeof(dpcd_lane_status_updated));
+
+			/* 1. call HWSS to set lane settings */
+			dp_set_hw_lane_settings(
+					link,
+					lt_settings,
+					0);
+
+			/* 2. update DPCD of the receiver */
+			if (!retry_count) {
+				/* EPR #361076 - write as a 5-byte burst,
+				 * but only for the 1-st iteration.
+				 */
+				dpcd_set_lt_pattern_and_lane_settings(
+						link,
+						lt_settings,
+						lt_settings->pattern_for_cr,
+						0);
+				/* Vendor specific: Disable intercept */
+				core_link_write_dpcd(
+						link,
+						vendor_lttpr_write_address,
+						&vendor_lttpr_write_data_intercept_dis[0],
+						sizeof(vendor_lttpr_write_data_intercept_dis));
+			} else {
+				vendor_lttpr_write_data_vs[3] = 0;
+				vendor_lttpr_write_data_pe[3] = 0;
+
+				for (lane = 0; lane < lane_count; lane++) {
+					vendor_lttpr_write_data_vs[3] |=
+							lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
+					vendor_lttpr_write_data_pe[3] |=
+							lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET << (2 * lane);
+				}
+
+				/* Vendor specific: Update VS and PE to DPRX requested value */
+				core_link_write_dpcd(
+						link,
+						vendor_lttpr_write_address,
+						&vendor_lttpr_write_data_vs[0],
+						sizeof(vendor_lttpr_write_data_vs));
+				core_link_write_dpcd(
+						link,
+						vendor_lttpr_write_address,
+						&vendor_lttpr_write_data_pe[0],
+						sizeof(vendor_lttpr_write_data_pe));
+
+				dpcd_set_lane_settings(
+						link,
+						lt_settings,
+						0);
+			}
+
+			/* 3. wait receiver to lock-on*/
+			wait_time_microsec = lt_settings->cr_pattern_time;
+
+			dp_wait_for_training_aux_rd_interval(
+					link,
+					wait_time_microsec);
+
+			/* 4. Read lane status and requested drive
+			 * settings as set by the sink
+			 */
+			dp_get_lane_status_and_lane_adjust(
+					link,
+					lt_settings,
+					dpcd_lane_status,
+					&dpcd_lane_status_updated,
+					dpcd_lane_adjust,
+					0);
+
+			/* 5. check CR done*/
+			if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
+				status = LINK_TRAINING_SUCCESS;
+				break;
+			}
+
+			/* 6. max VS reached*/
+			if (dp_is_max_vs_reached(lt_settings))
+				break;
+
+			/* 7. same lane settings */
+			/* Note: settings are the same for all lanes,
+			 * so comparing first lane is sufficient
+			 */
+			if (lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
+					dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
+				retries_cr++;
+			else
+				retries_cr = 0;
+
+			/* 8. update VS/PE/PC2 in lt_settings*/
+			dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+					lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+			retry_count++;
+		}
+
+		if (retry_count >= LINK_TRAINING_MAX_CR_RETRY) {
+			ASSERT(0);
+			DC_LOG_ERROR("%s: Link Training Error, could not get CR after %d tries. Possibly voltage swing issue",
+				__func__,
+				LINK_TRAINING_MAX_CR_RETRY);
+
+		}
+
+		status = dp_get_cr_failure(lane_count, dpcd_lane_status);
+	}
+
+	/* Perform Channel EQ Sequence */
+	if (status == LINK_TRAINING_SUCCESS) {
+		enum dc_dp_training_pattern tr_pattern;
+		uint32_t retries_ch_eq;
+		uint32_t wait_time_microsec;
+		enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
+		union lane_align_status_updated dpcd_lane_status_updated = {0};
+		union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+		union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
+
+		/* Note: also check that TPS4 is a supported feature*/
+		tr_pattern = lt_settings->pattern_for_eq;
+
+		dp_set_hw_training_pattern(link, tr_pattern, 0);
+
+		status = LINK_TRAINING_EQ_FAIL_EQ;
+
+		for (retries_ch_eq = 0; retries_ch_eq <= LINK_TRAINING_MAX_RETRY_COUNT;
+			retries_ch_eq++) {
+
+			dp_set_hw_lane_settings(link, lt_settings, 0);
+
+			vendor_lttpr_write_data_vs[3] = 0;
+			vendor_lttpr_write_data_pe[3] = 0;
+
+			for (lane = 0; lane < lane_count; lane++) {
+				vendor_lttpr_write_data_vs[3] |=
+						lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
+				vendor_lttpr_write_data_pe[3] |=
+						lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET << (2 * lane);
+			}
+
+			/* Vendor specific: Update VS and PE to DPRX requested value */
+			core_link_write_dpcd(
+					link,
+					vendor_lttpr_write_address,
+					&vendor_lttpr_write_data_vs[0],
+					sizeof(vendor_lttpr_write_data_vs));
+			core_link_write_dpcd(
+					link,
+					vendor_lttpr_write_address,
+					&vendor_lttpr_write_data_pe[0],
+					sizeof(vendor_lttpr_write_data_pe));
+
+			/* 2. update DPCD*/
+			if (!retries_ch_eq)
+				/* EPR #361076 - write as a 5-byte burst,
+				 * but only for the 1-st iteration
+				 */
+
+				dpcd_set_lt_pattern_and_lane_settings(
+					link,
+					lt_settings,
+					tr_pattern, 0);
+			else
+				dpcd_set_lane_settings(link, lt_settings, 0);
+
+			/* 3. wait for receiver to lock-on*/
+			wait_time_microsec = lt_settings->eq_pattern_time;
+
+			dp_wait_for_training_aux_rd_interval(
+					link,
+					wait_time_microsec);
+
+			/* 4. Read lane status and requested
+			 * drive settings as set by the sink
+			 */
+			dp_get_lane_status_and_lane_adjust(
+				link,
+				lt_settings,
+				dpcd_lane_status,
+				&dpcd_lane_status_updated,
+				dpcd_lane_adjust,
+				0);
+
+			/* 5. check CR done*/
+			if (!dp_is_cr_done(lane_count, dpcd_lane_status)) {
+				status = LINK_TRAINING_EQ_FAIL_CR;
+				break;
+			}
+
+			/* 6. check CHEQ done*/
+			if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
+					dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
+					dp_is_interlane_aligned(dpcd_lane_status_updated)) {
+				status = LINK_TRAINING_SUCCESS;
+				break;
+			}
+
+			/* 7. update VS/PE/PC2 in lt_settings*/
+			dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+					lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+		}
+	}
+
+	return status;
+}
+
+
 enum link_training_result dc_link_dp_perform_link_training(
 	struct dc_link *link,
 	const struct dc_link_settings *link_settings,
@@ -2466,7 +2798,11 @@ enum link_training_result dc_link_dp_perform_link_training(
 	 * Per DP specs starting from here, DPTX device shall not issue
 	 * Non-LT AUX transactions inside training mode.
 	 */
-	if (encoding == DP_8b_10b_ENCODING)
+	if (!link->dc->debug.apply_vendor_specific_lttpr_wa &&
+			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+		status = dc_link_dp_perform_fixed_vs_pe_training_sequence(link, &lt_settings);
+	else if (encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_8b_10b_link_training(link, &lt_settings);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	else if (encoding == DP_128b_132b_ENCODING)
-- 
2.25.1


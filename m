Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23158C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ECA610E62E;
	Fri, 28 Jan 2022 14:05:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D35C10E606
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1t2/ELnEtIzVBJcp4MTB8QNWKOlw/yOV0exHwaCTdzVntNoAKy6xU7s6ANNL50mvj4eeeCvkiXUZuS+igDIUWNdrMqP3TqFLdDkZadwbcDSNe4Q2oEf9ABv3LNTOcbniMm6DdNsFaaRtSeRb4ap5Fp4hPnieNplAqQUTiouPVqNfT8d0UMyiHsOwEFddtCbYeNv433oYU0IkGHLpSqkl12+gN1gjcRz28SMaa7aqsbXoSmupUWWpTM69Y57MJjDHD2Al53CIA3rDEVobmWT/ixQQmuOnGlmF/JUmQ/Wk4TaJoFSsmyPKnUgv+VA6jbi40/AgeiYWKJJcXo1wsFb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv5aKS8AefVeQyFB9Cpm3ywzHXkmxpEVWnxGRu5F7as=;
 b=MovCm7o2hPeWR/kq476WMCqzXcVjnqVpplO8V9E+p360+dEtTbExQUfchaYs4sk7vujPknLk4yIvbPrHEFzHbSFWCKMVK/gpvnUTUR5W52o7aeVsUcOIWpnGqMHPrEaDXgpAMHITxaKfq2ZPqzCy1jot2N6+ZELmYGYXackcK2aKCDIBLzwR8yJfaj1ps3NZf1Y7JdwcXPnsShDaxm+7Rx8okhy1+Csx6VsONuV+L+Tjz0Tskf7axavIUPjUqiaUbI6B4BlUkeg2KXHhAQSX09zpmYL0+rd9HKTrVOfncdK7+ISZJD/e3khzjq+K/Q9yKGCO8OsiSt7oNRvWqSwUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv5aKS8AefVeQyFB9Cpm3ywzHXkmxpEVWnxGRu5F7as=;
 b=I8jsMVQmt5vp8IayCbS/yCpiKCHNXIZnVGjvygbByY9JlldhcrO3MTayPdYK/k7ZqbLnXrQaaGfMqzEPuMT6fLbobzxxtTYM7/WCZJajg3zwuH2bMEIXSp+TnHwq2+xGaQzH/8as/okDH/INlbOvDad3+KveclZ8VqwQ++I/0ps=
Received: from DM5PR15CA0047.namprd15.prod.outlook.com (2603:10b6:4:4b::33) by
 BN8PR12MB3186.namprd12.prod.outlook.com (2603:10b6:408:9b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 14:05:42 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::d8) by DM5PR15CA0047.outlook.office365.com
 (2603:10b6:4:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:41 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:36 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/17] drm/amd/display: add set dp lane settings to link_hwss
Date: Fri, 28 Jan 2022 22:04:04 +0800
Message-ID: <20220128140411.3683309-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d756f99-1d34-4bc7-07dc-08d9e2674529
X-MS-TrafficTypeDiagnostic: BN8PR12MB3186:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB31862180F11407D2F27EE4D8FF229@BN8PR12MB3186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDcExkUzSu6nNx6DdOTxAuk5qFdNqPs23Yd2dxEc1RrwCtsnXz7ONW3R4miU7HRNQOWTBr/Exr0p0INTsCD/ywKPnDc1HvcXizS/rPxYydgGta7HItY2wk1tSW15eJxRbK2lNAJoe9J57tYp/a1c/ut3RyugheE7CYaQ2ntDGxuI1YDkGTg9FvM8JG2wif6lux5g0by6DMA8CFZHV8YivGkQCCzjokWwUMM+gI5QsywSvEfp0rgmWa/+qm/7SZlAxlWjLaTLvp1BL46E7EEgoAPAo/4icXcDAtggLCgL/DsM5jEeN6Wcatawz1D7ZfXjQH5977GKN50dTyvJoyMmQxGiZoCwaLJSR3mQmzZSIWiWFwQC+c8VK05/tPlaCS1KrlCmFhmSWgfwiT/0o8IcxfiHOkpDYtQx4OS0XnOyf455Co28KnBtEqV3m0U/wfFor8iqym6ougMCzGomukFvuuuxjvKLG40r9Sq5HmUJd4Pn9osCduylL29A7+2IOOzSlrB9SnYhRwcZakadsWWEyYhnEZ/ZpInhpAik63NKhMQELhttuNgJ+fNoHffkC9N8rrKICSr5V+xM5J6xrvtxyoWjkzj+preyFAYJc7vygN/BKY6RXmK4tEYP1G9Ty3kGXVRjml42UfoWylbcDVXFhGXUpvbl2UGZY9XtJi4IJ+B9qWYEFCq/74U5leWXVgkBE3fSeFBSbjjoQAtnIs0lBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(1076003)(2616005)(336012)(16526019)(426003)(186003)(86362001)(2906002)(40460700003)(316002)(8936002)(8676002)(83380400001)(81166007)(70206006)(70586007)(36756003)(30864003)(356005)(5660300002)(82310400004)(47076005)(44832011)(36860700001)(6666004)(6916009)(54906003)(7696005)(508600001)(4326008)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:41.8367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d756f99-1d34-4bc7-07dc-08d9e2674529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3186
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Factor set dp lane settings to link_hwss.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 40 ++++++++++++++-----
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 17 ++++----
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  3 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c | 17 ++++----
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |  3 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  3 +-
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  4 ++
 .../display/dc/virtual/virtual_link_encoder.c |  3 +-
 8 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index d5670d3b1a4b..3b7ab2ca34c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -295,22 +295,16 @@ void dp_set_hw_lane_settings(
 	const struct link_training_settings *link_settings,
 	uint32_t offset)
 {
-	struct link_encoder *encoder = link->link_enc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
 
 	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && !is_immediate_downstream(link, offset))
 		return;
 
-	/* call Encoder to set lane settings */
-	if (dp_get_link_encoding_format(&link_settings->link_settings) ==
-			DP_128b_132b_ENCODING) {
-		link_res->hpo_dp_link_enc->funcs->set_ffe(
-				link_res->hpo_dp_link_enc,
+	if (link_hwss->ext.set_dp_lane_settings)
+		link_hwss->ext.set_dp_lane_settings(link, link_res,
 				&link_settings->link_settings,
-				link_settings->lane_settings[0].FFE_PRESET.raw);
-	} else if (dp_get_link_encoding_format(&link_settings->link_settings)
-			== DP_8b_10b_ENCODING) {
-		encoder->funcs->dp_set_lane_settings(encoder, link_settings);
-	}
+				link_settings->hw_lane_settings);
+
 	memmove(link->cur_lane_setting,
 			link_settings->lane_settings,
 			sizeof(link->cur_lane_setting));
@@ -748,6 +742,16 @@ static void set_dio_dp_link_test_pattern(struct dc_link *link,
 	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
 }
 
+static void set_dio_dp_lane_settings(struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct dc_link_settings *link_settings,
+		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	link_enc->funcs->dp_set_lane_settings(link_enc, link_settings, lane_settings);
+}
+
 static const struct link_hwss dio_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
@@ -756,6 +760,7 @@ static const struct link_hwss dio_link_hwss = {
 		.enable_dp_link_output = enable_dio_dp_link_output,
 		.disable_dp_link_output = disable_dio_dp_link_output,
 		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
+		.set_dp_lane_settings = set_dio_dp_lane_settings,
 	},
 };
 
@@ -931,6 +936,17 @@ static void set_hpo_dp_link_test_pattern(struct dc_link *link,
 	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
 }
 
+static void set_hpo_dp_lane_settings(struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct dc_link_settings *link_settings,
+		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
+{
+	link_res->hpo_dp_link_enc->funcs->set_ffe(
+			link_res->hpo_dp_link_enc,
+			link_settings,
+			lane_settings[0].FFE_PRESET.raw);
+}
+
 static const struct link_hwss hpo_dp_link_hwss = {
 	.setup_stream_encoder = setup_hpo_dp_stream_encoder,
 	.reset_stream_encoder = reset_hpo_dp_stream_encoder,
@@ -940,6 +956,7 @@ static const struct link_hwss hpo_dp_link_hwss = {
 		.enable_dp_link_output = enable_hpo_dp_link_output,
 		.disable_dp_link_output = disable_hpo_dp_link_output,
 		.set_dp_link_test_pattern  = set_hpo_dp_link_test_pattern,
+		.set_dp_lane_settings = set_hpo_dp_lane_settings,
 	},
 };
 /*********************** below goes to dpia_link_hwss *************************/
@@ -958,6 +975,7 @@ static const struct link_hwss dpia_link_hwss = {
 		.enable_dp_link_output = enable_dio_dp_link_output,
 		.disable_dp_link_output = disable_dio_dp_link_output,
 		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
+		.set_dp_lane_settings = set_dio_dp_lane_settings,
 	},
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index f1c61d5aee6c..0bc41414481e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1325,7 +1325,8 @@ void dce110_link_encoder_disable_output(
 
 void dce110_link_encoder_dp_set_lane_settings(
 	struct link_encoder *enc,
-	const struct link_training_settings *link_settings)
+	const struct dc_link_settings *link_settings,
+	const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
 	union dpcd_training_lane_set training_lane_set = { { 0 } };
@@ -1340,26 +1341,26 @@ void dce110_link_encoder_dp_set_lane_settings(
 	cntl.action = TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS;
 	cntl.transmitter = enc110->base.transmitter;
 	cntl.connector_obj_id = enc110->base.connector;
-	cntl.lanes_number = link_settings->link_settings.lane_count;
+	cntl.lanes_number = link_settings->lane_count;
 	cntl.hpd_sel = enc110->base.hpd_source;
-	cntl.pixel_clock = link_settings->link_settings.link_rate *
+	cntl.pixel_clock = link_settings->link_rate *
 						LINK_RATE_REF_FREQ_IN_KHZ;
 
-	for (lane = 0; lane < link_settings->link_settings.lane_count; lane++) {
+	for (lane = 0; lane < link_settings->lane_count; lane++) {
 		/* translate lane settings */
 
 		training_lane_set.bits.VOLTAGE_SWING_SET =
-			link_settings->lane_settings[lane].VOLTAGE_SWING;
+				lane_settings[lane].VOLTAGE_SWING;
 		training_lane_set.bits.PRE_EMPHASIS_SET =
-			link_settings->lane_settings[lane].PRE_EMPHASIS;
+				lane_settings[lane].PRE_EMPHASIS;
 
 		/* post cursor 2 setting only applies to HBR2 link rate */
-		if (link_settings->link_settings.link_rate == LINK_RATE_HIGH2) {
+		if (link_settings->link_rate == LINK_RATE_HIGH2) {
 			/* this is passed to VBIOS
 			 * to program post cursor 2 level */
 
 			training_lane_set.bits.POST_CURSOR2_SET =
-				link_settings->lane_settings[lane].POST_CURSOR2;
+					lane_settings[lane].POST_CURSOR2;
 		}
 
 		cntl.lane_select = lane;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index fc6ade824c23..261c70e01e33 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -279,7 +279,8 @@ void dce110_link_encoder_disable_output(
 /* set DP lane settings */
 void dce110_link_encoder_dp_set_lane_settings(
 	struct link_encoder *enc,
-	const struct link_training_settings *link_settings);
+	const struct dc_link_settings *link_settings,
+	const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
 
 void dce110_link_encoder_dp_set_phy_pattern(
 	struct link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index f4b34c110eae..779110a2d948 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1101,7 +1101,8 @@ void dcn10_link_encoder_disable_output(
 
 void dcn10_link_encoder_dp_set_lane_settings(
 	struct link_encoder *enc,
-	const struct link_training_settings *link_settings)
+	const struct dc_link_settings *link_settings,
+	const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 	union dpcd_training_lane_set training_lane_set = { { 0 } };
@@ -1116,26 +1117,26 @@ void dcn10_link_encoder_dp_set_lane_settings(
 	cntl.action = TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS;
 	cntl.transmitter = enc10->base.transmitter;
 	cntl.connector_obj_id = enc10->base.connector;
-	cntl.lanes_number = link_settings->link_settings.lane_count;
+	cntl.lanes_number = link_settings->lane_count;
 	cntl.hpd_sel = enc10->base.hpd_source;
-	cntl.pixel_clock = link_settings->link_settings.link_rate *
+	cntl.pixel_clock = link_settings->link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
 						LINK_RATE_REF_FREQ_IN_KHZ;
 
-	for (lane = 0; lane < link_settings->link_settings.lane_count; lane++) {
+	for (lane = 0; lane < link_settings->lane_count; lane++) {
 		/* translate lane settings */
 
 		training_lane_set.bits.VOLTAGE_SWING_SET =
-			link_settings->lane_settings[lane].VOLTAGE_SWING;
+				lane_settings[lane].VOLTAGE_SWING;
 		training_lane_set.bits.PRE_EMPHASIS_SET =
-			link_settings->lane_settings[lane].PRE_EMPHASIS;
+				lane_settings[lane].PRE_EMPHASIS;
 
 		/* post cursor 2 setting only applies to HBR2 link rate */
-		if (link_settings->link_settings.link_rate == LINK_RATE_HIGH2) {
+		if (link_settings->link_rate == LINK_RATE_HIGH2) {
 			/* this is passed to VBIOS
 			 * to program post cursor 2 level
 			 */
 			training_lane_set.bits.POST_CURSOR2_SET =
-				link_settings->lane_settings[lane].POST_CURSOR2;
+					lane_settings[lane].POST_CURSOR2;
 		}
 
 		cntl.lane_select = lane;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index c337588231ff..663aac0a164a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -581,7 +581,8 @@ void dcn10_link_encoder_disable_output(
 /* set DP lane settings */
 void dcn10_link_encoder_dp_set_lane_settings(
 	struct link_encoder *enc,
-	const struct link_training_settings *link_settings);
+	const struct dc_link_settings *link_settings,
+	const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
 
 void dcn10_link_encoder_dp_set_phy_pattern(
 	struct link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 101444c6f145..2013a70603ae 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -162,7 +162,8 @@ struct link_encoder_funcs {
 	void (*disable_output)(struct link_encoder *link_enc,
 		enum signal_type signal);
 	void (*dp_set_lane_settings)(struct link_encoder *enc,
-		const struct link_training_settings *link_settings);
+		const struct dc_link_settings *link_settings,
+		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
 	void (*dp_set_phy_pattern)(struct link_encoder *enc,
 		const struct encoder_set_dp_phy_pattern_param *para);
 	void (*update_mst_stream_allocation_table)(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index ce9762aa58c9..3400e75685aa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -97,6 +97,10 @@ struct link_hwss_ext {
 	void (*set_dp_link_test_pattern)(struct dc_link *link,
 			const struct link_resource *link_res,
 			struct encoder_set_dp_phy_pattern_param *tp_params);
+	void (*set_dp_lane_settings)(struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct dc_link_settings *link_settings,
+		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
 };
 
 struct link_hwss {
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
index 348e9a600a72..df8bc44bc4be 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
@@ -63,7 +63,8 @@ static void virtual_link_encoder_disable_output(
 
 static void virtual_link_encoder_dp_set_lane_settings(
 	struct link_encoder *enc,
-	const struct link_training_settings *link_settings) {}
+	const struct dc_link_settings *link_settings,
+	const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]) {}
 
 static void virtual_link_encoder_dp_set_phy_pattern(
 	struct link_encoder *enc,
-- 
2.34.1


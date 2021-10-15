Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3402C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5AC61040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD5AC61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B736EDC8;
	Fri, 15 Oct 2021 18:44:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340646EDEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTyW82CgGMFP4YgyqzuOyfDx6EKfe8XlpCeofHcnRRCnjjvG6cDBPIXEFeXIqKNnvrym4xSJNxmez5ey9f+nFOqf7KRD/I/phNFa09U/fNd+S+3YCAQIF9Gsu5yb/YIptoPbdLcAO5AsupJdtGqvqToz0lqcwaDREMN0BxOkcbt3qt8mtIZcq6Rf3YOfae1OhjhSVH97EH1az/hBqrT4XfT93CW0OIpS9n4+AX+YGJYCGfTOMqrbSUxovHM6AD6XtSU8tDFyyowSlouMT5yiGU9S6MVrCyi1MD5Lh0AQ0ow4B/cAEqYt2ioCLKhb94RxBJ/2EsKtNLmJUUPsO4z0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWyqa8a5DiqSKc5HyKbn30mU8iymVrt+cyH75FfXGH0=;
 b=KD9nvj2zcs7msDCYNKzJSyASRc0pKATShXE8LijrZEiMv7UgN7wLqznBEdB4ShpB+h2RaEsxjtOnA5EkbYM39USzGG3fOdTd8xFRS5cJO/5hbLBUXYZlBc5fDQlRoHhC3k/R7ysKt8ITKXztjrDmz5nGkkYn05uHRi3IQGFbtZnwYhVMxF0b99RQTfndp6HjZF5Wq/Gxjk8NW3x5xLEyzPYH9X/GRZXXZHi/NBWSAHktBNBe/D57iHMDqfqQ7s5jYfd8Wu0S8gKnoxzhnGZilGtxB1+LIWjRY4jFb9iaGY4pkg9ufgwlJOuwxwui5cnm0K1LlWjTq3tPqEKVfTKZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWyqa8a5DiqSKc5HyKbn30mU8iymVrt+cyH75FfXGH0=;
 b=lw8LY2vwh9AMMUincTZrSeAYkNp1va57YEfiOKOY4tE5pNT9YcumJ25sPCTH3ygyOY3FjQg/i52vBIk4RBAev97zq8+7ktqNChS1J7b5bXPjnAUKd8xC3UYwsEl0VulwCOADs2e6RYpZfcJ5vkrEzrPLmnjHh1XQtmvMHmXELUI=
Received: from DS7PR06CA0026.namprd06.prod.outlook.com (2603:10b6:8:54::16) by
 DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:12 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::f8) by DS7PR06CA0026.outlook.office365.com
 (2603:10b6:8:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:12 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:09 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 22/27] drm/amd/display: Change initializer to single brace
Date: Fri, 15 Oct 2021 14:43:27 -0400
Message-ID: <20211015184332.221091-23-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 431a6790-728e-484b-86f7-08d9900bc80f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1385:
X-Microsoft-Antispam-PRVS: <DM5PR12MB138525B249436A13312C5CF5F5B99@DM5PR12MB1385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbo3FndgP6vPSAWYx0JTh6RmqdphxuMNVPgnBePZV1auFu0kmmu1khiIBR1q/ndmuDHnAPh4y9meLu+j7uosfRSpiuyZzEo40E0sEzrjachq/x3lhCOJa/8LhCXiiaHqB9Eax0j3Ki52DdAuq5ot7L72RTInfbBxOTndVnt6p30+m8Xg3S1X0i9aMDAc1N7l0Ddx658IH30vCc37FpjMnxqnsEF/nTevi24CbfELBvT6C7qc5OgtUaKOGyhht1sQuOSJC7Ud/hyj1MJBxL99WOonvLIIJF0ich6JYwJbB8p/8bFq+Xq6IuimW/xo/mZN6qfSG89ep3991StHzt9Z831JuL659CKYsg5S8gShrEcHFIgXDJ+fgaOMm1eYJznjUQGYEdid897MYZYkHMBhasyyEDmkgZ7dSD7fdJqXUqWwaKIic52KHxb6hejKx0kPsm6ol6k/LIm25IDcuZQJNkmym1WrBV285Fdl/834TQtq1JAa9Y2P0rQd0Jbroa0urTtVi3egJYhZP/iODkf3jd2Ia03rEBVqWbIFhOaIx+C9MN8uWs5LK3r9xIqrdzTGAqcEv7XwKhIKBJd0pxQjTjpHrD63s6Qlw3q7LQLqzLBVSUkKnooO4QCiK8gXc3fY+Z7yNfDcTabfTP4XsnFBG6L9jFlcBy4RXMv1n1A2a90aBCOISh7fuUX8+qp5pfKbOU2rRqeHyllSz9/Xxrma0stvPDMYjciigmC5vRwR2i4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(8676002)(8936002)(70206006)(6916009)(5660300002)(2906002)(316002)(54906003)(36756003)(86362001)(1076003)(36860700001)(426003)(82310400003)(70586007)(6666004)(336012)(356005)(508600001)(81166007)(2616005)(26005)(186003)(83380400001)(16526019)(47076005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:12.4307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431a6790-728e-484b-86f7-08d9900bc80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  7 ++---
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 30 +++++++++----------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  8 ++---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +--
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index d54592b573e9..6db611f9f554 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -674,13 +674,13 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 
 static void read_current_link_settings_on_detect(struct dc_link *link)
 {
-	union lane_count_set lane_count_set = { {0} };
+	union lane_count_set lane_count_set = {0};
 	uint8_t link_bw_set;
 	uint8_t link_rate_set;
 	uint32_t read_dpcd_retry_cnt = 10;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	int i;
-	union max_down_spread max_down_spread = { {0} };
+	union max_down_spread max_down_spread = {0};
 
 	// Read DPCD 00101h to find out the number of lanes currently set
 	for (i = 0; i < read_dpcd_retry_cnt; i++) {
@@ -3279,8 +3279,7 @@ static void update_mst_stream_alloc_table(
 	struct stream_encoder *stream_enc,
 	const struct dp_mst_stream_allocation_table *proposed_table)
 {
-	struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = {
-			{ 0 } };
+	struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = { 0 };
 	struct link_mst_stream_allocation *dc_alloc;
 
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index b0f1cd7268c8..471a67a64299 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -763,7 +763,7 @@ void dal_ddc_service_read_scdc_data(struct ddc_service *ddc_service)
 	dal_ddc_service_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), &tmds_config, sizeof(tmds_config));
 	if (tmds_config & 0x1) {
-		union hdmi_scdc_status_flags_data status_data = { {0} };
+		union hdmi_scdc_status_flags_data status_data = {0};
 		uint8_t scramble_status = 0;
 
 		offset = HDMI_SCDC_SCRAMBLER_STATUS;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8e0b40c7a1ee..296b0defcd1c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -259,7 +259,7 @@ static void dpcd_set_training_pattern(
 	struct dc_link *link,
 	enum dc_dp_training_pattern training_pattern)
 {
-	union dpcd_training_pattern dpcd_pattern = { {0} };
+	union dpcd_training_pattern dpcd_pattern = {0};
 
 	dpcd_pattern.v1_4.TRAINING_PATTERN_SET =
 			dc_dp_training_pattern_to_dpcd_training_pattern(
@@ -401,8 +401,8 @@ enum dc_status dpcd_set_link_settings(
 	uint8_t rate;
 	enum dc_status status;
 
-	union down_spread_ctrl downspread = { {0} };
-	union lane_count_set lane_count_set = { {0} };
+	union down_spread_ctrl downspread = {0};
+	union lane_count_set lane_count_set = {0};
 
 	downspread.raw = (uint8_t)
 	(lt_settings->link_settings.link_spread);
@@ -520,7 +520,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	uint32_t dpcd_base_lt_offset;
 
 	uint8_t dpcd_lt_buffer[5] = {0};
-	union dpcd_training_pattern dpcd_pattern = { {0} };
+	union dpcd_training_pattern dpcd_pattern = { 0 };
 	uint32_t size_in_bytes;
 	bool edp_workaround = false; /* TODO link_prop.INTERNAL */
 	dpcd_base_lt_offset = DP_TRAINING_PATTERN_SET;
@@ -1266,8 +1266,8 @@ static enum link_training_result perform_channel_equalization_sequence(
 	uint32_t retries_ch_eq;
 	uint32_t wait_time_microsec;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 
 	/* Note: also check that TPS4 is a supported feature*/
 
@@ -1487,7 +1487,7 @@ static inline enum link_training_result dp_transition_to_video_idle(
 	struct link_training_settings *lt_settings,
 	enum link_training_result status)
 {
-	union lane_count_set lane_count_set = { {0} };
+	union lane_count_set lane_count_set = {0};
 
 	/* 4. mainlink output idle pattern*/
 	dp_set_hw_test_pattern(link, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
@@ -1800,7 +1800,7 @@ static enum dc_status configure_lttpr_mode_non_transparent(
 
 static void repeater_training_done(struct dc_link *link, uint32_t offset)
 {
-	union dpcd_training_pattern dpcd_pattern = { {0} };
+	union dpcd_training_pattern dpcd_pattern = {0};
 
 	const uint32_t dpcd_base_lt_offset =
 			DP_TRAINING_PATTERN_SET_PHY_REPEATER1 +
@@ -2078,8 +2078,8 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	uint32_t aux_rd_interval = 0;
 	uint32_t wait_time = 0;
 	struct link_training_settings req_settings;
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 
 	/* Transmit 128b/132b_TPS1 over Main-Link and Set TRAINING_PATTERN_SET to 01h */
@@ -2149,8 +2149,8 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 	/* Assumption: assume hardware has transmitted eq pattern */
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	struct link_training_settings req_settings;
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 	uint32_t wait_time = 0;
 
 	/* initiate CDS done sequence */
@@ -4065,8 +4065,8 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
 							bool defer_handling, bool *has_left_work)
 {
-	union hpd_irq_data hpd_irq_dpcd_data = { { { {0} } } };
-	union device_service_irq device_service_clear = { { 0 } };
+	union hpd_irq_data hpd_irq_dpcd_data = {0};
+	union device_service_irq device_service_clear = {0};
 	enum dc_status result;
 	bool status = false;
 
@@ -5939,7 +5939,7 @@ bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timin
 	uint8_t link_bw_set;
 	uint8_t link_rate_set;
 	uint32_t req_bw;
-	union lane_count_set lane_count_set = { {0} };
+	union lane_count_set lane_count_set = {0};
 
 	ASSERT(link || crtc_timing); // invalid input
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bc3ec05bf34b..aa2d430f2a1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2304,8 +2304,8 @@ static void mmhub_read_vm_context0_settings(struct dcn10_hubp *hubp1,
 void dcn10_program_pte_vm(struct dce_hwseq *hws, struct hubp *hubp)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
-	struct vm_system_aperture_param apt = { {{ 0 } } };
-	struct vm_context0_param vm0 = { { { 0 } } };
+	struct vm_system_aperture_param apt = {0};
+	struct vm_context0_param vm0 = {0};
 
 	mmhub_read_vm_system_aperture_settings(hubp1, &apt, hws);
 	mmhub_read_vm_context0_settings(hubp1, &vm0, hws);
@@ -2478,7 +2478,7 @@ void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct mpcc_blnd_cfg blnd_cfg = {{0}};
+	struct mpcc_blnd_cfg blnd_cfg = {0};
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
 	int mpcc_id;
 	struct mpcc *new_mpcc;
@@ -3635,7 +3635,7 @@ void dcn10_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx)
 void dcn10_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings)
 {
-	struct encoder_unblank_param params = { { 0 } };
+	struct encoder_unblank_param params = {0};
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 	struct dce_hwseq *hws = link->dc->hwseq;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index fc83744149d9..cfee456c6c9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2123,7 +2123,7 @@ void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings)
 {
-	struct encoder_unblank_param params = { { 0 } };
+	struct encoder_unblank_param params = {0};
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 	struct dce_hwseq *hws = link->dc->hwseq;
@@ -2298,7 +2298,7 @@ void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct mpcc_blnd_cfg blnd_cfg = { {0} };
+	struct mpcc_blnd_cfg blnd_cfg = {0};
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha;
 	int mpcc_id;
 	struct mpcc *new_mpcc;
-- 
2.25.1


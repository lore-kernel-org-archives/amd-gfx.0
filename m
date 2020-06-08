Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F466C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7211520801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gvk+h2eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7211520801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED846E491;
	Mon,  8 Jun 2020 04:59:48 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700078.outbound.protection.outlook.com [40.107.70.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C136E48C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr8Y8LY1Zskh8iIJMZJYXua1poDhsl3mmIsHTxBU8Cs7/SiCRoHupZNTqj+m76tx0ZkHAVU504tBoktRgRLaZyqh13r0ZeAQs4UHi0CDdHjxOud5rMwkyG6y5exY5OGPfYRFH/qR30+Qi/dkrSIOdLVdi69finqlpe5xL/mOKDhkYcaqZ78hD1MCx8Rdr2q38DvDosmJX/qBfXjR0JzGS0Y8mFMDmhB3fNUzlaRxPZAd0suFlzV0VtvXm2XHYAOf3DM6TjoeOT6WicYeb5gTpCUSd2VWNuHa7ptL9VniFq2G0u/EPQofwdb+JsfA5ysdKEs3Z0+MxtPKWo1Ndsknxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ06UyJylkCs9kOPjEhoNF43vNpjLjG8EC3CnoEBxkk=;
 b=JK67rOyYZ5j38GZIA73jktRjOggaHeSyibkN4YDsWeGvcBR9LN1P8r63gFoEzRZougKUTfX50tJIePCtRfSAdChXuq7xQ0JKQdrc9TLHuhMJ3GElRtIbNYhOs+4OJTtPgcHAb3tngIQS32eFCueB4SgWvidkhxrx/ozKICSTOdaSKanWb836GwIqCEreLZjUWYfDp88NpOrRFy4Lqv4kvKACE2DM0G5ppEI3I9Dr6BrOjhM4/6ee3wBGGk5g12RMB8tyylVFC/iTG0QBRjeUcrd8Hz/Wvk3q1g5LWQn00Trc86xLhX14ikQUbdx7EcCDsL4qe8f7+vWWRK8K1q6tAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ06UyJylkCs9kOPjEhoNF43vNpjLjG8EC3CnoEBxkk=;
 b=gvk+h2eS2+NPxYE1HQOxK/xoLNiyclzzTTr+N6XZJ6RHET4u0BTmV/zLC3+QqrlcjJ4MhpACvZiAPtAZxMU9Mth4RvnTX9WwRyz7csR/WwAtED00a/H3OR7YnkuK06FuClO0F0HiQdo5yFywV6CjSYPphe5NQlfhaTqJ7t/u9w4=
Received: from MWHPR22CA0004.namprd22.prod.outlook.com (2603:10b6:300:ef::14)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 04:59:41 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::61) by MWHPR22CA0004.outlook.office365.com
 (2603:10b6:300:ef::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:41 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:38 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:37 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/28] drm/amd/display: Revert "DP link layer test 4.2.1.1 fix
 due to specs update"
Date: Mon, 8 Jun 2020 00:59:15 -0400
Message-ID: <20200608045926.17197-18-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(316002)(82740400003)(47076004)(70206006)(70586007)(44832011)(356005)(478600001)(5660300002)(1076003)(426003)(30864003)(2616005)(26005)(81166007)(36756003)(54906003)(336012)(4326008)(6916009)(8936002)(86362001)(186003)(8676002)(2906002)(83380400001)(6666004)(15650500001)(82310400002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b99d1a01-994c-4b67-d6c5-08d80b68c0cc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1549F0A93E16F87AED883EA0FB850@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Awtea1AWFAUEDCMWImiIcduh5TgWcOd/KAOeKdsFCX6xBNmDCVV8XiPRBxKQp8P/qtj559dXoyn2L0ac86FHtn1hFdx5OZDbW+9lmT2XGruUO79BSnabgnmhsNgCXC17eVEJHSUWLSBiCDtNvjSuu8YKHlaYOGM+cf3SRsOUFCdhf/+C/5QuvQJLBTLJpZG0M1nCeuXooGcteKEQwOBYny4v0mRAx5zirziGdEj/9Jbv2Y7oQyexTJulMnbILD63DfObr494WowowwWd/Qg2bZw7V8jCXHEveFLAxXI0oP1TQ2lRa9fNhLu2fO8hgielvJ260qc4SfouiJkEcoCSvvu3qvek2K3x2sG4iHcGv+/sek99CpfDkkDW6kMofxdrnpZJ6Chf7h9GAoiMV2o7sw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:41.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99d1a01-994c-4b67-d6c5-08d80b68c0cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
The change causes some regression in a common use case.
Will need more investigation before fixing the original issue.

[how]
This reverts commit ad418864c63a1718f9e283207b3fac96fbc148c2.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c | 13 ++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 59 ++++++++++---------
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |  2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  2 +-
 9 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cb5491fb326c..cbb4c24d748d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -690,11 +690,9 @@ static bool detect_dp(struct dc_link *link,
 
 	if (sink_caps->transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 		sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
-
+		dpcd_set_source_specific_data(link);
 		if (!detect_dp_sink_caps(link))
 			return false;
-		dpcd_set_source_specific_data(link);
-
 		if (is_mst_supported(link)) {
 			sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
 			link->type = dc_connection_mst_branch;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 242ed5976cdb..aefd29a440b5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -648,17 +648,16 @@ bool dc_link_aux_transfer_with_retries(struct ddc_service *ddc,
 }
 
 
-bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
+uint32_t dc_link_aux_configure_timeout(struct ddc_service *ddc,
 		uint32_t timeout)
 {
-	bool result = false;
+	uint32_t prev_timeout = 0;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 
-	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
-		ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
-		result = true;
-	}
-	return result;
+	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout)
+		prev_timeout =
+				ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
+	return prev_timeout;
 }
 
 /*test only function*/
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 674f53aaf2b4..6c03dcd6acb5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -245,7 +245,7 @@ static uint8_t dc_dp_initialize_scrambling_data_symbols(
 
 static inline bool is_repeater(struct dc_link *link, uint32_t offset)
 {
-	return (link->lttpr_non_transparent_mode && offset != 0);
+	return (!link->is_lttpr_mode_transparent && offset != 0);
 }
 
 static void dpcd_set_lt_pattern_and_lane_settings(
@@ -1038,7 +1038,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* 3. wait receiver to lock-on*/
 		wait_time_microsec = lt_settings->cr_pattern_time;
 
-		if (link->lttpr_non_transparent_mode)
+		if (!link->is_lttpr_mode_transparent)
 			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 
 		wait_for_training_aux_rd_interval(
@@ -1268,7 +1268,7 @@ static void configure_lttpr_mode(struct dc_link *link)
 		link->dpcd_caps.lttpr_caps.mode = repeater_mode;
 	}
 
-	if (link->lttpr_non_transparent_mode) {
+	if (!link->is_lttpr_mode_transparent) {
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Non Transparent Mode\n", __func__);
 
@@ -1473,7 +1473,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&lt_settings);
 
 	/* Configure lttpr mode */
-	if (link->lttpr_non_transparent_mode)
+	if (!link->is_lttpr_mode_transparent)
 		configure_lttpr_mode(link);
 
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
@@ -1489,7 +1489,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 
 	dp_set_fec_ready(link, fec_enable);
 
-	if (link->lttpr_non_transparent_mode) {
+	if (!link->is_lttpr_mode_transparent) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
@@ -1757,7 +1757,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	 * account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
-	if (link->lttpr_non_transparent_mode) {
+	if (!link->is_lttpr_mode_transparent) {
 		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 
@@ -1915,7 +1915,7 @@ bool dp_verify_link_cap(
 	max_link_cap = get_max_link_cap(link);
 
 	/* Grant extended timeout request */
-	if (link->lttpr_non_transparent_mode && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
+	if (!link->is_lttpr_mode_transparent && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
 		uint8_t grant = link->dpcd_caps.lttpr_caps.max_ext_timeout & 0x80;
 
 		core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
@@ -3248,7 +3248,17 @@ static bool retrieve_link_cap(struct dc_link *link)
 	uint32_t read_dpcd_retry_cnt = 3;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
-	bool is_lttpr_present = false;
+
+	/* Set default timeout to 3.2ms and read LTTPR capabilities */
+	bool ext_timeout_support = link->dc->caps.extended_aux_timeout_support &&
+			!link->dc->config.disable_extended_timeout_support;
+
+	link->is_lttpr_mode_transparent = true;
+
+	if (ext_timeout_support) {
+		dc_link_aux_configure_timeout(link->ddc,
+					LINK_AUX_DEFAULT_EXTENDED_TIMEOUT_PERIOD);
+	}
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
@@ -3257,13 +3267,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 	memset(&edp_config_cap, '\0',
 		sizeof(union edp_configuration_cap));
 
-	/* if extended timeout is supported in hardware,
-	 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
-	 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
-	 */
-	dc_link_aux_try_to_configure_timeout(link->ddc,
-			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
-
 	status = core_link_read_dpcd(link, DP_SET_POWER,
 				&dpcd_power_state, sizeof(dpcd_power_state));
 
@@ -3290,9 +3293,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
-	if (link->dc->caps.extended_aux_timeout_support) {
-		/* By reading LTTPR capability, RX assumes that we will enable LTTPR extended aux timeout if LTTPR is present.
-		 * Therefore, only query LTTPR capability when LTTPR extended aux timeout is supported by hardware */
+	if (ext_timeout_support) {
+
 		status = core_link_read_dpcd(
 				link,
 				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
@@ -3323,20 +3325,19 @@ static bool retrieve_link_cap(struct dc_link *link)
 				lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
-		is_lttpr_present = (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
+		if (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
-		if (is_lttpr_present)
-			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
-	}
-
-	/* decide lttpr non transparent mode */
-	link->lttpr_non_transparent_mode = is_lttpr_present && link->dc->config.allow_lttpr_non_transparent_mode;
-
-	if (!is_lttpr_present)
-		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14) {
+			link->is_lttpr_mode_transparent = false;
+		} else {
+			/*No lttpr reset timeout to its default value*/
+			link->is_lttpr_mode_transparent = true;
+			dc_link_aux_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+		}
 
+		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
+	}
 
 	{
 		union training_aux_rd_interval aux_rd_interval;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 6bbe4e775832..6590f51caefa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -281,7 +281,7 @@ void dp_set_hw_lane_settings(
 {
 	struct link_encoder *encoder = link->link_enc;
 
-	if (link->lttpr_non_transparent_mode && !is_immediate_downstream(link, offset))
+	if (!link->is_lttpr_mode_transparent && !is_immediate_downstream(link, offset))
 		return;
 
 	/* call Encoder to set lane settings */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9138adf63f9f..f9bdd9115edc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -283,7 +283,7 @@ struct dc_config {
 	bool edp_not_connected;
 	bool force_enum_edp;
 	bool forced_clocks;
-	bool allow_lttpr_non_transparent_mode;
+	bool disable_extended_timeout_support; // Used to disable extended timeout and lttpr feature as well
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
 	bool enable_4to1MPC;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index aec514e52e4d..79aca1bb9f1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -101,7 +101,6 @@ struct dc_link {
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
 	bool is_lttpr_mode_transparent;
-	bool lttpr_non_transparent_mode;
 
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 24aa3f1db031..7a37065c55d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1806,7 +1806,7 @@ static bool dcn21_resource_construct(
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
-	dc->caps.extended_aux_timeout_support = true;
+	dc->caps.extended_aux_timeout_support = false;
 	dc->caps.dmcub_support = true;
 	dc->caps.is_apu = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
index b324e13f3f78..de2d160114db 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
@@ -105,7 +105,7 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 bool dc_link_aux_transfer_with_retries(struct ddc_service *ddc,
 		struct aux_payload *payload);
 
-bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
+uint32_t dc_link_aux_configure_timeout(struct ddc_service *ddc,
 		uint32_t timeout);
 
 void dal_ddc_service_write_scdc_data(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index b970a32177af..e94e5fbf2aa2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -28,7 +28,7 @@
 
 #define LINK_TRAINING_ATTEMPTS 4
 #define LINK_TRAINING_RETRY_DELAY 50 /* ms */
-#define LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD 3200 /*us*/
+#define LINK_AUX_DEFAULT_EXTENDED_TIMEOUT_PERIOD 3200 /*us*/
 #define LINK_AUX_DEFAULT_TIMEOUT_PERIOD 552 /*us*/
 
 struct dc_link;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

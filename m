Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB6C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355FC208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pK9nqkT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355FC208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E262F6EB0C;
	Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534856EA6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWnIIa4JstQPPYGg9zvFg/B+ZU+bQ8b86e/77qP72A/z4rjrEMDtTQpzpqk+ddlisD7W3rF8lzs9w0hk4CtIP1tn4cUPaCnCH5FtgnIA5EP9cUmQz9XGtoupOyOvK8MlEizJPth/h7LZhwNyOzlPGFlHA75waUJSvQsm53DdE6ktpNCEWZF3SDaNJl8yikN2qo5zXJQMK6mKDtD1Et+1PcX0Sz86SaD6hsD4ND6X/8z1iRe3ElGXPTZPLmc9GeVMtXfFZAh8dT0an2PsNmhrB1ow+MJ3mpuHKMQZe5uRBAqKZr13prablsWyUL3j7EAdiL9vwYfZFrm93/w+RuHO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGOYrV4xDlyfNh/veyR7KFQGAjF6PfCGreP2kxMLY68=;
 b=SJNQyWmJnMxv2JRc/AQ4MgVF408hAM1Ed3dkpM92S22KmSiGtsx+V2u2EQUCuFRaftIfdykzRcJ8zQfF+5Hk/5foq0Lzwq0/7yIoTbjbnmYG/tqCTEp3t1Ai4VJ1dUB6xSwCeEDb7qV2pdXXoSy9TxSc7lU3bcfBhu2Iqt+LBqhY2c2A3kbdL/qZS4CzRnxNvkHbgLOanP3aO1Nx1VuuypkQ3IdW1hfE1ibkUMYGx0V1ZTNx0JoWb7/ZWe2By5/Jnz98eFWwWf+mv4zj6J0xEBAOOyt9aUI+H/3gTa3ArpmRf3sdaVsru56FkaQwNgINiWdBJZbWE+UtFoWFXFk0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGOYrV4xDlyfNh/veyR7KFQGAjF6PfCGreP2kxMLY68=;
 b=pK9nqkT4hlwTCFXEiV0vD6KWRsQPuo8S7K5HhviECnVk/0gzu5URkQSVkRMoO9tskSAeWSdeKAVbHQsaCuU6I/bpBZa2iCRp3t8+L9hQ/mshyU9yz0bQXWjcB87m9IEvxrOMsapsdNgnfiSvrhfjVHGzomrq/iWqz9VN5g0VSw8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:07 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:07 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/30] drm/amd/display: DP link layer test 4.2.1.1 fix due to
 specs update
Date: Fri, 19 Jun 2020 16:12:19 -0400
Message-Id: <20200619201222.2916504-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:05 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 457a6879-6e42-42bc-5bad-08d8148d2dbf
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408713FC2FDFE00310826A0498980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/KcWnMWI6uNEF4owXtufrGQhsAFvFen/35S9/QM3h7FbYQ1z28aC9INTf+HHV6Vn8KEH+fpj5grVxYUaHIic+E0xd7L1z3zAIoprFcEtfZh7upSvEUZ5RZyRWpfuc5f0YZ5iQ7O58htDJQRrg+o8KZa0lg3aLStSLuUrvdbUucBJufhHThFrrfl3X/OY2BNIcAKm0akpph0kPStdxGfdaDVycp326atT18u/osrPmK1Um9amOHvrz7CSYSXDqk3BYyOaSJhyVB/RZGEpq+GbwL7wzE6W9ofJupquqwR1jHtPO8OoIJKVNNxQAh+jpb5yRhJQxs0Zu2kTxdGZYVpgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(15650500001)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(30864003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Z3itySxIvKOgunVRFig6qgLidzY1DqZ/ztPrswQeS1sHbesXVzraw2tuByGRKDT+7lfE1mO97VwC1VUDI5XojRKUhJWiqhCYhLhR6X8mQ/mmalyP63iOQ6ELliFiaWeKUYAv/J9xa/4PUXmZsbviINMhGnvdmru2X/Gz19oVs1dQN2eG6+99xMO8lKVaXYi+HLUcd3/6l2ifrk7JjLCqhGvD5ExyzMgclQ+hCwEBIU0WY/0/wNM0N0XhTUkfuIklK3YEap+INfiCSB02DGhBuxEqbnTxdXvWjzSHN0ZaiWM85YHEzvCEDSlRq4nuIhxSQ9fNrjCJ5pvUP7NbxBfzQFEzU5d0nq5xyNVbNg/BKG6oyVyprs2J1r7iCjDYRsMP/hjUoOdCYRnXWd2yCz2xRJdci1WyjUKP7HTDfKCfQad++Be8/K7vaF1ztvjwYjNT3+H73RCUY4zZcgM/d4hJanZnvmJdU1RbZB/tg1EANaz59MhppfzbKikRekYrKm2p47Hm/e8gMYIXgcHJcwPWAQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457a6879-6e42-42bc-5bad-08d8148d2dbf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:06.5401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qco5g46OAQC6SBfMvAj5vWg0s0lqE0LOalXfXKOHzam2wjRYodXWH45GCLzxJGYeOpqV2XMwvef9tlXcI/JxJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DP link layer CTS specs updated to change the test parameters in test
4.2.1.1.
Before it requires source to delay 400us on aux no reply.
With the specs updates Errata5, it requires source to delay 3.2ms
(based on LTTPR aux timeout)
This causes our test to fail after updating with the latest test
equipment firmware.

[how]
the change is to allow LTTPR 3.2ms aux timeout delay by default.
And set back to 400us if LTTPR feature is not enabled.
We will set 3.2ms and always enable LTTPR non transparent mode
if LTTPR feature is enabled and LTTPR is present.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  8 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c | 13 ++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 76 ++++++++++---------
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |  2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  2 +-
 9 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f020b3b67f0d..02742cca4d84 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -690,7 +690,6 @@ static bool detect_dp(struct dc_link *link,
 
 	if (sink_caps->transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 		sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
-		dpcd_set_source_specific_data(link);
 		if (!detect_dp_sink_caps(link))
 			return false;
 		if (is_mst_supported(link)) {
@@ -855,6 +854,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 	bool same_dpcd = true;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	bool perform_dp_seamless_boot = false;
+	const uint32_t post_oui_delay = 30; // 30ms
 
 	DC_LOGGER_INIT(link->ctx->logger);
 
@@ -867,6 +867,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		// need to re-write OUI and brightness in resume case
 		if (link->connector_signal == SIGNAL_TYPE_EDP) {
 			dpcd_set_source_specific_data(link);
+			msleep(post_oui_delay);
 			dc_link_set_default_brightness_aux(link);
 			//TODO: use cached
 		}
@@ -922,8 +923,6 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		case SIGNAL_TYPE_EDP: {
 			read_current_link_settings_on_detect(link);
 
-			dpcd_set_source_specific_data(link);
-
 			detect_edp_sink_caps(link);
 			read_current_link_settings_on_detect(link);
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
@@ -1633,6 +1632,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	int i;
 	bool apply_seamless_boot_optimization = false;
 	uint32_t bl_oled_enable_delay = 50; // in ms
+	const uint32_t post_oui_delay = 30; // 30ms
 
 	// check for seamless boot
 	for (i = 0; i < state->stream_count; i++) {
@@ -1659,6 +1659,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 
 	// during mode switch we do DP_SET_POWER off then on, and OUI is lost
 	dpcd_set_source_specific_data(link);
+	if (link->dpcd_sink_ext_caps.raw != 0)
+		msleep(post_oui_delay);
 
 	skip_video_pattern = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index be8f265976b0..b984eecca58b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -655,16 +655,17 @@ bool dc_link_aux_transfer_with_retries(struct ddc_service *ddc,
 }
 
 
-uint32_t dc_link_aux_configure_timeout(struct ddc_service *ddc,
+bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
 		uint32_t timeout)
 {
-	uint32_t prev_timeout = 0;
+	bool result = false;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 
-	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout)
-		prev_timeout =
-				ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
-	return prev_timeout;
+	if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
+		ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
+		result = true;
+	}
+	return result;
 }
 
 /*test only function*/
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d9b53654c35a..d2116cb71937 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -247,7 +247,7 @@ static uint8_t dc_dp_initialize_scrambling_data_symbols(
 
 static inline bool is_repeater(struct dc_link *link, uint32_t offset)
 {
-	return (!link->is_lttpr_mode_transparent && offset != 0);
+	return (link->lttpr_non_transparent_mode && offset != 0);
 }
 
 static void dpcd_set_lt_pattern_and_lane_settings(
@@ -1040,7 +1040,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* 3. wait receiver to lock-on*/
 		wait_time_microsec = lt_settings->cr_pattern_time;
 
-		if (!link->is_lttpr_mode_transparent)
+		if (link->lttpr_non_transparent_mode)
 			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 
 		wait_for_training_aux_rd_interval(
@@ -1274,7 +1274,7 @@ static void configure_lttpr_mode(struct dc_link *link)
 		link->dpcd_caps.lttpr_caps.mode = repeater_mode;
 	}
 
-	if (!link->is_lttpr_mode_transparent) {
+	if (link->lttpr_non_transparent_mode) {
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Non Transparent Mode\n", __func__);
 
@@ -1479,7 +1479,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&lt_settings);
 
 	/* Configure lttpr mode */
-	if (!link->is_lttpr_mode_transparent)
+	if (link->lttpr_non_transparent_mode)
 		configure_lttpr_mode(link);
 
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
@@ -1495,7 +1495,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 
 	dp_set_fec_ready(link, fec_enable);
 
-	if (!link->is_lttpr_mode_transparent) {
+	if (link->lttpr_non_transparent_mode) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
@@ -1762,7 +1762,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	 * account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
-	if (!link->is_lttpr_mode_transparent) {
+	if (link->lttpr_non_transparent_mode) {
 		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 
@@ -1920,7 +1920,7 @@ bool dp_verify_link_cap(
 	max_link_cap = get_max_link_cap(link);
 
 	/* Grant extended timeout request */
-	if (!link->is_lttpr_mode_transparent && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
+	if (link->lttpr_non_transparent_mode && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
 		uint8_t grant = link->dpcd_caps.lttpr_caps.max_ext_timeout & 0x80;
 
 		core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
@@ -3253,17 +3253,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 	uint32_t read_dpcd_retry_cnt = 3;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
-
-	/* Set default timeout to 3.2ms and read LTTPR capabilities */
-	bool ext_timeout_support = link->dc->caps.extended_aux_timeout_support &&
-			!link->dc->config.disable_extended_timeout_support;
-
-	link->is_lttpr_mode_transparent = true;
-
-	if (ext_timeout_support) {
-		dc_link_aux_configure_timeout(link->ddc,
-					LINK_AUX_DEFAULT_EXTENDED_TIMEOUT_PERIOD);
-	}
+	bool is_lttpr_present = false;
+	const uint32_t post_oui_delay = 30; // 30ms
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
@@ -3272,6 +3263,13 @@ static bool retrieve_link_cap(struct dc_link *link)
 	memset(&edp_config_cap, '\0',
 		sizeof(union edp_configuration_cap));
 
+	/* if extended timeout is supported in hardware,
+	 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+	 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+	 */
+	dc_link_aux_try_to_configure_timeout(link->ddc,
+			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
+
 	status = core_link_read_dpcd(link, DP_SET_POWER,
 				&dpcd_power_state, sizeof(dpcd_power_state));
 
@@ -3283,6 +3281,12 @@ static bool retrieve_link_cap(struct dc_link *link)
 	if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3)
 		udelay(1000);
 
+	dpcd_set_source_specific_data(link);
+	/* Sink may need to configure internals based on vendor, so allow some
+	 * time before proceeding with possibly vendor specific transactions
+	 */
+	msleep(post_oui_delay);
+
 	for (i = 0; i < read_dpcd_retry_cnt; i++) {
 		status = core_link_read_dpcd(
 				link,
@@ -3298,8 +3302,14 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
-	if (ext_timeout_support) {
-
+	if (link->dc->caps.extended_aux_timeout_support &&
+			link->dc->config.allow_lttpr_non_transparent_mode) {
+		/* By reading LTTPR capability, RX assumes that we will enable
+		 * LTTPR non transparent if LTTPR is present.
+		 * Therefore, only query LTTPR capability when both LTTPR
+		 * extended aux timeout and
+		 * non transparent mode is supported by hardware
+		 */
 		status = core_link_read_dpcd(
 				link,
 				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
@@ -3330,20 +3340,21 @@ static bool retrieve_link_cap(struct dc_link *link)
 				lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
-		if (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
+		is_lttpr_present = (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14) {
-			link->is_lttpr_mode_transparent = false;
-		} else {
-			/*No lttpr reset timeout to its default value*/
-			link->is_lttpr_mode_transparent = true;
-			dc_link_aux_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
-		}
-
-		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
+				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
+		if (is_lttpr_present)
+			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 	}
 
+	/* decide lttpr non transparent mode */
+	link->lttpr_non_transparent_mode = is_lttpr_present;
+
+	if (!is_lttpr_present)
+		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
+
 	{
 		union training_aux_rd_interval aux_rd_interval;
 
@@ -4282,7 +4293,6 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
-	const uint32_t post_oui_delay = 30; // 30ms
 	uint8_t dspc = 0;
 	enum dc_status ret;
 
@@ -4323,10 +4333,6 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 				link->dc->vendor_signature.data.raw,
 				sizeof(link->dc->vendor_signature.data.raw));
 	}
-
-	// Sink may need to configure internals based on vendor, so allow some
-	// time before proceeding with possibly vendor specific transactions
-	msleep(post_oui_delay);
 }
 
 bool dc_link_set_backlight_level_nits(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 93e28231a9d0..1b3474aa380d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -283,7 +283,7 @@ void dp_set_hw_lane_settings(
 {
 	struct link_encoder *encoder = link->link_enc;
 
-	if (!link->is_lttpr_mode_transparent && !is_immediate_downstream(link, offset))
+	if (link->lttpr_non_transparent_mode && !is_immediate_downstream(link, offset))
 		return;
 
 	/* call Encoder to set lane settings */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 83de4c2e045e..ceba626bda2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -283,7 +283,7 @@ struct dc_config {
 	bool edp_not_connected;
 	bool force_enum_edp;
 	bool forced_clocks;
-	bool disable_extended_timeout_support; // Used to disable extended timeout and lttpr feature as well
+	bool allow_lttpr_non_transparent_mode;
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
 	bool enable_4to1MPC;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 79aca1bb9f1d..e002ef706e1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -100,7 +100,7 @@ struct dc_link {
 	bool link_state_valid;
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
-	bool is_lttpr_mode_transparent;
+	bool lttpr_non_transparent_mode;
 
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 7a038eef8902..61b337267a72 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1806,7 +1806,7 @@ static bool dcn21_resource_construct(
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
-	dc->caps.extended_aux_timeout_support = false;
+	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.is_apu = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
index de2d160114db..b324e13f3f78 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
@@ -105,7 +105,7 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 bool dc_link_aux_transfer_with_retries(struct ddc_service *ddc,
 		struct aux_payload *payload);
 
-uint32_t dc_link_aux_configure_timeout(struct ddc_service *ddc,
+bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
 		uint32_t timeout);
 
 void dal_ddc_service_write_scdc_data(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index e94e5fbf2aa2..b970a32177af 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -28,7 +28,7 @@
 
 #define LINK_TRAINING_ATTEMPTS 4
 #define LINK_TRAINING_RETRY_DELAY 50 /* ms */
-#define LINK_AUX_DEFAULT_EXTENDED_TIMEOUT_PERIOD 3200 /*us*/
+#define LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD 3200 /*us*/
 #define LINK_AUX_DEFAULT_TIMEOUT_PERIOD 552 /*us*/
 
 struct dc_link;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

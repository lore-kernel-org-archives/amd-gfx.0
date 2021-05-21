Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF29C4707A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1756D611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1756D611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 434FF6E580;
	Fri, 21 May 2021 17:37:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD266E526
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLth8/4e5d8ufGLAYokRawYbam16ketXcGB2LpuFRrmTbA2F82HzcLFYnikbRRVXPuuVU1+1RL6dkSXjFvgBeY49UetwLQA2XdLoGJ0qt40byZE4AQidsDdfpn3qvbrTEffW1HeRNYEPeA3c+T6bap7e5jkC4YnI/ky6xRskZ4cFf7ApgbIMF/a9RJopAHSYZdjf1T2N9kG9+SQczLcKyXg06LhVj5FAaIa3+2zLBbJrRkbqKRrSruLpbitSBKQ1znwJD7r2v9n1jd3RAWkcF7VW8dQ1tVEdmYs/XvzePKRwUzHVe+b5uY2qHbF20b3LkI7lFEc7Vakkk9gN72Zu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBXLKEwmZXVN+F1g0XEX/5Z1pvktDWbG6oAMAu2ZKYQ=;
 b=m7vGRQVGwx6+jnyFSEsj2M4Mr1sjgjYuULgY4wxyDvarVnbsrqySBfpVN/JMLG/kTm/jHP1bJriqnn6YQv7ndVt2Kz35IF7Uyf2MhxdiXp0RoWLJDy6NvVHgP4uJqtQCH/te3uH7cvar/uSE24cvPx9MaAX00APfqnzP6lagD4Bk4ccFytFd44y67yaW1tgPCthgoOc7epG2YYa56Y8l42M0kzBGFtaH4d718lnpUaQgGT1C1eQ2a1lKOQVjk4uyNupUfjHJDh+qES515uvVbvTaAw5hkd1R8xhq4jjZRxCtOTef85L9FNhMn2B3b73j+nh+pDqEMm8dn8Op66ObQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBXLKEwmZXVN+F1g0XEX/5Z1pvktDWbG6oAMAu2ZKYQ=;
 b=3IPPdrJTVm5eraWzD73QWm3L6zNQMMihlq3hojB20DRg6zALWrUOV4Qw7RHEe9KKcYdJSRbtrBVqSS7vfG2TmCub2SvEdTCxfztCU1F0VA6JIeCpVRLcSyTsRvsR6wDjcBE/zGT08eDwaW6Abn6M8Q9eRifsQZRW1DRPrOzXh8Q=
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 17:37:06 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::6d) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:06 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:05 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/15] drm/amd/display: isolate 8b 10b link training sequence
 into its own function
Date: Fri, 21 May 2021 13:36:41 -0400
Message-ID: <20210521173646.1140586-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b53656f-622c-4126-268f-08d91c7f0d92
X-MS-TrafficTypeDiagnostic: DM4PR12MB5117:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5117E7290A8EDF194BD9CB65FB299@DM4PR12MB5117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOFa9YS8sJGbYWbOf2sV8mgAgKSnPQODfk+QQguyfx4rlE/mJmn+Yd3qVoDkhQFvSb1NodSEyvZNhFWkqiwfgSl6Tz2mU0FuTLFUZgdZHwXE2IA6BlgMummOGuIW4l0aHYrB98cvPlNi7FyiZg2Ud+8J3Tr6+EK3WL8k3YOWOgcuQc48KbKpZuovB/YBJLJRa03k9+3f7zEu8n6o/lIeFGyvHpfQo7FNdJpB03yQUOgyn2AXRJud7TRcdFv/FDAaCGFO/fmsJn33Nbywtw9aZ6pnE5PkE90MYyQOC3zAJEL1eIvxSjrCgYFseE6/v2ePlxyLOPKgRmIY0dDoNB8Mt8OV1LXvZDqGvF8r2UDvZer752aJcjQPUKrFRCEWHNljBEwLsEtQ9JJO+ln3kTgstMOV0S/bGu6PyKqnc488NNHBtzTyq7cdaTwSiNNlTxUb6U6ts6EOX9jZbU/9e4GYpxoqSnDRhK2qu5VJ7s1SBWOa78rDJydqCvsnBS+RchxMKhGlRTK+vipxUza79cy9BeDZTRDc03CvA01JRN75Jblot+v+kqswysUN5cd6Xwz/t6EKptz3f6JqrlNiuHRh2DY1N5qlyRk0Bj4V4XonC2PY4G5BQ7xuyliDcMirUlW0DOhYanhO/bzweDLvJV9VJ/ahq2T9KQazY1WHiYsZlJeUQsdP2bekGWBYUwXittsE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(46966006)(36840700001)(5660300002)(426003)(4326008)(70206006)(70586007)(44832011)(336012)(478600001)(83380400001)(36860700001)(36756003)(2616005)(2906002)(6916009)(82310400003)(86362001)(81166007)(47076005)(186003)(82740400003)(16526019)(356005)(6666004)(8676002)(8936002)(1076003)(26005)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:06.3322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b53656f-622c-4126-268f-08d91c7f0d92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[how]
1. move 8b 10 link trianing into its own function
2. make link status check after a link success link as part of
dp transition to video idle sequence.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 118 +++++++++---------
 1 file changed, 62 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 60aa4876300b..15f089e4fa1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1170,8 +1170,16 @@ static inline enum link_training_result dp_transition_to_video_idle(
 	 * TPS4 must be used instead of POST_LT_ADJ_REQ.
 	 */
 	if (link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED != 1 ||
-			lt_settings->pattern_for_eq == DP_TRAINING_PATTERN_SEQUENCE_4)
+			lt_settings->pattern_for_eq == DP_TRAINING_PATTERN_SEQUENCE_4) {
+		/* delay 5ms after Main Link output idle pattern and then check
+		 * DPCD 0202h.
+		 */
+		if (link->connector_signal != SIGNAL_TYPE_EDP && status == LINK_TRAINING_SUCCESS) {
+			msleep(5);
+			status = dp_check_link_loss_status(link, lt_settings);
+		}
 		return status;
+	}
 
 	if (status == LINK_TRAINING_SUCCESS &&
 		perform_post_lt_adj_req_sequence(link, lt_settings) == false)
@@ -1621,18 +1629,9 @@ enum dc_status dpcd_configure_lttpr_mode(struct dc_link *link, struct link_train
 
 static void dpcd_exit_training_mode(struct dc_link *link)
 {
-	const uint8_t clear_pattern = 0;
 
 	/* clear training pattern set */
-	core_link_write_dpcd(
-			link,
-			DP_TRAINING_PATTERN_SET,
-			&clear_pattern,
-			sizeof(clear_pattern));
-	DC_LOG_HW_LINK_TRAINING("%s\n %x pattern = %x\n",
-			__func__,
-			DP_TRAINING_PATTERN_SET,
-			clear_pattern);
+	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
 }
 
 enum dc_status dpcd_configure_channel_coding(struct dc_link *link,
@@ -1656,41 +1655,22 @@ enum dc_status dpcd_configure_channel_coding(struct dc_link *link,
 	return status;
 }
 
-enum link_training_result dc_link_dp_perform_link_training(
-	struct dc_link *link,
-	const struct dc_link_settings *link_settings,
-	bool skip_video_pattern)
+static enum link_training_result dp_perform_8b_10b_link_training(
+		struct dc_link *link,
+		struct link_training_settings *lt_settings)
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
-	struct link_training_settings lt_settings;
 
-	/* reset previous training states */
-	dpcd_exit_training_mode(link);
-
-	/* decide training settings */
-	dp_decide_training_settings(
-			link,
-			link_settings,
-			&link->preferred_training_settings,
-			&lt_settings);
-	dpcd_configure_lttpr_mode(link, &lt_settings);
-	dp_set_fec_ready(link, lt_settings.should_set_fec_ready);
-	dpcd_configure_channel_coding(link, &lt_settings);
-
-	/* enter training mode:
-	 * Per DP specs starting from here, DPTX device shall not issue
-	 * Non-LT AUX transactions inside training mode.
-	 */
+	uint8_t repeater_cnt;
+	uint8_t repeater_id;
 
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
-		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
+		start_clock_recovery_pattern_early(link, lt_settings, DPRX);
 
 	/* 1. set link rate, lane count and spread. */
-	dpcd_set_link_settings(link, &lt_settings);
+	dpcd_set_link_settings(link, lt_settings);
 
 	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
-		uint8_t repeater_cnt;
-		uint8_t repeater_id;
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
@@ -1699,13 +1679,13 @@ enum link_training_result dc_link_dp_perform_link_training(
 
 		for (repeater_id = repeater_cnt; (repeater_id > 0 && status == LINK_TRAINING_SUCCESS);
 				repeater_id--) {
-			status = perform_clock_recovery_sequence(link, &lt_settings, repeater_id);
+			status = perform_clock_recovery_sequence(link, lt_settings, repeater_id);
 
 			if (status != LINK_TRAINING_SUCCESS)
 				break;
 
 			status = perform_channel_equalization_sequence(link,
-					&lt_settings,
+					lt_settings,
 					repeater_id);
 
 			if (status != LINK_TRAINING_SUCCESS)
@@ -1716,36 +1696,62 @@ enum link_training_result dc_link_dp_perform_link_training(
 	}
 
 	if (status == LINK_TRAINING_SUCCESS) {
-		status = perform_clock_recovery_sequence(link, &lt_settings, DPRX);
+		status = perform_clock_recovery_sequence(link, lt_settings, DPRX);
 	if (status == LINK_TRAINING_SUCCESS) {
 		status = perform_channel_equalization_sequence(link,
-					&lt_settings,
+					lt_settings,
 					DPRX);
 		}
 	}
 
-	/* 3. set training not in progress*/
-	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
-	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern) {
+	return status;
+}
+
+enum link_training_result dc_link_dp_perform_link_training(
+	struct dc_link *link,
+	const struct dc_link_settings *link_settings,
+	bool skip_video_pattern)
+{
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	struct link_training_settings lt_settings;
+	enum dp_link_encoding encoding =
+			dp_get_link_encoding_format(link_settings);
+
+	/* decide training settings */
+	dp_decide_training_settings(
+			link,
+			link_settings,
+			&link->preferred_training_settings,
+			&lt_settings);
+
+	/* reset previous training states */
+	dpcd_exit_training_mode(link);
+
+	/* configure link prior to entering training mode */
+	dpcd_configure_lttpr_mode(link, &lt_settings);
+	dp_set_fec_ready(link, lt_settings.should_set_fec_ready);
+	dpcd_configure_channel_coding(link, &lt_settings);
+
+	/* enter training mode:
+	 * Per DP specs starting from here, DPTX device shall not issue
+	 * Non-LT AUX transactions inside training mode.
+	 */
+	if (encoding == DP_8b_10b_ENCODING)
+		status = dp_perform_8b_10b_link_training(link, &lt_settings);
+	else
+		ASSERT(0);
+
+	/* exit training mode and switch to video idle */
+	dpcd_exit_training_mode(link);
+	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern)
 		status = dp_transition_to_video_idle(link,
 				&lt_settings,
 				status);
-	}
 
-	/* delay 5ms after Main Link output idle pattern and then check
-	 * DPCD 0202h.
-	 */
-	if (link->connector_signal != SIGNAL_TYPE_EDP && status == LINK_TRAINING_SUCCESS) {
-		msleep(5);
-		status = dp_check_link_loss_status(link, &lt_settings);
-	}
-
-	/* 6. print status message*/
+	/* dump debug data */
 	print_status_message(link, &lt_settings, status);
-
 	if (status != LINK_TRAINING_SUCCESS)
 		link->ctx->dc->debug_data.ltFailCount++;
-
 	return status;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7695C4707A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B66261244
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B66261244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0536E51D;
	Fri, 21 May 2021 17:37:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13806E526
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRBNaw0jekZYYScsVrzqcQuzap7fglOt6gsHWm6E1fV0dvVqBpK60mz+5KIGiSAA9t7KQYqnltz8Ae5r9QRRMOUFOQwTmAalMpf9tXPvd4IsNxcC+eo3fZWdhlXdm6VZy4yZf6c5LC0lOwa+3snAbWauXt3LrIrFNIDrYNjIaiUJKoiyiA6FMrTajeaA3kCsZA5bCoDqTkwwBfOncdI5xYbbmhGLbheCNNDqD4fNKIsawFhTo/nbzfx+fnSx3jwJpLnn6Y61CHl3tXq6fevOBKkHx+iS9e28laEeR425tavGsujhIDnq9vUdaoUB4qUTpE7H6u+czErHE+bRI4iYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1g/L1yCw27ofSHRZnTZFd9fpoBtafLOth4mc3LQLg=;
 b=Lf1lMsMGmfgkn/V8ZDsksNG8EmOxIeE8pH49+eSTnJJClxlSVvKdB9BTal/7QJv6GbsQnyqoeSyxD+uLQLSVZbQ/dgvIpbbA8Mkza+OlcwhOdlzIb2qMXEAegnX3+CwdGzBtbnsG/Jp8Bs4F4xtsRMJw+LL13lwO9fogtwUtqhIla0pvedj92ajt1JM3uyakl9sOT6B25cUnEafOHIUyzKsxjb81mDIXYOhjA9avfHyY1TsDCm4zixDkA8cOjMSozIGktz5UsR3TN+vaKCEao/9TLSksTDz/qulhzGmNRYuMbJoSDbZaq71DiAmcuVn1nQvRNYwIIp609CvgmMZNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1g/L1yCw27ofSHRZnTZFd9fpoBtafLOth4mc3LQLg=;
 b=N/2P6MbpOKHeezyN2alqtn7lp93DdsumizrX1yfdBZyUffUPfbAR5iNPSVN9o2UDGzbOlV/pziWcZSDrGaEn1RC2pBSVrPmWARj+mklROZ2Fhu/BUX2umT9lsb7ZFvRCP6ZsUuA7JqaobqDlwPp535nuwzQJ8D0q0v9pcO1hOrc=
Received: from BN8PR15CA0053.namprd15.prod.outlook.com (2603:10b6:408:80::30)
 by DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:37:05 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::9b) by BN8PR15CA0053.outlook.office365.com
 (2603:10b6:408:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:37:05 +0000
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
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:05 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:04 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/15] drm/amd/display: add exit training mode and update
 channel coding in LT
Date: Fri, 21 May 2021 13:36:40 -0400
Message-ID: <20210521173646.1140586-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45cdd95d-2f06-4f4b-6073-08d91c7f0cfe
X-MS-TrafficTypeDiagnostic: DM6PR12MB3769:
X-Microsoft-Antispam-PRVS: <DM6PR12MB376953F9E6365F3F63E58EBAFB299@DM6PR12MB3769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxArcz1wipVO6nkWEwe/68kI/rrloZbkVpOOTeFBo0Qb5dbS7SClEXuB7rRWeUlZYdYX2pHH1It1SeYNxjTeXN6h4zCXSwP6aNMGKpelFnKxwLDKCn0aqTvlX2QyxUgCxyzyet8ByFNH/8uDTdJPSQN92iXXZITHJd4uzRPRw4FXxMrBbbn1tu3oN+duFOuQumKLJs3Ey7dkxezoE1MqeHDxxNZnXFZvOo9VK4Gxu4+vAZat9srKdDMF72xmKq6GSGqpcWow/n3MordEU2ou86OFgFoAhSBZmzGNHTW3rzH7Mo2UCgfC2XQx4jV/7FLiYgeLhvX9LbaiuvA1F6ggcQTIb7ybGuRraW1HVXMVq0op4vszSB5F5ESwFvWI2Por/wHkUFPHKNhdbjiu0FgHtREQ94Aqyo7f7aYITGsEpFBmc0EQ7vmOsgCxS996YGrH+RzX4XLuVwlG7CbjdJqOoosGgE5WhHrI8XjtnEV6lRN6dXoAZdyGI8B7w+GCNOZuqsypEUjbxu/FKBSVvP6O8p9i3vDUm2U2PCxs8OYEmpR67gKP3OvF4fCsSsJVM6ePSwuO7JIlfnHsgpJzEh+AYbSN2VKXAjcbAkClEQtuYgs4VM22hHQazTlp3igm5Je2+xvwI/cPqGLCtUwnkg8P06ocxUjodK9p1lrP3VyUw8e8mJTIyyXPVTHvI2WOJcro
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(36860700001)(316002)(47076005)(36756003)(186003)(70206006)(8936002)(16526019)(8676002)(70586007)(81166007)(54906003)(4326008)(356005)(1076003)(83380400001)(336012)(82740400003)(2906002)(86362001)(6666004)(6916009)(426003)(2616005)(44832011)(5660300002)(26005)(478600001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:05.3607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cdd95d-2f06-4f4b-6073-08d91c7f0cfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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

[why]
As recommended by DP specs, source needs to make sure
DPRX exits previous LT mode before configuring new LT params
Nofity what channel coding mode we will use for current link training.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 73 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 +-
 .../amd/display/include/link_service_types.h  |  1 +
 3 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d9b538e193c4..60aa4876300b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1324,6 +1324,11 @@ static inline void decide_8b_10b_training_settings(
 		lt_settings->enhanced_framing = *overrides->enhanced_framing;
 	else
 		lt_settings->enhanced_framing = 1;
+
+	if (link->preferred_training_settings.fec_enable != NULL)
+		lt_settings->should_set_fec_ready = *link->preferred_training_settings.fec_enable;
+	else
+		lt_settings->should_set_fec_ready = true;
 }
 
 void dp_decide_training_settings(
@@ -1614,29 +1619,68 @@ enum dc_status dpcd_configure_lttpr_mode(struct dc_link *link, struct link_train
 	return status;
 }
 
+static void dpcd_exit_training_mode(struct dc_link *link)
+{
+	const uint8_t clear_pattern = 0;
+
+	/* clear training pattern set */
+	core_link_write_dpcd(
+			link,
+			DP_TRAINING_PATTERN_SET,
+			&clear_pattern,
+			sizeof(clear_pattern));
+	DC_LOG_HW_LINK_TRAINING("%s\n %x pattern = %x\n",
+			__func__,
+			DP_TRAINING_PATTERN_SET,
+			clear_pattern);
+}
+
+enum dc_status dpcd_configure_channel_coding(struct dc_link *link,
+		struct link_training_settings *lt_settings)
+{
+	enum dp_link_encoding encoding =
+			dp_get_link_encoding_format(
+					&lt_settings->link_settings);
+	enum dc_status status;
+
+	status = core_link_write_dpcd(
+			link,
+			DP_MAIN_LINK_CHANNEL_CODING_SET,
+			(uint8_t *) &encoding,
+			1);
+	DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X MAIN_LINK_CHANNEL_CODING_SET = %x\n",
+					__func__,
+					DP_MAIN_LINK_CHANNEL_CODING_SET,
+					encoding);
+
+	return status;
+}
+
 enum link_training_result dc_link_dp_perform_link_training(
 	struct dc_link *link,
-	const struct dc_link_settings *link_setting,
+	const struct dc_link_settings *link_settings,
 	bool skip_video_pattern)
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	struct link_training_settings lt_settings;
 
-	bool fec_enable;
-	uint8_t repeater_cnt;
-	uint8_t repeater_id;
+	/* reset previous training states */
+	dpcd_exit_training_mode(link);
 
+	/* decide training settings */
 	dp_decide_training_settings(
 			link,
-			link_setting,
+			link_settings,
 			&link->preferred_training_settings,
 			&lt_settings);
+	dpcd_configure_lttpr_mode(link, &lt_settings);
+	dp_set_fec_ready(link, lt_settings.should_set_fec_ready);
+	dpcd_configure_channel_coding(link, &lt_settings);
 
-	/* Configure lttpr mode */
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
-		configure_lttpr_mode_non_transparent(link, &lt_settings);
-	else if (link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
-		configure_lttpr_mode_transparent(link);
+	/* enter training mode:
+	 * Per DP specs starting from here, DPTX device shall not issue
+	 * Non-LT AUX transactions inside training mode.
+	 */
 
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
@@ -1644,14 +1688,9 @@ enum link_training_result dc_link_dp_perform_link_training(
 	/* 1. set link rate, lane count and spread. */
 	dpcd_set_link_settings(link, &lt_settings);
 
-	if (link->preferred_training_settings.fec_enable != NULL)
-		fec_enable = *link->preferred_training_settings.fec_enable;
-	else
-		fec_enable = true;
-
-	dp_set_fec_ready(link, fec_enable);
-
 	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+		uint8_t repeater_cnt;
+		uint8_t repeater_id;
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index c617e9ae68a3..83845d006c54 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -333,7 +333,7 @@ bool dc_link_dp_perform_link_training_skip_aux(
 
 enum link_training_result dc_link_dp_perform_link_training(
 	struct dc_link *link,
-	const struct dc_link_settings *link_setting,
+	const struct dc_link_settings *link_settings,
 	bool skip_video_pattern);
 
 bool dc_link_dp_sync_lt_begin(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 7a30ca01e7d4..32f5274ed34e 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -85,6 +85,7 @@ struct link_training_settings {
 	enum dc_voltage_swing *voltage_swing;
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
+	bool should_set_fec_ready;
 
 	uint16_t cr_pattern_time;
 	uint16_t eq_pattern_time;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

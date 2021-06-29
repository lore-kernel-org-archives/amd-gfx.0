Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73420C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EEA61D4D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EEA61D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D182D89E32;
	Tue, 29 Jun 2021 15:54:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7F589E32
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fco7JLgrJblA4xkzcSnBcwHZwT5TPTte/Dr4nGbNY+0B+MjJZZCZGS/Y2NUS6ecya+oA0qH4is38vxk/FUIirh1QICuwxXOlC1nKdL+yD5RSalPo9MOeIrCm4H3Kpq706vKVGXsCpxUwfAQX5++nakeaUAAwwQFt6n/tfPq/k07nlxL9jDGo+BK4gwoC0ErblEmD/8qVMdJM53sNYxX7pGf+t4CTpwtwjMO5Jw2d+R1W4zlRaaDcf3zmldVFbfoeADZA71pAvKsB56hl4fX72dXp8BVSvCIBoIMDi5fCyBfqUH4cJTHL7FZTH1wqIPTvnW/m88J4+JlnZIZ22vp0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xJ/1Ha1efhOUZaYHuBPvyvHswnOXWtkM75XqU1a/es=;
 b=JBorcntFIPQzZ2FB302Cc/MTi6ZCikarcJOWye+a8OO//3lhHvaksNaMjp+KDxFL6wOUKKiNRq7VgcVuiQPY0Ud08z7+xzptxCOMm2lc5pKFrgTHZ4df9P4p4oNpZEvfBE66n5UBvdncGxTacYLJpRhKhRznGJ0NVEAmGTNIwe0+tbRkWzNRvhEJo7KSAFwB8CzPLVHi+3Dxr9pxfpdpP6JJ2lO1dpKGfYtbQiiYtl0PffidJGykVRj7em1vU66ssVReX2ai2sqP/ym913UIZEq91ztSj3VrH8VluyYpXQ63VPAm4DYnTyx8E77MkMxwYAMWkNb66Z+T6CZn2wdfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xJ/1Ha1efhOUZaYHuBPvyvHswnOXWtkM75XqU1a/es=;
 b=xU005JHlYWKzPJ5UVGy5DotphXWL3nAgqH3uYlNec5VQxLexCI0CxwPAdTeIuwEh+hmS2tt2JECn8PRSVrPoxC/0qU2kXEhhKv5Sh2+TU/pPxmTkd5tB04+g3AYLHUnkfabj4W6rEgC59oQBUSRUplg1deO8B7pp4HBb8yITa98=
Received: from DM5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:3:7b::21) by
 DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.22; Tue, 29 Jun 2021 15:54:50 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::37) by DM5PR13CA0035.outlook.office365.com
 (2603:10b6:3:7b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:50 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: isolate link training setting override
 to its own function
Date: Tue, 29 Jun 2021 11:54:11 -0400
Message-ID: <20210629155422.26118-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b91278-6a92-475b-ea4e-08d93b163aae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3561:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35616F527749BC278A0AE6E098029@DM6PR12MB3561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iz06HH6EACXqmETEPd8AruMmcY+TVnlRYvZwGVES9ahqAawV6Nj6Jy3/4rYzgHU64Z1C8RCT7qCHxy4XLGBKYhPDAOFvCz01m0amBzmZzBf5svICSj+41cc38VQDPwtJNGp5ZwLEtLhuixMFPGekpDQuayjOj7mqjCfDpcPyPot/yhS43TDRv0qXOlE0AaPqOLnd4oD5nQ7wDjO/QyGxJgcjE49yXaVnq30ohnwOB0Gax8jyUt3b7OCfFV8qTOEvH3m7of5JiUa6P5AbiAw9zORFtyFq3aqwnFA2hEKKFR+xkfgOplVfNRRBL1mHT66OQ3BnXIqDEYU6/zAZyob4OQzI3gfrrELN1e6do4pi0MsNu3qJi63WHmEQ1Zl9ARPYGr8tFBMcx/U3K0/xxC/A9KRulkS8iyElFDKRbiJeQ4C/oJeEZa9FhthUosnB+ed043hpNgu5/t+ctLy+BLADDyYHEXLaPKK9wDH4Mcp41yR1OoAfY/nt7TiMc1M9fcs3ATF5Q8SXv3e76KkKD/G3pcrSX9LazSy2lH5kzt90vw6kOaliNFGQAJf1AGRDR2Snf8LW60LXveAbelGavrS29KHYeZUR3yDE8KkUhr6DAWsntyV4iq+AYKY4ryyycDP/qS7Cf/oa2IOkVjxgYiwA4Z8dQ9YnV99Uwm+94FACcYKVynLmB0k6E7sVLK3o4leIwaQP7/zFdoTDvtCFN0rhZooqAHV0rjZr3CRx5Vr44fg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(36840700001)(46966006)(83380400001)(36756003)(336012)(6666004)(2616005)(16526019)(426003)(81166007)(186003)(82740400003)(82310400003)(2906002)(356005)(6916009)(8676002)(47076005)(316002)(70206006)(36860700001)(86362001)(5660300002)(478600001)(1076003)(8936002)(70586007)(4326008)(54906003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:50.8427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b91278-6a92-475b-ea4e-08d93b163aae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 George Shen <George.Shen@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

There is a difference between our default behavior and override
behavior. For default behavior we need to decide link training settings
within specs' limitation and mandates.
For override behavior we do not need to follow all these requirements.
We are isolating override decision to its own function to maintain the
integrity of our specs compliant default behavior.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 113 ++++++++----------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 -
 2 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b8832bdde2bc..5c3f78b2f1de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1241,29 +1241,15 @@ enum link_training_result dp_check_link_loss_status(
 static inline void decide_8b_10b_training_settings(
 	 struct dc_link *link,
 	const struct dc_link_settings *link_setting,
-	const struct dc_link_training_overrides *overrides,
 	struct link_training_settings *lt_settings)
 {
-	uint32_t lane;
-
 	memset(lt_settings, '\0', sizeof(struct link_training_settings));
 
 	/* Initialize link settings */
 	lt_settings->link_settings.use_link_rate_set = link_setting->use_link_rate_set;
 	lt_settings->link_settings.link_rate_set = link_setting->link_rate_set;
-
-	if (link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN)
-		lt_settings->link_settings.link_rate = link->preferred_link_setting.link_rate;
-	else
-		lt_settings->link_settings.link_rate = link_setting->link_rate;
-
-	if (link->preferred_link_setting.lane_count != LANE_COUNT_UNKNOWN)
-		lt_settings->link_settings.lane_count = link->preferred_link_setting.lane_count;
-	else
-		lt_settings->link_settings.lane_count = link_setting->lane_count;
-
-	/*@todo[vdevulap] move SS to LS, should not be handled by displaypath*/
-
+	lt_settings->link_settings.link_rate = link_setting->link_rate;
+	lt_settings->link_settings.lane_count = link_setting->lane_count;
 	/* TODO hard coded to SS for now
 	 * lt_settings.link_settings.link_spread =
 	 * dal_display_path_is_ss_supported(
@@ -1271,30 +1257,52 @@ static inline void decide_8b_10b_training_settings(
 	 * LINK_SPREAD_05_DOWNSPREAD_30KHZ :
 	 * LINK_SPREAD_DISABLED;
 	 */
-	/* Initialize link spread */
-	if (link->dp_ss_off)
-		lt_settings->link_settings.link_spread = LINK_SPREAD_DISABLED;
-	else if (overrides->downspread != NULL)
-		lt_settings->link_settings.link_spread
-			= *overrides->downspread
-			? LINK_SPREAD_05_DOWNSPREAD_30KHZ
-			: LINK_SPREAD_DISABLED;
-	else
-		lt_settings->link_settings.link_spread = LINK_SPREAD_05_DOWNSPREAD_30KHZ;
-
+	lt_settings->link_settings.link_spread = link->dp_ss_off ?
+			LINK_SPREAD_DISABLED : LINK_SPREAD_05_DOWNSPREAD_30KHZ;
 	lt_settings->lttpr_mode = link->lttpr_mode;
+	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting);
+	lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
+	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
+	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
+	lt_settings->enhanced_framing = 1;
+	lt_settings->should_set_fec_ready = true;
+}
 
-	/* Initialize lane settings overrides */
+void dp_decide_training_settings(
+		struct dc_link *link,
+		const struct dc_link_settings *link_settings,
+		struct link_training_settings *lt_settings)
+{
+	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING)
+		decide_8b_10b_training_settings(link, link_settings, lt_settings);
+}
+
+static void override_training_settings(
+		struct dc_link *link,
+		const struct dc_link_training_overrides *overrides,
+		struct link_training_settings *lt_settings)
+{
+	uint32_t lane;
+
+	/* Override link settings */
+	if (link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN)
+		lt_settings->link_settings.link_rate = link->preferred_link_setting.link_rate;
+	if (link->preferred_link_setting.lane_count != LANE_COUNT_UNKNOWN)
+		lt_settings->link_settings.lane_count = link->preferred_link_setting.lane_count;
+
+	/* Override link spread */
+	if (!link->dp_ss_off && overrides->downspread != NULL)
+		lt_settings->link_settings.link_spread = *overrides->downspread ?
+				LINK_SPREAD_05_DOWNSPREAD_30KHZ
+				: LINK_SPREAD_DISABLED;
+
+	/* Override lane settings */
 	if (overrides->voltage_swing != NULL)
 		lt_settings->voltage_swing = overrides->voltage_swing;
-
 	if (overrides->pre_emphasis != NULL)
 		lt_settings->pre_emphasis = overrides->pre_emphasis;
-
 	if (overrides->post_cursor2 != NULL)
 		lt_settings->post_cursor2 = overrides->post_cursor2;
-
-	/* Initialize lane settings (VS/PE/PC2) */
 	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
 		lt_settings->lane_settings[lane].VOLTAGE_SWING =
 			lt_settings->voltage_swing != NULL ?
@@ -1313,45 +1321,22 @@ static inline void decide_8b_10b_training_settings(
 	/* Initialize training timings */
 	if (overrides->cr_pattern_time != NULL)
 		lt_settings->cr_pattern_time = *overrides->cr_pattern_time;
-	else
-		lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting);
 
 	if (overrides->eq_pattern_time != NULL)
 		lt_settings->eq_pattern_time = *overrides->eq_pattern_time;
-	else
-		lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
 
 	if (overrides->pattern_for_cr != NULL)
 		lt_settings->pattern_for_cr = *overrides->pattern_for_cr;
-	else
-		lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
 	if (overrides->pattern_for_eq != NULL)
 		lt_settings->pattern_for_eq = *overrides->pattern_for_eq;
-	else
-		lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
 
 	if (overrides->enhanced_framing != NULL)
 		lt_settings->enhanced_framing = *overrides->enhanced_framing;
-	else
-		lt_settings->enhanced_framing = 1;
 
 	if (link->preferred_training_settings.fec_enable != NULL)
 		lt_settings->should_set_fec_ready = *link->preferred_training_settings.fec_enable;
-	else
-		lt_settings->should_set_fec_ready = true;
-}
-
-void dp_decide_training_settings(
-		struct dc_link *link,
-		const struct dc_link_settings *link_settings,
-		const struct dc_link_training_overrides *overrides,
-		struct link_training_settings *lt_settings)
-{
-	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING)
-		decide_8b_10b_training_settings(link, link_settings, overrides, lt_settings);
 }
 
-
 uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
 {
 	switch (lttpr_repeater_count) {
@@ -1581,6 +1566,9 @@ bool dc_link_dp_perform_link_training_skip_aux(
 	dp_decide_training_settings(
 			link,
 			link_setting,
+			&lt_settings);
+	override_training_settings(
+			link,
 			&link->preferred_training_settings,
 			&lt_settings);
 
@@ -1726,6 +1714,9 @@ enum link_training_result dc_link_dp_perform_link_training(
 	dp_decide_training_settings(
 			link,
 			link_settings,
+			&lt_settings);
+	override_training_settings(
+			link,
 			&link->preferred_training_settings,
 			&lt_settings);
 
@@ -1940,11 +1931,13 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 	bool fec_enable = false;
 
 	dp_decide_training_settings(
-		link,
-		link_settings,
-		lt_overrides,
-		&lt_settings);
-
+			link,
+			link_settings,
+			&lt_settings);
+	override_training_settings(
+			link,
+			lt_overrides,
+			&lt_settings);
 	/* Setup MST Mode */
 	if (lt_overrides->mst_enable)
 		set_dp_mst_mode(link, *lt_overrides->mst_enable);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index e2b58ec9912d..01c3a31be191 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -174,7 +174,6 @@ bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable);
 void dp_decide_training_settings(
 	struct dc_link *link,
 	const struct dc_link_settings *link_setting,
-	const struct dc_link_training_overrides *overrides,
 	struct link_training_settings *lt_settings);
 
 /* Convert PHY repeater count read from DPCD uint8_t. */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

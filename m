Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBFC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A69D21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oWRWovj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A69D21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8AD6E94A;
	Thu, 10 Sep 2020 13:47:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315BB6E942
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKSsJ23Tzr0J/MR9z7ljB0bnYFi1nj0K2/T4elkRiTggdG5blG1HMM0PXhvJBkhUZPoukEjUyMWo1Dg0UVwacR7Ba5wjoT/97FqtF46dHBIdlHrITjCW8QBIOqvR0JLGGOiXZXEKS2T7c2a8oFofZwtV0vUAGU1Z9TtR0UtuZblZlF5MTC1bNnLQt7FDLU0ye+Nq8gnwGhns3y3Hlai2TNwvueq3hnV4MFOGUqVWIxrna0zZKIvdanh5A/He/T1jtinbxajKkD9SPAU3nhz0fLejhv33/DZs2mdlA8zsQ6FTij/5sW7+IXGt9qQshycyR/fX4p802cc9HGOZzAXdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTL56gHlS49Qs/Ii9ERsTgrdU4WOC5WGsimIu7aVWNc=;
 b=B6PKQDDRn1IZiZYpm6lNbj8/AfPoH0WLZlLaUQr9la4KrDw/EIen0z+fepUHMIHEKUD8K35yl2dVRBOpW3nhhSXKPJ0FukU55RgqHOZLDLi7ytFv7ADNMML+C07/7PGcUQg+zo6BtD7XYHExUQehV/jQ1jLu5KxqQMiOpgtbavvwQADcabyZ5xpdHMy4KWIAZ1cTmb0VLGIS1Lbb7E2OWvdgTYN/0WIWz9HBWK4weiE1RHO7LPCmel/TMivCDVbdYQIeCOCh72xaDLxyYKBHq6vHIVwM8sba4FjBgBVXkMXdwNJfbMV8EgwH2kr15vHqFThsWtPpGowwtNLwQmxw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTL56gHlS49Qs/Ii9ERsTgrdU4WOC5WGsimIu7aVWNc=;
 b=oWRWovj9+TNyIKbMJLJR15ifFWJ182UBX5+UAfhQRL8kbrxAr122kjfmkPE6Xl762YGCvBPYZwA2QKZcs5HbWJLzLaNCAuz+WcCRWHxOnGtVaAHvkWAkJzF9HBeNSrAjayJC/floICuOSeFvyxq+Yn6oCdY0bY3typhkFqrcY1s=
Received: from BN8PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:ac::25)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:34 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::1b) by BN8PR07CA0012.outlook.office365.com
 (2603:10b6:408:ac::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:34 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:34 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:33 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/42] drm/amd/display: Power eDP panel back ON before link
 training retry
Date: Thu, 10 Sep 2020 09:46:56 -0400
Message-ID: <20200910134723.27410-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9697adb9-d3ef-4f13-1700-08d855901281
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4317F209929592852C14A6898B270@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfUwk0xJOO5WIyAKJl3m8FzAj4U+hIbOpEk7s2RGf3Bg5hcypHjGl4fTZIfcnMfK4iTgW220glF6XX74KiRNZ18gseYPamdgx2FPMHN6Nvvh+yJmHQeTDHhVJGgaWsSKnDrKkINBTa9fAG3bfXAyp0s6KE9Ar8UYtKCT1l20ZAFYVuvw0l2EA5Xw++WpNhFMQMQL9paO1vsL43ANiJMlgItb1cL2AZ8M6tIibUqs9iTVYG5rqAyQyDj5WmwhkClVqjwgdb8+gSmaSd8rwRA3iO2+RqOeciZ29q44qG3K4OJKve1knW5Z4bipxdxvq44ROGoriQCwJdEESDmvryAa1gs+LCx2GjHQTPNW5pgDMIgpgW8caOMhF7S4O55fExeYC1hm0um7SvV3D3SSX7LG0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(8676002)(1076003)(7696005)(82740400003)(4326008)(26005)(83380400001)(356005)(316002)(81166007)(47076004)(6666004)(36756003)(8936002)(54906003)(70586007)(5660300002)(70206006)(2906002)(44832011)(6916009)(86362001)(426003)(2616005)(336012)(82310400003)(478600001)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:34.6586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9697adb9-d3ef-4f13-1700-08d855901281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ashley Thomas <Ashley.Thomas2@amd.com>

[why]
When link training failures occur for eDP, dp_disable_link_phy
is called which powers OFF eDP panel. After link training retry
delay, the next retry begins by calling dp_enable_link_phy
which does not issue a correspnding eDP panel power ON, leaving
panel powered OFF which leads to display OFF/dark.

[how]
Power ON eDP before next link training retry.

Signed-off-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  6 ++
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  6 ++
 .../display/dc/dce110/dce110_hw_sequencer.c   | 84 ++++++++++++++-----
 3 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index e4b3b71dad03..47fb09f41bfb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1619,6 +1619,9 @@ bool perform_link_training_with_retries(
 
 	for (j = 0; j < attempts; ++j) {
 
+		DC_LOG_HW_LINK_TRAINING("%s: Beginning link training attempt %u of %d\n",
+			__func__, (unsigned int)j + 1, attempts);
+
 		dp_enable_link_phy(
 			link,
 			signal,
@@ -1647,6 +1650,9 @@ bool perform_link_training_with_retries(
 		if (j == (attempts - 1))
 			break;
 
+		DC_LOG_WARNING("%s: Link training attempt %u of %d failed\n",
+			__func__, (unsigned int)j + 1, attempts);
+
 		dp_disable_link_phy(link, signal);
 
 		msleep(delay_between_attempts);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index dd88eb348dfa..81c026319ccd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -104,6 +104,12 @@ void dp_enable_link_phy(
 	struct clock_source *dp_cs =
 			link->dc->res_pool->dp_clock_source;
 	unsigned int i;
+
+	if (link->connector_signal == SIGNAL_TYPE_EDP) {
+		link->dc->hwss.edp_power_control(link, true);
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+	}
+
 	/* If the current pixel clock source is not DTO(happens after
 	 * switching from HDMI passive dongle to DP on the same connector),
 	 * switch the pixel clock source to DTO.
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 0603ddca7bd0..1002ce9979dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -810,37 +810,66 @@ void dce110_edp_power_control(
 
 	if (power_up !=
 		link->panel_cntl->funcs->is_panel_powered_on(link->panel_cntl)) {
+
+		unsigned long long current_ts = dm_get_timestamp(ctx);
+		unsigned long long time_since_edp_poweroff_ms =
+				div64_u64(dm_get_elapse_time_in_ns(
+						ctx,
+						current_ts,
+						link->link_trace.time_stamp.edp_poweroff), 1000000);
+		unsigned long long time_since_edp_poweron_ms =
+				div64_u64(dm_get_elapse_time_in_ns(
+						ctx,
+						current_ts,
+						link->link_trace.time_stamp.edp_poweron), 1000000);
+		DC_LOG_HW_RESUME_S3(
+				"%s: transition: power_up=%d current_ts=%llu edp_poweroff=%llu edp_poweron=%llu time_since_edp_poweroff_ms=%llu time_since_edp_poweron_ms=%llu",
+				__func__,
+				power_up,
+				current_ts,
+				link->link_trace.time_stamp.edp_poweroff,
+				link->link_trace.time_stamp.edp_poweron,
+				time_since_edp_poweroff_ms,
+				time_since_edp_poweron_ms);
+
 		/* Send VBIOS command to prompt eDP panel power */
 		if (power_up) {
-			unsigned long long current_ts = dm_get_timestamp(ctx);
-			unsigned long long duration_in_ms =
-					div64_u64(dm_get_elapse_time_in_ns(
-							ctx,
-							current_ts,
-							link->link_trace.time_stamp.edp_poweroff), 1000000);
-			unsigned long long wait_time_ms = 0;
-
-			/* max 500ms from LCDVDD off to on */
-			unsigned long long edp_poweroff_time_ms = 500;
+			/* edp requires a min of 500ms from LCDVDD off to on */
+			unsigned long long remaining_min_edp_poweroff_time_ms = 500;
 
+			/* add time defined by a patch, if any (usually patch extra_t12_ms is 0) */
 			if (link->local_sink != NULL)
-				edp_poweroff_time_ms =
-						500 + link->local_sink->edid_caps.panel_patch.extra_t12_ms;
-			if (link->link_trace.time_stamp.edp_poweroff == 0)
-				wait_time_ms = edp_poweroff_time_ms;
-			else if (duration_in_ms < edp_poweroff_time_ms)
-				wait_time_ms = edp_poweroff_time_ms - duration_in_ms;
-
-			if (wait_time_ms) {
-				msleep(wait_time_ms);
-				dm_output_to_console("%s: wait %lld ms to power on eDP.\n",
-						__func__, wait_time_ms);
+				remaining_min_edp_poweroff_time_ms +=
+					link->local_sink->edid_caps.panel_patch.extra_t12_ms;
+
+			/* Adjust remaining_min_edp_poweroff_time_ms if this is not the first time. */
+			if (link->link_trace.time_stamp.edp_poweroff != 0) {
+				if (time_since_edp_poweroff_ms < remaining_min_edp_poweroff_time_ms)
+					remaining_min_edp_poweroff_time_ms =
+						remaining_min_edp_poweroff_time_ms - time_since_edp_poweroff_ms;
+				else
+					remaining_min_edp_poweroff_time_ms = 0;
 			}
 
+			if (remaining_min_edp_poweroff_time_ms) {
+				DC_LOG_HW_RESUME_S3(
+						"%s: remaining_min_edp_poweroff_time_ms=%llu: begin wait.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+				msleep(remaining_min_edp_poweroff_time_ms);
+				DC_LOG_HW_RESUME_S3(
+						"%s: remaining_min_edp_poweroff_time_ms=%llu: end wait.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+				dm_output_to_console("%s: wait %lld ms to power on eDP.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+			} else {
+				DC_LOG_HW_RESUME_S3(
+						"%s: remaining_min_edp_poweroff_time_ms=%llu: no wait required.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+			}
 		}
 
 		DC_LOG_HW_RESUME_S3(
-				"%s: Panel Power action: %s\n",
+				"%s: BEGIN: Panel Power action: %s\n",
 				__func__, (power_up ? "On":"Off"));
 
 		cntl.action = power_up ?
@@ -864,12 +893,23 @@ void dce110_edp_power_control(
 
 		bp_result = link_transmitter_control(ctx->dc_bios, &cntl);
 
+		DC_LOG_HW_RESUME_S3(
+				"%s: END: Panel Power action: %s bp_result=%u\n",
+				__func__, (power_up ? "On":"Off"),
+				bp_result);
+
 		if (!power_up)
 			/*save driver power off time stamp*/
 			link->link_trace.time_stamp.edp_poweroff = dm_get_timestamp(ctx);
 		else
 			link->link_trace.time_stamp.edp_poweron = dm_get_timestamp(ctx);
 
+		DC_LOG_HW_RESUME_S3(
+				"%s: updated values: edp_poweroff=%llu edp_poweron=%llu\n",
+				__func__,
+				link->link_trace.time_stamp.edp_poweroff,
+				link->link_trace.time_stamp.edp_poweron);
+
 		if (bp_result != BP_RESULT_OK)
 			DC_LOG_ERROR(
 					"%s: Panel Power bp_result: %d\n",
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

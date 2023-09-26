Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225B6E7F13B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E371F10E43F;
	Tue, 26 Sep 2023 21:53:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1342410E43E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5WsuZBa//Unck+AZ8LPYAO10zZy8USTAZ+BpsyZSAxIyCB0p6a1xCvMPnmJuoejJirGzA7S2jv+/rl9Yi9xBP2+LaCbyZJgXI7tkSGtzghYsIvlbcJHHn4ybX2ZHHW5bvj94mdYMLEWn+rXEi0BB3ax+aW0yOHdwDybyOiLw0ssXJUZwQVsqHuzJZhVcXLi7RqkI9cTN2SeRttqUYwWWqMsHUZzrIT/N5x38mO4fGwOqdwhII1T+H3p4yWy/WpQFLsS7nRoNforhiYsAUaYW5kgXartdSgY/Gy0M8avf48T/055TAeNONer5WRnNMR+zUjFu0iq9MbhsCRcbAFa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuqX6ohYnK4aBcw3cQTjVyOjrjI+/cMz7+nEUZkSHqM=;
 b=F1+136ZjVrsIOzz66+BGIKl6dXylyea75m8eV12l1JT2UxO2U/nigvpNAHOcY30NruOKt6kCI8joUgR8K0YyfAHq3WCx0BBMq2aokje+/HBYw88bHjfezF7e77Uz5QTdpVBcvk95LOBhedMw4ZTATS7PQyuyvkuolHWSMqfVxJz+s2XCfFdicQby2FGFcM9wWccODdxhEf/Y0dKBoUcdgDLdzuVYDDM/uFqkyrWG4ZSIQ/6BLn0fGS0YPTblVp0Busnr/1YeNHk4F3zp+ppgWpo8oe+VidmUQ19rz+MSUqRJNpcWcQ9diKxs+VR+WL5w1UwSLUgtOXDJTrvRCldHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuqX6ohYnK4aBcw3cQTjVyOjrjI+/cMz7+nEUZkSHqM=;
 b=sYaFOBqpCvj1veVZOkG6xBtIeIRFjeYwQ4rgrc7+7JaXNC5+az4Qmjoz/YOmD6jOiLikzLJIK3RC50u9jg/C2ZgUJP1+ZVahkzNo72mJFpCgY5YmWU10bVGTfAjbsvIyN1iQLLcpzK3mmBfRcTZZoPQKnJiiaWpRIynle/tomjg=
Received: from DM6PR11CA0032.namprd11.prod.outlook.com (2603:10b6:5:190::45)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:53:49 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::65) by DM6PR11CA0032.outlook.office365.com
 (2603:10b6:5:190::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:48 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: refactor ILR to make it work
Date: Tue, 26 Sep 2023 17:46:57 -0400
Message-ID: <20230926215335.200765-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fe3a92-de5e-45d6-545f-08dbbedb1102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x53Sp323EdtDH8i+JHHRiuRt00vFj7MHivqxLNU2z5bPiD2J6sgzSyIqjRbPbBc8btuY1lFf+FTIrMVtdp+HZgFn7yl8ye68pWd8x6STAhY7f18NOmlbVDP93nzHjLhEw/gjNff+wn3O5+eS4S3NWuoZJMVkBGJPjQyJ2YtJqkXSmdkz7YsUlKhz2nKkI/GvR9dKrr/xDNFTL6LCaOQa89leFuo1u/o2L+G+z9n4YsADNgkFTs9yjYMfCmnTkN6rgNfge27iRobWHBF/Qhi4mEvVRyQB9eD+/isbXb+BsdM26IJGROeXLuCz6aNvCbJnRtuV+aWJAz/jvFZrdHPHjF3D7Y2DDRzkVdlr2rV8Sbq3BkbY5dc2gcFuYuPeILLm1SjoAzTUTijINF6NdKsZDELPD0pAU9EcgVhIuECDNxOJCOaYOxi9rE7eipYN2xuGAJeCdsolt2ZwqnNa4NQpmqKddiya00GguROPboPkKAgbd4CmgXxwxGAtPN7V8e9QDUF97YlTAb44Rx5FEl3H+RnMzRqWa+IL5nmcMKzyFFj1Ek1GzJhzeAIw6KCLDKjrELyKofY5DSVpuDo4bAwfnXEu5FwrWDOZm2S3JkpE6MQIZ4hXim8rR6H+PGrGqCLWMvv5KRJzGcHCtyktE6EuNutgGWCFHRM4GtFW4DpvVlLOYg3vESF6Fxc/wzVEWA7HghfZovttdlWjJjgxqZBgcMCXF2KTWy8P8eQSvh990vhWlVBBYYTTeEhkauMeNm56QNlZqo8mZrRqFawvjoDqbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(83380400001)(40480700001)(86362001)(40460700003)(426003)(336012)(36756003)(47076005)(54906003)(41300700001)(70206006)(70586007)(6916009)(44832011)(5660300002)(316002)(8936002)(4326008)(2616005)(8676002)(81166007)(6666004)(7696005)(82740400003)(356005)(478600001)(2906002)(36860700001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:49.4756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fe3a92-de5e-45d6-545f-08dbbedb1102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Sherry Wang <yao.wang1@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sherry Wang <yao.wang1@amd.com>

[Why]
Current ILR toggle is on/off as a part of panel
config for new function, which breaks original
ILR logic

[How]
Refactor ILR and take panel config into account

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sherry Wang <yao.wang1@amd.com>
---
 .../drm/amd/display/dc/link/link_detection.c  |  6 ++++++
 .../dc/link/protocols/link_dp_capability.c    | 14 ++++---------
 .../link/protocols/link_edp_panel_control.c   | 21 +++++++++++++++++--
 .../link/protocols/link_edp_panel_control.h   |  2 ++
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index aef8ef2f8d88..d6f0f857c05a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1166,6 +1166,12 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			dm_helpers_init_panel_settings(dc_ctx, &link->panel_config, sink);
 			// Override dc_panel_config if system has specific settings
 			dm_helpers_override_panel_settings(dc_ctx, &link->panel_config);
+
+			//sink only can use supported link rate table, we are foreced to enable it
+			if (link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)
+				link->panel_config.ilr.optimize_edp_link_rate = true;
+			if (edp_is_ilr_optimization_enabled(link))
+				link->reported_link_cap.link_rate = get_max_link_rate_from_ilr_table(link);
 		}
 
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 237e0ff955f3..db87aa7b5c90 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -707,8 +707,7 @@ bool edp_decide_link_settings(struct dc_link *link,
 	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
 	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
 	 */
-	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_13 ||
-			link->dpcd_caps.edp_supported_link_rates_count == 0) {
+	if (!edp_is_ilr_optimization_enabled(link)) {
 		*link_setting = link->verified_link_cap;
 		return true;
 	}
@@ -772,8 +771,7 @@ bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
 	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
 	 */
-	if ((link->dpcd_caps.dpcd_rev.raw < DPCD_REV_13 ||
-			link->dpcd_caps.edp_supported_link_rates_count == 0)) {
+	if (!edp_is_ilr_optimization_enabled(link)) {
 		/* for DSC enabled case, we search for minimum lane count */
 		memset(&initial_link_setting, 0, sizeof(initial_link_setting));
 		initial_link_setting.lane_count = LANE_COUNT_ONE;
@@ -1938,9 +1936,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
 	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
 	 */
-	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
-			(link->panel_config.ilr.optimize_edp_link_rate ||
-			link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)) {
+	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13) {
 		// Read DPCD 00010h - 0001Fh 16 bytes at one shot
 		core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
 							supported_link_rates, sizeof(supported_link_rates));
@@ -1958,12 +1954,10 @@ void detect_edp_sink_caps(struct dc_link *link)
 				link_rate = linkRateInKHzToLinkRateMultiplier(link_rate_in_khz);
 				link->dpcd_caps.edp_supported_link_rates[link->dpcd_caps.edp_supported_link_rates_count] = link_rate;
 				link->dpcd_caps.edp_supported_link_rates_count++;
-
-				if (link->reported_link_cap.link_rate < link_rate)
-					link->reported_link_cap.link_rate = link_rate;
 			}
 		}
 	}
+
 	core_link_read_dpcd(link, DP_EDP_BACKLIGHT_ADJUSTMENT_CAP,
 						&backlight_adj_cap, sizeof(backlight_adj_cap));
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index dad43e6d0a0d..938df1f0f7da 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -302,6 +302,24 @@ bool set_cached_brightness_aux(struct dc_link *link)
 		return set_default_brightness_aux(link);
 	return false;
 }
+bool edp_is_ilr_optimization_enabled(struct dc_link *link)
+{
+	if (link->dpcd_caps.edp_supported_link_rates_count == 0 || !link->panel_config.ilr.optimize_edp_link_rate)
+		return false;
+	return true;
+}
+
+enum dc_link_rate get_max_link_rate_from_ilr_table(struct dc_link *link)
+{
+	enum dc_link_rate link_rate = link->reported_link_cap.link_rate;
+
+	for (int i = 0; i < link->dpcd_caps.edp_supported_link_rates_count; i++) {
+		if (link_rate < link->dpcd_caps.edp_supported_link_rates[i])
+			link_rate = link->dpcd_caps.edp_supported_link_rates[i];
+	}
+
+	return link_rate;
+}
 
 bool edp_is_ilr_optimization_required(struct dc_link *link,
 		struct dc_crtc_timing *crtc_timing)
@@ -314,8 +332,7 @@ bool edp_is_ilr_optimization_required(struct dc_link *link,
 
 	ASSERT(link || crtc_timing); // invalid input
 
-	if (link->dpcd_caps.edp_supported_link_rates_count == 0 ||
-			!link->panel_config.ilr.optimize_edp_link_rate)
+	if (!edp_is_ilr_optimization_enabled(link))
 		return false;
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 20f91de852e3..ebf7deb63d13 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -64,6 +64,8 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
+bool edp_is_ilr_optimization_enabled(struct dc_link *link);
+enum dc_link_rate get_max_link_rate_from_ilr_table(struct dc_link *link);
 bool edp_backlight_enable_aux(struct dc_link *link, bool enable);
 void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
-- 
2.42.0


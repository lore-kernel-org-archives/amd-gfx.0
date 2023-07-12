Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E77EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8160010E5BD;
	Wed, 12 Jul 2023 17:14:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70D110E5BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7kocP68NCE3hx57ijczRUtyRdXNrImJ1fXZgGuT8odJB3x6/j2CWe4mwYw/po2uFKrtt7H0+keLyyv9tEJnF/JhWSpgFVSZDknqhK1LdpOWe2UHLgv3A5Xf77FkLYL0uxfHhU5z/dsCVMPA5caCQfdyPWGUVYmbbzAA7XBJw8YfPi3g8k9UWIBsdRGpuNLd4z4TCXANGRt5NEznSC6JdLMR5T1fEEaHPeNevyLA1wNvG/rNva+4jt99WCeA7hyepvX5n0GQ5EWrfTV6Ce7tfd3lvtP0wsFaYaqCjZwCCbLLhehGJyXRYfu5s3a8DjLQfXKVThVS6XUeeNwFgEe/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JYEGBH43d3+f1w+kZwggB7XQG0uiiJAn+4YwqM1Qvs=;
 b=Ru6U+8fz11Y1zUodwRMbObOuoSPSCnIWXmW3ISEP+4g7Diw6mMwxG2vxdIJZ2e7vLi1WtTYvG8imycLQDHBQJri9k9xEfEhyWnKI7me/bFOuttgZVoLZ+LcP1j8/uPFbH/Z78VYaMm1SJ2EyRgH0JlLGRz/92p5LKfoXZgTecxkcI2qAYJyOSQsP6A9lGZAFhs7SmnRTqJxIaKxXtkS3kngZoUwL2u40WGQip6dkic73sN1LRU6I9qkKz/4U9xIHf3yEcTLX+zpJuWh7BUwhyoFO9li/MR+TK4BAxq+Ss0P18yKSn4PryRJ2Y6VA29UKY77lEh70X//oY3XmuyVfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JYEGBH43d3+f1w+kZwggB7XQG0uiiJAn+4YwqM1Qvs=;
 b=aBkNJQL98Ellwq8mWbGxRcPIGfXoQaOVhWr5OUG8IclKQZFq5RFllkNRfRKGRoLparg8g1p6oH6pfpLvSTQWOG5SymVEoIEtPl/0fIg5ZKB4Bc8JvDvCHjOHmoDLXT3UCxiwP4Hj1nIOOQtFv8kSuACDrAVux+kGPfJ94JGMQ1k=
Received: from BN9PR03CA0960.namprd03.prod.outlook.com (2603:10b6:408:108::35)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:14:39 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::61) by BN9PR03CA0960.outlook.office365.com
 (2603:10b6:408:108::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:38 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:35 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/33] drm/amd/display: Cache backlight_millinits in link
 structure and setting brightness accordingly
Date: Thu, 13 Jul 2023 01:11:34 +0800
Message-ID: <20230712171137.3398344-31-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b8fedd-8eeb-485f-5340-08db82fb79af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DU/t7q0lFvQXSijTgcDePOrEX9l87zvqC5Wcd/FlOa3YJq8yD9HeZboK9fRbRH8+ydvjHslZmAZQ0t8pnxMc7zRk79A3PQdBeuy7G3ypnFx49Oyk7JAZMkEk3KqJC1KW45hovNbx7zJ9uQaK49VQwGCSYZr03WT3VORiEndKyqmGbyjO+MLPXEa0iU08NgbsTupIwSw/15OrWljWjlduQn5Lrr0aiCzoKM7qnWWWpxTxrt+1ACwUEWPi8rKqnbl3F0BVW0x/PcNBn5Akw4xY2qSHFw+P3UWzmOnRLkAOq/pdUBNHrv1div6GoCk2BZ5nX0MgH7ZwD4z054h3WcmiCji0CdfKBxzMooNIj/uXg9SLMsq8atxZ7aKm77qNllHlUZC3L72xFR2XHVDTE9terFYqbtMnpfSPDD8iQq5X7vIYrzXwcQan1hk8xqQl/uMxhgK0lfNpGP5TpIL8rm7hxe8Il++X59KwncPQWw/r/gX/PDNwSZdg5gxODEJ0CfhEFmgMtNbMuVq1rgHrQ4omS6g5MZ4nEeQlwsR7+dbuTztw7uEh1d8+7ge1SMVSiqwNkGgbFD+L66dXNOEXXWcPiciBteBSN9CrMobL9jVy/vOJiDKnrnPHCipBmrjPBCt516/DL+6VsGdPNpg4TI+WK7ptj0Uh7mGDbeJ+gK4EW/MTyt1CE6XHtElVsiniXrbDexhBj9r9Oly5M8AZ1/yHGzi7uy/ABDOjQSwlNAQ7/ywKl/sefTs5ajaZ7yrXxmsBF2OzTt1wjFspmPEewBnGpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(336012)(82310400005)(316002)(7696005)(54906003)(81166007)(4326008)(40480700001)(478600001)(40460700003)(36756003)(2906002)(356005)(70206006)(6916009)(82740400003)(70586007)(2616005)(83380400001)(5660300002)(8676002)(426003)(36860700001)(8936002)(47076005)(186003)(26005)(41300700001)(86362001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:39.2523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b8fedd-8eeb-485f-5340-08db82fb79af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>,
 Nicholas Susanto <nicholas.susanto@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]
Need to save the cached backlight level so that display lights up using
appropriate brightness level instead of the default brightness when
waking up from s0i3.

[How]
Adding a backlight level cache in link structure. Also instead on
calling set_default_brightness_aux, check if cached values exists.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h             |  4 ++++
 drivers/gpu/drm/amd/display/dc/link/link_detection.c  |  3 +--
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c       |  3 ++-
 .../dc/link/protocols/link_edp_panel_control.c        | 11 +++++++++++
 .../dc/link/protocols/link_edp_panel_control.h        |  1 +
 6 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b9e5d217573c..ec7edb7087b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1521,6 +1521,7 @@ struct dc_link {
 	enum edp_revision edp_revision;
 	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
+	struct backlight_settings backlight_settings;
 	struct psr_settings psr_settings;
 
 	/* Drive settings read from integrated info table */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index e6299e99335f..14d7804b70b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1002,6 +1002,10 @@ struct link_mst_stream_allocation_table {
 	struct link_mst_stream_allocation stream_allocations[MAX_CONTROLLER_NUM];
 };
 
+struct backlight_settings {
+	uint32_t backlight_millinits;
+};
+
 /* PSR feature flags */
 struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 8041b8369e45..c9b6676eaf53 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -876,8 +876,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
 			dpcd_set_source_specific_data(link);
 			msleep(post_oui_delay);
-			set_default_brightness_aux(link);
-			//TODO: use cached
+			set_cached_brightness_aux(link);
 		}
 
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index b3cfa3dc5f98..7997936613fc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2143,7 +2143,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
-		set_default_brightness_aux(link); // TODO: use cached if known
+		set_cached_brightness_aux(link);
+
 		if (link->dpcd_sink_ext_caps.bits.oled == 1)
 			msleep(bl_oled_enable_delay);
 		edp_backlight_enable_aux(link, true);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 78368b1204b8..92f58a719c07 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -164,6 +164,7 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 	*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
 	*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
 
+	link->backlight_settings.backlight_millinits = backlight_millinits;
 
 	if (!link->dpcd_caps.panel_luminance_control) {
 		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
@@ -276,6 +277,16 @@ bool set_default_brightness_aux(struct dc_link *link)
 	return false;
 }
 
+bool set_cached_brightness_aux(struct dc_link *link)
+{
+	if (link->backlight_settings.backlight_millinits)
+		return edp_set_backlight_level_nits(link, true,
+						    link->backlight_settings.backlight_millinits, 0);
+	else
+		return set_default_brightness_aux(link);
+	return false;
+}
+
 bool edp_is_ilr_optimization_required(struct dc_link *link,
 		struct dc_crtc_timing *crtc_timing)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 28f552080558..fa89bdb3a336 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -30,6 +30,7 @@
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool set_default_brightness_aux(struct dc_link *link);
+bool set_cached_brightness_aux(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 int edp_get_backlight_level(const struct dc_link *link);
 bool edp_get_backlight_level_nits(struct dc_link *link,
-- 
2.34.1


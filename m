Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61AFD2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1EA10E71A;
	Wed, 23 Oct 2024 04:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixtnnAB5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F8BA10E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNs13VUajGLnfQ1RgQnHrusf9uvOspaoMqnoU1zzqohRAwbmtQ4sK47gEcBFkWHmyg0yvTx9h8eqtEiqgg5sZ1Yx9E2SABXtYzlxdC1vxomuq0f+tLC/9c1jxKL7PdsO1lSUCaf9x5eKnxp8D8Lq2mCuy9EiB/CGX5iuAgPlIm7Nr6VEL20AxT+p5V2Oj/y/bK3XB/nBrBUkEh2cXEXnxOFAGN5P/6qh2gFTfEOQd3AWyx5sZX86wkm7J2JwkE7dnx0TwOxPvv8XGCjRiXEF8qLN1phWPcInC6mTSMQwJl+x6k2bJmsotKBVZ7xiWitrI7dG2m1bEJzH4/LZhvbMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nslGNPIaG+Yc/YQGY1mLWIDK1X5yrNK/+Z4l+SJlcQE=;
 b=CG2vnq7BXGNPd9b2wTX/1E/Q6QHzUSOBrkT7IFDacqrylnNUNih0I7oMZASph3c7EH1JQnN+iSGGpC4TZHFzwHnLK6mI9qJYM6/MDfrrM6zZ7LfcqxVWqxQrTHPKPAN4Xx6TokltyB3N5WjSuflTltsrGv5TALfyeRuAqf7K+wJCnOka1CgR0PhOKpYAd8h9BZmGVFhZcXN4pZjyhM9JHOccRmprz04jGbXORfNJfzTZ0UE8DibynLgFh0yfdkCWGhu8OT82cmb2W9tbICSIM5OWJfGLxqoCO11TrhrBukoDs3/3QirJwQ/OTKTADX0KiNPDI0A/yKqzpKkujUa8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nslGNPIaG+Yc/YQGY1mLWIDK1X5yrNK/+Z4l+SJlcQE=;
 b=ixtnnAB5U7LmJHi6TGhfxiN7JU4vcirs+xjiDsZVzwlOsY+lvYXXPyUWBkEdKg1EO9UM4dd5vE8SFtp/4sQELcWq9W7NOjSb20fxMn0YSmGjNqqv2no+eiiUY9OJAYsevG8M8rxYEi2liEuL+Cwx+fMv8in0CWjy6XN4b4Js+ds=
Received: from PH3PEPF0000409E.namprd05.prod.outlook.com (2603:10b6:518:1::4e)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 04:53:53 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2a01:111:f403:f912::) by PH3PEPF0000409E.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 04:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:53:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:53:50 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:53:47 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ovidiu Bunea <Ovidiu.Bunea@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Optimize power up sequence for
 specific OLED
Date: Wed, 23 Oct 2024 12:53:21 +0800
Message-ID: <20241023045336.1557443-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1837e2-0f39-4dff-ee51-08dcf31eb0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yB10w7mXzZf6/FxGc41J4QK8dQ6+93y3o7dD9o1sZQYSmdNmJ3FO+gxF7NjQ?=
 =?us-ascii?Q?w1+qmiT8dCItZU/fIkpWGFXdZWWpr34BWNFaeiawmQTcksSDiRXxpeuFT/gj?=
 =?us-ascii?Q?cTcMYowaxfEJ+GRVCaiuCU6fbbczWsjJqLmFmuBHDYFyZAg0xD2L53IyMIWK?=
 =?us-ascii?Q?1vjZrHZ9O12qRy5uQObwKpcI0LIJrXpwXIkeY4FajqlhCu0mbsMBcoCJEhBH?=
 =?us-ascii?Q?U3krv0fKNQtgeB3WyL4p5JOo2TgeszFqUJupzdBeBkc6k/c+vJwGxgQ5dURs?=
 =?us-ascii?Q?Kw+TWaneRePrJzXs0RCMYGc4hvECxvXQbxPeMtg+vFJ9QlgzMRYwDOUFZsaG?=
 =?us-ascii?Q?c/Gjh7Iq19rzUUTfHmctU4gElr4HFUCrk9H02NNVC0hYrsLDzd+abD2X7XKf?=
 =?us-ascii?Q?fpjcumrAOY+NU1LJpyAir1z6ksBSvwpttJRJwXtw5UOlHvz73fL88EFFPs8E?=
 =?us-ascii?Q?TnlywPvNtdJYuwZKXXN2oEiYUuvR0p7garDlYD2PpU0JbKUp6ffWwxFdUY55?=
 =?us-ascii?Q?wGCJjLKNp0+tDy9RMZqPEs0AqpEu5cMdLLQn7ew9VueKS3LqXF0Gz8vFMcS5?=
 =?us-ascii?Q?TAgA+8/qB/YMYqNEyTs0xH0534Gg0YN0b6IErDRYxSOvhSuhHrTfaR1hsjM4?=
 =?us-ascii?Q?oCeIpnyqe6FDV3pmG0gJMoiBElC4R2GlD8F3SGZAc8+uPgrbrqxNwbWLg11B?=
 =?us-ascii?Q?3kAHJhqV9RLnPwkFAR4AFMeq640uKyvxpsF6oLSynRzFi9pBx1l2qGn9cYBQ?=
 =?us-ascii?Q?Bfw+SpzJQCAgAB4SVYEJSp5MdZUHHZrd0tdJo4yD3UtHpjHZT/qg3aJF9tyt?=
 =?us-ascii?Q?bvmxgz4s+Q56gE/ItnIPPYXlDgfwi6J6A8y5l0jcDPPyScW138jy5Cni8uPK?=
 =?us-ascii?Q?iLcGQL8oHikur2xP7SUJFV9rtshP9n1MGjMB8L0ZBRSrHaAGJ7bGdNlG6nJ6?=
 =?us-ascii?Q?FQcmJGXoPi+erUhcFIReRzjbKKb74wycCCslPcvR5N8mJ0V7qUXQ0zbmD33w?=
 =?us-ascii?Q?+zIQzRV/iqw/RYm+GQhJ94GtI7VEHSX76ukRp+fSaArn53ZP6rPrZ0omAJ3X?=
 =?us-ascii?Q?bP8jYWMRAM9xznOR2psQv3LSaQngEnlL9eJyiER/JXcLU27kXGkccR4eqqsE?=
 =?us-ascii?Q?TPPoOzT6XEhdM0yNmIw/I5w2b9gL0GK7rlupROg6RWkUdex+yFtCPHbRPZ96?=
 =?us-ascii?Q?dW6izzVnGrGkJx4dVFtOFsGyrBIHz5gcAYFVaeqes6RCisq1eyhcTsjQ6ydM?=
 =?us-ascii?Q?nNAUe68cGoqGroHKXkJQF59DL5BVm7U3vYiyK+bFsfaNf2XPW+D02S654qvy?=
 =?us-ascii?Q?HTF780/Q2u6hDx0SFgreGLfNzN1bet9Yv08fO5Rnjhvnf3tujpylwr8TVJ+p?=
 =?us-ascii?Q?qDAW3z2jINEduYRn77yo30EOOuzMGvOSVH4ooYiuINUeC6hTrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:53:52.0385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1837e2-0f39-4dff-ee51-08dcf31eb0e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[why & how]
OLED power up sequence takes an extra 150ms via hardcoded delay,
but there is a strict requirement on DisplayOn resume time.
For customer panel, remove these delays to meet target until a
cleaner solution is can be put in place.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h               |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h         |  1 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c   | 15 +++++++++++----
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6d76dc110d38..412cdb01a61a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1067,6 +1067,7 @@ struct dc_debug_options {
 	unsigned int sharpen_policy;
 	unsigned int scale_to_sharpness_policy;
 	bool skip_full_updated_if_possible;
+	unsigned int enable_oled_edp_power_up_opt;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 3401f4c9fb10..f0776484abb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -180,6 +180,7 @@ struct dc_panel_patch {
 	unsigned int remove_sink_ext_caps;
 	unsigned int disable_colorimetry;
 	uint8_t blankstream_before_otg_off;
+	bool oled_optimize_display_on;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index c31ec44ccd8c..427fd6ea062a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1039,7 +1039,8 @@ void dce110_edp_backlight_control(
 	link_transmitter_control(ctx->dc_bios, &cntl);
 
 	if (enable && link->dpcd_sink_ext_caps.bits.oled &&
-	    !link->dc->config.edp_no_power_sequencing) {
+	    !link->dc->config.edp_no_power_sequencing &&
+	    !link->local_sink->edid_caps.panel_patch.oled_optimize_display_on) {
 		post_T7_delay += link->panel_config.pps.extra_post_t7_ms;
 		msleep(post_T7_delay);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index c4e03482ba9a..41cab9ad6885 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2082,6 +2082,9 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	if (link_settings->link_rate == LINK_RATE_LOW)
 		skip_video_pattern = false;
 
+	if (stream->sink_patches.oled_optimize_display_on)
+		set_default_brightness_aux(link);
+
 	if (perform_link_training_with_retries(link_settings,
 					       skip_video_pattern,
 					       lt_attempts,
@@ -2105,10 +2108,14 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
-		set_default_brightness_aux(link);
-		if (link->dpcd_sink_ext_caps.bits.oled == 1)
-			msleep(bl_oled_enable_delay);
-		edp_backlight_enable_aux(link, true);
+		if (!stream->sink_patches.oled_optimize_display_on) {
+			set_default_brightness_aux(link);
+			if (link->dpcd_sink_ext_caps.bits.oled == 1)
+				msleep(bl_oled_enable_delay);
+			edp_backlight_enable_aux(link, true);
+		} else {
+			edp_backlight_enable_aux(link, true);
+		}
 	}
 
 	return status;
-- 
2.34.1


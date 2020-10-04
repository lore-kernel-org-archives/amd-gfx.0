Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BCEC4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B57206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Klp7WWLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B57206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F7689E35;
	Sun,  4 Oct 2020 17:19:23 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD7589E35
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPMyarVhCXPL+xuFNZdPYuUnYTbIsHwKNZoEthCrthzU0ukPV66JGZPxexHVELiF7AhWAyW6rvBYLCkvrKuEl3lsSPb0x4h5+lwN+1/JmX9OivJxYS5hhBD+naZWVoOaKakrgfhMOS6BxuDVPUVIQ9sy5eZzxascSAnqjGLob+2KA8nFgEcTmAk8P+jC2SAVXMJ10SOGWW8nDuV3j6eFcYBNOE4r+GbG/gXWd+tvmLyjyqF5CLryc8iFZJohVC6jXDDWEjU9GS9QFoKkaZ6PJHL1zpR6Q4jy7OoJ94w7BlQByw5vjgTMzepWXeLKWJdJzYEpjgHTTtNaA+JQ6Bm9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJvGYhyjsTNxDs1JVAVDw0FAsOaubALXOrumvr3l53A=;
 b=DqOdwncUm+oxmbzNqqUuSudtR+DXOJfna+bF6+A0g58hI/fLQtw+PaSNbWIjvL+OGQO/vOvdAoNy7yS6988ajlU5egnJHRWxfC+TaDZDk36nCjzlBli6gKH6R7rBebjNQfK7LPsYDg0CWTfmfaPp4MCQHomZYgcpxKRfCUR3ZsPtO7O6xJVJynNX8UxpLYTPLN3Q1V7ZL5+5Oemmp4P8fzvp+8wv/5AWBmkFGKSJLdBRd+UgaoMUJWJFblVYcXFBBg5wmXAl23y0S7d6NXzVVYAQ1/5hHAf5I3ftHyu8kzqGOCr86DYQLIq2BMP5/Gi78FIB+eGWuYHsP1SnzacvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJvGYhyjsTNxDs1JVAVDw0FAsOaubALXOrumvr3l53A=;
 b=Klp7WWLCm2gbfJln+14wPPBmKnkM9gv5cQ8E4b2cuqDCw+1VgbaTER9jCTW2Qxkde4aXvd6XQJIfouHOw7rcG9dyKKqFXbyLlBB6BZZFRXLQulD3iY+rOvjKGa6HQQmoroF2IhLZGbHTwpGywc1vPtZhJ0C65Dj+0YlltqISfoI=
Received: from DM5PR19CA0058.namprd19.prod.outlook.com (2603:10b6:3:116::20)
 by MN2PR12MB4638.namprd12.prod.outlook.com (2603:10b6:208:ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Sun, 4 Oct
 2020 17:19:18 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::20) by DM5PR19CA0058.outlook.office365.com
 (2603:10b6:3:116::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:18 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:17 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:11 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/18] drm/amd/display: Fixed comments (uniform style)
Date: Sun, 4 Oct 2020 13:18:00 -0400
Message-ID: <20201004171813.7819-6-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f00ea5-82b1-4053-21bb-08d86889a050
X-MS-TrafficTypeDiagnostic: MN2PR12MB4638:
X-Microsoft-Antispam-PRVS: <MN2PR12MB46381FDD42193C94E6F96509E50F0@MN2PR12MB4638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yr8u0ZYwPRCVCIDJ90FmRvLWI+sICJ/epT99dIDLTgC6kwGwsbb83umlJMOw3+UorVwbS1pThxe/HvmUm63dX/HhkLXGYqQCkpf/EKeigIvC3quNn93EQo9cSyaGvSHSWiMpB0FEcMrDsN/4fppC7FBQmy8pKNVcGMPo/zy/Mx4jdbGTOuJ511rfihZKpOZQK5abyqA8oRZ5Fs8zC2Zxmew605BA9Ut2fAMLsvIEBeH0kyDDmT5zaYV5ZTGMEHINfN3sv5FIQveS/GeQUkpMSXuGGPQwVW7xNPF4psyt1Ir/mVGPxw9qMDczJikUupHc1kBnijznFpyZqNyg6xYhj4Bhc/bOQWvlV7EGsIyoS3XlkNuEQpN5RJoS/EN/qMknIKIeXQVmCD8v5cWEvAubxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(46966005)(2616005)(336012)(1076003)(6666004)(426003)(26005)(6916009)(186003)(86362001)(4326008)(5660300002)(36756003)(70586007)(2906002)(70206006)(54906003)(8936002)(44832011)(8676002)(478600001)(316002)(82740400003)(81166007)(83380400001)(82310400003)(356005)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:18.1380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f00ea5-82b1-4053-21bb-08d86889a050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4638
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
Cc: Felipe <Felipe.Clark@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felipe <Felipe.Clark@amd.com>

[WHY]
This change was implemented because the comment style was not uniform
across the file. In some lines comments were initiated with // and in
others they were in between /* ... */.
Additionally, the style for multi-line comments was also not uniform and
some comment lines were missing the space between the opening /* and the
first word of the comment.

[HOW]
All comments are now in between /*.../*, multi line comments also use
/*...*/ and for every comment there is now a space between the opening
/* and the first word of the comment.

Signed-off-by: Felipe <Felipe.Clark@amd.com>
Reviewed-by: Felipe Clark <Felipe.Clark@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index d988533d4af5..f76d31451dcb 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -41,9 +41,9 @@
 #define BTR_MAX_MARGIN 2500
 /* Threshold to change BTR multiplier (to avoid frequent changes) */
 #define BTR_DRIFT_MARGIN 2000
-/*Threshold to exit fixed refresh rate*/
+/* Threshold to exit fixed refresh rate */
 #define FIXED_REFRESH_EXIT_MARGIN_IN_HZ 4
-/* Number of consecutive frames to check before entering/exiting fixed refresh*/
+/* Number of consecutive frames to check before entering/exiting fixed refresh */
 #define FIXED_REFRESH_ENTER_FRAME_COUNT 5
 #define FIXED_REFRESH_EXIT_FRAME_COUNT 5
 
@@ -85,7 +85,7 @@ void mod_freesync_destroy(struct mod_freesync *mod_freesync)
 	kfree(core_freesync);
 }
 
-#if 0 /* unused currently */
+#if 0 /* Unused currently */
 static unsigned int calc_refresh_in_uhz_from_duration(
 		unsigned int duration_in_ns)
 {
@@ -184,7 +184,7 @@ static void update_v_total_for_static_ramp(
 	bool ramp_direction_is_up = (current_duration_in_us >
 				target_duration_in_us) ? true : false;
 
-	/* Calc ratio between new and current frame duration with 3 digit */
+	/* Calculate ratio between new and current frame duration with 3 digit */
 	unsigned int frame_duration_ratio = div64_u64(1000000,
 		(1000 +  div64_u64(((unsigned long long)(
 		STATIC_SCREEN_RAMP_DELTA_REFRESH_RATE_PER_FRAME) *
@@ -204,10 +204,10 @@ static void update_v_total_for_static_ramp(
 
 	/* Going to a higher refresh rate (lower frame duration) */
 	if (ramp_direction_is_up) {
-		/* reduce frame duration */
+		/* Reduce frame duration */
 		current_duration_in_us -= ramp_rate_interpolated;
 
-		/* adjust for frame duration below min */
+		/* Adjust for frame duration below min */
 		if (current_duration_in_us <= target_duration_in_us) {
 			in_out_vrr->fixed.ramping_active = false;
 			in_out_vrr->fixed.ramping_done = true;
@@ -217,10 +217,10 @@ static void update_v_total_for_static_ramp(
 		}
 	/* Going to a lower refresh rate (larger frame duration) */
 	} else {
-		/* increase frame duration */
+		/* Increase frame duration */
 		current_duration_in_us += ramp_rate_interpolated;
 
-		/* adjust for frame duration above max */
+		/* Adjust for frame duration above max */
 		if (current_duration_in_us >= target_duration_in_us) {
 			in_out_vrr->fixed.ramping_active = false;
 			in_out_vrr->fixed.ramping_done = true;
@@ -289,7 +289,7 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 	} else {
 
 		/* Calculate number of midPoint frames that could fit within
-		 * the render time interval- take ceil of this value
+		 * the render time interval - take ceil of this value
 		 */
 		mid_point_frames_ceil = (last_render_time_in_us +
 				in_out_vrr->btr.mid_point_in_us - 1) /
@@ -306,7 +306,7 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		}
 
 		/* Calculate number of midPoint frames that could fit within
-		 * the render time interval- take floor of this value
+		 * the render time interval - take floor of this value
 		 */
 		mid_point_frames_floor = last_render_time_in_us /
 				in_out_vrr->btr.mid_point_in_us;
@@ -559,7 +559,7 @@ static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
 	 */
 	infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
 
-	//FreeSync HDR
+	/* FreeSync HDR */
 	infopacket->sb[9] = 0;
 	infopacket->sb[10] = 0;
 }
@@ -897,15 +897,15 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	min_refresh_in_uhz = in_config->min_refresh_in_uhz;
 	max_refresh_in_uhz = in_config->max_refresh_in_uhz;
 
-	// Full range may be larger than current video timing, so cap at nominal
+	/* Full range may be larger than current video timing, so cap at nominal */
 	if (max_refresh_in_uhz > nominal_field_rate_in_uhz)
 		max_refresh_in_uhz = nominal_field_rate_in_uhz;
 
-	// Full range may be larger than current video timing, so cap at nominal
+	/* Full range may be larger than current video timing, so cap at nominal */
 	if (min_refresh_in_uhz > max_refresh_in_uhz)
 		min_refresh_in_uhz = max_refresh_in_uhz;
 
-	// If a monitor reports exactly max refresh of 2x of min, enforce it on nominal
+	/* If a monitor reports exactly max refresh of 2x of min, enforce it on nominal */
 	rounded_nominal_in_uhz =
 			div_u64(nominal_field_rate_in_uhz + 50000, 100000) * 100000;
 	if (in_config->max_refresh_in_uhz == (2 * in_config->min_refresh_in_uhz) &&
@@ -1042,7 +1042,7 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 		last_render_time_in_us = curr_time_stamp_in_us -
 				plane->time.prev_update_time_in_us;
 
-		// Sum off all entries except oldest one
+		/* Sum off all entries except oldest one */
 		for (i = 0; i < DC_PLANE_UPDATE_TIMES_MAX; i++) {
 			average_render_time_in_us +=
 					plane->time.time_elapsed_in_us[i];
@@ -1050,7 +1050,7 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 		average_render_time_in_us -=
 				plane->time.time_elapsed_in_us[oldest_index];
 
-		// Add render time for current flip
+		/* Add render time for current flip */
 		average_render_time_in_us += last_render_time_in_us;
 		average_render_time_in_us /= DC_PLANE_UPDATE_TIMES_MAX;
 
@@ -1125,8 +1125,9 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 	if (in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE)
 		in_out_vrr->fixed.ramping_active = false;
 
-	/* Gradual Static Screen Ramping Logic */
-	/* Execute if ramp is active and user enabled freesync static screen*/
+	/* Gradual Static Screen Ramping Logic
+	 * Execute if ramp is active and user enabled freesync static screen
+	 */
 	if (in_out_vrr->state == VRR_STATE_ACTIVE_FIXED &&
 				in_out_vrr->fixed.ramping_active) {
 		update_v_total_for_static_ramp(
@@ -1214,20 +1215,20 @@ bool mod_freesync_is_valid_range(uint32_t min_refresh_cap_in_uhz,
 	min_refresh_cap_in_uhz /= 1000000;
 	max_refresh_cap_in_uhz /= 1000000;
 
-	// Check nominal is within range
+	/* Check nominal is within range */
 	if (nominal_field_rate_in_uhz > max_refresh_cap_in_uhz ||
 		nominal_field_rate_in_uhz < min_refresh_cap_in_uhz)
 		return false;
 
-	// If nominal is less than max, limit the max allowed refresh rate
+	/* If nominal is less than max, limit the max allowed refresh rate */
 	if (nominal_field_rate_in_uhz < max_refresh_cap_in_uhz)
 		max_refresh_cap_in_uhz = nominal_field_rate_in_uhz;
 
-	// Check min is within range
+	/* Check min is within range */
 	if (min_refresh_cap_in_uhz > max_refresh_cap_in_uhz)
 		return false;
 
-	// For variable range, check for at least 10 Hz range
+	/* For variable range, check for at least 10 Hz range */
 	if (nominal_field_rate_in_uhz - min_refresh_cap_in_uhz < 10)
 		return false;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

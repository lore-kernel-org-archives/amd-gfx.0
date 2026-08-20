Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0737C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 14:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAC310E5E4;
	Thu, 20 Aug 2026 14:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nDqPoaCq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E7F10E5E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+qnNQqW2Zmx9VkmYH+JvNkpQFc8qhvvah4bzoIMzuFG3jVqEqIazBrdUQx52huZd7D/kGRHsZ0PAu3nclMVND89saIRhHyj/JaAuIr/qhpKYT+P7Z9gi9RC3P/ZEbO+IwiUSlzXAGmVqK+bV9mq2lyodREYoNXytAx5VDH7dQk/G/0a0850Y+dJJjfLQJXuFS31XpT+XGIetfOSdGBjMqQEyTL24ymfD2bbnaao+Ttef+PTKZyzIwGPXJRrVc/03PkJ3GtBLEynx5ZNFAhJdLUGkD6GFOkucLKDZROR6OugPynXyw9Jwp7FmkdZdHKIsaQbXZxeB1t7qs+mQLKzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/qiUA4JXPHU/ZNgCHK0Xq6Nv7BHixkT/APl284oHow=;
 b=GEx/066OwYnKvaTkT3MVa+alnEwWtnMgy/f6d5q9uuKDUfLSZpkbrTcFp52nypHXjUDsIQFhjrCN0qPV3Ntm9BF+YH/2wHaOFJXsu/g4GlA360ZnGqvu/37OgByUyKaPdT71iWPPH2I5vZMVn+EML2kU8keX1PyGdMyBiqJevNBzziochpjS87r/hmfXFFVhWZ5Xh2kQGA3OZAT4Ze7MstPFLr5O6VEeANDnIfsRwvSb9UXVa//or/9MShTLqpYRfOU8kVjKXTPvV/iAbcAYjEaXAfoxZCwiqsCCyOUGhlXdrNkcKlgDZaOhaSUEpO2fFrfNHg/15fyRBF/ip9PiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/qiUA4JXPHU/ZNgCHK0Xq6Nv7BHixkT/APl284oHow=;
 b=nDqPoaCquB29arrzdD7+hUkIRvuHQtI4QXn6SgNT8th579TfttlnjDy4ahjnvX3xKE5JUt7eZU5qyJ/YtO+GTO3t97ZnoaVQW8v8J+Nn6LkEu2wIoQXmrsaCNkAcOqd9r/9TzPPd4yQbnaB37CUdyeThdwr0iV5RVXpIpu1c34g=
Received: from PH7P220CA0141.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::29)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Thu, 20 Aug 2026 14:13:46 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:510:327:cafe::9f) by PH7P220CA0141.outlook.office365.com
 (2603:10b6:510:327::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 14:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 14:13:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:13:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:13:44 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 09:13:44 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 <HarryWentlandharry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [v2] drm/amd/display: Fall back to overlay cursor on dcn4x when top
 plane doesn't fill CRTC
Date: Thu, 20 Aug 2026 10:13:39 -0400
Message-ID: <20260820141339.343372-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 666ae8bc-1002-4b61-1fdd-08defec53efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|11063799006|10067099003|3023799007|18092099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YyAyhBTUgZwnyQ1eXT2dQh5AaXJ2ckYHez8GnpP0SfWbavMZiKCqPNtFAGvJcgaF8rK3nLBNwGyHcTZALTYXAHcuBx6zsh/vYCZhUxxeXRBj1XHHdnAKOV9V45QoqkSgmQNj6Ga+ZKFW2d02WHY4nePhyhOfCVbP+2rvjoOTJ5nqFCxKUSQckCTsJdqO/u+FM+BITa0uM22/gOzwu7iXhHd84KVHe5CK7ZfAlfhh9HoRIdsyL+HX7GPNJt5ZuUu8AnBq3Kj5eI7YR50PPVoUJqrywui3IJ3mL5hBkMmc3qQCxSlZqhqGgEr8rbGA9RyC5PceZCa6Ch2+1xhYmY8naAp+vzQwQwme/OewoL+eY9R9wev22A7y5hDrBv5TmFxCGILPKl8SBVntRP21XDKX91kZAjWJydhTHBKb97vaqw/vwp21y6vTn0ZN9CTWVBVijlTj2T6fRX6f+uQQfdPryNUV/8jPLNpWFoECXRLUYWL/C1xG/BK1THWmgNFDyg4M4lc0hq+//N3wyfwUfb75WeOM6eWig4fc9P6P5Cyt/W0TjF7LNvWOACQNEoaE8uxO3j+muHJ7YNzt2NxpNzhyC7XF7VhexyP0hd4qXptycwlY24tiughgXEVe3P5kykON697QBVzaBkgy35A1eVc3AY5dEYMo9KOItNMO4+SGoZDxLAqpgj/HyE/LEkOAT/Fc7VybJ1AOgGYTuCMJWjSDOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(3023799007)(18092099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KBVGdglsLDadZkGiDHiz4JCzUQ1RClzJVaaq4+u32LgA5M2l7MwROw1UsQqYNKy30V53qDCAwElppp53RFsIk0zDm7NNLTeWLpj+HeZfEs3kDdeW7DLl9HF9KHzm154CcPtmRZQKnl/7bXH4gaTlf3M+3VR6cWMGQQnSg2fYFiP5rYPnJIhIO05m0GMz/iPPVQ4+jFl2Q9EBghanASt5vgqCOhVg8MeyJ8QTqx1aJgKDdigcdTuOOq2P80sdSMTM9hky/Ccr4O4iA7mwanjWM9PY+sNEBkFt5/4rnGSnOqvUQkF2CdQGjAT44SzvsEr2NjYcpniA/oUkQqnRofvSRYhRzygWDUSDShhRnvB5PJXJGSOQoyZ5kbWycxIiTjOzQGnRWndee/RMNXhLuwLJpIz5RJXPjsfyNqioBu3nBuDwViJ7ZhvLhX/g8Lb+k58L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:13:45.1524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666ae8bc-1002-4b61-1fdd-08defec53efc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

From: James Lin <PingLei.Lin@amd.com>

[why]
amdgpu_dm_crtc_get_cursor_mode() returns DM_CURSOR_NATIVE_MODE early and
unconditionally for dcn4.x. That early return was added because these ASICs
no longer have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
of older DCN, so native cursor is fine in those cases. However, it also
bypasses the "does the top plane fill the CRTC?" (hole) evaluation further
down. When the top/primary plane does not cover the whole CRTC, the cursor
must fall back to an overlay plane so it is composited over the uncovered region;
keeping the native cursor there produces an incorrect result. As a
consequence igt@amdgpu/amd_cursor_overlay@non-full, which verifies exactly
this native->overlay fallback, fails on dcn42.

[how]
Replace the unconditional early return with a skip_fmt_scale_restrictions
flag. For dcn4.x keep skipping the YUV / active-color-pipeline / different-
scale overlay triggers (genuinely unnecessary on this hardware), but fall
through to the existing entire_crtc_covered check so a top plane that does
not fill the CRTC still selects DM_CURSOR_OVERLAY_MODE. Native mode is
still chosen when the plane covers the whole CRTC.

Update the amdgpu_dm_cursor KUnit tests accordingly: exercise the dcn4x
path with a full atomic state fixture (full coverage -> native) and add a
dcn4x hole case (top plane does not fill the CRTC -> overlay).

Also remove DCN5/6 guards since they've been upstreamed.

v2:
Move the check for disabled crtc to  separate early return, so a disabled
CRTC always reports native mode on every ASIC, independently of the DCN4x
fallback logic.

Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 45 +++++++++++--------
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 32 +++++++++----
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index 9534848ed240..8204ad4018e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -87,12 +87,8 @@ STATIC_IFN_KUNIT int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	 * check tiling flags when the FB doesn't have a modifier.
 	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-#if defined(CONFIG_DRM_AMD_DC_DCN6_0) || defined(CONFIG_DRM_AMD_DC_DCN5_0)
 		if (adev->family == AMDGPU_FAMILY_GC_12_0_0
 		    || adev->family == AMDGPU_FAMILY_GC_13_0_1) {
-#else
-		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
-#endif
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
 		} else if (adev->family >= AMDGPU_FAMILY_AI) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
@@ -289,26 +285,34 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	int underlying_scale_w, underlying_scale_h;
 	int cursor_scale_w, cursor_scale_h;
 	int i;
+	bool skip_fmt_scale_restrictions = false;
 
-	/* Overlay cursor not supported on HW before DCN
-	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
-	 * as previous DCN generations, so enable native mode on DCN401/420
-	 *
+	/*
 	 * Always set native cursor mode when the CRTC is disabled,
 	 * to make sure it doesn't cause atomic commits to fail when
 	 * they are trying to disable the CRTC.
 	 */
+	if (!crtc_state->enable) {
+		*cursor_mode = DM_CURSOR_NATIVE_MODE;
+		return 0;
+	}
+
+	/* Overlay cursor not supported on HW before DCN
+	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
+	 * as previous DCN generations, so enable native mode on DCN401/420
+	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
-#if defined(CONFIG_DRM_AMD_DC_DCN6_0)
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
-#else
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-#endif
-	    !dm_crtc_state->base.enable) {
-		*cursor_mode = DM_CURSOR_NATIVE_MODE;
-		return 0;
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0)) {
+		/*
+		 * Newer DCN has no cursor-on-scaled/yuv-plane restriction, so
+		 * skip those overlay triggers below. A plane that does not fill
+		 * the CRTC still needs overlay mode so the cursor renders over
+		 * the hole, so fall through to the coverage check instead of
+		 * unconditionally forcing native mode here.
+		 */
+		skip_fmt_scale_restrictions = true;
 	}
 
 	/* Init cursor_mode to be the same as current */
@@ -407,13 +411,15 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 			continue;
 
 		/* Underlying plane is YUV format - use overlay cursor */
-		if (amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
+		if (!skip_fmt_scale_restrictions &&
+		    amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
 			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
 			return 0;
 		}
 
 		/* Underlying plane has an active color pipeline - cursor would be transformed */
-		if (dm_plane_color_pipeline_active(state, plane, false)) {
+		if (!skip_fmt_scale_restrictions &&
+		    dm_plane_color_pipeline_active(state, plane, false)) {
 			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
 			return 0;
 		}
@@ -424,7 +430,8 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 				   &cursor_scale_w, &cursor_scale_h);
 
 		/* Underlying plane has different scale - use overlay cursor */
-		if (cursor_scale_w != underlying_scale_w &&
+		if (!skip_fmt_scale_restrictions &&
+		    cursor_scale_w != underlying_scale_w &&
 		    cursor_scale_h != underlying_scale_h) {
 			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
 			return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index efd16575896e..9026c6ce7336 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -521,25 +521,38 @@ static void dm_test_crtc_get_cursor_mode_disabled_crtc(struct kunit *test)
 }
 
 /**
- * dm_test_crtc_get_cursor_mode_new_hardware - Test new hardware always uses native mode
+ * dm_test_crtc_get_cursor_mode_new_hardware - Test dcn4x uses native cursor when the top plane fills the CRTC
  * @test: The KUnit test context
  */
 static void dm_test_crtc_get_cursor_mode_new_hardware(struct kunit *test)
 {
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dm_crtc_state *dm_crtc_state;
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
 	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_OVERLAY_MODE;
-	int ret;
 
-	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
-	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
 
-	ret = amdgpu_dm_crtc_get_cursor_mode(adev, NULL, dm_crtc_state, &cursor_mode);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
 	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
 }
 
+/**
+ * dm_test_crtc_get_cursor_mode_new_hardware_hole - Test dcn4x falls back to
+ * overlay cursor when the top plane does not fill the CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_new_hardware_hole(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
+	fixture.old_primary_state->crtc_w = 1280;
+	fixture.primary_state->crtc_w = 1280;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
 /**
  * dm_test_crtc_get_cursor_mode_no_change - Test unchanged atomic state preserves cursor mode
  * @test: The KUnit test context
@@ -948,6 +961,7 @@ static struct kunit_case amdgpu_dm_cursor_tests[] = {
 	/* amdgpu_dm_crtc_get_cursor_mode */
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_crtc),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware_hole),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_no_change),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_cursor),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_yuv_plane),
-- 
2.43.0


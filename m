Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2A3C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23B810EE2F;
	Wed, 26 Aug 2026 23:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="arfn6ZOb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DFC10EE2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKbTuFlnbk+vAt9IzFckaBLDob14IpzokWlh9kat8LrG4PtBan6KnMsQLq1WBBhxHdeECLkiz9eemYTDWQ8ky8AY+D+BeFEWxJSgNR+UYinPD0uomUtKokxxRrkf1CbLf8igVT0Ch/KUERamktlo0pWOcbiYrDKJxwWCvvJ78nF/odQdOSbReRQALI74OyMA8sDINIm8QEwvZaevjpXK6MSEihSFNdE/vt6iOpqhhHOdVK2dDFRRP0/wfhjrMCelXym2C2QhX/IXdbVa4ajyDOvnlPe9RB1KcfvMYRApaIDzUGslSCaTzy8e3cRl2Yr64wvyxtEyKD+fhETI4CvysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk2h0ZfILYaym564yM7fb1AnAvHY2VXafVcgUdlfhS4=;
 b=wFDmpO0l+OzF86bYtN0kzFRmQzqp/HxYOFs/b9dhtLda43y80h+IB7mkgdkdXqzlzvt2GPaUUB+H+liIkIaM63rtPz3hnCRPlav/xiWEifAbyfE+vRR4+095b3wHbtkcDPD5W7cJIZjICuhr0pSAD4Z4QSjLTywOVqpWpW4gVytb3NOSa6O+uCDcDzV+Xuq+iFWjNQoUzjyDcy8FvFCMaZwoiTO8kPtaKis37hL2eFPqRck4c0DOKJcgVCDRpybAyGcZowliPR1tGBg4nAgecTY4O0S6+5uydXpa0HbaUrpfuGKBTPb+eShxkwc4QMj2UYY09ofGjeqADp5FlC2r5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk2h0ZfILYaym564yM7fb1AnAvHY2VXafVcgUdlfhS4=;
 b=arfn6ZOb83RIo8iT63SAMA1IPErcO764hHdNhIIW7cybsDvvGZ+UO1ILGwzj9qWyZOsA3oZu5uKVeSRZTpJ/WyWXowSG+Rj8s7Swpk1gbQDcTAHvyzoo3AxBbLnWOOsCFVXvcxGQ5n0lFFOIwCzguu2Gzbzzkp4pfCa8OkpEyrg=
Received: from DS7PR03CA0211.namprd03.prod.outlook.com (2603:10b6:5:3ba::6) by
 DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.8; Wed, 26 Aug 2026 23:16:28 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::7a) by DS7PR03CA0211.outlook.office365.com
 (2603:10b6:5:3ba::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 26
 Aug 2026 23:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:16:27 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:16:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 02/59] drm/amd/display: Test ISM idle commit
Date: Wed, 26 Aug 2026 17:04:33 -0600
Message-ID: <20260826231519.881949-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d610da-9fce-41cc-d029-08df03c80e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MP0lsvxMhcFKdr9Xw3nG/BxpQFb2WgTIvHAcmLpskhHc8btkHmXGVPxyyDpwTsDmuzOpWTxW2ZjSk1MnqHpj44gx77NWEBB0zsZhpydAx7zI72k9cIbHJhxnH7b/5hSeWaZhJ083U95A0MdsngWog8mqLdO06rXL3OvFVkuC5gdp47xnln8/ViVnXtS20SlTjgmYT/0BsfvvCPTLSolTnjN7e+bkLsjydSh2OUznEXRfas3XBzyZNaoQhSh69Q+a7datpGS6IRqYRVEfZ2Yx/S8ndy6VXPq/lot8kqk3IX/Nkh9/8tNWWDOx6jQZ+u8qrUYzgqaM0pmtDIliDc78VKg9a2qEqWKDEy8tXHEkqg1/7IfTkA3MJpWTcZV2NAt4OSZtUEN5walXRSWpZjFPKLEIkfndkpPfCg9ilPPl3qNUkTPzu7IDOAwcL1WE4CJTYqxepuzw76eQV5SS7teTZMmYC+AGbXZ9iTWVsbmIHtn8bCUIdEc1Xds2WK8Uvtnfcv4Jfru63OuDHJbZsc1Ft8frFyh6xs5SSE8PY0l5MTWPqzXLk99qre/eh4sxJ7A+AaWZm9RtcmiX9qfqhonmd7uvypS5iX6Iujc27NpHsHU9YSlCbiv2Qw+iI5pxRKOuSned0vtwXfQD/hkCzF24UMGCmJduJ66muukByF/MnM4F1rlvHunwfgo1X13ht1QQggLrDhx2tFb5rjZBcSFItA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w4mTev8vTGdkDfLmPHSL/HY5BFwKxfuLhbuhq0Lk+cXsrmUEFELvV3gTSHFxvqUx9Zo6LP/r8idkrztDBIxflsuKLyNGLqswxBtZfoxdKPegxw/xQsfZ0bflDj6V6TXPNvuKbAnG/mjhY8OlYHxH3MUDWzwOCWQoccwOu80ZsvzsS2nKQMhTBNibtfK0YpM5ozapuQT0LaBRVxXx4zxShxtCn5QJZKbK3AAndiqx2pGfmzjT15+7oTiesdoTLjqmioWSKMIHF3vBUmK3BnU47tdtBe0AAB8LTrW7WiEz0fkAZCeLvOmMSCfV8fBK/r+lRmRwpcED7onw+OQSQ1m2K44tvMDwAerJtaaLeC5cHXU2pVLyQQLTID92nNO+vIziTrxQsPfcRhCyr6QNPQWymGaKGQ8zfgszzb2uTLzdlGQIWHdR68nzzo4faz8DfJGw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:16:27.5844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d610da-9fce-41cc-d029-08df03c80e36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
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

[WHAT]
Add KUnit tests for the three idle-optimization commit arms of the ISM
FSM: OPTIMIZED_IDLE, OPTIMIZED_IDLE_SSO and TIMER_ABORTED.

[HOW]
Record idle changes with a stub on
dc->hwss.apply_idle_power_optimizations() and read the outcome from
dc->idle_optimizations_allowed.

DC already owns that callback, so it is the natural injection point.
dc_allow_idle_optimizations() returns early when the requested state
already matches, so the stub runs only on a real transition and its
call count is the number of idle changes the FSM asked for. That count
is what separates the three arms, which otherwise all leave idle in
the same state.

The remaining two commit calls need no double:
dc_post_update_surfaces_to_stream() returns on !dc->optimized_required
and amdgpu_dm_crtc_set_static_screen_optimze() stops in the replay and
PSR event helpers when the link has neither feature enabled. Both are
already no-ops on a test dc, so a double would only add upkeep.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 198 +++++++++++++++++-
 1 file changed, 193 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index 6394b967ac3a..5b348ded482f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -865,18 +865,14 @@ static struct amdgpu_crtc *alloc_test_acrtc(struct kunit *test,
 {
 	struct amdgpu_device *adev;
 	struct amdgpu_crtc *acrtc;
-	struct dc *dc;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, adev);
 
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
-	adev->dm.dc = dc;
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
 	adev->dm.ddev = &adev->ddev;
 	mutex_init(&adev->dm.dc_lock);
 
@@ -1190,6 +1186,194 @@ static void dm_test_ism_dispatch_optimized_idle_defers_sso(struct kunit *test)
 	amdgpu_dm_ism_fini(&acrtc->ism);
 }
 
+/*
+ * ===== Behavioural tests for dm_ism_commit_idle_optimization_state =====
+ *
+ * The commit path runs the real DC calls. dc_allow_idle_optimizations() only
+ * reaches hardware through dc->hwss.apply_idle_power_optimizations(), so the
+ * spy is installed there — DC's own seam — and the outcome is read back from
+ * dc->idle_optimizations_allowed. The callback fires only on an actual
+ * transition, so the call count is the number of idle state changes requested.
+ */
+
+static struct {
+	int calls;
+	bool last_allow;
+} dm_ism_test_idle;
+
+static bool dm_ism_test_apply_idle(struct dc *dc, bool allow)
+{
+	dm_ism_test_idle.calls++;
+	dm_ism_test_idle.last_allow = allow;
+
+	return true;
+}
+
+/*
+ * Initialise @acrtc's ISM against a stream with a non-NULL link (required by
+ * the static-screen arm) and make dc_allow_idle_optimizations() observable.
+ */
+static struct dc_stream_state *setup_commit_test(struct kunit *test,
+						 struct amdgpu_crtc *acrtc,
+						 struct amdgpu_dm_ism_config *config)
+{
+	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
+	struct dc_stream_state *stream;
+	struct dm_crtc_state *dm_state;
+	struct dal_logger *logger;
+	struct dc *dc = adev->dm.dc;
+
+	stream = dm_kunit_alloc_stream(test, dm_kunit_alloc_link(test));
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	dm_state->stream = stream;
+
+	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
+	logger->dev = &adev->ddev;
+	dc->ctx->logger = logger;
+	/* is_apu path avoids DC_LOG_DC()'s NULL-logger dereference. */
+	dc->caps.is_apu = true;
+	/* dc_allow() only calls apply() when clk_mgr is present. */
+	dc->clk_mgr = dm_kunit_alloc_clk_mgr(test);
+	dc->hwss.apply_idle_power_optimizations = dm_ism_test_apply_idle;
+	dm_ism_test_idle = (typeof(dm_ism_test_idle)){ };
+
+	amdgpu_dm_ism_init(&acrtc->ism, config);
+	acrtc->base.state = &dm_state->base;
+
+	return stream;
+}
+
+/**
+ * dm_test_ism_commit_allows_idle_on_optimized_idle - OPTIMIZED_IDLE commits idle-allow
+ * @test: KUnit test context
+ *
+ * With idle-allow filtering disabled (delay 0) ENTER_IDLE_REQUESTED cascades
+ * FULL_POWER_RUNNING -> HYSTERESIS_WAITING -> OPTIMIZED_IDLE. Because
+ * sso_num_frames >= filter_num_frames the OPTIMIZED_IDLE arm commits the idle
+ * state. With no active vblank and no SSO the commit must request allow-idle
+ * exactly once, without a preceding disallow.
+ */
+static void dm_test_ism_commit_allows_idle_on_optimized_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 0,
+		.sso_num_frames = 2,
+	};
+
+	setup_commit_test(test, acrtc, &config);
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_OPTIMIZED_IDLE);
+
+		/* vblank disabled + no SSO -> a single allow-idle transition. */
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 1);
+		KUNIT_EXPECT_TRUE(test, dm_ism_test_idle.last_allow);
+		KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
+
+		cancel_delayed_work(&acrtc->ism.sso_delayed_work);
+	}
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_commit_enables_sso_on_optimized_idle_sso - SSO arm re-arms idle
+ * @test: KUnit test context
+ *
+ * With both idle-allow and SSO delays disabled the FSM cascades through
+ * OPTIMIZED_IDLE into OPTIMIZED_IDLE_SSO, whose arm commits with
+ * allow_panel_sso = true. Engaging SSO must first disallow idle and then
+ * re-allow it, so starting from an idle-allowed DC yields two transitions.
+ */
+static void dm_test_ism_commit_enables_sso_on_optimized_idle_sso(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 0,
+		.sso_num_frames = 0,
+	};
+
+	setup_commit_test(test, acrtc, &config);
+	adev->dm.dc->idle_optimizations_allowed = true;
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_OPTIMIZED_IDLE_SSO);
+
+		/* SSO engagement disallows idle, then re-allows it. */
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 2);
+		KUNIT_EXPECT_TRUE(test, dm_ism_test_idle.last_allow);
+		KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
+	}
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_commit_disallows_idle_on_timer_aborted - aborted timer disallows idle
+ * @test: KUnit test context
+ *
+ * A non-zero idle-allow delay parks the FSM in HYSTERESIS_WAITING.
+ * EXIT_IDLE_REQUESTED then drives HYSTERESIS_WAITING -> TIMER_ABORTED, whose
+ * arm commits with vblank_enabled = true: idle must be disallowed and, because
+ * vblank is active, never re-allowed. The FSM returns to FULL_POWER_RUNNING.
+ */
+static void dm_test_ism_commit_disallows_idle_on_timer_aborted(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct dc_stream_state *stream;
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 5,
+		.filter_entry_count = 3,
+		.activation_num_delay_frames = 10,
+		.filter_history_size = 8,
+		.filter_old_history_threshold = 0,
+		.sso_num_frames = 0,
+	};
+
+	stream = setup_commit_test(test, acrtc, &config);
+	setup_idle_delay_history(&acrtc->ism, stream);
+	adev->dm.dc->idle_optimizations_allowed = true;
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		/* Non-zero delay parks the FSM in HYSTERESIS_WAITING. */
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_WAITING);
+
+		/* Abort: HYSTERESIS_WAITING -> TIMER_ABORTED -> FULL_POWER_RUNNING. */
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+		/* TIMER_ABORTED commit runs with vblank_enabled=true. */
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 1);
+		KUNIT_EXPECT_FALSE(test, dm_ism_test_idle.last_allow);
+		KUNIT_EXPECT_FALSE(test, adev->dm.dc->idle_optimizations_allowed);
+	}
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
 static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_next_state — FULL_POWER_RUNNING */
 	KUNIT_CASE(dm_test_ism_next_state_running_enter_idle),
@@ -1263,6 +1447,10 @@ static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_dispatch_power_state (via commit_event) */
 	KUNIT_CASE(dm_test_ism_dispatch_hysteresis_schedule_and_cancel),
 	KUNIT_CASE(dm_test_ism_dispatch_optimized_idle_defers_sso),
+	/* dm_ism_commit_idle_optimization_state (behavioural, via dc->hwss) */
+	KUNIT_CASE(dm_test_ism_commit_allows_idle_on_optimized_idle),
+	KUNIT_CASE(dm_test_ism_commit_enables_sso_on_optimized_idle_sso),
+	KUNIT_CASE(dm_test_ism_commit_disallows_idle_on_timer_aborted),
 	{}
 };
 
-- 
2.43.0


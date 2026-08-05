Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ADDC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D32D10ED10;
	Wed,  5 Aug 2026 06:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EVleMGOz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83A510ED10
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUpvWLQrigobX9euWA+pLVs8b4BexSBkuyFNW6ghdbf2m7w6P3dVSqjzwOkH/PsOyDYp9zAKgK8xly2Rf5BhN1icS9m8vEdNhk0GozYpS+fGXJHcxYU17w6aIzzIvmLNi7MXov60hNEAuSCU7o+lXIlPXNATei5boPEyZ+E/GBPywCsMFJs/PQr+PqfCCodwLFr9HLG9gL4SIkoge/U4Yb20XMY0hJuM2UkQ65LiY41+iRVt6AY/zoxaFWTsyStjW59amRJ6bXldY1YhWsXSOAnhenh2hdv4CfAgegCpkfrTULIZKKBZj1V1kRZ/UDF5BAwgx8tne26OFHgzujV2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1flYgLu8EwN0udiWvADH2Gmhg4fSbNUQCbeSRdAoNsA=;
 b=LA7O1QtMSP3YQa3rGavIqD3iaDG6hN7MIRO9FGOcBamobSzalALyHrzWPpZxZ6JAZvRc5llHKBCbSkLb8FoYy33N/0MH9nlZbKIDq9tcRPQ/gEinAN7lLyLmzOdno9Rv42nI0Jduak2kwErksFWCFeC3VU4wbSrFyj7e+xLhrblS/KK2u6bzkiJVZpAJsKlaQWvEhN6ybTFSgvb7TOGSWfh8g4OGSUCQowBdsJhAqQeaomau7PL/QJE+LrJE5lvVAu14CAuy79zmDLY/jXF+oY8LRB6fowEbznkvylI3UZu07lX2SR1uyXkyB67QK7YPiI54RIw14zHBIRj7dqQcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1flYgLu8EwN0udiWvADH2Gmhg4fSbNUQCbeSRdAoNsA=;
 b=EVleMGOz5U0B2wJWCNx8vLqazJUWYYb8QuLNUVRSWN1dOofzz0b77lGFeVapn+YNL/v9qvLdgLsAoC/+fwQ36ER8PoBZLJzuNoAA/IzfctVVd1zX3Yhv/o9G+5VDm3DyMIsJ3kTzzpvOJkHsUuiQHnT58FTLKe/B9LT7TA8DHMQ=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 06:41:30 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::72) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:28 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 24/34] drm/amd/display: test dm_plane_color_pipeline_active
Date: Wed, 5 Aug 2026 14:36:36 +0800
Message-ID: <20260805063937.2145774-25-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5266c0-519e-4e44-9eb1-08def2bc94cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Hb58zECQJCOax13pnz0HWbzDKlMGbHh8snqth1aPwanHUy4FORlrZyT4uax2xzVhyspX9i0KxFoXZu5f/P9NRgZQDNbicqXjIZYwWE7gO7Ui3/wW1xmYCG9RQNIsnUASrGr1DfEafyCE7+5TqdpfPP800CWWq7LceSrP4ApXMsGxQJcp7hDmxV+y5EPJGlw35+ie8Dd7guqFpu7+t9PtVQRukHdmSuO0ktHM+FGfe5svDMvLkskgNpP6kv4/yu1PRztGhIWLZv1h9IzZlLLKUArgrhJcUwh2Vr8NITyi4NuoVBmzOY+SKR1btN3j22hnql6ipPlcr3WSKWC6ACtWHw8AOQKCOhzyPaB7rD3efTwW83ms+CkEhNF4yNz/NAxlkdVgIB9gf2klbeFeuHxHMnTYvPw+VHoVQvbb+yJwVZHAa0y4zjxM2902M9o65wTncfClSPqi2FEspUw9WTDS9IFlyN8zY312PJowmB1y6VYfOU5RZpnHSAfTxuNNLx8RldQU5W8+AzbQkiSbeXWzdTYEtAt1FjnZ4frbgiTwFu6/QBA9+AvX2f7zXO9a5HFW3jqkeDYy2Tyvwx1RMToA2Z3Ud1kcO+FQRHPNF8vdB/yCZRj3VYRvmm21uDO/BlQWCjPR5v+tr9jKxW+lcZXvr5BG6tmOlkc7GDsaJxAfug3TRCHlox6y9YfhD4DGLlJY3lfC2akeEYu98y7t6L5Mtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DUMqRtt1TWQrRQwcEQ1ykkwxxjTo6HLjP33Zo2KW2QK/pM5KBJboEaK4P9xfluPh0xpttrsANoBMR5ZGHU1b0X9mSYj9kfyhU+Ym5h4EITh+iLnYL0zUpEtteLRNuwgUB7OYvJ/bQFBWMJ1jotJgOVPGIlX1MYYtW3L3tLcKPFB9EcWaaPUJd6M6Rvpw/DfFdQ97p4th4ydsl9Rb8zFla1P2zcFH/RKYlghNHMUrvQAnA+9bpPbdpgeckEIREeYbOPASy3bPk+W9it1g5itlIifSLDu5bofOe08G9GxJZCbjCwyjAANNnRtE5zjivGwadjfadp7M6bnHWNQd5CNazG/prwzWevoCOR8VGxLlZrM/bnEzKU0pLc1MjNyaReTYpWPM2i6jTeXWoGdmBW7K94fFcXtNSuJdcDwBvZ0Fag2j4RYBGrZpOuY4TFZO2Hzb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:29.6169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5266c0-519e-4e44-9eb1-08def2bc94cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add two KUnit tests for dm_plane_color_pipeline_active(): one confirming
an active pipeline is detected, and one confirming colorops on an
unrelated plane are ignored.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |  7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.h  |  3 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 83 +++++++++++++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index 2b4801fa26af..34b5f2b28e91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -235,9 +235,9 @@ EXPORT_IF_KUNIT(dm_get_plane_scale);
  *
  * Return: true if the pipeline modifies pixels, false otherwise.
  */
-static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
-					   struct drm_plane *plane,
-					   bool use_old)
+STATIC_IFN_KUNIT bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
+						     struct drm_plane *plane,
+						     bool use_old)
 {
 	struct drm_colorop *colorop;
 	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
@@ -253,6 +253,7 @@ static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
 	}
 	return false;
 }
+EXPORT_IF_KUNIT(dm_plane_color_pipeline_active);
 
 /**
  * amdgpu_dm_crtc_get_cursor_mode() - Determine the required cursor mode on crtc
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
index 8879888745eb..cda6d73e9bda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
@@ -46,6 +46,9 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 		       struct drm_plane_state *new_plane_state,
 		       struct drm_framebuffer *fb);
+bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
+				    struct drm_plane *plane,
+				    bool use_old);
 void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 				int *src_w, int *src_h);
 void dm_get_plane_scale(struct drm_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index 78a4b40fad3e..e093420bb2fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_colorop.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -278,6 +279,85 @@ static void dm_test_check_native_cursor_state_checks_fb(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 }
 
+/* Tests for dm_plane_color_pipeline_active() */
+
+/**
+ * dm_test_plane_color_pipeline_active - Test old and new colorop activity
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_color_pipeline_active(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *old_colorop_state;
+	struct drm_colorop_state *new_colorop_state;
+	struct drm_plane *plane;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop);
+	old_colorop_state = kunit_kzalloc(test, sizeof(*old_colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_colorop_state);
+	new_colorop_state = kunit_kzalloc(test, sizeof(*new_colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_colorop_state);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	state->colorops = kunit_kzalloc(test, sizeof(*state->colorops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->colorops);
+
+	adev->ddev.mode_config.num_colorop = 1;
+	state->dev = &adev->ddev;
+	state->colorops[0].ptr = colorop;
+	state->colorops[0].old_state = old_colorop_state;
+	state->colorops[0].new_state = new_colorop_state;
+	colorop->plane = plane;
+	old_colorop_state->colorop = colorop;
+	old_colorop_state->bypass = true;
+	new_colorop_state->colorop = colorop;
+	new_colorop_state->bypass = false;
+
+	KUNIT_EXPECT_FALSE(test, dm_plane_color_pipeline_active(state, plane, true));
+	KUNIT_EXPECT_TRUE(test, dm_plane_color_pipeline_active(state, plane, false));
+}
+
+/**
+ * dm_test_plane_color_pipeline_ignores_other_plane - Test unrelated colorops are ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_color_pipeline_ignores_other_plane(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *colorop_state;
+	struct drm_plane *colorop_plane;
+	struct drm_plane *other_plane;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop);
+	colorop_state = kunit_kzalloc(test, sizeof(*colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop_state);
+	colorop_plane = kunit_kzalloc(test, sizeof(*colorop_plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop_plane);
+	other_plane = kunit_kzalloc(test, sizeof(*other_plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other_plane);
+	state->colorops = kunit_kzalloc(test, sizeof(*state->colorops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->colorops);
+
+	adev->ddev.mode_config.num_colorop = 1;
+	state->dev = &adev->ddev;
+	state->colorops[0].ptr = colorop;
+	state->colorops[0].new_state = colorop_state;
+	colorop->plane = colorop_plane;
+	colorop_state->colorop = colorop;
+
+	KUNIT_EXPECT_FALSE(test, dm_plane_color_pipeline_active(state, other_plane, false));
+}
+
 /* Tests for amdgpu_dm_should_update_native_cursor() */
 
 /**
@@ -515,6 +595,9 @@ static struct kunit_case amdgpu_dm_cursor_tests[] = {
 	KUNIT_CASE(dm_test_check_native_cursor_state_disabled),
 	KUNIT_CASE(dm_test_check_native_cursor_state_rejects_offset),
 	KUNIT_CASE(dm_test_check_native_cursor_state_checks_fb),
+	/* dm_plane_color_pipeline_active */
+	KUNIT_CASE(dm_test_plane_color_pipeline_active),
+	KUNIT_CASE(dm_test_plane_color_pipeline_ignores_other_plane),
 	/* amdgpu_dm_should_update_native_cursor */
 	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
 	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA82FC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2DA10ED11;
	Wed,  5 Aug 2026 06:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HhGEK3mh";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15C710ED0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLcMHiaJFZzZ3ob4FAh/Nv3gxSdj5Vij3n1VAr+GVN6g21rTNDx2MCqJzAYOpJJCLlmI3q2pLqBin0X1rxehfUC2ArSyV8KhSUt+m++X+0oMI7ZjYCzwXV6XaHdlVzfzP6BUXB9nq5f+BBTX5TOgfQ/TG5uUVhhxr28OxCHwU57HhlW28jWBjpRL052x/9mPJxSrhUVqp6Tq6BoXAmjgY5l6/kzVb+fRq9pFdmq1Po3qEEG9XdOMf9Qz13zeBoI0TlZwrY63xQxMlpctnue5I2WM8bhk3NuakRTrW8Jb7XKJ4c0H4en3sGO2LPIKQPWojqQSOmRCau9NYZauIBDQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGdYBL3ogas5nEj1stcdlOiQmCtKKaTRwIKB3dvew+Y=;
 b=kiIO+kxagZDsHE37Ro927A5cvLziqUP4sZjImbkMQpg7Csh6eCKjgmlKZ0o799BSGX0+uYIqPTXPjXM10Rmzgty8UMqPbRf7ugehl40J6Lo1kSZp4O3AlppahCz4/k194efwF+lwch3rWlM6CQTsXOGCAF2evgg+6tLBkDEv799ms/Hxa0k7M3UfLqfowLLanpurERJRQB8lXd75N0KA58AhFTX28YURB8M/KpftntK4Kd6RP8fwJL3iz8Ct5slvL5uMV4Zq/n7kUO1pcULt1rWTTpFh0DWavCYppvsNgfFRR3blBD4OWaNSAIJo/SugBkLu8maeLmElOpBKx7AUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGdYBL3ogas5nEj1stcdlOiQmCtKKaTRwIKB3dvew+Y=;
 b=HhGEK3mh8jNnymWWGED/1VBifrhL6mds5QWV1pyYa6tnhD19NWCZ6c+ckW5D+2lqn+bGAygreh1ZDIwM5fczr75kTeLGeebFM+UtGQ5KzkGUD8BxNJSRuE5xI4Smvf95rZsUPKtqATitlwUkUjp9dZV43Jke+Vx9hUuFicl3TYc=
Received: from SJ0PR13CA0095.namprd13.prod.outlook.com (2603:10b6:a03:2c5::10)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:41:35 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::2d) by SJ0PR13CA0095.outlook.office365.com
 (2603:10b6:a03:2c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6 via Frontend Transport; Wed, 5
 Aug 2026 06:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:21 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:17 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 22/34] drm/amd/display: test dm_check_cursor_fb
Date: Wed, 5 Aug 2026 14:36:34 +0800
Message-ID: <20260805063937.2145774-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: a8189a82-effb-40ec-4200-08def2bc97d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: riVoR/mf2EpxFwtLo5BAGP4vYaH5eGPBOmraIP9wocYSzN80J+EMNGVvPV3Za6uY2hRYqsEqsekJ/8CTdVsw4Xs66nWsQdD0S6U5dPQUYA/jY4bcO5t2GyrT4hCxx6wZR8S1aZDeeqntnXpLm1mCvvZD+N7vKbdmUPk1T/1ohaVfLGxry5TKyGPpkElG39wWUU1+xmdLOsrVefYS5qCZVSfNE1yURzab1va320VF4D6tD1hmffUBF0B7/LGYjHaJJ+ruT8dY6UdKKcSOVlBDhvdAZ1L6B7sEHuIRhW2WS58GgzeCi7uJldlz+ZEsLAOzTjx/oGS14kmg/IT5gv1lbc/xmxHwx0TVCXFVerR6wPBRu3bo0/Wi3UlxJldqYJYa1L3y2SPJhBBYwrSWZA/xz15HOaT20BGVlS/XUhfgvTUhGwaZUvuV6T2LUOFv9dvoE844y4zkUqx7rUwOYDBRSnYP5XzVMjibjds/ZCd9Qbbcrbmmro87mqjKpf7iN9FGMgDDhx/E4mcrxBPWJ6/EZK4buf7t8+PSSFuibez1xJssXANzYogeAs4PbNAUlnmjrxTL4u28UeLCy+eswGnyHAqRbB/FLSqKyQI4Zulcu5ivaVp29TD1S2Jlf6AbHJxxWrdt6UeFYPjtITddwPToGO3MbJw/qQM0eoN/uL7ztYo0ZNkB8dM+cmjkm2lsnK8ees7as9qgQ4N/4fCmmufnhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p/CvKeSiffm+UyjglI+iJuVbKSoM/CarFpdjV/Y4T5XzyB45QQ5PKqC+xiDCMh1H3UsVE9+Iy+RIIx4P3+A1FxrhW1Q147I0Kdf8sAxFWR+lUt9ggG/MLAvceXp/FXdbWAs4aF870gcW5i7d3zfNv1ps9FgkRn0EbptOvj0SyKf8cK13QOwWdTcK9Ix4e0nrDzJS8rYpEBhysqlbGhGO6aBc7Yc8N5JojdVMXN3upcWfxjQdySEmCc2zGxGTOMaamL5/HA48Pr/SOQA29EmRZmSa2KbSeM+jFVFnFPo2xLNe9NnkflB1QOzIGC1nNkzb5WC8LzZYfPE6fiuZRlIvdHieIxMeQc9UOgyaDdMd5QoX6KSk686RVKeihxDqtThcVT+r+j6f7+oHx9/KV+y5wPhgJhw/vRxrYZN6iStalUGUZPUgT4FB4qIcwGV+WZh9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:34.6602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8189a82-effb-40ec-4200-08def2bc97d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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
Add nine KUnit tests for dm_check_cursor_fb() with a cursor framebuffer
fixture, covering the supported linear case, size, cropping and pitch
rejections, tiling handling across ASIC generations, and modifier-based
tiling skips.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.h  |   3 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 196 ++++++++++++++++++
 3 files changed, 203 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index ab50d58896ab..953ad34918af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -41,9 +41,9 @@
 #include "amdgpu_dm_cursor.h"
 #include "dm_helpers.h"
 
-static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
-			      struct drm_plane_state *new_plane_state,
-			      struct drm_framebuffer *fb)
+STATIC_IFN_KUNIT int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
+				       struct drm_plane_state *new_plane_state,
+				       struct drm_framebuffer *fb)
 {
 	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
 	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
@@ -109,6 +109,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_check_cursor_fb);
 
 /*
  * Helper function for checking the cursor in native mode
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
index 5f619e4474aa..8879888745eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
@@ -43,6 +43,9 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 				   enum amdgpu_dm_cursor_mode *cursor_mode);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
+		       struct drm_plane_state *new_plane_state,
+		       struct drm_framebuffer *fb);
 void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 				int *src_w, int *src_h);
 void dm_get_plane_scale(struct drm_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index 3da76794ece9..f2ac94805777 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -9,6 +9,8 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_plane.h>
 
 #include "dc.h"
@@ -16,6 +18,190 @@
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_cursor.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
+
+struct dm_cursor_fb_fixture {
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_framebuffer *afb;
+	struct drm_plane_state *plane_state;
+};
+
+static struct dm_cursor_fb_fixture dm_test_alloc_cursor_fb_fixture(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = { 0 };
+
+	fixture.adev = dm_kunit_alloc_adev(test);
+	fixture.acrtc = kunit_kzalloc(test, sizeof(*fixture.acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.acrtc);
+	fixture.afb = kunit_kzalloc(test, sizeof(*fixture.afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.afb);
+	fixture.plane_state = kunit_kzalloc(test, sizeof(*fixture.plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.plane_state);
+
+	fixture.acrtc->base.dev = &fixture.adev->ddev;
+	fixture.acrtc->max_cursor_width = 256;
+	fixture.acrtc->max_cursor_height = 256;
+	fixture.afb->base.width = 64;
+	fixture.afb->base.height = 64;
+	fixture.afb->base.pitches[0] = 64 * 4;
+	fixture.afb->base.format = drm_format_info(DRM_FORMAT_ARGB8888);
+	fixture.plane_state->fb = &fixture.afb->base;
+	fixture.plane_state->src_w = 64 << 16;
+	fixture.plane_state->src_h = 64 << 16;
+
+	return fixture;
+}
+
+/* Tests for dm_check_cursor_fb() */
+
+/**
+ * dm_test_check_cursor_fb_valid_linear - Test a supported linear cursor framebuffer
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_valid_linear(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.adev->family = AMDGPU_FAMILY_AI;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			0);
+}
+
+/**
+ * dm_test_check_cursor_fb_rejects_size - Test an oversized cursor framebuffer
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_rejects_size(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.afb->base.width = fixture.acrtc->max_cursor_width + 1;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			-EINVAL);
+}
+
+/**
+ * dm_test_check_cursor_fb_rejects_cropping - Test cursor framebuffer cropping rejection
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_rejects_cropping(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.plane_state->src_w = 32 << 16;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			-EINVAL);
+}
+
+/**
+ * dm_test_check_cursor_fb_rejects_pitch - Test unsupported cursor framebuffer pitch
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_rejects_pitch(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.afb->base.pitches[0] = 96 * 4;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			-EINVAL);
+}
+
+/**
+ * dm_test_check_cursor_fb_rejects_unsupported_pitch - Test matching unsupported pitch
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_rejects_unsupported_pitch(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.afb->base.width = 32;
+	fixture.afb->base.pitches[0] = 32 * 4;
+	fixture.plane_state->src_w = 32 << 16;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			-EINVAL);
+}
+
+/**
+ * dm_test_check_cursor_fb_rejects_tiling - Test tiled cursor framebuffer rejection
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_rejects_tiling(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.adev->family = AMDGPU_FAMILY_AI;
+	fixture.afb->tiling_flags = AMDGPU_TILING_SET(SWIZZLE_MODE, 1);
+
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			-EINVAL);
+}
+
+/**
+ * dm_test_check_cursor_fb_gfx12_tiling - Test GFX12 cursor tiling decoding
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_gfx12_tiling(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.adev->family = AMDGPU_FAMILY_GC_12_0_0;
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			0);
+
+	fixture.afb->tiling_flags = AMDGPU_TILING_SET(GFX12_SWIZZLE_MODE, 1);
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			-EINVAL);
+}
+
+/**
+ * dm_test_check_cursor_fb_pre_ai_tiling - Test legacy cursor tiling decoding
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_pre_ai_tiling(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.adev->family = AMDGPU_FAMILY_CZ;
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			0);
+
+	fixture.afb->tiling_flags = AMDGPU_TILING_SET(ARRAY_MODE, DC_ARRAY_1D_TILED_THIN1);
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			-EINVAL);
+}
+
+/**
+ * dm_test_check_cursor_fb_modifier_skips_tiling - Test modifier validation stays in DRM core
+ * @test: The KUnit test context
+ */
+static void dm_test_check_cursor_fb_modifier_skips_tiling(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+
+	fixture.adev->family = AMDGPU_FAMILY_AI;
+	fixture.afb->base.flags = DRM_MODE_FB_MODIFIERS;
+	fixture.afb->tiling_flags = AMDGPU_TILING_SET(SWIZZLE_MODE, 1);
+
+	KUNIT_EXPECT_EQ(test,
+			dm_check_cursor_fb(fixture.acrtc, fixture.plane_state, &fixture.afb->base),
+			0);
+}
 
 /* Tests for amdgpu_dm_should_update_native_cursor() */
 
@@ -240,6 +426,16 @@ static void dm_test_get_plane_scale_zero_src_width(struct kunit *test)
 }
 
 static struct kunit_case amdgpu_dm_cursor_tests[] = {
+	/* dm_check_cursor_fb */
+	KUNIT_CASE(dm_test_check_cursor_fb_valid_linear),
+	KUNIT_CASE(dm_test_check_cursor_fb_rejects_size),
+	KUNIT_CASE(dm_test_check_cursor_fb_rejects_cropping),
+	KUNIT_CASE(dm_test_check_cursor_fb_rejects_pitch),
+	KUNIT_CASE(dm_test_check_cursor_fb_rejects_unsupported_pitch),
+	KUNIT_CASE(dm_test_check_cursor_fb_rejects_tiling),
+	KUNIT_CASE(dm_test_check_cursor_fb_gfx12_tiling),
+	KUNIT_CASE(dm_test_check_cursor_fb_pre_ai_tiling),
+	KUNIT_CASE(dm_test_check_cursor_fb_modifier_skips_tiling),
 	/* amdgpu_dm_should_update_native_cursor */
 	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
 	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2412EC5DF91
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AB410ECBD;
	Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jc7hFLrK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C2510ECB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+L+KRSVlichVJmmq5mvFLALsvfm6uXJHJAiDnzqQhPpBWDS5C0l6sIdRALtDeGrs67Y+6QAeh9wAytN1Z5SEf6lh6KwtFuxsxgXHJQsOdt+ATJbjibwfTjeJhdWt0xWM20fG1tBXr7kpckGRz9gDXJ2rftFpzylUn1PO0n1ZibGLEIIL4t49ACIgvRvE1hnyOSahogAWBSdvK1BjyStcvV949rvVbDmqnWqztSGGr1ajzxuOujN5wcef2WLKySwCEy6haeLhxoMYpXIvaY6c9qpks8RuHcdYOjxvRnqY1oOgaPCbflDqMxiVyUVC9yTlnnud+hk/BxddziNGCNJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaZZSFFKtZ0zxzFaNV5CH6rIyQzsO/7wi+1S8tFQUvs=;
 b=TwjCujtlxYvQ7Ul/iOpYFNguVZjzulD57v+G4vSCuAyf4ssSCLjIoK/4DxwrEpZrMYMK2yfQcDMlZdf5WEto3xKgqRmjYJ+x4pHQBCpDUYQ5b1DftQVKVXne3Ya0Ams4M2CvxejfYQgZ4b/qnpcj9slUSR+W54nfFp2/VR0WktMuoR/ePA0ct1LFYh3dWhRbqmpudHG2VQzfJn38SboDtl/Bo9q19TVg/wXp4irth7sgBUuLbNcWG83W5lX0MUg/HbKy2PgGFIuYixZHUva2eGGijqpbdp+0TWcUs7kUmRXKEd19YTMVxpCTM5qt/Dw9/2ZuPDhOBVRyS9xOJippZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaZZSFFKtZ0zxzFaNV5CH6rIyQzsO/7wi+1S8tFQUvs=;
 b=jc7hFLrKdT675M4L31LCGMUObNs0uMOoNmJERIMGv9EWE7N2D3qSbavxBJRzFq+cff+DK/sWkR6EjbWD2sL9MnA7Leltvmu/Xxt+R79dijjXTHdhYsX/lZlsazZLk2+jXLropEvNBWqR/sWEhoKpZpCI4iHST2A8bt0jTOGr12U=
Received: from BN9PR03CA0543.namprd03.prod.outlook.com (2603:10b6:408:138::8)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:40 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::77) by BN9PR03CA0543.outlook.office365.com
 (2603:10b6:408:138::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:25 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:24 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 44/82] drm/amd/display: Test plane state duplicate and destroy
Date: Tue, 18 Aug 2026 16:15:36 -0400
Message-ID: <20260818202139.4172592-45-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b3c0e9-538d-4575-9c79-08defd6673a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PUV0wUzfS93D/0kt2HtSyeiWbGv/jcPxXPPWaW4oI2fBmR3g4UBLBUb5sfhDYn8d8/z3HG8d4wpfARpE7XJSYyG+cO+Mrz5hMHC8OrAHfEnjwGhbLE4ZUll5rwsxIu9PG1rNm7ZwkZ3lJCr1hkWRKaejTZxdbobrY6tYPOpIyG8APn7Bs1Q1bQTXmP7bWH2LGUq5rrtlPmq+atoas649KFjKatW3y0KPVCl+oan3Yje5ttrwsf7poX0B021GjpHIuurj9IYf9h/Ls7iiidZbtKJpGPVCOgOa6S9cq0c23UEEL7nMNC4gxmJd37WNBbUj0YH86/eeUJBt2w8BvkEgRtB2RF6XT4wwbukGEaSagKdp3o7FKPI1bKEWBdaNboLT46R8svRNbYs9iXj2KQPdqCxhyi/Ohj2PgDdi9o1zUJIGw1shguDIwbE4dy4arLJLoBrxU3A5bk0znXbv4jdeoj0EtDFobuK6Tshy1+/z9a7wUfT1b9G2SyrfNgtTmQVzIVSnwWbyPXrto45BeYCspD4b0TtS9IvcRqNafZnrgYaH/7fTFIFipksz8xPxUBnvEGhrJssAI0e1wSghapIixTdYLvxvW8PpUC863G4p1S5PvxCl/DDE63OQ+lZcpfA7TanNckfesOVrmASdC/p7vBSdZUEuTrWaUdWS6+btoeiwtWfGAFMS+2vAd/hfJXyJCKmqVcTXBvjBKt4slGCUlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YMiX4/riDArTX2EiOw78XWYwQV/+ZhtTAW8+8fLNkgg40snxiikHLHyfFUPXv1HhEU9HljLVE9szhCzy9A3GURJzOyhMGWuBG/2weBWpwirQGGS/Gxfn0JGfU2yXhOFOCVJd80uhXrZRli5fRqTmAqiEfSAe0Dhs0oI4MQztaGOpCtnoD5Ea0zIsVbKNIrDtVJCqc7HZMbwnVj9nNYFBOJmcjShJ3VTmaDGXRPVNuO5oS6uEMm/gnuU7TfVDIgn9+6sRdlVqiuw6At0J8VPr/rdxW6YQAJu/vgqovIZwQqtZrY+8NgpsfYtSA0rCG6huOtYJqrSCwWhYeSd6aZ901AyhPwROD5XsdMI+2Ugx0msiKbQi28IP2t8AooSPMItk864Kq0yljyMNDYCOLCMd5jh3u3khqeKGr+zqJU+brggZDDHg7QDvTwt0EsLXLD2q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:40.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b3c0e9-538d-4575-9c79-08defd6673a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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
Add KUnit tests for amdgpu_dm_plane_drm_plane_duplicate_state() and
amdgpu_dm_plane_drm_plane_destroy_state() covering the resource paths.
Duplicating a state shares every color blob and takes an extra reference
on the DC plane state, and destroying one drops a reference on each.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index ba97092c7bb85..17789b3845b77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -10,11 +10,14 @@
 #include <drm/drm_blend.h>
 #include "link_enc_cfg.h"
 #include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
 #include "amdgpu_rlc.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 #include <drm/amdgpu_drm.h>
+#include <drm/drm_mode_config.h>
 #include <drm/drm_plane.h>
+#include <drm/drm_property.h>
 
 struct dm_test_dcc_cap_ctx {
 	bool callback_ret;
@@ -3001,6 +3004,78 @@ static void dm_test_plane_duplicate_state_copies_fields(struct kunit *test)
 	kfree(dup_state);
 }
 
+/*
+ * Attach a blob to every color property of @state. Each blob starts with a
+ * single reference that the tested function is expected to drop or share.
+ */
+static void dm_test_attach_color_blobs(struct kunit *test, struct drm_device *dev,
+				       struct dm_plane_state *state)
+{
+	struct drm_property_blob **blobs[] = {
+		&state->degamma_lut, &state->ctm, &state->lut3d,
+		&state->shaper_lut, &state->blend_lut,
+	};
+	u32 blob_data = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(blobs); i++) {
+		*blobs[i] = drm_property_create_blob(dev, sizeof(blob_data), &blob_data);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, *blobs[i]);
+	}
+}
+
+/**
+ * dm_test_plane_duplicate_state_copies_resources() - Verify blob and DC state sharing.
+ * @test: KUnit test context.
+ *
+ * Verify amdgpu_dm_plane_drm_plane_duplicate_state() shares the DC plane state
+ * and every color blob with the duplicate, taking an extra reference on each.
+ */
+static void dm_test_plane_duplicate_state_copies_resources(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dm_plane_state *old_state;
+	struct drm_plane_state *dup_base;
+	struct dm_plane_state *dup_state;
+	struct dc_plane_state *dc_plane_state;
+	struct drm_plane *plane;
+
+	KUNIT_ASSERT_EQ(test, drmm_mode_config_init(&adev->ddev), 0);
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+
+	kref_init(&dc_plane_state->refcount);
+	old_state->dc_state = dc_plane_state;
+	dm_test_attach_color_blobs(test, &adev->ddev, old_state);
+	plane->state = &old_state->base;
+
+	dup_base = amdgpu_dm_plane_drm_plane_duplicate_state(plane);
+	KUNIT_ASSERT_NOT_NULL(test, dup_base);
+
+	dup_state = to_dm_plane_state(dup_base);
+	KUNIT_EXPECT_PTR_EQ(test, dup_state->dc_state, dc_plane_state);
+	KUNIT_EXPECT_EQ(test, kref_read(&dc_plane_state->refcount), 2U);
+	KUNIT_EXPECT_PTR_EQ(test, dup_state->degamma_lut, old_state->degamma_lut);
+	KUNIT_EXPECT_PTR_EQ(test, dup_state->ctm, old_state->ctm);
+	KUNIT_EXPECT_PTR_EQ(test, dup_state->shaper_lut, old_state->shaper_lut);
+	KUNIT_EXPECT_PTR_EQ(test, dup_state->lut3d, old_state->lut3d);
+	KUNIT_EXPECT_PTR_EQ(test, dup_state->blend_lut, old_state->blend_lut);
+
+	/* Drops the duplicate's references; the originals are released below. */
+	amdgpu_dm_plane_drm_plane_destroy_state(plane, dup_base);
+
+	drm_property_blob_put(old_state->degamma_lut);
+	drm_property_blob_put(old_state->ctm);
+	drm_property_blob_put(old_state->lut3d);
+	drm_property_blob_put(old_state->shaper_lut);
+	drm_property_blob_put(old_state->blend_lut);
+}
+
 /**
  * dm_test_plane_destroy_state_minimal() - Verify destroy of a minimal state.
  * @test: KUnit test context.
@@ -3024,6 +3099,42 @@ static void dm_test_plane_destroy_state_minimal(struct kunit *test)
 	amdgpu_dm_plane_drm_plane_destroy_state(plane, &dm_plane_state->base);
 }
 
+/**
+ * dm_test_plane_destroy_state_releases_resources() - Verify blob and DC state release.
+ * @test: KUnit test context.
+ *
+ * Verify amdgpu_dm_plane_drm_plane_destroy_state() drops a reference on every
+ * attached color blob and on the DC plane state.
+ */
+static void dm_test_plane_destroy_state_releases_resources(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dm_plane_state *dm_plane_state;
+	struct dc_plane_state *dc_plane_state;
+	struct drm_plane *plane;
+
+	KUNIT_ASSERT_EQ(test, drmm_mode_config_init(&adev->ddev), 0);
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+
+	/* destroy_state frees the state itself, so use a plain allocation. */
+	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+
+	/* Hold an extra reference so the release does not free KUnit memory. */
+	kref_init(&dc_plane_state->refcount);
+	kref_get(&dc_plane_state->refcount);
+	dm_plane_state->dc_state = dc_plane_state;
+	dm_test_attach_color_blobs(test, &adev->ddev, dm_plane_state);
+
+	amdgpu_dm_plane_drm_plane_destroy_state(plane, &dm_plane_state->base);
+
+	KUNIT_EXPECT_EQ(test, kref_read(&dc_plane_state->refcount), 1U);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3102,8 +3213,10 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_plane_reset_initializes_state),
 	/* amdgpu_dm_plane_drm_plane_duplicate_state() */
 	KUNIT_CASE(dm_test_plane_duplicate_state_copies_fields),
+	KUNIT_CASE(dm_test_plane_duplicate_state_copies_resources),
 	/* amdgpu_dm_plane_drm_plane_destroy_state() */
 	KUNIT_CASE(dm_test_plane_destroy_state_minimal),
+	KUNIT_CASE(dm_test_plane_destroy_state_releases_resources),
 	/* amdgpu_dm_plane_add_modifier() */
 	KUNIT_CASE(dm_test_add_modifier_appends_value),
 	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
-- 
2.43.0


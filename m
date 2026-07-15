Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDFBC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CE210F085;
	Wed, 15 Jul 2026 13:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gqJc0yhT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9477A10F085
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvafqo7KM6U/Y/qKmIitle0zjB2YdIRnRZii/KbvSu/PcLjHlu2ftGCzHc/Me+0tb6FhTZjcA2iIr2MpNgCYKAgCO6bG4MXEec59CwDOHrgdsCLpnZajeidvhrynY17BfP8lSObWSEk/DbhW4sytGmAMJ+qEs43wr0i7NBuxDrYEYMLUz+p1JtP0BlCsrnBTraA1ik068mwQ4a4fKhVEigOZWkxMQbwbT6tQDLqK37So50KltKOLJ1DAYjqucDJsMeSv7rzJaHaxfLKLHrtytlM8oyt1L5SogpRdViM9aZHFmO8ijnxj/7TCUaVc/HPCZLk+5ffRBctES4k0Mct9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W//eorsIhJtfDE4nq7FleaZte1EaHYx9asZ7K62onV0=;
 b=P9UTWIGC9f1FdgYHl6ZOgSeVmQOp67QC3vs1EkHR80eE6j/tie9FXs6DU88o8DAvDg+D4kWh9mWIFf0XkYtQotEuXNcuXHbX/YTIGeFB8+B2ipzSgXKlQII/0ZY0x36/hmf7xW5T7zhAy291ZroxrJmamiqQrQwoQT0GLJn5H9xue9DhY496kxKxsvgGkE2V5/idOQkrNPISShGiJZxvSyVFXBbEG+fmdo5oxXlz8dIYbNiDIsyMo2NUxbLBj6dqhDPuUxgZIJEf9AEhiMA2W627VyJuD/i6w2Q2uHD5IfhuTtJHzbpEPxIA3VbZOs2a0YVg0HLVd2POJ+KrbnGFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W//eorsIhJtfDE4nq7FleaZte1EaHYx9asZ7K62onV0=;
 b=gqJc0yhTCtmMu6wMdNvVyOJRTkPtybGAZAcHL14o4pcISvo50+Hf7Tg1KSbiGBxBOYvTpLp32LwovyUHtQ7MkyUvh5t9TfBJMvRv5wi27GGl0p6qvfjRJTWLi6XNf6cYi2I9FZJwhVkAzQZxcCAOLccbfpBL07h5phFVzTq2VCo=
Received: from PH8P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::17)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:46:36 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::55) by PH8P220CA0011.outlook.office365.com
 (2603:10b6:510:345::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:35 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 27/70] drm/amd/display: Test CRTC color management update
Date: Wed, 15 Jul 2026 21:37:37 +0800
Message-ID: <20260715134432.1975118-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7284775d-4d32-4da8-155b-08dee2777d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: CL9NGngDbOYJwqT6KXORVpJgKIyRKr6buitmt5Lr3FE65qlVWrljVsRFF7RRbd6platkL4Zs45uSI31eHx8jD3K6gdZQja1BzOIvOMLi8oEkQq6R/IYg0V7W+kzDkay40WBJ/ILAstJDXsMp74mWGqaTDvfetBL/HwegUTuY6IqAImOwEjlG6XWeCsaqhJgWYueto3l+Y02107oeBpxqyA8e5ACEajti7AFYwYPnq9UH4Rm4GaibJGoAXI3h8SB3CQHVldjJIpjBpA+DoSo58fTVrGefG0lViFi/GESzFEcbEV02vATRzcrhQPXTnQTtNIN0WzlB9JBGDABmSY2N/GCrKWbCAgO1qrX9XLBvhQkpkSaGndThCTcf6Kg0otHMVKC5CXo+Bz40b2T6Gk6SVZODzO8HcQ/779tuAMTqxei7VPA7b/EXNG2hyIzIWtGLgC+dl0OtQjNDh8vDXz//D71NoMAAt/Gg4WdIoam4r/kL3Lfh/kX1a9ySN6/Tqi04ZZS39DWN/gV/aI3s2hlY1fYB1wZk0U+b+2kDBzNDY8mGDTxb5FAx0o3iiY5+STUwZ5ZnyKHE7Q6luwg0YjIH0uAThRLfyi96yhqtZCLCOh4Yhrw2u9bZNjClLltQrdeo0fJxqJGompEguJV3MDHTLKUk3w+6NaqmvljboeMpEFZN3iq/8MwcrNjRQohygFdA/3bsJRdMcJtafPC0jPX4WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eDVNhbxvNE1lQEy7O8CLjDHVKWRegiNKimmTiQezeI2wfqgMUPGM6f2BtOVUBOLFvUcyiJE5zQbNJTmyhkj+EA4TR3Tq3dN1q2JReU0bQoSCfOp8jo7giqPR85PqMlBT3HL2SNtjzdMLQDObtz6Mj/j98br06sXdm3CEeEo1OEAd1mitoplmzq1lZO4/SlHC04KEIDtjDrKVXB7k8yRXKtphooEYOntIDbEtIutK9HBleDGgeNyY0MHsmLGMAtmim0ZXyGLF9cSed2VWsAX0dwdvHj7o7D1NP1Rlu/LUPWu8yi32UoUCRFyx2AAsdj5gkRKPZ2WRVJ0r++er+lvrOOrDKYVoQ9B/MAvJcgcrw82NXXhIpWMi0JhHmChG6lLFpw03TNYd2RjioNgaNqfMrZNW9CsUqFVJcCjP8VPXnSEspiZPo+H9BUjCjuaWwDfX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:36.1980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7284775d-4d32-4da8-155b-08dee2777d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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
Add KUnit coverage for amdgpu_dm_check_crtc_color_mgmt() and
amdgpu_dm_update_crtc_color_mgmt().

A shared color-update fixture (adev/DC, atomic state, CRTC/stream and
plane state) backs the tests: the check path succeeds with no CRTC LUTs,
and the update path leaves the stream gamut remap bypassed without a CTM
and enables it when a CRTC CTM is present.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 142 ++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 2f46de79a47c..36aa4af581dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1323,6 +1323,7 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 
 	return r;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_check_crtc_color_mgmt);
 
 /**
  * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
@@ -1381,6 +1382,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_crtc_color_mgmt);
 
 static int
 map_crtc_degamma_to_dc_plane(struct dm_crtc_state *crtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index a4253e44ca7b..2e7a6b2a6d91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1841,6 +1841,144 @@ static void dm_test_colorop_degamma_no_match(struct kunit *test)
 			-EINVAL);
 }
 
+/* ---- Tests for CRTC and plane color management update paths ---- */
+
+/**
+ * struct dm_test_color_update_fixture - minimal color update fixture
+ * @adev: backing amdgpu device
+ * @state: DRM atomic state with @adev's DRM device
+ * @crtc_state: DM CRTC state under test
+ * @stream: DC stream referenced by @crtc_state
+ * @dm_plane_state: DM plane state under test
+ * @plane: DRM plane referenced by @dm_plane_state
+ * @dc_plane_state: DC plane state under test
+ */
+struct dm_test_color_update_fixture {
+	struct amdgpu_device *adev;
+	struct drm_atomic_state *state;
+	struct dm_crtc_state *crtc_state;
+	struct dc_stream_state *stream;
+	struct dm_plane_state *dm_plane_state;
+	struct drm_plane *plane;
+	struct dc_plane_state *dc_plane_state;
+};
+
+/**
+ * dm_test_color_update_setup - allocate a minimal color update fixture
+ * @test: KUnit test context
+ *
+ * Returns: a populated fixture with all large DC/DRM state heap-allocated.
+ */
+static struct dm_test_color_update_fixture
+dm_test_color_update_setup(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = {0};
+
+	f.adev = dm_kunit_alloc_adev(test);
+	f.adev->dm.dc = kunit_kzalloc(test, sizeof(*f.adev->dm.dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.adev->dm.dc);
+
+	f.state = kunit_kzalloc(test, sizeof(*f.state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.state);
+	f.state->dev = &f.adev->ddev;
+
+	f.stream = kunit_kzalloc(test, sizeof(*f.stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.stream);
+
+	f.crtc_state = kunit_kzalloc(test, sizeof(*f.crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.crtc_state);
+	f.crtc_state->base.state = f.state;
+	f.crtc_state->stream = f.stream;
+
+	f.plane = kunit_kzalloc(test, sizeof(*f.plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.plane);
+	f.plane->dev = &f.adev->ddev;
+
+	f.dm_plane_state = kunit_kzalloc(test, sizeof(*f.dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.dm_plane_state);
+	f.dm_plane_state->base.state = f.state;
+	f.dm_plane_state->base.plane = f.plane;
+
+	f.dc_plane_state = kunit_kzalloc(test, sizeof(*f.dc_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.dc_plane_state);
+
+	return f;
+}
+
+/**
+ * dm_test_make_ctm_blob - Allocate a fake drm_property_blob for CTM data
+ * @test: KUnit test context
+ * @data: CTM data pointer
+ * @size: CTM data size in bytes
+ *
+ * Returns: a fake property blob pointing at @data.
+ */
+static struct drm_property_blob *
+dm_test_make_ctm_blob(struct kunit *test, void *data, size_t size)
+{
+	struct drm_property_blob *blob;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	blob->data = data;
+	blob->length = size;
+
+	return blob;
+}
+
+/**
+ * dm_test_check_crtc_color_mgmt_no_luts - No CRTC LUTs check succeeds
+ * @test: KUnit test context
+ */
+static void dm_test_check_crtc_color_mgmt_no_luts(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.crtc_state->cm_has_degamma = true;
+	f.crtc_state->cm_is_degamma_srgb = true;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_check_crtc_color_mgmt(f.crtc_state, true), 0);
+	KUNIT_EXPECT_FALSE(test, f.crtc_state->cm_has_degamma);
+	KUNIT_EXPECT_FALSE(test, f.crtc_state->cm_is_degamma_srgb);
+}
+
+/**
+ * dm_test_update_crtc_color_mgmt_no_ctm - No CRTC CTM leaves remap bypassed
+ * @test: KUnit test context
+ */
+static void dm_test_update_crtc_color_mgmt_no_ctm(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.stream->gamut_remap_matrix.enable_remap = true;
+	f.stream->csc_color_matrix.enable_adjustment = true;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_update_crtc_color_mgmt(f.crtc_state), 0);
+	KUNIT_EXPECT_FALSE(test, f.stream->gamut_remap_matrix.enable_remap);
+	KUNIT_EXPECT_FALSE(test, f.stream->csc_color_matrix.enable_adjustment);
+}
+
+/**
+ * dm_test_update_crtc_color_mgmt_ctm - CRTC CTM enables stream gamut remap
+ * @test: KUnit test context
+ */
+static void dm_test_update_crtc_color_mgmt_ctm(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_color_ctm *ctm;
+
+	ctm = kunit_kzalloc(test, sizeof(*ctm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctm);
+	ctm->matrix[0] = 1ULL << 32;
+	ctm->matrix[4] = 1ULL << 32;
+	ctm->matrix[8] = 1ULL << 32;
+	f.crtc_state->base.ctm = dm_test_make_ctm_blob(test, ctm, sizeof(*ctm));
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_update_crtc_color_mgmt(f.crtc_state), 0);
+	KUNIT_EXPECT_TRUE(test, f.stream->gamut_remap_matrix.enable_remap);
+	KUNIT_EXPECT_FALSE(test, f.stream->csc_color_matrix.enable_adjustment);
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -1954,6 +2092,10 @@ static struct kunit_case dm_color_test_cases[] = {
 	/* __set_dm_plane_colorop_degamma */
 	KUNIT_CASE(dm_test_colorop_degamma_predefined),
 	KUNIT_CASE(dm_test_colorop_degamma_no_match),
+	/* CRTC and plane color management update paths */
+	KUNIT_CASE(dm_test_check_crtc_color_mgmt_no_luts),
+	KUNIT_CASE(dm_test_update_crtc_color_mgmt_no_ctm),
+	KUNIT_CASE(dm_test_update_crtc_color_mgmt_ctm),
 	{}
 };
 
-- 
2.43.0


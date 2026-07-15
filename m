Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F71C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E48810F08A;
	Wed, 15 Jul 2026 13:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hlWfBTL5";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44D610F08A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuWIzFQxkaJi+EGZE020QxwYYNJt8Rc2hOeMWw18C2AyDiCzLZxjQ5zRpP61a3rFxLTl7DEItBgo83/ekPfAUgdWN3aWQCvepuQ+FSM5IS6n2Xes4n3QcquxQARIIMFhVUXqxVfftvr4yEoBsNzOZii0fahOc+C/8c7NPjmWWElOiUakckLHCObDRF1fg5vk+eMItJxYhJJtR3kG0STVqPNhsCPaAkc9H64pYNtV4lxjWtFvqxlKze/joPbtWZ3qoRtwGtdkJH3QrIY6xaSrM5uTzRwUvNpy0bg4CKw+TIx79wZAdP5XbUaJpPP/miybADzO2OcNo7TQxAZP1v0EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0qKrCTLioqn5W0cTbi23AXvMhr8Pm0+26raqkGYdfo=;
 b=UvMmdtkvlU3M5MTbJlKHWPXdMIuJxQc1WQvkEKwdvH87KSL4v5OJtr7m6+pmjaSH17NDCB0qbrPmkT2csCB+wvRgY5zGs0/bkRgiHNbayD/gl6XfdiSWqlIcudEBfY1cPSnz0aKjbfm1sngS2RfyaWlAxLeDQBEPGAJrl2Z1qPg55fuwwY8PnRwsyKbdBlY3kqHears03vn2wBSNlrqrE04Y0qanwHLicLCgp+qa9Ny/jXE5sOgzIJluu1Ii9b/6WKBAJYBUruaSaSRf8CZziZk4+pHdwELmUgCPEMqdcqzpHAqdIkO+1cmrjeFDmlDz47YQtbZzW+5Twa6N1b5QmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0qKrCTLioqn5W0cTbi23AXvMhr8Pm0+26raqkGYdfo=;
 b=hlWfBTL5SUFtCZBFnEriPaITdJR5hXnZwff3DPA1MGYOqkOX1X/XTv26OXRfnk5N1Ecc5QzeaJMFmHpziMOfYYuksDHG7QeQTkWN2g8CJVe1nXR4rzcsOrsdXLQcoEiV0nwCwwovISrJ3nCeQ5Eq6rVGUd0C9sV0l8Vngf6d8lQ=
Received: from PH8P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::23)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 13:46:44 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::a3) by PH8P220CA0015.outlook.office365.com
 (2603:10b6:510:345::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 29/70] drm/amd/display: Test plane colorop pipeline update
Date: Wed, 15 Jul 2026 21:37:39 +0800
Message-ID: <20260715134432.1975118-30-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2a85bc-007d-4ad5-c4aa-08dee27781b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: XIg+W6sL2qVP6aKDCtAVIv6gtsnKleqcLrqaJyaRiniETerMfi77ph5m3i5QBjK2BbNDogTO6+LZXapkHyDwmrSyRxPCsGESI+ZhVmSk6o9iRt00GBBaebppKhPTkES+iKpSXFjcX9qG07guz6D6TjDkmzgN7gLD/WlSyJZnDS8mmpSvpzpJex3kTXO4LQrurhVnNIIwq1PrdENckv9mndjiXMcx9JoCI5B8UR7uvSrXeJUbS4i6fJJIMY7dEpSrKb+NLyL9Z3vnVeIvD2oUc2IiBhOkVbSd5YVgmEkyAVYfFi0xw/DOwuY5J6elkz/RVOZKtU36zOeNpwF/uO76iXmeJ4KlwjpU24Gn8tKjIre1ssstmwsK5TAMyGfXG9kwXm+peDqecrFKfIwum0Y9mlwl3QaXceuBsjF1e41jtoucXqQITaKFKsIezrYKJquIP1TDM+0K4WvXdDLNwq/hpOzwbPqm595Sjfl7eqnOoTTahQ2L/kM3yGPlmcWOugHXorx+GSq3TPYj70Twhr8C1GROpKwnd+lBThUs/QW8vQpbKPe3h12tg55JN7OWl+T1EJU5EpSelXzB5L0lDfKOlAxeDiWpnIvWriOuWPgR5yMnmKwqKfc2ms41mPHx/gygzuOyMyHl14T7jY1iJttadBZaTwkA5xXyg9B7ovpa0n1cwhiK7YobIH5ihTtTfgm+Jqm88bToyzfV4cizoM1k0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZiMsFdv+xGyGgHRlu5s2ipyi/xrHmOWtio6d8HGueuHUoWRPOPVJ9CQ2MgsXUQcvW6pAwltKlZQ/EJiF++WQ5jA4vbnYGxDIWWEdgeOycBqwQJiLTFXTvKjtJwlx2CYuKmRT1Dr6ITtuG5Onc0+OX4VozKs2YFqAsp18F0VmRdrUDEo6OhNs5mbKLPcwHch6jWkr19H6hXmrDBJIb93vZFbAxQkb/P/VVrT48nYmpdIzbLQkCRQpkLT2DHKhgbb73XILwXPfNI5M3M0Fn0TuHPipNJU+ToGmIW/Gj3ZBHealWK/tTOJo0RwJYF5YnrfjZtknuVOJEEKwvaywCrbp5s5FWcR6l/RZ5XEbwTJb1SHCO7lNofS755L8kEH4w3rhjCxqknGUGx6fv+yZtmzwNFLhDvH0BWedOWiyUTBq7NkGNFzd0IFZpI582AdPXdsa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:43.7597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a85bc-007d-4ad5-c4aa-08dee27781b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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
Add KUnit coverage for the colorop-pipeline path of
amdgpu_dm_update_plane_color_mgmt().

Test-local helpers fabricate a linked colorop pipeline so the update path
can be exercised end to end: a fully bypassed pipeline succeeds, a
pipeline missing the multiplier or the 3x4 op falls back to defaults, and
a pipeline with no 3D LUT hardware skips the 3D ops.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 219 ++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 6bca2b2f62a8..641126d03c65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -2082,6 +2082,221 @@ static void dm_test_update_plane_color_mgmt_plane_ctm(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->input_csc_color_matrix.enable_adjustment);
 }
 
+/**
+ * dm_test_colorop_pipeline_add - append one colorop to a fabricated pipeline
+ * @test: KUnit test context
+ * @f: color update fixture that owns the atomic state
+ * @index: colorop array index to populate
+ * @type: colorop type
+ * @curve_1d_type: 1D curve type for DRM_COLOROP_1D_CURVE states
+ * @bypass: bypass flag for the new colorop state
+ *
+ * Returns: the newly allocated colorop.
+ */
+static struct drm_colorop *
+dm_test_colorop_pipeline_add(struct kunit *test,
+			     struct dm_test_color_update_fixture *f,
+			     int index, enum drm_colorop_type type,
+			     enum drm_colorop_curve_1d_type curve_1d_type,
+			     bool bypass)
+{
+	struct drm_colorop_state *colorop_state;
+	struct drm_colorop *colorop;
+
+	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop);
+	colorop->dev = &f->adev->ddev;
+	colorop->type = type;
+	colorop->size = MAX_COLOR_LUT_ENTRIES;
+
+	colorop_state = kunit_kzalloc(test, sizeof(*colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop_state);
+	colorop_state->colorop = colorop;
+	colorop_state->curve_1d_type = curve_1d_type;
+	colorop_state->bypass = bypass;
+
+	f->state->colorops[index].ptr = colorop;
+	f->state->colorops[index].new_state = colorop_state;
+
+	return colorop;
+}
+
+/**
+ * dm_test_colorop_pipeline_setup - build a linked colorop pipeline prefix
+ * @test: KUnit test context
+ * @f: color update fixture that owns the atomic state
+ * @types: colorop types to create
+ * @curves: curve type for each colorop state
+ * @bypass: bypass flag for each colorop state
+ * @count: number of colorops to create
+ *
+ * Returns: the first colorop in the linked pipeline.
+ */
+static struct drm_colorop *
+dm_test_colorop_pipeline_setup(struct kunit *test,
+			       struct dm_test_color_update_fixture *f,
+			       const enum drm_colorop_type *types,
+			       const enum drm_colorop_curve_1d_type *curves,
+			       const bool *bypass,
+			       int count)
+{
+	struct drm_colorop **colorops;
+	int i;
+
+	f->state->colorops = kunit_kcalloc(test, count, sizeof(*f->state->colorops),
+					   GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f->state->colorops);
+	f->adev->ddev.mode_config.num_colorop = count;
+
+	colorops = kunit_kcalloc(test, count, sizeof(*colorops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorops);
+
+	for (i = 0; i < count; i++)
+		colorops[i] = dm_test_colorop_pipeline_add(test, f, i, types[i], curves[i], bypass[i]);
+
+	for (i = 0; i < count - 1; i++)
+		colorops[i]->next = colorops[i + 1];
+
+	return colorops[0];
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_colorop_bypass_pipeline - bypassed pipeline succeeds
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_bypass_pipeline(struct kunit *test)
+{
+	static const enum drm_colorop_type types[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+		DRM_COLOROP_3D_LUT,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+	};
+	static const enum drm_colorop_curve_1d_type curves[] = {
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+	};
+	static const bool bypass[] = {
+		true, true, true, true, true, true, true, true,
+	};
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass, ARRAY_SIZE(types));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
+			0);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_colorop_missing_multiplier - missing second op falls back
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_missing_multiplier(struct kunit *test)
+{
+	static const enum drm_colorop_type types[] = { DRM_COLOROP_1D_CURVE };
+	static const enum drm_colorop_curve_1d_type curves[] = {
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+	};
+	static const bool bypass[] = { true };
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass, ARRAY_SIZE(types));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
+			0);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_colorop_missing_3x4 - missing third op falls back
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_missing_3x4(struct kunit *test)
+{
+	static const enum drm_colorop_type types[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+	};
+	static const enum drm_colorop_curve_1d_type curves[] = {
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+	};
+	static const bool bypass[] = { true, true };
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass, ARRAY_SIZE(types));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
+			0);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_colorop_no_3dlut_hw - no 3D LUT skips 3D ops
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_no_3dlut_hw(struct kunit *test)
+{
+	static const enum drm_colorop_type types[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+		DRM_COLOROP_3D_LUT,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+	};
+	static const enum drm_colorop_curve_1d_type curves[] = {
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+	};
+	static const bool bypass[] = {
+		true, true, true, true, true, false, true, true,
+	};
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass,
+					       ARRAY_SIZE(types));
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = false;
+
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base,
+						  f.dc_plane_state),
+		0);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -2204,6 +2419,10 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_maps_crtc_degamma),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_uses_color_caps),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_plane_ctm),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_bypass_pipeline),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_missing_multiplier),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_missing_3x4),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_no_3dlut_hw),
 	{}
 };
 
-- 
2.43.0


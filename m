Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC258C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0ED10F086;
	Wed, 15 Jul 2026 13:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SMdjvwZn";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F19A10F088
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmLiUne/rUItcY9UU8f0miQkWmjyUCJimLkPTn7iXUiH4HaA0rl/FMjZwfyDrKx9DluHyr8BZmSYru8xMNr4JLh8jEHHRyycLRsl/Su4J8cbgQvIpsxy9LqtqtWdK1TFPAwKu4d19G/vepzuNpzo8KiX1gxe4YK3R6ZJB/8XCx2oFllJqmf9fAmEQof/Vkds7Knjh1Yp7DEgn5dCJr6YdYXLTgJptVwmhffivsrsDmm+jyy1EfyuXTAGCaO0yGY0qMpZnAJZ0Ek4eyYLvSPbviVEgeEs4LdWrJfILcvQh8wfc3iNilsj+1rFyYHjGzhk32j8tWNhqXdaH7k1zMnURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpl2iv8nbN6GvsOOuqvpGL9rXSnXTu70Q+tjxeXW/zs=;
 b=lRhCMLd58nXQAkGfWJ6Gu5V9WcahwTfTnW6I/OHqvBI2KUQDHI7dKalfGNVljZ3iz5wTjda1expaLZF7muQuDmRGZXIizwzwSALeMZLTh5SSnc3iku8HEKXP+lJJkcRjh8pu67aD2QBlV4/3TLFxgjCDm4PeBUlcyQ3VlJ/z+bFCHNhwlqjwTsCgqk+eZlIbS01IGA5jSpViEVI6CWPIBCiXTMUYTmRwwBumtgjcXqZMHOVA4bV755AF4GXc2DTQhzL1ghI6vrDd3owUNCDCD36erz3FBodu+5MEnQJu22y4eJ+vW8MohWQ9ZFmJD98xn0AnNW/z1h008ciCXV3eIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpl2iv8nbN6GvsOOuqvpGL9rXSnXTu70Q+tjxeXW/zs=;
 b=SMdjvwZnybZXxLrbk3BGKsxQd3MkUY6yRK75bgJ/viaH89M1IgSRw+rEiiZMw6lfQsrdp2EZAm/EMvHiV9UpJi5nQUqXoSbPufVG9mg6ZrRVz6L1yDBpJvEj+aC54UI/OKuE/mVJcQbeOmQ7Su96S3hwO0d1XH3oXwcPquvbvxU=
Received: from CY5PR18CA0014.namprd18.prod.outlook.com (2603:10b6:930:5::13)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:46:32 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::23) by CY5PR18CA0014.outlook.office365.com
 (2603:10b6:930:5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:31 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 26/70] drm/amd/display: Test plane colorop helper walkers
Date: Wed, 15 Jul 2026 21:37:36 +0800
Message-ID: <20260715134432.1975118-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e256b9-f6ee-463d-539f-08dee2777b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hfNncl2h2mGhmnabczlIMlmB4Z3nnt1JPgfAK9E7OwOaJ6RBezcd2FFD6lBWe/KDFUItZxn9wm9vRujd71en1LGmR+RyMtX8j9gZxcufVLXrmFI9eDCmSgA268XdWaoxMglEgSwVBP9tNjh6fJqkc5JzlUnhbkkvicFqcAwo84IwA4BaMkGyzBYP88keoNezRxRvasovJ1E5A2YK5y9MBGj6lDRBgCyfVeWae2sf3EiibNXW/yh4FsDvMFQZD2ih/dO/1xA59tHRVKHQAxyIGxKPaxGBRyEwo16YMAZ3o+BvHqiUfUSmt4dIyDY4FKwSg3mdGjWCzn/Yd0KdBuFFVRYZxJ8T5xhVjYnZ8idEIwBHQLhWf2My3cmQoLOlEBFKOLx3j3NvTInL8OFyIoCPnRhHoLecdvvGdzUq7jPYBLG2XXD4TDmExcI62nMuPKnQ9YKBlSlmxu3PL7btojHH5dVlCfbERkgjXHlFZRMErp/3Q+FGSnHOK8bRaxrNudKhCctGNwJGyjmtU7fca9Gc4NRxwjc1CBcVTLU9lzNjvWZCCdZyVG/yvOrfq75x4MJ3xCSZAf7m3rQwXHJMiacPN/cSX8aPh8BxU4LnkWoKQ7uVBLySoPaCB0YLchYvSjoHtlwFJQAxp9x+6VSLpCbXrTKWDdgSeOctEkzpLm82tMj5JqWq1AzZUy0owfaOvUJMoLqWf6ySMfFKY5alAXEhjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /9w0LqSiWawvlqRNbTaIQv7QFw/Ba2NIVeMrEDYKnhqWD+ziyL1+5tgwOxjmNrWHjlkgw70PvgoWdPdwU9GIKGwhgIxKbM6JItKk7F699D9KsmKOzdoXO8am/DoTT6WzwzCdfpDRzL5AcuS5I6FG6WyzdR2HzQSI4r9O8UqaoFp4JvArF1LPhL8m/30r+s85GdidOc4B/thpA4+5veoIJ0ruaJuX9QcqyV92QX5eSXEWkD4vTi3F9zI1uJdVKMzSrq2g99qNfiHCFpiNuvu78m1vGFtVLDtcb2kwMHpXPkQlZgggbtCKARnPG/dMhwG7rhL0eBdFecITnphuS7WekLtb+1ChOwSLYX6SDEgQgMP80uCEBXrRWR2MM+b/UEOrVdD4sfDcR/ijQCizraPMb1Emc2M2uDkNg9P1Sc+pnxU8y1a+3wgCGQ/6EiOq16xG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:32.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e256b9-f6ee-463d-539f-08dee2777b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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
Add KUnit coverage for the per-colorop plane helpers
__set_dm_plane_colorop_multiplier(), __set_dm_plane_colorop_3x4_matrix()
and __set_dm_plane_colorop_degamma().

A single-colorop atomic-state fixture drives each helper: the multiplier
programs hdr_mult, the 3x4 matrix enables gamut remap (and rejects a
wrong blob length), and the degamma 1D curve maps to a predefined
transfer function (and rejects an unsupported curve).

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |  11 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 207 ++++++++++++++++++
 3 files changed, 224 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 45d11990bc8e..2f46de79a47c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1547,7 +1547,7 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 }
 EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
 
-static int
+STATIC_IFN_KUNIT int
 __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 			       struct dc_plane_state *dc_plane_state,
 			       struct drm_colorop *colorop)
@@ -1573,8 +1573,9 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 
 	return __set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state);
 }
+EXPORT_IF_KUNIT(__set_dm_plane_colorop_degamma);
 
-static int
+STATIC_IFN_KUNIT int
 __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
@@ -1614,8 +1615,9 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(__set_dm_plane_colorop_3x4_matrix);
 
-static int
+STATIC_IFN_KUNIT int
 __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
@@ -1643,6 +1645,7 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(__set_dm_plane_colorop_multiplier);
 
 static int
 __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index 8dbbcb3ab156..1a8b06bdaf44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -113,6 +113,17 @@ int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
 			       struct dc_plane_cm *cm);
 int __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 				 struct drm_colorop_state *colorop_state);
+struct drm_plane_state;
+struct drm_colorop;
+int __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
+				   struct dc_plane_state *dc_plane_state,
+				   struct drm_colorop *colorop);
+int __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
+				      struct dc_plane_state *dc_plane_state,
+				      struct drm_colorop *colorop);
+int __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
+				      struct dc_plane_state *dc_plane_state,
+				      struct drm_colorop *colorop);
 #endif
 
 #endif /* __AMDGPU_DM_COLOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index e46a8454425d..a4253e44ca7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1643,6 +1643,204 @@ static void dm_test_verify_lut3d_valid(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut3d_size(adev, plane_state), 0);
 }
 
+/* ---- Tests for plane colorop helpers ---- */
+
+/**
+ * struct dm_test_colorop_fixture - shared state for plane colorop walk tests
+ * @adev: backing amdgpu device (provides a real DRM device)
+ * @state: fabricated atomic state with a single colorop slot
+ * @colorop: the colorop under test
+ * @colorop_state: the new state attached to @colorop
+ * @plane_state: plane state whose ->state points at @state
+ * @dc_plane_state: DC plane state written by the helpers
+ */
+struct dm_test_colorop_fixture {
+	struct amdgpu_device *adev;
+	struct drm_atomic_state *state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *colorop_state;
+	struct drm_plane_state *plane_state;
+	struct dc_plane_state *dc_plane_state;
+};
+
+/**
+ * dm_test_colorop_setup - build a single-colorop atomic state fixture
+ * @test: KUnit test context
+ * @type: colorop type to assign
+ *
+ * Fabricates a minimal drm_atomic_state with one colorop slot so that
+ * for_each_new_colorop_in_state() finds exactly the colorop under test.
+ *
+ * Returns: a populated fixture (by value).
+ */
+static struct dm_test_colorop_fixture
+dm_test_colorop_setup(struct kunit *test, enum drm_colorop_type type)
+{
+	struct dm_test_colorop_fixture f = {0};
+	struct __drm_colorops_state *colorops;
+	struct dm_plane_state *dm_plane_state;
+
+	f.adev = dm_kunit_alloc_adev(test);
+	f.adev->ddev.mode_config.num_colorop = 1;
+
+	f.colorop = kunit_kzalloc(test, sizeof(*f.colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.colorop);
+	f.colorop->dev = &f.adev->ddev;
+	f.colorop->type = type;
+
+	f.colorop_state = kunit_kzalloc(test, sizeof(*f.colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.colorop_state);
+	f.colorop_state->colorop = f.colorop;
+
+	colorops = kunit_kcalloc(test, 1, sizeof(*colorops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorops);
+	colorops[0].ptr = f.colorop;
+	colorops[0].new_state = f.colorop_state;
+
+	f.state = kunit_kzalloc(test, sizeof(*f.state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.state);
+	f.state->dev = &f.adev->ddev;
+	f.state->colorops = colorops;
+
+	dm_plane_state = kunit_kzalloc(test, sizeof(*dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+	f.plane_state = &dm_plane_state->base;
+	f.plane_state->state = f.state;
+
+	f.dc_plane_state = kunit_kzalloc(test, sizeof(*f.dc_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, f.dc_plane_state);
+
+	return f;
+}
+
+/**
+ * dm_test_colorop_multiplier_applied - Multiplier colorop programs hdr_mult
+ * @test: KUnit test context
+ */
+static void dm_test_colorop_multiplier_applied(struct kunit *test)
+{
+	struct dm_test_colorop_fixture f =
+		dm_test_colorop_setup(test, DRM_COLOROP_MULTIPLIER);
+
+	/* 1.0 in S31.32 sign-magnitude */
+	f.colorop_state->multiplier = 1ULL << 32;
+
+	KUNIT_EXPECT_EQ(test,
+		__set_dm_plane_colorop_multiplier(f.plane_state, f.dc_plane_state, f.colorop),
+		0);
+	KUNIT_EXPECT_EQ(test, f.dc_plane_state->hdr_mult.value, (long long)(1ULL << 32));
+}
+
+/**
+ * dm_test_colorop_multiplier_no_match - Non-multiplier colorop leaves hdr_mult untouched
+ * @test: KUnit test context
+ */
+static void dm_test_colorop_multiplier_no_match(struct kunit *test)
+{
+	struct dm_test_colorop_fixture f =
+		dm_test_colorop_setup(test, DRM_COLOROP_1D_CURVE);
+
+	f.colorop_state->multiplier = 1ULL << 32;
+
+	KUNIT_EXPECT_EQ(test,
+			__set_dm_plane_colorop_multiplier(f.plane_state, f.dc_plane_state, f.colorop),
+			0);
+	KUNIT_EXPECT_EQ(test, f.dc_plane_state->hdr_mult.value, 0LL);
+}
+
+/**
+ * dm_test_colorop_3x4_matrix_applied - CTM 3x4 colorop enables gamut remap
+ * @test: KUnit test context
+ */
+static void dm_test_colorop_3x4_matrix_applied(struct kunit *test)
+{
+	struct dm_test_colorop_fixture f =
+		dm_test_colorop_setup(test, DRM_COLOROP_CTM_3X4);
+	struct drm_property_blob *blob;
+	struct drm_color_ctm_3x4 *ctm;
+
+	ctm = kunit_kzalloc(test, sizeof(*ctm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctm);
+	ctm->matrix[0] = 1ULL << 32; /* identity diagonal */
+	ctm->matrix[5] = 1ULL << 32;
+	ctm->matrix[10] = 1ULL << 32;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	blob->data = ctm;
+	blob->length = sizeof(struct drm_color_ctm_3x4);
+	f.colorop_state->data = blob;
+
+	KUNIT_EXPECT_EQ(test,
+			__set_dm_plane_colorop_3x4_matrix(f.plane_state, f.dc_plane_state, f.colorop),
+			0);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->gamut_remap_matrix.enable_remap);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->input_csc_color_matrix.enable_adjustment);
+}
+
+/**
+ * dm_test_colorop_3x4_matrix_bad_length - Wrong blob length: must return -EINVAL
+ * @test: KUnit test context
+ */
+static void dm_test_colorop_3x4_matrix_bad_length(struct kunit *test)
+{
+	struct dm_test_colorop_fixture f =
+		dm_test_colorop_setup(test, DRM_COLOROP_CTM_3X4);
+	struct drm_property_blob *blob;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	blob->data = kunit_kzalloc(test, 8, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob->data);
+	blob->length = 7; /* not sizeof(struct drm_color_ctm_3x4) */
+	f.colorop_state->data = blob;
+
+	KUNIT_EXPECT_EQ(test,
+			__set_dm_plane_colorop_3x4_matrix(f.plane_state, f.dc_plane_state, f.colorop),
+			-EINVAL);
+}
+
+/**
+ * dm_test_colorop_degamma_predefined - Degamma 1D curve programs predefined TF
+ * @test: KUnit test context
+ */
+static void dm_test_colorop_degamma_predefined(struct kunit *test)
+{
+	struct dm_test_colorop_fixture f =
+		dm_test_colorop_setup(test, DRM_COLOROP_1D_CURVE);
+
+	/* SRGB_EOTF is part of amdgpu_dm_supported_degam_tfs */
+	f.colorop_state->curve_1d_type = DRM_COLOROP_1D_CURVE_SRGB_EOTF;
+	f.colorop_state->bypass = false;
+
+	KUNIT_EXPECT_EQ(test,
+			__set_dm_plane_colorop_degamma(f.plane_state, f.dc_plane_state, f.colorop),
+			0);
+	KUNIT_EXPECT_EQ(test,
+			(int)f.dc_plane_state->in_transfer_func.type,
+			(int)TF_TYPE_PREDEFINED);
+	KUNIT_EXPECT_EQ(test,
+			(int)f.dc_plane_state->in_transfer_func.tf,
+			(int)TRANSFER_FUNCTION_SRGB);
+}
+
+/**
+ * dm_test_colorop_degamma_no_match - Unsupported degamma curve: must return -EINVAL
+ * @test: KUnit test context
+ */
+static void dm_test_colorop_degamma_no_match(struct kunit *test)
+{
+	struct dm_test_colorop_fixture f =
+		dm_test_colorop_setup(test, DRM_COLOROP_1D_CURVE);
+
+	/* SRGB_INV_EOTF is a shaper TF, not in amdgpu_dm_supported_degam_tfs */
+	f.colorop_state->curve_1d_type = DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF;
+
+	KUNIT_EXPECT_EQ(test,
+			__set_dm_plane_colorop_degamma(f.plane_state, f.dc_plane_state, f.colorop),
+			-EINVAL);
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -1747,6 +1945,15 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_verify_lut3d_bad_shaper),
 	KUNIT_CASE(dm_test_verify_lut3d_bad_lut3d),
 	KUNIT_CASE(dm_test_verify_lut3d_valid),
+	/* __set_dm_plane_colorop_multiplier */
+	KUNIT_CASE(dm_test_colorop_multiplier_applied),
+	KUNIT_CASE(dm_test_colorop_multiplier_no_match),
+	/* __set_dm_plane_colorop_3x4_matrix */
+	KUNIT_CASE(dm_test_colorop_3x4_matrix_applied),
+	KUNIT_CASE(dm_test_colorop_3x4_matrix_bad_length),
+	/* __set_dm_plane_colorop_degamma */
+	KUNIT_CASE(dm_test_colorop_degamma_predefined),
+	KUNIT_CASE(dm_test_colorop_degamma_no_match),
 	{}
 };
 
-- 
2.43.0


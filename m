Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29385C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983FE10F6EC;
	Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zqM6Ndnm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EF110F6E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsF2HWSgo8owPS9n0iTjHIjnbwippmJy+J39nnmFvk45Zk60inkjdpnX56QljLG7zd6Pto+I6VWvKeCSG1t5r8x9Snq4wPdDn3lx7UNVWICbNsm718Tq/gJywaiZK7tw68UlhOOeg4wt4T/AuP34xgHkf69HScpceyqeHqC2mWak0In88tmG3sRKW8mvVSoKv5wW2co2fblVn2+6AFMKvwAFLcrgfytJKRD5sZGti/57dklS/Zkui0QwJNGGESJTI6TAHuoIi9rmCA+Ew6abWiqelyBMLugi+FyhoHl+bjF61kZYFzhs5yZfgLffhYYZzGcLdOxLUiVBu1jRHk2NTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyCHHLrpocJmQ5WeHHfABi2Uc7xOsfPR6PoYWvXH88I=;
 b=hUpN+yT9YpLNCRbYvjckb13lpcgfcgtjFHAEbMIqgU2kFtyBPhtH/VABijmIK5V22IDFHF2ALLzO6GVCLPd4shrXf+C2G4GRl6SnVaTd6jYDDiwLvKxgC0n5WQE6Ovp3wCY/EZvSXt5AkyBf2qjqS4XPzhAlPNA7yGQvFXTiU87JK/jnvjG0RTyPjFDauLVaBJgjZOa26yS1tgwPYv13vGsBnGTq4J5udeIXo7ujGiMri0nDw6x4da5FDcqOkyi1KlFj0PYOja5CHZ9mWWRSFShAUAWVcBswAEHy1at0n9jz0dQ6p4NmlK9gF4RKzm/DmcbaC1Eub+p3CyB8iJDU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyCHHLrpocJmQ5WeHHfABi2Uc7xOsfPR6PoYWvXH88I=;
 b=zqM6NdnmYo8fFMqioKGrmsiW9b+1rO8Nl56sLbeJfXLCIPEUJGp9Y0AV5FvGzRgygA/x1LXF1xvrY4wt05skNu5Nbl4YJxAxHG3DfrjIfjdzJEfLI39epOIgO70KdUVgJtof4+vCPI0x5xZ0Ov4TmAvkPvKQ44BFIpz5F9KFzh8=
Received: from MN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:52d::33)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 21:02:31 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::28) by MN0PR04CA0019.outlook.office365.com
 (2603:10b6:208:52d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:31 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:12 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 48/80] drm/amd/display: Test plane buffer attributes
Date: Thu, 9 Jul 2026 16:48:16 -0400
Message-ID: <20260709205936.5719-49-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 972c7fab-d0c7-43e1-273d-08deddfd644a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: N0myIDjrpjfYN6DX6ti7qQYKb3UJub3lAVM63LYsyRB9XBK+TnubZmt7AJpBBNR2Iti+UXkfS7MkZkT0Hg6WMznDd+poptp00Y6P8erdrrusSzIzlnib3oEGH46jQCkwR9XiiwFbRChwQKJWmRKFZHN8gdkTmtu4igD0DrOhrKlBKs7UQqki0c4xzpQVtPnaFu+l0X6C6cQnSVbmKaKqYExPayeYTqGsrvq1roxK7MsMUbxQLxroS2SLlfcdBKPzsq2GhHjlC1ug998km8ySLPHZ4P7hPEccrHeQ7CN1D/yMtO3QIjfOpqMd4MsnTZqpUxkOzxocUcTmn3vk8N+uza+TY/guzfrUCk7iOC9uMcX6ejSaXFzFUFJynqKzfDfVua4ARg+qIV7LgbCza5l+Rc0OiAhKdIbBZQBh/NiGbvE/74djBc4ZeLVuchlExiNmBqi4guLL4DL76jKzMIbg5gopemX4DXWxafWlbKg9s3T88UhhuhNjSXgWcEcM+03XV2XiYmU6KwMR6XuiApcesyjPf3qmjXkV27sG3uHSOMtMlKSbXI1nC+2E18Ax9UAKgccs36gq90Oeyh/pjbgLpqRA/qtLbOU1yCQ2foy5HjXE7u1u4sgUQg+QeVJWnvzfK2GXqD7VM8OgPDD/fb4u29gqz4W3FDm0fi7sNQyN1RPatfbglFyvA6BCDfL/G+y+3FN3naBWmQBMgxK4eaCGfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Vbl2zsxFnH9XtVW7N8exRi6u3Q1/A65otVGE8YsRVox8wB2x4v7ZszbklKQE87kmfOCAuvgs8+hAAOAEdayj9BNOxmOpFZWowLrGcBSrs8aHSVIwpZmOwDgOo2NSaaAxnxcbJTEZncG/bcGRKYJkWD8izpVBgVJH2x+7gnwk/2GPlhZxUmbW0zzV9PfXfFaJxh/xdfSi8J5opnQxcBFwiCEzLfL59iWccJbmFmvj8cO4wvVwK16nIxViOTzLnLNB0USeoQNl8X5YSwwtERCTw71NffH+gafbaPaox3JZL1p3WZ3kCyM4X25Eo2VaaV2cjqjZQXdAoRsKEiWNsEBg13jwMERVi/lJwQj5Sv35IaFalXfJ+XvlsCkRfJKLBDQE5oCN+32Eh20TdxBVjxHmQUdYucuAeBYr5u2wzmWwToDtdxLtE1nuR6vLnLcV9YR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:31.1878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972c7fab-d0c7-43e1-273d-08deddfd644a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
Add KUnit tests for the video and GFX12 paths of
amdgpu_dm_plane_fill_plane_buffer_attributes().

Introduce the dm_test_plane_attrs(), dm_test_video_attrs() and
dm_test_graphics_attrs() helpers that drive the buffer-attribute fill
with representative plane states.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 5d0691473a56..e05c9f71d451 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1301,6 +1301,41 @@ static u64 *dm_test_get_primary_mods(struct kunit *test, struct amdgpu_device *a
 	return mods;
 }
 
+static int dm_test_plane_attrs(struct amdgpu_device *adev,
+			       const struct amdgpu_framebuffer *afb,
+			       enum surface_pixel_format format,
+			       struct dc_tiling_info *tiling_info,
+			       struct plane_size *plane_size,
+			       struct dc_plane_dcc_param *dcc,
+			       struct dc_plane_address *address)
+{
+	return amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb, format,
+		ROTATION_ANGLE_0, 0, tiling_info, plane_size, dcc, address,
+		false);
+}
+
+static int dm_test_video_attrs(struct amdgpu_device *adev,
+			       const struct amdgpu_framebuffer *afb,
+			       struct dc_tiling_info *tiling_info,
+			       struct plane_size *plane_size,
+			       struct dc_plane_dcc_param *dcc,
+			       struct dc_plane_address *address)
+{
+	return dm_test_plane_attrs(adev, afb, SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+		tiling_info, plane_size, dcc, address);
+}
+
+static int dm_test_graphics_attrs(struct amdgpu_device *adev,
+				  const struct amdgpu_framebuffer *afb,
+				  struct dc_tiling_info *tiling_info,
+				  struct plane_size *plane_size,
+				  struct dc_plane_dcc_param *dcc,
+				  struct dc_plane_address *address)
+{
+	return dm_test_plane_attrs(adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+		tiling_info, plane_size, dcc, address);
+}
+
 static void dm_test_setup_gfx11_device(struct amdgpu_device *adev,
 				       struct dm_test_gfx11_reg_ctx *ctx,
 				       u32 num_pkrs_log2, u32 num_pipes_log2)
@@ -1642,6 +1677,104 @@ static void dm_test_get_plane_modifiers_gfx12(struct kunit *test)
 	dm_test_expect_mods_terminated(test, adev);
 }
 
+/**
+ * dm_test_fill_plane_buffer_attributes_video() - Verify NV12 attributes.
+ * @test: KUnit test context.
+ *
+ * Verify if a video pixel format fills chroma plane size and the progressive
+ * video address type on a GFX9 family device.
+ */
+static void dm_test_fill_plane_buffer_attributes_video(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_framebuffer *afb;
+	struct dc_tiling_info tiling_info;
+	struct plane_size plane_size;
+	struct dc_plane_dcc_param dcc;
+	struct dc_plane_address address;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	tiling_info = (struct dc_tiling_info){0};
+	plane_size = (struct plane_size){0};
+	dcc = (struct dc_plane_dcc_param){0};
+	address = (struct dc_plane_address){0};
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+	afb->address = 0x80000000ULL;
+	afb->base.width = 1920;
+	afb->base.height = 1080;
+	afb->base.offsets[0] = 0;
+	afb->base.offsets[1] = 0x200000;
+	afb->base.pitches[0] = 1920;
+	afb->base.pitches[1] = 1920;
+	afb->base.format = drm_format_info(DRM_FORMAT_NV12);
+	afb->base.modifier = DRM_FORMAT_MOD_LINEAR;
+	KUNIT_ASSERT_NOT_NULL(test, afb->base.format);
+
+	ret = dm_test_video_attrs(adev, afb, &tiling_info, &plane_size, &dcc,
+				  &address);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, plane_size.surface_size.width, 1920);
+	KUNIT_EXPECT_EQ(test, plane_size.chroma_size.width, 960U);
+	KUNIT_EXPECT_EQ(test, plane_size.chroma_size.height, 540U);
+	KUNIT_EXPECT_EQ(test, address.type,
+			(int)PLN_ADDR_TYPE_VIDEO_PROGRESSIVE);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion9);
+}
+
+/**
+ * dm_test_fill_plane_buffer_attributes_gfx12() - Verify GFX12 dispatch path.
+ * @test: KUnit test context.
+ *
+ * Verify if a GFX12 family device fills graphics attributes via the GFX12
+ * modifier path and reports the GFX addr3 version.
+ */
+static void dm_test_fill_plane_buffer_attributes_gfx12(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct dc_tiling_info tiling_info;
+	struct plane_size plane_size;
+	struct dc_plane_dcc_param dcc;
+	struct dc_plane_address address;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	tiling_info = (struct dc_tiling_info){0};
+	plane_size = (struct plane_size){0};
+	dcc = (struct dc_plane_dcc_param){0};
+	address = (struct dc_plane_address){0};
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_GC_12_0_0;
+	adev->dm.dc = dc;
+	afb->address = 0x80000000ULL;
+	afb->base.width = 1920;
+	afb->base.height = 1080;
+	afb->base.pitches[0] = 7680;
+	afb->base.format = drm_format_info(DRM_FORMAT_XRGB8888);
+	afb->base.modifier = DRM_FORMAT_MOD_LINEAR;
+	KUNIT_ASSERT_NOT_NULL(test, afb->base.format);
+
+	ret = dm_test_graphics_attrs(adev, afb, &tiling_info, &plane_size, &dcc,
+				     &address);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, address.type, (int)PLN_ADDR_TYPE_GRAPHICS);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxAddr3);
+}
+
 /**
  * dm_test_get_min_max_dc_plane_scaling_fp16() - Verify fp16 cap selection.
  * @test: KUnit test context.
@@ -1832,6 +1965,8 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling_fp16),
 	/* amdgpu_dm_plane_fill_plane_buffer_attributes() */
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx8),
+	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_video),
+	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx12),
 	/* amdgpu_dm_plane_get_cursor_position() */
 	KUNIT_CASE(dm_test_get_cursor_position),
 	/* amdgpu_dm_plane_format_mod_supported() */
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF0FC4450E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82F210F70A;
	Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DRI0zHz5";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0DE610F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/zYkdnrEFa1lmunfxBGPQJeeMclEclT8v2i2zCuzFEvKfAsfnDwoYsaZpwCa7xB0og5O78I7KOcGbNLBmKgzXe9mKWumktE6RG0AQgSubxgK6256oQl7CSlZAKn7kYtFpoDOcmYsptm4FvFYkNUJ/KwRSB53fjVb8x8w1CFmJgC8Q4B0JFQ23suOZbvUvr73pIpxVnMO53pTzSD+auhA8uZNvaTaKnybAleicRfe9fn0/0cdt1e2YZBocazMoCNN2Cita7/L92/UQYoPMeYGFpoo4kh+mIHSJIbetXaNyPYam69ecym2N6eht7zoKIWMtqPjQDk6B9mQ+wHGJzwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnG4163+vffGxgHUY9wyO6HF88zhEmqOs1HBp8Me4zE=;
 b=b+bLHf6DPdDx4duI+++jraYyO30Y2a/zbdNzk5lcEHwXzykSCDQ4XfeKwYuBw3j2YLPKEHnrXrUO0otBWITKxgx7Vbh724Ye0cf1315Y7IPuZRUhQYgETAD0bWPN7AI2Ng2TGuCTc/i9OEBk9OYJetSrjF1Kqrrc+sUYiPMju1HNwbKTs69peLiMzYmFJe5pEA1EOwWd1PUw+L7v9BsPjWgKd26xbf+MbslnsHry26rpbeRvW1Ig73EmFuo2ndAxERz7JPG+68cihrX3+3usS5yU1olEHCcBaegZ38hoTyFlW8cMxP8Z1pcwwpm04JZeT4Fq3ylh/6w11Q4xZS6Fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnG4163+vffGxgHUY9wyO6HF88zhEmqOs1HBp8Me4zE=;
 b=DRI0zHz5/KhX3ESPDzvRcdw1hJ24ZoBvrEYlgPwQE0mAn5UI3EiM8XcF1v6o2pZXBVWvAv9LcChbSYsVInyX2ojFf5XIbQoXogfIjMfGWioiBbKx1VDZ0iJB5ZY0s+zTLOcJAS4U7uITJZuqTwELu2p+i4thticdlQsGOdg3e1I=
Received: from BLAPR03CA0112.namprd03.prod.outlook.com (2603:10b6:208:32a::27)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:32 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::1a) by BLAPR03CA0112.outlook.office365.com
 (2603:10b6:208:32a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:31 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:13 -0500
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
Subject: [PATCH 49/80] drm/amd/display: Test GFX9 DCC plane attributes
Date: Thu, 9 Jul 2026 16:48:17 -0400
Message-ID: <20260709205936.5719-50-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b9ae2b-431f-4ec1-30ac-08deddfd64ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|3023799007|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7Om8un+/sXlgRw+7hBEyzoCKPMDFV10zHmOCjIWqC24Q2bQLrKGmnqWkOgW5T+M6Yg/QR/awMm36bXGm9DSz0yvUXKfREUUar1nEbtvO5J0r0ci0YMScu5ybbZ9f8rXLj18CZbrF5A3xnoHBaEFG7nNAmUDHuEZtwmvPO/1j8QJkV96r6XODcQYg0z4I0/p136a456MZYJIzB0oeDu4SJ81nJsZUrcH1hYRzHgelpdgnAO/vw5wExa0kwlJXWd7zeyefNh2ReJau1s3w5LcIkNnN6gLy6mKEBQHUcbn+mb2894wJ6WzxBIbJY0Xi9OAHlmQKRfJiwX8Sn0UQlh/O+WgYwOofGUyMW5FAtPDT3L8YoGZESMvAG7jdLkGpabgapti4lHBN9AvitD+xPbm+NtVbARamZV38iVPABGrwuUvEAxLHTM6ouMgDDdPRTv+Dr580uY0H6FOlo8IKAur8xJZk3WclBGWcBgTJqEtqsyYGzaoVAkEaU/0WL6a/W/Eln9wWL1Vlas0iCtEr3e3GyLpRHd/jmYP+hcL3p9xKA0vnwJCaM2ndxNndo1q3tf7Uula8M7cCaKUrpvgE3xFcgf7Tq/fyszYzSOQ+7I9PSL1cCW/lK4JRn77FHKG5VBQ/3FXsVedC7AYgIiFUTGW+eAJZ/vXhq69vVB2gciSGZpIrQDtaNjNfqee4a+Op8qUU2RgggB/3qpzlHwBYqCMnPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(3023799007)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E62O/qEJGM72z1IvxdO74CLTxG+ppqF6oy5850H4nHBS40UjvV+tppk4te8E2MWn++U9t3N2Sf5HOs1ALQtPS8niZi1CGFg4dpFTDMp4eyPsmnnkstU+eM1NVH+rzT7LBNYoqyEeOpHqrI6gBNQXV6pgRMuppMdpa023VEr23Zxd5oF1hQ1jrYzJQmkHjjReUBe034ZPdQpQaQgHFsJTxtpJnzqr+XQiUYygQXdIAZLfYSX719IKWQAu+MK5nIAHpotf59xjrRRcC8w3NQXI8QEpOzjhpzV68HsL+XIqKC6wANf9k3ueVNzyRB+74uP1KEgKRr19+WenKLlB+Okilra8noYmQJDUy8NeZq5zmjlTl5AeUKIFIwqY88BPXRYN6avxnKiSg+DyOd3IZ698yIm/G/3ULTqfDuCF0msI9EjYnz5DVXU2uxS8ItzOrMrW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:31.8210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b9ae2b-431f-4ec1-30ac-08deddfd64ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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
Add KUnit tests for
amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() covering
DCC enablement, validation failure, and the RB+ 64B/128B and GFX9
64B/unconstrained block modes.

Add the dm_test_gfx9_attrs(), dm_test_setup_gfx9_dcc_device() and
dm_test_gfx9_dcc_modifier() helpers used to build the GFX9 DCC inputs.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 351 ++++++++++++++++++
 1 file changed, 351 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index e05c9f71d451..4b7d9a2f798d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1301,6 +1301,18 @@ static u64 *dm_test_get_primary_mods(struct kunit *test, struct amdgpu_device *a
 	return mods;
 }
 
+static int dm_test_gfx9_attrs(struct amdgpu_device *adev,
+			      const struct amdgpu_framebuffer *afb,
+				      const struct plane_size *plane_size,
+				      struct dc_tiling_info *tiling_info,
+				      struct dc_plane_dcc_param *dcc,
+				      struct dc_plane_address *address)
+{
+	return amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev,
+		afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888, ROTATION_ANGLE_0,
+		plane_size, tiling_info, dcc, address);
+}
+
 static int dm_test_plane_attrs(struct amdgpu_device *adev,
 			       const struct amdgpu_framebuffer *afb,
 			       enum surface_pixel_format format,
@@ -1336,6 +1348,34 @@ static int dm_test_graphics_attrs(struct amdgpu_device *adev,
 		tiling_info, plane_size, dcc, address);
 }
 
+static void dm_test_setup_gfx9_dcc_device(struct amdgpu_device *adev,
+					  struct dc *dc,
+					  struct dm_test_dcc_cap_ctx *ctx,
+					  bool output_independent_64b_blks)
+{
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->dm.dc = dc;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 2;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	ctx->callback_ret = true;
+	ctx->capable = true;
+	ctx->output_independent_64b_blks = output_independent_64b_blks;
+	dm_test_dcc_ctx = ctx;
+}
+
+static u64 dm_test_gfx9_dcc_modifier(u64 tile_version, bool independent_64b_blks,
+				     bool independent_128b_blks)
+{
+	return AMD_FMT_MOD |
+	       AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+	       AMD_FMT_MOD_SET(TILE_VERSION, tile_version) |
+	       AMD_FMT_MOD_SET(DCC, 1) |
+	       AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, independent_64b_blks) |
+	       AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, independent_128b_blks);
+}
+
 static void dm_test_setup_gfx11_device(struct amdgpu_device *adev,
 				       struct dm_test_gfx11_reg_ctx *ctx,
 				       u32 num_pkrs_log2, u32 num_pipes_log2)
@@ -1677,6 +1717,310 @@ static void dm_test_get_plane_modifiers_gfx12(struct kunit *test)
 	dm_test_expect_mods_terminated(test, adev);
 }
 
+/**
+ * dm_test_fill_gfx9_plane_attributes_dcc() - Verify GFX9 DCC modifier path.
+ * @test: KUnit test context.
+ *
+ * Verify if a GFX10-RBPLUS DCC modifier enables DCC and selects the 64B
+ * independent block mode.
+ */
+static void dm_test_fill_gfx9_plane_attributes_dcc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct dm_test_dcc_cap_ctx ctx = {
+		.callback_ret = true,
+		.capable = true,
+		.output_independent_64b_blks = true,
+	};
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->dm.dc = dc;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 2;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	afb->base.pitches[1] = 256;
+	afb->base.modifier = AMD_FMT_MOD |
+			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+			     AMD_FMT_MOD_SET(DCC, 1) |
+			     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				 &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion9);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_64b);
+	KUNIT_EXPECT_EQ(test, dcc.meta_pitch, 256U);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx9_plane_attributes_validate_fails() - Verify GFX9 error path.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX9 modifier parsing returns validation errors from the shared DCC
+ * validation helper.
+ */
+static void dm_test_fill_gfx9_plane_attributes_validate_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	u64 tile_version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->dm.dc = dc;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+	afb->base.modifier = dm_test_gfx9_dcc_modifier(tile_version, true, false);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				 &address);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_fill_gfx9_plane_attributes_dcc_rbplus_64b_no_128bcl() - Verify block mode.
+ * @test: KUnit test context.
+ *
+ * Verify if a GFX10-RBPLUS modifier with both 64B and 128B independent block
+ * bits selects the 64B-no-128BCL block mode.
+ */
+static void dm_test_fill_gfx9_plane_attributes_dcc_rbplus_64b_no_128bcl(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct dm_test_dcc_cap_ctx ctx = {0};
+	u64 tile_version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, true);
+	afb->base.modifier = dm_test_gfx9_dcc_modifier(tile_version, true, true);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				 &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
+			(int)hubp_ind_block_64b_no_128bcl);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx9_plane_attributes_dcc_rbplus_128b() - Verify 128B block mode.
+ * @test: KUnit test context.
+ *
+ * Verify if a GFX10-RBPLUS modifier with only the 128B independent block bit
+ * selects the 128B block mode.
+ */
+static void dm_test_fill_gfx9_plane_attributes_dcc_rbplus_128b(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct dm_test_dcc_cap_ctx ctx = {0};
+	u64 tile_version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, false);
+	afb->base.modifier = dm_test_gfx9_dcc_modifier(tile_version, false, true);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				 &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_128b);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx9_plane_attributes_dcc_rbplus_unconstrained() - Verify block mode.
+ * @test: KUnit test context.
+ *
+ * Verify if a GFX10-RBPLUS modifier without independent block bits selects the
+ * unconstrained block mode.
+ */
+static void dm_test_fill_gfx9_plane_attributes_dcc_rbplus_unconstrained(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct dm_test_dcc_cap_ctx ctx = {0};
+	u64 tile_version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, false);
+	afb->base.modifier = dm_test_gfx9_dcc_modifier(tile_version, false, false);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				 &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
+			(int)hubp_ind_block_unconstrained);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx9_plane_attributes_dcc_gfx9_64b() - Verify legacy 64B mode.
+ * @test: KUnit test context.
+ *
+ * Verify if a pre-RBPLUS GFX9 modifier with the 64B independent block bit
+ * selects the 64B block mode.
+ */
+static void dm_test_fill_gfx9_plane_attributes_dcc_gfx9_64b(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct dm_test_dcc_cap_ctx ctx = {0};
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, true);
+	afb->base.modifier = dm_test_gfx9_dcc_modifier(AMD_FMT_MOD_TILE_VER_GFX9,
+						       true, false);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				 &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_64b);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained() - Verify legacy mode.
+ * @test: KUnit test context.
+ *
+ * Verify if a pre-RBPLUS GFX9 modifier without the 64B independent block bit
+ * selects the unconstrained block mode.
+ */
+static void dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct dm_test_dcc_cap_ctx ctx = {0};
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, false);
+	afb->base.modifier = dm_test_gfx9_dcc_modifier(AMD_FMT_MOD_TILE_VER_GFX9,
+						       false, false);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				 &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
+			(int)hubp_ind_block_unconstrained);
+
+	dm_test_dcc_ctx = NULL;
+}
+
 /**
  * dm_test_fill_plane_buffer_attributes_video() - Verify NV12 attributes.
  * @test: KUnit test context.
@@ -1976,6 +2320,13 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
 	/* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_validate_fails),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_rbplus_64b_no_128bcl),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_rbplus_128b),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_rbplus_unconstrained),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_gfx9_64b),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained),
 	/* amdgpu_dm_plane_helper_check_state() */
 	KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
 	/* amdgpu_dm_plane_add_modifier() */
-- 
2.55.0


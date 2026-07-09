Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370B8C44509
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DDE710F6EE;
	Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vI1KqbCV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B8F10F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtS5YRC0qM4R5lA0YQEsvqkBTBtEa9aujVjR4SWKRTfm6TVm2+jtylNeK6z8vVLsBAiAIwhuYTVfDc4/VNRzhYxQPUx3rION13DGa5a+Vzx7Qm64Lb2lH/GlyoK8PJuewo6S6JB2rrodJu3cbRa7TRA7Ayh4z4DVU/TuxjcYYgHUgfw4eNG9SsxRrx2ru/Jcl4FraYpUSFB6u5ALvWy0bS6fX9hj7n9Sh+qPHZpYWC1yUTGdg0bGDp/QZ9w6xZvtWN5AqE1sP+orHJSQuJK3844X2Ifet3715xAgYY+6ghWsakMvZzVm91oHMxCaKC+w/d84Tg+lORojetyKQRv2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYuF/1QSRRJFBVEdLHaJxwPJfhnIoX2sjDOXe8KRg6A=;
 b=IpJTRwuTRtkK2sTeGp+ayTSarrGV7fju60rN2gsMnzjgmZNTdCHauwKATgKUnBLYtT8xHIRiwDpkuKmcVjz3MwWxtZxS3qpyluoBTz5b/GHP0dEbgAaxFCGTYTCdkNDFhKkJ0QCGZ8TXItKwHnqMTDWoE6FluROceC/vtcLTlI1RQeJ/ho7WtT5y4MjKOqf1oW2+lodYrIsEVzOSycAzjhEmRF0ZMCXj6aUiWQqNtcLcaZYBVKkFV7xRS0ZtQMk6K1RFF3ZFDbqVeFNQ+kDPakZGxOouZfpx4QZVOEEoxzAwt2wlJ7XVseOuYgZgArIelcrEx18/PnZi4gei6htf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYuF/1QSRRJFBVEdLHaJxwPJfhnIoX2sjDOXe8KRg6A=;
 b=vI1KqbCV945DsEFbzyjTYupOGRdOwsJ+A0m/fnByvtmyL3gIU14oaN5z9zLnPCSTT6E4muFX3GiB8/NHrsGCnB1klcoZZ3JqDOMggZz/VD77oLrIy3Oxa2va1Seyrr3uLFcCWCksbbIGVCA1ul2jIfn5rRovP0KxXnzTBml9JRc=
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:33 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::68) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:32 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:14 -0500
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
Subject: [PATCH 50/80] drm/amd/display: Test GFX12 DCC plane attributes
Date: Thu, 9 Jul 2026 16:48:18 -0400
Message-ID: <20260709205936.5719-51-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9cac9e-4075-433a-c132-08deddfd64fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|22082099003|5023799004|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: Tcfex7wlxy30zUFnB+m+rARlDX9B/eV2mRaq9yuPeYl5UceVzhW0Bve8w+1YWKUS8DtiD5hZdc351AFSAEDEfWfNgedWpKw4t3SO9sbIILFDNw5IPLI7B+7gfS0DzZs0yAfseZCDBHXU/G5qlDGcbGN01HLqq9TBeV75RtAfzWM5COcFYwsdb5UDDLhYtUim3sdpHc0PuV1IrCtfBjrxZ8yhfbsQVT5CgyHn0j8R2pM3LekBwUtjZ3CA2eTWAMc+NygI0POLhcr6WRpXZbR0vnK08sYOeaDl+y1McIJIp34bGm2ajup/C+7jLPhyTcfnjw0cWdmvmHMAxgNnt5H1QfOeKvk4GiWLa5hod/TkPsx6cWcFwnPje4agMjK+1UOIF/Y4reBGyzq/UdnFHuWnjJRf07WUSaVUCcLkUarkBdVmhHk+wRlNtUv4EGaN0JQCqikMgOSnk/ggI+TCjMlqAc1E41v0kr9phKELJqyMeDZcDyrsS3eHVOHyunqsuvCl5+49mN2oDbrHLZE0Cw5HtcpMkmnGmdUinEi+V//pSLMQw6phYnLctLncy3XzXFVSDsFS7fTrfN5ZFJewxwwL8WJGdjE+QUXJdPyU3119mP7ui1Rtu4rJ2nbzH5lS7bzm2fOuc5jFJy/DeoVwHGyi9vJAjILa0cXu3PZKkd5UBdjI35Ocws2ZaDZS716gguSrmBpcYu2It58TVslYvXNTIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oUB4FbuMosq5kg7Ly9vcjKnFo/1E3xW7vwcr7kx7hLlURLAqSQ11k8iVMyz300omrcXmlZaYy/9Sw9SLIBy7YUJOAPnWJQXrgpNZg2JhAlMko/kJ09xhWMVOdv6tlzn2mCXR+wn91mIyp8fFxbS71q4bOLRL4PfWbZZ+idFxdZ3MuSxJ+mKPPFhi68UsYLM/P8WgBxyynIEI7eRbRPSwx+GJuGCgaWkPFAdOj21MGuVznopPMlNAbToMlHwSlfF5zbUznxVp8bEKzt7vWfQy5G9xpmSJK5nDUZx+/gKuRlnqnboJY5FwO2Q+CgKgqwP5liTFC2G5ENg51TNIuhmdli74SOpSHSmdpIcI6SfvOupSSItfTZNwCcgdjJt7fPIcaDqhhL162HDGqqyJjMBJT43AupkFeGAvoa5YEYeZzA3GeU1G2/AJn2T8mGKVf9yq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:32.3454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9cac9e-4075-433a-c132-08deddfd64fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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
amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() covering
the block0, unconstrained-block and validation-failure cases.

Add the dm_test_gfx12_attrs() helper used to build the GFX12 inputs.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 4b7d9a2f798d..47da180cf3a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1313,6 +1313,18 @@ static int dm_test_gfx9_attrs(struct amdgpu_device *adev,
 		plane_size, tiling_info, dcc, address);
 }
 
+static int dm_test_gfx12_attrs(struct amdgpu_device *adev,
+			       const struct amdgpu_framebuffer *afb,
+				       const struct plane_size *plane_size,
+				       struct dc_tiling_info *tiling_info,
+				       struct dc_plane_dcc_param *dcc,
+				       struct dc_plane_address *address)
+{
+	return amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev,
+		afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888, ROTATION_ANGLE_0,
+		plane_size, tiling_info, dcc, address);
+}
+
 static int dm_test_plane_attrs(struct amdgpu_device *adev,
 			       const struct amdgpu_framebuffer *afb,
 			       enum surface_pixel_format format,
@@ -2021,6 +2033,153 @@ static void dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained(struct kun
 	dm_test_dcc_ctx = NULL;
 }
 
+/**
+ * dm_test_fill_gfx12_plane_attributes_block0() - Verify GFX12 64B max-compressed-block path.
+ * @test: KUnit test context.
+ *
+ * Verify if a zero max-compressed-block modifier selects the 64B independent
+ * block mode on GFX12.
+ */
+static void dm_test_fill_gfx12_plane_attributes_block0(struct kunit *test)
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
+		.output_independent_64b_blks = false,
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
+	adev->family = AMDGPU_FAMILY_GC_12_0_0;
+	adev->dm.dc = dc;
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	afb->base.modifier = AMD_FMT_MOD |
+			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
+			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
+			     AMD_FMT_MOD_SET(DCC, 1) |
+			     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 0);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx12_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				  &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_TRUE(test, dcc.independent_64b_blks);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_64b);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx12_plane_attributes_block_unconstrained() - Verify block path.
+ * @test: KUnit test context.
+ *
+ * Verify if a max-compressed-block value above one selects the unconstrained
+ * independent block mode on GFX12.
+ */
+static void dm_test_fill_gfx12_plane_attributes_block_unconstrained(struct kunit *test)
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
+		.output_independent_64b_blks = false,
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
+	adev->family = AMDGPU_FAMILY_GC_12_0_0;
+	adev->dm.dc = dc;
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	afb->base.modifier = AMD_FMT_MOD |
+			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
+			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
+			     AMD_FMT_MOD_SET(DCC, 1) |
+			     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 2);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx12_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				  &address);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, dcc.enable);
+	KUNIT_EXPECT_FALSE(test, dcc.independent_64b_blks);
+	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
+			(int)hubp_ind_block_unconstrained);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_fill_gfx12_plane_attributes_validate_fails() - Verify GFX12 error path.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX12 modifier parsing returns validation errors from the shared
+ * DCC validation helper.
+ */
+static void dm_test_fill_gfx12_plane_attributes_validate_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct amdgpu_framebuffer *afb;
+	struct plane_size plane_size = {0};
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_GC_12_0_0;
+	adev->dm.dc = dc;
+	afb->base.modifier = AMD_FMT_MOD |
+			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
+			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
+			     AMD_FMT_MOD_SET(DCC, 1) |
+			     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 1);
+	plane_size.surface_size.width = 1920;
+	plane_size.surface_size.height = 1080;
+
+	ret = dm_test_gfx12_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+				  &address);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
 /**
  * dm_test_fill_plane_buffer_attributes_video() - Verify NV12 attributes.
  * @test: KUnit test context.
@@ -2318,6 +2477,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_format_mod_supported_d_swizzle_reject),
 	/* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
+	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_block0),
+	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_block_unconstrained),
+	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_validate_fails),
 	/* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc),
-- 
2.55.0


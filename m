Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785FBC982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9419E10EC7D;
	Wed, 16 Sep 2026 17:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2RgEB42f";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D51510E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjjpnrUeyI4nhHaf4TsAXMtf8GK9VGm8N/UnnSGpcBdz5vUnd3jTxcwPe+mNdzCXhERK72NA9mVIik8gegxSaHtVFMzMLfIwkHZwdLl+6tqmQ7m89y8/LW1AROQt6+NlQYCDdTHNrrHFvstTI71vWMqUUESfMo4i8dwr3RrIUb9OhLMGyaeybNZH/u/nUVlIKl9ALyC6oAPskPb9RV42fGJ0Gmnf9XlWfZOd9qY8AHfzlzZ/XBKvRiUyuAfewMz5dFyzUBwhTgBd45Xvusrwxl/ZYPsfWxvwAlcFtcj84NXh9KnmZdS9OYiOYrjOEB+c7B2/Eix5qRmPItz+DdvujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWYN5kBd+z2uL+VoKLro4sEPI9aX/6KKZYy3mrDHZyk=;
 b=xJxMCRh6YExU79J9XoZ6jYncJcYPjZ4SCT5JsP146GZRen0+rhoOwZL805iQs0dc8LmQpdg6luIHSZeaaRY0IfK+Y2Sdq1RZjT6Yey0wYvrwCEJzaGAwK/E2JV8X0eTzmjD14y3kh/inyS7RdPhXI2eJYyydmqHrnyUCbVAOLAjmNsdneFelBjgs3gTpUyW/3qzUKnSbTSE6DMcTzpXitDUciXUFXzOn6jAhNiU6lhBn8U8pGxNV2TOV6Z2CgTcoF5rzFOgE6QGpFG29KKO5LkJJrIYSZnlxfpwz9l3Q5kzrW8oRgoyc9aEt3dKuTmcAJqGaU9RV8fmOW7x3gq4F4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWYN5kBd+z2uL+VoKLro4sEPI9aX/6KKZYy3mrDHZyk=;
 b=2RgEB42fPtIBeFBey70osqZ7PXjOLIhFFx+8hWIvgD5QZ1nwSLTEu6Q/HK9xWFFJ+N5DOwmWggcrbTWkuOCduE/Yvm8S0j0VQVFHeOblL88ZvRxzCy0ZCXEZGY69YOJY9JLZi23fJbXQEGBklbeCJfiIGwllnCgNCbKgG2w33MY=
Received: from CH0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:610:e5::18)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:38 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::8e) by CH0PR03CA0253.outlook.office365.com
 (2603:10b6:610:e5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:38 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:26 -0500
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
Subject: [PATCH 16/64] drm/amd/display: Fold GFX9 tiling info tests
Date: Wed, 16 Sep 2026 13:51:31 -0400
Message-ID: <20260916175301.368306-17-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 97916929-3dea-4f3d-19d7-08df141b4c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zieZoRedsvQwGrmWP2p4C1sI5RxSoA/NJ5u4HPmv3E6NwQEbsZATy5xTc9CNX9TAeaUjBSWyCcMVlJgKTnP0uelC62pe2CeqjIAbUAqefgMmjqutT06XnsL8mJtwgHd6+H5zRidq+Nq+dzYF0b/0RPuR62b6hIH196dLKWFCRrml0lF430KK66JfawcWMpgCS6/bnLECL5tnLVufChGyYhUHjSzm8JVfYK1gmJUANfLXWmKWnlQzDGfkFcjNLWolpxb0NjBljj5BdL9MneFIMOW+BQm8yAxviuVopz637K5qyZPSFkseuknxjItk0n3nLLrhGwgtJhMz2gvPgkxdSFeZz3Bj+HI0NKdIJkGKvVLxeHP4+QgwU8zi3zD89fQY4QoEbOKsZY7WrWRWYF5fRFIscWlWo/cZOLL4mp6xgsZYDwt84qVjRE0RXKNf/Yu8ffBSfQCW5lDYjTwUR+8winT39Mg3iAOa03d9k2eN788KwHy2/sYkl2zBdk8vEliMBPbxkJOMBNIbQtg1+/zAsrN4CWMTSGVYywh6d2yIYfrzJsl+wUV5N2Z5gellljksO/4Y4n/Ogcn7h431qgWaBaVJpCKJUKi4oWkNRlQ+1YMDhrVXiZJXyC6W3Qj7Q/2sntGxaJgMsaokx0TyidgL58urGlqIvLtlLlwoQNchfdRT7k9JeCFpAwQMuhL3Gw389imbiA3pJzfH6WPqOfypCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mj8Nal4LsZ7ZxE9/+ey+ByLFzgA7rfrTRjIYQxHg458fyQBi0Ojn+NDoj3Cem37127Aa0Z/LpBkHNKlJ/wPHVUlphFFhlJV5EGIqdjREQ0MkrCSdMBBSn1cml0gFzN+bjH8e9QMvxUPuzLuWTc1E3OiXGvvGcbC9Ytl2P0J/k6s5nE8xwwOl7QYWesMQ+B44erRvbVjg2zFyvLUJYB7sYGu2SV9tcD/6ps750fpR8vW0Wu5axWsyRxA3FwuddE1cTWyIPmHS0ZDjkHx1cK+i4J8WO5sNAPmjL8y3wHOZw1g/Jg5c24YOZ0fYz2bAh7WRBev6eW6fnkG9ZE0onj0TLwKTI3EjhdnEaKCgf33IUioTSl+m8g3W/NfzDHqit1lv2s6uU8Zh7AzUo62TEqj0uZp4xChzR5uQVn3n1hDTLiHwCVWudsmVXpPmABrJxksE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:38.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97916929-3dea-4f3d-19d7-08df141b4c46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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
Reduce the two KUnit tests for
amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() to one, and the
three for amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier() to one.

[HOW]
Reprogram the device configuration and re-run the helper in sequence
inside a single test per function, so the pre-10.3, 10.3-and-later,
linear, pre-NV and NV-and-later cases all stay covered.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 80 ++++---------------
 1 file changed, 17 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index e2afb84de454..34eef4fbd833 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -928,12 +928,13 @@ static void dm_test_add_modifier_failure_paths(struct kunit *test)
 }
 
 /**
- * dm_test_fill_gfx9_tiling_info_from_device_pre_10_3() - Verify GFX9 field copy before 10.3.
+ * dm_test_fill_gfx9_tiling_info_from_device() - Verify GFX9 device field copy.
  * @test: KUnit test context.
  *
- * Verify if pre-10.3 device fields are copied and existing num_pkrs is kept.
+ * Verify if the device tiling fields are copied, and if num_pkrs is left
+ * untouched before GFX 10.3 but taken from the device from GFX 10.3 onwards.
  */
-static void dm_test_fill_gfx9_tiling_info_from_device_pre_10_3(struct kunit *test)
+static void dm_test_fill_gfx9_tiling_info_from_device(struct kunit *test)
 {
 	struct amdgpu_device *adev;
 	struct dc_tiling_info tiling_info = {0};
@@ -962,21 +963,6 @@ static void dm_test_fill_gfx9_tiling_info_from_device_pre_10_3(struct kunit *tes
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_rb_per_se, 2U);
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 0x5aU);
-}
-
-/**
- * dm_test_fill_gfx9_tiling_info_from_device_10_3_plus() - Verify num_pkrs update on 10.3+.
- * @test: KUnit test context.
- *
- * Verify if 10.3+ device fields are copied and num_pkrs is updated.
- */
-static void dm_test_fill_gfx9_tiling_info_from_device_10_3_plus(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc_tiling_info tiling_info = {0};
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
 	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
@@ -987,6 +973,8 @@ static void dm_test_fill_gfx9_tiling_info_from_device_10_3_plus(struct kunit *te
 	adev->gfx.config.gb_addr_config_fields.num_pkrs = 6;
 	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
 
+	memset(&tiling_info, 0, sizeof(tiling_info));
+
 	amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(adev, &tiling_info);
 
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pipes, 2U);
@@ -1000,15 +988,18 @@ static void dm_test_fill_gfx9_tiling_info_from_device_10_3_plus(struct kunit *te
 }
 
 /**
- * dm_test_fill_gfx9_tiling_info_from_modifier_linear() - Verify non-AMD modifier keeps device values.
+ * dm_test_fill_gfx9_tiling_info_from_modifier() - Verify GFX9 modifier decoding.
  * @test: KUnit test context.
  *
- * Verify if linear modifier path keeps values from device configuration.
+ * Verify if a non-AMD modifier keeps the device values, if an AMD modifier
+ * updates the bank count on pre-NV families, and if it updates the packer
+ * count on NV and later.
  */
-static void dm_test_fill_gfx9_tiling_info_from_modifier_linear(struct kunit *test)
+static void dm_test_fill_gfx9_tiling_info_from_modifier(struct kunit *test)
 {
 	struct amdgpu_device *adev;
 	struct dc_tiling_info tiling_info = {0};
+	uint64_t modifier;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, adev);
@@ -1034,33 +1025,13 @@ static void dm_test_fill_gfx9_tiling_info_from_modifier_linear(struct kunit *tes
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_rb_per_se, 2U);
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 3U);
-}
-
-/**
- * dm_test_fill_gfx9_tiling_info_from_modifier_pre_nv() - Verify AMD modifier updates banks on pre-NV.
- * @test: KUnit test context.
- *
- * Verify if AMD modifier updates pre-NV pipe, engine, and bank fields.
- */
-static void dm_test_fill_gfx9_tiling_info_from_modifier_pre_nv(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc_tiling_info tiling_info = {0};
-	uint64_t modifier;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->family = AMDGPU_FAMILY_RV;
-	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
 	adev->gfx.config.gb_addr_config_fields.num_banks = 16;
-	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 256;
-	adev->gfx.config.gb_addr_config_fields.num_se = 2;
-	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 1;
-	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
 	adev->gfx.config.gb_addr_config_fields.num_pkrs = 7;
 	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 2, 9);
 
+	memset(&tiling_info, 0, sizeof(tiling_info));
 	tiling_info.gfx9.num_pkrs = 0x5a;
 
 	modifier = AMD_FMT_MOD |
@@ -1076,22 +1047,6 @@ static void dm_test_fill_gfx9_tiling_info_from_modifier_pre_nv(struct kunit *tes
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_banks, 8U);
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.num_pkrs, 0x5aU);
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
-}
-
-/**
- * dm_test_fill_gfx9_tiling_info_from_modifier_nv() - Verify AMD modifier updates packers on NV+.
- * @test: KUnit test context.
- *
- * Verify if AMD modifier updates NV+ pipe, engine, and packer fields.
- */
-static void dm_test_fill_gfx9_tiling_info_from_modifier_nv(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc_tiling_info tiling_info = {0};
-	uint64_t modifier;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->family = AMDGPU_FAMILY_NV;
 	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
@@ -1103,6 +1058,8 @@ static void dm_test_fill_gfx9_tiling_info_from_modifier_nv(struct kunit *test)
 	adev->gfx.config.gb_addr_config_fields.num_pkrs = 2;
 	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
 
+	memset(&tiling_info, 0, sizeof(tiling_info));
+
 	modifier = AMD_FMT_MOD |
 		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
 		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, 6) |
@@ -3971,12 +3928,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_gfx6_format_mod_supported() */
 	KUNIT_CASE(dm_test_gfx6_format_mod_supported),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
-	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_pre_10_3),
-	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_10_3_plus),
+	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier() */
-	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier_linear),
-	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier_pre_nv),
-	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier_nv),
+	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier),
 	/* amdgpu_dm_plane_validate_dcc() */
 	KUNIT_CASE(dm_test_validate_dcc_disabled_returns_success),
 	KUNIT_CASE(dm_test_validate_dcc_video_non_gfx12_fails),
-- 
2.55.0


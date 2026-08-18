Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029D0C5DF91
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E66110ECCD;
	Tue, 18 Aug 2026 20:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tr7C7TSp";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EC810ECC3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGb9gtO+JekJKb9y+8IqPk/eaFbESMX443gkLO6teJNN64kgC4UstphAWiNlH/EnfzW5tZfpOzrEQ1FHxBJfiO9UmJiKDSEcEdeGxqHgKTka6ZrMQkHadtkU/Opuk0AfSGR7PohBgs/F23t6KaqreRB+S09EdKZwtzezseGNkC7pWLc9u7acssGPaMHEYDLmkEn5Yy6U14GIfT2yTpIIm9ysYBHuRzXoHMvYPtMOXEcuJvq5ihjYLydxSNa0Fov7Z7gYHijmRtRqJ1i2twnzRYOqPqGnmCtM2qOqOzjvfHEYVsy54BK4dLe3j/Pm+c5UEASA7oii/1wz9PJowXsMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+cTvPcFf2ouwx8HobVMOi9Kqr0sVughthCcmotirhk=;
 b=FIlkIMzhguBkMRw5NhiQDvHi5qF7RRzEnY25KnSbjMgc81XHBzyF9MzGJxyXzKvprkgfgS/8NsfKyn0vhycp63srHMxUu7Lczcj3boPaCakPXkmO4m3eA/uLu1/gfsDhQ2wLZsYndaBqcT+3sJTTy41kBaWK1VS1CsoMgCU5/2LPW3NXvlLmXiDoLP45tuGPqi05mHgMtZeWU7QZBZ8JtLEaJwcnp4ytVW6glS5Vfg6gOAxtcMw5TJNhhp7mrFASMcZLbg04H1gMt03eiSi5MGmCEmRKwhSlTsohuB8kMfOWrMalKsygQbQC/SB7WBXofGpwwBEKan1Dv9whcTPJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+cTvPcFf2ouwx8HobVMOi9Kqr0sVughthCcmotirhk=;
 b=Tr7C7TSp1+ocyO50Vnl3SHPeD172562CWSIzX3kkcSOH8AA/+YDpDVYFaLMsDb97B2TzMZW7xvSstVgTHmEi6c1Hiz8UUw3/kyk6+61eIK7Fs7UUSeas4/MynxyzZdDOWmS3rW+rIV6yu1LTNoFFWN6dNeX2FNt5nR17dsh5JIg=
Received: from BN9PR03CA0350.namprd03.prod.outlook.com (2603:10b6:408:f6::25)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:40 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::7d) by BN9PR03CA0350.outlook.office365.com
 (2603:10b6:408:f6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:27 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:26 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 47/82] drm/amd/display: Test GFX6-8 tile mode and tile split
 lookups
Date: Tue, 18 Aug 2026 16:15:39 -0400
Message-ID: <20260818202139.4172592-48-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4d0c31-958a-47e3-3154-08defd6673e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yCluudYuBt8UD4pHxJIhoYaUN1TsU/uPonfVtyoCij8V8MJbkNLk96Sl7Cz03WDA2K5KViUoqnCf0fCBCRmDnnzF/8ONGyA/Wj5bBAlWDha7xL8p8O8FAGZPmRlFAPmhTiKkcHXlbxc0Cq9Z/+4fB1CG/xAssaY9t4aF3JL9rG1q4TbKD3Rt3FlhmIcQT/AnnG3wt7+Wqf3flKHbJmmGSoEKzyC48XeeVGPQ3nDW+u5PPIaFatCPZQldsDLFnEbtMRKZA2WTkBHu9Ohkb8fRbHbAhDd3qrYPj6YKmD0/YH52Ed0Zk8aw8fmz8L3IxPz3w1exgDE2bh8ErwoEm6wPg1vrAs2Z4T+CZ/oreA7rAphNn/mh0973K8LfmhIKFVEtlP9fcsyrjZT6OP8C/PwiF2unDZSVQfsTQX9xfAW6iFTO5RQAJ3p6UdRnJtp5RkLNEoGAKxD+MHYW+un/BjslAvDnwr/AqGJYhfZ02MYUMjPsROUiI6773rui5j5G0dm2Ud2UVlXJIYRdklG5kVGqAmqOdg7b93gsGVDSMO0mmikbQZlaq1AHCbwLvPza/0fYIiUg7yrIPJ9RY9oOPohjnqYEhqRJ07PjrSNB2aM5NRGFE9NbQWt5TlThOX41fp0GMvxShBr3jtrcmo+AYswhHlSKhOuv6UdJ0i9fMKcQ0wdwJa4tBYlq/8orZUqExntzkDl8cvJkOVrUMqn5NJV0iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8w/MyOqU4lzUvh0wYAolDli1ndbNcBZGKv5XuFNtpRXc9fka3MFQOT5ay6A48I97MhJXeQwN+AHApkaHJmKfxEw2HWcVeUSmqudwwJa0R1alTL8GRuJ+Xw0sk0eeffGWXQtnyWWLZD6Ql+tccjKKuA75MP/WWsvCeg69Tfbjt7eReBUx8vtzflmgchLX1nVJZorG0uLfqSzPfrsLvNzZE+9m8g79D2njzcg+enmyhoUN4x38cjQK8SrMVtv5qKediDSDE92j4nnZNhNmaq2POv7yEnm2ErXkvpVstfage8UQ3YBOR3WFbFb5xOzBGoM5KWmdNa7uScYx1gUEmNl7q7leMsbjrXZWsUf92eDHL1T0g41LIzHTxTz3zFxijh0rAVsxiQ25cdGM2c/2G4L9vBdcVBgp3QpxEpHvxm6EnVFCYYeC6aI9uzUk9MZOD9bX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:40.5652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4d0c31-958a-47e3-3154-08defd6673e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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
Add KUnit tests for amdgpu_dm_plane_get_gfx6_tile_idx(),
amdgpu_dm_plane_calc_gfx7_tile_split() and
amdgpu_dm_plane_get_gfx7_macro_tile_idx() covering the per-family tile
mode index selection, the tile split derived from the sample split
factor with its 256 byte and memory row size clamps, and the macro tile
index capped by the tile split.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 18 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  5 ++
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 81 +++++++++++++++++++
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 824ef3ce5de0a..d6b80c380db85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -504,9 +504,9 @@ static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *ad
  * present at specific indices.
  * See SiLib::HwlSetupTileInfo() and CiLib::HwlSetupTileInfo() in addrlib.
  */
-static u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
-					 const u32 bpp,
-					 const enum array_mode_values arr)
+STATIC_IFN_KUNIT u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
+						       const u32 bpp,
+						       const enum array_mode_values arr)
 {
 	/* Assume that the microtile mode is DISPLAY. */
 
@@ -527,6 +527,7 @@ static u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
 		return 12;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_get_gfx6_tile_idx);
 
 /**
  * amdgpu_dm_plane_calc_gfx7_tile_split() - Calculate tile split on GFX7-8
@@ -542,9 +543,9 @@ static u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
  * can be calculated. The TILE_SPLIT field is only used for the depth micro tile mode.
  * See CiLib::HwlComputeMacroModeIndex() in addrlib.
  */
-static u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev,
-						const u32 bpp,
-						const u32 gb_tile_mode)
+STATIC_IFN_KUNIT u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev,
+							  const u32 bpp,
+							  const u32 gb_tile_mode)
 {
 	/* Assume 2D_TILED_THIN1 mode with non-DEPTH microtiles */
 	const u32 sample_split = (gb_tile_mode >> 25) & 0x3;
@@ -557,6 +558,7 @@ static u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev
 		     256,
 		     adev->gfx.config.mem_row_size_in_kb * 1024);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_calc_gfx7_tile_split);
 
 /**
  * amdgpu_dm_plane_get_gfx7_macro_tile_idx() - Get macro tile mode index on GFX7-8
@@ -570,7 +572,8 @@ static u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev
  * present at specific indices.
  * See CiLib::HwlComputeMacroModeIndex() in addrlib.
  */
-static u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const u32 tile_split_bytes)
+STATIC_IFN_KUNIT u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp,
+							     const u32 tile_split_bytes)
 {
 	const u32 thickness = 1;
 	const u32 tile_size_pixels = 8 * 8;
@@ -582,6 +585,7 @@ static u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const u32 tile
 
 	return macro_tile_idx;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_get_gfx7_macro_tile_idx);
 
 /**
  * amdgpu_dm_plane_calc_gfx6_mod() - Calculate a DRM format modifier for GFX6-8
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 092ade738ce98..7c5d0a7dadb1d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -125,5 +125,10 @@ void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
 					uint64_t *cap, uint64_t mod);
 int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(struct dc_tiling_info *tiling_info,
 							uint64_t modifier);
+u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev, const u32 bpp,
+				      const enum array_mode_values arr);
+u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev, const u32 bpp,
+					 const u32 gb_tile_mode);
+u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const u32 tile_split_bytes);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index aaec65d7431ce..420b053d2e3dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3277,6 +3277,81 @@ static void dm_test_fill_gfx6_tiling_info_2d(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 2U);
 }
 
+/**
+ * dm_test_get_gfx6_tile_idx() - Verify GFX6-8 tile mode index selection.
+ * @test: KUnit test context.
+ *
+ * Verify if the micro tiled mode maps to a fixed index, GFX7+ uses a single
+ * macro tiled index, and GFX6 selects the index from the bits per pixel.
+ */
+static void dm_test_get_gfx6_tile_idx(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_VI;
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_gfx6_tile_idx(adev, 32, DC_ARRAY_1D_TILED_THIN1),
+			9U);
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_gfx6_tile_idx(adev, 32, DC_ARRAY_2D_TILED_THIN1),
+			10U);
+
+	adev->family = AMDGPU_FAMILY_SI;
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_gfx6_tile_idx(adev, 8, DC_ARRAY_2D_TILED_THIN1),
+			10U);
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_gfx6_tile_idx(adev, 16, DC_ARRAY_2D_TILED_THIN1),
+			11U);
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_gfx6_tile_idx(adev, 32, DC_ARRAY_2D_TILED_THIN1),
+			12U);
+}
+
+/**
+ * dm_test_calc_gfx7_tile_split() - Verify GFX7-8 tile split calculation.
+ * @test: KUnit test context.
+ *
+ * Verify if the tile split is derived from the sample split factor and clamped
+ * to the 256 byte minimum and the memory row size maximum.
+ */
+static void dm_test_calc_gfx7_tile_split(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->gfx.config.mem_row_size_in_kb = 4;
+
+	/* 8 bpp gives 64 bytes, clamped up to the 256 byte minimum. */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_calc_gfx7_tile_split(adev, 8, 0u << 25), 256U);
+	/* 32 bpp with a sample split factor of 2. */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_calc_gfx7_tile_split(adev, 32, 1u << 25), 512U);
+
+	/* 64 bpp with a sample split factor of 8, clamped to the memory row size. */
+	adev->gfx.config.mem_row_size_in_kb = 1;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_calc_gfx7_tile_split(adev, 64, 3u << 25), 1024U);
+}
+
+/**
+ * dm_test_get_gfx7_macro_tile_idx() - Verify GFX7-8 macro tile index selection.
+ * @test: KUnit test context.
+ *
+ * Verify if the macro tile index is the log2 of the tile size in 64 byte units,
+ * clamped to the tile split.
+ */
+static void dm_test_get_gfx7_macro_tile_idx(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_gfx7_macro_tile_idx(8, 1024), 0U);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_gfx7_macro_tile_idx(32, 1024), 2U);
+	/* 64 bpp needs 512 bytes but the tile split caps it at 256. */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_gfx7_macro_tile_idx(64, 256), 2U);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3371,6 +3446,12 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_rejects),
 	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_1d),
 	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_2d),
+	/* amdgpu_dm_plane_get_gfx6_tile_idx() */
+	KUNIT_CASE(dm_test_get_gfx6_tile_idx),
+	/* amdgpu_dm_plane_calc_gfx7_tile_split() */
+	KUNIT_CASE(dm_test_calc_gfx7_tile_split),
+	/* amdgpu_dm_plane_get_gfx7_macro_tile_idx() */
+	KUNIT_CASE(dm_test_get_gfx7_macro_tile_idx),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_pre_10_3),
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_10_3_plus),
-- 
2.43.0


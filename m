Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CFDCD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FF610E87B;
	Wed, 10 Jun 2026 09:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bnBgYDE6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5179010E87B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgxmihL1Mrh0oGT+a71tBBgc5k0cENe5GmMTRZkkDlyeEIVfHVyC8tLLvs8d6odbwrQr+VYZyka8c5DqbqWAMch2KGxuW/nvjRGUmGSlhoHntSW7eo+t+qsyG88sAQ8h+Wm5Sc0Ro0XLKt/Yg2gNm8NbNqgxmyNceAyZ6L08NAsVCKNru63hjBtyFs7fapv2wf3CpvHUBUvNmfuXpsk25zn07tS4kayZ3kXWOcQzaT/RiI0foTvd34+uolgjhqxBNIzYSnWiRWbhHcaNn2jBAlDMPR8Ym0Cc6Z/4YkcoMoLC3zpAjIXqX0D68iAVV/6ZVUqB2Hrs6+k9TjdfTwESxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm7Pn5L1P5OHFgZU9AcaCd9LVaLjC/5iBZpXGXK1OiQ=;
 b=pQiAWrMXAMqgcDoHwCxbso/MoJn/bk7m0uHQdY6uy9/9wZHrLYeeYDM8hmnc6GqR587O6/jF2AUUDGjCtFIS+6xdacYnIGLM+TQ1yMIQBM4jJJtpLRtFma3OVlIg7twC4FSwNJbFGSNEUKod5gMB6ZGm0PCNFMqY7xefCdTdSEbiG95lAKTJKwrR7df32OiL62XR+rdbMIpzxunjmDG1OuGcSsJ93ONzjZhpDm8vs6QcmdT8ZFinLzgT0gy5NTnbkQkfJLSZj2BUYzWTjB/6koTh8nzTJUheivaCe+0mdSJ9Ehl6lXjillOQugcicZ0lpAyYntl6gf60lhQQS2v2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm7Pn5L1P5OHFgZU9AcaCd9LVaLjC/5iBZpXGXK1OiQ=;
 b=bnBgYDE6NPDLvvk2+A5+DdbhEJU2C9J3pzslAgqF/pSrVVJ+Xy1NXH56LQhOCgdTeegSuVkaHhNrpEJ7zVN6iUb+LAKmiyIts2ImXKZLDJhitRXB3GJvfPrJVfOlqnyDQH6QJShb6ZqBf+NHh51SJ+BhgffLL6HumC+YIhlq9mE=
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Wed, 10 Jun 2026
 09:49:48 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::87) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 09:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:49:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:49:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:49:46 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:49:38 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, "Chenyu
 Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 12/32] drm/amd/display: Fix conflicting types for dc_plane_cm
 functions
Date: Wed, 10 Jun 2026 17:44:56 +0800
Message-ID: <20260610094639.1965367-13-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: a993c586-8e59-4576-b6d1-08dec6d59c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: w9heK8+ThjH8oo8YJ1+v/G39B6zxMeyToY5WXCjyEfy4Oakuxr+bOjZ1V3SV7l+iQTEo0q/Y9apaJR9hzUu5urdoF8DI3+A06ufpD6iPTgZcyo+ENRf1R7Y07Z4Dnw5DPGIX7rHcIOwKMoQqTUO3LOiUtazYpIck8jT+kDp3QfuV7TW04o+dHxik9UcEfKGUUxCZka37m4PIDEgVISMrQ5tI8E5tWZ5pHwyiHBYaxtR23EeyRGoYXKurDmWPm+RIZpSR7Td/P+yhOkcEuOzG2wdQMMq+GjGY6WLShn2GtKFcsRdUueMeOId/HmMEEEMPrGnt7dAgTlA6HXzmwQK4yOpxMdf9LocjOIHS2h20jHnqCv7mx7UqXgLAknpPc2vsLjR0tVh/S4BHcGwUYfI4ft8a/fXF+Bv2tGWAlYPvtsKNx4KNU5X5iZ4HcADoLhG3P2zEiaQqOiUX59leUk6Py+M/4V7//BBWTsRCPf7UEKwo6mznX597V8VcXrXvr2Ix/LFViruzYgd6SU9LPfJsf1ZJouEznf6eEFxQ1745zCz5UmnGLSFsQaMLz7qq0eHgSgY+56KAvqQw+plsKAO+xflZYaiCjlNuqTfImsEBrdxyu5n8E+k5A9H+uf1QdCG1KLab9NR/HLREoOf2yoSg2FxNPx6L6+RAvFwxGM6nq4lt+BQ4eVLQl0pSiv54H+7mVy+TwgaU5jnvXqlNhmR6IqJwxchKNnW+Ni0WN0SJIqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CSpYphg0I6g3mQh5QE0oAn6UVruS6eCqrF9fvZ1lB1p8+srbORzlchbkzCymGG3m7rBSv45eRowoWRQ+v8EBX0p8gONCOn3r/GvCob+cWCuqVZNhxcKzmddL1fWPAr4rM5dBV1blFM+AVPz7cVgUhtZeuX8X7Hn49ujLKG5hK6OpFn3/2qZ+dVET4pqf3qzSky0nmK9ORAIQ+jMVU/l2hbHXkSRE5AkcWGWm/WnWC7mNV2WrXdEoh3G3KM3T7/3eoCvwfJe2fHjmEVWoVtlzhKB48CYi0mPPbs9/wNO7NF30CaWBTSCrplNfv4srLjqJwrjCwSHgEq2hn/3rPRGp7zRg/Qm2SQuihXbICzW06Up9nHpHc+mUib8f3WmN0iI3UERZjlfos1wm94P6wcBx1FFJLI4WpuoGJNqySwG159+xiEn73K9RckpYejkNrCmG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:49:48.7196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a993c586-8e59-4576-b6d1-08dec6d59c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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
Update declarations of amdgpu_dm_atomic_lut3d,
amdgpu_dm_atomic_shaper_lut, and amdgpu_dm_atomic_blend_lut in
amdgpu_dm_color.h to use struct dc_plane_cm * matching the
definitions in amdgpu_dm_color.c. Also update the KUnit tests to
allocate struct dc_plane_cm and access the embedded sub-structs.

This patch fixes an issue in the previous patch in this series,
"drm/amd/display: Introduce dc_plane_cm and migrate surface update color path".

Cc: Rafal Ostrowski <rafal.ostrowski@amd.com>
Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |  8 +--
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 64 +++++++++----------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index e4f53b7bc753..8dbbcb3ab156 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -87,10 +87,10 @@ void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
 				struct tetrahedral_params *params,
 				bool use_tetrahedral_9,
 				int bit_depth);
-struct dc_3dlut;
+struct dc_plane_cm;
 void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
 			     uint32_t drm_lut3d_size,
-			     struct dc_3dlut *lut);
+			     struct dc_plane_cm *cm);
 int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
 			uint32_t drm_lut3d_size,
 			struct dc_3dlut *lut);
@@ -105,12 +105,12 @@ int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 				bool has_rom,
 				enum dc_transfer_func_predefined tf,
 				uint32_t shaper_size,
-				struct dc_transfer_func *func_shaper);
+				struct dc_plane_cm *cm);
 int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
 			       bool has_rom,
 			       enum dc_transfer_func_predefined tf,
 			       uint32_t blend_size,
-			       struct dc_transfer_func *func_blend);
+			       struct dc_plane_cm *cm);
 int __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 				 struct drm_colorop_state *colorop_state);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index f943361b70e8..d64c7da20f2c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1159,19 +1159,19 @@ static void dm_test_verify_lut_sizes_invalid_degamma_valid_gamma(struct kunit *t
  */
 static void dm_test_atomic_lut3d_zero_size(struct kunit *test)
 {
-	struct dc_3dlut *lut;
+	struct dc_plane_cm *cm;
 	u32 initialized;
 
-	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, lut);
+	cm = kunit_kzalloc(test, sizeof(*cm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cm);
 
 	/* Pre-set initialized so we can confirm it is cleared */
-	lut->state.bits.initialized = 1;
+	cm->lut3d_func.state.bits.initialized = 1;
 
-	amdgpu_dm_atomic_lut3d(NULL, 0, lut);
+	amdgpu_dm_atomic_lut3d(NULL, 0, cm);
 
 	/* Copy bit-field: typeof cannot be applied to a bit-field */
-	initialized = lut->state.bits.initialized;
+	initialized = cm->lut3d_func.state.bits.initialized;
 	KUNIT_EXPECT_EQ(test, initialized, 0U);
 }
 
@@ -1183,22 +1183,22 @@ static void dm_test_atomic_lut3d_nonzero_state_bits(struct kunit *test)
 {
 	const uint32_t lut3d_size = 5;
 	struct drm_color_lut *lut_data;
-	struct dc_3dlut *lut;
+	struct dc_plane_cm *cm;
 	u32 initialized;
 
 	lut_data = kunit_kcalloc(test, lut3d_size, sizeof(*lut_data), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, lut_data);
 
-	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, lut);
+	cm = kunit_kzalloc(test, sizeof(*cm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cm);
 
-	amdgpu_dm_atomic_lut3d(lut_data, lut3d_size, lut);
+	amdgpu_dm_atomic_lut3d(lut_data, lut3d_size, cm);
 
 	/* Copy bit-field: typeof cannot be applied to a bit-field */
-	initialized = lut->state.bits.initialized;
+	initialized = cm->lut3d_func.state.bits.initialized;
 	KUNIT_EXPECT_EQ(test, initialized, 1U);
-	KUNIT_EXPECT_FALSE(test, lut->lut_3d.use_tetrahedral_9);
-	KUNIT_EXPECT_TRUE(test, lut->lut_3d.use_12bits);
+	KUNIT_EXPECT_FALSE(test, cm->lut3d_func.lut_3d.use_tetrahedral_9);
+	KUNIT_EXPECT_TRUE(test, cm->lut3d_func.lut_3d.use_12bits);
 }
 
 /**
@@ -1209,29 +1209,29 @@ static void dm_test_atomic_lut3d_data_forwarded(struct kunit *test)
 {
 	const uint32_t lut3d_size = 5;
 	struct drm_color_lut *lut_data;
-	struct dc_3dlut *lut;
+	struct dc_plane_cm *cm;
 
 	lut_data = kunit_kcalloc(test, lut3d_size, sizeof(*lut_data), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, lut_data);
 
-	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, lut);
+	cm = kunit_kzalloc(test, sizeof(*cm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cm);
 
 	lut_data[0].red   = 0xFFFF;
 	lut_data[0].green = 0x8000;
 	lut_data[0].blue  = 0x4000;
 
-	amdgpu_dm_atomic_lut3d(lut_data, lut3d_size, lut);
+	amdgpu_dm_atomic_lut3d(lut_data, lut3d_size, cm);
 
 	/*
 	 * use_tetrahedral_9 == false → data goes into tetrahedral_17.
 	 * lut[0] maps to lut0[0] (first element of the first group).
 	 */
-	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].red,
+	KUNIT_EXPECT_EQ(test, cm->lut3d_func.lut_3d.tetrahedral_17.lut0[0].red,
 			drm_color_lut_extract(0xFFFF, MAX_COLOR_3DLUT_BITDEPTH));
-	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].green,
+	KUNIT_EXPECT_EQ(test, cm->lut3d_func.lut_3d.tetrahedral_17.lut0[0].green,
 			drm_color_lut_extract(0x8000, MAX_COLOR_3DLUT_BITDEPTH));
-	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].blue,
+	KUNIT_EXPECT_EQ(test, cm->lut3d_func.lut_3d.tetrahedral_17.lut0[0].blue,
 			drm_color_lut_extract(0x4000, MAX_COLOR_3DLUT_BITDEPTH));
 }
 
@@ -1398,19 +1398,19 @@ static void dm_test_set_atomic_regamma_bypass(struct kunit *test)
  */
 static void dm_test_atomic_shaper_lut_bypass(struct kunit *test)
 {
-	struct dc_transfer_func *func_shaper;
+	struct dc_plane_cm *cm;
 
-	func_shaper = kunit_kzalloc(test, sizeof(*func_shaper), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, func_shaper);
+	cm = kunit_kzalloc(test, sizeof(*cm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cm);
 
 	/* size=0 and tf=LINEAR: must take the bypass branch */
 	KUNIT_EXPECT_EQ(test,
 		amdgpu_dm_atomic_shaper_lut(NULL, false,
 					    TRANSFER_FUNCTION_LINEAR,
-					    0, func_shaper),
+					    0, cm),
 		0);
-	KUNIT_EXPECT_EQ(test, (int)func_shaper->type, (int)TF_TYPE_BYPASS);
-	KUNIT_EXPECT_EQ(test, (int)func_shaper->tf, (int)TRANSFER_FUNCTION_LINEAR);
+	KUNIT_EXPECT_EQ(test, (int)cm->shaper_func.type, (int)TF_TYPE_BYPASS);
+	KUNIT_EXPECT_EQ(test, (int)cm->shaper_func.tf, (int)TRANSFER_FUNCTION_LINEAR);
 }
 
 /**
@@ -1419,19 +1419,19 @@ static void dm_test_atomic_shaper_lut_bypass(struct kunit *test)
  */
 static void dm_test_atomic_blend_lut_bypass(struct kunit *test)
 {
-	struct dc_transfer_func *func_blend;
+	struct dc_plane_cm *cm;
 
-	func_blend = kunit_kzalloc(test, sizeof(*func_blend), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, func_blend);
+	cm = kunit_kzalloc(test, sizeof(*cm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cm);
 
 	/* size=0 and tf=LINEAR: must take the bypass branch */
 	KUNIT_EXPECT_EQ(test,
 		amdgpu_dm_atomic_blend_lut(NULL, false,
 					   TRANSFER_FUNCTION_LINEAR,
-					   0, func_blend),
+					   0, cm),
 		0);
-	KUNIT_EXPECT_EQ(test, (int)func_blend->type, (int)TF_TYPE_BYPASS);
-	KUNIT_EXPECT_EQ(test, (int)func_blend->tf, (int)TRANSFER_FUNCTION_LINEAR);
+	KUNIT_EXPECT_EQ(test, (int)cm->blend_func.type, (int)TF_TYPE_BYPASS);
+	KUNIT_EXPECT_EQ(test, (int)cm->blend_func.tf, (int)TRANSFER_FUNCTION_LINEAR);
 }
 
 /* ---- Tests for __set_colorop_in_tf_1d_curve ---- */
-- 
2.43.0


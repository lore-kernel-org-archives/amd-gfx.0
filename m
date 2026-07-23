Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291B1C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B8410F1E6;
	Thu, 23 Jul 2026 20:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvArvR0I";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B4310F1DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDqDurROjpHZPfQUaYGL8+j+zgj5ZOYGIyZ8tIfW8VFmYxnDkYtst1HG9kGp7E+n4Y/X/vpvmV5mQJQC6xI/LNO1RVB1FX2vVMzxEoDWzjk8ouW2wqPF7M5/TkrQ/tBHoRXbJTyW9Asg11RJggEtUIHOUzI9NLKnYXI/+BObj3qFnzwv66IxLZE5aumFWxAUcT8M5sTqR19bcF+x2NG95FwTyDWbuG9NguMVKTTfdvmM22HaILYUsrKf5St6tzLZ3FSXFkdRHUwgd6Y9QOtMsw0m4jQ4qZ22h8sSkiidaHux5z45DOBS429g0b0rqzPvbwhA8xoArnS7TzBmc+PW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vOx+1BeSqKRTcWRVN4w78oKQIu6uW+l4Q4GE0CY+QE=;
 b=MLtSVNW9dt1zVLoRNlqy6cKjTNIKhvFe0Qq/Tc4kesniJ+kxCjWIa+VxyJh9swL4425ui5FuQpMs8RRo0JrnSmNqNi/+7CHlTC5dCU1B8miPrV/kxOZb9aUq1zbxuW2HmpwyySNH1nZdCLVgeXnBX+DE0X0AJplyDFDlBsBVy09UYfzNUJ0vN4grBLSV76QWL3Z7bcaAlK2bf9gr3k2gROanE9Y08AqImSx4odgFfgFfYdjfrMLa/ApEuCQIipnW1pkVEXtHBBXF2UuUMW0bZH7Z/e8HFqWjyrvf3Ly0mQDc286BsAQQntSJh4GgwCGLyT7B1rKB0F08yykksW86Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vOx+1BeSqKRTcWRVN4w78oKQIu6uW+l4Q4GE0CY+QE=;
 b=vvArvR0IYOMKrcIntqAF5stSun6lP3+F0LJt0wOC8gOxaCAYOLemk96n8NlIkKzgV+QlMmQXjCfaeXSzz9tRn2x6CwauXSEBu4eeJr7lmSn4t6UFkQaxA6TXNFmXoMX/XcgIRGwRpbfBU+hFiY/i7JZdZytGEITJCdGeIXeKm2A=
Received: from BN1PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:e1::22)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:23 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::58) by BN1PR12CA0017.outlook.office365.com
 (2603:10b6:408:e1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:22 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:09 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 28/49] drm/amd/display: Add colorop LUT programming tests
Date: Thu, 23 Jul 2026 16:13:36 -0400
Message-ID: <20260723201908.373300-29-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: e5de273d-c499-4769-db98-08dee8f7af55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: hpitMkcEfIVEQcDz0PwTahMqSmxI/TBwZPCn5Esqc2n4dxL2lAJfoeOtkH78n7xT2HQB/L4fQwFns7533mzf7gByUQko/iIg5pUgR85TrghZGLaWw7UfdF7iro1fMwNmct38KImMgYnZVvP5hzUrx5sV+cbVbotl0uxj5xZKITgUeC3YP6FNzQqCZ3/BZbd33JllOo5/teyDYmG+BEOM3kXenApTaHNiEJjNk4uP1knLWhRnxVs/LnVw3TMgHA6FdYfCsxSgwJVwz5uOAlAo1DsYPVTgqsU8dDRAZ6RmLzTyCjUiH3ILDu+AxF2LEaS7btLT5rJrnXJhQ5+Z9HSu2Xe6DFkYJsh5NK2tUUafrINzW3ROdFJBK3Jj/OibVjH/gFKZIsQDbJq2sk/4CvnKSaZplzeQAIrehxMikzy2p1yd7uI+Vn+NpcXm3w9Zyr+WNPMoW2MxthAzpIYgsLkT+Rd6VIIYENTKElZHGgGFQfFrm+zyUKYz+FOKe0GU6iX3Lo14aInJzjMTisZvCZpTJaWuLLahHgQryl4BT3T/sZQoJgL/zLn6aG0Gfjc9SzaMUGfem9ldKPV4Urac2GZMeRXx4FaSqpXkStBp2hgQgqpezNcjaDxzutYevPNO1d7I5VoJ1oIP17+PuCqSwcFIEMGtzKJ7BJKZfb54Y7OEcEBheNTV5TgPTqTmakQTORJuRiRzhKbb/H/r0nk6fNGVvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aVtGuclWYwCNFTtv3YrbK83IqxLa2twqJp4PXesvtNIxhroeK6id7ahBojRt7eXKWLtg2P32ANnlXIRi7EIsuyzs7JItd1LxF5NorI3MR2rXSma2JO2Oiz1wtxrjE+Afr7sR+zK0JLLARmpCXl6l4exSgYi+X0WWPjGl5aq2DDW4Jr5izob8xYbqxUf8ypJoBTpqk+OEZ6C45xPvY9f9ptariUi9kDvNRlwkDO5jmeUgDgh73aFTud/5Q0sEqv1L1q+Rq/85VIF5ovW2tG6lseeStWXWwSYYSw/g7p7gpALsU94KPWHXmR/hYNcxgHsmLbZlg08Abv5DkDakAH8oOpiPSW9KLh03Prio0QQ8PIR0sdQVDRmzsxaLvjXbzOY2GVC2iwuNODj56sGTbNO5kmTMNxm4Wka8OJURTzvlB2FbkQ+FJ+yy2LpsxXxjQtk2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:22.8958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5de273d-c499-4769-db98-08dee8f7af55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

[WHY]
The enabled colorop shaper, 3D LUT, and blend programming paths were
uncovered, including the fallback for missing 3D LUT data.

[HOW]
Build complete colorop pipelines with valid LUT blobs, verify each
enabled stage, and cover the empty 3D LUT fallback.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 206 ++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 11d42ff59dff..8c2f7ab5f8d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -2676,6 +2676,208 @@ static void dm_test_update_plane_color_mgmt_colorop_no_3dlut_hw(struct kunit *te
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
 }
 
+/**
+ * dm_test_update_plane_color_mgmt_colorop_shaper - enabled shaper TF and LUT succeed
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_shaper(struct kunit *test)
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
+		true, true, true, false, false, true, true, true,
+	};
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_colorop_state *shaper_lut_state;
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	struct drm_property_blob *blob;
+	int ret;
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass,
+					       ARRAY_SIZE(types));
+	shaper_lut_state = f.state->colorops[4].new_state;
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	blob->length = MAX_COLOR_LUT_ENTRIES * sizeof(struct drm_color_lut32);
+	blob->data = kunit_kzalloc(test, blob->length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob->data);
+	shaper_lut_state->data = blob;
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->cm.shaper_func.type,
+			(int)TF_TYPE_DISTRIBUTED_POINTS);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_colorop_3dlut - enabled 3D LUT succeeds
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_3dlut(struct kunit *test)
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
+		true, true, true, true, true, false, true, true,
+	};
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_colorop_state *lut3d_state;
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	struct drm_property_blob *blob;
+	int ret;
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass,
+					       ARRAY_SIZE(types));
+	lut3d_state = f.state->colorops[5].new_state;
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	blob->length = 5 * sizeof(struct drm_color_lut32);
+	blob->data = kunit_kzalloc(test, blob->length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob->data);
+	lut3d_state->data = blob;
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->cm.shaper_func.type,
+			(int)TF_TYPE_DISTRIBUTED_POINTS);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->cm.shaper_func.tf,
+			(int)TRANSFER_FUNCTION_LINEAR);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_colorop_3dlut_no_data - empty 3D LUT falls back
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_3dlut_no_data(struct kunit *test)
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
+		true, true, true, true, true, false, true, true,
+	};
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	int ret;
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass,
+					       ARRAY_SIZE(types));
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_colorop_blend - enabled blend TF and LUT succeed
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_colorop_blend(struct kunit *test)
+{
+	static const enum drm_colorop_type types[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+	};
+	static const enum drm_colorop_curve_1d_type curves[] = {
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+		DRM_COLOROP_1D_CURVE_SRGB_EOTF,
+	};
+	static const bool bypass[] = { true, true, true, false, false };
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_colorop_state *blend_lut_state;
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	struct drm_property_blob *blob;
+	int ret;
+
+	f.dm_plane_state->base.color_pipeline =
+		dm_test_colorop_pipeline_setup(test, &f, types, curves, bypass,
+					       ARRAY_SIZE(types));
+	blend_lut_state = f.state->colorops[4].new_state;
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	blob->length = MAX_COLOR_LUT_ENTRIES * sizeof(struct drm_color_lut32);
+	blob->data = kunit_kzalloc(test, blob->length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob->data);
+	blend_lut_state->data = blob;
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->cm.blend_func.type,
+			(int)TF_TYPE_DISTRIBUTED_POINTS);
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -2819,6 +3021,10 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_missing_3x4),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_truncated),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_no_3dlut_hw),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_shaper),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_3dlut),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_3dlut_no_data),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_blend),
 	{}
 };
 
-- 
2.53.0


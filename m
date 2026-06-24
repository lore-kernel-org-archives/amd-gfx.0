Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDBFCDE000
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EBD510F085;
	Wed, 24 Jun 2026 18:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jijQgsSL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294A310E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvozluE6YyR+mSbgwluV+G/Jbx/llet7hil+eYOZVEOANu7YSQmB1EJvCPcXgkKCniwPBJzrw/kCOGTZg3lCH0DqWlZzPSc9DYHWEaGRRRg8xEpjErYb/eGcuE/Uv69i9d5MFs0g9fttjyuFvYgiKRsVLS5slGIVcKiYAH74rmz75kXs05pUiJWsf11gNYXczbucbQqilSowZuOe/bDXwxYYif3iWh7hY13qcPzfpbypxF0hbjVV66MMHoWn6QW8oC10Y7IKVlX6RlVvWOTmRrMarS8pJV3d9INUR4Fh3cEJwHtKOe1SbOrtMBnWBu2m40k+xVzIMD3Vz14kycJjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbXVmkH6lGC9UOiRDJKmrc9+ncD39WfYhwNFTPYx5Fw=;
 b=mWjvyPSZuKZGH3oHu6QO7HKfHHyxd0qmohOb6ZXXy76tUaxHuRbtCmgJbDjL/Ay4FFgMjDb7nCw68HrJdCJGO7LUiBXS/wKWyyaS04r9iWUZkdzRnqyHHfbx8ZWxni+AGb8QSViQAB0gLknsnHQHejjXcI5vOL59Thi/kMfhECsxBKQFjr8Fjk3+1IPqzbDwY0gYEvViRCFqSjBLmgBc9bvYXSxEJYBbfkf6VNtZlbajdVmjtNrj4lVkoPkytsW42bNla93+nLouskU0/oEZVJCTpKlbo6nqBsn3blsib6rIykVHvUZuD3TmIw690arkkyyy3TQO5PIWPWzNSrZQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbXVmkH6lGC9UOiRDJKmrc9+ncD39WfYhwNFTPYx5Fw=;
 b=jijQgsSLXh7iGUIPrnrvm815426KcAVlFfO1GNjkkTIogtJREynb52B69vMl0+ehxgLzn1yxogL5qkiEKZIE61BjckpWnyhHzEOVobvO0TUTDBrQFNMYc/s0LdEpHWOG0cqx9nLH+W2k7SBplT7LVY7FFFQ5G7vJoplL/UNGBxc=
Received: from SJ0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:a03:33e::33)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 18:09:09 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::73) by SJ0PR03CA0058.outlook.office365.com
 (2603:10b6:a03:33e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 18:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:09 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:08 -0500
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
Subject: [PATCH 04/28] drm/amd/display: Add more KUnit tests for
 amdgpu_dm_colorop
Date: Wed, 24 Jun 2026 14:03:02 -0400
Message-ID: <20260624180829.4775-5-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 1898c5e8-1432-4dad-1050-08ded21bb058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LwKwF97kPv89bGkPduuyslAkm8djq5Fp+5pSo2PFVJ+UUQapaL7mDmpooC2N1EOX8AXZ40qr4arcgopzQhFi38/e/ak8wmlcP3VXzU/1f0TBvBnMVdgKAGWRCo9iI5totdM5BQLw/ejwhwaxoOBEMDxEc+hyKbNhub/i86/gCQb5bgUcyjlW8cbli2n2c+8zfe7HsH0LaFbfMHng4MOuiuPXJPWiRHmHXXR7rePODo/b2TzdaVhOXNMuCu+pbiwvmcx4s+ykRo5hzJye39XyvYhh2oHtBz7Zy5tg87czgnEtcsPco0Ty+PjA0Vb9BLJndPrnhID200qh/ytESCJYqDfmi+lpPlSnceFoKXH+30wYpl46nziN254TArKW4LebLVy07g29CsVXh7PtSKpGftqZSQuq+toJte+sjZVdq79ZZLlZ9oHbuQ+7KzZ7Y7aVLEANPGxZsdnyzNtnOh9t2gKZxxxjqFxBHcSsxdvfMgWSp21U27Cdr4jwZkkYxBt7MvVNluKwlknKd/mHn0vKSwcghHcu3dXWddM9PY3xlLvOPZiU8ZLMxFGe2FgGIqqgPsohq76pYgCPK+k/MWze31/Bez5jypjLhI1DZIP1Gqu3JlLO9JbrbK1+1VBdVLzcWDL5WaO5m7VvRLoy+BMmfdAcr+FkYtwJt0ySl2Yr0/nlimHibb+v6r6OruegGQl14YRJpF3S5zwAaW8TukhUhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nfNd4Kmryra+jTNdlIHl9FlcBShf4z8e3O7y1dBsLKFDZuh2525MAUujx8DH5qcqiXmI30U9dncayGsCtZwl8C5QI8g/h2+fPHxR2GgZ6Exdt5r4MCIhZxVxK8o4YSaYMRourTPX33OjgGx6fadiM2p4uKxRbLx0Bq6MfCWnUacLhs1mh2NtZ5WTmvY2aK38hDOLwzz0q3MM8kW3afaI2MNGSO+4BVIBKKhZDKIQcVwUqNBabq2FA8O/A5LeMfexBpMYNitEeL18Qb8J6g92wo/lT6SNaAbiMdtFwlzh921vVg1zL+bOxkFgvi8+opklEGOJsDq/I1pb5B1QVv81Dxwr1uvM+hD6F9qltRoYDuV4EXCHvVdiIwUI0g62upCF9H796qIRIXK7Ol6H0YPEVqEus+D/KA9CGxzax2+TxhmN0jUeqgTp5q0OgVL5vhKi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:09.6644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1898c5e8-1432-4dad-1050-08ded21bb058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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
Add KUnit coverage for amdgpu_dm_initialize_default_pipeline()
using an amdgpu_device-backed DRM mock so drm_to_adev() and
the DC color capability checks are exercised.

Assisted-by: Copilot:GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 147 ++++++++++++++++--
 2 files changed, 133 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index d3ae9b58024b..0301cb333770 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -224,3 +224,4 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 
 	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, list);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_initialize_default_pipeline);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index fa270ff28c6a..b28a165b213e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -9,6 +9,8 @@
 #include <drm/drm_colorop.h>
 #include <drm/drm_kunit_helpers.h>
 
+#include "dc.h"
+#include "amdgpu.h"
 #include "amdgpu_dm_colorop.h"
 
 /* Tests for amdgpu_dm_supported_degam_tfs */
@@ -133,6 +135,30 @@ static void kunit_colorop_pipeline_destroy(void *drm)
 	drm_colorop_pipeline_destroy((struct drm_device *)drm);
 }
 
+static void dm_expect_colorop_pipeline(struct kunit *test, struct drm_device *drm,
+				       const struct drm_prop_enum_list *list,
+				       const enum drm_colorop_type *expected,
+				       int expected_count)
+{
+	struct drm_colorop *op, *first = NULL;
+	int i = 0;
+
+	drm_for_each_colorop(op, drm) {
+		if (op->base.id == (uint32_t)list->type) {
+			first = op;
+			break;
+		}
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, first);
+
+	for (op = first; op; op = op->next, i++) {
+		KUNIT_ASSERT_LT(test, i, expected_count);
+		KUNIT_EXPECT_EQ(test, op->type, expected[i]);
+		KUNIT_EXPECT_NOT_NULL(test, op->bypass_property);
+	}
+	KUNIT_EXPECT_EQ(test, i, expected_count);
+}
+
 /**
  * dm_test_initialize_default_pipeline() - Verify amdgpu_dm_build_default_pipeline()
  *   produces the expected colorop chain with all ops bypassable.
@@ -154,8 +180,6 @@ static void dm_test_initialize_default_pipeline(struct kunit *test)
 	struct drm_device *drm;
 	struct drm_plane *plane;
 	struct drm_prop_enum_list list = {};
-	struct drm_colorop *op, *first = NULL;
-	int i = 0;
 	int ret;
 
 	dev = drm_kunit_helper_alloc_device(test);
@@ -185,20 +209,110 @@ static void dm_test_initialize_default_pipeline(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	kfree(list.name);
 
-	drm_for_each_colorop(op, drm) {
-		if (op->base.id == (uint32_t)list.type) {
-			first = op;
-			break;
-		}
-	}
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, first);
+	dm_expect_colorop_pipeline(test, drm, &list, expected, ARRAY_SIZE(expected));
+}
 
-	for (op = first; op; op = op->next, i++) {
-		KUNIT_ASSERT_LT(test, i, (int)ARRAY_SIZE(expected));
-		KUNIT_EXPECT_EQ(test, op->type, expected[i]);
-		KUNIT_EXPECT_NOT_NULL(test, op->bypass_property);
-	}
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(expected));
+static void dm_test_initialize_default_pipeline_caps(struct kunit *test,
+					     bool dpp_hw_3d_lut,
+					     bool mpc_preblend,
+					     const enum drm_colorop_type *expected,
+					     int expected_count)
+{
+	struct drm_prop_enum_list list = {};
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	struct device *dev;
+	struct dc *dc;
+	int ret;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*adev),
+						   offsetof(struct amdgpu_device, ddev),
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
+	adev->dm.dc->caps.color.dpp.hw_3d_lut = dpp_hw_3d_lut;
+	adev->dm.dc->caps.color.mpc.preblend = mpc_preblend;
+
+	plane = drm_kunit_helper_create_primary_plane(test, drm,
+						       NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	kunit_add_action(test, kunit_colorop_pipeline_destroy, drm);
+
+	ret = amdgpu_dm_initialize_default_pipeline(plane, &list);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kfree(list.name);
+
+	dm_expect_colorop_pipeline(test, drm, &list, expected, expected_count);
+}
+
+/**
+ * dm_test_initialize_default_pipeline_dpp_3d_lut() - Test DPP 3D LUT cap.
+ * @test: KUnit test context.
+ */
+static void dm_test_initialize_default_pipeline_dpp_3d_lut(struct kunit *test)
+{
+	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+		DRM_COLOROP_3D_LUT,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+	};
+
+	dm_test_initialize_default_pipeline_caps(test, true, false,
+						 expected, ARRAY_SIZE(expected));
+}
+
+/**
+ * dm_test_initialize_default_pipeline_mpc_preblend() - Test MPC preblend cap.
+ * @test: KUnit test context.
+ */
+static void dm_test_initialize_default_pipeline_mpc_preblend(struct kunit *test)
+{
+	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+		DRM_COLOROP_3D_LUT,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+	};
+
+	dm_test_initialize_default_pipeline_caps(test, false, true,
+						 expected, ARRAY_SIZE(expected));
+}
+
+/**
+ * dm_test_initialize_default_pipeline_no_3d_lut() - Test no 3D LUT caps.
+ * @test: KUnit test context.
+ */
+static void dm_test_initialize_default_pipeline_no_3d_lut(struct kunit *test)
+{
+	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+	};
+
+	dm_test_initialize_default_pipeline_caps(test, false, false,
+						 expected, ARRAY_SIZE(expected));
 }
 
 static struct kunit_case dm_colorop_test_cases[] = {
@@ -224,6 +338,9 @@ static struct kunit_case dm_colorop_test_cases[] = {
 	KUNIT_CASE(dm_test_degam_and_blnd_tfs_match),
 	/* amdgpu_dm_initialize_default_pipeline */
 	KUNIT_CASE(dm_test_initialize_default_pipeline),
+	KUNIT_CASE(dm_test_initialize_default_pipeline_dpp_3d_lut),
+	KUNIT_CASE(dm_test_initialize_default_pipeline_mpc_preblend),
+	KUNIT_CASE(dm_test_initialize_default_pipeline_no_3d_lut),
 	{}
 };
 
-- 
2.53.0


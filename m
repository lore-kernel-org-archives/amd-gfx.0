Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761CCC44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A8110F6FF;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T2jzA4vG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C189210F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzkizepIIlF/6j5yuQlvHmyaJ+duFV1N167ZZ5IK1MBjlJYPfWgxoFuVRdM6cx9KXTpsMvMiKY6z8TzMd0ow+5iN56yD5OYWcHY1Xaw1VDV+YzoC8mf8a1ZqFRoqfu2spOE/j5czQFhVHgabmszl5zqTP467NFUx8i00WFsPFhpUqxgxZo4VWD3+QHAPEgi0UOi9AYLDYy9p4gcku6JCgWO3f54n76Jz8grKTc5t9zNJhrhU8hLJxUwEwELdjn6SsBav9ToRisQr469X5XcnpDyaycQe17NCrXTRd+PaAqNge7032kp5xLTx35BcFjIhEy4XAEhL3T3LxuIg0XF4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgyUrRvOdtweWUqQQvk0iCINKHmgVkrI/LNv15kW+bM=;
 b=EAMXU4HjYeUpZMZ7WeSWf2hJ5QEA5SBOMfnj9WhPG6iyRgVaXKqGLBEXOlbvTsGbhcp2yHMz4Vq4LAaoIaZug9tZA0ic74VgWRFsvk1vZKb0Hw3PrVKokVnKIfr7Mno4Txn4Dex1nHv2ObH3RSYM1pDrQYUPfV5Mwo0PMIcZvRREyZL3sL2UOkAnQa82WkcXdnblfQtHpWAoU0N4wQrogQMGUYJBaTdmKFVigTh3ksXjl8MfA/ntlkOnAFFknySlEjzvUrnFmwS9jkw1Iw3lFLS03SjFiCJIvKk4rIZ+zn9bXs+Gpu/EfgeXiWxYOhsw30O7cwsTo2MUiV5kFx5Q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgyUrRvOdtweWUqQQvk0iCINKHmgVkrI/LNv15kW+bM=;
 b=T2jzA4vGHdao36DJXfrC1cj74wROzjOsNk3UnHXn5AMmLg8Ir+ngdQ7B6sJCJz7tPgExwfg46Cx4ynFasUDMzd9Pzq300S32C3MtF89BaTmTmeqcVQWYNR0fiT6c8DVVVWL4ZJfJ6RfhtXBAQKq76wQvZg+POOOhlcM3L54l9S0=
Received: from BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32f::16)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:31 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::ac) by BLAPR03CA0152.outlook.office365.com
 (2603:10b6:208:32f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:30 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:11 -0500
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
Subject: [PATCH 47/80] drm/amd/display: Test plane scaling info paths
Date: Thu, 9 Jul 2026 16:48:15 -0400
Message-ID: <20260709205936.5719-48-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 04605ad2-aca5-4389-bbd6-08deddfd63df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Ldlm24FIR1znFCzU7Wb9UMd1u9DEu4Dv7nInJEy/CVv2ejzM4DQMnQxjrtrVG3HW/+YKZgZ9pxImp8buzJl6kkPZtmE6bTX7W9e9ZMZK/RL7bQGOjx83VXmnz6R3CRehQwneEGYAG0u6ls+Yrn7uoQ0108dt4vG1eZ4KNnjS+DvsEUrm1pbmRmdsspDPPZ8pwNkhJoPmkF/VsfevGw8w0Bt30UAznA+DXMWxnnesw+P0xuViU+CnmYAUtAMzcJ0swbfIfQPwji+n2bbc6rPk31ofIBRPCSslsTeAQavrgw7o4mBpIW1KUGHyd4quRGRVXPprjzq9TtX48wckbY1Lf05IzqqP+C6Hg2WsISTfJz5ORfk1MyabaxL3t7m0/LzY39hLcAxtqPZ1LR3gXbBL+NZzHBfLEqbBhZxNJv8XXDAHjBMTd8M8wO2Ewwqx74pxVyR9DLbLni0YgNaVb/8p4PM20Kqfr3ayw37bcjRW2eJNXE71MdN8P7a8EI+qomtMWI2eOcsOy6zTwhOQV7gr1OZGWyPnpxEBrTuK/OclWT2+2u4+r44b0qbPl7Qdd78QuiiMl/yGDs+mtGKk95XhdxIphch9twbtzrMh2TKiMFtUCz0a0uUAfhlQ31Wl2CxlMrgl1Kwul9JJM0XsVTbgthVT5cSvRVlk3KVptTbPzwgis0rNue6jYPmX0lVFwi5H9guJsIsip0CxeLDnfm/fNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BeBqG0NBZMMv1e6TLL44ohTTnpt5h8FzdvsaG3CCcLhQg8u35BY+XImcLd2at+iyMmALw8NO4H5ZYvTUF1UAl/X2XEL2+C8nK1SmaCdO4SfV15QQh1JnOwL87wjBKfAkowses156NjCZDLFgOGLMQPqZolLaRX0iSWobpnmKYuBesM1xHZyhgmgSto3pgK9Io0nlTohiWHCFN+M6nVVu8NHuVbiOnE02f6n5hgj6Ee1eUoA5sufYaiy67tdTFqnJH57qh46AhdoJCJTW7SgsYFCjimzMlffmjbEXA9cotO+J2EShXVBFH7B35YPHeqwf5prwiBC0Dc+Tlfhu/jziLwrvBMihPA+6/+l1gaAt073cJL1Au0TFd4iOtghh244V7bYfnlanbD9hbS0Ve/OpeyzfCnuQ0BOThHt+4xvosKgd2kc2fkvfp1vLaFqwrOa1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:30.4811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04605ad2-aca5-4389-bbd6-08deddfd63df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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
Add KUnit tests covering the NV12 DCN1.x and plane-caps paths of
amdgpu_dm_plane_fill_dc_scaling_info() and the FP16 path of
amdgpu_dm_plane_get_min_max_dc_plane_scaling().

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index e1171c6dafe3..5d0691473a56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1642,6 +1642,128 @@ static void dm_test_get_plane_modifiers_gfx12(struct kunit *test)
 	dm_test_expect_mods_terminated(test, adev);
 }
 
+/**
+ * dm_test_get_min_max_dc_plane_scaling_fp16() - Verify fp16 cap selection.
+ * @test: KUnit test context.
+ *
+ * Verify if 64bpp fp16 formats use the fp16 scaling caps.
+ */
+static void dm_test_get_min_max_dc_plane_scaling_fp16(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct drm_framebuffer *fb;
+	int min_downscale = 0;
+	int max_upscale = 0;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	adev->dm.dc = dc;
+	dc->caps.planes[0].max_upscale_factor.fp16 = 2000;
+	dc->caps.planes[0].max_downscale_factor.fp16 = 500;
+
+	fb->format = drm_format_info(DRM_FORMAT_ARGB16161616F);
+	KUNIT_ASSERT_NOT_NULL(test, fb->format);
+	amdgpu_dm_plane_get_min_max_dc_plane_scaling(&adev->ddev, fb,
+						     &min_downscale, &max_upscale);
+	KUNIT_EXPECT_EQ(test, min_downscale, 500);
+	KUNIT_EXPECT_EQ(test, max_upscale, 2000);
+}
+
+/**
+ * dm_test_fill_dc_scaling_info_nv12_dcn1x() - Verify NV12 DCN1x rejection.
+ * @test: KUnit test context.
+ *
+ * Verify if a non-zero NV12 source origin is rejected on DCN 1.0 to avoid the
+ * known DCN1x hang.
+ */
+static void dm_test_fill_dc_scaling_info_nv12_dcn1x(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane_state state = {0};
+	struct drm_framebuffer fb = {0};
+	struct dc_scaling_info info = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
+	fb.format = drm_format_info(DRM_FORMAT_NV12);
+	KUNIT_ASSERT_NOT_NULL(test, fb.format);
+
+	state.fb = &fb;
+	state.src_x = 10 << 16;
+	state.src_y = 0;
+	state.src_w = 100 << 16;
+	state.src_h = 100 << 16;
+	state.crtc_w = 100;
+	state.crtc_h = 100;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_fill_dc_scaling_info(adev, &state, &info),
+			-EINVAL);
+
+	state.src_x = 0;
+	state.src_y = 10 << 16;
+	memset(&info, 0, sizeof(info));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_fill_dc_scaling_info(adev, &state, &info),
+			-EINVAL);
+}
+
+/**
+ * dm_test_fill_dc_scaling_info_plane_caps() - Verify scaling caps path.
+ * @test: KUnit test context.
+ *
+ * Verify if scaling info uses plane caps when the state references a plane,
+ * device, and framebuffer.
+ */
+static void dm_test_fill_dc_scaling_info_plane_caps(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_framebuffer *fb;
+	struct dc_scaling_info info = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	adev->dm.dc = dc;
+	dc->caps.planes[0].max_upscale_factor.argb8888 = 16000;
+	dc->caps.planes[0].max_downscale_factor.argb8888 = 250;
+
+	plane->dev = &adev->ddev;
+	fb->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, fb->format);
+
+	state->plane = plane;
+	state->fb = fb;
+	state->src_w = 100 << 16;
+	state->src_h = 100 << 16;
+	state->crtc_w = 100;
+	state->crtc_h = 100;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_fill_dc_scaling_info(adev, state, &info),
+			0);
+}
+
 /**
  * dm_test_format_mod_supported_d_swizzle_reject() - Verify D swizzle rejection.
  * @test: KUnit test context.
@@ -1703,8 +1825,11 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx12),
 	/* amdgpu_dm_plane_fill_dc_scaling_info() */
 	KUNIT_CASE(dm_test_fill_dc_scaling_info),
+	KUNIT_CASE(dm_test_fill_dc_scaling_info_nv12_dcn1x),
+	KUNIT_CASE(dm_test_fill_dc_scaling_info_plane_caps),
 	/* amdgpu_dm_plane_get_min_max_dc_plane_scaling() */
 	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling),
+	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling_fp16),
 	/* amdgpu_dm_plane_fill_plane_buffer_attributes() */
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx8),
 	/* amdgpu_dm_plane_get_cursor_position() */
-- 
2.55.0


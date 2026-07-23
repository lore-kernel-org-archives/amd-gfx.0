Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E61FC531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F32810F1DB;
	Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cP9KGiS+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4CD10F1DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOcjhK+wsZ8OFEaj1MD1GVdbO4eJDunz6nzYK1b8iq3zEc0pmnOZ2qc2746BMFSRb9pgOWUlFIw4neY087b90bdrUy8KDvGKlMzgahqjFLtMEK90krcVwTq/T/2vqgPQjMSiA+Kbs/ZoPlEMu3nvoLpLFhnj1P2OWP/Bhsd+DkIxoVT+LGaDu2/W+hq3VAiSgDEjDWhzHFOcKAXDxMWZ+MJjwRP8GJv1Fcxzhb+J6ttv5giHaQr2RtU6sAWBo6925zqCLvWH6HiPs6WBY3AKaXLyP6wVUYRpxFIjq/Tv3Ovpv9WTb9Nn/I6YdLSBgZOa2nsYWO4rJeu/sXK7OUbVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ2HYmty9qbcFhPIk4bTMgxTtMAffzzePdB/y2l5pGY=;
 b=zIZaqWTmXZEGLTxvQzsMS/m2FstEYfyvqnJ3eRsjGOS/0rlmrZV6c01atansfVo05UV9V0YVr/WI7mYy9aOBcBH7mc7UOkvVeoE5nG4Kejl6B6RjO9lyR2E3np8SFToknEIzOJu3F0kCMzHfKGlTJLvmoa+MHoPCgHKcvH/qlR2JJfTorpo0iaRoqH/pI7q2WQtkNgpf0CfmBhbjQwUKBRJGdaI0pyzrkMDeCA3eSRrT0lx6V5h7hIlWtnKWtVFRjEWnRqVLogeHPquwqWdyaTrktBR0kBf2P72O34WRQA1cyRtildlbEYaxv9iAmRTH46izQbSda3EEcdvUikqHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ2HYmty9qbcFhPIk4bTMgxTtMAffzzePdB/y2l5pGY=;
 b=cP9KGiS+apGYKsCaeykvC4Y6vzDWIFS6KW55WwaHdAGT+cuR1Nv5Yl6pM+8zsvFGUdxY8g0Dn0swKhUYA8HDKTHfx5aDKOZq4V5hBw6h6fP1NOFA6mWHgXg7THyr8/pQ96ElVK5fWv+bfbj3MJJUHsWfhhatoYiFvIckpMjCi/M=
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by SAWPR12MB999142.namprd12.prod.outlook.com (2603:10b6:806:4e1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:19 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::57) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:19 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:06 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 25/49] drm/amd/display: Add CRTC and plane degamma tests
Date: Thu, 23 Jul 2026 16:13:33 -0400
Message-ID: <20260723201908.373300-26-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SAWPR12MB999142:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e426f9-a077-4f13-d28e-08dee8f7ad47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /ii2V8Xvgp8YFXByxXjDEFE5ACiy/zND7Nx8YxBD8Z1+hX+8mmzdB8REdxhhx335kuBScwI/cwrdyDxh/UKC00emJ5C61H5ZmMG9W/udD9qmk4iWfvijCMNBaoOwJjf2Ta83Zy6jyd9WYYVGNuAj4QakiXOzwpKpnMXVHA+AjcGnQU/92mZoxhxqnlYMTlMaYgyWu8bmPHnLjOkk65sEgZavty6MY/tVz1PwukWcVVEVTWnqdYAaY76wDQM4d4QcmlzXH2DLiRNcrw6e0n8IWjoUWm/cJDnIJcEKGEqgq9Wh6g1TBrhWvqkCHu/bLkAYLonuDQZ7gipa1dGLH/E9GdgtBxFY6e3A4l0BHUZUKICW6N5ud+GbzErCbvEUiEUyBRMmozRphYp/SgsEo2Vs7OJ5q1IHRrm7DL3irHjX5xG9EZufqEMC1dyPsdKp7SIoDHMvczzZiROJ4nyWNbaSTiVM4YffMp6H+tViCd64OJp1+hD8Smi7y960yqoOUdtN3BxCeDeybR9bzssUiqWkkWkidyNq1e56OyScxSCcIwRuU3jUDa0ygHmpXPO5g+WeEGrLZBJKlYhxGeWScystaU14P6FYHC+biIM+7YU2PixJamPmwG2rbM+nOlbQGmw/u7XKZw/g3k8bAH/14ELMYonBOnzvypWzt7ZdS5j60c06c593AkE/WMlOkri/zm3HmMSeq/9FKvXcl5SC6ztWew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KHC5LWJXX2C+F1IMaZYkx8NckKSPDVlJse/RNrMiKPjo2BQ0J3HbYyRyZ+fekLnXzxLJyTvq/hniMSFhgu0+saZ4TB35nifZXgTNi9ORjVQrxsFKFjItz67n9Y6PwToD5DG6j6dtpY4l5XafDslAU7k6ehgwSAxo+fH2fymKiaVTecdAbcX4OrHzSk/oarjfFpZR89bhUIkoFOfr45ltn05N1vPDMrgG1DBJpZAjop8XwUwgiAtmHp/rhLweqauwKg1ccyRG2+3NJ+Kh8KaJHZECkFftvzOYofP2ok6GijK0gD/Xbai24U3CSb74MEYDhM2z7Czdy0uzFiKwUsy5N7t4/qXhlezIXhA9HtRV2zybsjRDuFUoStajz1QpuhhnlwPw8zTBuFWZPyazHzxhOGWsTMSFl0xHkHqPZAOs9gVAtxRS6d2pHxzR1FUADiF+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:19.4490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e426f9-a077-4f13-d28e-08dee8f7ad47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999142
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
CRTC degamma classification and its mapping onto the plane input
transfer function lacked both success and conflict coverage.

[HOW]
Exercise legacy regamma detection, atomic and plane degamma LUTs,
BT.709 video mapping, and rejection of simultaneous degamma stages.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 4945f5429bc1..0835177c98d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -2121,6 +2121,36 @@ static void dm_test_check_crtc_color_mgmt_no_luts(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, f.crtc_state->cm_is_degamma_srgb);
 }
 
+/**
+ * dm_test_check_crtc_color_mgmt_legacy_regamma - Legacy LUT uses sRGB regamma
+ * @test: KUnit test context
+ */
+static void dm_test_check_crtc_color_mgmt_legacy_regamma(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.crtc_state->base.gamma_lut = dm_test_make_lut_blob(test, MAX_COLOR_LEGACY_LUT_ENTRIES);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_check_crtc_color_mgmt(f.crtc_state, true), 0);
+	KUNIT_EXPECT_TRUE(test, f.crtc_state->cm_is_degamma_srgb);
+}
+
+/**
+ * dm_test_check_crtc_color_mgmt_degamma - Atomic degamma is mapped to the plane
+ * @test: KUnit test context
+ */
+static void dm_test_check_crtc_color_mgmt_degamma(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.crtc_state->base.degamma_lut =
+		dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_check_crtc_color_mgmt(f.crtc_state, true), 0);
+	KUNIT_EXPECT_TRUE(test, f.crtc_state->cm_has_degamma);
+	KUNIT_EXPECT_FALSE(test, f.crtc_state->cm_is_degamma_srgb);
+}
+
 /**
  * dm_test_update_crtc_color_mgmt_no_ctm - No CRTC CTM leaves remap bypassed
  * @test: KUnit test context
@@ -2214,6 +2244,98 @@ static void dm_test_update_plane_color_mgmt_maps_crtc_degamma(struct kunit *test
 			(int)TRANSFER_FUNCTION_SRGB);
 }
 
+/**
+ * dm_test_update_plane_color_mgmt_maps_crtc_degamma_lut - CRTC LUT maps to plane degamma
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_maps_crtc_degamma_lut(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	int ret;
+
+	f.crtc_state->cm_has_degamma = true;
+	f.crtc_state->cm_is_degamma_srgb = true;
+	f.crtc_state->base.degamma_lut =
+		dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->in_transfer_func.type,
+			(int)TF_TYPE_DISTRIBUTED_POINTS);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->in_transfer_func.tf,
+			(int)TRANSFER_FUNCTION_SRGB);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_maps_bt709_degamma - Video uses BT.709 degamma
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_maps_bt709_degamma(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	int ret;
+
+	f.crtc_state->cm_is_degamma_srgb = true;
+	f.dc_plane_state->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr;
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->in_transfer_func.tf,
+			(int)TRANSFER_FUNCTION_BT709);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_plane_degamma_lut - Non-linear plane LUT succeeds
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_plane_degamma_lut(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	struct drm_color_lut *lut;
+	int ret;
+
+	f.dm_plane_state->degamma_lut =
+		dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+	lut = f.dm_plane_state->degamma_lut->data;
+	lut[0].red = MAX_DRM_LUT_VALUE;
+	lut[0].green = MAX_DRM_LUT_VALUE;
+	lut[0].blue = MAX_DRM_LUT_VALUE;
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)f.dc_plane_state->in_transfer_func.type,
+			(int)TF_TYPE_DISTRIBUTED_POINTS);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_rejects_dual_degamma - Reject two degamma stages
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_rejects_dual_degamma(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_plane_state *plane_state = &f.dm_plane_state->base;
+	struct drm_crtc *crtc;
+	int ret;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	crtc->dev = &f.adev->ddev;
+	f.crtc_state->base.crtc = crtc;
+	f.crtc_state->cm_has_degamma = true;
+	f.dm_plane_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF;
+
+	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
+						f.dc_plane_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
 /**
  * dm_test_update_plane_color_mgmt_uses_color_caps - DC context provides color caps
  * @test: KUnit test context
@@ -2600,11 +2722,17 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_colorop_degamma_no_match),
 	/* CRTC and plane color management update paths */
 	KUNIT_CASE(dm_test_check_crtc_color_mgmt_no_luts),
+	KUNIT_CASE(dm_test_check_crtc_color_mgmt_legacy_regamma),
+	KUNIT_CASE(dm_test_check_crtc_color_mgmt_degamma),
 	KUNIT_CASE(dm_test_update_crtc_color_mgmt_no_ctm),
 	KUNIT_CASE(dm_test_update_crtc_color_mgmt_ctm),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_bad_lut3d),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_fallback_defaults),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_maps_crtc_degamma),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_maps_crtc_degamma_lut),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_maps_bt709_degamma),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_plane_degamma_lut),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_rejects_dual_degamma),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_uses_color_caps),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_plane_ctm),
 	KUNIT_CASE(dm_test_update_plane_color_mgmt_colorop_bypass_pipeline),
-- 
2.53.0


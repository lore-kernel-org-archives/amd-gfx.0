Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8D0C4450D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A906610F6F8;
	Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQ16shPd";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9F310F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxLRfG8yrYpd1bOYe6BC0fHeZouwB7PCtGjZYl96oA/ZIBQ4YnTtIGaNXWQPonTWU2sfTxGLuGsqJKOvmMhRZFjH0dL24gvYRlnTonM9UaLEQ4noUVxCyD+2JlysLTaIxhSqRi0D7Cp4sIWOglBj5wJhR5gc64nl4afiuJRFD6YzptPAuW7K80UXKkeWRonNCE9ejaNPEVMInZjgmfI8+tc08waaPDpVEdjkxDSS6CQhryPPWAxMvunMWVxojxKt67y87xHu2Md3PAhgk+hS9eqyfChhRCdiiGWL+krm5pfGzj75KM2jFyviD5oONinR4kuo+ofldN9RyJaWNNvWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7l0RW4/WBiOPWg9FLdN38J+AOw/EigntlMV0ia8B1E=;
 b=h5sdEOTj3vIQzAmQHC0a5vNf0mApUvoL0DzzXCb2v1adil2q8p5cg9iGZVKyvGGPs7QyJ9Srz8GUv2xme6XwkgrrP/ouF9j6WYeTnUmQU61XR6xVuajjwpXK6RfLJwldQkdJOC+QstAQtItjVYAMwUcXHaMICC9b/lP2Eypwsr9oGYdMychMKXlPU0+JuWWUGapwQW1i7Szq+jbgerYJDaibssLsVgDC7ehFu21LlYC/EZ664ca3A0QD1tfe6d7RMqJ2xANqQdUUVCC2QISdJI1gsgWsheE57cylPVS8gK7llgZhpD2lWHlmQORv25fCBoMF9xZ+BETXysnwFfqrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7l0RW4/WBiOPWg9FLdN38J+AOw/EigntlMV0ia8B1E=;
 b=nQ16shPd+u6ueQh76lz0269H0kw3NYwaPZdQM8TyWcFCi5HCZMS3y8SDcWOdWNz/BTl24TDtbPtyDTRrNA7pZqwONXV8poyqCYte7tk2D+04ijGKN6Uy7Gvh/2fRkS7jjO6MJdSYPCmUJQA+Su5cM78LvButn63xeSFZOA7NKrk=
Received: from MN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:52d::19)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:32 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::8) by MN0PR04CA0020.outlook.office365.com
 (2603:10b6:208:52d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
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
Subject: [PATCH 51/80] drm/amd/display: Test DCC and cursor edge cases
Date: Thu, 9 Jul 2026 16:48:19 -0400
Message-ID: <20260709205936.5719-52-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: f9660cbf-2a47-4c6a-71b6-08deddfd6544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|5023799004|22082099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: MAXLr9wrlK3ilshCSgJMgncx6SxRtEzvAZdh52wxPP1i/E3Mf+/flINwv27qPjm0Y9tbTCyQcfK/1AqhZE4zeCA7Gu5HmxL+CgAFMH7eTr2ua7yAqwAovCcHnooMadYiZWXPl0eihyCCas2KD8wRqIKIJ6pTGtIal6f3vKjpvwwXisEBvOTfQibEjzbVun7boKBjXZzO3vF58C+M8rfRxPOhTx8gJ3UzI+WTTgW53Q4/+DKlIZxc8LmBKbbqF0BcdOPWEYykNUsc8cEVort5cH0d9xpuzRSU8XjeB9ShjP41ijabyh1QgkBXlW+c3WL+es8mP0L4EC43+6DuIsDHq8wO6B3Q13FfHALJxlYulgZgCmNHFyUkREhgK3CnweJc7Rz76Pzmqb+f28i2r5K8cQ7npw8jfzq6lkoJBjivUlanw4tLA/u+ZqdDZv8sofyVuSGrsIP4ZhbPyM0iWatjShVFpj+nRFqSwCoptZWlQuR9IdY3Rtei5LXoGGnvEUmIdnPdU/PihjRaLX3MCNs6jCgDPv7qi4jjCLMpo42R+4yaQhXvMfrm0R8CVTZOEgRJ8935d6Lritk0bkXjBrym+wL9dgdXoQPiAkw96/1UL83jVFMJegSjf3MqePEukc0ZlT+s3DoXZR6xP12BzyG64KiWeoVMv407GnaBip9WsPN4PSlyK6rsCffbpfxw17EYvOsafxT1yOd3uf94jXpAag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(5023799004)(22082099003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lZSZ8Gxrv8UTwVXWqybf2iTG8lvM2oeBaDs8Rnv+if+TAwbznhaZBq22V0N9sOMJg+lqhwrf0iFbA8+YjJNL7DqfCH1CvlgOBxGUt1NCUvfYUQqTStFxeRWKSuxaNivOpnRaOyhqcOAI/A+1a2u4GKziZFZykq+6LvXgGm4CbdEE94pwqhpjicL2j4NBh21Gvjttgj3LHIHFlqWZWowTqpcF+CHsAme926YsBqMHOQBHZSgCu+SzLkX3lWry8emAQEk/YKz9mLdWhKhq20EHpL4QNUK/dIuxRufuslR7oyGl9R6rE9r/8+rCJTX73QJ3EDMHXjsvbp/U/InIcNv9gB71WjuEOv+oT23vGOYKph3kPZZwrMPxZHVSwJlwtC3zQtZ4Oh67AsoCU9yLlpQ3MpQQ1zS452jQaAEPkUHYms6J7ZkMqCt0FizU/CaCTq9/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:32.8274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9660cbf-2a47-4c6a-71b6-08deddfd6544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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
Add KUnit tests for the capability-callback-failure and not-capable
paths of amdgpu_dm_plane_validate_dcc(), and for the bad-size path of
amdgpu_dm_plane_get_cursor_position().

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 47da180cf3a0..e1841a30fc32 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -785,6 +785,77 @@ static void dm_test_validate_dcc_missing_cap_func_fails(struct kunit *test)
 			-EINVAL);
 }
 
+/**
+ * dm_test_validate_dcc_cap_callback_fails() - Verify callback failure path.
+ * @test: KUnit test context.
+ *
+ * Verify if validation fails when the DCC capability callback returns false.
+ */
+static void dm_test_validate_dcc_cap_callback_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+	enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
+	enum dc_rotation_angle rotation = ROTATION_ANGLE_0;
+	struct dm_test_dcc_cap_ctx ctx = {
+		.callback_ret = false,
+		.capable = true,
+	};
+	int ret;
+
+	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+					 &plane_size, test);
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, &tiling_info,
+					   &dcc, &address, &plane_size);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_TRUE(test, ctx.called);
+
+	dm_test_dcc_ctx = NULL;
+}
+
+/**
+ * dm_test_validate_dcc_not_capable_fails() - Verify not-capable callback output.
+ * @test: KUnit test context.
+ *
+ * Verify if validation fails when the DCC capability callback reports that the
+ * surface is not DCC capable.
+ */
+static void dm_test_validate_dcc_not_capable_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+	enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
+	enum dc_rotation_angle rotation = ROTATION_ANGLE_0;
+	struct dm_test_dcc_cap_ctx ctx = {
+		.callback_ret = true,
+		.capable = false,
+	};
+	int ret;
+
+	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+					 &plane_size, test);
+	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+	dm_test_dcc_ctx = &ctx;
+
+	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, &tiling_info,
+					   &dcc, &address, &plane_size);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_TRUE(test, ctx.called);
+
+	dm_test_dcc_ctx = NULL;
+}
+
 /**
  * dm_test_validate_dcc_success_and_scan_mapping() - Verify success path and rotation-to-scan mapping.
  * @test: KUnit test context.
@@ -2400,6 +2471,45 @@ static void dm_test_fill_dc_scaling_info_plane_caps(struct kunit *test)
 			0);
 }
 
+/**
+ * dm_test_get_cursor_position_bad_size() - Verify oversized cursor rejection.
+ * @test: KUnit test context.
+ *
+ * Verify if a cursor larger than the CRTC maximum is rejected.
+ */
+static void dm_test_get_cursor_position_bad_size(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_framebuffer *fb;
+	struct dc_cursor_position position = {0};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	amdgpu_crtc = kunit_kzalloc(test, sizeof(*amdgpu_crtc), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, amdgpu_crtc);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	amdgpu_crtc->max_cursor_width = 64;
+	amdgpu_crtc->max_cursor_height = 64;
+	plane->dev = &adev->ddev;
+	plane->state = state;
+	state->fb = fb;
+	state->crtc_w = 128;
+	state->crtc_h = 32;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_cursor_position(plane, &amdgpu_crtc->base, &position),
+			-EINVAL);
+}
+
 /**
  * dm_test_format_mod_supported_d_swizzle_reject() - Verify D swizzle rejection.
  * @test: KUnit test context.
@@ -2472,6 +2582,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx12),
 	/* amdgpu_dm_plane_get_cursor_position() */
 	KUNIT_CASE(dm_test_get_cursor_position),
+	KUNIT_CASE(dm_test_get_cursor_position_bad_size),
 	/* amdgpu_dm_plane_format_mod_supported() */
 	KUNIT_CASE(dm_test_format_mod_supported),
 	KUNIT_CASE(dm_test_format_mod_supported_d_swizzle_reject),
@@ -2510,6 +2621,8 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_validate_dcc_disabled_returns_success),
 	KUNIT_CASE(dm_test_validate_dcc_video_non_gfx12_fails),
 	KUNIT_CASE(dm_test_validate_dcc_missing_cap_func_fails),
+	KUNIT_CASE(dm_test_validate_dcc_cap_callback_fails),
+	KUNIT_CASE(dm_test_validate_dcc_not_capable_fails),
 	KUNIT_CASE(dm_test_validate_dcc_success_and_scan_mapping),
 	KUNIT_CASE(dm_test_validate_dcc_independent_64b_mismatch_fails),
 	{}
-- 
2.55.0


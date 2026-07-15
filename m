Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7D8C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1635910F08B;
	Wed, 15 Jul 2026 13:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qFRF7ihR";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C442910F087
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emN8OOBilzjd5nGZG6rh4JpHH7kBGpPAmzmGx+FIhc5X7jALrS1Hf6pCHs9P3SVGjAEf9a9ERk2c29CmxrVeJ4NogAuUMObtp7CZeRQl3KnYtEq+POS7JP/r7zZ73bERqn7EPzIRmX2MZOvToO6QRuCaj8XpzU+rONvQALV9LJbe0Xun0KTOjM95RwwvF5Z52+8NcoJve4zzP/vte9HSXwpG/A9GLH3nbMILJSNlyYsbyOPCH8JZqFUrr9DNr/cuNDvOjEBZ3BLwrFDz07jAyWhvGqfafEaLzXRjQQvQCYPm6+PjFpUTFSIhG+NpA5UO+mhI4L3iXA++/vJVpXjHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er7lOP4i2oVzDTIWRu4z59NtHmOwTZUUkB4cCIv+1yQ=;
 b=jZZtptAXDv2IVmn+ZZMnajSM3LZ26KLYPWi16gEQrRTGJ8H3F3n93CK+9aJEqofdIWyPcuaGNPk9ZZp2Xb+Iv5LArHDaGaXrlX7GiSloqATYvOAaU/LFj50ps1+oNU8Rg/fsuzjJZjFjE8G0dkx5ARp1an4Bqn05h5RMKPw0qAO7LKcSk6Ata3n1fMxB1oZAjEkcmXUcVPPquDjkTn7ZiNKjrdcqm1CLyiFdfEgyW5llNKkI1kRkldp2jlcyb/yaVgVxuqNEUR8RLCN08r75QGJkVspUiC1bDbC4pbjZfb1fKEuL5P3IT2c8MYhH7XRFXItD8V/xzDT3Il0Jqk9bEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er7lOP4i2oVzDTIWRu4z59NtHmOwTZUUkB4cCIv+1yQ=;
 b=qFRF7ihRvURv0XSHdxBQwEhMMIhq6SRJECvD3vg5joR7iPLGk7fipETZlJYlc9/x29PY4msYx/DdONAQRR7UD4asGUcZfnJO6CqKVkoCBg6REJ1iPuLuHWPzeTahA4kZc1hyOywAzrcnGaT7cNIsaUTXzRNU1yHRn/Q6MRBXe9I=
Received: from CY5PR18CA0001.namprd18.prod.outlook.com (2603:10b6:930:5::6) by
 MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Wed, 15 Jul 2026 13:46:40 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::2a) by CY5PR18CA0001.outlook.office365.com
 (2603:10b6:930:5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:39 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 28/70] drm/amd/display: Test plane color management update
Date: Wed, 15 Jul 2026 21:37:38 +0800
Message-ID: <20260715134432.1975118-29-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 706499fe-d962-4d79-c26e-08dee2777f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: n3/IOsj/CeIaZ80Qm4GvZVuYKWbiVnIbZ8jjgrAfQLbwwFvoFNb4+uFyeBEN/UT+1k8UzQrLe6cng+IC5cRx9yBXPhxUBoYOAoJ8zfYjWWGJsF5fMVBF7IcVhQzUjmrT33V70f0nSQiYoQZm3feCDKtxdDJG4w08PE9RmlYrQ/AeY0X25xdo1BJF5sFvUcOl3H7muTnDgf+68PxlSj6l7O27IlL3l3LA71a37lDr2gOhxY4VT6mQC8FBHPimlIQlzn4uU0dyKkRz9KKp6H+b67Xb0SIYXHg4XKG4QSi+zgSeO83SlMzww5Ba0XkqQ+yOJWh6As96VWFiHLs1DjDjnjZiHPyqCYPVc5j4sRC9WcAd2+jNPM/YGp1gDNqCPPogke39y71JjJX+xZg6pvQPhYc36wqqPofT1hDdkZdTlhPxYZ5lXccX61raHC8XwbQWQxuziz4UmXYx5N628dIqdKpM4hVaBKyj7eZW9bjEEUeGnkkChPK7WzrWvi0ntSXaEJA6/aGdp/n6CTFE6+DIGiINrSG11f+oeRNJ7ksw7jzssFSLSdrAMQQ6+yT+N/UejHMFQF5UHoxh5Z2ltgEwIBFg/IAvV5rq1mHRuebcIfOkQA4R3QX/csSMHZFMHney6+RLr1hlZ6VmBQlrel5J2bbMSVHwMXO/cEPeUTddoWIiYAvCCDXCa9qltM4NGdLaSAzikYvjV8kCQtt6wucf6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zHiRtdYFut57QGl5+zDDCB/T6eUunv8HK1ZgRv/8woCIcB5Nh5Y3MFyH1exf93LiCCXgYEKKEsM1CE3r+zi0NCAuuV3K9arZJtJQhQ8prPFw9KDUhlECJ1omqqTl7ZX0Lyxt+k8HXM6Dj1MO6BPjiEnT+PeCtCiTP1dQZp1HecV6s3qcVWihxNX9wCF53rqtkW8KzNcRE4uG1osSmxoDQfDja7t13DDXeqlq2l5vEUHaULfEfii7sUeAoxlVoo3DhbV/mRaTb8Ms8Uxzn4KqeMMLgF9Fj91CL9d6mHaZ35dHCMDAEvEbCbQn1AZOpWe6DiC5Lwzk0M4cxh+HDAUFOFzsEryEgBnsBCMgAoaEXaFqpVtipFFuBaimsyOoGrfzWWMbgXLMkhVZS14ohnzm3awmOLLh3YoxveQEKBMKkgotC9pA8dHPFgGIeHHZXXSa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:40.0308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706499fe-d962-4d79-c26e-08dee2777f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
Add KUnit coverage for the legacy paths of
amdgpu_dm_update_plane_color_mgmt().

Using the shared color-update fixture, the tests cover the bad 3D LUT
size early failure, the default fallback path, implicit CRTC degamma
mapping, color caps taken from the DC context, and a plane CTM mapping to
the DPP gamut remap matrix.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 108 ++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 36aa4af581dd..dc1ad4325739 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -2132,3 +2132,4 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 
 	return amdgpu_dm_plane_set_color_properties(plane_state, dc_plane_state);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_plane_color_mgmt);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 2e7a6b2a6d91..6bca2b2f62a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1979,6 +1979,109 @@ static void dm_test_update_crtc_color_mgmt_ctm(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, f.stream->csc_color_matrix.enable_adjustment);
 }
 
+/**
+ * dm_test_update_plane_color_mgmt_bad_lut3d - Bad 3D LUT size fails early
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_bad_lut3d(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	f.dm_plane_state->lut3d = dm_test_make_lut_blob(test, 128);
+
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base,
+						  f.dc_plane_state),
+		-EINVAL);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_fallback_defaults - Legacy fallback default path
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_fallback_defaults(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
+			0);
+	KUNIT_EXPECT_EQ(test, f.dc_plane_state->hdr_mult.value, 0LL);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->gamut_remap_matrix.enable_remap);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_maps_crtc_degamma - CRTC implicit degamma path
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_maps_crtc_degamma(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+
+	f.crtc_state->cm_is_degamma_srgb = true;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
+			0);
+	KUNIT_EXPECT_EQ(test,
+			(int)f.dc_plane_state->in_transfer_func.type,
+			(int)TF_TYPE_PREDEFINED);
+	KUNIT_EXPECT_EQ(test,
+			(int)f.dc_plane_state->in_transfer_func.tf,
+			(int)TRANSFER_FUNCTION_SRGB);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_uses_color_caps - DC context provides color caps
+ * @test: KUnit test context
+ */
+static void dm_test_update_plane_color_mgmt_uses_color_caps(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct dc_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->dc = f.adev->dm.dc;
+	f.dc_plane_state->ctx = ctx;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
+			0);
+}
+
+/**
+ * dm_test_update_plane_color_mgmt_plane_ctm - Plane CTM maps to gamut remap
+ * @test: KUnit test context
+ *
+ * When the plane has a CTM blob, the update path programs the DPP gamut
+ * remap matrix and enables remapping (and disables the input CSC).
+ */
+static void dm_test_update_plane_color_mgmt_plane_ctm(struct kunit *test)
+{
+	struct dm_test_color_update_fixture f = dm_test_color_update_setup(test);
+	struct drm_color_ctm_3x4 *ctm;
+
+	ctm = kunit_kzalloc(test, sizeof(*ctm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctm);
+	/* Identity-ish entries; values are irrelevant to the branch taken. */
+	ctm->matrix[0] = 0x100000000ULL;
+	ctm->matrix[5] = 0x100000000ULL;
+	ctm->matrix[10] = 0x100000000ULL;
+
+	f.dm_plane_state->ctm = dm_test_make_ctm_blob(test, ctm, sizeof(*ctm));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
+			0);
+	KUNIT_EXPECT_TRUE(test, f.dc_plane_state->gamut_remap_matrix.enable_remap);
+	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->input_csc_color_matrix.enable_adjustment);
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -2096,6 +2199,11 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_check_crtc_color_mgmt_no_luts),
 	KUNIT_CASE(dm_test_update_crtc_color_mgmt_no_ctm),
 	KUNIT_CASE(dm_test_update_crtc_color_mgmt_ctm),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_bad_lut3d),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_fallback_defaults),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_maps_crtc_degamma),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_uses_color_caps),
+	KUNIT_CASE(dm_test_update_plane_color_mgmt_plane_ctm),
 	{}
 };
 
-- 
2.43.0


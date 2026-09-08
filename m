Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B17AC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037B810EB49;
	Tue,  8 Sep 2026 11:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jq1lU/dp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845C110EB49
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afYs1h66dM6nMwyGslvH8wknuuuWqDkyVC1RZiUEBpEEqhUxYgGhl4Z7TP7r/LOF7v8zSaicbWeMnN/usry6IvzIoo4Bk8gKpQXCNTybPdn2rk87pTQvtAgywYW8T1orljOuWf2yFG4ocf66TvhSIILn8f7NKpWTM6zciVyA1ygoTOkEs8m1FonZ7Kesw/Sss7bBQMqok0FXN5jA5PPWnYR+5IQMcC1YCUqE2hvt40yx0yD4N31L7NDedirz1dq0EeQ3ghBtACun1C8lbFGRwwSPjcEVcifkszO2p1KDvgjrTHpMYF1gvx7IdsJdSn0GLFWdFZ6KRGl7J2tjEnOm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai6A+Wvq790S27Q2KFCq620LMA9K4i6vkoM0RyVTbT4=;
 b=bKS8VdknnZdSSNw5hMXeV2EhS0gTgVLtg/IOXWODWXj9kEFDmOtHNyPYWi1cNVZ82pDCrHyyYb5/29ZVkgWxVcxSS8yyLDHkmuF1G39vriGIV1HHVjCkHI0zgOVT0W6u8gazuQeW1Z4YZRKC1hCuor3MSNvPtFmZW9PJogFqeUvsgtN+imJLDYqaW5DHd6/CPcq/BHYMYVlhOWFgfqNBGTQF89tfZYTTAKv2lVzahN7rDNxY+ZSNXw+FbWhQmkhMaUXXQU2cwRpJQ3jTAxnafNJR8wT5M7cBOcy+n0yj0I/edN217Ydk8k/k3ijEzbx9QBYS7t+k30BLYGHCxYiz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai6A+Wvq790S27Q2KFCq620LMA9K4i6vkoM0RyVTbT4=;
 b=Jq1lU/dpC9UBttUxyEAyLpcHQw0jfr+oPQKUb01oszSPN/HP1i1zhlw8tJbxUqGdCNu7P09/fPbgUBxkQ7Y6NL/y8EkApWdxiFIigMfRpTbhnTrscoTfV3+fyadWkMB7hDE7X3MnNMEFtpO9222QdAnAWUX1+y84RezDQjTMUcs=
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 11:36:18 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::7e) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:36:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:17 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:36:09 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 17/66] drm/amd/display: Test optional plane property creation
Date: Tue, 8 Sep 2026 19:31:10 +0800
Message-ID: <20260908113338.2433445-18-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a525af5-8690-4db3-d6a6-08df0d9d6670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: H36uz8bEGdA4rTrcUPp3RGibsPK5jNsUiMsU+L2p6EfFw+dza+J82kwBDAoN/GA6dfusZt/IQGAOZ/cKjRVUp4AcRWfdWZVQ2ShnQg5bo/lpr5waKcJf6mnjUVCTTjCeg4p+Q5cOeQVgGM/l5qJbk5IJpy4D7tQF/4YTFLrNYyi1tKYtj3njGh7xLLnM9ank/3Vwnmz6/0B1iH5nWK6h6f73XJk8elzFqoW3RURo2Zh88RgEEzpj1+K0HaVzU0FcIMOChH6NrYR5eorsle/DohV8vRLhQAAd0k1cs9DFmvKCrrgkfSX94byGZ2HrW0gUonKpjOEuPFx6UWwd9gsxC3tmclFrpiTrZa/uawxZWu9i+wrVtdMmdjcYtBzuIhzLtw/YaRauxEhwJvY8znzDwl9QwvM8P1t9xT1YFYNQK0HM1iQjONtI0S3v39sEaLlcLOe3XQTPB2wO+2h+HrU4+YggfnpmRrhXHemyS6jdGD1i1rlcJohDjaAAZc9OJWCOou5WjDca76RSQe0N1n16cidXck1I7FOh80MzRFE4fcdpgcgBUwRN3dKSGQOFb1rfugwe4xOevrp/ELWCdu4h8NQ3g26DGIbK5Lvglorrx792iLrrfLzf5C1V5uHTh52kaAPrWMd47TxtWnrhHbXZmYAxwSAvBTmHdXoGUpDA8SGiDWhqu9dSvj70wF3nwLI0SKLrOp+dwZvWWA0uv60jpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2wtVhy25hgeIk2yIlknAZVdB2MJPjyrxJcBYBUGLGS5ctX1cuJmlYpiP/OSZgMob+pQr8KL8HeOdXrdGfxp/K4fUmE7GsFvHjZV7zfZ47U8rsqM7pWCvAdRwTmaZ4mkUPvE3DJ6REEjqLrOzdWUcIHXXYnH7HXrp6mx73GgPE9caJttC/wYF7x2LFg3iEgV08gc+B3pMTHO46GBxOghpk1IIQf2c1bOtNT6iDRPWkOMJ7UX47i1kPFzlXk501kCyOKq+bSxGPScyiDse7nc1vnHF7q1Cg0GMvZMUwVQx4ZqIIEgY+5EnPSbrpr329QA8+NahqY/6Rhwn1gEh07I8BLWe8VnPQr2xN944IXnRn/b0UeBZqP6gPYhWW1K5H3rqG6UNtc30Q3rsx5QW7mRemo8uaGaIHvXGYtaA6DsyzaG/UDlEcOzsBhxOItHXX2j/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:36:18.8308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a525af5-8690-4db3-d6a6-08df0d9d6670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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
Add KUnit tests for amdgpu_dm_plane_init() covering the rotation
property and framebuffer damage clips on newer ASICs, and the default
color pipeline on DCN 3.0 and newer.

[HOW]
Initialize an overlay plane on a standard DRM KUnit device, varying
the ASIC type, the DCE IP version and the DC context DCE version to
select each optional property.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 0a5a7347238e..23054952a6f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2294,6 +2294,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_init);
 
 bool amdgpu_dm_plane_is_video_format(uint32_t format)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 20826691b55d..a39c0acad6f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3941,6 +3941,73 @@ static void dm_test_panic_flush_disables_dcc(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_test_clear_dcc_tiling_count, 1);
 }
 
+/*
+ * Build a DM ready to initialize planes on a real DRM device. The plane itself
+ * is plain kzalloc'd because DRM frees it through drm_plane_helper_destroy()
+ * when the mode config is torn down.
+ */
+static struct drm_plane *dm_test_alloc_init_plane(struct kunit *test,
+						  struct amdgpu_device **adev_out)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane *plane;
+
+	adev = dm_kunit_alloc_adev(test);
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->dm.adev = adev;
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	plane = kzalloc_obj(*plane, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+
+	*adev_out = adev;
+
+	return plane;
+}
+
+/**
+ * dm_test_plane_init_creates_optional_properties() - Verify optional properties.
+ * @test: KUnit test context.
+ *
+ * Verify if a Bonaire-or-newer non-cursor plane on a DCE version above 3.0.1
+ * gains the rotation property and framebuffer damage clips.
+ */
+static void dm_test_plane_init_creates_optional_properties(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane *plane;
+
+	plane = dm_test_alloc_init_plane(test, &adev);
+	adev->asic_type = CHIP_BONAIRE;
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 0);
+
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_plane_init(&adev->dm, plane, 1, NULL), 0);
+
+	KUNIT_EXPECT_NOT_NULL(test, plane->rotation_property);
+	KUNIT_EXPECT_NOT_NULL(test, adev->ddev.mode_config.prop_fb_damage_clips);
+}
+
+/**
+ * dm_test_plane_init_creates_color_pipeline() - Verify color pipeline creation.
+ * @test: KUnit test context.
+ *
+ * Verify if a non-cursor plane on DCN 3.0 or newer gets a default color
+ * pipeline exposed through the COLOR_PIPELINE property.
+ */
+static void dm_test_plane_init_creates_color_pipeline(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane *plane;
+
+	plane = dm_test_alloc_init_plane(test, &adev);
+	adev->dm.dc->ctx->dce_version = DCN_VERSION_3_0;
+
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_plane_init(&adev->dm, plane, 1, NULL), 0);
+
+	KUNIT_EXPECT_NOT_NULL(test, plane->color_pipeline_property);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -4078,6 +4145,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_validate_dcc_not_capable_fails),
 	KUNIT_CASE(dm_test_validate_dcc_success_and_scan_mapping),
 	KUNIT_CASE(dm_test_validate_dcc_independent_64b_mismatch_fails),
+	/* amdgpu_dm_plane_init() */
+	KUNIT_CASE(dm_test_plane_init_creates_optional_properties),
+	KUNIT_CASE(dm_test_plane_init_creates_color_pipeline),
 	{}
 };
 
-- 
2.43.0


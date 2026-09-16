Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5B3C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D95D10E80C;
	Wed, 16 Sep 2026 17:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="swltRTd+";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0631510E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub5LwuHgsxwOsgLFeZGWIVlSJKiuugSCD571UUq6Rsl4A2ew6AtLIayb0ypImU8tMI/TFVCXFATVpjq6TrIfOe66oFsE/CRNDiyTD7vkW1j3BHKxvFNT7hYpxBCpNoXQzvceMBZVQ5LB92Bh+6GJ5pUKMxJmKZua9HWHHSRiEEH5WtiXBbDnzKv7LS5yk4DFnPtF9PeqYbVlEJcDBpZp+ZQJtmsYKonTfhiFLY5tnWAgid0mCCSJ0xB0GIKaaAMn5MUM0vTXimfAryRFf84doCTXGmFnpTFh0NXK3cmHpH+Pyv2i2QqzAn7mjc5WadEyM5w9hcghld6qNoxSMwzndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io7m/SkyFbplPTyY1HkdK7MMzcEyi0g0tV2jgIjiZwY=;
 b=I0i6AF8mAvopdusM8SyzRB+SBmfV5Eg/zETT0w3/i5ctsi543G0SzO3tTc0lnAZcHv8vIntjCXJsC/RdG3HYVsgQ34SDT3OyGze7dDlzguMWahPOHE7EIgM7dERZbu/YIdqPy6JZwbg/XutJkCpcHx01ajzoTmD27j/O8iOFCnMPltntHJphIjvICnvspuBOi7TqEwQ8ECeIjfXCcFvE7QL4ekOqQJXjKbU1KTJXt3Pfk6TcGPPi0PEEWgo0HLA95N/Fvg1Re08ln1tq0I6gJoV6cMrly8682vS39gm5Zs8uz5eNnIQlHZcWfZINy+IzSKMEB1DnCXkJffB8Mv4gDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io7m/SkyFbplPTyY1HkdK7MMzcEyi0g0tV2jgIjiZwY=;
 b=swltRTd+NMfkOAiYbIgZjGvCv9lGZsxeD3289eOAQQcCINqSATgQuBVPjyw/4gAOAKTS1pib/nqVBBpkQMiHgqMqdh2ub2IXxGLzH144aeTPeRCyaEOuRvVeQddwtX+jWxZs1gCQlKJL7njEXljD7bLhfW8vpj94jDcNwlyPB/w=
Received: from CH0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:610:e5::13)
 by DS3PR12MB999239.namprd12.prod.outlook.com (2603:10b6:8:38c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:39 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::59) by CH0PR03CA0248.outlook.office365.com
 (2603:10b6:610:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:27 -0500
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
Subject: [PATCH 18/64] drm/amd/display: Fold DCC validation tests
Date: Wed, 16 Sep 2026 13:51:33 -0400
Message-ID: <20260916175301.368306-19-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS3PR12MB999239:EE_
X-MS-Office365-Filtering-Correlation-Id: dc48a912-de0a-4101-873b-08df141b4c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|5023799004|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PVfGdFh8Uonl6ikHkuYfslTUrDfJKalmPxBpSddqeBQHlm6A5RXhB7rH4GrXv46PMnzEYUzI8vIWJvdjwwRJUFK8UquPvx+8Wl9VVAespExlWRnXQ1zrFxjByia5lAhbVaEKEsNcfGDvYTu458bfgyWkep6WpXbF7OUYk+THHyevK7DQ2xCkx+xZKPpxOaCFcnylZSwALmEiPxtLQvkSXZsD3A89DxYCg9LgN5egRb8/3PgFS+CA7YcL2lZJF/oOEj+9eQzVv2VT4n1IWZiqyc03xtevbwgf+b5NPrja2vQ2J4eoX7F2xGvLKN+XV8DUB8Zyhdcl4ZdQxNas1cXf3IpcCOKOs2gzPPNk8yGwxihqqDR1dC0i1AzTxXOki8n3CI+nLtyyGJy9fU7j/KLkfVCAe0VKxfm8k74fPsDkdfUOSXC0fJRFzcHTgQaCW9o3DNAdW/t6eswlKI1/6aJdJYRvKJDF/nVVOZn/EeTTUqejKqTddQh2rEt5HFpk/vhwCDz/aa2FwuzAOOQqd8iyDuz+4UX+KAGEBfslwQrgzuq3sA/H+aU3uyBhZJBS6ePr1oLqtaEs1jqufP5XcoDYQf85SV9ybGL3laNm4k1rt/fsS7eBBv5tPNTraXlt/VLxPhDLdzMheT7BUw7TbonyrmZcmaPr+I0jRMRzyXAQWDbnZN0zQARliNKzosXMYlg3acv6mu+o6UjWBiygAQ3MBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(5023799004)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8a36jWu+eGC5lJm2LlPyn4BUm/RMUkc/jRWJd7fY6bvnlvpY+zVRdpJfJ1eYUpndD9ekHQJM3E6szGJKXWLS2Qa1G54QfOuf3VRyVeKwEGDZd1X/10xZIKtYCukiKWiGHpGlw1wyoRFAp+wEMMR3AR7Xv9GGZ2CHQgyXYo2MdHJ0VLbcVMa40KS7QQ3iZs9ngLqpKzlqKmgNqH+EYTGoQA7FqhSajx0p4rZyWvhRMxs3Zhi3+NmRnrwXrfths1ZDRgfHOEb9r7cHRp5wjKZ2zD0Ttm+7H/pSdH7f8jowSJ47Hg42AYFDuHW76ASCyYYdyiZfSvuoqS7I/pCSay2kRQ14GRZpxHkL1lwmKs99M+vLqi/udRj/GC7pQdKsRtfmxmBEfTruCyaKNFv3Q0yD89oqNHkczYOByXjreYr+w4820ieDf4Stnu1WL01h3IC6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:39.0621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc48a912-de0a-4101-873b-08df141b4c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999239
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
Reduce the seven KUnit tests for amdgpu_dm_plane_validate_dcc() to
three.

[HOW]
Split them into a table-driven test for the checks that run before the
DC capability query and a table-driven test for the rejections that come
out of it, leaving the success and scan-mapping test unchanged.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 248 ++++++------------
 1 file changed, 76 insertions(+), 172 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index b8489a0b185e..807c91bd8ab1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -633,152 +633,95 @@ static void dm_test_helper_check_state_viewport_reject(struct kunit *test)
 }
 
 /**
- * dm_test_validate_dcc_disabled_returns_success() - Verify disabled DCC is accepted.
+ * dm_test_validate_dcc_early_exits() - Verify the checks before the DC query.
  * @test: KUnit test context.
  *
- * Verify if DCC validation succeeds when DCC is disabled.
+ * Verify if disabled DCC is accepted without consulting DC, and if a video
+ * format on a pre-GFX12 device and a missing capability callback are rejected.
  */
-static void dm_test_validate_dcc_disabled_returns_success(struct kunit *test)
+static void dm_test_validate_dcc_early_exits(struct kunit *test)
 {
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct plane_size plane_size = {0};
-
-	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
-					 &plane_size, test);
-	dcc.enable = 0;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
-			ROTATION_ANGLE_0, &tiling_info, &dcc,
-			&address, &plane_size),
-			0);
-}
-
-/**
- * dm_test_validate_dcc_video_non_gfx12_fails() - Verify video format restriction on pre-GFX12.
- * @test: KUnit test context.
- *
- * Verify if video format DCC validation fails on non-GFX12 devices.
- */
-static void dm_test_validate_dcc_video_non_gfx12_fails(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct plane_size plane_size = {0};
-
-	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
-					 &plane_size, test);
-	adev->family = AMDGPU_FAMILY_NV;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
-			ROTATION_ANGLE_0, &tiling_info, &dcc,
-			&address, &plane_size),
-			-EINVAL);
-}
-
-/**
- * dm_test_validate_dcc_missing_cap_func_fails() - Verify missing capability callback fails.
- * @test: KUnit test context.
- *
- * Verify if validation fails when DCC capability callback is not provided.
- */
-static void dm_test_validate_dcc_missing_cap_func_fails(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct plane_size plane_size = {0};
-
-	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
-					 &plane_size, test);
-	dc->cap_funcs.get_dcc_compression_cap = NULL;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
-			ROTATION_ANGLE_0, &tiling_info, &dcc,
-			&address, &plane_size),
-			-EINVAL);
-}
-
-/**
- * dm_test_validate_dcc_cap_callback_fails() - Verify callback failure path.
- * @test: KUnit test context.
- *
- * Verify if validation fails when the DCC capability callback returns false.
- */
-static void dm_test_validate_dcc_cap_callback_fails(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct plane_size plane_size = {0};
-	enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
-	enum dc_rotation_angle rotation = ROTATION_ANGLE_0;
-	struct dm_test_dcc_cap_ctx ctx = {
-		.callback_ret = false,
-		.capable = true,
+	static const struct {
+		const char *name;
+		bool dcc_enable;
+		enum surface_pixel_format format;
+		int expected;
+	} cases[] = {
+		{ "dcc disabled", false, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888, 0 },
+		{ "video before gfx12", true, SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr, -EINVAL },
+		{ "no capability callback", true, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888, -EINVAL },
 	};
-	int ret;
-
-	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
-					 &plane_size, test);
-	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
-	dm_test_dcc_ctx = &ctx;
-
-	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, &tiling_info,
-					   &dcc, &address, &plane_size);
-	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
-	KUNIT_EXPECT_TRUE(test, ctx.called);
+	unsigned int i;
 
-	dm_test_dcc_ctx = NULL;
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct amdgpu_device *adev;
+		struct dc *dc;
+		struct dc_tiling_info tiling_info = {0};
+		struct dc_plane_dcc_param dcc = {0};
+		struct dc_plane_address address = {0};
+		struct plane_size plane_size = {0};
+		int ret;
+
+		dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+						 &plane_size, test);
+		dcc.enable = cases[i].dcc_enable;
+
+		ret = amdgpu_dm_plane_validate_dcc(adev, cases[i].format, ROTATION_ANGLE_0,
+						   &tiling_info, &dcc, &address, &plane_size);
+		KUNIT_EXPECT_EQ_MSG(test, ret, cases[i].expected, "%s", cases[i].name);
+	}
 }
 
 /**
- * dm_test_validate_dcc_not_capable_fails() - Verify not-capable callback output.
+ * dm_test_validate_dcc_rejects_from_cap() - Verify rejections from the DC query.
  * @test: KUnit test context.
  *
- * Verify if validation fails when the DCC capability callback reports that the
- * surface is not DCC capable.
+ * Verify if a failing capability callback, a surface reported as not DCC
+ * capable, and an independent_64b_blks mismatch are all rejected.
  */
-static void dm_test_validate_dcc_not_capable_fails(struct kunit *test)
+static void dm_test_validate_dcc_rejects_from_cap(struct kunit *test)
 {
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct plane_size plane_size = {0};
-	enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
-	enum dc_rotation_angle rotation = ROTATION_ANGLE_0;
-	struct dm_test_dcc_cap_ctx ctx = {
-		.callback_ret = true,
-		.capable = false,
+	static const struct {
+		const char *name;
+		bool callback_ret;
+		bool capable;
+		bool output_independent_64b_blks;
+		u32 independent_64b_blks;
+	} cases[] = {
+		{ "callback fails", false, true, false, 1 },
+		{ "not capable", true, false, false, 1 },
+		{ "independent 64B mismatch", true, true, true, 0 },
 	};
-	int ret;
-
-	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
-					 &plane_size, test);
-	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
-	dm_test_dcc_ctx = &ctx;
-
-	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, &tiling_info,
-					   &dcc, &address, &plane_size);
-	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
-	KUNIT_EXPECT_TRUE(test, ctx.called);
+	unsigned int i;
 
-	dm_test_dcc_ctx = NULL;
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct amdgpu_device *adev;
+		struct dc *dc;
+		struct dc_tiling_info tiling_info = {0};
+		struct dc_plane_dcc_param dcc = {0};
+		struct dc_plane_address address = {0};
+		struct plane_size plane_size = {0};
+		struct dm_test_dcc_cap_ctx ctx = {
+			.callback_ret = cases[i].callback_ret,
+			.capable = cases[i].capable,
+			.output_independent_64b_blks = cases[i].output_independent_64b_blks,
+		};
+		int ret;
+
+		dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
+						 &plane_size, test);
+		dcc.independent_64b_blks = cases[i].independent_64b_blks;
+		dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
+		dm_test_dcc_ctx = &ctx;
+
+		ret = amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+						   ROTATION_ANGLE_0, &tiling_info, &dcc,
+						   &address, &plane_size);
+		dm_test_dcc_ctx = NULL;
+
+		KUNIT_EXPECT_EQ_MSG(test, ret, -EINVAL, "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, ctx.called, "%s", cases[i].name);
+	}
 }
 
 /**
@@ -819,41 +762,6 @@ static void dm_test_validate_dcc_success_and_scan_mapping(struct kunit *test)
 	dm_test_dcc_ctx = NULL;
 }
 
-/**
- * dm_test_validate_dcc_independent_64b_mismatch_fails() - Verify 64B compatibility check.
- * @test: KUnit test context.
- *
- * Verify if validation fails when independent_64b_blks values do not match.
- */
-static void dm_test_validate_dcc_independent_64b_mismatch_fails(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct plane_size plane_size = {0};
-	struct dm_test_dcc_cap_ctx ctx = {
-		.callback_ret = true,
-		.capable = true,
-		.output_independent_64b_blks = true,
-	};
-
-	dm_test_init_validate_dcc_inputs(&adev, &dc, &tiling_info, &dcc, &address,
-					 &plane_size, test);
-	dcc.independent_64b_blks = 0;
-	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
-	dm_test_dcc_ctx = &ctx;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_validate_dcc(adev, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
-			ROTATION_ANGLE_0, &tiling_info, &dcc,
-			&address, &plane_size),
-			-EINVAL);
-
-	dm_test_dcc_ctx = NULL;
-}
-
 /**
  * dm_test_add_modifier_appends_and_grows() - Verify append and capacity growth.
  * @test: KUnit test context.
@@ -3876,13 +3784,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier() */
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_modifier),
 	/* amdgpu_dm_plane_validate_dcc() */
-	KUNIT_CASE(dm_test_validate_dcc_disabled_returns_success),
-	KUNIT_CASE(dm_test_validate_dcc_video_non_gfx12_fails),
-	KUNIT_CASE(dm_test_validate_dcc_missing_cap_func_fails),
-	KUNIT_CASE(dm_test_validate_dcc_cap_callback_fails),
-	KUNIT_CASE(dm_test_validate_dcc_not_capable_fails),
+	KUNIT_CASE(dm_test_validate_dcc_early_exits),
+	KUNIT_CASE(dm_test_validate_dcc_rejects_from_cap),
 	KUNIT_CASE(dm_test_validate_dcc_success_and_scan_mapping),
-	KUNIT_CASE(dm_test_validate_dcc_independent_64b_mismatch_fails),
 	/* amdgpu_dm_plane_init() */
 	KUNIT_CASE(dm_test_plane_init_creates_optional_properties),
 	KUNIT_CASE(dm_test_plane_init_creates_color_pipeline),
-- 
2.55.0


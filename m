Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9175BC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2B310ED00;
	Wed,  5 Aug 2026 06:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3g3BD+fC";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E97610ED00
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSk1Ep2EczshqMfkeoyKBhDjVoCvXJ14Gllu/NxoyMZk9zUJztRTEmAvUFbPW1BLtHrsed8hvaiFgONZLLqHGg4a+ftppUHHNcO3daggGj+OqlRkXgzZLuTslS6Fg6YUjnb7WzIYgHrV726YQplsVzG0ayrJvA0HF48UomK7b/qhC4Mirjl9W6R2O8vcgZTWgrZQcCyl+8b6Ulgn1n78mJLv3mWY+RSzrHaviLludS8Fen6hIM33BFz+Tc4LANCJD70yLrkDmEV/7qzO9Jn9yZpqyFjaGVOcbMkg4oMZZs4BtQY2w+hWe218GWmbF3N/+pWlTxyn92A9XN+A9jHPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgENp1lpKawr69UvXIA2HeJOfhzn54mNCLXdiABLQ6s=;
 b=KaaOCeXLBbYzEI+2rmtVWI2sICtmT69BrUJTd6jOVSxtYJcHSBLH4XFGtljzoFDaFWPnPMnrvqQFFgpB7A+FkExaXuu67nlpEengWkZdOBPxCKmIYCzpgMg/CRuYWqkM4vWrDh1xj6Ayxcl5xt6ew/oRafs/Cqy8lliphWJcwsPSm1efdDuFuVaGYGfjupK6/zJnqdTZNDXmxa5l9KM0BNaT7RhStka3S2FdrpZhhn/sn8vOAmFDgnAFPiCuKvm0lVpsFqEZpp/cuKx2k+PoAWQylHeYyl38M8jU2RGyIK9KidV27xDgrpSlOPjc4MINEEAFIz4e/2Aeqd69lmJ/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgENp1lpKawr69UvXIA2HeJOfhzn54mNCLXdiABLQ6s=;
 b=3g3BD+fCpm/Bh2wR/gsBE2WGvm4yCR9z6IWpmQzny/39KGLK4seGcZPqcckWgCe/5Fe0CjY0f+Q9ojBu5Sn40eha0ZEvx6BI3W2WgzZz5pFgoy0coqqycW2hE8zWt1EvoZwaphery1sLGDmYcBe0plJbj78JOlLBdfNGoFdGuq0=
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:40:26 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::9d) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:22 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:19 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 08/34] drm/amd/display: Add amdgpu_dm_crtc_init tests
Date: Wed, 5 Aug 2026 14:36:20 +0800
Message-ID: <20260805063937.2145774-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df8706c-2fc5-4565-32d6-08def2bc6ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: ENwb6c5GdvfAqY1iSOasjOOvpgj11vvqTvvbFf+kEWESNLAh2a50AsoDexoth6olpEI3FC7WdOk8jkGP07auo7Hp9KXyTjc7SiQd90yQynFcdpW3p/jUDhopuP5N0rmqUmrA+thb9kUj3pkh4/Y+LihVSHlYc5oNIjA+ZWjViz793Jqf2EWrzcPwaSPH/QvWsvR2qjrhkMtFszyTDsMeYBxxpy05Sk/jg0r1kexAt2/Od00SdInBtrxYR004J1vtrqSN+RkCahU9CkLcWQOvbBPyQbZXYukdh57Zk3MXkE1SnExr7oV6Cz+yODNKcpco30Z4U1FOedyI4H+NvhMXUSrqcun2xAf5uNTzqAaKVtzUlRp0yeJk8/3yIMYP9y8coIVFkKdgGBUUmWkQNtHVRjTEDgr8M3Sxe4qR2jUafhkojowA5m7F5qt78zTOAkMU08GN3I2WIXS3ER+VzCS5ATzxrelo1CQwtVFU0cEX8RL56+GElB+jxCeVUxTY8dFfKEqPZthlH1gEBhDeYDEAYjN47LyYYuSso9uaznPV2T3TcI1OldJVKx7FQ+OgWkLc5LtN1eZd353kf2rQnc8PZAcVRUj0AzUKIIDSQ0R9LObidT2FAN49oDAKYr2EyN5rYiYzzfCh/p8YJCgfUcDbX5siT3mcvr5M/VX/ZwdSJTC0lPs4jzavofmGSEmOy7a+DffcBVMtupn8JWBe6jqNtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sh0wG53LL0j1xUDLc0bm8DkFcTBqrcsGvmZQGBtqYCZBAuA0BSMeFfemvrZBkHmG66bQqSPyvypj9yQlhRYpQkFhRRmuc6Joc2KcdFqX1E+OVswD71Au/a22psC5sJzZkIBLSFKq3NWHFU0HwylM9yLiedAokyhF3Fhwvj21ixG3DjIC4KiJWBq76btn6j8blFb07HClw2IAVOPpyM1xvlWKwdWctZHAx3+9G2AZ4T1y6Qhfxg7mOMOQrx1ACK7ywiZJrTIKXsh/7qeJOSn0eG0DSQw0bwFNeILgaYgZOVKbBwahMH8vSNkGW+tsjIEwMq2LUjajaL6G4DgeVB/kc4jMImw462Vw9/q2hAWoJLb4qEXX5ndYMPAvFyuNN0UTHMR/HDAdYcWxKhPCB5jgg1IQQM3Ix4Ag71SJL+aYeiwfjJQnFu85Q/5nobId+gye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:26.0039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df8706c-2fc5-4565-32d6-08def2bc6ee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

why:
amdgpu_dm_crtc_init builds a CRTC with its primary and cursor planes,
resets its state, and records it in mode_info, but had no coverage for
either the default or the degamma-enabled configuration path.

how:
Add dm_test_crtc_init_registers_crtc for the default (has_degamma == false)
path and dm_test_crtc_init_enables_degamma for the DCN DPP (has_degamma ==
true) path. Both set up an adev, dc with ctx, and a primary plane, call
amdgpu_dm_crtc_init, and verify it returns 0, registers the CRTC, and
initializes the expected fields, then tear down the reset state, CRTC, and
cursor plane the function allocated. The remaining branches are allocation
failures and unreachable defensive paths not drivable under KUnit.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index abe0769ed502..b640e4cc37c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -818,4 +818,5 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	kfree(cursor_plane);
 	return res;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_init);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 7abd85be3019..1a48c6fea8d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -2018,6 +2018,124 @@ static void dm_test_crtc_late_register_inits_debugfs(struct kunit *test)
 }
 #endif
 
+/* Tests for amdgpu_dm_crtc_init() */
+
+/**
+ * dm_test_crtc_init_registers_crtc - Test amdgpu_dm_crtc_init success path
+ * @test: The KUnit test context
+ *
+ * amdgpu_dm_crtc_init allocates an amdgpu_crtc, wires it up with the primary
+ * and a new cursor plane, resets its state, and records it in mode_info. It
+ * must return 0, register the CRTC with the DRM device, and initialize the
+ * CRTC's identifying fields and cursor size limits.
+ */
+static void dm_test_crtc_init_registers_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct drm_plane *cursor;
+	struct drm_plane *plane;
+	struct dc *dc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	dc->caps.max_cursor_size = 256;
+
+	adev->dm.adev = adev;
+	adev->dm.ddev = &adev->ddev;
+	adev->dm.dc = dc;
+
+	plane = drm_kunit_helper_create_primary_plane(test, &adev->ddev,
+						      NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	ret = amdgpu_dm_crtc_init(&adev->dm, plane, 0);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.num_crtc, 1);
+
+	acrtc = adev->mode_info.crtcs[0];
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	KUNIT_EXPECT_EQ(test, acrtc->crtc_id, 0);
+	KUNIT_EXPECT_EQ(test, acrtc->otg_inst, -1);
+	KUNIT_EXPECT_FALSE(test, acrtc->base.enabled);
+	KUNIT_EXPECT_EQ(test, acrtc->max_cursor_width, 256);
+	KUNIT_EXPECT_EQ(test, acrtc->max_cursor_height, 256);
+
+	/*
+	 * Clean up the objects created inside amdgpu_dm_crtc_init(): free the
+	 * reset-installed CRTC state, destroy the CRTC (which kfree()s it), then
+	 * destroy the cursor plane it allocated.
+	 */
+	cursor = acrtc->base.cursor;
+	if (acrtc->base.state) {
+		amdgpu_dm_crtc_destroy_state(&acrtc->base, acrtc->base.state);
+		acrtc->base.state = NULL;
+	}
+	amdgpu_dm_crtc_destroy(&acrtc->base);
+	if (cursor)
+		cursor->funcs->destroy(cursor);
+}
+
+/**
+ * dm_test_crtc_init_enables_degamma - Test amdgpu_dm_crtc_init degamma path
+ * @test: The KUnit test context
+ *
+ * When the DPP reports a DCN architecture (and the ASIC is not DCN 4.01),
+ * amdgpu_dm_crtc_init must enable the DRM CRTC degamma LUT. Exercise that
+ * has_degamma == true branch and confirm the CRTC is still initialized and
+ * registered successfully.
+ */
+static void dm_test_crtc_init_enables_degamma(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct drm_plane *cursor;
+	struct drm_plane *plane;
+	struct dc *dc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	/* DCN DPP with a non-4.01 ASIC selects the degamma-enabled path. */
+	dc->caps.color.dpp.dcn_arch = 1;
+	dc->ctx->dce_version = DCN_VERSION_3_0;
+
+	adev->dm.adev = adev;
+	adev->dm.ddev = &adev->ddev;
+	adev->dm.dc = dc;
+
+	plane = drm_kunit_helper_create_primary_plane(test, &adev->ddev,
+						      NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	ret = amdgpu_dm_crtc_init(&adev->dm, plane, 0);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.num_crtc, 1);
+
+	acrtc = adev->mode_info.crtcs[0];
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	KUNIT_EXPECT_EQ(test, acrtc->otg_inst, -1);
+
+	/* Free the reset state, destroy the CRTC, then the cursor plane. */
+	cursor = acrtc->base.cursor;
+	if (acrtc->base.state) {
+		amdgpu_dm_crtc_destroy_state(&acrtc->base, acrtc->base.state);
+		acrtc->base.state = NULL;
+	}
+	amdgpu_dm_crtc_destroy(&acrtc->base);
+	if (cursor)
+		cursor->funcs->destroy(cursor);
+}
+
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
@@ -2103,6 +2221,9 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_late_register */
 	KUNIT_CASE(dm_test_crtc_late_register_inits_debugfs),
 #endif
+	/* amdgpu_dm_crtc_init */
+	KUNIT_CASE(dm_test_crtc_init_registers_crtc),
+	KUNIT_CASE(dm_test_crtc_init_enables_degamma),
 	{}
 };
 
-- 
2.43.0


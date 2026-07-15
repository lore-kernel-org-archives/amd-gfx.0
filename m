Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBCAC4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FD310F091;
	Wed, 15 Jul 2026 13:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xfQtOfXT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD6810F08E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srl4tXbf5BwWwGVc57WW4Bzoh0V2iRc2ePyVM2O+kZ30MyJnYAzCX+nd+Nb+QTlNaQ87N6UWmRJFsI+kdKX7pRDaXqAcrHVKToobHY6h94WDfop7HfC06/feSvH6BU5N0QDC0w34vbbTVnRfXdL3P5XDC7mxzfGsRwwQnDXlvFArnQ9+oqGijaMLqBH2G73cC3NNLO+BwIf9/7CHB/HYzRYmq+RRXS27Kmzpw5iY3AjRq69q8K4AoyvZVoyT4z+P8yLh3nKgo9UkSPQ9REXebFN8YdejopBdW28UTzg0hZLTaf6bMZhjCsNXm8p8AiiC8ewQ3a9iDqwjcb6z1+kGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3WJo9w9cJdpjCsi/M2lDkka6op1P+wyZE+LvsfAAew=;
 b=lXG/KYUPO+Fq92rlnkaiY+MdKJUoF8Xkh/dtRe16J7YqaE4Zy/NjTmb3SIpDBQSr1r07hL4TdIg2kHynrjkSr8q+KiJgm053w55/gVunOv8OWJVMdGfJw2i8n3OQQVaO/BeX96erGGXWIpyAPTY+SKCMUbOhtqUzI66+gjH2o8n2s8+LPApcenajQAYtcrAvAMUlKtxyE3bi9+NBc8A/3jJS/N1i71JJGgELAGJO6EIv/gidNAdhHFIh11IYvbUBHF8fW5qhhgIe5NtGL9zNwY+IaodMYIA5sg9bbLg0hxxYACe1ZMME6n9/g6AY9LzLSqHiccfDJQdAb89fMKoSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3WJo9w9cJdpjCsi/M2lDkka6op1P+wyZE+LvsfAAew=;
 b=xfQtOfXTy+x1lMlxSzE7b6dEtD9PSYrtqJ9ASvQxzWS02aWTIliinE5EoCQDWKJnDpLCSVsOgqYgwe12S5Ma+OGVgFwQeUyCyS4oWYbYD/7xaw9vub+rDOst2iwyNGdykglsNbagRItcdPWd8UX4N5ADQ1F+xY3hqUq/TvpSMcU=
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:46:51 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::af) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 31/70] drm/amd/display: add KUnit tests for DM CRTC
 vblank/scanout
Date: Wed, 15 Jul 2026 21:37:41 +0800
Message-ID: <20260715134432.1975118-32-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b5a4ea-bf0f-4be0-eb63-08dee277864e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 14mrcDVRlgzokvSQBjq8EGe9tLYoKzC5+KKfaNn6uuBOWna6VeSMSe7SdRa/98lSRbHgWfu+Gu+Hc9sbr+t2sJTBb8obSiFjnvsxGfmmjwNkqdIQmkZ6YDMBa/PKU2m4uxb8uf1Vk7k34WYxXcf8B/26tuO5drWQXEVvRdi8y4iVa5LjRfZQSrEbPHhCshFh2qnZ8mZXnHHkBoCF8Vr7KBvA58v4He6sxUNCvg8LMe59j3MKKTW01c4Lh6QqT/zBLmUWeviSS8aNelt/yFAlxo+8S7HmO02xlwtS0rEywVInSqPvu2I+GBjMrKfGPfJ7UOoZZCSnMSbth3/Rr0aTvHMI7sZdxIY2HRYZP11601Sdob9sKnTmgVas4fdUmpnoUziJiHv5dgSA2LhQ/lX9TpsBBFkE4hyPRbY90pf3Xq/d/pHK05F0hChXf/lv/408NXwPhXmXDCfdMJN+7FnSwJG+05aAzwpgpUXuVjwalN2UedCJ0ux/aHwwVaV0eVm9lsu1939RwyAMx9kUWC3zdxn50IJGdY/GntCAyLhPRjf1D1kmrB2x8bxxe1eLE9i2XrARTrm45FfW0Z5Bt5CxUhvExnAZ5C/dII55C4gPy1t86tY+L4sbHQqIec+vM5Q2SZa7Rupkc0u57A/Mco8P8wnAB8KVo/S5nQOOjJi/TU27aDumXUtW+KKvFWaCNqrQMtE+qB5Svlb6kORyglEbcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AdU5hIkEHA1HgOaJz/oRg1GgEGNanBvQwbdw62zI+cW/RMoN1gWDXY+4VLdmLdWlylPpIXXPIBNXNZkqFBMDDoWo9ZUVsVX0yOrECRJ1DBdqWvUauXWVMeXorYoUwREAogu2mABxmatPcNLiwhINX4BjCBrHBNs0m5kkIKLVQ8JFshfr1wY4xtrk5bDea4olBnKzKfh+Boe3ksjLGsFth8cvlWrvfL++mHUD/mKmxDIbma+q+JlCh+WWWCxPimokyMyZTvSPzIR8cvZrbWjhznKZNrCSkPPbw8nGnK28aPr8vpn5ISLtMqqhn+eqyF7mUBLEMMj8dUHzau3jZp5iBqEdp1rKqsLIOkPnKd3alc2sF8zkt6GGUzvvnwyvRSCrwKxyIeIKo8aoWAlYnyN0lQegRR/4yGZ1MCKj1s50S/h7jNCNM52zZDyEVDpSt08H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:51.4231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b5a4ea-bf0f-4be0-eb63-08dee277864e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
Add KUnit tests for the DM CRTC helpers: the no-writeback and
non-pending writeback paths of amdgpu_dm_crtc_complete_writeback, the
out-of-range and no-stream paths of dm_vblank_get_counter, and the
invalid-CRTC and no-stream paths of dm_crtc_get_scanoutpos.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 112 ++++++++++++++++++
 3 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 80778d7e7337..4b60d7343dec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -169,7 +169,7 @@ static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
  * @return
  * Counter for vertical blanks
  */
-static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
+STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 {
 	struct amdgpu_crtc *acrtc = NULL;
 
@@ -186,9 +186,10 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 
 	return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
 }
+EXPORT_IF_KUNIT(dm_vblank_get_counter);
 
-static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
-				  u32 *vbl, u32 *position)
+STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
+					    u32 *vbl, u32 *position)
 {
 	u32 v_blank_start = 0, v_blank_end = 0, h_position = 0, v_position = 0;
 	struct amdgpu_crtc *acrtc = NULL;
@@ -223,6 +224,7 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_crtc_get_scanoutpos);
 
 STATIC_IFN_KUNIT bool dm_is_idle(struct amdgpu_ip_block *ip_block)
 {
@@ -4686,6 +4688,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
 
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_complete_writeback);
 
 static void dm_clear_writeback(struct amdgpu_display_manager *dm,
 			      struct amdgpu_crtc *acrtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7bb552d1ddba..cbe95fb3c0d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1149,6 +1149,9 @@ int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			     enum amd_powergating_state state);
 void dm_bandwidth_update(struct amdgpu_device *adev);
+u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc);
+int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
+			   u32 *vbl, u32 *position);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index d4e37580316f..7b92078d95bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -77,6 +77,112 @@ static void dm_test_bandwidth_update(struct kunit *test)
 	dm_bandwidth_update(NULL);
 }
 
+/**
+ * dm_test_crtc_complete_writeback_no_connector - Test no writeback connector returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_complete_writeback_no_connector(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_complete_writeback(acrtc));
+}
+
+/**
+ * dm_test_crtc_complete_writeback_not_pending - Test non-pending writeback returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_complete_writeback_not_pending(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc;
+	struct drm_writeback_connector *wb_conn;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	wb_conn = kunit_kzalloc(test, sizeof(*wb_conn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wb_conn);
+
+	spin_lock_init(&wb_conn->job_lock);
+	acrtc->wb_conn = wb_conn;
+	acrtc->wb_pending = false;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_complete_writeback(acrtc));
+}
+
+/**
+ * dm_test_vblank_get_counter_out_of_range - Test out-of-range CRTC returns zero
+ * @test: The KUnit test context
+ */
+static void dm_test_vblank_get_counter_out_of_range(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->mode_info.num_crtc = 1;
+
+	KUNIT_EXPECT_EQ(test, dm_vblank_get_counter(adev, 1), 0U);
+}
+
+/**
+ * dm_test_vblank_get_counter_no_stream - Test missing stream returns zero
+ * @test: The KUnit test context
+ */
+static void dm_test_vblank_get_counter_no_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	adev->mode_info.num_crtc = 1;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test, dm_vblank_get_counter(adev, 0), 0U);
+}
+
+/**
+ * dm_test_crtc_get_scanoutpos_invalid_crtc - Test invalid CRTC returns -EINVAL
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_scanoutpos_invalid_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	u32 vbl = 0;
+	u32 position = 0;
+
+	adev->mode_info.num_crtc = 1;
+
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, -1, &vbl, &position),
+			-EINVAL);
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 1, &vbl, &position),
+			-EINVAL);
+}
+
+/**
+ * dm_test_crtc_get_scanoutpos_no_stream - Test missing stream returns zero
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	u32 vbl = 0;
+	u32 position = 0;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	adev->mode_info.num_crtc = 1;
+	adev->mode_info.crtcs[0] = acrtc;
+
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
+	KUNIT_EXPECT_EQ(test, vbl, 0U);
+	KUNIT_EXPECT_EQ(test, position, 0U);
+}
+
 /* Tests for dm_plane_layer_index_cmp() */
 
 /**
@@ -957,6 +1063,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_set_clockgating_state),
 	KUNIT_CASE(dm_test_set_powergating_state),
 	KUNIT_CASE(dm_test_bandwidth_update),
+	KUNIT_CASE(dm_test_crtc_complete_writeback_no_connector),
+	KUNIT_CASE(dm_test_crtc_complete_writeback_not_pending),
+	KUNIT_CASE(dm_test_vblank_get_counter_out_of_range),
+	KUNIT_CASE(dm_test_vblank_get_counter_no_stream),
+	KUNIT_CASE(dm_test_crtc_get_scanoutpos_invalid_crtc),
+	KUNIT_CASE(dm_test_crtc_get_scanoutpos_no_stream),
 	/* dm_plane_layer_index_cmp */
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_descending),
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E92C5DF99
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A640B10ECC5;
	Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rMHgiRD3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74B210EC99
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvBqw+FIb6h1cOSZqbVFgnRkaRXrMOWzwCy2dmM+icpvkD8HH0FnuCxu4sCybsI62v5kEhmGpe+AqZl4sSD8D+9FWaIbUhWwpGwe3y9+SydkMN/Q4bDOrc1p9aXEJGEstrdwToamxh49yHHY3gZBkV823juNfDwAXl2AI85mQvPR+0vREDJIZnzKRU7MOB7zuvn5Etjt9OUzZgNBobaPItiBZ3VIZsFHwJA4AoRb/s09x23LEVjLFKDy9NUvgwDhETGPfhAFIm23H8eWcS9ucfeN0SXShWX63Rb5wsTfShgaYhlSd9hotmbksGn4vcu8XhiIbC/LNZS+XihdmLxWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugERtL0u2fVLHwJEmF5viovor4yN+udg+BJoQxDEkyM=;
 b=Ylz9Z3bTIpF2Y2mwi0RLPNxH2DOdYh7J8jF8B6ZnX+zitE7eBUHBbxqbuCYxF9HeErljAk1f6+ZU0uM+DDuhINPiPTkqZtW4RQMKIdGEhBuDSvnGIh1w9MUeNzO7EG5/lfcjfTmg5xh451kMQUZYb3xKGrNlEJaFTEygDHDRWDRBZiLhsbB6SHzORfI+WDY8Mm3qoV8nU2M7oaYzMokbeb5AT4gR0e5jFn3j2q+FqCrCh9tB18KAGwh2aWgmVnELFdiFxZg+406GJPQHlXOz+nd2sDUZxqso7oDqn7HGfuTUJQkrHV4FtBmZc+Cmz4E0BDIqv+NaGAi8juoNRDfJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugERtL0u2fVLHwJEmF5viovor4yN+udg+BJoQxDEkyM=;
 b=rMHgiRD3k+g8xv+EosfptXsQABp7mR5b82HLzxOdvxmE4RPnMziSiJQlEw/EjYppbbRVQScOk0SwHIFJ3AQS9m4jTyGyLr4z86UHrdc0T08eVdgrOYOkAW6zLieckQHYZ9i5A38UIUSxQr+pn+Z35LiZZRwvAsVal0PE94VXIPg=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:45 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::5a) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:39 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:38 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 63/82] drm/amd/display: Test writeback handling in
 dm_crtc_high_irq
Date: Tue, 18 Aug 2026 16:15:55 -0400
Message-ID: <20260818202139.4172592-64-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 0210f996-91ee-4739-6400-08defd6676ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Y+xUqFzyzp5/2tUHyfZYDryrJJ9anNbe1i2RctPPhqu4tyjptTWpw4GVirYr/aTtTU2ZiV9147mGkaak+GEbt9XmwV4PfXSKPZsqJMJs6CIwopXp2apdaaTVDakBhDUNFaM/XFYgO3iiRi2PVUEw+tWrparQL4AOkeQuLFvybdYmzBJAo+ladWUglI96cj567A8TC2WG9+8aUjv1lFh/S/aYVoyiiPYq2btYK0eImjf7aTXZUO9Ju7dhPXIKo9kXP4CvDKmjhcwxOYvAowOQSElfrUHD8MUPp3koQlBeijpIOjrUrE3ZNc0B7TZEW8nC7IsdSLS8b5N6OyU9Vr88Wkenxf76H6vH75sJxwKznGFHgHIbzdBeKkecVkev4AwnR/NRKsVM0f8Az0nPX65PQSXWUAJSlSMyM0C2H841fCHO4nTDYBaLHhm/zq6EY8N9dF2pphL8GFnc59Mh9Ue90pecs8z5vytnhr4h5NcrffyYwO5/a3FiXK4PYpJnUqmUw4Z7K9sPCCuPqFT4O7AfqwyFVJTJFlTWJYjnA5qugAu/WyOpXwsjMB9Y8fkb8WBRFkLFKwZ76cUJSgVt9r5STI06bCYgFB5ImbmCsHvncPyoBqnC/3aDMbwxBls0Ec7HoQ+V3Vxr3JTvT8YabTXRU62RsLiekdFHytOgnNgbPg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XRkPmVGwKSiYoJfacUZThx5vLvOS4AniwSUb2uh+YTZsa+Kz3kG0h/wic66IJ+LxnUZpFbNleaCobT1N2ZHQfhdya9yZMqTTwPkuEw1AaQvjmbZsnQxwAlO9syBpBn01JxI3PNRXz1AFtyzqcx8sFE1V8q/FpPcv8X/v10F75KSFNPPFTqhdtteWYAqqwnHtLG2k9qWM3yPb5Z39oI9HU6OPFBa+yywSkrhpngj8cjxMDfeMhGxjbZeNp68hELUKL71bT8wyguesV2aZiQiip1DX5Edt772zsz/FN293Cppvdbja3YaUmpoakBm/YKthlko35STDPPsqM/WYmxfX+BC+Pky1+i63bHaqqdT4R0FaPOJ+MTxS6ihc1IAkjZzfRDwJnGV3BF1SS7x6jH9TUjOcKej+hmVGSwxIxFgoJqvKlJGFJNjBb+9mNRbWhm3B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:45.2195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0210f996-91ee-4739-6400-08defd6676ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
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
Add KUnit tests for the two writeback vblanks in dm_crtc_high_irq(): the
first disables frame capture and marks wb_frame_done, the second signals
the out fence and clears the pending state.

[HOW]
dc_stream_fc_disable_writeback() dereferences dc->res_pool before its
NULL-stream check, so supply a dc with a fake IRQ service. The
completion test queues a bare drm_writeback_job and holds a vblank
reference for the completion's drm_crtc_vblank_put().

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 0bf46e856f5a2..4cb52093987f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_writeback.h>
 
 #include "dc.h"
 #include "inc/core_types.h"
@@ -3524,6 +3525,100 @@ static void dm_test_crtc_high_irq_vrr_ai_no_stream(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
 }
 
+/**
+ * dm_test_crtc_high_irq_writeback_disables - Test first writeback vblank
+ * @test: The KUnit test context
+ *
+ * The first vblank after a writeback is armed must disable frame capture so the
+ * hardware cannot overwrite the buffer, and defer signalling completion to the
+ * next vblank by marking wb_frame_done.
+ */
+static void dm_test_crtc_high_irq_writeback_disables(struct kunit *test)
+{
+	struct drm_writeback_connector *wb_conn;
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	/* dc_stream_fc_disable_writeback() dereferences dc->res_pool. */
+	dc = dm_test_alloc_dc_with_irq_service(test,
+					       &dm_test_irq_service_funcs_dcn10);
+	adev->dm.dc = dc;
+	/* Pre-AI family returns right after CRC handling. */
+	adev->family = AMDGPU_FAMILY_SI;
+
+	acrtc = dm_test_add_crtc(test, adev);
+
+	wb_conn = kunit_kzalloc(test, sizeof(*wb_conn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn);
+	acrtc->wb_conn = wb_conn;
+	acrtc->wb_pending = true;
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VBLANK;
+
+	dm_crtc_high_irq(&params);
+
+	KUNIT_EXPECT_TRUE(test, acrtc->wb_frame_done);
+	KUNIT_EXPECT_TRUE(test, acrtc->wb_pending);
+}
+
+/**
+ * dm_test_crtc_high_irq_writeback_completes - Test second writeback vblank
+ * @test: The KUnit test context
+ *
+ * Once wb_frame_done is set the DMA has had a full frame period to flush, so
+ * the next vblank must signal the writeback out fence and clear the pending
+ * state.
+ */
+static void dm_test_crtc_high_irq_writeback_completes(struct kunit *test)
+{
+	struct drm_writeback_connector *wb_conn;
+	struct common_irq_params params = { 0 };
+	struct drm_writeback_job *job;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+	adev->family = AMDGPU_FAMILY_SI;
+
+	acrtc = dm_test_add_crtc(test, adev);
+
+	wb_conn = kunit_kzalloc(test, sizeof(*wb_conn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn);
+	spin_lock_init(&wb_conn->job_lock);
+	INIT_LIST_HEAD(&wb_conn->job_queue);
+
+	/*
+	 * The job carries no framebuffer or fence, so the deferred DRM cleanup
+	 * work only kfree()s it; it needs nothing from this test.
+	 */
+	job = kzalloc_obj(*job, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, job);
+	list_add_tail(&job->list_entry, &wb_conn->job_queue);
+
+	acrtc->wb_conn = wb_conn;
+	acrtc->wb_pending = true;
+	acrtc->wb_frame_done = true;
+
+	/* Balance the drm_crtc_vblank_put() done on completion. */
+	adev->ddev.vblank[0].enabled = true;
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(&acrtc->base), 0);
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VBLANK;
+
+	dm_crtc_high_irq(&params);
+
+	KUNIT_EXPECT_FALSE(test, acrtc->wb_pending);
+	KUNIT_EXPECT_FALSE(test, acrtc->wb_frame_done);
+}
+
 /* Tests for dm_handle_hpd_work() */
 
 /**
@@ -4154,6 +4249,8 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_crtc_high_irq_no_crtc),
 	KUNIT_CASE(dm_test_crtc_high_irq_vrr_pre_ai),
 	KUNIT_CASE(dm_test_crtc_high_irq_vrr_ai_no_stream),
+	KUNIT_CASE(dm_test_crtc_high_irq_writeback_disables),
+	KUNIT_CASE(dm_test_crtc_high_irq_writeback_completes),
 	/* dm_handle_hpd_work */
 	KUNIT_CASE(dm_test_handle_hpd_work_out_of_range),
 	/* dm_dmub_outbox1_low_irq */
-- 
2.43.0


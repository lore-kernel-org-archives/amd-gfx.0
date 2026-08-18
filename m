Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC3BC5DF85
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECECB10ECB0;
	Tue, 18 Aug 2026 20:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GOqi6k1d";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD28A10E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsS4nMmvm0bFVf+IL/8/mOSyfkZho0mC5V122Z/5JQCSp01UZxqMxgsq5bW8Ehw8bQ6IygXryIj/atTpyCcHdcBh6dik1asoAvbLKlx0nWIuxs5GFj4FHiK+IMQV2r/itbCXD9YiUTFH3AjvJi1sW/1TlvsddycMeG0voAWI+Z1uU3ogX5p7Bhz01U2b2MebE461A4EmqjOjSXbCcyM2e1w39zRPaNMdLs66KTgCDKImwTfF3UXlOQcR31fGK0Aha2W+R2bn9r9ug8vn2KsjJWQJiuCkXHtEXKovpJHaSRTnb+2d49jjZuExrR0VGcECnnRFn7e7rdbIQ+Q++h3zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzde14Yn3P2PUZZ/oOuy3dyODAwfKqkSqOJiFDWKZVM=;
 b=lVitWCDxNnDUztAWDZtUheUci0bit/KYZbEcgDma3pjxPKUm4KL/n4fQyJWy3HwuCeY5jmJhPIV8gi5jYJGcN9knuT/J02Caf1l1zv3F8VLVKzAtwuAmvmw/0oxIL903R7mhmqRPD65NEKm0PUfIDajj8emebyLEpIehPZBJ59kUK6LGZSZwM/WCI61dPS92GIKForT8k9c21Sbmod+E45KuqxG3vV2IAg9h/0MB/Mv1FiXH0TjNUy8x36JBm4+Yx2b5IdA6tU8DtbUZIwLyvc8zefRiFlpmPgZofa7UQGqBZWUjpz2gzmudvcI8lAXrDeS3SL0L8Z5jCYf1Ox/CJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzde14Yn3P2PUZZ/oOuy3dyODAwfKqkSqOJiFDWKZVM=;
 b=GOqi6k1d2yrU43KBXVCG0l6bVVWdbBeK0sZ3MNqcv1WYVU2KqckmTBRtS0dNjLhmFhMQuP21axpUYtj0eCPfApMlMH8p6UPNbz5Vem6b8yDh8WnOivnQBzBzBylC6Aqt4WM7lCsgKgaC4djff6XRKA/7nk/zpS/R3AurE5WOFyI=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:47 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::58) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:44 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:43 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 67/82] drm/amd/display: Test dm_dmub_outbox1_low_irq drain and
 work guards
Date: Tue, 18 Aug 2026 16:15:59 -0400
Message-ID: <20260818202139.4172592-68-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 84463cca-4342-40d4-2573-08defd667813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: M/HOaV3OfXRYUeTeGtoqifSFNBH2aasG/x8AYKPxCSMezmBeY+IwETbmdu6Td/3DljgGclRJg9e8tTZN5ZMGePU/GeGn9ujsBzyp37HH85/V9GRRZbq9m+7I1l904M/q82B2UQWGM1nbtPWtj4ZSLg32uHnGYU6xvFzTg1bXw+8J0Q8fSLFYb/GmazWswXUOwis7GMyUSUtq349neDRsu9RDKk0+ITV1etR8fEubIb1wFnoeYp4K0xSSqunWyCVvzGn3bm/ZyLgWLtlQRlc7OmW0wDtgrvSKfvGUeSP0R0PzfFwryPzrplqLuEFTQMmNofvO1ZM57ViIz3iLF0QRYigCmTin2swaEI2zV0T1OYIqbRQ0z1KXXIxKy2wMRKfi2yONPWTieiHxdaFAxfA8PoLT1x2BVshXQWXpDmhoF0wChG/kLs4RsEjZXdJSIPHiDENM8EXHlHSbdhmRVBrCsTRzJYm7h3itwkF7b99S7VPUYxsAz1njYO60mOQ21RRkyBs7tVdHOFm0d2yFvigXjKsygCiF7D16S5MpH9hCbrwKmXTYkDSMwUXoeO45W9zb7/lM7HM9KjfqyUZcMfOrkbApo/y0ivlq7hKpYsygLX5sgJwTxH7clHCfAIZJ41VZBV57jUf9HAVxmq9BihV89BFLKBJzf6Ij3ECQTbWX21Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+4G8kjeA/pNL7HpOTFtKlltOVVx1u5qRqwbiHbf2q3RAbn1fDTaWiGtaQjMvddyIMHwc6O8ms9OvzcOkC6OmvC9SuOoyDCHB+tFcXiFsxk3EOH7sAazdJTxNTS7c0gHVlHRyVua6qhFC1nZCsr2q1EsBQFEEkWGOSZqZscvQfvk6ELfjYmOQFm4zR1IDPDQCUTYFK6VlUvjboECq+gvCx3X+Gm/ep9Plsc2kLwrxnjrORJIs7y38JY25xHQYCgdcyT3y8yPX0tfKmLqqv/UsrEcs36gTVd1zokF8yVzCotFz0Z8KaJSmN94p0535xi1vXNob5qV4nb2omKAwpEeQOEGf4MIO0FpP0yVxgdVAGIrMM8vwZ9USdswCP/upPfQOJdBCUkKLIDGZ8FYOsnxW3totERJUX7ctxIlgfDarqOe8US5GbGzZZmcoiDcwC4l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:47.5771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84463cca-4342-40d4-2573-08defd667813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
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
Add KUnit tests for dm_dmub_outbox1_low_irq() draining a trace ring up
to the DMUB_TRACE_MAX_READ cap, dm_handle_hpd_work() rejecting a work
item with no notification, and amdgpu_dm_irq_schedule_work() not
queueing once the IRQ workqueue is gone.

[HOW]
Back dmub->outbox0_rb with a fake ring whose write pointer sits one
entry past the cap, and keep the ring larger so the read pointer does
not wrap. dm_handle_hpd_work() returns before its own kfree() on the
NULL-notify path, so the test frees the work item.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 4f22230a5520e..933a33a360fbe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -220,6 +220,18 @@ static uint32_t dm_test_dmub_get_outbox0_wptr(struct dmub_srv *dmub)
 	return 0;
 }
 
+/* One more than DMUB_TRACE_MAX_READ, so the drain loop reaches its cap. */
+#define DM_TEST_OUTBOX0_TRACE_ENTRIES	65
+#define DM_TEST_OUTBOX0_TRACE_BYTES \
+	(DM_TEST_OUTBOX0_TRACE_ENTRIES * sizeof(struct dmcub_trace_buf_entry))
+/* Keep the ring larger than the write pointer so rptr does not wrap. */
+#define DM_TEST_OUTBOX0_RB_SIZE		(2 * DM_TEST_OUTBOX0_TRACE_BYTES)
+
+static uint32_t dm_test_dmub_get_outbox0_wptr_full(struct dmub_srv *dmub)
+{
+	return DM_TEST_OUTBOX0_TRACE_BYTES;
+}
+
 static uint32_t dm_test_dmub_get_outbox1_wptr(struct dmub_srv *dmub)
 {
 	return 0;
@@ -1941,6 +1953,39 @@ static void dm_test_irq_schedule_work_requeue_fallback(struct kunit *test)
 	amdgpu_dm_irq_fini(adev);
 }
 
+/**
+ * dm_test_irq_schedule_work_no_workqueue - Test schedule work after wq teardown
+ * @test: The KUnit test context
+ *
+ * An interrupt that races DM teardown can reach the scheduler after the IRQ
+ * workqueue is gone, so a registered handler must simply not be queued.
+ */
+static void dm_test_irq_schedule_work_no_workqueue(struct kunit *test)
+{
+	struct dc_interrupt_params int_params = { 0 };
+	struct amdgpu_device *adev;
+	int count = 0;
+	void *handler;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count, &count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	destroy_workqueue(adev->dm.irq_wq);
+	adev->dm.irq_wq = NULL;
+
+	amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);
+	KUNIT_EXPECT_EQ(test, count, 0);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 /* Tests for amdgpu_dm_set_hpd_irq_state() */
 
 /**
@@ -3938,6 +3983,28 @@ static void dm_test_handle_hpd_work_out_of_range(struct kunit *test)
 	dm_handle_hpd_work(&hpd_work->handle_hpd_work);
 }
 
+/**
+ * dm_test_handle_hpd_work_null_notify - Test HPD work with no notification
+ * @test: The KUnit test context
+ *
+ * A work item carrying no notification must be rejected before dispatch.
+ */
+static void dm_test_handle_hpd_work_null_notify(struct kunit *test)
+{
+	struct dmub_hpd_work *hpd_work;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	hpd_work = kzalloc_obj(*hpd_work, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work);
+	hpd_work->adev = adev;
+	INIT_WORK(&hpd_work->handle_hpd_work, dm_handle_hpd_work);
+
+	/* The handler bails out before its own kfree(), so free it here. */
+	dm_handle_hpd_work(&hpd_work->handle_hpd_work);
+	kfree(hpd_work);
+}
+
 /* Tests for dm_dmub_outbox1_low_irq() */
 
 /**
@@ -3969,6 +4036,46 @@ static void dm_test_dmub_outbox1_low_irq_empty(struct kunit *test)
 	dm_dmub_outbox1_low_irq(&params);
 }
 
+/**
+ * dm_test_dmub_outbox1_low_irq_drains_trace - Test the trace drain loop
+ * @test: The KUnit test context
+ *
+ * A trace ring holding more entries than the handler reads in one pass must be
+ * drained up to the DMUB_TRACE_MAX_READ cap, leaving the read pointer parked
+ * after the last entry the handler consumed.
+ */
+static void dm_test_dmub_outbox1_low_irq_drains_trace(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct amdgpu_device *adev;
+	struct dmub_srv *dmub;
+	struct dc *dc;
+	void *rb;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub);
+	rb = kunit_kzalloc(test, DM_TEST_OUTBOX0_RB_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rb);
+
+	dmub->outbox0_rb.base_address = rb;
+	dmub->outbox0_rb.capacity = DM_TEST_OUTBOX0_RB_SIZE;
+	dmub->hw_funcs.get_outbox0_wptr = dm_test_dmub_get_outbox0_wptr_full;
+	dc_dmub_srv->dmub = dmub;
+	dc->ctx->dmub_srv = dc_dmub_srv;
+	adev->dm.dc = dc;
+	params.adev = adev;
+	params.irq_src = DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	dm_dmub_outbox1_low_irq(&params);
+
+	KUNIT_EXPECT_EQ(test, dmub->outbox0_rb.rptr, DM_TEST_OUTBOX0_TRACE_BYTES);
+}
+
 /*
  * dm_test_alloc_adev_outbox_notify - Build an adev wired for DMUB outbox
  * notification handling.
@@ -4487,6 +4594,7 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_irq_schedule_work_empty),
 	KUNIT_CASE(dm_test_irq_schedule_work_queues_handler),
 	KUNIT_CASE(dm_test_irq_schedule_work_requeue_fallback),
+	KUNIT_CASE(dm_test_irq_schedule_work_no_workqueue),
 	/* amdgpu_dm_set_hpd_irq_state */
 	KUNIT_CASE(dm_test_set_hpd_irq_state_null_dc),
 	/* amdgpu_dm_set_dmub_outbox_irq_state */
@@ -4555,8 +4663,10 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_crtc_high_irq_schedules_vmin_vmax),
 	/* dm_handle_hpd_work */
 	KUNIT_CASE(dm_test_handle_hpd_work_out_of_range),
+	KUNIT_CASE(dm_test_handle_hpd_work_null_notify),
 	/* dm_dmub_outbox1_low_irq */
 	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_empty),
+	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_drains_trace),
 	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_no_handler),
 	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_direct_callback),
 	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_offload),
-- 
2.43.0


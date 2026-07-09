Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5941C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD0710F6E5;
	Thu,  9 Jul 2026 21:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eoUFNkhh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B406210F6D9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVrXn4nInjGbmIxej3jt5EMXxaXythSsLYsh1DkC6og/rUDRbfhY+a0x9nYtg3Wtb8fkLlIPVM84ke8KjLkvgefdYcuTYG9ePAvLgXBlsC4h97SRTwD8mCCXy2VmcaKIb8XBOYum5O0mr2AIpnvgacGnK/WC6XypED+Us8k4er+buBDbiGBe5WtUwPlqbfJgkAfn5sr/RDvnvdOUr0QriO5B7eL7ZVaN932b3r4pQ2wUuwfKn9Ke2cljHno808DjmW5mixxG/sqgCMah1ELBl3m3mREV8twfuaMe512S6zMOJ6NviQeYf7lF1A6G4kgtQQD7u/GqUY2lXPux/lauMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k++GxIqKiOOI/OxR5Ukmqwoop0hC3Z20QSIqTZXc+uM=;
 b=AkU+5KY4c/fUhTem4xHvR1nHrv+h/sCecocn+CLRvuwB41ty4H2WZmopHVfyBb24Z/MxR5ESBWmJ5UFkQVFT1K6+TNCMIKv+Sve502UG+Ze0OLSwy+vKAOUs4K8tgdLFqMC1dcWdx8oVmBhhTJXrpasC6pRfgecjrA+4BdcyyqV6jFkKlhcDesrcfoqA2rvj80zI9RKs2XPUvZPwHIuUlIw4d0c1pqk/E3zqQ8onvrGL+V4dktSAm20XahhldckDz1yg/JvvaqXgm4frYg+lAQ9L0dqbqsK2BVGSE0PAJux4VwNIA1PSz9X0i5t28g9Bk275IfANcuH2FXIBsd+rvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k++GxIqKiOOI/OxR5Ukmqwoop0hC3Z20QSIqTZXc+uM=;
 b=eoUFNkhhW2kPz3NNmK77z0yugILJrLscoryf0UuByzEey5wSl/HG/gYg/az/4Lsr9JmZsvhIAM/a3FL7+dJfGVREiN2XmZBY2DAy/T7wGK+xWlIaprCrSp4xnYahWSbSJW4PJJAPutviXH5I/QdZQ482LJF6/WFkA/1lM7jmwbs=
Received: from BN9PR03CA0497.namprd03.prod.outlook.com (2603:10b6:408:130::22)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:23 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::68) by BN9PR03CA0497.outlook.office365.com
 (2603:10b6:408:130::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:23 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:03 -0500
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
Subject: [PATCH 36/80] drm/amd/display: Test top-level IRQ handler and
 vmin/vmax worker
Date: Thu, 9 Jul 2026 16:48:04 -0400
Message-ID: <20260709205936.5719-37-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c5aa01-a639-4104-e5ea-08deddfd5f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: rDC+6tCxYclq4NfV66Y2f/eJhXKV3HPOozp42daQL2SqDZHAGgOc0rn3TzW+k2wKH9CVTGuBKvwI7v/eVJIFcXskliz0tttPpWb9hhbEAYlo3EaxGv/5p8ei1FNgYCs7c+qIvcVUWgj0GF1fNp+YzT870EVuEYZx3MA6z4jKCjK7PR0luOXj1zgyyTCmQTnG1jufuiQnzt9TLVNjCJ0DdZXTz1rRrCaTKcCeuNtdfXvuw7R3P12/1WJGL32m4JAAhHEpwUY7MkBrfHvmhuEQcwjTesOETNv8JUeeWcML5IxyjxwUid9mT5mGQxchs+xGTx3fUTPr8pVe+HWJ3AZ3drhBjsdpl4JsYq3PetLWRPdYHqRBm6nyvoPjiEOHwtue5ye9cEyaLDQb5oCrQNulnqd4Enz1Us9O+JfY5DWhRDo6kWMzQW8GwxJV2BTGbn88dgNY9wYUnlps1yWyqL0sKYwub8cILyRYMvm04aoflagFmG4FwI1BYB29Wlifof2N+Zkh+2IumJl0hP0Xdd5loNyfsuBKxzlWyFlzKJ7E/tME0VAcqjIZL1zf9oago2MYfshbigzQm4/8qSqdPdNwzAe8sGPmFp5NHYoiYQOSRblw01OGHaC9SakXdHyxweDzu/GM4rCqE/ZWKZMIep+/jBnKLTfy4OIUC9n0iRLCjL3fe3ttT1iCiSKdZkQ0ee9bYrf+D5wizjMQVlcni7US3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4kkeXQTFtKuElzR/y6kk7KyhS9ghhSy/q1gCQ7py+1WEvW7H8GV0t2U4szwJcte6nBXAiCRoTwYvpAtzMzbZsTSYzVZCzMY0kGTe/P0/Zs7KTTnMxSbtFU35BGe7F+LCnMI2S0+C4y41QOJnm+KRsqHaLF/yEzf0GstxKyLKtdq8lroYT3tYLyCZsSwOR1Sx21WRgoqwDzmyOeYUJmAvNw0Ha8OB8VTIYIQL4UTyrUhjeD1GQWdp/4kolf3SJVweVbFRKNpy4gFqOY2r1enK2fe4qVgi58jtn0srKzzQ9Yd/PdwGwHNaOipNPB/QW5M5dPqcJFDqAFmKA5uNMnpJQx8bT27n6ow5OMjGWJ1ORuaIIisRWMXLM9t33Vh8DteQoqQqVna/kzNDWk1xGBhzmSGDqsINgI1D+1PpCwDaqaBtxLELUNJ2FW2/fZbVSx26
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:23.2309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c5aa01-a639-4104-e5ea-08deddfd5f8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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
Add KUnit coverage for the two remaining uncovered functions in
amdgpu_dm_irq.c: amdgpu_dm_irq_handler() and dm_handle_vmin_vmax_update().

amdgpu_dm_irq_handler() is driven with a fake dc whose irq_service maps
the hardware IRQ entry to a DC source and whose per-source info table
lets dc_interrupt_ack() succeed; high- and low-context counting handlers
verify the immediate and scheduled dispatch paths.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   5 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 125 ++++++++++++++++++
 3 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index dab970e064ff..32caba06927a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -679,7 +679,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_immediate_work);
  * Calls all registered high irq work immediately, and schedules work for low
  * irq. The DM IRQ table is used to find the corresponding handlers.
  */
-static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
@@ -699,6 +699,7 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,

 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_handler);

 STATIC_IFN_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
 {
@@ -1874,7 +1875,7 @@ STATIC_IFN_KUNIT void dm_pflip_high_irq(void *interrupt_params)
 }
 EXPORT_IF_KUNIT(dm_pflip_high_irq);

-static void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
+STATIC_IFN_KUNIT void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
 {
 	struct vupdate_offload_work *work = container_of(offload_work, struct vupdate_offload_work, work);
 	struct amdgpu_device *adev = work->adev;
@@ -1889,6 +1890,7 @@ static void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
 	kfree(work->adjust);
 	kfree(work);
 }
+EXPORT_IF_KUNIT(dm_handle_vmin_vmax_update);

 static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index da698f224d85..4c200a9614a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -124,6 +124,7 @@ int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev);

 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 struct amdgpu_irq_src;
+struct amdgpu_iv_entry;
 enum amdgpu_interrupt_state;

 enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type);
@@ -178,6 +179,10 @@ void dm_vupdate_high_irq(void *interrupt_params);
 void dm_crtc_high_irq(void *interrupt_params);
 void dm_handle_hpd_work(struct work_struct *work);
 void dm_dmub_outbox1_low_irq(void *interrupt_params);
+int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
+			  struct amdgpu_irq_src *source,
+			  struct amdgpu_iv_entry *entry);
+void dm_handle_vmin_vmax_update(struct work_struct *offload_work);
 #endif

 #endif /* __AMDGPU_DM_IRQ_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index c356c2c836b4..5a4fecdf3135 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -3802,6 +3802,127 @@ static void dm_test_register_outbox_irq_handlers_with_dmub(struct kunit *test)
 	amdgpu_dm_irq_fini(adev);
 }

+/* Tests for amdgpu_dm_irq_handler() */
+
+/**
+ * dm_test_irq_handler_dispatches_work - Test the top-level IRQ handler
+ * @test: The KUnit test context
+ *
+ * amdgpu_dm_irq_handler() translates the hardware IRQ entry to a DC IRQ
+ * source, acknowledges it, then dispatches to the high-context (immediate)
+ * and low-context (scheduled) handler lists. A fake dc with a stubbed
+ * irq_service maps the source id to DC_IRQ_SOURCE_VBLANK1 and lets the ack
+ * succeed without touching hardware registers.
+ */
+static void dm_test_irq_handler_dispatches_work(struct kunit *test)
+{
+	struct dc_interrupt_params int_params = { 0 };
+	struct amdgpu_iv_entry entry = { 0 };
+	struct amdgpu_device *adev;
+	int high_count = 0;
+	int low_count = 0;
+	void *handler;
+	struct dc *dc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	dc = dm_test_alloc_dc_with_irq_service(test,
+					       &dm_test_irq_service_funcs_dce110);
+	adev->dm.dc = dc;
+
+	/* High-context (immediate) handler on VBLANK1. */
+	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_VBLANK1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count,
+						   &high_count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	/* Low-context (scheduled) handler on VBLANK1. */
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler_count,
+						   &low_count);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	/* src_id maps to DC_IRQ_SOURCE_VBLANK1 via the dce110 stub. */
+	entry.src_id = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0;
+	entry.src_data[0] = 0;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_irq_handler(adev, NULL, &entry), 0);
+
+	/* High-context handler runs synchronously in-place. */
+	KUNIT_EXPECT_EQ(test, high_count, 1);
+
+	/*
+	 * Low-context work runs asynchronously; amdgpu_dm_irq_fini() flushes
+	 * each pending work item before freeing, so it has run afterwards.
+	 */
+	amdgpu_dm_irq_fini(adev);
+	KUNIT_EXPECT_EQ(test, low_count, 1);
+}
+
+/* Tests for dm_handle_vmin_vmax_update() */
+
+/**
+ * dm_test_handle_vmin_vmax_update - Test the deferred vmin/vmax worker
+ * @test: The KUnit test context
+ *
+ * The worker applies the cached timing adjust to the stream via
+ * dc_stream_adjust_vmin_vmax(), drops the stream reference taken when the
+ * work was scheduled, and frees the work and its adjust copy. A fake dc with
+ * a current_state lets the adjust walk an empty pipe list without touching
+ * hardware. The work and adjust are kmalloc'd because the worker frees them.
+ */
+static void dm_test_handle_vmin_vmax_update(struct kunit *test)
+{
+	struct dc_crtc_timing_adjust *adjust;
+	struct vupdate_offload_work *work;
+	struct dc_stream_state *stream;
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	mutex_init(&adev->dm.dc_lock);
+
+	dc = dm_test_alloc_dc_with_ctx(test);
+	dc->current_state = kunit_kzalloc(test, sizeof(*dc->current_state),
+					  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc->current_state);
+	adev->dm.dc = dc;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	/*
+	 * Start at two references: the worker's dc_stream_release() drops one,
+	 * leaving the kunit-managed allocation intact (no kfree).
+	 */
+	kref_init(&stream->refcount);
+	kref_get(&stream->refcount);
+
+	/* The worker kfree()s both, so they must come from the slab. */
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, work);
+	adjust = kzalloc(sizeof(*adjust), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adjust);
+
+	work->adev = adev;
+	work->stream = stream;
+	work->adjust = adjust;
+	adjust->v_total_min = 1000;
+	adjust->v_total_max = 1100;
+
+	dm_handle_vmin_vmax_update(&work->work);
+
+	/* The adjust was applied and one stream reference was dropped. */
+	KUNIT_EXPECT_EQ(test, stream->adjust.v_total_min, 1000);
+	KUNIT_EXPECT_EQ(test, stream->adjust.v_total_max, 1100);
+	KUNIT_EXPECT_EQ(test, kref_read(&stream->refcount), 1);
+}
+
 static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_to_dal_irq_source */
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
@@ -3958,6 +4079,10 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_one_crtc),
 	KUNIT_CASE(dm_test_register_outbox_irq_handlers_without_dmub),
 	KUNIT_CASE(dm_test_register_outbox_irq_handlers_with_dmub),
+	/* amdgpu_dm_irq_handler */
+	KUNIT_CASE(dm_test_irq_handler_dispatches_work),
+	/* dm_handle_vmin_vmax_update */
+	KUNIT_CASE(dm_test_handle_vmin_vmax_update),
 	{}
 };

--
2.55.0


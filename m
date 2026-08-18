Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB561C5DF89
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660A610ECCF;
	Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PfJtzUnM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29BF10ECB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ2gZ6UXq5tgj+2rCAa7wv2/JwjopFyctsKYwk1UMOYNryDHJ3LBki3Ov6UdkDP5ybNEjucnEYwKShG/8bIgladiXdcfc6duWNh8Yqmm2kQNyJIS4Dfy9x3hunke83x7P5YWay9749ilHj/Y/fkIvTY/GETJ8cSZe7HGkhf7aZUsnFnrCcpl6Zwj+L/QGnJwsst3KoWaAVz/H7uThVCauVYIb2Tuwle+MXzZYKr6QKpoCv458Su2fRLV+QyhC6s7tnAhbEKhIyskveu1sD7bMseDv5meWrMyBSAO5eon7GcYutHRzK0QPJ+iQi4n5mnCND1uCiFazIuuOxJEBz7Tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQg1MKQNP0y8I0oCmciOK66JU1su7d4gXdHqxKLKRjA=;
 b=JI9oH3v2l2A9nfrDhm77y9FeoCYhBfzZWr2DoIhWA0OFgqpNTT1AZq4uDH2HhtZyrUdwcbc6FOv7e/grrocsLEghrgjO9wyb7xalxbpa24ZEnejSRdvDHp4fM7wu7byAfBwmxgEGaJae115wng/LvsMvN8F3P+q87bYHFWdHOcmFJDLaASKuMT4SI1rbONlHFsvEXGLK0ifK16azhTQI1MZ3Hd13j0Na09XlvIeo/DBZRXNZR054pWJqOL5wsJ9cHgSvbslXbhmFrZkqDhtqgWr0O6XBsx0gKLg+Wl/bmDf7+y4WQztBmNsuEOu6JoQcHCQqqArb/pgtjQczF4MsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQg1MKQNP0y8I0oCmciOK66JU1su7d4gXdHqxKLKRjA=;
 b=PfJtzUnMPpUAl1Sq2+PJ6zl/LyBI8OeXetsksNFfGZ5GTorn1AIngQOG6ITqtCI8SlSp4lR0vgWU1484fqWb7c3nRnOb8pHlJMsAK7tvWI/7I/coZpJVPvOqLPhdachAd6u8h6z4J5lA2b2jpFZi71iMqR5yVZno2zYneQK+myA=
Received: from BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::15)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Tue, 18 Aug
 2026 20:22:47 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::60) by BL1P221CA0004.outlook.office365.com
 (2603:10b6:208:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:43 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:42 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 66/82] drm/amd/display: Test HPD RX,
 HPD init and DMUB callback branches
Date: Tue, 18 Aug 2026 16:15:58 -0400
Message-ID: <20260818202139.4172592-67-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 202b819c-6801-4397-093b-08defd6677b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fOamzpVAOE8ajS9UaaSxea0WpjjqGs2GnSJXYWzukKd7nbbX2Jina4ATyxeSrSElgw7FNyWVs4tcdyTlSZSXC1opTVh1J6aFiaKNdeP9b5OyBGeT2Cq+IgSbZLdhYhzgGUvBYzzYE6HnD2k26RxWg6UbPsymEwHRoavrpwoIY9y/0jh5wierkIJKEr0JO4pdnycPBAe+E+DA+J1wQ90sGesJFVzN5L1DWCdavvuxIpMzalD001Dz2abj3XRSgRaSSXsK+RjbepqdXLuQvxmPqoUdDGSEF2VXL584U8SL4+3scS9ufgmbZHbG2IIskWiaL1ix/o2tAIeEkdgD9CYnvhRbnbSA7/Vg5i+IlcM1P7+oKlmewN9vxJZdRB14K4IsRf5O5kUno0LAn45OiaEr8KRmK4jyy/MxPMSYNqMRm+3qxjf3cQPlKuLmXXh4Prl+aLHyvg4mc0G9RWvjfYQDBB5b3Cue81P4ACEtiNlS8b+FaBePXVdK4sNdO47TnjEmr70aDVcwHEu4LoaJlUsRQhI5W+0KnB6LBbdfyqOs3hu2bKANjSGd8BYZ0XjQVfPWSXWLHD1VQKclaNhiD/iWdB7MlJk0FxEntnqkhEi+8zHE1fEkharNE5M1gh3zVa0U0GYkTrnkGU4gfrDJZ7emWECUBDA6YHWq85wtFi06IOA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h2qtGw1f3fQF4Z/mI24OX5y/b5oYzTP7qA+BEjBOzR78PgsY0jPKBkREXDCjRNbJuIdxxwsqXJM4anweqsB0RDMCoFOCl4RnyqVsu/B2om3rzLa+elrUUlwrVp3bAhGMEVW/Pt4hPExhmqQgvlTwjKlWtNp+HN9vScogYqb97/WMEp8FhjL8W6UVR7YhFTYR6gflhcH/P6vJda4LiMTJvr9iMV76E3fJFOwpCzlDDYVe3ViidHJ4LI8lYkg/VangR1KTI2OzxaioKSo1D1tgO+SPFey89aomBvhOk81H3k7eP10YSnCAgynQY24ECsjcxL5FuwohrRHJ9/WWce2EK6+0Vzg55NARCXrgmyKdSvZVSxFl8TXbCw3ImDDYoN0TYag7fd84mpclNr6OnmGhCJm0BL+Xfp9FgPg1TCgq3Prj5aEZUSAbfUGWVv9uZVGX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:46.9638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 202b819c-6801-4397-093b-08defd6677b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
Add KUnit tests for handle_hpd_rx_irq() re-detecting a downstream port
change on a non-MST-root connector, amdgpu_dm_hpd_init() skipping a
connector with no dc_link, and dmub_hpd_callback() deferring HPD while
suspended. Also add a writeback connector to the HPD registration test.

[HOW]
The downstream-change test reuses dm_test_setup_hpd_rx_irq() and clears
the MST root state, with dc_link_detect() stubbed to fail. The suspend
test leaves adev->dm.ddev NULL, so reaching the connector walk would
crash.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index c335ac0e2a6f5..4f22230a5520e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -197,6 +197,18 @@ static bool dm_test_handle_hpd_rx_link_loss(struct dc_link *link,
 	return false;
 }
 
+static bool dm_test_handle_hpd_rx_result_true(struct dc_link *link,
+					      union hpd_irq_data *hpd_irq_data,
+					      bool *link_loss,
+					      bool defer_handling,
+					      bool *has_left_work)
+{
+	*link_loss = false;
+	*has_left_work = false;
+
+	return true;
+}
+
 static bool dm_test_allow_hpd_rx_irq_true(const struct dc_link *link)
 {
 	return true;
@@ -2165,6 +2177,35 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 	amdgpu_dm_hpd_fini(adev);
 }
 
+/**
+ * dm_test_hpd_init_skips_connector_without_link - Test HPD init skips linkless
+ * @test: The KUnit test context
+ *
+ * A connector that does not carry a dc_link yet must be skipped by the init
+ * loop. Only init is exercised: fini has no such guard.
+ */
+static void dm_test_hpd_init_skips_connector_without_link(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	adev->mode_info.num_hpd = 0;
+
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
+						 &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_DisplayPort), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_connector_cleanup,
+							&aconn->base), 0);
+
+	amdgpu_dm_hpd_init(adev);
+
+	/* Skipped before the analog check, so polling was never requested. */
+	KUNIT_EXPECT_FALSE(test, adev->ddev.mode_config.poll_enabled);
+}
+
 /* Tests for dm_handle_hpd_rx_offload_work() */
 
 /**
@@ -2953,6 +2994,34 @@ static void dm_test_handle_hpd_rx_irq_link_loss(struct kunit *test)
 				->dm.hpd_rx_offload_wq->is_handling_link_loss);
 }
 
+/**
+ * dm_test_handle_hpd_rx_irq_downstream_change - Test HPDRX post-detect block
+ * @test: The KUnit test context
+ *
+ * A handled HPD RX IRQ on a connector that is not an MST root means a
+ * downstream port status change, so the handler must re-detect the link.
+ * Detection is stubbed to fail, leaving the connector untouched, and a
+ * non-MST-branch link also exercises the trailing CEC IRQ dispatch.
+ */
+static void dm_test_handle_hpd_rx_irq_downstream_change(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_result_true;
+	link_srv->detect_connection_type = dm_test_detect_connection_single;
+	link_srv->detect_link = dm_test_detect_link_false;
+
+	aconn->mst_mgr.mst_state = false;
+	aconn->dc_link->type = dc_connection_single;
+	aconn->fake_enable = true;
+
+	handle_hpd_rx_irq(aconn);
+
+	KUNIT_EXPECT_TRUE(test, aconn->fake_enable);
+}
+
 /* Tests for dmub_hpd_callback()/dmub_hpd_sense_callback() */
 
 /**
@@ -3010,6 +3079,31 @@ static void dm_test_dmub_hpd_callback_empty_connectors(struct kunit *test)
 	dmub_hpd_sense_callback(adev, &notify);
 }
 
+/**
+ * dm_test_dmub_hpd_callback_suspend_skip - Test DMUB HPD skipped in suspend
+ * @test: The KUnit test context
+ *
+ * Plain HPD notifications are deferred while the device is suspended; they get
+ * re-probed on resume, so the callback must return before the connector walk.
+ */
+static void dm_test_dmub_hpd_callback_suspend_skip(struct kunit *test)
+{
+	struct dmub_notification notify = { 0 };
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
+	adev->in_suspend = true;
+	dc->link_count = 1;
+	notify.type = DMUB_NOTIFICATION_HPD;
+
+	/* adev->dm.ddev is left NULL: reaching the connector walk would crash. */
+	dmub_hpd_callback(adev, &notify);
+}
+
 /**
  * dm_test_dmub_hpd_callback_unknown_type_match - Test DMUB callback matched
  *						   connector, unknown type
@@ -3217,10 +3311,15 @@ static void dm_test_register_hpd_handlers_empty(struct kunit *test)
 /**
  * dm_test_register_hpd_handlers_valid - Test HPD/HPDRX registration succeeds
  * @test: The KUnit test context
+ *
+ * A writeback connector must be skipped by the per-connector loop, while a
+ * DisplayPort connector carrying valid HPD and HPD RX sources registers a
+ * low-context handler for each.
  */
 static void dm_test_register_hpd_handlers_valid(struct kunit *test)
 {
 	struct amdgpu_dm_connector *aconn;
+	struct drm_connector *wbconn;
 	struct amdgpu_device *adev;
 	struct dc_link *link;
 	struct dc *dc;
@@ -3231,6 +3330,13 @@ static void dm_test_register_hpd_handlers_valid(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
 	adev->dm.dc = dc;
 
+	wbconn = kunit_kzalloc(test, sizeof(*wbconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wbconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wbconn, &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, wbconn), 0);
+
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
@@ -4395,6 +4501,7 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_hpd_init_fini_with_connectors),
 	KUNIT_CASE(dm_test_hpd_init_fini_analog_connector),
 	KUNIT_CASE(dm_test_hpd_init_fini_irq_ref),
+	KUNIT_CASE(dm_test_hpd_init_skips_connector_without_link),
 	/* dm_handle_hpd_rx_offload_work */
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connector),
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connection),
@@ -4416,11 +4523,13 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_automated_test),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_msg_rdy),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_link_loss),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_downstream_change),
 	KUNIT_CASE(dm_test_schedule_hpd_rx_offload_work),
 	/* dmub_hpd_callback/dmub_hpd_sense_callback */
 	KUNIT_CASE(dm_test_dmub_hpd_callback_null_inputs),
 	KUNIT_CASE(dm_test_dmub_hpd_callback_invalid_index),
 	KUNIT_CASE(dm_test_dmub_hpd_callback_empty_connectors),
+	KUNIT_CASE(dm_test_dmub_hpd_callback_suspend_skip),
 	KUNIT_CASE(dm_test_dmub_hpd_callback_unknown_type_match),
 	KUNIT_CASE(dm_test_dmub_hpd_callback_hpd_type),
 	KUNIT_CASE(dm_test_dmub_hpd_callback_hpd_irq_type),
-- 
2.43.0


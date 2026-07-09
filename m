Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45352C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF0710F6E6;
	Thu,  9 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lumpVtmF";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCDB10F6DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZKqW5kmoivUF/gNokV20r/rSQMgrHhTZ5HS7fPm4wAqS1sGBYCDDU6USeXG4Y2+4BphOEs1Z2rq59fWSM0zNsPZVZJTYTFl9cNJVJ0ilcX7YiXe65Ft33t4ywJW8u7Bkv4cMiXeIvC6KfXSprBST5CKmiwD/ZPL9Fh27Hb+zQ84p2my0qRgRicAb3HbiliQXI/tqE1txxkw9BvSsjOpxrobvw/IN05n1zat7rwWW6+N9p1I7Jabm82qPihZtLyy0tZgjQ/5jn9WicI2KFBq8ov1wJPN36lq/TyuhHmjUOd45L95uV+WSHNtRTa6wF5FJnfZi5VH4oC4R2pH8Mr3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdRtxv0YqdV2xZXP0jFuwbPUWpnCLbK6NcYWvQ4WrEg=;
 b=IHyr60O5vKzKOS869bu8A7JO1OKNB2z0OFWasbx5FUSKC7UtL0TkXT+6i4cl1Le400btEg0uf+osdvyAsZc4HZactuPcDb3yebZxEyi/TsanmRpjERSkkdKqPEi+QuIspjIAy8eI7VC8xhc+sXAKGiIMimeAp/rSgriIf929dnMJ9Unu/2Z8e4003IVhvC5ObnvfdA2Vc9hnxdICdEeHeY5ruyRLswC5KHhK+4aqiwrCGOgm6mgpd+XvTU0oa5lprgYfpuJqE42PE+Nrh4Bdfjm2rk1byFd0E13Bs3DGAYLP80IZv4/Ut1S8RkKzpCHnf+445mDpiBSvWFnm/KIoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdRtxv0YqdV2xZXP0jFuwbPUWpnCLbK6NcYWvQ4WrEg=;
 b=lumpVtmFWNaRoCLpoPxA1HmkPAFnc5JePKOOJBhB0RqYI6IOleFEgalQfGhAJ3CF+p9Mj9QUOYUaS0eq3hy1LItfws5OU7alQj2L0nWllHNeGcJBMPpQMcgTNoIAEafBwBxhzxXZT7zWRRCOm9IsCV4Ik/DNWalhYZZCTDZ0Ueo=
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:21 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::34) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:20 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:00 -0500
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
Subject: [PATCH 32/80] drm/amd/display: Test HPD init/fini
Date: Thu, 9 Jul 2026 16:48:00 -0400
Message-ID: <20260709205936.5719-33-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 909af6d9-357b-489d-6806-08deddfd5e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: AoQ/62ovIPLKlMc0wnFJbc/4+Yrrx5l8nkGWTGHzZrW1/j99XkBV24SN/ebKmzz1H4VNADGFf5c7d9zrdvQQUT8tsQql28ZT41+6Kl9aa4PbcOIFpsCx2n3CThVQdHX+uuM07D19JI7qFAe9xBHV0Abh+z4nYUoXAgbG5+aMB8Y9q5q9/wISQXB5ak7S1IwMnurKS+Y0udmZZwlGIpdNEmrc3JXOxbeUHJ5cIir2NTfVdrYWWSAgrjsC3fcEhjaffXZOP048gLh4u9RfHYxp7xT1zOZbWEkWju1CxMZyt/xI4bltjlEEmWn+fNkWGZEVroSmXZOxijTQ2e3rxZsbQcPO83Yxon8uIZUzJZIL4bJhCvW73LTxs6Nt78zyxVm5g0Gdojy27ExJ7cWQR4Eg3W7ei1Oim+74Jk4M+gGM0cekjbVx31msHkpOkFrSmBDpOMjHAgKRcYPYBF688ueRfbN0kaOy1HULI8onajLcVuhNfoPg8pdDP5P5+/KrmAysDVqLXZK8maGeSEKySsDcdqGMl5RJJNpb7M0RXe/syrFEq7Vr4wGwOhzQ1PoBeghoOyzmWdMVgUfKQ2dzkmfAZ03F75B9PLCZ/E20k0KI1oC8qV0eivYSnLqhkD9jjHBgxG4bSxB933h2z8snTDENxSVooqWQ03JxFiwhVFGtsWhayAVP4mXTnnyqUNxAvCcoN7ZZzPca4fCIbMNeuXAsYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m1NJGLI8wt4EOJQB3TNqqBDI+/Xd89bs4zUTiqIEc+QRF3aGT6xjtDF2Ee2HNVXw+4aD8zes5esAMnIgC0r0b/aQ4A4h6szqkl/fmQxFlRBUZPIHnlSG4l4ZWxa9BoejPVAMTYxC/ImflV3YGPKQTwwK858hFQvcy8Yfdu10sralhoboCdh75JzJdzkZdz1RihyC7MCWjG7hNTz0vt0ie0YA+NdTVCBObgm89g/RggEdZNZ75a0DpxpC61tDJ0f3sg0NoQHOoTJfKwArHkxAL0W87PDY/D5XzAfxWUA4hvcJsVaY1qRgJw7pILC6a1c/cgvZmqRdwAzE6edaf5UGLSZQUZ8eProqLUiAoz+NaBLoQ07HYyaQ+LKQ3gb5gF6EJMWvLR+r4s/DwR/7kf5v/DS6sCnGmObHW2g2R3IEclvvF0fOEEizffFLCkKCTHeM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:20.9736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909af6d9-357b-489d-6806-08deddfd5e35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

Add KUnit coverage for amdgpu_dm_hpd_init() and amdgpu_dm_hpd_fini():
empty connector list, the per-connector HW fallback path, the analog
polling enable/disable path, and the base-driver irq-ref path. Export
both functions for KUnit and add shared drm_connector test helpers.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 187 +++++++++++++++++-
 2 files changed, 183 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5af7f0bebdb8..8e18ed9f9501 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1003,6 +1003,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	if (use_polling)
 		drm_kms_helper_poll_init(dev);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_hpd_init);

 /**
  * amdgpu_dm_hpd_fini - hpd tear down callback.
@@ -1056,6 +1057,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	if (dev->mode_config.poll_enabled)
 		drm_kms_helper_poll_fini(dev);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_hpd_fini);

 /* ========== HPD handling ========== */
 static void force_connector_state(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 7537d30cd983..8c58523ef1bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -154,6 +154,19 @@ static void dm_test_destroy_hpd_rx_wq(void *data)
 	kfree(ctx->wq);
 }

+static const struct drm_connector_funcs dm_test_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+};
+
+static void dm_test_connector_cleanup(void *data)
+{
+	drm_connector_cleanup(data);
+}
+
 /* Tests for amdgpu_dm_hpd_to_dal_irq_source() */

 /**
@@ -917,11 +930,9 @@ static void dm_test_get_crtc_by_otg_inst_returns_match(struct kunit *test)
 	acrtc_b->otg_inst = 3;

 	list_add_tail(&acrtc_a->base.head, &drm->mode_config.crtc_list);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del,
-							acrtc_a), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del, acrtc_a), 0);
 	list_add_tail(&acrtc_b->base.head, &drm->mode_config.crtc_list);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del,
-							acrtc_b), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del, acrtc_b), 0);

 	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_crtc_by_otg_inst(adev, 3), acrtc_b);
 }
@@ -946,8 +957,7 @@ static void dm_test_get_crtc_by_otg_inst_returns_null(struct kunit *test)
 	acrtc->otg_inst = 2;

 	list_add_tail(&acrtc->base.head, &drm->mode_config.crtc_list);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del,
-							acrtc), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_crtc_list_del, acrtc), 0);

 	KUNIT_EXPECT_NULL(test, amdgpu_dm_get_crtc_by_otg_inst(adev, 5));
 }
@@ -1733,6 +1743,165 @@ static void dm_test_outbox_init_null_dc(struct kunit *test)
 	amdgpu_dm_outbox_init(adev);
 }

+/* Tests for amdgpu_dm_hpd_init()/amdgpu_dm_hpd_fini() */
+
+/**
+ * dm_test_hpd_init_empty_connectors - Test HPD init with no connectors
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_init_empty_connectors(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	/*
+	 * With an empty connector list the per-connector loop is skipped and
+	 * the initial clear loop relies on dc_interrupt_set() being a no-op
+	 * for a NULL dc, so init must complete without touching the DC.
+	 */
+	amdgpu_dm_hpd_init(adev);
+}
+
+/**
+ * dm_test_hpd_fini_empty_connectors - Test HPD fini with no connectors
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_fini_empty_connectors(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	/* Empty connector list and disabled polling: fini is a safe no-op. */
+	amdgpu_dm_hpd_fini(adev);
+}
+
+/**
+ * dm_test_hpd_init_fini_with_connectors - Test HPD init/fini walk connectors
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct drm_connector *wbconn;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	/*
+	 * num_hpd = 0 forces irq_type >= num_hpd so the loop takes the HW
+	 * fallback (dc_interrupt_set()) instead of amdgpu_irq_get(); with a
+	 * NULL dc that fallback is a safe no-op.
+	 */
+	adev->mode_info.num_hpd = 0;
+
+	/* A writeback connector must be skipped by the per-connector loop. */
+	wbconn = kunit_kzalloc(test, sizeof(*wbconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wbconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wbconn, &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, wbconn), 0);
+
+	/* A DisplayPort connector with a dc_link exercises the loop body. */
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
+						 &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_DisplayPort), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
+	aconn->dc_link = link;
+
+	/* DC is absent (NULL), so the HW writes are NULL-safe no-ops. */
+	amdgpu_dm_hpd_init(adev);
+	amdgpu_dm_hpd_fini(adev);
+}
+
+/**
+ * dm_test_hpd_init_fini_analog_connector - Test HPD init/fini analog polling path
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_init_fini_analog_connector(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	adev->mode_info.num_hpd = 0;
+
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
+						 &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_VGA), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
+	/* An analog connector id makes the loop request polling. */
+	link->link_id.id = CONNECTOR_ID_VGA;
+	aconn->dc_link = link;
+
+	/* use_polling becomes true, so init must enable KMS polling. */
+	amdgpu_dm_hpd_init(adev);
+	KUNIT_EXPECT_TRUE(test, adev->ddev.mode_config.poll_enabled);
+
+	/* fini must tear the polling back down. */
+	amdgpu_dm_hpd_fini(adev);
+	KUNIT_EXPECT_FALSE(test, adev->ddev.mode_config.poll_enabled);
+}
+
+/**
+ * dm_test_hpd_init_fini_irq_ref - Test HPD init/fini base-driver irq ref path
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	/*
+	 * num_hpd >= 1 makes irq_type (0) < num_hpd, so the loop takes the
+	 * amdgpu_irq_get()/amdgpu_irq_put() branch instead of the
+	 * dc_interrupt_set() fallback. The mock device has irq.installed ==
+	 * false, so both calls fail early with -ENOENT (logging an error)
+	 * without touching the base-driver irq state.
+	 */
+	adev->mode_info.num_hpd = 1;
+
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
+						 &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_DisplayPort), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
+	aconn->dc_link = link;
+
+	amdgpu_dm_hpd_init(adev);
+	amdgpu_dm_hpd_fini(adev);
+}
+
 static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_to_dal_irq_source */
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
@@ -1829,6 +1998,12 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_set_dmub_trace_irq_state_null_dc),
 	/* amdgpu_dm_outbox_init */
 	KUNIT_CASE(dm_test_outbox_init_null_dc),
+	/* amdgpu_dm_hpd_init/amdgpu_dm_hpd_fini */
+	KUNIT_CASE(dm_test_hpd_init_empty_connectors),
+	KUNIT_CASE(dm_test_hpd_fini_empty_connectors),
+	KUNIT_CASE(dm_test_hpd_init_fini_with_connectors),
+	KUNIT_CASE(dm_test_hpd_init_fini_analog_connector),
+	KUNIT_CASE(dm_test_hpd_init_fini_irq_ref),
 	{}
 };

--
2.55.0


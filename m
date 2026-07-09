Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40879C44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE1AC10F6E4;
	Thu,  9 Jul 2026 21:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMv94Ws4";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D1810F6E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISYceN9cbGgxiV4ySaJeWouRZNC5mgzqxVufi88LNrQYmS1YM8cVhIOlUnp+h0U9LEJ1LHmQYsaZkUOc3rGW3QSzbv3Yd3CLX6q1LtloHcrPqwGRHs7Ydj7snbUZrRtsOWGhmKSZffUQ9QH9H+NWI1lnPxqXBXAK29FMkZp1DMI1q3svjJ4NZLU4OiZuzSR8/24GsR2j22P4+Bv173Hout0z0kMd2AP4n8VJUTHixMEw4swvPHo0E5whUmr7pECqoaAIiMR1B8wjuzggUHpaipWBvV245co4M5lp4rF72E+pb/wFp43hx28P87mQM0HITMSnHjDG0M5ND0pT8G57zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXU9B+Xy3ZLPIkg18XvWI9B7gS4QOGnfHb/HydIjJ1w=;
 b=Oix9EpTOklo2cwvRD/SI9TaP9mqZdjq6gdiBsZN0WikVVpZfwLjEX/IBLDiLHZa+C4EgW6ArckFrvrGtQTl6QzsasHxSDFMsuAW/Op24ANEa9y/eqoF/3A37k2rJiLGN10uTHhUO3YnTfLb8XVMGr21ZUY/DhV5IAAWW3sRcyER6X5u5a6txvocLCrtgUhwRWW5WaWkpXbYz7u+SpbTigLga+SgNRB8wlWdFqkEdsHNzwxVW3viZqsoEByk9uuh00f3WL9nJZJWwXIsGH1zscTYceyhjNnUZrPLXTZXsjid4JmjR/QRZ08BCi3HjGa1xWBmKCc/M73U9bC/CTPsf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXU9B+Xy3ZLPIkg18XvWI9B7gS4QOGnfHb/HydIjJ1w=;
 b=hMv94Ws4wHIOgb5dFUyOJsj8Ev8fCZXNoVGfpKSa79N3xUfYRcP//FHZJ03gkBic8DLjOg707Jnsnhsrqd/a9zxN3KygqRyKbPopMhuLirBa8z8SXCfWy/WM/fNzdF83DuJzF8cFggf2ZqJ7bGO48cXvV/V7nkuxtysn7CEUIk0=
Received: from MN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:52d::13)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:22 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::7) by MN0PR04CA0002.outlook.office365.com
 (2603:10b6:208:52d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:22 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:01 -0500
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
Subject: [PATCH 34/80] drm/amd/display: Test dmub HPD callbacks and handlers
Date: Thu, 9 Jul 2026 16:48:02 -0400
Message-ID: <20260709205936.5719-35-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7ce591-9fa7-4081-7093-08deddfd5ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: CnWl9ltiSMLQMshX56MpvEncJppQbI5py4a92Y5q84pdGlrzPaGSVdGFaLheYoFp3ST77mPKKSESrlLnz2CjniDAyuLmxu6m7hTaOe0X09uZVoAQKG9YXBN2xH4NTYYZEtclZuACa9p8gkhs4anSYIUAbqY2mewVWHsokqc8UjDkM9PihdTT9JGdhv11rezRchCoUaHD70TuTJ7MVudehAXoqyMkaNwVY6GR4TEzE8C+nn/TbZDjIWqgEhDvKdLb1NUeTcUC/Hpiw5TjZ/jg6psy/2nQpIOWCvXXZjZneHgSyIkV13cyylS7cxKm6kBIQDRwQtgopWvlcpac+KIKbNuKd0j6GCX7vDLM5yee/pzS0muzagnLdJtijNXylwci7u9U7dC0nAsizyohSGBem/c36m9CXGe0ttBS80hf6omtOXbqUoS/cglWj9SCXi+QTmVgiBBtR5f7Lc55EfCsrlpnmweANkb2V1E+iirvjYFF6/YJ5VZ/5091IJ8ngGtGmGDkOcoo+veJeIaQ8vq/CpIqsT9LwG393mJDazFsNF7cLwMSkjagcYXIMd5daSfXdZC7S04TRaHUPQKtlIN4LpMD8XOu6wvv3dGqZRNjcHqrpdnCRXHDXS7FUZMxg+4u9rPhPMok7tJBRuoSfLiE3gkQwdAq2HNFRp1uw5XW2H3ctJ9XXqArvCZeSzvcXsnMz8T8PW7Bi9TdsfbXS7CrIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sCdNA4nGaWnJEsdoPEwBt0NKIFnlxU+U09Uue5TVcf+grgFN4xwHwrIgIhKp7HNmgtvHjCUFm1siCohZFlsqC/HfsFgh8VY92gnAUIaxQYAYN4+In4SY7In5iSzqT+264o18D4hVlUgKoLr1FGDJy1ogQrw3gTgO9FjYwIUVuSeM6knZMyHYsJe8T/bvCLrJC2Zje/ae45NYQ4E29Pm1uZ/v83B2hZIUMu7fuavisuy+CmPoOtMPtYH3gNqMeAx3SO1vwR7qtLEaATbL2epU5nlLTlMXHbmCNEYufj5Ms+1lpp6mPZVu9iPDKBJ7Tqu7MLSzud90LVtzB6zGRhobJKhKB3IXx5S+Qu6pnFJkcEwt0H6C3j8qBQCdvtRqHS0I07hRVX3Ra+NzJcmwLc/MbukkM7lhbX/Se0hulYmp2215VlBHL5WoN5xz/Het6TQd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:22.0211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7ce591-9fa7-4081-7093-08deddfd5ed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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
Add KUnit tests for the DMUB HPD notification callbacks
(dmub_hpd_callback, dmub_hpd_sense_callback) and for
amdgpu_dm_register_hpd_handlers().

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 418 ++++++++++++++++++
 3 files changed, 427 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index c169f891470a..e34bd3bbc2b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1585,7 +1585,7 @@ EXPORT_IF_KUNIT(handle_hpd_rx_irq);
  * Dmub Hpd interrupt processing callback. Gets displayindex through the
  * ink index and calls helper to do the processing.
  */
-static void dmub_hpd_callback(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void dmub_hpd_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
 	struct amdgpu_dm_connector *aconnector;
@@ -1651,6 +1651,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		}
 	}
 }
+EXPORT_IF_KUNIT(dmub_hpd_callback);

 /**
  * dmub_hpd_sense_callback - DMUB HPD sense processing callback.
@@ -1660,11 +1661,12 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
  * HPD sense changes can occur during low power states and need to be
  * notified from firmware to driver.
  */
-static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void dmub_hpd_sense_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
 	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
 }
+EXPORT_IF_KUNIT(dmub_hpd_sense_callback);

 int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
 {
@@ -1742,6 +1744,7 @@ int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
 	}
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_register_hpd_handlers);

 /* ========== IRQ handlers ========== */
 struct amdgpu_crtc *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index e01b0856f91f..7200d3754905 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -169,6 +169,10 @@ void schedule_hpd_rx_offload_work(struct amdgpu_device *adev,
 				  struct hpd_rx_irq_offload_work_queue *offload_wq,
 				  union hpd_irq_data hpd_irq_data);
 void handle_hpd_rx_irq(void *param);
+void dmub_hpd_callback(struct amdgpu_device *adev,
+		       struct dmub_notification *notify);
+void dmub_hpd_sense_callback(struct amdgpu_device *adev,
+			     struct dmub_notification *notify);
 #endif

 #endif /* __AMDGPU_DM_IRQ_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index fa161d0ecfd9..eb74883cb6d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -2812,6 +2812,411 @@ static void dm_test_handle_hpd_rx_irq_link_loss(struct kunit *test)
 				->dm.hpd_rx_offload_wq->is_handling_link_loss);
 }

+/* Tests for dmub_hpd_callback()/dmub_hpd_sense_callback() */
+
+/**
+ * dm_test_dmub_hpd_callback_null_inputs - Test DMUB callback null inputs
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_hpd_callback_null_inputs(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	dmub_hpd_callback(NULL, NULL);
+	dmub_hpd_callback(adev, NULL);
+}
+
+/**
+ * dm_test_dmub_hpd_callback_invalid_index - Test DMUB callback index check
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_hpd_callback_invalid_index(struct kunit *test)
+{
+	struct dmub_notification notify = { 0 };
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
+	notify.link_index = 1;
+
+	dmub_hpd_callback(adev, &notify);
+}
+
+/**
+ * dm_test_dmub_hpd_callback_empty_connectors - Test DMUB callback without match
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_hpd_callback_empty_connectors(struct kunit *test)
+{
+	struct dmub_notification notify = { 0 };
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
+	adev->dm.ddev = &adev->ddev;
+	dc->link_count = 1;
+	notify.type = DMUB_NOTIFICATION_HPD_SENSE_NOTIFY;
+
+	dmub_hpd_callback(adev, &notify);
+	dmub_hpd_sense_callback(adev, &notify);
+}
+
+/**
+ * dm_test_dmub_hpd_callback_unknown_type_match - Test DMUB callback matched
+ *						   connector, unknown type
+ * @test: The KUnit test context
+ *
+ * A writeback connector must be skipped (continue) and a non-writeback
+ * connector whose dc_link matches the notification link must be selected.
+ * An unrecognized notification type takes the "unknown" warn branch, and the
+ * post-loop dispatch is a no-op (neither HPD nor HPD_IRQ), so no real DC/MST
+ * handler runs.
+ */
+static void dm_test_dmub_hpd_callback_unknown_type_match(struct kunit *test)
+{
+	struct dmub_notification notify = { 0 };
+	struct amdgpu_dm_connector *aconn;
+	struct drm_connector *wbconn;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
+	adev->dm.ddev = &adev->ddev;
+	dc->link_count = 1;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	dc->links[0] = link;
+
+	/* A writeback connector must be skipped by the loop. */
+	wbconn = kunit_kzalloc(test, sizeof(*wbconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wbconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wbconn, &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_connector_cleanup, wbconn), 0);
+
+	/* A DisplayPort connector whose dc_link matches drives the match branch. */
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
+						 &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_DisplayPort), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
+	aconn->dc_link = link;
+
+	notify.link_index = 0;
+	notify.type = DMUB_NOTIFICATION_HPD_SENSE_NOTIFY;
+
+	dmub_hpd_callback(adev, &notify);
+}
+
+/**
+ * dm_test_dmub_hpd_callback_hpd_type - Test DMUB callback HPD type dispatch
+ * @test: The KUnit test context
+ *
+ * A matched connector with notification type DMUB_NOTIFICATION_HPD logs the
+ * HPD callback and dispatches to handle_hpd_irq_helper(). Detection is stubbed
+ * to report no connection and link detect to fail, so the connected branches
+ * are skipped and no real DC/DRM hotplug path runs.
+ */
+static void dm_test_dmub_hpd_callback_hpd_type(struct kunit *test)
+{
+	struct dmub_notification notify = { 0 };
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link_srv->detect_connection_type = dm_test_detect_connection_none;
+	link_srv->detect_link = dm_test_detect_link_false;
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+
+	adev->dm.dc = dc;
+	adev->dm.ddev = &adev->ddev;
+	dc->link_count = 1;
+	dc->links[0] = link;
+
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
+						 &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_DisplayPort), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
+	mutex_init(&aconn->hpd_lock);
+	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
+			  amdgpu_dm_hdmi_hpd_debounce_work);
+	aconn->dc_link = link;
+
+	notify.link_index = 0;
+	notify.type = DMUB_NOTIFICATION_HPD;
+
+	dmub_hpd_callback(adev, &notify);
+}
+
+/**
+ * dm_test_dmub_hpd_callback_hpd_irq_type - Test DMUB callback HPD_IRQ dispatch
+ * @test: The KUnit test context
+ *
+ * A matched connector with notification type DMUB_NOTIFICATION_HPD_IRQ logs
+ * the HPD RX callback and dispatches to handle_hpd_rx_irq(). The HPD RX handler
+ * stub reports no left work, so the function returns through the early goto
+ * without scheduling offload work; an MST-branch link skips the trailing
+ * drm_dp_cec_irq().
+ */
+static void dm_test_dmub_hpd_callback_hpd_irq_type(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
+	struct dmub_notification notify = { 0 };
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+
+	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	spin_lock_init(&offload_wq->offload_lock);
+	adev->dm.hpd_rx_offload_wq = offload_wq;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_no_work;
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	link->link_index = 0;
+	link->type = dc_connection_mst_branch;
+
+	adev->dm.dc = dc;
+	adev->dm.ddev = &adev->ddev;
+	dc->link_count = 1;
+	dc->links[0] = link;
+
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
+						 &dm_test_connector_funcs,
+						 DRM_MODE_CONNECTOR_DisplayPort), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
+	mutex_init(&aconn->hpd_lock);
+	aconn->mst_mgr.mst_state = true;
+	aconn->dc_link = link;
+
+	notify.link_index = 0;
+	notify.type = DMUB_NOTIFICATION_HPD_IRQ;
+
+	dmub_hpd_callback(adev, &notify);
+}
+
+/* Tests for amdgpu_dm_register_hpd_handlers() */
+
+/**
+ * dm_test_register_hpd_handlers_empty - Test HPD registration with no connectors
+ * @test: The KUnit test context
+ */
+static void dm_test_register_hpd_handlers_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_hpd_handlers(adev), 0);
+}
+
+/**
+ * dm_test_register_hpd_handlers_valid - Test HPD/HPDRX registration succeeds
+ * @test: The KUnit test context
+ */
+static void dm_test_register_hpd_handlers_valid(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
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
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
+	aconn->dc_link = link;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_hpd_handlers(adev), 0);
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1]));
+	KUNIT_EXPECT_FALSE(test,
+			   list_empty(&adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_HPD1RX]));
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_register_hpd_handlers_invalid_hpd - Test invalid HPD source fails
+ * @test: The KUnit test context
+ */
+static void dm_test_register_hpd_handlers_invalid_hpd(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
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
+	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1RX;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
+	aconn->dc_link = link;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_hpd_handlers(adev), -EINVAL);
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_register_hpd_handlers_invalid_hpd_rx - Test invalid HPDRX source fails
+ * @test: The KUnit test context
+ */
+static void dm_test_register_hpd_handlers_invalid_hpd_rx(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
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
+	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1;
+	aconn->dc_link = link;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_hpd_handlers(adev), -EINVAL);
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_register_hpd_handlers_dmub_outbox - Test DMUB outbox callbacks register
+ * @test: The KUnit test context
+ *
+ * Enables DMUB outbox support so dc_is_dmub_outbox_supported() returns true,
+ * exercising the dm_register_dmub_notify_callback() block. Asserts that the
+ * HPD, HPD_IRQ and HPD_SENSE_NOTIFY callbacks are registered.
+ */
+static void dm_test_register_hpd_handlers_dmub_outbox(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+	dc = dm_test_alloc_dc_with_ctx(test);
+	adev->dm.dc = dc;
+
+	/* Make dc_is_dmub_outbox_supported() return true. */
+	dc->caps.dmcub_support = true;
+	dc->ctx->asic_id.chip_family = AMDGPU_FAMILY_GC_11_0_1;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_hpd_handlers(adev), 0);
+	KUNIT_EXPECT_PTR_EQ(test, adev->dm.dmub_callback[DMUB_NOTIFICATION_HPD],
+			    (dmub_notify_interrupt_callback_t)dmub_hpd_callback);
+	KUNIT_EXPECT_PTR_EQ(test, adev->dm.dmub_callback[DMUB_NOTIFICATION_HPD_IRQ],
+			    (dmub_notify_interrupt_callback_t)dmub_hpd_callback);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    adev->dm.dmub_callback[DMUB_NOTIFICATION_HPD_SENSE_NOTIFY],
+			    (dmub_notify_interrupt_callback_t)dmub_hpd_sense_callback);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_to_dal_irq_source */
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
@@ -2934,6 +3339,19 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_msg_rdy),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_link_loss),
 	KUNIT_CASE(dm_test_schedule_hpd_rx_offload_work),
+	/* dmub_hpd_callback/dmub_hpd_sense_callback */
+	KUNIT_CASE(dm_test_dmub_hpd_callback_null_inputs),
+	KUNIT_CASE(dm_test_dmub_hpd_callback_invalid_index),
+	KUNIT_CASE(dm_test_dmub_hpd_callback_empty_connectors),
+	KUNIT_CASE(dm_test_dmub_hpd_callback_unknown_type_match),
+	KUNIT_CASE(dm_test_dmub_hpd_callback_hpd_type),
+	KUNIT_CASE(dm_test_dmub_hpd_callback_hpd_irq_type),
+	/* amdgpu_dm_register_hpd_handlers */
+	KUNIT_CASE(dm_test_register_hpd_handlers_empty),
+	KUNIT_CASE(dm_test_register_hpd_handlers_valid),
+	KUNIT_CASE(dm_test_register_hpd_handlers_invalid_hpd),
+	KUNIT_CASE(dm_test_register_hpd_handlers_invalid_hpd_rx),
+	KUNIT_CASE(dm_test_register_hpd_handlers_dmub_outbox),
 	{}
 };

--
2.55.0


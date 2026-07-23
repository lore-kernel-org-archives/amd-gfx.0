Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EF7C531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551E210F1C2;
	Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z3LqTOrK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C728D10F1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVc7S5NWf8FtU621qgD7Po0RT4blIv+5sjHScQ3EP4J2pffkNG4GPB/aKDTB9hko877KR+Oe8X1mnOYJrWc44ioGaxpPmNfMsMrRal4W+Sd3RgIFEMXp38H1YKyNPPhg5yPgO5XNBD1aJg/4Bfxe1ZnKbJcSYIhVmFZLPDLkAFfMNQVEUvpvidEUZK6tvFmRqrhtGMB0Fh4kDQ3672elTo5oDKcKv1aPEhdJSYoquIDZ/fpUJnm3K7t+B4JaKg2667ERmyxMFNhYN21rX83+jDBuykBrTUvcOBRlZGb7RYNA+7H+CclMl22CJoo+udulFTuT1xtVIle58iHRMQkhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLFQHWj5wDQFLmjflagvkwXaehg9FuleQXFKwb3FETg=;
 b=ImMfk9ngLO7+64ZTv5iMLA4RKczp4IRYo9xL0jGvEcXjaDb20Vfkt+GA4YCBmQuSgZFu+hZc04oaN0nB6wYeLqZDNBMREd7MJimfUuVXuWgfyEUDsO8bJBvq6E6gtOE2Tifj36DffComT4fB81Sj/B2o/NoVirbjb2k5ddxDt03cTWeyKbGcQVOuoWLUUePu66wZL9lqWtS5rrNKamTnzaiR4LZH2iFQx3o6XAgLnfYE0xl1MU3bGVBYYPDajJFwQ4KldGc5YYxIbXrJcXNK004q6b/lGewiyBviLcpROYAkt/M8WXUwe7wODv5sD7DA1hjEX0Pd7fOzYTpEcDhVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLFQHWj5wDQFLmjflagvkwXaehg9FuleQXFKwb3FETg=;
 b=Z3LqTOrK68K8QfeTKPUmsmLIkF1JURMkm/QGJmlU1Q5t7jVcfVzHhNW7YYnx0vOOja3IYnhBTrpuQIg+Z7e5l/cBwifLuNeeF4T9lS9ihtQYyCP0L5RK964PVkIPGTU1H2n+jNheL8wcwFVqBcmyL3X3yp1X5PRRg+5Z/tfDt/s=
Received: from MN0P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::33)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:18:54 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::a5) by MN0P223CA0030.outlook.office365.com
 (2603:10b6:208:52b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:54 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:51 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 05/49] drm/amd/display: Add KUnit tests for HDCP display
 helpers
Date: Thu, 23 Jul 2026 16:13:13 -0400
Message-ID: <20260723201908.373300-6-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 0983e8bc-3028-4a2d-58e2-08dee8f79e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: Gb8RcSK4wIrAYBQwUfwi1fW5eEyPqQIbA/DxdXBGlbWZC+bIdALdNTULRzRfhirBMg04sUhAoOCG4mhSUO2/Znz69uekscPMjdmE+Zl3A9xDoa9adiJ9NK9cfgGW2fT9VUJDm1WTzjAmMyd8AFYUBd66/n+p74+++DG8Lqk3PCPHsx0Ze44yRO6f5EDYwdxDOid5a826zuHc099tO+UEb1fD44uPgEUzjnNOW4kIvTDtj10N10p2UBr/tQ7BBrlv3HCFGVGqD5AR8toF1mOuObgK42yny6N8c7xOplCaqaN8X7e5se/EGxpH86Ufvll9rdjWq9uhdvSTBwzdK2+sKlKciaDKxFIGZ0X6sbad30sxJWXIJO/0U710vdj9TP5R5Gb0JrH+ZKMDav9fr0PwM4pSXBSuZe+sbQl/oCEjIp9h3yEkjnlt264Jkh6ivRRlm+18M82Bk437iO92nMv4shb+zLIQigUSEi0Rt0rDJTxBx0b67KEvE0nN+6C+6kqRSupaLdpsCgIHjb5ZIFK0P9/q8VrMwscwfSoZLl5ySGJ/ctAOUOq4Jn8ZGedejtNyaBB1lz/8W9BleTAlug0gkV3lMsWrR9LNUXGDMxsHMPu7rANkyiDDnE6GtM11QDVFpC80syc2KiEdwsOR6/pLV4tLxZGYRxrUrA/eHu/3ESJQUKk0ShGk2NdJ/8Xc52Pp8W/jTBeHlBiyWhDJqhV/zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sM90gVkgjoaDxTae7TqxT/8SOd021HdraMhtNXNseDIaV6PtniD6IAsHTg1ENt004ylbz1zr50E4a4wzMDPN2SZmd2EK5GpwgoYIxTmmv59ftPt/hi2kJG539WuDw0g6buOSBv3UwHK1zywx5gJzk4KG5Di2vadIHXU4metC0DG1ogBAhApctulIeMe6YJ0BB6gp6u0+2HgwfpEwoEYoS2kMn8fKhAqMhzYSMukT6H142AkNywJUNCZTV9452oz4kKmkPDCD0qPxJnhzZvea6NhccMQMyE1LtvsUeeI6Qu5+8GQLQXyTPdFRT4pfAXKt1g4lt9O6U0yH2E+sHxBcuevcWE4yfvV1LUwF780LakZMP1OdbT7fKbMJI2ev4KpuekA9Bp3sRLy0Xs1UXNTqmzcEDI4aj09NKaXKVxJgkSiKE6IxXJl1l6CE2TUIrumd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:54.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0983e8bc-3028-4a2d-58e2-08dee8f79e48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046
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

Cover the HDCP display lifecycle helpers:
- hdcp_update_display() registers the connector and, on the
  disable path, resets the per-link encryption status to
  HDCP_OFF.
- hdcp_remove_display() reverts an ENABLED connector back to
  DESIRED and clears the per-link entry, including the NULL
  connector-state path.
- hdcp_reset_display() clears the encryption status and the
  connector for every link.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 207 ++++++++++++++++++
 3 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 3b5e0e64adde..f786c0a85425 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -317,8 +317,10 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 
 	process_output(hdcp_w);
 }
+EXPORT_IF_KUNIT(hdcp_update_display);
 
-static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
+STATIC_IFN_KUNIT
+void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 				unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector)
 {
@@ -348,6 +350,7 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	}
 	process_output(hdcp_w);
 }
+EXPORT_IF_KUNIT(hdcp_remove_display);
 
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
@@ -371,6 +374,7 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 
 	process_output(hdcp_w);
 }
+EXPORT_IF_KUNIT(hdcp_reset_display);
 
 void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index fb66f48d7297..69a50e081c56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -115,6 +115,8 @@ void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 					    bool enable_encryption);
 void event_property_update(struct work_struct *work);
 void link_lock(struct hdcp_workqueue *work, bool lock);
+void hdcp_remove_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index,
+			 struct amdgpu_dm_connector *aconnector);
 uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size);
 int psp_set_srm(struct psp_context *psp, u8 *srm, uint32_t srm_size, uint32_t *srm_version);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index 43c7efcdd22c..e6d03199187b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -9,6 +9,7 @@
 #include <linux/workqueue.h>
 
 #include "amdgpu.h"
+#include "amdgpu_dm.h"
 #include "amdgpu_dm_hdcp.h"
 
 static void dummy_work_fn(struct work_struct *work) {}
@@ -753,6 +754,206 @@ static void dm_test_psp_set_srm_uninitialized_returns_einval(struct kunit *test)
 
 /* End of tests for psp_get_srm() and psp_set_srm() */
 
+/*
+ * Tests for hdcp_update_display() / hdcp_remove_display() /
+ * hdcp_reset_display().
+ */
+
+/**
+ * alloc_test_workqueue_locked - workqueue with dworks and mutex initialised
+ * @test: KUnit test context for managed allocation
+ *
+ * Allocates a minimal hdcp_workqueue with its mutex and the three delayed
+ * works initialised, as required by the guard(mutex) and process_output()
+ * usage in the display update/remove/reset helpers.
+ */
+static struct hdcp_workqueue *alloc_test_workqueue_locked(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	mutex_init(&work->mutex);
+	INIT_DELAYED_WORK(&work->callback_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->watchdog_timer_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->property_validate_dwork, dummy_work_fn);
+
+	return work;
+}
+
+/**
+ * alloc_test_connector - minimal amdgpu_dm_connector for display tests
+ * @test: KUnit test context for managed allocation
+ * @index: drm connector index to assign
+ *
+ * Allocates an amdgpu_dm_connector with an initialised connector refcount
+ * (so drm_connector_get() is valid) and a dc_link/dc pair. The connector's
+ * free_cb is left NULL so drm_connector_put() is a safe no-op that never
+ * releases the object.
+ */
+static struct amdgpu_dm_connector *alloc_test_connector(struct kunit *test,
+							unsigned int index)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *dc_link;
+	struct dc *dc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	dc_link = kunit_kzalloc(test, sizeof(*dc_link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_link);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	kref_init(&aconnector->base.base.refcount);
+	aconnector->base.index = index;
+	dc_link->dc = dc;
+	aconnector->dc_link = dc_link;
+
+	return aconnector;
+}
+
+/**
+ * dm_test_hdcp_update_display_enable_registers_connector - enable stores the connector
+ * @test: KUnit test context
+ *
+ * hdcp_update_display() with enable_encryption=true should register the
+ * connector in the per-link aconnector array at its connector index. The
+ * hdcp has no active display, so mod_hdcp_update_display() is effectively a
+ * no-op and the call must not touch encryption_status.
+ */
+static void dm_test_hdcp_update_display_enable_registers_connector(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 0);
+
+	work->srm_size = 0;
+
+	hdcp_update_display(work, 0, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, true);
+
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[0], aconnector);
+	KUNIT_EXPECT_EQ(test, work->encryption_status[0],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+}
+
+/**
+ * dm_test_hdcp_update_display_disable_sets_status_off - disable clears status
+ * @test: KUnit test context
+ *
+ * hdcp_update_display() with enable_encryption=false should register the
+ * connector and reset the connector's encryption_status entry to HDCP_OFF
+ * via hdcp_update_display_encryption_control().
+ */
+static void dm_test_hdcp_update_display_disable_sets_status_off(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 2);
+
+	work->encryption_status[2] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	hdcp_update_display(work, 0, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
+
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[2], aconnector);
+	KUNIT_EXPECT_EQ(test, work->encryption_status[2],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+}
+
+/**
+ * dm_test_hdcp_remove_display_enabled_resets_cp - ENABLED CP reverts to DESIRED
+ * @test: KUnit test context
+ *
+ * hdcp_remove_display() must revert a connector whose content_protection is
+ * ENABLED back to DESIRED and clear the per-link aconnector entry.
+ */
+static void dm_test_hdcp_remove_display_enabled_resets_cp(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 1);
+	struct drm_connector_state *conn_state;
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	aconnector->base.state = conn_state;
+	work->aconnector[1] = aconnector;
+
+	hdcp_remove_display(work, 0, aconnector);
+
+	KUNIT_EXPECT_EQ(test, conn_state->content_protection,
+			DRM_MODE_CONTENT_PROTECTION_DESIRED);
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[1], NULL);
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+}
+
+/**
+ * dm_test_hdcp_remove_display_null_state_clears_connector - NULL state skips CP change
+ * @test: KUnit test context
+ *
+ * When the connector has no drm_connector_state, hdcp_remove_display() must
+ * skip the content_protection update path and still clear the per-link
+ * aconnector entry.
+ */
+static void dm_test_hdcp_remove_display_null_state_clears_connector(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 0);
+
+	aconnector->base.state = NULL;
+	work->aconnector[0] = aconnector;
+
+	hdcp_remove_display(work, 0, aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[0], NULL);
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+}
+
+/**
+ * dm_test_hdcp_reset_display_clears_all_state - reset clears status and connectors
+ * @test: KUnit test context
+ *
+ * hdcp_reset_display() must reset every connector's encryption_status to
+ * HDCP_OFF and clear all per-link aconnector entries.
+ */
+static void dm_test_hdcp_reset_display_clears_all_state(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_locked(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 4);
+
+	work->encryption_status[4] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+	work->aconnector[4] = aconnector;
+
+	hdcp_reset_display(work, 0);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[4],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+	KUNIT_EXPECT_PTR_EQ(test, work->aconnector[4], NULL);
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+}
+
+/*
+ * End of tests for hdcp_update_display() / hdcp_remove_display() /
+ * hdcp_reset_display().
+ */
+
 static struct kunit_case dm_hdcp_test_cases[] = {
 	/* hdcp_get_content_protection_from_status() */
 	KUNIT_CASE(dm_test_hdcp_get_cp_disabled_returns_desired),
@@ -790,6 +991,12 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	/* psp_get_srm() / psp_set_srm() */
 	KUNIT_CASE(dm_test_psp_get_srm_uninitialized_returns_null),
 	KUNIT_CASE(dm_test_psp_set_srm_uninitialized_returns_einval),
+	/* hdcp_update_display() / hdcp_remove_display() / hdcp_reset_display() */
+	KUNIT_CASE(dm_test_hdcp_update_display_enable_registers_connector),
+	KUNIT_CASE(dm_test_hdcp_update_display_disable_sets_status_off),
+	KUNIT_CASE(dm_test_hdcp_remove_display_enabled_resets_cp),
+	KUNIT_CASE(dm_test_hdcp_remove_display_null_state_clears_connector),
+	KUNIT_CASE(dm_test_hdcp_reset_display_clears_all_state),
 	{}
 };
 
-- 
2.53.0


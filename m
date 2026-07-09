Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF1AC4450B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E495510F6EF;
	Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fJhgl4d0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433A110F6E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud9+kIhFHMJ+VZNdss3vIDAn8gwo5GKtiVodaKXdwo7O79N2YWceO2fCVpRCs5lLnevaq/hxUbEsC4J/xu7POauBrthVOBE86vtsIMXq7IQKr8CSjPh6zq6vjMJipRqrgqvHBnfRYfjmzq7zquOIc0Z1e8T+Hxs9UR3LjihE8MAfXhyJ4O1QFBLt/ukgxZ+T4S0vrRCdHyKVfNAHlPLOJ+BeBHwBibicnY359XvZTGDSGWqfcWiqowTrKVawLHD3mI9MG9/aoTHP+hMzdiKq7ABOCuonnrw30pR4Xm9uhtTcYdquOOhegRmorRAQ8xz0WpMS3+Kf4v3VXQLKW9Yztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBQnPlL7k9J1XJaeaNzY45Qk80U83EjpxsjxoqymMXU=;
 b=bMKPupvHmaJawbZyObIvm7M68VI+9I0UjVvoH/w/eVXYRhNxMnqJHw60bID+z6Y/VJwTyAMgpBdo4JZH+EK9hbKXAubvm6vOfFSvx0WD+VQY9mHOljT3SSLITLt1SAGwlBC6P35GWPjLsdLO+t9rAOdPCyLWRTzFMNp4St50d8MTjwCkdH9iZfm/lazDa0rafQ0GYx2+VMLdl7I27ZyBtr0myooG+R/xu8N8W22FnvWO5QxX+1ObT19PJj+77+DZHl0jzZLS3jEVd3AypyC6PD5Eil+gLuVW7tLpbcK/RPb7mMFKWJm5rKOJmv63h3Y5WFGFac2OhV7bRxcqnF5EXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBQnPlL7k9J1XJaeaNzY45Qk80U83EjpxsjxoqymMXU=;
 b=fJhgl4d0nXxBwXjHoanVDpkloIfO9iFS8/9sDTw9WcK4mFfXTZiBbMFgnNSj9g7Bgh/LCNpgmeVxgbpsl8UAkRIWcUYsFxxDP39aEuZnAJjh7qcJx9/nmqh08aEwHKKRr01N27UZee7PGFJlEMQqkcKN6jpHUsV9HL3syXGDDjM=
Received: from BL1P223CA0032.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::15)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 21:02:19 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::92) by BL1P223CA0032.outlook.office365.com
 (2603:10b6:208:5b6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:19 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:58 -0500
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
Subject: [PATCH 30/80] drm/amd/display: Test irq funcs/suspend/workqueue
Date: Thu, 9 Jul 2026 16:47:58 -0400
Message-ID: <20260709205936.5719-31-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 247f6e1a-c259-4501-6b91-08deddfd5d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: pm29A9wVlPVc3DwMTN0rbqycjm/CdRtos2s8tqKOxIElbqO8HjsHt8uQqicSIsGhNmNLrooPr2aRvIhRicyBy3WZTsuQ6HUGVnLwXPiYU1qd/6vRxBigrHaDcsyIwLfsZ6dKG6Hinx5W1baOY92W36q0w7it5/H7479WCTKsTCiplWkKklxZmP/OmprI7V3F1HcODOmYUS4EC+iUaR3rWQvi1dPg1tbgndTjVhwXLV2c47oe1ecYmVtaf4FSh9nssUN6stzRwVl+2IYbBqnH+L47K0fnP1o7qtBXhS5oBIvUajBo00wklNaemBo3MkCHgVi6crJ7EM0aaskL5Fwx3XjorL05cDI3EuW8xlF61XJH3PPJ3uv8lq/uZcTmNwMCHRLEY7EGwbkLNf0F11h/ehHQb0bWZe6oyAbJRBDLMsGaaZzTlY6/fMlgd1ZupoPJRCkB751872gp6+p60mkM2ZWAkqHsYTfJn8kreC/POafz/dYgBfVSShKnlsJSqJBNuo+53YVvW70dvkuj8ivoSqkq3TbNzOsHtlJwa8vZJAmcp2KQIHn+yKDPfm93dZso+M2GEbcwFmKJL1sohneWyawTbDMz73/BaiaMi5NVXGGgslKlm1OdOjTR+6CISsvcxQGv+eFA49k0aQuBkgWD3mjpU1JZa3FfvHCan7Aj7ZHVtY02d4iUMVNKzWQRC1xJURr6G+vyN64d9flPaYnOPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PtciNzWj6aHhHKZvHmQz2YZdq1k341IY4QIu0qH9uhHgTTBh5m78e+K8AY8czjNeHqQhE38HCrGh8pswApTP0uVNl5oP3p+k0bDEm9bGpu17Z3ybb1zTmtuuTqT0/+UIKWdA8+sHFyXe6B21+UR1EhFme2hqlG1ZS6QbbC5LDfV8LQSOJRWjwhvDgnNZrcY3Pgz6pbT0SIauBnODS++9yDRi71O7axGUbs4Kdk1qhrGHYVzb730AjKolnaMBW3OuhM2vhyhcq54E+xQh7hT8kSyND5speJqPg1kOovzeil3xGxYsYbKXx1Q7/Z0MqQHuIlUoeMhWvgr2mmPZFP4sSA4HbZPWCg6By0CWoVh0/tJd8UkqO7ByhshrRu5gOrpm1c/1IPEI43wYj7VCYJDx6XN1PTCwWpZWH9bsxbor2+CgUuN0HPgywv6Bumf4CIPO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:19.7616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247f6e1a-c259-4501-6b91-08deddfd5d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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
Expand the amdgpu_dm_irq KUnit suite with the first batch of tests
covering IRQ source-function setup, suspend/resume of the IRQ
clients, and the HPD RX offload workqueue lifecycle.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   7 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 353 ++++++++++++++++++
 2 files changed, 360 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index c5467f34c51f..ee74b212aebf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -537,6 +537,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	if (dev->mode_config.poll_enabled)
 		drm_kms_helper_poll_disable(dev);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_suspend);

 void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 {
@@ -558,6 +559,7 @@ void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)

 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_resume_early);

 void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 {
@@ -586,6 +588,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 	if (dev->mode_config.poll_enabled)
 		drm_kms_helper_poll_enable(dev);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_irq_resume_late);

 /*
  * amdgpu_dm_irq_schedule_work - schedule all work items registered for the
@@ -900,6 +903,8 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 	adev->hpd_irq.num_types = adev->mode_info.num_hpd;
 	adev->hpd_irq.funcs = &dm_hpd_irq_funcs;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_irq_funcs);
+
 void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
 {
 	dc_interrupt_set(adev->dm.dc,
@@ -1187,6 +1192,7 @@ struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(stru
 	kfree(hpd_rx_offload_wq);
 	return NULL;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_create_workqueue);

 void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 {
@@ -1197,6 +1203,7 @@ void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 			flush_workqueue(dm->hpd_rx_offload_wq[i].wq);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_work_suspend);

 STATIC_IFN_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index a73a6dd146d6..7ea6f93ca998 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -7,14 +7,23 @@

 #include <kunit/test.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_probe_helper.h>

 #include "dc.h"
+#include "inc/core_types.h"
+#include "irq/irq_service.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
+#include "dc_dmub_srv.h"
+#include "ivsrcid/ivsrcid_vislands30.h"
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+#include "link_service.h"
 #include "dmub/dmub_srv.h"
+#include "dal_asic_id.h"

 static void dm_test_irq_handler(void *arg)
 {
@@ -31,6 +40,22 @@ static void dm_test_crtc_list_del(void *data)
 	list_del_init(&acrtc->base.head);
 }

+struct dm_test_hpd_rx_wq_ctx {
+	struct hpd_rx_irq_offload_work_queue *wq;
+	int count;
+};
+
+static void dm_test_destroy_hpd_rx_wq(void *data)
+{
+	struct dm_test_hpd_rx_wq_ctx *ctx = data;
+	int i;
+
+	for (i = 0; i < ctx->count; i++)
+		if (ctx->wq[i].wq)
+			destroy_workqueue(ctx->wq[i].wq);
+	kfree(ctx->wq);
+}
+
 /* Tests for amdgpu_dm_hpd_to_dal_irq_source() */

 /**
@@ -842,6 +867,318 @@ static void dm_test_get_crtc_by_otg_inst_empty_list(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, amdgpu_dm_get_crtc_by_otg_inst(adev, 0));
 }

+/* Tests for amdgpu_dm_set_irq_funcs() */
+
+/**
+ * dm_test_set_irq_funcs - Test irq src funcs and counts are populated
+ * @test: The KUnit test context
+ */
+static void dm_test_set_irq_funcs(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->mode_info.num_crtc = 6;
+	adev->mode_info.num_hpd = 4;
+
+	amdgpu_dm_set_irq_funcs(adev);
+
+	KUNIT_EXPECT_EQ(test, adev->crtc_irq.num_types, 6);
+	KUNIT_EXPECT_EQ(test, adev->vline0_irq.num_types, 6);
+	KUNIT_EXPECT_EQ(test, adev->vupdate_irq.num_types, 6);
+	KUNIT_EXPECT_EQ(test, adev->pageflip_irq.num_types, 6);
+	KUNIT_EXPECT_EQ(test, adev->dmub_outbox_irq.num_types, 1);
+	KUNIT_EXPECT_EQ(test, adev->dmub_trace_irq.num_types, 1);
+	KUNIT_EXPECT_EQ(test, adev->hpd_irq.num_types, 4);
+
+	KUNIT_EXPECT_TRUE(test, adev->crtc_irq.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, adev->vline0_irq.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, adev->dmub_outbox_irq.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, adev->vupdate_irq.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, adev->dmub_trace_irq.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, adev->pageflip_irq.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, adev->hpd_irq.funcs != NULL);
+}
+
+/* Tests for amdgpu_dm_irq_suspend()/resume_early()/resume_late() */
+
+/**
+ * dm_test_irq_suspend_empty - Test suspend walks empty handler tables safely
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_suspend_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	int src;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	/*
+	 * With no registered handlers the HW dc_interrupt_set() calls are
+	 * skipped, so suspend must complete without touching the (absent) DC.
+	 */
+	amdgpu_dm_irq_suspend(adev);
+
+	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
+		KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.irq_handler_list_low_tab[src]));
+		KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.irq_handler_list_high_tab[src]));
+	}
+}
+
+/**
+ * dm_test_irq_resume_early_empty - Test early resume walks empty tables safely
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_resume_early_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	int src;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	amdgpu_dm_irq_resume_early(adev);
+
+	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++)
+		KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.irq_handler_list_high_tab[src]));
+}
+
+/**
+ * dm_test_irq_resume_late_empty - Test late resume walks empty tables safely
+ * @test: The KUnit test context
+ */
+static void dm_test_irq_resume_late_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	int src;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	amdgpu_dm_irq_resume_late(adev);
+
+	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++)
+		KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.irq_handler_list_low_tab[src]));
+}
+
+/**
+ * dm_test_irq_suspend_registered - Test suspend reaches the dc_interrupt_set path
+ * @test: The KUnit test context
+ *
+ * Registers a low-context HPD handler so the handler list is non-empty,
+ * forcing amdgpu_dm_irq_suspend() to call dc_interrupt_set() (NULL-safe with
+ * no DC) and flush_work() on the registered handler.
+ */
+static void dm_test_irq_suspend_registered(struct kunit *test)
+{
+	struct dc_interrupt_params int_params = { 0 };
+	struct amdgpu_device *adev;
+	void *handler;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	amdgpu_dm_irq_suspend(adev);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+					   dm_test_irq_handler);
+}
+
+/**
+ * dm_test_irq_suspend_disables_polling - Test suspend disables KMS polling
+ * @test: The KUnit test context
+ *
+ * With KMS polling active, suspend must take the poll-disable branch.
+ * drm_kms_helper_poll_disable() only cancels the poll work; it leaves the
+ * poll_enabled flag set (cleared later by drm_kms_helper_poll_fini()).
+ */
+static void dm_test_irq_suspend_disables_polling(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	/* Enable KMS polling so suspend takes the poll-disable branch. */
+	drm_kms_helper_poll_init(&adev->ddev);
+	KUNIT_ASSERT_TRUE(test, adev->ddev.mode_config.poll_enabled);
+
+	amdgpu_dm_irq_suspend(adev);
+
+	KUNIT_EXPECT_TRUE(test, adev->ddev.mode_config.poll_enabled);
+
+	drm_kms_helper_poll_fini(&adev->ddev);
+}
+
+/**
+ * dm_test_irq_resume_early_registered - Test early resume reaches dc_interrupt_set
+ * @test: The KUnit test context
+ *
+ * Registers a low-context HPD RX handler so early resume calls
+ * dc_interrupt_set() for the short-pulse interrupt source.
+ */
+static void dm_test_irq_resume_early_registered(struct kunit *test)
+{
+	struct dc_interrupt_params int_params = { 0 };
+	struct amdgpu_device *adev;
+	void *handler;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1RX;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	amdgpu_dm_irq_resume_early(adev);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1RX,
+					   dm_test_irq_handler);
+}
+
+/**
+ * dm_test_irq_resume_late_registered - Test late resume reaches dc_interrupt_set
+ * @test: The KUnit test context
+ *
+ * Registers a low-context HPD handler so late resume calls dc_interrupt_set()
+ * for the HPD interrupt source.
+ */
+static void dm_test_irq_resume_late_registered(struct kunit *test)
+{
+	struct dc_interrupt_params int_params = { 0 };
+	struct amdgpu_device *adev;
+	void *handler;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
+	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
+	handler = amdgpu_dm_irq_register_interrupt(adev, &int_params,
+						   dm_test_irq_handler, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, handler);
+
+	amdgpu_dm_irq_resume_late(adev);
+
+	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
+					   dm_test_irq_handler);
+}
+
+/**
+ * dm_test_irq_resume_late_enables_polling - Test late resume re-enables polling
+ * @test: The KUnit test context
+ *
+ * With KMS polling active, late resume must take the poll-enable branch and
+ * leave polling enabled.
+ */
+static void dm_test_irq_resume_late_enables_polling(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	/* Enable KMS polling so resume_late takes the poll-enable branch. */
+	drm_kms_helper_poll_init(&adev->ddev);
+	KUNIT_ASSERT_TRUE(test, adev->ddev.mode_config.poll_enabled);
+
+	amdgpu_dm_irq_resume_late(adev);
+
+	KUNIT_EXPECT_TRUE(test, adev->ddev.mode_config.poll_enabled);
+
+	drm_kms_helper_poll_fini(&adev->ddev);
+}
+
+/* Tests for amdgpu_dm_hpd_rx_irq_create_workqueue() */
+
+/**
+ * dm_test_hpd_rx_irq_create_workqueue - Test workqueue array creation
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_rx_irq_create_workqueue(struct kunit *test)
+{
+	struct dm_test_hpd_rx_wq_ctx *ctx;
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	int i;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	dc->caps.max_links = 4;
+	adev->dm.dc = dc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->wq = amdgpu_dm_hpd_rx_irq_create_workqueue(adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->wq);
+	ctx->count = dc->caps.max_links;
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_destroy_hpd_rx_wq, ctx), 0);
+
+	for (i = 0; i < dc->caps.max_links; i++)
+		KUNIT_EXPECT_TRUE(test, ctx->wq[i].wq != NULL);
+}
+
+/* Tests for amdgpu_dm_hpd_rx_irq_work_suspend() */
+
+/**
+ * dm_test_hpd_rx_irq_work_suspend_null - Test suspend with no work queue
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_rx_irq_work_suspend_null(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+
+	/* A NULL hpd_rx_offload_wq must be a safe no-op (DC untouched). */
+	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
+}
+
+/**
+ * dm_test_hpd_rx_irq_work_suspend_flushes - Test suspend flushes queues
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_rx_irq_work_suspend_flushes(struct kunit *test)
+{
+	struct dm_test_hpd_rx_wq_ctx *ctx;
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	dc->caps.max_links = 2;
+	adev->dm.dc = dc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->wq = amdgpu_dm_hpd_rx_irq_create_workqueue(adev);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->wq);
+	ctx->count = dc->caps.max_links;
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_destroy_hpd_rx_wq, ctx), 0);
+
+	adev->dm.hpd_rx_offload_wq = ctx->wq;
+
+	amdgpu_dm_hpd_rx_irq_work_suspend(&adev->dm);
+}
+
 static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_to_dal_irq_source */
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
@@ -894,6 +1231,22 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_returns_match),
 	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_returns_null),
 	KUNIT_CASE(dm_test_get_crtc_by_otg_inst_empty_list),
+	/* amdgpu_dm_set_irq_funcs */
+	KUNIT_CASE(dm_test_set_irq_funcs),
+	/* amdgpu_dm_irq_suspend/resume_early/resume_late */
+	KUNIT_CASE(dm_test_irq_suspend_empty),
+	KUNIT_CASE(dm_test_irq_resume_early_empty),
+	KUNIT_CASE(dm_test_irq_resume_late_empty),
+	KUNIT_CASE(dm_test_irq_suspend_registered),
+	KUNIT_CASE(dm_test_irq_suspend_disables_polling),
+	KUNIT_CASE(dm_test_irq_resume_early_registered),
+	KUNIT_CASE(dm_test_irq_resume_late_registered),
+	KUNIT_CASE(dm_test_irq_resume_late_enables_polling),
+	/* amdgpu_dm_hpd_rx_irq_create_workqueue */
+	KUNIT_CASE(dm_test_hpd_rx_irq_create_workqueue),
+	/* amdgpu_dm_hpd_rx_irq_work_suspend */
+	KUNIT_CASE(dm_test_hpd_rx_irq_work_suspend_null),
+	KUNIT_CASE(dm_test_hpd_rx_irq_work_suspend_flushes),
 	{}
 };

--
2.55.0


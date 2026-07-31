Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DAAC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49ABE10F3FD;
	Fri, 31 Jul 2026 21:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Olo9BLzF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9A810F40F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQl2qvyWx1t9l6zHhDiQs95/8imV/VDCkXFCxeReqizeEqVg2pxbRutc+FeM687BGxZ3kUcOjgdV/IG3l+FwsYfzqkwqtKqJDxWoQjWFMgyL/oUJxBnFsvhAnE0/ScPhAgOr6yMzIZZL4g4RB79mV2ODpFPv5L1Zo3CU1VwDK3YFNZnsQeYUxwYzXHm1Ge2/jn52zfUtjqZevqNirGNmA63qXL7rBubNtY6huqJgIQMlHNVOzvFlf5iBRrSshKKhl1+8C0YkiKWveullUX9fqaLhieVnUl3SMiJ/HMnrhciLXB8iG5oESFwRrvmQYLd+uQd+R5E+KbMp3enzcnjnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNQlhA9JCFpmQ1mi7PlULEz9mt47FfSyNVdO2krneLg=;
 b=WlZyRbfU0t4wamFGns55h0LDAYW0AIxOTyjZsi0kWi/K5pNirx1J7EsB0/KS9pVZYQTEQhuRSpvKcJ261jKAHRA40evrZHT8J/cOsq977H1N00WCfGHcroy+jA27mWQjy9efC9bW6En3fxobKXxl0krCYu9mGU2B0ePznowt0LFe3EOAjPFB0Qu7GHRqbRWNitnQWKORMoZxbcDy/QRBRSSn2M6VANMphYzGRgvXZcMW0xPnzHV3xDcsuBfqIACU442askzT01RzaI0islig5RfebpL+HX2Pv2bGn5B478MlXnUhTIjQq6bU6PQ0AoV9NjTIPOfr76JHbJQr8fHImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNQlhA9JCFpmQ1mi7PlULEz9mt47FfSyNVdO2krneLg=;
 b=Olo9BLzFIjYdJmonQSTBzRmcwuk/a4ImTozYIxKlmrGIUb+oZtYmmUFAYpR5zZgxpx2zO13lrjjjLHgJBvJQx+51kmv8/jiBk2PtUnGW9ch3XaUR5LQUzGU10PaZ8BfjNUS72vtWAilviRxpXFZG3/YGi94ntu981nvjqf7gMOA=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:48 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::2b) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Fri,
 31 Jul 2026 21:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:47 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:46 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 19/41] drm/amd/display: Add KUnit tests for crtc
 set_vupdate_irq
Date: Fri, 31 Jul 2026 17:12:40 -0400
Message-ID: <20260731211302.3040343-20-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c168a4-e1bb-44ae-dc42-08deef48e43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NeeKsU6dDjhkQNbGN7WtxNQ6j0m6PwzgB5gjf+dniL9UHdj1g9loPKPb6WPHKgD27uIFPzxlpIQrm7Kw2xyVycTKob2UhiYyyAc0BIrZKbtxUQh44rrK6CahFPd7kej7HgW8Qm9UOPZrpYH056+C/ISsMRqFEKzp9EsW6pFN3HEXTPpmey92UhPWMdZic4K9QUIjT8muZIdfZvkNLUpKdWJTMZBRlklhL5v9r3SX6+J4/MH+OUR0xw0LPMXPO2HL1/6ZEdk/8VpPsuwfPp0LMUwNU5i+sEq5qDLBhwOTV4iwHcb+fvzfhVKJrPVIgGWW5EKk1huAYFkNVCVTmyYhYve1//fYGwHtE/ufbq7AovQRIlx3d7CF1JkA+vBVDeiMClLNPC8htKAyakW7JYElUce+8C4UabHhdUeDthZzA9d2WsUydQD6Mg4dsGfjMPhx+XnOPvDAdaWkINQzHx9/D2yrv3Xd/KjRep1jc0r3+YwKtIfcLxeR5xBaULHOZOh5u0ydbdGU0itCfN1JYWDqRUp//dQOlx8xkvzoyad7wGOfFbNjpu7RP92LwIq6wlIHXDuL9fLMViNuBBS75i4XqEP2Dlc1ltr2DbHctCWtxXZU0Ai66AdTzh5A0FyvIUcgHXrmquhZHhKvbNscB+jYQCL5c0Wp6rn86uSe4yzwo+S7xGhtgnq3sXLikQ5pBCYIxNl8w1yU/TFBOVDw6d6zYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n3km73A1LkJ8yH5pfnT8tJkplbE5edd/IhS+4yxKPhjUjP6Ahx6+7m5Sfrg95ISzwHHZnmhv1OdmRQAqspITz/2+5nIkH//WmQLF212rd4QO01jdkvgFM6rlIbbBkiqMBV8h/n7HQfCw8FAT0/VwOKEA9JH4OhqEEsCL/EXLj6b+mt50tEmG2m00kJavXbmobmsXiOxwfd2l/9m0tAQ1bc6fqaSbD5bgS/z2xZmSdykkon1RX7y0zoa+njYpQRPT8roFT4sbEtofWuZIxt2/PLF8FdJ1qcD2GOwWMHMmNqvIfI6hl55oNBv3yNlwtWqh4E53NaD/gcs52A7Nj8fW9CXeGSDAB27x1ZHxUb2C7DacpmKSzqNDvgPAEjZ6tZQjjAh6qWs60AdBcRJNgkDYRJ09LjusqIQ1+xzQK5uo0NhuROrC1NxEX5CgY9SN3aG2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:47.8686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c168a4-e1bb-44ae-dc42-08deef48e43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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

Add dm_test_crtc_set_vupdate_irq_dc_busy and
dm_test_crtc_set_vupdate_irq_enable to cover the previously untested
paths in amdgpu_dm_crtc_set_vupdate_irq() where an OTG instance is
assigned: dc_interrupt_set() failing (returns -EBUSY) and succeeding
via a mock IRQ service (returns 0 for enable and disable).

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 6bc4f932c839..db98e42c561b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -12,6 +12,8 @@
 #include <drm/drm_vblank.h>
 
 #include "dc.h"
+#include "inc/core_types.h"
+#include "irq/irq_service.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
@@ -430,6 +432,101 @@ static void dm_test_crtc_set_vupdate_irq_no_otg(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false), 0);
 }
 
+/**
+ * dm_test_crtc_set_vupdate_irq_dc_busy - Test vupdate irq when DC rejects request
+ * @test: The KUnit test context
+ *
+ * With an OTG instance assigned but no DC attached, dc_interrupt_set() returns
+ * false and the function must report the request as busy (-EBUSY).
+ */
+static void dm_test_crtc_set_vupdate_irq_dc_busy(struct kunit *test)
+{
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	acrtc->base.dev = &adev->ddev;
+	acrtc->otg_inst = 0;
+
+	/* adev->dm.dc is NULL, so dc_interrupt_set() returns false. */
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true), -EBUSY);
+}
+
+/* Per-source funcs let dc_interrupt_set() succeed without register access. */
+static bool dm_test_vupdate_irq_src_set(struct irq_service *irq_service,
+					const struct irq_source_info *info,
+					bool enable)
+{
+	return true;
+}
+
+static bool dm_test_vupdate_irq_src_ack(struct irq_service *irq_service,
+					const struct irq_source_info *info)
+{
+	return true;
+}
+
+static struct irq_source_info_funcs dm_test_vupdate_irq_src_funcs = {
+	.set = dm_test_vupdate_irq_src_set,
+	.ack = dm_test_vupdate_irq_src_ack,
+};
+
+/**
+ * dm_test_crtc_set_vupdate_irq_enable - Test vupdate irq enable/disable success
+ * @test: The KUnit test context
+ *
+ * With an OTG instance assigned and a DC whose IRQ service accepts the request,
+ * enabling and disabling the vupdate IRQ must both succeed (return 0).
+ */
+static void dm_test_crtc_set_vupdate_irq_enable(struct kunit *test)
+{
+	struct irq_source_info *info;
+	struct resource_pool *res_pool;
+	struct irq_service *irqs;
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	int i;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
+
+	/* Populate the per-source info table so dc_interrupt_set() succeeds. */
+	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
+			     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
+		info[i].funcs = &dm_test_vupdate_irq_src_funcs;
+
+	irqs->info = info;
+	res_pool->irqs = irqs;
+	dc->res_pool = res_pool;
+	adev->dm.dc = dc;
+
+	acrtc->base.dev = &adev->ddev;
+	acrtc->otg_inst = 0;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true), 0);
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false), 0);
+}
+
 /* Tests for idle_create_workqueue() */
 
 /**
@@ -1187,6 +1284,8 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_helper_mode_fixup_returns_true),
 	/* amdgpu_dm_crtc_set_vupdate_irq */
 	KUNIT_CASE(dm_test_crtc_set_vupdate_irq_no_otg),
+	KUNIT_CASE(dm_test_crtc_set_vupdate_irq_dc_busy),
+	KUNIT_CASE(dm_test_crtc_set_vupdate_irq_enable),
 	/* idle_create_workqueue */
 	KUNIT_CASE(dm_test_idle_create_workqueue),
 	/* amdgpu_dm_idle_worker */
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8571BC982D3
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D4010ECB1;
	Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIkxtf6y";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A51010EBD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDn0MQD+5Fxo4zv6FoHf6pYdFDJZ7dj4jbF/FyVj/+zkBwmU995YOPnhd2ZnKnD+VMCesai6sPUMt2JdSUgcPnNW7Gqk2AeSxZJAFOfUW/JOYmKkyOkKwUBYl5RGyqpo8wk4tThQCZRfhpbzxlOuxvX1mYnXQKSt9WoDm3EbGSi8SM+ZqGEQfxFfaCGHiUYC5qajFRiHOReHgGh1NlyZgecTc+++xCzIAbB7FpgMLyqVLVVCRntWHrYx/zzMtRVhBPFh3QvyDnZBYfhB4epoghXsWJjEYuW6IjKW8by+LDPLa0kQy3FydfMk65x97ea6YqegDwCI+nEXHvl+Omiw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEBCuLBOYOhITEaJdNR70qSZNRl8DhA0D+KCFSv8f/Y=;
 b=S5aK6Js9s/Kgm203wV9asyO+Y2RfByPPRHY3PnBcA9sN6nVlA6D3Hy2BlFAPXySHj+nR4vLqVVQ00Db4PjGBha8EzEIlQyAvWkikZ7kh7JDKNGPiw7nlfaDlSyZO+rKs5toH75tw6CfCxjZkvPU1NxkC/H1zuFKQiPpxFD6Kg+uiPeX81lOH+T0YyBvOid9tDJIORw3Br+lP5VPrRcMqEW6/UibYC7inL/JKDGS3Kfnmp5SjAGhKJ6kvaGWRAKl9DDTneRBp3oYxB9UVgcItDlaSH2UaI8wsvvgHkRz/XOrYaXIQbTTGttmmE+UVCc6afNyKMHWjfmP98wnFouLYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEBCuLBOYOhITEaJdNR70qSZNRl8DhA0D+KCFSv8f/Y=;
 b=dIkxtf6yIGtWl6/5iF70l7eMQU9sLYmwDhKCvtHD1ZOkim3eCgXz6r3Dlys5mdjCoRE36RKVOtytNsAfPxDOlX3OcqwLt8AIBsaVT1fH7L1rDPpZIw7KrVuqU4wq8D/2TpiCydQ17SFPMnInxVuX4BFMYmUOQltCGCcGuJf6/o0=
Received: from CH0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:610:e4::31)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:54 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::10) by CH0PR03CA0206.outlook.office365.com
 (2603:10b6:610:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:54 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:40 -0500
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
Subject: [PATCH 35/64] drm/amd/display: Test HPD handler HDCP and detect
Date: Wed, 16 Sep 2026 13:51:50 -0400
Message-ID: <20260916175301.368306-36-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b68470-a9df-4c06-8586-08df141b5586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: giFwA6eiXwxR0xq8EzBhLsKVdJSlRjSzljKB0nptQMbcUIzAmElbrhd2T7LZiFaTUaPADB4WYasX/R4Yl0pyFeoHsxaqRVZt8RrgY7Od21LhVfxqbqSi285xi8UN3Pw0wMRq4S+alJLK/ok5jwewlAU45ND6coNbov59YgqfUd+Jj7gbPbXD7eVMyXN1pIFwCHkzBcLeJC8Jss3HF3mreWeSZNn0RKkKzhvVAYeC3uRfl+Wzlc+EtG/wHMHNhtukWldazOc451dKhJJCw5Yo9padmhTSLaX39JK61FlK2yBh95eBz4EUJvOUHINqmQ28DYNTtBvFlF7BXJ+paTwCXunXhWS+HsT/b42heCn2k/d5qkhJXB40kBhrEeyqpS1e2N13nLOW4GD8oBVcvRzBj9+Vpdl5ajUE8sjFfYPsqcAS9WKPlimHjlLSQa9tuasQXesy99zH0A34PobN1aT4VXlpnXH1fRIKHt78Pfb+MKkEBkHKmgO6sGDNK9dynfcN0tKufOovN/X/VgL9XhbblVrnA2E6AQNB0X860en5wD8q5oBHqq6x9iRSxzRnu+S38IUT2ExvB1OypKwuQJpIsgr3kV2FklhnI2hcFcxjBATxzaReJWNqryESXlCWgGvr0QGccXP/QE5CaN3DQ5ow11CqNrhE9JGA/iwQ7JTfEFmRG/JTwhwUMrLALUqmDM3aPJX5lRwJa/Pjorr9DGp2KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I9PDvKP3JWz7G+k/ntnRRz//Ct/mu7kaDACHaL4tzYzyuaHPUvF0BqR/g3UNBu7B/TbJ0DmPo/gf1zy6SeW6mud5aIRYWq8PaM4hpvqdTzyMq1fr83Lo1/Zazj94RB/2H6o4B4iJH7OzznLrYqVdfUB9hefXMXujZnklyrJj4Y7ZYFn1njdVH+bxrcpCfN1SXwMYUXljXK6bMySicn0X4wbQK/YHES01S8NaWUAOULJPBBi6gRbbwFuK66V2qAJHwrJ15aCzjur5Szqhx2jgfbe6YZDHreLvDAz6JxzR3YhKskCrwGoV2Y3uafJTtutLJcZGb+598Mg4smTF0JQmzm+dWzIxaUoMWZKRR2SwXZuFrr6+9mSDBQuTnUehAP9ILbcZT6F5sjoyEaWw18erk3pqOs9D0XMW4bV0sK/JMkwkp7prKVPh/SmcR6tN8rc+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:54.0889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b68470-a9df-4c06-8586-08df141b5586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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
handle_hpd_irq_helper() never ran its HDCP reset, its forced
connector branch or its successful re-detect branch.

[HOW]
Add a minimal HDCP work queue fixture and three tests: an HPD on
a driver that carries an HDCP work queue, which must reset the display
and flag the connector state; a connector forced on that reports no
connection and is emulated instead of detected; and a successful
re-detect that notifies userspace.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 04cc5dd5812b..5f877c50b120 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -21,6 +21,7 @@
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 #include "dc_dmub_srv.h"
@@ -547,6 +548,39 @@ static void dm_test_register_drm_dev(struct kunit *test, struct amdgpu_device *a
 							&adev->ddev), 0);
 }
 
+static void dm_test_hdcp_dummy_work(struct work_struct *work)
+{
+}
+
+/*
+ * Allocate the minimal hdcp_workqueue that hdcp_reset_display() and
+ * hdcp_handle_cpirq() touch: the per-link mutex, the delayed works
+ * process_output() re-arms, and the CP IRQ work item.
+ */
+static struct hdcp_workqueue *dm_test_alloc_hdcp_workqueue(struct kunit *test)
+{
+	struct hdcp_workqueue *hdcp_work;
+
+	hdcp_work = kunit_kzalloc(test, sizeof(*hdcp_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hdcp_work);
+
+	mutex_init(&hdcp_work->mutex);
+	INIT_WORK(&hdcp_work->cpirq_work, dm_test_hdcp_dummy_work);
+	INIT_DELAYED_WORK(&hdcp_work->callback_dwork, dm_test_hdcp_dummy_work);
+	INIT_DELAYED_WORK(&hdcp_work->watchdog_timer_dwork, dm_test_hdcp_dummy_work);
+	INIT_DELAYED_WORK(&hdcp_work->property_validate_dwork, dm_test_hdcp_dummy_work);
+
+	return hdcp_work;
+}
+
+static void dm_test_flush_hdcp_workqueue(struct hdcp_workqueue *hdcp_work)
+{
+	flush_work(&hdcp_work->cpirq_work);
+	cancel_delayed_work_sync(&hdcp_work->callback_dwork);
+	cancel_delayed_work_sync(&hdcp_work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&hdcp_work->property_validate_dwork);
+}
+
 /* Tests for amdgpu_dm_hpd_to_dal_irq_source() */
 
 /**
@@ -3206,6 +3240,88 @@ static void dm_test_handle_hpd_irq_helper_detect_type_fails(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
 }
 
+/**
+ * dm_test_handle_hpd_irq_helper_hdcp_reset - Test the HDCP reset branch
+ * @test: The KUnit test context
+ *
+ * An HPD invalidates the link's HDCP authentication, so a driver carrying an
+ * HDCP work queue must reset the display and flag the connector state for a
+ * property update.
+ */
+static void dm_test_handle_hpd_irq_helper_hdcp_reset(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct hdcp_workqueue *hdcp_work;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
+	link_srv->detect_link = dm_test_detect_link_false;
+
+	hdcp_work = dm_test_alloc_hdcp_workqueue(test);
+	drm_to_adev(aconn->base.dev)->dm.hdcp_workqueue = hdcp_work;
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+
+	KUNIT_EXPECT_TRUE(test, to_dm_connector_state(aconn->base.state)->update_hdcp);
+
+	dm_test_flush_hdcp_workqueue(hdcp_work);
+}
+
+/**
+ * dm_test_handle_hpd_irq_helper_forced_detect - Test the forced-connector branch
+ * @test: The KUnit test context
+ *
+ * A connector forced on but reporting no connection is emulated rather than
+ * detected, and an HPD RX always notifies userspace. An unset connector signal
+ * keeps amdgpu_dm_emulated_link_detect() to its unsupported-signal early
+ * return.
+ */
+static void dm_test_handle_hpd_irq_helper_forced_detect(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	dm_test_detect_link_count = 0;
+
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
+	dm_test_register_drm_dev(test, drm_to_adev(aconn->base.dev));
+
+	link_srv->detect_link = dm_test_detect_link_false_count;
+	aconn->base.force = DRM_FORCE_ON;
+	aconn->dc_link->ctx->driver_context = drm_to_adev(aconn->base.dev);
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPDRX);
+
+	/* The emulated path replaces detection entirely. */
+	KUNIT_EXPECT_EQ(test, dm_test_detect_link_count, 0);
+}
+
+/**
+ * dm_test_handle_hpd_irq_helper_detect_true - Test the connected detect branch
+ * @test: The KUnit test context
+ *
+ * A successful re-detect refreshes the connector state and notifies userspace.
+ * An MST-state connector keeps amdgpu_dm_update_connector_after_detect() to its
+ * early return.
+ */
+static void dm_test_handle_hpd_irq_helper_detect_true(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
+	dm_test_register_drm_dev(test, drm_to_adev(aconn->base.dev));
+
+	link_srv->detect_connection_type = dm_test_detect_connection_single;
+	link_srv->detect_link = dm_test_detect_link_true;
+	aconn->mst_mgr.mst_state = true;
+	aconn->fake_enable = true;
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+
+	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
+}
+
 /**
  * dm_test_handle_hpd_irq_helper_debounce_pending - Test pending-debounce exit
  * @test: The KUnit test context
@@ -5419,6 +5535,9 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_false),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_type_fails),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_pending),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_hdcp_reset),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_forced_detect),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_true),
 	/* handle_hpd_rx_irq/schedule_hpd_rx_offload_work */
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_disabled),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_no_left_work),
-- 
2.55.0


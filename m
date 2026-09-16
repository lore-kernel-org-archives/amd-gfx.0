Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCBFC88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847BB10ECC2;
	Wed, 16 Sep 2026 17:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gKksDzjX";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB68410ECB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZPcUQu1AXSitP5S0nQMVDHddFeDO2JKvjxyxsV+6BE7+/Kt/6qts93H/QnPWSXKnRxqwYEvaf1b4TDxT1pKcFUj8+1DBOe6Bu1PLJ8ZVDLiYwUXmGRRitHJJom/q7En/LFr5tBa9ZA5RyDyLevWwNsRrj9yQ0pSp1mWqCDsRUSIMittEtSyNUCDndl6vEG6hNJvMwOy4hxmJdJk//fubyJsuN6WI91kt6sRNlgrVvxZEsp6Fyp0DAE+73AL1XTKl7DsT0qFbMVjLjAApxkS88iofPtUEIUdWbgUGCq6VhjYkr3LTr9yzOtzX1IPSYC6X5/u5G7TObeM5qwAmQFQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exv35hetcf5P6MkuQHoDoP9UzxI7JQKNIj3C04jFVD8=;
 b=uy11JRZtTu7Ll9jnbUSr1FkzJnSYWFujyix/bZuPYPFzWOyxqxQkfcleotcAvjcZ/O+EPtEpJQVC2fuBl2StI6nd0bRymq8cI9Ce2v2xxLAHRRxVKkpyHGIpfC7SwmhHtLGYSQjKkJkiTVWONfdK99B/Qjx/aLSGG3XLHwxf6xhwZfxdusPxJVl8h9pwAiyapEW11LHfmC9lEotsEZYc1czeyw58NyfR7wchyn/2ZF6P6iYhw/39VpnDGbs/QVwKSiMaKzCWRjb7zFOgXSyNdzqZOCLbljbo4jlLv3dOhJToNYGQuiPDkFoa2uvGPxd6pBYY0+UYPJdWOTQdGvRWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exv35hetcf5P6MkuQHoDoP9UzxI7JQKNIj3C04jFVD8=;
 b=gKksDzjXQj59z5x7ugV/a7RJ+fS54S2sOyQHN/sLXs2j0nHl6uECaXLjhHvHn7cv43Y9Sy23EfyhLalKIjspDx7ISJr/n4FrprAc/yJf2daKBHLom2OXauv7bQUcAUKqtnXvBIcAJS9W35mmikCiO5kT9A+j9gBAkFFfXRtSbUE=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Wed, 16 Sep
 2026 17:52:53 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::4f) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:53 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:39 -0500
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
Subject: [PATCH 33/64] drm/amd/display: Test HPD RX offload work branches
Date: Wed, 16 Sep 2026 13:51:48 -0400
Message-ID: <20260916175301.368306-34-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 618dea38-947e-4deb-e9cd-08df141b5524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: yQlhJPaXsCWWIe1lrlN9MKpbRrHVzv0o0rOA9zAW+mAw1tf9GTKvd2v4k1xNX26o8eLhfnNv9wLdz7BAAm+McwD38tRvoulcuHWSes0a9pJYQA3GnThZKQHxXCHzM+3ecqRRY3J2ABinUzh9JjZO39BmXe8dxvdWUmPaviaWp/fRHavMP0wS56jR818JNNPZ9rN13PbbrpMWWMA8scE0J2qmaVgmsL0ysLVHXisHKBfgcNO3RgAsyVmSzc9gqYz80t0cPy0MirNcOnaC///RBrhimgvqIPfn5XOxcPh86Rwzy9PBrmBOyGKpaMMzjqauu+s2H4cnvIymljX53MiWgHQZlkfzozsWO7Q2IZhDEq/PA98+0sawZBboXVe87dxaGoFOWSQCNtdm+2Vv8ADkShDhq7PeRtzTwNuiM/gYHnpwduuvQIecfBwTKzDGGI8L0jaUwWIITTAzbx8u9CqHv1F7FRx673QF64gfNk34H/6T0uUaC+hxiJVj7bKB9sQNr/UaVWHRVgsjGRudZXfs0iPNt4Mvn5ylgq0CuplkCHytyID4WsUsgJvZnX5e7TV9IscEufTRSKnEfXTu7IpFPQq675ex9x/ga4pfiDstRCcwulRWWzR1k/SmpoQye71BuanJmlrzPDHhlX6T0y0jK63JzU7xmDZi/ZPzDfGSG5yjGsTeA/OYxi5BEgZ2sMHOFTxPjAmTuvcQqxu05Mb61A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j+On2AXd6/nmcmgF38eaW/I2BZ4GJlf2AWnD3tnr4UMtOeG4jsguWNdwwZ27dp5K7h6fO6gH/rxxixe99yA7scwf0SYwPKDBHB+d83jeHTRPQcjllrbzluS2ya8mxNjETBsVCvmFYoTvJLxwy7EKhrMLnRrzEnYXcSk73cJWaExyu9WY9TcGDdkRkpSzd50jUE9GzeSr/SeoGSmN9i6EcZKb5x695UsXqmavBhx8rH2qgVG+7GSUro1uCninbh2VG3KxGbX0ce7zD88daH86Qwi+9MSnY9ipoGH+rx7TwMW4bmvYzMhkH+HrXvu9y/H4bmcufwkS8MUPGKrBb9+cvdzKyJp4lmkUVDWotHI4h/Uj8BBd5gJeXLJyPoH17VagKB8PE5W7bWZXmFdVZvtEts06sRTjEtmmhte5z2HvoPMSglEQZces/yPV8Qc0NpHL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:53.4507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618dea38-947e-4deb-e9cd-08df141b5524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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
dm_handle_hpd_rx_offload_work() was covered only for its
automated-test and link-loss branches. The connection-type failure, the
GPU-reset drop, the MST message-ready drain and the forced reconnect
were never entered.

[HOW]
Add a fixture that builds a queued offload work item on a
DisplayPort link and four tests: a failing connection-type probe, a
device already in reset, a deferred UP_REQ_MSG_RDY drained through an
AUX that fails every transfer, and an automated test whose timing
changed, which forces the connector off and back on. The last one
registers the DRM device so the hotplug uevent helpers find a sysfs
minor on the primary node.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 6299e1fd2fcc..352ec7773e32 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -6,11 +6,13 @@
  */
 
 #include <kunit/test.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
+#include <drm/display/drm_dp_helper.h>
 
 #include "dc.h"
 #include "inc/core_types.h"
@@ -115,6 +117,18 @@ static enum dc_status dm_test_dp_read_hpd_rx_irq_data_ok(struct dc_link *link,
 	return DC_OK;
 }
 
+static const struct dc_link_status *dm_test_get_link_status(const struct dc_link *link)
+{
+	return &link->link_status;
+}
+
+/* Fail every AUX transaction so the MST ESI read loop bails out immediately. */
+static ssize_t dm_test_aux_transfer_fail(struct drm_dp_aux *aux,
+					 struct drm_dp_aux_msg *msg)
+{
+	return -EIO;
+}
+
 /*
  * Allocate a refcounted dc_sink for tests without pulling in the DC-core
  * dc_sink_create()/dc_sink_release() symbols. Production code under test still
@@ -511,6 +525,22 @@ static void dm_test_connector_cleanup(void *data)
 	drm_connector_cleanup(data);
 }
 
+static void dm_test_drm_dev_unregister(void *data)
+{
+	drm_dev_unregister(data);
+}
+
+/*
+ * Registering the DRM device gives its primary minor a sysfs device, which the
+ * DRM hotplug uevent helpers dereference unconditionally.
+ */
+static void dm_test_register_drm_dev(struct kunit *test, struct amdgpu_device *adev)
+{
+	KUNIT_ASSERT_EQ(test, drm_dev_register(&adev->ddev, 0), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_drm_dev_unregister,
+							&adev->ddev), 0);
+}
+
 /* Tests for amdgpu_dm_hpd_to_dal_irq_source() */
 
 /**
@@ -2412,6 +2442,155 @@ static void dm_test_hpd_rx_offload_work_no_connection(struct kunit *test)
 	dm_handle_hpd_rx_offload_work(&offload_work->work);
 }
 
+/*
+ * Build a queued hpd_rx_irq_offload_work for dm_handle_hpd_rx_offload_work():
+ * an adev that is not in reset, an offload queue owning a connector with an
+ * HPD lock, and a DisplayPort dc/link pair that reports a present sink.
+ * Caller sets the link_srv stubs and the service-IRQ bits its branch needs.
+ *
+ * The work item is kzalloc'd because the worker frees it.
+ */
+static struct hpd_rx_irq_offload_work *
+dm_test_setup_hpd_rx_offload_work(struct kunit *test,
+				  struct link_service **link_srv_out)
+{
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+	adev->reset_domain = kunit_kzalloc(test, sizeof(*adev->reset_domain),
+					   GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->reset_domain);
+
+	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	spin_lock_init(&offload_wq->offload_lock);
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	offload_wq->aconnector = aconn;
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
+	link_srv->detect_connection_type = dm_test_detect_connection_single;
+	dc->link_srv = link_srv;
+	dc->ctx = ctx;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	aconn->dc_link = link;
+
+	offload_work = kzalloc_obj(*offload_work, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
+	offload_work->offload_wq = offload_wq;
+	offload_work->adev = adev;
+	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
+
+	*link_srv_out = link_srv;
+
+	return offload_work;
+}
+
+/**
+ * dm_test_hpd_rx_offload_work_detect_type_fails - Test detect failure logging
+ * @test: The KUnit test context
+ *
+ * When dc_link_detect_connection_type() fails the worker logs an error and
+ * carries on with the connection type left as none, so it still skips out
+ * before any DP IRQ handling.
+ */
+static void dm_test_hpd_rx_offload_work_detect_type_fails(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct link_service *link_srv;
+
+	dm_test_automated_test_count = 0;
+
+	offload_work = dm_test_setup_hpd_rx_offload_work(test, &link_srv);
+	link_srv->detect_connection_type = dm_test_detect_connection_fail;
+	link_srv->dp_handle_automated_test = dm_test_dp_handle_automated_test;
+	offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST = 1;
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+
+	KUNIT_EXPECT_EQ(test, dm_test_automated_test_count, 0);
+}
+
+/**
+ * dm_test_hpd_rx_offload_work_in_reset - Test the GPU-reset early exit
+ * @test: The KUnit test context
+ *
+ * A GPU reset owns the link, so a deferred HPD RX IRQ must be dropped before
+ * any DP IRQ handling runs.
+ */
+static void dm_test_hpd_rx_offload_work_in_reset(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct link_service *link_srv;
+
+	dm_test_automated_test_count = 0;
+
+	offload_work = dm_test_setup_hpd_rx_offload_work(test, &link_srv);
+	link_srv->dp_handle_automated_test = dm_test_dp_handle_automated_test;
+	offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST = 1;
+	atomic_set(&offload_work->adev->reset_domain->in_gpu_reset, 1);
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+
+	KUNIT_EXPECT_EQ(test, dm_test_automated_test_count, 0);
+}
+
+/**
+ * dm_test_hpd_rx_offload_work_msg_rdy - Test the MST message-ready branch
+ * @test: The KUnit test context
+ *
+ * A deferred UP_REQ_MSG_RDY drains the sideband messages and then re-opens the
+ * queue for the next MST message-ready event. The AUX transfers all fail, so
+ * the ESI read loop bails out on its first iteration.
+ */
+static void dm_test_hpd_rx_offload_work_msg_rdy(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct dc_link *link;
+
+	offload_work = dm_test_setup_hpd_rx_offload_work(test, &link_srv);
+	aconn = offload_work->offload_wq->aconnector;
+	link = aconn->dc_link;
+
+	link_srv->get_status = dm_test_get_link_status;
+	link->link_status.dpcd_caps = &link->dpcd_caps;
+
+	mutex_init(&aconn->handle_mst_msg_ready);
+	aconn->dm_dp_aux.aux.name = "dm_irq_test_msg_rdy_aux";
+	aconn->dm_dp_aux.aux.transfer = dm_test_aux_transfer_fail;
+	drm_dp_aux_init(&aconn->dm_dp_aux.aux);
+	drm_dp_dpcd_set_probe(&aconn->dm_dp_aux.aux, false);
+
+	offload_work->offload_wq->is_handling_mst_msg_rdy_event = true;
+	offload_work->data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY = 1;
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+
+	KUNIT_EXPECT_FALSE(test, offload_work->offload_wq->is_handling_mst_msg_rdy_event);
+}
+
 /**
  * dm_test_hpd_rx_offload_work_automated_test - Test AUTOMATED_TEST branch
  * @test: The KUnit test context
@@ -2482,6 +2661,37 @@ static void dm_test_hpd_rx_offload_work_automated_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_test_automated_test_count, 1);
 }
 
+/**
+ * dm_test_hpd_rx_offload_work_timing_changed - Test the forced reconnect path
+ * @test: The KUnit test context
+ *
+ * An automated test that changed the timing must force the connector off and
+ * back on again through force_connector_state(), which sends a hotplug uevent
+ * and therefore needs a registered DRM device.
+ */
+static void dm_test_hpd_rx_offload_work_timing_changed(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	offload_work = dm_test_setup_hpd_rx_offload_work(test, &link_srv);
+	aconn = offload_work->offload_wq->aconnector;
+	dm_test_register_drm_dev(test, offload_work->adev);
+
+	link_srv->dp_handle_automated_test = dm_test_dp_handle_automated_test;
+	aconn->timing_changed = true;
+	aconn->dc_link->aux_access_disabled = true;
+	offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST = 1;
+
+	/* The forced off/on cycle must leave the connector back at its default. */
+	aconn->base.force = DRM_FORCE_ON;
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+
+	KUNIT_EXPECT_EQ(test, aconn->base.force, DRM_FORCE_UNSPECIFIED);
+}
+
 /**
  * dm_test_hpd_rx_offload_work_link_loss - Test link-loss branch
  * @test: The KUnit test context
@@ -5079,7 +5289,11 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* dm_handle_hpd_rx_offload_work */
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connector),
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connection),
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_detect_type_fails),
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_in_reset),
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_msg_rdy),
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_automated_test),
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_timing_changed),
 	KUNIT_CASE(dm_test_hpd_rx_offload_work_link_loss),
 	/* amdgpu_dm_hdmi_hpd_debounce_work */
 	KUNIT_CASE(dm_test_hdmi_hpd_debounce_detect_false),
-- 
2.55.0


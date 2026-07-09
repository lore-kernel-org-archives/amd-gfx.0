Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A100C44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F0010F6DA;
	Thu,  9 Jul 2026 21:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aLPFXwV9";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0B310F6DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+bukGu6rlUIAUx/FgjjVOucLxdk4Mu0lhKpgJvtO1VtK5Ai9wWJGNrjxQ7vJyfK56rPDj6UG1TyMCOBbyZP4djoIXFI/cHnlYMPqo6WUuLrgg8+wsIy26OEFUkmusTvwdygGA+ki2HOE4myX7dqtovcVXgN/VSAcSCIrljokdz97Vetnuazbd1gHG3lWEdK4D0Harp95Q7i3ukSD9F9clv1UzbC1aYp94UEkSL3/zkTUPpQcfgkYhL9Qpg+gYQI/7aJc3BZzavZPJaieDarGhwo3miDdVrbcrQLjxEmG52G3V1iMYqDY1sUd3diDOjW2eTHu1v3/3KlClwA9V+kcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPfYEzuxatWjNmJ32+dMJSEmhwYWrSmicmqf6eZt2Zw=;
 b=BXXJqIK2hm/bpFo+QCLnhPryyDYUhQ9T22VbSIlkPUH6b9QVrPObszewBc4oyx0MB3q0Y1fxI6hi7aai2BT7tiFzHlc7QrQRfxlW/O9tV2CNsiPpWTksSSSzWkB7Oq+w7yFUQyYBiuXO3jYkUwaeg8wOS6DRLrFKeiz8fB+90AY/0wTOROx6URovh/53MZW5a7ibDnZ5fUOSQc/s+TK7ZF28cR4zIwy6ZXwk/r+vc+WxBgIlZAuZALCFBIXn0vdCtxGxTWvud1K4c7wR+xqtHH/NEJ7AepZ/2+YZYIKvf1wh3lCFMn+f+BCFVdFnKEtmndbeeJI6sjhZO9lAUt/1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPfYEzuxatWjNmJ32+dMJSEmhwYWrSmicmqf6eZt2Zw=;
 b=aLPFXwV9fVa0KJdAcj6T8e+wdUgwrHiCEH12H7BHvKGNHrFMV3AsqLo9srRpKMJiqOIa/Ajq0M7h80uwYW2k4x+sz8tbIfGQht2jCQvm0uXmLeGjYtGGCloirbOXV3q3WkGRCVdSdsxBPb4250kBrgSSH49cVa1MLVU61hZ1k7w=
Received: from MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) by
 SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.9; Thu, 9 Jul 2026 21:02:21 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::2d) by MN2PR01CA0043.outlook.office365.com
 (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:21 +0000
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
Subject: [PATCH 33/80] drm/amd/display: Test HPD interrupt handling
Date: Thu, 9 Jul 2026 16:48:01 -0400
Message-ID: <20260709205936.5719-34-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: a36ad0b8-fc3c-4251-6071-08deddfd5e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Oc/BjwLe4WTR+8qop5FVKLeksFHl+Md0MbpSYCJMoNmz/OqijMgRuW490n+wipu0nPOw0f4mlXVE0HxjD8Kq1AjUHaN/zqNWh1OKeHgyCsJeHdRKKDuiKrB8D9sKrHSK2ReWjQtnN9rLi4S4aiZ9dadP0SiA+UW9Ti6uUHd9BPK2DiHTwW6PEjHBe9Yz3ySe8D9rAjOGNFJETEWD/HicjArXpHkQdbqI4MzZ+TrS7iMT+s6JmG8A/wDio0xzD0Xo8hMwXQRk4Fi/kMZoNXltaHeuvRc04K8fAADj4aHIIIjSY6VxI2vtJQku8tpa17l2KE6udrQrx0G6Bf3ejpkc/uY9Yo7E3FiYuYnqelSWEdbxPJCJGPWFvE2BJ1v8uCDC3eaO65K+gfL5yksG5fV+NlGiUnip5WbrcahKZQFg6sM2pPqJ24oWPaP69EvZyGl/fcJvF6lmxGDNrdkRKBOdB0nkAiSIHnWqJ5va78K09DXQHc4Ck6cO+sEhzIcoF3A9PL2hTEfB+qNJSQfS7bcTuaK2Rs4MKicuHoB0j/2+J2fZzmYQ9MCzFpa0ezosBCLFCErPqhovxzTrMp1wMVJxfrgyeCF0lZ5Atev/pxe1cTHpmha07bATDz77JG15pb13HK7bf2NH14sW2A6zoSIVTse9TnRTuit7CncngbdCS0Lsi+7mq32DOKA9NElZfcFMZa6+FPWLj4HmjSFY2DzUtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hRrBtrWf3QMvxR+9cHZnLm0o2jL/6cnmKVNHz5pUOV/reLoHwrxwJ+MCjmPt8849jXKfpCVqDp9rG6zfgyq7AlWXaCXG2Gz3+FGCG3a/CKDdGgk0s0CsKVTLHOlfOMoWjKzgNB6NcWmu15I6SayPgUGFkaK6s28Ouiey9K8CrQ5QiDVk0VYNuxIbuDg5F69ga454bxqZh6py88te7EDeDS9iWVMcYRnwSVsNo82aheKrNsNKt+L0B05kPMOwLC57j7YIKkUFDrqsbodSitdRL8k4QYldvAqqmznOuq8ESyIiXpYgOUXzf7Oanw7MVizgw4mCvA35SFhgLTl5yXQVoO3vft8zyQzHgeA2V352X/+SzdHgObUg725qJpeI+Lnpxk6xzrIxl6biHTUCvu9yjNMfV0SCUNtnAn18xdFG0dPCr1M46ZYRjTFg7/hxG0dS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:21.4295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ad0b8-fc3c-4251-6071-08deddfd5e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

Add KUnit coverage for the HPD interrupt-handling helpers: the HPD-RX
offload worker, the HDMI HPD debounce worker, handle_hpd_irq_helper(),
handle_hpd_irq(), schedule_hpd_rx_offload_work() and handle_hpd_rx_irq().
Expose these statics for KUnit and add the stub link-service callbacks,
sink helpers and fixtures the tests rely on.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  16 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   8 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 930 ++++++++++++++++++
 3 files changed, 949 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 8e18ed9f9501..c169f891470a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1075,7 +1075,7 @@ static void force_connector_state(
 	mutex_unlock(&aconnector->hpd_lock);
 }

-static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
+STATIC_IFN_KUNIT void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
 	struct amdgpu_dm_connector *aconnector;
@@ -1168,6 +1168,7 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	kfree(offload_work);

 }
+EXPORT_IF_KUNIT(dm_handle_hpd_rx_offload_work);

 struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev)
 {
@@ -1309,8 +1310,9 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 			dc_allow_idle_optimizations(dc, true);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_hdmi_hpd_debounce_work);

-static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 				  enum dc_detect_reason reason)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1408,16 +1410,18 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 		}
 	}
 }
+EXPORT_IF_KUNIT(handle_hpd_irq_helper);

-static void handle_hpd_irq(void *param)
+STATIC_IFN_KUNIT void handle_hpd_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;

 	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);

 }
+EXPORT_IF_KUNIT(handle_hpd_irq);

-static void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_rx_irq_offload_work_queue *offload_wq,
+STATIC_IFN_KUNIT void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_rx_irq_offload_work_queue *offload_wq,
 							union hpd_irq_data hpd_irq_data)
 {
 	struct hpd_rx_irq_offload_work *offload_work =
@@ -1436,8 +1440,9 @@ static void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_
 	queue_work(offload_wq->wq, &offload_work->work);
 	drm_dbg_kms(adev_to_drm(adev), "queue work to handle hpd_rx offload work");
 }
+EXPORT_IF_KUNIT(schedule_hpd_rx_offload_work);

-static void handle_hpd_rx_irq(void *param)
+STATIC_IFN_KUNIT void handle_hpd_rx_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 	struct drm_connector *connector = &aconnector->base;
@@ -1570,6 +1575,7 @@ static void handle_hpd_rx_irq(void *param)

 	mutex_unlock(&aconnector->hpd_lock);
 }
+EXPORT_IF_KUNIT(handle_hpd_rx_irq);

 /**
  * dmub_hpd_callback - DMUB HPD interrupt processing callback.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 15e024947970..e01b0856f91f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -161,6 +161,14 @@ void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 				 enum dc_irq_source irq_source);
 void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 				  enum dc_irq_source irq_source);
+void dm_handle_hpd_rx_offload_work(struct work_struct *work);
+void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+			   enum dc_detect_reason reason);
+void handle_hpd_irq(void *param);
+void schedule_hpd_rx_offload_work(struct amdgpu_device *adev,
+				  struct hpd_rx_irq_offload_work_queue *offload_wq,
+				  union hpd_irq_data hpd_irq_data);
+void handle_hpd_rx_irq(void *param);
 #endif

 #endif /* __AMDGPU_DM_IRQ_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 8c58523ef1bb..fa161d0ecfd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -24,6 +24,7 @@
 #include "link_service.h"
 #include "dmub/dmub_srv.h"
 #include "dal_asic_id.h"
+#include "../../amdgpu/amdgpu_reset.h"

 static void dm_test_irq_handler(void *arg)
 {
@@ -41,6 +42,148 @@ static void dm_test_irq_handler_count(void *arg)
 		(*count)++;
 }

+static bool dm_test_detect_connection_none(struct dc_link *link,
+					   enum dc_connection_type *type)
+{
+	*type = dc_connection_none;
+
+	return true;
+}
+
+static bool dm_test_detect_link_false(struct dc_link *link,
+				      enum dc_detect_reason reason)
+{
+	return false;
+}
+
+static bool dm_test_detect_connection_single(struct dc_link *link,
+					     enum dc_connection_type *type)
+{
+	*type = dc_connection_single;
+
+	return true;
+}
+
+/* Recording stubs for the dm_handle_hpd_rx_offload_work() DP-IRQ branches. */
+static int dm_test_automated_test_count;
+static int dm_test_handle_link_loss_count;
+
+static void dm_test_dp_handle_automated_test(struct dc_link *link)
+{
+	dm_test_automated_test_count++;
+}
+
+static void dm_test_dp_handle_link_loss(struct dc_link *link)
+{
+	dm_test_handle_link_loss_count++;
+}
+
+static bool dm_test_dp_parse_link_loss_true(struct dc_link *link,
+					    union hpd_irq_data *hpd_irq_dpcd_data)
+{
+	return true;
+}
+
+static bool dm_test_dp_should_allow_hpd_rx_irq_true(const struct dc_link *link)
+{
+	return true;
+}
+
+static enum dc_status dm_test_dp_read_hpd_rx_irq_data_ok(struct dc_link *link,
+							 union hpd_irq_data *irq_data)
+{
+	return DC_OK;
+}
+
+/*
+ * Allocate a refcounted dc_sink for tests without pulling in the DC-core
+ * dc_sink_create()/dc_sink_release() symbols. Production code under test still
+ * uses dc_sink_retain()/dc_sink_release() (resolved inside the amdgpu module).
+ * Use kzalloc (not kunit_kzalloc) so the final kref_put frees it exactly once.
+ */
+static struct dc_sink *dm_test_sink_create(struct dc_link *link)
+{
+	struct dc_sink *sink = kzalloc(sizeof(*sink), GFP_KERNEL);
+
+	if (!sink)
+		return NULL;
+
+	sink->link = link;
+	sink->ctx = link->ctx;
+	kref_init(&sink->refcount);
+
+	return sink;
+}
+
+static void dm_test_sink_free(struct kref *kref)
+{
+	struct dc_sink *sink = container_of(kref, struct dc_sink, refcount);
+
+	kfree(sink->dc_container_id);
+	kfree(sink);
+}
+
+static void dm_test_sink_release(struct dc_sink *sink)
+{
+	kref_put(&sink->refcount, dm_test_sink_free);
+}
+
+static bool dm_test_handle_hpd_rx_no_work(struct dc_link *link,
+					  union hpd_irq_data *hpd_irq_data,
+					  bool *link_loss,
+					  bool defer_handling,
+					  bool *has_left_work)
+{
+	*link_loss = false;
+	*has_left_work = false;
+
+	return false;
+}
+
+static bool dm_test_handle_hpd_rx_automated(struct dc_link *link,
+					    union hpd_irq_data *hpd_irq_data,
+					    bool *link_loss,
+					    bool defer_handling,
+					    bool *has_left_work)
+{
+	*link_loss = false;
+	*has_left_work = true;
+	hpd_irq_data->bytes.device_service_irq.bits.AUTOMATED_TEST = 1;
+
+	return false;
+}
+
+static bool dm_test_handle_hpd_rx_msg_rdy(struct dc_link *link,
+					  union hpd_irq_data *hpd_irq_data,
+					  bool *link_loss,
+					  bool defer_handling,
+					  bool *has_left_work)
+{
+	*link_loss = false;
+	*has_left_work = true;
+	hpd_irq_data->bytes.device_service_irq.bits.UP_REQ_MSG_RDY = 1;
+
+	return false;
+}
+
+static bool dm_test_handle_hpd_rx_link_loss(struct dc_link *link,
+					    union hpd_irq_data *hpd_irq_data,
+					    bool *link_loss,
+					    bool defer_handling,
+					    bool *has_left_work)
+{
+	*link_loss = true;
+	*has_left_work = true;
+
+	return false;
+}
+
+static bool dm_test_allow_hpd_rx_irq_true(const struct dc_link *link)
+{
+	return true;
+}
+
+
 static struct dc *dm_test_alloc_dc_with_ctx(struct kunit *test)
 {
 	struct dc_context *ctx;
@@ -1902,6 +2045,773 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 	amdgpu_dm_hpd_fini(adev);
 }

+/* Tests for dm_handle_hpd_rx_offload_work() */
+
+/**
+ * dm_test_hpd_rx_offload_work_no_connector - Test missing connector early exit
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_rx_offload_work_no_connector(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+
+	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
+	offload_work->offload_wq = offload_wq;
+	offload_work->adev = adev;
+	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+}
+
+/**
+ * dm_test_hpd_rx_offload_work_no_connection - Test no connection early exit
+ * @test: The KUnit test context
+ */
+static void dm_test_hpd_rx_offload_work_no_connection(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
+	struct hpd_rx_irq_offload_work *offload_work;
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+
+	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	offload_wq->aconnector = aconn;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	link_srv->detect_connection_type = dm_test_detect_connection_none;
+	dc->link_srv = link_srv;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	link->dc = dc;
+	aconn->dc_link = link;
+
+	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
+	offload_work->offload_wq = offload_wq;
+	offload_work->adev = adev;
+	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+}
+
+/**
+ * dm_test_hpd_rx_offload_work_automated_test - Test AUTOMATED_TEST branch
+ * @test: The KUnit test context
+ *
+ * With a present connection and the AUTOMATED_TEST service-IRQ bit set, the
+ * worker runs dc_link_dp_handle_automated_test() (stubbed via link_srv) and
+ * writes the test response with core_link_write_dpcd(). timing_changed is left
+ * false so force_connector_state() (which needs a registered DRM device) is
+ * skipped, and aux_access_disabled makes the DPCD write a safe no-op.
+ */
+static void dm_test_hpd_rx_offload_work_automated_test(struct kunit *test)
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
+	dm_test_automated_test_count = 0;
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
+	aconn->timing_changed = false;
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
+	link_srv->dp_handle_automated_test = dm_test_dp_handle_automated_test;
+	dc->link_srv = link_srv;
+	dc->ctx = ctx;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	link->aux_access_disabled = true;
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	aconn->dc_link = link;
+
+	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
+	offload_work->offload_wq = offload_wq;
+	offload_work->adev = adev;
+	offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST = 1;
+	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+
+	KUNIT_EXPECT_EQ(test, dm_test_automated_test_count, 1);
+}
+
+/**
+ * dm_test_hpd_rx_offload_work_link_loss - Test link-loss branch
+ * @test: The KUnit test context
+ *
+ * With a present non-eDP connection and no service-IRQ bits set, the worker
+ * takes the else-if link-loss path: dc_link_check_link_loss_status() and
+ * dc_link_dp_allow_hpd_rx_irq() gate entry, then dc_link_dp_read_hpd_rx_irq_data()
+ * returns DC_OK and a second link-loss check triggers dc_link_dp_handle_link_loss().
+ * All four are stubbed via link_srv.
+ */
+static void dm_test_hpd_rx_offload_work_link_loss(struct kunit *test)
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
+	dm_test_handle_link_loss_count = 0;
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
+	link_srv->dp_parse_link_loss_status = dm_test_dp_parse_link_loss_true;
+	link_srv->dp_should_allow_hpd_rx_irq = dm_test_dp_should_allow_hpd_rx_irq_true;
+	link_srv->dp_read_hpd_rx_irq_data = dm_test_dp_read_hpd_rx_irq_data_ok;
+	link_srv->dp_handle_link_loss = dm_test_dp_handle_link_loss;
+	dc->link_srv = link_srv;
+	dc->ctx = ctx;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	aconn->dc_link = link;
+
+	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
+	offload_work->offload_wq = offload_wq;
+	offload_work->adev = adev;
+	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
+
+	dm_handle_hpd_rx_offload_work(&offload_work->work);
+
+	KUNIT_EXPECT_EQ(test, dm_test_handle_link_loss_count, 1);
+}
+
+/* Tests for amdgpu_dm_hdmi_hpd_debounce_work() */
+
+/**
+ * dm_test_hdmi_hpd_debounce_detect_false - Test debounce false detect path
+ * @test: The KUnit test context
+ */
+static void dm_test_hdmi_hpd_debounce_detect_false(struct kunit *test)
+{
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
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
+			  amdgpu_dm_hdmi_hpd_debounce_work);
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
+	link_srv->detect_link = dm_test_detect_link_false;
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	aconn->dc_link = link;
+
+	amdgpu_dm_hdmi_hpd_debounce_work(&aconn->hdmi_hpd_debounce_work.work);
+	KUNIT_EXPECT_NULL(test, aconn->hdmi_prev_sink);
+}
+
+/**
+ * dm_test_hdmi_hpd_debounce_reallow_idle - Test debounce idle/sink-release tail
+ * @test: The KUnit test context
+ *
+ * With detection stubbed to return false, the if (ret) block is skipped, but
+ * the function tail is still exercised: IPS support plus an idle-allowed dmub
+ * makes reallow_idle true so dc_allow_idle_optimizations() runs on both entry
+ * and exit (disable_idle_power_optimizations keeps those safe early returns),
+ * and a cached hdmi_prev_sink is released and cleared.
+ */
+static void dm_test_hdmi_hpd_debounce_reallow_idle(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct dc_dmub_srv *dmub_srv;
+	struct amdgpu_device *adev;
+	struct dal_logger *logger;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
+			  amdgpu_dm_hdmi_hpd_debounce_work);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+
+	link_srv->detect_link = dm_test_detect_link_false;
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	aconn->dc_link = link;
+
+	/* DC_LOG_* dereferences ctx->logger->dev, so wire a real drm device. */
+	logger->dev = &adev->ddev;
+	dc->ctx->logger = logger;
+
+	/* Make reallow_idle true and keep dc_allow_idle*() a safe early return. */
+	dmub_srv->idle_allowed = true;
+	dc->ctx->dmub_srv = dmub_srv;
+	dc->caps.ips_support = true;
+	dc->debug.disable_idle_power_optimizations = true;
+
+	/* A cached previous sink must be released and cleared. */
+	aconn->hdmi_prev_sink = dm_test_sink_create(link);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn->hdmi_prev_sink);
+
+	amdgpu_dm_hdmi_hpd_debounce_work(&aconn->hdmi_hpd_debounce_work.work);
+	KUNIT_EXPECT_NULL(test, aconn->hdmi_prev_sink);
+}
+
+/* Tests for handle_hpd_irq()/handle_hpd_irq_helper() */
+
+/**
+ * dm_test_handle_hpd_irq_disabled - Test HPD helper returns when disabled
+ * @test: The KUnit test context
+ */
+static void dm_test_handle_hpd_irq_disabled(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct dm_connector_state *state;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	adev->dm.disable_hpd_irq = true;
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	aconn->base.state = &state->base;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	dc->ctx = ctx;
+	ctx->dc = dc;
+	link->ctx = ctx;
+	aconn->dc_link = link;
+	aconn->fake_enable = true;
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+	KUNIT_EXPECT_TRUE(test, aconn->fake_enable);
+
+	handle_hpd_irq(aconn);
+	KUNIT_EXPECT_TRUE(test, aconn->fake_enable);
+}
+
+/**
+ * dm_test_handle_hpd_irq_helper_debounce_schedule - Test HDMI debounce branch
+ * @test: The KUnit test context
+ *
+ * An HDMI link reporting a disconnect (connection type none) with a non-zero
+ * debounce delay and a cached local_sink must take the debounce branch: it
+ * caches local_sink in hdmi_prev_sink and schedules the delayed debounce work
+ * instead of detecting immediately.
+ */
+static void dm_test_handle_hpd_irq_helper_debounce_schedule(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct dm_connector_state *state;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
+			  amdgpu_dm_hdmi_hpd_debounce_work);
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	aconn->base.state = &state->base;
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
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	aconn->dc_link = link;
+
+	/* HDMI signal + debounce delay + cached sink -> debounce branch. */
+	aconn->hdmi_hpd_debounce_delay_ms = 100;
+	link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	link->local_sink = dm_test_sink_create(link);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link->local_sink);
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+
+	/* local_sink is cached for later comparison by the debounce work. */
+	KUNIT_EXPECT_PTR_EQ(test, aconn->hdmi_prev_sink, link->local_sink);
+
+	cancel_delayed_work_sync(&aconn->hdmi_hpd_debounce_work);
+	dm_test_sink_release(aconn->hdmi_prev_sink);
+	dm_test_sink_release(link->local_sink);
+}
+
+/**
+ * dm_test_handle_hpd_irq_helper_debounce_release_prev - Test stale prev_sink
+ * @test: The KUnit test context
+ *
+ * When the debounce branch is taken and a stale hdmi_prev_sink is already
+ * cached from a previous HPD, it must be released before caching the current
+ * local_sink. This exercises the dc_sink_release() of the previous sink.
+ */
+static void dm_test_handle_hpd_irq_helper_debounce_release_prev(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct dm_connector_state *state;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
+			  amdgpu_dm_hdmi_hpd_debounce_work);
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	aconn->base.state = &state->base;
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
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	aconn->dc_link = link;
+
+	/* HDMI signal + debounce delay + cached sink -> debounce branch. */
+	aconn->hdmi_hpd_debounce_delay_ms = 100;
+	link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	link->local_sink = dm_test_sink_create(link);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link->local_sink);
+
+	/* Stale sink from a previous HPD must be released by the helper. */
+	aconn->hdmi_prev_sink = dm_test_sink_create(link);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn->hdmi_prev_sink);
+	KUNIT_ASSERT_PTR_NE(test, aconn->hdmi_prev_sink, link->local_sink);
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+
+	/* Stale sink replaced by the current local_sink. */
+	KUNIT_EXPECT_PTR_EQ(test, aconn->hdmi_prev_sink, link->local_sink);
+
+	cancel_delayed_work_sync(&aconn->hdmi_hpd_debounce_work);
+	dm_test_sink_release(aconn->hdmi_prev_sink);
+	dm_test_sink_release(link->local_sink);
+}
+
+/**
+ * dm_test_handle_hpd_irq_helper_detect_false - Test immediate detect branch
+ * @test: The KUnit test context
+ *
+ * With no force, no debounce, and detection stubbed to report no connection,
+ * the helper takes the else branch: dc_exit_ips_for_hw_access() is a safe
+ * no-op (no IPS support) and dc_link_detect() returns false, so the connected
+ * if (ret) block is skipped. fake_enable must still be cleared.
+ */
+static void dm_test_handle_hpd_irq_helper_detect_false(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct dm_connector_state *state;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
+			  amdgpu_dm_hdmi_hpd_debounce_work);
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	aconn->base.state = &state->base;
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
+	aconn->dc_link = link;
+	aconn->fake_enable = true;
+
+	/* No debounce delay and no force -> immediate-detect else branch. */
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+
+	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
+}
+
+/* Tests for handle_hpd_rx_irq()/schedule_hpd_rx_offload_work() */
+
+/**
+ * dm_test_handle_hpd_rx_irq_disabled - Test HPDRX handler returns when disabled
+ * @test: The KUnit test context
+ */
+static void dm_test_handle_hpd_rx_irq_disabled(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	adev->dm.disable_hpd_irq = true;
+
+	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	adev->dm.hpd_rx_offload_wq = offload_wq;
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
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
+	aconn->dc_link = link;
+
+	handle_hpd_rx_irq(aconn);
+}
+
+/**
+ * dm_test_schedule_hpd_rx_offload_work - Test offload work is queued
+ * @test: The KUnit test context
+ */
+static void dm_test_schedule_hpd_rx_offload_work(struct kunit *test)
+{
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
+	struct amdgpu_device *adev;
+	union hpd_irq_data data = { 0 };
+
+	adev = dm_kunit_alloc_adev(test);
+
+	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	offload_wq->wq = create_singlethread_workqueue("dm_irq_test_hpd_rx");
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq->wq);
+
+	schedule_hpd_rx_offload_work(adev, offload_wq, data);
+	flush_workqueue(offload_wq->wq);
+	destroy_workqueue(offload_wq->wq);
+}
+
+static void dm_test_destroy_offload_wq(void *data)
+{
+	struct workqueue_struct *wq = data;
+
+	flush_workqueue(wq);
+	destroy_workqueue(wq);
+}
+
+/*
+ * Build an aconnector wired for handle_hpd_rx_irq(): HPD enabled, an MST-root
+ * connector on an MST-branch link so the post-detect block and drm_dp_cec_irq
+ * are skipped, and a flushed offload work queue. Caller sets the link_srv
+ * stubs (dp_handle_hpd_rx_irq and, if needed, dp_should_allow_hpd_rx_irq).
+ */
+static struct amdgpu_dm_connector *dm_test_setup_hpd_rx_irq(struct kunit *test,
+							    struct link_service **link_srv_out)
+{
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
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
+	offload_wq->wq = create_singlethread_workqueue("dm_irq_test_hpd_rx");
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq->wq);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_destroy_offload_wq,
+							offload_wq->wq), 0);
+	adev->dm.hpd_rx_offload_wq = offload_wq;
+
+	aconn = dm_kunit_alloc_connector(test, adev, NULL);
+	mutex_init(&aconn->hpd_lock);
+	aconn->mst_mgr.mst_state = true;
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
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+	link->link_index = 0;
+	link->type = dc_connection_mst_branch;
+	aconn->dc_link = link;
+
+	*link_srv_out = link_srv;
+
+	return aconn;
+}
+
+/**
+ * dm_test_handle_hpd_rx_irq_no_left_work - Test HPDRX early out (no left work)
+ * @test: The KUnit test context
+ *
+ * When dc_link_handle_hpd_rx_irq() reports no left-over work, the handler
+ * jumps to out and returns without scheduling any offload work.
+ */
+static void dm_test_handle_hpd_rx_irq_no_left_work(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_no_work;
+
+	handle_hpd_rx_irq(aconn);
+}
+
+/**
+ * dm_test_handle_hpd_rx_irq_automated_test - Test HPDRX automated-test path
+ * @test: The KUnit test context
+ *
+ * The AUTOMATED_TEST device-service bit must schedule offload work and jump to
+ * out before the allow-hpd-rx-irq checks.
+ */
+static void dm_test_handle_hpd_rx_irq_automated_test(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_automated;
+
+	handle_hpd_rx_irq(aconn);
+}
+
+/**
+ * dm_test_handle_hpd_rx_irq_msg_rdy - Test HPDRX MST message-ready path
+ * @test: The KUnit test context
+ *
+ * With HPD RX IRQs allowed and an UP_REQ_MSG_RDY bit set, the handler must take
+ * the MST message-ready branch, mark is_handling_mst_msg_rdy_event and schedule
+ * offload work.
+ */
+static void dm_test_handle_hpd_rx_irq_msg_rdy(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_msg_rdy;
+	link_srv->dp_should_allow_hpd_rx_irq = dm_test_allow_hpd_rx_irq_true;
+
+	handle_hpd_rx_irq(aconn);
+
+	KUNIT_EXPECT_TRUE(test, drm_to_adev(aconn->base.dev)
+				->dm.hpd_rx_offload_wq->is_handling_mst_msg_rdy_event);
+}
+
+/**
+ * dm_test_handle_hpd_rx_irq_link_loss - Test HPDRX link-loss path
+ * @test: The KUnit test context
+ *
+ * With HPD RX IRQs allowed and a reported link loss (no message-ready bits),
+ * the handler must take the link-loss branch, mark is_handling_link_loss and
+ * schedule offload work.
+ */
+static void dm_test_handle_hpd_rx_irq_link_loss(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_rx_irq(test, &link_srv);
+	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_link_loss;
+	link_srv->dp_should_allow_hpd_rx_irq = dm_test_allow_hpd_rx_irq_true;
+
+	handle_hpd_rx_irq(aconn);
+
+	KUNIT_EXPECT_TRUE(test, drm_to_adev(aconn->base.dev)
+				->dm.hpd_rx_offload_wq->is_handling_link_loss);
+}
+
 static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_to_dal_irq_source */
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
@@ -2004,6 +2914,26 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_hpd_init_fini_with_connectors),
 	KUNIT_CASE(dm_test_hpd_init_fini_analog_connector),
 	KUNIT_CASE(dm_test_hpd_init_fini_irq_ref),
+	/* dm_handle_hpd_rx_offload_work */
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connector),
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_no_connection),
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_automated_test),
+	KUNIT_CASE(dm_test_hpd_rx_offload_work_link_loss),
+	/* amdgpu_dm_hdmi_hpd_debounce_work */
+	KUNIT_CASE(dm_test_hdmi_hpd_debounce_detect_false),
+	KUNIT_CASE(dm_test_hdmi_hpd_debounce_reallow_idle),
+	/* handle_hpd_irq/handle_hpd_irq_helper */
+	KUNIT_CASE(dm_test_handle_hpd_irq_disabled),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_schedule),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_release_prev),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_false),
+	/* handle_hpd_rx_irq/schedule_hpd_rx_offload_work */
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_disabled),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_no_left_work),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_automated_test),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_msg_rdy),
+	KUNIT_CASE(dm_test_handle_hpd_rx_irq_link_loss),
+	KUNIT_CASE(dm_test_schedule_hpd_rx_offload_work),
 	{}
 };

--
2.55.0


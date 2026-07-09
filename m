Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BB6C4450D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3539910F709;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQcom0xP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D4510F6EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJw/zrWQb5drLsGtEEGGTLBf9zI7oCyjYZ/ect6NGPePllxU6MJa4XWqzRIJDLolfL+qeh3Jvzu8iFUK9/Qsec7HQJW6lDrMgF+45a3x7U1z96vpca5Nf4MNALURjUdkS9MlSU8Y5alL3feI1OJynWmSeBytteS0wA/l/CaeIXRpxdusVMROqunmxWs7B4JlLCz7FBw2PCkqsLr1L4k8oK36GGAktlWb4QsSLwXQMXB/7PcUbRLobfzeVZBDh8aLF7dI8y+qNCBpoIqaYdnflUK6Um4kM8NWraRkeZ8sTwVwubmzdlV7ssEKEqjUAJXn9zjK2AGv/c1WxZ+mFi5jSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihkfTeWdmLtaPwuufag5AzRcxk7XI2yz6UraLLKvUag=;
 b=ql2jTaVH2/SokfJT6mfwfXdHtu9UaNztcaPlgUuxTO3V1D0ofU+2MaVRGNFh28Sl1PfsIUMqplDnI9aDLhUc47v4XqKgkDPmgFoCtrXvb4A6P5W3vhJaftRa6wl0fGBVdZNq/k4g/SOrYjBEkdomo9jlBBrlNqKhzavxGnZer25NE0zA9D8Llsa38dAFKcL10J3cmnHtd2zztfRPbvBa3u1aXTxjVdIFHizIapJGC1WFgdiXjBhPyE91JPnAN7R4/R7Dn55eDw7wJmdaKkPBEKTZlSUM0X2pNzf+MRvGDnt1YrPknWmcO/jrjricqF8eqS7BRygQLnVRGjQrw6vnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihkfTeWdmLtaPwuufag5AzRcxk7XI2yz6UraLLKvUag=;
 b=mQcom0xPO1/6kONfouP2QRIfLSoIj+DHzi5zb6rIo7z3Uot7IWzhn8MIPsZnkR+15vy27TEPSDHvfFQUMOewWXNHhFoUgidQrzJ1MHhYGr6o742/b8KkxdkAGhr/XPKM5Kzfjvon7LU9VHOAnk5sLtm8GwuruyrLYPN8xq+VCkM=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 21:02:25 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::91) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:25 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:05 -0500
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
Subject: [PATCH 39/80] drm/amd/display: Add more tests for HDCP
Date: Thu, 9 Jul 2026 16:48:07 -0400
Message-ID: <20260709205936.5719-40-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: d65aea47-82d2-4ec4-9c91-08deddfd60ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|11063799006|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: zemI73l+j/2w1h6dzlUTb97+D4854KzSAYW44geTruuS9+Eqr0uBi4C4fWCAdxfipLRE2E2UuV7HGq5tWaSbmY8vMZitcsuWwuQ4RrimBeqkXVGAfwRdWNN1vTIZyHeSaJ9jb7BHvOLAp4yKDGPlIY1IPo8GlLBbYhZfPjURuat+X1K7uD/txGMMkjTc//Vvy8utc8JrEI/DhVbh6BKOqReDKQoAl2oaAZGdZDmVvjmxS7RZCZ/XVRU08R+qT3S6xslzYY1VpqzWH/w43ywM0a6JMm/pYVv0Tl4na9+TbBsBT19dDXgZlsKLxgHbaujasuY3pXU8ERS7ylsEEwHD3f+/OKJ7Wom8Hevoty24d5ugZS+t5uhw815X1wEg4L5OtHiqpqY6pnelByHeSjoHE7g7FTma8+KCri8Tae0Esafv9kYHSLHLxxhgWmVhOD3t9/aXu/CL9HITCuh7G0j7vFqhnI0NTmHIukXv3KlPceLPV/Lz6etHn0yKcGQbWWIl+rSXZY79WMhGkrzidFj+C3+Xq6cNq4v46/h7rhy85iU1o1fUJvksqccH/1qGQVchDSu2ctnwK1PG0ANp158L9mwyOiz7SU7T1RpXulPL/wZ5v3GODIbC76pksJIRH8PBN3YU+dyqxRe8I9YvhEFya3OHIA8cpKX8QizdV3SIOKrBtfTN+GZi7pIBNYv2mX5wBbzMaNQ6INwA7t1GT2hAtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(11063799006)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9lSBNv39aw27LTjHVL1uagdSgRjxusANgFoDPrvudrFSP/+snSJOkhoboSauXrb+lQHNNM93AO441PEuVNanMYTkZqDl1qlgnZswA37BII8sUPEv+hlQreuHJhl8Z6HQivuXNAgD9YE3aWoVfxExvIcOGcHzPmSczXteF40vNIkmca3RbbL3nMANW5N8zhPYfwTu0vh5RItQLtjpDgLrZD9G5WpvHGigea8jyo4mOoCf1Vme1ZMxIDR6TPbzb2+C/6eij3srLMjBoU0H+Ojk1TQu1igoq2kuvsCDzaIqsM0+CXtQhrbn/mE3RnIlD5ehrtTyD1M1qlIuvtlj+NWkj4bsC/NGY4uAtGj5EvqriE4sAsk3M2w+bHq2EQJMU5QNsWjpph67kv3lJgazVuioDJ4GPVcUHqeE0JVq1ItxlCFM7PXGhMO50Jzq9x+2mYlt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:25.6580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65aea47-82d2-4ec4-9c91-08deddfd60ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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

Adds a few more test cases to the hdcp code

  - process_output(): make sure work gets requeued when callback and
    watchdog are stopped but also asked to run again
  - event_property_update(): bail out when the connector is NULL
  - hdcp_handle_cpirq(): schedules the work and picks the right link
  - hdcp_update_display(): schedules property validation on enable,
    resets status and cancels validation on disable
  - hdcp_create_workqueue(): returns NULL when max links is zero

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  48 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   5 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 240 ++++++++++++++++++
 3 files changed, 276 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 039f6516085c..8f7585d3efa4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -258,6 +258,30 @@ static void link_lock(struct hdcp_workqueue *work, bool lock)
 	}
 }

+STATIC_IFN_KUNIT
+void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
+					    struct hdcp_workqueue *hdcp_w,
+					    unsigned int conn_index,
+					    bool enable_encryption)
+{
+	if (enable_encryption) {
+		/* Explicitly set the saved SRM as sysfs call will be after we already enabled hdcp
+		 * (s3 resume case)
+		 */
+		if (hdcp_work->srm_size > 0)
+			psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm,
+				    hdcp_work->srm_size,
+				    &hdcp_work->srm_version);
+
+		schedule_delayed_work(&hdcp_w->property_validate_dwork,
+				      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
+	} else {
+		hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		cancel_delayed_work(&hdcp_w->property_validate_dwork);
+	}
+}
+EXPORT_IF_KUNIT(hdcp_update_display_encryption_control);
+
 void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			 unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector,
@@ -281,22 +305,8 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			dc->debug.hdcp_lc_force_fw_enable,
 			dc->debug.hdcp_lc_enable_sw_fallback,
 			&link_adjust, &display_adjust);
-
-	if (enable_encryption) {
-		/* Explicitly set the saved SRM as sysfs call will be after we already enabled hdcp
-		 * (s3 resume case)
-		 */
-		if (hdcp_work->srm_size > 0)
-			psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm,
-				    hdcp_work->srm_size,
-				    &hdcp_work->srm_version);
-
-		schedule_delayed_work(&hdcp_w->property_validate_dwork,
-				      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
-	} else {
-		hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-		cancel_delayed_work(&hdcp_w->property_validate_dwork);
-	}
+	hdcp_update_display_encryption_control(hdcp_work, hdcp_w, conn_index,
+					      enable_encryption);

 	mod_hdcp_update_display(&hdcp_w->hdcp, conn_index, &link_adjust, &display_adjust, &hdcp_w->output);

@@ -363,6 +373,7 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index

 	schedule_work(&hdcp_w->cpirq_work);
 }
+EXPORT_IF_KUNIT(hdcp_handle_cpirq);

 static void event_callback(struct work_struct *work)
 {
@@ -381,7 +392,8 @@ static void event_callback(struct work_struct *work)
 	process_output(hdcp_work);
 }

-static void event_property_update(struct work_struct *work)
+STATIC_IFN_KUNIT
+void event_property_update(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work = container_of(work, struct hdcp_workqueue,
 							property_update_work);
@@ -440,6 +452,7 @@ static void event_property_update(struct work_struct *work)
 		drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	}
 }
+EXPORT_IF_KUNIT(event_property_update);

 static void event_property_validate(struct work_struct *work)
 {
@@ -872,4 +885,5 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,

 	return NULL;
 }
+EXPORT_IF_KUNIT(hdcp_create_workqueue);

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 3ba5823aed9f..a82a20b80518 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -108,6 +108,11 @@ void hdcp_get_link_display_adjustments(
 	bool hdcp_lc_enable_sw_fallback,
 	struct mod_hdcp_link_adjustment *link_adjust,
 	struct mod_hdcp_display_adjustment *display_adjust);
+void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
+					    struct hdcp_workqueue *hdcp_w,
+					    unsigned int conn_index,
+					    bool enable_encryption);
+void event_property_update(struct work_struct *work);
 #endif

 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index 619b4a80c82b..dbcff92672e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -402,8 +402,236 @@ static void dm_test_process_output_callback_and_watchdog_needed(struct kunit *te
 	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
 	cancel_delayed_work_sync(&work->property_validate_dwork);
 }
+
+/**
+ * dm_test_process_output_callback_stop_and_needed_requeues - stop+needed requeues callback work
+ * @test: KUnit test context
+ *
+ * When callback_stop and callback_needed are both set, process_output()
+ * should cancel the previous callback_dwork and queue it again.
+ */
+static void dm_test_process_output_callback_stop_and_needed_requeues(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	schedule_delayed_work(&work->callback_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->callback_dwork));
+
+	work->output.callback_stop = true;
+	work->output.callback_needed = true;
+	work->output.callback_delay = 300;
+
+	process_output(work);
+
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(&work->callback_dwork));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/**
+ * dm_test_process_output_watchdog_stop_and_needed_requeues - stop+needed requeues watchdog work
+ * @test: KUnit test context
+ *
+ * When watchdog_timer_stop and watchdog_timer_needed are both set,
+ * process_output() should cancel previous watchdog work and queue it again.
+ */
+static void dm_test_process_output_watchdog_stop_and_needed_requeues(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue(test);
+
+	schedule_delayed_work(&work->watchdog_timer_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	work->output.watchdog_timer_stop = true;
+	work->output.watchdog_timer_needed = true;
+	work->output.watchdog_timer_delay = 700;
+
+	process_output(work);
+
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
 /* End of tests for process_output() */

+/* Tests for event_property_update() */
+
+/**
+ * alloc_test_workqueue_for_property_update - allocate minimal workqueue for callback tests
+ * @test: KUnit test context for managed allocation
+ *
+ * Allocates a minimal hdcp_workqueue with property_update_work initialised
+ * so event_property_update() can resolve container_of() safely.
+ */
+static struct hdcp_workqueue *alloc_test_workqueue_for_property_update(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	INIT_WORK(&work->property_update_work, dummy_work_fn);
+
+	return work;
+}
+
+/**
+ * dm_test_event_property_update_skips_null_connector - null connector is ignored
+ * @test: KUnit test context
+ *
+ * If aconnector entry is NULL, event_property_update() should skip it
+ * without modifying encryption_status.
+ */
+static void dm_test_event_property_update_skips_null_connector(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_update(test);
+	enum mod_hdcp_encryption_status before;
+
+	work->encryption_status[0] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON;
+	before = work->encryption_status[0];
+
+	event_property_update(&work->property_update_work);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[0], before);
+}
+
+/* End of tests for event_property_update() */
+
+/* Tests for hdcp_handle_cpirq() */
+
+/**
+ * dm_test_hdcp_handle_cpirq_schedules_work - cpirq handler queues cpirq_work
+ * @test: KUnit test context
+ *
+ * hdcp_handle_cpirq() should schedule cpirq_work for the selected link.
+ */
+static void dm_test_hdcp_handle_cpirq_schedules_work(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	INIT_WORK(&work->cpirq_work, dummy_work_fn);
+
+	hdcp_handle_cpirq(work, 0);
+
+	KUNIT_EXPECT_TRUE(test, work_pending(&work->cpirq_work));
+
+	cancel_work_sync(&work->cpirq_work);
+}
+
+/**
+ * dm_test_hdcp_handle_cpirq_selects_link_index - only selected link work is queued
+ * @test: KUnit test context
+ *
+ * hdcp_handle_cpirq() should schedule cpirq_work for the selected index
+ * and not queue unrelated links.
+ */
+static void dm_test_hdcp_handle_cpirq_selects_link_index(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kcalloc(test, 2, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	INIT_WORK(&work[0].cpirq_work, dummy_work_fn);
+	INIT_WORK(&work[1].cpirq_work, dummy_work_fn);
+
+	hdcp_handle_cpirq(work, 1);
+
+	KUNIT_EXPECT_FALSE(test, work_pending(&work[0].cpirq_work));
+	KUNIT_EXPECT_TRUE(test, work_pending(&work[1].cpirq_work));
+
+	cancel_work_sync(&work[1].cpirq_work);
+}
+
+/* End of tests for hdcp_handle_cpirq() */
+
+/* Tests for hdcp_update_display() helper logic */
+
+/**
+ * dm_test_hdcp_update_display_enable_schedules_property_validate - enable path queues validate work
+ * @test: KUnit test context
+ *
+ * hdcp_update_display() should schedule property_validate_dwork when
+ * encryption is enabled.
+ */
+static void dm_test_hdcp_update_display_enable_schedules_property_validate(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	INIT_DELAYED_WORK(&work->property_validate_dwork, dummy_work_fn);
+	work->srm_size = 0;
+
+	hdcp_update_display_encryption_control(work, work, 0, true);
+
+	KUNIT_EXPECT_TRUE(test, delayed_work_pending(&work->property_validate_dwork));
+
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/**
+ * dm_test_hdcp_update_display_disable_resets_status_and_cancels_validate - disable path state update
+ * @test: KUnit test context
+ *
+ * hdcp_update_display() should set encryption_status to HDCP_OFF and
+ * cancel property_validate_dwork when encryption is disabled.
+ */
+static void dm_test_hdcp_update_display_disable_resets_status_and_cancels_validate(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	INIT_DELAYED_WORK(&work->property_validate_dwork, dummy_work_fn);
+	schedule_delayed_work(&work->property_validate_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->property_validate_dwork));
+
+	work->encryption_status[3] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	hdcp_update_display_encryption_control(work, work, 3, false);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[3],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->property_validate_dwork));
+}
+
+/* End of tests for hdcp_update_display() helper logic */
+
+/* Tests for hdcp_create_workqueue() */
+
+/**
+ * dm_test_hdcp_create_workqueue_zero_max_links_returns_null - zero-link creation fails early
+ * @test: KUnit test context
+ *
+ * When dc->caps.max_links is zero, hdcp_create_workqueue() should fail
+ * the initial allocation path and return NULL.
+ */
+static void dm_test_hdcp_create_workqueue_zero_max_links_returns_null(struct kunit *test)
+{
+	struct cp_psp cp_psp = {0};
+	struct dc *dc;
+	struct hdcp_workqueue *work;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	dc->caps.max_links = 0;
+
+	work = hdcp_create_workqueue(NULL, &cp_psp, dc);
+
+	KUNIT_EXPECT_PTR_EQ(test, work, NULL);
+}
+
+/* End of tests for hdcp_create_workqueue() */
+
 static struct kunit_case dm_hdcp_test_cases[] = {
 	/* hdcp_get_content_protection_from_status() */
 	KUNIT_CASE(dm_test_hdcp_get_cp_disabled_returns_desired),
@@ -423,6 +651,18 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_process_output_watchdog_needed),
 	KUNIT_CASE(dm_test_process_output_watchdog_stop),
 	KUNIT_CASE(dm_test_process_output_callback_and_watchdog_needed),
+	KUNIT_CASE(dm_test_process_output_callback_stop_and_needed_requeues),
+	KUNIT_CASE(dm_test_process_output_watchdog_stop_and_needed_requeues),
+	/* event_property_update() */
+	KUNIT_CASE(dm_test_event_property_update_skips_null_connector),
+	/* hdcp_handle_cpirq() */
+	KUNIT_CASE(dm_test_hdcp_handle_cpirq_schedules_work),
+	KUNIT_CASE(dm_test_hdcp_handle_cpirq_selects_link_index),
+	/* hdcp_update_display() helper logic */
+	KUNIT_CASE(dm_test_hdcp_update_display_enable_schedules_property_validate),
+	KUNIT_CASE(dm_test_hdcp_update_display_disable_resets_status_and_cancels_validate),
+	/* hdcp_create_workqueue() */
+	KUNIT_CASE(dm_test_hdcp_create_workqueue_zero_max_links_returns_null),
 	{}
 };

--
2.55.0


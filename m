Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AD0C531FC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F6710E5FD;
	Thu, 23 Jul 2026 20:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbjGEgGF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63FE310E5FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIqRI5UQ4ZrhfcqY7Cm/Zsp7f4kvOIUYaKVwdlG2scIILk1ORTU/8ZAzc8SPkVor64L+Mw/ZRkh2+E560nv8sEubopKfud+M0roo3S0gNBdkNF2E1zo2ZJZD12UJTqP+JrNw2X7OyqQY4iR4LHPiMg0RudQa8pJmFQ902RoT9AsWq6YOypOVvT61HVPSWdaoapkAZJlxL4s/iT4icF45Ab0nNlcli6SQ1epHuJCr5soL4Xk2IB2FTlg5QEwrp4gdhoueIhcAUMaNbqHTHSSwkEv9Cj/r3ncc02BzrA7aJkNX7q2hbbN7gj40tZhDMBHu8Kl2ds4IST7PlnAxjkZZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/nEz/+j6KoI+ek+g0JbL7q2/VWKgaOoUs2bBgnJm7I=;
 b=mNX9mdHCqtNfarRDrHb18loVgNT6CGqDRHn/WCiMXyOeQokQrI1sDOmNgF2DTcvdY8KB8HHdgLDBosCJXiTpo+EElmKS5luRHQYkhmMqH2CAeauh/UFr2C8Dny273JuEhrAT2lxSM7ivwoqDOe6w/Or4TNPFlbsoGRN9WDsc5bjs6P6pBL0dWWu4TiN5GfbfYJpyonfejm7g3dYSsIffaGKbHaTB61dDgOMfQvVT/2LQY0t2J8MYbiUTJQ1H2VjCPou/4kafErRauiJ4pcXHDIgms8DUU4Vv9EiYjd/U4bMRqEdUg1Yn4LUdYi2kVF3fes1ehEh3aVSeF3rRqKkkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/nEz/+j6KoI+ek+g0JbL7q2/VWKgaOoUs2bBgnJm7I=;
 b=gbjGEgGFz6EuHPNw1I6+O5NWILAohu+ZulcTRkE3RU6xai3o/TNNRnzBhuCuK9MHsSWvKE3eGaiPKu7bjrerwRuRm+zCuTPBCWdxkDaKIWnF19YnG49W6kCTG2lm2iWDII59HUkjDETdsjR6wJUXOh5/fL0yDIkNNRRIXWyUSMM=
Received: from MN0P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::33)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:18:56 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::5c) by MN0P223CA0030.outlook.office365.com
 (2603:10b6:208:52b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:56 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:54 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 08/49] drm/amd/display: Add KUnit tests for watchdog and cpirq
 events
Date: Thu, 23 Jul 2026 16:13:16 -0400
Message-ID: <20260723201908.373300-9-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf0f406-142a-438c-fae7-08dee8f79fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|3023799007|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: PrEACVNot5Inhyk8aAIPmjwDG6cj+GuTmSqifKhVOXMp3y8DCd8P2o3Sp7kybpxL/4BZlVpBP/dmIxE41vWb9PHtKJlmpLpcwOSwa2QwIfUVeNfu8hh5s+OkwpSzhpznQffiPPJpeAUMwab+MI8sVvjxSjUkitX9+qftqowJ0ne/LSiqhy+J5LSOe+nAOaHBUgayPi12aniDD6OI25uATLWFPBKtSCCvxXVxusi2w2K2J7gVeg1oF7cpV+SI/SgTW8jbwgFSEuVoHjM9vpZSMgHtNhnZ+mGdwjJsO4JtypXvFnfwIcKaB58SVb0orMo5sglTMvSKWiBHt5DyNU5EMRspMxrFEY8dOFkYx+OoLrRylbwwiwaV7GYS5ruZ8M3qCK4Yn2CyJPjn5IrOhA8ueKOKdlh6l+4KUo2sxCaoB3rf1HZDl4WzRx6Krip7rAS2Oma+5xWJiFICd9o/iLJUgSHank0n6Nmr9lnJlBblfsw8/dhyAmHFB0pqtzl7H6OTVVb3r17uuu/GX3gNELKg8FfwDATFI51byyWpjeazbOdMs/G63T5nuAUC1Ny1Xi5gYyBqsB03lwX0D0GLDHm2H0Wax+1GBlwMtWp2m5Ym2dySRyF/P3Zbb6B8vD6iALOJZIA362PVre62UR0meWqpy9sAZAq9oI028xJig0DQHhR+oCnEu4EMpyoeoUziaVF6aE28VhaCEYDrkFG8hPThWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3wTX9DMEyVaJU1owjfnGfjueCRmMDp9fUf2QovPoxV+t6bAaAO3srD5femObnjFAHb/8LJqxVTv1gQYwvewI5TjoEdFfS9aNl9EpOuND46TSnGOP3qkMWbyzHlilA6oDIHxoY2EhjHSF08rldnuw6cuGhoTAIlQd7/TkrufuO8xDiX958Usb7EW5hZ1WETyk2iuWrzSRyo0Um2AAqNKd29tfKIGfZEqLLQgi4WqUz+dFTL8HWKGk65r4gaLYsFj043OR3Gvg7P5lzOHuUXnIU9WZG6lDBYBiSAkikz6e2uzSqdojsa2qvwUF0hHVttnqYJ/kvJowALX9YxVr+Y2bAwZmFlLcMtjPZVVjfM7vow8n403tFRXU1wZMRuNNdgMr5k1la3bBC+7ngK8iNXs0v3e0hI61Snc0ak3eFTF6OD59nQ3V36uWIQEVytDn7RXa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:56.5697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf0f406-142a-438c-fae7-08dee8f79fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

Verify event_watchdog_timer() cancels its pending watchdog_dwork
and runs process_output(), and that event_cpirq() runs
process_output() without arming the callback or watchdog timers.
Both release the work-queue mutex on return.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 132 ++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 622d9c275c3a..896668c92888 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -517,7 +517,8 @@ void event_property_validate(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_property_validate);
 
-static void event_watchdog_timer(struct work_struct *work)
+STATIC_IFN_KUNIT
+void event_watchdog_timer(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
 
@@ -535,8 +536,10 @@ static void event_watchdog_timer(struct work_struct *work)
 
 	process_output(hdcp_work);
 }
+EXPORT_IF_KUNIT(event_watchdog_timer);
 
-static void event_cpirq(struct work_struct *work)
+STATIC_IFN_KUNIT
+void event_cpirq(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
 
@@ -548,6 +551,7 @@ static void event_cpirq(struct work_struct *work)
 
 	process_output(hdcp_work);
 }
+EXPORT_IF_KUNIT(event_cpirq);
 
 void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 57c534efbc71..a2b08bec58b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -116,6 +116,8 @@ void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 void event_property_update(struct work_struct *work);
 void event_property_validate(struct work_struct *work);
 void event_callback(struct work_struct *work);
+void event_watchdog_timer(struct work_struct *work);
+void event_cpirq(struct work_struct *work);
 void link_lock(struct hdcp_workqueue *work, bool lock);
 void hdcp_remove_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index 6f5cae0960e1..a4097a4aec26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -748,6 +748,132 @@ static void dm_test_event_property_validate_no_update_when_unchanged(struct kuni
 
 /* End of tests for event_property_validate() */
 
+/* Tests for event_watchdog_timer() */
+
+/**
+ * dm_test_event_watchdog_timer_cancels_watchdog_dwork - watchdog work is cancelled
+ * @test: KUnit test context
+ *
+ * event_watchdog_timer() must cancel a previously scheduled
+ * watchdog_timer_dwork. With no active hdcp display,
+ * mod_hdcp_process_event() leaves output cleared so the watchdog is not
+ * requeued and watchdog_timer_dwork ends up not pending.
+ */
+static void dm_test_event_watchdog_timer_cancels_watchdog_dwork(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_callback(test);
+
+	/* Pre-schedule watchdog_timer_dwork with a long delay so it won't fire. */
+	schedule_delayed_work(&work->watchdog_timer_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	event_watchdog_timer(&work->watchdog_timer_dwork.work);
+
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/**
+ * dm_test_event_watchdog_timer_schedules_property_validate - process_output() runs
+ * @test: KUnit test context
+ *
+ * event_watchdog_timer() finishes by calling process_output(), which always
+ * enqueues property_validate_dwork with delay=0. Verifying it is pending
+ * proves the handler reached process_output() and released the mutex.
+ */
+static void dm_test_event_watchdog_timer_schedules_property_validate(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_callback(test);
+
+	event_watchdog_timer(&work->watchdog_timer_dwork.work);
+
+	KUNIT_EXPECT_TRUE(test, work_pending(&work->property_validate_dwork.work));
+	/* Mutex must be released after the guard scope exits. */
+	KUNIT_EXPECT_FALSE(test, mutex_is_locked(&work->mutex));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/* End of tests for event_watchdog_timer() */
+
+/* Tests for event_cpirq() */
+
+/**
+ * alloc_test_workqueue_for_cpirq - workqueue ready for event_cpirq()
+ * @test: KUnit test context for managed allocation
+ *
+ * Allocates a minimal hdcp_workqueue with its mutex, cpirq_work and the
+ * three delayed works initialised, as required by the guard(mutex) and
+ * process_output() usage inside event_cpirq().
+ */
+static struct hdcp_workqueue *alloc_test_workqueue_for_cpirq(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	mutex_init(&work->mutex);
+	INIT_WORK(&work->cpirq_work, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->callback_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->watchdog_timer_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->property_validate_dwork, dummy_work_fn);
+
+	return work;
+}
+
+/**
+ * dm_test_event_cpirq_schedules_property_validate - process_output() runs
+ * @test: KUnit test context
+ *
+ * event_cpirq() finishes by calling process_output(), which always
+ * enqueues property_validate_dwork with delay=0. Verifying it is pending
+ * proves the handler reached process_output() and released the mutex.
+ */
+static void dm_test_event_cpirq_schedules_property_validate(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_cpirq(test);
+
+	event_cpirq(&work->cpirq_work);
+
+	KUNIT_EXPECT_TRUE(test, work_pending(&work->property_validate_dwork.work));
+	/* Mutex must be released after the guard scope exits. */
+	KUNIT_EXPECT_FALSE(test, mutex_is_locked(&work->mutex));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/**
+ * dm_test_event_cpirq_leaves_callback_and_watchdog_idle - only validate is queued
+ * @test: KUnit test context
+ *
+ * With no active hdcp display, mod_hdcp_process_event() leaves output
+ * cleared, so event_cpirq() must not schedule callback_dwork or
+ * watchdog_timer_dwork; only property_validate_dwork is enqueued.
+ */
+static void dm_test_event_cpirq_leaves_callback_and_watchdog_idle(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_cpirq(test);
+
+	event_cpirq(&work->cpirq_work);
+
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->callback_dwork));
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->watchdog_timer_dwork));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/* End of tests for event_cpirq() */
+
 /* Tests for hdcp_handle_cpirq() */
 
 /**
@@ -1233,6 +1359,12 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_event_property_validate_skips_null_state),
 	KUNIT_CASE(dm_test_event_property_validate_updates_on_status_change),
 	KUNIT_CASE(dm_test_event_property_validate_no_update_when_unchanged),
+	/* event_watchdog_timer() */
+	KUNIT_CASE(dm_test_event_watchdog_timer_cancels_watchdog_dwork),
+	KUNIT_CASE(dm_test_event_watchdog_timer_schedules_property_validate),
+	/* event_cpirq() */
+	KUNIT_CASE(dm_test_event_cpirq_schedules_property_validate),
+	KUNIT_CASE(dm_test_event_cpirq_leaves_callback_and_watchdog_idle),
 	/* hdcp_handle_cpirq() */
 	KUNIT_CASE(dm_test_hdcp_handle_cpirq_schedules_work),
 	KUNIT_CASE(dm_test_hdcp_handle_cpirq_selects_link_index),
-- 
2.53.0


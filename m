Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C7DC531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC4110F17B;
	Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7iyk6rT";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720C110F1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx0J0jpxI3he1g+1Sbs10I6uVT2SnH4JC3dhCemPuLsxY0Mvttcf+vTc6Z2ED6m6ohm8gf06qqUAdygsEy4va/ovxt5p5DDmAQphdkbb+5M7ZNzxGz87x4kBOOyE401vja1cSNzT8laKnwkPsWQQb0ryu0Aa7h1qZMB05qi6/pCR9bjNCi+497tkXrftejbSKmeSA/VDic33p8VQXfUB+SnlxdvpBmG5NYhBugBZzSfo8Bivr7pEfX/G94IeH5y5kSSv/lC1MydgvZiBHt/Jd513LUDIs8q2HqCnXiLGSM0alGCwNDQshWgC7JtwK2YmRBi45YxV8RxRbZDX/5nIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KChiaTuQW5IWAYwJJpSgYYWKmzeU54vbn5L3Qn8XtI0=;
 b=VuSinKdZywYbeSl61fh3aQd42vsWyAngfvsWFaU8l4G54btpF1DA+H58gEk4Zdzp6JGfzreC8mwT5tqbkxjMG/9K0mNoOXdNPTY4xq3icGSPGHtcyGKV09MfcEVmRQqIK/zZUfBT1xALXXagYLWTH2oUiTCbau3WsTmsI72iy0dd2X+56+KnQoZWzh+qoPmCwHunLw4RT0FcjIxLPdigZIFm0IXDq8fud8D/H8pPT3QB0kcr5izNwx2mcW6Kcs6RKa54JZ7mk5+mUKr0BxfLvnRJFzW2j6sPuDKIR//3VARQYyCHhFietvX3+PAVi+cjdjvZGCEj/ltdqtU8dWK/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KChiaTuQW5IWAYwJJpSgYYWKmzeU54vbn5L3Qn8XtI0=;
 b=E7iyk6rTmGem+gLRiuSOe/kafOolCik2grypzC8mPgQfswBlEzl9L6UVm7UNW4Q1kqHXo2aFgnurKaWu4LAvCG5PSrz9k5i5hRjBhGHAmddc3PTgnwZMlQbccPi5lvms14iTCMLzeZSrKujW/sLxHuZDINnEnPsdGfnZj7dAtA0=
Received: from MN0P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::19)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:18:55 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::4) by MN0P223CA0001.outlook.office365.com
 (2603:10b6:208:52b::19) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 15:18:52 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 06/49] drm/amd/display: Add KUnit tests for event_callback
Date: Thu, 23 Jul 2026 16:13:14 -0400
Message-ID: <20260723201908.373300-7-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 1256d46b-83eb-49f5-649c-08dee8f79eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|11063799006|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: HrydNTYScNBjG/D+6doQ9dPjMT4Q8fBZO7Xq7llME8z9wsOh6eBvp6AjG+0n2f0k2oyA/VM5J9MiFDRq5pZH0LAepX+dWsyXRE8rMnLUBKFMKawVMnhxmwBvNx5BzqijYABJBWdq2SbBXjcnmtACydNVgA51FMAUfNTUMVIgWGkTNm0jIZOYYe1ZGMaQsxGicqhxoFafGSedW4d6uXQcUDPz/rZZJn6IHJmlJvriCcSLdrZJoRe/anl6b4DZKH+dLuE06x6tNdaT2OQssvmfKFVZcF0Q1cDdZrYwskiUfRIiNGX2xikRjGU9GxViogkdncmGeepo+xOzpIx+Q2NR3VZ/KVd4ngMznBpu9/ncZwQhRJobMW+qQC7ZOBaKCfE96RrdxmlXZf6M2OdINru5ZvHJA3QwOMpa8cbUsH+TsFsoJmDWOqHFbcmfIkb8t58SuQmp+Q5CriizzKcpOzL5fX/mFHcQFfYug7XBGDNbhNGFlQRPFka+x7KG/xMHql8gW25BHDl6gl8DfDOVTv1/HnuSTJsTyegFuAzkVo4+Y8lzfK/Xt4n3Z2XWhu+JeZ2o2iCSnFHn44p+UzVP/WZXPnDySw5GirbOQFDACKb3neZ50VJTr/tGUeraSx+7XsLEMSWJ32pVsRSBjH7R37w+UwjRCV9W4BXHJaE0r5+0daKwkL7Jmuc6rOtZFJlSoR0kuM0N5EDDWkIz80pv+UIPAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2JsfY10YkL3igBKzxni5MogYprrYArffo665NY9HZ9qms8uH7Xv0AF1It86OOEsL/pdWq5QdsxyrxTUxXq8xv35jAVlTSd1Fdw0zf8aqUciVHHOGK/6Z3++DXTRUkpjWz9q6WqhmfkY/qMc2fK8j5VU0m2Yp0Vx/XPmXV4YK9TK4VIOpQZlocZMa/CGxm3g9ftCrSzGX91bUXCtBsrO5NG51G1d6f6o1fX+9Pe7TJkg2R/KGuwb+pTbgjRreQhUHowiFaLP4HycuS4sfFTUpVEk193XC6xGctCI4NknxXt7vghGKIZHSYq/QD1FghPF6Nt5Fvbn3FLQnpvKcmoCHwYxpSwnYI3bQ86BSOJELs3sOZgy5kLyL0gJPapFdentDUrdYTcyeUbzIB5DsUI1UtsOL8VcH/fVJ7Ai6tr0QoGIsmzWOw2QNNRFiolLdaVRr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:54.9348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1256d46b-83eb-49f5-649c-08dee8f79eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550
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

Verify event_callback() cancels a pending callback_dwork and then
runs process_output(), which re-arms property_validate_dwork, and
that the work-queue mutex is released on return.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 78 +++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index f786c0a85425..34f70e517dc6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -384,7 +384,8 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index
 }
 EXPORT_IF_KUNIT(hdcp_handle_cpirq);
 
-static void event_callback(struct work_struct *work)
+STATIC_IFN_KUNIT
+void event_callback(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
 
@@ -400,6 +401,7 @@ static void event_callback(struct work_struct *work)
 
 	process_output(hdcp_work);
 }
+EXPORT_IF_KUNIT(event_callback);
 
 STATIC_IFN_KUNIT
 void event_property_update(struct work_struct *work)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 69a50e081c56..4b8ba743f9d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -114,6 +114,7 @@ void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 					    unsigned int conn_index,
 					    bool enable_encryption);
 void event_property_update(struct work_struct *work);
+void event_callback(struct work_struct *work);
 void link_lock(struct hdcp_workqueue *work, bool lock);
 void hdcp_remove_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index e6d03199187b..e0386030b35e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -501,6 +501,81 @@ static void dm_test_event_property_update_skips_null_connector(struct kunit *tes
 
 /* End of tests for event_property_update() */
 
+/* Tests for event_callback() */
+
+/**
+ * alloc_test_workqueue_for_callback - workqueue ready for event_callback()
+ * @test: KUnit test context for managed allocation
+ *
+ * Allocates a minimal hdcp_workqueue with its mutex and the three delayed
+ * works initialised, as required by the guard(mutex), cancel_delayed_work()
+ * and process_output() usage inside event_callback().
+ */
+static struct hdcp_workqueue *alloc_test_workqueue_for_callback(struct kunit *test)
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
+ * dm_test_event_callback_cancels_callback_dwork - callback work is cancelled
+ * @test: KUnit test context
+ *
+ * event_callback() must cancel a previously scheduled callback_dwork. With
+ * no active hdcp display, mod_hdcp_process_event() leaves output cleared so
+ * the callback is not requeued and callback_dwork ends up not pending.
+ */
+static void dm_test_event_callback_cancels_callback_dwork(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_callback(test);
+
+	/* Pre-schedule callback_dwork with a long delay so it won't fire. */
+	schedule_delayed_work(&work->callback_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->callback_dwork));
+
+	event_callback(&work->callback_dwork.work);
+
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&work->callback_dwork));
+
+	cancel_delayed_work_sync(&work->callback_dwork);
+	cancel_delayed_work_sync(&work->watchdog_timer_dwork);
+	cancel_delayed_work_sync(&work->property_validate_dwork);
+}
+
+/**
+ * dm_test_event_callback_schedules_property_validate - process_output() runs
+ * @test: KUnit test context
+ *
+ * event_callback() finishes by calling process_output(), which always
+ * enqueues property_validate_dwork with delay=0. Verifying it is pending
+ * proves event_callback() reached process_output() and released the mutex.
+ */
+static void dm_test_event_callback_schedules_property_validate(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_callback(test);
+
+	event_callback(&work->callback_dwork.work);
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
+/* End of tests for event_callback() */
+
 /* Tests for hdcp_handle_cpirq() */
 
 /**
@@ -977,6 +1052,9 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_process_output_watchdog_stop_and_needed_requeues),
 	/* event_property_update() */
 	KUNIT_CASE(dm_test_event_property_update_skips_null_connector),
+	/* event_callback() */
+	KUNIT_CASE(dm_test_event_callback_cancels_callback_dwork),
+	KUNIT_CASE(dm_test_event_callback_schedules_property_validate),
 	/* hdcp_handle_cpirq() */
 	KUNIT_CASE(dm_test_hdcp_handle_cpirq_schedules_work),
 	KUNIT_CASE(dm_test_hdcp_handle_cpirq_selects_link_index),
-- 
2.53.0


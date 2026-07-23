Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F28C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7F510F1AF;
	Thu, 23 Jul 2026 20:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LDvIvtKK";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C4610E5FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcvavtHfK450k+OZ9yIQm9cuH+1XWMszmUQht4mS3FqqeeNNieCSYbQQD47ezc9mF7fHISKjaXjUc8hiJq3pNB3cZuKtHoM0bJz4FUw/019cVfCvKE5gupKdAIntr6GC1svGh5KQnfSo5KR5/j7T1gcFsrmi5QV2EbW+U2VLQQiGOtkxLlHmmogJmnK0umspaoBQwlG0eXRl5P+LIB+e+GIn6zipER0gH3B7wWrHUj8QnPMeT++EdCVf9Kc25wS8cSNGV2Z4MSfTP2WyGkPgSxM6A4ZHqEW5KrBM7Pvy9+oCAZAEYy4FmmUpoE0LhFEP9TYu45LMtXzQPFmu7u8hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gXy8YJYiMcMWuoFRO16b17KcKR3X5CzwrBCPSjCJu0=;
 b=R3gsZxhHC7FaWz67vhAWWeTHlAzbf41dmlG+ODf45Nl0Cu0HW9BVwQo5KjcxHTFHJYs1hUWfpWsiIpUrARsebT/99+0tW96rn9BcoOhNAhhoBgXieMliLbPvCcxFF25htMT9qsCnXhlBY/a+wCoyZMYl2Xn1cmdHw9lqUm1dO8LcPTdeiwo3IrA23xesO4y49Sqlyb/j3NLYIebRc2AxVxarGWCVKGBZVC1ObfHCiNbdOugx/TfHXKCTTkDX3dd+eRATnJVPo77R2gyBFsCT78iS84+30uTk01DQ/f/BFN4vQLwDIpY8tSZCND53VZb/Xzfpmz6Hx5bTLfxFAvQaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gXy8YJYiMcMWuoFRO16b17KcKR3X5CzwrBCPSjCJu0=;
 b=LDvIvtKKUjfjmguIZ2bhMyk1p5hQbmnKbbBsmpM+9mxKf8Ku2ouaNmJmA4YXYw6rUQ4qtRf4YeW20XqqDyBLpLGVinaPD+ghNfvgP5TTnGZ4dq3yI/MoNPGYJsRCVTJSOKP+CvtN4ohEsqWpQ7334WWK+4V6j8dUwPnWltTso/Y=
Received: from MN0P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::12)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:18:56 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::31) by MN0P223CA0026.outlook.office365.com
 (2603:10b6:208:52b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:55 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:53 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 07/49] drm/amd/display: Add KUnit tests for
 event_property_validate
Date: Thu, 23 Jul 2026 16:13:15 -0400
Message-ID: <20260723201908.373300-8-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d992b9-d37f-45c5-6fc0-08dee8f79eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: smpFAumFuxxzi2Df28+uv+OWjI6FKO3lzLi+dkq+RZVognAQcEcj1iWYuJGSjcD+m/kdWw7ohrpquRb7OLERA3oFCKDj2Y+EV94N04vSfHv568zo0SmW6/U4gMTpslnNCE40pX3yy3fXxDgXAGNgWGH65Ka+PdES24EGa5TceJJ0AIluVAr+wSqVGgO6idI/YMRtp/fUpRpEMMOjZ1NNEnrFZZirtAVkZXiLKMVuvomYFKfXgrVhJ8y/OqguGJPy8Ju1KjCc8cZOltavmWCLTwro2gOHRvZGa/+ExVIr52RbnY0THp26M+VPvk8S/a7YJtIMaan6cBCDcnfvgg+VnlQKXSoOoSJSXy4+P5aZoCD5ecyJuurVNvcpCGi7gVl7q4uI7p47xUpGYL6je+Ef7olZzKfvB+nuDeH8TxO+Lt7VHpFQVHXeJw2uX2nZLdfHjeMmsLdkGx1axbTXb4bvk/1n4w5jUq66YC+Rxa9+/tOr1ejaBfpt4CuzoDcLkMljM5XxuPFiqh0Q+39ovW3LI5Y2fCsSnsyquRE2IFw6IpsjH4zB0F/KmWTuFN7UrgPXKw1mcdvExM6vQnJv7scfk1h+d5+A4VdlFTZsZVMHw81oGEsgeQEl/cNViec+c036c5Fi6LyVDbw9OulPLKDJ1AD8KDDvTyUOdUXpXGr/WLubAmksXzNn5Nmpl5X0Y82XABRj4gYwUVpWzW6weu7SSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hU3XZnDXjMtMnCY2LzoaNEVy08MYko7rJ2ioHaSRlAMcLtCsy8XhfC2BdT5TYEtub++DjSBWdQbEVjLtUK9h9qYjGSwkyTKw8zatd/6+Jszl4LH9OkDAPDwMHbdDbhm3X4Dqq8cqcxWPv21tPVmsvJ+zsU5KNw2Map49ujnQ6n8yJWswMBGWD/mPrxTwJSWzzKY7Y7BAiyh5D+Z036GjjXxz/AIdrb3FY2PLjzxAmeUGL1O06+tAt+raxkZo9lZvmlE4dOMxQVSSBoq658VEVMaxawKCp85X7oj0sKnqSurkc1X7eQmDdj895ljsWijPlWUr2YePiTjusbeHqZivPL/HBgMXF4krQbf6IS/xl+nllb/NBIgeOdVFIfo2nehGcRJoxNrKSL5A3jqr3DdoM/r7LCTtpFu33sfcHzXKkEKTSucJytJxkejalDtMUXf0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:55.3372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d992b9-d37f-45c5-6fc0-08dee8f79eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

Cover the per-connector scan in event_property_validate(): NULL,
disconnected and NULL-state connectors are skipped; a changed
encryption status updates the cached value and schedules
property_update_work; and an unchanged status leaves it
untouched.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 178 ++++++++++++++++++
 3 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 34f70e517dc6..622d9c275c3a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -465,7 +465,8 @@ void event_property_update(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_property_update);
 
-static void event_property_validate(struct work_struct *work)
+STATIC_IFN_KUNIT
+void event_property_validate(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work =
 		container_of(to_delayed_work(work), struct hdcp_workqueue, property_validate_dwork);
@@ -514,6 +515,7 @@ static void event_property_validate(struct work_struct *work)
 		}
 	}
 }
+EXPORT_IF_KUNIT(event_property_validate);
 
 static void event_watchdog_timer(struct work_struct *work)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 4b8ba743f9d8..57c534efbc71 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -114,6 +114,7 @@ void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 					    unsigned int conn_index,
 					    bool enable_encryption);
 void event_property_update(struct work_struct *work);
+void event_property_validate(struct work_struct *work);
 void event_callback(struct work_struct *work);
 void link_lock(struct hdcp_workqueue *work, bool lock);
 void hdcp_remove_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index e0386030b35e..6f5cae0960e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -576,6 +576,178 @@ static void dm_test_event_callback_schedules_property_validate(struct kunit *tes
 
 /* End of tests for event_callback() */
 
+/* Tests for event_property_validate() */
+
+/**
+ * alloc_test_workqueue_for_property_validate - workqueue for validate tests
+ * @test: KUnit test context for managed allocation
+ *
+ * Allocates a minimal hdcp_workqueue with its mutex and property_update_work
+ * initialised, as required by the guard(mutex) and schedule_work() usage
+ * inside event_property_validate().
+ */
+static struct hdcp_workqueue *alloc_test_workqueue_for_property_validate(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	mutex_init(&work->mutex);
+	INIT_WORK(&work->property_update_work, dummy_work_fn);
+
+	return work;
+}
+
+/**
+ * alloc_validate_connector - connector for event_property_validate() tests
+ * @test: KUnit test context for managed allocation
+ * @index: drm connector index to assign
+ * @status: drm connector detection status to assign
+ * @with_state: whether to attach a zeroed drm_connector_state
+ *
+ * Allocates an amdgpu_dm_connector sufficient for the traversal in
+ * event_property_validate(). mod_hdcp_query_display() has no active display
+ * so it returns early, leaving the pre-set HDCP_OFF query untouched.
+ */
+static struct amdgpu_dm_connector *alloc_validate_connector(struct kunit *test,
+							    unsigned int index,
+							    enum drm_connector_status status,
+							    bool with_state)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->base.index = index;
+	aconnector->base.status = status;
+
+	if (with_state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, conn_state);
+		aconnector->base.state = conn_state;
+	}
+
+	return aconnector;
+}
+
+/**
+ * dm_test_event_property_validate_skips_null_connector - null entries ignored
+ * @test: KUnit test context
+ *
+ * With every aconnector entry NULL, event_property_validate() must not
+ * schedule property_update_work and must leave encryption_status untouched.
+ */
+static void dm_test_event_property_validate_skips_null_connector(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_validate(test);
+
+	work->encryption_status[0] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	event_property_validate(&work->property_validate_dwork.work);
+
+	KUNIT_EXPECT_FALSE(test, work_pending(&work->property_update_work));
+	KUNIT_EXPECT_EQ(test, work->encryption_status[0],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON);
+}
+
+/**
+ * dm_test_event_property_validate_skips_disconnected - disconnected is skipped
+ * @test: KUnit test context
+ *
+ * A connector whose status is not connector_status_connected must be
+ * skipped, leaving encryption_status unchanged and no work scheduled.
+ */
+static void dm_test_event_property_validate_skips_disconnected(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_validate(test);
+
+	work->aconnector[1] = alloc_validate_connector(test, 1,
+						       connector_status_disconnected, true);
+	work->encryption_status[1] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	event_property_validate(&work->property_validate_dwork.work);
+
+	KUNIT_EXPECT_FALSE(test, work_pending(&work->property_update_work));
+	KUNIT_EXPECT_EQ(test, work->encryption_status[1],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON);
+}
+
+/**
+ * dm_test_event_property_validate_skips_null_state - missing state is skipped
+ * @test: KUnit test context
+ *
+ * A connected connector without a drm_connector_state must be skipped
+ * before the query, leaving encryption_status unchanged.
+ */
+static void dm_test_event_property_validate_skips_null_state(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_validate(test);
+
+	work->aconnector[2] = alloc_validate_connector(test, 2,
+						       connector_status_connected, false);
+	work->encryption_status[2] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	event_property_validate(&work->property_validate_dwork.work);
+
+	KUNIT_EXPECT_FALSE(test, work_pending(&work->property_update_work));
+	KUNIT_EXPECT_EQ(test, work->encryption_status[2],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON);
+}
+
+/**
+ * dm_test_event_property_validate_updates_on_status_change - change triggers update
+ * @test: KUnit test context
+ *
+ * For a connected connector with state, the query returns HDCP_OFF (no
+ * active hdcp display). When the stored encryption_status differs, it must
+ * be updated to HDCP_OFF and property_update_work must be scheduled.
+ */
+static void dm_test_event_property_validate_updates_on_status_change(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_validate(test);
+
+	work->aconnector[3] = alloc_validate_connector(test, 3,
+						       connector_status_connected, true);
+	work->encryption_status[3] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	event_property_validate(&work->property_validate_dwork.work);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[3],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+	KUNIT_EXPECT_TRUE(test, work_pending(&work->property_update_work));
+
+	cancel_work_sync(&work->property_update_work);
+}
+
+/**
+ * dm_test_event_property_validate_no_update_when_unchanged - no change, no work
+ * @test: KUnit test context
+ *
+ * For a connected connector with state whose stored encryption_status is
+ * already HDCP_OFF (matching the query result), event_property_validate()
+ * must not reschedule property_update_work.
+ */
+static void dm_test_event_property_validate_no_update_when_unchanged(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_validate(test);
+
+	work->aconnector[4] = alloc_validate_connector(test, 4,
+						       connector_status_connected, true);
+	work->encryption_status[4] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+
+	event_property_validate(&work->property_validate_dwork.work);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[4],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+	KUNIT_EXPECT_FALSE(test, work_pending(&work->property_update_work));
+}
+
+/* End of tests for event_property_validate() */
+
 /* Tests for hdcp_handle_cpirq() */
 
 /**
@@ -1055,6 +1227,12 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	/* event_callback() */
 	KUNIT_CASE(dm_test_event_callback_cancels_callback_dwork),
 	KUNIT_CASE(dm_test_event_callback_schedules_property_validate),
+	/* event_property_validate() */
+	KUNIT_CASE(dm_test_event_property_validate_skips_null_connector),
+	KUNIT_CASE(dm_test_event_property_validate_skips_disconnected),
+	KUNIT_CASE(dm_test_event_property_validate_skips_null_state),
+	KUNIT_CASE(dm_test_event_property_validate_updates_on_status_change),
+	KUNIT_CASE(dm_test_event_property_validate_no_update_when_unchanged),
 	/* hdcp_handle_cpirq() */
 	KUNIT_CASE(dm_test_hdcp_handle_cpirq_schedules_work),
 	KUNIT_CASE(dm_test_hdcp_handle_cpirq_selects_link_index),
-- 
2.53.0


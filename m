Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C664ECD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7440110E4FC;
	Tue, 26 May 2026 07:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4k8lFgat";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C88510E4FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzTzHfwH6L/0LZbaKr6qyr5yhjbBGkfLF2+UQXGx1/e6b/M4cX5BAt6qntgqMrl0zQeSLCnTFB7Wnkt2fa7ES7ENVDFxfjCyPWCYlcntpVSxXJhqG/SKcfahiQWU73b8xgj3t2otptcU7asW4R7yoiiXNzd+AwA9xhpZMdVcD5lXui8+E4uySHV7vC8Ru9pApHsI0yfxplioG1Cd/6RC9oAFbCJ1sTYCs0pHyBSRLurfxiHuFhqMsaIY+buqt85a89L0vgELcGd4z4kIc7oB4joSMYUVbeLXsQQbUZ/mfC6rbYvdcAdOGf9dOeabwsNxU+du9hIWD8ZFSR+ljeISfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCpL4IMs23kcIeW6MVmq2l6+yVxzwi5CEraStTaEdTU=;
 b=ch6JoYUkQXmDMmYdjEkSQJiA7tRghDxPipQuFd6Z1iZGnwOfb5mxeML7k2BZ7tRNeGxgdYvBk8wxJviRGMQDz7W0L8uUl+6sQe0IO6wqHwyrzCPdyxr5nobmH17RiZRN3OtKhxEr1HAmY7i3Qrq/qNhVwF9HGI8vJxtmR5UR92i0zppLbuIEpj5FAT50WeG5CtxNWiI5ZcJkNUs5CxmkjyS/4P8i1c00ywAC9tTKR9y8fsEdJQyvjQLdJAjmZUFPAS+TeUUqpFvPdvBqmDD2D6mMNRpK0BvHsMtVQ8mfd7qX5x2Yo6ry8sclRENKTX1f1sJ8njrrBPHAiVHBUjqhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCpL4IMs23kcIeW6MVmq2l6+yVxzwi5CEraStTaEdTU=;
 b=4k8lFgatFJW/ldmdmLFiPeeYWEj8BMgwfnDNqQ5Yz04TRVadAZu5gh5w6OeCrqgllWnS+N7T2UderZWIq+D4CJneLN5FRdEe2iyc0MR3bBuHrkhp/rUHrL8gc02j5OEojeY82pX4s7bto6F+4vu3cuRcj5DMnAEzzRcKspj+Ai8=
Received: from PH0PR07CA0086.namprd07.prod.outlook.com (2603:10b6:510:f::31)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:18:09 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::8d) by PH0PR07CA0086.outlook.office365.com
 (2603:10b6:510:f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:18:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:18:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:18:07 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:17:59 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 26/41] drm/amd/display: Add more KUnit tests for amdgpu_dm_ism
Date: Tue, 26 May 2026 15:01:49 +0800
Message-ID: <20260526071413.2181251-27-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e7e993-012d-4e64-4a5b-08debaf6f0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 2gxFw4NLKvQfE6kRT2mvSc0WinNVJNyWSClLXQzoLR8zSu8yee+r9rkKrPLeMU0meiEuD7wDfGOaaR47SZ7h+4MhVZ4p7ac9kNl/ajPORWpBS4vnAW6kW1BRpKE4UGMunnFrCGvtZ43Jh/AQXPNYs4MAKs4Kqa/a0X70nEQm64cabtz1P+TQzfLtbvt1W/J3YgKWtRwaeDIwtmmKMchFuYKkZk22i2iJoS0znl65ynyMkiejIdogeuNACQIgEMcNHMbjqsaQcXZ6rjXLxy65znaZ929+YsoRNfnRW2RSGArVE9JuzMkmD3YmMKG+m2hYSfMIBioM5yfNQG1u3LJMmk/j/Z1EkDdq400bREKHAebKqUrpF61oh/QGMKjc2Pub0FL1OKeo3uG/0T9EHAdNvwlzCCVh/SUOBge9c6TE7jU74MwWJFnMOYe3gwZ7Vdc6OdsRbxCOfUW7R4BDZF0x1SnJbCnco51XtnyQFXVZ90u45oG47EFKs9yh2Vzo0vJo0TMdI9wuLq2imQYQ2GFcgZvSEuY0KmkHwoW4cxdw2WAzE2F1XjdX9LqqIZwdrifQQQr92+Jm/fwD4vrr2PaVUCfmydSqdAnU3DUtVs+ilzLBjkAUjaJAdFrqCeaurpBE273WxaTP70XF+QnyK8O5J1XrDkjky+4Z1vCXiq7uqc0A9ulohJhBz7fGLslIw9QuaTx4bGq8FKb+UYTQW0mQBG/9CmgZijHo0T2SmYX/oT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3jRRlyqCD2bA//zE5wSBLSMZsJ8THsm43AEpjtvrfKsRoprY4HXXk1xHDHcNUWn7V7TFaRJkts3fB5N33xUGNbk4kWEujMtwPU6guYFWN1I0PWMrx7+X7Qhn3Z9VBUueqkAvKZB77zw4CfSrHZPvGCLWMod961wGwBukblSAjEq5uES90l+QDoBsUKnxi1wYJWX2cKDkrV+NVPUVXmD8vPZnGOgWMLQPfLBaRaQBz7gGrDZtd1XtL9T7PL+vONF7oowrvy4UTOHabC9zfQwHfsAO1R2qMrMKHuumH1ype5QiZnKjp6uzbxTCXp8H/ZfO40pXSZjktwC3ZX6qFmc1ADpqBisl6jZiyyy46RF9cC9vEuRjcZS5vzp2J2whK+bwWVGunXbyW4YNq/P9cBYolhWmaMD0ovXMQ5aifMTu9WhJAinbU831TOo2kb0AQpm5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:18:09.5514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e7e993-012d-4e64-4a5b-08debaf6f0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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

[Why & How]
Add 8 more KUnit tests:

- dm_ism_get_idle_allow_delay: add a case where filter_entry_count
  exceeds filter_history_size, exercising the max() branch in the
  history_size calculation.
- amdgpu_dm_ism_init: verify all fields are initialised to
  expected values after construction.
- amdgpu_dm_ism_fini: smoke-test cancellation of never-scheduled
  delayed work items paired with a preceding init.
- dm_ism_set_last_idle_ts: verify last_idle_timestamp_ns is
  updated to at least the value captured before the call.
- dm_ism_insert_record: verify index increment and duration
  calculation; verify out-of-bounds index wraps to slot 0.
- dm_ism_trigger_event: verify current_state and previous_state
  are updated on a valid transition and left unchanged on an
  invalid one.

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 215 ++++++++++++++++++
 3 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 06594fbfceee..0a010802540d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -230,7 +230,8 @@ EXPORT_IF_KUNIT(dm_ism_get_idle_allow_delay);
  * dm_ism_insert_record - Insert a record into the circular history buffer
  * @ism: ISM instance
  */
-static void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
+STATIC_IFN_KUNIT
+void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 {
 	struct amdgpu_dm_ism_record *record;
 
@@ -245,15 +246,19 @@ static void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 	record->duration_ns =
 		record->timestamp_ns - ism->last_idle_timestamp_ns;
 }
+EXPORT_IF_KUNIT(dm_ism_insert_record);
 
 
-static void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
+STATIC_IFN_KUNIT
+void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
 {
 	ism->last_idle_timestamp_ns = ktime_get_ns();
 }
+EXPORT_IF_KUNIT(dm_ism_set_last_idle_ts);
 
 
-static bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
+STATIC_IFN_KUNIT
+bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
 				 enum amdgpu_dm_ism_event event)
 {
 	enum amdgpu_dm_ism_state next_state;
@@ -268,6 +273,7 @@ static bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
 
 	return gotNextState;
 }
+EXPORT_IF_KUNIT(dm_ism_trigger_event);
 
 
 static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
index 72e2dac49e55..da3e192e8d25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -157,6 +157,10 @@ uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
 			      const struct dc_stream_state *stream);
 uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
 				     const struct dc_stream_state *stream);
+void dm_ism_insert_record(struct amdgpu_dm_ism *ism);
+void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism);
+bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
+			  enum amdgpu_dm_ism_event event);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index e761105e1995..c333dab40959 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -579,6 +579,208 @@ static void dm_test_ism_idle_delay_mixed_durations(struct kunit *test)
 			(uint64_t)0);
 }
 
+/**
+ * dm_test_ism_idle_delay_entry_count_exceeds_history_size - entry_count > history_size sets delay
+ * @test: KUnit test context
+ */
+static void dm_test_ism_idle_delay_entry_count_exceeds_history_size(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t one_frame_ns, expected;
+
+	/*
+	 * filter_entry_count (5) > filter_history_size (3), so history_size
+	 * is determined by filter_entry_count via max(). All 5 records are
+	 * short idles, triggering the delay.
+	 */
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL,
+				 1485000);
+
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 5;
+	ism->config.filter_history_size = 3;
+	ism->config.activation_num_delay_frames = 10;
+	ism->config.filter_old_history_threshold = 0;
+
+	for (int i = 0; i < 5; i++) {
+		ism->records[i].duration_ns = one_frame_ns;
+		ism->records[i].timestamp_ns = 0;
+	}
+	ism->next_record_idx = 5;
+
+	expected = 10 * one_frame_ns;
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream), expected);
+}
+
+/* ===== Tests for amdgpu_dm_ism_init ===== */
+
+/**
+ * dm_test_ism_init_sets_initial_state - all ISM fields initialized to expected values
+ * @test: KUnit test context
+ */
+static void dm_test_ism_init_sets_initial_state(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 5,
+		.filter_entry_count = 3,
+		.activation_num_delay_frames = 10,
+		.filter_history_size = 8,
+		.filter_old_history_threshold = 20,
+		.sso_num_frames = 2,
+	};
+
+	amdgpu_dm_ism_init(ism, &config);
+
+	KUNIT_EXPECT_EQ(test, (int)ism->current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+	KUNIT_EXPECT_EQ(test, (int)ism->previous_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+	KUNIT_EXPECT_EQ(test, ism->next_record_idx, 0);
+	KUNIT_EXPECT_EQ(test, ism->last_idle_timestamp_ns, (uint64_t)0);
+	KUNIT_EXPECT_EQ(test, ism->config.filter_num_frames,
+			config.filter_num_frames);
+	KUNIT_EXPECT_EQ(test, ism->config.filter_entry_count,
+			config.filter_entry_count);
+	KUNIT_EXPECT_EQ(test, ism->config.activation_num_delay_frames,
+			config.activation_num_delay_frames);
+	KUNIT_EXPECT_EQ(test, ism->config.sso_num_frames, config.sso_num_frames);
+}
+
+/* ===== Tests for amdgpu_dm_ism_fini ===== */
+
+/**
+ * dm_test_ism_fini_after_init - fini cancels never-scheduled work without error
+ * @test: KUnit test context
+ */
+static void dm_test_ism_fini_after_init(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 5,
+		.filter_entry_count = 3,
+		.activation_num_delay_frames = 10,
+		.sso_num_frames = 2,
+	};
+
+	amdgpu_dm_ism_init(ism, &config);
+	/* Work was never scheduled; cancel_delayed_work_sync is a no-op. */
+	amdgpu_dm_ism_fini(ism);
+
+	/* FSM state is untouched by fini */
+	KUNIT_EXPECT_EQ(test, (int)ism->current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
+/* ===== Tests for dm_ism_set_last_idle_ts ===== */
+
+/**
+ * dm_test_ism_set_last_idle_ts_updates_timestamp - last_idle_timestamp_ns updated to current time
+ * @test: KUnit test context
+ */
+static void dm_test_ism_set_last_idle_ts_updates_timestamp(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	uint64_t before;
+
+	ism->last_idle_timestamp_ns = 0;
+	before = ktime_get_ns();
+	dm_ism_set_last_idle_ts(ism);
+
+	KUNIT_EXPECT_GE(test, ism->last_idle_timestamp_ns, before);
+}
+
+/* ===== Tests for dm_ism_insert_record ===== */
+
+/**
+ * dm_test_ism_insert_record_basic - record inserted with correct index and duration
+ * @test: KUnit test context
+ */
+static void dm_test_ism_insert_record_basic(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+
+	ism->last_idle_timestamp_ns = 0;
+	ism->next_record_idx = 0;
+
+	dm_ism_insert_record(ism);
+
+	KUNIT_EXPECT_EQ(test, ism->next_record_idx, 1);
+	KUNIT_EXPECT_GT(test, ism->records[0].timestamp_ns, (uint64_t)0);
+	/* duration = timestamp - last_idle_timestamp_ns (0) */
+	KUNIT_EXPECT_EQ(test, ism->records[0].duration_ns,
+			ism->records[0].timestamp_ns);
+}
+
+/**
+ * dm_test_ism_insert_record_wraps_around - out-of-bounds index wraps to slot 0
+ * @test: KUnit test context
+ */
+static void dm_test_ism_insert_record_wraps_around(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+
+	ism->last_idle_timestamp_ns = 0;
+	/* Out-of-bounds index triggers reset to 0 */
+	ism->next_record_idx = AMDGPU_DM_IDLE_HIST_LEN;
+
+	dm_ism_insert_record(ism);
+
+	KUNIT_EXPECT_EQ(test, ism->next_record_idx, 1);
+	KUNIT_EXPECT_GT(test, ism->records[0].timestamp_ns, (uint64_t)0);
+}
+
+/* ===== Tests for dm_ism_trigger_event ===== */
+
+/**
+ * dm_test_ism_trigger_event_valid_transition - valid event advances current and previous state
+ * @test: KUnit test context
+ */
+static void dm_test_ism_trigger_event_valid_transition(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	bool ok;
+
+	ism->current_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+	ism->previous_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+
+	ok = dm_ism_trigger_event(ism, DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)ism->current_state,
+			(int)DM_ISM_STATE_HYSTERESIS_WAITING);
+	KUNIT_EXPECT_EQ(test, (int)ism->previous_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
+/**
+ * dm_test_ism_trigger_event_invalid_transition - invalid event leaves state unchanged
+ * @test: KUnit test context
+ */
+static void dm_test_ism_trigger_event_invalid_transition(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	bool ok;
+
+	ism->current_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+	ism->previous_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+
+	/* EXIT_IDLE_REQUESTED is not valid from FULL_POWER_RUNNING */
+	ok = dm_ism_trigger_event(ism, DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+
+	KUNIT_EXPECT_FALSE(test, ok);
+	/* State must remain unchanged on invalid transition */
+	KUNIT_EXPECT_EQ(test, (int)ism->current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+	KUNIT_EXPECT_EQ(test, (int)ism->previous_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
 static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_next_state — FULL_POWER_RUNNING */
 	KUNIT_CASE(dm_test_ism_next_state_running_enter_idle),
@@ -621,6 +823,19 @@ static struct kunit_case dm_ism_test_cases[] = {
 	KUNIT_CASE(dm_test_ism_idle_delay_wraps_around_buffer),
 	KUNIT_CASE(dm_test_ism_idle_delay_old_history_cutoff),
 	KUNIT_CASE(dm_test_ism_idle_delay_mixed_durations),
+	KUNIT_CASE(dm_test_ism_idle_delay_entry_count_exceeds_history_size),
+	/* amdgpu_dm_ism_init */
+	KUNIT_CASE(dm_test_ism_init_sets_initial_state),
+	/* amdgpu_dm_ism_fini */
+	KUNIT_CASE(dm_test_ism_fini_after_init),
+	/* dm_ism_set_last_idle_ts */
+	KUNIT_CASE(dm_test_ism_set_last_idle_ts_updates_timestamp),
+	/* dm_ism_insert_record */
+	KUNIT_CASE(dm_test_ism_insert_record_basic),
+	KUNIT_CASE(dm_test_ism_insert_record_wraps_around),
+	/* dm_ism_trigger_event */
+	KUNIT_CASE(dm_test_ism_trigger_event_valid_transition),
+	KUNIT_CASE(dm_test_ism_trigger_event_invalid_transition),
 	{}
 };
 
-- 
2.43.0


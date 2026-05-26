Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEFFCD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A9510E4FF;
	Tue, 26 May 2026 07:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qiq8u6Q+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0566D10E4FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBe8yhEnVonpOqwEbO1spZKzmcXJZbwr0kl+w1ZpuR3WTJ6aI0Hbb26gCnC/l8fTgviPJvL0dMXKG3JQ+Hz8Tn1kABZRgr+UK8x8gqO2TOTxiCrgnixzlPJuBU8jRexPBHxmomWJq6V8/jlB0noldStD0tnFNCxAtLDO+78s9PaQ636pXuioh1zXWa80/o8KDC5avjHp9tOE/H8WS5o4ZeYaZVCwdwTVMaRXQrht/U5lozCorFOrvwOXSPAQDLxRXJ6rDP5fjUvOoX3R6EVFGE/OHRKT5D5k9arXlEP1AeHcJIQ4vIlgFEPATgiSkTLkBi9wBU5pcd8dDCRySxhfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKMW9LffiuDiYWfU7fgjphqybuaGwyscY4e09FYTZVU=;
 b=iR+DU7WoLHRZXx6HZ5hvvSGI6q72hDN4bpXOXhyvzgXPwC4GiDNe9jCQIzfWLhbswSAfTafJf/NPhVRFJelUt8qwX7tYxT+yLU2l7OU8/+fo7SFQJKnC83QLlRSBzaqT4k62W4RL9mSuLhhY89yrIc6V2BXNtHJTvi8mz5+CmJ4sujUdwF2mSHH0LREV9aG398j+/RO9/MEOFIf6BrqzkDsjaA9vLcXjJnt66muEiKu/ylWc8FCtX00DMtFnvYqQdwR92sF6IK+0HXkmvgrrvrxGLJnx/0UUlMkmMppv9+M/Ma4+5WimqWvuolTxC1AqbJwzBoGV5LZNkz5HkKV9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKMW9LffiuDiYWfU7fgjphqybuaGwyscY4e09FYTZVU=;
 b=Qiq8u6Q+mkykjALLid0RpRrSsXJKV5SX16wLgZZ04uQxBi2ulK+9C9gX3zvQRLK5f0fMr2Qx0zyb8NNuXcO5B3Yew0poS+I7ahF8iUPXLiIiyHBmsBFZQG3cCAtQ/Qwk4cyYLauvT7Q3i0q20hj0I49i6bICTWY9GULlz9Gw+1U=
Received: from DS7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::26) by
 LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:18:26 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::32) by DS7P222CA0017.outlook.office365.com
 (2603:10b6:8:2e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:18:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:18:25 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:18:16 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 28/41] drm/amd/display: Add KUnit tests for
 dm_ism_dispatch_next_event
Date: Tue, 26 May 2026 15:01:51 +0800
Message-ID: <20260526071413.2181251-29-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 311ce10e-a324-4712-ffa8-08debaf6fa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|6133799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: itc9+J9TIckIixZe7V2oksgLH4POrWlxTdZhgQvrCt9K7a3wnRkPbSvXS+s+AeBUIUX6L0fryynBPfssxlG6/q0Ndjt1gLktzcEgy16tNmPIzqiHdEteHfT/lP0Ny1AzLTHYovPUIo4pMfmYvkMh8XAm819qJHaemjx7V+DvdHr9BydLovsmx+9Zw5mvyrCvdLfI6y3g6iLLJDF2KfNWmcN3z193Zrh/EKj/DDA/Nh5x9fLwjCvuZLN3aKs45DY+K/ELmJI/7ljPL2CRpVBle6N3leF1dmSRCwHWWlBks8IJWPOm5em0g/pg64Knrj2SstVRRHFuw9KxiczP4MOWKaBO+lugONsDExWUPy+emxqqM9/StWGAZKwSmXn/jAFwM/DqYPLkfCxPOr1UCzJ2cpJ9VuXcvfxwMxFK6Up5J0PWYuP/AufYSmbiSTaQQCNXeoiAL6bGmrKnG/7aVrGEM1KzwXKYAQKxp0VWaMVldPmvJXBDvjxe/x9PLaZx7y6iKS7j3hjpP2Tfe7l1BHy6YewagY/EDIfWhWCTJipmXl8QURddZQr1ecOe7ThKAcxEyC2adxsEi3jWYUUmaviAZtDDtQN2aBr7gsfG7RJMCanIa6Jm+u+WwX48fjxctZhAWxR3WV8MLNLlS3Mbhqm5vjbGbHub59WFh0ApYcfszplWHnqpr2JcwvlJj/u/8a5DSVm56NcNrbYdVZogykJNX3m0WWts93KaTbAyz9dnQoo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m3x0M0rsaueLi4G67GsWEBO1ury8wP6IxXQ4GgwGNL4v3QOdV2c9id0XscwTEaN4EOqIulx2vlCwEkDiTqv5MwE2KFW5Fkom4bmw1gxn2ObsZiO8EzTg8ockIfkrj5Bpav5Lro+pEmLKj51pZEjkvTy8YgqH7GCFrvhtsO+gFgsMjEGAygth0UuEjdCs+uunp+ye/5syOAmNzL/nDvYKjzpBhQY+7IWawUgoJiZEdWzUMaKydcUbAjrwJmvi0h37Z3+GVkfgJe5+FnAXTTA0T9c7OjYDe2c8OehxJyeDxBW/pKHJTc0MvwV8a3XWp3+bfq8u45WdVgqjoOZlUS3y1Nn/68AecFuFJYtYGEth43hGTJqxJFt2UZb2i74iOp0A+xfiX4L1RCZXHaT/ueuV6JswC44V2BmcG6I95xljnlW4ug/egL5IvGRIcei5mk3Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:18:25.8089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311ce10e-a324-4712-ffa8-08debaf6fa66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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
Add 6 KUnit test cases exercising the new helper:

- hyst_wait_no_delay: HYSTERESIS_WAITING + delay_ns==0
  returns IMMEDIATE (covers null stream / no hysteresis config).
- hyst_wait_with_delay: HYSTERESIS_WAITING + delay_ns>0
  returns DM_ISM_NUM_EVENTS (timer scheduled, no immediate event).
- opt_idle_no_sso_delay: OPTIMIZED_IDLE + sso_delay_ns==0
  returns IMMEDIATE (skip SSO, transition immediately).
- opt_idle_with_sso_delay: OPTIMIZED_IDLE + sso_delay_ns>0
  returns DM_ISM_NUM_EVENTS (SSO timer scheduled).
- timer_aborted: TIMER_ABORTED always returns IMMEDIATE
  regardless of delay values.
- no_action_state: all other states return DM_ISM_NUM_EVENTS.

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index c333dab40959..f3b3f77aafd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -781,6 +781,86 @@ static void dm_test_ism_trigger_event_invalid_transition(struct kunit *test)
 			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
 }
 
+/* ===== Tests for dm_ism_dispatch_next_event ===== */
+
+/**
+ * dm_test_dispatch_next_event_hyst_wait_no_delay - zero delay_ns: IMMEDIATE in HYSTERESIS_WAITING
+ * @test: KUnit test context
+ */
+static void dm_test_dispatch_next_event_hyst_wait_no_delay(struct kunit *test)
+{
+	enum amdgpu_dm_ism_event result;
+
+	result = dm_ism_dispatch_next_event(DM_ISM_STATE_HYSTERESIS_WAITING,
+					    0, 0);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)DM_ISM_EVENT_IMMEDIATE);
+}
+
+/**
+ * dm_test_dispatch_next_event_hyst_wait_with_delay - delay_ns > 0, no IMMEDIATE event returned
+ * @test: KUnit test context
+ */
+static void dm_test_dispatch_next_event_hyst_wait_with_delay(struct kunit *test)
+{
+	enum amdgpu_dm_ism_event result;
+
+	result = dm_ism_dispatch_next_event(DM_ISM_STATE_HYSTERESIS_WAITING,
+					    1000000, 0);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)DM_ISM_NUM_EVENTS);
+}
+
+/**
+ * dm_test_dispatch_next_event_opt_idle_no_sso_delay - sso_delay_ns == 0 triggers IMMEDIATE event
+ * @test: KUnit test context
+ */
+static void dm_test_dispatch_next_event_opt_idle_no_sso_delay(struct kunit *test)
+{
+	enum amdgpu_dm_ism_event result;
+
+	result = dm_ism_dispatch_next_event(DM_ISM_STATE_OPTIMIZED_IDLE,
+					    0, 0);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)DM_ISM_EVENT_IMMEDIATE);
+}
+
+/**
+ * dm_test_dispatch_next_event_opt_idle_with_sso_delay - sso_delay_ns > 0, SSO timer, no IMMEDIATE
+ * @test: KUnit test context
+ */
+static void dm_test_dispatch_next_event_opt_idle_with_sso_delay(struct kunit *test)
+{
+	enum amdgpu_dm_ism_event result;
+
+	result = dm_ism_dispatch_next_event(DM_ISM_STATE_OPTIMIZED_IDLE,
+					    0, 1000000);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)DM_ISM_NUM_EVENTS);
+}
+
+/**
+ * dm_test_dispatch_next_event_timer_aborted - TIMER_ABORTED always returns IMMEDIATE
+ * @test: KUnit test context
+ */
+static void dm_test_dispatch_next_event_timer_aborted(struct kunit *test)
+{
+	enum amdgpu_dm_ism_event result;
+
+	result = dm_ism_dispatch_next_event(DM_ISM_STATE_TIMER_ABORTED,
+					    0, 0);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)DM_ISM_EVENT_IMMEDIATE);
+}
+
+/**
+ * dm_test_dispatch_next_event_no_action_state - other states return DM_ISM_NUM_EVENTS
+ * @test: KUnit test context
+ */
+static void dm_test_dispatch_next_event_no_action_state(struct kunit *test)
+{
+	enum amdgpu_dm_ism_event result;
+
+	result = dm_ism_dispatch_next_event(DM_ISM_STATE_FULL_POWER_RUNNING,
+					    0, 0);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)DM_ISM_NUM_EVENTS);
+}
+
 static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_next_state — FULL_POWER_RUNNING */
 	KUNIT_CASE(dm_test_ism_next_state_running_enter_idle),
@@ -836,6 +916,13 @@ static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_trigger_event */
 	KUNIT_CASE(dm_test_ism_trigger_event_valid_transition),
 	KUNIT_CASE(dm_test_ism_trigger_event_invalid_transition),
+	/* dm_ism_dispatch_next_event */
+	KUNIT_CASE(dm_test_dispatch_next_event_hyst_wait_no_delay),
+	KUNIT_CASE(dm_test_dispatch_next_event_hyst_wait_with_delay),
+	KUNIT_CASE(dm_test_dispatch_next_event_opt_idle_no_sso_delay),
+	KUNIT_CASE(dm_test_dispatch_next_event_opt_idle_with_sso_delay),
+	KUNIT_CASE(dm_test_dispatch_next_event_timer_aborted),
+	KUNIT_CASE(dm_test_dispatch_next_event_no_action_state),
 	{}
 };
 
-- 
2.43.0


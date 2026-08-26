Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41208C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B757E10EE30;
	Wed, 26 Aug 2026 23:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEhzsbr5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A6F10EE30
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8oHWgaDpy1B1KEM+I3HO2IWa0+0cAfWDHZlgwpBqz/c5WPHL8j6NDUTN6etY7jFLVSy5RqhYuwJdFhRUkfvZckaL7dorW2tLg+WPs0hUM42FGX4rI4ftbrdMzXITofhbZlOl73cqsKJW6RfWhJUEi3MkpeRn8MLavmw7x2JpiikmUB+dSzYDaDZywltoydm4TclnRDdGXjGcapCQL8UByXQmO3nWnYhMdNhvJ6UwDu2h+McSFS4zbxPG9fl8j7OXhpdd72N/tw3OvLlQrminfLpFLrnNoi2e/gw6fE3+EcHSV2yVfU4VxW0AWOektihB4BpELyofxrFh5VYCEXDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDjv8deVBq5QmXqAOSqQ+rXCyHIaddS2rzjIUHuRxPI=;
 b=kEoU+bbHnrKcT3jd8uhIKLq3AZZdbgTF/GpCfYwICBWkKTOhJP3CAQrFr0z7X5Vt2oIpzIxMbx01Ush/VfHVosXNhkAXvjMO3YjlaiotHSTXCsdmZaWZRoWwAApeq0A2artQeznuQKW2Qji8JZf/P0CQynTxYNV5jBR7JCOiQhU8wL1c1Z9Yo+dYGWnHdGqZDBjsSbYu36t0wGA68GITRzsyLwlufm+NhxofpjNQSF9iDxaFc7VfmRQmUQB3Rz9X0TXMvXd+WeGF+bvUgloelmDtojPPaqt3F+G1GAtdGeyg0jgpx4HSpjo+kbMJO63vmiT2rX6tNeOIPllgRBP5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDjv8deVBq5QmXqAOSqQ+rXCyHIaddS2rzjIUHuRxPI=;
 b=kEhzsbr5M3M/pd9K2NJcCkS9QprfzvmgBL6RlO5bLhvfB5RTGJYU8fg7EglwTzzaoHbgDakMTM1RUqz6aiOQjtK2pN2Ykw1HyXnSFXwCRd6hZxvYEmUYdOpsHoqtJJbu0vp1SQqb5ilp6ErA+nELJ3O7287gLDzsZ5PN7DmN9QQ=
Received: from DS2PEPF00004556.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::510) by SJ0PR12MB7083.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 23:16:52 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:92f::1006:0:6) by DS2PEPF00004556.outlook.office365.com
 (2603:10b6:f:fc00::510) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:16:50 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:16:45 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 03/59] drm/amd/display: Test ISM idle exit arms
Date: Wed, 26 Aug 2026 17:04:34 -0600
Message-ID: <20260826231519.881949-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: cad42743-9227-46a7-63d6-08df03c81c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|10067099003|18002099003|22082099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: OjlahdB1qzHIHk/1DtcP+4iTFXf/agFDnO9apS4h+0PQBDMgJYWCSEsOGZqrwvc9ylDkiP8yBgfiMok9Kolq54e93rv15M+bVfeNLRge8m9gUWp4BlvHch8ZisecTDmSHLc5GVKFq18LnQX/aeKR5Yh5HwkyHb9JmNIyghdLQFys+cO0llvIb+/qQcJfpwd/btKc/B9pUFDVdSEogBB/P7JGUUA/E1uduNcK7rtVuVdbZPHsrJffykvpoMTbweRddGcYkKaZCGDIRafPwHNHgXDFuc0aFb6p2iBBDoq5BUXYz+3i8I51edmuSCopbhMffkpcE291ZBr1llntSoVVau0oUzDXDuZ+/KJgh0UcECfyE0SXjwJg0N9fpvaZfTBEdfHSpOA+muBT8ewPFTHTMexwXBvSulrnQQt1JAbs9Z7CIp39PyLdjVbnTt4eNf7exHebmyOEAtZYy+KtAiK66PuITEjY1xwwHmy+7rA2qfRqehuD0ZdyU6gIkBvk9AXJiuJDo6kWToRzagc3u6oFFVQyDlYxoMNVj7WcEAeE2NNlLRPTI6fLpt6NKPDHeoHqLD/pn9n05BT9Mw6JUbngflN5M/6EXY9T3tHiT9d9OSKltF/LmHoxYlZ/P3yeg4h8dl2nlMsXj9htOCqLWtkjknQjMn9WWGNgD/JrfBzd9rTOOauj2rRD94MPIgsua1fV4p3V3WWvDK4ctLNQlGdPMw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IBbnNLP7LfILSrA0jIaeJQQARMtwIaUKruaaJztzQ1/gtwsQJtb1Kj4ryykA1YutZ2+iRdPrFwQFXhiS+okqYLkzL+295ClABbFdEkT4C+IbrLlStoB6VyBI7BFybf1QjAdsbJk647reeM5Wg7k4UVsELm/OC/iZBat7fv7UTMmCzXG8z1DHtNpWKxn77XkET7SotPJHCUwqyKl4TphF5n0n/cwISO7MRAcuSc1FyD1eiipp8KaKQ5eKaPsgjFdcFrlNx4ohVXM2xieYwIuiQOwekoYrntSe9VBeZ+8miaRuLmv/0dQhBj26HsV49AD8shJ6odqvJMWyQtwwQbeAfF5QcRDlkJ6dO+/0KR6DCZL9Gz+D/gQjoujd9wbNtkEoEz/8T6u1N3BNP5Ou9AW/aVtLLfisf0y1UW8FI6ySWppfSoFmd/F93yLmVDzJtsxV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:16:50.9165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad42743-9227-46a7-63d6-08df03c81c1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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

[WHAT]
Add KUnit tests for the OPTIMIZED_IDLE and OPTIMIZED_IDLE_SSO
previous-state arms of dm_ism_dispatch_power_state().

[HOW]
Cascade into each idle state, post EXIT_IDLE_REQUESTED, then check
that idle is disallowed and the idle period recorded.

These arms run on a state departure rather than on entry, so a single
event cannot reach them; the FSM has to occupy the idle state first.
Driving both steps through amdgpu_dm_ism_commit_event() keeps the test
on the real path instead of calling the dispatcher directly.

Both arms end in FULL_POWER_RUNNING and both disallow idle, so the
state alone does not tell them apart. Asserting ism->next_record_idx
pins the side effect that matters: the idle period is added to the
hysteresis history on the way out.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index 5b348ded482f..76c2004224b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -1374,6 +1374,87 @@ static void dm_test_ism_commit_disallows_idle_on_timer_aborted(struct kunit *tes
 	amdgpu_dm_ism_fini(&acrtc->ism);
 }
 
+/**
+ * dm_test_ism_exit_from_optimized_idle_disallows_idle - leaving OPTIMIZED_IDLE
+ * @test: KUnit test context
+ *
+ * EXIT_IDLE_REQUESTED from OPTIMIZED_IDLE runs the previous-state arm of
+ * dm_ism_dispatch_power_state(): the pending SSO worker is cancelled, the idle
+ * period is recorded and the commit runs with vblank_enabled = true, which
+ * disallows idle again.
+ */
+static void dm_test_ism_exit_from_optimized_idle_disallows_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 0,
+		.sso_num_frames = 2,
+	};
+
+	setup_commit_test(test, acrtc, &config);
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_OPTIMIZED_IDLE);
+
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+		/* Allow on entry, disallow on exit. */
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 2);
+		KUNIT_EXPECT_FALSE(test, dm_ism_test_idle.last_allow);
+		KUNIT_EXPECT_FALSE(test, adev->dm.dc->idle_optimizations_allowed);
+		/* The idle period was recorded on the way out. */
+		KUNIT_EXPECT_EQ(test, acrtc->ism.next_record_idx, 1);
+	}
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_exit_from_sso_disallows_idle - leaving OPTIMIZED_IDLE_SSO
+ * @test: KUnit test context
+ *
+ * EXIT_IDLE_REQUESTED from OPTIMIZED_IDLE_SSO runs the SSO previous-state arm:
+ * the idle period is recorded and the commit disallows idle. Unlike the
+ * OPTIMIZED_IDLE arm there is no pending SSO worker left to cancel.
+ */
+static void dm_test_ism_exit_from_sso_disallows_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 0,
+		.sso_num_frames = 0,
+	};
+
+	setup_commit_test(test, acrtc, &config);
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_OPTIMIZED_IDLE_SSO);
+
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 2);
+		KUNIT_EXPECT_FALSE(test, dm_ism_test_idle.last_allow);
+		KUNIT_EXPECT_FALSE(test, adev->dm.dc->idle_optimizations_allowed);
+		KUNIT_EXPECT_EQ(test, acrtc->ism.next_record_idx, 1);
+	}
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
 static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_next_state — FULL_POWER_RUNNING */
 	KUNIT_CASE(dm_test_ism_next_state_running_enter_idle),
@@ -1451,6 +1532,9 @@ static struct kunit_case dm_ism_test_cases[] = {
 	KUNIT_CASE(dm_test_ism_commit_allows_idle_on_optimized_idle),
 	KUNIT_CASE(dm_test_ism_commit_enables_sso_on_optimized_idle_sso),
 	KUNIT_CASE(dm_test_ism_commit_disallows_idle_on_timer_aborted),
+	/* dm_ism_dispatch_power_state previous-state arms */
+	KUNIT_CASE(dm_test_ism_exit_from_optimized_idle_disallows_idle),
+	KUNIT_CASE(dm_test_ism_exit_from_sso_disallows_idle),
 	{}
 };
 
-- 
2.43.0


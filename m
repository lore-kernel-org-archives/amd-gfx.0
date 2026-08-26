Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6288FC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA25910EE31;
	Wed, 26 Aug 2026 23:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Ssdhrnw";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E099610EE31
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVZY0HOKxigjURrcNqYtOlY0CH6phQE3G076Uk4LeLrD51pRUDZ4ug+vbLhgkooDlOpBVk1UpMyVPUAfina8znT5NXeC+HvQ8bpYqfuquGiAMTOrlLUzu8FbwAGge4eCO1xLY5lpQJdUIUHTnQEjElOi5ZooOmT99X+fd18Lk8OXCLklzaTKDK+Lzx8S1noK6V3VEImgc/Lf/xBfhSXgeAp5XWzlklhvTEeUlGRoPtpgqsyAskxP2Ib0SSEBQUyclwhNq3XU3RhNbZ0q29J82IP4X4Va+k96qjcr4tYFQp2ckYUKMVuV24Ne88YAsT8f5c3EMsSrqH7+VTv0+JcgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr5CSZJDRz5MqeHDZfjDAyZQnl2hqWTHuI4k/iUGdBI=;
 b=SR4KCKd4OTSGQNUOp2LDSInSGW+MUvsDK5kCpsBqmkUzDAKMMFmdZbydDFzWeZou6oN1Pv5tiMI7dOvb7CRG6/Bfvj23dZ57rsj8Y6WntWirCGHw0ml3J3GHtAsmDOf0v1HabmzJNMB4zuTUZdgRJzRQMzd6eORSgb78orhEOMi1GjoSMwrCOEYKJonoMRJK2adZyLmlH3iO5rITNwctb8xkKGIU3O/zu/EvlskBtYAVD9X0VTkXuShM5/ISjMBHHBOJZNCrurlCIiZ43IabFdLCsrz9NLuBuBvXqJo10q5RK4ZGVnairNHO3viX8Msk3hYdrBbwdcusARd5L4nGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr5CSZJDRz5MqeHDZfjDAyZQnl2hqWTHuI4k/iUGdBI=;
 b=5SsdhrnwZ7KaTq+PW6QQsTinzClsHodYGRA7TUGbGgcg3ineKoOUDvP2c5yiDmeebXHmPIHKmm1zXVZ6eNRzUiz4K+oriDRDzma/LCT4egKW8iREjfQ9oBaXSQ7bULO1wivyAccmzCpRRYqfj9aFyk7EjFSudqx/I9U8jukRVT4=
Received: from CY8P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::14)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:17:09 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::7e) by CY8P220CA0043.outlook.office365.com
 (2603:10b6:930:47::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:17:09 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:17:04 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 04/59] drm/amd/display: Test ISM delayed workers
Date: Wed, 26 Aug 2026 17:04:35 -0600
Message-ID: <20260826231519.881949-5-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a6dcb0-1631-4250-4a69-08df03c82706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: xhTr5w9ZGX6V7z9lxGxBbsFvs5VrOt4Tg9NXKoSgNZn0LGNO99JkZxrNI2juY0aPKFRrETggLb++7mhPEF4Oxx/04dyhflD4aUp4snzD2ZLsNFEuyLnAm7lgTRcNZOZYH3+M3rFMOmRE9C6vkc2bCFhH6Fcdwp3a9gv7NX4/C5iTQK6+RBtA6YXOxP0Qiqb+CIuSMEUjIwLEiogDczgOfU8m4TAVsProjOwA6PsJtRzkEN3jRd7H+ZgqrKuO+T61AWdy4es+kB9nWjodixjTWsMhckB2ea/bSv9R1rdveSmzVMdommUpIwuB5UQgcdLahauGh7mNc4xq0zveo7gLZ3vHKAgucJZKUqsbiK1RzZvNALJ5jjXYoKA2H0xqDMNhbHGNf56RdY0begQLO54EfSoM+T5yBLXXm/r6+vq9JJWzwGOzVQShEWJU3uRYNXwzZigmCQWAI9+rX19m64uqMiZl/0FHMzevoqolkdwJ1yQLPRARtH65Rj6aXcazj+7fu9k5Tg7UbKOnwmUWq0AkO+PzKb5FDJzwdZxwwfU/PKgckCH7iTvUOk35v1SXgvuNlYsdDLss18tZ4lNMsFwD6FlUbRkYZetsATOm42yfzq68QS46hk6/sNFgmP+YJC0PbpV8bKn0xVLyy3P7vDpqgdlpWmDT/qxqzSL2roFoI96FMacxEsT/bp0oR7S+4M30+wrUviSXazU+KtdUo/BzUw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GIa7PIEsWrItrhHMXm8nRE0xM4CEXX82CNdHsRYkq1W7jWYmCVZFWO2JS1M71eG4POVkeQ5He/QyTpl7nqc/0pN9tn95Dh73J7KnqJfzplvsY63EuRN4Bye429MnrF56quZzkfURiaoteJPm0BthCNHADsqYATAJzSsR405KuOkW3l8kVJdPMF6Fkpciy1U9aTCpMag2GXUjHB/tCBDerb8xu03RDC8Mfm2QNfvhhbmB4ExgCva4AOZTyRlrES7fG3n5qBZ/he/ngm63ApnrHC8/fzgkFMv/yLW6zzNlbmpDjKi6m/XwtEhqFXGqD8pg2CyjudJTAsX7JMIUyFVaOaf2Qh43dIcRrlV2/bsvdBwCJVkmWgFYCgO40zkR6POFZ0EhHd7000hqQ7fcIMlt4bIHB+NoqLcD07j8ZL5qqOpjd1I2T2/wZhTLL3jkbYCj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:17:09.2091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a6dcb0-1631-4250-4a69-08df03c82706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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
Add KUnit tests for dm_ism_delayed_work_func() and
dm_ism_sso_delayed_work_func().

[HOW]
Arm each worker through the FSM, drop dc_lock, then run the handler
with flush_delayed_work().

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index 76c2004224b8..b77df47d3095 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -1455,6 +1455,88 @@ static void dm_test_ism_exit_from_sso_disallows_idle(struct kunit *test)
 	amdgpu_dm_ism_fini(&acrtc->ism);
 }
 
+/**
+ * dm_test_ism_delayed_work_runs_timer_elapsed - hysteresis worker fires
+ * @test: KUnit test context
+ *
+ * A non-zero idle-allow delay parks the FSM in HYSTERESIS_WAITING and arms the
+ * hysteresis worker. Flushing it runs dm_ism_delayed_work_func(), which takes
+ * dc_lock itself and posts TIMER_ELAPSED, cascading to OPTIMIZED_IDLE_SSO
+ * because the SSO delay is zero. The flush must happen without dc_lock held.
+ */
+static void dm_test_ism_delayed_work_runs_timer_elapsed(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct dc_stream_state *stream;
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 5,
+		.filter_entry_count = 3,
+		.activation_num_delay_frames = 10,
+		.filter_history_size = 8,
+		.filter_old_history_threshold = 0,
+		.sso_num_frames = 0,
+	};
+
+	stream = setup_commit_test(test, acrtc, &config);
+	setup_idle_delay_history(&acrtc->ism, stream);
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_WAITING);
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 0);
+	}
+
+	flush_delayed_work(&acrtc->ism.delayed_work);
+
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_OPTIMIZED_IDLE_SSO);
+	KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 1);
+	KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_sso_delayed_work_runs_sso_elapsed - SSO worker fires
+ * @test: KUnit test context
+ *
+ * With sso_num_frames >= filter_num_frames the OPTIMIZED_IDLE arm allows idle
+ * and arms the SSO worker. Flushing it runs dm_ism_sso_delayed_work_func(),
+ * which posts SSO_TIMER_ELAPSED; engaging SSO disallows and re-allows idle, so
+ * two further transitions follow the initial allow.
+ */
+static void dm_test_ism_sso_delayed_work_runs_sso_elapsed(struct kunit *test)
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
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 1);
+	}
+
+	flush_delayed_work(&acrtc->ism.sso_delayed_work);
+
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_OPTIMIZED_IDLE_SSO);
+	KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 3);
+	KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
 static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_next_state — FULL_POWER_RUNNING */
 	KUNIT_CASE(dm_test_ism_next_state_running_enter_idle),
@@ -1535,6 +1617,9 @@ static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_dispatch_power_state previous-state arms */
 	KUNIT_CASE(dm_test_ism_exit_from_optimized_idle_disallows_idle),
 	KUNIT_CASE(dm_test_ism_exit_from_sso_disallows_idle),
+	/* dm_ism_delayed_work_func / dm_ism_sso_delayed_work_func */
+	KUNIT_CASE(dm_test_ism_delayed_work_runs_timer_elapsed),
+	KUNIT_CASE(dm_test_ism_sso_delayed_work_runs_sso_elapsed),
 	{}
 };
 
-- 
2.43.0


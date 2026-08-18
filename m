Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18BFC61CE0
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A5C10ECE7;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20AF0+lD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28CD10ECC0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5SRvrG1qrTxDy9PLiXjFR8EtG1lPFfiykeelfUTxa9vRfuQejN8WgJ5WQZ78ONtufb6ZTdQqy+eY9wAGvZ75sSGvf5d2kAKnTv/f1S9TxvvgEoJ7msWIinoTbCRl8O55743gEFMNn6k54P18Oj40e4Hyhz0X9PqGpvLnt+J44NNIkkyYB7F+coCH7F0D9KH5z3jNvLDT4XjCQ8V7Xi0ODeGrw35G9x2LR6Nv3kHihkoJZdAxSFaF7v0AzTCj4nK+CPKoJCTL1w8xX0NVjFf9hXrJZ/a8quaJmDHB7PvNJ++ZiOOZNzu9u6rRWBgcIY12jzswS0ibUS15Nfux9JgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxDpbat4aeFgGnksDLolT/r5ptwGBP9dANwxxqY7B10=;
 b=gbV/iasiffERpdeMuWH5St/nFOZnOEGJKHX5iumXME1fLx7b5YKUoMLXSWD47j7qLDFtycgVlr+57dGQhZQmC5vh2QtMdhDwDi3I7QOvESWIdf8UkQme3mG5Jmz9/N0R+33EMCsuO6NfT5/mGwyTO+FYplc9yn65tgOSFX6qHU/lsaw4ixUL+xxhqzz3c1BIeL2a0LPRIRP58D+UBAMSlNDPHMC62RLmJiM8uZOdWTBWYixBQjydY+38Q7c4mID8Bw9Vf8qLlBbpbYAw0jqImFxkTtAwafpW3DYsDx+vkwusj6tLmIJwTkVaUQrOcDUKzkh8tj391jQoL48JeZ+pQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxDpbat4aeFgGnksDLolT/r5ptwGBP9dANwxxqY7B10=;
 b=20AF0+lD+J0w3ZK+dBCdBpCVu7So1Bg7LpkwEK7Ibphwh4BBKko5GxIjJ8V1K9BMJ25BL+A+kEpfaoMWdmJ0tTRAFXbO6sjVKxwmuE+fZN7iWGwTIfUq9AO8GiFSlsAC0bP2JYlu3+jsi2Aosf5MiB6/9DMfc2NayONg4F06SFk=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:46 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::1d) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:42 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:41 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 65/82] drm/amd/display: Test handle_hpd_irq_helper detect and
 debounce exits
Date: Tue, 18 Aug 2026 16:15:57 -0400
Message-ID: <20260818202139.4172592-66-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 250b7288-0f64-41c6-77a4-08defd667735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|3023799007|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: QT96b0/WkeM0pZAQHUoihdPnRySHDTBr0wYVsz3Bx3jyPzU7qSrPUr4Aas1/NMix6lNYF7wB4Y1WeX1XcR1JQ0xrVEVpNCxafLfXKMXSGffgfAOLXCspudDy5ffeEf0Irj3JAE5HMsyBlS2dhMacHwwmt/H/6s3WxTmqM1y5yQYx2dHK5tRNBAphV1T9ozt0rdMaQpDZ+4QjVA4RG5e0ey7jd1ecjdVdQjur4D8aFuocd1GeSISLDaAdXL13jMVVxqc/o/fKOQte6DWQzaZZ75GLBsZdAFkG9AUAic9UcnWnKF7T2333rapLlPAsXaQJ9HNbn+AxtgSNdePOo6YOTdBeOUgK9b70Xn8hzToOqLhCUMmm73j77guGQ0JLKRf57FVk0CaETqjmcpgk+AYLnJjNCo7BNMIHt16bKFUGDI2j1Cly87Q2W2ZseqCPX3hmTKRAVOORU1YdsHF+A9raN8LOc3aFaFPL38b4Q55mHBTid/kikrKa9Bz3mfx7i80U9SGlw4i5TjjkRCDuTVEtdFokKSJHBR7KbWs5YeaW3xytDbr57YeIaSbmgCDF/iPpnax/T/h1//fzW3gPJMx+o3SGDeQ80t1CGGK7xTD0m2UZQPchMRb7DoavBXyIhGLEyyhz5gue37cRr0ZBZenvn2bU/+iB31YTEM0No+TtGsM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(3023799007)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S24gDkgHo1et4UXe1f5mGJgnvNSVrWG3EFuQgQOU1ccjbIxYdDQo4YQ/zCLmzb/2SnQY970bIIkfQQVqjys401f2vVeJo0QC/M0USYeYTNIuFEmrrJcqBfBCm/gwrDV5mKErP+PABl3lfYJU3BF5u5DSU+agGDXuXPvI6gl9d+QFP1STqsVIgN3EqFIykerlPtPVql0dPLt+P+ZB31XC5KvxA815m6ujYvsXzlbshltEmrcmcUAs91UJCqQNmJGboZijwsW4cQTOKNkIE8vxUMFlGTl5BFrP+K6vpcIift62Kg1Y1Bz3fAXHnKrWeVmg7t/F2x9FsaGqfQfs/oFfS4HBb4VCURI2tlU6SfV6wSBzitK4/GJlr+GV1tzOVZc5XlrIjZQGJn01jZnA3DS4LOkYTPiiYeCkcJjZsqesgRXrBNnFH35zq5SqVSBRamev
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:46.1123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b7288-0f64-41c6-77a4-08defd667735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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
Add KUnit tests for handle_hpd_irq_helper() covering a failing
dc_link_detect_connection_type() and the early return taken when a
debounce re-detect is already scheduled. Also arm the debounce work in
the stale-prev-sink test so mod_delayed_work() re-schedules.

[HOW]
Both build on dm_test_setup_hpd_irq_helper() and override only the
link_srv stubs they need. The pending-debounce test arms the work ten
seconds out and spies on dc_link_detect() to prove it was skipped.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index b398be878c932..c335ac0e2a6f5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -58,6 +58,17 @@ static bool dm_test_detect_link_false(struct dc_link *link,
 	return false;
 }
 
+/* Spy on dc_link_detect() to prove the debounce early-return skipped it. */
+static int dm_test_detect_link_count;
+
+static bool dm_test_detect_link_false_count(struct dc_link *link,
+					    enum dc_detect_reason reason)
+{
+	dm_test_detect_link_count++;
+
+	return false;
+}
+
 static bool dm_test_detect_connection_single(struct dc_link *link,
 					     enum dc_connection_type *type)
 {
@@ -66,6 +77,12 @@ static bool dm_test_detect_connection_single(struct dc_link *link,
 	return true;
 }
 
+static bool dm_test_detect_connection_fail(struct dc_link *link,
+					   enum dc_connection_type *type)
+{
+	return false;
+}
+
 /* Recording stubs for the dm_handle_hpd_rx_offload_work() DP-IRQ branches. */
 static int dm_test_automated_test_count;
 static int dm_test_handle_link_loss_count;
@@ -2607,6 +2624,9 @@ static void dm_test_handle_hpd_irq_helper_debounce_schedule(struct kunit *test)
  * When the debounce branch is taken and a stale hdmi_prev_sink is already
  * cached from a previous HPD, it must be released before caching the current
  * local_sink. This exercises the dc_sink_release() of the previous sink.
+ *
+ * An already-armed debounce work also makes mod_delayed_work() re-schedule
+ * rather than queue.
  */
 static void dm_test_handle_hpd_irq_helper_debounce_release_prev(struct kunit *test)
 {
@@ -2628,6 +2648,10 @@ static void dm_test_handle_hpd_irq_helper_debounce_release_prev(struct kunit *te
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn->hdmi_prev_sink);
 	KUNIT_ASSERT_PTR_NE(test, aconn->hdmi_prev_sink, link->local_sink);
 
+	KUNIT_ASSERT_TRUE(test,
+			  schedule_delayed_work(&aconn->hdmi_hpd_debounce_work,
+						10 * HZ));
+
 	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
 
 	/* Stale sink replaced by the current local_sink. */
@@ -2662,6 +2686,59 @@ static void dm_test_handle_hpd_irq_helper_detect_false(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
 }
 
+/**
+ * dm_test_handle_hpd_irq_helper_detect_type_fails - Test detect failure logging
+ * @test: The KUnit test context
+ *
+ * When dc_link_detect_connection_type() itself fails the helper logs an error
+ * and carries on with the connection type left as none, so it still falls
+ * through to the immediate-detect branch.
+ */
+static void dm_test_handle_hpd_irq_helper_detect_type_fails(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
+	link_srv->detect_connection_type = dm_test_detect_connection_fail;
+	link_srv->detect_link = dm_test_detect_link_false;
+	aconn->fake_enable = true;
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+
+	KUNIT_EXPECT_FALSE(test, aconn->fake_enable);
+}
+
+/**
+ * dm_test_handle_hpd_irq_helper_debounce_pending - Test pending-debounce exit
+ * @test: The KUnit test context
+ *
+ * A debounce re-detect that is already scheduled owns the connector state, so
+ * an HPD that would otherwise detect immediately must return early and leave
+ * dc_link_detect() untouched.
+ */
+static void dm_test_handle_hpd_irq_helper_debounce_pending(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+
+	dm_test_detect_link_count = 0;
+
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
+	link_srv->detect_link = dm_test_detect_link_false_count;
+
+	/* Arm the debounce work far enough out that it cannot run here. */
+	KUNIT_ASSERT_TRUE(test,
+			  schedule_delayed_work(&aconn->hdmi_hpd_debounce_work,
+						10 * HZ));
+
+	handle_hpd_irq_helper(aconn, DETECT_REASON_HPD);
+
+	KUNIT_EXPECT_EQ(test, dm_test_detect_link_count, 0);
+
+	cancel_delayed_work_sync(&aconn->hdmi_hpd_debounce_work);
+}
+
 /* Tests for handle_hpd_rx_irq()/schedule_hpd_rx_offload_work() */
 
 /**
@@ -4331,6 +4408,8 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_schedule),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_release_prev),
 	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_false),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_detect_type_fails),
+	KUNIT_CASE(dm_test_handle_hpd_irq_helper_debounce_pending),
 	/* handle_hpd_rx_irq/schedule_hpd_rx_offload_work */
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_disabled),
 	KUNIT_CASE(dm_test_handle_hpd_rx_irq_no_left_work),
-- 
2.43.0


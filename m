Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EEFC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5924010ECFD;
	Wed,  5 Aug 2026 06:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SrskFqgF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0DC10ECFD
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyBWcE63gm+a2vqCVr5qsR427SC1MVjssXimEkrL64kzMioX35MS8fHMNGyO7/bz1mWe6HFRvhh4TIenV1wvsHNOFegc99EuhfvKo9TEl8E6uukBJ109geCLFRlIJI3V3gXuhFfIjASDUqB13Uj6DSRRkZ5L7jBeInEEKZ7TUd9YX/ZspBtU1mv88DqM6/hAS3FhAIcjYrz/bdGYilftMzm+Rdl7tOFl+xD3BEomJS6PAYZGGMQNPWGpTZPnw/dGOdWOJGf60bBOPi+/cGQkuBUusxgrRm2CEQOmLRqhLGCZ2kWBWZeQccCCjHIaWDvF0LNDNnJzG3K8j87U2LVf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIrmbxk4nIY0bcgKDmgKCzZJKDDlBeYs4+R8kX07daY=;
 b=Ko+Hqc3MucMtrd+k/1D5k/mVUTwe/GuQG8Bv67fp+o6Y1skfsGLAlXNH8NdKzIQTSjul4s22mkIyHe9D+avCdRqIZ7abxpw4QU2iziB9Ny/JKnYHiINO7NLmrlAy3CLqDvThBqxL0Mx9RGxHS+wQKhBz7tqadNNH5Jm1o8q7bsCaag6s23vkt3bX2aWVNnve6MdtJs+IIvRN6pYLzvo59CEeGCXj+fYZcAKtWZPIE58btFqka1lozra8B83suED4yj2xF+ma2su7EDxcVixbkrxv3j68S/gfZoAz7JWB7VyjKCc/IDN3psYA81VuZAplBcyJ1sTbgOqX7q9pq2TYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIrmbxk4nIY0bcgKDmgKCzZJKDDlBeYs4+R8kX07daY=;
 b=SrskFqgFz0KSnnNzmB3t+nPEb0wtHyyGMJPRb4/rH9hreSGLaHDdvGrSlWUZ/RMlr6eTrmnMyJDKEeuyDsFXunB2vTjUFbapEJFFHlvhrnqjwsA4FY+NxQQXhPPYzDBC2sCtkBwX2X2PdK7sbyzCGERXHMVOh7gQ7Jxn96r3SZM=
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 06:40:23 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::9e) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:18 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:15 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 07/34] drm/amd/display: Add amdgpu_dm_crtc_late_register test
Date: Wed, 5 Aug 2026 14:36:19 +0800
Message-ID: <20260805063937.2145774-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ba447e-d8f7-4e53-08ba-08def2bc6d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: t4jfIxIiXAN7dMtsUE9S6UQzsYNI74SAffOrUK3YVIN2BclQUPYFKn1AEOn8oLftR1gxJ3pAzJ/gAqwaO9pBs+1CuTTv3mJjOYXZmyeW/Gt7P2oHyJ1lRovwPMeVc/EekoAxoZJXLkGlhxeZYHeYX3wUNr3n/Z6dNntdHEueJ48LSYRWUlEolunSHppnB9T0yEDgtWnr4ahcCsGfPM0TmlmKLgcBBYQb2JhiMcf8JnDRcTLdQFnKhCg7ycaJr9WYHVF2tdRbxmDU1kjTGEVufDFkj+Hq5ijRi1qVoSCHvtcjpDXlQaC8LMbHie+zpu6WIqlrhbjHTt8U6ZWROW3sgvOz0TTO53/nLJ5eYyepwB0Bq9EeftsWCIxbQH5l9A7qXHPwN6bQ7HnwYj88pg2HIY2w2qQqQNMvWBvCAKbbLaPKa2RIwaJPdnjpnrr1nu/owXzMsznRDmIPsd3cvoZzTizOI+f6UI7zHWIZtf4IZfZKQ2/CSgpd60c6wq+SbvasSdn41lv4lFq3AFmB72uqlZTZxlvqbcvNUk9Plg58ZiRTG6tq/xYRHejyc0btOb0jDceQlkuUxV01LgHt1zToD4BCIbzToc2NkZrI22JNn157/hFScGqjASTc5JYg2jn/v4q/yqlXT2JPu9KWvj0hkcs33ZIi63wS4R8kOaHVYaMj4hDr8ZRwOTFb0RJBTklq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SX82QeeGVat9+ZOB1sTuAhF+2CFIdKNN3OAnOs+9lUIBJLoZLSpxzjOn+84buC4k5K7Y3ncNMHDxi4kzOJvn79UHHziSJiGRbgoIBiIbgWZ6bUiiBC3inpTCXfX2XS+UuYKDWyyH5xPHB5dkb8TGP/z9BOuyxsKsbzH3U6FZON7GVwaBRkdZWQcPChZ0eTx4Xt/Zb+szg8rF0z4tvH/Vt5lVrkfLb0/keAOEJB2qlIEXhOt47F+haDI1knF1+PB52zAAzS4m1zkjLyzrTs8v59HCfqGrkl8d25Kooseiv+/atAKb71hILS1GuvUIERSWnMjyj67eMgzuvQu/4hCbk3WkgrR0+QSJ80jPolMzLWSBRkVCKA0aORC+4dUOp6QYNaqEFJdOKdcdFYVydxSGT8Vv5Eb4FmwZ0/Epj//dlnkNH3jOw62ikWWdLbg8/V+O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:23.3780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ba447e-d8f7-4e53-08ba-08def2bc6d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

why:
amdgpu_dm_crtc_late_register wires up the CRTC debugfs entries during
registration but had no coverage, leaving its single path untested.

how:
Expose amdgpu_dm_crtc_late_register for KUnit via STATIC_IFN_KUNIT and
EXPORT_IF_KUNIT (guarded by CONFIG_DEBUG_FS) and declare it in the KUnit
header block. Add dm_test_crtc_late_register_inits_debugfs, which gives
the CRTC a real debugfs parent, calls the callback, verifies it returns 0,
and tears down the debugfs directory.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |  3 ++
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 32 +++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 470abe9cc8f1..abe0769ed502 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -488,12 +488,13 @@ STATIC_IFN_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_reset_state);
 
 #ifdef CONFIG_DEBUG_FS
-static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
 {
 	crtc_debugfs_init(crtc);
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_late_register);
 #endif
 
 #ifdef AMD_PRIVATE_COLOR
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 06bb22d4c3b7..a2b105a496e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -56,6 +56,9 @@ void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 					      struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
 void amdgpu_dm_idle_worker(struct work_struct *work);
+#ifdef CONFIG_DEBUG_FS
+int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc);
+#endif
 #endif
 
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 430765dd87a3..7abd85be3019 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_vblank.h>
+#include <linux/debugfs.h>
 
 #include "dc.h"
 #include "inc/core_types.h"
@@ -1990,6 +1991,33 @@ static void dm_test_crtc_disable_vblank_queues_work(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 1);
 }
 
+#ifdef CONFIG_DEBUG_FS
+/**
+ * dm_test_crtc_late_register_inits_debugfs - Test late_register succeeds
+ * @test: The KUnit test context
+ *
+ * amdgpu_dm_crtc_late_register populates the CRTC's debugfs entries via
+ * crtc_debugfs_init and must return 0. Provide a debugfs parent so the
+ * helper attaches its files there, then tear it down.
+ */
+static void dm_test_crtc_late_register_inits_debugfs(struct kunit *test)
+{
+	struct drm_crtc *crtc;
+	int ret;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+
+	crtc->debugfs_entry = debugfs_create_dir("dm_test_crtc", NULL);
+
+	ret = amdgpu_dm_crtc_late_register(crtc);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	debugfs_remove_recursive(crtc->debugfs_entry);
+}
+#endif
+
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
@@ -2071,6 +2099,10 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_disable_vblank_no_irq_installed),
 	KUNIT_CASE(dm_test_crtc_disable_vblank_vrr),
 	KUNIT_CASE(dm_test_crtc_disable_vblank_queues_work),
+#ifdef CONFIG_DEBUG_FS
+	/* amdgpu_dm_crtc_late_register */
+	KUNIT_CASE(dm_test_crtc_late_register_inits_debugfs),
+#endif
 	{}
 };
 
-- 
2.43.0


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC13606A335
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xvq6CUIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC6910F831;
	Tue, 17 Nov 2026 17:15:02 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14FD10F81B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mw08m/IHWPkXGLY7Ywutoxr38WmNy8gzP70E8HLL/ROTnMYHWvNAEUBbXnHcd+enhR0xPKBNUOQHKZ2ts82uMbnYcIh7F31062tQlKwg/LTzaW5/F5WqhPWeR8qHZkhnAbOUlZLvMSdB2qggPj5CdMUK6Jbo3saam2zOkqHA7WnH9hpKivS3lzNk75zfShI74YN48HlIJLNT6neDD3cSUWPRkoGERs28gYZURgL9ZjZTWsmDHnU6nxeDoJmz1euilkzcW/jcky/MliETKkG+JsbcLBa0rQKy3pwMZdSdZqpqb9P8ueuUPh0sb3e0DWR+eX0fsDnUdnXESOC4KGs5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1YkZ/GnVX4FfUR/vYMd6y1sdJLszP+sP8h3IN00RSI=;
 b=gZ44YTT7l780+YphWpJ6TlOJzU1GNbddTaue+9VT/EjalRmv2Btbn89AZeqakzxAy1xeeVmyFCt1w5XVakl1pAcv29CclJqJMyDNEW7GMREW31x6+2bS9LYvINQidLl/FuRSx9I8NqTNo+I9PeImSy67oofOQjo7IjcN1gFkcEu2Faz7u5s0Kib8L5H8utyjtiluAlIxdPnJ8hFO5jtHWgwMIQLv3YtLQrfov1a7LbxWtGD7+FpIwECzrkhCgJgV4V23JtMEBujM4mlyhh8gX9KOcLI4jnHgtCud1M7otWn1bRvGNqi4pOEWW147rSzb17XCMd1sqm9rFhwLR/ZcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1YkZ/GnVX4FfUR/vYMd6y1sdJLszP+sP8h3IN00RSI=;
 b=xvq6CUIJQWGz6UbyxOSyWEjiGS36q5aP5wfS7G0Gm+TPUXv3DNeMZysHucUJZxxZ2lokdvfMyXHCAzeWzbG66CTbffgKMIdtTUCtuDBVT3YiXFRIO7neDIpaZEKD+2Z1WlgCqKzc6jle1WdW9MDzWgOpfdCA8wQGKi+j6Qo7gN4=
Received: from PH8PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:2d0::28)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:14:44 +0000
Received: from PH3PEPF0005961B.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ae) by PH8PR02CA0021.outlook.office365.com
 (2603:10b6:510:2d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:14:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961B.mail.protection.outlook.com (10.167.243.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:14:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:42 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:14:33 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 15/33] drm/amd/display: Fix KUnit tests for vblank control
 rework
Date: Tue, 17 Nov 2026 05:50:52 +0800
Message-ID: <20261116215641.2800595-16-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961B:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a11b30e-d52c-4a39-212c-08df44ce4606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|5023799004|11063799006|56012099006|261022075727099003|261026121527099003|261028144727099003|261009223327099003|261009221227099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261009221727099003|261009223027099003|261009220027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: XnEnrtiV5hdhGUWo1RLHoMfQUtPxjh1IbzIHCkF92whTLWqcg45zu8pCNyFyPon0vDtu0IgwCK/sjXURdLSCKI7PNUICxu4i6AcPlxtY2c9HXoCwtHnqkXcFRkUcC46NmQpKxnZpaG0IDBntkWLerpKyDHDrSQ/8SOGouJwn5GBmoIUgK2Z8mgoUA+hrFKDVafaGcaeG3CPeTA7C0zWtpqD+sNaXEifX3XBNzeSu2GswX//3qLsguA8u2TScWqWmm/90wbBHrLzKg1hRb0fQ3rkyYSgYZizlXYUBUJR5Rv2i35UhDchxIxZhcm59hgB2t14p8iBte2TgZhfXV00Wi/cZ70PCwHDIBz5hUkS6ylAYHDRAmzTCWgHi9d80FZtfFg+Yur/0+ThUtPzFnLEZoeZaMDs6Zfq5ETYzbhDrjnvymDhltDqu4tNFPp/Qab3irST/Xn/5hifDUpDfhMqNCUl5A9LDUia2IArP5Hw2Kv8s1ph8OfrAciVA2QEL+vn9fWXfHKDyD+1FbYgGlA2A+0pcPHT5Az/KB49WvD6BruMFBbjUrIvtjweVIWtb50qxH5UOc9KFjnN3m2NMzNrCrHU8TMGpS0l1X+CPAKfQMaHaLQ6xu7cWE3uHQOh3n2yFHZjqFGrHwQ3T9cXIE1Bcgko/VC3blymzNPqBzFl0pciv0igwnCmIEH6XVcngv6JW8/9UR48pY8rr29qJLqUpUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261028144727099003)(261009223327099003)(261009221227099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261009221727099003)(261009223027099003)(261009220027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jB//MX6gfDmjAwJTaxXuPGrxAwCGO41U2gKXszRYNocUydg3BfG7XbEMM1LYr6KjvfC0DoZ6PMBJc1wWeqSJOuUqIfpInrHdw5gFHCqvMvuBkCo7FgxcyL7Xj10xGQOPNQF7fw8y4wC5WtO5gcGclrxAu0W1DVhppbFY7wx2pniRqNKWXapXrAwVHY+YlQQMduu6OK+FuA2rOuza+zGaicJfu/fQGSIF3sFN7VMFTO6DkfUkBXMQPfP0ZHe6E9wxHXG9e3JKDYySwq9/0+1tTLZnvbMAFWZhFL7skCrZD+qJ1c/kZc5B/yfpU4ikixuCTk4MvV1T2kiWE0iKf6UW9urIoqn0sqb1CMP5r/dxOWCp5zlzM/p1PKuoc0TOt/5fBhRJU80x6wkLXT2zPM0wMS7amI/hEApeOv0Szu0g6QFfiG2shk+OTQT/IaKsYsvu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:14:43.4951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a11b30e-d52c-4a39-212c-08df44ce4606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Zhang <george.zhang@amd.com>

[why & how]
The per-CRTC vblank_toggle_lock was replaced by a device-wide sw_counter_lock,
and the vblank-control-worker no longer touches active_vblank_irq_count on
disable (that now happens synchronously in amdgpu_dm_crtc_set_vblank() before
the worker is queued) -- seed the new lock across the affected fixtures and
rework the worker tests accordingly, also seeding reset_domain where
amdgpu_dm_crtc_set_vblank() now calls amdgpu_in_reset() unconditionally.

Cc: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 219 +++++++++++++-----
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |   2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   5 +
 3 files changed, 171 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 20ad887979f7..ff73931a8c4d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -909,6 +909,38 @@ static void dm_test_crtc_cleanup(void *data)
 	list_del_init(&acrtc->base.head);
 }
 
+static void dm_test_crtc_destroy_vblank_wq(void *data)
+{
+	struct amdgpu_device *adev = data;
+
+	destroy_workqueue(adev->dm.vblank_control_workqueue);
+	adev->dm.vblank_control_workqueue = NULL;
+}
+
+/*
+ * dm_test_crtc_init_vblank_wq - Give @adev a live vblank control workqueue.
+ * @test: The KUnit test context
+ * @adev: The device to equip
+ *
+ * amdgpu_dm_crtc_set_vblank() queues unconditionally, as amdgpu_dm_init()
+ * fails driver init when the workqueue cannot be created. The worker takes
+ * dc_lock, so initialize that too. The workqueue is drained and destroyed at
+ * teardown; tests that assert on state the worker touches must flush it
+ * first.
+ */
+static void dm_test_crtc_init_vblank_wq(struct kunit *test,
+					struct amdgpu_device *adev)
+{
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.vblank_control_workqueue =
+		create_singlethread_workqueue("dm_test_vblank");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.vblank_control_workqueue);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test,
+						  dm_test_crtc_destroy_vblank_wq,
+						  adev), 0);
+}
+
 /*
  * dm_test_crtc_arm_irq_src - Prime an IRQ source so get()/put() short-circuit.
  * @test: The KUnit test context
@@ -978,6 +1010,9 @@ dm_test_crtc_setup_enable(struct kunit *test, struct amdgpu_device **adev_out,
 	acrtc->base.funcs = &dm_test_crtc_funcs;
 	acrtc->base.enabled = true;
 	acrtc->crtc_id = 0;
+	/* amdgpu_dm_crtc_set_vblank() takes this; amdgpu_dm_crtc_init() is bypassed. */
+	spin_lock_init(&adev->dm.sw_counter_lock);
+	dm_test_crtc_init_vblank_wq(test, adev);
 	INIT_LIST_HEAD(&acrtc->base.head);
 	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
 	KUNIT_ASSERT_EQ(test,
@@ -1148,22 +1183,56 @@ static void dm_test_crtc_enable_vblank_queues_work(struct kunit *test)
 	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 1);
 	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 1);
 
-	/* Real workqueue so the queue_work() branch runs the control worker. */
-	mutex_init(&adev->dm.dc_lock);
-	adev->dm.vblank_control_workqueue =
-		create_singlethread_workqueue("dm_test_vblank");
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.vblank_control_workqueue);
-
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
 
-	/* Drain the queued worker before the fixture is torn down, then tidy up. */
-	destroy_workqueue(adev->dm.vblank_control_workqueue);
-	adev->dm.vblank_control_workqueue = NULL;
+	/* Drain the queued worker so the count below is observed deterministically. */
+	flush_workqueue(adev->dm.vblank_control_workqueue);
 
 	/* The queued worker ran and accounted the active vblank IRQ. */
 	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 1);
 }
 
+/**
+ * dm_test_crtc_enable_vblank_idempotent - Test a redundant enable programs nothing
+ * @test: The KUnit test context
+ *
+ * amdgpu_dm_sync_vblank_irq() short-circuits when the request already matches
+ * vblank_irq_programmed, so a second enable must leave the crtc and pageflip
+ * IRQ references untouched rather than taking a second one.
+ */
+static void dm_test_crtc_enable_vblank_idempotent(struct kunit *test)
+{
+	struct dm_crtc_state *acrtc_state;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	int crtc_refs, pflip_refs;
+
+	/* DCE_VERSION_8_0 supports VRR -> the vupdate-irq branch is walked. */
+	acrtc = dm_test_crtc_setup_enable(test, &adev, DCE_VERSION_8_0);
+
+	/* OTG unassigned -> amdgpu_dm_crtc_set_vupdate_irq() returns 0 early. */
+	acrtc->otg_inst = -1;
+	acrtc_state = to_dm_crtc_state(acrtc->base.state);
+	acrtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	adev->irq.installed = true;
+	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 1);
+	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 1);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
+	KUNIT_EXPECT_TRUE(test, acrtc->dm_irq_params.vblank_irq_programmed);
+
+	crtc_refs = atomic_read(&adev->crtc_irq.enabled_types[0]);
+	pflip_refs = atomic_read(&adev->pageflip_irq.enabled_types[0]);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
+
+	KUNIT_EXPECT_EQ(test, atomic_read(&adev->crtc_irq.enabled_types[0]),
+			crtc_refs);
+	KUNIT_EXPECT_EQ(test, atomic_read(&adev->pageflip_irq.enabled_types[0]),
+			pflip_refs);
+}
+
 /**
  * dm_test_crtc_enable_vblank_ips_restore - Test IPS/self-refresh vblank restore
  * @test: The KUnit test context
@@ -1881,12 +1950,15 @@ static void dm_test_crtc_handle_vblank_completes_cursor_only(struct kunit *test)
 /**
  * dm_test_vblank_control_worker_setup - Build a vblank_control_work for the worker
  * @test: The KUnit test context
- * @enable: Value for vblank_work->enable
+ * @enable: Value for vblank_work->enable; also seeds vblank_irq_desired so the
+ *          worker's own program-decision ("desired && !programmed") matches it
  * @count: Initial dm->active_vblank_irq_count
  *
- * Returns a work item wired to a freshly allocated adev/crtc/stream. The CRTC is
- * left without an atomic state so amdgpu_dm_ism_commit_event() short-circuits and
- * only the vblank IRQ accounting in the worker runs.
+ * Returns a work item wired to a freshly allocated adev/crtc/stream, with the
+ * crtc/pageflip IRQ sources armed so amdgpu_dm_sync_vblank_irq() can actually
+ * program on the enable path. The CRTC is left without an atomic state so
+ * amdgpu_dm_ism_commit_event() short-circuits and only the vblank IRQ
+ * programming in the worker runs.
  */
 static struct vblank_control_work *
 dm_test_vblank_control_worker_setup(struct kunit *test, bool enable,
@@ -1901,14 +1973,24 @@ dm_test_vblank_control_worker_setup(struct kunit *test, bool enable,
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	mutex_init(&adev->dm.dc_lock);
+	spin_lock_init(&adev->dm.sw_counter_lock);
 	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
 	adev->dm.active_vblank_irq_count = count;
 
+	adev->mode_info.num_crtc = 1;
+	adev->irq.installed = true;
+
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->base.state = NULL;
+	acrtc->crtc_id = 0;
+	/* OTG unassigned -> amdgpu_dm_crtc_set_vupdate_irq() returns 0 early. */
+	acrtc->otg_inst = -1;
+	acrtc->dm_irq_params.vblank_irq_desired = enable;
+	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 1);
+	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 1);
 
 	stream = dm_kunit_alloc_stream(test, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
@@ -1930,7 +2012,9 @@ dm_test_vblank_control_worker_setup(struct kunit *test, bool enable,
  * dm_test_vblank_control_worker_enable_increments - Test enable bumps IRQ count
  * @test: The KUnit test context
  *
- * Running the worker with enable set must increment the active vblank IRQ count.
+ * With vblank_irq_desired seeded true and nothing yet programmed, the worker's
+ * program decision is true, so it calls amdgpu_dm_sync_vblank_irq(), which
+ * programs the IRQ and increments the active vblank IRQ count.
  */
 static void dm_test_vblank_control_worker_enable_increments(struct kunit *test)
 {
@@ -1943,16 +2027,22 @@ static void dm_test_vblank_control_worker_enable_increments(struct kunit *test)
 	amdgpu_dm_crtc_vblank_control_worker(&work->work);
 
 	KUNIT_EXPECT_EQ(test, dm->active_vblank_irq_count, 1);
+	KUNIT_EXPECT_TRUE(test, work->acrtc->dm_irq_params.vblank_irq_programmed);
 }
 
 /**
- * dm_test_vblank_control_worker_disable_decrements - Test disable drops IRQ count
+ * dm_test_vblank_control_worker_disable_leaves_count_unchanged - Test disable is a no-op here
  * @test: The KUnit test context
  *
- * Running the worker with enable clear must decrement a non-zero active vblank
- * IRQ count.
+ * amdgpu_dm_crtc_set_vblank()'s disable branch calls amdgpu_dm_sync_vblank_irq()
+ * synchronously, inline, before ever queuing this worker -- so by the time the
+ * worker runs, the real decrement has already happened elsewhere. With
+ * vblank_irq_desired seeded false and vblank_irq_programmed defaulting false,
+ * the worker's own program decision is false, so it must leave the count
+ * untouched; its only remaining job on disable is the (short-circuited) ISM
+ * ENTER_IDLE_REQUESTED dispatch.
  */
-static void dm_test_vblank_control_worker_disable_decrements(struct kunit *test)
+static void dm_test_vblank_control_worker_disable_leaves_count_unchanged(struct kunit *test)
 {
 	struct vblank_control_work *work;
 	struct amdgpu_display_manager *dm;
@@ -1962,26 +2052,7 @@ static void dm_test_vblank_control_worker_disable_decrements(struct kunit *test)
 
 	amdgpu_dm_crtc_vblank_control_worker(&work->work);
 
-	KUNIT_EXPECT_EQ(test, dm->active_vblank_irq_count, 1);
-}
-
-/**
- * dm_test_vblank_control_worker_disable_clamps_zero - Test disable clamps at zero
- * @test: The KUnit test context
- *
- * Disabling when the active vblank IRQ count is already zero must not underflow.
- */
-static void dm_test_vblank_control_worker_disable_clamps_zero(struct kunit *test)
-{
-	struct vblank_control_work *work;
-	struct amdgpu_display_manager *dm;
-
-	work = dm_test_vblank_control_worker_setup(test, false, 0);
-	dm = work->dm;
-
-	amdgpu_dm_crtc_vblank_control_worker(&work->work);
-
-	KUNIT_EXPECT_EQ(test, dm->active_vblank_irq_count, 0);
+	KUNIT_EXPECT_EQ(test, dm->active_vblank_irq_count, 2);
 }
 
 /**
@@ -1990,10 +2061,12 @@ static void dm_test_vblank_control_worker_disable_clamps_zero(struct kunit *test
  *
  * Disabling vblank walks amdgpu_dm_crtc_set_vblank()'s disable path. With the
  * IRQ subsystem not installed, amdgpu_irq_put() returns early so the routine
- * completes without touching the vblank workqueue or the active IRQ count.
+ * completes without changing the active IRQ count.
  */
 static void dm_test_crtc_disable_vblank_no_irq_installed(struct kunit *test)
 {
+	struct amdgpu_reset_domain *reset_domain;
+	struct dm_crtc_state *dm_state;
 	struct amdgpu_device *adev;
 	struct amdgpu_crtc *acrtc;
 
@@ -2006,6 +2079,11 @@ static void dm_test_crtc_disable_vblank_no_irq_installed(struct kunit *test)
 	adev->dm.dc->ctx->dce_version = DCE_VERSION_6_0;
 	adev->dm.active_vblank_irq_count = 0;
 
+	/* amdgpu_dm_crtc_set_vblank() calls amdgpu_in_reset(adev) unconditionally. */
+	reset_domain = kunit_kzalloc(test, sizeof(*reset_domain), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, reset_domain);
+	adev->reset_domain = reset_domain;
+
 	/* No CRTCs registered and IRQs not installed -> irq_put returns early. */
 	adev->mode_info.num_crtc = 0;
 	adev->irq.installed = false;
@@ -2014,8 +2092,23 @@ static void dm_test_crtc_disable_vblank_no_irq_installed(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->crtc_id = 0;
+	spin_lock_init(&adev->dm.sw_counter_lock);
+	dm_test_crtc_init_vblank_wq(test, adev);
+	/* Without this the disable is a no-op: the IRQ is already not programmed. */
+	acrtc->dm_irq_params.vblank_irq_programmed = true;
+	/*
+	 * Seed the ISM in a state where ENTER_IDLE_REQUESTED does not transition
+	 * so the worker skips the ISM power-state dispatch and its timers.
+	 */
+	acrtc->ism.current_state = DM_ISM_STATE_HYSTERESIS_WAITING;
+
+	/* CRTC state with no stream -> the stream-retain branch is skipped. */
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	acrtc->base.state = &dm_state->base;
 
 	amdgpu_dm_crtc_disable_vblank(&acrtc->base);
+	flush_workqueue(adev->dm.vblank_control_workqueue);
 
 	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 0);
 }
@@ -2025,12 +2118,13 @@ static void dm_test_crtc_disable_vblank_no_irq_installed(struct kunit *test)
  * @test: The KUnit test context
  *
  * On a VRR-capable DC the disable path turns the vupdate IRQ off (OTG
- * unassigned so it returns early), releases the armed crtc and pageflip IRQ
- * references and completes without queuing vblank control work.
+ * unassigned so it returns early) and releases the armed crtc and pageflip
+ * IRQ references.
  */
 static void dm_test_crtc_disable_vblank_vrr(struct kunit *test)
 {
 	struct amdgpu_reset_domain *reset_domain;
+	struct dm_crtc_state *dm_state;
 	struct amdgpu_device *adev;
 	struct amdgpu_crtc *acrtc;
 
@@ -2059,8 +2153,23 @@ static void dm_test_crtc_disable_vblank_vrr(struct kunit *test)
 	acrtc->crtc_id = 0;
 	/* OTG unassigned -> amdgpu_dm_crtc_set_vupdate_irq() returns 0 early. */
 	acrtc->otg_inst = -1;
+	spin_lock_init(&adev->dm.sw_counter_lock);
+	dm_test_crtc_init_vblank_wq(test, adev);
+	/* Without this the disable is a no-op: the IRQ is already not programmed. */
+	acrtc->dm_irq_params.vblank_irq_programmed = true;
+	/*
+	 * Seed the ISM in a state where ENTER_IDLE_REQUESTED does not transition
+	 * so the worker skips the ISM power-state dispatch and its timers.
+	 */
+	acrtc->ism.current_state = DM_ISM_STATE_HYSTERESIS_WAITING;
+
+	/* CRTC state with no stream -> the stream-retain branch is skipped. */
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	acrtc->base.state = &dm_state->base;
 
 	amdgpu_dm_crtc_disable_vblank(&acrtc->base);
+	flush_workqueue(adev->dm.vblank_control_workqueue);
 
 	/* Both IRQ references were released without underflow. */
 	KUNIT_EXPECT_EQ(test, atomic_read(&adev->crtc_irq.enabled_types[0]), 1);
@@ -2073,9 +2182,12 @@ static void dm_test_crtc_disable_vblank_vrr(struct kunit *test)
  *
  * With a vblank control workqueue installed and a CRTC state carrying no
  * stream, the disable path queues the control worker without retaining a
- * stream. Draining the queue runs the worker, which drops the active vblank IRQ
- * count. The ISM is seeded in a state with no ENTER_IDLE_REQUESTED transition
- * so the worker only exercises the vblank accounting.
+ * stream. amdgpu_dm_crtc_set_vblank()'s disable branch calls
+ * amdgpu_dm_sync_vblank_irq() synchronously (not via the worker), so the
+ * active vblank IRQ count has already dropped by the time this call returns.
+ * The ISM is seeded in a state with no ENTER_IDLE_REQUESTED transition so
+ * draining the queued worker only exercises its (short-circuited) ISM
+ * dispatch, leaving the count as this call already left it.
  */
 static void dm_test_crtc_disable_vblank_queues_work(struct kunit *test)
 {
@@ -2109,28 +2221,25 @@ static void dm_test_crtc_disable_vblank_queues_work(struct kunit *test)
 	acrtc->base.dev = &adev->ddev;
 	acrtc->crtc_id = 0;
 	acrtc->otg_inst = -1;
+	spin_lock_init(&adev->dm.sw_counter_lock);
+	/* Without this the disable is a no-op: the IRQ is already not programmed. */
+	acrtc->dm_irq_params.vblank_irq_programmed = true;
 	/*
 	 * Seed the ISM in a state where ENTER_IDLE_REQUESTED does not transition
 	 * so the worker skips the ISM power-state dispatch and its timers.
 	 */
 	acrtc->ism.current_state = DM_ISM_STATE_HYSTERESIS_WAITING;
+	dm_test_crtc_init_vblank_wq(test, adev);
 
 	/* CRTC state with no stream -> the stream-retain branch is skipped. */
 	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 	acrtc->base.state = &dm_state->base;
 
-	/* Real workqueue so the queue_work() branch runs the control worker. */
-	mutex_init(&adev->dm.dc_lock);
-	adev->dm.vblank_control_workqueue =
-		create_singlethread_workqueue("dm_test_vblank");
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.vblank_control_workqueue);
-
 	amdgpu_dm_crtc_disable_vblank(&acrtc->base);
 
-	/* Drain the queued worker before the fixture is torn down, then tidy up. */
-	destroy_workqueue(adev->dm.vblank_control_workqueue);
-	adev->dm.vblank_control_workqueue = NULL;
+	/* Drain the queued worker so the count below is observed deterministically. */
+	flush_workqueue(adev->dm.vblank_control_workqueue);
 
 	/* The queued worker ran and decremented the active vblank IRQ count. */
 	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 1);
@@ -2667,6 +2776,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_enable_vblank_crtc_irq_error),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_in_reset),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_queues_work),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_idempotent),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_ips_restore),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_ips_restore_replay),
 	/* amdgpu_dm_crtc_set_vline0_irq */
@@ -2696,8 +2806,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_handle_vblank_completes_cursor_only),
 	/* amdgpu_dm_crtc_vblank_control_worker */
 	KUNIT_CASE(dm_test_vblank_control_worker_enable_increments),
-	KUNIT_CASE(dm_test_vblank_control_worker_disable_decrements),
-	KUNIT_CASE(dm_test_vblank_control_worker_disable_clamps_zero),
+	KUNIT_CASE(dm_test_vblank_control_worker_disable_leaves_count_unchanged),
 	/* amdgpu_dm_crtc_disable_vblank */
 	KUNIT_CASE(dm_test_crtc_disable_vblank_no_irq_installed),
 	KUNIT_CASE(dm_test_crtc_disable_vblank_vrr),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index f844b644bb77..6031d9c9c29f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -95,6 +95,8 @@ struct amdgpu_display_manager *dm_kunit_alloc_dm(struct kunit *test)
 
 	dm->dc = dc;
 	dc->current_state = state;
+	/* Guards otg_sw_counter[]; amdgpu_dm_init() is bypassed here. */
+	spin_lock_init(&dm->sw_counter_lock);
 
 	return dm;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a7618473e207..85f2e78c54af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1292,6 +1292,11 @@ static void dm_test_crtc_with_stream(struct kunit *test,
 	adev->mode_info.num_crtc = 1;
 	adev->mode_info.crtcs[0] = acrtc;
 	acrtc->dm_irq_params.stream = stream;
+
+	/* dm_vblank_get_counter()/dm_crtc_get_scanoutpos() take this unconditionally
+	 * once a stream is set.
+	 */
+	spin_lock_init(&adev->dm.sw_counter_lock);
 }
 
 /**
-- 
2.43.0


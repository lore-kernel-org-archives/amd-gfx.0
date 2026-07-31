Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5975C55177
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3150310F408;
	Fri, 31 Jul 2026 21:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wSetDQF5";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DD610F402
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP1Z5H360t/oXF2VppvID0z2U9rINN9Viqh5A5aaogNErh+7tqPtY3/PAw108DokfXK813n0kwHJQcaFpIsAyKWtmMngSojh2Oj9k8Zi0SLUJdgQkasC5Nnd87WYJY6erShzS9sH2Pxxi5s5+OqDSwiezSnhueYqZjc6zrEBs2SCJ7NyV48zIt5JWZuFAnx1i8gkJHG2sIlNTI0z/JAYlCixQedX8x6A954dZOncsJRjiEsbSTHtwyhKbPrGvuT3h3lcQV+xj+ZsKIToEUVP9yiQaHV5Ue1hP6WzXmmIuEZkTAIiX994IRuyrwrmzpf2QpcOeYQAevZ05V1TaL31yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCtWBVt07na8dNE3coB4jYUJmO0+GsecXmJAvLy9mYY=;
 b=VNKWIn85PTprAz8yLp5QddAijHP2EnhweFhPC7HiYgSR68X0Y6gFUIvUW1Z1xWQCuhIY+r/QkqNPHsxF0P23pzwUmTgwtXNUd2OnTLIHYqk2pTNOO6uJ5CEaiJjhNpkqGdE/HLRMwEF47Vn45cTWb1SybEfbLYd25CIU/zvAURxe2EAVDCtgFQSUTyED0VN0GlRimKLkuJI2765HpFu1EsGf1eR3zFvSs95ECbg+SfnfYf0EsKWc9xa3D0yTzoqxgHOLUJS8MKpWeW3DkZjCPBIEzcCxLvhPaOd5Oryc9/BjDDvC8UATEZDbmZ7gRd9GcwOZuMaftqJXo6x8TgrgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCtWBVt07na8dNE3coB4jYUJmO0+GsecXmJAvLy9mYY=;
 b=wSetDQF51CIoyfN+BG7OGzblNNmuuRZWE/Zxr+SPXlbGytDuK+pWKpeK4BDklQS8DtJBar9oDf8xmrqEoIBR3jSRnr3uLXrwHjf8Ubdr7kFWIIzBcQf6G0/rY1UfWFqzh5uS/hh1xFV1tSB+o5BmcICP9l+vReMhf0GUFalERiQ=
Received: from BN9PR03CA0930.namprd03.prod.outlook.com (2603:10b6:408:107::35)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:54 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::a3) by BN9PR03CA0930.outlook.office365.com
 (2603:10b6:408:107::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 21:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:54 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:53 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 26/41] drm/amd/display: Cover crtc set_vblank workqueue branch
Date: Fri, 31 Jul 2026 17:12:47 -0400
Message-ID: <20260731211302.3040343-27-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: dad5295c-9642-4fe6-79ba-08deef48e84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MdaMMYUwLK/mKXIXn3n613foJXWUOHETRM7xgINjGoWrCseqcRUTJlCYpEl7m0Fgf0G6OyroAk3Qz4H5evEv3clhXJhRJgKcGzSsQQVkcowNs2jlHWFYW6PEFlsHbTDkmSoSWj6I9bbMin9822FLeNOkK0EfFHCKP4C0BxH4Zg4+1FmIeGEm7Mm6dpgjPJigLqF8FSmT6LQkBWRUQGAqyX/8Ewrly6FLfYKomFM0Bs79Cve21c+ZNTasZD61X2Ky/GF+ooZuhQ73ws3wjFk0WrEHBu/xr0krSMIlBJVCdGUQg7PpoOzxrMz0ypFaHWkyVQP7HmQHMgWwLgxH/fK2PdjABDNvJa7unYK+JAOMwSSJtxphz8voJ5n7GcpVpc8YbxqxazPmUHRebcW6TzGVLYsA9Y325nMTR+nI6vLyEgHFjLzTSYboV4vcBiybH/vfDtJd96mARqY1KXsyNPGOUm207iP7cN5VlxhaVdIa8VkzIcCpQH0zjTTBECk1rwa3CZf4IFglMJ/mlq84ockX0u9lgwEJgGjiYVKger8l4ARQ6pC7hrDGEJ54YOWEohu57yohqi6vWt1jLoO2zhazcK98swo3vIWQSpubMw3aJ1lCQ3zIqdZc6vKTdHlJZWY0n9cWxGdjR+I/g1KrciS3oyq7g10T/SOmmBIqF27mp+W9QfYXL8XTHKi0f0kZf1aDkPZGRGTKP9tvaA9PVYdtag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hSIuuOCA+EC/izXm81Vrcij+ZyQKuLISrqkUwvRHBV8BVAUzJx23bCFry2iKaSP7JTrraT9imOgc3+QA1H5LQzyegRD0xd6bR/rkm+bUUorlVcmTjdncCjaZkdq/TMIv5XEmFBiK6ohvE+WKpctX+34I2uYTR6isrUGd8XwaTR8z5/VpX5IVQ8zIzd4raC8MqFLlYA/bqRArExMHUqTH1Ye72uFqTncfIXBniIZzhL7soZhNpwDvm9Lzcf3g4Y3YfP+3rBA6cZa/2PDZle7LKvBZopeFiDWPTMDJXiTELnWIQ/s2Hee5ytOuatoPWzH+3yhN+Xwr0truGQsKcYyNAO6+WL60RLyz2He79sLIobdU04b63GyUMcZty736YIk3Nh6BTpNJPFc8oA5DMaOilef++EobsHN2j3q+biT05VXasNsMYaaC2v63mEOXWUEm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:54.6741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad5295c-9642-4fe6-79ba-08deef48e84c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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

Add dm_test_crtc_enable_vblank_queues_work and
dm_test_crtc_disable_vblank_queues_work to cover the
vblank_control_workqueue branch of amdgpu_dm_crtc_set_vblank():

- The enable test installs a real workqueue, retains the stream and
  queues the control worker, then drains it and checks the active vblank
  IRQ count was incremented.
- The disable test drives the no-stream sub-branch (the stream-retain is
  skipped) and checks the worker decremented the count.

Both seed the ISM so the queued worker takes no state-machine transition,
keeping coverage on the vblank accounting; the ISM state machine itself
is covered by the ISM tests.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 753150943fba..74d72289dff6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1063,6 +1063,50 @@ static void dm_test_crtc_enable_vblank_in_reset(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
 }
 
+/**
+ * dm_test_crtc_enable_vblank_queues_work - Test enable queues vblank control work
+ * @test: The KUnit test context
+ *
+ * With a vblank control workqueue installed, the enable path allocates a work
+ * item, retains the stream and queues the control worker. Draining the queue
+ * runs the worker, which bumps the active vblank IRQ count. The initial ISM
+ * state has no EXIT_IDLE_REQUESTED transition, so the worker only exercises the
+ * vblank accounting (the ISM state machine is covered by its own tests).
+ */
+static void dm_test_crtc_enable_vblank_queues_work(struct kunit *test)
+{
+	struct dm_crtc_state *acrtc_state;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
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
+	/* Real workqueue so the queue_work() branch runs the control worker. */
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.vblank_control_workqueue =
+		create_singlethread_workqueue("dm_test_vblank");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.vblank_control_workqueue);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
+
+	/* Drain the queued worker before the fixture is torn down, then tidy up. */
+	destroy_workqueue(adev->dm.vblank_control_workqueue);
+	adev->dm.vblank_control_workqueue = NULL;
+
+	/* The queued worker ran and accounted the active vblank IRQ. */
+	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 1);
+}
+
 /* Tests for amdgpu_dm_crtc_update_crtc_active_planes() */
 
 /**
@@ -1585,6 +1629,75 @@ static void dm_test_crtc_disable_vblank_vrr(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, atomic_read(&adev->pageflip_irq.enabled_types[0]), 1);
 }
 
+/**
+ * dm_test_crtc_disable_vblank_queues_work - Test disable queues work without a stream
+ * @test: The KUnit test context
+ *
+ * With a vblank control workqueue installed and a CRTC state carrying no
+ * stream, the disable path queues the control worker without retaining a
+ * stream. Draining the queue runs the worker, which drops the active vblank IRQ
+ * count. The ISM is seeded in a state with no ENTER_IDLE_REQUESTED transition
+ * so the worker only exercises the vblank accounting.
+ */
+static void dm_test_crtc_disable_vblank_queues_work(struct kunit *test)
+{
+	struct amdgpu_reset_domain *reset_domain;
+	struct dm_crtc_state *dm_state;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
+	/* DCE_VERSION_6_0 has no VRR, so the vupdate-irq branch is skipped. */
+	adev->dm.dc->ctx->dce_version = DCE_VERSION_6_0;
+	adev->dm.active_vblank_irq_count = 2;
+
+	adev->mode_info.num_crtc = 1;
+	adev->irq.installed = true;
+
+	reset_domain = kunit_kzalloc(test, sizeof(*reset_domain), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, reset_domain);
+	adev->reset_domain = reset_domain;
+
+	/* Seed with 2 so amdgpu_irq_put() drops to a non-zero refcount. */
+	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 2);
+	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 2);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->crtc_id = 0;
+	acrtc->otg_inst = -1;
+	/*
+	 * Seed the ISM in a state where ENTER_IDLE_REQUESTED does not transition
+	 * so the worker skips the ISM power-state dispatch and its timers.
+	 */
+	acrtc->ism.current_state = DM_ISM_STATE_HYSTERESIS_WAITING;
+
+	/* CRTC state with no stream -> the stream-retain branch is skipped. */
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	acrtc->base.state = &dm_state->base;
+
+	/* Real workqueue so the queue_work() branch runs the control worker. */
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.vblank_control_workqueue =
+		create_singlethread_workqueue("dm_test_vblank");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.vblank_control_workqueue);
+
+	amdgpu_dm_crtc_disable_vblank(&acrtc->base);
+
+	/* Drain the queued worker before the fixture is torn down, then tidy up. */
+	destroy_workqueue(adev->dm.vblank_control_workqueue);
+	adev->dm.vblank_control_workqueue = NULL;
+
+	/* The queued worker ran and decremented the active vblank IRQ count. */
+	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 1);
+}
+
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
@@ -1634,6 +1747,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_enable_vblank_vupdate_busy),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_crtc_irq_error),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_in_reset),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_queues_work),
 	/* amdgpu_dm_crtc_update_crtc_active_planes */
 	KUNIT_CASE(dm_test_crtc_update_active_planes_no_stream),
 	/* amdgpu_dm_crtc_count_crtc_active_planes */
@@ -1656,6 +1770,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_disable_vblank */
 	KUNIT_CASE(dm_test_crtc_disable_vblank_no_irq_installed),
 	KUNIT_CASE(dm_test_crtc_disable_vblank_vrr),
+	KUNIT_CASE(dm_test_crtc_disable_vblank_queues_work),
 	{}
 };
 
-- 
2.34.1


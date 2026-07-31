Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8BBC55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE0C10F404;
	Fri, 31 Jul 2026 21:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H06PO+tq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B58310F40F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNKT/g6o87IfNXSneyEssVQocDcup0U7F7vpud5mDj+B3xvkWHyy3rZLix+UrYWfAR1ZOPzXb0bAhk7AVFtaphNH+/x1DtO6Q9/toCNx0FhHdWqXYbxjCg5g3CNSa0h5oKVOpJGiTW+tX3+cIgtpGf0mYxqpWlE+KaRnvKkFVc1iXGJh8XEZmg7vls3nn40axMVpzlQROCnOkm+o/TP5RszYAzRDZDZWAEbX+UPbMH1bxSndLHELhxHuN5/xAqZsmm4VMk6Me+b2WgputW+5kBpyRPAH1y7w8G/CBDQhD69eJ0HnKkCOPbvCNVZMuRQB/rfkDEOFMXz7lg6T1CAsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oPt2/TIbOTXuUWU1aB7Mk/mwpg0HBjAlw+v8JLm9gA=;
 b=f13tJbnIG4k5ZixXMzxfQVNUkDIoZMs2oHFaPTeICP+oVgVZSb2FfeKgZK4YawscFD5fwGsv6/IdWzMlKybOwwX1tVGAaAYERtUNp2EzHmQvM/SKHxDdntdkBPLDdal/kxrVTY55JOoa4bBV0LxPOZFH4sK+bcpXzFWW1A4GIor+3GqSuJsMy1z8gqmluBK6M0jSAgkk30YQqdqpOFS4OGHO0ujZ0UBfxAQ+07WHv4oO7I1ddLcXYBNt7PaTSssqe6iju8I+lzUYoHmgjzUUvSmLvi/8QHlvpUO7wRBytIXomgxf4EuofTmeyMH3+ec08VGu4f2UMokLl0flrs99nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oPt2/TIbOTXuUWU1aB7Mk/mwpg0HBjAlw+v8JLm9gA=;
 b=H06PO+tqFHi5KW87XpxTGgu/ZHgk9Nsgafo5Udo82GCEe7ob0ddw+6Rlkkx6E6vlF4YPH68MrthR/05KLIQE3MUfpSM6MpUBpuY97NUOgZJ0sTzZg0IBavndL6mGVCnFAptYPZbF+u4r/YTq2sU/rDzWFi3P9H7ErMmBNC+Ta4o=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Fri, 31 Jul
 2026 21:15:54 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::32) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:53 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:52 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 25/41] drm/amd/display: Add KUnit tests for crtc set_vblank
Date: Fri, 31 Jul 2026 17:12:46 -0400
Message-ID: <20260731211302.3040343-26-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: a9492cc6-b83e-4b0f-bfce-08deef48e850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|22082099003|18002099003|5023799004|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Fskc4eo7olquEGpbhk6KWmnjmdmT6caRaFRY7eIbzX24PyZHgZFEp4JFcxh/pu7DfLawSflFlhOYjYoXtoP4tVPWR3F0fvijEULiwgzgNwaOMdgdPtuW1jMbjs2g8NDABk2cT1kIQ2pyoiZha5pXfMBgCbr1CfMuGziQiqCdECOmAwRKGMLKptW4RxbwrVM+BhBaKiMe65ywyL5RUDKPM2C6xy+6hxj6f6Pa2Emy2psii7oszRK7jIplWTKCKv5Cr2+rh1Snsz603HR9OwcCi9mUUSJZSGHcgX3c7XR89mJOAOTTauDwp2vcIPq1rQj/GGHEfQ9GS/4fVwuOeWK/SU2/+ocUB+jjgKzI4ev2+zyzDYX6VdGlR2zHUCHWod79ce+xQlNsO45cSGz0A8J5WqN7o3e3uNNboryjwUNqC/r02Egs43wwYwKYi3YB0v/XYdBoZLbVh1a1NfgoC86XyovMfRXzFUc6wls9/tyLNf7kjlV1ntZj4utNUy9wYXJVu4tpyu0frcjCECyXEkL1FwxAieFzmC9yDFCFLmpvQQvvq692/GHl2i0RijZGGg7YLuEpuvwQfk3hcyBAjcnvaxpofhxM/6W6QRhQsftfq1/xX7JletQ8w4ZuXU3vXECaOjhNSeDotBMenweCKHV6dPvvYBLjdS7TMifhRHonW4zgwkIVQo/g9IVeH2iNgSgn3AmHWhsDqnKzH00Rj0wJBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(22082099003)(18002099003)(5023799004)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7kY30SVE95zb79tmeOtoVnFYrHsyLjq9kVVK5PLA4T/cCJl0/wZXpvrrZdQ1cdaLf5OTwz9JgZdPTsJlNe++kPHH7Cqggoy8kXLQPOrOTXNJmkDdv9akfaQFCykVP1dsxrqPNw0HyjJ5wwk9PbWzxR+xJAApVkJLiZaOVE1RgzEnYPM5cSAGQ/tP9oo+70vkRHiZMm51AkTsOsxxlL4GINDdfTBFM8G9AqYJ2WwyZRVSS0BGYoAYEOMdxyjq42V4Tiiwl2LUaIrsIsAXw1R0WL+GCe23OHwMmJQTvkuM0bqqzSXfxcevDkrzTk0jSM+KZIIDVBPvXaLBGPUxSsHMubklg/tTEjkxODETE/eJmZhOcstL4iJUCQshvzOq6pIR/EVnpSWpxcHujSwTFHr7ibZXjS25o0bdfXYpOTO5JBxZa9GqYIY12qVLTSXgY9ZM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:54.6903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9492cc6-b83e-4b0f-bfce-08deef48e850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462
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

Add coverage for the amdgpu_dm_crtc_set_vblank() paths reached through
amdgpu_dm_crtc_enable_vblank() and amdgpu_dm_crtc_disable_vblank():

- dm_test_crtc_enable_vblank_full_path: VRR-active enable that walks the
  vupdate-irq branch and acquires the crtc/pageflip IRQ references.
- dm_test_crtc_enable_vblank_vupdate_busy: vupdate IRQ rejection aborts
  the enable with -EBUSY.
- dm_test_crtc_enable_vblank_crtc_irq_error: crtc IRQ acquire failure
  aborts the enable with -ENOENT.
- dm_test_crtc_enable_vblank_in_reset: an in-progress GPU reset returns
  early before the vblank workqueue branch.
- dm_test_crtc_disable_vblank_vrr: the VRR disable path turns the vupdate
  IRQ off and releases both IRQ references.

Add shared IRQ-source stubs and setup helpers so amdgpu_irq_get()/put()
succeed without hardware access.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 283 ++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index fa4986153eda..753150943fba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -477,6 +477,19 @@ static struct irq_source_info_funcs dm_test_vupdate_irq_src_funcs = {
 	.ack = dm_test_vupdate_irq_src_ack,
 };
 
+/* A .set that fails so dc_interrupt_set() reports the source as busy. */
+static bool dm_test_vupdate_irq_src_set_busy(struct irq_service *irq_service,
+					     const struct irq_source_info *info,
+					     bool enable)
+{
+	return false;
+}
+
+static struct irq_source_info_funcs dm_test_vupdate_irq_src_busy_funcs = {
+	.set = dm_test_vupdate_irq_src_set_busy,
+	.ack = dm_test_vupdate_irq_src_ack,
+};
+
 /**
  * dm_test_crtc_set_vupdate_irq_enable - Test vupdate irq enable/disable success
  * @test: The KUnit test context
@@ -832,6 +845,224 @@ static void dm_test_crtc_enable_vblank_rejects_unconfigured(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), -EINVAL);
 }
 
+/* Stub IRQ source .set so amdgpu_irq_get()/put() pass their funcs->set check. */
+static int dm_test_crtc_irq_src_set(struct amdgpu_device *adev,
+				    struct amdgpu_irq_src *source,
+				    unsigned int type,
+				    enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs dm_test_crtc_irq_src_funcs = {
+	.set = dm_test_crtc_irq_src_set,
+};
+
+/*
+ * dm_test_crtc_arm_irq_src - Prime an IRQ source so get()/put() short-circuit.
+ * @test: The KUnit test context
+ * @src: The amdgpu IRQ source to arm
+ * @count: Initial per-type reference count
+ *
+ * Seeds enabled_types[AMDGPU_CRTC_IRQ_VBLANK1] with @count and installs a
+ * non-NULL funcs->set so amdgpu_irq_get()/amdgpu_irq_put() adjust the refcount
+ * without ever reaching amdgpu_irq_update() (which would touch hardware).
+ */
+static void dm_test_crtc_arm_irq_src(struct kunit *test,
+				     struct amdgpu_irq_src *src, int count)
+{
+	atomic_t *enabled;
+
+	enabled = kunit_kzalloc(test, sizeof(*enabled), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, enabled);
+
+	atomic_set(enabled, count);
+	src->num_types = 1;
+	src->enabled_types = enabled;
+	src->funcs = &dm_test_crtc_irq_src_funcs;
+}
+
+/*
+ * dm_test_crtc_setup_enable - Build an adev/CRTC primed for the vblank enable path.
+ * @test: The KUnit test context
+ * @adev_out: Receives the allocated device
+ * @dce_version: DCE version stamped on the DC (controls dc_supports_vrr())
+ *
+ * Returns a CRTC whose enable path can run to completion: a configured
+ * (enabled) CRTC with crtc_id 0, an initialized single-pipe vblank array, a DC
+ * with @dce_version, a non-reset reset_domain and a dm_crtc_state carrying a
+ * stream+link. IPS support stays disabled so drm_crtc_vblank_restore() is
+ * skipped, and the IRQ subsystem is left uninstalled for callers to arm.
+ */
+static struct amdgpu_crtc *
+dm_test_crtc_setup_enable(struct kunit *test, struct amdgpu_device **adev_out,
+			  enum dce_version dce_version)
+{
+	struct amdgpu_reset_domain *reset_domain;
+	struct dc_stream_state *stream;
+	struct dm_crtc_state *dm_state;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
+	adev->dm.dc->ctx->dce_version = dce_version;
+
+	/* crtc_id 0 maps to a valid IRQ type only when a CRTC is registered. */
+	adev->mode_info.num_crtc = 1;
+
+	reset_domain = kunit_kzalloc(test, sizeof(*reset_domain), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, reset_domain);
+	adev->reset_domain = reset_domain;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->base.enabled = true;
+	acrtc->crtc_id = 0;
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	dm_state->stream = stream;
+	acrtc->base.state = &dm_state->base;
+
+	*adev_out = adev;
+	return acrtc;
+}
+
+/**
+ * dm_test_crtc_enable_vblank_full_path - Test the enable path runs to completion
+ * @test: The KUnit test context
+ *
+ * With a configured CRTC on a VRR-capable DC and both crtc/pageflip IRQ sources
+ * armed, the enable path walks the vupdate-irq branch (VRR active, OTG
+ * unassigned so it returns early), acquires both IRQ references and completes
+ * with no vblank workqueue queued.
+ */
+static void dm_test_crtc_enable_vblank_full_path(struct kunit *test)
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
+	/* VRR active so the enable path takes the vupdate-irq branch. */
+	acrtc_state = to_dm_crtc_state(acrtc->base.state);
+	acrtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	adev->irq.installed = true;
+	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 1);
+	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 1);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
+}
+
+/**
+ * dm_test_crtc_enable_vblank_vupdate_busy - Test vupdate failure aborts enable
+ * @test: The KUnit test context
+ *
+ * When VRR is active and the DC rejects the vupdate IRQ request, the enable
+ * path must propagate the error (-EBUSY) before touching the crtc/pageflip
+ * IRQs.
+ */
+static void dm_test_crtc_enable_vblank_vupdate_busy(struct kunit *test)
+{
+	struct irq_source_info *info;
+	struct resource_pool *res_pool;
+	struct dm_crtc_state *acrtc_state;
+	struct irq_service *irqs;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	int i;
+
+	acrtc = dm_test_crtc_setup_enable(test, &adev, DCE_VERSION_8_0);
+
+	/* OTG assigned and VRR active so set_vupdate_irq() calls into DC. */
+	acrtc->otg_inst = 0;
+	acrtc_state = to_dm_crtc_state(acrtc->base.state);
+	acrtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
+
+	/* Per-source .set fails so dc_interrupt_set() reports the source busy. */
+	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
+			     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
+		info[i].funcs = &dm_test_vupdate_irq_src_busy_funcs;
+
+	irqs->info = info;
+	res_pool->irqs = irqs;
+	adev->dm.dc->res_pool = res_pool;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_enable_vblank(&acrtc->base), -EBUSY);
+}
+
+/**
+ * dm_test_crtc_enable_vblank_crtc_irq_error - Test crtc IRQ failure aborts enable
+ * @test: The KUnit test context
+ *
+ * On a non-VRR DC the vupdate-irq branch is skipped. With the IRQ subsystem
+ * uninstalled, amdgpu_irq_get() on the crtc IRQ returns -ENOENT and the enable
+ * path must propagate it before touching the pageflip IRQ.
+ */
+static void dm_test_crtc_enable_vblank_crtc_irq_error(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	/* DCE_VERSION_6_0 has no VRR, so the vupdate-irq branch is skipped. */
+	acrtc = dm_test_crtc_setup_enable(test, &adev, DCE_VERSION_6_0);
+
+	/* IRQ subsystem not installed -> amdgpu_irq_get() returns -ENOENT. */
+	adev->irq.installed = false;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_enable_vblank(&acrtc->base), -ENOENT);
+}
+
+/**
+ * dm_test_crtc_enable_vblank_in_reset - Test enable returns early during GPU reset
+ * @test: The KUnit test context
+ *
+ * After acquiring the IRQ references, an in-progress GPU reset must short the
+ * enable path so it returns 0 without queuing any vblank control work.
+ */
+static void dm_test_crtc_enable_vblank_in_reset(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	/* DCE_VERSION_6_0 has no VRR, so the vupdate-irq branch is skipped. */
+	acrtc = dm_test_crtc_setup_enable(test, &adev, DCE_VERSION_6_0);
+
+	adev->irq.installed = true;
+	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 1);
+	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 1);
+
+	/* Mid-reset: return 0 before the vblank workqueue branch is reached. */
+	atomic_set(&adev->reset_domain->in_gpu_reset, 1);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
+}
+
 /* Tests for amdgpu_dm_crtc_update_crtc_active_planes() */
 
 /**
@@ -1307,6 +1538,53 @@ static void dm_test_crtc_disable_vblank_no_irq_installed(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 0);
 }
 
+/**
+ * dm_test_crtc_disable_vblank_vrr - Test disable path releases IRQs on a VRR DC
+ * @test: The KUnit test context
+ *
+ * On a VRR-capable DC the disable path turns the vupdate IRQ off (OTG
+ * unassigned so it returns early), releases the armed crtc and pageflip IRQ
+ * references and completes without queuing vblank control work.
+ */
+static void dm_test_crtc_disable_vblank_vrr(struct kunit *test)
+{
+	struct amdgpu_reset_domain *reset_domain;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
+	/* DCE_VERSION_8_0 supports VRR -> the vupdate-irq branch is walked. */
+	adev->dm.dc->ctx->dce_version = DCE_VERSION_8_0;
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
+	/* OTG unassigned -> amdgpu_dm_crtc_set_vupdate_irq() returns 0 early. */
+	acrtc->otg_inst = -1;
+
+	amdgpu_dm_crtc_disable_vblank(&acrtc->base);
+
+	/* Both IRQ references were released without underflow. */
+	KUNIT_EXPECT_EQ(test, atomic_read(&adev->crtc_irq.enabled_types[0]), 1);
+	KUNIT_EXPECT_EQ(test, atomic_read(&adev->pageflip_irq.enabled_types[0]), 1);
+}
+
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
@@ -1352,6 +1630,10 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_set_static_screen_optimze_psr_su_skips),
 	/* amdgpu_dm_crtc_enable_vblank */
 	KUNIT_CASE(dm_test_crtc_enable_vblank_rejects_unconfigured),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_full_path),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_vupdate_busy),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_crtc_irq_error),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_in_reset),
 	/* amdgpu_dm_crtc_update_crtc_active_planes */
 	KUNIT_CASE(dm_test_crtc_update_active_planes_no_stream),
 	/* amdgpu_dm_crtc_count_crtc_active_planes */
@@ -1373,6 +1655,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_vblank_control_worker_disable_clamps_zero),
 	/* amdgpu_dm_crtc_disable_vblank */
 	KUNIT_CASE(dm_test_crtc_disable_vblank_no_irq_installed),
+	KUNIT_CASE(dm_test_crtc_disable_vblank_vrr),
 	{}
 };
 
-- 
2.34.1


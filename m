Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D04EC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71C410ED04;
	Wed,  5 Aug 2026 06:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pVIzkn6M";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FE310ED01
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsGTxi5nLft2mqeeiCW7rSJR/CEAXvmoERy5ToYz95WzHeZ9wIsI+HhieDtsg2E8psx6opPT7XxIQ/Mbs5aLculwUZrJytOC07Ekpw2MsD9YKXg9405F4xKGHpMhKEzaCw0OU748iIpmCfpswMDETJ3vJTCSlYvwPuXCSQoTCTfZ0Mfy2tFKzKT5FkFz4tJKTDU6+wbU8cGFELjX3qkczCh5BNVP3ZuGsUmt6DeTHu1mEW7gFR+Ghqu6BfDSBgad4Glo06bLyQJnVH+Ta80HTsqf/myZVRlHjidc4pmomXyq2fOw2PjZZeS8fZGV7GCUbXnwAJ/B8osJ02EldbC3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/HveZX/otCNNv3c1C0fjdAs3uAfuxCCfV65IkBd2Gg=;
 b=SLA3kT8Wss0miNhGKbpeIHslsDj2dRISJMMoFuv2tH5hZ5ywl+W04cQQIKp3iaedeXnY0pKuZcf2R4osD0znOcH+xscDf0aKYP2F0gTwR0B6Ftxyez/vAs8nDe+AtOA3tY9ZqAwTuWAVeKzfP/j5W8ock5pQq54+KYERt866HvJHZklsBEEJNUuCvvuSCkp4pcZywyw34dDBgDyNCo6/h4cNIXNUfE5uO4Way25LHK+N/mBkaCWnuiACdsTLl7tdp+YAQLBKyC6cv6EFuAu0hovfvD22Z7u1EnEI5rURUgE/0F3HGl/JQfmhp0Kocqz8ywzBBGtcqN5XHaKj0aw7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/HveZX/otCNNv3c1C0fjdAs3uAfuxCCfV65IkBd2Gg=;
 b=pVIzkn6MokfftIlOh9qsAE65uBHzzeJ2plQQimRkVf20IWtpF8wl0JXmr8g+51PHhY38ZElxSWl/hLyjRVvpJ0mUydIgROBL15UbMedSAzpBkhOX22G/GfckmFEcet9VqjE3ZWxqyn2kqdNkChAuzhUSdMLNM4GmXc75qbO/X6g=
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 06:40:29 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::95) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:26 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 09/34] drm/amd/display: Add KUnit tests for
 amdgpu_dm_crtc_helper_atomic_check
Date: Wed, 5 Aug 2026 14:36:21 +0800
Message-ID: <20260805063937.2145774-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: fadb156f-0ed9-4c88-e046-08def2bc70e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BGQBzeORGMKphj5EM60qu1QCgDSI9ORIFnpCxVFylnT8zvIWgGViS9lr+O1+EjpgYvBDNL7/1QKuDlr7fTV+g28xWAecRWHacNUKgr2pKnfNAZYFG/lAjtDMxkGu3kPnE6c2+O7nTQdMhXlATutJo4mmpSYpVrODe9fkIPY60pUfta0JMHLbBlQkzb09ShaOgg3SGqvzlBPnGusxNcThltqlfkjj+Ex9RUlrzdfIAyYYDTmrqq58dXu0Uk2fySg/Df1yIX4SmYAe1erpWPpLt1Crly1QacPjbOVhYdxXHmr6wFWuwkE/1SYt+5HUwjbS8a0OUnuco1cXbfGubibOTJgR4z5MTOeIxW3KmoLCyHUynSxLhlOyjbvBhajrYV+If2bYB/JvIUnI/z+g7g1GDBRebcwy5SRhpDZtJc2G17Y4zarswgknWwE0Q5v6HpYxLJQpJhmGgjmhoEC+diDFtvhYK870iwuS+DkP6Qu2x7UWfkvcvYgrdPFpl9LRt8/CQ2F9TxS7GwIsekBApT0p5eul26Qy1b6CcArRFfaf2XdRlCjKEcfASBYA1t7yAELo1IPNyF5sL8lTS82HdHYKW2sGFLBU/01wY99e5y0t2NAJP5iwMKwAfrbpxvxdIjcpZkF25brNhIv1vVqBegcHmcCa+wrZpOHmWel8oz3Ia+7Oq9lBqWm1DXQpofL4fthxfXRgvVllZ1ExE7yzeMo6IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V9nl8qMpR3IuhGUw6JaUZg0VPb8aQ6Hla/QfMTp8JUNCfOVn96HfVp4hezqi+VGmFA0U2TatFjltrANBnKHpqSFJqNn5epaH6WatkZ3YOr027d3ZwlIkUbu8fDyAyahEHfKOQaaWndWK5qjxYNl6/8FryGWrwOV8Smbi4Ys5umEJRgOKODz1CSeOGpvyATc96gNKtZmvizRDAK/XPYViN4CQlYOnLKaLSrIdgSBGwtmtzz54nTrhJMyljiET1bA0RJrl3RP+4spe7LQpGuhB4UumDg/385rcwmhBUtW6EJcFnhGakc750K1R0cXPphYN8KAc8eGrYtzkl6QqtCBD1pzA82IsAViv0ffkyYbeb6WZPfVxB3mpK2f3VGcHki5rkinHwuJohM2V6qLMR2YJdkIaePpTKHoUESrTBmshlaGjNdGpPTmhT6Eh5tERZjiD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:29.3924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fadb156f-0ed9-4c88-e046-08def2bc70e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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
Expand CRTC KUnit coverage to the atomic_check helper so its branch
behaviour is exercised and protected against regressions.

how:
Expose amdgpu_dm_crtc_helper_atomic_check for KUnit (STATIC_IFN_KUNIT +
EXPORT_IF_KUNIT + header declaration). Add tests covering the no-stream
(reset) pass, enabled-CRTC-without-primary rejection, async-flip non-fast
rejection, the VRR primary-plane pull path, and DC stream validation
pass/fail using timing_generator and link_service stubs.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 345 ++++++++++++++++++
 3 files changed, 349 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index b640e4cc37c3..261bf05c2084 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -646,7 +646,7 @@ STATIC_IFN_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_helper_mode_fixup);
 
-static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 					      struct drm_atomic_commit *state)
 {
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
@@ -708,6 +708,7 @@ static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	DRM_DEBUG_ATOMIC("Failed DC stream validation\n");
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_helper_atomic_check);
 
 static const struct drm_crtc_helper_funcs amdgpu_dm_crtc_helper_funcs = {
 	.disable = amdgpu_dm_crtc_helper_disable,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index a2b105a496e0..7de79796a56d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -56,6 +56,8 @@ void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 					      struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
 void amdgpu_dm_idle_worker(struct work_struct *work);
+int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
+				       struct drm_atomic_commit *state);
 #ifdef CONFIG_DEBUG_FS
 int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 1a48c6fea8d8..a88175d99092 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -15,6 +15,8 @@
 #include "dc.h"
 #include "inc/core_types.h"
 #include "irq/irq_service.h"
+#include "inc/hw/timing_generator.h"
+#include "inc/link_service.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
@@ -2136,6 +2138,342 @@ static void dm_test_crtc_init_enables_degamma(struct kunit *test)
 		cursor->funcs->destroy(cursor);
 }
 
+/* Tests for amdgpu_dm_crtc_helper_atomic_check() */
+
+/**
+ * dm_test_crtc_atomic_check_no_stream_passes - Test atomic_check with no stream
+ * @test: The KUnit test context
+ *
+ * A CRTC state without a stream (as during reset) and with no modeset
+ * requirement must pass atomic_check and return 0 before reaching DC stream
+ * validation.
+ */
+static void dm_test_crtc_atomic_check_no_stream_passes(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	dm_crtc_state->base.crtc = crtc;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = &adev->ddev;
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+	dm_crtc_state->base.state = state;
+
+	ret = amdgpu_dm_crtc_helper_atomic_check(crtc, state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/* Stubs for the DC stream validation branches of atomic_check. */
+static bool dm_test_atomic_check_validate_timing_ok(struct timing_generator *tg,
+						    const struct dc_crtc_timing *timing)
+{
+	return true;
+}
+
+static bool dm_test_atomic_check_validate_timing_fail(struct timing_generator *tg,
+						      const struct dc_crtc_timing *timing)
+{
+	return false;
+}
+
+static enum dc_status dm_test_atomic_check_validate_mode_timing_ok(const struct dc_stream_state *stream,
+								  struct dc_link *link,
+								  const struct dc_crtc_timing *timing)
+{
+	return DC_OK;
+}
+
+/**
+ * dm_test_crtc_atomic_check_enable_without_primary_fails - Enabled CRTC needs primary
+ * @test: The KUnit test context
+ *
+ * An enabled CRTC whose primary plane is not part of the plane mask must be
+ * rejected with -EINVAL.
+ */
+static void dm_test_crtc_atomic_check_enable_without_primary_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_plane *primary;
+	struct drm_crtc *crtc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+	crtc->primary = primary;
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->base.enable = true;
+	dm_crtc_state->base.plane_mask = 0;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = &adev->ddev;
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+	dm_crtc_state->base.state = state;
+
+	ret = amdgpu_dm_crtc_helper_atomic_check(crtc, state);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_crtc_atomic_check_async_flip_non_fast_fails - Async flip needs fast update
+ * @test: The KUnit test context
+ *
+ * An async flip is only permitted for fast updates; a non-fast update type must
+ * be rejected with -EINVAL.
+ */
+static void dm_test_crtc_atomic_check_async_flip_non_fast_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->base.async_flip = true;
+	dm_crtc_state->update_type = UPDATE_TYPE_FULL;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = &adev->ddev;
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+	dm_crtc_state->base.state = state;
+
+	ret = amdgpu_dm_crtc_helper_atomic_check(crtc, state);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_crtc_atomic_check_vrr_pulls_primary - VRR path pulls in primary plane
+ * @test: The KUnit test context
+ *
+ * When VRR is active and the update is not a legacy cursor update, atomic_check
+ * pulls in the primary plane state. With an existing primary plane state already
+ * present and no stream attached, the check returns 0.
+ */
+static void dm_test_crtc_atomic_check_vrr_pulls_primary(struct kunit *test)
+{
+	struct drm_plane_state *primary_plane_state;
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_plane *primary;
+	struct drm_crtc *crtc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+	crtc->primary = primary;
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = &adev->ddev;
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+	dm_crtc_state->base.state = state;
+
+	/* acquire ctx must be set; existing plane state avoids taking a lock. */
+	state->acquire_ctx = kunit_kzalloc(test, sizeof(*state->acquire_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->acquire_ctx);
+	state->planes = kunit_kzalloc(test, sizeof(*state->planes), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->planes);
+	primary_plane_state = kunit_kzalloc(test, sizeof(*primary_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary_plane_state);
+	state->planes[0].new_state = primary_plane_state;
+
+	ret = amdgpu_dm_crtc_helper_atomic_check(crtc, state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_crtc_atomic_check_valid_stream_passes - Valid DC stream passes
+ * @test: The KUnit test context
+ *
+ * With a stream attached and DC stream validation returning DC_OK, atomic_check
+ * must return 0.
+ */
+static void dm_test_crtc_atomic_check_valid_stream_passes(struct kunit *test)
+{
+	struct timing_generator_funcs *tg_funcs;
+	struct timing_generator *tg;
+	struct resource_pool *res_pool;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+	struct drm_crtc *crtc;
+	struct dc *dc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg);
+	tg_funcs = kunit_kzalloc(test, sizeof(*tg_funcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg_funcs);
+	tg_funcs->validate_timing = dm_test_atomic_check_validate_timing_ok;
+	tg->funcs = tg_funcs;
+	res_pool->timing_generators[0] = tg;
+	dc->res_pool = res_pool;
+
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	link_srv->validate_mode_timing = dm_test_atomic_check_validate_mode_timing_ok;
+	dc->link_srv = link_srv;
+	adev->dm.dc = dc;
+
+	link = dm_kunit_alloc_link(test);
+	link->ep_type = DISPLAY_ENDPOINT_UNKNOWN;
+	stream = dm_kunit_alloc_stream(test, link);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->stream = stream;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = &adev->ddev;
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+	dm_crtc_state->base.state = state;
+
+	ret = amdgpu_dm_crtc_helper_atomic_check(crtc, state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_crtc_atomic_check_invalid_stream_fails - Invalid DC stream fails
+ * @test: The KUnit test context
+ *
+ * With a stream attached but DC stream validation failing (timing rejected),
+ * atomic_check must return -EINVAL.
+ */
+static void dm_test_crtc_atomic_check_invalid_stream_fails(struct kunit *test)
+{
+	struct timing_generator_funcs *tg_funcs;
+	struct timing_generator *tg;
+	struct resource_pool *res_pool;
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+	struct drm_crtc *crtc;
+	struct dc *dc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg);
+	tg_funcs = kunit_kzalloc(test, sizeof(*tg_funcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg_funcs);
+	tg_funcs->validate_timing = dm_test_atomic_check_validate_timing_fail;
+	tg->funcs = tg_funcs;
+	res_pool->timing_generators[0] = tg;
+	dc->res_pool = res_pool;
+	adev->dm.dc = dc;
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->stream = stream;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	state->dev = &adev->ddev;
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+	dm_crtc_state->base.state = state;
+
+	ret = amdgpu_dm_crtc_helper_atomic_check(crtc, state);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
@@ -2224,6 +2562,13 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_init */
 	KUNIT_CASE(dm_test_crtc_init_registers_crtc),
 	KUNIT_CASE(dm_test_crtc_init_enables_degamma),
+	/* amdgpu_dm_crtc_helper_atomic_check */
+	KUNIT_CASE(dm_test_crtc_atomic_check_no_stream_passes),
+	KUNIT_CASE(dm_test_crtc_atomic_check_enable_without_primary_fails),
+	KUNIT_CASE(dm_test_crtc_atomic_check_async_flip_non_fast_fails),
+	KUNIT_CASE(dm_test_crtc_atomic_check_vrr_pulls_primary),
+	KUNIT_CASE(dm_test_crtc_atomic_check_valid_stream_passes),
+	KUNIT_CASE(dm_test_crtc_atomic_check_invalid_stream_fails),
 	{}
 };
 
-- 
2.43.0


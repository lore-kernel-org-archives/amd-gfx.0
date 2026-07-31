Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245EEC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6702710F42A;
	Fri, 31 Jul 2026 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eWqCo71Q";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244B410F3FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJCU7Xa582B5vqFyA338WFIlbmqqWXeGlr3fWJdr2rtQhs5u/gDr4TlR/LY9gAHKd/p/hFYZtTmrSDMpveobk93y406B7d6T2RCXddJ6ehicYZ+m5PJ3mgz2Kci9xbrDaWmLpboyTD6MViq19xXLbW/dhJ/pQBrZN/QOrRTZzSWJ0sxKh/uBc1aiUoWEdvpcT80u+MGmb4EEBP2OgcP8+11q+YGKUUmSahfxBGS6HjfxSadZipmtzseQ+GA/NJlwK1eZN4FvWYCWJhVl5X2fRI0R02JU48QHsdXsC2EKEoHrapWvkd7IYdi9qQBm4BK53atCICufmr2WUj4VqpoCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoLzon64i/pHsZEnMKTZiRKmM06+6KczPq2zLLGSw2c=;
 b=iVBKkxwNB8OZ/fCFduhv48oRlQTWaiDz8JEYcWl6ZERktcz7WAw28TMKAAlAoLAKnF5Epq2Gho7WRN50s3xpmd2XGmfGB6s1VHKf4hJVqErMeb95NEk1ea2xpDGRiGQ58g+eXJcrf/+LeHRe1aSSWloUAiokZauMKXlTtRF48CMOH67GEPtPxYsh5ibSTM+1OfU34zq3dIh9vqOM+4nBrYsMTQDSrXV7RZSjcKS+XDM7IeSAD1bsevivGl2CqUAm41pcirW+OmlyHQpW5+YsReUxmztmQ97uNvv7sH+xUaH2Dn4kKNKug3H55EuoTsTCh/yUGbUEFrJ56BP/bBhaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoLzon64i/pHsZEnMKTZiRKmM06+6KczPq2zLLGSw2c=;
 b=eWqCo71QEmFI9isjgF0fdmSBAP1wyYITwc1qqk/yTdccl85IGMlz79GvXs3cjeYEiqRwzt4XIVI4zUHN8h9IB1S8RDsL9MygBcuiOXMYce3DbMhrsSeGoWeFabJZGwU63VGbgKnV/8YB/L9cKqjE2lb/53FUaFNALG7YU0uS4+Q=
Received: from BN9PR03CA0148.namprd03.prod.outlook.com (2603:10b6:408:fe::33)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:44 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::29) by BN9PR03CA0148.outlook.office365.com
 (2603:10b6:408:fe::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Fri,
 31 Jul 2026 21:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 14:15:43 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 15/41] drm/amd/display: Add vblank handling tests for crtc
Date: Fri, 31 Jul 2026 17:12:36 -0400
Message-ID: <20260731211302.3040343-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 653bec34-2549-4f1c-7df6-08deef48e21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +hxCh/g581jyJziafL2+qLkpW0GnovAIYUIYQ2fJ5YDrwlam3QGSdg+cnt5IoIe0kFkSCmLIkfcht+dSuxGPgnl1QQD345gFK8KJCezyI3axukixSC1rCWEBejwNQLDe9itQE3fXBSyC6IeZoZ70zCk4PYFqLbzyE2K77FMVxxYi+atONOyDfBa45inrYUWOCYXmVHGfJVnXl9Vj9Jy2Y6T0pzfJIT3oEroYOwTVxBTZxiMh1fm6f29fW0R7dpegSuGuOcOAnVDjH/9RItjjIO0+WZrttZz+HeVVicDRmrraz7viGqQQZjejl6N/p4OZ58EsT0Riybonp1oIyzW4i1aLoNr/F1ugbUERQDRffQ+uTECOwfi15JTGOZB5CleJ87WhpRPHSp/XBErYrrAG0U0hoDzgDjjzLRVC5gWixJ3CmQHBPbWN8wK/RBY6t9H6cDTqrMc/ZaLJlOM66dLzEcjN5zx0Ts6GnQ/sfE3Khh0EHuKrnB6y/EhviNucTSUR6Qhd1a5UBCBt6xAoqxve4XJfpMG06/bRGyxi316o5jNYoUgj0vLW3Xi1G9+t+e/Liio3RU6IkMESRPT037mN1EaVMyWFFqtLf1Ie9OAiPXQ/V7SoycnQgnHwB98/I4hMWBuxLO9wBTXugCNl1HTyU3XGxzxeiG5c+4BZEk5tx3/hYATZq3WDNEfTOkZGvqUlxxhflTbaOis1CharVjvIkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gSBd3jIoBfj3SdkRApbVn+TvLAJyWZO1GqK68Ep+1i1Hh4ShY9wP1nAVw2ivfae3E6sB5h3j5Hvr1jay8ojS9gmLJel1Tj03nQFDJ3dDWc8sHgrzylriUejefJOLh6Db/Lq4kkH/MPQe6Vp2n+xr5UKybdGXUer5DQ3qfxOTF8r4q50zcHHxf/YqB4DaDIkCf2Z/B/DfHeF5QC2zn0q4iEL3I8cvpDojp225ru42e+Zi1IqB1zolltswUtKXxIBGPGepAjObb+oRNG+to21NnIJ24JVKVK6ChMgnfTvLzPppOISqSlxP5V2H1NG5g6ZLonH73edX5rB7qejXOesL2NIgC4bDrsQlPamxmkb0Hq2OIFgxBdcrNeO2Ts7cePm7JwOzG2KtQXK7Ue0FhUDlV2ylBsxpO67r5opdq2HJLt14WV93umY9rbuKsaV9R4rD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:44.3079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 653bec34-2549-4f1c-7df6-08deef48e21e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

Add KUnit coverage for the CRTC vblank paths:

- amdgpu_dm_crtc_handle_vblank: no-event completion and the
  AMDGPU_FLIP_SUBMITTED guard that keeps a pending event pending.
- amdgpu_dm_crtc_vblank_control_worker: enable increments, disable
  decrements, and disable clamps the active vblank IRQ count at zero.
- amdgpu_dm_crtc_disable_vblank: disable path returns cleanly when the
  IRQ subsystem is not installed.

Expose amdgpu_dm_crtc_vblank_control_worker for KUnit via
STATIC_IFN_KUNIT/EXPORT_IF_KUNIT and declare it in the header.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 213 ++++++++++++++++++
 3 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index ce42102109bb..2a4e241350f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -59,6 +59,7 @@ void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
 
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_handle_vblank);
 
 bool amdgpu_dm_crtc_modeset_required(struct drm_crtc_state *crtc_state,
 			     struct dc_stream_state *new_stream,
@@ -216,7 +217,7 @@ struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(idle_create_workqueue);
 
-static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
@@ -241,6 +242,7 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 
 	kfree(vblank_work);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_vblank_control_worker);
 
 static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 {
@@ -400,6 +402,7 @@ void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	amdgpu_dm_crtc_set_vblank(crtc, false);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_disable_vblank);
 
 STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index ed6e8021d69e..c68b7b2e1916 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -52,6 +52,7 @@ struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 					      struct drm_crtc_state *new_crtc_state);
+void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
 #endif
 
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index ce20692959d0..4d4b4061c789 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -9,6 +9,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_vblank.h>
 
 #include "dc.h"
 #include "amdgpu.h"
@@ -621,6 +622,209 @@ static void dm_test_crtc_destroy_state_no_stream(struct kunit *test)
 	amdgpu_dm_crtc_destroy_state(NULL, &dm_state->base);
 }
 
+/**
+ * dm_test_crtc_handle_vblank_no_event - Test vblank handling with no pending event
+ * @test: The KUnit test context
+ *
+ * With no flip event pending, handling a vblank must complete without sending a
+ * vblank event and must leave acrtc->event untouched (NULL).
+ */
+static void dm_test_crtc_handle_vblank_no_event(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	/* Initialise vblank so drm_crtc_handle_vblank() runs cleanly. */
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->event = NULL;
+
+	amdgpu_dm_crtc_handle_vblank(acrtc);
+
+	KUNIT_EXPECT_NULL(test, acrtc->event);
+}
+
+/**
+ * dm_test_crtc_handle_vblank_skips_when_flip_submitted - Test event kept on submit
+ * @test: The KUnit test context
+ *
+ * A pending event whose flip is still AMDGPU_FLIP_SUBMITTED must not be signalled
+ * on vblank; acrtc->event must remain set for later completion.
+ */
+static void dm_test_crtc_handle_vblank_skips_when_flip_submitted(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	event = kunit_kzalloc(test, sizeof(*event), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	acrtc->base.dev = &adev->ddev;
+	acrtc->event = event;
+	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
+
+	amdgpu_dm_crtc_handle_vblank(acrtc);
+
+	/* Flip still in-flight: event must be preserved, not signalled. */
+	KUNIT_EXPECT_PTR_EQ(test, acrtc->event, event);
+}
+
+/**
+ * dm_test_vblank_control_worker_setup - Build a vblank_control_work for the worker
+ * @test: The KUnit test context
+ * @enable: Value for vblank_work->enable
+ * @count: Initial dm->active_vblank_irq_count
+ *
+ * Returns a work item wired to a freshly allocated adev/crtc/stream. The CRTC is
+ * left without an atomic state so amdgpu_dm_ism_commit_event() short-circuits and
+ * only the vblank IRQ accounting in the worker runs.
+ */
+static struct vblank_control_work *
+dm_test_vblank_control_worker_setup(struct kunit *test, bool enable,
+				    uint32_t count)
+{
+	struct dc_stream_state *stream;
+	struct vblank_control_work *work;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
+	adev->dm.active_vblank_irq_count = count;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->base.state = NULL;
+
+	stream = dm_kunit_alloc_stream(test, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	/* Worker releases the stream; keep an extra ref so kunit owns the free. */
+	kref_get(&stream->refcount);
+
+	/* Worker kfree()s the work item, so it must be a plain allocation. */
+	work = kzalloc_obj(*work, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, work);
+	work->dm = &adev->dm;
+	work->acrtc = acrtc;
+	work->stream = stream;
+	work->enable = enable;
+
+	return work;
+}
+
+/**
+ * dm_test_vblank_control_worker_enable_increments - Test enable bumps IRQ count
+ * @test: The KUnit test context
+ *
+ * Running the worker with enable set must increment the active vblank IRQ count.
+ */
+static void dm_test_vblank_control_worker_enable_increments(struct kunit *test)
+{
+	struct vblank_control_work *work;
+	struct amdgpu_display_manager *dm;
+
+	work = dm_test_vblank_control_worker_setup(test, true, 0);
+	dm = work->dm;
+
+	amdgpu_dm_crtc_vblank_control_worker(&work->work);
+
+	KUNIT_EXPECT_EQ(test, dm->active_vblank_irq_count, 1);
+}
+
+/**
+ * dm_test_vblank_control_worker_disable_decrements - Test disable drops IRQ count
+ * @test: The KUnit test context
+ *
+ * Running the worker with enable clear must decrement a non-zero active vblank
+ * IRQ count.
+ */
+static void dm_test_vblank_control_worker_disable_decrements(struct kunit *test)
+{
+	struct vblank_control_work *work;
+	struct amdgpu_display_manager *dm;
+
+	work = dm_test_vblank_control_worker_setup(test, false, 2);
+	dm = work->dm;
+
+	amdgpu_dm_crtc_vblank_control_worker(&work->work);
+
+	KUNIT_EXPECT_EQ(test, dm->active_vblank_irq_count, 1);
+}
+
+/**
+ * dm_test_vblank_control_worker_disable_clamps_zero - Test disable clamps at zero
+ * @test: The KUnit test context
+ *
+ * Disabling when the active vblank IRQ count is already zero must not underflow.
+ */
+static void dm_test_vblank_control_worker_disable_clamps_zero(struct kunit *test)
+{
+	struct vblank_control_work *work;
+	struct amdgpu_display_manager *dm;
+
+	work = dm_test_vblank_control_worker_setup(test, false, 0);
+	dm = work->dm;
+
+	amdgpu_dm_crtc_vblank_control_worker(&work->work);
+
+	KUNIT_EXPECT_EQ(test, dm->active_vblank_irq_count, 0);
+}
+
+/**
+ * dm_test_crtc_disable_vblank_no_irq_installed - Test disable with IRQ uninstalled
+ * @test: The KUnit test context
+ *
+ * Disabling vblank walks amdgpu_dm_crtc_set_vblank()'s disable path. With the
+ * IRQ subsystem not installed, amdgpu_irq_put() returns early so the routine
+ * completes without touching the vblank workqueue or the active IRQ count.
+ */
+static void dm_test_crtc_disable_vblank_no_irq_installed(struct kunit *test)
+{
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
+	adev->dm.active_vblank_irq_count = 0;
+
+	/* No CRTCs registered and IRQs not installed -> irq_put returns early. */
+	adev->mode_info.num_crtc = 0;
+	adev->irq.installed = false;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->crtc_id = 0;
+
+	amdgpu_dm_crtc_disable_vblank(&acrtc->base);
+
+	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 0);
+}
+
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
@@ -665,6 +869,15 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
 	/* amdgpu_dm_crtc_destroy_state */
 	KUNIT_CASE(dm_test_crtc_destroy_state_no_stream),
+	/* amdgpu_dm_crtc_handle_vblank */
+	KUNIT_CASE(dm_test_crtc_handle_vblank_no_event),
+	KUNIT_CASE(dm_test_crtc_handle_vblank_skips_when_flip_submitted),
+	/* amdgpu_dm_crtc_vblank_control_worker */
+	KUNIT_CASE(dm_test_vblank_control_worker_enable_increments),
+	KUNIT_CASE(dm_test_vblank_control_worker_disable_decrements),
+	KUNIT_CASE(dm_test_vblank_control_worker_disable_clamps_zero),
+	/* amdgpu_dm_crtc_disable_vblank */
+	KUNIT_CASE(dm_test_crtc_disable_vblank_no_irq_installed),
 	{}
 };
 
-- 
2.34.1


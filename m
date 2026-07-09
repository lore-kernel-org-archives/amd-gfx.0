Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C5BC44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518BA10F6D0;
	Thu,  9 Jul 2026 21:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kUofGQgv";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90D210F6CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoBfztR8Sn86vmh/c3K0kf9JDoaSs3fVaGb2Fyh245226ICEx7c2lQdLGO6L1RO0zKxaIamtX6q+EP8jL3ss+Q31yNpPR8vM2KPIReZ3nXyvWq7pCO87b5JJN1YoSHcHQHy5saXnFiq4WFWNx5DmZdgiEIQOeOsxfU2YIphE++dtrBs3Jx63QVmRm1Se9bQuNjjNosHu+gwshTC9YyEK2WHTI5wWel8JmAINnTZrF3qv1BZPl2sANSgmw12Sn9S1RBP5wgaxhr+gSrXoLc/tqM7apzISa/0z3p0DyppVY5FFr0pX/KgEKNgTgJZlQsSQP5tu3JfR/ulc5fHd4zv9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v7z3ky/StrIrt9kLXFw36IFiXbW1SdNasjG5tXiGkQ=;
 b=C1SW/yo51JNU9rDkVc56RaKfp+modOXm7eBHcOBP3XiNpjzmm4tpWW/6LiJe9LJWyiUjFcA+PloC0pqgzPSkjyOSsSTX8VFT5aL4/I4/vYeXcJp1vSIpiexx8o5ojN36I0FcSn7NtA3QWyxKS1fBPa9nZQ0jN6KzXfMXOJmolacgfEW1/0TfrJQyXJRhfzI81S5uD/J5lIxqT9NA0/TPF3DNTelhD2VABMfxDQlW3Hn1KgZUNgzURQBSqzqASCfNxBrAqLBSL8pcz8AkYc6lgoKatmJkWYi07EAjGCby6QnMZ41cHchEJLUw0uekWmmZWEOI2CsvGerdGp9Ia3HouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v7z3ky/StrIrt9kLXFw36IFiXbW1SdNasjG5tXiGkQ=;
 b=kUofGQgvsUWdVdw2jTpCf+tFiVp2Lr+T8mpoAWM4BeEhXLiER9yd0qTZ2/ScmatUSkk0gdAenf8zvNHcnx3uYgWUDcI5VlUJcK+lAetgsuWRJZ+8OVUN1gNk0u9mOLhhhiCioep+vg2F0FuCR/Na9nA66693n3mCp0/uams8ekk=
Received: from MN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:208:52d::24)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 21:02:10 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::d) by MN0PR04CA0025.outlook.office365.com
 (2603:10b6:208:52d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:10 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:48 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 17/80] drm/amd/display: Add KUnit tests for ism
Date: Thu, 9 Jul 2026 16:47:45 -0400
Message-ID: <20260709205936.5719-18-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e02227-99eb-4074-4966-08deddfd5820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|5023799004|11063799006|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: k7APTp7FgqB5raxibODQj+cX9N/QtjNRfi3g5jtH8Pg2x9+RxgHFuTb9YpjTTw8w8FAYmqUaJrNGpgtXeHfMrE70bdni3QpTCOXWELzHL38fN8uaoFROAlcf4V1HwAtnCaI5U1w9ZWlnfwpJzTOPOcPwQHNNZOhnstsGtNZqxoB12mu6XcTwsPkWptrCgg1rKpa0LtydyH3BJKZQ89K9JPLe5ZyXzHSvRURXg074Bz1cNf+9WqCcezU9/wsVM09q/Xci8xC4NVvm+0OAgp00NaHRzpfVaOWYoIRithOQZ9yWlfEt6ZWTpSGZX8pGK2NdXPg6BYSdWjzbBe4q/t5Vc3ztJhEAQnSyZq5/nfKIXOHwhTvKgoBUL488cd0/TQH7NiuTnxDlOu6MAhHCniul9KiW0YYlZDAjcZQaK9KfvbBv+I0un/J0QRf6Y5aeK69lj+y+40ckYRGeGjw5H1hFXnUuvuHSnCNXk1T+obr7RxKKPW41flPOClMqTc+ThYCk5ukINnVmBMWlmZmN0ml0fm3vFIBYxnyRtoN8nHnO8zEXmfpCKGpu0+JqK08Bnl2MRseySl3cNYoxGx0vwtCDVyLXt6bMPxGrL9j3erQweXDtkTLX+1wW00sls9J7GkJoyKKFhZhPLmaokgndOcZERC6c0zmRpgg+Y3ilQ3FbpqQDl0GrqH1j7aZEKkPJ3i1C+x1thDvrTrEi6FIZDqEL0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bXcDugMkGsQWm1TBEE8qqrU4liZbklKw6VZewekFzWe0OFSPDr5TUclZxHyQeIFDk/VU3dPfXcRDClg5NEQoSuP0mmQ/vwnqmV8WOdl4gSJJNAWckZ0JYOswefCKzGLrTerkUE2sYImUmO0cTs9dZwiR3aM13rNuS/RmimslHWN5cPYyQjfszCU+aHF/wgoeF4NDpe3oa5bQoVLYCkR5s2eJEUN2Lcgi/aBgu+2yRtkMMt/WEd7OGYwZwJRGx1SMas9q2r0mhUA4/Vr5mfidO6C4KKlijMQfF4AytJqaqG6eo5MHSOqYDOY0xcySIiTRWJ76vUbDjgf11mFuv5PrrS82Yh6/XXe9IKbKHdBb338Kxm361c+41ip6ifuZq27henyXILplKUE1kuhfhyVQT/STfB2g17OfNR9C7S3KQJcVpPy3zIQVOUtM5nBauiLH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:10.7847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e02227-99eb-4074-4966-08deddfd5820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759
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

Add KUnit coverage for the following ISM functions:

- dm_ism_next_state(): state transitions for running, busy,
  hysteresis-wait, optimized-idle, and aborted states
- dm_ism_get_sso_delay(): null stream, zero frames, 1080p60 3-frame,
  and 4k60 1-frame calculations
- dm_ism_get_idle_allow_delay(): null stream, zero filter/entry/delay
  frames, short-idle filtering, wrap-around, old history cutoff,
  mixed durations, and entry count exceeding history size
- amdgpu_dm_ism_init(): initial state setup
- amdgpu_dm_ism_fini(): cleanup after init
- dm_ism_set_last_idle_ts(): timestamp update
- dm_ism_insert_record(): basic insert and wrap-around
- dm_ism_trigger_event(): valid and invalid transitions

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 353 ++++++++++++++++++
 2 files changed, 357 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 32391b56097e..a9575bf25fc2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -502,6 +502,7 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,

 	} while (next_event < DM_ISM_NUM_EVENTS);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_ism_commit_event);


 static void dm_ism_delayed_work_func(struct work_struct *work)
@@ -568,6 +569,7 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 		disable_delayed_work_sync(&ism->sso_delayed_work);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_ism_disable);

 /**
  * amdgpu_dm_ism_force_full_power - Force every CRTC's ISM FSM to FULL_POWER
@@ -603,6 +605,7 @@ void amdgpu_dm_ism_force_full_power(struct amdgpu_display_manager *dm)
 					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_ism_force_full_power);

 /**
  * amdgpu_dm_ism_enable - enable the ISM
@@ -626,6 +629,7 @@ void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm)
 		enable_delayed_work(&ism->sso_delayed_work);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_ism_enable);

 void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
 			struct amdgpu_dm_ism_config *config)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index 7dfb3b351d20..6394b967ac3a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -8,6 +8,9 @@
 #include <kunit/test.h>

 #include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
 #include "amdgpu_dm_ism.h"
 #include "amdgpu_dm_kunit_test_helpers.h"

@@ -848,6 +851,345 @@ static void dm_test_dispatch_next_event_no_action_state(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)result, (int)DM_ISM_NUM_EVENTS);
 }

+/*
+ * Helper: allocate an amdgpu_crtc (which embeds the ISM) wired up to a
+ * minimally-populated amdgpu_device so that the container_of()/drm_to_adev()
+ * lookups inside the ISM event machinery resolve correctly.
+ *
+ * The amdgpu_device is large, so it must be heap-allocated via kunit_kzalloc.
+ * acrtc->base.dev points at the embedded &adev->ddev, which is what
+ * drm_to_adev() expects (it is a container_of of ddev).
+ */
+static struct amdgpu_crtc *alloc_test_acrtc(struct kunit *test,
+					    struct amdgpu_device **adev_out)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dc *dc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	adev->dm.dc = dc;
+	adev->dm.ddev = &adev->ddev;
+	mutex_init(&adev->dm.dc_lock);
+
+	acrtc->base.dev = &adev->ddev;
+
+	if (adev_out)
+		*adev_out = adev;
+
+	return acrtc;
+}
+
+/*
+ * Helper: register an already-allocated amdgpu_crtc into the DRM device's
+ * crtc_list so that drm_for_each_crtc() iterates it. Only the list linkage is
+ * required for the ISM enable/disable/force-full-power helpers.
+ */
+static void register_test_acrtc(struct amdgpu_device *adev,
+				struct amdgpu_crtc *acrtc)
+{
+	INIT_LIST_HEAD(&adev->ddev.mode_config.crtc_list);
+	INIT_LIST_HEAD(&acrtc->base.head);
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+}
+
+/* ===== Tests for amdgpu_dm_ism_commit_event ===== */
+
+/**
+ * dm_test_ism_commit_event_no_state - commit_event returns early without a crtc state
+ * @test: KUnit test context
+ *
+ * When the CRTC has no atomic state (base.state == NULL) the function takes
+ * the NO_STATE early-return path and the FSM is left untouched.
+ */
+static void dm_test_ism_commit_event_no_state(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = { 0 };
+
+	amdgpu_dm_ism_init(&acrtc->ism, &config);
+	acrtc->base.state = NULL;
+
+	guard(mutex)(&adev->dm.dc_lock);
+	amdgpu_dm_ism_commit_event(&acrtc->ism,
+				   DM_ISM_EVENT_BEGIN_CURSOR_UPDATE);
+
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_commit_event_cursor_transition - cursor begin/end drive FSM without DC work
+ * @test: KUnit test context
+ *
+ * BEGIN_CURSOR_UPDATE then END_CURSOR_UPDATE from FULL_POWER_RUNNING traverse
+ * the FULL_POWER_BUSY state. Neither transition reaches the idle-optimization
+ * commit path, so no DC hardware access occurs and the FSM returns to
+ * FULL_POWER_RUNNING.
+ */
+static void dm_test_ism_commit_event_cursor_transition(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct dm_crtc_state *dm_state;
+	struct amdgpu_dm_ism_config config = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	amdgpu_dm_ism_init(&acrtc->ism, &config);
+	acrtc->base.state = &dm_state->base;
+
+	guard(mutex)(&adev->dm.dc_lock);
+	amdgpu_dm_ism_commit_event(&acrtc->ism,
+				   DM_ISM_EVENT_BEGIN_CURSOR_UPDATE);
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_FULL_POWER_BUSY);
+
+	amdgpu_dm_ism_commit_event(&acrtc->ism,
+				   DM_ISM_EVENT_END_CURSOR_UPDATE);
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_commit_event_invalid_event - invalid event leaves FSM unchanged
+ * @test: KUnit test context
+ *
+ * EXIT_IDLE_REQUESTED is not a valid event from FULL_POWER_RUNNING, so the
+ * FSM does not transition and no power-state dispatch occurs.
+ */
+static void dm_test_ism_commit_event_invalid_event(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct dm_crtc_state *dm_state;
+	struct amdgpu_dm_ism_config config = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	amdgpu_dm_ism_init(&acrtc->ism, &config);
+	acrtc->base.state = &dm_state->base;
+
+	guard(mutex)(&adev->dm.dc_lock);
+	amdgpu_dm_ism_commit_event(&acrtc->ism,
+				   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/* ===== Tests for amdgpu_dm_ism_force_full_power ===== */
+
+/**
+ * dm_test_ism_force_full_power - force-full-power sends EXIT_IDLE to every CRTC
+ * @test: KUnit test context
+ *
+ * From the initial FULL_POWER_RUNNING state EXIT_IDLE_REQUESTED is a no-op, so
+ * the FSM remains in FULL_POWER_RUNNING and no DC work is scheduled.
+ */
+static void dm_test_ism_force_full_power(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct dm_crtc_state *dm_state;
+	struct amdgpu_dm_ism_config config = { 0 };
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	amdgpu_dm_ism_init(&acrtc->ism, &config);
+	acrtc->base.state = &dm_state->base;
+	register_test_acrtc(adev, acrtc);
+
+	guard(mutex)(&adev->dm.dc_lock);
+	amdgpu_dm_ism_force_full_power(&adev->dm);
+
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/* ===== Tests for amdgpu_dm_ism_disable / amdgpu_dm_ism_enable ===== */
+
+/**
+ * dm_test_ism_disable_enable_cycle - disable then enable quiesces and re-arms work
+ * @test: KUnit test context
+ *
+ * Walks every CRTC's ISM, disabling its delayed work (synchronously) and then
+ * re-enabling it. With no work ever scheduled both calls complete without
+ * touching the FSM state. disable must be called without dc_lock held.
+ */
+static void dm_test_ism_disable_enable_cycle(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = { 0 };
+
+	amdgpu_dm_ism_init(&acrtc->ism, &config);
+	register_test_acrtc(adev, acrtc);
+
+	amdgpu_dm_ism_disable(&adev->dm);
+	amdgpu_dm_ism_enable(&adev->dm);
+
+	KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+			(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/* ===== Tests for dm_ism_dispatch_power_state (via commit_event) ===== */
+
+/*
+ * Build a config + history that makes dm_ism_get_idle_allow_delay() return a
+ * non-zero hysteresis delay. A non-zero delay keeps the FSM parked in
+ * HYSTERESIS_WAITING (the dispatcher returns DM_ISM_NUM_EVENTS instead of an
+ * immediate follow-up event), preventing the cascade into the DC-dependent
+ * OPTIMIZED_IDLE / *_SSO states.
+ */
+static void setup_idle_delay_history(struct amdgpu_dm_ism *ism,
+				     struct dc_stream_state *stream)
+{
+	uint64_t one_frame_ns;
+
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL, 1485000);
+
+	for (int i = 0; i < 8; i++) {
+		ism->records[i].duration_ns = one_frame_ns;
+		ism->records[i].timestamp_ns = 0;
+	}
+	ism->next_record_idx = 8;
+}
+
+/**
+ * dm_test_ism_dispatch_hysteresis_schedule_and_cancel - cover the HYSTERESIS_WAITING dispatch arms
+ * @test: KUnit test context
+ *
+ * ENTER_IDLE_REQUESTED moves FULL_POWER_RUNNING -> HYSTERESIS_WAITING. The
+ * current-state arm of dm_ism_dispatch_power_state() then records the idle
+ * timestamp, computes a (non-zero) idle-allow delay and schedules the delayed
+ * worker. A subsequent BEGIN_CURSOR_UPDATE (-> HYSTERESIS_BUSY) exercises the
+ * previous-state arm that cancels that pending worker. Neither arm reaches the
+ * DC-dependent idle-optimization commit path.
+ */
+static void dm_test_ism_dispatch_hysteresis_schedule_and_cancel(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct dm_crtc_state *dm_state;
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
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	stream = dm_kunit_alloc_stream(test, NULL);
+
+	amdgpu_dm_ism_init(&acrtc->ism, &config);
+	setup_idle_delay_history(&acrtc->ism, stream);
+	dm_state->stream = stream;
+	acrtc->base.state = &dm_state->base;
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		/* Enter HYSTERESIS_WAITING: schedules the idle-allow worker. */
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_WAITING);
+
+		/* Cursor update cancels the pending worker (prev-state arm). */
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_BEGIN_CURSOR_UPDATE);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_BUSY);
+	}
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_dispatch_optimized_idle_defers_sso - cover OPTIMIZED_IDLE dispatch without DC
+ * @test: KUnit test context
+ *
+ * With sso_num_frames < filter_num_frames the OPTIMIZED_IDLE current-state arm
+ * skips the idle-optimization commit and only schedules the SSO worker. Driving
+ * HYSTERESIS_WAITING -> OPTIMIZED_IDLE via TIMER_ELAPSED exercises that arm
+ * (get_sso_delay + the skip branch + mod_delayed_work) without any DC access.
+ */
+static void dm_test_ism_dispatch_optimized_idle_defers_sso(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct dm_crtc_state *dm_state;
+	struct dc_stream_state *stream;
+	struct amdgpu_dm_ism_config config = {
+		.filter_num_frames = 5,
+		.filter_entry_count = 3,
+		.activation_num_delay_frames = 10,
+		.filter_history_size = 8,
+		.filter_old_history_threshold = 0,
+		.sso_num_frames = 2,
+	};
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	stream = dm_kunit_alloc_stream(test, NULL);
+
+	amdgpu_dm_ism_init(&acrtc->ism, &config);
+	setup_idle_delay_history(&acrtc->ism, stream);
+	dm_state->stream = stream;
+	acrtc->base.state = &dm_state->base;
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_WAITING);
+
+		/*
+		 * Timer fires: HYSTERESIS_WAITING -> OPTIMIZED_IDLE. sso_delay
+		 * is non-zero and sso_num_frames < filter_num_frames, so the
+		 * commit is deferred to the SSO worker and the FSM parks here.
+		 */
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_TIMER_ELAPSED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_OPTIMIZED_IDLE);
+
+		/* Cancel the scheduled SSO worker while still holding dc_lock. */
+		cancel_delayed_work(&acrtc->ism.sso_delayed_work);
+	}
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
+}
+
 static struct kunit_case dm_ism_test_cases[] = {
 	/* dm_ism_next_state — FULL_POWER_RUNNING */
 	KUNIT_CASE(dm_test_ism_next_state_running_enter_idle),
@@ -910,6 +1252,17 @@ static struct kunit_case dm_ism_test_cases[] = {
 	KUNIT_CASE(dm_test_dispatch_next_event_opt_idle_with_sso_delay),
 	KUNIT_CASE(dm_test_dispatch_next_event_timer_aborted),
 	KUNIT_CASE(dm_test_dispatch_next_event_no_action_state),
+	/* amdgpu_dm_ism_commit_event */
+	KUNIT_CASE(dm_test_ism_commit_event_no_state),
+	KUNIT_CASE(dm_test_ism_commit_event_cursor_transition),
+	KUNIT_CASE(dm_test_ism_commit_event_invalid_event),
+	/* amdgpu_dm_ism_force_full_power */
+	KUNIT_CASE(dm_test_ism_force_full_power),
+	/* amdgpu_dm_ism_disable / amdgpu_dm_ism_enable */
+	KUNIT_CASE(dm_test_ism_disable_enable_cycle),
+	/* dm_ism_dispatch_power_state (via commit_event) */
+	KUNIT_CASE(dm_test_ism_dispatch_hysteresis_schedule_and_cancel),
+	KUNIT_CASE(dm_test_ism_dispatch_optimized_idle_defers_sso),
 	{}
 };

--
2.55.0


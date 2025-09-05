Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E89CA1012
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 03:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E2E10EB09;
	Fri,  5 Sep 2025 03:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixAj7Af2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012C710EB08
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 03:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoyeE15P/QDB7RKFihFDCD3F6OekoV8ceNgvMIWyYMj7aHdl6v0r/QKy1fmQYNZG/lCAq+xBBT4rpwjO9qdsdWy/8B1c2vFRYEuqvWoEAbctQVsR1uSizyn/CkS8oCBgqFUZM8mWr+WLS3qrm9ZLA/BhwS7DgeedhxibjwMosiDuUn+FxNAUAuMFBNo6oDu0mjLoc9ADxDKgJvTaAKl5wioJbZ+3cPwBTbeZ8YgAapLdeZ7U0VxbWiAXCwW7gOhQICac8gqDxUcI0BzKdhmHfY4ZPL+gVfKly7KaH3K5L0WW5IDEnmskWszGXQZDy5swh4YGHxZuRfPn+fNPq3DZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sGByCVXZbAgLMG22Fsgov5l0IOR5klXTnxdwD5QS6c=;
 b=SPOyyl7uPYA9D/Y/6Rv9ESPJ68WInSpQsX7SeH7qVNdkIJCkJFC1eBy9am+NYk18GRIVi9Pyw0VIVVuDRSiDqvxMfOEBgr5D6mSYb5QNiUIWGhijGUwtSTsqDvWf4La8pyxUEL531CUVyZ0mjccRB+GlGPF6E+tk/dYjUfiDEZ+ncqEwcfdrWFaosHIZ+B8Iy+HkKEmUtzMaXAShB7zAdbtfyVMRRgY5MlXhFA10XYDTqtfwGCZjLCzpOHnxWziEAtDbtv/gRpVrmunfvG9+PG6hy3FDAERlRHWIj/oxt7a+EgcWdVseT6UrDtvYZhbfjT5KP46WHu0DbdLOSVfRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sGByCVXZbAgLMG22Fsgov5l0IOR5klXTnxdwD5QS6c=;
 b=ixAj7Af23HeV3we8vsU33IZ8kd411SC9IHG76WYFNuVT9uaNP2fZnKxvR1PQ05BUohOpNwckROTmyGTH91Iw/if3L/EO3w9WSCcdqUiAkArkTM+nbPvDbHw1l6PC/oQmq5uFLgBtMVkAsWKzwv8HsyGMgSs8Z1jyFPgcag7LaHI=
Received: from BYAPR02CA0018.namprd02.prod.outlook.com (2603:10b6:a02:ee::31)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 03:20:49 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::db) by BYAPR02CA0018.outlook.office365.com
 (2603:10b6:a02:ee::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Fri,
 5 Sep 2025 03:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 03:20:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 22:20:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 22:20:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 4 Sep 2025 22:20:41 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Implement user queue reset functionality
Date: Fri, 5 Sep 2025 11:19:27 +0800
Message-ID: <20250905032026.3256999-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
References: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 8333bcf1-4b17-4699-4d49-08ddec2b35ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?67aQg63Ri/WRDYSOh7abEKif2M9A/zutrRVJQSrmwk89FeyvdOIELszyrlSn?=
 =?us-ascii?Q?xO1KfFt+RBRm0lQTg6Xzu/cTai9PDQcqMR/nqaGpkPGQAwTrmgli5akxjfuK?=
 =?us-ascii?Q?eg3XCpMadoiYFsgTFbIATKlrPw9eE7zsoB/t4w1jsBcZEX30grBn2hMeG7m4?=
 =?us-ascii?Q?quOkKE75RZ2xoe4ol4DYvfcFKBg8RT/lZg/kzsisOZCpiDVSGjKtcGp1lPXE?=
 =?us-ascii?Q?B8fO7PvDAtSGqXiLW4nyGdC83cgor5wtznID43r8zOj2KVA2T5JQhNE+FhEP?=
 =?us-ascii?Q?gt5+8J/+/2hMS8RXo5GhFOZ7G33p+DU8bGjpNCh1uPT6ZxNwckEtoKiZi+Vg?=
 =?us-ascii?Q?URCJyKRBYVgDK+Bloqc0fthVkD4rwwmuQZIkc0+JdolwvfTnr1+0/y7MXgxq?=
 =?us-ascii?Q?Kj9ahMXMj64M7Q8f9S0J+ea23SY7hUy37Ed5HS5y4dXHpnjZa/ugLj8d/vqg?=
 =?us-ascii?Q?J21gnrzwVgodBo5uWMZOcCAXJbj/x+NlEutECFDPgrKjccrTe4CAmIcZqu4c?=
 =?us-ascii?Q?9yLvT8lPre4RJDmpDmTcm6kLUu+dgE7QAJNh0558VGI1i9+S6C9pmL3oYwQU?=
 =?us-ascii?Q?R4ep/QbN1NPRX5K4Cw6NYJZ4dKmhtwlG1bG7V7KnQBEs0vjuBCnpSBfg5SkT?=
 =?us-ascii?Q?so1CZpFFKR2Er6XyAwz8s4sxNj2IIwEmODy2gE6C8YhLeoM833TVSjj21u7v?=
 =?us-ascii?Q?xqxBhHmymy4BaokwmztqAjvpDQE8wPedhZI96eEZgg8nUSE8oSUuXnHsFgBr?=
 =?us-ascii?Q?8Q+RH6LAV+Ckr1Okua7We/JO4bAUEScmWnvRnMPhWbQFbAtNnLmj/IERM+BF?=
 =?us-ascii?Q?am91ykYPqU7eARcHRW08+doS9wIsrrhfqH+YcA7KAMBaWdit7AmIsjk9fc3V?=
 =?us-ascii?Q?EDfK/pEOXQYpFIKuLIfCAvLctxLRhL3uPAl4UV0zhj6rayfkzftSgaH63MB3?=
 =?us-ascii?Q?txDLhW6quEF+LHOdvuy8w8Ur4e0+spf20jNv621E4i0/WgWwSQz0a37yS0Hh?=
 =?us-ascii?Q?a9cJAACM+eXgxVUkgqlyNe5ug+oPxn1YnWkuJ91mPedZ9MEVOI2QVoUsYipP?=
 =?us-ascii?Q?2J7+fbxKCiIXYLd+VZTteXevu6oZ3ZT8Kjga6p6wXlZ/lRm1mU0KP/I+A/Zb?=
 =?us-ascii?Q?9/0kpVw6J0HXY0R2OC0or5W736kg3/CNcIg342XRRgtnCMowAVo6wVhCkHQd?=
 =?us-ascii?Q?0y+tHX3iKBdi/zo6NkQkPnf/PheJ7aPd61f1xoT/60QKnPfvyS37Sjh5rfcF?=
 =?us-ascii?Q?RCfEvQdMw80xsigxnABuB8chfh/ebyyApydEruwq+dVDWLi6U7Gb1yhG0bAP?=
 =?us-ascii?Q?ftpWfxfLhujlVLYXhobJv/5pmAibKF4DJt7o/CTyToOVf2tBcv7XEXfGzElD?=
 =?us-ascii?Q?D2/gU++6hjfVOl7B8hphibxFCGX6dj7xQNkam83yyjNEHHRuRVN6HwgmbTae?=
 =?us-ascii?Q?xhv13NEp5j4HScttVH03djByWxLpsBFdh+Qc1CmC3xe/XAuYvMKjdRQLXCkd?=
 =?us-ascii?Q?C+8yvrcwBxESK0usjd2Rk+Fzox0t287l0sBi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 03:20:48.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8333bcf1-4b17-4699-4d49-08ddec2b35ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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

This patch adds robust reset handling for user queues (userq) to improve
recovery from queue failures. The key components include:

1. Queue detection and reset logic:
   - amdgpu_userq_detect_and_reset_queues() identifies failed queues
   - Per-IP detect_and_reset callbacks for targeted recovery
   - Falls back to full GPU reset when needed

2. Reset infrastructure:
   - Adds userq_reset_work workqueue for async reset handling
   - Implements pre/post reset handlers for queue state management
   - Integrates with existing GPU reset framework

3. Error handling improvements:
   - Enhanced state tracking with HUNG state
   - Automatic reset triggering on critical failures
   - VRAM loss handling during recovery

4. Integration points:
   - Added to device init/reset paths
   - Called during queue destroy, suspend, and isolation events
   - Handles both individual queue and full GPU resets

The reset functionality works with both gfx/compute and sdma queues,
providing better resilience against queue failures while minimizing
disruption to unaffected queues.

v2: add detection and reset calls when preemption/unmaped fails.
    add a per device userq counter for each user queue type.(Alex)
v3: make sure we hold the adev->userq_mutex when we call amdgpu_userq_detect_and_reset_queues. (Alex)
   warn if the adev->userq_mutex is not held.
v4: make sure we have all of the uqm->userq_mutex held.
   warn if the uqm->userq_mutex is not held.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 219 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +
 5 files changed, 223 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 17848ce65d1f..707a1fb4a061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1310,6 +1310,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct              userq_reset_work;
 	struct amdgpu_uid *uid_info;
 
 	/* KFD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bdfb80377e6a..82f01c7a06ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5951,6 +5952,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -6173,6 +6178,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6293,6 +6299,8 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		    amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..4471e4c388ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -107,7 +107,6 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct amdgpu_eviction_fence *ev_fence;
 
-	mutex_lock(&uq_mgr->userq_mutex);
 	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
 	if (ev_fence)
@@ -118,13 +117,11 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 
 	amdgpu_userq_evict(uq_mgr, ev_fence);
 
-	mutex_unlock(&uq_mgr->userq_mutex);
 	dma_fence_put(&ev_fence->base);
 	return;
 
 unlock:
 	spin_unlock(&evf_mgr->ev_fence_lock);
-	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
 static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7772de16f12b..566a26c05262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,8 +25,10 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -44,6 +46,67 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
+{
+	if (amdgpu_device_should_recover_gpu(adev)) {
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->userq_reset_work);
+		/* Wait for the reset job to complete */
+		flush_work(&adev->userq_reset_work);
+	}
+}
+
+static int
+amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_gfx_funcs =
+			adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
+	const struct amdgpu_userq_funcs *userq_compute_funcs =
+			adev->userq_funcs[AMDGPU_RING_TYPE_COMPUTE];
+	const struct amdgpu_userq_funcs *userq_sdma_funcs =
+			adev->userq_funcs[AMDGPU_RING_TYPE_SDMA];
+	bool gpu_reset = false;
+	int r = 0;
+
+	/* warning if global mutex or process mutex is not held */
+	WARN_ON(!mutex_is_locked(&adev->userq_mutex) || !mutex_is_locked(&uq_mgr->userq_mutex));
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+	} else if (amdgpu_gpu_recovery) {
+		if ((atomic_read(&uq_mgr->userq_compute_count) > 0) && userq_compute_funcs->detect_and_reset) {
+			r = userq_compute_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_COMPUTE);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+
+		if ((atomic_read(&uq_mgr->userq_gfx_count) > 0) && userq_gfx_funcs->detect_and_reset) {
+			r = userq_gfx_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_GFX);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+
+		if ((atomic_read(&uq_mgr->userq_sdma_count) > 0) && userq_sdma_funcs->detect_and_reset) {
+			r = userq_sdma_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_SDMA);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+	}
+
+gpu_reset:
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
+	return r;
+}
+
 static int
 amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -51,17 +114,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool found_hung_queue = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		r = userq_funcs->preempt(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			found_hung_queue = true;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
 		}
 	}
 
+	if (found_hung_queue)
+		amdgpu_userq_detect_and_reset_queues(uq_mgr);
+
 	return r;
 }
 
@@ -93,16 +161,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool found_hung_queue = false;
 	int r = 0;
 
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
-		if (r)
+		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-		else
+			found_hung_queue = true;
+		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+		}
 	}
+
+	if (found_hung_queue)
+		amdgpu_userq_detect_and_reset_queues(uq_mgr);
+
 	return r;
 }
 
@@ -113,16 +188,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			gpu_reset = true;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
 	return r;
 }
 
@@ -346,12 +427,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	int r = 0;
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
+	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&uq_mgr->userq_mutex);
 
 	queue = amdgpu_userq_find(uq_mgr, queue_id);
 	if (!queue) {
 		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
 		mutex_unlock(&uq_mgr->userq_mutex);
+		mutex_unlock(&adev->userq_mutex);
 		return -EINVAL;
 	}
 	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
@@ -361,6 +444,18 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+	switch (queue->queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		atomic_dec(&uq_mgr->userq_gfx_count);
+	break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		atomic_dec(&uq_mgr->userq_compute_count);
+	break;
+	case AMDGPU_RING_TYPE_SDMA:
+		atomic_dec(&uq_mgr->userq_sdma_count);
+	break;
+	}
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
@@ -368,6 +463,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -576,6 +672,19 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	kfree(queue_name);
 
 	args->out.queue_id = qid;
+	switch (queue->queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		atomic_inc(&uq_mgr->userq_gfx_count);
+	break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		atomic_inc(&uq_mgr->userq_compute_count);
+	break;
+	case AMDGPU_RING_TYPE_SDMA:
+		atomic_inc(&uq_mgr->userq_sdma_count);
+	break;
+	default:
+	break;
+	}
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -789,6 +898,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0, r;
 
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
@@ -801,6 +911,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
+void amdgpu_userq_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  userq_reset_work);
+	struct amdgpu_reset_context reset_context;
+
+	memset(&reset_context, 0, sizeof(reset_context));
+
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+	reset_context.src = AMDGPU_RESET_SRC_USERQ;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
+
+	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}
+
 static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -827,31 +954,33 @@ void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_eviction_fence *ev_fence)
 {
-	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int ret;
 
+	mutex_lock(&adev->userq_mutex);
+	mutex_lock(&uq_mgr->userq_mutex);
 	/* Wait for any pending userqueue fence work to finish */
 	ret = amdgpu_userq_wait_for_signal(uq_mgr);
-	if (ret) {
-		drm_file_err(uq_mgr->file, "Not evicting userqueue, timeout waiting for work\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
 
 	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret) {
-		drm_file_err(uq_mgr->file, "Failed to evict userqueue\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Failed to evict userqueue\n");
 
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
 
 	if (evf_mgr->fd_closing) {
 		cancel_delayed_work_sync(&uq_mgr->resume_work);
+		mutex_unlock(&adev->userq_mutex);
+		mutex_unlock(&uq_mgr->userq_mutex);
 		return;
 	}
-
+	mutex_unlock(&adev->userq_mutex);
+	mutex_unlock(&uq_mgr->userq_mutex);
 	/* Schedule a resume work */
 	schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
@@ -866,6 +995,9 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 
 	mutex_lock(&adev->userq_mutex);
 	list_add(&userq_mgr->list, &adev->userq_mgr_list);
+	atomic_set(&userq_mgr->userq_gfx_count, 0);
+	atomic_set(&userq_mgr->userq_compute_count, 0);
+	atomic_set(&userq_mgr->userq_sdma_count, 0);
 	mutex_unlock(&adev->userq_mutex);
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
@@ -883,6 +1015,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -916,6 +1049,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
@@ -972,13 +1106,15 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
 				r = amdgpu_userq_preempt_helper(uqm, queue);
-				if (r)
+				if (r) {
 					ret = r;
+				}
 			}
 		}
 		mutex_unlock(&uqm->userq_mutex);
@@ -1020,3 +1156,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+				amdgpu_userq_wait_for_last_fence(uqm, queue);
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				userq_funcs->unmap(uqm, queue);
+				/* just mark all queues as hung at this point.
+				 * if unmap succeeds, we could map again
+				 * in amdgpu_userq_post_reset() if vram is not lost
+				 */
+				queue->state = AMDGPU_USERQ_STATE_HUNG;
+				amdgpu_userq_fence_driver_force_completion(queue);
+			}
+		}
+	}
+}
+
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
+{
+	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
+	 * at this point, we should be able to map it again
+	 * and continue if vram is not lost.
+	 */
+	struct amdgpu_userq_mgr *uqm;
+	struct amdgpu_usermode_queue *queue;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	int queue_id, r = 0;
+
+	list_for_each_entry(uqm, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+
+				r = userq_funcs->map(uqm, queue);  // Re-map queue
+				if (r) {
+					dev_err(adev->dev, "Failed to remap queue %d\n", queue_id);
+					continue;
+				}
+				queue->state = AMDGPU_USERQ_STATE_MAPPED;
+			}
+		}
+
+		/* Restart resume work after reset */
+		//queue_delayed_work(system_wq, &uqm->resume_work, msecs_to_jiffies(100));
+	}
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 1bd84f4cce78..391c510b025b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -94,6 +94,9 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct list_head		list;
 	struct drm_file			*file;
+	atomic_t			userq_gfx_count;
+	atomic_t			userq_compute_count;
+	atomic_t			userq_sdma_count;
 };
 
 struct amdgpu_db_info {
@@ -139,4 +142,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+void amdgpu_userq_reset_work(struct work_struct *work);
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 #endif
-- 
2.49.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDF4CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4649D10E89E;
	Wed, 10 Sep 2025 08:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A1cGWkHn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5F510E89E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 08:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVBGCHrH3NA6ZQ6XBzhXIrnkUe8usq5DYbIE2USAB7y2hbGwKb4lon351GO/BNbvRdWzP7nzvfOSAuhQR1NYKhZD7idsGuddl3/Vr3SlTUUI3iLzXtdz3EFd+D+fxQBTJah4pG3HV6UYIztPBrzLbwos4bNqCngSgvAqarxdfEQpI6dDlg5qNLCD6OgfOT/oof+Olb3zoYR717/epnD0coVSWH0V+LLMHF6qbzhgiMdgLyio5zMUrXifS5u70fq/iGR6eWOkRQayg0JGyEvKTMoJa8/i/TePGEqecdKfFYZFg37wK9e3w1hjHlua0BlKpihlhwAvodJ7YSI098dLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNXLsozzukktLsVmsEF9RVFKXVpkTeK1V45uMX8gtNo=;
 b=nysnqhjPR47/+JiqHooggZ1WqCFZoZie43SyIa/ENRe0BcqzT7Jv3aj54/7ZBed9t1tN91Yd37SRGTEB7o3yfdH3uAofjz4t2PgOi4C6hiMKah9F1U1b0P76RIS4r/WNevwkZUjyr9o3kePIJN29yl9TzY+kr95uBXKyuCBmEE+db4CJ4ULgTS9gKOUcvdSGCDe23bg+cnfq6JrWYIEi8G4ogIS1cnfEelghSOOLSS01wDqSsi2LI4Wy5gUvzvtfsnuL6dwDLekWMGN1TDJxD+VvWJc9uErVM9Cs6rP1g/4V8At6KXu/+5fiN48N1YpCsMfzT9q6eEKWhm3dfuZ/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNXLsozzukktLsVmsEF9RVFKXVpkTeK1V45uMX8gtNo=;
 b=A1cGWkHnUcy6gQ2M1XAOT9VJ4pQZUuC9/inW7HdVXxcsrz/yDK15FNAh3tjtSnmNWwDNob21Wg0irsM1XEYpLpc7tJixIKQlqK6Nx9OV1ZgO9fqQb8NDOoXgIMECpRIkL3XfdyxYAZ/W5mrFqJu36zoNQQCtIR+FvKvAsLY6uJc=
Received: from CH0PR03CA0428.namprd03.prod.outlook.com (2603:10b6:610:10e::23)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:16:56 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::7b) by CH0PR03CA0428.outlook.office365.com
 (2603:10b6:610:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 08:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:16:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 10 Sep
 2025 01:16:56 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 03:16:55 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 10 Sep 2025 01:16:49 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Implement user queue reset functionality
Date: Wed, 10 Sep 2025 16:14:37 +0800
Message-ID: <20250910081634.3943981-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
References: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: fed0b03e-442a-4d26-9439-08ddf042686a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oCl3r8q0+GhA2he5qJM+2Ce9HRLvczxbjcstME2P53GSbJ0lqRjY770U60xs?=
 =?us-ascii?Q?KbosCq5UpA474sMRHCriXyrjUYX+PShie75555vW5tDLeQnPYXZgUI1vcnFs?=
 =?us-ascii?Q?qBfpuD4RCoc9wNmCfB3Ydfw6fnw+UsRBHd/2sDvlFFCx0kWMGWWlPJlekVJn?=
 =?us-ascii?Q?pK61PZDCUHVjkxfqbYpAOGWcY94u9144Q0P5ODlZY2cndScdGeLs5ucSqpqd?=
 =?us-ascii?Q?CKFv1n/pRkDQrPHKdmZTjzsc523D3xPkx6ianTtsJnJPCOAWXcSNXmlTNwXa?=
 =?us-ascii?Q?a2wIXdoBz97J/pYJwF627SxPIqTC/D61R9wIyWAq4IBrz4k7jJevExJkPcyB?=
 =?us-ascii?Q?sqS7ermWUGgaQqSXyZMDcc9IW9HLaYZ97Qy6WAchwX0muqMHecU5x9BPoPMF?=
 =?us-ascii?Q?0ozIjdKahkLr0m3wyagxIjjGkpqyFJtEpz/kuMj8RlEHXM0nYxiRSZggo27s?=
 =?us-ascii?Q?TpODuZOiP05g8zueLpCy0tc9qFgvQVSlJLvQdDBESrh3CoTQMRdB2j8uCucG?=
 =?us-ascii?Q?7DhwAwkxNqzf0+hS+QBsOZSsnWA7TLqQEYhxPAVEGZlGu+ofJ0gEgvthex+w?=
 =?us-ascii?Q?EwaxrWtpAGAV8vRT4R9InMLJoZFrLmA2wf30Y/mjnJtLEn6vMxUid9UWiJGr?=
 =?us-ascii?Q?oLk3233wONtBqVG9tUPZNwJQnS+WDYuz7ZuDLB98GvRkV631ym6M3FZjuyyH?=
 =?us-ascii?Q?xf+E2qWfmjUDSqi92lH7xE8iQNtw0479KBCZl7Ekgi/zULlkpCGeKzZin8x9?=
 =?us-ascii?Q?k6rQtHLFAnmDHW77PWWn1aeoqiSPBNM1WBsk1MJumfs55uVYA9ZMqMSmbZtP?=
 =?us-ascii?Q?XG3RuIYIG1y/e6bai5PpGM20vAZ8nfzKt69IPYjd0nixLsI/Lx0Xbbo7YCtq?=
 =?us-ascii?Q?BGwYDyKImpRmE1DhtkY1kyZWYWmAFBXfrXuU2KBVuE+ke+xnK8AACIqecFEO?=
 =?us-ascii?Q?QQ9Lv9UZb4/VIsh3n1O8FYhTb0CEhlD7edJZQyYho7YNjBb+qBjeNeQ6YO3Y?=
 =?us-ascii?Q?aRxYGWtignv+h5Y0TGODWdziMhpnDk77dT2GFMgqrX3sj0/DNzbYqfIjjkLD?=
 =?us-ascii?Q?taMo8CREzzHf9DIxKKRZNam+9aCAdtC1RYhn2z9Gpk3Pxj8mj0vaglxDxaRL?=
 =?us-ascii?Q?QIUZYNf7tVHEL08zQicz/stIVbWAmIE8LZhB9c6M+0+bAgr3Xz8DkAWspq6Y?=
 =?us-ascii?Q?J4Kdm+dNi2Bf/brv4q3/1j8qnDfmBv3+NiJd+xSin7o3fSW3gk+tIyFW8Ri2?=
 =?us-ascii?Q?x3+qBAq5e46EoXKUxVSAJAaxna3/gcQqy3hqROl+zC/DVPfdldurRKx9zbeL?=
 =?us-ascii?Q?zjK8UlT6UMoyWxPvrSH+EFxz6i2zjz+2Lr/lRQ0S4Fi/3k0ZnM+omiZOtGeE?=
 =?us-ascii?Q?x6EYNCZ0OKjgcPBY2X2gmYERcfvKs5CfhIVkbDszYA0FHdWtLhyZroje4115?=
 =?us-ascii?Q?2gOUE7edPuqj20S6eSTVbc537I0yU0dvVHyZ5/XWmVbtXnHqP5ZvNfW6Bee8?=
 =?us-ascii?Q?/kMYX7/CtxVtVzLeevBlN2ya5B+DYsOflV0O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:16:56.6260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed0b03e-442a-4d26-9439-08ddf042686a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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

v5: Use array for user queue type counters.(Alex)
    all of the uqm->userq_mutex need to be held when calling detect and reset.  (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 211 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   5 +
 6 files changed, 212 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c56839528843..93c255d1ddfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1311,6 +1311,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct              userq_reset_work;
 	struct amdgpu_uid *uid_info;
 
 	/* KFD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b20383021b50..f1d3c16c67cd 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 80b85547c810..cf21f36b5761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -83,6 +83,7 @@ enum amdgpu_ring_type {
 	AMDGPU_RING_TYPE_MES,
 	AMDGPU_RING_TYPE_UMSCH_MM,
 	AMDGPU_RING_TYPE_CPER,
+	AMDGPU_RING_TYPE_MAX,
 };
 
 enum amdgpu_ib_pool_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b649ac0cedff..f3f1b78dfef6 100644
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
@@ -44,6 +46,77 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
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
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	bool gpu_reset = false;
+	int r = 0;
+
+	/* warning if global mutex or current process mutex is not held */
+	WARN_ON(!mutex_is_locked(&adev->userq_mutex) || !mutex_is_locked(&uq_mgr->userq_mutex));
+	/* make sure all process locks are held */
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		if (uqm != uq_mgr)
+			mutex_lock(&uqm->userq_mutex);
+	}
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+	} else if (amdgpu_gpu_recovery) {
+		if ((atomic_read(&uq_mgr->userq_count[AMDGPU_RING_TYPE_COMPUTE]) > 0) && userq_compute_funcs->detect_and_reset) {
+			r = userq_compute_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_COMPUTE);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+
+		if ((atomic_read(&uq_mgr->userq_count[AMDGPU_RING_TYPE_GFX]) > 0) && userq_gfx_funcs->detect_and_reset) {
+			r = userq_gfx_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_GFX);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+
+		if ((atomic_read(&uq_mgr->userq_count[AMDGPU_RING_TYPE_SDMA]) > 0) && userq_sdma_funcs->detect_and_reset) {
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
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		if (uqm != uq_mgr)
+			mutex_unlock(&uqm->userq_mutex);
+	}
+	return r;
+}
+
 int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 				   u64 expected_size)
 {
@@ -83,17 +156,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -125,16 +203,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -145,16 +230,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -362,12 +453,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
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
@@ -377,10 +470,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
-
+	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
@@ -389,6 +483,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -588,6 +683,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	kfree(queue_name);
 
 	args->out.queue_id = qid;
+	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -849,6 +945,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0, r;
 
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
@@ -861,6 +958,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -887,31 +1001,33 @@ void
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
+		mutex_unlock(&uq_mgr->userq_mutex);
+		mutex_unlock(&adev->userq_mutex);
 		return;
 	}
-
+	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 	/* Schedule a resume work */
 	schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
@@ -919,6 +1035,8 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev)
 {
+	int i;
+
 	mutex_init(&userq_mgr->userq_mutex);
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
@@ -926,6 +1044,10 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 
 	mutex_lock(&adev->userq_mutex);
 	list_add(&userq_mgr->list, &adev->userq_mgr_list);
+	/* Initialize all queue type counters to zero */
+	for (i = 0; i < AMDGPU_RING_TYPE_MAX; i++) {
+		atomic_set(&userq_mgr->userq_count[i], 0);
+	}
 	mutex_unlock(&adev->userq_mutex);
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
@@ -943,6 +1065,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -976,6 +1099,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
@@ -1032,13 +1156,15 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
@@ -1080,3 +1206,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
index c027dd916672..4395a5c13745 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -94,6 +94,7 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct list_head		list;
 	struct drm_file			*file;
+	atomic_t			userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
 struct amdgpu_db_info {
@@ -137,6 +138,10 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+void amdgpu_userq_reset_work(struct work_struct *work);
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 				   u64 expected_size);
 #endif
-- 
2.49.0


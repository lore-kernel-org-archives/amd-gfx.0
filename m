Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1BBCA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38AD10E57C;
	Wed,  3 Sep 2025 08:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+Hxg7eC";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2584710E57C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtX12yPbUwQlEoyBfHeGwH6Csw0J1yoeu1q1+1NfLnmYLwdgkYEPrS22V8Bl+qBw8+X5UXdErNXs6lhh8dOPCSbDe1OgvUTs/RgQ5VL282f79qmFB0lenHN+DAXbZxgE+SL+Ri3tud/Hh4wWqWsO5amNAWmg8NQr39olTAhdZ+xT80g7B28vi8EUqA+hFYvtfGa0c5RF8MVCfyln9RcZW9d8grZJuTQoLrGkTH56KBpkNQnsGUVHTuQ+hXn3QLCJjBvrnSnmU51j0j8bpzM0zC1pUEbB+GQzmymV2Iq1TtMHNz0QBSpF0JtD5xkaZAAI+dY9qRmx0KcE6XJngKz61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YbJtfydR9aXIO81KBosm15fGhBKI88+KOT8OC/noNY=;
 b=HYxoekE7pEh6LVkIr1fUbl08ZavhoI8PcxM1GAh4iEPlZ6RbLTvGqZWnPT5r9lIqLXstAtkiUL8qaMTaMuObEPcEiCPHFsTAKOaGdpaeMNkJNsI2Z4Ax2awGviE+oOh1wRltCVuRw+/dtZLn2Okd6SEk8u/9L+Gttph3Ol1zCBIu5xAfYkYFhtMYkXfhaPFyaxiEjSdwW+Fqc8mlqpJHaHbFZ+B65ZiPca4uPVnmjGDx0KsetOdvcHwHI9CxSZkPN5b8ooD8CsTN3MlKWL4m3Dp98JJpDqNMWDru7vOKdz/e8xSq70LBszGCxPMKJfcx2T1d78uF3oILsBFwza4AJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YbJtfydR9aXIO81KBosm15fGhBKI88+KOT8OC/noNY=;
 b=B+Hxg7eCXFB+7QB5Lusu+2gLnSTX19OHQ60R9UZtiZLHM83LBORXhk9fsI484hTFJfp/ZM0bVxxO5RjWTAVlLOXvMNZ572zlKCBvQG+IpeoJ0kG0oZJX3APM+71GIzOEzoZo8lRjIgoSLfYyxOLcYMmSuBAUh2/k9qHKWmb8O7g=
Received: from SA1P222CA0109.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::26)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 08:40:31 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::b0) by SA1P222CA0109.outlook.office365.com
 (2603:10b6:806:3c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 08:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:40:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:40:28 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:40:22 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v14 11/11] drm/amdgpu: Implement user queue reset functionality
Date: Wed, 3 Sep 2025 16:34:29 +0800
Message-ID: <20250903083914.2604482-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8f2aba-97a4-4c26-ffa2-08ddeac58aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V81LE21dSQn0Scx0UStH2/eUnzToD91RHVibu51WULgtOWN831NFEyk1ZP1S?=
 =?us-ascii?Q?T6EADp0Uv6wj+U5oICLIIkKW7EVzDtTlDAYQzxY6MOd9EW+sulT3hYD6/KmT?=
 =?us-ascii?Q?cDNwuddL3N3evDpjAix7kENoFgIbLWCwTmrpnvlML2nj6oAAf/ACE3T+Bv4C?=
 =?us-ascii?Q?fTg3KRvrVMOQ3XWJQ6qtxp1TEigHjSxTPUr3rQoM2nt+uxAFVtalECUO3ooR?=
 =?us-ascii?Q?cB7Amm7oEqxOTevxMmTQXYwBpV7slFgOPv43WSt7wbBca29koWvj4Dd01fry?=
 =?us-ascii?Q?X7NUeYHt2yqoKQ9CFkThmOpzovlqJG28Goqyyg9ccX6lO4Fp0APsz3tjI3QI?=
 =?us-ascii?Q?B0UoojQUVOt2hk7oQ0K3IR6WiX5hLSj54bybGUZjLyGCRckX18QWMDV2jq74?=
 =?us-ascii?Q?aTua29dpF36LwAdf0QSx2OE5+uaad8NCxiQpuktMb/BYR+f0jdFVZfh6NWD6?=
 =?us-ascii?Q?MYyP2QDZEANjgx58zY1t3YfpqkDo7SnpKCvgNOkYHi/u979jqkwB/Kf3JnMS?=
 =?us-ascii?Q?f9vexMN/opL7Gm5oleLtRxBoJEluomcKQ7Cl5KMeiXnZ86XJcTWQXBpLvTHD?=
 =?us-ascii?Q?OoeTGDW8DjAbQtYV68l7PxXqwIPPh0/mRJRAOTXQlMY+iNUWpY/y10kW6E+h?=
 =?us-ascii?Q?QOOOqNs21HqgkzhepbbB535oUSIih3cxNbVeBUVxANG9IhtlFIrzXfn6VkSs?=
 =?us-ascii?Q?4JvTENO9SiI2jaXCpVejS1YYu+wJdBrM55Z8uwfvM/r4vU21ekf9kZZdstKE?=
 =?us-ascii?Q?vNihut8sVk13VRjoHFzOZ77hwXn5n26qdPQgEj2P6PyFdB9wj5q903wyTY2/?=
 =?us-ascii?Q?EJcxFlVUzeaP5TwFoA8MEYAs1leLEsSzPLIA05P/PlaoNKq3b3FbuII31bHk?=
 =?us-ascii?Q?3uBrx7pGcEWNIPA541NDQ4JK4XEtbRmZYJM4vQSSU4c+ifzRrqmrqgYpf32L?=
 =?us-ascii?Q?T3PosFd5LsK48YQuxOQ0aNBL6XsIryHMFcuFxtQZOCCRzp+Y1RF42X4vz9Mq?=
 =?us-ascii?Q?AVewBVZD00CUtlvlCT/g2TwGAE6OmCs2MF3ueiobLvwpDMznKvvWymKehufP?=
 =?us-ascii?Q?C1kGxncAMq2RrEYgcongFHe2jM+YlPvglP53GtCWYkDJDOga7QtodvVtV6vD?=
 =?us-ascii?Q?s22zFNiNc1/WZE79QPGlyDGhmf7KvOcb7CuzZcWdbmG1HIy9RZsq4qfrp3/C?=
 =?us-ascii?Q?InfgFO/JldlKmofwFru10uzck6EV7CNHKSXuRyZ7R4CR6QLSTY8YNhAzEm7m?=
 =?us-ascii?Q?Rxs5mNBEznM6W4Vxaoplej5ekdlKaYjyZwBmzWNj5kGBpzWoEm1yVZmUS/DP?=
 =?us-ascii?Q?zggrKacHZPdCGnsh0iFUmNMRVnboOd5GosVD5kQEye3+Swws4jMDTnnrOWsx?=
 =?us-ascii?Q?q0Zuusqq6GXxHt7ttp4AWGgNxKG8tadMya+zlveD1zDXto+qEB04D/+SA7IX?=
 =?us-ascii?Q?x04KUOZoPs1RAwRCAoNvXCf4mIyYrZWNnh/yjsv2Iver0ipPhl7p2tFSFMPm?=
 =?us-ascii?Q?REApE4jgRmgX+Z0SnrAt6sinhYx8J9ecaacI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:40:31.1982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8f2aba-97a4-4c26-ffa2-08ddeac58aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
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

From: Alex Deucher <alexander.deucher@amd.com>

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

The reset functionality works with both compute and graphics queues,
providing better resilience against queue failures while minimizing
disruption to unaffected queues.

v2: add detection and reset calls when preemption/unmaped fails.
    add a per device userq counter for each user queue type.(Alex)
v3: make sure we hold the adev->userq_mutex when we call amdgpu_userq_detect_and_reset_queues. (Alex)
   warn if the adev->userq_mutex is not held.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 216 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +
 5 files changed, 221 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ef3af170dda4..9db05cdc7304 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1302,6 +1302,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct		userq_reset_work;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3757634613c3..1dc88b0055dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4475,6 +4475,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5880,6 +5881,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -6102,6 +6107,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6232,6 +6238,8 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 8b919ad3af29..58ae564b3350 100644
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
index 54851ba8756a..7b10742a5cdf 100644
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
+	/* warning if global mutex is not held */
+	WARN_ON(!mutex_is_locked(&adev->userq_mutex));
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
@@ -361,9 +444,22 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
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
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -520,6 +616,19 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 
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
@@ -734,6 +843,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0, r;
 
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
@@ -746,6 +856,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -772,31 +899,33 @@ void
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
@@ -811,6 +940,9 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 
 	mutex_lock(&adev->userq_mutex);
 	list_add(&userq_mgr->list, &adev->userq_mgr_list);
+	atomic_set(&userq_mgr->userq_gfx_count, 0);
+	atomic_set(&userq_mgr->userq_compute_count, 0);
+	atomic_set(&userq_mgr->userq_sdma_count, 0);
 	mutex_unlock(&adev->userq_mutex);
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
@@ -828,6 +960,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -861,6 +994,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
@@ -917,6 +1051,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
@@ -965,3 +1100,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
index 9fa0d1a88d71..ff9aa41c4ff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -93,6 +93,9 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct list_head		list;
 	struct drm_file			*file;
+	atomic_t			userq_gfx_count;
+	atomic_t			userq_compute_count;
+	atomic_t			userq_sdma_count;
 };
 
 struct amdgpu_db_info {
@@ -138,4 +141,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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


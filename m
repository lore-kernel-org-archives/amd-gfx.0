Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31182C25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7708410E6FD;
	Fri, 10 May 2024 08:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VmitpO6K";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E5B10E669
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYk7pvtjjgBhK8m3SkVryjNeXmP+3Fme3YQnSrG+33x55KOFXN3oxBfiGFr0X8cUbTXRKrnR5gFihW44yJZ1dpdDQMGniVMASS4fpRNR2bkx74xiwlYhRLDoxfTuUW3uEhQEA4ywbFbnF50T/NKkJKLZ/49k4youUlbupEEW7VdJZeDQdc6JFYK4xll0Z0Db1aRgYLuiAyGsqfQEFkyDvws2UxhMKZtn0A78yFNDlXAaIofNqbB1W8A9Mh/NyQRieBtWBj2NhSaznbSXBqFAshrmT3qfBijDTvlALtKyllwa0Hji3CYMrvFour8RIrat0xvACHon/nUHkKfX8oLrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVq5/pjKaJUh9eFZaSAffg2yH6Bj1UIKt5sj/VOyR90=;
 b=nqJVw9RJ20QPWyEDEYmP07dPrnNaq7U1RJyjviq0CX/n77wPfPMoQIgs+kKCFsbnc/uWO8ofc+jVK/9e+NnjUVHx1EzVelWP7Z8Ix5/G2i5+r1Skb8uBmKDH65KBpDSadQxaJXQeE13zbyBdPwQdKWXt9ToOo/+LbnzOiafYsG+dG8WDvG5YOjAbrhk9+6JMHVApmnqRc5eZQoaE27PbjB8UsBRkyKU7Mo0JRF9ZEwXzDSXTs56XtTu1VQXeJIAEej3ObzlNd/DzUcXQsOnYSYLLZsKy/gXzpkqW/MDMvRjWANfPSOOzFi1/61oYldl/iDmSCxKuKGXvKaBKceYmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVq5/pjKaJUh9eFZaSAffg2yH6Bj1UIKt5sj/VOyR90=;
 b=VmitpO6Km1ihzuLkblGMzQ3FCNKryB1gVZkyAhT0ndYL/dcra2nc3xqUVVB0J2oLPMC08Sw5TvCpdwGmLOs1R5EMdIdtQZkd/WbapMV4HGzXXAraihmPiaPCApPsZkYC/Y/B/SdTqeJpnNbXfLN1hiIbC1/N1xH7g9KQJdeDbVk=
Received: from CH5P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::15)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Fri, 10 May
 2024 08:51:24 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::d1) by CH5P223CA0015.outlook.office365.com
 (2603:10b6:610:1f3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Fri, 10 May 2024 08:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 08:51:23 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 03:51:21 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v10 4/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
Date: Fri, 10 May 2024 14:20:44 +0530
Message-ID: <20240510085046.2718-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 74eb156c-27ed-4540-5580-08dc70ce5ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHNwM01vKzlvY0lwR21mY0pMSWQ4VlNJNXg2TUs2cWpBNG05S0hSRlZmWjBE?=
 =?utf-8?B?VjJJN3hqOHRkdGg5WGpscXhzUEJLSFMvWWxDMlBSZlpkYkVUOXA5Ymg1MWRF?=
 =?utf-8?B?RDVBeTJwdjdPQ1h3MVJlNUxiTGp1UFIxcjAydmh5TFNEOXJkNnpTQ0Y0dGNC?=
 =?utf-8?B?YnhoUlBtZXcxRjZwRFg2VEtWUlhIaG5GZmIzRHNrd0RKVFFHcVp6dFdKbTBZ?=
 =?utf-8?B?bnRiSTdXVXRScFVlYXlxKzBXK252WUJWUkdieE9tVVhTWlNhQjZUOGFLZHRJ?=
 =?utf-8?B?dUdhK0daalQ1T2ZMcFVFQ09FeE1sNEJwUG9TUkdqT3dJKzR2TVY3RFVtdTFy?=
 =?utf-8?B?RjJpd1lJQzI2eHcyMGlhTHFiOEh1ejBmdFd3WFZmNlR1VE9Ca253bW5uc0Z3?=
 =?utf-8?B?N2tjQUdZVmJzMkRRWWQ4QVRWQmNqeksycHBFMTNBRWg2WE5SczJ1RHlzLy9M?=
 =?utf-8?B?ZzUyVTM4NHNnM0ovYW5ZYWZ1bUlVOVRWUHJUb0M1NkFHOWhmd3hlZGdYWFRr?=
 =?utf-8?B?THFhMzV0alYwK0Y1ZEUxWDBtdXVYR1hIT0NsdmJTZDQzOWZja0RxUzdsMVhM?=
 =?utf-8?B?b1pWMStIQ1F0ZjczN1UrazBsQStmMktKL25XeVNQbWh6SFk4N0pCekE0SEhX?=
 =?utf-8?B?dDNUc01TeXBtVko3aU5wUmxpRmFvd2ZaUDBOQmFxY1dmQmx6dWgxM2R6WkVh?=
 =?utf-8?B?QmpqU3pTcEdDUm5nY0ZBQTNxOWxZMzBjeWp3ZitnQXk4UW1IcEFYZG9XaGpn?=
 =?utf-8?B?V3lRWElpVkRWcGRZQWYxZmt1d2d0V3VSS1NjSk5yeFRuaVlwSG5vOHI3bk9F?=
 =?utf-8?B?N08ybnN4YUR1eUZseHk5KzN5UkQxOG0wNjhvR1JoZ2QrSXRINit0cXZkMFdh?=
 =?utf-8?B?U0hLL3ZxOGU3QWMxc0VHdzI0RjdBM1VqdHBlbWdYYVlrUmU0ZmRYYmI0Nmpp?=
 =?utf-8?B?OVdtSkpMWSsyKzNHZWNJcGVMUHlaNU1xaHBWUVBpNXc3aVR3aEljZVdrU2RB?=
 =?utf-8?B?N3ZZNFlzeXA0Rk1qdmxaR2NjNUFEU2ErT1FMZ1hJWFpKQ3hNTDhwYWZDMUdD?=
 =?utf-8?B?TCtoTWh0NnBlSXcyY2hTQWg5YXRweVRQckdaQXlVT0hRTjROQ2hrbHd2bFVj?=
 =?utf-8?B?RXI4V25oU0o1cXVLK0ZrWTJoRDJqaWE2MzIvei9IV2lnZ2RtSWJBTWFnSDVZ?=
 =?utf-8?B?MkREdWJ3THkrSGJ2WVhHZSt2OUFUZXhycXJZNWs5WEZxVE5MbUxvTkxrM1RN?=
 =?utf-8?B?cC9rQVRQRTA3Vncxc1l5TnhrbDlSV25ubG5ZTFdibld1Z2s4UUJBWDRjNVdP?=
 =?utf-8?B?OS9lSmt6WDBQdmxYa05ZSjBQUHZxdWFWUzh5NUhuQldZclVyL1ZYRnEzUXFz?=
 =?utf-8?B?SXR3NENMYU1MaDhFZGFVUlJ1dWdmYmFXdDZqS2NrajhxUko5Y2NhNS9oOWJt?=
 =?utf-8?B?SkhCSkEzMWYrZjA3eTI5MEdZVmtOREtxWE8vT2VuaGJVQThSQm1LcGdEUFM2?=
 =?utf-8?B?Q0MzNU1sNklNbXkwdXdwbEh2UmE3N0pMS0hIYkVUcWtUUVNxdmxvSW5RQXRZ?=
 =?utf-8?B?cXNNbGpBbXlxRm9rZ0ZkK2NpRmUxUmRmcHBKZmowUkNOTFRsWXhuZEVaQWJS?=
 =?utf-8?B?WjkyNWhOeDFKUmVKZ2V3ZGNJZi9PMi9hVm8vL0xFaktSYUcrZ3VBcmhja1lI?=
 =?utf-8?B?OGd4ZHA0QS9PWlVpdlpwLytiVTRrTFlzZ1VqUUpLYXpibjY3L2dBK1VkdGRK?=
 =?utf-8?B?R3NpMzlobm5uYlF4WDJidndGRTduSXlGUVIzQUJjNzNEVWpFUXpDRDVqYWNa?=
 =?utf-8?B?SE5sOGNpSmM2UXFyTFJZd0I4dTZZSWhlUVhwUlFjcW9VdTdBWDJxSHBRRXlQ?=
 =?utf-8?Q?TYwbn1NKiJx0b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:51:23.7646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eb156c-27ed-4540-5580-08dc70ce5ef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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

This patch introduces new IOCTL for userqueue secure semaphore.

The signal IOCTL called from userspace application creates a drm
syncobj and array of bo GEM handles and passed in as parameter to
the driver to install the fence into it.

The wait IOCTL gets an array of drm syncobjs, finds the fences
attached to the drm syncobjs and obtain the array of
memory_address/fence_value combintion which are returned to
userspace.

v2: (Christian)
    - Install fence into GEM BO object.
    - Lock all BO's using the dma resv subsystem
    - Reorder the sequence in signal IOCTL function.
    - Get write pointer from the shadow wptr
    - use userq_fence to fetch the va/value in wait IOCTL.

v3: (Christian)
    - Use drm_exec helper for the proper BO drm reserve and avoid BO
      lock/unlock issues.
    - fence/fence driver reference count logic for signal/wait IOCTLs.

v4: (Christian)
    - Fixed the drm_exec calling sequence
    - use dma_resv_for_each_fence_unlock if BO's are not locked
    - Modified the fence_info array storing logic.

v5: (Christian)
    - Keep fence_drv until wait queue execution.
    - Add dma_fence_wait for other fences.
    - Lock BO's using drm_exec as the number of fences in them could
      change.
    - Install signaled fences as well into BO/Syncobj.
    - Move Syncobj fence installation code after the drm_exec_prepare_array.
    - Directly add dma_resv_usage_rw(args->bo_flags....
    - remove unnecessary dma_fence_put.

v6: (Christian)
    - Add xarray stuff to store the fence_drv
    - Implement a function to iterate over the xarray and drop
      the fence_drv references.
    - Add drm_exec_until_all_locked() wrapper
    - Add a check that if we haven't exceeded the user allocated num_fences
      before adding dma_fence to the fences array.

v7: (Christian)
    - Use memdup_user() for kmalloc_array + copy_from_user
    - Move the fence_drv references from the xarray into the newly created fence
      and drop the fence_drv references when we signal this fence.
    - Move this locking of BOs before the "if (!wait_info->num_fences)",
      this way you need this code block only once.
    - Merge the error handling code and the cleanup + return 0 code.
    - Initializing the xa should probably be done in the userq code.
    - Remove the userq back pointer stored in fence_drv.
    - Pass xarray as parameter in amdgpu_userq_walk_and_drop_fence_drv()

v8: (Christian)
    - Move fence_drv references must come before adding the fence to the list.
    - Use xa_lock_irqsave_nested for nested spinlock operations.
    - userq_mgr should be per fpriv and not one per device.
    - Restructure the interrupt process code for the early exit of the loop.
    - The reference acquired in the syncobj fence replace code needs to be
      kept around.
    - Modify the dma_fence acquire placement in wait IOCTL.
    - Move USERQ_BO_WRITE flag to UAPI header file.
    - drop the fence drv reference after telling the hw to stop accessing it.
    - Add multi sync object support to userq signal IOCTL.

v9: (Christian)
    - Store all the fence_drv ref to other drivers and not ourself.
    - Iterate over uq_fence_drv_xa without holding a lock.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 431 +++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  29 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 5 files changed, 462 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 844f7b5f90db..5892a4c1a92e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2918,6 +2918,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f7baea2c67ab..339d82d5808f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -25,6 +25,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 
+#include <drm/drm_exec.h>
 #include <drm/drm_syncobj.h>
 
 #include "amdgpu.h"
@@ -92,6 +93,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&fence_drv->fence_list_lock);
 
 	fence_drv->adev = adev;
+	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
@@ -102,8 +104,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
+	struct amdgpu_userq_fence_driver *stored_fence_drv;
 	struct amdgpu_userq_fence *userq_fence, *tmp;
+	unsigned long index, flags;
 	struct dma_fence *fence;
+	struct xarray *xa;
 	u64 rptr;
 
 	if (!fence_drv)
@@ -114,15 +119,25 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	spin_lock(&fence_drv->fence_list_lock);
 	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
 		fence = &userq_fence->base;
+		xa = &userq_fence->fence_drv_xa;
 
-		if (rptr >= fence->seqno) {
-			dma_fence_signal(fence);
-			list_del(&userq_fence->link);
-
-			dma_fence_put(fence);
-		} else {
+		if (rptr < fence->seqno)
 			break;
+
+		dma_fence_signal(fence);
+		/*
+		 * Walk over the fence_drv xarray and drop the old wait ioctl
+		 * fence_drv references.
+		 */
+		xa_lock_irqsave_nested(xa, flags, SINGLE_DEPTH_NESTING);
+		xa_for_each(xa, index, stored_fence_drv) {
+			__xa_erase(xa, index);
+			amdgpu_userq_fence_driver_put(stored_fence_drv);
 		}
+		xa_unlock_irqrestore(xa, flags);
+
+		list_del(&userq_fence->link);
+		dma_fence_put(fence);
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 }
@@ -188,9 +203,29 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
 		       fence_drv->context, seq);
 
+	xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_LOCK_IRQ);
+
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
+	if (!xa_empty(&userq->uq_fence_drv_xa)) {
+		struct amdgpu_userq_fence_driver *stored_fence_drv;
+		unsigned long index;
+
+		/*
+		 * Move fence_drv references of old signal IOCTL calls to the
+		 * newly created userq fence xarray.
+		 */
+		xa_lock(&userq->uq_fence_drv_xa);
+		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
+			__xa_store(&userq_fence->fence_drv_xa, index,
+				   stored_fence_drv, GFP_KERNEL);
+			/* Erase fence_drv reference entry from userq xarray */
+			__xa_erase(&userq->uq_fence_drv_xa, index);
+		}
+		xa_unlock(&userq->uq_fence_drv_xa);
+	}
+
 	spin_lock(&fence_drv->fence_list_lock);
 	/* Check if hardware has already processed the job */
 	if (!dma_fence_is_signaled(fence))
@@ -240,6 +275,8 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
 
 	/* Release the fence driver reference */
 	amdgpu_userq_fence_driver_put(fence_drv);
+
+	xa_destroy(&userq_fence->fence_drv_xa);
 	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
 }
 
@@ -255,3 +292,385 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.signaled = amdgpu_userq_fence_signaled,
 	.release = amdgpu_userq_fence_release,
 };
+
+/**
+ * amdgpu_userq_fence_read_wptr - Read the userq wptr value
+ *
+ * @filp: drm file private data structure
+ * @queue: user mode queue structure pointer
+ * @wptr: write pointer value
+ *
+ * Read the wptr value from userq's MQD. The userq signal IOCTL
+ * creates a dma_fence for the shared buffers that expects the
+ * RPTR value written to seq64 memory >= WPTR.
+ *
+ * Returns wptr value on success, error on failure.
+ */
+static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
+					struct amdgpu_usermode_queue *queue,
+					u64 *wptr)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo *bo;
+	u64 addr, *ptr;
+	int r;
+
+	addr = queue->userq_prop->wptr_gpu_addr;
+	addr &= AMDGPU_GMC_HOLE_MASK;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
+	if (!mapping)
+		return -EINVAL;
+
+	bo = mapping->bo_va->base.bo;
+	r = amdgpu_bo_reserve(bo, true);
+	if (r) {
+		DRM_ERROR("Failed to reserve userqueue wptr bo");
+		return r;
+	}
+
+	r = amdgpu_bo_kmap(bo, (void **)&ptr);
+	if (r) {
+		DRM_ERROR("Failed mapping the userqueue wptr bo");
+		goto map_error;
+	}
+
+	*wptr = le64_to_cpu(*ptr);
+
+	amdgpu_bo_kunmap(bo);
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+
+map_error:
+	amdgpu_bo_unreserve(bo);
+	return r;
+}
+
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
+	struct drm_amdgpu_userq_signal *args = data;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_gem_object **gobj = NULL;
+	struct drm_syncobj **syncobj = NULL;
+	u32 *syncobj_handles, num_syncobj_handles;
+	u32 *bo_handles, num_bo_handles;
+	struct dma_fence *fence;
+	struct drm_exec exec;
+	int r, i, entry;
+	u64 wptr;
+
+	/* Array of syncobj handles */
+	num_syncobj_handles = args->num_syncobj_handles;
+	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
+				      sizeof(u32) * num_syncobj_handles);
+	if (IS_ERR(syncobj_handles))
+		return PTR_ERR(syncobj_handles);
+
+	/* Array of syncobj object handles */
+	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
+	if (!syncobj) {
+		r = -ENOMEM;
+		goto free_syncobj_handles;
+	}
+
+	for (entry = 0; entry < num_syncobj_handles; entry++) {
+		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
+		if (!syncobj[entry]) {
+			r = -ENOENT;
+			goto free_syncobj_handles;
+		}
+	}
+
+	/* Array of bo handles */
+	num_bo_handles = args->num_bo_handles;
+	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
+				 sizeof(u32) * num_bo_handles);
+	if (IS_ERR(bo_handles))
+		goto free_syncobj_handles;
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto free_bo_handles;
+	}
+
+	for (entry = 0; entry < num_bo_handles; entry++) {
+		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
+		if (!gobj[entry]) {
+			r = -ENOENT;
+			goto put_gobj;
+		}
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto exec_fini;
+	}
+
+	/*Retrieve the user queue */
+	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
+	if (!queue) {
+		r = -ENOENT;
+		goto exec_fini;
+	}
+
+	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
+	if (r)
+		goto exec_fini;
+
+	/* Create a new fence */
+	r = amdgpu_userq_fence_create(queue, wptr, &fence);
+	if (r)
+		goto exec_fini;
+
+	for (i = 0; i < num_bo_handles; i++)
+		dma_resv_add_fence(gobj[i]->resv, fence,
+				   dma_resv_usage_rw(args->bo_flags &
+				   AMDGPU_USERQ_BO_WRITE));
+
+	/* Add the created fence to syncobj/BO's */
+	for (i = 0; i < num_syncobj_handles; i++)
+		drm_syncobj_replace_fence(syncobj[i], fence);
+
+	/* drop the reference acquired in fence creation function */
+	dma_fence_put(fence);
+
+exec_fini:
+	drm_exec_fini(&exec);
+put_gobj:
+	while (entry-- > 0)
+		drm_gem_object_put(gobj[entry]);
+	kfree(gobj);
+free_bo_handles:
+	kfree(bo_handles);
+free_syncobj_handles:
+	while (i-- > 0)
+		drm_syncobj_put(syncobj[i]);
+	kfree(syncobj_handles);
+
+	return r;
+}
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
+	struct drm_amdgpu_userq_wait *wait_info = data;
+	u32 *syncobj_handles, *bo_handles;
+	struct dma_fence **fences = NULL;
+	u32 num_syncobj, num_bo_handles;
+	struct drm_gem_object **gobj;
+	struct drm_exec exec;
+	int r, i, entry, cnt;
+	u64 num_fences = 0;
+
+	num_bo_handles = wait_info->num_bo_handles;
+	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
+				 sizeof(u32) * num_bo_handles);
+	if (IS_ERR(bo_handles))
+		return PTR_ERR(bo_handles);
+
+	num_syncobj = wait_info->num_syncobj_handles;
+	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
+				      sizeof(u32) * num_syncobj);
+	if (IS_ERR(syncobj_handles)) {
+		r = PTR_ERR(syncobj_handles);
+		goto free_bo_handles;
+	}
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto free_syncobj_handles;
+	}
+
+	for (entry = 0; entry < num_bo_handles; entry++) {
+		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
+		if (!gobj[entry]) {
+			r = -ENOENT;
+			goto put_gobj;
+		}
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (r) {
+			drm_exec_fini(&exec);
+			goto put_gobj;
+		}
+	}
+
+	if (!wait_info->num_fences) {
+		/* Count syncobj's fence */
+		for (i = 0; i < num_syncobj; i++) {
+			struct dma_fence *fence;
+
+			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
+						   0, 0, &fence);
+			dma_fence_put(fence);
+
+			if (r || !fence)
+				continue;
+
+			num_fences++;
+		}
+
+		/* Count GEM objects fence */
+		for (i = 0; i < num_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
+						dma_resv_usage_rw(wait_info->bo_wait_flags &
+						AMDGPU_USERQ_BO_WRITE), fence)
+				num_fences++;
+		}
+
+		/*
+		 * Passing num_fences = 0 means that userspace doesn't want to
+		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
+		 * userq_fence_info and return the actual number of fences on
+		 * args->num_fences.
+		 */
+		wait_info->num_fences = num_fences;
+	} else {
+		/* Array of fence info */
+		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
+		if (!fence_info) {
+			r = -ENOMEM;
+			goto exec_fini;
+		}
+
+		/* Array of fences */
+		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
+		if (!fences) {
+			r = -ENOMEM;
+			goto free_fence_info;
+		}
+
+		/* Retrieve GEM objects fence */
+		for (i = 0; i < num_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
+						dma_resv_usage_rw(wait_info->bo_wait_flags &
+						AMDGPU_USERQ_BO_WRITE), fence) {
+				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
+				dma_fence_get(fence);
+			}
+		}
+
+		/* Retrieve syncobj's fence */
+		for (i = 0; i < num_syncobj; i++) {
+			struct dma_fence *fence;
+
+			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
+						   0, 0, &fence);
+			if (r || !fence)
+				continue;
+
+			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+				r = -EINVAL;
+				goto free_fences;
+			}
+
+			fences[num_fences++] = fence;
+		}
+
+		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
+			struct amdgpu_userq_fence_driver *fence_drv;
+			struct amdgpu_userq_fence *userq_fence;
+			u32 index;
+
+			userq_fence = to_amdgpu_userq_fence(fences[i]);
+			if (!userq_fence) {
+				/*
+				 * Just waiting on other driver fences should
+				 * be good for now
+				 */
+				dma_fence_wait(fences[i], false);
+				dma_fence_put(fences[i]);
+
+				continue;
+			}
+
+			fence_drv = userq_fence->fence_drv;
+			/*
+			 * We need to make sure the user queue release their reference
+			 * to the fence drivers at some point before queue destruction.
+			 * Otherwise, we would gather those references until we don't
+			 * have any more space left and crash.
+			 */
+			r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
+				     xa_limit_32b, GFP_KERNEL);
+			if (r)
+				goto free_fences;
+
+			amdgpu_userq_fence_driver_get(fence_drv);
+
+			/* Store drm syncobj's gpu va address and value */
+			fence_info[cnt].va = fence_drv->gpu_addr;
+			fence_info[cnt].value = fences[i]->seqno;
+
+			dma_fence_put(fences[i]);
+			/* Increment the actual userq fence count */
+			cnt++;
+		}
+
+		wait_info->num_fences = cnt;
+		/* Copy userq fence info to user space */
+		if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
+				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
+			r = -EFAULT;
+			goto free_fences;
+		}
+
+		kfree(fences);
+		kfree(fence_info);
+	}
+
+	drm_exec_fini(&exec);
+	for (i = 0; i < num_bo_handles; i++)
+		drm_gem_object_put(gobj[i]);
+
+	kfree(syncobj_handles);
+	kfree(bo_handles);
+
+	return 0;
+
+free_fences:
+	kfree(fences);
+free_fence_info:
+	kfree(fence_info);
+exec_fini:
+	drm_exec_fini(&exec);
+put_gobj:
+	while (entry-- > 0)
+		drm_gem_object_put(gobj[entry]);
+	kfree(gobj);
+free_syncobj_handles:
+	kfree(syncobj_handles);
+free_bo_handles:
+	kfree(bo_handles);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index c3e04cdbb9e7..9c5f72a88440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -37,6 +37,7 @@ struct amdgpu_userq_fence {
 	 */
 	spinlock_t lock;
 	struct list_head link;
+	struct xarray fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
@@ -52,6 +53,7 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
+	struct xarray *uq_fence_drv_xa_ref;
 	char timeline_name[TASK_COMM_LEN];
 };
 
@@ -65,5 +67,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 73d225aa3e1e..404c39073661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -28,6 +28,32 @@
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
+static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long index;
+
+	if (xa_empty(xa))
+		return;
+
+	xa_lock(xa);
+	xa_for_each(xa, index, fence_drv) {
+		__xa_erase(xa, index);
+		amdgpu_userq_fence_driver_put(fence_drv);
+	}
+
+	xa_unlock(xa);
+}
+
+static void
+amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
+{
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
+	xa_destroy(&userq->uq_fence_drv_xa);
+	/* Drop the fence_drv reference held by user queue */
+	amdgpu_userq_fence_driver_put(userq->fence_drv);
+}
+
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue,
@@ -37,7 +63,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
-	amdgpu_userq_fence_driver_put(queue->fence_drv);
+	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 }
@@ -405,6 +431,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
+	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		DRM_ERROR("Failed to alloc fence driver\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index d3738f645adc..27e1617b234f 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -48,6 +48,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+	struct xarray		uq_fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
-- 
2.25.1


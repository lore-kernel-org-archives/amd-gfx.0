Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C99CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 01:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A775910E6C2;
	Wed, 15 Oct 2025 01:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f+Vs3AQo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D30710E6C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 01:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu7aMpcSZAWgf9TO90NUVS0NczMNJM1WnW+tBpcbJK+aq2v3hdV1rO6OpqsLPxWH/e1R5XkrZ7QlRNj4//WZdU+9l1yn/yPK4ixydpLDzghhv2t4OC2qcRKqj1SjkV0cvCinn+HPilt/O5KIBuewRikkWcYCYaWCbw/DwbqUlKRpZxwdpwK3C4VH5HxMiV9Z9f5qbI0e+vnu4BpVugMUvDZopA0zjG927XVn3hAOS8n+lZ0DyvizIosXEqzvM1KSN/Jd9FQbVbToTSMMZ/l9KCpAW1EBMbV0DslWX+VNqTkYLPrsPy/V1ytze6ZZmvbykLzvnFZB+tdLQNuMPfNw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOkvzMf7HTIpqJgBbsifqrtH48MYrVByfKAwwqNrpis=;
 b=oxUWMJBYtEj746rXLWH7rOJaBAeJCT+S2Z+rbcNVcGXQztezI0mgde0NghIPEp0E+yE/uawVcZ86KeNRECibVh5s8CKpWfjvybWMkMomD66u9Y6Z0932NE6aw4MdQEKRDRdhxExxQTpv041BmWAmLqh/5aJRmrScogyU/I5aP4h26bBwRtsEKg1ub7lELDuU2vVcy1tt6pDsxA9p6pMjUQgG+BG4AcP2JrHU29/CNjB4KV7QMHF9umPm9fTal0sloHr0cubdqshwN+5Kq7VchjahC84SqpgqkiKXM/IWx9W768+Jm5h1hmCABQYmre+Qke0ieORHHY5ZVDYBFRKWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOkvzMf7HTIpqJgBbsifqrtH48MYrVByfKAwwqNrpis=;
 b=f+Vs3AQoztDvXQSZW45kqlsw1yW9CrcG8h1KQyuEEi9rQZsKxa2D9VIJHS42XtqNjE0qqox2Ad0TrjF/jbNxEEnRr26t/Fo18OblDZGijettVhSqVrfVGCnAPruyVMgW4LJqcJzT7aDmrNjBZR6/iPe13vYXMEfaDH89GWeE0Yg=
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 15 Oct
 2025 01:09:33 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::93) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 01:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 01:09:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 18:09:31 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 18:09:31 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 14 Oct 2025 18:09:25 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v8 2/2] drm/amdgpu: Implement user queue reset functionality
Date: Wed, 15 Oct 2025 09:08:53 +0800
Message-ID: <20251015010922.1983385-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015010922.1983385-1-Jesse.Zhang@amd.com>
References: <20251015010922.1983385-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: d78db548-2f04-4809-5c1e-08de0b877f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HSnd525UGPuvUcdgk5JW9LSz6n/i/7SvLN3viBsYOH5O71khY+pQpDmQHz3+?=
 =?us-ascii?Q?42OtinwUtu675ePdeHyJDJkuNmij0KlRYiCsMoxZnc7FXTYWnNV766HIv0Ui?=
 =?us-ascii?Q?vOFeLFmRQTw88Ql234GWiju+admq6xg7STkG2wfcGX1nmG6myYrh/NdS7G89?=
 =?us-ascii?Q?z3K253Z3ZsaHWVTOHO/rC//XtC5cK21v9+SJe9nYLPaROUun7e1Yali0I7lH?=
 =?us-ascii?Q?vIXbqcI+4dX/KD35gaKrg2hEVhyXZxvI2tO1g/09pyO9K5bSBr7BaX/Ko6gJ?=
 =?us-ascii?Q?kTw2QM16hIVZ/U5wG+G5xfz3BnXeLvoqPINep1JaW0lKPwAoaCR43hYHuG1D?=
 =?us-ascii?Q?OcE92NzdfSKR/6wfx6iCn+vF8xApaE13AwC80rAXCyVtpVn7caCJRZ30GLtz?=
 =?us-ascii?Q?7Nk6Ji2cLBav/FpPmIe3rracn/VW/xyp5BymRtse8FmUx5X+zltup4BlwMDj?=
 =?us-ascii?Q?swqcLmwvR1+L5BXNynIvrnpVxI3m3yb4bHHwdmZcwN0fhWp3XsIwANgBl5AI?=
 =?us-ascii?Q?h9cFApX1YrwFzeE/JTX1foHN9SpnvxKQHIW9sXWA4pTszI3VlS0+XMGoB+B0?=
 =?us-ascii?Q?TS+s2uRWUAhnz9vz+qRc24XZGDEE2rIg1p2CHwePlHyw2TOhf/ZjL+6TuKzY?=
 =?us-ascii?Q?HhSDAsQVRFCvc6iQE9qzSUaXE2fz0rICgMaEx+x9NoMfQ/IAnP9yiGJ38y9j?=
 =?us-ascii?Q?qI0kTP4Rx8rPmM511TB/wwfkyAhvEp5mu42vpCvbk84R/GNlrKD73NC0Gd3g?=
 =?us-ascii?Q?NKAIuPAVQtJLRrKVzHf1dkqdHUjhexVWIx0VFDhTW5PPurcwRl4jFS6t3nRo?=
 =?us-ascii?Q?2FcCKSYFFOiN1FiDgwvNVZXMJmK86/dlA0rDHaRDxD2AeFVX022lg9Cc0lFQ?=
 =?us-ascii?Q?2HmijInmsbhH5sViRqKRWFSpnOFP9QWVw/0xf3ZKIH/OCtLtK0EwILX4mzyJ?=
 =?us-ascii?Q?bGBgoqFiqD0eoFlvZ7PP9RyYDItOxrbYYyq8Qrmza/Lbg2igCKoY2Oam8n2n?=
 =?us-ascii?Q?WBLHENUFqfEW0FC5O2jBjzHZe6s7vBfLr/B+sq8HKkKGNGS2zWLQnkzQcTol?=
 =?us-ascii?Q?+vn8t2m9vqvMzsVgr6s0sy7/CNAplPfJWO1DK9nCt+ZZBXR4C96QQlWZRdg+?=
 =?us-ascii?Q?ugQoT6d8dITRJuzKmoGutlUF+0PZV0Oo3uThFCDRbBBV4hYeT0UPvvq4Tw7j?=
 =?us-ascii?Q?AdNNlvQY6DgmG07UMaSUrclF0CyAjVXndcmvdKzjL7uNpnk0dj2gPa7iTGAA?=
 =?us-ascii?Q?Tow1P8+YXslWQ0/gkMdVE6cX/4Qd8mBIqH96bafBmewNrxmeodBx41WbWhnC?=
 =?us-ascii?Q?mtMF7upPXALWiYIaDihth11nOBERn2HP69P33hoVifjsuPK/g7ZsNLTS1dqE?=
 =?us-ascii?Q?HQ4nneHJKaTjDFt2RaoN72SeZl1QI76EUtEj4T4dRKG0OPPoD/Jdzmop0UtR?=
 =?us-ascii?Q?cNJ+0V6UBOjmyOhDjlc92cb4RjBM+btZEjb3I/Xe0A5jKjbykd9FUcbBl9ak?=
 =?us-ascii?Q?rKlA4rTeWcs43lyrzDQEJYAtAVReQEGeETvEGmpVb5UpLGSDEkXJliAWvokO?=
 =?us-ascii?Q?zJ+qVgX4u1cNC2AbS6g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 01:09:32.0043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78db548-2f04-4809-5c1e-08de0b877f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457
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

v6: fix lock dep warning in amdgpu_userq_fence_dence_driver_process

v7: add the queue types in an array and use a loop in amdgpu_userq_detect_and_reset_queues (Lijo)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 183 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   5 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  13 +-
 6 files changed, 195 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3d71da46b471..dc695bf69092 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1314,6 +1314,7 @@ struct amdgpu_device {
 	bool                            apu_prefer_gtt;
 
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct              userq_reset_work;
 	struct amdgpu_uid *uid_info;
 
 	/* KFD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5d9fd2cabc58..b63807b7b15a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4583,6 +4583,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5965,6 +5966,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -6187,6 +6192,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6307,6 +6313,8 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		    amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 87b962df5460..7a27c6c4bb44 100644
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
index 1e3a1013eb71..4a7a954ee8ed 100644
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
@@ -45,6 +47,69 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
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
+	const int queue_types[] = {
+		AMDGPU_RING_TYPE_COMPUTE,
+		AMDGPU_RING_TYPE_GFX,
+		AMDGPU_RING_TYPE_SDMA
+	};
+	const int num_queue_types = ARRAY_SIZE(queue_types);
+	bool gpu_reset = false;
+	int r = 0;
+	int i;
+
+	/* Warning if current process mutex is not held */
+	WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+		return 0;
+	}
+
+	/*
+	 * If GPU recovery feature is disabled system-wide,
+	 * skip all reset detection logic
+	 */
+	if (!amdgpu_gpu_recovery)
+		return 0;
+
+	/*
+	 * Iterate through all queue types to detect and reset problematic queues
+	 * Process each queue type in the defined order
+	 */
+	for (i = 0; i < num_queue_types; i++) {
+		int ring_type = queue_types[i];
+		const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[ring_type];
+
+		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
+		    funcs && funcs->detect_and_reset) {
+			r = funcs->detect_and_reset(adev, ring_type);
+			if (r) {
+				gpu_reset = true;
+				break;
+			}
+		}
+	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
+	return r;
+}
+
 static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
 {
@@ -175,17 +240,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -217,16 +287,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -243,10 +320,12 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			amdgpu_userq_detect_and_reset_queues(uq_mgr);
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+
 	return r;
 }
 
@@ -474,10 +553,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
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
@@ -699,6 +779,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	kfree(queue_name);
 
 	args->out.queue_id = qid;
+	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -965,6 +1046,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
@@ -977,6 +1059,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -1004,22 +1103,19 @@ void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_eviction_fence *ev_fence)
 {
-	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int ret;
 
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
@@ -1036,11 +1132,18 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev)
 {
+	int i;
+
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 
+	/* Initialize all queue type counters to zero */
+	for (i = 0; i < AMDGPU_RING_TYPE_MAX; i++) {
+		atomic_set(&userq_mgr->userq_count[i], 0);
+	}
+
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
 }
@@ -1053,6 +1156,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
 	mutex_lock(&userq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -1079,6 +1183,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		guard(mutex)(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_preempt_helper(uqm, queue);
 		else
@@ -1137,6 +1242,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 		    (queue->xcp_id == idx)) {
+			amdgpu_userq_detect_and_reset_queues(uqm);
 			r = amdgpu_userq_preempt_helper(uqm, queue);
 			if (r)
 				ret = r;
@@ -1209,3 +1315,56 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		cancel_delayed_work_sync(&uqm->resume_work);
+		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+			amdgpu_userq_wait_for_last_fence(uqm, queue);
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			userq_funcs->unmap(uqm, queue);
+			/* just mark all queues as hung at this point.
+			 * if unmap succeeds, we could map again
+			 * in amdgpu_userq_post_reset() if vram is not lost
+			 */
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			amdgpu_userq_fence_driver_force_completion(queue);
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
+	unsigned long queue_id;
+	int r = 0;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			/* Re-map queue */
+			r = userq_funcs->map(uqm, queue);
+			if (r) {
+				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
+				continue;
+			}
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 09da0617bfa2..c37444427a14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,6 +106,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
 struct amdgpu_db_info {
@@ -148,6 +149,10 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
+void amdgpu_userq_reset_work(struct work_struct *work);
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
 int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2aeeaa954882..aab55f38d81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -151,15 +151,20 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
+	unsigned long flags;
 	u64 rptr;
 	int i;
 
 	if (!fence_drv)
 		return;
-
+	/*
+	 * Use interrupt-safe spinlock since this function can be called from:
+	 * 1. Interrupt context (IRQ handlers like gfx_v11_0_eop_irq)
+	 * 2. Process context (workqueues like eviction suspend worker)
+	 * Using regular spin_lock() in interrupt context causes lockdep warnings.
+	 */
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
-
-	spin_lock(&fence_drv->fence_list_lock);
 	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
 		fence = &userq_fence->base;
 
@@ -174,7 +179,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 		list_del(&userq_fence->link);
 		dma_fence_put(fence);
 	}
-	spin_unlock(&fence_drv->fence_list_lock);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 }
 
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
-- 
2.49.0


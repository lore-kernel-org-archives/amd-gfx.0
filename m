Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300D1C3DA70
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 16:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF2110E334;
	Tue, 30 Jul 2024 16:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G0rnca9m";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E5F10E334
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 16:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1ArpFwgYM1Qc95vdfl3V5yBJoqCjhwv5bm3sO1RWNI3Ovcltp+nItPuHtFH4ZA4/vKtodMAYOspM1EMELnHsJdifbp0gCIN7fYWA7m6Qw8n6KkceA9Dp3BwnWyxUuZeZF0MWvg2ZiQfDtJrL//GfL1JmvpwkejMOBfGP0oM0WWs5HiBUr6Uw/SbhAbU2OMkBZD27/fJRGMwSVulFMz9HtMgK4t1zt7D52YiQU6HTwUzLgAfQuNUF31Hhs4wEytuyXmErKsTxNCPjgbBA9f/s4eTiWuMDkSErq/D2yyiT1UqNPVSuc+sC3gH3lx/pPxyzsuUlh3gS6eJ1oO8vIg97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT3O/apZQW1JwwmrMTU7lrE66fNwKZTtm7BwEk1ZS3Y=;
 b=KWEm3RA0zcWuifS+ARjzMrBIcSvYxLHqz4m6FKEwEDJMIkEb45Y3Ze/A3ZMkIzA8V6MJ1ZS67WGF7CTlwO8j8Imcf1q0DU0IgNXlwzbqciG/BpmqPrpCjOL2saJHzcG8mz8ub6fVnQ+lNsyOgZ786ZrJgLdu7VJStQgGi4gM7mn1qGpn7L0iT5YCFlI+XWYcq+hCgyNHNd9oyRHlY6LvRTzZkAnZj3x/KaoHEDTXU2Z0YVF7Hi9MvOJ9cC4Rx2g9Nl+FV1Epn/PVOplSZ039mwgnDbLEkyZOl3zUjh8zV6UwqUKve3Q16Isz/xEZwUefb6RpabC2a+PM0uBaWQR2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT3O/apZQW1JwwmrMTU7lrE66fNwKZTtm7BwEk1ZS3Y=;
 b=G0rnca9mbVeiEuMGwh99Vr4ICiCvCQc23Qh7jjcszubjVbINHavGw9GBA8LCeZwuugNrHkXiQ5w0hFwW3pvtxgLHmN6r8ZZ21w5ZOAIg3dMfpKuejW2aYVKolwF/K9drN57N+9xNyaPWdb6HxhWxh9yYYiZ7MS2tYbmoy+IBVGc=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 16:35:11 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::f7) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 16:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 16:35:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 11:35:09 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 11:35:04 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Philip.Yang@amd.com>,
 <christian.koenig@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>, "Xiaogang
 . Chen" <Xiaogang.Chen@amd.com>
Subject: [PATCH v5] drm/amdkfd: Change kfd/svm page fault drain handling
Date: Tue, 30 Jul 2024 11:34:23 -0500
Message-ID: <20240730163423.639112-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c66568b-8dd5-4948-7bf3-08dcb0b59468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MCdyfM8e2vqeGZ5mwkIQ58vpci95TRgtV5VBtDBacH4UKKsKaNvmTey4KkEq?=
 =?us-ascii?Q?LDQKmwzxwuznJaIjIyMQkcqVHTyYM9nY8VkezPlyrtybsiNOswfChaLlgAbk?=
 =?us-ascii?Q?XqzkWQZ/0b027vOCRqUl2GdyAOrH//JXXEk595wIC8ihe16TXQZmwvEmpzXP?=
 =?us-ascii?Q?wJy71o7XuoPVZrl+n3btDtS9HQlNq7lIeY1G0n+DT/jaZCLRKgiYVhqUOlzx?=
 =?us-ascii?Q?g4FO7bfQyCeP+ZkwL29Ud5cJU8reT1rjT3+EKNcbze3OShZJs6H+3Oxvs1Ib?=
 =?us-ascii?Q?d/TncwzUrz/cauFWOyjbcHp+fAoMqd349NsayA96Mg0Gfayz7i+v5mvKzQQy?=
 =?us-ascii?Q?N8v9CNG8/cs1R1CYsdgsR4f+sA3XUKmdNRrox3OfIgX3qQXM7MaSXBquadEK?=
 =?us-ascii?Q?5vEufaS0niCeD2uAoDWngP8yD78IA9sGRKPM/pavzLl1pVKGSJnyXYihyECo?=
 =?us-ascii?Q?K/W6b5wwspaIewUrN0ZNpnuLL4PSv9k22kjs5ftuP6AjaZkRbjIV3VZB2poJ?=
 =?us-ascii?Q?XfkNGI0FBd61wqXais4C8iH2M1MmmC5RO14yEtHL6KWci1TBXNWOVsQ8Q1hi?=
 =?us-ascii?Q?q5bcqPl9eWVyybI2dwjzrvqopanRwNgiQu9BZ34stI/lzq0dS+1gDhiVxWbd?=
 =?us-ascii?Q?wk5nM2C95BIJCMTuyb6Uv5GvacboLjx5MCFaRRioSinB1ssKVFmwJUjVcSxj?=
 =?us-ascii?Q?f/SKxwNDEa+dgcmNgDpk7DhQ1XFpQJVq2HS3+lLf3zpqL6h8S3U7jl2dnc+2?=
 =?us-ascii?Q?aW1YF1vOugFsbzoxKx4q3F43Yx3mEHCs2EXZD8XE434CKBk2Vf0baqEi1oLm?=
 =?us-ascii?Q?WUGg/2zMp6aGFkk0OqehgP0A97npshZbTjX+et1cz7C3trymOpaWQJTntwGU?=
 =?us-ascii?Q?OxBLz0NbZr5mM3WSwtlRaRkaJKc0Cvc/dGva9V4Av3dYC23Cm3Xhln4NGWUk?=
 =?us-ascii?Q?P2NPN/63gt3Se8KkvO0l+Y2xGq/LCvVUXVcPs7d3Uo4RY9SUVm9+YXEKd791?=
 =?us-ascii?Q?IVShMJjRYEkf+LHnZvhvp6Hy43MAUXIZVB7Q5C3TXhiJe4WJfK06aE6lWR2P?=
 =?us-ascii?Q?TRYSnSflzhoSQPDXY8nzK17E2oeRB0VeCrs0yvBzZUP8Ayv6NZsmGP3JdeFh?=
 =?us-ascii?Q?2DRDYBa6n4cTqCxRQLvfA8Mo3595cqdRuC0E0dyy04PgfMPSuRH2gmUZwOVd?=
 =?us-ascii?Q?gmimy/E0nO1H2fxf0CNxxvJ/XbIBlW19bQYUvwbRmcOe/rWp7SLga8LXJliD?=
 =?us-ascii?Q?eQTXOPFF2wu/OOWkfBwE4FemB3KabHe9f7/m1dE1ku05aNdiYZa/6thL63pm?=
 =?us-ascii?Q?Vl+jSDRw2PeRWNjRZ1kUuVCTogs4kJ6ueTu5yzg+X2fuks1uFLf28lYMrt/f?=
 =?us-ascii?Q?RrnZaa9OyafdBXt5tBIloABO/X45lrvWkq1A5GjnztpvverNyA7T5VuqnP0R?=
 =?us-ascii?Q?3MUR7XjF+hFdg95I1IAeJPL0prwNndCU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 16:35:10.4431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c66568b-8dd5-4948-7bf3-08dcb0b59468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of "not handle page fault"
can be long and is unpredicable. That is advese to kfd performance on page
faults recovery.

This patch uses time stamp of incoming page fault to decide to drop or handle
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happened on unmapped ranges after unmap events is application
bug that accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 101 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
 7 files changed, 78 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a060c28f0877..d89a4c14bbb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2764,7 +2764,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2790,7 +2790,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 046949c4b695..d12d66dca8e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -558,7 +558,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f0ceab3ce5bf..9784a2892185 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
+					   entry->timestamp, write_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b73136d390cc..c76ac0dfe572 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry->src_data[2] & 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						     addr, write_fault);
+						     addr, entry->timestamp, write_fault);
 			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						   addr, write_fault))
+						   addr, entry->timestamp, write_fault))
 				return 1;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4190fa339913..5132223ce383 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -859,10 +859,13 @@ struct svm_range_list {
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	atomic_t			drain_pagefaults;
+	/* stop page fault recovery for this rocess */
+	atomic_t			stop_pf_recovery;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10b1a1f64198..0d667afde5fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2256,16 +2256,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
-restart:
-	drain = atomic_read(&svms->drain_pagefaults);
-	if (!drain)
-		return;
-
 	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
 		pdd = p->pdds[i];
 		if (!pdd)
@@ -2285,8 +2279,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
-	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2308,17 +2300,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange->start, prange->last, prange->work_item.op);
 
 		mm = prange->work_item.mm;
-retry:
-		mmap_write_lock(mm);
 
-		/* Checking for the need to drain retry faults must be inside
-		 * mmap write lock to serialize with munmap notifiers.
-		 */
-		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
+		mmap_write_lock(mm);
 
 		/* Remove from deferred_list must be inside mmap write lock, for
 		 * two race cases:
@@ -2439,6 +2422,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	if (atomic_read(&prange->queue_refcount)) {
 		int r;
@@ -2458,11 +2442,37 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing "phantom faults".
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
 	 */
-	atomic_inc(&svms->drain_pagefaults);
+	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+
+		pdd = p->pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd->dev->adev;
+
+		/* Check and drain ih1 ring if cam not available */
+		ih = &adev->irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+			continue;
+		}
+
+		/* check if dev->irq.ih_soft is not empty */
+		ih = &adev->irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+			continue;
+		}
+	}
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -2903,7 +2913,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2913,7 +2923,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2933,12 +2943,38 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
-	if (atomic_read(&svms->drain_pagefaults)) {
-		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+	if (atomic_read(&svms->stop_pf_recovery)) {
+		pr_debug("page fault handling disabled, drop fault 0x%llx\n", addr);
 		r = 0;
 		goto out;
 	}
 
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
+	if (!node) {
+		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
+			 vmid);
+		r = -EFAULT;
+		goto out;
+	}
+
+	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
+		pr_debug("failed to get gpuid/gpuidex for node_id: %d\n", node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0 &&
+		amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
+		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+		r = 0;
+		goto out;
+	} else
+		/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+		 * to zero to avoid following ts wrap around give wrong comparing
+		 */
+		svms->checkpoint_ts[gpuidx] = 0;
+
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -2955,13 +2991,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	node = kfd_node_by_irq_ids(adev, node_id, vmid);
-	if (!node) {
-		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
-			 vmid);
-		r = -EFAULT;
-		goto out;
-	}
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
@@ -3176,9 +3205,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&p->svms.drain_pagefaults);
+	atomic_set(&p->svms.stop_pf_recovery, 1);
 	svm_range_drain_retry_fault(&p->svms);
+	atomic_set(&p->svms.stop_pf_recovery, 0);
 
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
@@ -3200,7 +3231,7 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&svms->lock);
 	INIT_LIST_HEAD(&svms->list);
 	atomic_set(&svms->evicted_ranges, 0);
-	atomic_set(&svms->drain_pagefaults, 0);
+	atomic_set(&svms->stop_pf_recovery, 0);
 	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
 	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&svms->deferred_range_list);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 747325a2ea89..974bbc6b14c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -174,7 +174,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr,
+			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
-- 
2.25.1


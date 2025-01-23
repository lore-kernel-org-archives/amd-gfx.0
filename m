Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1049BC0218B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2025 20:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD7B10E89F;
	Thu, 23 Jan 2025 20:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="irVnP/KY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93E710E89E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2025 20:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmHHx1BwryhhJ10ko5bNsGGfwnfaV5fpcVoCPK6YcH722paqhroIwVKyM7CH9G+buIbRuAssO+GMKMo33dTGafQWjS4R3Chs0QCOSCfzFxYH/pEaBDysEsvM2uTdBwAqHtSwL7pi2sfFwrCarYyRIPeu487A9Nmnir+GE0Avpr4vr+yb81RBUYwrw8cekdJMWQwlKlg5XgCBjatzzDQP/BJvUjczialskdsn8j2B5fzWfJci5M4pAYAyYFoZoQs38DZXBuJHdmcLXEx/iqJ9dbB8yN+JVZzBH47MpR4sZvu1Yq/QEH1CJoHaBXj9pFloA0sLLxHkWs2qXnBgUtjrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD4DpQUfoY2tfmpJfyHXi7a36UDOx1AMS5PiOsQ9GKY=;
 b=MGaBXutT0wOww+r2yPu4/ECXi3V35kppi5HDBwoKPprFJkEhZ0LmapqGUt27z2LvhoQOji7I04Vs10T9uFjMJ97n86yNjaJRDPC40ZSmPbl/6tsDCS8ipbvdn4DD7ln7lauUfTKiPEtYoARraJhOhnNncwh/Dj9meynR+JlfHwc4lil7g3EsTwF08LXDxHPMOC35rcpdU+N7K66+MBJPbpN7261KKjqsOPF2f4De9EsZrKTN9WGu0bFbcmeHLp2mOlxmTpnZirHbcgGNUlKD4KdDikvtIMBMgMRLnkTzhuF3ifPT4X9SXUfTQYkRwOMwTHjWW+1yA7X84nY6QyQjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD4DpQUfoY2tfmpJfyHXi7a36UDOx1AMS5PiOsQ9GKY=;
 b=irVnP/KYH4IzQV94Utfs4QcJam1yJjeBNvDUJukcheAFYrCHBlFNs5kewAAtYBIKbk7MvMAfq4/MSF5DJZ2Ema6NNuayCKITb/fld3gvm+1yRHYqSm1BYubof4Gt0oaokPcoWtdIHew5P0D1YsihVBW6R0LjD5esT8NzmJx6bqs=
Received: from BN9PR03CA0427.namprd03.prod.outlook.com (2603:10b6:408:113::12)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 20:39:58 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::4) by BN9PR03CA0427.outlook.office365.com
 (2603:10b6:408:113::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 23 Jan 2025 20:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 20:39:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 14:39:57 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <emily.deng@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Unlocked unmap only clear page table leaves
Date: Thu, 23 Jan 2025 15:39:30 -0500
Message-ID: <20250123203931.18867-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaa2eff-c34f-4372-009b-08dd3bee1a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ys4pj+lgRKI7MM+qexLhPsxLXUbTKlvPa3XFIKoQ18nWP8YW/IwDWzW7Gsi1?=
 =?us-ascii?Q?LRfozT0awIUR+/3Ht9Vun6aBe7r6GRCJ8neijqPeID2ZZHYvrj0Fdkb8bEtU?=
 =?us-ascii?Q?tDNz8pxz3Rt8jnwr2tMkMrZH/L1kF+hVqB9qo958Wx0aoJTTXsSALlCMaO41?=
 =?us-ascii?Q?ySzKA/+eHZhLud+pR4IzbGgNePP4ExvsbAfO6sGJ+VvXN0ScA/iw9QcRy/j2?=
 =?us-ascii?Q?6rlYo20S0gEQFgtRqeIOs8GpdE7AP+kALmpUc+HVKqjSwUuHRLYLaBg+gz29?=
 =?us-ascii?Q?mOGsJ3n+FsNerWARy29FDM7xC4KRMyoZUua1vp90A6ETra7w09T0A7lKLdYS?=
 =?us-ascii?Q?n0cWCJJaB4S0cHuc+EJF7rVOCKSpK6qKNpt8jgt+jMUQS3yU9oC4Qlgdl9eO?=
 =?us-ascii?Q?VeMKBMkUHVbkleTj8KmkmalPotquKWb+UgO7F8z8xuoGAvLoqrEg6Y3G1TzR?=
 =?us-ascii?Q?jkejqK2bjneWzdwUuX0FKwIXXtiTVlnfTTo6O9co1N/MTp+INrsRKEReR8cb?=
 =?us-ascii?Q?IVUyo6dcJjc6/GBd9UBdWtXdQe8S80ia5Eq3Y/9TIvFkhMYpMzdLAruMVrZ3?=
 =?us-ascii?Q?ZoKrtEE2UJDTONtJxhpH115AsGJBoqlqt20lRMtgLhr/GxY40LXGIiV6UmkE?=
 =?us-ascii?Q?s6fyjfjqQZsMGQMk+kZ2hDk0bc0yQ7lfXGrfzwJaj2okRv/RbAqvXmPZPmD3?=
 =?us-ascii?Q?XhyWBxbYTT1Mph8jErhsTLfSJp6u0KfpwYudRRTOG1/luIu/NdWEavbYw8vo?=
 =?us-ascii?Q?0v0M0xowHG8XADlbXM/J49wOa48wxFKDbsQCM2aqF7QixlDAxQDZ29uAbjDi?=
 =?us-ascii?Q?HE5Kb+2jAVvDePiY60caKzq3SdLo4bRei76Eto0G/PR3zjB+4IrmCrZmZjAu?=
 =?us-ascii?Q?jE1sjCUAZs/FtqKxatwNtiG1n5eB4qeNm/3xyw1RDgPP97jXddL0gs3rhH5d?=
 =?us-ascii?Q?nrlmzjzZO++HY8g/1XuGAdll6ULIlhdMicv2YCqb8XAkr9PXwCyjoy0OUsYb?=
 =?us-ascii?Q?INfvQCPnkcnQ+xO5qfTjmzeIuFaE3Y+nU++Vgbqf+MJKdIrOF+NjqgnSzhKY?=
 =?us-ascii?Q?46lBmnYtdUYFdr57UxJa/CSCUWJmhNLiTBDddtZchM2kgFHvzaamX5N3KjcQ?=
 =?us-ascii?Q?lrhOM2s+Ub9NTV5wptlco7hnwE9co77+Am3KtTcQjVwbpDvoB+jRoQTtZPt1?=
 =?us-ascii?Q?ShU0lI4O1LLRW/LNOTFybgG3KTYuMKeUeBbt0sUWxcafMf3wRbqFio+qtKgf?=
 =?us-ascii?Q?9EnMRWe2HNVIoaqhttgCCowhq2yKcFl3LhZt1FMqyohaVsyDiMPQK2HZQFRM?=
 =?us-ascii?Q?YtEr0RVOa8pQLL9Gw7Gx9AAIPIfDCEuKNdNmUmRGlS7muV0TJIzQuY0Jaw0/?=
 =?us-ascii?Q?45pCtlTshIsvJE6GE7GYnddnW51tV1kYpwD+La2jHPQf+mkTUJKJcUTwsf5o?=
 =?us-ascii?Q?0c62gvtJ7+uPc5zdDyh7besCtv8QWhi0CvCIkUVLpNXn+zAsEOHCbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 20:39:58.2413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaa2eff-c34f-4372-009b-08dd3bee1a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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

SVM migration unmap pages from GPU and then update mapping to GPU to
recover page fault. Currently unmap clears the PDE entry for range
length >= huge page and may free PTB bo. Then update mapping should
alloc new PT bo, but there is race bug that the freed entry bo maybe
still on the pt_free list, reused when updating mapping and then freed,
leave invalid PDE entry and cause GPU page fault.

By setting the update fragment size to 2MB or 1GB, update will clear
only one PDE entry or clear PTB, to avoid unmap to free PTE bo. This
fixes the race bug and also improve the unmap and map to GPU
performance. Update mapping to huge page will still free the PTB bo.

With this change, the vm->pt_freed list and work is not needed. Add
WARN_ON(unlocked) in amdgpu_vm_pt_add_list to catch if unmap to free the
PTB.

v2: Limit update fragment size, not hack entry_end (Christian)

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 54 +++++++++--------------
 3 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c9c48b782ec1..48b2c0b3b315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
-	INIT_LIST_HEAD(&vm->pt_freed);
-	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
 
 	r = amdgpu_vm_init_entities(adev, vm);
@@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
-	flush_work(&vm->pt_free_work);
-
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_put_task_info(vm->task_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5d119ac26c4f..160889e5e64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -369,10 +369,6 @@ struct amdgpu_vm {
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
-	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
-	struct list_head	pt_freed;
-	struct work_struct	pt_free_work;
-
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48f..063d0e0a9f29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
-void amdgpu_vm_pt_free_work(struct work_struct *work)
-{
-	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm;
-	LIST_HEAD(pt_freed);
-
-	vm = container_of(work, struct amdgpu_vm, pt_free_work);
-
-	spin_lock(&vm->status_lock);
-	list_splice_init(&vm->pt_freed, &pt_freed);
-	spin_unlock(&vm->status_lock);
-
-	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
-	amdgpu_bo_reserve(vm->root.bo, true);
-
-	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
-		amdgpu_vm_pt_free(entry);
-
-	amdgpu_bo_unreserve(vm->root.bo);
-}
-
 /**
  * amdgpu_vm_pt_free_list - free PD/PT levels
  *
@@ -579,20 +558,9 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm = params->vm;
-	bool unlocked = params->unlocked;
 
 	if (list_empty(&params->tlb_flush_waitlist))
 		return;
-
-	if (unlocked) {
-		spin_lock(&vm->status_lock);
-		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
-		spin_unlock(&vm->status_lock);
-		schedule_work(&vm->pt_free_work);
-		return;
-	}
-
 	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
 }
@@ -611,6 +579,11 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 	struct amdgpu_vm_pt_cursor seek;
 	struct amdgpu_vm_bo_base *entry;
 
+	/*
+	 * unlocked unmap only clear page table leaves, warning to free the page table entry.
+	 */
+	WARN_ON(params->unlocked);
+
 	spin_lock(&params->vm->status_lock);
 	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
 		if (entry && entry->bo)
@@ -794,6 +767,21 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
 
 	/* This intentionally wraps around if no bit is set */
 	*frag = min_t(unsigned int, ffs(start) - 1, fls64(end - start) - 1);
+
+	/*
+	 * MMU notifier callback unlocked unmap only clear PDE or PTE leaves by setting fragment
+	 * size to 2MB, 1GB, 512GB. If leave is PDE entry, only clear one entry, next fragment entry
+	 * will search again for PDE or PTE leaves.
+	 */
+	if (params->unlocked) {
+		if (*frag > 9 && *frag < 18)
+			*frag = 9;
+		else if (*frag > 18 && *frag < 27)
+			*frag = 18;
+		else if (*frag > 27)
+			*frag = 27;
+	}
+
 	if (*frag >= max_frag) {
 		*frag = max_frag;
 		*frag_end = end & ~((1ULL << max_frag) - 1);
@@ -931,7 +919,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 				/* figure out the next fragment */
 				amdgpu_vm_pte_fragment(params, frag_start, end,
 						       flags, &frag, &frag_end);
-				if (frag < shift)
+				if (frag < shift || (params->unlocked && shift))
 					break;
 			}
 		} while (frag_start < entry_end);
-- 
2.47.1


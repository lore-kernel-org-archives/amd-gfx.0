Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD61ED38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EB810E663;
	Wed, 14 Jan 2026 16:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRtD95X/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E077E10E661
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm8TI/lDHAaqSMIBZt86PKQzMeta3P2gpSNofbUVQNqoyGnAdTsVohHjD+zkiuxKYMNWr74y4JEOGeP/VLgWZt1zf1FuT9LQElehSug2LOCf6PxiPUHs5RIeudRfkQaQj68/BOKsye93HzV2tosvS8uguvGh6SskBVXVTv46gIN0fqiu0Fyfi5qbrlI00+Ey51YBN+xLgWlCDwAnav1eF1JucuhPu1ORbpTo0WC9n8W2GU2p9z4pIGkke0yFHPb1gyi3iqpsrJ9dq98IFUSD8+p9OBvuS5mc354Q9B+DriOgotfAK5jfhdWJUmEB9xEP5kc8BF4wJcyMu+0iyqqkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MxfPfKaFdtUcFEY86r42b9AosJVDLdyozBmb0j9Noc=;
 b=KijfKSMswYgOvu+ULt0LNHk+uPukGDAgc5tPPDGDFW7nnP2OLsHTZiU0ru+hVW6pwmUWamdw9CtVYYN4CCUjnQqgvb94g3wpRPVU6DEerpaquJfPtE2jO1JfPkiKJBnFKmp/XDonJ174B9H3Q2ALAHhnGk9D9FbkhpBYeWwuUNrnA2jr6/JXFLjPbvlq+Lu4DfSA/DEHzV23cFGp6velvGNhUJkqPtrQSayML+cLLRFq03H1sbJQJcx4Y1iMVe7UJQ63+NBdRe8qZLTh8iL11i08SaucoJmprRs6KRcy5Yuj+Uh9zkXAVnOgUohHdn22iRE/SF0p9gv8JuEJacIkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MxfPfKaFdtUcFEY86r42b9AosJVDLdyozBmb0j9Noc=;
 b=yRtD95X/jv6nqbn9y//zSKmcXWlaJfSsCVlmrxJw2331xNafhF2+MTlG92xRs7LQy9H4J2TsmYtbm7oXbaYaZyIQ5nrb5jaRHRftORIA3g5xbrZsfMbvulorwGrnOSQx/0RUjmKDFY3tSVD/20HAYFUn1RoSyMTtHfQ8PRe9X3Y=
Received: from PH8PR02CA0015.namprd02.prod.outlook.com (2603:10b6:510:2d0::7)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:48:23 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::2f) by PH8PR02CA0015.outlook.office365.com
 (2603:10b6:510:2d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/42] drm/amdgpu: rework reset reemit handling
Date: Wed, 14 Jan 2026 11:47:26 -0500
Message-ID: <20260114164727.15367-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0dc9ab-c2c8-49e6-9ea9-08de538cba78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zMzBJqxqS4uV/rMUpheuCqIeksKHdzJqtfsz4ziu1J8ryFSaPxbKTU8kGSH?=
 =?us-ascii?Q?GrHtZabw1VntRl3D8Xgm5ZriiKG2utKXkC31Jq8et/IcR2FlsF3Bul/oltJ8?=
 =?us-ascii?Q?Nc7+6XepmokuyMwarifm/UwVPQ4ul+HbClr+f1cxMo2662jb23pNA7v530ZT?=
 =?us-ascii?Q?Hgzhsdp9FBCVMtsS44iX2mSU7Fm8cNIO01VG8Pu1IPKQMsQTiCEd2Q4rah4q?=
 =?us-ascii?Q?u+4zXAvwTRcWc8AVpKKBBKO0bvY9mjsNFUUEbCKK/rJ7IdKiMqdXiY7LX/vX?=
 =?us-ascii?Q?cVQPy+bV11DbHNV0z81evZZJdxhaHe/x6Nwa/3+7zrsypEcCjJ2/bjiA+h3+?=
 =?us-ascii?Q?qqcBTSXc4B+shUGEXKMyHPEPvoogzngtifN+PiVyzr0uterfyOp62fXAtkL4?=
 =?us-ascii?Q?F3wwQPUtyPu8fxn+QC14JKEcKkLOHEcUsqlSJAVWmo43DhImXhCIZnFv1oxt?=
 =?us-ascii?Q?n2t2/SdjwF0EW3H1IMT8Wj17IJADCS1awSxcswHv4Ut2gFQO1OCSCwEiGWt1?=
 =?us-ascii?Q?6M3yn7Pz7vIMgApFpD14BLooekvwMOBBpdRnBfR6Z4px4DiihxEhW3AKrBBJ?=
 =?us-ascii?Q?Ly1zz6fRT23gKLVmgPKTgpznK/NHxHF72e8r1JPrLqovY3VvdP3v1kVOnbsF?=
 =?us-ascii?Q?woM22HWXBF5NeF7V8azXvPQ36/qO9n4hgkgIBb87sl7ADyWIyl6RmCapBTvf?=
 =?us-ascii?Q?OTkyu055n+Ixr5wIs/nSh85N77IQlqd8vGoixufpBSn6BJs11hFOqfzd0G/I?=
 =?us-ascii?Q?spx+bPXqj5nCFlf9n6WINPFEqIooJ9vFv9SgncMsxcC/znwObcjOTlth5VhD?=
 =?us-ascii?Q?/xUiyTKW+xTnzJZuv1akBIFiehOFhkXD1JwwbfwI3SCncrKulckpn8Nrg89P?=
 =?us-ascii?Q?Ur09b3+pS04i5utOyzzMcuyUfhzTT8Sr4tDlm3KP+q5dihtAIMtksGTzC9ag?=
 =?us-ascii?Q?IKIET1L1Zl6anPIeQSQVf4Ej7uguxMu7ikKJCjYw2E6khoX0kWpyHMeiLmUR?=
 =?us-ascii?Q?8NWLn0K0g9GBzJoP/7oC5c0cCqlDamO2iNVXv4DkaJ4aL3HA2+DtyUfz3a3H?=
 =?us-ascii?Q?LxWczxRCcCCDZJoq6YWTxPOoEXeww4LFozUdUE8CZaTRjdPO8bv9IB/0H4Ta?=
 =?us-ascii?Q?a4LOtlpjzeh4nJGwPyF41fVkKMdt3RFEidPQ6dDzh/DkYs6j0gm6vf5Kufwq?=
 =?us-ascii?Q?dZhtDuKH0f/wCb/75JxRKghwWm8fm8+mJfgXpF5jt74pkSD9438mDp4xWqfw?=
 =?us-ascii?Q?rZ9Ql0o4/1OhibUcR3Kpox04n8x7dcglPDNc4jbm2e6A/gm4XqmcTdVkiQ11?=
 =?us-ascii?Q?XeqtxvuGi3GkHuWuiqh8XhsxrVc4miGFikIf6Y/c8S4DjiabYDp3uORmdfoW?=
 =?us-ascii?Q?DTNZlnyWBZNOdtdw02Ctus6hIL75QufEXZruTFpg1QByZHqmFbaNOGPXFz8M?=
 =?us-ascii?Q?HKxMbVRlu7H4uGVmWP10f4DGJoVSOmsWaSfd8egHi0kKKYrX4yGsC1pHlDVV?=
 =?us-ascii?Q?45L+bJ0muAJLJ8aJSYTpXBIK9yEiGf6CHVsc0i0ThTKComQnECDleNnHRVBa?=
 =?us-ascii?Q?XS2v4kQi4MxMDnpcreOOy9X3z5uzVWzHj+v9yMTGVwkkhrgF3POg2WtsT1/v?=
 =?us-ascii?Q?HsTJwCO5UHoq5+n4FYRpUaiPgaFQjXaMAaAZO7nykXcQSiKYZN8NCd2EgIHD?=
 =?us-ascii?Q?YGzjaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:22.1333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0dc9ab-c2c8-49e6-9ea9-08de538cba78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

Rather than saving and reemitting the ring's contents,
use the state stored in the job and fence to reemit
the state explicitly.  This greatly simplifies reemitting
the ring state and allows it to be reemitted over and
over if there are multiple ring resets.

v2: save and restore ring state as well

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 91 ++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 46 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 33 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 50 +------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 15 +---
 5 files changed, 80 insertions(+), 155 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c1cb47e92d08c..28691f9b6e32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
 	return seq;
 }
 
-static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
-{
-	af->fence_wptr_start = af->ring->wptr;
-}
-
-static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
-{
-	af->fence_wptr_end = af->ring->wptr;
-}
-
 /**
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
@@ -154,11 +144,8 @@ int amdgpu_fence_init(struct amdgpu_ring *ring, struct amdgpu_fence *af)
 void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       unsigned int flags)
 {
-	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       af->base.seqno, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_fence_wptr_end(af);
-	amdgpu_fence_save_wptr(af);
 }
 
 /**
@@ -743,7 +730,6 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
-	bool reemitted = false;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -761,84 +747,17 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence->reemitted > 1)
-				reemitted = true;
-			else if (fence == af)
+			if (fence == af) {
 				dma_fence_set_error(&fence->base, -ETIME);
-			else if (fence->context == af->context)
+				fence->skip_ib = true;
+			} else if (fence->context == af->context) {
 				dma_fence_set_error(&fence->base, -ECANCELED);
-		}
-		rcu_read_unlock();
-	} while (last_seq != seq);
-	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-
-	if (reemitted) {
-		/* if we've already reemitted once then just cancel everything */
-		amdgpu_fence_driver_force_completion(af->ring, &af->base);
-		af->ring->ring_backup_entries_to_copy = 0;
-	}
-}
-
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
-{
-	af->wptr = af->ring->wptr;
-}
-
-static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
-						   u64 start_wptr, u32 end_wptr)
-{
-	unsigned int first_idx = start_wptr & ring->buf_mask;
-	unsigned int last_idx = end_wptr & ring->buf_mask;
-	unsigned int i;
-
-	/* Backup the contents of the ring buffer. */
-	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
-		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
-}
-
-void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
-					     struct amdgpu_fence *guilty_fence)
-{
-	struct dma_fence *unprocessed;
-	struct dma_fence __rcu **ptr;
-	struct amdgpu_fence *fence;
-	u64 wptr;
-	u32 seq, last_seq;
-
-	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
-	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
-	wptr = ring->fence_drv.signalled_wptr;
-	ring->ring_backup_entries_to_copy = 0;
-
-	do {
-		last_seq++;
-		last_seq &= ring->fence_drv.num_fences_mask;
-
-		ptr = &ring->fence_drv.fences[last_seq];
-		rcu_read_lock();
-		unprocessed = rcu_dereference(*ptr);
-
-		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
-			fence = container_of(unprocessed, struct amdgpu_fence, base);
-
-			/* save everything if the ring is not guilty, otherwise
-			 * just save the content from other contexts.
-			 */
-			if (!fence->reemitted &&
-			    (!guilty_fence || (fence->context != guilty_fence->context))) {
-				amdgpu_ring_backup_unprocessed_command(ring, wptr,
-								       fence->wptr);
-			} else if (!fence->reemitted) {
-				/* always save the fence */
-				amdgpu_ring_backup_unprocessed_command(ring,
-								       fence->fence_wptr_start,
-								       fence->fence_wptr_end);
+				fence->skip_ib = true;
 			}
-			wptr = fence->wptr;
-			fence->reemitted++;
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
+	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4126be3ed3efd..ab6e35716c266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -99,7 +99,7 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
 	amdgpu_sa_bo_free(&ib->sa_bo, f);
 }
 
-static int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
+int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
@@ -135,6 +135,40 @@ static int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
 		return r;
 	}
 
+	if (job->hw_fence->skip_ib) {
+		if (ring->funcs->insert_start)
+			ring->funcs->insert_start(ring);
+		if (job->emit_vm_fence) {
+			amdgpu_ring_ib_begin(ring);
+			if (ring->funcs->init_cond_exec)
+				cond_exec = amdgpu_ring_init_cond_exec(ring,
+								       ring->cond_exe_gpu_addr);
+			if (job->vm_flush_needed)
+				amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
+			amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+			amdgpu_ring_ib_end(ring);
+			amdgpu_ring_patch_cond_exec(ring, cond_exec);
+		}
+		amdgpu_ring_ib_begin(ring);
+		if (ring->funcs->emit_gfx_shadow)
+			amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
+						    init_shadow, vmid);
+		if (ring->funcs->init_cond_exec)
+			cond_exec = amdgpu_ring_init_cond_exec(ring,
+							       ring->cond_exe_gpu_addr);
+		if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec) {
+			amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
+			amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
+		}
+		amdgpu_fence_emit(ring, job->hw_fence, fence_flags);
+		if (ring->funcs->insert_end)
+			ring->funcs->insert_end(ring);
+		amdgpu_ring_patch_cond_exec(ring, cond_exec);
+		amdgpu_ring_ib_end(ring);
+		amdgpu_ring_commit(ring);
+		return 0;
+	}
+
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
@@ -221,14 +255,6 @@ static int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
-	/* Save the wptr associated with this fence.
-	 * This must be last for resets to work properly
-	 * as we need to save the wptr associated with this
-	 * fence so we know what rings contents to backup
-	 * after we reset the queue.
-	 */
-	amdgpu_fence_save_wptr(job->hw_fence);
-
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 
@@ -300,6 +326,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	amdgpu_ring_save_state(ring, job);
+
 	job->need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index af57e116126a8..887bfd40b9bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -85,6 +85,37 @@ static void amdgpu_job_core_dump(struct amdgpu_device *adev,
 	}
 }
 
+static int amdgpu_job_reemit_jobs(struct drm_sched_job *timedout_s_job)
+{
+	struct amdgpu_job *timedout_job = to_amdgpu_job(timedout_s_job);
+	struct amdgpu_ring *ring = to_amdgpu_ring(timedout_s_job->sched);
+	struct drm_gpu_scheduler *sched = &ring->sched;
+	struct drm_sched_job *s_job, *tmp;
+	int r;
+
+	/* skip reemit if we reset all the rings on an instance */
+	if (ring->all_instance_rings_reset)
+		return 0;
+
+	amdgpu_ring_restore_state(ring, timedout_job);
+
+	r = amdgpu_ib_emit(ring, timedout_job);
+	if (r)
+		return r;
+	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
+		struct amdgpu_job *job = to_amdgpu_job(s_job);
+
+		amdgpu_ring_save_state(ring, job);
+
+		r = amdgpu_ib_emit(ring, job);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
@@ -138,6 +169,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
+		if (!r)
+			r = amdgpu_job_reemit_jobs(s_job);
 		if (!r) {
 			/* Start the scheduler again */
 			drm_sched_wqueue_start(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 0065ac0fb1e52..3a031649f6c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -104,29 +104,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 	return 0;
 }
 
-/**
- * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reemit
- *
- * @ring: amdgpu_ring structure holding ring information
- * @ndw: number of dwords to allocate in the ring buffer
- *
- * Allocate @ndw dwords in the ring buffer (all asics).
- * doesn't check the max_dw limit as we may be reemitting
- * several submissions.
- */
-static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
-{
-	/* Align requested size with padding so unlock_commit can
-	 * pad safely */
-	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
-
-	ring->count_dw = ndw;
-	ring->wptr_old = ring->wptr;
-
-	if (ring->funcs->begin_use)
-		ring->funcs->begin_use(ring);
-}
-
 /**
  * amdgpu_ring_insert_nop - insert NOP packets
  *
@@ -370,12 +347,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	/*  Initialize cached_rptr to 0 */
 	ring->cached_rptr = 0;
 
-	if (!ring->ring_backup) {
-		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
-		if (!ring->ring_backup)
-			return -ENOMEM;
-	}
-
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
 		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_bytes,
@@ -386,7 +357,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    (void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
-			kvfree(ring->ring_backup);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
@@ -430,8 +400,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
 			      (void **)&ring->ring);
-	kvfree(ring->ring_backup);
-	ring->ring_backup = NULL;
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
@@ -868,8 +836,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* back up the non-guilty commands */
-	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	/* set an error on all fences from the context */
 	if (guilty_fence)
 		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
@@ -878,22 +844,8 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence)
 {
-	unsigned int i;
-	int r;
-
 	/* verify that the ring is functional */
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-
-	/* Re-emit the non-guilty commands */
-	if (ring->ring_backup_entries_to_copy) {
-		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
-			amdgpu_ring_write(ring, ring->ring_backup[i]);
-		amdgpu_ring_commit(ring);
-	}
-	return 0;
+	return amdgpu_ring_test_ring(ring);
 }
 
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 340d4f6b87a93..e935159a61a3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -150,11 +150,8 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
-	/* has this fence been reemitted */
-	unsigned int			reemitted;
-	/* wptr for the fence for the submission */
-	u64				fence_wptr_start;
-	u64				fence_wptr_end;
+	/*  fence state */
+	bool				skip_ib;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -163,7 +160,6 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 					  struct dma_fence *timedout_fence);
 void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -312,9 +308,6 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
-	/* backups for resets */
-	uint32_t		*ring_backup;
-	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
@@ -572,14 +565,14 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  enum amdgpu_ib_pool_type pool,
 		  struct amdgpu_ib *ib);
 void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f);
+int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job);
 int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f);
+
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
-void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
-					     struct amdgpu_fence *guilty_fence);
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
-- 
2.52.0


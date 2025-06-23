Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03641C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 17:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F25C10E1E3;
	Mon, 23 Jun 2025 17:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c0Zej5c+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7976D10E1E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 17:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN7ffavEdJmI8SRSdLol5XjCifTUgTM8cmjw1GJLkIeSDNqPnuhyVoUoWIHDtWDnWF9BUt8CLa2U2Zes8exZ5+wMoyg2/IDWaQd1zZIDSmVWZ7b3ayR4jWXujSz4xmKnQ27OJ+PS72fv3Y6/dw2EYS2ZmK0bPWKt4z03oRcw7dR34JHNhGNJqqfiGnk4HPU8A7xO4hb4DN0kvRAqTZXOV3L+P/6tYyevXUBeOmAl3GyxGV4ucR8fFkk3nigjwkBwUy4587XGfQR40mHZBMF4GOLe+YHUvBi6dwjOC9HvWvfM9R2NgI5XF2jkJ+lRIdiww/FwCQJj3nKsz5C8fbT0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhRWlLSrtJN7Gxf+DehXk8gI5ZKUcU/HS93JYdHAJtk=;
 b=Fc2d7bOf+SHFJaDpbQvsi5Qh8WVFL6v0K8bizpgS4x516pXZTLd2k8rbBsNzSgmSGMouXbUJmHH8inKJ3REHzZfJs51+O6pueXPgzNV1DxtgNlxzLXTpEQjv8ZDKbXsSy+r105iwGm78K19RY7G2NVJ6wQxrDiLKUdU/x05LdqPTYTpT4IDru65vDbZ+xxDScnhywsnlVkDvHO5WUjgAUN+BcSoCf9oLR/SfFZh3BqAaPPaZyZRY4vLvDkYO24U4vc+CChNm5OOk0dYh/UZzXWH+DpkJS+zlv9bXSpkn3kbXmNyEsm6pIdriXPRm+bRXrCaW5FSoxMgoueTDVDuIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhRWlLSrtJN7Gxf+DehXk8gI5ZKUcU/HS93JYdHAJtk=;
 b=c0Zej5c+jyJYMmCFOm6w91lcPQgkBWyARFnOGK1coUo3RwDevbmykFDIkIbauReP/p+pOLPhTgoYcidf2YC1o7/1yyRZhUTzXK1BtZqbTtTud2/ZsaKHYegQuSpuutpQghqVYBdn4pvQD5mnUPkhQKwfc4q0tfGjfHn4GROvFgo=
Received: from DS7PR03CA0331.namprd03.prod.outlook.com (2603:10b6:8:55::26) by
 SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 17:00:50 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::1b) by DS7PR03CA0331.outlook.office365.com
 (2603:10b6:8:55::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 17:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 17:00:49 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 12:00:48 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Don't call mmput from MMU notifier callback
Date: Mon, 23 Jun 2025 12:59:35 -0400
Message-ID: <20250623165936.6178-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f004e86-6cc2-455d-1e75-08ddb277812d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Bg+szeo1K1q6iMXqE44BNbYFyOJbzRIWRiWV8YKkq6lUbW0baVIMYxqulAn?=
 =?us-ascii?Q?8SuYMXaAX990LGVWXmUKSg1oeHwpXiXStkmoJ/gMq+cBJLBvstS90UB7ewYX?=
 =?us-ascii?Q?XWVSfdbUFNpqVni4kv+9bhDOa/iPPbNVFH51r30vsUc+ZVGbLzb3aL/5tpdi?=
 =?us-ascii?Q?/C7su19rcdAE7szkYK6ykGlPfPnClTxsqkq3UFf8SGDHFnW0syUnn32yk37f?=
 =?us-ascii?Q?ER4vGVOvmuA2k9Kqliwh6VRLP14feRyap3mj6oHG8vouK9ncDWKwaAnk0nIo?=
 =?us-ascii?Q?CWhRg4VXMwy0cmi9bT6MoT+tPJdWEoiyWBC3gjlQbi6e7l01cmhxTr21uBJ3?=
 =?us-ascii?Q?TQ/HMOuJJZpoCEfmUjcIaFp36JbhAmxtP8HfL7ZcUIXbGyA/FM1At20mR69X?=
 =?us-ascii?Q?C/cWwM7h7EsoI5chPiZ2ox10q1b0wihcRPMzX9lZ8kC/Ksvg83LogrHLt00g?=
 =?us-ascii?Q?YgI6XRokbCRggv930KFo6PTu8XIcutBtHT4n7UMlPU0F+0CXXCugvt4ydL2u?=
 =?us-ascii?Q?rkyR1sUfA+CIyeAIgHMHca3x+paxMDwZjDQP2d61l/7arh6rK0+afZagWEPd?=
 =?us-ascii?Q?vNVylUzzYN+mOFJgrhkiPWJZXvIU2A3KryWIBFMQl5BAoJZ88MJsqiRVimRk?=
 =?us-ascii?Q?ic4WDb+xBtG1MrMM6xzo97pG3EFLH5laByGR+lxuXGre9Jv6e6bsZvuWIUSj?=
 =?us-ascii?Q?GkETp9kZ1Q6FMfZgI1giV1HbDkiNpx3FsUoBrsygSryROPlfVKvVw63fpSJS?=
 =?us-ascii?Q?ijB6c7fE8o6P9a9coeL3hbm6q3CSjemcGTOwga8AvnyGz0dlFO1aQHnxz65G?=
 =?us-ascii?Q?Ag4yiU/3sus4rOl9bQhy/JPm31cZbTQ62myTb81C6V1FAklMLgHtOrSCQCNg?=
 =?us-ascii?Q?u9vay9vcZ2sr47iddK0VAe7+AEn1xyXdw4+47s/kHNJl0bYR10boudHzWOGm?=
 =?us-ascii?Q?HV+boa3w1qsR1Y3o0XNu6+2wjLfbKtS8woByWyZAlWL7R9UP9F8dc2Xv1hqn?=
 =?us-ascii?Q?NjsMxWEIMf6pv+8Ab4NIt95RCdmDhPP45J2YFuAAxsY+1hyRmW8CZmEYWTun?=
 =?us-ascii?Q?gnGZEZC82upb+eM7Qetx+O1QfBawSNDUwa4h7KmELFYgx7z9NMV15X1Erh4H?=
 =?us-ascii?Q?XjubboQ/P/U9s46ny0BfRFzoVPMRLivs/EzQloeOYk0t81env00MJ8WWDClZ?=
 =?us-ascii?Q?kfuPX/sqB9w8kWp+I1b9H0SGxO3wiZv0tZfK60rTr55OY0jQ6pFgCS7+RDOa?=
 =?us-ascii?Q?zk8fqVpYwL7UKmKvRf09BQFCN/hWREwQE2RLPMLXHCf6x3iXUM1xg6vTG7Dk?=
 =?us-ascii?Q?1AKTcmYIf39WyhqQBU52++9+F/j2rOrfmQ1aUFZby1eaFUgenEAfwg4hGzqC?=
 =?us-ascii?Q?2N0OYdS7qUb7oBtfeX4L34i9gGCMbE1Ly9YuIEe3YvGQUiXP14HLcBlcW0I0?=
 =?us-ascii?Q?+GgW+XyJ5eL8vfukALAK0zZbLtfyCX3jVaGYFcPfyc9oigIdQLblxoCWxb+L?=
 =?us-ascii?Q?HubKEgb6Mw8qUvjivGto9/cTwNe8RLpcNZMf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 17:00:49.3765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f004e86-6cc2-455d-1e75-08ddb277812d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

If the process is exiting, the mmput inside mmu notifier callback from
compactd or fork or numa balancing could release the last reference
of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
with below backtrace.

The deadlock will leak kfd process as mmu notifier release is not called
and cause VRAM leaking.

The fix is to take mm reference mmget_non_zero when adding prange to the
deferred list to pair with mmput in deferred list work.

The backtrace of hung task:

 INFO: task python:348105 blocked for more than 64512 seconds.
 Call Trace:
  __schedule+0x1c3/0x550
  schedule+0x46/0xb0
  rwsem_down_write_slowpath+0x24b/0x4c0
  unlink_anon_vmas+0xb1/0x1c0
  free_pgtables+0xa9/0x130
  exit_mmap+0xbc/0x1a0
  mmput+0x5a/0x140
  svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
  mn_itree_invalidate+0x72/0xc0
  __mmu_notifier_invalidate_range_start+0x48/0x60
  try_to_unmap_one+0x10fa/0x1400
  rmap_walk_anon+0x196/0x460
  try_to_unmap+0xbb/0x210
  migrate_page_unmap+0x54d/0x7e0
  migrate_pages_batch+0x1c3/0xae0
  migrate_pages_sync+0x98/0x240
  migrate_pages+0x25c/0x520
  compact_zone+0x29d/0x590
  compact_zone_order+0xb6/0xf0
  try_to_compact_pages+0xbe/0x220
  __alloc_pages_direct_compact+0x96/0x1a0
  __alloc_pages_slowpath+0x410/0x930
  __alloc_pages_nodemask+0x3a9/0x3e0
  do_huge_pmd_anonymous_page+0xd7/0x3e0
  __handle_mm_fault+0x5e3/0x5f0
  handle_mm_fault+0xf7/0x2e0
  hmm_vma_fault.isra.0+0x4d/0xa0
  walk_pmd_range.isra.0+0xa8/0x310
  walk_pud_range+0x167/0x240
  walk_pgd_range+0x55/0x100
  __walk_page_range+0x87/0x90
  walk_page_range+0xf6/0x160
  hmm_range_fault+0x4f/0x90
  amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
  amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
  init_user_pages+0xb1/0x2a0 [amdgpu]
  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
  kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
  kfd_ioctl+0x29d/0x500 [amdgpu]

Fixes: fa582c6f3684 ("drm/amdkfd: Use mmget_not_zero in MMU notifier")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10d1276f8e1c..5fe92f9a1ce1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2392,15 +2392,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 		    prange->work_item.op != SVM_OP_UNMAP_RANGE)
 			prange->work_item.op = op;
 	} else {
-		prange->work_item.op = op;
-
-		/* Pairs with mmput in deferred_list_work */
-		mmget(mm);
-		prange->work_item.mm = mm;
-		list_add_tail(&prange->deferred_list,
-			      &prange->svms->deferred_range_list);
-		pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
-			 prange, prange->start, prange->last, op);
+		/* Pairs with mmput in deferred_list_work.
+		 * If process is exiting and mm is gone, don't update mmu notifier.
+		 */
+		if (mmget_not_zero(mm)) {
+			prange->work_item.mm = mm;
+			prange->work_item.op = op;
+			list_add_tail(&prange->deferred_list,
+				      &prange->svms->deferred_range_list);
+			pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
+				 prange, prange->start, prange->last, op);
+		}
 	}
 	spin_unlock(&svms->deferred_list_lock);
 }
@@ -2568,8 +2570,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 
 	if (range->event == MMU_NOTIFY_RELEASE)
 		return true;
-	if (!mmget_not_zero(mni->mm))
-		return true;
 
 	start = mni->interval_tree.start;
 	last = mni->interval_tree.last;
@@ -2596,7 +2596,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 	}
 
 	svm_range_unlock(prange);
-	mmput(mni->mm);
 
 	return true;
 }
-- 
2.49.0


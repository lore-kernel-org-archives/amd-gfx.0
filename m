Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F1DCDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 01:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9580010E052;
	Thu, 19 Oct 2023 01:56:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC9410E052
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 01:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbIFKChVHm9Gp9XMaPCspl4dI39sje+gcuAOTnY5bdpgoy/bjUO8dq8ICyF4xDQUePvsAxZiYSnF/y/cHtzx6sOhCYdAAYS84p7rH5qMV1kTPhndJI4r7Y29Tzoxo+baY4uSBlnThqQl+0tgVj9bCPcMvQgN3Ylg/tXGXR48tCRA9TgnlER5SBGb9WFpuwcVcyJV7P1chh9Kud29uVkvPWrHvY04N4Y1c2pePavrlMDVxC46QXf5cwb2bOusuJVoGFjc8EGuIcJQy+QGD89aDCH+mRtO1PyuPaBvtE7MhXfEId5bMErDvZe6dFOgf1r5z33RTQ/2GEJZC0CB2sE3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKAy55l/SEV4H7WLMTb8QUyAMFUwiYP4VsNeBVSrUgE=;
 b=aQpK6Z/KBevP4dGnqGLYePGMjS4v5VS9wpr/WEQwORfLTrzr26f4WlYXFFAyukkFfFxaeyol7u9EiyzD8BYWM6UJRZilel1W+moDj2FAD+MxXYKd8JUZHq6+HFh/yC1n/+tCZl9BE0tgCurLxAloz61WBDMGWs9/dGqwyyxRjRKWjS+fZE21PhsEU/LwuKdNxTpf55smtCRpMEGXDIJ29V27VI6SVXTCVV4B51tWpG2BRxFT+UQ/dD3Ma90h7XLvK3AaKMEqAHPd9TG0YhSEijfRXvbx/rjikuN65mmyOLSdZpARUxmcgO3/9+s9xs15PuldNsKjDK8kdtXYDlnkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKAy55l/SEV4H7WLMTb8QUyAMFUwiYP4VsNeBVSrUgE=;
 b=0o18wtCDljlsHSvUV+3cQlgR/I7bWQ1+yi7BLLdTKFfnIWda0G3T+aDsl2OjorJ8p7CxowPBAoXXt1bAU65zYuxzNz1CWV6c5AsUHpwtJ+qdbtMkc4viv5ABthfFPcJDv70uVdhS8KofyjxIBHy9ObNcnwlv2NjFp0bOkWcqCr8=
Received: from SA9PR13CA0118.namprd13.prod.outlook.com (2603:10b6:806:24::33)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 01:56:31 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::49) by SA9PR13CA0118.outlook.office365.com
 (2603:10b6:806:24::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Thu, 19 Oct 2023 01:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 01:56:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 20:56:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 18:56:21 -0700
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 20:56:14 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue and remove unused
 code.
Date: Thu, 19 Oct 2023 09:56:09 +0800
Message-ID: <20231019015609.299859-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 150f9ea9-32ef-4c4a-7a9d-08dbd0469d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuZEVFBjiUiOPi9CnMDyDlZalgYOP3I4AUtMmTAqZA4vrVIv+cewmEBUYghI7id2CuoruiboNES3RkjZG2vuohmexofmBH6DhHoH0royuJWk3MrswbKdQj4/ZHekBe0yqo3HY5GMCRb4ddn6OOg5JVt/XFS+MrHFtsd/fvin4nPUXFNuxdWJMEqfxDaY5t90fjr6B09vpgRF1jTxHRMdQMpQMSHqaGqKwhVO2MawJodntp6941vN9m7OixC7wdfKt/0N74vV6Jy6CT/BxOZVTNc4p/bymNZF/s9w1HJJ8KX9/T2nTATVoku+K5jeGeFa5kAkjIhJTQYLwF6BRJt0FQQhXimdOx+2ujLE2akgyXdz62+PkTtczEOgZcny/ZEsZ8mhd+4BDyQJOEsUDTvClvfB5AfJN4JXUib/uHmmQZ3+wPbqroLxkni4Bv80/TxYGm+G7kVajqauIihza1IVZ24xQYCr/6ksWRlP3C1mBh2xXqUumd/+rutauJ4ehCAj+ZL4JWCeG2v+Y12LlxVQR6EduuYHWcIp9v8gh+KxdZovB3IGRkjYx4EnYH3Y/1uzW+iB0m1VEwJlwavrVUq3sznDPwloYPfmXzM5sHJncQVNALH1vxWMMd9sn4pgZJE+hAoaV5jmZGGDj5YDcogNKEkTofJXT8LBLRne/GbQe6RYnE3Q0zVlgwHt9Y65YwY+hQjpJGhuP6+eCjbvE43QmMBltQfOBZ0nuvqvq0sEkBoN8JqmRowr3hLFPKV6oqNWTivuBoMyvjGTDBEqxigMQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(356005)(6666004)(82740400003)(478600001)(2906002)(54906003)(6916009)(70586007)(81166007)(316002)(7696005)(70206006)(4326008)(8936002)(5660300002)(41300700001)(44832011)(8676002)(40480700001)(2616005)(83380400001)(1076003)(336012)(426003)(26005)(36756003)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:56:31.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150f9ea9-32ef-4c4a-7a9d-08dbd0469d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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
Cc: Alexander.Deucher@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jesse Zhang <Jesse.Zhang@amd.com>, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[  567.613292] shift exponent 255 is too large for 64-bit type 'long unsigned int'
[  567.614498] CPU: 5 PID: 238 Comm: kworker/5:1 Tainted: G           OE      6.2.0-34-generic #34~22.04.1-Ubuntu
[  567.614502] Hardware name: AMD Splinter/Splinter-RPL, BIOS WS43927N_871 09/25/2023
[  567.614504] Workqueue: events send_exception_work_handler [amdgpu]
[  567.614748] Call Trace:
[  567.614750]  <TASK>
[  567.614753]  dump_stack_lvl+0x48/0x70
[  567.614761]  dump_stack+0x10/0x20
[  567.614763]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
[  567.614769]  ? srso_alias_return_thunk+0x5/0x7f
[  567.614773]  ? update_sd_lb_stats.constprop.0+0xf2/0x3c0
[  567.614780]  svm_range_split_by_granularity.cold+0x2b/0x34 [amdgpu]
[  567.615047]  ? srso_alias_return_thunk+0x5/0x7f
[  567.615052]  svm_migrate_to_ram+0x185/0x4d0 [amdgpu]
[  567.615286]  do_swap_page+0x7b6/0xa30
[  567.615291]  ? srso_alias_return_thunk+0x5/0x7f
[  567.615294]  ? __free_pages+0x119/0x130
[  567.615299]  handle_pte_fault+0x227/0x280
[  567.615303]  __handle_mm_fault+0x3c0/0x720
[  567.615311]  handle_mm_fault+0x119/0x330
[  567.615314]  ? lock_mm_and_find_vma+0x44/0x250
[  567.615318]  do_user_addr_fault+0x1a9/0x640
[  567.615323]  exc_page_fault+0x81/0x1b0
[  567.615328]  asm_exc_page_fault+0x27/0x30
[  567.615332] RIP: 0010:__get_user_8+0x1c/0x30

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 62 +---------------------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  3 --
 2 files changed, 1 insertion(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54af7a2b29f8..ccaf86a4c02a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -781,7 +781,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			prange->flags &= ~attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
-			prange->granularity = attrs[i].value;
+			prange->granularity = attrs[i].value & 0x3F;
 			break;
 		default:
 			WARN_ONCE(1, "svm_range_check_attrs wasn't called?");
@@ -1139,66 +1139,6 @@ svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
 	list_add_tail(&pchild->child_list, &prange->child_list);
 }
 
-/**
- * svm_range_split_by_granularity - collect ranges within granularity boundary
- *
- * @p: the process with svms list
- * @mm: mm structure
- * @addr: the vm fault address in pages, to split the prange
- * @parent: parent range if prange is from child list
- * @prange: prange to split
- *
- * Trims @prange to be a single aligned block of prange->granularity if
- * possible. The head and tail are added to the child_list in @parent.
- *
- * Context: caller must hold mmap_read_lock and prange->lock
- *
- * Return:
- * 0 - OK, otherwise error code
- */
-int
-svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange)
-{
-	struct svm_range *head, *tail;
-	unsigned long start, last, size;
-	int r;
-
-	/* Align splited range start and size to granularity size, then a single
-	 * PTE will be used for whole range, this reduces the number of PTE
-	 * updated and the L1 TLB space used for translation.
-	 */
-	size = 1UL << prange->granularity;
-	start = ALIGN_DOWN(addr, size);
-	last = ALIGN(addr + 1, size) - 1;
-
-	pr_debug("svms 0x%p split [0x%lx 0x%lx] to [0x%lx 0x%lx] size 0x%lx\n",
-		 prange->svms, prange->start, prange->last, start, last, size);
-
-	if (start > prange->start) {
-		r = svm_range_split(prange, start, prange->last, &head);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, head, SVM_OP_ADD_RANGE);
-	}
-
-	if (last < prange->last) {
-		r = svm_range_split(prange, prange->start, last, &tail);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
-	}
-
-	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
-	if (p->xnack_enabled && prange->work_item.op == SVM_OP_ADD_RANGE) {
-		prange->work_item.op = SVM_OP_ADD_RANGE_AND_MAP;
-		pr_debug("change prange 0x%p [0x%lx 0x%lx] op %d\n",
-			 prange, prange->start, prange->last,
-			 SVM_OP_ADD_RANGE_AND_MAP);
-	}
-	return 0;
-}
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index be11ba0c4289..026863a0abcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -172,9 +172,6 @@ struct kfd_node *svm_range_get_node_by_id(struct svm_range *prange,
 int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
-int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr,
 			    bool write_fault);
-- 
2.25.1


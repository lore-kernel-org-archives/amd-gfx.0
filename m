Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C69CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 15:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE2E112870;
	Fri, 16 Oct 2026 15:33:01 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DA2112870
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 15:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBCi3U35c6ljbTNqiWd5TKc0a+zAKVXuoreemlApOh7blYMHypYhplYpWzWMebS9I9ggskWtIaWm0okPeDm4y0F1CwsE1R+icV2OM85V5bomGEQRRybnKUdP8SSoDQYP8Q5gjWOkxHk0GywX9bkdqQhf/OU9s8PNBLGOR5Zq0eflY1s/KCqnz+ZHinSHPVlqSV1pnDuogpPnBHXHRfpv3H+DHkwnJEnCXebqC0cpw/QbWbAtShHRJP54QTGF9iUeRl7Y55rjk6U/p3ZzVs8k1XUx4zq4s8PsvpgxCPtSwnFnvKY+AT1SOn5iXDB3dXAeohzJb5/7DsFITK60T2z2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSTeoSIaYbwEZCPrwdLuEuyOAoY3aiDaC2N4m9BpfrQ=;
 b=f4X5PTl/68z46BT5OLb6FjY2QkDBeuIuZHC/xqNLOXOgNaivQf91j13TJXXGBE697hWEhB+U05LXj0Ckm6p72m/XdpiqIbvuzgrMVswI2xPMjwrClnYUgAiW2aYaUYItoqCQUQqURCzkmWYhnD7l1/L9utnK2DVqrnG1JXIseC5Fcfl03WDNh4lLLiJJ12TnZHX9Ayfxm+Nezb1jCZcKK02TN7k2ocaPz5uUeSZw3OMyu9xBiKuf7ZSs7e4QezZEPJkSfjLWXOuC8LbhxCC1xJMOd6+ptzAywf8BNJdB9gCXV+nJe+XmJ3iq0l4ajnNT55gWXfX4hddcI082BDGV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSTeoSIaYbwEZCPrwdLuEuyOAoY3aiDaC2N4m9BpfrQ=;
 b=t2bzyvA4yBBkcJtOWsDSuEbNOwXia4go63qvXyiUrTfRP3vSMJjNCpUfpdLPT1ti2hqY1T1hACS7zmPkJtHlrxCUNvG+nHX/+AtbHQ5IcTP1IfHHE9CQZMrWo0E9WbmWK3Pepn51ltr60aHWaBeLScPMbIQ9hl8nLG6eoyPHuFU=
Received: from PH7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:33d::27)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 15:32:51 +0000
Received: from CY7PEPF000000EB.namprd04.prod.outlook.com
 (2603:10b6:510:33d:cafe::ae) by PH7PR02CA0008.outlook.office365.com
 (2603:10b6:510:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 15:32:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000EB.mail.protection.outlook.com (10.167.247.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 15:32:49 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 10:32:42 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>,
 <Kent.Russell@amd.com>, <Harish.Kasiviswanathan@amd.com>, William Palacek
 <William.Palacek@amd.com>
Subject: [PATCH v5] drm/amdkfd: wait for a GPU reset before freeing a BO
Date: Fri, 16 Oct 2026 11:32:36 -0400
Message-ID: <20261016153236.1163913-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EB:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: c732ab7e-b56e-4faf-38ea-08df2b9abc9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|260925022911599003|10067099003|18002099003|260925021911599003|260925021311599003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: HFhsQxP1Tqm0yQalERazjqmEovsqIVkO9NdGuKHeTrvYEhpT5FZ3x3wRVd6goWY7ejneJasyLqKj8HZLnRQ3t6PlmXvufqghno5igIR1+TNyxnFLy0m/OLuk37llqXWwiTYskuF8CDf53Fb0VzkLGQXgPcLPd/26dkYWMJMsvK0mCEGXt23l0uP13FnbSGXsRX+kQXqO8X1T4lBMlf0R/IuN3jNnGkGWAcM923KvomHl3POxVBxxd8YNIUAUk6fDU99uYnF38E6JPt5ytLJUrz5IR5NVFMlAlYjK0F5LweAWu9IdlTboMX/4/AUDEJVgLvLMGj5tF4jd5ahA3JTQKdj+kIkTUSHbxx3PmTD/2UMJSHTKO7X4FpnoVcxR64dspR3khqqKUydGcoeEilgFZgsW9QAstNcwW107z2oYMmA37kug5W6tgYsybegg/qkMxDCxHI2dBOliWig+HeFmBRiG/8YbrmPo2J4/SDQy8MdOh4Zg3TYmClbePOw9n1OcnHyB4IcOhKiR/2uvABQvnPB0Jpzp4yTNIM90FJv4Xqd80upA3uWv/rSml8fE6casrwjzO3Sa5PUzBuYGhRlWZx+ba0fA3WkfG9QNDB+AbIykU7SOYpLmEwqn3HOCqf7Vcx3/yToixNcXWUaqYUaMdmHlSr6ZaYQ4akBy6XvpgyhXOWot2Hy6QvS+SqKYfSAV2cEEf40XMkvfxx6EGZ0rBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(260925022911599003)(10067099003)(18002099003)(260925021911599003)(260925021311599003)(5023799004)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 70KTA0p/SxRnWNKS+b8HEhh04BTmtdEpspmnnokhKLLn5RgnK+3JAVOyn0o2gyO/YiKcdoxFpWCWDkR2dl+3pJZUC4W0Qb73eU3g/V1dDKL8j23wIrQ5X7CXSFaXFgr+nHdwjCxsgR/0XZiczWMJu4X1wHzDpzrDl77fpzPpOTE4+MLeIVGozr0t5STJJku+xQs7eddQYT9DEkZP4FWwhiIoOM51WC73UcuhWUT3wuYjjuK6Z1vDFQI0zgoc+4v2ldBYKkOP+xYIegdvQHmCbGJEM3NHgQJcPNnNTKLP7qfNk1MhDGlCagOJBRJXOyZiPwigQstCmnmwqZadF5iDRUiOjtGztQKvrjQXDJXOGepvgo3RJWb7xcp+fgOBZP45ljx0PzKgkG7irc7cl2G7VdgCg36crQ+fQ7U2ShWOsod2ZwI6IAKdqhA2z5Mplerq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:32:49.8192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c732ab7e-b56e-4faf-38ea-08df2b9abc9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000EB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150
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

When a GPU reset takes the reset domain, KFD eviction cannot unmap
user queues: execute_queues_cpsch() fails its trylock with -EIO, so
the queues keep running until the ASIC is reset. The TLB flush is also
skipped while the reset is in progress. If the process unmaps and frees
a BO in that window, its pages are released while a queue can still
access them through stale translations.

On MI300X, munmap() then crashes in free_swap_cache() on a small bogus
page pointer in its mmu_gather batch page:

  BUG: unable to handle page fault for address: 0000000000002900
  RIP: 0010:free_swap_cache+0x5/0xb0
  Call Trace:
   free_pages_and_swap_cache+0x3a/0x60
   tlb_batch_pages_flush+0x43/0x80
   tlb_flush_mmu+0x3d/0x110
   zap_pte_range+0x80d/0xcd0
   ...
   do_vmi_align_munmap+0x3e8/0x5b0
   do_vmi_munmap+0xdf/0x190
   __vm_munmap+0xad/0x180
   __x64_sys_munmap+0x1b/0x30

In a traced crash the bogus pointer was the read pointer value of an SDMA
queue the process had just destroyed, at the read pointer's page offset:
the queue's writeback landed in its freed rptr page after the page was
reused as the batch page.

commit f0b4440cdc18 ("drm/amdkfd: Fix mode1 reset crash issue") fixed
this race on process exit by waiting for the reset to complete before
freeing the process's BOs. Free through the ioctl has the same race.
Wait for the reset there too, using the same helper.

Fixes: 9c33e5fd4fb6 ("drm/amdgpu: fix locking scope when flushing tlb")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
Christian, Felix suggested asking you about a lower-level fix. In the
traces, the TLB flushes during the reset returned right away without
flushing, because amdgpu_gmc_flush_gpu_tlb_pasid_xccs() returns 0 when
it can't take the reset domain lock. So callers free memory the queue
can still access until the ASIC reset. The SVM munmap path goes through
the same flush. Felix thought a more general solution may be in
amdgpu_object.c or amdgpu_ttm.c. amdgpu_bo_release_notify() already adds
the wipe-on-release fence so TTM delays freeing the BO. Could a fence
that signals when the reset completes hold the pages the same way, or is
there a better place?

v5: new approach, replaces "drm/amdkfd: discard interrupts during a GPU
    reset" (v4) and "drm/amdgpu: preempt KFD queues before taking the
    reset domain lock" (v1-v3)
    - v4 did not address the munmap Oops (Felix). Fix the cause instead:
      BOs freed during a reset while user queues still access them
    - Reuse kfd_process_wait_gpu_reset_complete() from commit
      f0b4440cdc18 in the free-memory ioctl; no queue unmap, nothing sent
      to the GPU during the reset (Christian)
    - Drop the interrupt discard from v4

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b3ebbee76088..0953d823c345 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1305,6 +1305,9 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		goto err_unlock;
 	}
 
+	/* Queues a reset could not stop may still access the buffer */
+	kfd_process_wait_gpu_reset_complete(p);
+
 	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev,
 				(struct kgd_mem *)mem, pdd->drm_priv, &size);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7a365fca68e4..25f57dd59bfd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1126,6 +1126,7 @@ void kfd_unref_process(struct kfd_process *p);
 int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
 int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
+void kfd_process_wait_gpu_reset_complete(struct kfd_process *p);
 int kfd_resume_all_processes(void);
 
 struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e742ef206abd..7750741444ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1291,7 +1291,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 /*
  * If any GPU is ongoing reset, wait for reset complete.
  */
-static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
+void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
 {
 	int i;
 
-- 
2.43.0


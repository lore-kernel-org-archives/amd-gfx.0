Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3B4CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 18:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6133810E0C6;
	Thu, 30 Apr 2026 18:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZoEg7zo";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991EF10E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 18:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC+v8ZatOxKZNa3yAvB0yjzL2QMsIPuIHilhgPBOC5R9TBqnRvrw3E6HGkt9hD81aMW1oW06mBNZhzglDqBkakiZyUuftcwUWFZS65MujJoy4FgnDn7akhpDN/Cd2WzYksSx0+KBbQLB6C6NyUzsTthp171VBC5+iWRTPisNGThuQixtgcI+tKK1zt+dOcCEGBXw3p58nf78NHlTY1LXhXRiwPk7mR6/K5dbLM0uk7OUIp7zJt+MYMvPxxK12rz7IsCQrY5yhLuEHIW975iZw1qmZZTdlEfP43JxfsywHcJ/h0NeRdz02OjRzo/QvNeppxDKKbrPQ15I1zwX70EYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgVBIIHFX73ZRcL5UsnvBBimur0qFBJW5qtpsh5FkcE=;
 b=ZmIKUYFCyH6O90gES0FB2Zv8MKMHyzDOWkaalRCIGUmfLVeRUyhAJGznH4EMR0deLmMi1TZAQl7F96TTb0OLX9ud7934tiB2pe4dTNkJixHHddvWued/P/KQMHzP5IaO5qy0WUDmPGYwUgNTOxd1Pyjbqxa+LSTh9gry8g7+n/aC/qYUT0d+ApObKGoVxPuDnSpGq5LzwOBtGnSZZq5vVbFR9sPkP0NU4VJ1Lb08CA+Rvih/c+/WUK5Ay6oIJ6R/0mc6+xDjKvOdvS1ANE4KzGBgGdlJ7HoLozLl6dTZ611Txu++Ygb4yIhBfleIGkqR6eh1Lwm39a3M6mNUuI63Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgVBIIHFX73ZRcL5UsnvBBimur0qFBJW5qtpsh5FkcE=;
 b=PZoEg7zoXaucrIhDY6BTJulHuxuT0Si189xN/qji+EPKLSVe/fEBMiAqklRnuk6ZF040Mx8DuYj2iMExiRBkh2JjeHo1ReXgTRczepvmAbXIxobOxUiadnARHM8PWMEovgRARjb+CSmwzRB2Zk5LtAsQJB8yol3RkzDqUBxVsWw=
Received: from MN2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:208:23b::16)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 18:17:46 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::eb) by MN2PR11CA0011.outlook.office365.com
 (2603:10b6:208:23b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 18:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 18:17:45 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Apr 2026 13:17:43 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: remove obsolete codes for kfd_mmap
Date: Thu, 30 Apr 2026 14:17:18 -0400
Message-ID: <20260430181718.201371-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: acb02a84-973d-4586-2d21-08dea6e4c6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: EoCb9+C7bYVwQ5gbf+tD/taTratXgzRFNqvmKXgJ8qa8hQuI+4a7VJ2VCaGZx5RBGY0/YEl69g5BNMLiedzbIjgnGiD7bD72cjUyBucy1gha+pqkUJEMCFNRdDQBLrzlyj6ZH8Bhmnv0puAIWM7sYm4/rpc7KI4U/MF1Rzz/Cf042uOFSg5TEnIeqI75z2xOld3u6FfDUqbz26wJcYPYRQk+N2xqDeDV0lf9XBXPYmBsZUvcmRx0qGGoRSIQFkz5YP7aTKfJ3SHAXTxk+xQjDS69MzG25DXnvr8N3fNP/lFjNkkfX0RLnLsCHdXxXfBlayJVtwiUQVd4yXE1P11kI8kz9NrjNdLUJ6+PmpLYS5ZCwnk5HUrl90k9SCv2BUEfuzHRT/6hdi9M/i92lpLGUMogbsrzWNnjIek0Pj/RLbCD07f8GuC9rUdj9cjcUHdgRyBwrMpiC95YsTzD5xNETv4g4onxP/rysIiY9OlFxqv9BTOTQa8vwfFyiu/dItg8YY8Yos8iRUjCQBQQNso6OeBij0RzGVGOxh9fDncdnu0nTZccGzAu5u6JiPSrkKO+amErI2JRY81h6RUmDJ0MoSPC8plpptmTKA0GB5F6/ZwTQEVQ1U1SdzVMKJ8e7mK0+4pU5NMjwO6T2wJwBiLJbrAv0EfMiFKGBc8SFPIyqC1NfnGY0oYQYZvzQbcqEEJpH6iAS+s4RLO8/iN0BuDQH261m1eVc0aYc3Hc66o09BU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nCTRojEdr5ba/N6X6b8+W6VuzEowM7GwBsXnvtsu44Z6JGvrUEp1gUP9Vv+ECqgPe2gzde0QAGGXleOGzxn+bUBLGPn5rBoKIv5IBq7+vfSgQvJ1sMLcMawfbJB5hUxeIg1vgLkiu4a7PezvtJJ95y3yog8zhIuVA0I2ww7pFg1kmtrKolBx80kXaAuMrqiNXphHziv72HoZWT2R7k8XZkinAdnSUGZkW5YpEw1nibkvzNvvHUFzvooOWwy83/drEnxV8F1SbW8weNfGgpW9yfN+3FhGWLo/EU9WfxVOhbc9Murugv6FSno1eusl9dBsAhQmbPeqY7XCSmuGOMI0EmAMMdgV5VG7OiFepkyftWBylsTW8+BVEsoXeJ+ETmPvKPx9jvkNMCVG0dqUKCAXEEFsPrfwfSvsQmKFS8XUoG67NOjcnmWCPfMb+42L8BEi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:17:45.3208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb02a84-973d-4586-2d21-08dea6e4c6f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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

kfd_reserved_mem_mmap is only for mapping CWSR on APU in IOMMUv2
mode, which is no longer supported, and qpd->cwsr_base has been
set before calling kfd_process_init_cwsr_apu, which is the only
caller for KFD_MMAP_TYPE_RESERVED_MEM, so kfd_process_init_cwsr_apu
is not functional anymore, remove them together. On the other hand,
it will fix a vulnerability issue to abuse KFD_MMAP_TYPE_RESERVED_MEM
of kfd_mmap from userspace.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  8 ---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 76 ------------------------
 3 files changed, 2 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 881ea252b3ad..84b9bde7f371 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -149,11 +149,6 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	if (IS_ERR(process))
 		return PTR_ERR(process);
 
-	if (kfd_process_init_cwsr_apu(process, filep)) {
-		kfd_unref_process(process);
-		return -EFAULT;
-	}
-
 	/* filep now owns the reference returned by kfd_create_process */
 	filep->private_data = process;
 
@@ -3748,9 +3743,8 @@ static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 		return kfd_event_mmap(process, vma);
 
 	case KFD_MMAP_TYPE_RESERVED_MEM:
-		if (!dev)
-			return -ENODEV;
-		return kfd_reserved_mem_mmap(dev, process, vma);
+		pr_warn("KFD_MMAP_TYPE_RESERVED_MEM is no longer supported\n");
+		return -EINVAL;
 	case KFD_MMAP_TYPE_MMIO:
 		if (!dev)
 			return -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 78c76fd64677..a6ff1db477f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -995,9 +995,6 @@ struct kfd_process {
 	struct kobject *kobj_queues;
 	struct attribute attr_pasid;
 
-	/* Keep track cwsr init */
-	bool has_cwsr;
-
 	/* Exception code enable mask and status */
 	uint64_t exception_enable_mask;
 	uint64_t exception_status;
@@ -1113,8 +1110,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 
 bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
 
-int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
-			  struct vm_area_struct *vma);
 void kfd_process_notifier_release_internal(struct kfd_process *p);
 
 /* KFD process API for creating and translating handles */
@@ -1231,9 +1226,6 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled);
 
-/* CWSR initialization */
-int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
-
 /* CRIU */
 /*
  * Need to increment KFD_CRIU_PRIV_VERSION each time a change is made to any of the CRIU private
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4f6bf3b7c59c..419bb8086ccd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1430,50 +1430,6 @@ void kfd_cleanup_processes(void)
 	mmu_notifier_synchronize();
 }
 
-int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
-{
-	unsigned long  offset;
-	int i;
-
-	if (p->has_cwsr)
-		return 0;
-
-	for (i = 0; i < p->n_pdds; i++) {
-		struct kfd_node *dev = p->pdds[i]->dev;
-		struct qcm_process_device *qpd = &p->pdds[i]->qpd;
-
-		if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || qpd->cwsr_base)
-			continue;
-
-		offset = KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev->id);
-		qpd->tba_addr = (int64_t)vm_mmap(filep, 0,
-			KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
-			MAP_SHARED, offset);
-
-		if (IS_ERR_VALUE(qpd->tba_addr)) {
-			int err = qpd->tba_addr;
-
-			dev_err(dev->adev->dev,
-				"Failure to set tba address. error %d.\n", err);
-			qpd->tba_addr = 0;
-			qpd->cwsr_kaddr = NULL;
-			return err;
-		}
-
-		memcpy(qpd->cwsr_kaddr, dev->kfd->cwsr_isa, dev->kfd->cwsr_isa_size);
-
-		kfd_process_set_trap_debug_flag(qpd, p->debug_trap_enabled);
-
-		qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
-		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
-			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
-	}
-
-	p->has_cwsr = true;
-
-	return 0;
-}
-
 static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 {
 	struct kfd_node *dev = pdd->dev;
@@ -2249,38 +2205,6 @@ int kfd_resume_all_processes(void)
 	return ret;
 }
 
-int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
-			  struct vm_area_struct *vma)
-{
-	struct kfd_process_device *pdd;
-	struct qcm_process_device *qpd;
-
-	if ((vma->vm_end - vma->vm_start) != KFD_CWSR_TBA_TMA_SIZE) {
-		dev_err(dev->adev->dev, "Incorrect CWSR mapping size.\n");
-		return -EINVAL;
-	}
-
-	pdd = kfd_get_process_device_data(dev, process);
-	if (!pdd)
-		return -EINVAL;
-	qpd = &pdd->qpd;
-
-	qpd->cwsr_kaddr = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(KFD_CWSR_TBA_TMA_SIZE));
-	if (!qpd->cwsr_kaddr) {
-		dev_err(dev->adev->dev,
-			"Error allocating per process CWSR buffer.\n");
-		return -ENOMEM;
-	}
-
-	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND
-		| VM_NORESERVE | VM_DONTDUMP | VM_PFNMAP);
-	/* Mapping pages to user process */
-	return remap_pfn_range(vma, vma->vm_start,
-			       PFN_DOWN(__pa(qpd->cwsr_kaddr)),
-			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
-}
-
 /* assumes caller holds process lock. */
 int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 {
-- 
2.34.1


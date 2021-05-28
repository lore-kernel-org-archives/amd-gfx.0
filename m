Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B046C4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64866127C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64866127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E766F62E;
	Fri, 28 May 2021 20:49:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8374B6F62C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYXYJc4qSoyJYHjd4P6PaZq4pmBCH14/XsuQ2Iu2xolpydvczn1pDHnfRyzoOQktdTHQlzTYUS+pEMOqlwD/3K637oJeqjUpv2oKfHh3z7KXWJDKeCnw4B1OwGcTynZMrL8QWDI87fJ5DUwb4PyqpiEBgHddVXBUglvjpNpMxBt5lSTQlS80Gd1CYnjwOV20PxpCxqtDO0rXkvDH/vrA9GcdckmqP2+rKCAObjApvvJLC11EDflFt9xDXMwfd5BFAX69ZzaP3NXuIm9VZYMQ4in4iDLlwswITSHiXrlGfPSgxYcPBG2WA8QzE1RBw2Ycz3DFc5kRnP89Fh5O1dASrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRJIZFdO0aoLn0jWJ0aVfAQuh4R+rjkd+HQq3zHHNCk=;
 b=KRz8JbxTb+Fx3w3+a7Bwbg+b7qBBcTJArrjcrSHTxyOMKAUTnKVAJocT5eAI7+k9OEf+7+fH86ty2rjpcI7SOqK1bAZ7tOg74RxywuisADKT/P6Df+/79BpVUzqC5PgXYzFokQlLCRgfKM/mimfNQ1Zt3UviLNFDDbAPUPZ7kz1dX2CHPK/CL+/1CcOtcIKKyXOyexxnB9BPOJL9CzU38jqUyMXh+00uNylVAyFy53RFmnfega4VN/TR1KEDuqLM2Hit0WN29+TpbTjRSMg8plVuw9oq3PCFzX3qZpfF19sf/b1xHEEdsh1RkzKkCxPdU8VTs6TBwz9VLqfoaD1eyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRJIZFdO0aoLn0jWJ0aVfAQuh4R+rjkd+HQq3zHHNCk=;
 b=x3Kl9MFzpcQT2WwPANknjnqfInHKQCetpc2gyZo8/Bru0nNzodAJxwI9+ptgE3bGZ+Jjm2Mf6akFJRXE2pWzX6+todJ4psDl6nueLjx9+dd7leJAnRbK4C/uTyTMVW5eZ2+PWmytLbYmIYaxvFKOlFk+G276hc9uZ3i+i98XTh4=
Received: from DM3PR12CA0079.namprd12.prod.outlook.com (2603:10b6:0:57::23) by
 BN6PR12MB1810.namprd12.prod.outlook.com (2603:10b6:404:107::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 20:49:48 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::54) by DM3PR12CA0079.outlook.office365.com
 (2603:10b6:0:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:49:48 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:49:46 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: optimize memory mapping latency
Date: Fri, 28 May 2021 16:49:06 -0400
Message-ID: <20210528204906.245661-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528204906.245661-1-jinhuieric.huang@amd.com>
References: <20210528204906.245661-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d999b7-595d-4030-5128-08d9221a21e2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1810:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18103DCA40069FDD0601FDEC82229@BN6PR12MB1810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ij6hBjDkACBR/Gr2hJ4Cu+HjtsY/k0KmB0eJM0O3+Ub5h28axDWRzqouBMDt3H3GmypD5KIsnqlJiVJM4M6vfHjWD+dUHXPEmf6Y4aCE55x1JuVFC0S+9hI2F6lWIYXfYkQRfDlvVSXFouHNSdeiRZntpA8gGRSWatS7BySKcpGgXsHtqzVDHv2/FuOZaLRnZFhiUk2nsy8QCulmixXbdM81FnqRgjthssXCn2+DZBOUURP7HPDcouWHzcju2XSRZrSU1S9W3fksnzo2K38wadEnTtRl7VFWgtsVDUCeUaNjUL2ph5ZAHHGMe2mX8b8peKFVObQS9i8QAMYPngNIEXsO7/SqBVb5InLte3wPSWsFMTo1AYFt/9dkmVI28vgcWqqyrWfr1hHsx58Hn8LE2WBrRSI3mM5Ty76uMbVrBgC4KHOHT9Hkriix6/sCDxmZkvmI43FO9+FEXiHTaQwCexY+tWrhFyQlDKAQysxpFfAhCJs/fdK0RqtkGqeZNNvOxIEH0r/+C4zUqTrq8M1OmnI/VvbAsxMDbLRQxDNMIjyiwisW8JgB0ht52emt+8cPS3RJfk9lWMu2VQ8MAL53krZ+mdJnQpQ1TEpAvNlaEkDf1nwb56CpIItnkhAE5myC8Tic1G41gSh0n3lojrFRjqEjHClCkecP80Vcl8l+UH2X51b06ZZv3mTDgPxN4qIQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(426003)(186003)(336012)(478600001)(6916009)(2616005)(26005)(16526019)(70586007)(6666004)(5660300002)(36756003)(70206006)(7696005)(47076005)(316002)(83380400001)(4326008)(36860700001)(82740400003)(8676002)(2906002)(81166007)(1076003)(82310400003)(86362001)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:49:48.1620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d999b7-595d-4030-5128-08d9221a21e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1810
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. conditionally flush TLBs after map.
2. add heavy weight TLBs flushing after unmap.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 24 +++++++++++--------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  4 ++--
 8 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2560977760b3..997258c24ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -85,6 +85,7 @@ struct kgd_mem {
 
 	bool aql_queue;
 	bool is_imported;
+	bool table_freed;
 };
 
 /* KFD Memory Eviction */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 385c33675227..8ac0d849fd3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1132,6 +1132,8 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 	}
 
+	mem->table_freed = bo_va->table_freed;
+
 	return amdgpu_sync_fence(sync, bo_va->last_pt_update);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 36e7f088d4ee..0e0f27f779cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -87,6 +87,7 @@ struct amdgpu_bo_va {
 	bool				cleared;
 
 	bool				is_xgmi;
+	bool				table_freed;
 };
 
 struct amdgpu_bo {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b1bdc89cb5d1..57793483c8d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1897,7 +1897,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, mem,
-						pages_addr, last_update, NULL,
+						pages_addr, last_update, &bo_va->table_freed,
 						vram_base_offset);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 960913a35ee4..c45ccd1d03c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1658,16 +1658,18 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (WARN_ON_ONCE(!peer))
-			continue;
-		peer_pdd = kfd_get_process_device_data(peer, p);
-		if (WARN_ON_ONCE(!peer_pdd))
-			continue;
-		if (!amdgpu_read_lock(peer->ddev, true)) {
-			kfd_flush_tlb(peer_pdd);
-			amdgpu_read_unlock(peer->ddev);
+	if (((struct kgd_mem *)mem)->table_freed) {
+		for (i = 0; i < args->n_devices; i++) {
+			peer = kfd_device_by_id(devices_arr[i]);
+			if (WARN_ON_ONCE(!peer))
+				continue;
+			peer_pdd = kfd_get_process_device_data(peer, p);
+			if (WARN_ON_ONCE(!peer_pdd))
+				continue;
+			if (!amdgpu_read_lock(peer->ddev, true)) {
+				kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+				amdgpu_read_unlock(peer->ddev);
+			}
 		}
 	}
 
@@ -1766,6 +1768,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			amdgpu_read_unlock(peer->ddev);
 			goto unmap_memory_from_gpu_failed;
 		}
+		((struct kgd_mem *)mem)->table_freed = false;
+		kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 		amdgpu_read_unlock(peer->ddev);
 		args->n_success = i+1;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c1bea1f7627b..a4920bc5cfbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -278,7 +278,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd->vmid,
 			qpd->page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
 		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
@@ -314,7 +314,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			pr_err("Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
@@ -885,7 +885,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm->dev->kgd,
 				qpd->vmid,
 				qpd->page_table_base);
-		kfd_flush_tlb(pdd);
+		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ecdd5e782b81..edce3ecf207d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
 
-void kfd_flush_tlb(struct kfd_process_device *pdd);
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4ab9da288f90..a03373743a3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2161,7 +2161,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
 }
 
-void kfd_flush_tlb(struct kfd_process_device *pdd)
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 {
 	struct kfd_dev *dev = pdd->dev;
 
@@ -2174,7 +2174,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
 							pdd->qpd.vmid);
 	} else {
 		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
-					pdd->process->pasid, TLB_FLUSH_LEGACY);
+					pdd->process->pasid, type);
 	}
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

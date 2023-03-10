Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7E9C6FD19
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 22:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FD310EA1B;
	Fri, 10 Mar 2023 22:17:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F3510EA1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 22:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIR37nw2W0yGCOOuZFNii5Fe+y9dTfS7ZpnlItfFcK/OQSKcpYUOc8XPKpO3jwzixporIe7HqmXJp/ay3IyAMfuKZBVrbdSXa3KcB3qFjxq0xXzkX2+lv30k0Gjn+zQFBYw80GGPzQ1RaKc7Uw/6X5ppNQp7UuYKkmi7HIqUe/cBvCDDEUp9hhWx7WRvl+Q2aLSJ3NKDZULVyCtrHz2cgO0TXgOuWRlorrjmVN2Fcee9AW6tKJA1iUEjKDxDVP9GVQcOrU3osp1jAHy5vcwxvP0TaDQZ+kH2GzXU2zgGD6mppNEyT2J+4h+QA7Gp+KbwPb5ZlkP19hDStevDVr0BaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVSluThs/hs6m6pErDQ3kkR+jX9JjoOBXIlwEWGZqWU=;
 b=OG840ZQuaeZ0nzfvH9BoR0sG9AWTX3B4ZO4VT3Uh0e7EAHpqEQd63cdBNQ3edEod6A9IoXik578kZeK1ldePS2gKpwkWw5JgHP42+pQ+uJdZ1JzuxMNPnY/F8p6cjAeELM6tv8p8xnhYw0cQT627moBfj7B8uW6K4IWHctv7c5CCMcsYwRoNJdmMh+7sKh5o25GCgAjg83jegPwUVeztu4J25e1BE4oJvR4pagboQVm9tXeVIeWEt1NSftRMWdfOFMQW3SdFqDxk0OndLrDrWK4dwwnFklf5e/bOJKKx0vipj54uNcVQy4G16cygh0pW7Ir+/HBWamc0OKYtREOliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVSluThs/hs6m6pErDQ3kkR+jX9JjoOBXIlwEWGZqWU=;
 b=3llrlYeIEHb5yc9Qkcx0frfn9b/TXKpqo5ar6En377axMuFwuVEY+r/som3wX0bDcpIhWt6vEKHYY3QJlg03gaRyP2r0rTzdyNdqAT1MN2HRPs2wzom9yVumRtwuvRFYeBc76g4hGXyzm4Sx/MUidrlEbAkim630nIDckNPH7Nk=
Received: from BN1PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:e0::11)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 22:17:08 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::b) by BN1PR10CA0006.outlook.office365.com
 (2603:10b6:408:e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 22:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 22:17:07 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 16:17:06 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 1/2] drm/amdkfd: Move TLB flushing logic into amdgpu
Date: Fri, 10 Mar 2023 17:16:12 -0500
Message-ID: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e58d8ef-1ca6-4749-9f24-08db21b52fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIxXJ/jCNFJsYt8RryF+T73J5oHg+J0tm8LmNOD1VUY8a717+Ib5Mb7z7UdhpNzys6NHzy3wuGtqng+bo8xPhxKrKYwQEQSFg3ZIRBV6TrSBEk/Y3e51FwjMP3CqO7CThwoDsO88IAg+7DLYrVde8XnVWaj3R4Jpqr/c95bAMB+A2DD5IwJGfx2506ayf11/TrKWNx1mYgCCYHXsR7Hz5vmN0RvrPGnUaE9BrYUUW4rHjWYRPpffvlgyLBMisn+zhmx/1/9tysOhcRqHONarYX6KObGtq0xF5+wilbiBxF5ee0ryoqPD98qmh9LRNorWPx1QScpoaWVqOY9xCZRlmm13r0K9IFPHlM6mHsNERz2iRSpoCIBcBayuVGWv/A27fO0fWzlYrFdJlPbZHvQ3ziCKdIVVZ18F9d1nnQAAkRMn4pbavUJBtJ5o5L1G/VvpS4Z04hgf5dA4NmIJsIF2G5OymH/Oe7xVyMTaw6+3HMTV4Xu7qxU9UXcFrHfgePqKVMr+X7JajjLj6Aludxf35XVxMr8lFo6CikLBKLJCHntTVXQcPy+DPoAky4I0RK1T674dgvLLBWe1AS+/IM96O0y0fkuN7PdHSoEd+f06/2ixCKfG1pqeMpIsbSHxUR5WrQ/nA+RNCdtAIXEP6c18m7P3QA1P2G8QHUnrHeXcZQ7kF7L9xb6M5QBi7NyEMkfYkci/8PrHRnMl1zITXGUJD8/MIKGrz1/ripb3bSdHBes=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(336012)(426003)(47076005)(316002)(40460700003)(36756003)(356005)(40480700001)(82740400003)(81166007)(86362001)(36860700001)(6666004)(83380400001)(26005)(82310400005)(478600001)(1076003)(186003)(2616005)(16526019)(7696005)(5660300002)(41300700001)(8936002)(2906002)(6916009)(8676002)(70586007)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:17:07.6735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e58d8ef-1ca6-4749-9f24-08db21b52fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will make it possible for amdgpu GEM ioctls to flush TLBs on compute
VMs.

This removes VMID-based TLB flushing and always uses PASID-based
flushing. This still works because it scans the VMID-PASID mapping
registers to find the right VMID. It's only slightly less efficient. This
is not a production use case.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 30 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  9 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 28 --------------------
 5 files changed, 22 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 8816853e50c0..dcbd28e99b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -726,31 +726,25 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 	return false;
 }
 
-int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
-				     uint16_t vmid)
-{
-	if (adev->family == AMDGPU_FAMILY_AI) {
-		int i;
-
-		for (i = 0; i < adev->num_vmhubs; i++)
-			amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
-	} else {
-		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
-	}
-
-	return 0;
-}
-
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-				      uint16_t pasid, enum TLB_FLUSH_TYPE flush_type)
+int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			    enum TLB_FLUSH_TYPE type)
 {
+	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	bool all_hub = false;
 
+	/*
+	 * It can be that we race and lose here, but that is extremely unlikely
+	 * and the worst thing which could happen is that we flush the changes
+	 * into the TLB once more which is harmless.
+	 */
+	if (atomic64_xchg(&vm->kfd_last_flushed_seq, tlb_seq) == tlb_seq)
+		return 0;
+
 	if (adev->family == AMDGPU_FAMILY_AI ||
 	    adev->family == AMDGPU_FAMILY_RV)
 		all_hub = true;
 
-	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
+	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, type, all_hub);
 }
 
 bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 01ba3589b60a..dcaf69fd833c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -157,10 +157,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 				uint32_t *ib_cmd, uint32_t ib_len);
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle);
 bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
-int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
-				uint16_t vmid);
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-				uint16_t pasid, enum TLB_FLUSH_TYPE flush_type);
+int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			    enum TLB_FLUSH_TYPE type);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 03a3314e5b43..171de7da2959 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -290,6 +290,7 @@ struct amdgpu_vm {
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
 	struct dma_fence	*last_tlb_flush;
+	atomic64_t		kfd_last_flushed_seq;
 
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bfa30d12406b..e029129308e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -715,7 +715,6 @@ struct kfd_process_device {
 	/* VM context for GPUVM allocations */
 	struct file *drm_file;
 	void *drm_priv;
-	atomic64_t tlb_seq;
 
 	/* GPUVM allocations storage */
 	struct idr alloc_idr;
@@ -1344,7 +1343,13 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
 
-void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
+static inline void kfd_flush_tlb(struct kfd_process_device *pdd,							 enum TLB_FLUSH_TYPE type)
+{
+	struct amdgpu_device *adev = pdd->dev->adev;
+	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
+
+	amdgpu_amdkfd_flush_tlb(adev, vm, type);
+}
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ebabe92f7edb..48d7d30eeb24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1591,7 +1591,6 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 		return ret;
 	}
 	pdd->drm_priv = drm_file->private_data;
-	atomic64_set(&pdd->tlb_seq, 0);
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
 	if (ret)
@@ -1994,33 +1993,6 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
 }
 
-void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
-{
-	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
-	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
-	struct kfd_dev *dev = pdd->dev;
-
-	/*
-	 * It can be that we race and lose here, but that is extremely unlikely
-	 * and the worst thing which could happen is that we flush the changes
-	 * into the TLB once more which is harmless.
-	 */
-	if (atomic64_xchg(&pdd->tlb_seq, tlb_seq) == tlb_seq)
-		return;
-
-	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
-		/* Nothing to flush until a VMID is assigned, which
-		 * only happens when the first queue is created.
-		 */
-		if (pdd->qpd.vmid)
-			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->adev,
-							pdd->qpd.vmid);
-	} else {
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
-					pdd->process->pasid, type);
-	}
-}
-
 struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)
 {
 	int i;
-- 
2.34.1


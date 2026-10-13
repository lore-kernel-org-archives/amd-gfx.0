Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AF9CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 10:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C39610F6E7;
	Tue, 13 Oct 2026 10:10:29 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE1310F6C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 10:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygx6Tkspr7p27XFk9Wq1EnFm0OKyWmTrqhpUBqmPOVHlwDPEFMaDWkKSs4tOk2MUad+GrPo3cmlm8NzLPakblUHVZxYf0Y7GxAdRIHohFf423IUSwiWTs5b4B8v77wsM16QrTB2sCl5K3tY4CV6jiv8a02bxXkLuMHqcLXR/+rv7ijQEyxyyhk9iZgZpw1TAS+4a0CJGDufjaBfC1fiyqFt01lDo2a8bR45z6ty81nJxgUU2BO+gP3buX7p8We1ExOMpNltjaDrGoUcvdzHjMQq+YBC5dMfEpvjN0bb9WhtDP2RrieQtbSHzBaNaLHr/pOU1DKU7yPJogVchAubaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JO4nxmDBUpVLjsw46sSTl2mMwUJvS1BY6CXTt7QdcQ=;
 b=fev5bJnd5xWkk/rvGavUEnNITTH6rbIZS79upUVx5mbH1dcVw1rVyF3gduhgJhfIlF2c0++ohr78kiR93cUcQaxBWd7VZo8jE3T6TBIMMTEEXF9qUjK3Bm0xM3sMPo+aHg9GKj32BrkXX0wv9FD8OOKUtcsu5DD0GgWDaeTv82zPvyp/ggB3UQl9nivuwvsogJcKxF4NPvG0iDtRJcWeYJctUoeIkWcdUMsbFI3BVSdTr3OywvOITTIv2SY/PWM6dSeN63v7lrsyMDhYK7h4v26pN/H3trtCNpgmj1+7dNOUz9GlR6AVTNq4cF8BEaPj5y+0mpsvFRYFE7tHKnJokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JO4nxmDBUpVLjsw46sSTl2mMwUJvS1BY6CXTt7QdcQ=;
 b=16GHR+aIG7GWYbDpGa7N/r0TUpOxsFGTXHjNmbgCSlScU4t10nXjs+Jj5n/VYuHKAclux9OVsynkUPAjFlZFsi7pDOpBaZoOrVLXuyndys9En8JwgDhMs+XmBw7GYVBvlmvUNRob7UptKAPAo47KJEuZfZSEu7Bmu2+MqlLJQWk=
Received: from DS1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::10) by
 SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 13 Oct 2026 10:10:18 +0000
Received: from DM3PEPF000265BC.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::7a) by DS1P222CA0003.outlook.office365.com
 (2603:10b6:8:454::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 10:10:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BC.mail.protection.outlook.com (10.167.23.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:10:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:10:10 -0500
Received: from RSB-IT-SPARE06.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:10:09 -0500
From: Filip Adzic <Filip.Adaiat@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>, HaiJun Chang <HaiJun.Chang@amd.com>,
 Filip Adzic <Filip.Adaiat@amd.com>
Subject: [PATCH] drm/amdgpu: don't halt KFD when the guilty job has already
 signaled
Date: Tue, 13 Oct 2026 12:10:11 +0200
Message-ID: <20261013101011.16579-1-Filip.Adaiat@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BC:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5fc029-e357-4c1b-aeed-08df29122e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261009220027099003|261009223027099003|11063799006|56012099006|261009223327099003|5023799004|18002099003|261009221727099003|261009221227099003|10067099003;
X-Microsoft-Antispam-Message-Info: T9DDvSTC/beZxeFnwUwImS+NK5ZJLLB7E6UA6RuNb8j3RnBqlfYQxFfh5diupOkkKfrAPTMc8u3MrY9o7PNtHnBzaXMYqNRltAGVgcB+ev9k5ihImORdSrlbrwa9zNZ8G4JGXNYtxlkbVynZxLewm0C7B13FFp6XrpaP5K4vu5/BZrQV6bLTIoxZQkjNe3vUBxbBrqRmVBCFQNtxUP/XZfk18pCcb03S8gsPpsSMCP7zuxJH48IGdwJlqc7F7JqXnDIzwwnx5UQR/pdxPHzHLT7PMT2xWUdswWcefIkjdk2uKzyCxhDDHMGpG/A27wzq3f4k4WI+ulB7jhsRdGG376gZQx46Com2HW3JuIY9TKN0Zp7Z8f28eE9ikQ5uP/6QlwIk3FHd+h7ntR9kMw/DzNZi0Y4OnB8jMG7JFO8J86qeKRBVF8fWxlAZ3Bps8EC+P+lchb8cr6KrcNd8cX6e+7TFSY/J41z8IlPFgf3LAZ0/95L/cFmdwtouwssRfYjO34il/U2kIN3VCHnTq2GIBb2Qec0vIEX+5XZBbkE1DRkZPwPvedD8AjLXzvVV/qK7WfG7Ng+VOemEZXQE2KvxZTFJMAAl0ejs7ILJbHFXack5NoIdxY99UlCsold43oApWCago9417d7nX+bgeFGnZVqgwqy21oRGNPeMOCvIOeOSTZnu66EnCeBJfQAEJZt6/wGRXw+qMhge2HngTGK5iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261009220027099003)(261009223027099003)(11063799006)(56012099006)(261009223327099003)(5023799004)(18002099003)(261009221727099003)(261009221227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +bLNrbyaH5h1AW16+5fTZ/2RI25sWvBP75n/ntlTVybXOO+6Lg5MHar45dzUohIwswE5304FgiBdNctV2NheKa1gqMTDYxM5ntPMont6i7JgcM8z2riUv1BpEFJhD/Zu3trdKXHeTuPtuES9zNZysyWyuQDLmD2d69lGZIwooYwX6oy/fmr8Z858S3Y4gXtiWcCq+5eeXHHsrCXdWKNLAwzhMnof1QsoC12bchzh+zYvvkwQfl7U8DENxbjfMDF1GcNCYvhiS4SzA8Mg/YmazisxjX2LIAfVYZfoC5IUi0t8kv3qXSyVPiEHUwis/wbzX4VqSUl6HSmmlKMHWwi0/NJyC3F/NTTb0OR3EDVOrlBcsNWGg9ArOOO9wirzsIk/I+9FItk1vx0Y0TVc54ABDLkWhsoEo86IhSku+/TfpOEuyaWWw5OipfkWW2JuZ1H+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:10:17.1495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5fc029-e357-4c1b-aeed-08df29122e45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
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

amdgpu_device_gpu_recover() removes the user doorbell and MMIO mappings
and calls amdgpu_amdkfd_pre_reset() before it checks whether the guilty
job has signaled. If the job has already signaled by then, the ASIC
reset is skipped, but KFD has been suspended for a reset that will not
happen: user doorbell and MMIO mappings are gone, and with the reset
domain held the HIQ and user queues stay mapped. On SR-IOV nothing
resumes KFD, because the only amdgpu_amdkfd_post_reset() for a VF is in
amdgpu_device_reset_sriov(). kfd_locked is leaked and later
open("/dev/kfd") fails with -EINVAL.

Move the unmapping and amdgpu_amdkfd_pre_reset() after the signal check,
so that they only run when the ASIC is reset, and skip
amdgpu_amdkfd_post_reset() on bare metal when the job has signaled.
Emergency restart does not check the fence and still runs them.
amdgpu_pci_error_detected() now calls amdgpu_amdkfd_pre_reset() itself,
since amdgpu_device_halt_activities() no longer does.

The check can also see a job that was never submitted to the ring: when
its finished fence already carries an error, for example one copied from
its entity by amdgpu_job_prepare_job(), amdgpu_job_run() skips it, and
the job stays on the pending list until it is freed. Its HW fence was
never initialized, and dma_fence_get_status() would take its NULL lock.
Such a job cannot have hung the ring, so skip the ASIC reset for it as
for a signaled job.

Fixes: 9f4f2c1a3524 ("drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov")
Signed-off-by: Filip Adzic <Filip.Adaiat@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++--------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 44091ac12fa9..01648b0f28fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5541,8 +5541,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
-
 		/*
 		 * Mark these ASICs to be reset as untracked first
 		 * And add them back after reset completed
@@ -5687,13 +5685,15 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 
 static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 			      struct list_head *device_list,
-			      bool   need_emergency_restart)
+			      bool   need_emergency_restart,
+			      bool   job_signaled)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
 		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+		if (!need_emergency_restart && !job_signaled &&
+		    !amdgpu_sriov_vf(tmp_adev))
 			amdgpu_amdkfd_post_reset(tmp_adev);
 
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
@@ -5730,6 +5730,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_reset_context *reset_context)
 {
 	struct list_head device_list;
+	struct amdgpu_device *tmp_adev = NULL;
 	bool job_signaled = false;
 	struct amdgpu_hive_info *hive = NULL;
 	int r = 0;
@@ -5794,28 +5795,36 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
-	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
-	 * accessing them
-	 */
-	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
-	amdgpu_amdkfd_clear_kfd_mapping(adev);
-
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
-	if (need_emergency_restart)
-		goto skip_sched_resume;
 	/*
 	 * Must check guilty signal here since after this point all old
-	 * HW fences are force signaled.
+	 * HW fences are force signaled. A job whose HW fence was never
+	 * initialized was not submitted to the ring, so it cannot have hung it.
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
+	if (job && !need_emergency_restart &&
+	    (!dma_fence_was_initialized(&job->hw_fence->base) ||
+	     dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
-		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		dev_info(adev->dev, "Guilty job %s, skipping HW reset",
+			 dma_fence_was_initialized(&job->hw_fence->base) ?
+			 "already signaled" : "was not submitted");
 		goto skip_hw_reset;
 	}
 
+	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
+	 * accessing them
+	 */
+	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
+	amdgpu_amdkfd_clear_kfd_mapping(adev);
+	list_for_each_entry(tmp_adev, &device_list, reset_list)
+		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
+
+	if (need_emergency_restart)
+		goto skip_sched_resume;
+
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
 	if (r)
 		goto reset_unlock;
@@ -5824,7 +5833,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (r)
 		goto reset_unlock;
 skip_sched_resume:
-	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
+	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart,
+				 job_signaled);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	amdgpu_ras_post_reset(adev, &device_list);
@@ -6214,6 +6224,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 	struct amdgpu_hive_info *hive __free(xgmi_put_hive) =
 		amdgpu_get_xgmi_hive(adev);
 	struct amdgpu_reset_context reset_context;
+	struct amdgpu_device *tmp_adev;
 	struct list_head device_list;
 
 	dev_info(adev->dev, "PCI error: detected callback!!\n");
@@ -6254,6 +6265,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
 					      hive, false);
+		list_for_each_entry(tmp_adev, &device_list, reset_list)
+			amdgpu_amdkfd_pre_reset(tmp_adev, &reset_context);
 		if (hive)
 			mutex_unlock(&hive->hive_lock);
 		return PCI_ERS_RESULT_NEED_RESET;
@@ -6428,7 +6441,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 		list_add_tail(&adev->reset_list, &device_list);
 	}
 	amdgpu_device_sched_resume(&device_list, NULL, NULL);
-	amdgpu_device_gpu_resume(adev, &device_list, false);
+	amdgpu_device_gpu_resume(adev, &device_list, false, false);
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 
 	if (hive) {
-- 
2.43.0


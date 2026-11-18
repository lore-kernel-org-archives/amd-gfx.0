Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E632606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sWcIU0Vy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8353510FDA1;
	Wed, 18 Nov 2026 15:11:08 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE40010FD96
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAezZSKSy/j+41Vh0lAtS1jxEweV1uSJi4a0tiNrDVCzt534LKtfuumRM8YXD44+jhixFP5CnVmRpMcWbyygLOeYNwCaC5+F1Z4hJmWlsWVi9U6N8cA17xPQQzCSBmj7CV2H0YS6yGoWwFoBc4aDvKB13W1YNOv3kyESOfH4xUhgWramb938LgrZ+6p2cOSjiG5yik2E8uL2MhH8iwbW+hhvNtwiqeP1aeeGnFOa5NjXJknpWFVfU0NsSTsHFKfCphYWG+GmwRiTVmA2COJC+/FzMg6Z1vrA6lHsCalo+QvCwa6KYgsz74N70PCgZar+nfuKl/0Z7a9jcQCpxVvrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSnK+E54o/CzekT2LdWgHj+pqv3K5EbTE1JDoAyoadA=;
 b=k6wk1E7oALEeKHbq4//osHmcQozcOeHushRREaThZzMiszhFVoKV8AINnR2sp18TgtLYwpat/tsRIYTX5swbOmKe8lOxvVF7mr4Ajrg6wB8XbQPk16M6hDhVer8n9Lkv2er326DNm5rJfK2KnXoSCw6R5JzAwPgvPv8ifitlF2GSN6sjCMrI7Bojj9XYGiqNU18CGQiv6rCseSf39WTjUPtYF1uIKI7m6BKMLxPhXkzlL+ZWG0TDS50UUtjVBC1msXWfovtsbF3BfWDo5ZXB1VA/iDgyZPYhYZnaAd0SsZdNyx7mCrz2EFAdj6eJrPi8lAZON7G6KNfvJX1OvfReGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSnK+E54o/CzekT2LdWgHj+pqv3K5EbTE1JDoAyoadA=;
 b=sWcIU0VyDCf6AxXjMmWj8aExFaa/NqA4HIoqujyfndTHUdHQO8TH/Cov9TY2dcum8icvgnaF5mzqAcVr0/+DOVIYvBH3B36XCZXycKxfuH0IM55wU55acFMKahD4Vl8/h7IE3KWaYeVf016Gd0UzPT9fFbuYV5cOQiEa+jrMwI8=
Received: from PH7PR17CA0035.namprd17.prod.outlook.com (2603:10b6:510:323::16)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 15:10:56 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::49) by PH7PR17CA0035.outlook.office365.com
 (2603:10b6:510:323::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:10:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:10:56 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:10:54 -0600
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: register userptr pages without holding KFD
 process locks
Date: Wed, 18 Nov 2026 10:10:38 -0500
Message-ID: <a6ee74edf60bcb97ee2dafcae8eb3adf3a6ae94f.1795014593.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795014593.git.William.Palacek@amd.com>
References: <cover.1795014593.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2587af-7428-4f90-6293-08df45862524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261026140227099003|261022105027099003|261026121527099003|11063799006|56012099006|5023799004|261021123027099003|261021121427099003|10067099003|261009223027099003|261022075727099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: plMPFxpEI4l+xsWXpu2OMhM+ZN4TYa+cG7LqJ7Kpy2J/bNSJRtGAUZAfdXPc2sLmEsTtfz21MOm7uxVoFCDS0Olx6WUPOUXhvhLhcoiEHNz+bZPHBEo15w23RUdYuCPNwO/bn9Wm2mhuqrlq+6nwFCKlge/uh9i37lPDUPjDR5wrG7wuL4iZLG/rJYU6v08CUE5vGdzYBrwe2rh0JichiocRYhJrfqCjJ8dZ9LL79xhZcnWOBU2pWpsXNODPuzhX7sVRaZcPo/QTc17S5Zoyg930dQ9DL4hetV5TFXlqvU+dzKrQVj5NUqHP2/2nYMA1SXGU6vYll4HR+5Y2UT6m15Wwc6IA8nphK3Ycka+A05tSpuFJ7Mn6hObR98axuyEWGBFi8GyGh2q6T1nTyqvdEmYlWG1xmBOHGR6UhL1vwqc+TypooGBJFDOnffig807Jm+EP7/XrYCBSNFbZpyMoEBjjKzZEjrW3nIpfLCBhf8Eq4zL7z/115mMBTjhYapcdouiT3fqGgfNuHEsNseeNBrXBDIEzHgu52ekxuRZRzcncmb+PBoLJdaahbYeUzAq6lgJpXPBg7Cb38WWAUguTUhxh3+6R1OWhUXIVtzE8+h2ptvGRPaMYfCfJZlSoBYIOF8srBMsu8e13RoAMGiUitS0UoticxBXvZYrEkk0IApcXyUmNv1G+EqhJJKQzo3SbIQavhWSm9Tzto79tDGmp3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261026140227099003)(261022105027099003)(261026121527099003)(11063799006)(56012099006)(5023799004)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ampydGw/Mne8T9pQxLuL4fuKWdMk1c8VSyusQux/+3B9fa18CUSoGZQvPvaN65A4MK+5IE+W60/sqRxjDQaB7y7cd5QQjFX4jBbPr7x61/cFYzWSWW8QOKHVRjSOKAQuC1HuVR+K9m+koHO92dGfS1HlxAcoCadzE+5sZ36RouKqHDRutMVQvR5CWGbcB0+LRGUZi9SRcN1C2Ky1YMW/2y+wgd1Qh/q1wwVUEV4mygD/oyuCi/4ZJbBBIlH8VevgVfCWh6qHD5oRUxgwiMqr7XcoyJ0INxT1uZT9IMLH/N7hgRXyVI78m4JXVymTFH63yWXAAbBktnAHubNih7I3JoRPWxgJIWF34TZnJZ6YS/HSUp0nrXFZWX2gLttFkjDgOr+jNoXWZpG7zghCV0whM3wGa/9WKeFdG07pIWXridNvO3D7i+Zoa36RI9SsgTKl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:10:56.0056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2587af-7428-4f90-6293-08df45862524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Registering a userptr BO faults in its whole range while holding
p->mutex (alloc ioctl) and process_info->lock (init_user_pages). For a
32 GiB hipHostMalloc this takes seconds, and other threads of the
process block on both locks in their own alloc and map ioctls, stalling
GPU submission on every stream.

Allocate the BO without p->mutex; it has no handle until the ioctl
takes the lock again, so no other thread can reach it. In
init_user_pages, fault in and validate the pages without
process_info->lock, then add the BO to userptr_valid_list under
process_info->lock and notifier_lock only if the range was not
invalidated meanwhile. Otherwise return -EAGAIN, which user mode
retries; an invalidation after that point is handled by the restore
worker as before.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 45 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  7 +++
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 565ecd7e012a..01a34ee5f316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1062,12 +1062,12 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
 /* Initializes user pages. It registers the MMU notifier and validates
  * the userptr BO in the GTT domain.
  *
- * The BO must already be on the userptr_valid_list. Otherwise an
- * eviction and restore may happen that leaves the new BO unmapped
- * with the user mode queues running.
- *
- * Takes the process_info->lock to protect against concurrent restore
- * workers.
+ * Pages are faulted in and validated without process_info->lock, so a
+ * large range does not block other threads of the process. The BO is
+ * added to the userptr_valid_list only if no invalidation happened since
+ * its pages were read; otherwise an eviction and restore could leave it
+ * stale with the user mode queues running. A lost race returns -EAGAIN
+ * and user mode retries the ioctl.
  *
  * Returns 0 for success, negative errno for errors.
  */
@@ -1080,19 +1080,17 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 	struct amdgpu_hmm_range *range;
 	int ret = 0;
 
-	mutex_lock(&process_info->lock);
-
 	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, 0);
 	if (ret) {
 		pr_err("%s: Failed to set userptr: %d\n", __func__, ret);
-		goto out;
+		return ret;
 	}
 
 	ret = amdgpu_hmm_register(bo, user_addr);
 	if (ret) {
 		pr_err("%s: Failed to register MMU notifier: %d\n",
 		       __func__, ret);
-		goto out;
+		return ret;
 	}
 
 	if (criu_resume) {
@@ -1102,10 +1100,10 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 		 * later stage when it is scheduled by another ioctl called by
 		 * CRIU master process for the target pid for restore.
 		 */
+		add_kgd_mem_to_kfd_bo_list(mem, process_info, true);
 		mutex_lock(&process_info->notifier_lock);
 		mem->invalid++;
 		mutex_unlock(&process_info->notifier_lock);
-		mutex_unlock(&process_info->lock);
 		return 0;
 	}
 
@@ -1117,12 +1115,11 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 
 	ret = amdgpu_ttm_tt_get_user_pages(bo, range);
 	if (ret) {
-		amdgpu_hmm_range_free(range);
 		if (ret == -EAGAIN)
 			pr_debug("Failed to get user pages, try again\n");
 		else
 			pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
-		goto unregister_out;
+		goto release_out;
 	}
 
 	ret = amdgpu_bo_reserve(bo, true);
@@ -1138,14 +1135,27 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 	if (ret)
 		pr_err("%s: failed to validate BO\n", __func__);
 	amdgpu_bo_unreserve(bo);
+	if (ret)
+		goto release_out;
+
+	mutex_lock(&process_info->lock);
+	mutex_lock(&process_info->notifier_lock);
+	if (amdgpu_hmm_range_valid(range)) {
+		/* Earlier invalidations completed before the pages were read */
+		mem->invalid = 0;
+		list_add_tail(&mem->validate_list,
+			      &process_info->userptr_valid_list);
+	} else {
+		ret = -EAGAIN;
+	}
+	mutex_unlock(&process_info->notifier_lock);
+	mutex_unlock(&process_info->lock);
 
 release_out:
 	amdgpu_hmm_range_free(range);
 unregister_out:
 	if (ret)
 		amdgpu_hmm_unregister(bo);
-out:
-	mutex_unlock(&process_info->lock);
 	return ret;
 }
 
@@ -1875,7 +1885,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
 
-	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
+	if (!user_addr)
+		add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
 
 	if (user_addr) {
 		pr_debug("creating userptr BO for user_addr = %llx\n", user_addr);
@@ -1907,10 +1918,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	return 0;
 
-allocate_init_user_pages_failed:
 err_pin_bo:
 err_validate_bo:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+allocate_init_user_pages_failed:
 	drm_gem_handle_delete(adev->kfd.client.file, (*mem)->gem_handle);
 err_gem_handle_create:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9886bbd28ea2..acd4dd0f2f06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1228,10 +1228,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		}
 	}
 
+	/*
+	 * Not under p->mutex: a userptr BO faults in its whole range here.
+	 * The BO has no handle yet, so nothing else can reach it, and pdd
+	 * lives until process teardown.
+	 */
+	mutex_unlock(&p->mutex);
 	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		dev->adev, args->va_addr, args->size,
 		pdd->drm_priv, (struct kgd_mem **) &mem, &offset,
 		flags, false);
+	mutex_lock(&p->mutex);
 
 	if (err)
 		goto err_unlock;
-- 
2.43.0


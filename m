Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6D8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AC361037
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27AC361037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DBD6E153;
	Thu, 11 Nov 2021 21:13:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDB989E1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 21:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyHIZBqzb8n0rCP/eg3lo8Qtqw6qmbTB9jEBAO5Utd8Ypx97+WuRL/LoSIq9WwtL0snK2x9XMSDgtNpiNyxTm+PKLOOJUmA1MXmtz8CqycBRxRrwQpbOW5NKxBhorTDQtCWCAOJRkkBA2yRHHl/CfK/s4VjDUo3G5SiGP/UaXxv81dhKudVb0AfYi0rdeYnNTC5mjxXMF/DIvStVp0iolxu3xJeNLoYTPCeHy9+hK/5Q8qxBdg9+qCSR0AhiTvfp7leYqpunocXw8I5gPqWxjYrIgP2cIs5iOYE9Sq8wK0rzruFa6cv6/hPyDSHsDJq7KITqWQcNuCbraRR9fMOKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9F0pr7XPSjIx92WBRabd3x5OE7pRcaGRo8idVZz9I0=;
 b=H+drwljHaoQD721q1DxKnZEYl45MLxI6Cn9nBfzjX7PkxyHqCYMUfhnbVMNyP9w4C+io9M32Y6I8g+d8WDsla+rn0PnHm2YGdJBU25w28pxbw3qrm1ZKUv79RxnHjxVDlIy7+ePp4mBXiI934uaOCKadeJ6uFFec9jxrOuRr9nIGCFku1ynwYazGevtfy++xDahbD4DSVNDBUVSSovK6O3w3rfa9uPDIGgA4XK6LiX+YlmOBVHXikNrjAP8kurD2MzVpMDizFH7rqCJz0Wo9d1Xf41WZkDJPUzNCztiUrPJa7krFrbuMgIh2cpT0rogAms8QRYpqoT+GfI39BxtnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9F0pr7XPSjIx92WBRabd3x5OE7pRcaGRo8idVZz9I0=;
 b=kFEc/m7JId6ium7S4DDMy+5FpzU3buNG3t4cXPQ1Y8gLI/R7Wshx8iUYWfFr67f0tgl6F7OzZCo7ilcRbZxxtXNcBp3wCmQlLJqmVL6/0juKwksJ+Yuj8abUUT9u+A/PLHzA54c5z1+oLJ+El5TQGAX7ciSDzdz6snkP+JAGP0Y=
Received: from DM3PR12CA0119.namprd12.prod.outlook.com (2603:10b6:0:51::15) by
 DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.17; Thu, 11 Nov 2021 21:13:23 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::11) by DM3PR12CA0119.outlook.office365.com
 (2603:10b6:0:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17 via Frontend
 Transport; Thu, 11 Nov 2021 21:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 21:13:22 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 15:13:11 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Update BO memory accounting to rely on
 allocation flag
Date: Thu, 11 Nov 2021 15:13:02 -0600
Message-ID: <20211111211303.12291-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1312e4e-ee2d-474a-1161-08d9a55817cd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4513D8706C298FC7F89D7B55E3949@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvYZwuR/O/bTPYeOaj1aB372XH7QC3B/1j0HshR/4K+VDxixM1QPPo3+qJZJtvk2TMdZUSzcSz1YuSfSai5s1Xulw6pcJD7GU/DJRCPCmhGfKeWDU+b3CY9dS+wPILL0P0N5Lzd6tQzOgj+h+/RsaQ1Q/5yJouNZYZTZ9VffY8rK9XytXlI1fB0GqWyf6sTkEfn3HnoQG+VIdLp9BlUS2NQRVxQhIApzDTIkkAS1inhZgb1aPC7Ph677zh7c5L0gQ7MF6R0KhnC0WeiXNBDfSNo1ZA3krnsL5NdXS0OwcvuBcY2ePUbgYNp/9y5ZVuXEpxn6vRtMriN9+MSh7eSx71AL5R/DRiru+nlTja1eK0JEHToIF8+xjtAyhbCI0lyGLAgkLsltv7YS2OXNloDuT5+R64WderxDbFcz3cggeIXsEeffcN9DPhjOAS+jLMkfqmRQeQ9tW9clYLnmAQ6pIu3iCt9rH9dRsCq2GG6oFqC96n+ZyZm34TQV14bwLaSBJqmmiP1/+QpJfa4IknEO9TfWDZPyiFXIMVLww5eRmeAJ8cfTDVl/tU5CC90Um2t6wwP/X/uGSUGevU57iyYkGB4ZSfub1/zyaQ/hSuudHfKOGTL7t2OSOJKP5Gd1kLjz36WEa5mwtTtWpiz+j0+Qkk2Ui243UQ1Kvc8CAc26025dx5jXOKSa3GtvkRVM8vPunJe5STX9t1rtfoHTAvFz9kixQkCUUEoMTVVietw0oDn5/qhTP7rllRF8BSu+rHjMDcVWhHqNxPy9ZtLRNX48RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(81166007)(316002)(2616005)(7696005)(426003)(356005)(83380400001)(336012)(36756003)(70586007)(508600001)(15650500001)(6666004)(70206006)(4326008)(16526019)(6916009)(5660300002)(82310400003)(47076005)(8936002)(8676002)(36860700001)(26005)(86362001)(2906002)(186003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 21:13:22.3596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1312e4e-ee2d-474a-1161-08d9a55817cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Accounting system to track amount of available memory (system, TTM
and VRAM of a device) relies on BO's domain. The change is to rely
instead on allocation flag indicating BO type - VRAM, GTT, USERPTR,
MMIO or DOORBELL

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 95 ++++++++++++-------
 2 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index d00de575c541..fcbc8a9c9e06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,12 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
+
+/**
+ * @amdgpu_amdkfd_release_notify() - Notify KFD when GEM object is released
+ *
+ * Allows KFD to release its resources associated with the GEM object.
+ */
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 94fccf0b47ad..cfc84af682b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -120,8 +120,19 @@ static size_t amdgpu_amdkfd_acc_size(uint64_t size)
 		PAGE_ALIGN(size);
 }
 
+/**
+ * @amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
+ * of buffer including any reserved for control structures
+ *
+ * @adev: Device to which allocated BO belongs to
+ * @size: Size of buffer, in bytes, encapsulated by B0. This should be
+ * equivalent to amdgpu_bo_size(BO)
+ * @alloc_flag: Flag used in allocating a BO as noted above
+ *
+ * Return: returns -ENOMEM in case of error, ZERO otherwise
+ */
 static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
-		uint64_t size, u32 domain, bool sg)
+		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
@@ -131,20 +142,24 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	acc_size = amdgpu_amdkfd_acc_size(size);
 
 	vram_needed = 0;
-	if (domain == AMDGPU_GEM_DOMAIN_GTT) {
-		/* TTM GTT memory */
+	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		system_mem_needed = acc_size + size;
 		ttm_mem_needed = acc_size + size;
-	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
-		/* Userptr */
+	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+		system_mem_needed = acc_size;
+		ttm_mem_needed = acc_size;
+		vram_needed = size;
+	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		system_mem_needed = acc_size + size;
 		ttm_mem_needed = acc_size;
-	} else {
-		/* VRAM and SG */
+	} else if (alloc_flag &
+		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
 		system_mem_needed = acc_size;
 		ttm_mem_needed = acc_size;
-		if (domain == AMDGPU_GEM_DOMAIN_VRAM)
-			vram_needed = size;
+	} else {
+		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
+		return -ENOMEM;
 	}
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
@@ -160,64 +175,72 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	    (adev->kfd.vram_used + vram_needed >
 	     adev->gmc.real_vram_size - reserved_for_pt)) {
 		ret = -ENOMEM;
-	} else {
-		kfd_mem_limit.system_mem_used += system_mem_needed;
-		kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
-		adev->kfd.vram_used += vram_needed;
+		goto release;
 	}
 
+	/* Update memory accounting by decreasing available system
+	 * memory, TTM memory and GPU memory as computed above
+	 */
+	adev->kfd.vram_used += vram_needed;
+	kfd_mem_limit.system_mem_used += system_mem_needed;
+	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
+
+release:
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 	return ret;
 }
 
 static void unreserve_mem_limit(struct amdgpu_device *adev,
-		uint64_t size, u32 domain, bool sg)
+		uint64_t size, u32 alloc_flag)
 {
 	size_t acc_size;
 
 	acc_size = amdgpu_amdkfd_acc_size(size);
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
-	if (domain == AMDGPU_GEM_DOMAIN_GTT) {
+
+	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		kfd_mem_limit.system_mem_used -= (acc_size + size);
 		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
-	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
+	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+		kfd_mem_limit.system_mem_used -= acc_size;
+		kfd_mem_limit.ttm_mem_used -= acc_size;
+		adev->kfd.vram_used -= size;
+	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= (acc_size + size);
 		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else {
+	} else if (alloc_flag &
+		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
 		kfd_mem_limit.system_mem_used -= acc_size;
 		kfd_mem_limit.ttm_mem_used -= acc_size;
-		if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
-			adev->kfd.vram_used -= size;
-			WARN_ONCE(adev->kfd.vram_used < 0,
-				  "kfd VRAM memory accounting unbalanced");
-		}
+	} else {
+		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
+		goto release;
 	}
-	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
-		  "kfd system memory accounting unbalanced");
+
+	WARN_ONCE(adev->kfd.vram_used < 0,
+		  "KFD VRAM memory accounting unbalanced");
 	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
-		  "kfd TTM memory accounting unbalanced");
+		  "KFD TTM memory accounting unbalanced");
+	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
+		  "KFD system memory accounting unbalanced");
 
+release:
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 }
 
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	u32 domain = bo->preferred_domains;
-	bool sg = (bo->preferred_domains == AMDGPU_GEM_DOMAIN_CPU);
+	u32 alloc_flags = bo->kfd_bo->alloc_flags;
+	u64 size = amdgpu_bo_size(bo);
 
-	if (bo->flags & AMDGPU_AMDKFD_CREATE_USERPTR_BO) {
-		domain = AMDGPU_GEM_DOMAIN_CPU;
-		sg = false;
-	}
-
-	unreserve_mem_limit(adev, amdgpu_bo_size(bo), domain, sg);
+	unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo->kfd_bo);
 }
 
-
 /* amdgpu_amdkfd_remove_eviction_fence - Removes eviction fence from BO's
  *  reservation object.
  *
@@ -1452,7 +1475,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	amdgpu_sync_create(&(*mem)->sync);
 
-	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, alloc_domain, !!sg);
+	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
 	if (ret) {
 		pr_debug("Insufficient memory\n");
 		goto err_reserve_limit;
@@ -1508,7 +1531,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, alloc_domain, !!sg);
+	unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	kfree(*mem);
-- 
2.31.1


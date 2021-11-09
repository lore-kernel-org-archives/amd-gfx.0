Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DAEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 06:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CB8611AF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 06:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02CB8611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EB789CD5;
	Tue,  9 Nov 2021 06:13:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10E489CD5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 06:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4OHF3luXCz4bCUidQOtxCDcPwy5M8uP4PP41DqY74Ffj55TDv4IAhijnwEnRefZuVwpqnMdxXpbj8lw4P7AFiV31o5cv8b7gnXh5RLy92kVxnnfWsCGA7EIn+cg/QwoTD3J6FL0S88KxLxpE6/mLmKbMb3rOzfkk8dSfSTjFXO/D5OphIxmUbhR3X4N6MSMdDLSngCCIMClRvY9ggNypYYQmVyiNJ7/ptwNDEuBUvp6fhcqmSIfBJZ7MZ5WGLjKgyc50dvZi1C8MiXt2AX8LWCPjZGuDpVi6vPlORY3ev1H3m/TRVRwkNgmSBzJ2Z+0JNZToGrNv80zOl6u8ohMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZvgsYEIai9+yxzja1YVNtSluwQkYUrIe/HgY+PU5SY=;
 b=bZ+Y2ygRkJTct/4t/vOl12yMOQwVoktaOB+iIMOBBNVNG4CMSLeGwIBF5Xwgm3tmL1ymalVzo0PDaXfw/9jr1PLghohZzYYuosCG78pP5ZDvJOAzUPfkbHwThRoqfc6jKHqX8SMYXIRC832jVxSNefqATAvMODsF4RNQ8C4FO8QloJ+AyblevpUrzQ68l6uAX++vJB2WUxpgIt3yTr1wC0CbXEijL1y/JlqrsiiACFSssrxOhjW/tZ+m9sDEh9/wG9RijAOJ2LkOO6x/yP46+RPP5GbO1zFXZzQ+1mHmAF39JRpg3UvSHKvY52srMWupoWITVrQnpJj+s8pPfS9gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZvgsYEIai9+yxzja1YVNtSluwQkYUrIe/HgY+PU5SY=;
 b=201SgtnGsvxz4agg+tQYrA2j7g13A9ytwruERBsMdPtSvWJ06HZM0+S4u9Ze6ubOik68iDZc83lXRSwwn5+1ASl0F43cxhBz4m3nXj1pZ+s9p77rAOUC+m+bMPNEB3URzhSBk/HOLt0Rh2RGHoRZEyVxIsW83upD26nEvUz+5Ko=
Received: from MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 06:13:14 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::6d) by MWHPR17CA0058.outlook.office365.com
 (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 9 Nov 2021 06:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 06:13:12 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 00:13:11 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Update BO memory accounting to rely on
 allocation flag
Date: Tue, 9 Nov 2021 00:13:04 -0600
Message-ID: <20211109061304.13110-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24ccbb01-2b69-4b8b-5d52-08d9a34802d4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43010EE130B83C2FDE642C60E3929@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nni8V0GxWCvjtwTGtmxPcyyg7xStV6bLLnkQ4ua4tzKSinO9ZibolUWNC4Hmo5EfEsIEiNNHYaiTSFFisRled8ZcIWLuqWhxadkp7TAkp1MqsUybT4vW5NmSxDCjMJKyWnEiP94npM3qf5XQTIP6UgiLSfwIDP2aWWJ+TthkmFdQ0V1HHgeFLCGvIspn9RBdLEaaqya1UISJqqiJlCmtTmDqlVdOVD+h6+NLXtGHG4xoHJCsT0bID6At8DGfNnSDFgtM2oiXfh8KftvHQABkffhS5rg4WYfMxwXSnMmuKfGNIRHgpkkmzMSIz8r4hUJaaL7wgLuL7Jx3seGAMx2vY+Ng8lZTcjADMunFipBLXmC50SD1Vkh7Z4ldrVrvcVkkYNlZWVDOe5SNqKjdilyRJiXoItFZoF63MS4lxMI+quXxQTMSB3zzx7X5wxOz/Jk8/BhJj9DgtctAGkOkDDZQhWsxmXEeWYiLUTVn3KGTDIAQUT7s87Q+iMq4wpPxFWP/5z4OBQP/+ZVp+ESljDo2HKN8iOh80zuxWl+tssdTzfzsp4EtFic6kYJklD0aY+UL7ocUOCk4dXHrpFJTJAQdaw9aHZm78BDvQxbHLIiShE6XOzXv4TIcg9PIFXVCmC+0Coxb8PtCJdpAbBi7lwnfG4jdrlP3MJ2kwss+nnSS4iCs6FEtJLyNU1rzX9IyoGZQmVOZVRAcvxrbqE3c1/q360/q/GhgLGecGfYOZ4QDIhl/LWaWk4V5VwhLl57DZ/2/jFCLsE9gLRNEFivZlsR61Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(5660300002)(82310400003)(1076003)(36756003)(81166007)(6916009)(356005)(83380400001)(426003)(2906002)(2616005)(26005)(86362001)(6666004)(8936002)(336012)(4326008)(70586007)(316002)(186003)(7696005)(15650500001)(8676002)(16526019)(508600001)(47076005)(70206006)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 06:13:12.8421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ccbb01-2b69-4b8b-5d52-08d9a34802d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  16 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 101 +++++++++++-------
 2 files changed, 79 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5f658823a637..8d31a742cd80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -307,7 +307,23 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
+
+/**
+ * @amdgpu_amdkfd_release_notify() - Invoked when GEM object reference count
+ * reaches ZERO. Increases available memory by size of buffer including any
+ * reserved for control structures
+ *
+ * @note: This api must be invoked on BOs that have been allocated via
+ * KFD interface amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu()
+ */
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
+
+/**
+ * @amdgpu_amdkfd_reserve_system_mem - Decrease system memory that is
+ * available by an amount specified by input parameter
+ *
+ * @size: Size of buffer in bytes
+ */
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
 static inline
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 94fccf0b47ad..08675f89bfb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -120,8 +120,22 @@ static size_t amdgpu_amdkfd_acc_size(uint64_t size)
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
+ * @note: This api must be invoked on BOs that have been allocated via
+ * KFD interface amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu()
+ *
+ * Return: returns -ENOMEM in case of error, ZERO otherwise
+ */
 static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
-		uint64_t size, u32 domain, bool sg)
+		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
@@ -131,20 +145,24 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
@@ -160,64 +178,71 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
+	/* Alert user if memory accounting is not per expectation */
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
-
-	if (bo->flags & AMDGPU_AMDKFD_CREATE_USERPTR_BO) {
-		domain = AMDGPU_GEM_DOMAIN_CPU;
-		sg = false;
-	}
-
-	unreserve_mem_limit(adev, amdgpu_bo_size(bo), domain, sg);
+	u32 alloc_flags = bo->kfd_bo->alloc_flags;
+	u64 size = amdgpu_bo_size(bo);
 
-	kfree(bo->kfd_bo);
+	unreserve_mem_limit(adev, size, alloc_flags);
 }
 
-
 /* amdgpu_amdkfd_remove_eviction_fence - Removes eviction fence from BO's
  *  reservation object.
  *
@@ -1452,7 +1477,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	amdgpu_sync_create(&(*mem)->sync);
 
-	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, alloc_domain, !!sg);
+	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
 	if (ret) {
 		pr_debug("Insufficient memory\n");
 		goto err_reserve_limit;
@@ -1508,7 +1533,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
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


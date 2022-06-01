Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CE1C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 20:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071D110EF4F;
	Wed,  1 Jun 2022 20:53:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C4E10EF4F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 20:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdoUjeZ31GXrsyjhNxRJPK4OzeqXan8OxULNn+oAfvNinpO2asq0SXKUUXCQvNVe2KtaIrJ0dJ6CU/VL8ZnWZFbbJLAJe3gz6LuCFiEPpPK6LveWinSrPCycI4/pLFYaQ7kSF0+V431KfS2xnmpqc8PbCEOl2uijljHZY8Uw/O+PR6vSkkgeUmvUh4gutDXW4uTLSvVr7CYcwqRM0PJcufr/W/nSf5/b9j837j/EZ8yvUVqFey8vnwpVieN4qCVXEtSEHbu2dRS9qPcMS/jOSNDaPYbACkmbIsdFdk/2L4doMzZkqaB85T2vriJKEAEQzAe9Euc5VbvI1W5xdnm2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaKipBvPKM7doP3w5U2GwXZX20/BxZ6lIXX5SD+Ux78=;
 b=Si4MhE2okNvqfi/LUeg6pXJ3MLVGxch+9exiaYBPNEA8X/igm7UL7oyPZHJLScShsWoMDar7UA6hC/FcCBaUCJr8f9zB01vaKAwY3OhzwgI8DIssHhLMZirSmFPzIF9gj8FmtE78S3h7oi26qOllOoeTmsyTyfemaLTzoqWh3qV5OE4zs0MpkroCUs94a4l63w+URAhnasM4juqReTWAFgVbpbeyJg0ZLQEPoKo1czZmY4e7nJ/4WY2PDQuKqRiVm+UOCHbM5nx0SJTbFZcs+c8a4ZiR2wKYnm15tAk62swtPmbceH42lQtlDLxtk8iySx86g1nhkIJTjlfArfR/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaKipBvPKM7doP3w5U2GwXZX20/BxZ6lIXX5SD+Ux78=;
 b=3fwqH5VJOCvbVq1+Evvy8cLaALay4dOF+0orvJ3ZL2EJACpDCu0KIV8I85Wsc5Wa3Jc1hGNiHF3pTT2P4omM9gWghCN5Yx4krKhR4lDossm3maBVXDyEHFESSzxcHYy6CaS1R2PrRJV/ouh61akjY8GFLESo+j1HlNHMkQIXkU0=
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by MW2PR12MB2507.namprd12.prod.outlook.com (2603:10b6:907:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 20:53:36 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::a9) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Wed, 1 Jun 2022 20:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 20:53:36 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 15:53:35 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add available memory ioctl
Date: Wed, 1 Jun 2022 16:53:19 -0400
Message-ID: <20220601205319.2174378-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77718c6a-146c-4657-d875-08da4410cc8c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2507:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2507E1C107965CD0CF34E30895DF9@MW2PR12MB2507.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLeKwmBDbGzEY4P5r9X4zugo3B266xTIWOIIW4S0AF14MdEIM+rzw0W89LsSxqCcFyvCbuVUy/bcwgFc5iU3Je9oXC3aRD9gIMlgk5KMoZAeF5WKLT1I7rL6hnRKyw2s8YLSTPuR8zAByuyVqnxZZ3qLtT2clRI3Z/9MIu5GdGBnQqzrZyWs/Pz0w44CA1VtM4g7LFt7va5hFclHVlKAD0v8b55A8PHp0ju9nf7qjQLBzzxYZDEhGrTchu1vJTqmFYbYfI2QpGUm4lbupTQvvfCJHDIedBXeXUJgVP3RbvQHK9pdnsXAwxuLaeADBB85AZ8wbgzwTYo5K6mOl4tkdzYsGVXFs5obD89x1JajcmGpSN4cm0SYjaewQnFs5yv2NmYUcgKfdOfGelI/Nu7+oLg8487OrZO34jhRy94aTUqwFkdIyat5XXOMrGyafpFzIqaiBaWICMNn8AgH4yNaVLhOX+4kWSAz0tv1ChXf/EK8nFTwlgcKRcy9+xYRuLdff9a/Bfo/o+MCu9p0ZsKMEHQUQsxJR4Jgjjuqd+i23gZ6euSb99V3sUYZPJNaIT7xArik6VdTat3OO+1S47cdAo0PfLR5xCNDcaxnli+T+JYuZffgXI6cJwEHV8rwLZOvNO77Yg6TVWeu34v4HzGVtoXOPbIJLgS0YiaRRmUFonp4ihmQwHR8xcqtRsxIV/Y6tDa2tdVAwJa4ZQOgZEwELxPyTYIMf+lLmCkBMvDLqnA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(86362001)(4326008)(356005)(8676002)(70206006)(16526019)(5660300002)(7696005)(508600001)(186003)(47076005)(426003)(336012)(83380400001)(6666004)(8936002)(36756003)(316002)(6916009)(2906002)(1076003)(2616005)(36860700001)(81166007)(40460700003)(26005)(82310400005)(54906003)(131093003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 20:53:36.6419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77718c6a-146c-4657-d875-08da4410cc8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2507
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
Cc: Daniel Phillips <Daniel.Phillips@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Phillips <Daniel.Phillips@amd.com>

Add a new KFD ioctl to return the largest possible memory size that
can be allocated as a buffer object using
kfd_ioctl_alloc_memory_of_gpu. It attempts to use exactly the same
accept/reject criteria as that function so that allocating a new
buffer object of the size returned by this new ioctl is guaranteed to
succeed, barring races with other allocating tasks.

Signed-off-by: Daniel Phillips <Daniel.Phillips@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 37 +++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 34 +++++++++++++++++
 include/uapi/linux/kfd_ioctl.h                | 14 ++++++-
 4 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..0b0ab1de76ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -266,6 +266,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
 					void *drm_priv);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		struct amdgpu_device *adev, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 34ba9e776521..105af82d41a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -38,6 +38,12 @@
  */
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
 
+/*
+ * Align VRAM allocations to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
+ * BO chunk
+ */
+#define VRAM_ALLOCATION_ALIGN (1 << 21)
+
 /* Impose limit on how much memory KFD can use */
 static struct {
 	uint64_t max_system_mem_limit;
@@ -108,7 +114,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * compromise that should work in most cases without reserving too
  * much memory for page tables unnecessarily (factor 16K, >> 14).
  */
-#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
+#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
 
 static size_t amdgpu_amdkfd_acc_size(uint64_t size)
 {
@@ -148,7 +154,12 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		system_mem_needed = acc_size;
 		ttm_mem_needed = acc_size;
-		vram_needed = size;
+
+		/*
+		 * Conservatively round up the allocation requirement to 2 MB to avoid fragmentation
+		 * caused by 4K allocations in the tail 2M BO chunk
+		 */
+		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		system_mem_needed = acc_size + size;
 		ttm_mem_needed = acc_size;
@@ -173,7 +184,9 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev->kfd.vram_used + vram_needed >
-	     adev->gmc.real_vram_size - reserved_for_pt)) {
+	     adev->gmc.real_vram_size -
+	     atomic64_read(&adev->vram_pin_size) -
+	     reserved_for_pt)) {
 		ret = -ENOMEM;
 		goto release;
 	}
@@ -205,7 +218,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		kfd_mem_limit.system_mem_used -= acc_size;
 		kfd_mem_limit.ttm_mem_used -= acc_size;
-		adev->kfd.vram_used -= size;
+		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= (acc_size + size);
 		kfd_mem_limit.ttm_mem_used -= acc_size;
@@ -1492,6 +1505,22 @@ int amdgpu_amdkfd_criu_resume(void *p)
 	return ret;
 }
 
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
+{
+	uint64_t reserved_for_pt =
+		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
+	size_t available;
+
+	spin_lock(&kfd_mem_limit.mem_limit_lock);
+	available = adev->gmc.real_vram_size
+		- adev->kfd.vram_used
+		- atomic64_read(&adev->vram_pin_size)
+		- reserved_for_pt;
+	spin_unlock(&kfd_mem_limit.mem_limit_lock);
+
+	return ALIGN_DOWN(available, VRAM_ALLOCATION_ALIGN);
+}
+
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		struct amdgpu_device *adev, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 95fa7a9718bb..625e837f0119 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -65,6 +65,25 @@ static int kfd_char_dev_major = -1;
 static struct class *kfd_class;
 struct device *kfd_device;
 
+static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
+{
+	struct kfd_process_device *pdd;
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, gpu_id);
+
+	if (pdd)
+		return pdd;
+
+	mutex_unlock(&p->mutex);
+	return NULL;
+}
+
+static inline void kfd_unlock_pdd(struct kfd_process_device *pdd)
+{
+	mutex_unlock(&pdd->process->mutex);
+}
+
 int kfd_chardev_init(void)
 {
 	int err = 0;
@@ -958,6 +977,19 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 	return false;
 }
 
+static int kfd_ioctl_get_available_memory(struct file *filep,
+					  struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_get_available_memory_args *args = data;
+	struct kfd_process_device *pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+
+	if (!pdd)
+		return -EINVAL;
+	args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev);
+	kfd_unlock_pdd(pdd);
+	return 0;
+}
+
 static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 					struct kfd_process *p, void *data)
 {
@@ -2642,6 +2674,8 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_OP,
 			kfd_ioctl_criu, KFD_IOC_FLAG_CHECKPOINT_RESTORE),
 
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
+			kfd_ioctl_get_available_memory, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index eb9ff85f8556..c648ed7c5ff1 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -34,9 +34,10 @@
  * - 1.6 - Query clear flags in SVM get_attr API
  * - 1.7 - Checkpoint Restore (CRIU) API
  * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
+ * - 1.9 - Add available memory ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 8
+#define KFD_IOCTL_MINOR_VERSION 9
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -100,6 +101,12 @@ struct kfd_ioctl_get_queue_wave_state_args {
 	__u32 pad;
 };
 
+struct kfd_ioctl_get_available_memory_args {
+	__u64 available;	/* from KFD */
+	__u32 gpu_id;		/* to KFD */
+	__u32 pad;
+};
+
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
 #define KFD_IOC_CACHE_POLICY_COHERENT 0
 #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
@@ -824,7 +831,10 @@ struct kfd_ioctl_set_xnack_mode_args {
 #define AMDKFD_IOC_CRIU_OP			\
 		AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_args)
 
+#define AMDKFD_IOC_AVAILABLE_MEMORY		\
+		AMDKFD_IOWR(0x23, struct kfd_ioctl_get_available_memory_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x23
+#define AMDKFD_COMMAND_END		0x24
 
 #endif
-- 
2.30.2


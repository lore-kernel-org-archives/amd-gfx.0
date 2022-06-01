Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06269C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 21:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E39610F0E1;
	Wed,  1 Jun 2022 21:19:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A5610FC6A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 21:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXl6q/YemItZo5Q5zjkuAfVOWxDhmLF1SMpRISdp5ym9jrIS808zHyLZTrmw7WHouUPLA3vwHH8vfRZ/L2L/tz7hj0Y86lhDyeh6B4kXChMjWlUkCFtKfRx0tfn42MKwvTgZmGoZgchGtO9F9nGUaxEFHn311K3buqwToOUnXMd3oGYUFs9gf2klIUIXXY2PdT4jOiEKIlj6p/DfdfI9y0ZSMXUuXn8clUX2Dy/YQFOzBezpD2JPESR/t6KYLFvTXEa1M4RqRjzHQ5wBxgLXDY0b3lIDU2+aPKH3OUKSTswvVffCuPOwLN0Bs3jnPMGm8Ukz4eVqbcgHa+Vxjl1MjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSJ2dEqAi9jGZMdZdbRyrOYqO1qsghqN0lZVrYbCKwA=;
 b=N9f163sgGbazC+k+bMvucAWk5/cygdpBAKHR7cSguzGhTCbjnbmyFsND3tXLV4TkH9Rw+2iLc2TiIL+aN5+7T6NFGaut72rFbm15jKIoEZ+ROVJYAd2rOanZcSwadlfs8Qj2YcjsrysOVK89UOBB6GJvfyk+mQkfI9R1txqlGqox4MyZ2L+M6BHjP+7tPvXiM3268CiJzz4JvJ9KrAdmdSWHicjn5pkqxX05O6JfbwFK/VoYPVdke8t1YqPbg4ulb/cmz+TKqEqWu4rRygDGAmklPR/FZPQ50z7j2Sku5qTpbxI0gLUKdCJ9j2I+5Ok69e9ek0giCCay/UPeENQbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSJ2dEqAi9jGZMdZdbRyrOYqO1qsghqN0lZVrYbCKwA=;
 b=eLYO3GMa/0P9dMrKXV0Fd+V4U+hsVdMNC17ppUbtukjuUihPiUIejwJjYhxWRgVes7jrwmyaq6YZPx1h/7jveQnh5pVVXGJxGJiTMYssx0Mii76PO2sbhJUcxOpNASoPXIaYnbWDLQ9DSAgF3+utiyQ1hpPsX9aSKJ3k4xgVKMQ=
Received: from DM5PR07CA0155.namprd07.prod.outlook.com (2603:10b6:3:ee::21) by
 BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 1 Jun 2022 21:19:31 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::a0) by DM5PR07CA0155.outlook.office365.com
 (2603:10b6:3:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 21:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 21:19:31 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 16:19:25 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Add available memory ioctl
Date: Wed, 1 Jun 2022 17:18:26 -0400
Message-ID: <20220601211826.2174605-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9eded43-52f4-49c6-43bb-08da44146b16
X-MS-TrafficTypeDiagnostic: BYAPR12MB3592:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3592B25D8014F59EB3E7709A95DF9@BYAPR12MB3592.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2B50+/TSoKBvz1Tq6tjTMqPLKrpS2ORbqPzs0E0UACahBuSnluNtHSqO1o6hHGlC2VDIv/UJlBGMTy5SIzDrHhzcTmmo2E6ApCIRXezJ3UMw9aUqw1IKWIK0cChCHEo3wbx/XO+YdL02jZ3Ww4xYtm/mzRbu8c0vcxj78X8fjQ4qse/yX6EMbMEvaLQ60ohgo7LdiE5tyWg3z732ZVfWP61Ok1s+4uEygIg8FHbLP/LQHOCO7Tj+BMAqHR2NrrUZW7nnTWy9hBc+5tEoOSkfpmZ4CSLY/WMr01b9ebyJK6UGnmyc9SEgmzLo2pSqrnsZv3Y1fE5yL2sKZyWCGT93pPVRFIiZw9nCR6lbCUUhsr7Uu0c6z5IM9K45riJsWvbE6JVcgiinniIGvGorJm2h9TIIWlX5eSXh/PXl8tiFd7SUbpztrzVL7m/wHQd7K2/u2VJ5fIbVl7yglv8DP0MacCHU3wi6+Y6HrPSO6BZCJDIXqB+xo1dyaXZOMVs516gloX3VqGVCDdk+JLSuIwau8NjQjPHfVUWjFEOB3uwZI3G4mJXAZRtsps/xztTW9u6301wGFIsNCv3y4jSarF0JhVttklhDz7LDgSgcr40aucHQ6qNA94kpWPGsMw5FPlGWdDTIiB3gXyUGXOxOpSiVvhlgR3I+3EjZ0dPnpaRDjqvQdfHYgH+SLnRg3EKFMGV33oNvPNiTggWFj+JaMAJtFU2T8Fe3d+kRt3auufey94Hu1X3QRtvwKIm5nUUphUoignmJJXyvpIelXAYwWImd4rqCrNsHYiRFdyBQRpw4omGKVIbrKRswTdKDgSf03Rb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(54906003)(6916009)(7696005)(26005)(2616005)(8676002)(2906002)(36860700001)(966005)(508600001)(47076005)(316002)(356005)(81166007)(86362001)(40460700003)(16526019)(186003)(8936002)(426003)(83380400001)(36756003)(70206006)(70586007)(4326008)(1076003)(336012)(5660300002)(131093003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 21:19:31.1908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9eded43-52f4-49c6-43bb-08da44146b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3592
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
Cc: alexdeucher@gmail.com, Daniel Phillips <Daniel.Phillips@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Phillips <Daniel.Phillips@amd.com>

Add a new KFD ioctl to return the largest possible memory size that
can be allocated as a buffer object using
kfd_ioctl_alloc_memory_of_gpu. It attempts to use exactly the same
accept/reject criteria as that function so that allocating a new
buffer object of the size returned by this new ioctl is guaranteed to
succeed, barring races with other allocating tasks.

This IOCTL will be used by libhsakmt:
https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg75743.html

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


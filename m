Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C7C46CD4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 10:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F12410E28A;
	Fri, 29 Dec 2023 10:03:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C036410E28A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 10:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkqvQoQ1Qv/oPzfVKSapxK68LBE7Ln8VCwQga8DaumijuSxeLV7Dw8eNmik7uLgQC69Ox/mCehZY7wYns3GVKgxewOBsyNX1f3IXRUhN7fn75V7KwoghTZUGaK1N9tz2cszmAaxrCvp2angbVF9PKVu7WrOjd+OWeiMkL2MyOEiQJo+TPS6DynjfWuFcS09RBIP+goZktHV2kxYPqpgIStnn9d7JbB9B42MMVV8jULBTLBHE9rPseQIP6D6DJYT1drUr67lhAsPODuzPFAE/1IYHAZpDY5HQgn9nuESZZjBDASArXAJKjciDeEUVT8ZhYLuxs/UVg4HeFlx14eGm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QuZB6QhxgMmVH12OAIKx4rTdQA615KZ3aSSlTi1zI0=;
 b=gcHLlHmbWtf5Ws+sEq2CC1Qr8zaOQut1oIWIOEI3mltPpHcEAjcwK5pONf3OGVyQNu+eWLN7m7yMM5Jo/nQX3ZqB87al1CCSjpBK5ZFyFsLqHbTkaGVk494jU9+hI4bc9wO2g4Wa5ZFXvnnocTJeKx9Ry4ffqdsk5vKJM3jp2nNO8VAZgRnquZzjp3+FD1afoLvHvLUjo9tWD4UIE7AfXqNZa0V76x3CKx5atsTT91mzPri4rWBYseQjDeUhpXHCfekAlk4XvnPdt3G3HiNRm9gzCUh8XpJvMCGZBmFP32UMdKYnubP68E3t0LAlalX7i4KNVD1S+KurfRWdCvezSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QuZB6QhxgMmVH12OAIKx4rTdQA615KZ3aSSlTi1zI0=;
 b=Jj+UkaaSRsoK9y0nsmYi+P3sokvPMIAY4qIULfyiEI2IeCS1BckoMNhgf6dQoNNnUYkQXWq1+Gwvvj9xE7Zcu7oxYB9FDQZJbgdEtC8oa9Uj2gcGsHCk4hE1poHGGhwU2Ocue9461AW2egpQz7v/KhS43L83BDNIsY6URbWSxIo=
Received: from MW4PR04CA0324.namprd04.prod.outlook.com (2603:10b6:303:82::29)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 10:03:07 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::b7) by MW4PR04CA0324.outlook.office365.com
 (2603:10b6:303:82::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Fri, 29 Dec 2023 10:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 29 Dec 2023 10:03:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 29 Dec 2023 04:03:04 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Prefer kernel data types u8, u16, u32,
 u64 in amdkfd/kfd_priv.h
Date: Fri, 29 Dec 2023 15:32:42 +0530
Message-ID: <20231229100242.50894-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4fd67b-3aa0-456a-4e93-08dc08555b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulhCCGH8apcre1/5GQiENGVSm3M3V5q9R8Bq3k9Ceqoae+BYqwW7VSasflVEvgStbAT1hYgtJ4uvFDRoHWTGypwK30y6cEkSY4Qfm+oIOUtfY4JB1WkV6j7pqk+Qa06zVhaP0aNR5z5hTW3FRGxjW1Y1UgMkfJNl2GNJ6TNgkMrlr7TzCkv/a5MYQcGfm/rIFjwmtEAPbxSkDzAw6UKULOj7JSGFaHpWzW3AbfQaymfvK5QchCrUxmhCZGMNb/EQbbcjOFTiJ6M1ws21eza6P7ygallL0MDF6bKYwmmSXXrOc+cL1JrwJ1K8LV2U0ZVIRSUKaIGu71D0/FI3Bl0zpmTwb0be9wvqV5ti3BCifWJ0+a7pSnSrWTrKUhws+iqffu83bZcnypwdf0cgbeEd9gRbrB03kh4OezEDiLJZeUgDflb7NJiaRlnffcRMOEp7AaFW+mZ/oyGoMXsCqV9/sv/BdV67NZZo6ndlMRuF+7ixBWjZ4nJ83xQjCpukWglENBmKFQKhwhMenzj9AdieMvryYbyEPWlwiHkpobn2KeiQfndEzMGi1of527vsn8uhPpGWJ4TSSBIJ2UXay7SyZS4JDuB9Tp5HmEf1G4JQVCwzji34+1xzriQSMQLHO+Yn9ihjWopOWvohhbYLAw0IKBCloUVnbRukb3vaS0su72gWZRyv3uorXUopAy+VvfnNm1raWfyYIbkyDvUncOSfRsLqSXJoNzOHFhxZsClpppscWS7wgc6WdDlt3+D1Y1BEBtnDiwqrdHAxcxbChrJ1sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(47076005)(36860700001)(36756003)(81166007)(41300700001)(83380400001)(356005)(40460700003)(70586007)(70206006)(8936002)(8676002)(426003)(336012)(110136005)(6636002)(2616005)(44832011)(82740400003)(30864003)(5660300002)(54906003)(4326008)(316002)(86362001)(6666004)(7696005)(26005)(66574015)(1076003)(16526019)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 10:03:07.2422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4fd67b-3aa0-456a-4e93-08dc08555b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following checks reported by checkpatch:

CHECK: Prefer kernel type 'u8' over 'uint8_t'
CHECK: Prefer kernel type 'u16' over 'uint16_t'
CHECK: Prefer kernel type 'u64' over 'uint64_t'
CHECK: Prefer kernel type 'u32' over 'uint32_t'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 368 +++++++++++++-------------
 1 file changed, 186 insertions(+), 182 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 745024b31340..d492e1315f7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -91,7 +91,7 @@
 
 /* Macro for allocating structures */
 #define kfd_alloc_struct(ptr_to_struct)	\
-	((typeof(ptr_to_struct)) kzalloc(sizeof(*ptr_to_struct), GFP_KERNEL))
+	((typeof(ptr_to_struct))kzalloc(sizeof(*ptr_to_struct), GFP_KERNEL))
 
 #define KFD_MAX_NUM_OF_PROCESSES 512
 #define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
@@ -145,13 +145,13 @@ enum kfd_ioctl_flags {
 	 */
 	KFD_IOC_FLAG_CHECKPOINT_RESTORE = BIT(0),
 };
+
 /*
  * Kernel module parameter to specify maximum number of supported queues per
  * device
  */
 extern int max_num_of_queues_per_device;
 
-
 /* Kernel module parameter to specify the scheduling policy */
 extern int sched_policy;
 
@@ -212,24 +212,24 @@ struct kfd_node;
 
 struct kfd_event_interrupt_class {
 	bool (*interrupt_isr)(struct kfd_node *dev,
-			const uint32_t *ih_ring_entry, uint32_t *patched_ihre,
+			      const u32 *ih_ring_entry, uint32_t *patched_ihre,
 			bool *patched_flag);
 	void (*interrupt_wq)(struct kfd_node *dev,
-			const uint32_t *ih_ring_entry);
+			     const u32 *ih_ring_entry);
 };
 
 struct kfd_device_info {
-	uint32_t gfx_target_version;
+	u32 gfx_target_version;
 	const struct kfd_event_interrupt_class *event_interrupt_class;
 	unsigned int max_pasid_bits;
 	unsigned int max_no_of_hqd;
 	unsigned int doorbell_size;
 	size_t ih_ring_entry_size;
-	uint8_t num_of_watch_points;
-	uint16_t mqd_size_aligned;
+	u8 num_of_watch_points;
+	u16 mqd_size_aligned;
 	bool supports_cwsr;
 	bool needs_pci_atomics;
-	uint32_t no_atomic_fw_version;
+	u32 no_atomic_fw_version;
 	unsigned int num_sdma_queues_per_engine;
 	unsigned int num_reserved_sdma_queues_per_engine;
 	DECLARE_BITMAP(reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
@@ -239,17 +239,17 @@ unsigned int kfd_get_num_sdma_engines(struct kfd_node *kdev);
 unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_node *kdev);
 
 struct kfd_mem_obj {
-	uint32_t range_start;
-	uint32_t range_end;
-	uint64_t gpu_addr;
-	uint32_t *cpu_ptr;
+	u32 range_start;
+	u32 range_end;
+	u64 gpu_addr;
+	u32 *cpu_ptr;
 	void *gtt_mem;
 };
 
 struct kfd_vmid_info {
-	uint32_t first_vmid_kfd;
-	uint32_t last_vmid_kfd;
-	uint32_t vmid_num_kfd;
+	u32 first_vmid_kfd;
+	u32 last_vmid_kfd;
+	u32 vmid_num_kfd;
 };
 
 #define MAX_KFD_NODES	8
@@ -267,7 +267,7 @@ struct kfd_node {
 					      */
 	struct kfd_vmid_info vm_info;
 	unsigned int id;                /* topology stub index */
-	uint32_t xcc_mask; /* Instance mask of XCCs present */
+	u32 xcc_mask; /* Instance mask of XCCs present */
 	struct amdgpu_xcp *xcp;
 
 	/* Interrupts */
@@ -281,7 +281,7 @@ struct kfd_node {
 	 * from the HW ring into a SW ring.
 	 */
 	bool interrupts_active;
-	uint32_t interrupt_bitmap; /* Only used for GFX 9.4.3 */
+	u32 interrupt_bitmap; /* Only used for GFX 9.4.3 */
 
 	/* QCM Device instance */
 	struct device_queue_manager *dqm;
@@ -293,7 +293,7 @@ struct kfd_node {
 	/* Clients watching SMI events */
 	struct list_head smi_clients;
 	spinlock_t smi_lock;
-	uint32_t reset_seq_num;
+	u32 reset_seq_num;
 
 	/* SRAM ECC flag */
 	atomic_t sram_ecc_flag;
@@ -326,7 +326,7 @@ struct kfd_dev {
 	struct mutex doorbell_mutex;
 
 	void *gtt_mem;
-	uint64_t gtt_start_gpu_addr;
+	u64 gtt_start_gpu_addr;
 	void *gtt_start_cpu_ptr;
 	void *gtt_sa_bitmap;
 	struct mutex gtt_sa_lock;
@@ -336,9 +336,9 @@ struct kfd_dev {
 	bool init_complete;
 
 	/* Firmware versions */
-	uint16_t mec_fw_version;
-	uint16_t mec2_fw_version;
-	uint16_t sdma_fw_version;
+	u16 mec_fw_version;
+	u16 mec2_fw_version;
+	u16 sdma_fw_version;
 
 	/* CWSR */
 	bool cwsr_enabled;
@@ -346,7 +346,7 @@ struct kfd_dev {
 	unsigned int cwsr_isa_size;
 
 	/* xGMI */
-	uint64_t hive_id;
+	u64 hive_id;
 
 	bool pci_atomic_requested;
 
@@ -362,7 +362,7 @@ struct kfd_dev {
 	unsigned int num_nodes;
 
 	/* Track per device allocated watch points */
-	uint32_t alloc_watch_ids;
+	u32 alloc_watch_ids;
 	spinlock_t watch_points_lock;
 
 	/* Kernel doorbells for KFD device */
@@ -489,38 +489,38 @@ struct queue_properties {
 	enum kfd_queue_type type;
 	enum kfd_queue_format format;
 	unsigned int queue_id;
-	uint64_t queue_address;
-	uint64_t  queue_size;
-	uint32_t priority;
-	uint32_t queue_percent;
-	uint32_t *read_ptr;
-	uint32_t *write_ptr;
+	u64 queue_address;
+	u64  queue_size;
+	u32 priority;
+	u32 queue_percent;
+	u32 *read_ptr;
+	u32 *write_ptr;
 	void __iomem *doorbell_ptr;
-	uint32_t doorbell_off;
+	u32 doorbell_off;
 	bool is_interop;
 	bool is_evicted;
 	bool is_suspended;
 	bool is_being_destroyed;
 	bool is_active;
 	bool is_gws;
-	uint32_t pm4_target_xcc;
+	u32 pm4_target_xcc;
 	bool is_dbg_wa;
 	bool is_user_cu_masked;
 	/* Not relevant for user mode queues in cp scheduling */
 	unsigned int vmid;
 	/* Relevant only for sdma queues*/
-	uint32_t sdma_engine_id;
-	uint32_t sdma_queue_id;
-	uint32_t sdma_vm_addr;
+	u32 sdma_engine_id;
+	u32 sdma_queue_id;
+	u32 sdma_vm_addr;
 	/* Relevant only for VI */
-	uint64_t eop_ring_buffer_address;
-	uint32_t eop_ring_buffer_size;
-	uint64_t ctx_save_restore_area_address;
-	uint32_t ctx_save_restore_area_size;
-	uint32_t ctl_stack_size;
-	uint64_t tba_addr;
-	uint64_t tma_addr;
-	uint64_t exception_status;
+	u64 eop_ring_buffer_address;
+	u32 eop_ring_buffer_size;
+	u64 ctx_save_restore_area_address;
+	u32 ctx_save_restore_area_size;
+	u32 ctl_stack_size;
+	u64 tba_addr;
+	u64 tma_addr;
+	u64 exception_status;
 };
 
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
@@ -537,8 +537,8 @@ enum mqd_update_flag {
 struct mqd_update_info {
 	union {
 		struct {
-			uint32_t count; /* Must be a multiple of 32 */
-			uint32_t *ptr;
+			u32 count; /* Must be a multiple of 32 */
+			u32 *ptr;
 		} cu_mask;
 	};
 	enum mqd_update_flag update_flag;
@@ -581,12 +581,12 @@ struct queue {
 	struct list_head list;
 	void *mqd;
 	struct kfd_mem_obj *mqd_mem_obj;
-	uint64_t gart_mqd_addr;
+	u64 gart_mqd_addr;
 	struct queue_properties properties;
 
-	uint32_t mec;
-	uint32_t pipe;
-	uint32_t queue;
+	u32 mec;
+	u32 pipe;
+	u32 queue;
 
 	unsigned int sdma_id;
 	unsigned int doorbell_id;
@@ -599,7 +599,7 @@ struct queue {
 	struct kobject kobj;
 
 	void *gang_ctx_bo;
-	uint64_t gang_ctx_gpu_addr;
+	u64 gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
 
 	struct amdgpu_bo *wptr_bo;
@@ -622,11 +622,11 @@ enum KFD_PIPE_PRIORITY {
 struct scheduling_resources {
 	unsigned int vmid_mask;
 	enum kfd_queue_type type;
-	uint64_t queue_mask;
-	uint64_t gws_mask;
-	uint32_t oac_mask;
-	uint32_t gds_heap_base;
-	uint32_t gds_heap_size;
+	u64 queue_mask;
+	u64 gws_mask;
+	u32 oac_mask;
+	u32 gds_heap_base;
+	u32 gds_heap_size;
 };
 
 struct process_queue_manager {
@@ -663,28 +663,28 @@ struct qcm_process_device {
 	bool mapped_gws_queue;
 
 	/* All the memory management data should be here too */
-	uint64_t gds_context_area;
+	u64 gds_context_area;
 	/* Contains page table flags such as AMDGPU_PTE_VALID since gfx9 */
-	uint64_t page_table_base;
-	uint32_t sh_mem_config;
-	uint32_t sh_mem_bases;
-	uint32_t sh_mem_ape1_base;
-	uint32_t sh_mem_ape1_limit;
-	uint32_t gds_size;
-	uint32_t num_gws;
-	uint32_t num_oac;
-	uint32_t sh_hidden_private_base;
+	u64 page_table_base;
+	u32 sh_mem_config;
+	u32 sh_mem_bases;
+	u32 sh_mem_ape1_base;
+	u32 sh_mem_ape1_limit;
+	u32 gds_size;
+	u32 num_gws;
+	u32 num_oac;
+	u32 sh_hidden_private_base;
 
 	/* CWSR memory */
 	struct kgd_mem *cwsr_mem;
 	void *cwsr_kaddr;
-	uint64_t cwsr_base;
-	uint64_t tba_addr;
-	uint64_t tma_addr;
+	u64 cwsr_base;
+	u64 tba_addr;
+	u64 tma_addr;
 
 	/* IB memory */
 	struct kgd_mem *ib_mem;
-	uint64_t ib_base;
+	u64 ib_base;
 	void *ib_kaddr;
 
 	/* doorbells for kfd process */
@@ -738,12 +738,12 @@ struct kfd_process_device {
 	struct qcm_process_device qpd;
 
 	/*Apertures*/
-	uint64_t lds_base;
-	uint64_t lds_limit;
-	uint64_t gpuvm_base;
-	uint64_t gpuvm_limit;
-	uint64_t scratch_base;
-	uint64_t scratch_limit;
+	u64 lds_base;
+	u64 lds_limit;
+	u64 gpuvm_base;
+	u64 gpuvm_limit;
+	u64 scratch_base;
+	u64 scratch_limit;
 
 	/* VM context for GPUVM allocations */
 	struct file *drm_file;
@@ -764,17 +764,17 @@ struct kfd_process_device {
 	enum kfd_pdd_bound bound;
 
 	/* VRAM usage */
-	uint64_t vram_usage;
+	u64 vram_usage;
 	struct attribute attr_vram;
 	char vram_filename[MAX_SYSFS_FILENAME_LEN];
 
 	/* SDMA activity tracking */
-	uint64_t sdma_past_activity_counter;
+	u64 sdma_past_activity_counter;
 	struct attribute attr_sdma;
 	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
 
 	/* Eviction activity tracking */
-	uint64_t last_evict_timestamp;
+	u64 last_evict_timestamp;
 	atomic64_t evict_duration_counter;
 	struct attribute attr_evict;
 
@@ -810,30 +810,30 @@ struct kfd_process_device {
 	struct attribute attr_faults;
 	struct attribute attr_page_in;
 	struct attribute attr_page_out;
-	uint64_t faults;
-	uint64_t page_in;
-	uint64_t page_out;
+	u64 faults;
+	u64 page_in;
+	u64 page_out;
 
 	/* Exception code status*/
-	uint64_t exception_status;
+	u64 exception_status;
 	void *vm_fault_exc_data;
 	size_t vm_fault_exc_data_size;
 
 	/* Tracks debug per-vmid request settings */
-	uint32_t spi_dbg_override;
-	uint32_t spi_dbg_launch_mode;
-	uint32_t watch_points[4];
-	uint32_t alloc_watch_ids;
+	u32 spi_dbg_override;
+	u32 spi_dbg_launch_mode;
+	u32 watch_points[4];
+	u32 alloc_watch_ids;
 
 	/*
 	 * If this process has been checkpointed before, then the user
 	 * application will use the original gpu_id on the
 	 * checkpointed node to refer to this device.
 	 */
-	uint32_t user_gpu_id;
+	u32 user_gpu_id;
 
 	void *proc_ctx_bo;
-	uint64_t proc_ctx_gpu_addr;
+	u64 proc_ctx_gpu_addr;
 	void *proc_ctx_cpu_ptr;
 };
 
@@ -893,7 +893,7 @@ struct kfd_process {
 	 * one for each device the process is using.
 	 */
 	struct kfd_process_device *pdds[MAX_GPU_INSTANCE];
-	uint32_t n_pdds;
+	u32 n_pdds;
 
 	struct process_queue_manager pqm;
 
@@ -954,8 +954,8 @@ struct kfd_process {
 	bool has_cwsr;
 
 	/* Exception code enable mask and status */
-	uint64_t exception_enable_mask;
-	uint64_t exception_status;
+	u64 exception_enable_mask;
+	u64 exception_status;
 
 	/* Used to drain stale interrupts */
 	wait_queue_head_t wait_irq_drain;
@@ -1005,6 +1005,7 @@ struct amdkfd_ioctl_desc {
 	unsigned int cmd_drv;
 	const char *name;
 };
+
 bool kfd_dev_is_large_bar(struct kfd_node *dev);
 
 int kfd_process_create_wq(void);
@@ -1017,11 +1018,12 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
-				uint32_t *gpuid, uint32_t *gpuidx);
+				u32 *gpuid, uint32_t *gpuidx);
 static inline int kfd_process_gpuid_from_gpuidx(struct kfd_process *p,
-				uint32_t gpuidx, uint32_t *gpuid) {
+						u32 gpuidx, uint32_t *gpuid) {
 	return gpuidx < p->n_pdds ? p->pdds[gpuidx]->dev->id : -EINVAL;
 }
+
 static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
 				struct kfd_process *p, uint32_t gpuidx) {
 	return gpuidx < p->n_pdds ? p->pdds[gpuidx] : NULL;
@@ -1041,11 +1043,11 @@ int kfd_process_get_user_gpu_id(struct kfd_process *p, uint32_t actual_gpu_id);
 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 			       struct file *drm_file);
 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
-						struct kfd_process *p);
+						      struct kfd_process *p);
 struct kfd_process_device *kfd_get_process_device_data(struct kfd_node *dev,
-							struct kfd_process *p);
+						       struct kfd_process *p);
 struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
-							struct kfd_process *p);
+							  struct kfd_process *p);
 
 bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
 
@@ -1054,11 +1056,11 @@ int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 
 /* KFD process API for creating and translating handles */
 int kfd_process_device_create_obj_handle(struct kfd_process_device *pdd,
-					void *mem);
+					 void *mem);
 void *kfd_process_device_translate_handle(struct kfd_process_device *p,
-					int handle);
+					  int handle);
 void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
-					int handle);
+					  int handle);
 struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
 
 /* PASIDs */
@@ -1076,13 +1078,13 @@ void kfd_doorbell_fini(struct kfd_dev *kfd);
 int kfd_doorbell_mmap(struct kfd_node *dev, struct kfd_process *process,
 		      struct vm_area_struct *vma);
 void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
-					unsigned int *doorbell_off);
+				      unsigned int *doorbell_off);
 void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr);
 u32 read_kernel_doorbell(u32 __iomem *db);
 void write_kernel_doorbell(void __iomem *db, u32 value);
 void write_kernel_doorbell64(void __iomem *db, u64 value);
 unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
-					struct kfd_process_device *pdd,
+					       struct kfd_process_device *pdd,
 					unsigned int doorbell_id);
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
 int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
@@ -1122,10 +1124,11 @@ static inline bool kfd_irq_is_from_node(struct kfd_node *node, uint32_t node_id,
 	return (node->interrupt_bitmap & (1 << node_id)) != 0 &&
 	       (node->compute_vmid_bitmap & (1 << vmid)) != 0;
 }
+
 static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
-					uint32_t node_id, uint32_t vmid) {
+						   u32 node_id, uint32_t vmid) {
 	struct kfd_dev *dev = adev->kfd.dev;
-	uint32_t i;
+	u32 i;
 
 	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3))
 		return dev->nodes[0];
@@ -1136,7 +1139,8 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 
 	return NULL;
 }
-int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
+
+int kfd_topology_enum_kfd_devices(u8 idx, struct kfd_node **kdev);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 
 /* Interrupts */
@@ -1149,8 +1153,8 @@ int kfd_interrupt_init(struct kfd_node *dev);
 void kfd_interrupt_exit(struct kfd_node *dev);
 bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void *ih_ring_entry);
 bool interrupt_is_wanted(struct kfd_node *dev,
-				const uint32_t *ih_ring_entry,
-				uint32_t *patched_ihre, bool *flag);
+			 const u32 *ih_ring_entry,
+				u32 *patched_ihre, bool *flag);
 int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
 void kfd_process_close_interrupt_drain(unsigned int pasid);
 
@@ -1158,7 +1162,7 @@ void kfd_process_close_interrupt_drain(unsigned int pasid);
 int kfd_init_apertures(struct kfd_process *process);
 
 void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
-				  uint64_t tba_addr,
+				  u64 tba_addr,
 				  uint64_t tma_addr);
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled);
@@ -1181,19 +1185,19 @@ int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
 #define KFD_CRIU_PRIV_VERSION 1
 
 struct kfd_criu_process_priv_data {
-	uint32_t version;
-	uint32_t xnack_mode;
+	u32 version;
+	u32 xnack_mode;
 };
 
 struct kfd_criu_device_priv_data {
 	/* For future use */
-	uint64_t reserved;
+	u64 reserved;
 };
 
 struct kfd_criu_bo_priv_data {
-	uint64_t user_addr;
-	uint32_t idr_handle;
-	uint32_t mapped_gpuids[MAX_GPU_INSTANCE];
+	u64 user_addr;
+	u32 idr_handle;
+	u32 mapped_gpuids[MAX_GPU_INSTANCE];
 };
 
 /*
@@ -1207,44 +1211,44 @@ enum kfd_criu_object_type {
 };
 
 struct kfd_criu_svm_range_priv_data {
-	uint32_t object_type;
-	uint64_t start_addr;
-	uint64_t size;
+	u32 object_type;
+	u64 start_addr;
+	u64 size;
 	/* Variable length array of attributes */
 	struct kfd_ioctl_svm_attribute attrs[];
 };
 
 struct kfd_criu_queue_priv_data {
-	uint32_t object_type;
-	uint64_t q_address;
-	uint64_t q_size;
-	uint64_t read_ptr_addr;
-	uint64_t write_ptr_addr;
-	uint64_t doorbell_off;
-	uint64_t eop_ring_buffer_address;
-	uint64_t ctx_save_restore_area_address;
-	uint32_t gpu_id;
-	uint32_t type;
-	uint32_t format;
-	uint32_t q_id;
-	uint32_t priority;
-	uint32_t q_percent;
-	uint32_t doorbell_id;
-	uint32_t gws;
-	uint32_t sdma_id;
-	uint32_t eop_ring_buffer_size;
-	uint32_t ctx_save_restore_area_size;
-	uint32_t ctl_stack_size;
-	uint32_t mqd_size;
+	u32 object_type;
+	u64 q_address;
+	u64 q_size;
+	u64 read_ptr_addr;
+	u64 write_ptr_addr;
+	u64 doorbell_off;
+	u64 eop_ring_buffer_address;
+	u64 ctx_save_restore_area_address;
+	u32 gpu_id;
+	u32 type;
+	u32 format;
+	u32 q_id;
+	u32 priority;
+	u32 q_percent;
+	u32 doorbell_id;
+	u32 gws;
+	u32 sdma_id;
+	u32 eop_ring_buffer_size;
+	u32 ctx_save_restore_area_size;
+	u32 ctl_stack_size;
+	u32 mqd_size;
 };
 
 struct kfd_criu_event_priv_data {
-	uint32_t object_type;
-	uint64_t user_handle;
-	uint32_t event_id;
-	uint32_t auto_reset;
-	uint32_t type;
-	uint32_t signaled;
+	u32 object_type;
+	u64 user_handle;
+	u32 event_id;
+	u32 auto_reset;
+	u32 type;
+	u32 signaled;
 
 	union {
 		struct kfd_hsa_memory_exception_data memory_exception_data;
@@ -1253,26 +1257,26 @@ struct kfd_criu_event_priv_data {
 };
 
 int kfd_process_get_queue_info(struct kfd_process *p,
-			       uint32_t *num_queues,
+			       u32 *num_queues,
 			       uint64_t *priv_data_sizes);
 
 int kfd_criu_checkpoint_queues(struct kfd_process *p,
-			 uint8_t __user *user_priv_data,
+			       u8 __user *user_priv_data,
 			 uint64_t *priv_data_offset);
 
 int kfd_criu_restore_queue(struct kfd_process *p,
-			   uint8_t __user *user_priv_data,
-			   uint64_t *priv_data_offset,
+			   u8 __user *user_priv_data,
+			   u64 *priv_data_offset,
 			   uint64_t max_priv_data_size);
 
 int kfd_criu_checkpoint_events(struct kfd_process *p,
-			 uint8_t __user *user_priv_data,
+			       u8 __user *user_priv_data,
 			 uint64_t *priv_data_offset);
 
 int kfd_criu_restore_event(struct file *devkfd,
 			   struct kfd_process *p,
-			   uint8_t __user *user_priv_data,
-			   uint64_t *priv_data_offset,
+			   u8 __user *user_priv_data,
+			   u64 *priv_data_offset,
 			   uint64_t max_priv_data_size);
 /* CRIU - End */
 
@@ -1283,19 +1287,19 @@ void print_queue_properties(struct queue_properties *q);
 void print_queue(struct queue *q);
 
 struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
-		struct kfd_node *dev);
+					 struct kfd_node *dev);
 struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
-		struct kfd_node *dev);
+					struct kfd_node *dev);
 struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
-		struct kfd_node *dev);
+					struct kfd_node *dev);
 struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
-		struct kfd_node *dev);
+					 struct kfd_node *dev);
 struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
-		struct kfd_node *dev);
+					 struct kfd_node *dev);
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev);
 void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
-					enum kfd_queue_type type);
+				       enum kfd_queue_type type);
 void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
 
@@ -1311,7 +1315,7 @@ void kfd_process_dequeue_from_all_devices(struct kfd_process *p);
 int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p);
 void pqm_uninit(struct process_queue_manager *pqm);
 int pqm_create_queue(struct process_queue_manager *pqm,
-			    struct kfd_node *dev,
+		     struct kfd_node *dev,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
@@ -1322,28 +1326,28 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue_properties(struct process_queue_manager *pqm, unsigned int qid,
-			struct queue_properties *p);
+				struct queue_properties *p);
 int pqm_update_mqd(struct process_queue_manager *pqm, unsigned int qid,
-			struct mqd_update_info *minfo);
+		   struct mqd_update_info *minfo);
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
-			void *gws);
+		void *gws);
 struct kernel_queue *pqm_get_kernel_queue(struct process_queue_manager *pqm,
-						unsigned int qid);
+					  unsigned int qid);
 struct queue *pqm_get_user_queue(struct process_queue_manager *pqm,
-						unsigned int qid);
+				 unsigned int qid);
 int pqm_get_wave_state(struct process_queue_manager *pqm,
 		       unsigned int qid,
 		       void __user *ctl_stack,
 		       u32 *ctl_stack_used_size,
 		       u32 *save_area_used_size);
 int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
-			   uint64_t exception_clear_mask,
+			   u64 exception_clear_mask,
 			   void __user *buf,
 			   int *num_qss_entries,
 			   uint32_t *entry_size);
 
 int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
-			      uint64_t fence_value,
+			      u64 fence_value,
 			      unsigned int timeout_ms);
 
 int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
@@ -1370,21 +1374,21 @@ struct packet_manager {
 struct packet_manager_funcs {
 	/* Support ASIC-specific packet formats for PM4 packets */
 	int (*map_process)(struct packet_manager *pm, uint32_t *buffer,
-			struct qcm_process_device *qpd);
+			   struct qcm_process_device *qpd);
 	int (*runlist)(struct packet_manager *pm, uint32_t *buffer,
-			uint64_t ib, size_t ib_size_in_dwords, bool chain);
+		       u64 ib, size_t ib_size_in_dwords, bool chain);
 	int (*set_resources)(struct packet_manager *pm, uint32_t *buffer,
-			struct scheduling_resources *res);
+			     struct scheduling_resources *res);
 	int (*map_queues)(struct packet_manager *pm, uint32_t *buffer,
-			struct queue *q, bool is_static);
+			  struct queue *q, bool is_static);
 	int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
-			enum kfd_unmap_queues_filter mode,
-			uint32_t filter_param, bool reset);
+			    enum kfd_unmap_queues_filter mode,
+			u32 filter_param, bool reset);
 	int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
-			uint32_t grace_period);
+				uint32_t grace_period);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
-			uint64_t fence_address,	uint64_t fence_value);
-	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
+			    u64 fence_address,	uint64_t fence_value);
+	int (*release_mem)(u64 gpu_addr, uint32_t *buffer);
 
 	/* Packet sizes */
 	int map_process_size;
@@ -1404,14 +1408,14 @@ extern const struct packet_manager_funcs kfd_aldebaran_pm_funcs;
 int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
 void pm_uninit(struct packet_manager *pm, bool hanging);
 int pm_send_set_resources(struct packet_manager *pm,
-				struct scheduling_resources *res);
+			  struct scheduling_resources *res);
 int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
 int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
-				uint64_t fence_value);
+			 uint64_t fence_value);
 
 int pm_send_unmap_queue(struct packet_manager *pm,
 			enum kfd_unmap_queues_filter mode,
-			uint32_t filter_param, bool reset);
+			u32 filter_param, bool reset);
 
 void pm_release_ib(struct packet_manager *pm);
 
@@ -1435,7 +1439,7 @@ int kfd_event_init_process(struct kfd_process *p);
 void kfd_event_free_process(struct kfd_process *p);
 int kfd_event_mmap(struct kfd_process *process, struct vm_area_struct *vma);
 int kfd_wait_on_events(struct kfd_process *p,
-		       uint32_t num_events, void __user *data,
+		       u32 num_events, void __user *data,
 		       bool all, uint32_t *user_timeout_ms,
 		       uint32_t *wait_result);
 void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
@@ -1446,15 +1450,15 @@ int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
 int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset);
 
 int kfd_event_create(struct file *devkfd, struct kfd_process *p,
-		     uint32_t event_type, bool auto_reset, uint32_t node_id,
-		     uint32_t *event_id, uint32_t *event_trigger_data,
-		     uint64_t *event_page_offset, uint32_t *event_slot_index);
+		     u32 event_type, bool auto_reset, uint32_t node_id,
+		     u32 *event_id, uint32_t *event_trigger_data,
+		     u64 *event_page_offset, uint32_t *event_slot_index);
 
 int kfd_get_num_events(struct kfd_process *p);
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
 
 void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
-				struct kfd_vm_fault_info *info,
+			       struct kfd_vm_fault_info *info,
 				struct kfd_hsa_memory_exception_data *data);
 
 void kfd_signal_reset_event(struct kfd_node *dev);
@@ -1478,7 +1482,7 @@ static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 }
 
 int kfd_send_exception_to_runtime(struct kfd_process *p,
-				unsigned int queue_id,
+				  unsigned int queue_id,
 				uint64_t error_reason);
 bool kfd_is_locked(void);
 
-- 
2.34.1


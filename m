Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F66C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C9910EC39;
	Wed, 29 Mar 2023 20:14:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A226410EC3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0gDKObGkg3S9Q2s2WWfJe2vHZyt4OsrTA+7kY0yraDuTVIPGiVyzUDOcyulmwanTqwULHragR9BZ4gDrHUYKZbsU/aMbahh9daBxkMAwW4B1r9a0Y7N77DYHLaWvvzBgKQD0/eHu4hZMo5IFCLn04ovBHoBljHOU2BswS9L/OIcsTlmTDjxlfoYBS4bfRrOze68Z1amDzc0DzE26lMt9PPMs2mRGg6ecOJGKqZ27T+aIjxYIiAUk8d98uIig6yIiu+0FPSy2cyzjvk5pDSZ8N690YlLxzzc4/K9wfF3aOFwK5KoTT0Yjab9pvlIbuP+4LHo2AvLItANj43b0z7uNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfnbO2WV603bszDqDx68LjpAH/ubRfn0yRIH6rFh73w=;
 b=fjvt7b74NCqVCtnNTsHiZ4spB2Q+D5poer/WbZoihU0HrLUuC/NAoIpdJdvB5xokH7qvjrkUXelERSDjsTUj8Ts87yonyDLPw+Vvc9i0Lv4Ej5p3jdD0LHKydrqCKqWffqLM//ePpGZWcRQkx9yfdbFbRASBRFAPw83CBAIjHtwersURkU8VCgVe03fXxsHU8e556gXC/YxtH9qHBfQCjbQIOtkGSB2dfPm5dBzChwi/MMMKtafPRceCxXGhGKRRxwfNaeprVNRApst54SgcMdrtiTrcgkMc2qLQ1N66m5HHCP3z+rhg5TVnCs3f3NookSiyGXmAyYqRKkGo7PEJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfnbO2WV603bszDqDx68LjpAH/ubRfn0yRIH6rFh73w=;
 b=JetfII87ZCjOiHUvpoIAdV2DgyJCmG3Z95TbWunHCgBcVhwhoxzkj2rLTpxF31HjlWSRGMrESSH9J1DEjtTmGIHF7q/UV4aUC1mL3L9Jf/5jL2HwkjqVHczEuyR2x3hpaUZjEUsY8VlYTVWDwV1rd2ucbLYlzlPh+mZxu+d3KgM=
Received: from MW2PR2101CA0036.namprd21.prod.outlook.com (2603:10b6:302:1::49)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:14:51 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::bc) by MW2PR2101CA0036.outlook.office365.com
 (2603:10b6:302:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amdkfd: Update interrupt handling for GFX9.4.3
Date: Wed, 29 Mar 2023 16:14:24 -0400
Message-ID: <20230329201426.1982669-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1453ed-9bee-4c6c-556a-08db309240e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyF/xlWyHRCiCO0idGO4Y5F2ksYIa6QjdZL2J3n4ci9SX5Ia2ezjH3XI6IovlkZjDDTBoPrj7vTCEi7t2ICKS0yhzTMiQvFK/aoVW/vZ30rge0CH/4FbzSxdeJiU6zvPNBCLJBDaMC7YaKOTWooIGh4G8zApyJsqkji15VZM7NrsRXnQQTmrwyKyPXcvZwLNOHIe17uTYR6zzXReS3cvHuE24c91jE4y3DmLscRs8wXZqlCGXKky+mpeqtGgFD6F2zG4LHCrmeiJKbYtSL/K1ZWUqOIRgVuuP5GwF/DohRxNLSg04nE8H96jxcKe9zH07VF2WdUwnSyRUZb00148N1ddNUUfYOfy7uVi5Nx8IwCLCDrXGL63RuApw2PzqCzZqG3XTmfMzX4fJRGeViPrm07Tc1BiaPOL2iip9+vEoHf7R+Gqv+Cl1hl9UpEKPThIK5IwVoTm3RYPbS2Y7+8FxL99dXuJgMFpOwY6wpz+oBxCU+TE4aa68MNFONAQyj/Co3NEJqsHXJhJqUDWKRW7DyBzwoAPJ2TyWpvyeVbxQ1rSLFYIF+B7O9LMZweKllVN5UMT9BZdpDHCUE8MWA0Z4G8a4UTTYIPmOHAq89HZtht50nyPTkcHXsrGnvVegW5B9uOtNlg2yi1DxB39uj0gfol9uajj2G0k/ft1ROtc45T8BIKCEtkG0RH2nf6K8zQL9If3V1FVBCZ7NXpEr1tdi0f7QvlM4478g9pXzDmbJ6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6916009)(40480700001)(4326008)(40460700003)(41300700001)(70206006)(36860700001)(70586007)(316002)(8676002)(478600001)(54906003)(83380400001)(15650500001)(16526019)(82740400003)(186003)(5660300002)(2616005)(82310400005)(426003)(86362001)(47076005)(36756003)(336012)(2906002)(6666004)(1076003)(26005)(8936002)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:51.3846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1453ed-9bee-4c6c-556a-08db309240e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Update interrupt handling in CPX mode for GFX9.4.3 by using the
VMID space instead of SDMA client id to determine if an interrupt
should be processed by a KFD node. This is especially needed for
handling retry faults from MMHUB.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  | 16 ++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |  2 +-
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a5064d95e7f5..e9b4b3c68b1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2431,6 +2431,9 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
  * @pasid: PASID of the VM
+ * @vmid: VMID, only used for GFX 9.4.3.
+ * @node_id: Node_id received in IH cookie. Only applicable for
+ *           GFX 9.4.3.
  * @addr: Address of the fault
  * @write_fault: true is write fault, false is read fault
  *
@@ -2438,7 +2441,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 client_id, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2463,7 +2466,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
-	if (is_compute_context && !svm_range_restore_pages(adev, pasid, client_id,
+	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
 	    node_id, addr, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 721bc55bfafa..14864a8541ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -455,7 +455,7 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			     struct amdgpu_task_info *task_info);
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 client_id, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5c209f2d38c6..d819b544b043 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -593,8 +593,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->client_id, node_id,
-					   addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid,
+					   node_id, addr, write_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index df372de6b056..fb3cf2c51da8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1073,18 +1073,14 @@ struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_node *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_node *kfd_device_by_pci_dev(const struct pci_dev *pdev);
 struct kfd_node *kfd_device_by_adev(const struct amdgpu_device *adev);
-static inline bool kfd_irq_is_from_node(struct kfd_node *node, uint32_t client_id,
-				     uint32_t node_id)
+static inline bool kfd_irq_is_from_node(struct kfd_node *node, uint32_t node_id,
+					uint32_t vmid)
 {
-	if ((node->interrupt_bitmap & (0x1U << node_id)) ||
-	    ((node_id % 4) == 0 &&
-	    (node->interrupt_bitmap >> 16) & (0x1U << client_id)))
-		return true;
-
-	return false;
+	return (node->interrupt_bitmap & (1 << node_id)) != 0 &&
+	       (node->compute_vmid_bitmap & (1 << vmid)) != 0;
 }
 static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
-					uint32_t client_id, uint32_t node_id) {
+					uint32_t node_id, uint32_t vmid) {
 	struct kfd_dev *dev = adev->kfd.dev;
 	uint32_t i;
 
@@ -1092,7 +1088,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
-		if (kfd_irq_is_from_node(dev->nodes[i], client_id, node_id))
+		if (kfd_irq_is_from_node(dev->nodes[i], node_id, vmid))
 			return dev->nodes[i];
 
 	return NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0e2b21ec468c..8bd9d88655b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2788,7 +2788,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			uint32_t client_id, uint32_t node_id,
+			uint32_t vmid, uint32_t node_id,
 			uint64_t addr, bool write_fault)
 {
 	struct mm_struct *mm = NULL;
@@ -2840,10 +2840,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	node = kfd_node_by_irq_ids(adev, node_id, client_id);
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
 	if (!node) {
-		pr_debug("kfd node does not exist node_id: %d, client_id: %d\n", node_id,
-			 client_id);
+		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
+			 vmid);
 		r = -EFAULT;
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a165c73b40b2..5116786718b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -173,7 +173,7 @@ int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 			       unsigned long addr, struct svm_range *parent,
 			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t client_id, uint32_t node_id, uint64_t addr,
+			    uint32_t vmid, uint32_t node_id, uint64_t addr,
 			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
-- 
2.39.2


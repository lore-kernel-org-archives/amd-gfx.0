Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A1AC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 19:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43621125E7;
	Tue,  7 May 2024 19:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYdyTqjs";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B71C1125ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 19:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaReoZkOMyTv2KHWTR4BLMxSbtvDkXHkNt9+CPqvc4vjdEH8XCGOuIggSK6VpQVx0ipZN3VvoeQatvFcoJ3CKGs87XbLSjR9bq4Vh782XXz/8huasTf+sKUbI+ZbIXcwukW5lS5EjCUoIX49OsMWrpJORpez0zL4vAkDul3LDVKV42URiFL9FMiN6+stGLX0PptVsnL6h+QoeitdNVFPhqA7/Hv27xg2CKpsAceS9emKQ3rPofHwGyow6VtFKn21/PN4+OrhRTa/xfPHrU6jjG1uT7JRDaXBP456+yo264FzcRqiPW4SFpjEpWF/GBSWYJ45dFyDo76eJPisISBhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg775/BaTNks5jPM/esi/6EQbRhnIBdaXwRNhh89cXA=;
 b=SqzNOBGDl41Lu9R2qh7v7x5p7zYIpe4Dz/cyueJt39hF3QuB+QfnZtSbBXwwuQeww8NpCmvGtviBqPnioiQ7wLvV/8kvhD6GDz/z8pJUuEKVrDEDMscYv4s+aFRN96kuF/fvDATlIS/fC0f/rgP/3Qd/p/jwhwYqGE/9Q3K/6SteQ6QpHvZp+B53+9o8dTP25qWtI1ZPgQILCm2wUlT7y9N6W3kpzqSdg2pM3A5BCUlvw+4ZLTk45dX06MGBu14VN6b7bi34un2VOoFP65fhVH1ISpF9DnFp4lYN/4ExxtZZUJB7pprB0/OA+QNDV2Lmz4QJxp0PXUb1FcZ+r5LhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg775/BaTNks5jPM/esi/6EQbRhnIBdaXwRNhh89cXA=;
 b=ZYdyTqjsF/nSlFubNwprgcroXraYeJEAI8qEkndLaVUL6uw5mAb/iErij4sJ1mG0fqlOrswIHpiGvLTDKGLE81uQIC9OGANVIzxhd6pt/aPqxco/RFpdNUH6hNUHMx/sZp6OZBF6vJB9pM8hS5GRFgJnrzRyYVuuawmkrrFrSmo=
Received: from DS7PR03CA0277.namprd03.prod.outlook.com (2603:10b6:5:3ad::12)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 19:45:26 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::f3) by DS7PR03CA0277.outlook.office365.com
 (2603:10b6:5:3ad::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 19:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 19:45:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:45:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Show retry fault message if process xnack on
Date: Tue, 7 May 2024 15:45:05 -0400
Message-ID: <20240507194506.21521-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc989c5-cc90-469f-68ef-08dc6ece3dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vw0eUXAooVX1tbmCAujqnzfz9HsgGk7SaZGz6ULqi4OWKfckmexbW6WWS4WF?=
 =?us-ascii?Q?o2wDoejWc8PNVaunRMeA4G3LRNwQszpRH55390OwGr2ObON1xBH91MMSKa6a?=
 =?us-ascii?Q?ax9llb1cG3cC/OycagaSO5H/ShQBLXdyDp1R6JI39wgmjI79XgrPR/S6i9KB?=
 =?us-ascii?Q?b46qGZlBE6Lf7X3HCjvbQdhtxgGZg/H1MSBL3z35DQMVLpAOXkbHvW5OLMpm?=
 =?us-ascii?Q?DZebSBTbS649jJuUzsvXr+8tJy5oLM3chxttv8MeUa0sKNprykQF24OtCyiw?=
 =?us-ascii?Q?/Rvye8+okcpUSQM2Xcvt2sNwmqcQ5K+MdihiV6TM6n4IklZ1xNJj64D/ykJl?=
 =?us-ascii?Q?lD10OPUybHWq5MomqRxvPRBLQDOl0w8Ujy/1UFIbWL/loRTeBZk7+uG7F0Ub?=
 =?us-ascii?Q?vBdZfm7HW03i7ebu2daQIxNkqLXvRf0JRQZl77KsJfhIVkIO5qvd+ASVXKmM?=
 =?us-ascii?Q?568BGxlIDfIkroCBoB+SUZIBv6DMPlWxSsVMnJ/O/Es4a1C9pDL8M7ms/Onn?=
 =?us-ascii?Q?1BVgeOdt6fmCDwfS7rvqAMGS0msUomKFgKih7lB/+A6reaF3eyCTjM6BPFgO?=
 =?us-ascii?Q?Hpnp9a0p5riawqUdU0xWmHAuQie8ZBD2FeNB7kl5vxsyK09pIBMgl5GMKqZ6?=
 =?us-ascii?Q?5IYjP25QV+jXRE9GtaW4m3MFF+k4xrd09qC9q12nXhOwWEwJF0Pw91gM93vn?=
 =?us-ascii?Q?FYPEATfvpLY52G3UOMeOUDJ9KHnAV+cjSfniWqRhNipLRi2lds+S1TSyZdSH?=
 =?us-ascii?Q?AVsjeVjA1lh+r9G3TTIll67j/xUpg2ZmUh7JWqkDQEyRjM+UPgXq+h3ye4ZC?=
 =?us-ascii?Q?K3lhBBvXI3rnlm5QJsVe03V6yR24LqXcrBIa/rJ0SnVzoPeY/y+DdrF1Ijbg?=
 =?us-ascii?Q?TBFb+8clQ09GHLZQNy9CvDQZJ6VSMsypTCEpeCLLxsTJjWwIGc+sFFwJZ186?=
 =?us-ascii?Q?QZF2x+njSrWmL2tawB8O/G6EfuGuP/p4LwNcd/XmpYnTdtCPjs5Ksj8XAIKw?=
 =?us-ascii?Q?fN5mBF9mz/mvLB9TFYYHKnMLDtlQrnmWd9dZgSV6KAaY+yXigrsMpgOVA9YN?=
 =?us-ascii?Q?im/GUUC102GvXgqeJRDk6YahORRxCZx1sJjBSnUokkhFU9u6U1mU92VAxT2l?=
 =?us-ascii?Q?bCZr0YQMz+78TGLd14M64mRB46dLlNWXRZBAtkkRVaKzKbjeR4MsNuDGxWFv?=
 =?us-ascii?Q?+mamC6MLA+G+UizTRDn6SPNGOa7xOH86tZ0yQZIJlZBkH2zRQPxqgWCPE8pK?=
 =?us-ascii?Q?RlLQJmzI+yfoVnEftzpclQ6E6IZmYHr49pOg20xjIyO8LiwtsjcnoLlWU7dP?=
 =?us-ascii?Q?drNtjYqA4//+aifi9jvv2Pt/IvDVP9awCZ6I78zdjJnnZUB6M3s4uy4oxSBi?=
 =?us-ascii?Q?zT/2xe+p+l8OUqLHSLbbksPlck3Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 19:45:26.1166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc989c5-cc90-469f-68ef-08dc6ece3dfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680
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

If vm_context_cntl set xnack on, then GPU vm fault has retry_fault bit
set, but the driver select xnack on or off path depending on per process
xnack setting which is also used to set qpd mem_config xnack on or off
if KFD_SUPPORT_XNACK_PER_PROCESS.

If process is xnack on, then GPU page fault show retry page fault
message, otherwise show no-retry page fault message, to avoid misleading
when debugging application page fault issue.

The process lookup from pasid is done inside retry fault handler
svm_range_restore_pages, add xnack_on parameter to pass process xnack
setting back to amdgpu_vm_handle_fault and then to gmc interrupt handler
to show vm fault message.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   | 2 +-
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 64ddc87f7fb6..58f7ab193027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2757,13 +2757,14 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  *           GFX 9.4.3.
  * @addr: Address of the fault
  * @write_fault: true is write fault, false is read fault
+ * @xnack_on: return value, true if the process sets xnack on
  *
  * Try to gracefully handle a VM fault. Return true if the fault was handled and
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
-			    bool write_fault)
+			    bool write_fault, bool *xnack_on)
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
@@ -2788,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, write_fault, xnack_on)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bc71b44387b2..7f364f0b9a60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -549,7 +549,7 @@ void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
-			    bool write_fault);
+			    bool write_fault, bool *xnack_on);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..2f0752376236 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault, NULL))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 671a6766df5b..3db0f2304b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -558,6 +558,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	uint32_t cam_index = 0;
 	int ret, xcc_id = 0;
 	uint32_t node_id;
+	bool xnack_on = false;
 
 	node_id = entry->node_id;
 
@@ -595,7 +596,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry->src_data[2] & 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						     addr, write_fault);
+						     addr, write_fault, &xnack_on);
 			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -618,7 +619,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						   addr, write_fault))
+						   addr, write_fault, &xnack_on))
 				return 1;
 		}
 	}
@@ -628,7 +629,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 	dev_err(adev->dev,
 		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n", hub_name,
-		retry_fault ? "retry" : "no-retry",
+		(retry_fault && xnack_on) ? "retry" : "no-retry",
 		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
 
 	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 234ea0fbfa0c..9d44a52bc4b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2887,7 +2887,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, bool write_fault, bool *xnack_on)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2923,6 +2923,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
+	if (xnack_on)
+		*xnack_on = p->xnack_enabled;
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 22f22b06a2f4..402f6fbb6452 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -182,7 +182,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr,
-			    bool write_fault);
+			    bool write_fault, bool *xnack_on);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
 			     struct svm_range *prange, struct mm_struct *mm,
-- 
2.43.2


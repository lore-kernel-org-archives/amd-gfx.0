Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F851C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D250B10EC35;
	Wed, 29 Mar 2023 20:14:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6431810EC35
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzU9uO3yWoU6s85J8/9H4GUg0fblLc+aQot5VT4Jo+8NSf2zXLX/CUwRb/iWD6464UK/FK6zZXqO/Rr4y+0a19P/6xJskwVIb4OGR0inFbdHda1qBSIwz6lrl/LN3cEBRVr1e28aina7sPUDR8zIRfy60HuWeHF9NvoTxrh4Pr3J/Eq4aWfGnRUMCAPxufmNhTtJOE8gShUXLlPjnn5sL+Gm2Ab3QETnauOle/81Y4ZKLWOJyE49fWgMYd4KQZ6sFYQNOwQwlwHXjPnOhlWvGjBG+xgDF/xvEZNgxYF46n0HOuqebBFms8ZFCM0wANNAWkbeiwlvG2cbo5P9V3Y2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaOGXswDR9n2/TuXECtA3e+u/rT2gLd+kBIQZBKzagE=;
 b=E1GW0ZQSuACgAtiJZ/ZBQ3Ge9klo1Zk/JqPQtkv6649qi/8oVgAaP0Z+6C+06PAYAtFqZPNrFqnei7NZVZsUgxtxcJT+A6BmBksKs9Me0PMdEsPz7YtQ3Fzsz2/PTBVRUvWGjo0f3Yf1aM6WNC/gnkZw5XpAmUvJ9tl1AO1G6KXIBPWYi+CoHK1dTmbTKKnSy+KJzwcaFOu+4nmJx8Nn32/t78y8MdcYQmqQgjgNSmW29ZRWEaUDrj/DCnNv8SD4YF8nK4S7K1LyjyHtvsKnmerYUcbgQ+j5m8JcwHW6n+ep9Rxsk/vCog5REDy6JaPwy3rEgJ22vCGSz8ZCjsnpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaOGXswDR9n2/TuXECtA3e+u/rT2gLd+kBIQZBKzagE=;
 b=35mGg5SIhXuCIINXuIYT4hQYBs3epqak5Opiyi7hRetGH2whUPmr5NzSnNJLHaolKMFyKacO/S20meWzNGm85FjAcYOj40HVU0Vi8GP8G/EgLVdU4Z0rtXzDBP3htN6Ga6dXGVvMPrdiOsIdPePPoM1nGQYvVLme5vG8NSN10Ho=
Received: from MW4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:303:16d::24)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Wed, 29 Mar
 2023 20:14:45 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::bd) by MW4PR02CA0017.outlook.office365.com
 (2603:10b6:303:16d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Wed, 29 Mar 2023 20:14:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amdkfd: pass kfd_node ref to svm migration api
Date: Wed, 29 Mar 2023 16:14:14 -0400
Message-ID: <20230329201426.1982669-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: fed5c1f5-5a8c-4864-502c-08db30923cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiTHSiLMdXZp/iOT3bs1l3N+q517KS2gsFG5VvfwgDalihgASFMXp64bVzMyrdiN2P6J0UjaKuJpKyxufXjb0hq5qjHhCPTMiRp6Ql5N3IaWq/MSN6d8NDFgFghsnhPWC56oMNvqOzdtfUCG+oST48IoT/BjtpXXS/QA5MfCScsdiE2fU8ayCTW7UP8ibAObVPe1TVtHLI4Sf2JLUgOJ3YtlSC8AsvOsCLmEFyfWeQhl2r5IUiJLNNOVrPbc9K386LrffQLzggIETDl3X8AIpj8sSXMpeZrT7/jaQ31HzRCRkLqI6xMgiGSBC+qQ+tXFiuKU2uBT1BUl8BvakJIZBrmH6fea0+d5Lky+v0nYtZyx25lbXIfQEvnDTVgNPjsFyeuK9SGDX9UTP33iUlTa5xnSrVtWpEQYIWjJwGyhSKgEfLzLmc/JvhEoz9zNbTBpuwsC0Pg2qhJAN5y3ukOexmNfLoZP/K/NQUR+A0fgdCHMdswgCzas6cpg3GyLcIVB+yyRxfJkw47JGAI3O/TZ0KvxeLAeN+XRwDe/hmndK1JTbeoh+OdqTCtSDBYmTdHaQLtUtAl0jaH5fJY3oYlSV4n8dpD0bvqbpW97YmqmbYbBSZeHPFgy7gbTeUldxzT/tVfPmgWjvr3Adx14IyPbAxO+tdPJEXYKyr4AYGSnmO4/ruHnRBMnzj01ySBvBi3i2ApLaAYuiSVVFCHn9vb7kkA5ct4MsNBcJYvODI5lp+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(186003)(41300700001)(8676002)(82310400005)(426003)(36756003)(6916009)(36860700001)(47076005)(70206006)(478600001)(82740400003)(7696005)(2616005)(70586007)(16526019)(316002)(83380400001)(2906002)(5660300002)(30864003)(40460700003)(6666004)(81166007)(26005)(8936002)(54906003)(336012)(86362001)(356005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:44.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed5c1f5-5a8c-4864-502c-08db30923cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
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
Cc: Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

This work is required for GC 9.4.3, previous to support memory
partitions per node at SVM. When multiple partition is configured,
every BO should be allocated inside one specific partition which
corresponds to the current amdgpu_device and kfd_node.

v2: squash in compilation fix (Alex)
v3: squash in fix for pre-gfx 9.4.3 (Alex)
v4: squash in best_loc fix (Alex)

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  30 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  45 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  30 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 152 +++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  21 ++--
 9 files changed, 164 insertions(+), 132 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 492506446a06..a5064d95e7f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2438,7 +2438,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    uint64_t addr, bool write_fault)
+			    u32 client_id, u32 node_id, uint64_t addr,
+			    bool write_fault)
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
@@ -2462,8 +2463,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
-	if (is_compute_context &&
-	    !svm_range_restore_pages(adev, pasid, addr, write_fault)) {
+	if (is_compute_context && !svm_range_restore_pages(adev, pasid, client_id,
+	    node_id, addr, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8fa88bb43fdc..721bc55bfafa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -455,7 +455,8 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			     struct amdgpu_task_info *task_info);
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    uint64_t addr, bool write_fault);
+			    u32 client_id, u32 node_id, uint64_t addr,
+			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 100da79e17d4..dadb75492332 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -139,7 +139,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index bf19f17c18e6..5c209f2d38c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -555,11 +555,24 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	const char *mmhub_cid;
 	const char *hub_name;
 	u64 addr;
-	uint32_t node_id;
+	uint32_t node_id = 0;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
+	if (entry->client_id == SOC15_IH_CLIENTID_VMC) {
+		hub_name = "mmhub0";
+		hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
+	} else if (entry->client_id == SOC15_IH_CLIENTID_VMC1) {
+		hub_name = "mmhub1";
+		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
+	} else {
+		hub_name = "gfxhub0";
+		node_id = (adev->ip_versions[GC_HWIP][0] ==
+			   IP_VERSION(9, 4, 3)) ? entry->node_id : 0;
+		hub = &adev->vmhub[node_id/2];
+	}
+
 	if (retry_fault) {
 		/* Returning 1 here also prevents sending the IV to the KFD */
 
@@ -580,25 +593,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->client_id, node_id,
+					   addr, write_fault))
 			return 1;
 	}
 
 	if (!printk_ratelimit())
 		return 0;
 
-	if (entry->client_id == SOC15_IH_CLIENTID_VMC) {
-		hub_name = "mmhub0";
-		hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
-	} else if (entry->client_id == SOC15_IH_CLIENTID_VMC1) {
-		hub_name = "mmhub1";
-		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
-	} else {
-		hub_name = "gfxhub0";
-		node_id = (adev->ip_versions[GC_HWIP][0] ==
-			   IP_VERSION(9, 4, 3)) ? entry->node_id : 0;
-		hub = &adev->vmhub[node_id/2];
-	}
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 5f4dc2a45bd0..e7e5abc32c84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -287,11 +287,12 @@ static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
 }
 
 static int
-svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
+svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate->npages;
+	uint64_t npages = migrate->cpages;
+	struct amdgpu_device *adev = node->adev;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
 	dma_addr_t *src;
@@ -321,7 +322,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
-				dev_err(adev->dev, "%s: fail %d dma_map_page\n",
+				dev_err(dev, "%s: fail %d dma_map_page\n",
 					__func__, r);
 				goto out_free_vram_pages;
 			}
@@ -390,12 +391,13 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 }
 
 static long
-svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
+svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
 			uint64_t end, uint32_t trigger, uint64_t ttm_res_offset)
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
+	struct amdgpu_device *adev = node->adev;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -445,7 +447,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages migrated\n", cpages);
 
-	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch, ttm_res_offset);
+	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
 
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
@@ -465,7 +467,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	kvfree(buf);
 out:
 	if (!r && cpages) {
-		pdd = svm_range_get_pdd_by_adev(prange, adev);
+		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
 
@@ -492,8 +494,8 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 {
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
-	struct amdgpu_device *adev;
 	uint64_t ttm_res_offset;
+	struct kfd_node *node;
 	unsigned long cpages = 0;
 	long r = 0;
 
@@ -503,9 +505,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		return 0;
 	}
 
-	adev = svm_range_get_adev_by_id(prange, best_loc);
-	if (!adev) {
-		pr_debug("failed to get device by id 0x%x\n", best_loc);
+	node = svm_range_get_node_by_id(prange, best_loc);
+	if (!node) {
+		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
 		return -ENODEV;
 	}
 
@@ -515,9 +517,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
 
-	r = svm_range_vram_node_new(adev, prange, true);
+	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
-		dev_dbg(adev->dev, "fail %ld to alloc vram\n", r);
+		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
 		return r;
 	}
 	ttm_res_offset = prange->offset << PAGE_SHIFT;
@@ -530,7 +532,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger, ttm_res_offset);
+		r = svm_migrate_vma_to_vram(node, prange, vma, addr, next, trigger, ttm_res_offset);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -663,7 +665,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  *   positive values - partial migration, number of pages not migrated
  */
 static long
-svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
+svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
 		       uint32_t trigger, struct page *fault_page)
 {
@@ -671,6 +673,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
+	struct amdgpu_device *adev = node->adev;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -745,7 +748,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	kvfree(buf);
 out:
 	if (!r && cpages) {
-		pdd = svm_range_get_pdd_by_adev(prange, adev);
+		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
 	}
@@ -766,7 +769,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			    uint32_t trigger, struct page *fault_page)
 {
-	struct amdgpu_device *adev;
+	struct kfd_node *node;
 	struct vm_area_struct *vma;
 	unsigned long addr;
 	unsigned long start;
@@ -780,13 +783,11 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		return 0;
 	}
 
-	adev = svm_range_get_adev_by_id(prange, prange->actual_loc);
-	if (!adev) {
-		pr_debug("failed to get device by id 0x%x\n",
-			 prange->actual_loc);
+	node = svm_range_get_node_by_id(prange, prange->actual_loc);
+	if (!node) {
+		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
 		return -ENODEV;
 	}
-
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
 		 prange->svms, prange, prange->start, prange->last,
 		 prange->actual_loc);
@@ -805,7 +806,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		}
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger,
+		r = svm_migrate_vma_to_ram(node, prange, vma, addr, next, trigger,
 			fault_page);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate prange %p\n", r, prange);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 400b4dcbdf05..df372de6b056 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -289,6 +289,7 @@ struct kfd_node {
 	 * from the HW ring into a SW ring.
 	 */
 	bool interrupts_active;
+	uint32_t interrupt_bitmap; /* Only used for GFX 9.4.3 */
 
 	/* QCM Device instance */
 	struct device_queue_manager *dqm;
@@ -971,9 +972,8 @@ struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
-int kfd_process_gpuid_from_adev(struct kfd_process *p,
-			       struct amdgpu_device *adev, uint32_t *gpuid,
-			       uint32_t *gpuidx);
+int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
+				uint32_t *gpuid, uint32_t *gpuidx);
 static inline int kfd_process_gpuid_from_gpuidx(struct kfd_process *p,
 				uint32_t gpuidx, uint32_t *gpuid) {
 	return gpuidx < p->n_pdds ? p->pdds[gpuidx]->dev->id : -EINVAL;
@@ -1073,6 +1073,30 @@ struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_node *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_node *kfd_device_by_pci_dev(const struct pci_dev *pdev);
 struct kfd_node *kfd_device_by_adev(const struct amdgpu_device *adev);
+static inline bool kfd_irq_is_from_node(struct kfd_node *node, uint32_t client_id,
+				     uint32_t node_id)
+{
+	if ((node->interrupt_bitmap & (0x1U << node_id)) ||
+	    ((node_id % 4) == 0 &&
+	    (node->interrupt_bitmap >> 16) & (0x1U << client_id)))
+		return true;
+
+	return false;
+}
+static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
+					uint32_t client_id, uint32_t node_id) {
+	struct kfd_dev *dev = adev->kfd.dev;
+	uint32_t i;
+
+	if (adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3))
+		return dev->nodes[0];
+
+	for (i = 0; i < dev->num_nodes; i++)
+		if (kfd_irq_is_from_node(dev->nodes[i], client_id, node_id))
+			return dev->nodes[i];
+
+	return NULL;
+}
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 75cd4eafaa44..273002466dd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1891,13 +1891,13 @@ int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id)
 }
 
 int
-kfd_process_gpuid_from_adev(struct kfd_process *p, struct amdgpu_device *adev,
-			   uint32_t *gpuid, uint32_t *gpuidx)
+kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
+			    uint32_t *gpuid, uint32_t *gpuidx)
 {
 	int i;
 
 	for (i = 0; i < p->n_pdds; i++)
-		if (p->pdds[i] && p->pdds[i]->dev->adev == adev) {
+		if (p->pdds[i] && p->pdds[i]->dev == node) {
 			*gpuid = p->pdds[i]->user_gpu_id;
 			*gpuidx = i;
 			return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8023be9a9cc1..b3c10d8fbe0b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -169,8 +169,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
 		if (is_zone_device_page(page)) {
-			struct amdgpu_device *bo_adev =
-					amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
+			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
 				   bo_adev->vm_manager.vram_base_offset -
@@ -423,10 +422,8 @@ static void svm_range_bo_unref(struct svm_range_bo *svm_bo)
 }
 
 static bool
-svm_range_validate_svm_bo(struct amdgpu_device *adev, struct svm_range *prange)
+svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 {
-	struct amdgpu_device *bo_adev;
-
 	mutex_lock(&prange->lock);
 	if (!prange->svm_bo) {
 		mutex_unlock(&prange->lock);
@@ -439,12 +436,11 @@ svm_range_validate_svm_bo(struct amdgpu_device *adev, struct svm_range *prange)
 	}
 	if (svm_bo_ref_unless_zero(prange->svm_bo)) {
 		/*
-		 * Migrate from GPU to GPU, remove range from source bo_adev
-		 * svm_bo range list, and return false to allocate svm_bo from
-		 * destination adev.
+		 * Migrate from GPU to GPU, remove range from source svm_bo->node
+		 * range list, and return false to allocate svm_bo from destination
+		 * node.
 		 */
-		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
-		if (bo_adev != adev) {
+		if (prange->svm_bo->node != node) {
 			mutex_unlock(&prange->lock);
 
 			spin_lock(&prange->svm_bo->list_lock);
@@ -512,7 +508,7 @@ static struct svm_range_bo *svm_range_bo_new(void)
 }
 
 int
-svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
+svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			bool clear)
 {
 	struct amdgpu_bo_param bp;
@@ -527,7 +523,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 	pr_debug("pasid: %x svms 0x%p [0x%lx 0x%lx]\n", p->pasid, prange->svms,
 		 prange->start, prange->last);
 
-	if (svm_range_validate_svm_bo(adev, prange))
+	if (svm_range_validate_svm_bo(node, prange))
 		return 0;
 
 	svm_bo = svm_range_bo_new();
@@ -541,6 +537,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 		kfree(svm_bo);
 		return -ESRCH;
 	}
+	svm_bo->node = node;
 	svm_bo->eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 					   mm,
@@ -558,7 +555,10 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 	bp.type = ttm_bo_type_device;
 	bp.resv = NULL;
 
-	r = amdgpu_bo_create_user(adev, &bp, &ubo);
+	/* TODO: Allocate memory from the right memory partition. We can sort
+	 * out the details later, once basic memory partitioning is working
+	 */
+	r = amdgpu_bo_create_user(node->adev, &bp, &ubo);
 	if (r) {
 		pr_debug("failed %d to create bo\n", r);
 		goto create_bo_failed;
@@ -616,45 +616,30 @@ void svm_range_vram_node_free(struct svm_range *prange)
 	prange->ttm_res = NULL;
 }
 
-struct amdgpu_device *
-svm_range_get_adev_by_id(struct svm_range *prange, uint32_t gpu_id)
+struct kfd_node *
+svm_range_get_node_by_id(struct svm_range *prange, uint32_t gpu_id)
 {
-	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int32_t gpu_idx;
+	struct kfd_process_device *pdd;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
-
-	gpu_idx = kfd_process_gpuidx_from_gpuid(p, gpu_id);
-	if (gpu_idx < 0) {
-		pr_debug("failed to get device by id 0x%x\n", gpu_id);
-		return NULL;
-	}
-	pdd = kfd_process_device_from_gpuidx(p, gpu_idx);
+	pdd = kfd_process_device_data_by_id(p, gpu_id);
 	if (!pdd) {
-		pr_debug("failed to get device by idx 0x%x\n", gpu_idx);
+		pr_debug("failed to get kfd process device by id 0x%x\n", gpu_id);
 		return NULL;
 	}
 
-	return pdd->dev->adev;
+	return pdd->dev;
 }
 
 struct kfd_process_device *
-svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
+svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node)
 {
 	struct kfd_process *p;
-	int32_t gpu_idx, gpuid;
-	int r;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 
-	r = kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpu_idx);
-	if (r) {
-		pr_debug("failed to get device id by adev %p\n", adev);
-		return NULL;
-	}
-
-	return kfd_process_device_from_gpuidx(p, gpu_idx);
+	return kfd_get_process_device_data(node, p);
 }
 
 static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
@@ -1145,12 +1130,18 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 	}
 	return 0;
 }
+static bool
+svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
+{
+	return (node_a->adev == node_b->adev ||
+		amdgpu_xgmi_same_hive(node_a->adev, node_b->adev));
+}
 
 static uint64_t
-svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
-			int domain)
+svm_range_get_pte_flags(struct kfd_node *node,
+			struct svm_range *prange, int domain)
 {
-	struct amdgpu_device *bo_adev;
+	struct kfd_node *bo_node;
 	uint32_t flags = prange->flags;
 	uint32_t mapping_flags = 0;
 	uint64_t pte_flags;
@@ -1159,18 +1150,18 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 	bool uncached = flags & KFD_IOCTL_SVM_FLAG_UNCACHED;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
-		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
+		bo_node = prange->svm_bo->node;
 
-	switch (KFD_GC_VERSION(adev->kfd.dev)) {
+	switch (node->adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 1):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			if (bo_adev == adev) {
+			if (bo_node == node) {
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 			} else {
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-				if (amdgpu_xgmi_same_hive(adev, bo_adev))
+				if (svm_nodes_in_same_hive(node, bo_node))
 					snoop = true;
 			}
 		} else {
@@ -1180,15 +1171,15 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 		break;
 	case IP_VERSION(9, 4, 2):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			if (bo_adev == adev) {
+			if (bo_node == node) {
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
-				if (adev->gmc.xgmi.connected_to_cpu)
+				if (node->adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-				if (amdgpu_xgmi_same_hive(adev, bo_adev))
+				if (svm_nodes_in_same_hive(node, bo_node))
 					snoop = true;
 			}
 		} else {
@@ -1204,7 +1195,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 		if (uncached)
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		/* local HBM region close to partition*/
-		else if (bo_adev == adev)
+		else if (bo_node == node)
 			mapping_flags |= AMDGPU_VM_MTYPE_RW;
 		/* local HBM region far from partition or remote XGMI GPU or
 		 * system memory
@@ -1228,7 +1219,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 
-	pte_flags |= amdgpu_gem_va_map_flags(adev, mapping_flags);
+	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
 	return pte_flags;
 }
 
@@ -1335,7 +1326,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
 			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
 
-		pte_flags = svm_range_get_pte_flags(adev, prange, last_domain);
+		pte_flags = svm_range_get_pte_flags(pdd->dev, prange, last_domain);
 		if (readonly)
 			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
 
@@ -1344,6 +1335,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
+		/* TODO: we still need to determine the vm_manager.vram_base_offset based on
+		 * the memory partition.
+		 */
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
 					   last_start, prange->start + i,
 					   pte_flags,
@@ -1381,16 +1375,14 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		      unsigned long *bitmap, bool wait, bool flush_tlb)
 {
 	struct kfd_process_device *pdd;
-	struct amdgpu_device *bo_adev;
+	struct amdgpu_device *bo_adev = NULL;
 	struct kfd_process *p;
 	struct dma_fence *fence = NULL;
 	uint32_t gpuidx;
 	int r = 0;
 
 	if (prange->svm_bo && prange->ttm_res)
-		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
-	else
-		bo_adev = NULL;
+		bo_adev = prange->svm_bo->node->adev;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
@@ -2515,17 +2507,17 @@ svm_range_from_addr(struct svm_range_list *svms, unsigned long addr,
  */
 static int32_t
 svm_range_best_restore_location(struct svm_range *prange,
-				struct amdgpu_device *adev,
+				struct kfd_node *node,
 				int32_t *gpuidx)
 {
-	struct amdgpu_device *bo_adev, *preferred_adev;
+	struct kfd_node *bo_node, *preferred_node;
 	struct kfd_process *p;
 	uint32_t gpuid;
 	int r;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 
-	r = kfd_process_gpuid_from_adev(p, adev, &gpuid, gpuidx);
+	r = kfd_process_gpuid_from_node(p, node, &gpuid, gpuidx);
 	if (r < 0) {
 		pr_debug("failed to get gpuid from kgd\n");
 		return -1;
@@ -2535,9 +2527,8 @@ svm_range_best_restore_location(struct svm_range *prange,
 	    prange->preferred_loc == KFD_IOCTL_SVM_LOCATION_SYSMEM) {
 		return prange->preferred_loc;
 	} else if (prange->preferred_loc != KFD_IOCTL_SVM_LOCATION_UNDEFINED) {
-		preferred_adev = svm_range_get_adev_by_id(prange,
-							prange->preferred_loc);
-		if (amdgpu_xgmi_same_hive(adev, preferred_adev))
+		preferred_node = svm_range_get_node_by_id(prange, prange->preferred_loc);
+		if (preferred_node && svm_nodes_in_same_hive(node, preferred_node))
 			return prange->preferred_loc;
 		/* fall through */
 	}
@@ -2549,8 +2540,8 @@ svm_range_best_restore_location(struct svm_range *prange,
 		if (!prange->actual_loc)
 			return 0;
 
-		bo_adev = svm_range_get_adev_by_id(prange, prange->actual_loc);
-		if (amdgpu_xgmi_same_hive(adev, bo_adev))
+		bo_node = svm_range_get_node_by_id(prange, prange->actual_loc);
+		if (bo_node && svm_nodes_in_same_hive(node, bo_node))
 			return prange->actual_loc;
 		else
 			return 0;
@@ -2667,7 +2658,7 @@ svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
 }
 
 static struct
-svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
+svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
 						struct kfd_process *p,
 						struct mm_struct *mm,
 						int64_t addr)
@@ -2702,7 +2693,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
 		return NULL;
 	}
-	if (kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx)) {
+	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
 		pr_debug("failed to get gpuid from kgd\n");
 		svm_range_free(prange, true);
 		return NULL;
@@ -2756,7 +2747,7 @@ static bool svm_range_skip_recover(struct svm_range *prange)
 }
 
 static void
-svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
+svm_range_count_fault(struct kfd_node *node, struct kfd_process *p,
 		      int32_t gpuidx)
 {
 	struct kfd_process_device *pdd;
@@ -2769,7 +2760,7 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 		uint32_t gpuid;
 		int r;
 
-		r = kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx);
+		r = kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx);
 		if (r < 0)
 			return;
 	}
@@ -2797,6 +2788,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
+			uint32_t client_id, uint32_t node_id,
 			uint64_t addr, bool write_fault)
 {
 	struct mm_struct *mm = NULL;
@@ -2804,6 +2796,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range *prange;
 	struct kfd_process *p;
 	ktime_t timestamp = ktime_get_boottime();
+	struct kfd_node *node;
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
@@ -2847,6 +2840,13 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
+	node = kfd_node_by_irq_ids(adev, node_id, client_id);
+	if (!node) {
+		pr_debug("kfd node does not exist node_id: %d, client_id: %d\n", node_id,
+			 client_id);
+		r = -EFAULT;
+		goto out;
+	}
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
@@ -2865,7 +2865,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			write_locked = true;
 			goto retry_write_locked;
 		}
-		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+		prange = svm_range_create_unregistered_range(node, p, mm, addr);
 		if (!prange) {
 			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
@@ -2880,7 +2880,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_lock(&prange->migrate_mutex);
 
 	if (svm_range_skip_recover(prange)) {
-		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
+		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
 		r = 0;
 		goto out_unlock_range;
 	}
@@ -2911,7 +2911,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_range;
 	}
 
-	best_loc = svm_range_best_restore_location(prange, adev, &gpuidx);
+	best_loc = svm_range_best_restore_location(prange, node, &gpuidx);
 	if (best_loc == -1) {
 		pr_debug("svms %p failed get best restore loc [0x%lx 0x%lx]\n",
 			 svms, prange->start, prange->last);
@@ -2970,7 +2970,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(adev, p, gpuidx);
+	svm_range_count_fault(node, p, gpuidx);
 
 	mmput(mm);
 out:
@@ -2978,7 +2978,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug("recover vm fault later\n");
-		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
+		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
 		r = 0;
 	}
 	return r;
@@ -3220,7 +3220,7 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
 	uint32_t best_loc = prange->prefetch_loc;
 	struct kfd_process_device *pdd;
-	struct amdgpu_device *bo_adev;
+	struct kfd_node *bo_node;
 	struct kfd_process *p;
 	uint32_t gpuidx;
 
@@ -3229,9 +3229,9 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
 		goto out;
 
-	bo_adev = svm_range_get_adev_by_id(prange, best_loc);
-	if (!bo_adev) {
-		WARN_ONCE(1, "failed to get device by id 0x%x\n", best_loc);
+	bo_node = svm_range_get_node_by_id(prange, best_loc);
+	if (!bo_node) {
+		WARN_ONCE(1, "failed to get valid kfd node at id%x\n", best_loc);
 		best_loc = 0;
 		goto out;
 	}
@@ -3249,10 +3249,10 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 			continue;
 		}
 
-		if (pdd->dev->adev == bo_adev)
+		if (pdd->dev->adev == bo_node->adev)
 			continue;
 
-		if (!amdgpu_xgmi_same_hive(pdd->dev->adev, bo_adev)) {
+		if (!svm_nodes_in_same_hive(pdd->dev, bo_node)) {
 			best_loc = 0;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 7a33b93f9df6..a165c73b40b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -48,6 +48,7 @@ struct svm_range_bo {
 	struct work_struct		eviction_work;
 	uint32_t			evicting;
 	struct work_struct		release_work;
+	struct kfd_node			*node;
 };
 
 enum svm_work_list_ops {
@@ -163,16 +164,17 @@ int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
 struct svm_range *svm_range_from_addr(struct svm_range_list *svms,
 				      unsigned long addr,
 				      struct svm_range **parent);
-struct amdgpu_device *svm_range_get_adev_by_id(struct svm_range *prange,
-					       uint32_t id);
-int svm_range_vram_node_new(struct amdgpu_device *adev,
-			    struct svm_range *prange, bool clear);
+struct kfd_node *svm_range_get_node_by_id(struct svm_range *prange,
+					  uint32_t gpu_id);
+int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
+			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 			       unsigned long addr, struct svm_range *parent,
 			       struct svm_range *prange);
-int svm_range_restore_pages(struct amdgpu_device *adev,
-			    unsigned int pasid, uint64_t addr, bool write_fault);
+int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
+			    uint32_t client_id, uint32_t node_id, uint64_t addr,
+			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
 			     struct svm_range *prange, struct mm_struct *mm,
@@ -192,7 +194,7 @@ int kfd_criu_restore_svm(struct kfd_process *p,
 			 uint64_t max_priv_data_size);
 int kfd_criu_resume_svm(struct kfd_process *p);
 struct kfd_process_device *
-svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
+svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
 void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
 
 /* SVM API and HMM page migration work together, device memory type
@@ -219,8 +221,9 @@ static inline void svm_range_list_fini(struct kfd_process *p)
 }
 
 static inline int svm_range_restore_pages(struct amdgpu_device *adev,
-					  unsigned int pasid, uint64_t addr,
-					  bool write_fault)
+					  unsigned int pasid,
+					  uint32_t client_id, uint32_t node_id,
+					  uint64_t addr, bool write_fault)
 {
 	return -EFAULT;
 }
-- 
2.39.2


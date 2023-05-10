Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFE5C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EEEB10E545;
	Wed, 10 May 2023 21:24:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4551610E538
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzazlZWWzX0wlQpFuT9QjCf4LfrMsFjMhfLCNXHjBJQYZkyMB75EkMaDaMHDNSlIR+P+dUUVGQxsFWJPPYlg1Ff7wpeTscLAt4vQKh2VwYL+XvGJYTvJq3RdudkHi+ob3GhjskdYnas/mkz0Q+Vxw9hRE+0xkBQB6fDsDucGBV9FytxScnfGmbfn5Cd9OWaR4U8s8XOnJVcRiexZYsdAfU0ac+wH26GtNa0yCkBGSz9z5UjNAKmpBmOSKGm56QLka2vsmmXMq75ErNzHlblVgZyhl6SK8mFQflOGD3jMm9LgnHM58K+HwtCfmDX5yC0Ml53HiDdiL/DdzuZcDSzZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuJFeaYe2WCBISLockswa5BeGLMbrDsJx2fOoQUGnD4=;
 b=do6yT0qHpkXslVV6+8eAejauMxTcwDuycU4KMdQXPCxgkUcNgheDVbNfLhOMXGcV1i1ZJvnHMomFop9VeI9HqQi3B1LKCXbpdgCh3zyIYAx2qNmttKAxkmF7JmAnitFmiWAmajaFZ7Ri1mnUWVrON+k6Z3lh4mzJrFajws5MdXEZclokVq/qQydqo0gKHcHOICNZ7gEljNLplXzhyKgexwc4MA2KPkB8qH/D02OTsWBUEtsGYWfXmt6vB2zRWHKI4Z6JV97EiwDhPfoSjckUna+llGPoVfcl0dXV+dx8aBNnuuLaQseomlEFIs8jaf1mPhiYDmvukfUq6VQ0fEVSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuJFeaYe2WCBISLockswa5BeGLMbrDsJx2fOoQUGnD4=;
 b=nImvONXlHaaDtlPn6oLphWqkAjP60VaZmhVJdZTp1orNSVQOzTkgQgZ3YrFdagNPG1oIKiHn1oQCC5jChOPO8lckfIw5YnAnc89iAxFIQWXsS1doxNGmCzGyb/xlXUkRE1P6QMGlihsr7fN06tQT5aYNhjGYIeLcp14ysp4HzNI=
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:24:00 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::68) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/29] drm/amdkfd: Update MTYPE for far memory partition
Date: Wed, 10 May 2023 17:23:22 -0400
Message-ID: <20230510212333.2071373-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: f020e7ca-e6dc-422d-4f31-08db519cdec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IpY6IWC8WEqFMXRMT5yHdPexk7nRBlV1voeqtUFSCgkNOF6UVyfRLITD2FyXjJkYEbVoDce14OZeyjz9xRe2vS1xlzUf/7C2HVs0m6X8L91qoV/ggwlfzZk71tMpfMRoIVMkoeXxHE5n06q8L6Lj6tM8PWN6RLIfweLELKq/BzmWFFw/YJQZL2IYvIhS6rT4wl6VnqQLHOgp3QhJQEcY7+NgpMGqdx/QY8Wlqu62syu4ZA1IVcSAGOIhot1QHIaE6nN82D6b+5Ci7G50sSbggGDnu5ULctYXmrZinNSlNLEx1z0jRLcNWYMemadHKKsgEeNsuvuEbrH7tby6NXgHKesY+52vd08w3dC6y3Pv9nQOp/1zbjLCoLH5RGlmWYnRgs0GAkTNKZ+u6xgAzfXFmUycyWiXA10KdxQPOHdBuGEQ14sqlOm1gWlJNJoaQD43Srnehtyo+JFlbiedQlTZ6tn2cuCSyni76UlH4Bk0Lcpfq4SX46/UbqHvypKkByRVM8KX2wrNSmkESGzULYyfm4Fc9j7DTTMxgwQGnMUCg20kExg8m/yvEfeJI+p8RnvrwV1qSaTL8DSNugg9sQyY/2ReUMDgEthGnJij71cHTSgLerJ/EBmsGECES0TZPlqXrWtJJ1hlsbElXcVgyRjrnGb+/Xd2bhCK/hLHEOSvP4fTSITaDw7ijORFCcQdH3UFpTttzHVv1x4cotUuYK0X7tginlSb1X4l5p7ppvbkLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(36860700001)(186003)(16526019)(40480700001)(2616005)(47076005)(426003)(336012)(316002)(6666004)(41300700001)(70206006)(70586007)(4326008)(8936002)(8676002)(6916009)(7696005)(36756003)(54906003)(82310400005)(86362001)(478600001)(5660300002)(40460700003)(2906002)(83380400001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:59.5379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f020e7ca-e6dc-422d-4f31-08db519cdec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Use MTYPE RW/MTYPE_CC for mapping system memory or VRAM to KFD node
within the same memory partition, use MTYPE_NC for mapping on KFD node
from the far memory partition of the same socket or from another socket
on same XGMI hive.

On NPS4 or 4P system, MTYPE will be overridden per page depending on
the memory NUMA node id and vm->mem_id.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 15 +++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  |  9 +++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7dfe6a8ca91a..ee5d4d67b423 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1191,7 +1191,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
 	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
-	/* TODO: memory partitions struct amdgpu_vm *vm = mapping->bo_va->base.vm;*/
+	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
 	bool snoop = false;
 	bool is_local;
@@ -1252,8 +1252,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		}
 		is_local = (!is_vram && (adev->flags & AMD_IS_APU) &&
 			    num_possible_nodes() <= 1) ||
-			   (is_vram && adev == bo_adev /* TODO: memory partitions &&
-			    bo->mem_id == vm->mem_id*/);
+			   (is_vram && adev == bo_adev &&
+			    bo->mem_id == vm->mem_id);
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
@@ -1340,13 +1340,12 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* TODO: memory partitions. mem_id is hard-coded to 0 for now.
-	 * FIXME: Only supported on native mode for now. For carve-out, the
+	/* FIXME: Only supported on native mode for now. For carve-out, the
 	 * NUMA affinity of the GPU/VM needs to come from the PCI info because
 	 * memory partitions are not associated with different NUMA nodes.
 	 */
-	if (adev->gmc.is_app_apu) {
-		local_node = adev->gmc.mem_partitions[/*vm->mem_id*/0].numa.node;
+	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
+		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
 	} else {
 		dev_dbg(adev->dev, "Only native mode APU is supported.\n");
 		return;
@@ -1361,7 +1360,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	}
 	nid = pfn_to_nid(addr >> PAGE_SHIFT);
 	dev_dbg(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
-		/*vm->mem_id*/0, local_node, nid);
+		vm->mem_id, local_node, nid);
 	if (nid == local_node) {
 		uint64_t old_flags = *flags;
 		unsigned int mtype_local = MTYPE_RW;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f6a886d9e902..8b5453fd304a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1202,8 +1202,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			/* local HBM region close to partition */
-			if (bo_node->adev == node->adev /* TODO: memory partitions &&
-			    bo_node->mem_id == node->mem_id*/)
+			if (bo_node->adev == node->adev &&
+			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
 				mapping_flags |= mtype_local;
 			/* local HBM region far from partition or remote XGMI GPU */
 			else if (svm_nodes_in_same_hive(bo_node, node))
@@ -1357,8 +1357,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		/* TODO: we still need to determine the vm_manager.vram_base_offset based on
-		 * the memory partition.
+		/* For dGPU mode, we use same vm_manager to allocate VRAM for
+		 * different memory partition based on fpfn/lpfn, we should use
+		 * same vm_manager.vram_base_offset regardless memory partition.
 		 */
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
 					   last_start, prange->start + i,
-- 
2.40.1


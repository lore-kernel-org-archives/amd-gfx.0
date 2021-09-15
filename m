Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D66C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 06:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA9C61157
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 06:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADA9C61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CD389FBC;
	Wed, 15 Sep 2021 06:38:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234A589FBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 06:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmsNWEXuWMtlH3fohdRwzK67uE/2cd3RChWH2w3mZicEZc0VXX8i2Ctw/EvnMkkhP1LcMy0v+t3tECfPNvcF45bfMIbklc7tUCQKe5ajUAoLovUyqfCRtrfF0GMxXUY9j3J0Dq+RirpF8Uu1oo74eGLs88hcPeGBtz3uOMRHqmVzUKkveyeyvHMFpKSt2zCvHDBTkaXgzwXHTe06wskxOGIqCYG1yoAj7MVOMIwsND0swANxucuyRB27/cJ+p/B44+c/uutsXjg3fFxn8bkOnndUvfKnb4HYiwCV1g02iCkisYxTHNdz+E/+CSf06mifrRHrwYjgo+iW8pr0B4eIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0Q/3GlRL9jkeH2lUSZ5n1TR7F+M7OZhR+WKzy0k5o7Q=;
 b=a2wCEkVa5PmSiA/cqGZO3phH6bM2EzlQzs5+rAcBoGCvQNDT0RJb+NUNzUvynZYWiuIayu9CtokrD3gB8MalbZAk8H6jQ6XPlUmbYJFN2yy6m2ZVpJZ0wFg8dfMoNJyV6trx6+NkCKwgsPWV3us1Uzadi0GdWAvfSrLrNxGh+SCJ6friIVy5EMeNuRSQ6J7fodi1ZqWcAgweFxlck90DX9qovmBXP9qtq0cJm7iPNHY8Ges+lBActoHWlHb2TX5jI7axofkZmSrLiqWa2b4wPgc9kS26LUQTPGe31HQ2A9JbMBVZLGsgW1rYVQY0j+8fSaA+9X3QEybiAy4icelccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q/3GlRL9jkeH2lUSZ5n1TR7F+M7OZhR+WKzy0k5o7Q=;
 b=a2oVKSKiaM+fVbdkY3Owqk+7/9HuI0Wz3ij+5KoLxwQoCTcoawynDAt8QXSwv/9O1an71yWOVj7/yswWPBPMJ5nfUfH1wJiSMN6D39TcvYPuLdjZJ4S+6GO+pvNiRCbETJugOB3o/0+vKeH5OJB/N8u1L6OPggo1B6Jopi5fMQo=
Received: from DS7PR03CA0254.namprd03.prod.outlook.com (2603:10b6:5:3b3::19)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 15 Sep
 2021 06:37:58 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::9a) by DS7PR03CA0254.outlook.office365.com
 (2603:10b6:5:3b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Wed, 15 Sep 2021 06:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 06:37:57 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 15 Sep
 2021 01:37:54 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <andrey.grodzovsky@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH v2] drm/amdgpu: Put drm_dev_enter/exit outside hot codepath
Date: Wed, 15 Sep 2021 14:37:39 +0800
Message-ID: <20210915063739.31244-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2add4c-0549-4769-59d9-08d978135ad7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44332EBDFE17B581D5D5A61D87DB9@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDL4dzQ+ieEMjyfhTybNzNF9idxBLsgCDGK0+pt3x6QavLeXprUoSIVhBYxXbG661LHk+4lfwTBSRq7J8NM3wFWvU++7Fta4P3sfqQeLgdcgBpCdnZpyV3SYpjSvjsH1Dtc0A+JQGHQGmC+nv28TVTDYEJmPo0tdt8zXiHNcpTCYHYFT5STFW0ojkqsjw1Q2JjInsbqzCJV4mmTYj++6YrRV+RWbk1Ztz4pa1HDMF/63j5z09AJkUO82C4h1GEkNq5ijHNKCbMWTYfxWv1MP2lAuY3SfhvVupSxaoYzASV39oh+TcarmgsQCubhYZUuMXmP+pOduTJLAmW6KSH33CMWpbLzieDnEnOwNPNg8KEy1JOheoPBpasi1gkId2hX+GUHcds0NIGrJmsaJPonQjFqCMTPtC5nW4+J13lK2VlRtXVCOTvS5zX5A08p83Tv0sMtfIhhq+Fu2WcgnJUIxaohEXSX4HWggIXEnxvrex9qf/Ach2RNsR58HUJRVQ9PuplgpChLW4ab1A3sUbBpCczvKOxnWaLPu5x917+zTu5INAeH8vc4s4BTl8H1KsHqAJSOPN7oYGGmFB0sM1tjZjKu+wPPjS1Wg+cNr6YKR6ldTaIg1bCayH3TZKxupQy84r60PygM26o4PuqE+9u0EG7RoLa6r/vlVAQJruRSqrn1T+gL2q8+0QlhjYypOG9efuhopm5TSDOyLnnXu5K2kZuIpVIEhKFB+17674yKWOqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(47076005)(36756003)(508600001)(5660300002)(1076003)(426003)(356005)(2616005)(81166007)(36860700001)(6666004)(16526019)(6916009)(26005)(2906002)(186003)(70586007)(86362001)(70206006)(54906003)(7696005)(336012)(82310400003)(8676002)(4326008)(8936002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 06:37:57.2551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2add4c-0549-4769-59d9-08d978135ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

We hit soft hang while doing memory pressure test on one numa system.
After a qucik look, this is because kfd invalid/valid userptr memory
frequently with process_info lock hold.
Looks like update page table mapping use too much cpu time.

perf top says below,
75.81%  [kernel]       [k] __srcu_read_unlock
 6.19%  [amdgpu]       [k] amdgpu_gmc_set_pte_pde
 3.56%  [kernel]       [k] __srcu_read_lock
 2.20%  [amdgpu]       [k] amdgpu_vm_cpu_update
 2.20%  [kernel]       [k] __sg_page_iter_dma_next
 2.15%  [drm]          [k] drm_dev_enter
 1.70%  [drm]          [k] drm_prime_sg_to_dma_addr_array
 1.18%  [kernel]       [k] __sg_alloc_table_from_pages
 1.09%  [drm]          [k] drm_dev_exit

So move drm_dev_enter/exit outside gmc code, instead let caller do it.
They are gart_unbind, gart_map, vm_clear_bo, vm_update_pdes and
gmc_init_pdb0. vm_bo_update_mapping already calls it.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
change from v1:
add enter/exit in more gmc_set_pte_pde callers
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 11 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28 +++++++++++++++++-------
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 76efd5f8950f..d7e4f4660acf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -34,6 +34,7 @@
 #include <asm/set_memory.h>
 #endif
 #include "amdgpu.h"
+#include <drm/drm_drv.h>
 
 /*
  * GART
@@ -230,12 +231,16 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	u64 page_base;
 	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
 	uint64_t flags = 0;
+	int idx;
 
 	if (!adev->gart.ready) {
 		WARN(1, "trying to unbind memory from uninitialized GART !\n");
 		return -EINVAL;
 	}
 
+	if (!drm_dev_enter(&adev->ddev, &idx))
+		return 0;
+
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
 	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 	for (i = 0; i < pages; i++, p++) {
@@ -254,6 +259,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	for (i = 0; i < adev->num_vmhubs; i++)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 
+	drm_dev_exit(idx);
 	return 0;
 }
 
@@ -276,12 +282,16 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 {
 	uint64_t page_base;
 	unsigned i, j, t;
+	int idx;
 
 	if (!adev->gart.ready) {
 		WARN(1, "trying to bind memory to uninitialized GART !\n");
 		return -EINVAL;
 	}
 
+	if (!drm_dev_enter(&adev->ddev, &idx))
+		return 0;
+
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
 
 	for (i = 0; i < pages; i++) {
@@ -291,6 +301,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
+	drm_dev_exit(idx);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 54f059501a33..1427fd70310c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -153,10 +153,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 {
 	void __iomem *ptr = (void *)cpu_pt_addr;
 	uint64_t value;
-	int idx;
-
-	if (!drm_dev_enter(&adev->ddev, &idx))
-		return 0;
 
 	/*
 	 * The following is for PTE only. GART does not have PDEs.
@@ -165,8 +161,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 	value |= flags;
 	writeq(value, ptr + (gpu_page_idx * 8));
 
-	drm_dev_exit(idx);
-
 	return 0;
 }
 
@@ -752,6 +746,10 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	u64 vram_end = vram_addr + vram_size;
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
+	int idx;
+
+	if (!drm_dev_enter(&adev->ddev, &idx))
+		return;
 
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
@@ -773,6 +771,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
+	drm_dev_exit(idx);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0126ece898da..daa16d2f89da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -800,7 +800,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo = &vmbo->bo;
 	unsigned entries, ats_entries;
 	uint64_t addr;
-	int r;
+	int r, idx;
 
 	/* Figure out our place in the hierarchy */
 	if (ancestor->parent) {
@@ -845,9 +845,12 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			return r;
 	}
 
+	if (!drm_dev_enter(&adev->ddev, &idx))
+		return -ENODEV;
+
 	r = vm->update_funcs->map_table(vmbo);
 	if (r)
-		return r;
+		goto exit;
 
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
@@ -856,7 +859,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
 	if (r)
-		return r;
+		goto exit;
 
 	addr = 0;
 	if (ats_entries) {
@@ -872,7 +875,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 		r = vm->update_funcs->update(&params, vmbo, addr, 0, ats_entries,
 					     value, flags);
 		if (r)
-			return r;
+			goto exit;
 
 		addr += ats_entries * 8;
 	}
@@ -895,10 +898,13 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 		r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
 					     value, flags);
 		if (r)
-			return r;
+			goto exit;
 	}
 
-	return vm->update_funcs->commit(&params, NULL);
+	r = vm->update_funcs->commit(&params, NULL);
+exit:
+	drm_dev_exit(idx);
+	return r;
 }
 
 /**
@@ -1384,11 +1390,14 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate)
 {
 	struct amdgpu_vm_update_params params;
-	int r;
+	int r, idx;
 
 	if (list_empty(&vm->relocated))
 		return 0;
 
+	if (!drm_dev_enter(&adev->ddev, &idx))
+		return -ENODEV;
+
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
@@ -1396,7 +1405,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
 	if (r)
-		return r;
+		goto exit;
 
 	while (!list_empty(&vm->relocated)) {
 		struct amdgpu_vm_bo_base *entry;
@@ -1414,10 +1423,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	r = vm->update_funcs->commit(&params, &vm->last_update);
 	if (r)
 		goto error;
+	drm_dev_exit(idx);
 	return 0;
 
 error:
 	amdgpu_vm_invalidate_pds(adev, vm);
+exit:
+	drm_dev_exit(idx);
 	return r;
 }
 
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAAECD37AD
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 22:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2FD10E69F;
	Fri, 15 Sep 2023 22:13:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2552E10E69F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 22:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ/SNjgqZ+LQC2RHcKlqQ1mtCVw4XD2o1kw5RIW+zfn0n3p1XdxW6BRTYj1jkwzEWAFF8irXuIpzesxu5jyX0+4qkgBaVzWFYGAurREQMsY3OYDzr7JYJcXkulSd/Z2MF3V6xOneLgqkTHRRsY8xm6/3BAxxYVvxMmhnsRC1mW+lDVh+GZRf+1bqC+ILFYlL9KKLBsxMXSYz/RDjltVkbK24XWnAxvNAuiN+khW3x8Vf4lk8bYa+Gnlc6xS2XcXgWqaQeyZSxeZXqXtkYpwHZbFrm07PQB4za6zcXhPBBGPv/zFu4a47VAeF9+zHDERQF3ThLviKoOrVjoDBL8YmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEmkMpZlMi1VwoiF/RuNT5yeMZaAL/dyuI1rbM8SLTg=;
 b=NAUBl0NBeaSIuOlcRqXzXYQ3uK88nKttwA/SWznfRFB1C7N7I44qPOctxUAe+eAKvnyV4x8qAh9wIUP+7WbXyJ02LsX0SoXFPbqWDIREEMB1nPh9gYIZPk6qjOPXCs8wwEnkbHZI2QRQZnP0AtZZuoN6QRtMXiai2v/PtmUrF5X26k6WNN4xq4HYEVTuYatnOa9Kkke+T8amrM+gvar6McrUMDb1b467ATAULNiN7K53dYsxH9lbLZ0aRLoHemKsoMlM5hVCMjR3MdXzH1Mu4QENvdSOA+7OQ8xx5sWrLV1RYDCqs59D31YqJDTni3JXn/ooe8qzsdzIUwnbOcAdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEmkMpZlMi1VwoiF/RuNT5yeMZaAL/dyuI1rbM8SLTg=;
 b=A4tVHi/2ZrT/Eg7O4BsjKlRzKMyuzmQ31wUSAHY7aI66O8aqQ2NnWSodhzFlNWZBMzdzSkdW7VCjrIY8STAas4R4ok8cbMyikejILOtpHkfFf1ColNa0GYvls4O7fttSeSDGjlMM1s7SG/5c0sGzkA1oSUbGHSD5Yk4cvsJEFSY=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.42; Fri, 15 Sep
 2023 22:13:45 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::f0) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Fri, 15 Sep 2023 22:13:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:13:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:13:44 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 15 Sep 2023 17:13:38 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Seperate dma unmap and free of dma address array
 operations
Date: Fri, 15 Sep 2023 17:13:53 -0500
Message-ID: <20230915221353.21242-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 174bc2ba-d70b-46c5-7ccc-08dbb639071e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hUTpO6mbN8pPP7kz4Kr772KJRALYraVUB8xU/Tx6TPFin4Do4j3fCDWGwj+jaWCoyBxJT3Kvms/ASiv7P12e8eV9VWLnfu/ESUFaMtfiMby3R52/EIwPFLuEPafTaYy0A6DXxwT2ks+Icy8R+xCN0ryJw+i2imuUf6KHS+h4ajN6JBcwmGgJgjwHBY8AsrGJpUQQVyCnGoYq42OkrSyYhxI3P36cYKCNiepRVeicit/OpRLlzFMnKChOY7q0DE6BU/K1XoJL3bkWgYJtS6jw0gnst5EzjfCEJEuWEW9RD2C+Qg4z9Tn+isfLjYOi/6Y8nnpITmkeOnJcD8t4Lv9Kxi1p2ncB41XKUZ9yKzGfuZ4KQTAf6h3Xb2oqoOduarbhZhIIkE287Xm4KdGdU2TwfGg+pjuWI/vjHFvWktQ7RcNR6BXaS3ZGoVwf+caTLh4X8DPjX+u+PYVCKoO3aIAOb+4X7+81tZfxPF3FlNKcxapSJXbGee2ND7em/vAoqQRBg427oq13gyokIPNG42qVR0wT5ij6hyAiWnp6XrbxSFxlK1uH7p7hTS57M0tpkU8NXduh050bDwWv4NV9QPaKY7sYu0KeZAyXwmIxbmWLY32GNJaDYcTWGnMz0IbP56AGrMFF5mr6Xfus2P46tIQS2BYuYhQiBaWFzPySeL3klF+Z/ucWEvz+M2Cx3k9FrddTDj2pK9jVNNtm/Wus8E8XoEOYCC5g39P6kWY8XIjJveNEdaJF7jlTx3m2r/7385vFu/Pi7yXCZV9JsN34UDEoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(4326008)(8676002)(8936002)(5660300002)(316002)(6916009)(41300700001)(54906003)(70206006)(70586007)(40460700003)(82740400003)(356005)(47076005)(81166007)(36860700001)(83380400001)(40480700001)(1076003)(86362001)(426003)(2616005)(26005)(336012)(2906002)(36756003)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:13:45.0324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174bc2ba-d70b-46c5-7ccc-08dbb639071e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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
Cc: "Xiaogang
 . Chen" <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

We do not need free dma address array of svm_range each time we do dma unmap
for pages in svm_range as we can reuse the same array. Only free it when free
svm_range. Seperate these two operations and use them accordinly.

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 23 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  4 ++--
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 192b0d106413..6c25dab051d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -460,7 +460,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    0, node->id, trigger);
 
-	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
+	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
@@ -544,7 +544,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	if (cpages) {
 		prange->actual_loc = best_loc;
-		svm_range_free_dma_mappings(prange, true);
+		svm_range_dma_unmap(prange);
 	} else {
 		svm_range_vram_node_free(prange);
 	}
@@ -745,7 +745,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    node->id, 0, trigger);
 
-	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
+	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5d7ba7dbf6ce..bed0f8bf83c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -229,7 +229,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 	return r;
 }
 
-void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
+void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
@@ -247,7 +247,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 	}
 }
 
-void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
+void svm_range_dma_unmap(struct svm_range *prange)
 {
 	struct kfd_process_device *pdd;
 	dma_addr_t *dma_addr;
@@ -268,10 +268,8 @@ void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
 			continue;
 		}
 		dev = &pdd->dev->adev->pdev->dev;
-		if (unmap_dma)
-			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
-		kvfree(dma_addr);
-		prange->dma_addr[gpuidx] = NULL;
+
+		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
 	}
 }
 
@@ -279,18 +277,29 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 {
 	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	uint32_t gpuidx;
 
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
 		 prange->start, prange->last);
 
 	svm_range_vram_node_free(prange);
-	svm_range_free_dma_mappings(prange, do_unmap);
+	if (do_unmap)
+		svm_range_dma_unmap(prange);
 
 	if (do_unmap && !p->xnack_enabled) {
 		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 	}
+
+	/* free dma_addr array for each gpu */
+	for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
+		if (prange->dma_addr[gpuidx]) {
+			kvfree(prange->dma_addr[gpuidx]);
+				prange->dma_addr[gpuidx] = NULL;
+		}
+	}
+
 	mutex_destroy(&prange->lock);
 	mutex_destroy(&prange->migrate_mutex);
 	kfree(prange);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 9e668eeefb32..78bfb83cd0c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -181,9 +181,9 @@ void svm_range_add_list_work(struct svm_range_list *svms,
 			     struct svm_range *prange, struct mm_struct *mm,
 			     enum svm_work_list_ops op);
 void schedule_deferred_list_work(struct svm_range_list *svms);
-void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
+void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
-void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma);
+void svm_range_dma_unmap(struct svm_range *prange);
 int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
 		       uint64_t *svm_priv_data_size);
 int kfd_criu_checkpoint_svm(struct kfd_process *p,
-- 
2.25.1


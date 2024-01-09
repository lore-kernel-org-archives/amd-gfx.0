Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07131C4706C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 20:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ECD410E493;
	Tue,  9 Jan 2024 20:06:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2A710E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 20:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAVFgGJuALmCjhWN/hkgJGhe5NJAgkZ6jhmsu2B6ZMTxjIcx2uRZKeGgFd7R4qOT67TmvpnmGT5ftIgTL7yVZC4DNrSZn6AxoDfRQJZlOwrZcDWNQJi0oMeUvAOMrCXmTLpcFpOdl9dVeJ+6/q+cgUGvu5V5fQ+LCEOoQiT/LJQEDXQ7TE/JFSuoGe6rtIwjcdOlumMU6JaYn4/HQMdGmwsVMU/rqilwt8uHYz0oxtUr4Wp3M0eYU3JMqILWjrSCo8FERQBfIVetWPE6cEfkCPjy6ijf1bMLevwJOfBGbtoBtbiJ4DLM7G2GafDP/DsmDFWsIZcTWBTSH0/kLHQ0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsUIle17Is8iN2tMNP65Gp9abjxMNZdAfoz0yWkmuwI=;
 b=hhGnAUMUl5xFIeacisZChTFgSavVMV1xfoH1zFuwg3UNby6EuPb04ju6n8qfeA+v/JVEahFIVt7YvZN5keL7ziSRhUN0mpKhXD3GVqJcPaL9puQW3yxA1ugpddU5+jKSDxe1WrUDu9oNex0DpesLHXyZJ3UdsBxdyvWJxjdKOQIUYxHOcuR3SpLV3vU0XJeG6mht3gyXVzJ8VBylsKMxzXASpzQoa7JJOg3M1t7MhFxfEAQPydbCNq1AW9PLbouRRlyH931XFk3DX4GyUi62+20QufT8cMqdCCzPjA+yEnh0W2pw0t9CfXRiw2yMKZqKJ7n26MKW6lU8uBAUhX0kaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsUIle17Is8iN2tMNP65Gp9abjxMNZdAfoz0yWkmuwI=;
 b=OLaK9RNRaAQmbVQ4z4h7DNHVyQ6KRbuWlbgT+hlyeu0yODqjCrLyw+bgcNqfBYmGFcllQgHtp6+UZVtVvb0dgBunbEz+RyU9+Lcw4BufvQ+XFej+QQdj40kOmqtwA3KZNX8GEIYmT4KgDFWTphaNxyV0prgBDZ0/OLQbzAbzPH4=
Received: from CY5PR19CA0058.namprd19.prod.outlook.com (2603:10b6:930:1a::14)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 20:05:57 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::c9) by CY5PR19CA0058.outlook.office365.com
 (2603:10b6:930:1a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25 via Frontend
 Transport; Tue, 9 Jan 2024 20:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 20:05:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 14:05:56 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] amd/amdkfd: Set correct svm range actual loc after spliting
Date: Tue, 9 Jan 2024 15:05:27 -0500
Message-ID: <20240109200527.24039-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 23796f10-1446-4a9e-4f0c-08dc114e647f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtdsPznAMn6F5vZe97n6gEfZsiiW9HA0bbG0HFDTIKn4nLnGFm5IFH8Z2D30mgOnugYDRcRG/RuK5+kO/y6g/28xc5zaX3rOmS40ic7Fkf6RXCbmteR+0LzuXG4bLvU7EfGBT8XezAWGT9eTfUEJWDgTyz1IAx3hvFrgFXnEl7sEWS74wvi5+g8KoSNmgHZ1TfDkkOanwutUUyx9mh/FBgaSaHYqlKbQkBstOLU8tGezxuELcU9vTGcJD4k6TsbkUcgV43ExHT7MezoU8ehCeafBd3LZIxaaJzCRyR6vJFrBTDYH7zH+IeJUbkHdDKJ41kXm7S47MLmOfBjgPBpz1fovgQBAroUi77M5TJpg63O/pdzhwnY4u5NlqDqqBPw87mcs82PDD9pZxMwpe9U5sK6j/rhdcewLjs8jgbwG2ee5jJ1t9hiYubLE+uYeRLKr+QCFQm5kSPdlzOFaKSDjgSDFKwJVz4vPZsb23flWHh1EK9TrvB6vxUSaPR5XCT12rltbnPhVYAV4pktjV95asBt8mAcxWvyrrqFJs9Sx3M4pKVWtHO3K4YWMsQwuqge0hCnrIGrIBQneZQmOEQfHsshZQawEOAekce8wm1UxVMsPNxWIwsqQhzjmeIqNiIl6FSz8ahCO7KoN02+8uZeORDtxib6ct9JiOH4ee3Q/jGEpda6PVvrBPIiL3UBswP4xoM0qqTFnxfh8gwlwlOc81hsZ06iM++nFiA1ZioFsvrk6pa+apZfEOsj+2wA1EtmlHQTfOr5HgJ0uoHOCziw5pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(1076003)(336012)(478600001)(426003)(26005)(6666004)(7696005)(47076005)(36860700001)(83380400001)(41300700001)(5660300002)(8936002)(4326008)(6916009)(54906003)(8676002)(16526019)(316002)(86362001)(70206006)(70586007)(2906002)(356005)(82740400003)(81166007)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 20:05:56.9391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23796f10-1446-4a9e-4f0c-08dc114e647f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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
Cc: Xiaogang.Chen@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After svm range partial migrating to system memory, unmap to cleanup the
corresponding dma_addr vram domain flag, otherwise the future split will
get incorrect vram_pages and actual loc.

After range spliting, set new range and old range actual_loc:
new range actual_loc is 0 if new->vram_pages is 0.
old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.

new range takes svm_bo ref only if vram_pages not equal to 0.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 35 +++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +-
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f856901055d3..e85bcda29db6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -839,6 +839,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			prange->actual_loc = 0;
 			svm_range_vram_node_free(prange);
 		}
+
+		svm_range_dma_unmap(prange, start_mgr - prange->start,
+				    last_mgr - start_mgr + 1);
 	}
 
 	return r < 0 ? r : 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cc24f30f88fb..2202bdcde057 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -254,6 +254,10 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 		return;
 
 	for (i = offset; i < offset + npages; i++) {
+		if (dma_addr[i] & SVM_RANGE_VRAM_DOMAIN) {
+			dma_addr[i] = 0;
+			continue;
+		}
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
@@ -262,7 +266,8 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 	}
 }
 
-void svm_range_dma_unmap(struct svm_range *prange)
+void svm_range_dma_unmap(struct svm_range *prange, unsigned long offset,
+			 unsigned long npages)
 {
 	struct kfd_process_device *pdd;
 	dma_addr_t *dma_addr;
@@ -284,7 +289,7 @@ void svm_range_dma_unmap(struct svm_range *prange)
 		}
 		dev = &pdd->dev->adev->pdev->dev;
 
-		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
+		svm_range_dma_unmap_dev(dev, dma_addr, offset, npages);
 	}
 }
 
@@ -299,7 +304,7 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 
 	svm_range_vram_node_free(prange);
 	if (do_unmap)
-		svm_range_dma_unmap(prange);
+		svm_range_dma_unmap(prange, 0, prange->npages);
 
 	if (do_unmap && !p->xnack_enabled) {
 		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
@@ -362,7 +367,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
 	prange->validate_timestamp = 0;
-	prange->vram_pages = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -980,9 +984,14 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old->actual_loc)
+	if (old->actual_loc && new->vram_pages) {
 		old->vram_pages -= new->vram_pages;
-
+		new->actual_loc = old->actual_loc;
+		if (!old->vram_pages)
+			old->actual_loc = 0;
+	}
+	pr_debug("new->vram_pages 0x%llx loc 0x%x old->vram_pages 0x%llx loc 0x%x\n",
+		 new->vram_pages, new->actual_loc, old->vram_pages, old->actual_loc);
 	return 0;
 }
 
@@ -1002,13 +1011,14 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 		new->offset = old->offset + npages;
 	}
 
-	new->svm_bo = svm_range_bo_ref(old->svm_bo);
-	new->ttm_res = old->ttm_res;
-
-	spin_lock(&new->svm_bo->list_lock);
-	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
-	spin_unlock(&new->svm_bo->list_lock);
+	if (new->vram_pages) {
+		new->svm_bo = svm_range_bo_ref(old->svm_bo);
+		new->ttm_res = old->ttm_res;
 
+		spin_lock(&new->svm_bo->list_lock);
+		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
+		spin_unlock(&new->svm_bo->list_lock);
+	}
 	return 0;
 }
 
@@ -1058,7 +1068,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
-	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
 	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 026863a0abcd..778f108911cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -182,7 +182,8 @@ void svm_range_add_list_work(struct svm_range_list *svms,
 void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
-void svm_range_dma_unmap(struct svm_range *prange);
+void svm_range_dma_unmap(struct svm_range *prange, unsigned long offset,
+			 unsigned long npages);
 int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
 		       uint64_t *svm_priv_data_size);
 int kfd_criu_checkpoint_svm(struct kfd_process *p,
-- 
2.35.1


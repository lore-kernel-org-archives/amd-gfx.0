Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160AFCD8C99
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AD010E38B;
	Tue, 10 Oct 2023 14:41:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC3610E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBOPD2th+zdC5tqT2efIP6tiUF1us1dr8tYmN4/OK62j9TN1XbYOpziwZMM+Z4uuof9kmOyuABnak6i0juExTOhvGnfRIubSAu7LmGjaijqVwKtKhm+LJQX1GwxyYvafkAZywVKegGX2gnZrFqCzoDDHi8X+JYCbmVRNkL2KwAx2ErJ4xvO8O8Y70y7ybNF0wVSiq1ALQuyProZE1FyrQ6A8MgdBR6sO/qTd6HoiZC96KUKpiC5U5apbuI62NcLvO+fxkWix1QD9le0wQCK82uKMuNNVgEm+6LVjpBq2yHmrdTBl1DCNwUbR5w3RmXB/suzXnzB61QOxQL36EINbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz4FCZsgF+jVBAO9dmuABQ9xRfiwaUjBKHiXsbuH4LI=;
 b=eTQ+tKpWwPQwWsDqvS6vhCg6Mi0yIhZLC9vsMpqEXYWhzCZuabXiMdEOIJaZSTbvv0BqARd3nbQWJ5OmCEvVJFzcU9lEqBzh0wLPXhbDZg7Mq7058Njnn3sroKZoAklEcihUeBVbWjZuCeTuR7Ld2FFd7+r+iEHXnpam6Bki4t4oQJroBM/eqKoh6og/93wAp4iigO3GfqxhrLoLR7evtEX+GEnsCC37Mp1bO+4tu7C4LzC5rQBbSWmSqPDPVkL7lh8xLxGlzAHUm4HzdOotTFkHi50XA9ku86eh+CvFYndi8Rnty2K6VRUU03nF7MG10KozNRIUS6IspTeqGRSlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz4FCZsgF+jVBAO9dmuABQ9xRfiwaUjBKHiXsbuH4LI=;
 b=0tOodJvoMzl0fuMtlEe86cftOg9k6DgrdFU3Jxd0nMbpzQFPSjt070cL8rkDNJ+UIu1je+hr6FaIs/ZJzsWp4L/90fNREKOzl8WYWv6aihb4XObcpK7wkAzaKqZo1rc+QTYxE6Ke8K9Qfeh68JT2vV5tVuLEZbzq+Ns/yimWoVQ=
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:41:49 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::fd) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 14:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:41:49 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:41:47 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/7] amd/amdkfd: Add granularity bitmap mapped to gpu flag
Date: Tue, 10 Oct 2023 10:40:20 -0400
Message-ID: <20231010144024.3016-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
References: <20231010144024.3016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 478610ad-52da-4702-f110-08dbc99f0917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhTvpY7OQKjSBF9LY2eY8t72NxarG+YduAnWociBEZdRtNiKq5wppyyK2DzCBh+IGTScNCCnM3DhHNDMwxGSysJu8JXuNOnoWZk6qB3O4RlU1gOQPqpfeYiEvyD7eq6UxkWk4uHIt+g8bHQTQxGoGLF1sP5JrTAaBn68RMYO75UkT8vOTcwH/dV526vYmf6ZkkUJveLNuQ5cf1pHM8Nza7Fzi+GGcmcvI+a20/1Vi9KJFUIbcpsD0IkvxPlE65+F7rzQ9b1Gw7qnRv7kwBRVg5cKSsP852slT6jcUlfU8bxPhhrxMyZevU7DVmRWhdp45yQMTYL+xEGCXwFM37ohLHmLr2JLa0AaHr1Jwv+lsE5P645xeg1evk4pAOGh4uWoKV5Q0r9fCr7Q2NeevN5BmgAk50eZxsHoorgPP76BFoclYQqlRPOhLMEYIl8HgbvKCrm8XvROeVanaFXz8LEpRo9615Xduy7dKvDyv3ZigE1B42Po2WKBWtLrVOXoMFPUMTNLeG1x+BAI3isAUSsTAPHCSFLrpe6x9YwDr9Jw9aJlE7r2brIGh+SyYikXGzVuw7J59FMxbcTslz9AJSoxgSqeapQ44uAq4kpxoFjfboy1lvav4rBv1qgOgbpXy33YIuwkSxL0G//TGJMhTn/yaJxTc0sMIiEt6RdkEFUBXUvuKmFa5kDAKii4u3fNuuEF90+zeAIkRsFdSQEcbK2cES08OULDtYKsTqdszkD5JqlisVk319touJ5Fhc1bU9vyZYJebpFR4pxKLwICRX2bvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(30864003)(16526019)(47076005)(26005)(426003)(336012)(356005)(82740400003)(83380400001)(81166007)(36860700001)(4326008)(8936002)(8676002)(1076003)(70586007)(478600001)(6916009)(70206006)(40460700003)(316002)(2616005)(2906002)(5660300002)(54906003)(7696005)(6666004)(41300700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:41:49.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478610ad-52da-4702-f110-08dbc99f0917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace prange->mapped_to_gpu with prange->bitmap_mapped[], which is per
GPU flag and based on prange granularity, updated when map to GPUS or
unmap from GPUs, to optimize multiple GPU map, unmap and retry fault
recover.

svm_range_partial_mapped is false only if no part of the range mapping
on any GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 256 +++++++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   8 +-
 2 files changed, 213 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fb22b857adbc..4e1af4b181ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -296,12 +296,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 	}
 
-	/* free dma_addr array for each gpu */
+	/* free dma_addr array, bitmap_mapped for each gpu */
 	for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
-		if (prange->dma_addr[gpuidx]) {
+		if (prange->dma_addr[gpuidx])
 			kvfree(prange->dma_addr[gpuidx]);
-				prange->dma_addr[gpuidx] = NULL;
-		}
+		if (prange->bitmap_mapped[gpuidx])
+			bitmap_free(prange->bitmap_mapped[gpuidx]);
 	}
 
 	mutex_destroy(&prange->lock);
@@ -327,19 +327,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
 	struct kfd_process *p;
-
-	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
-	if (!prange)
-		return NULL;
+	unsigned int nbits;
+	uint32_t gpuidx;
 
 	p = container_of(svms, struct kfd_process, svms);
 	if (!p->xnack_enabled && update_mem_usage &&
 	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
 				    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
 		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
-		kfree(prange);
 		return NULL;
 	}
+
+	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
+	if (!prange)
+		return NULL;
+
+	svm_range_set_default_attributes(&prange->preferred_loc,
+					 &prange->prefetch_loc,
+					 &prange->granularity, &prange->flags);
+
+	nbits = svm_range_mapped_nbits(start, last, prange->granularity);
+	pr_debug("prange 0x%p [0x%llx 0x%llx] bitmap_mapped nbits %d\n", prange,
+		 start, last, nbits);
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		prange->bitmap_mapped[gpuidx] = bitmap_zalloc(nbits, GFP_KERNEL);
+		if (!prange->bitmap_mapped[gpuidx]) {
+			while (gpuidx--)
+				bitmap_free(prange->bitmap_mapped[gpuidx]);
+			kfree(prange);
+			return NULL;
+		}
+	}
+
 	prange->npages = size;
 	prange->svms = svms;
 	prange->start = start;
@@ -359,10 +378,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&prange->preferred_loc,
-					 &prange->prefetch_loc,
-					 &prange->granularity, &prange->flags);
-
 	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
 
 	return prange;
@@ -984,6 +999,47 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	return 0;
 }
 
+static int
+svm_range_split_bitmap_mapped(struct svm_range *new, struct svm_range *old,
+			      uint64_t start, uint64_t last)
+{
+	struct kfd_process *p = container_of(new->svms, struct kfd_process, svms);
+	unsigned int nbits, old_nbits, old_nbits2;
+	unsigned long *bits;
+	uint32_t gpuidx;
+
+	nbits = svm_range_mapped_nbits(new->start, new->last, new->granularity);
+	old_nbits = svm_range_mapped_nbits(old->start, old->last, old->granularity);
+	old_nbits2 = svm_range_mapped_nbits(start, last, old->granularity);
+
+	pr_debug("old 0x%p [0x%lx 0x%lx] => [0x%llx 0x%llx] nbits %d => %d\n",
+		 old, old->start, old->last, start, last, old_nbits, old_nbits2);
+	pr_debug("new 0x%p [0x%lx 0x%lx] nbits %d\n", new, new->start, new->last,
+		 nbits);
+
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
+		if (!bits)
+			return -ENOMEM;
+
+		if (start == old->start) {
+			bitmap_shift_right(new->bitmap_mapped[gpuidx],
+					   old->bitmap_mapped[gpuidx],
+					   old_nbits2 - 1, old_nbits);
+			bitmap_copy(bits, old->bitmap_mapped[gpuidx], old_nbits2);
+		} else {
+			bitmap_copy(new->bitmap_mapped[gpuidx],
+				    old->bitmap_mapped[gpuidx], nbits);
+			bitmap_shift_right(bits, old->bitmap_mapped[gpuidx],
+					   nbits - 1, old_nbits);
+		}
+		bitmap_free(old->bitmap_mapped[gpuidx]);
+		old->bitmap_mapped[gpuidx] = bits;
+	}
+
+	return 0;
+}
+
 /**
  * svm_range_split_adjust - split range and adjust
  *
@@ -1024,6 +1080,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 			return r;
 	}
 
+	r = svm_range_split_bitmap_mapped(new, old, start, last);
+	if (r)
+		return r;
+
 	old->npages = last - start + 1;
 	old->start = start;
 	old->last = last;
@@ -1032,7 +1092,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -1346,6 +1405,108 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				      fence);
 }
 
+/**
+ * svm_range_partial_mapped_dev - check if prange mapped on the specific GPU
+ *
+ * @gpuidx: the GPU index to check
+ * @prange: prange to check
+ * @start: the start address in pages
+ * @last: the last address in pages
+ *
+ * Return:
+ * true: if any part of the range within [start, last] mapped on the GPU
+ * false: if the entire range [start, last] not mapped on the GPU
+ */
+static bool
+svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
+			     unsigned long start, unsigned long last)
+{
+	unsigned long start_index, last_index;
+
+	start = max(start, prange->start);
+	last = min(last, prange->last);
+	if (last < start)
+		return false;
+
+	start_index = (start - prange->start) >> prange->granularity;
+	last_index = (last - prange->start) >> prange->granularity;
+	return find_next_bit(prange->bitmap_mapped[gpuidx], last_index + 1,
+			     start_index) <= last_index;
+}
+
+/**
+ * svm_range_partial_mapped - check if prange mapped on any GPU
+ *
+ * @prange: prange to check
+ * @start: the start address in pages
+ * @last: the last address in pages
+ *
+ * Return:
+ * true: if any part of prange mapped on any GPU currently
+ * false: if the entire range is not mapped on any GPU
+ */
+static bool
+svm_range_partial_mapped(struct svm_range *prange, unsigned long start,
+			 unsigned long last)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	struct svm_range *pchild;
+	uint32_t gpuidx;
+
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		list_for_each_entry(pchild, &prange->child_list, child_list) {
+			if (svm_range_partial_mapped_dev(gpuidx, pchild, start, last))
+				return true;
+		}
+
+		if (svm_range_partial_mapped_dev(gpuidx, prange, start, last))
+			return true;
+	}
+	return false;
+}
+
+/**
+ * svm_range_complete_mapped - check if prange mapped on all GPUs completely
+ *
+ * @prange: prange to check
+ *
+ * Return:
+ * true: if the entire prange mapped completely on all GPUs that need access
+ * otherwise return false
+ */
+static bool svm_range_complete_mapped(struct svm_range *prange)
+{
+	int nbits = svm_range_mapped_nbits(prange->start, prange->last, prange->granularity);
+	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
+	uint32_t gpuidx;
+	int r;
+
+	r = svm_range_need_access_gpus(bitmap, prange);
+	if (r)
+		return false;
+
+	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE)
+		if (!bitmap_full(prange->bitmap_mapped[gpuidx], nbits))
+			return false;
+	return true;
+}
+
+static void
+svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
+			unsigned long start, unsigned long last, bool mapped)
+{
+	unsigned long index, nbits;
+
+	index = (start - prange->start) >> prange->granularity;
+	nbits = svm_range_mapped_nbits(start, last, prange->granularity);
+	if (mapped)
+		bitmap_set(prange->bitmap_mapped[gpuidx], index, nbits);
+	else
+		bitmap_clear(prange->bitmap_mapped[gpuidx], index, nbits);
+	pr_debug("prange 0x%p [0x%lx 0x%lx] update mapped %d nbits %ld gpu %d\n",
+		 prange, start, last, mapped, nbits, gpuidx);
+}
+
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			  unsigned long last, uint32_t trigger)
@@ -1357,29 +1518,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	uint32_t gpuidx;
 	int r = 0;
 
-	if (!prange->mapped_to_gpu) {
-		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
-			 prange, prange->start, prange->last);
-		return 0;
-	}
-
-	if (prange->start == start && prange->last == last) {
-		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
-		prange->mapped_to_gpu = false;
-	}
-
 	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
 		  MAX_GPU_INSTANCE);
 	p = container_of(prange->svms, struct kfd_process, svms);
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
-		pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
 		if (!pdd) {
 			pr_debug("failed to find device idx %d\n", gpuidx);
-			return -EINVAL;
+			continue;
 		}
 
+		if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
+			pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n",
+				 prange->svms, prange, start, last, gpuidx);
+			continue;
+		}
+
+		svm_range_update_mapped(gpuidx, prange, start, last, false);
+
+		pr_debug("unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n",
+			 prange->svms, prange, start, last, gpuidx);
+
 		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
 					     start, last, trigger);
 
@@ -1519,6 +1679,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		if (r)
 			break;
 
+		if (!r)
+			svm_range_update_mapped(gpuidx, prange, prange->start + offset,
+						prange->start + offset + npages - 1, true);
+
 		if (fence) {
 			r = dma_fence_wait(fence, false);
 			dma_fence_put(fence);
@@ -1670,7 +1834,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
 		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
-		if (!prange->mapped_to_gpu ||
+		if (!svm_range_partial_mapped(prange, prange->start, prange->last) ||
 		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
 			r = 0;
 			goto free_ctx;
@@ -1755,9 +1919,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
 						  ctx->bitmap, flush_tlb);
 
-		if (!r && next == end)
-			prange->mapped_to_gpu = true;
-
 		svm_range_unlock(prange);
 
 		addr = next;
@@ -1939,22 +2100,8 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p->xnack_enabled ||
 	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange->mapped_to_gpu;
-
-		list_for_each_entry(pchild, &prange->child_list, child_list) {
-			if (!pchild->mapped_to_gpu)
-				continue;
-			mapped = true;
-			mutex_lock_nested(&pchild->lock, 1);
-			if (pchild->start <= last && pchild->last >= start) {
-				pr_debug("increment pchild invalid [0x%lx 0x%lx]\n",
-					 pchild->start, pchild->last);
-				atomic_inc(&pchild->invalid);
-			}
-			mutex_unlock(&pchild->lock);
-		}
 
-		if (!mapped)
+		if (!svm_range_partial_mapped(prange, start, last))
 			return r;
 
 		if (prange->start <= last && prange->last >= start)
@@ -2005,7 +2152,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 static struct svm_range *svm_range_clone(struct svm_range *old)
 {
+	struct kfd_process *p = container_of(old->svms, struct kfd_process, svms);
 	struct svm_range *new;
+	uint32_t gpuidx;
+	int nbits;
 
 	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
@@ -2027,8 +2177,13 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
 	new->vram_pages = old->vram_pages;
+	nbits = svm_range_mapped_nbits(new->start, new->last, new->granularity);
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		bitmap_copy(new->bitmap_mapped[gpuidx],
+			    old->bitmap_mapped[gpuidx],
+			    nbits);
+	};
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2147,7 +2302,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node->last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
-		    prange->mapped_to_gpu) {
+		    svm_range_complete_mapped(prange)) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -3641,7 +3796,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated && (!p->xnack_enabled ||
 		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
-		    prange->mapped_to_gpu) {
+		    svm_range_partial_mapped(prange, prange->start, prange->last)) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
@@ -3652,7 +3807,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
+		flush_tlb = !migrated && update_mapping &&
+			    svm_range_partial_mapped(prange, prange->start, prange->last);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
 					       true, flush_tlb);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index bf2fde008115..7e165854bc0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -136,7 +136,7 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	unsigned long			*bitmap_mapped[MAX_GPU_INSTANCE];
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
@@ -167,6 +167,12 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
 		return NULL;
 }
 
+static inline int svm_range_mapped_nbits(uint64_t start, uint64_t last,
+					 uint8_t granularity)
+{
+	return (last >> granularity) - (start >> granularity) + 1;
+}
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A400E71D3F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 14:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1C210E139;
	Fri, 29 Sep 2023 14:12:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9CF10E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 14:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVwFuLUvujSTUhgEl9XBGte9rqz3NmHZG2kWrv0IZMpPD33mquXeW4wJ5k2HOkassHN+oiUDzNR1XMLYNbhIQsDKai1cRgYOLbfDasXL62nKfZrkbGmunRRU1isI/JDV+q3bQg1oIX9iwuSkTtq/KlIpuhFqHl5smUeEFPFVIqDDVwA/pBT50odxSmvbi2Zp7lye4Ko2c2yty1DDxFhGn2lMPjRWXTLOw352kCHuwuAsTcbKghyhSR+H3O3NdhldnPicQtfXg0wIGludTm2ZlwvKuZe+KXTCDpzwdjOzSKtAxx33t+SDH9PnR4Z+r/mOBpGfXltKuIT9pyvFGxmEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCtaid6myv2XOBaCEJPdnJ9U+PG6NPLuq3gNa83OKkw=;
 b=DzylsotJev8Lcaq9E9KRnxk/BjifJ2HGYf4NUayWIZVzaWBAxaScXW9IcXcBJmLWDxTWO5ShaPjYuwhzJAxxCza3bj3COX9rm20wPc0chLJr+MUsX2U68KSHZAKlsDSeL4r5kDXtEidagADsnaY2j11QblSsl56OfDTQJ7ntjTPzhRBBhtjagzFQfV8th5DY+7dNl7VLiLZK5vvtmgcNx4xPsLBLUQgATG4AzulmFC4FJSJnQjy4JOoniWRJxw7rtii8pWUQi4Orkt1xhyqVK60yRl01QbjHIJKTwyFApuzQOJCcmDIgvobGzIjgntVsdcJuxdL4M1LrY8zqfbrjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCtaid6myv2XOBaCEJPdnJ9U+PG6NPLuq3gNa83OKkw=;
 b=AHiiQzaaLgATdpkAgRTPuGIQVFLMrwCqHedBviqwKsKrn0uAih4hMuN3GrARpP6IZLjS2j7Z4CJJedVgySVSGX/5NJKGIuZHXZ3NxOSGxyZ5xXSwE4L2YHYityJf56e7Kqo9zAyNe1hVjJVzQH4gMtdSM/+Y1123tJwW1xElDjI=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 14:12:05 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ec) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 14:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 14:12:02 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 09:12:02 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] amd/amdkfd: Add granularity bitmap mapped to gpu flag
Date: Fri, 29 Sep 2023 10:11:13 -0400
Message-ID: <20230929141115.10016-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ba6988-c581-4cc1-ec72-08dbc0f60ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jak2sF2+jJZLplhl/wQnUMPMMTAqz3MfavpFevZt7jOxEuwD7EAcfdZHl9OtvtTXdBXj/ULCUOHJ7NA0WmMXffYwB5tcY76u1Bf5saAFRoGj+hyDbxnJWigoChEeqZ1NUSvbtYBwik8WTf2nS+5QdO3UZU+nqmFeVKIeMb4PDt2pTuI+wmNHj7MnZqVxJGAVBzgm2EjXNqGBTN7yft3eFQc+z/tmqzSXEboah/qFMTR+yjNultwAkSQdpiwewEDo9sPPODMaT4q1fvQPboMmR6Aa7/gWrLbAs0U+UQZVJrIrB/quA4QiezHR+TcsMuWIB1X1QSrVRm7mxPl+ntNFsNWutfewr3lmlh6ZE6zM1MUEZgCUYnDL9hIp2iMQA+9/3uszevmcafYnfT88JecgjNOLaH9nL6dP2LTGSIAN0sJ3t7qgy3xG5/eDRqqMuAghQdKPldts2GX2NiSBt/ZFcM0K1eFmJOxqoCqsIrqPx0/DqAFoid11G3Sou6mqItcbvcpVKvXYsDElRo/B8ZxGbUu5mxo8Y7HjsFaq7G9qhXjhJfiKi2qhyvon9UtLfWa3jrQa4OW0QTjLGs+3QOn6HKpVFr859a9oEN5/oTQGLGiN7YDxiRMrnK818Pq6aHWNsZG1Rulhdr0jjxE5iPucr4TGVJHVVvLzyI+wXaXNY1CHSSIH1Fj3166sbyPO5yxUBbRJitgrTcF8HaTknfEskP/7BtFzol1Odaz5z5IAWDJbtZH/7xg1LI39zj33p3tP7qMgF3Ob1Kq/7pYiYyg2mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(40470700004)(36840700001)(46966006)(6666004)(5660300002)(40460700003)(1076003)(2906002)(36756003)(16526019)(26005)(2616005)(83380400001)(426003)(336012)(30864003)(356005)(82740400003)(81166007)(86362001)(47076005)(36860700001)(7696005)(40480700001)(8936002)(8676002)(4326008)(54906003)(70206006)(70586007)(316002)(41300700001)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:12:02.9658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ba6988-c581-4cc1-ec72-08dbc0f60ddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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

Replace prange->mapped_to_gpu with prange->bitmap_mapped[], which is
based on prange granularity, updated when map to GPUS or unmap from
GPUs, to optimize multiple GPU map, unmap and retry fault recover.

svm_range_is_mapped is false only if no parital range mapping on any
GPUs.

Split the bitmap_mapped when unmap from cpu to split the prange.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 218 ++++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   4 +-
 2 files changed, 184 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 040dc32ad475..626e0dd4ec79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -292,12 +292,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
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
@@ -323,19 +323,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
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
+	nbits = svm_range_mapped_nbits(size, prange->granularity);
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
@@ -354,10 +373,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&prange->preferred_loc,
-					 &prange->prefetch_loc,
-					 &prange->granularity, &prange->flags);
-
 	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
 
 	return prange;
@@ -972,6 +987,48 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
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
+	nbits = svm_range_mapped_nbits(new->npages, new->granularity);
+	old_nbits = svm_range_mapped_nbits(old->npages, old->granularity);
+	old_nbits2 = svm_range_mapped_nbits(last - start + 1, old->granularity);
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
+					   old_nbits2, old_nbits);
+			bitmap_shift_right(bits, old->bitmap_mapped[gpuidx], 0,
+					   old_nbits2);
+		} else {
+			bitmap_copy(new->bitmap_mapped[gpuidx],
+				    old->bitmap_mapped[gpuidx], nbits);
+			bitmap_shift_right(bits, old->bitmap_mapped[gpuidx],
+					   nbits, old_nbits);
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
@@ -1012,6 +1069,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 			return r;
 	}
 
+	r = svm_range_split_bitmap_mapped(new, old, start, last);
+	if (r)
+		return r;
+
 	old->npages = last - start + 1;
 	old->start = start;
 	old->last = last;
@@ -1020,7 +1081,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -1310,6 +1370,84 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				      fence);
 }
 
+/**
+ * svm_range_partial_mapped_dev - check if prange mapped on the specific gpu
+ *
+ * @gpuidx: the gpu to check
+ * @prange: prange to check
+ * @start: the start address in pages
+ * @last: the last address in pages
+ *
+ * Return:
+ * true: if any partial range mapped on gpu based on granularity boundary
+ * false: if the entire range not mapped
+ */
+static bool
+svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
+			     unsigned long start, unsigned long last)
+{
+	unsigned long index, off;
+	bool mapped = false;
+
+	start = max(start, prange->start);
+	last = min(last, prange->last);
+	if (last < start)
+		goto out;
+
+	for (off = start; off <= last; off += (1UL << prange->granularity)) {
+		index = (off - prange->start) >> prange->granularity;
+		if (test_bit(index, prange->bitmap_mapped[gpuidx])) {
+			mapped = true;
+			break;
+		}
+	}
+out:
+	pr_debug("prange 0x%p [0x%lx 0x%lx] mapped %d on gpu %d\n", prange,
+		 start, last, mapped, gpuidx);
+	return mapped;
+}
+
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
+static bool svm_range_is_mapped(struct svm_range *prange)
+{
+	return svm_range_partial_mapped(prange, prange->start, prange->last);
+}
+
+static void
+svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
+			unsigned long start, unsigned long last, bool mapped)
+{
+	unsigned long index, nbits;
+
+	index = (start - prange->start) >> prange->granularity;
+	nbits = svm_range_mapped_nbits(last - start + 1, prange->granularity);
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
@@ -1321,29 +1459,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
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
+		}
+
+		if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
+			pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n",
+				 prange->svms, prange, start, last, gpuidx);
+			continue;
 		}
 
+		svm_range_update_mapped(gpuidx, prange, start, last, false);
+
+		pr_debug("unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n",
+			 prange->svms, prange, start, last, gpuidx);
+
 		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
 					     start, last, trigger);
 
@@ -1483,6 +1620,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		if (r)
 			break;
 
+		if (!r)
+			svm_range_update_mapped(gpuidx, prange, prange->start + offset,
+						prange->start + offset + npages - 1, true);
+
 		if (fence) {
 			r = dma_fence_wait(fence, false);
 			dma_fence_put(fence);
@@ -1648,7 +1789,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
 		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
-		if (!prange->mapped_to_gpu ||
+		if (!svm_range_is_mapped(prange) ||
 		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
 			r = 0;
 			goto free_ctx;
@@ -1729,9 +1870,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
 						  ctx->bitmap, flush_tlb);
 
-		if (!r && next == end)
-			prange->mapped_to_gpu = true;
-
 		svm_range_unlock(prange);
 
 		addr = next;
@@ -1900,10 +2038,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p->xnack_enabled ||
 	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange->mapped_to_gpu;
+		bool mapped = svm_range_is_mapped(prange);
 
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
-			if (!pchild->mapped_to_gpu)
+			if (!svm_range_is_mapped(pchild))
 				continue;
 			mapped = true;
 			mutex_lock_nested(&pchild->lock, 1);
@@ -1966,7 +2104,9 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 static struct svm_range *svm_range_clone(struct svm_range *old)
 {
+	struct kfd_process *p = container_of(old->svms, struct kfd_process, svms);
 	struct svm_range *new;
+	uint32_t gpuidx;
 
 	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
@@ -1988,7 +2128,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		bitmap_copy(new->bitmap_mapped[gpuidx], old->bitmap_mapped[gpuidx],
+			    svm_range_mapped_nbits(new->last - new->start + 1,
+						   new->granularity));
+	};
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2107,7 +2251,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node->last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
-		    prange->mapped_to_gpu) {
+		    svm_range_is_mapped(prange)) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -3587,7 +3731,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated && (!p->xnack_enabled ||
 		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
-		    prange->mapped_to_gpu) {
+		    svm_range_is_mapped(prange)) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
@@ -3598,7 +3742,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
+		flush_tlb = !migrated && update_mapping && svm_range_is_mapped(prange);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
 					       true, flush_tlb);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index d2e94d8fb4be..10c92c5e23a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -132,7 +132,7 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	unsigned long			*bitmap_mapped[MAX_GPU_INSTANCE];
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
@@ -163,6 +163,8 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
 		return NULL;
 }
 
+#define svm_range_mapped_nbits(size, granularity) DIV_ROUND_UP((size), 1UL << (granularity))
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
-- 
2.35.1


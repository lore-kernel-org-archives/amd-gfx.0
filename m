Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805ECC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CF910E3A3;
	Mon, 15 Jan 2024 22:51:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3F810E3A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciefeTWihddd3EevhnzHmasMXAChsRh4tzK89zZMrYBawF4XiJQDzrbLJfBwAOYlluefnIkhfR04nuhS6vJ7SgG+c7pS4LgZV1mxu0TOiZ2zNhcJPIQN2Ai0uI04O52aIyPUlIzitn+yfml3hWNLUAJ9iknkJRvHDKNZ1VfX5YzuOXX1Q5+KtUeSNn4kX2wSmMHB/9Xe8e/iWoyqmUO4/uXcA8wHvPgpPEpTlW5KtGaAtHykyZ3u1uG0tdDiSU44J7sCODJvOWI6ePYcYuALIPQ2JiXsxSokn+yy+xQDenjmMwRJIadoHtZ7A+Vb5HiA2Y6UxlO7wzg+3rKor8p+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjz2Cn3Z258/rOGDyE+hUQXboYaqYnRKi8zYdrQUpiM=;
 b=Co7g6RPtrn6Qzdchap/1OJYayjPPHBvTsVt478OgWAyu0svlDI8Ov5Bb24Xb9jvbS+fORaneBQEETLGu1fC2h+f525wQUQRfRX8J4EBOIPtemrlk8xWGhENfd98z6gTL55etf0wy7QAmVCDCOJ13+Avr9Gbqk925su4l+hnHYAJYBYXUxw7FSpBSbOQ7qMztPTWhv4dwQDxPivl4gotmP5/aASFjJ+8YSvkp02jIuH2tHqsabqMYdaUfClBaKQXFEl6zoV3JGWNabMtHACuV43iK+DMQURypgFwroYu/drIh6bOgV7EGMJSQd0DN0ajC9Tf9bUaLWernbP8EPqvDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjz2Cn3Z258/rOGDyE+hUQXboYaqYnRKi8zYdrQUpiM=;
 b=5iuhVK3ats+D0P/Z9I6X6mG+sl2BNxsCAfK4JXuVL2rWvr7Nj3tsnfzCu4TVneghM2Q+L+FbdU2H/mxkqe917zkCwPMJ3po6REeNiW76h+4aWeDKhV4WpJragrKzo8c85OB8TfZw80IAbfFXcj4KIfz9UJ4QL2hRSCebih4EcJ0=
Received: from SA9PR13CA0164.namprd13.prod.outlook.com (2603:10b6:806:28::19)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 22:51:23 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::b4) by SA9PR13CA0164.outlook.office365.com
 (2603:10b6:806:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.19 via Frontend
 Transport; Mon, 15 Jan 2024 22:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:51:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:51:21 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/7] drm/amdkfd: Add granularity size based bitmap map flag
Date: Mon, 15 Jan 2024 17:49:46 -0500
Message-ID: <20240115224950.3300-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240115224950.3300-1-Philip.Yang@amd.com>
References: <20240115224950.3300-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: f3000d81-d6c4-498f-7e68-08dc161c7fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyxXo7xJhYCo+GRWz5occrrMXUn23/9fTk3miAtmXm6THcTHWrkp8moLfD2moKlCCemUT2mxGwmR2jBeqzaL+txqG02qQvX0MSQcVEopqnBFeEMzhm7C9uRMK6zPcLoIluZXOycEe1N0ckYZSTmZKFwXmUVYX/7rKLYD9POm62Hz8h/AkmjgcPMCTfWzQkn4euXp6FP2/5WbafAGAZQE9Ocj9sjBZkAKfXMlluo2wSmfvjAZKTmBjisAU2CcXSkeFx79Eqf8fm0sOG9WcyvxLZVhUtKYJi90jWd1tzv9GGiinoWFGICM7DwyTJY3BpbRBtbT1Pj270pu3CSC4qztyC2SIBQxEst601ALABYFXuUhpDHHbdH1bIyJDr/qA1XxTw6j/EM6gByIqsLxrNp/0wMk8d7DyrHNG27mLwsNvDA6I+cQETGMGhAuRqjOFggKrFXrHj2RHZeY+9ZgxwTQqchWOqEuOj6/omqdHbTu8o5/plcdfobgauG+G/hOCOc7R5yDzWOiq9Y8IhFi6PMhASosyuEaGrQNo9d2jLWkM8v6tOF78bKn7kSTKVfsoP1EKRSUjyLAyJxUAuD0fmlreTT5JAPWoj4KVLmZCVTYKrM3k747YfRMo85dZhpJr9ZcDGuGSI0bbXlE4FOi5ABc9VflHqkMja3V7IDRMRNkHl5RLNRLVo1OzMBJUyAPlUNyA+UmGyXcBEKmS4PCSFD/czFTOYX+u3sB1bZV8GF3W5dEqOfz9/74MPfoIYv6ciMNiSTjXMOaQE0Oee7u0hUzIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(426003)(6666004)(336012)(26005)(2616005)(7696005)(478600001)(1076003)(16526019)(6916009)(316002)(8936002)(8676002)(36756003)(70586007)(54906003)(70206006)(81166007)(4326008)(356005)(82740400003)(83380400001)(47076005)(36860700001)(86362001)(30864003)(5660300002)(2906002)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:51:23.7884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3000d81-d6c4-498f-7e68-08dc161c7fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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

Replace prange->mapped_to_gpu with prange->bitmap_map[], which is per
GPU flag and use bitmap bits based on prange granularity. Align map to
GPU or unmap from GPU range size to granularity size and update the
corresponding bitmap_map flag bits.  This will optimize multiple GPU
map, unmap and retry fault recover.

svm_range_partial_mapped is false only if no part of the range mapping
on any GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 258 ++++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   7 +-
 2 files changed, 219 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a2c96f5760ff..a003406db067 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -307,12 +307,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 	}
 
-	/* free dma_addr array for each gpu */
+	/* free dma_addr array, bitmap_map for each gpu */
 	for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
-		if (prange->dma_addr[gpuidx]) {
+		if (prange->dma_addr[gpuidx])
 			kvfree(prange->dma_addr[gpuidx]);
-			prange->dma_addr[gpuidx] = NULL;
-		}
+		if (prange->bitmap_map[gpuidx])
+			bitmap_free(prange->bitmap_map[gpuidx]);
 	}
 
 	mutex_destroy(&prange->lock);
@@ -338,19 +338,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
 	struct kfd_process *p;
-
-	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
-	if (!prange)
-		return NULL;
+	unsigned int nbits;
+	u32 gpuidx;
 
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
+	nbits = svm_range_map_nbits(start, last, prange->granularity);
+	pr_debug("prange 0x%p [0x%llx 0x%llx] bitmap_map nbits %d\n", prange,
+		 start, last, nbits);
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		prange->bitmap_map[gpuidx] = bitmap_zalloc(nbits, GFP_KERNEL);
+		if (!prange->bitmap_map[gpuidx]) {
+			while (gpuidx--)
+				bitmap_free(prange->bitmap_map[gpuidx]);
+			kfree(prange);
+			return NULL;
+		}
+	}
+
 	prange->npages = size;
 	prange->svms = svms;
 	prange->start = start;
@@ -369,10 +388,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&prange->preferred_loc,
-					 &prange->prefetch_loc,
-					 &prange->granularity, &prange->flags);
-
 	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
 
 	return prange;
@@ -1017,6 +1032,51 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	return 0;
 }
 
+static int
+svm_range_split_bitmap_map(struct svm_range *new, struct svm_range *old,
+			   u64 start, u64 last)
+{
+	struct kfd_process *p = container_of(new->svms, struct kfd_process, svms);
+	u32 new_nbits, old_nbits, old_nbits2;
+	unsigned long *bits;
+	u32 gpuidx;
+
+	new_nbits = svm_range_map_nbits(new->start, new->last, new->granularity);
+	old_nbits = svm_range_map_nbits(old->start, old->last, old->granularity);
+	old_nbits2 = svm_range_map_nbits(start, last, old->granularity);
+
+	pr_debug("old 0x%p [0x%lx 0x%lx] => [0x%llx 0x%llx] nbits %d => %d\n",
+		 old, old->start, old->last, start, last, old_nbits, old_nbits2);
+	pr_debug("new 0x%p [0x%lx 0x%lx] nbits %d\n", new, new->start, new->last,
+		 new_nbits);
+
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
+		if (!bits)
+			return -ENOMEM;
+
+		if (start == old->start) {
+			bitmap_copy(bits, old->bitmap_map[gpuidx], old_nbits2);
+			bitmap_shift_right(old->bitmap_map[gpuidx],
+					   old->bitmap_map[gpuidx],
+					   old_nbits - new_nbits, old_nbits);
+			bitmap_copy(new->bitmap_map[gpuidx],
+				    old->bitmap_map[gpuidx], new_nbits);
+		} else {
+			bitmap_copy(new->bitmap_map[gpuidx],
+				    old->bitmap_map[gpuidx], new_nbits);
+			bitmap_shift_right(old->bitmap_map[gpuidx],
+					   old->bitmap_map[gpuidx],
+					   old_nbits - old_nbits2, old_nbits);
+			bitmap_copy(bits, old->bitmap_map[gpuidx], old_nbits2);
+		}
+		bitmap_free(old->bitmap_map[gpuidx]);
+		old->bitmap_map[gpuidx] = bits;
+	}
+
+	return 0;
+}
+
 /**
  * svm_range_split_adjust - split range and adjust
  *
@@ -1057,6 +1117,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 			return r;
 	}
 
+	r = svm_range_split_bitmap_map(new, old, start, last);
+	if (r)
+		return r;
+
 	old->npages = last - start + 1;
 	old->start = start;
 	old->last = last;
@@ -1064,7 +1128,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -1169,6 +1232,65 @@ svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
 	list_add_tail(&pchild->child_list, &prange->child_list);
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
+svm_range_partial_mapped_dev(u32 gpuidx, struct svm_range *prange,
+			     u64 start, u64 last)
+{
+	u64 start_index, last_index;
+
+	start = max_t(u64, start, prange->start);
+	last = min_t(u64, last, prange->last);
+	if (last < start)
+		return false;
+
+	start_index = (start >> prange->granularity) - (prange->start >> prange->granularity);
+	last_index = (last >> prange->granularity) - (prange->start >> prange->granularity);
+	return find_next_bit(prange->bitmap_map[gpuidx], last_index + 1,
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
+svm_range_partial_mapped(struct svm_range *prange, u64 start, u64 last)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	struct svm_range *pchild;
+	u32 gpuidx;
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
 static int
 svm_range_need_access_gpus(unsigned long *bitmap, struct svm_range *prange)
 {
@@ -1196,7 +1318,7 @@ svm_range_need_access_gpus(unsigned long *bitmap, struct svm_range *prange)
 		 * update mapping on GPUs with ACCESS attribute
 		 */
 		if (bitmap_empty(bitmap, MAX_GPU_INSTANCE)) {
-			if (prange->mapped_to_gpu ||
+			if (svm_range_partial_mapped(prange, prange->start, prange->last) ||
 			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
 				bitmap_copy(bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
 		}
@@ -1336,6 +1458,48 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				      fence);
 }
 
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
+	int nbits = svm_range_map_nbits(prange->start, prange->last, prange->granularity);
+	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
+	u32 gpuidx;
+	int r;
+
+	r = svm_range_need_access_gpus(bitmap, prange);
+	if (r)
+		return false;
+
+	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE)
+		if (!bitmap_full(prange->bitmap_map[gpuidx], nbits))
+			return false;
+	return true;
+}
+
+static void
+svm_range_update_mapped(u32 gpuidx, struct svm_range *prange,
+			u64 start, u64 last, bool mapped)
+{
+	u64 index, nbits;
+
+	index = (start >>  prange->granularity) - (prange->start >> prange->granularity);
+	nbits = svm_range_map_nbits(start, last, prange->granularity);
+	if (mapped)
+		bitmap_set(prange->bitmap_map[gpuidx], index, nbits);
+	else
+		bitmap_clear(prange->bitmap_map[gpuidx], index, nbits);
+	pr_debug("prange 0x%p [0x%llx 0x%llx] update mapped %d nbits %lld gpu %d\n",
+		 prange, start, last, mapped, nbits, gpuidx);
+}
+
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			  unsigned long last, uint32_t trigger)
@@ -1347,29 +1511,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
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
 
@@ -1510,6 +1673,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		if (r)
 			break;
 
+		if (!r)
+			svm_range_update_mapped(gpuidx, prange, prange->start + offset,
+						prange->start + offset + npages - 1, true);
+
 		if (fence) {
 			r = dma_fence_wait(fence, false);
 			dma_fence_put(fence);
@@ -1745,9 +1912,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			}
 		}
 
-		if (!r && next == end)
-			prange->mapped_to_gpu = true;
-
 		svm_range_unlock(prange);
 
 		addr = next;
@@ -1916,12 +2080,11 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p->xnack_enabled ||
 	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange->mapped_to_gpu;
+
+		if (!svm_range_partial_mapped(prange, start, last))
+			return r;
 
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
-			if (!pchild->mapped_to_gpu)
-				continue;
-			mapped = true;
 			mutex_lock_nested(&pchild->lock, 1);
 			if (pchild->start <= last && pchild->last >= start) {
 				pr_debug("increment pchild invalid [0x%lx 0x%lx]\n",
@@ -1930,10 +2093,6 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			}
 			mutex_unlock(&pchild->lock);
 		}
-
-		if (!mapped)
-			return r;
-
 		if (prange->start <= last && prange->last >= start)
 			atomic_inc(&prange->invalid);
 
@@ -1982,7 +2141,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 static struct svm_range *svm_range_clone(struct svm_range *old)
 {
+	struct kfd_process *p = container_of(old->svms, struct kfd_process, svms);
 	struct svm_range *new;
+	u32 gpuidx;
+	int nbits;
 
 	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
@@ -2004,8 +2166,13 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
 	new->vram_pages = old->vram_pages;
+	nbits = svm_range_map_nbits(new->start, new->last, new->granularity);
+	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
+		bitmap_copy(new->bitmap_map[gpuidx],
+			    old->bitmap_map[gpuidx],
+			    nbits);
+	};
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2126,7 +2293,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node->last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
-		    prange->mapped_to_gpu) {
+		    svm_range_complete_mapped(prange)) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -3611,7 +3778,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated && (!p->xnack_enabled ||
 		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
-		    prange->mapped_to_gpu) {
+		    svm_range_partial_mapped(prange, prange->start, prange->last)) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
@@ -3622,8 +3789,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
-
+		flush_tlb = !migrated && update_mapping &&
+			    svm_range_partial_mapped(prange, prange->start, prange->last);
 		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
 					       MAX_GPU_INSTANCE, true, true, flush_tlb);
 		if (r)
@@ -3639,8 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
 			 prange, prange->start, prange->last);
 		mutex_lock(&prange->migrate_mutex);
+		flush_tlb = svm_range_partial_mapped(prange, prange->start, prange->last);
 		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, true, true, prange->mapped_to_gpu);
+					       MAX_GPU_INSTANCE, true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d on remap svm range\n", r);
 		mutex_unlock(&prange->migrate_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 806bcac6d101..a10eeb77f83e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -136,7 +136,7 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	unsigned long			*bitmap_map[MAX_GPU_INSTANCE];
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
@@ -169,6 +169,11 @@ static inline u64 svm_range_align_last(u64 addr, u64 range_last, u64 align_size)
 	return min(ALIGN(addr + 1, align_size) - 1, range_last);
 }
 
+static inline u32 svm_range_map_nbits(u64 start, u64 last, u8 granularity)
+{
+	return (last >> granularity) - (start >> granularity) + 1;
+}
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
-- 
2.35.1


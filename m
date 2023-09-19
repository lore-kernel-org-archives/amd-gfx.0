Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E534CD5BC7
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 14:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F3510E278;
	Tue, 19 Sep 2023 14:21:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAEE10E278
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 14:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzhteONLIveJbRwB3aTzAdCnoNnNwvZ2SKL7hZlp7ptLsGs0jYBYmO0OxfwYBh7xnoGm2FeVihBtXSwc1YEyEXurSeyOwZLhp9rNP4pXKaHO//y7ttUnrCy03IWlj2V7hFDlkeBx2CVii6yVvcg/jsZ+YI7Dw6dXG+4XoI/xnNzJtf0j3GS2Eh+z3+D6Ai+f7kVuSMCm1yXPUhCrnSFmc2162711D73wiH5DbpFKALKudIiJgvjBAG2pz3kKtnqkF8wkh7WRYV/owEXT0Z6QvxKcAG/cOfONrWVGs9WJX+HAmpLC3FOueeg2YUu38S13Me7T5EKZmweE5lI/JmBrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5Jkx1xwKikKUuiifSQqOz0H9zW1YevpPJalxBJBp5A=;
 b=DKHuqiLBgJx/hH3HJXtrKt25H1KDyebdvSZVvsRJVgVQ56ueipeI0ENaGRv+xECHZQRhuNyamBAtd8yjhWqgShzs/+MsdA8VArXaaRwRN4oLeNZqMEoS40QVhHXOTqiRdl1wMQhtN4nZAABm0sGJTOz198v8Lxj+VCmkcpGxw0MvHdYZ2r3xBv9UpWpaMi6cZ1y/dUz1GnC5VvQkwKQOYCVMuHz0L65kZ67sxDNACr6IZW50yBAX654zAeu5NgQEL+mawPw8nrO7iSJzum8sqhJ5GS0K7kuVp/TsE4e0rZEt82kKKfCMh/5lhVbV3OcbRkPmumiL+DXUN1GSCDqZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5Jkx1xwKikKUuiifSQqOz0H9zW1YevpPJalxBJBp5A=;
 b=KjvYyAWWvxp/15JU3XG8qNz+InzPqgDeaupA3yjjmWcBQIMX5ovmS86mbpCQ82sgdk+Bw7uhXBihjivBLZgMvCz3SY4Fm90yhgWHOTggFB8539RrO4lwz5enjO1rwElGyMhqx53mmwSYGIHTcSSvrU/yidugLUL76Y3pttY/7nk=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Tue, 19 Sep 2023 14:21:52 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8d) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 14:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 14:21:52 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 09:21:51 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Handle errors from svm validate and map
Date: Tue, 19 Sep 2023 10:21:24 -0400
Message-ID: <20230919142124.15092-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230913151617.18894-1-Philip.Yang@amd.com>
References: <20230913151617.18894-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3e9ac0-757a-4d4d-ad31-08dbb91bc4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNVj6fKTT7JL6Hr+duJqVe2I6kXCMGd+uIrgTeMQB/SbKuEWxW2yugkMgkvszOMyaaGcBSPERYOrRf2RxwSLXR/HUyUIEckXd2RLxsJPg10JNKu+vFl6InjTkk5pT13nUk7obyEBxWv863D79TqRc6MJiGH7Zp5bm08BWxFGn8O/C4g2s+/Yv8lnQ7NuL/zlztr721DxKknsJARDIHFfqFHdoavaO0Amc9J8Kl3fH9l09vJqNsabzpb+cdGQNMXYoMbFPpdttxePgyfY9CMKfJEf8v9pTfCZXBmX4I3KB5deU2790h1Lv3UBsdw+5Pu5i+p63z1JIVs0I2fpYtGNNFtSYopQWQK7hDFcdvc/Ai7zwZCVtjFqJDT4FNzpbrNNXXutDIXmzZps1mtsMacreD5K2thBNJ+Pse0MJP91uhRCXWb6j6gEg+b0C1LS82aN6bScfhulO68PuX+vb6G+kGNF9xE/Ru8oAzBnrdEAF8ztuSmrmgLG8UIO4S4MSHmIS/NFrP/3oYpnDKOKZC2mu9TBbYaIGVv1KXE4gxI1EPbpnO09rWRljYkFYFsNiYiHMR/KuGuZEIemcri96IlIPYu3D/xQtRC5Lp4UTvdjI/VjosLal8fElrZ/BO7rZu7sMDv++wYLqFtmVi/6FlaJxZNMCTLPnIcNFQ2UjSpzu6tM6YA1xz8ub8bWCDKREmODeqHg2qe12z4rLXzcXKpSK64a/udNF4t5ybNpqcE7mTZgHQco8kPjohdZGPZ+fK6EonRArp9D2mFnxNFnGvwg0u4OPEwNwGEuXYdODLOdU/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(478600001)(15650500001)(41300700001)(83380400001)(5660300002)(40480700001)(6666004)(2906002)(70206006)(316002)(70586007)(6916009)(54906003)(8676002)(4326008)(8936002)(7696005)(1076003)(40460700003)(26005)(2616005)(16526019)(426003)(336012)(36860700001)(47076005)(36756003)(356005)(81166007)(86362001)(82740400003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 14:21:52.0328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3e9ac0-757a-4d4d-ad31-08dbb91bc4dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If new range is splited to multiple pranges with max_svm_range_pages
alignment and added to update_list, svm validate and map should keep
going after error to make sure prange->mapped_to_gpu flag is up to date
for the whole range.

svm validate and map update set prange->mapped_to_gpu after mapping to
GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
update mapping case) instead of setting error flag, we can remove
the redundant error flag to simpliy code.

Refactor to remove goto and update prange->mapped_to_gpu flag inside
svm_range_lock, to guarant we always evict queues or unmap from GPUs if
there are invalid ranges.

After svm validate and map return error -EAGIN, the caller retry will
update the mapping for the whole range again.

Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 78 +++++++++++++---------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 50c29fd844fb..4812f4ac5579 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 		}
 	}
 
-	return !prange->is_error_flag;
+	return true;
 }
 
 /**
@@ -1671,7 +1671,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
-	for (addr = start; addr < end && !r; ) {
+	for (addr = start; !r && addr < end; ) {
 		struct hmm_range *hmm_range;
 		struct vm_area_struct *vma;
 		unsigned long next;
@@ -1680,62 +1680,55 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bool readonly;
 
 		vma = vma_lookup(mm, addr);
-		if (!vma) {
+		if (vma) {
+			readonly = !(vma->vm_flags & VM_WRITE);
+
+			next = min(vma->vm_end, end);
+			npages = (next - addr) >> PAGE_SHIFT;
+			WRITE_ONCE(p->svms.faulting_task, current);
+			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+						       readonly, owner, NULL,
+						       &hmm_range);
+			WRITE_ONCE(p->svms.faulting_task, NULL);
+			if (r) {
+				pr_debug("failed %d to get svm range pages\n", r);
+				if (r == -EBUSY)
+					r = -EAGAIN;
+			}
+		} else {
 			r = -EFAULT;
-			goto unreserve_out;
-		}
-		readonly = !(vma->vm_flags & VM_WRITE);
-
-		next = min(vma->vm_end, end);
-		npages = (next - addr) >> PAGE_SHIFT;
-		WRITE_ONCE(p->svms.faulting_task, current);
-		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
-					       readonly, owner, NULL,
-					       &hmm_range);
-		WRITE_ONCE(p->svms.faulting_task, NULL);
-		if (r) {
-			pr_debug("failed %d to get svm range pages\n", r);
-			if (r == -EBUSY)
-				r = -EAGAIN;
-			goto unreserve_out;
 		}
 
-		offset = (addr - start) >> PAGE_SHIFT;
-		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
-				      hmm_range->hmm_pfns);
-		if (r) {
-			pr_debug("failed %d to dma map range\n", r);
-			goto unreserve_out;
+		if (!r) {
+			offset = (addr - start) >> PAGE_SHIFT;
+			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
+					      hmm_range->hmm_pfns);
+			if (r)
+				pr_debug("failed %d to dma map range\n", r);
 		}
 
 		svm_range_lock(prange);
-		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
-			goto unlock_out;
 		}
-		if (!list_empty(&prange->child_list)) {
+
+		if (!r && !list_empty(&prange->child_list)) {
 			pr_debug("range split by unmap in parallel, validate again\n");
 			r = -EAGAIN;
-			goto unlock_out;
 		}
 
-		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-					  ctx->bitmap, wait, flush_tlb);
+		if (!r)
+			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+						  ctx->bitmap, wait, flush_tlb);
 
-unlock_out:
+		prange->mapped_to_gpu = !r;
 		svm_range_unlock(prange);
 
 		addr = next;
 	}
 
-	if (addr == end)
-		prange->mapped_to_gpu = true;
-
-unreserve_out:
 	svm_range_unreserve_bos(ctx);
-
-	prange->is_error_flag = !!r;
 	if (!r)
 		prange->validate_timestamp = ktime_get_boottime();
 
@@ -2104,7 +2097,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node->last, last) + 1;
 
-		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
+		    prange->mapped_to_gpu) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -3517,7 +3511,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct svm_range *next;
 	bool update_mapping = false;
 	bool flush_tlb;
-	int r = 0;
+	int r, ret = 0;
 
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
 		 p->pasid, &p->svms, start, start + size - 1, size);
@@ -3605,7 +3599,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 out_unlock_range:
 		mutex_unlock(&prange->migrate_mutex);
 		if (r)
-			break;
+			ret = r;
 	}
 
 	dynamic_svm_range_dump(svms);
@@ -3618,7 +3612,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
 		 &p->svms, start, start + size - 1, r);
 
-	return r;
+	return ret ? ret : r;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c216c8dd13c6..25f711905738 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -133,7 +133,6 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				mapped_to_gpu;
-	bool				is_error_flag;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
-- 
2.35.1


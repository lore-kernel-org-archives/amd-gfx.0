Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68969C04AAA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9D410E516;
	Wed, 20 Sep 2023 15:47:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2449310E516
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0lbIn8OCVZIYT3sxH9K9wM2Bz84HkYtuB/F95zMIORQSR7Fhcq6svh7/+4gkE5l5JX0G/gvRYh1xBaLhgIo440REmVKlaK8b74ChnxXHPTfsYLkBcQtKxyf7oJ4nV1zzZEDI2vTJQZ8B3nqhCVozJZ69FGrG2qoe3GOh//K8kW7KRVnszx8JknWnrTMHDh49FbKgALA4GXDwn3p4s4y9MhfGJmF16gjNH9TLZlGDSPF9Za9EXm+r2NAU7oXxzu6cWOQSaVa6/JwMLVqr2tgoTvIPH9LAOjIbaNXBY/ljV+j4T+8vGj1toTL0kMKEkInuvrlo9zAkf26qVTDB5S/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy4JLXZlvAdnC7eYMeWxdSuo9C7Bx0MZTkJAS82vPjI=;
 b=NcA8Hi6G9j85VuXcMv/b/2tHVqGEjz3uVCZpv3H/Al1Ft3oJkMrKMf2IvVWzBXnPtghLZ7NFVYDgSbqJ/rNeKbNBa83P60ZVrb/p82jOhoHgl6S/X6hUAjyQgJyOW3ltse8HeUiU+jwv67ljc/xETK+5CYRC9LegSAeMrlXS6AjB7SCYWLM0nWE9h1Ax+9UTQwysrEIS5BiNJF4ngkUM+8idBycvEjlfZp+rj1I+zFCpivJ5X73i2fTYUWOBdpqIc4T+DwayRwNmUNaUHBSS3Ig/DkN5kA2zWbkiNmSawI/BDCedmU7QNjh/47v7XgjKSLOuxyXvuv8PluQQqg5Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy4JLXZlvAdnC7eYMeWxdSuo9C7Bx0MZTkJAS82vPjI=;
 b=gYC68feX7/ltcU1Rl2fcP1iZjR0qyg8I8IV4ac4UTDISgIbwtQFNXAaiDbajpy0G1oIH8j5MvfS/yQvCIv0tWWNS2mmqPDUW7lajmMJE3NHkMTkIje50N7/YRg00WvyTm4fOyLMf5jjkANVq7/7G6LLu0sFyG/qJxUC13e7xnSI=
Received: from BL1P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::18)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 20 Sep
 2023 15:47:23 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b5) by BL1P223CA0013.outlook.office365.com
 (2603:10b6:208:2c4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 15:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 15:47:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 10:47:20 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdkfd: Handle errors from svm validate and map
Date: Wed, 20 Sep 2023 11:45:30 -0400
Message-ID: <20230920154530.18588-1-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: e62501df-6800-4952-8545-08dbb9f0e1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRXUq6/dYC4g9a/VfiNG3n0HKQjhNsfF6G00OQ+c38woRASVDSwFedg0dhWx4wOhLwc1TidmylzfNWWLGCv10ABeVPQ7QCLamPoIAqu8IyjeNhGitO8R9D4UCy3eqDVDyr2Wom0gwg/4jy8l/gkMo4ftm/Dz1wKIGGNT/PJRfIsPG0TPMazy3jJBsLy4SLhz9UY41D/gRhmryNnR9PrP0HB0H8ghWN7fxPQAPzPqVYStHVdekQ9Q0lDZOzbREpqhCCT/vN5w1ZuS9Qvku5ZjwfGgcvz4xX/Ub27M5SBWLPLSMt7CZ/B86Olu+RoG098/tSTWKqmQX9zfjizTQcT4tSt4i+7Nvdui46T6ZcdSeJ2ym+Zt2U8QDnxwqnBATQaXgu1vFXxWUz+B1gBzDqWX3+6RcByIJ4vuz1mryST9S5qqV9jk1MrVyT5WQe8t5YudxzSFmzM+ZLa983QAsaonWOIAZTaU+U0Qy/28iMqGjsjEV2P9QXyS8dHp6j+KAuHLU7EurnCqjh3EorEuhKtfgwbsf1BD5msagKMp5Mc99jmri7sgQ4hB9/5TKdpjgq+qhjWzp2ou4KGv3H+WDDqHK5DMsrRz9bfTGJhh53o+48nB0BEYCz0yj6e8gxBG4bCpUNiGN/W8nqGGto/61gi9lTI36/OkTNfhMi8Bs7ZbHskOtWzOztLWOmBUV8U0G2/sowCPRn0sWC/BHa4cROfapVFQxTrVbWcZoevGRDtPdu+/t+1YRcwdJUB+CX+zpkH0pAqwDfFkDRQV8P5OEak4vltKfngEMn/CMQ+/c60XbnQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(15650500001)(2906002)(5660300002)(8936002)(8676002)(1076003)(26005)(41300700001)(40480700001)(6916009)(316002)(70586007)(54906003)(70206006)(4326008)(16526019)(478600001)(6666004)(336012)(36756003)(2616005)(83380400001)(40460700003)(47076005)(36860700001)(356005)(81166007)(82740400003)(86362001)(7696005)(426003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:47:23.2123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62501df-6800-4952-8545-08dbb9f0e1ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 80 +++++++++++++---------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fb55cf80d74e..0b6a70171320 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -827,7 +827,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 		}
 	}
 
-	return !prange->is_error_flag;
+	return true;
 }
 
 /**
@@ -1680,7 +1680,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
-	for (addr = start; addr < end && !r; ) {
+	for (addr = start; !r && addr < end; ) {
 		struct hmm_range *hmm_range;
 		struct vm_area_struct *vma;
 		unsigned long next;
@@ -1689,62 +1689,57 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
+
+		if (!r && next == end)
+			prange->mapped_to_gpu = true;
 
-unlock_out:
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
 
@@ -2113,7 +2108,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node->last, last) + 1;
 
-		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
+		    prange->mapped_to_gpu) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -3526,7 +3522,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct svm_range *next;
 	bool update_mapping = false;
 	bool flush_tlb;
-	int r = 0;
+	int r, ret = 0;
 
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
 		 p->pasid, &p->svms, start, start + size - 1, size);
@@ -3614,7 +3610,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 out_unlock_range:
 		mutex_unlock(&prange->migrate_mutex);
 		if (r)
-			break;
+			ret = r;
 	}
 
 	dynamic_svm_range_dump(svms);
@@ -3627,7 +3623,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
 		 &p->svms, start, start + size - 1, r);
 
-	return r;
+	return ret ? ret : r;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 5fd958a97a28..c528df1d0ba2 100644
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


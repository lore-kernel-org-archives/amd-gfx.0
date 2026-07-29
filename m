Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7A6C53219
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 16:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4B210E059;
	Wed, 29 Jul 2026 16:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FiFXM2xM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677F310E059
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 16:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHr6YNF64kat77Ooc/CmuJeltZJogRwhSd/AYFN/jB6Lk9muilkK55jjS5QHrB1sY0qiWpeMuzZxNC3JX0XWc55vY10rfLrkMGVYr1Cs9BP3p3xkVRfQZihBLaYbHY1+qIJosc6oQ5pubDzWvFwos1PO0zpM5Elvksk+DeXaeIctqbQaDKIZBNUjnB/e1o3Tt4yLSqvpOqgnNwcBbhBF/lqnACzkElpsJHDhBeE0o6XdVuvrBQplylBPl6bIER8YC8/dpddn+cBLgE+Oe8Z3YBmMBuAv0Z+1NWi8/ZYR7fly3vgbXvgtUwh112S/uZ9ZFNr7r9xjvDvrjvIt3HN37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsvY3J5Ba+UqLG7esYVfaH09Z/octH77lgEBJRVjhSI=;
 b=iCi6jSjfgcFk4kzmTCzllbJ3gdvZFgmjU8UD5keLZaIUwDEyiOLJxjZavNxiTv7TehpRr6O6Oc/ZhvX9Ts3qLXGs1YzRuVv/tsK9ZiJS0SHtg/RTEI7knkHQU7L09AaUgaAvpFIQ3J12A/7PIweXTXDwEXy1p3Od82L+FwvBKvDzLx+BbdvPP+yfvFvwfgV2Qax+oF/B7pjcm/a8SdVLvQSXVR6fcxMpNt8b7//96qlPMn5gx03nevDJ4VaHbzcFPvebhVXDgq4Jg8yaKF/dRDvbl4J/hK6tlaAvGhn+4Qkrh4H8BThRgi2sC0OPAyOBd+P5Rx+0lhhRXANWgXTLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsvY3J5Ba+UqLG7esYVfaH09Z/octH77lgEBJRVjhSI=;
 b=FiFXM2xMP4M0dFKkNez/8H8uSYfdGFO0t4pHh/E+twm5K8g5nZGhNzckwpHn0f2NhudyaITfwlYpN/WdVoVogBRMUvvLtlI6gZz6wlm6ssn5ZJw53IGVFb3EwWJBnEo+X/afaMDbOUn7IPxPrAR/UOtTcuDsEnTXsctUGjt8iNY=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 16:36:05 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::97) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 16:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 16:36:04 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 11:36:03 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v3 1/2] drm/amdkfd: Add helper
 svm_range_update_checkpoint_timestamp
Date: Wed, 29 Jul 2026 12:35:37 -0400
Message-ID: <20260729163538.229530-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729163538.229530-1-Philip.Yang@amd.com>
References: <20260729163538.229530-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 4291dbe2-513e-4d1b-bd8d-08deed8f7c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cdzF1d4PAS4q9Qw2iVjVRLD2e5Pvs2yjWXldvNOmRKqhMNBo1MPldTRAxlC6OEfI8Da/4ifxUaIyV4w/JshcvjVt1AQcijdidlmdmv+WGhEGd0eirghl9y0rsu2SoOWp8+o8GzL9IluN/K7yS2rc38hsES+5E4W0GutJGcwMgWlHUCmAwUwjB0kM3plXHFCmFGa9GvZwFu5qgnU8iQ9BeSdA+iMA7JvJJfKm6lavrgG9ieLa+2BdkjSZQV/ihg6QnxcUkffMieq0z6LcQi85pbGYYrXXHiw/PoyRgKebG1N1ukrlIVC3O3tcnjF4TzENA6YiglstYDFKnJBBs2DxrMAw6ZoX9goX43mC0LqDyh4/uYOuiyGhH7DvJ03Cgp8f15a4AAmjIj0PNoFNOH5nJYhE46tVHKNUOim8dZJOmv/f951lmJlg27gwDIiQ4riYHWMQLm7U4g3pBK/gXfM1xvY42ohtZpfyDj6b0imeSBca79ZzKwSh2QgxC8Iele0PDyLhszzf4b6XbXUELzfbOUvIX/KUHXDGJ5RNQwmxgARNrREsNPcasNmzn/U5+x148WZyxSrnpkdPfpxcYKgpgskKRYi3Ck7KskNniwNOHbenrTOrmfpH9Nd9Q660lrabAPSEB4NTp9Ouo2T6GjXG0ZHy+rjh+wosMmV8SqZXL6uZRvvfBZlmHTECrKvsQyTM7cNzRQXoypXLeT+GcZckFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TLnDpqaewlD2h75YuQ2FTcPxr9hhBsQbTgNIA8E+AphZkYJU6W9M3PlZUriNxvIg3H4egQRjK2H6c34KnzvSvyHB7pPWYTA5cW8zX7/s8DGh/27f3mq3SMRrmeUS+FPRWbzXxxLSqubgfLgbLaWweieES5Ex/otJqXQ2KkNJ9k/e0J6xKkLrHF3EbPagfUBBS3HV2va0z4xtpGzPui6REBxL9ThnhPRe69qm6GdCkUw6FA0CA2f1mv9YWtOU8GLw6H72xa7w3xEuNH4w69DbCXR8Vb/xJNzom4vQEgTrtb1ejUqeGpFtQ9v/PwllHxpnAGdxnefQ7Ta8xuS1FnOSmIr7KQiuFu9M5/ZDMppG6vuMzT6E0xcArmtZPjH0UqL0wx+E4FHWYhR/WPTDqvWtajNPm1z4EKhKPze9JYmOdk1hcWo3YTBX2KEnc7g7cl57
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 16:36:04.9101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4291dbe2-513e-4d1b-bd8d-08deed8f7c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
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

Extract svm_range_update_checkpoint_timestamp() from
svm_range_unmap_from_cpu(). The next patch calls it when the app sets
the no-access attribute.

Change checkpoint_ts in svm_range_list from uint64_t to atomic64_t so
svm_range_restore_pages() can read it from the page fault handler
without holding the svms lock.

No functional change, preparation for the next patch.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 85 +++++++++++++++------------
 2 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 88191a4c1657..bcb929002839 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -895,7 +895,7 @@ struct svm_range_list {
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
-	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
+	atomic64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 
 	/* Default granularity to use in buffer migration
 	 * and restoration of backing memory while handling
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4c6700c6e88d..34de59f0432d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -768,6 +768,48 @@ svm_range_check_attr(struct kfd_process *p,
 	return 0;
 }
 
+static void svm_range_update_checkpoint_timestamp(struct kfd_process *p)
+{
+	struct svm_range_list *svms;
+	int i;
+
+	svms = &p->svms;
+
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
+	 */
+	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+
+		pdd = p->pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd->dev->adev;
+
+		/* Check and drain ih1 ring if cam not available */
+		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
+			ih = &adev->irq.ih1;
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			if (ih->rptr != checkpoint_wptr) {
+				atomic64_set(&svms->checkpoint_ts[i],
+					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+				continue;
+			}
+		}
+
+		/* check if dev->irq.ih_soft is not empty */
+		ih = &adev->irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr)
+			atomic64_set(&svms->checkpoint_ts[i],
+				     amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+	}
+}
+
 static void
 svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
@@ -2565,7 +2607,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
-	uint32_t i;
 
 	if (atomic_read(&prange->queue_refcount)) {
 		int r;
@@ -2585,38 +2626,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
-	/* calculate time stamps that are used to decide which page faults need be
-	 * dropped or handled before unmap pages from gpu vm
-	 */
-	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
-		struct kfd_process_device *pdd;
-		struct amdgpu_device *adev;
-		struct amdgpu_ih_ring *ih;
-		uint32_t checkpoint_wptr;
-
-		pdd = p->pdds[i];
-		if (!pdd)
-			continue;
-
-		adev = pdd->dev->adev;
-
-		/* Check and drain ih1 ring if cam not available */
-		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
-			ih = &adev->irq.ih1;
-			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-			if (ih->rptr != checkpoint_wptr) {
-				svms->checkpoint_ts[i] =
-					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-				continue;
-			}
-		}
-
-		/* check if dev->irq.ih_soft is not empty */
-		ih = &adev->irq.ih_soft;
-		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-		if (ih->rptr != checkpoint_wptr)
-			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-	}
+	svm_range_update_checkpoint_timestamp(p);
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -3063,6 +3073,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct svm_range *prange;
 	struct kfd_process *p;
 	ktime_t timestamp = ktime_get_boottime();
+	uint64_t checkpoint_ts;
 	struct kfd_node *node;
 	int32_t best_loc;
 	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
@@ -3125,9 +3136,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 retry_write_locked:
 	mutex_lock(&svms->lock);
 
+	checkpoint_ts = atomic64_read(&svms->checkpoint_ts[gpuidx]);
+
 	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
+	if (checkpoint_ts) {
+		if (amdgpu_ih_ts_after_or_equal(ts, checkpoint_ts)) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 			if (write_locked)
 				mmap_write_downgrade(mm);
@@ -3137,7 +3150,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
 			 * to zero to avoid following ts wrap around give wrong comparing
 			 */
-			svms->checkpoint_ts[gpuidx] = 0;
+			atomic64_set(&svms->checkpoint_ts[gpuidx], 0);
 		}
 	}
 
-- 
2.50.1


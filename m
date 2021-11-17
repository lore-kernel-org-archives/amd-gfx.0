Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF51CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6692D613C8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6692D613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142216E1BD;
	Wed, 17 Nov 2021 03:43:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D805C6E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 03:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akuxq4BZDxWMvN9z7adOoEFjAyqE0D2Yq+oHurJ0zdtAwVHbbqf9fFMJYesgO43/FgOPBvdiWZxiQxYtJBT2wcMvmhhqtF2p8jOL77KtiL8bF+6vjKkNySFb2z4KErJ5ID5WLyFz4C49+hkvOT4QrHe+XFiKXAH/vOgzkBf9ACSrn6GBTESGz6TQM7o3Zjn+l6QPDM/NDTD7fZ16wVr6ahn/eYBheX/c7vbfaeRMldkF7Bg6mfISJ3EZ/L/pEICG9U1i/GqG20ixdNOQWdsjffuDE+Ihox3ujgwY/EviAC7nq83gb69eP4uPar6sXgGrRUu72fnWpDpyq+HTz0L3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM6uHoSE6V9uPtK/XHRJXHrsU/7nRkS2SLjk5yjeX+Y=;
 b=X3XnYkL/6WpTwK+rCCkOtf3U/B3ihIkTJcQJPxF4xDN5O4A0iPVAVU6wGcxGxud7aDdUXNhr8rIfne7QJcIR91f+CvintrdcNqEp+Dptnapnx2lKCMwymQzNf+YYbYmGAqDRpeu/3bKGwKuc3ND9d8EVNfaUtq2j3fgM/V0GhiiLaUtG9p3/X3youd+Ydf+KGz8N7MbJtZpFIviLEhFCqiNbA3ukXsSHGV/EK0v8WXWDUVTGV54XbL7+2p6/atc4rOfuuae/orU2H41VsF55MsllYoJItSiKJ51gV3pXO9p4x9pWWKtArCkNKHFHcuQ51VEnSZHHy7nIdWEWKBSv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM6uHoSE6V9uPtK/XHRJXHrsU/7nRkS2SLjk5yjeX+Y=;
 b=t3ZLZ338uODmCyJxiTr7/4z3Q/rR+sPHyKhkF/bJ0A2/aaFSDKnC8MIpD9E+JFzSTfJ0uVjPtRAqdAtz0L81ihkVbkOMRggs8XKpRoXLaBqNLFhA9j6yaZ6ZKnvqEPdjAjQkCnCylcab0itx3PJvUp+LqF6vax1gdRIVO400lms=
Received: from BN6PR13CA0067.namprd13.prod.outlook.com (2603:10b6:404:11::29)
 by MWHPR12MB1807.namprd12.prod.outlook.com (2603:10b6:300:113::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Wed, 17 Nov
 2021 03:43:43 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::99) by BN6PR13CA0067.outlook.office365.com
 (2603:10b6:404:11::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend
 Transport; Wed, 17 Nov 2021 03:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 17 Nov 2021 03:43:43 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 21:43:42 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: simplify drain retry fault
Date: Tue, 16 Nov 2021 22:43:24 -0500
Message-ID: <20211117034324.4663-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117034324.4663-1-Philip.Yang@amd.com>
References: <20211117034324.4663-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7de899a-0834-425e-56a2-08d9a97c7411
X-MS-TrafficTypeDiagnostic: MWHPR12MB1807:
X-Microsoft-Antispam-PRVS: <MWHPR12MB180757CDED38F8B6040B51EFE69A9@MWHPR12MB1807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMevHGcoQ/FkjgYdjf8rvqvn9rxqdkHKZe6WuC3Lb0dy3MXQUzfmfY8Csb09GO2YuSyJcQvhBhxBQAbEzRtOKu68dNsPpIJoQd5XtHXV6csFvAQoWmmdolVXcCgeYKMPb2ASzjeHckXVFztU0qOhasMjtcG4/jAwZhUx3d624xfh1VbYimKbkgfDhBYWeD7CmvLpKYiI4vFlcMpoPu4gUn+6aXhglA9GvicmdNlA6uF2OVdBRf2jT0hX8QB6ML8LZ6gZzXOQI69XkK38Hm91mofV9bMLD8IWZPAsU2yA95zRieslf5hBhLfq0rjtGZ4LFo/gNgIBI1/OiSi5floMYb2mr0BL/An3RKAFYGOi1ydLBC0aMfxasTqVpAq28Vkzv4HcC6iVB5YPGbT2dE+mBDfNy6p4JjWTzmXhEiw9sCKAC+ShBYT/UifwJHkP6RWJG4fLyrHTQ2C9L4OdMW9ReXB1fLdjesWk8Mc2uZTLg1HXF6CGoE5F3OTTud5m2xW8cCvv2VSjm1nFiLfKY8etmHLlmb3rbyIubo21SjWSWRT8Uh0ObKHP9mFKqcZpGWu5octZLqgde6MQBIdGsVPQWNoud/0NjEcovLKrIErFQq27b2xh7/SrOk68GfAL66icZYGBupWBfdKOLBFoY5nCg7pmurspmXMeeR+DndOVMeAEqnK/Tiq4YjLzCzRTw3pDtI8zsyeLDNNvtHp87rkLLJHrxHFBI9I+amSSG+If5LI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(2616005)(336012)(316002)(36860700001)(356005)(82310400003)(6666004)(86362001)(5660300002)(4326008)(6916009)(508600001)(47076005)(7696005)(2906002)(8676002)(36756003)(8936002)(83380400001)(26005)(54906003)(186003)(16526019)(70586007)(81166007)(70206006)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:43:43.7518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7de899a-0834-425e-56a2-08d9a97c7411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1807
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

unmap range always set svms->drain_pagefaults flag to simplify both
parent range and child range unmap. Deferred list work takes mmap write
lock to read and clear svms->drain_pagefaults, to serialize with unmap
callback.

Add atomic flag svms->draining_faults, if svms->draining_faults is set,
page fault handle ignore the retry fault, to speed up interrupt handling.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1d3f012bcd2a..4e4640b731e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -767,6 +767,7 @@ struct svm_range_list {
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
 	bool				drain_pagefaults;
+	atomic_t			draining_faults;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct 		*faulting_task;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3eb0a9491755..d332462bf9d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1962,6 +1962,7 @@ void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 	p = container_of(svms, struct kfd_process, svms);
 
+	atomic_set(&svms->draining_faults, 1);
 	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
 		pdd = p->pdds[i];
 		if (!pdd)
@@ -1975,6 +1976,7 @@ void svm_range_drain_retry_fault(struct svm_range_list *svms)
 		flush_work(&adev->irq.ih1_work);
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
+	atomic_set(&svms->draining_faults, 0);
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2002,6 +2004,7 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 	 * mmap write lock to serialize with munmap notifiers.
 	 */
 	if (unlikely(READ_ONCE(svms->drain_pagefaults))) {
+		atomic_set(&svms->draining_faults, 1);
 		WRITE_ONCE(svms->drain_pagefaults, false);
 		mmap_write_unlock(mm);
 		svm_range_drain_retry_fault(svms);
@@ -2049,12 +2052,6 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 			struct mm_struct *mm, enum svm_work_list_ops op)
 {
 	spin_lock(&svms->deferred_list_lock);
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing "phantom faults".
-	 */
-	if (op == SVM_OP_UNMAP_RANGE)
-		svms->drain_pagefaults = true;
 	/* if prange is on the deferred list */
 	if (!list_empty(&prange->deferred_list)) {
 		pr_debug("update exist prange 0x%p work op %d\n", prange, op);
@@ -2133,6 +2130,13 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
+	/* Make sure pending page faults are drained in the deferred worker
+	 * before the range is freed to avoid straggler interrupts on
+	 * unmapped memory causing "phantom faults".
+	 */
+	pr_debug("set range drain_pagefaults true\n");
+	WRITE_ONCE(svms->drain_pagefaults, true);
+
 	unmap_parent = start <= prange->start && last >= prange->last;
 
 	list_for_each_entry(pchild, &prange->child_list, child_list) {
@@ -2595,6 +2599,13 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mm = p->mm;
 	mmap_write_lock(mm);
 
+	if (!!atomic_read(&svms->draining_faults) ||
+	    READ_ONCE(svms->drain_pagefaults)) {
+		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+		mmap_write_downgrade(mm);
+		goto out_unlock_mm;
+	}
+
 	vma = find_vma(p->mm, addr << PAGE_SHIFT);
 	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
 		pr_debug("VMA not found for address 0x%llx\n", addr);
@@ -2732,6 +2743,7 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&svms->lock);
 	INIT_LIST_HEAD(&svms->list);
 	atomic_set(&svms->evicted_ranges, 0);
+	atomic_set(&svms->draining_faults, 0);
 	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
 	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&svms->deferred_range_list);
-- 
2.17.1


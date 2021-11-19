Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF86AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 22:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648B56E210;
	Fri, 19 Nov 2021 22:30:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3D96E219
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 22:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFcJjyzdq/3YgN490O5kGyP/SVHRypffpIBcpujkd2EKJ//Mmlv8g2aDM4wNp7yvzqhDi9qUSmAtPt9Z8Zee7kQOVH1sqZt7lupF/ZskHCvu/pzlHfHe5jkNygEfsdWCyeqHUJTrWR/fmyP8DscQ0u0M6TFgx1F9Lm55/nDEVEBA6vbNzwiUZnRQ5zX5TXNIxVoiE18uLDkd2bzh8C3NtcXNC2/RzM508QB331H1LTmaf8z21qwQQR+IIA39eEyZ7Xot0AW2nzxHqPxrNesrrufsJ4tXRSytgKtX5pvOVMIBiasFqmnKb/fS8PSM3I3pXNfsq+HWeKqrpGAZAq76SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFder+MCcbhYSMsVHfOc2xQ+OEt9bpsOw9Q6LnBh0TE=;
 b=ByC44XNws0zNl9pZWJDioAPd2p/7+6rnLpc3tK0bjHu8TJbkscWr83ykn6Vw6l2lSIiEEWZ+kRrcA5STu7EvkF2zjyQCwADJzCdeAO+8y2+7wKNSXIevoAsWs+lznTucy05QTd0WTIfsTid5Xt21dqIxKtmL8N/MODRZr+bu6FCPLeoAW/ybXZ6rdfySMvsJQDiLK9tLdtm4/3TTw6S6oIBBeYRT+eI7I855WxwqIC4RRJstdyTWYCxL0t3y2Jvx8/IfOdoQpU+cSV7X1tqbGz9uZhBuWwmVOIkfcfLOwDMyphrcd0CuN6ZgIrZD4lk84W1f0XyVKnYyxRJIg3pTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFder+MCcbhYSMsVHfOc2xQ+OEt9bpsOw9Q6LnBh0TE=;
 b=CMChjjw1EcX4eUBeM9ppwtO6SdBlMIV258iAKGGNO0poqtd3fraR/r53F9dv/NNifcOAEErxkqBqJoubG8noldn6pqBsPMQO5RgwtHwxESxfL3VqNwbAS45aBrJ03p9s/7IzOuQ3IO2VKHC4H3EVVyJpSm3DcxNUCJanbiGIMT8=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 22:30:12 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::dc) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 22:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 22:30:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 16:30:09 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdkfd: simplify drain retry fault
Date: Fri, 19 Nov 2021 17:29:41 -0500
Message-ID: <20211119222941.18053-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119222941.18053-1-Philip.Yang@amd.com>
References: <20211119222941.18053-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8cec824-0abb-4f09-4188-08d9abac2666
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4965BE1461D8129C8765C31AE69C9@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwFabeC5PyiIZLl+Eu0ygMlAm4tIB59bj8W+q+w3X6w0AE2v4UFrJTjJXPsQnCuL/OzMS3QbgvmuSdr064sOgaDY15x+hfxImjDKqc8pUt7+teT10DEDDlf8k7Ozlkl6H9VXU3to/+qFPrrFTaOwofJKYdnRzjw13Ac8zAvQFC9u9IdSC/yfuAnHRQLq0ZsBTCp75wrH6lRvFhFwMC4LwH8UzTsJZLE1rn02PicOBoiL7YA/islwhj92t/mzkT6ItDwa4+NNrr+Okkv7UUy+LfFRZnufmBAa8MxWukAxxayLmRpcZ5kh+RBwBUQxZ8QsJQXShBclY7ad889/HhKwOYGAtXIs9RCY+Nbxsp4IJEIsKutm029Qsy2MgxZ0BG/FE3naZYqPKCvkXs5LPWq/pgTW5BTjaYJEv0vx2Ob4rhWdXMNuP/yR8PhxroWTsFVAq+sJQYxHaDZEHNiopbE/6P/cx0Zb1HPAU2avuqLw/O3BPsEm7e/XBiIQz3yhzW9Ay+vLL8UfDlDQrXHk7PRL6iKUhdDKQK5AVvHU9YUvnqPoYZHH3Nzhcm2DA/HvfBkYlE8gt/3QLP/+6eXkH+QdZzFEzZ70rIAdo5uocMkqZNy+Xac7woDrit3fO5ckWR7JiYvby3SZjHAUUQkGlyTX6eTy9mhKZhqE5j2jqDdzVWjrVf8GZ4gTctkSxDRChGD/HkombEkf2+mlACOmAqRawwni8Y1Waa6sVr5e+uGBho8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(8676002)(70206006)(70586007)(36860700001)(186003)(8936002)(7696005)(6666004)(356005)(16526019)(47076005)(83380400001)(82310400003)(1076003)(2616005)(5660300002)(4326008)(508600001)(426003)(2906002)(6916009)(336012)(81166007)(86362001)(54906003)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:30:11.6156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cec824-0abb-4f09-4188-08d9abac2666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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

unmap range always increase atomic svms->drain_pagefaults to simplify
both parent range and child range unmap, page fault handle ignores the
retry fault if svms->drain_pagefaults is set to speed up interrupt
handling. svm_range_drain_retry_fault restart draining if another
range unmap from cpu.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 30 ++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 836ec8860c1b..7ea528941951 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -767,7 +767,7 @@ struct svm_range_list {
 	struct list_head		deferred_range_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	bool				drain_pagefaults;
+	atomic_t			drain_pagefaults;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct 		*faulting_task;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 65daae9e4042..99f38ffbf43b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1957,10 +1957,16 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
+	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
+restart:
+	drain = atomic_read(&svms->drain_pagefaults);
+	if (!drain)
+		return;
+
 	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
 		pdd = p->pdds[i];
 		if (!pdd)
@@ -1972,6 +1978,8 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 						     &pdd->dev->adev->irq.ih1);
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
+	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
+		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -1997,8 +2005,7 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 	/* Checking for the need to drain retry faults must be inside
 	 * mmap write lock to serialize with munmap notifiers.
 	 */
-	if (unlikely(READ_ONCE(svms->drain_pagefaults))) {
-		WRITE_ONCE(svms->drain_pagefaults, false);
+	if (unlikely(atomic_read(&svms->drain_pagefaults))) {
 		mmap_write_unlock(mm);
 		svm_range_drain_retry_fault(svms);
 		goto retry;
@@ -2045,12 +2052,6 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
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
@@ -2129,6 +2130,12 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
+	/* Make sure pending page faults are drained in the deferred worker
+	 * before the range is freed to avoid straggler interrupts on
+	 * unmapped memory causing "phantom faults".
+	 */
+	atomic_inc(&svms->drain_pagefaults);
+
 	unmap_parent = start <= prange->start && last >= prange->last;
 
 	list_for_each_entry(pchild, &prange->child_list, child_list) {
@@ -2594,6 +2601,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
+	if (atomic_read(&svms->drain_pagefaults)) {
+		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+		goto out;
+	}
+
 	/* p->lead_thread is available as kfd_process_wq_release flush the work
 	 * before releasing task ref.
 	 */
@@ -2740,6 +2752,7 @@ void svm_range_list_fini(struct kfd_process *p)
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
 	 */
+	atomic_inc(&p->svms.drain_pagefaults);
 	svm_range_drain_retry_fault(&p->svms);
 
 
@@ -2763,6 +2776,7 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&svms->lock);
 	INIT_LIST_HEAD(&svms->list);
 	atomic_set(&svms->evicted_ranges, 0);
+	atomic_set(&svms->drain_pagefaults, 0);
 	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
 	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&svms->deferred_range_list);
-- 
2.17.1


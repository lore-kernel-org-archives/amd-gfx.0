Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C364EC25B46
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 20:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD2510E253;
	Mon, 23 Oct 2023 20:38:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE3F10E253
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 20:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpCgpUuU+aCVvmM0f0hFr9ywk3Mt3U6Q222GnS9Aa5vy8RB9Y3dqRa+7Rud1UdT6iWznjoQkxjBYWRW0LF4q6ufl5rAxVqdgeSu+Vidyd1UY/93o0U+xPZs6rPl0Ur8I3PJLQ7w6e2hvJlfAV3PA11bVo7RokH76OLREVvG0PE8HocmWL9qwnNvJQOLCt9Q2l8aKJi/ry5IzHu+FA1PjHVgfSsPrTOfRrw0CMOWFi3wN4L739PGbRTSUvzC9gI0XtVZpZIxrmiMgBMHvVFokJZv33p6VxL9keLQA1uP6qzbRj+ebHcUN/CsbSPELwjc+dh5IjcE8IxHaLYmt1cT3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTqDPInTMQr0y4Zn75ksztOjZD1MMKz776s4NBXo6o0=;
 b=Og0QLWsRWQKaCIHLWvqQpyfUpr4kyTkjkQEmTekVvRJFO6vt8UrQiqfjdCvrfAOATSNeHChcsUa0DzlytCiPZaWu9FOdzDLzjrjjpiwnbpJNZvV/RZBiFveIYca2uVoE4RFbwY33cG0eQFPZMrkLsKj7TPodreZz4Wz9CwQxgwTMMlFGmeDASKAEZLIXSl4QA5O+306X8PWxkmo87+vMVmLjqMX062YJqsIC7JqlMiG7VGpkJwAwVdFlr7wykT+IeQOvylzB1gn8fQHckdbggcrjy1weJOGxJdDrW4m39iuj16wyipiextWxJu1G8sTKuDK2MKD4cCjloEJsnGJY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTqDPInTMQr0y4Zn75ksztOjZD1MMKz776s4NBXo6o0=;
 b=oaQDCWXT/2sqk5H0CM8io8MSJzuRi6bmJvr/ng85FWe+ZIXOqzK4YLDxNnqtmF94/nJVh0a92GxdFg+kmAXp9al9e26imSYKEzqBHXTb7Rxg9Glivw/dVL5scIGcKnGxVj2gvoLQhUvzLz2Xz2iSUIFKKTa9zP3y2wh9Z1QO8uU=
Received: from SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 23 Oct
 2023 20:38:26 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::66) by SJ0PR03CA0208.outlook.office365.com
 (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 20:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 20:38:25 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 15:38:15 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdkfd: Use partial mapping in GPU page fault
 recovery"
Date: Mon, 23 Oct 2023 16:37:01 -0400
Message-ID: <20231023203703.31664-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 490584fc-b9b4-489f-6d8e-08dbd40801e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NU6WgbVgnzkhBNrfnly12w0ByH1RLy6w99AeYayzVpnnxdHvQPOrEz6YbCe98czhnqeGCL77q8mDzlC6UryAahxtgnaSyx0ftlvYkP8qqY7Fu25D2K3rngMXPvXkTycd9ieYv6LcAoFyTkNa+nw3NkXrKLQfkwi4o+srOY1aSs3xoHNtRlt/2T/JZeKu4j04Hiq2nFN0R1nX/v92wl+sHzXr6eLSKEpqnTHuk6/hhXz1NZ1S/1MsCAcnH6VxX+diYYBLz9txk+1M/Lyd6Q1ez8J+QEv3RrM21z1AiDzhOBayMUWG0rHT+5zyS5d078oGt+3pSH7cpQTQy6Jw1LTBtRUTuMR/08k7XNIypN5kO4HLngMxkmXyQYQd8JZ2dbnmPhXD1x1vdg+uiSZ+p7c3vluVMjRRNm7phcHuhXSszp4vuhKGgk7V283J+v0Xp04MCRakT3kOFSjUsPiltETeklRTd0TgjiTSW6+llbU5LpAhx5VzI0fCVoI8H8q6pDBiy5XmQoscM+5zwrXkUkfyrShDtWPGdHoR+80HTPQFPSZib4sF49Q9lVQXNO2fndGsWeUP7bLS+0iOryr0FXgVH3khlCMqTv0mHU5OvwFzbLG4d04VD8ljsc1dfMu4KHvz9EgGVJEV5VfrBFIFTG0jJORXtg+zvZupCfuh8QvHHz5u/LeerTn1j7fSCkvQMKuwdWV5bf22wxAS4Np5vNkncTQrj9n4HQTgRRufvAwuce1E60w9YrLlUoehYFL1c4+tt9ydApHf7s786VOdW5hTxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(336012)(2906002)(5660300002)(41300700001)(8936002)(4326008)(8676002)(26005)(316002)(54906003)(6916009)(40460700003)(70206006)(70586007)(36756003)(40480700001)(7696005)(478600001)(6666004)(81166007)(1076003)(83380400001)(16526019)(86362001)(36860700001)(426003)(82740400003)(2616005)(47076005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 20:38:25.8003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490584fc-b9b4-489f-6d8e-08dbd40801e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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

This reverts commit c45c3bc930bf60e7658f87c519a40f77513b96aa.

Found KFDSVMEvict test regression on vega10, kernel BUG backtrace:

[  135.365083] amdgpu: Migration failed during eviction
[  135.365090] ------------[ cut here ]------------
[  135.365097] This was not the last reference
[  135.365122] WARNING: CPU: 5 PID: 1998 at
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:3515
svm_range_evict_svm_bo_worker+0x21c/0x390 [amdgpu]
[  135.365836]  svm_range_evict_svm_bo_worker+0x21c/0x390 [amdgpu]
[  135.366249]  process_one_work+0x298/0x590
[  135.366256]  worker_thread+0x3d/0x3d0
......
[  135.721257] kernel BUG at include/linux/swapops.h:472!
[  135.721537] Call Trace:
[  135.721540]  <TASK>
[  135.721592]  hmm_vma_walk_pmd+0x5c8/0x780
[  135.721598]  walk_pgd_range+0x3bc/0x7c0
[  135.721604]  __walk_page_range+0x1ec/0x200
[  135.721609]  walk_page_range+0x119/0x1a0
[  135.721613]  hmm_range_fault+0x5d/0xb0
[  135.721617]  amdgpu_hmm_range_get_pages+0x159/0x240 [amdgpu]
[  135.721820]  svm_range_validate_and_map+0x57f/0x16c0 [amdgpu]
[  135.722411]  svm_range_restore_pages+0xcd8/0x1150 [amdgpu]
[  135.722613]  amdgpu_vm_handle_fault+0xc2/0x360 [amdgpu]
[  135.722777]  gmc_v9_0_process_interrupt+0x255/0x670 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 +++++++++-------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2b33fb2afcf..4d000c63cde8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1565,7 +1565,6 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
-				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
@@ -1646,8 +1645,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	end = (prange->last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
 		struct hmm_range *hmm_range;
-		unsigned long map_start_vma;
-		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
 		uint64_t vram_pages_vma;
 		unsigned long next = 0;
@@ -1696,16 +1693,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 
-		if (!r) {
-			map_start_vma = max(map_start, prange->start + offset);
-			map_last_vma = min(map_last, prange->start + offset + npages - 1);
-			if (map_start_vma <= map_last_vma) {
-				offset = map_start_vma - prange->start;
-				npages = map_last_vma - map_start_vma + 1;
-				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-							  ctx->bitmap, wait, flush_tlb);
-			}
-		}
+		if (!r)
+			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+						  ctx->bitmap, wait, flush_tlb);
 
 		if (!r && next == end)
 			prange->mapped_to_gpu = true;
@@ -1811,8 +1801,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&prange->migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, false, true, false);
+		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+					       false, true, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -3026,8 +3016,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
-	start = prange->start;
-	last = prange->last;
 	if (prange->actual_loc != 0 || best_loc != 0) {
 		migration = true;
 		/* Align migration range start and size to granularity size */
@@ -3061,11 +3049,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
-				       false, false);
+	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
-			 r, svms, start, last);
+			 r, svms, prange->start, prange->last);
 
 	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
 				     migration);
@@ -3611,8 +3598,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, true, true, flush_tlb);
+		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+					       true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
 
@@ -3626,8 +3613,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
 			 prange, prange->start, prange->last);
 		mutex_lock(&prange->migrate_mutex);
-		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, true, true, prange->mapped_to_gpu);
+		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+					       true, true, prange->mapped_to_gpu);
 		if (r)
 			pr_debug("failed %d on remap svm range\n", r);
 		mutex_unlock(&prange->migrate_mutex);
-- 
2.35.1


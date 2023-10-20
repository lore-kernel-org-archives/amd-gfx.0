Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC37EC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 21:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FFA10E5F5;
	Fri, 20 Oct 2023 21:53:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A59710E5F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 21:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihj/iA5bRA4IwLWWMmr3Xep9ajNXETEPtv26pVEzxCFaN7Hko8IAppY9xLM5PA7y1KvjaUGSh9/1sv7yBxqwd4VM0vFD8hIEQ/N59SpAggywlznc8R2KlsSWa3V8x/588+ZxuEeIaoSvft0IH8l2//pkCdDDOLY7KymaX01HYaSH1LOi+wSEC2WKCEyBVsCT+q73b7yrooDP4C9U+rXdhD7ssE7uSpL6uhXtCDGu7TXwCRAyf4PYz7F80j79ZfzSbkWRH6lSrsv9OnfK7WKf5IvQAm6vausv4zmnFOj00se/z2b8zbu81RV4HIIGykZowTuaZbV1Ua+oS1RRsvQZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkDIkWHCah9YlwnlVWZiUeVod+3G99jxUXzHG0zXzHI=;
 b=hlzUjKrnPWo9knqt68butBEJXGDQ0Bjs9sYLR4IX2OxESO3fctA0wFwIKOF8tAE5UFghiqZzr8Sg/WAv9TU2+0D8vLpWP8/Oh57at2bisKi8jHRSSPkpLs5UTQsy6ART4ZadYSwwCckN2RHKQDBeE+wJIfFt5wHnDTSqmOlfhAhyD+9XWvIA9XnHsDwuJNXM8Ucpp3zw1KRBFEEgkNdG3W5oHNvKH2ngTRf6oUaXWG1EE+kATsej6Qv05F+IgOSj8eAJGz7tU8H7EnEe570FDgtAoAAE48H9gQzIwjXJqJ3dzrjtTUicN65mo49l8r0BwlgivL8WVwMLNw23UFV+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkDIkWHCah9YlwnlVWZiUeVod+3G99jxUXzHG0zXzHI=;
 b=FNTILjF6KWuRSCsxH8tqzx+0Awc9euKiBOojN7ml3bSuc2e1OjCkHWlFciGEPR9nKUQfbI7xIxW6lIqBmYMfi/uO7aei9e8JPJlZUlLPBksK6WqncdAVrBa6fgOi6uzKjOUPftezMOlFDLKji0vXobY/98T4OxP+G/IF3aIcdig=
Received: from DS7PR03CA0300.namprd03.prod.outlook.com (2603:10b6:5:3ad::35)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:53:49 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::b6) by DS7PR03CA0300.outlook.office365.com
 (2603:10b6:5:3ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 21:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Fri, 20 Oct 2023 21:53:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 16:53:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 14:53:42 -0700
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 16:53:37 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Use partial mapping in GPU page faults
Date: Fri, 20 Oct 2023 16:53:16 -0500
Message-ID: <20231020215316.247816-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d94a538-a165-4626-8e99-08dbd1b70a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83dp5HuPLgvQXbIbi5lyIXUSHVi0xp0Ph7Fsb7YndXlBZKMywkZ2HeDBkX7dOeydvQpL78KNy0e2Z2OruQbXNqTo60ftdN7h4r0otVld4I3FxNdpxgrVrgTZm+zc09M7zxRVaxzGdtl0uK+SuWKUgOt0cCzFDoik7SDQPq+gjn1QUp5/6jp3t/9r7QTvIG6jaDpZitHBe22CNiPcIDnY5iEBadaR0Uh0UmcDilC4weemIXSq0/FlFtpZ6+xQrUZUEdjzppbExl5YAxHji01EN3PcsBXpDS+ODDCLGXAyQOZQtjsrLcnYmTdMxlJ3Io2x5gFF8MHVm8OovK2h6Kh9Jt2YKsrur/QZ5aUgE3Ep2AgsiM2pRzN9kmAo2Xv90bMYt5HpgQJ1ooBQryKw6ji0lDSU+nuIs8H93YH0pVRSGT7FcTp50NiPAAduNVRuI/pOo+Ottsln0UReQqVbvaI1ULabojN1F4zHgO1PhP1COzAdcUzL1hLse2yxEh1ngUR32bjYpYdzHRAMpAFjxz872wwSOTsOXZOk/CqUFQMX5ZfKjxOLlWkSip0PKGHwhmcyPEzpcf0K33iEhbIJzjTHX7MrZjJbNIYXNd9KZ1qOIZ83XAdyudPQYiTT/9VxQiSaFYF7YuRiYVl5kYzTsNp9JcMIMo2fvDuPuvRZZwG7+UuCAY7lqt63Fw3W2HkWI849D4RNDZpg2wldboQjaq6fj/JcTV3Eb0+k/wIf1weVSdaPABKYdApLrFSVc6CLNlV0n0Osz+RJWhAlP4cdd2IGuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(41300700001)(8936002)(2906002)(5660300002)(4326008)(8676002)(70206006)(70586007)(2616005)(6916009)(316002)(54906003)(6666004)(1076003)(26005)(478600001)(336012)(83380400001)(426003)(47076005)(36860700001)(82740400003)(81166007)(356005)(86362001)(40460700003)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:53:48.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d94a538-a165-4626-8e99-08dbd1b70a65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

After partial migration to recover GPU page fault this patch does GPU vm
space mapping for same page range that got migrated intead of mapping all
pages of svm range in which the page fault happened.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 29 ++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54af7a2b29f8..3a71d04779b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
+				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
@@ -1699,6 +1700,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	end = (prange->last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
 		struct hmm_range *hmm_range;
+		unsigned long map_start_vma;
+		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
 		uint64_t vram_pages_vma;
 		unsigned long next = 0;
@@ -1747,9 +1750,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 
-		if (!r)
-			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx->bitmap, wait, flush_tlb);
+		if (!r) {
+			map_start_vma = max(map_start, prange->start + offset);
+			map_last_vma = min(map_last, prange->start + offset + npages - 1);
+			if (map_start_vma <= map_last_vma) {
+				offset = map_start_vma - prange->start;
+				npages = map_last_vma - map_start_vma + 1;
+				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+							  ctx->bitmap, wait, flush_tlb);
+			}
+		}
 
 		if (!r && next == end)
 			prange->mapped_to_gpu = true;
@@ -1855,8 +1865,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&prange->migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
+					       MAX_GPU_INSTANCE, false, true, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -3069,6 +3079,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
+	start = prange->start;
+	last = prange->last;
 	if (prange->actual_loc != 0 || best_loc != 0) {
 		migration = true;
 		/* Align migration range start and size to granularity size */
@@ -3102,10 +3114,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
+	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
+				       false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
-			 r, svms, prange->start, prange->last);
+			 r, svms, start, last);
 
 	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
 				     migration);
@@ -3650,7 +3663,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange, MAX_GPU_INSTANCE,
 					       true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
-- 
2.25.1


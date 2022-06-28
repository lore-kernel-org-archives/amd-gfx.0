Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FAFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F0310FAA1;
	Tue, 28 Jun 2022 14:51:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482FD10FA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQA7pfMSaCX+4tAqkO89Cj/03H0RulDQebzI8RCpA+FDLLE7cJ3FU8uiSCm4O9uUMWjeiNOJUBsO6rrU5tdyOmRTtjqlMufdOsdDC32Xu6eK2B5AMuwjhLlwFrUYfPJKa0TJekSud7teqgOdmDoiepJC3aXqRDo/7HRIHmRq5pG1vV02coQ7+jWCPaVj2myKVNNbwkK9O4emx2CXX2NSqLoKgi8aOwgdQGHPEYSrR8tCK+L6HT07I/Ofk+YSamYk2wLnCsvTCUxG1JBg26m2ZpMRsg8poOO9dfw4x4Vso2O26EfdIrGWcfwMFMSqr5P5J9N7pyuNVsOGsESyLxbU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBRgTM5VggLH3irp5Vn+Iqp4ToKb6zCmyhubUh9Aoxs=;
 b=Szy/rGBtpo5BgqZvtSvyjlrwMRMqkWmI1WZvKn3eS1O68N6kIiweNHs1O/Aj1mq6eSer8BQYuihmOGoeBM7VqfNTzLGl3YLgMgDf9WUIl79pSNMyX9wz/x/2yg8rL0Hi20+k6v/xq+exc+UZ2OUWOI9lPM4J8n6XRFDLrefEtS0bRMIAyDjd7pfIz6TN5CTTL3k/4Ey3Z6QaMX+vns+HDg/9WgYpIweempJVDNKhdUmQoSBwFNg6UpACeneH6Gp3SLBe/sJOQuaOH1F/772FYohNnV2DN1V7t4l/+Q939JUCLdzR7i8hoTQo33we827sLzibOntX8UpFPvEZo7jT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBRgTM5VggLH3irp5Vn+Iqp4ToKb6zCmyhubUh9Aoxs=;
 b=gmpTu1jzd2tjG0qqo1vC4Z04xe/wDMUsTAyy8xIoEdIT26msFKi6vUSaeCppfafQeYuNlqiAbCDE87WQfICETNePzfz6Smt7MCgfd8NMkBC86b721ruOKSbMiZsaVzBaxqQhJiFkalWg2RqhrQe27xUgae5YX/zeTCO688qH5Io=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by MW2PR12MB2410.namprd12.prod.outlook.com (2603:10b6:907:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 14:51:27 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a6) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:21 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 4/11] drm/amdkfd: Add migration SMI event
Date: Tue, 28 Jun 2022 10:50:13 -0400
Message-ID: <20220628145020.26925-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb86d498-989f-4f57-5175-08da5915ade4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2410:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbkPNNszebNPyhYrSSKhYnv1S+TTPirKKn4zwlp+FCme6xyAwLMB4COxBc73KgEL4zFokb97f4LfH+3G2fzDOe0/7ZGxJEY9IbHZsusCZoDiQFf65DiM82Le6kSyCvduT4kVQSOZje1M2obAYWmyqEgsv5s+1xp578w7guCaiJ/GMZAhC8T37bj4Z6XCaZvMXpj7jRuq6cwgll7n8MwuZhK5oqdDK34XdD8JUWdl+YLhpEfV6dLL6wc3kgY/HoTSFaam6eNIRMiZnAhdbxmVL1mPEvWFbMW+ECXFnw41WEx6yBG6DU+ZemRZB/84GomACZWtWGLQOK/eODSwxhYv5qfQ/vF43FtvBimKK4anK4B69fZ0wazFtJVxzwNfq43dAypDyIAy7u/jn92MAgkzsz1wwnmkfJXzMI6zfdRYwCq3NjUfX4iLplrtqPY7jEkpw5sYqPAFoRAV35rygjYxTc6XKQvQJD8hv1pUEevrPAbIeVJDCNDnHHmz5SEJI+CuCQ8wrYo7kNen3F352j6feRTR78VHn66lbtsv3hqKfMIVXokdwFwRfUni3L7IYlMti0b4gAI32+J+sA/zg46w0nzmCAa5ZF682fuHZmoUnOeaVhihhI++xz6ni6RK816GiL0MW13Uf0xsUwlgGLLBMz/h9fY0HzQS58FTz34QmAJM5Nk9vXu/eQo9aNf8mf09PLK5rF98YOfpwS86ciEFqbtecjI5XzJb1LizYPfpDl0FOFJAAIT4tiwiAEJbNnwQ30k/5XvHFLcxmJftnJ78n839LCvOJlUFhZqwdLXq27fan8EtUESpyDX3Sq30R8RFuTSO/NFPRSe+yi19Qq9v0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(40470700004)(36840700001)(46966006)(5660300002)(36756003)(4326008)(478600001)(8936002)(30864003)(40480700001)(82310400005)(316002)(40460700003)(86362001)(2906002)(83380400001)(54906003)(70206006)(6666004)(16526019)(41300700001)(2616005)(186003)(426003)(7696005)(8676002)(26005)(82740400003)(336012)(356005)(6916009)(81166007)(1076003)(70586007)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:27.1078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb86d498-989f-4f57-5175-08da5915ade4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2410
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

For migration start and end event, output timestamp when migration
starts, ends, svm range address and size, GPU id of migration source and
destination and svm range attributes,

Migration trigger could be prefetch, CPU or GPU page fault and TTM
eviction.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 53 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 22 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  8 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 16 ++++---
 5 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fb8a94e52656..9667015a6cbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -32,6 +32,7 @@
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
+#include "kfd_smi_events.h"
 
 #ifdef dev_fmt
 #undef dev_fmt
@@ -402,8 +403,9 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 static long
 svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct vm_area_struct *vma, uint64_t start,
-			uint64_t end)
+			uint64_t end, uint32_t trigger)
 {
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
@@ -430,6 +432,11 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				      0, adev->kfd.dev->id, prange->prefetch_loc,
+				      prange->preferred_loc, trigger);
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
@@ -458,6 +465,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
+	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    0, adev->kfd.dev->id, trigger);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
 
@@ -479,6 +490,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: the process mm structure
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -487,7 +499,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
  */
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			struct mm_struct *mm)
+			struct mm_struct *mm, uint32_t trigger)
 {
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
@@ -524,7 +536,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			break;
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate\n", r);
 			break;
@@ -655,8 +667,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  */
 static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
-		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
+		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
+		       uint32_t trigger)
 {
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
@@ -685,6 +699,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.dst = migrate.src + npages;
 	scratch = (dma_addr_t *)(migrate.dst + npages);
 
+	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
+				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				      adev->kfd.dev->id, 0, prange->prefetch_loc,
+				      prange->preferred_loc, trigger);
+
 	r = migrate_vma_setup(&migrate);
 	if (r) {
 		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
@@ -715,6 +734,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
+
+	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
+				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
+				    adev->kfd.dev->id, 0, trigger);
+
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
 out_free:
@@ -732,13 +756,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  * svm_migrate_vram_to_ram - migrate svm range from device to system
  * @prange: range structure
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
  *
  * Return:
  * 0 - OK, otherwise error code
  */
-int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
+int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    uint32_t trigger)
 {
 	struct amdgpu_device *adev;
 	struct vm_area_struct *vma;
@@ -779,7 +805,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 		}
 
 		next = min(vma->vm_end, end);
-		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
+		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger);
 		if (r < 0) {
 			pr_debug("failed %ld to migrate prange %p\n", r, prange);
 			break;
@@ -802,6 +828,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  * @prange: range structure
  * @best_loc: the device to migrate to
  * @mm: process mm, use current->mm if NULL
+ * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
@@ -810,7 +837,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
  */
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			 struct mm_struct *mm)
+			 struct mm_struct *mm, uint32_t trigger)
 {
 	int r, retries = 3;
 
@@ -822,7 +849,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, trigger);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -830,17 +857,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (prange->actual_loc)
 		return -EDEADLK;
 
-	return svm_migrate_ram_to_vram(prange, best_loc, mm);
+	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
 }
 
 int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
-		    struct mm_struct *mm)
+		    struct mm_struct *mm, uint32_t trigger)
 {
 	if  (!prange->actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm);
+		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
 	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm);
+		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
 
 }
 
@@ -909,7 +936,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		goto out_unlock_prange;
 	}
 
-	r = svm_migrate_vram_to_ram(prange, mm);
+	r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
 	if (r)
 		pr_debug("failed %d migrate 0x%p [0x%lx 0x%lx] to ram\n", r,
 			 prange, prange->start, prange->last);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index 2f5b3394c9ed..b3f0754b32fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -41,8 +41,9 @@ enum MIGRATION_COPY_DIR {
 };
 
 int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
-			struct mm_struct *mm);
-int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm);
+			struct mm_struct *mm, uint32_t trigger);
+int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    uint32_t trigger);
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index b7e68283925f..ec4d278c2a47 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -261,6 +261,28 @@ void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 			  pid, address, dev->id, migration ? 'M' : 'U');
 }
 
+void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+				   unsigned long start, unsigned long end,
+				   uint32_t from, uint32_t to,
+				   uint32_t prefetch_loc, uint32_t preferred_loc,
+				   uint32_t trigger)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_MIGRATE_START,
+			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
+			  ktime_get_boottime_ns(), pid, start, end - start,
+			  from, to, prefetch_loc, preferred_loc, trigger);
+}
+
+void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+				 unsigned long start, unsigned long end,
+				 uint32_t from, uint32_t to, uint32_t trigger)
+{
+	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_MIGRATE_END,
+			  "%lld -%d @%lx(%lx) %x->%x %d\n",
+			  ktime_get_boottime_ns(), pid, start, end - start,
+			  from, to, trigger);
+}
+
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 {
 	struct kfd_smi_client *client;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 7903718cd9eb..ec5d74a2fef4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -34,4 +34,12 @@ void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
 				    ktime_t ts);
 void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 				  unsigned long address, bool migration);
+void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to,
+			     uint32_t prefetch_loc, uint32_t preferred_loc,
+			     uint32_t trigger);
+void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
+			     unsigned long start, unsigned long end,
+			     uint32_t from, uint32_t to, uint32_t trigger);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2ad08a1f38dd..5cead2a0e819 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2821,7 +2821,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (prange->actual_loc != best_loc) {
 		migration = true;
 		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm);
+			r = svm_migrate_to_vram(prange, best_loc, mm,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 			if (r) {
 				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
 					 r, addr);
@@ -2829,12 +2830,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 				 * VRAM failed
 				 */
 				if (prange->actual_loc)
-					r = svm_migrate_vram_to_ram(prange, mm);
+					r = svm_migrate_vram_to_ram(prange, mm,
+					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 				else
 					r = 0;
 			}
 		} else {
-			r = svm_migrate_vram_to_ram(prange, mm);
+			r = svm_migrate_vram_to_ram(prange, mm,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 		}
 		if (r) {
 			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
@@ -3157,12 +3160,12 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 		return 0;
 
 	if (!best_loc) {
-		r = svm_migrate_vram_to_ram(prange, mm);
+		r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 		*migrated = !r;
 		return r;
 	}
 
-	r = svm_migrate_to_vram(prange, best_loc, mm);
+	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3220,7 +3223,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 		do {
 			r = svm_migrate_vram_to_ram(prange,
-						svm_bo->eviction_fence->mm);
+						svm_bo->eviction_fence->mm,
+						KFD_MIGRATE_TRIGGER_TTM_EVICTION);
 		} while (!r && prange->actual_loc && --retries);
 
 		if (!r && prange->actual_loc)
-- 
2.35.1


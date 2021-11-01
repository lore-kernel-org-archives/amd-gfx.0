Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 12:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48A760F70
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 12:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E48A760F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C2389D52;
	Mon,  1 Nov 2021 12:55:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B76589D66
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 12:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRg4cymmGgv5pkun6RapDh5uLjAJ1XV9zOEo3TbGUVrEPl/sMSeC1r06j1mOUsTcd9ZrMllNxutuskfDvNXXDjCyk4APxhvNZc/nleMztjxI5fia1emTrUmCTINKTxGNMwc5fUrkTQfO6Be8ISs7YFp9e7sE4dU96uNTrpNnJYXoepy0fQP4gntx0ndhkXdoSrU9o3i71NOMH/75uIzEnXaIqoa47eS5kSVCjVqyWx0WIqac00AF3xp75uhDk9V7LrCnRXPd0fbceV1xcDjrVJLryGNl+Cu9ZIjAyxemwaGHVGt5HgJTgE8U1p33GQ+a7x1j2geqGTVEYRDs6TApgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UD4lpARoa33koEWai33Hu2Tk2TOUWgq2Ef3ZCCl7Mw=;
 b=FWggvS5HbzAb0IsOgnIbegfTMrprf8xTqZsHUt2tYumqbd9zANSV2ubRhbZDPUUr59560YYFikzDn4PVm/+ff0o/8/81mqgcerFc9dcW/EFVihoHzDseLpUPRUVeqwsWwLyMzXQNTk1qPp/RV5jjHNIxAVPFJxGsPVBBefznciXSB2TtnfFa1PWtDDL6nQ13+dm0LSyAw6DWVnBBOZMP3bJABJZ/f1+uYa71j755JXm7NYkW9nibTOrAm4mg2/YhTvHU1GyrHiwqReJiDDEwbNeRX1xda8ztZtRMgum6oRQ3h2shFpXIHnrKJ9g+uvKbJMBktzBAOVUU6e/iWbHdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UD4lpARoa33koEWai33Hu2Tk2TOUWgq2Ef3ZCCl7Mw=;
 b=RJrJB61xmrSWwBkaaxqA1+cvIm5Wk6U3bUOBKLIqctGAetVy0HK4sUOUlR+Mc/q25jBiOq8b3d6gYC0u2OJq52uZLUqCphJRY0eMs3JLZstgNZ9NvOLjPn8h8kNqY1dgrLKDe81Mxg2X8KZru4y3f51Wgi9kNqiQMempuwqEbOw=
Received: from CO2PR05CA0090.namprd05.prod.outlook.com (2603:10b6:104:1::16)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 12:55:37 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::e6) by CO2PR05CA0090.outlook.office365.com
 (2603:10b6:104:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Mon, 1 Nov 2021 12:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 12:55:36 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 07:55:34 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: Avoid thrashing of stack and heap
Date: Mon, 1 Nov 2021 08:55:12 -0400
Message-ID: <20211101125513.999187-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101125513.999187-1-Felix.Kuehling@amd.com>
References: <20211101125513.999187-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd4778d9-88cb-42aa-0425-08d99d36e64a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4271:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4271DF7D5AC7257DE919CC2A928A9@MN2PR12MB4271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLdp+eM3UuRzlAT7k8FOBvdchjm25wp06jPEfGX3sgQQNipFgMcoYFgi2kcXMRpq2muUmfdHvr/FJqYfobvYgrn4d/2u3wzTh0dMcMFDhJkiaQsKekS2nA5uuD3dw7i2/bqbl8iouKZHNOf6WfvZ/Q+oAjBOU9DUO4ki7HARZbR/G/+2Jm1vvo22lVfsShCJqUtbMg8wnsD2+7gP6k9TbQQ2OEwKslumsMm6DU502+KUgVvpGIZXSSRQ7TRY3qCrEty71oYbcnz8n3yLd6WQox5G85JycEVY6s+E/hh8Wg1/P79lPw+XInwe++d1rike6uRP3Jxb3jUEO1gBC0DUifgvwqZVA7dMsyFesiRt7bMeNlAD2pF9Dk5ikdifjabHVnRo8YtkKLZV04dbCqzmBzly/6Zxxs+O6RPsbdroU3DlK9Gm4/r9voOfEFjWdMrK8MvOBC0sDFnmmCgCfLNkcbNtTQBMO57gEyn60GlOMz29QgqdTUzKP3+undDnlO3BWv5yfy3ArdN+634+/EdxpxOG+7f25pJUgzZl9hq/GZC0201BxLnurDJbwdpQTf6rGnWnADsjyiu3oXGcIyEip8f5BO6nRYUcALAcW+WICCBFAoI0LsTwBgc+/LJC0TAN2CR8UAJAjk9lLsK4v5i+dbEXysxViJ84zGfRXyOJMPW9AQGwmZzP0I7b55wRFUYwo+URMa3vWjtBDpe1HI0UqEnR89uN8Ho073XQs6qIJq8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(36860700001)(70206006)(81166007)(1076003)(186003)(70586007)(86362001)(26005)(356005)(4326008)(6916009)(54906003)(316002)(16526019)(2906002)(508600001)(7696005)(8936002)(426003)(82310400003)(8676002)(47076005)(83380400001)(36756003)(336012)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 12:55:36.5402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4778d9-88cb-42aa-0425-08d99d36e64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
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
Cc: philip.yang@amd.com, Philip Yang <yangp@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Stack and heap pages tend to be shared by many small allocations.
Concurrent access by CPU and GPU is therefore likely, which can lead to
thrashing. Avoid this by setting the preferred location to system memory.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Philip Yang <yangp@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8d37ee755b34..854735dbb96e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2310,7 +2310,8 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 static int
 svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
-				unsigned long *start, unsigned long *last)
+			       unsigned long *start, unsigned long *last,
+			       bool *is_heap_stack)
 {
 	struct vm_area_struct *vma;
 	struct interval_tree_node *node;
@@ -2321,6 +2322,12 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
 		return -EFAULT;
 	}
+
+	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
+			  vma->vm_end >= vma->vm_mm->start_brk) ||
+			 (vma->vm_start <= vma->vm_mm->start_stack &&
+			  vma->vm_end >= vma->vm_mm->start_stack);
+
 	start_limit = max(vma->vm_start >> PAGE_SHIFT,
 		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
 	end_limit = min(vma->vm_end >> PAGE_SHIFT,
@@ -2350,9 +2357,9 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	*start = start_limit;
 	*last = end_limit - 1;
 
-	pr_debug("vma start: 0x%lx start: 0x%lx vma end: 0x%lx last: 0x%lx\n",
-		  vma->vm_start >> PAGE_SHIFT, *start,
-		  vma->vm_end >> PAGE_SHIFT, *last);
+	pr_debug("vma [0x%lx 0x%lx] range [0x%lx 0x%lx] is_heap_stack %d\n",
+		 vma->vm_start >> PAGE_SHIFT, vma->vm_end >> PAGE_SHIFT,
+		 *start, *last, *is_heap_stack);
 
 	return 0;
 }
@@ -2417,11 +2424,13 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 	struct svm_range *prange = NULL;
 	unsigned long start, last;
 	uint32_t gpuid, gpuidx;
+	bool is_heap_stack;
 	uint64_t bo_s = 0;
 	uint64_t bo_l = 0;
 	int r;
 
-	if (svm_range_get_range_boundaries(p, addr, &start, &last))
+	if (svm_range_get_range_boundaries(p, addr, &start, &last,
+					   &is_heap_stack))
 		return NULL;
 
 	r = svm_range_check_vm(p, start, last, &bo_s, &bo_l);
@@ -2448,6 +2457,9 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		return NULL;
 	}
 
+	if (is_heap_stack)
+		prange->preferred_loc = KFD_IOCTL_SVM_LOCATION_SYSMEM;
+
 	svm_range_add_to_svms(prange);
 	svm_range_add_notifier_locked(mm, prange);
 
-- 
2.32.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BB9C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 00:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F67B10E603;
	Thu,  8 Sep 2022 00:17:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915DF10E603
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 00:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF4QLDD1BLVXsPNOUoVT1Ruk+VKn6LSxfQVJ4gITArrFgsVrR/dG4lFVtGkApwD3umXR7Y+NyJJKkCpE13kRETpWbBK7IPEKxWswr2vZQFw0xrftMhaW6wj0b1mEEE3MdcD+QD5wlId8r2HiHrne9lcwJ6SG2u/BIL2EYuKzUUuHU/TWhGtEOIMGG7TcGHR0LJAK15Z9nJPMTF3r2zKti+y2S/wC/lf4MUNJAd3avOUpiYnmyh1XMZO/b8/eqSidELOyBVlmm+8ciUE5clAfXUChdyLwEBup/BqHv4C+sBNZY19rPmgF9rFZfNLf94G6FvsCv0vrILBH/11VXknHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvlGsW+OnjeAwR9qXNsxQETUXv2K8A0u/jh6uJghpqk=;
 b=DWl5A7HOdXQ1y9KaEuW2SfpLQ29Rjucx1HvBh01HhmvkbrETbFlZV36qbcLjADjecg7JPcyeUZRi0zhpCubX8hAQtaIUmTY4LqTusljXXXQESxJBQCGN3NcKSyPaiEYPt4pUKl9OiGOJGXUsSIMB6TI0vqMDCnGAQ11NBZxDISkxyFK+p3ZTA961hEnDyOxP/x6lDkIOzSEHpcd2BvzwnhX4vCwgevzyaS/2dfgakCg8wmuBaRmTxbc8Y0KDP+Qlr5Ych/rX5Rk5mT7JHkjtmVCUCavTxAymcvRjCC/UHWxl8D9eTb+Mu+1QlAVIT+1esTFoElDctu7iQ11fObrpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvlGsW+OnjeAwR9qXNsxQETUXv2K8A0u/jh6uJghpqk=;
 b=FaZVMUC+KmOVwsIdcup9S5lBXEMPWn1sPz3t5uVS5wUrSW5PgDXEwrC+r3a/IKV5HPEZ0lqh/ZouLPURPDmmn0h+7CQj0X8fPhcMGvVp3RQSXqqYOjqN2bPru0a6CImIpzMQDDJZ3dxXW1u+KDh5p7WukFD5duuXexQnDzkyaAo=
Received: from DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9) by
 PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 00:17:23 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::c8) by DS7PR03CA0310.outlook.office365.com
 (2603:10b6:8:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 8 Sep 2022 00:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 00:17:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 19:16:56 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdkfd: handle CPU fault on COW mapping
Date: Wed, 7 Sep 2022 20:16:29 -0400
Message-ID: <20220908001630.15437-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d90a40-6763-45fd-d470-08da912f809b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jipddTC6sMfm1rRfkEVKyn/onJdY9Zb2YUiQuqh5gN5SOcVxSmGw4uA2CeyfBnVCVWTzeRhiXLFaS7QQBpkNBcYxtHeQMcYWDn/1xCD7knEvRHeqFg/wkWxicmHaQEKqYAGnr7PsjsYM9Yh1kpw/1gx6eSZ7WgX+fahWuvUE1MyVW/5kHspTPGxf61Eprk3eLfjtWp+mKnTtbg2WYoZp/buySLexpYy7rfWYkMG3tm/4Rd8ow2Tr4QngqUsQ9IhVbrJ+xKeMjuxv3bZHfC6YwhNdBVCUROL7I/2LUdp8ufvWdRZIBgzKedxoF+UAG+3MmYxaMJSrJeJ49Rfg9zeLrQI9LLGT+0W7ht309o/9jyTyegsrpNcV5UeddG4Zfgi5QgzOuz/AsNhzKeoml9+/orbFOY/ZZcqkHcLQiGsK9BuzN7PX6qHbY0+N2JTvC41OfPMkEVdt9ApzUaa8ItvqI7ShpWoplS8ukwEZPWQ+rdzxi41Lq9xX7kYIu/Ur+3MsW+Hmcto+77VCOd9jjuArZcy4weiHzQEJZ5f6SRYX+jR+Df/hs1JjJrrgxVCgohydbL9lLOvTsUDAeNupLVsTFmKXHBKjj8rfodwTLpMzrFPfQLO5cHyRIB4tsRn37xwwkTQljxtJqjTX+ZUTuFRTko0vuKZiFdoNtK7gO6h11EE92bbyydPEbQKHTcciuPQayqO2xULdhJWW3SLXLGjfFYeHisU+KO/b8UB/Ttu0nIlAvtISIgpISLMUwmkBGc6C3a/M7BCB/AacGgB/lxfKCAPp11KI4nchyky9Va0eEY3EShothZe3M/MFKmwqE9bLLEf1eSaJhGfCJ8P3veye5WAY1qzmv+pvaAD1BYxl4BI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(40470700004)(7696005)(186003)(16526019)(26005)(1076003)(426003)(2616005)(336012)(47076005)(5660300002)(8936002)(86362001)(41300700001)(40480700001)(36756003)(6666004)(478600001)(40460700003)(36860700001)(82740400003)(356005)(81166007)(83380400001)(54906003)(82310400005)(316002)(4326008)(6916009)(2906002)(70206006)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:17:23.2439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d90a40-6763-45fd-d470-08da912f809b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If CPU page fault in a page with zone_device_data svm_bo from another
process, that means it is COW mapping in the child process and the
range is migrated to VRAM by parent process. Migrate the parent
process range back to system memory to recover the CPU page fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 42 ++++++++++++++++--------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 373e5bfd4e91..8562dd0eb4b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -884,7 +884,7 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
 static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 {
 	unsigned long addr = vmf->address;
-	struct vm_area_struct *vma;
+	struct svm_range_bo *svm_bo;
 	enum svm_work_list_ops op;
 	struct svm_range *parent;
 	struct svm_range *prange;
@@ -892,29 +892,42 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	struct mm_struct *mm;
 	int r = 0;
 
-	vma = vmf->vma;
-	mm = vma->vm_mm;
+	svm_bo = vmf->page->zone_device_data;
+	if (!svm_bo) {
+		pr_debug("failed get device page at addr 0x%lx\n", addr);
+		return VM_FAULT_SIGBUS;
+	}
+	if (!mmget_not_zero(svm_bo->eviction_fence->mm)) {
+		pr_debug("addr 0x%lx of process mm is detroyed\n", addr);
+		return VM_FAULT_SIGBUS;
+	}
+
+	mm = svm_bo->eviction_fence->mm;
+	if (mm != vmf->vma->vm_mm)
+		pr_debug("addr 0x%lx is COW mapping in child process\n", addr);
 
-	p = kfd_lookup_process_by_mm(vma->vm_mm);
+	p = kfd_lookup_process_by_mm(mm);
 	if (!p) {
 		pr_debug("failed find process at fault address 0x%lx\n", addr);
-		return VM_FAULT_SIGBUS;
+		r = VM_FAULT_SIGBUS;
+		goto out_mmput;
 	}
 	if (READ_ONCE(p->svms.faulting_task) == current) {
 		pr_debug("skipping ram migration\n");
-		kfd_unref_process(p);
-		return 0;
+		r = 0;
+		goto out_unref_process;
 	}
-	addr >>= PAGE_SHIFT;
+
 	pr_debug("CPU page fault svms 0x%p address 0x%lx\n", &p->svms, addr);
+	addr >>= PAGE_SHIFT;
 
 	mutex_lock(&p->svms.lock);
 
 	prange = svm_range_from_addr(&p->svms, addr, &parent);
 	if (!prange) {
-		pr_debug("cannot find svm range at 0x%lx\n", addr);
+		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
 		r = -EFAULT;
-		goto out;
+		goto out_unlock_svms;
 	}
 
 	mutex_lock(&parent->migrate_mutex);
@@ -938,8 +951,8 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 
 	r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
 	if (r)
-		pr_debug("failed %d migrate 0x%p [0x%lx 0x%lx] to ram\n", r,
-			 prange, prange->start, prange->last);
+		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
+			 r, prange->svms, prange, prange->start, prange->last);
 
 	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
 	if (p->xnack_enabled && parent == prange)
@@ -953,9 +966,12 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	if (prange != parent)
 		mutex_unlock(&prange->migrate_mutex);
 	mutex_unlock(&parent->migrate_mutex);
-out:
+out_unlock_svms:
 	mutex_unlock(&p->svms.lock);
+out_unref_process:
 	kfd_unref_process(p);
+out_mmput:
+	mmput(mm);
 
 	pr_debug("CPU fault svms 0x%p address 0x%lx done\n", &p->svms, addr);
 
-- 
2.35.1


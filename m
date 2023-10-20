Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F769CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 15:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA57D10E01F;
	Fri, 20 Oct 2023 15:01:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1541F10E01F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 15:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl7CMwFkbNrWNiQP6guX59e//1k3nl4qp5t4RJYUg4vk+baJUQBqtKysjb1eIBiu5D8KUr4Kfr1RJBY2rJ7MfiDwxTruHUvupRXIeG6CqTn4mojaxRxSOXu41cu3RM7BJ9tqX/AwwA07ovHBexSp1YGISaF7JeMbdnGJPAxHfI1lWiHlDcTyX/ZGzgVkp8xoXxcGHTtNPIDAZatkm3EMd1GbFy5zRmi/v4We+Jq8f2D5IYbMeYzV7wNKqJXUyt4DehsmJDAZ7CKW3q2tX9ArJkt8FDhggDGWf55rvGsRvcL5FQqaC3kkULMkei+i2I/M+PnAgQhRhQDqa7oQEvUAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq6uuYXpexUNZMF2si7G1ph65sRhpByb0j7UDeIvh5U=;
 b=L7/NlT4eoZGLnLp2Ppm8EQNg8IM74pCPXZ9NaolHlbvfDO4gy8NmolvwBG4BEBc8lQq//ObHcV6syX+dyG5px3q4BcV2QmLFRXKseOqiYMXO0kAuwEhTt/7aXrCbTgM2IrH8KOEItTH+MYnatXZkIBM0dXDH4vwCq64sngSS15+II05IXLaZ0Y8PWKBfeAgsTHa0wrTagYUFxK6zevtN8fiCzttSsWxfCtlyAgXHe+AFFBi9KV9nZGTtxn/DrtQRXQOh2eOc31d711+vb5xWxIf2xnzgybV2zTm7KHzT9UOV13ZfjcwdCsLLcfrT1fzSdNTt8xHN9wkpI583cIO8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq6uuYXpexUNZMF2si7G1ph65sRhpByb0j7UDeIvh5U=;
 b=kJ+VQ+OCuQlA3HrFlXMX1lcC50o396AzYi54z3gB5Y+YerrwLUvYB9eMr3BAfav+wGAcPwc4JYEE4QrV/OP9IRK6AcJ9ywqWUMC7YtXdIsJwoo86ZZRwjcFST1JRqjgN0lwJj+Brc1xagT05Iroyc7Gz84KU4x8TJDuSTWW3Lqc=
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 15:01:29 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::b4) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 15:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.24 via Frontend Transport; Fri, 20 Oct 2023 15:01:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:01:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:01:27 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 10:01:22 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Use partial mapping in GPU page fault recovery
Date: Fri, 20 Oct 2023 10:00:39 -0500
Message-ID: <20231020150039.153593-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: db8c76bd-b1e4-443b-7e5b-08dbd17d7052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFuyXc5balVS2L+xaWzBGdK8kTQ/7XmKrMoGgQCpy1KixPOXdx6SBtF7lXFIH34sLgTMLdTT57+EYch7zTC5hqBkMwZZ1iwul/6td09rYrjz2UAIXF4j+b/wbCvmCo9xxS/8/46nsS1A2lNpTwcpjgSwYTKCz2e6K8p70drvIMTIfrUn4uFTtIyiVPjq96tNTyCZlKU+G3ux0wUbgF4uwKS0rKIn7WPf28xejpyhxhso0O6KQg8gmmQYGBDFpE6UhNJl6WeYLkh/1Lsp2D3/uqBhaiQlCgQbyVA13WJVsEUWvu++3+wskpe7Qg3jvIdFv/OiPUDU246oOB1dsvw06LLxxGi/BOIXh7DyYznegrddvVFK1YkKrZ6BNcQQ7QScey0lujbsq9YaoGWwZtQWfTf0HRb2dxo7T4dZ+RXaPGTYvSGofAumd2UkEhuBQnr/t0QMrqquqCJu4nmCeGQesg2VmOMoTZwy6NULSZi1Mloqvz5ZW5gTfpgs6954yyZx8vA5LKoYDbIuX1t36x9yBAIAwBmYAwNJEzqkh8EwW7Vjjq71l3y2hubAYzKoXr9N+FecX3Y4yt2kPO4+rxzJ2FNBlvHcH69e8lp3EAbOu4vQ9Ba+W7rOe4+3Rri4Tne6lRDUVYXdb9Jqf/pxJH1OlSuyIxshBmqzIGwsSu3zM2WEqpTJBzqSPIR/y/5YchKjwgK/lk6m9VtiNalssumBQ8ssczdNjZCq0n99pnJ9cLicr6aiS/ebiIWLDLtReab+iHh1kazao96kkb7m5tozWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(40460700003)(316002)(54906003)(70586007)(6916009)(70206006)(86362001)(82740400003)(356005)(81166007)(36860700001)(83380400001)(426003)(26005)(336012)(1076003)(2616005)(6666004)(2906002)(478600001)(8936002)(41300700001)(5660300002)(47076005)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:01:28.7691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db8c76bd-b1e4-443b-7e5b-08dbd17d7052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
space mapping for same page range that got migrated instead of mapping all
pages of svm range in which the page fault happened.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54af7a2b29f8..58f0506d5221 100644
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
@@ -1747,9 +1748,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 
-		if (!r)
-			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx->bitmap, wait, flush_tlb);
+		if (!r) {
+			map_start = max(map_start, prange->start + offset);
+			map_last = min(map_last, prange->start + offset + npages - 1);
+			if (map_start <= map_last) {
+				offset = map_start - prange->start;
+				npages = map_last - map_start + 1;
+				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+							  ctx->bitmap, wait, flush_tlb);
+			}
+		}
 
 		if (!r && next == end)
 			prange->mapped_to_gpu = true;
@@ -1855,8 +1863,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&prange->migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
+					       MAX_GPU_INSTANCE, false, true, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -3069,6 +3077,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
+	start = prange->start;
+	last = prange->last;
 	if (prange->actual_loc != 0 || best_loc != 0) {
 		migration = true;
 		/* Align migration range start and size to granularity size */
@@ -3102,10 +3112,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
@@ -3650,7 +3661,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange, MAX_GPU_INSTANCE,
 					       true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
-- 
2.25.1


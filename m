Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C56DCD8C98
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D8210E389;
	Tue, 10 Oct 2023 14:41:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F2310E389
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBaHujETLCAz+H0vzTxGzW1KluW8JkNF/QyrqM7ZsnfvVNWLoWSAiLD++kXEGZbdz/AfMFrbxOENDnoE1Oc/mY8YE/eqkJemu7mjMLzMX6UiJwVJ77QbLRlERvamMN7BOutQLArkc326teMdoC+QhWIIIiBZ41+icden+jXC3P9FkNgaMKSssolRYI2lwLeOhtTLW57COBGIninfGS9WTyD8kL0OtLJ/Q5zUQlC37aj19/5tG/nzmbVsg763HIBNA/IGVbwXy4ff3t3UzsyH8jwxN0L5DpboiYYJuvVkibGq/V3uNesBI6U8Z2p/3nhsd4YYAJ6GSY5guYQoe8thXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVYD7ior3Qs8zBVhopCgIarP+QmzGA11Z+P9UTGALPY=;
 b=Jy7pM7S7yWaWy7ymJB/nk8i1+0aSuiH3EhD8R4diYG5vGWE7ya1ko26XexoZ4HvY11dYtHEyo/WWUGBo1IL75/Sdy+VqsYHBCRJRSF84L58LfiXJA4otK7LYSqnzCeYT4VM+wO5sAeaSKnQ4lGaTETuADObt+JtgvQtt4SU3VnBLR0w5x9b07sAY3xGKVx3DHr+xWZNYI90ms2g+yRw89xZogv2qgGPs4M1Tb07VtDHqLfHNZIJHolbUCM/eeIFPPxpWEBNKF4uQy6GZKkInME7lkEeMumI1uvYKa6D0zQ5+S6YvXpJzkxkwPkExhDg2SwBideMmsN1afL8fXoSKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVYD7ior3Qs8zBVhopCgIarP+QmzGA11Z+P9UTGALPY=;
 b=H2lRDAMgYUPvb3PVOwP7kPAcCDDLqGJzS0oydofJMAmz8QGkKwyxK92fzarvLjN++hSETnAwOHqZJ0PgLwNRk2EsfUt0qbFQLA7VINsIq2wXT9K8f+q2Kwryu+3P0P8Pi7bUE7+huiakFRhMgcnR9ej9Vs3CQAoAssS608Q20B8=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 14:41:48 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::53) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 14:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:41:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:41:46 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/7] drm/amdkfd: Wait vm update fence after retry fault
 recovered
Date: Tue, 10 Oct 2023 10:40:18 -0400
Message-ID: <20231010144024.3016-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ad8579-6422-44a8-2279-08dbc99f0846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQJcTjN1boaxZR2ST+iCanv+A9jR1Vmnt4QvVA66Wvu5D6uhM97gui4lEBbsZ6g46ZR0BAiFf21VpdgMQQlZg/1PW8oK/KC2baV7+w495VokUfijUIo62Br1aIhsEkmvhOG4T/W3MZ2nIjDBurTBZBQfVhp1tl+gcU7uTEIyhsehCjEI//VNic/h0fSy1IO8mocQ6LrvmyLRp0u+dYrvg2zySxqP7uYJ5Hj09oT0rVcH4Ctaxda0IQ4RumeOIbcLias11/Dcq4SupWHV1+YVU4NESoOTVIMDmye9+Zmw4pPGWS2cI8idLYmEX1LjzFrxI+rF1erEfmdUIHvrfE6w4JthvOoguY/qrYziWWsjaFdA5sMGeF5QFkwNWMS0wcgnUgOJX7mxddwOg8oYnCK+8yI34q8ynTCZxwp9NG7dry01qzXm2wcFDSBiO1yZ89Ld+0SlMRcku1Snk13Uq2rFvgi77+j8BQh+siBkdAfIh1twKKd9/uCvPXVc762TtIP6UJg3uqG95flmNpdEOe1pY+RvBiqeFeIoMl/KIPzgZM/Y3FLyxTFYU4nIzfJeZQ+JrEVbDbKLDlY7q7y92ez2Kl4D/8maoGPAFwxvf4Ma9QdSAIsugwEGTZfMXJHFazjj6NQp0uXOZvfeDDwF5DeWZsnX8DEF3rYpjtB+OKftAGM1UTq4zk/VFKfnmgFmpYRSVdgg1VRGAlcm1aW7CYZRvY6Mcc/vR82zohyRPc4lbX4ih4xxqZPSr86EVVsCC5HnS8PmZXK5VDVznl5XCcw7qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(82740400003)(2616005)(7696005)(1076003)(41300700001)(478600001)(336012)(15650500001)(2906002)(83380400001)(47076005)(426003)(70586007)(5660300002)(6916009)(54906003)(70206006)(8676002)(4326008)(16526019)(8936002)(26005)(40460700003)(316002)(36756003)(356005)(36860700001)(81166007)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:41:47.7448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ad8579-6422-44a8-2279-08dbc99f0846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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

If using sdma update GPU page table, kfd flush tlb does nothing if vm
update fence callback doesn't update vm->tlb_seq. This works now because
retry fault keep coming and will be handled to update page table again
after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout and flush tlb.

With the following patch to add bitmap_mapped flag, the retry fault
recover will only update GPU page table once, need wait vm udate fence
and then flush tlb.

No change if using CPU update GPU page table because no vm update fence.

Remove wait parameter in svm_range_validate_and_map because it is
always called with true now.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2b4ccc0531e8..e195106a77cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1454,7 +1454,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 static int
 svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		      unsigned long npages, bool readonly,
-		      unsigned long *bitmap, bool wait, bool flush_tlb)
+		      unsigned long *bitmap, bool flush_tlb)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev = NULL;
@@ -1487,8 +1487,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
-					 bo_adev, wait ? &fence : NULL,
-					 flush_tlb);
+					 bo_adev, &fence, flush_tlb);
 		if (r)
 			break;
 
@@ -1612,7 +1611,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
 				      struct svm_range *prange, int32_t gpuidx,
-				      bool intr, bool wait, bool flush_tlb)
+				      bool intr, bool flush_tlb)
 {
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
@@ -1741,7 +1740,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		if (!r)
 			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx->bitmap, wait, flush_tlb);
+						  ctx->bitmap, flush_tlb);
 
 		if (!r && next == end)
 			prange->mapped_to_gpu = true;
@@ -1848,7 +1847,7 @@ static void svm_range_restore_work(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+					       false, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -3094,7 +3093,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
+	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
@@ -3643,7 +3642,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true, flush_tlb);
+					       true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
 
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA13C4707B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF0610E3BE;
	Mon, 15 Jan 2024 22:51:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F39B10E3BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzP3VmB3MBF0LN00KHMe2q8czd/M543/SMQAINI+qZR7VS3nCL5dHQA6c2jeqc/XA8oovSk2FBJdUnhd8b78XL4vLFJE3PR9Cz1MOer0Jgay1xfD2ANhoAE1wiPPLR7w8LkCv7OS6kzA5C/YlPzWkfuq4SeYs9oWt/upXNOQ/bcjUkfh5nF2HZAisCW1335M9QIDiK8/uaZAI1N3l5fVIPACbFDGxoIq4HVKGgUXNkO9WTASrsJ2Fdw7SbFbexPCUXzZG4OvO2EofSUoSYcHdN8Qh+pC5hY6JYXfb3mVSbb3POzFExAzhPcJMvXsoKSSBLgtgtFq4JuOb6uGLExgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBDxw/BcctJVy4K9SjP8p5sRz9NOIc/5Pjfs1dnj+dU=;
 b=lEB2CDstu6xxjiHUqxhNP4+E61vPX92mTazN9snvlx9ZVv658pJaGBILcvIgelrpDtzVMhNw+QikzW5L2IKegd4gbdgfImpnTw+bIf2FgQjsbd9dcxQfMJPJrVvUS5UcnbrZRcI5l2RHVzQjFhIkJxgiDXF8egqLpHEOCWrIrMjbBgAHY9lOY7kSxbG7w2royloqFVzT+o1VxHcKEb3r4nq2Dj0ZU6Ix6IM9/1c/i0l3Bx2r5HZqIqLTYXxaIG4EsHom6QsAtzaRgw9sKcp/aDLm09R0lXKqVYziVu6ODq+JT0kbjCqlHSN9OuAt9W7uKwmpAryvI61wuhLvtq0ECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBDxw/BcctJVy4K9SjP8p5sRz9NOIc/5Pjfs1dnj+dU=;
 b=28+WoTfjVC0lsvjBzcfj4aSMBaZAcGJ7XiVXxKTsJ0I3yKW9oeSyIU4D0LNS16VNO/94fygLmcqUA7OaEMYrT6JO3wR+M/gJ/kuiGvBw+KehfAwzepJ9FgBXxHg/zh8sOO8r1CoKkPtKvD0UEnc0IKiyW5sCzrPdDyHPlaLtwbQ=
Received: from SA9PR13CA0156.namprd13.prod.outlook.com (2603:10b6:806:28::11)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 22:51:25 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::74) by SA9PR13CA0156.outlook.office365.com
 (2603:10b6:806:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.19 via Frontend
 Transport; Mon, 15 Jan 2024 22:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:51:25 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:51:23 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 7/7] drm/amdkfd: Wait update sdma fence before tlb flush
Date: Mon, 15 Jan 2024 17:49:50 -0500
Message-ID: <20240115224950.3300-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240115224950.3300-1-Philip.Yang@amd.com>
References: <20240115224950.3300-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cada165-92d0-4c89-d356-08dc161c80e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bextEbjfTr0HK5VSgRkT5qj621QsK+ASaUtGRRkW59mLmS2Kx/Wavd1GPCNIMpGFPv4XnHGvDeOCwRUbq0wFJV5+AntrR3/r9Qw3PL29fBB19kyV9OBLi90zRdrLANZjeWdo5d/6TRSIkfVnY2hykWTLLeDWLbYDeQJhwpUjrV/hbbFI2P7f6pp6HJDjYA+yAQ7WDsZw8IVsynh17OjoD5X+WtgI+FtxuFXGCVtcNFY56p6K7fdr3XXQDLxPmQ+89yRPUud2HVl3pkUkv+iVjGJgR39flHMXkoFC6uy2bDwX4rgIGDIwgDeb5rOA1rQmfmxnTamS6asT76yz2zOeLtuM/W+Gq9kaAcqvosHGMr0nzxVMFtVr97UhDFRT3LQ0tUzya8cAq7gUFx6OxvSAlZ0OrNI1bgM1DKVYk6xjoz8fDXAq7t2Bk6p05PTa4cpe6s8mSGGF7ICm9Tz8NujmwCMQ6iHl8w+SaG2nuQJj1wvi7uOolCDvdJKyN9KkM6iebwBnJRgOrTlP3Eb/ba8oxXvmPWXUHF/XECGZHvVQHVI1RIVV84aPtjWFf67WNlqYe0gf1r8zJStwLZmHmIMqPO3kzFZs81rVaTRJPg+hGaBl4ygBQqoKPGj168N89e4Z93OxUbivv4DrVTQNBhfsfnMzCRR7yJ5VwyLJdy0tolKTvmJQ+ZJZxXRNAuhpxB8gsBVevuG/At3mtgVdzRZxg1tLSw58XvvhFXekC/YimgTlN/Zh98BYQ9i6KJFmkftcljEVu/Xh5DvqE449rDbAuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(426003)(26005)(336012)(16526019)(82740400003)(356005)(81166007)(86362001)(36756003)(316002)(83380400001)(2906002)(6666004)(7696005)(478600001)(2616005)(47076005)(6916009)(8936002)(8676002)(36860700001)(5660300002)(4326008)(41300700001)(70586007)(54906003)(70206006)(1076003)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:51:25.6477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cada165-92d0-4c89-d356-08dc161c80e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
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
retry fault will come and update page table again and flush tlb finally.

With the bitmap_map flag, the retry fault recover will only update
GPU page table once, have to wait sdma udate fence and then flush tlb.

No change if using CPU update GPU page table for large bar because no vm
update fence.

Remove wait parameter in svm_range_validate_and_map because it is always
called with true now.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b36d997e7a3d..9e5f6e12c498 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1677,7 +1677,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 static int
 svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		      unsigned long npages, bool readonly,
-		      unsigned long *bitmap, bool wait, bool flush_tlb)
+		      unsigned long *bitmap, bool flush_tlb)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev = NULL;
@@ -1710,8 +1710,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
-					 bo_adev, wait ? &fence : NULL,
-					 flush_tlb);
+					 bo_adev, &fence, flush_tlb);
 		if (r)
 			break;
 
@@ -1837,7 +1836,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
 static int svm_range_validate_and_map(struct mm_struct *mm,
 				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
-				      bool intr, bool wait, bool flush_tlb)
+				      bool intr, bool flush_tlb)
 {
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
@@ -1950,7 +1949,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				offset = map_start_vma - prange->start;
 				npages = map_last_vma - map_start_vma + 1;
 				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-							  ctx->bitmap, wait, flush_tlb);
+							  ctx->bitmap, flush_tlb);
 			}
 		}
 
@@ -2041,7 +2040,7 @@ static void svm_range_restore_work(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, false, true, false);
+					       MAX_GPU_INSTANCE, false, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -3303,7 +3302,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 
 	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
-				       false, false);
+				       false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, start, last);
@@ -3847,7 +3846,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		flush_tlb = !migrated && update_mapping &&
 			    svm_range_partial_mapped(prange, prange->start, prange->last);
 		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, true, true, flush_tlb);
+					       MAX_GPU_INSTANCE, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
 
@@ -3863,7 +3862,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		mutex_lock(&prange->migrate_mutex);
 		flush_tlb = svm_range_partial_mapped(prange, prange->start, prange->last);
 		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, true, true, flush_tlb);
+					       MAX_GPU_INSTANCE, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d on remap svm range\n", r);
 		mutex_unlock(&prange->migrate_mutex);
-- 
2.35.1


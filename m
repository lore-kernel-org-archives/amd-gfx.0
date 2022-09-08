Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A5FC38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 00:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D94E10E908;
	Thu,  8 Sep 2022 00:17:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D294C10E86B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 00:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSpnltXE5UIEDaxIy1hhR87rbqJmTCl/Fwn9ypM7Ta4a/aFhUrhF96T7fbe70UqZIsZr1YCbDBLHp/UbYTTUv5d4Sls8cZa1aIdINYZMUn3QvakJkYra1guJvZtMj9jlJy2EnOkrEscFTOZ/PX/a00K571FdLa0Yiieng03OyWAGHHLV1fkduDHClJptSKPkXVn5gHQreGU4vJa0h//JLCluB3OIcjKVRLcC5DmNUFf3aUDRXoZH7vl9e5TXh++cWfh2YBR3EyvG5q/aW4RMzgfDfyRWG2CQ/mi2vHEZWdYnRGbwL2Y0NlrFUoJ3TVn0mC3zH0z2aX2U5aUpmxB0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aERrfY/7AYhwuz5D0yEuOyaAultSn55fMYVnMNDHRAM=;
 b=SfEA3Qij8TSwWEfbeewH2dqHKLJK7I1lf+GTObMTJebFNiVXXJAzQlmYxyzKdGzn9Qlg1APUO7pGRQP4eJ3Bw7BfFj8nydlcP0Z6XtIkSoxEm/K3mH0MXGt2isnpZ3qMjdsAF1mujb/RG3UIRPizksaN36lOKzLQkYna8N1FzabjoftkruPXCs96YUtwCWr5FOcG63cCt8/gqRHk+oSSxeTP2axcmd9hZCYdb3K7HsVMm67m/b30IZY7cIXAmfFUsadl6agHqRV7+CkGJVCQ7YlUoXLa8so8oTnJScs1BHtE9OoLXH2ivnLLznPzN5zxjNjPWy7Z71HpotFpOaSaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aERrfY/7AYhwuz5D0yEuOyaAultSn55fMYVnMNDHRAM=;
 b=ooqLW/wKT6TYknirKZcTziNPLbc+iTJj03VFS6c9W3YvtvWhO8Ih1eK0G6Jm8eqTaFjOsl/qkq2Fngn3GBK2WaZaPcVCx2BCChN2h7i3lE0BOhKvNcS5P0uIPY/I602xoVkhos4BvgfQrEaoJk0AGpjYDmE8VL8lZhuS8Idz50A=
Received: from DM6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:5:bc::17) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 8 Sep 2022 00:17:28 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::89) by DM6PR13CA0004.outlook.office365.com
 (2603:10b6:5:bc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 00:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 00:17:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 19:17:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdkfd: Remove prefault before migrating to VRAM
Date: Wed, 7 Sep 2022 20:16:30 -0400
Message-ID: <20220908001630.15437-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908001630.15437-1-Philip.Yang@amd.com>
References: <20220908001630.15437-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|DM6PR12MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 082c5e5d-7f19-47c9-0b74-08da912f837d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ISO5ig0x2rwxw4k3myCazHRriBy/+CDd781W42DLQ+Teqh0BZyPqFi5AbyQcWt6lldhOqENDbYQk722Iptynt8217pBaXxPgoV7zfiTvmTTmSjfGK9vzynaSPiT12v1tcFVFK9bxeTB+KUvaDFYqWBOlYfoikzAu0UTlxg6PeL0n2UaoMv7d3fe0kTdemz4Crw4kg4tMt3pcnaRww1xztb0EI9xKx2ju5JrBldNpSgH+qpUmsO7qqmew0Egh567yXqEAJ4atYjFfgjq92fWF8EiQ2HQt5/c7Ez63lFbNsT4Ykx9KiDKSvSluIzINrEiwhv0DiS/CM8KwJbIjDGYG8IeUWAmAGqrE70fNQ+dkKLWML4x9NoIm1moXSRco1rpaFM4e9u8Qb9vDH2eg3yJAfpBjLP6MQGrpkWcw0FiofsJMjQ0d3IlHyGuxYyrxTpXrLXxHF5TeGkPGEudgIMWo8NhBa+BlOZA2JzHzCtopCeJem2zMQhJMizlyR/Fbl/fhK/qoW3EQNCKST25r3TGs3hRccRbxeofDwoxEJQvHWfqfLHFZOIjdAF/6otZVt7tKonMTkiK9qrxlVwmu7FAOnEBrUUnAuq4FG3tStFLVePMd1wdAT5ziUd3ceQcttfXHwfxBDbk+wrZGNKF7quozSS08ECoxjLtcpej/V6G4xKTIUHcKohtJBMplRdPjHKOLXixBxsr3Xu2NRVRC4nG2hQ5VLwn2zQsNGlpKh/aJM6eD/AdGRaHwtss7f3Qo0EUn/fIPVJBzpzhMgq48Q6I+j8OMd+M/Gm59cBHdMO4roc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(40470700004)(81166007)(47076005)(5660300002)(36756003)(356005)(2616005)(426003)(186003)(16526019)(83380400001)(336012)(8676002)(4326008)(40480700001)(70206006)(70586007)(1076003)(8936002)(2906002)(6666004)(86362001)(7696005)(6916009)(82310400005)(54906003)(26005)(41300700001)(36860700001)(40460700003)(478600001)(316002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:17:28.0909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082c5e5d-7f19-47c9-0b74-08da912f837d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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

Prefaulting potentially allocates system memory pages before a
migration. This adds unnecessary overhead. Instead we can skip
unallocated pages in the migration and just point migrate->dst to a
0-initialized VRAM page directly. Then the VRAM page will be inserted
to the PTE. A subsequent CPU page fault will migrate the page back to
system memory.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 +++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 22 ----------------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 --
 3 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8562dd0eb4b6..f62c4561f0f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -322,12 +322,13 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	for (i = j = 0; i < npages; i++) {
 		struct page *spage;
 
+		dst[i] = cursor.start + (j << PAGE_SHIFT);
+		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+		svm_migrate_get_vram_page(prange, migrate->dst[i]);
+		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
-			dst[i] = cursor.start + (j << PAGE_SHIFT);
-			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i]);
-			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
@@ -522,9 +523,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
 		 prange->start, prange->last, best_loc);
 
-	/* FIXME: workaround for page locking bug with invalid pages */
-	svm_range_prefault(prange, mm, SVM_ADEV_PGMAP_OWNER(adev));
-
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 11074cc8c333..cf5b4005534c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3181,28 +3181,6 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 	return best_loc;
 }
 
-/* FIXME: This is a workaround for page locking bug when some pages are
- * invalid during migration to VRAM
- */
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
-			void *owner)
-{
-	struct hmm_range *hmm_range;
-	int r;
-
-	if (prange->validated_once)
-		return;
-
-	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
-				       prange->start << PAGE_SHIFT,
-				       prange->npages, &hmm_range,
-				       false, true, owner);
-	if (!r) {
-		amdgpu_hmm_range_get_pages_done(hmm_range);
-		prange->validated_once = true;
-	}
-}
-
 /* svm_range_trigger_migration - start page migration if prefetch loc changed
  * @mm: current process mm_struct
  * @prange: svm range structure
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index cfac13ad06ef..012c53729516 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -181,8 +181,6 @@ void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
 void svm_range_free_dma_mappings(struct svm_range *prange);
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
-			void *owner);
 int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
 		       uint64_t *svm_priv_data_size);
 int kfd_criu_checkpoint_svm(struct kfd_process *p,
-- 
2.35.1


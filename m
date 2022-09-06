Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173C2ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 19:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C02110EA55;
	Tue,  6 Sep 2022 19:34:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08ABB10EA5C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 19:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCqhghA03xNqQU/chOWgR4N2sjptHWfsUmH8bk2Ya+VaHBFf2yfCUjNQU+Y71WhOF+IghyQLRgqKUL+CISltsmb46/Ye94b3O887FvUG93oVGR7QArHozfPHt3YJa5DC3CvmaUk1k1txLSl8uGjz6Dqm3ZciEdGFUGpuzfg2UCChN6ye7/c6I+d2dDwp2di3Fqq4wbsS07aWIlb2opYKKsNs07c/Y75UCPGQDcMxgdZc8wlDnBXIjcPoVxw8n8T0u8Hmz/uu7nPrCDKOt+xajWbPjxONFgFQkLWhyR9ME5s5DODXEzf/cCW1MLnTtfDZzVr9yEA7o93onpLf+LY6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVETb5SRPMTliLVgw5wLeZFmWXRdV5gJybdN/B289v4=;
 b=YKhCeo9DI1E9j1TaiYMHsBxgJ0bkCmqY6/eLQEEm/EiSCnSyC9Hz+QRGq+Imv0P6Rwf1UVch9fiwfzUpsmf2jRl9gJCgde4TRig1cA7rGVayl42tLQEHjSNUCD+k8wIF+BO+iMc1ioiYGF5hdfcipsraz8sF0qAY+9o4TrvppS+9EwGljnszv4VRQbMpkPehl94mdNi32us19Dx5hsPKQyuJqOpR+spW3ymsDpWulrBvBt1ZcuHFpOPlZJue1eNuoyTHuTRbMDdeNqaYKgUNejTsHCJ7An+eQg/9VU5NdO8Bnn5I/umxA9wdv5UvC87wn3u4LOoJGnPP77PJ1zifTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVETb5SRPMTliLVgw5wLeZFmWXRdV5gJybdN/B289v4=;
 b=uqJ5TgB5I2V1TtE0kWqgkW7UrioyzzHNU09H+nvIOJp59ms1O4CocTBB5i68Whub5hzxvMZ0tiHNkq0xkG5K8dzFwpN/ONfXZUlfQYi0hHqsx0BQxCGJTm1siX3AYgnk6fSc8XNXTEKp4FGcDkDY2W5R4LAxdfFOYvwqnURevVQ=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 6 Sep
 2022 19:34:45 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::e4) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16 via Frontend
 Transport; Tue, 6 Sep 2022 19:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 6 Sep 2022 19:34:45 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 14:34:44 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Remove prefault before migrating to VRAM
Date: Tue, 6 Sep 2022 15:34:14 -0400
Message-ID: <20220906193414.1261-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f32685-4001-4b01-eda0-08da903eda99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HE1wsdDuX2Vh12ZiwGxVhdVLtdx+emk4hioilk2KjvnEy8PKFN0RvkulY5iY7IMT7oCcNhfE7WmbX7/OETr7tVwl5rRtWLIOm41V/LepgvhhBExqAaHMZwAJImnXHRgP0sQpezT4saZrEQRSDIbIfcO15nez/lomiSTrHfSNMQWaz8BH2ZB+e4w6zmriWjHjSPQL//x21y8rhLqUxg/D/IyESuJSZK0FDlR7IokS5BYtlqmvvp3VWBC31fXj5mpFAnEnaTnoJPv6SGcyC1etY1QVuOdw/U6otkCE1NtpeT/ortjuD4ScRP7Qlynorns/4e52m+O7ZstCFBVkiLtfTUPSxXvOAe3dxKJkpxMne+0zx+OQm8ZXBGCsDkOJWf0TEV83AXKYZuuBpFiE3IYV1HxoLSdKF/1ChKoTjyCnCG0ZY8QawkdUE7c3gYFPlUOlHZJqjDz0ns8PVbOASEHHFh63PG6/N2iv7pQ4IDwZwMdTz99WLZKBTWzWENw1RXThXgvSRWXud9diQ4RyiljlCmBKHkVuRtcQicuUmFiOlA9ygY1RvYG0KGyE4sg+Ia7gw2bi80t2fH1PmwgnlGKRqOK32SzQZUOjJ5k0lnwXYTAVEAcztHOari4z6YpHocMu9IS7ZX9rCGFOowW95Cq1MbFpzj3EEFc2wV04jdl1zSwblZrxmDwrksxcd3be/UdmoPiflYanBz0CKGXgJgXVMCQLCN4dbv6q2L0t6sD+iWdEhQg71UFTtkhXCUi45EEDQ3Isbk2yeJiSr4wF+aAcFNfc9Pj1OdvaUcRIK1qKnWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(86362001)(6666004)(82740400003)(54906003)(2616005)(41300700001)(26005)(356005)(1076003)(186003)(36756003)(16526019)(426003)(47076005)(478600001)(7696005)(83380400001)(336012)(70586007)(5660300002)(8676002)(70206006)(40480700001)(82310400005)(316002)(6916009)(4326008)(2906002)(36860700001)(8936002)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:34:45.4364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f32685-4001-4b01-eda0-08da903eda99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
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

If svm range no back system memory pages, migrate the range to GPU VRAM
don't need prefault on system pages to migrate pages. Instead we just
alloc VRAM pages and setup migrate->dst with the corresponding device
page and skip the page migration. The device page will be inserted to
PTE. Then CPU page fault will migrate the page back to system memory.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 +++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 22 ----------------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 --
 3 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 373e5bfd4e91..d3ebbde21241 100644
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


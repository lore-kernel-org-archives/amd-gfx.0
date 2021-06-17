Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F61C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 14:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180C56128B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 14:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180C56128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC416E8BC;
	Thu, 17 Jun 2021 14:09:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4986E8BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 14:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC0xup+WE3xYc70QTzX0OlTNA8CSsQRr5JwG+rAUEJRl+s4DqTq6kAzat2hO4oAwUG5wd+VTtfn4RZLSjcQ3mPbtqu415SoDKdmBnl0idxKxCb0S0X8UrY00pP28/DVq6is/hcF/4Q9POKq2dy9wdZTLm9DXeWwInmdSvji1lMtpw4W/rcy634EKzd6XhX9uo+2R84SBH2efrY0W4VcQiufIXgPy/NElF5vZ6lZmny9hovawkxK/i/7PcfiRJb92ebTc/zPghPxR7FmssZHIwUDThhfMyr4lLaTB7DePwN/5uZcJOAwCs0EeNNmbMzFHwDXPEbHMHaJU4iEzp2GtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olP+sVujJrkNjDuk1SA18InkykzE3WcFw8iKRhVOg24=;
 b=BjU0OyxpqW7qd9CgLHdb3hixYW9EduOnq59FdcJVEjRp4MCfWghJznvT4LuoTRHbUMVan3ohRchag9iUzaNiq0AViouHcxUEcXmiviYw7a9Bh5ZBLO5DtDeLsJHqcTiEnsyeGr/y0oUzgj+yfxR7gW3n+mBzswGHybmDEEhESWDV4+UxDVLRHJw6s4A7//jttxbZ/KX75jgCpGDOJk7M00Pl9+f7uK6ZcB7eW7Fbs6tDdoRrNmWrnCCq5Fz4nPKAHs+/IDFLCPgjqRRFnlarPZU1tPg3co/IxFL/PEdoirP2QsTBXrn8mnIRRGkGpNzU8fiohtlYnCT51HwFsGoQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olP+sVujJrkNjDuk1SA18InkykzE3WcFw8iKRhVOg24=;
 b=AKvueSXJlnjfijjupSfHUZ7dsGPPphftRoKih5E9gd5iPQDDjtfncMr9D7mVyRJtamziuoh9KJk89FjR+qf0MndGFs0wbHD6Q6rvrmANd4929NVR6TZmFK/tFL4hAWskky5raIIqnLcFd0jeUOwbw0Nhdnja+FEyxyCi4LCygoE=
Received: from DS7PR03CA0250.namprd03.prod.outlook.com (2603:10b6:5:3b3::15)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 14:09:52 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::ae) by DS7PR03CA0250.outlook.office365.com
 (2603:10b6:5:3b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Thu, 17 Jun 2021 14:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 14:09:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 09:09:51 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 17 Jun 2021 09:09:50 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove unused parameter in amdgpu_gart_bind
Date: Thu, 17 Jun 2021 22:09:48 +0800
Message-ID: <20210617140948.2558103-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e54e32c0-8c73-469e-2738-08d9319993a2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5306FDEA1BE74480717F2435C10E9@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tv+ETWx2xn1pfiEv3PFIvBc814YkggMXOdH/qRQaJSBRXddPJSWFafApZ4EozYPz2PEpUTsVe7YJcsqS9msr6QwDwNdtcqsqLrbKEGqQCIEKYpy5A71DVn0BBGgoD3HF0Cxmv4+PBd6PxblzlD8N+Uh1/Z7lhxhJxqhz5VC0QCAd5wzJtIrU9/qcJCIbaU0NPkMXqvZ0WAFpCP5NNbstFY6l+GFQLVLlBw1pgFipJESjzyuDJPjwRC7NCKqugi4GmvLgqWtmUp/8y/H06Z8zo1V/8ErwqeRxMJiU/xquiyG4ZvzwEkuY4KCTIn0P0Ykmv7wp6MgmJVTr2+I7yQwXviw0xnhE/GjVNYkXaqB+iemstkp8bMN96a9R1fbquHysOO+AZld+to60uFEz+m2nZd/A54NMbMAmGnEaG3pMypavWzkCukDCxyQysPWxlmuCyK0mbaxx7Y4XuFVc+7+IQdOGVEvZj6hWbIY7spToZqHlHV/Ss3KvhGTlsU56PDcPFVgGZkwIaTlNHsfa7gMj7mWX/h/ZJL3lAV4igpu1MR/Nye+1OaVV4dgx2CKVxScSpumSq5f2Ho01F8PBvJyYHuHQsH6EsPv8is5HIk7uRXrAMojKw4Ac9kr74AadsNsZedEbenzDbjCPhlEJHrOvL9V8xhXjMkFyU+nu1ygdv8vk1IXA4VnLVUYLd2MNjvol
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(70586007)(82740400003)(83380400001)(86362001)(2616005)(6916009)(1076003)(336012)(70206006)(36860700001)(82310400003)(5660300002)(36756003)(356005)(26005)(4326008)(186003)(8676002)(81166007)(8936002)(426003)(7696005)(47076005)(316002)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 14:09:52.5241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54e32c0-8c73-469e-2738-08d9319993a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After commit 72a616bb953329bd97c6d6d4c64f3f40ed788a36,
pagelist is no long used in amdgpu_gart_bind. Remove it.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 7 +++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 1091ec5d3592..9fbd1e62948b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -300,7 +300,6 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
  * @adev: amdgpu_device pointer
  * @offset: offset into the GPU's gart aperture
  * @pages: number of pages to bind
- * @pagelist: pages to bind
  * @dma_addr: DMA addresses of pages
  * @flags: page table entry flags
  *
@@ -309,7 +308,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
  * Returns 0 for success, -EINVAL for failure.
  */
 int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
-		     int pages, struct page **pagelist, dma_addr_t *dma_addr,
+		     int pages, dma_addr_t *dma_addr,
 		     uint64_t flags)
 {
 	if (!adev->gart.ready) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index e104022197ae..6ff87de620db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -64,7 +64,6 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 		    int pages, dma_addr_t *dma_addr, uint64_t flags,
 		    void *dst);
 int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
-		     int pages, struct page **pagelist,
-		     dma_addr_t *dma_addr, uint64_t flags);
+		     int pages, dma_addr_t *dma_addr, uint64_t flags);
 void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e8033b6f2395..6297363ab740 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -857,7 +857,7 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		uint64_t page_idx = 1;
 
 		r = amdgpu_gart_bind(adev, gtt->offset, page_idx,
-				ttm->pages, gtt->ttm.dma_address, flags);
+				gtt->ttm.dma_address, flags);
 		if (r)
 			goto gart_bind_fail;
 
@@ -871,11 +871,10 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		r = amdgpu_gart_bind(adev,
 				gtt->offset + (page_idx << PAGE_SHIFT),
 				ttm->num_pages - page_idx,
-				&ttm->pages[page_idx],
 				&(gtt->ttm.dma_address[page_idx]), flags);
 	} else {
 		r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
-				     ttm->pages, gtt->ttm.dma_address, flags);
+				     gtt->ttm.dma_address, flags);
 	}
 
 gart_bind_fail:
@@ -951,7 +950,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
 	/* bind pages into GART page tables */
 	gtt->offset = (u64)bo_mem->start << PAGE_SHIFT;
 	r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
-		ttm->pages, gtt->ttm.dma_address, flags);
+		gtt->ttm.dma_address, flags);
 
 	if (r)
 		DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

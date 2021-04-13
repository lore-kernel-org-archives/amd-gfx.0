Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB427C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 17:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE6D611AD
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 17:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE6D611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9556E056;
	Tue, 13 Apr 2021 17:17:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440FC6E056
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 17:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5kWL54cSO4wZp2eJx+CtjozaVDCQ/yMvTyuDu5/NxNm5dRMBUS0ek3xQbTgJNigz3uxw5oRPAxFfW7R36cIlvTh2uNqFJsGBkcXS3OAJw1QLapfNnO7Cjr0+AZxixHUzz2j8wMPaJSj1Y5Fa8uD6a+uW6Lw3eCNfTtEMcNFRtVkKAYvWEn4ISh5naUEC6Ku4OrzvWlg4kEXiDCVV+f5v6T6p+T/s7rWCX/Bu6lFcQjIEgrjmSTXbWVT58oSKuCEqNdiYYA4/GNCMFC5lv4WygxM2sx2SImPdFZlaLrklkR/BMEIFA7Xj/JM0pWLPgyimoli0Y8H9oZveM6Ol7hr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pCYCghZuIAnRhOCTJURboMGa8ITcwCpi6pVGxPo9cM=;
 b=bA0v5X3D/gA7seRvKvejxdC5y/aZ9EgwKiOvjIZ7HTsr736wnQzSCU0/dA4uJhUpxoX/eMzFRY6Lk7GRuaVe274Cn4SbwJvJyXxnmN/WyKkfN0fUx8yerh9E31MUTEzZHJ3kroESWuVamu/SS8sK9TUdHRrAXY7rov+F7hslOF2HKCnFUue55m6z76XuhfZG4Q8ZTOWrAe+Cu2dK8YTd+z7L3gxL/NlkglHia0gWF9IFdSRHb+CViDNf4rr+av7NAC2T4mj6GsAyyPXEZNgQ1DGliijSOobNSd31/uLNrJgYVIQ85RfvEOGga22oNYxJLWiEKZ2/zMW1Ko6bCacNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pCYCghZuIAnRhOCTJURboMGa8ITcwCpi6pVGxPo9cM=;
 b=mXWVZ7CYJvHwKoKpCWtR0quk8a4ViMyA3G0USETYSHSL/gvm3FzaRIEUGgSmOiwTSWrAWmhD5AK9QgLNcE6JnsAwmBcYSqoP06UR3g1V8EnjNfFhKTLHsSSLtP5F3i3QZSo9Tjp0DvQeCIW6QqdcIWH6Rs/CgKW3a6RHopudTi8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 17:17:46 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:17:45 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use iterator methods exposed by
 amdgpu_res_cursor.h in building SG_TABLE's for a VRAM BO
Date: Tue, 13 Apr 2021 12:17:36 -0500
Message-Id: <20210413171736.12102-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN7PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:806:122::34) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SN7PR04CA0119.namprd04.prod.outlook.com (2603:10b6:806:122::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 13 Apr 2021 17:17:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5988c79-0ffc-4f3f-bf24-08d8fea00d81
X-MS-TrafficTypeDiagnostic: SA0PR12MB4496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4496A08FCA077B2D9B1F1B6AE34F9@SA0PR12MB4496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLgDHUj3gVCI93CGxXm1CTOeQ6laZLtzKK4+6MEM/FO2Db+rWWZGlTSMJNMbQqH+RNrRm2hPlrFGEj5bPgZGrf8cDzdPVGyHBgNxs1kK4msH3EZKHCqXGdqC0C2QgGywZBY5B+bTp10+6HNigdc3ZFJfNdNNqrFewKfmjtkEzUmH4ziIqs5XMw6FamNb/AgxzGm/QAFnaIUNMdYMiS0f/ipRjZ487Kr5/Y6sye1TTPNYTb4CqBODiJmY0G/cFlXP5MgwnWH2bI5bc/3rLEEDZbeXWvspteFEceIDPovyDG2ly4sTgFVyoQbImtg5jlYBX2/5/ZcRtmb2nC6yCaYBBVSpmZPQ1SrCk5sksFXK81aTLzXH7rYMxqtYDdUOf/IdGuTSisUA5PHMQ2Xho432VgX67AGr8IrywgnRFDCO1KYQkpMje/GmtbCmWG/3yEJ0i/Wh+nzkN3dS1Ejwkeh/tvnSneX9A2UtD7gsiWOWuuqnmrqDXhs/QEY2M+HslvYuV1YA/0DHEDj1kfbd4ku6DQCCydNPyI5qHo7uD50vkNMsmoXOk+a1aCOp1vH53LgqfsAx1W6I7MG+6k0fcZfF83ytFECVVFL9gRs8Dy7P34Ai05KhKy1nUKJ4NQr1Ov3LUNaGK/K6cGSOwjVZGH887D/FsZquVyXsyyGuEdsTazQ4ensqtNN3k3WgrKqlXMm2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39830400003)(396003)(376002)(83380400001)(38350700002)(7696005)(26005)(66556008)(6486002)(86362001)(36756003)(66946007)(6666004)(38100700002)(4326008)(5660300002)(8676002)(956004)(52116002)(2906002)(2616005)(316002)(8936002)(16526019)(1076003)(186003)(66476007)(6916009)(478600001)(31153001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FFLwnhVAL+M4kFeUwXal6a+chPXiPSJcpk7mTMH21WTGd0S6PGwPq2X8J1TE?=
 =?us-ascii?Q?lmuUUSZv0raU61qT5TJbUiHXYDTv2YUj0nx1kUopYGVpV8Z3ouim7bHIeK+3?=
 =?us-ascii?Q?oCbeT6uKwNPT2itLLt/gqN4fIq++YJQEdbuVZID2QxusvbhUaKUSK4XD2YuM?=
 =?us-ascii?Q?iBns5HlzEFgIB8cp0YhTB9LgZwNBNST2TjaUv5+Zv7ztA0Jf5ntlp7NJt0/A?=
 =?us-ascii?Q?kddKiPRj/XzupX+Jwh+ylm4P7lGuXr8zR45OnAB/ccA4H4G2Tlu0vCPG82xk?=
 =?us-ascii?Q?hvxUtsPucnPrD6+vdFhcFmDUHeA3n6u1mBZS4/XgFsPfpRP3+oFXUnVJpurC?=
 =?us-ascii?Q?9u5rqQ6nY5fUpx7dWC1LOODVEeYC28rNtvCWLPFGyMzcuSci+vFAGrWqLlQH?=
 =?us-ascii?Q?WYVwkk7iPf397gfdnKSa4xcQziq3/wm61B88bfN0Vq389GDGnnsUROBh2ekD?=
 =?us-ascii?Q?11ObPKYwQdl13I+3CED8P2xKhoDFXUWJ5Zgt6W0QCVYD8EonYT6IUkHxSb8f?=
 =?us-ascii?Q?72R5rlOg3fLnnncYsuUQly1N/vrzTmL98dA451bAUGr+MiNa4DKstD0mznnO?=
 =?us-ascii?Q?4ouoSfsV6/aWnSoWbBQfva2m2svMPdFXU0a8uyWSjNXwBP9NB0ohBk9FNy95?=
 =?us-ascii?Q?JuXKPWOsETTUh5U1Aj4kxptphCGITXFNNBni8Kq0ILPrR2i4Yw+agCQOX77+?=
 =?us-ascii?Q?12sQjKiMHcMgV3xHZost5Gw4Jo4kHcA4Jx/V7uB2rt36OnRREdExkjlBRHCW?=
 =?us-ascii?Q?uHZjzltNl1DmYpN4PdZ+IPsX70RxK+WezA6CN+Wxs70G9RD9ikJRS1Jna2HS?=
 =?us-ascii?Q?pVP4CCygyrcsHKUTcEDPileIQ9FyFU8RzwwRZbd7/dV3Ea3bvNYgmWi+wqjg?=
 =?us-ascii?Q?hpM4t4U4MYDEP0KFLGHPn1aU0jAtl2VBKPONeIKXVdeJ6WXdCocMrSkFvkiz?=
 =?us-ascii?Q?+mTO2FrThePZFFVmJxZfeyE8XpiH6Kp7em0NhCVoBPByFSKsaE1aUKbpdJOF?=
 =?us-ascii?Q?1lxDLigvOWwZGPjETWO3hrrwY+fua1Tb4xjZBLPghoAd4aCJEP1NtqmpaW8A?=
 =?us-ascii?Q?c981uSkB9Wy2YFUThU1nFfAqGpXSEjyvxSnyP93I19zxAI0NaQcSsg0nV4fH?=
 =?us-ascii?Q?9yvfFqIHIdZm3zTkSppc7FEnq5HdNdrjqSfVFH4sy/MvpMuFKJ4l9+HW6scp?=
 =?us-ascii?Q?RmQsscbatIxey2GfurQ++UHX+1x/Kq3d7Ahgxw/j2tqYSgp1XM1afITF8T+m?=
 =?us-ascii?Q?4C8eQmL2gumX0UnsiVVjeey6viyKgERg/jx3t02If7rziTkouYeHDyFotMQ3?=
 =?us-ascii?Q?snmDBlgSagMCF/2wRnw195BN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5988c79-0ffc-4f3f-bf24-08d8fea00d81
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:17:45.8068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2tjihfkPWREsuRTt8G8K8U8PFk5dSdPukEbY3pBIVyhZ1N7syNy+9lYZ0yyXSWnptXtEucFAGgvNA5CyzS9aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend current implementation of SG_TABLE construction method to
allow exportation of sub-buffers of a VRAM BO. This capability will
enable logical partitioning of a VRAM BO into multiple non-overlapping
sub-buffers. One example of this use case is to partition a VRAM BO
into two sub-buffers, one for SRC and another for DST.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 34 ++++++++++++++------
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e0c4f7c7f1b9..57534b93bd91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -255,6 +255,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct sg_table *sgt;
+	u64 num_bytes;
 	long r;
 
 	if (!bo->tbo.pin_count) {
@@ -291,8 +292,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
-		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, attach->dev,
-					      dir, &sgt);
+		num_bytes = bo->tbo.mem.num_pages << PAGE_SHIFT;
+		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, 0, num_bytes,
+					      attach->dev, dir, &sgt);
 		if (r)
 			return ERR_PTR(r);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index dec0db8b0b13..9e38475e0f8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -112,6 +112,7 @@ int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
 u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
 int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 			      struct ttm_resource *mem,
+			      u64 offset, u64 size,
 			      struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table **sgt);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 592a2dd16493..c1a7772fa8e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_res_cursor.h"
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
@@ -565,6 +566,8 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
  *
  * @adev: amdgpu device pointer
  * @mem: TTM memory object
+ * @offset: byte offset from the base of VRAM BO
+ * @length: number of bytes to export in sg_table
  * @dev: the other device
  * @dir: dma direction
  * @sgt: resulting sg table
@@ -573,39 +576,47 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
  */
 int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 			      struct ttm_resource *mem,
+			      u64 offset, u64 length,
 			      struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table **sgt)
 {
-	struct drm_mm_node *node;
+	struct amdgpu_res_cursor cursor;
 	struct scatterlist *sg;
 	int num_entries = 0;
-	unsigned int pages;
 	int i, r;
 
 	*sgt = kmalloc(sizeof(**sgt), GFP_KERNEL);
 	if (!*sgt)
 		return -ENOMEM;
 
-	for (pages = mem->num_pages, node = mem->mm_node;
-	     pages; pages -= node->size, ++node)
-		++num_entries;
+	/* Determine the number of DRM_MM nodes to export */
+	amdgpu_res_first(mem, offset, length, &cursor);
+	while (cursor.remaining) {
+		num_entries++;
+		amdgpu_res_next(&cursor, cursor.size);
+	}
 
 	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
 	if (r)
 		goto error_free;
 
+	/* Initialize scatterlist nodes of sg_table */
 	for_each_sgtable_sg((*sgt), sg, i)
 		sg->length = 0;
 
-	node = mem->mm_node;
+	/*
+	 * Walk down DRM_MM nodes to populate scatterlist nodes
+	 * @note: Use iterator api to get first the DRM_MM node
+	 * and the number of bytes from it. Access the following
+	 * DRM_MM node(s) if more buffer needs to exported
+	 */
+	amdgpu_res_first(mem, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
-		phys_addr_t phys = (node->start << PAGE_SHIFT) +
-			adev->gmc.aper_base;
-		size_t size = node->size << PAGE_SHIFT;
 		dma_addr_t addr;
+		size_t size = cursor.size;
+		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
 
-		++node;
 		addr = dma_map_resource(dev, phys, size, dir,
 					DMA_ATTR_SKIP_CPU_SYNC);
 		r = dma_mapping_error(dev, addr);
@@ -615,7 +626,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 		sg_set_page(sg, NULL, size, 0);
 		sg_dma_address(sg) = addr;
 		sg_dma_len(sg) = size;
+
+		amdgpu_res_next(&cursor, cursor.size);
 	}
+
 	return 0;
 
 error_unmap:
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

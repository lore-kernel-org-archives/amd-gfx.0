Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ABAC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109AE6052B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109AE6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1636E85B;
	Tue, 13 Apr 2021 18:26:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4D66E85B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 18:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfPlLv1zpkUNFmVPQwyrwgISqhWYkvdT60nioCpXrAqIOwtKlwDuGw5WiqrJ9apz2/zIktMsDXMSWKfu5rqgOUQGGxnBG/57lBDhNlKdtOsv7TY6cMui4Ktdfp3bONpXIpGVUQxgXuY4jLM7jIriJMG/9uF0BTL5cl3/NjeGh4fHL+FD2GUpMWSHn1UX+8xWSZ1755fzBUBe+ApoqZf8BX91Q5uek0hwXk3OvIwr+XZiniSRejrCnmrg6Uc+o9TB5mMhQpcxcpqyFEjSk07ekJwwHXn5eg0Q08YFdQ/4FDKSp3IoChUALlvhyfS2kRB3noTMVSG0YFyOLpbwLyN+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qDbCPUE+r8/1vJkIS9ceOJLc1wfoCCNWNjmADwwq3Y=;
 b=CINHdgCvfcb5I3opzFssqq3VmdjtxOLjoh50H3OzyRqiu40Hh/n2aUxiNFf5UTTpErEvxKqXp7Sj6LRGIS1lQCnjD6gKm0zCeUp4K9YHy4Ra2RIj20yUaWLtchnvH62ZyPa0FVCzTQFbPzqKZ4cPx98cslqoiskB7ve066KtriPWW5HuFC97xVRQHeWhdeM5UK92EVfRrGpljQUMgG09ytDT4RTUdHmNtsIRQxyPdnTwH8qEzTWIdylkforwk0Gccsv7XpZmYrDwMZCFK94ac84e41duQKxstkrP7MNcCaZqmzMdVTJXTCj5rFSGpeD1EJsJjjO10jsGViOjeZo5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qDbCPUE+r8/1vJkIS9ceOJLc1wfoCCNWNjmADwwq3Y=;
 b=4TOdhjVCd2Wkn9/4ZznjVpDKnUZavtinJZWTifY5sDeWgfRiEKBdxFxkd4t2mbxNAxgcYn/w7KEfWVM5nz/eexBEjVOaVCTRRf+TyNamocUOYdIYTlMG0Uh3Y9mgnbOqUztTYgFDNTZ5vn623Pa8Md+GafOLzhZwMmqZYVLOu7o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 18:26:17 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:26:17 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use iterator methods exposed by
 amdgpu_res_cursor.h in building SG_TABLE's for a VRAM BO
Date: Tue, 13 Apr 2021 13:26:07 -0500
Message-Id: <20210413182607.7367-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:130::21) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SA0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend
 Transport; Tue, 13 Apr 2021 18:26:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea080b0-04af-4d05-df19-08d8fea9a05b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25606F5C293192007DCFEF8BE34F9@SN1PR12MB2560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxuS2QcCGLIPwG6ariZFFOPl53gr2id/f1t12DM5ekDoAOPLXHmJQ4EJ6LAYwx0ZQtAMXqQelHwTTYKUPinfZLxgfKIz8C0ascgKJ2ixCL8tEzpI1wcJ20VPYon4ZYokNsFunr3LHb+RH9kxRngsjXcgJ6uByjGcjAi0e/goRAYQ15yXfHOrhW2Ajh/zBHuBiwklrDPgxbClmaPh8o7+smqqwT7ZpfWmk8xYDjZ+1rgbmVatDngeOmTE3kc00Cc8T1LM+YnxJZqqIU9CM96RrwcjCMozprNujzBtQ25/0gMYQ0EkVr7JngTvnKLmMG5Yk+e2APrlgxtQ4TP4Uqvj1B955GVshmoAm3F6NKfZfNBSVl2Lo1oJCoGqg4VJPfuCLCwJ0ubWqR4lpT9zsQsc+EjxCoTGLJ+c99XTsdPqZV+I4MdEWh1CMAPZNjwJ8VVJa5RgetLFQyhUCBGFwtYhDvc2WxXZNrnWTeZ1hApIovWfwyvVFKMgtjhoLzAXkk37t54OKJVq+TC0TH3EW69vcCjV2w90g+kzcbgFEuqj+z/InzWKs91g222ZuQ8PRy9C2V++Xi9z8t7Uah16t4Qb3X0YBWkNg/cBDQMF9Krk+jSnuaxTlFvsDkNUjyN/+1FmDZVlzma4eXhLc6dN86omdWSJYNHhPyCTHTG/RPpZgGgSoGne086eoku76Y/xN6fR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39850400004)(136003)(396003)(2616005)(66476007)(66556008)(956004)(6916009)(83380400001)(4326008)(38350700002)(26005)(6666004)(2906002)(1076003)(7696005)(52116002)(5660300002)(38100700002)(86362001)(6486002)(186003)(8676002)(478600001)(36756003)(66946007)(316002)(16526019)(8936002)(31153001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ne2qtTffnVDyw1VT9tMOQv4nbUrV+oeXWRDWyVplFnzc2ll/MnlufiUESajr?=
 =?us-ascii?Q?xKwoZ9G2/1xbj7K0a4V0ryzPT2idgbikhQfUxZlxEU8HAYMnfOljO3SAb5I3?=
 =?us-ascii?Q?kF4HlZTm+a8i0l1gK1NnOmAqQkX1DrO26osXRrXyINbrr7J/X17LvDQp7bg3?=
 =?us-ascii?Q?gjIwbZ5tO0IYxpa8XpCG+uVH8a9KvA4fzsbrAwO0INmo7lwzQC18rd8y93c9?=
 =?us-ascii?Q?Im9Y3sML0zfUHtQ41rI/zUVmY1WvbjSCBzytXpS++uDFjWgZXdPJQe6bDjob?=
 =?us-ascii?Q?siyjXT7GLFdBtTj3B7inzxSsXSHjDdF0rghb9Q2WQuLdFVLMgrgQzXZiKQFW?=
 =?us-ascii?Q?icF+mbO9Qj7nCaJ2GWTKpDMhLKuCBPOQWkggNbSKsNjF87iESyO4Ki3DosLv?=
 =?us-ascii?Q?6svOqs+qYBg7TuhvmN9QbEWahWqm0cQAX48o8DoFgpAMJENOgLy/wSHa+OlO?=
 =?us-ascii?Q?wo5cl4kwbhWBKddfQ3JsRPL5ZLnu1xTJRFJVmy0PCriZKXf0h8a5JMcyHb0f?=
 =?us-ascii?Q?giFE2DD+zSlwqZ0+jICrgNVA01wyDsISTG/D1J0dQD4rBL3O3ZbXV2isGh2s?=
 =?us-ascii?Q?Rqwx4bf5fub9ZA6jcLDp1co2lWUl1T+NV7v0PFYV7KRhHJWzIp1TRVQBr2Z3?=
 =?us-ascii?Q?pV25AWBW9Z1mw1tIagYpRIzkNBYpwRnvrCjP9RGszSZzw6H4Xc6rMGc0HFb/?=
 =?us-ascii?Q?Obp8oEaRMyQL7VVcgFghJLE67LmoJAU95Bx0Go4D/S0NG5B0YXJTjoQp0/Cc?=
 =?us-ascii?Q?aJOxxhHFHoOeYcELAbC4mtbv5CoTYBjLc4SWKm5szbm81Y5JnpydLBSnslht?=
 =?us-ascii?Q?5Hitw7vzKH983OkMDiyathSir9+ayDSskp0wMcAM0BxWK1PkPU2qp0zoP7IT?=
 =?us-ascii?Q?YI1/DWVxOpX0b0k5ebouO/6U5480wD2ABu1d1wYfbJDQYP4ZghTCnff8WZ5d?=
 =?us-ascii?Q?Arsxu5XY2kVJ3xMW8w2sPYPf2rD8znIzykl9TO5ptAHbbCofgxtDX9/G58yp?=
 =?us-ascii?Q?1K5BzUoOQGrYD5IEFViQCcfSiulAV2fpVi28LxzIhu1vpzBLE0ObQI489Hb0?=
 =?us-ascii?Q?Pheu4BB/k6Zsa2gESH9TRp12KbU+TLRfIGExNp/1cAuiDORN1w02hqFMnoWe?=
 =?us-ascii?Q?T2uWyN6MMh+u2s4Deynb1ebgFr7eS2P7KvcEgzvhfz0zoaaqftTc2J+MLhm6?=
 =?us-ascii?Q?0f65JXQQrNte6Oyyi44i4ertkyl86mxcxX/okZnBAwTKsA7fhfyJ/aiwKM9C?=
 =?us-ascii?Q?dzigjoL6/MGa3uKGNwyRYNShN/VCsuYRyZLhfvWh5PnFUM0jYIqTAekEbWx4?=
 =?us-ascii?Q?jk7DXSn0Tsi6OMINpfppJKUF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea080b0-04af-4d05-df19-08d8fea9a05b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:26:16.9247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVWuHlvduZ+f2ota973y1Q9UyD7EdcjFGh+bbLGJ7WcmBeYxYddIj0wlqhzvsvrr86CID4aj6YBzxWG3+q+B/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 34 ++++++++++++++------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e0c4f7c7f1b9..baa980a477d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -291,8 +291,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
-		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, attach->dev,
-					      dir, &sgt);
+		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, 0,
+				bo->tbo.base.size, attach->dev, dir, &sgt);
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
index 592a2dd16493..bce105e2973e 100644
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
+		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
+		size_t size = cursor.size;
 		dma_addr_t addr;
 
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

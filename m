Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297A1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 23:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E023E610FC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 23:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E023E610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBA7891CC;
	Mon, 12 Apr 2021 23:28:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A5C891CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 23:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv92Njmjw8xtewB8b04Wg+85hsQICEGRIqlOBOOAtgWsCycU99tXvA4ytILfiwW/lWcZ8GxOl8543m4wWYdVmEISLRCzUkES3siOeiJcrFBRkcLaUePgXD6T45wWxKE3TB9xhDbakJFZD75XYukWyqfGgN/K1OE/0GxMaODLJ7JCH7Ke4KY5DYoLIZ+ftA966H8tMeXkhwPRy8AuICYezeKyzygWR6tjnJb8VQMPjW8YC41KblvT4gTjCox6OuxDmZaIksjfXcYJvG0BxD8TjGTjEiMrXdWhKib3dEfSqnWhx25UC+cqDjgguSSqG1edk9zaNeOTbIfNp2NNwZ6ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfhjmnwmHkSde7CdpNk9a1skPBNP828PQIRaF+fBSkE=;
 b=QqIiiU/ims/fZyKDpqO9zdQVlwJLanf7DLhSsB2madqu5Bh8bj/0b70waGZpLHTmp8KZnYSyNNhNJsUliPhnUnWNWvgQLDQViXO4vGJWn/T956MFRPuBfVroByLWcrpOec3KSohSe65LdwlexjXLqwoA0xk4XI/z383sGXVvM7kZj8ajJAyXwsk6Lz7649t7xmN8iIqfAr7dslRa4tkvX5sQIwa5jfnJJXETvklqtG1grGhszE9AR7s5l0GAPEkBdzOCh0N81pSMO3FhRImIS9rKpjq9lqpnpie7JwhDoeMKy4K8+uDV+85Lp0WvYLFk03DGyw3T/CSi+YgewbTkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfhjmnwmHkSde7CdpNk9a1skPBNP828PQIRaF+fBSkE=;
 b=ym+sLTBWMB5bdc4uDkopw6oJs5EQmk2vFid/3ENw4WRQIgCMEANUzUcQt+BdptRAEE7hs9mx9UO4QLm0JM4bjozK1GKGYTPvb5A6YprlFDEmSNlsJ2ZNW5dVCROOr8PhSf8XuLb6i8bvUHw0c8ZwSM+bv61Ws5HRuEYvPuHgbOs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB4703.namprd12.prod.outlook.com (2603:10b6:805:ee::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 23:27:57 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 23:27:57 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use iterator methods exposed by
 amdgpu_res_cursor.h in building SG_TABLE's for a VRAM BO
Date: Mon, 12 Apr 2021 18:27:44 -0500
Message-Id: <20210412232744.8655-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:21::14) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SA9PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Mon, 12 Apr 2021 23:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0b858a3-4da5-49f1-6c4a-08d8fe0a9b07
X-MS-TrafficTypeDiagnostic: SN6PR12MB4703:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47031D390C5FE3E3C08B1E40E3709@SN6PR12MB4703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMmIpRzAnwtgSAT1g+44h3JjrBstak+gHmdL46qBSZi/kBHF31fbthsFXb/JraXjZYQVW1ZNWz9KFL+uMEREu9v8yqac8I4SknyF9hcDGIJn4vTGWYAwdh3LV7/zQKmAw8mNUbbS10vfrFRR5vH862A93jj2HZTVQMnyyewEdLFQ4HeMXDqltPeiYZRDascqph7RK6adBjMS1zNKmdO8BTyS00tDoSel3u6rbDSBRQFYQMRE22R76atnPEYYtmMj1YG7BN4/Dz3kba1Be6uMjMJKfDIiQWMCke0HSd20MtxCK7pXIJK/Ps8XvZgC5bpGGT919BIQGLUJhCPNQYqT2DpY66xdBiT+T4+urA1yPX+kcH4Xy4QPsYd1kqfqLg/cZFQq0rwcpJqdACRtzRAQjSl2ZW3wgBShul1SZJbeJE28PZIBYXerdv3gE2YBwlRvpdLTwjldKbHh8oVH8dtbF3+HwkxXGntZkcNEuspKDFSsrJylLloR0GdKf/L1R+cRd0VB1hIE38yrB+koH45dUayIx+QTqce71FMI6OrAtOt0dmNRioJr7Tc47JOX3BHNZTwUfw9SaXybN3XhzL1khJsnwP9qfyBTa+zkcb1A9QMZUqbvCjNtYrCEk7/GO63X5SPGmfQ1HDF4zshV6Oe/BPmO3T8Mi2oJ4P8RRJIPat3TbpcxywLy0eivnBu/DgBD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(316002)(52116002)(7696005)(66556008)(38350700002)(66946007)(66476007)(2906002)(186003)(956004)(8676002)(4326008)(86362001)(36756003)(6666004)(5660300002)(2616005)(478600001)(1076003)(6916009)(8936002)(83380400001)(38100700002)(26005)(6486002)(16526019)(31153001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g/w5ceuCq8ux5wR1QduM3cf2OKVdopN7QIsSXg1pqZYq7RVXk1qkzMTznAoq?=
 =?us-ascii?Q?kFWx/UMyurclqqbVDYzDUxL3qlxy01iA8kxO1Voj0/2H5LvR+rm7aacKBHBH?=
 =?us-ascii?Q?zJ/Z/siXfsc8NBhO7YnmK/80jyr1vl2qs4TSaVjy22sJOCr7HDYC0aZYCgF8?=
 =?us-ascii?Q?GHTKTdhZ4rK7Oztr1R9vGjhHZuXIcajTpv3DSD5vj/bcGuMHkv/fgB7pAqKh?=
 =?us-ascii?Q?BiDpGsjUStBHfZp0yhNgccMmxBpgfwc3wRyi1/zNhDE5UUaCElb8OaWk47qR?=
 =?us-ascii?Q?ROh4ZT5lG521Aze1LigOlMMEj8TDZciYcJ5876QMmf3wpTbzRS13FBI0O/b0?=
 =?us-ascii?Q?KXzknxkWNfOEa9MQAk0s5ytGtwD7ohojnA4kfxBYFhzDZLrGucUMXecJ2LDX?=
 =?us-ascii?Q?kbM/JYT1o0xd4Jscasflp1s1dNT/zC2TwKdBb5T4F5JT1RdwOtpUGUxHVB+/?=
 =?us-ascii?Q?b7Ukvq6+iYezDDCO7Ei7T2gl+kT6dPA/PMhbJFf+XJRRX7bjDxBe+3+E34Uy?=
 =?us-ascii?Q?bsymMsWEeqFtg3DURxbU4bOsb4YIfMkL8uputeUGAneu9o0GwnJRgCYSplkG?=
 =?us-ascii?Q?0/JnKpOVFaMhb0JOVuOPZnmv8MqOL+OffByNIfjhrBkLTHYuBvvgvUmfFdaw?=
 =?us-ascii?Q?S92fnN9b8dHFj8xniJvKfOGakHDqwww8ctWgvhksZiaALRPLCZlJeupoacwt?=
 =?us-ascii?Q?HjPkRG4UXD0Zws33EuqLKabh7vWO5rae4+6PlElZrc9S2NXgXrGSs6YdK7VG?=
 =?us-ascii?Q?MCRhDDtaWG85U5nywH4HztHwgZvsU9aRQGvtaoit9LiGK0liS7uGg9lo0bGQ?=
 =?us-ascii?Q?t555VQs+UmZQ6ZdpbvoYVZXKBTPx7yRIJRDETTncozUZsZFjyXIYE3xW0qLR?=
 =?us-ascii?Q?Au3+OQr+I+1ronJpbHj4hB2Kr5afY3X7RI/emE+GMVJO5nEjRSAwSjnsCxH+?=
 =?us-ascii?Q?mebw7rXjgi2Uibn2ZFUx/EoXFjbvYOwcHebrdcH0JxXVOlxwtg/5y8MQvBZH?=
 =?us-ascii?Q?kb8JCZBRw+y8LHZMPkYaDtG/pAm9XgHjVvjh3ur4/orJovQlhT7ZX6d9auCz?=
 =?us-ascii?Q?gC43p8HvFaSplW2M7mkNSDZY8v6IXiaUYCvQV+9znGOVRIAqKwm/gZHHRIw5?=
 =?us-ascii?Q?J40e9zOXA52A2Dpj0P7zLwDoA9N8vaBe4Pvm/m+6jO3CFFaDRhkWD39Tz41Z?=
 =?us-ascii?Q?p1nxhYtTy7KZWzOa7Yx5yBLYysEF8Xv3m2nfsIJE7N0rpvNxwpMnjMXASUyA?=
 =?us-ascii?Q?4jEAx1S3VAT8o1b5bohWuBQyYLnp4DeusZonqkt08A7efmE49yZs6c3RhTJj?=
 =?us-ascii?Q?MQ1VHGzH7kBcLfzaPv9mmZF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b858a3-4da5-49f1-6c4a-08d8fe0a9b07
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 23:27:57.8037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRCD0esS++91GNYpNgz+5iJSbPslGJz/9WoivG0YMGhAoU4e7Gzz6UOPUGaAL42asGoHJcAL/N40oEqX7i5kmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4703
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 32 ++++++++++++++------
 3 files changed, 27 insertions(+), 12 deletions(-)

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
index 592a2dd16493..fcdee0deba16 100644
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
@@ -573,39 +576,45 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
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
+	// Determine the number of DRM_MM nodes to export
+	amdgpu_res_first(mem, offset, length, &cursor);
+	while (cursor.remaining) {
+		num_entries++;
+		amdgpu_res_next(&cursor, cursor.size);
+	}
 
 	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
 	if (r)
 		goto error_free;
 
+	// Initialize scatterlist nodes of sg_table
 	for_each_sgtable_sg((*sgt), sg, i)
 		sg->length = 0;
 
-	node = mem->mm_node;
+	// Walk down DRM_MM nodes to populate scatterlist nodes
+	// @note: Use iterator api to get first the DRM_MM node
+	// and the number of bytes from it. Access the following
+	// DRM_MM node(s) if more buffer needs to exported
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
@@ -615,7 +624,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
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

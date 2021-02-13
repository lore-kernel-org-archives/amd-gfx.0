Return-Path: <SRS0=DGdK=HP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53BFC433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 04:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE0E64E64
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 04:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE0E64E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268276E49A;
	Sat, 13 Feb 2021 04:32:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356946E25A
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Feb 2021 04:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8NeA/lAJJjT/Ss3AGklC0FZOZV0LxYTT1gVWTTP/Gn/4CByrcW2VzIf9FOXpK6fznEjPJARIrKQH1HwOroA9l6rLSTBLMRJlDrUAJsl1gicf/rG14T963hTXCAlCtWuVaEAWG9f93SkdH6gWoQgovRud53ri0S87uH5xAMqNsDMnTGOLpCN+xGIYusdzrjSb2/h363ceXzuo2CSNvup6ESnRo7ZPJlLKpKFsFSpIIxQBtd84f2y3qt09YMeWYj336/c1Vd+lPSGZDK9MIyAm3yYWsAzlE1J5Yvc4/tBGF+Hd5Lb/deGdyHitJ/CdQCZw9TERhUb6lykz2e4Y8kzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKI6Nw9zmGYcf0msRuRI6xxDIl6/+Go09k5GBxxsFMw=;
 b=aDBXcnu5zTYJp5MJDRwzfib6g8s0ULYiZPSs2kvE2J7rh6YoLAZSjzMFY/bdxCrHTH7PTggDNej07JhztHUqzFGjvsK/PmpiJf8xm6t/MRqFemIVKnWT5wYhwpcXVMVA8CZO/QlbZ2osHz4OD9JRai8nDvtd+xj68/LKDjRR9tWcsaja9bJbxTY4bVC64QotqfVGwqDUeORj+fXKqklCxXxvHC7+Y8Eu3dSF2QPT+2fu8khCVuuVGALuYr3DMoHXU5bROEk6Onq49czgXQV93GRdjei/N929Zm3ZyuaYC9qLlh7ds1fmcng47tXjnH/AZN5xQHboeJaaiciQfTVm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKI6Nw9zmGYcf0msRuRI6xxDIl6/+Go09k5GBxxsFMw=;
 b=tTJjBREsdQE+J+28BgBrDStQJQW/LYu/+p2uYj3IL/joaEBbCZxYX2V4otQy033dLc6AlJ/wojqO2wiovDNCfLgY0JV/HqemCQLvkmXAX+RrOV7vHQ55O71AqWlr90kiJpWwNGGwwyo2jPZk3g3bhGTw/IbcEY6eOGdUCCR0wFc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2525.namprd12.prod.outlook.com (2603:10b6:802:29::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Sat, 13 Feb
 2021 04:32:33 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c%5]) with mapi id 15.20.3846.027; Sat, 13 Feb 2021
 04:32:33 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Modify alloc_sgt apis to consider size of request
Date: Fri, 12 Feb 2021 22:32:18 -0600
Message-Id: <20210213043218.5837-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:806:21::12) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SA9PR13CA0007.namprd13.prod.outlook.com (2603:10b6:806:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.15 via Frontend Transport; Sat, 13 Feb 2021 04:32:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ac0baa9-31c0-4ca8-a8d6-08d8cfd861bb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2525DFA4013B7979E55316FDE38A9@SN1PR12MB2525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQY84rIayk2RQ5DLT2fyhVr1hIhA/thhzdl8QroTiIyCl/3zI8JdZ4WXMdwiuEjHsMpRc+ON4E9YKOTiqmOygQoMTx4Ae6usXKo6iJNDZnq7Y13lyFfYZ2WUOGydo/auJM2YWS/VhOUFdmsfLYZn9q9LjzFDGUGHDIyAby8C6+/xv4p3BFXoL/nyL0vk0cJQ9uUarwhnKDm8q5CWZVo8SZgRvuww13hWhwjHfp4FQWumi8X3XNWDS6GmiAUwRbuEmrhBUbSx4nMvXKAq+Tk+kUmxinjKrEY2fxPACbI66Q+htvJqFAA72uNsNec9apZW+bVYH2enr92LsClHO6zdcfQkCOq2AciSymte669PjIT0o5xtzMjz1x5ZJScr318tapzPvuOsXppphLtW85pp/LRJQshfznVzgyaJ2TEoeyrZlgnlp3bBmeIB4Tf/W7OJMAQ1GNNtwRIVk0FSiE6I+kbs+UKUM78J7fKXSaVFJYL6AMlk/TFL2nzaOUSoN7JtHb+KSzd6lCs83FHiWpJ0nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(52116002)(66476007)(186003)(316002)(66946007)(1076003)(8676002)(36756003)(16526019)(6916009)(6486002)(4326008)(66556008)(7696005)(478600001)(6666004)(2616005)(26005)(956004)(5660300002)(86362001)(30864003)(8936002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zqx79WK+Tk3vAVLaB27XNCzTa+TiHHHQC3NaWMtKCMJbacBzQ5uq3CTDF8fv?=
 =?us-ascii?Q?Dmso+kRaJIdfQe1ND4t5z4ZsnE4guamAfFTOzR36UVXRW9k11ui9m0QCpevc?=
 =?us-ascii?Q?RdeHicLutijI/pnIRYQUGrvwC3Jq9PH24FLGfpvws2Gn2KfVuHrjjf5K0nJG?=
 =?us-ascii?Q?ZLEBKUlRqY3UOJ2DnNtR/XSRo5e463YdRUoEYQbu0z3AZpcKCZ1QigpUTiLe?=
 =?us-ascii?Q?dNofycN9+RywOyjY7CTbSGmYsOxoFraQ19U1ZSsw6f81DWgUQ3TacDMZ6R8z?=
 =?us-ascii?Q?Cah8enhT3EvpRYSfMV+xPCgxWYykHEZS24Y6gfFgwGpZPR4RIQSyow2RiUgZ?=
 =?us-ascii?Q?Tga25xnow0cSHGzzeLqmAylt7fnVy0HBdCdmeu+hxRmUYZJZzM1OXejRILqs?=
 =?us-ascii?Q?SK8oypQrZChhQf0DUacNtu8E0P0xQP6aF8w1SumuWNFnzYX1pxeYtdDQ/8OU?=
 =?us-ascii?Q?PL9XcA0GFbJQ/mRDHSFORzjpdKHk7UcwjOU4MbNOn1uddZ+YXOXESi0Z+INS?=
 =?us-ascii?Q?bxQkDVKoPM1sSooAaEveimajONrLy1OJrI3TmT8QpSVl6Xw1QXr3kuVEeUif?=
 =?us-ascii?Q?u9wpRI5IR4bY4dcZ8TqEqihj3opHvW5q2wkYPgNjx7aXO7bi2HtAr1JrMNos?=
 =?us-ascii?Q?HStrft0kq4+JoGH/UdMOQ59rXV6sDrJyvVo/0PX8LOPXMUfxOzNz3xD86e0o?=
 =?us-ascii?Q?Wcln/DcIX1ca0ZY+R4JO2Ltitax68meGk1Gmq5/ocN39mpN0XUfYYeguhsjy?=
 =?us-ascii?Q?UoqZiHvZIwNEBRycTxn4OxXDSsU1nlEpJCu6ZE+8bEOAM0c2cU88QPHmC+TW?=
 =?us-ascii?Q?GaAf0sysa9EC8TojWFITZ4dPfU29/Kllh5tOmG6i2NcuDRzYuOgvHI//tHfV?=
 =?us-ascii?Q?WaDkk9uxbtpelF4dM241KKe6kw0V1ALEM9oOaWcM5f/seyUBMH/zEAdiU2BH?=
 =?us-ascii?Q?h/jFfIcFVTOhtc++l7iRRLvBV1LEZ9vqfZM14YKQmzGFoSQNxR7d/VmxNcgO?=
 =?us-ascii?Q?qRwCnQ+1+Bqd77LPGXdl6GaYf2Kn6rsx1KPACwuNnoBeWSComBmx6rT+onMZ?=
 =?us-ascii?Q?UGVYwQO82toFxobt8vkVuWMBHRe+fKR3xvKn42ncSqGH3/I73yPg4OI9bde/?=
 =?us-ascii?Q?82Im1DIgeWcjO4JiKvSY6xcwNWGcNHDp5MZ7KOBclqWZjCi7OxMYQtyRyd5O?=
 =?us-ascii?Q?1dy2FABr1UfS9MTQmxP7g9R0nGfZSOQCSb3zJmn9wagoW7r8k9hE50RczcMk?=
 =?us-ascii?Q?3GHTtmKhBOYF1uAGNn3Kf7O2qUA3YXxpXRQTnHOpILx9ZmpLdqy+TcCJOMsN?=
 =?us-ascii?Q?HOJHF1JIYWN+8G6baqe1lN8w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac0baa9-31c0-4ca8-a8d6-08d8cfd861bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 04:32:33.4198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuMlnFn0GALMeW7fNiAjq5yBy3x25acv+eiB1JERlSKYoXDU0abWpzq3utsmm3NYkVyvQt9J8MPkFfwC+WRv0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2525
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

The current method that builds SG table does not allow its users
to request a sub-block of the buffer object. The change modifies
api signature to allow users to specify both the offset and size
of the request.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 245 +++++++++++++++----
 4 files changed, 210 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 2808d5752de1..b23f44999814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -326,8 +326,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
-		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, attach->dev,
-					      dir, &sgt);
+		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, 0, 0,
+					      attach->dev, dir, &sgt);
 		if (r)
 			return ERR_PTR(r);
 		break;
@@ -356,17 +356,12 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	struct dma_buf *dma_buf = attach->dmabuf;
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-
 	if (sgt->sgl->page_link) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
-		amdgpu_vram_mgr_free_sgt(adev, attach->dev, dir, sgt);
+		amdgpu_vram_mgr_free_sgt(attach->dev, dir, sgt);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ce92768cd146..ad504d0e5b26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -222,8 +222,8 @@ static uint64_t amdgpu_mm_node_addr(struct ttm_buffer_object *bo,
  * @offset: The offset that drm_mm_node is used for finding.
  *
  */
-static struct drm_mm_node *amdgpu_find_mm_node(struct ttm_resource *mem,
-					       uint64_t *offset)
+struct drm_mm_node *amdgpu_find_mm_node(struct ttm_resource *mem,
+					uint64_t *offset)
 {
 	struct drm_mm_node *mm_node = mem->mm_node;
 
@@ -782,8 +782,8 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_reso
 	return 0;
 }
 
-static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
-					   unsigned long page_offset)
+unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
+				    unsigned long page_offset)
 {
 	uint64_t offset = (page_offset << PAGE_SHIFT);
 	struct drm_mm_node *mm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 4df4cf2fd4dd..e3e413dbfd72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -116,11 +116,12 @@ int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
 u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
 int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 			      struct ttm_resource *mem,
+			      uint64_t req_offset,
+			      uint64_t req_size,
 			      struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table **sgt);
-void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
-			      struct device *dev,
+void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt);
 uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
@@ -155,6 +156,10 @@ int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma);
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
+struct drm_mm_node *amdgpu_find_mm_node(struct ttm_resource *mem,
+					uint64_t *offset);
+unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
+				    unsigned long page_offset);
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 21d18efca277..37a57a5ecd85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -28,6 +28,9 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+/* Defines the maximum size of a SG node */
+int64_t VRAM_MAX_SG_NODE_SIZE = 0x80000000;
+
 static inline struct amdgpu_vram_mgr *to_vram_mgr(struct ttm_resource_manager *man)
 {
 	return container_of(man, struct amdgpu_vram_mgr, manager);
@@ -565,6 +568,90 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 	mem->mm_node = NULL;
 }
 
+/**
+ * amdgpu_vram_mgr_get_size_sgt - Determine the number of scatterlist (SG) nodes
+ * that are needed to encapsulate @size amount of memory.
+ *
+ * @mm_node: handle of the first memory node to walk down
+ * @size: number of bytes of memory
+ * @page_offset: offset of desired memory in page index terms
+ * @byte_offset: offset of desired memory when it is not on page boundary
+ *
+ * Returns number of scatterlist nodes needed to build sg_table
+ *
+ */
+uint32_t amdgpu_vram_mgr_get_size_sgt(struct drm_mm_node *mm_node,
+		uint64_t req_size, uint64_t page_offset, uint32_t byte_offset)
+{
+	int32_t num_sg_nodes = 0;
+
+	/* Walk down memory nodes list to determine number of SG node */
+	while (req_size > 0) {
+		uint64_t node_size, node_offset, min_size, tmp_cnt;
+
+		/* Determine available memory for current memory node */
+		node_offset = page_offset << PAGE_SHIFT;
+		node_offset = node_offset + byte_offset;
+		node_size = mm_node->size << PAGE_SHIFT;
+		node_size = node_size - node_offset;
+
+		/* Offsets apply only to first memory node */
+		byte_offset = 0;
+		page_offset = 0;
+
+		/* Determine number of SG nodes for current memory node */
+		min_size = min(req_size, node_size);
+		tmp_cnt = (min_size + (VRAM_MAX_SG_NODE_SIZE - 1)) /
+					VRAM_MAX_SG_NODE_SIZE;
+		num_sg_nodes = num_sg_nodes + tmp_cnt;
+		req_size = req_size - min_size;
+
+		/* Get handle of next memory node */
+		mm_node++;
+	}
+
+	/* Number of SG nodes in SG Table */
+	return num_sg_nodes;
+}
+
+static struct scatterlist *amdgpu_vram_mgr_populate_nodes_sg(uint64_t size,
+			uint32_t iter, uint64_t pfn, uint32_t offset,
+			struct device *dev, enum dma_data_direction dir,
+			struct scatterlist *sg_node)
+{
+	uint64_t node_addr, sg_size;
+	dma_addr_t dma_addr;
+	int32_t idx, ret;
+
+	for (idx = 0; idx < iter; idx++) {
+
+		/* Get bus address from page frame number */
+		node_addr = pfn << PAGE_SHIFT;
+		node_addr = node_addr + (idx * VRAM_MAX_SG_NODE_SIZE);
+
+		/* Determine size of memory scatter node */
+		sg_size = min_t(uint64_t, size, VRAM_MAX_SG_NODE_SIZE);
+		size = size - sg_size;
+
+		dma_addr = dma_map_resource(dev, (phys_addr_t)node_addr,
+					sg_size, dir, DMA_ATTR_SKIP_CPU_SYNC);
+		ret = dma_mapping_error(dev, dma_addr);
+		if (ret)
+			return NULL;
+
+		/* Populate the scatter node and get handle of next node */
+		sg_set_page(sg_node, NULL, sg_size, offset);
+		sg_dma_address(sg_node) = dma_addr;
+		sg_dma_len(sg_node) = sg_size;
+		sg_node = sg_next(sg_node);
+
+		/* Offset applies only to the first node */
+		offset = 0;
+	}
+
+	return sg_node;
+}
+
 /**
  * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
  *
@@ -572,71 +659,132 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
  * @mem: TTM memory object
  * @dev: the other device
  * @dir: dma direction
- * @sgt: resulting sg table
+ * @ret_sgt: resulting sg table
  *
  * Allocate and fill a sg table from a VRAM allocation.
  */
 int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 			      struct ttm_resource *mem,
-			      struct device *dev,
+			      uint64_t req_offset,
+			      uint64_t req_size,
+			      struct device *dma_dev,
 			      enum dma_data_direction dir,
-			      struct sg_table **sgt)
+			      struct sg_table **ret_sgt)
 {
-	struct drm_mm_node *node;
-	struct scatterlist *sg;
-	int num_entries = 0;
-	unsigned int pages;
-	int i, r;
-
-	*sgt = kmalloc(sizeof(**sgt), GFP_KERNEL);
-	if (!*sgt)
-		return -ENOMEM;
-
-	for (pages = mem->num_pages, node = mem->mm_node;
-	     pages; pages -= node->size, ++node)
-		++num_entries;
-
-	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
-	if (r)
-		goto error_free;
-
-	for_each_sgtable_sg((*sgt), sg, i)
-		sg->length = 0;
-
-	node = mem->mm_node;
-	for_each_sgtable_sg((*sgt), sg, i) {
-		phys_addr_t phys = (node->start << PAGE_SHIFT) +
-			adev->gmc.aper_base;
-		size_t size = node->size << PAGE_SHIFT;
-		dma_addr_t addr;
-
-		++node;
-		addr = dma_map_resource(dev, phys, size, dir,
-					DMA_ATTR_SKIP_CPU_SYNC);
-		r = dma_mapping_error(dev, addr);
-		if (r)
+	uint64_t node_page_offset, byte_offset, page_offset;
+	uint64_t num_sg_nodes, base_pfn, work_size;
+	struct drm_mm_node *node, *start_node;
+	struct scatterlist *sg_node;
+	struct sg_table *sg_tbl;
+	int32_t idx, ret;
+
+	/*
+	 * Determine the first mm_node to use in computing MMIO address. This
+	 * is determined by the offset of the request, which can be at a page
+	 * or non-page boundary. Furthermore this offset may not coincide with
+	 * the start of mm_node i.e. it may lie internal to a mm_node. Thus the
+	 * offset of request should be treated as follows:
+	 *
+	 *     offset = (N * PAGE_SIZE) + OFFSET_IN_PAGE
+	 *         N can be zero or higher
+	 *         OFFSET_IN_PAGE could be zero or (PAGE_SIZE - 2)
+	 *         mm_node->start refers to K pages off from MMIO base address
+	 *         mm_node->size refers to number of pages mm_node encapsulates
+	 *
+	 * @note: It is possible that the offset of starting page of a request is
+	 * one or more pages away from the start of mm_node
+	 */
+	uint64_t req_page_idx = req_offset / (_AC(1, UL) << PAGE_SHIFT);
+	uint64_t req_byte_offset = req_page_idx << PAGE_SHIFT;
+	uint32_t offset_in_page = req_offset & ((_AC(1, UL) << PAGE_SHIFT) - 1);
+
+	start_node = amdgpu_find_mm_node(mem, &req_byte_offset);
+	node_page_offset = req_byte_offset >> PAGE_SHIFT;
+
+	/*
+	 * Determine the number of scatter gather (SG) nodes that are needed
+	 * to export requested size of memory. Depending upon request, following
+	 * are possible in building sg_table
+	 *     Starting mm_node contributes all of the pages
+	 *     Starting mm_nodes does not have all of the pages
+	 */
+	num_sg_nodes = amdgpu_vram_mgr_get_size_sgt(start_node, req_size,
+					node_page_offset, offset_in_page);
+
+	/* Allocate sg_table to carry list of scatter gather (SG) nodes */
+	sg_tbl = kmalloc(sizeof(*sg_tbl), GFP_KERNEL);
+	if (!sg_tbl) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = sg_alloc_table(sg_tbl, num_sg_nodes, GFP_KERNEL);
+	if (unlikely(ret))
+		goto out;
+	for_each_sgtable_sg(sg_tbl, sg_node, idx)
+		sg_node->length = 0;
+
+	/* Determine base page frame number (PFN) of MMIO space */
+	base_pfn = adev->gmc.aper_base  >> PAGE_SHIFT;
+
+	/* Populate the nodes of scatterlist table */
+	work_size = req_size;
+	sg_node = sg_tbl->sgl;
+	node = start_node;
+	byte_offset = offset_in_page;
+	page_offset = node_page_offset;
+	while (work_size > 0) {
+		uint32_t iter;
+		uint64_t elem_pfn, node_size, node_offset, min_size;
+
+		/* Adjust PFN to correspond to request */
+		elem_pfn = base_pfn + node->start + page_offset;
+
+		/* Determine size of available memory upon adjustment */
+		node_size = node->size << PAGE_SHIFT;
+		node_offset = page_offset << PAGE_SHIFT;
+		node_offset = node_offset + byte_offset;
+		node_size = node_size - node_offset;
+
+		/* Distribute memory of mm_mode into one or more SG nodes */
+		min_size = min_t(int64_t, work_size, node_size);
+		iter = (min_size + (VRAM_MAX_SG_NODE_SIZE - 1)) /
+						VRAM_MAX_SG_NODE_SIZE;
+		sg_node = amdgpu_vram_mgr_populate_nodes_sg(min_size, iter,
+				elem_pfn, byte_offset, dma_dev, dir, sg_node);
+
+		/* Update size of request left to handle */
+		work_size = work_size - min_size;
+
+		/* Determine if there was an error in populating sg nodes */
+		if ((sg_node == NULL) && (work_size > 0))
 			goto error_unmap;
 
-		sg_set_page(sg, NULL, size, 0);
-		sg_dma_address(sg) = addr;
-		sg_dma_len(sg) = size;
+		/* Offset apply only to the first SG node */
+		page_offset = 0;
+		byte_offset = 0;
+
+		/* Get handle of next memory node */
+		node++;
 	}
+
+	*ret_sgt = sg_tbl;
 	return 0;
 
 error_unmap:
-	for_each_sgtable_sg((*sgt), sg, i) {
-		if (!sg->length)
+	for_each_sgtable_sg(sg_tbl, sg_node, idx) {
+		if (!sg_node->length)
 			continue;
 
-		dma_unmap_resource(dev, sg->dma_address,
-				   sg->length, dir,
+		dma_unmap_resource(dma_dev, sg_node->dma_address,
+				   sg_node->length, dir,
 				   DMA_ATTR_SKIP_CPU_SYNC);
 	}
-	sg_free_table(*sgt);
+	sg_free_table(sg_tbl);
 
-error_free:
-	kfree(*sgt);
-	return r;
+out:
+	kfree(sg_tbl);
+	*ret_sgt = NULL;
+	return ret;
 }
 
 /**
@@ -649,8 +797,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
  *
  * Free a previously allocate sg table.
  */
-void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
-			      struct device *dev,
+void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt)
 {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

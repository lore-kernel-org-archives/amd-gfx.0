Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04879CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 15:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2524208C0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 15:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2524208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8AB6E93A;
	Mon, 28 Oct 2019 15:38:47 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2F86E93A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 15:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpRWMONwAoXRoFE6m+d3vxo9nESq8XCVx/lxOb+sYRNIUR4FK7AgWPAv+R2ihFvI3WCAbC/5PeYUA4swJc6DMUM6kaYgGuK63mRDk7K9B2X2fG21I/cK25/nGF0ic2jQEjObL0Y3uifklf/lcitPI8az5lfapHEMHYI9IZGYIV9qaKoFJ4EmHbxO9JO4SmfTUG0YZc0/jfS6joolY+zQjh2ORuc046zeAiBRgBfut3Uj2cVakfs9X+3rMbRsfxxJcb4SAH1PHcXd7grNbdMNyJxJbuwu27Ga3xZxHYo+XA/F62vJ5b1tp1xFRvU9TN9pOhOCVNgpeDYpWdcy8Lqqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu/tt69jyfZFLYa0tCIlSVL0pjGVKvuik7rG1iE65qk=;
 b=dDfuFit+VS1iOAGC9SxRKtOtrNLcXidfaLJmRmCou1JHadEHL9oCFKJjsIQ5CMyQijYxsdU/tRpBFLf7MAPjGQachZVZi9nS33LHx3gsA6etRRTnbCwhn4JoPceGj1qBvYtzSLr0omJZSEHzhInj3Td9f6iGuagadELkBY+QwFwiagedakAB9QNtV7Yr2yC+Jfd0bLLP3HCQe4odBQXVVR3FcIsSPrUU5ZzKTbuzV+ilPfDLvVr895bek1DMO1/V8o4MLh1uidCBsmj0cM6QKKWFPvvALS710z6Lu1iYmrxUfQu/FDVzDhYSAmdaeVRv4FR9R2NTJIOEcNuqVsNFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB1770.namprd12.prod.outlook.com (10.175.86.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 15:38:44 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 15:38:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9
Thread-Topic: [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9
Thread-Index: AQHVjaJc/xJ6TN5WoEyRZ886zEpL1qdwMDWu
Date: Mon, 28 Oct 2019 15:38:44 +0000
Message-ID:
 <DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191028151407.15357-1-christian.koenig@amd.com>,
 <20191028151407.15357-2-christian.koenig@amd.com>
In-Reply-To: <20191028151407.15357-2-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.51.171.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44d7d92a-ffc5-498e-9084-08d75bbceac1
x-ms-traffictypediagnostic: DM5PR12MB1770:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR12MB17701D1ED2BEF22A54749D3BF7660@DM5PR12MB1770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(7696005)(3846002)(33656002)(102836004)(6116002)(6246003)(19627405001)(105004)(14444005)(256004)(229853002)(71190400001)(5024004)(71200400001)(76176011)(6506007)(236005)(26005)(446003)(7736002)(486006)(53546011)(99286004)(11346002)(186003)(2906002)(86362001)(476003)(5660300002)(66476007)(66556008)(6436002)(64756008)(66446008)(52536014)(76116006)(606006)(66946007)(81156014)(66066001)(81166006)(8676002)(478600001)(25786009)(110136005)(966005)(8936002)(316002)(55016002)(6306002)(54896002)(2501003)(9686003)(74316002)(66574012)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1770;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUgU1phEhzR5SDwDL8c8hfqUFjRrHEw2DU3ru8Xv2ah1UDJKH8pEH8T7TeYkY9PC09EusqcDEsueQouwpz9iRDDDhlFRUSMmK+J7f1cBeAT5ScPipdHH24E5TFabL+Q4oD6DlwrrVJnx/dvDMs4mCX/VHzJIb/WYIXzYXaZuHO2DoxWzbZyxUciJbucHvgD3JjCl3DC1s7Edbg1r7y+fGCCCM/pvhvmsFvZzOmbHYYZnLfCG64tVD3Tg9A8ZrAiBV9qIKo9Dk53fxN0+DqjvxDGwamPw9GQwLb4UORu+ghNJV1EeFWNgzUhPEGg2Z+TIMIpfeAppN+M2pCdOuNalPb9PerpXJAffSKWJt/RGu9cMPA2Kss1OhUEej2rTee5mHAuCdaFcRfy+JB8VFuL+koiZD3o3cJoWnkYsBR1z3gpdELxjZuk/gPkvoutL6RSTxTN5Lyn5n8NHra7bTJSRrHnvSJaUYv3HMe2LZywp8wY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d7d92a-ffc5-498e-9084-08d75bbceac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 15:38:44.4648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xy2muagVLDfCtnK68/na9TtKSU3dlj+6NLJ4iisIoB6A6mHAIgpdrI5r3Gc4i4YSAZKzG0FTZUibAv5b0kTtsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1770
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu/tt69jyfZFLYa0tCIlSVL0pjGVKvuik7rG1iE65qk=;
 b=xGIhpCLybqWnnKU3ayOtgv1rtQHP6ph/wplnmPPWz5/nLYwshVthEWTBoI9e7pobHVw5NbU4RQcUHoNU7ETjUcOr/j7Q1CMxcLLFk+lZgvPg1wbe0TpBJ3ESCHwNi1glARPHFYHrbagiE8M0xVOpfYR7AZHwH9D4EzTag5ylBBs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1054867076=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028153844.WC8CoYIZvzlDy2REblP_oVX80rFNGxMOBiaKXExrmHk@z>

--===============1054867076==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_"

--_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, October 28, 2019 11:14 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9

Instead of relying on the DRM functions just implement our own import
functions. This prepares support for taking care of unpinned DMA-buf.

v2: enable for all exporters, not just amdgpu, fix invalidation
    handling, lock reservation object while setting callback
v3: change to new dma_buf attach interface
v4: split out from unpinned DMA-buf work
v5: rebased and cleanup on new DMA-buf interface
v6: squash with invalidation callback change,
    stop using _(map|unmap)_locked
v7: drop invalidations when the BO is already in system domain
v8: rebase on new DMA-buf patch and drop move notification
v9: cleanup comments

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 32 ++++++++++++---
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index f14b52cc7205..d5bcdfefbad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -370,31 +370,28 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_ge=
m_object *gobj,
 }

 /**
- * amdgpu_gem_prime_import_sg_table - &drm_driver.gem_prime_import_sg_tabl=
e
- * implementation
+ * amdgpu_dma_buf_create_obj - create BO for DMA-buf import
+ *
  * @dev: DRM device
- * @attach: DMA-buf attachment
- * @sg: Scatter/gather table
+ * @dma_buf: DMA-buf
  *
- * Imports shared DMA buffer memory exported by another device.
+ * Creates an empty SG BO for DMA-buf import.
  *
  * Returns:
  * A new GEM BO of the given DRM device, representing the memory
  * described by the given DMA-buf attachment and scatter/gather table.
  */
-struct drm_gem_object *
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
-                                struct dma_buf_attachment *attach,
-                                struct sg_table *sg)
+static struct drm_gem_object *
+amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 {
-       struct dma_resv *resv =3D attach->dmabuf->resv;
+       struct dma_resv *resv =3D dma_buf->resv;
         struct amdgpu_device *adev =3D dev->dev_private;
         struct amdgpu_bo *bo;
         struct amdgpu_bo_param bp;
         int ret;

         memset(&bp, 0, sizeof(bp));
-       bp.size =3D attach->dmabuf->size;
+       bp.size =3D dma_buf->size;
         bp.byte_align =3D PAGE_SIZE;
         bp.domain =3D AMDGPU_GEM_DOMAIN_CPU;
         bp.flags =3D 0;
@@ -405,11 +402,9 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *de=
v,
         if (ret)
                 goto error;

-       bo->tbo.sg =3D sg;
-       bo->tbo.ttm->sg =3D sg;
         bo->allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT;
         bo->preferred_domains =3D AMDGPU_GEM_DOMAIN_GTT;
-       if (attach->dmabuf->ops !=3D &amdgpu_dmabuf_ops)
+       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops)
                 bo->prime_shared_count =3D 1;

         dma_resv_unlock(resv);
@@ -425,15 +420,15 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *d=
ev,
  * @dev: DRM device
  * @dma_buf: Shared DMA buffer
  *
- * The main work is done by the &drm_gem_prime_import helper, which in tur=
n
- * uses &amdgpu_gem_prime_import_sg_table.
+ * Import a dma_buf into a the driver and potentially create a new GEM obj=
ect.
  *
  * Returns:
  * GEM BO representing the shared DMA buffer for the given device.
  */
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
-                                           struct dma_buf *dma_buf)
+                                              struct dma_buf *dma_buf)
 {
+       struct dma_buf_attachment *attach;
         struct drm_gem_object *obj;

         if (dma_buf->ops =3D=3D &amdgpu_dmabuf_ops) {
@@ -448,5 +443,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct =
drm_device *dev,
                 }
         }

-       return drm_gem_prime_import(dev, dma_buf);
+       obj =3D amdgpu_dma_buf_create_obj(dev, dma_buf);
+       if (IS_ERR(obj))
+               return obj;
+
+       attach =3D dma_buf_dynamic_attach(dma_buf, dev->dev, true);
+       if (IS_ERR(attach)) {
+               drm_gem_object_put(obj);
+               return ERR_CAST(attach);
+       }
+
+       get_dma_buf(dma_buf);
+       obj->import_attach =3D attach;
+       return obj;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.h
index ce1b3f017451..ec447a7b6b28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
@@ -25,10 +25,6 @@

 #include <drm/drm_gem.h>

-struct drm_gem_object *
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
-                                struct dma_buf_attachment *attach,
-                                struct sg_table *sg);
 struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
                                         int flags);
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 8805776c8c52..25adf2b847e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1445,7 +1445,6 @@ static struct drm_driver kms_driver =3D {
         .prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
         .gem_prime_export =3D amdgpu_gem_prime_export,
         .gem_prime_import =3D amdgpu_gem_prime_import,
-       .gem_prime_import_sg_table =3D amdgpu_gem_prime_import_sg_table,
         .gem_prime_vmap =3D amdgpu_gem_prime_vmap,
         .gem_prime_vunmap =3D amdgpu_gem_prime_vunmap,
         .gem_prime_mmap =3D amdgpu_gem_prime_mmap,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 8e867b8b432f..c19100ced040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/swiotlb.h>
+#include <linux/dma-buf.h>

 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
@@ -763,6 +764,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_b=
uffer_object *bo,
  */
 struct amdgpu_ttm_tt {
         struct ttm_dma_tt       ttm;
+       struct drm_gem_object   *gobj;
         u64                     offset;
         uint64_t                userptr;
         struct task_struct      *usertask;
@@ -1227,6 +1229,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm=
_buffer_object *bo,
                 return NULL;
         }
         gtt->ttm.ttm.func =3D &amdgpu_backend_func;
+       gtt->gobj =3D &bo->base;

         /* allocate space for the uninitialized page entries */
         if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags)) {
@@ -1247,7 +1250,6 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm,
 {
         struct amdgpu_device *adev =3D amdgpu_ttm_adev(ttm->bdev);
         struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
-       bool slave =3D !!(ttm->page_flags & TTM_PAGE_FLAG_SG);

         /* user pages are bound by amdgpu_ttm_tt_pin_userptr() */
         if (gtt && gtt->userptr) {
@@ -1260,7 +1262,19 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm=
,
                 return 0;
         }

-       if (slave && ttm->sg) {
+       if (ttm->page_flags & TTM_PAGE_FLAG_SG) {
+               if (!ttm->sg) {
+                       struct dma_buf_attachment *attach;
+                       struct sg_table *sgt;
+
+                       attach =3D gtt->gobj->import_attach;
+                       sgt =3D dma_buf_map_attachment(attach, DMA_BIDIRECT=
IONAL);
+                       if (IS_ERR(sgt))
+                               return PTR_ERR(sgt);
+
+                       ttm->sg =3D sgt;
+               }
+
                 drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
                                                  gtt->ttm.dma_address,
                                                  ttm->num_pages);
@@ -1287,9 +1301,8 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm,
  */
 static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
 {
-       struct amdgpu_device *adev;
         struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
-       bool slave =3D !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
+       struct amdgpu_device *adev;

         if (gtt && gtt->userptr) {
                 amdgpu_ttm_tt_set_user_pages(ttm, NULL);
@@ -1298,7 +1311,16 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *=
ttm)
                 return;
         }

-       if (slave)
+       if (ttm->sg && gtt->gobj->import_attach) {
+               struct dma_buf_attachment *attach;
+
+               attach =3D gtt->gobj->import_attach;
+               dma_buf_unmap_attachment(attach, ttm->sg, DMA_BIDIRECTIONAL=
);
+               ttm->sg =3D NULL;
+               return;
+       }
+
+       if (ttm->page_flags & TTM_PAGE_FLAG_SG)
                 return;

         adev =3D amdgpu_ttm_adev(ttm->bdev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, October 28, 2019 11:14 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Instead of relying on the DRM functions just imple=
ment our own import<br>
functions. This prepares support for taking care of unpinned DMA-buf.<br>
<br>
v2: enable for all exporters, not just amdgpu, fix invalidation<br>
&nbsp;&nbsp;&nbsp; handling, lock reservation object while setting callback=
<br>
v3: change to new dma_buf attach interface<br>
v4: split out from unpinned DMA-buf work<br>
v5: rebased and cleanup on new DMA-buf interface<br>
v6: squash with invalidation callback change,<br>
&nbsp;&nbsp;&nbsp; stop using _(map|unmap)_locked<br>
v7: drop invalidations when the BO is already in system domain<br>
v8: rebase on new DMA-buf patch and drop move notification<br>
v9: cleanup comments<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |&nbsp; 4 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp; | 32 =
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&nbsp;4 files changed, 52 insertions(&#43;), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c<br>
index f14b52cc7205..d5bcdfefbad6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
@@ -370,31 &#43;370,28 @@ struct dma_buf *amdgpu_gem_prime_export(struct dr=
m_gem_object *gobj,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_gem_prime_import_sg_table - &amp;drm_driver.gem_prime_import_sg_=
table<br>
- * implementation<br>
&#43; * amdgpu_dma_buf_create_obj - create BO for DMA-buf import<br>
&#43; *<br>
&nbsp; * @dev: DRM device<br>
- * @attach: DMA-buf attachment<br>
- * @sg: Scatter/gather table<br>
&#43; * @dma_buf: DMA-buf<br>
&nbsp; *<br>
- * Imports shared DMA buffer memory exported by another device.<br>
&#43; * Creates an empty SG BO for DMA-buf import.<br>
&nbsp; *<br>
&nbsp; * Returns:<br>
&nbsp; * A new GEM BO of the given DRM device, representing the memory<br>
&nbsp; * described by the given DMA-buf attachment and scatter/gather table=
.<br>
&nbsp; */<br>
-struct drm_gem_object *<br>
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_table *sg)<br>
&#43;static struct drm_gem_object *<br>
&#43;amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_=
buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv =3D attach-&gt;=
dmabuf-&gt;resv;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv =3D dma_buf=
-&gt;resv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bp, 0, sizeof(=
bp));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D attach-&gt;dmabuf-&gt;siz=
e;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D dma_buf-&gt;size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byte_align =3D PAGE_SIZ=
E;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_D=
OMAIN_CPU;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D 0;<br>
@@ -405,11 &#43;402,9 @@ amdgpu_gem_prime_import_sg_table(struct drm_device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.sg =3D sg;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.ttm-&gt;sg =3D sg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;allowed_domains =3D=
 AMDGPU_GEM_DOMAIN_GTT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;preferred_domains =
=3D AMDGPU_GEM_DOMAIN_GTT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attach-&gt;dmabuf-&gt;ops !=3D &a=
mp;amdgpu_dmabuf_ops)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops !=3D &amp;amd=
gpu_dmabuf_ops)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo-&gt;prime_shared_count =3D 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_unlock(resv);<br>
@@ -425,15 &#43;420,15 @@ amdgpu_gem_prime_import_sg_table(struct drm_devic=
e *dev,<br>
&nbsp; * @dev: DRM device<br>
&nbsp; * @dma_buf: Shared DMA buffer<br>
&nbsp; *<br>
- * The main work is done by the &amp;drm_gem_prime_import helper, which in=
 turn<br>
- * uses &amp;amdgpu_gem_prime_import_sg_table.<br>
&#43; * Import a dma_buf into a the driver and potentially create a new GEM=
 object.<br>
&nbsp; *<br>
&nbsp; * Returns:<br>
&nbsp; * GEM BO representing the shared DMA buffer for the given device.<br=
>
&nbsp; */<br>
&nbsp;struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf *dma_buf)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf *dma_buf)=
<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops =3D=3D=
 &amp;amdgpu_dmabuf_ops) {<br>
@@ -448,5 &#43;443,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(str=
uct drm_device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return drm_gem_prime_import(dev, dma_=
buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj =3D amdgpu_dma_buf_create_obj=
(dev, dma_buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(obj))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return obj;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attach =3D dma_buf_dynamic_attach=
(dma_buf, dev-&gt;dev, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(attach)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; drm_gem_object_put(obj);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ERR_CAST(attach);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dma_buf(dma_buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;import_attach =3D attach;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return obj;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.h<br>
index ce1b3f017451..ec447a7b6b28 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h<br>
@@ -25,10 &#43;25,6 @@<br>
&nbsp;<br>
&nbsp;#include &lt;drm/drm_gem.h&gt;<br>
&nbsp;<br>
-struct drm_gem_object *<br>
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_table *sg);<br>
&nbsp;struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; int flags);<br>
&nbsp;struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev=
,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 8805776c8c52..25adf2b847e8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1445,7 &#43;1445,6 @@ static struct drm_driver kms_driver =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prime_fd_to_handle =3D dr=
m_gem_prime_fd_to_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_export =3D amdg=
pu_gem_prime_export,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_import =3D amdg=
pu_gem_prime_import,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_import_sg_table =3D amdgpu=
_gem_prime_import_sg_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_vmap =3D amdgpu=
_gem_prime_vmap,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_vunmap =3D amdg=
pu_gem_prime_vunmap,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_mmap =3D amdgpu=
_gem_prime_mmap,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 8e867b8b432f..c19100ced040 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -39,6 &#43;39,7 @@<br>
&nbsp;#include &lt;linux/slab.h&gt;<br>
&nbsp;#include &lt;linux/swap.h&gt;<br>
&nbsp;#include &lt;linux/swiotlb.h&gt;<br>
&#43;#include &lt;linux/dma-buf.h&gt;<br>
&nbsp;<br>
&nbsp;#include &lt;drm/ttm/ttm_bo_api.h&gt;<br>
&nbsp;#include &lt;drm/ttm/ttm_bo_driver.h&gt;<br>
@@ -763,6 &#43;764,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct t=
tm_buffer_object *bo,<br>
&nbsp; */<br>
&nbsp;struct amdgpu_ttm_tt {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_dma_tt&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ttm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object&nbsp;&nbsp;=
 *gobj;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
erptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *usertask;<br>
@@ -1227,6 &#43;1229,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct=
 ttm_buffer_object *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;ttm.ttm.func =3D &=
amp;amdgpu_backend_func;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;gobj =3D &amp;bo-&gt;base=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate space for the =
uninitialized page entries */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm_sg_tt_init(&amp;gt=
t-&gt;ttm, bo, page_flags)) {<br>
@@ -1247,7 &#43;1250,6 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *=
ttm,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D amdgpu_ttm_adev(ttm-&gt;bdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ttm_tt *gtt =
=3D (void *)ttm;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool slave =3D !!(ttm-&gt;page_flags =
&amp; TTM_PAGE_FLAG_SG);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* user pages are bound by=
 amdgpu_ttm_tt_pin_userptr() */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gtt &amp;&amp; gtt-&gt=
;userptr) {<br>
@@ -1260,7 &#43;1262,19 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt =
*ttm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (slave &amp;&amp; ttm-&gt;sg) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm-&gt;page_flags &amp; TTM_=
PAGE_FLAG_SG) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!ttm-&gt;sg) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_b=
uf_attachment *attach;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_ta=
ble *sgt;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attach =3D g=
tt-&gt;gobj-&gt;import_attach;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgt =3D dma_=
buf_map_attachment(attach, DMA_BIDIRECTIONAL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(s=
gt))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(sgt);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm-&gt;sg =
=3D sgt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_prime_sg_to_page_addr_arrays(ttm-&gt;sg, ttm-&gt;=
pages,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&=
gt;ttm.dma_address,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm-&=
gt;num_pages);<br>
@@ -1287,9 &#43;1301,8 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *=
ttm,<br>
&nbsp; */<br>
&nbsp;static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ttm_tt *gtt =
=3D (void *)ttm;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool slave =3D !!(ttm-&gt;page_flags =
&amp; TTM_PAGE_FLAG_SG);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gtt &amp;&amp; gtt-&gt=
;userptr) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_tt_set_user_pages(ttm, NULL);<br>
@@ -1298,7 &#43;1311,16 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_=
tt *ttm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (slave)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm-&gt;sg &amp;&amp; gtt-&gt=
;gobj-&gt;import_attach) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dma_buf_attachment *attach;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; attach =3D gtt-&gt;gobj-&gt;import_attach;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dma_buf_unmap_attachment(attach, ttm-&gt;sg, DMA_BIDIRECTION=
AL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ttm-&gt;sg =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm-&gt;page_flags &amp; TTM_=
PAGE_FLAG_SG)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev =3D amdgpu_ttm_adev(t=
tm-&gt;bdev);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_--

--===============1054867076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1054867076==--

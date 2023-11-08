Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E96C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 00:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9753C10E6C8;
	Wed,  8 Nov 2023 00:01:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907C910E6C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 00:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRG86yenfMgi4pU67DOKV/WFJ3UGa7vLV9nFWX3kV95ow3GlXKL3K8Ih0mwzCMcIskpNjzT4JYykdV63SRg/HOT4EIjjBxze0CaXlGcz3FGBOqSgY2jBSg6Lw/3nnCBTGK0Oie4IaRwBzsC9BMTH6+I378yKo+TiJF9ohe707wcrZUcl2WigsoYFwOC0a1C5z+lmAa2eTbGjKRqw/H2taOgvM8jAskmUL2OZselTWlk5YafXXvS+ulbcHbFf7DKmbWaelncYTlHT2Mfu78HdWaCBZYAUqkioRBq+5SgKoNPTnbdCwuckzZAbBijymvtPKWQre4CyKYrK3V+RqjZohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SKQWvSau4EZpokAM2cQI+vWFn038ryWDeOPfaQB8Lc=;
 b=Q9K7rmaKpmMXE8hRzISSWB3xVlVhG1+eyNGdkk/r/61INktnSNSyhbhZnQA+gek/P/a7LrNwy7pHL2R0CflgvjD30n7dqokrA1MKnkRU9PLUUSX9oJjiBHrjQwohHsDGR5AXxlACBSl2ioWnq670FPmDqts1EHQ6L8JSi+NW7PG6bTyzGwxOmWIAQfSJpDKrCstNlXfJY/j0iYNlG3srkFuKE4F0nHLRla5Oo8nXPElMC2SKdTftvMW816pFvKARsMQiPZKGuR4Ewt4BKppB1y88uOEdTDsUXxL/e/x8kvPi3I64EBoc031bi6pkLynnGoLMewwHM9WkEZevxPScHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SKQWvSau4EZpokAM2cQI+vWFn038ryWDeOPfaQB8Lc=;
 b=0O8sNkrFGYcB8Z25VCWOeSZ7By/nNVLTwAl9QihuA+fSjSD0L7iUIgP8Ula7Nzj0vfFYIMeaXh+0iMmJovEepjnPuM+b0T7rscDudm1ZM2gmIQnO/dZUDnNfV+ek+unip0Na9dECS0BarTENv72exEh+VxkIRqnMC/tPp2jWMAM=
Received: from MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 00:01:15 +0000
Received: from MW2PR12MB2569.namprd12.prod.outlook.com
 ([fe80::73e4:f725:be1a:d0fb]) by MW2PR12MB2569.namprd12.prod.outlook.com
 ([fe80::73e4:f725:be1a:d0fb%4]) with mapi id 15.20.6954.025; Wed, 8 Nov 2023
 00:01:14 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM
Thread-Topic: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM
Thread-Index: AQHaEZukJAi93rFM1UCljsLVyJL9S7BvdW5A
Date: Wed, 8 Nov 2023 00:01:14 +0000
Message-ID: <MW2PR12MB2569904F434244A295AE2F30E3A8A@MW2PR12MB2569.namprd12.prod.outlook.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-5-Felix.Kuehling@amd.com>
In-Reply-To: <20231107165814.3628510-5-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=caa1a678-d83d-4f78-a91c-aed745504652;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-07T22:47:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB2569:EE_|LV2PR12MB5872:EE_
x-ms-office365-filtering-correlation-id: a628c796-d4cc-4ee1-6feb-08dbdfedd340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EOYVWwB59EYqGLXAZBKOLOQ4MCr75iDq61tyHPQ9byfgzhkpjIfiBPM3vDh3nqIvrb/OGmrRI/cBXWBVB1UdlIaup4wl9HJYfQbkzOlNh0T5uYHByzyjmZZ+LjJKLODnUz1XsV2REblgAxrCXjjWJN6yKtUeBk2hE78RyKI6/NyVvezCuRNGm3oVgdUGqquHPefGQCVkYVBJMZHaTbT6cOr8woOIVRd2CX14T8Pl922BjU0EUZfXbiAYd8fY/mvO036apdyvuPmWHNkgsbqK0rV9gJhkorwEJRMcBH0BJXoNzo1MFp38sdIWXIuiSF4/gghZ91WYt6rl3uGawnjSOmfcLnLZFtxeaS2jXcGsbAxv153/wXCbYyyOAoChs+aByeVoycKMAqkaIenHWPJpi6MAtvRAHsfyCgHLilm8XOqPLB7T1VU7Z98eGmEWM5eCG0HzbgOYuGZfMKt9kCeB9JcPl6wyfFwymKt+GH7+n8IpIc/ENAGDN8kyn0o1/p8UVrwBaJHl52LjVsROQm+DfnHGvUjeERq0pQJmQ0yDesLDF0lzrMhZmKWSltOt1lrGP8ppQFWgmlrg4NpYZxtAp0rhZCGF1/WY198xuiZfhuElVnXkm5XinLYt3bxSrinQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2569.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(55016003)(33656002)(5660300002)(52536014)(4326008)(8676002)(8936002)(83380400001)(64756008)(26005)(316002)(66446008)(66476007)(110136005)(76116006)(66556008)(54906003)(66946007)(2906002)(41300700001)(9686003)(478600001)(71200400001)(53546011)(6506007)(7696005)(122000001)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?faHr3jn0BHc6OmiIaWg5IApTTXHXCsTYE7ODvgGh8UEEl17LMYGV5Vn/Dv3n?=
 =?us-ascii?Q?3+UDavc7mBdKUpdJp+P9eFy7AIHE6QzRnAn47RPHqMpr1x4tAlLwhmVuHqFS?=
 =?us-ascii?Q?z2mObAfANOYPJZYxXVatxm7QvoBb9aYkjhB5e/EpKl1yDXJJlBOFTVHtetfW?=
 =?us-ascii?Q?QkLpRgxxTUTQ9M+OkkxFeotwTy/r3iFrCaB4f98qk/4o91VQpmr4a6BvCVcl?=
 =?us-ascii?Q?ythnpiKvJA8Y6pT3aZXu4f/cnUEVbeE/BqMGfX38Ya8K0xFfuPqyBHGalba1?=
 =?us-ascii?Q?XA+Dm5sJnl9kAXm+5W2mMkaoqWXfXlNIJn2noUnT7ju2FGocGOwjnjGbF2Ap?=
 =?us-ascii?Q?6xru6kOBIPIZ8+34Kw4r/JU2Hzs9SFhlR6xzmK3boLnuyd0MMLw6906HLfXZ?=
 =?us-ascii?Q?LfPcNCP9OaP0hUldUvuYb+M6q9lwD/aL9kYtBTPRdB0FlzF1hO7L7Tg6AWkY?=
 =?us-ascii?Q?qx1JsR4izjQYwzss6tV0HQfXBc95HETPIdYQawOnOqyi8np9z54Nymroseaa?=
 =?us-ascii?Q?BrbN84/BSp9gZAY7phZYl8PR3MkncWbZJV3e7D3NzdawHTcPjgnJ8G5RLxvp?=
 =?us-ascii?Q?EsnTwYO5PUnqUews6W2Zp81cshHIoKiMyFfLpINLXVmeZiy7do724P0vU5+l?=
 =?us-ascii?Q?gBi4uS8IajXAkfuL7FywpxA+z4LT4rfscdUjE1Z3/DN8je+djvAreCHzXmj1?=
 =?us-ascii?Q?nwf6pQbhGMP8GqC2lTnNRUNOlxaLAuXfiNLThXsKddfua+BCGFBgb+EwuTXC?=
 =?us-ascii?Q?k6piUqieuHx2lZ5EJ0eGYjmIsvqCXa2YMcjc24ZrdQy4J067pu16OSpj3MU5?=
 =?us-ascii?Q?qlsJdh0S5tH+iZZb9p55aphqqeo/wiyR6XhjeWnHe1MheOwUHDdioL2k7M7Z?=
 =?us-ascii?Q?O/C6Xj63joFkhasG1GBbfXexVUb7Ui+9J6XQe9ODVxgs+hert5MaZ0/NHhK8?=
 =?us-ascii?Q?L6Y/lia1feUesppV8xO34n18l4eLSRNL/PhAgIwAFh8pUGIl6VhTWeesQSLe?=
 =?us-ascii?Q?KZtia2BMnqbBRaXoknTXpkNC4ercWWbJ/vsCa4xlLkBFRpENdg2kxcVXapaV?=
 =?us-ascii?Q?yPlG81Zi9sW5id1nSm5dtH7mz6e5CrxQQnN+29FMluQSpPVcJPRzNL/BQMtt?=
 =?us-ascii?Q?kGtolTjkY6A4RP5VDqNttMX0SvKVLBhzZ8jrXqNRGW+XD3Ha+BFUt+xfC1UM?=
 =?us-ascii?Q?fSAktlXgya6QOD1XC5vINkILrp5g0uVNVKGgDvg4G1zAGfs2BPJHrAFlE1Wf?=
 =?us-ascii?Q?09ayuwHb1uCv0e6G01U8b7jGUarwpwdbe9G58MF6iWRfdq6m2RFBCzgGBzQ/?=
 =?us-ascii?Q?3dkuPCPGhwdtc5qguHQ6X/eXHtLDxcxKxlN1tuZHvpHpMKGz4Ef1jqWX5voU?=
 =?us-ascii?Q?YgIpm0oHqlwyx0orI9iXKrxruFXYig5CEVWq1ixNBK8g6SY3Csy2Us0PRt9V?=
 =?us-ascii?Q?eIcn2CyfqWeK+wWui0nuN4tbrzzK1MKjSlwqbo6FT3oEagHONsTgWZ3HPeoj?=
 =?us-ascii?Q?StIxbrKoAqs6tbS/jCbwlfFagZSiDsA6BTRLWMl408SDhmh4ilSARbXlXYt1?=
 =?us-ascii?Q?nkFWy78JhMnq3BHHHzM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2569.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a628c796-d4cc-4ee1-6feb-08dbdfedd340
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 00:01:14.7026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqjMt4+9m26TWoPtR1lBnC/zLiKErXQ5IYp2ypGjVZeE6sY4En96COeQRiX4NGK6FJc9T5k79z4fCvgd7L2WeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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
Cc: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, November 7, 2023 10:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chen, Xiaogang <Xiaogang.=
Chen@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM

Use drm_gem_prime_fd_to_handle to import DMABufs for interop. This ensures =
that a GEM handle is created on import and that obj->dma_buf will be set an=
d remain set as long as the object is imported into KFD.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  9 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 64 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 15 ++---
 3 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 4caf8cece028..88a0e0734270 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -318,11 +318,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *pro=
cess_info,
                                            struct dma_fence **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
                                              struct kfd_vm_fault_info *inf=
o); -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
-                                     struct dma_buf *dmabuf,
-                                     uint64_t va, void *drm_priv,
-                                     struct kgd_mem **mem, uint64_t *size,
-                                     uint64_t *mmap_offset);
+int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int f=
d,
+                                        uint64_t va, void *drm_priv,
+                                        struct kgd_mem **mem, uint64_t *si=
ze,
+                                        uint64_t *mmap_offset);
 int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
                                      struct dma_buf **dmabuf);
 void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev); diff --git=
 a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_amdkfd_gpuvm.c
index 4bb8b5fd7598..1077de8bced2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2006,8 +2006,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(

        /* Free the BO*/
        drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
-       if (!mem->is_imported)
-               drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handl=
e);
+       drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
        if (mem->dmabuf) {
                dma_buf_put(mem->dmabuf);
                mem->dmabuf =3D NULL;
@@ -2363,34 +2362,26 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct am=
dgpu_device *adev,
        return 0;
 }

-int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
-                                     struct dma_buf *dma_buf,
-                                     uint64_t va, void *drm_priv,
-                                     struct kgd_mem **mem, uint64_t *size,
-                                     uint64_t *mmap_offset)
+static int import_obj_create(struct amdgpu_device *adev,
+                            struct dma_buf *dma_buf,
+                            struct drm_gem_object *obj,
+                            uint64_t va, void *drm_priv,
+                            struct kgd_mem **mem, uint64_t *size,
+                            uint64_t *mmap_offset)
 {
        struct amdgpu_vm *avm =3D drm_priv_to_vm(drm_priv);
-       struct drm_gem_object *obj;
        struct amdgpu_bo *bo;
        int ret;

-       obj =3D amdgpu_gem_prime_import(adev_to_drm(adev), dma_buf);
-       if (IS_ERR(obj))
-               return PTR_ERR(obj);
-
        bo =3D gem_to_amdgpu_bo(obj);
        if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
-                                   AMDGPU_GEM_DOMAIN_GTT))) {
+                                   AMDGPU_GEM_DOMAIN_GTT)))
                /* Only VRAM and GTT BOs are supported */
-               ret =3D -EINVAL;
-               goto err_put_obj;
-       }
+               return -EINVAL;

        *mem =3D kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
-       if (!*mem) {
-               ret =3D -ENOMEM;
-               goto err_put_obj;
-       }
+       if (!*mem)
+               return -ENOMEM;

        ret =3D drm_vma_node_allow(&obj->vma_node, drm_priv);
        if (ret)
@@ -2440,8 +2431,41 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_=
device *adev,
        drm_vma_node_revoke(&obj->vma_node, drm_priv);
 err_free_mem:
        kfree(*mem);
+       return ret;
+}
+
+int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int f=
d,
+                                        uint64_t va, void *drm_priv,
+                                        struct kgd_mem **mem, uint64_t *si=
ze,
+                                        uint64_t *mmap_offset)
+{
+       struct drm_gem_object *obj;
+       uint32_t handle;
+       int ret;
+
+       ret =3D drm_gem_prime_fd_to_handle(&adev->ddev, adev->kfd.client.fi=
le, fd,
+                                        &handle);
+       if (ret)
+               return ret;
+       obj =3D drm_gem_object_lookup(adev->kfd.client.file, handle);
+       if (!obj) {
+               ret =3D -EINVAL;
+               goto err_release_handle;
+       }
+
+       ret =3D import_obj_create(adev, obj->dma_buf, obj, va, drm_priv, me=
m, size,
+                               mmap_offset);
+       if (ret)
+               goto err_put_obj;
+
+       (*mem)->gem_handle =3D handle;
+
+       return 0;
+
 err_put_obj:
        drm_gem_object_put(obj);
+err_release_handle:
+       drm_gem_handle_delete(adev->kfd.client.file, handle);
        return ret;
 }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 4417a9863cd0..1a2e9f564b7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1564,16 +1564,11 @@ static int kfd_ioctl_import_dmabuf(struct file *fil=
ep,  {
        struct kfd_ioctl_import_dmabuf_args *args =3D data;
        struct kfd_process_device *pdd;
-       struct dma_buf *dmabuf;
        int idr_handle;
        uint64_t size;
        void *mem;
        int r;

-       dmabuf =3D dma_buf_get(args->dmabuf_fd);
-       if (IS_ERR(dmabuf))
-               return PTR_ERR(dmabuf);
-
        mutex_lock(&p->mutex);
        pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
        if (!pdd) {
@@ -1587,10 +1582,10 @@ static int kfd_ioctl_import_dmabuf(struct file *fil=
ep,
                goto err_unlock;
        }

-       r =3D amdgpu_amdkfd_gpuvm_import_dmabuf(pdd->dev->adev, dmabuf,
-                                             args->va_addr, pdd->drm_priv,
-                                             (struct kgd_mem **)&mem, &siz=
e,
-                                             NULL);
+       r =3D amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, args->dm=
abuf_fd,
+                                                args->va_addr, pdd->drm_pr=
iv,
+                                                (struct kgd_mem **)&mem, &=
size,
+                                                NULL);
        if (r)
                goto err_unlock;

@@ -1601,7 +1596,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep=
,
        }

        mutex_unlock(&p->mutex);
-       dma_buf_put(dmabuf);

        args->handle =3D MAKE_HANDLE(args->gpu_id, idr_handle);

@@ -1612,7 +1606,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep=
,
                                               pdd->drm_priv, NULL);
 err_unlock:
        mutex_unlock(&p->mutex);
-       dma_buf_put(dmabuf);
        return r;
 }

--
2.34.1


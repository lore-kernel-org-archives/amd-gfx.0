Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0B7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542E310E673;
	Tue,  7 Nov 2023 19:44:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9134110E673
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBazEbYFS/DCtApARzSp61nWwvhQ2m5opOSRzon4BApkgG/+ujQw1XaM5EC0jWeJ0Jt2xtVYedBlUblkmYJ0IP0qwiwq6fQhzwHUg84BbXExoBGlnHOqvPeJsrXkQVTAs30uAKV7gBR+xno2bYKbnfDeSDGHXW27o8RLQTlzQnT+U+H6AFQcMWuZNPa22sW2jfOfwkjONAv3wj7LGy1MUFnBVrpGPBBcALfiryAqrKrGaxmgsBsrzRdam7qz5oZx55Pg5A1Bcs035XtG86MAYFZTEvLF5S8RpUZKfsomDNkkOK8A9dx6II/Ukun3abS27g7R47rMhzzH/TuBY/kLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD2BIJqIKRLMrKtKkX9F3UolM1eoB+6jen8/tLnSO18=;
 b=jdYG53aNv2faM4fV10Uj8Q1JmO0NSLmneUR7JYxKAC0YKrY9+l4jrj/XnxiuhcEr35x0T6IK8cf0tccIgqSgFc54v+eG/3KzRaKo+WfjZ0TeK+J39WQijZ00+2NjBVejBzRJpE5F5L0KYQZQjdkIaUbJJaC/kMcuausC/7899fDFXvc4X86XUV9Jj44hLWP+/meDaXu4b6XncvUMjZuodSfbUOQJlv5W4yoRoqRnRkEezjrfVjJdJISglVMVv02iR2kp6lpRa8QH3hGGQvDIwZAJGHjpuN7HRqj7g9EAV6Qr2T/PnngfDhutUdl+ti3NMdPldncOFkRFujLoyVfvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD2BIJqIKRLMrKtKkX9F3UolM1eoB+6jen8/tLnSO18=;
 b=fiD8Oslr0hdsYJxCAB2IuZ0MvyOnb6tys9Owspm8HF7bRAvhfNus/qFje03jVF3iHoN/g96nnxA4PKfll3MsaHzL3CqcT7+Lns3yqlOmOd0owNgk9GuWNbRoVVxkIrYy8AfUXIFciDI0KfVk0llttpR1xJYW7KeC8Nnw7U98vvg=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Tue, 7 Nov
 2023 19:44:53 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fed:e1b0:3dc9:3774]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fed:e1b0:3dc9:3774%4]) with mapi id 15.20.6954.025; Tue, 7 Nov 2023
 19:44:53 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/6] drm/amdkfd: Export DMABufs from KFD using GEM handles
Thread-Topic: [PATCH 4/6] drm/amdkfd: Export DMABufs from KFD using GEM handles
Thread-Index: AQHaEZukleXlr3cGKk2ZGUaLvhhK5bBvLlwg
Date: Tue, 7 Nov 2023 19:44:53 +0000
Message-ID: <SN1PR12MB25751192799E41D409AB0758E3A9A@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-4-Felix.Kuehling@amd.com>
In-Reply-To: <20231107165814.3628510-4-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a17e6101-c858-430c-a864-d5c0a2e906d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-07T18:32:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2575:EE_|DS0PR12MB8341:EE_
x-ms-office365-filtering-correlation-id: 25644ae9-89ba-40fd-0f62-08dbdfca034d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1pRD2B6p3zyN2IaVI8Ktx8rYEzrgSgChaGsYD0oszfBlIpKglWvnqO+fZUNLwfmI5f/WddILFBlMaqExVpUARNvCNbGul+9j7qwfUZUatUh9Y9gX6BV7x2DTZEq1mi50UC/anfpb5s1mXP9d6Mb/liGkM3fnThgCptaceE7vmTUM1D26fmilRY2cuQVS0QPWAADtCXvTENZqC7rOWSAPwb94Fi8G1dOIPzKGERsRVNE+zRKJ5G8v/d9KMKbanRpFcIGSkLQP+5BBZyeR6ss2kIz2JlGfe/R1RGHr3XEuKIQYXnyj46EZGdoqiPaxeeN3IjcNRltrowOhnM8K6hgs1b3843IasHS8OZm2rhJgo8xfG7dHi6NObgaMfregQIonSZACwaLWPuhp3OQVkUlviX1tmOOrWZFTv/18UWHdTzZfEy6wsVmTtsa3unz4muvHePwyu0DmlRateWnsTTXCIV4ktede84S/MgC0ivduJzlMuM/gv/YYs3HsFGnY13HL0tZ2vKzNsfZYhRfbhVnCyxTmGJLhDFG+ZIhGk5s45AcrjH4FohksXXYQkz9rLeZOTLsPlyXDLsU/9HrqalV+QQ8XWOfE7cBn6UyupU3eNHi9D16xh9dq5jd6vhfcwvE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(122000001)(2906002)(33656002)(26005)(86362001)(5660300002)(41300700001)(8676002)(8936002)(4326008)(316002)(478600001)(52536014)(66946007)(55016003)(66446008)(110136005)(66556008)(64756008)(66476007)(76116006)(38100700002)(71200400001)(38070700009)(83380400001)(54906003)(7696005)(9686003)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sXBPPAvV43fKq2lJpHmKkGqtb08lhtCGPyoFSUTMTiCwqNMuQWO9QzdhNj0a?=
 =?us-ascii?Q?DASKTjQcKNyyUNkEiUd+9KqsRg2YenkWVc5Zj4qntgGvnR7PiB8HtYPR9RX6?=
 =?us-ascii?Q?vXhuazuHbRf3hwSqLU0/5G7YQvj/bsursz9K26BokqFzm0BhZfYLuuvbC1GZ?=
 =?us-ascii?Q?B8M/0wZbLbNu9W+s1o+SqsqulqPFmMTsIDZzzHSJWzEmdhEeICMZxNOp5/+/?=
 =?us-ascii?Q?VGsQgtv14KgECDp//wf3LOvTCrmuxBJvrdiOGP2/jkcLOsCoMdnL+XOFc0eX?=
 =?us-ascii?Q?b5w3TKosk1+d8PmVAb+AOF7bNW+jCVsAzHkMG4q4xE+P8MYUnOj8fgik2iPb?=
 =?us-ascii?Q?ltZmhxQAUGzurO8iYk5I/AwoJEJYgmBqbtx6rwyWL7iNVz+EhslRtsfMfybR?=
 =?us-ascii?Q?u5r9H/el33pqhvnW2Co7vbZGnM/uHFUHOduPyxfndwfNDR1QZhXtLeUWDpSZ?=
 =?us-ascii?Q?Vz5lxcuQF+SHBzn6HUJmpmcRiDqeRr0ARR7E/J7XJyqxtjzY+eSSX0cD74jZ?=
 =?us-ascii?Q?Wecx63XyutldhT8LJtUSbUV+zQAGNdBJnjdd7eVUf3tY4Ovrn/gnTvlyI4X6?=
 =?us-ascii?Q?C+iU9hKNUB0e08I9su7/O1s4VliM/Y53k1RgVj3CWJp/+d3tLrcahI/LJiYB?=
 =?us-ascii?Q?t1Cr5ENAjLwq2OEbRknMm+MoR0NREnYzrMI/RjrcZ4KTaRx7fcmnbTbCWCdm?=
 =?us-ascii?Q?ot4J2SY+UmFJpFc9aZiAByUcCRAjA2LeUJFx4aLqGszdF1cVp/Hkk+9ZyPWr?=
 =?us-ascii?Q?LzpJ4SYG3cOKdS331uB4r4LN6qqg6CMdKR4f8LokQm3vNN6RqZxrZB0vcjc4?=
 =?us-ascii?Q?fRha/tPoMFEMaW2+gl2OzNbcAIcM6S1jzUVBREBhwwSFMStaRsVOvNWtF4TO?=
 =?us-ascii?Q?tfWZ5c1s0pBYuw9od40Y4wDuB5DfvTYZcucIDplW8xEHClXHuH1CDQ5ajw0y?=
 =?us-ascii?Q?BGog1p16UEhhc6mlD5OVJTTJyArLrT+ZWYQ3iUS7SWUWwr42uQxyDCNIQiDF?=
 =?us-ascii?Q?SuL+dgteuyczEh8zX1Hsvx4C0RbP1gK9D0e9Ygr1duJxPrUg+Bp+2gIhTRDx?=
 =?us-ascii?Q?6lfgcc+kdP0so9cOoZJzj+j//xyLhrNV364DmbE/VQGNegWbgOhpoNeHiMVO?=
 =?us-ascii?Q?Sc9/KQ1CQh9mQRpwb7qsEweTUyiFIRBgu8VTZCiGE1jhXX5QTE7/xi9y0vfq?=
 =?us-ascii?Q?HG4QLPeCmpFgnjR1p9ofc53SJ6c6ZV/zpl7CQLAi9NIPvY4bU7tlmZ0iuyzC?=
 =?us-ascii?Q?YJYXneDJGXzhp4tPEnJ98Yo8zWqR0Q5pduEqaptVjwzLePKDNA91p2X7xMb1?=
 =?us-ascii?Q?OUkPiyZqxyGUzaNm/Isb+WZ9HinbLk5w+4QmmFgpK5OP3Az78TdNdRGJfNxo?=
 =?us-ascii?Q?fkkW7WDayIhPWymbC/rspuesBy6P1rmwRHgkvqbWgTc4u4OStXt7YRRy/JpS?=
 =?us-ascii?Q?iaB/4llwdLQvV1CkwMghvO2YmXNJ/rWsABpwfI2Ue5vXoMAf/4CPKfYC4CEy?=
 =?us-ascii?Q?KX/x00l4JX/ubvre2qAsG2XaeFG5q68rkBe/dzhOgYJLY4tSUdcKVP4uKMLI?=
 =?us-ascii?Q?a+iIiX5HYuNsg/ToqJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25644ae9-89ba-40fd-0f62-08dbdfca034d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 19:44:53.4226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvl36Lkb8cScx4xSyB/FrRhBnINHIgQzcjL+dMLxxZlRA11/UbTXeatXziSvKK6b8MN/Ugf+0HAGTn8XIiK+MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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

My queries inline.

Regards,
Ramesh

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, November 7, 2023 10:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chen, Xiaogang <Xiaogang.=
Chen@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH 4/6] drm/amdkfd: Export DMABufs from KFD using GEM handles

Create GEM handles for exporting DMABufs using GEM-Prime APIs. The GEM hand=
les are created in a drm_client_dev context to avoid exposing them in user =
mode contexts through a DMABuf import.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 11 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 33 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +--
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 6ab17330a6ed..b0a67f16540a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -142,6 +142,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *ad=
ev)  {
        int i;
        int last_valid_bit;
+       int ret;

        amdgpu_amdkfd_gpuvm_init_mem_limits();

@@ -160,6 +161,12 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *a=
dev)
                        .enable_mes =3D adev->enable_mes,
                };

+               ret =3D drm_client_init(&adev->ddev, &adev->kfd.client, "kf=
d", NULL);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to init DRM client: %d\n=
", ret);
+                       return;
+               }
+
                /* this is going to have a few of the MSBs set that we need=
 to
                 * clear
                 */
@@ -198,6 +205,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *a=
dev)

                adev->kfd.init_complete =3D kgd2kfd_device_init(adev->kfd.d=
ev,
                                                        &gpu_resources);
+               if (adev->kfd.init_complete)
+                       drm_client_register(&adev->kfd.client);
+               else
+                       drm_client_release(&adev->kfd.client);

                amdgpu_amdkfd_total_mem_size +=3D adev->gmc.real_vram_size;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 68d534a89942..4caf8cece028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -32,6 +32,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memremap.h>
 #include <kgd_kfd_interface.h>
+#include <drm/drm_client.h>
 #include <drm/ttm/ttm_execbuf_util.h>
 #include "amdgpu_sync.h"
 #include "amdgpu_vm.h"
@@ -84,6 +85,7 @@ struct kgd_mem {

        struct amdgpu_sync sync;

+       uint32_t gem_handle;
        bool aql_queue;
        bool is_imported;
 };
@@ -106,6 +108,9 @@ struct amdgpu_kfd_dev {

        /* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
        struct dev_pagemap pgmap;
+
+       /* Client for KFD BO GEM handle allocations */
+       struct drm_client_dev client;
 };

 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0c1cb6048259..4bb8b5fd7598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
+#include <linux/fdtable.h>
 #include <drm/ttm/ttm_tt.h>

 #include "amdgpu_object.h"
@@ -804,13 +805,22 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,  sta=
tic int kfd_mem_export_dmabuf(struct kgd_mem *mem)  {
        if (!mem->dmabuf) {
-               struct dma_buf *ret =3D amdgpu_gem_prime_export(
-                       &mem->bo->tbo.base,
+               struct amdgpu_device *bo_adev;
+               struct dma_buf *dmabuf;
+               int r, fd;
+
+               bo_adev =3D amdgpu_ttm_adev(mem->bo->tbo.bdev);
+               r =3D drm_gem_prime_handle_to_fd(&bo_adev->ddev, bo_adev->k=
fd.client.file,
+                                              mem->gem_handle,
                        mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE=
 ?
-                               DRM_RDWR : 0);
-               if (IS_ERR(ret))
-                       return PTR_ERR(ret);
-               mem->dmabuf =3D ret;
+                                              DRM_RDWR : 0, &fd);
+               if (r)
+                       return r;
+               dmabuf =3D dma_buf_get(fd);
+               close_fd(fd);
+               if (WARN_ON_ONCE(IS_ERR(dmabuf)))
+                       return PTR_ERR(dmabuf);
+               mem->dmabuf =3D dmabuf;
        }

        return 0;
@@ -1826,6 +1836,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
                pr_debug("Failed to allow vma node access. ret %d\n", ret);
                goto err_node_allow;
        }
+       ret =3D drm_gem_handle_create(adev->kfd.client.file, gobj, &(*mem)-=
>gem_handle);
+       if (ret)
+               goto err_gem_handle_create;
        bo =3D gem_to_amdgpu_bo(gobj);
        if (bo_type =3D=3D ttm_bo_type_sg) {
                bo->tbo.sg =3D sg;
@@ -1877,6 +1890,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_pin_bo:
 err_validate_bo:
        remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+       drm_gem_handle_delete(adev->kfd.client.file, (*mem)->gem_handle);
+err_gem_handle_create:
        drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
        /* Don't unreserve system mem limit twice */ @@ -1991,8 +2006,12 @@=
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(

        /* Free the BO*/
        drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
-       if (mem->dmabuf)
+       if (!mem->is_imported)
+               drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handl=
e);
+       if (mem->dmabuf) {
                dma_buf_put(mem->dmabuf);
+               mem->dmabuf =3D NULL;
+       }
        mutex_destroy(&mem->lock);

Ramesh: What happens if user invokes "free" using KFD IOCTL while the BO is=
 imported and mapped on the device using DRM IOCTLs. Could it lead to incon=
sistent state?. For example the call drm_gem_handle_delete() will remove Dm=
abuf, close the GEM object. If user invokes free() using KFD Apis then the =
underlying object could be removed. It is not clear if this impacts devices=
 that have just imported.

        /* If this releases the last reference, it will end up calling diff=
 --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_chardev.c
index 06988cf1db51..4417a9863cd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1855,8 +1855,8 @@ static uint32_t get_process_num_bos(struct kfd_proces=
s *p)
        return num_of_bos;
 }

-static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
-                                     u32 *shared_fd)
+static int criu_get_prime_handle(struct kgd_mem *mem,
+                                int flags, u32 *shared_fd)
 {
        struct dma_buf *dmabuf;
        int ret;
--
2.34.1


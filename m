Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BFDC61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 07:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ECE910E262;
	Wed, 26 Aug 2026 07:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3RWitXM9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D31B10E262
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 07:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUwP6UX9UEMm9Zc9+tNddNeb5shu21Ng93h+hLW2THxVDjEH7qmpbXJpPNYpSO9BQSp0dBCApyhVXwsARk12a2BQuwzu1Z7WESCe2CRZmxmtoVVJR2ClgWqxA/upP5OEfpgJfDkvSsqIwZUT1b/9zBf9SEVzV/OsPIWZKbWLTrKbNRT450GvZ9R0/0OXYjDySW5vQLptDhs8FjP22c0LlMDBhsvL/vkZrNagnbXBFpcWlZ8MA5mVsj9PbYj6XvyC0c5SeRDXriW4r8F/OnFuG7x8lULbz5HVVB5QcIBwZLWaIy9xvkTXlWUUzFREH8J6YUspqMBfI4rEzBUkWVfd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCS/r5di5pmd1B0XcZZtBXlPFbPxv2VrRLvfb9yaiII=;
 b=EZ4XwPo224kj1fj45WVAfnt/gK4F0jrvpZWfyBtwjUJnhjgp7Gt3BNap7ELLKCW9r3EKATrgNUD5dHw883AIW3GvXnIX3yqP23w6v9FioSTQj/tgj5hMW4Xt27d15wCJiAi5P6cOzqWPBwOKIXPCCjhkHb/WsPJS8UVTNAahF36+KyKId0JehyiFpBwKZozNmsNSXiR+kEs08FxeGp5xfjD7gx7ZvbRSN2axMOwJGe8Oqi2m6Az8lC58iIPjduMmhpkAD+CXopGgGXNA1+BIv4/0ncJX/gv95jiuYeI4mgz2BLuPmeaQ6u5usmLO8e7DhUvsZvxofzsoe6CrbEEKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCS/r5di5pmd1B0XcZZtBXlPFbPxv2VrRLvfb9yaiII=;
 b=3RWitXM9vVPkkF1vRA8K6ObjYsFbhBkV872nyvNxYVAKof+IUmbDHE6rF38uDsSw87oSH0TsJHkGXVJfpU0FbUMED87n+aDaqdbkRIyjRDY8/00X7NXGiiZq8NcpDqMNfnUW+t+xvxUC7Gu3mTaMjyu74GiSpAWA4towTzmhCKE=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 07:34:30 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 07:34:29 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Ghosh,
 Prerona" <Prerona.Ghosh@amd.com>
Subject: RE: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is
 attached
Thread-Topic: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is
 attached
Thread-Index: AQHdNGbr5Ymh+UT3w0mK2ppFSX8jTrav8cHQ
Date: Wed, 26 Aug 2026 07:34:29 +0000
Message-ID: <CY5PR12MB6369E2C2D1A79A51CDCF631CC1AE2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260825075346.536983-1-yifan1.zhang@amd.com>
In-Reply-To: <20260825075346.536983-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-26T07:34:23.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA1PR12MB9490:EE_
x-ms-office365-filtering-correlation-id: 6320a7d8-1ebf-413b-b55e-08df034476f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: jc3DVEEGU/8D8jRthiCskFiwm1/jOtKVww9Bn7RQWnUoAV6Sark4Gjw3CChnf4mTTKfLa9w9O+FemgkBjYBg8GLPY2g/TROOvc51IHJJOJQxhBZCzi3+0O68pRNrQKxCiLLN3wV6OOLJeDEetFDbIZ6npl24CEJ3Sc4e38BKaPk2KkweJH1kx+lLjPWwLawDFMQeS1SwBFf630mnvWDUybJYFx19AsppukIAZbSiu0q1rNQZ7woMOraYr1cOl060+7deI0Q72K6KNKwYptJmieLgL4vLmxgARiVnJptuiTLzuir20mKrvaCr8FffPh4TICOwALpEWGhp10W8LhotIity0dmmhH2VxDlXX5bRKp+RTP3m6ae/3wgffh/tJ3RJMDxR/FqhBeAM/tzF0GNWXkmxXRwNFVzPj16UYNTyaxJdj2w4z/SDigA6HupzXYUN7Ls8qPKFxVxl37a293Wx4h4FHvwVoVHnbhbq8BA+kxYahmg61Mvdvks1wJa9oMMORbLvgySyIzUfJN/ZDflK6OgAH4ruXdHU/VZ3WPBuszodZeHyuWwFcaenZIEk+teVgcaL3T5/wcuXaYw5uQOxMtfA/ySXzLSlJrbWSe61gnKZcL9dri1L5PDYZr/Zd2Z+sg5F7IVUwgZZyavBWVvonWyWTv+QeJphl8VmMbWSCmY4JE3KDVtimGwO7iwucT2ZeDkbxK9tDtWnQDzyRyXg1Ek3FY+HVNHHSJfMMQZvWNI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+wNfTHZnAjBnQxhS7mjaHLt/PdD8KVlLny6ArdGQtAIz19o1C5W/gPPplHkJ?=
 =?us-ascii?Q?ITEdoXIEXZTTJvwKwq3pjozPJer5IFedEmjRiIw8zWp8d83f6lNHnYYibFSi?=
 =?us-ascii?Q?3TTw0wDBokko/NbgfiRtk6iFFlwEu+U6U9DUAKnujj24EhZAYwUemieEWjhm?=
 =?us-ascii?Q?tbWJHEDFR56ektEMPJB10P0xfoQaSM+Y2WeSuCfl0K2SyptY7muTKadDdBxB?=
 =?us-ascii?Q?r94NlUCrAGVX7wQqAojI9wmYrezJ8YLhtvSi1VrGrm1DxGB739anGefpYzcn?=
 =?us-ascii?Q?0aQc56ixtrWQqBJXaUpcWNhwjrEva9HyezTbeJ/nTKAoEJwFa60JjzLQZZay?=
 =?us-ascii?Q?6dqZ8MJsP/oILRwGwatyOcAljQmrv3uwaHfU+ABWNl1PfgyLGlGQoVDuaPi+?=
 =?us-ascii?Q?1gpIPfxxA8wHtDRisO9V7WdL2QmKzqzJRekISakTqCuzUNvMo3gb5VE3kUc+?=
 =?us-ascii?Q?Mis8HrlvE1d4V/YG8AjYpatEguUkNDKmvtwSC5Z2UAY7xoBNwQjg8m0fF2hi?=
 =?us-ascii?Q?UjzRDiXW5/HiyXO/5WSRhkSibY/Mj/OZW8FaNUj6hX2vpjGeg98cfG77LGZa?=
 =?us-ascii?Q?upYSM4paKtPmD6xFnigELoBCmVTp1VA33aKhFvzvVwY1QDnXBeq07MGEXPmK?=
 =?us-ascii?Q?+ToWQIZAWjq7Er5aqXxC/HJMlUdPnhJ6zclpelJZWsmXTbRQPHpDd6v3Dt5N?=
 =?us-ascii?Q?dBZfce4jm4mn0gJYFuZqZKgymIA5zsvYubK6EpfvbLiKGZLIrf68oxcJIAwE?=
 =?us-ascii?Q?IdhA+5YlOsfakIj7Uq/l/WYoT92VCqZNoPJOnX/MSkuRvVbWUCraYazSGxbW?=
 =?us-ascii?Q?slVFBWYZr1VNEZ7AiqZYccEEqcyRdekzSZ5XTjxnkfWTEuBeb+YjgskakHJg?=
 =?us-ascii?Q?DgiDOskWMbnTmVTMb5X6pq2XTu3tE7WxQO/CpGo0egwo4rHz1gOlCJ6HhSaI?=
 =?us-ascii?Q?DjqEhGBgXoAozvmh0KjBxBxwS3lU01qNOvMqKkapYgMJE3kxTLT4DNtn0yyb?=
 =?us-ascii?Q?t7xnY0pc5HG+Y8rcwIMU7gEzKPx/7RHr6SFH3Eb00tEF08qM28ImEH+kxiHe?=
 =?us-ascii?Q?X0UrlGvkYylV0k7STvT99/AleXYhko9S0AjOSq6WFhEZU62LuEY2ZPcNw8Jv?=
 =?us-ascii?Q?XrdVfxg71+oLsw7QuiZW8ldNsv3pmfLbHwR/JQKuYoh+wmCkCPDJe+cntMBw?=
 =?us-ascii?Q?0DUtBgjCLTpUr0EADQ5iKtR+3VVC9wfC+HXcJPqep67nDOQKlWD4rT3/qUku?=
 =?us-ascii?Q?bA69/IigVzlcqGUKpPEprHqGXX4kz+C5fXEKi8Ah28N6PXjcqFcuophSjXS2?=
 =?us-ascii?Q?bWpiXOOkISj4xKJL7gLA3Y+BczKtGhww615QJB/cfvi19UhiH/rHNDQZKw5I?=
 =?us-ascii?Q?Kr6YWgMGgUC0UsAMuacq/MbaJIlCCTG00Fm04f2vVXV/sFPxYQbjxEyWNG79?=
 =?us-ascii?Q?GGzygxItzhVoTgFK5OO+BkgLcT6Bcq6AQzeS2MLFmyYXa4v4Ge7sLbfnOSfO?=
 =?us-ascii?Q?keI/iHVkHl9LuLqil+pSZWDsLVk0pgztvkUwzOck/swhVzaswPpaDuUy2luX?=
 =?us-ascii?Q?J6JBMH3FIpsWlb5H5zGkxDjooeclDBaZmKKMRZ8nuSSrzBxqytIhgk7fBQCv?=
 =?us-ascii?Q?fSlxuthw4ZUhrBvN3LNilYbRfhuE6PrRp0K6uhqX6GflRm1gPOGV8U8lss2Q?=
 =?us-ascii?Q?bDDmB8DqY511DJjlRgH3oQw0EWU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6320a7d8-1ebf-413b-b55e-08df034476f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 07:34:29.7988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhAzYXktsNFcW+mIgVr2bb1s9yDnVapXqcSNhzigdDXjIXPWGsTJnBN+jF5pFo0k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Public

Ping...


-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, August 25, 2026 3:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Ghosh, Prerona <Pr=
erona.Ghosh@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is attache=
d

From: Prerona Ghosh <Prerona.Ghosh@amd.com>

DMA-buf imports are created in TTM_PL_SYSTEM and land on the VM idle list, =
so nothing binds them for a VM using user queues: amdgpu_vm_validate() and =
amdgpu_userq_bo_validate() skip idle BOs, and amdgpu_cs never runs.
AMDGPU_GEM_VA then programs PTEs without AMDGPU_PTE_VALID and the first GPU=
 access faults.

amdgpu_evf_mgr_attach_fence() is the right place to fix this, but it only v=
alidated while the eviction fence was unsignaled. At amdgpu_gem_object_open=
() time the fence is still the permanently signaled stub installed by amdgp=
u_evf_mgr_init(); a real fence only appears after amdgpu_evf_mgr_rearm().
Natively created BOs hide the bug because amdgpu_bo_create() already valida=
ted them.

Validate imported BOs even when the fence is signaled, and unwind the bo_va=
 if that fails.

v3: validate inside amdgpu_gem_object_open (Christian)
v4: fix amdgpu_evf_mgr_attach_fence itself instead (Christian)
v5: restrict the extra validation to imports so that resident and pinned
    BOs are not migrated or failed on every GEM open

Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Assisted-by: Claude:claude-opus-5.0
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  9 ++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 4c5e38dea4c2..c2f9380511a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -101,11 +101,16 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_evictio=
n_fence_mgr *evf_mgr,
        struct dma_resv *resv =3D bo->tbo.base.resv;
        int ret;

-       if (!dma_fence_is_signaled(ev_fence)) {
-
+       /*
+        * Imports are created in TTM_PL_SYSTEM and this is the only place =
a VM
+        * using user queues binds them, so validate those even when the fe=
nce
+        * is already signaled.
+        */
+       if (!dma_fence_is_signaled(ev_fence) ||
+           drm_gem_is_imported(&bo->tbo.base)) {
                amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
                ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-               if (!ret)
+               if (!ret && !dma_fence_is_signaled(ev_fence))
                        dma_resv_add_fence(resv, ev_fence,
                                           DMA_RESV_USAGE_BOOKKEEP);
        } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index f754a4a3a1c2..3118b3036564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -264,9 +264,16 @@ static int amdgpu_gem_object_open(struct drm_gem_objec=
t *obj,
        bo_va =3D amdgpu_vm_bo_find(vm, abo);
        if (!bo_va) {
                bo_va =3D amdgpu_vm_bo_add(adev, vm, abo);
+               if (!bo_va) {
+                       r =3D -ENOMEM;
+                       goto out_unlock;
+               }
+
                r =3D amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
-               if (r)
+               if (r) {
+                       amdgpu_vm_bo_del(adev, bo_va);
                        goto out_unlock;
+               }
        } else {
                ++bo_va->ref_count;
        }
--
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23796C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 09:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A771710EDAA;
	Wed,  5 Aug 2026 09:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uALA1mYQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773E610EDAA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 09:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrOWegJfdj4noPsAAwT9gsEOjqKWdcaelrbLXr00mKrTVgA6Xphxg5neg8uoAOWWm5Mv2kOw1fZICnK8JKQ65Iqy6fuN3LEkAbcTp+mw62wp+XV5GR4XvFaHVXfvj1lh9GUsjR0kJBVXc01tnmXB0FJTj4PxOifN/xQtsp+2K2o6fVsReMNj/robyi+XGWAKf7/ZHeDkNqN0SEFY/ZANwTYIojzJtGPCfkjA+bs5F6EGXKoiksWpCR3bnQDB0GfRQZq9vR8xGAxQVrWpuXzfItWXzvzZq7XYK0Um7TmGN99KbUeb66H9gXbhYiwdciTnmy1SSiYBRwSsifyLIPDY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DBpuS3TdyXOix7yiKzEC5nRUXJfPZTe0x0KUzNgSbo=;
 b=cJZN/0tVrwOSnz5dOyQw/jW0cn4DMa3Q/QHthpOq4sALdno77wh0a6BCZr0aZBMKsXbyA/rWgfCaNaGY3ukGf54kTSfHIVlc8cYliZaLzea74O/D0h4JRan1O9YwO99mG5ipRnhOGSYYUwCPGwiCg4A1CpVx9oEti68FElC3aLWMAEh+vihM6RNODib+4yGvqPB1fttggfF+Ux76iMsVBT3alCLTg5+oLku+spnFJsT2JghuROwAmcdPynZeeD0v9Ks5RhMmZxTYpGVOUCONx+aLU6msjKWylvWisajl5zTFSDjbbG6ATZvhUZJ3zJ3NG5CV922TwrsYCNqtQ9KhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DBpuS3TdyXOix7yiKzEC5nRUXJfPZTe0x0KUzNgSbo=;
 b=uALA1mYQog9Nm9vZBXRuLb54Ijll1TdcvRIPWmX0bPAYfF3AzrYqxSixcql0gzEGgVFgUAt3WXrciTtSsBdnVl9RHR/lRk8a2czfFXgFlA9NjlxB3bX5tBDMhYgdkg68BuUuizF7h/F8Q7eKvCqYI9ty2bQ8WxXobOIeHR/ZlHU=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by SJ2PR12MB8182.namprd12.prod.outlook.com
 (2603:10b6:a03:4fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 09:19:05 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 09:19:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "YuanShang Mao (River)"
 <YuanShang.Mao@amd.com>, "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, Yuansheng Mao
 <yuansheng.mao@amd.com>
Subject: RE: [PATCH 1/2] Revert "drm/amdgpu: fix aperture mapping leak"
Thread-Topic: [PATCH 1/2] Revert "drm/amdgpu: fix aperture mapping leak"
Thread-Index: AQHdJA/9MgAS5rgupUCopDtJHpqhtbaPLqkw
Date: Wed, 5 Aug 2026 09:19:05 +0000
Message-ID: <EAYPR12MB999158C445C00B9416BE85B6BDFCD32@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260804125116.2196299-1-asad.kamal@amd.com>
In-Reply-To: <20260804125116.2196299-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T09:18:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|SJ2PR12MB8182:EE_
x-ms-office365-filtering-correlation-id: 9174ecb3-5c21-4e2d-c4b9-08def2d298aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: g+EJ9yJxDGFDqTmq+EbRexsdiQi8j6PU9qTjMgdvvr5cBZMmABpmgAimiiXSA5LMeAQ9CaaDkuJTgP9+3PwsZIaz8cPIaVs6QiwYNYvLQiaxr4zdH7/T3hvx4XnAjc71UO9SgXSzSkbn0OdY7ZbMC2JK3ifJcakXawGJV/tNzHtDF7//io5MyCDZFvV9z6v0bHIvi3Aowa0MExoDzmOljTF1EymrwNuhxv+4BGOK+ZO/5CPfKNoc+BFJ/xppnBKCsCHPlr/7SaRGl9hIbZuRx2ol3iGqiegL40d517vUMncQgws5LBsexPR6vNmAYv9LjIVASbEl6rTgGwBlqbe3Ef1Re7OJQU84rG3e3M8fQ+3XmAxWIN4xr/sMiFww38CPr3cxOdYifWbV9NW6oBgfXLKE+/pYLlpdVvktFg3ndwVxTP5CS0Hbn8boF3qcr15Cs/Yb05PCq224O8i6OrzF4y/qg2mE1gIiv+EnLB3E71zYfqi/g5NAhm/C7y+9ch3PtBw5RjzVyB/mo79Yd0GCUKp1kgrR9yN42xMoABSBLzO3RildEtTqQhfECb75Y6u13v1ymZOcxHoyATqIH0VNXb8egs+MDY5f3Nsviw8/Elzrysse4QNt3IxjO3+Yr2HVaABoBEB0AgU0yANxAWWbZbf/fAEBV1N1PfUzzeRqlgKkXPCCgbAcBdA8pdO7E0WG+xoGHENJoNV81LRrFsrfrrXzcwp0+lQq1UDty8FVUVk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pS72EUWz6V7FVPmYThuPumgvGPJOWt3wcLeEgh+6LynsFJqmrXOlJ1+J1zmx?=
 =?us-ascii?Q?jwVkodOhX7TAZK01ObLYxzPxc4Xb5zqB8uK4omuL9LUrG6cTJMzCCGGY6nDi?=
 =?us-ascii?Q?fI2YNJi+dSc5JY+DqlJAUUAYrShzATCKOdL7K/g815RUEFpO0txI7EMuHbv7?=
 =?us-ascii?Q?UR8Fu76AoxZel1UIgsj5z6M0hGkMrNbsQrVSG7wcPX0XggdrU/LjTfILmOsq?=
 =?us-ascii?Q?kHrimO/1WcejtAE1K//WkVRIlvYM2nrPMb3+uKWB1omzpgwEgypavVzub9io?=
 =?us-ascii?Q?jwRXYp7Di/MtqMZ245wKmdgn6OeMek1U7fttx+RGHbi4llPiy+D1a1qoMMgb?=
 =?us-ascii?Q?rSosVZEUNLlK1bOOAoTj6ve3MHt0M1iJg3BDI93bHi1aZDvvLYd3VYp+gSM4?=
 =?us-ascii?Q?7S+/8ZnrXg4EY7c+65slk1KbsVfSrgE2Rd/ohGX8OOyf8T295wpyXzvyWnQI?=
 =?us-ascii?Q?iqxgUJ09zDzsWdPCt1uwTMEZHJSPT6dK36wM97Bl44M/qDYBvnOy6lBCnUUB?=
 =?us-ascii?Q?KVl3lp1boKxy3OrXS6fzHBkXSD8vcmZ79e//pHV1UmYZ3ycWCVG8o6SmSEZK?=
 =?us-ascii?Q?6yT1G0p0T0FjYzYka072NsYLBfKVo7KSxelOgBnV/rNLVPSJ1/MyzOtz2bMC?=
 =?us-ascii?Q?fUDWj+OcwM0MLkhaxLkAu/k/7aGdnaNLTYmcGkpkrHQk3Jq6vRdrgnEa0fq+?=
 =?us-ascii?Q?pSdc0siZNI6mrnpPliQS2PqsCtywKauuOgsd+FUnVpKeAERedYIWL2wqw75H?=
 =?us-ascii?Q?4JRsg9No8fM9Y4NqNjVyuUo5Jmj/TvTY433vwRQPyEWmX7Fs+kUvbxb9CNE/?=
 =?us-ascii?Q?CSvIVy03qMP3Jp1JtY33NNr9Na7wUojL2y6UjBAOfATjMNP3RiUVhWz661To?=
 =?us-ascii?Q?YKarBBNazOekc4SZrK6+Z88oOMDpltidcJUytJXnnfTHJhrtV1xqlysR1xQP?=
 =?us-ascii?Q?HwqMWoM9a8Pcj9Hahq45NxruUTUg/bb10/QqBfdZtKOrqo8ehZ4IIhC8w/tF?=
 =?us-ascii?Q?nUC2PI1K4AzbS4dqL8fmvCkYogqyyQ9ge4NYiItaZYvR/r7pLDQElUWQkb5R?=
 =?us-ascii?Q?UrH75JVYXlhkwuCKxKB8CvT0nH0vCQkA+SBYLoUixRJjPEYfTODrPjrZpD7Z?=
 =?us-ascii?Q?c7wmR/ASitUWWyMyQ+Zxf/wziSostSij3ix9CAlC6AxLEleWsZkyES8E3wgK?=
 =?us-ascii?Q?jsIFK+jRy2rUsxQAGO2MYjFiLcBCDaUBN3TOJrN7srLzr27SfhY8NkIJBfKO?=
 =?us-ascii?Q?ss3EraWjxxoj/e3WjEQAkcSZ05dfC7Wcor8I0vX5wQnReSlM9XfNw8C3lBEQ?=
 =?us-ascii?Q?Hi550vhnNs86wq9Eac9HBqonOoFNbZjLMKuccxRIveB6asEzY6zKXBZyM8T1?=
 =?us-ascii?Q?JGTLgkL/IB8P91o2WihE9ZBxBQptqylURH2mcVY9Esc0tE9aQRTrqlNSjv+s?=
 =?us-ascii?Q?0qiYogolFV+8IZL7tOF8h6aQJC+N+F5Vbtz+Gdz960NqH3r9Pg8j3XDod8/L?=
 =?us-ascii?Q?2VDBt9B9LdNeXgBz4ozX2CnB6zFFV1dZRO9EByK22M0HtxxjzjHlzeiFNqN1?=
 =?us-ascii?Q?892/vgLsCdVFkua1M+eE6cZeTMYX/qLWCowyg92q+wsf7cpjlQzke8XwEAnx?=
 =?us-ascii?Q?Y9SnioLBxba1RNunKnq58E3DtsxagdTa2jWxlLYtxu7sV1m1LIUkNxsbLjd9?=
 =?us-ascii?Q?wWkJKUQ7t+AS2fnIlVKQ3eMKYhkpZ/k0B8Ln34O63NYQT8Wy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9174ecb3-5c21-4e2d-c4b9-08def2d298aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 09:19:05.1544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xzx59YL9QxPPrSefS1h2/EptIWdKzdXYsS3S9T5vThdIH99SHm0P1JSe36DuRwbw+tY4cD4rpvx6JkEfdybksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

AMD General

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, August 4, 2026 8:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; YuanShang Mao (River) <Yu=
anShang.Mao@amd.com>; Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>; La=
zar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Ma,=
 Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Alexande=
r <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; =
Kamal, Asad <Asad.Kamal@amd.com>; Yuansheng Mao <yuansheng.mao@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: fix aperture mapping leak"

devres teardown is LIFO. The aperture devres node was registered after the =
DRM device node, so devres_release_all() unmaps the aperture before the DRM=
 device release callback fires amdgpu_device_fini_sw(). IP sw_fini callback=
s (e.g. vcn_v4_0_sw_fini) write to fw_shared through a pointer derived from=
 aper_base_kaddr, causing a kernel page fault on probe failure / rollback:

  BUG: unable to handle page fault ... PMD 0
  RIP: vcn_v4_0_sw_fini+0x7b/0x170 [amdgpu]
  Call Trace:
    amdgpu_device_fini_sw
    amdgpu_driver_release_kms
    devm_drm_dev_init_release
    devres_release_all

This reverts commit 3763eacdfba23f3d642dda8d23f0e261653fe7fe.

Fixes: 3763eacdfba2 ("drm/amdgpu: fix aperture mapping leak")
Reported-by: Yuansheng Mao <yuansheng.mao@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/issues/SWDEV-599369
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 34 ++++++++++++----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 638dfaf127fd..964efec0d335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4185,6 +4185,8 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_de=
vice *adev)

        iounmap(adev->rmmio);
        adev->rmmio =3D NULL;
+       if (adev->mman.aper_base_kaddr)
+               iounmap(adev->mman.aper_base_kaddr);
        adev->mman.aper_base_kaddr =3D NULL;

        /* Memory manager related */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index c4094edbdff1..0b00625603c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2139,23 +2139,17 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
        /* Change the size here instead of the init above so only lpfn is a=
ffected */
        amdgpu_ttm_disable_buffer_funcs(adev);
 #ifdef CONFIG_64BIT
-       if (adev->gmc.xgmi.connected_to_cpu) {
-               void *kaddr =3D devm_memremap(adev->dev, adev->gmc.aper_bas=
e,
-                                           adev->gmc.visible_vram_size,
-                                           MEMREMAP_WB);
-               if (IS_ERR(kaddr))
-                       return PTR_ERR(kaddr);
-               adev->mman.aper_base_kaddr =3D (__force void __iomem *)kadd=
r;
-       } else if (adev->gmc.is_app_apu) {
+#ifdef CONFIG_X86
+       if (adev->gmc.xgmi.connected_to_cpu)
+               adev->mman.aper_base_kaddr =3D ioremap_cache(adev->gmc.aper=
_base,
+                               adev->gmc.visible_vram_size);
+       else if (adev->gmc.is_app_apu)
                DRM_DEBUG_DRIVER(
                        "No need to ioremap when real vram size is 0\n");
-       } else {
-               adev->mman.aper_base_kaddr =3D devm_ioremap_wc(adev->dev,
-                                                            adev->gmc.aper=
_base,
-                                                            adev->gmc.visi=
ble_vram_size);
-               if (!adev->mman.aper_base_kaddr)
-                       return -ENOMEM;
-       }
+       else
+#endif
+               adev->mman.aper_base_kaddr =3D ioremap_wc(adev->gmc.aper_ba=
se,
+                               adev->gmc.visible_vram_size);
 #endif

        amdgpu_ttm_init_vram_resv_regions(adev);
@@ -2284,6 +2278,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)  {
+       int idx;
        if (!adev->mman.initialized)
                return;

@@ -2306,7 +2301,14 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
        amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
        amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);

-       adev->mman.aper_base_kaddr =3D NULL;
+       if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+
+               if (adev->mman.aper_base_kaddr)
+                       iounmap(adev->mman.aper_base_kaddr);
+               adev->mman.aper_base_kaddr =3D NULL;
+
+               drm_dev_exit(idx);
+       }

        if (!adev->gmc.is_app_apu)
                amdgpu_vram_mgr_fini(adev);
--
2.46.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A440C282C6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 06:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC1F10E0BD;
	Tue,  4 Mar 2025 06:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fx48X1bw";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFC510E0BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 06:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og78Xou97frK7RLbmiAc55zLmuOmqSAnVC9hX9Nynuqo80M2n+TNyMRPx9jfpR0E82aAn7mpt63poJDvCUK8O0dNJm3LMLZBp7+lOULQCdvA0JPkiahUvDweJcXPJvMNxozebG3rPFk7nPCapiDT5fryE71EUCmNYmif65tqHohVpOE9PJixtuXyDA+DbV/raKOY3hyKLSGvze8wACcFRT10JVBzQVGyTwfY7pCXtTt6AfhBG57T6u5SrZY7ajSzZY7Mc3TJZwq9gX0rsZ9/91rBUtyCbgIWaGJXEn0xykXtSjJxa5d3pOUEf5d+dvtjQeROpbrG0O6odviAB7yKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8ZvKfciE9lPD2K8GV0JG3YnVVw4jBcdL+wg7YxGPRg=;
 b=Fkw7A5yGs1Qu5WwAbcYvxBmoCDwsW8+uxpYFasKZILWpYFJoOr8QxtBPjEfauYsomA2slcEeR7XoYAGTD8YgtWBYFJdXemfdBl15gwtMVTn3md3wgpMixdUf4fzybZidADI1a+qyPtlQRxvCX8P6pyoID+53dd2av98SCf20I1lzmu9vtCnSVTyAAY/2WjpnMm5UtKj2J8WsQcPQrghuwpSDZP5toEXDBj6Jx/mOeZqcFyTJJ0X3TLSR2fkzD2f97STYcMxYnARKnnLhmei2ku//LcopWI1KzLvHnhaRNiCi86BaeCH3S/A/6H23yIqiIx/KvEcgG3UPonOlug+ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8ZvKfciE9lPD2K8GV0JG3YnVVw4jBcdL+wg7YxGPRg=;
 b=Fx48X1bwKUBpNNVTWWnskmu0+plHleznHACELOq9WjnRIMf7BC8mhMPG72tY1SdioD4lTZsuAdxPJ9NgLgIAgBtxJ2wvhT0VmltBbc9r5eTDDgbDpzmbqSwbnV+QfWbCRXBNgUilhb4ayE6pDJeSIJYiA0m/fk9SIGSmfz5c9sI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 06:48:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 06:48:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH V6 2/3] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
Thread-Topic: [PATCH V6 2/3] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
Thread-Index: AQHbictnqxDLwx5U9kCX8611N9GDBbNijx6A
Date: Tue, 4 Mar 2025 06:48:02 +0000
Message-ID: <DM4PR12MB51522CEE2B70D716B71C6A7DE3C82@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250228102711.832036-1-jesse.zhang@amd.com>
 <20250228102711.832036-2-jesse.zhang@amd.com>
In-Reply-To: <20250228102711.832036-2-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=11f8c3ea-26c0-48e6-a48f-cac4ea31ae11;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-04T06:47:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY5PR12MB6526:EE_
x-ms-office365-filtering-correlation-id: 8163fdb5-e62b-4cdf-d55c-08dd5ae882c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2hcdg1M9WZr4Ilm95tlUVoSyP4H1rqmF04p1UeAlDl0zqp+hRLYe3+P73XhL?=
 =?us-ascii?Q?2ZlFSZCIh23wnxwCHbc/r4EIcxxvvCz5ZTTpHCDF2PfPIQtM1YFGAyZAaRwm?=
 =?us-ascii?Q?shFIWccY/T2YsPMWyePICwX5qqG5bd4LpusIf2x5irNDwv9ndHgfHUbAnd2+?=
 =?us-ascii?Q?D02RSd/whnZVYwkJEqxf9jscIfb4sofTBC81CRwgpQjqCXlCdfZnsD1FEyEp?=
 =?us-ascii?Q?qO4H+dhMr/2Um5dbSaSvapG5VM2Qso2Z7boH/6P+HTtk/5Z+m7XJ6fMohFsx?=
 =?us-ascii?Q?KMkQsgeJWdITPmz5Da89CjWpDrdsaXaTB/LvirKribge9yAAFX6V/UuFl4wo?=
 =?us-ascii?Q?GIYzK3KuN4VRe52OOZx8eSTUtKfbqQVuKmTcCFSycussM/tI0wV//W/wHjL1?=
 =?us-ascii?Q?nQHWVEuwpz0G+W/FgJjdxKolmFuYXAJPPwW9XNP4fNR2M5MnXDXNOO7NSDwD?=
 =?us-ascii?Q?yznm/8xL1A4zh0NNQVITzX3HGbpmCcXpP8GZdeudilehsv2ZegjI1RH8nstQ?=
 =?us-ascii?Q?T9gXQHuGmkvQgOGf1/x0Dp1bvl7t6GG00WygKIE5Tojw9fKSSzP5ngucTMxm?=
 =?us-ascii?Q?cnNjhTkQ+hAcSagfPJFWZKfAW6+xkaoF8nz2ltPI4Zn1ljIbARg2lktdGO81?=
 =?us-ascii?Q?KAscM1/eRF6sw9svYfcVLFQaQCHrZ/gtEl40f9GwSHupyEmyoCmArtju4xOZ?=
 =?us-ascii?Q?VAdBnKfmUUEtgsXdj2VyXWWLbJJ5Hn/QP0NejnN6sqdFoX/F2vuE/l+QAkXC?=
 =?us-ascii?Q?ZevOXqM0CSC4pIKt/rI4BWZwYjnklJGGRwZaXke1Mp6mLjlvUrucwDfd3dT6?=
 =?us-ascii?Q?oplQUS1nYehrzLrv/UUUetOw7xIOP4UfbXzUAXlrFiXpG0iBGabeI1aOsCQE?=
 =?us-ascii?Q?yndVDX/sGEnA7iJPZ//mPRJAlB2qcpYn4zNbAKX4NVyMx8uV+HhoQY//aX/o?=
 =?us-ascii?Q?3znAFm8gwPxZGsYPu5lGy7BV540z1BBnk3+PTQVcrn86J7EcjXS+C5pDdpzi?=
 =?us-ascii?Q?mV31qr0OULmSGFE1gqWUxbHivW7OXEGIj0dvvVXsJq7+WUE6OXWUXdx8z6iJ?=
 =?us-ascii?Q?LekdM0qvLA8MDxb+zwRengVN9bE2XS3iCs03xDGcaGnLed6HFXdMBpI4ZWO/?=
 =?us-ascii?Q?hqTzDZShP2sFuEjYQp922YDaZHT6kAp7ueurhFimqb7FRl5PYmpb4WyPsarx?=
 =?us-ascii?Q?VN9aiCrLAbMAUJZhZJlmxhUE9S7FwHiW0WA2ylJdcsAYMErVQlWe0lUGwtk3?=
 =?us-ascii?Q?uC4yctV4hRDMkghRMrxSEUWP+Er+7YQi7vVrMImiFRmaWQqY9IBcAW2L11rq?=
 =?us-ascii?Q?tQ+hyFbEfIv4iX7Pg150Bz0yfmKeLWqYApU8k+4c9XV+t3hmOKM8/YSTj//r?=
 =?us-ascii?Q?8KdioIGOOc9FbuMVtrijIuHYNB+KXo9TOuxbDEiX9ErfDYkSdRlia7xDrcs2?=
 =?us-ascii?Q?vSqrDBXD69Wfgn1S7lvVjmnvh8O+1g1k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w/PSdwQQVur2AdGiSyH7Yr11RZe5bOEktM9DnAnKqe5aP8qqf2f6px7xlndv?=
 =?us-ascii?Q?oHTSbNADqeYaO0VlGD+RLmMB545CFU5sFISmHi6t2wnaHsFp0V09qlJdsMG1?=
 =?us-ascii?Q?8mvxdYmcx/zXu7R2BrHU125G83w4EVWEK5FQQn9shJvPX9W0cHvxSzks1Xwd?=
 =?us-ascii?Q?OUHzbn2CbG712fnUvfPkjVBUTlkH9AbdO5CGQLVc9lDsMpptPuFl6gvs2NRz?=
 =?us-ascii?Q?MbU/xqdZsYlsp6sdqVNU41GlwRPfHHxy1InaaoT2yPXAMliKVILfwO/CXD5G?=
 =?us-ascii?Q?IqBQKNvhtgeQxkQTHBa/76U3+qoLwu7zE93psup6uUOzAw+egeVvg3XcUm7z?=
 =?us-ascii?Q?wJdPjxV7e02vXXnP3HYo/ied5jyMtBJJ4ejHa2DOE/Let8PJwjxxyj7ANBmz?=
 =?us-ascii?Q?3AHz2wll0NXVYaRTWhRu3mf9AKLxT80Pu7Yszc7WV7P70yxjelkCnyPxHqpJ?=
 =?us-ascii?Q?sRBpUmu0kn5UZe/zy/1Yj6pEJQM4MEvEvm1Vnno6+4QD99mmpbqJDguLVYRN?=
 =?us-ascii?Q?dXrxcml7P+fmmcoNEWnLFoDX/TUTeJ3URPENrd/JalVQV+gnNvHgJoJAMADb?=
 =?us-ascii?Q?OHoC+XmPcQyh/HuyeMXDQcbgNkHV9PkzBFpf9poEwkVzpMbwELgOMpdt/kbg?=
 =?us-ascii?Q?M6qY0nkFUbhzxwCOxW2KvUFralPD/HJI6vlZO5QWr4ApVgYKRRXSU2ZodFuZ?=
 =?us-ascii?Q?ooiDooVNwpFbzuMWgWIOKbk4Q1SmQ8Q2RkSCTSJchJzV1i6wGPUd2kTMi9F7?=
 =?us-ascii?Q?QPwQfhtu7P/IUAYMZKcD6qpGG4eBYFRwU5a/nw/xSjdrpS+Cv9ii1MBLX8S9?=
 =?us-ascii?Q?uc35llqGzqBa4o8MztdMHHjpOGHvya31EZJyxThTsEdTqgVI8arAUK1FOiwU?=
 =?us-ascii?Q?gMDjqcukJZ6dxTHkITB1m9OQPQCy8TO3u3OIQUQsKKloNPKGcjUZXK6/mnIL?=
 =?us-ascii?Q?hWJxvBh8shOWHc9CkTs7Wnu+YmNx+wPMIVr3vL0iO4NxQCeSyaQL7OSzfnaF?=
 =?us-ascii?Q?r9E4B/WoNABoi5E6sciSIAI5bINsVJXjgBnzy6vnExuH6+zzSA1PE+1diw/D?=
 =?us-ascii?Q?KhleFmWhxiPpeepUsmpZfWIPPyJ4JmJBw0RFyx5XV7yMbV+bU8m+bHL7QN4O?=
 =?us-ascii?Q?Nngk/jwIKL4cjY/SKLr/BMjcxyiDvNOXBg9qO94XAY5IeqkF5J10yGkph70R?=
 =?us-ascii?Q?B4HkS/Iw0XEXop+ksZWhLQu954/J4heqh1x4wdixerlYUQAy8TacuWPE4pVM?=
 =?us-ascii?Q?JcEx3igZfA+j93PZHMmqXad5JG4omktVh3UyZVxFU8eiiloGVF2fQBc5b7iA?=
 =?us-ascii?Q?zAIgpLCfQN5svaT21NakcgTKIBw0fcJeZAyNfC6GT9QocR0TafDP2YogA8+5?=
 =?us-ascii?Q?oTLPfGsjpg56d8f6czO8M7MzGgrdy1ASaqvRLwjVoTb+lbYkI8i/Kfs6jGVj?=
 =?us-ascii?Q?pF0JcMxvGiywX73XuIeoS8KTkvyOtrUY+0wZcITAO09uRnDkEb4uc7fSwE3y?=
 =?us-ascii?Q?z0Y6suz8AeRNnl5mmk81AOc6G5XTUsRr/CQ7fADET051c2wqZsTafbR9vODA?=
 =?us-ascii?Q?uabnCKt/bO+nEAAuVkw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8163fdb5-e62b-4cdf-d55c-08dd5ae882c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 06:48:02.9082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jhnwDvQSz45kIR3Ga1gKaApM7RHNYsZPhcwQ3w3mTm3ziKAItVEq1xHbNBrNPd+ePyn1UanI50uvt3KyYUEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping on this series?

-----Original Message-----
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Friday, February 28, 2025 6:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, Jiadong <Jiad=
ong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie=
) <Jesse.Zhang@amd.com>
Subject: [PATCH V6 2/3] drm/amdgpu: Optimize VM invalidation engine allocat=
ion and synchronize GPU TLB flush

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

- Modify the VM invalidation engine allocation logic to handle SDMA page ri=
ngs.
  SDMA page rings now share the VM invalidation engine with SDMA gfx rings =
instead of
  allocating a separate engine. This change ensures efficient resource mana=
gement and
  avoids the issue of insufficient VM invalidation engines.

- Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
  Use spin_lock and spin_unlock to ensure thread safety and prevent race co=
nditions
  during TLB flush operations. This improves the stability and reliability =
of the driver,
  especially in multi-threaded environments.

 v2: replace the sdma ring check with a function `amdgpu_sdma_is_page_queue=
`  to check if a ring is an SDMA page queue.(Lijo)

 v3: Add GC version check, only enabled on GC9.4.3/9.4.4/9.5.0
 v4: Fix code style and add more detailed description (Christian)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 12 ++++++++++++  drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sdma.c | 25 +++++++++++++++++++++++-  drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 4eefa17fa39b..aad3c5ea8557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -602,8 +602,20 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_devic=
e *adev)
                        return -EINVAL;
                }

+       if (amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
+               /* SDMA has a special packet which allows it to use the sam=
e
+                * invalidation engine for all the rings in one instance.
+                * Therefore, we do not allocate a separate VM invalidation=
 engine
+                * for SDMA page rings. Instead, they share the VM invalida=
tion
+                * engine with the SDMA gfx ring. This change ensures effic=
ient
+                * resource management and avoids the issue of insufficient=
 VM
+                * invalidation engines.
+                */
+               ring->vm_inv_eng =3D inv_eng - 1;
+       } else {
                ring->vm_inv_eng =3D inv_eng - 1;
                vm_inv_engs[vmhub] &=3D ~(1 << ring->vm_inv_eng);
+       }

                dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n=
",
                         ring->name, ring->vm_inv_eng, ring->vm_hub); diff =
--git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_sdma.c
index 42a7b86e41c3..9b958d6202bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -462,6 +462,29 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_d=
evice *adev)
        }
 }

+/**
+* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that
+shares a VM invalidation engine
+* @adev: Pointer to the AMDGPU device structure
+* @ring: Pointer to the ring structure to check
+*
+* This function checks if the given ring is an SDMA ring that shares a VM =
invalidation engine.
+* It returns true if the ring is such an SDMA ring, false otherwise.
+*/
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct
+amdgpu_ring *ring) {
+       int i =3D ring->me;
+
+       if (!adev->sdma.has_page_queue || i >=3D adev->sdma.num_instances)
+               return false;
+
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))
+               return (ring =3D=3D &adev->sdma.instance[i].ring);
+       else
+               return false;
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post=
_reset functions @@ -503,7 +526,7 @@ int amdgpu_sdma_reset_engine(struct am=
dgpu_device *adev, uint32_t instance_id, b  {
        struct sdma_on_reset_funcs *funcs;
        int ret =3D 0;
-       struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instance=
[instance_id];;
+       struct amdgpu_sdma_instance *sdma_instance =3D
+&adev->sdma.instance[instance_id];
        struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
        struct amdgpu_ring *page_ring =3D &sdma_instance->page;
        bool gfx_sched_stopped =3D false, page_sched_stopped =3D false; dif=
f --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu_sdma.h
index 965169320065..1fa2049da6c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)=
;  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);  i=
nt amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);  void amd=
gpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct
+amdgpu_ring *ring);
 #endif
--
2.25.1


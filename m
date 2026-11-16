Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BB606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Fke5r9K4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C8110E061;
	Mon, 16 Nov 2026 04:54:16 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A324710E061
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 04:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/qyu7CFOKBfhYcF/zww1ZCqSSkmfCu3oNhRnF/10OH7RunS7JJPSkMhuSv9WH/ZwOIAwe2G6oiWMeKbqmhRZ9CaFnKfqWs0j6gz+n1ZLDuo2jAwcQQrOQi82sMJjUL6ZG5VSxaeTYkY+ovi6TuoAEb8TpP5+VljDkLowkZcyrGSbw0aZM195lKKkYOepjza7b+RO2VZ0ca5C5KmCcszgNz0rH8SZTJhFIs7gFgiEZrkpR3d8Wp8uErglPxjRhNuodxbmVpeQTczAYwtYmf+Oc/dvX2EFb4dVSCkJ9QTMP867alVCY04qEnyd6NaLpFwV9FYtdOMFH7V/cEOPnvJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFinreiCI3zHZysMglVJsWy8uH8ZD+pU96cqvuYSpEE=;
 b=mIioL0g0sQBOVYbmZBJo2xAo2IuEz6Ed7B7x4nY6xQ0K31EBZbUEe1+OcrLVBLJEkIjb74b0zoFly8jh4bvhgj56dHKgAY0X6IfFma9cqcKwgtFLXQGgM0/jwAmanbW4K6qkZmPt+Qbwa2W/Ou92bBpRrzaklQV5seZT4RflP0LbSXHKrWBRUItbStvOpVEroo6cqZNu+ldV5yACf4TxQSJSHe5asznCKRArJ0mIdtULnP8NIVsMw2BeukQ6g70JazcbY5ut08JzeJzFBUETTzSp1JKUbp/nZEfu/KezZboKaIoE8AGWuNaCm1W6mq5dF03E5bUrkswi/BPqUCdWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFinreiCI3zHZysMglVJsWy8uH8ZD+pU96cqvuYSpEE=;
 b=Fke5r9K4p/4GILjOhfFEuh1vQwaGEBOZEVFWkkDLGZFYlOVVX022l+3R2TE01bYUwAa0ZcWa3vqS6apcmv9qcYY6o9ohA7tDc6U01Bap+fQUGaqO1f91t+3z5E6mbua2Lxn2O9mV0+DHVIZyPdz/KSVa9/A3qYvuKXvuAmQB9zU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 04:54:06 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 04:54:05 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: look up the L2 trap handler mappings by GPU
 page
Thread-Topic: [PATCH] drm/amdgpu: look up the L2 trap handler mappings by GPU
 page
Thread-Index: AQHddXnTUcB335liH0CLnoJY96O9grcwIJ8Q
Date: Mon, 16 Nov 2026 04:54:05 +0000
Message-ID: <DM4PR12MB515258450A52AC3AB5300C24E37C2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261116032304.2023851-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261116032304.2023851-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T04:48:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB7367:EE_
x-ms-office365-filtering-correlation-id: e6a8443a-30e5-4133-8a61-08df439da44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: zplkH2FGeepqAzyemeQYUhAFAnmdXOyH3GhNKpNoYF1zBa09MxBo1IXo4zaMJTneurAcfP0oYrmDWdknmoqRFE5C2h4AEIXtFqlj0dessENlPeOKHY8PHs/KahjZlodaAUD+tooruzJl+a9HOHF1ESqbUDW14W5KJSQeF3/+gI5qWDO4Mt8uRLD8fKeVNbmvibyFJt+zh7Ss5t504tH9xrb0WDu8AOL9T6RtJaQCgocWIByVEASi7xDEly38NBwFQ+bXf8omq+leCc/fFj2upndYmOnlUUl/TjVjZw2Gdmq9rCNU/Ihiv9FtiAMWNXmooVNWEoTo5VMutZOxDJUmNYjLycXZLHpuH90ivgj7m5DXnVG6eZX+p5gO4xTttLC0ciIcz+cOtMo/L9C3WHIY7o6fWWsseTDZO7ItwjS/aTTy21bCv+f6Di4sTaAM3plNNY7/t0NlyuR6RtCrYMnSSFuZklIhk+RpX0+6xMS9+jRqp3bJjPAZjSfUMXx4A9HjwX5I6uEIMutVNSXlVPP4YPl9fQDOw2f0hlcMPRI263rUkx+w8on04kYhmpZVxFyYoJEeAPtAmV7zfNwIS5j+oD12ijIPP/zIVUdS89bppDPxXDvXwaXnhqeGiBewbgjbbm5t4BRJLKY8ORhV9iAGihuPeMSVG8kXorRO9HdqDdG28VbHw64dlbjKCMopDNCHNWtBJxvbRIwzjobq+bV4a3zOKRgmDZdawyEIO2mcJFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bquHuu4uPUg1N12e8s8sLlON3hOdOpQPx10mkSQKjnR5jUjiUr7Jn5eYQpjb?=
 =?us-ascii?Q?DQND9eHRdtOcx1N6+vdquQUz14jW1L1EO2Baz1ghDzPpsUC8Ir0x7+3Fs+D9?=
 =?us-ascii?Q?NpVcIE4/MkjT/irz5kMa27ZTZYtxpL+nK0zvUW3863u+w3iOAUoLsrLoAqod?=
 =?us-ascii?Q?W+zm+r4eTiEPuBkRm4NzKBOEJZpe5MZWETgVM+IFb/rYgJ0iKfEZGqfiZUQM?=
 =?us-ascii?Q?iQR9nU6MdLE8N/ihSTX/bm4Ybe2Xi235Dc9vj+NPNiZJfjkq60eT7bW2Zayb?=
 =?us-ascii?Q?rgGbeCK2MwPFoxJAV9cYd3Tt2CQ+9QFjc+Hu/njvpK12uNBUqn+pWL80gou3?=
 =?us-ascii?Q?razwEsrlPJlVk5FcV0RN/3v0FCEFck+4bFWw8+lrKkYjlM4K1l+ZsQDPnUHx?=
 =?us-ascii?Q?nNb2HvtqTbKz/ySCL25aPTcs+FEy1oNQfifOSjjTepTiDTsmRnrhKpqiyKs2?=
 =?us-ascii?Q?+1HKp7RH3N/lm0THKh/k1XUsDqcqqioul3dTGnQIoR+WnOOFowZ5+B24ieum?=
 =?us-ascii?Q?gcU5QZulXgtNWU+RlHZrcivI7NXkWG5pYgCgBINSOlgBVaA9e1gqEEH290aI?=
 =?us-ascii?Q?VHTL6LuoHbFcOZb0NoEtvtWRUBeGU1ijoWXRYE8oCZcakjylOAuWvkXAnJbb?=
 =?us-ascii?Q?rwMGwQ61KSlw3nLP7AookcdYhcGrlbmIY7uLnfCCG2tGVPJzUvmZ+G/kjhM3?=
 =?us-ascii?Q?JMiVx39n0Sh0RVpdHvqKnv55VquTex4oGhOpdnrrRQznmh284yKHUJyRzzl1?=
 =?us-ascii?Q?VF4njQLQASlBd7rPrAOOwEnsUSp9iRF7JxC/J4tTLaQ9RX8ddDQi/nxM5fmu?=
 =?us-ascii?Q?DfSNRsI9Jm+zczUEdSNK9fAdIyZl/Al5bqn/WVQWQvlmN5prCxld8aDQJ7JS?=
 =?us-ascii?Q?yDhvqs9n4ctwerjIZ/zd8TGh1Wbz/v/3MnRi0bH8rT1we/M309q0Hy5ICCFN?=
 =?us-ascii?Q?phIoBH1dd24SRSegiUnJyeDTe8YYYUSnACMyc8ILJgSPUw6AclScNyV19Dyb?=
 =?us-ascii?Q?5ogyCE7AVyyNi2vdO/2cm3uPp17jCOx0wdE/qgQfMSJpg4W2ssPPeNjcWQUB?=
 =?us-ascii?Q?76P7g2stn4V4/6od1GyYI+/7ZAQaujvnLnsLOnohhLM39JSqnWe5HltHbJ9e?=
 =?us-ascii?Q?cYLBUVt9R0H2c8H9NO/hbvAPJBz7+pGclM9B3Zb9nWdo19fTAOIuj6Da52zT?=
 =?us-ascii?Q?K8IzI6HeFYZmvhvy7RZqmVYWi22iCrhI+/bZDvjVJ50626btvjvwYLeDBtBk?=
 =?us-ascii?Q?mnqBqLJN/G77Q00sY3AEyOeexmD4EHfO4aq13Q+b8ju28GjnrYduu1LKKZvs?=
 =?us-ascii?Q?pw71HLpxckEPn+5GdJ6xHtVpQ/ApblJaN5JY7FPUcKDaadQ25g2Z8csArHeo?=
 =?us-ascii?Q?WG6vMTNrjlIRh6rAC1wcGDtOSSxSOKLYDOVXxWOfFR6k0Qg6AnURzyQxrlJU?=
 =?us-ascii?Q?F66NbMFkxIPLpyOz8MiTuXq0eKYNcQ9fmoaP6oubb5Le042jg0bCjXheKbdI?=
 =?us-ascii?Q?liQTJJRrts26Zf09i0oHH+/ScxujwfwLRzzKOe32pALXPBOhFutXLo0pT4m9?=
 =?us-ascii?Q?fsjMBn5U5o+BgHUEVaKvlLQUjMEfXcei3jO+68HReQ6A8dHGoT/HbI0nTTTg?=
 =?us-ascii?Q?BnoxalFYASeU1XUitUIokkowUtN24ZmkmLiQGsUAZI/GLLyZod8sKVSToC0L?=
 =?us-ascii?Q?tQl5CGuL3hTPab/ODjL+vxk76HS7l/lCF4QhbGkuPPFso9GR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a8443a-30e5-4133-8a61-08df439da44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 04:54:05.4740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NL4u3iToqU+p8SfXBED//sgi7MHV2tkVLxNGUro/Awzwv/Ial7ZoiLrZh9WMkOnGHVIrTReH0vYT6xIoXoAn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

drop this patch. It is only needed on the amd-unified-interface branch, whi=
ch is missing a prerequisite change; the latest amd-staging-drm-next does n=
ot need it.


> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, November 16, 2026 11:23 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: look up the L2 trap handler mappings by GPU
> page
>
> amdgpu_trap_validate_user_addr() passes the byte address of the second
> level TBA and TMA to amdgpu_vm_bo_lookup_mapping(), but the VM
> mappings are indexed by GPU page number, like every other caller of it do=
es
> and like the range check right after it assumes. The lookup never finds t=
he
> mapping, so SET_L2_TRAP fails with -EINVAL for any valid TBA/TMA.
>
> On navi48 with the VM ioctl SET_L2_TRAP added, the IGT slth-* tests map t=
he
> TBA at 0x100000000 and the lookup of 0x100000000 returns NULL, while
> the mapping is at page 0x100000. With the page number the lookup finds th=
e
> mapping and slth-{gfx,comp}-kq-vgpr-proof, slth-gfx-umq-vgpr-proof and
> slth-comp-kq-returnproof pass.
>
> Look the mapping up by page number.
>
> CC:Alexander.Deucher@amd.com
> CC:Christian Koenig <christian.koenig@amd.com> CC:Lijo Lazar
> <lijo.lazar@amd.com> CC:Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com>
>
> Fixes: 1a6f95d4a5d7 ("drm/amdgpu: Add second-level trap handler
> infrastructure")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 3660f94a0929..52e4d30e63fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -622,17 +622,14 @@ static int amdgpu_trap_validate_user_addr(struct
> amdgpu_device *adev,
>       if (check_add_overflow(start, (u64)usr_addr->size - 1, &end))
>               return -EINVAL;
>
> -     /*
> -      * amdgpu_vm_bo_lookup_mapping() expects a GPU VA,
> -      * not a page-shifted address.
> -      */
> -     va_map =3D amdgpu_vm_bo_lookup_mapping(vm, start);
> -     if (!va_map)
> -             return -EINVAL;
> -
>       addr =3D start >> AMDGPU_GPU_PAGE_SHIFT;
>       last =3D end >> AMDGPU_GPU_PAGE_SHIFT;
>
> +     /* The VM mappings are indexed by GPU page number */
> +     va_map =3D amdgpu_vm_bo_lookup_mapping(vm, addr);
> +     if (!va_map)
> +             return -EINVAL;
> +
>       if (addr < va_map->start || last > va_map->last)
>               return -EINVAL;
>
> --
> 2.50.1


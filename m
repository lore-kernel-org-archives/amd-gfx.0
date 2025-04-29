Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAF7C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 08:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE08A10E2FD;
	Tue, 29 Apr 2025 08:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="evYOA78t";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B99410E2FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 08:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0iIDKErmIZ4kbcmWq4quK15UAuYb/Cn0mteawlKg6+rKQuJDwF/EUVgc/Tw1a/aMRKqNp9xdG4PSiRPT4PUmN0gPk3IDpic7kG3y3XyXuuLomwEdQtf5M+mQcjJ0XINcXPLEGzCtyRnNl3cgql/PE01xECLWy49QAYgNAh1GQaYWTZs6Ns1xwloALpJbeDoGANtrdYtN+6yBtNqt6uF5wVSEKqNOqTzhqf9HXAMzVthb/XxmUzugcLHNYtGbQuDVI6nVv4CcFFpNzLCrNiLOHQGVc3skseFuDJmVcbOibiQf54sbJTkhCrZNOTq/Po+lJeIzBU1a+kb2fnAarsWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrms6CqKlXT8se2NAPHNaEIlZa5U7JQv8njBU5BQkHg=;
 b=avsrSLwrcQChvIsfb+XTiHwggVhYXW6jJ/v+MjJClE6BwyEyMiWl4qbCrVYq5nIndzW1ZU5oQR/EPU/f/GpCtkbdwvQnnOx8UdhAHOdpOgeBACasfwFInchZVXdjOPxTcvAoWcFnMo8Sp5X4BA/RG+fxCPROmKYwU39SK4ONP12Fpl2XP9NIQ+y7NDvaDKMmSi7y7qwGSPkv568vG4c/GsE0+KMdzfrFeNWNiCtw7Zs4COUAFMNysteg86rVeTj4s2M6EJIhiwdJ45AQHa9z9mNqj7wh3o50JB/OKzl8pXv7/qREsNXSe+e3wRwu3qoafH5jhPeo1zS+IOO6VjViEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrms6CqKlXT8se2NAPHNaEIlZa5U7JQv8njBU5BQkHg=;
 b=evYOA78t6M+EfrXxCuo8fBE4pgs6s4S8gNMvbKvqSQ/kf4CP730is1GpDisLbXRjFk2VE6lrKAb2rNAt1DNe5SWesNY7kHxU5IqHo429WkaqKDz5B9/1aVF3BQEQlp1+cEslYgRW1JL80jslEh51o935OVCIMcDyNiOAFxTrFos=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 08:52:49 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 08:52:49 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Topic: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Index: AQHbuNSUufXe4GuQCEK2IbT3YFaDF7O6VhMA
Date: Tue, 29 Apr 2025 08:52:48 +0000
Message-ID: <PH7PR12MB8796DF080D6D991A7CC37ABBB0802@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250429070121.299873-1-ganglxie@amd.com>
In-Reply-To: <20250429070121.299873-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=277a55aa-6944-400b-8930-8ac0888aa38b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T08:51:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB7600:EE_
x-ms-office365-filtering-correlation-id: 349b0623-edd9-4442-2f63-08dd86fb37f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kuDqJDDNMXHs9i1ggd4+7waujGIwbS4zdtCau9ZI6/YKu5RrUx57X5Xv1pQb?=
 =?us-ascii?Q?N9y8kYxCORoJjDTz0DOGJfzgKm1R+LxvUqLsE8qXi5VRUrDquRGDaOJD7IO1?=
 =?us-ascii?Q?CCjxPD/aY85yVaehCFOTWKKVN6TW0J4pz2gMzvLz4QEwyok/EXTUcWZwaMgA?=
 =?us-ascii?Q?OTdbySlzPrai6QjTkWhZ2gW5waQsLqC+EssnjRzXI9ThRxB0QgEcFKFQsq+E?=
 =?us-ascii?Q?1GSKj07pVaFmnxsWsbkf6sCxbGavLOJvYHSwsN9V2PdwROKdoVe4lIE7Y5fs?=
 =?us-ascii?Q?m9E2WtrLHZ54CPTUmiUbkXh/4JZ+jjgpdgbaOJQ0nFjmYy0hyxd8WAejCndo?=
 =?us-ascii?Q?+dtrq48vQcrc4qwn8gQl2m+fhepl3KWKF5Dq3GxMrtLROAcKci2GV7IcegvI?=
 =?us-ascii?Q?8TReHxbDCM1f1cPsEcU3JaBLcxAoCrjwzfqZ/+zN3IY5rHr+QTCN19gKH1Ft?=
 =?us-ascii?Q?i+8jhX2wbndz8nNj4JRdx2NxcL2dWNzYGsRt474tQtcKwpIO/djAyN1pPFa3?=
 =?us-ascii?Q?D6FxXFtY+ktzrC7AN8mI/LAW0X7VO3xNbWnY0RYLOEz6pOvtxmGaaIxgsr1C?=
 =?us-ascii?Q?X3crmpIXo/BLOS9gMEcZGxi+sZWHzuDg+t5vwdxzUq3tYrtMm49OCKr9nJ6V?=
 =?us-ascii?Q?I8FBs3bmaTE15Vb4fzC1UtjQvI0quvDOZYoSOK8AIkMifGaYvIjqslCqjyax?=
 =?us-ascii?Q?y6C7sTX1rMiN3K+p8s+260dlAxFupcgtJemJcxz4yVuPwgv7My/0V+nxb418?=
 =?us-ascii?Q?8wl9y7TqlL1opPNmK3/L5//MVh04oQjnUxue3V7RvukiL9JEm+Jgz1zOULog?=
 =?us-ascii?Q?7jdrJ2MrF0cn2qHRARUAr3avGbDiyffuZ58XRsSaXhONQdLEC3zJ63GiZEZt?=
 =?us-ascii?Q?sbmc5LEd3eDz1DTtMZJk4j1pHts6WFzAUH27C7kQsh+gSGP8akjFQwuR56Iy?=
 =?us-ascii?Q?k8RpmZD3HYIYKZc43thyC7v/hBtP3ivenYf+9cJ321rFxm4w7cGK33iJnU03?=
 =?us-ascii?Q?NPuJpGm3VYQEDmxgjiiCtWV9crBh1g4cbwMHFLQW4S0/RJU/Ai1MhdZXzbbw?=
 =?us-ascii?Q?8D/uIqXBtHs40Y2VnWv2AN3IMKi0BA6TDOiTpVWnE84Eiux7Qdd8RmcLKL6C?=
 =?us-ascii?Q?W+/Xzw7thR870aDu8iOH13io3gJuwUDP6ajkJ2qfwq0WemkVOQg4rG6gOo1e?=
 =?us-ascii?Q?ipBWmaBJwPHVbFXMhQixCye9EpPHwe7ictz1lMqxNzsMW1fnOIk5ANI/vie3?=
 =?us-ascii?Q?DlQR7KyZRo/V99hMF5unnFncv7+K9wA7mVVI/U1xD/TME7qUHJG8mycXLPeA?=
 =?us-ascii?Q?GVgvgYA1B2LJbDgBtw0iHRhmck4ZPyTArgDe0hV+RI+XKV0R0PkO/iUltFG3?=
 =?us-ascii?Q?6c9X7Rlt+v9C9jzZUBPhQg69Vf8ZfB6y8ZEhaIVlq/+4IxvCHG19y1t4bn5W?=
 =?us-ascii?Q?virA2tcWn4uWETYBT6gRgzeEtbBpvk+kph7xQvAsrIoHSphWNHvWTg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pi+dY80/DruMS/rKCyWyXe0prrIpOAGa4FuX8/Q7QUHtO2WwUGOIU0/s4bva?=
 =?us-ascii?Q?7c7jDVUCTm8JauQ2cwqcid/EFMJYLHQAsRhBH4LR1Fd0ER1ZIB83Zw2Ejrsx?=
 =?us-ascii?Q?CCnYT2xihi6f334NbFRw+n7kE7zMlTMqx9ig4Fbf+6EWVv0Iy4FDnoRwq6la?=
 =?us-ascii?Q?KDv/PDxjayg7auNAC+ohpD9ycl9EzPciZxM3r0ALKT82qQJ19Dv4drKw9w6Q?=
 =?us-ascii?Q?FrBcfS1WukxQ8AkN/7DCIkM60fSc6WBYH0stTgM/uF1KYnK1MKs+BTfkdDUG?=
 =?us-ascii?Q?ab/4JlgA9GHHZo04446jQe8YfgO7/5CsTAv/4LJEv1MRxUMBsuvR8Of+mCa8?=
 =?us-ascii?Q?slhYClWQYwjwxh8Hg36uEbAxTReHqP7fDjyfAQWR4QA80hvGGN/zBfSgzbmc?=
 =?us-ascii?Q?tn4W6nN7EocQ7Zi+q2zVoiT6YlFZbNqieTprG0a1vLU7/FpeyZeQtHCedIlv?=
 =?us-ascii?Q?0DG0eNqs6lppuHt3tas6jXt9Tbups/f3Q0CCAKtgsXafSOeOcFjnIWzyjiJY?=
 =?us-ascii?Q?w0RnDKVyRv6pXTAhObwlCtD8CAplJnGIkiM3+cWprTatq3jLFmSZluepuMAF?=
 =?us-ascii?Q?l7HLihgrlpOU59B2epduRBPamzb9BN7c+R0Qln7TiiP66v+z/1aaSmouRoro?=
 =?us-ascii?Q?5TJ6PIs922M12/jLUC0knpfr9juA+hjaX5+63eJOL+sgXDGG65LXKFCB9K4O?=
 =?us-ascii?Q?xuKiaXVqQLyG9pM2POAx3TpcvGGSzKaHwDpvuC7NgiiFDUo4svkMgnHabuq7?=
 =?us-ascii?Q?e8sIhk6TE0g0qtWzC+q2MgG2JXIyZP0EoK2bIVt3LGh+LdMHdeNUSNbDTpHB?=
 =?us-ascii?Q?u/evQVliyN1Vlb9574ap0odqgz0sOxGQCNBeomHKmtAivQY6lil0D5UqaosL?=
 =?us-ascii?Q?8ONsFenglociZr28B+FtO5LEz+/A+GaSmvbHZbui9f6fkB+4dH75w2vt9KQr?=
 =?us-ascii?Q?UoHaAunGiEyuaNNSjpmvpGjNzFBP/v2fhlLTW5g72MwZYa2sHR2I7pNnMe0G?=
 =?us-ascii?Q?m0AFuqmRyo/Gd1p02PXvH9m8yt4NuF9bl8a3/07iGEN/eLHtGo2wRLtISzBv?=
 =?us-ascii?Q?d6Jci171FgCO/lsPxbIKRM1NR0AOWWnsWmTTcGEq3iPdOFcxXp7FHyStNodM?=
 =?us-ascii?Q?vNaCJ+iPQm5PUkmyL97Uuzpw5TGvA/98jYTspIcwjaljTQPK5nmZs+lgUd97?=
 =?us-ascii?Q?duPvcgMwwgPHY4K78oL8hr+NHKnwyv91+HUoX4OVMXc6dGSnX4GjErLHhWfI?=
 =?us-ascii?Q?Y6Udlgw7IXBciUIrMoNpI0wKveiJeou/HVeNNFmByLHOsOMz0AzvBNNw4t5F?=
 =?us-ascii?Q?/QS4IgIIdHzzO9zka58m4Pk4g9neiODUUAEOWJ0EnwPA8asVSLEF0MSeUJIx?=
 =?us-ascii?Q?rY8JCWjuKLFFTnEKMEGtqbT67Bg378VumI4gPzEMipbGbx5A9J/M7lIc6sT1?=
 =?us-ascii?Q?i0l9it0YHqqZOCojStWRU1klYwNof3aknw7zrcGn+3gEyuwJs1nv4OcQcVHy?=
 =?us-ascii?Q?RF/Lf5e/uGoGLhV/CKzahC6T6lx78ov6TxToEqgzYKwyq49C9g+yEb0PBOrL?=
 =?us-ascii?Q?OuswaAFuabePvLuZ8Tk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349b0623-edd9-4442-2f63-08dd86fb37f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 08:52:48.9493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ke3RfMwCp59FRPAJivgIgfQiEvGHOsYxAbb6uOnnETtCmUWir+qLjD1m6HeVX3eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, April 29, 2025 3:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] Add support for leagcy records in eeprom format V3
>
> After eeprom records format upgrades to V3, records that have 'address =
=3D=3D 0' should
> be supported in NPS1
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 73 ++++++++++++++++---------
>  1 file changed, 48 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e85143acf3a2..4f4e12452ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2881,6 +2881,17 @@ static int __amdgpu_ras_convert_rec_from_rom(struc=
t
> amdgpu_device *adev,
>       save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
>       bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
>
> +     /* if address=3D=3D 0, the rec must be a PA rec under NPS1 */
> +     if (bps->address =3D=3D 0) {
> +             if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE) {
> +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> +                             bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> +                             return -EINVAL;
> +                     goto out;
> +             } else {
> +                     return -EOPNOTSUPP;
> +             }
> +     }

[Tao] better to add an empty line here.

>       if (save_nps =3D=3D nps) {

[Tao] is possible that both "bps->address =3D=3D 0" and "(save_nps =3D=3D n=
ps " are true?

>               if (amdgpu_umc_pages_in_a_row(adev, err_data,
>                               bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT)) @@ -2889,6 +2900,8 @@ static int
> __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
>               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
>                       return -EINVAL;
>       }
> +
> +out:
>       return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
>                                                                       ade=
v-
> >umc.retire_unit);
>  }
> @@ -2903,7 +2916,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
>                       &adev->psp.ras_context.ras->eeprom_control;
>       enum amdgpu_memory_partition nps =3D
> AMDGPU_NPS1_PARTITION_MODE;
>       int ret =3D 0;
> -     uint32_t i;
> +     uint32_t i =3D 0;
>
>       if (!con || !con->eh_data || !bps || pages <=3D 0)
>               return 0;
> @@ -2924,28 +2937,31 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>       mutex_lock(&con->recovery_lock);
>
>       if (from_rom) {
> -             for (i =3D 0; i < pages; i++) {
> -                     if (control->ras_num_recs - i >=3D adev->umc.retire=
_unit) {
> -                             if ((bps[i].address =3D=3D bps[i + 1].addre=
ss) &&
> -                                 (bps[i].mem_channel =3D=3D bps[i + 1].m=
em_channel)) {
> -                                     //deal with retire_unit records a t=
ime
> -                                     ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> -                                                                     &bp=
s[i],
> &err_data, nps);
> -                                     if (ret)
> -                                             goto free;
> -                                     i +=3D (adev->umc.retire_unit - 1);
> +             /* there is no pa recs in V3, so skip pa recs processing */
> +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                     for (i =3D 0; i < pages; i++) {
> +                             if (control->ras_num_recs - i >=3D adev->um=
c.retire_unit)
> {
> +                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> +                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> +                                             /* deal with retire_unit re=
cords a time */
> +                                             ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> +                                                                        =
     &bps[i],
> &err_data, nps);
> +                                             if (ret)
> +                                                     control->ras_num_ba=
d_pages -
> =3D adev->umc.retire_unit;
> +                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                                     } else {
> +                                             break;
> +                                     }
>                               } else {
>                                       break;
>                               }
> -                     } else {
> -                             break;
>                       }
>               }
>               for (; i < pages; i++) {
>                       ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
>                               &bps[i], &err_data, nps);
>                       if (ret)
> -                             goto free;
> +                             control->ras_num_bad_pages -=3D adev-
> >umc.retire_unit;
>               }
>       } else {
>               ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages); @=
@ -
> 3040,21 +3056,28 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>               dev_err(adev->dev, "Failed to load EEPROM table records!");
>       } else {
>               if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> -                     for (i =3D 0; i < control->ras_num_recs; i++) {
> -                             if ((control->ras_num_recs - i) >=3D adev-
> >umc.retire_unit) {
> -                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> -                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> -                                             control->ras_num_pa_recs +=
=3D adev-
> >umc.retire_unit;
> -                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                     /*In V3, there is no pa recs, and some cases(when
> address=3D=3D0) may be parsed
> +                     as pa recs, so add verion check to avoid it.
> +                     */
> +                     if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                             for (i =3D 0; i < control->ras_num_recs; i+=
+) {
> +                                     if ((control->ras_num_recs - i) >=
=3D adev-
> >umc.retire_unit) {
> +                                             if ((bps[i].address =3D=3D =
bps[i +
> 1].address) &&
> +                                                     (bps[i].mem_channel=
 =3D=3D bps[i +
> 1].mem_channel)) {
> +                                                     control->ras_num_pa=
_recs +=3D
> adev->umc.retire_unit;
> +                                                     i +=3D (adev->umc.r=
etire_unit - 1);
> +                                             } else {
> +                                                     control->ras_num_mc=
a_recs +=3D
> +                                                                        =
     (control-
> >ras_num_recs - i);
> +                                                     break;
> +                                             }
>                                       } else {
> -                                             control->ras_num_mca_recs +=
=3D
> -                                                                     (co=
ntrol-
> >ras_num_recs - i);
> +                                             control->ras_num_mca_recs +=
=3D
> (control->ras_num_recs - i);
>                                               break;
>                                       }
> -                             } else {
> -                                     control->ras_num_mca_recs +=3D (con=
trol-
> >ras_num_recs - i);
> -                                     break;
>                               }
> +                     } else {
> +                             control->ras_num_mca_recs =3D control-
> >ras_num_recs;
>                       }
>               }
>
> --
> 2.34.1


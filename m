Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15527C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 08:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B480010E185;
	Thu, 20 Feb 2025 08:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyFa8m6n";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D28610E185
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 08:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKSTguCUtO22wh2FP5OkhaLOyE3H74nzPHe51m8ZTNkokB4YqsTA5LkooVJWidGDXxcNCnkPJUY0KxPH7Qx4sqhseHK8VBYA4UYMo5MkZ6I+hfVZBS82AWyHrL8xrhTUkp7rOMjz5XW6HK1/+hOGqg+wzqP7aClYBjs5deVy0h+kQpT2Fc4Eh/w8o5kXrRm52e3kZH3TFkOaTeg8hWWcia+JiGuqSapAGWTPSWgWMbiy4POyqZ9R3aCOp+AjkWifRyOblvNr/MwZ3ahZiwZPn8V/LXHy1gYnSFmbGw/iPJc8mb3DV1TaysJR3uGwhT7oKY9LrLSC1T7LnO4RDF6JhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKZ1We1Tt/iASZByonvkKqqNRVqcVla/DTtwye1B1UY=;
 b=rATxJ6UBx64Aw9DWKu4Isd2ezXyzZxzJubVJKwLafSmeb7g7v1q7x2vtyS8oO4zlmj1VTZEcH/MGReWRiLz6vfX5tSaszKowJ8nqTulFBktuTzmrSZPKifLIX2JPV8TJP0+oGhkioLmAPLMutvuZVX3BXM5x0cYuj2ZxOxjj6eTcx+kCo6eioPM4/0ZPOKCII8dyuAQjBnpKFRXZQCqYOY2o1BEZcZfL33mOHl7uO1n1v7WmlTQFTofk7aS0udo1t4iowe3kxTVNwKNDFL+tZY738D9eVplfioaqGcmhWe8llq894CytHZAKaf/5aRJPb5oH1aLkMmO9wiUvxp6UOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKZ1We1Tt/iASZByonvkKqqNRVqcVla/DTtwye1B1UY=;
 b=zyFa8m6n9Th0h02WNN5+ontli9Z9dK99VB6IedI5JYl2NyWLRDcYgGeKr3nOKyKXRSKtSwoHLPwXnrrDpmnG8Ios+5LYYkdhnXmhONJyD3hKjsH5HOz0N7SUG40oxzDuPLt1aGb5jhp8/SsemPiTC9RPcE3biP5+GlNIMJp6FEY=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.24; Thu, 20 Feb
 2025 08:54:53 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 08:54:53 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, 
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Topic: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Index: AQHbg3HLQOmSBLptC0qImCz3hbml2rNP4o4w
Date: Thu, 20 Feb 2025 08:54:53 +0000
Message-ID: <CH3PR12MB807403AB9842D5F5297C14F4F6C42@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20250220083053.3834177-1-jesse.zhang@amd.com>
 <20250220083053.3834177-2-jesse.zhang@amd.com>
In-Reply-To: <20250220083053.3834177-2-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=af18c5b4-b05b-4fdb-b1b4-24c8617cb755;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T08:52:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SN7PR12MB7933:EE_
x-ms-office365-filtering-correlation-id: 92d7e9ad-f439-4c3a-7bfd-08dd518c3ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+k8468YddWDngoA8nsl2mkqXLd/ul6zFTLgbIABGvL8PFRWDsofGRuKER46D?=
 =?us-ascii?Q?kkRm9OEdiy48mhavmZVYgtQsRDEnxO8qoPdRcyz9pQA+WdLlje4QdOsYFjRT?=
 =?us-ascii?Q?sBmCuYwkpIfKcs/y+Y7slH+tocByPsE9wgsQaeNaET+8LmTN01Xv4jDTNY0Q?=
 =?us-ascii?Q?DUxTc7wSKc0/KtVpameNrGCWXwO31e1xPwPNM2wPcSLM1ai0Peera7AV3Ipo?=
 =?us-ascii?Q?RAQEKadgiqofekNjikpL/JO2BtxbaeBUSER45WTDuViIrQ32nB74zn9b5OeG?=
 =?us-ascii?Q?DAAi0wWPkSmbQyZwdCRDDq6bzaUG24voQ/BnxoT2LrqK/jNiojK50+gQlfeZ?=
 =?us-ascii?Q?JuyAMUypnooqPVc8IrC6qCF80iIKU1z6gTz8NN22zRA1SReXNLJp1LrSXedr?=
 =?us-ascii?Q?95b2RyywyKb/N4UY2mtQkzNBsqAQQvIKIBFbvdxvIF8vZSdGpZt2aQ4QujNj?=
 =?us-ascii?Q?BXQGiYqBs8P2iA1mkIGW8AXG76QCnWIIWYLM60LbM1icz7TSzzHQ+KyRhMyt?=
 =?us-ascii?Q?ChqtNK5Ic+mdDKpxvx2m2aMxXhec7tyoG64emXrFrUVppbXb7+ol+o0QIKNa?=
 =?us-ascii?Q?7Oi9Fib21hCU/LLnlxOGn3fDAAL6I3CecvdoBmDFXnO2lWkNW8zDQe3Ypk0B?=
 =?us-ascii?Q?BqBZ411JBv0k4GiBjvdgC2BjibhPVBbSBT4CkH5Z/nxaxnrP4kJagzRdFxiV?=
 =?us-ascii?Q?srMZrYgpOMni6yzGUWRJWiSKmoFNtOcY+jCGidtqtFdfJDMrGrb7YiWQ5qwN?=
 =?us-ascii?Q?BZ3Jm31TZgDH2aXgD69pTVxo7/i1f4Ip7CeYQzg+O6tXL70jZ6stIE9SyQJi?=
 =?us-ascii?Q?3C3DeH0rSUI+KLlyg+QrwGfGzGs7D0UcRv3qW8m7Twri30DO4zxByY6D+M0S?=
 =?us-ascii?Q?Y8dcv3rTpb4G6wO8NLEgOUuD/NvT+T2lNUReluvbFQRn/f2MgQM47jYFrsJ5?=
 =?us-ascii?Q?PaBiF32qimnxyNFshPBW6nlpS1OT53s39qYUDVuiJ9SC5uPwwDRL6HpkncBh?=
 =?us-ascii?Q?gDpA/qKtaDdL2fjZx3X+iH/pAwMot5SqWugps8dsFjnuIc0vy2B0NjspweFP?=
 =?us-ascii?Q?cSp7o8Qe8mGR9SWK27TH5eV4BJST21Wn8fsonPrw8HBvm+spiCP92j2GiZFP?=
 =?us-ascii?Q?pe3GFc5r3irxlFuyyqXbvnoIOk1dlFPu8V+u1kNOSW8fyhufJED9+YWJ/ILW?=
 =?us-ascii?Q?7BiRmkoTYxRNy9J1uuRHKeFI0qOhxsM9va+PN7z09FOGwe2eXNbk4+CUZqsW?=
 =?us-ascii?Q?zQeGM5Jrte424oa9AqV9MXt2C56TXHvPjB3yBuMooEx4NDhPyqyB2coU3oB+?=
 =?us-ascii?Q?lV39F37o1rzbNO2AxkirQXVzCnItQbJewzyrcXr3cfc1SqOk85QH0fXqHSgn?=
 =?us-ascii?Q?jEj6TxKgMsmNGfaL5V+YkDJxM+cz4ai35etGE7tkc8j1blsk3QTSn8AMX/2G?=
 =?us-ascii?Q?XWo+xgvZQE6vWKnuGejqOKGzWKx9+5DE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wci4wzqHCstohDIAPFNf4QSDzkL22v5DCTOszZQ7TJ/6gF+3rtb2DKStXUG9?=
 =?us-ascii?Q?f9BDL/DHedzfhBseodJ9r9bFtLJHcCkBN2mc7P+jhbUBnDY835EEHGbowSsV?=
 =?us-ascii?Q?DDIpxmKN0Z6yiF0EClKKTjOUyFoy7ssH9LNB4KU+0LJnFg2BwfR6L2XvtXwf?=
 =?us-ascii?Q?IVUfaM6CV0cO2fiPY8hVjp6Bh33iIiWv4RSRpqeZ7hfXQW299hQWVV8hJgus?=
 =?us-ascii?Q?OwuRIYJ4JizrEYrQSCVahHeIXgWAJgo0AgRbTg6fJrvBH1fBATqsgWhFFDF6?=
 =?us-ascii?Q?L3Cbmi9ErcadAgK/ALW6ocgIUPoOeGuBlWa5B+MyZ32R3j3MMvns44GOuFZ2?=
 =?us-ascii?Q?qsN2aRoJOa35BcSyZ1X1hfAiDkFDUdQoMuCFtA40ukrwy3Uwh4h50TiE7Ojm?=
 =?us-ascii?Q?P2kENeFi6Y3Nvr0iNU8wsXKebaIEnFIS83JGp9zml6bFxU0Fahsrt23/Mp76?=
 =?us-ascii?Q?uu62JUq9MuKLAFXIEYWr39xFXt69cr2B/LanHCW9wZ4Q9tBFCgKLNqTyZB+4?=
 =?us-ascii?Q?k7imPksHAypHZeVRvJ+9iuVnWQ2KnB4eiASDl5rUJu/eCzykazbqM1i8KunP?=
 =?us-ascii?Q?WFqPim8l+1Vtg2WRtpTsFxjLD2Tg1EfaEH6X1Y7pykdPRZJ2Un1EiwK90yZI?=
 =?us-ascii?Q?ge5eAqnesT5Q97UoW2hWR4/0SIY0YCZn3ITtgpn+48gswZcFKEloczvc+ZBw?=
 =?us-ascii?Q?+DxV2kup3jD7TTfLQwRSCIDLpRdvVq0pZuhHd0IfiMsAObnVvEILUWS60EIK?=
 =?us-ascii?Q?FVQT9xMbtZxNKWsTyzmBUy+5dfa4ZW8vz29v5p8sOvF1Bk4u4jQamPW1WX4r?=
 =?us-ascii?Q?rs1nWU3D+QDjz+G0oIYfm9N0fcj45Vbo9vzq4rpMW1+5IOZ/r+tBjnZZLMN2?=
 =?us-ascii?Q?p94wgb7uZGmaGJVF0UgaV/410hlBbU0+nTEikZ86T12uv0o/a8Li8dVCi2nv?=
 =?us-ascii?Q?B68i4nHnE84GFp72L3VFeMmt854VTtSrvWC4fnNmtgoBQL++IubgyTb5cYWb?=
 =?us-ascii?Q?EYYfA9eB7SPSBi5xDCxxhfez/jkBoGPh5D1Re0AYPVSPjZaF1U/pE6Yn4Fls?=
 =?us-ascii?Q?FUZLx94OfMiCvGO3P9ADmutTAbCNUyNgRfbMwus8uUAeOIp/iUswCDVVjyqb?=
 =?us-ascii?Q?6s6jpZ9scTSdXID/q8LoDkAwbuAFmyaS5PKOfJymkgu0Zi/GvR6TXV2toRiS?=
 =?us-ascii?Q?b6olU5EuDw7JcTEnIZvlGqNBwzaPckpe8jZa0rBocHP0aSpv0Hnr92hdW/Z/?=
 =?us-ascii?Q?Mqq3037Npsm+oVPa8zOoOg4CNVgvSHpD7M5+VGvrVJyE5uUSNMWpu4g+1eHl?=
 =?us-ascii?Q?60plF49LUyN8HSr4wzETIxRjQIoH0YURwAFEwW8ulgcZLRi6mTMLGrSp/PWi?=
 =?us-ascii?Q?esqUY12u/6kANC3gkzCAY8Zd2CFOeCoOPfxSiF3peJOFZ2HvLTEGyoEORFRP?=
 =?us-ascii?Q?7+7HDIMp9NU0AUe/EcHIbS8q65YHj4MrpslOVSt9tKMM+5LeCxcLrEkcGglg?=
 =?us-ascii?Q?wr7QUFuafCI1VrgLyd2hAhws8xMopKDE8KO8iPm0E/ZMUKL4VoHOgwUv3E4x?=
 =?us-ascii?Q?u4pVlv7cyVRXd01/Yhk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d7e9ad-f439-4c3a-7bfd-08dd518c3ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:54:53.1405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzRWRzef7WGjuRU2lZ61Se6ecDPLcwXgPD35Vpyp9epVJRdz9Ju3B8MxnSDkhWiAk9yqxaCSFd0hJo0JefatRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
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

Hi Jesse,

> -----Original Message-----
> From: jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Thursday, February 20, 2025 4:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Jiadong
> <Jiadong.Zhu@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> - Modify the `sdma_v4_4_2_sw_init` function to conditionally enable
> per-queue reset support.
> - For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firm=
ware
> version is at least 0xb0 and PMFW supports queue reset.
> - Add a TODO comment for future support of per-queue reset for IP version
> 9.4.5.
>
> This change ensures that per-queue reset is only enabled when the MEC and
> PMFW support it.
>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9925b183c07f..0e004b156e95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1458,9 +1458,23 @@ static int sdma_v4_4_2_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> -     /* TODO: Add queue reset mask when FW fully supports it */
>       adev->sdma.supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].rin=
g);
> +     /*
> +      * the user queue relies on MEC fw and pmfw when the sdma queue do
> reset.
> +      * it needs to check both of them at here to skip old mec and pmfw.
> +      */
> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +     case IP_VERSION(9, 4, 3):
> +     case IP_VERSION(9, 4, 4):
> +             if ((adev->gfx.mec_fw_version >=3D 0xb0) &&
> amdgpu_dpm_reset_sdma_is_supported(adev))
> +                     adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;

Do you want to check the adev->gfx.compute_supported_reset here or a typo?

Tim

> +             break;
> +     case IP_VERSION(9, 4, 5):
> +             /*TODO: enable the queue reset flag until fw supported */
> +     default:
> +             break;
> +     }
>
>       if (amdgpu_sdma_ras_sw_init(adev)) {
>               dev_err(adev->dev, "fail to initialize sdma ras block\n");
> --
> 2.25.1


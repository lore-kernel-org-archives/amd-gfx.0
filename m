Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF56C6FA8B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 07:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B6F10E5B2;
	Thu, 22 Sep 2022 07:14:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B8B10E5B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 07:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps1rxX5onFlXvjRM/m8khco6L94CkA/OlY+q/vU7HULRdQtp9XpGc1Z84dH68CR0vvvZ3aVdnRWan8Ik3TlBlppoiq0ugga7abXNOrGVgYBImOpEj8NaWBZX6S1hIzXS34JP+FoNzdeXBeNOy+cwdkHsAD9xXM/u2ikYyRYvztKZnJ9CqF2rg8ez5f/MiUB3OR579/5Qn7/zv0GFW5ESfjuZPqJycOum/ZqYv3TveoW1q/X3b6j0I9ezqecyWj0OuWuDRD71xeS6pZd0bKV9u6QAshsR1pxKzPsA4ywtgiELUvEoEiPl6BcMF5kFq1UCWhUIw8esfYYdZCQsf3C5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LPnTcCH68MqHKlFw/TIiFrZcjDaUdzUaeWtUOBEOoo=;
 b=jQ2rFlbbp25zANWNb4Entz8wvwvDjdedizw9jkIJXfCAOfy+paqOTJLfiKqEwjkoDxJcV4TV69pakZPuWxH/SBKIcmWQsqmVpJpie2rboCgk5JvanRqQ5JVHp/fU2hEBwZ3SSqtGiCsd+/0Pvpt8fTCqEylOdGlscDbFFW1MRopkZD8/8vXVs1BOiygo4iXz/WdFTMSHa+niN9+TwHmV36V7zVgaCYtG23O8c3TgBKt5X0lZdI1c3cOulZ82e+k0GVOkFoc6Cr1eBFkuxPws+oMmZtB6gnTl3Ar49HsvGv+VjZDDiqohz7fWmRW5+C7M4Wc0FQCOs5VeRHsR7u470A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LPnTcCH68MqHKlFw/TIiFrZcjDaUdzUaeWtUOBEOoo=;
 b=H5BgRK8negVXIIetAmzVEvNsUgn4YZPcAHbyStThM+buphlc/TxU8qEgmR1sBlQBwOtZ0WwQlWECIAFE4dN75cZabR4dNa25fa+yULHsSqr5AF3kHQ1x9wxEQoZrrk6NEZI4AYLJU1QJ6Bx33ty3YcRnj1+1y67rJ1pdbzsBkNw=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Thu, 22 Sep
 2022 07:14:35 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::14ef:f2ad:a4e3:ebb0]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::14ef:f2ad:a4e3:ebb0%6]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 07:14:34 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Xiao, Shane" <shane.xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous
 pages under xen dom0
Thread-Topic: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous
 pages under xen dom0
Thread-Index: AQHYzlKeE6EF9LbXIkGO8rALO3F78a3rCSCA
Date: Thu, 22 Sep 2022 07:14:34 +0000
Message-ID: <BL1PR12MB52374B22F1F63E91E7F4B47AF04E9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220922071133.927436-1-shane.xiao@amd.com>
In-Reply-To: <20220922071133.927436-1-shane.xiao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-22T07:14:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e2b41e70-7a13-4ddd-94a2-364d31b723d9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|MW4PR12MB7165:EE_
x-ms-office365-filtering-correlation-id: 6e18208d-3bf3-4703-4409-08da9c6a1a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APJrnqgCZH8d40r2R96Oao6uUB8BL40KSn4nBG1IdZR48ihzUdktulRXXbk8dQaVviAy0P4MBqArLbvTq8m9tXTaXR+pCelNTdULhIw/t3Hjb+Avwt9Q9owtkuMhhhojIFaLlG+rugD0vy7NM/8KmEnB8bCD9y0P/89qdnV80FLrG5sMI695049R3IYJ5XWiFFQjWoGrpBeD+GcdLOf7l288InjZRAxiPxkL9epLZ0G/8KmFQOEi7hMNJg9fqRDQpmUEA4gpvlMIUnrP7f6W5iw8sBI0VLqLEZ975zSB4dX5824EqvRarLxHvU3gph4ccwchaSrPCHbFtGcREYGQ8lvceqS3e83SIc5s17hOgYOXG+UCHM1ENZKG/ooba03ojbCX5lKF8SD0nHJ5q8Zib5skbgjMEL67NYVsp0myJwCHDcBy4p0cAAZs4GFS8L0i1q9I1S0OLcmMfdLvLyUxMKl6rKv0CleBkkB1rTE8FrZomttoatMPFvL+abZUnhhTyCH7xZldRMf27LlD3u/JYXX23za0QKSo6C+ncFKgirDMfO66o1YMiAZs7ipzqbyAjy+UuYquOFHbQCNet3A3iPMk2TBLLMZAvqRXi4jMufaBWbF4MxvhfIZAvMK8wSsqbI5ZSHFEEBP5oHci3NfepzGG/RZenm8RHm+bCf9a+cIdpI1e3wFgcUGwO5Fbr8vr7fJpF2PviBYqiXBrKAp1mzTFTXieF5hJxCsE8MXm+Pc95wa6k2M0Ed/k3nmX0UyLGF9fWBi7iafSE4+iYBSG3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(38100700002)(52536014)(122000001)(55016003)(478600001)(33656002)(5660300002)(38070700005)(316002)(110136005)(86362001)(66476007)(8936002)(4326008)(64756008)(76116006)(66446008)(66946007)(2906002)(8676002)(41300700001)(7696005)(66556008)(83380400001)(26005)(9686003)(6506007)(53546011)(186003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oqN+agc78q7uH/ZdyzKVxlY+NX6TyUjw8rkxZkM20xOPOZRGcDvkFtfKGWz3?=
 =?us-ascii?Q?p+sqUzcHU4JnlJZQ9mK1TyzY+7mERYmMuYX8knoF2OVCKe/NzZCd7PC5B2i+?=
 =?us-ascii?Q?Hsfb6cCWzQ07aQs20lKBdLSkqPd8PWM5GMAfcb/wMYE7ICNkKx5nk5J1tQPQ?=
 =?us-ascii?Q?F5ByLTmzVN6LnBcrlzI0mycCw4HMQN/yCX0zosC/Na+GOsjoPeUX/6HC4GtL?=
 =?us-ascii?Q?fRPszBkFHF4/r0pcB3UhbP8yy4ITZnVuuYDq0oIcf7BlDDyK5PEAq1euQiMw?=
 =?us-ascii?Q?3I6xMmoC1iDZluwONM7WJVmXmFAusaW+UPoPvTIHOAV0rRa62WNoItuucmDm?=
 =?us-ascii?Q?/P496mjpuwqz1dc6anwoFpG5lUb7vtUz/PaZ9HEU1Zx7pi4GpqaTFdU2D2Px?=
 =?us-ascii?Q?6tWKas2fzA05pId/sr+nKMQk08bqC7iIFsFfx3y7KVmj+Y7pbiIPVFYePgY+?=
 =?us-ascii?Q?KxNbA3i264fWmOn6qVJ2Ky//x3AwNxYLjpicCYoaExmj/YZ7REG0hYf5O/kD?=
 =?us-ascii?Q?QSavL90jLG93n2GpGUlTHlXvL0IgqZ0bKHjF3U0uIcFGIlGEbJkarLkymd7O?=
 =?us-ascii?Q?VCZsVugTNV7Ix1ySjic1heGgAviU79V4HecmETDBhSsUSUX5Y5+q3zdCJnj8?=
 =?us-ascii?Q?BUfOqLuv0HfbEjAC72fP1SU9f8MVEE5DGGi/LfhdC8GQfSxs1sTpSbtwKQDj?=
 =?us-ascii?Q?IzQRy59K9vbp93gcVTRrhk59q6BzrwdnAWda0LucD8LPlZLU6y3kpr6tfw0N?=
 =?us-ascii?Q?mqskAU5/u/3u33wIezcICvu43CzluS9guaK7JX4GMY9VD0u0si8sByREKrcm?=
 =?us-ascii?Q?6agFwFuJKx8YDmzRT5kwZ2bIiWVBbh8gXPZkFxVm3PNNKr/D19+d8qtW1kam?=
 =?us-ascii?Q?k7ueLJkCV/zlTGFacL7sj1H+3mB3ht6sGeRKwCh7eAfWur/WosPL7SoxEudb?=
 =?us-ascii?Q?Zpoz01IAyLmD0LgqtwgqntyI7idsh7RETDYXiRfn7dqgi3QyMa6a54Vf40FY?=
 =?us-ascii?Q?Clb9B65lNlcFJaqCmFhei2Oj2sJII6reIZpOju3yKO14OG0GRCFHwLpB4RBc?=
 =?us-ascii?Q?yBs+2PYc5pzwDiH+nNvAgOU9q02rTgdVKeG1Mh5sEoNafKHNulQOL8g7BV7O?=
 =?us-ascii?Q?TciJJdM79xtybY5/MH9LPTvMV7DZcMHvg+b3opCaAFQHbCcLk8KPctu1HPFC?=
 =?us-ascii?Q?3gKzknAIcCAYYBlJuk7Y41GhLqnbjqpBdSQ/Pg61Vh0mYEgAwHI9pdn5NQH9?=
 =?us-ascii?Q?xi7v3VJCUsw0DkPJQQr6lfoPbsgFCNI2ts74HvMBTqjbx4kqXtL1iWZr41ZP?=
 =?us-ascii?Q?c563l+5ruA6dDg9AymcTTcIQnKU+LfOoI4V2oo9g4e8z9wAIp8n8ykFWn0qi?=
 =?us-ascii?Q?clgUoZl+jx3Q20+fJ/VSItAq4X3QYM+6KqdgJkV9Mv5BH8v1bBJpFvLboIre?=
 =?us-ascii?Q?OSDyy0BvoUvg8CSQym12Ww1jYXCkKbZwUiP1E6y6dlMC73rSoL4pbu+Lrx86?=
 =?us-ascii?Q?USKcjKXNIoBVIEGWT+pfqmiYyylu/rNLkf0hB2ZLQa6uuiG9vVf59QSnf6GC?=
 =?us-ascii?Q?av8WcDYHDg5V4uPPuyw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e18208d-3bf3-4703-4409-08da9c6a1a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 07:14:34.8114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGlIsfio5Wm12IaM4rzD6P/m5qjQiXQYD3e2BulD6jibJbv0KVirNOGxsJ0/o+Ub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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
Cc: "Xiao, Shane" <shane.xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shane Xiao
> Sent: Thursday, September 22, 2022 3:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Xiao, Shane <shane.xiao@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous
> pages under xen dom0
>=20
> [Why]
> sg_alloc_table_from_pages alloc too large continuous PFN pages under xen
> dom0.
> However, xen should check continuous MFN pages in
> range_straddles_page_boundary.
> When range_straddles_page_boundary return false, some cases fall back
> into swiotlb process and the continuous allocable page is not enough.
>=20
> [How]
> In fact, xen swiotlb set max_segment default value as UINT_MAX and
> xen_swiotlb_init_early already change the value to PAGE_SIZE under xen
> dom0.
> However amdgpu driver doesn't use the value, which may cause issue such
> as swiotlb buffer full. Add amd_sg_segment_size according to iommu settin=
g,
> the details are as follows:
> 	iommu setting		|	amd_sg_segment_size
> -------------------------------------------------------------------------=
------
> 	iommu=3Don		|	UINT_MAX
>     iommu=3Doff && swiotlb on	|	IO_TLB_DEFAULT_SIZE(64M)
> 	xen_swiotlb on		|	PAGE_SIZE(4K)
> -------------------------------------------------------------------------=
------
>=20
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22
> ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 134575a3893c..d081fcd22d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -80,6 +80,23 @@ static int amdgpu_ttm_init_on_chip(struct
> amdgpu_device *adev,
>  				  false, size_in_page);
>  }
>=20
> +static inline unsigned int amdgpu_sg_segment_size(void) {
> +	unsigned int size =3D swiotlb_max_segment();
> +
> +	/* size=3D0 when amd iommu enabled */
> +	if (size =3D=3D 0)
> +		size =3D UINT_MAX;
> +
> +	size =3D rounddown(size, PAGE_SIZE);
> +	/* swiotlb_max_segment_size can return 1 byte when it means one
> page. */
> +	if (size < PAGE_SIZE)
> +		size =3D PAGE_SIZE;
> +
> +	return size;
> +}
> +
> +
>  /**
>   * amdgpu_evict_flags - Compute placement flags
>   *
> @@ -760,9 +777,10 @@ static int amdgpu_ttm_tt_pin_userptr(struct
> ttm_device *bdev,
>  	int r;
>=20
>  	/* Allocate an SG array and squash pages into it */
> -	r =3D sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages,
> 0,
> -				      (u64)ttm->num_pages << PAGE_SHIFT,
> +	r =3D sg_alloc_table_from_pages_segment(ttm->sg, ttm->pages, ttm-
> >num_pages, 0,
> +				      (u64)ttm->num_pages << PAGE_SHIFT,
> amdgpu_sg_segment_size(),
>  				      GFP_KERNEL);
> +
>  	if (r)
>  		goto release_sg;
>=20
> --
> 2.25.1

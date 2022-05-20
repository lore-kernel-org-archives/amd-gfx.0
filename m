Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9982EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 17:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4394A10F31A;
	Fri, 20 May 2022 17:56:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9372510F31A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 17:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ety5IwG+zjOQ8B33EKGVrUK/h4xEWkdj0vuCitCtb96wF3dtrgWSbedtDF6jaXhpXTtQtrq7Ym2WuKsBNh666OfLm/3QdQPC5e6CBIhb4OggZJr73E/Le0BvNTPiLBG1M7n0n8dWN5I9T2c3kOd908gbeOo7B1jpwrkoqGudfVtbDZH5HR+WmZfSEmPQbxeZT/r0afBkN6MwFvV/T/haBzPQFwImTqREPw1eLAWqzm4ACvIiiGs1y3+XIw3H0DlKrkHa9MDDYgiVUyvEAp+fo71TnldS0WcmSOtZsNgvWZl0GzqUQkPx6mlMBdhwhhfm37xXDjZh/722SzvL0KS1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXjbdVJP/6JXeNXC5AwgzgWS1Wit0sK0VvN0OORic9Y=;
 b=Ee+glfNSRML0TI8CGKynFfLbvubGF/HnmaonRmanYZTqyRBw/IAeGF51hN6eX95PLwKV1t1+IUEQDDKhSVyW/GTyk7rrrcx0mTau2+yVXiiVrpEv2KL+wLbOZ++nMx+yz2QlhL3LEocQFvRSMZBhnzCsKPD4EneRx2Kf+CeQqSbUXKLJoLfoq1NxxXFRQi1OlYQ8jPT+bDuLdYNiESPRAPVLwIKgEiuKnp0BEhr9/NAdAEoSG+ESj6obvghDCDD4V5hmtWtQoTn/DJrArJf53S0mhfXi41vbs7o9IRH6wXsDiQUJnYbmoXNFMlrLfR/seu6VGqChDCKy8CIvU69/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXjbdVJP/6JXeNXC5AwgzgWS1Wit0sK0VvN0OORic9Y=;
 b=JPW0kqRlUbrzCwA7Yg7us0N2Dluz4XWiNJot9PT1y/NIkHEQ3kdXOVAw3VWA4F5dGsvsdUeiEjLbKylMqReRskQnYZoIRk9dzZvoR0COexcTIpVBQ5/1IpHO6pNt0P9kwvswc+QiS+/4vt5rnKdARM4ue+SkeOEDvAL5w8D9D20=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 BY5PR12MB4643.namprd12.prod.outlook.com (2603:10b6:a03:1ff::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 17:56:54 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7594:d12a:7bb7:34a9]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7594:d12a:7bb7:34a9%6]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 17:56:54 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
Thread-Topic: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
Thread-Index: AQHYbFuevhqc4noDaU+WVtEntTUi/60oDQrw
Date: Fri, 20 May 2022 17:56:54 +0000
Message-ID: <DM5PR12MB13081742FCCDCD1117AC806185D39@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220520150912.762831-1-alexander.deucher@amd.com>
In-Reply-To: <20220520150912.762831-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-20T17:56:53Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c482d70e-bd4c-4861-8d66-e80c1c94fd8b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c7c98a-393f-4cd9-ba21-08da3a8a2013
x-ms-traffictypediagnostic: BY5PR12MB4643:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4643AE004ABE56A71B79B56285D39@BY5PR12MB4643.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N48QlCSoomf61IijlD+csUEBIyM2St739L6/Y9DKIjMzEReWYK5Om4dDvz1UeQLehQlKKhm3gfuqAL0bT4tFD2iDZvMmM31ptfHC8npXyjL5ob5B/2Axf/gUv+S+lkf/mZwnDSkpYqBTX0Ji4ViF/gmo4r56DGE6bPBPTdK1iVbZ0ZIHqsjaGmR28lq4uGREXpzo426ESGavMi3usUSKPvFZfc5Q5ZvS9f3z2s6WX1D2WPIkHScO/KI8a06v6Z5AhGptTvKXeDF9p6rWOFgmYRf1vKHYXim2dNcCMDEvGWd2G+ovEHv4SkkYw9wi8wu1/qhr8Jil7EiwW/SukRreIPadFSarSCfJ0ZI6/KYyWTojdR1KStRcLIzJpwOFg0iiDtlwfXrHywgaqgCg0/6IYPSiEw4zXH9mrm6cyQTyrRY996sjIKUaqDItl9Hl+pROtcAU36fSvsCBKeCVEE6jQt/58aqsUIjvKRiJnVeuT8hrMYY5M+KNgUFXSWyknI/78fdYt8Lrm23ZZUeoUk4Jt8bqa4IcN5Pd+6Hl4O5fjIsK+LiuMBKEyBqHCLf+HrBrjA0D7ChnkXBt3DPJFbI//1smk1vGSd4AlYj5KRMHvqeikTUxyQ1bSKOp2DuhcwzYUlohrgeiS8QpVKZw0ReRythbhsKy5XlzhDO57iIYQR6UJ/RCoCfvHScTMTMl22bLtu6d493AP/hMXSQZuIOqHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(9686003)(122000001)(186003)(86362001)(83380400001)(52536014)(33656002)(71200400001)(4326008)(76116006)(66946007)(66556008)(66446008)(66476007)(8676002)(64756008)(5660300002)(55016003)(8936002)(2906002)(508600001)(110136005)(53546011)(6506007)(7696005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KcdJEq9g2fiao/y+kHL6tjZN4ruOjVA848sTm5PNyLMm9CrNY+KsqPo/YrXw?=
 =?us-ascii?Q?JRqkrFckEPYs/Q4cjST8u8MgcdttZZ8mPwtC2SOAWmx0KFQWPAmbV/mYa4p5?=
 =?us-ascii?Q?h3wmVHcHLfGvfwfoQs3q8zOZA83qWbPpsAt62aGz8EKeJfLOyz8CcwT2xhiD?=
 =?us-ascii?Q?jqoLsXGBPJ6NxMsiBp7dJbmb4NGBnNCAGMwZo9xNa5cdLBWtMfw6ou78V/mn?=
 =?us-ascii?Q?s5E6adrFpVYES+7T9p3FhmdFgHOH2TPrsQan/7KDfoq5Y24F/835OILoNuCI?=
 =?us-ascii?Q?hifUFxRoy+2yhg4GLreQp9PK3DxnNP2XEEBB6kgOaUGIY3gp90L5WfDe+Oiw?=
 =?us-ascii?Q?MCGzzzMiuQp5zEOCzekeMqrOpRj6DTAV6jk2JdDl+xuUWj9wm0xfciYIcHLR?=
 =?us-ascii?Q?cwrZTUnHoTidtJlpPChN3tmuYqIeHqhyB4/UC2vcnu0bGMFmBrKQrbytW9GD?=
 =?us-ascii?Q?eGVwJdj8G3uo3IbQQ6nAzuW4SxOn9M+yFMm8AUnHSE7fOrw5ueflzQeS2C93?=
 =?us-ascii?Q?ZY0N+eL93zrqf6iTz7Lwgfj/Nx2S/R+qThDDgO3XtvgUQ7+AwzfCO3T2kxRo?=
 =?us-ascii?Q?hatTpudMUMiL3emK4A17uSjXGb+f5qAziBBSrkkzsgqwwdOPkT9LJNWPV+g/?=
 =?us-ascii?Q?/vfpjHKEbsNGaiJzN+jVnA2xtPhPXdDSjfjnC1i8ZNb6aXrS2pxiWRRRByWV?=
 =?us-ascii?Q?J5F6sy0DGu8Z2VTAp6P+QZqztCwJ+eqr4wTkh3QLQCwQU7SlQ6fILg7zc4kZ?=
 =?us-ascii?Q?WgZ/k3d6cvusFFLgsQkVn8mbJz0tc+esv/2mT0CBVvXQcSMbz/j0GoYZisVf?=
 =?us-ascii?Q?EUTUdhGyjkMKsXzGaD7rppL80OPrmLcA+VrN0G82AvcAmqDvQILS9sVe+yMd?=
 =?us-ascii?Q?3KqiZSEmR+dOZz1nCH405LISOtKlGiBFkE4JjNsev+rPi3QB2rk4RSP1YMWL?=
 =?us-ascii?Q?ka2yplCS2+I16oFnWGtn684ORs7fhPFonaxKJwZGtrYAvVp+5qDDcQOgtJig?=
 =?us-ascii?Q?FAeWSEnCT7w656SQYeoc8L3DTe37lbFv0VMaUu3EaxiAjtiKtsJdoIWnPw7r?=
 =?us-ascii?Q?HAhlsXmxwxQbaeuI0gKswTaF2XV9B9NGy7OGAf8ljXbnbgc9n2OVIbbtjR+o?=
 =?us-ascii?Q?MCZBDof9NeiBZaQCcAcArtP1+Iu5xeHhIknoMDiRynwJgAc2Q9O2SaM5zufW?=
 =?us-ascii?Q?/hIAI1tGhsQM9a7u8G2D+Qh8YM5HxSLL/khurk9xYt8+7IvyUPZffPfinF9J?=
 =?us-ascii?Q?DbInskk+VakUxOfh+lbcuciNCPDYxvgQTc/WyYSe3WUSE62DiR06lBriYLbj?=
 =?us-ascii?Q?XyEZ/sli4JWoLIvNh0ypseOs5o8oiHNEirw/yNHXoJcY+h/L2DaGGbmnLnyA?=
 =?us-ascii?Q?+uaNgUdwiCklpBkYHEihfdpT0UWPtACtvsUYZjGgPMo0/HWq1sOY3Xw2VlZ8?=
 =?us-ascii?Q?NveFYGY2eMZzO9gdvrYdXItyNXnwl3Y+xV9NBQGs7Qmy341W7Kstq2OT69r2?=
 =?us-ascii?Q?jGfMVkna5x3F6WnNJvpxO96hJLSv1AOKlpPmADWJm9Xtgz4g8gxA4mfiLJr/?=
 =?us-ascii?Q?5gaE6pAo6FrUhH8uvmZW19YdLraiczk+Gx0TUSd+6tTz6nythNYlLYubBCsI?=
 =?us-ascii?Q?n0kXy9Cn07Z75bCSM2PvFnqlG7JYSrYZm6ic4eZ0Hsa6pU+VzngU3tHPTbek?=
 =?us-ascii?Q?QSSdg8AON+qkEuEup9h8TnaVbQgjNaMi3Gdo7eQdevzE7smELWYdaKTtYMMZ?=
 =?us-ascii?Q?gVBoGDyxRoPAS1xwwU9RQEV+Kg55gQuizjI+mzTfFJ+Z3Nzb39psD2IONXvC?=
x-ms-exchange-antispam-messagedata-1: XD+4GvxWpZAcZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c7c98a-393f-4cd9-ba21-08da3a8a2013
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 17:56:54.4251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khEtE+Auua5xQBlEhZjpcRinS8lh3/yejDXKJn+IACt9zP5h/B1PsygV2m6nvjnIEmvfbgHq7c06nBS9sdxEvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4643
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I'll defer to Felix/Christian for the actual change, but a small typo in a =
comment:

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, May 20, 2022 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
>=20
> Certain GL unit tests for large textures can cause problems
> with the OOM killer since there is no way to link this memory
> to a process.  This was originally mitigated (but not necessarily
> eliminated) by limiting the GTT size.  The problem is this limit
> is often too low for many modern games so just make the limit 1/2
> of system memory. The OOM accounting needs to be addressed, but
> we shouldn't prevent common 3D applications from being usable
> just to potentially mitigate that corner case.
>=20
> Set default GTT size to max(3G, 1/2 of system ram) by default.
>=20
> v2: drop previous logic and default to 3/4 of ram
> v3: default to half of ram to align with ttm
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d2b5cccb45c3..7195ed77c85a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device
> *adev)
>  	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>  		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>=20
> -	/* Compute GTT size, either bsaed on 3/4th the size of RAM size
> +	/* Compute GTT size, either bsaed on 1/2 the size of RAM size

 ^ s/bsaed/based

 Kent

>  	 * or whatever the user passed on module init */
>  	if (amdgpu_gtt_size =3D=3D -1) {
>  		struct sysinfo si;
>=20
>  		si_meminfo(&si);
> -		gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB <<
> 20),
> -			       adev->gmc.mc_vram_size),
> -			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
> -	}
> -	else
> +		/* Certain GL unit tests for large textures can cause problems
> +		 * with the OOM killer since there is no way to link this
> memory
> +		 * to a process.  This was originally mitigated (but not
> necessarily
> +		 * eliminated) by limiting the GTT size.  The problem is this
> limit
> +		 * is often too low for many modern games so just make the
> limit 1/2
> +		 * of system memory which aligns with TTM. The OOM
> accounting needs
> +		 * to be addressed, but we shouldn't prevent common 3D
> applications
> +		 * from being usable just to potentially mitigate that corner
> case.
> +		 */
> +		gtt_size =3D max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> +			       (u64)si.totalram * si.mem_unit / 2);
> +	} else {
>  		gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> +	}
>=20
>  	/* Initialize GTT memory pool */
>  	r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
> --
> 2.35.3

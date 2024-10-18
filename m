Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38492D30019
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 16:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D7A10E379;
	Fri, 18 Oct 2024 16:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4Z58Dt6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD1510E379
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 16:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vlkwz2hO0+rzeU7hXHyur+E4xD9xzPva1LS+PWA35Zi6+yM3DUjOnFXJVW1deS5qH5hRTTcZ8SUY8/p9NB+fE0yeQCpaGr3D1HAmYplfMgbZS8BBoeB9QXsNMhXch9Rtpilj0trU81eB0VhIwmEBG76QGKek/1SCBoOWkvSg4iVmEj8adgQvcua06RzD1Ve5iY33JcdkYb8aulcoCZk3v5BmUAZOL9pJgn21NklOonNg+F121jg7mkcjlD0pGWwpplfGg3WxkyBQg8IoyfEAz4m/5SCj9G0eJBn4H6xB2skqLaL77U4pdai01ycvXAgIYjksqFw4+EQBSUw1vLqcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ari0t5FVQLny6/NB9nFeUFtwjl8tCdpFDpMlzSUYg7o=;
 b=e67m2Puy+mgMMUsXPA9maMhLKSVbILZ5/M/6R1I9gLrjnfqaFQpMrSh/inJMZtWaOTG1BBymZ5NaWSnbv1IGkT3jPzBWRfqoo141EcnT7bL/IQDOHQXjOMRgYY8uKx2inSY1wn1RsM9MopjOdTn0fOz1iiv7eBLZIxtZtra4t+dBq+khOLxdgW5Q3czNgdw/QG/Yo+DzLHCtbpX7FwBHnWAJu8FGpbxdDkOcbMgPF193OvRNp1wwUhR39DwNYxMBhhxy4O8O/HWZOVGe9Z5SEX6UInfNO7y+LkK+C4e60JPRwxhFDoBs32KGQ1WVhlqXMNZzWLtx2ySYNK7xZriR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ari0t5FVQLny6/NB9nFeUFtwjl8tCdpFDpMlzSUYg7o=;
 b=N4Z58Dt6shCM9o5/cvmp+lGbHZddRH0+OypnSGRk5KrnFhxb+NRLUIQclqMdCZo3GBKeZ/oK0QXEHyV3f+/in7hWLJ2KJiWi7kI/t3Ea/y5mFnRQZHrYAEeaugtMZcH+/478sVKGwl1nXdQtaC7DiR+g3W1civ+TjDvQbnFcTAo=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.24; Fri, 18 Oct 2024 16:01:58 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 16:01:58 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Bhardwaj, Rajneesh"
 <Rajneesh.Bhardwaj@amd.com>, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "Zhou, Hao (Claire)" <Hao.Zhou@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Save VCN shared memory with init reset
Thread-Topic: [PATCH v2] drm/amdgpu: Save VCN shared memory with init reset
Thread-Index: AQHbISjGKBQyxDXKbkOXZlU+hH7rO7KMq7gw
Date: Fri, 18 Oct 2024 16:01:58 +0000
Message-ID: <DM8PR12MB5399BFAF9208C330C098C74EE5402@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20241018064103.3087876-1-lijo.lazar@amd.com>
In-Reply-To: <20241018064103.3087876-1-lijo.lazar@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=099231ee-4e14-46ea-95bd-7a6ec94ef1ba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-18T16:01:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DS0PR12MB8454:EE_
x-ms-office365-filtering-correlation-id: 2ac428d2-4b01-435d-0ddf-08dcef8e321d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SfvczXW6ln8y51rDLowaDARpsPaPK6tiV2+ztAdDJxcqaHAvn5M+nInY2UaU?=
 =?us-ascii?Q?LCiseZ4Q0HbCNIpz6Yx/O047tks0Ni5Wr7wGjimkuTc3zjHCwzV2Ad2/X1D+?=
 =?us-ascii?Q?JwocV6cw4nh9O88oZrK2Phw1tj9lHGW1/Xw8az9daRc9o4D+1uI/FqJXb5y/?=
 =?us-ascii?Q?P3Nhun5s91hupBEBOaroq2e28DMJRiTGcc+o4iu0eutj119aE/dle4jTlFct?=
 =?us-ascii?Q?wtqPRNyFjHrV1NLQCB2myFqGSjK9fHXWQqWuvhd8AJyszY37jjwUGkXOngZk?=
 =?us-ascii?Q?cdw10FR88NzRSFHdy0ecPmgCcu1Wm8o1Pv5l8MxvlXXR5LFGmKmMzl1YVT2v?=
 =?us-ascii?Q?8Y6TK3AyO6XIBgS2UlOlJEvpcg1mmQDWv07IYQMzsPEWl5ogLeakuY3vgAkh?=
 =?us-ascii?Q?XKS6TD3G3IBaydj/F+Os5TQJtKWwkbdXibgZ9QIKuce4nxAjQol0y44Wo+uw?=
 =?us-ascii?Q?M/s+yGv0jM9z4nMcUCcxs5uKiHXcvG90w/zwbsRLM96etUC8c9FVGPLX2tBi?=
 =?us-ascii?Q?TXXj0QBjrnx+CADwsrELjglVKkF120R3PBqpt77zDcg5MM5vCnV43lekMdsx?=
 =?us-ascii?Q?8bZM/2LMfBGTQwEJ2RawCNoWi/mA4ZlIBN6VvFDzhQuw96p0ktBeKUP5ZV8b?=
 =?us-ascii?Q?mki7U/H8FCffk44+MGl2EV7J/Gny5snC3U4Hjf5103f2vKdEnGpH8nXSQvvk?=
 =?us-ascii?Q?OLXIh4UN9AdfSE9fkWz9et0CkHHJ4sK+4N6Wq/NTTpUQ/II5zGd6YvpryZff?=
 =?us-ascii?Q?G+Zu/bwOdOsxgaxbNLktQBCEliVkmvLTLAP9RwRzuLTScCmcYkrdFJKm5ojS?=
 =?us-ascii?Q?93aBj5EZ4nS6p5fJOd1YAUE7V/UEwE8yGEJ1DTvsmmabyP6pQlraw305Epj/?=
 =?us-ascii?Q?H41khNJADz57O/iElo3f72EQXR1WE6O5x5WceMyiS7EBZSwwgvHfUWfbFNUr?=
 =?us-ascii?Q?L21LMhR8yjhyrAKrH/6ZMhtsxb2/r1CkMi6Qc2K9KtLj3qg3j9I4tQ0U3G4U?=
 =?us-ascii?Q?Ec2PhuiGUupBs0h9pdBw2azbSUYv+gtAlFufD0DgxJEEbqdmZ/mfNQAnvXnz?=
 =?us-ascii?Q?uWxQA9mhdL8Vvnh7l5PQaAJFM4G96mrWwSkrGeNjTMUenQnCjx+CkKkonrpR?=
 =?us-ascii?Q?G/5QGt9U8b93263L4NT9ndSK45KitU81Li7h9f8S3/HX4BXzM50NFdWBzola?=
 =?us-ascii?Q?HsZYJJ006lu1Shnv8fWaw+yYGp4NMwCGeUdI3EJncHytcgcLWjsAlIF4MsgD?=
 =?us-ascii?Q?5Xxw0UuZPEhXsWEZcmxdxR7HbsIXyiJArHpKSKleyyiKyfvVngQW1jCJ6/VT?=
 =?us-ascii?Q?/pm3NhfmaXJqTcTk+v3lsuRsdi//G/SPx3d0ogczWtU0OLl5uSqRehrrnn2c?=
 =?us-ascii?Q?yPyNlhg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9+X030yPVgcKNm4VwEdngWBO8pUJRfxlj7P6Qh73hHxr4KOgCW0GAPz1wXlZ?=
 =?us-ascii?Q?T+AShSNdldvdMZx/paRtSqSzLXO6Sr7x42cG+meEqZFyfYsIZUekJ/mHI5OP?=
 =?us-ascii?Q?AutMoe+lObhzpOBMUbctehBpN7wwHdrAlpyQfQ0Gg0mQ6b4Tc/mtonXWv82X?=
 =?us-ascii?Q?auvZNbkX4Cg5XZ1O6ZWLd40YJdRNJVVEY9tU0PN+uMggzl29l/JyRpORr0GE?=
 =?us-ascii?Q?0+/d2okrJGgWabo2kgXI8EheQA2AgSrVlzznFC3Dlp1lISv6bZgEgMP6fAoX?=
 =?us-ascii?Q?CwJKPLbDHHuJHHxBCf0GSKHItqWfhwDlV5Fj6vTz69V8jEOQBMzyxGXoTVEw?=
 =?us-ascii?Q?+eHwVsTjMEkK2agfBWFcqdSsLIjLp/A/Rx7BTGTQ/bUVPyGsLpT2w+ptK2oe?=
 =?us-ascii?Q?NBCzOhn7MsdNEMEnPFseaa/GfPuouP7CjqPgu5G62eRkXdjhPTNdKioVYjv4?=
 =?us-ascii?Q?LQg8PwDgefSgREhD6wqYmkQqOztc27bBDEGp1vzTkGzgGc+0sQlxCjYYZ8GV?=
 =?us-ascii?Q?bZfNhOiRB2v+qSNggsyuNLPQXZnCQjOsni0hSrKvF8Hy/Fbnkjtek1rGJrKt?=
 =?us-ascii?Q?oUUy/dCUlUL39MUgm8ixEgeW6SauAn6PxS7VwDooqRNakzF8awVvB+S2DM9D?=
 =?us-ascii?Q?nHP73w2QgGZtTdjNEqc8M1/uFlMhZzcY1n2AMlkd1JBX0dkrM+JjqJwIkFHa?=
 =?us-ascii?Q?O1Zat9oeUTTKfDpUKMoBTsKJPplsg6Wu62KII8zPCiyyJoco+rjO23m9tPLv?=
 =?us-ascii?Q?rTb3eV+8+J9jDUMzJZiqnEcTEJ7o76B/mNvKQZsWNdQ1gAMep3bUN3q5yJgl?=
 =?us-ascii?Q?Xip0voYoBS5bZerbyHT5MRq66BORj4jLf2yKTinFoxFRNpJ5gb452Mr1sV4I?=
 =?us-ascii?Q?6sBBG1nRbfBNsw1VROafCruiwOUgn/3BQ/wd737lVKBtqfNJKjDiiIVcC20n?=
 =?us-ascii?Q?/S7DAve8sJJ/VZ9179mD52m73LQIbVMjoNdPb+PU3v6XnOEXm13/DyMTVTR6?=
 =?us-ascii?Q?ivYsr1g9KE6D63elsBr5OQPsm9Z51i+l4v65rv6L0C2qlfYh00qi3gXKRflG?=
 =?us-ascii?Q?DweqHdTTRbi7rG1w/Ve+BmVT+DjcYAM+bzLnkNBCgpcW8MtkfaOziagHgOHi?=
 =?us-ascii?Q?gf+QyYb1p7MIzHSNxTE2QiRVwjLsJYRkqZjPnbGyhUJHx0XbbVGX6S22sB6H?=
 =?us-ascii?Q?qEtvsomRlr6hyVbB3mk06+u/5ZDLjqT/6OQZyyFfulVYPteaD7hDmsxsMN/K?=
 =?us-ascii?Q?JIMjy86OyNqrQsdTIfu+kz9i007f72ebqKAzxBlQrAYxL6SE2N8HzPhz1A40?=
 =?us-ascii?Q?nNbXnjYM+qvqWm/xW4VSl+22NnFfakgEu5NQgIe2Ut1xniS2/UWaIBWrloDx?=
 =?us-ascii?Q?jETGOuDDc7k59S6h5V6Y5WGpIf5hBEsV9YV8q5VOQyczxlZ9TJwP6AdH2omI?=
 =?us-ascii?Q?HAiaRMm3hH2DdMPEMzSEe0vjs2e7q4laQfbeoxEjxIPw067hypsWr4GBFIsQ?=
 =?us-ascii?Q?BD5oCs8Oi6hB0MxKm7JiWVP2LUCfoMRq3BcN5+I2YPsClYXyTBwDFNb8Bvxd?=
 =?us-ascii?Q?auFQph7qnPoJ/BrE9S0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac428d2-4b01-435d-0ddf-08dcef8e321d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 16:01:58.4608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rz0jctlHaaR+AxCknlUdkA0b0Tkts/XoRGGq1i4WHPfTyPI42ySjqP6szbWHZOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: October 18, 2024 2:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Bhardwaj, Rajneesh
> <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh
> <Ramesh.Errabolu@amd.com>; Zhou, Hao (Claire) <Hao.Zhou@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Save VCN shared memory with init reset
>
> VCN shared memory is in framebuffer and there are some flags initialized
> during sw_init. Ideally, such programming should be during hw_init.
>
> Make sure the flags are saved during reset on initialization since that r=
eset will
> affect frame buffer region. For clarity, separate it out to another funct=
ion.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reported-by: Hao Zhou <hao.zhou@amd.com>
>
> Fixes: 1b665567fd6d ("drm/amdgpu: Add reset on init handler for XGMI")
> ---
> v2: Rename save function to a more appropriate amdgpu_vcn_save_vcpu_bo
> (Leo)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 26 ++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  1 +
>  3 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 3e2724590dbf..d15438ec81a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -49,6 +49,12 @@ static int
> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>               adev->ip_blocks[i].status.hw =3D false;
>       }
>
> +     /* VCN FW shared region is in frambuffer, there are some flags
> +      * initialized in that region during sw_init. Make sure the region =
is
> +      * backed up.
> +      */
> +     amdgpu_vcn_save_vcpu_bo(adev);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 43f44cc201cb..aecb78e0519f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -294,21 +294,12 @@ bool amdgpu_vcn_is_disabled_vcn(struct
> amdgpu_device *adev, enum vcn_ring_type t
>       return ret;
>  }
>
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev)
> +int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
>  {
>       unsigned int size;
>       void *ptr;
>       int i, idx;
>
> -     bool in_ras_intr =3D amdgpu_ras_intr_triggered();
> -
> -     cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
> -     /* err_event_athub will corrupt VCPU buffer, so we need to
> -      * restore fw data and clear buffer in amdgpu_vcn_resume() */
> -     if (in_ras_intr)
> -             return 0;
> -
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
> @@ -327,9 +318,24 @@ int amdgpu_vcn_suspend(struct amdgpu_device
> *adev)
>                       drm_dev_exit(idx);
>               }
>       }
> +
>       return 0;
>  }
>
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev) {
> +     bool in_ras_intr =3D amdgpu_ras_intr_triggered();
> +
> +     cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
> +     /* err_event_athub will corrupt VCPU buffer, so we need to
> +      * restore fw data and clear buffer in amdgpu_vcn_resume() */
> +     if (in_ras_intr)
> +             return 0;
> +
> +     return amdgpu_vcn_save_vcpu_bo(adev);
> +}
> +
>  int amdgpu_vcn_resume(struct amdgpu_device *adev)  {
>       unsigned int size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 2a1f3dbb14d3..765b809d48a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -518,5 +518,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device
> *adev);
>
>  int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>                              enum AMDGPU_UCODE_ID ucode_id);
> +int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev);
>
>  #endif
> --
> 2.25.1


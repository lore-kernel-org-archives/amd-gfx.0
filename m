Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4B3C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 06:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2912B10E24B;
	Thu, 31 Jul 2025 06:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TKMIg2JT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5ED10E24B
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 06:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRRGLbLllAua+COBVJKSddRyI5pA8wwfAb0S45WbgKO2FQ3Ksm1+yRUt5lGahfmTiEPxHkdXSiUU+s14Uz/WFQYGhHVUjFUY/QjI5jaCZGZLI19TbpQZ5IH8PVtuMJL0/YoOsGjI1U2i65IZxUJY2k6A/nSC/DeLN6EvcmImCNhEvUeUFYaMLwjKIZ0FYKsm1iZy5THSTmAz6HHKPKEWjqH/VEQEc7WkaTYyc9NGtK92+2G60uXMi/6m8a6qok7/2Zj/ZeW1VSD7O/AtMc9EKHzOiTRA50IdOpkALG1ng/E5ToloHxA9AGel3sFtMoKpPDtfeW/OePRLGsOgPIUWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqnb5XjeBVqachlTX34vh3SZbbYAxhh09VqnKFLGrmw=;
 b=AaYPeSdw4/Xf53N4bJNfSeYr2Ir33CHEbNNOtuR9FDdNe8PdDCwiN5DtteDj3Pt/Z8/UmrhKnlzCIjZdgbQI+ztgc8S7IrDqtahPx3Cz8eAD7vOAS99N4rGlmEgv0HzqHofkHz37r14++aCmt83EyYNROQNVBAnZ+s2eJYk6Vd59WLGgIGAHSxB6Lt9RQ1/W372NZo/Upb2LUVKzAhDbjeOxBd5SvVc/zFOkRilo4Te3CHNyVGEOKZxBmZ2pWbourezNL9iU4fYv1J0MLJ3rFcnA+VIgWXDRzynOfYWk9Ht/0F4uqTgzlgkHecBZ48DSScwMscuLQKgRKwHWLbvLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqnb5XjeBVqachlTX34vh3SZbbYAxhh09VqnKFLGrmw=;
 b=TKMIg2JTraxvyj9Nk4ICnS7JjsPxnacM77qhuijXoubLd0MWBX3TWJQr5AxqcLb0z82xUIkPiCDyb0LpAOq+gv3NR8Zm9pX0QqLJQZLnCSePFXjVO6v9XZoiLGJqW5mKzmEStNfpYnksQR4rAGKEA90WaIobwZ31vsCjJNBknck=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 06:39:29 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 06:39:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
CC: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Initialize vcn v5_0_1 ras function
Thread-Topic: [PATCH 2/2] drm/amdgpu: Initialize vcn v5_0_1 ras function
Thread-Index: AQHcAEAsBmyEKrB10kGAQUn2fVH1xrRLyyNA
Date: Thu, 31 Jul 2025 06:39:29 +0000
Message-ID: <PH7PR12MB8796F8318543D7DD266DD2D2B027A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250729042019.1487385-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20250729042019.1487385-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-31T06:39:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY3PR12MB9608:EE_
x-ms-office365-filtering-correlation-id: eea0df95-1144-4dfa-1d11-08ddcffd0058
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3+WX4InBSi7NJtlNUKYe7s/oR6ha4cFEb/+OxM7IoSyqRTUeZjHeFkJ5Ka4x?=
 =?us-ascii?Q?ldmeWYfFlYXrb5sacKWUJaX6HeOFo/rpiAhf6WX2Cp7H9YQnK9OzzDPNZemn?=
 =?us-ascii?Q?7MTJ/ucbtSo1K7WEsJNwO+cjPFeuC6t+05yBkCt9iJyiNLduQbz0ES/ARkd7?=
 =?us-ascii?Q?z2GxwIoUKae4V+90OFDrMPy8rL551H/Xi5fub2umpb+pzA/544+8ETL5QMsU?=
 =?us-ascii?Q?8+HErxuPrAWi55ztdaD2DygbUfARc5Y+cATl0zcGUL3UZ0xm2nd6wKK6IjFt?=
 =?us-ascii?Q?QGTCrxCEtyRLuRm89cPe2uRENeKBCt5Hl2sk3fIzls5hvpQeZ3i3mkYQIRQL?=
 =?us-ascii?Q?kFJFdVh5kEc8mMhQXJg8uQV4/Fy1yymUN8G0PaAsFa0rXgjrRRYJjP0XnRgC?=
 =?us-ascii?Q?NQJ5Q4ELhz0YcOQudy1oG841saYMTnbYjhi845kp12vyz4J504X0UBJshlLt?=
 =?us-ascii?Q?LnRM/SW5oIaBPxcFROfuB776JA3R3kniSFh9kRDRPcZjiyks0cMwfLEzuevm?=
 =?us-ascii?Q?UxUhgg2reNGhecRsi1YWBvvZHNhCG2XE/QSvMNDOuwZgJUXrOSGuaT6kscBw?=
 =?us-ascii?Q?493SVJPP1rBsQ1Xrg1FKo95uv65simiqeFJeFixseuAWRJqvc/ofRMbMRaHf?=
 =?us-ascii?Q?D7r33J8N2QkhRxEanRocus9Opsp1c32DvRSKSmWNYJwejVEr2BLEkhe0U4u6?=
 =?us-ascii?Q?okV8ZSY3M/sMBTha28eMkqtBgQnjsnPq1cTmNCkXoioEeaYh/tPcz9nNC9b3?=
 =?us-ascii?Q?/xepA/2e0N14gh7vuXY6kSdwkZoADNwnSLt+iEijuPW7iZxA9VTCNJkEGOzA?=
 =?us-ascii?Q?MJZaB5IqkZ7khqYob4wGxEtU7iypAvzJIdTDNM94M1LBYK9mfpA/en2poRz5?=
 =?us-ascii?Q?vGkvf6BHkjA5LCFBuGfIkDylKLsp7qRYNEMmXHqFwaHeWkW6zaid0ZRwZyzT?=
 =?us-ascii?Q?+NtoTpRSIN8KU3wpLjEc1gVSNwScnLvuCwuaUfZz4XCg38iVhaD/3gluP2lS?=
 =?us-ascii?Q?VrK/WlMBdThEAO2AQHY6uxXLbIDCEB3fD85TDEfRQ4eQ2uI/shp0MF5AToS5?=
 =?us-ascii?Q?clcwN419QqcOp1bOp6MwA860kpYWO+gqmU06CvbtOJi8QIEQ2DmWxxZv1N81?=
 =?us-ascii?Q?DpBi2gQBtPmEd1tYtQFHnaiTa83YAW79PNOuWlKlGHa03ZvEkNZE21TSBsml?=
 =?us-ascii?Q?JEpdnvSyGC//6c63pb2noHpmtJpOzpV9OrJZh62qO0ufMnvDClPjXXCp5yZX?=
 =?us-ascii?Q?jvN6YKvi6LbBwfuMc9fciljIn9KziExNQkyCXV6lBmNPbd1o6lybc1NTQYKh?=
 =?us-ascii?Q?v3qAffC0IcE6VNKZlSzt7eT0gVT58oJ6q8Uy0H5NSAnsDkxsniXT66Lz4RKb?=
 =?us-ascii?Q?fruUBceKqyexY1yzEYEaJP8+Ap1FOg3uxppcYKNIRVzoDvdBSxyIXMLseUZ5?=
 =?us-ascii?Q?65vjiF8R7NN9nEfHHGQKaN/YsLoQOPKqMN4cCbNLvKzc4VdNkDeSsA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t9quu573kqKp9G1AyXyKTzudyNakPIzQWmrK+sAmhb26Tn0nkzyGLK1CiQ+p?=
 =?us-ascii?Q?WsR9CTcvLWA6KEqp2dpH/FFC3hSkc4PmsDN652+wBv5xnPH4eua/YWMfTUqG?=
 =?us-ascii?Q?jC1oOW7DbGaS5n1cl2bO0e06Q6tx2v0kem6juoBvH0ikdZnWZHbYpOMh/4xE?=
 =?us-ascii?Q?GILBcMRKfeCtJFHhup3pINe6jnhsNsv3H2Z4Xk31k/njek1oiBQPyrfqLBga?=
 =?us-ascii?Q?Cl1UzGAW3l1mtRnwfziWsofjrtFz2zMySzs6OguCukcxSMKENkJwEiDdQoaK?=
 =?us-ascii?Q?gqs1+HlAUnt0q39q3BQCiYG2LOgRSy45eawkUv62e/roQO+y6K5kUO8+whBk?=
 =?us-ascii?Q?8Wkv+CK3Tw4m5QW5wiYLWMxJQ4n/xs0dd0RGXxlfKGaJbrXG3IzMnBG0HLa9?=
 =?us-ascii?Q?rFyzOLBv+mdkGpkz71RY1pEmc9LibImITkfp4uTCr++d0bPIdrF3lQJRcNLC?=
 =?us-ascii?Q?/FMiwOkYXq/yhmJbhytZYMu7CvYXH+RgfX+LYggb6VdJS2cVSs6pwI4TndMS?=
 =?us-ascii?Q?niCsbmJTG2nAed31urcTONIEnw8aDj2QEZYruOtWbf/5TPSkF7lm5kpjlO8r?=
 =?us-ascii?Q?L+659t1x0aDa9yNd1tiMCrmKalt83He26lSmEShdbXIneEBBdP3Klc3Vfolx?=
 =?us-ascii?Q?Vlhu9/GGf3aTG6/qSAeHDhjvsFCPqbg1CTzfGl71iL9mEvhRL5M/CJtL6yON?=
 =?us-ascii?Q?kSd5+fUKOjc4gn/BdofSKNkyfXNiTKjafoK2QP2hssxUyYRRFWazC9y7nlXq?=
 =?us-ascii?Q?/Dg+s9B+dD/I2/Nt/tVIwRFsiA0v4j5c70+wDG1LgbK8KqFuwun4KSI2nKC5?=
 =?us-ascii?Q?jMN8OkqFTPoHZ+6qyGz/0fFA1LtskXcpVreV43BvPEcgAbfFZHcAW/4gInoD?=
 =?us-ascii?Q?hIvjpwBLK1s1cV6+9jZGIaVJxpdCAb4jAWSd/2Tx1g2gaM4JWBVEKoROcXqs?=
 =?us-ascii?Q?9s0u6oOTsmksADoyG46H5zIXMLFUgfFDYnZRuuq/uFLHmINlMl8KKIwQlzDd?=
 =?us-ascii?Q?TcEqY2ERE6PwGVfeH+uG4Fr50pw4S4nLhyy45e2+oAp69qk9313rchxMVp1Y?=
 =?us-ascii?Q?SSZF8FeiTCsu7MbuNX0YVfteQ4I6By9bdEh7ecDEK4wjuOJ2uhvmd0TVGS4b?=
 =?us-ascii?Q?fv1rGp3IAmdvYaQY9ioQcFhBmKPU4wYg/6ZaV8pHTiFldhW2geRZyu7bSPMB?=
 =?us-ascii?Q?3xEW9ybkNepRRIpHpCQKVGAcHM4qzZn1pXzavjFQ2/W6wTjvJCn1es6RjRHN?=
 =?us-ascii?Q?LuocDkV6Fq2RmVyLj7+lzOeE1UV8KgiFYzosRpy3PD+J6PPfy1egzqDsDwar?=
 =?us-ascii?Q?HJFziQ42Ul1T2rGT+ZSpC1oAoCEMcw2xXKV0R2w48qTVj1/PgT/Ksnn3RKDM?=
 =?us-ascii?Q?Ovuuy2b2nzGsA5fv9KzwaWN5luXF+2aqTHOzigdn56BvG01XKo+UI+Z5bjPz?=
 =?us-ascii?Q?1p36fcrZRQAO9N5xWMMq4OJN9nhplykctCESUDY3l6dyCbKF1+UF1Q+1UNDQ?=
 =?us-ascii?Q?/Qo5gYlRnZrutygPXLi+pRVECPmI72NSRM4tEoqil5D5qrCOYCsZG6Tjmw87?=
 =?us-ascii?Q?shnvR3uc9TQ/q+wV2OM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0df95-1144-4dfa-1d11-08ddcffd0058
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 06:39:29.5848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /20p5nj8WVCZoUyiAJ0BAm3Mc/aSFA+WACvu5erTjch6UI6h/+GaiyHMltI14Okc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Manges=
h
> Gadre
> Sent: Tuesday, July 29, 2025 12:20 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Initialize vcn v5_0_1 ras function
>
> Initialize vcn v5_0_1 ras function
>
> Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
> Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index cdefd7fcb0da..563cb3e1b610 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -163,6 +163,15 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block
> *ip_block)
>                       return r;
>       }
>
> +     if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
> +             r =3D amdgpu_vcn_ras_sw_init(adev);
> +             if (r) {
> +                     dev_err(adev->dev, "Failed to initialize vcn ras bl=
ock!\n");
> +                     return r;
> +             }
> +     }
> +
> +
>       vcn_v5_0_0_alloc_ip_dump(adev);
>
>       return amdgpu_vcn_sysfs_reset_mask_init(adev);
> --
> 2.34.1


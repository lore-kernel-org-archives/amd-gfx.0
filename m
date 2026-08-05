Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4C0C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 14:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CAA10E20D;
	Wed,  5 Aug 2026 14:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLA+Tmxq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BB910E20D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 14:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxGKdUKQYGOxV8g+iwWOB+hAPt1O8lVF1xK4VZ+9eOgY2F0rwyGxEn2k3VrkRJNBnAMTXfdaBzRDCbGW8Y1xGWObqlt1f1thQAQx1T2AVMKoq4GnEw95HFyEbEhrQbHXUhQPhI1vfkRIghs9zUuSMU4sZHpcAqpRy17gHyRUZsE/FII0+Fx5JMyaPneJ4E9f/BHOf+z+6Ks0QQdlzy8RMxhrnAbdMFclfg9xaLp4hgnNv2+qYdmT4jZrrVRwwvtQ55c5P7+Nuvw0wlVwzwM0xY4yZlEryrd986pq2AUV7NW79I+ilbLoJmfaTZnqzdng+KeUNKJ+SNaR1Vj8Q7Fnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q932gEQ8HpvH/B3iYR8grwkbQJsnGWYuwMdpmc9xkaI=;
 b=VCoDVqg/ML+XJIRmt89Xl6LfpSWvTy88V3Mp110IM+LvIyKEbcPU5pvfK1no9yBEKeThYu3xSbNADEuJnyCeUGuz0p+ZrZWsCWqTn2XtwFICG32/w0zKxoJ8ySvdzeGtMEtsGHgbKIiJpSuxjZw3nvisvNt5XEEoQXWFQYyx7cSxfGgwLOkMijGTI7L5f0k2asEKTmYK9NxsRWw27aEZTSDDQc9ZjtwgKL/KbjkW6GUXxxic8ysSrJt+5R2Ugc+Oj8Yujp7BShGvJsxmOjqgTuUAlFR4xAW73sP/elY6qydHSJ4NKD/roLHAAAB7mxln7gi8KgjEqWUynn21j/yIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q932gEQ8HpvH/B3iYR8grwkbQJsnGWYuwMdpmc9xkaI=;
 b=qLA+TmxqXVs+ffF+klT282xq/WjbepiRk0cADLTwxpotaaYyuLieRA7ElkEObo7XoEgvU7YiPJ7h9oNGML7k1Vzha6Wz0GjzyZcSrEH5oWeK5x16+SPQEozqIYAWAUHzndGJKDLjH4xF81Iu9cAUrlsL4GCbAUCXCtWJFisT1Ns=
Received: from IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 14:57:29 +0000
Received: from IA1PR12MB7568.namprd12.prod.outlook.com
 ([fe80::5fa7:308f:19a7:cca4]) by IA1PR12MB7568.namprd12.prod.outlook.com
 ([fe80::5fa7:308f:19a7:cca4%6]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 14:57:29 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Fix UVD min buffer sizes
Thread-Topic: [PATCH 4/4] drm/amdgpu: Fix UVD min buffer sizes
Thread-Index: AQHdIEVUk6O6G0Zj2EulImdm5FbmNbaPlMmg
Date: Wed, 5 Aug 2026 14:57:29 +0000
Message-ID: <IA1PR12MB7568C9C1B2A033B92BBADCEDE5D32@IA1PR12MB7568.namprd12.prod.outlook.com>
References: <20260730170230.11930-2-david.rosca@amd.com>
 <20260730170230.11930-5-david.rosca@amd.com>
In-Reply-To: <20260730170230.11930-5-david.rosca@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T14:56:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7568:EE_|BY5PR12MB4212:EE_
x-ms-office365-filtering-correlation-id: 67008101-1e1e-4850-a23a-08def301deb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info: qPyGUh479GuCbnShjp0uz5wM7Y502Lwqnrn/L2TTGkiqmhmEKKclvLOqSpGr+Eb0b/cgrT9N6+Qj9rZDuKRmn5ouYo0MonzTQBs6lQuLRNBKs7a9ucV+eP7R1OpLGFtdmSP+Pl8b65wQ23p3bvXgS44f3uXkespskpMTtgUejKssL+TsZaQoQZlETVq9FDxxjyApzUbqoEMnj4FfxunXlOpSBzeNfHX3VFFtgJxiSbRyXsBMgJo3Qo5uvabxH8sBBcaTJ4ehnXudtljkuInX0Ic8FzT52tPAehhBSTfe5P/8CTkSYGxXzX5ir/4y0RR2+sTIwPzD8cZz1KtPnGK/w8ixCJpVkI5K7qT4xBpGAPaO4+lPnRZSx6H/Z13tIQmSs5C321f4+i829FTaI7q/6m08xbpOBseWTmKeY9RAzNTKC/NTMmhgnDMfjUiTvqc6tIhHFS5Sj964I6VLFnkUcnNTTB//7EM+jgO6bh0PAL7vAjWT5myR5daYpQsR85BwgdjItkZe5LMIqWidfZNoOwWGQU9ChFMPEIEboPngEQBbqW6vGXh9AnSt0tspIMuf+4+fvca99+Hff1PEGXBEKnHxYJLEEt8TofXwVCbfdtTam7JQUW/FDjtyw4Uqd6US89Y652s5KVvPv1bj22NVMZ046tCcyVTar5Q5vNuaCf8nUi4vrtVNlSBbeN0IFJ0WLauIRFy57yTmVOoKhxY7WFSCIV2Zf3j8wkTrx0kCZ2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB7568.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jODYB5OpcDIrZLmMuPeaEJPVxLjIXjfgtpLtPEdGQHAi31WAJWYUz1RaFK1Y?=
 =?us-ascii?Q?VdUDe2J5YSgveV1nSE4KzM2Rkrx4QDZI5EEBt+aIF1tGfpjTiHowQrruxvTX?=
 =?us-ascii?Q?oeI2IWUUuytFX1OJU7Q1osdfmU7BkH3usn3+ayvuDKPbvy/IlKznIU1y8lCN?=
 =?us-ascii?Q?lq+G+/DnXA5Zhdp3bW87ijv9nFC2498hKzHHelZtUph1V5sheRp53oc/wxy4?=
 =?us-ascii?Q?UgdOdp3bgriCVIXg9aD2hHnHE5n7XzG5PwDUmTbsSl82d/t2psbOOJHQZWd0?=
 =?us-ascii?Q?6HYGAtiRBhQlVwxGvCJ1Y96n68klPofGfM3mxfITV9cCrH9HvFFmXJD4NGCd?=
 =?us-ascii?Q?pSSLHBWmSkDdcA+vj+NXzD3PftTI/6VFbKVuHYzN63fEJcsISWEUodILePEx?=
 =?us-ascii?Q?GfbvfOjbA1/AvY73d4ADEoka2Hq48XuzgrJNhMadlR+wWxzNPYe4NYl8RgId?=
 =?us-ascii?Q?Ke1kGfXHf4zXPW61ptS469fZeltgyzy0pEyfuJUQgHUjG+kLjy2bJo+gd4qw?=
 =?us-ascii?Q?7N21hWkuef1zepTFgtyERm5HJeK1TlmpkX087Swoesl9pnRXHA36ihTw5P2j?=
 =?us-ascii?Q?BKSCwqmq48DSx5dBhpxyBVqSIRJF2caGW0pUpoupeCxyIlnAhGTHWRyJ6uwV?=
 =?us-ascii?Q?lMPhO++0KS839nPV3NSpXC3b4iO5dT7Fe7Yy6m5ZwOvvs0Kb8DRoVfTNX7+8?=
 =?us-ascii?Q?gxoLZIczFLZa2vvZgY4/QyIT9/ZraOzJ5PGBZ0w132LQQBC1IYxHq+0rWrgg?=
 =?us-ascii?Q?wJXuo4s4ExUaaTmpezLB8WhIIhKi1mUspYSb9Ipt7QPn25FpHK0dkXPseHIu?=
 =?us-ascii?Q?NGYyl2DqwEqX2wk6TiaCeIkOUAobObhJ/1v0N06wsf5Z8C2GU3UeYq7A6YWG?=
 =?us-ascii?Q?UVaUzl4Ma2+RcSXMknn9tLAVb/wAYmZwKj1kpOOKgfkGaNB2EzCpMP6Dn2f+?=
 =?us-ascii?Q?iKB0a9u6sQUQm3zAPFUvaZCSl541UwSmSbjaJNpZpGI7RlqSm+KL7B1k7Fqa?=
 =?us-ascii?Q?wpS/V1e5K85SLurmdvy9urmCxP2+BWNtYQNAs3WJJGXM+mK9BG9Hq+kliTCe?=
 =?us-ascii?Q?ILTS41gdpmz0iko2CD+PSDmDv42moR1gyN+xiNAOKExjFvR8+4NYbxkoZhzU?=
 =?us-ascii?Q?K8MmaJJ8y4MwXFQ74Nc2M4G8wnaUfkyAKgeY6lOod3ieez6VF+gGW0k9RyD4?=
 =?us-ascii?Q?9JU1SIN9FNIh3wTAB9yEVnX8u/1UQvLkxApE3TAwreRT2gZkRZZLdPNAURg+?=
 =?us-ascii?Q?SL9yVJKKSfjhaj8Sr2nOdfeBRl934J0dUf+NNa7rbbm9tbHbdVrGUiwRoniv?=
 =?us-ascii?Q?svQ3wwnysGvMNpwbWMmJB3uqr7rJRRTOA8TvX3ivutRu/OfVSgmIK4x/wQ3y?=
 =?us-ascii?Q?HkTQeXxQZlXojkGFKcHeVTQCjK2yx7D2E/DCala8pqNCjVan5zLsje9XAW40?=
 =?us-ascii?Q?jfWkpksC7jv5hJn1srSGb7jRLs/xfpDDazPDtplb4De6W46zAfTymuw4WEuI?=
 =?us-ascii?Q?vpGMcy54uu8kQJsuSF+D+pXntOAdKg+qLYW1a+vg1DVRTmxmb1LwLQxpoWSN?=
 =?us-ascii?Q?WKg4aaXRNuIwUC4q6nJIoACLU2VhOTrM1EXR+g0XEpStTZnw4wHxiqLdWLTS?=
 =?us-ascii?Q?Z7PLpTanOye+ptZB4+nDVptUPxDfK7mTActGpfSzthX8jzU4TLHwLeQUrl9g?=
 =?us-ascii?Q?UIsyWSAxvM7wq8Z7FrbjqW8Yv3PUzzGtPA4x57gLliRn/UAW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7568.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67008101-1e1e-4850-a23a-08def301deb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 14:57:29.0314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S11WLdxefNj+W+OS41ydKis+MmRiRuGVhM19qBrmGE0OKzoaoW25UlWhFOaMzRUQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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

The series is:
Acked-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> David Rosca
> Sent: July 30, 2026 1:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Rosca, David <David.Rosca@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: Fix UVD min buffer sizes
>
> Use correct size for message buffer =3D sizeof(struct ruvd_msg).
> Add ITSCALING_TABLE_BUFFER size.
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 947a6cd45881..e2d0f23d48aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -918,15 +918,16 @@ static int amdgpu_uvd_cs_pass2(struct
> amdgpu_uvd_cs_ctx *ctx)
>                                 ctx->buf_sizes[cmd]);
>                       return -EINVAL;
>               }
> +     } else if (cmd =3D=3D 0x204 || cmd =3D=3D 0x206) {
> +             unsigned int min_size =3D ctx->buf_sizes[cmd =3D=3D 0x204 ?=
 5 : 4];
>
> -     } else if (cmd =3D=3D 0x206) {
> -             if ((end - start) < ctx->buf_sizes[4]) {
> +             if ((end - start) < min_size) {
>                       DRM_ERROR("buffer (%d) to small (%d / %d)!\n",
> cmd,
>                                         (unsigned int)(end - start),
> -                                       ctx->buf_sizes[4]);
> +                                       min_size);
>                       return -EINVAL;
>               }
> -     } else if ((cmd !=3D 0x100) && (cmd !=3D 0x204)) {
> +     } else if ((cmd !=3D 0x100)) {
>               DRM_ERROR("invalid UVD command %X!\n", cmd);
>               return -EINVAL;
>       }
> @@ -1056,11 +1057,12 @@ int amdgpu_uvd_ring_parse_cs(struct
> amdgpu_cs_parser *parser,
>  {
>       struct amdgpu_uvd_cs_ctx ctx =3D {};
>       unsigned int buf_sizes[] =3D {
> -             [0x00000000]    =3D       2048,
> +             [0x00000000]    =3D       3556,
>               [0x00000001]    =3D       0xFFFFFFFF,
>               [0x00000002]    =3D       0xFFFFFFFF,
>               [0x00000003]    =3D       2048,
>               [0x00000004]    =3D       0xFFFFFFFF,
> +             [0x00000005]    =3D       992,
>       };
>       int r;
>
> --
> 2.43.0


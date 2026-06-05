Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8186ACD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 11:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9F111A771;
	Fri,  5 Jun 2026 11:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MdivflXN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A807711A771
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 11:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTInN/ZvTPrD8X1AsMJ0u8Flpmz/trHK/BGYysO2lU9jWW9qJ54E/SJWUlDv5t+nw7ex4ontIeoXKlmKIaidLaHTG/71p4Ronz6uEgGO3N/N4M37HiHWyhWVa9vQIUtNKpnyKgy1JnInxJlCHMkq+Y72lr7V/hAE1KLW97Gnexlrmjbbc5+XmLATOFLF5Idcr4wLRnAa3XNMpLU5kvAMBQsN447vCOGTPetjJkPbwLcuKsI+agggFx2S2UNNJSI9QcM9SnEen8wk5ChdNRVyug1e+rDa+8PMHwyhw1Lgye5DxjHsEWqVW44HT1bNeJYrSf3oA9kRPJ2dD3Lnky2NPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP06xXCYHhrwpg8II7BPmC42vm8smdg9Im07jAXNu/4=;
 b=MGQl+avSVekHJdaXC5wae0wo25UBZ57hrh0fDTZv9sLkQlZwyA1Bz/IRMGFfM7yWdmEWlRhcctVpu6NTrV5aAAyrFZRoHKVAhqMzUz6N3DWaSCGrrP3yVIk5PBwgovQPo1aSf2kvfniA9smsn8pjX71k+sEh01Wb1ZML5zGFv9cuRIu7zh78+5x+7kKYZkCZ8H/D78SMPnEIsfAm90K5MeyNBSMA+C95iD7qAYwZMVnBxNMOW5Wtro0WPDW2/vX+ajlq5fxJTzN8TcJo4qFUZo78o9NzQF7JNXArD0VoIsPdXsSmchl/9nX1v4Cm6/0NHXUyoyQz7LnBaCi+oTLH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP06xXCYHhrwpg8II7BPmC42vm8smdg9Im07jAXNu/4=;
 b=MdivflXNbggM+rp8pTp3Vuc2SW0nVUyT1uc1dDzVfH/PnA3B7LW3lDwxgPQPfaXTti0Q4UEjLUZPXstpaaCjhAhinNLiO+hIpV8k2P1+niCllXAWWpyN3+o2WXYZ3Sb82nHISqtBYBupd15q1CD9I2RTOJ1P/3zOlzNe57vsM5U=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Fri, 5 Jun 2026
 11:04:03 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 11:04:03 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v1 2/2] drm/amdgpu/ras: adjust the update of RAS bad page
 number
Thread-Topic: [PATCH v1 2/2] drm/amdgpu/ras: adjust the update of RAS bad page
 number
Thread-Index: AQHc8wPv/6aHVdAkxUOc2+CQjN21NrYvzv6w
Date: Fri, 5 Jun 2026 11:04:03 +0000
Message-ID: <PH7PR12MB879607B77131E2EF2E87107CB0112@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <cover.1780454960.git.cesun102@amd.com>
 <9121837bc19d90122953bf4f398fd4c5d8206a1a.1780454960.git.cesun102@amd.com>
In-Reply-To: <9121837bc19d90122953bf4f398fd4c5d8206a1a.1780454960.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T11:00:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB7710:EE_
x-ms-office365-filtering-correlation-id: cbb33d29-701b-4190-84ec-08dec2f227bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 1Xb8IrS2gbiOUOLiiK3NbSSjt3MRU36aAwq/RKypduTMHwqutvX1ybqGTHJmXWDqDCY1kyC6KSyxQdcdCngxgxe+axrTjo2l2CS3bMGyGs3df0d5e4+K1Gl1w+VF/AfV+KyfjLkdBKmaTK2JHd0i6gjiqlx6jCumXSq+zdxJEQZGCgTzs3xCFNY/EnB7GRuilsEhjrAZsvrHCQ1hpKGfvi+2zd0bi9UaJAwxu9OKueC2/xg58OMBwZ6lxIDmk3U1xF5Zzvm4zWZ+DmZAYc0KmZGSKlap4q1wVWvbnPLkN2YpoU/Uv1Hpfk4PmwzsbdOrdXOD85wBlMc0CCWjN4s1kccU/xLIaodqZS+akKuZBp9Uy3fsNkeDf2mzvK1B4WppJgSDVV1QwSjxtpGMRoEV1bTnhDpEwPEBARyPMd6zFx0/g8GXBWWlNXEG7PgCnJK5ZKBClsX5uGr/vWL/Lp5SAgDnBRkSj+Mie7npJF+lRfu3VLhVtoQk2jYG1JUMcw12iYa88RsKV3Ryx5yGunqCP2/xTXIQr7Lwxj+EvxraaReunG6Z0F7HP6eghD0eJq9Eff0oxbDqtZWDwUZ7V9cj4XAjiWcyun/IaUfbmf0a9qqiUEUeDt2SsSGNts1rM3Ci1uGe/KzvkKzLejtfOnQ11Nj+L8leJpbOYG4GKPpecIkAwXfvlDjmfUssN9o3XSBoHIVCVBQjibqtiBBXDqsz3U+XMxwsMz+KfvPIE9b+H2hFIE6j8mBAzeMmWR5wweUL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8cetUeiJ+Lb5kQyfyd2YnOfalsXFPDlYb87ho26Q+In1sbWAIMbpNgu7r0EA?=
 =?us-ascii?Q?Q1JWTblFA9FbZWCR+Oj7/4zGFC9M3dtgEO46w/s6PnIvFAAKfZ6XONpBW/F5?=
 =?us-ascii?Q?7XLazwHYreXznryG02FWE+A8pc942TIAsNd2vFQmPkshC/FqoSHQWdlZsv2v?=
 =?us-ascii?Q?i4uD1dgEiYOUMaBEGvmaOlX4eSQCYeRpOt+jpwqDtEes96wHB2K8x1rZs6iu?=
 =?us-ascii?Q?+18QOBnzPLNMkGK0eWxqj4B9mdADliBHDyTphysUU6iTC8Mt4rPbNtgqSvb5?=
 =?us-ascii?Q?XzZNB60oEQ/sCE86dznup+vdPm9CGQcaOkw0UZ325oDtB8xxEQR12hnRpXka?=
 =?us-ascii?Q?4QxbRELsAAYmb4bfShx2q4mT6ZlB09ge7lAV5E7x2Kf2ibveSJqUqazMzntn?=
 =?us-ascii?Q?1Rre+YCeGrHOCteRjLk1Bfd8vvXmgNWaBw4vg3EF6IpGfeE+quF92qZ2zaKn?=
 =?us-ascii?Q?uH2qLNNDQLPDmEl66+YStxYUKvpudrjCI9l+tsHcy1Q8ZAQe/WLS5/cIf7bD?=
 =?us-ascii?Q?KNrCPjEe0sT+qmt8da2mF/U3P6Wj1Uy/h4SEPU8Sc68fTF0VWDvFzyyXPCNS?=
 =?us-ascii?Q?tk8azZXMCXjf9DtwXVgDC4hMRNxX616wbpFq3yAirXuPd2fic2zqbhwBc++2?=
 =?us-ascii?Q?7sHqJS2bZB7B1uaQuHqTpuFU3+r1xjCtSP6y5U9/szDSQtOo+K+s3cek90eE?=
 =?us-ascii?Q?qxQWFYnY+xq4RLRP9AdmVycA+86BOViwWTmzTNqf7n15xCYzIp6LzNGfeogH?=
 =?us-ascii?Q?Dmue4P0eJ2QdN+3RVn6vO9d0h1bpNWlbg0VOgqeihwVT5Lb+cWq4AwtC1i27?=
 =?us-ascii?Q?pD5Vy51YuPzsDknwS1Kdm9WLMdvh9OJHDzmfU5ttqsGGkfKeBiPv4tWBL37V?=
 =?us-ascii?Q?mtHd7rqqpwxALDnNWmJySHir0/bJy/chDwmCfWmlYvetGVEpVRZmITUUjKtv?=
 =?us-ascii?Q?9pMnK8v06aFzT+mDe96bqqsK7eXFgTPS1V/7aqyd2/epOSP3O5NMWyLwgZbD?=
 =?us-ascii?Q?TJWJAMhkLFGTD2zGfU129puST+RhPe8HRWoObQPfIK6i2B/78RebRH6pwoqK?=
 =?us-ascii?Q?Mhm7ohjYejNl+Xp4KceUTjz8Z/rBHifzJYqcZCyGOgW1Z9KOd+rNFNF4Tbbm?=
 =?us-ascii?Q?A+p6++XMg57xGBxCpBlBliaJTbAlVPXgnYBW8TpUXx+qBxDzUlBQbvoR0v9G?=
 =?us-ascii?Q?MrrefAI73bl1eX5KYJNKSaxhz/4HrwOJuO0OKO8ZFI+2P1t9SU+29aNNJPY6?=
 =?us-ascii?Q?j82/Lr7AZJQ5MSNEg0w6Atr3ahqPRUm/cGvvBF/3h2lMwFZw8sAllVnegXZF?=
 =?us-ascii?Q?NMLXtbbQ6UoPzOZwDCxxBKbesuEQSxoEgaHNgWPmQbcMJmbKARF+uEgjLLS8?=
 =?us-ascii?Q?ufGG53N8JZlCJ/qOOezJecYkX1TZDxzmJPKx1JiNU0YEtFShIS7rTvtlDNUV?=
 =?us-ascii?Q?XieTxG94NiiNLrCxjTN9GpZKBXldSWYWvvOqip1U7qPAWMcer/hJoeBGwoNV?=
 =?us-ascii?Q?n9dFFhKWbRvc6Yl5X9dU11tUQShCGhlDZEX0SUA5pMUZtrRr6XdA3hJ8CnbJ?=
 =?us-ascii?Q?DCpKNb7P/plF7RCjRFZL1ZumFAWl8XDKXQ4A45SOmSoV/MZV+85pd+MTPPRN?=
 =?us-ascii?Q?lVjJG0pupG+gBFbbCFhtT2MHgDBTJqAr+4MU5NCYfLld+JFdO/XfGMWWqHmY?=
 =?us-ascii?Q?96TM1JxgmQ7mI6pFAsUwB+VMHGcHwATbPtHf52D1DRsp9l0b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb33d29-701b-4190-84ec-08dec2f227bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 11:04:03.6638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7iILm/HI5vkT7UP9PZerU7NPwF3xHI9YSVIJiMXzTCXEbMbHElDHzU+wXmk9OF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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

As discussed offline, the saved page number can be smaller than save_count =
* ras_core->ras_umc.retire_unit since page address could be invalid and nee=
ds to be excluded.

Tao

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, June 3, 2026 10:52 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH v1 2/2] drm/amdgpu/ras: adjust the update of RAS bad page
> number
>
> One eeprom record may not map to unit number of bad pages, Correct the re=
levant
> update logic accordingly
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c       | 3 ++-
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.h       | 2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c | 3 ++-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index e5971c3dd7da..11490048a282 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -548,7 +548,8 @@ static int ras_umc_save_bad_pages(struct
> ras_core_context *ras_core)
>                       goto exit;
>               }
>
> -             RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM
> table.\n", save_count);
> +             RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM
> table.\n",
> +                             save_count * ras_core->ras_umc.retire_unit)=
;
>       }
>
>  exit:
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> index 237525b46b9b..e9e34bbdbd30 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> @@ -143,6 +143,8 @@ struct ras_umc {
>       u32 pending_ecc_count;
>       /* number of entries dropped because pending_ecc_list was full */
>       u32 pending_ecc_dropped;
> +     /* how many pages are retired */
> +     u32 retire_unit;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> index b809a2f21d73..0064e89ac1ab 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> @@ -110,6 +110,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_co=
ntext
> *ras_core,
>                       "Unknown HBM type, set RAS retire flip bits to the =
value in
> NPS1 mode.\n");
>               break;
>       }
> +     ras_core->ras_umc.retire_unit =3D 0x1 << flip_bits->bit_num;
>  }
>
>  static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_c=
ore, @@
> -166,7 +167,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_con=
text
> *ras_core,
>
>       idx =3D 0;
>       row =3D 0;
> -     retire_unit =3D 0x1 << flip_bits.bit_num;
> +     retire_unit =3D ras_core->ras_umc.retire_unit;
>       /* loop for all possibilities of retire bits */
>       for (column =3D 0; column < retire_unit; column++) {
>               soc_pa =3D row_pa;
> --
> 2.34.1


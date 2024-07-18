Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A2DC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 02:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDFA10E355;
	Thu, 18 Jul 2024 02:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hyVaGgL7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A173210E3CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 02:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwnmWAiSLelCAQAXsNpejBnsQ/VtEOK5NEQxFiTmPEK2tQ9zMQnq0T/RRW9imTBf2yVWBtOJpUbOvht29RCYuLgGV44RH0u0Ae28+b1J1DpVyY0Qr930uvC2esAjdRIVFZ2Fvh6cjicbQpODdKMyLh7r8j1Ee7FoLUztQ4PI8cs6Mf/j7AyruepBgU4rkA+dw4h9y8qv/tobaL8lKiynqJOASuMitpmAHZAsqr/DouvT4bxs15/oymBX0KRbMkv3VLxdNZT/vEOElu6KQtRQGan0fT7KlvCXL4yDhS+gzo4ZVrCANuhFbEFhZFoIniJI3/5+UP2kMv+g6aIPA/O17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJWd7HjXgho+uchX1ofPY7tJe40IMbHyMmCNQ0Hjya0=;
 b=ptNqPEfsWxYdus56dvVIzHYcb2iysbryhXklN06RDHFK0et/vyEQqR5a6YxINvObegcJJdeojkrK0dnEQT6OMcT0VcPW4ev9nD/6wbBSqAa89lFcA7iuhatlrY4rjmneBPy52O04QKV+QjPDaoBgFfztBdoU9L8MUW8c2E9IgZPat0E5Bxk+WejS/dXlsFGqkhJU0wHcBZyuN+tGYd+zpoere5rHGPp+tNN6oFeG3DBzNeZsbz/3Qt1hkIpApMxkQ5tz3zo9awxQN4NahZ0BLJn4xL7LE0qhDzAJjqPff8721B2ZL0x7wdcElw80b471iOkRTSCYmWEvmdqZyD55YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJWd7HjXgho+uchX1ofPY7tJe40IMbHyMmCNQ0Hjya0=;
 b=hyVaGgL7yNLPP575i8n2oNhRKjbruYd/pZEe9m3qgP7M9o1RzY2sCiXnvreGLbvwMi+LdK1QyLp4A9Lwujx/GeES8k30KyjSGlr7K4jXIKmQ1TcjMQmWd0z7Mcgt3tsFyAem8xb+0/pW65PCYSYYTEaGf3+0yLeHkM8HctzrloU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 02:57:15 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 02:57:15 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Topic: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Index: AQHa2CGZzRuewd00l0aepnpp4M9IJbH7y+rQ
Date: Thu, 18 Jul 2024 02:57:15 +0000
Message-ID: <PH7PR12MB87965FE14B4B083B38E3CDBDB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
 <20240717081547.224193-2-YiPeng.Chai@amd.com>
In-Reply-To: <20240717081547.224193-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c3021fd-db53-4b87-840f-056fb3730b62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T02:56:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH0PR12MB8507:EE_
x-ms-office365-filtering-correlation-id: 23c1e129-412d-4cee-ec11-08dca6d5547a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QF+NjSlpLBs7zDRy2zbHs8yuIBLPrRK5C4MZsNOpl2XUtv2UrGjQw8am8Aer?=
 =?us-ascii?Q?0RVNpNGnRZRFFFs9d8ksmBNlu2fDUGg8BL4ECgDjpYf3w8K6dy80PWX/NBDh?=
 =?us-ascii?Q?SAW6GjXg4IKsb3skEmxeI/M/rYSgN9ZujrDzf9xAHYx4E/n40nksQhEvNMRp?=
 =?us-ascii?Q?nBPhJH2PFj2/3fcC9mZPmTZo9d0mTlQEFVhXh8wVLLUU3ymbteAK2Gz7E6Ew?=
 =?us-ascii?Q?A7O+ek8aSsTqp8bd01xERy1PUpH0toyXvn4kfBQlFN8FemV5XgeXILnFU0pv?=
 =?us-ascii?Q?Rm03HOSKZr5DitY7W2CML7mQO7IDOxBvs8ztnaCwebPLThnOn/c87x4yk9WS?=
 =?us-ascii?Q?EGMKaf7UgpSgW1bUIIZwTRZAqzeZ/J8PfOBoFJ5S/QwaxNmYmGMudt9uFpyM?=
 =?us-ascii?Q?fSZ5NL5RJZ88nTr1MRjPr9jfjOg0UTAINdTGTg0GEOyZwRiEdtUcegBJx8hA?=
 =?us-ascii?Q?NK8gYeGbm1PMkWpjzl2eRNzFYe73bfYx6ISID5aaJDAi7fj/wwJCsglt9mMt?=
 =?us-ascii?Q?7s6qaDz1mSwmT9E488nmUwUV1JKhW4k2g3AFK/MzFjg3f5zl9w3Mz6ftdw+E?=
 =?us-ascii?Q?JpeezflT6qmCN2yHHxgzQ19s6vU5enEuktVZbrJEWhrz7rDpWqaATbq6e/BC?=
 =?us-ascii?Q?CTfTm3HUliEbxxkF5rSQL+eqfWByu+jbR6GelDQ2hPENbJyv+lkqJoVLaQtm?=
 =?us-ascii?Q?Xtdo+3C8z/TjrASlnTGxgtHp5ifXDyGf9Fq3wRoLG+Dc0icBdZqpw7Hlx9M2?=
 =?us-ascii?Q?RpcoepgZ6Kt7/xmWjJTVn8TH5YDSe1LKcwAj2Uwx5udKJJaoY25xDKMoAUYp?=
 =?us-ascii?Q?t/cYlFU7WOQzyCLqnpSPRyb4u7kAM+qSHMq8wE4PcrK45CF2wjzfRrre3qiU?=
 =?us-ascii?Q?1WtNc2UcuEcc6FiSwnCBY9crIxvX9rYz31+sGAbSRTbCVCXTsjfJvS53B+en?=
 =?us-ascii?Q?W/+/Efz2lvsAxP6IX2Fhr4zzxSTMMyzq7OBTb4ZGcqe9Q90NJTlgoKyWeZw8?=
 =?us-ascii?Q?6kQvewmS0TOOke9Pihc0KoV5D1OjBbkNut1rCwOMLwDv3IrgUNtUlveoobG4?=
 =?us-ascii?Q?p/ASGX5i1akZGQH4pKd/+V6ppfksbAjm8+w2OyYI5Zo/7cDmK71pb+ASc38e?=
 =?us-ascii?Q?ZyU7b8cASbyJk1qErwllhCBD4Bb7P2e3Rlo9XSFyG6t9FYG7vSXJDn0rB4Wq?=
 =?us-ascii?Q?UzZL97mhnyMphcFE3uGEqLRzHSsADSsO2yHQxwoXSaKmgnZqpMrsh0GdmAVB?=
 =?us-ascii?Q?fBZk0Gy654E/N+j+Sa3oz9u4fjklMT6IIk6IaF6yvdkd3pn5prwSWBptosvy?=
 =?us-ascii?Q?f8IC7IGHyEswN9hV4ywbt2ajYMPofUWMkyoLWaMaKQGZHAi1Qo48UYFMaXqV?=
 =?us-ascii?Q?GI5/Jvmu76Rfpxgq+XeztLBq/+yy0diFk1NkpXgt3n3h4fv9TQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3uc0QmKqHym6/tGlP83FyQ4eeLFOAlQpFDL1/lbnjsKtoEXityyXYQGYFPaI?=
 =?us-ascii?Q?vhLtZbRkE61pbd6PmaxZeN7SPg6pQu6/poZjn2U5l0gjgeVzmdg+/sjbUeSQ?=
 =?us-ascii?Q?siN/dzO5yNCU63jbtYFlz2M9A113K8TFCDJmCd5bBPjCoC9vUmTOaemr6N0J?=
 =?us-ascii?Q?b35FPi4L/p6I47RTwSk/isrmy8lebsw4LiAhwwIMr+wOZbZ1AHWchCdsUZnJ?=
 =?us-ascii?Q?XbLNyXS5mVQi17GdnxG0Jd1e+4pngkd0DC8h3UQU9V1eUcFdekOr2jQhRWgV?=
 =?us-ascii?Q?Ury4BeolI2qbidRs1VMvllUzhCxKxKu0GkgD2VszWCgflnUrxabMRWgLVGt1?=
 =?us-ascii?Q?iWvu1QQJQNgklU1nVYt6Jb7JaD+xq2dPJ7CnqBMIDYbMpJSlqQXa5tkCBENz?=
 =?us-ascii?Q?hWxeSpKlRpCBPp3ile0gjc9PMhI6iZhEJzB4XtnjRABOsrMGZMLE5Oha+Yph?=
 =?us-ascii?Q?STt73K7mIvuGXjHKgE/Y4Be3it0x5QEhK2rp1wVMmDaSNAytKdV28jXA34Yi?=
 =?us-ascii?Q?KlI/SLaQ+v8ntZQcsEJe/a6R6b3uPaqBJKl3AvdvJxsp4QydjN1LAy0iwFxV?=
 =?us-ascii?Q?gK74L8I9vmkt+/+hki5acqRUbgEC4KXgapqGMj9fq5zxsyOmj6lAvBiE77Nx?=
 =?us-ascii?Q?hfecFLc4jKLDb27HoFxhkKAo+DR6Gvf12x3qNN8y5biHckALj/IYXesw1BDa?=
 =?us-ascii?Q?oYB/0tJybeaZjtKaCRHQan3lRXv4Nd5J3GHi39TCmkGTW3ofXQcMPH5dJxWi?=
 =?us-ascii?Q?OraeM0KrBHZgB+3481UswL5KIrSMrNapYgorEYwgo70kiNP8n3jTO3maF3P5?=
 =?us-ascii?Q?zqITor9Shm9YZtj7M1XMTg5WHusizOM2PUdbW82EJyRi/Ar4YlX4s3MQqg6n?=
 =?us-ascii?Q?5JBLvUrVOlk/5TZhbQPCTecXgbN9fCCNIHmSnKQkzCFaXULRPDpIKryTVxXG?=
 =?us-ascii?Q?TYQVKCTSXHQp2o014Y80kiT8dYhNPd18scHtXxlsfFGMZ8bBqEPA5hBlSn5Q?=
 =?us-ascii?Q?jfXGlCW2A+dffFOUuCbOAtGrMBXaT0Uv9aXrFDaLwoAcpPAzuDhL3OxLt4oO?=
 =?us-ascii?Q?ik+fiRWa/3z4Zt1I9ny4tRDoN1dsY21ch4uVwvg0Ka+R4lPpkXMRYj3BqjaY?=
 =?us-ascii?Q?ULZ58N5zBdARQmmLtY2o1GCb+ky0AUKDzO7+pn5cDV9GTU0qZsEMTq3YfxVW?=
 =?us-ascii?Q?SH7rxeArAFyaJJi5p/pJ4l4a5ebQDXzU+dtKNBdHW9EekXqeBrRf4d9MO5je?=
 =?us-ascii?Q?xhhTCxzPDZ9GJiOTxvwJ1T3xbL9aiydQL5PAx5AXQmNlmwa2oqMYTVl5gYnR?=
 =?us-ascii?Q?25N2S5WRcjQ4/0xJhE79UVKtKxW3OcY7DzamQ2H7eyxgCNcwcuP+kuthhEXR?=
 =?us-ascii?Q?wBCU0l3daTYql9R3gQ+DPa+CuHbhGQttdq4YXGCC3WXA/dBdm+YlvOVwhORb?=
 =?us-ascii?Q?wddgGAG7mvGMyvXs9EXKtoczvFMSg0ToklzttvfnTBPTogNIYECoDiz3GJyt?=
 =?us-ascii?Q?o0jye5NK0yqD+yILc9wN91+hVhnNtZBdH3Du2OHC4Cj8bVJRcTDR3yUn54mt?=
 =?us-ascii?Q?Oak8vNNitYKueJKpWt4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c1e129-412d-4cee-ec11-08dca6d5547a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 02:57:15.5058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIx6OoeV+zZcaBmqsE4DC0DSTPtyyVOSmgBRhQGD8OAPUmsUJea+tSeOsyDgU5Dt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 17, 2024 4:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
>
> 1. Use pa_pfn as the radix-tree key index to log
>    deferred error info.
> 2. Use local array to store expanded bad pages.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 14 ++----
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 65 ++++++++++++-------------
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |  5 ++
>  4 files changed, 40 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index dcf1f3dbb5c4..f607ff620015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -476,10 +476,10 @@ struct ras_err_pages {  };
>
>  struct ras_ecc_err {
> -     u64 hash_index;
>       uint64_t status;
>       uint64_t ipid;
>       uint64_t addr;
> +     uint64_t pa_pfn;
>       struct ras_err_pages err_pages;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 5d08c03fe543..2fc90799bf8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -523,18 +523,10 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device
> *adev,
>       ecc_log =3D &con->umc_ecc_log;
>
>       mutex_lock(&ecc_log->lock);
> -     ret =3D radix_tree_insert(ecc_tree, ecc_err->hash_index, ecc_err);
> -     if (!ret) {
> -             struct ras_err_pages *err_pages =3D &ecc_err->err_pages;
> -             int i;
> -
> -             /* Reserve memory */
> -             for (i =3D 0; i < err_pages->count; i++)
> -                     amdgpu_ras_reserve_page(adev, err_pages->pfn[i]);
> -
> +     ret =3D radix_tree_insert(ecc_tree, ecc_err->pa_pfn, ecc_err);
> +     if (!ret)
>               radix_tree_tag_set(ecc_tree,
> -                     ecc_err->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> -     }
> +                     ecc_err->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
>       mutex_unlock(&ecc_log->lock);
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index eca5ac6a0532..f2235c9ead29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -524,9 +524,9 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       uint16_t hwid, mcatype;
>       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> -     uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
> +     uint64_t err_addr, pa_addr =3D 0;
>       struct ras_ecc_err *ecc_err;
> -     int count, ret;
> +     int count, ret, i;
>
>       hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
>       mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -559,39
> +559,18 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device
> *adev,
>       if (ret)
>               return ret;
>
> -     memset(page_pfn, 0, sizeof(page_pfn));
> -     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> -                             pa_addr,
> -                             page_pfn, ARRAY_SIZE(page_pfn));
> -     if (count <=3D 0) {
> -             dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
> -             return 0;
> -     }
> -
> -     ret =3D amdgpu_umc_build_pages_hash(adev,
> -                     page_pfn, count, &hash_val);
> -     if (ret) {
> -             dev_err(adev->dev, "Fail to build error pages hash\n");
> -             return ret;
> -     }
> -
>       ecc_err =3D kzalloc(sizeof(*ecc_err), GFP_KERNEL);
>       if (!ecc_err)
>               return -ENOMEM;
>
> -     ecc_err->err_pages.pfn =3D kcalloc(count, sizeof(*ecc_err->err_page=
s.pfn),
> GFP_KERNEL);
> -     if (!ecc_err->err_pages.pfn) {
> -             kfree(ecc_err);
> -             return -ENOMEM;
> -     }
> -
> -     memcpy(ecc_err->err_pages.pfn, page_pfn, count * sizeof(*ecc_err-
> >err_pages.pfn));
> -     ecc_err->err_pages.count =3D count;
> -
> -     ecc_err->hash_index =3D hash_val;
>       ecc_err->status =3D status;
>       ecc_err->ipid =3D ipid;
>       ecc_err->addr =3D addr;
> +     ecc_err->pa_pfn =3D UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >>
> +AMDGPU_GPU_PAGE_SHIFT;
> +
> +     /* If converted pa_pfn is 0, use pa xor pfn. */
> +     if (!ecc_err->pa_pfn)
> +             ecc_err->pa_pfn =3D BIT_ULL(UMC_V12_0_PA_R13_BIT) >>
> +AMDGPU_GPU_PAGE_SHIFT;

[Tao] why address 0 should be avoided?

>
>       ret =3D amdgpu_umc_logs_ecc_err(adev, &con-
> >umc_ecc_log.de_page_tree, ecc_err);
>       if (ret) {
> @@ -600,13 +579,25 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>               else
>                       dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
",
> ret);
>
> -             kfree(ecc_err->err_pages.pfn);
>               kfree(ecc_err);
>               return ret;
>       }
>
>       con->umc_ecc_log.de_queried_count++;
>
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             pa_addr,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
> +     if (count <=3D 0) {
> +             dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
> +             return 0;
> +     }
> +
> +     /* Reserve memory */
> +     for (i =3D 0; i < count; i++)
> +             amdgpu_ras_reserve_page(adev, page_pfn[i]);
> +
>       /* The problem case is as follows:
>        * 1. GPU A triggers a gpu ras reset, and GPU A drives
>        *    GPU B to also perform a gpu ras reset.
> @@ -631,16 +622,21 @@ static int umc_v12_0_fill_error_record(struct
> amdgpu_device *adev,
>                               struct ras_ecc_err *ecc_err, void
> *ras_error_status)  {
>       struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
> -     uint32_t i =3D 0;
> -     int ret =3D 0;
> +     uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> +     int ret, i, count;
>
>       if (!err_data || !ecc_err)
>               return -EINVAL;
>
> -     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             ecc_err->pa_pfn <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
> +
> +     for (i =3D 0; i < count; i++) {
>               ret =3D amdgpu_umc_fill_error_record(err_data,
>                               ecc_err->addr,
> -                             ecc_err->err_pages.pfn[i] <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
>                               MCA_IPID_2_UMC_CH(ecc_err->ipid),
>                               MCA_IPID_2_UMC_INST(ecc_err->ipid));
>               if (ret)
> @@ -674,7 +670,8 @@ static void umc_v12_0_query_ras_ecc_err_addr(struct
> amdgpu_device *adev,
>                       dev_err(adev->dev, "Fail to fill umc error record,
> ret:%d\n", ret);
>                       break;
>               }
> -             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> +             radix_tree_tag_clear(ecc_tree,
> +                             entries[i]->pa_pfn,
> UMC_ECC_NEW_DETECTED_TAG);
>       }
>       mutex_unlock(&con->umc_ecc_log.lock);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> index b4974793850b..be5598d76c1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> @@ -81,6 +81,11 @@
>       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
>        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
>
> +#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
> +     ((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
> +                     (0x1ULL << UMC_V12_0_PA_C4_BIT) | \
> +                     (0x1ULL << UMC_V12_0_PA_R13_BIT)))
> +
>  bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t
> mc_umc_status);  bool umc_v12_0_is_uncorrectable_error(struct
> amdgpu_device *adev, uint64_t mc_umc_status);  bool
> umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t
> mc_umc_status);
> --
> 2.34.1


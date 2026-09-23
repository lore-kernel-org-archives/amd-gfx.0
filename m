Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A615C982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 10:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CAC10E0D4;
	Wed, 23 Sep 2026 10:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fG0OVADf";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57E410E88F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 10:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRhtnwoVOPgTvaxT+QKOLC7V5xTO8gCXwmN/eXQgoWib+oV+hVZzILxAUD4gnHHR1Kna6TZ/Vy5lif5S47V5mZpeIbgyOkwrv+RhPnnP3sOjFNmrfJMn7jxTSrmusVnI1JcYqhktZ4pm2N2ghcsirEGmNaGQFmf1BdkAi7PNH6YX6MceVCRFe6vS4uQhqwprs9etquF8OJVRQ7MHb5+olLlYA1Uoks7HVgG/zF6MoC9fvCnSjIp6hyieUm/DcLlAcpX7Um66ZShgk0bQyN0rf/EbliDeSBJWrPEanyOTwcjBaqV4cW8lcdTS+U7l8yPC5i5hqToHOhfgDvjCFT7+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFzLWUhBCWExKTO3v+Um9KXEMHskEvGRLhp6mOjBFWo=;
 b=hpf2EQJOodfivNC6vGjv/kL1tG4e1hicYwwr2pcaE46rnuq+5yeM7gW6XVqSusnk3NHjZKvLiE24T505hRtoxLQSKIOfm68kj7c6Rm7BV2BWNFg2PfZ3jQM4igtewHBG89DQ2FLCtIEb+2jogUOz3hxxyPhBb2qilkXy0uc8L496BqoAg691uA7S8e3IaylUQYZTEC2C5glIh7GpxP8rgNCZnFDzFnDHQkeOQW41ioYifSLyycqQUwAKigbtruAkWp8DndrljeqtAqX3Fjo15W3xCJ9GlbhRlYBM6FDsnKzNOtQITWuDkylyJN492bM5EeP7SUszGltpVC16BV+57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFzLWUhBCWExKTO3v+Um9KXEMHskEvGRLhp6mOjBFWo=;
 b=fG0OVADfZpsu/XcYaknlD4e8IpRY2YXPC7wZXdjSnwgrdztVmcOEo/NhMRW4dzm1ZajFKAndWrEeNSHbd3aLI1D2L26nc0ZhaURPYnkjvCUX9X/kZZ2pgJeP10eE3qxFX2tW1JP7F/7iM1y+CQDhHMR45R0NkbPAY+7BOLNBO5U=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 10:11:27 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 10:11:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras : Update psp 13_0_15 ip block support for
 uniras
Thread-Topic: [PATCH] drm/amdgpu/ras : Update psp 13_0_15 ip block support for
 uniras
Thread-Index: AQHdSz5k0t5xJUEs5kiI8cfynV+o0bbb8TEQ
Date: Wed, 23 Sep 2026 10:11:26 +0000
Message-ID: <CYYPR12MB87293807BD650849BDAD8275B0822@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260923093139.140456-1-cesun102@amd.com>
In-Reply-To: <20260923093139.140456-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T10:11:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|LV3PR12MB9257:EE_
x-ms-office365-filtering-correlation-id: b33a1031-aabb-4fdf-7a80-08df195b07a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: x3jPBey9V4TkgUEnB/lNibGsK9cM6PkHzRjxfHJbG8C0BmKGz1G3V8gYPusG806fk5qKvItt4lb1dudF8r5qNCsR6yLSzqYpsquysYmojrlLlHVmSdsn1robFofx06LRxoFJ2krS5rNIXlH7s82vkGoYKeUdDBG5oJ/iwccSIMJWokWgeq2EjBNpscS1uVORtJ5rzfiWIsFgloH5HWBBZi889T2n6PHeLmrZ70EqD0gdil2bp2YsiEBM3h7yeF2gW+/AjmQMsNkH5ZZXPz1xS+eRtGnek3sRyZOjLP3+geaj8yIeDjS8nMSr+Zx08a4mY7A/1jW/QU+DEJUgQPXJCYUjee8AeawzESBJE5jmuKp18HE0gG12r1/phOfSPqEpGYWYCnbuOUEuJ1F+03Ju8w0DomXb1eJPC0HkRqY54KCNg4s/zQo4lpfFVtzubwdHQOe5areMb76AjbbamrHtMmU4YMEOZwGzp0UGFxJ3Z2j5yO0DlRu37gbCrTjZZqRkW1sOjDc/bHoVXU8RHdunMnIb6fM3AcGUM5NysSkZ9f4qZz1Ws/8h5+qnIgMwkgF1B+FwvtBd9ojfAgLJh1RRDS9jx19TW1pNd83bnrM+qXQAnIW1WpOA8jDWkruEzZGG6olgN/nBNut958n2DuOh4ddzGGkJdqn5rBXLrw1KWZaOX4dJ9/lLd2L7I9Eox+x2/k3B9C1MYPi2B6sDI2wS53up4GIa5oud+7KcK6M73rg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VFpfwJJVpqYHoGZSLSRW0DDmQn5y1uNHtK7FeQfx3rS8HNNuHI7Jw3Yk7Udc?=
 =?us-ascii?Q?lIHBpnk3ADkL9Mi8Hicx80SkxQgfvDjDD7+/PowtVmpWXuxP2ne1U7j5kGIO?=
 =?us-ascii?Q?QmHRjhSthaTydOQ3jefp3kUgxdhkeY/48J3w5Sfix4NDb00fpjoGGwn4zqBW?=
 =?us-ascii?Q?UmopVqCurVNw479bLrFwQNl1GwSnWWQuUNgWlgp+3ePzQCUYtjrhPYPLn2bX?=
 =?us-ascii?Q?WrlIO2QPMmVIbwUByYq48NW3Jrfwa7vFf5H9THdnfI9OC1MbIoSa9LVJ43sQ?=
 =?us-ascii?Q?uMzBU09Fz1gsjqTtfpJzjz+dHJihgpM2glqDnNEDybj5N3IiJNDds52ypN6S?=
 =?us-ascii?Q?Zf1m+MVl1cRdeHBe/WNOXHmElpaFVILmsG/ae+4A2DoAC+JNIGezaG5k9hkP?=
 =?us-ascii?Q?RfBh6j9FadFrVR/t0gdBQliMwz0pmNgQHuRHWxg2jpPg9s8/l1CvyaggvZ/I?=
 =?us-ascii?Q?xYt/UMXS3B0D/GFvEVoyH3//x0nISnYsujnAlkTOjET6VpcrVeGGFQ06Q9tN?=
 =?us-ascii?Q?nifGqeiSBgCmkCrAhk3XtbyxiVO3Fo6sYUmRHnoRV5iSNjcMNh1b+yMKyvJc?=
 =?us-ascii?Q?m1li8syr6aGd4nj7MmP6y8SEvK8jWUH73jYhzZjAHFWPJJxrB9ChPqakd35N?=
 =?us-ascii?Q?rhIe4mIIbmru2wCfdjdKUvq8y7tpvom1I0Ia6su0KMM9nOGGOuJ73RTsJ1w4?=
 =?us-ascii?Q?GGVT8QEUbldl0/VyO8iatGM93tx4fo0AVhL1NdrGJjG6YyU2A4yP3X+u2RG1?=
 =?us-ascii?Q?Gtm65haPcVg40Tt6qrsc4x+Ul6rODcoaCXRJ/+fRL6HyX26cgZnvSRBv2M/6?=
 =?us-ascii?Q?AY2SPAIgrxqOXOlvTsaMSUX3eVJQrU3Y7sCQ8SYf7ilfXvERqc4Ce+4fFgIh?=
 =?us-ascii?Q?EJ5yWlIVdk3EQrNj2O9VI99laA47JAmZ/KDdgOCUA+oDMYDYNlTYHsRjs6D2?=
 =?us-ascii?Q?KxelLdbb/7vEfZIpJHWgxWAiXJaxQqV9aUQuPS97syD5wTQNQfD/bU3F0KH8?=
 =?us-ascii?Q?ox3TxNjVAsgOQLOTuR8Sf7TV+AmZfMDQOo78e9brNWAT4fkc37MjcP//J/jK?=
 =?us-ascii?Q?fGomENVNiMvRLy2whWSYad/uprEo4svOnvjhGn9HEo5u+s4i9raKlU6rftpW?=
 =?us-ascii?Q?CMJH6EQcpxxIevdOL69t5QTu3v8zOnIsdtrFiSp1gYKuRwI2qAsKRcKFYZVN?=
 =?us-ascii?Q?vXORnpj2nD3aT4SjbGWwCB9nBBlBdIwX/pyTTtxWM7pxd5Tmyr+iCRnTK9B1?=
 =?us-ascii?Q?EgccHQP/pA3sMzS8r1MsX2YRzXamuSo2QOuuX/f1h+gbpf6HT8ZTDqWhHtpn?=
 =?us-ascii?Q?mAiV+57RP6T64qp7mMk1XypgjQHCNOo6ngikJCE7fTGz6a9bFk7ZzaBMl+Y5?=
 =?us-ascii?Q?hY2fAFyRsw8IU82CXLUHrd0QoVcLfk5Ou0215q/jAwGzuqE4uHBP3imj4Asm?=
 =?us-ascii?Q?u+3u1hok1AKfN9yLFwUj1/v64IoJAP48ObWUjR//ow/YKhEQcV5CWUWrO7KS?=
 =?us-ascii?Q?SQ2+EMm+eE18HqaRlREjehodp3OzguUuSvefH0evIrGv+P0jhPV7/QltoxBK?=
 =?us-ascii?Q?gVeRp3j0+dGLhbeEljenPpTODyli4gf9tEYFeKhsRKpWKlGLjaHAQ7jpe7IN?=
 =?us-ascii?Q?lpouzx3mg0DLPmTlXwFHfrHP+aZcZJxoOXvEMV41Qbks3GreZ94dSPbb2dDh?=
 =?us-ascii?Q?TfwnjIAPLufCL4lTMcMLF4/ZYqeJXvCcgnLG9lUujZKRmYC5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a1031-aabb-4fdf-7a80-08df195b07a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 10:11:27.0529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PD9s/J18kQgQdfc8vPG1Pw7OLcGKmZ4GkYZb5skujinYT/ZNbxY4PfsFLkWXGtm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, September 23, 2026 5:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu/ras : Update psp 13_0_15 ip block support for=
 uniras
>
> Included psp_13_0_15 ip block for uniras
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c           | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                 | 3 ++-
>  drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c           | 1 +
>  drivers/gpu/drm/amd/ras/core/ras_mp1.c                  | 1 +
>  drivers/gpu/drm/amd/ras/core/ras_psp.c                  | 1 +
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c | 1 +
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c        | 3 +++
>  7 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 1420bb60e015..69a998e09556 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3130,6 +3130,7 @@ static int amdgpu_discovery_set_ras_ip_blocks(struc=
t
> amdgpu_device *adev)
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 12):
>       case IP_VERSION(13, 0, 14):
> +     case IP_VERSION(13, 0, 15):
>       case IP_VERSION(15, 0, 8):
>               amdgpu_device_ip_block_add(adev, &ras_v1_0_ip_block);
>               break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6b2b8acdbf9b..47e852c15c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3822,7 +3822,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device
> *adev,
>           ras_obj->hw_ops->query_ras_error_status)) ||
>           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4) ||
>           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
> -         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
)) {
> +         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
)  ||
> +         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
5)) {
>               r =3D amdgpu_ras_sysfs_create(adev, ras_block);
>               if (r)
>                       goto interrupt;
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> index 1781d037ef13..fe0e35357af1 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> @@ -41,6 +41,7 @@ static const struct ras_eeprom_ops
> *ras_eeprom_mgr_get_ip_func(
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 14):
>       case IP_VERSION(13, 0, 12):
> +     case IP_VERSION(13, 0, 15):
>               mgr->eeprom_early_init_service_supported =3D false;
>               return &ras_drv_eeprom_ops;
>       case IP_VERSION(15, 0, 8):
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> index 4c180027850f..49ce6ec7993f 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> @@ -34,6 +34,7 @@ static const struct ras_mp1_ip_func *ras_mp1_get_ip_fun=
cs(
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 14):
>       case IP_VERSION(13, 0, 12):
> +     case IP_VERSION(13, 0, 15):
>               return &mp1_ras_func_v13_0;
>       case IP_VERSION(15, 0, 8):
>               return &mp1_ras_func_v15_0;
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c
> b/drivers/gpu/drm/amd/ras/core/ras_psp.c
> index ed53cd25d6bd..23ceec04a82a 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
> @@ -46,6 +46,7 @@ static const struct ras_psp_ip_func *ras_psp_get_ip_fun=
cs(
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 14):
>       case IP_VERSION(13, 0, 12):
> +     case IP_VERSION(13, 0, 15):
>               return &ras_psp_v13_0;
>       case IP_VERSION(15, 0, 8):
>               return &ras_psp_v15_0;
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> index a56d3116c5fd..5f550abd8dbf 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> @@ -121,6 +121,7 @@ static int ras_eeprom_i2c_config(struct ras_core_cont=
ext
> *ras_core,
>               case IP_VERSION(13, 0, 10):
>               case IP_VERSION(13, 0, 12):
>               case IP_VERSION(13, 0, 14):
> +             case IP_VERSION(13, 0, 15):
>                       cfg->eeprom_i2c_addr =3D EEPROM_I2C_MADDR_4;
>                       badpages_per_record =3D
> BAD_PAGE_NUM_PER_EEPROM_RECORD_V13;
>                       break;
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index eb5722a59786..109c47eb002a 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -141,6 +141,7 @@ static bool amdgpu_ras_mgr_eeprom_is_supported(struct
> amdgpu_device *adev)
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 12):
>       case IP_VERSION(13, 0, 14):
> +     case IP_VERSION(13, 0, 15):
>               return (adev->gmc.is_app_apu) ? false : true;
>       default:
>               return false;
> @@ -156,6 +157,7 @@ static int amdgpu_ras_mgr_init_mp1_config(struct
> amdgpu_device *adev,
>       switch (config->mp1_ip_version) {
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 14):
> +     case IP_VERSION(13, 0, 15):
>       case IP_VERSION(13, 0, 12):
>       case IP_VERSION(15, 0, 8):
>               mp1_cfg->mp1_sys_fn =3D &amdgpu_ras_mp1_sys_func; @@ -325,6
> +327,7 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct
> ras_module_param *
>               return 0;
>       else if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 14)
> ||
>           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
> +         amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
5) ||
>           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
>           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(15, 0, 8=
))
>               con->uniras_enabled =3D true;
> --
> 2.34.1


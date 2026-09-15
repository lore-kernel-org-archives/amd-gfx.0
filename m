Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ED6C88E7F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 15:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A54B10FA3A;
	Tue, 15 Sep 2026 15:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1Dt0wvM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295B910E2D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 15:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mibwFMUpeLN7Ktvbu1fkGEImueufzocbxG9N6w3Z2QLRlsTrCpw12V1lkaIVbIX0Eafoy/++XDoSj6zKKysW9+QTsgAR8Pc8d1Y/vSKWXoc+6s5L/xh7DJT8UFSAgrafOOn2fr5oWSjqiSQhzvfGl96gaRV9+bYCccMVxSWF+QbnVsTMMJUijss2kzMot/uYt+A3Y32/ppnBp+T9TJTgWxx43QELBXk0wqDrQjnxt/ZiM6aVaTNTbBhtlllOtXTs/csrw7oTtRjCGUUAK3bQoL857JVnx4fx1lgmsF0H6bmtAneY2bisXdPlBe8mYBXgzQWShp6rzKZA6TxxP4PGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwyLTiYlZPzXUC22tccDiE1ArDgfKj3QiTPkSL0zsHs=;
 b=mqpeLDrgczhBFxepyz2RPrbbQyVi/jFbZTyDKDXuGFDxWNAhCSUqh1mI+Ppk1xFuskZEV2Hry80y5cjL1YqtazADUddIlE3HIoiwCXuT3zfAnxtK0Hefi0saGwAwp7xB6atNCz8PVqpY7GVYyx1RQxbZEp7/1Uglfs+4tHDWn5mkAu0Y82+bsXJkev1BAxy2mVRLx3duLC5SLRUkfgZPLNb0/hdXywrasBtm7ydUDFr9D/C5kgRrOx7GSfkGR/lGvpDU9XX2Blu/g6of+hgEUTBdhYqBgojQkIjMZ7bChShZ4ez9pXwMKwpcPPf536CKrds3MU3UJEOhOd0Oa4wscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwyLTiYlZPzXUC22tccDiE1ArDgfKj3QiTPkSL0zsHs=;
 b=Q1Dt0wvMc3pQdN5rZ+mifIn/XqrKHVg8Psmce4UhmHqqWqb0TE3hBg76skgs89ehqH6WBMCnbPGbxd6TgLlfH7tljCfiuKhOofEJAUbznTc2WARAEchy8WojN/tOwDpwwWUEOyA8t2e/2ij40o0OB6ziAQxlsTMXSw5UoiM8diU=
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 (2603:10b6:510:3da::21) by PH8PR12MB6985.namprd12.prod.outlook.com
 (2603:10b6:510:1bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:03:31 +0000
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766]) by PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 15:03:31 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Francis, David"
 <David.Francis@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Avoid integer underflow with ffs in EOP ring
 size calc
Thread-Topic: [PATCH] drm/amdkfd: Avoid integer underflow with ffs in EOP ring
 size calc
Thread-Index: AQHdJOMMt5bN9vZjT0u9y16Qw0ud+rbP/O8A
Date: Tue, 15 Sep 2026 15:03:31 +0000
Message-ID: <PH6PR12MB345224C8DD50FBBDAF2F0F350685BA2@PH6PR12MB345224.namprd12.prod.outlook.com>
References: <20260805140153.612765-1-David.Francis@amd.com>
In-Reply-To: <20260805140153.612765-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T15:03:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH6PR12MB345224:EE_|PH8PR12MB6985:EE_
x-ms-office365-filtering-correlation-id: 405d1eb7-c241-4b21-28ad-08df133a81ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 8gjUNq+NA0e7/MpE63VFZmBah3aMKfn4ZTJM4S9ZNeDMr0oj1PFG2QijcdMOEgNmvPB8bBq0Wrn/17FRm84WtmWXNqVBw4C5stYAHzmXA+7IjL8u6LKTVodrs9eajZCx4Tk2yVuCEb8Sk+gA7f5L0SpvsRXeqLb+aqH3c7R78XohW7H4OQF6bzqkIqB3R+RgEsb6RxSIZl14uFOdoATs8fClMTvQ3iNMgZ+c4LhXszCZPLlRbLNLWdiWF21rAbIfgFMvFGlSZ/VxyPHxJ1YVmC/axmiUlJWjcLBubP8amdzGP003c999iXVXes3agtIgIEtAE6OxosrhCLMASrDivMG1teioFjuq4CMH/V2bZbVsnKPtkrOxLyQr1azGBk/TdOf5JCn686BM9Pws4wMRLeikKqXfl6IXFgSTfQJd++0cmRyF3rY+vukNgUncLdNEhL/4y6UoVls1lIXGy2m599QQgEO/4oRc5GZCCQWiOg3auDyIcp+ogpbxXfKHFPLaTmJZ2O60J2Ydr3nsm8prQoUfqsNeEo+XeSAYEhX8SxisXnwc4EyRm9AJXmiNP8dyS65rMsjffGL5mrZUkH+khi/aRCTZp7rlUJoiybIY/1HgUhtveZTiqQQOerlTxT9g1LLvf6wmV3YuhlLl4MfB7OaOW7ac7fDq4C55fPUHjfaBWKHk8MNc6DU9RAH1XLurB2VGoo9/4vc9ckAu7bGcWasgGlykavuNeu4tLs/9+Yk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH6PR12MB345224.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AY1k+v3P5Kdx9s911kMXGWGIxoLRMAPP3ICKRDpdPtMd6rPAXEH29oc7mGSk?=
 =?us-ascii?Q?XwuSbjAFWgSHXq0XWThsf+t+28syL4iK9wDjGNPrecXaXtkBrRJLTjz3Pei2?=
 =?us-ascii?Q?A9wK38xtEk1zwFatXuUjKuqREcZ+HzmiH7UF9Qudi8QgtXCWUr5w1c1D4kez?=
 =?us-ascii?Q?bDHAREqi2m1Kl4tH8TzR+4NUqRfuA5e8IYdJjSFKhGKINhKNXKl2Z15iE8Pf?=
 =?us-ascii?Q?9Cp4YtPFUXc6VVcOpYYJUxwGC8IjAUqfCYlsKzDFVHYy3mLSB1mrzoKLuILg?=
 =?us-ascii?Q?hVNf/TOtgbBq6ChsSd9DPy6qN88u+hO68of7y3S0lFf3ay3w+iHEaJfgxAZV?=
 =?us-ascii?Q?g+lwRwIyxi9yPY1ffm7mORFnIgkggzmPoyPaLDZ6fRxOrLwwaokcxjEJrNT1?=
 =?us-ascii?Q?Ft5DtrNnhcRNoKfCiyqtgnjHDpJh91ORRSwgaHAUAdZdl1ts6w/gQkZ3s8/D?=
 =?us-ascii?Q?Fs0wFirM2bK2W54aWo4R/nLKyb7XE3wMdwtgTWO6NFv3s5RkbfJ8dqFeuV25?=
 =?us-ascii?Q?xt/aKUGr5pcFmcuGXQHnEs3ponkXiOmMqAQYAhCy9zq+0PIUcU1g5Z5I8ZTe?=
 =?us-ascii?Q?7vpzisoPE3iLbDyhQ5E01gO3y9q5c/hCYWAy8Prxc1KSjNFeZT217SjVbKck?=
 =?us-ascii?Q?QnxnDE+ML4o5jWcucWZOTufY38fydu3e9/5l6FDodfUvt1d4xDGaDuQWOBUq?=
 =?us-ascii?Q?TrhAJ8aJrWZN9Lk1KXh4xlGM40vmURQzmK2tDEtKQyD9Wr/rch1obAhPbFph?=
 =?us-ascii?Q?SdelfmpBC0SkP51DVP7Cv5wkHfHMm1m0m9LPVbatnHER1oXzBbySt79AuI3+?=
 =?us-ascii?Q?mmUOhyeYdJSpEaBaqgtUViQIb4uaG5RwMRbmzdHjQwDUTKWAVWepg9yogIPn?=
 =?us-ascii?Q?G0jZYJWaQrH0fVbZeFNt4sSgxDS4n1IyJzMPHbiAsPaI2pzO1Z4NgoJRtoxJ?=
 =?us-ascii?Q?3AtzysM6rJjijp3AkyvJ1AjHWqF3GqfmbNAmGLyr5Q/ewRQz+yWAJIV8Tu1d?=
 =?us-ascii?Q?KKAp36Ywn2UrJEYspwDDhyGqWSYZU0lTMqVSNlWfoW0IbmoZPiObobbKRKRP?=
 =?us-ascii?Q?xOYPuNyrUCTJ11C8xAKVF0XDA8Oc4+KxyO5e3wOXKsU+btuRGtGxdubBmtZN?=
 =?us-ascii?Q?0e/DBSKjFx+/ARilE/JoAnOHVB813ILhscSabzYbyJBc7Mq+PpdVx6qrcheg?=
 =?us-ascii?Q?hzG1MzeA9b40H6+x0PCbgpi16IcjdaHHLmczUda2yDcEAmCrOpDqzEfk0vlL?=
 =?us-ascii?Q?CqoVJS9l5plegIIlKq2Nl0AEVD0Kcp2978zVDj2L7l8Wz8xJBCiDKoZWJ0vZ?=
 =?us-ascii?Q?AN+iHPiCdZIWKMQYnL80vLC86gd6styzTOBdI2Kgfx7VVhIVBqY6YUxBZWGl?=
 =?us-ascii?Q?uTjLoMwIM5cZdnkFB8qdF/et7ctfMSnvrEb6CpujsqFMCEe7V94X4YOCLiFr?=
 =?us-ascii?Q?eUYcZlFw2L/4gs/E58lUnlZiua06VESJKxSbwePQEJM6t9Uc8m4+Q616qZ0t?=
 =?us-ascii?Q?W2ddRM9pS2xHSkdOiubbIYxARRYHGuWQBfyxlTru0yA0Vnxr7SL9N9uEjDxD?=
 =?us-ascii?Q?lxjWlm5MjLRf/AJwf4DqZdCwo2wOMI76NWB9eHWfWrhAYOXen4M1XJ1UC2tF?=
 =?us-ascii?Q?vOCeKsjOg+Xb1vIEDZEtxpeQADtf7SRpf9iC5ua2Cs+NmKAw6Ebz23FZsFAF?=
 =?us-ascii?Q?yH9ixEj8j5EomiMO2OHU4l+quDbm0L8fGQaJ9NmQAg5o9lmZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH6PR12MB345224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405d1eb7-c241-4b21-28ad-08df133a81ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 15:03:31.6343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHh/LuBi9PUWlYJQn1a9cFPqLoAK/cZ3VyrztSQ1K4+5sWj0m/wq3hj9miIj4Ryl2m7+Ubct/yU978D1N3rCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: August 5, 2026 10:02 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Francis, David
> <David.Francis@amd.com>
> Subject: [PATCH] drm/amdkfd: Avoid integer underflow with ffs in EOP ring=
 size
> calc
>
> The low 6 bits of cp_hqd_eop_control store the base-2 logarithm
> of the EOP ring size. This was calculated as
>
> ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1
>
> But ffs can in theory return 1 or 0, so this could underflow
> (although in practice the ring buffer size cannot be less than 4096).
>
> Change this to
>
> ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)
>
> using properties of logarithms.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index e034da638c07..4f8a8a1a6186 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -204,7 +204,7 @@ static void update_mqd(struct mqd_manager *mm, void
> *mqd,
>        * is safe, giving a maximum field value of 0xA.
>        */
>       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> -             ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
> +             ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : =
0;
>       m->cp_hqd_eop_base_addr_lo =3D
>                       lower_32_bits(q->eop_ring_buffer_address >> 8);
>       m->cp_hqd_eop_base_addr_hi =3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 350fcbbba4b2..bf015dc5b868 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -242,7 +242,7 @@ static void update_mqd(struct mqd_manager *mm, void
> *mqd,
>        * is safe, giving a maximum field value of 0xA.
>        */
>       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> -             ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
> +             ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : =
0;
>       m->cp_hqd_eop_base_addr_lo =3D
>                       lower_32_bits(q->eop_ring_buffer_address >> 8);
>       m->cp_hqd_eop_base_addr_hi =3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 7c387fa90076..3942d6675268 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -217,7 +217,7 @@ static void update_mqd(struct mqd_manager *mm, void
> *mqd,
>        * is safe, giving a maximum field value of 0xA.
>        */
>       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> -             ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
> +             ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : =
0;
>       m->cp_hqd_eop_base_addr_lo =3D
>                       lower_32_bits(q->eop_ring_buffer_address >> 8);
>       m->cp_hqd_eop_base_addr_hi =3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 431a940f91f3..08da097f780a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -295,7 +295,7 @@ static void update_mqd(struct mqd_manager *mm, void
> *mqd,
>        * is safe, giving a maximum field value of 0xA.
>        */
>       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> -             ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
> +             ffs(q->eop_ring_buffer_size / sizeof(unsigned int) / 4)) : =
0;
>       m->cp_hqd_eop_base_addr_lo =3D
>                       lower_32_bits(q->eop_ring_buffer_address >> 8);
>       m->cp_hqd_eop_base_addr_hi =3D
> --
> 2.34.1


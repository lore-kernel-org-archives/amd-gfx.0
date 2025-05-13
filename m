Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260CBC3ABCB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 02:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD37010E4C8;
	Tue, 13 May 2025 02:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oq0vf9Lm";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE23F10E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 02:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cY2NudIqWG6kf5mR3PjN4sCbfLJd1hO0iMb2zOB7gyYooXRdHYPIMP9ces5zUhzDCa9JKP8+8dBhrzjxvAvk8wp2sfgdL/Tscwuwavm/kWOuXp70n3/3A4OwrV5nKmTb7xt7IsRafDV//6ZIBZSMHAjS17+v+P9zp12BhY73W44c4cPMJ4d2Iim8eHFnKgopmvEWiG01xfPJQiZUGIl3nF6FDg97HziLjBtyUSUKjhklbIxumH0zP1AUa5+509M6/ca3S35t4b7ieceFG5f3S2KUfk40rdOxEuJz5moIWWd33kiZ4V+HPLekdau38V9lBKRBnrY+tLnJtjI3gQLenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0pS2bbtW8BCJJAx4Q5zrzMsr/aTJ+Nt+RhcT886tLw=;
 b=dftl1bdEIABkyvOS2e6WCAvh61p7pmxouXhK0z7AKHYJv5Art5baJVDEwhe94yuD9/N58kMODsodjF2wF1bM+X+cuum5zWFC9skKOVqRFWqqKR0Th5e81MclpITfYc0vOnTeWYUf3YKrEjASTcDL7uL4GO6EOl2ViDP7nrrO3qYFmXFQIsWNq1spao6At1uHtYmfSB9GHKHA5d76FnmyAzJXCoTHsTBBiu2mliPKWn7faNbuHaB93g7UWjDop/pktuLIlIl2Z54QmeCXBElwWv5oFG4Dcr+B+lrwjpwApfKgHcK2lqIKg+mzbqzTebGSUbC0OmK+WYvIstD2Cma5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0pS2bbtW8BCJJAx4Q5zrzMsr/aTJ+Nt+RhcT886tLw=;
 b=oq0vf9Lm+lRTg8U+jJyrkTy0kpl2thT2Bn7FouGRiM+57Iv0AQbFrP8LazDluy1QbzVSNPoifrDozD8GY5tuiHtKQu6LFDcyQbuTZEpOaF62y6Lhr68D5vsqDjUc0LydP9hZlE0E2CDZEGdJaNa+phU3cdOqyrvfjvOuz/hW9/8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 02:04:18 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 02:04:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Modify the count method of defer error
Thread-Topic: [PATCH] drm/amdgpu: Modify the count method of defer error
Thread-Index: AQHbw0rxGfXrcZXZSkWgsr8THRF31LPK745w
Date: Tue, 13 May 2025 02:04:17 +0000
Message-ID: <PH7PR12MB8796DE93598A2D9926252B17B096A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250512143357.9377-1-cesun102@amd.com>
In-Reply-To: <20250512143357.9377-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=57062496-949f-4f9b-ae09-430ed818d788;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-09T23:35:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ0PR12MB6758:EE_
x-ms-office365-filtering-correlation-id: dbbe2a98-c3f4-4bc0-015f-08dd91c277dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZTMCfPKkWzdX1DXGi/vhIzjeh+o73xldfUu/jcOBincrIugIiy/LURvleoli?=
 =?us-ascii?Q?FCuVFcwUJhhlREMnwFRjFQ5PoRmQAx271tHJMu0yxV6XqZIs6E51VqB9OpSs?=
 =?us-ascii?Q?xKfc0iJ2EHOuYyw2uz6GnVFGRisLtEuWRy01JJDYz3938T3mrh32cvaPcRR8?=
 =?us-ascii?Q?YHPmA1Q/hv+mZUA2cyxPa+YQhuB+cb30wjNFCabIKmxFcN/3sxbZh9TC+jm+?=
 =?us-ascii?Q?h+69sp+l5lG0TTKfklKqBbfu9bisk3r2bz6aTA0PMvnDbjii6JtjaVujJKfG?=
 =?us-ascii?Q?/JBVZaEMSW6BCkt9WbBJZhKiWCPhDQ1S9PgJpi4GF34NY1v6KDl2j17hEruQ?=
 =?us-ascii?Q?gpFisggxMtoQ29PADDltlrC4fj+vlDyNBqUdOoEBwONZlLmVXIaZvPemGkk+?=
 =?us-ascii?Q?HyEZMaHUNvuaJQdGZspI5Jje1rJfP5llny35/59Wdgu/ebHXqoE+S4B3JsEz?=
 =?us-ascii?Q?ZTGlZCejciUsaUUOm7X5bmWJiKaMJBshq5mVe45+TGgu0XBazoqUK+uYTWGG?=
 =?us-ascii?Q?UnAtYsHN591kIIvMnUEPT4T8owGPfznPULIGLRlnBsACjy67S+0lctvbQA8K?=
 =?us-ascii?Q?xlmlVWTDU2397kk0Bj2HqfKXxAmn/W6v1TuC7Po+IoAQkS+FFVDBgFSfKudj?=
 =?us-ascii?Q?bCtiQ9B8sCzluLE6Nf2KSVVlxAR37RYuVLEavBes9fhlxQ+QdieaT3iTPA0C?=
 =?us-ascii?Q?t41Z4y+rau4gLejRTMFn8TL7IWXaoWnXV5hZrsvD/eH5UiTbT76Nvmc2mnx8?=
 =?us-ascii?Q?5acOlvrrYFqMdfO2AZay7iYcJzZGMDBmbqOMmcSStlrIxAxyoCa98A/W7NMR?=
 =?us-ascii?Q?1ktGx3lCvEYNqfG2rI/0A64tIu2ZXEt1CTjEVmJvheIq4tmuY2mTfrtjD1uu?=
 =?us-ascii?Q?84wKIXhKZjjwI1QzLPF46SNtoZlQNdfw1klkNmOkzrfnQwVs47zyibWMYGrM?=
 =?us-ascii?Q?HZwSkbt9ldpIrNCp97S+t7z/UtDXltpVj9gSHE+78l1hJe2+XuOt3PIQon1I?=
 =?us-ascii?Q?xLsqvqFiJzuzma4C6FBfGLtiNSEJK5Iu6/uxBbna0Pu4xWgyIxzYketUAPuq?=
 =?us-ascii?Q?zbiilsGXXmwsCrn/D0AmtGk3kQC84G8bRGzmZWn8R1x0ksAGJKx5JMl/oj91?=
 =?us-ascii?Q?c7C6PdOkW323ONJJUANfuuF9AdsBSX2PiaCzSuKTcXOIAKq973zOHz2QRkui?=
 =?us-ascii?Q?9YAF3g3Clx9XH/MwUW5a7RXoiMKr8QS27zC678/DeqFMg+KtRO5jeu9uoR/+?=
 =?us-ascii?Q?6oB3oHjlPCkchb+JtDNaBkdQTuDc49HZUMSCih+M+Y8GO3T0vUGhnpmmYPZI?=
 =?us-ascii?Q?k3c5YAwQ2KZa64d2w+FDiTyL36RfqhjMziluO0txG39YMDKLPS5t3l3LcL7t?=
 =?us-ascii?Q?ielPEUnWe5hVk/NBkNEbYpzfge2bU+lrPbYqC3ioRONzc0Hz88Ag00/hHahu?=
 =?us-ascii?Q?nQiH84rv60xcvS/EfCIPWZBcOLDFi6DhqyMnrihi2jJ1xRmXu7kI3ZrpuXfC?=
 =?us-ascii?Q?LtMb3xGlvdPz8J8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QwvBwB68vPLs9y4SUCpA8+Zqepo+EbjGEaE3jepA7GSixTwsvafMM+SCIkUy?=
 =?us-ascii?Q?/mu1M4ZJ9xYIgKJOFQ2D+lBtLZga/aNCXkpFSxNCWwkRIP/YIhtzopedGv2n?=
 =?us-ascii?Q?BizDWIf1syU5adsDaaiu+5trpLF64VCr1msBSIiRplIBzPqv4k7SNoEX7qS7?=
 =?us-ascii?Q?ci9Fvf58XGkSYXKzk+G/Y3I2xQTadNAtWf6lSJNl49m7hf1RIKqy7d3fryM7?=
 =?us-ascii?Q?ZqkuVXK8k51ChZ1zPyq//W/ooTGXcbsvitYwqNpBicMKiIBNTJZFS5DzCqPx?=
 =?us-ascii?Q?x8q8spFiRHTbToJcajqIIBJnZvkgX3WtGQDr1TYwYPoFmsTZYXieyOe+udgq?=
 =?us-ascii?Q?WsnLgMlbBzn34eBZmCRUV6DOl2LKw2be4BHDljYvBdPnX63x4XjVjlqCzoWd?=
 =?us-ascii?Q?x62IyqX3V/0IfvbDBPLR3/DFhtzjpVWZkmNyUuD+bVS1Mz4/qaSyxjQqPD8U?=
 =?us-ascii?Q?0D5NtAkNqCUJnbO2zfM924pr0Z5IhbzmbKbG9VFf+FG3Us59y7+rqNSytcuo?=
 =?us-ascii?Q?8rqokhtXh1QaTmvWpAMrtYiMwoIOrmAkqM1q7t21nt2/gyPt8FbyzIWdmG0/?=
 =?us-ascii?Q?dNyrk5x4N6ziGkXWFlE2Jmgd34m+86vuEQKayIkkbH2WyckRgU45OPRwofxy?=
 =?us-ascii?Q?qUoUlQOMA/NDHe+RJH+25/OVHThaHGLihNqCs0rHAq39mm6BevLrF+U6Y3zy?=
 =?us-ascii?Q?szAU2RXE5JaHJ7DujQkBYOByBV2xKRCfLWjf5ixV276jyR67cPBnJzsXFSXy?=
 =?us-ascii?Q?41PpdAEPirxD6usPPfm/AlaH9ptNjbKpIcZOWA+aeBa0XhKcwGrGAWdQ2InX?=
 =?us-ascii?Q?LihEV2XyEkeI0CtabY8AxxiLhoNGKNipXrd1yc5xWXJcCaypcD2YtdzFxopF?=
 =?us-ascii?Q?ZJjOrwNfSMArQkmmzGTFnmfE9rtOqD8ChHnHxp1HCdc3onf3bVonxOYquD/q?=
 =?us-ascii?Q?IIoe6OaxMFPIryRVANbsYrEjucdQ+ThjPyR5T2FjMISXZipPqx+Ja3V3dPsk?=
 =?us-ascii?Q?YnH8vYANJL8VxEmpoMCDoaS1Blu9GhN1aqQGI4icmnNeNrA7zpzZkAuH2cVE?=
 =?us-ascii?Q?bs59JClvvIdi6+3BL8ptRXhK2Hzp0J7OGfhWjrD1bnJSqmiuKO+bmVr2NaIM?=
 =?us-ascii?Q?9xG8i5ipK0NudJHIdEKgW5+MmdJaIghngNnf5bds5tX5wbw6YhmD8Uq/auyQ?=
 =?us-ascii?Q?SBnw8BsgwAjtITnPb5YK8yHp5RdtL1fYwWzIB2CD2RPvS5fRmHwJTNJhGCuT?=
 =?us-ascii?Q?oE6BsE0AXVfXOak9lHKcOsNa9Ehu9xhWRTjVH1f0JQId2+rrHGICeEZe3rB1?=
 =?us-ascii?Q?A5xmhEFvhvYwSp1rQrgzveDqhVrqs3FGWYy07YvXOlPxmL85Iek302oYl73o?=
 =?us-ascii?Q?cGRcRoQRTbOXR1/M9ebakMP5Qwdgufbry9at7yUp4xuuNPJreWaWT0e+pgM6?=
 =?us-ascii?Q?hdpzY0x7DRjqPwZZOYCwBkwySwxFj8hDc8WDeypM97ZOxjnXEwwuqvEtwDZ4?=
 =?us-ascii?Q?Yd+W3R3edgYyX88+b7oIyG1ce266KFN6su0NYfaeB0lhwdJiVoG3DvdVWTvM?=
 =?us-ascii?Q?YV4VKIGBitEZkO5ix0Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbe2a98-c3f4-4bc0-015f-08dd91c277dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 02:04:17.6541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaE4mkNCcT+Ho4ci6PJR2TPLvnBQ90HUTOjZbpoCmqzSmaQEU7rTh0dXSiQhbE7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Monday, May 12, 2025 10:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Modify the count method of defer error
>
> The number of newly added de counts and the number of newly added error
> addresses remain consistent
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 1 +
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 8 ++++++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 8adceeee298b..c19e40d095a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -533,6 +533,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct
> amdgpu_device *adev,
>               pfns[i] =3D err_data.err_addr[i].retired_page;
>       }
>       ret =3D i;
> +     adev->umc.err_addr_cnt =3D err_data.err_addr_cnt;

[Tao] please confirm we have chance to set umc.err_addr_cnt to 0 when no er=
ror address is queried from PMFW.

>
>  out:
>       kfree(err_data.err_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 857693bcd8d4..52fb71c4ce9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -130,6 +130,7 @@ struct amdgpu_umc {
>
>       /* active mask for umc node instance */
>       unsigned long active_mask;
> +     unsigned long err_addr_cnt;
>  };
>
>  int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0e404c074975..0a4ab63287c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -428,8 +428,12 @@ static int umc_v12_0_aca_bank_parser(struct aca_hand=
le
> *handle, struct aca_bank
>               bank->regs[ACA_REG_IDX_ADDR]);
>
>       ext_error_code =3D ACA_REG__STATUS__ERRORCODEEXT(status);
> -     count =3D ext_error_code =3D=3D 0 ?
> -             ACA_REG__MISC0__ERRCNT(bank-
> >regs[ACA_REG_IDX_MISC0]) : 1ULL;
> +     if (umc_v12_0_is_deferred_error(adev, status))
> +             count =3D ext_error_code =3D=3D 0 ?
> +                     adev->umc.err_addr_cnt / adev->umc.retire_unit : 1U=
LL;
> +     else
> +             count =3D ext_error_code =3D=3D 0 ?
> +                     ACA_REG__MISC0__ERRCNT(bank-
> >regs[ACA_REG_IDX_MISC0]) : 1ULL;
>
>       return aca_error_cache_log_bank_error(handle, &info, err_type, coun=
t);  }
> --
> 2.34.1


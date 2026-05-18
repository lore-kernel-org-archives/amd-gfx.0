Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0EBCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 12:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD99910E405;
	Mon, 18 May 2026 12:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/Ql3BVO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC1A10E405
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 12:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJlykDXWXGy4K5A6ieP+KglDhDBrr0hnsDwpP9yfLH9iFh+7GuSYR4Fi+u60AfVMejzB7knlGoMc8YzQz/jyuunjm9UwPhWA0GPfisUbHqc1NOvyi369Ky4XQ69S4SO7V/CmSnTjfweuPy9baYLJd9dvuaNpUFXGjSLO9F2AB6vskR6wdURsV9Cabs88bEBnWSgltBPesE4GoprPzKrVfGQ19ozU2Ym5Vr6ukHIhxidvVKna3lw5l6xaXfAZStER/Gcg1ikaQNLWWyG6Y5xu7UuW1YW74wrustGj46YHTboZvtib6VW1IVYnXaTgGzMuj+qtS5JoqqTu1eNc8jl/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/PNTGo44d9vCi79Aa4XpkUW/aHKC33ByyDdp0NKYPM=;
 b=LX0O0Gl7aqo7Hk2sKq1bnVhyIZsz8dZGVuJBaho9szMrN7I1F/4fb1+w3DIeP+VYKRqEaBckQHOI8h3P73RHbOlHCHhnXB0Eyr2NWU+yR6wRR/ZkcfgdADkLGGroy8VOMoC7c9L382RIJHBHou67h1JmptMLi4IHg77thp+1/RCuKgHVeixYGG9ae5SRHri6RTQAP40xbK5tZ3Bh+/MjaKM3tiDYJ/A0G0BkOISNJPGn2csZ6DI7zpaPUzUwaL5vhoKxrPSWd4FLzSYTc9SWyiiKbsAM6bTQurblFR+kmTaja8IPdDGtKXDEsoytjQeSoZuW1PKreKMGQdKJRjQAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/PNTGo44d9vCi79Aa4XpkUW/aHKC33ByyDdp0NKYPM=;
 b=d/Ql3BVOHmzYdKbKHTW+3qCwBq6jR/3dHHWbItrVohM37PSJI5+xToa3Yd557s8KdoAtQRjn2HO2avb6rtW2erQSXriGu52/5cUG2EwXvcI4TNXaZISLRi2Rjtu8Z2hP80Q9c5Gxg9qmS/j1fHnuqPBuIulNBgRWSixw9WQIPOo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SAWPR12MB999142.namprd12.prod.outlook.com (2603:10b6:806:4e1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 18 May
 2026 12:13:54 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 12:13:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Sun,
 Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH v1 2/2] drm/amdgpu: Fix memory leak of i2s_pdata in ACP
 initialization
Thread-Topic: [PATCH v1 2/2] drm/amdgpu: Fix memory leak of i2s_pdata in ACP
 initialization
Thread-Index: AQHc5pPl8sijBdENtUuGXl7XMtKybLYTsmJg
Date: Mon, 18 May 2026 12:13:53 +0000
Message-ID: <PH7PR12MB8796269022C28FFEA9B82E2EB0032@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <cover.1779087459.git.cesun102@amd.com>
 <355e38deb2eec64909f771db7a9e9abfc832fbcd.1779087459.git.cesun102@amd.com>
In-Reply-To: <355e38deb2eec64909f771db7a9e9abfc832fbcd.1779087459.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T12:13:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SAWPR12MB999142:EE_
x-ms-office365-filtering-correlation-id: b8d491da-96f2-4762-a643-08deb4d6eddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|3023799003|11063799003|4143699003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tswxEDfz3LERsBgYxqZfmNFKkRhYslVHPXdvEkyexO+8SFfbEmQz0qsMsipiJaxP0rm37K1EHY8BPGh8UNTjD3VzVIzhW8QOpBATps/5VJNyIeRJdIDTH5JZg3ODLqdgXO995f/yXzkQ5iBQVCfJzPyNmRBlEusGpuiTKgxRInZC/wX6nTMrK0o3xiBz7lZ4dFvh0/o6XFkNGRTFzLCh78jPrg2Q4Sg5yZ8sq2Cr+kcYIM+GZfLT3+jjNsp+nubiQWNcMsT9Rz8d+8S+543MaIVhnxzyNZdlAWObhkLka28/8qE+qKe3GtHCShPZn4/WcCKDL5jjOJnCo7GFG9SOSr4UpMyzd+MhVA3It6lpC18SFiJzIiU+0N8zfb2XP8cW2xcEX0dBbWrtR3Ey5Yd4A3rDxh5iO2lUA+FnoaK4Y7UmLScFNBzSf0tPOBCEKLnPTjH9oteQB9zMX/acmvV01O1zmhRSCiDH75KlbsXmhvW32OUb6Y1c71Dbr3SC4ySZkOuQPZzWWrNPc2O7GRHJAe+M3Ljh0owjVjxQmocVkRHTkP10hs4MeAFlKgAzh3P9j1og4K4vCPLtN6yfBxttPhH/ZI4d9XFJoN+xomSlUI652GJlzY+tQ0+DaQPzv6A1UhabmCRT9cYP3KLIle0jPFgB2+tQm9dQJeGXjZl7JR0gxIQm1cJU7iv4cp9yqn1ouuf4LEarKggrlSDMxdBJjvChg6VZcTExfkMotZidyuHbuVKt+izHOaWKJawSTeM7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(3023799003)(11063799003)(4143699003)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIovVd8hwlUAU5gIajgYD2WY6D1B/Id8Tf9LF/GtdkkBebc1cUAy3Eqb+jDX?=
 =?us-ascii?Q?juKWHkXLJ2KbrD+JC8GapPfJE40ubING23OSZ/niZ8OT10Irv+6/Du12SfXL?=
 =?us-ascii?Q?08n3GJtPepwsb/GQ4qpQQ0p3k242HgXtRgcwwLza5yfWJlydNrWdg47YUfXn?=
 =?us-ascii?Q?SuFER4wBdFWBk5+eB9zIsuEVKxCr830gbhGk2jv8+GSf8ZWbf8gbEbRxzrC3?=
 =?us-ascii?Q?7CKxCsZtCualh9YzYDxHdPR3yt5RNF3yEZUwQqcuotP/SjdzgxN+7NCWzqQ6?=
 =?us-ascii?Q?JLrUjfvq67TYt1s306mfssE+uJ6gkuQzgc+eg/6feNVGHv/OJVbBkCjZZ0xS?=
 =?us-ascii?Q?aSxU1SW8NPjUeWNZbFIwtnFjlxCDjOqryXdvoUTQR8xgOHrH8UwZfNQ0b80v?=
 =?us-ascii?Q?TiqwbnHMKK49N9hRfjV/Dka5VLGScEHSQAAchV0Ztjd+tx5pPZxvdz9krjrZ?=
 =?us-ascii?Q?UQT0o1UO8jUdo90i2Ttcrk/gaZsClpzl/dqCZYr1EsrwOEIPuK71yEQeUobD?=
 =?us-ascii?Q?O1gtM3tp7tQ6JaMjCLo9s15Ly61wO64cfowsjO6wZLvelyselMxPm9wjAoPw?=
 =?us-ascii?Q?iXVg0MDhhimNNl8LOuuPf3W9xA5JLw47lIKhfaCvXMvlhP4UlucPhFYakWob?=
 =?us-ascii?Q?vW405QZKFy0gRexcczw5Vne2+CKWJoxj4S1tkeIijdr/xACvqvosgQY0oxMz?=
 =?us-ascii?Q?MDOXXoBaR3aI9iVM5eGTWGnANM/u6CmbmfvcNmBypgyIms/5JLVWNC4V1iXQ?=
 =?us-ascii?Q?HW/yjGJUgrWDnfu6HUazUIKyYulcmMDwsPLJkDRr2/iu7KnLbBcv5JMve04P?=
 =?us-ascii?Q?bLBaJ82v94ZyPdubA5ANjZTvdMuHlyurwiZwDLnfU7qzU/Ccj66/wRyfwebD?=
 =?us-ascii?Q?7vC9i/zxnwpD+DnTrxB4mHenNbPKB4RjKmFqg2V6OJhPopmS/bbMiTl/SY7+?=
 =?us-ascii?Q?t18qagLUeqMbgMAZ8cjCTiDB2uAHPj2C1I0oZd1U0YzIl2RjVZ5zTQfEP/pZ?=
 =?us-ascii?Q?1ejc15lipVinuywusvRwjP7uA03utwaY/uwT+CWfuj2hDgbOBqa8MgNe0zp2?=
 =?us-ascii?Q?XV/W1hopkDwnQLq4Zm+qQr4czAoQ9IG/sODgGyGH/cbB4DG3EHLb2aOzGTSQ?=
 =?us-ascii?Q?OykkgzR0TIgEO7joaju5yOmhgVwcyqzPXe3uILPLRlSbw19a8U4ds0oJnKh6?=
 =?us-ascii?Q?bkZLiSwlg/GYpdrh7PLXQy8iC4FXzjcJ+3jZ+AnQZpomSLqmqNhhpvMAn9A+?=
 =?us-ascii?Q?HXfNH4ljWlcxug4MCFVsurx1ytk541C2y8hLfAAtUvvjuSSJRVYr0a7Mqr19?=
 =?us-ascii?Q?5HPaXm4EMlXKTf2H3wFKFr1LSAfSwQRAcCzPAafkgPkIOzD+Ui8xC6++7Oks?=
 =?us-ascii?Q?kngi/YRodxIZO/lDgARr+r9GUddHog5ncBjGGee3SuMZRfIHzFGKffxqiE9A?=
 =?us-ascii?Q?/Gl2RukkBOsMn/jL0na1HltoiqpdSCAWPcyxJZdFkxMTCNqWDyBQqgGelE2Y?=
 =?us-ascii?Q?bMlBdd2Emnsq1zIbBSZo7ZHjOrlkjdEjv60Rbh5xzxsJ1hUsgQ3yUDnXklkC?=
 =?us-ascii?Q?w3uOO0qLPUBSXPx0HL0QAAZ5Hxv6LTujr8O5DZFlStdDdwQd5jUY8M6OYojQ?=
 =?us-ascii?Q?T0fOkk6f02AcZP89SM6cdRrRFbLTZHGB38AMnADikIOE5/53kc6ozmXLtBED?=
 =?us-ascii?Q?Yk/RWQ9mmNwYKocu5oxF6pm7Cu0Vw7+y9LQOzaw/K9UhWzYv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d491da-96f2-4762-a643-08deb4d6eddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 12:13:53.9503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rmm4lorNXXhYRoCIxtSv4eYUq0slAqI+LKTV5oDnRe0Yau+G2h2FwGl2m+jjpi0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999142
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce
> Sun
> Sent: Monday, May 18, 2026 2:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH v1 2/2] drm/amdgpu: Fix memory leak of i2s_pdata in ACP
> initialization
>
> Currently, the i2s_pdata structure is dynamically allocated in
> acp_hw_init() but never freed in both the error handling path and the
> acp_hw_fini() cleanup path, causing a permanent memory leak.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 76 ++++++++++++-------------
> drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h |  1 +
>  2 files changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index 381ef205b0df..c1307dfccf92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -228,7 +228,6 @@ static int acp_hw_init(struct amdgpu_ip_block
> *ip_block)
>       u64 acp_base;
>       u32 val =3D 0;
>       u32 count =3D 0;
> -     struct i2s_platform_data *i2s_pdata =3D NULL;
>
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> @@ -273,18 +272,18 @@ static int acp_hw_init(struct amdgpu_ip_block
> *ip_block)
>                       goto failure;
>               }
>
> -             i2s_pdata =3D kcalloc(1, sizeof(struct i2s_platform_data),
> GFP_KERNEL);
> -             if (!i2s_pdata) {
> +             adev->acp.i2s_pdata =3D kcalloc(1, sizeof(struct
> i2s_platform_data), GFP_KERNEL);
> +             if (!adev->acp.i2s_pdata) {
>                       r =3D -ENOMEM;
>                       goto failure;
>               }
>
> -             i2s_pdata[0].quirks =3D DW_I2S_QUIRK_COMP_REG_OFFSET |
> -                                   DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> -             i2s_pdata[0].cap =3D DWC_I2S_PLAY | DWC_I2S_RECORD;
> -             i2s_pdata[0].snd_rates =3D SNDRV_PCM_RATE_8000_96000;
> -             i2s_pdata[0].i2s_reg_comp1 =3D
> ACP_I2S_COMP1_CAP_REG_OFFSET;
> -             i2s_pdata[0].i2s_reg_comp2 =3D
> ACP_I2S_COMP2_CAP_REG_OFFSET;
> +             adev->acp.i2s_pdata[0].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET |
> +
>       DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> +             adev->acp.i2s_pdata[0].cap =3D DWC_I2S_PLAY |
> DWC_I2S_RECORD;
> +             adev->acp.i2s_pdata[0].snd_rates =3D
> SNDRV_PCM_RATE_8000_96000;
> +             adev->acp.i2s_pdata[0].i2s_reg_comp1 =3D
> ACP_I2S_COMP1_CAP_REG_OFFSET;
> +             adev->acp.i2s_pdata[0].i2s_reg_comp2 =3D
> ACP_I2S_COMP2_CAP_REG_OFFSET;
>
>               adev->acp.acp_res[0].name =3D "acp2x_dma";
>               adev->acp.acp_res[0].flags =3D IORESOURCE_MEM; @@ -312,7
> +311,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
>               adev->acp.acp_cell[1].id =3D 1;
>               adev->acp.acp_cell[1].num_resources =3D 1;
>               adev->acp.acp_cell[1].resources =3D &adev->acp.acp_res[1];
> -             adev->acp.acp_cell[1].platform_data =3D &i2s_pdata[0];
> +             adev->acp.acp_cell[1].platform_data =3D &adev-
> >acp.i2s_pdata[0];
>               adev->acp.acp_cell[1].pdata_size =3D sizeof(struct
> i2s_platform_data);
>               r =3D mfd_add_devices(adev->acp.parent, 0, adev-
> >acp.acp_cell, 2, NULL, 0, NULL);
>               if (r)
> @@ -338,53 +337,53 @@ static int acp_hw_init(struct amdgpu_ip_block
> *ip_block)
>                       goto failure;
>               }
>
> -             i2s_pdata =3D kcalloc(3, sizeof(struct i2s_platform_data),
> GFP_KERNEL);
> -             if (!i2s_pdata) {
> +             adev->acp.i2s_pdata =3D kcalloc(3, sizeof(struct
> i2s_platform_data), GFP_KERNEL);
> +             if (!adev->acp.i2s_pdata) {
>                       r =3D -ENOMEM;
>                       goto failure;
>               }
>
>               switch (adev->asic_type) {
>               case CHIP_STONEY:
> -                     i2s_pdata[0].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET |
> -                             DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> +                     adev->acp.i2s_pdata[0].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET |
> +
>       DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>                       break;
>               default:
> -                     i2s_pdata[0].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET;
> +                     adev->acp.i2s_pdata[0].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET;
>               }
> -             i2s_pdata[0].cap =3D DWC_I2S_PLAY;
> -             i2s_pdata[0].snd_rates =3D SNDRV_PCM_RATE_8000_96000;
> -             i2s_pdata[0].i2s_reg_comp1 =3D
> ACP_I2S_COMP1_PLAY_REG_OFFSET;
> -             i2s_pdata[0].i2s_reg_comp2 =3D
> ACP_I2S_COMP2_PLAY_REG_OFFSET;
> +             adev->acp.i2s_pdata[0].cap =3D DWC_I2S_PLAY;
> +             adev->acp.i2s_pdata[0].snd_rates =3D
> SNDRV_PCM_RATE_8000_96000;
> +             adev->acp.i2s_pdata[0].i2s_reg_comp1 =3D
> ACP_I2S_COMP1_PLAY_REG_OFFSET;
> +             adev->acp.i2s_pdata[0].i2s_reg_comp2 =3D
> ACP_I2S_COMP2_PLAY_REG_OFFSET;
>               switch (adev->asic_type) {
>               case CHIP_STONEY:
> -                     i2s_pdata[1].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET |
> -                             DW_I2S_QUIRK_COMP_PARAM1 |
> -                             DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> +                     adev->acp.i2s_pdata[1].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET |
> +
>       DW_I2S_QUIRK_COMP_PARAM1 |
> +
>       DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>                       break;
>               default:
> -                     i2s_pdata[1].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET |
> -                             DW_I2S_QUIRK_COMP_PARAM1;
> +                     adev->acp.i2s_pdata[1].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET |
> +
>       DW_I2S_QUIRK_COMP_PARAM1;
>               }
>
> -             i2s_pdata[1].cap =3D DWC_I2S_RECORD;
> -             i2s_pdata[1].snd_rates =3D SNDRV_PCM_RATE_8000_96000;
> -             i2s_pdata[1].i2s_reg_comp1 =3D
> ACP_I2S_COMP1_CAP_REG_OFFSET;
> -             i2s_pdata[1].i2s_reg_comp2 =3D
> ACP_I2S_COMP2_CAP_REG_OFFSET;
> +             adev->acp.i2s_pdata[1].cap =3D DWC_I2S_RECORD;
> +             adev->acp.i2s_pdata[1].snd_rates =3D
> SNDRV_PCM_RATE_8000_96000;
> +             adev->acp.i2s_pdata[1].i2s_reg_comp1 =3D
> ACP_I2S_COMP1_CAP_REG_OFFSET;
> +             adev->acp.i2s_pdata[1].i2s_reg_comp2 =3D
> ACP_I2S_COMP2_CAP_REG_OFFSET;
>
> -             i2s_pdata[2].quirks =3D DW_I2S_QUIRK_COMP_REG_OFFSET;
> +             adev->acp.i2s_pdata[2].quirks =3D
> DW_I2S_QUIRK_COMP_REG_OFFSET;
>               switch (adev->asic_type) {
>               case CHIP_STONEY:
> -                     i2s_pdata[2].quirks |=3D
> DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> +                     adev->acp.i2s_pdata[2].quirks |=3D
> DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>                       break;
>               default:
>                       break;
>               }
>
> -             i2s_pdata[2].cap =3D DWC_I2S_PLAY | DWC_I2S_RECORD;
> -             i2s_pdata[2].snd_rates =3D SNDRV_PCM_RATE_8000_96000;
> -             i2s_pdata[2].i2s_reg_comp1 =3D ACP_BT_COMP1_REG_OFFSET;
> -             i2s_pdata[2].i2s_reg_comp2 =3D ACP_BT_COMP2_REG_OFFSET;
> +             adev->acp.i2s_pdata[2].cap =3D DWC_I2S_PLAY |
> DWC_I2S_RECORD;
> +             adev->acp.i2s_pdata[2].snd_rates =3D
> SNDRV_PCM_RATE_8000_96000;
> +             adev->acp.i2s_pdata[2].i2s_reg_comp1 =3D
> ACP_BT_COMP1_REG_OFFSET;
> +             adev->acp.i2s_pdata[2].i2s_reg_comp2 =3D
> ACP_BT_COMP2_REG_OFFSET;
>
>               adev->acp.acp_res[0].name =3D "acp2x_dma";
>               adev->acp.acp_res[0].flags =3D IORESOURCE_MEM; @@ -
> 422,21 +421,21 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block=
)
>               adev->acp.acp_cell[1].id =3D 1;
>               adev->acp.acp_cell[1].num_resources =3D 1;
>               adev->acp.acp_cell[1].resources =3D &adev->acp.acp_res[1];
> -             adev->acp.acp_cell[1].platform_data =3D &i2s_pdata[0];
> +             adev->acp.acp_cell[1].platform_data =3D &adev-
> >acp.i2s_pdata[0];
>               adev->acp.acp_cell[1].pdata_size =3D sizeof(struct
> i2s_platform_data);
>
>               adev->acp.acp_cell[2].name =3D "designware-i2s";
>               adev->acp.acp_cell[2].id =3D 2;
>               adev->acp.acp_cell[2].num_resources =3D 1;
>               adev->acp.acp_cell[2].resources =3D &adev->acp.acp_res[2];
> -             adev->acp.acp_cell[2].platform_data =3D &i2s_pdata[1];
> +             adev->acp.acp_cell[2].platform_data =3D &adev-
> >acp.i2s_pdata[1];
>               adev->acp.acp_cell[2].pdata_size =3D sizeof(struct
> i2s_platform_data);
>
>               adev->acp.acp_cell[3].name =3D "designware-i2s";
>               adev->acp.acp_cell[3].id =3D 3;
>               adev->acp.acp_cell[3].num_resources =3D 1;
>               adev->acp.acp_cell[3].resources =3D &adev->acp.acp_res[3];
> -             adev->acp.acp_cell[3].platform_data =3D &i2s_pdata[2];
> +             adev->acp.acp_cell[3].platform_data =3D &adev-
> >acp.i2s_pdata[2];
>               adev->acp.acp_cell[3].pdata_size =3D sizeof(struct
> i2s_platform_data);
>
>               r =3D mfd_add_devices(adev->acp.parent, 0, adev-
> >acp.acp_cell, ACP_DEVS, NULL, 0, NULL); @@ -493,7 +492,7 @@ static int
> acp_hw_init(struct amdgpu_ip_block *ip_block)
>       return 0;
>
>  failure:
> -     kfree(i2s_pdata);
> +     kfree(adev->acp.i2s_pdata);
>       kfree(adev->acp.acp_res);
>       kfree(adev->acp.acp_cell);
>       kfree(adev->acp.acp_genpd);
> @@ -558,6 +557,7 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>                             acp_genpd_remove_device);
>
>       mfd_remove_devices(adev->acp.parent);
> +     kfree(adev->acp.i2s_pdata);
>       kfree(adev->acp.acp_res);
>       kfree(adev->acp.acp_genpd);
>       kfree(adev->acp.acp_cell);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h
> index a288ce25c176..13b48c582314 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h
> @@ -35,6 +35,7 @@ struct amdgpu_acp {
>       struct mfd_cell *acp_cell;
>       struct resource *acp_res;
>       struct acp_pm_domain *acp_genpd;
> +     struct i2s_platform_data *i2s_pdata;
>  };
>
>  extern const struct amdgpu_ip_block_version acp_ip_block;
> --
> 2.34.1


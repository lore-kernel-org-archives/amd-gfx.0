Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A036C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 07:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131D210E42E;
	Mon, 13 May 2024 07:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JEfXr/J+";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D495E10E42E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 07:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5839+CliUfozXc+CY1AMnH13QtavmHojiKNyc/bHJBNwUGvxLoPNRexMinROoZMzd+boJJMbb2cCcB7Z+p42hsXbt4Hc45Gd98GiHGrzTFOiQ+AHPXXk+EKDUUbNQG71afjgf+zDsn0jXuMYxwE+P6WjREmX7I8Vwo0PaDFm/jnQHc6STsN4Kuhso+Z0X3YzEhxi7VzhxwwyPmuACt5Z4d1CXpuZmgGr6zUxiaA7zSbknkmKSwixh5zTBQJGkjtTST3EFBz3AUAugRRn7HlJVswGJYTBepiWHwhl9RqJO5tCwURTnogk2ocMIAfSSZKbK9hXXBTDBjysvOy1igX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX+WNkVCwTwnyZiueYQEIqlEk0hjZ/2P4XKFnT0wBZ0=;
 b=UFY7TYGG6e2iCHz6hKW86S3OzoEHMRv0O6ifPMk91czJynorq7bcNp4+Ej8UaZyvZGaze/p8Ab4UuoUx1S72CZG42gbID/QUi+bDmPHUaGvnVZS/JAxlUuoMD/ZXCKRMrkMcUTppJyrAyCKk+e9ztiKfUhSOJuq6tKWCO0/wDt+H6inXZFL2DWkP6zPivHAzuFdx0pz9ZkgDPafp1nj0BNOhg9JdrASGGOwndL1BcVdU7qbyQk41Vmuh+jBEpxKA912peGn3bt9QS1SRuaGfBiF41AeDdYeDoCz8wyriJ/vVfAkSi7HlbyNh4Uhh1WJZXmeRbOrR++UiS3exIsOmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX+WNkVCwTwnyZiueYQEIqlEk0hjZ/2P4XKFnT0wBZ0=;
 b=JEfXr/J+U04J45bnW5yAVR+KA7Gklb68Llp3bkSxOuRqPSqUJ4KxWWc4uTB/sRpGLpSUv7EgROPhNvQW3djAz2lC2wY1/jzrfF7Qwd35j2JS+gP5iA9qkm/2v3zyASXRqWwkx7Ud94YKyByZqEWEDX0e6h6mzCXmspCCkA9SQ7Q=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:40:18 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 07:40:18 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Topic: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Index: AQHapQfzsQWqcgYxEEy9woItg75R27GUxrhQ
Date: Mon, 13 May 2024 07:40:18 +0000
Message-ID: <CH3PR12MB8074401359DAA799678AAB2CF6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240513073359.3612989-1-jesse.zhang@amd.com>
In-Reply-To: <20240513073359.3612989-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a5abaff8-81d7-47ec-a5b1-c037a1d6af6b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T07:37:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA0PR12MB8645:EE_
x-ms-office365-filtering-correlation-id: 02734590-e556-402b-9e48-08dc731fefda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?nvHmAnvsAoSdYH6tqVEZ/oiuGg9q3ZDS2ccQ6HvQnhguTke4/cLncZYDH+Jc?=
 =?us-ascii?Q?cUyCNgi1v73KVukNYZmVCF5s1Dzo2FotPdFysmt2vPZ/C3YGIHhuGITZRIYO?=
 =?us-ascii?Q?v3/yMa0Iy3RsgeQ3jqaAXh+QF+GDQPH2PVixs37F2/WE0nTa/Ut5M5AFtoz7?=
 =?us-ascii?Q?kM2ZFpOV5PBEiStz6+7zKT/+vNa94qwUKMP86WbIcGuYvjkS7NBDwhKxz4T3?=
 =?us-ascii?Q?rxJoxMWcrVZjsO+eZ2yJIK57DEVMtQpdDftZJMYOIrnienAJHkK2bR50vPt+?=
 =?us-ascii?Q?6Uf+TK42dJ0pclmm7y2hckr0AmboxG2Lrg6e+/1cHZMl0i66YvzyOI6Rjsff?=
 =?us-ascii?Q?KCHYIfpcWjNxd7F4Ax/RC1IG5I9TBeDCtu9yvXVsap7zYl2REMQABcux/iKi?=
 =?us-ascii?Q?vO5mEzjKLV9v/YiU+Xa0ZVTCWGnCNeyDwVINzf50Hy3WwOLLiNHJwWizTZMH?=
 =?us-ascii?Q?zJBTLHtZAFZWWNePkp+ZkcvVOyNNo6yh9aT0qwekTsC8P8UqThG4pWA6Rz0k?=
 =?us-ascii?Q?2wLpNdgI7qS3m8WBGWvboktT6SNz+8GP6A563NF0sY7vvsTqdkRkojO/v7M8?=
 =?us-ascii?Q?aQ7vj7fmfOmW0egoVYdEmJsKAA6+0jDPpE0rqu1/8JhYliFRnMUdW/cncWSr?=
 =?us-ascii?Q?zOr366rg3bfOekTQG+xAwTBsOcokAaWuhkNvaM35LjW+kZ69J1fpyU70mMyK?=
 =?us-ascii?Q?K707zMcFdVIX1ARXauKmeIydnPc7a4PMz/ESNLLhMkuTwcIhKZ3m46PnVjCp?=
 =?us-ascii?Q?gKi6yu9RVa0x0DBNe4BnoVmtjsSpHjDaKvsJg/W8jTgGMM0ZeSkVHLwxF+MC?=
 =?us-ascii?Q?BWmNkaWrGXEZlQAgO5beM3aYAX/Fc7k1W40vyKfMLulVqwEFqVJs8grivAIC?=
 =?us-ascii?Q?BDCZtnv7yiS8GEeRhz7+9gOUiDQeQrYaR+gJo34N9o46wEW1MhOstZ9jTBXd?=
 =?us-ascii?Q?dX0eOQkzfXEq7bHY4Deyr3aNj8CuJ0REYKTzyZYG42+UxZbM7fIJ4RzunEVX?=
 =?us-ascii?Q?0iyI3fl7UYiPkBln4afY23cZF04yoixJ0L3F+TBn8v8txlKYdKa/zCxo1yLr?=
 =?us-ascii?Q?7d6zYAJDVayVk/jlTsQhSr47lEe+yI+C5d1zgBaBGbhpuKGZiNBXZ6/KZRiU?=
 =?us-ascii?Q?7jx3gzWYYs3JdC4/W08RdrzEeJNlpRMAtnh3lZbYqKMj1jq9Exl8lMLuftW+?=
 =?us-ascii?Q?fuqayQCox32Qg5534odQ8+gK8Ftct+yBx5sjJyFlvbzFAg5mgFylcU9uARQM?=
 =?us-ascii?Q?qiGKYTGqbyAcqNxtsaRcefui7kReBcvJYimCZcRCCOztfq3Esi0+GQJWw/7J?=
 =?us-ascii?Q?n4QQukNTR7454SoeInTQkmurDAzlTQFmJiVF+DbSmJLxdg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uRA5m6FE8eJKNl12vk+cNBH2C5chnuM8Savx2CfJoS3Qb2D/dZZbg8+au+zR?=
 =?us-ascii?Q?Oea/n8zG4196n1En/2FRj0dZ5/3T9MRCUhjOjApLFBRyAQ2+AYRH53anuSzn?=
 =?us-ascii?Q?d9nRebtDbO97g7WIX4iqcOaw9ZwT7Ky/MaarID7hr0DK3k9fYkPSazAqZUOv?=
 =?us-ascii?Q?DHH75kGyeVW4qVFycAECGIOgoNeWErC+YvT0q9FqsH+E8wMy8DtEioCY4ur2?=
 =?us-ascii?Q?cDRjr5F4FnbyTO23oo+t1ivyjJ37uMz2A+NuGwd93r+RaaSxKBkJxaaoP39c?=
 =?us-ascii?Q?GrjYIVlW73ActsNngog3vLVMC5fwjjIhTaoBZAJPNsGKE0bIQZ6K5/v0i4dK?=
 =?us-ascii?Q?LkyExsmiZaFTYI/tJ/zNZCaAXNfsdvUT41Dh48QvoT6blx95u5aMRR3MYZJN?=
 =?us-ascii?Q?7UVEJZSoh/XM8ojEmJtQWhsb3YMQHcOAn/U1OJT+H3EPa9ozEbgSPtSIOmKP?=
 =?us-ascii?Q?PtNon660GKTkw00yNsiQU0HGC/DUHEJvswX8vYpyNxP3Ww/3ngB3tjZXROrw?=
 =?us-ascii?Q?gsG5gYQXCcvG64uI+KotR65I/AKPhAXLM1dq8g97qTFWLUvYEmmboYrTDTwm?=
 =?us-ascii?Q?/J2fAl6TBVOHExUT8XIfXbiVCDbDHvYyC7enDsKoNvwpm2IZhXJDsYCOYGyA?=
 =?us-ascii?Q?Xa9DIsfNA7BTJPq8dqLboB4YfW5cPRYjFXg4zDFSFRyvcUSSqBVGaDLdL4K6?=
 =?us-ascii?Q?CP49TISDqFNHY/t+jWvJXuHT9N1LxCE5PhYLjFSjo8UHNNE8KWCsO55OW/Lb?=
 =?us-ascii?Q?xQ+TCGutwOEbd1O0A2wu+KTrln0D75ucW47fvx1OnIjoHgl7fxa0L5haT63G?=
 =?us-ascii?Q?ARo//sNPDglZj8HCGqmmJ7Lv2se6Rc9HBJ/FmFqlCGe0Ag907jNTj8xHi5EN?=
 =?us-ascii?Q?0qu4fdtAw2CnTJquf0hz62NHKfYD/gbOCetlQ5I7vW5p5lPts97QK1nf6oB3?=
 =?us-ascii?Q?xgpdaHCd91GC9aL0+wPv293bc5esprf2LuOYWbUykVZbLhGvZcOIXXtjBxh2?=
 =?us-ascii?Q?DDHnwhThAkxfOAnObB4mFjI952eK6x4c47Axaa9R4ajg3YUVq1j1r/E9tuP3?=
 =?us-ascii?Q?8ZJbgZoTQ2byS/5B4I4h19t0y1JTx+U3UOACBRFdRTXVS33urQDBIveDEhqg?=
 =?us-ascii?Q?Oqco9XN02haCCfzxjdflSUvwGIIJqsv/tupXA5/zbOTm9cwdQEnAGxdNE5SS?=
 =?us-ascii?Q?Q9s4dFELqFuuAojCqWtgOeMHZKelw9EgXfUU3jonmiF0SXd1oSJ+q/j0b8a1?=
 =?us-ascii?Q?8SZK2N84lMpCkrR5RoZYrh/H9HF7NndyUIVkOmOr4nx6+rF6B4kW1UKtY+71?=
 =?us-ascii?Q?uvc5OxihfyiRFeYFNowhOWYVdb7fyz8lAeHX3JYwrQReW59BWJWii7E2SYFt?=
 =?us-ascii?Q?GFAxN6lx2BZDUHuN5ria+MTFmKTCtOQoBTsndsVSSg6my5VLmdlYJYOX4Jy0?=
 =?us-ascii?Q?aA7vCSxI1FRpOvL1TBeqfEjXtaZhqUAPeL1Od2htsOh0p0LxM6JpKtLHrVaD?=
 =?us-ascii?Q?i1WiMcW1ywfCw7M1NsOzXYNHMVyQ/IgHGwxJFgPtAQcYRUSJYID3rdeYeGDE?=
 =?us-ascii?Q?IQYrkrVn6O3NULPEz/k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02734590-e556-402b-9e48-08dc731fefda
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 07:40:18.4982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbvurJqQAYxmLS+WbwcT4Q3C+oGbk4TP8HJYEpkkSugxaMhAkrXT4oHvqMTiy4mKiofNu4oCMIgvTkjG7+pUtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
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

Hi Jesse,

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, May 13, 2024 3:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
>
> Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr)
> returns a negative number
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> index f4bd8e9357e2..1276a95acc90 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> @@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)  {
>       int result;
>       unsigned int i;
> -     unsigned int table_entries;
>       struct pp_power_state *state;
> -     int size;
> +     int size, table_entries;
>
>       if (hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D=3D NULL)
>               return 0;
> @@ -40,15 +39,17 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)
>       if (hwmgr->hwmgr_func->get_power_state_size =3D=3D NULL)
>               return 0;
>
> -     hwmgr->num_ps =3D table_entries =3D
> hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
> +     table_entries =3D
> hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
>
> -     hwmgr->ps_size =3D size =3D
> hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
> +     size =3D hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
>                                         sizeof(struct pp_power_state);
>
> -     if (table_entries =3D=3D 0 || size =3D=3D 0) {
> +     if (table_entries <=3D 0 || size =3D=3D 0) {
>               pr_warn("Please check whether power state management is
> supported on this asic\n");
As we return 0 here, we still need to set the hwmgr->num_ps and hwmgr->ps_s=
ize to 0 here.

Tim Huang
>               return 0;

>       }
> +     hwmgr->num_ps =3D table_entries;
> +     hwmgr->ps_size =3D size;
>
>       hwmgr->ps =3D kcalloc(table_entries, size, GFP_KERNEL);
>       if (hwmgr->ps =3D=3D NULL)
> --
> 2.25.1


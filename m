Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38109CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC1610F9E6;
	Fri, 29 May 2026 07:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3KPmcrOz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B3E10F9E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 07:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ9IGYk3cfdjgSvl/DpLSP/6kbZ45FhHUvkfJIMnntMtAGa3/GIYkjuc9XYzeOB2tpOOILmfjKeobkHiiaNOIkhu0ls7hvPNq8A0t8koUUL6nJ8tAGc0bFmZBQ03zv6XUQ3Qz2E54Nd58dkz7N6r8nJ66M8FqUsAyPBqHUYOKAAAeKiYHhxu3i7mFlccW8NjFeQELvanyRN/yBdlv0OqrRgBPbjeS5Apl8AAjvd963nJfxynHLwhergVuX4/S3uPislnz2UF4GnQM02fXhLDsjh2Pd+Qjg01S3u/XT1RiydfXqTbuVQRDTNxXA+X+KLMd9J1IfLgBSJKc8G9TjB/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ra71kD5/AiEeiFvE6VvXbcGyiAmxd5EPxcHNWlEsrI=;
 b=twy6bGa/y0g0ZYMLZBFsFlfTSLMZAiuqGj1IINV9NE6bRgRMZXO6pjsnW7nn/O++dDDkR7OI26amFTys056NTHj0qlGGL2tEoG9NWelX7JAHoac/uCmZP6prQB6ypmpZMKOvm2aGzY4yzqywrhgH/LU0Vso4lR68Z7J0t8QWt4CbSXoMVtkI09KAykvp9npb3OvzAD8CbmATCV1I4m/hyTsBF/UQuZhzQfabgailoABcf5WpeB8gnS3gIVEpE7mduSP/KXyOzB3VYVEVdj8zOjeUCiIOttS73UsJh00QiZahqg3fGL6b/QGSbdCp7lN/LTRBMu0vnc+jkno6bWI+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ra71kD5/AiEeiFvE6VvXbcGyiAmxd5EPxcHNWlEsrI=;
 b=3KPmcrOzaJf6ttSimc7L5lEYAk9N8WxH+ffciP8MhC8BoCmbssmavw7/XrpYcdFoJRr/G5IXu1pHsL1s8mlCH4HrhOdhASQhhS9iZ6vvW32wKI7WCXQmVV3p48GfS+MXTIGwDT9zADf43aHaZ/JXM8UtuEG8DgXP3TCPzNqf1b8=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 07:16:01 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 07:16:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
 printers
Thread-Topic: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
 printers
Thread-Index: AQHc7zMiATTs52bkPUijEL4YACEOF7YklPtA
Date: Fri, 29 May 2026 07:16:01 +0000
Message-ID: <DM6PR12MB2972DCC91EE8D0476171F39982162@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529061920.357400-1-asad.kamal@amd.com>
In-Reply-To: <20260529061920.357400-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T07:06:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN0PR12MB5834:EE_
x-ms-office365-filtering-correlation-id: 5c809a04-bbb3-4fe0-1696-08debd522376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|6133799003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: vsZsH/oeFmYLy40qSYU3qNjQ92hUTX8KC5CGTeFGVM+5txH5O734UdaOP8b3wjgscfbD/KfWtq16LxESyZjBx8Q4F4rBzgEonDcMfhedOCuKVoGS30GmzY+eb/PNw8jl6zjKj0QnxQ35SuJltLihBeT7nN8w3oDWQrRdVaLEcqDSPyeQCIUt1TJSQjXx64duP2c9DitydBpTVtlh6e3Dodbcy/gT2OyFJKHKcK2SeU0hwey3kH0N9m2RJnxx/c+UguCvYD9NgSvn8+zDeRW5v4RogNbfxpNmbqjxkEaz0ZpHEmKqWvkhoQHJgiSK1Vzi0M9SZm8NX7ybrTRKPEDbU+/IIA4yp25c3brl+MBigceyl/3G61hWLaEFLs8LXbWVoT3cw8Uufxfzn9831R0jUmWifoA+ILUBYqvgFI5Pzjz0gMlk2ekZmzSG8gzYTWQ4Nk41PCRdO59al22oFDrbSNWHgbTqr2o/Vtwj0RqAiXu8Gd/LVmPWsiaXgkxrTuB9TN0bnH4CfRt+PBqU92Hv/m0MJQUpRXHOYXbUWp9a3d9ybze2rjg347nj350/rL7cG2JDjntcgJ1lGYINgvQs4SJ3+z4PhEatDThcyXo53/WpPVs9NPX5J4KUfZf01icXRx1wXeKNgTi34HS1WYp7LVDzTY2UlMAOG7x4JRTqNgSkN3VuXrX/SITejPzQvDTbxBw08iVCI1aiP8IUyHLm5+lSsDR/gqdA8PXWY8ZwBLG/5EDG8X0W7YFoPklUe5AQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VU1BPo1BKkMkrHZq0s7M/cnQb1dYQ0TAVQZ/uuBhPZmJizbRYsNM28AxZcHn?=
 =?us-ascii?Q?UDNtmpl+qqmiPVj5qZ4IQUVJqHU2tu5hh/vzqB2xAqwtcCLRioNAqZPuFvBe?=
 =?us-ascii?Q?DpN2sfaS5kpK4QrWI66NLUbgDWgDQwyBriG59w5QToNzibgwIiQ3r2wgQY02?=
 =?us-ascii?Q?npGOUHw1uQxE38k6TRv2aaBkDP9zHQ4BMlbmFT+GDaZLzG1FZoEuGl13fty/?=
 =?us-ascii?Q?9THR2TkLnWMaZJKV4mPSbKel+I2gBQg3J6X72JuYo4UnWyNzKbkhfrih3cld?=
 =?us-ascii?Q?babdiUWvgibTogdNe/cx48yVSrKBMHNphuqtvRBxAEv51pg/INmeNgxrHQPb?=
 =?us-ascii?Q?CKZsPuKGjlbWNIOAdQGTuXthyWrlqvWvxK40FY9BpfwgSrj36VMSQF7B+nj0?=
 =?us-ascii?Q?egbme9rxBSxXJbJRAQD5LoL4OsoMLMkmmXfIv7TRVMyhzrxqXoMxehrRSCmi?=
 =?us-ascii?Q?QS3C/mjoQWEWkeXwTTl3YYRfQMFO9+I8Z2ZUeVD4PSvbCTrJSm6Y3rU9lK4w?=
 =?us-ascii?Q?YPK8/gfAl1CqZ37u8d99UvK3xJDwAlEQ+UL+ONaGqj1Toq8z5t/06tKSa8JO?=
 =?us-ascii?Q?HJN25d29RlRoJi8yKzclJjJfHBpJivq1jXqjcorso7IeEyChVcStCUAJj7qi?=
 =?us-ascii?Q?WPdiGJno84hfoAiM5ZrLuSAzwt6yh1n3behS9okZPEzrYZK7XRMjgj0Xlfxy?=
 =?us-ascii?Q?JbdkIoyXo47iodmPG7R8WtQma7JdOaHO1iIGw3jyoxFJuuDyaSqMGzv1onlP?=
 =?us-ascii?Q?ABZt6/eII+EON/QppedstPqTTNQCtll0AfpFThMWuxVSB7x+oAk2pnneaQH3?=
 =?us-ascii?Q?Tn6op3FCH79pfWF26JqBY0IKV8PWyKXi6KE//aCSj/GqsA/4kXsmd4TyzWyM?=
 =?us-ascii?Q?BxMco2jQFl86eY6K/ccmRov4T97+1fJMsx02XSBE3aHk4OgvfWUr4/BwPR+A?=
 =?us-ascii?Q?8t4Rzb5fHWtKg6c2sQ2FDsTj3vh4AlppnOSo1QtosYINeNdoObdC7yqlUTRi?=
 =?us-ascii?Q?177U9zP/V5DGgrP2qhxmAhJUdRWFs5DPLu1RXYRJIyHPGSjsbqjy1WS0EhuI?=
 =?us-ascii?Q?1Ui/yz57OHHdQkHEVM9tZa7eu/bol8OTzMK3i2FMhuk5UvH5e6fSP0G96JK3?=
 =?us-ascii?Q?YSeN4XcBLxKK7Pk7+wiKrbJtMirkU8MOuNgFG01yhbA/yOtzaPqWZTukAExj?=
 =?us-ascii?Q?lMU57wPixv6ZHf1VvZKWjbkHDI5wLXpoiF0ICmPSQMU7zbqhSyQbIqJj4U7F?=
 =?us-ascii?Q?GKOMI0aASA7x1adql+7M0wk/kaiHT09vdWjT1UNa5+mD3Voy9dVx+vBYXvJH?=
 =?us-ascii?Q?9vxG18quhs1aMLTw7DfqZYnQ4WzBleUDP6kqhwV9LGmrP0qURFZfQkbkMntj?=
 =?us-ascii?Q?1q4yd/TbuRpnQR8Bwc2wFksdBLAK634L1k94AhG0Q4u7aXVOU9fkursGOLf8?=
 =?us-ascii?Q?58fnPNXk17+XEQMStQLRrAqgyomSDmAewaTG3HpUh9BBnor9BPXdIek02bCz?=
 =?us-ascii?Q?MFvN9IwQfdKR5MEZykjytHi+ZG7PEjDp225H7oYFoqRfSLmETSp93CuGe7oG?=
 =?us-ascii?Q?uM5izz2jvUpGWFHH4bngzXco31E80GlwCodptox6KF5MlLvKpil3HHkTxyTV?=
 =?us-ascii?Q?m4Hp7sGHkb0nM5uIWrv8wMUzyow8rWNKqtaDv4pjgNznZ2N4kDnk2jzYbliX?=
 =?us-ascii?Q?vLyBLMhJhEPtm1FR6MCzL7ZX+NQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c809a04-bbb3-4fe0-1696-08debd522376
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 07:16:01.2033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMR7IEqDsmvXexqR3BVQ9EUPEkD4EnmP8A0Byh4SC5Xw7s87N8+PWKS+SQ813rEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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

The "len +=3D sysfs_emit_at(...)" is a common practice in the Linux kernel.
Its return value has no adverse impact on subsequent calls, so repeatedly c=
hecking the return value serves no practical purpose.
You may refer to other usages of sysfs_emit_at() in the kernel source; none=
 of the existing examples check its return value.
(this may be a widely adopted convention).

Cc @Koenig, Christian

Best Regards,
Kevin
> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 14:19
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>
> Subject: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie pri=
nters
>
> In smu_cmn_print_dpm_clk_levels() and smu_cmn_print_pcie_levels(), use th=
e
> sysfs_emit_at() return value, break out of per-level loops when n =3D=3D =
0, and use a
> shared out label before updating offset.
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 77 +++++++++++++++-----------
>  1 file changed, 44 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 546e64e3ba9c..0a745afa8552 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1384,7 +1384,7 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context
> *smu,  {
>       uint32_t min_clk, max_clk, level_index, count;
>       uint32_t freq_values[3];
> -     int size, lvl, i;
> +     int size, lvl, i, n;
>       bool is_fine_grained;
>       bool is_deep_sleep;
>       bool freq_match;
> @@ -1402,7 +1402,10 @@ int smu_cmn_print_dpm_clk_levels(struct smu_contex=
t
> *smu,
>       /* Deep sleep - current clock < min_clock/2, TBD: cur_clk =3D 0 as =
GFXOFF */
>       is_deep_sleep =3D cur_clk < min_clk / 2;
>       if (is_deep_sleep) {
> -             size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk)=
;
> +             n =3D sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
> +             if (!n)
> +                     goto out;
> +             size +=3D n;
>               level_index =3D 1;
>       }
>
> @@ -1412,10 +1415,13 @@ int smu_cmn_print_dpm_clk_levels(struct
> smu_context *smu,
>                                    smu_cmn_freqs_match(
>                                            cur_clk,
>                                            dpm_table->dpm_levels[i].value=
);
> -                     size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n"=
,
> -                                           level_index + i,
> -                                           dpm_table->dpm_levels[i].valu=
e,
> -                                           freq_match ? "*" : "");
> +                     n =3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +                                       level_index + i,
> +                                       dpm_table->dpm_levels[i].value,
> +                                       freq_match ? "*" : "");
> +                     if (!n)
> +                             break;
> +                     size +=3D n;
>               }
>       } else {
>               count =3D 2;
> @@ -1437,13 +1443,16 @@ int smu_cmn_print_dpm_clk_levels(struct
> smu_context *smu,
>               }
>
>               for (i =3D 0; i < count; i++) {
> -                     size +=3D sysfs_emit_at(
> -                             buf, size, "%d: %uMhz %s\n", level_index + =
i,
> -                             freq_values[i],
> -                             (!is_deep_sleep && i =3D=3D lvl) ? "*" : ""=
);
> +                     n =3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +                                       level_index + i, freq_values[i],
> +                                       (!is_deep_sleep && i =3D=3D lvl) =
? "*" : "");
> +                     if (!n)
> +                             break;
> +                     size +=3D n;
>               }
>       }
>
> +out:
>       *offset =3D size;
>
>       return 0;
> @@ -1454,7 +1463,7 @@ int smu_cmn_print_pcie_levels(struct smu_context *s=
mu,
>                             uint32_t cur_gen, uint32_t cur_lane, char *bu=
f,
>                             int *offset)
>  {
> -     int size, i;
> +     int size, i, n;
>
>       if (!pcie_table || !buf)
>               return -EINVAL;
> @@ -1462,28 +1471,30 @@ int smu_cmn_print_pcie_levels(struct smu_context
> *smu,
>       size =3D *offset;
>
>       for (i =3D 0; i < pcie_table->lclk_levels; i++) {
> -             size +=3D sysfs_emit_at(
> -                     buf, size, "%d: %s %s %dMhz %s\n", i,
> -                     (pcie_table->pcie_gen[i] =3D=3D 0) ? "2.5GT/s," :
> -                     (pcie_table->pcie_gen[i] =3D=3D 1) ? "5.0GT/s," :
> -                     (pcie_table->pcie_gen[i] =3D=3D 2) ? "8.0GT/s," :
> -                     (pcie_table->pcie_gen[i] =3D=3D 3) ? "16.0GT/s," :
> -                     (pcie_table->pcie_gen[i] =3D=3D 4) ? "32.0GT/s," :
> -                     (pcie_table->pcie_gen[i] =3D=3D 5) ? "64.0GT/s," :
> -                                                      "",
> -                     (pcie_table->pcie_lane[i] =3D=3D 1) ? "x1" :
> -                     (pcie_table->pcie_lane[i] =3D=3D 2) ? "x2" :
> -                     (pcie_table->pcie_lane[i] =3D=3D 3) ? "x4" :
> -                     (pcie_table->pcie_lane[i] =3D=3D 4) ? "x8" :
> -                     (pcie_table->pcie_lane[i] =3D=3D 5) ? "x12" :
> -                     (pcie_table->pcie_lane[i] =3D=3D 6) ? "x16" :
> -                     (pcie_table->pcie_lane[i] =3D=3D 7) ? "x32" :
> -                                                       "",
> -                     pcie_table->lclk_freq[i],
> -                     (cur_gen =3D=3D pcie_table->pcie_gen[i]) &&
> -                                     (cur_lane =3D=3D pcie_table->pcie_l=
ane[i]) ?
> -                             "*" :
> -                             "");
> +             n =3D sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
> +                               (pcie_table->pcie_gen[i] =3D=3D 0) ? "2.5=
GT/s," :
> +                               (pcie_table->pcie_gen[i] =3D=3D 1) ? "5.0=
GT/s," :
> +                               (pcie_table->pcie_gen[i] =3D=3D 2) ? "8.0=
GT/s," :
> +                               (pcie_table->pcie_gen[i] =3D=3D 3) ? "16.=
0GT/s," :
> +                               (pcie_table->pcie_gen[i] =3D=3D 4) ? "32.=
0GT/s," :
> +                               (pcie_table->pcie_gen[i] =3D=3D 5) ? "64.=
0GT/s," :
> +                               "",
> +                               (pcie_table->pcie_lane[i] =3D=3D 1) ? "x1=
" :
> +                               (pcie_table->pcie_lane[i] =3D=3D 2) ? "x2=
" :
> +                               (pcie_table->pcie_lane[i] =3D=3D 3) ? "x4=
" :
> +                               (pcie_table->pcie_lane[i] =3D=3D 4) ? "x8=
" :
> +                               (pcie_table->pcie_lane[i] =3D=3D 5) ? "x1=
2" :
> +                               (pcie_table->pcie_lane[i] =3D=3D 6) ? "x1=
6" :
> +                               (pcie_table->pcie_lane[i] =3D=3D 7) ? "x3=
2" :
> +                               "",
> +                               pcie_table->lclk_freq[i],
> +                               (cur_gen =3D=3D pcie_table->pcie_gen[i]) =
&&
> +                               (cur_lane =3D=3D pcie_table->pcie_lane[i]=
) ?
> +                               "*" :
> +                               "");
> +             if (!n)
> +                     break;
> +             size +=3D n;
>       }
>
>       *offset =3D size;
> --
> 2.46.0


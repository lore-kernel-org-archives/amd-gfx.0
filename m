Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B287CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B1610FA70;
	Fri, 29 May 2026 07:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W543pQgj";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6554010FA70
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 07:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzzlwaDl0U7LupRLpLELnLSPAnIY5s5KoWlxa6f+5Rz/PQEY4h5ZOEuIbRiVcYkC7XppgVywFH0w8pEyKybOYhdvNvNuyFV8+6xyXp8v6qkXtxHp6pvAcpx7BPOfJ9iSTYeIcP3qGW0P71qhf99Pbb8Kv5LOLpxld2VTKj3AU3/kSQW1r28LKJYMTj2TtYSwtmMGDJVzrPNmi2sg9sTGcEWrG8Enm72ALsG7IeKJlojbrt2cq4BUN+l8QMpSA1Qal1sAh6WARK+u6nhldWo7Lttj5DkmeAhLPpLdamDmNBym4VtBeLEfBgyP3KZQfsQsWOW06GcrkYUre7sUTrsbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO+GfnAUtUjvLwB5DiSpEl0qc9IhBNabm5tWQBaYGgc=;
 b=v1xsCwLJv7h2L0KnrVhQVKDllB+TZVOrZVa/bl0StlEti/P0hCF+7NBigptsXUijTM/5ImrZcL0r3JbEBIBJiKtW+j9vDLUzUgVmCPjgAmgD5Eh3/61b+251EoNcaXt3pgVwGRhCh/PqkJhR2u2t4ziigkJFuj/900P+CiYf9XOHf9X3uZMgCUm1RLU7dKMopwJX3w4yYLu0zuEmYESLUJkqUDQUGNsRzWrjp2kUTZfktA6IzkwLnhIf5aULmkiRw5bV1B05I50D61k5k3ZswS9hVzmkWCEIsrHUpTyTZHGup0Z+1ReIdlfJmw8kY049xidx79glq8B8rB8v+rQYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO+GfnAUtUjvLwB5DiSpEl0qc9IhBNabm5tWQBaYGgc=;
 b=W543pQgjKAsmwswRxZn8TAb4TAvdZraGV2Ai2bxT2kS59DMav9dwykxIQEO1mMlpbOrsRRoqiCwQWfXCO73DFX9JkGZYlob/2Kx0Vq2pWwFoOwqB6BgGXB+gGmqpDz2RaRr4emI7gMXksh7p5WAxdGUGtPCnYlvC3GPfIN99jIo=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 07:59:36 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 07:59:36 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
 printers
Thread-Topic: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
 printers
Thread-Index: AQHc7zMiW2LTNbWX3ECuIW3HIwP5w7Ykl5uAgAAL01A=
Date: Fri, 29 May 2026 07:59:36 +0000
Message-ID: <DM4PR12MB503807B3B231B9FCFB6517588E162@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260529061920.357400-1-asad.kamal@amd.com>
 <DM6PR12MB2972DCC91EE8D0476171F39982162@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2972DCC91EE8D0476171F39982162@DM6PR12MB2972.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
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
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|CH3PR12MB9100:EE_
x-ms-office365-filtering-correlation-id: b9bbff01-f662-4314-2cd5-08debd583a2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007;
x-microsoft-antispam-message-info: LWugbYB8v6UTEVcnwby48UwCkws4FyolNigBjFukw2fWNscKwsGxpEm/NsJIZZkhosx5efNStc8yPfD2hmw/C0SC31rvfzUr89+bEQwwUxN9S8Lhadch0BkamZwd34W64bqE5LWwb0B3PlMhkLq2AHdS08tWiV7xOctmwygHaqzJIG5EMK7zrkKtkY6bvrHrP6CDpzKJ0DH8elpzrxa6T4QMxkzO9Vra9gydWfbWNrJ+eww5Zx8YYSi7RqlsyX4+Wc8qdJVM2C+H8XzzeyJHSrF2paoeLdsU4RvRwH+XOPvy9xkJuObtvmdaV+wAxkCLppkIfFceGXR47lAmUegX2B9BAEliz3sSHDWzlqijdE68bA+w/logh1fekwNk3gCbLkiVHIVHV7LL5KbP3lzSiNVxCsSdR5t6TtW56AUkuN4zYERObQdjLOaJMZAQ87XsPbNNii0hbNJo8+rH5XVbsy3urlBA3nL2w+96oSGs2MKehHKwev5fbtd1/VkCfac460Dm//qA9T3WXUmDI5CmFLEc6JECTP3FMBPLnOScYvH1PbwCfJ87Oqju4sfJjDWyEhcZpeORJokKLkG5JrBRoVdN5KX4f3HS3O48ePtu3Zy+bWVMwC8P+uk6VYzvfujUwQ1kynpbked6iqzF75M99uPSjpKuFqB6lmmiWUBU2IZnX+XXYqo0U0+1C9K6NXMJ1V2RbOYmhlZJjDoE92k/+KTaAaQHlgXpA3NK8GFxSLT8TSV5C5S613KXR/GH6E6+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pyzx/tS3KYh9CX1S5g5YiLyOAV9PTorqg3h696EZuP2G3mCyU7btRgs2Qgn8?=
 =?us-ascii?Q?pYWZiF+tD0i9OR4Q24fv9ma/88wsgFXH8YOwnhUmMV02EIsHKSD2NIrUj85g?=
 =?us-ascii?Q?2UNZmqJNGJw09du8jLUDmrtC4/mVa2/NmiiFnCfCu5T62916Q3xlLakOdgXG?=
 =?us-ascii?Q?pJii20UWqGwO5cI1yhSvSXa6/CJnP1UxixUNAQK84/OksMYg/6RzAcZUTdaD?=
 =?us-ascii?Q?3m8kvrGTi/fjFvsStXTvbFplrJz004L65XUaVGsZY9NClE33ZvuXzIbcqoXY?=
 =?us-ascii?Q?zyr1KbHan/iLeEp3SplRyNz7KC2AGNkAqdXMV78giLVcrupvz0EZh5aKklRd?=
 =?us-ascii?Q?LMyzB8aipl4eXajMcN9PdHCDtHNDOPFzrPiYufYGQZ8cWE9avF4lv9keLzVw?=
 =?us-ascii?Q?Jk/9qUpes+H42Dt1u2Cfoz8pDJBHtHQJhGD2ju8n7IDhCUHkzIxyNjAIpJXW?=
 =?us-ascii?Q?Wo0IoBXR68MiMFI/9/S1+rvkXzER3rxQpP2YuMtHRmcFe0VEaURDQbZPTmgs?=
 =?us-ascii?Q?oCqprrzokFPlSy5cl7NOaz9lP1TwfAAGpcAPUhcrydbkGZeUR9XA+AlGAAjH?=
 =?us-ascii?Q?RYvtAxCYKT7CrDKLK/6VfeCXRT5FsQL7vp6U/ow7fxjZZA165v0QkKUTHP2P?=
 =?us-ascii?Q?xOsfP4S8yGliwXm1gqNogOPOmGiTe4ORqz2zQXUQYldMqlgSjN759yqTpvI6?=
 =?us-ascii?Q?ivd6k4AXYoADDlMoidqRNS6prFRIZI629fIEiO5YvYS/94MumVAhn1PqqfOG?=
 =?us-ascii?Q?mhqVZRbErWeEMzUHCIohNUa44f5NiKb3x1pPXa2R348SLgRx2vBDzrE6XdKf?=
 =?us-ascii?Q?vPftoAR4bO9iaAom2/DpSDEF2aM6AFubIKEJ9zH/zmZkx5BWF3JQeKGb4oIq?=
 =?us-ascii?Q?FooQ9UGKjPnlgXdDHIMtJU0pHbZZamF5LogvPgwhXxXezC375VuR6e0bcrJ9?=
 =?us-ascii?Q?wpscSXmy2PF6XwHf75LqCmcYD4xosElIKkFOgl36dVrCngTZAxWtIb5BgZbo?=
 =?us-ascii?Q?LI1OLWpS69CV2/9ourWfsSHrH53Jm7ZgnlZzfTgs4uZlGJnm8GGJo5D0MHZ6?=
 =?us-ascii?Q?XEFsIrX3FXf2WmxF/fPCpJntn4VQV8aVThqxYbylKS6KwcTD5zLZBGHYI04J?=
 =?us-ascii?Q?eJhDu60uceCesz2sBRqmMBZBQw9ibg1+zxubVZENx9HsPZLNq6KLEfkJXNuV?=
 =?us-ascii?Q?72IUmt+z7x65wTVKVpk513ETMEVki0RdPgKxLV4jX/89kodqC4LbM4ZOjpeK?=
 =?us-ascii?Q?VVWqQ0wQx7z/BJqAAYaDfpStjLLthuSrBaXFFY30KlySYK6J85Vs/UEzgMFJ?=
 =?us-ascii?Q?YZjDP4ntJ8+lb4bVBY28W/+HQWSkfKTwnm1DOf80fcbfvW4FsdAw6F6nrEWW?=
 =?us-ascii?Q?RhnPvLRHtyboeUHsRceDRg72wDsLaOYmrhPh90nqP8zuOx9Om4ltK1xej2oX?=
 =?us-ascii?Q?C1tVpL3VVDgk5GPOUCL9xach60plfsOAr7DtYry4Tpifqa9cSpLGQKXXkyC4?=
 =?us-ascii?Q?Tt8JHqMlXcTB93bUc971Qik6qmwrG8VDAInR9z4hbW1F3VYSW0HNSgs8H7bc?=
 =?us-ascii?Q?oPw3Joox7ULv40GqoP+L59jVoex9qAiNg6CpP87e59wFF2O785LqxQ+8nipp?=
 =?us-ascii?Q?X4iC3lZeWUD1XuAapXLNpvn0vNmZ34OgCYBKFz72ZiYt+apX+cLs9fnY6mRj?=
 =?us-ascii?Q?gMRFnIysdehwB4UsL2lDDp1jf9Bq5x5irmyDc72s6yuz+NKE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bbff01-f662-4314-2cd5-08debd583a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 07:59:36.3001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYSvY8AVNF16QYGCyPAz9FtUxdDX3fqjx496Hh9rrTaSOR5145TvVtVVv80LIL7Coprc0Qb52DUVuK2DRf/N8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

Thanks for the review.

I agree that size +=3D sysfs_emit_at() is the common pattern for simple sys=
fs show handlers, and for many SMU paths the output is small enough that PA=
GE_SIZE is never exhausted.

The checks were added specifically for helpers that append many sections in=
to one PAGE_SIZE buffer, in particular pp_od_clk_voltage, which calls amdgp=
u_dpm_emit_clock_levels() repeatedly in a single show(). On SMU13 OD paths =
the combined OD/fan output can approach the sysfs page limit. Once the buff=
er is full, further sysfs_emit_at(buf, size, ...) calls hit the at >=3D PAG=
E_SIZE WARN path in sysfs_emit_at() and return 0, continuing the loop only =
generates warnings and does not improve userspace output.

I'm happy to narrow the series, keep the return check only in multi-emit/lo=
op paths (e.g. smu_cmn_print_dpm_clk_levels, SMU13 OD emit_clk_levels), and=
 revert it for small single-shot emits such as smu_v13_0_6 where truncation=
 is not realistic. Alternatively, we could add a single stop condition in a=
mdgpu_get_pp_od_clk_voltage() instead of per-emit checks.

Let me know your thoughts.

Regards
Asad

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, May 29, 2026 12:46 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org; Koenig=
, Christian <Christian.Koenig@amd.com>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie p=
rinters

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
> Subject: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie
> printers
>
> In smu_cmn_print_dpm_clk_levels() and smu_cmn_print_pcie_levels(), use
> the
> sysfs_emit_at() return value, break out of per-level loops when n =3D=3D
> 0, and use a shared out label before updating offset.
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 77
> +++++++++++++++-----------
>  1 file changed, 44 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 546e64e3ba9c..0a745afa8552 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1384,7 +1384,7 @@ int smu_cmn_print_dpm_clk_levels(struct
> smu_context *smu,  {
>       uint32_t min_clk, max_clk, level_index, count;
>       uint32_t freq_values[3];
> -     int size, lvl, i;
> +     int size, lvl, i, n;
>       bool is_fine_grained;
>       bool is_deep_sleep;
>       bool freq_match;
> @@ -1402,7 +1402,10 @@ int smu_cmn_print_dpm_clk_levels(struct
> smu_context *smu,
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
>                             int *offset)  {
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



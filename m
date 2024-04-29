Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD1FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F129910E24F;
	Mon, 29 Apr 2024 07:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s1hsHnHw";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F3110E7A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCpQAuiWBIZQZVX/yGiE0JstZ1AdcEnggqxX9AAVR8BC2LGuzkrGMbHJa/dA8lBT+QYr4PczYy8VTpqjoZeg7pOE7eKSXJ21fENsJY57AZDpz16r83FN9anWFoQ5y3BtprujJiJW8aNZ1yaljla16+iI979UK6NsQGTIpT+w5FVOf4HTmt6pV+iGAXxaMb+GMAj+1H4cHcJsO5bwLyNZG9XHXvTyuAP1iXnxo5PLcNE6rT5gxvxac1DIzA9cqP7FpY1lLY+/VIpQ3egYhBWRqp3Znl4IJtSQs8cLmKGABQ56E2qJwK6FwJDgFPDnUwEBhX5Pr6spiDM3aU5x+KpkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uChuvMjSXPOBgUMhveVZZFE0K2E00gUeXTe4VEhc+K0=;
 b=l5vL4nFd9rHHcBZZGPUsiEmMectDZ6krMyLY2aJ2oKNixk4ccUYHYY2EjEqZ8oZzIwSu8r0+dhf0otaVWZ1LzIIR4qwWxrM48Lg2m/K3TFuYq2nie2YZwlZ9Myq1UCcKlQQOduiPO1o2cIl8mzEYJzEYplANbErp0iYRBD14VCRKjUmPnco/cp9bzqmXPK5vPZWmKlfKTMQ61LV3Vr2mUSkJjrTo+o7QQBWuNJA0YcM0prHBCCHu5spW+8mz13Tcbkf+45r7lgP/hQioyIR0/1FuMyEdW0UjqApGqVsYrew2y6M265N2scUg9T3xDep8OYKsvIO1ZnA+a4ziyMHGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uChuvMjSXPOBgUMhveVZZFE0K2E00gUeXTe4VEhc+K0=;
 b=s1hsHnHwnTD8i37qCJta27MS8P1LUZ56aTyMVMtXFFTWB8gvETjhEYxONvumInJhtetFNUy2NEEeVN0jp8btZA8ueKh0VpD+GoaJkoj3hGqcEuvrivN0a/mFSuPK6ETjhsryyo15JZHXo38IjykX/Nv0lA0803Lsq7T5axLiYU4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 07:43:24 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 07:43:24 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V2] drm/amd/pm: fix warning using uninitialized value of
 max_vid_step
Thread-Topic: [PATCH V2] drm/amd/pm: fix warning using uninitialized value of
 max_vid_step
Thread-Index: AQHamgb6/b8vmybsqUy2jEDJCm4YErF+3amA
Date: Mon, 29 Apr 2024 07:43:24 +0000
Message-ID: <CH3PR12MB807400B92CF24DAC33152240F61B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240429072922.2069718-1-jesse.zhang@amd.com>
In-Reply-To: <20240429072922.2069718-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cca7d0d1-518f-4319-9144-14859f631b59;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-29T07:43:18Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7104:EE_
x-ms-office365-filtering-correlation-id: 640f0fba-35ad-4584-fd1b-08dc68200cea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?FmYo17RLakYuG9V50y+XdjyjFF+pCn1N0Ur7GMazr5pv+hpFUzzFBeRVIOik?=
 =?us-ascii?Q?XH0QPDXQ5KtdbBymeSWdezzT/KFvGXQHrXSPmjs1ICoGDHJD3d534ocuJabf?=
 =?us-ascii?Q?AnSdYiBT6/nu/qP0xE1ucRbODM7o07823PGtGxEuWb4XEc5tSVa7K+TbCcXL?=
 =?us-ascii?Q?LF0Uv69HBd/JvfVeDLfSSjzTft50JeqEJTJFhTTkHLJJcF7GzlRohLivChGa?=
 =?us-ascii?Q?xwDo/ucREOXWo7n1NgJCru1Zy4lj6YgVyGams7r7/0vba4+iM1NtPx6Heipo?=
 =?us-ascii?Q?QpDFvivFZoH8OG1OfehA/vqOY4I2NITIYIhy2+WmgawduMhvbWiJByAuzejq?=
 =?us-ascii?Q?5lwm3poeADmSSVV8AEGcifVNgeRhwwiToMi/e5cleC+62FxvGB2R7hrwFPhH?=
 =?us-ascii?Q?f++nlm0xqGwjRJmHPFEftE+F3b3EvE8ntnjlYGy2ymRV2xcFEmM5OJzy/Lwz?=
 =?us-ascii?Q?wavfhGUxP3IG/PmGsJb7mE73gt4jhG50EvEqU6JrRkISRuDQXSYKjP26gy6Y?=
 =?us-ascii?Q?AchG5smpbZYvsQW1QtW48B+PPyROcv+9edPBkdlawFyrFlV/s3T4waC2+QyR?=
 =?us-ascii?Q?ZQN4BpiGDF8BgJ5BnHTtJHk1+LbtlfeeRNyhzeTJamnzZo6qSeCkGhEVpLQg?=
 =?us-ascii?Q?RZGhLuBLXF8OizM8p5fzfJM33+wrW4S9e+L/XpOXLXoSzQSIQtYPwuLtdxOj?=
 =?us-ascii?Q?Ayr46GxBxAa1DT/Tqlu0X2Ve1O9ZveTf4g7cv4WYf3naH88aatQwSvuiVIXK?=
 =?us-ascii?Q?tqEUKins7qL+IWZgXcyHCGkgCgpFST+tg9A30U2SUAwIm3hQ2l7mHTKrEphF?=
 =?us-ascii?Q?aw66utrBuKgcG87r1oOcDlyxt6gSi5SCxl7AiB6J1qvRgxN0P3O6+8LUHwZM?=
 =?us-ascii?Q?FViS8cQa5Q6z3ej+GSAFLB+xbFSXoGmS7rulFN5H0mOHmMGewz0jYP7TntZW?=
 =?us-ascii?Q?z0lKAQ6Jc35XESr9i2PhYXQG/6jXhRB253v/gw5LxEBk+r878I2oBbCxjHmF?=
 =?us-ascii?Q?n6oLuZIa9e0qBkHevMVxJJpb6IS6e9VBT17zZgHz1md7RPcHueDFhsL0rU07?=
 =?us-ascii?Q?G0H0Qqh7BXciW1XBsCAOiz7AtQzYwYn3Q20BLoSOcn75KDs80LzjfFEzv1hh?=
 =?us-ascii?Q?qgHu+AFqdv7kw72w7RaTFxNKj46AnkmBI423tb73fPMCkjeIX+1Dnh7Itw3R?=
 =?us-ascii?Q?vh40HwR2qvoNFTbuhm2reU6+HaM2u3Yhs20mMPXHglIyEkQFsk2krsVkuJGh?=
 =?us-ascii?Q?3pkL0cStKEf6qDrPVVLxx7zQbEdYfigPENuURD5ZTqXavxE3kHe+6MO9PBYF?=
 =?us-ascii?Q?lq2YGiJp5ZgnHLEU1XronMKGz16phHHtv7yyBPbJpgTVZQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TE3FSSA/Nfw8R60HgFUpYG4ikEOouICO0kznAmWVrU8xIu48VsrM43jVbQ4J?=
 =?us-ascii?Q?2zoqkTnra0Rd2evMJBvHIvGcgsNNVGthN7ujMH8n1FeogQ8rzGeuili2Mt3h?=
 =?us-ascii?Q?OwY2gsnZX2BbvPJ/M6R4l8GlZSofHrOoERD3Pe1OqUk77SiS7S47/IJXTcGd?=
 =?us-ascii?Q?wrUpfAi3nF/bz8WDiin1XXPg4s8KVeUiXHjnoRz4RQg7EgLLN5rKqdKBDQun?=
 =?us-ascii?Q?0r9jMPrfPLjLdQ+8OMsOpFUEkcuGQG6ZUWnSCLtmMBM9JnA8qOoTV+sBKZ/Q?=
 =?us-ascii?Q?PPzumupk+BE2lDxzc1M5kHHmTYRgrD5tdNZqaErpJgBDOmbwNgWK3NAsr88e?=
 =?us-ascii?Q?puwgM+ebnrIeOf78an2JkJoB/hsuioMqKUYA8xsWQGoGpHM6FtLzhBaADfN1?=
 =?us-ascii?Q?dJOby+wNTwrV4ExeWqBdg9GM4NZIaB/UjMltPg4k47TD2zxbEshj85vbwFQG?=
 =?us-ascii?Q?VlSkLSkFRFdbzGnZWLo4TlhG3IfC2as6cZj3YIulAJmMzyNoIp4Ehiu/PVG/?=
 =?us-ascii?Q?7rMp9vI6SquOBWoKaBbu+thvFLvbjNrY/9SD3Hi08mgipNp80GARIgIIT22B?=
 =?us-ascii?Q?8aZGFNOh7OhMF54agrXs4QJMXlwG0Wj6V030XaoRMfq5PFizuOlijuRk+qZ9?=
 =?us-ascii?Q?NSvnVcprStHX8aEmPi6gmgplF9Hh0ecmn21uLKu82z9odCoe+XKYDbgzABtb?=
 =?us-ascii?Q?HtAV8igUkZz8szB2cGZBor+73XmCaD36Ikx49cQAkfQWGwsAnWF/WUQHND0o?=
 =?us-ascii?Q?vG1s+QA0Dar32BRWo6KtwkHJ+9zlV+58l/5BSV4JdBf8WjPJvyTA1sX80jDe?=
 =?us-ascii?Q?NQTbqjdB/AN89VlkvUIY4imxzRJ+A3c4XkQkde58roqr1jFSFKjsdT/Us6u8?=
 =?us-ascii?Q?dBW1l5Ypw8H0iEYFaTp0sf0mBwxutY6LKD2+W37HowESUNvwKSoVYD+LcYD7?=
 =?us-ascii?Q?JQ0x7s2vD/BaApLPQhV+CzxARqxrtmjnvpL5wib/vqQr7VcGVj+vHKcpRImU?=
 =?us-ascii?Q?A5Sv27RHY5PgjXYE7tXwUwyilw4KV+nOfXMkuKQrxyzLABdFMwtbl7ZPDfIh?=
 =?us-ascii?Q?yrLw+a7mjO46RfXt2Mjs/hZ8yD0fQcsD3DZD3OC4fR/2u3l7PI3CTKZMdfbz?=
 =?us-ascii?Q?9HgMwlqLJhSTfX0zy6o71irKtJ6IQ3ORwXjvzWBulQAxprsWeof7U+QvaROo?=
 =?us-ascii?Q?3Qhgn1h3fjE5hcWddf6UX2S2AbrtNRaZIbg4pNXpIVnGChMAljHt5QiwcCue?=
 =?us-ascii?Q?WKc5NV6hVsyZwEyPnGEBgkQiCUtvbsqFJyQczMVKHkVTA3ayuGloYB2FSPbm?=
 =?us-ascii?Q?fofLiqsxykYQzJYRRNTDezFX9SvEN/JMseirBfOmJuIlu8Qofz1ZdxyvdTX0?=
 =?us-ascii?Q?0x3OdcL+zVkwAIqtbASiklAEHBpaM/yOviw3Tg5ziVN5Xltxxav5oaF6k3pD?=
 =?us-ascii?Q?cZ4e1b19u/W77BrfusQxCBUpgwFuj3A9hahUuPkjxSUjORuV0nTqB1Y3G8nD?=
 =?us-ascii?Q?IPpP2yOAurKnXZ3AhoAZ69R3UpTc3Da5vjcD/KCOzL9YAbbsrrSjdJQHe8c0?=
 =?us-ascii?Q?KcfPgEhRBT/HiT0BY0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640f0fba-35ad-4584-fd1b-08dc68200cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 07:43:24.4533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxC9twRl3OoZUd3uSoZSjVYe/9/DL35XBD0FDGo6CSl3E8/Lmy0OfKiMbF47hzwkucIxH1/esa6siZWW+WoZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

[Public]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, April 29, 2024 3:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V2] drm/amd/pm: fix warning using uninitialized value of
> max_vid_step
>
> Check the return of pp_atomfwctrl_get_Voltage_table_v4
> as it may fail to initialize max_vid_step
> V2: change the check condition (Tim Huang)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index b602059436a8..d004cdbe97b4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2573,8 +2573,11 @@ static int vega10_init_smc_table(struct pp_hwmgr
> *hwmgr)
>               }
>       }
>
> -     pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
> +     result =3D pp_atomfwctrl_get_voltage_table_v4(hwmgr,
> VOLTAGE_TYPE_VDDC,
>                       VOLTAGE_OBJ_SVID2,  &voltage_table);
> +     PP_ASSERT_WITH_CODE(!result,
> +                     "Failed to get voltage table!",
> +                     return result);
>       pp_table->MaxVidStep =3D voltage_table.max_vid_step;
>
>       pp_table->GfxDpmVoltageMode =3D
> --
> 2.25.1


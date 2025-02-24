Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D5BC021B6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 21:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71ECD10E038;
	Mon, 24 Feb 2025 21:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDRNUVnn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D9110E038
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 21:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqJrnBl0OXYzWbdRcuZ78A/L7Cv4tjM2alvWC4Aak9mb4Q89D0ADt8YR7MCnPS2QeZk74xPYROu93/W+LHniHmXtobxqpxd2ft4UZRxS6l1gIwQmmg1RR51MVHqm3aZgRTdxLlrIUcefYWC9sl4COkXZcb23+Bgbg/9qmLvdbCtA7TxFwWd/ja0U3ZOeFXZ7bGkoJEXuPSGWZUQZb+2REa16c4n2tJQHeJrMnpfvLJDGa83b6t/KezDwt+CpWwqxmM+p+sjcPnC5w+3B5Zw8KNBgT8JN5r426n4yxbAb49IsA1O1lzRi1dY9rNrGQVxy2vDNmbswMZwSWQsoHZ8ZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R63XdtihY5gepLcCPbcL3EiSM7+lCGO1IXPcxbT9rdQ=;
 b=OSksXSx8LDZR8InPjs5tfaDpdknGqHpuQ2/LRKRsiCKH73tsTmbyZhCSbgpAARpMcUnskERCuTD1N3bhb03/a2GWrxRcNIHJlPEHPh9+XnuAabFUGx1VWz55DojA+JVP5n31GWkaaQoJp3IhfAtDgvxWuCA42Nui85ulri+dDKfu5g4nmOkSdgSi8pdj8onNZQkzktdFoPtD0Y1rIvxtwkvgQ8tOv/N9M9xcrsBsGxPImYWgKQ2Yfler1B0K2Mq6Vk1nbGfI0oZZpeJx2+hpo6batlcM2OBvca5ful/qxJIp3OCThhsNl4mfeuzXZFTiHTNxoJW0WcNkl/zmvWDhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R63XdtihY5gepLcCPbcL3EiSM7+lCGO1IXPcxbT9rdQ=;
 b=kDRNUVnn4qW5V4jD0u+fCgY6nbF/82s0vsds59IkS7C6FFSnMfnTXF+UbeEs6OKG8gf4BrMcwwqJSd5I5oiq9EWSmzrGrtp1iw2HZEIMXao+mRDkyDBegHyS2sggAjE/R0Aw0uuI9cVYw/rHn3bSzdsJsASiMM67UR8WQtrnDYo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:26:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 21:26:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "amd-gfx @ lists .
 freedesktop . org" <amd-gfx@lists.freedesktop.org>, "Hung, Alex"
 <Alex.Hung@amd.com>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 2/5] drm/amd: Pass luminance data to
 amdgpu_dm_backlight_caps
Thread-Topic: [PATCH 2/5] drm/amd: Pass luminance data to
 amdgpu_dm_backlight_caps
Thread-Index: AQHbhIOBsP8YVNn3Z0aq0akZv1O30bNW++Iw
Date: Mon, 24 Feb 2025 21:26:15 +0000
Message-ID: <BL1PR12MB5144BE831F36EA57542CA1FDF7C02@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250221171002.209895-1-mario.limonciello@amd.com>
 <20250221171002.209895-3-mario.limonciello@amd.com>
In-Reply-To: <20250221171002.209895-3-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7381e4e3-45aa-4c7b-824e-f02400d00c93;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T21:24:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB8125:EE_
x-ms-office365-filtering-correlation-id: a0ef22f1-8aa6-426d-28cd-08dd5519de72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?N+TPeT20sBDNNoCy3uJyW4cTrLuTKt7UQ0uFNUzwHcIWnt16b7jNhT9NYnc0?=
 =?us-ascii?Q?V+nZXw72zNIqzYm2E1GEuhyW8O0hzgDy3Evrj1Pvmc625xXlRNGpE4Xv+AUZ?=
 =?us-ascii?Q?OccPZBpnei1qCYZDJqqXV2xa5baauXfrv78R3+dcnPubqOvaXDmW7fjprBsp?=
 =?us-ascii?Q?L1CSk1Jx15CcSlnRpcV80UKrciEIV8GRGOtiy4MGArK7f44XnNOITfslDJAp?=
 =?us-ascii?Q?joQzLtbVD7FkEApAt/5RFhC58G2B6olmNKFC+wlEHhYbtr2xW7wgxA/OuiSx?=
 =?us-ascii?Q?JnkVGfTPb9ZNmlyj0RtJdlSH/WnzfYHUv0vUQ/Exg3C630TiDeUnBRcA/UMD?=
 =?us-ascii?Q?VxeKmNgKuseGq1KjxclI3Eu7BrMJsl9LeVC0QRbjWxbxVqoOUIgiz+Opi/Eg?=
 =?us-ascii?Q?Q1wdjoG/cqBXP3G6QPxjlZY0TXR1cgdHWHmdZVpnVrE8BqnWnwQSfnNt7UqP?=
 =?us-ascii?Q?1rVyKNyivTO96VLvFIwlCFKwsPv0We8bsyBDakB2paNjcDMp51/6pG5xCun4?=
 =?us-ascii?Q?Oyd7qjiDReXa1B05X/432O58UF9qVoOMtyDLJvFz6SZiIkKW4DgzMUKfI9DY?=
 =?us-ascii?Q?tvUKiyOIaqoyV0ncCRKlIM5SICQxyQB+yMV1JesNFAlCl5Zb43Dy1t7ikPkq?=
 =?us-ascii?Q?gbBes5nC3oFfoZ+3JjVB3FybVQbwuu6ZoSIjB6LiKXHN5EJwRPThb1GMX13o?=
 =?us-ascii?Q?aD/T5bujj0A1MFvUnu6RKtfDVpGoXx18juQuYEtqyF4LbkP5iuBoDTDqFiW/?=
 =?us-ascii?Q?BD4BWomXTBfhP+GnKVBxhIXTvZH0NuWwl+mc0Wo1b4raveu56VKJJv1Nz/Ho?=
 =?us-ascii?Q?1avxvZ7ST/RE9QTgJfaAqYzna9cyBN40r8MkrrDCSVNvKueWqY6Sn0YNvgoN?=
 =?us-ascii?Q?Iv244FVCIJ56iXMmsKr4EvYvO6fxG8bamjktSIphZUN3a84zaB7G9iiREIdE?=
 =?us-ascii?Q?8bNxZezCxf4jBlWI+SAUlNYl6x9ZyUkBLUOlP0kaQk1m6Ao8cNiqVtG0Yk45?=
 =?us-ascii?Q?39ryg+LeO5ACsg+31uCcypFhttq9cxcAFKc0Sqkk6ru65Mvqm81k1kjXlkIo?=
 =?us-ascii?Q?Kx3bTPpi15JCxtRt4/VkMN+uMc16g+bxavNxEJByQkZPw3GdjbfC9LmyO1Zf?=
 =?us-ascii?Q?B5lQAUlc9zeiNjSUHblzj02Cla/h/O+9qHJJwesjdRV+ml4LoxL91IezEF+m?=
 =?us-ascii?Q?rV1kLwOywMoy8+YCLWVNX4H3C4oHSZBDr0eiitQCooN4I3sIPoODoWnIB9IF?=
 =?us-ascii?Q?H42wPgtwkwHI0cAYjI3O8VUNMf2f/ovVDuFIR8u/eUrIBegXkyb8Kr3cm4wd?=
 =?us-ascii?Q?YmIVwN6D4jFLP2TpVGY6hOOF/IdMv9pNDaaaBVc2ngy/pxFRRzQ6n2k41v0m?=
 =?us-ascii?Q?3ZcGtP29bkAM58O6PRDPerh6Ri9yOMLMq0nK4mxXqaLelizUCdORIiw+jjpd?=
 =?us-ascii?Q?juRPJPAWGnIW/eY1VoUDCTVizi/UIonu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RAHCL35XMYB9Hypp0XRS9BRf983tRTnUpjzPM8K0Y5ds/RO+rXJHKDJUU5lN?=
 =?us-ascii?Q?61chU4quTgI6C8ySB8lWFV+4XtCUBteFmgT6kOvgFEWvb5eAJc7yHHApMLfQ?=
 =?us-ascii?Q?dEHFmRIhdAYk0IGejpJlLPUOi3vwgw2wY7gQ/35hBoXIdXisf4dus9ILD9o3?=
 =?us-ascii?Q?6gP4tiXt69awdVxcNWvIOeHciRL/CjytxrqicmiJaHJTrGt6/VqgvUSrHSrD?=
 =?us-ascii?Q?uhpPFHaHfm5ICqjd0wnmHPo2U6jiuDEu0PY1w5LuB6HLFoA8upK5xxcS2eM3?=
 =?us-ascii?Q?AcGKIXTrNwKkov0eUWjxvI5WmzlPpQcajnPOQKvwxrjsenEy84l8IrLDVrKu?=
 =?us-ascii?Q?9WPN/q3H1UPiEU1lMhpaWpcSngq/PQdbvAFt2qrbbBrES2xk5P2Y5hpmpEZR?=
 =?us-ascii?Q?1kQK+9K1qcrCB1oxq+Xxzs02UwUZ2bTKr+UzzFY55GXcT34MscIqfWFFhD7u?=
 =?us-ascii?Q?W3rr5QH355Vx/WjG9ENSObi1wQbgvNtJIs0+mEwv3NDgbFuV43BvVE9jDRg3?=
 =?us-ascii?Q?y49/JiVk5t76+qrxOTNgVE7Cb3hxkRJ7Tcoi/Dh+IfNA1BuT2/CK7bzoVQLy?=
 =?us-ascii?Q?pIN9TUaq4mGSurgnGgzq97zDSNLr10DWW2Mljoo18h3ZS9bIp7kxPitcoGew?=
 =?us-ascii?Q?gzv7Kgk2nFlbST9R/itgwqRRCXqJl87xXNDCcaQE4rZliuIgmdkW6bqidc3J?=
 =?us-ascii?Q?K8H1hB6juhLUrOb91+37woRajLqxpEmbsudwC6Vri9MCh96MBG8T/F4UCfr0?=
 =?us-ascii?Q?GV9594ZAMzAPeSS2ZFeDwVTWGbdB0n82Bp7vVKDXukf20xL7+FR5pN9JnhCl?=
 =?us-ascii?Q?q8kB9VwaGIJs/dEKFP8ZTVp9X9bxWyr1EH6y6t/DVN9Vw4yOK19QEXdmdtx+?=
 =?us-ascii?Q?XN+E+0JWQ9F2lhXE4mARPjvua/nARqKEGim+FweuxMD/+0HlAKx9BkAeg7B5?=
 =?us-ascii?Q?ThJi97td1IHFTdPMrBUQbnwaENdo0kH7PbL96Cn8OXULNnQgHLfqCzpbNVJM?=
 =?us-ascii?Q?GIEJc+puLZ3jpTQ9YqKsfhRwzKTztFLeAQJ3htPFahYnvbyHzySBwDfMpDT/?=
 =?us-ascii?Q?C+pPcjGpJ7PQ7YvwQRStLYy4gxWzVEdRa4oCxq6uQkr+U2rYXHartzqCJEmm?=
 =?us-ascii?Q?iZpW604zOVWI8Fyvh0mxN8LQ4zRH2Ws5xs5PlyuunTLTrfTPfc/0fPstJO99?=
 =?us-ascii?Q?Upt89ErcOwl8zz27e7pkYKRbm3V+HjTd+3iZGytlI3aBQIsUBOy3SeO6HvOr?=
 =?us-ascii?Q?zUmxgZxzYrWGgmHst4o/uLtgYkjgFVibMbV/BNwJGLTXbDx0qCskmn+bqkvv?=
 =?us-ascii?Q?jfAeV07R0BDqUY4invSm/tvPro20FChI2pPDcgI51dtQT6ApYXs7HaWHB0D9?=
 =?us-ascii?Q?dyUukNtRQvYWGmOqwD+RvIPB6MY/3l1nJrcj60kNwJLqFqmimJQjR547zici?=
 =?us-ascii?Q?M6yoOXi5IjzZ3/OBPZUsy47KFhzYFJwkE5QSydukKAOEQrvXT5xCMFNrvV4k?=
 =?us-ascii?Q?v/Idplj5CNnI308R6PJOWNR9D8a4RoYfAfdfZu4bJETQU07uygZG9r7o1Wrs?=
 =?us-ascii?Q?Ixhapg8soOgnRpf9zCE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ef22f1-8aa6-426d-28cd-08dd5519de72
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 21:26:15.0704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28nCttU30r3+UZNA8mMSvQ4qYjvN1VRgW0M+uDnv025gHZA5M1p51T698aRaD/7UdNRizVRFwUlooR2R/Co83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Friday, February 21, 2025 12:10 PM
> To: amd-gfx @ lists . freedesktop . org <amd-gfx@lists.freedesktop.org>; =
Hung,
> Alex <Alex.Hung@amd.com>
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/5] drm/amd: Pass luminance data to
> amdgpu_dm_backlight_caps
>
> The ATIF method on some systems will provide a backlight curve. Pass this=
 curve
> into amdgpu_dm add it to the structures.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  4 ++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/include/amd_acpi.h        |  9 +--------
>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 515c6f32448d..b7f8f2ff143d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -394,6 +394,10 @@ static int amdgpu_atif_query_backlight_caps(struct
> amdgpu_atif *atif)
>                       characteristics.max_input_signal;
>       atif->backlight_caps.ac_level =3D characteristics.ac_level;
>       atif->backlight_caps.dc_level =3D characteristics.dc_level;
> +     atif->backlight_caps.data_points =3D characteristics.number_of_poin=
ts;
> +     memcpy(atif->backlight_caps.luminance_data,
> +            characteristics.data_points,
> +            sizeof(atif->backlight_caps.luminance_data));
>  out:
>       kfree(info);
>       return err;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index f3bc00e587ad..85b64c457ed6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -151,6 +151,18 @@ struct idle_workqueue {
>       bool running;
>  };
>
> +#define MAX_LUMINANCE_DATA_POINTS 99
> +
> +/**
> + * struct amdgpu_dm_luminance_data - Custom luminance data
> + * @luminance: Luminance in percent
> + * @input_signal: Input signal in range 0-255  */ struct
> +amdgpu_dm_luminance_data {
> +     u8 luminance;
> +     u8 input_signal;
> +} __packed;
> +
>  /**
>   * struct amdgpu_dm_backlight_caps - Information about backlight
>   *
> @@ -195,6 +207,14 @@ struct amdgpu_dm_backlight_caps {
>        * @dc_level: the default brightness if booted on DC
>        */
>       u8 dc_level;
> +     /**
> +      * @data_points: the number of custom luminance data points
> +      */
> +     u8 data_points;
> +     /**
> +      * @luminance_data: custom luminance data
> +      */
> +     struct amdgpu_dm_luminance_data
> +luminance_data[MAX_LUMINANCE_DATA_POINTS];
>  };
>
>  /**
> diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h
> b/drivers/gpu/drm/amd/include/amd_acpi.h
> index 2d089d30518f..63713fdca428 100644
> --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> @@ -57,13 +57,6 @@ struct atif_qbtc_arguments {
>       u8 requested_display;   /* which display is requested */
>  } __packed;
>
> -#define ATIF_QBTC_MAX_DATA_POINTS 99
> -
> -struct atif_qbtc_data_point {
> -     u8 luminance;           /* luminance in percent */
> -     u8 ipnut_signal;        /* input signal in range 0-255 */
> -} __packed;


I'd be careful here lest someone changes the definition of struct amdgpu_dm=
_luminance_data not realizing that it used here as well.  The ACPI definiti=
on should be separate IMHO.

Alex


> -
>  struct atif_qbtc_output {
>       u16 size;               /* structure size in bytes (includes size f=
ield) */
>       u16 flags;              /* all zeroes */
> @@ -73,7 +66,7 @@ struct atif_qbtc_output {
>       u8 min_input_signal;    /* max input signal in range 0-255 */
>       u8 max_input_signal;    /* min input signal in range 0-255 */
>       u8 number_of_points;    /* number of data points */
> -     struct atif_qbtc_data_point data_points[ATIF_QBTC_MAX_DATA_POINTS];
> +     struct amdgpu_dm_luminance_data
> +data_points[MAX_LUMINANCE_DATA_POINTS];
>  } __packed;
>
>  #define ATIF_NOTIFY_MASK     0x3
> --
> 2.48.1


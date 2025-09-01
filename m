Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8B3CA0FF2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 02:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9626F10E2F8;
	Mon,  1 Sep 2025 02:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VaCw1V4E";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC07410E270
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 02:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT1hpGesuPvPmPuQLdQbIpQuVCUaw48Hf+UqpIE0N7y0i5CxZ48XK0bHE8bWKRXA6Y0Lw1wv4xR28TUzskWKcVyq+RrNf0NwFiERSaxmzqUqlvQq+uzHcvrgddeueBMSfEU6RYpTtQdtbmJkZToOqp4YZKat5CS9WLEItpkXepxlyV2CWWa4ihC7OGiCQL9kkkvQAZu8QruARLOUGmQ+T+ZodHvnqqiq1nKm6yvL9D9/x16pcr0yuxCi7eyFQzFMu4WN/w3l9AIvZ8ah+toiGxkCseKxn0vcRfCbSgiTXdxQ3GGy9dPNN4n/aLODwIDfxukd4HRZPrcIxYHTH290fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paGzYOBtESaTjrUQuRPsnbzggP8UfLIlsqOI0AS8tes=;
 b=OtddRq3ZWAXuQewnuiGao/fnR68wPzIIh8hx8M8le97ETOjo2h5C/TKVHhN8ko7NsF3ZatkliGTf3OlGZ1HTzLRGa8NkA0uSkw7JWdyyZEiJI5NwBBN5u8C+XurjxSw/ecCnJ4vA3cP3ge3g29k0my+ZrQFG8nzZvYGvNMKdt4b/yxge2a1xwe3bJ+gpVVzBmmv2sEcYtYoTZq3w4uf8FFxzk1ppJgRpySK6U0FaDKaNVVqBPLVB70MD+QZ7KcWVr2cuCfjmQMwFbbapmEomtoTyyAefuw5UVW9uXbnTY0BRB3OrTxcszDlAu8nKJezJm4QL0K7u38t8Twk6JQBd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paGzYOBtESaTjrUQuRPsnbzggP8UfLIlsqOI0AS8tes=;
 b=VaCw1V4EwUDoSZU3BC+uoqcg0Ga1GJa6SVfgsQT6AO9NSnkX+uzCq6krA3PhBlDflimT/ClAOusIDUjFRB1rzDcg93DK+SqE4spAecn4lzS0bFaeIUbaHC/KQlNUYkc23mAwV2AvSDH6ImEoPPznwzpp+MJ03pyyLt0SXmttlEk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 02:22:59 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 02:22:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank info
 done
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank info
 done
Thread-Index: AQHcGI706MnofVQR+k2bwxHlsuj2MLR9nQIQ
Date: Mon, 1 Sep 2025 02:22:59 +0000
Message-ID: <PH7PR12MB8796EFBFA72BA7A4B6909F16B007A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250829024442.1019668-1-Stanley.Yang@amd.com>
In-Reply-To: <20250829024442.1019668-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-01T02:21:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ0PR12MB6878:EE_
x-ms-office365-filtering-correlation-id: 53bb98fe-f8e9-48cc-5ef0-08dde8fe7881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/xqQKDVXJLUocSTpJV1s1XEAE7/rMgUGU5qxwaZDomzSCCn0msg8a1oJ3gOR?=
 =?us-ascii?Q?L/GGPmk/2/zBNtuYfNYHW3N/2pLmzT1VgUt/B7caHGKVvVk0IruBnPoxW+Yi?=
 =?us-ascii?Q?hyMemq8W4qBYjx5IEcA+ibMRpo1HuBTJYkhtLxPb0tBzOgdJpjptIt3BOYkw?=
 =?us-ascii?Q?S2Bb7WgbiOzQmL6bO9KCcy/u546KmrYO+pYbd8Mm8uTTsbfdzgCX/1C2YC1l?=
 =?us-ascii?Q?OT5ZILr7RA+qkQWYdrM7Ig7EuhXRs5BPftBvTtm84Wc92MG+Viz03o5ufcrz?=
 =?us-ascii?Q?UEpTf2hYn6f/Di/ezHJyE9mrH0XyWDgk236jvdY+lQ6g8k0j6DY2FEYOkrdc?=
 =?us-ascii?Q?ppU90EYrDtopZ/9BjfJJFtF0sXfrny0xDIY/F9A1iiLihQnIrdnkRdige4c4?=
 =?us-ascii?Q?Mrub5ZLc518ceksi/nCe6SCIK83jM5GzESeA7hQxWNXWrNtaeH3fR08Yk/QG?=
 =?us-ascii?Q?eO6HQSxq1Eq1kQlWS2Bp7gXEUTjOvSLzYbWfliSYEtBFsfUYOIXEBHFuReey?=
 =?us-ascii?Q?AznlkYNGoM8aSZzOZrE2ls5iJyd3T9oWXBl+rIrxinEH5HLsv7m6iGXf8KNt?=
 =?us-ascii?Q?1CLNpUxi12XIvUeu/L8/jbFTOpbrB9Vmnj32LPEUuwuiFUx6q+/tDqvpnHEs?=
 =?us-ascii?Q?acYmsaYr351IY5D+KIFBaO7EADWh9vUb6gNOUsBGaSAUhg919Becij4JHj1R?=
 =?us-ascii?Q?f6ySG22EcNU47aGh2f0vRXI/+7orJq8XGL83JheJN5VZR3DLdh3qW+1UbULB?=
 =?us-ascii?Q?Jv4NGDuKf79tO+LiDtxEihblvD1qpKOi+mrlFus41EvbZvOw3lODL2W6SpBO?=
 =?us-ascii?Q?K+g4VLDCYj8qF0EfahtQen+EEvxSYLrxZn0CUogVuI+EUVlxQwBXYcABlPWV?=
 =?us-ascii?Q?pWVYT0EntBIA6uMuqV82Xo/fesi6RimQFGiSrF03AAppraTTPfVrXQYVq+Zs?=
 =?us-ascii?Q?7CW6I2zZcIvnRQwLZNjNFWGNuFBwcs5NpKqQw38ftYM2syBC8G1N1FKjjKoY?=
 =?us-ascii?Q?bAyyenPhuWkvObwt8Nbo74nltghLZ8phvrSvBm5JpI5RluMqhX5xh4VlhWdx?=
 =?us-ascii?Q?HxWl+TIsOLWNLAIXXBHdsdFNUwBwGQ2HRCP3OruJCKu3ha2rS318FdP67U8x?=
 =?us-ascii?Q?pZAoOSTrJvNM9OhNaPqh1N1WFSmWOi+TAf28+8wowB5ZQYKcl2TsB88M7UPV?=
 =?us-ascii?Q?RDblEHoCoIvV5wE658zCfztD20uTl8PNeW9dL1uUx5/BrqtTZQvywpStUogg?=
 =?us-ascii?Q?GRU8pxOqmeNXh5MTB14qoTXzuxhuXST9L/MP5xTOtDMKyRjlNGBzMdAVcnN7?=
 =?us-ascii?Q?u4XG3tn5bnYRz/QnHOXrr7L/eE0T0T/lia3u4mVBuHT/IUNcxiTpcS1t9jpp?=
 =?us-ascii?Q?6ejR/x45YpXwgzGonGJxCTKVhJAVJm5h8RTC8VB1nOBylWOO4GJLRHu3lFjP?=
 =?us-ascii?Q?6LnO0uiCdHcUfwrUzQ49hNvVUV1e34cQa5UtJDFOrXc9faqCTG7IZJaf9cNf?=
 =?us-ascii?Q?XSkVU0T2bKS9nHY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0vN1flDUAQ9mL5RI6nPRcFVRiSDgTwQoJuS9deMQdiikc5k5V+Sb2fMuWVwm?=
 =?us-ascii?Q?ya/NTXVYsB0elPBk+r1HdFwkDxEVq9G6OjgbyP06t120nstot70rqfE1W6pA?=
 =?us-ascii?Q?dMnmywzZ7d2PrOUyUiUJMfYp2gmDftB5nLZgzmxD70uUwOlrj24voueLaO4x?=
 =?us-ascii?Q?jviR0pzAteGR5nW2z7tNpUj7euCKK6wrM9Qjno6DIw+orhV60TnJSj+ocE83?=
 =?us-ascii?Q?IOl4f3cNdvEj5eO2RM8TK+8z8X2tG90zNC2/0gvNygBDnvgaGyiGMxlwr3ie?=
 =?us-ascii?Q?4zcYX/amEB4vXDiNqm1SP+d8RZHOhPpFoLUlJmguUVekenDr2VlkqalzQwQU?=
 =?us-ascii?Q?K4qaR0GrQT2oHSPHzaTv5Z+NI37AKwC79+e2b7gKOeh4YTXBtFRMD5v6Mr3C?=
 =?us-ascii?Q?uXqSm7JQakkms/ib30RXVhKn3ZaBitBvMelp19Z0CXepgq2F/R/ti9ck6Bfg?=
 =?us-ascii?Q?TlbUtdGhoIxYIwbWBd4wtrTsbSBo8CYw7jpF6m/v1/j8ZHLU01jmngrh+RMB?=
 =?us-ascii?Q?ZeC3UNnDlWRGfpfk55s4wpawPmWK+3qDJVCgmeqkv2bx7YgBX/g33oKYd3u3?=
 =?us-ascii?Q?sNFPHohtPCWLSbrgGT6y/s8ly99MpiCn3o8JRB+Uxl2zuyxZzK7e3PB6JCQ+?=
 =?us-ascii?Q?otKTbLuUQ6ujG9vM8atP+m0IvC1Eaei/lGDkgGc9CCDTtJC3U9TEy0QqHulc?=
 =?us-ascii?Q?aFeqsV4/t8qqwXac6dbO72W5ICczFYl8s8Flys9x0gHBFzsxBiYYJOdfbP5K?=
 =?us-ascii?Q?Lk1zy2+jLNGhRGNpPSPXbsJ0EPMp+/4trQD8ZSUkEsT3IYliin1XLU0vm+/7?=
 =?us-ascii?Q?u4l7w96h4x5iKTl76tcJIz2fGT3joja3GIq4Ek5mjewAHWesHW4ghSOr/0T/?=
 =?us-ascii?Q?r1pohoX3WVyFWmPGu0giALwbWpA/Tr7IfFKmWYLPLuogQnnk47pjR3kzP04A?=
 =?us-ascii?Q?1TMuxppSZGAUPTyvzM6fSvNoNExsYt57KHzitSPada41lCKQJRM9hcTO9GBj?=
 =?us-ascii?Q?sjRcYaHwY2DPK9HMGB+/Lwz3IhMLC4jGBBWGJWIDpOH+/hnB11TUJsvWZ5nM?=
 =?us-ascii?Q?c9rB+zf0sbN5hA+E0brF6q9l3Fa0FiYyBrz1+Eow0lvH2FpK4F87Na1m3OGy?=
 =?us-ascii?Q?BRCWNOSuhRynHuWdjcGngeY8jiIUTCqxJf7jWpdJ9bhWEpMiQuW/fhslglNR?=
 =?us-ascii?Q?ZVa4aqdm580EvA+Usui47PsimNDfxfs/tV0IChcecONg6c1+2zgNWvB7GKRr?=
 =?us-ascii?Q?P6F1a6qIpci5V5GOUiAJbmk7NI9LRj0hP8s0w1ZQop7q8uHHQtpivKKY2+wi?=
 =?us-ascii?Q?jG08bV5roBeKi5CDh6wz8wr9UfZND47kpQFIOlQi7AxrtG5kDSawf1zpbl8/?=
 =?us-ascii?Q?vNaY0yzxZ7sUw+w7jEnqUI18i/4FplxPP8B2P2sDPYLgjgJfNWrGJ12iediI?=
 =?us-ascii?Q?qDikWNnlOVPE+pY9heb3Ed7inm20KeK1h7oS7I3uP+pK3UjdaaNQrJzR+sG9?=
 =?us-ascii?Q?ycL8CxQflk7iFBvbovkOpVfGmI7rMvigH17P3JuWl7//y9EyifLWHBXhzzay?=
 =?us-ascii?Q?F7fuDfd9NJCHigvx6yE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bb98fe-f8e9-48cc-5ef0-08dde8fe7881
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 02:22:59.6976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtS2w0E0t7/g7CWD7FFkrx/nlCxBESjG0Ti6G8RotzhD3/3C1AmznGnXQa+yGk12
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

500ms is not a short time, not sure if we can decrease the delay or check p=
mfw status.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Friday, August 29, 2025 10:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: wait pmfw polling mca bank info d=
one
>
> wait 500ms to ensure pmfw polling mca bank info done.
>
> Change-Id: I50581f03929c86d75bf09d66238b64f2806697f0
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 096881c90200..be0da05aa9a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2705,6 +2705,7 @@ static void amdgpu_ras_do_recovery(struct work_stru=
ct
> *work)
>       struct amdgpu_device *adev =3D ras->adev;
>       struct list_head device_list, *device_list_handle =3D  NULL;
>       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
> +     unsigned int error_query_mode;
>       enum ras_event_type type;
>
>       if (hive) {
> @@ -2733,6 +2734,13 @@ static void amdgpu_ras_do_recovery(struct work_str=
uct
> *work)
>                       device_list_handle =3D &device_list;
>               }
>
> +             if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode=
)) {
> +                     if (error_query_mode =3D=3D
> AMDGPU_RAS_FIRMWARE_ERROR_QUERY) {
> +                             /* wait 500ms to ensure pmfw polling mca ba=
nk info
> done */
> +                             msleep(500);
> +                     }
> +             }
> +
>               type =3D amdgpu_ras_get_fatal_error_event(adev);
>               list_for_each_entry(remote_adev,
>                               device_list_handle, gmc.xgmi.head) {
> --
> 2.25.1


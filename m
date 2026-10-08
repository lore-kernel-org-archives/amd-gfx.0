Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E04FCA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B42D310E833;
	Thu,  8 Oct 2026 12:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nAVn4ro5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98D910E833
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sT4hzGyzoC783WckpO/wZleDwjbMqj0LhBZYKEeHLLPANIbsSXjduL7HdU3ZW+31mTKPgRsCUe5pY6GbGErz0SK7dv2FLvxzWyb3Eq6Fjxn5M1tGhL7mG6XarclSgGWOqr933Zd33waYC5X+hGkw0Qrfr5iQqKdBUpSjRpobAbWNeaRXNh9duVFpFPnMowHisviizFsd4OiU4wnLWfg0sMN4Cc8tf6tADVS0gSP/0aNyeYl4GqsIRL2grP8GaNK/0ITFaqIWLZ5i4KrZqvTgC1i54TKcgKflglNjI/xwkurDXQakLT/Ikcvbpb3lem2Ub4dwR17qtSMMFjUvqVSvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vYGWd5j4HPoEcGtoxxqw7Ggm2+Wf+bg+opXyhEMNA8=;
 b=Igy6PJDaTzRQ0YwLVD1if2KwUQg2E0wp/yDLFfgJ+pxnzqJneBd+Vwx787QvCuwWAMz/dOe+FuOL+KjghHJQwSkWz8Njb/fQcQTsA4cKncBaDt+oqY0+2LZcax2ZkAhOO2NaYGrCwpNobDwsB5dbK4zgGcXIwRup6myCPPM2ZzZNcrIUJI8a9nfZ/+blNLMakMwCzq8I90uMkFQnb1c+kww8MOxmr0CMJUF/37v5KIp+GsCf9qkMXCnLUE1du2WhD+0zLoXWsevdKJJwNxmbHd8NuJPz3k0U/q3AXfFhbSNbcFeEfLwbBLnnl2V1TiveKHxVtgS5BQQMshik3Vr5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vYGWd5j4HPoEcGtoxxqw7Ggm2+Wf+bg+opXyhEMNA8=;
 b=nAVn4ro5n5E3m6cd4SkMIHlUMKD9jJTjdbivjjGZPS6a5B8o/ENlGFJW5HSt6qVIvtrmcZ+71Nn/HQMw6Ms/wqYpg81pkVJ4t8t4V/+jVjsjWjUhAPCUQ2+VD1BFnKVgv6Tj/tbGCrP0f/XiZWXl3AxavGDJpDux2EvryEmifTU=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 12:51:35 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:51:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2 05/14] drm/amdgpu/userq: complete hung queue fences
 after successful removal
Thread-Topic: [PATCH v2 05/14] drm/amdgpu/userq: complete hung queue fences
 after successful removal
Thread-Index: AQHdT8U5zgImZtOS9UyxFzrXuBq5c7bzp6UQ
Date: Thu, 8 Oct 2026 12:51:32 +0000
Message-ID: <PH7PR12MB6000CDB154102C9FED5E3EEFFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-5-Prike.Liang@amd.com>
In-Reply-To: <20260929034650.2393125-5-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:50:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SJ2PR12MB8782:EE_
x-ms-office365-filtering-correlation-id: f43d0e25-484a-4acc-5b8d-08df253ae297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: TLQ2XKnXlt/Lh88jyK5PJOqvXRCHY3QXzXQ9458UCyguLzocJywYD1ogVf7nEeQd9jU/ikoshXXyP58crbQb833YYgb20kllis0huJLnd+VNnmgHnCUNxs5hlsKC0w9Pq8uVQFBKKUwjeVwQ7LHUmv1STacQLFEz311+m750CQPxbOGVSKYgy1JeXtX+6GVSkAnXJ3oQL+AgCoY4dZWfepJSbfXv0bvkYHS2iOvmlhWLFImAP3cu1RihPzFSQsbHmxt53F2NpDLs7s+/TCK+W97DBZSujJ27YypfPF8VhGeFku/A1VadqgOzRuwkkKS+NAygj5S93lbdjQLqhHmd4N2euP0OMgt6cIGYWD3x0JRREOKwe6etN97aUQfS1RszmyddxWhTElIGxdcZ2lP5iGEP/0tgX+b2s5oMcFWZkmockYMW9gGa1eqDVX6hNZfSC7hLp4BGnaCSpmrHofVLAsPhMnHXU0GvsYmj5MyLAO0dggWmw+zvXssgI++0T4lbeMzvz9rui2PnAYVsm6gFlfd/DlPaao4I5xORcYVL9XLvL1xFKh/M0S3X+IXeHXspLJlmbtz8/8+xUtxMMDxD85pvZ3OfugXh6x+vVOcoBAeNbpHJeSseE0dtrlKiVPtoF5QlMseVGy2WTWTb8CaWCkrzes2DKdfsk9VSYd6Hc8QY0JguCCZCnFTul/auIr7RQX3qYBVR5zK2qmR7dc/MV6dEQL0p9C/UNn2hsOAO79E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ba33FuNOHUz6bUeCibjE2vuJiO/ulyhTz7OPpTMbMUd0Oi4Tse1444t/PyXj?=
 =?us-ascii?Q?pCxoI03eDc/udcUtPcjoYJSa0Hi3V097X9PMODdl76OhKWbq0jK+oBwIuaxL?=
 =?us-ascii?Q?3gG6uswuwMNI7uhE774aklzsz5IVzFax2I2SAZrS8k7BBeY6OIdZctQ2u2gY?=
 =?us-ascii?Q?zIRTZv2xp//q74qSHz1lGf2yV8eLBdzLVcTBne6xRQaqMn0YsLXh75Rc1TT7?=
 =?us-ascii?Q?BT3ruAhuCQndclzM8MLLuI6VHKmSif82MDuGJCpj2D0MOeJ6rOjcS9uiA5n9?=
 =?us-ascii?Q?TLlNkrRJznmUjtNCILAiCbLUZJS1e25izV9qvHBCokv/bkzvyifXCDs7hBiV?=
 =?us-ascii?Q?eMa2nRNCeKcRr7IM1Rb3ub/wpk3C0akAtMSX4mwan+/Q0ht9p8EeyBJC8QBq?=
 =?us-ascii?Q?ATyg9jFzcSc6eGCQedqWWCLD5Ko0NyBNvRNutCeX0mesMz6iDgVLQgZNbSd+?=
 =?us-ascii?Q?pNCq3+TZTIU6YjpdzxSvREqFQl35StKtkiwsLGC4QkIwTsC6XjBUd6TF0Afr?=
 =?us-ascii?Q?ujQ+TPMz9VBLk5F60CuxZZQ33+DlI1P97mJb13WcteCDuaUlwArkajTz34Et?=
 =?us-ascii?Q?2W5VabA2vYhJY0ETiM668nwogkS943eIQFuQPKRp6027DFSY2nsprihT1tSA?=
 =?us-ascii?Q?+PSBZeXFndAgC8NpFb4dwpgKt0hqwlSljNZDw5cR6YnF5+17bXtc903O8gyb?=
 =?us-ascii?Q?o7QKSZtJxuFtt2oe46elLGR0gpQXbD+0htpY04uiy6iNwsl0OdY1BRIsKSp1?=
 =?us-ascii?Q?Kusrra0c5Fz99WBNAjuo6nv1aLcLIlVA2O+dbUwhtzj7lyyrRCo1fErfexRX?=
 =?us-ascii?Q?gF/vnPDOkY9IWkgUdnk4UNIKu+oDHyPOgc7eaVHhm389o+0hygiorUb81XIQ?=
 =?us-ascii?Q?dkxAWUTkr71EP8E+o82l4IEjpakYkzNX5mtI/urd5lp2jXF/898A0O+s7C2I?=
 =?us-ascii?Q?zbQfWnIF2GH/gWGPpwLEZeVj1ntckilTCxchslOC4gCMy2CtjGNtpiLVB6hs?=
 =?us-ascii?Q?aUXzGQ9zin6oDeVuyLT35FFBHd/9pAN1XpcbqRMJuqNhG2rH/sJko1+0HX+6?=
 =?us-ascii?Q?HMc16nPXN+4tR3sKmj7IEaHR8VywUULkEeGDCW67WTwP9x7ZWBsPbIC2sBoT?=
 =?us-ascii?Q?6NOHsZ5aT8DAfmt4t0RLaFFFkZzVEyBwu1imWV+Py/Kh4hP3RPSV6mCnEDUA?=
 =?us-ascii?Q?Q6fG1sM8UE1idLFGTDrH4ObKZgZK/KmbJbWaDGpt/NttKp9JehG/brNRwcss?=
 =?us-ascii?Q?TtONpe0nW1/Krvyw1g8Xr/Nltd7OpGTTkD30c3ee354avmp7Kk5rVcGq0pkN?=
 =?us-ascii?Q?PgHfA2QJLos/LI1pEHSyt+pvPHM522U9zuUBOJ/2MaYTgk2pAMcQ7R/v71/F?=
 =?us-ascii?Q?w8TY4haEZhLp90EpgEo2Rp5s9tXevbl6u93odndvUtHlLTrtf09EVYGYBcos?=
 =?us-ascii?Q?0QUBQmb/Xb3PRKJQ7HN1mHlDyZkvU3/Ks5JDLZaskFCHEI84efQtGveXUhe9?=
 =?us-ascii?Q?odWzEISPwfS/lA4H4wnNOwA8I54xi0+ZsGpxas9z4XnHgUsZaPBNAsQuGQ4a?=
 =?us-ascii?Q?covio5LncEukBKWiSf2nAym/9BWXeeowsoqgqMWkvFrqJFRam5Tfg95RWSpo?=
 =?us-ascii?Q?bWnidM6YVvxxFr7TEFbpTBWt+OmAgN3zl2QB2GkCWet47yXGTVTmE15AcQxL?=
 =?us-ascii?Q?eDXEFD6oKLVv7+gGu7KgPUUJ4l4CoTiSnjCKK34iuIOaQOsQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43d0e25-484a-4acc-5b8d-08df253ae297
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 12:51:33.1565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KK3XnmMymcLJWzsFO5R4ix0g3VlcQiMhS3IjrYSOvlKkV384k4OwsURmNte5UU40
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

Ping..

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, September 29, 2026 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Lia=
ng,
> Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 05/14] drm/amdgpu/userq: complete hung queue fences af=
ter
> successful removal
>
> Only mark an additional MES queue as hung and complete its fences after b=
oth
> hardware reset and removal succeed. A failed operation leaves its depende=
ncies
> pending for device recovery; it does not prove DMA stopped.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index fe49aa4dc5ff..3b973ea0c24a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -282,7 +282,6 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
>                       if (uq =3D=3D guilty_uq)
>                               continue;
>                       if (uq->doorbell_index =3D=3D db) {
> -                             uq->state =3D AMDGPU_USERQ_STATE_HUNG;
>                               if (use_mmio)
>                                       r =3D amdgpu_mes_reset_queue_mmio(a=
dev,
> queue_type, 0, 1, pipe, queue, 0);
>                               else
> @@ -292,8 +291,10 @@ int mes_userq_reset_queue(struct amdgpu_device *adev=
,
>                               r =3D mes_userq_unmap(uq);
>                               if (r)
>                                       return r;
> +                             trace_amdgpu_userq_state_changed(uq,
> AMDGPU_USERQ_STATE_HUNG);
> +                             uq->state =3D AMDGPU_USERQ_STATE_HUNG;
>                               amdgpu_userq_fence_driver_force_completion(=
uq);
> -                             break;
> +                             return 0;
>                       }
>               }
>       }
> --
> 2.34.1


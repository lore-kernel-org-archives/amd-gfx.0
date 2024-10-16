Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00AED2A530
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 16:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563E810E742;
	Wed, 16 Oct 2024 16:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lajckMn4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0094110E742
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 16:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnL4NNDKYnpbn1PB6Jzi9PQfvTOqVWgjls66h6CuwpJEBwLZAG30G/iI5J5xznLwRfXbqGd6qg+XOKbkRDbrfJDX+SQAJzc/JBuVd3gH3sjyjEYhXwyjK4Za3pMPpuuZWWO57dXDD4x6Ui4TnDv4uDRk7bVs/F1hREZhaq92CvK3XU6eoTgXR+au0CkeE9EkxVrmoXYhLTd/mTYBjjfX7sb3H/wm46sX5kMadPLo5n0v7HscFs4oLpqmW5/wHSXS7+yxLrO5RudoCb3s393RMk0MewdeDKCEeERLfjULNSIrKEqftBHWgjzDM779nIeUqhWe2D4YZbGhyKs9p6Fl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4WBgAULtDXNrMndY4QrQDcUpt87CdKeWNVlonYfrcg=;
 b=PvGt3jCMtHsncc2/fNmXJlIUHgNF3jVK1JcbT/M3vZ1hZ0l7YnEV8rq5dbplk8Oz8mu29OTGcQmnWBshFgXX+WJP5kcstK5nRXVkemGocaCzuaN1fRuFzLjKiG0qkRkU3vpvzKg9pHflD8DIiFRvtcYb9IpnU6HwYPl2QyBkqx56uKaAXlVW6vSJ9AGTlIyzXFvRMpwjnB9IWS98SFUIP2EQeiN0e76RIAO4GMqZNxtm8b8uRr7bSKZ0auGTnFxwk0XJr/sbxsnliKqEbqc7vExwahpWy/kJ40EPspnitsI23VWHCbZPlZZKT7k+f5yvCDYyLsyX6LoirAh32u0B7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4WBgAULtDXNrMndY4QrQDcUpt87CdKeWNVlonYfrcg=;
 b=lajckMn40X4W42WD2AhocrqxGAjqBDPrhmRtkj5z6u80zzoVmRh99txraZpXF3+yBS4CM/fBzz+zvymgPtXBn/IfrTXwNovVH7vFahu5TW5iY+UADIVAHDFDX8QYd9axoyduwdEFu8l10pQy/hudkW3Vf0SmIASvS8FDzZvGFBE=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:222::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:09:06 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 16:09:06 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>
Subject: RE: [PATCH] drm/amd/display: Ensure HPD source index is valid for
 dcn20/dcn201 link encoders
Thread-Topic: [PATCH] drm/amd/display: Ensure HPD source index is valid for
 dcn20/dcn201 link encoders
Thread-Index: AQHbH835Ph+XKbyJFk26RJM5ZUR7SLKJiW6Q
Date: Wed, 16 Oct 2024 16:09:06 +0000
Message-ID: <CY8PR12MB8193DBBCCD226E32F1437F4D89462@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20241016131845.3154052-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241016131845.3154052-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=10b74b3a-d673-402a-9669-10ca27ff4c15;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-16T16:00:37Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|MW4PR12MB7382:EE_
x-ms-office365-filtering-correlation-id: 6120413f-9c29-4348-67ee-08dcedfcdc41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3KUt0Bga2hmlu4hRXM3hr0QMcWOs7bfoIP/a5LmzoLQspA8xAZcT33jHzUma?=
 =?us-ascii?Q?9Psq3HfkiRP0hOdHe8jIdKFoslyjcy6jbrr9219KRugBk0kz31hYipu73PqO?=
 =?us-ascii?Q?e/JQlEL5US3aUIj1SWVl6bqu238HUbAt/tEwa63RkCFYmNLokpUiRT0TJ+tI?=
 =?us-ascii?Q?5ebg+CL48C3x1nTo1HrNcBetNLD6F0nYYdgQUjMQs+XT0dPWN1ggyNxbcKY7?=
 =?us-ascii?Q?CoDMjlaLfKy7CM9PkEzGfnvzwQtIVglcCJGvpSfUH9RLCVvJ59w96SxJdC+H?=
 =?us-ascii?Q?BwhkD+ERCmBq00oQRSbx9iexTyXL44HzlNjUTR3zBXQQTFB8B7GDtK/Fpm24?=
 =?us-ascii?Q?griLJJtEcp7djYYxdsNkY3zbY+h+DSzs6AUzj/3GYEQpHOfhxEapiqoiBfXL?=
 =?us-ascii?Q?Og/0r9VLdcP7AfJ6DnizB0vnqjdGn3zRELLEMAfJ23IdvhLsnmrXVgZsFxwm?=
 =?us-ascii?Q?nmM90igWvowJTW1BO7XrYM+YrkUr5+GVPeh6gtrRCRLPr+FT6o2HhtLaLYTN?=
 =?us-ascii?Q?npbPf5KBL09EPKpFaObVDmly0lOKn9+FNq542BtC0cWG1MsTt5axfw4Rr0OJ?=
 =?us-ascii?Q?xeC5AhDCcJ8w3yigT1JC2TODVP7C5lu0oMwGdbF/Aj1pMMIz+ij9c4Bk2fYs?=
 =?us-ascii?Q?yhv2Jn656PKDu2lkH6ghwsXconowmJbEW/8gdcViRZJM401aWEHfsyNnNfRt?=
 =?us-ascii?Q?d4Q2oilMyYR5u3230h6RF7rnB0I1p+Ds5ThkN48rq0zAU8d0kU2DxS3ETMuU?=
 =?us-ascii?Q?N2ynMxJ4cz78NuSxd2Y0BeHX6ESAIqwvd7THFQY0H1/orXjhU2qVYjVXb7Qg?=
 =?us-ascii?Q?EeVst0JKlCZJn6CGUR5Dk0DnhaHqQ4TxpVhuaJOWIiCE/jcxsdS3rvctpGNq?=
 =?us-ascii?Q?5MGYJa7AcP/xlhxacUWqTBZlHO6gywN0ZKsEncWH7AAppEYdJto5eDu3GSG0?=
 =?us-ascii?Q?Ux3JOxIPZ6tk1nV00a0puRKTEQ0f066bSQV95PfQQOJsTdlRM9E4ZWs/W+Ti?=
 =?us-ascii?Q?cVkB1Tl4VnWsO0ZhURw3BUgfbPo7PGGQdueYaVCQHn/+ZRC3y/VlB0jTErIB?=
 =?us-ascii?Q?oCdfI//+aHzEvmOnLt57yz+c8FLPOWGso/ozsEoGhqiKDwzvBb38HjsKcvVn?=
 =?us-ascii?Q?JIjwJ/VbV7CB8lcNzfNDwYV1U2U2ckhUjmmsJr4o5YyiSmqoBizChHiSLT0W?=
 =?us-ascii?Q?FV6AtZhyaX60Z7mKKwqrEX12KkuxZzwtHpddt7Nat9hGk4I+0ugaCSuAQnBg?=
 =?us-ascii?Q?TTElOeeMADN8zbnj5pwZxPzH7Fm9eFBcDz9vxSTx4vuvIzeo24U6DDUamYbY?=
 =?us-ascii?Q?LpFYYzE23f+Agtwxj+2P/X9xu68knOIw2L3G4Mq5Su1qOg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OuhqMLiW2UZx3vvhTUTu9o+1QEFg+JcxJey66YMUmI1ciD2e4Zj4nHPXEP7g?=
 =?us-ascii?Q?wUDqUOqK648oThILSygeLe2CAhKTCowQtCx+5KR3gUh11bc0vxrHK7SWPB+H?=
 =?us-ascii?Q?NzFb6NxckvxlT/1idsHUJgJ+sF08olvCpzWsGZGRBw4Ke3UxVi+iG/aDAUmd?=
 =?us-ascii?Q?Fdc7N1pZLwCkRN8V1n/0Ppkh3rfiHPvw96ylw2fDj9fU0srjqy6lvv+mal9H?=
 =?us-ascii?Q?eV1WDP2vxG9QZpSCJFBjssxlqJyH1rHgqV9wh4cp2fT+nbi7tfS0z9J3KB6Y?=
 =?us-ascii?Q?iewlsJ+NejZr+sZo0wQsIpQycDUm4PymKgaCX25917P6c3P8h1fqawYadT11?=
 =?us-ascii?Q?X9R9dvzPrfxOdR5IkA4jyyb2ydD3TNyEdk9SjCg4ou/DY30Hqa3o9MEIvE2B?=
 =?us-ascii?Q?N+KafBSZZIszsaOJq0XO9+y/j/tzzY4X+Bjt4KXd1UP6T04uCGFb1FEPSKlo?=
 =?us-ascii?Q?bhRrlw2LdB5VaBUFYNxn0Os2lUXQM/uXHXKLe00oV8tnWoMxpRrDsvvY8K4t?=
 =?us-ascii?Q?KnRM2LVSPee7F/TeKpHhkBqHzskNVuB5YUqqWMnbpxSwXOuPGlNKmL2UbE6i?=
 =?us-ascii?Q?jPCp7ahKgq446DwijWAKfATmOrZhT6+yxPuk9xQC62KrCi85sE21Q+lyCNgT?=
 =?us-ascii?Q?HSRHIIAmjPy7fWgyx95BnEpU5kBLnyB3NT13hLJplZmW/2UJkIdSTzQNtnOu?=
 =?us-ascii?Q?wpSMoUnhYJSP/mJIORseWOCjzwL9/ZDxCL+cOefv3pLLNDOvWnxJcoWr+lHU?=
 =?us-ascii?Q?q9Ma1c0zBGeOtVVlxqFn9LCM3hl/V9Xvmeh02GlJTwe4GuUepbbhkO6xXT3K?=
 =?us-ascii?Q?8NYMVDL0s8/twsShXmezOFSFqH7H5Af9d7pNhKEQfVTy7t4WZVMYnQeY9r0Z?=
 =?us-ascii?Q?U9bnTSD9BQoVDiHcKnLwMvUrMG+hOZBz77TM5BcXfNdSXmEd0FsO6nag5+Vo?=
 =?us-ascii?Q?dS9yX4j2YKnq6WvJ+M31PxPUPb4CJDK14Xtk9BWGpZWRqc8Ac0Cp5f5ZUOXZ?=
 =?us-ascii?Q?y3ApejKa+25OHiUdAx6ko/okcXPOJzw5bUx2/HKR81Fi8gUZmR2JGHyCIQi9?=
 =?us-ascii?Q?NQ/Ect7YtdQu1EHSTCqpexyuVdzIQX44YsC2ukS1UNAGXs90oUxgk691gQNu?=
 =?us-ascii?Q?atPckh09GahVJm+CmUUIxJkU/hU4maH3/G9iPjFH3PPZ+N+DXcWuHGd8lKoy?=
 =?us-ascii?Q?jBkTKg8zqOq3OA0mT3Fgy6YxtZLEUR0UgC05u5EviogXXUei8++KDW53vULu?=
 =?us-ascii?Q?WHMoJZm2TZzTCJshI/k58FEzGIir5S0HhjuW6MezN4/trrHjHzBUENvR7bW7?=
 =?us-ascii?Q?mpW/IRArwJm0peMML7XJK9FMViPEpcZO9Gvcz1sDVxiTjDUglbRHQUpGdcdk?=
 =?us-ascii?Q?0YXLW42wvNBqfXyZjt1KxAmIvZudkxXBB2ELn9OvYEnp1aHMmYY5ASsA7PQU?=
 =?us-ascii?Q?bFeNAzWKN9fKh7a289LQwWoqyngTT7D4LKKEg7fw14T+djoi9KWOMIVEJDKO?=
 =?us-ascii?Q?AW58Iunke/PJUXa3JSzUyoiGUr90ujmKroHFZ3yQ+9U01x7BbuhbdCBX49lA?=
 =?us-ascii?Q?Tv2k2A0FEN6t2q2jaAc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6120413f-9c29-4348-67ee-08dcedfcdc41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 16:09:06.2530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4mkMXfMzJHiiTokOg1ghM+NAY+efc70K+6gIQ0nG7/YhnK64Tq5zpL5yqXxuc24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Wednesday, October 16, 2024 9:19 AM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Mahfooz,
> Hamza <Hamza.Mahfooz@amd.com>
> Subject: [PATCH] drm/amd/display: Ensure HPD source index is valid for
> dcn20/dcn201 link encoders
>
> This patch adds a boundary check for the hpd_source index during the link=
 encoder
> creation process for dcn20/dcn201 IP's. The check ensures that the index =
is within
> the valid range of the link_enc_hpd_regs array to prevent out-of-bounds a=
ccess.
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c  | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource=
.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index eea2b3b307cd..288189913e1e 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -920,7 +920,7 @@ struct link_encoder *dcn20_link_encoder_create(
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>       int link_regs_id;
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       link_regs_id =3D
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> index fc54483b9104..15180ad71513 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> @@ -797,7 +797,7 @@ static struct link_encoder *dcn201_link_encoder_creat=
e(
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);
>       struct dcn10_link_encoder *enc10;
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       enc10 =3D &enc20->enc10;
> --
> 2.34.1


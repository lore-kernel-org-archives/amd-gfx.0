Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C051CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 06:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C075610E1E7;
	Wed,  5 Nov 2025 06:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZTWC7fMy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E819710E1E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 06:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LquA556E23DoOXUlWo9wKjyzS1z5F8qOk7Bb5qyIDliSH6YUaiTjdDgf2y73xmtwYSDU+jaNEv2TK0+ITeDHO8q5b4I40RY7pdjhyOUAWK0BxHq7BjYDARhDP9xaXRrUC2IVCIKkP1527h+DbWshLye2g++/hFiG15MYNouow9pXCHiu1XrK6Leo8DLEFkXUCxGwv7BU4lJHTVxKGJLWtvYTROfo52pnfr9UtYGwGVQfijhkpOmwMYtHp88FDKKV2c30miNjMY4chlUUnX1HovmJicqReSULtM+gZXgZqDPoNifjAVlZ8b5LHjfd00JV8rgVXN0rsXyY0qUJ6VSD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAHZ8PeeBKnzdZhLwkwWQAM+Xljl67HphlU6X80Zo/4=;
 b=UxngGbMTrviUO1pCpoOoZi6Mgr/r8pD62JQIqD7E3Mk4NCl2hTfVO2GWEEg0jUpvxcuwmq3zOrEFVXY/b8yRCA4KGsl2Ww/W46E+lBkF90agKGsYfCuUUTLhcFXiqSORo1S0Wf88mIlqGup0IKqQMhfFACYyDq8y2QseHJAcaeHrr5L622DUbKGLWZJSp7DAYGOjqjcjfjokTr9hxwWboC0vGo5GTBNrcubRikcRzrNtWJ3zjmWriUj5d1p8J6t209lQ6UfFD1+GLv4ew1MhGktJBW0GuXpNzI3RVLd2U3Dnzc9fE/gxCEhsdrjUEICxVpb9wWgd20FZD6dYFBkUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAHZ8PeeBKnzdZhLwkwWQAM+Xljl67HphlU6X80Zo/4=;
 b=ZTWC7fMyFDSqBZ4BHHxlBKjK6jSjZ7DAzT9NtVkjlq5tlilnnnkUVVH/xLF3zMZv/RCT1y+EmjomqlsV7x9WwZnG672x+/skEd3p2oy45w/QgLscI4SejEInAMBI0nfdOWAjWe08sWI3KjQ/y+tch0n57e/U9UrsC2xp3blI1Ls=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 06:47:11 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 06:47:10 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
Thread-Topic: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
Thread-Index: AQHcTfiXXDxnsN/uHkq4J75cdJZKaLTjabUAgAA6NpA=
Date: Wed, 5 Nov 2025 06:47:10 +0000
Message-ID: <PH7PR12MB879699E3091FBB91DA77419BB0C5A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
 <20251105020445.1423034-2-tao.zhou1@amd.com>
 <PH7PR12MB599720B798D3B16BACF3218E82C5A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599720B798D3B16BACF3218E82C5A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-05T03:13:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB8906:EE_
x-ms-office365-filtering-correlation-id: 12e64b7f-0dc3-4dff-ce3b-08de1c37254a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SCjbVkAlvTd0EoKWXyh/9OQN1wjmuICkkwkbxDTUGO+x/zjXykOgRkuCNnt8?=
 =?us-ascii?Q?oHwPjzuyztgjeIa3eiHYqHuAaZwhLa5KYYDT0aHowvQJfQ5gGff6Rta6plfA?=
 =?us-ascii?Q?MZ/gMqNAqM/CQZlcc6g9FGICR3AmM8vHVY65yVy6qUEYKUHM6AQr1OYkfPOX?=
 =?us-ascii?Q?kHkwamQouS2mctRK3no6T8VaKQaMcUxQNYnUUQJnF0tOLBKKHYpNCaXWcsLa?=
 =?us-ascii?Q?yF5MzglXXe0WGUcfH846L5lwwLFx2l89kQ4FIF8f1qE/kFWjVGWOjcc5+erU?=
 =?us-ascii?Q?35eLxdpTQ4vsKvQFTjLlFOg20luSzqE94BORh/TYxVAg8ud4F/0wxHLsOL9j?=
 =?us-ascii?Q?ZkDGhiZi2FRCgtCek/+eYw1Igf6D8UARqMfW0od5dPqbJZMA5L0pjbuBfLI+?=
 =?us-ascii?Q?MldNQxzqhk9GkUSTaCauMPBUlVXWqR41o3cwf63XSddzhn1derEMCBciM7G/?=
 =?us-ascii?Q?ftLVvKhaQ4CRnExutBXnVT3DfbnWZDLZNTuZjZI8PoiZQJ45I9G28YKv0v0E?=
 =?us-ascii?Q?ZnahVjfgLot3E4x3NZTjY26Axewv8hHe8vWTtj1BzXZRpqB/QNVegkxR+V5C?=
 =?us-ascii?Q?Resw92UNzV2fMSGfEu+IdUUJdTs7tNhBIXqcKmbVwQ3Nx1UqXqyfuag8ZPdD?=
 =?us-ascii?Q?g9PBR2PbQPRTNXoPnPXbPb1lC/DiCBO0Ki4BSJNjZagq0TJKe3KGAuXRnaQ2?=
 =?us-ascii?Q?i3yR+63B/Toz/MRhCfeOpoKa1bDs1pyXSJqcE3S5ts25T7kyWy1PXHpNnjGm?=
 =?us-ascii?Q?S3X7G2/gMR/RTlQZuijmF2rAYyIcpw4nE+fffCmrYqutxF2V0tYXDmAva3s0?=
 =?us-ascii?Q?GBpcDYYWja15NZqHBXC3NaljI+kvNZCsUKtfQ00Ctzt9kFYFn3z57t1uy8HY?=
 =?us-ascii?Q?OyFIcYFfATUa0oiNajDM2dnsEUYcUT0qHZBg2c49XThdKU3aEy2zVifK1H5P?=
 =?us-ascii?Q?keZvDRhVgJ3mtJqUoPBnRaDK9PXqvM/H4Cojo2gDv6SYzK3k+Tz1mBWTpG8H?=
 =?us-ascii?Q?fAgWSQiSPXMMIgy7gn1MdFedOgpXVpsAsVqiHOl2r0uO485HnK57VOKWvRIr?=
 =?us-ascii?Q?rraFGms6bHa9gaBXgnUVdWrYZGItroAjzCYkRjgjW/P61cONs0J0TVjhgJBQ?=
 =?us-ascii?Q?1+G9tX+ZDXoTW8wsrGxDyk+eBy+2l20Jj2r1wG+ija6shYLC6iaRBWJLZ/R9?=
 =?us-ascii?Q?l1o2E7yezqSMbd144xzHJt3eJUK6GNFzFZ23Y7MEyTEZ5LngWV4UDA0Y1VE+?=
 =?us-ascii?Q?kdZDa7Zwc3YQgUSGCwEBU8dLf+YIku1uBT4S2/36spd1ItW9gmQ1TxRtJUgX?=
 =?us-ascii?Q?hNwOZo505QBAlx6otvFZ/cxRJCUu/gqE+nkraV/Ph+kN84KeVzwnlUL+8LJv?=
 =?us-ascii?Q?9ww8QxYtRcZJw8lqaVaHoFuIjhwp5CWk9mV3XQOVswEeUuIfCLVwBI+5FVhC?=
 =?us-ascii?Q?BNfrwRzyCS1+8CD2c9o+Msut14YLFzsvqZjViC7tBjFnbP8UaL0nxG+Dz0zO?=
 =?us-ascii?Q?2Lwoqj695l6BkqOVv0XPCxlYYbbpcQt8I8df?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4AQMHmh9bdp5LMTroYX89fVUDq2y/UMpm6LX7ifGbhxyHXqhjKOqNgdvVmE1?=
 =?us-ascii?Q?qTY5tKEKLO4SSLBhYTm09V7FH8MXOEAGzTw889KOjNeBk7wVepVcKHvdo9St?=
 =?us-ascii?Q?T3Mddtog5/dnSgXoSaVjtAhDGh/x49x3bG/l6WGUlZYP7xcnq/gm9mY0ulXK?=
 =?us-ascii?Q?602Hxhc2efQ3CTWyVu9VRaHEGp8lf8IB6aeZFU3gtb6XY55QwOdqtFlOf0O8?=
 =?us-ascii?Q?MygAZrYD+i0JhtMgKTE9xGRJ2+bHaJS6eH/CffcFlHsPMam5QIxsFT5n3nYm?=
 =?us-ascii?Q?bXGruboF15shelYxSwqe0yIlsolSecB6Pm8ZwK9Pixfai0NjLjkGTszMm12p?=
 =?us-ascii?Q?kGjt6ykRzpI1Me+39E/Zs4EfO/pUiCVZnXjJXsF4OHOGnvU2l/hz6UIOP8qV?=
 =?us-ascii?Q?Ps5NuCkmK5fP6i+yIVEhwUV+GpNIx8WccynN/sB1Lp9dTe4CWOhCOnuX0kIm?=
 =?us-ascii?Q?sWz9w67O0DqNobhGFBOYaE3+Pief6IoBvDkkqdWgq8ij7/KPevnl6Lq7zPNl?=
 =?us-ascii?Q?s4uNN038ZTiWMVexAqh7fi44JjJH9txbRPoGCpaj1n+oValSYsMfqlZUHyYa?=
 =?us-ascii?Q?F82rk8o51BsIRf6yyYB8H23Ln8ovPGFrr4rwmfSzWDuV2He8u0mGFnl4gFRD?=
 =?us-ascii?Q?BWny3TVvjva7GmEqMHcGB6dEXLLpKzvnjdHreHeCRBAMxz+LJ/lbmbS+8Iqy?=
 =?us-ascii?Q?aS83zbN+sCNXYJnaMYC6/Nl+eDOECTWwC0uys3vZXZSaGClkJdE+CSDN5ZR3?=
 =?us-ascii?Q?893E95ZvRwaZSlGDnGg23z2Nh+9PiGPnzoswup6JXSMoIepF71VibH+hrdLB?=
 =?us-ascii?Q?vNQ5cwBJdeXYWi1YuSPL5Aym79FIIIltipPmutx9ALaOlUgtFRK3cFMAW12+?=
 =?us-ascii?Q?YaSM+qc0/Az7OlpstnbJwFIuF3ph2rBlM1pcyOrkEBNg9rHD2XzFqUm51Y5t?=
 =?us-ascii?Q?qG1PzMy+kqPYxwf4JjqtIFji3BampOPCcB/ez9feoV26bzYA42s0ph3OSqK4?=
 =?us-ascii?Q?jZE+rTHnmCDDzE/9D1FIgJfv+S4Cp4/UOi7aevaBLeWCvbLKTjCh77lAThbR?=
 =?us-ascii?Q?oZ6mM9Hx9BCf1OfcSWkzoFWDHn9x9oIaERztXuElpBdCK3dGLVOWBHKwBmgM?=
 =?us-ascii?Q?2gwIjC34mPLlGyFKxXe01IpK+Wj/3JInZX7/CwLOebBHNnTZ41g3gBiPmaj9?=
 =?us-ascii?Q?plwr0JTfhEM41LIEZYYn4N8vQECRUXolMTJKBh47KRD7tikudoWRrLKd7AFB?=
 =?us-ascii?Q?a0c8I/1/rxBCiSbQgUByEGPDJm+hLM/GRain27znVyb2LMIvNq51X8GsT+u6?=
 =?us-ascii?Q?dzo5xKspskMw0NcX/FZeFds9XM8mG7caVJGkD8YTsxStziLuTlpdplGSh9Jl?=
 =?us-ascii?Q?s+dlo4tq9//H7k60RTWmsPUrxQ7r5cvbyt+Z7L/kq0chBvbHz03JLXJmIsvK?=
 =?us-ascii?Q?F2lcHdHsJlhB9RHeSRDDdKtkJ9DIiseu3GcYCVGw9m4Z3QPIZjV7UR69mhus?=
 =?us-ascii?Q?zPfzM4e/RkQR225U5a1Udo5+2YJ6y+bzYWos8WIqJqR+K7aAcdwTzMQ2fDXl?=
 =?us-ascii?Q?Acvh+fnccUJYJxr0wVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e64b7f-0dc3-4dff-ce3b-08de1c37254a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 06:47:10.7611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D43ZE2EDxhaEcVpjw+OB8Ik/oKiSP+nG+hfZUzCMwdh/Qc2t8Xxm+oTia/hBCa8E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, November 5, 2025 11:18 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> +               if (adev->umc.ras->mca_ipid_parse)
> +                       adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
> +                               (uint32_t *)&(record[i - rec_idx].mem_cha=
nnel),
> +                               (uint32_t *)&(record[i - rec_idx].mcumc_i=
d), NULL);
> +               else
> +                       return -EOPNOTSUPP;
>
>
> It is better to remove the null pointer check from the loop and perform t=
his check in
> the early stages to avoid unnecessary operations With that fixed, the pat=
ch is
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin

[Tao] thanks for the suggestion, will update it.

>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Wednesday, November 5, 2025 10:05
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
>
> PMFW will manage RAS eeprom data by itself, add new interface to read eep=
rom
> data via PMFW, we can read part of records by setting index.
>
> v2: use IPID parse interface.
>     pa is not used and set it to a fixed value.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 51 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
>  2 files changed, 55 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index d7e2a81bc274..47f292557a0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -970,6 +970,50 @@ static int __amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>         return res;
>  }
>
> +int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control=
,
> +                       struct eeprom_table_record *record, u32 rec_idx,
> +                       const u32 num)
> +{
> +       struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +       uint64_t ts, end_idx;
> +       int i, ret;
> +       u64 mca, ipid;
> +
> +       if (!amdgpu_ras_smu_eeprom_supported(adev))
> +               return 0;
> +
> +       end_idx =3D rec_idx + num;
> +       for (i =3D rec_idx; i < end_idx; i++) {
> +               ret =3D amdgpu_ras_smu_get_badpage_mca_addr(adev, i, &mca=
);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D amdgpu_ras_smu_get_badpage_ipid(adev, i, &ipid);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D amdgpu_ras_smu_get_timestamp(adev, i, &ts);
> +               if (ret)
> +                       return ret;
> +
> +               record[i - rec_idx].address =3D mca;
> +               /* retired_page (pa) is unused now */
> +               record[i - rec_idx].retired_page =3D 0x1ULL;
> +               record[i - rec_idx].ts =3D ts;
> +               record[i - rec_idx].err_type =3D
> AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
> +               record[i - rec_idx].cu =3D 0;
> +
> +               if (adev->umc.ras->mca_ipid_parse)
> +                       adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
> +                               (uint32_t *)&(record[i - rec_idx].mem_cha=
nnel),
> +                               (uint32_t *)&(record[i - rec_idx].mcumc_i=
d), NULL);
> +               else
> +                       return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_ras_eeprom_read -- read EEPROM
>   * @control: pointer to control structure @@ -991,6 +1035,9 @@ int
> amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
>         u8 *buf, *pp;
>         u32 g0, g1;
>
> +       if (amdgpu_ras_smu_eeprom_supported(adev))
> +               return amdgpu_ras_eeprom_read_idx(control, record, 0,
> + num);
> +
>         if (!__is_ras_eeprom_supported(adev))
>                 return 0;
>
> @@ -1162,6 +1209,10 @@ static ssize_t amdgpu_ras_debugfs_table_read(struc=
t
> file *f, char __user *buf,
>         int res =3D -EFAULT;
>         size_t data_len;
>
> +       /* pmfw manages eeprom data by itself */
> +       if (amdgpu_ras_smu_eeprom_supported(adev))
> +               return 0;
> +
>         mutex_lock(&control->ras_tbl_mutex);
>
>         /* We want *pos - data_len > 0, which means there's diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index cfbd402ddea2..e881007f715b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -186,6 +186,10 @@ int amdgpu_ras_smu_get_badpage_ipid(struct
> amdgpu_device *adev,  int amdgpu_ras_smu_erase_ras_table(struct
> amdgpu_device *adev,
>                                                                         u=
int32_t *result);
>
> +int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control=
,
> +                       struct eeprom_table_record *record, u32 rec_idx,
> +                       const u32 num);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>
> --
> 2.34.1
>


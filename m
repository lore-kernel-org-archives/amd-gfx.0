Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580F8C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 19:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41EB10E0AB;
	Tue, 14 May 2024 19:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b8dgF9Uq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE2410E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 19:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5iBGu9k25GfNqnOvXESL6PJLOHhPQy08uX86usJclGM1xYMhdi/vIYQmHCj3cBnMqjlxXOnj5JYa76tBoLf87B7D8DY+zcv29IfnuGLPw7EkwGvv3Kpo1aEIW/E0+BxL5UQyYvIBsCnwFU/xLL7AnXYTGDtx+V6emVAk70ABcLHttFlB1wQn7lmPJrVgURNppWa+5XRRkEYU44RPwT5K7pFGSYVmUnnN+JiC5KSCFbQ/PP4dkIY5WpJjw+JGb/TOf/tE1mWFxpVF6+Xo79twwehywMjwOXBlOLMsNMq7e6QXy+qF3e8ps6qiwMYo1QwKjn4slWvSrAW9wcDWch2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFrIE/6i/K2lat4qm9oNCuWU/KPlwEHGDdpYzgTMHKk=;
 b=FG7oonI9NrlKCrVCaaB9QhFEy8YTgXbHbfqExwc9hMs9PSGA6Leq7XvqZObX5q4VDuHNQ9Gy0EIWy2xZqAKVos/LqqFUC8Y1N2+mgAGfqvWk192ykIfbWwalTW6kYvxtV5KQMoD7mnA/oSRu09u+xNdcJ3Fk9TzgjjfFkevB9V1Rcwdlmtd8v1RJG61TaJpSmTW1I1fPhtOXdBcQfOcrugnbUqxUsAOW1UVlGhuaudFi2OeiTQeK7t0HG9ARh5u2iwHWq41Hm085LPohvuh4d1Wi2tgdl/zf/R5TbmnMwrHn0okpIyxel+HOkeJZX9AzsxvVsDOOFlKj0Av87COX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFrIE/6i/K2lat4qm9oNCuWU/KPlwEHGDdpYzgTMHKk=;
 b=b8dgF9UqbGyXJFohrCT2tIRweHh09rSVuCX7kxTs+yDQnNzpVx4Nw5PSIFVlvaFwD7Uwo8iNvVpz1jd9KBfwV93eTMWquMQHCfr6/jAzCihVJltAFqEREyvlV4P3OBiovkFbVT+DZgw9Gn7qIYJ4uItsAMCgf98ptfxJWvdeOt4=
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 14 May
 2024 19:28:56 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::2e76:1977:c456:6faf]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::2e76:1977:c456:6faf%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 19:28:56 +0000
From: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH] drm/amdgpu: Add documentation for AMD_IP_BLOCK_TYPE_ISP
Thread-Topic: [PATCH] drm/amdgpu: Add documentation for AMD_IP_BLOCK_TYPE_ISP
Thread-Index: AQHaphFfNUncczYWmkCUT9hh+O2fJrGXG2ZAgAAB/bA=
Date: Tue, 14 May 2024 19:28:56 +0000
Message-ID: <CY5PR12MB64299A536CC4473921C7B02FFEE32@CY5PR12MB6429.namprd12.prod.outlook.com>
References: <20240514151353.1072181-1-alexander.deucher@amd.com>
 <BL1PR12MB5144B3AEF3E9B27068E0D14DF7E32@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144B3AEF3E9B27068E0D14DF7E32@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9207ba2d-ee8d-48f7-b5c0-ed131d4ca7ac;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-14T19:20:33Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6429:EE_|SJ2PR12MB7797:EE_
x-ms-office365-filtering-correlation-id: 09190179-8e7f-485c-fb88-08dc744c1912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?9/diaJNcDZ9b8rAepp9TECP1260qaWhyYGz1u39TC19pK7626Hc860cMd4FO?=
 =?us-ascii?Q?GhSWz2c8gQnB//ADZGiaoEVm/7MylEE4CB/xH1qG5a2Ur4SN+rQO4UoArhMH?=
 =?us-ascii?Q?rWHZSP12h4m3dC5UWFWLk/RaNyJhRCsuvftjW9/m2qOx+K9lT8Kkmripg8KF?=
 =?us-ascii?Q?coitRHrISqx/7VfzUKfB82R3ilaWq4VAmyBiGCADQmG3S0qPIIJ7wZAJVsqp?=
 =?us-ascii?Q?qWEw6W5z08vfHzOBQvFpbHj4XM1OXt10eYYana/lKzdsRC75a9G2QsYv782/?=
 =?us-ascii?Q?xLgkVh9l6GhzA6wWpQOpaKI5VomFAB2kjJu7IhvjwD+xtwoJYGjwFPId9Blh?=
 =?us-ascii?Q?1jnr3SiIxua/xC/8HBmnSSshNH6E18Rn/KEUPU5NQZl8Sg21wIQbSOorEn1W?=
 =?us-ascii?Q?dKEBLk4Eg4o9ndQK/KU2E2q8alLPdWEER0VPt4HhNI2AtHpPm3qVuoz5tk2G?=
 =?us-ascii?Q?8HtH9fKuPFP+i1xaV+Vtdx49ZF9pTALVoH70lW4LC2l2A7dqjFEl8TLJLPAy?=
 =?us-ascii?Q?eFNZP6SKJMsinsRrziPJqqM02HVh8SKLLDml8h6qjHeyXhGAu1mPyrRMnGBU?=
 =?us-ascii?Q?qry0EdZdgK95Nfq8PtrlohtWRbixLmDudaRebtSU72UWsCJp15cuAtcVcrEH?=
 =?us-ascii?Q?ANJCl/VAsC/QxXPg/lhdVM6QnYLi1icBT7PpdkKil5Sm6uttwGq/LIkOsYKH?=
 =?us-ascii?Q?0BFWSFq4Lpn27/1xK+o6ZC8m9fXMIP7rzas1wYoYmCLwhmQGNaWFOjNjJE/1?=
 =?us-ascii?Q?Q/GJNHcLXjt+OjJ3yJHaqeZnTVLgncJ+kRxA4A5KIuaFVTOuSBJPd8J+hfR3?=
 =?us-ascii?Q?VKw5Ekv1Jz6Pym4QGNdz60guxlm2ILLDbKrjK+YN8ziFlpXWxAwXGiKe7sUD?=
 =?us-ascii?Q?IzDRcJwME3gippyWykvcR0VisB5XzcU4ttAPnzCyKfCGh8MPFE9V5HCWqcov?=
 =?us-ascii?Q?zg+WIDVaOSUc6K0ED/HBm8DXgrF9UWm4DDxOIxgBso5LG+e3rWnID559x221?=
 =?us-ascii?Q?dPncc49R8yMEM6oHQpI6nVtHGxDfosmMW0Y0jLUzrBsS6QeacJ8LIIpeFNLk?=
 =?us-ascii?Q?DecDMOl9nME8UvTzatKBwjRhc7yyvS0uGGlrkQPqV4gUFrO86xPTTeb4Fo4w?=
 =?us-ascii?Q?fmiPtl7QYqFthpRaQDwKcSYUg20I2eljA/uT0HrpPwMraPMTWSOgF13vBwMr?=
 =?us-ascii?Q?iKTKf75qLoBx3Cx7EgI8VD8DKVpghZAm52Iya6EEanZS/JCPeJL20mM+YENI?=
 =?us-ascii?Q?MFjDfzGxpr9tCj2a13rHG7aR6FMVxh9TPlTnGjUrgpz/fNqfwl3OzZ8BgIRM?=
 =?us-ascii?Q?qu+47gAEpIxaTXjWkJCsDKePBItaUKi1P9G959t9azWS2g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gvd8Ws27Q2MV/PbQ1Xw+6T0nl+ppjo3BSh0/xvAN4ZVORu9mVFdCAo9ItfsJ?=
 =?us-ascii?Q?v+wgbHYSs4Vz/GJFsuhitKp2gcTYrQMpIIEjoEV8IO5BwKx795OjAYQYEesm?=
 =?us-ascii?Q?dbvt9/aNWniXQvSSDZBdQY8/f9gtZ2CZM2vvQBzRJyHuSfrUkB2rjmSUDo0q?=
 =?us-ascii?Q?28ccQS/n3ONwOHfcNOvOOOXhr38hsNPd7TI77K/sMzLisbDCv0/1Cg824GNE?=
 =?us-ascii?Q?E5nDqTee+t6yUboS5BYWJ57mdIYMXjKPTTEZPsc3HY6mvhaoYURnnV/GM2Vh?=
 =?us-ascii?Q?rXbiUNK+lBNc0YlocQO5Wk5NYFHoHuzLaehX2Q3OhJm7hU/+P7aqALBwMFzv?=
 =?us-ascii?Q?OAeZ04aI9ii8QRqTJPprkBlyfYKRHrMMSniR8vgRcGa5FSX+C4G9M00Pfe+w?=
 =?us-ascii?Q?dXd1FTr9FUPveR6wqgNdLMzv6uzpvxN6dDsLs0Iz73zxGgl08DL+ZeYyJ5GU?=
 =?us-ascii?Q?98UEdv2fEyltLsMnLPUxg6HCYjBX/aPRcBET4Zn5V2yV3kuaPvtUd1C0jjCg?=
 =?us-ascii?Q?vUg5rV4mkpUpWXo4NphSaYUfgLlNB5vb8xHX9Wosh5C0M4gYHJV4EjxObi8c?=
 =?us-ascii?Q?IyN4ifn8SKZmccuDa4FSgkagepNodLtBVKehO+iYCjo2kXpzdVioZ4RFdj1w?=
 =?us-ascii?Q?PgmjTD4IRF0SGGR0HZ9115mO2isioNRdZaAZzEXEmAwBxae4BKZlYiCNbk+b?=
 =?us-ascii?Q?/Xacjk7iDeDi5Pfzm47qiCSmjJJWFH8xCeRGHDYeGlwbed3Q7YwhzBd0dmfd?=
 =?us-ascii?Q?GKqt5BHBw02YZQKIJYRnkcEt8+Bm5u51imKWHY3mpghvgH49uIxlsp08R40S?=
 =?us-ascii?Q?4aaapgO7mT0YVz9DfmPjTv9WM+LvwhL9uOhw5SL2VNnAVc2ZJQDinB+rWptL?=
 =?us-ascii?Q?tJOlJ6kmSGpyVCEYr0R8W+7ZCADmF8br6B+VTuV2NHRwUBW4ebh8fubvwnUA?=
 =?us-ascii?Q?nAeJ056Yoex4/FQ0yKhkAjmi0dhMlW4bMLgyTY3jb3VcrmFm3pVR9DAEsd99?=
 =?us-ascii?Q?Lxp0xPXdDFJeZ3pcUMpg/WJgixA5F6gqR7bSuX5nM4y4Ev+AVX49ZR2xCHXK?=
 =?us-ascii?Q?eAnj4w71KGUYzR7mcqIk0pr/UMAIK5nQJM3uIHCQYaf3L/PARCgbwrUPErT/?=
 =?us-ascii?Q?bd6p9z1jo3AUyEOyXVYaIcfEsi5zKEQR7D17NjvL/IdIqasTE8Meomp3Ur0Z?=
 =?us-ascii?Q?gmyjW9z2FgQUyj0/da7BvcXIywxDrgBIDBvHGh5pwNjnUJDiwgSbabvJljth?=
 =?us-ascii?Q?ElNDgbJiRukvQSjW8jgE5TFwfyCbL2lC2fXNgG5oHkJWOZPKHptxlxv203bm?=
 =?us-ascii?Q?mikRt8gTzGxV5otQLytBLGmInDW+prcLF8HjYAg7ur1wuYm2evge6rpL/KQi?=
 =?us-ascii?Q?YUGGO1z5Nm/CHTv17RlOJ8uaV27DRxEdeCAU40Pnkivszn9pJOBxpjuPTGOY?=
 =?us-ascii?Q?r8HUYj64KwV6MKm6eOUwpQEnuU7zyQ9RbMWmD9ld57Fk1JAVexU6t1vPKibi?=
 =?us-ascii?Q?3I1smaD8TMfry2w/9VjXUy9msYgCAfVIRxKjh5A1Og7h3MwaXK1M27hGCiAf?=
 =?us-ascii?Q?x+AFspbUfNfDC8jWW1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09190179-8e7f-485c-fb88-08dc744c1912
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 19:28:56.6726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ax2la8wyTC6TkLW67WhmxdlWcnyCvuRkcVVyp4nSZ0PatbstyOPBa1D/IadeiVihVk2CjJc17dttUeVYy0gHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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

Acked, thanks Alex.

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, May 14, 2024 3:23 PM
To: amd-gfx@lists.freedesktop.org; Nirujogi, Pratap <Pratap.Nirujogi@amd.co=
m>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH] drm/amdgpu: Add documentation for AMD_IP_BLOCK_TYPE_IS=
P

[Public]

+ Pratap

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, May 14, 2024 11:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Stephen Rothwell
> <sfr@canb.auug.org.au>
> Subject: [PATCH] drm/amdgpu: Add documentation for
> AMD_IP_BLOCK_TYPE_ISP
>
> Add missing documentation for the IP block.
>
> Fixes: a83048bfa402 ("drm/amd/amdgpu: Add ISP support to
> amdgpu_discovery")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 8bc2134cdd6b8..f5b725f10a7ce 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -86,6 +86,7 @@ enum amd_apu_flags {
>  * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
>  * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
>  * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
> +* @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
>  * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types  */  enum
> amd_ip_block_type {
> --
> 2.45.0



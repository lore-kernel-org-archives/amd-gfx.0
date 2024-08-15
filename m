Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9102AC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 20:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C15E10E54A;
	Thu, 15 Aug 2024 20:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7UmD2ct";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D478210E54A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 20:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+Q/MOZ9OvYVCH25B41+X56Nf9msqbBP/wmF/Wk0e2g+Mg5Tli57uYIT1W2IOtCBjOEeyzJqyZtID1Q8mCQIKgQrrtPQTY018PW+0qtR5Rn7D+AWXHnlE6S4up4S5WlomYydh2rYD1UtJq3TU8Q2JrxQqUjs+BJIxgBFKW6WfTEkoVfijdpkO82ea5h9wCyxsniwo7f8i+ctnankmuWdVrjg3qUbGz7y30Xl6uUDsqzA3iibjIwHIOk5CAclJTyDvOVNIuwA+DqGlAb3iapDr9gZM+fLvlFjceVOOhX5LM91lTLVX5/7v5Y8JuEjMTrPb/7jF5FkmmFBP0Dtz4G5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsEN8yHV2YTgEMJVZtHgjMjX9+arrOLV37R+o/41sNU=;
 b=k9FeacifJJ5kDbK73yCBT4LGJUXWkNzgG4rnNzeVFDYRngWNoaFqm8R00GflGL8O3JKCfQT/FM9P820S4fzxcmvntRXlr01J88HQ2OZxOFEfT02z8QkT2/5IkuURo8NXdtxSOrI2yphiv1b/es24UlOxRHvIX3kOxZHLQvHbTaQkEiYtYcPdTAkE90JJ9PIKi1uqzXAIJ4vV7300T1RVhiyerIoqovQKbxTOqmBdLu8zlo6wlMuPJnXtKL3JsiKRYoqWPGLsyn45MuKVdUepzcduywCnxyacMfQnJsOzgMDNLAG597RBBq5AXC4rQiUXOFSIQusfkA5H+UAUfOrqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsEN8yHV2YTgEMJVZtHgjMjX9+arrOLV37R+o/41sNU=;
 b=C7UmD2ctizWlXpJqkh0WWT+m+dUPLmYLa3PUooCN2kc5Rc2TqjraOjRZzpBhqlvkoe3d8wQnDapypOKL0xWKoP/30fkpS2VzG3+w6OkKRSSaazk+kbabKJ0+IqZ5owM1GT7D3SO1v1R5w+mrN+5orxI52Zc4JS/AwjhqQEvxxbA=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 20:44:11 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 20:44:11 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs
 for GFX11
Thread-Topic: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs
 for GFX11
Thread-Index: AQHa7qG7avyTQCZnMEaBybX5zQWwx7IoxyqAgAACe3A=
Date: Thu, 15 Aug 2024 20:44:10 +0000
Message-ID: <BL3PR12MB6425BB3B0B101C395804C428EE802@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
 <CY8PR12MB70995C3CAC6AFDEEAD83DD128C802@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB70995C3CAC6AFDEEAD83DD128C802@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f9e57a81-6eda-4070-ae7b-fb9838723530;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-15T20:31:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|LV2PR12MB5990:EE_
x-ms-office365-filtering-correlation-id: 3d66953b-3668-4e02-831c-08dcbd6b0433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TP1J0nHpIvK8ya2b0hhqTnYvdq/vS4CemdFJdfWoV7iYhwJ4QwwpLuVNpDgp?=
 =?us-ascii?Q?UBUY2sIGLCUTfZyl6ssmy02JID7UnbKS6Ciw4JfaqiT2hsX8knaknx90qJ8t?=
 =?us-ascii?Q?DzpacuK0jINEbDQUUNOaStlR2sEkCkZ1ozFrEcvbk8HGAp4/7Uxfc3GyLP/b?=
 =?us-ascii?Q?JRirX1Hedg0hvZBi5tURKGZs9Npc/AfQl28XYAjh7dEw62Gnq0tAts6L4DVO?=
 =?us-ascii?Q?ux0cX6M0Vib1u8bRBf1aVDx6aUv+W/YB/Is+gzLXrn5OjxYaRUIK2btgEKJf?=
 =?us-ascii?Q?qsee739ePymbqVwZC3SYJC8UI8yUVPZ9G2cacwrKqyhkluxZnTTNjZ7sIsJG?=
 =?us-ascii?Q?1JBxp3qqzdFqjFyllh7SkQqBJxAE6ntykbd8stUit8MHV+MPDtHDGSKUcyLA?=
 =?us-ascii?Q?y0bYPQKwxj8wKeKsTSKjMHH+x9KdYE0l0Wi05eOqRuCHQeLoEuayNBHDvRmD?=
 =?us-ascii?Q?T0LjgUNr/DuHkvMhUfZ6enWf6B4HhrUpSkScIPad4NCAqxaGFjgEuJjQUTiE?=
 =?us-ascii?Q?Px5iJW3eywM0fKDEMfpbBEFWWonbRp+Yf1kIe/1EyqPiTlF3kT6GHDaBKNS/?=
 =?us-ascii?Q?HzuxkdDpQm0cg4Is69QzQn3LBVeCtJgY9VNLuINyfGWLvpG2A6bwV96PJRAY?=
 =?us-ascii?Q?dyHo2t5LZChOd9LVW3xsqmgLqTRwErzc6fZOUTmR3XPbdLx0kFxq20JgXL3h?=
 =?us-ascii?Q?2yQzbbismvgIIibenbbJdS97NrZLUjog/zaAgg8pb1OkE3GyZdMLkv//VWed?=
 =?us-ascii?Q?gO0Q2vg3Jb+rfK9iLArkQAuVO6NRHRIl99JjiddayERYpbKQzPl5As+ccCDz?=
 =?us-ascii?Q?RZVeBgO1J+dz3epMVaoPNnfiZuuMkmZzvSMe+hy9CqKJyrRbyeqzzBXi/JSH?=
 =?us-ascii?Q?2MRYYUvD0LWrtmkSm2xcu3asCjtxKwQ7OekrVZxS6Ea0uJvcLJBPegmWLKq5?=
 =?us-ascii?Q?lh8lCfaAD25gkcvjY62fRKcyikxY+3CF/lsKoSmeA7x3DzCE9SaKknkAA5Dj?=
 =?us-ascii?Q?TZ9VbCUPUQIEdSwblVfCOoO2Cnt0RTRW9aLKA+l8OoydzisgHROrGHLtnDdx?=
 =?us-ascii?Q?kLQN0p5TUl5TzIGc4T7svduRw6lVIXFu1B8IUuLCsU2M5svFPJ1xqfxB5pby?=
 =?us-ascii?Q?QmawDK/5b6IIfSj662f/K/9tM4cClzRRBjdKhLuANK7TW/XEmHubjQ7koYoJ?=
 =?us-ascii?Q?c4gi+UP8WwKsLbUmMH/Kg601PNKtbZ5FCYh2DdWvfljfUxpjFgovOlpCiw7O?=
 =?us-ascii?Q?u2dd9cSPANgXHWj4qnRpXRMxU6/pMiSpOp4ld2JJ0FjaRPXC2ZcVml5xv47W?=
 =?us-ascii?Q?Y6B31j5JtAMEOwIPXeP3mw+6cZFFUjrYp32oZiKpNuUL7Cp+8bTxzT3TJbTM?=
 =?us-ascii?Q?H0m8Aun7VCvYXa9kg7qABXkO2/K6xqB6TuEUUE+QLKrtxIW4wg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lnlJfS6GnfORfBLxCc1wyQAQzVECMEo0LWfMN+oK4qMeMqCS5weRYe5+btKv?=
 =?us-ascii?Q?LlURz5toEBs2LT/P7sXqq7U95IjejQs5t2b+YRtOHMb1S5Q8C5K93kEH2PaL?=
 =?us-ascii?Q?hMMxTNa3XfIeJCi8IeI+7xWx1fx7CLqELgfrE/SgAEtR2gEHZbKHUR7jtXPO?=
 =?us-ascii?Q?W0+tkTwxYJrshVkTHAwk3Xy8SVM4A4hpNSZTDLHFnU7xkB0hDYW53A9YHRXm?=
 =?us-ascii?Q?GOuJE1FV9lNikVhQ7Vf09iCwE496bMKyEAyZALpKZ+VSfNaUPL3SyC8wnSCt?=
 =?us-ascii?Q?cAYi2Nb2nPJaEWe1rTcAH49QegYVDNWN6U7oPU+QQpz1CBdItiwMGsVrfVq/?=
 =?us-ascii?Q?xiyhEjh/jL56/jTdKkXwWJMfJlTMLDFJSyr5TsUt0iGjDpo2k9gWYfvm9wTk?=
 =?us-ascii?Q?Nyi0XdzXzdO3/I/e0RWR/aDQSkjd4vUl+d2CVqfXf136/o2F0OYV5bnNe/rY?=
 =?us-ascii?Q?peo05zj9+1WubmB3qL10De6IP4BttT1iZnNsSTnpPee1Q8km+FebThxrEp9p?=
 =?us-ascii?Q?lE5E/WH8U+q7T/XRzhfg0bDr86jHy8MuO4ZYTfwv95QYUBCPgplWePjI3a/u?=
 =?us-ascii?Q?wPbg2nqX6NA8hqo7WsPCT0V/ajOIkIhgH4vqam9AdlBqold8eWMWHWbMu6ZR?=
 =?us-ascii?Q?zqYZoRSy/RDwPhZRJpvna/EFvbCMnYZE6MNktziFYAx/Rb6lcCO+NdBIJSsT?=
 =?us-ascii?Q?99uwKKsTupzGgnucsw6CCYvohbXuEQVucqNGuOnq7eLvW6WGdhi79cztYmRI?=
 =?us-ascii?Q?P2C200az6yuT8lMjkI89igzI0yAxAqOGn62rJp0imFWbY+FgtJiHdTOvog+p?=
 =?us-ascii?Q?rpuQh12iGDByYvMiRbFJS9jkWYem6pkpDr3hYZsnrwemtrljoz3+a8hjPtRL?=
 =?us-ascii?Q?2w2hemuwm9ixfgfJfjm7sf6llSO+AKGG8Yj1P2SMZs3Pj5OzTMAu5yldqoBA?=
 =?us-ascii?Q?sPCGaj/xXT8IhV6+8f/qmpCq2QTKPqma/X813UzwXU3vWeRxov51UzuXEmnW?=
 =?us-ascii?Q?tQtRIqCo7CnhHklRgDz6vJxRVMwpljhlDalkrJLLwnItuLY+3QV1f7M2jz6l?=
 =?us-ascii?Q?5/RI4uvU1+TbEL/LgOxjEmwNPPLR3DHoyoIcmK0zWMYHdWnJIrAJ612zjJ2D?=
 =?us-ascii?Q?1AkS1oT+5vgbVJAVeQitGF6WFegPAcCRUnLwZjZmHUiV9v6b4/ihejhNWFfl?=
 =?us-ascii?Q?FCLDmqLXnxBsQGTUuj8FPNGqGYXzv8w0da7ni2Bd08X87Qj0BeEQFv6LvqOL?=
 =?us-ascii?Q?s1usXSgJEa0yFoVRu0OP07d8jFM+L21hbr7oCK5oPUDv9QJOyBJUXL8tu2Dn?=
 =?us-ascii?Q?6jwRwR7oZZmAi/GR4YNvfBXo2FPt9fxxcPIiDsgPop/2+ACREDDs853G5FHq?=
 =?us-ascii?Q?essxjNzW23iw1KqFQbHatieLzRGOnFWsfcuDa0uy8/t/Yjgh27tYDduO/xDa?=
 =?us-ascii?Q?RtsfRh05hQvNb2UfJ4iZaVgB7zmjxOxHDz/HHk+bxbcv/D18dEIVUw/g73zp?=
 =?us-ascii?Q?wAp93yUzt/zFm+5UsKpOFj4ZnWU3LhFARMDP1oejzdfL5KYxQ7ijb1z/Jd86?=
 =?us-ascii?Q?b5rtGMMpjJYXHNQ4YZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d66953b-3668-4e02-831c-08dcbd6b0433
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 20:44:10.9084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hASndvbonIXPq/fBM91sICnZpYFFaRT4HnFYatanQ2lDpip7K68CscBbquHjA5IDu5g3L7UqvGubakzoP/r7Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Thursday, August 15, 2024 4:32 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: RE: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and
> Resume APIs for GFX11
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul
> Joshi
> Sent: Wednesday, August 14, 2024 7:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume
> APIs for GFX11
>
> Add implementation for MES Suspend and Resume APIs to unmap/map all
> queues for GFX11. Support for GFX12 will be added when the corresponding
> firmware support is in place.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Add MES FW version check.
> - Update amdgpu_mes_suspend/amdgpu_mes_resume handling.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 71 +++++++++++++--------
> ----  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +
> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 32 ++++++++++-
>  3 files changed, 69 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index c598c3edff7e..e551943da77a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -501,60 +501,50 @@ int amdgpu_mes_remove_gang(struct
> amdgpu_device *adev, int gang_id)
>
>  int amdgpu_mes_suspend(struct amdgpu_device *adev)  {
> -       struct idr *idp;
> -       struct amdgpu_mes_process *process;
> -       struct amdgpu_mes_gang *gang;
>         struct mes_suspend_gang_input input;
> -       int r, pasid;
> +       int r;
> +
> +       if (!amdgpu_mes_suspend_resume_all_supported(adev))
> +               return 0;
> +
> +       memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       input.suspend_all_gangs =3D 1;
>
>         /*
>          * Avoid taking any other locks under MES lock to avoid circular
>          * lock dependencies.
>          */
>         amdgpu_mes_lock(&adev->mes);
> -
> -       idp =3D &adev->mes.pasid_idr;
> -
> -       idr_for_each_entry(idp, process, pasid) {
> -               list_for_each_entry(gang, &process->gang_list, list) {
> -                       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &=
input);
> -                       if (r)
> -                               DRM_ERROR("failed to suspend pasid %d gan=
gid %d",
> -                                        pasid, gang->gang_id);
> -               }
> -       }
> -
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &input);
>         amdgpu_mes_unlock(&adev->mes);
> -       return 0;
> +       if (r)
> +               DRM_ERROR("failed to suspend all gangs");
> +
> +       return r;
>  }
>
>  int amdgpu_mes_resume(struct amdgpu_device *adev)  {
> -       struct idr *idp;
> -       struct amdgpu_mes_process *process;
> -       struct amdgpu_mes_gang *gang;
>         struct mes_resume_gang_input input;
> -       int r, pasid;
> +       int r;
> +
> +       if (!amdgpu_mes_suspend_resume_all_supported(adev))
> +               return 0;
> +
> +       memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
> +       input.resume_all_gangs =3D 1;
>
>         /*
>          * Avoid taking any other locks under MES lock to avoid circular
>          * lock dependencies.
>          */
>         amdgpu_mes_lock(&adev->mes);
> -
> -       idp =3D &adev->mes.pasid_idr;
> -
> -       idr_for_each_entry(idp, process, pasid) {
> -               list_for_each_entry(gang, &process->gang_list, list) {
> -                       r =3D adev->mes.funcs->resume_gang(&adev->mes, &i=
nput);
> -                       if (r)
> -                               DRM_ERROR("failed to resume pasid %d gang=
id %d",
> -                                        pasid, gang->gang_id);
> -               }
> -       }
> -
> +       r =3D adev->mes.funcs->resume_gang(&adev->mes, &input);
>         amdgpu_mes_unlock(&adev->mes);
> -       return 0;
> +       if (r)
> +               DRM_ERROR("failed to resume all gangs");
> +
> +       return r;
>  }
>
>  static int amdgpu_mes_queue_alloc_mqd(struct amdgpu_device *adev, @@ -
> 1608,6 +1598,19 @@ int amdgpu_mes_init_microcode(struct
> amdgpu_device *adev, int pipe)
>         return r;
>  }
>
> +bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device
> +*adev) {
> +       uint32_t mes_rev =3D adev->mes.sched_version &
> AMDGPU_MES_VERSION_MASK;
> +       bool is_supported =3D false;
> +
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0)=
 &&
> +           amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
> +           mes_rev >=3D 0x63)
> +               is_supported =3D true;
> +
> +       return is_supported;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void
> *unused) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 548e724e3a75..b2db62e50454 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -494,4 +494,6 @@ static inline void amdgpu_mes_unlock(struct
> amdgpu_mes *mes)
>         memalloc_noreclaim_restore(mes->saved_flags);
>         mutex_unlock(&mes->mutex_hidden);  }
> +
> +bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device
> +*adev);
>  #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index c0340ee3dec0..a5c582674db9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -421,13 +421,41 @@ static int mes_v11_0_unmap_legacy_queue(struct
> amdgpu_mes *mes,  static int mes_v11_0_suspend_gang(struct amdgpu_mes
> *mes,
>                                   struct mes_suspend_gang_input *input)  =
{
> -       return 0;
> +       union MESAPI__SUSPEND mes_suspend_gang_pkt;
> +
> +       memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
> +
> +       mes_suspend_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_suspend_gang_pkt.header.opcode =3D MES_SCH_API_SUSPEND;
> +       mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_suspend_gang_pkt.suspend_all_gangs =3D
> + input->suspend_all_gangs;
>
> Only suspend_all_gangs and resume_all_gangs are set by the caller. None o=
f
> the variables below are set by caller. Is that ok?

Yes that is fine. The callers of these suspend/resume functions will set th=
e appropriate
values based on the need.
For our case, we need to suspend and resume all queues. Hence, the callers =
set suspend_all_gangs
and resume_all_gangs=3D1.

Thanks,
Mukul

>
> +       mes_suspend_gang_pkt.gang_context_addr =3D input-
> >gang_context_addr;
> +       mes_suspend_gang_pkt.suspend_fence_addr =3D input-
> >suspend_fence_addr;
> +       mes_suspend_gang_pkt.suspend_fence_value =3D
> + input->suspend_fence_value;
> +
> +       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pk=
t),
> +                       offsetof(union MESAPI__SUSPEND, api_status));
>  }
>
>  static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
>                                  struct mes_resume_gang_input *input)  {
> -       return 0;
> +       union MESAPI__RESUME mes_resume_gang_pkt;
> +
> +       memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
> +
> +       mes_resume_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_resume_gang_pkt.header.opcode =3D MES_SCH_API_RESUME;
> +       mes_resume_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_resume_gang_pkt.resume_all_gangs =3D input->resume_all_gangs;
> +       mes_resume_gang_pkt.gang_context_addr =3D
> + input->gang_context_addr;
> +
> +       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt)=
,
> +                       offsetof(union MESAPI__RESUME, api_status));
>  }
>
>  static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
> --
> 2.35.1
>


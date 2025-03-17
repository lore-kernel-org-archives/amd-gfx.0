Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD58C35FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 02:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B8E89B66;
	Mon, 17 Mar 2025 02:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xELR+7RC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A713F89B66
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 02:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7URPwKBzH1qyH97vhGNemkKAmnOto1tk9Y+gyfueN0d0Xh7Sfgp7Lg+xnD+1jIa40QD+jmj9IpfG5d0BbKhaCGB+PzzYB5ywymgsjFCzVacLfM11CJEEJp5vG1okgTRAm6SsMGieGbgDYBqbk6Co16DPtclVOSSIilKr7InaImBE9w/jXNbyLVu0xIXvgTcY+5HSDSEArmKjErntWY4I5XaT26mYouTFxsq80LK6IqJGGLDMM8jVbAbqmhWUnw9vOF2G9RCvNrNzGqGlp2qRML47JogNm7N2Iv+9tkXd+HAGoxMU3SToZO39tb6Tk35FPNRT0Lr60tfbPwQ/eKWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR0lhZgIYlbknkY2Z3KqmqwMjmIVI5E51Le2A55UVIY=;
 b=pCbG+zptf4aBDiTPBwrK+zBYXJ8hVtdMzRlZUV9iCo68/zbermHZpZCilwOk3AZyUDmq3abhFa2a9RkTZxJTzBK4p2pxzuRh1FqvQIgOI2+uTRoEcvBcM/uop6gWU82ew0DX+8qbTEYqfnZ7lWGE7eN5fs66aO1giJKFuVzSNCzlv4+FC4S/Qqb2NCfvsXb/tfJ7frTdRI1XpRPRonMEftMQGFjqzXWALHxw80We/GM1ZpsXwUbSKAUn9WConSCY15syWT3XxuuMJ2b5LLmxLXpNbKGLvKn6SowYanp7mO+/K1J3ksdVRIJLK3Tme1C+BM6XCIGqlV2lkNuI9A4uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR0lhZgIYlbknkY2Z3KqmqwMjmIVI5E51Le2A55UVIY=;
 b=xELR+7RCtL2uJDpRkfCfN3YabRhK0Lh0p61RubMPaW+dFB9By99MU677Ihc5sqa4Z9L79uhYQcvhFUS+uWswObmf0dzkKAV+IPm4Y0axXg3157uLNVhSLZNk43Pq3xKLmLdV/7RcOz/7k+VXfK20ix3Wt/JzFECLmGu6IDEECm0=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 02:12:48 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:12:48 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "jiadong@amd.com" <jiadong@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix SDMA engine reset logic
Thread-Topic: [PATCH] drm/amdgpu: Fix SDMA engine reset logic
Thread-Index: AQHblty5PWxVlbrYGUyepExN62W2x7N2lkbA
Date: Mon, 17 Mar 2025 02:12:48 +0000
Message-ID: <CH3PR12MB807471AC9D37CA52EBD997A3F6DF2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20250317013407.3804268-1-jesse.zhang@amd.com>
In-Reply-To: <20250317013407.3804268-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5edbc789-725f-4bf5-8915-1e6c6cfacb9c;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-17T02:12:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CH3PR12MB9220:EE_
x-ms-office365-filtering-correlation-id: 423a9a45-561a-4c93-ba53-08dd64f936bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XJPUH4ELZ4YO17dVmvE3+6CrbXndYdmYp6Z7kRM0W18+XmcUcYQmdCcjMu?=
 =?iso-8859-1?Q?kFBvKpR7A/JyBEvFHcOlKum51uvIDRR1N/GR8sFX5QQbaBF78G80W7WS0Q?=
 =?iso-8859-1?Q?8AaHz2HtxL5XK4+P+Hr0N/rs3Ab815ahZnzriEhtgRkAWtovrQKL098SJr?=
 =?iso-8859-1?Q?GZDWb8965CJRlyJAZCVl/BwvkfBURmkioLp8qDkOYTgVFYD8NFaGPagIQJ?=
 =?iso-8859-1?Q?Vc/zbooyiKTFASrKzsdID7X7stu3sNJdoE0PLaj/ZdMLX22dRQ1Z6J5x9N?=
 =?iso-8859-1?Q?CWM5AX0FLzFApJG/uM8hUoqSDhH9cZ7FX0GWPH62xszXptyI8x9xY3Lb85?=
 =?iso-8859-1?Q?PtdyblZtwID2FQnirJjimn6bIh+6glldD9mS/A5/jehAtjkhK3GCiWyAxt?=
 =?iso-8859-1?Q?edsj8a8xjHSQR9RJ3X4M7gpVCPbIGEL5OcAebxn9PGpkChoiasc6tURQ8Z?=
 =?iso-8859-1?Q?KgERPUL+/kh36GEUZeKkCJi2UgRFyZHc4EzAbwgHpoUnn3pQiQ/4NWMBWg?=
 =?iso-8859-1?Q?QXDzMGIQUFtICNcqpXL3Ji9JQrDdGcvA3m28P5oXJi7l00CqL3PWVjn+ls?=
 =?iso-8859-1?Q?3YFqOXNbKQPOr4vmQokVgJ+FXGVFD2eMXWB+Q92OP/IXljxVNLKw0IIe3F?=
 =?iso-8859-1?Q?IliHXZySfwCbYPU8EtPSBUCppsikuon66aP8PY6+uEqITh1zrhS/SWlGAD?=
 =?iso-8859-1?Q?rALfNe6c60/OtWPBYJAWNVLCn3HAZGIgA4+yj4/fZ3QVJ0qor9tv20hYBf?=
 =?iso-8859-1?Q?wV7ZZd8iMqnDxmWRg/cEKFMWXZhf6xzvsZ7CDFhUdwghAc6Qr/zy9E381R?=
 =?iso-8859-1?Q?x977AnUBU2IxGRJyIdUWOJXGmPnRMaY8+TUw+CZ6VPzsOTrJnpR0tpzmvA?=
 =?iso-8859-1?Q?0D+BeCbscxa4r7dM4myl7yUveyRTYIhmGNU2+MAiYyP4+xxeQJZiAsis7N?=
 =?iso-8859-1?Q?/BEiVwb+dcSOXs3fpsefBZRoHiecWY1oVnc7+B539BVOTtim+12R36Vgmx?=
 =?iso-8859-1?Q?XIIrkBQMoMvMzybdgo2olVPvPg9ZMsPGQZg6B0iR9aiB1IXLRxsHdbKT5w?=
 =?iso-8859-1?Q?DdmLULSlmjpVLkCt3mK3WT39BxxSihAgZ761ajzrK5LrT+x6of/wJTO8iG?=
 =?iso-8859-1?Q?62wZibsbIWzr4y/cTZwdbgcPrcQkZNbXbP6BFHoD85VEM4Nqc3qpJSYn8c?=
 =?iso-8859-1?Q?yYdvRYBuS4vD/Kk+ij7xbp5fNsN4+9A9VOGiwgJzjYY+0SxGkalmlBAtbI?=
 =?iso-8859-1?Q?K/DgcjpcT/fQ8c8SRaXN1f5KKkffiLp7WzSY63VRAAC8jombRUf7R7Dnx9?=
 =?iso-8859-1?Q?HJkHxTA5jZYX0Z1Kp7uyCvaLWttFbE9KuwmZ7AsltyX4prmUThmUl0vChb?=
 =?iso-8859-1?Q?UuNb9RQ2Uy83vINCVWgsL3j+NQm1hRAfboe9oKBUW99bU3TcPMiQoTAUjy?=
 =?iso-8859-1?Q?thK49UG/0G9gIAQ+nTHr2+3ny/nd848OAG58tGZWdR5CYM6Y5FG1Fk/4hc?=
 =?iso-8859-1?Q?n7tLija4+eIipHv77xWOC6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N/X3/e0VvhqGAbRl9OFGHqA6rYZscp8vnyL3KZzCJLFrYWM0WLxfzueW0B?=
 =?iso-8859-1?Q?eQbVx6s4VdoCpG5RwTECbdfFy/ivYVYtlupu+oESlbLIVFkgkQzS1FWV/j?=
 =?iso-8859-1?Q?/s7z75A8yHe+1SvcVjWy+9PyBT5rZfuzRHbWpcxS5XWbwD/50epRNinzeQ?=
 =?iso-8859-1?Q?81t/PO4qkzkgv+/zdU4siiVTnorzI+40agsVsUWOSWZwdusl2hKx6bEhxO?=
 =?iso-8859-1?Q?IhLHqxXwXwhMraYxyHCxSukP/bFJfAj0UCsCNKMpHknrijddbwjcOVv9j/?=
 =?iso-8859-1?Q?xsXA4Wn9fUWszlcRQAqQJAiJJW40aRiIvl5OVK/lf8uLEfcCKH1WyPxgYF?=
 =?iso-8859-1?Q?IPrXNcE6hfj/mTEAUOCGIH4O8vy1xpDP5cGj3Jh/27UL9whFppV60uXAj7?=
 =?iso-8859-1?Q?S96KN7xxV9HYfwtDj8BQzWdg5YX7/FAzPUVDe2Tjnn8Io45X9O5qyV9v54?=
 =?iso-8859-1?Q?67p+TwDeCIwskaxoQRJUZYmOLQW8tFeKLH78dTi53NoR8J8qira2lf9ofO?=
 =?iso-8859-1?Q?LLH0DYiBg9+JEBdIfCq/sLNKrjlx6FHteJ9f2IaYxkhr7dF30rqzKpITvs?=
 =?iso-8859-1?Q?kTFmfg5FWRIvSOKgwOWSTTYgxpwkvzu32mkCeYqIWPOeh6YMPZi2KqFf5l?=
 =?iso-8859-1?Q?QD/qwsKgCFoaFqxGCOuLBa80kGDVy3q87OOjLlbUvXYdu8+YeDQrBBCBVD?=
 =?iso-8859-1?Q?GWn5JVQGWGqlHR6TzflYPkMKyjFpXvt5TxTTueXEzaYIKRWvic53fQJT0K?=
 =?iso-8859-1?Q?mrD4eaFTknh8AmGJp4n0z4+VJuklX9vvvMyxoItIM2IMSXjPTFNYJ4cuva?=
 =?iso-8859-1?Q?+nAgQzSYOrO+vDGeWSB9GXYZZO4e82UaCCKy5CGbCqDP0pcrumEvZKZDG2?=
 =?iso-8859-1?Q?gVUXfmF3C5B/Vsdx0RlhJJIBpLLoweL9kvu3HI5ihu0aLTIzF+Bn0V8P23?=
 =?iso-8859-1?Q?jr4GCwpSr49+jU16Vm8WkVi59s95JYhDAjppJIX5vOy5XzPSa46RfeR+43?=
 =?iso-8859-1?Q?zR5mk2FODUX5XYfB2XfGhOfHt2FIvtfzlGpd5bKtLu0bgdsc7oc4G8eIFr?=
 =?iso-8859-1?Q?QER0lbgDjI2/uSOx9WC7dowFmvnV2OZcopfFvtQs8ZQtlkCt+VPhNtwMEO?=
 =?iso-8859-1?Q?7kjpOBePi45+HUE3hYb0NWlFVrsCiCUpO/3pbFF8NYq+1//sMt2frfmMkc?=
 =?iso-8859-1?Q?g8x+diwAKbKKu6gWEMeHDCSMgFCL7IGipUxCD+X+c8x4HrXY1Nfsc61wWl?=
 =?iso-8859-1?Q?fOmt1wtzR03PDfpxNBTM3qwUxMVDGGGe0hBC1nsO4IGVxBt66aZgBfLntQ?=
 =?iso-8859-1?Q?ys/REqnqfx4n+7SUKcA5mEHssZ90vRHv5AUmPAGNBn09rBGH8mJcYe4tvA?=
 =?iso-8859-1?Q?f0zi9YJS1yHktYrHRn6P/5RXMBNFD+V26/NAdLrZ1/WgCwFIHHD93xG3yX?=
 =?iso-8859-1?Q?6sdfR91PSgVV0X/Nx1JrhMAt78Okp3igtqsAIuIjmigWx8aGvqsqL8evnB?=
 =?iso-8859-1?Q?86jErImzbhr/3UxEUyHOG93Ve1rn1ux0xDOkIL/uv8qN/BI0X3m/jhnchU?=
 =?iso-8859-1?Q?x/pfcyDPRn/ORCSsjfzjyeP7e+1Tvv5akdRxksC4gI2XZhmk4NBAkF/ex3?=
 =?iso-8859-1?Q?sm2YNYrW3FjE8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423a9a45-561a-4c93-ba53-08dd64f936bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 02:12:48.4117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K912qjrX1NDJRQwR7MvqQnCfqqtNwEfAWy+v/it+Ba957UFdLbSt8WADkJq1wnEt7rqJEUvGTTjQqKTWBGzNsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>



> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Monday, March 17, 2025 9:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; jiadong@amd.com; Huang, Tim
> <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix SDMA engine reset logic
>
> The scheduler should restart only if the reset operation succeeds  This
> ensures that new tasks are only submitted to the queues after a successfu=
l
> reset.
>
> Fixes: 9b5d66721b66308a5 ("drm/amdgpu: Introduce conditional user queue
> suspension for SDMA resets")
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 3a4cef896018..1334c209201f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -609,7 +609,7 @@ int amdgpu_sdma_reset_engine(struct
> amdgpu_device *adev, uint32_t instance_id, b
>        * if they were stopped by this function. This allows new tasks
>        * to be submitted to the queues after the reset is complete.
>        */
> -     if (ret) {
> +     if (!ret) {
>               if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring))=
 {
>                       drm_sched_wqueue_start(&gfx_ring->sched);
>               }
> --
> 2.25.1


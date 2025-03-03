Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B5AC282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 22:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075BB10E2ED;
	Mon,  3 Mar 2025 22:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gZPymG2r";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D2010E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 22:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToNllf3e5LjPOIY43BqOREjFIok9GLiTcs8NfQPIRQkSPLmHdly6iz6lpzyPZfHIr6TH6xynd+1g/qGBxvOeXD+WUDdDDE8/lcIT0tjDJG4OpltWEZOoC8hzKSHCQxGrweVoFkf0yokeByO+MsS+HFWVwjpDMobBf51wWmvJIWHezK+dmRN0Q5E+Q0xLPK9C/92Aadzqo4OUUbZTAN8nnO+b9WCRWgEQYbGOhXGZv5tO7Jftu0fiXv1B6sqdvsqdexK0KEmhzeo9c97KD//+96ftkDR7Dtr4s/VnhnlGvghM3UdrRK9iLnV6d3jELg8J+vi77FvHLxHimcO3mPT/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GheCX7aUyXXYOe8PCKDqOnkzPervUs9EqrtvSXNCU2w=;
 b=N5CWXskVdKsg3R08mLrVcVWf5ylVH7OYkS1OEtWzw9Kj1B1uMEg+duyaB5CDkoGH8swzBVnP2nYld6Yu3MaxB4qoCmOeA7ekpc9QjI1HAGQll/fieZDtJQEevS0axlDmKWcwtjMoNXS0abD45ATRZLrrShET0TvmnHAeDp/YnGma3xXCyt1KRLdiM8BnGFJsvWM4NYKVIrHw2woEY9qVM81bEG6YjgruYMfxQv2s4XTfodt71xJbP1OfDrAMjviDxVP2uQZ6oikb7U3ccriYPozxPV5AI3Wp/Fe4tXGELzha/BCIDEFyG+/YABVKi/TG3k6nS7fujUyC5HROuWUJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GheCX7aUyXXYOe8PCKDqOnkzPervUs9EqrtvSXNCU2w=;
 b=gZPymG2rGIBPxbprU1S8E3AwhN1abmp4z2KlS/k9rgCxDM4Za6PAWTGR4V62E+gzAV22lmqzpuwylOEpmt/p4MmZdqPY1zLJ/jejKveQdEvt/54BiusRA+PraxWOJ0cogaXgG2IlHAm/ulo3F/9LFL5oZpvRdVlcFhnMcsyx6jQ=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 22:12:24 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 22:12:23 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9
 family
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9
 family
Thread-Index: AQHbjH0fElOD6gPKL0yObGwe1XXL07Nh48SAgAAVwUA=
Date: Mon, 3 Mar 2025 22:12:23 +0000
Message-ID: <CY8PR12MB709946A21252DEE22AEEBDC88CC92@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250303204427.113261-1-Harish.Kasiviswanathan@amd.com>
 <20250303204427.113261-2-Harish.Kasiviswanathan@amd.com>
 <CY8PR12MB743538C53BABCFDC92013C8A85C92@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB743538C53BABCFDC92013C8A85C92@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c48227f5-ed51-42c5-8d1e-c6d601315285;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-03T20:53:35Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SA0PR12MB4351:EE_
x-ms-office365-filtering-correlation-id: 8032cca6-9718-4e9a-1867-08dd5aa07975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LUZlVgkrt7kYjAbQuR9vUUAOi2Bbzw0TvnKDW5gBwLclS8pyRmcKWOmBusg1?=
 =?us-ascii?Q?qRvTUm/lBz4Rys11yBOz5okov6BIu33kD85BHsxf/KMwL7QpEnNl1/AcsAnQ?=
 =?us-ascii?Q?PnyNhJt5NCOZT1aEOIb7nLvJFmFLPiQMnNhobRX0ijdmiWbiipPI1V+/VmYV?=
 =?us-ascii?Q?jrcZGBBj9SMYEVeatdnqH85KvIthhfZ3Dz0hTT12i+VsiRonPoJwa3t8UOPA?=
 =?us-ascii?Q?m49T+21YnbQHge4a5GSrZC01oosxaBqKE+d8rV0ZVSMGrISF/88hqBza6hEW?=
 =?us-ascii?Q?EtEAKvwQx/KiPo7cFS2diF6g+JoivchOzjffzmy9I6HH4QlMuJr5tL3cxQtS?=
 =?us-ascii?Q?wg4eQ5Uc9/FyuOs8opVxQwgdhYfH0P3WA0No2it7c8b+nN0TjX7/jbO90JHK?=
 =?us-ascii?Q?0ext/g/gUDlbwhI9GB5ODkURgSbd7Tx3hz/6EpNiwEcW1N3s1d6jQKNXoz5z?=
 =?us-ascii?Q?+/kvy/i8fcI5jFvGU3HZixRmyNVRabTi7t5276grFiC5l9xNSpGNsu4jhE4b?=
 =?us-ascii?Q?gzsOG/u3jxbWFl1xXJT6BMWJjLDEhJLCHqgMUjH1oVLV8/rtgp77VBPXg+Bh?=
 =?us-ascii?Q?TOos4lQ2EepAbouU+AcrZ0Lg1Zl+g4AL5aD0X1iLWCtw+Ufmctc0RAckzA1y?=
 =?us-ascii?Q?unvAInT7Btcj53sZiqrmF/AWfF9+/p3W7QR1js5As6ilVk/xPcEnUCDYquwY?=
 =?us-ascii?Q?df4Poyt1Ejuar3B+d7/zJfT7XL7io64ms0BEq9bqvfzs5AvCTPUvWdCwhNCy?=
 =?us-ascii?Q?kz4kYDapHk1OT3COj6bQxbgOHh5OhB9fSuxU4gfrlifxFmLTNSun+7NB9iVs?=
 =?us-ascii?Q?Wu/ISPlfi2WelwnFGVRi8PBeciirP45o+xERRO0SJiWLACO4tIO7WHERJf03?=
 =?us-ascii?Q?JTKK6BZLcotJ00x+Qq89Ogcj/khX5ncFy3fAoTkhFOyd4H2cV9qZii8Fbrfb?=
 =?us-ascii?Q?RTTdGRFb9c7MqJzSauAD2lvr1cH8+Pm9KPT/QZQP0wlfSUxJu84jCSTfHO1i?=
 =?us-ascii?Q?EFW+3CimPylK3Qm7vYBvjRxkgV3FJnx70omB25FH/i3WTI3dNgOVHsgMEwOL?=
 =?us-ascii?Q?KeIRVm1pcmMHAyvzKwwWv7eg/NNA4ALYGeRE01YY9OY3CPT+3LyvZOX/5Z9e?=
 =?us-ascii?Q?rAriZuV9dvGfAwK5iw1ECSmC7GX0us0KTESViqyyhDuS7PGZulEo5b9dn03w?=
 =?us-ascii?Q?IIdUvd/8olFy0d8RudTsmTLWfCcCB+PbSmTntdaNOhEpUfgXAnr9Eq2JnVP6?=
 =?us-ascii?Q?f9FNFf/xO8e/aeoEdh5OdvlhZ/4HNLqgrneiwzM6LbkahsO+nYAYA1MjdnPG?=
 =?us-ascii?Q?AnI5lqJWeXhyGaCMtQQ9dgTpY5pNTt87MRgvn8s/rfLSGr8uHW+NkcCRkyd9?=
 =?us-ascii?Q?MGuY4C18pPVkMwavYWzfaNDS97ggxU0SbdQbRxD4wKTD/i0j5dBe2UgCUR9M?=
 =?us-ascii?Q?Gx3CfIWBekZgNYkjso4u680kM7HzmEFF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D16CPTZx1qCRXqW4hAAQB/XNlGV3FlF3NtQzzJ/qkVTRmzjIg+KGx/RJBA+O?=
 =?us-ascii?Q?cAUKmGxtSGnQ4x5LdBU0zSjhP0cLx4bcRzuGt5EesKAPtt3mcaiBHeTfBgQU?=
 =?us-ascii?Q?d4btgpHnrb5gH/DUdMpHeaw/7uTh6pG087xgNpmdcOAf7uWEb+1x/jkP9BaP?=
 =?us-ascii?Q?tcXiFv3OlapOm7fSXva9F2Xy3C0bfa0IrB4KvRiGUVjA1yLd9lPdc8lhtSZF?=
 =?us-ascii?Q?H9XL2sLTQcPrJSob8JEJtuR7cQsWZx1Krndb6/93GvfidorhXY3BExuvYd0i?=
 =?us-ascii?Q?xH6SqZwOamgxelTqKEYKEuL7gxCLSVbAvUG9RASk+aELvxKUQp8pg3/Yivtd?=
 =?us-ascii?Q?+Y5wkznbeOROP4OY/i422WKSeB7PDsnFnifikT8Tf6Z5xdEsRFbZkmRp6jIg?=
 =?us-ascii?Q?DIAt1mm5Elrg3wF5uKWppPtw9Ru1EKCA+FLkZTele8AJXHPaYUlaQKQTdagd?=
 =?us-ascii?Q?AwOmrYWdAEsKnUYxePRibv/3qSxyRYzfVZVceuuDjrmQ0zsC3tfSOve+vDiW?=
 =?us-ascii?Q?Qvm2Lqz8vfAri5lEJmA/QcePo5Vhkvele1VpN6p8Ea1A9IO3D6NsSIYQdS36?=
 =?us-ascii?Q?KmqIGHsGqrqcHD1z11OCQZleW1vsfopHSno1V18qRJEhvQevCltQQxkEDIhh?=
 =?us-ascii?Q?gSsLrb7x0FthsnxvYRSTqL/1XapJukl4+gLerKC6H4RrDviB8fkom0qNSdBy?=
 =?us-ascii?Q?wQu0ECfR1EeBJrapcKz+mbQUdWB7twsFv5ASPk5/3vfaWSLRf4kyKC4Eksa7?=
 =?us-ascii?Q?5Wvzj8F/Pfyj6EI4Lh2T0BIY837Eh2jnc5KuF6fZqLUpWfkhZf5n1a7+Whfz?=
 =?us-ascii?Q?Ye/jNmwNU+8yLSRo/GgszgHHauQPcAIYYDcgE2S5uvTzMstrFRPlgsow1l1A?=
 =?us-ascii?Q?xwY84eJGbv2Z8uUHdVUdE348E2gaRW7eA/VY7nNeaHzgCBWwUqRRRUbLocgR?=
 =?us-ascii?Q?pWZFf8DErebF0Nu/Ab1w1BHX0vkqHAR2SLrYEAUTHQ5zGcwkBm1kbc5yazPH?=
 =?us-ascii?Q?zXZ039LLPFnJG1e+QWWr9cBUBg8+3CifiIyE+Glg6h/c4dq/qXxYwHLWyreA?=
 =?us-ascii?Q?fuvVyxg9AdLDlKr1pf5DEolLmNyh/h34Pzb9HNXJMsanYxSkXU4YqGGMDJQg?=
 =?us-ascii?Q?nM+ioeXhjuwjSeTDH8XLj6DqCWJZeie8p9dM2GrPpF3DmDuG6FmEBTa7cwSN?=
 =?us-ascii?Q?UcdBec8Dn2TiNdirWnvBqusXXoExwQvS3LZeIAGelGYcgDhig3kP24B5LyDw?=
 =?us-ascii?Q?Ihwip7EHh343oFZ1vq9Brlw97XEwJV9m+7CbYLczOcmtYsgAsB74j9jrvOP/?=
 =?us-ascii?Q?RIt/zpsX4BRQyPOWVJElQwSFYmmkPVSY+Nd6CO20D59XGXNG6iTwK3DIMJPF?=
 =?us-ascii?Q?SzyYJ2lvmQuDw1bZuivyELiQQG88BQqHrcP2WScLnAyC5dTiFDoHDOlMQxiZ?=
 =?us-ascii?Q?wsxVI+IjC7gZ+T/ynC6HrwE+QkyERaaNJqhM1IkM4DaLgzFYFlGtf3tEgH29?=
 =?us-ascii?Q?L5G674cKtJBtCVotP6Kg7RZIXI7LNxWllbHFeQvvr9ZgS5olVRWqwG7bvxd5?=
 =?us-ascii?Q?Aa2546G2yMrCBc5fJF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8032cca6-9718-4e9a-1867-08dd5aa07975
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 22:12:23.5428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FyMmuccGCR92h25C0nj9vDI8ybkLYJArNF9Zsh0sNJl9EUvbXvWKTqMs5pMjXLIvHwGz+pR8Nw5cE3HAvUmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Monday, March 3, 2025 3:54 PM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists=
.freedesktop.org
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gf=
x9 family

[Public]

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Monday, March 3, 2025 3:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonath=
an
> <Jonathan.Kim@amd.com>
> Subject: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9=
 family
>
> Dequeue retry timeout controls the interval between checks for unmet
> conditions. On MI series, reduce this from 0x40 to 0x1 (~ 1 uS). The
> cost of additional bandwidth consumed by CP when polling memory
> shouldn't be substantial.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Reviewed-by: : Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  2 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 28 ++++++-------
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  5 ++-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 28 ++++++-------
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 ++-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 40 +++++++++++++------
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  5 ++-
>  10 files changed, 70 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 8dfdb18197c4..53f5f1885870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -189,7 +189,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_aldebaran_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v9_hqd_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 9abf29b58ac7..6fd41aece7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -415,7 +415,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v9_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index e2ae714a700f..95f249896275 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -530,8 +530,8 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
>                               kgd_gfx_v9_program_trap_handler_settings,
> -     .build_grace_period_packet_info =3D
> -                             kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> +                             kgd_gfx_v9_build_dequeue_wait_counts_packet=
_info,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
>       .enable_debug_trap =3D kgd_aldebaran_enable_debug_trap,
>       .disable_debug_trap =3D kgd_gfx_v9_4_3_disable_debug_trap,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 62176d607bef..0b03f2e9a858 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1021,25 +1021,25 @@ void kgd_gfx_v10_get_iq_wait_times(struct
> amdgpu_device *adev,
>       *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmCP_IQ_WAIT_TIME2));
>  }
>
> -void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
> +void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_dev=
ice
> *adev,
>                                               uint32_t wait_times,
> -                                             uint32_t grace_period,
> +                                             uint32_t sch_wave,
> +                                             uint32_t que_sleep,
>                                               uint32_t *reg_offset,
>                                               uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannont handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> +     if (sch_wave)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             sch_wave);
> +     if (que_sleep)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
>
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
> @@ -1109,7 +1109,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v10_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v10_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v10_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
>       .program_trap_handler_settings =3D program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v10_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v10_hqd_reset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 9efd2dd4fdd7..89ae07288b10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -51,9 +51,10 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct
> amdgpu_device *adev,
>  void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
>                               uint32_t *wait_times,
>                               uint32_t inst);
> -void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
> +void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_dev=
ice
> *adev,
>                                              uint32_t wait_times,
> -                                            uint32_t grace_period,
> +                                            uint32_t sch_wave,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index c718bedda0ca..2c5f22838fe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -673,7 +673,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
>       .set_vm_context_page_table_base =3D
> set_vm_context_page_table_base_v10_3,
>       .program_trap_handler_settings =3D program_trap_handler_settings_v1=
0_3,
>       .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v10_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
>       .enable_debug_trap =3D kgd_gfx_v10_enable_debug_trap,
>       .disable_debug_trap =3D kgd_gfx_v10_disable_debug_trap,
>       .validate_trap_override_request =3D
> kgd_gfx_v10_validate_trap_override_request,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 441568163e20..d2bbe9973c93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1077,25 +1077,25 @@ void kgd_gfx_v9_get_cu_occupancy(struct
> amdgpu_device *adev,
>                               adev->gfx.cu_info.max_waves_per_simd;
>  }
>
> -void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
> +void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_devi=
ce
> *adev,
>               uint32_t wait_times,
> -             uint32_t grace_period,
> +             uint32_t sch_wave,
> +             uint32_t que_sleep,
>               uint32_t *reg_offset,
>               uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannot handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> +     if (sch_wave)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             sch_wave);
> +     if (que_sleep)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
>
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
> @@ -1254,7 +1254,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v9_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index b6a91a552aa4..54ee8992be5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -97,9 +97,10 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct
> amdgpu_device *adev,
>  void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
>                               uint32_t *wait_times,
>                               uint32_t inst);
> -void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
> +void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_devi=
ce
> *adev,
>                                              uint32_t wait_times,
> -                                            uint32_t grace_period,
> +                                            uint32_t sch_wave,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index b9c611b249e6..6861e8f7a2f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -298,13 +298,14 @@ static int pm_map_queues_v9(struct packet_manager
> *pm, uint32_t *buffer,
>  }
>
>  static inline void pm_build_dequeue_wait_counts_packet_info(struct
> packet_manager *pm,
> -                     uint32_t sch_value, uint32_t *reg_offset,
> +                     uint32_t sch_value, uint32_t que_sleep, uint32_t *r=
eg_offset,
>                       uint32_t *reg_data)
>  {
> -     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> +     pm->dqm->dev->kfd2kgd->build_dequeue_wait_counts_packet_info(
>               pm->dqm->dev->adev,
>               pm->dqm->wait_times,
>               sch_value,
> +             que_sleep,
>               reg_offset,
>               reg_data);
>  }
> @@ -320,26 +321,41 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       switch (cmd) {
>       case KFD_DEQUEUE_WAIT_INIT:
> -             /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
> -             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> -                (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)=
))
> -                     pm_build_dequeue_wait_counts_packet_info(pm, 1,
> &reg_offset, &reg_data);
> -             else
> +             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> +             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +              * On a 1GHz machine this is roughly 1 microsecond, which i=
s
> +              * about how long it takes to load data out of memory durin=
g
> +              * queue connect
> +              * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              */
> +             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &=
&
> +                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
> +                     que_sleep =3D 1;
> +
> +                     /* Set CWSR grace period to 1x1000 cycle for GFX9.4=
.3 APU
> */
> +                     if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                     (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, =
4,
> 3)))
> +                             sch_wave =3D 1;
> +             } else /* non gfx9 */
>                       return 0;

Please close the else statement braces to balance the if statement braces.
Also the /* non gfx9 */ comment isn't correct and should be removed because=
 you can still have GFX9 devices that are pre v9.4.1 that do not need optim=
ized wait times on dequeue.

[HK]: Yes correct. Thanks.

Thanks,

Jon

> +
> +             pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> que_sleep,
> +                     &reg_offset, &reg_data);
> +
>               break;
>       case KFD_DEQUEUE_WAIT_RESET:
> -             /* function called only to get reg_offset */
> -             pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset=
,
> &reg_data);
> -             reg_data =3D pm->dqm->wait_times;
> +             /* reg_data would be set to dqm->wait_times */
> +             pm_build_dequeue_wait_counts_packet_info(pm, 0, 0, &reg_off=
set,
> &reg_data);
>               break;
>
>       case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
>               /* The CP cannot handle value 0 and it will result in
> -              * an infinite grace period being set so set to 1 to preven=
t this.
> +              * an infinite grace period being set so set to 1 to preven=
t this. Also
> +              * avoid debugger API breakage as it sets 0 and expects a l=
ow value.
>                */
>               if (!value)
>                       value =3D 1;
> -             pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_of=
fset,
> &reg_data);
> +             pm_build_dequeue_wait_counts_packet_info(pm, value, 0,
> &reg_offset, &reg_data);
>               break;
>       default:
>               pr_err("Invalid dequeue wait cmd\n");
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index e3e635a31b8a..4f79e707bc80 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -313,9 +313,10 @@ struct kfd2kgd_calls {
>       void (*get_iq_wait_times)(struct amdgpu_device *adev,
>                       uint32_t *wait_times,
>                       uint32_t inst);
> -     void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
> +     void (*build_dequeue_wait_counts_packet_info)(struct amdgpu_device
> *adev,
>                       uint32_t wait_times,
> -                     uint32_t grace_period,
> +                     uint32_t sch_wave,
> +                     uint32_t que_sleep,
>                       uint32_t *reg_offset,
>                       uint32_t *reg_data);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev,
> --
> 2.34.1



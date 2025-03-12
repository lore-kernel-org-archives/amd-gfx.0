Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A6C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB2510E02D;
	Wed, 12 Mar 2025 08:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UOlEygxa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E5010E02D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWBdQ3mY2JE8jHuX9YrH2boBMUgLuxONZRG3eQ/Y0vFXzGFpRJWNWYWuCDwqlrA/gpfChdP08lZEDm6EXWVrJK1FNSZjzTgkmw2L28YHR78fteQ30ifD8Zab8bsnQsfRt7M24pYmlC+ioMtwc9vBwei9nCWu4G7Z6JaeZD5E5mgDfFrQe1HmdvR1kQDd6FIlXYkl/IaXG+0SJNrv5NOkag05TJ0S6/AwxzRggl1z6eXEWbvM0NZ63t4op5IF8mtW0QUHRLBYfZof1m5f9XKoFGmm2WJ9lV7SX7hPuLZg67qLjP1Xr5Bn0x1z15GeejHaDF115fnyU7tzPUV1J5vQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/VDC+vmm+qfsm3KTA+PdE5BBvwweb5cSiqKc8fWWHg=;
 b=i9r3CYdV0yBa7LRSyg+Lr4Nl8eLth6t2LoZiOT4uasn7nMvlSSWxBe5PvIvu5L+HrCOpxdecmet5IXp9UO/3g8KyyBUty40TjsztORF/d5RC0zjc87/9EcOiEG8cFnqxQY0oWgc11kilhXRfPGzrqSYJ3rx5UsUUjH5cyMHLkO5F3Xw10xSNkcOW5hL4E+AQrDlTUvGO0BtLn5CCDdrnVbbsLi4YBdzNlFIl6rZxYwze2hDZ/qKxkO8mPuxjKEu1zCF4y2AH61ekmUOTW4EwYfQI7RdMSNARrTDJ01oZD0camWTTYhhrKZ8tWsir6RMbw6KuwY7Bl4DLnsJOx0KTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/VDC+vmm+qfsm3KTA+PdE5BBvwweb5cSiqKc8fWWHg=;
 b=UOlEygxa69/RoCVHiwFBMW4NnJSF3URzFW/8MeZgC6bZe5OTEuuqUo6KjgVNUuh4MGS4Sx4gSVZ8AXE+raD92Ym+b0jsyE023b0cBl5wrJOJD4cKfFvkWB4BARSc65H6c3cIRuNN5MV2TgUc2u1GRAgNuSpEA63uo6AROWQQv+Q=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:15:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:15:02 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
Thread-Topic: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
Thread-Index: AQHbkyTO92AOOtmVFUm9oWmwwCVnGLNvJQsAgAABIzA=
Date: Wed, 12 Mar 2025 08:15:02 +0000
Message-ID: <DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
 <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
In-Reply-To: <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e8b202ce-5c2c-439b-b162-b79e6f19cdec;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T08:10:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SN7PR12MB8818:EE_
x-ms-office365-filtering-correlation-id: 6ff07ca9-3675-4964-e87e-08dd613dfd5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?F7UlLBHF6MoCluPavDNTvgFBBYgme46513IZa+bwjURF93Hl9QqL1RuSXgGT?=
 =?us-ascii?Q?HSLRPWYShS16+u4ReNvzW43IKzQ+4IH96eHUn5Ak/BlcgyEQ5rdQs+ZmV7vb?=
 =?us-ascii?Q?RE42KCNaYUkn/dB5LZT4G/6IihiwNSqEvSvSKUFJaqiCLzvOmRY6EZ918FtJ?=
 =?us-ascii?Q?BP3shmer71+NH9wVgENDJJABZT8sEfHef61CXAtai1/c1SunrHJhIF0ZhTr0?=
 =?us-ascii?Q?AtMP0+mHF+Y7kPBQs0+tQBxf6FkNzc1lTq/APdkT3UGf1/qMRo/FkBdCNk6m?=
 =?us-ascii?Q?/NoIi/e90745GHiWoihdB9fa36tgSHdg5lAP3HmB0XnyUJj+WZemBz19xXNT?=
 =?us-ascii?Q?m63eHx/Q1QvNQe+pusxg9mqxK969yc/E0SXzwhS2AO0Jv7npSf/TBIZFxnpZ?=
 =?us-ascii?Q?qzRzRnyKX3tlsgfltJBAGXhR5awflIslkQ4xuw3+Rt1938RcS1hj5tvG94PM?=
 =?us-ascii?Q?DfHJ83NvAmX92S0rNN4p9zBw2HCqIhRHSUOwOBX2JA6T6Tazp0j3hFv6C6KU?=
 =?us-ascii?Q?dFWpR8NjQxed+6n4BPfAyEC2/WrDCoDqjxaapcCrWHbyWwmCYoa9Lee8BTqe?=
 =?us-ascii?Q?jbz/W5M5RdSSU9D9K9Hd2lNOougVx8Jt2DJxjeSfAKJInXtcPCoZd9AZJYe5?=
 =?us-ascii?Q?QY+xGHx3YLg2R68UcpjqFEjK204k2+1O/bt8bFLZWHLaMMyj0AxgB2RVnhaC?=
 =?us-ascii?Q?VB5dw1woXQrzGQ87L+UMgFkGQcGwpe6VMLC1ThlRp8OY7RYk5qU8EhaFMLG8?=
 =?us-ascii?Q?XtHBuO4K/h0ZiwuYYR7OSUMnbG3UItFUN/AepljmHn1ayPTO268Q8VEEz0E1?=
 =?us-ascii?Q?GqB2y1+5fP519dgpbeMJSazDg7HlIxHMRvpVM/TsRG5aEwuakg/xF6iKbIxk?=
 =?us-ascii?Q?EdRi2nKP53gjgEZJNEwu6NXnT+cpKMOrSwY13ii4paqfRmqIaBnQb3j4cP5L?=
 =?us-ascii?Q?xhsDxSnFKaZJ60oWxSMlVLpLS204M9yHC0a4C7DRSSHNW0SIQ8mLMCmuBd7L?=
 =?us-ascii?Q?0vjNKvf1decl9PGcdLcw26XltlgYuEmqpr+JTzaEgSGHcvDHCSAYSoPzIMWw?=
 =?us-ascii?Q?yJpLM8A9UCRtblwDQMlQMwBflnp5bOpLh0j8iwL7L0GFUEjjYtVj7yezD1f0?=
 =?us-ascii?Q?WYhPstZac/Ai5maZ1CRwYejfvDMFPorlqOK8D90sSNdkBwCb+hRNkq9twVCn?=
 =?us-ascii?Q?p2JqtNijNj4zlvGweJyQ9pNR05gMlqCrQkv+wJXvpjtGEsitOv6bKOFTHarR?=
 =?us-ascii?Q?8wda3XKOS6GKypgdofrbh/tcoGnO43tleWvkB+KRdiu3JLuXtU9tS3d5aEdu?=
 =?us-ascii?Q?wSK4QiQ/cqwmqleeIapbpS+HAYdMshrpsdvoiaRoiMi6OFojMEhJ00O0SJNm?=
 =?us-ascii?Q?7oMdvgHsw1Fc5oLgJesfrW0BY2AzgZ6HOyWrkMqc8N6aV0tENJ1jSjagbuVm?=
 =?us-ascii?Q?d/2OWUBjiwSw3FggQ0FMEq7xPCcMAR0j?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40JyxMlh6npKuQqcaSYN7W1YhFJfEEOih7M6/t4fKTuVwIM3qUrSXMQa5OmF?=
 =?us-ascii?Q?KEgR+auQqiQTxswSrER/QBQLBtZUDYjI9MWNDayX6siCoclYKGJbdj/r+/E3?=
 =?us-ascii?Q?e4BTYEIQidqXmAyehr/vXSSBTh5aD+wuiY44DMF9WmMrK677owjkkaCY/R49?=
 =?us-ascii?Q?NVpjdh02KTbLlIeAYzhqxXBx8BjLcDuxC3NJH+IJoJcI9Prnq9RDpU5S01PA?=
 =?us-ascii?Q?qqsa2M0RuvSiEWoaOD1D72112gGxd9+2Ig9rF52jPyKFmnT5b+S7OdaC9jl8?=
 =?us-ascii?Q?QwzBOFkAFXUcTmSJZR17MfX+ESrf2k3bCTsSADSLIobOXNrLPZjgBkO/ND7I?=
 =?us-ascii?Q?g6ov80NQ+XMsjBUaxYQDCA17Feb6rPRfNvNHaVz2AbXtWRhOACo07oYXzhzq?=
 =?us-ascii?Q?SmOZy7tsd1TRTo0bLEQf/drr13CGbN0NKFZR9rm+KqAA//x9RtLckHFY0Qep?=
 =?us-ascii?Q?deu2LHkUyoMH3bIusGV3Fv2Fe/uPZqMq1rXQ3sslxUgNE1Fgc9gMwCNPxr+r?=
 =?us-ascii?Q?dhBzJIyKYJgwQ5R1ylr1FXm7wQ3S1yrzKGmEbOyZC4KyZ0EHEVyahjuwNqdB?=
 =?us-ascii?Q?zJ94V3CQvIpIV5pySpl7cqzy78MiwYPwZ1lKTvF7wA6/FQEG1mLgQWV1USnD?=
 =?us-ascii?Q?uPZje9P8aRxtru5ZGYT/WfLLZV8EE+cRltSzmg87XdUgXr5Kn+n3njFGk1nP?=
 =?us-ascii?Q?oEZMOzMbnxSDFyiCXawhT7iLBGTboQh5grbjSHuBBdxKX55Ol0oCEcibIMJ8?=
 =?us-ascii?Q?7ochQCz7oinvj/xXY06WSWMAxhJnKm+7VI5WTnGSoq0KTRuAkFZGZOVWiPoK?=
 =?us-ascii?Q?8eBcYE0q+cBzlqlbKfdiqo6bbaMq4WRQJ2tkRaZKzh9YZOtE42we+557C2Zw?=
 =?us-ascii?Q?MLWes1MeF+A024TmZGoI4+QOLZPkyFPhFRSR6BkCyzQAbqxwnX4Rgxm1gIeo?=
 =?us-ascii?Q?ltRd0tksqvAbPtELqY/90nptyIDkZrO1eR287IFg2KNo7+t+GwvRUWqKs++S?=
 =?us-ascii?Q?uye6vSI/kIf20V1jSdlT5r6ZbppQl1CsOLM6gkEwcteWoFuhXMXvoJYsCj68?=
 =?us-ascii?Q?6xl8mSQMWcvhrpRPIzUUFCFVPh+bDFXXgJyUoO4SSjDCZhSjBlyEn85uCa8v?=
 =?us-ascii?Q?rxLPGmryQOU9EWXOrXXJAsRh0if7i/fTVg6E21OwUoISIGrI1iUAep2R6ndF?=
 =?us-ascii?Q?gQgPdRApqGYh2M+YX8C/Sik7Zj/UT3oJqPnpKYHNdNdnsBnWR3+PO12locJ2?=
 =?us-ascii?Q?EwQVZwbHj6p2E1F8g4XzvEhevDg1GpSQUWSemltXggBaVB9CUbT6BkaoYAAF?=
 =?us-ascii?Q?rEAIwPPLBdfoEyIRYoNW1vr3ocOb8pXq4mea0hQRdVgDdnIWgfcwZEa7hWfE?=
 =?us-ascii?Q?nia8h1xoe3wgO/ocw069xQG3Ydy8Ym/g3IZ5UoAAblkXZ1Uwy83q5O+UJ1x7?=
 =?us-ascii?Q?YsrrDB/zoEf1hVm52w7AqL1X7evSx/4htgJ4suXq0TaDOfojMHvOFFIU7xbf?=
 =?us-ascii?Q?JLeJRP14S2yjZ52+awefP6hXgrTQae/TSDvH25rg//1tzrkJriJWqut+MCQn?=
 =?us-ascii?Q?pNFQu44CMsBSzfDlDbA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff07ca9-3675-4964-e87e-08dd613dfd5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 08:15:02.7487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64YwYAF0gkoaaOEDKXqt5wTHsm3fp4nxjUKWgE/dy4YkliIsNcRh15a1ryaG/tnihakC7PYAlfYkIoTIO48PjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
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

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, March 12, 2025 4:07 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan=
.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by r=
emoving dynamic callbacks

Am 12.03.25 um 08:59 schrieb Jesse.zhang@amd.com:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Since KFD no longer registers its own callbacks for SDMA resets, and
> only KGD uses the reset mechanism, we can simplify the SDMA reset flow by=
 directly calling the ring's `stop_queue` and `start_queue` functions.
> This patch removes the dynamic callback mechanism and prepares for its ev=
entual deprecation.
>
> The current SDMA reset mechanism uses a dynamic callback registration sys=
tem to allow both KFD and KGD to register pre-reset and post-reset function=
s.
> However, KFD no longer registers its callbacks, and the reset logic is no=
w entirely handled by KGD.
> This makes the dynamic callback mechanism unnecessary and adds complexity=
 to the code.
>
> 1. **Remove Dynamic Callbacks**:
>    - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdm=
a_reset_engine` are removed.
>    - Instead, the ring's `stop_queue` and `start_queue` functions are cal=
led directly during the reset process.
>
> 2. **Add `stop_queue` and `start_queue` to Ring Functions**:
>    - The `amdgpu_ring_funcs` structure is extended to include `stop_queue=
` and `start_queue` functions.
>    - These functions are implemented in the SDMA version-specific code (e=
.g., `sdma_v4_4_2_stop_queue` and `sdma_v4_4_2_restore_queue`).
>
> 3. **Prepare for Deprecation of Dynamic Mechanism**:
>    - By removing the callback invocations, this patch prepares the codeba=
se for the eventual removal of the dynamic callback registration mechanism.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 33 ++----------------------
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 ++
>  3 files changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e..1c52ff92ea26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
>       void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>       void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>       int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +     int (*stop_queue)(struct amdgpu_device *adev, uint32_t instance_id)=
;
> +     int (*start_queue)(struct amdgpu_device *adev, uint32_t
> +instance_id);
>       void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>       bool (*is_guilty)(struct amdgpu_ring *ring);  }; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..b1f4a11ad0c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -534,16 +534,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct=
 amdgpu_device *adev, struct
>   * @instance_id: ID of the SDMA engine instance to reset
>   * @suspend_user_queues: check if suspend user queue.
>   *
> - * This function performs the following steps:
> - * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their state.
> - * 2. Resets the specified SDMA engine instance.
> - * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU =
to restore their state.
> - *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> instance_id, bool suspend_user_queues)  {
> -     struct sdma_on_reset_funcs *funcs;
>       int ret =3D 0;
>       struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instance=
[instance_id];;
>       struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring; @@ -571,19
> +565,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32=
_t instance_id, b
>               page_sched_stopped =3D true;
>       }
>
> -     /* Invoke all registered pre_reset callbacks */
> -     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -             if (funcs->pre_reset) {
> -                     ret =3D funcs->pre_reset(adev, instance_id);
> -                     if (ret) {
> -                             dev_err(adev->dev,
> -                             "beforeReset callback failed for instance %=
u: %d\n",
> -                                     instance_id, ret);
> -                             goto exit;
> -                     }
> -             }
> -     }
> -
> +     gfx_ring->funcs->stop_queue(adev, instance_id);

Yeah that starts to look good. Question here is who is calling amdgpu_sdma_=
reset_engine()?

If this call comes from engine specific code we might not need the start/st=
op_queue callbacks all together.

    Kfd and sdma v4/v5/v5_2 will call amdgpu_sdma_reset_engine, and start/s=
top_queue callbacks are only implemented in sdmav4/sdmav5/sdma5_2.

Thanks
Jesse

Regards,
Christian.

>       /* Perform the SDMA reset for the specified instance */
>       ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>       if (ret) {
> @@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id, b
>               goto exit;
>       }
>
> -     /* Invoke all registered post_reset callbacks */
> -     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -             if (funcs->post_reset) {
> -                     ret =3D funcs->post_reset(adev, instance_id);
> -                     if (ret) {
> -                             dev_err(adev->dev,
> -                             "afterReset callback failed for instance %u=
: %d\n",
> -                                     instance_id, ret);
> -                             goto exit;
> -                     }
> -             }
> -     }
> +     gfx_ring->funcs->start_queue(adev, instance_id);
>
>  exit:
>       /* Restart the scheduler's work queue for the GFX and page rings
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc138081..c1f7ccff9c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_r=
ing_funcs =3D {
>       .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
>       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_he=
lper,
>       .reset =3D sdma_v4_4_2_reset_queue,
> +     .stop_queue =3D sdma_v4_4_2_stop_queue,
> +     .start_queue =3D sdma_v4_4_2_restore_queue,
>       .is_guilty =3D sdma_v4_4_2_ring_is_guilty,  };
>


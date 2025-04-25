Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ED4C369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C7B10E898;
	Fri, 25 Apr 2025 07:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xaHUWnAW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5312C10E898
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5vjNbSujnjEnE95c4FjUiaZ28TmuHmVslwnZglmGmoz4V1SszH8fXGM1vHT8kQBxVu4KQq/vLYEFO/t3frsKRzEqy71yEbn+/X2m+/UONiRlHx6cocy0fHmi0i9wqHKyKANeA+TMHy72oFFXKAcqQP2nWyJGObI84KC9rQtysgHbf8wv3O+g5diCY6qxc7p8gU0hErswnhQZMm0oOZYCf683tjs4stootD+328wrDDDq9OZHLJiYkUQiIf4ed8E16F7aL8kwqQcewvBAf+2v4FAIjhThXrJyN6/431VuQWxw1pCjOOrInLMz561dbhBXNlp/5zVFwnmhFELx5g2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz1KjEZQwM7W7jSXg6SS8IyZIAWRO7telKrfDnSyBm0=;
 b=B5Qh5wFBpJ3KJKTqgMQalQZQjZWfPA2t4IQybUBG8b569M+52zOi6efIh0dRZACiBRGBEmhaUnq+HwjgJwgZLtdjOvr5mKJdoEzGOFddFoILcgY8re69tsMX6FqYO6y0pNcV1GSKTLYrYFBU/ah/5D4YPU4AIArr9Azfe3l8SFy9pULE+Vc5SvqQMtxbYH5AFaMQP/dXuN7QgSZjmGmqIfZjaqFiz6qAtIhugvI3fJWFNZaPxU2HYLhvQ/V5hRAU8BrYeTW7hEH8hYwGJXcmcjtP4H14xnW2Uj//s7f7+PvpRHHJB2MsKTT29pxy5e41sxTKytCrJ9tahHUU5Mta1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz1KjEZQwM7W7jSXg6SS8IyZIAWRO7telKrfDnSyBm0=;
 b=xaHUWnAWYeZLoRBqOhFymk422s6oxgMlp/ecklHELlqYiHKhM8g0YFJlMFppn4VAUlwZw3bf3sJmjGhbOGm1tXa61/1kgrjOBPjxWs62Fo3sDbC+ZnvyYqiUboeAZgAvlMm8EGA2xzJCtBNjTi4daM68c79mluUmln3PJD5Yicg=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Fri, 25 Apr 2025 07:19:24 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:19:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Topic: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Index: AQHbtbC+ccKGxg3NBU6MKAwb+Y5nY7Oz94zA
Date: Fri, 25 Apr 2025 07:19:24 +0000
Message-ID: <DS7PR12MB6005DA16220E12CEAB86B38EFB842@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
In-Reply-To: <20250425070730.4033803-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=843580ee-1582-49b1-827a-ac3852d3533a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-25T07:13:04Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY8PR12MB8067:EE_
x-ms-office365-filtering-correlation-id: 5358d5a1-b75c-41a4-833f-08dd83c981a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?d/kKLN6cL/XhghHtHGj/TUX/zUQI4dgdHhB1V+odsJAzZIbud0Lpusu8KMQN?=
 =?us-ascii?Q?a/0Q/DhSB7nYlRFX3TilV5zskqhYdmtCSS3fWxGdJDAQCSbPmt1AMFs5QMNd?=
 =?us-ascii?Q?lBbwl3TpWisAZuzUZHP4sOTcr6XxQ1uSHw4s9l88R+8T+H/KvZlRJh48wusd?=
 =?us-ascii?Q?SF51bL4SL7B1sk5Nsi45tsTjUKKBxG3WOucnMj2q0USi+wZEUHPPffBax2ZJ?=
 =?us-ascii?Q?IM8v190BWB92VhhseVD5i/wys/lFTEdnITH+z0mzk2tDBmgHQ/4BUQdJ80cS?=
 =?us-ascii?Q?xDQRZjW5BBCLxXwcVf9PiLrGFtyKJPZlgrxWylV6bVOhbBFJZNDzmv44ce0u?=
 =?us-ascii?Q?pMtm1QDNbveocl6B081s2iGSXoinaxtgGaxV+3WJIT4U8KkkM22/5mPiPhnZ?=
 =?us-ascii?Q?hytYnhA74vCUzw48VcoWnH1jlgMoIdpF8JJcCt8tkdK4PQuEsrOIVT4QcJSp?=
 =?us-ascii?Q?yRCkKFVT/AhBD0uBrJJi5d+LNVP6a8+jUZBme0dxKAf38X3rvwqLCbZ3+0Hy?=
 =?us-ascii?Q?pij4WTN73mRxxb1z3ynGl1A/eFOUi671tsIfTG6ltSgMc++O9RDZ+rYvk/Cc?=
 =?us-ascii?Q?/htT30VM5kcS5MSM2RG0m7JZE/WU8V9/y03eMRkh2M+fHn3ucbIGWNRuHWHn?=
 =?us-ascii?Q?8ZI+E/rXjVqyjm7qOzuZWv7WaSHUGjwyDQpbI9ORoGl3ACI+U8ZM3lw/L9HA?=
 =?us-ascii?Q?gLU4lpPoG85Hg3rDUGL6pk48LpcFlP1zFOK+tTvW1cHnY+o03tkRqeZ2dhOr?=
 =?us-ascii?Q?dEsUscGLeEq5epceg1kFw/RNtKH9A4wLGbsZhuM/aZQVdNqrbJIYl8+cKYFn?=
 =?us-ascii?Q?01pOy+/96ZTTtPRSW3JEX0oz/nKAE3uaLERmjTWfxqamr9a9Y6p64K/VnjNH?=
 =?us-ascii?Q?2Q47k8idueHEqmXQd2J05b2DjnlkFwepIiwTXMmeN3LTYHrkQiqez+REDubk?=
 =?us-ascii?Q?lgm4Y8Hh6jdTPRJBZhZR99qrchdmB+TP/8oTu8jEXkZslFZQTUx+FrnEG7RA?=
 =?us-ascii?Q?KcIaUyPa/7Gk6u+xl45bXy7Q+IFD28n7n22aSuyQLKJ0PC9g23hJdXOqqIDQ?=
 =?us-ascii?Q?09HGLTTv+7GPyjqrQc2wXQqPiQp8nn2DQUjt1Bn4XbwW1J+Fd70d5llfkJ2i?=
 =?us-ascii?Q?4WOydDHKBW6NNtxfPWpu2VDgGgKOYEAUO76i9BALp0JifeE30F4tOHsJqiWy?=
 =?us-ascii?Q?wFMJRX4clusSJIQueRUgrMLdTfjJBfdCDEPcF/MICWxr52YU5lJsuqb1N9OZ?=
 =?us-ascii?Q?4L9XNS2Ak6E/faC8uuPSMOqD5f0dxxout1gxA5mmZ/wwVfJ6xV93zJ9i1L/e?=
 =?us-ascii?Q?SSPufDCQC5OsyNNh50JnVKbVMjUMlsgS0P+R0e6ltOkRrn+H3RguiPJ7sG/6?=
 =?us-ascii?Q?QIYSYp5OHjRCQ8L6BG4pwmjtTY3/pyrrsQBaHcjDfeCl+u+6S7oZqZm70Abz?=
 =?us-ascii?Q?0ouB+gYjSF9ZRH+oLIti4uRoqyWm2inOYkjn7xl9dKKqQiOjaGeb0+lrv8gK?=
 =?us-ascii?Q?afMuwBimxgWFe2Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZptLZhr9Q/hnnrs2YhjzPk3LtDd5Y4+Rfpp0NLIiIUdS5ENqwPb6+32kRUCq?=
 =?us-ascii?Q?sE7ck3Uwub26cMzQcUViS4v/MUMRVf1YFu1M4u1oZ2v0QYSYTo1aFr9ZA63X?=
 =?us-ascii?Q?arsxWQ/rOQNmySl0nFIyLxZDlEnJ6vEqaCybvV4uMTbl6ILDYCT0D7raHWPF?=
 =?us-ascii?Q?n0oJbwc90WCvxhONr2fyNYtxQuPUTKmFJJ2y/3hN5TZ56ehT4c2FG7/w4+WK?=
 =?us-ascii?Q?FJqnvJGPXwM6eFXhaHj1zzjiNViDUjIACVXK66XwlUuGw/zKfTTP9iXfePag?=
 =?us-ascii?Q?OjdSqVlqXh0Ekp3bgey/aFDflgQ8td2DKyZYDfnctboDcKrhdTj7KYrchS3u?=
 =?us-ascii?Q?fJLguvC9ARVVu63ICxR3FOqi13Rxb86HGLPYZ6BkIqRuWD5EeY2be5+Q/AMs?=
 =?us-ascii?Q?x1WJGt+mSpm8+M9Staa8XEfrIb2vkTbOa6xKPNaWVyW8JtRUZq58fqf6ktII?=
 =?us-ascii?Q?xKxrObBvRMG4nmbbCLbP8NRt5YJRT0aZNcbYTaMiQoMCf1/L4zDu4GYd4Bhm?=
 =?us-ascii?Q?z11gUzRu4c87kXCW11vEwqBd117Szdj+71c2yLIxhIKorLO7dVGpT9GKpiAB?=
 =?us-ascii?Q?XfVAnfhQ8pomkXTwoqJ+kFa5tGhJQmSpFyTlitW8aFiwwWr/LvGONoWfDzIN?=
 =?us-ascii?Q?qDesWmSQNk38h0XTVPqhZJoZw3QoxxoOkrzX0OzN/84vmlLoVv87ZJ77bwRf?=
 =?us-ascii?Q?Au/gwQizYgqpf6v8nhwNgYeuI0BMx96eFAiBYDQ/J7Go2QR0Vi/PEDRnjQn0?=
 =?us-ascii?Q?JUWyCPb8pUxLNLnC+fhYc3QhIU48HT6EseK+4m4+E56GTeuOSUoW5dhbNBD3?=
 =?us-ascii?Q?F9hapUjmtTMFo21oAKtQD6PqNGBJFfZdcGDTWkbGxeg6UCcMWDhiZ/epdA7z?=
 =?us-ascii?Q?QJc8fS98fmmovPL6GLxoeYUKe+ezA0Y1IsLaidk7uG3mQSHc+pBcamX8r1e7?=
 =?us-ascii?Q?laOU69DWiXXZupzAc/kLOWMHYboGN8qfFo6jlglE1Oi/tKAOdTlJsf9xu3Xr?=
 =?us-ascii?Q?I9roUSsFek2fOqiUWNUCkfYG7C1Ia4MV4ToIeGftaK9pNyMnQWu2uyfGSuGg?=
 =?us-ascii?Q?DSaeerpTGz8tt4Z8hwUFdDcL/bbBcBwr9mVgYSweelV5oWlhvIV/ES805jLJ?=
 =?us-ascii?Q?qOBTQPxguWKMdGRIHJ4MCu/P+VSHcb3W62bg6pNxQbFsA8l2sMOqrtXLH74A?=
 =?us-ascii?Q?XU+A6lE2j0q8JtHHlDRmd43l7sXIR9OuhFACDUuNk6d0Vm36zxlIu8POw7Qv?=
 =?us-ascii?Q?zZtkjCXnTQa8mfDbHXxPvAX0upePwu4pMB4rM3Mabnj6udRLjHLn7mKy1vAY?=
 =?us-ascii?Q?gF/L1m6LbJu5Bk6seuS6lgngBuFF52/TNALugog9jri64wHxUoMY+NkoL+vF?=
 =?us-ascii?Q?sHhNvxYIF4df7sk3Uw66BqeYjIu00hlm4s/mCx5E5ZgblBGvygr6qrz2AAT/?=
 =?us-ascii?Q?xLQQnyy8L9yK2EsBwWOBGMs4CtBrU9UiYkJ8ijaBbA0qKRAQg6fqsYimL+ei?=
 =?us-ascii?Q?FewzF1uHafSxvkp+lrIlMs8z2pbTSRpliN9P0nOdHzCZtFsVcddPpq/tcLxE?=
 =?us-ascii?Q?7ijTDWZDTIkFACjt/BI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5358d5a1-b75c-41a4-833f-08dd83c981a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:19:24.2776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QhvwR/VzaBkONl30UN+dKSRUEHhPTnBEqtwO8+GxHFNmSfeKoaPjuCVk73MkiXX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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

Will send a new patch for updating the patch subject.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, April 25, 2025 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fence=
s
>
> The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP usage
> fences, so here only return and sync the dependent read fences.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index 5576ed0b508f..4e1d30ecb6cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev,
> struct amdgpu_sync *sync,
>
>       if (resv =3D=3D NULL)
>               return -EINVAL;
> -
> -     /* TODO: Use DMA_RESV_USAGE_READ here */
> -     dma_resv_for_each_fence(&cursor, resv,
> DMA_RESV_USAGE_BOOKKEEP, f) {
> +     /*Only return and sync the fences of usage <=3D
> DMA_RESV_USAGE_READ.*/
> +     dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
>               dma_fence_chain_for_each(f, f) {
>                       struct dma_fence *tmp =3D dma_fence_chain_contained=
(f);
>
> --
> 2.34.1


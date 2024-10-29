Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F21D1356B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E7010E5AC;
	Tue, 29 Oct 2024 06:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kNzSKvpS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9020E10E5AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuRXON7RkV/8rVcSCAzL6r0077zm8N0Cxf0DelEf6qdHaJD15CJqKsAM/u5luK6DV+/G7QLVy7znIPaGrnvqqwrZAcPwR+34NiFobfbbTj+Ntpcils/dyFRF6PooMyUWZh+9jHKdvqpYZqbOXeQZziBA312m0zZVAgPNILRlr8hBkUzGhLDXTVNhu4GynY0wXkxqBZjYsuiGhqFg+q6em5cYgKKMfdLtT5upKQKQXZjtMzGMmvzz5n48e0dfzeumGjADZPAYwwsoR04N/jL2c/Iw6zveoFfbn9uB6fJAxbfV8rJ+lt/J+IQj4PqQbyE71nHgZeoOFghVsrdLobgfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx8btYqygt8pvHqv0h3wFOlu6wQDsA6tzoyGTcjSP6U=;
 b=hvPttu5Nzlh+HcehlLcPepcevnEJxllC9F141LKVFKRCGmfspbDacrPQf/ER5EGUg2u9Rk1tGmwWvihCfvi/4grDdlBGCArg3WV27kpPp/RAVFbcDkGRRAMzSG0CBkbQ8XMxAZsgYEdRt85RSDee6cPIgZdpspC/pgT/NjoyS8uUf5X777j6Ke6wCdgpjaDZGUX5BQBv1Lzlr3dLOFaK9nBLu20Hi0yLHQILWvty+akvafue9oWJkcM+KmfxPjR/5z4MN3VUrHWw2siTmTjm/Qwpw+AVdRoFkRQhN+2NTsYg5lZFH1ieVn3kyQdX/yr5PnvyH9Mo9nu9+RYCpZvg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx8btYqygt8pvHqv0h3wFOlu6wQDsA6tzoyGTcjSP6U=;
 b=kNzSKvpSztA4w0p9HlyuLjNcNDUDS/83iTM6ff5mmcPHnm8NSP6i52lVVBD7XB4oEjumwPu3ZFTBU/joGZKxc5jLbhHy7xuBIxUA0Wna57sG88q2cIudaQ2n2/tHr5Jx2L1vV4x90GmRLj7O3BrcjKxfcpREtvj5dBJpLDNljck=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 06:56:06 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 06:56:06 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V4 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Thread-Topic: [PATCH V4 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Thread-Index: AQHbKc2jtjj0eZUmlUSwgGoFtYIX3rKdSqQg
Date: Tue, 29 Oct 2024 06:56:06 +0000
Message-ID: <CH3PR12MB807442F079D584C1035B23EDF64B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241029064136.3057034-1-jesse.zhang@amd.com>
In-Reply-To: <20241029064136.3057034-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bd51f30b-7b00-42b4-9bb9-f10d1563c746;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-29T06:52:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DM4PR12MB7503:EE_
x-ms-office365-filtering-correlation-id: 9404b6e3-5098-4856-8469-08dcf7e6c2b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lOzs5BSfom8JNY2zdxkZW9tdA4+rJhZJAVnGUy59rvoaHbSGV8l3eFsA6zJT?=
 =?us-ascii?Q?oB07gcf5tLjq/Ym+sNAbDiV107ZgK+ZYNPioXWvLDsevFjETpsXAHsIV+1dj?=
 =?us-ascii?Q?nwtZZ3BP/NRUEohb1+D9mJQx42DymQKUsmp5VcxEdVn/7GItWVmOdYJ+YGLm?=
 =?us-ascii?Q?Qp6z82sj8hrAV85x0T5Fy52Zr5MJtCx8aY46XZbE8OZY2wFyGk8uieqApR6M?=
 =?us-ascii?Q?xCsRkC8VvBfM2P3aqluyNHXwkAKVpsKwMi7jFOn+dbSII4kjQJjaybjQpJ4V?=
 =?us-ascii?Q?Y4YWUYwS1o8OD+x5UjfdLomvpLyd7fAKi1czVkPCbLAzUmktZbG+y00J9FZQ?=
 =?us-ascii?Q?DEpjxa0pH7dp5V+Rnp0b89wfj+y4geLBezJ5DYOqQ9SpatKZ3BH2018FS+n2?=
 =?us-ascii?Q?ajQc+hC08bFEhMQN1s9LN+uO4MEXW22HkyDSTL2kCQFo1GFF+2dKCjvIJwDJ?=
 =?us-ascii?Q?HA/CnrD9+pP2/kd2roeGxFurCFv6eob/etpZN+R2HgjHgurxWIcyoxcQJAFM?=
 =?us-ascii?Q?96S6NW0v1lD17WPaSQbKWM9PVyq15QtCZiar17rYtCku5wF9Do1hB9XFuclp?=
 =?us-ascii?Q?d2MmLng90KruGZJN9r8FRnz8It2qOdEx/scUUBreEszgik8klhPPyxHsQNGy?=
 =?us-ascii?Q?e6+cGj/7gjX8ziTt5Yvh5RBQ/7oIRI9QoQ5aWg+1Kr1eHcuuIJPuML31Al5Y?=
 =?us-ascii?Q?xVohfZEMTg/DKDwwCPDY1+ZmYlGGmG0PrUy1z8cj8NF/mUmInZEu2dvTScmt?=
 =?us-ascii?Q?UkyfgYR98fAHp6F0G+rr94MuzSNyvVCL7Zpd8Du3TvEuJ13/8IFu+F8QJTRn?=
 =?us-ascii?Q?KtanlM9tRkasvJb8uBd/xdOzBcGLaf0W6AECnV4ReVi6dTqXHZbNyYIlkutn?=
 =?us-ascii?Q?/oxDro7ljEZpJyvFFDpXRomX+UPf0632sHsNJ5X5VlhuWutTs9d7fpcShDKu?=
 =?us-ascii?Q?m2+TPP9ved/EsW4jQL3noH62V7LtjamRucTBo0rkkqiO16TnmDgx6t7vVpB/?=
 =?us-ascii?Q?XQPgcRSfpV3XTZ8HX+dNivKLY3WHXoyaLSd3rryCXTxFdEAFI8Rq3jZW7Ti0?=
 =?us-ascii?Q?qRvIZHaut+xjxGfz/IGVQSyXJuDsuQ7UeIdpJgpuobHwXKwFNWvbMGqB0V9H?=
 =?us-ascii?Q?aXe+OJzKAR1qeyUxGMYDcmUVdHIFZqU8TUGlfZ6pJWhigs6udnevR0jc/ujb?=
 =?us-ascii?Q?XiqNZNqr8ywTSJhwhZ7rz6q36Abz635qZgkqW5emnWf7TWcv2hYQ2SvjZVou?=
 =?us-ascii?Q?fdn/MSAbl06DLpOk2jPPV3JPRIclVQgWpU692Z4H7kqk3JSHYeqYMII/cyDP?=
 =?us-ascii?Q?7KkXFLauXQtkqYv5ix5OdONRsUp19mOz3cBcVvx67BIyaHQ0NSuZmKWotTHH?=
 =?us-ascii?Q?W+T6+v8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x3O9mDgj2gQ1EaN6dDMtfknYRFH2gFdQni4wnvBmBHlRBOJgEFfbBo3odNKe?=
 =?us-ascii?Q?+uAmTevtu2CY63LjvaazVM8BvvT2f6L86Jbsaqwje4yfll3RkOT/+11TjD+B?=
 =?us-ascii?Q?o6JFv4T9HUBDnPUbOGIoWc0RjR2czP75NJXQs1nnBFQQJpLIQynLa1EF0Loa?=
 =?us-ascii?Q?9zM5Uz04Y1pZ57FI2ylRmmMEIjxQXGu97DbALu2r91lD5XxP019KabJf0HWv?=
 =?us-ascii?Q?DCfXph63Gswba1PCo9vR3WgcQDkuCFY8PqXqLmOrjmNeAP8aoV4psKBkyrXh?=
 =?us-ascii?Q?rCqgSKrKH5JrR8NW7Y5uNUKmgFI6nrIuY1n364oqX83dXCpq7RCPfi3GEU+f?=
 =?us-ascii?Q?Csu28ZRTURohcxLtKuWpBv5avztGO7I7JQ1JRiphklWzk2aorB7T2DIO8WD/?=
 =?us-ascii?Q?C2NxGw69RXmsm5tPS2AGHDDSMISPhCFsduUSLXXCk4C/o8ThJNthaGSBuvht?=
 =?us-ascii?Q?TKOY3c8RdDCfayFSuAoSB4Xf6sdmmleDaCHQ81QLnJjfLAIqjvWcSKfxGnII?=
 =?us-ascii?Q?ceL8H/pWi+EseEq6RvSVYPWJldzaB2jaaE3EzPyaDSJAC1kqgf1bsJ+4DmDl?=
 =?us-ascii?Q?YFFFWkv1auVmwzCPyLUIJ69hmT21yTuWQEpBUfb0OiVrlUIeAU2mp4Nni1M+?=
 =?us-ascii?Q?XZIgU5YQNisVWxgnfcVE7sUD2drj9Mjfd/ireUL7dopJWmwObfbQXLAN1P7B?=
 =?us-ascii?Q?J8XJzUeRG2BGAPeR/O9idFJ8hJHb0oV8Ott2bZWYdJ/lYPJb/xJdS8nLk+oW?=
 =?us-ascii?Q?y8F3kjtjS9plLAUqGzitfTwrh4PuDT6V7I2coaH/iz/MbjsY9FPZT+vAGE09?=
 =?us-ascii?Q?PjOMaxw5Hp3DDxP3xkhE3XeJDI5LcDj/xB4J/Oq6clI9fdOc/q8yul2G2T+U?=
 =?us-ascii?Q?OBxrbH3ES+ytUPQN3RYOObiZJTIirJZTlJURtD+4FBxgJnOzP3EE2XG9q6ui?=
 =?us-ascii?Q?SxrasoHZCvkZl0ZpKNVUFrKvQ5r3vXcNgAb2/Jpo4TpSjEoTEX+JYDMlxV2f?=
 =?us-ascii?Q?4iWuY3thypZ4P3Yxlf5V7lHdWgVZepC2y0K6aH/T+Zp2vH75IgR7nBhuLkkK?=
 =?us-ascii?Q?PNQwJjVHiiUChwaVKhJFk4DjNmMLVXDwO2xXs5ciHc2klJ6Gbog/ww822kB6?=
 =?us-ascii?Q?pQmXHf8b/mA8S3ko+JB2MQU6xZPz8E7hKiydln9RXa1LmBA/GLg6KgxXRKJN?=
 =?us-ascii?Q?g3Fdu8bbaC/BttnEo6WQeTG/nn8diFWZ/9T2rWSYQVnJNjfUVjH9LWl3r4le?=
 =?us-ascii?Q?vVQa5DrKdKq0PXGvnNtbDBfk9U09bY/mHtzB6hS/pitevPCCGEVqWrzV2Y/9?=
 =?us-ascii?Q?hceLBrkCZD4L6ucp5F98Dt8s5BnT+0DOrdg/Lig/UlUcEbSSJbTo8SyvYlDt?=
 =?us-ascii?Q?0/Ez3m1buccku5RMqxOgkTwuKpd6h43bgrvzdgskq7LdPK/lBa+LI3v0skU4?=
 =?us-ascii?Q?B6hB20usfiWOQJac2uRNjzajsM/fKAgyDLW5PmHR5EAFHYi/8BD+LVGVQ8nv?=
 =?us-ascii?Q?ImIhJmIyqoi0z9jZwD+9MJOPZ47eAt6vLcIPle3239rja8XcG3ZMZK+ZHsUx?=
 =?us-ascii?Q?o80VWr+LXhCummrG4XY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9404b6e3-5098-4856-8469-08dcf7e6c2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 06:56:06.0751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAFb2IwYu6tzQywRoIuEmDONbpsPy9CFJfLuhtpEf3EoDqsWkV+CqTCJF0+mRuA48xqhtZHefguou35iq38Daw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
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

Hi Jesse,

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Tuesday, October 29, 2024 2:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V4 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
>
> Add two sysfs interfaces for gfx and compute:
> gfx_reset_mask
> compute_reset_mask
>
> These interfaces are read-only and show the resets supported by the IP.
> For example, full adapter reset (mode1/mode2/BACO/etc), soft reset, queue
> reset, and pipe reset.
>
> V2: the sysfs node returns a text string instead of some flags (Christian=
)
> v3: add a generic helper which takes the ring as parameter
>     and print the strings in the order they are applied (Christian)
>
>     check amdgpu_gpu_recovery  before creating sysfs file itself,
>     and initialize supported_reset_types in IP version files (Lijo)
> v4: Fixing uninitialized variables (Tim)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com> Suggested-by:Alex
> Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  9 +++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 23 ++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 17 ++++++
>  9 files changed, 184 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..aea1031d7b84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
>  #define AMDGPU_RESET_VCE                     (1 << 13)
>  #define AMDGPU_RESET_VCE1                    (1 << 14)
>
> +/* reset mask */
> +#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset,
> +mode1/mode2/BACO/etc. */ #define AMDGPU_RESET_TYPE_SOFT_RESET (1
> << 1)
> +/* IP level soft reset */ #define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2)
> +/* per queue */ #define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe
> +*/
> +
>  /* max cursor sizes (in pixels) */
>  #define CIK_CURSOR_WIDTH 128
>  #define CIK_CURSOR_HEIGHT 128
> @@ -1466,6 +1472,8 @@ struct dma_fence
> *amdgpu_device_get_gang(struct amdgpu_device *adev);  struct dma_fence
> *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>                                           struct dma_fence *gang);
>  bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ef715b2bbcdb..cd1e3f018893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6684,3 +6684,40 @@ uint32_t amdgpu_device_wait_on_rreg(struct
> amdgpu_device *adev,
>       }
>       return ret;
>  }
> +
> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring) {
> +     ssize_t size =3D 0;
> +
> +     if (!ring)
> +             return size;
> +
> +     if (amdgpu_device_should_recover_gpu(ring->adev))
> +             size |=3D AMDGPU_RESET_TYPE_FULL;
> +
> +     if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
> +         !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
> +             size |=3D AMDGPU_RESET_TYPE_SOFT_RESET;
> +
> +     return size;
> +}
> +
> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset) {
> +     ssize_t size =3D 0;
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
> +             size +=3D sysfs_emit_at(buf, size, "soft ");
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
> +             size +=3D sysfs_emit_at(buf, size, "queue ");
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
> +             size +=3D sysfs_emit_at(buf, size, "pipe ");
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_FULL)
> +             size +=3D sysfs_emit_at(buf, size, "full ");
> +
> +     size +=3D sysfs_emit_at(buf, size, "\n");
> +     return size;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e96984c53e72..6de1f3bf6863 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1588,6 +1588,32 @@ static ssize_t
> amdgpu_gfx_set_enforce_isolation(struct device *dev,
>       return count;
>  }
>
> +static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
> +                                             struct device_attribute *at=
tr,
> +                                             char *buf)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +     if (!adev)
> +             return -ENODEV;
> +
> +     return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset); =
}
> +
> +static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
> +                                             struct device_attribute *at=
tr,
> +                                             char *buf)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +     if (!adev)
> +             return -ENODEV;
> +
> +     return amdgpu_show_reset_mask(buf,
> adev->gfx.compute_supported_reset);
> +}
> +
>  static DEVICE_ATTR(run_cleaner_shader, 0200,
>                  NULL, amdgpu_gfx_set_run_cleaner_shader);
>
> @@ -1602,6 +1628,12 @@ static DEVICE_ATTR(current_compute_partition,
> 0644,  static DEVICE_ATTR(available_compute_partition, 0444,
>                  amdgpu_gfx_get_available_compute_partition, NULL);
>
> +static DEVICE_ATTR(gfx_reset_mask, 0444,
> +                amdgpu_gfx_get_gfx_reset_mask, NULL);
> +
> +static DEVICE_ATTR(compute_reset_mask, 0444,
> +                amdgpu_gfx_get_compute_reset_mask, NULL);
> +
>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)  {
>       struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr; @@ -1702,6
> +1734,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device
> *adev,
>                           cleaner_shader_size);
>  }
>
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev) {
> +     int r =3D 0;
> +
> +     if (!amdgpu_gpu_recovery)
> +             return r;
> +
> +     if (adev->gfx.num_gfx_rings) {
> +             r =3D device_create_file(adev->dev, &dev_attr_gfx_reset_mas=
k);
> +             if (r)
> +                     return r;
> +     }
> +
> +     if (adev->gfx.num_compute_rings) {
> +             r =3D device_create_file(adev->dev, &dev_attr_compute_reset=
_mask);
> +             if (r)
> +                     return r;
> +     }
> +
> +     return r;
> +}
> +
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev) {
> +     if (!amdgpu_gpu_recovery)
> +             return;
> +
> +     if (adev->gfx.num_gfx_rings)
> +             device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
> +
> +     if (adev->gfx.num_compute_rings)
> +             device_remove_file(adev->dev, &dev_attr_compute_reset_mask)=
; }
> +
>  /**
>   * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD
> (Graphics Driver)
>   * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..fb0e1adf6766 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -424,6 +424,8 @@ struct amdgpu_gfx {
>       /* reset mask */
>       uint32_t                        grbm_soft_reset;
>       uint32_t                        srbm_soft_reset;
> +     uint32_t                        gfx_supported_reset;
> +     uint32_t                        compute_supported_reset;
>
>       /* gfx off */
>       bool                            gfx_off_state;      /* true:
> enabled, false: disabled */
> @@ -582,6 +584,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct
> amdgpu_device *adev);  void amdgpu_gfx_enforce_isolation_handler(struct
> work_struct *work);  void
> amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
> void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev); void
> +amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)  { diff
> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9da95b25e158..e2b2cdab423b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4825,6 +4825,11 @@ static int gfx_v10_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>                       }
>               }
>       }
> +     /* TODO: Add queue reset mask when FW fully supports it */
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
>
>       r =3D amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
>       if (r) {
> @@ -4854,6 +4859,9 @@ static int gfx_v10_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>       gfx_v10_0_alloc_ip_dump(adev);
>
>       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +     if (r)
> +             return r;
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
>       if (r)
>               return r;
>       return 0;
> @@ -4896,6 +4904,7 @@ static int gfx_v10_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       amdgpu_gfx_kiq_fini(adev, 0);
>
>       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       gfx_v10_0_pfp_fini(adev);
>       gfx_v10_0_ce_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..89af21b57885 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1683,6 +1683,24 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +     case IP_VERSION(11, 0, 0):
> +     case IP_VERSION(11, 0, 2):
> +     case IP_VERSION(11, 0, 3):
> +             if ((adev->gfx.me_fw_version >=3D 2280) &&
> +                         (adev->gfx.mec_fw_version >=3D 2410)) {
> +                             adev->gfx.compute_supported_reset =3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +                             adev->gfx.gfx_supported_reset =3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +             }

Should be |=3D here?

Best Regards
Tim

> +             break;
> +     default:
> +             break;
> +     }
> +
>       if (!adev->enable_mes_kiq) {
>               r =3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
>               if (r) {
> @@ -1721,6 +1739,10 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>       if (r)
>               return r;
>
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init (adev);
> +     if (r)
> +             return r;
> +
>       return 0;
>  }
>
> @@ -1783,6 +1805,7 @@ static int gfx_v11_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       gfx_v11_0_free_microcode(adev);
>
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       kfree(adev->gfx.ip_dump_core);
>       kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..f5ffa2d8b22a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1437,6 +1437,12 @@ static int gfx_v12_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> +     /* TODO: Add queue reset mask when FW fully supports it */
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +
>       if (!adev->enable_mes_kiq) {
>               r =3D amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
>               if (r) {
> @@ -1467,6 +1473,9 @@ static int gfx_v12_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>       gfx_v12_0_alloc_ip_dump(adev);
>
>       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +     if (r)
> +             return r;
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
>       if (r)
>               return r;
>
> @@ -1530,6 +1539,7 @@ static int gfx_v12_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       gfx_v12_0_free_microcode(adev);
>
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       kfree(adev->gfx.ip_dump_core);
>       kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b4c4b9916289..94007a9ed54b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2362,6 +2362,12 @@ static int gfx_v9_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> +     /* TODO: Add queue reset mask when FW fully supports it */
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +
>       r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
>       if (r) {
>               DRM_ERROR("Failed to init KIQ BOs!\n"); @@ -2391,6 +2397,9 =
@@
> static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>       gfx_v9_0_alloc_ip_dump(adev);
>
>       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +     if (r)
> +             return r;
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
>       if (r)
>               return r;
>
> @@ -2419,6 +2428,7 @@ static int gfx_v9_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       amdgpu_gfx_kiq_fini(adev, 0);
>
>       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       gfx_v9_0_mec_fini(adev);
>       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..bd1a0f9b7a37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1157,6 +1157,19 @@ static int gfx_v9_4_3_sw_init(struct
> amdgpu_ip_block *ip_block)
>                       return r;
>       }
>
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +     case IP_VERSION(9, 4, 3):
> +     case IP_VERSION(9, 4, 4):
> +             if (adev->gfx.mec_fw_version >=3D 155) {
> +                     adev->gfx.compute_supported_reset =3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +                     adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_PIPE;
> +             }
> +             break;
> +     default:
> +             break;
> +     }
>       r =3D gfx_v9_4_3_gpu_early_init(adev);
>       if (r)
>               return r;
> @@ -1175,6 +1188,9 @@ static int gfx_v9_4_3_sw_init(struct
> amdgpu_ip_block *ip_block)
>       if (r)
>               return r;
>
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
> +     if (r)
> +             return r;
>       return 0;
>  }
>
> @@ -1200,6 +1216,7 @@ static int gfx_v9_4_3_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       gfx_v9_4_3_free_microcode(adev);
>       amdgpu_gfx_sysfs_fini(adev);
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       kfree(adev->gfx.ip_dump_core);
>       kfree(adev->gfx.ip_dump_compute_queues);
> --
> 2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82D5D5B874
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 04:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F14C10E155;
	Tue, 29 Oct 2024 04:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lbDqWRiL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E281210E155
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 04:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVZHXDGvN4v8eyuX/aYYE/ZHUKU3ndMxs2VGjzFNNh9WfrLT+B3aULAlR/eqEmyE1+BDs0cfHSCG42SR/8pkNEnGebT1SdVjaX5DMVmfKQrUyBUgDWrRPHeHIK2h4eSeU1W0GVIqh2vyBGP3H08QUmZlPY1l2iUIPTH2TjNrc65O4cOfvRUEUVQwlumb4aRSC7R42Fjxkl8QjaO+3WXAQmkd4RUvJwIjzCyw4P9avrpfb48RGY4pcqw+szgMyLeykWbGxL/+7BlYb3AmVNpHJL0ZecULd6Mj7W6A+PwF6ulgVbHBo1SlyuJBu8awaDBt4HhRcedcebHcE+zhGECJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4YkJpvbW1I0PqYcgHB6ph6uHibYkFVYu7WbPxPM8ek=;
 b=IOcc+9fRhSucX79/lIrNPJ6B3P9BuI9W5nSK0XyrS74VnWMlmtf046quo0NgF4HZGhYsY4tz5LLrfASYLzOz+vzOz9wlO5XdyrltVK76pxsty8ftjiYFCwG4cSoI/5Vow49cijR9aBaoUqFRdFyb7LEis8ivFe+96aAEPs3ntCTLuvu3Z6oqR/mr3iKkt997guO14IuPrutMspN1MBqb6i+F23XyV2/jOIPdUPrUJOsR9LEN5E/7uRYEP+FFTA9TjSbJhyp/ny0TsdNwle3rCKX1XbOf1RGrA1i7ywtZsaCc3CEdII1dHk907w6uMsNnIKu4mKANXXwgdBHIEipbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4YkJpvbW1I0PqYcgHB6ph6uHibYkFVYu7WbPxPM8ek=;
 b=lbDqWRiLeRALD4JViKgih2YRdBEb2d/jy7mYxxfBOaah8FXi3QwW3+pZmEc33PHgWzCPDbWSEPXtR+gwkWiSATaZW+eG1B68IS+YKCJojWI1Z9M3/YVCC5c4E9GZqj74lVS0awQ78OgUbnqyV/9SGcS8tTlLDgJvsADlUxUDjW4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Tue, 29 Oct
 2024 04:21:21 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 04:21:20 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Thread-Topic: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Thread-Index: AQHbJeftqp22rHaPQkirmAVZzhi5B7KdJ2HA
Date: Tue, 29 Oct 2024 04:21:20 +0000
Message-ID: <CH3PR12MB80740FE14544C2B5AFBD8BB2F64B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241024073933.2709389-1-jesse.zhang@amd.com>
In-Reply-To: <20241024073933.2709389-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=7566df4e-db63-44ac-83a1-85ad3ea97ba9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-29T04:18:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|BL1PR12MB5801:EE_
x-ms-office365-filtering-correlation-id: 4ee07738-d1a7-4395-1f50-08dcf7d1243e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MP39MAZD3ZbEG5shX51jcOLCOpXyElp7m4Kv+AXC/W5x2reuGsJKdTTwdeD2?=
 =?us-ascii?Q?d1jgsuUhFrc6hPdP8MLFIUwAsAX7Ec1TRsZ4KzrThhkCLzEgJuYuGRsVepTp?=
 =?us-ascii?Q?pTglW0qe2UVlerQ6fQ8sX8vmG0MYjobilLB8WExGErwIipLQdOW0gcJHNW97?=
 =?us-ascii?Q?rHWIXgxB69ZcIeD4wT1CM6QErjUyKrXzEBshVMUwtwOfAcSHpjF/KEKYoLDI?=
 =?us-ascii?Q?jpmsAF1ys8x5yRvrVYMAuEwMCw12brNAnH5j/Ydsi+XBQV9GjF5SBqRBx5ou?=
 =?us-ascii?Q?KjULhBCc6tTr9f/r8SxZM6BjhwQZirlM1w3uCSQcVTnQBweNS90q/d10Mk/e?=
 =?us-ascii?Q?6wJ2yle8ysEs089x4To9KkxrtA1XAo4/BnoQrMI8xiPpXp0RvHsioNjKruyU?=
 =?us-ascii?Q?OAabP7BvVYOlkI2VNi9zrH/6ixXzRq1yupIWG0oJ5DvnU78n9cRvpX2Xw+AE?=
 =?us-ascii?Q?966/4VJ2KxDcodftX7AT1gYKBNKnJQDoWxn0obdgsT18DIQnn+Z4POhPDVm4?=
 =?us-ascii?Q?FstNzOJxBIBWhu4AVcy4AWoYxctPL57LuVLOWCGKuHB1VILhCWpXvKzSUagt?=
 =?us-ascii?Q?utHfFfAiGyFqqyeptrRW5iZiJVwg9JzV35H5cS9Ll7gHYyZe25tvuA3C7XkL?=
 =?us-ascii?Q?ByqnrqFWAVBwK9ZIIAOAwLA+t86CQjUFHudeGUSQ1BB/6g9fbGR2rmLLMOsq?=
 =?us-ascii?Q?/jHGw7dIWH3toPTgl6A6kYyeFVcjse+j2H/kj9NfALLo6ioSUZ4E3hEF9YxD?=
 =?us-ascii?Q?6RcjTGvX8FlLqkF8RGPGQgYO1n3yG7orSPalZ/G0FzqR/7JW1aOYNRnz7HMQ?=
 =?us-ascii?Q?KmhyWbkujtZj5LGTN3Dy/8Q9QwJ6h02QyYPATLWlVyp98W4jjO0k6g3Ej8Y1?=
 =?us-ascii?Q?selIEFBUxEm8SbvuQIbiyf4bVX4B7Z2E9MLl5/4t5fSk/WCCHD1unDWr5b7Q?=
 =?us-ascii?Q?zs0fHxspLQZX8v6kbs4tJ7d7YOvLfWKHT6PH2+0s4A6LHzd7GHD+UxZK34YZ?=
 =?us-ascii?Q?pA0tZBy6TW1V4XksGsN/xjAx/X6XWwNWaRQJy3WBRh+hs9hBHjPdbGjoLfBw?=
 =?us-ascii?Q?FPhZTek/tYIkGiweKIA6kgY6YRC9irzcXkgbEO10Y8xMKybXnM+ZmDwxqcn/?=
 =?us-ascii?Q?3fA3kIRK9m1LW57gRX3teMnsW9jk4KK/JnX5ttUWsocFAa8Q+3X43+3TJvY+?=
 =?us-ascii?Q?fxr5B4EIMKKbS7Tficf71WoVykpUYjltweOUwKUnfZTjmWaXudNh7QFIY2sC?=
 =?us-ascii?Q?geIs8+t8Hfw6CtqbDN1Vrb0U1zdZYmHidPzenwP6BQBa1dmIJ3eSNTIVT+2N?=
 =?us-ascii?Q?zHdIHSFpgzrgz19SFMohNtmjLdu4aTBLtmppLOWojwkt0iALej8a417RYw+W?=
 =?us-ascii?Q?3myPXbE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?edRWD6o8N1NG/MmXbjf+W3NeqWr3awyFmk+iThWY+cHChUc80ropHgbbKgf/?=
 =?us-ascii?Q?8AMQGS4odrr0NRSsTiKkZcBA8XbdDKelMYfCE9j3GN06t5NobbA3gVZ1eZIN?=
 =?us-ascii?Q?ZrJhavJ88kTWFFReN0bLfrEHTGAWTCTmHkHHZCN8ArH1SDL8NllERAQ4e8zL?=
 =?us-ascii?Q?QiM+k8XQ7dzco3JHTye+nplTw5NGvYsMl/MjiCVHYG6irhlPLL2LL2xr9mUY?=
 =?us-ascii?Q?hD+Iwxxeg+rO7tPt4lBUHswZj0MwfC11fGZ4ju7FZuz/YH/nZbh4BNfFUUiu?=
 =?us-ascii?Q?G+XLToyKKdMhYgH8dR1QgUF62yNcJslS1lTkwH8SV3sLDglppihZlGsqMXcS?=
 =?us-ascii?Q?Vz/3hsVPYFlh/OoTJc5H1JVI6PnIFu2FQDc5MDTguTVt9Ls7V1GLgqg8mvsZ?=
 =?us-ascii?Q?x0VkdAmQd9M/zFRX/0zKAII5pLy9gOhmCIVmK4iYYLnNsW/Kxyo/QVsHwRSh?=
 =?us-ascii?Q?2Mp2g1kGyth2c38wDeVZYnJ1HuTCJ3BTU9LGCY2n2gwgdSKFTwujkoV7jxK8?=
 =?us-ascii?Q?Y2QboT7/i5/ZWjK5StKVLaHtPaY0GM+61YOFoK+yhcFknHFLv1ybisJ/eR6L?=
 =?us-ascii?Q?7djswTymLnEUf56A93UIlyQUcyXFR6JU/Hp4IIX3MO4Ylk/jCQgy/rUFf24L?=
 =?us-ascii?Q?VCldRF4RPylKRWncVUA9I0T3Ko98rzdsBSy95qz1LssqkzQHlslLUeRGWANj?=
 =?us-ascii?Q?zENOwVwu2g532YLIduGoZwpV3IQVWRlLRG4s6spyX6xIW0HcaKl05bsK77Rx?=
 =?us-ascii?Q?MIcWI7bru86nyUcrRW3XdYYVyK9p07O7yMrplEPJkU9kOyg/9DPL4WU/jtWo?=
 =?us-ascii?Q?pPScMKcC+GlfppkzJ3nI1XcqbOGg5c2wK5DTIWbpteqQPtVjMkT97a+i2K8p?=
 =?us-ascii?Q?YidnrzSU+Yw9t7qdlpEWuCcrK8NBTXJB7u6Ut11oidJZWMeXUA4TMqz+xIBP?=
 =?us-ascii?Q?tdjPTceHUs0QJf5EbVxpsRmYDxmj12g+lf4SAT9rWSsbUcOUfLeG5dk1upnM?=
 =?us-ascii?Q?mLnDZYs5eROozEg7Owj4F+np4ePoAaZGzNzGHljGoGjZcQemO5FSv4Qy7b2N?=
 =?us-ascii?Q?s4cC1tV/s7Tc+m+RFCUq2x8SE7E0xyWFsVXJOToK8OZbWD+th32EfW8yNPpQ?=
 =?us-ascii?Q?6CxSfUYXxf7uPg0WsnmjPhPr2jBweTNAlHzpyQzmCEJp6Ct9IHdut/fPDB8V?=
 =?us-ascii?Q?WaLUx0YBRTBGNP7raOnIicNJkbFgKDy4eM/RiuRzoLGxskyHXpuBaXKnBq+/?=
 =?us-ascii?Q?IsgZn8G/7muKXpxDoGr0XWbZvfU5tWCzFn8q5jSbAInBmB/IagGtWXbjr7Ax?=
 =?us-ascii?Q?IStDuqGU4n43kML3l4DMCNjN2hD6bC+NL3VVn/RBjb2+FEIG/QiI3LsqZBRO?=
 =?us-ascii?Q?Pgp1zNFxvQV6FA1LMH5t0+HbxYCORFGb51dkRl/QUS5nGdTkBOqvP6uqaeFN?=
 =?us-ascii?Q?yUxW/u0xB0IZ+6TXDk567Mdcvmnr0GkcYM5xpDOlo/AqRuECYz+0u6tFEcbc?=
 =?us-ascii?Q?9INALw0l9aJEgNB9EgKfkvf2iLj/7uOPSpTmnugZneKLxCnp5bJYz/bHJAP8?=
 =?us-ascii?Q?Gm5+o5PfxCm9LO8Mwfc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee07738-d1a7-4395-1f50-08dcf7d1243e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 04:21:20.8015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPlLtHiAzA95A+UXad3Ww3EL/L35udcHejvsKN03DClZHS+O3jtvjb4QGBEML6n6oLQ0ZicZGbBk9dWMxPSHEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.zhang@amd.com
> Sent: Thursday, October 24, 2024 3:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
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
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com> Suggested-by:Alex
> Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  6 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 14 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 12 ++++
>  7 files changed, 147 insertions(+)
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
> index 9da95b25e158..446e37768397 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c

Here may miss the reset_mask_int and reset_mask_fini for gfx_v10.


Best Regards
Tim

> @@ -4806,6 +4806,9 @@ static int gfx_v10_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>                       }
>               }
>       }
> +     /* TODO: Check the version that supports fully queue reset */
> +     adev->gfx.gfx_supported_reset |=3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>
>       ring_id =3D 0;
>       /* set up the compute queues - allocate horizontally across pipes *=
/ @@
> -4825,6 +4828,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>                       }
>               }
>       }
> +     /* TODO: Check the version that supports fully queue reset */
> +     adev->gfx.compute_supported_reset |=3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
>
>       r =3D amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
>       if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..3b23402dfb47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1560,6 +1560,11 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D
> &userq_mes_v11_0_funcs;
>               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D
> &userq_mes_v11_0_funcs;  #endif
> +             if ((adev->gfx.me_fw_version >=3D 2280) &&
> +                 (adev->gfx.mec_fw_version >=3D 2410)) {
> +                     adev->gfx.compute_supported_reset =3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +                     adev->gfx.gfx_supported_reset =3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +             }
>               break;
>       case IP_VERSION(11, 0, 1):
>       case IP_VERSION(11, 0, 4):
> @@ -1663,6 +1668,8 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>                       }
>               }
>       }
> +     adev->gfx.gfx_supported_reset |=3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>
>       ring_id =3D 0;
>       /* set up the compute queues - allocate horizontally across pipes *=
/ @@
> -1682,6 +1689,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>                       }
>               }
>       }
> +     adev->gfx.compute_supported_reset |=3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
>
>       if (!adev->enable_mes_kiq) {
>               r =3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0); @@
> -1721,6 +1730,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block
> *ip_block)
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
> @@ -1783,6 +1796,7 @@ static int gfx_v11_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       gfx_v11_0_free_microcode(adev);
>
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       kfree(adev->gfx.ip_dump_core);
>       kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..b9d5a79ba85c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1067,6 +1067,11 @@ static int gfx_v9_4_3_sw_init(struct
> amdgpu_ip_block *ip_block)
>                               dev_err(adev->dev, "Failed to initialize cl=
eaner shader\n");
>                       }
>               }
> +
> +             if (adev->gfx.mec_fw_version >=3D 155) {
> +                     adev->gfx.compute_supported_reset =3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +                     adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_PIPE;
> +             }
>               break;
>       default:
>               adev->gfx.enable_cleaner_shader =3D false; @@ -1157,6 +1162=
,9 @@
> static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>                       return r;
>       }
>
> +     adev->gfx.compute_supported_reset |=3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +
>       r =3D gfx_v9_4_3_gpu_early_init(adev);
>       if (r)
>               return r;
> @@ -1175,6 +1183,9 @@ static int gfx_v9_4_3_sw_init(struct
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
> @@ -1200,6 +1211,7 @@ static int gfx_v9_4_3_sw_fini(struct
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


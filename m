Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1116AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 05:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3FC10F02C;
	Tue, 29 Mar 2022 05:57:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6A810F027
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 05:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l625BgkKQXxZVQ9ndajKh8yPJMnV3gjjN7JHqrepQAEBfj8vDd11cvzf4V1gYX0/kjiStWIv8qNQO1lDfndQgJAM8MXJCBVn8jHyVpG20RjQENzKH0LpVZ3BTRhj0RDodDn0A8jmMISrYGPf/RevzkDqDmaa4olIN7/MBsxiohmpjeKM+REVuEnVRuuyeOM00rfqccQRdPhRVeKsKVUIyewEbNbATj7uQkIA2uN7MTRY2xOBPw/n8KLDJGe3S2buh6OXoI8piRBZ8lcMJxF/hPCyubRaBtFq8yCYx1Ea5F0JF5x1ikPBWRCPC6BVNnsHopkoRCw/MGbF2IhPUYGssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxvkyB03pAyi03n3Rl9Mo/q/idZ07jj5yCCWErs6ZMI=;
 b=ORp2TlAL7mIPg+9k5IU8n63nY36zAOv+8YWtBP6/NXyfB14FAyO/5Q2qYZM5fzOoaHUdmz6wJa7F8kWvXzZRvg4BbVCn24QFZMtYqAQ6aYW5O7n3MVO2al93o8fvE6r7yk2mFZ1UDuiKxuGB5RdNPV4fGVyZhv0N1OtZ0Xh8m+/dF5eUIACjQsTLkP4Q4SB7RIOC2a0Z4rLVfjxALhjtbEyFQx+4M/I5bmHN5GDwcoT7LGLJdliTjXWx2Cgl0gQ3vL4NuchDDwcHFojhtfoUwYy2v19RjoY/IzciydiInndwTrCqx39kMWSFCXDE8NX3nseDRnhcVS05Cu3wL/g86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxvkyB03pAyi03n3Rl9Mo/q/idZ07jj5yCCWErs6ZMI=;
 b=zRboMHrJSD64aKrYV06khBBQcRPq5Y1rQL66CAm3ZX5MVUhujUjDU36fQQco+dGWGqPAGWeI6LeMRGdoLO2b/rISPGJES42JzqKM7y/L/diYh/h+vACJwWfF9DK3OJ9EV3/VW41q3y1UZuOueGb+egDH/hzEcpEuj+iyMyGg144=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BN6PR12MB1523.namprd12.prod.outlook.com (2603:10b6:405:10::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 05:57:39 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::fd2e:7352:22d:7d0a]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::fd2e:7352:22d:7d0a%3]) with mapi id 15.20.5102.022; Tue, 29 Mar 2022
 05:57:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Index: AQHYQlaYDba59ggOtE+kNpvfctRQGKzV3R1w
Date: Tue, 29 Mar 2022 05:57:39 +0000
Message-ID: <BYAPR12MB3238026B05C5B4A976D24E60FB1E9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20220328034650.1983337-1-ruili.ji@amd.com>
In-Reply-To: <20220328034650.1983337-1-ruili.ji@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ec84c259-e96b-43c5-bec0-f7f99e3939c6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-29T05:56:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c56bf32f-9e78-439e-9e39-08da1149081b
x-ms-traffictypediagnostic: BN6PR12MB1523:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1523AD6A2A8B3E8B3312FF19FB1E9@BN6PR12MB1523.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkEMUhU9BD5sNEX5BpCwhVOZ1YUXX7K2vHggpO5XQIW9TaHJpIU8F2b08pypEQMsB+glPiUsvPCQnMR9czDHcxgjmDaMmVlNvfRRCIJEZVRmF8ypgfuw04GuexZ1qkILSkHCpKNJSW6VX9lslwiW7m52/XPElibHtmhJ5+CRmLwrv3AYEcAXzNxEw1ipjgd8Sx2A0vQHRUWqIgQNh5eKHZiWwp4oSnIt7zepn7/KBC6Oiw9jL+OGaXNgAIYziCRjAmZq13wuivDna7ROCWRB/OfKs8vVoC1PaL+AaD2CEEp0O/dXKr4cW5EVw+WI52EMKV6lfVwkojtTx96hf04koWod87viu1M6g3m6j6DzEggvebJmIeqYfPkqMWADxxbBaa3EOtspWWBAD6HDM3FlpbQyz+WxOaHAl8hjbD7/d7sM4lzAVyjIVAZtz+aRJ6jQVkCsPR/4QrmMN9rYVw7GtThcm3cqBxgmurQyC8PDhpjI/PzReHBggm5novoK5FTF1+Y9kerrHphrIvOXeqEvAZOqmexeM7UT6nb3H60qhWii+luV+B5I1DlIDeXCEYak/fhcvnu4sTlSJLN1F6gN42k+QyEb4VA3uToZIV3Hy88limnQpzEVtnUTvFumx194qv2QLkkn7UEm8sGHtpTfJ2n75BV9fT6fMW6ueJBO0nXVfb4Dl+aHiek4pG/5bl2mMMBwNXpuc0lydVb5wcYanQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(55016003)(86362001)(52536014)(38100700002)(122000001)(186003)(8936002)(5660300002)(83380400001)(9686003)(26005)(54906003)(316002)(110136005)(38070700005)(76116006)(66946007)(66556008)(66476007)(53546011)(6506007)(66446008)(7696005)(8676002)(4326008)(2906002)(64756008)(33656002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P56fzPmZCZlpx6uCcOaelujOjFO/UEl9Y1aaYcB16hygnbtP/cTQkzOuDyOl?=
 =?us-ascii?Q?VVEJflrbXlg1qHqEItC+jbbxN5jkl1JPyaS82FwwnfNtL9BfhFIPx87o6Qct?=
 =?us-ascii?Q?5+DCZYa1HCX+/2n82L9mZFo7KxeKDmbK+3qKIJNMIwBjxUUp8qFcy8wtPf+q?=
 =?us-ascii?Q?z3rei+jKDttEBhE7dG3whX699NEoXuf636iYGy3IGrR7pxQipoIh+y6AZR3c?=
 =?us-ascii?Q?e6FLH2Me0SUhNg7c52UKVBNgJ5Yfmp+nxejGXFmbaZjq8qQ7TKSyMgr5dDgB?=
 =?us-ascii?Q?RaRVQGg7++gP2mgDiACSIYV2Q80bqP8ho5OJc4IykdW5b3qO68UUIbXJg5Vd?=
 =?us-ascii?Q?oyKkzOfBqktwyEB4OqhKlYJrTqiik+amdK14zrdSCOE4ccOrtn2+TBHjPS1h?=
 =?us-ascii?Q?yy0MZ0pGpsXGMvr0xkZe0QKg4DF0FnStoGOoUPdwryadOCWuYmFfDRNvzpsr?=
 =?us-ascii?Q?wXgpuZZz8CthUh2eJgIxEsHuaKqNs5RkTQOgOkJXnFW0SV3P7XfeC5CL4AlV?=
 =?us-ascii?Q?0gAKnLj7sUy8pt78zDyGJboZGUDTFggN5dKxvuJEuZpWzqgBgTHispbKqUJo?=
 =?us-ascii?Q?5LvTii6E4Y2Z5OHupIYe8drL9PnrZCxhmeQ/Gix+vLqphEriRWVUWcfZknHc?=
 =?us-ascii?Q?i6GfcVsdz/h1ExKLQMwL+jWByfX++Sfi9JZ7glaae+fYbBhtd9BN5KWfO5iH?=
 =?us-ascii?Q?9/IqqntSowNUGx1P0eTSxEjEfjJObB+LE2wcZSG+Tn3DLPOS6LCWZ0XnG24/?=
 =?us-ascii?Q?6Trlu8EW5SVUR7NHI4ugG9YU7KgYJtdw4TV16qiZnd1fTK3sbaXsAU/LiK83?=
 =?us-ascii?Q?nDJw7vcKGS81H3QGZLPgitgeJ9s02dS+Zq8i+BgeVq16aQJwTBAjNGdVuZw3?=
 =?us-ascii?Q?GAbMBQIljZ/kFwDfbqd15ApG8iHJczyuXB7bcXoo9O+yw7eXvz1XGVLuEftX?=
 =?us-ascii?Q?dnsdyBW3ysr0WjIgZRucohCE9nem1Gt9PV57FMio95YLg6Qrp91b4EyoGTRz?=
 =?us-ascii?Q?ePtXIYb7RXWriUkg0P+aOKLwNxf44YOgJNt+tN6j04QcZzxOKxhwSUhdldj3?=
 =?us-ascii?Q?bGNVD7XNd2I8elzLAI/ZS5HZht8G84NtBIeoC7aIiQl674mv55JYLNe1pzG7?=
 =?us-ascii?Q?wzwV1rSJazyg1R9aHiSmUkByJRKafgL73glSLko3Vzht5bKMxmoSsIKPJO1q?=
 =?us-ascii?Q?a+7ArN2ImFADbXI17ZR2KwTxRMPLjZIaV8rqelRdPz4UDazMrngs15uUYIHd?=
 =?us-ascii?Q?rznKblnMefiwJmvbiTokGNN84B1cK2cnoNY5+Z4cdng1gH5Z8/k7E8DbQ+2A?=
 =?us-ascii?Q?AzMmYJdn/gD6O2DMyWkNgcltQjFmal/eur1yr9SLrKG+0jR6bfgZWHjfzHEh?=
 =?us-ascii?Q?RtkwAIiCrHFqWAFRdLEjMr+YoVYnf/3k4MHy0l4+51MqzxrqmHTcQb6DcF5R?=
 =?us-ascii?Q?9OQ+M4TrMSvnxLzu5Ozrt0oOWPAHF8Ug4E+e7VEsYofWnwPMVCkXSUKbNAuf?=
 =?us-ascii?Q?Yd0b9vOhICZrr/IVm483YiQwbprzC2pglav3kANWh4E4RTgc2YPLmUh81Zx+?=
 =?us-ascii?Q?dg6esCz+4rbgVBIiZWOeun/v9PPHfp2l3sMzK/Wg6thaUDxOsS49YNuwYqVm?=
 =?us-ascii?Q?DThrAgv04a6lmUKND8Jw2xOheK0PNMlUKwZUaM6LXowzykDkuxPvIy+20su6?=
 =?us-ascii?Q?5bIjszsH6YSAwhFbdEjhz+4dgG4YnbJ1JEiE0bPgh3z5ptkM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56bf32f-9e78-439e-9e39-08da1149081b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 05:57:39.0784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0KyF3vliobSh8QWYv+hhlepJf7HvJnxNAmqsdGd6Q0pnP/tzmRDhmza2mpFSq5G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1523
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thanks for the correcting fix and  I confirm on the gfx1037 exactly need up=
date the mmGCR_GENERAL_CNTL offset to 0x1580.

Meanwhile, please confirm whether this change also apply in the gfx1036, an=
yway this patch is

Acked-by: Prike Liang <Prike.Liang@amd.com>

> -----Original Message-----
> From: Ji, Ruili <Ruili.Ji@amd.com>
> Sent: Monday, March 28, 2022 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Ji, Ruili
> <Ruili.Ji@amd.com>
> Subject: [PATCH] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
>
> From: Ruili Ji <ruiliji2@amd.com>
>
> RMB shall use 0x1580 address for GCR_GENERAL_CNTL
>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Change-Id: I10a85891986f31411f85fa3db46970aaa8a5bd03
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 99df18ae7316..e4c9d92ac381 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3300,7 +3300,7 @@ static const struct soc15_reg_golden
> golden_settings_gc_10_3_3[] =3D
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000242),
> -     SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +     SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff,
> 0x000000e4),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210), @@ -3436,7 +3436,7 @@ static const struct
> soc15_reg_golden golden_settings_gc_10_3_6[] =3D
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000042),
> -     SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +     SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff,
> 0x00000044),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210), @@ -3461,7 +3461,7 @@ static const struct
> soc15_reg_golden golden_settings_gc_10_3_7[] =3D {
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000041),
> -     SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +     SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff,
> 0x000000e4),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210),
> --
> 2.25.1


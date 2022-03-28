Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0536C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 05:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAEE10EAD5;
	Mon, 28 Mar 2022 05:05:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D818310EAD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 05:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUVJMgQJdnt+7hlF8PExrCl0yiW3sxUEGpfazl3Fket3W3gaziUI6l98VleKa1ry4V8FUXegfnEOTZzqeEGuOhOFN+HxR2Z6hZAlkbDGRbPzqvPlDUCcBaUgzwhw7RBmria/9uSZrHMbEN3pYfDMzVNa6IlxSr7MS08+hRMFpCyQimw6YJZ8kUuurz+QQv9+uR+hDzGpUs7YkeNteQBpPI0JARZDjT1/pof0PyJjJl/Cy12jE1pzm7hqPVTpfp8/pec8oYZkmn2AlOGzD3SR98l6tEK2g2OH4wmkuf2uA6WgfS3986e71/mQXHWGqkAC7pJILAwO0H3yiUH77DKeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvVcSYxgUaKTnIQ6dLCU+u9tSLLjXPfP/zBDj0ioiLw=;
 b=fxYvm3dbtyc2g4f5CL+KcfnFUM+6GDzVX97oznmkA7TnQZXCKFPvF5+O6gTd7Pq9J2/CIjSxeWTs/13OfdtjsT/e112FsZpBQ2oE5kbsEOsUXSc2lqtHta+g/voYi22zOasWm7ntMqZq5pOVIZm9b9aNpw/ynLetrtbjBl5u9uuoL1klf2mIJ7qK4XzX6AcFeHnaXvh7WjBCHnZqx3tUM3/+A+QoioNOnwi8WGx6ZJNVUv1F3M0Fg7R7pT0giiZ/Oj6kmuvzCLSnsiiwicGPfU7uog9/ky+Yasvv7xSYBhRCysyRrmGXOznAlAx9cLEptYfgoJOtJ7Dx2TQaMnyPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvVcSYxgUaKTnIQ6dLCU+u9tSLLjXPfP/zBDj0ioiLw=;
 b=sYiJoFPXVgDiJVVn1KwYWzao9Hpa0/bq/TFSaed0BowwisvjbZjn1t9MX8hla/h4QZ6nPY5egBwdBqrCPGUn6K1TIEWkoXYtkdLR8pYKZnbM0vGG2uAj/Yqsvtk+TyEBhK8muqxdaSmmQVoIv79BhqzwPsDnXvGsxGL9u9nPeqI=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 05:05:24 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::d898:13c3:cc9f:d318]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::d898:13c3:cc9f:d318%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 05:05:24 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Topic: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Index: AQHYQmDG9nUmV0hc1UyYuVBjtdII36zUPZug
Date: Mon, 28 Mar 2022 05:05:23 +0000
Message-ID: <BL1PR12MB52379B1AF26538143F565BCDF01D9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220328045845.1986195-1-ruili.ji@amd.com>
In-Reply-To: <20220328045845.1986195-1-ruili.ji@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f093c53-2864-4fc1-d07e-08da10789109
x-ms-traffictypediagnostic: MW5PR12MB5683:EE_
x-microsoft-antispam-prvs: <MW5PR12MB56830C8B3FF8B008223793BDF01D9@MW5PR12MB5683.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vfq+IVqoYHwtHV8YNPir0q+ZeuMJs2ma3iwOUEzLaR0Yr3fYdXYSwr+RWWsAEewz1U8j9OZfFd2pG5/ddl+WxLWz+/AgXfa1fCB0WBUBh2lpoiEvOBx42jO/YKe0bnnGmJelaZxwuYYTP0om84vl+7fgdDwOEB7EO8wt8iXBNOv7md3wGVsVt1RNMXnCpGuuCtYXv8Rax5PvRXPQwuwPPACafIWYUJXV9A2whRWF5mcfTPTv4829H2xHwOjA3eHRYbOVuO0vgk91JgOWPyrHARwlacRmsQXLg0ncM+8d6B42JslM21F+bvto2S39eCuSPRdyFXeRNXsfKjbnNpunpW2xEwNZxqRMRH1gtM2uWuxn2TBF+zTCUKXyXlZgL/BbdOvWW0JQPkcXjLaP2413wLsvrJGh31kty9zdwTCANR6RJrGJq/wMn7Eib/OMivVFqJ3zk2ZvrXK3QiguRdP0Huz88vb0tjbzS+daTgnga/nlTYntO7yWzQ8eUC0K+xRmtbtnocwPY8AH/Oc8Tn9U340jTcot2cRnkICGxEfUGorYyRnarKj4oIbV7jLnO3pcxPIBqSERUSC+gWVh5JXSPEY3yrRHEXiY7Uq5WdyA+un1wXnpPz+Dey4gpmlpe2Xsc8jFNolC7QIcdw+ccYh9uKWHhm/fnU4DIHnjKvv50NQvtHnU5ykMe5/jZIkkW/6+wWV4Ig7NSIgy0B2BO1R29g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(7696005)(38070700005)(8936002)(83380400001)(33656002)(6506007)(508600001)(52536014)(2906002)(9686003)(71200400001)(186003)(66446008)(110136005)(54906003)(55016003)(316002)(64756008)(4326008)(53546011)(76116006)(86362001)(66946007)(5660300002)(8676002)(122000001)(38100700002)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sRTTgrwOy1qTMUXNZ3LqfycQkWkK3HmZTx/4hNco36KzcWrr33/D5VPTj7TR?=
 =?us-ascii?Q?pYCnY0jg2qYPPamUSfkCVq7JVyk/h1wgo0RQbiJ3nRhL2xDfu55h9QLOK4Ad?=
 =?us-ascii?Q?mdz3nvvs19weAkFJ7orxPkKApL2rytqgWz2IYSfda2ai9p/8Y3EJ4jEVOOxW?=
 =?us-ascii?Q?/ptU+J4oizGPw9rml77m4ksFs/LoxIleV5Tf+yOFZWG74Uw1MmV+YWmQIgFO?=
 =?us-ascii?Q?056B5ZMMXEdxqqqlJ96VjYM/5vqY2IY59emZggpvByZgDRPWPBsoBa4wut4O?=
 =?us-ascii?Q?VQq4yEkwNCoTgySidV5uMRx1WdZ46Z/UQ2VaghAwapTHl/4qUmWXSU0SvsSr?=
 =?us-ascii?Q?GyI2UIZSPboRtfqvdBO9ANhz53r8TRrSamAX47quheS6afdg+4QnRcpFWyOK?=
 =?us-ascii?Q?sjldGeb6BIC2kj2iJJ5TNBJnnWD7zwQ2j8f+avVAXwuOOvu/P7YFDhUWKQBT?=
 =?us-ascii?Q?H7fbqwVqAUfPMIvvy2f/dQ6qIeF8YhCwu5o4Vk7e9qwomzpsY8Vjn5WFsrWd?=
 =?us-ascii?Q?D7ecEfNtD/kLdS6uJ/doLKucoiVMwh9S7q7kjQ9uP3qoD/xexGk5LF98qaHD?=
 =?us-ascii?Q?V7V4AVwQyqhrdK/dt0GvIUBCXRQRIuBdGA49b60j9HhijP/uXLCD/ina2Mof?=
 =?us-ascii?Q?X/dAlwWBpvZqB+h3qaVDZhTWh8v2rA7mXYkjIRBNUwqabJlCWuvK75p1JlKE?=
 =?us-ascii?Q?gqj4OagSUscXzNUI5ELFBAdjRITCvEKLRicck9H/YDIcqhHsoL1PaH1hQoGS?=
 =?us-ascii?Q?ZQPZ3SFduiIWRK4eF/KypuHAhAlUCF/KNBfzXI3Ms+YQsjvV20+9r1/krIsQ?=
 =?us-ascii?Q?R0UhS9zFHkViUYMm1ly3WaWkZhAiudsONWlObp8wO5rZWk29xFvKJJPCnJZV?=
 =?us-ascii?Q?Be/RgTKIb4tLP1t8eTZbBZG2PpqmiSCbEwNh/tK/p5t6Xaymqhnlwi+lf91V?=
 =?us-ascii?Q?+5fqQPEBQzlgNFOdfQSdlzKlxdwn86i5HIbtGJ1gAtzHCYtoCqoGKaRtND2A?=
 =?us-ascii?Q?p3TUuN9xPm79VkP+Ajtko+iR0a2tKJuwSF9p3GT8Bm9rfZ3XQnx9o7m5/yxl?=
 =?us-ascii?Q?aXNTeDGhPTorsHMOtyHxYhj4E0mC82cV++G2w/Y3qh8ngiKi/i6Pe19FxU86?=
 =?us-ascii?Q?UeCe4LpBfq1n+cNNU7ObSRd9KOnB8tRfMDJx2m5mF+x1/SqGAfw1e9jyY7W2?=
 =?us-ascii?Q?mRIerUnWGjDOTxk1tKedobrP1DNsG/TdjEuy9xKu07zdNumP3r0Q5+HRpQTC?=
 =?us-ascii?Q?2ACL9qw99P9HmaKrD+dmq7ZC6ItX3At+UuYQHXleb87THEZsyqp1RKWh283A?=
 =?us-ascii?Q?RysxDwVSLapEEP8DTy4dtNHnYPysuOnZujAoJBv2AP/lKOmhiH/Q2Ros4dvw?=
 =?us-ascii?Q?dSW/ybUvvyDYzYivOedP6VcDFCEtY4l7WmssVtj0u9VlLx0FKXW/nykn6Gz8?=
 =?us-ascii?Q?BjflVE8jR3u7rC9ZgRboOGkWyxio/2MhM2u4pQcoKYYw1Hos/j4v9qemtAL6?=
 =?us-ascii?Q?fsxBzfafxlfnp0cazy3lTuTHzn/NSB1nJz6fq2InmEi0xzsMD78TlV6dEiio?=
 =?us-ascii?Q?QtIJgvufGmWiIOoToSstcM8K8ga+p8lc/KjthSRkX02hGj6UI8WXNDCW2uFH?=
 =?us-ascii?Q?Qt4wvVlxM7rKr9akE2FGJRPQDAKtrFxmzkv9mkplnlVyDo2wmq+IlfIWvj7s?=
 =?us-ascii?Q?R6rvzRx0a/XexI0aZRp3CMYy+9hQVIifq7d3uUw2Tf2HTNft?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f093c53-2864-4fc1-d07e-08da10789109
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 05:05:24.0088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGn6FfCLJTzVPefo/hi2a3DJuNEnr/U9aza/nNcDOgbEQljPWVRTqfZVAq32BpqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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
 Yifan" <Yifan1.Zhang@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Ji, Ruili" <Ruili.Ji@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ji, Ru=
ili
> Sent: Monday, March 28, 2022 12:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
> Subject: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
>=20
> From: Ruili Ji <ruiliji2@amd.com>
>=20
> gfx10.3.3/gfx10.3.6/gfx10.3.7 shall use 0x1580 address for
> GCR_GENERAL_CNTL
>=20
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 99df18ae7316..e4c9d92ac381 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3300,7 +3300,7 @@ static const struct soc15_reg_golden
> golden_settings_gc_10_3_3[] =3D
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000242),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff,
> 0x000000e4),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210), @@ -3436,7 +3436,7 @@ static const struct
> soc15_reg_golden golden_settings_gc_10_3_6[] =3D
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000042),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff,
> 0x00000044),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210), @@ -3461,7 +3461,7 @@ static const struct
> soc15_reg_golden golden_settings_gc_10_3_7[] =3D {
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG,
> 0x0c1807ff, 0x00000041),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL,
> 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff,
> +0x00000500),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff,
> 0x000000e4),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0,
> 0x77777777, 0x32103210),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1,
> 0x77777777, 0x32103210),
> --
> 2.25.1


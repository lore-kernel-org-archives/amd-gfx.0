Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E428CD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 17:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF0510E34A;
	Wed, 13 May 2026 17:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RPJvGJQQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AF710E34A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 17:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKJmxYZqoDbXMA67uG4hISPWLUJXLh/FE5zSyIPB1XD05RK1tkFv+CBiktyeJ4fLoiLvMTx8IClHNLrH2XvtM0WGStGeuADQUl1n2kX3IEoEy8UpYDIFhDkA6i7VWRyu/AWOsaQVKqlmCVgTVafV3W71FoFMBL92xY5wizLkOcWcZqXfJCZelAMoxOJryZHY3UANWXoJwOwC4qZsukPZESpV9w5z8/LMbI6zCG/7hsTyuUXdk6jS6XZQBF05/KwAQeT7wekc5ndN6SElGNwOzdnHNUM6klw7pW+WRQ751XoLPSodV6AHruk7hSOkrB1DTKuPIvr2essX616U6FKRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd7X/I1UEJyDI8DkUmV83+10isZIMFEaBV9WOlNYJxI=;
 b=ovO9CAWxDJ9W8W44iaz/Dk2pLCIf39K0RkN4OdihbpJ0HuMf2vH0UAhb0fo7HyvWihtAuxtEeuImKT2d7bJ0ZeJrlNwLd8vBdlU6jT7m+oJrA6dEYyHPI/FEe26qJGCMvZKYq9PqQWfUjD/sBjlSxXwbYqQxE50xwaExVaBjGTR8do4hbzSZtS88GNJBXCHeq+EYDZ60VNJG9eybdcE9U/QfPn1qpyVlTOyROyU2uyc8Vw+E2dEjzSw8rx92PvmTeDaz+uGmYPWfqJGBs5DWUTMYLgTKbv4pumCfhRX32fMLLWURi0Zd6xVvfIbUWDaPT1RDW1yxvk+20rQ2gkbTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd7X/I1UEJyDI8DkUmV83+10isZIMFEaBV9WOlNYJxI=;
 b=RPJvGJQQVpK+K/F9NrtogtoLyNG+Ee5gLs61dewWI4dU2ec1IMOqqktx+6UhlPezlNU4JgLKi9b73K0W83RteQEaYXzHr9aAXcv9JCYWlf4tJMnmGE1qQp5Hn7nrOGLTGLfKdFmejoOuAF5k4LqcbncdKztbQ87kEfa+rg2SlxY=
Received: from DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:16:00 +0000
Received: from DS0PR12MB8477.namprd12.prod.outlook.com
 ([fe80::db6d:61a5:b5b1:f175]) by DS0PR12MB8477.namprd12.prod.outlook.com
 ([fe80::db6d:61a5:b5b1:f175%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:15:59 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix division by zero with invalid uvd
 dimensions
Thread-Topic: [PATCH] drm/amdgpu: fix division by zero with invalid uvd
 dimensions
Thread-Index: AQHc4h+4RN/jUfFSpUKs24rrhR9ICbYMMfxg
Date: Wed, 13 May 2026 17:15:59 +0000
Message-ID: <DS0PR12MB8477940915F5CABC136FE0EEE5062@DS0PR12MB8477.namprd12.prod.outlook.com>
References: <20260512145735.450047-1-boyuan.zhang@amd.com>
In-Reply-To: <20260512145735.450047-1-boyuan.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-13T17:08:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8477:EE_|LV3PR12MB9259:EE_
x-ms-office365-filtering-correlation-id: e50d82c7-2904-4d93-e219-08deb1134d8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|1800799024|376014|38070700021|11063799003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: fyQnKd60KBsn7PqSJIzyZ8pLcUj2QRrcRF13DPsSHjGAI+bq2GPYZRk+bX5TCOKQWwvWBoSHbjYxW5l87cOyUfkrqK6j1jJTUjgXzgy3gyjc12U3kvPIVZKBOLX4XSMJVnJzlcPootO/ZnjCtSkrsHeloCZ3FfqRQd1v/vn3LzdefmlVFpNaPOJf1ZN6AjH+UNc4R9kF1AgLPWrQX1/nQaVbI63Z4mMc8xrPJPnEWzuHWhhbyvjviMNgnWrPFbFpt4FpP5KOozf0ICuMNguHj+r364NhLjZdN/9YlataSzS7b9CwsMaUiTjE9LNqBN7n9ZYTJmoKrwVDgd9E6aMyL77nRLdD4nuG9OwWSJ1qP61D0iVb/gd9oQormXf9FToz8kKZeskrxvXnfblq+dU7D/V3jzqwU43vxHuVnUpV9m1oMAIlJNf129MtrAH+QiCiUIV2eI8eoM5YR/VBD8UpSy8j7oL6HqtEZIICrhTTJyjGx6chfm9Fvcgn+3IGBYEyu5tGbTAyFTdsHvuPekvuSGVXBjvTGSaSxjcTsoRSDUZW5XGqn4b7BofQtmdp6Xbh7jqPURLAUVVUoal4wFro7Zo2XqWU8JHLH71SJZEvrP5mQtW0Hz+RTBxXeFkkzYe5r7P7alPmG8DfVTHOTi+im8B0IeX5vDjgy2e3/++ZXzVHNldTFO2J/bKlJL1rGW4RDBS2+mVXW334OjmLIEKK9q1Lz/4oTwtO8UaRgiBYpkP+oLW1M3wTKrEupRId0hp7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8477.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(1800799024)(376014)(38070700021)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s0HatPl0p1N+OBW5w0ZWJ0+aGrIrus0xaKCcpIeqzNqkIPmoz/BUoM1P7yUN?=
 =?us-ascii?Q?ocl/4H1SJXNVXREABTcXh53h5Wxxq7unrwlwKmup3kSCeKVpgEWIA82FkqiM?=
 =?us-ascii?Q?Sg192YZNGklwl8v+RjvNVJbaUIWnDhtwkdv4PnFHsG9tN49EsjFBd5wHOFGb?=
 =?us-ascii?Q?4wl4qYke8Dx4moAKSjc7uGQ5A1Upy0gKhIO2u9AhpOxMYbsy5/0niXTb91nz?=
 =?us-ascii?Q?7hSBlAkBtso49pn8yKsquV0fHJ6JLy+M0bORrP6+DFUkUltirc/que2/qrSs?=
 =?us-ascii?Q?8dVY/2m7BOGbhHEhVAb5dt0ZjFpcVlkM1mRUV9rQl6zHRlksz//DTjYpdvF2?=
 =?us-ascii?Q?hQmiRurC6p0SkHrFUOHsKynT5qtu0EvVY43DHUV5Pwus0agh5tBMPAgiKqPa?=
 =?us-ascii?Q?zRtIWeko7SjYo+H8qlwUnQUY8mp55Ufb+JwO4dwcBFGjJwpXElQ9VjYJJSvs?=
 =?us-ascii?Q?pv9kC/WELjL0ddoLru0yk7kVtuJ0VoWp4M8FhY5RCYhTLK7AX+gqVnOIa2k6?=
 =?us-ascii?Q?78Eq4ykdlCRR4SckuwmZouw9HDNVC2YRsmNsbOgn9RkjIW3BcRJPi/zCbBRn?=
 =?us-ascii?Q?1wCWw5Jg8rNqHXEU9A+qUBT8WiaSjGrHCjI3lAETSszdbC+dG53ScFBasnc0?=
 =?us-ascii?Q?cRsuTy8lrO2SJCGpEqqh1MXLO7Ak1bGljKCngJDNfyRTFn/RzL/ClYKXKCyW?=
 =?us-ascii?Q?gx4/NPm5/i7iXZXBSKff4OLPCtz2R5/WcMUGBS37HyVXosH6lppqJWX2npY8?=
 =?us-ascii?Q?X5HFzlcwSSoC7Wc4MlgoMevvCVss0nRnYbyO+h3+56A06DLf7swLCb1xwqSD?=
 =?us-ascii?Q?9VIuw3ONKt9yJ7DGzRvaS0oOH5K37csIBhCMhkxNkxkFSwcpRa2gRjdjJxjS?=
 =?us-ascii?Q?RI4gFkOzJHw+nd+y5ahKxMJOnPfdcG8E1h6weFAaNObKCrtKDWbMhKgNOmms?=
 =?us-ascii?Q?nFezeUTeic9Tp/Dl/jP2DMGnsmyf+TOcH2AabBI3n6+198s+BiUrFRLfKOqN?=
 =?us-ascii?Q?c8nhB1b6kmJ2ABxAw/70vh2jWpjq1fWFS+5kqmsAM95/zYeDkUqxjJDbNbAn?=
 =?us-ascii?Q?XBkdtX6LJ3rcQnWlA8QZmanVVSvO4iTDNRwjFv1E4ad8LheuhBKiC2UH9N30?=
 =?us-ascii?Q?o2WO/4TrjYULmyHmV39F06mqVvJwnOoTIKzeeN+II68yYlYArkFvpx4ZyqZk?=
 =?us-ascii?Q?vPBV+vp186Yh5sHflbKNEUwmA+ciXoMopPZRTsWo+NAA3z1qw8hEK2CazEFE?=
 =?us-ascii?Q?Lse3q/KrTIVkeypZL7JTTQBB0EYFQh+X7Ew2lyPInCG4/K67tMdhuU4NPxMq?=
 =?us-ascii?Q?6AwVEgLyzAx0PfJYxS9D4aicGc9N1tp5RSQnHg94eE+q66nsbvcXHeDqCBai?=
 =?us-ascii?Q?4F/jVhSnw95QbgVbWXVHFi9V/EhdTsXRY4zmA/UGnPHJXbStzcdc/RcPY68R?=
 =?us-ascii?Q?Qx5rJUEmDu/31jZorxoYMe0KhPZAZdEiNIqnzvUX0TtKzbfOGG3pqknXF1Tq?=
 =?us-ascii?Q?RnRAX3IAET8OrLuYtXRX4y2DRK/ijdb4cpABngyqmWpo6eyxftisDYHfpfLi?=
 =?us-ascii?Q?jCn+h8EpmdcE/foc/X22YmqkdJXbJdfFrKuZ40nUBlixKxdZ4rqeJ6dNJQbL?=
 =?us-ascii?Q?l6mFwPSB2ymaF8z6GvqKE1QagsrYAe+kvS5NNsM3jbxwVnohrH+3BYKYOVnK?=
 =?us-ascii?Q?EcwrO+3RBl6ku9D3H7qNY4f449Ad1ghmMGqt6yW+uE7sKhkq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8477.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d82c7-2904-4d93-e219-08deb1134d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 17:15:59.6390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67LyJ97nXGo6GtmC+/K/WzhDf9/ONfTAc3kDp2lmS0LhFqa3NbMOTLvOtY89sd0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
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

AMD General

> -----Original Message-----
> From: Zhang, Boyuan <Boyuan.Zhang@amd.com>
> Sent: May 12, 2026 10:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Leo <Leo.Liu@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Boyuan
> <Boyuan.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix division by zero with invalid uvd
> dimensions
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> When width or height is less than 16, width_in_mb or height_in_mb
> becomes 0, leading to fs_in_mb being 0. This causes a division by
> zero when calculating num_dpb_buffer in H264 and H264 Perf decode
> paths.
>
> Add validation to reject frames with width < 16 or height < 16
> before performing any calculations that depend on these values.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 3a3bc0d370fa..0cf0f53e5066 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -628,13 +628,20 @@ static int amdgpu_uvd_cs_msg_decode(struct
> amdgpu_device *adev, uint32_t *msg,
>       unsigned int pitch =3D msg[28];
>       unsigned int level =3D msg[57];
>
> +     unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
> +     unsigned int min_ctx_size =3D ~0;
> +
> +     /* Reject invalid dimensions to prevent division by zero */
> +     if (width < 16 || height < 16) {
> +             DRM_ERROR("Invalid UVD decoding dimensions
> (%dx%d)!\n",
> +                       width, height);
> +             return -EINVAL;
> +     }
> +

May be we can move up the variable definition below with the rest definitio=
n there. With that:
Reviewed-by: Leo Liu <leo.liu@amd.com>


>       unsigned int width_in_mb =3D width / 16;
>       unsigned int height_in_mb =3D ALIGN(height / 16, 2);
>       unsigned int fs_in_mb =3D width_in_mb * height_in_mb;
>
> -     unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
> -     unsigned int min_ctx_size =3D ~0;
> -
>       image_size =3D width * height;
>       image_size +=3D image_size / 2;
>       image_size =3D ALIGN(image_size, 1024);
> --
> 2.43.0


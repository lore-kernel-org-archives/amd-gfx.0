Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5EEC021B6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 02:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7EA10E543;
	Tue, 25 Feb 2025 02:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MA+O2iws";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C85E10E55A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 02:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRhjbeqa8CxqgTOt8Uugkc39MUSLAskoP3mfvBUJRd2XKAiF5svuVKF5W+RfpEQcMQR9+s2B+JfHpWiibQnwxz8VEGMnpqCkA3V99kMDRq9uyx8jEQz3Qd0Y3K3zy6lnj9DyVOoBuYvF1bXCKh9FFImfSwz48oIbUbEkoxizyh7qrLGha82WHdU6BdgKaFEzV3+c7MVjHmnRk1y7d2P8J6e6VsIETtesMtjpkUqlQJ627NZcA7a4Tjk01ExmuLXQNZiqvJkQ6wyLkAZYDsIDeVnEnpdZutUPotuWTFx9YzHYt0lmPVOwUYrX+ji6ufUvJD+gvjwML61VtGDVkG2naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkN110VAqQ1NVie7h6Zps+BpzBMqtIpq+aAnTEbXJIU=;
 b=PMXqZts3CwoLKwAYzg5AphR6Xz0ebUopYlecjMkMqtOjbUt0ggiKOpscEDm3n3ov4tsQM4ytBKFk6egvbJF8wuGHPjKD2JMSOHN7gAlZwFLlPkrUcaZNHvVByK4c3GCPXW6jnNdkcjbQZ98d+GVQJtBbl9y0oBUOYAZAWwb+OQMItrsiVzo6f3JfHLxdZupvAot6+4GAntkwe7IkEebF6fyaNdZ8lp4ipPpC6wuDuixkY0GWmKEDrFAkIHalKATt9lWVHtmACrgfo77HF76pB0VbICUBmTYXbMZQZmxtD4DFyIWAhIqOwO1EGwGVVFkN7FGDaBOA9jyAudf3Y/gRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkN110VAqQ1NVie7h6Zps+BpzBMqtIpq+aAnTEbXJIU=;
 b=MA+O2iwsZvGELDKj0gpaC9ID+JXH9HCs0ppLDRl/yRdyXYB2rkePnJHWriXytbfd/DlBzSwVbvAvCruVdrXqIMZ5HMIxPjSKTJZAdpXKrlMFj/vY2uyM3DMdbcRVWHm9yaAClZyXsMtx9N0u0qSiYAG0zvEFNIWlUEj7PIcZLsE=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 02:20:32 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 02:20:32 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Dong, Andy" <Andy.Dong@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Set CPER enabled flag after ring initiailized
Thread-Topic: [PATCH] drm/amdgpu: Set CPER enabled flag after ring initiailized
Thread-Index: AQHbhs0b2hmxlYgmFUOcM6GPjuLtQLNXSdcA
Date: Tue, 25 Feb 2025 02:20:32 +0000
Message-ID: <PH7PR12MB87966D8DB162C2602E51F085B0C32@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250224150159.28149-1-xiang.liu@amd.com>
In-Reply-To: <20250224150159.28149-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=14ab5d25-fd63-48c7-a1de-20110ab7d134;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T02:19:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY5PR12MB6551:EE_
x-ms-office365-filtering-correlation-id: 46d2997a-3df4-417e-26b8-08dd5542fb1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6IosV2EmN8wLoa9/jt1RaP86C2hOWi9wfyLd4lHrKVMWwhSdEjI6+MLxIwIW?=
 =?us-ascii?Q?u1kLgnMj/CvXI0CqzbZRCuqJ5hXFhwRLwgZl1zMFD39YLKZEqegqOgWvFjq8?=
 =?us-ascii?Q?ItVoSpOVOJIZABZkq3E0NuK+0UxK/s0ALfI5bMlZHJL8+adL1wJ1a+GCJtNv?=
 =?us-ascii?Q?Ue/SkbuRqkoSwmRxwTJdh3IjhGJoycN78E0PQoMYnDIS7c46eHVkx0LOX6Le?=
 =?us-ascii?Q?i3yBZkirFwfW+YMobRxRAvF/KQ3V/wMlp8PN4NdOtrut1MtQhqv0DDJp/fd7?=
 =?us-ascii?Q?8M4ZJSOZRezdGB+Vd53/qfeLBLbCxKJRPQ1IEhsGjF966q7HieA5vH4P3RDG?=
 =?us-ascii?Q?eXq5ou/igGjPc6T1Tf4w15O0F/OXV8JLT3Pj9bnDiaA4awZ0NCOoQOhV2OMm?=
 =?us-ascii?Q?lUiC+LMT2CjKQ1Tnxp/PTD1/1Dcy3JXElEEWgZLAp1RJ6Le1uY7w2ynQBzM2?=
 =?us-ascii?Q?irgswvoY5y+kcscyphD/ZUIsn2d/PTHhJmsh4ua28YoGLQlbTD4wgRAhaCPx?=
 =?us-ascii?Q?XQoYbbK+Am2IOUGV8uMfq1S5m7XS2M1lPl5YxzuyzzryKOs+8lHJ9OfQGr3s?=
 =?us-ascii?Q?Ei9Ihr17jQuMLdaIuIET65YbGJ2sFKAgy3rtt9o+PHfWIYqpI9nxH+X6sRwz?=
 =?us-ascii?Q?IVi9earzZTwwiyO7asIPKGkMKfvggVot+rqE8ZCfG8vEHdT3K5QPmCYVeo1N?=
 =?us-ascii?Q?f1qQFdUMc5xTPOqmFYWDkMBQj2ZXmw0B/NHOhnNyzWkfgd5QBzJq/BRTmVQN?=
 =?us-ascii?Q?0KCZSKXt2QHMHzZiy+prCaHNEzt3kf5QAELMSDKz0xpuVnz9ah+Um1LuAQSQ?=
 =?us-ascii?Q?oBvapI10gtgyw5yGsk9vKFssxiPJcdMYg7C6xkMRz7KTzruKu+l+kXphFxak?=
 =?us-ascii?Q?mPzWsY9qTl+kE4W5T1MO7XFb6c9Ebb1xYokWx+wQzqdh0rlVKl+oBauZ3Oq3?=
 =?us-ascii?Q?/Xkd/liYsOAkNh3fNK45XPwWAVMFa3gZuJDknSdmg0li9TSgfYYIeesu8bVn?=
 =?us-ascii?Q?lq0Z2jyw9rZBc1cnIApeW7Hro+/NkrFfyiYgFdfZyDQWElCyUZ1rab3lpNNU?=
 =?us-ascii?Q?jJANX3d32brwERGeqop/QFXJPufADkDs8dtxXJ2HDHTotRWPcEKOLwCyb/WJ?=
 =?us-ascii?Q?Dve3e0mWt/QhRyHQap33eh/F5P7UNRMEtVEwX91vVrWUfYahBjoGia0jqYa+?=
 =?us-ascii?Q?CPzDbbjuPXOSTjiKgcDLE/16xF2xZaK3sO/2BIFExZeecLjxyw1rBpqQxSQB?=
 =?us-ascii?Q?Dlc8j7PG3cguR+eB5ChgWstSETFqHMh35geJHk01SeS4bt3BSKifT5jCA3Xp?=
 =?us-ascii?Q?/VBdAhJcB4/RULmx2pp1pIao2LGWBSBO73wJkFeWvYsHXu6iRRVTa2Txt6NK?=
 =?us-ascii?Q?wNLh8SDOCruJvyV9mUDcO1fv82/JV8boU/FLyTPrIGReVlR1HcoYmVa0FeCB?=
 =?us-ascii?Q?J3n4ydbL0DK7Fet7+ipEq8eAWZXQe05a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J5LMaQrmPC8UG9S8z4Wef/stsumIOYtKYtGpWnXZNl2stJvxZGq0m5DCqNWX?=
 =?us-ascii?Q?HMvMnDGXoYvmi11OPh10p4IQjOcU4O3I0loAySsGt8IW+VdJQXFDCWLeTSYg?=
 =?us-ascii?Q?RJiHchMVP5YBpa4Uq1msmRReyj+X0zhMXKFxSZnLElT7GZMz54Qp0t6bYL3J?=
 =?us-ascii?Q?JSP66OQfnx1ac1zNoEp2ESBojpeqEwCHbpAI8r/RKYz7X824tbKddnQun4EZ?=
 =?us-ascii?Q?aB3v8re/zAr3nifEVKuvQtqYbw6RWpuXIYXSnSARCqpssVOGwZWZdNfjUFoo?=
 =?us-ascii?Q?WCwEWJc7WSb6rVZRvXDs6KViNpVKPL4ATz8oRW5ZYsi4J4N7T1AbtmhiTr7W?=
 =?us-ascii?Q?5MqTJJGR07/lnxgzFYTVw2NXFCg0D30SE0ko07uGqQr2bo+7ntsXHpAlKGsw?=
 =?us-ascii?Q?va6KsAuTfxr/d2u250lVnWUgb4K3NS+6Wni4wrXFBANnSOBrhu5nWInrH2Hr?=
 =?us-ascii?Q?U+nuFItB47UVdn7SjHOTb1Z0Mk47sPerq88XHz9Vl/WCw3OJgDKXAFNqvNAO?=
 =?us-ascii?Q?UPup+ZlPySL36q7Ur2j4HydHUQ/PQJaISXGpIeF48TzNBSIfJMAAsMZXxOxY?=
 =?us-ascii?Q?Ecnd7jJcDlqKIqZen/2ih6QJ2YoxVSXO/TGR1/SLiDDWRMJ37JDK0ph6tt9o?=
 =?us-ascii?Q?ISMR7Nx/qICUiZrT0NFKauZ85X3hBFVl5e2gujjwy5FSsLBh1GAgrW87mhYa?=
 =?us-ascii?Q?jX9Y5UnOMxMOJmfsY+Wg4hnrNd2We6gCdcJjSNqKZkrq6XSkzbavI844rzSZ?=
 =?us-ascii?Q?Ee1S+kz16UseZ79mPmOXPNWkeW6uI0tR21rRhg49g9Xy3zld3oaQFpU+qCl7?=
 =?us-ascii?Q?VuPCKoL0OMgDrqRGosAGNpzXMCuRab1WAUOoA7dGLcnbJwsT2IPmtU3wP2/k?=
 =?us-ascii?Q?9eMN+rb8VmtEB3UzPYfb8UEllOGoKTweOBdo8T8ENPgpO7672A5rd191wXFH?=
 =?us-ascii?Q?2GGB+aOUsINucBNHwUkzCx5QI/D63knZAdeosVrLlj94gQUwffIxCTWz1KvC?=
 =?us-ascii?Q?Pxoa7xMX2WtYE84C5JCZeNd0DDNWUmGIS5j2WPgKEWrWjMhPxNA9doO6lp2B?=
 =?us-ascii?Q?eAbUuRjqfSfWigGyLSKLQ4JESUdgpV1F3zE4tXXFXPKaRpfVpjPdKHaoA7/G?=
 =?us-ascii?Q?2pV9KtTd9nOLkkXUu4NQTPAtmGGcODi9QA3Dj1CBa63i1IZgfAE9iyRkHN2D?=
 =?us-ascii?Q?k35p9KlvsHcGJldgqFs71uMtAWGA3PYo31eH4uUyydrqsN8iS1Lhn95QUW6w?=
 =?us-ascii?Q?sehyovuK63pnR7dvOZBrVt1ykxnTKCTZ6TuSDXjQ6sdUfJ8pwIB4plKZycga?=
 =?us-ascii?Q?IXgUNNDwEwBM3RrT9bycRQdrRDBpez/jKPmoPKNZ4n5h1az+i8cNh2yA5lmX?=
 =?us-ascii?Q?Wu+ojPRFyWjGS99MoeytBMnH4caDt0RuOFW4S8ZuR9ZjSCKtHfjkdJ8qAP1o?=
 =?us-ascii?Q?poNAAC3UeuwqGVY5Iq597m5b1sFLmJ+CppCubuKfwm3TLOyGhdWrqZP1h8dZ?=
 =?us-ascii?Q?1w+RVoyUrNvrUh7+6lJ+kzQpf5AfI2wZH9p8z7KDKET2jFFBQ+1U8Z1iIDxo?=
 =?us-ascii?Q?dXAU+sd2yiO3Ure3Lhg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d2997a-3df4-417e-26b8-08dd5542fb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 02:20:32.5514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2DXE5/Q1DdbVeGmcdWQ93jc7FjjD7KtezFgXxhyshMISx7x4PWiJLmoqIBKnM98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Monday, February 24, 2025 11:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Dong, Andy <Andy.Dong@amd.com>; Liu, Xiang(Dean)
> <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Set CPER enabled flag after ring initiailize=
d
>
> Setting cper.enabled to be true only after cper ring is successfully crea=
ted.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index d57e6ba66c44..a39e7efe50b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -535,15 +535,23 @@ static int amdgpu_cper_ring_init(struct amdgpu_devi=
ce
> *adev)
>
>  int amdgpu_cper_init(struct amdgpu_device *adev)  {
> +     int r;
> +
>       if (!amdgpu_aca_is_enabled(adev))
>               return 0;
>
> +     r =3D amdgpu_cper_ring_init(adev);
> +     if (r) {
> +             dev_err(adev->dev, "fail to initiailize cper ring, r =3D %d=
\n", r);
> +             return r;
> +     }
> +
>       mutex_init(&adev->cper.cper_lock);
>
>       adev->cper.enabled =3D true;
>       adev->cper.max_count =3D CPER_MAX_ALLOWED_COUNT;
>
> -     return amdgpu_cper_ring_init(adev);
> +     return 0;
>  }
>
>  int amdgpu_cper_fini(struct amdgpu_device *adev)
> --
> 2.34.1


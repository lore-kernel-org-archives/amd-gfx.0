Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985F4C5320E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 03:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F72910E09E;
	Mon, 26 Aug 2024 03:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cV1OMAIS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2BD10E09E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 03:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPKX2JoBvykZrPCbi76bQsSRcx5DGnyj6WBM8IEeTTuvXPDfr0VB3ggGe17u4wJLg8kiqhuCyiqwKWPvxa7u9JZX1rACbcTyYE21AkvXS/YSLy1RNO0BNme3ZqKBK/etp7dzdKSDtenWuOnjaoJCEvYxI7FzXKMsDjj+bm7C86fsh3alHnhgCj8RAJwN92c8FeUhav66YdRRA2GytZt13CiUSEvf85SvaV43TCvdTrLVHea8Rg1ikLXAY5o/zfeCL7xODCLynbGx9wl3lI0oGpobkqCzOFjrFbzBjgUvkJpwh9sukYZqGFza1yk8c+VWO/6Hv3zuqkKs+gL0gx4SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzA3Powife48j5ayO4vz7q35hm1QgTUg8GvioqkALVo=;
 b=USWUhvCYxPquJX/M3u8ogsbYTSoSOyb8EFiNtm2iBAQOu15XLAHaM16aUb1yJC8M6/hVVHsNG182NufGLkwXSfjK9DG9Dc36vDaZbMDJcRifZMKNneTaofTJQ2RPy2KeddCwPOuPfFKKwMJdKsWrbecwKJd5nJdZZUK3ROMCf6gxrZ81uVINRSN2DY5kq8uTXa+Cxfu5IDCyhvp8e3aydk0S+VQ59FDfHvhQasPfr9Hezxtv49T/PjGjUoTY9nlH2KZ13nrfhQL00RoeRvBxV5bJxShjoQVVLLaKTYM/qyybBa6PQr70Tt15xHI3Tnwi1NFANvlgeyLvrjObkYhp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzA3Powife48j5ayO4vz7q35hm1QgTUg8GvioqkALVo=;
 b=cV1OMAISqY3wzAh5GgCY6bx1U3S3D44xHyam801fSjwsMgHnc7XfY7XjFUptKnqsHLQFfot6I3wtzqUamf3o43o75dMyzxx7xDYOHslFX5TceaLwEAp9kpqXeyjaWyRieEzg5SrPK+/Da9mKlhvqLJHljurf5GEKc00/nQRnq3M=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 03:31:44 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 03:31:43 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/gfx9: put queue resets behind a debug
 option
Thread-Topic: [PATCH 2/2] drm/amdgpu/gfx9: put queue resets behind a debug
 option
Thread-Index: AQHa8z8jxDhLa2UU4ECn5In3a0eLN7I46igg
Date: Mon, 26 Aug 2024 03:31:43 +0000
Message-ID: <DS7PR12MB6333EEDCAF23B541B272097AF48B2@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20240820202518.2110483-1-alexander.deucher@amd.com>
 <20240820202518.2110483-2-alexander.deucher@amd.com>
In-Reply-To: <20240820202518.2110483-2-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=04472304-a6de-417a-80c0-eb2001f16ac1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-26T03:30:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|PH8PR12MB6892:EE_
x-ms-office365-filtering-correlation-id: cd9fffa6-f6d7-4ef7-1370-08dcc57f9b34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ReiMk3+G2ALtDgno+jZZOBe5/Y2WXI+hUsPIMjaqfuVhxTxX9ai528b2qhqs?=
 =?us-ascii?Q?81rRSWLgmIeoQll55AEZ13ThINx2TKaM3PRBoJgkCJV6xDhsTcFYyzqjRhmw?=
 =?us-ascii?Q?h4CF2FVapjtwjnS69g5n4ZTrnd5Th6ZFI5cHQmlJn7C+qcgFT29gDdVQNXOK?=
 =?us-ascii?Q?QZdWrsBMPm/ERTOL95OuVXH4NhxFzHvWAOFeu0uxF3eeA81HbdpQcDk+tiFT?=
 =?us-ascii?Q?g9IaypY8YVmAhFAGua+iGU8XBprvKr/KNUycvRks2tQHeRYBYqyLBsV1izTW?=
 =?us-ascii?Q?gZk4VBK0ry4RLJ3S/OJm40sX97PtdZsuU5JdY4M7baZPesBxVSyQinLPkBYO?=
 =?us-ascii?Q?gFaAiPM5SaFIMUhS85kFiSa6X2t0ImvJA5wMTEVS7sVyk3c/cuxienrxT4VB?=
 =?us-ascii?Q?EAMvoVDI7ypi0nF7oYE7Qgr9Y+HO3EBNoSWd6PxbwROFZehPv3jQNB6Oj4NG?=
 =?us-ascii?Q?Zwoye6k2M3X7lLktsN4LfxC8vBGAXAc8IWpACi8I4ONCWCNZMy504jMksxcz?=
 =?us-ascii?Q?WpPqPOM3zbtah5ZZLLy1ab6lZN4FwYjBHxuwWG+ad8Nto2NFV5UJ2Qx+aZUP?=
 =?us-ascii?Q?a9dpZiTta5+5XYHA6nXaB6vI/5Fro+7oFzypASkNg10ONZT+Vg5NCOtPEw6N?=
 =?us-ascii?Q?3NrBM3I4xpLM3AjXGXJ1OjeH/nF2UdX1mhoPiaRnc1Bcl1tD8RbZSNTaozn/?=
 =?us-ascii?Q?QS++bNXbuBIHixug2J7wvPCmbpW27FeWYVIi9uks8lC2Sl2gi3Vz3z3qEXG2?=
 =?us-ascii?Q?SNMuN9HQJJU26WNQeQu0M89xoAsIP2LMP9zdTqZhvrGDQ0NRW5zrlMgrdnrI?=
 =?us-ascii?Q?VzTFI8e3di4Wuh3LPWBgEKzJdLooIjb81HJy9/1MD33L8HtmJr7msX/ZiCBt?=
 =?us-ascii?Q?MfoZ4hHWAFY5wmE6arhcCEdlQXq7gGof1lvDcq8goM5vJNHukogKwaGHkCSM?=
 =?us-ascii?Q?32CZ9LJK0qtQcTe/Tk8+WwZlbVAIpAN18/uzvUN7FE6J10tskORmXD15fKvF?=
 =?us-ascii?Q?vY9j0zuDZo7Q2D0uXOO5v4aQ+D7FFSwDS4WJN3ewvgGTXirhWcDdiOTfCEjp?=
 =?us-ascii?Q?bKjhAyj5j38eZnqUAFEdnM410qaJzo4wUu31P7j/R/8QXyt7BdJBBmoy3Tfj?=
 =?us-ascii?Q?lehYLXO0pFnFKNBW10Fyr8oyc6zAYua+C/oPxm6zpX3/zczZrLwhGDWFb78I?=
 =?us-ascii?Q?R0JynK0IipF4ZRRYo0X6h1UNi2pFa9yZ50GyJrlFHn2oPXgU9ZLSy8arVpFR?=
 =?us-ascii?Q?h8/mIrsq9OUy+2gGiZOGCgfcthi86DvYA716LNsZohEUw5HN0kUHa89jxW8Z?=
 =?us-ascii?Q?TdWI2ryUb3rSp4ENBXGPPLtnysw+2d1mot4BFfH9ZrtreN5scQOca4TR6lrZ?=
 =?us-ascii?Q?nkyJ2Wbz2KjRUm1L4Cac6fwZAGKoh43tWnHxTjoBJI9fjCJq6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mITuhrRG0Ts/lbJEbbcy4DitYukEJQH0E/dxf2+coZzhRya3ak6JcRZdOukR?=
 =?us-ascii?Q?J1S8RIVy1HkjHob6PopZuo7poBrwqRM+x3tDCwjKm8HNrEFA4nuOQ0e1S+jt?=
 =?us-ascii?Q?lGmxOXLdFx7KhuFlvFxDVVJNSy15xDM69ECIlwpHSCZEXo+MVuf+TueR4tDN?=
 =?us-ascii?Q?6/XvV7oPqrNhMlB48Bm45hgIqc+FVVW2DYbWTSBZ2xIbVEqqArsluwmTIflU?=
 =?us-ascii?Q?kMNZojHyBg4/jGBNfhFZUCMyJUrlaqP1z6VHNn8XiXk+64fd6APCvucsDkTD?=
 =?us-ascii?Q?kL7Rh0/aDe/h7qEtDx4C55DBUNv1yD1n9skN90JaZRsbsEIiO6cf8Dx3v9Ja?=
 =?us-ascii?Q?FJAiq1dENebLF+DrkICvPPNIWPUhcQjDuTTc+zp6u4s0Xc0PBJNtRQUwXgr0?=
 =?us-ascii?Q?30veiANu0xiK8TanbAaYfvhVdi7oV2876XZ8tSKVOSbzZOTRyRWAfurv3+vn?=
 =?us-ascii?Q?W0DGjDzPTz4oFXzPEu/H8RXvSecc8Rq7aAcJzp/SJnhRCAqcxJ6N/B5D21UX?=
 =?us-ascii?Q?n+e+Ftci8oog4jqWvYrSb6OE/eZZy/u3vB7IE0XWyUrF0NHbof521TvDLIjp?=
 =?us-ascii?Q?tBbFQdW3TwLg1tz+0nY+kps2iy4mI+BiLPyyxLqHDlOvPZ2BEdp11RSmYhcO?=
 =?us-ascii?Q?nVM7Cd+CCZn3RPfqYhV1EiotDMi/ONdB9NvXNa+aSyEhVI2P1iRoKU8XnnSu?=
 =?us-ascii?Q?gTDSy+D1VBZrZNawRBkejRB9q21HzXGVehZ2bjOlKY9gREv7qKLeDUrq23pM?=
 =?us-ascii?Q?aKspS0ObkYg4eazYS9r75UTDwc8Oa0DrfgjVQAFJS9PnYR8jvC4pJrK7Zqa6?=
 =?us-ascii?Q?HYFG9a/GL/gyxKYnQSXlmQzTPA382F+Q1VnJ3ON03InN9FwTDKf+/Ssr69vp?=
 =?us-ascii?Q?fXLUPy3X1OTQbEyFvsiQL1/aExQjgq3k+eCYxD9JgQlJlzNsx0a9BNpM3H4F?=
 =?us-ascii?Q?RyZfxbPzKUn3nYHrmdp67+vn9snYleR2nY+WiRwcmVZyH7rh+mA4ec5VaPHa?=
 =?us-ascii?Q?oYjf7qGDTe6ydQToszGi0m00oGj0adhIMZoQFp3VsTwbypzreT4cQ0odp8Td?=
 =?us-ascii?Q?aSw9wcE9SB5atEkkz8JUerBeMXF62WXZdB5OGyg0ozxYzxMT9CCzw6wsNR7y?=
 =?us-ascii?Q?OQ7W3ONoRhQBOahtMt56/iloSW8g6R+CxQ6yO4axV6wfETIrzpIBnSML8Pul?=
 =?us-ascii?Q?ckrU/tA/Frx2kWYv9SuXbNtkjDlNbnsxEDQjlbncaheX1a3WMoxANyjdh/UP?=
 =?us-ascii?Q?Xrw5Cd+Exq8XFxum2ghucjD+Kl/OcCi9V+L/Uvl6iDo51A4rSjGNPNKkSqmx?=
 =?us-ascii?Q?w1kASOvVjmBuccMlonD8pKFG2W59oBzkkl58IAGOrUP/Do8Ch2i20dDsnJzh?=
 =?us-ascii?Q?KNlECNY5tg8EXls/T24oU3MqmsuL/Eoo0Tq/mxrnyQ6Arq0BXbebfMi5Qjlg?=
 =?us-ascii?Q?1FIFLDuaUoAkk8qBAfUbQQ4Mc8iEgYCsgGudMJqP5TBd58mc+S5YT+6nOGcs?=
 =?us-ascii?Q?Zwtc7quUFcfi5FRc8j/kQPtWCf1OOvIesNEm9eFQqs/ijCEWyvyMbG4reUe6?=
 =?us-ascii?Q?pylqif2lZUW15Z9xrVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9fffa6-f6d7-4ef7-1370-08dcc57f9b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 03:31:43.4654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnoVqvc3OmgrQOSTO1r4nDLim7iEFO5fKHGmOsN57HlHTmfVDs764yVF2Cij8KoAI3ZW3bRwyJD2nJ0KtGHsPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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

The series is Reviewed-and-tested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, August 21, 2024 4:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/gfx9: put queue resets behind a debug
> option
>
> Pending extended validation.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index c63528a4e8941..1254a43ec96b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1151,6 +1151,10 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
> amdgpu_device *adev,
>       uint32_t low, high;
>       uint64_t queue_addr =3D 0;
>
> +     if (!adev->debug_exp_resets &&
> +         !adev->gfx.num_gfx_rings)
> +             return 0;
> +
>       kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>       amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 21089aadbb7b4..8cf5d7925b51c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7233,6 +7233,10 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring
> *ring,
>       unsigned long flags;
>       int i, r;
>
> +     if (!adev->debug_exp_resets &&
> +         !adev->gfx.num_gfx_rings)
> +             return -EINVAL;
> +
>       if (amdgpu_sriov_vf(adev))
>               return -EINVAL;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2067f26d3a9d8..f8649546b9c4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3052,6 +3052,9 @@ static void gfx_v9_4_3_ring_soft_recovery(struct
> amdgpu_ring *ring,
>       struct amdgpu_device *adev =3D ring->adev;
>       uint32_t value =3D 0;
>
> +     if (!adev->debug_exp_resets)
> +             return;
> +
>       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
>       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
>       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1); @@ -
> 3475,6 +3478,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring
> *ring,
>       unsigned long flags;
>       int r, i;
>
> +     if (!adev->debug_exp_resets)
> +             return -EINVAL;
> +
>       if (amdgpu_sriov_vf(adev))
>               return -EINVAL;
>
> --
> 2.46.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1785D358E6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 08:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7560C10E310;
	Thu, 29 Jan 2026 08:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gDDzJhP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C264310E816
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 08:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHeTodnBtfb46/Ufynl9+KcM38AG93HMJQLhM2HCroGBIGq916frpCfWetZnkH0mby38jFdMRuliA3MiUX9Ez6goCeqS0V2MvZVOZHNt68X/nPoivnI+7lKgdh3Wwf/Xbu4KWe/lbDYiOQNMB31ATkZWgBywv2wIRaZQyLZya8A12e5u2e6bSkgINtc+aaEsCMY9uKAafKd++jf1nm8QnJu3mDskOgCjOhP1eYff9+/1zpvGO9Kax080OIwoerRz6Xfso1WHnkTE8HQx2A687nD97yhdxln1n9T3EX8RrlbqjcG9dCrwy07+q+U/HYN22vXWYUoPS693kxyHrfUOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHXeSjqWN8048EHpo4NxL2ouM911L8std+XPdhBUi4w=;
 b=w9UiGaVA3R9hHx57XNi9EMGHrUXfhK9C2JZmTRZbU+YLH/SchVpM34vJyg4k5QYmEKWabUw712ltk0xDYeKb+MUls5h+mjskWAiu49FNf7U5GGPvvTGNkYND7sQq7QewQrKp1hqcJnJQwrq6NVwQQpu9qFbvXg62pUHv48J4d7EuvXTzcXs1zAw1j/2Wu+A3qxJN7akKO82jIDHkrJw5XV+Qke1BeBgzLiPSf0WUOalmAzlY2bGef1WduH7KgIrN9YyvzB3+aNx5xOa65kSrpQIGLZKbr700xbqzVWvmeIx8cjKbGwhtiDUBNeNTMqpdAo50Dp5z/3KPzquOomRLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHXeSjqWN8048EHpo4NxL2ouM911L8std+XPdhBUi4w=;
 b=4gDDzJhPN/NjXRPQWSHGDFf6GZAFmHgCnMQ67nRJzTjUx78pmTeDtJSGPbQYO0VszGKLgeI1Enm2o4B8akdoTMcEo5M+gjZQMPfu+ySlJpNQ2aJp7qsSrgjA7icqgrTcJAmTtfdYYGbbhxIumrL6GfK4B+wi6VywRebSqcoj5uQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Thu, 29 Jan 2026 08:55:06 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 08:55:06 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/gfx12: fix wptr reset in KGQ init
Thread-Topic: [PATCH 3/3] drm/amdgpu/gfx12: fix wptr reset in KGQ init
Thread-Index: AQHckNionLK2joBmQ0+Lm4Qf9dehWrVo1ygQ
Date: Thu, 29 Jan 2026 08:55:06 +0000
Message-ID: <DM4PR12MB515264CC89BD0EEB9C8C5D10E39EA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260129043446.33377-1-alexander.deucher@amd.com>
 <20260129043446.33377-3-alexander.deucher@amd.com>
In-Reply-To: <20260129043446.33377-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-29T08:51:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB9072:EE_
x-ms-office365-filtering-correlation-id: 6ad1acdc-e2ab-4ba2-418a-08de5f141977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qFXXRNjDCynfe7nsMfzr8RlN0vuuJy2DEojF9DmU2SJu2jFdSAdBkeXwuxcV?=
 =?us-ascii?Q?cSp67EzN9YS+6y0XvvWmEbr3niEDZYmFNQV8QGYOw3KlkKqfJZjjvr0TTnK9?=
 =?us-ascii?Q?NRAqeiuBvxISujL2DgYx2O61aYJm09fHwHuOjvh5QyzOvsVAZznMO9LRTizP?=
 =?us-ascii?Q?j14u/Qlg4aEOqw19FHTB4FDZ1KlcyRlSlOSDZS5k2FfPRLMAR6fhBE+HQzhS?=
 =?us-ascii?Q?xdZDQBqUG3c0B5+UlUOgDokEJ/uJsFsOPhdcvzWDUshEg54Z5OdTmZiAOA5f?=
 =?us-ascii?Q?psofGNXLKEgUIkK850jqcfeFa7e9zdqAzJTgZH1TRwBD6oGCqNrQrHmLDQB0?=
 =?us-ascii?Q?39zy80ENqUi9Csf9L5YmCNosXQw0efxfyBY6FGh/cjYMEtj0BFhdac10qNqx?=
 =?us-ascii?Q?SKbRjTGxSwMWNTeyp8Xi/pgnNsfhC0VjbqEmQF1GX425FN+0XybrzFyoyQfZ?=
 =?us-ascii?Q?dREGTjkjFUWFiomsALqxRGY65fGwDifKgesMUrk1pbOx47NOZk/FxnT1nN79?=
 =?us-ascii?Q?duK/35TO91dIwUrdWISg5QHISeMCnHTcGP0FOjSEYfmtU5j/9FhApLyP1Vw2?=
 =?us-ascii?Q?b7s12djxjL2GOABA0fNPULDNSYNlJOuWwvSj9m0n5QIEKE2QsYwWnVVM99n2?=
 =?us-ascii?Q?Cmh7Zc/O5juY7epUPhC+tVsFb1gqWJ7M+1HpJ/LuRtK0WWvdjozPI6IV3V6q?=
 =?us-ascii?Q?8m+1GZAeaQJOwlJsd5IcJB/qE539xb2hqNDZQ0RqBlZv0SXzm8Ux3e4xQ7p2?=
 =?us-ascii?Q?0oASA3FKFsnCI1Hk0hUGd+MqiGux6YM/0xgIncajSw2WW4qpygKYWK4TQtzk?=
 =?us-ascii?Q?Kn2lRrxp1PwSgGc4KFDZ0ryAUG0CUXsK7eePCfhfT9fFGJwtUx5iZjW/WRe8?=
 =?us-ascii?Q?+2LjFSwCuCCvNgF6xEqaAefioRrztI6SUm6WbsYsqSXkSboTcu+vvpk2j+BD?=
 =?us-ascii?Q?hvVd3TigkK0XzTsnNfSNNzStAHUW6SKnCiGDXoK6N0lhw5J4pu1DZ0kXqQ1x?=
 =?us-ascii?Q?MhZDFwUrjSuzusJ3JH7ClgPFKShBqTIw593o2e2jXDo/Q2xR7XmNDpFftlsz?=
 =?us-ascii?Q?4bIAaAxgNyJ2ZrBZn4ZGvuRYi1n5VMgk7esVav9H4LaX4CwMMV7LbsEu3DZr?=
 =?us-ascii?Q?/Gzk8cAcGTO2VLu2GAuvCzbJTg2bFwvx/0gXZoKi85+F6rouw9JKrhewEovG?=
 =?us-ascii?Q?LKSgUpuyiT608J+Yl3SDHYB/yqJ/qoOW9zzptITxh2KPfpwNR/B+GXfDhMKV?=
 =?us-ascii?Q?hJ8lOdC2VcmW8xGlESs33GdhXrgNk/at42y20IFhf4Xn9aYEsm/2e5XzRbnq?=
 =?us-ascii?Q?fbNekfC4F47B97Hj2Hx7BaixccxVeP8A4p58uwfzkehC/I9fJIPnXYf3Jdrr?=
 =?us-ascii?Q?Srmu7EWd+BfwWjsa6idiIpGC9KOPoVWXr+6LKuwSRh92dhYQJ3OXExySuvwE?=
 =?us-ascii?Q?awSauP93q/SEAVlXhq+XCXOPAkbgl33SiPO3foTJxqDKfcRa7atIyeHQvMGk?=
 =?us-ascii?Q?+67quBn68JGN2pJFNnUv4ALWTMJS60cxs7r3KXCYKFcbdOQfHRIdSEHK3ZaD?=
 =?us-ascii?Q?h8kJfMOvo4iYiVJ+wQqTH4HqcLGRbXGVqdnGg9Q610wS0WS2y9RfJje3z0Nk?=
 =?us-ascii?Q?QUIHWwz01+5Bu4YgZMV5uDc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IGcsMzgx07xYFGTd79jvmJo9SPEQIdLDddvnewx0wYHcXW+Y3nLpxTW3z6LG?=
 =?us-ascii?Q?uywwbMM10SEn+Cc9Q14i5tgONIsTKcvT6SEPJvi4iNDzr1VZznXHYnwNbLUT?=
 =?us-ascii?Q?15qReyyk1RIGs4tNlEcwFXGOGr3kBXuZOV1WopRgHxKJ2ohX2aWrqIu2eJyg?=
 =?us-ascii?Q?IntDxpJFKkWFCe3Q65DcNfPvRsRchyd3qrSI7uyJt/KjhexKAvYBe/RT0H9i?=
 =?us-ascii?Q?NL4Hf0XhQ/Ay3D65bTjydugU2pj3uLXI5KKgq2YpyupYH26Q9FnDk4Gd2f/T?=
 =?us-ascii?Q?C0zUHagzhfPF41iG1eM52Ek8w0gBokMtMTVnPitA540WhCRXShulEiHZERvB?=
 =?us-ascii?Q?cQTjz2l4t8gC1Q2+mhuJtKcREhmCpquSueqIKjgRUG0l+BRZZ5nCATpUff7m?=
 =?us-ascii?Q?ubdcZFSlepOkkXAEiIsKw/ly910Fn+A8NBTe6q6c0lPIX6Qnfqw6vGlR3aql?=
 =?us-ascii?Q?vl0Sw2X6NSERuPpKBfwUdEmHEvceIleqBFp3eJUBOCUGxsTHTNwqR8fp3UQU?=
 =?us-ascii?Q?UWbYNFRXpSh6Nw39tfLuVDp0Vjn8J387fxxVRF/Niw4L/lTmV5KgoYZc3Tn9?=
 =?us-ascii?Q?njX43p00wAMKZqtLnByZbLdl9LkDsvmU+VyI01hetsDkpzvYcBGVMQi2z1na?=
 =?us-ascii?Q?jTq5ivF2P/RqWtvzfBpwIj8WYFFZ/AfSLzzklYphu7eRdDzaeJMX1rgl9+J3?=
 =?us-ascii?Q?y02PzjMc+fT/NbJrdfOAtcuadI17yJA4Xpsj3aRzLIEwWRja5V/6tYAHTk6L?=
 =?us-ascii?Q?wSvSQfWxkoH9qRbSlWdBSX9tOu0XpSDUpZ2VnL9XJJslm4Dhvv+PIJ5mGZne?=
 =?us-ascii?Q?v8QehJMzRF74yK7RGIReCD8KeX77iCEWeOy8mt+v+snfShdiw8jESS85GG4U?=
 =?us-ascii?Q?xknGZqJV56ht7RkDsa2j01929kmRnLkWN7+GWQo55FqkApd/L5qaC+vGwfY3?=
 =?us-ascii?Q?pfyjNYaestIwn022JLUQlt1smKKXDT8SIvh4ojB7JgBmpPhJIU6oyVXrbXDI?=
 =?us-ascii?Q?K0P+NirqRv9G9fHWgPhScvPaGPtWwhdAsMVrpW5p+Cmfw7N8nk9MhNeUDJe5?=
 =?us-ascii?Q?WrAQ3k7WwPlhEhUOGWQJba0IBHf5cq0hiEr5Mujy7/R1U//KEeZTQjZJMLnF?=
 =?us-ascii?Q?nJmTQKWCYmfFGQNvTfFWKFSkULUTcbLW6oE7Ts48M2lwZb9Jg1INPDPp7u05?=
 =?us-ascii?Q?J9DOt3gg58uRtzTQM9iM1g786hObndha2bEvgly/g6pw4H0MVMyCVwKvJQML?=
 =?us-ascii?Q?usE3F/rVUdKSDVdCoRe0/UZcE46Ndehv+xz7blSkTyY6o+9jF18Kny4ukQUD?=
 =?us-ascii?Q?H7nmcgNjNYuJZ+ma8czwMRrlMuD02GAtHd4qwqJQZpgitNaalKPbCE3V9lxy?=
 =?us-ascii?Q?U0Fxs86pHwJd37DVK6M532VI9/AysnH1fnPbdB+n+hJir1wUcZ1WZKpNZG2P?=
 =?us-ascii?Q?x6JQ7DVz2zk/AMLpsJ6O1NvKSGdzL7vf5/VBkC6LkMedWd9Q2obEZlLfwy5f?=
 =?us-ascii?Q?YXJt/VYFRX9PsijkrKO1CJhrut+u1Bsr7dkC1EloYQq2YiNRl1DvLSbut2tH?=
 =?us-ascii?Q?DWbrWV5ge8QjFLf9CvBL7EXwY69c8JdzOXbIrg4TszuX9elhyslErKkWOieO?=
 =?us-ascii?Q?LITg2MSlFYVUX/d48nrRPghK4EBamBtufGFk2vT17nTE3N4anBlKQEsqf3wj?=
 =?us-ascii?Q?dNwz62Vyv35XGkTa9SSbVgtZAg4/94xzB5vux0gWmYvp6exc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad1acdc-e2ab-4ba2-418a-08de5f141977
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:55:06.4268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mbj8md9V9OpffKvweA1xn5Fdt+P0zfSHwrFEUduz8Gig2BC/c/a0Skx/aBWbB6J44mbiensPByjgM8LZy+e4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

Series is :
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, January 29, 2026 12:35 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu/gfx12: fix wptr reset in KGQ init
>
> wptr is a 64 bit value and we need to update the full value, not just 32 =
bits. Align with
> what we already do for KCQs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9e48045b036a4..d8ab93c82366d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3096,7 +3096,7 @@ static int gfx_v12_0_kgq_init_queue(struct amdgpu_r=
ing
> *ring, bool reset)
>                       memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx],
> sizeof(*mqd));
>               /* reset the ring */
>               ring->wptr =3D 0;
> -             *ring->wptr_cpu_addr =3D 0;
> +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
>               amdgpu_ring_clear_ring(ring);
>       }
>
> --
> 2.52.0


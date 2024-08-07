Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3300C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 10:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED8A10E48D;
	Wed,  7 Aug 2024 10:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="np2BFLLG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F099A10E48D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 10:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNM4xHvA+IQYNKzPhaFP98iF2qhyj+9egSn79sJWlsmGuKk9lBSQVru3+hCZHuoU8SdzLWTBUKUuy7JxSr/P569HaXw/xYh5pP2N1BzrFjAPgV9r/HiKbsKAZo/fshmnPWSHIx1qYsAEKqHp91kzIo4sGFUfAhgEetjZB4Xbhe5BSKgRbVsb2FsLWiEFykmK1lmHpUqz2UsuJ60l/wPgh1d2UMqOIYRHwB2CZOyqrFiQ7+ZX1YadW/uaRnXcs9TfXX1MwXILkNZicB8s2S+pZNb76bUupS5oNfFuyU7UJ/kwzRFqkfl0+lO+6PwILUk+37p9uqDhv9OFYCk+MrDjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ3W/f2AQe/pZtW0URogwM8Cv3tBAhGV2LS2wZ7WuvQ=;
 b=jcwnHOkbLMubFd+/lDPqOUnUVLTqKahMxjlc0aI0ZlKwiDnpe8/9P3v8V8MwawggwMz13osNbtQ34OwCfUwOseWlZaJlXyPTR0qiJVOGbP71uccMtNqhMnXB7o8i/N16Zryiwi9iv4SGj4UAlNN+0/m/iXqsJMBC0osBiYJ+aMwOhjDMJn+WhHy61ICM+fmHZAqxXoW+JScyYly5QP94MvnhOOJDlhbqb5d7pjbSazNPv10IkuYB3RB8Pq0jW8bn9s0i8GFnVPl7kLh/QxDscXDHLl9CxFDQz1Hjb2ReG6/6h1KqVp2xGB/lvY3gh+ndAnr9omVxF/KkACRoq/cNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ3W/f2AQe/pZtW0URogwM8Cv3tBAhGV2LS2wZ7WuvQ=;
 b=np2BFLLGu50KOcQdnN+hl2UnGBqoq52Zk08dYmSMlWBD9vjW80TvUGFTnEuTqoO4r0qfowfron9Qq6iW/Y7QzRZPK/lpaiPKXZ8m2Hv0QPoBBwevCI4DsggiG8Mp2o7DaJbBN4t/7IfxOjibp9Z6vY3CTm3qn/+ZOizQ6iBbRwM=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Wed, 7 Aug
 2024 10:15:21 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a%7]) with mapi id 15.20.7807.026; Wed, 7 Aug 2024
 10:15:20 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
Thread-Topic: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
Thread-Index: AQHa3NpFMT0UvXEhrUKklgWJTMpOs7IaYa8AgAFCtNA=
Date: Wed, 7 Aug 2024 10:15:20 +0000
Message-ID: <PH8PR12MB68419FFBB3B6B0C7FA22608EEFB82@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20240723082737.2359410-1-Jack.Xiao@amd.com>
 <BL1PR12MB514460C71C2B804E7E24DF3DF7BF2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514460C71C2B804E7E24DF3DF7BF2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c3fe5217-115b-4623-9105-85f588fa8e02;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-06T14:33:46Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|CH3PR12MB8353:EE_
x-ms-office365-filtering-correlation-id: 1c4c4eff-36dc-4e37-79fd-08dcb6c9d7f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UKP66l7SE9lIwg7tC/BqLUIyLZ/vE+vzSDaYabCSomWy1n2U2MlrIJPDrduX?=
 =?us-ascii?Q?vR04VyVl1AYdRvx+kLTk7Oj8dkwmZs4dyv8b3WGwnwij7B73FgJbGtvtfu4J?=
 =?us-ascii?Q?eT/UbS1cKtFY9oyclCnLmV62xbwIxmVl2/S3fh+TL4jkuSzmSLNDq5JVM2Aj?=
 =?us-ascii?Q?ZCowNl1iHaCmBA93iaQsM7dn9HaRKPYzD+K8/+e5GrMi40YrV3wxUME5/0yN?=
 =?us-ascii?Q?oZlBSddk7zmZl1jWACK6AdepGycYQAf38RmZJeJk+Kye4Ntiik9N5sXG11ls?=
 =?us-ascii?Q?VVP1dAXa5ZydZcYvVR5eVTl/9oPCTf/2yhpXDdC0ECYTDJU04X9zDaXxIvSx?=
 =?us-ascii?Q?fy8b+/XtMSgJngT9SeWFTRGX9y/ldEUVtxtHNOcmprg5gpwDmnJMJi7ANz2W?=
 =?us-ascii?Q?r+sIyapjg552nK0/S9L7F5GQrCwfynCdBdSqDoar5BcjR8IINECZjGcOkJdY?=
 =?us-ascii?Q?dW62TxPbV2iI1KYJv4AvJNxf7qSuXL+XTnP5qTtiQiC/Ri8ZGUWkWPnhgyaV?=
 =?us-ascii?Q?6+06Qpm3AzkskipcDmtFTj/qBlNbKniQIol6k0eOLGukYIlyvC1QVMvmUzLK?=
 =?us-ascii?Q?Wm180Bt/ev6km+P2Zunl8tIYTjZBRngi+DmaipxwZuq40GcVf9I0QcatMSlD?=
 =?us-ascii?Q?QFVdMQFTwdv3GPilBlds5aN281gjkOlswMsgmdOAVoqbtDKIUHybLbTQ3hwb?=
 =?us-ascii?Q?mFCLSb8WeimbC9SHTD/lBxHtIqPanXH54twmMdCzUF8wB5Gz7FtVPmBAOqhB?=
 =?us-ascii?Q?wN8QN8LUrWAiL/sQmo8tJ/9BUw/ZxiltpOg0lOkumPSxiC7Boq50GY0G+1wl?=
 =?us-ascii?Q?EZ3omWKM4pQWpQluas3vIqMI2AenCtoRb1qfhXhX+/TtcbiwIPyUxFB2ByC3?=
 =?us-ascii?Q?4YZ8qxE5MLs2U+mL4/Te2sI8UfqMhXFTCbN1VGL/7cN/KcCNtM26o1RYhyIo?=
 =?us-ascii?Q?uTAYBNt96fE3/I7uJ3Xxi663Z9xS2JGKIcYzwtmCXiOTHWi8k3klylHgp9QJ?=
 =?us-ascii?Q?P911J3N1CJ4z8gSjwUGBxS69Lrz3HiYEY1jl9xAe8LpAG+8aJrUOQjg++4jA?=
 =?us-ascii?Q?yZUFPDLaFgXg9AJvsAfBn5c7NHgLxjGsA9eK+w8BpEk05HEdKrdatjQF82eJ?=
 =?us-ascii?Q?JVYwemW2RsOWfgL9efZ/NNUyohwz/cb1c9/GgvRhXQxYk6LOKPC6h62mfXo5?=
 =?us-ascii?Q?fkvc0kB0azBQJBQBkTMYO4THr+xjmHXAJRBOtQQ5D5B5v2+DGOkHi13tng+r?=
 =?us-ascii?Q?9cnNNur8IFSImY7f1nKCNOcBjcLNVyKdC9lpADPEQUtFE5nfNvIA/k23FsjA?=
 =?us-ascii?Q?h0Y5oRPiBEzNLGOslvqyexBRI56Swv0G+rvEm0/E8i9KWRyQqB4qgNzzSCIY?=
 =?us-ascii?Q?epqvwzKstcEl+13o0OPuCZUyIOe3YthUacmt/LaPXYtqao1VTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uyvz7M0+5as4jmNsQzUX8hAeFFaVLp13xZfKSCimSL93gQH41viEKwaqpbHD?=
 =?us-ascii?Q?YleEfFiplU8D58IwmycgNOYWxLSsHpWooxv88jzIyBzEs7AJpyuJfaBYDHgl?=
 =?us-ascii?Q?0Swk2F0hnj02M09/z3P/KId10m/UnThMMPvpZvJt++jnJF4xM4LHdID/dMsU?=
 =?us-ascii?Q?el9XSHda/3L1YsuTu6Q2XGoKNVJt9ENqFFJw4AwXaEaBgJeMEwinvfuxvqiE?=
 =?us-ascii?Q?cL5fUbG96BqYjrzXCf69KqO226qT6D+dafNFLAHIAuL7OTjEOrrRkjvV+6jA?=
 =?us-ascii?Q?x/xWiNmSfiPALjgDKlKgaVkjLfXUVxEwEehrGoAlKfESed4Bm3aOuLTjZFvX?=
 =?us-ascii?Q?VS6tlNIAWkmX/vi2qxLuUJZV+OVvnif7nLGruT9X7gict1nNFTIF8tAHdY5i?=
 =?us-ascii?Q?AJjPIqnVh/mREJ/fcWlLH7PAqu2yzGA3+RGo23ZuAInaWQYmS4U1vaeMVsVG?=
 =?us-ascii?Q?nvR4yrnF9VRUkeq4t58VaDuWob2sa/weDugu6LP5zY6+3R7S47aw5l6N8Rbg?=
 =?us-ascii?Q?K+4j6i4BmjzJXxmaO6gKIx1wyY2CApsOzg1rZA7AwGeWT1rP4laeH0HeFl+p?=
 =?us-ascii?Q?6V2K/d4/h1Wwt/hlRU/aOhYKWhqIfypicLIRmSV+mmIhBPu696/x4xO8eF6t?=
 =?us-ascii?Q?C6YlchYGnIeHa/J+0Vts3Q2+zlqfKl7hAM4Sp4lqkU9vrRzxzLRxYNFunlOM?=
 =?us-ascii?Q?Xdox18UIibi9jV9yh8/WhHS4b7C/HDLM2yjvjJMqnL0cTotyd4k46rPhsPiF?=
 =?us-ascii?Q?72wJmhKgxVajZ6eSCLEspD0daQR89ll58QUB3l/Fw9sJNSdx3k9r53ioYnnh?=
 =?us-ascii?Q?+Op8zlkgro2nkuM+CQ2EQh8G2Gs+LsvYWRZqwEpV0dsvXavKknWWsjRERxRD?=
 =?us-ascii?Q?Ww125FRuL2FYsXl4X7hMo5Ci3o6t1htgXAFQC5un4DVP8prniv3IT7el8KYe?=
 =?us-ascii?Q?B++lxjtCJ/o+win5d+ZfNcvokvqJymr2BGtGhoJAZ3JhEWlYSogO/FPzDzQT?=
 =?us-ascii?Q?8JS/Rn38J71b2tHZNNG38mS/yiOvM6RkDcbdPP36E9TQRSMp/zkdsasZ9foK?=
 =?us-ascii?Q?Hnuk/e7iHCWXm3xcsRcsapqQsBg1zB8PrYIT/sR/2vW2WgKCbYl/20Fqwgw2?=
 =?us-ascii?Q?lByIVjYfpu/Fhh7ZRr9GqsU8kJXJmOF1Q2DjpFiY0zZhARaxC+jtpL1UJySu?=
 =?us-ascii?Q?5ISQKOaogEOc18lbwBwp0rg8DKGCcFy2P9i7OeuZW/BA0Zr9VOK7mNTjg2tS?=
 =?us-ascii?Q?6jToGMXLMopKYKnPqGQ7Wj9OHxX423SNAC8sC1f/bJK03UcgSoOQWBaZyViD?=
 =?us-ascii?Q?j0o+a6N2K8SFn5bx07nwLwxgKIc6saex9g3Vrg3p9dD9OVEjocOSG62olIG4?=
 =?us-ascii?Q?xNbUQ0CyZ2bu+6RjoKYo5pkdiRFVsbWjkVfJSyps+puCeAJX5yRIWfVBI/B9?=
 =?us-ascii?Q?hSLj4HT9DfYj/NuuygbegFAkCjWGvIHq9Bu1CuGLev5iPLBWVWSfXD68J7on?=
 =?us-ascii?Q?TQgd/8GfxSTsloWrJkl/SxzRaFe+qLkAbmP2LUm5yQAMGGRsk6AquuJMRxaB?=
 =?us-ascii?Q?b03opg1BTwwPKj7u00Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4c4eff-36dc-4e37-79fd-08dcb6c9d7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 10:15:20.7213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/1xZx4IBi6+BTSa/el7W9g9mNfJYF+BBGDSBC/+WVHzLBBXUm+ZzN+AjZixj7bt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

The maximum sched_hw_submission value will be set to 8. The value will resu=
lt that the maximum number of packet execution which is not greater than fi=
rmware allowed.

Regards,
Jack

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, August 6, 2024 10:34 PM
To: Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org; ckoenig.=
leichtzumerken@gmail.com
Subject: RE: [PATCH] drm/amdgpu/mes: refine for maximum packet execution

[Public]

> -----Original Message-----
> From: Xiao, Jack <Jack.Xiao@amd.com>
> Sent: Tuesday, July 23, 2024 4:28 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; ckoenig.leichtzumerken@gmail.com
> Cc: Xiao, Jack <Jack.Xiao@amd.com>
> Subject: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
>
> Only allow API_NUMBER_OF_COMMAND_MAX packet in mes ring buffer, refine
> the code for maximum packet execution.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Any updates on this patch?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ad49cecb20b8..dfe487521a4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev,
> struct amdgpu_ring *ring,
>        */
>       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
>               sched_hw_submission =3D max(sched_hw_submission, 256);
> +     else if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_MES)
> +             sched_hw_submission =3D 32;
>       else if (ring =3D=3D &adev->sdma.instance[0].page)
>               sched_hw_submission =3D 256;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 68c74adf79f1..951f13e01ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -198,7 +198,7 @@ static int
> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>
>       seq =3D ++ring->fence_drv.sync_seq;
>       r =3D amdgpu_fence_wait_polling(ring,
> -                                   seq - ring->fence_drv.num_fences_mask=
,
> +                                   seq -
> (API_NUMBER_OF_COMMAND_MAX/2 - 1),
>                                     timeout);
>       if (r < 1)
>               goto error_undo;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 48e01206bcc4..dc65f28d1795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -184,7 +184,7 @@ static int
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>
>       seq =3D ++ring->fence_drv.sync_seq;
>       r =3D amdgpu_fence_wait_polling(ring,
> -                                   seq - ring->fence_drv.num_fences_mask=
,
> +                                   seq -
> (API_NUMBER_OF_COMMAND_MAX/2 - 1),
>                                     timeout);
>       if (r < 1)
>               goto error_undo;
> --
> 2.41.0



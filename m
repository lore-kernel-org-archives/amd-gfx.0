Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACEBC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 11:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D761010EA3D;
	Thu, 11 Jul 2024 11:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I6+YSnYK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5165310EA3E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 11:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ6y0nkOTU76/90unMvwkksyThsdj2LowD8vO4iY9thn1SXD93+BJE4hk46aU7U8xiioULRR2NZVh2uf5jnpoQY2aOB/1xi3LX9mn3/LGaUDBZAe+OLg5HaBYdbL+8lWBSI6o3Y8uzI1/v+GCVoMUNCG47u5KY1dR8qUVV7xengHw74Uw0SkkUU2xuniy0GInJBIhtEerL7KXeCw9n9gq8iclK8SqgKl1OebdPjY1kVD5rddUPMUovnAJmVQDtPRaEkM5oDn1pVxX21NPt1Ri2yHIeVX/WI/ctRn7YNwpgOoGH7UCyC7fxfgKdheIDBl3Yvn/89twVdxWTcujdX5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbhHD32SJDya8yj1rrL4QffcBrt85zeJcFfQbB4IuJA=;
 b=ZSx/Nt1hxprmMmOn0d75ExLKOUKbSRPjrDF/zBojeow3p8Md2QGNN3YjpS/5kpo0CjXYx2Q1oGsQW0lYlgHfSDamd7z88vJBEotrPXYF11s50ik+UoaY/NjEiUf0yVKBCjIETzuob/ws1HaS9HmLLEfHCi8wXjxd4TSWILpTcZdNfU8xikTRxkVZcexqj3d3x5NNbc0/SGQjAJDgY/YWRt4VBdNeTQowqRWGBrs7PecYgVPeZq9I7nobibs9ILOSmyW0MPgi4oOrTjv3Bkkg7/3rvqeYOtfbL3bOlqwL/k9vgnZnFWfLQ26Huml2iC3q/9vymoe5hGXA9OMJWP6vfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbhHD32SJDya8yj1rrL4QffcBrt85zeJcFfQbB4IuJA=;
 b=I6+YSnYKv06w8M0JwFYCFp+DIb9iuBJHO9Zf6ahySZPOkRYHhOH8khWTgewCrqRmkauaLxEJIzQeUp1z9Pt34f1zq7M/qhG6uYujbEGHIHY5FMHzFpoP1jozCF/MoVHbwzCCXgUXrZWSmB77zTdDQNoSnMz+V/CWgWGvXouKkjM=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.41; Thu, 11 Jul 2024 11:56:15 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 11:56:15 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>, "YuanShang Mao (River)"
 <YuanShang.Mao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
Thread-Topic: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
Thread-Index: AQHa03IhEK0Tdjf3Jk+mDkXW36o+uLHxaZFw
Date: Thu, 11 Jul 2024 11:56:15 +0000
Message-ID: <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
In-Reply-To: <20240711090947.478919-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e650a8ab-534c-4e8d-8faf-07322d5f2a18;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-11T11:48:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|DS7PR12MB5936:EE_
x-ms-office365-filtering-correlation-id: 0438a2b2-9e57-45ea-0fb5-08dca1a07782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mk5X/z/Stb/WZBGYxhx2N6Id4juiwmDtAHz+lPOydjhQUtV9kcQscsiEqQJ7?=
 =?us-ascii?Q?hrItPgjWahbAsvlNSP0GGx3AXP0Q8DRtiU+phUf/OpRWVO+62tF8ho35TBax?=
 =?us-ascii?Q?8WCY8WjcrNXylh1ogf8Z3ooAfgcd5Hz5ChRdTvr/n14wkg1a7knJv7rQpssV?=
 =?us-ascii?Q?yhA/nQCzLxpCSLH+9ZSIpKtJbEw4XrZ0I1A6RxVqbQa3MadpVCVrq7U5CGHd?=
 =?us-ascii?Q?NrJnYusjmvx2JtXsb9bWzzevGFZTzGWjJgg83Y9csev6PPQ/k6vTVH/qAGuC?=
 =?us-ascii?Q?WWyPqu54E2k62jA60W5z7hqbbxo8orXMucJ4wLjPigZvZstCJiS542KhDFWG?=
 =?us-ascii?Q?DJ0qp4Q5IIQDPhZWQZHoxHb9CgFku/Jvpu8L+DMb3Oxz1wHuP/5TfrkbNati?=
 =?us-ascii?Q?TPvz4b75sJyTSBAOKcPAlH2fF5bYCsEiYHOkL2W+eqNGw6wldZXrb9JpINKR?=
 =?us-ascii?Q?e6Mbv9+lRPA1ENoEtNyd9sgj/DpOIwCEvjlkCedoH+mCxKkzUEvvjt8rO8/k?=
 =?us-ascii?Q?ZmZBgF5ZT2eCYafEjDLQ0qnVEYtu4aZoQx7sqb2rkRzN4g0FtzIapfOrMx/C?=
 =?us-ascii?Q?qV0hN4TV/qx7GP8egU3ZV/dbEPMXvHBy9xp3+4IfMrY/eb5e4rWkW1289F52?=
 =?us-ascii?Q?N9EWdQ49zXu6brcWGirhzYW6ba1r0JWahseQj+mgEY5gfgZuWpOXntpGEqLv?=
 =?us-ascii?Q?hkPFO5+R+egnl3EmjUY/yTYmfngJL11pbKCVpBT1dcVWWTRlKmVxSqnSvWZ2?=
 =?us-ascii?Q?u1bzIMn5TTVSCBpvpP5pgo8WYsBrP9IbIe/zy+AD0qInyJoTENYNh7H6K8N9?=
 =?us-ascii?Q?8ocjUg7KH9BbisU21gILqcguIFlwM1qJi9cNzgrkww3SGoWRcdxvIy/MVnSO?=
 =?us-ascii?Q?+29E33ko4VhzUzyG8jTMkRtW1aK/kOPdpqLJ1qYeTqQGh9Q53unrr/WNPFrP?=
 =?us-ascii?Q?L/SR+mP8OYTGoAReP3xu722tJjyfWABMld0yykGS5UkIj8u9/ZXC+nT9uluI?=
 =?us-ascii?Q?vGJTwqSZtrqXLvDncG9pYtq7sYUP30aIxbBGmhHPY+wG2ENOonvpW2bmEY1x?=
 =?us-ascii?Q?t3Afauq52cMLf3CbxJzWYLFW2PlbSMxPiTrCvmp9PB45YSIE/HaoJ1YTt6O0?=
 =?us-ascii?Q?Dax1BA5yI+K4US6nk8CWn6xGbHOzxuIYx6YNLQYs0DVojfU9B4XvhKn1l5mm?=
 =?us-ascii?Q?fbjtWCEoOQZrmTwv41m79tiTZYMR1eL2SAakXbJ6bUy0CHVEy3S5rIFEYKGC?=
 =?us-ascii?Q?zBKVAOhw9QIJOfd6FdxCLd/tSTECF/iXa5rbjzGec32SRzwvrsadz4AoRLR7?=
 =?us-ascii?Q?K2Hp3upPwWgzRlA8SBZrV1oBHnhjCZllR+jPJwICHr2M4kEyBbf6Mq2fr51J?=
 =?us-ascii?Q?lTgQJehN+9YVB77dz1sk50SyaPK8xaUd5ixSMgfmPggzfHFclA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jcSfSZR8u2KmXgb8AP+ArV2OEJGEg2I8Dl0LrOeciYROpHPLwA8jI4I8+JJi?=
 =?us-ascii?Q?c95LXfaIwW2yD7/v9xEWmUX3ie2xK1T6FE2qfzEXg+9o1nhj1w0xnF2F5f/8?=
 =?us-ascii?Q?pCLS/3knpnuQGiGhwXVyWOYiSBinheNgTbYsiw5XTQ7/QSLkIxHR+2v+12Ez?=
 =?us-ascii?Q?SI8uQsSEm9Bs/+slYWworborwcOFStAyNaYANfT78tGAiANyuzzRq4tke9Eb?=
 =?us-ascii?Q?Lyx5Lwjtc7maOe3uav8E9ylxPVlwO7Gtm9FDr4orzuDv8AeSXdemaQT+dIeH?=
 =?us-ascii?Q?ot+KrDwrU9PhmU8l5JUZcOYq21YQcxqJSWzxsSVlJgZ2MWaUbx4PcN3VV2WR?=
 =?us-ascii?Q?7cbMSSeJUJ9+AaLzM46rTtSGO8hKRGGAwOMRA7tTqztsPi4UK2lg6xaf/YnB?=
 =?us-ascii?Q?Ipw+CN4bl77jfXq3Q7T/CPkUmbcgYZl8+q079BkRvEQuaCLVKgLlSo35CJ9x?=
 =?us-ascii?Q?1tG/r0TwZ7ByHWyPi60h9JUWcZ11VBXmlqGT4nekVpySglXqV3EXK0RW6/+K?=
 =?us-ascii?Q?YBGA0lTIir0s4way/7Omfr7n4yjUtzW69qJafsTKvbDoVcXE9DX4Js/QWsDT?=
 =?us-ascii?Q?LgGLRlmieeW9aHGoiQCHnuiKKa5dPjz1ksfJrUd9hg87sYdScDbsFtLUZhq9?=
 =?us-ascii?Q?+ifRTiaNJ4BfL12xH++jldi8/uv8T5p4651wzwjnAqKKNuwpxR/18H8F+K5c?=
 =?us-ascii?Q?xazHqZgtxfvFw8hULCmUJzrP52edbGO4VUscX1jnhG7Ynb/oz7oq5I4OhZf1?=
 =?us-ascii?Q?ZMP59ve04VAi9LnUdGR7LtUn6uPP0hJxBGtg/jCDhtotxCTuiiPhzoxJdIje?=
 =?us-ascii?Q?sp8QGQkUeW1kOTg6kE0ttTwjqi8foDzyW/E2kr2r5Ux3kJQepAbGjh2BSIpo?=
 =?us-ascii?Q?DMfvEujxQyNTpRiGfifbD2HztZcW5kmuBmHcwdf4WdTJBcH/9wfQ/vjUa+MZ?=
 =?us-ascii?Q?smqirNhwVOVUG9Vys0CoJoqQnT8oLMEyOk849Kuppskf5K9EGHzFLd5mPsHk?=
 =?us-ascii?Q?//4R3l14uNdsdQ1KJI0bB1xc7OBWAlTErvXvVyW8tWDQFqpbbc1a0Zr6LCNa?=
 =?us-ascii?Q?MYod4pfV7T8tgh3ggABBUSBa4urb9Ud8pqnW2+aG5BGOtxN8cRNWFDpnD2ua?=
 =?us-ascii?Q?KjAfQNooSaPIUERZLAJeoVmPCZkuI0qB4xGbNLfR9s0aZjWP02WowHaoUN85?=
 =?us-ascii?Q?sYVuiSelD0RHlWd9tvWJTN3HvtyY0NRTmv7dQVcSeEt+FCuEW0vE3rgrNSMk?=
 =?us-ascii?Q?mX8KSY6/mcyVBPnVMvOZ5BQA6/gYVmJqd739ni3wIV5xKoY6Pvhj+jo3dUp1?=
 =?us-ascii?Q?yM5x7B/nr5fi5AC8n8wsxraD8y/O1AWHP4x4cWnfleEOZ3paUkMuaBu5T+lr?=
 =?us-ascii?Q?JKIwPyu8qNeM68xzln9nwa/9QyY0ducC8AU8MtYG2a5gNnP7vX3KXIsIi8RL?=
 =?us-ascii?Q?0FiXy+rlj6Knbkdm5AqSjs1990zaZNd1hLarWaO32PLII4jcyRaYz5LY9sbF?=
 =?us-ascii?Q?M1Ke+tupR3xko4TaLRD/XGQYk+BnXaFPGJ5GthwE6rDgdLyn/5IdpEXGLHVp?=
 =?us-ascii?Q?x/DYGBdkrRAg8/xrxQ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0438a2b2-9e57-45ea-0fb5-08dca1a07782
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 11:56:15.1476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hh9bkkSYS7AliaVDbsQ0UqpHvWbTPO1whhNWnbYQqwog1TQ6LtP5u9YcwmYkfRhIcpv+yiYtGKPdczNINkTI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

This patch seems to be wrong.
Quite a lot of preparations have been done in amdgpu_bo_move_notify
For example, amdgpu_bo_kunmap() will be called to prevent the BO from being=
 accessed by CPU. If not called, the CPU may attempt to access the BO while=
 it is being moved.

Thanks,
Trigger

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> YuanShang
> Sent: Thursday, July 11, 2024 5:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao
> (River) <YuanShang.Mao@amd.com>
> Subject: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> It leads to race condition if amdgpu_bo is marked as invalid before it is=
 really
> moved.
>
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 29e4b5875872..a29d5132ad3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -519,8 +519,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
> *bo, bool evict,
>
>         if (!old_mem || (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
>                          bo->ttm =3D=3D NULL)) {
> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 ttm_bo_move_null(bo, new_mem);
> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 return 0;
>         }
>         if (old_mem->mem_type =3D=3D AMDGPU_GEM_DOMAIN_DGMA || @@ -
> 530,8 +530,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo,
> bool evict,
>         if (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
>             (new_mem->mem_type =3D=3D TTM_PL_TT ||
>              new_mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)) {
> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 ttm_bo_move_null(bo, new_mem);
> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 return 0;
>         }
>         if ((old_mem->mem_type =3D=3D TTM_PL_TT || @@ -542,9 +542,9 @@ st=
atic
> int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>                         return r;
>
>                 amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 ttm_resource_free(bo, &bo->resource);
>                 ttm_bo_assign_mem(bo, new_mem);
> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 return 0;
>         }
>
> @@ -557,8 +557,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
> *bo, bool evict,
>             new_mem->mem_type =3D=3D AMDGPU_PL_OA ||
>             new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
>                 /* Nothing to save here */
> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 ttm_bo_move_null(bo, new_mem);
> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>                 return 0;
>         }
>
> @@ -583,11 +583,11 @@ static int amdgpu_bo_move(struct
> ttm_buffer_object *bo, bool evict,
>                 return -EMULTIHOP;
>         }
>
> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>         if (adev->mman.buffer_funcs_enabled)
>                 r =3D amdgpu_move_blit(bo, evict, new_mem, old_mem);
>         else
>                 r =3D -ENODEV;
> +       amdgpu_bo_move_notify(bo, evict, new_mem);
>
>         if (r) {
>                 /* Check that all memory is CPU accessible */
> --
> 2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E5EC55174
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 02:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 856A110F08F;
	Thu,  6 Aug 2026 02:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H+2MNtc9";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1ED10F094
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 02:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlHAa8cIGz2ulX6f0ScFRwMpNQ/cmbsCL3RGCcBATNxDNlw3N9RdAYexzjVdTuYMfSCKW4B7kSQOFpPpwUeumxr7GJyhCmuZH533AQ8l5a3jmojXLra9G4y3wNAwU3yoszDJoIQVQTMk1ilkrzQKcVyTOpX2/Xu9nVdB7SyYBrGJGs3XhU+eikT5eb9jKYE9+71GJ/3j6HJA6rwOiC1wCytYwyuLMdjgfXZ0Rydj/zBxleX9E2tUCn4b6ye0H0/x9dU3mYML0wRxfwa7dMHWuElMsO8KcPSQMoeNLnnPaiikqdByJkCUNKw1y9xhoaChpwyLSR6oUTwrdkFXCjC6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9phcDgZpPxoyWlF05nFxDXjdvVmLHgq8aPWD4qFhLI=;
 b=rO2kD3uYCq7INHCmd7oUSFpOhklzezPzry+fkKJg5QVd5yj11FMimgQ3y0powPgTs8eF0EHrGFJEJUYR/NkP15ERJZNyl8rJJIu6ugr56gR9g5a17l+EUHA1mFZZ8AHqZB9A5HmpM+xBpeuM2RRUOfZwSSUtfc2HbwpwyX443N6XaSANXbl34VUw9wSLLYp1hiQVq3cq4JYq76DezYyp+y5Ra883wkZaHOTug9mwmXxqAauIfmpDKLcRBUDoWgLvzvQW1thWS7xjgU5DES9tc44s6mZmV5UnJieBSr7VjVpeC+DA3LIueMd2lbzzrQWgpRlC3Uwrcwf04WjEKNZFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9phcDgZpPxoyWlF05nFxDXjdvVmLHgq8aPWD4qFhLI=;
 b=H+2MNtc9Oer87AtxQfIPEv4Tb92tTa+wdQNj05l06ViNEpwDNG1OoQJpsEmM7jqBbAlIG4avbr3FWsOtjw+GTDycPSL1nEtwymSprA5fq6osk7f+Sv7BNh7Qv3lLU4vi+Kcqm2z7F2TYvLERcUxnSjFc7hbuG4FbBQoiB6w/mKY=
Received: from MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 02:37:46 +0000
Received: from MW3PR12MB4361.namprd12.prod.outlook.com
 ([fe80::f4a2:f8f7:8160:c277]) by MW3PR12MB4361.namprd12.prod.outlook.com
 ([fe80::f4a2:f8f7:8160:c277%6]) with mapi id 15.21.0270.015; Thu, 6 Aug 2026
 02:37:45 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Francis, David" <David.Francis@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: skip BOs being torn down during GTT
 recovery
Thread-Topic: [PATCH v3] drm/amdgpu: skip BOs being torn down during GTT
 recovery
Thread-Index: AQHdJLifkI8+Flq2YkeJKwaC4kZjq7aQTu3g
Date: Thu, 6 Aug 2026 02:37:45 +0000
Message-ID: <MW3PR12MB4361F042EFC6926F4B93143D9CD22@MW3PR12MB4361.namprd12.prod.outlook.com>
References: <20260805085826.2700421-1-yifan1.zhang@amd.com>
In-Reply-To: <20260805085826.2700421-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-06T02:35:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4361:EE_|IA1PR12MB7733:EE_
x-ms-office365-filtering-correlation-id: fe218980-cc58-4a74-8a55-08def363b2ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info: 0Gd7A/E7jCcE9pZJn7LkuiJ6GUP1/6zF5mTOnm33mzJuBZa3bH5a9IVlGY5JcC21GcWBqhfv4yBdX2ezUkrNSFo4rxYQRCAYsMa/D9BS7mtvM0x3A6EdfPZM5DIfpA7O41lfxR2tYjiP59+UTIOmYUMj63H7ZJpqw0Bk0DO3NTHoMza9rtrkzHa+Slx0z9RhPy4hPMVNTZBNXSwb7wVSXEpFulBYW2f5DprO3Sz9YHbh/dBtQAfn6/RGyFCav/KPgpUx5xiu7Nj6BxRD3mL5jMYrYlC+gAfIwb0N+n5YXordeNzZy9Ofg8lkGisr/QtLuEOeGrggdaeyWvKYhtULWigLMdmX+bYyM5Y94bcD3XlViahW/QlrChug9e/vYpenUbDFARRj2CLEhv9OpgzAt7xFFbLjQhLxT4PyUZhHhJ2hPCJni+PQGWiYArtvPvGE9o5FXd0rVDVDsa6vwBb5AnJWkJZPXDfvlEgA6r4HFTqo6j6raH7I6iz5FKW/jKcxo319HgH7kcNCKpy83Zi2/nC0xYqZCEG2eIJoNrgwECKhEXBiJ9GH2lfBaW4JLHQWWeem8E6t+YH7vFSYLvrs4IzmrDIJF0sI1ue0nDsnaM+eHemOjG5F0KcXlYy5Lep+OrKfVnTa2+nrKwlDaqZm7HtesjGpAhbM5z+e/HSo2nexSsRfw6aPpxVdW41zEZPAmYKHXLBoqMoHpTIhW/gBrLpuwmDM8Q+7YPo8rkqNHfA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4361.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ea8rLhw6KDId9blrfT/cwEP050YuSGfSgcdMOws4PxYKfvWVaAbsWCQbaYVD?=
 =?us-ascii?Q?M+LOMWn4dGeGGI/2n0pfWsfejZhaXX02zBJ17TR04nlCf1rKm8CCHQBTEYoX?=
 =?us-ascii?Q?o+x8AIl3d3NUph/uywHTu/c9U3jviGcMeFVLXqiH55qHoX2nSDy3iKri+It9?=
 =?us-ascii?Q?VFMkBjDOIGN0z34nJmd+JtdOVzDjodfN9vTiLM9LE2cRTPJp7hqo7xXcJKcK?=
 =?us-ascii?Q?GlBgHIHlgHy2C0QTno2mzPNVT9pPfSA7OD8jQkMXiVqY/r61dVAOO0mEMScf?=
 =?us-ascii?Q?fq0OhOFmIs0NP18RHmEHXHY2vYcxtZU8kDN1L8rqfFfcOf4dj2vjw7snMlAU?=
 =?us-ascii?Q?glOGTz9M+ecRnZXNyNBjZ69x2lk9xojdCXfXzdljd6qSG3lO7CXhmJ9lHUDH?=
 =?us-ascii?Q?PuXpLs3iyRcKMD4rNe/GEXrKYpAk6ulH70zFVZvKMgkmv5GkLKU664bRk+UR?=
 =?us-ascii?Q?LkD5uIbm4F+fOAC2a9g+P1zccjC4xlgQeYt2D2Ui1Y5oeG5cX37W820VV7pj?=
 =?us-ascii?Q?1H/nkTYBvJT9oj4wIB9X39My34/kW2DY0lfzL0qx6XJnYUsQ/+p+5YcAiuvQ?=
 =?us-ascii?Q?bu43nncgL8RHzZk2GfINsZdpf4wfk7CfiY9lfnc8dcdPtjS13C+KrzY+YKJO?=
 =?us-ascii?Q?DCHYECiN6iRwX9hcMULRL9C0I3RFt5+1Vf17eCneCyg3GxprRyZjHwhOK+au?=
 =?us-ascii?Q?YAd0d5KIBGUlYqiAUIXXYPROFkOVnz17CtdepFibKg86qjLhwpKqnEzvdL+w?=
 =?us-ascii?Q?a7ZUUNme8rO8GpTt6Qi0s/1vObBYQ3kLFfUF9emEXkxY6kqEJW9q/E9VW5wz?=
 =?us-ascii?Q?7k8Dg/rDUtgunYKe7NoPVNHAkLmjjCSk/BftLBOVqcUw3tHDg1qb8w+0rIND?=
 =?us-ascii?Q?mNDuel5AJHbPZqfymxZ1sBcBbo45uuQWHZz4EuS+OgYv9nlZg7SihWxoKi/n?=
 =?us-ascii?Q?hNZmy3Tm3lpB0Tr1gNQt501t6GW89g+gMPDqPdaTO9WtD7xzmYJErcp6Xj1o?=
 =?us-ascii?Q?bEgj8a3GnJLp0l7F3MRr938/27wXEZjBROvQ2x96qFFjFC7Y5bgIvF0F+cQA?=
 =?us-ascii?Q?M6JoX9rD+9FEgzZioO++S/kHhh4zSHDfNifBdIOvocze38tdzQFGd+EoZMfi?=
 =?us-ascii?Q?QJbNMaIiDeAxjhc+4Lt3u1MxQS6IGeaUTAUh+muOyxsKdbtIlY9J2+t8Y1b5?=
 =?us-ascii?Q?kD96JVeL4j/7YXhJpkCO8hLL5cTeExwboe2eCIj07DdIBUUaY6F7g4Fk/ERJ?=
 =?us-ascii?Q?/4uyeraXxLUbUwegL/b2Gx8819EGk+wnIl9hf/L0o1TBkOCtjK/2Y0oEAJAM?=
 =?us-ascii?Q?7ML2JwNhAhNUY2tTNuflFtRSLhsOFqbed8gsyzMrJEOy2dFxrx0T/UWn9G7t?=
 =?us-ascii?Q?5/yXASP6gcDJrAipTX7Q2+WdqwnwgCoTfxi99HxfeGizyWb3TG9dCqqtnNz6?=
 =?us-ascii?Q?ez8PmapbjtSEykyjBuVHXDJlvMMSRNAyJfVxPlFv8GLQQvCxdHcuzp0WGFjJ?=
 =?us-ascii?Q?RiFpwkm8yDPLfTr8HBZoj+XI5AMbSDiLaNnyzfvMztKmtzFNgXnnF4xdCVQ0?=
 =?us-ascii?Q?g0twaSo5IbB2IQOU/1j3AydToVkll38QHmmes2Ad85n0cnbOH8guMpSdYgjZ?=
 =?us-ascii?Q?f1OpDnP2V4nc65/XdQ4CoMsnfxZ1DM3X3x0Xvc1zA4ABuVduzz40FjFaIDkh?=
 =?us-ascii?Q?V6YMs67z2WwF595Wb1ylSWQLvKJ5DYYCQOz9VGdEmWRbX215?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe218980-cc58-4a74-8a55-08def363b2ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 02:37:45.7960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzijvCtOObBCjiZlgkBVuoe4/uGLfdq4WqmsAvmFRqcwCV7O3jHXa4uCUkxtlX1y6jp7sP10bTb0yo8k7XZM6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Wednesday, August 5, 2026 4:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Francis, David <David.Francis@amd.com>; Yuan,
> Perry <Perry.Yuan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH v3] drm/amdgpu: skip BOs being torn down during GTT recov=
ery
>
> A GPU reset can race with BO teardown after the BO's GTT resource has bee=
n
> marked for deletion but before its drm_mm node is removed. In this window=
,
> amdgpu_gtt_mgr_recover() can treat the node as a live BO and try to resto=
re its
> GART mapping while its TT backing is being destroyed.
>
> Recolor the GTT node from amdgpu_bo_delete_mem_notify() so that recovery =
skips
> it, reusing the existing color for ranges without a BO. The range stays a=
llocated until
> the resource is freed.
>
> This prevents reset recovery from accessing a BO whose backing storage is=
 no
> longer valid.
>
> v2: refine commit message. (David Francis)
> v3: Remove new BO color. (Christian)
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

LGTM,
Reviewed-by: Perry Yuan <perry.yuan@amd.com>

Best Regards.

Perry.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 23 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 0ea32561c4bc..6219233ff712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -102,6 +102,29 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resourc=
e
> *res)
>       return drm_mm_node_allocated(&node->mm_nodes[0]);
>  }
>
> +/**
> + * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
> + *
> + * @tbo: TTM BO whose TT backing is about to be destroyed
> + *
> + * Keep the GART range allocated until the resource is freed, but make
> +recovery
> + * treat it like a range without a BO so it isn't touched after TT
> +teardown has
> + * started.
> + */
> +void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo) {
> +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(tbo->bdev);
> +     struct ttm_range_mgr_node *node =3D to_ttm_range_mgr_node(tbo-
> >resource);
> +     struct amdgpu_gtt_mgr *mgr =3D &adev->mman.gtt_mgr;
> +
> +     dma_resv_assert_held(tbo->base.resv);
> +
> +     spin_lock(&mgr->lock);
> +     if (drm_mm_node_allocated(&node->mm_nodes[0]))
> +             node->mm_nodes[0].color =3D
> GART_ENTRY_WITHOUT_BO_COLOR;
> +     spin_unlock(&mgr->lock);
> +}
> +
>  /**
>   * amdgpu_gtt_mgr_new - allocate a new node
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c4094edbdff1..a9067305b26d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1694,6 +1694,9 @@ static int amdgpu_ttm_access_memory(struct
> ttm_buffer_object *bo,  static void  amdgpu_bo_delete_mem_notify(struct
> ttm_buffer_object *bo)  {
> +     if (bo->resource && bo->resource->mem_type =3D=3D TTM_PL_TT)
> +             amdgpu_gtt_mgr_mark_bo_teardown(bo);
> +
>       amdgpu_bo_move_notify(bo, false, NULL);  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index ff9e2e346609..af1e7fcc7175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -145,6 +145,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
> void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> +void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> --
> 2.43.0


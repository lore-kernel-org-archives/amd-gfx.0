Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E570C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 05:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5992E10EE76;
	Tue, 28 May 2024 05:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rMlAYMWy";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0790410EE76
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 05:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOc/W7HltRaTMXIwWrzcN/gac6XQdxajby5inNhi6GU0LzXJhJLEtod2al3MMejFdiU8+EhN9CxU4Vps1kYXUw33BrpgL1NkmQ21Mtpnk+Wt38fE+ES5Go3CGaJXywqVMarU1GQwp2VUtcLwll88jhmkJSxuTCfRSwhEE4fQ8NDiRWHtKJ4UmBfWmQPjjdcCH5utUziLHRhekiOzeZOun4ITPg+MCckWKa/t2uHtlU3fcccbGO4JQRteT2DXnz2auA3TZdmNNQ4Her+eWgSd9nL0S+riMg2fz8lpAtcAicZ7mN4DlchjKXcjmfYdohDxy25ItxkD5lCyhiKqQyOZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmHmiUsakShA+Xw3NOr6Ub3zech3zgoHyj5mSkZJtE0=;
 b=j0GJS9cytRj86NW1cB2GPyM1cK0OLDtQvBUmG/4zTabxJDuluvwVkL0f2nkaOvWMmd5tmetd5aUrZXJsiNGwyOu6lKJb1T3QWbYOMFGBvIk3AANejibjCB2S6EdH10X6KHsW+OZAOsDareIrEEeJyXegKcWVO5iGGUNVBCVAMhBjWhD/fZQvEAck68N/Y8Xgth/Toq7Ml+eKVQyFlln3oZkAKI8Zr8ik8U6CRqyIgEUsZ2ALc2rU3yVCr+1rJtYxiaHtXTbPHYTn+TyskffArcb0VOimhmA+yKAP32U33F8BXXF7V+YUY91nLNmtRj1wfBJx9J7tlBgk3RIknqLFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmHmiUsakShA+Xw3NOr6Ub3zech3zgoHyj5mSkZJtE0=;
 b=rMlAYMWytdc97CRKE3W6F+wo64N6Xci2Cn1uBUf35M8tzXiUdNdINSS2jjKNGtBFKG9mXqBZM2YGaWmSEKVu3jWYmGtUdoOR+IerJTjgqLw8eY9XwWyOn3EJixTtI1m0vmiS3+k8pf690eYl2SIYIylrxuuwP0s7e5Sp3dSzQPM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 05:36:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 05:36:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity
Thread-Topic: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity
Thread-Index: AQHasKXdmYpLF4tK/EqxsHhymg1ORbGr778AgAAvbLA=
Date: Tue, 28 May 2024 05:36:57 +0000
Message-ID: <BN9PR12MB52577BF5D9819BD6F15CE6E0FCF12@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240528022051.27099-1-Hawking.Zhang@amd.com>
 <PH7PR12MB8796C4D9039EB457342B604AB0F12@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796C4D9039EB457342B604AB0F12@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=41a2dad1-5f91-44ef-ba83-a6dc24bcf7d8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T02:39:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB8083:EE_
x-ms-office365-filtering-correlation-id: 08a7fa37-624c-4f86-1f2a-08dc7ed8308a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?P7wiKHLSdprW5sv1NRH9tT1E/Kj4/QOtfFHkb21sOAUPX5jdMyyZDdJwpmGt?=
 =?us-ascii?Q?QB3P2Om038J8AL1jFByPwgldv2livGapWRIrLUpy6s9C9IygXOYrdCLC40ng?=
 =?us-ascii?Q?ojk6H1+GtHf24Nj8lEfIxzGIggV4DSad8d8mPbX8RjQbb5Q6o0fXQKse7Jmg?=
 =?us-ascii?Q?pL745uryU68+4Tlrijl+hTejO+hKUidtbAUUxdX+KcTYEeNtcXISK9/4A23C?=
 =?us-ascii?Q?ybs151d2MMesZ4GZMwdHlBCpuwHEk7WmmrQRCz2LSy9PcVmEn1sJdwWQQEyI?=
 =?us-ascii?Q?dBjWDyhjoycm36QBfgihV9QV0jag5v92Fg/Ebn99a4cfdm3nyvfETuXu3Hg3?=
 =?us-ascii?Q?p3lHCjoZLlEs9/3NO12MrPdESur628o7Fa1F0h7wndEkojd+Y07n8lh4qwyw?=
 =?us-ascii?Q?ow0a01znMzN7SAaSR5UuEUn4c+pPePH3OTHdlrx39+Ux1MIGHAlW89zu55RY?=
 =?us-ascii?Q?RExRwAmW9l11xK1pMM28qnmejWXG0fI2Iv5KRWNT7mOVidFlS9s1m0bv6XBh?=
 =?us-ascii?Q?IvB/iclwXkmeu+36mm3HIjDJyf/1nx/ngHr5qciPccB5OosV0qA7H92jmWhg?=
 =?us-ascii?Q?2S3vpT1aFlnEU7P5xRyQB0aQsI6HyrtKgpqdEZuMvdwWT4sqSW5G5fGEDCGm?=
 =?us-ascii?Q?aeiBxdfjA8WudGEtVuinXM91+8A6sQnsY9t9OnRxSY1raQf4GW87gCvU0bPp?=
 =?us-ascii?Q?P7BxlhJ8j4ACJjVkVChoW52LwkYglD8yBsxnoq7/j4fgqrDQj3rpsE9SvdCD?=
 =?us-ascii?Q?B0ZKSxwu2iTqK0lMXP+jwxkQIqJQSsjNJAhDF/zlVUKhgzKb4cQU6+m5mgWP?=
 =?us-ascii?Q?4b/OClXVKl97p1RkJ0sQIuBw6WzmphVvVGjjxG+3qxBnRggsEDdoNA+9Q6cg?=
 =?us-ascii?Q?KHjwhieZI2VRkGyyS8eprSOMFcLmB5FGBVPaV2jARs3N6M2ccDzIzGifDP0R?=
 =?us-ascii?Q?BhdaPcspKajZNpVIZiAaK64WjI3H2r0+BAGOUaUib919M4N4jdEnbtRZ0KNJ?=
 =?us-ascii?Q?5b29+TTpWoEpFAodxUEpSrCOvcTfUgGw/pshI/bA2gc1ryPZFm+IakaMWUpI?=
 =?us-ascii?Q?tJObBKJU+Tt+OEQUdJpmfQl6CoRgQsJIbGazPyaHCbzbMSUs+FIJ7vLUNaEF?=
 =?us-ascii?Q?Y6PCikF0OHz/3/YCTWSlcXF+jq5oReYYPDF1ZmTjvKxJELFWtzafAowl0gfH?=
 =?us-ascii?Q?OvkKXFxaU435JKrBwr/r1zUachivTeYxT5fh4aBrxWAdguiGZipuU3kjEl3/?=
 =?us-ascii?Q?pRxMLFCbfk1SnG0kFf7S2MayZKn6cJ7/eJ1t18qMoaD+gi22VKrpnX42v85C?=
 =?us-ascii?Q?lCfCZLetWsaJuIbbhhUBJPOEGlv7L9DXsyC2fvPKDYym/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xznM8bzelrt3G1WlNXVy2AkX1o3Hq7kyvWRrh2gG6Rf5W9wC0RvD498N2UeK?=
 =?us-ascii?Q?kFpnWK78sP42akQPSi9XCb9GJGTPo7rJ+HcgPC7VtqzyW6MkZyR/qE8CLS9L?=
 =?us-ascii?Q?dOikAgPjUS1Bz7W2PeQb/sxpaUblVOQDRdNXpSzyf6PeVEH1CVPk2mLtcnhk?=
 =?us-ascii?Q?bU10prkVzxMF/wVVp8y/ub4LCKggBQCzghCs8ISbT3a+p4kfvNQCxTF1OUVL?=
 =?us-ascii?Q?3BbcxYmrqtlApWyVLM+lIMprlDWTiIyws+6/bWeYwwNX6woVYeC3of7q37Pd?=
 =?us-ascii?Q?jIx0wL9lRSm7AIxP5esYhx6LSeXk87Zh2iqElRGUaZz2z5HHogrxhtSRyoDq?=
 =?us-ascii?Q?h+zaOQdrB+8qhjg/T2rciAToFNNW0pj3uXkSJR8HJN6giHKYE839JtloGB3T?=
 =?us-ascii?Q?1xqvw/5yfY4a4uTOegtlba3FNVJKEFNmRL7o83D1yfXXVRA/5K+kd7doSr8e?=
 =?us-ascii?Q?3krx2+BsuXwQ13ulbsnTaFDmDWhvA3Q0KbWyBl7YO2sFRc7D4qujeB0TvPoW?=
 =?us-ascii?Q?BjDZz6n1uQYmBHEGrcy4JA6UZBJJxY8hD2tEQuZMt6mjUHRLGsl7j98vnfem?=
 =?us-ascii?Q?IsAkZXxj1ELgkvk/tjr6lGl3jsYPiKEOrz/QySBKrQTbGREqs6Re0XWMHrN3?=
 =?us-ascii?Q?T7GlAvslk84WdrhCvlrm+NZAuCWJZvS9ej8AE/F63F+V+31yEMdvrb85eXHY?=
 =?us-ascii?Q?+lc4+A/BNzpyESgFpow/Yi1iV7UexzJpvaFh634DIvZSH6fprm7rZwi8pWzt?=
 =?us-ascii?Q?oIdL+xGIYcEjsVH2YVUCGa9FSrPxa2iECKuvfSp7eHMzVO499/bsZ+n0Rl1e?=
 =?us-ascii?Q?SClUsu8+C3KifC1F+18kaVZ5tKhv7C9g1xAdj7lRx0RyYzvJlfXHqrhF7/6K?=
 =?us-ascii?Q?qfwHqjZ2A5jefUlKRB7DI1ST9UYJfbq3G+/Cyx65q1mIoj34qleB65+nmYXz?=
 =?us-ascii?Q?Z0aCEDuTCSBtV9cmYiR9/T6VXDX5OAfTsj4FCRMLyHZfYDBbZVT6vrbgF+6D?=
 =?us-ascii?Q?vwkTph81PoSOdoy+GSnf13v6a7xVY4JWuAYBT05F10ybkZHdsnFX3XcMf7SZ?=
 =?us-ascii?Q?+3JhIFFKrBLRjx5xrzBBrrl7/uyGxnpAM5TBPdVLkBgdT4KQenRJsdjeseDa?=
 =?us-ascii?Q?w10CqnnPZBroNNH4X0UY+/jFBWEuQHLq6pWLQytz3t3DPrWRmm0pVGerKFh+?=
 =?us-ascii?Q?e2Qet1o2oWEpDKhNv7HlP3pSOjmu7N0o1gYVDgnZW/kAdo76X55T9s0XucBD?=
 =?us-ascii?Q?5lZjQiR+iOelxHkztTvWZikbVPHwwK9vG0F8dOa55f/CzGdcUZbQkdzdmNbu?=
 =?us-ascii?Q?e20Qhuf/1CFNUUiz33voE+QaS4mwaWs4jkH6zuzCefXghPznuEH4qcJb6lcf?=
 =?us-ascii?Q?QPK8sOeiWumSwckqi1tQ12mqdusv8gQ3sjrQz0/DvnYLJVm4W4lqNSPQLhb3?=
 =?us-ascii?Q?zngsa6xXIoehTwUhdQVMwV7ItURP2eLaI9AFI0AnItUlu8U9N76Ebl7h8ALp?=
 =?us-ascii?Q?KadScKEVY9N8Si0veMxSnYUdw65XJmNxibqpdDZ2kXXHpk3Zt0W3a5AJ6Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a7fa37-624c-4f86-1f2a-08dc7ed8308a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 05:36:57.1859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xo7hHC6odUlmJpsdq+kdeBRceoDoCbPuQhYoj0D4SX4ixpRimC7COA8RRGHVAWMmgY44jYcSWfiiYz5YAfmvhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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

Hi Tao,

We don't plan to apply the change to gfx adapters. And it's only applicable=
 to aldebran and aqua_vanjaram. I will add back aldebran in v2.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, May 28, 2024 10:41
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish <Hari=
sh.Kasiviswanathan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Estimate RAS reservation when report capac=
ity

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Hawking Zhang
> Sent: Tuesday, May 28, 2024 10:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Estimate RAS reservation when report
> capacity
>
> Add estimate of how much vram we need to reserve for RAS when
> caculating the total available vram.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        |  2 ++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e98927529f61..ad813772f8a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -173,6 +173,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
> amdgpu_device *adev,  {
>       uint64_t reserved_for_pt =3D
>               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     uint64_t reserved_for_ras =3D (con ? con->reserved_pages_in_bytes
> + : 0);
>       size_t system_mem_needed, ttm_mem_needed, vram_needed;
>       int ret =3D 0;
>       uint64_t vram_size =3D 0;
> @@ -221,7 +223,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
> amdgpu_device *adev,
>           (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>            kfd_mem_limit.max_ttm_mem_limit) ||
>           (adev && xcp_id >=3D 0 && adev->kfd.vram_used[xcp_id] +
> vram_needed >
> -          vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_si=
ze)
> +
> +          vram_size - reserved_for_pt - reserved_for_ras -
> +atomic64_read(&adev->vram_pin_size) +
>            atomic64_read(&adev->kfd.vram_pinned))) {
>               ret =3D -ENOMEM;
>               goto release;
> @@ -1694,6 +1696,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct
> amdgpu_device *adev,  {
>       uint64_t reserved_for_pt =3D
>               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     uint64_t reserved_for_ras =3D (con ? con->reserved_pages_in_bytes
> + : 0);
>       ssize_t available;
>       uint64_t vram_available, system_mem_available,
> ttm_mem_available;
>
> @@ -1702,7 +1706,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct
> amdgpu_device *adev,
>               - adev->kfd.vram_used_aligned[xcp_id]
>               - atomic64_read(&adev->vram_pin_size)
>               + atomic64_read(&adev->kfd.vram_pinned)
> -             - reserved_for_pt;
> +             - reserved_for_pt
> +             - reserved_for_ras;
>
>       if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>               system_mem_available =3D no_system_mem_limit ?
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ecce022c657b..a6334e0e62dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3317,6 +3317,22 @@ static void amdgpu_ras_event_mgr_init(struct
> amdgpu_device *adev)
>               amdgpu_put_xgmi_hive(hive);  }
>
> +static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device
> +*adev) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +
> +     if (!con || (adev->flags & AMD_IS_APU))
> +             return;
> +
> +     switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +     case IP_VERSION(13, 0, 6):

[Tao] can we apply the change for all ASICs which support RAS?

> +             con->reserved_pages_in_bytes =3D
> AMDGPU_RAS_RESERVED_VRAM_SIZE;
> +             break;
> +     default:
> +             break;
> +     }
> +}
> +
>  int amdgpu_ras_init(struct amdgpu_device *adev)  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@
> -3422,6
> +3438,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>       /* Get RAS schema for particular SOC */
>       con->schema =3D amdgpu_get_ras_schema(adev);
>
> +     amdgpu_ras_init_reserved_vram_size(adev);
> +
>       if (amdgpu_ras_fs_init(adev)) {
>               r =3D -EINVAL;
>               goto release_con;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 6a8c7b1609df..bee622c4268a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -64,6 +64,7 @@ struct amdgpu_iv_entry;  #define
> AMDGPU_RAS_FEATURES_SOCKETID_SHIFT 29  #define
> AMDGPU_RAS_FEATURES_SOCKETID_MASK 0xe0000000
>
> +#define AMDGPU_RAS_RESERVED_VRAM_SIZE        (16ULL << 20)

[Tao] it's better to add comment here to explain why the value is 16MB.

>  /* The high three bits indicates socketid */  #define
> AMDGPU_RAS_GET_FEATURES(val)  ((val) &
> ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
>
> @@ -541,6 +542,7 @@ struct amdgpu_ras {
>       struct ras_event_manager __event_mgr;
>       struct ras_event_manager *event_mgr;
>
> +     uint64_t reserved_pages_in_bytes;
>  };
>
>  struct ras_fs_data {
> --
> 2.17.1



Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A238BC25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 06:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F2710FD4B;
	Tue, 28 May 2024 06:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nwSsesYS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC1610E034
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 06:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUwtRRF0bCFNqWEEqPAijI/39szch3X/9oAWnvfQ1qxK0fjIFpoGVPeOGhKxVV1UIZOiGLH9IcDCa5E2UHqnjOc7O8R0K+TdlYxpvRDsdVlF2pBKfblCK9KGfDeeCebVbEw00ozKdFLm1VVeMMvYhBvDJgK0W/gvyyX9eGhp4s7GVspXpjWA8/1vtYN4t4+uq4mu5+UP8OvX9K3k7cUWhLSGCBc+bAr4Y0kQHkUD+3cwwIu7nnraeGnqB7A9zM8N3A8dNT82Gczs57zWh7YfP8iLYLZziueRb99qpCDaS6tNTudtw+ixQ2X75T5VkWH/h8gqLUswFeWFo6ZxDDZzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUto5/3xY60sk1juqcKCAN0hHY680fhRy9pJZZtsBCA=;
 b=NZ8IZJd49uDfGC1UPKje+fCTrgfuqW419WB7mXtYikBquo7B+RRnUiGwT8nsADCHgSE7c13SyI9TMOkMbn3RT7eqmGP4P16IzsMF5gxKt397cxb1wiQ3Yaxom9aUiQ8F8Ycr91wG0pH6p/V7vbZZD5f2RBEzHCGcbU4uYhov9r/3ujbbR12gusxO+GuctFVfwiMzOFE1ARG5mPPdAzd+chsEedzzmZwiCBYctHyjkyfilDY1OsvO80za8LWxglr0HsQ4RF/Io3k0G6nc8Q7kbUnxW/T636bVLcREIZhz7yjnEJFZJeAro7LuWpzBo/uNCwQTSjsfFIgPzBBGH6/myg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUto5/3xY60sk1juqcKCAN0hHY680fhRy9pJZZtsBCA=;
 b=nwSsesYS8E2LTGCQ1w83xIKLTmkus2brpwRwlVGDTQUMV7hDRyx7deEiYtBynuXKkeKMay1crx7d87UcsjjCY0WB2TwArAua93mjpR2srGoGRxb/IxD0oCBjiusJnRfED6Rfs4XNH2sVx737F8fglR00aUlqvwbA9ACm0H2ICCQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 06:07:41 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 06:07:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity
 v2
Thread-Topic: [PATCH] drm/amdgpu: Estimate RAS reservation when report
 capacity v2
Thread-Index: AQHasMP0Qcv6DlKHjE+q7yvKQvBA2LGsJ6yAgAAA8pA=
Date: Tue, 28 May 2024 06:07:41 +0000
Message-ID: <BN9PR12MB5257D9CD67BE0F02FE731A83FCF12@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240528055721.27848-1-Hawking.Zhang@amd.com>
 <PH7PR12MB879690F3B337DF8B9934A297B0F12@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB879690F3B337DF8B9934A297B0F12@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=73685698-2f20-48d3-be98-f5d5ff03c302;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T05:59:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB7907:EE_
x-ms-office365-filtering-correlation-id: c9fdbebb-13c8-4330-b389-08dc7edc7bc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zdg/Lgy3KZMd7OqItTRWaIqLeVRqrc/9szIynNOsBlYgI/hnEkGm4zMtTqkA?=
 =?us-ascii?Q?MUUxeVu2biV7BT4dNoqqAiCXzpWlVN9ZWM3EA3xlqjQ//a1XkcrAi1/LYflL?=
 =?us-ascii?Q?Z7qCF4OMCPIFQ8ql/xC3qChIUluUnVLcAElwXwqOGVMWp305BADcBVyqEwSf?=
 =?us-ascii?Q?lMqnfIF/iV3biW+INL2gNyEe0zwtlOWqfB67+jeNRJwWXtRsU1qnKy+Nk79g?=
 =?us-ascii?Q?8iO94n+HeMqVkIWONKUjvAVCcr+oa9olia1g4NtdMCYDhGiF/J6KuPwX/1l8?=
 =?us-ascii?Q?aILxvafoa8YLcwRoEyjuXn0P638j1nPhOLLbakOBYbR8afr/NjUoYlWhphPG?=
 =?us-ascii?Q?UVHrZmPBUWK92T2/oBU+OpLogQG4+9y/LSe5+oItI/2Oq0kbEIaReY1on+T/?=
 =?us-ascii?Q?HN4VCQzJI01DtWZYtb8WLr4IWUsdcO5rTzwSw9BaJjPo3CLHFlgDLgxKDiJ4?=
 =?us-ascii?Q?RuGBycYSN75846O0q9Xqviq2t329zi1XR4bydv1pqUId09hKP2DX3x94iEq3?=
 =?us-ascii?Q?fduz84xdQWvL924D1FAiIBXFxvfa+WuAv4vVgNd0QCmv+43oMTgrjNFJBx1/?=
 =?us-ascii?Q?xwYVdTeBSsAQF1ZcFEyLxUso+QWbA7H3qXMByPM3iDYv28+GPSmlIfrtv5Mz?=
 =?us-ascii?Q?u3owMrGSXOOA7M7G95X5Xnpq7l6tkDk9RXsT6kzg+5wurGgEfnDQdglZepaD?=
 =?us-ascii?Q?prPdzd+r0aO81Tja2rMlMY50c9nfCRE5Dy4VdLFTIq/uCbOtSH1TNWJZUEcY?=
 =?us-ascii?Q?jPHRveAbAv5SrugVKUre2Cttz1zP1VDyuFq6oHnZLLgsPN535C0In17/FSkB?=
 =?us-ascii?Q?aDhuresF0owJVfcPoBtWebxb5eST0iZCVnMkI24jOjIA8A78YG66sKXSeuXp?=
 =?us-ascii?Q?OHhInalqgkBfbv+47uf8qMEiA25BsEsXj5U6PH5BFeaNuOPsLEqRtXsb5eZR?=
 =?us-ascii?Q?S+qqShmSf66TcdGLtDG64McWJrA8JN0UAhcu4dbuW8gWVjXPbiAV1hgWy/p8?=
 =?us-ascii?Q?PI6MxOdAk5Ue/PXQ4Zhlsf86kZNGZ1K/UpP+BPfzy88KKRywQBR6W+6vITh6?=
 =?us-ascii?Q?g9kocRh/79e4zwUTVQ1StRqal/jkdyCQdtw/LuR77EJXzFmBaYQSmAmfFyFS?=
 =?us-ascii?Q?ylPQBn0woL5gxpTLeG/l7L3qK8W7UKmt3Z+NFgdGIVGDzK27lmgkXbMiQuKY?=
 =?us-ascii?Q?Pki1Ow0o2uJ4eNBkpnYEfDiiHmxTHHAzzScnG6JtB5QYv8o+JL16Jb1/0M8/?=
 =?us-ascii?Q?aOljmhCGfxGqzy/+Q6N5L03x78ny4JY6c8TYNBYmazd6huC+oMZ7mplHLevE?=
 =?us-ascii?Q?6YqhgHB1bwMOCQfJaYu1e0ZYpWbvYpLQ+MpW6PPpAaV7xg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bP5y8FuzUbRvelfIyv8er3wkpkMEOWAhC97Ic1gd4XXcipREnFjdh2jmcrVI?=
 =?us-ascii?Q?kiA7hubss3Tev+S4zc/DDNQ8HBctMxGka4RMsesAGjpMKVsKkAkmX+BNGeCP?=
 =?us-ascii?Q?wOLaC6j+PTqDnR9SjiJR+nXara/+A32jROFi5xxeCQa/oDU67caV65OGZgyZ?=
 =?us-ascii?Q?x2eRs70kEZAeK1JiamAUD9HKeALe5tGDxzUjI9SkL7np/Fyul8Ua3wM3sr0T?=
 =?us-ascii?Q?dfbxSYjnvojTY7NHbOLHhhQioShAgZWSqKI88LZYaO68X+hlELKfxZmES0Dk?=
 =?us-ascii?Q?xMyFBAt/dAVb+faRkqYNvFdUO2F3xA3ITGb9X8XT++tbNfs97sHvk1E6wIEv?=
 =?us-ascii?Q?hMHhMSlF4vWy2daOa1kVH7VJdxF9MqftlJXfonlSZmW1LQeWR755ftsPfGcr?=
 =?us-ascii?Q?Kk6nLTCBFEho8dW60izu64CJeTp8R76f3jzdLNads6eMX79T3qvYX73FDRMH?=
 =?us-ascii?Q?KbgORNZqT3anQbAHIV9NhElR913R1oTdKvarZAWdWMQJj3dyvE9PTPnbX8Po?=
 =?us-ascii?Q?5xEWBoBKAkzOJknKk4wiBR19qm0xErSnNfGgc7Zl5g8q3mEO0veZbmhdI9Xe?=
 =?us-ascii?Q?TuLQCkQP7N5t1errDgtYIm+/bQwigwceDCq6eFxWL6BPqqzctn+bLrZfy/9P?=
 =?us-ascii?Q?6DloiUJFxCGWwSMATRh4sXbI9qNrxuhEx0M1K8GesDr0JaJPL7EU22aLRY+v?=
 =?us-ascii?Q?ql9VC9YzSSaezNobBwJPlthW14l3XB4zioz0byD5JEjp9j0pP5wxLOKHd6Z6?=
 =?us-ascii?Q?OA/3p6fJ0oO39CU4rTA6ikfpfLIxdUwBRZ3Qfj/qPb/OsqrWJvTfseysHfl2?=
 =?us-ascii?Q?62w0DpP8ioNZFDyw2X3N2tY6BI3M1ioSHlhGqmvLoeHsUo6vqRBLKvHAj79O?=
 =?us-ascii?Q?AMNlxbDg1Me9Gjv5Xz9rGktU72uCp12P13wxR4vbRymgGsydHH2oJLHVxag2?=
 =?us-ascii?Q?0n0xsTlejj68RDBrvM9WUWCvlrGhWxWZlYSw6ua5krG8es72d7EtBqM5RMEi?=
 =?us-ascii?Q?txuj2Ja7Rp24ObAX0oAp+1cfFwnGq1d4Z8XnPfxlBHWaBB/XKkGEPrkrm1EC?=
 =?us-ascii?Q?y6IXIVeuBwjC90g0jFFyIf97yH/2WuEARO1DWPv82wPoE2E2neIUO205KLL+?=
 =?us-ascii?Q?BQ4ynkGIE6m25GaqaF4vuNuowIfafGFt7F3fnqCJ8myvbg6uGAMXsF/hPt4O?=
 =?us-ascii?Q?afT7NdhVpLesUqMGIYRw8eEpDcLGgOB5Y17xpc/ekZWI5oA8LoKCRPqxS0wv?=
 =?us-ascii?Q?X4kiGQpe2oXWKfIjOxOr2U0QwQBwYlPAQkmTqBZKkGtBQIkjgKqC2vx9qhW3?=
 =?us-ascii?Q?g087K592m3yGihn4WZldixfuAhJuhR7uLYZk21ZDgxTEqI0FoN+iZWmEHbKp?=
 =?us-ascii?Q?LlT0wfY/OVOeWDp97H0L8uurPemC/aEXdDhvcfZB2/inGM0Q51PnHeSUWmiy?=
 =?us-ascii?Q?s0DKPcvTWFdhAezPq/5A8gTDJPW7WukTYNsttoNyoXtakqwj/Uk8KEib2qwM?=
 =?us-ascii?Q?CcBXBZ6YuN34xaDmGPFYApsP+DvZ6YbhAf16uykIKzDy8C29LOWA0IgwuQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fdbebb-13c8-4330-b389-08dc7edc7bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 06:07:41.3591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 734LZfDMKhOGjMP5hGfGwP3Opqw6xsFpLjS4z1P37K06SB+rmBSXFlDsCoDEkkugCku7AEB+vP8toUZ42lY0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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

Thanks Tao. Yes, I added the comments to amdgpu_ras.h.

+/* Reserve 8 physical dram row for possible retirement.
+ * In worst cases, it will lose 8 * 2MB memory in vram domain */
+#define AMDGPU_RAS_RESERVED_VRAM_SIZE  (16ULL << 20)

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, May 28, 2024 14:02
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish <Hari=
sh.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Estimate RAS reservation when report capac=
ity v2

[AMD Official Use Only - AMD Internal Distribution Only]

I prefer to add comment for AMDGPU_RAS_RESERVED_VRAM_SIZE to explain the va=
lue of 16MB, anyway the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, May 28, 2024 1:57 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH] drm/amdgpu: Estimate RAS reservation when report
> capacity v2
>
> Add estimate of how much vram we need to reserve for RAS when
> caculating the total available vram.
>
> v2: apply the change to MP0 v13_0_2 and v13_0_14
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  4 ++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
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
> index ecce022c657b..f28bf5765380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3317,6 +3317,24 @@ static void amdgpu_ras_event_mgr_init(struct
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
> +     case IP_VERSION(13, 0, 2):
> +     case IP_VERSION(13, 0, 6):
> +     case IP_VERSION(13, 0, 14):
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
> +3440,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
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
> index 6a8c7b1609df..bd61f77a7134 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -64,6 +64,9 @@ struct amdgpu_iv_entry;  #define
> AMDGPU_RAS_FEATURES_SOCKETID_SHIFT 29  #define
> AMDGPU_RAS_FEATURES_SOCKETID_MASK 0xe0000000
>
> +/* Reserve 8 physical dram row for possible retirement.
> + * In worst cases, it will lose 8 * 2MB memory in vram domain */
> +#define AMDGPU_RAS_RESERVED_VRAM_SIZE        (16ULL << 20)
>  /* The high three bits indicates socketid */  #define
> AMDGPU_RAS_GET_FEATURES(val)  ((val) &
> ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
>
> @@ -541,6 +544,7 @@ struct amdgpu_ras {
>       struct ras_event_manager __event_mgr;
>       struct ras_event_manager *event_mgr;
>
> +     uint64_t reserved_pages_in_bytes;
>  };
>
>  struct ras_fs_data {
> --
> 2.17.1



Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57156D1CA37
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 06:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0187110E010;
	Tue,  5 Nov 2024 06:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hhyY1ww2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415F610E010
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 06:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob/WwIkT8liq5ivsMQ/vwIxKYiltcWwDuAcAkwX6M7imhjlz9EYVaW8s95Chk159rlAzFhL71ayaIWmNZq+pohIB/7txdaxFQV4VjJbXvR5yCskqc8nFVe/I1Ey4T4idEA5Mkudf264jLFAcBM8NZQzoDeu09RJTojwlH1D8rodv+rXi0l7z4sFVJtqenB6MzrJ3io15IJ0qhRQnqxOPkA/OiNe1VExZ8Hhe1qK65r8jhHbpxbX03/c3cuLmAwF2j4v9iSdU2yJ//+hVzdUj644N60l1nAO632LwU7rHYQMJWB91OE6ZDxdYDyWQlG7EORRmaUEBpH3tlYUohdm+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za2l75IIG2kf+o7IhMwMiAd5hVB6joIp6bXNInBE6k4=;
 b=NLVBwFPJvBDBZrnzU9dR3zpFt8+rENh4kTd14YXIcMKAixotTmkUAeJHiu+9j/7y1tt9IhVIogbttBsxwPbYNh2LMhJV59myFPdnhY92+JyRQrfiGv8n4iXfOoIccJmpBIsgQu3wvTziC5cKQ1zzUmAoTju1yY625XFXtmH6HVAFWoT5eTrhAyn5pCB4cL8BmtjnhNd/iSGQ0vy+e9W28XUBVQKCIlS169PUvLdr1ykjKNHS48+Gd/s8+9rffPajBod43or0aUhz8P0b8uvQunDhHPMvepQmqPHV8xRO5S8AIXi84N+0yF7PzLQ2o+9EuRf6liyd+xnVfirHiAg5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za2l75IIG2kf+o7IhMwMiAd5hVB6joIp6bXNInBE6k4=;
 b=hhyY1ww2MpIv0XnOQ0v1OG/Kgd12FrUbbVDG9t+c70VfCzHJ8OknOTWaiaiA97gT2TTwYYfXLPfKEhlwSOjhoiMYZ2WDj6UXQ4uHLr66iHUOFyazzbcIM98HVmwwRFCtYDC2sypAxT7RYlZ0XU+g2A/6bs+WzocFzcD01rJqKu4=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:15:32 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 06:15:32 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
Thread-Index: AQHbL0UqEtUbQ7pfJkORFMCv7JyWWbKoNEiQ
Date: Tue, 5 Nov 2024 06:15:31 +0000
Message-ID: <PH0PR12MB5404F8E5463D0157BE13BC32F6522@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20241105053844.3242241-1-lijo.lazar@amd.com>
In-Reply-To: <20241105053844.3242241-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=67f58c5c-f75e-4b63-aaae-9ab918b864cd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-05T06:10:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|IA1PR12MB6329:EE_
x-ms-office365-filtering-correlation-id: e35dc31f-2992-4346-185c-08dcfd6140bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?F1kVwLy9OHsR53P8wEijoSYAEd0TKLMu20WXHEiYGH11+qW4RAi/7rOIzOWY?=
 =?us-ascii?Q?XK++t6AyXZnKDLnURTk7Ab07auUwK5aHZU6kFKFoJZQ9hF6ZWsNRSNPc+Pcm?=
 =?us-ascii?Q?5ZzAeWC+KL0VWPLcD4Bl3y1yyFu2nD8g7JDMRVv2wDOUZCyGVS2HmSY1MJil?=
 =?us-ascii?Q?0r4Lh/kQpibz4YXyJuAwFAmcTp+1P3Iqhcf4TUBBcjTB0vt5oqJLNiBZSuXJ?=
 =?us-ascii?Q?zqUCIZZys60et/LKoGRskrxXVYOWGJg91Fot9K8R08cBZQxsy3RC9DhMgj2F?=
 =?us-ascii?Q?mndvoM40Tllow/XUnH9M3rnab+oaKIz771UKMIYR5W/IAWhYQ0XbQmlbTmlC?=
 =?us-ascii?Q?dzkC84gzZzTaUAYnYBQzf8ybVcMCfak6L2rAoDxwVoclWOUVhJjbflQD/Mn5?=
 =?us-ascii?Q?YgdNq+nfyhVtlGHfb9WkLGGSctOnJAmB/+u1huuEe8s5TvOG5kvk0z7u9DBb?=
 =?us-ascii?Q?HycRj5UXoKFpjsFCkoW6gd8Kk2gNW6IfKidxLo30GeRS54tLMg+hBNnljq8E?=
 =?us-ascii?Q?b0rHPy9VIQPEXbvF3+BQLJYTsZfbemLisMDMR3L4d1OWfWX3CXfY5L1D9h26?=
 =?us-ascii?Q?Ij1GnVaP3hZoCzex63/KoAfj+ri+3KrKYKaOh9tjLFUi0NbBifHOydic8uqa?=
 =?us-ascii?Q?Y4Xbw+9nzxLLZjK4DB69cFfOA3IIOtLc+PgSfrM/I3QJ67PvlzyQXijV04P0?=
 =?us-ascii?Q?+YNXi8nB8imnzSn0+LI8mZfPFfRAhF83HjfdkPhFCcOeQdBnHub+pMJY5orT?=
 =?us-ascii?Q?TEE7CJiKo/YCO6m1gkU39D+Tj6SNTFlExwoRg/RBkbMfMGjn6Jhs90+qpFIe?=
 =?us-ascii?Q?KBJ/tNX1sz+UZUcD3QU7N7jA462YVF1R51QRdNNFPwMotAaGymsDDWPQDBhp?=
 =?us-ascii?Q?LWPlbkWDExBgp4cg5vKuvyXPyIyLtC4YETppRHiNPRM+fe5kZboo6CdatOs0?=
 =?us-ascii?Q?F3Ged850xQtUNKnFYu66As6lLlY3BHyMvljcl06wuAlEsViMeefJHTjXQc57?=
 =?us-ascii?Q?6/8dvGSr0bMNAr4ka4+twwGLQArDI9YCOd4Wdtln72GhMQ7ZGmhXbLZ1k/7I?=
 =?us-ascii?Q?2p4rp133KtiytBEEuGeWkf6IHp/WndOquO4w8+owTW0MCCNsbaEKt3vK0sHl?=
 =?us-ascii?Q?i840WlPBdMEioTLII/zP92olkEwpnF+mw62JVlgAKpZiPvVHgk2c7M6yW3p6?=
 =?us-ascii?Q?vX1iXX668eMMGrVqmRX1+M2IRQio0+JV7uLy7gr16+T91z2Myvsl/pxSB3Pc?=
 =?us-ascii?Q?hUMHKd87NB9/IpOAmS4kIasac54Z0z51OopLoACHYyJ+XbrcdpQH0BQ6Aafm?=
 =?us-ascii?Q?PSder9n/aH074uKFV7AEFi2O0kQmOBXoNwWt+QRJKf6z79AB1edVjUuuGrXm?=
 =?us-ascii?Q?B7g3e2Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HtjqDBiL57CnJbj9GHbrxCYVSDbWLTiobn3xhyOXEZrURl0HL4yxabC4EE7l?=
 =?us-ascii?Q?mSX8XAVercUqCo+ODKnx9C1+skcyVsMGGNaqI4TrGtr2tE2egkBzcI4vRZAq?=
 =?us-ascii?Q?TlhboAjRgeLNxBxCKLBBLHqe0BkTVBa/hdVo6UKuJwodwRYrVpHCqqwfL/OT?=
 =?us-ascii?Q?pUnXq3C8FBPpm5UONHHQw9RHy5MC+jKivY/ZDyR6uGG+kitgL1UeA+Hatr7N?=
 =?us-ascii?Q?xNd5/Cla8JaDkD76hq/IWD8EsrL9LfN4Thj/yS5jl6B8oHIFLNAVIpcSSmQX?=
 =?us-ascii?Q?RxnGDTq/kRxHpGLvfGf4i8c6ZFs+Kha24Qt0hjJCqOMwG8VlTMF9MnYjlD6u?=
 =?us-ascii?Q?kk+xEeV15cfibqPiEGRNwxKCwb4N9PEKSH4ENxZxIVePCEbmVHMZXj2rab40?=
 =?us-ascii?Q?TarIUU5gwj3vfgcGSRKMRho23BN7p4uQoOJjl5oI4zoUwyxMTQ6vnIP88u+j?=
 =?us-ascii?Q?VwNCzG2DnySS/NKFE6C3EZl9yqKRq4kmKjyL8fTlRjbx41SHbb7XqxWR53JP?=
 =?us-ascii?Q?/SLiFjBQUvfjI33+WbBPURECJZYrzFseasEs2mT2t8103sAQ8QZlYuogOZD1?=
 =?us-ascii?Q?RkZBb0/CC5UHmpjZpomWk20cFvUZY8FYC7Pud1mw/Z5Wm0hRYY1CAcJ1NIvy?=
 =?us-ascii?Q?e6H14KUqKEGAeFoWO+L3fILq4qgzyOsHOZuZRniBiYCLLdagEbThoizUCQKw?=
 =?us-ascii?Q?PdQKQoklAT4rnjIqsTYbGUtuTtTKNd3BFSMy38wKH+Kb+Dae1P4r/rGlDcdS?=
 =?us-ascii?Q?F7pBHaoCplklpTM15WJEAqjamuEBxjl0ly8t1+EMWbNQWY1lo4uSmCx+3U0t?=
 =?us-ascii?Q?9fh9/G6lUnhCMr3c7ngFja3cFZN2YI43tl34pYLba0F6jNDwV2V0gkyfwN4f?=
 =?us-ascii?Q?ZjafDjdBI31QqorSqH70QZwfdcMDcVpv/yvv0tcWXcNCuWyM5bOyNCSNwYtC?=
 =?us-ascii?Q?6vch8UBRhsM+h9J9+qPlGD7j0cgyFVZDsUOt5ZXKjMMJ6cVf0J4FxKu+QPX1?=
 =?us-ascii?Q?58Jnwu/0v20WwKdQq2atYdIjfCCxqp/7+fvT5ORbmaZDgo0daHWnO4QrLfYM?=
 =?us-ascii?Q?MfXtgPud/qNGPaor6uJa+qDuRqIGD6OOIhIu2yW3SybiJQlWqnLkDkrbTydg?=
 =?us-ascii?Q?LoOA3MW81R6EJ0BdyOL+/jloVYRCpiUaoQRHGkgE0O2ntsAW8la70Ji4onNh?=
 =?us-ascii?Q?beMhryM5IG7W3vKhIOg4+X3T8WBSnXCbrzXxavj13TcvyMcCaeSAf4edhib2?=
 =?us-ascii?Q?lrpekUnhc0vNLimUPhY8SzBNtcx48x+2YmtO2PZIHNDAax6uQBtX8flv8os6?=
 =?us-ascii?Q?cCdi8qEg2/w4s+EGhmJ7n2c2HQSNQpev1EUI94w4SNBm/p1dOI3hyTFoA0HA?=
 =?us-ascii?Q?IQ1dNZOavXOyD181I4R50UZVO0KxejuRqho5eDjnu50QXRBDU/Rtvlh3CaQh?=
 =?us-ascii?Q?ei+R/jFxEF7vnDvmCxrNSTq1XWo/oSVjECZOamQ+iaXoz4C9YTdnploHkYvf?=
 =?us-ascii?Q?xekehqjnPiasM/OGwpl/ve3sVV3oYPkUn4YAc/Fj13gkEZf1EP+F+CUw1JWb?=
 =?us-ascii?Q?c0wd9Zf57O8/98zxfuI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35dc31f-2992-4346-185c-08dcfd6140bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:15:31.9291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsNyZgPAHPtR7alhf+wZHGS8vnnJtoHXZFofJngb3z0kMBvTrzkx9yDObaLNnWB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo L=
azar
> Sent: Tuesday, November 5, 2024 1:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Fix unmap queue logic
>
> In current logic, it calls ring_alloc followed by a ring_test. ring_test =
in turn will call
> another ring_alloc. This is illegal usage as a ring_alloc is expected to =
be closed
> properly with a ring_commit. Change to commit the unmap queue packet firs=
t
> followed by a ring_test. Add a comment about the usage of ring_test.

Regarding the description " This is illegal usage as a ring_alloc is expect=
ed to be closed properly with a ring_commit ", does this only apply to unma=
p queue logic ?
The current logic to do map queue is also to commit once in ring_test but r=
ing_alloc twice.

>
> Also, reorder the current pre-condition checks of job hang or kiq ring sc=
heduler not
> ready. Without them being met, it is not useful to attempt ring or memory=
 allocations.
>
> Fixes tag refers to the original patch which introduced this issue which =
then got
> carried over into newer code.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Fixes: 6c10b5cc4eaa ("drm/amdgpu: Remove duplicate code in gfx_v8_0.c")
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 47 ++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  7 ++++
>  3 files changed, 49 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index c218e8f117e4..2a40150ae10f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -844,6 +844,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device
> *adev, u32 doorbell_off,
>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>               return -EINVAL;
>
> +     if (!kiq_ring->sched.ready || adev->job_hang)
> +             return 0;
> +
>       ring_funcs =3D kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
>       if (!ring_funcs)
>               return -ENOMEM;
> @@ -868,8 +871,14 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device
> *adev, u32 doorbell_off,
>
>       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
>
> -     if (kiq_ring->sched.ready && !adev->job_hang)
> -             r =3D amdgpu_ring_test_helper(kiq_ring);
> +     /* Submit unmap queue packet */
> +     amdgpu_ring_commit(kiq_ring);
> +     /*
> +      * Ring test will do a basic scratch register change check. Just ru=
n
> +      * this to ensure that unmap queues that is submitted before got
> +      * processed successfully before returning.
> +      */
> +     r =3D amdgpu_ring_test_helper(kiq_ring);
>
>       spin_unlock(&kiq->ring_lock);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index dabc01cf1fbb..6733ff5d9628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -515,6 +515,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *ade=
v,
> int xcc_id)
>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>               return -EINVAL;
>
> +     if (!kiq_ring->sched.ready || adev->job_hang)
> +             return 0;
> +     /**
> +      * This is workaround: only skip kiq_ring test
> +      * during ras recovery in suspend stage for gfx9.4.3
> +      */
> +     if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
> +          amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4)=
) &&
> +         amdgpu_ras_in_recovery(adev))
> +             return 0;
> +
>       spin_lock(&kiq->ring_lock);
>       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
>                                       adev->gfx.num_compute_rings)) {
> @@ -528,20 +539,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device
> *adev, int xcc_id)
>                                          &adev->gfx.compute_ring[j],
>                                          RESET_QUEUES, 0, 0);
>       }
> -
> -     /**
> -      * This is workaround: only skip kiq_ring test
> -      * during ras recovery in suspend stage for gfx9.4.3
> +     /* Submit unmap queue packet */
> +     amdgpu_ring_commit(kiq_ring);
> +     /*
> +      * Ring test will do a basic scratch register change check. Just ru=
n
> +      * this to ensure that unmap queues that is submitted before got
> +      * processed successfully before returning.
>        */
> -     if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
> -         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))=
 &&
> -         amdgpu_ras_in_recovery(adev)) {
> -             spin_unlock(&kiq->ring_lock);
> -             return 0;
> -     }
> +     r =3D amdgpu_ring_test_helper(kiq_ring);
>
> -     if (kiq_ring->sched.ready && !adev->job_hang)
> -             r =3D amdgpu_ring_test_helper(kiq_ring);
>       spin_unlock(&kiq->ring_lock);
>
>       return r;
> @@ -569,8 +575,11 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *ade=
v,
> int xcc_id)
>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>               return -EINVAL;
>
> -     spin_lock(&kiq->ring_lock);
> +     if (!adev->gfx.kiq[0].ring.sched.ready || adev->job_hang)
> +             return 0;
> +
>       if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
> +             spin_lock(&kiq->ring_lock);
>               if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size=
 *
>                                               adev->gfx.num_gfx_rings)) {
>                       spin_unlock(&kiq->ring_lock);
> @@ -583,11 +592,17 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device
> *adev, int xcc_id)
>                                                  &adev->gfx.gfx_ring[j],
>                                                  PREEMPT_QUEUES, 0, 0);
>               }
> -     }
> +             /* Submit unmap queue packet */
> +             amdgpu_ring_commit(kiq_ring);
>
> -     if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
> +             /*
> +              * Ring test will do a basic scratch register change check.
> +              * Just run this to ensure that unmap queues that is submit=
ted
> +              * before got processed successfully before returning.
> +              */
>               r =3D amdgpu_ring_test_helper(kiq_ring);
> -     spin_unlock(&kiq->ring_lock);
> +             spin_unlock(&kiq->ring_lock);
> +     }
>
>       return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index f85e545653c7..553a6113fa67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4823,6 +4823,13 @@ static int gfx_v8_0_kcq_disable(struct amdgpu_devi=
ce
> *adev)
>               amdgpu_ring_write(kiq_ring, 0);
>               amdgpu_ring_write(kiq_ring, 0);
>       }
> +     /* Submit unmap queue packet */
> +     amdgpu_ring_commit(kiq_ring);
> +     /*
> +      * Ring test will do a basic scratch register change check. Just ru=
n
> +      * this to ensure that unmap queues that is submitted before got
> +      * processed successfully before returning.
> +      */
>       r =3D amdgpu_ring_test_helper(kiq_ring);
>       if (r)
>               DRM_ERROR("KCQ disable failed\n");
> --
> 2.25.1


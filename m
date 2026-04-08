Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713881073CB4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFEAC10E476;
	Wed,  8 Apr 2026 13:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9BHoKKU";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EAF10E476
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=starpSLFiGCq1xm/tWmnPMGnHyJxFpCCHFwHjVUN9CwxNlH8G4P8ImFYO/1keNmxaymw8kKYEoPBdzaAqcbmMH6YxDfDkOd1zEbe6VviH5jQvOlaxDKG1YOy5mCOGx9tY6ZMbO7qjCAkmp9VezOv8EVvvlKATl4qSwWhizADIMSao1lFI7Gl9ges4srRp5XAbI4/4/aqbedIoaQ7MAsAC3r+LMqDEkxsiU6+OYZb3hmBzcMH0zIyFE6haV1czmLMdJoA+QX2eJUnehw1xsPr/yCmQWFaM7hjRhPisHerwCarkNLMauwp7k9rgD174exMKg5x0SwJRTd6i5qYoOb/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/33xXPxyC/TwWeIiLcvjsSgUQSwWz5MqD7PY5vbCOoY=;
 b=QW/E0Wwkz6Mcu8mILT3ZNLDouWLe6m6e0FMsfwZupYHPvLSAc7MH3dzebd1HdzwRcJ4m6ZbfkoAr62MZj3pqS60wNOXNe8Ghu3284buJ6t5NjjVOp4VqczLV+PgxfVSG4eswqcuzTx5853X/DYxGEqXKG0rCagZfI2Pq9lmKfX/VkUx8RTN5ChnWrHlOf/3kT16MZ0PTQdjueaaKr+ZjFOXjQGTP9ZSg/icxwklpqLXt3QlVhbV3Cq9mNRZ5+nUykA73/nG/eEd8y+fepgJyovsWctM7z7AzM2x0j6tRzNj6PfF+mtiKqCia+OW0DPCP9YcdyIwU3MWBxH51yZUVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/33xXPxyC/TwWeIiLcvjsSgUQSwWz5MqD7PY5vbCOoY=;
 b=C9BHoKKUdjybNgGaLtoOkpQPYG5GIuV60Pb3Z86c0BhIEPn/BX31m6ycpWo1aZVTxen/heQgzizkfB+DDmLuZjGRcAzZEV/Oe6hcepsobgl61fNRFy1xjvloEAshkJfIfDCzkPmL7e32K4xIi/ypSDm3dYhBvmP83DjQZUZgt9o=
Received: from DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 8 Apr
 2026 13:14:38 +0000
Received: from DS0PR12MB8477.namprd12.prod.outlook.com
 ([fe80::db6d:61a5:b5b1:f175]) by DS0PR12MB8477.namprd12.prod.outlook.com
 ([fe80::db6d:61a5:b5b1:f175%4]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 13:14:38 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Cheng, Benjamin" <Benjamin.Cheng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wu, David" <David.Wu3@amd.com>, "Dong, Ruijing" <Ruijing.Dong@amd.com>,
 "Cheng, Benjamin" <Benjamin.Cheng@amd.com>
Subject: RE: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Thread-Topic: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Thread-Index: AQHcx1bhwSp8omgQgkq90YupjPNZNbXVJHYg
Date: Wed, 8 Apr 2026 13:14:38 +0000
Message-ID: <DS0PR12MB8477585788A3C2CC01EC7213E55BA@DS0PR12MB8477.namprd12.prod.outlook.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
 <20260408125426.2118644-3-benjamin.cheng@amd.com>
In-Reply-To: <20260408125426.2118644-3-benjamin.cheng@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-08T13:14:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8477:EE_|PH7PR12MB7356:EE_
x-ms-office365-filtering-correlation-id: 9b42c66c-2f6b-4bc3-870e-08de9570c999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: ELooD60Ps7IDlPuv2ZcOfHlDZhhQwgGQKqA0UsaBTa5lMJK1kRN/JSGqSUJlWLUj3mWy5aoHf3eUD5AuCQPb0+zzb3YQrvWBD8EijnK4baRehJJZwJnOrfY0GnsCGZNErpmx2eMGz0mkRSy/mv9m1sk2YQhSiPmWzfsIqSk6AUSR7yUAxjgPD1/86KcISfZNR9v5prnaE2+8IR1D2HMm8ZXoPXnxJwnIs6XIwHEeTMKK/3HikykBUe36SqCKsGdfOb1J1rTGy6JV243d0B9p7uTtrDrpnGHGYM8MZFg4cFOzuJgfWc26MbcfrCN8F8LXxdetRiBzy8b/DatdoQhfn3QCuzvhShAFhYpNmRU6fgwPCK2rdRYnZ48z8grm0ezBjBS9/id3wiD0x6P3vp6dfrSZzBFXko6lNZgCJNJLorr80KmVN2HFs4Obr/6wd3mMgrxzRbOt1XZAbBoY36n30AK4DxrdQz9vcWc5bV32kUlhpVqzjsspOxa+muGScIc3PtV4zxZxm0qC0pUDy9DhrBVVIEDZrKVQlI7dFOIkhHq519gHRYtWLd35TZuFPH+e+/PCjQtfKOsHMbYg1asNtPhCzhzZDxvcN6jYtTVj2TjSAKOQrZA1CWLoVWYlF61NItiAEkFAlCuqu0qxm4Gf0z750lUCiKgibJoSGbjsMbL6pgPB8pUmanoEkJYkp9M3pIDii9iqIFs4mN0VMsHw7RtZ0rNJZnzzuCBMoCKsULiT89Md8l05oMge1q1XUerN1fQdVgwfZUT88po8SyqGK3FEqJVqGBDnXf4mYIu/deA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8477.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1DGAw9RE0ljPDBSb95CpTTV/v+Pfq9R89X5SWTkZin10K3M8SJUrYplbaZq?=
 =?us-ascii?Q?ywAeqAviTS5G8B7iapkupD15JAeu6/zuvm9aBZ5lnX+OAjyc4u8EDkdrFsOV?=
 =?us-ascii?Q?RCmEHsp8YHT6ooPD6St9TbKhsaWSqheZBnRlCPzmOTQOECgqfHos8qRU7I/z?=
 =?us-ascii?Q?pZDcPs7mWCkhwm0YQCAqX2d4ciuISCUjo67NQVyHfvO3Tqo+7c6kvuSuWzVB?=
 =?us-ascii?Q?mhDChW3SbxNl6co2Dn2FcBhifkFWgOswafRUsTkL17whD9zw/W033ee6vrvb?=
 =?us-ascii?Q?7fsUCnAhUvZ3x48mhlAidS7m2EIrbDI3UcPktNdPP0VZcwrutQZIyR62bI+h?=
 =?us-ascii?Q?edrgqxIucMEcP1dcWlIbDtgCYpQk6UCwETUYO4DpTngLiTfP+n0rqvH9eJDx?=
 =?us-ascii?Q?D/H7v18p+Stah0nwjIv2VWtDIX8Ojq+TO4eqEQ1lybobwz7vhHPrs2/YAKMI?=
 =?us-ascii?Q?yVGLD91lqsgPFqrn9vRDi3Nm4rd5+QIVojZKTdiYydzrtDURdLDM19HBMQe6?=
 =?us-ascii?Q?vvwcrU+EBG3KCDkIXWXcNPR1EwshBttQ893zKUjYa2qHwvRNind9t/EphxE9?=
 =?us-ascii?Q?F19iBTQv0b3Q0UlW71YVbjltWRotQKQUCG96uhXYhHRNAkdv6sfT1sbdQym5?=
 =?us-ascii?Q?2qw+Au1RfzEuRV/jVuV2dHcpBr2hKmL5rMe6xqNo2onA9X0KHHdqq/nonp/O?=
 =?us-ascii?Q?mSoKx7DdGCX25WFnpwvwmJLHksUfC8jO8BDhk3MSVqkvgcAFyVq2TxNTkWuU?=
 =?us-ascii?Q?6tBi3JeUwxR7yLoAV5Y3r71tqO0yEXIurQKVUPpITM6OF5ux/Wmk5H8p88Jr?=
 =?us-ascii?Q?KNqTMMR5Iuvv5XS2KuruevPqKQzOD04um6brvNJ76pE39fW/TozZz8sTVf9/?=
 =?us-ascii?Q?q6DjELoiZ7f9Rrrt71fpJl5Ewg5tU6rpdHdfh0+adWruWRbPYWF1IUmLN4Yk?=
 =?us-ascii?Q?CsrmxPp/d2a3hrg1ztv6bSf2ELJ5VeLYksJjjhcKK88TS6ATyRdRczZiul5N?=
 =?us-ascii?Q?hFZVUJ8UDd+RvDMhI3JM0jJLFvJIMt63Agh+/n9hzpVZrSV+4Frb7fZ9L65Y?=
 =?us-ascii?Q?U1v6Ik2V5CLmnqPwdhhUVY2MzLjCi03W2XCJaxtWtVWQxoFb1JhAl+55pHiP?=
 =?us-ascii?Q?azCiDEya03Nz9xkBY0hVzEHA9ICAjKzruDEem9BeHmdPF7Tv0ZWUixalsbgv?=
 =?us-ascii?Q?SuP21cCDJ+kKuamW94TIef47xjV69YXPihSv339CgW0Ys3VGLroqS4d+4IB7?=
 =?us-ascii?Q?NO/16/CS2oHQ1107aZEwD46V1zDZaAsdRJKwXAl26MbyzesE3wHSW833WnJq?=
 =?us-ascii?Q?Qn0kO1ggc0DMJFdliDAl+5M07Vmsn/6QYT8EeyGnpJjXy5uYcUPx+EsnkcAG?=
 =?us-ascii?Q?lg6DLpIcOX3yBNDi6PxJXkNyDTFKHuax83Yd5wo2F7rVAjIoOkMa9p2N0Ry6?=
 =?us-ascii?Q?nIo00zi+dH+gXXEFbkJaJBeveoPO3IpeB/NNeh1XOxZR24h3srT8FCx12ph8?=
 =?us-ascii?Q?Dfx/4abJ7FZ+j3Icm3M6Yrua9H1ma6N9DCbjKSKS9IdkLcmI75b7rrhqW6Wi?=
 =?us-ascii?Q?nM3ufnv+NaGwHy4PWLxYR0LUC6Dwt0w/C2WHuv0jhoDfjWIk3KE0CBI37DU1?=
 =?us-ascii?Q?+oSxFFI9K5c+jp3yYeL5uqT8c2ECtkC0tVDoXfXrc3S7Zaqp1P+zy6AmNt2S?=
 =?us-ascii?Q?1QdczF7kOU/W6tL/8/y77TzWS7BH7PVqxFihBOCKDna395bv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8477.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b42c66c-2f6b-4bc3-870e-08de9570c999
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 13:14:38.3993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcdJFLFkFZGmy6AbCB3lUpM85dpK0uJOrZKtv2Z7K9xjdX8TA0x64EFMuGGL1D/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

The series is:
Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: Benjamin Cheng <benjamin.cheng@amd.com>
> Sent: April 8, 2026 8:54 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Wu, David <David.Wu3@amd.com>; Dong, Ruijing
> <Ruijing.Dong@amd.com>; Cheng, Benjamin <Benjamin.Cheng@amd.com>
> Subject: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
>
> Both vcn_v3_0 and vcn_v4_0 use the same interface, so unify the code.
>
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
> v2: Moved RDECODE_* defines to header in patch #1.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 100
> +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   5 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 102 +-----------------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 101 +----------------------
>  4 files changed, 109 insertions(+), 199 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 03d95dca93d7..10aff7da52b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1641,3 +1641,103 @@ void amdgpu_vcn_print_ip_state(struct
> amdgpu_ip_block *ip_block, struct drm_prin
>               }
>       }
>  }
> +
> +int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p,
> +                                struct amdgpu_job *job, uint64_t addr,
> +                                int (*limit_sched)(struct
> amdgpu_cs_parser *,
> +                                                   struct amdgpu_job *))
> +{
> +     struct ttm_operation_ctx ctx =3D { false, false };
> +     struct amdgpu_device *adev =3D p->adev;
> +     struct amdgpu_bo_va_mapping *map;
> +     uint32_t *msg, num_buffers, len_dw;
> +     struct amdgpu_bo *bo;
> +     uint64_t start, end;
> +     unsigned int i;
> +     void *ptr;
> +     int r;
> +
> +     addr &=3D AMDGPU_GMC_HOLE_MASK;
> +     r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
> +     if (r) {
> +             DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
> +             return r;
> +     }
> +
> +     start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
> +     end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> +     if (addr & 0x7) {
> +             DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> +             return -EINVAL;
> +     }
> +
> +     if (end - addr < 16) {
> +             DRM_ERROR("VCN messages must be at least 4
> DWORDs!\n");
> +             return -EINVAL;
> +     }
> +
> +     bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +     amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +     r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +     if (r) {
> +             DRM_ERROR("Failed validating the VCN message BO
> (%d)!\n", r);
> +             return r;
> +     }
> +
> +     r =3D amdgpu_bo_kmap(bo, &ptr);
> +     if (r) {
> +             DRM_ERROR("Failed mapping the VCN message (%d)!\n",
> r);
> +             return r;
> +     }
> +
> +     msg =3D ptr + addr - start;
> +
> +     if (msg[1] > end - addr) {
> +             DRM_ERROR("VCN message header does not fit in BO!\n");
> +             r =3D -EINVAL;
> +             goto out;
> +     }
> +
> +     if (msg[3] !=3D VCN_DEC_MSG_CREATE)
> +             goto out;
> +
> +     len_dw =3D msg[1] / 4;
> +     num_buffers =3D msg[2];
> +
> +     /* Verify that all indices fit within the claimed length. Each inde=
x is 4
> DWORDs */
> +     if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +             DRM_ERROR("VCN message has too many buffers!\n");
> +             r =3D -EINVAL;
> +             goto out;
> +     }
> +
> +     for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
> +             uint32_t offset, size, *create;
> +
> +             if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
> +                     continue;
> +
> +             offset =3D msg[1];
> +             size =3D msg[2];
> +
> +             if (size < 4 || offset + size > end - addr) {
> +                     DRM_ERROR("VCN message buffer exceeds BO
> bounds!\n");
> +                     r =3D -EINVAL;
> +                     goto out;
> +             }
> +
> +             create =3D ptr + addr + offset - start;
> +
> +             /* H264, HEVC and VP9 can run on any instance */
> +             if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
> +                     continue;
> +
> +             r =3D limit_sched(p, job);
> +             if (r)
> +                     goto out;
> +     }
> +
> +out:
> +     amdgpu_bo_kunmap(bo);
> +     return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e72687246235..ad6ca7aa74bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -573,4 +573,9 @@ void amdgpu_vcn_print_ip_state(struct
> amdgpu_ip_block *ip_block, struct drm_prin
>  void amdgpu_vcn_get_profile(struct amdgpu_device *adev);
>  void amdgpu_vcn_put_profile(struct amdgpu_device *adev);
>
> +int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p, struct
> amdgpu_job *job,
> +                                uint64_t addr,
> +                                int (*limit_sched)(struct
> amdgpu_cs_parser *,
> +                                                   struct amdgpu_job *))=
;
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 64531ad56c48..38a4fcf5872e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1900,104 +1900,6 @@ static int vcn_v3_0_limit_sched(struct
> amdgpu_cs_parser *p,
>       return 0;
>  }
>
> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct
> amdgpu_job *job,
> -                         uint64_t addr)
> -{
> -     struct ttm_operation_ctx ctx =3D { false, false };
> -     struct amdgpu_device *adev =3D p->adev;
> -     struct amdgpu_bo_va_mapping *map;
> -     uint32_t *msg, num_buffers, len_dw;
> -     struct amdgpu_bo *bo;
> -     uint64_t start, end;
> -     unsigned int i;
> -     void *ptr;
> -     int r;
> -
> -     addr &=3D AMDGPU_GMC_HOLE_MASK;
> -     r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
> -     if (r) {
> -             DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
> -             return r;
> -     }
> -
> -     start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
> -     end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> -     if (addr & 0x7) {
> -             DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> -             return -EINVAL;
> -     }
> -
> -     if (end - addr < 16) {
> -             DRM_ERROR("VCN messages must be at least 4
> DWORDs!\n");
> -             return -EINVAL;
> -     }
> -
> -     bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -     amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> -     r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -     if (r) {
> -             DRM_ERROR("Failed validating the VCN message BO
> (%d)!\n", r);
> -             return r;
> -     }
> -
> -     r =3D amdgpu_bo_kmap(bo, &ptr);
> -     if (r) {
> -             DRM_ERROR("Failed mapping the VCN message (%d)!\n",
> r);
> -             return r;
> -     }
> -
> -     msg =3D ptr + addr - start;
> -
> -     if (msg[1] > end - addr) {
> -             DRM_ERROR("VCN message header does not fit in BO!\n");
> -             r =3D -EINVAL;
> -             goto out;
> -     }
> -
> -     if (msg[3] !=3D VCN_DEC_MSG_CREATE)
> -             goto out;
> -
> -     len_dw =3D msg[1] / 4;
> -     num_buffers =3D msg[2];
> -
> -     /* Verify that all indices fit within the claimed length. Each inde=
x is 4
> DWORDs */
> -     if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> -             DRM_ERROR("VCN message has too many buffers!\n");
> -             r =3D -EINVAL;
> -             goto out;
> -     }
> -
> -     for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
> -             uint32_t offset, size, *create;
> -
> -             if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
> -                     continue;
> -
> -             offset =3D msg[1];
> -             size =3D msg[2];
> -
> -             if (size < 4 || offset + size > end - addr) {
> -                     DRM_ERROR("VCN message buffer exceeds BO
> bounds!\n");
> -                     r =3D -EINVAL;
> -                     goto out;
> -             }
> -
> -             create =3D ptr + addr + offset - start;
> -
> -             /* H264, HEVC and VP9 can run on any instance */
> -             if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
> -                     continue;
> -
> -             r =3D vcn_v3_0_limit_sched(p, job);
> -             if (r)
> -                     goto out;
> -     }
> -
> -out:
> -     amdgpu_bo_kunmap(bo);
> -     return r;
> -}
> -
>  static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>                                          struct amdgpu_job *job,
>                                          struct amdgpu_ib *ib)
> @@ -2021,8 +1923,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct
> amdgpu_cs_parser *p,
>                       msg_hi =3D val;
>               } else if (reg =3D=3D PACKET0(p->adev->vcn.inst[ring-
> >me].internal.cmd, 0) &&
>                          val =3D=3D 0) {
> -                     r =3D vcn_v3_0_dec_msg(p, job,
> -                                          ((u64)msg_hi) << 32 | msg_lo);
> +                     r =3D amdgpu_vcn_dec_msg_limit_sched(p, job,
> ((u64)msg_hi) << 32 | msg_lo,
> +
> vcn_v3_0_limit_sched);
>                       if (r)
>                               return r;
>               }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index a89e316a4add..41215ad7dfac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1817,104 +1817,6 @@ static int vcn_v4_0_limit_sched(struct
> amdgpu_cs_parser *p,
>       return 0;
>  }
>
> -static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct
> amdgpu_job *job,
> -                         uint64_t addr)
> -{
> -     struct ttm_operation_ctx ctx =3D { false, false };
> -     struct amdgpu_device *adev =3D p->adev;
> -     struct amdgpu_bo_va_mapping *map;
> -     uint32_t *msg, num_buffers, len_dw;
> -     struct amdgpu_bo *bo;
> -     uint64_t start, end;
> -     unsigned int i;
> -     void *ptr;
> -     int r;
> -
> -     addr &=3D AMDGPU_GMC_HOLE_MASK;
> -     r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
> -     if (r) {
> -             DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
> -             return r;
> -     }
> -
> -     start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
> -     end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> -     if (addr & 0x7) {
> -             DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> -             return -EINVAL;
> -     }
> -
> -     if (end - addr < 16) {
> -             DRM_ERROR("VCN messages must be at least 4
> DWORDs!\n");
> -             return -EINVAL;
> -     }
> -
> -     bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -     amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> -     r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -     if (r) {
> -             DRM_ERROR("Failed validating the VCN message BO
> (%d)!\n", r);
> -             return r;
> -     }
> -
> -     r =3D amdgpu_bo_kmap(bo, &ptr);
> -     if (r) {
> -             DRM_ERROR("Failed mapping the VCN message (%d)!\n",
> r);
> -             return r;
> -     }
> -
> -     msg =3D ptr + addr - start;
> -
> -     if (msg[1] > end - addr) {
> -             DRM_ERROR("VCN message header does not fit in BO!\n");
> -             r =3D -EINVAL;
> -             goto out;
> -     }
> -
> -     if (msg[3] !=3D VCN_DEC_MSG_CREATE)
> -             goto out;
> -
> -     len_dw =3D msg[1] / 4;
> -     num_buffers =3D msg[2];
> -
> -     /* Verify that all indices fit within the claimed length. Each inde=
x is 4
> DWORDs */
> -     if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> -             DRM_ERROR("VCN message has too many buffers!\n");
> -             r =3D -EINVAL;
> -             goto out;
> -     }
> -
> -     for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
> -             uint32_t offset, size, *create;
> -
> -             if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
> -                     continue;
> -
> -             offset =3D msg[1];
> -             size =3D msg[2];
> -
> -             if (size < 4 || offset + size > end - addr) {
> -                     DRM_ERROR("VCN message buffer exceeds BO
> bounds!\n");
> -                     r =3D -EINVAL;
> -                     goto out;
> -             }
> -
> -             create =3D ptr + addr + offset - start;
> -
> -             /* H264, HEVC and VP9 can run on any instance */
> -             if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
> -                     continue;
> -
> -             r =3D vcn_v4_0_limit_sched(p, job);
> -             if (r)
> -                     goto out;
> -     }
> -
> -out:
> -     amdgpu_bo_kunmap(bo);
> -     return r;
> -}
> -
>  #define RADEON_VCN_ENGINE_TYPE_ENCODE
>       (0x00000002)
>  #define RADEON_VCN_ENGINE_TYPE_DECODE
>       (0x00000003)
>  #define RADEON_VCN_ENGINE_INFO
>       (0x30000001)
> @@ -1957,7 +1859,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct
> amdgpu_cs_parser *p,
>
>                       msg_buffer_addr =3D ((u64)amdgpu_ib_get_value(ib,
> idx + 7)) << 32 |
>                               amdgpu_ib_get_value(ib, idx + 8);
> -                     return vcn_v4_0_dec_msg(p, job, msg_buffer_addr);
> +                     return amdgpu_vcn_dec_msg_limit_sched(p, job,
> msg_buffer_addr,
> +
> vcn_v4_0_limit_sched);
>               } else if (val =3D=3D RADEON_VCN_ENGINE_TYPE_ENCODE) {
>                       sidx =3D vcn_v4_0_enc_find_ib_param(ib,
> RENCODE_IB_PARAM_SESSION_INIT, idx);
>                       if (sidx >=3D 0 &&
> --
> 2.53.0


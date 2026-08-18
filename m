Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1747C5DF84
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 13:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399B410EB48;
	Tue, 18 Aug 2026 13:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i4qL2qW/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3BB10EB68
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 13:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ifk8uxnpjJ8LpTATbMKrn4DN5mvff4Iaq3cXO1qrcfg2/dt3ShZ1zVOAb87nGZT5zk7JPy3eKnMUI7M7beYGap0nBpyyQXZw2wVK9iVU4vc2FSkQr88NSnGOBMJnhkON+tu87YkYTXDsVKFfvnsJ/iWbvL94cd7hQ1tn1rljYmhOVEC/JtpURwG6WUN8Cvh4NLNxWuMQvrDWPKI8UIBGTdqm+uBHKZT4aU1O929RGVDzEpKDAMM7ow/X2nJuLrxdc4Lyq7nR6XZZTygcJGblUquqzaakgV7bXqTAFzsP+qLxTTpzK+PQRi8ugj9x4dtczzhGK0t99JtZvH7lgIHpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0+L75hFcjXUZUW8+O8hcqMFC+ELbYv+ZdUywDIEuDA=;
 b=XOYhB9JFfEDtUrlit7OjLdCqXC5arG+AB3Li2naCDAD8qqXsH1jR0XwdgIEuwTmuwBOqYF7tG3MP4GS4TyZq+s/RzVFR8wHLo51kMICpT/7JxOudI9wwaHfahf4XjeQR9Y+CDLRCHWo9+6XplYNgw61vEiqFnJj6XkOxNbxwdVntWqiFuoCarsXVV+PEZ0EUn4uri8YP1KY+AH4Egqs1/NZ5X7VF7xC/sPakjqiu6hCeL2Bf9f4P0NLQ4+h0+si3EUItQFtjDOKxVD7gbgb2NdrHuts7oAJClc5uAsReBHDWCT+QEYE/508k1durvj3+wAGSCv69oItD2CNMRoTK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0+L75hFcjXUZUW8+O8hcqMFC+ELbYv+ZdUywDIEuDA=;
 b=i4qL2qW/bwoAcUPB6zplaNP65IicmtNuJdEPHuS7AXECwLtaIX6UxLcPx4KNBtrfH+BlR57xrSK9xfSlNiKBYElLzb7hSkOAjjY+QoDT2ztptFtqysdLHofewq/Z1axCuIkOSuriihYu0CROUveXmrfzdzbiZYT7sGiiILNuCUw=
Received: from CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 18 Aug
 2026 13:12:18 +0000
Received: from CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd]) by CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:12:17 +0000
From: "Clement, Sunday" <Sunday.Clement@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations after
 size halving
Thread-Topic: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations
 after size halving
Thread-Index: AQHdJbXcMgZUsEwrW0mx6ja6TZiM9Laj2uxg
Date: Tue, 18 Aug 2026 13:12:17 +0000
Message-ID: <CY8PR12MB75631E1DF4CD49C84275057B9FA62@CY8PR12MB7563.namprd12.prod.outlook.com>
References: <20260806151103.122321-1-Sunday.Clement@amd.com>
In-Reply-To: <20260806151103.122321-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-18T13:12:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7563:EE_|SA1PR12MB8600:EE_
x-ms-office365-filtering-correlation-id: 0d61c139-d109-4b8d-3950-08defd2a545f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|11063799006|56012099006|10067099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: RgVdkP4nodF8txaTvwyrgR9bB8zFOm7gggmar7y3qv0osWjObfZrxulG1XJnCQAXqYsfjPtt5o9bqVBJvIEKKfAwo3fvH9NVVatDqsOOQsiPmLDCNbvDIdNa3U0n76ms0cMgrSkcDMW11lqaK4UhsAbwg7wNyJBIiveUs2saHHhemnPSjHd0ALTu63MowK0IEpdhhNt3pfCw8VEtwKrkbKaCghU67kscxQeY1X7CZBOghdpQihyUnraMkNF1rf4joMnPpoZXnIDCSjgzwwPhaywZ0AGShwA2hDf3m0sCAmkGCtz7y/y1pRJn2UFPTerSCRvDt13Rt0eTJZxCCuBTGKlmkJH9+WbPXqWtbWQu37H3uNiGrdXOE73XynYRvMeuBkK3NysS5tyE/PyBabe1Z8AwJ78Wnel9tQiefrh1K3CP5Tqfqz2F9a0FMjRiIWOLzKcJdJ3lSkBrPX1aUssJ8R+WKPcl1yt1MUG2fUUKhWr2YW6+6MAtZ4Wig8oBeufG2DH8v21ThyT+yH8oxIR/UK4DXM8aGmpC3L7F80V+sBPMdEJwAPLhnaFXgZBO+VKUARcCfGaEoi/vFpB+s4bIJuiS0Pi1AR1YQ8E5M+ql27aYKotAT0Ae4XSG3HHOvk3GInd9QK48sEBxyp3HdC/Bj/Pwg4xAL/UYmc9exihOwZWbI5bfzurzdk7HmseAGnsK7P0EFniv2Cx3HG99iOPj6crE96wdZGAOmnPvRcuiU1A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7563.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R2XgWH7G9UU1MD5UkUMuKFDmJNXOtOhRLNNvHwqN5YiktKDv1OKLwh9HC/v7?=
 =?us-ascii?Q?TdvxnOlnJ/K3wOIny+0aYs/ObiGB9c7LAbTKq6/RiGR7ckq03MKiHxlmDaE8?=
 =?us-ascii?Q?fRaBuF2bD4ma4advpqOtuXZo9alcXgmITAIFZwbGYzL+5XGfJcPCQw3XWYs4?=
 =?us-ascii?Q?v1d/eZv2fs3uqmIPzsb4ud0QdNYyRNw8RRrFlaJTtsPu+jOXMcxIHtGRKI/i?=
 =?us-ascii?Q?kDyLVsR3QBrZT3CRu/hpqLsZkMyDZAT/AYzBVqdQa1ROC08XHraFat80Ih5e?=
 =?us-ascii?Q?XAAG0aKmaip3dTO00nPbtn345ZWeCTO5lNcccsk/s8iVAppKUy2Qhfeu9ZoP?=
 =?us-ascii?Q?50kTZFsSHncvfa37PUXH4SEZOHoWsRNtJHZFfYZO8+KdRHRnkdYDJFNRLmdI?=
 =?us-ascii?Q?LsOkEKfAPWMmMI/DpfQDP4jDV+TCbRG4nmneFFljOA9qE+QbHT8p7ve+f65U?=
 =?us-ascii?Q?oAf53WoxGnoQzNoe+/h4cH7BoQBnfDXGufzNHqF+cecGjHxzA7FECcqNILsw?=
 =?us-ascii?Q?kPsdOYasSj+nSWplKtCdn4CLBmafdMl0HhSP5Kj7vUDy1Wxmb0MWhjNNayss?=
 =?us-ascii?Q?6WTCHzbMl4Yk/4s2tDjL+MEVB8AT6Jhfk5uG/sabhEqkEzgCZ0CTb8BG5K3Y?=
 =?us-ascii?Q?q64fw+f55EO+eUsYl/gjuY1etLA0HW7hBoC/hZe500Blq3edppMPKn4fv+BI?=
 =?us-ascii?Q?FJihtMWJgbbFNxLInLzRmhk/nATHCD859PMgFqR31A7r8LRcvzL2N3I1gkfQ?=
 =?us-ascii?Q?jts8u1DfOyog5aXPgDkmQVN4PmmOE87QKGPh8VhuDdxGmZKqgELLJwzAPoVA?=
 =?us-ascii?Q?HicO86IgJnSfTMlvlNMiLGOHZOKY0oK+RsCTPr8fELSrkahkYy4+676qJ6WI?=
 =?us-ascii?Q?p9uJf5BgitOD/CV10AasbHnUnba+XjYV26Rr/VYC0onHOrHtiKEqsjJufjNh?=
 =?us-ascii?Q?n1ZO3gtpJyl5LuGrlSK+i4T488XSHTDt4ZI69UFQ1tkU3CFiEiVoQzXkE5TX?=
 =?us-ascii?Q?tTJ/9AS0r3tMPOnn2SgjEz01nFywyCjvucWRAtsHVWMcBWAWVLBdULmjDLz+?=
 =?us-ascii?Q?2qtuLzjnrOUmjUsiC/+zOJYxV0aL5ft0cX+hPcGhcStqO2Fd3r9uhPZXsnJ0?=
 =?us-ascii?Q?I+0BxruySosEVypo8FEvADQ6eYYmVsCF3FopMQb22qVq2o1NxWA3mk3JjZeD?=
 =?us-ascii?Q?LjYctEbaxRqCTrQaEgRlflzeKWORyF/dsLTO72shfo+O8Xa8Xpz95Zzt8NNx?=
 =?us-ascii?Q?ANcziK5zTGn/ixGpyGNAnJYNrbo6F5fKXml5xWcTg45jM9z1C4SM+aWiG9Mk?=
 =?us-ascii?Q?4wsNMffuI6DtIN5FNNfT4xwLzrb47e4uD6No/lJjZAk765EfCHRVLDy0c4/i?=
 =?us-ascii?Q?4wNobjUp+EEEfmIhajZtNom47KTCTpUBOcBffvX/rjr5Cv6pHgCZMhrqwPQD?=
 =?us-ascii?Q?BfendeJ2k29A6Kl04+euReUcD9LwRTjZ3Vfh3lhUSyqUAXJQQxGBqsZvaE+B?=
 =?us-ascii?Q?G9e1P5wBtjxgijoAu8V2rQTz/NN0hxClFrVjng6Sdfhhne0IcUqUpst4IIqp?=
 =?us-ascii?Q?ravDJdV1Bvng9DLSkR8X+LrUs1Ck2XQFz/e4drvfypuJAe/Gs5w6zgrbVc9S?=
 =?us-ascii?Q?Qc0JaEvTjomipB3Bbu/heokIBI9anYLbJvx0n35GJfE5FzQLnD7eb3YV8mgu?=
 =?us-ascii?Q?ndW6TjQaI7ZRb67TJn6blZVlQqQSWQhjzTx8BL9IsQ2OSTA2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7563.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d61c139-d109-4b8d-3950-08defd2a545f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 13:12:17.7392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQlntEJ+QTdkCyQHKUZyYsJu9AXWZo4uoVAYJIfvFBnXISghLaZ3DVQpe0ltW/MWXqkfCvFwMoG2Hzi82bmzjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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

ping

> -----Original Message-----
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Thursday, August 6, 2026 11:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Clement, Sunday <Sunday.Clement@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations afte=
r size
> halving
>
> KFD_IOC_ALLOC_MEMORY_OF_GPU with flag
> KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM and size=3D1 triggers the AQL
> wraparound workaround (size >>=3D 1), reducing size to 0. The resulting z=
ero passes
> through PAGE_ALIGN(0) =3D 0 without validation, bypassing the per-process=
 VRAM
> quota check in reserve_mem_limit() (vram_used + 0 > vram_available is alw=
ays
> false).
>
> The fix adds post-halving zero-size validation in the primary allocation =
path
> (amdgpu_amdkfd_gpuvm.c). The check happens after size halving but before
> reserve_mem_limit(), and uses err_alignment_size error path to properly c=
lean up
> the allocated kgd_mem structure and mutex.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1e71829e0fc6..90a4a68478f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1795,6 +1795,11 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>               size >>=3D 1;
>       aligned_size =3D PAGE_ALIGN(size);
>
> +     if(!aligned_size) { // reject AQL queue with size < 2
> +             ret =3D -EINVAL;
> +             goto err_alignment_size;
> +     }
> +
>       (*mem)->alloc_flags =3D flags;
>
>       amdgpu_sync_create(&(*mem)->sync);
> @@ -1886,6 +1891,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>       amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags,
> xcp_id);
>  err_reserve_limit:
>       amdgpu_sync_free(&(*mem)->sync);
> +err_alignment_size:
>       mutex_destroy(&(*mem)->lock);
>       if (gobj)
>               drm_gem_object_put(gobj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 309510e23315..bb0a2c615326 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1200,7 +1200,8 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct fil=
e
> *filep,
>
>               if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>                       size >>=3D 1;
> -             atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
> +             size =3D PAGE_ALIGN(size);
> +             atomic64_add(size, &pdd->vram_usage);
>       }
>
>       mutex_unlock(&p->mutex);
> --
> 2.43.0


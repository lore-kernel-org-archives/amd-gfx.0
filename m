Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41962C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 13:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37AB10E9B8;
	Fri, 10 May 2024 13:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kynSF2V4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1C910E9B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 13:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpYVPUj1fRmf77ALhFI2jYDESZoMVgIyZBDUHKmUIB7yyV2XhWyggE1iGFgAjdWnhcQl45dXQ55kIQfBDpiQYdlmj3OWW8mnYYFG2ZgMtyalohGsyNx3ZglMatjGbJx0m3q+Iy13vAz/NhYrzrPsV2OOivcFG++X2T6SQKa4QCkvy9zcldOJec8YgWV98u2JxyAExMDAwOrNqtaZvGXJF4pgyNH3rBMSnGRExQdPZIvD2b5jJcKvJ8d3KLmqYlsHdh8ON32IuK856cMZdI8QFiQMpR/Aw3HJSLPx601TjEm5unCkST5Exapm3X6PYtjk28NBxhW0IGgF7BV6Od1ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG7XksQz3f5snbbzCiPFFftzIikB9azaGXqsLU4+nRw=;
 b=TcYeYmCN3yf4cSPO1ylShXH7XsILyG36Z3jnrM/NZEvkRciT3095//jd/9xuLOjsSiMnHNfMrhseE6Q9H3GCNljMRn3IMBdYqjubA4wW1gvX5ODggOaQEaKNOqfviuCcFdOseX8GX0JpmcvLRugOTI50sQ5pEGrSCGDl2X0OEW5YZ25u2+oVf+rEOhfI4o1SWJeeqAcau4hshXBtRFnbqG4WiS8ZtDioTsi8JyX+3TJ1U2DcOEsgZvXPLXzBruGIvXpSyWbjxHVdLFTUBCrd2XUxtoSTZBM3lXXGmib8ew2CiP43o1BYtQgx7TZz4OsnkkP+DOpSpxp1QDT5hVONBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG7XksQz3f5snbbzCiPFFftzIikB9azaGXqsLU4+nRw=;
 b=kynSF2V4oVO0/EkUAfE2neTdWlN+H4sVEHGBuRS1bkbdC4jJVmJUpFBv+nZ0bbJhZlERjE7N0MKJemyiAZUUuNH2b4BZJo9huHF5x0LZUfd0LnmvKB2nskFmfqeNAS4OMUeHOWfcskK0elpCdsVxLwD2p4fPYZbkuvYJ8NlRiPo=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 13:15:29 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 13:15:29 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit
Thread-Topic: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit
Thread-Index: AQHaopZvF5yrE7ZyUkSQM2Spr9QcVLGQctUQ
Date: Fri, 10 May 2024 13:15:29 +0000
Message-ID: <BL1PR12MB58988832B0D636510D2D190985E72@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
 <20240510045541.533908-2-sreekant.somasekharan@amd.com>
In-Reply-To: <20240510045541.533908-2-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57ad51bc-03bb-4c9c-85ab-56e18aefcf23;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T13:14:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MN0PR12MB5905:EE_
x-ms-office365-filtering-correlation-id: e87ef7a2-3ab9-4845-7058-08dc70f343bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?jzhixUlrJ+jKCQXuJPPpSpj2kac95Thm/gssI+9q1SHiUkex7DkEi7pS5Zkp?=
 =?us-ascii?Q?IqEJ1vAINNSsCgXoZUSVLjBLSbmUoQ76+LB1yBH70YuB+pRsymjD2ElaNiyw?=
 =?us-ascii?Q?kaEjJ0kDPuI027vyjYuy17knvmP2PBugO0GteYz62jlSfM9cUlARfR/LGkfg?=
 =?us-ascii?Q?uFhgQq5d7grnmCjAsthtWVi+F2jmYPjOS/Oh44UL3mjdROM+IgZooflIJd8/?=
 =?us-ascii?Q?Aj369uLFRyaRXkhqTNRy+jyehUKAQv7vwL2UIP8avFiUW4MRhEn6/w6TjeaO?=
 =?us-ascii?Q?1c0OJLvyvDg794bOj/WcUKg8eR8GD7siYBx22ErowKMTE5rY4HVolK2/VS2w?=
 =?us-ascii?Q?Dag7c2de8Ib4wAGNImmxxbvLNe6TjuDxONBco8TSjG8r+776fhbk/HcvuTC/?=
 =?us-ascii?Q?1djIm621mJ7gwaUJYizVX04cCeqOA0e89XrIwG5qGaWPNbgPdw1fAM1OWtqC?=
 =?us-ascii?Q?a0JFpE8Eu4OpCWcJSB4zsOpZP6iAVXm/DI4XXGYYeYiiUBmPtpovru6YN8xz?=
 =?us-ascii?Q?MKiNjgaWfKpPqiMpnr7VL8IC0CEu0Pv3x2rd+SbaAXf8xM/7ofNJR3PrJ2L0?=
 =?us-ascii?Q?tTkbhqxSf+WA1hCCI1EA6h8B6QJqkaiXVzG0NGnCJDrJkdGGZNQwX4GdCvR7?=
 =?us-ascii?Q?U7LZfKV1wiOdoQGU+kJX8n1h27dXJb4YMEp20d9xxyo/L0zS9dRcmyU5cag6?=
 =?us-ascii?Q?MMP5w60CutvPW27xLRnIn5gag4YArUdGsoiVMAieG6/g9BPAgLC9czDB4Ifq?=
 =?us-ascii?Q?tLitat2nO4mtgwJ0N+l7PgFwPJI0zT/Qi33Z5o68Tu+WifCboApkgJBAXlxu?=
 =?us-ascii?Q?fq7taaKPkyMs+cXyr2s5AFsFbqp2kO1izMlb9m6jNiZeJQrav5WN/ZV2Jvvn?=
 =?us-ascii?Q?ogWJRbjda4hP3nk2im9bqBi6aWFPWgd44Sck7+4m47a9WTIBTCw1ozAsC1d7?=
 =?us-ascii?Q?T5ZyNpAcQStda+Yaapya7seOwvSwRGdUJsz/wXtUzgWqhzTKulLCJdApJjnB?=
 =?us-ascii?Q?J0HJLaupRFLhbiUNMevnE37aQBIvMV8ZZXeBTPzaABVXyf8Gf3NmT/OQFSdr?=
 =?us-ascii?Q?lPCp+IIrEdzzcs+UpQ0ckuRhHz3muHZA8VsX3hKbGYXzuH8cKWyCoq9usTV9?=
 =?us-ascii?Q?De/oIMfJIQ1ETcTO66LJAoU/x9exF7Z8+DpCesz1+T/oEZPmbMXlGKNUaS0K?=
 =?us-ascii?Q?Ce3OcSDFNM8Ks+HOQI+BRLYthZ9fl/B0wvcwfzqTiqlEHz5LznWwFP19tGaL?=
 =?us-ascii?Q?i76Ygqon6MdPtaioTj4xEsnUarqzFmQT0VpAzpM7d9AcLaFiPAbi3lsf9Gjy?=
 =?us-ascii?Q?9u2pCPHWNQOtOsf8dLGny0mzI5sWHjY0+LrL/Qk6zmvLIg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BohrgTpL8J53rzvyqaqnW4rgYnGd9h8AtG6r98GJp944PQkPPs+WNOtsjVit?=
 =?us-ascii?Q?bSaD1FIa5E7tB9N4C85pdUCR6U2woqScRCkVmWzleRP/Dk4Cx1XfSNkjHamD?=
 =?us-ascii?Q?BJDEWmc/0myTA4y7ywxy7U+a3iGOsjll/xfsaqrBQ421bCFOoylGkD166JMZ?=
 =?us-ascii?Q?v0YPFcyBI5ROjOsUMRCVA6CbA4iBYyunMGPMFBv85fwq9aFhaBXqaC16GkNy?=
 =?us-ascii?Q?QuIDhvqhQISPpCFGhhAjPgGy78qh+Iky6sVfDu4G0nBdXbJ0z/1aNSBT/GQh?=
 =?us-ascii?Q?ubuoCw52b/SwCq42cOFZWI6UgxbscjE38xDMVmuFWcPXXbekEuLOjhIKDQUz?=
 =?us-ascii?Q?V92PaFPg9zwce/8w7sgEwhwjeXDhy68OQn5bW9XU4Jmt4hqdEIMm42sOVgOM?=
 =?us-ascii?Q?I0U1uXo9L7y4wyZwfaHRqQ2cS8nc8ret0ljwcHlwXasHKBaxK8MOfiq2w6eu?=
 =?us-ascii?Q?gG921XhQgecfafPdy1HjxpKq449NMnVBu0o6wk3zOSNQDPr2LZLlUo7efczU?=
 =?us-ascii?Q?FLTBGf8A6VwyqneVB3Zje8rrmq/2USCl6Xmo2i/6Hu8fqGOBEP68LvPhJMbp?=
 =?us-ascii?Q?PBUB/CYS0oK8aI2GnWED9QDBh1WhOZDHI8UtsR/gCxY9cW1SRY174JHBM6nA?=
 =?us-ascii?Q?gI+ipkgRXpQunIWp3mpNJZsNhOJmTJDQnJI4QVy7+89zhoZRElCxPx/ugY93?=
 =?us-ascii?Q?FeQLfobvM1DegAQQhiCruui8hrByStRz3Nbh/IZt84zEWods7D7ZaMkuR3oD?=
 =?us-ascii?Q?qOI2fHJ+4WMMIb59ZMhiYAB2tV24MeclebU5z1sqQ4vYzFF/hJjFvYt7NshN?=
 =?us-ascii?Q?8b3FldD92Uvsehf7I6CxJ3FnxGKwBy2YQHLVzef4ElcvAMfgeb2hdACEuUCZ?=
 =?us-ascii?Q?TQg3IGijsl7zua1OqDkQAJEbX6tlwlKWQvyR8Vmk8i/vJ1s3K81PKvERrzky?=
 =?us-ascii?Q?Db/7XXeYQhumgJsEwX69Dx4DfisxEgKb66BPFi8jRPoUowI4eyjxKodrAz1E?=
 =?us-ascii?Q?GN0XtSqtx1KB9Ij7ENDv+a5vBK+t+iOL4pPNWHgjfZnO0F69r3J6rk1gJQBW?=
 =?us-ascii?Q?unbfrbFAabXYhkpMd7ev/lfG1y2S81F37RS4vSJPgvZlEQIjZwEL1Y1+oD5U?=
 =?us-ascii?Q?HLPEZz1h/mK8iDoqmWQHD71CR6PkqDlyQ/7Vj0cCoN/ZXKTfC3qLlpczM477?=
 =?us-ascii?Q?YYKXlbvs7gfOaWtDsHzb4dK+xIvZ8HFNN5WkG23in0kfVosSqWAoMVIzhFx8?=
 =?us-ascii?Q?13Cbw48/y4DbrbqEyeyROqnDUKBEhz4R5MBhPTAS7pYXHPtXoJdAEFb6eDTA?=
 =?us-ascii?Q?lwUyOmsE3CZsK5nXVOD5Oq3R8Pmb+lU79RrUiGiDNn2sLYE4+u9lsf41QR9Y?=
 =?us-ascii?Q?Hwp1Bd34IgHR6EqVNQPu5QT+sJynQ+iW3FRJoR61NnThoMpvJD/u5KNPkUUU?=
 =?us-ascii?Q?FTe+DepPrQTl8XX1IkXEBQBWBhS0op7FKdPoFvu5bHHHY4/PVopRLR1ASlKp?=
 =?us-ascii?Q?qBeixrNPDwfdy9v30YP8GQClTkK5CjlIGVvSQP5uR3N/SlvYNMB/qGL7c0s8?=
 =?us-ascii?Q?6m/AHCyPbfx11LGslhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87ef7a2-3ab9-4845-7058-08dc70f343bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 13:15:29.5429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZksh5tLVvttU7CUENXC82jhp4lNhDwa6XEi+kwH0qAwz5v6VoOym+MF1hdYjuPjp+HopCEgf2syU7W2LMrtCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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

[AMD Official Use Only - General]

You should add a Fixes tag for this patch.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreeka=
nt
> Somasekharan
> Sent: Friday, May 10, 2024 12:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> <Sreekant.Somasekharan@amd.com>
> Subject: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit
>
> This patch rectifies mistake in previous commit:
> 'drm/amdkfd: mark GFX12 system and peer GPU memory mappings as
> MTYPE_NC'.
>
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index df0363ad1a51..6eb370609d01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -495,7 +495,8 @@ static void gmc_v12_0_get_vm_pte(struct
> amdgpu_device *adev,
>       struct amdgpu_bo *bo =3D mapping->bo_va->base.bo;
>       struct amdgpu_device *bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>       bool coherent =3D bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> -     bool is_system =3D bo->tbo.resource->mem_type =3D=3D TTM_PL_SYSTEM;
> +     bool is_system =3D (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) ||
> +             (bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_PREEMPT);
>
>
>       *flags &=3D ~AMDGPU_PTE_EXECUTABLE;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2aea33d2c4d4..6175800f50f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1253,6 +1253,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>               }
>               break;
>       case IP_VERSION(12, 0, 0):
> +     case IP_VERSION(12, 0, 1):
>               if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
>                       if (bo_node !=3D node)
>                               mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
> --
> 2.34.1


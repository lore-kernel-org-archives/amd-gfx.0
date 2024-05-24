Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB19C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 02:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC6A10E075;
	Fri, 24 May 2024 02:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zi2jEtxr";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0C810E1CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 02:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dybuQ9RpahzAX+xL9xRWEoOoPrBvQyw9w5UkCBX+/ZQDacBm2gtL9pEx80zcOALqKqXa5qzPqb7mTbQVgc4Upp2ouGDP4Yl7UhJ2T8TDaFzl7EdvB5j4WbbPdg+stt+n4lBjANuQauSZ1ZmounEd2zHAJj6PD7CLFi2PndneCxrT78WQAssqNpernTfERZzmLZx/JrbisWhwla+ZXRw6pbKt5hH2UcMZ5ewnO39w4UafPVEY0tjZVIjoNW/MvfGQTXfmgadxizUlZOJip4BgJBvV+M5AKwJvCRINHAfSt0RE+ulgwZ2BWTHSMHS0FctUHoDHzO55M0WMO//KFnolrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSACiSiOErRagd9EhL0UJ9kUejXDLiS3dru5m+L2aSI=;
 b=KYsLHPRNO1XI89YRq2QgWTFTM9E8NXGk4c9SNTBZAOK4kfsLOaktgnf9+1Lc8zT5ns6C1fDt02zw3yPcP2+lvxHiSheF0JjAGcZefYdK5oGSi8R9EPIUlXcCI7Kwqh6H16vckX9T7fFJtdg4lf8Olx/3B43WfrBQFebhMMjCp8yh0r7WWiBlF4qXOyYopx4tPGM8B0ETOB6LmhcTaUGtLiovCcWfU4db0Bao+A1WBroBord2duR/GRTQNWYEE/SSLuTio23LIdMbenwAKT5AIbs6E7Dr1vEHuyRPRyqaCJkkmlfq3MgerQw6Mz5U78umbDRxN9Hb5qVajuSXC6Nl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSACiSiOErRagd9EhL0UJ9kUejXDLiS3dru5m+L2aSI=;
 b=Zi2jEtxr+mOea3dIdaf7qeWi47MP28PWSqfA+BgZJVpo0UacZoDCK79bhdiWQlWht2+tHII3XjxKnX/MqNU5/Wufl/UnBSVunI3X5runOzPUvuGTDCKoEPrkQwQvhfqEnAdSfStLe1EixE9gKYhjXaEPNPt0Xb83XvlmflAbRYQ=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 02:16:20 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 02:16:19 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: simplify APU VRAM handling
Thread-Topic: [PATCH] drm/amdkfd: simplify APU VRAM handling
Thread-Index: AQHarUCHP4gpIO8qP0utrxtb9O+QR7GlpKuQ
Date: Fri, 24 May 2024 02:16:19 +0000
Message-ID: <MW6PR12MB8898B871604637E9DA76B7F5FBF52@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240523183856.1067664-1-alexander.deucher@amd.com>
In-Reply-To: <20240523183856.1067664-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3a783b3e-1a4a-45fb-8b3e-fedd51ef12f0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-24T02:15:20Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|MN0PR12MB5761:EE_
x-ms-office365-filtering-correlation-id: 3c1f0eb5-35b2-42ac-ba6f-08dc7b977feb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tgnk1d1Efi1T6kFQj8VO0UrU6Y2vaLWfvFrIOsXXbZkZlOcQQcV0fuvlDQ1B?=
 =?us-ascii?Q?wLkePfLRjcPoPzPRIkS/VBFr/w+r36xo5obIzDncRn3QrjxxHlx4QUOOGptL?=
 =?us-ascii?Q?StNGmyyG88Q/SXH8ooU7EQMcdL5s0xM7pKdZTNy0hKpTUYD4zmE4KWVOT3Lr?=
 =?us-ascii?Q?iwVhTlrD24s6KhMRopUKas/m/WVf1TnPymUAtlyPVIHRAsc088HETuOC/OgR?=
 =?us-ascii?Q?jAy5kH/G84AJc9hPAbPuPlrQwQS3hzeEgGsE2iTkPAnxEjui4GP4h7sWNluK?=
 =?us-ascii?Q?3S7YSIRVSHl8aUDzuvZO54RPj2N7RWUQx+Kao/2v8A53EZBS4QV6G8/dbfng?=
 =?us-ascii?Q?GQ2lGREOMn5iOGc3XVd9i0rdokTEVR45f+H+kWebiMEtFFLsnU4YBeReklmo?=
 =?us-ascii?Q?ZyRcOLJVKUtXrr6wBHoN2TxJ7t7Ikw/daI1KRNPoCMr3K1Iox5pZenhSacXA?=
 =?us-ascii?Q?FMjhQbtHxaIqIje336F/RlZ4AHc2XqHsjldVtNbcC2Uz5ifncSpkH7owgE/n?=
 =?us-ascii?Q?TgVIbsok4Uxz2KKw/wL5iONgKCxa4As6DqACLCdBdhdJaFfARmBbWFqJ749u?=
 =?us-ascii?Q?u80oZ6Ter24BCfiylA1HSZzSWa71HcFK9y6Dkuu3wQfmLAABPkBGsL3FyYZe?=
 =?us-ascii?Q?muH560Q1jTfk9wk2h/KCWIzB0/mmUzIPWnbrn7B/48pAU81mWBAacDk6FYbY?=
 =?us-ascii?Q?H5VFQe2Rjp3GJOyR6B1NR/KrhRd4TAKXiXK+TsD6phjE7et0jdtpN+bU1lYO?=
 =?us-ascii?Q?hJft02jXbscwp9UlxtqKFrJNSasV0fKSSiMN7BbFGaBuCnhDut5EjmYoC7/l?=
 =?us-ascii?Q?X6hEA3Fgn4+7QFxw+0szAKMsGtMo9z08wG+sWQJAIlvDANGZbXAZVqR7CyvR?=
 =?us-ascii?Q?kY9r9nyZUSETJ8EYe7oEhHfzeEpXwlKk4Ep6Ux3JUvhowhoAVwbNEakY4rJr?=
 =?us-ascii?Q?i69nXoS/KS2SUgNX4weWiCX6UuPa197i4YS3VL9dZILl1AEy/YkoaI7h5/Jz?=
 =?us-ascii?Q?URaBdLQfJBvvhhogEg8w9pTtVnWOteuqdssIOdv7sM4EASK7Qhm8iSujbkbf?=
 =?us-ascii?Q?m2KlqyrmLPUWggHFfwnDD3yEbUsxLH9ToCHdhUGbcREUcGXqKXGKUgUNYCf7?=
 =?us-ascii?Q?Z5nhUbDRpHqX4cJsHiLYdHL1FaZaqoDphMu+r4m+JyNkrv013LbkkGoq5rNq?=
 =?us-ascii?Q?G1ROujWungS2W0UjXY2AgbUEjjKUTeuAfbbTL36yIyHh/qgBqH6+LhOYa9tN?=
 =?us-ascii?Q?EOfxGMGCjtF1TwmUn68CLhvsJuDDdFHoeM4X4Hiny//9tyLGApQYYtzIgmTd?=
 =?us-ascii?Q?G4ViFWSl7X9uIfTFzlBrmrdrC1rVqT5Tbzo2rWJmfJOWxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dioaW+7DgU9b5UmZnN5YaFdcGduVVRtYeo2L1sd8Ep0qDeDfuegVrULpGZ7v?=
 =?us-ascii?Q?aQ4OFnro/HuaA9Xj3IrxLiug9ianahg6JlqPUVPVOHDdLuCbKAKfsjLx43gV?=
 =?us-ascii?Q?gQ371ZNRcZM7YZT8XrvfeUVA8hYVHTLHVpajKFt6ST0NtZQJ+Czw9XtO6t0J?=
 =?us-ascii?Q?QjOJxPflZ48FBBruUjrnAecPE7WptY6BEgQzAzSD8O2MKWWdyWRGHfFhlX/t?=
 =?us-ascii?Q?w1+6q2R7lea03anydNSUyG8Dk4FQg2WcGOCrGNehm+rB5MyLsznA03IoBAeq?=
 =?us-ascii?Q?3cU2yeFuzcwjWRkaMPln7KcXHxu8muXxY+15iN+noOvA8e6QwKUM8YCtbZCs?=
 =?us-ascii?Q?9CtyjoGajR58PXTdbpgxVsejZnrhnKjPRHgAXRWt7Z5Qs9NHQWrg5x594TZB?=
 =?us-ascii?Q?eXMvM2/fDnlnqJsNeySH+ifS4tht/53m9OoK+GLILh4XYhtAFM3rfONny27o?=
 =?us-ascii?Q?MwS31XstqBlb5mPrXIAv4gUOPlpZJ/KF9Z0rKKT7+J2IqxBTSKP4oHvDp2AW?=
 =?us-ascii?Q?DDngIiJ0gfwbbemj9whaGUapBGhJkpSQnUwcVAbw/dxFkioA8UEytPY3Zsf2?=
 =?us-ascii?Q?mAt+cdLOceR0smnj0mT70SXfWZz99zcLezx5XazJXWt8x2pOMzCxj6x3zXfd?=
 =?us-ascii?Q?IKg0U9mo507RJ9jVp7ktwIl4dhlX8kMwwhsn+NUb7J3jHZQ+++DFDTPlx56e?=
 =?us-ascii?Q?6CNoDW4FckgfMnyiLG3SM7VKgv821yL4PAtJ8Ri6Ze+3DnTC1ZKpTTASMhre?=
 =?us-ascii?Q?Vd5YblE0P1mMnA/QxaWAQGF3YD6zMBHsBKThQG9YLrDMS4jkf4V3yHfp6Ew6?=
 =?us-ascii?Q?qUvRIuLaSB6obuZTnBOO9AkUmEU7zidwLtzO1NMeDfkLU+5wAbV96nk57fTB?=
 =?us-ascii?Q?vgxqEy/n8N3molhp/ZKPdzse67Uudx4ZRJ6db+U5/CENl4LGquA8LX2zYWgm?=
 =?us-ascii?Q?GNYO4n8BLwp4veAehGYjapgOP3cUztUxDJBidZ8SbhNaCGG2Guw9ZM2ifKLT?=
 =?us-ascii?Q?3y7h9hPrn1eRuCSgJClrfUaH/N6gFf00NElFhJpS+7ZREHE/PFNEv7NfxVkT?=
 =?us-ascii?Q?u2EbXO1i4u5AoS9jqA3Q9L31PqN21IrnqHE2wl/tIdcBCaMTrxW1VWsDKROp?=
 =?us-ascii?Q?Gk465SXL3rKcUtFumYBnn2+ynyI/KmG7uejYQHGatyyGcqt4vnYF4B0LuLWf?=
 =?us-ascii?Q?O8PwuFfdHazIzn/fkoCstZHlF+xfLPxSZgbPuK7YP/viTfYQ6zVCFAF+Q7Z2?=
 =?us-ascii?Q?ToXWWa3LX3MXmRWitxCTzGFVkGwK/A3S9J67QkJYb6jaZ3/ZKYfTpppBqT6S?=
 =?us-ascii?Q?OSEQtp4M9serRKKlLN/eE9aKFwwNpbaDwEBF0Sh/xeZsCP0+enJLNPb6VYNW?=
 =?us-ascii?Q?Ju9jx2boVCpTV3kyTYy8/euMYM1G7M+sk/KKI7hsGa5SnqjGGUw4flFlwSFM?=
 =?us-ascii?Q?klRUcnzJVrUlLph/5ezv/QWUdPx5SwCN4EIE7VnleG42KPmokQHtayjoe5Ql?=
 =?us-ascii?Q?odEBJTl4ZaCrgqslA2syS6zTamnHSdazx4M/Sq8DBL9dZu5dwpww4S0tRg1d?=
 =?us-ascii?Q?/H8aeJM41wfUPOIYhlI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1f0eb5-35b2-42ac-ba6f-08dc7b977feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 02:16:19.6071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXC7qPmq+Tk1OU+DG4hcTB4a4RM7pWd9ASu5sRvB2GbrUefUYqY3+DouLKGYXECJxYKQkgd7HKlLYi/A99RP6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
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

Hi Alex,

3 places are missed.

--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *ad=
ev)
        if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
                return -EINVAL;

-       if (adev->gmc.is_app_apu)
+       if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
                return 0;

        pgmap =3D &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 91175b1bd9ac..4885d1b2cc29 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2631,7 +2631,8 @@ svm_range_best_restore_location(struct svm_range *pra=
nge,
                return -1;
        }

-       if (node->adev->gmc.is_app_apu)
+       if (node->adev->gmc.is_app_apu ||
+           node->adev->flags & AMD_IS_APU)
                return 0;

        if (prange->preferred_loc =3D=3D gpuid ||
@@ -3349,7 +3350,8 @@ svm_range_best_prefetch_location(struct svm_range *pr=
ange)
                goto out;
        }

-       if (bo_node->adev->gmc.is_app_apu) {
+       if (bo_node->adev->gmc.is_app_apu ||
+           bo_node->adev->flags & AMD_IS_APU) {
                best_loc =3D 0;
                goto out;
        }

Regards,
Lang

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>Deucher
>Sent: Friday, May 24, 2024 2:39 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>Subject: [PATCH] drm/amdkfd: simplify APU VRAM handling
>
>With commit 89773b85599a
>("drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs") big
>and small APU "VRAM" handling in KFD was unified.  Since AMD_IS_APU is
>set for both big and small APUs, we can simplify the checks in the code.
>
>Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++---
>-----
> drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  1 -
> 2 files changed, 8 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>index 336eb51c4839..3af00b57cd8a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>@@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
>amdgpu_device *adev,
>                       return -EINVAL;
>
>               vram_size =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id);
>-              if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>+              if (adev->flags & AMD_IS_APU) {
>                       system_mem_needed =3D size;
>                       ttm_mem_needed =3D size;
>               }
>@@ -233,7 +233,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
>amdgpu_device *adev,
>       if (adev && xcp_id >=3D 0) {
>               adev->kfd.vram_used[xcp_id] +=3D vram_needed;
>               adev->kfd.vram_used_aligned[xcp_id] +=3D
>-                              (adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU) ?
>+                              (adev->flags & AMD_IS_APU) ?
>                               vram_needed :
>                               ALIGN(vram_needed,
>VRAM_AVAILABLITY_ALIGN);
>       }
>@@ -261,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct
>amdgpu_device *adev,
>
>               if (adev) {
>                       adev->kfd.vram_used[xcp_id] -=3D size;
>-                      if (adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU) {
>+                      if (adev->flags & AMD_IS_APU) {
>                               adev->kfd.vram_used_aligned[xcp_id] -=3D si=
ze;
>                               kfd_mem_limit.system_mem_used -=3D size;
>                               kfd_mem_limit.ttm_mem_used -=3D size; @@ -
>894,7 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev,
>struct kgd_mem *mem,
>        * if peer device has large BAR. In contrast, access over xGMI is
>        * allowed for both small and large BAR configurations of peer devi=
ce
>        */
>-      if ((adev !=3D bo_adev && !(adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU)) &&
>+      if ((adev !=3D bo_adev && !(adev->flags & AMD_IS_APU)) &&
>           ((mem->domain =3D=3D AMDGPU_GEM_DOMAIN_VRAM) ||
>            (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
>            (mem->alloc_flags &
>KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) { @@ -1682,7 +1682,7 @@
>size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>               - atomic64_read(&adev->vram_pin_size)
>               - reserved_for_pt;
>
>-      if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>+      if (adev->flags & AMD_IS_APU) {
>               system_mem_available =3D no_system_mem_limit ?
>
>       kfd_mem_limit.max_system_mem_limit :
>
>       kfd_mem_limit.max_system_mem_limit - @@ -1730,7 +1730,7 @@
>int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>       if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>               domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>
>-              if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>+              if (adev->flags & AMD_IS_APU) {
>                       domain =3D AMDGPU_GEM_DOMAIN_GTT;
>                       alloc_domain =3D AMDGPU_GEM_DOMAIN_GTT;
>                       alloc_flags =3D 0;
>@@ -1981,7 +1981,7 @@ int
>amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>       if (size) {
>               if (!is_imported &&
>                  (mem->bo->preferred_domains =3D=3D
>AMDGPU_GEM_DOMAIN_VRAM ||
>-                 ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
>+                 ((adev->flags & AMD_IS_APU) &&
>                   mem->bo->preferred_domains =3D=3D
>AMDGPU_GEM_DOMAIN_GTT)))
>                       *size =3D bo_size;
>               else
>@@ -2404,7 +2404,7 @@ static int import_obj_create(struct amdgpu_device
>*adev,
>       (*mem)->bo =3D bo;
>       (*mem)->va =3D va;
>       (*mem)->domain =3D (bo->preferred_domains &
>AMDGPU_GEM_DOMAIN_VRAM) &&
>-                       !(adev->gmc.is_app_apu || adev->flags &
>AMD_IS_APU) ?
>+                       !(adev->flags & AMD_IS_APU) ?
>                        AMDGPU_GEM_DOMAIN_VRAM :
>AMDGPU_GEM_DOMAIN_GTT;
>
>       (*mem)->mapped_to_gpu_memory =3D 0;
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>index 9c37bd0567ef..70c1776611c4 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>@@ -201,7 +201,6 @@ void svm_range_list_lock_and_flush_work(struct
>svm_range_list *svms, struct mm_s
>  * is initialized to not 0 when page migration register device memory.
>  */
> #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type !=3D 0
>||\
>-                                      (adev)->gmc.is_app_apu ||\
>                                       ((adev)->flags & AMD_IS_APU))
>
> void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>--
>2.45.1


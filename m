Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D23BC36014
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 03:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BDD10E1F3;
	Thu,  3 Apr 2025 03:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rfzbO+3s";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D521E10E1F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 03:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIs+RMgYm/etg2AXcGflsWIHrg4DlS48BBjttG9iJDSl5svSuU2Hn9WKx5DBLIN7V5aOslUNgIxqwMekYXShvihIQX7YoCmz+sC44TAJgQapKvvgkXUEijDFjGSIzfiLIDGLNGAVtHjEwsRZhMvfubHr87v3E9ci9FGHH/IcqSAre5AD3kQvM+qWaUszMhS07s00b5/74Bxz4UFG0/q3dc0aEfAKnoNRbnRKuzVcYaO4cSajZIT2t7CSsrE0ByWWO+emXjNGeyhbus63OCYl9JzKD8/PZ9PUohd/U+MMWAYRQpphPd31E38VCZRctWfiO8l3N61kHIEg2IwRwV3AJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaVPk53enQDKe0OgyzJ1qAwJU8/TGvdwd6YodlPFiW4=;
 b=HCAnXd12o9UYwRPzZ3F/MD8MEhFWC+YTDlfZXdzU1DsLBRL6uBzs0qsuyvft4m0M87fcwtwZLlVO7JC574P/MwP/IbpYIw6BU6775w8HtifVhMUWNCFe5PF7UAQqzefFQmKkX7+NtppcHL8jwTieG0IiouZq6Zfb50i9sz38DiMBWwMOIOeqCXIb1JKLyf5RRqbjIhwIKbdXmQxkDDpgjOlS0JxusDiIz6MG31icMDPuo6qeqWbyqOinaNTpLbHupn0Pt30YouVvqY4+PRDu6qCzpy1JLLXCyyMQEwmzq3oyFlNAzDTs4E9fEKA4YoMHOVyJHIx9nBm+a9fTfSi32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaVPk53enQDKe0OgyzJ1qAwJU8/TGvdwd6YodlPFiW4=;
 b=rfzbO+3sxD2YXHaTF5K0D8hL7r86s32pVoZpjavR3GME0Fu1EofHD8/DJxrtwyb4ziukEUupFH1MsO6Y/kNq14Tvek1nM3GqgifYTIps7xsMGwaXfJFc8LOPTyp3i7aCTIXQX5Ig1+WHXHf0M41VHht1k5XnhUA72XUuGQscPNc=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 3 Apr 2025 03:01:56 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 03:01:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable ACA on VFs
Thread-Topic: [PATCH] drm/amdgpu: Disable ACA on VFs
Thread-Index: AQHbpBzaVuzbaTXJeE+qhtJkq0u+DbORQQfg
Date: Thu, 3 Apr 2025 03:01:56 +0000
Message-ID: <PH7PR12MB8796818F46DFEB1AF4C16976B0AE2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250402221544.110496-1-victor.skvortsov@amd.com>
In-Reply-To: <20250402221544.110496-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=47b37be9-f6fb-4cd5-87a7-f90bbb69329f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-03T03:00:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB8344:EE_
x-ms-office365-filtering-correlation-id: 4edcc6de-1c91-4b20-5da0-08dd725be4c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rFjAbWnTUN8RACEQJSXB9+WhozfJxnv0ZdMxC3CIt5XCq0xjxIV8UUqOvvMy?=
 =?us-ascii?Q?Z8Dyp5O7vVSQJx/6WIKqJkShfn1EInb//5fzGind7UZd7Z5oD9ZJoSBdqoco?=
 =?us-ascii?Q?RXNykCPiLYAVvBILUeGsurtsR53wik9iwpAbfmgaVX7J/z5rWkvRCVKOzhD1?=
 =?us-ascii?Q?yxgXWFK4Y3h6Wf2TM39dW9nT+4qkkeydZ/vydDm/0Hd0CF2D9LRB8jeW+DbO?=
 =?us-ascii?Q?BQUyCCwFbCqsJK7hgrwkkcVCCxDQvF018BGiwnXYl0ihxNmT8udBsKBPy6iN?=
 =?us-ascii?Q?Ro5HYPTQc0ZlwOiT4J71MlLwx4auBrr3vuRU1MhiADl5PIYjIzMB4Etosjkv?=
 =?us-ascii?Q?z/Qd0ar8b6rAArDfjys9IEPcEwWHGC5Z9csgeilVk9enPi3V6RhOHQo6yGWV?=
 =?us-ascii?Q?MKxCVlAzJeI0oHzNZgfiS1+SXyO0qXGc4gxNrOVUPRIfJfboJlT5rh0P3Est?=
 =?us-ascii?Q?G4Fx/WGndJFktMLMkN5hemAHKTtj7D3uzV6swJmyzZltFki5STsCHbHsCSbs?=
 =?us-ascii?Q?pAXRUphVzMDoWKvpaKQfKk6lxhTyZYbPQZ6nmdkbdxDIlfslK8uDKbHcNpy2?=
 =?us-ascii?Q?wt2UqJg8t+2wKqOdCijnNFOksJsrb8Thx/uiLVQaZivfpdKMjv89xKTACGbf?=
 =?us-ascii?Q?0iHDKr1OMNHIGPMHMVpWJfCSWY2nVfdcM/XVOrUcFSTz6t8Q+ELJ15lb9QXn?=
 =?us-ascii?Q?YBeRltWo/RSgqDQuIS75UyR7F2nh/dgKVuAAjqHM7akx6WAaRx11V7vhxLGu?=
 =?us-ascii?Q?thI9Z933SfA/CWbfMb0RGLRsml4V9nE3lbrWUYRUwcylyi1MLYw1tOrIsL1d?=
 =?us-ascii?Q?fZ+VLwttjO2L9IlROv88TLBQu4XMRy+INpE/ku8sJrXvpFGQ5/Or/AzfC85X?=
 =?us-ascii?Q?9NDJUaGsme/i9IRhVrrr/Y5hsi1fC8bqTorfrOmFdShg74j5mh/rJ2hamBLx?=
 =?us-ascii?Q?8LKeKrf4FSpqTNpRrGOoqaw522xtubFnMhnMYW3bn7i5ZLgtplNcNiAWGTm8?=
 =?us-ascii?Q?7Nc73tYsZVDmXJzeFB+SYVZC95tfjAIF1v/oP8RDOcHOxT75hDgj14wT6qbs?=
 =?us-ascii?Q?4W3DM5n0+wZTyF9M+iwaaqKbDvhc7b1c3n63IhnK6D0L8tJESTnrt1SXovPj?=
 =?us-ascii?Q?egjTlslMLYF46l/nzmkgL6C7EbyA6wUUDfEQXd06ZIXRt4DacZmbSsM58KBL?=
 =?us-ascii?Q?vAgIylpwAsRj3rvz0SwjX2YZfR/8L8rdAwXhv9tMwW8yIRW0VXCBkHutE6QC?=
 =?us-ascii?Q?tLuiYWmY0Ke6kSE9HKVGl/YXKK5cp430FcgQmb7/vBv1s7nN0kxP2P2rrTnE?=
 =?us-ascii?Q?zX1PpCfIAKT1C5U7YeAsU57mtVxJ1zJ1XRpZ3YtqfEsTda9iV9tQjNWZ9+8a?=
 =?us-ascii?Q?4NOKzt9w4EV2EkzlGEZSsPom906+KTgCnJFjQp6N/R1KxAHVmEOXXyKmaX7x?=
 =?us-ascii?Q?Bc5cUB0068eEYWTmt3DlTaqxA3+XB1NM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ESJPwGYJyuqXAmz8IX0MPmbyJphzjS532lZCxoYyy9WKXUIW62RD+IaQ0yPo?=
 =?us-ascii?Q?acvLsQcA7bH3YvTrBzWge52CA+OV6HmaFUgchfsOwJ8R3N4ymtoSOn0aKxHA?=
 =?us-ascii?Q?N0y1vx1dLsuzvJsvxSR7lfpgl34H5YCx0dN6s9HMEfvMHkcnBF7a3zKfODfp?=
 =?us-ascii?Q?BWu2UKbEkU4NlBXmJfw4K7uYf4/OmFRIw2ud2yUu5YGe5syTn2TTDvhYCQsp?=
 =?us-ascii?Q?okdHWESXaZxq4Yk5Bi+imhOblVYopYQGHqBDwzI8TCRe+cf6ISqUF27lwe6s?=
 =?us-ascii?Q?yuXz0PcwQKPOOS584yYQr9NbJN1qwhlEDlQ4juYUsR5cHEdWqpIeKtbe7rVw?=
 =?us-ascii?Q?0owW5ZqrwwS0fK6CYkswjBXFaQccGqj40e1Gt2pXvjdNhVAA6Y0sCp21psfh?=
 =?us-ascii?Q?5dK6kb9GffQ9N9D56hLzMYtN/GOqIt4DTnfJ9Ud30FtdYOIfpJQXyZrF1pca?=
 =?us-ascii?Q?byho3FiNZYxo+8ZRkoZvJJO/smMCFXc4ZBbEVoL0VxiAxEaumcH9o7gDOHcB?=
 =?us-ascii?Q?rOxS7R8UAnVbQbMjAz5mOCpf2yNkJ58nk9dnJXSKyzWJwkYW/e4Zc6k6aPdm?=
 =?us-ascii?Q?ZFhU3VVqlM8KU/1hkOJ6gQd9oBoz70JG+0sdgpZgT+sHOUFUs5pFJd8qClrw?=
 =?us-ascii?Q?fJHLv1cT/KOXeGQ38GdpD5XyG/iNEypxii7rSg1SiPjfhXn66D6TwV5JZbq7?=
 =?us-ascii?Q?xKtRPYgjD2FqE9342zPrXK+Fr68HXWrTt/OsPZBbIY+TWjMP1lyedB4q0KC3?=
 =?us-ascii?Q?SNwMzcCq36y2oOw3dS+LpiNiey23UFCuSgB+aoQhRc20mh6I+J0urmzlNTlk?=
 =?us-ascii?Q?326muQhwLy21t+GbOswLu8GfDCrnHuTwMvyLtvMpUPUa6vuXD8i4Mt7uLnun?=
 =?us-ascii?Q?vGxKJP4XXEIKOWesyqcwl00RDrdtZMk6uTtGlt7xW14YbkZ8ys4PMm4uDY6f?=
 =?us-ascii?Q?exI6l07oLWaaIL/3OtVzINIAYXPLYRjZCKKkIjySqfD1h494+o29pfIpOWi+?=
 =?us-ascii?Q?r/qWFZnZyPsqSNIBmPbki1gkDussiyIdZ3laPwEQudJaX6AGj5jlW6oKyU6S?=
 =?us-ascii?Q?XwmpP4CjGj+MGsOjxoWIbh5f0F80u2QISz9Y+LwSUG90e5TCMrJVZ+Kuki+t?=
 =?us-ascii?Q?JhZ/ARFJnlZ0wf/hbnfjbTotmaCd7pOy3gPzKh5oZFlftVjHsS0cE0zyyMc2?=
 =?us-ascii?Q?swkyQtapbKADpoKU9/r9VEVahfKm9Awj6YbX0X2Cz59zXxOhn1SQRyYsaRdU?=
 =?us-ascii?Q?1vZDRMbKzI1SFou1TqGMmdf/GFpuEAyfR7KFZUltQHsRr7oWFDUmjIpOAvv8?=
 =?us-ascii?Q?ZI/N/VjSK3mMr5dpHZJ5cD8aQUvKlXbVIGF67CdaTdFEICFtwW2JXxYyvEWs?=
 =?us-ascii?Q?IJT1kKc2FGD/C/2cCGP4scPoOKUjp0kgZHn/JOVsKFXOgBFljYRyG5xXjuAS?=
 =?us-ascii?Q?N4/fE0GgebVTNAiLvjtTKh/hj2nJj1Nf8knmqePJxC3u6TUVlz9ISu2rGIVa?=
 =?us-ascii?Q?+5+YTjMbfLOe0+evZ3fUIik63h+Thy87PfdgjDxCu9VE9u1MBQm8wOLZ/zZ6?=
 =?us-ascii?Q?V0/oQy+cS8qpepODTNU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edcc6de-1c91-4b20-5da0-08dd725be4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 03:01:56.1324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 797kTQz+8D31vqoh/BXfLYz5YDksawROXGTRmpOmx/rh/vvx9z0jwLWmXe3u+Ab+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
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
> From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> Sent: Thursday, April 3, 2025 6:16 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhao, Victor
> <Victor.Zhao@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Skvortsov, Victor
> <Victor.Skvortsov@amd.com>
> Subject: [PATCH] drm/amdgpu: Disable ACA on VFs
>
> VFs query RAS error counts directly from host with
> AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY. When ACA is enabled, an
> unusable aca_sysfs is created rather than amdgpu_ras_sysfs_create()
>
> Likewise, VFs depend on host support to query CPERs, rather than ACA comp=
onent.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |  4 ++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index 360e07a5c7c1..5a234eadae8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -549,7 +549,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)  {
>       int r;
>
> -     if (!amdgpu_aca_is_enabled(adev))
> +     if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev)=
)

[Tao] can we put amdgpu_sriov_ras_cper_en into amdgpu_aca_is_enabled?

>               return 0;
>
>       r =3D amdgpu_cper_ring_init(adev);
> @@ -568,7 +568,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
>
>  int amdgpu_cper_fini(struct amdgpu_device *adev)  {
> -     if (!amdgpu_aca_is_enabled(adev))
> +     if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev)=
)
>               return 0;
>
>       adev->cper.enabled =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ebf1f63d0442..5bb7673fd28e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3794,10 +3794,12 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>               adev->ras_hw_enabled & amdgpu_ras_mask;
>
>       /* aca is disabled by default except for psp v13_0_6/v13_0_12/v13_0=
_14 */
> -     adev->aca.is_enabled =3D
> -             (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 6)
> ||
> -              amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12)
> ||
> -              amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0,
> 14));
> +     if (!amdgpu_sriov_vf(adev)) {
> +             adev->aca.is_enabled =3D
> +                     (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> IP_VERSION(13, 0, 6) ||
> +                     amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> IP_VERSION(13, 0, 12) ||
> +                     amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> IP_VERSION(13, 0, 14));
> +     }
>
>       /* bad page feature is not applicable to specific app platform */
>       if (adev->gmc.is_app_apu &&
> --
> 2.34.1


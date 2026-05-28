Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48206CD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25A710F1CF;
	Thu, 28 May 2026 13:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YsEvEIi/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018E810F1CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifYAHr89kAZn+TjTEo6mQjlFPdeTXfSGj1DAIVFt1cfTyY/RNjlfthhYaxQP3QnymGwHKzZwbQFVOISCqbyKYK2p6uRAK4GyKC81ZYTBljvEkZjAWa3mbiQxLzR8x47BWawd14n/J4/Ex1RVBvoS5rsY4hxzr8lBPzGiuka65JZ2/yhPqW14Sk6v8X5SCfK4/8SgoSgGBDpLeHneXFAUNkGCWZ0pWqr1CNq6JiahGLHvsKmeBi3PQemYU9Soe5Ukj1sBgWo0iPSLrjpGVrlL9F75Ctjpp2ic0HzSUE3pu2pCVitWNtghjt404MFEr9jGg0sBa0uba5Z4vlSZpN666A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgAd7siVlNy/dVHWtLd8Q9rdMyjilQ0fe40eOEbxowE=;
 b=CdwdibcpCYFWTXxuJ0vuSFDTOQWIeDpp2n9xnSDjyhM4e9SmCPTdo9n6tgGJhTIrZa+vU/yNHe9KyKAZ4II7AsxL//D/XKLmCmZyPWmbpcj4ZGchouLI+EB2KGfhG+DbP6rGzuU72WBHUyH00jjw0wRYYozebPv5xCE/WxG5jm4U96fwdzJ8ndkK/mCPmC+8Fx909iZeqhxELbr6YVDpU0tV0LBkBcAuuFrG9jK3MQk8vjC+0pZeSnuWaR/2SudQbRoRB4GU8veAQQQ1WShJMRZSO8YoYTwlEhJNOfrYKjMxEwIgZ1ESnxOFhN9KxksrDB2FTzgm4Fhnu6MsxfYNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgAd7siVlNy/dVHWtLd8Q9rdMyjilQ0fe40eOEbxowE=;
 b=YsEvEIi/xFOlGPKqAmTw191avZlRjAcXKtF3uQ5R8FEzJXL6gbmPM8VTFXaR6zI54UA/i/tC6l1nmifAx08G0LNFpuVxUTnnybS2wPphMl6DuygDkT2kW+Ve/VeDdi8ajow3ExheQYo0ziqrcD9/NNqwOoPYIEtXQibv8bfBcGE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 13:44:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:44:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/8] drm/amdgpu: add support for MMHUB IP version 3.4.2
Thread-Topic: [PATCH 6/8] drm/amdgpu: add support for MMHUB IP version 3.4.2
Thread-Index: AQHc7m0tfWoVYTfx7kiplLJL+lf8jbYjc0NQ
Date: Thu, 28 May 2026 13:44:25 +0000
Message-ID: <BL1PR12MB51447BAE8074328D17344399F7092@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
 <20260528064206.12358-6-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-6-Pratik.Vishwakarma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-28T13:44:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB8364:EE_
x-ms-office365-filtering-correlation-id: 89289f47-5655-4aae-a589-08debcbf3bcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 7SrTwg7amULU/r/SuIT9nnf+tWzJaPzie0BX68l3ekNIs40Qx/uOebB2jVMIe+9Pn9NCoNNTJ0MiSaWvzPn5T0j8pFooqXcuG6gfA4xIBLmN/LltEOXEj734uOCoMHiMnx24/zYqls1/YuGIcLr1TlApJx4iO8uKmc4//V1qHArO1JU63i3UX4bpkv3+8CEKgY/wOXzBB5tPYpHUyFPUclA8vG64vF/KPe6ixHwWv5S6GT3ofIss8lbmMtroKy/k2Sxf9ki6+z0KblMcH7bHsFEZGeQdLfH06ulkiOXS1zQ+4g2iYjd89no+3hLtJfptRz2OYn6B1spG5lQsJfIVosHqbfuuHh81zs1EBqwTkECl/yNyjJDpCMidYuemFi4R94YbX37a5WvaXPb3aRkazJURDX/Cpg2DFexQFjJiCARGjgLWUxJ6CQxOozDNoZhcKHOMKyLRytUz87Wev6kWl0Nig0brsCPqKqTkQ8gl/1cGjOiVMAq0PNg3tdoLC0W+lkLKqe3wlaKESEuH9FbV3tVUuvf/HBT3l4UgV2YBUYgf/EQAt8DqMpf5KGhWNUO3Selxn+88/ZvZfIvVGECiK0UjplGoWFBkKXV/ysupJp0AM7UdG/GtOjB6j6lmZzxaMYslPkEdGmfU75ncPypxbwsBhRJl6Y+CFSH9L+myVa+/xZjBCukMjKFwlY4VCpxnXVFpcxARu/8ApEQkBeC+HrgW/wSwhxEFLzgl2zdDjCZxjYgI3lb+NSDWXetfmYSk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?66uFrvhK8+FTO1+RuMrIC8ViZNpU+icsla9vJ69hHJqAQh8cnludAvi93wUC?=
 =?us-ascii?Q?Mpaz2jKN6LUNtDGqD47FzKj+mMt6LBj7cuAyZV5ui+ih4d3L4s5lBkCDwQW+?=
 =?us-ascii?Q?P38bx6eae3pWwW6LDDD7qVdOiApntX+oBrtRyoikpVL+czHMLFPAquz5YffL?=
 =?us-ascii?Q?r6kC+pMj6YvBMZm4bwocFybD6VAWi6hhOCtgIBrYwQaeVvUVJD7UYgi43eL5?=
 =?us-ascii?Q?j/YQbOiX3ZQLtLJIqFrA2JV9fiWDhDX636BeDndMlEP6i79UQIjto4q8TK2x?=
 =?us-ascii?Q?+xvieNB/fWgmNfkuP7sa681KjkOnF0TQQnPJ8qjItEkvToOfCExrdItktqGT?=
 =?us-ascii?Q?4wuxmN+2qkY42Tu8yIPsFKd8YojDELn9q0CsL5eiKlAaJczaW9h3C0iSJanf?=
 =?us-ascii?Q?c/xCQzzvkFylzKLTC+6OSwh2CuQmZoF0RiSqnxvE2MDPxCI6oZZ1CI0D7IRW?=
 =?us-ascii?Q?bgW/tNklKRbUV89Ikdt6E2Wpuqv65mTELhHkxOtT+h3EWG5LXmXkU2WTYYzK?=
 =?us-ascii?Q?B9nhqjSmE7zA+R1WoVQeSwhGUtNQ1zrFt9HXkhNjJDG0YbUvm0TKSglmFMhv?=
 =?us-ascii?Q?+N6qlavnGunTbhagzeacpVgyHnYutkLG8Bl2qqEv2iIdSBx27Y1NzQa4QncH?=
 =?us-ascii?Q?AOLfYAG9RdqYcBjic6FkWo6oXkREex4bCCgwvh8d1J38WZAz64M/NPs5s9ah?=
 =?us-ascii?Q?o0w6+/n+cZjpYfQwxN1U5TCrbZgW86YB9z5/f74TNg9ck3PKZsh8t0ipHwO+?=
 =?us-ascii?Q?WtxKQYe84Jfcbvnk4OaeERd4BuvqjMTR5Uj84x1M4QRMfffTHkkXhXtpi27Q?=
 =?us-ascii?Q?wo5BpoScl15GBbdoUluZWv15nAFeeX9M75RFp2WetfmV1+d+N2keIPiiCG4+?=
 =?us-ascii?Q?RWLrq/hq+T6xxFat84+spUd/NWs2VWCeoRqQnxNDjv0Ysxd+3s58Ph5Z/aJD?=
 =?us-ascii?Q?Ts6O2dg1tSVvRnmcNjzTvEa68wJD2Mi5FjwMCtyZK1XOtML4erHA6Ab9jaJu?=
 =?us-ascii?Q?EKv19LXJcW3FBfE0TTOVMJKuBZkeLCEjGdcWMamJISazKLj3EEBwmbAQUIX+?=
 =?us-ascii?Q?SuGOGlpel2Wd02wQ9ICubt5PHIym0UJUUO1119OHTEYN+6RiPIu7VaeP1iTf?=
 =?us-ascii?Q?HX74OG/L7qMnSqTs8wc8oi3jIhebHrSKhAKt8kqSsRCd5JQKpd2auD3BvKIc?=
 =?us-ascii?Q?bCHcScehP2vGx694CZFcm8xl8PGQfan0KF3yThO75DOAClreHKAQyXav2Vcr?=
 =?us-ascii?Q?UhfdmDbPTtNqLY9nSCwWUGYSJ9Hkg0KRk+Jjr8izjqs9kGyohpfj8919nGS3?=
 =?us-ascii?Q?B6gR2uI0zLU15hoK5OpubZ6nJ6ZX+/AET8gblCcie69yDYPWeOOVcS/ECo8t?=
 =?us-ascii?Q?UWTr0cXdgMmsQu1f0FPuPU+U7YWqmeO6Qmh2wOo5knMo0wfg6Ow+9RpiQgbh?=
 =?us-ascii?Q?1YE2kyfshuwLiYKj9k+4AqNBWRKu+MkB0OlqMOH9i6/bPaMIIdYusOyFS+R0?=
 =?us-ascii?Q?cmO+vgdNnx3pMtRFDshTTFkp9hL5vOEtAwyJhcXRgK6DDoUBRXMuO9WTCXQs?=
 =?us-ascii?Q?ofG/XUJ6PLDCwVmRgmSTRVYeWfWn66ByFDmZrpVn7Eff9U1xaPi5AYXWYYnH?=
 =?us-ascii?Q?c5GMMbPYeWjC3LqoQtbOoSjf2DaWjVC/8+BIzrgs18lPW0enilqfVrvOgQV7?=
 =?us-ascii?Q?Jenk58sdgwaZZh+WJCZTKCKyAiigCkM62XhDo5+X4DzCZzr/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89289f47-5655-4aae-a589-08debcbf3bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 13:44:26.0823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlCusY8qWt1tkiQ36XdUua5HzLiR0OIy69UT1RbU+JmOKs9VlaoOAjAceBdC/9Tm4jFCwNz3K63llat9E/tn/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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
> From: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
> Sent: Thursday, May 28, 2026 2:42 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
> Subject: [PATCH 6/8] drm/amdgpu: add support for MMHUB IP version 3.4.2
>
> This initializes MMHUB IP version 3.4.2.
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
> drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 9664b7b8f0db..41ec28bbff05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -585,6 +585,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct
> amdgpu_device *adev)
>       case IP_VERSION(3, 3, 1):
>       case IP_VERSION(3, 3, 2):
>       case IP_VERSION(3, 4, 0):
> +     case IP_VERSION(3, 4, 2):
>               adev->mmhub.funcs =3D &mmhub_v3_3_funcs;
>               break;
>       default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> index cfce7e1297d4..292b660ead66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> @@ -636,6 +636,7 @@ static void mmhub_v3_3_init_client_info(struct
> amdgpu_device *adev)
>
> ARRAY_SIZE(mmhub_client_ids_v3_3_1));
>               break;
>       case IP_VERSION(3, 4, 0):
> +     case IP_VERSION(3, 4, 2):
>               amdgpu_mmhub_init_client_info(&adev->mmhub,
>                                            mmhub_client_ids_v3_4,
>
> ARRAY_SIZE(mmhub_client_ids_v3_4));
> --
> 2.43.0


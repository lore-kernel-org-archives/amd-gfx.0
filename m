Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753C8CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194EE10EF81;
	Wed, 20 May 2026 08:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sjZypQ2O";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC7010EF81
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et0yU5gLdnyd0awR2n+ME4fY31LmN+OKqxPCERcvK0GqL95lcaMuHrFZ1UKYVWnnzWc6hV3VWC3OSCVaTPvGsTgaXwsuGJI1dhsZ5WSL/johF4oDH3t6tNwcyodLS/dHaUD6lx93jXwDtGqqch86JM1tHsgScWmTaL4E4+gnJZHAwUnyY8C8mljwoJ3AHCwdnXNPSOFl/jRu2ubLFbiO5TgyPKo1TDNHc6Cga/tYjRop0eh84fghIO8U4JDhZ2z/rNDCLeSPInv1Z1bUataPTNQ1EGCaNGONKoUIlYre8ImAC+2Fs8yM3PkrwgalxBIFynlCWKcpVqsJPS5O0VWroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lui23NCkqipnEWKzE2gSFk/3kW/jlh04UF9hWo8ciDo=;
 b=j1aT9r/Q/p7ZvYlOtrR5PTymi7dx5tsne2GUeHp53KClfUykLrsf14gjsiV4Nq3eELOhHPmd9AvvqbhaSEoQ0tCxGCsNBcd2jy0e9pGg11FgtMPrvM8rhZyuUejgkaHC3z1LnJEhA9JNc/NfDI+S1PgtylZdy7uLlRhGZDhioKNITAmwEnuXXreU5Sq6vBwB3fuWuAg1/vQBfhQ89vuJ70zwxvdEbowu6TSBmH8xen3epOuR5mFVPNOR/2rZijtMlUhj0TyF4ipESnd7J48DRWH6e/e0pvUTePhJG++ogQiPhAuEcpYATC4wS0OSV6dHMaVb688uyS++jbY4B1W2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lui23NCkqipnEWKzE2gSFk/3kW/jlh04UF9hWo8ciDo=;
 b=sjZypQ2OetJYVKKNjOvqqBdUcFhOmE3owEHfMRX7cXhsqLBBuEGNuFr8xW6pmT5fmQTqtACv14LnF1z9MW20QwAP0vx3/9dhdrx4lZwS5erDaU5DXEV3Rt6WOqLQK7KDCV1TofZlGHHZcjlMd5ZYqbQgRB5dcQaYrTktoYq18jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 08:56:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 08:56:10 +0000
Message-ID: <933edeb7-9f7e-48aa-a798-feb5c0cc7738@amd.com>
Date: Wed, 20 May 2026 10:56:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu/userq: reserve the object before pinning it
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520025258.1866776-1-sunil.khatri@amd.com>
 <20260520025258.1866776-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520025258.1866776-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c291c5-3b5f-41d0-98a6-08deb64da322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|4143699003|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: fmmxjwraKPZTrX8AU8/mnGDH7IlRd6KG3iuWxkq0HrzyaZQXKLlEU8bDmo/TJve1XmaTJ4prgwv48WYPyEgP20u8s6ADRPVRp4Zg1GTjrOze/jED7hTIA6w0eoaBrDUMrBVyqvqPpH72JdWdVtD8vdVP+Km0+cK1D3kgHforiqOU8Lk8tNoPUUpnBjLHCpk4vu2Tu8o3y+ezyE5SBSf+mVUBBC8oUSq26ADSnAGY5jpTLGrQ7IH7FUVBrG0GFvHqntVbSuWLPsys6zNBvz+E6sa1SZAV13yX0u2Ie5eC3ZxDA5wmgSSFH894e/17r4BcXvk1EruiNV4BZqRQMAKgVtSpOntjMlZqxHJmPbzvF+jV+csNAmaaSz9Yk7IxMpRD8dhE68PuWKmqFwZUbJn9gwuN5MtNu/QWRYE9UE869BsqscfM/ESkXIw6Uh+oEKQCECsSZUsxp1tpiGmbM7c4oDNlHRV4rTvixp3LMMrG7146CrOv0kWugTMvLPQrJ6j+0nz2m8FtjjKwPAeXVotc7itsGl1fRzo4cqIAI1v1T1McX4xJTGmYjHawSXPGYuM32BpErsYgY56A8cMJtwGt8CPJX6flkISITI4k0CloCxbJhVXiX124/fiCZGB2vuzfx6QS/z8liIlePySvZ45mNIfWc0X+IBTMeHTrzpwEb2Amm3HSNXayMAwLYGZi1kMa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpJVGFUVTFBSmZUanR1QmFLbGpDUzJzdjNNOHlGMmo0aWQ5MWhrRXU0Ukdk?=
 =?utf-8?B?eWZKWGFOaDFsdnhjUzRnQ3ZZbUozaW96WHV1ZXBjMWJmbGJ1OUcxZ0tUSmVQ?=
 =?utf-8?B?M0p5UldIdndvQm81UFJ4bmx4TlpXSkpqRXh1LzB4cWVLUktVa2E4ZEpBRmhP?=
 =?utf-8?B?emRYRlF4eWI2QTBaTit4S1Rzc0k5ODFVc1pvNDZhNDlXdCtMTTROSkd1aTdo?=
 =?utf-8?B?UzYxK1JjMHNnUFh0d0dxaWxNNlJMNFhvVGNzb3ZTdGtJUlN2bDF0Z3lsQWlt?=
 =?utf-8?B?WEYvSFc1YkpYZkIxVVJDYXNxN2Z3WmJ6QkhIUk9hcVcvQ04yQ1pLZkE1a3Zw?=
 =?utf-8?B?ZWdFaGRxQkNTLzUrREcvdDVTRnFFQWxmZHRRVnNIK1kxWDNNbkw3MzJQVlFi?=
 =?utf-8?B?bExHbU80dE5mTmRteU9zUHBEQVhYL1ovUytndFN1UXNiSURlbmRTL0Z6WDlS?=
 =?utf-8?B?OXR2c2dXMEl6ajdUSFM3SXRUWG5ibGtoUW85eWxSRllGa01HNVVpMnNNK3dG?=
 =?utf-8?B?d2VxZFc2TG1SRnM3TmQ5TGJta2Z4QzQ4b0RXRHEvTWZKKzEzbkk4NU9wd1VG?=
 =?utf-8?B?eDZmM2NrcytldTNuRW93TEQ4SkxSSGl6WkVKTUp1dmtHZ2JnWUxIb1BTcVpG?=
 =?utf-8?B?anRtNGZ0aVc1OGd1NldKVW9WdVZFM3ZxSlhldTNNeTg2Z05XSVVycjBJOS9K?=
 =?utf-8?B?YUIvc0p4YlFwYnpjTk5aNWxSZjJhcjJxWFFsRjlIN2N1d0F0aVFSNWt4YTht?=
 =?utf-8?B?T2FtZ1ViK3JzZndQVFFvUDNvRkJmamI2cCtWTk8xQ2s2TmJWOGYySDNZeU40?=
 =?utf-8?B?dVMrSVV5SGxFWElpWGRvbkJCaUtNekFEVlFmYTcrMjZuTmwzcy8yOHkwRkRE?=
 =?utf-8?B?Tm1xTDdjL3QrY1hlTTNSa1RrWTNlaWJkK1d1SVRsUzF4MWFhZ015OW14Z0Vz?=
 =?utf-8?B?eFVJckFiTHVWc3lZZWF6eXZkc20wK3JsQXc3TkQ4ak5pNFBhbzZWV211M0hD?=
 =?utf-8?B?cUFsYTNEUkNzbVRPbVFZWDlhSVgxRldIRW1rZ2pvSGVlNkM1TWVXN3QydVlz?=
 =?utf-8?B?L056VzVFc3RUeEpkMGVoeUxMNTdWOGxodG16K1J5TFQxNDZacG12L0ZMdm5C?=
 =?utf-8?B?eFJCNXoxbUFNOXFwUWl6Rlp5c2grWGliTHQxem9yZ1hKR3NaMmVPWGJOS3dH?=
 =?utf-8?B?NkEwcVBxZk5SQmZTaHNKSzdmYXJsRGNjeWVkRmlxOHBKNVhiZmVlNCtLSU8z?=
 =?utf-8?B?S3dUOGU0N2NCUlZPdzVMeU1ObG4zUzR6SGE3SHhJL0FqeDF0S1I5Y24rVkFn?=
 =?utf-8?B?R2FuRTc3RDJtTlAxQi84VXArRDhsUUJ4T2c5bXozZmdkMklzNjVsR0xrODh1?=
 =?utf-8?B?VGFCSkxsQ3NIaVRYeVVxWldTZitXWnpnc1l2eUJKdnZsU25EME1Lb3BaaDNN?=
 =?utf-8?B?V2crYTlkeVl1UlMvZjR5MmI5RC9yeWtWbGUxUXRqeUZTb0JoQy9oa3hxaTAz?=
 =?utf-8?B?azlzV0NQZU5xQk91YVdjZG1LNmh6V3Y1MDArZWw3d2VIdHAzTi9sbURNeVVM?=
 =?utf-8?B?N1pTdUxkb1hNUTdqdnczOVl2eGJmTWVtRS8vZy9sdHA5ZVJyaFVDWHIvb25S?=
 =?utf-8?B?bjRuNStJTHU5UkhuMkoxTy81SWdnalZDSGpLV085Y0JWMWsvblBaVExTMlZD?=
 =?utf-8?B?ekdCbEZWWWtEaWVjdTEzcXNWelAxUXdDNGwraDNKbk1MRHMyR0Z0RHZseUs1?=
 =?utf-8?B?cElQUlloTjJGSnFaeFh1RzYvVHlqRVpuWm1FREwwYjZMRUs1SlZ6dzR4MlR5?=
 =?utf-8?B?UzZyTDluUnVJc1hzamE3d1Y1MnhoTWxWaHRwK2JaOE9XYUlZK0s3TjIvTS9F?=
 =?utf-8?B?RVUrRzJQaVlNbzN3d0Z0RjliczFIZTM1L08va3NVcXNoWEZ4NmhzeGRyMkN6?=
 =?utf-8?B?YXFyNUEwTVQ5YS8ydWJsQ3VYQ0g5dk1pUWtGVWZ5TkRIMDZ6WmtRcnFUa0N0?=
 =?utf-8?B?bDJzd3gzVllHd3I3MmV0bTRsb0VjUE9SbG41M0JiRldYcVZQY1Mvc1Jhb2tK?=
 =?utf-8?B?RG9zdDdxVFR0cjNkejl5ZU1wTS9uTUJ6Zlpqb3NmaVVtVHYycGlFUlNRVTJj?=
 =?utf-8?B?KzhCQld0Qjh2N2VrSEdpTUNKQ3JSVzBETG9BVzhDQVRsbE4yd2hOTzAzQWdX?=
 =?utf-8?B?eTkvdGVvb0NJOFBNTnJudU1aV2tzTHNaaXhHWnlOenlEdThTRE9EaC9jcTU2?=
 =?utf-8?B?UHl2b2gzT0RjNUVkeDhnVGRhTW5qeTRKUVR1c2JuWHlvYWY5VTFNcCtEeTBz?=
 =?utf-8?Q?8lowtX27069DrwKZeV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c291c5-3b5f-41d0-98a6-08deb64da322
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:56:10.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyrFZR3Xj1P1gQhfmYuwFA8G27KJ1IySojibGF3YjqJx7g8BLiVByPsQOsZd9zbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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

On 5/20/26 04:52, Sunil Khatri wrote:
> In amdgpu_userq_destroy_object, we should reserve the object
> before unpin the object.

Yeah please completely nuke the function and use amdgpu_bo_free_kernel() instead.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0607b7078518..758bf099f0bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -528,8 +528,10 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  
>  void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj)
>  {
> +	amdgpu_bo_reserve(userq_obj->obj, true);
>  	amdgpu_bo_kunmap(userq_obj->obj);
>  	amdgpu_bo_unpin(userq_obj->obj);
> +	amdgpu_bo_unreserve(userq_obj->obj);
>  	amdgpu_bo_unref(&userq_obj->obj);
>  }
>  


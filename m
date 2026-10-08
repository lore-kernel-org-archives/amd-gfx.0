Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9ABCA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 09:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6F010E785;
	Thu,  8 Oct 2026 09:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wOC1zW1w";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EABA310E795
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 09:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqHenNlD+gU4+zxW14fn0BK5XQyVEq/P8khGb91sOdVRf7lkJW3tYZjG7G9nWYJuU67HnHH7cf6olTThRz3jROJCri3hb4m1uqT9ghgIIr1DRczAHyvHc6C4QsaN2bZkRVxHT/RpZYJJnRnK8KiOO54MJ8qnyDkAT9ZK03ncGF718X0Yuux+wbxkIYma86HaSoaELAsbMowU9DDsVWVI8KZp6z72GsYbB4X1gXvuMavzyKq7QvoIVemai0at4TEVwh3LzpLLQuiknwmbYJg8lYMMoAyneaoBS8+PXZf+Z+GEo2uanEoVNEK1ATqo7FWEpl2lSvEY0F5MvNycJYwHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYGghZKuNb+4X3XgaQESB4YUBqToTzYW4uCmkOq35Ts=;
 b=tYVyfrVrQ20+sY3/zVqFLRva/iXSTL25/oRCO3KDo43vL+IUeuibc/014GJIwlbqBOu9S1BtbrLBQ0CuVHkoCC7q+CHK1StfRf4/hviHHxXz6AAamI4FXG3Y7l2hACd/nWzlW92e4EEirxc6cWGqsfv2Vniab9xXoGcOVJeGKTZGWM9tKy+6dl8xzZ3dIy+YtEAdTtY25VsFXezVWPDurN/wdwuudtzIAqmjonz9i5HwmhrpjcKELgjVTcVmcnm2LRV6IZ8a65bAdMUfcFqbJDvo+t8OdMZMbvdwGs7yrynLnaVlfz59vEcpL9L3XE2cS9efbyh1QGBJPKABfq6H7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYGghZKuNb+4X3XgaQESB4YUBqToTzYW4uCmkOq35Ts=;
 b=wOC1zW1w3uOstfjYATZjbMDZByineHNuXLDIEIEDfk2lXF2CJfJ5qjJvyOZHKht39R0L13pwl9dZRkyU2Ii+fZ33H9KmiILSbeF1DOjKmnPRdGeuuDmULIeWCAuO9n9eFHakBcC05ElCkynWhcHbogbvIMg+gK0UmIxZQPzpYfU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 09:15:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:15:15 +0000
Message-ID: <592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com>
Date: Thu, 8 Oct 2026 11:15:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: rename first_kfd_vmid to
 first_userq_vmid
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261008065234.2945047-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008065234.2945047-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d39c72-b449-4995-bdc7-08df251caa2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: cRsNpwV/1VQ5pdBzCyFwTuaKo+Zo30rt37z+3jV5xfnzIkn9UroCsqbVWGN3cPfCNACvHduiSo94XlAKKMqg/dnQidm2UfA0jDo22VVmkTP6Lrdgv4LAiffK8OFslZqdf7/imM7lFl7vTB9AYmA+3yK+DwdFMGFUxEDiBgLxRa1xlfGIe9kNqyEvsVi/Qd8YRSEEs6TdfqZQOYZs8DCNkYSf3Kjzza4sLvWWvq4kd6RWOoVaO28pn5gA24cs07Ydra3qDODkIv0ngZ5cSli9bfX+G7kG0AIPj91v94WvaQKUZc2XGyvVd2+KstjRjyrC7JFq2jh9jMKRF2kpyvJYdL5TtD4ilgGXWD6FU4hVa3Kj1KzkgnnqJI1calgGdg0tS0eDUTjABL6U+nScU1Eap+gifO/wizwuoy58cptte7rgT8ge34fnYAPq4pqkAGGgps6x+ZZ5Sgloywr5g0lQRm8sG3v+XuMID3yiJ1yF9h5exMtZIiTNuAMSotEPKzMKXuNdY+oQBByUF/OvdBgBo0tJ53uVw5Tkoh62Fln3M4bwN18HT31uGcPTMLMrU046UntNxAceURxsvxgqH9mco7GyIuqRAF9WA0mB9lQygM5F3I3Wlb4dCeh8Nd0lRm1b8JwTUNIUZeTknAQ3Vi9Nuk0Azhl+ykTEagv2piN5hCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZWQmk0VnhPczhNY1JTczhmSi9ocHQzZERld2NOT3RLS1Y2cW1GaVBoSTBp?=
 =?utf-8?B?NVZGVW5HRE8xODlKbVp5UUJvOUVjV2FMN05sczNGM2dyOHdjc3FrdFJQc2V1?=
 =?utf-8?B?UEtBUHRmY1Q4TU1xQUhud2pKY3dlcnMvOG1mNFBuUHoyV0JHbVh0aE8yODdj?=
 =?utf-8?B?bWw2b1hQdGs2L2N1c0RFUlh0MXZ6SklvdWREcWo0R2tlbHJlYVE3UVVCRXdx?=
 =?utf-8?B?Q09sYTd0dTQ1RTgzWVJ0QWNKR3lJdzdoU0l1WGFIclZaa2pCNEFJeXA2blZO?=
 =?utf-8?B?M3QxMUVzSzNQbnUyUDEzU1ZGVm5rV21XQWM3OG91T0ZIMWxRRGRJUFdlS21u?=
 =?utf-8?B?bmtrMlBrMTBaRGJnNjg4OHFGZzFZS2dFU3p1Ry80S09DemRFb3QvUVkyajY3?=
 =?utf-8?B?SVY3ZTBwVDBab3dDV1R3QWJ2bVpldHI3Z3d4WkNrd05GZzRZNzYrUGV4TENZ?=
 =?utf-8?B?WXIvbGtwQnZsQzRBWGU4cWhKMEJCbUtpUklEcVpLdlZ4UXFzeTVYQ2wyRGtC?=
 =?utf-8?B?c2dvYWpKMG1oU1Q2TUNOS2pEREhZMVRBSWJlZXQwSHBqNUlPQzhuWm1lV2VT?=
 =?utf-8?B?ajAyY21TY09aMTcwZmNLSUhHWjZ6bFhyY2psQ2QxVXNsREJUdk16VzNLcCs4?=
 =?utf-8?B?Z0w3OHRhRU9GMEc2VEl4bnFFVUdFSUZwTkVzR0d3ZUFJVmU1VVRTaVQwT0l0?=
 =?utf-8?B?VXBlSm1RVlliZGN0bCsxTTJPTHhOc25DdG1kNjdNM1pqNHI4TjA4UkZaZ3lu?=
 =?utf-8?B?cG5UZFp5b251azEyWWRGZXl2RjBQcitKUkJRZ01PcVNZNXZYY0tuakxZb2Fa?=
 =?utf-8?B?Z0w5bzRJOVpLSnBzOWtqSElsUDZveUoyWEdJbFk1KzJxcjEvdjQrelFWVkxS?=
 =?utf-8?B?QW1CelF4cHM0Z0toNUlFZTBNVGY1d3JTeCs3UkpxRG9uTmhJemdUODcvK2N6?=
 =?utf-8?B?UDB6ZUxudGl0dW1LWjlWU1hiUzRLMm9sNkVQR3JHNTRPWjRjeVBiTUxMa0l2?=
 =?utf-8?B?M0Zkc0FrRVZkSDJmNVlMMlV0UmY2RkNwZitVRWNQMlVXUmhzYlpGVXQ4U1ZM?=
 =?utf-8?B?RzhEUXJyaWY0WkFCcXAxeE9RR2NpMmJvUXlKcGlWU3BRRkg1ZGxoUHYvUHQ1?=
 =?utf-8?B?YkN1OVRGWDBlL3F5VFRaVFJEYStFK1ROeHE5WTA4T3gyVmNnL1RsUWlKbTUv?=
 =?utf-8?B?TVhRY2NSU1NJUVk2VjczL1RvaGxuZm5yQWNyQjFLQnBDemtyb2RSNXZ0dDhk?=
 =?utf-8?B?SUpRWkUxOG9YUGtPOXc3UGtnY2U3ZjdFODJrVHI3T2Y5L213T0lMSjJBN1N1?=
 =?utf-8?B?UytzNTcwWWE2aFMrSVhROENXWUhGU25yNmdmZFJsNHNqQklGSXYzZWJ1L3g4?=
 =?utf-8?B?UlgyWFVLYmd1L0xYK2diOHAxSG51czl0LzgydWNuSm9pS2toeWQxY29na2NM?=
 =?utf-8?B?ZzVSblE5SDM5VjRzMmdsZFFpMFJTYll3Y25VeWRKTm1CdVhjOGIwZnIybW5l?=
 =?utf-8?B?RHJtUXZzUXg3cDVBbkVNUFhteDBLVU90UFVaUms4TUJETFFHVlNrVHVpTGg1?=
 =?utf-8?B?elR4UndtMVdSSGhuUlNBQ3dRWW15ZUVGZ0pVenZDWm1nNWg2VldCME9XejJk?=
 =?utf-8?B?TWhnWWdnUGhOQVJqZEpGeXlaS21tYWtocDM3T0t6RzJRdXZJRlhPd1pSS3B3?=
 =?utf-8?B?OEFvVFpTSmJhbSt0eDd4YlhaY3NzTXI2enB2bEtkZU9BWjZiUnpJeG12VFR2?=
 =?utf-8?B?UnRtN1NKNGlnMENIbVdyemN2bTVra3UvVnhDYVV6R3EvVVhkUkVlWTlWTGtx?=
 =?utf-8?B?V3lhTVV5WXA0RG5ocHJDc2lQa1hWZ2trdEYzQ05tNkRHV0t2N1g0b2hVbWVn?=
 =?utf-8?B?akdnQkUxbDRqUkhFT0dncGFvaE84WUloZ25TMFlpNnNDTGZpalZnVDZwQnVE?=
 =?utf-8?B?ZFRnSmNkTVpiN0drbjZuUDkvWlZkOHlzYU1GQkVyOVlGUzRkNjJJK1NHV3Fv?=
 =?utf-8?B?N2xITm9uZ0pPc3lZYU9ySy9QdWMydjRrNlAvV1hYYmdMWERNa0RzU2tTRHIr?=
 =?utf-8?B?dkd3eUxuT2RTQUt5Q2N5TVdXeTVOU05JQ28ySFBxbUFmZUduUkVwem92Q0Fy?=
 =?utf-8?B?ZndPMXROZisxd1paRmlqeGZvQzQ0VlptV1ZoNXI3V0I5TnkvQmVxVm45MWF2?=
 =?utf-8?B?YU5Gd084REpUeHhiU2NNVzBrK2daRGVnRHpwUmIzVlZPL0VpeFg0ek9Nd3hy?=
 =?utf-8?B?RHVhYnRwdERVSnFqdmJGWDAvRHcyMk9FYXpEeWMwZjFlekhaRk00c0RkMHNq?=
 =?utf-8?Q?Aao5IDL0wfhaxz8aMv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d39c72-b449-4995-bdc7-08df251caa2f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:15:15.7121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5g1HLjHLtEl+zkZj7e4O10IJ7rVUWr6mFO0IOQzm/VoPsxYByaECrxQTkLaXvOxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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

On 10/8/26 08:52, Sunil Khatri wrote:
> The boundary VMID is shared by KFD and KGD MES user queues alike,
> not just KFD, so first_kfd_vmid is a misnomer. Rename it to
> first_userq_vmid. Pure rename, no functional change.

I would make that a mask as well in the same patch.

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 8 ++++----
>  18 files changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3391e8c77f13b..38eef8e7155aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>  {
>  	if (adev->kfd.dev)
> -		return vmid >= adev->vm_manager.first_kfd_vmid;
> +		return vmid >= adev->vm_manager.first_userq_vmid;
>  
>  	return false;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9cdd8870960a6..d2414b4656805 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -652,13 +652,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>   * @adev: amdgpu_device pointer
>   *
>   * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
> - * first_kfd_vmid, shared by KFD and MES user queues.
> + * first_userq_vmid, shared by KFD and MES user queues.
>   */
>  static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
>  {
>  	adev->vm_manager.vmid_uq_mask_gfxhub =
>  		((1U << AMDGPU_NUM_VMID) - 1) &
> -		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
> +		~((1U << adev->vm_manager.first_userq_vmid) - 1);
>  	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8e478d3bda1ac..4c407d705d0c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -383,7 +383,7 @@ struct amdgpu_vm {
>  struct amdgpu_vm_manager {
>  	/* Handling of VMIDs */
>  	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
> -	unsigned int				first_kfd_vmid;
> +	unsigned int				first_userq_vmid;
>  	bool					concurrent_flush;
>  
>  	uint64_t				max_pfn;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 33403e16df5ca..cd1f01604c4b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5214,7 +5214,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>  	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		nv_grbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
> @@ -5227,14 +5227,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>  	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	 * access. These should be enabled by FW for target VMIDs.
>  	 */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>  	}
>  
> -	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
> +	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_userq_vmid,
>  					AMDGPU_NUM_VMID);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index d5f428ac19bf3..7d66f41aa8957 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SCRATCH_APP_BASE;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		soc21_grbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
> @@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>  	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	 * access. These should be enabled by FW for target VMIDs.
>  	 */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 420ce997bebc7..9245fc1c95767 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SCRATCH_APP_BASE;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		soc24_grbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 4498e253846f1..4b7f90fa203b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>  		/* CP and shaders */
>  		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 549d1239e326b..0bdb800dafc64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		cik_srbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
> @@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>  
>  	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	   access. These should be enabled by FW for target VMIDs. */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index ab4123ddbb942..403ed29e7c0b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		vi_srbm_select(adev, 0, 0, 0, i);
>  		/* CP and shaders */
>  		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
> @@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>  
>  	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	   access. These should be enabled by FW for target VMIDs. */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>  		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1678015ce5a97..231dacdf16548 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2610,7 +2610,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>  		/* CP and shaders */
>  		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
> @@ -2621,7 +2621,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>  
>  	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	   access. These should be enabled by FW for target VMIDs. */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
> @@ -4933,10 +4933,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>  
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
>  		gfx_v9_4_2_debug_trap_config_init(adev,
> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
> +			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
>  	else
>  		gfx_v9_0_debug_trap_config_init(adev,
> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
> +			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 01ed1701c781a..1479dbc20c706 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
>  	mutex_lock(&adev->srbm_mutex);
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>  		/* CP and shaders */
>  		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
> @@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>  	 * access. These should be enabled by FW for target VMIDs.
>  	 */
> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>  		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
>  		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 490b4c4eb662a..259aca57a3ec0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -869,9 +869,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 3cdc7893587a1..daec00725b969 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -854,10 +854,10 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
> +	adev->vm_manager.first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
>  
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index fcc1d580fa946..f3e9759833b77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -997,19 +997,19 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 */
>  	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
> -		adev->vm_manager.first_kfd_vmid = 3;
> +		adev->vm_manager.first_userq_vmid = 3;
>  		adev->vm_manager.npa_vmid = 15;
>  		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>  	} else {
> -		adev->vm_manager.first_kfd_vmid = 8;
> +		adev->vm_manager.first_userq_vmid = 8;
>  	}
>  
>  	if (adev->gfx.disable_kq)
> -		adev->vm_manager.first_kfd_vmid = 1;
> +		adev->vm_manager.first_userq_vmid = 1;
>  
>  	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      false);
>  
>  	amdgpu_vm_manager_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 71409eb718d39..2fb3b0687ab70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -824,12 +824,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      true);
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index c95e097241bf8..1208822b6ef8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1006,12 +1006,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      true);
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 8d8a0775878ff..b21dc8fc6a9a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1121,12 +1121,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	 * amdgpu graphics/compute will use VMIDs 1-7
>  	 * amdkfd will use VMIDs 8-15
>  	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_userq_vmid = 8;
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      true);
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 85ba228f002d0..f9d2e82c34793 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2030,9 +2030,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	    adev->jpeg.disable_kq &&
>  	    adev->vcn.disable_kq &&
>  	    adev->sdma.no_user_submission)
> -		adev->vm_manager.first_kfd_vmid = 1;
> +		adev->vm_manager.first_userq_vmid = 1;
>  	else
> -		adev->vm_manager.first_kfd_vmid =
> +		adev->vm_manager.first_userq_vmid =
>  			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
>  			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
>  			 amdgpu_is_multi_aid(adev)) ?
> @@ -2040,10 +2040,10 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  			8;
>  
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      false);
>  	amdgpu_vmid_mgr_set_vmid_mask(adev,
> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>  				      true);
>  	amdgpu_vm_manager_init(adev);
>  


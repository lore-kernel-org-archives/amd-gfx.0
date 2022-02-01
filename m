Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4554CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Feb 2022 16:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7C310E6D8;
	Tue,  1 Feb 2022 16:22:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9F910E6D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Feb 2022 16:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/UltEleAaQ8/AaDttJ+uzl7+/ACVjASFOka4Xcvap2c55l0gvozyYz6wtFVZYD5smrI2x3Jl4ngx6ZMlke3Fby2Dz7EgnaosbgyAin6GtY/q8FGzafAvMfGEuvHG4lufhXJbqvTDHIbULWxxfW+stWfCJlryIuY9ox3fAeOFCgjEZWTFJ5XYxx9Qp9S9KeowwfrG/HrImkEO6vKTINRpWJoXxNmdCrFGl+nCO/n3p4G2cANG0QkUGmx03bEEPUxm1iRBcL91u//VwZsbnpQo+WSqhJS5IipGLiJcXr0du/R6T23sWibMiDselJ3uKYEMERlaacpnHL7oVj3NuaTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNDPQbCG+scpDZdTWWRkjbPssgLEKiQG0+vFWbOYZdY=;
 b=UJvmKGnsBLRvD2RMbvMyu0h7ZEcKFidjVD2K3+l/1TjkeJ3uu/6uwGDAOx9U1Aq4pHVviFqRmk0K3uf2uzHtPGNRa3zU0syPr2vd3SsmO4EVbEZr9/sPcr98lCqZZKg9Ff1dw1yJuvNPXpL0YnGWQ1Iin2lrncIwYqY7rZhIJLusypVYnSdb1Vgu/N4lh8rzYWgQDbMxcGXeMeM3J0/TTIgFw4Cndmx03RoYPQ3XKKjYfK2+13XNkSu01piJDn3BpTgZl+0y8na6iv8vzBesyjM6M2VLIiAjdJXSYP/S6wiov3yPJTZV1L9eqTHTxPPZRYWItn0v0Ufds7u8kzydHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNDPQbCG+scpDZdTWWRkjbPssgLEKiQG0+vFWbOYZdY=;
 b=ka656OSwjaNScU5NBoKSAT3VmKOI3Z6gG1rm6O7uyUBeQDbEP4QgJpV/AUYDX6QALns/Hvx1qs89T6Y1u7p6RK8Fk9GNmWA2TIJYjKnTaQGjHiD7TdoUhLDLjP3IfHgt6jAbKCGr2VdPR6pClwRrWocd+XUrKYH8/UPp1v9w9Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW2PR12MB2393.namprd12.prod.outlook.com (2603:10b6:907:11::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 16:22:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 16:22:03 +0000
Message-ID: <60325be8-4d0b-9b14-8a14-180de4ce15c9@amd.com>
Date: Tue, 1 Feb 2022 11:22:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: rename amdgpu_vm_bo_rmv to _del
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 daniel@ffwll.ch
References: <20220201152802.12159-1-christian.koenig@amd.com>
 <20220201152802.12159-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220201152802.12159-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9e38086-04c0-42f0-ede6-08d9e59efb76
X-MS-TrafficTypeDiagnostic: MW2PR12MB2393:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2393E1CE4260691F9915C20C92269@MW2PR12MB2393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daXBiynP8vUas9wT/A5/H/CbzCjnN8h14xQI/vXA5Pj6gJQX2C+x2USzKsXE2SLMKTWxGKPRkLUNz0ayJUYu3qGIcI0M6rEtHZCMs8HgDLGc06zDb4U9yZOXJyzWmMM4332RWwSHdnsHoIjfrYV1RiVTWen7yJT9ZxlUDN8JDrTFPqJWj7NbDo4vFbZw7Ij3J8TPFXq6hw8GvI79HQg/BB5u2caZ2Z0e97QV5gvolyFFLMmJRFXR0FtGYBrQSnvU5s4S6qkIhdtRXmdq7kLQUoplBRsMdsSKfY4qGAwUESp5xgta9QXdGKU4uVzp9Mzp5Mmk8Ijr9F19e0rb31U9stTnPuQyYqUN8D2K9gML2/hBGo5p05u/01JLuAl4bshwUXmPxrYNX318bhK+6XzEljBRqQnLz0Rwb10p4M8sPJ/+WTSTKoA9HaSRha9/7OMsb6qttRH3+geMkxMng6NfWdrMYwmJxqP3GRUNwnMyBIaFFXYaYdVvVzmmoUa4R6qrP9ysBBDNfoJ7sxIOADEp2MT1UhrY0O0GtSYzekNNs2DIughzCjkcc1jchrL2Am+Cw40CXuckn1BZk66VD32MZWcZX1BC7cdQzSSby65IQum/DdotEewJBZhMuDM6VLzijVaQIG8btJt0FvxNPemRvdNx0fgCAbwOYXlazDczv6fvUXvzPRw5u/mYTYLEb8tdp3v0m2qHpDxs+/ru5hmSFqMFuW2Bhy2uwII9gAyo3fqhRS/5hwgSz8b4xBZ0TkT2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(38100700002)(83380400001)(4326008)(6486002)(8676002)(8936002)(66476007)(66556008)(66946007)(5660300002)(6506007)(44832011)(2906002)(316002)(6512007)(2616005)(26005)(186003)(508600001)(86362001)(31696002)(31686004)(36756003)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXVxaXZhY2k4ZDU1U1ZkUEQwN0tmMHBDcDJuK3ZOQmN1NjJVV0FwbkxtV2VP?=
 =?utf-8?B?dEFXamlkK2k3UnlhRWhRYTBiVFdxU0R4NFE5Qzh1bDVuYWlwM3RiblAyOEd3?=
 =?utf-8?B?RFp6V3JuVnlZaWNQOEdBSDBBc0VmWVNzaXFmRUtQVlZYYVR1eTF4ZE9BUmZV?=
 =?utf-8?B?WEE4L2ZXMVJmUnZiOUczZ3lWZ0FUdzE4MkZxVHBjZW1rcFBXdWx2bkp4eTdt?=
 =?utf-8?B?Q2VTU01aU0NIK0t4Z1U2bFVVUVpRemhLYzlXV3cyQmJ0L2RwSk93cWZCUlBS?=
 =?utf-8?B?dEJtc2t6WHJHQ1hDa2hRclUrVFNDdWVxUnU2MDh1ejdPR2J0bWlRVS9IdUZE?=
 =?utf-8?B?dVpHS3ZCMzZBOXVCcmNjN0VhRkFpM0FMVDhKZndnRitrQjZUdi9rcVp6MUk3?=
 =?utf-8?B?S2VrdGFTV3NNTXlSYk5IOU5LZEhKY0xLL3RuRkdMOStOeVVBOXNkSHA5Z3hq?=
 =?utf-8?B?Yk1PbFN6YmlrY0JhRENyS2Z2WmdVQ2lzQ2FBclJTc3RnbklhR1BqMUJDOW80?=
 =?utf-8?B?Yy9Gc25jSU5tbU51U3VicHZNYmErdUo3aEs0UUlNMndqcDZKQ0tWL3ZzbC9u?=
 =?utf-8?B?Z0hlQW5OcklFWi9Feld3Z2lmd3ZQRmFGNGxyY2F5dCtMenkwQ09DdHhlTHN2?=
 =?utf-8?B?NjVZZFNDcGNuZFF1ZHZheVBlQyt6TEppZ3hrQXdNVGhqYnFObHVDaUJVcXFS?=
 =?utf-8?B?MW1Wa21vbk80RU1ZMlY4STNERi8weFdiVHhlZlNoOThKWm4yM29pcmdiNXRC?=
 =?utf-8?B?YlFUbTZsbmdoMjl6TDR5aFJUSnExV01oYWpTRW1MUlNhTlNpSkZmNnlzVmVa?=
 =?utf-8?B?UzRVaXBaZWFzTnErUzFOYjJHZ1N6NVcyRGRPU1MydE9jZndQcDlBTkNwY1h3?=
 =?utf-8?B?YXlaR04vM1pjbnA2RHJlR3JmaEp5d0pwdlNXVXh2MGx1VmxHTjBIcVVjS1Bp?=
 =?utf-8?B?NjhYVElOM3psYStCdFBRallHZndVTk1yQjhOQUZQTmtXbUZrTG1HVC84TTRa?=
 =?utf-8?B?MkdYZHNvYzZlajBBSkw1VWVZVGppK2Z6VXorRXFOeTFUM1NleHBHSHpNZHhC?=
 =?utf-8?B?MnNGSWI3aTV0MmozOHhYZnZRRVBpYW9YeTJROXJ2VmhnYTA4TDdMcE1kZXUz?=
 =?utf-8?B?WVAxNkpRamR3Y1JDUy9ybjRVNG9kVTM1azdxV0plMFdEZ2Z2a2o5S2x0VXdv?=
 =?utf-8?B?MXhDWnlEclBXS1NSYkJrMTBlNWlFZjViZXF2dkRUSXppbm9XanBSRTNaL1dD?=
 =?utf-8?B?UUtzaEhBdUdiWTZzNmJBN3E0M3cySGhHb3gyNXBxZlY4RHJYMHpDOG1pVHZV?=
 =?utf-8?B?aWRPZlFmSFpuYzU0M0VsRUEyU1F5R2l1cks5NGZJeEUvUFlUT1dwdVg2eVo3?=
 =?utf-8?B?bzA0amVnMHd4UWV6UldrZEVtRU1MUnpBc2JrSUh3Tzh5VU56SGJuRkRCT2FF?=
 =?utf-8?B?VjFsYm1aS0srZjNBSVk3ZkorS1F1UlFRdEE2ZjQ3ekc4M0s1bkNEeEN0Z01j?=
 =?utf-8?B?Mk0vMEoxcnpyUnRTZnB1YnZaZ3dHa3lOdFNqNnQ2RXNHYmI0Nis0aWJDL1hw?=
 =?utf-8?B?TlEySEhMQ2lqSU5OMzd6ZlUxbTZNSUZnV2djbUp1NzRyKzBiN0VDeGFPdktl?=
 =?utf-8?B?NEttWlp4eDMra1JneGY3TE1VMktQMmhWb0tKdjU0KzZvdXFWYW8yankwYTRY?=
 =?utf-8?B?akhIeXlxMG02cXd5djV0T0szUTN5ejZjVDd1QU5oY3hIRTkwM0FCTGVPMmEw?=
 =?utf-8?B?U1JYLy9SZWdYTDZ0VmxSakJ4SGVaa0d1MFg5UGxYdm1BcmR2R2V0OEVNeHVT?=
 =?utf-8?B?N2pqTEx1WXg4ZjhJQzdYYzdYOG1HZmRORWRqSXdWbE00TXdVcW40UXAzSDJX?=
 =?utf-8?B?RG9WZm9XVHUvbmR1U1JKNmpGRzVJOEhXYTdEK0wydWlkeFRXN0dGK3RnVkF1?=
 =?utf-8?B?bWo1WmR4bTE1c1hreWdNQTFZdUFHSndzVnlycUY5S0V1d3VRbUZxTSsvWFlp?=
 =?utf-8?B?bEdlNDd4YnRoM1BVcXd0TGtlelk4VDBKbkZ0OTdjc1JEdTI5NWNKbk9odHhv?=
 =?utf-8?B?RFgyYVdiMmFVdW5uUHhvY3NPQ1VPQm1HR1phNjZGWVhuWU84V3FxZXExcTVN?=
 =?utf-8?B?TE9hcS82c1U5akRnVjYrOXpKQ3FOK0tDb2RBcmZNaWQxaEN2eVVWVnRuSXNC?=
 =?utf-8?Q?tg42kG8FJlSIZSJ8eKkmMt4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e38086-04c0-42f0-ede6-08d9e59efb76
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 16:22:03.7354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/+VfgJOa1YkcSIkmhFE/CJVVu4CChopA/MTEqKs58lSmQR01wYJDTf05S5Rdv83kWLhjdMadGCyGupVmOhbqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2393
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-02-01 um 10:28 schrieb Christian König:
> Some people complained about the name and this matches much
> more Linux naming conventions for object functions.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 2 +-
>   6 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5df387c4d7fb..5d00a6878ef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -778,7 +778,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			continue;
>   		if (attachment[i]->bo_va) {
>   			amdgpu_bo_reserve(bo[i], true);
> -			amdgpu_vm_bo_rmv(adev, attachment[i]->bo_va);
> +			amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
>   			amdgpu_bo_unreserve(bo[i]);
>   			list_del(&attachment[i]->list);
>   		}
> @@ -795,7 +795,7 @@ static void kfd_mem_detach(struct kfd_mem_attachment *attachment)
>   
>   	pr_debug("\t remove VA 0x%llx in entry %p\n",
>   			attachment->va, attachment);
> -	amdgpu_vm_bo_rmv(attachment->adev, attachment->bo_va);
> +	amdgpu_vm_bo_del(attachment->adev, attachment->bo_va);
>   	drm_gem_object_put(&bo->tbo.base);
>   	list_del(&attachment->list);
>   	kfree(attachment);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> index da21e60bb827..c6d4d41c4393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -98,7 +98,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	if (r) {
>   		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
> -		amdgpu_vm_bo_rmv(adev, *bo_va);
> +		amdgpu_vm_bo_del(adev, *bo_va);
>   		ttm_eu_backoff_reservation(&ticket, &list);
>   		return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 7c1f1b8ca77d..b4c0a4e77525 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -221,7 +221,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>   	if (!bo_va || --bo_va->ref_count)
>   		goto out_unlock;
>   
> -	amdgpu_vm_bo_rmv(adev, bo_va);
> +	amdgpu_vm_bo_del(adev, bo_va);
>   	if (!amdgpu_vm_ready(vm))
>   		goto out_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index ee3c17bd02fc..efd13898c83e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1194,12 +1194,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
>   		amdgpu_vce_free_handles(adev, file_priv);
>   
> -	amdgpu_vm_bo_rmv(adev, fpriv->prt_va);
> +	amdgpu_vm_bo_del(adev, fpriv->prt_va);
>   
>   	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
>   		/* TODO: how to handle reserve failure */
>   		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
> -		amdgpu_vm_bo_rmv(adev, fpriv->csa_va);
> +		amdgpu_vm_bo_del(adev, fpriv->csa_va);
>   		fpriv->csa_va = NULL;
>   		amdgpu_bo_unreserve(adev->virt.csa_obj);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7910046fe11a..8174d71764d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2653,7 +2653,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
>   }
>   
>   /**
> - * amdgpu_vm_bo_rmv - remove a bo to a specific vm
> + * amdgpu_vm_bo_del - remove a bo to a specific vm
>    *
>    * @adev: amdgpu_device pointer
>    * @bo_va: requested bo_va
> @@ -2662,7 +2662,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
>    *
>    * Object have to be reserved!
>    */
> -void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
> +void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		      struct amdgpu_bo_va *bo_va)
>   {
>   	struct amdgpu_bo_va_mapping *mapping, *next;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 85fcfb8c5efd..a40a6a993bb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -435,7 +435,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   struct amdgpu_bo_va_mapping *amdgpu_vm_bo_lookup_mapping(struct amdgpu_vm *vm,
>   							 uint64_t addr);
>   void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket);
> -void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
> +void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		      struct amdgpu_bo_va *bo_va);
>   void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   			   uint32_t fragment_size_default, unsigned max_level,

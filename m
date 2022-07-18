Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512F9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB9F10E5E1;
	Mon, 18 Jul 2022 18:31:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9377910E5E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA85JaO/HcupIPNUF3Mn5k5xLrr1cDF8psKWsEq4gEnz3GSWWIf0Boi4dysv4684oCbQod2J5YWJ3+2BEQqsVj3fGlqkvKjKCGY06+At4QrPBnUCRiv/CdN1wDOHRmB2KFi5WHNTM9VEJvfYT+7kkSrUioqrNkzCxW5Y0ECvPXBzr5OjLJyj4qPO7GtjA3N+9jf6dqv3K7/GTHcJO9XChaXnxJRR5xJCY22eQBd2ddq5KfgQgxF2mvc4aqMcULZtqfHFen+X4WUl5OvE9ko6+aDRyZ+UoqwNtjcnQNhtUvDGaHXd5lbgaVXrQ7waEWOpQ6+zSl5O+U/cPIKqz6JtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJyLkUtNr+RmtDxW9QnaJby5xFk3Bgf/3+c4b7F8jYY=;
 b=VsyuvxbvDSyS2iQkjmpw0yJAvS1mKQuW/ex7g6JzcEG+5SS14+7QFk5HTE6E0dXHs9pn5prWxYtor4V+vooQ4CN2ICs6ZKmWAqjEXpw/xIhRrlyNxaF6PqhFoYcjYq28Kz61yeu4wTAB8b8OsK2NVJB5GUxgOJHt5o68jp0KMuFe7BtZ2IEoSItioRMQdhiA0iFOA/i9DCYLalVT7UK1BNOY4ln+kV2aKuLIlvg25ivNkgx6yawzeHbeppKvi+DGUfzfZJAYSxt4XZ/CLXKetQLYVYDUKs69X0IpzFRcFO8Tj1cKr1bDTij1afFOk2T1rsftp4PlxslrLzXrpsPFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJyLkUtNr+RmtDxW9QnaJby5xFk3Bgf/3+c4b7F8jYY=;
 b=g7RRRFao/Jfr8+uSCf9EncI7CZAp9ShrNQurMK/n6yVYFa5Td58Qf/TPn8/tFF0q3BoTCWAc926sS8IGoERsgyZrRwtCFafl8sGeEsG9kFFcn7BXoCIdJEQfK7rZRefYolO4qpRwXlQEO76v/HN8jzfGrNgEbQkrA7vNwibbcHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 18:31:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 18:31:29 +0000
Message-ID: <715f782d-840b-18cb-e3a5-cc072152634e@amd.com>
Date: Mon, 18 Jul 2022 14:31:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: track unified memory reservation with xnack
 off
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712015604.7697-2-alex.sierra@amd.com>
 <20220715235443.32471-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220715235443.32471-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:610:e6::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384b1849-ae9c-4ad4-dc77-08da68ebbb66
X-MS-TrafficTypeDiagnostic: BL3PR12MB6403:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfFL427uTC3wJUPV6jgoo9Fhm+TwNa/wbrs9TsMIuA7Nfy4C8yNeV0dMUjLJL7qxR4/qnB70LobW8DJ7idWvEUczts/TctDKEJgCQ/D/Q93FUSPpKZKRO5BGJynX/pwcXaYAX7ipq3pPM+IIM5JcAnUns6yP/T7jp+51J8GrUqvUMTH+T7znr8LV0DnotvXgPEQib27VTclPxuowzTXBFDPYZL9NQkI3TNPgNI1/jJYVsJavirQuxgyRXg1Ncj3s0jwCoYfIw3ZuoSK/tFiC98YwsdS6GOUCcuXY1OAqzdQfW+yUfP+cqvnsARHFiRscDQSkPzc9wOdKVQQZeNLqGevAXdzHs2fZnH2sdQ20U2uZzgOdEFFGkMQ32OEgzJVtbVwj69UyFQsrsb74U8fvgUp30X4SjzuRmnl6oY/VfCQpDqWIP+4/ZpAx2mSAZ9+JlczNHJuIGA7svdR6Nxh43GwzUeW/fQBM477RbYoV3g1GYGB8DKfgeQuMlmLQfOs7aORXcN/0TCoMUORTdlwLDzj4BlUcIlvRIY747kkj0OqqFv3Sb/9vXraSIUaZ+Dzk5lXSEXLTEWqAJ30zfgmhXxAg7ZyeztishiSm8ryDmWE/rFiR16FDlGJWeAQAYxmVt3OpvAizioOgjQtw0b6612vPwPJKKS7LPExCc2kC+PyKLyQAS/f2lNC3kyFYCsxy6EeuLqGM0A0hIOnLB0MFg9hj2nXFt6rrbrFqt/fz4EInWq+II0WlBur1NItOG5UvDSkVW5E0BZijYvIez9YrANVbmyf4uTdO1dFW1DgxsZWU0QXD29H5Y+z5yrX/9v1oGLBagA4n5a0A4knpIdFlXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(31696002)(41300700001)(478600001)(6486002)(53546011)(6512007)(2616005)(186003)(36916002)(6506007)(83380400001)(38100700002)(26005)(30864003)(2906002)(86362001)(44832011)(31686004)(5660300002)(8936002)(36756003)(66476007)(316002)(8676002)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVN6NjludUd0RXRrNnpDMDNXSFBKLys3YVVWeWluSXA1TUVWR3U3c214OG9v?=
 =?utf-8?B?YWFvT25mdmdYSytoQW9EZjloTm5ua3ZkM2toTDRnQlVhcWxEMW4vZ2poUFR5?=
 =?utf-8?B?akpibmlBNXE3UjNBSHFnMCtSdk5VL3Vta0lmMzg3QmtsMTUvTUthaTZpbTI0?=
 =?utf-8?B?c2liQkRxWG96VVFGMjJzWjFiUmpJcW5HdloxTEhmMUVaM0RLM09SRCt3TUh1?=
 =?utf-8?B?Tnl3Uml4ajViMjBWdjZJMFVqRXF4RUFDUE5nQnR1czVDa0NZUmo0VmsxaUdr?=
 =?utf-8?B?bmhNRm9WUGo1QmNmalc3cUJWNjhHRHpyNnE0Q2JCOGczUmdPZEtxSU14K01q?=
 =?utf-8?B?NDhBeDZkQjlVQnNGbHhGamlmME9FL0pKQ2NlaUUzRm9URXZnQUVud0Jhcy9s?=
 =?utf-8?B?cXZ1SWZyWHdha0JRU21tOFhrbjNaMCtvZEZZbktmZS9mc0RXNVRNN2dBUDJW?=
 =?utf-8?B?L1BzVkZvbXlra3VQNWpFQmsyb29rSWZ1ZStpdTdjL1lLOURoN1czOGhWV0dG?=
 =?utf-8?B?NkhmblVubnZJbFMxNFAyU1ZLVXM5NmphZ0xMaEVESDV1RG5lUXJGV3I1NVN3?=
 =?utf-8?B?M3dZQ3M2ZllkTko2OU5lUGR0cVRIVHh3UGV4V1JNU3dRUjhHRTNwczdUVkFG?=
 =?utf-8?B?SVBLV1VUNkJMV1hNK0xuTXJ0RjlXaGRQbWFENXNpd3ViUmpwak84YjVVYkMr?=
 =?utf-8?B?bmFiSVJFY2JhYnBWYW1kWWJLbUtMTVJYejNBK3VDVEFqenRMZFRuc2hBa1N5?=
 =?utf-8?B?UTZHeXJISXpsOU9ra2VYNy8yaXpNM2RGdFZLM1JPaGlnMGcxNy9iQXc4RGVU?=
 =?utf-8?B?Y2FsbkliN3JzMmF2VmJ1ell2U0pRL3kwTzlYNnJFZUMvSzdsOHdJcUZZODZj?=
 =?utf-8?B?dWtjVmZlenQ0TEJrRGR3bjAwdnhrNG51ZDN2aklxYzN2T0czTGxrVWxnQ1Fa?=
 =?utf-8?B?RVQwSlZJb2Ewem5EdjdRSjB2eVpEQ3pzQkU4cGhZZXpkVit3c29VNkZ3STR3?=
 =?utf-8?B?akxiNmxRdDJoT04xby8weUUrL2s2bU9LSkhGNHpuNkJ6aldZK0hLZkpYV3Iz?=
 =?utf-8?B?cHM3dmpWNU1hc1lLQ0dqSVM5SERUYXU5VGR6OVVzc0ZYYjZKZ1VxUm0vUnBu?=
 =?utf-8?B?TWlZWmR5Y2haSDVKY1BtZTZvbDY1cjFwRENUNjkrNzBIKzBzYUJveS9NTytQ?=
 =?utf-8?B?Q2c2dHJCUUhaTjgwTVJqei9wYW5waUk2dHVJZzM3cWhEU0tDeVZRa0EyZGgr?=
 =?utf-8?B?YmtVakgvbHpoNzIzWUhkcFZEeGVXZDg2aVM1SUdhZ1JHekM5NS84VFFuT1Iv?=
 =?utf-8?B?c2NObTJzUUdSbGRNTHlhTzRYQnFFTW9NSjZSZDlBcWpKR1hoK3pOZ09RejFG?=
 =?utf-8?B?ZWFBdXpaTkI5VlU4ZG4wZW51R0ZuQkhmOUFBMlAwOVppeEhpTkJhVjFFSjd2?=
 =?utf-8?B?bnIvUGhvMEcvVUJhZG5ydVk1NGNldXZKMzZCWEcxV2dtK0pCMXJjOENnVXN6?=
 =?utf-8?B?c3dCemp1TjVxc2M4MXBlUEV4RzZ2NmRLbGJ5dGlzQW16T1BEUkFmTzNBdVM0?=
 =?utf-8?B?dHZQRHo2WFBRanJ2N3ozNmQzYTVEdm9UYStCOENqUWdNTEpvbmE1UDZKdTZB?=
 =?utf-8?B?NzR5RnZTUzh2YjRFZ3N5TFV5TUp5aCt5cGZZTlQ2bzFWVm4wbEJJcFdQOVVm?=
 =?utf-8?B?NDJSL0ZRWFFSVDlsNXh0MmdZeEVoSVFSQ0FpS3NMRDB3YnpMZHJGOEUrdWtw?=
 =?utf-8?B?VWRlY2pLbEdNZ21wSkdVZWNkSTRhQnZxcWhxaUhHYUlpUVdxQkg1Y3JwQkVV?=
 =?utf-8?B?bDZ1OUVxN2pWdlBOVDNkc1VSZmFtYy9aaHd4VVN1WDdBaWFDSFpwTnA1eGJz?=
 =?utf-8?B?UjdYQTNOeUJwRmdodGVhSmlDV1NmcVlLK3M2QU5mMG5tVHZwNXZVOEVFVXhT?=
 =?utf-8?B?aFVldThUdFhsdXZmU2t1V3NRRUYvUVd1YTcxVWJFWWVvSGRiRW5BQ2RCeWli?=
 =?utf-8?B?UU02RjRpY05HaHJnaFplSXkzMTBvSkxVK3J1SHNvdW9KbGNLV2xwL0RObmFy?=
 =?utf-8?B?NHJ5Sy9mY2pCaVhvazl4R2hQOEwzWGtFaXBERUpaRVBiOWJGbmtyWlVFWWVu?=
 =?utf-8?Q?V5/fUsgY4VYoWhByaf/wptKME?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384b1849-ae9c-4ad4-dc77-08da68ebbb66
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 18:31:29.8123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTi2s/4iDGsboZdq8FdsNH8DPtIJR/r3nwJaKk/Y3+5Mrf3uDy6xaNAvPDTJCrugtDPemr1U3QdtMj3fCyI1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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

On 2022-07-15 19:54, Alex Sierra wrote:
> [WHY]
> Unified memory with xnack off should be tracked, as userptr mappings
> and legacy allocations do. To avoid oversuscribe system memory when
> xnack off.
> [How]
> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
> API and call them on every prange creation and free.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 ++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 ++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 60 +++++++++++++------
>   3 files changed, 60 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 73bf8b5f2aa9..83d955f0c52f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -305,6 +305,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>   int amdgpu_amdkfd_criu_resume(void *p);
>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> +		uint64_t size, u32 alloc_flag);
> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
> +		uint64_t size, u32 alloc_flag);
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD)
>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2bc36ff0aa0f..39d589394160 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -129,7 +129,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    *
>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>    */
> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	uint64_t reserved_for_pt =
> @@ -169,7 +169,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
> -	    (adev->kfd.vram_used + vram_needed >
> +	    (adev && adev->kfd.vram_used + vram_needed >
>   	     adev->gmc.real_vram_size -
>   	     atomic64_read(&adev->vram_pin_size) -
>   	     reserved_for_pt)) {
> @@ -180,7 +180,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	/* Update memory accounting by decreasing available system
>   	 * memory, TTM memory and GPU memory as computed above
>   	 */
> -	adev->kfd.vram_used += vram_needed;
> +	WARN_ONCE(vram_needed && !adev,
> +		  "adev reference can't be null when vram is used");
> +	if (adev)
> +		adev->kfd.vram_used += vram_needed;
>   	kfd_mem_limit.system_mem_used += system_mem_needed;
>   	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>   
> @@ -189,7 +192,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -static void unreserve_mem_limit(struct amdgpu_device *adev,
> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
> @@ -198,7 +201,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		kfd_mem_limit.system_mem_used -= size;
>   		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +		WARN_ONCE(!adev,
> +			  "adev reference can't be null when alloc mem flags vram is set");
> +		if (adev)
> +			adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= size;
>   	} else if (!(alloc_flag &
> @@ -207,8 +213,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		goto release;
>   	}
> -
> -	WARN_ONCE(adev->kfd.vram_used < 0,
> +	WARN_ONCE(adev && adev->kfd.vram_used < 0,
>   		  "KFD VRAM memory accounting unbalanced");
>   	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>   		  "KFD TTM memory accounting unbalanced");
> @@ -225,7 +230,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>   	u64 size = amdgpu_bo_size(bo);
>   
> -	unreserve_mem_limit(adev, size, alloc_flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>   
>   	kfree(bo->kfd_bo);
>   }
> @@ -1788,7 +1793,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
> -	unreserve_mem_limit(adev, size, flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>   err_reserve_limit:
>   	mutex_destroy(&(*mem)->lock);
>   	if (gobj)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b592aee6d9d6..af5b0629b84a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -260,13 +260,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>   	}
>   }
>   
> -static void svm_range_free(struct svm_range *prange)
> +static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
>   {
> +	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
>   	svm_range_free_dma_mappings(prange);
> +
> +	if (update_mem_usage && !p->xnack_enabled) {
> +		pr_debug("unreserve mem limit: %lld\n", size);
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +	}
>   	mutex_destroy(&prange->lock);
>   	mutex_destroy(&prange->migrate_mutex);
>   	kfree(prange);
> @@ -285,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>   
>   static struct
>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
> -			 uint64_t last)
> +			 uint64_t last, bool update_mem_usage)
>   {
>   	uint64_t size = last - start + 1;
>   	struct svm_range *prange;
> @@ -294,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>   	if (!prange)
>   		return NULL;
> +
> +	p = container_of(svms, struct kfd_process, svms);
> +	if (!p->xnack_enabled && update_mem_usage &&
> +	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
> +					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
> +		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
> +		kfree(prange);
> +		return NULL;
> +	}
>   	prange->npages = size;
>   	prange->svms = svms;
>   	prange->start = start;
> @@ -308,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> -	p = container_of(svms, struct kfd_process, svms);
>   	if (p->xnack_enabled)
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
> @@ -1001,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>   
>   	svms = prange->svms;
>   	if (old_start == start)
> -		*new = svm_range_new(svms, last + 1, old_last);
> +		*new = svm_range_new(svms, last + 1, old_last, false);
>   	else
> -		*new = svm_range_new(svms, old_start, start - 1);
> +		*new = svm_range_new(svms, old_start, start - 1, false);
>   	if (!*new)
>   		return -ENOMEM;
>   
> @@ -1011,7 +1028,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>   	if (r) {
>   		pr_debug("failed %d split [0x%llx 0x%llx] to [0x%llx 0x%llx]\n",
>   			 r, old_start, old_last, start, last);
> -		svm_range_free(*new);
> +		svm_range_free(*new, false);
>   		*new = NULL;
>   	}
>   
> @@ -1846,7 +1863,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
>   	struct svm_range *new;
>   
> -	new = svm_range_new(old->svms, old->start, old->last);
> +	new = svm_range_new(old->svms, old->start, old->last, false);
>   	if (!new)
>   		return NULL;
>   
> @@ -1910,6 +1927,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	struct interval_tree_node *node;
>   	struct svm_range *prange;
>   	struct svm_range *tmp;
> +	struct list_head new_list;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
> @@ -1917,6 +1935,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	INIT_LIST_HEAD(update_list);
>   	INIT_LIST_HEAD(insert_list);
>   	INIT_LIST_HEAD(remove_list);
> +	INIT_LIST_HEAD(&new_list);
>   
>   	node = interval_tree_iter_first(&svms->objects, start, last);
>   	while (node) {
> @@ -1972,13 +1991,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   		/* insert a new node if needed */
>   		if (node->start > start) {
> -			prange = svm_range_new(svms, start, node->start - 1);
> +			prange = svm_range_new(svms, start, node->start - 1, true);
>   			if (!prange) {
>   				r = -ENOMEM;
>   				goto out;
>   			}
>   
> -			list_add(&prange->list, insert_list);
> +			list_add(&prange->list, &new_list);
>   			list_add(&prange->update_list, update_list);
>   		}
>   
> @@ -1988,19 +2007,24 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   
>   	/* add a final range at the end if needed */
>   	if (start <= last) {
> -		prange = svm_range_new(svms, start, last);
> +		prange = svm_range_new(svms, start, last, true);
>   		if (!prange) {
>   			r = -ENOMEM;
>   			goto out;
>   		}
> -		list_add(&prange->list, insert_list);
> +		list_add(&prange->list, &new_list);
>   		list_add(&prange->update_list, update_list);
>   	}
>   
>   out:
> -	if (r)
> +	if (r) {
>   		list_for_each_entry_safe(prange, tmp, insert_list, list)
> -			svm_range_free(prange);
> +			svm_range_free(prange, false);
> +		list_for_each_entry_safe(prange, tmp, &new_list, list)
> +			svm_range_free(prange, true);
> +	} else {
> +		list_splice(&new_list, insert_list);
> +	}
>   
>   	return r;
>   }
> @@ -2047,7 +2071,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
>   			 svms, prange, prange->start, prange->last);
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, true);
>   		break;
>   	case SVM_OP_UPDATE_RANGE_NOTIFIER:
>   		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
> @@ -2610,14 +2634,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>   		last = addr;
>   	}
>   
> -	prange = svm_range_new(&p->svms, start, last);
> +	prange = svm_range_new(&p->svms, start, last, true);
>   	if (!prange) {
>   		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
>   		return NULL;
>   	}
>   	if (kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx)) {
>   		pr_debug("failed to get gpuid from kgd\n");
> -		svm_range_free(prange);
> +		svm_range_free(prange, true);
>   		return NULL;
>   	}
>   
> @@ -2917,7 +2941,7 @@ void svm_range_list_fini(struct kfd_process *p)
>   	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, true);
>   	}
>   
>   	mutex_destroy(&p->svms.lock);
> @@ -3333,7 +3357,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			 prange->last);
>   		svm_range_unlink(prange);
>   		svm_range_remove_notifier(prange);
> -		svm_range_free(prange);
> +		svm_range_free(prange, false);
>   	}
>   
>   	mmap_write_downgrade(mm);

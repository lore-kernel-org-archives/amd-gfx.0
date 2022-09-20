Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387CECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 15:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B623E10E6E8;
	Tue, 20 Sep 2022 15:21:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0700310E6E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 15:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKFWMHQ6I6ZWVtnZOtTih5RbvAV/3854Vudnvh5Tl2K8ATnx8dZsw2+UepXUhdKE45hnPYasxPWBV8AkqquzvsBLu4hA8AOPs+bZ6FWdTEj6nr5aFVznfdyZcYC4DwOyCeYdVuFrYMWPGlXRXjLuk3AXE7qW061hwXHzpsBRBCbDyOWyDJOGUeGPMIjmA5lPEcZbwn51OtHt+4qg1hkzelpAa55y+CJ/oG4jBq92MnPSHvkRaszhU+2M+8ZjrCxaCcfdOzaUj68SwPm7EXmjLD07dgM3C0LjdV6qUd7joBKg9wPkb8Vh/JH8Fi/gNDUfGPbym5Zexf4knM4hzVVzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtgyEhzrLUVLujpnScKayyUAM82ho42neWjocieN2eI=;
 b=fApUU3EgM4+TCYT9hSGlSKbbOp+04QLhF/aOTXO8onzvCPuIzyFGkIkaTVGxJVyt7gGQP7mk9qJegyHL6VvnGB/9/zy/3omi3M637GCFD0FaI3fENs4HNAFVdc1a9McoBlutaPisseS83sPPzvQuXj87jr6dw0QaCZlht9CHI76HlgWjpTyiutwxtCSqDOfKDndxxo9fAaI/L1iq6HQazR2ljV2sTeaWTh3SHSrRBae92gXdVPDAOoFgzuB034YWhTYGogKJfBeWykMlWb+wSwcWkj/B1PzyelshMOC/23cje+RiB0UlREkBjdGvUjIDs1fMbdsiaJZJgoiyCJaa4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtgyEhzrLUVLujpnScKayyUAM82ho42neWjocieN2eI=;
 b=evgA4HvFMKg7se4lgg7uD/V5cGLoUq3cTEKRlZ9MJzYGTKlnucWkf37F5nUTA8gVwqDFgruM0FbStk0gImEtb78+GZuUqJnqwuSJhSnxVLdWs/1c2pW3TgKf8T10GGRk5fx9mqud6GsfDbqW9qCiJ2LpWntwRCcupiOCl+p/vSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 15:21:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 15:21:19 +0000
Message-ID: <c15a1b07-1b11-5e6a-3112-9a5786e9963e@amd.com>
Date: Tue, 20 Sep 2022 11:21:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Rename vm invalidate lock to
 status_lock
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220919171553.11286-1-Philip.Yang@amd.com>
 <20220919171553.11286-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220919171553.11286-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 204d3ee5-b998-497a-7933-08da9b1bc45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPHEb4r6xQstI0Mn8VoRgZAijkO54udEbPgh+uMBGjClKZInInhtEF5kX/Xv0d+C6U853a3VZXRPlQypmegM9XS7LyZsGaogbezqny3jLkeHQz/8kPrHo1PmiimRXIt4d3gMNgG4UREhn15ceDAANb2oE8ss7CKDIO/2Uhs8QFnvdYTYRyzRDeie3AZ4f+Qw5ByxGvi9ss3qspT3aRFn7xO8aZaWpVvGqOvvktOcK+W/8QSv5AGiOyJIw8N1rAHXAe2cQTw+8ri2rty7JxMcPhm1sw5fTtnqD67X0lqP9/NC2dVo1ttJGYoIVuSIjkIpHmSjY5r4bwPG8i29HeZchNDfbJwxkF3KS3m/VIANrI0BR+NNP4QbY3jUbUVqZ5cuqSY5uONh4JhwdwL6G1+iugBmM0A36Ee9NV6KKfcw7vclkTUWtaxFYx42A+XwDC9fsiopd9hUQa/xKRtglMXs0BSY+kUisgfinReT9d/kX/x0alItS65GFAm7hAiBajKQiGiXscBr4K3TWDQasiIgT+oX+lzAJyzwoJlJoyWMWfGyQV4Y2lP0Pavh2cR+brT7e3UQ2+TIaccwPMyql8NwQXZ0MrWk1Y+bKF3hZOVwagA70yy1DhesnAs7hvsDdLuKyDEUTms02JWZHpk8+Fkj+FLYtvUeW3IshRtml3n+hNO5TZ5ou/Rew0e4uJspRTT6Dpn4Le+k3sKl8oEAAjZjaP6RlLeU8gbPDROMX/ju5BVeiRLVAymUjNHiBMdlqW8aofT8enTRCWqBFYU5qsf7KkqV1LN3LtQZalmEuwr2NAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(31686004)(36756003)(83380400001)(2906002)(8676002)(44832011)(5660300002)(316002)(4326008)(66476007)(66556008)(66946007)(31696002)(478600001)(6486002)(86362001)(41300700001)(8936002)(6506007)(2616005)(186003)(66574015)(26005)(6512007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTc5K1h5bDJqZkkydFYycmdBdmI4UnpmWjBMWXZEZTFsVkI4M1ZPNm1iWXhx?=
 =?utf-8?B?KzNmTlNETUhGTDNzbkhObzBMQ0RGaUtjaUg3RTAzUTBIbnF6djZzV1RXcExK?=
 =?utf-8?B?MFdxMlpkNFByWEdsYnk0Mlc5N3psYlpwYmdqWVFORHZ3TkNrL3Q0TXNsTHlL?=
 =?utf-8?B?YTlkcnBRV2c1NTlCc2tBTElUQTByWm5ZRU1YTjFSNk5ucTR5U3BoOXVpUXd5?=
 =?utf-8?B?MGtiTkhGSFVQQ0pkL0YveGVYR1BlZXNFbVRQYzZOQTZ5QUI0SEpGeFBUSm82?=
 =?utf-8?B?ZU53VWhocFNBdDlZU2NDMllQanFGSFJPY2V3Ri9USjFJQUNhZU96VVVQV0g3?=
 =?utf-8?B?citJMlozWmJwVjJwRm1sMlBRdTZBUlloN2NwS1I4d0xxdEQwVS9UWlhVQWNv?=
 =?utf-8?B?NTdrTGdGUnJ0dGVzM0tiNEpqVSswZS9ObVRUM29UWjcwTzVRMUR2dS9NcnpP?=
 =?utf-8?B?N1NHUDJneGtuNkJOcWJsbmJrV3lMTmZYWUhIOElUc0l3SXdUcnlYU0pQY3ht?=
 =?utf-8?B?WmRMYWZ5b09zK1JPUkd3SFFlaGVoQ3VmWWxZZDNYbmJQRGdjRlJsdk1yanR4?=
 =?utf-8?B?VjVYU2FYL3NjY0w3M1RrcUNobFU5aWd2akd3RUVnY3ZlUFowa2I0VnYrM0xQ?=
 =?utf-8?B?bVhPS3JxU2M2bDZSUjBQNmN3bHRzUkQyeFN3WEJJc3BxSG1hakRJNktUbHZR?=
 =?utf-8?B?VldXVkJMVHBPYmZMYm5UTWE2eXpTem9SQk43NEVtL29IR21rS0U4WG9aL05E?=
 =?utf-8?B?Y1NGYzdaZ1pmbEloTzEwOStzK1dtdE9PRXVxTjV4Z1NHcWM2TklCYzgwdDRN?=
 =?utf-8?B?LzJubFQ3OHU4Wno3VnBpMUVYOWtpNTNWcW1qa00yUUREb3RMUU9rN0QrblpR?=
 =?utf-8?B?ck9qWDFZRHZ0dngxUWhZeWRYa2NBaVpOQ21QdC9XQm9XRktQY3VwUlZwdWtZ?=
 =?utf-8?B?L0JNajQ4N1Vvb0kzL3RNYTU5ckVQOThpdytUa3ZkRVBXU20wbnA5MkJUN1g5?=
 =?utf-8?B?WDdoa0hrU3ZLQkloOXF5aDJsdk5vbDZndis5cDZPU1BYUTN3K21ibHZKTWp4?=
 =?utf-8?B?SVgweVZuYmtvUjg4TkZsTXBzalVxbktLS1d5bG56MzFSbUNyM2dGVFFERXF3?=
 =?utf-8?B?aSsvREM4ZmpyWmtQdGR6Y2YwVmIweVVaenJKK0RkZU9qNW5rSEVkWXdHRlJO?=
 =?utf-8?B?TmFqZ3JjU1VOVkRvZ2VDaWdTaDcxVzR2dzlqa25nUlQxdEJhRHdUc0tHM2R1?=
 =?utf-8?B?bng1MzBHMjNOUGVYOVdPUmo5ak5HRUVGdVFzM0IybGxJOUpqYldVZktOK3cy?=
 =?utf-8?B?aDdqMnN4TkhycXFwNGEvTTF6REc3M1hieGhoWjZHa3BTb2VLeHU2MENibVIv?=
 =?utf-8?B?Zks1bmc1L01vTlM4dE5IS0hzci9KMm9Ud1NBVW1WRkUxakRqV1JBUS9RL3FR?=
 =?utf-8?B?RG1xRTNaZW9jd2FGekdwTE9QejE0UWpyM1UyOUVnMDNpVTE2YXlaOVNxc2hr?=
 =?utf-8?B?R0p3YTVkRSs4dWNsUVQwcC95UC9WS2Z3NnpYMGVUdXQ0VVZSL0MvNmliK1Y2?=
 =?utf-8?B?Zyt5djZHZTF5T1dxei9hMFQwYVgwTDFHWW9adS9oWm85SEdCVEV6VEZoVDIy?=
 =?utf-8?B?SENOT1RVZDNWd3ljOXRVc0ZSTUJVUnBaMVJNS2JqcjYzTmNPVWJpOEwyVVpz?=
 =?utf-8?B?U1hCYjdGNkVPY2VkNnh4cm9rM0QzVUdUK203d0FPeEg1S04rOHlNVS9zK2lG?=
 =?utf-8?B?c0h5QngwTEdlSlMwc1ZJR2trNWZKMEpRWE1tMHJjMEFCZVlMTkZCL29LSmNV?=
 =?utf-8?B?eTNrQkVrQ28wVzFoNGsrS28xQkg3TVkrQVZQVHk3TERVYVFHcXM2ZGwvZ3Zj?=
 =?utf-8?B?T25YcngzQnEzODdiN0FORndxbXUyUWdvbE81WmM0aXhWdG5EaDF6WkVWTGZh?=
 =?utf-8?B?ZmJ5NTRaOEhRWHRTcTRGcHVUd2cySzhzbko2N3JKSW1yZVpQNmpRUTNsbkRV?=
 =?utf-8?B?UlArNENRa1ZhR0MrUk5TcmE5S09UdnhoTExwbDRkMlRYS2xDUVdleXZhN0xi?=
 =?utf-8?B?SVdSenhJT2szeUt4c3FLOVZvUXJLbXdxWTk0SG92cEx3Q2hxYmdXVUZ1NVhu?=
 =?utf-8?Q?NDjb2Ruvs0I+LpXuCw95ezZbk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204d3ee5-b998-497a-7933-08da9b1bc45a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 15:21:18.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngzhxpz1MOGr/a6lxH4/FgCDP52aFZx4ADk5KDTOb97IaYwCz9MDaQ0y2jz5HA/0JoHNuM01NXSRs8YN1p8exA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-09-19 um 13:15 schrieb Philip Yang:
> The vm status_lock will be used to protect all vm status lists.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Christian König <christian.koenig@amd.com>

Was this meant to say "Reviewed-by: Christian ..."?

Patches 2-6 need proper patch descriptions. Something like: "Use 
vm_status_lock to protect all vm_status state transitions to allow them 
to happen without a reservation lock in unlocked page table updates."

Other than that, patches 1-6 are

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 30 +++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 +++-
>   2 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 690fd4f639f1..596f1ea8babc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -225,9 +225,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->invalidated_lock);
> +	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->invalidated_lock);
> +	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -256,9 +256,9 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->invalidated_lock);
> +	spin_lock(&vm_bo->vm->status_lock);
>   	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->invalidated_lock);
> +	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
>   /**
> @@ -936,7 +936,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
>   				gtt_mem, cpu_mem);
>   	}
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
> @@ -949,7 +949,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
>   		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
>   				gtt_mem, cpu_mem);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   }
>   /**
>    * amdgpu_vm_bo_update - update all BO mappings in the vm page table
> @@ -1290,12 +1290,12 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   			return r;
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	while (!list_empty(&vm->invalidated)) {
>   		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>   					 base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->invalidated_lock);
> +		spin_unlock(&vm->status_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!amdgpu_vm_debug && dma_resv_trylock(resv))
> @@ -1310,9 +1310,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   
>   		if (!clear)
>   			dma_resv_unlock(resv);
> -		spin_lock(&vm->invalidated_lock);
> +		spin_lock(&vm->status_lock);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   
>   	return 0;
>   }
> @@ -1763,9 +1763,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2019,7 +2019,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	INIT_LIST_HEAD(&vm->moved);
>   	INIT_LIST_HEAD(&vm->idle);
>   	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->invalidated_lock);
> +	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
>   
> @@ -2584,7 +2584,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   	id = 0;
>   
>   	seq_puts(m, "\tInvalidated BOs:\n");
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->status_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>   		if (!bo_va->base.bo)
>   			continue;
> @@ -2599,7 +2599,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>   			continue;
>   		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->status_lock);
>   	total_done_objs = id;
>   
>   	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..e6dd112d865c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -254,6 +254,9 @@ struct amdgpu_vm {
>   	bool			evicting;
>   	unsigned int		saved_flags;
>   
> +	/* Lock to protect vm_bo add/del/move on all lists of vm */
> +	spinlock_t		status_lock;
> +
>   	/* BOs who needs a validation */
>   	struct list_head	evicted;
>   
> @@ -268,7 +271,6 @@ struct amdgpu_vm {
>   
>   	/* regular invalidated BOs, but not yet updated in the PT */
>   	struct list_head	invalidated;
> -	spinlock_t		invalidated_lock;
>   
>   	/* BO mappings freed, but not yet updated in the PT */
>   	struct list_head	freed;

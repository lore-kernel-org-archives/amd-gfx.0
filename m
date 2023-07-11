Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058B3EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 19:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 500E810E0CD;
	Tue, 11 Jul 2023 19:35:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEED910E0CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 19:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk3vNZR5rzTkymvfS81VUw4PKhHDsoWlKh/J1cN1sGqA6WeGR6x+RLyxaH2+k3PnRiMZjZREZzEnRSjOFmIlurFB7ZNLU9Z7w2vnFtDxZzDtcuh9G5bjS+zBVIIUpa3mmZ3tb/r+vQ1695qrLNq/Peu+EGC6TYQAeE1Z6Va3DyZOiXtLJhxL+s8Yq+VVtr0b8EInpnK+fWUy8oKHzy5jb5urii/VInu/X/eGr1PothiqW8D7zAPBcwksHNOFSpL1xCEHZhjsaJdGTQ8Kq+PaSjQo71ydbzfi9ZvTzJP+TaVSc7qYpeKSVIVv9BGWf3thBWirQxJpQt/XjAZntlrXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVQMQi65qLzpzgk516P6MedBrgozeUYtrFLHFNHK+is=;
 b=NPJ7G6Px8cu9YsSWnn/XMzxK2CjgvHO3nBYuPFvoQgqu54Yd/cLdLF8BtFslwVN4FiZyie2iHVHoASX34ud38co3HkMmISbLDszRnwO+qKB7OSNGm+N3+wUtJfmZ/pW+A5u+9jvVzdqO+56lsBrBQxElB1nrlE8aL5hIHTe0Ij72fUumRE0mRDQpzMI7CwWc7LhSccLBD7e+6RLUcrlTs04eDADsyD86TeiegHTzDUs+aqu8Rijw9PPYR2yu054Vud8lH16I0vy++8MVAQOds9xEdeacJzgR/HWkEXb0dq8vaDkQdHwcWjwZiYe/OomSCe/c59bFV1wRzh3SeU2+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVQMQi65qLzpzgk516P6MedBrgozeUYtrFLHFNHK+is=;
 b=ocwdSAMJ+aN6H+69dPpEly8Rpjikh4SMgCBwie/O6pC6QPVqSjuoeM3KFHrgO3m56j4NhxXCrV4DEXOQt4jG5bxg4RqyvvM+H/L6wg3MBj2r0s/k2e5sC1i46Esd31SgJBLdhjvzxFMhdSIhWqSC3kl9ZqDlfx4hsoDPtm417Sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 19:35:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 19:35:31 +0000
Message-ID: <29fc55d2-3a93-2e08-6e51-f61b3e238e53@amd.com>
Date: Tue, 11 Jul 2023 15:35:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/6] drm/amdkfd: switch over to using drm_exec v2
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
References: <20230711133122.3710-1-christian.koenig@amd.com>
 <20230711133122.3710-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230711133122.3710-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3a6d72-8aff-4fe2-f1c3-08db8245fd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIGMMAiunKDv213IKTPCfGIy8u8S46KmpfB+263Z7UtHiG5ffyhHzfJEAcGMXnXVsYolBE1fH8kB/CB5y0KCIviOnBNWHHp0TN23abatVr9lXpvnVAMqYL3O9B22saRYbBkVZqUv86qcqSv2K6EP054ARVUMiJo1HGCHgx2lOKDqG1CMjshUjBq7JQRe/80SUUTlwKQ1anUQ6OaO1O6fSX9Up/nSkafDzpZpHSAvDlE/oyzVTxMkXIrRNSCBHRPLBPiIwEmV6+f/ML4/CAahLAInl7Dt0L9DZaI3v8TX0JDswkr/zgkPIFGJIfBBsbRzLcsu5jvi1szMWIgtkEz6yqgBg3inhBAgtOq+szdBgZVsnqufnm5Bx+XzeUVy34K/5cw+ilhBo4Q+m99kxWaUiwrCpLtnELX9FqcSiFlkfH8jbsyzrdJh4yyi4Q1hxoGreoDFei4A8EVsORlZ0R2BhQlt9eZ4aWE9FRFgfs8a60HgKJ4OEf0mDOqx7JSJ32YTrvJQPLDMQeWcc46yG1/wa7MQtRWYeZBoNeVepxs16CzTn1kHhcwZenwdEqtDDq+qYlxJmp0vSWuMAX8vKr7iQ+t+X2vEtfFAXM9lQLnbqhKoWtggeBAhccaM2Ogmu84gGmdJRAOYxcZ5thEJ++UOWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(478600001)(83380400001)(2616005)(6506007)(186003)(26005)(53546011)(66574015)(36756003)(6512007)(36916002)(6486002)(2906002)(316002)(41300700001)(38100700002)(66946007)(6636002)(66556008)(66476007)(86362001)(44832011)(31696002)(8676002)(6862004)(8936002)(31686004)(5660300002)(37006003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdJbFVRU0lSZFNTbWZrUCsxUnljb2VyNlhOV2J4aDIwZ2NtblR6MGdpdzd6?=
 =?utf-8?B?ZllHRG1naVpmL3JsOHRVYkg3QzJHc3ZycGdGWE5RSGpQcHBNMHVCL0RDNnRE?=
 =?utf-8?B?WEIyK2Nab0NHeS9DUnNQQ1UzVVBkT2E0V3V1SzFES2hEZlNCb25DQzd3cnVq?=
 =?utf-8?B?ZUp6UElMbCtUcnhsc1pIL2JSODJ2VCtWRDhIVDJmbUJrSCtmMGNmWmFxVWht?=
 =?utf-8?B?cmtuOE83RzNWRUx3RHI2NmZvakZQYVV6VGVkbGE5dWRnVE05aDM1aXhCTUJK?=
 =?utf-8?B?b2luQ3c3NlREbHViUHlUWENKZG9lUU0xMTVZWjd2dS8wdVVKQk1kTXdjL3Ew?=
 =?utf-8?B?TDFWUEUrRytlOVBiNEp1cTJ5T0c2Tm02NS94NVJmRGJ3alZPQlU1dlVONWxZ?=
 =?utf-8?B?S0RwbGtEQnlKTEN1MUhjVTc2cXhwSG1PaVZ0NVlRbkw1dWJuRUZaRUpkRFRL?=
 =?utf-8?B?a2xhSXNXZTd3aUpLVklaVnBBd0hxc0hZTTl0TSt6Y0dEMURhTHY5N3NpcGtH?=
 =?utf-8?B?ZGRJbGVGNzRpNXFjWW1MV2F4Zmp3V2JMblpVTm5IY01yVzdteE9PRlBkU0N3?=
 =?utf-8?B?QjY4d25pRW55WDhRWTMzV092b0oxelFQRzlIaXZ5dktIT3dSSHd4MHIyeW52?=
 =?utf-8?B?TnorSERicHJpQkhWTXZ3bzI5Q2ErWmlUTTFyQkk1ZnJCRExSQllieVNjVVo1?=
 =?utf-8?B?L3BJK3luelFMK1luSFBmcEhiQnBkQ0lURS9zTUZpa3NQRnVoZUwwOEkyMGNk?=
 =?utf-8?B?RlN4TVN0N3pZeXUrTllEMTVVU1ZQckNxZEx2TXpOOVNLTjJkekNKUXJQRVNi?=
 =?utf-8?B?UFhLaG9UanJCN3BLblBlcDlZRkcvbVNPZVpXQWNnY3QzNkFDSXh2RWhncVFL?=
 =?utf-8?B?bFYwd3VhYzNJOXVSZkxqVm1mVWhHeFdGQyt5aU1vYnB6dkdNeHQwTGRuMWRC?=
 =?utf-8?B?RU9IQjJrZnNUbDFmdndhdUlrbDI3Y0dOUklVUWZadXFabGNpWGx5NEZtMnU4?=
 =?utf-8?B?b0RNcVI4UjhDRTNYSGhjbGZ0YXd2T21rREFVcWF3L2ZmdWQ0YnRISVczRTBN?=
 =?utf-8?B?UHFUVzFGbWN5TTJRTGNhc0ROUmR3em4yWVVEOUVXNUZMU2MwdS9YRFdtQmdj?=
 =?utf-8?B?cHJpNnRUekJVWGtkbjRsL01FYVkvcmxZN25OaldJQ0NBQkRHa0tzRXkwVm5H?=
 =?utf-8?B?N2pyc0FoL3ZnTDhNTmJ2THR6NTltU3YvQjBxSVlzYjJLellHQkFZZExnQVRX?=
 =?utf-8?B?dG5TS1NHV05qeklPUFgzWDE0NkJJOXRsTDNKcGxQdFBNRzRoUktWSG5hU2F1?=
 =?utf-8?B?Ui83Sng5NGJjcmk4SzBQVmtDRTY1aU9PM3NqaHRqMnhVZm1xMnk1NWZha0hY?=
 =?utf-8?B?S1dCUTlYcGxWcmxZbUkrU3lCQjJnUkhPb2pqcmlWODI3TkU4VnZmZ0F1NjQz?=
 =?utf-8?B?cWFlYXU3QmwvdHJSUW56Z0l3NitQT2Fkd2lQemJMVU5PbTRRQ1M1blkwemJx?=
 =?utf-8?B?NEtYamt3Ky9HK2JPbjdDa3hDb0J0OE13YzQ5cWhCVXRUN0ptaWtVdkI2cWdZ?=
 =?utf-8?B?ZC9QaTJ4T29rTXFzUHF4Q20xOXorRWJ4V2pPNWxHN1VWYk03M3RCUGNNaVdS?=
 =?utf-8?B?RkVBNmlreCthMkFvTVhtVGZZZktxamZ1ZFNUa211eDlQL3p5THBkV1pSRDF3?=
 =?utf-8?B?OUZYRFIzMUdFTU9MYlZIcGRvUWt1bFFRUWtIK1V1VkxxZVFzM3BtZ29xeGQ3?=
 =?utf-8?B?ZWVXZ1BpRFZIQm5UTStZZFRXdy9wYWpKVk52dU5nYll3dVJmbzVxRTZaR3hX?=
 =?utf-8?B?M2orTzgrK0VwLzRWdWI4SzdzOXhNWm1FN055VlUyZDhBZ3VrZFQvYlUvczYz?=
 =?utf-8?B?STVWcGtxMmViY2Nid0NtWGtPTWtLVnVoNUFOUmFYVnAyWVpEZ3A2THRsRzlo?=
 =?utf-8?B?WGVvSFZqcUtXMmorbS9obmdwN3NNVjM3cm96TG1Kb3h6Q2d1Qkk4MnZYRnRQ?=
 =?utf-8?B?RzNRZFdqM1gzak1oWnE4STBaWkdRNkxxVHI3MEl6SytHZWphakd1bFllQzJX?=
 =?utf-8?B?SFNjRm0weGM2NFNqaXVpd0tEYU9rZWxEWmNNNGlxQ00wZFBiWUFWVXRwU0Q1?=
 =?utf-8?Q?SXKpoMrPteUVDoUGCwk3sU6H8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3a6d72-8aff-4fe2-f1c3-08db8245fd07
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 19:35:31.4527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjkKd/iI9aJnv/zaIwaBi8wJmL6TgHY3w1NkQvIaAcZHzBNh6o0rc96FWEGQaioBdodMTdgS1LUthxOfgzKawQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
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


On 2023-07-11 09:31, Christian König wrote:
> Avoids quite a bit of logic and kmalloc overhead.
>
> v2: fix multiple problems pointed out by Felix
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Two nit-picks inline about DRM_EXEC_INTERRUPTIBLE_WAIT. With those 
fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>



> ---
>   drivers/gpu/drm/amd/amdgpu/Kconfig            |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   5 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 299 +++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  18 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  45 ++-
>   6 files changed, 162 insertions(+), 210 deletions(-)
[snip]
> @@ -2538,50 +2489,41 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>    */
>   static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>   {
> -	struct amdgpu_bo_list_entry *pd_bo_list_entries;
> -	struct list_head resv_list, duplicates;
> -	struct ww_acquire_ctx ticket;
> +	struct ttm_operation_ctx ctx = { false, false };
>   	struct amdgpu_sync sync;
> +	struct drm_exec exec;
>   
>   	struct amdgpu_vm *peer_vm;
>   	struct kgd_mem *mem, *tmp_mem;
>   	struct amdgpu_bo *bo;
> -	struct ttm_operation_ctx ctx = { false, false };
> -	int i, ret;
> -
> -	pd_bo_list_entries = kcalloc(process_info->n_vms,
> -				     sizeof(struct amdgpu_bo_list_entry),
> -				     GFP_KERNEL);
> -	if (!pd_bo_list_entries) {
> -		pr_err("%s: Failed to allocate PD BO list entries\n", __func__);
> -		ret = -ENOMEM;
> -		goto out_no_mem;
> -	}
> -
> -	INIT_LIST_HEAD(&resv_list);
> -	INIT_LIST_HEAD(&duplicates);
> +	int ret;
>   
> -	/* Get all the page directory BOs that need to be reserved */
> -	i = 0;
> -	list_for_each_entry(peer_vm, &process_info->vm_list_head,
> -			    vm_list_node)
> -		amdgpu_vm_get_pd_bo(peer_vm, &resv_list,
> -				    &pd_bo_list_entries[i++]);
> -	/* Add the userptr_inval_list entries to resv_list */
> -	list_for_each_entry(mem, &process_info->userptr_inval_list,
> -			    validate_list.head) {
> -		list_add_tail(&mem->resv_list.head, &resv_list);
> -		mem->resv_list.bo = mem->validate_list.bo;
> -		mem->resv_list.num_shared = mem->validate_list.num_shared;
> -	}
> +	amdgpu_sync_create(&sync);
>   
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);

This runs in a worker thread. So I think it doesn't need to be 
interruptible.


>   	/* Reserve all BOs and page tables for validation */
> -	ret = ttm_eu_reserve_buffers(&ticket, &resv_list, false, &duplicates);
> -	WARN(!list_empty(&duplicates), "Duplicates should be empty");
> -	if (ret)
> -		goto out_free;
> +	drm_exec_until_all_locked(&exec) {
> +		/* Reserve all the page directories */
> +		list_for_each_entry(peer_vm, &process_info->vm_list_head,
> +				    vm_list_node) {
> +			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unreserve_out;
> +		}
>   
> -	amdgpu_sync_create(&sync);
> +		/* Reserve the userptr_inval_list entries to resv_list */
> +		list_for_each_entry(mem, &process_info->userptr_inval_list,
> +				    validate_list) {
> +			struct drm_gem_object *gobj;
> +
> +			gobj = &mem->bo->tbo.base;
> +			ret = drm_exec_prepare_obj(&exec, gobj, 1);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unreserve_out;
> +		}
> +	}
>   
>   	ret = process_validate_vms(process_info);
>   	if (ret)

[snip]

@@ -1467,25 +1467,24 @@ static int svm_range_reserve_bos(struct 
svm_validate_context *ctx)
>   	uint32_t gpuidx;
>   	int r;
>   
> -	INIT_LIST_HEAD(&ctx->validate_list);
> -	for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
> -		pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
> -		if (!pdd) {
> -			pr_debug("failed to find device idx %d\n", gpuidx);
> -			return -EINVAL;
> -		}
> -		vm = drm_priv_to_vm(pdd->drm_priv);
> -
> -		ctx->tv[gpuidx].bo = &vm->root.bo->tbo;
> -		ctx->tv[gpuidx].num_shared = 4;
> -		list_add(&ctx->tv[gpuidx].head, &ctx->validate_list);
> -	}
> +	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);

This function is only called from svm_range_validate_and_map, which has 
an "intr" parameter. If you pass that through, you could make 
DRM_EXEC_INTERRUPTIBLE_WAIT conditional on that.

Regards,
   Felix


> +	drm_exec_until_all_locked(&ctx->exec) {
> +		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
> +			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
> +			if (!pdd) {
> +				pr_debug("failed to find device idx %d\n", gpuidx);
> +				r = -EINVAL;
> +				goto unreserve_out;
> +			}
> +			vm = drm_priv_to_vm(pdd->drm_priv);
>   
> -	r = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->validate_list,
> -				   ctx->intr, NULL);
> -	if (r) {
> -		pr_debug("failed %d to reserve bo\n", r);
> -		return r;
> +			r = amdgpu_vm_lock_pd(vm, &ctx->exec, 2);
> +			drm_exec_retry_on_contention(&ctx->exec);
> +			if (unlikely(r)) {
> +				pr_debug("failed %d to reserve bo\n", r);
> +				goto unreserve_out;
> +			}
> +		}
>   	}
>   
>   	for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
> @@ -1508,13 +1507,13 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
>   	return 0;
>   
>   unreserve_out:
> -	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->validate_list);
> +	drm_exec_fini(&ctx->exec);
>   	return r;
>   }
>   
>   static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
>   {
> -	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->validate_list);
> +	drm_exec_fini(&ctx->exec);
>   }
>   
>   static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE20E74914
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 19:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE43D10E233;
	Mon,  2 Oct 2023 19:29:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F404E10E233
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 19:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8yPm8ykWUnBn4LjgMZo3+UkqXlbVNwUgIKM8pUumtOKvq/71t9Y2dMMrkhuLF3AKOZp2ftBukyV0vfATuxceE9RSi8dNkrEQK+lGdqrvHgQ0gqOrV71M/6/Xig2zFIH/JLKRVkwOlu7HbYfdBVhUNs+OD/COWMNtWfr6rfKtc/FPGBKFcL901ECa/EtBmJKJLGIPB4aA7vLxz559A/F4OuoVNPEBn1bvBzSAGwfJTwWTp5HKb4/W4FQcSEm27HrpfEs10OeYlSEtOGZgx9MHEcdSUcU+n53hVZGlq4qSziX+W83mj8K0Mc2nBxukHnOUWgLT5GOMfeJqVnwYIvjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7sLE7imh0UtTA/OrNHQyMfkqua1A7S+p4ysnlyb0vg=;
 b=VU5GrSpAR37eoRIEyksq09ngu4R2on9bpVDa30lV8z22nv9mPGMqqWAbi0hrF2Tt944HpW1bM2Qyl0E3BTGeaZsTT/iGJ5pujPO03WqtP+snp7UKWL9YtjHnckpy4bvqLP51Ujp+UMhR3jYohqRoOGHLzR/Skc1y9PPmlP09rJegXZe+4tF2m/DKZj3U3r2FnqJ4n/9ZciA5b1IMEtLUVGD0v9cEeE2fTpJRioSiaJwdI2Crv7DUnk4VEO66w+GSqqCal38ZCf0loX3bVNX2OWAUz8qQk5vX3fEe/xDCZtFqfOQ5LlJUVnqMZ4diko+GW7rKKPSd1d68auOIztkDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7sLE7imh0UtTA/OrNHQyMfkqua1A7S+p4ysnlyb0vg=;
 b=HvZ5MsuHNkPlghBAhNHqqyT8c4/FXHOBlT6tt5ytKaI6LjYYKOhbUjteXnLjqnPSogj/BQvUCaOa60kXTb5OAUlQchng5hFTnvejURw6Sd5Lf2Iu4ImkyCc9hTHXWXZwGgiMT6L+xuxjrFR3y60kbh8iGyTRdfXVvwm8ICZQY4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 19:29:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 19:29:36 +0000
Message-ID: <eb5b293a-d15f-4ecd-bb86-091c11faa52b@amd.com>
Date: Mon, 2 Oct 2023 15:29:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: Check bitmap_mapped flag to skip retry
 fault
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <20230929141115.10016-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230929141115.10016-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 43da2a23-25d8-4c19-09ba-08dbc37dea03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SN//jr4ysN4p9hkeCiQ4/kMUDl7UpO4uHHEhgZ6qbZAmprFZbYf7XhGllv5B3mhW5emMuMR8CBAiYGorIGXJ5nHAj1VHwtCCVaBuHgo+RAduJsOC5OlNp5SqsJoAdJlnGfZmBQcPDazdKjFzQ9Ifp3L+jq8CuCnigPC/GNtccfsHP4Ang+JsJHZWUd2FXbnoPWGInkaq/Z600VLmT0Q3kMjAZ+jJb1ceOsd3dyze7LxKgYMCXTEhZjKvdvG+u0cnuQifMWD0CZwoLTrkcE2t6nS99X241+CO92XLZsgd6Hr3pENjV6+SaKpPbvTBOeEzuxIfwQSnV8aam2Z91IAw/gGRm6BZxwS97LPgn4oDnFnPlE4uIdVrDJzuHHiYlqUktLYQ7kynrRUtX1F8KJtbunwrkhZMHky/gc/fugPc7DogjYFSAlpy2mtaaBo9fcFYlEcRXFCVRiMu/7oLT+tRK9bFLiz5+88PnaR22gTFLkM7GSb9cR8JpJmfZneBTwluz616Yo4NUgSC1jHO931EVV4DGxGqE1R0wAtjpS0vMe0Q1uiF1ioWBx/OTEBtiFQ9dggodlwGpl5T+sk5oIpxYxk7ZTs6DrvaCNiITjVv60DYO6x/nW8Zq+0jaW0RdXWoIxgOd/gFj9Y8QdWtqebsRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(53546011)(6512007)(2616005)(6486002)(6506007)(8676002)(316002)(66946007)(26005)(5660300002)(44832011)(66556008)(41300700001)(8936002)(66476007)(83380400001)(86362001)(31696002)(2906002)(38100700002)(36756003)(478600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5UVFRjM0w0elExdHRLRWlxUkNSbXJhVm1Ld1RqeWw1YlgwVlhhSzU1eDF5?=
 =?utf-8?B?ajI2ellKVzZ5bHpKQndOdUhyUTUxQ3F6UlczTzBZa0R0ZEVyaUZJNkNBaU95?=
 =?utf-8?B?Um9ERHZuaW8rV083VVlBRnJmMG5PTCtGRFZuemVvdGJHZEhOOFZXWGtrVlBj?=
 =?utf-8?B?QklGMVUxVHljQUhGekpkZ0xvVmg3eEVqeUdEQmtNUVNFYS9sd0RGRzlkL3VW?=
 =?utf-8?B?RHVaQmR3OFRNa052NjIrRGQrSHVEVXhjZnhOUVdob3BReFJDdVhOSjVZN25Z?=
 =?utf-8?B?OFVFU3R1cmZJZUdkSW9FN1NqUHB2UmV1V1dMeWhxaXEzR2swcDdZQlB3L094?=
 =?utf-8?B?RVc4SmprVS9uQ3gyOFVSbXFDOFlCM2RwMXF3eE4yRnVOOGRaWHZlS3FZYUli?=
 =?utf-8?B?SlZJL0RCUllpL0c2cFEzLy9xbHJDU0Y3aTZieHU1dXI0ZGdOazk3cG5lcjlz?=
 =?utf-8?B?NVc1dlp5WGlDdS9WaEZBc0N5OUJ5QVVxNEZFUWNIaXlWMkg3R3hvYmNIY2t6?=
 =?utf-8?B?dDVKcjZ3SjZOd2dlR3RpN0tiOEY1dGxhbUQ1c29NVlFZMGVkbmpoVEtUM2cv?=
 =?utf-8?B?UXY1emdlS0ZWV1daNWkvME5PUUJFTnVsSzZkNjZBQUgyMGJJcWxDNndDMTR0?=
 =?utf-8?B?cjNGYUdUNHpaK0dseTJSWmNBVVRJWU5yb01pV08yUzU1cGx6blVUSmN4c1p2?=
 =?utf-8?B?TjluZEF0TDBoL0hmQ01SdjN1cVpLVUxhTGVXY1ZPM0N6endlV0Nyczd1LzBZ?=
 =?utf-8?B?dXFxMHVtRWJ3TFlaM3NQZ2RuMWJHbVdLWitMNVZqY2FXUkk2WlZ1R0t4eGRK?=
 =?utf-8?B?SkllMzdUanErSXFhdzZDb0VnelRvUG4yWS9pTm1WTng0Kzcxc1p3UVFveElx?=
 =?utf-8?B?L3g0dHB5Yy8xcHhxeTU0eG1Uci9nYXExaVVyR0I1bFQ1NWFUKzlSVU5nZExw?=
 =?utf-8?B?RVgxemExcHN4QzhnMVhMTkwrRWhTbzh1OXRGVjVxVUVLdnQyT0M0b2M3T0h4?=
 =?utf-8?B?S0dPaXpydDVxTWVkZnVtNVYwbUdRNWVWeGFMUW0zSzgxZytad3lHak11aVFk?=
 =?utf-8?B?TjFJT2VqejVvdFJJL3VnWm1FeXR1a2pabVlKaHRHZ2IrNmFTL2pwQnlIYm1l?=
 =?utf-8?B?OXF3M25HYzE2VTA2YTVlN2xkTGI1TWx6WXpEYUdDRWNpNXFvVDhTRDJ5Z3gw?=
 =?utf-8?B?eDAva2pMTGcvcE1EUWZhc3RGRUxIRU1vRWtTaERrREUrdzRxRVFDbTFWRjk3?=
 =?utf-8?B?OGNrcDFyS3F5S2diR2YyeWh4cU9jRCt4QVVJeUFWVHA3RjY0THMvc1FpWEph?=
 =?utf-8?B?VE5wUFh2elVhbTZzUXhCUWRIRzAxb1B2aHYwai9YVmVDdG8rVG5lazAzYjhC?=
 =?utf-8?B?NUpES1p6VENHamRlaGVUdDR0dmFVOG43bVluMnRnc01NRTg0ZUhvbFNqK2VL?=
 =?utf-8?B?ZENESWdtY29aYUM1dVlHdGZGMlRsSFdodTNVWHZpNDJIUlpLcjFMSmkvUkha?=
 =?utf-8?B?K1lKbUVPRXpJN1JQSG9HWElNYi9GdDZiTmN1RHNDWnJxNnJwVlo1SlhxQ1VZ?=
 =?utf-8?B?eFQweTl0MmdVSmtlekFOWTJKcE1NZFkvaXVsTzZIUFV1bmxycVJYeUNYeE9V?=
 =?utf-8?B?UFRIUHA2L3NFM2tLTXZBNDZhcTU0R3FYSTJqSEM3eTREaSt6M2RXV1pWczN6?=
 =?utf-8?B?R05DeFhtYS9xVGtLczcwVGZQVWlQR2JrNmY1Q21tUU9mU2p0anZML2RRUHp0?=
 =?utf-8?B?NXVDVWMvQ3RWdVJBUUMzVXZvZkwxTFFUbFpsWmszUUVIWCtoWis3SlkxbU9o?=
 =?utf-8?B?c3dCdk5sdnBISnpmRmhGQkxLZGN1aEdySkk3OXlRQ0pBQVRUOGVCYXVPVzQw?=
 =?utf-8?B?WE1YYjdpbTFJQTdnNGRSaTB0RGRIQ0N4ZGptdmFDUkNBRUF2OXlSL01COFFT?=
 =?utf-8?B?dUROTmU0ZEJCT1pEN2E2d2lRVDBXV3ZYdWRQZUdqd0UwcWZIZmwrNUttSCsw?=
 =?utf-8?B?MW1hVmtQR0NwUlNBajV4THR4dS95QXJmL2NuWTBIT2ZvK2o2YldwM3RZV2M2?=
 =?utf-8?B?ZmFqRk1HOC9MN1p4VlBLNnYxQUY2K0UvR2N2TVpzNWNTZzdnVzhBZVRhcDZq?=
 =?utf-8?Q?eP3O7UHOl4a4hu/egmBRI88IC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43da2a23-25d8-4c19-09ba-08dbc37dea03
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:29:36.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQF1UIgxLMK1ODef55zd3lTF25RFnPYzLw9E5Sero7kAZKNhbO4K0D6V066ZUXSZyGow8ZDVhJ7r5iv85kxz3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

On 2023-09-29 10:11, Philip Yang wrote:
> Use bitmap_mapped flag to check if range already mapped to the specific
> GPU, to skip the retry fault from different page of the same range.
>
> Remove prange validate_timestamp which is not accurate for multiple
> GPUs.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++----------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>   2 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ac65bf25c685..5e063d902a46 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -43,10 +43,6 @@
>   
>   #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
>   
> -/* Long enough to ensure no retry fault comes after svm range is restored and
> - * page table is updated.
> - */
> -#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
>   #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
>   #define dynamic_svm_range_dump(svms) \
>   	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
> @@ -365,7 +361,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->deferred_list);
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
> -	prange->validate_timestamp = 0;
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -1876,8 +1871,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	}
>   
>   	svm_range_unreserve_bos(ctx);
> -	if (!r)
> -		prange->validate_timestamp = ktime_get_boottime();
>   
>   free_ctx:
>   	kfree(ctx);
> @@ -3162,15 +3155,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out_unlock_range;
>   	}
>   
> -	/* skip duplicate vm fault on different pages of same range */
> -	if (ktime_before(timestamp, ktime_add_ns(prange->validate_timestamp,
> -				AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
> -		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
> -			 svms, prange->start, prange->last);
> -		r = 0;
> -		goto out_unlock_range;
> -	}
> -
>   	/* __do_munmap removed VMA, return success as we are handling stale
>   	 * retry fault.
>   	 */
> @@ -3196,6 +3180,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out_unlock_range;
>   	}
>   
> +	/* skip duplicate vm fault on different pages of same range */
> +	if (svm_range_partial_mapped_dev(gpuidx, prange, addr, addr)) {
> +		pr_debug("svms 0x%p [0x%lx %lx] already restored on gpu %d\n",
> +			 svms, prange->start, prange->last, gpuidx);
> +		r = 0;
> +		goto out_unlock_range;
> +	}
> +
>   	pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
>   		 svms, prange->start, prange->last, best_loc,
>   		 prange->actual_loc);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 10c92c5e23a7..3afc33a3dd30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -125,7 +125,6 @@ struct svm_range {
>   	uint32_t			actual_loc;
>   	uint8_t				granularity;
>   	atomic_t			invalid;
> -	ktime_t				validate_timestamp;
>   	struct mmu_interval_notifier	notifier;
>   	struct svm_work_list_item	work_item;
>   	struct list_head		deferred_list;

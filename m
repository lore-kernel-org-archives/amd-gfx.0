Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F88AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 20:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C765410F5B2;
	Wed,  8 Jun 2022 20:44:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072FC10F5B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 20:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncr6/TyAGs6yzkjz82xxAxKhCD2GlBwyD1Jf/TlbDIIsBwrk0hUm6xmIJQX1b9+g+OeCZLNjAdJ9xx5HqgKkZoyOgLXEQekzlQfASgNUciBJvww+YxdKeENsfQ9WqeibQXTAOP32jA9YHkVvr6ncophuUDBfnFIuEbrGnmTQyhwGcF84O9u9TMo/lZ8wZpQ17032EMtlX533Aw7FIfBp+t39nrpThEPkbrzfCfhUci1Mc7sk+BQlFzIN2l/xcfs2/4ABapEXYe1r1UK69RK0rkiEyQkSbG+2hI7ALxV1diaCi3sm+dCbmtvN/xgmp4ebHIw/YldJG+jq4BL/pkwrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4KRf5F7u3TJzBlpa9im6TC32d6Lq06JlG/6kqL8EG0=;
 b=gUalDbabqeDxTNkxVqYN1+6hjUnLyg375YuJKefmNDCvenEZWYKUbuqbUDB21WSXU6Jl04XyMbhraIBF58R/QXaxWsuPFwLA2HTGRN7ik2t4qX05gjPalinxH5tFGl810WbPklujBtbiNt38lEPvzv0OvVUdaLYBX2eE3S/2+hQZuNnX2XdiuWSoGmhLdtDxnEXqxZ8A2BXD017AXahSnQ+ld8VqSMAP++vHk2dsOFTucZ6u7asZ88fF1f+STOQMHxt225v67i2qgKndP9fKPakMQgEE6DqeMObobLUDtIgF6vfgAQb/smT3cQlHFj6RaxLeRZU4QKVy7F3RdYcBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4KRf5F7u3TJzBlpa9im6TC32d6Lq06JlG/6kqL8EG0=;
 b=alZnyA0+2y08J8qalrtKUf3AWMgRbSc4V87AmwfW8mw54IEsO+rJfsPuk+st5MV2sx+theaowcq4luG6xGwRsRKkWVfu2+RqKF2lD7bX/6vm+S9IBdhQYKMVJYLKQr9bSqMdnaU6GpSWVx8083f7pzkhWw2uDJLDhvhLvMNIvv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16; Wed, 8 Jun
 2022 20:44:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 20:44:05 +0000
Message-ID: <4eb71fb8-fff6-4686-03ba-877fb920770e@amd.com>
Date: Wed, 8 Jun 2022 16:44:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map
 count goes to zero
Content-Language: en-US
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220608115110.1798650-1-Ramesh.Errabolu@amd.com>
 <954e9aa2-835b-397a-299c-c98bb60b764f@amd.com>
 <SN1PR12MB2575DAB025B69322D14B60D1E3A49@SN1PR12MB2575.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <SN1PR12MB2575DAB025B69322D14B60D1E3A49@SN1PR12MB2575.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2696ae8-06b8-4571-ff6f-08da498fa08b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3775B2534F814713EEBAF0E092A49@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qO3XyDmoUxxS4D07yHY/F9dLNb95F4xNxIJ90lkMviRvzaJvxyN02SxnbcPOBw9on6PYcfSQRZW6AGQbDS3sEVY5U6TcrbjpHII5DfXsjH+pyu/T3/amnindKZudqDnlLTWuiGlg6qFd+b9yobBkN4hoZIijpo5B5eAOojC3FFrr8xQIJ/UpYzAVuZqHRxgGFUiIGKMlPZwvGHNiLatn8wtRqpFi06ZZrVrRs2/stVCTV73zQ7B4fonmkpZLmgJEWngopav/BMRW9g1mYjaLFgzjRpt34sqzZ8Y41C0pDjxUkIAYSAieGuaSW0o3bMyj8/0lqKcCMGXtJ+laTq/+Ap8ShJzME1nEs2wqiJbHBJPvs7OuytOYpdBF+1Ilq8CtlAsF6dkb7iQYgwlv6hc5LaQFU9FD6bvrxJ3u5uyDpHn9dxsHM7vBtBtI90rIRqw2S/snhY/WkNrk0s8Qgn0exRk43uWDcnRxkYDNRt3dvmaz3likmJBGOauAIzkzDa3FzOHaib0KZ/nTC92GMot8VFebE93v1mQBym3R+W6gUfJGY8lFK/FROkQLNCO2+Apn3h3xgUpUqibjq7htYcVMofgHtNiqbaxwMs/ymNEXO9inTqZp3XkoCA11OQWo6B3T0GHX4ZXOulQFdWmx+AId8uncsdqHVPyPkIYSRlgeFok1XUg2xzY+zg7RuEik1LSe6ChQUVSyMtqDm/Rf9bw70M2NzLInK8SYtLfEiVLNFnGSBlcqXb+SjbaGp+PDTEgi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6512007)(186003)(83380400001)(44832011)(36916002)(508600001)(8936002)(31696002)(5660300002)(31686004)(86362001)(6486002)(26005)(53546011)(38100700002)(36756003)(2906002)(2616005)(316002)(110136005)(66476007)(8676002)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pERDdENTlUU1pUcW9FUkxnWm9iVys1NVVhUy9RS2UzYmI2V0dlTzhoaEtR?=
 =?utf-8?B?VTRnWW5IdzVFUTM4UkxNbE11YWgwVWs5a2F4YUNFRE12OGUrd1VFUFltN29R?=
 =?utf-8?B?Q1UxdXo4aEtHZ3p0SFY0bGRRUVNsS1RITWxBQlYzZWp1V2hrWjBZb2ZIWnlw?=
 =?utf-8?B?akVmbG5UZ09ldmRkZ1BKOVNSUTFaVmszZFdiRnJDWmU1SDAyalA0NU4zaVRS?=
 =?utf-8?B?T3VzRWtHV2tBNVVzVzVidXJVcmE1VlAxa2xub2pBN1l1ZnJrdmFFaE9FUDhi?=
 =?utf-8?B?RmZZWm9NM0l5bDV1dWx2NUswTkVuM2pGZGVhNnBtNmd5VndicTV0dVNwNjRD?=
 =?utf-8?B?WjVnalNzcFBmYlBid2VSbTduZytDSWhLYVFnbnlWZ0NwcnBuQzE1ZXd4MHJN?=
 =?utf-8?B?NWh3S0dnOVJjUzFQRE9KRDduL2JlUGtaQm8xRnB2Umc3REdUS1YzM0Zud3dE?=
 =?utf-8?B?YWI4d0lXaS9OV3FpRUFaQ0g3aEZsOVRwUnU2YXhQNm13M3dqZ2RFUjRlMVox?=
 =?utf-8?B?WWZFR1N0cWZFL295ekIyQUQ2anZjeHNHUjR0dXBYcHlWQzF5MmU5M0RlOWVk?=
 =?utf-8?B?VklTczE3TjhVbVhiZGNaajI4SGdpS25CcnF0V0NhVVFPNXUrdE90eWtsQ2Fj?=
 =?utf-8?B?OFM2RTBwQjNTM3VDQzVDUnoxc1gwd0k5TDhZQ1lYYUF4RTdlcjBhODUyK1Bo?=
 =?utf-8?B?UXY5dG9RN3FvT3NjaG9HeUZ6M1pGM2FyZjBZS24xd1FBR1lOcUpmdTdCMTBT?=
 =?utf-8?B?ODcwRmJpL3hKa3l1UXJvenN1TGw1OVBLbkdKSUpldTE2ckFNcmJDQ1FDbm5U?=
 =?utf-8?B?dWpoWTBub2VITkc5cFJRcVRNd3dGQVF3Rk5SSHNhb2JZbUkwSDNRWW5mcmdv?=
 =?utf-8?B?a3NsU050NGg1ODRhKzlXU2FrTVF1MlRxZXBsRDUrRjAvYkxoTkZES2VtVmtR?=
 =?utf-8?B?SHRHNUVVWDNyQzFuYnRhMWFrMjMrRjRxZmJjcFFLNllReWdlcHlKeTZJQ1dQ?=
 =?utf-8?B?WXVxNEw3YTBmREhJODc0N0JoVC9MMzE1VlEzUkJwZk5xNzNJdlV3RHBUazhT?=
 =?utf-8?B?d0pETmVkZm80OVVjSU5xSCtNMlNvbWZ5T3E3QkhKUjBjM3NQcVRjSlZyYnp3?=
 =?utf-8?B?MGw3TE1KM1B5ZUo1NVRnWUlzcHBXVEo5UExDYi81WmxkRUJlaHMrczVLT2tS?=
 =?utf-8?B?cVBSTnhTU3RPMU9iVHZ3M2JkNWVpaDNLZS9WYWhlcXBTM041WCt2dUdjWUhO?=
 =?utf-8?B?YnBXZFZqamx0M3JFN0JrakprK0xjMmNJREtBK21teklCbXBXVzlTaGo3QVhQ?=
 =?utf-8?B?Q1ZSdXV2RG9VMnlLMWlzdXpVWDcxdlhBVmNobWx2SjhxcnJPTHRFM2g2ZXhh?=
 =?utf-8?B?OHhlUTJWNTdlY2RmbkxlaWhyOFE0d2FOd1cwVlJGOGxKOVVnQVFTQ2dNWkpO?=
 =?utf-8?B?K0pTZE1zZ0syU0xFcWlhVUo0a215VkJCenhOQ09LTngzY0RHT2dnQjFiY2gw?=
 =?utf-8?B?TDZnZzBaT0ppdzJYMTZlbVdPVnNtUHlWTjhicVd5OGdJVjc4bE5IWjVjdjBW?=
 =?utf-8?B?R3BuVEQzOE5ZVFppRk1WWmgvVVRXNjZuVTFMajR1OUQ0ZUlKWEgreG9ZVllR?=
 =?utf-8?B?U2dxbGNGUzFlRnNiNGc5WUhPZkFwNlB4SjVOenc3b3dKeEFUbVJ2Zlk4M21W?=
 =?utf-8?B?UmsxV3NobzJOSmZrQmJER1ZVMkVmL3lWejdlNVorNzNJUkVkYjBEcGRSdVdt?=
 =?utf-8?B?eE5KWjRGZmFUeGtzSHp1TVd0R0dKZ3RIUnNOZ0NPMjAwZHFaQnZGWE1GK3Jt?=
 =?utf-8?B?MGdXSTZKYUVGZFVROTJweS90WmUwTXdNcFBZMG8vWHZSazV5ZlR5VnNGWlNB?=
 =?utf-8?B?cUNMc1UweTBGYS9ieldPU0JscTJjeVlKSWZZOFlNQ1JZTnhrN1BobG45Sm9i?=
 =?utf-8?B?anVZZXhzeE9kZWl6bVJZZDBmcXFxQlBEcXJ5S09lVWZqb1FYbjg0cDJhaFFO?=
 =?utf-8?B?d2NhajdGaUxJK284RCsyUVpYNzdHK3Bibm1wK2I4ZXBVNGNGdm5FNTNXcWMz?=
 =?utf-8?B?dDNzMVcxZ2RuRUhxd3ZnK0Q4eVh6cHpTZ00vZ3hiWVlpWlYycFlNQ0NwOFNp?=
 =?utf-8?B?U2RmMGs3bWZ5MFBwd3czVW9zTTJ1azkvMTJMenV5eFVFVE5CSUJmRVpuRHV1?=
 =?utf-8?B?WWZiU09taFZ3bWhRTThWdVNWcm50SG9wb1lVRVZLZmFFNTEwWm5TRTBlWEky?=
 =?utf-8?B?OWJUTjBqTkc0Y1JhdGtBWWtreE5rYmJHYXhCSTNnbHBqNFA1RWU3SktUL1JH?=
 =?utf-8?B?VlhiUEFrWlpEazA0UjdzeHZVdUYvU2M5TTJjbit4c081ZnRqZXNsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2696ae8-06b8-4571-ff6f-08da498fa08b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 20:44:05.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v380rXblvCpRR/YL6LjWxdNO4eYkYLNJROLUzXwcg2AAkmfdBwHuGbKaVvA50TBGFFlkZaKfENm84t20a22/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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

On 2022-06-08 16:03, Errabolu, Ramesh wrote:
> [AMD Official Use Only - General]
>
> My response is inline.
>
> Regards,
> Ramesh
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Thursday, June 9, 2022 1:10 AM
> To: amd-gfx@lists.freedesktop.org; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map count goes to zero
>
>
> On 2022-06-08 07:51, Ramesh Errabolu wrote:
>> In existing code MMIO and DOORBELL BOs are unpinned without ensuring
>> the condition that their map count has reached zero. Unpinning without
>> checking this constraint could lead to an error while BO is being
>> freed. The patch fixes this issue.
>>
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 +++++++--------
>>    1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index a1de900ba677..e5dc94b745b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1832,13 +1832,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>    
>>    	mutex_lock(&mem->lock);
>>    
>> -	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
>> -	if (mem->alloc_flags &
>> -	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> -	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>> -		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
>> -	}
>> -
>>    	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>>    	is_imported = mem->is_imported;
>>    	mutex_unlock(&mem->lock);
>> @@ -1855,7 +1848,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>    	/* Make sure restore workers don't access the BO any more */
>>    	bo_list_entry = &mem->validate_list;
>>    	mutex_lock(&process_info->lock);
>> -	list_del(&bo_list_entry->head);
>> +	list_del_init(&bo_list_entry->head);
> Is this an unrelated fix? What is this needed for? I vaguely remember discussing this before, but can't remember the reason.
>
> Ramesh: This fix is unrelated to P2P work. I brought this issue to attention while working on IOMMU support on DKMS branch. Basically a user could call free() before the map count goes to zero. The patch is trying fix that.

I get that, but I couldn't remember why I suggested list_del_init here. 
It has nothing to do with unpinning of BOs.

Now I recall that it had something to do with restarting the ioctl after 
it was interrupted by a signal. reserve_bo_and_cond_vms can fail with 
-ERESTARTSYS. In that case the ioctl is reentered. We need to make sure 
it doesn't crash the second time around. list_del will remove 
bo_list_entry from the list but leave the pointers dangling. The second 
time around it will probably cause corruption or an oops. Using 
list_del_init avoids that by initializing the prev and next pointers to 
NULL.

See one more little fix below.


>
> Regards,
>     Felix
>
>
>>    	mutex_unlock(&process_info->lock);
>>    
>>    	/* No more MMU notifiers */
>> @@ -1880,6 +1873,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>    
>>    	ret = unreserve_bo_and_vms(&ctx, false, false);

This unreserve_bo_and_vms call cannot fail because the wait parameter is 
false. If it did fail, the error handling would be broken. I'd add a 
WARN_ONCE to make that assumption explicit, and change the return at the 
end of this function to return 0. Basically, if we got this far, we are 
not turning back, and we should return success.

You could update the commit headline to be more general. Something like: 
Fix error handling in amdgpu_amdkfd_gpuvm_free_memory_of_gpu.

Regards,
   Felix


>>    
>> +	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
>> +	if (mem->alloc_flags &
>> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
>> +
>>    	/* Free the sync object */
>>    	amdgpu_sync_free(&mem->sync);
>>    

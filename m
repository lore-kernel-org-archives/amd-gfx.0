Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCFCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 16:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC7710E529;
	Thu, 19 Oct 2023 16:20:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F53F10E527
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 16:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lkcx9jBkmgMQPVfklEdiQNUwEkr95M8qzdlITiMnb+YbrLcnX5reCwAEE96dOzuzAXSM+jH7gkcGjPGRnIAq7KyoT2inEGnr42TKaOJ7vCky2ievt0TA+hA6w4/B8A04ne8yg+QPsiWBxsLsVr7uiOLHdokfLfrFdk1ez2Y3o23hKw4kHep7a59UGoK89dM+wz8mIISglsw5gVEGphgaQazPMrFEhotBwF9+XgZpDvCl0GKL9OjJXVPxRd4W9ZqoBOjLB2j6NjQ/cJwHK4yFH6tcoSVKuPYxQs58J1vEWU2Okt33qggVIG9tHKwjqsah0m8K7kNefmhF28MHj1gFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mo9PciY7447T166Jh+J8z+4Wvt/wrRSHr0IpmarTJo=;
 b=i1c7K2S4DjhYZeCHa+LHHTQ8Pcgonux/XZCr+09PCcS7PgrekvMALhinEgV1V8M9cpqdNPuEbDzM6RQpWqR0r+nM4tu8Z1rZHCDeaoNGd7fWiqxGJFbdhzmDOzsb49oKQPrWO53kuw8Jysbo33Dgpo2xO/2rMtH/+Z05DqbqVZD1f9VyNOx8OIhXnjnwxKWfw7xSHT6l71nNP6LM9MpSLT5SFg1Twm0rC239QBZovngMhVuevMrUIzkoFeJJ5ffXtztOjPCbYnjPvTUcMuOBfNiZ1WWDLpDXz4HKjbCqiACgC079MHjh7A48uiF5aQxAxxFszvUyJHGU8dMSclU9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mo9PciY7447T166Jh+J8z+4Wvt/wrRSHr0IpmarTJo=;
 b=VTV/UZKDz35ZYyVp2BqQZgddK5VSuWiVu/EM8tqvQoLsOMxrpyU3Mmh35IdIiWEQQsIHdXiAqP9fX05PbV9jIr5tS9eDZZLIymffetE3ogKjoJ5kRnlQNEKhiHfKdma/ZY6zySaQe+SS0CVcFpvqtiGuVQqeeTbpmtXCx9vkR0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Thu, 19 Oct 2023 16:20:21 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8b00:757c:424:38c2]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8b00:757c:424:38c2%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 16:20:21 +0000
Message-ID: <56bbfe3b-38ec-22c3-4f57-61c409bc7c6c@amd.com>
Date: Thu, 19 Oct 2023 11:20:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Use partial mapping in GPU page fault recovery
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019142441.622430-1-xiaogang.chen@amd.com>
 <9e5addf0-9e91-d67d-af6e-e89479572478@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <9e5addf0-9e91-d67d-af6e-e89479572478@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:8:57::20) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e8044c-760f-4fde-b74f-08dbd0bf4a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTG6TBWflmTZRVcFzZU6EorEHaYF/yqNsC3mV5MFZsEb5IgtQjKyKNyqlY3u1XU5weUv4LZL1KDbrx3DayRBVjj6p9g7VZzJowIrKbPc0vxXRVxKyh4yUCq0zbfIISnVWiOuKylP0qiKJtUiKGYsfnjVxwI9EKkusjd2kW2fuSTbsnbyjrp87hUaytwS+4z/APieEHnLlUh0SxXjNI+nMxkBsiPBRQ/NFFNetSgGas49zvgzGi789KMtVeBi7Fik3Y9ohyBupDZqvQIrguaPv4iAwJ/fOhr4twQBG3qMPztbdQ2UNdbt8PaqwcJ6G5c8BtDsZY+I+c0HUMzpZomA6adIh0nVbSl7xFRJ7hq6HiV/IiLoHzN21Gp7skxjhAUsoRevh5/f/Y3mcRJxA1hhqlA0Ucg/taLCIwoGoh2PxvuEiZmIve1DQVkrHkC2CJP5ZUOAaEAJi2bwL5cihiC2zp7Zxf5nwuG/JsOBDYWUp/VKn9D1tNI9z+CEeoWxuQ152O4HclGLquYnwjW3pA1ViseEJeHfwozDeQpJ7d9u25S6ullDdsX4RorjrJfnG3mzn63KRMcW3D18WmurhtiuSl+POZVBzP0CFh0a+WBjHvcRxPn4W0tG69dsM16+XyxfDY6yCMXXDf4RyndeQpAsNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31696002)(2906002)(66946007)(66556008)(66476007)(316002)(478600001)(8936002)(6486002)(5660300002)(41300700001)(8676002)(36756003)(4001150100001)(4326008)(86362001)(6506007)(38100700002)(53546011)(2616005)(6512007)(83380400001)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0kxZ2V1OCs2Sm8yekpkQlJPZW94MklQOVpXSWliSW4zTnNZRkFJWm85b0RS?=
 =?utf-8?B?dlkyTmxXS1NZQ2pDWXZ3ZTk2aDZGZWtncmJvMFlkQWl2WFI1bzBTUGNHOXdX?=
 =?utf-8?B?STZ4dW5vT1NDa0RxbEphVll5L0Y4MHlsbkdLdjdNVkt4UGJLNkpkdmNKT2gr?=
 =?utf-8?B?enN4ZXowZTdUekxqRDg5MldqWnBBWVZvRUxGQ3F4VzdlUitvVDFyR1c0c3ZE?=
 =?utf-8?B?NDFCMWxNMWVqUTQ5dVJCNUdoS2FrSUdGeTVpTUVVOXZBY0JiVGp0MkFWZFdD?=
 =?utf-8?B?bS9RWHV5Nkd3V1VHZ29QK29sZWZMTnJZVjNrdDNiK3hCTVZlQXkvVEtKZmtK?=
 =?utf-8?B?NFlua1FtUU8ySjVqbU9ORDhhMUNtbUNBaENsT3lMZEpMbER2V1N6Z01jUnpr?=
 =?utf-8?B?V09NTDdqV0JzOTVuWDBaWmtQQWtvcnBLZlBydTgyWFFtaVJSaGREREtYWC9x?=
 =?utf-8?B?U2pQc3puaENpdEpQdWZVdXp4eFBpcXZ1SXBGWUVZSXhKcUpYaHY4TWpWSUw3?=
 =?utf-8?B?eEUvV0I0QWZMd0loL0JvMTBvSWZVZmt4UzdMbWoyVkpVVFFQU0N2WGh1NldB?=
 =?utf-8?B?aUMrSWgxLzNyeW5leGFwQVFFSm1zOTBISDAzNlVSaVNoZ2dCN3RYK2pUN3Iw?=
 =?utf-8?B?SmhWY2VNRUxVY2lsT2xKeStNdmZpeVhwYURUS2RSRXJ4bS9uRmhaR2FKMjlO?=
 =?utf-8?B?b2hTckl0a3k2UUlseGMveXcxOU44bmxvaTRpTFlDaG5CVmVBTkF3dmJlYWIw?=
 =?utf-8?B?QzVvR29rMkQ0a0NnSk54OENVMUJINGxtWHRjRlV3RkxGRDdLVCs5TC9sVlhz?=
 =?utf-8?B?UTlvcGhMZnNRbVZxZHROMDB5UEdpREpLc2g3dnVEZ0lsVHY3MEtRTXpWUjl4?=
 =?utf-8?B?WGlwRWpwbHRFblhVVjd1T1lXbXlUOTdpT202VldtVnZQUkgvbUlQTXltNE9S?=
 =?utf-8?B?U3BoT2pJNkxNeVZTTm11ZEg1ZE85ejh4S0s2WklscmdhdDhIb2p4bldQLzhh?=
 =?utf-8?B?bzBua1M2NUxHTjlmT2QrRDMwblU4S3FNeWtCRU5BSVZaNWlXQlQ1T1VNQ3ZD?=
 =?utf-8?B?cjdONENicnF3eC9pWGsvc3l6Yy96RzZycy9zKzg3ckY2aEFVWEdta0k5cnQ5?=
 =?utf-8?B?bXZ0VmlaNmF5VVZ5YnluTTB1VlY0M1htNVhZNzJPRkJScDVPdFF0djI0ZWZW?=
 =?utf-8?B?cG9TNlNvQ2w4cFlIQTJUVzZCd0RtTE5sRHlVL2lVRnhmVytnbEV0MDkzS1lC?=
 =?utf-8?B?MUdnamcyU2hoVnI1SjRaeGJwamlkNktVekJ1Y0tuaGZXaWJFWExBSlJkQzRz?=
 =?utf-8?B?d3MyVUhINVZaY1U2YkdKS3lFcVRoVHBpOHQ2UWJpZGg0aWppS2s5eHpnT25l?=
 =?utf-8?B?THY4UlY5K25ZWWRjNXAwcWZQdFVXZU1NZWhGbDlYbnhzZmtrMjJGeUZDc3dZ?=
 =?utf-8?B?cDhEN1N5OG5OTmE4L1dWeE9kRUpnaE9wWHVVWTVmSk5pdTM5Z2F4aGtERDVF?=
 =?utf-8?B?T1VobmpRSjRxNDhFQWl5d1FJTndaSmI4dkxtaDFWN1ZSR0RiTXFhYy9HYWI0?=
 =?utf-8?B?OHBMUUtKUENNdW9SMjZyY29OYnJ1djEzQ2F0OU9uT1dGSjVlUktGZ0hydEI4?=
 =?utf-8?B?T2pQUnFrakJoOWJMTDRwKzIxczRyRHcvalpLYytHRlNVMklqckdwYTdSVVI5?=
 =?utf-8?B?QzJhYm1XbTFwVjJCNVFJckJ0NTZVQzBxbURmQkc5YnVEZ3NRMmVGOEZwZG50?=
 =?utf-8?B?S1lRY3FFT0RyVmFpSy9KRG8ydmE2RkxXdE12Skt2N05BNUlBdHJwc1o3djJG?=
 =?utf-8?B?YnJuS1lsOHRrQnJTd3ZvVTdNMTFicXVKd3pXMTNNNm5WVlNxVXBJY2ovb1pp?=
 =?utf-8?B?ZHk1ZXg1U1Z6b0ZkVmpyS29OM0xJVzNPVmtpczNnQlpHYjh4WUdaSkNCSkN5?=
 =?utf-8?B?RmhmYUxjSnF2MG53dkF2L1pJMzQrQ3FIYjMzc2dyZzJ5N3VhS1kzT01mSktX?=
 =?utf-8?B?QmhVYnh1MXMxQlA5RmlHd0NsU2pjeXMzTVkzNUIvSHR5M2FVR0prZWNLaHNi?=
 =?utf-8?B?VThHRFZIckdKTmpET2NBNzVsaFFUM1VUWk1NdDZXZExDKyt3Q25BNDVEcWcy?=
 =?utf-8?Q?xDqU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e8044c-760f-4fde-b74f-08dbd0bf4a8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:20:21.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCMWnWFMbwrzFULdQqY9A0b/yc4Jm7NPJU9YRQ1PT3E4GuSXb6zh1ET/5vr8Lk2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/19/2023 11:08 AM, Philip Yang wrote:
>
>
> On 2023-10-19 10:24, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> After partial migration to recover GPU page fault this patch does GPU vm
>> space mapping for same page range that got migrated instead of mapping all
>> pages of svm range in which the page fault happened.
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 33 +++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 54af7a2b29f8..81dbcc8a4ccc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>>    * 5. Release page table (and SVM BO) reservation
>>    */
>>   static int svm_range_validate_and_map(struct mm_struct *mm,
>> +				      unsigned long map_start, unsigned long map_last,
>>   				      struct svm_range *prange, int32_t gpuidx,
>>   				      bool intr, bool wait, bool flush_tlb)
>>   {
>> @@ -1630,6 +1631,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   	int32_t idx;
>>   	int r = 0;
>>   
>> +	if (map_start < prange->start || map_last > prange->last) {
> This is not needed, as this case should never happen, and you also use 
> max/min to limit map_start, map_last below.
This was just a sanity check, I can remove it.
>> +		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
>> +				 map_start, map_last, prange->start, prange->last);
>> +		return -EFAULT;
>> +	}
>> +
>>   	ctx = kzalloc(sizeof(struct svm_validate_context), GFP_KERNEL);
>>   	if (!ctx)
>>   		return -ENOMEM;
>> @@ -1747,9 +1754,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   			r = -EAGAIN;
>>   		}
>>   
>> -		if (!r)
>> -			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>> -						  ctx->bitmap, wait, flush_tlb);
>> +		if (!r) {
>> +			map_start = max(map_start, prange->start + offset);
>> +			map_last = min(map_last, prange->start + offset + npages);
>
> This should move forward to outside the for loop, otherwise 
> amdgpu_hmm_range_get_pages and svm_range_dma_map still work on the 
> entire prange, and then prange->vram_pages update logic should be 
> changed accordingly.
>
We need use hmm function to get all vram page number on whole range as 
we did not know how many vram pages after partial migration, then we 
know if can release vram bo.

Regards

Xiaogang

> Regards,
>
> Philip
>
>> +			if (map_start <= map_last) {
>> +				offset = map_start - prange->start;
>> +				npages = map_last - map_start + 1;
>> +				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>> +							  ctx->bitmap, wait, flush_tlb);
>> +			}
>> +		}
>>   
>>   		if (!r && next == end)
>>   			prange->mapped_to_gpu = true;
>> @@ -1855,8 +1869,8 @@ static void svm_range_restore_work(struct work_struct *work)
>>   		 */
>>   		mutex_lock(&prange->migrate_mutex);
>>   
>> -		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>> -					       false, true, false);
>> +		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
>> +					       MAX_GPU_INSTANCE, false, true, false);
>>   		if (r)
>>   			pr_debug("failed %d to map 0x%lx to gpus\n", r,
>>   				 prange->start);
>> @@ -3069,6 +3083,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>>   				       write_fault, timestamp);
>>   
>> +	start = prange->start;
>> +	last = prange->last;
>>   	if (prange->actual_loc != 0 || best_loc != 0) {
>>   		migration = true;
>>   		/* Align migration range start and size to granularity size */
>> @@ -3102,10 +3118,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   		}
>>   	}
>>   
>> -	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
>> +	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
>> +				       false, false);
>>   	if (r)
>>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>> -			 r, svms, prange->start, prange->last);
>> +			 r, svms, start, last);
>>   
>>   	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
>>   				     migration);
>> @@ -3650,7 +3667,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   
>>   		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
>>   
>> -		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>> +		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange, MAX_GPU_INSTANCE,
>>   					       true, true, flush_tlb);
>>   		if (r)
>>   			pr_debug("failed %d to map svm range\n", r);

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651B2EA3C4E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 12:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D7510E4AF;
	Thu,  9 Apr 2026 12:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BKDd/qie";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5870F10E4AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEhtDSKLuCVY6ng90Om7L4VnxUYVb+w/KqbIv+DaEb48J124xwST646vBVzWsK8mRa64/3BN9xvsPlJq1K+59g7GQG8J9Bs+aFkcB1cSQZ84+nAE2RED8a6AOqRFPL8L+NOD0LOn18U4iHi8H6wahXtkLrM3S4kOrZaYBAebB5QiHsERwTq/sAIP+bOZvjsbtMfm1IlCjPZ0Z1ZnQCMp9F29m/kAGOQmGNW71JVOzjMdRpcQ8D5TQfo4N6Mwem6cZUzWdbsgrOvkcQPg8VVfqkIT5qvoCg1JVDNI91K94hshk8ZNnLXk/VbjOuUu3C5Rj9tdeC6niINCP1hANGXHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G5h7pvva3+hM0ooP9t2DmX5rOhld1GZHzRSejKCRg0=;
 b=dBaWSKQYyeOmrkGDuGsks+JCT91zw3faz/qVPutY3UoGIWMFwVJYkMbVAJXd6tV8c0DhboXQSVLh6GOgnhEFHKXfj97Rl2ZaPu2xU5pF1Pm1gW6LtxMVsKpbE9gdGI2ObtDy9sq57sshsfSCgQBjkyxpQu/jLr6UmW6ZiVcDvMUH847fxahBpteDS0s69J74qtCQw2EESqe1gMNlOzKzRYIJZa26gdHQZso7inahBZVkCl3aNw/0cdVmD3erECsvX810KL0D5m2QxFCJARwml2rjcavmUPBtVXdfzw4q2/9/sF5D2BjU/gNaMN+Kcr059y178JeXhHXVSyChyUeoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G5h7pvva3+hM0ooP9t2DmX5rOhld1GZHzRSejKCRg0=;
 b=BKDd/qie0LJTmldPEgrEB5RVk2MawgX86UjE8Lfv5MvkgQo1hWj/vJt+3yd7Rppr0zy0wKcW2ohlLq51vrTh4r4isJysored0YCriOEsBCTfgWTB4xyb5udma2l6Cd+r2qNVxLPPsP3ER/LV+Al3vaw/tSiXzNXffpHPg7qivN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 12:48:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:48:06 +0000
Message-ID: <3b5af30b-9575-4c4a-9426-34fc4c01bd99@amd.com>
Date: Thu, 9 Apr 2026 14:48:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/amdgpu/userq: caller to take reserv lock for
 amdgpu_userq_buffer_vas_list_cleanup
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-4-sunil.khatri@amd.com>
 <25488a11-dee0-4397-949f-d166edaf674c@amd.com>
 <ec94e8db-712f-4409-a7f9-f800ed1f093d@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ec94e8db-712f-4409-a7f9-f800ed1f093d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: d07e0d34-32d4-44b0-5f99-08de96363f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: hU/pvpWjttbnNcbbR1Zv0hyVFgAHMRQxfZBDIhrDaXsvBJr+n/ycDQ5NmJTtB0adS7i5pTpVdxcqVO+yBgNp8Zd5DA5hGxBJmR7Ks2GUM8q1DP5l8I5DsYXj3Sj9bSKblpsDGfTR1FEaPvwuYBkB0d5bwtv3KoGG/FErT9GcebStiA+Ilf85hKAkUSyYpCmJc/dCCXoGnzwnH0S7xICYLZPsRdonagy+GXmuopD+roYnbw64A542EEtmXDpn+lEODEHZbHT4kZai88jsUTQM04u0Ppt0zZ/f8mbdCutZjdFYcSs4sKpUtsQMTPs8XS1FwMqDk/LMq0j7NucAZZmJwb8vqxKHgePRQMUJqGKFgzrcIEi0FmDuWNz7P/Aqma2upQ6FUwCH6wNV46WrLPASw02PIy0mzoodt/lnbR5fiTg1p5d3PeUS2/bKhp1eFHST7pRVH/kHhq6jiBzHzKSDRlfcy+gOpWMUjJpeJUJnjVgyK61i8OT1pHcCJ0wa03nVohfkdU6ZVYZOIgJJvR/Nh9za42Ip5+eDINqLUCAZFqfvPTmOesj7NVPmDZzDEf5ec3fIaXRJrZHgz7+AO2ickSZVYYe2VLajqRU2j/1qEFHuk+57M3ha6XaRVgJIreR/3/ifLLBm4g2YtBODmPe7qz0dF0L86ZVwBgrqH6UQGyjzKGofvDuq2Gry+Tq3nYwABvXd6imfDWHZhZrzBuUM7iE0kejxrX7nsNwKbo/ukYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFArYVRPVFBPTWYxeDdDTG9nbkIwenZBd3M2bzZ3ak53NzR5MXVTeU0vMzRh?=
 =?utf-8?B?UVA0Q0sxNjUyTkhKYVlsTmM1V29HRGx6MHRxbTRJU2lZNEs5MS9vVU9UZllj?=
 =?utf-8?B?U3R5S09WbnZYNkNXWkxkRjhqR0tvMTZnSUJITG5xRFQ3clN0azN0QW91c3pz?=
 =?utf-8?B?dG1WQW1hS3dnbnViVDMyQXlIWVZJaG9QdG0rU3BrTE9OSHNvRU5pK1BxYklO?=
 =?utf-8?B?N0hETEZwRE9rK3QxczZ1anN5YndRL2ZtaHE4Q0J2b2E5R1ZYbUlFekRONmwy?=
 =?utf-8?B?N1RKU1FDeTBvSVZpVXc2cUViM21LSzRLdXVkM1hidVE2V1FxS2pBTzJqd0hM?=
 =?utf-8?B?ZGRoS2N4UDArM25VTk9MK05FcjE5ZkJJMFlwV3ByeUZkYll1WWNYK29Ta1B4?=
 =?utf-8?B?cXI0RjQ1SzF2VG5GcFFVWXpmS2V3LzBuR2JPb2dYb2RGeXdyYUZtcXNPaS9L?=
 =?utf-8?B?dFJJUWRXUFFIS1RoeHVVOWpLRzlHNE5rUGtpTHhvY1JwcGpzbnhMRWFEMVBY?=
 =?utf-8?B?c1Z5N25LcGkrWE5wSm1yQmxHaEQvaUVHNHVVQTNNWllhcFg5SDRYWnVVN1hn?=
 =?utf-8?B?UlZlR29rYVUzaURpOVFPVnZvQ1NGakNiS0JES1haaVlrdjhGQ2hndEFQMTg1?=
 =?utf-8?B?UHJDSWowbkFiYjdZdDJ1QmszbW95RnFlUlpTaTIzbnRucnFUcWdMTHAraDhp?=
 =?utf-8?B?L29qT0hTaE02akgwbWdZemJpN0doemZoV3h0T2U0TUkyZWZ5eEorQ3dPckd4?=
 =?utf-8?B?S3ZZK1dHNGRQWWJKQlpFRUVUYUFhdjNxTUFPYUlEVVB6SmZCRkRDL3ZKQk4z?=
 =?utf-8?B?dFk2a3hZMFFGQlp4WnBRckhLYUdMd2xISktwQkhPK3JpeUJjdm9UME41WWFw?=
 =?utf-8?B?eFBJZTZPOU1ZeDUwOEdSS3dONStZNklxWkxObGRJNmJpakdHT0p3SVJZeEZz?=
 =?utf-8?B?YzlwRTIySlpUejNzTG5UZXlWSyt6QmFNQWtYOUhLT2grVDloOU9rMjBSQ1NO?=
 =?utf-8?B?YlpIZXd3ckI5V2IwdjBmRG5sbDIrRzZPcTZOYnk4emNXd253RFgzKzNJNGxS?=
 =?utf-8?B?bWN6R2s0dEtGNzh1cmd0Slh3azdsOTZNQUw5SjVyd3Z0bm5MQTVLNzhYUW12?=
 =?utf-8?B?QzFnYWg4bmRFL3hDb3JsZkpoOE5lNXNVVG5nK0IzdENSNjlLbTI0RnVUY21O?=
 =?utf-8?B?NGhpWk1WV0p2aDdFWXN5T3pVdU52Um5FUGdEb2licnN3THdrZmlBeW5OVzla?=
 =?utf-8?B?NURMTGVtc1lXNngyaXJ5NklLWVBpa2tteVM0aTFNejhPQ2VmTVNMU2xROUVW?=
 =?utf-8?B?bmdLQzdDTkhJdHVQTXZoVnRHaDFSNWppWTVCZ2dFckZnSHZoRWt1SnZjalZp?=
 =?utf-8?B?TUdMcnVVU0dUVEo1TVFqVnk2REdHWE9IeVJ1ZWpGOFJNeUxKUkl6VEN3NmpM?=
 =?utf-8?B?SUd6ZVZRVEVkb1VzcnA0cTNpTHhkakZzNG5MM2pPM210eW5KMVZWMXhLbFA3?=
 =?utf-8?B?OWxjcTl6dERGVjNYMTB4aXlPQm8zVEJSL0xXWTJGZDdRUEt0RFdMSEZaQXNV?=
 =?utf-8?B?ak1xMGhzWmUwN05kdmFEOWhNdnNRQVVtY1ZyNS9XVjRZd0hFL2c5YXVUa0ZI?=
 =?utf-8?B?Mis3dXlsRXlSVEJ6bmMvbEJhSmlQMllaME10ZSszYnhzU0M0cXYrWFVadUZW?=
 =?utf-8?B?bndUNWlCYVNMNU5wNldscFVvMDRmU1dERXIzZG0wSHZWbjlya3VFK0VYdTBt?=
 =?utf-8?B?czErdStiWnBvR0pjM2liMWFxQzdZMjV5S3I1ckxiS0VCdDdNK3l0OWs4QzNQ?=
 =?utf-8?B?WXFRb2J3ZlZtNlliZEptV3Bmek5CRVlCUlpDTWE2Mk93UmtGT1dWWTNvVzZG?=
 =?utf-8?B?c3Z5TUdzMGp0WkFEYzkzQXNVSGN3Y2UzVlBCSGxnZG5ZTDB4eG16N2lMRVVt?=
 =?utf-8?B?Y1BZWUtDMU9JMGJUcWw0Q3JjcXlpT25nNWc0M2h4ZFpQblJpaUV5dERIMzl5?=
 =?utf-8?B?WjBRZnVDTUg4VHVOUU9IaExQa09tQ0VaRWJhRCtYRzBDRTdaYk1iZy9rNStN?=
 =?utf-8?B?VkNncEtTR0JtMGdqN1YyRnovbXNacVg4b3dFMWdFQThjdkRNVUhUVmM2MnV5?=
 =?utf-8?B?MXNITzRvcG1lc1B4SnBSWHhyN0JkZTJybnJTTmRiL09ERmxsemZPcm4xWGtR?=
 =?utf-8?B?L1RoNmI1eDJySDRHeVpoZGhWZUtXSjF6UEo4M1d4Z3krL2ZRRDdGOVVycW12?=
 =?utf-8?B?SU5vSW41U25OSEVYVjRJcTU2ZzViQmQzUlRyY0Juc3lzV2l0dGtiaURSdkJ1?=
 =?utf-8?Q?SavpdZ8KmfumDFpFRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07e0d34-32d4-44b0-5f99-08de96363f39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:48:06.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IKuI5QKDE4rnCTG8+eJMgeOcfob/lG/3k5BlrcR7uh9mqWuLd/fLiYdeQ8aTOxe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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

On 4/9/26 14:41, Khatri, Sunil wrote:
> 
> On 09-04-2026 05:28 pm, Christian König wrote:
>> On 4/9/26 10:33, Sunil Khatri wrote:
>>> Remove the reservation lock for vm from amdgpu_userq_buffer_vas_list_cleanup
>>> and caller should make sure it's taken before locking userq_mutex.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 34 ++++++++++++++---------
>>>  1 file changed, 21 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 2408f888c4d9..1b81ce49d408 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -312,25 +312,21 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>>>  {
>>>  	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>>>  	struct amdgpu_bo_va_mapping *mapping;
>>> -	int r;
>>>  
>>> -	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
>>> -	if (r)
>>> -		return r;
>>> +	/* Caller must hold vm->root.bo reservation */
>>> +	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>>>  
>>>  	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>>>  		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
>>>  		if (!mapping) {
>>> -			r = -EINVAL;
>>> -			goto err;
>>> +			return -EINVAL;
>>>  		}
>>>  		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>>>  			queue, va_cursor->gpu_addr);
>>>  		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>>>  	}
>>> -err:
>>> -	amdgpu_bo_unreserve(queue->vm->root.bo);
>>> -	return r;
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>>> @@ -444,8 +440,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>>>  	/* Wait for mode-1 reset to complete */
>>>  	down_read(&adev->reset_domain->sem);
>>>  
>>> -	/* Drop the userq reference. */
>>> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>>  	uq_funcs->mqd_destroy(queue);
>>>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>>>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>>> @@ -626,6 +620,9 @@ static int
>>>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>  {
>>>  	struct amdgpu_device *adev = uq_mgr->adev;
>>> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>> +	struct amdgpu_vm *vm = &fpriv->vm;
>>> +
>>>  	int r = 0;
>>>  
>>>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>>> @@ -633,6 +630,14 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>  	/* Cancel any pending hang detection work and cleanup */
>>>  	cancel_delayed_work_sync(&queue->hang_detect_work);
>>>  
>>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>>> +	if (r) {
>>> +		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
>>> +		return r;
>>> +	}
>>> +	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>> +	amdgpu_bo_unreserve(vm->root.bo);
>>> +
>>>  	mutex_lock(&uq_mgr->userq_mutex);
>>>  	queue->hang_detect_fence = NULL;
>>>  	amdgpu_userq_wait_for_last_fence(queue);
>>> @@ -664,7 +669,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>  	}
>>>  	amdgpu_userq_cleanup(queue);
>>>  	mutex_unlock(&uq_mgr->userq_mutex);
>>> -
>>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>  
>>>  	return r;
>>> @@ -856,7 +860,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  clean_fence_driver:
>>>  	amdgpu_userq_fence_driver_free(queue);
>>>  clean_mapping:
>>> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>> +	if (!amdgpu_bo_reserve(fpriv->vm.root.bo, false)) {
> The second parameter should be true here, and then you actually don't need to check the return value.
> 
> Sure Noted. Should i do that in other patches too in this series where i do amdgpu_bo_reserve -> validate -> unreserve. so change this false to true and go without checking return values.

It depend where the call is. If you can savely return to userspace then the lock should be interruptible (e.g. parameter false).

If it is like this here in a cleanup/error path you can only do it non-interruptible and then also don't check the return value.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
>> Regards,
>> Christian.
>>
>>> +		amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>>> +	}
>>> +
>>>  	kfree(queue);
>>>  	return r;
>>>  }


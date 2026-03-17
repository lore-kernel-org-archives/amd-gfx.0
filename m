Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FF9FD7075
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EDB10E1F7;
	Tue, 17 Mar 2026 10:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KPi4c1Da";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010018.outbound.protection.outlook.com
 [40.93.198.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B19510E1F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1Vzr/wUwi0eDkwVM79f2UTxiMe9zmi1S+/7bS400pABfy17UgxnfZ7uFxJkZnXgke5oXsxBTdBCai4GqOa+TXnzjQxZwYUoT7JHyr0ZoFBrUrcO3NOl0GNEh2UpG4bWg7ilcbujPIxaReD3FcLszkLJeSUdvtaeBhckHGGjBKEQsxjevbbuuIIJkNtvIqpr4VXubUd4jDBRBrXBRAqHpW0ACQN21cWpKjC30XsDHugLAhe4IdwjxuPC8SxabqIuMZSpYf5rKEEk3oQNB/lP3xO7g/2dNwRpLIaFcWbV+Wkh+ZPizIw1jRj7kgvIX5InpFhWl6ET25OK8HTDRxyy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT4l3flzGb/Oi3YRDn3aWQM2OO+JzfUyWPTJYhi0a2k=;
 b=OiO2KS5N7IuUdPdOki/gkzB69D+tdgTKQuUcMZYJWom8WY0B2hAKywC3hbqyZKj/x0pj3Vrn9wT+evRFodpCK7RvfRWRXhK7rqLytN4Du4Po68oWHdenR/4QjlNFX0W9pcFpTjhh9Hw7BVoMuvSwsGfioO/8H+cpucACTEpQHCN5wMAInqj02VUNul+52gFa0cbhUT+XIX+Mai/H/z3aL7nw4y2iQ76MkSA9isIjriyZN8lfxCZ4GIal/2e7oxV4sYaGvpgqIqyyclEAn6hPdmGVO/PYjMfb9U87g22CPynqhJ7ygDWQY9RyDkYmn6W2+jaY+H2owB5EWlr4+JBDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT4l3flzGb/Oi3YRDn3aWQM2OO+JzfUyWPTJYhi0a2k=;
 b=KPi4c1DasWT3xJUQ0oeIRdFNgPbqRhckNdIPHYOGP/qtvxJfQgIIa5bzLcap/fO1dgB0wh8hovNSCHFG8Rssxjr44hfZVoqGoK512pNV+to7ogDhG3yDmPMXmIADrumd8Z7Ix/AXTMQ0u95gf/1dmX8jFFWUH2Mixig0aku8IbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 10:52:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 10:52:05 +0000
Message-ID: <7fa0c8f7-887a-40a5-8fdf-55ab7aa58aa4@amd.com>
Date: Tue, 17 Mar 2026 11:52:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] drm/amdgpu: WIP sync amdgpu_ttm_fill_mem only to
 kernel fences
To: "Khatri, Sunil" <sukhatri@amd.com>, tursulin@ursulin.net,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-11-christian.koenig@amd.com>
 <2c655fb8-f8d7-46f7-9ab8-9574a45b1fde@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2c655fb8-f8d7-46f7-9ab8-9574a45b1fde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e23ca1-a87a-4ac8-af2e-08de84133a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: urXptLoUcuS3OytxerfmH4JAau8ttfk5Woj33klw5L97mG6SuFANqQv3OcwQPMIKXfALwXyMeuxJWEqawTqnYY1jSNouaz03i4OTwzniz/TgUPf6M6b8Kn92Da6cyiXt4mlKjmnwrK88vmHxxtk5bSzRQnHVLRDawqrBRpX0bhNyk9FN8yCg5OaqtKgcFwxynA4biA79aqKmrbvELG6bidYWBtlu6BVUZFbSigWtSR2zI9lT52jOGaPq2fW3w2DVVcHOo5snyoJTYho+4eu2ILdc6fd9mRF8S8v0f+LSz29TXIpNL+lgDO5gd4eXVEO1CdyAgdpUuU2HLT6w6ZlDtEv89zqn0oJMVzsfBNRhO8mbyPufl+0BU9bYLkk2Lsthfrokiti3C1kjg0pKGiYjAtqTEGOJNOKYsMpWFNTpnKkTYnZqW2NeCZEiEHNTDXM2dv/gfv6j4KEZmhkwF5IqEaPs8Q2rFCqU3jVxsosEGzAccqkfM57+Ss9SQMWQVVsmIZ1anOAPrEJpmFy7sNx6wXliLGoVUmoUAsstWfrIepMRtRf728w8dA/41fvwFxYG3xqNcVX0MeeWQPWN9e8eEW/T1e2VZUs0v9I7NlEsObzI8+s5WU8+tTvKlqdRffQw5pmgFYXuK1CJw2s3GGQ2z5YXlXUz61Ep91nzCiTa3/pQuW61FoLl1iyYza5iQbAgRenq9hihiLMGn4oyoaTuowR0Aht2N3Qo3BzXaPC2AFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVp0bUVRcWJhTng5WXoyTDcwZWtVU29pSjFFY0IzSkZkK2RoZ2VBbE0yZFNy?=
 =?utf-8?B?R293ODRtVG9ncVU2bXoxV3dwVGhtMmdKSkhQN3Fkai82TmU4SGxzTFl5NHVK?=
 =?utf-8?B?Z1NXSVNMK1JnQ2N1ci9TV3JmOUl6TGVnNC9WM2U5a04xZGl5NlRoM2xVdGpl?=
 =?utf-8?B?V04rRnJZSmhsTjlGZCszSkRXSHZqWFlaSkJhSWpGWnlRTWl5TXMrZjlSUFM5?=
 =?utf-8?B?SHRvOGVxcG9kbC92ZVRLVEpwdXlLYTMvQnVHMVAwU0RlbnFBZWdRdWRON25p?=
 =?utf-8?B?RWxvbFMrRWl4SHFqTFhKVklVQ25pbTFMMS9IZktiUEZEK3lDTzhQbTJZZTFS?=
 =?utf-8?B?dExMYjRlbWdhQjJvNVhtbjhOakpvbTIxTWtqdkt5NGVXVGdtR05aQ1YxUzN0?=
 =?utf-8?B?YXlMdHpHaTVjT0tWcmlCRm1vTHUwOUhubmxkbjhuQlhmaitKdExORnVONmpK?=
 =?utf-8?B?YXVUT3ROeDFydEh6Nm9FanJ1V1FiM29hY1VYSDNPUzRjKzVJUmhSUmo3R0FN?=
 =?utf-8?B?amd6V1ZyQi9hUXcxTnlEQnR3d2gwWXVzN3lJeCtyYVViMkppdkNaK1ZwMHRu?=
 =?utf-8?B?cUhlMkkvK1N0dXVGWmlxVGUxUUxkczRZYzM0eU5wdExaRGhsOFBrZTRLdzdh?=
 =?utf-8?B?amRsa2QxUDdrdUtPajcrYm92b3BhQVhSVTVuZytTeHBXTGRBc21kUXRUTElX?=
 =?utf-8?B?Qmk2OUk5Y296bVRRVE1hMjFuT0FnS0RPcnhseEtsVmtmWTNrSWNueXBNY1pv?=
 =?utf-8?B?L3JyNzhlMGttZFE1WVFJQk9weDlNNkRua0FDKzd0VmZWNmkvblRHcDVER01Z?=
 =?utf-8?B?ZlhMMGFrQWlaY0NmRkE1RC9PYTc1b3orbjJUSTlJOXNLRjZtQ05sQUlrbjVQ?=
 =?utf-8?B?ZXB5b0pERG5WcFB3MHhHYXJTYjYwdERMU0lQQS9rOUJ0WlA4K2I1d1RLYS9C?=
 =?utf-8?B?M1dmRGxFYjRNby91NlFTSlpWYS96SmNxWVR6UjAwbHZBc2xXdUVJbHlwVnk0?=
 =?utf-8?B?MDdLQU5HNHh1ODQ1UGdTMk9HZm9iMlRzVE9sdnpYdmI3T3ZtcmgwNEEyVTU4?=
 =?utf-8?B?OEZhMVVaQ25DMmxIVzBzOU1iNUdVRFNyZXVJcE0yVDcwSVhvVVk4WVRxQWs4?=
 =?utf-8?B?a214OWFvbGJRWHl2KzM1SDcyVUUrMUFCZ0dLbnZ1OVhQN1gzMVg4U1R0K0ZL?=
 =?utf-8?B?VCtodkcxV3VNckx5Yk5HTVlVVXgxbjBacmtjcjFpM3A4V1V1eHpyTER0UTVo?=
 =?utf-8?B?bHRhR3hDanpGcGZhNmRGZERDenhldWd2bEptZDIySStybjhyU1NreHA0Wldn?=
 =?utf-8?B?UkYzWXNYMWFFc2hVYTJhbXVOa0w2QTdtVzVBSWgzWUVVWHZ6NEpZbjVLc0NS?=
 =?utf-8?B?WS94c3BGSGU0cHQ4TUhEVTNkSEUwbWJSWXN4YVJ4SW5PVUdiTUxGb2RpWEw2?=
 =?utf-8?B?WVpOVExEbXhSV09aalROcHZGNmlNVUlvTWlhekJraUVYMllCZDFLK3J5RDN1?=
 =?utf-8?B?bnBwUTFuR2JyZThYYnJ2dS81RDJtd2FEZndEZksyYVBvVmdCaG0xSmtXZjUr?=
 =?utf-8?B?SG5uVDhCUFJOUDcwUWM3SGVCci9XaWt1eEhzZGREUGdzWG03b3F3RmxhQk1U?=
 =?utf-8?B?REh5WWNGcVc0Yk01NXdkSFFlVmlvZFRVbnVwSnMvQ2RsbXBwSXRpem1uTE9Q?=
 =?utf-8?B?MWNFbVFmWThvbmhpQnFGdmpVVUg1Mms0OHF3dWxOcVU2YUJHQjhtYzFBSHA3?=
 =?utf-8?B?eDFaQkpHVTlJT0F2Z1l5VU90bWFzWE01ZU4xSWpaa285aXBuemFUMDdLTmlB?=
 =?utf-8?B?aTlCQWFKMHE0ZWljYjVSZFZqSjBlaHZMbk5LRGRjNUFPOXFhYzVQa2QyTVVX?=
 =?utf-8?B?Uk1vTXE5MlRLUXhQdEo4WXNBaFowTGp0SWMxKzl4a2IzV3VYenhsNGhYd0hI?=
 =?utf-8?B?a3RObFcvWXZVUDlhUm1BT01vYTJnN2Q0Ymc1MWZXWkdJNm5qYlFBRTd4dDN2?=
 =?utf-8?B?aVA0bk1ZbTJIT0tKZUM3VUd0aUFiamdoWmNxMkRpL3VBZWJHQjJwWnY4aVhx?=
 =?utf-8?B?SnJFUkc4VUZ3S3RrUXBpNitJSE10ZGNuUTJtVEFZUHM3VDdqL1g4dktUTVNE?=
 =?utf-8?B?VWdSYlFRWmJIUThVazF0c1BKanZjNUptVXJ4MlZQdDN6YWRJb1IwbG9Wa1dN?=
 =?utf-8?B?Ynh4aktMZlMzeTh2cVNTQ0ZMOVVpMHNneEJNQ0dLTWwyMU9ZWEdVSW5IVWw0?=
 =?utf-8?B?N01mdFBBelRINXZ0bW8zWTR3TXNwOGdGNnNxUkh2Q1E4QXUrZThjMlZqVFNw?=
 =?utf-8?Q?RdQab5Rodu5ea3AABG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e23ca1-a87a-4ac8-af2e-08de84133a2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:52:05.1731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKf3q4R1w5NSDLPKfg90wuktSKs9HdATwjdc8JE1rmIaP6Mj1LtlvZv+nmRh9GHW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

On 3/17/26 09:59, Khatri, Sunil wrote:
> It would be good if we add some explanation of why we used DMA_RESV_USAGE_BOOKKEEP for buffer copy and for fill we use DMA_RESV_USAGE_KERNEL.
> Either as a comment or in commit message would help new folks to get a hold on it. Other than that its a good catch.
> 
> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
> 
> 
> For my understanding:
> A copy buffer could involve buffer move to different domains too and might need to depend on all fences including read/write and internal kernel fences. At the same time buffer fill only
> writes to the memory and only depend on kernel implicit sync fences ?

No, the patch is actually buggy like hell. Both copy and fill should wait for all fences.

I only added this patch as a hack to work around MES problems and will probably drop it again when those are fixed.

Regards,
Christian.

> 
> Regards
> Sunil Khatri 
> 
> On 11-03-2026 12:43 am, Christian König wrote:
>> That's not even remotely correct, but should unblock testing for now.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 714fd8d12ca5..69f52a078022 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2428,12 +2428,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>>  				  struct amdgpu_ttm_buffer_entity *entity,
>>  				  unsigned int num_dw,
>>  				  struct dma_resv *resv,
>> +				  enum dma_resv_usage usage,
>>  				  bool vm_needs_flush,
>>  				  struct amdgpu_job **job,
>>  				  u64 k_job_id)
>>  {
>>  	enum amdgpu_ib_pool_type pool = AMDGPU_IB_POOL_DELAYED;
>>  	int r;
>> +
>>  	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
>>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>>  				     num_dw * 4, pool, job, k_job_id);
>> @@ -2449,8 +2451,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>>  	if (!resv)
>>  		return 0;
>>  
>> -	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv,
>> -						   DMA_RESV_USAGE_BOOKKEEP);
>> +	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv, usage);
>>  }
>>  
>>  int amdgpu_copy_buffer(struct amdgpu_device *adev,
>> @@ -2479,9 +2480,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>>  	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
>>  	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>>  	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
>> -	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
>> -				   resv, vm_needs_flush, &job,
>> -				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
>> +	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
>> +				   DMA_RESV_USAGE_BOOKKEEP, vm_needs_flush,
>> +				   &job, AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
>>  	if (r)
>>  		goto error_free;
>>  
>> @@ -2524,6 +2525,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>>  	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>>  	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
>>  	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
>> +				   DMA_RESV_USAGE_KERNEL,
>>  				   vm_needs_flush, &job, k_job_id);
>>  	if (r)
>>  		return r;


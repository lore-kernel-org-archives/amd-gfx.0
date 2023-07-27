Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8419C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 11:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB04810E11E;
	Thu, 27 Jul 2023 11:24:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E729110E56E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 11:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQEHZ0A9YOhEwCrLUmXJpcflENiwCY/MDTblefJ91YN6pZwZ4QjBfpd5Jt6D+ttOYIAKoN1rgVaQC+mFrBGT1gkxT9RIKXr1acWTdiu2Z+eeVxA08IHRNQOcCwOJJNb3SrMqeO65TovsyQMjPht6q7X8PPLJlL3zXzMEiDkR0DffZxko+WboCoOb0qYbpg3wjKd3obKfUMtxM8c+Ey3dQ3b9FvIPNAJ0fwVR2NZc1L9ePFaE9odpnzwlwSeleI0WEwgtec8RdhOwCg/Nha6cbyEm0fcGSppJ9LKGpu1xkZCzHmhie6mx7LpckeERec3aT0Raec9bUOMTz6vVvC6s6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci/c2zmgSMI0QYBkSrKdxHkNL6tdqdt0WaiiCWsQvlw=;
 b=hD8XX5NPIDCpZGbBaFti3vCjoOQfO1/ALsC2goIE4+xdgLYchWxYA1+ZlffmCEbaLlMhU7oQHjZ5UWKOZubPUhxu2uZr15SfR362QON91WXPXFffXNV01VPwU1HEvcjfthszSqNxkXISjGd6U8Yxr06woG456CbmY+U4/pk872KjsQpee2UYfZX9MvLv9fxph+Qrt/P1f4U0fGSHzM/eIdVjvUVvcSOWuL9Ldp/+f6RNiJkMCZTZuFGzB4WnL3wKXiHzwtEvKseI8cakbXsWv652OVHFCa+c6pjHXYam10hoGMExAUSIwHvlep3cuxgRFto42lsmNeLPl1tVIN/E+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci/c2zmgSMI0QYBkSrKdxHkNL6tdqdt0WaiiCWsQvlw=;
 b=lQrHUYtPfXHLBiRL077HiGe56nn9kV2IYPajo1ywxLx0M7XxfZw1G+o6w07d7xFEOM1qXrI0Yi+eSGWIo5eQEloVJUG8sBQCVmf2DsIo1et16/J9FMYHfAx6HmZ91I+PNCW9HWX7NxcXPSh7CRc+zax4TnMoBJlTg1bsMOa2k/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:24:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:24:07 +0000
Message-ID: <87302ce6-cb75-bc7a-72cc-d4f08c04258c@amd.com>
Date: Thu, 27 Jul 2023 13:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20230727075620.728235-1-Lang.Yu@amd.com>
 <329490e4-22d5-043c-e57d-12b029053e15@amd.com>
 <ZMInle4+cxmmiR1h@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ZMInle4+cxmmiR1h@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d7db83-6f5e-46e2-b5d6-08db8e93fdde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEg+JtUJU41JBbZLpq8XnjJa+jIpHrFdISXrcwtRt7UfqiZxflSzxo2p2GZ1OnBSERDhFb3FnRHqJ6h34/quzgBlw51YOGHSu3/Yjc5DKJDQ23ksfjscBnzROLEr60A+x0ELPEcv4dDMtJ5HZFqrD0UWF3whzrLzWv0/rkdoiZP5KZW/AjoEVHk5Dkbwz3xt9Ebkd02sNetLM74wnR5aX98o3Kzu+BJR2qRX8WFDcxMwKLlSq4UmvQNwzmWrM1LdRqFIk6NdvH3RP1LqdXJFoHQMYduraUACL9DssV3RhCZDrbVqOS5VukojFP9Cw7PXO8uLouTru7FPg51WfuVm6+fhs1cR2ODtaQnUCzfefm2PJ4tZJmLNCYr7sxTSqujaPU5GzUyTxsRAeP2WzQLBhBPux1inzXu9lTl4tMNBcmHdlfBn2RSO/bWphuWOg278Qk+bIp74lTYJQurpdTbItD2k22rsJDZJucFEGhi0Z00DrkksGcxIsH70oJmEsGrfX8D9o9hdy3rkXUbWgrE97X6qWtFf/fWhPVAxtLjAi0vZNB+JS74TEVvW0Xf4MVy6xvnqqGWs0r+SnX8S9o8KXvUYf+opaptTXRF0JMjteAdJJR20UOO+agi5UU5Tah8UNXNXjk3g8devWpEKtDJVyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(41300700001)(66574015)(478600001)(38100700002)(6512007)(86362001)(36756003)(4326008)(6862004)(8936002)(8676002)(6636002)(31696002)(316002)(31686004)(186003)(66476007)(66946007)(66556008)(6506007)(5660300002)(37006003)(2906002)(2616005)(83380400001)(54906003)(6486002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTc0YmZUR0h2M2wwV2tzd0RHZGZzRzFKQ2c3NVZUVm9hWVhlMHVXWjF6SDJu?=
 =?utf-8?B?b2dJMVVIbkE0bnB0WTFrckdia3l4aHY2d1JtWEJib3d5bDJYN0ZZVGRSVlU0?=
 =?utf-8?B?VlBzN2VTbXV4TG5RcENueFh0ZkxMSEFKM2Uyd2ZpOEMxakIrRmhhd0V1eFhh?=
 =?utf-8?B?ZUE2Y0VyR3h4cFc1RzNYMVU3ZnkvQ3NIVGJjUDllMUgzeEpQVzQxSHdXQy95?=
 =?utf-8?B?bGVUMzlXWnBQL0EvWCsvWXU4dWI1bmJEaUEwNVpSVDN6dmVOb2pjU0FPbEJk?=
 =?utf-8?B?QjRMaGNOZy9nbkRyQVVpYWR2WmlyWSsyZFFuTG5ZUWRMVFdNRm1kTmMvSWJD?=
 =?utf-8?B?cGhRWUVXYjM3VFh0Z1JQY1ZFYlZHNTNib1NNVzZBam9jRmZzb2NKZXhxdXJF?=
 =?utf-8?B?MjE5R3MrSUYzUkNmRC8vMFZHbXdXSFR2YXEyK3l2bHErLzA2OTNLSmk5WFpR?=
 =?utf-8?B?WGIveHgrcUVNdURZazlIeDlOTVdKcERNSEM5amJLbDNJNTM5S1U5RkQ1Y1Nt?=
 =?utf-8?B?eG5CTzVEYi9DanZqai9BZ1h4NnZYSHFKdGtxM0lMN29iQUV5Wmhwd2xpc1Fp?=
 =?utf-8?B?MlFYalZVMyt6NHo4OUtsYkwzQWQxMTM4UzNBN1ZIcFRjdG1LZDR2by9vTFBK?=
 =?utf-8?B?ODRnTDcxYUVXSGtaUVVxQkhvZFM4L0hEc082eFl3SDBIN2VDZ3luSjBaWHJh?=
 =?utf-8?B?S0JBNEhSdktYZTRxSkpwc2krTU9FVzNjby9ZbVdaOU1ndHd6K1ZDS1dpQmRH?=
 =?utf-8?B?eURYd0xjeC9iT3pUVVl6ZmQ5bDdsRGVacDliV3ZjT2NaUlBWeE5MSEltQ2ND?=
 =?utf-8?B?RUhHWnNmNERCazNqWTFVUnRQQWtHdGxmT3dBd3NYQzdYWlZhTy90TW5ZcStl?=
 =?utf-8?B?K2ZDT0ZlNitiNmpWNDFlVTI3ZUJvTXZLMHQrMnR0TlRPK1lHSDVURXU4K3pY?=
 =?utf-8?B?SW9HWUtHS3NtVVpibHkzeXcvNEMzZ0kybzdaaVFvQWphdE1keUxCd2J4UzRj?=
 =?utf-8?B?Mzk2akhXUUJqU3Rxak9wUW91WHF6UWxUVWJZUnppMHJYOHEwWlFwa29wNFUx?=
 =?utf-8?B?eUhVTXJMZDkyZWU2UmJYZjhySGU5MlpWNGZqNHZFdHBCbDZMUHY2NXFuTW9K?=
 =?utf-8?B?a3pJd21odWp2VEs0SGpxUXVubnBLMVpIdXVjcktzR21kamNOenRsbktmdDIy?=
 =?utf-8?B?dSsrcFFkYzllQUNONE0rUTFXQitReTByd0VvWGRQWGs3akRFZzFwT25iN0t1?=
 =?utf-8?B?YUpGS1IwdldXc1YrNUZVbjVHZTNPZG1hcU80RDNocHB2SWZiZG1PSkU1K2Rn?=
 =?utf-8?B?Q1BHYXNrd09iQU9jbEZSMGdNdk51Z3B1TmxaQVlSRDhDc2NUcDNwYnhlZ2Fm?=
 =?utf-8?B?SzdZUFBma04vSUJ4UW5xWHNqT1YwL3llMFUrSnFCcHdWZzdOSUxkc3BHcSs2?=
 =?utf-8?B?VWpqY1hhRXk2bGxSdUcvN1RGeXZpS2VpVnJ6SjRKN2FrK29KM0ZjbVBPVk9H?=
 =?utf-8?B?VkJRbE4vUWFUM01wMis3VE5UbzQxTEV2T0xFdllmYkNmRlMrK054MHpqM0V3?=
 =?utf-8?B?WW93K1VtV2YzcEoxOEhReS9KODBtK2Y5RjZjcW5OVVBVTHVmSWUwTnJpa0hI?=
 =?utf-8?B?dGJKSlhETUNzNkxzYXB6R3lGczJCK0ZiOFM2ck92akdPVjdtN3ZzRGp5YUZF?=
 =?utf-8?B?S0Z2NnhlRnYxbTJzY2MwWUY0VTlCQzhDRnVzTVJYZDQ3VzB5MUV1Tittakg1?=
 =?utf-8?B?bk5YVWNwaVZEZ1hpVFZ5MzgxaHJvNVB2WkRiYWtEWjZsdkh6NW9SQXpOMk95?=
 =?utf-8?B?czZ4OHhjZjJhTXZSTVI3WnlsbmM0K2xPVVYzMS9naFlBQm1COStNbmZJR0Nm?=
 =?utf-8?B?SDF0b2J3WTBGaHlZbkIxMEkwelRNejZVSUIyNVB3MHJxZGFDZjJGVEZPdm9K?=
 =?utf-8?B?T0xkdk9MRGw4ZGhvL1VsbG93dWZ1R1d1bXFjSk5TRFhUQ0RiMzFHaVVCSUxm?=
 =?utf-8?B?UXZCRWpUMjdMcTVLeG0xMHpHTEhUMkwyNVAydXBMS1FNZGNUWWVEZms3WEJV?=
 =?utf-8?B?MzhrRkJydHREMFMrOCtNeFJVbDFLSFZLSVlVc0JiUnpBSmxOd3RnbDBwUjZY?=
 =?utf-8?B?QTJXRHBaZ3piMGVxZUpKcjJEREpkNksxaWlraXRxVmduaWdpckpxY01ERGNQ?=
 =?utf-8?Q?0f86brvzwFMysf7Djf0vqINJQxg11eTG2Ty9JBkm9c8i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d7db83-6f5e-46e2-b5d6-08db8e93fdde
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:24:07.5226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNDsglsAh8W7mpo0ikQGcBa1v6kz+DH3tRJfbgtePAmOqtS3DOQJ8xf0q9uPC5bh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.07.23 um 10:15 schrieb Lang Yu:
> On 07/27/ , Christian König wrote:
>> Am 27.07.23 um 09:56 schrieb Lang Yu:
>>> amdgpu_bo_create_kernel_at() is used to create a physical
>>> contiguous VRAM BO at the specific offset. It calls
>>> amdgpu_bo_create_reserved() to create a VRAM BO first,
>>> then frees its old memory and allocates new memory at
>>> the specific offset. But amdgpu_bo_create_reserved() would
>>> fail if requested VRAM BO size is too large(>128MB) on
>>> APU which usually has a small default VRAM size(512MB).
>>>
>>> That is because VRAM fragmentation and DRM_BUDDY_RANGE_ALLOCATION
>>> is not natively supported by amdgpu_bo_create().
>>>
>>> The approach is using amdgpu_bo_create_reserved() to
>>> create a BO in CPU domain first, it will always succeed.
>>> Then use amdgpu_bo_pin_restricted() to move the BO to
>>> requested domain and location.
>> That won't work like that.
>>
>> The amdgpu_bo_create_kernel_at() function is used to take over specific
>> memory areas from the BIOS and *not* to create a large VRAM BO.
>   
>    Literally, it is creating a VRAM BO.

No, it doesn't.

amdgpu_bo_create_kernel_at() creates a BO for a predefined offset in VRAM.

E.g. the BIOS says to us you can find the table at offsets 0x12345678000 
in VRAM and during driver load we create a buffer object for this so 
that we can map or copy it away.

>
>> Allocating the initial dummy in the CPU domain is a good idea to avoid
>> overlap, but you are messing this up quite a bit here and will probably
>> break tons of stuff.
>    I don't see it breaks something.amdgpu_bo_create() doesn't support
>    DRM_BUDDY_RANGE_ALLOCATION. Actually it works, this approach is just using
>    DRM_BUDDY_RANGE_ALLOCATION to satify such allocation request.

The big difference between amdgpu_bo_create_kernel_at() and 
amdgpu_bo_create_kernel() is that the allocated VRAM is not initialized 
to zero.

E.g. we keep the original content the BIOS has placed there for us. With 
your modifications that content would be overwritten.

Regards,
Christian.

>
>    Reagrds,
>    Lang
>    
>> Regards,
>> Christian.
>>
>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++--------------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
>>>    4 files changed, 21 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index ff73cc11d47e..331daa47a444 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -358,6 +358,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>>>     * @offset: offset of the BO
>>>     * @size: size of the BO
>>>     * @bo_ptr:  used to initialize BOs in structures
>>> + * @gpu_addr: GPU addr of the pinned BO
>>>     * @cpu_addr: optional CPU address mapping
>>>     *
>>>     * Creates a kernel BO at a specific offset in VRAM.
>>> @@ -367,42 +368,33 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>>>     */
>>>    int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>>    			       uint64_t offset, uint64_t size,
>>> -			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
>>> +			       struct amdgpu_bo **bo_ptr,
>>> +			       u64 *gpu_addr, void **cpu_addr)
>>>    {
>>> -	struct ttm_operation_ctx ctx = { false, false };
>>> -	unsigned int i;
>>>    	int r;
>>>    	offset &= PAGE_MASK;
>>>    	size = ALIGN(size, PAGE_SIZE);
>>>    	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
>>> -				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
>>> -				      cpu_addr);
>>> +				      AMDGPU_GEM_DOMAIN_CPU,
>>> +				      bo_ptr, NULL, cpu_addr);
>>>    	if (r)
>>>    		return r;
>>>    	if ((*bo_ptr) == NULL)
>>>    		return 0;
>>> -	/*
>>> -	 * Remove the original mem node and create a new one at the request
>>> -	 * position.
>>> -	 */
>>> -	if (cpu_addr)
>>> -		amdgpu_bo_kunmap(*bo_ptr);
>>> -
>>> -	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
>>> +	amdgpu_bo_unpin(*bo_ptr);
>>> -	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
>>> -		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
>>> -		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
>>> -	}
>>> -	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
>>> -			     &(*bo_ptr)->tbo.resource, &ctx);
>>> +	r = amdgpu_bo_pin_restricted(*bo_ptr, AMDGPU_GEM_DOMAIN_VRAM,
>>> +				     offset, offset + size);
>>>    	if (r)
>>>    		goto error;
>>> +	if (gpu_addr)
>>> +		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
>>> +
>>>    	if (cpu_addr) {
>>>    		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
>>>    		if (r)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index 5d3440d719e4..8f5b5664a1b6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -315,7 +315,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>>>    			    u64 *gpu_addr, void **cpu_addr);
>>>    int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>>    			       uint64_t offset, uint64_t size,
>>> -			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
>>> +			       struct amdgpu_bo **bo_ptr,
>>> +			       u64 *gpu_addr, void **cpu_addr);
>>>    int amdgpu_bo_create_user(struct amdgpu_device *adev,
>>>    			  struct amdgpu_bo_param *bp,
>>>    			  struct amdgpu_bo_user **ubo_ptr);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 7c6dd3de1867..a210c243dac0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1619,7 +1619,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>>    					  adev->mman.fw_vram_usage_start_offset,
>>>    					  adev->mman.fw_vram_usage_size,
>>>    					  &adev->mman.fw_vram_usage_reserved_bo,
>>> -					  &adev->mman.fw_vram_usage_va);
>>> +					  NULL, &adev->mman.fw_vram_usage_va);
>>>    }
>>>    /**
>>> @@ -1644,7 +1644,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>>>    					  adev->mman.drv_vram_usage_start_offset,
>>>    					  adev->mman.drv_vram_usage_size,
>>>    					  &adev->mman.drv_vram_usage_reserved_bo,
>>> -					  &adev->mman.drv_vram_usage_va);
>>> +					  NULL, &adev->mman.drv_vram_usage_va);
>>>    }
>>>    /*
>>> @@ -1729,8 +1729,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>>>    		ret = amdgpu_bo_create_kernel_at(adev,
>>>    						 ctx->c2p_train_data_offset,
>>>    						 ctx->train_data_size,
>>> -						 &ctx->c2p_bo,
>>> -						 NULL);
>>> +						 &ctx->c2p_bo, NULL, NULL);
>>>    		if (ret) {
>>>    			DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
>>>    			amdgpu_ttm_training_reserve_vram_fini(adev);
>>> @@ -1742,7 +1741,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>>>    	if (!adev->gmc.is_app_apu) {
>>>    		ret = amdgpu_bo_create_kernel_at(
>>>    			adev, adev->gmc.real_vram_size - reserve_size,
>>> -			reserve_size, &adev->mman.fw_reserved_memory, NULL);
>>> +			reserve_size, &adev->mman.fw_reserved_memory, NULL, NULL);
>>>    		if (ret) {
>>>    			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
>>>    			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
>>> @@ -1885,14 +1884,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>    		r = amdgpu_bo_create_kernel_at(adev, 0,
>>>    					       adev->mman.stolen_vga_size,
>>>    					       &adev->mman.stolen_vga_memory,
>>> -					       NULL);
>>> +					       NULL, NULL);
>>>    		if (r)
>>>    			return r;
>>>    		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
>>>    					       adev->mman.stolen_extended_size,
>>>    					       &adev->mman.stolen_extended_memory,
>>> -					       NULL);
>>> +					       NULL, NULL);
>>>    		if (r)
>>>    			return r;
>>> @@ -1901,7 +1900,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>    					       adev->mman.stolen_reserved_offset,
>>>    					       adev->mman.stolen_reserved_size,
>>>    					       &adev->mman.stolen_reserved_memory,
>>> -					       NULL);
>>> +					       NULL, NULL);
>>>    		if (r)
>>>    			return r;
>>>    	} else {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> index 41aa853a07d2..b93b42b916ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> @@ -397,7 +397,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>>>    		 */
>>>    		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
>>>    					       AMDGPU_GPU_PAGE_SIZE,
>>> -					       &bo, NULL))
>>> +					       &bo, NULL, NULL))
>>>    			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
>>>    		data->bps_bo[i] = bo;


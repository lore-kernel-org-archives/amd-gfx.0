Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376CFC77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 02:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23E910E27A;
	Thu, 27 Apr 2023 02:21:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AEA10E24F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 02:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkwUED1iwluiiEuQULsfuXBymO8GvSzEt8VBkcOacdrMe8Z59XZJtp/JMH1wVSAP0etPeY/EYL/4zG12c7ryyfaGBqW+6nNusUZWdbqoZ9B7QoH3IJt1WGumIXKn/fDK2lHHM7RTdO7z/uwh8gHSZHYqI0C+lEJDimTMyQfZ9dIVP0qGRC7s3A+0IydfKG7q3QLEKBimO5dZWJrvhFKFFwdAUNncRK5LNzfpa50NeumVcSd23wuaNLRf/8/nHPfsu+Fxw3llyuknzI3Or8VQIM1tD9W2NDgHgmdMlUMvZ87rdqThRVYXfgElux035WcxET5n3RNJxN+X0Gz/4iDncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNjUzpJ9IUhj9iNd92oNEzb6FzKGLSyEw9vT3sUNgTo=;
 b=bplMC2lkfocFgX0qCHAMKhwWD29LIOxcdN1uGmTz/Ttc5dbGpAxlDjODJSt5VPSuExHBjH652ZhEQilPcP2WZ9RfoFp0SyCFi94GWXBEUIQugFFM4lx2YGsYJjmer+sDb0vyCrIItNAMGWBDn3U/4+gBYjm5XVQ3l9tPmhKnc6u2+JDL/CxWUmqL3XJR8P6lKmUBqYn7c+YbcOdquXNUl0a0y6q9pQjN/o/qNHuGe0CsgO6uMzNo5WggU2qulTWxU+4V7aC4eBwmYIGSKjEAr9Jt2eWi4raDM8nkN/NCLzlKMXNGrVWH+jDUE0p6d6B3Hdv5BWQTJGmLPQbp/txryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNjUzpJ9IUhj9iNd92oNEzb6FzKGLSyEw9vT3sUNgTo=;
 b=Zzm3OaAjKQeYGBSdM301F478JQo+kGYjkFMBglWcz9QZ5ji6oBgqgdW6WrjMeeuAGLtzvKRrviN5yqE+6BMrdRtq4Q/mXOgBcWgNAdExInUIEYdSWaYJwQk3hiSWB/5ehKzJeuv8Ub7BksrJ1vm62m3UYSmZcCnvXsTiJWbIe7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 02:21:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 02:21:17 +0000
Content-Type: multipart/mixed; boundary="------------nD8Z8E44oFDYJ63SIVGa34VA"
Message-ID: <008e334c-d62a-bca7-6465-3cccea7f0c17@amd.com>
Date: Wed, 26 Apr 2023 21:21:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
 <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
 <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
 <8b8d22bd-0eff-2f81-9267-07c4c4d058d1@amd.com>
 <04b2fcfc-90d8-5398-9ccf-58dfd178d73b@amd.com>
 <19238e6c-86db-6a00-ea83-e69b7384eeba@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <19238e6c-86db-6a00-ea83-e69b7384eeba@amd.com>
X-ClientProxiedBy: CH0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:610:cc::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: e57dc57c-5950-4c5a-51b6-08db46c614ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRzs2PEBPwtcO3Zjz2HyNIk+MSw/HM+E5q6rT6hKQO1XZArfx3uNbBzR2vdkd06FbiB8z+bedo2EczzIs+r3vAOHMw9wckNVrNZoY08TP33Z2ApoV03F8UXOqQnUOLCcpD6PAYBikWiI3/a4SK1WhANvnfKONTZPn0imxNCdKFtbKRSvy8zQNIOaLUYvJkXVHN3W2XHB5zzAOk9jQ12TFn9KQ0BKtYRBSBqz9IBVSJhLF9KAeB+5H6rxPZZtjxhfSCpH3whOxK/Cm7h3HCllggZjMfZcRoGrTNLy6dGiXdGvhmU7Du3rRnUl6JAn2jM58I1tK5vH+rQKPMSXTmIVYG+ucnfLll157Ic4fGvE8if1xRDKLRp8FivfVt2fm438ki3OyOPzM04hHOhD/kse0lVj/s9cQ2SlFCchR+jZjLhun/0DgeFC74ZhedaN5+ZJe1n3bRfBS/U3j7pgGiA41Tss7FjknV822UH5yLt2/AsjuBkH9UMKg+OD4V6x+KR2BaCJ1nyUTtAu1AL2nRuuONUcPXjrCiiI119KatS/dsIgZVFImRVCynHe1ych1qEZo59eE8VNIWtToVSrqDzWyka3y+8wVwmvAKuT31WscXt1XWJ8nyipJfJcN2oH51qRnWbns1EctsayUMklwRSYrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(478600001)(110136005)(2616005)(83380400001)(6506007)(6512007)(33964004)(66574015)(6486002)(26005)(6666004)(66556008)(316002)(66476007)(41300700001)(53546011)(186003)(31686004)(38100700002)(235185007)(5660300002)(36756003)(66946007)(44832011)(2906002)(86362001)(31696002)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9NTlZhS0tCV0w3eDVHbFNlZGxCL1Y0NkliUlJzWHNTR3pjYVZ1SXBwOGpy?=
 =?utf-8?B?Tk5rMDVwL3dpLytaWURESU0wUXRZQWR4QkxQQTFlUytmMnJuMDNxNHhieS9j?=
 =?utf-8?B?UVRUVGx5MSs0b3dRcWF1RGJnbGVxcElpU2JHM01Sb2djZGNUZ1JSOFhOWFpW?=
 =?utf-8?B?TjdlSWxQYTNPcmExeUltWElzWm8yS0dkR2xXUzV1RUFQaUR6aThjcGxHVzJO?=
 =?utf-8?B?MGEyTCtCeE1pV3U3aTN6cEVqY3Y5MEkyd1g5cGdnYkVoZDV5ZUxRWnZJbU9N?=
 =?utf-8?B?cDVxV29kNSttS2I1R1c5WnNITTV2UjVYdXNRMmwrRVpQSVNLZThyRVYyWDhE?=
 =?utf-8?B?aktsbFFTMGs4aTNMQWtOaVdWeVEycDA1UmlDZmNVVURjalV5SldmemlHUWVq?=
 =?utf-8?B?aG5KeDNld2xQZ1Zhd3hyUTR2TGtOUU9GWHJzSDZXYlNxdktpc3lJV1VYU0Q4?=
 =?utf-8?B?YUxwSEJnTDUyc29QcTJ3THlmN0xYVWZlbnhoMys1OEp0bnpHYXNaY1JkRGtn?=
 =?utf-8?B?VUd1ck00d29jREpEWkhKbXhzOGkwVzJSYTBSUGcvQ284bmFzSWVwdlhJUWFy?=
 =?utf-8?B?MUM5UnRiNjVMODhPYlZTanMrQjBIVVVObnBZa1J5T2ZvWFMvYndTaFJVSEtL?=
 =?utf-8?B?VjRiSkJlVUxyMUhqR2JVdGs1eHdWb0grcnBsY08yL2IxS2Nyc0dZQWQ4L1Jo?=
 =?utf-8?B?dU5QTWZZaS9KOE1zT0pZMHUvQkVaY3BDS1RXMkZvN3A5VHBpb2tkSm1uUGNy?=
 =?utf-8?B?THBZLzRoK3FPUC90TWRVdk01V3E5NStod0NVMVNFZitaRGFqekZpUmVETHlE?=
 =?utf-8?B?aUVqYm1ObDRSVTJtMkh4Z1dvODdZSVJGdmpmSkVEOUltVytSdGdxZ1VBK2Fr?=
 =?utf-8?B?UjdFWEozd0loZURUUXlPaXNJUE95RlRiU09pZDJCemx2M2xoTFVYaEdsc2FD?=
 =?utf-8?B?bGQzZmlvUGRyZk1QOFhqNnFaOGtyK2lSSzJSekJFSk95Z2tFcFhwWE5NbUM1?=
 =?utf-8?B?MzF6U1pFMU1NV2JmV0MyN2tLTlBGdis1NlVOaWFVOEhtdmVCZEt3SmRIeHNQ?=
 =?utf-8?B?dTM3anFyT1NLQmxqZDhRdEZCMXU3WFF2VkNWNEdtSnR5Q295bDZFSFlpaTRS?=
 =?utf-8?B?cmhuT2VBM2FMdUVVcmhja2JNejc3K3F0cjEyb1NSZDN1RTByS1BmQnJxZHRL?=
 =?utf-8?B?UjVFc0xwcFZCL1JJaXVVMWdxN2NZbnFRb25CcnlYdzFMRU5RbGhLZkdnWUw0?=
 =?utf-8?B?U1VNV2RoMm9vcmFtUTVzRUF4UEV6Ym1EZTJCVy9xU0tDUVVpNFlhc05FVFFu?=
 =?utf-8?B?V1hUQzNrYVk3REpJZytxcjl4Y3FhTDkvbE10OUVUdlVuaS96YU13VUVwMy93?=
 =?utf-8?B?YWJ6cEdCR0lNYlo3a3VCa09vV3NXTzduaUZGbXpWS2dJYmtCVS9UQTlhSGkx?=
 =?utf-8?B?Ujh6bmdOUjNqMVl5K0ExZzF3K0hoNGlTdE1jNVkrQnlpWTZCMjJKM2k5MnY5?=
 =?utf-8?B?cDBHUzNUMTN3Nm1JVWozVVBxMXNsS3F2STlpd05OY3JHSHgrdC96UXg0MWc4?=
 =?utf-8?B?R2pmMnkrSzF5UWNQeitSQS96NTN5czEwOWl6Z21ibVJpdUMvZTVjelFUMlJu?=
 =?utf-8?B?aVh3amR6SWFxMFR1VXB0dlpCSXpFZEVTbVdEV29vRGNHWlpjU0srT0txU3py?=
 =?utf-8?B?bEttMFVZd0ppKzBMSHFPbmNCeit4elNlUnQvTHo2TTloQUNGdnJiOG42cTZ4?=
 =?utf-8?B?ZG82NFpIeXRMN2NhS1VLU1YxdkFPd0gwQkRGSTJ5clNqRkdvdFdtOHNsZUdE?=
 =?utf-8?B?eDNtTkI5K1AxbXlxaDZ6NlhSQWZnVnZJcWVzekNFMVpsQ21uV0U0bEJaUW5s?=
 =?utf-8?B?YzJNRHNkU3VHaWJpeFFCaEFRQ0dpUFhDb2ZKeC9Hb25udSsxYVB6VDFReGp3?=
 =?utf-8?B?Q3hPUWtRdUNOVUlDRmp5d3BMUWZTclliUzR1NVpQaDE2RzluVjY2eW04V09k?=
 =?utf-8?B?cUR5OWNtQkpodStabFFxd05GeUZMV2NqZTNKWHZHVGI1TzZuenlnVjR2M3lE?=
 =?utf-8?B?MjRXaGFMUmlYbi9LWXZqOWRKbWZIRGhRUU44NzI5VjZFZ3JWWVhKYnJLaHpR?=
 =?utf-8?Q?b4kBZ6LtVfFkTHoRhMVA4qWel?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57dc57c-5950-4c5a-51b6-08db46c614ed
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 02:21:17.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcBSmOy6PoTskS+y5IHeb3nYZpd0myFH6Ma04TwRw4W0qyvC7iLRt6EetuduqOTvohg+rHTCJjwyFQCo/yc4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

--------------nD8Z8E44oFDYJ63SIVGa34VA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric,

Can you try if the attached patch fixes the problem without breaking the 
eviction tests on a multi-GPU PCIe P2P system?

Thanks,
   Felix


On 2023-04-26 13:02, Christian König wrote:
> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>
>> On 2023-04-26 9:03, Christian König wrote:
>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>> Hi Christian,
>>>>
>>>> What do you think about Felix's explanation?
>>>
>>> That's unfortunately not something we can do here.
>>>
>>>>
>>>> Regards,
>>>> Eric
>>>>
>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import
>>>>>>>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>>>>>>>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>
>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>
>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>
>>>>>>> I'd like to get an Acked-by from Christian as well before 
>>>>>>> submitting this.
>>>>>>
>>>>>> I have to admit that I only partially followed the internal 
>>>>>> discussion, but in general you need a *really* good explanation 
>>>>>> for this.
>>>>>>
>>>>>> E.g. add code comment and explain in the commit message 
>>>>>> extensively why this is needed and why there are no alternatives.
>>>>>
>>>>> OK. I'll give it a shot:
>>>>>
>>>>>    This code path is used among other things when invalidating DMABuf
>>>>>    imports. These imports share a reservation object with the 
>>>>> exported
>>>>>    BO. Waiting on all the fences in this reservation will trigger KFD
>>>>>    eviction fences unnecessarily, for example when a DMABuf import 
>>>>> for
>>>>>    a DMA mapping on a secondary GPU is being unmapped explicitly. 
>>>>> Only
>>>>>    moving the original exported BO requires stopping KFD user mode
>>>>>    queues. If the invalidation is triggered through a move notifier
>>>>>    from the exported BO, then moving the original BO already 
>>>>> triggered
>>>>>    the eviction fence and we don't need to wait for it again on 
>>>>> the import.
>>>>>
>>>>>    We can identify DMABuf imports in KFD for secondary GPU DMA 
>>>>> mappings
>>>>>    by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>>    operation that ignores KFD eviction fences.
>>>>>
>>>>> How does this sound?
>>>
>>> To be honest like quite a bad idea. Why in the world are imported 
>>> BOs moved from GTT to SYSTEM in the first place?
>>
>> As I understand it, the way to update SG tables in  SG BOs (e.g. 
>> userptr and dmabuf imports) is to move them back and forth between 
>> system and GTT domains. If we left the import in the GTT domain all 
>> the time, we would have no way to update it, e.g. after an eviction. 
>> Currently the move to the system domain is done in the unmap code path.
>>
>> Before memory is freed, we also need to unmap it from GPUVM, 
>> including the DMABuf imports on remote GPUs. For the above reason 
>> that currently includes moving the import to the system domain. If we 
>> removed that from the unmap code path, we'd need to do the move to 
>> system somewhere else, maybe in the mapping/validation path.
>>
>>
>>>
>>> The only reason for this I can think of is that the DMA mappings 
>>> become invalid for some reasons and in this case waiting for the KFD 
>>> fence is actually the absolutely right thing to do.
>>
>> In this case the reason the only reason for unmapping the memory is 
>> that we're about to free the memory and its DMABuf imports on other 
>> GPUs. This is coming from the application with a promise "I'm no 
>> longer accessing the memory". We don't need to wait for fences here. 
>> We only need to invalidate the PTEs to make sure that any further 
>> buggy access by the application will fault.
>
> Well in this case just free the BO and it's bo_va structure. The core 
> handling should take care of clearing all the freed up regions.
>
> As for updating the SG of a BO you indeed need to move it from GTT to 
> SYSTEM and back, but in this case we should either indeed wait for the 
> KFD fence since page tables in between the operation still have the 
> old entries or we should destroy the BO and create a new one. The 
> later would overwrite the PTEs with invalid entries first and then 
> fill in new valid ones.
>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>   Felix
>>>>>>>
>>>>>>>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>>>>>>> +                        ctx->interruptible);
>>>>>>>> +        else
>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>           if (r)
>>>>>>>>               return r;
>>>>>>
>>>>
>>>
>
--------------nD8Z8E44oFDYJ63SIVGa34VA
Content-Type: text/plain; charset=UTF-8;
 name="0001-drm-amdkfd-Don-t-trigger-evictions-unmapping-dmabuf-.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amdkfd-Don-t-trigger-evictions-unmapping-dmabuf-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiNGEwY2RjMjAwMjc5NmRkN2MyOTQ2OTE1NDY3MGI2NTkwYjExNTVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4KRGF0ZTogV2VkLCAyNiBBcHIgMjAyMyAyMjowNzo0MyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRrZmQ6IERvbid0IHRyaWdnZXIgZXZpY3Rpb25zIHVubWFwcGluZyBkbWFidWYKIGF0
dGFjaG1lbnRzCgpEb24ndCBtb3ZlIERNQUJ1ZiBhdHRhY2htZW50cyBmb3IgUENJZSBQMlAgbWFw
cGluZ3MgdG8gdGhlIFNZU1RFTSBkb21haW4Kd2hlbiB1bm1hcHBpbmcuIFRoaXMgYXZvaWRzIHRy
aWdnZXJpbmcgZXZpY3Rpb24gZmVuY2VzIHVubmVjZXNzYXJpbHkuCkluc3RlYWQgZG8gdGhlIG1v
dmUgdG8gU1lTVEVNIGFuZCBiYWNrIHRvIEdUVCB3aGVuIG1hcHBpbmcgdGhlc2UKYXR0YWNobWVu
dHMgdG8gZW5zdXJlIHRoZSBTRyB0YWJsZSBnZXRzIHVwZGF0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBG
ZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAxNSArKysrKysrKysrLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwppbmRleCA4
NjJlOTRmYmY1M2MuLjYzODYxMDI5NjAyNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwpAQCAtNTI2LDYgKzUyNiwxMiBAQCBrZmRfbWVt
X2RtYW1hcF9kbWFidWYoc3RydWN0IGtmZF9tZW1fYXR0YWNobWVudCAqYXR0YWNobWVudCkKIHsK
IAlzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggY3R4ID0gey5pbnRlcnJ1cHRpYmxlID0gdHJ1ZX07
CiAJc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBhdHRhY2htZW50LT5ib192YS0+YmFzZS5ibzsKKwlp
bnQgcmV0OworCisJYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihibywgQU1ER1BVX0dF
TV9ET01BSU5fQ1BVKTsKKwlyZXQgPSB0dG1fYm9fdmFsaWRhdGUoJmJvLT50Ym8sICZiby0+cGxh
Y2VtZW50LCAmY3R4KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OwogCiAJYW1kZ3B1X2JvX3Bs
YWNlbWVudF9mcm9tX2RvbWFpbihibywgQU1ER1BVX0dFTV9ET01BSU5fR1RUKTsKIAlyZXR1cm4g
dHRtX2JvX3ZhbGlkYXRlKCZiby0+dGJvLCAmYm8tPnBsYWNlbWVudCwgJmN0eCk7CkBAIC02NTgs
MTEgKzY2NCwxMCBAQCBrZmRfbWVtX2RtYXVubWFwX3VzZXJwdHIoc3RydWN0IGtnZF9tZW0gKm1l
bSwKIHN0YXRpYyB2b2lkCiBrZmRfbWVtX2RtYXVubWFwX2RtYWJ1ZihzdHJ1Y3Qga2ZkX21lbV9h
dHRhY2htZW50ICphdHRhY2htZW50KQogewotCXN0cnVjdCB0dG1fb3BlcmF0aW9uX2N0eCBjdHgg
PSB7LmludGVycnVwdGlibGUgPSB0cnVlfTsKLQlzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IGF0dGFj
aG1lbnQtPmJvX3ZhLT5iYXNlLmJvOwotCi0JYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFp
bihibywgQU1ER1BVX0dFTV9ET01BSU5fQ1BVKTsKLQl0dG1fYm9fdmFsaWRhdGUoJmJvLT50Ym8s
ICZiby0+cGxhY2VtZW50LCAmY3R4KTsKKwkvKiBUaGlzIGlzIGEgbm8tb3AuIFdlIGRvbid0IHdh
bnQgdG8gdHJpZ2dlciBldmljdGlvbiBmZW5jZXMgd2hlbgorCSAqIHVubWFwcGluZyBETUFCdWZz
LiBUaGVyZWZvcmUgdGhlIGludmFsaWRhdGlvbiAobW92aW5nIHRvIHN5c3RlbQorCSAqIGRvbWFp
bikgaXMgZG9uZSBpbiBrZmRfbWVtX2RtYW1hcF9kbWFidWYuCisJICovCiB9CiAKIC8qKgotLSAK
Mi4zNC4xCgo=

--------------nD8Z8E44oFDYJ63SIVGa34VA--

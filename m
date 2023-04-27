Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3734EC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 19:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFBD10E0D4;
	Thu, 27 Apr 2023 19:58:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A6210E09F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 19:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqKMoo3lWZKX1sKFiMLKtIq3EtOEAW3Z8v16LYZxaP+NOYQD+vbfqa5MBZKtQTFyyO3yOAo39NkttNH0WvxuWVDRRJxMGG6FeY0Gb9KPL0wIpIn2PGkdPPGxK7mVcFY43OpFGdSC3LQp7CBDP/Kb01P2m61OhGQSkHomNbU8aWmDMIw+gzTdENiVh3hx1SbragiNKGbSqYO+6tFcgtiBAcChtP1J9mgFOqAnA+YlgBhP70VewMbV3T1UV6r+tSERj2EU83uqgu0rxkMvBqr3sh+WhJoFfeXTO8AtLgw5f67x1nPwM8GAkt7087eWDsDDJjS2iGkClFtcqI/ZRiwkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aqPCjsNecVpqgS6Eb0yNBGuubBlirGllyOd4ZyuaLU=;
 b=d6AMYFOgFMe4bWX/0JJ214Knm+p2lLkPFSZzrkzuHK0EmXEKVG0yK+TG0w4R3uqPquKv3tqJSD7hJJUQV+ozHogezZLop9OAvHoSMQ9JniD9oYho87WkPpjLoadRTsZJu6ZApGcZ1uLpbP2BVBU17G0GbnNLyn4GcvdbbQaGw3WKQP9AUPwExDpvJxxR87oylLeA1sD2/1CdgFiJFAUhvt1nwPrpLjaSAZjiB1YK7T6N4ZKSVMciG0DpDDlDKnHB9MkXRdrkEdA/9wuMiUIYVes2MPNYBQomLdkKWtB6MHh4ncAG4jmfXruztiepTWPNnzCx0kGGMdarxGXpTSvBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aqPCjsNecVpqgS6Eb0yNBGuubBlirGllyOd4ZyuaLU=;
 b=m8cvMNg+sUizL8H0Ai+/tk9glMd7uAiAqyEMqb0DkpKL8mq9GBlJsdnOVoXsQ0ZNz1qaUyOdPOTY3lbkH3165NA0et/guXGCNBCISZM3Iz2mgzkLGHnkyqcbLS8gQAeVmWgAXGr9u476Btbjtb4m2TdsgtLsiwAbF2/os7MMg58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 19:57:58 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 19:57:58 +0000
Message-ID: <56d9dd1c-2028-76ca-3f74-d37ad1733264@amd.com>
Date: Thu, 27 Apr 2023 15:57:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <008e334c-d62a-bca7-6465-3cccea7f0c17@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <008e334c-d62a-bca7-6465-3cccea7f0c17@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0414.namprd03.prod.outlook.com
 (2603:10b6:610:11b::32) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: ec21f93a-5d1e-4075-e63d-08db4759b2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjAh8lC6w/++xl7DkZMrMH0dzC7QvKUydoawa1kf1tzEyWMOBxaexl/hL5UQ8M9dSOFWg9h7hQa4JZ0FufSAoJMfH1ZoR+CW/VD6EWi5MdP/bq5O1ebEIKAf/N3M0/2DAx2Jk6uNpf8ImtPoxPrANZTpVLA946dZrb0XAaMOzanlwmdU5p+WbYopK2JGjpBl4QEfkl2KXnto+LVhiEG0aXL19Ob4swTfSWj5mbyWu4KwTLfDtYXAqatKroYAcil+s+PwTsHG2OsYHwNrupVDQNup3jwaDEq38DeFHhD64Jgn+Ug4X3Ubtyv/c8GW/ziwyso6W/6TJqJN9DwsTBJ3L5dVS1MefAnWJz6hgylkcXSP4UIbf3nZwtI5mzcysVsXfnFuBUg+ybxED22UsUeCzv5wbWd76WaaJJ+H+zWFspDdGmyyVD3LKZf5diQI1PWlLzYPw9OsFMrqCKfVYwiPRPezQJWcwLWCGFx9QtRW3uSBtnoKSU/xTaM9qz6MwN8RB+HPCe1pswjpm1QGnAShiCKtF2FX83uWNPDd12KZcom2I74WQBOOUqeSmV2jPBfmbBPMe84NRuVRF/uDqS2409JAu6uUn6NxSAoaCzGaEXkXnXEO+oBpBrdecTbK+qqO7jDAOiSBMiU3rfhQhsmoiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(8936002)(5660300002)(86362001)(8676002)(38100700002)(316002)(66946007)(31696002)(66556008)(41300700001)(2906002)(6666004)(36756003)(6486002)(2616005)(31686004)(6506007)(6512007)(53546011)(26005)(186003)(66574015)(110136005)(83380400001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzkzdFZyRVpTSCtQQnZRa0k2eGxCa2hyYU1MRHNrZ2tSaHAyNDFFODdSOTdm?=
 =?utf-8?B?dzF3THVEUG9HZFdRNjVaSlMwVjRjNzQ4RHZnV2t0L3RMclFydlM5M1IvSWM2?=
 =?utf-8?B?YmovZHd0ZWkyaDZhZm81RThzalNaV08zSWNDSlY3ZlVkUlpBZFo1VkNESnN0?=
 =?utf-8?B?NU1vYS9jRTd4ZGRaU091K1V6WWF4Q3Q3OWRLdFJWWGIyMEJSSGNyM2FXcnhi?=
 =?utf-8?B?Tm1LMEh6ODdVbmljNzFPelVnTTk5OHNML2xRSUV1WlViMEVrRDBNNXUzbEtB?=
 =?utf-8?B?QnRLck1PZllNWjA2cGlXU3J5YTNaVDUwa0YyQm1weTJwOUlrcW5GNlZFMlRH?=
 =?utf-8?B?aXJQQ3lrYmdselRuQTNJbkkrOUhWYkQxZEcrUUJHemFOMlF5YWhqb0dqN3Q5?=
 =?utf-8?B?Z3FqMEJnNkFzOGMxNDhTamU5V0FMNTc0NlplUVJ4bFppaS96MUV5QWQ0aml0?=
 =?utf-8?B?VUppRWEydXFCZmhzd2syOWdOZStwNXpYYVVDdkFlV2RTalozeE1FTTJkOXp4?=
 =?utf-8?B?ekk0d2xDTzV0QmlYOFBES1NtRFVuUWZVeUJ5Sk9wNnI1dkdiZ1RKQ29pV2R4?=
 =?utf-8?B?RjRlOHRtZk91OG40M0NTd1pNOStlYjBLdE44TUNaanAzUE9oOU9SUlRMeDdy?=
 =?utf-8?B?VGxPZ3IyU3dTNkY5UkhPOUFvN2NJSXV5VHd1eTd4Z2NYWUt1UUp3WFBzWGhx?=
 =?utf-8?B?cVlFaEhZVkMxQUFnQ25ydUw3eEw0cEZXcmVLbFZQTXQ4Tm5pM0FtdVNON2hz?=
 =?utf-8?B?amZaMzNkVHJOcUdlWVR3d0VtY0pMWGYwWGo3S2piRjFiTUI3ZlZYTjFvdTRY?=
 =?utf-8?B?bncvNjgwbkNkWEdyNW9OMCtORHMrSnBkUzBqdFVnVUtPVFlzOUx4ODMwQkxw?=
 =?utf-8?B?NHZ5NnhKSFNHYmZSVnhNc0h0aERvcW5lTng4cnI5c1pmcnFMUWxJZW1MYkRK?=
 =?utf-8?B?ZnJvTENIL29ORW5wTFpHZGZnSEsvUlY5SDJHdG92SmtNRmZWRElvNTZQKzJN?=
 =?utf-8?B?N2JoNWUrcU1BNWRGalVnQkUya2t3ckxWNjFMOEJKZFM1Qks2Q1BsR0hML0R2?=
 =?utf-8?B?bHRwY0hlaGJudUt0Rkd1eEJBd20wUlJhNGZ0Sm15bnFiaktEQkhqQTVqdnBM?=
 =?utf-8?B?RzRJYzJMNWFLSHF1eEoxeFR6ZEM0cmxaQWFGT09SME1OREdNZGh4bmFUWWpR?=
 =?utf-8?B?bUorbGxJVzNqNlYvcnFUK1h2SGR0c0Z3aXVlUUYxZzJJTVF6aWdydGs1bXR4?=
 =?utf-8?B?OUVMbG1JeEt5ZENZc2UwSlRJazVTMVpyQktkUjMvenJkcXRIakR0SSsrOWV6?=
 =?utf-8?B?Vm1uNlRXQ0M3RXFOMzhyTWRVN0pOZVhFWnlFNjJZWXNISkdSMnJzSUZiNG1o?=
 =?utf-8?B?NXdJSTg3N0NGYlRFVFdLSnV0d3U0VUFiK0pSYXBadXZCMkpON2RuVm1JUlNO?=
 =?utf-8?B?Q1JzRllrVzBKdkpScHVEdVBtRUZNTVQ1R3F3angySDJ1aGloSktRSmt5dERk?=
 =?utf-8?B?SW1QeU01QmZzZ3FJNlhkYVBhbWw0ZTRnMVFnQy9jSWlxcGc3M05waDlZb2dx?=
 =?utf-8?B?T1FwWXhGOFIvRU9JaWpLN093c0tjanB6cm5KeU4yMEtuZTFWdjFNZExKOEUw?=
 =?utf-8?B?dS92a0tmRTJ1b28zZGJESlo3bmREeExDMUkyTjJsTEc2TUhYWmI0OFNodFA2?=
 =?utf-8?B?NTBxNFYvd0VOR2Q1RWhNSGM0aGJHaFJiSHBzSXpJVUR4K0tBQUsxRFNJOVRM?=
 =?utf-8?B?MkJ2a0h0c3NTQjRXSVhHaTNDOGgrZTFJNEtSd2dmQzNzR0RzckFJeTYwVzhZ?=
 =?utf-8?B?Q2NheDZ2TDN6bndqbHl4c2JrSTJ6L0dPOGhuMVRxUTQvYklKV0xhZEl0clJl?=
 =?utf-8?B?OVF5L0tpaDRrVkFyQUNhWkRUQm03YkV3MHZ5eXhaN3NZUktYRmJtUCtSYUw0?=
 =?utf-8?B?WmhCd3hQSHQraE5sYUhMRENZQzBBQkd6MVFiZkZEdytzRnBYWDZtdFN0UnBD?=
 =?utf-8?B?ak16SllBU2FGNTJ5a29mdVEyczhRYUtTZW1PREZ2dFJYTS9TTUplLzhTVjNF?=
 =?utf-8?B?UGVpMGVjUUdHRHcvaHBlamZTRDVJSStLTzRiVFppTVBRT0pLWlJweTJtZk1B?=
 =?utf-8?Q?dt++iIv/iSGpPMol2UFougOoY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec21f93a-5d1e-4075-e63d-08db4759b2dd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:57:58.3291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1h9a/fb0SAHH6TxgjnIWffcbP8OA2xHp7NlEBW8ssFPZMgBCqJJ5MSXtpspqM3rshBtYowcNGEzF2gzcMUIWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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

Hi Felix,

I tested your patch on mGPU systems. It doesn't break any KFD eviction 
tests, because tests don't allocate DMABuf import, that doesn't trigger 
it's eviction fence. The only thing the patch affects is in re-mapping 
DMABuf imports that the eviction will still be triggered.

I have an idea that we probably can remove eviction fence for GTT bo, 
because currently the only way to trigger the eviction fence is by 
calling ttm_bo_validate for CPU domain in kfd_mem_dmaunmap_dmabuf. Do 
you know there is other case to trigger GTT bo's eviction?

Regards,
Eric

On 2023-04-26 22:21, Felix Kuehling wrote:
> Hi Eric,
>
> Can you try if the attached patch fixes the problem without breaking 
> the eviction tests on a multi-GPU PCIe P2P system?
>
> Thanks,
>   Felix
>
>
> On 2023-04-26 13:02, Christian König wrote:
>> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>>
>>> On 2023-04-26 9:03, Christian König wrote:
>>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>>> Hi Christian,
>>>>>
>>>>> What do you think about Felix's explanation?
>>>>
>>>> That's unfortunately not something we can do here.
>>>>
>>>>>
>>>>> Regards,
>>>>> Eric
>>>>>
>>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import
>>>>>>>>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>>>>>>>>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>>
>>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>>
>>>>>>>> I'd like to get an Acked-by from Christian as well before 
>>>>>>>> submitting this.
>>>>>>>
>>>>>>> I have to admit that I only partially followed the internal 
>>>>>>> discussion, but in general you need a *really* good explanation 
>>>>>>> for this.
>>>>>>>
>>>>>>> E.g. add code comment and explain in the commit message 
>>>>>>> extensively why this is needed and why there are no alternatives.
>>>>>>
>>>>>> OK. I'll give it a shot:
>>>>>>
>>>>>>    This code path is used among other things when invalidating 
>>>>>> DMABuf
>>>>>>    imports. These imports share a reservation object with the 
>>>>>> exported
>>>>>>    BO. Waiting on all the fences in this reservation will trigger 
>>>>>> KFD
>>>>>>    eviction fences unnecessarily, for example when a DMABuf 
>>>>>> import for
>>>>>>    a DMA mapping on a secondary GPU is being unmapped explicitly. 
>>>>>> Only
>>>>>>    moving the original exported BO requires stopping KFD user mode
>>>>>>    queues. If the invalidation is triggered through a move notifier
>>>>>>    from the exported BO, then moving the original BO already 
>>>>>> triggered
>>>>>>    the eviction fence and we don't need to wait for it again on 
>>>>>> the import.
>>>>>>
>>>>>>    We can identify DMABuf imports in KFD for secondary GPU DMA 
>>>>>> mappings
>>>>>>    by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>>>    operation that ignores KFD eviction fences.
>>>>>>
>>>>>> How does this sound?
>>>>
>>>> To be honest like quite a bad idea. Why in the world are imported 
>>>> BOs moved from GTT to SYSTEM in the first place?
>>>
>>> As I understand it, the way to update SG tables in  SG BOs (e.g. 
>>> userptr and dmabuf imports) is to move them back and forth between 
>>> system and GTT domains. If we left the import in the GTT domain all 
>>> the time, we would have no way to update it, e.g. after an eviction. 
>>> Currently the move to the system domain is done in the unmap code path.
>>>
>>> Before memory is freed, we also need to unmap it from GPUVM, 
>>> including the DMABuf imports on remote GPUs. For the above reason 
>>> that currently includes moving the import to the system domain. If 
>>> we removed that from the unmap code path, we'd need to do the move 
>>> to system somewhere else, maybe in the mapping/validation path.
>>>
>>>
>>>>
>>>> The only reason for this I can think of is that the DMA mappings 
>>>> become invalid for some reasons and in this case waiting for the 
>>>> KFD fence is actually the absolutely right thing to do.
>>>
>>> In this case the reason the only reason for unmapping the memory is 
>>> that we're about to free the memory and its DMABuf imports on other 
>>> GPUs. This is coming from the application with a promise "I'm no 
>>> longer accessing the memory". We don't need to wait for fences here. 
>>> We only need to invalidate the PTEs to make sure that any further 
>>> buggy access by the application will fault.
>>
>> Well in this case just free the BO and it's bo_va structure. The core 
>> handling should take care of clearing all the freed up regions.
>>
>> As for updating the SG of a BO you indeed need to move it from GTT to 
>> SYSTEM and back, but in this case we should either indeed wait for 
>> the KFD fence since page tables in between the operation still have 
>> the old entries or we should destroy the BO and create a new one. The 
>> later would overwrite the PTEs with invalid entries first and then 
>> fill in new valid ones.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>   Felix
>>>>>>>>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>>>>>>>> +                        ctx->interruptible);
>>>>>>>>> +        else
>>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>           if (r)
>>>>>>>>>               return r;
>>>>>>>
>>>>>
>>>>
>>


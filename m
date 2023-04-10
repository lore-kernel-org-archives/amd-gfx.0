Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8160EC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 19:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B74C10E231;
	Mon, 10 Apr 2023 19:09:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DFD10E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 19:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giH+M271yDxyeYLoNluKXT+WyJdU9XsAXNqLIaUiScZfowSLLnpYhXDW6Ue2lW3KeeHBmSBHWOuSC5N6NsXTjfe50vLc8zG9zUgrhYUSETtDluGpJXZ4Dl9/ivpFbnUMkhvHhdeOyai+ThNDWNfTh3+1ZyxtGoS647JiJO0Wael40AFhNPdU2rPzI+zXvxht+9GiK0URaeNwYMMx0rkx4R4T4FkP8HdBBkpyEUr8rdPXoAVBRa2jbRl8ONttKbuGQTQJaMxFWVD1InXLtZpzMtkTCZbUfhMcV/CG5lvJnNu3QMqXTH8M3JLQA2P8xaxFqWbWIUhvyCaS9XewJ6/CpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQrFOzqDgo0CjEvjZpa+9M6YZtEEG10eQjsfDTkAcA8=;
 b=chQWAAH4wtjXcJ3/p2SQ0Bajt9MDD2gnkshan3WBL5mA6wh2hSGkvEmxmvVdcpNsHHjeOU4Hn7XV6qdF8eBQTNvmUpGnbrC1Mt1RTcLkmEloamYkIjm/MJb7ONVMmyzeAN4csfQvzttPCORjqA6HbBxxIaofi2t/oMsE0LdhYhPY0MWYKS8VX9VAZ6fWOAWiZLGAbIE8u/N48mBFLEEKyZuEue6v+VWkQkwWwN91qg+4fWMJZ3inQ1HlsOH7YidWKPijbRokHPcD00HEkHKDTOI+aK3WSvd4lDUO4YGO+UGYFH7S4Nw6fyh3PKA5Ai5/P7M1ob28neoY6y8kHjdECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQrFOzqDgo0CjEvjZpa+9M6YZtEEG10eQjsfDTkAcA8=;
 b=ne1K0LRYUOKec3BDgQ9c5FCyjUm+jovx8CmGiwRPbzCatR5VO/8aSScjj/ooyvAxjsuB5r6/pN09whVDzVmtkV1C4ehfOulRJVmwIXR8Qfbg4hhjFn/owH3MNz9Q5qgDaYRjgJ4dsIhHd8ZFziBeOx0Tx2oNJvzvXNV3AR0kBv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 10 Apr
 2023 19:09:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%5]) with mapi id 15.20.6277.034; Mon, 10 Apr 2023
 19:09:03 +0000
Message-ID: <cad53eab-7c6c-495f-b2da-d4f507145b8e@amd.com>
Date: Mon, 10 Apr 2023 15:09:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Fix dmabuf's redundant eviction when unmapping
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230403175949.131530-1-jinhuieric.huang@amd.com>
 <91875e99-89f0-5a5e-03fc-d08d3240c869@amd.com>
 <04845a1f-c602-b796-eeba-c12a91d4401e@amd.com>
 <4a3bfe1e-2c8b-198d-23bd-035e6d78372e@amd.com>
 <4aa3ad89-ed94-bf74-62ef-193bc3a5d6b3@amd.com>
 <39806f53-926c-026d-5cb3-60eedf4082d1@amd.com>
 <4a068fd7-18bf-d346-f1ff-2ba91ef65abf@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <4a068fd7-18bf-d346-f1ff-2ba91ef65abf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 24de77a3-1d24-48d5-7198-08db39f70cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nzx42ljI8AG8yhc+jLs28839aJZVSf+TO1/2Bk6OX+LkB3z26MOu3QEBUPH3VYtRtVBjFGEmd9hQwflPIf1gdfKLyDfL/RH1SPKI1bgFjsLosveoVXnpIFio35Xdv0Q1ThnrJSO5ZavnaGOr4ozcl31nth/HNiVWg8GiccyuqckxYPcMR4iYIseFYgfQ7Kjk29lUGDut6SSEDpkb1Gi7LLH2mlF+gTWdMYXLYs/d9mDhRxXHgY4Mo4vn0tarG1o+Uf5LjEP+VbItAYygbsh46R7oH+Ful9C4H+sWCQvoUUeK/nqjpGpFMFsg5dLL9XC0FvShZeuTfmQlRxvbvuYF8O3UPCu2qldxb0c6Jb8TKD0/ui3I/asTdIZ4ky9GHyY/7MrsVcHj2CEhf/rggL90csX30rDNe6us9XFQAKFJGIHWJWaAY3RR0y9FHUFXU2zaNyV6aFM50OAXW6L8oNYdDQRQhAYoBzVw8pzMesZV7+BXI76iCBHOjNgb36u3MPGuiDg6l4S2Rk8aPoP+7ceX6q3ZHTcnhEM3L/G2vTTYTMqicWzXLpwGBaS6eHytFdikNmBqTu9AJJPOtUuYW4t3llLT13Rdeu18u+hrFEhkrzsJ/9vtfVAxV3KC1PdRfRcoNcS0loR1Hdhi9efCR3ep9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(83380400001)(8676002)(6636002)(26005)(6506007)(44832011)(5660300002)(6512007)(478600001)(53546011)(8936002)(186003)(2616005)(66946007)(6486002)(66556008)(30864003)(36916002)(45080400002)(66476007)(2906002)(110136005)(41300700001)(36756003)(316002)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlGSDZsaXV3Vm14QUFyZEkxTjlNN3FDekd6cnkwS3gyTUFLc1hkTTVuVFV1?=
 =?utf-8?B?VWNDSjV4a3k0V0lwYzVGZVBZbncwTDF4Wk02WWdTU2daWGg3VTRJeSs3WndF?=
 =?utf-8?B?R3hmNDV2QUp5bTJYWXRKbDhkWkpsWk9RVHMweUdUN242Y2VUdlYrdSt4R0VS?=
 =?utf-8?B?YjFWTWp4Mnk5UnVSUWRNMytGbmhHR2lxSUIwa3JJMlQ0UkpDSm93bFhnWFZI?=
 =?utf-8?B?d0hsci84d1YvK0JOaGhpSnhNeENpSlROQnoyR09yYm9tSXNhK3kwb3dKOGpU?=
 =?utf-8?B?dDljdkFzTkI5MjFFZmtTZHJrd1ZGLzFVdTJ6ZzFzV0lDK2tIakhBejJxRExz?=
 =?utf-8?B?amwxUGxmTEU1SGlRREZNZmFKTXU5RDlQQW1GWHVXVkJrK04vWmNqczlPbWJa?=
 =?utf-8?B?R1lYb1djYUFRdU1tOWtZOUJPaExlVVdieHhsQ2d1SDlLWUhyRDdmTkQ4WGcw?=
 =?utf-8?B?MHY1eElhQUttdGFiZ2RDWlN0M2ErVUo0TjAraVB5dHg4NlRrcEk4TDJzekxi?=
 =?utf-8?B?M1dFUDdsQ1g2WG9TbHdTQmgrbHl1enFtVzlURzhQbG04SVRUNktPamNSYTJw?=
 =?utf-8?B?VnU2d2FBY1l1Z0IwNVJRM3owR1M2djdVZ0JKamJqMTlJNzVKRGU4OHRoNTV6?=
 =?utf-8?B?Y1dNZG54Y2hJd05xZnJ6QlVhQjJ2YTM5RHRZbzY4MDZZaW9IUGFZeTRFQWp6?=
 =?utf-8?B?ODQ3azMxUUpLeWR4c2dRbCtqRHJJc3E0bGE1RVhyV2VPejY5Y1ZyeDZUUmc4?=
 =?utf-8?B?enl2djVJSlJZd2lYVE5ObE10T0lTWEErTlZVZjNoNFd3elA4T2lMc2UybnRq?=
 =?utf-8?B?VjhiaHo2VTZIVXNjYlFaZzdBcXBBeUsxNi9UUFJiVk1oU1dMM2pjWmdkMnUy?=
 =?utf-8?B?K0ZzaWZMZlNONDBPMUpnSldzcStSK0RiNjNGaFpQQkJYb0FLYjNicE9CVVhh?=
 =?utf-8?B?NmNyR2svcnA0YS96M1NBbm5ROHlmRGdicEZBeXdDOFNWQ1MyK3RRSm5Ga296?=
 =?utf-8?B?aFVYK25USEJkKzgybDNheUkrSGJUU0c3RlBwNTVDendxb0Rwdmk3UUcwU2E0?=
 =?utf-8?B?WnV4azJaay9xeTkxWXdoT1J0ZWxlNHZSSjl3by9oVUovR1hnN1FzVUpCV0xB?=
 =?utf-8?B?d3FOUXhheVVzZ3VwV2NTdGp4ZkhGVEtTdG1BcFNlRDY1OFVyaGRpQ1BtV0pS?=
 =?utf-8?B?ejVDN05vR0NEQk5aN1pGdDRMeE5jdllsOFBDRmFKVlNFaDV1QllXOVlrQ0k2?=
 =?utf-8?B?Y0QxcTVTWnF1ZjgxRnB5bFdwaHlHZlRNYy93dnhvWWJKdW90ZVVNb0dTZjdZ?=
 =?utf-8?B?d2x5RThoZytOaGNxT1prUnhmNzhqVHZyZ0d4TGp3UkhHblFTOFdYUE5aZGkr?=
 =?utf-8?B?TFhuMTZUWnMrSnAzR2xhRWhKMkRha0RhelFwa2Yvd0V6ZHFvQTN5S2l2ZDFr?=
 =?utf-8?B?U2d5dXA4cE50aVViNVY4TmxqSWM2VXN0azlLT0VHcloyRkk2Z2pOTnQrdjh2?=
 =?utf-8?B?dytZeFg5OW9SN0JSUVdmbU5TUnFoejZKY3RvTU4xMldsODV2bzFLMHJPd1N5?=
 =?utf-8?B?Y1RvZGxyTmVEVjNHUE1PRkw0S0d5NzFORUJ0K0s2ckpBWENqV05VaXIxaG43?=
 =?utf-8?B?eG5Od3YvSWVwandIaFNORDVHY3pZNzhkYTUxUlNJS0lCR0k5ZnhQeGhnSzVJ?=
 =?utf-8?B?R0pRRmx1dkd0OWR0ZGJ2dzl2TVJpS0VZSTZIbTVGQlJhQmorMU1HYnNaY1Rj?=
 =?utf-8?B?MmFYcWJLS3Vuclg0Zjg3ZEJiSWxLbnAxSnloamxtUndnTkFlYVVRYUY1M2p4?=
 =?utf-8?B?aS9NMXN0VEpzWnZROFVzZEUxc1B4alF4S2xVS2txV2pnSDhSOUVlajhYaUlZ?=
 =?utf-8?B?TkNLWnByZnFpQjExVXNsbjhXd2tnRkpKaTU4d3FWcVZ0Vm9LR3FVa1hvVlp3?=
 =?utf-8?B?WlkwcVFuNE9rRUF6THBweEFHZ2xqOUdWTCs4TmgrS3VISHkyT2Y4MmZWVW52?=
 =?utf-8?B?MjZtODJNOUhrbzVmNGh6bHNYRnZtLzlQR2hRTlZjamljYlh2ZnhhUnZwL21u?=
 =?utf-8?B?cmprZ1AxUnQwZEV1aGh3WjNReWVBYU9uUzF4SWIwYkpqUUZJS2tyU295N3pH?=
 =?utf-8?Q?j7fB/lU4uK//YGHsy0M5O48TE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24de77a3-1d24-48d5-7198-08db39f70cc5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 19:09:03.8235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd5RQYisygMH8gWfkMoSd29xCi/vpuxi5wwe1g8cf6iDzSJ2+yarrr4/xWDGZ+8ew+8RHe5AUs0S8LiccQD2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

On 2023-04-10 15:03, Eric Huang wrote:
> Hi Felix,
>
> What do you think my proposal in my previous email? that setting 
> domain to CPU in kfd_mem_dmamap_dmabuf, and setting domain to GTT in 
> kfd_mem_dmaunmap_dmabuf, that will be doing the similar way as userptr.

No. This is the exact opposite of what it should be doing. Validating a 
BO in the CPU domain means, you cannot map it in a GPU virtual address 
space. It would result in invalid PTEs in the GPU page table and any 
access by an application would result in a page fault.

You say that we do this for userptrs. I think that's a misunderstanding. 
From what I see in the source code, kfd_mem_dmaUNMAP_userptr validates 
the userptr import in CPU domain, kfd_mem_dmaMAP_userptr validates the 
userptr import in GTT domain, just as a I would expect.

Regards,
   Felix


>
> Thanks,
> Eric
>
> On 2023-04-10 14:50, Felix Kuehling wrote:
>> Sorry, you're right, there is no AMDGPU_GEM_DOMAIN_PREEMPTIBLE. I 
>> remembered this wrong. There is a flag called 
>> AMDGPU_GEM_CREATE_PREEMPTIBLE, which changes what happens when is 
>> placed in the AMDGPU_GEM_DOMAIN_GTT domain.
>>
>> So my proposal would need to be modified to set the flag 
>> AMDGPU_GEM_CREATE_PREEMPTIBLE in the imported DMABuf BO.
>>
>> On 2023-04-10 14:28, Eric Huang wrote:
>>> Hi Felix,
>>>
>>> Thanks for your review and suggestion, but unfortunately the 
>>> AMDGPU_GEM_DOMAIN_PREEMPTIBLE is not defined in amdgpu_drm.h. I 
>>> understand we need the memory eviction on either 
>>> kfd_mem_dmamap_dmabuf() or kfd_mem_dmaunmap_dmabuf() to update DMA 
>>> address, so I am thinking to do it as simply as userptr memory does.
>>>
>>> The purpose for this change is for non-MES HW scheduler we are using 
>>> userptr/paged memory, but since GFX11 we will be using MES scheduler 
>>> and it needs the memory to be allocated as GTT/non-paged memory, so 
>>> we want all GPUs using GTT/non-paged memory, but there is 
>>> performance drop, because of eviction in kfd_mem_dmaunmap_dmabuf.
>>>
>>> Currently userptr memory is evicted in kfd_mem_dmamap_userptr as 
>>> changing domain to GTT before calling ttm_bo_validate, and not 
>>> evicted in kfd_mem_dmamap_userptr, so I think we can do the similar 
>>> way for GTT/non-paged memory that setting domain to CPU in 
>>> kfd_mem_dmamap_dmabuf, which will evict memory to update DMA 
>>> address, and setting domain to GTT in kfd_mem_dmaunmap_dmabuf, which 
>>> will not evict memory. The performance should be the same as 
>>> userptr/paged memory.
>>
>> This sounds backwards to me. dmaunmap should move objects to the CPU 
>> domain because the GPU mapping is potentially invalid. And dmamap 
>> must use move it to the GTT domain because that updates the GPU 
>> mapping and allows the GPU virtual address mapping to be updated.
>>
>> The problem is the eviction in dmaunmap. Userptrs don't see these 
>> evictions because the SG BOs we use to map them on other GPUs do set 
>> the AMDGPU_GEM_CREATE_PREEMPTIBLE flag. My idea is to do the same 
>> thing for DMABufs that map GTT (and VRAM) BOs to other GPUs._
>>
>> Now that I look at it in more detail, I see we're already doing that 
>> in kfd_mem_attach_dmabuf:
>>
>>         *bo = gem_to_amdgpu_bo(gobj);
>>         (*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>>
>> So then the question is, why is this not working? I think that's the 
>> second part of my proposal, which is still needed:
>>
>>> 2. Add a special case in the above if-block for old_mem->mem_type ==
>>>    AMDGPU_PL_PREEMPT: use amdgpu_bo_sync_wait with
>>>    owner=AMDGPU_FENCE_OWNER_KFD so that it doesn't wait for eviction 
>>> fences 
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Eric
>>>
>>> On 2023-04-04 16:40, Felix Kuehling wrote:
>>>> [+Christian]
>>>>
>>>> OK, this comes from the ttm_bo_wait_ctx call in this section of 
>>>> amdgpu_bo_move:
>>>>
>>>>         if ((old_mem->mem_type == TTM_PL_TT ||
>>>>              old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>              new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>                 r = ttm_bo_wait_ctx(bo, ctx);
>>>>                 if (r)
>>>>                         return r;
>>>>
>>>>                 amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>>>>                 ttm_resource_free(bo, &bo->resource);
>>>>                 ttm_bo_assign_mem(bo, new_mem);
>>>>                 goto out;
>>>>         }
>>>>
>>>> We can't just remove this wait. It's not even specific to KFD or 
>>>> DMABuf imports. We also can't just change it to avoid waiting for 
>>>> eviction fences because it's also used for GTT BOs (e.g. before a 
>>>> BO gets swapped under extreme memory pressure). So we also need to 
>>>> trigger the eviction fence in general case.
>>>>
>>>> In the specific case of DMABuf imports, they share the reservation 
>>>> object with the original BO. So waiting on the reservation triggers 
>>>> the eviction fence on the original BO. I think we want to avoid the 
>>>> waiting on eviction fences for all BOs where the underlying memory 
>>>> is managed by some other BO, and at the same time also avoid ever 
>>>> evicting the DMABuf import BO. That's what AMDGPU_PL_PREEMPT is 
>>>> for. So I think a combination of two changes should to the trick:
>>>>
>>>> 1. Change kfd_mem_dmamap_dmabuf to use AMDGPU_GEM_DOMAIN_PREEMPTIBLE
>>>> 2. Add a special case in the above if-block for old_mem->mem_type ==
>>>>    AMDGPU_PL_PREEMPT: use amdgpu_bo_sync_wait with
>>>>    owner=AMDGPU_FENCE_OWNER_KFD so that it doesn't wait for 
>>>> eviction fences
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>> Am 2023-04-04 um 10:36 schrieb Eric Huang:
>>>>> Here is the backtrace from Jira:
>>>>>
>>>>> Thu Nov 10 13:10:23 2022] Scheduling eviction of pid 97784 in 0 
>>>>> jiffies
>>>>> [Thu Nov 10 13:10:23 2022] WARNING: CPU: 173 PID: 97784 at 
>>>>> /var/lib/dkms/amdgpu/5.16.9.22.20-1438746~20.04/build/amd/amdgpu/../amdkfd/kfd_device.c:878 
>>>>> kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022] Modules linked in: veth amdgpu(OE) 
>>>>> amddrm_ttm_helper(OE) amdttm(OE) iommu_v2 amd_sched(OE) amdkcl(OE) 
>>>>> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink 
>>>>> xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat 
>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bpfilter br_netfilter 
>>>>> bridge stp llc aufs overlay binfmt_misc nls_iso8859_1 dm_multipath 
>>>>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr 
>>>>> intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm efi_pstore 
>>>>> rapl ipmi_ssif ccp acpi_ipmi k10temp ipmi_si ipmi_devintf 
>>>>> ipmi_msghandler mac_hid sch_fq_codel msr ip_tables x_tables 
>>>>> autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 
>>>>> async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
>>>>> raid6_pq libcrc32c raid1 raid0 multipath linear mlx5_ib ib_uverbs 
>>>>> ib_core crct10dif_pclmul crc32_pclmul ghash_clmulni_intel 
>>>>> aesni_intel crypto_simd cryptd ast drm_vram_helper drm_ttm_helper 
>>>>> ttm mlx5_core drm_kms_helper syscopyarea sysfillrect sysimgblt 
>>>>> fb_sys_fops
>>>>> [Thu Nov 10 13:10:23 2022]  pci_hyperv_intf cec psample igb mlxfw 
>>>>> rc_core dca ahci xhci_pci tls drm i2c_algo_bit libahci 
>>>>> xhci_pci_renesas i2c_piix4
>>>>> [Thu Nov 10 13:10:23 2022] CPU: 173 PID: 97784 Comm: 
>>>>> onnxruntime_tes Tainted: G        W  OE 5.13.0-30-generic 
>>>>> #33~20.04.1-Ubuntu
>>>>> [Thu Nov 10 13:10:23 2022] Hardware name: GIGABYTE 
>>>>> G482-Z53-YF/MZ52-G40-00, BIOS R12 05/13/2020
>>>>> [Thu Nov 10 13:10:23 2022] RIP: 
>>>>> 0010:kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022] Code: 5e 5d c3 4c 89 e7 e8 cb c6 44 df 
>>>>> eb e7 49 8b 45 60 48 89 ca 48 c7 c7 38 8b d7 c1 48 89 4d e0 8b b0 
>>>>> 20 09 00 00 e8 87 ee 7e df <0f> 0b 48 8b 4d e0 eb 9f 41 be ea ff 
>>>>> ff ff eb ba 41 be ed ff ff ff
>>>>> [Thu Nov 10 13:10:23 2022] RSP: 0018:ffffb25f2a173978 EFLAGS: 
>>>>> 00010086
>>>>> [Thu Nov 10 13:10:23 2022] RAX: 0000000000000000 RBX: 
>>>>> 0000000000000001 RCX: 0000000000000027
>>>>> [Thu Nov 10 13:10:23 2022] RDX: 0000000000000027 RSI: 
>>>>> 00000000fffeffff RDI: ffff95d06e4a09c8
>>>>> [Thu Nov 10 13:10:23 2022] RBP: ffffb25f2a173998 R08: 
>>>>> ffff95d06e4a09c0 R09: ffffb25f2a173750
>>>>> [Thu Nov 10 13:10:23 2022] R10: 0000000000000001 R11: 
>>>>> 0000000000000001 R12: ffff95c371d74580
>>>>> [Thu Nov 10 13:10:23 2022] R13: ffff95b1cd3f2000 R14: 
>>>>> 0000000000000000 R15: ffff95c371d74580
>>>>> [Thu Nov 10 13:10:23 2022] FS:  00007fcaff268b00(0000) 
>>>>> GS:ffff95d06e480000(0000) knlGS:0000000000000000
>>>>> [Thu Nov 10 13:10:23 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>>>> 0000000080050033
>>>>> [Thu Nov 10 13:10:23 2022] CR2: 00007fc643980000 CR3: 
>>>>> 00000003e9492000 CR4: 0000000000350ee0
>>>>> [Thu Nov 10 13:10:23 2022] Call Trace:
>>>>> [Thu Nov 10 13:10:23 2022]  <TASK>
>>>>> [Thu Nov 10 13:10:23 2022] 
>>>>>  amdkfd_fence_enable_signaling+0x46/0x50 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022]  __dma_fence_enable_signaling+0x52/0xb0
>>>>> [Thu Nov 10 13:10:23 2022]  dma_fence_default_wait+0xa9/0x200
>>>>> [Thu Nov 10 13:10:23 2022]  dma_fence_wait_timeout+0xbd/0xe0
>>>>> [Thu Nov 10 13:10:23 2022]  amddma_resv_wait_timeout+0x6f/0xd0 
>>>>> [amdkcl]
>>>>> [Thu Nov 10 13:10:23 2022]  amdttm_bo_wait+0x39/0x50 [amdttm]
>>>>> [Thu Nov 10 13:10:23 2022]  amdgpu_bo_move+0x41e/0x7b0 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022]  ? down_write+0x13/0x50
>>>>> [Thu Nov 10 13:10:23 2022]  ? unmap_mapping_pages+0x68/0x130
>>>>> [Thu Nov 10 13:10:23 2022]  ttm_bo_handle_move_mem+0x7f/0x120 
>>>>> [amdttm]
>>>>> [Thu Nov 10 13:10:23 2022]  amdttm_bo_validate+0xbf/0x100 [amdttm]
>>>>> [Thu Nov 10 13:10:23 2022] 
>>>>>  kfd_mem_dmaunmap_attachment+0x131/0x140 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022]  unmap_bo_from_gpuvm+0x67/0x80 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022] 
>>>>>  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x114/0x220 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022]  ? __mod_memcg_lruvec_state+0x22/0xe0
>>>>> [Thu Nov 10 13:10:23 2022] 
>>>>>  kfd_ioctl_unmap_memory_from_gpu+0xe8/0x270 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022]  kfd_ioctl+0x23c/0x590 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022]  ? 
>>>>> kfd_ioctl_get_process_apertures_new+0x330/0x330 [amdgpu]
>>>>> [Thu Nov 10 13:10:23 2022]  ? exit_to_user_mode_prepare+0x3d/0x1c0
>>>>> [Thu Nov 10 13:10:23 2022]  ? __fget_files+0xa7/0xd0
>>>>> [Thu Nov 10 13:10:23 2022]  __x64_sys_ioctl+0x91/0xc0
>>>>> [Thu Nov 10 13:10:23 2022]  do_syscall_64+0x61/0xb0
>>>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>>>> [Thu Nov 10 13:10:23 2022]  ? 
>>>>> asm_sysvec_apic_timer_interrupt+0xa/0x20
>>>>> [Thu Nov 10 13:10:23 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> [Thu Nov 10 13:10:23 2022] RIP: 0033:0x7fcaff57b3ab
>>>>> [Thu Nov 10 13:10:23 2022] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 
>>>>> c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 
>>>>> 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 
>>>>> b5 7a 0d 00 f7 d8 64 89 01 48
>>>>> [Thu Nov 10 13:10:23 2022] RSP: 002b:00007fffe41e0098 EFLAGS: 
>>>>> 00000206 ORIG_RAX: 0000000000000010
>>>>> [Thu Nov 10 13:10:23 2022] RAX: ffffffffffffffda RBX: 
>>>>> 00007fcacc7f7f80 RCX: 00007fcaff57b3ab
>>>>> [Thu Nov 10 13:10:23 2022] RDX: 00007fffe41e0120 RSI: 
>>>>> 00000000c0184b19 RDI: 0000000000000003
>>>>> [Thu Nov 10 13:10:23 2022] RBP: 00007fffe41e00d0 R08: 
>>>>> 0000562e2d5730d0 R09: 0000000000000000
>>>>> [Thu Nov 10 13:10:23 2022] R10: 0000562e2c928ec0 R11: 
>>>>> 0000000000000206 R12: 0000000000000001
>>>>> [Thu Nov 10 13:10:23 2022] R13: 00007fffe41e04b0 R14: 
>>>>> 0000000000000000 R15: 0000562e2d3f5b20
>>>>> [Thu Nov 10 13:10:23 2022]  </TASK>
>>>>> [Thu Nov 10 13:10:23 2022] ---[ end trace 1464f08f6be60b30 ]---
>>>>>
>>>>> Regards,
>>>>> Eric
>>>>>
>>>>> On 2023-04-04 10:11, Felix Kuehling wrote:
>>>>>> If we keep the BO in the GTT domain, it means it will not be 
>>>>>> updated if we validate it again later in kfd_mem_dmamap_dmabuf. 
>>>>>> This means we'll use stale DMA addresses when we update the page 
>>>>>> tables after evictions.
>>>>>>
>>>>>> I think we'll need to find a different way to avoid triggering 
>>>>>> the eviction fence on the original BO when changing the placement 
>>>>>> of the DMABuf import here. If you need help brainstorming here, 
>>>>>> please share a backtrace from the eviction generated with the 
>>>>>> debug_evictions module param.
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>> Am 2023-04-03 um 13:59 schrieb Eric Huang:
>>>>>>> dmabuf is allocated/mapped as GTT domain, when dma-unmapping dmabuf
>>>>>>> changing placement to CPU will trigger memory eviction after 
>>>>>>> calling
>>>>>>> ttm_bo_validate, and the eviction will cause performance drop.
>>>>>>> Keeping the correct domain will solve the issue.
>>>>>>>
>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> index a3b09edfd1bf..17b708acb447 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> @@ -642,7 +642,7 @@ kfd_mem_dmaunmap_dmabuf(struct 
>>>>>>> kfd_mem_attachment *attachment)
>>>>>>>       struct ttm_operation_ctx ctx = {.interruptible = true};
>>>>>>>       struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>>>>>>>   -    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>>>>>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>>>>>       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>>>   }
>>>>>
>>>
>

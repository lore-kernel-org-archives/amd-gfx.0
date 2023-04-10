Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51E5C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 18:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4396210E18A;
	Mon, 10 Apr 2023 18:50:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D5E10E18A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 18:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4w+ztHN8nX4YiNoJeHtU0cKciQYbQ6bFpzEadaaRZAPBnkidnCC9CjcAuXxd5WTg23GKW6wbLT8MjSSJPuwzCIn84uYIRbM/GIL2HFCtKu3JNzc47TPVM4jWwF8JgV9Fv6ffUlbvLM8Yr6Xgx5fwjbSRAcoHNJjgVF8KXGgphrm2EgjWqHIQGfDIpbRCc763kjpLJEB58Ouqjno4DTFlK/qmkvcJS/a2BbBOP1bQ1PestbqNpWLApUa9aVtKbkqASBwMmVcDsI18JL0hZRWf8RDa5SLn43PIU1g0Dcj+0jUFI3ZrieVkyjowZteqAWD+P6PWDUgIQVUg1A48aqbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ddT/DkUXj2/+d/osfreHfuSmM4fpmihdn9OKOiWSPk=;
 b=IovTcIDZ5ByBj4odwLbn6Z9oNJlh8KI1DERwQZpDi88W12LHGjxS1vQp156WdD+2PPKK151ux9+OVxu1Oy21XfUN5XVfkGsc91sh+tmpXAW9jOEL+OgFpHlHS5RNVeVV9YVsNMtuqO73y0nPQBWL8pJNTtxFPOp83iyAv1t95AR7Sv2O4fHf+K4cNS7PietEuITuFFOQo/f7UjZ/ffa2bzCaoC2nyuYHtzUPg4nqtXgDgaARy4v3Tz91x9WAMaklFpQrMRmK2qsqyVGGCfwNPxW6D3ks138ODn9sjYyaCBmiUc4N8uDrOhyHvaSq6DLHKmvgdutFqyiYQ5MnBk7e4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ddT/DkUXj2/+d/osfreHfuSmM4fpmihdn9OKOiWSPk=;
 b=L9rnuq0qtnPxVr7V3zmngLl6j+7O1L25PbzDyIkAyRuPWNDhsErZBWgFnTwrDQC88m7PvTSQx6UDbUQ5ni2bZLITXbaJuLUNaRbrGpSpxf8bVcgwfSCH59s6q3R1SopSz5HVxOitnyESIHFqoxvfKqdQwe9vzrEMfe8a+L6StYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Mon, 10 Apr
 2023 18:50:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%5]) with mapi id 15.20.6277.034; Mon, 10 Apr 2023
 18:50:47 +0000
Message-ID: <39806f53-926c-026d-5cb3-60eedf4082d1@amd.com>
Date: Mon, 10 Apr 2023 14:50:44 -0400
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
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <4aa3ad89-ed94-bf74-62ef-193bc3a5d6b3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: b03e164c-dace-45ce-b3b0-08db39f47f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DUKOpLEKiEwkrOyWTDFqg+ZQNeAsB3HaMNfv7yR7b+usiYYWKzf4te3V0kxOSg+FCPaKY2b1Ue8sV5r3yJvM75Vk3y9v7rivzKd30u95NBjbi/3CP/KgazloiCLBVviCdT64vY4yImikFzmmUEqdz91E3gQGg3kDBSfzXc6gALjZf1kVmBikAmgk6hdnlaDFxYF75nwkl9krvq458Xv7SVye2DERUM5nf/4Fjum7XIeDs6MoZ4Z15tqygeuigTSciQRnQCpBlNXPZVfkasqHNZZcniJG9tOJjkJuVM3OIq1kgF5yEOgWuaGir/vfNRQ69nFOy0j2Alt9Gbg9R6XaZTIEtaS3iZE5dZFYr8pCagDsb16Br538Kbrn7r6nKgHFZPkPvX1Wbj5rrCmZci8YusEs4CpqwyBHmMqd1PQF7PBGVlMcl9atboP+EltFf3UZZa1LDUcnF0qsptwyQEUusfiiFB3yhn1jqAvjp2F9daO1zi9l+GOtTllr+61KWUQrlUqHycfJ1cb1O1bsPlKfRzEI5kO1GnVb8NYLThhnPpoCvulKjzxOiOcGnne+ij/Z2yVtDgHw75sQyjuLBtTR2EkMnFFPPbF+RKMaP2+ycXFDuWZ0CeAHxAr9/0VTJ8zEarsI5ulUF5clDGPCDFVGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(186003)(36756003)(53546011)(86362001)(31696002)(6666004)(2616005)(6512007)(6506007)(6636002)(5660300002)(26005)(110136005)(8936002)(316002)(8676002)(44832011)(478600001)(30864003)(66476007)(66556008)(38100700002)(31686004)(41300700001)(83380400001)(45080400002)(66946007)(2906002)(36916002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzRJZTVXdVcwbFprL3NHQTIvenZTRjJ2SllyZm5teUJZcllTaVVuQTJGRVM1?=
 =?utf-8?B?UzE2UjJYa3pBa0svZWpLTER6SFZYWHYzTk1jcGdJL1RkMmwvSmh4L2MzaVE1?=
 =?utf-8?B?RGtWWFNKZUMwOGlLNjFxODhzeGpVT0xqdytEcURNSi9PUy9Yc2pYa3liTEEr?=
 =?utf-8?B?ZkdHam5RMzd0L0h0Zmo0OHVGdUVJMWwwSFNMa3VDVGZSTGpsN3d5M0hmWmJE?=
 =?utf-8?B?aUhRS2Y0SW02ckxxRzRiUm0wS2c3bzQyaHJjUEZHc05zaE4xeWphK1o5amln?=
 =?utf-8?B?VkU0cyszbzFOejdGTS95R0pQZHVSSHRvc2ppMTh1LzJpbWU4SVNTbDhRWS9Y?=
 =?utf-8?B?OWd5elN1RUpmQlJ4U1NrUUNMOEEzYm9rd1ZFaW4rS1ZTU0pLa0xGYk01Tk81?=
 =?utf-8?B?eE5JSkxnODAyZnE2UGxGMDNBcjkxS2xFcE9Rczkrc3pyZ2psdjFXZU1ReFdk?=
 =?utf-8?B?RmZzYjVZUUFuQUNNVXJrS2g2dGNqQm5FZllEVjFDVkxzbG1vQkhJV3FqOXhz?=
 =?utf-8?B?WDBXS29SQUlEb0VMRVJLWXUxTmRQRUZWS2ZBOWhNd0swTUt1L3R6cjd6UFhC?=
 =?utf-8?B?V3p4a0x6ZmNxaXZBTkE1bDVCUnE5bnl0cXMySmhWSkpVOUhYZ2NVSTJqUG5U?=
 =?utf-8?B?bWlUczBWSjdJOWFDRGhvRHFTNm1ReUtYU1Y4SS9taEEwdG5jcldHZ281UzRy?=
 =?utf-8?B?ODdUUTNCUmFtc01JNEFmanV6aWlmZHA3OW1HeVdzVkVMMVprRC9QZnpYWnpH?=
 =?utf-8?B?dEpHU0MwK2I5Ti8vdHNNUG1QeTJxRTdxVEhwVkRkbFc0L1QwMGxodys3aFpQ?=
 =?utf-8?B?cGZhdWJNS0xsVW55OWJiQ291QzFKeU5NZkI1dWdaZTFOU1JscjFFMGM1d2JF?=
 =?utf-8?B?cDROa3FTNndRVlZLSGY5aG01dkF3R2tkdVUwSzlhbC9IRUJ4M3NzczZzd2Ni?=
 =?utf-8?B?ZXppVlZYei81U3JzQnUzV3MvZGlqaDRhajRRMkpLKzhueG1HVmwzVUtIMU9a?=
 =?utf-8?B?RWovVGNydllHN2V2ZFhwTzlHbmpRck00MFo5bC9Ddk10NFB1MldBNWgrRjN1?=
 =?utf-8?B?QWZTQkVSc3d1N1ZrSWpncHdsNXFhaXI1bmZwRktrS2NsUk5kdk5jdW13SGFS?=
 =?utf-8?B?bkJKSXZjYWNUUGFtMHdaN0dKUTZTUndtaDRBekQvMXBWaFZVY0MxMUludmJl?=
 =?utf-8?B?UXROM2FGaG9JeHdkSUlZS05VRG4wazRvTUlKMDFrOGRIS3J0NWU1Z2RsS21v?=
 =?utf-8?B?U0x3eGpvUFlhTFduaFo1RnREWmhPVEY4SlYyTmlsSnRJOWR0eHJlUUY4ZUtF?=
 =?utf-8?B?RXJUcVM5aUpSOFNWeEU0SE5pVVlnV2pOMFRqSzBycmZtdkx0UEg5SFpqTFBs?=
 =?utf-8?B?cVBoOWYzTnhrUEtLMGxDYzVXZExTbFhWRUM1ZHczUE1KZTNrMmhXRklzTU5Q?=
 =?utf-8?B?ZG1lVks0bmpxT2Z4YTRCZ1JQdmZkSCsyeEZjMU1GYXVOblhIVWIwdUZYR0hD?=
 =?utf-8?B?V0hzRHZmMkw5UUlZNmZ1Y0tvVHFQRHc1VVd2NGZhQ1VTc3dZYkhFMVk0dHZI?=
 =?utf-8?B?WFpoQXNQOS9obC9LL1hTOW05SVVvS2lpUkxRbjc1RlVaRmorVnpZai82WE53?=
 =?utf-8?B?L0Q4bkJ6dWpKRUNjaERQMWNpZWlSbjRJN3NvYmlxK3czZlJtZnZobFdOOG5Q?=
 =?utf-8?B?OUpjclhqOWk5dXFkbVhaZm9JQWJISitBdGM2Rm9ZMDVjWnNzQzZZWTBJT1pm?=
 =?utf-8?B?SG5yK28wekpNYmJlbi9zemRUZmJNTUdkUG9TQm44WnpsTmRiRk5JdXpjZ1FJ?=
 =?utf-8?B?RmVENFkyTTNOWExuTk1hRnBmdzRzd0NVN3FDekNhTFhaY2Z5S1dxcjVZYnlP?=
 =?utf-8?B?bFlpSld5SUliN0VIZ1U4ODVOR2Q5ZTdjSko2U1gwZTZMSUUwQU9ablpGZzdv?=
 =?utf-8?B?bXZPbGUvem5DdGxBS2l2UHoxeWY0RkxTeElSLy80VzNGSXVRb2YrdFdkV0tx?=
 =?utf-8?B?T0wwb28xbmo2b2ZqSWoycXV1WU9HOXMweG1LQmM4QVZJZytRMkNEZENwejh0?=
 =?utf-8?B?WEY2aFZYS3M2WGpjdmp0UDYwSDVFTVlYVmZjRjBLTW9VanVzUjYxWU5WcFRX?=
 =?utf-8?Q?mjbP8zX1ex6nNQnJ46sxA2st7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03e164c-dace-45ce-b3b0-08db39f47f2e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:50:47.3169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD4bctKeC1sI3L4V+mc9MxxX0UY8ZHU26qbQb+jc1MpWSiiXi/JsFcpmIKZm8jRqDr1pJJmjx35stJumD79qaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
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

Sorry, you're right, there is no AMDGPU_GEM_DOMAIN_PREEMPTIBLE. I 
remembered this wrong. There is a flag called 
AMDGPU_GEM_CREATE_PREEMPTIBLE, which changes what happens when is placed 
in the AMDGPU_GEM_DOMAIN_GTT domain.

So my proposal would need to be modified to set the flag 
AMDGPU_GEM_CREATE_PREEMPTIBLE in the imported DMABuf BO.

On 2023-04-10 14:28, Eric Huang wrote:
> Hi Felix,
>
> Thanks for your review and suggestion, but unfortunately the 
> AMDGPU_GEM_DOMAIN_PREEMPTIBLE is not defined in amdgpu_drm.h. I 
> understand we need the memory eviction on either 
> kfd_mem_dmamap_dmabuf() or kfd_mem_dmaunmap_dmabuf() to update DMA 
> address, so I am thinking to do it as simply as userptr memory does.
>
> The purpose for this change is for non-MES HW scheduler we are using 
> userptr/paged memory, but since GFX11 we will be using MES scheduler 
> and it needs the memory to be allocated as GTT/non-paged memory, so we 
> want all GPUs using GTT/non-paged memory, but there is performance 
> drop, because of eviction in kfd_mem_dmaunmap_dmabuf.
>
> Currently userptr memory is evicted in kfd_mem_dmamap_userptr as 
> changing domain to GTT before calling ttm_bo_validate, and not evicted 
> in kfd_mem_dmamap_userptr, so I think we can do the similar way for 
> GTT/non-paged memory that setting domain to CPU in 
> kfd_mem_dmamap_dmabuf, which will evict memory to update DMA address, 
> and setting domain to GTT in kfd_mem_dmaunmap_dmabuf, which will not 
> evict memory. The performance should be the same as userptr/paged memory.

This sounds backwards to me. dmaunmap should move objects to the CPU 
domain because the GPU mapping is potentially invalid. And dmamap must 
use move it to the GTT domain because that updates the GPU mapping and 
allows the GPU virtual address mapping to be updated.

The problem is the eviction in dmaunmap. Userptrs don't see these 
evictions because the SG BOs we use to map them on other GPUs do set the 
AMDGPU_GEM_CREATE_PREEMPTIBLE flag. My idea is to do the same thing for 
DMABufs that map GTT (and VRAM) BOs to other GPUs._

Now that I look at it in more detail, I see we're already doing that in 
kfd_mem_attach_dmabuf:

         *bo = gem_to_amdgpu_bo(gobj);
         (*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;

So then the question is, why is this not working? I think that's the 
second part of my proposal, which is still needed:

> 2. Add a special case in the above if-block for old_mem->mem_type ==
>    AMDGPU_PL_PREEMPT: use amdgpu_bo_sync_wait with
>    owner=AMDGPU_FENCE_OWNER_KFD so that it doesn't wait for eviction 
> fences 

Regards,
   Felix


>
> Regards,
> Eric
>
> On 2023-04-04 16:40, Felix Kuehling wrote:
>> [+Christian]
>>
>> OK, this comes from the ttm_bo_wait_ctx call in this section of 
>> amdgpu_bo_move:
>>
>>         if ((old_mem->mem_type == TTM_PL_TT ||
>>              old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>              new_mem->mem_type == TTM_PL_SYSTEM) {
>>                 r = ttm_bo_wait_ctx(bo, ctx);
>>                 if (r)
>>                         return r;
>>
>>                 amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>>                 ttm_resource_free(bo, &bo->resource);
>>                 ttm_bo_assign_mem(bo, new_mem);
>>                 goto out;
>>         }
>>
>> We can't just remove this wait. It's not even specific to KFD or 
>> DMABuf imports. We also can't just change it to avoid waiting for 
>> eviction fences because it's also used for GTT BOs (e.g. before a BO 
>> gets swapped under extreme memory pressure). So we also need to 
>> trigger the eviction fence in general case.
>>
>> In the specific case of DMABuf imports, they share the reservation 
>> object with the original BO. So waiting on the reservation triggers 
>> the eviction fence on the original BO. I think we want to avoid the 
>> waiting on eviction fences for all BOs where the underlying memory is 
>> managed by some other BO, and at the same time also avoid ever 
>> evicting the DMABuf import BO. That's what AMDGPU_PL_PREEMPT is for. 
>> So I think a combination of two changes should to the trick:
>>
>> 1. Change kfd_mem_dmamap_dmabuf to use AMDGPU_GEM_DOMAIN_PREEMPTIBLE
>> 2. Add a special case in the above if-block for old_mem->mem_type ==
>>    AMDGPU_PL_PREEMPT: use amdgpu_bo_sync_wait with
>>    owner=AMDGPU_FENCE_OWNER_KFD so that it doesn't wait for eviction 
>> fences
>>
>> Regards,
>>   Felix
>>
>>
>> Am 2023-04-04 um 10:36 schrieb Eric Huang:
>>> Here is the backtrace from Jira:
>>>
>>> Thu Nov 10 13:10:23 2022] Scheduling eviction of pid 97784 in 0 jiffies
>>> [Thu Nov 10 13:10:23 2022] WARNING: CPU: 173 PID: 97784 at 
>>> /var/lib/dkms/amdgpu/5.16.9.22.20-1438746~20.04/build/amd/amdgpu/../amdkfd/kfd_device.c:878 
>>> kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022] Modules linked in: veth amdgpu(OE) 
>>> amddrm_ttm_helper(OE) amdttm(OE) iommu_v2 amd_sched(OE) amdkcl(OE) 
>>> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user 
>>> xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack 
>>> nf_defrag_ipv6 nf_defrag_ipv4 bpfilter br_netfilter bridge stp llc 
>>> aufs overlay binfmt_misc nls_iso8859_1 dm_multipath scsi_dh_rdac 
>>> scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common amd64_edac 
>>> edac_mce_amd kvm_amd kvm efi_pstore rapl ipmi_ssif ccp acpi_ipmi 
>>> k10temp ipmi_si ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel 
>>> msr ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress 
>>> raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor 
>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mlx5_ib 
>>> ib_uverbs ib_core crct10dif_pclmul crc32_pclmul ghash_clmulni_intel 
>>> aesni_intel crypto_simd cryptd ast drm_vram_helper drm_ttm_helper 
>>> ttm mlx5_core drm_kms_helper syscopyarea sysfillrect sysimgblt 
>>> fb_sys_fops
>>> [Thu Nov 10 13:10:23 2022]  pci_hyperv_intf cec psample igb mlxfw 
>>> rc_core dca ahci xhci_pci tls drm i2c_algo_bit libahci 
>>> xhci_pci_renesas i2c_piix4
>>> [Thu Nov 10 13:10:23 2022] CPU: 173 PID: 97784 Comm: onnxruntime_tes 
>>> Tainted: G        W  OE     5.13.0-30-generic #33~20.04.1-Ubuntu
>>> [Thu Nov 10 13:10:23 2022] Hardware name: GIGABYTE 
>>> G482-Z53-YF/MZ52-G40-00, BIOS R12 05/13/2020
>>> [Thu Nov 10 13:10:23 2022] RIP: 
>>> 0010:kgd2kfd_schedule_evict_and_restore_process+0x104/0x120 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022] Code: 5e 5d c3 4c 89 e7 e8 cb c6 44 df eb 
>>> e7 49 8b 45 60 48 89 ca 48 c7 c7 38 8b d7 c1 48 89 4d e0 8b b0 20 09 
>>> 00 00 e8 87 ee 7e df <0f> 0b 48 8b 4d e0 eb 9f 41 be ea ff ff ff eb 
>>> ba 41 be ed ff ff ff
>>> [Thu Nov 10 13:10:23 2022] RSP: 0018:ffffb25f2a173978 EFLAGS: 00010086
>>> [Thu Nov 10 13:10:23 2022] RAX: 0000000000000000 RBX: 
>>> 0000000000000001 RCX: 0000000000000027
>>> [Thu Nov 10 13:10:23 2022] RDX: 0000000000000027 RSI: 
>>> 00000000fffeffff RDI: ffff95d06e4a09c8
>>> [Thu Nov 10 13:10:23 2022] RBP: ffffb25f2a173998 R08: 
>>> ffff95d06e4a09c0 R09: ffffb25f2a173750
>>> [Thu Nov 10 13:10:23 2022] R10: 0000000000000001 R11: 
>>> 0000000000000001 R12: ffff95c371d74580
>>> [Thu Nov 10 13:10:23 2022] R13: ffff95b1cd3f2000 R14: 
>>> 0000000000000000 R15: ffff95c371d74580
>>> [Thu Nov 10 13:10:23 2022] FS:  00007fcaff268b00(0000) 
>>> GS:ffff95d06e480000(0000) knlGS:0000000000000000
>>> [Thu Nov 10 13:10:23 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>> 0000000080050033
>>> [Thu Nov 10 13:10:23 2022] CR2: 00007fc643980000 CR3: 
>>> 00000003e9492000 CR4: 0000000000350ee0
>>> [Thu Nov 10 13:10:23 2022] Call Trace:
>>> [Thu Nov 10 13:10:23 2022]  <TASK>
>>> [Thu Nov 10 13:10:23 2022]  amdkfd_fence_enable_signaling+0x46/0x50 
>>> [amdgpu]
>>> [Thu Nov 10 13:10:23 2022]  __dma_fence_enable_signaling+0x52/0xb0
>>> [Thu Nov 10 13:10:23 2022]  dma_fence_default_wait+0xa9/0x200
>>> [Thu Nov 10 13:10:23 2022]  dma_fence_wait_timeout+0xbd/0xe0
>>> [Thu Nov 10 13:10:23 2022]  amddma_resv_wait_timeout+0x6f/0xd0 [amdkcl]
>>> [Thu Nov 10 13:10:23 2022]  amdttm_bo_wait+0x39/0x50 [amdttm]
>>> [Thu Nov 10 13:10:23 2022]  amdgpu_bo_move+0x41e/0x7b0 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022]  ? down_write+0x13/0x50
>>> [Thu Nov 10 13:10:23 2022]  ? unmap_mapping_pages+0x68/0x130
>>> [Thu Nov 10 13:10:23 2022]  ttm_bo_handle_move_mem+0x7f/0x120 [amdttm]
>>> [Thu Nov 10 13:10:23 2022]  amdttm_bo_validate+0xbf/0x100 [amdttm]
>>> [Thu Nov 10 13:10:23 2022]  kfd_mem_dmaunmap_attachment+0x131/0x140 
>>> [amdgpu]
>>> [Thu Nov 10 13:10:23 2022]  unmap_bo_from_gpuvm+0x67/0x80 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022] 
>>>  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x114/0x220 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022]  ? __mod_memcg_lruvec_state+0x22/0xe0
>>> [Thu Nov 10 13:10:23 2022] 
>>>  kfd_ioctl_unmap_memory_from_gpu+0xe8/0x270 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022]  kfd_ioctl+0x23c/0x590 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022]  ? 
>>> kfd_ioctl_get_process_apertures_new+0x330/0x330 [amdgpu]
>>> [Thu Nov 10 13:10:23 2022]  ? exit_to_user_mode_prepare+0x3d/0x1c0
>>> [Thu Nov 10 13:10:23 2022]  ? __fget_files+0xa7/0xd0
>>> [Thu Nov 10 13:10:23 2022]  __x64_sys_ioctl+0x91/0xc0
>>> [Thu Nov 10 13:10:23 2022]  do_syscall_64+0x61/0xb0
>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>> [Thu Nov 10 13:10:23 2022]  ? do_syscall_64+0x6e/0xb0
>>> [Thu Nov 10 13:10:23 2022]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>>> [Thu Nov 10 13:10:23 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [Thu Nov 10 13:10:23 2022] RIP: 0033:0x7fcaff57b3ab
>>> [Thu Nov 10 13:10:23 2022] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 
>>> 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 
>>> b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 
>>> 00 f7 d8 64 89 01 48
>>> [Thu Nov 10 13:10:23 2022] RSP: 002b:00007fffe41e0098 EFLAGS: 
>>> 00000206 ORIG_RAX: 0000000000000010
>>> [Thu Nov 10 13:10:23 2022] RAX: ffffffffffffffda RBX: 
>>> 00007fcacc7f7f80 RCX: 00007fcaff57b3ab
>>> [Thu Nov 10 13:10:23 2022] RDX: 00007fffe41e0120 RSI: 
>>> 00000000c0184b19 RDI: 0000000000000003
>>> [Thu Nov 10 13:10:23 2022] RBP: 00007fffe41e00d0 R08: 
>>> 0000562e2d5730d0 R09: 0000000000000000
>>> [Thu Nov 10 13:10:23 2022] R10: 0000562e2c928ec0 R11: 
>>> 0000000000000206 R12: 0000000000000001
>>> [Thu Nov 10 13:10:23 2022] R13: 00007fffe41e04b0 R14: 
>>> 0000000000000000 R15: 0000562e2d3f5b20
>>> [Thu Nov 10 13:10:23 2022]  </TASK>
>>> [Thu Nov 10 13:10:23 2022] ---[ end trace 1464f08f6be60b30 ]---
>>>
>>> Regards,
>>> Eric
>>>
>>> On 2023-04-04 10:11, Felix Kuehling wrote:
>>>> If we keep the BO in the GTT domain, it means it will not be 
>>>> updated if we validate it again later in kfd_mem_dmamap_dmabuf. 
>>>> This means we'll use stale DMA addresses when we update the page 
>>>> tables after evictions.
>>>>
>>>> I think we'll need to find a different way to avoid triggering the 
>>>> eviction fence on the original BO when changing the placement of 
>>>> the DMABuf import here. If you need help brainstorming here, please 
>>>> share a backtrace from the eviction generated with the 
>>>> debug_evictions module param.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>> Am 2023-04-03 um 13:59 schrieb Eric Huang:
>>>>> dmabuf is allocated/mapped as GTT domain, when dma-unmapping dmabuf
>>>>> changing placement to CPU will trigger memory eviction after calling
>>>>> ttm_bo_validate, and the eviction will cause performance drop.
>>>>> Keeping the correct domain will solve the issue.
>>>>>
>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index a3b09edfd1bf..17b708acb447 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -642,7 +642,7 @@ kfd_mem_dmaunmap_dmabuf(struct 
>>>>> kfd_mem_attachment *attachment)
>>>>>       struct ttm_operation_ctx ctx = {.interruptible = true};
>>>>>       struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>>>>>   -    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>>>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>>>       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>   }
>>>
>

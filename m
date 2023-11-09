Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3ACC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 08:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BBB10E1DE;
	Thu,  9 Nov 2023 08:12:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E923410E1DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ0EtPtKAKiHU/C89melM5EDBDhR8VLnxP29Xjyujippc5z08yKPNnUZmsBHzHSlYxVnaKyFx24OlltY4YgqkHcX3u6lUi4/dE1CrbKEtE+nZnkiUKyWO6Cm8UX2BVdCoa1aaSPSC/fq9VHnyGaJp6kZVXUPt5gW3dxBeFg4WItfHVuwinky82SBlOUiR2PdtlQjhQ4asXx+o1AMz84Dw9T5t5SXPDBp/1rsXiRUVi07bDuBBfBS6K/7QZaO/zZlzKaFJRqOxt/Q3BcIeEiEV9TiC18Z2dpNM+TdlzL8puy/XK0nARFwKAN7EHHcN6A3ejDDUwpjMBrS8N+SJK+n0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It8u81ToFx7VFoShC8G7R2kQXws0n0wRdFNQwHag4pM=;
 b=Pz8FFT/DeCFKkjMXj3aLowUc1w/pr9Ha82HXf2N6L2aR3HIsCAo+mkM0EhIFuHPG5EyyOpEIWpQ7HUHyzzhD1KO2P+2NEtFh6K87qRorH4GOVLGn13d59zERdXCjmcA+jJwlTcE/i/P7JTY5LEweRV38UgxUliUyqlpKY/vyH3Aa2Mi50XgM99AxGABnRZdkw8m/AHSKAuvYKHskfQdyJ0iExdHPgwnHLE6CFtqIQyJrclvw8muZIT34RlZKIzR4+MkfPdj4PIGs50R6S3M4uKzYySOrYrZXO2CyJ/BOONPGXaK6xwxGy6lw/677hus3AMyvKXSe7CSVcHBwG2xfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It8u81ToFx7VFoShC8G7R2kQXws0n0wRdFNQwHag4pM=;
 b=Brk54oIys1Std7iZlq0MRwjPeLhAbcleQCqkhiK5j7Y2DQ0uCvp2SFFxmjgbtfYuMdFmj62ZrNTCzuQxakwRAcN3xELJjwtAFZmJOUXz2Dx6+7MPNV8dvlZWhu4J8hoq9JL7UjVe+LrE5sv1Ju+8RXK72GhkvwvRdPjzSVIBB5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 08:12:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 08:12:46 +0000
Message-ID: <1cdf935f-4b59-4c41-9aa8-e1fc7d37d79d@amd.com>
Date: Thu, 9 Nov 2023 09:12:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: New VM state for evicted user BOs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-2-Felix.Kuehling@amd.com>
 <8b63ff39-b1f2-4dc5-970c-29d96c63b18b@amd.com>
 <c3a50dd5-d621-46ac-8cd3-d1fa5bed30bd@gmail.com>
 <9cd52b41-f9ce-49a0-9985-eb4eeff2a0ec@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9cd52b41-f9ce-49a0-9985-eb4eeff2a0ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1b867a-415c-4ff8-ddcd-08dbe0fba84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAKL9vwo/nxcWSERufU5dSxtgQozSj2S2JebRCoQAGrpMK2zfCgOoIP2v+z/bFJwid7yg3qP+/a8dnBdVQrRn9n3xqsjlG0Sfkp6oFmmHAb1CPvmlasyXjhxsZUQnuhfnmaM+5erPQHwPzAA9pN8f7md6bD1bZFSdVsGkc1e31rGNmt8DJD13WbSpv4YiMYSNyVuXDi/7RNl1DY6E9TbowL6ZnI4nFQdd0UcRsPXDeWdm4WFYo+n1SjHY/ZqOnkZF3OZFcbx9deAF5E7cmGtcRq5QJF15Kl2jCq7AXVz2nLG624cvYZrLUt9cYqo2Dy1CCn6onvDuAZywAPhWMInm0UJCSnn16QQeR0Az4pEyvdF6LcFrKTv7rViTPMi189uHVNnM1g2aFrkGL0D9KmDd/W82i94ggv/QkU8dLDe6YSmkw4icyqGTmyb9ySaUkExK5IUDoV+bjjjjXhTVtYc45D8Itrh2bun5IUh+qUYkooNPYrwEo6v4mjAVsQWNpUjK+tjkGzDwJl/EdqMG4Pmf3ADruAPLIOI//8WxeusZ2viEroGYmEOUz+midnFw1bjKsEEZb78nIV8YR7hKt6uEptvp9xSqEwICBJh/lmerpeoGkGKKX/lKIwzhZOw3bivuw/1I38oXucazC3/8C4Nug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(26005)(83380400001)(66574015)(38100700002)(86362001)(36756003)(31696002)(110136005)(66476007)(6506007)(8936002)(53546011)(4326008)(8676002)(6666004)(6512007)(6486002)(41300700001)(478600001)(66946007)(316002)(66556008)(31686004)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXBic3RUZ2ZvVWVJbkJidFRaVTcrRit4M2R1WkFOWWI1L3Bzd0liWDhyWmtT?=
 =?utf-8?B?bFVUWXY5U2V5SUt0a0JxVEVYL0NlOVNGbTR4TVRncHBCTm5GRE9GWS9ra0pQ?=
 =?utf-8?B?ZGY1M2pobi9aTjB4V0lMd1FPSlAvNEI0MVFYKyttRlNNbkxwbVhveXhnTktw?=
 =?utf-8?B?WGVrNXpMd3dzUTBxMlVtRm92YUNaY1ZZeTJrdm8zbFdrZ0lnMk1MbkxHdnQ0?=
 =?utf-8?B?YjYvVFJrRTBSM29DQ1VlbGtkZDRGRjA3MDhHNVNRTFN3TVhhK29XOHdkS0ht?=
 =?utf-8?B?SllDekpNaG9UMm1USVFyUGZYTW44WFFOTlh0bGpkelE5MFEyVlp2K21uNXpG?=
 =?utf-8?B?RXBZeFJLNzZDV2Y2bzA0L3NaQkl0c0JpdnZCTGd0dy9XakZhUnphK1R5VkZ0?=
 =?utf-8?B?Umo4QndsNU1lZWM0Tko0azA4Z0JPZDJRUDltZklhd0RORVY3dGpyUDErYUxH?=
 =?utf-8?B?WFVsNjY2MnZUa2NGK2VnaFdadzBqQ3VFMG93WjFLSVV2SlpOdEdiSEkwc1Jz?=
 =?utf-8?B?NDhvZE1SMWNRdEdxUTB2NkV5dW56Q2I1OTRYQkwzR081cjE4aEFINlRQMEZI?=
 =?utf-8?B?SUtMdWs3SmNuMkN0WlJWcjYxQk50bE8xRlQwcnlWanBOTkVnVXpydTlnWDlF?=
 =?utf-8?B?bEIvTndNaXhMbWlsZnYwTUYxMzNPQ0l3WkxKQXJ4dHhkV3pOWE1XS0RIbFdI?=
 =?utf-8?B?M2ZuSXIwVGdlYmhzRUNGSkVJaEY0THUyQXkwcUNOa3grN2pPdmVnZlMzRjFh?=
 =?utf-8?B?cWx2MkZsRktaSExLLzJNZHFCN0JEL2lSU1VwcHlwVFJSZklDRXhTbmROTFJO?=
 =?utf-8?B?MGNuZjZxdXNKT3pBaStHYkpWdVltRm03ZEdESXBnbERrR3FYWi8zQVdYc1lW?=
 =?utf-8?B?eUpxNG9SSkduUjlpa1pDL2lpclFCd2pLR2Nmb2lXRk9VdTJFbTh3cUE4TURY?=
 =?utf-8?B?ekVYMkVLVUVwbVZ2aDQybi9RRlJ1dkMrN2d4V1NVY2dPd1VkRXhEaGZtMHA1?=
 =?utf-8?B?elplcjl1d0dqeVFmb2krRm5OQitpKzM1bXhJaTNvaHQxekV5cUxkcnNwUnJz?=
 =?utf-8?B?clNTV25VVzBGQ1V4d3I5T0k1d2I3MmJPL21Ga2hkc25GMmZlcCtYOGhOR2Nw?=
 =?utf-8?B?L2JDTzJvQllLYnR4bllPRUFqYWg3S0l3R1FSZ0pjVDJHMlhnQ3h6d1M2Vi9a?=
 =?utf-8?B?OGRCKzV5RitLUEJXanE2SDE5RGluUW9WNlc2UlRpanZWdFd1M2dLWVJ3bjBu?=
 =?utf-8?B?ZFJiMHdMa0xRSUNkZTJ4RlBoTmtZck5WcFVEN3NpVHQzemVYcUxvYk93N0lU?=
 =?utf-8?B?SExBaXdCUHBpd2tLbkF5V2tuZTQ4R1A5ZDUxVFFjV25VSVJCSW0zNkxaQ3Qw?=
 =?utf-8?B?RWovc1dHQm9WMHU0OEdtNml3bVNRWVMvbnN2NW5aaTdlSStFdjFMNGtYcXlk?=
 =?utf-8?B?UzM2bklyekVmbHJHeGZBQnltRHZ5bzQ4Zk1DdmZMSkNvKzRFOGUwdmVYRnlj?=
 =?utf-8?B?UFMyWUpleUJVNjlzZTY1YXJ4ald3b0N4QkZsSFcwVGU4ZkI0dndlclZXRDFk?=
 =?utf-8?B?NWhnalZyYlNNYVZzRUo3elhNWDl6Q1Y0bkU0emE5d0dwMWl5b3hjOFVBTmw1?=
 =?utf-8?B?c1lENllIUVpXZEplK2x5blhObmd2R245VVZ4aGs3WEF0QVk0MnJYRGpSaHVL?=
 =?utf-8?B?V1VwUDNhdE5FSjZoalREUW54Y0RiQUt0VkpRbHdrdERJOGVxV2lVa0xGZFhY?=
 =?utf-8?B?SkFTMVQwckJEUEQ0MTJBLzRrL2VPb3V0LzdsYzJqcjBUem1KSm41aUU1Z2Rl?=
 =?utf-8?B?UUYwZlhxRnM0d20yNWdLTkY1Skx2RXdURERFY1JQcGliVmh4Q1c0a3JGdU5i?=
 =?utf-8?B?S2pqN3pQUU9iYk53T2ZOMHNUWVJuWW05dXVHN0xCVDdVQ0IrK1dwSHhtVi91?=
 =?utf-8?B?NUxORFdQeXEwTyt3STVwdDNrTzdFSVJVd2owVFRCNWVSM2pyai8zYjQ5T3Bm?=
 =?utf-8?B?UWxTdE4zMTR0UFl5STJBUGNvaFBDVVJRaTJkblk1b0Z4SnZ3ZGVFYSthUStw?=
 =?utf-8?B?bnkzM2Z1VUVjY3VXZ2dzNkFzT3NSQytrK3BKRWxxZitvdi9SK0NhYktKVldU?=
 =?utf-8?Q?M2cE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1b867a-415c-4ff8-ddcd-08dbe0fba84d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:12:46.9532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l+k7Dd/xmmRVC+kEVVeQijbeqGZGthBEMu2hCdFCyEP1enrSvTMTOXH1se3vFS8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.11.23 um 22:23 schrieb Felix Kuehling:
>
> On 2023-11-08 07:28, Christian König wrote:
>> Not necessary objections to this patch here, but rather how this new 
>> state is used later on.
>>
>> The fundamental problem is that re-validating things in 
>> amdgpu_vm_handle_moved() won't work in all cases.
>>
>> The general approach for both classic CS IOCTL as well as user queues 
>> is the following:
>>
>> 1. Grab all the necessary locks
>>     The VM lock + either everything inside the VM (user queues) or 
>> just the BOs in the submission (CS IOCTL).
>>
>> 2. Validate everything locked
>>     It can be that additional BO locks are grabbed for eviction and 
>> even locked BOs are shuffled around during that.
>>
>> 3. Update the PDEs and PTEs
>>     This can be done only after validating everything because things 
>> can still shuffle around during validation.
>>
>> 4. Do your CS or make the userqueu / process runable etc...
>>
>> 5. Attach fences to the locked BOs.
>>
>> 6. Unlock everything again.
>>
>> I think that is part of the problem why handling all updates in 
>> amdgpu_vm_handle_moved() for the CS doesn't work and sooner or later 
>> you might run into the same issue during process restore as well.
>>
>> If I'm not completely mistaken this should be solvable by moving all 
>> validation to amdgpu_vm_validate_pt_bos() instead (but let us rename 
>> that function).
>
> I'm trying to understand what the problem is. As far as I can tell, 
> amdgpu_vm_handle_moved just runs a bit later in the CS and 
> process-restore code than amdgpu_vm_validate_pt_bos. But it runs with 
> all the same reservations locked. My current implementation in 
> amdgpu_vm_handle_moved has some failure cases when reservations cannot 
> be acquired. I think your drm_exec patch series would make it possible 
> to handle this more robustly. That said, in case of KFD process 
> restore, we can retry in case of failures already.
>
> Anyway, moving my re-validation code to a renamed version of 
> amdgpu_vm_validate_pt_bos shouldn't be a big problem. I just don't 
> understand what problem that solves. Maybe it just makes the code 
> cleaner to handle both evicted states in one place? Or maybe you're 
> pointing to a way to merge the two states into one?

Well yeah merging both state into one might be nice to have, but that 
isn't the fundamental problem.

What basically happens during validation of a BO is that this BO is move 
to a desired place (as described by the placement parameter). During 
this it can happen that we shuffle out other BOs.

Now the issue is that when you validate in amdgpu_vm_handle_moved() it 
can be that by validating BO we shuffle out other BOs which then end up 
of the evicted list again.

This most likely won't happen with KFD, but for GFX CS it's certainly 
possible. So the idea is that we first validate everything and then 
update all the page tables and not inter mix the two operations.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>> Am 07.11.23 um 23:11 schrieb Felix Kuehling:
>>> Hi Christian,
>>>
>>> I know you have objected to this patch before. I still think this is 
>>> the best solution for what I need. I can talk you through my 
>>> reasoning by email or offline. If I can't convince you, I will need 
>>> your guidance for a better solution.
>>>
>>> Thanks,
>>>   Felix
>>>
>>>
>>> On 2023-11-07 11:58, Felix Kuehling wrote:
>>>> Create a new VM state to track user BOs that are in the system domain.
>>>> In the next patch this will be used do conditionally re-validate 
>>>> them in
>>>> amdgpu_vm_handle_moved.
>>>>
>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 ++++-
>>>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 1442d97ddd0f..0d685577243c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -232,6 +232,22 @@ static void amdgpu_vm_bo_invalidated(struct 
>>>> amdgpu_vm_bo_base *vm_bo)
>>>>       spin_unlock(&vm_bo->vm->status_lock);
>>>>   }
>>>>   +/**
>>>> + * amdgpu_vm_bo_evicted_user - vm_bo is evicted
>>>> + *
>>>> + * @vm_bo: vm_bo which is evicted
>>>> + *
>>>> + * State for BOs used by user mode queues which are not at the 
>>>> location they
>>>> + * should be.
>>>> + */
>>>> +static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base 
>>>> *vm_bo)
>>>> +{
>>>> +    vm_bo->moved = true;
>>>> +    spin_lock(&vm_bo->vm->status_lock);
>>>> +    list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>>>> +    spin_unlock(&vm_bo->vm->status_lock);
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_vm_bo_relocated - vm_bo is reloacted
>>>>    *
>>>> @@ -2110,6 +2126,7 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm, int32_t xcp
>>>>       for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>>>>           vm->reserved_vmid[i] = NULL;
>>>>       INIT_LIST_HEAD(&vm->evicted);
>>>> +    INIT_LIST_HEAD(&vm->evicted_user);
>>>>       INIT_LIST_HEAD(&vm->relocated);
>>>>       INIT_LIST_HEAD(&vm->moved);
>>>>       INIT_LIST_HEAD(&vm->idle);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 12cac06fa289..939d0c2219c0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -286,9 +286,12 @@ struct amdgpu_vm {
>>>>       /* Lock to protect vm_bo add/del/move on all lists of vm */
>>>>       spinlock_t        status_lock;
>>>>   -    /* BOs who needs a validation */
>>>> +    /* Per VM and PT BOs who needs a validation */
>>>>       struct list_head    evicted;
>>>>   +    /* BOs for user mode queues that need a validation */
>>>> +    struct list_head    evicted_user;
>>>> +
>>>>       /* PT BOs which relocated and their parent need an update */
>>>>       struct list_head    relocated;
>>


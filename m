Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063B1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 21:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375C410E1A1;
	Wed,  8 Nov 2023 21:23:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119F410E1A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 21:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odQ7Fz0IE6nuWJVHYDa3C/D9W9Xhfubsg1b6NCnaaQolTKigQhPa2D/rBo3TUHemZaDRP7z5UHgn4Iv6ilrMB/zpmvjAtw752OQvl/xvzj0gE6tmNMQjOCWtaraqY5CsZmMPoQgJECybu4KX/8WUW2GOuyy96zksccWNNvVGv/4r/b7WaRDoVxQ8ONe44U+Qxu+ldEhreSlZwV8CT21CsqzPaAEjVbXGvJ9xvdGB5/v7FEdUBw138226gjDzIM89Tqn5TfyqQXSBRVLdafps1f9MyRTPfl+3n6KjXGK7/OlYNdiVI8xzOYT9IA5ki9K0zMGoXV8xuj2lmeTL+o9QSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Eq7cfOlEijuPmy/7fbrGoWLNEMbK/lNe74XFw4waU=;
 b=KQuZWU76s8aX26kDeqe/pL9ukVHYl4Cxm5rHWCyLWrnImkpgOyOdW7fToCaTI22rpgGlCtS+07OCSjDWg+T481aygDorYah3xa9QBxZsdkZ+MijnkA+1V24rrXnfdG1H4Lkfv4ucWFOcksS5RMbPl28HPhI1Dpmzd/CXK4zAYcqxkkQAdgCTB/fQ2a5dmsGazD2JaooNebNA6ivQMEdRiLKMeTud6EsK5a6GjyWuv5GafcWGoSVB/P/mg9DK4QOXQOOERGzU50p883FrfKpNbafRw0EHxkM1RHXvA3nTdGbSqtNNm7hau9kz1YhmmU85DaKquVlJHIvZOYCH7XkLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4Eq7cfOlEijuPmy/7fbrGoWLNEMbK/lNe74XFw4waU=;
 b=QLapgSzxQkCxrZHgTT8gevFOtk2AMX6i+pFND4acbO2UHElYHwBHyCrWieI1KsCQP/SWGfmn4k8hrKFl6BQ5CeGQKlkuy/XGfzbeBwb4fk2SqqnFsluc+hmvPVJJG2d3K57QfMkOm6G4InlhbvrihCZiC3uPHndUgCoLjIQo2yU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 21:23:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 21:23:39 +0000
Message-ID: <9cd52b41-f9ce-49a0-9985-eb4eeff2a0ec@amd.com>
Date: Wed, 8 Nov 2023 16:23:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: New VM state for evicted user BOs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-2-Felix.Kuehling@amd.com>
 <8b63ff39-b1f2-4dc5-970c-29d96c63b18b@amd.com>
 <c3a50dd5-d621-46ac-8cd3-d1fa5bed30bd@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <c3a50dd5-d621-46ac-8cd3-d1fa5bed30bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e3ad46-75ba-44a4-dfcd-08dbe0a0f997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCuNY7LWOBgrSdpRfgGKc6QILfno2o2ZTsEvOTuHKG/3m/sogE1CI/T3Vbj6ufiq1s36nrYM6E0rlPKE38154VNUyuN9tWyxe7FbOV9lqprqxpdkNGx5h7ZJl05HttiziPT1X+VG//1hqCPtH1JhFZtX5SznxeEQ0zH51Cp+/oQSNDO/4FC5Cyh3jovy852kzPj+OxauO31a2sIDGCa4pZAEJs7B92J6SaXIIj9rnMBebAgE8A1jciz8l4M7GsWMWDoDxEEm+KVAykTcTKuYrp8znu35jluBnEjzHpqMFM3HuC9W5jz30yDrvEiIP8yd0ozbwcLgX1M85GDsGhYU4M+/KHF75yds3iZBwy+nC832p0EvP3fijAuQwPPWzy5r1oHjljMhSvPSAxyyzXuiszqatm39fTV5TUf0EjmoSwtr9Mbr4irk7xoXMG+rsLukULi9L3e4zex9BFlru7hw1an645SnDieHarzxpBa4COZf2tqTeP5YgUZJq3akrkE16mJGN+u9t/iXsUliYElZqJoABCH/4Hu4J8TlQC2S1eHtvPI4qKQbMAFo4yVSuZt2PJmwnnJxKG26EB3Ew4yEbMvnp/IM23HOOc9cRNzxIVEOEDw8+ZF0mu9DvbdrcpP4WB7aGAdD9Ky1XF3rvIbv8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(66476007)(66556008)(66574015)(4326008)(26005)(2616005)(38100700002)(44832011)(8936002)(2906002)(41300700001)(8676002)(316002)(5660300002)(478600001)(6666004)(53546011)(36916002)(6486002)(31696002)(66946007)(6506007)(36756003)(6512007)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxyY2hlMEZsVHIrazNFejFzaGRCTktnSHphMHRwRkl5WXFYWnZTWnViK29E?=
 =?utf-8?B?bkQrTmpzdUhKcWJQaWRLbnVuK2RxSE54Yk0yd1ZteFdIM01relBINzZEOHZq?=
 =?utf-8?B?OU05UTA4WmFHR3ViWTRHcVBRZnhHVFM0eTE0MVpFZkFBVnkyYXBSdDJHcTBM?=
 =?utf-8?B?TE9RajZ0MEVKTTVDc2lXdkZZWVdBd2N1NHFvRS9QTHBlck5hc201aU1jUlRm?=
 =?utf-8?B?V3lMK3krcjlHM0lqK3hqUXpEeVNvZ3g4dmFGT05OWlJQbHlRN2hpWGV3dUtu?=
 =?utf-8?B?bmVuNDg5dzkydTVUandWTDZ4NzYzaytEK3Y4Q3NTMEFQMWRFOEpFVjN3SWlE?=
 =?utf-8?B?UXQ0dm9yNGhNSEM4QU1ZNFdxRVNvWUQ5ZUIwQVhhb1l3SGdJbkNHY0FQbUlp?=
 =?utf-8?B?bE1MVi9sSlFKY0tFWGpDVEIrNWRsRDZEc3NjdXRwV0lpMllTZEZlWTJYUzJs?=
 =?utf-8?B?TDBGQWhGZ0h0eTBVWklNN0t6SUxhVVVsdmU5WnZ4M3JvOWdha1lhelFvODR2?=
 =?utf-8?B?cmlud3B5UXB3a01DNGsySEJ6Vy9UMUU3T2tKRE5pY2IvTDI2ZHRuUFRyZlFh?=
 =?utf-8?B?NW5ra0U2V1NFTDMzUytPeGhEajFFSXNiR0lMMDU3Q3N4ME94WE0vOHRMWnZF?=
 =?utf-8?B?bjNlSFNMTFRBK1Jzb0VHVFBHaVNXQXJERDVuMVp6S3lyU1JRdmRzRURDekNq?=
 =?utf-8?B?T0dpVDNwSld5RjRTNHd1eGNaNHoxOHF5MkNVVzBXVzVCNTgvWnR6ZUJWZUdR?=
 =?utf-8?B?RHd3N1dSSjI4ejBMaFUxQ3FYdkF4SkxLUkdWZlNnMER5T3k4R1NGekhVZVVw?=
 =?utf-8?B?bndyeU5XcTIyTElwYTAreWhyTkxHSjNhNHNUTUlmR3ZiSXlaUzA4QmVPSDRy?=
 =?utf-8?B?eWYrd2lDclRISlhCOFRVMUxzTlhoQmhIMy9RNzRHYUlJZ2lSczY3Zmh0SXo1?=
 =?utf-8?B?Z2wrTzdWWEFpZ1VrSzQxQXdOb0VjcmhVTTlyaGgySCt1REhTWkdNZ3BDV2FS?=
 =?utf-8?B?WitFMmhUUTk0LzU2VllmNmRTdHArZVpSYjRDblZmUUZsWTgyd3ZTekl4b2dW?=
 =?utf-8?B?c3hvdzNkUmwxWFNYTzBKdDRoazI1M1kzM200bWFUTUFXTHpPUmxQQ3hrL2dP?=
 =?utf-8?B?UFRxVkxNZFJXeWtWQlVzd3FEQzV0OHc1ZStnMHQ4WEhNUWVnL3FZOGRjZVpQ?=
 =?utf-8?B?UXJwUkh0UlBwczAxUnFBd09LS0ZIV2JtWk1SOGFtN3cvVFNyZG9jWHhPU3gr?=
 =?utf-8?B?V1BZZ1pRbEZ0c1psanpRYWQ2ZDBralVtQlpINlF6NjhqTThnZGJpTnJQVlg3?=
 =?utf-8?B?WGFNUkVSWEp3QTVWcmg2RFgveWdFdkNjazV5Y1JneUVTYWNGWjlpZzJoS3I5?=
 =?utf-8?B?VHNNTWQ3L2RiZkovUEU5Wk1JNkM5by94dDN4UHpsdmw2Y0pTWC96REp0VEhS?=
 =?utf-8?B?QjJXUWJmTkQ1cFFnYjhUNUozR284emhKMm1sSklMSEplbndiUHJtT2hDM3Mr?=
 =?utf-8?B?cGtiMjdERUFnYTRSVjFrWUV5aHpMTXI4UUJROXFhKyt0QUJCaGRRZHVqTWd5?=
 =?utf-8?B?SHJuU000UVZCeDZpRGNZWGlzbkRtYVhXeXpxMTVYMkJlcktPTi9JYVVKMTlS?=
 =?utf-8?B?QnRIaHVJNWZ4cS8rZGwyV1h3OU4zcnV1NHFBVWh2S2c3MnpzcXJ2L1hTTHJj?=
 =?utf-8?B?VWQ4eUdkQzlBNUsrZnVjVHNaVUFXa2FTNWtGOGFpQ1dDbHArTGpwd3pZQ1dh?=
 =?utf-8?B?OUJiWWhZcVhRWU0xWjEzOGVOcWxTNWFtTU14QnZTamRlcTNmd3hUQloxUGJm?=
 =?utf-8?B?ZWZITWtzZDVCYzA5bW1reG1QbW5OektLSkZVbE9uNis3dGhsbGU0L0cxTjhZ?=
 =?utf-8?B?eDlxa3krNHJMQWpWbWxiZnhOZ3EzbGZrU0NHZmRxU2lkZXJZZC9FbzNrcG1a?=
 =?utf-8?B?YncxY3lFc0VNSnd1MWVwRTJnQUFvU1dhcDhlKzR6b3dGRk01ZStMaTZNWHMy?=
 =?utf-8?B?TE41ZzNDR3V6VkhiUDZ6dnlFUmgwN1hJdXVha3I3ZjN4K1ZCazhRK2M3am1C?=
 =?utf-8?B?UzVrYUpzM0tQTWtuUlFlMXFMLzVUam40Nk5yVmV5Tlo4Q2RQZXdpdllJWHpn?=
 =?utf-8?Q?uv0y67R603V8RWy1oV0SPZMKa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e3ad46-75ba-44a4-dfcd-08dbe0a0f997
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 21:23:39.1607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FsBAoXGw6jh6o2z433N5hz22bmfm9QO9QTzAHAumtmXblYTH2E1KX4Cx/OzDEXxLMKl5WYdJwQP7p4hlnyJvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-08 07:28, Christian König wrote:
> Not necessary objections to this patch here, but rather how this new 
> state is used later on.
>
> The fundamental problem is that re-validating things in 
> amdgpu_vm_handle_moved() won't work in all cases.
>
> The general approach for both classic CS IOCTL as well as user queues 
> is the following:
>
> 1. Grab all the necessary locks
>     The VM lock + either everything inside the VM (user queues) or 
> just the BOs in the submission (CS IOCTL).
>
> 2. Validate everything locked
>     It can be that additional BO locks are grabbed for eviction and 
> even locked BOs are shuffled around during that.
>
> 3. Update the PDEs and PTEs
>     This can be done only after validating everything because things 
> can still shuffle around during validation.
>
> 4. Do your CS or make the userqueu / process runable etc...
>
> 5. Attach fences to the locked BOs.
>
> 6. Unlock everything again.
>
> I think that is part of the problem why handling all updates in 
> amdgpu_vm_handle_moved() for the CS doesn't work and sooner or later 
> you might run into the same issue during process restore as well.
>
> If I'm not completely mistaken this should be solvable by moving all 
> validation to amdgpu_vm_validate_pt_bos() instead (but let us rename 
> that function).

I'm trying to understand what the problem is. As far as I can tell, 
amdgpu_vm_handle_moved just runs a bit later in the CS and 
process-restore code than amdgpu_vm_validate_pt_bos. But it runs with 
all the same reservations locked. My current implementation in 
amdgpu_vm_handle_moved has some failure cases when reservations cannot 
be acquired. I think your drm_exec patch series would make it possible 
to handle this more robustly. That said, in case of KFD process restore, 
we can retry in case of failures already.

Anyway, moving my re-validation code to a renamed version of 
amdgpu_vm_validate_pt_bos shouldn't be a big problem. I just don't 
understand what problem that solves. Maybe it just makes the code 
cleaner to handle both evicted states in one place? Or maybe you're 
pointing to a way to merge the two states into one?

Regards,
   Felix


>
> Regards,
> Christian.
>
> Am 07.11.23 um 23:11 schrieb Felix Kuehling:
>> Hi Christian,
>>
>> I know you have objected to this patch before. I still think this is 
>> the best solution for what I need. I can talk you through my 
>> reasoning by email or offline. If I can't convince you, I will need 
>> your guidance for a better solution.
>>
>> Thanks,
>>   Felix
>>
>>
>> On 2023-11-07 11:58, Felix Kuehling wrote:
>>> Create a new VM state to track user BOs that are in the system domain.
>>> In the next patch this will be used do conditionally re-validate 
>>> them in
>>> amdgpu_vm_handle_moved.
>>>
>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 ++++-
>>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 1442d97ddd0f..0d685577243c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -232,6 +232,22 @@ static void amdgpu_vm_bo_invalidated(struct 
>>> amdgpu_vm_bo_base *vm_bo)
>>>       spin_unlock(&vm_bo->vm->status_lock);
>>>   }
>>>   +/**
>>> + * amdgpu_vm_bo_evicted_user - vm_bo is evicted
>>> + *
>>> + * @vm_bo: vm_bo which is evicted
>>> + *
>>> + * State for BOs used by user mode queues which are not at the 
>>> location they
>>> + * should be.
>>> + */
>>> +static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>>> +{
>>> +    vm_bo->moved = true;
>>> +    spin_lock(&vm_bo->vm->status_lock);
>>> +    list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>>> +    spin_unlock(&vm_bo->vm->status_lock);
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_bo_relocated - vm_bo is reloacted
>>>    *
>>> @@ -2110,6 +2126,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm, int32_t xcp
>>>       for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>>>           vm->reserved_vmid[i] = NULL;
>>>       INIT_LIST_HEAD(&vm->evicted);
>>> +    INIT_LIST_HEAD(&vm->evicted_user);
>>>       INIT_LIST_HEAD(&vm->relocated);
>>>       INIT_LIST_HEAD(&vm->moved);
>>>       INIT_LIST_HEAD(&vm->idle);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 12cac06fa289..939d0c2219c0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -286,9 +286,12 @@ struct amdgpu_vm {
>>>       /* Lock to protect vm_bo add/del/move on all lists of vm */
>>>       spinlock_t        status_lock;
>>>   -    /* BOs who needs a validation */
>>> +    /* Per VM and PT BOs who needs a validation */
>>>       struct list_head    evicted;
>>>   +    /* BOs for user mode queues that need a validation */
>>> +    struct list_head    evicted_user;
>>> +
>>>       /* PT BOs which relocated and their parent need an update */
>>>       struct list_head    relocated;
>

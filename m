Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB31C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 16:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D810810E68A;
	Wed,  8 Mar 2023 16:38:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9186510E68A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 16:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuRHDFayaQJ0HBpGmOAr0XRl09QnHR1RnqrBfBk+EdKdngAORoBt9Ps1EDWUkm8ZoQpRtbbzwxOZoHPWSGR2UVhg/YCLCsP1fabDhxKeeIB70LAfAkpL+1d4lOQiWwj9CZKQnd/jfRZ8xiVNekxQW4IY1rWxfzQc/3KcqWFY0Qhk8QebOYWifGueEekriAX41+tKup6bPSOSnFCFsNOol30MsiNqgf/TyonPZXRO+ShghQyeYQLsfRCQOMLpJ4ofMFRIoy6BoUX9PvopY5S15UN5LMwaPAIFO4zmh0nYt3ndvzIWD80jZJAATeXkv15+/VdIAPrnlCJ+72AIG6gmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2HLmVdpAg66yuSstLBUAHvkAskVY71ijUYrnA3pLOI=;
 b=Tt9mjekXPaCaXmKzMZsv85NajlbhqWG9b0yisz5FEHA4qaHSTFwTIJp266D6rOuW7eAOZ+vgYmKveV7v6+B7OxFp9++e4mTOS059hJaLieAoUctPX0nf7C17qSzB51FxNoz3jz/tH3awYRfOzYEBuBNOIor1e9S0vyZL4GQBS1LbzyAOa6KviuU4o41DBgUXC2Sjay1gSya0XyYDrKMQvkeMCHbZ5Xg4+iSonj0UAhFqzkyoSm8Q+9b7l/Zn0jtkxVTkTGTJYV5yehe6lMbQSpX8ERYNw2eY2PuUdm0Wx8leAz/8M5iIXo/IlNzeU8bvoAH95RmzEfU7x/1B4tre5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2HLmVdpAg66yuSstLBUAHvkAskVY71ijUYrnA3pLOI=;
 b=gYZskS5LOtcAKwzCCpGtju+okGhQILIUkPnC6L+hUkMnKZCwLLdPOqmPGHmhWcyTbHfJHq8IKKykjcXnM1GdqTG9j7SzWfbAgArZHTaF1Plzvir5wYs+dmRkOikTnOPZ6++WZjHNeJa08lIC0cPZV8dw8ArRIt2o4d7LPpFZXN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 16:38:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 16:38:09 +0000
Message-ID: <0e990638-962f-2bce-6359-21197d4d1951@amd.com>
Date: Wed, 8 Mar 2023 11:38:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Belanger, David" <David.Belanger@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230306215808.2903387-1-david.belanger@amd.com>
 <92f89f03-dfa8-0f50-309c-69c7c22541d8@amd.com>
 <DM6PR12MB482867775D93C72A95ED5C3099B79@DM6PR12MB4828.namprd12.prod.outlook.com>
 <b38285d6-c7c5-3fa3-1cda-0fc8b430feb1@gmail.com>
 <2c36c501-652b-4535-8507-ca9b1f1045b7@amd.com>
 <2d7565f5-8ca2-feff-2619-3c7942fb653a@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <2d7565f5-8ca2-feff-2619-3c7942fb653a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::37) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e65049-54bc-4cbe-3829-08db1ff38083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfC/WJV5QKugGTNnmwVA1pgseglF2E9Zj/tq1EGwzvAACRZ1C7VS7hV1/Cn5xGCrCa0oDkMFBDP6GLmdncMrGgbxFcfPc+EWziYCvYLV23K+FYmAlrIXgAlzT4RKdSEyjkrARZXkocDPddU7M/BA6XqdEebl+Kp3Z6KyboEJXBRuP2+hlsNDKypqIy6iNwqwKT0ApuNlUuav9ytrtvDUuBLGCYnCJuXuxaCQKHmi3GDb+zZg1Dyt4xDXP8/O+/KpzeXzZFTCSaw1F5KBy9gt0ZNADex3FiWIu8VSs4qSlj6unIKyB+D9OfjagVnriXUduGiQfyQyzylCWZPXeKgubqrx56+hGxUuuH9c6ycPY8zvyjK4OhLTPOpbog1WOCZ+qndwj1xo97VLnpZqL7IQ1i7nfUYW+UGW7H3rBPKIUOgkh8O6dgBZ29C33A7dNHjVpdOGt4XkHvCNdE0G/oTMgS33zU6+WNizFqHpMsXJvfuxguuBEi2+PmEWLstdEgV0+O9tBOs6nJCZ8bwG6xcUgB22SUg9U+XMBdk35bkrLkBbS4E2034tJkL72VX96qBSHWN3A0Lfgj0t510qLTT8v2qJLRU1Zu9/udaxlA8p9V+eeVg4B5QUiejcoe1GvaR9I7kimqgnud5nKd/7tnsdU2h+UVYX0aFTEfjAJzmpwHOPtGtDxlSO9qPyyYs7IzfVhBjUDQvX0daop1aah9P2BZl8y1e57Ovqss6Qe6TyYpaYJtAdHwxtzo2MZqKNYIqq2J6orT8o2i8RGs2bjo79tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199018)(31696002)(66476007)(38100700002)(86362001)(66556008)(8936002)(36756003)(8676002)(44832011)(5660300002)(66946007)(41300700001)(2906002)(6506007)(26005)(186003)(2616005)(53546011)(6512007)(66574015)(83380400001)(110136005)(316002)(36916002)(6486002)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmVyR2FUMUZ6b1BSbWZtTzc5cEp3dmo3bzA4emZ1Nk5CY084c2VsR0NUOXlE?=
 =?utf-8?B?SHpJTGE3dUNzS0FsMnVvS2RqWSswcEU1UW5WekZKRzlwRlNVNnVOT0NrczlT?=
 =?utf-8?B?U2I0SnpzZTFrWW82aGNMVkU5RWQ0alBKVVVxdzB3OEVTWklPU0ovQzJUenFX?=
 =?utf-8?B?TXJJVmp3a0kwN1d5R3dvaXhoZ2FJZjhIMG1rY0FCYzE2LzVPMTl2eXpaUzN0?=
 =?utf-8?B?NHd4MFdjdXU1dlYrQjlHRXJ4UVRhSWhaano4T21XeGRnL281UE1oUk9TMERw?=
 =?utf-8?B?ajBmUURsakVpV0E2N01qTE5vMk8rbU9wMUFoaHJyTWRBSzI5RkV6WHVEWEJN?=
 =?utf-8?B?S2xwNVlZc01BdFZkMDV5cDhEditkZDhsUWRkU2NPVnA3bzVRcnA0L2RIcVM5?=
 =?utf-8?B?aXo5QXR3My9pK3hrT2F1WjdUY0VmeUpJMDVMQ2R4aHVlYlhGTm56ZmlwcVpy?=
 =?utf-8?B?UjJYR09KeVpnYXlQR3hYaHlaaUpKY0JhOGdISkdBSUNESjB6Zi9HT1ZscnBs?=
 =?utf-8?B?OE4zMDZ1akJsRkxlelY2Ny9sNEhxL0hNQTVSREtwZWUrZTAwdkVWT1BROW11?=
 =?utf-8?B?UmxRN2prVjBrV21hYVZXekFjT0JUOHV1NkREY1J1R3dFZk9kMTF4eXgyQWdW?=
 =?utf-8?B?RWRxS3gvVXlhVDBTT1NkOE1SRTJEeGV3QTg3L0s4UUxJRkg3aFc1cnBtRmE1?=
 =?utf-8?B?YldIeGQ4dVl6SSs1TmNadFVaVi8vZjl5b080ZTQzTWNmRFVRL1BGWmRaZVhy?=
 =?utf-8?B?U2cydll4UTRPR08wM202SmNPYkN6SVAxUDcrMTlqeXZRL3p6aXg5d200YVRD?=
 =?utf-8?B?d0xxVEpCNks2TjVDd3hLYyt5TlJmYThvQjRhV2x3cGgyYU4wYnN6amQrMWJj?=
 =?utf-8?B?WU9TUDNORlZBRXc4STRpREQwSC8xOGdqb25BMUN3bGtXZm8waDZjUEZFU09l?=
 =?utf-8?B?NWJvc2hEQlBKMmlSN3NBRktWaitoS3FrWXR4VWFTMDZsZU9rZHVzN3luV3l2?=
 =?utf-8?B?aEgwZzRTbC9UOGtHbUFPdXZvdTJiclFSZmZPTlBvd3VFNXY1dm9aWEYxSzRz?=
 =?utf-8?B?dkdxSVd4SFdpVml2VVBvNG10UVFNYitKV2czRHc2YmxFU1R4RGtZYlN2VDcx?=
 =?utf-8?B?dkRoRlJCZzVnK2d4ZjlqeXBsR2YwSENsWHlxNUYrVjhrNkZyNFlXcnI4MTJa?=
 =?utf-8?B?TWtCbzhsNzNuaDIxMGwxSXR3Q0hJUlR6RDk5TDFjS0FVZDlXZ3JvOUJPSjFI?=
 =?utf-8?B?SUNUQXZLbkpMWmJTN3NVbk1CaitzbHJrOGpYNWtvb2ZQdkpOUTU3UmV0TGRm?=
 =?utf-8?B?Z0VaNDlzTFM0ekY2ZzJoYUQ0MVBFZ2V3ekRxODdnK3JsR0dUUnpobnhnUUxC?=
 =?utf-8?B?OUc3WlZ5YW84Ti9DZkI1aENjaGV5VW5VOXl2TlhxZUF6U3M2a3ZramJhK3FY?=
 =?utf-8?B?YjRkTzRiZUVYcVFYajVnV2tXMFB5NEJiSjZXd3FWaTY5bW4zNVBCYTcrK1RK?=
 =?utf-8?B?UTJvT1lIQnNRVU5EOUFYNFVDUXVBK0YrdDdXSTgwMmhxanJoQzFuWXlBbFNv?=
 =?utf-8?B?YXdyN1gvRStGaVRya01Gdk1jUmN3dzhtTWcvK29lZzRWMm42eFJrNUcvTGg0?=
 =?utf-8?B?cUxXbDVjYnFDdDlDLzhoWWRWdElSTnNUdURnVjNFc3owWXBUZ3ZwYWFTTlVM?=
 =?utf-8?B?QnhscTNSb0JmSFVaRStnZlBCZFFqOXJEblJYWWRSNnRZc0xtQ2JNRnRCejZT?=
 =?utf-8?B?VlZzQUhQV1ExT0hsb1pWSVhHZW5UaTVEa1NCUmFGdWNua2QvRXhWdlRDdHkw?=
 =?utf-8?B?bHN6eVJXK1V4eG9uTUQwZFJEMCtyV0pxWC9TR1V0VWdFUE56WXQxUFg4SEZu?=
 =?utf-8?B?VmJJakJ0dk1KcXZwVUg3S1NxN1NRUlpIUjY3YmhUVDZjczJSU1hkREhlbE44?=
 =?utf-8?B?VTZyM0NORUFCbmhHSzhZdGFTT1dKWUc4OW1DWkZwcHZQRkl2M2NTbC9OOEZD?=
 =?utf-8?B?MVFrRGp5ZG5IWXNjWXZJNU5nTGRTSEhlV0kzR2I0M2t4VmRJSGQ0ajRFNUVw?=
 =?utf-8?B?M0VRZ3NqT1JFY1FtaGlNblBrMTJCWFRzdW56Ym1RVWh2Q1NWeFc3NjNubHFO?=
 =?utf-8?Q?d52Phxc4evQ7tmM5Aw0x8U5cI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e65049-54bc-4cbe-3829-08db1ff38083
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 16:38:09.7904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJtGPBOExPAiOve9ArOfRnqwd8keHEUmKORbVCYtxNN+1n8tgTxZK6gMFjaAfiriFjOjwRQMUDrZruv5Z20D/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
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

On 2023-03-08 11:20, Christian König wrote:
> Am 08.03.23 um 17:17 schrieb Felix Kuehling:
>> On 2023-03-08 04:07, Christian König wrote:
>>> Am 07.03.23 um 16:28 schrieb Belanger, David:
>>>> [AMD Official Use Only - General]
>>>>
>>>>
>>>> The test case is a python program that will load the driver, do 
>>>> some operations, then unload the driver.
>>>
>>> What do you mean with unloading the driver? Removing the module? Or 
>>> destroying the device?
>>>
>>>> When the driver exists, there is still the python process space 
>>>> around holding on the address space.
>>>> When the python process space exits, the mmu_notifier gets called 
>>>> but the driver has already been unloaded.
>>>>
>>>> The goal of the fix is to address case where there could be 
>>>> outstanding address space / worker threads for process
>>>> cleanup that needs to be cleared/completed at exit time.
>>>
>>> Yeah and when the module is unloaded this is a completely futile 
>>> effort.
>>>
>>> The general upstream approach is to take references on the struct 
>>> device and module and prevent unloading as long as those references 
>>> exists.
>>
>> That's not how it always works. In case of RCU callbacks, the 
>> documented strategy is to use rcu_barrier in the module exit function 
>> to ensure the grace period and all callbacks have completed 
>> (https://www.kernel.org/doc/html/latest/RCU/rcubarrier.html). 
>> mmu_notifier_synchronize is meant to do something similar for pending 
>> mmu_notifier_put work 
>> (https://elixir.bootlin.com/linux/v6.2.2/source/mm/mmu_notifier.c#L1116).
>>
>> But this implies that we need to call mmu_notifier_put for all the 
>> MMU notifiers registered by the module first. I think closing 
>> /dev/kfd drops the module reference count, but the MMU notifiers we 
>> register for process cleanup persist until the address space is 
>> destroyed. We need to trigger that cleanup for any processes that 
>> still exist in that state when the module is unloaded. Or we need to 
>> find a way to increment the module refcount for every process that 
>> registers a KFD cleanup MMU notifier.
>
> The later is what I've meant. Cleaning up when the module unloads is 
> certainly possible as well, but harder to get right.

I think we can get the cleanup right. I suggested a strategy to David in 
my code review.


>
> And I don't really see an use case that we should do the cleanup way.

I'm not sure it's a question of use cases. I see it more as a risk 
trade-off. If we manually add module refcounts for our cleanup notifiers 
(try_module_get(THIS_MODULE)/module_put(THIS_MODULE)), there is a risk 
of leaks that could prevent module unloading, or underflows that could 
allow the module to be unloaded too early.

I guess this particular test (app trying to unload the module after 
using KFD) would just fail if we add module refcounts. But I agree that 
this is not a valid usecase.

Regards,
   Felix


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
>>>
>>> The device might be non-functional any more (because for example of 
>>> hot plug), but the driver should never be unloaded before the python 
>>> program exits.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> David B.
>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Tuesday, March 7, 2023 2:05 AM
>>>>> To: Belanger, David <David.Belanger@amd.com>; amd-
>>>>> gfx@lists.freedesktop.org
>>>>> Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module
>>>>> exit.
>>>>>
>>>>> Am 06.03.23 um 22:58 schrieb David Belanger:
>>>>>> Handle case when module is unloaded (kfd_exit) before a process 
>>>>>> space
>>>>>> (mm_struct) is released.
>>>>> Well that should never ever happen in the first place. It sounds 
>>>>> like we are
>>>>> missing grabbing module references.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Signed-off-by: David Belanger <david.belanger@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 57
>>>>> ++++++++++++++++++++++++
>>>>>>    2 files changed, 61 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>>> index 09b966dc3768..8ef4bd9e4f7d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>>> @@ -26,6 +26,9 @@
>>>>>>    #include "kfd_priv.h"
>>>>>>    #include "amdgpu_amdkfd.h"
>>>>>>
>>>>>> +void kfd_cleanup_processes(void);
>>>>>> +
>>>>>> +
>>>>>>    static int kfd_init(void)
>>>>>>    {
>>>>>>        int err;
>>>>>> @@ -77,6 +80,7 @@ static int kfd_init(void)
>>>>>>
>>>>>>    static void kfd_exit(void)
>>>>>>    {
>>>>>> +    kfd_cleanup_processes();
>>>>>>        kfd_debugfs_fini();
>>>>>>        kfd_process_destroy_wq();
>>>>>>        kfd_procfs_shutdown();
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> index ebabe92f7edb..b5b28a32639d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> @@ -1181,6 +1181,17 @@ static void 
>>>>>> kfd_process_notifier_release(struct
>>>>> mmu_notifier *mn,
>>>>>>            return;
>>>>>>
>>>>>>        mutex_lock(&kfd_processes_mutex);
>>>>>> +    /*
>>>>>> +     * Do early return if p is not in the table.
>>>>>> +     *
>>>>>> +     * This could potentially happen if this function is called 
>>>>>> concurrently
>>>>>> +     * by mmu_notifier and by kfd_cleanup_pocesses.
>>>>>> +     *
>>>>>> +     */
>>>>>> +    if (!hash_hashed(&p->kfd_processes)) {
>>>>>> +        mutex_unlock(&kfd_processes_mutex);
>>>>>> +        return;
>>>>>> +    }
>>>>>>        hash_del_rcu(&p->kfd_processes);
>>>>>>        mutex_unlock(&kfd_processes_mutex);
>>>>>>        synchronize_srcu(&kfd_processes_srcu);
>>>>>> @@ -1200,6 +1211,52 @@ static const struct mmu_notifier_ops
>>>>> kfd_process_mmu_notifier_ops = {
>>>>>>        .free_notifier = kfd_process_free_notifier,
>>>>>>    };
>>>>>>
>>>>>> +
>>>>>> +void kfd_cleanup_processes(void)
>>>>>> +{
>>>>>> +    struct kfd_process *p;
>>>>>> +    unsigned int temp;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Iterate over remaining processes in table, calling 
>>>>>> notifier release
>>>>>> +     * to free up notifier and process resources.
>>>>>> +     *
>>>>>> +     * This code handles the case when driver is unloaded before 
>>>>>> all
>>>>> mm_struct
>>>>>> +     * are released.
>>>>>> +     */
>>>>>> +    int idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>> +
>>>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>>>> kfd_processes) {
>>>>>> +        if (p) {
>>>>>> +            /*
>>>>>> +             * Obtain a reference on p to avoid a late
>>>>> mmu_notifier release
>>>>>> +             * call triggering freeing the process.
>>>>>> +             */
>>>>>> +
>>>>>> +            kref_get(&p->ref);
>>>>>> +
>>>>>> +            srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>> +
>>>>>> + kfd_process_notifier_release(&p->mmu_notifier, p-
>>>>>> mm);
>>>>>> +
>>>>>> +            kfd_unref_process(p);
>>>>>> +
>>>>>> +            idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>> +        }
>>>>>> +    }
>>>>>> +    srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Must be called after all mmu_notifier_put are done and 
>>>>>> before
>>>>>> +     * kfd_process_wq is released.
>>>>>> +     *
>>>>>> +     * Ensures that all outstanding free_notifier gets called, 
>>>>>> triggering the
>>>>> release
>>>>>> +     * of the process.
>>>>>> +     */
>>>>>> +    mmu_notifier_synchronize();
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>>    static int kfd_process_init_cwsr_apu(struct kfd_process *p, 
>>>>>> struct file
>>>>> *filep)
>>>>>>    {
>>>>>>        unsigned long  offset;
>>>
>

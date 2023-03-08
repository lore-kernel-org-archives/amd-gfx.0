Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD227C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 16:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3F110E62E;
	Wed,  8 Mar 2023 16:17:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA8210E62E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 16:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mnxemg49DFw/3G+FrFgYFMeUt7bNp0T84FqoLsHLSKxmg/eaFgDRv5FyueHxv1U+RBzKBTfQ9w5PKzIeMucqp+KDhqgJMA5knwc7uV492BlNmuK1bDuKfSXvHui0+bJ023zrDYiZPrbdbbCDW8UpnoVL7ZzXDPfadYKc9daB8PvUr2p8K32HLHlCEWv/dTUEa9KvzjClws9Zyujz2Or18goYIPui8fXRG0qyhoVd/zZFLc4UzcXUuaT7UlaIVtAvmWiNpZYRJW0baPXVKtw5KcwtnHfxj4oBjxdBH/wTdXwDxlmr93hh3pV3mMaAc0PYbMJXXa/HGrn2g0ONxMStqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrAk1rofty/KFEpvaGMvdsYgzUdGh5IfwEQc7cX8DkI=;
 b=aY/+HJVryJ/iGOKdA6V9RCcro9Q9OnD5BxmkpE6nig787GE1zhvbfFANhMvakz6WCxZ+Gu87rnTDFzNs35jdB1VbtxjRifb+A2o/cSmNf4wcfX4RVdmXCWoDPTdS0zYVRprH/T6xbp4/h+YIev26CxwhWzwwyvPIcNwKj06BZm1fZlh77AU46JUlmyMtW59+ksTnXxwtta2k5JJX/AMIEGL0AnyVuwWbO0IwMpH3Ufqpi5R6vpSGSfQ8vNZoSM7ZS4sDzMcUR8i2PiHGmpY/80up97NyX2pDe6gEmQoPTQqDujGlDVwhM9PK72C7r7g9ABCZgHTh+L/YAq0gDVP5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrAk1rofty/KFEpvaGMvdsYgzUdGh5IfwEQc7cX8DkI=;
 b=YY+wSJuvVLNzbj7KVk5VHdjLa69EZnl6NpMWgWLnmo7cOvFK9N1vmCVCi6nL6ElAuV0A2b3f/UFO8sj2Df/og6lGIP94p3mJS5+TbZH80xLYteRC5G1hFI2QNvxJrODJDph6pt9dg3/7POACruj08odmKKG2oPkzYCvMme4vMCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 16:17:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 16:17:30 +0000
Message-ID: <2c36c501-652b-4535-8507-ca9b1f1045b7@amd.com>
Date: Wed, 8 Mar 2023 11:17:27 -0500
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
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <b38285d6-c7c5-3fa3-1cda-0fc8b430feb1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 77487f50-faff-4095-60ee-08db1ff09db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5A+JFYDJOjwAaXf6z5ZAJI0bmSADTCCpyEHHtxJWXp+fBr71P1963OH5HfaRyW/YZSsgDqTXTXFSUp9qB3XzC3oLG7tThTiwxYzACpegJnZZydpuEtCdIXXYS5wEsftAEtTF7Hfddbjd1FFZbEx505AnImfIFZZIRtCUg0KChQgEGAAkoNsFoY5QFC3joO8pG1kuNF495iVZXvC0ItXylRUXOXgCtmO2ZDmeUhgFEtMFYDeyMdeB7pNcYtM2XJwRWeL1fHn2CxT1xAtho1rLcD8N3aKAe21OjurfNuhQPMP0Yku8NgQKZh0ugpO3cYrlZjfDzOrmZsiRB9doK1TWfV59OH/8Gc5Mxvs7CFyszY2ANiDoUiAyoaiQcvx0fCD8hNNeMNrFU3mk+WJoIQNfmoZr5IRkd+uFVxKW2+3APRok7I5hq7+NrBPNSJCFwCLRG6YEzYrh37N5jFiUU8YF9dsXjt5Mimqv4VX4JIJa3ScdB7M3Zf41m5M91MamoGBgMrQbVi1Hqe8+BuhxzZ/lFn+riL68YuuX8T/Fgei2qiyMSvMIgoczWlQs4t83dEo7jaYLnyW9yP4/KqtLr2qrUzOXDzmzM35hHqLRTnYwvZjOa/Gx28AmqRJqxv9a4p3myaVb+TDDdtk1RtAh1jRbztRKtr4qar+48PKfznEb/78IE2cvydl9y4oisvcsBv0z94ixgr5iCfFYVWSpwSvMVnw8m4mWBuBAebcsNqM8g/4710ydssKS2GxG1fcZSfqTOa/x9g8Hnso3vcRSJ6CNgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199018)(36756003)(110136005)(316002)(6486002)(478600001)(8936002)(5660300002)(36916002)(66556008)(8676002)(66476007)(44832011)(66946007)(6666004)(2906002)(186003)(6506007)(31696002)(38100700002)(86362001)(2616005)(26005)(41300700001)(53546011)(6512007)(83380400001)(66574015)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWtBK1ZpdEdhaHpQSG9LcHpDL2RpZ29xQjNiUS9ZcEVmQ2d5OU81VGNTOUpE?=
 =?utf-8?B?UUdhYmJrZ0hTZzQ5UXpJbW8vYkFqdlFhRitCbTRUNkFvZU9BTjd5K2RMaUs0?=
 =?utf-8?B?NytuSkZyT3pGLzg1QkNpVitkcEtPQStZNnNBVzFILzF4RWMrSnRWcGVqY0Zh?=
 =?utf-8?B?T2NOam01RVhuTk5RclVrbGtnZE81VFFGNGpsUUdzaWtKYTl3T2dTRHI0TStV?=
 =?utf-8?B?MVBvcnE3ajFITmxlandVWW1sZy8wTFl5blVlQjlnZ2I3QS9aQ2VxNkV0Qkla?=
 =?utf-8?B?RVB1RzduQnl4ZzU2dEpnVG9CQ2VxMVN6cXoyVXl6SlorWGF0cElJeG9iZ3lH?=
 =?utf-8?B?MHNDWGoyQzRtNmMvK1RlQk5JWXVpaitqWk5SalQ1WEtMRC9wcUNxWitmck5H?=
 =?utf-8?B?TUtrUjlSbmVsdXozN3Q3ak0ra1dpT1M0NEd2TCtCbjFmYTV1TktPZU5mbldG?=
 =?utf-8?B?TjI0cWFScGpvUUlhbHVlelE5TVU0d3ViaHlPQnRSbkNacDlNdHdLLzRYdlpj?=
 =?utf-8?B?a0NVdkVERVFLRnFLU3IvUlV5TnkzMnpWOE9aTldpUERnTHFQT1Y1emxuZzhB?=
 =?utf-8?B?Mm1DMWt1L1hBcS83WElPQmpsOEdLYXZxb01KbjRGUlMvdkZ0NVhoOUZOZTV4?=
 =?utf-8?B?b0NUaDFrRi9LdllHM2hkRWZWN1VUOVkrNDVSaWRwWm9lazJOMWxKa2F3bUp5?=
 =?utf-8?B?RU0yL004RHZTeWttOE9PRUtWc2E2QVF2empxWXdUTFlpT3ZyOFpXM2IvakxM?=
 =?utf-8?B?d3V0bXErM1hRQmJUOTc1bEh4cTUrZVhzV0dLTFVYZk9kZzBvcEtNNXlzdGo5?=
 =?utf-8?B?Nm02eUI5RG1ud2REcHFHSHZDSHRvK2NWU2hXWWp4d2JWU3VKemRGTkVwY3lr?=
 =?utf-8?B?alRtWjg4Q05OeEpiVVhZSEpPeWxXM0xURWgzMmtpVHgxMGMxdUpCbW9KSmRJ?=
 =?utf-8?B?YXgvY05oSERrK0lRSmJ5dVZCd3UvR0VuSDdRa0tmYWxEMWNxQ0RFdUtqSHlK?=
 =?utf-8?B?RlA5VFNwcUNzSTd3UjlOYXJWem5uSDh0VjllenZPQk9jcmVQZnM3UUI5YlNv?=
 =?utf-8?B?VnA4NnlZeVZTZEdoMzltZUdPdXFrNFczbTRjL0puODNIZFZSekEzdGFpNSs4?=
 =?utf-8?B?N3ozejBOOGlsUkRsMCtlQkJhV0lINDNCQXF0WFdBcXhXL0xKWmRkWjhFbmFZ?=
 =?utf-8?B?OW0xcXZJcGV6S1NYUmpaL2cwRm8rNHJSQ3JIWEhXcXlGcHhNamNmNHl2SURj?=
 =?utf-8?B?Y2taV2wxNXlZYWxKNzVLalZEdVpJcm13YWhPYmdwMnhBQ09WTkZQVGlmOENW?=
 =?utf-8?B?Z1BpVUV1azgzRVdCbUhhL0xwUHZZc0tESHBqRUhjLzRLTWxCNElHUk1qNm1W?=
 =?utf-8?B?VnFiWXgrS0RsM0E2T1dJK3MxNkkwRXJzN0NWYTViQXpzZ0JuTTduNzF4dm5s?=
 =?utf-8?B?SU94STgvNGJaT2c4OHBGWFFXZXZmTTgxaTUvK2RsWTJmdVkwY25oSDc0Qmls?=
 =?utf-8?B?a2xNTDNwOW1uSnREclkzOThVSXpKR24wZUJDMUxtcVhmL0xYY0pzblFJREVw?=
 =?utf-8?B?L3p1cWlLNFQ1QVhEd24vcjBUTGJ5RnZLZER0U3g1K1dBeERuRjVZaXl1bm1t?=
 =?utf-8?B?aFJUTzFHMDlwWHowU2lOK2U2czRBcHVJRmNwSGlJTlhsQ29pcDlvbCtObldm?=
 =?utf-8?B?UDU2VmlXQ0h5alVxREhNTVNCYkhqZFJyckIrMXRqL0dYcWdTTUs5OVdteVNy?=
 =?utf-8?B?Zlg1bUltcFI3WWRsOExzREd4ZTV1Qk9pdlJucEhxQThHYVVHekVyeWlTMnRn?=
 =?utf-8?B?Y1h3UERJN25jMVN0a3owcWFzMmZmSXJCNDFkSFFDZnVEVHFmSUJCekl4YmN2?=
 =?utf-8?B?K0MzZUIxcmJDVGFQSko5T0JQMnhJS3ZMbmNoTitnOFY2dVhtWUNYVVpmSzc5?=
 =?utf-8?B?YVFTOXhwVjliLytYck5iWXlGUUZLR1lxYlk3VlhvVDVSbjdBVzlJRUJNandO?=
 =?utf-8?B?V0UvRWRnYUNZT1pFSnFIYytMUStPRjVZdlM5MjZhMGl5aUlQbjZKVVBadkZt?=
 =?utf-8?B?eHF3WkR1QW1CVE01UEcvSUQ2eDY2N0Y4MmJCMnM0bUViS3lYanJSLzhmRlov?=
 =?utf-8?Q?YbB7ZierzOwZqpQt7RsRFy/38?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77487f50-faff-4095-60ee-08db1ff09db0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 16:17:30.2813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hf6KA70gh5Gfu+U7DkIR2OtjTghGfzaswfQYTjN72zDFU8Lh1OxjLUj2jei6zwIAfNkV0tSKV0uT+5hu4kQ9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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

On 2023-03-08 04:07, Christian König wrote:
> Am 07.03.23 um 16:28 schrieb Belanger, David:
>> [AMD Official Use Only - General]
>>
>>
>> The test case is a python program that will load the driver, do some 
>> operations, then unload the driver.
>
> What do you mean with unloading the driver? Removing the module? Or 
> destroying the device?
>
>> When the driver exists, there is still the python process space 
>> around holding on the address space.
>> When the python process space exits, the mmu_notifier gets called but 
>> the driver has already been unloaded.
>>
>> The goal of the fix is to address case where there could be 
>> outstanding address space / worker threads for process
>> cleanup that needs to be cleared/completed at exit time.
>
> Yeah and when the module is unloaded this is a completely futile effort.
>
> The general upstream approach is to take references on the struct 
> device and module and prevent unloading as long as those references 
> exists.

That's not how it always works. In case of RCU callbacks, the documented 
strategy is to use rcu_barrier in the module exit function to ensure the 
grace period and all callbacks have completed 
(https://www.kernel.org/doc/html/latest/RCU/rcubarrier.html). 
mmu_notifier_synchronize is meant to do something similar for pending 
mmu_notifier_put work 
(https://elixir.bootlin.com/linux/v6.2.2/source/mm/mmu_notifier.c#L1116).

But this implies that we need to call mmu_notifier_put for all the MMU 
notifiers registered by the module first. I think closing /dev/kfd drops 
the module reference count, but the MMU notifiers we register for 
process cleanup persist until the address space is destroyed. We need to 
trigger that cleanup for any processes that still exist in that state 
when the module is unloaded. Or we need to find a way to increment the 
module refcount for every process that registers a KFD cleanup MMU notifier.

Regards,
   Felix


>
>
> The device might be non-functional any more (because for example of 
> hot plug), but the driver should never be unloaded before the python 
> program exits.
>
> Regards,
> Christian.
>
>>
>> Regards,
>> David B.
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, March 7, 2023 2:05 AM
>>> To: Belanger, David <David.Belanger@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module
>>> exit.
>>>
>>> Am 06.03.23 um 22:58 schrieb David Belanger:
>>>> Handle case when module is unloaded (kfd_exit) before a process space
>>>> (mm_struct) is released.
>>> Well that should never ever happen in the first place. It sounds 
>>> like we are
>>> missing grabbing module references.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: David Belanger <david.belanger@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 57
>>> ++++++++++++++++++++++++
>>>>    2 files changed, 61 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>> index 09b966dc3768..8ef4bd9e4f7d 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>> @@ -26,6 +26,9 @@
>>>>    #include "kfd_priv.h"
>>>>    #include "amdgpu_amdkfd.h"
>>>>
>>>> +void kfd_cleanup_processes(void);
>>>> +
>>>> +
>>>>    static int kfd_init(void)
>>>>    {
>>>>        int err;
>>>> @@ -77,6 +80,7 @@ static int kfd_init(void)
>>>>
>>>>    static void kfd_exit(void)
>>>>    {
>>>> +    kfd_cleanup_processes();
>>>>        kfd_debugfs_fini();
>>>>        kfd_process_destroy_wq();
>>>>        kfd_procfs_shutdown();
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index ebabe92f7edb..b5b28a32639d 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -1181,6 +1181,17 @@ static void kfd_process_notifier_release(struct
>>> mmu_notifier *mn,
>>>>            return;
>>>>
>>>>        mutex_lock(&kfd_processes_mutex);
>>>> +    /*
>>>> +     * Do early return if p is not in the table.
>>>> +     *
>>>> +     * This could potentially happen if this function is called 
>>>> concurrently
>>>> +     * by mmu_notifier and by kfd_cleanup_pocesses.
>>>> +     *
>>>> +     */
>>>> +    if (!hash_hashed(&p->kfd_processes)) {
>>>> +        mutex_unlock(&kfd_processes_mutex);
>>>> +        return;
>>>> +    }
>>>>        hash_del_rcu(&p->kfd_processes);
>>>>        mutex_unlock(&kfd_processes_mutex);
>>>>        synchronize_srcu(&kfd_processes_srcu);
>>>> @@ -1200,6 +1211,52 @@ static const struct mmu_notifier_ops
>>> kfd_process_mmu_notifier_ops = {
>>>>        .free_notifier = kfd_process_free_notifier,
>>>>    };
>>>>
>>>> +
>>>> +void kfd_cleanup_processes(void)
>>>> +{
>>>> +    struct kfd_process *p;
>>>> +    unsigned int temp;
>>>> +
>>>> +    /*
>>>> +     * Iterate over remaining processes in table, calling notifier 
>>>> release
>>>> +     * to free up notifier and process resources.
>>>> +     *
>>>> +     * This code handles the case when driver is unloaded before all
>>> mm_struct
>>>> +     * are released.
>>>> +     */
>>>> +    int idx = srcu_read_lock(&kfd_processes_srcu);
>>>> +
>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>> +        if (p) {
>>>> +            /*
>>>> +             * Obtain a reference on p to avoid a late
>>> mmu_notifier release
>>>> +             * call triggering freeing the process.
>>>> +             */
>>>> +
>>>> +            kref_get(&p->ref);
>>>> +
>>>> +            srcu_read_unlock(&kfd_processes_srcu, idx);
>>>> +
>>>> + kfd_process_notifier_release(&p->mmu_notifier, p-
>>>> mm);
>>>> +
>>>> +            kfd_unref_process(p);
>>>> +
>>>> +            idx = srcu_read_lock(&kfd_processes_srcu);
>>>> +        }
>>>> +    }
>>>> +    srcu_read_unlock(&kfd_processes_srcu, idx);
>>>> +
>>>> +    /*
>>>> +     * Must be called after all mmu_notifier_put are done and before
>>>> +     * kfd_process_wq is released.
>>>> +     *
>>>> +     * Ensures that all outstanding free_notifier gets called, 
>>>> triggering the
>>> release
>>>> +     * of the process.
>>>> +     */
>>>> +    mmu_notifier_synchronize();
>>>> +}
>>>> +
>>>> +
>>>>    static int kfd_process_init_cwsr_apu(struct kfd_process *p, 
>>>> struct file
>>> *filep)
>>>>    {
>>>>        unsigned long  offset;
>

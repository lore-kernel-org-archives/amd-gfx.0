Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08494C61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 22:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D4210E048;
	Thu, 23 Nov 2023 22:00:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0ED10E048
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 22:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibSSu3rmJfKLKIwjrYfEp5WuPLMzFx0Z3sjq+wEiRqHqB5UtZ+3tAIyAe109FQhEDjPx9umnUhb+DQ1bHV9YoDHciYuj3qJeUZ8jc+PqM8FN4t5JOepGHPex/89vNM18AzMoqvex/AFeslpfMdJOgxj9AcMOorXV1mNGLQXSFwI0Phzqb5NfwZpWfs9uFE9V+HdKlACY2zEBo1/fDZfzJzT5QMGvnDJ3hNrSBjIuzCVh61IP8ZrF+ATTzQoM88eUv88GM9kJND11hCPyZER7/HhrsQobKuKadZix1/5lWPMpbWkwiHDLd3CIuBYh+aCA/b3DkroGFLgYXOwG6yo2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofHpuAjPw71ll6AReBdWnOAjyEhmCd7A6oVbAazqUZM=;
 b=fwtTu90sZ14SnneHyr9khLMwvwdnrJ/w6uyQOsrWh5KFZ6gvF44Wd5xQH/g89sE3j179EqhraJZzWr1HMuADFdBbMM/9pySFqPtzcBQh1nMAC17sZNVdvkDVapRjumjUFGVWfjD6dyDB/PpCSBGg01iVrVVjFHJIs3c2zJLQ+K9raKRVG1aIR4+RlqonV0orbItvID8c3lCsrDostP9VNN+4KSrY3+JKd7zyIYEIBJLcpbesN3mQsXyznJ0wH5csmLXB0hgaqObc3xb1JheErvV/Kk0EgX/Plh4Mtzi/BdIWT5+bDcWUdOClk3EoYbcdFvQ5nfc/zTpvqh7lajeteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofHpuAjPw71ll6AReBdWnOAjyEhmCd7A6oVbAazqUZM=;
 b=x5ybufUM/Jki3qBc3iHEt6j8Re2HW6v4jiNOwJjKY+5g1mKtmi9DNlovS2JBmISGFFNNbNOgNpUY2oRxIci/Mhz5Vk/YOUVZVzB3xSG/PxjLGYubZ1qiB+zWl+PhVmKk8m+6ZJqUIEMIS+jWZt4n7N/7PcbxqOLXgD68lHVzCuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 22:00:14 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 22:00:14 +0000
Message-ID: <16333c5d-e57f-4b12-956b-73f92790a121@amd.com>
Date: Thu, 23 Nov 2023 17:00:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] drm/amdkfd: enable pc sampling start
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-19-James.Zhu@amd.com>
 <eed89842-a946-4574-bafd-dd39bd471d79@amd.com>
 <958e5512-ac80-4cf8-b994-b0bf44f25ce7@amd.com>
 <f65dfd4f-351d-4251-85ac-16e893786cc4@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <f65dfd4f-351d-4251-85ac-16e893786cc4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::21) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a796e0-008b-45d5-03b4-08dbec6f91f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cV1/r248Hvy+9eHDW/fhB+B7orItVvi4iap7DnaOlhrIsSNgvbMaZPdC+UwxM86dcOxfefAfRQwmyhsr/jNkl4I0o8Lbds2wzit5M4cP5/TRvljyvy/991x6qg3oObZfmTT1FhGGrkislITab/OMHZSUINKOjn6LDWuX98tDJc9rHr9oB/7vLJRyf/uHUCLLzlss4mwaDCkkO5EJcsmwyYycq/2vKAPjU+9WZAUdE0JPHm08ZtDzKxZwsn5KNUUC6l89auGO6qVu1Sdy7AR+zEj2bzyR2FNfTrxfTjPn1cN4WI7g7A7Kjw9SSWofIXfp8iCZ8Sl/O1xU1nTEqnqsPfj3qXnIqCRCZ8fcjrC/oYW6XmLGA72JwonJ0bbVA6/hH+7yRn3oRaPzDo/T9fUQ7FYYoM1tXllF9epQ8wJgvmDPG9SclmMOQ2TYQ2BZ0ws37MOvru/jd7wq0n5fdkzxy9YCxYmc5/aHA3scIHo9zKJWAyqfxVbKgiy9xWKxM/G/hpyr0pdJaP/qLTDz7IYyIgjDiLC1JAtmCycqDNe0gGpA98m+fZd+cJ2mAtqWMlSDmORDlALG35KISkdflhZO8Cd6gxCMDngV6QxfV7xbhgFnvzhYsKDaH2HJPiH1shjE3cigXo4US645AcCJpgvFDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6666004)(53546011)(6506007)(2616005)(36916002)(8936002)(5660300002)(4326008)(41300700001)(6486002)(8676002)(26005)(4001150100001)(478600001)(2906002)(316002)(6512007)(110136005)(66946007)(66556008)(66476007)(31696002)(36756003)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFloQ1g2U1N5eDM5eEFXSWNZU1dGeEJTTmxsdTVadjRZQVQ5aVZrdFAyR3Vs?=
 =?utf-8?B?VFVDeWtSdFBTdytteXF6M3Nab2hBdDB1OUQrRCs5RUhRRjJNZWZqTFdlWU53?=
 =?utf-8?B?RndURi9IMkwzNmFEejJZU1JHUTZVcldIcmFIRFdpendOTXFLYVBMOWNQOE5Y?=
 =?utf-8?B?ankza2NMWFkwUU5jMlFUOEdKWHljcVUzSFoyNU9vbUxYeElIMzlaWUtoYVVJ?=
 =?utf-8?B?M2toK0w5Vm54N2Y4Q3V5azZ6a1ZrSXdNTStXVERTN3dlM1FDeTVURE1BWnE1?=
 =?utf-8?B?RTJEbVBnWjRKOUEraTZxcXJoNjk4MU9aMy9wRVdVUXJMMUJDMmcxNFVpTEhJ?=
 =?utf-8?B?UVpJcUlEbERHaUxaZjBBRkFUSy9OZDdLTEZKNng3eGlucXFvTVJwK3VLVE5t?=
 =?utf-8?B?WG1RTVlVa1pmYm5RMjVEY1QvODQ5bmFOb1JPNVlPdWpNY3BGRHpnUk9lVXBh?=
 =?utf-8?B?cE0yRG1pYUNiSGVNRUwyaVN1NElJek9jWGppUjB1ZVdYQ293cU9CMmZMSXpL?=
 =?utf-8?B?TmFRL3lTM09WSGVTVk5iT1I0Z29CRG9YT1pKNUZkMkJJUFBka01VS2k0MWo0?=
 =?utf-8?B?eW4yT2dhLzRJUERERjlDM21qSGNzOVdkV1krbmZWSlo4alFJcldtQ3I1QjV5?=
 =?utf-8?B?RnJDQ0pGdUdQQlFwS1pRN2tmVEZqeis4SVU3QmtuT3lORTBvL0cwMHEwTE1C?=
 =?utf-8?B?Yk5xRWhaRHRnb0RSMUFzUzdBV0Jxb3dzV3M4NjlqRCtKTk1lRmp0S0pUVWow?=
 =?utf-8?B?NXdCNU5CeHBLcVhtSUFMc1N4d2pZQXgvN3k4Y01IYTZFZGZYeDBLS1NsRElC?=
 =?utf-8?B?YUNDTENuTndRazFReCt3NGZ0K1M3NkZwdXlYd0dSTy80a1Vob2J4eU9JVDhy?=
 =?utf-8?B?VHpsZGZvVFc4U2JJWFQweDlmS0tlaFNPVnJOZlFXQjZIWCsreHpGVUw4cXhT?=
 =?utf-8?B?dzRJQTd6MTZUTlhaa2VuQlFhU0JTUzgxUkFOc2RwdkxGSEhBRGFRd3JHYWd1?=
 =?utf-8?B?ZWZsMWFKaTZwOGFLN1NNQVpPRzlFLzNOSVgwZ0wvYVM4ZkVadXFDMzR5Z0py?=
 =?utf-8?B?MWExVUJlZnNDS1U3VW1rSmd1QXhHVmhBeW9aZ1hJOWdiSEdUY0dOR1NoNnhp?=
 =?utf-8?B?bDB6VU5kSVBRTVcycmxuTUMrWW5ybjdvQ1N5a25iaVBGWVhyWUIrVXZRR2VW?=
 =?utf-8?B?OGhYd2M1WmJLdm0xd2llRk45bHRpWlpMcEkxVGRvdVRsV1pnNnBNbTFYTThZ?=
 =?utf-8?B?R2xHcFB2bUJHTGwyR2RmeTc1Y0hsYm9pamtQN0F0N3JJR0lZMVVXZlplaGx2?=
 =?utf-8?B?bWsvZWJzeGdPVk5uenZnYUh0ZXBGaXlYZHc0eTZlaHR3VFpRd0E0ZThLN3ov?=
 =?utf-8?B?Mk4rTnBMSHNCVVJyNXg1Z0lWSGFVdWZGNml5a3pCUWZvdUFiODYrN3dkVFVv?=
 =?utf-8?B?dG9IRXB3V2FGcmI0Zld0RWFibCt1b3FxNGQ5d2VYOVoyYmFEd0ZqcTBLN204?=
 =?utf-8?B?NERoZkV4akMzUUZqcHhxbkZCS1JPRGRSdSt1NHB2Sm82Q3NLbFhjalhXNE00?=
 =?utf-8?B?VnVnR1BCMSsyMElXaEpYVk8zMkFwK2YzbG9na3F1Ymdxbzc1R1pBZ21NWGor?=
 =?utf-8?B?SDNwZFpvUzBBT2FPeHY3QWw2NndiNVo2YnhEa0hTaFJYeW1rZDdveE1yVTZN?=
 =?utf-8?B?VlgrYkpzMkM4TmhPbi8wS3JIVmQ3ZWRGWi9PcnJyWjhzK2ZINGtPR0pTQzgr?=
 =?utf-8?B?Qi9JRGJDUmN5N3RUdUQ3QlFlRnZYS3dXZ1hHb2xjZEVJbHYyckRvakJyeFQw?=
 =?utf-8?B?YWsyT083RzZXWGkvTkNqYmNrOWVEVzBiSkNMdjFLSVoyQ2dLYVdseEFpNk5i?=
 =?utf-8?B?M2JVMHJpTE9oRlJKalp1blhRdkVkWG5xWkplVUl0M0pWTTVuQjVkdnVUVExT?=
 =?utf-8?B?bDFsb1JUWS9iUDN1eUNtSUNtU2tPU1dIMklMa0xSUC9HY1doMFcza0ZONVV1?=
 =?utf-8?B?dmlPWVBFWFRTTVVpSzNXbU1FM2RYbnhtUGtGV3htZTYzY2ZpMFZqYzAzY0h0?=
 =?utf-8?B?bWpObkJEUzR4MDhvZjRaU0tKOG9qcFJVcnl1U3BESUczR2tray8rckNKM0Q4?=
 =?utf-8?Q?lc1zby1mZEH43jcblzHH5ehmS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a796e0-008b-45d5-03b4-08dbec6f91f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 22:00:13.9632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIsBeRRx1aiI8xqLcLizPNtzNPNufX18cBaSKgxDgb3w7TLcB4e7Q67e6kd+TzRU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-23 15:21, Felix Kuehling wrote:
>
> On 2023-11-23 15:01, James Zhu wrote:
>>
>> On 2023-11-22 17:27, Felix Kuehling wrote:
>>>
>>> On 2023-11-03 09:11, James Zhu wrote:
>>>> Enable pc sampling start.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 
>>>> +++++++++++++++++---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
>>>>   2 files changed, 25 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> index 60b29b245db5..33d003ca0093 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> @@ -83,9 +83,29 @@ static int kfd_pc_sample_query_cap(struct 
>>>> kfd_process_device *pdd,
>>>>       return 0;
>>>>   }
>>>>   -static int kfd_pc_sample_start(struct kfd_process_device *pdd)
>>>> +static int kfd_pc_sample_start(struct kfd_process_device *pdd,
>>>> +                    struct pc_sampling_entry *pcs_entry)
>>>>   {
>>>> -    return -EINVAL;
>>>> +    bool pc_sampling_start = false;
>>>> +
>>>> +    pcs_entry->enabled = true;
>>>> +    mutex_lock(&pdd->dev->pcs_data.mutex);
>>>> +    if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
>>>> +        pc_sampling_start = true;
>>>> + pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
>>>> +    mutex_unlock(&pdd->dev->pcs_data.mutex);
>>>> +
>>>> +    while (pc_sampling_start) {
>>>> +        if 
>>>> (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
>>>> +            usleep_range(1000, 2000);
>>>
>>> I don't understand why you need this synchronization through 
>>> stop_enable. Why can't you do both the start and stop while holding 
>>> the mutex? It's just setting a flag in the TMA, so it's not a 
>>> time-consuming operation, and I don't see any potential for deadlocks.
>> [JZ] for stop, not just set TMA. need wait for current pc sampling 
>> completely stop and reset some initial setting.
>
> I think that's being obfuscated by how you split up this patch series. 
> Maybe if you squash the queue remapping patch into this one, it would 
> be more obvious what's really happening when you stop sampling and 
> would make it easier to review the synchronization and locking strategy.
[JZ] Sure
>
> Regards,
>   Felix
>
>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +        } else {
>>>> + kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>>> + pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return 0;
>>>>   }
>>>>     static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
>>>> @@ -225,7 +245,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>>>>           if (pcs_entry->enabled)
>>>>               return -EALREADY;
>>>>           else
>>>> -            return kfd_pc_sample_start(pdd);
>>>> +            return kfd_pc_sample_start(pdd, pcs_entry);
>>>>         case KFD_IOCTL_PCS_OP_STOP:
>>>>           if (!pcs_entry->enabled)
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index 6670534f47b8..613910e0d440 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -258,6 +258,8 @@ struct kfd_dev;
>>>>     struct kfd_dev_pc_sampling_data {
>>>>       uint32_t use_count;         /* Num of PC sampling sessions */
>>>> +    uint32_t active_count;      /* Num of active sessions */
>>>> +    bool stop_enable;           /* pc sampling stop in process */
>>>>       struct idr pc_sampling_idr;
>>>>       struct kfd_pc_sample_info pc_sample_info;
>>>>   };

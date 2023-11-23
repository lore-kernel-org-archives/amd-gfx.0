Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275B3C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 20:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F5310E342;
	Thu, 23 Nov 2023 20:22:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CCC10E342
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 20:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ+tJ3BUgQhcb+0Z/YsE5fCJ+rt8iQ3NuLCOwIU5U5M0yy2DVYE4cg92J/HmDBlyl522HYs9Id3M3WOeuakVN0KoeIoCypY/OmMUdZKUS6NBwMkfra5DNo1TOzAVALDOilB3fy2zPrHMAJ0MkG3H68/2MwgUzB7qjWHajC8zlVKkfdFMrYBA1qFsVjxykJ9NGvjgMQ0pkPrcaKw5sYR5SOPNemINUV4olAEBrFP1UlheNpb9yQpValOP6OYS0mLokCZ1TxwfRRH4BjtXXvKSischjQ1fe1WZYWXjLlquJxNN/JMhzxBBZtG2lOrWs9cwzKgwVe8GaPvLMJGUocNcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzWlRsaBfVM84NIjOtrkFWoyvGnOHEbRKGw6UBMn3rQ=;
 b=ePTW6QizbmZu1jIc3SXsJOLakVRPFaiGtQG/v6bMZq4Xe2WMOMQTHe3YGdfMzI6WpSrcTf863Q14/d6exj/d9Qoiq3QM1dCu1e6MzFlnYUzP9pEp8SnSfdJof7dsUhpQ+4naRYjIsOHyN8cS248toqkU8vnVMmMCvmEDQIvh3Eqbw4DXu3uUJx/8fGw/w+cMX++KXRJjwf4f0feI9P/s5/khXGbTrJR3YPTqM3F09rkR0J7ookhNEUdtEtavt1/NoMejYl58UPpFdGo1NIM7pqbEAMY/CPuQEucMiOUzFeP/w/h1sKV2BMQCSURqPMa4NZ/IXsKJ1gJtfc6KbslcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzWlRsaBfVM84NIjOtrkFWoyvGnOHEbRKGw6UBMn3rQ=;
 b=PoCKWaRlWardA7HRxEaYTD5teqIh5DuMAn7tyZ/U7jQ0tJBHmS0EBP1i6Vni6LjQAhi8yQKl30J7hZHYhVTLSoNLLltylDM6nEhpr+0mRV5JA81ky79PSN7aNTeyMCELGYiz+4jSDxzgGFDoinuf+EJ4D7drgW6kAP0/tvzRgVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 20:21:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 20:21:54 +0000
Message-ID: <f65dfd4f-351d-4251-85ac-16e893786cc4@amd.com>
Date: Thu, 23 Nov 2023 15:21:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] drm/amdkfd: enable pc sampling start
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-19-James.Zhu@amd.com>
 <eed89842-a946-4574-bafd-dd39bd471d79@amd.com>
 <958e5512-ac80-4cf8-b994-b0bf44f25ce7@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <958e5512-ac80-4cf8-b994-b0bf44f25ce7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: c026cd12-e1ff-48e4-118d-08dbec61d585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmaraWQfawqHCLAKPs+OwKPf8kA39vZ3+SuNa1L1xU1eaPEwWUY4s0zENgoRFEfSoLGnTI3wfoSkQAo88vOw52EMhiU9UWzMm9Qg+r17DHC5nFVCFCsTfT1Kd+5Ofz2wYB22LIA8Rf1kJDHm3jWCLcV1V3Vz2gV2AIqdgTHu7YsDko/abtpPg4lXWDbgAMxz3dkj1CXLbjTwxF7kbjkjDTcHCPAy5E7p6ULQo1YtsUmkvo1rA1fbSIFaGj3i/FirY83FdCT9TQj3ydfLIAsZv52KZOBDDeGY9ucmkNgeODgR+/50HNce0pahUFF+ReLepYgwWoRBoZ71FCvQ3UjdUFzbSUoAjRQyV73Kn8fJPvDf51Fxn24VSQnxUt8GQru8QW8fvyIGSU1rVmaqLLZgq7pDlL+RGpz0nHmnvhdpE5L06b2O3cv09IcNewfTfvMJ969pPqtjYh+0QHKlv+V9cBKI7iTAqXX491oy5FTBqAsqPLsAuZavBBUqpxXuZOj0OTWseRktGC8FLgBJgZetjak+vf3nSxpvVVUr7D711J6o2iDzDD0U+7sLSdVfnUD+I6qNoW13dHGiHvsfb99IyAXm06vKTP7dA9qC0GKOecjyKaFD7WJrxYDys2VKfjdlgFUDPWftyYou5BvC2PoU4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36916002)(2906002)(86362001)(31696002)(66476007)(2616005)(8676002)(6506007)(83380400001)(4326008)(8936002)(6512007)(53546011)(66556008)(316002)(26005)(36756003)(66946007)(110136005)(6486002)(478600001)(38100700002)(5660300002)(44832011)(41300700001)(31686004)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktFNDZmcWY2SnRUSnhGWVRBZWI3QjJjb29LVjBQMHNqOXpTUDNRdmZnUUlz?=
 =?utf-8?B?UldNU3VXZ2hHcXZib0tIbzVBK3k0eFZkNzRXNnVFb1BSM2dFd3poOXBnYmNv?=
 =?utf-8?B?QnVtOEJlQnJDZkNmOHZMbHVNNnpXeWFsbmZ2eXZDbk4rTEpDcE9YVzlrbXg2?=
 =?utf-8?B?S1FKM2lReUo2dXJxUU50S0tMV2VlbjZMM01FVE5TZm05ZHpQQ1Ezbm5yc1dz?=
 =?utf-8?B?cTU4d0M0SExDUGxrZElMSHNTR05xVzJEeDBmMFhTWGZPQ2pSMkpFSlRWOFBS?=
 =?utf-8?B?TzlsWWN1aTY0TzVrb09SWmFMeDlwUFdETXNYSzY2T05KajlEMmVQVnAyVEU1?=
 =?utf-8?B?N01oQUFCS3RJQWM2WW1rRWkwK2dUcU9ueERLMGd4ZmFnaG95YXRUMGJRVzhO?=
 =?utf-8?B?QWI1S2VuQW5YK05EMU5XNkdHWmRQVUtZbU9nYmtlNW1GOGZmRkpMdnVmSkU5?=
 =?utf-8?B?ZmIxU01lRHNucHJsYkhnTW11V2pmc1M1WTVVNi9nbDZpNG8zOVlXSE9HdFNz?=
 =?utf-8?B?Mjg1ZUh3eVloTzRiTnZzbXV6dGxyaXE1NGpQR3BQTWVPUjRvbHdWQnlTNE95?=
 =?utf-8?B?VlNkdjE2eGZ1TURjVVp5OE9PSGhzbEc1QUI0TTR5dGFGaXpyU1pnNEVkT1VN?=
 =?utf-8?B?K3ZENnp5YVdFR3RPVVllcm02VUs3akU4SFZMZlZQL1lVU0xBTWN0bjZLNTZa?=
 =?utf-8?B?d0llcEdTckNuVldyRHNiWEh5Q0NhbGhrSnZvNVdPWmtheDYwNUlRT2RlSzdp?=
 =?utf-8?B?MmNLRElQSHJtNFN2R09RZ1lycHlrRUxtOFFOQ2NpakF5Q2Z3OTQzb21uTzNi?=
 =?utf-8?B?RzJXN29YNWlEK0w0aXhXUmtQZDNQZXJGaXBKcDlTR3F1aVZDREdjMUVqNFlU?=
 =?utf-8?B?TGpTU0ZDSlVLNnl4ZzBkMWpjRzBBSkxrYXprdjF1cDFwTDlCQVhRaGN0TEtv?=
 =?utf-8?B?Njh2WUNSVDJkZW43cnIvZlNYY2s3RTdpc2tMUDRJVUpYeVR1K1l6ZDJQWmNj?=
 =?utf-8?B?Q1RQU1BzaXVuT3hveE5ZMC9BV1RpY0llRTVkUHpUbEFlaDk2Tzdqd2tRMS8r?=
 =?utf-8?B?TUZNREgyYnVQLzcwWTBRSjRsZ1ZnejZuRFlsTGtNNXF5WGJvR1EvdnVJZDFn?=
 =?utf-8?B?TklERmZxckQrNVFLZEozK3BkeHUrcTNPcEZQb01melI1UXkzdExhZEQ2M2R2?=
 =?utf-8?B?cWVFME83NUV6bndxSjJ5Yzk1Q3RuVjJvbkFHTmwvSlllOEd3OWZEWEhqUXBC?=
 =?utf-8?B?b1lEVnAvVVJEUWFoTXFOc2tobmVCR1U1bEFFNFFPT3N2T0hSYytZSDdYTkhr?=
 =?utf-8?B?RzVaVGNUSCtaTHNYV2szSFBxekoyTDNrTmQxNGYyOHdrSGlWcklSbFlmSWc4?=
 =?utf-8?B?OXp0VDg2MElEa09sT3ZUSFpnOFYwTzg4RjlxeUg3NFpuMW5JS0dwZGxGUmlR?=
 =?utf-8?B?RFFVaHFwVEM4ZlptejhwQzhWQlMzb0UxVExnVWc2VEVTdkZTYXRpUmMyMWZs?=
 =?utf-8?B?VXJIYzhvcnd3T3pReG5GS0VmbUt4YUlHSHJRdVI1dHNEeU9SR21GVXhNZnNy?=
 =?utf-8?B?akliWVBUb0pKOWlrWWV5YkR0ZkltZEoxTlBWTzY1aG9oOUhVQVNuRWVDTXhp?=
 =?utf-8?B?M1RreFpGQ0wvbzdmTXVIUHpvL1RhS1JvS0hSdFpkMlJZZGY5UTgrV244dHIr?=
 =?utf-8?B?Y2E1dUtjR1VQUlpkeUhnMjhzOEZweUI5RFJzZHc0Y1cyS1E1bHgvMGxFazc2?=
 =?utf-8?B?RFNFWEdwQ081V3NXOFpvVHlPSTJVaDVJOHU3djF4OFNqSHJ5cExSckxIZDdS?=
 =?utf-8?B?SXlJSHFiMzVaNHlkYjRUZDFqSjFHenUyRUZ6MlNUZHVKMDlsM1FjWjN1OG9V?=
 =?utf-8?B?U0pjalBrYngxbVFiWVVSNUNjeDhpQy9GS0dCaVkvM0lIdEQzejFPcWx0U0Fi?=
 =?utf-8?B?N1BzVVdUUVUrWCszdXlNWC9SUkNTbDE3Z1FmWnRCTWMzcWk3M09JOER5NzZV?=
 =?utf-8?B?eHU2QkwyenhCdm9OcVMvWkdXMVpuWFJIYWkvV0RnZkp5OGEwSHB4eUlNNCtK?=
 =?utf-8?B?TWdhRUhzakhkc3h3a0pNeGszR1E0akNmL2dCWjhrNm5vZ3A0aWh2SERXa1kr?=
 =?utf-8?Q?nKBA8u/RUncdjf+Ig9RJ1U73K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c026cd12-e1ff-48e4-118d-08dbec61d585
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:21:54.2421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlhbCvvoj55LJ0MgQL08A7MZ/x5w6x5PvPcK21zqsF51T8ozRk4hMJ76KNJaddqQSBKQxuEGk02bmXwdJq7G3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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


On 2023-11-23 15:01, James Zhu wrote:
>
> On 2023-11-22 17:27, Felix Kuehling wrote:
>>
>> On 2023-11-03 09:11, James Zhu wrote:
>>> Enable pc sampling start.
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 
>>> +++++++++++++++++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
>>>   2 files changed, 25 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> index 60b29b245db5..33d003ca0093 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> @@ -83,9 +83,29 @@ static int kfd_pc_sample_query_cap(struct 
>>> kfd_process_device *pdd,
>>>       return 0;
>>>   }
>>>   -static int kfd_pc_sample_start(struct kfd_process_device *pdd)
>>> +static int kfd_pc_sample_start(struct kfd_process_device *pdd,
>>> +                    struct pc_sampling_entry *pcs_entry)
>>>   {
>>> -    return -EINVAL;
>>> +    bool pc_sampling_start = false;
>>> +
>>> +    pcs_entry->enabled = true;
>>> +    mutex_lock(&pdd->dev->pcs_data.mutex);
>>> +    if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
>>> +        pc_sampling_start = true;
>>> + pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
>>> +    mutex_unlock(&pdd->dev->pcs_data.mutex);
>>> +
>>> +    while (pc_sampling_start) {
>>> +        if 
>>> (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
>>> +            usleep_range(1000, 2000);
>>
>> I don't understand why you need this synchronization through 
>> stop_enable. Why can't you do both the start and stop while holding 
>> the mutex? It's just setting a flag in the TMA, so it's not a 
>> time-consuming operation, and I don't see any potential for deadlocks.
> [JZ] for stop, not just set TMA. need wait for current pc sampling 
> completely stop and reset some initial setting.

I think that's being obfuscated by how you split up this patch series. 
Maybe if you squash the queue remapping patch into this one, it would be 
more obvious what's really happening when you stop sampling and would 
make it easier to review the synchronization and locking strategy.

Regards,
   Felix


>>
>> Regards,
>>   Felix
>>
>>
>>> +        } else {
>>> + kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>> + pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>>   }
>>>     static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
>>> @@ -225,7 +245,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>>>           if (pcs_entry->enabled)
>>>               return -EALREADY;
>>>           else
>>> -            return kfd_pc_sample_start(pdd);
>>> +            return kfd_pc_sample_start(pdd, pcs_entry);
>>>         case KFD_IOCTL_PCS_OP_STOP:
>>>           if (!pcs_entry->enabled)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 6670534f47b8..613910e0d440 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -258,6 +258,8 @@ struct kfd_dev;
>>>     struct kfd_dev_pc_sampling_data {
>>>       uint32_t use_count;         /* Num of PC sampling sessions */
>>> +    uint32_t active_count;      /* Num of active sessions */
>>> +    bool stop_enable;           /* pc sampling stop in process */
>>>       struct idr pc_sampling_idr;
>>>       struct kfd_pc_sample_info pc_sample_info;
>>>   };

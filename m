Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BA5C61DF7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 22:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3639010E18E;
	Thu, 23 Nov 2023 22:06:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4FC10E18D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 22:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcAL3lzFg4ZJCdzNsiwkUVPmVbk9pBR/GGMwUk8HVVxm7p8IsMto6e2Pih8zvxnnQbBTXNs6v/McDYbEMNHYpk/UPr0Ki92xUffdj8Jf1wzFqbRdWRiPNAj8YfvRlV+nD/dvO6WSoyu0IYWHSSoABIom9s/rHUWQ2v9n69f1oWDefxcVjXGVIsgt9jfq+FaSt5SP20KgDp4oKmsMhrWFKHUmXeVo5dluNletE1aQLSKt9HWN3++pKCGFEb7UD4gmPJWrPUfC9fiJAEfvc4U0PIb0Ty6WjLzj3TQ7tBIB6djQOxGpC1gFtUjSinq/AheFt7nfBFtubaTXDJoqrRHYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow17ML22EYXWw3V9+rJ5P4CDx+VDgxj0DY3gI4VHMvk=;
 b=TFZGWgjofdIZ3VC9mpgzI4WJnCQkX4D7QOYODoX4ezY4whlLAzMc2Z9bPuCAJgtxuMHhlwx7Q+i0uGbB2y1Fmv4AL2c5lpdV1Ir+YlPhUGAYG7O84agPWrbEnmmFoRd9hLG2D2F55GRIndUoI/vEq1rAqzy1szJUNMG/qyxkpQvr7DBM57EgvGc03f7+UNQ+qrDKawQWquRzuUi8Hk0t8FILxvF0oWt0kg2SW/AtANeqtwyN9QmWIcMDjG2KF+sW4gAj1crIiZAXmIjV98vpSePUecy3Ww4MmERixE7aubgxzHOopbYkpJmjW4DBHH94qDlE8RpmyEiLEbryHW4tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow17ML22EYXWw3V9+rJ5P4CDx+VDgxj0DY3gI4VHMvk=;
 b=brbicKqiGsNrF9E3ed/ekoFptrvVeydjkqXKIATVIAn4c0cPKqzPx/+1MwjWlUQ2C9ha3WBCr6eELiieX5Q3hgRikU68msqGRjQ4LhvgsMTSoUL2BWIoW1cYy03kLu34JIrB/UWTFDzLhyZlUovN+G59gytTMHd4fZGmpdL7JUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 22:06:43 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 22:06:43 +0000
Message-ID: <431ee837-ccaa-4eb3-a769-47ea2d52a45f@amd.com>
Date: Thu, 23 Nov 2023 17:06:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-8-James.Zhu@amd.com>
 <8a4a1994-f92c-407d-8e12-4466b27ca53f@amd.com>
 <3fc881ee-06c5-4b67-bc0e-a19da4f1919c@amd.com>
 <fb7eb2e0-12f3-4a4b-b721-d68856568c02@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <fb7eb2e0-12f3-4a4b-b721-d68856568c02@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::22) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc6d2c3-63e4-4b09-0cea-08dbec7079a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GthqWsrsxnS7Lv7F2jeECp8BFiXaadlOevlvZcX7P8Enm8HtyaeIZl/7M5+q4cY8SAoR1vlBzPDYpFH9A7hjGCcJv5nP7AWwXQI0S6o78dHw246SKLJRMde1wkRipKoPqCw3bBPtg5LlvJ+RYpWa+bludFTxr+SufOg1WeD6yWJ7AcaBN5/rzZEayGzVMaQXH0CTM5XKa8YsUPIKPrPC2fmF2Lq/E/wpLEhybpNRx/aE9CJ1GCDESYp3L7AKQkgKebqhwcRUUhtr0TP/7j5+lw7t4Mbiwp5PKgVr73w1FZZzQn/kgokWFpleJJOmGvvYEMXKxoSAw5N7JMlvYunhi4xpuQeJ+U7Ksb5JS4zDgvnxu1Sb8L/tNkVPXCElJBCY75R6UA9Qp0C1c/hV5tED5G5QkLTC3sozLkYsZ0YDl3XlB9J27CP9HfwhrtS+i1XGyDohf1BhpI/A7J+KO1c/Cb2w0Rxvr6Mfd0Xefkg0tkZLh1S3tdYcu/EsDkfgVlvnRUm1OoHPRGgo53zdmsDW+bZU6VniDwZCo4vWIae9x/6IzkA8XiZAoNn/2ABDdWuswhyZMaE3UHNcBA3ku6jWLEYtQ8V4T1kREV2mtO+tKE7P9vmSsVbgNWT96uHNsIT3RRLLT3hHLbQ7mUi0ktJvOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(31686004)(66476007)(66556008)(110136005)(66946007)(38100700002)(36756003)(31696002)(36916002)(6506007)(2616005)(53546011)(6666004)(478600001)(4001150100001)(26005)(2906002)(6512007)(316002)(41300700001)(8936002)(4326008)(6486002)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5nY3BsbkVPVGNGZTJRWXdhVlB4L0FFSEZVT0ZVQ0IyVSs5UmJrR1krSmxF?=
 =?utf-8?B?c0dQdjR5RHhPUE9hbXhFd25oMEx2cUVyMVBncTdBYmY3U1JTZ3NiWnd3eWVv?=
 =?utf-8?B?RXdtUmtWaG1NYWZJaDFpWjZHWFJnUU1hdVoza3NGWUg0aDhza1hjaTE4TzZY?=
 =?utf-8?B?THNRNmJyR1JMSGk4dTZuaG5nbHpEQjhzMjhOdklCOGxUdkRudG9qSUpiM2lV?=
 =?utf-8?B?d1BGSDQ4NmZ5SVRKKzNvZnRGN1ZTMmQ4bTZ3aHRhbVArTkJ5Y3VqK0U4Szdk?=
 =?utf-8?B?UDQ3ekszbDJzWW40cTZvZkx1UTBCaFVMUjROczE2TUg2azd6WkxyNEIrWXEw?=
 =?utf-8?B?RVlrdDRlUDRBRGlQTElTcklSamh0b2RSRGxWdmt1RHhYSkNkYTRkV2tiWno0?=
 =?utf-8?B?UWt2dXdoTXNLajJwQ3dHOU9sSG5sQXc5TWNnT2o1WFloV1hyWEpKeEN2Sm9X?=
 =?utf-8?B?WDZsTFRXRjVsbnRlOU82TlliUVM0NGdHbWc4dExnSUJsaEc1ZllVUjg0RWdt?=
 =?utf-8?B?SmpCbDJWUWI4SVkwRGt2WUI2ZkRaRXBSVFhMUlNiK0lVNENRanhMcUdYcjdi?=
 =?utf-8?B?TVZNTTNPS1Jvdmp4bkxFbjg5d3J3MUlybVBScElHeFVqWms0RGM1dmhOVnF1?=
 =?utf-8?B?ZklPVVhkWXk0M1VnTElIcWNTSVdLOEFUc2pHRmhOQTFQS1RqZlB5TXhIZlBl?=
 =?utf-8?B?RG8vN3hFY3V5UDFlMVBMeEc0NElpc2tEZ1JoNS9ONFVTVGg2aFAzRXF0N2xL?=
 =?utf-8?B?dHZyVHBGOGQyUjRDUVBFSXFmNHRvOG1HNXoyZEcydE5aV1hzRVZmOXdZT01l?=
 =?utf-8?B?ak1YZ1MvMjNmV0JUSXBoZ04vMmJCcUs2TU5YQ2hUeDBVL2Z6Nk1MT3VpeXZt?=
 =?utf-8?B?YzBLU3ZBQzVkQVNHVVlsbDZKY2cvcG5NdXRhM2UwZzRCWlNxZXpKUitla3hT?=
 =?utf-8?B?SGhrbkxNYnlEaXhSMHB2N0ZUbTVIRlE3c2FRNXBITmNSY3lJbGJ5L2czRktO?=
 =?utf-8?B?cWJNYmRJaWZaMStucm5VT2xLOUsyNHlVQzlrMi9pR3RuSkNLejFMZW9PUE0r?=
 =?utf-8?B?eWJxeVF2VElzdm56bzV2WDB1RVNYNVh1NEhvOVlncE44aWNOa2RHRDRJWWVE?=
 =?utf-8?B?ZGxsRTkxck1kUEVYRDhSb0tsTnlrZjhHTitqMGRWaVhFRTROY0ZUSzZIeGlM?=
 =?utf-8?B?OXFPdURycWlIc0RWRDZvc3Mzb0tkZzVoWVVKRkxaOUFkMm91bjE1enREUTYv?=
 =?utf-8?B?Z1JsZTJvZUM3YVloVUJWblFNWmRCWVc1ZlRjVnJLSy9oa3AvL0dIQ1N3WnNo?=
 =?utf-8?B?cG4yRHRacFIzSGYzNC9HZUNGTVJ1YWZpSnpUclJwQUZPMDl0SnJiM3daMWF0?=
 =?utf-8?B?ajhPUHFZalRkTFhqT29yQ1AvZU5VaWsrY01SQ3NGdmxmSWNYTzVpbkliVlRh?=
 =?utf-8?B?ZFA4bVIreWRuVW1VQnZjaW1Vb0FvUnA0OHRUdzA3ZEFsdXp1ZzRTUndjL1c3?=
 =?utf-8?B?VURZVFlnaHVmNGtzYm11TEhVNEZCSmdHSkFrOXdEelFQNmcwaXNrV1Z5TTh5?=
 =?utf-8?B?anhYVnRLckdQajA4SFV5ZVA3ODBiMkJaNWUzSUxiMTBia1JsbEcwdjRqK2R1?=
 =?utf-8?B?Mlk1UmsxQndZVDR2bzJBc0NvdEpLZkxCQmFadmYwUlpNVHRqbklqNmcwRmUw?=
 =?utf-8?B?Ynh5SWRxYUlQbHJpbFZVc2V1M0NadFkzeXYyMG1YR3FDRFZHajRSUGNCWklY?=
 =?utf-8?B?WnBPVDI3L3NHaE9QbTJXVmdpOG56aDVjTmNpMThrTlduWmQ0NlAyQTZwVUI5?=
 =?utf-8?B?UFZOSFc5cFUvV2t4TVFvZGd5NTMrMTArUHFIekhVSnBaMTR4R2tNQ05ialo3?=
 =?utf-8?B?RVZCUnBoYXd5d3pEaVZGUWtwb1U5a0JUaHBEb085aWY1NGg0UEN4TG9kMnRn?=
 =?utf-8?B?WC9BNDFROXo0Z2RSRU5weVBIVjh5cCt4OWR1bXFCaWhhcUxRRnFmUklCVjNx?=
 =?utf-8?B?cDJ3RVBMWU1OVlFsZkxlRSt5NXFlelhlT3VlWHJXMitWNmZKQ3ZQcWJid0c5?=
 =?utf-8?B?aDVhVUFxT2h3TlVTRTZxR1ZMWERnN0hOT2w5Y3VpM0k1RU5wUGFLK1poMmtr?=
 =?utf-8?Q?mmpd6bYMw1uhuEvDnUoXrZxVK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc6d2c3-63e4-4b09-0cea-08dbec7079a2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 22:06:43.1617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBPUCKLTMsfLR2W047aXecIeTIuHPvBSbt4EqVhiKbrweslc3QrxF9Zo2Sx+Uxqw
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


On 2023-11-23 15:32, Felix Kuehling wrote:
>
> On 2023-11-23 15:18, James Zhu wrote:
>>
>> On 2023-11-22 17:15, Felix Kuehling wrote:
>>>
>>> On 2023-11-03 09:11, James Zhu wrote:
>>>> Check pcs_enrty valid for pc sampling ioctl.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 30 
>>>> ++++++++++++++++++--
>>>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> index 4c9fc48e1a6a..36366c8847de 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> @@ -179,6 +179,21 @@ static int kfd_pc_sample_destroy(struct 
>>>> kfd_process_device *pdd, uint32_t trace_
>>>>   int kfd_pc_sample(struct kfd_process_device *pdd,
>>>>                       struct kfd_ioctl_pc_sample_args __user *args)
>>>>   {
>>>> +    struct pc_sampling_entry *pcs_entry;
>>>> +
>>>> +    if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
>>>> +        args->op != KFD_IOCTL_PCS_OP_CREATE) {
>>>> +
>>>> +        mutex_lock(&pdd->dev->pcs_data.mutex);
>>>> +        pcs_entry = 
>>>> idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
>>>> +                args->trace_id);
>>>> +        mutex_unlock(&pdd->dev->pcs_data.mutex);
>>>
>>> You need to keep holding the lock while the pcs_entry is still used. 
>>> That includes any of the kfd_pc_sample_<op> functions below. 
>>> Otherwise someone could free it concurrently. It would also simplify 
>>> the ..._<op> functions, if they didn't have to worry about the 
>>> locking themselves.
>> [JZ] pcs_entry is only for this pc sampling process, which has 
>> kfd_process->mutex protected here.
>
> OK. That's not obvious. I'm also wary about depending too much on the 
> big process lock. We will need to make that locking more granular 
> soon, because it is causing performance issues with multi-threaded 
> processes.
[Jz] Let me add some comments on pcs_entry.
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
>>>> +
>>>> +        if (!pcs_entry ||
>>>> +            pcs_entry->pdd != pdd)
>>>> +            return -EINVAL;
>>>> +    }
>>>> +
>>>>       switch (args->op) {
>>>>       case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
>>>>           return kfd_pc_sample_query_cap(pdd, args);
>>>> @@ -187,13 +202,22 @@ int kfd_pc_sample(struct kfd_process_device 
>>>> *pdd,
>>>>           return kfd_pc_sample_create(pdd, args);
>>>>         case KFD_IOCTL_PCS_OP_DESTROY:
>>>> -        return kfd_pc_sample_destroy(pdd, args->trace_id);
>>>> +        if (pcs_entry->enabled)
>>>> +            return -EBUSY;
>>>> +        else
>>>> +            return kfd_pc_sample_destroy(pdd, args->trace_id);
>>>>         case KFD_IOCTL_PCS_OP_START:
>>>> -        return kfd_pc_sample_start(pdd);
>>>> +        if (pcs_entry->enabled)
>>>> +            return -EALREADY;
>>>> +        else
>>>> +            return kfd_pc_sample_start(pdd);
>>>>         case KFD_IOCTL_PCS_OP_STOP:
>>>> -        return kfd_pc_sample_stop(pdd);
>>>> +        if (!pcs_entry->enabled)
>>>> +            return -EALREADY;
>>>> +        else
>>>> +            return kfd_pc_sample_stop(pdd);
>>>>       }
>>>>         return -EINVAL;

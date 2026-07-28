Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD346C54F4C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 13:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5D610E904;
	Tue, 28 Jul 2026 13:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSZGkACz";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B18B10E904
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 13:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9H9NePhCCVkC6n6SdqWTvYPgPUk6CW/NgAqqahWvZVZcCwUySxGuOk3JKaXL17xcI25UqoTUCjbE+pqs82/B/ccxhifPtgKOgpnUlxXVzqXyjd7Wiz24J5Yd4Ajb74tdwOvESmHBZeSfyGqf6WnDLZpZmwNMPk46P2ibuy07nZEyJgxsS9n0w0OuX22lkXaE/B+0ARQksH8VPmyo5dPtdV9KOYdek9xc4uATW6olyzEIzb818UEctcj8DVX+4IxrE2Kf2TlUwEW5kr6Ymacw3IB3KDthrsoEsRh8ZMjTo+D+ZpufFR/q1MHAMZFaM+k/OfttPxs7c6HV93JK1RJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFMLoR531h8Vi+T/5bgOSIJuBrTPEh/G4nZIPHnGgao=;
 b=GkLZmThx3m/n6SukSBXL015EwrjYp3WKvQQ/ytA5OMCVHaYQrTJVtfBJR5H3F+RO5jc/d6wYJ0qQ1RNLYrYfsXYGQ6CLIyW4Zh16iSQaypt/+8hAB5uaIUgzlczw/6VQ7+fFzHbuNNDP/nGWMheDh3PPAxkzDRjeIkeSi1pxFnv54xDrp5rL6qZonu7HZMnorAVVrXKvhonVx9rwpWwuHS6yNS9/kqtwtpeug9if3j5LYVHFuLuGKek1Ij9zOAktGXE/MJmEXiXLPZiqq9ocb3vTDLEtGJL6TmUskSxFmDioeTDIktqpmXLkVEhljPD4EkJKnp5leANc/O3mokM+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFMLoR531h8Vi+T/5bgOSIJuBrTPEh/G4nZIPHnGgao=;
 b=QSZGkACz5WSuTeU3B6mtYs86Cc+gwb9ocqL10y6tEy4YLCwtDNmp4ShesZrduc4onSteRHr3tiL7ZVYxilYFm8hYDne4RNwn7SLqK1VGWXcEUM/zcLVzEfKW9NZ6kUdpHchwvKKK15oRR/X8sbhhXXVEmr0gVAgUmyeFkPoz3ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 13:35:27 +0000
Received: from SJ2PR12MB7800.namprd12.prod.outlook.com
 ([fe80::fc35:3b7c:16dd:a5cc]) by SJ2PR12MB7800.namprd12.prod.outlook.com
 ([fe80::fc35:3b7c:16dd:a5cc%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:35:27 +0000
Message-ID: <3e87aa14-3087-4c7e-9290-4fcac84a1beb@amd.com>
Date: Tue, 28 Jul 2026 19:05:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add trace events for pid register/deregister
From: "Khatri, Sunil" <sukhatri@amd.com>
To: "Francis, David" <David.Francis@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Liu, Shuzhou (Bill)" <Shuzhou.Liu@amd.com>
References: <20260724132100.1337346-1-David.Francis@amd.com>
 <13e91e3b-d134-4175-9a21-19ddb0b01b62@amd.com>
 <SA1PR12MB8144502B9A0E12CEBA235AB7EFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
 <4009684d-a24a-4cd5-9244-d92110b33ed5@amd.com>
Content-Language: en-US
In-Reply-To: <4009684d-a24a-4cd5-9244-d92110b33ed5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::10) To SJ2PR12MB7800.namprd12.prod.outlook.com
 (2603:10b6:a03:4c1::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7800:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 33171857-f610-4b48-0ec0-08deecad15c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7dZMB6gOC5zaN7J/E4bt8Tm2jCuOy0g0Tx1XA9hfkY6FMxPZW0dHWBfI0+TX46eyI3jx0rWDSYWDO00ohpZLUlMsfgAL2Jb82/kh7zyy4753mWFBIivLEsXpYwiLX1CXosSrH+RDcUk9LNUqpb8sI7e3i3y+WgmlmTEsjCtpYziUe6F6gDVUtJ6YRe1scXC/H7SkLmNc8jGkamtkezmGcOQjIPXFDAw1/uWq4P9bDLpX95PaGxbDN8U8eW3pEuTdu2vLC80xlxCyYnDAeUvdmAhsgbEoEVfaPUCsoEoKQ67/tPcIp2fD1DX+yuwU2jXwSqsFlh9tlYvVJMpb/QUCF9K4kxMxlQpZxRS4DOS2I/O+lSrIFSn7D8c9Cl87WBT5BMoK5A+9dqZ4XiU4rC8UsAXz2X7MKziVcNKGrnc/hepidT78ShwGVKx+KHrGUvw3x9/7rlGQVu5NSyN2gnM2XPCFWlsv7i66EqpDmYtXZGVqc0N7o6knZrtMPLeCK1GdYEWfftKYXf5HNiZOhEDrW1L80wbNvv4VRWHY7M4O0n7rmlf7TNzS6WX1O7MoqUZY1P/bE63lXGx4qS7XyzSLcBUILqEllO1vHwOxSZpTZ3uqPuoZ7PUpNgGCy6y7tQg/U0YA4wS83zBH83PLBT9wh8s/o/k+eSNTJiJgDJEHdpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB7800.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGthY251Snh1OHdjRGRkaFNKVEw4dnBXSUJYVFVJMEFOMEIvd2ZwZ05wN2xL?=
 =?utf-8?B?WkJQYmJLSU41bXF5OEtkSmxrU3o4UDEyYjFOZ0JFOXBDYlFrWmU3Y1pVczJt?=
 =?utf-8?B?cGRLNDRxRm12NFlOUTZsVVdDTGZwRTBYckx4MnhIWTY1Y2IxSDBSZFJTZ3Z0?=
 =?utf-8?B?dVV4T2doWU9HVkw4Z2xJTTh0dEo3TlI2VWdHWFNDMFFyLzM4akFqNmpVcVpi?=
 =?utf-8?B?RmhXNy8vZTVFSXdWUXAxbk43TzE3ZmFodTBXTmtKZCtya01ZNkcvejM1bU11?=
 =?utf-8?B?N1dyQ2dTYXdFVHRqZGVDYk5DMU5aOXUvaVRtRmsvODV0M3BsWXFMNUZ4SDZo?=
 =?utf-8?B?V25BZGhudzRvcll2dlR2L3NDbG56Z0R1ME1zR0JQWThJc2N2b0xjcnhJZHln?=
 =?utf-8?B?SUpneW4vN2xod0RBbFJJVmcwWjlwWU1CVGVXd3NPMEZpR1JsZlU1aTFnc3JV?=
 =?utf-8?B?ek5UWjR5MlVTbklmdlRZM1FSNFp1WjJ6c3NLaDc0V0ZFM1RBTlI1dGdyYnRM?=
 =?utf-8?B?Q2tUdVFoYXlNbHJwL21STzljK0k3U0hmZ0lxaldqN054a1hwZ3liQTY4NElU?=
 =?utf-8?B?czRaRGVpR293Tm9IOGdoWElVOGQyN0RKQ1gwVVBqN3U4TUF5cVIycXlyd1Ju?=
 =?utf-8?B?TUhNRVpYWHlKVXBrQ1p3NUFsKzBKSEg0alhWYkN3TXRXTm5iOFZxdnNBTkM1?=
 =?utf-8?B?bnRyeDVheTB5V1l5Y3VOdUhMMHA1cEpqQVpPalpCUzNkNk1lRkRRS3hZTDN1?=
 =?utf-8?B?cXdkZVVZWjBKMTNqV2pVKzFvQTZsNVFmUUM1WXFyL3RvZnNRN0xkek0xNkRw?=
 =?utf-8?B?cHVoTExla2NCVzVjdE5BMThYL3BTWUxkaHBRLzhhREFaY09iSjk3RldsaHhH?=
 =?utf-8?B?ZnFJcmJQcUJnN0FtVjRqa0h0WW1XUFpmOWJvSWNhbm50U21lL1VGNmN6TUpE?=
 =?utf-8?B?M1lGMSt4ZUxhbDMzQWFycXVZcFFTcG0zK2R4NjdkNEE2cFBkSTErN0o4aDNM?=
 =?utf-8?B?MHo0T2RkTnd6SFBQY2FhN1YrNWdJTk5VVzFNSGI4UUZ4RnlpNFIvZ0I5dURF?=
 =?utf-8?B?QysxaDhFTUlMSnhsMlYxNUJTb2N6Z2M4YmpNcFlSd3hzbk9VY2lDZlJvZDdE?=
 =?utf-8?B?V1E0MDJIdkoySXo3VCtRNHI4Q1N6TjlCbXhyRXRxSXRtQkR4Y3ZRY2JMUkt3?=
 =?utf-8?B?YS8yRUlqWnJQYnFQaU1GdXBKK1FaMVg5cmZvakd0dmtnclFqU1dQNER1Nm9Z?=
 =?utf-8?B?anRHSDdzRW5CaGtJZVBCUzlncmNFVUdzTURUN3NBeTVtRzNPS1VaTlg4RENj?=
 =?utf-8?B?SU5GbERXbEFHZ2JwV0E5RVI4dkxTRnZwZWEyUjVCc1paZkZIc2YvZEIyQVdX?=
 =?utf-8?B?ZnhQUHpPUmxVZzF5TFY3em1xckxQNXVhOWh6SHFmY3g4dmo0ckt1cmNhZUoz?=
 =?utf-8?B?WUFjc0ZLaHR1VHlTWEF3ZjJoeXhhLzY0SG1qZ2V4WWkxd1ZZQzJlWU1ncEtZ?=
 =?utf-8?B?bVlBUGk5aDVjN2d1TDZ1NEcvQUplK2c3SmcxV25vSjQwQkxmQlhzZWpnYXR4?=
 =?utf-8?B?cU9TZDREUGZRdXVyWTE2bDVuM1BtamhHcmk3VDJaV0E4Q2JkWFR6dElUK2pO?=
 =?utf-8?B?c2N3OENoOXFoWHhFYjA2cjlvYytNa3VwUGdmRHZvcE5CdVRmQUpIdVE5Qzh2?=
 =?utf-8?B?RFBDVHA5Wlo0S3Z6RWd0ZVNyM0VQcEdHQjZ0R3k1SzNwZFVvbXA5aTNZUEts?=
 =?utf-8?B?eG5TVkw0ZUl2Y0JnNEM1OEFiQVR5dEVDOHAwRmg2MXRrcEhGU1dJbW4wNW5R?=
 =?utf-8?B?ZTVtM29lMHpYNFV2TFhOc0NXODV0emhXeWV5SlREK1FCMkx0bmUyQVRLWW9o?=
 =?utf-8?B?SUhWL0NrMG5PaE03clptWk43V2lrdGNrcGVlK2pHRHpFWmthR0tYcTYra0Va?=
 =?utf-8?B?UTU0OXVDeDgxUGVhNFdTNmxYUEFXRXFQSkhyQ2R4WGR1NlN4OE15b2VlTWpE?=
 =?utf-8?B?U2JNZlE4VGEwWVQwbTFjOURacWxVV0laQ0NocUdUOTQvcDRmWm4xM05xbzlJ?=
 =?utf-8?B?a0Z3QlZWSEJkazdQZlV2UG8weElTeUd3Q3U5Qyt3d05oYzRqMllibnpoS1J6?=
 =?utf-8?B?UjY3a3NXM3pCcllXNm1wNnAydDlSK3lRY1Z5Qi9kdXo1eEhBa1phR1FSZ1Ns?=
 =?utf-8?B?VVVjWitKTURCemxGWEp2clNmOWtXQWY1bzJGamE5bkF3YVk1eXhOMlpudTRn?=
 =?utf-8?B?dnZXRElqc3cybmxVaFBqdVNtMm1ZVURBWjhQazY5ZUc3eVJsb0hKay9YUmwr?=
 =?utf-8?B?VW1EcDJXZUFSK2RTbml0VE5JQk9EcEl5UE41UGQ5OFVJa0dvUk1YUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33171857-f610-4b48-0ec0-08deecad15c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:35:27.5047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kE0sWNh9hFxU+9PaK9uHGzQEGG5iX844ENMruv27TfK56L124B+/5DF0LJHVazVACe5rlGbYN1RXKUzjVIvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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


On 28-07-2026 07:02 pm, Khatri, Sunil wrote:
>
> On 28-07-2026 06:45 pm, Francis, David wrote:
>>> This function is called from many places and will not match when a
>>> process start and similarly for stop. Better find a unique function,
>>> also this will be called for KGD and KFD processes too.
>> This function is called when the last ref to an task_info is put.
>> Many places in the code temporarily acquire references to a task_info
>> but only amdgpu_vm holds the long-term reference, acquired in
>> amdgpu_vm_create_task_info and relased in amdgpu_vm_fini.
>>
>> Tying the trace to the lifetime of task_info also guarantees that
>> there will be exactly one such trace for each task_info, matching
>> the register trace semantics
>
> For begining, amdgpu_vm_init sounds like a better choice

Anywhere After line , r = amdgpu_vm_create_task_info(vm);

Regards
Sunil Khatri

> for ending, amdgpu_vm_destroy_task_info is correct.
>
> Regards
> Sunil Khatri
>
>>
>> David Francis
>>
>>
>> ________________________________________
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Tuesday, July 28, 2026 8:26 AM
>> To: Francis, David; amd-gfx@lists.freedesktop.org
>> Cc: Liu, Shuzhou (Bill); Khatri, Sunil
>> Subject: Re: [PATCH] drm/amdgpu: Add trace events for pid 
>> register/deregister
>>
>>
>> On 24-07-2026 06:51 pm, David Francis wrote:
>>> Some debugging applications need to track when a process starts
>>> or stops using the amdgpu driver. For those processes, add ftrace
>>> events that track when a amdgpu_vm task info is changed or destroyed.
>>>
>>> Signed-off-by: David Francis <David.Francis@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 17 +++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 +++++++
>>>    2 files changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index 5324030a13f5..c79604b9dda1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -732,6 +732,23 @@ TRACE_EVENT(amdgpu_userq_state_changed,
>>>                      __entry->client_id, __entry->queue_type, 
>>> __entry->doorbell_index, __entry->to)
>>>    );
>>>
>>> +TRACE_EVENT(amdgpu_register_pid,
>>> +     TP_PROTO(uint32_t pid),
>>> +     TP_ARGS(pid),
>>> +     TP_STRUCT__entry(__field(uint32_t, pid)),
>>> +     TP_fast_assign(__entry->pid = pid;),
>>> +     TP_printk("amdgpu register pid %d",
>>> +               __entry->pid)
>>> +);
>>> +TRACE_EVENT(amdgpu_deregister_pid,
>>> +     TP_PROTO(uint32_t pid),
>>> +     TP_ARGS(pid),
>>> +     TP_STRUCT__entry(__field(uint32_t, pid)),
>>> +     TP_fast_assign(__entry->pid = pid;),
>>> +     TP_printk("amdgpu deregister pid %d",
>>> +               __entry->pid)
>>> +);
>>> +
>>>    #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>    #endif
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index aac8ace9d7a6..8d31a61e8c26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2457,6 +2457,9 @@ static void amdgpu_vm_destroy_task_info(struct 
>>> kref *kref)
>>>    {
>>>        struct amdgpu_task_info *ti = container_of(kref, struct 
>>> amdgpu_task_info, refcount);
>>>
>>> +     if (ti->task.pid)
>>> +             trace_amdgpu_deregister_pid(ti->task.pid);
>>> +
>>>        kfree(ti);
>>>    }
>>>
>>> @@ -2543,6 +2546,10 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm 
>>> *vm)
>> This function is called from many places and will not match when a
>> process start and similarly for stop. Better find a unique function,
>> also this will be called for KGD and KFD processes too.
>> Chose a better function to add the trace although trace in itself is 
>> fine.
>>
>> Regards
>> Sunil Khatri
>>>        if (vm->task_info->task.pid == current->pid)
>>>                return;
>>>
>>> +     if (vm->task_info->task.pid)
>>> + trace_amdgpu_deregister_pid(vm->task_info->task.pid);
>>> +     trace_amdgpu_register_pid(current->pid);
>>> +
>>>        vm->task_info->task.pid = current->pid;
>>>        get_task_comm(vm->task_info->task.comm, current);
>>>

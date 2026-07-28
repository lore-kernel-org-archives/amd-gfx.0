Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481B1C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6CB10E579;
	Tue, 28 Jul 2026 13:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HtARyEwI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D461910E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 13:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMmcK38Tfjcm38sh8BWelJVNoSKjSKqzK8w/WC45Gj5JsoQK8I+anVcnIiXBnWztJESoUJl+blGuwHPPwgJMo/DMPs8GCAEOCv7SjauUj4lv6Ceo6c6s0r2pAgPUhZscdDx4Tfu4UPNw9al+9zeCT58/5vSK6tXsiUJkakC7A7hohMMFsICmcw/VIokKTNoSlc8ErHSiSEdg7VknQWLBuVGo47hEvA9nNzp87rhwFT0N0Mbf4/lNjNo00AID4XJzhMVTs+9fiay7cC7NjFkcTufmddfrkoxubnVX3vKiGmyVwHm8LwGMidumnmizGhZ6gLCBgjGH/jgjbOoj5NNEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2xOvY8Q8luAHncDENNfcY1E1N9e/DY/0bykb/rxN6c=;
 b=PZsm1khBbYw88RknjAAMeFEGeIJvjW95GTkGG9w1gFXTyjBZH0tcG1H1iY8S1tvE1kP1HCa09VuFYUFvqrQzZ10hUF67b1+mRdNfkScnkOMDq1tWJEMvjtBtu36hBzZ1FOdKqA2AV6ft2tEWYaiWWij3unRDadogYQ2RzTaaVvF0+DO4Cngz4gPOOHTObqSPxYUrtMvNK+0IhM030gcdZA1A/pAuSE2IrZKUuzqhQ2g3+6Bd3+chxyN2ZbteDpe82sXlTJFnfFL9QN4myGZSeCHUlsCsKGv2gy90HIJscFPR5N2DibWTIa0YYpdq+xL7ry7ljA5qdXnOgLQmEhy7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2xOvY8Q8luAHncDENNfcY1E1N9e/DY/0bykb/rxN6c=;
 b=HtARyEwIvhwIvQKX5innp+FRj820HGIwgG41qTXtBPjsWfqNAh0VKkQaWhLxx7a/dNwyE3BCYpg31e8lI939lUfQpQmkyHrKDklvpWtYVrl0peTOjla7JARcLIFxu2sc3+frSASOz7QCle0jayYLfiuQvV0nyRrjt79ktmID0dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18)
 by DSSPR12MB999214.namprd12.prod.outlook.com (2603:10b6:8:378::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 13:32:35 +0000
Received: from SJ2PR12MB7800.namprd12.prod.outlook.com
 ([fe80::fc35:3b7c:16dd:a5cc]) by SJ2PR12MB7800.namprd12.prod.outlook.com
 ([fe80::fc35:3b7c:16dd:a5cc%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:32:35 +0000
Message-ID: <4009684d-a24a-4cd5-9244-d92110b33ed5@amd.com>
Date: Tue, 28 Jul 2026 19:02:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add trace events for pid register/deregister
To: "Francis, David" <David.Francis@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Liu, Shuzhou (Bill)" <Shuzhou.Liu@amd.com>
References: <20260724132100.1337346-1-David.Francis@amd.com>
 <13e91e3b-d134-4175-9a21-19ddb0b01b62@amd.com>
 <SA1PR12MB8144502B9A0E12CEBA235AB7EFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <SA1PR12MB8144502B9A0E12CEBA235AB7EFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0325.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::17) To SJ2PR12MB7800.namprd12.prod.outlook.com
 (2603:10b6:a03:4c1::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7800:EE_|DSSPR12MB999214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8387ce01-1d22-4b94-31ca-08deecacaf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X1ALrYF23pJ6hcjSNZAFJs0GzZ/iqz0N3tqjC6JIeUEp2gHggC00g4/EVaFQM9IQqUBdu5za28vGnWUeffDKIDRigOcN9+t8FXCbyDBFNICJH17ULVWGiL5ydPR8/ojIu+uMHga/+hMCt6l15b2Esv8CNUT4NMBatMPzWTnYNaTOg3qmAdNdc16rWRTZHdaGlJmSV0l2rQls3cOtwX6Da6Pg+mwQkrQHkPqkP18bU/ZTJyQH/9qaT6bqDWGXUfYvGKrcmyXq/OEaKfyvoJCiMO8cqqqIji1nq11XtYmlG/Ui2SrXA48kTIgBTNSnRF2oZcsLi3ms2tMa6riJAwSDoxU8b4Cfoo0vYdf+52ggdZUODXk3Zj1oXHPV1wqY6hK5RG4EY4CZfYT04C6OX2FBNVz3eTYNi3Oh73a3w2+HL8dgRhqO5JfVTxeNcrOcrkT0gx2WHah6G/0PJVwciumo63+7DrDDBkKXKRduJZONk70kK55pAKWehdIdWkTipxkU98abRhDr2PGixwC+Wp1l5MNbAwADG18FsX7Qx71NE0FKQQv8SfGmMU60wDy6xmabh/1ElUfLlCq2WfRxa8tIrq/amoP5Zm+aTNxLpQUq0RAK3lULOzrNKqiS+iMyx2rVXs4Aud8l21T8OtaArNXLzzBdpWGWN3NDYftE9lojgOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB7800.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhTTUNFOGhGT1p1UTJPVlJLZW52RjBKNFRnanZ1cnF5YW05MlVyMGR0WTdx?=
 =?utf-8?B?MzRNaXZ4bUNmWnZQdm5SOXRYRUtmVU43bmVSMmd2RExqZmllNWlLZnppWHJ0?=
 =?utf-8?B?OXRPeW5hV1Q1M2x3eStCVFRMSjlGQytGYStQYUZ0OHRHQTRzTHdtSVlvZ2pW?=
 =?utf-8?B?a2s1TUl4VGxzSE1xNjJhdElHWis3dFQ4MCtqakh2MEQ5Y2VGZVNvWGgrbWNj?=
 =?utf-8?B?NUhRZXNYM3djdDlOYUwraFpIY2I4ZHowUWwzY2NLMFVxb2ZuQUo2MmF3UDVn?=
 =?utf-8?B?bEkwSEpZbFY5RENoVHUwemhIMVNKK01mcXBiWmtwQ1RZNTR0MVBZZDdwa1lw?=
 =?utf-8?B?MjdTZTFtY3dQZFM2Y1V2VUMrUndpK25qSS9JRzg1OENhSmlEL0lHMm8yZkhi?=
 =?utf-8?B?aW1OK0Y3bGZKYXU3WXdpbG8zcXBUTmpQcG05N0d2S1JFNFB0VWpZTGZQUVBG?=
 =?utf-8?B?SzBuZWdEY3hKY0IxTjlmcmpxSDEzNFpoQTZXd0FKRkFTN1Z1ZWRuUXA4L3cx?=
 =?utf-8?B?VUNlUDQrbmFuK2xiZ3dGL0VFTFlISEtXam5MYldEOWR1Uyt1V3RnKzArcjh4?=
 =?utf-8?B?TDY0OXVsd1pLKzhxSFZYWnBaeUphOGxMSXJmeFE4VDcrdU1GWi9wRzFqMkQ1?=
 =?utf-8?B?R2FJaFNhTXNDL0IrNWVnVy9lSnluc3BFZHJ3ZmZCRzdLLzlrMzlUMFd6OUFx?=
 =?utf-8?B?MWtKM2lEb2ZJaFk4dTBSRnhibXM2Z1pZRTVMbDBseUcwR1E4WXkrekVHQlVn?=
 =?utf-8?B?b3hLQ0p2aUpYUjdiMm14d3FvU2wwT2ExQmNUVGJxSmI3NE41MHhPMmZYb3I0?=
 =?utf-8?B?YWFVZXdPckNPUDlFSk8yaTMrZTdPOVhzNm1aaXBPSWUzNy85YUVBYXJpZVN1?=
 =?utf-8?B?VG9Ld1dKQWFOZ2hWb3NmWHNlSTI2YlllSjhZY21lcytmOHQ4dU9zS0JtR1Uw?=
 =?utf-8?B?YUViN01KR1lqVG9CZzNrRGVuSncvWWhRNEtmd3pkV1pjUHJETEg1MzUvenRL?=
 =?utf-8?B?eHVCaVlZZVlZczhJVjVlZmV5Q1lqZVluY204RVZON2JSOVdReTArTzJIVEVH?=
 =?utf-8?B?Z2d6REQ0M2hlU2p3YUVjTjJQU0ZPYjhzTXZaUlM5cGhYK3hHejV3dUNla3Mr?=
 =?utf-8?B?UHoweUdMSFl4SmFmQ0xhSXJPQkdhV1pZeUFTVFNKRVRwVEgrUTVVNVFuZGZQ?=
 =?utf-8?B?UGlSc0NtZC9DMFBwNVBxcFVnT3ZGUnVKRENpSjhwWUxQL1RvZFNjZE13WDB0?=
 =?utf-8?B?YnBLSGNCNjBhRFZXK1BtejREREhua0lhWWt6RDRJblJxQThFRC81L0N5RDE0?=
 =?utf-8?B?c2NsaFdVNC83Y0prK2oyek1vOXFDT3Z1UUNkSExKUUhjbFp5UW1SRnFPdXJn?=
 =?utf-8?B?dXh3Q0RibTV4SGJsYmVxcWRLTDhZYzlCZ1BranU5aWZlZGswVkJ2Q3MxSXlM?=
 =?utf-8?B?TGcxc29JZkpVa25kaDZPZXBHODM2RXVaQVoxdjk5NmsydEtUckk1YVlRSFdk?=
 =?utf-8?B?MmEreCtsd1dlTnNScmlBVmJtdVdmcTRSeGMvdDFJLzZDMmE0SnZPbzgrcWZ1?=
 =?utf-8?B?NE40SC83Yld4ZGNrQUd2Mnlyek1iQTQyNEZkaUlacHhlL1gvODI0dStXcFJp?=
 =?utf-8?B?U2dJaFRtMkZ6UmpSSzU3ZTFNSnllOE9INUNEWEgzNFdocVpYKzUrQXhrUVpT?=
 =?utf-8?B?djhPbFh6NWJKdEN0QXZEN1hPTnliODRCNW40ZS9ydTBEblVxbHNFWGh0VGRp?=
 =?utf-8?B?VURvRjhVQlZJR2Y2YzdwbENwalJRQmU1SzMxb244V1l3T05zWWp3Z0Z6VTlh?=
 =?utf-8?B?a0hZNExJOTBZbklzcDBRazB3OWNHaG9nNk9nMW14dE1VTS9DNzVWVCtUK1dk?=
 =?utf-8?B?MXhkcTlZQ0ZQUU5hVm1xRVVtRWo5RXFycWx5OFJIUHNyT3A0bmw4VzFYMFpL?=
 =?utf-8?B?dnhZY2RUQ3JmNlFhRGxvT1pYeUpieVRXMTBGckdKN1ZPNUpEaFdMTmpiNitQ?=
 =?utf-8?B?YzNpTVVQc3p0WlJIYm81UVY0Q0FPOHpwTDdXRmROYjl2ZThQRGVqUHVGSFVC?=
 =?utf-8?B?bkxwZ0tJbk5OWmJZUkFHVUFSR0xuTkZYdUwya1RzYmpjeElNcXlZL2pjNHJ6?=
 =?utf-8?B?Ky9XTFdWdkt2QVNldWFVYk0xZUdPRm5YUllvQms2NzFTRy92VUhaWlN4alo4?=
 =?utf-8?B?OGhSckh1VkFJVVNhWGlEZW1oRGp3djUxRUhSWENDbmpBVjRiU0RqVzdCazI0?=
 =?utf-8?B?MkxvZ0dBaVZ2R2pZZzdOdjhBQVQ2c0ZwRmhkOG1aV1JvYjBJWnE0T2UwZXY5?=
 =?utf-8?B?WUJ2dUJNRzB2NzRTakhoMG9oKzJVbEdoL1BHeFpvdFY5dzFkWEtsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8387ce01-1d22-4b94-31ca-08deecacaf1a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:32:35.3072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1fgByCUBbtqpGWqmdwOioxXqcYXzZmNIXhME/0Xi/IaBivbxVC9AJrJXM09mHLce3oiGrOiI1B2AJxvySQoiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999214
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


On 28-07-2026 06:45 pm, Francis, David wrote:
>> This function is called from many places and will not match when a
>> process start and similarly for stop. Better find a unique function,
>> also this will be called for KGD and KFD processes too.
> This function is called when the last ref to an task_info is put.
> Many places in the code temporarily acquire references to a task_info
> but only amdgpu_vm holds the long-term reference, acquired in
> amdgpu_vm_create_task_info and relased in amdgpu_vm_fini.
>
> Tying the trace to the lifetime of task_info also guarantees that
> there will be exactly one such trace for each task_info, matching
> the register trace semantics

For begining, amdgpu_vm_init sounds like a better choice
for ending, amdgpu_vm_destroy_task_info is correct.

Regards
Sunil Khatri

>
> David Francis
>
>
> ________________________________________
> From: Khatri, Sunil <Sunil.Khatri@amd.com>
> Sent: Tuesday, July 28, 2026 8:26 AM
> To: Francis, David; amd-gfx@lists.freedesktop.org
> Cc: Liu, Shuzhou (Bill); Khatri, Sunil
> Subject: Re: [PATCH] drm/amdgpu: Add trace events for pid register/deregister
>
>
> On 24-07-2026 06:51 pm, David Francis wrote:
>> Some debugging applications need to track when a process starts
>> or stops using the amdgpu driver. For those processes, add ftrace
>> events that track when a amdgpu_vm task info is changed or destroyed.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 17 +++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 +++++++
>>    2 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index 5324030a13f5..c79604b9dda1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -732,6 +732,23 @@ TRACE_EVENT(amdgpu_userq_state_changed,
>>                      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
>>    );
>>
>> +TRACE_EVENT(amdgpu_register_pid,
>> +     TP_PROTO(uint32_t pid),
>> +     TP_ARGS(pid),
>> +     TP_STRUCT__entry(__field(uint32_t, pid)),
>> +     TP_fast_assign(__entry->pid = pid;),
>> +     TP_printk("amdgpu register pid %d",
>> +               __entry->pid)
>> +);
>> +TRACE_EVENT(amdgpu_deregister_pid,
>> +     TP_PROTO(uint32_t pid),
>> +     TP_ARGS(pid),
>> +     TP_STRUCT__entry(__field(uint32_t, pid)),
>> +     TP_fast_assign(__entry->pid = pid;),
>> +     TP_printk("amdgpu deregister pid %d",
>> +               __entry->pid)
>> +);
>> +
>>    #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>    #endif
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index aac8ace9d7a6..8d31a61e8c26 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2457,6 +2457,9 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
>>    {
>>        struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
>>
>> +     if (ti->task.pid)
>> +             trace_amdgpu_deregister_pid(ti->task.pid);
>> +
>>        kfree(ti);
>>    }
>>
>> @@ -2543,6 +2546,10 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
> This function is called from many places and will not match when a
> process start and similarly for stop. Better find a unique function,
> also this will be called for KGD and KFD processes too.
> Chose a better function to add the trace although trace in itself is fine.
>
> Regards
> Sunil Khatri
>>        if (vm->task_info->task.pid == current->pid)
>>                return;
>>
>> +     if (vm->task_info->task.pid)
>> +             trace_amdgpu_deregister_pid(vm->task_info->task.pid);
>> +     trace_amdgpu_register_pid(current->pid);
>> +
>>        vm->task_info->task.pid = current->pid;
>>        get_task_comm(vm->task_info->task.comm, current);
>>

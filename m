Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03CDC54F52
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 12:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A0C10E595;
	Tue, 28 Jul 2026 12:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bi3v46Vn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB2510E595
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 12:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXDEZpiOgB3rE3d/ORPNok6/KD3wkgi3dS9poMkiEbPN8YQd6xR757yybdyhzVzaOXDb2DxPr4huxl5nL27/jHgMyme6MHeQZSFo2Yt9pdGfhu00/ETn8eDkXkVHVkZ7mduDTFQtEqt59Bz+QpOzWv0rldMzeUNpBf5dGyOAsC9en3MLbZsu4ADb+Dm2/PtaA6PKp+FsROQVWkAePZ9DzmM8AKwUx0iKBYwZqy1MZqj8JKOdayvk9aGC5ZpxmNim14qem1xwyH42/CgJnhkUegnfDsCgCHJF0IINv4zYTRPFbnxHgYHP4NJnglepQ5RfplNqbzy+kHI+pvh90C7NNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0puxfRF3EjyxGkzGFo2GMMBD1t7J0vf0WuNBu//Q1e0=;
 b=h628N5pWBEgSMK79++ya3K7v47qV8RDbJ1pjM65VRMDeKAIw9UfwvYCLUpmqRLVoW+8OHAFxnseXduLChDc3+3Mjj/QFES8SDU5ZN6Y55Chd6h0Dd3WIYhttd0wGGfas7MbEoQWjfl+y/HciFBH21p2rvuz4wAlT/fYndiHIFqalS7PdAycJ3EWVGMf3fvre/4G2FIWxvnc4vXCII0VMLwS/WqHSRxBcu2DPm/pZTuX8/Wo0PYfOgBdJABdCIGiTEh2RQtQDgr+XKzIz1OF5juCwQbLJ5XzhMuweotSHjQhWSIuxWw0OMLXPEsBTol0+A/Arlas56dTV248ff+cvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0puxfRF3EjyxGkzGFo2GMMBD1t7J0vf0WuNBu//Q1e0=;
 b=bi3v46VniLS/NN0g8+MJefqMcsuQeirX86eI1CNwewqbh2CCk+qjmV2WZtlNF5PGpXkbk2jvQbk6oHSdnl0eB+ngIUdNhSFR8OmGQZ+MN0rcfogwxZ5aiwrJ7nfkOn+M1tm5CJLk/IWoOBxDv1OH/mqMyAYn+vuaqMD1IMK4yeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 12:26:42 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 12:26:41 +0000
Message-ID: <13e91e3b-d134-4175-9a21-19ddb0b01b62@amd.com>
Date: Tue, 28 Jul 2026 17:56:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add trace events for pid register/deregister
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Shuzhou.Liu@amd.com, Sunil.Khatri@amd.com
References: <20260724132100.1337346-1-David.Francis@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260724132100.1337346-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0311.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::6) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 151d4e66-afe6-49da-2af6-08deeca37a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gIZtMOSYKJDyJLwt0fk7bBCZg/UxSqhwgX463yYow8bprdyS9sMbS3+spAQpN3lnK/f+jWHmWx9GBl6WXD14uOj/el+9Qza/Bjvi0+nlYBkPvty/fk9fW+QLk1+L0414Tcrz95BXt8xNuq5o2oTYBcU6+lHA2p1yM6G5jx02tfW0tkgqEfBbEYqTSgbjz54X0WIOMiprCNnfrNaWifK1Ds6ZEC6oeEg53fE5ppAacNtfGfzxWp5Evl+yNayFUJNfTd/zpBtJbXTrQzKflAPVw0uqvm0GhMOBv4X+lIikI7lXYRVok+Vv4oftxm9pOpenlRwc35Y3f3x17jXSv6wEo2EI0aapCgVV3SvenUu48p9TiO+gDWj2EzFibSI4HBDSaZRL3b4vy//SmqlbuQODm4gisRW1F3A6/XS+OPl6vdMVqI8ScEdAZKReKQm5rRziYyq2wwq9ibMM431IkIeRyEsiyReG4PSGz2Q1gFLjQeRz1KRpqMmckj+lU899yf7FowkZ3/wwGmgmRgRt8peP4KCcEaI2B91Z4fenpoqUE2XoTEyxxNp5S/WqEN/qORbhzP6aB7qmdQWra+215UKs8DC9z6DdFF25dYh9ZKApFv5z26+yu+hCdxEXrF480lhL4JTbbuRgIwoYxR1yrC+Ib1reXtorBcuhPZuYB/prA0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5iaklEN0FGazFMbFRNQWNRUHRLWG9aRERxUktMQUVKaDVoZUpqcFpHeUxD?=
 =?utf-8?B?OVZOV0RSRFBoZE85NnpsYjVKMUR3WHRvK2VteGFxa2JjZTJtTTE0M3FDcWpH?=
 =?utf-8?B?eEZqRW9OWWJLYUY0OElja01Udk5iYUFPekhpdU82NGRHVnVnU1J6bEtYYk1m?=
 =?utf-8?B?K2lQOFB1OENNR0kwUkgxYURMbS9sRmNXc2pKc0N0ZXh6MnVtNnBNWG1YMFZH?=
 =?utf-8?B?MHMvSHUxS1RDNjY3OVMwR2FmQ0hhTjB5Y0hWcXNaSklWeEpxNU5vMkFudW9W?=
 =?utf-8?B?ZFpiVFpnRmVLK3A5RGkrVjZ0MnNZek9HRUIzS29LN3N5ZjhBcEtDbmIremxR?=
 =?utf-8?B?ckhQbmJTMHlrbjZCQnAvcHNJVk12RnlMd09pZGJITUlFaG1LNHI4S1N6VE95?=
 =?utf-8?B?ZGo0TUtGc1VZM2Nab1pweEtRb3lEdXY0TkZJUm5MRkg5ajlsRUJxR1g5RzJ3?=
 =?utf-8?B?NGx3SzdXQnJvcFhkM1dTckRvTXJzbUhrSkppYVpJNEgxT2RodU1heThTL1cr?=
 =?utf-8?B?N08xU1JQeVVRZjZPc0xRL2Z1NTVPZHFqK2lSaXhlOTJvZkg3TTVPTDBZK0Zk?=
 =?utf-8?B?Z0IxZGRmcnRGVzdqajRiR2lkb1FaNHBVRTBoQXBGcHJQYTQ5c1JCYkpYUnll?=
 =?utf-8?B?TitDMitzc3ZTbkdkSUtENG94Zml6LzdHS2I1UDYveitMY01raVIrOUR6NXlJ?=
 =?utf-8?B?dlBQM0N5TTMwckVwMGxFaFZNVWtyZ3kvOEpiN3Yrc1V5bWRQeHRoUUN1eGJU?=
 =?utf-8?B?OTlWRm9McFdtdE14WDdRME5VSFgydXoyRko3WWM5Q244STJPUlAxbU5QVXY3?=
 =?utf-8?B?NHhML2QwWm1aT05HRGJxNEcvVklyeDRhZ0hITW10d2tqcTg5NmUwV1Nzc2lJ?=
 =?utf-8?B?d1kxU09DamRlUHk3d3Jva1JuYm5oMlQ4SUgrOFk1Ym11L3VkeXlTbU1HZ3Zo?=
 =?utf-8?B?MmhZYkxuVVZzNnZZcU9HV1JVV2dneVRUZ1ZVSTlVZzNHR01wWmdXL3c0Ty82?=
 =?utf-8?B?RW5wZnpJMkJzMCtKK1d6d2xQODFZN2xrUHBVZGR5ZGMxbkRCNW9uRGZXSnZz?=
 =?utf-8?B?QWx4Q3RTS3UrNmNINFE1L0tnSElkdnlYR2tIemk5Q20xaGV0YmFNZlF3MDZJ?=
 =?utf-8?B?N0J5T0FqQStFSkFYY2REa1hUVCtpV2RYTEpjNUlhVkxZdUY4V2JXZ0FHNnhD?=
 =?utf-8?B?RlBvcGMrckFOSTVFZXd0cVVSeUJyNGlXKzdKK1ZwVFZlRjNWZFovOVJxb0NR?=
 =?utf-8?B?Zk1JVVR0K3YvSFdQUm1GQyt6dGszczRjWURkN2hTc21Xa204T25mSm5JcHFk?=
 =?utf-8?B?U1hJMzg4cFhvM2lJMUVYME5YTU1IOW5HUjc4SGhrVGJoNVdabnA3UWJMRlBP?=
 =?utf-8?B?TjYwbTc4Zi83bEUweDVoN003MXJWZlI4UHlKM2IyTlhRRmVJY3BGY1AxQzFo?=
 =?utf-8?B?aGEzelFQK2R2RHhiZGEvYnh0WCtudmpGdS9ybU44L3hpdmpUS1FPM1ZKWld6?=
 =?utf-8?B?TzE1R2UrUXc1eUlnWEZnOExreXZYZkkrQ0FUeVBmVkZIdDYxUDFTWkhLdUdh?=
 =?utf-8?B?ckh6eUhKZ1pIUGRjTEQrZHFxZ2hwTlphdENxNXdTOUEyTEUrT2ZFczdCa3ZL?=
 =?utf-8?B?ZWI0aUtleWlkNXZjM3AveHlaM0N0dDNwZWpzRU56SGtWN2REdXJRcFhtUXBr?=
 =?utf-8?B?dnh1bEZUVHh6Z1JQdWlXaWFsVUdoOTZlT1AvQS9ZYkR3dVBNVU5qMXBlRkpt?=
 =?utf-8?B?Z0FER0k0TDNYb1ZUd2tsdFRicWh5ejRMUllqaXl1aTVrZUxTcCthSVhJbXNY?=
 =?utf-8?B?RWRFQVUzNkd0Y3hVQkwxMzhaNktIUCtrT2twUUxoK1RIYlZzeWNsaXdxV29q?=
 =?utf-8?B?dTl5Sk9pc1daRmRIQVgvaUFmdFlteVF4YXRLZmVaZXFnd1FQYjh0WjVJWTFj?=
 =?utf-8?B?R2hWaHFKUURMTllXNWFOYTBUZk91SGpqM0tXdDA3S0NsejBWVE1RcGhQMkxq?=
 =?utf-8?B?S3Z0VHNYTHJ0M1RMVDJTRlc1TERSSEd1NmJSeVVCd3FuUElSZStzY3lPeURi?=
 =?utf-8?B?OWhHVEN3NUREYk5RK0llR21YV2xpdlRxMFRCTGZHWUNiUnhFTDZUMnRyM0xq?=
 =?utf-8?B?TjNrdHBOUzlhc2FEZTdqbC9lelk4K1JXZUZ6d3hxekxhTC9IOTVNd1RVd0lr?=
 =?utf-8?B?eFh1UkV5dVZaZjhmaXh5ZlZlM1JKcTdLdWZDWGx4TE5QN2hrL0pUd2o2aThT?=
 =?utf-8?B?VnJKWkEyN2tSQmt2cERnNVUrcVltKzVwQTBFUVFtY0lpNjBvOHBDN1RreGNE?=
 =?utf-8?B?Z3FtN3ljU2xqRU95ZERLM1FCbVlUajQ1U1FObW1rVTZvRVF0R3IvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151d4e66-afe6-49da-2af6-08deeca37a77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:26:41.5662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfonlhcknAWTC0bdkoGgQK74EizmHIYpTZOGJoP0u07UNlJyhooePUoWyJa3VQ6B+LLze9f1SlsFz4N3GmxMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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


On 24-07-2026 06:51 pm, David Francis wrote:
> Some debugging applications need to track when a process starts
> or stops using the amdgpu driver. For those processes, add ftrace
> events that track when a amdgpu_vm task info is changed or destroyed.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 +++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 5324030a13f5..c79604b9dda1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -732,6 +732,23 @@ TRACE_EVENT(amdgpu_userq_state_changed,
>   		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
>   );
>   
> +TRACE_EVENT(amdgpu_register_pid,
> +	TP_PROTO(uint32_t pid),
> +	TP_ARGS(pid),
> +	TP_STRUCT__entry(__field(uint32_t, pid)),
> +	TP_fast_assign(__entry->pid = pid;),
> +	TP_printk("amdgpu register pid %d",
> +		  __entry->pid)
> +);
> +TRACE_EVENT(amdgpu_deregister_pid,
> +	TP_PROTO(uint32_t pid),
> +	TP_ARGS(pid),
> +	TP_STRUCT__entry(__field(uint32_t, pid)),
> +	TP_fast_assign(__entry->pid = pid;),
> +	TP_printk("amdgpu deregister pid %d",
> +		  __entry->pid)
> +);
> +
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index aac8ace9d7a6..8d31a61e8c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2457,6 +2457,9 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
>   {
>   	struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
>   
> +	if (ti->task.pid)
> +		trace_amdgpu_deregister_pid(ti->task.pid);
> +
>   	kfree(ti);
>   }
>   
> @@ -2543,6 +2546,10 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
This function is called from many places and will not match when a 
process start and similarly for stop. Better find a unique function, 
also this will be called for KGD and KFD processes too.
Chose a better function to add the trace although trace in itself is fine.

Regards
Sunil Khatri
>   	if (vm->task_info->task.pid == current->pid)
>   		return;
>   
> +	if (vm->task_info->task.pid)
> +		trace_amdgpu_deregister_pid(vm->task_info->task.pid);
> +	trace_amdgpu_register_pid(current->pid);
> +
>   	vm->task_info->task.pid = current->pid;
>   	get_task_comm(vm->task_info->task.comm, current);
>   

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77BECA5FFF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 21:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D34C10E6A2;
	Wed,  7 Oct 2026 21:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VMXzu1eD";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC11C10E6A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 21:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWRj1dcckicavZxnpzf1jm4dmi29lmTlDUyFY4rUfBFlURQ7EDM1kY04y4AEjBMf6yUTGOE9LljrjwleMrkHo9EzwJvn1GXUM2B5USlgOony2f4zIEatjAysxZeBiJ424K3+Ku38lKqdEYKDD1Y6nvPBiP1oQUC1g+XYcTGqiBNbZWDYO3J5ZpRGdzSunlIfcjlcJlybnQU1t9fNft3WzaKDzbjGgzHxbMnXHF0+zc0mbgCJsMx/QITlL55rUypvpkf2vcCwbXpMgmT23BbRWaW5mVXNRDZNRDnlD6mfiMoVsmgzHz1FyNaIFN9BJeralnxL4P62hdeQPm8RD1YL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DuC9Psr6T2h5CEX56KvOLFUffXUt3pu4w0AL37/8TU=;
 b=uN+tgQfskmWt3Oyfwii+8ROOVC8fZJI4F0hJmSsGIZDTTYEWfVvTqZsq74/TEuUMySdr12+LExjSWkwjM09KyWdXktdqy8NGoagYOGa+teC72MQHo2uOmEVg+/DmKB9/n3Q1IrdTD0TyQenJGafPSKeRz3xmPbITAnrT7atI4Y1JnAUW6X62xIcaMYxTa6S0JcMd37/BaPbBF33g7gM4fCsJ3ZOSBj1RL7vrgPFq3XKRp1ckXSP54ZvIEqvomwms0pDXNJ0wpQRBzZdm/32SCQTd0Przb41m9I+HuAGlLHFvBD2JDOCqv4Ks8qykgEqKxpOo1kysNmdBoCGBbpKkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DuC9Psr6T2h5CEX56KvOLFUffXUt3pu4w0AL37/8TU=;
 b=VMXzu1eDjcjwTFVzWwgD/fEE9a0B/OW0w+pPrfla3d8rZfPVEuW7FmgRKZmWtOduSE9G+oyf7W5BdPCdaE6/uKE66v/NZMOIvp0+VbBbe+aIS3ok/oeRxwXA1laCen4Ry0vFI7L8/ZPcbKXdSkxOGkzcWyuV3kBKxHNxOu4pJ8A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SA0PR12MB4496.namprd12.prod.outlook.com
 (2603:10b6:806:9b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 21:01:25 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 21:01:25 +0000
Message-ID: <a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com>
Date: Wed, 7 Oct 2026 17:01:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Restrict CU and memory entries to
 resource nodes
To: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>, Dhruv B <dhruv.b@linux.ibm.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <cover.1791289746.git.dhruv.b@linux.ibm.com>
 <c1a0b1c06c7616c225bf1eb22fad4ca4d73eeddf.1791289746.git.dhruv.b@linux.ibm.com>
 <c4f3a215-531a-440e-a0e2-c3fbcbd4408c@amd.com>
 <9c600a6f-e665-46d2-9924-a7af08af092b@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <9c600a6f-e665-46d2-9924-a7af08af092b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::23) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1238b06e-6fed-4f98-82f1-08df24b6263b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|3023799007|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: tPH3Kmj5UYqmoT9fzilmZT6P4DsmSuVbe52lc9sYg1oJUUh58lAu+YRXopYEV7dzCeEJmhe3wIlVfIHVbnfN2nZsiTnOxobp9Pk1GzwdydOSRVThhK1Xc0dEvJbXzxpJPAeaApGSf7DT/iKEpoFofYJwCKwoQQxnMkOAK5QyVfE7QvFm90YeZghnG1drWRsFZNZKZYjnRsEzhbA7+0kFUEwXEN22jhAfXnHwVSEl9XPXrrRo7YSW8tldSZ3THp8chl6Tx/zQRjT+3cQBTXaqkz/TRyZip2cgr1HEO0hGGz74TGmpr1R6MVA7uj+9Emq+t8QVQ8G+zgrSkXqOFg2FRYAe825Jb5s/rFM/8uCrd6LmH2IcO87cYdkQ9ARSfWN9+W2mB5ABBUbEQh3ajB6jpESfMtMt+gp7y3c6KrBrs3DpijXJHGv65Ah+iAN2sZf/q9GgQN1qOwcmAxtza7VtqELKxFjiyr6+MyqCyKdryfeRw5CpIO9pFG3LgklWaY9wCk8MsuBsQHRKvE+MoPS+tl6HFOdV9nWxt5dPonXJzYNojJ6936dapBAikqsOFcrvav9pIN64wqUFSbhheSLxm1IkZeBY2XVGCViLqA9TAx7WHWlQdwCBAOEe5P8oDwB9hXUDiKac1Av1235Lec3H6dQpl2iAO3WJeXnN/rKToRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(3023799007)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVFORHpGb3ZjREtvNkQ4MnZQR3V6QnlmSHlHTjRnSkhSMlArajRKLzBQL2sx?=
 =?utf-8?B?NkJhckU4cTJCWHRXUkZWNTFGdUtWWWUrNlh5V1VxNCszcFFIRDZFREVTaGpj?=
 =?utf-8?B?N1ducVYvSHMvK0NYOUxrUEFsVTlKUmdRMFlDbDFTMHRFVjNwMUZiOHAxYlNS?=
 =?utf-8?B?dUFoR0tDVGI0a2Q1QkRGTEFDLy92T0g1TFo2TFZ1ZURpZjNnbjB5WWc3bU1B?=
 =?utf-8?B?dmd5bUI2azdzSWtTZ1MwbjRoWjhRN3lDQW1iQU1XZGhlNUNjbU5qNFNuckFz?=
 =?utf-8?B?cEhadVhDRUtEUS92Tngrbm9XVUhmRExtdkI3VHlYeFJ3dW5yMzRrMUJNaXJs?=
 =?utf-8?B?Y1ljdzZ3N3owMDBQMlRTQjRvSGdjV2xBdlM1WkFMZjJMblVoYXoyd0FlKyt0?=
 =?utf-8?B?U2NtT04yWlVnNXIwNWdJQjNmYkZSblhBQ0MzbUVEeXFVWVZ0dkxvRm9uUGtq?=
 =?utf-8?B?VDZPN2hFUm02TGxsOUdPVzJLSnNxR0tRU2tYWGZqakdGODhmckRZME5UV21y?=
 =?utf-8?B?VXZsU1M1OWpjdlFyL003bmlXc2d2Skk1ajYvbkVqMFQ2TzNkNDMrbHdUd0Zu?=
 =?utf-8?B?UEtwTXZLMyt3OHhleDFLUFd4WVhZQVFUOEpEZkVuRDYrbVB2K2VZY3o5ZHlz?=
 =?utf-8?B?WWRLbXJtZjJtWENXVk9tYnZkUlUxTHVwZzRxWUNZUVRvbmNtbzNxSTNNSXlm?=
 =?utf-8?B?L2N1elZZN3dHTVl5VzQ0VmtqUXJOOEtTSTJjNGVrcVQzT1p1Z3BuQyt6YmFu?=
 =?utf-8?B?Vy90RW1rUGs0dnp3eEUyellRa1NISkdLaGtnSmZ0RTdERE5IUmR2dStjanlq?=
 =?utf-8?B?b0xnclVHazhFU2ZqUGRZWVJzdkpWNEtmeWJLc0ZIR0tEOE9QQWFwUnFhTGtO?=
 =?utf-8?B?VlQwZ2U3RFdsdjBGZTc5OEVIeTF1OXJkelMwQmkzRGJ5TGFqQ1R5T2xMdGRr?=
 =?utf-8?B?TUFlcXBoZTQrOWl6MjF5U3Nad054UXlSSVVSdkxHTURQd3I3S2xPRktNbExR?=
 =?utf-8?B?Q3B5ZU13UEZvdk5xNGJmcG1RcW5kV09lRTdUTnRXRENtVDNNcE16d3ZsdVNZ?=
 =?utf-8?B?MWRjVTNWK1dKNXpIRUJWN0JxNmpwR1ZjbnZ1aWtOc2tRa3VMVnFCTlEvRFgy?=
 =?utf-8?B?Rzg4bVY3TEpXN1J1cndRdERIOXdoOXh4R0NmaE5RY05leEN0ZkJMU09UTTc1?=
 =?utf-8?B?RUlZR3h5TGFCVXlqNHZ2eWR1UWx0R1BYcDdnZVliN21tLzZJTkwza2RYWW9H?=
 =?utf-8?B?UUEvYllab0d1ZlRXU2dPR0ZsSTFVTSswaWNhUno2ZVdJalRtb09zNXV6aGox?=
 =?utf-8?B?K01EZStFbFB2Zmo5TGhmYkJWbit3YkRENnVZUzJWQVdMbnVhQ1FjcU8ra1JV?=
 =?utf-8?B?eWc5KytiN1hOcVJYaUVkcFNmMG8ybGNYYWQzRHZTSFFYZnNpbWQyeFhvaEFP?=
 =?utf-8?B?Wi9pWXNvN0RWWS9iVkovSVMrT0FJamliL3lYakNKc0pkcnM5K2swTzd5V1g1?=
 =?utf-8?B?NDJMMDBkdVIwZlZNUWxxeWdqdU9QRUxuU1BTWGRFMVNMNXVDdEVFL3hVZFg1?=
 =?utf-8?B?T1UxTmtwbWE1UG1EWXBEb0hmVzE3aHJiWVg1RXkrRGQ3dmNQNHp0ck1acDl5?=
 =?utf-8?B?REZNUzhneTJ6eGhqNGZjT21RbEZXQ2J5SXY2bDR1S0JiMEJXc0s2WStnYVNL?=
 =?utf-8?B?bitMdFg4R0xScGMwcTArUS9lRm4yb1E5a093OEtIOTJ2cmwyNzFvSDUzMmRk?=
 =?utf-8?B?Smk0WVd0R0tlTHVOT2hTTWdjVGNSUHBjbGtGYTVQMmc0cEYyZDRJUDlzQlZq?=
 =?utf-8?B?ZnBJSXZwdWNEUnZ4dTVuUEVaZDJHOFZxU00vM2dQVHlWZEp6OTJ6OC9ZY0FH?=
 =?utf-8?B?c2NTRVFnNUYycWMwbis3M3EvOG4vb2p1My9KWTVnQnZaWk1hVlBxSm5pSjl5?=
 =?utf-8?B?QytaV1k3Q0JORVliOHBnOTIvRTVGdUR0REtlS0xNamZ5TkFZTkNpWFJpNFEw?=
 =?utf-8?B?VHBkYTIvaHRhREpUSEhuUkJlYXhya0NmUWdUZEVnN3RtSjA2WENhbHkwQWtv?=
 =?utf-8?B?Q0pJVCs3alU4ZFNIeU9sMXNDbzRKamQwSmZBcCt4ampsM0lSMXVoS0xqbWFh?=
 =?utf-8?B?QlB0RWdZWHJhQ2ZiVERNWU14SjMvR0JnV1FDRDFZNmsrQk1iQ1ZRN0NWZnht?=
 =?utf-8?B?NlBUVHFod1V5bjlacFZMekw4TjlBK1FBYkZaR1p0eExkbmVtak9wM1IrK0h0?=
 =?utf-8?B?UFUzUzkvQVJpS0crMm84a2hSaHhkZ1lkSDBaU3l4L0ZWRnM5TmF2NXdNRDQ4?=
 =?utf-8?B?T2RHdFphbnJGcUxweUkxQVlaNmlBSXdHcVBocEtobVh3cVJkeGljdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1238b06e-6fed-4f98-82f1-08df24b6263b
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 21:01:25.5360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMfOuPyP3Tp/pLD0H0YPrycWB7JEJuoXK8MxMOUAICcG1ojIqHXhpPiHjGE+T/EpuSsqdm0TTTgDFAyCV88eAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

On 2026-10-07 07:14, Dhruv Bhogaonkar wrote:
> [Some people who received this message don't often get email from 
> dhruvb@linux.ibm.com. Learn why this is important at 
> https://aka.ms/LearnAboutSenderIdentification ]
>
> On 07/10/26 01:30, Felix Kuehling wrote:
>>
>> On 2026-10-06 08:51, Dhruv B wrote:
>>> In heterogeneous or non-uniform NUMA systems, a NUMA node may be
>>> CPU-less, memory-less, or both CPU-less and memory-less.
>>>
>>> Previously, kfd_create_vcrat_image_cpu() assumed that every online NUMA
>>> node contained both compute units and memory, attempting to create both
>>> CU and memory CRAT entries unconditionally for every online node.
>>>
>>> Add explicit guards to:
>>> 1. Only create Compute Unit CRAT entries if the NUMA node has valid
>>>     CPU cores (kfd_numa_node_to_apic_id() != -1).
>>> 2. Only create Memory CRAT entries if the NUMA node actually contains
>>>     memory (node_state(numa_node_id, N_MEMORY)).
>>>
>>> This avoids emitting invalid or empty CRAT subtype entries for 
>>> CPU-less,
>>> memory-less, or both CPU-less and memory-less NUMA nodes in virtual 
>>> CRAT
>>> generation.
>>
>> @David Yat Sin, I think we currently support CPU-less and memory-less
>> NUMA domains already. I know we have CPU-less NUMA domains on MI300A
>> in NPS4/TPX mode. And I remember we've fixed bugs on NUMA CPU systems
>> with only one DIMM populated, which would result in a memory-less NUMA
>> domain.
>>
>> Therefore, I'm not sure whether this patch is really needed and I'd be
>> concerned about introducing a regression. Is ROCr able to handle the
>> changes being proposed here? David, could you take a look at this and
>> maybe even test it, or find someone who could help test it on the
>> system configurations I described?
>
> Thank you for the feedback, Felix. Apologies for the bug in v1 —
> that was an oversight on our part.
>
> From the current code, the kfd_numa_node_to_apic_id() == -1
> continue causes the entire loop body to be skipped
> for a CPU-less NUMA node:
>
>   for_each_online_node(numa_node_id) {
>           if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
>                   continue;
>
>           ret = kfd_fill_cu_for_cpu(...);
>           ...
>           ret = kfd_fill_mem_info_for_cpu(...);
>   }
>
> When the loop body is skipped, neither a CU entry nor a memory entry is
> generated for that node, and no KFD topology device appears to be
> registered for it from this code path. From our reading, it appears that
> CPU-less nodes are effectively absent from the generated VCRAT topology
> rather than being represented with an empty or placeholder entry.

OK. I'm a bit surprised about that, because MI300A in NPS4 mode should 
have three CPU-less NUMA nodes per socket. Maybe we never depended on 
them being represented as CPU-less NUMA nodes in the KFD topology. Then 
this change should be an improvement because it removes some ambiguity 
between NUMA node numbers and KFD proximity domains.


>
>>
>> @Dhruv B, how much testing have you done on this patch series. Given
>> that the bug in patch 2 slipped through in v1, I'm worried that it's
>> not very thorough.
>
> Regarding testing, on the userspace side we ran the RCCL unit tests.
>
> On the kernel side, we verified that the IO links are created correctly
> for both topologies by inspecting the KFD topology sysfs entries after
> driver load.
>
> Here are the RCCL unit test results for both configurations, along with
> the corresponding numactl and KFD topology sysfs output observed after
> driver load.

Sounds good. We still need to test MI300A to make sure the changes don't 
confuse ROCr or amdsmi. Applications mostly shouldn't care because they 
don't use KFD topology node numbers directly. I'm told that most of the 
MI300A systems in production seem to use NPS1, so this shouldn't affect 
them.

Regards,
   Felix


>
> ---
> Test environment — contiguous NUMA (4 nodes, 0-3)
> --------------------------------------------------
>
> numactl reports 4 contiguous nodes (0-3), all with CPUs and memory:
>
>   $ numactl -H
>   available: 4 nodes (0-3)
>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
>                22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
>                41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
>   node 0 size: 881496 MB
>   node 0 free: 875909 MB
>   node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74
>                75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93
>                94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109
>                110 111
>   node 1 size: 885640 MB
>   node 1 free: 883815 MB
>   node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122 123 124 125
>                126 127 128 129 130 131 132 133 134 135 136 137 138 139
>                140 141 142 143 144 145 146 147 148 149 150 151 152 153
>                154 155 156 157 158 159 160 161 162 163 164 165 166 167
>   node 2 size: 885640 MB
>   node 2 free: 874248 MB
>   node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178 179 180 181
>                182 183 184 185 186 187 188 189 190 191 192 193 194 195
>                196 197 198 199 200 201 202 203 204 205 206 207 208 209
>                210 211 212 213 214 215 216 217 218 219 220 221 222 223
>   node 3 size: 885394 MB
>   node 3 free: 884033 MB
>
> The KFD topology sysfs reflects all 4 CPU nodes (0-3) plus 2 GPUs
> (nodes 4 and 5), each CPU node with correct core and memory counts:
>
>   /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
>
>   0: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>   1: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>   2: cpu_cores_count 56  mem_banks_count 1 io_links_count 2
>   3: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>   4: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>   5: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>
> RCCL unit tests — 948 cases, all PASS:
>
> ---
> Test environment — discontiguous NUMA (3 nodes: 0, 2-3)
> --------------------------------------------------------
>
> numactl reports 3 nodes with a gap at node 1. Nodes 2 and 3 are
> CPU-less and memory-less:
>
>   $ numactl -H
>   available: 3 nodes (0,2-3)
>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
>                22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
>   node 0 size: 519305 MB
>   node 0 free: 504963 MB
>   node 2 cpus: (none)
>   node 2 size: 0 MB
>   node 2 free: 0 MB
>   node 3 cpus: (none)
>   node 3 size: 0 MB
>   node 3 free: 0 MB
>
> After this patch series the KFD topology sysfs correctly preserves the
> NUMA node IDs as proximity domains. Node 1 appears as an empty
> placeholder, nodes 2 and 3 have no cores or memory banks but carry the
> GPU IO links, and both GPUs correctly reference node 2 as their attached
> CPU-less domain:
>
>   /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
>
>   0: cpu_cores_count 40  mem_banks_count 1 io_links_count 0
>   1: cpu_cores_count  0  mem_banks_count 0 io_links_count 0 (absent,
> placeholder)
>   2: cpu_cores_count  0  mem_banks_count 0 io_links_count 2 (CPU-less,
> GPUs attached)
>   3: cpu_cores_count  0  mem_banks_count 0 io_links_count 0 (CPU-less)
>   4: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>   5: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>
>   node 4 io_link: node_from 4  node_to 2 type 2  max_bandwidth 10000
>   node 5 io_link: node_from 5  node_to 2 type 2  max_bandwidth 10000
>
> RCCL unit tests — 948 cases, all PASS:
>
> We fully understand your concern about regressions. We would
> greatly appreciate it if someone with access to the systems you mentioned
> could test this series, and we are very happy to make any adjustments
> based on that feedback.
>
> Regards,
> Dhruv
>
>>
>> That said, the patch series looks good to me now, in theory.
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40 
>>> +++++++++++++++------------
>>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> index 7dad8f30ff2a..329931b0edc6 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> @@ -1944,28 +1944,32 @@ static int kfd_create_vcrat_image_cpu(void
>>> *pcrat_image, size_t *size)
>>>           }
>>>             /* Fill in Subtype: Compute Unit */
>>> -        ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>> -            crat_table->num_domains,
>>> -            (struct crat_subtype_computeunit *)sub_type_hdr);
>>> -        if (ret < 0)
>>> -            return ret;
>>> -        crat_table->length += sub_type_hdr->length;
>>> -        crat_table->total_entries++;
>>> +        if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
>>> +            ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>> +                          crat_table->num_domains,
>>> +                          (struct crat_subtype_computeunit
>>> *)sub_type_hdr);
>>> +            if (ret < 0)
>>> +                return ret;
>>> +            crat_table->length += sub_type_hdr->length;
>>> +            crat_table->total_entries++;
>>>   -        sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>> -            sub_type_hdr->length);
>>> +            sub_type_hdr = (typeof(sub_type_hdr))((char
>>> *)sub_type_hdr +
>>> +                sub_type_hdr->length);
>>> +        }
>>>             /* Fill in Subtype: Memory */
>>> -        ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>> -            crat_table->num_domains,
>>> -            (struct crat_subtype_memory *)sub_type_hdr);
>>> -        if (ret < 0)
>>> -            return ret;
>>> -        crat_table->length += sub_type_hdr->length;
>>> -        crat_table->total_entries++;
>>> +        if (node_state(numa_node_id, N_MEMORY)) {
>>> +            ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>> +                            crat_table->num_domains,
>>> +                            (struct crat_subtype_memory
>>> *)sub_type_hdr);
>>> +            if (ret < 0)
>>> +                return ret;
>>> +            crat_table->length += sub_type_hdr->length;
>>> +            crat_table->total_entries++;
>>>   -        sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>> -            sub_type_hdr->length);
>>> +            sub_type_hdr = (typeof(sub_type_hdr))((char
>>> *)sub_type_hdr +
>>> +                sub_type_hdr->length);
>>> +        }
>>>             /* Fill in Subtype: IO Link */
>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)

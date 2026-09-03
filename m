Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E66C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 04:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A564410E037;
	Thu,  3 Sep 2026 04:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sT84ueRM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB28E10E037
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 04:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3LOvZsGnG6s9cGur0P6XmAJw0d5x7f80jgo5ZbEMBiHURUpWDYZUrK7je+i4mUloqrvT7TjKn61ngHkcMNKksutlLXJyM6M9OGogfjpDXWgE8nvMKfpD5Z50YgxQALfLIGJVdYMz43iRcdkkQhIPGLWdNxT9Bt+RctBovf7ydjsIgz2oDAs4VE9HeId6PW0Mj+ZNCmaxihfRa+FWfCHBzUq0UK1oBrxV61870vNWmPKwmosRRpZbRuBLjlyX6CfXBT5fWJLM2IqFBOQ35HbLCKqaEQM+Snhbim/Qs8SjsLnj/j74DVvcMXLJyIO6o2PiKR0wi6mTbtyt2EHUbHdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM26g3OCWrr6c1CPcSAkz4F9C3o2oZNCNW1mrQsP+zw=;
 b=KM/2CNC0fblxMqXzkvD7OEiNMXXPkm7/Lum+kMDZHVUBhxhkS5eswlYhEo99b2SnJuv/RTRTYxf/Fsn1JdfbQQrk5m300x9uYsTy6Ub1UOVyY17kyORUUmyRXcL4YiCGM4FNWFz9PmA3GJi9nFqUuI/4c8tBdM/aTMR3vu1eRND+mupZVuY4F0dP0Ewz8HvKjL2aQMzJ/6wpriY9lUZRHCvhupDxQVKEEuUKzRUPCX+UcJqeQQh3TWzCHpjH+KKmX5lXoiAIJkpavMpdFCdFfAJ3Olmvc6WikGCkRF9tvxtIT4yqpB+VIsG5j99UEGYI5KI7n5gtEt0z3Sb803wn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM26g3OCWrr6c1CPcSAkz4F9C3o2oZNCNW1mrQsP+zw=;
 b=sT84ueRMYHG/0oxrTHXHELHOLcYog00SyRNI6ICk9geXKfhcUstQIbXDZmIKvRm/iPepJABke9g1YBs1t7qd2zfQ2yi+Jp+MgX2xfhHoj0aZFFiwPy+OUh4jZJRUt+WOmOeAnp9s15RjQUPSVxln4Sj3PmGvZWJ/0BOzsHKajCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 04:03:40 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 04:03:40 +0000
Message-ID: <de1313dc-62bb-42b6-a22e-4775260fd680@amd.com>
Date: Thu, 3 Sep 2026 09:33:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
 <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
 <ae477cda-c0be-4a26-8aa4-95a836500e7c@amd.com>
 <IA0PR12MB8208E904460F474C4975950690B72@IA0PR12MB8208.namprd12.prod.outlook.com>
 <SA0PR12MB70916914036CA157754EAAC497B72@SA0PR12MB7091.namprd12.prod.outlook.com>
 <BN9PR12MB514657D40AC8B41594720A93F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
 <f2755b35-ef95-4067-b5bd-0a37ee1df457@amd.com>
Content-Language: en-US
In-Reply-To: <f2755b35-ef95-4067-b5bd-0a37ee1df457@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9f0f16-803f-4cf8-6595-08df09705678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6hJvNaJmv7U3LiWpwo19zA5V7MrmWHBuFgqvQ4iYjCmBer5yg8jycru1CY8B6CJVLJ0BcZsEfn9wlI83cELxBXhF0PT7nUWvnMeFZ0kvA2r/WvXObjT7RjISsnwGn1aZB8x2TWRKfZ63ZgfsxxLHFqnh6ZENDtWTZFlRovHWwB1MZ2iewxRe3S/ppeaWQVwmBWTrAkjUrYxmV36PoUXLzg2xXnbt5SiQvnA0Z2QxL81OqGxTMs0IFNLDsAKBGH6mB74a86vigaH/kV69XE3WhuyuwRbZI2cPcWlGei7OVnnOSf5kiWzyR7eu+Z6Gvur6ljxhKYk9p6RuZKKJeacBeXAbN2DYY6GHJxB+nn/ug00qxapkVpEfL+IMNQDqOXzSexIwJlnH4SMkxmfDRjAELQvFbC1N7qVRlcyjJlmGfXvCS5CTN1wKN8eD+qWnrLaFpoJYiDtCkbhWA0EULk+TqGeQWqh+NgoIiTzPzH8MKOlzLuYF8m6a/f4+VanJ2LfBQxWGsv7KwUbDo0KQ6RTuo1cWJ6Su3vA3JxytbehK+EFdluFngLqLAuULRSyfqxbL85eTvZtzfMo4jHdlpM4gVa6cd/PWdQr/1CjDi6tVJWV/9NxJko3/vWQ2iJ11W09HlcYEGRGWbYdVD5nKZqc6Afg7GNynwgMTmQ3mMRMeo+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUVkOWhtSGNpdTMzUWhyWjNyMUgxUkZiMGYyMDFrdlRRT3ZGeDFnY0Zha1c3?=
 =?utf-8?B?WWxNYnQwRm5LVDVQcEhCdkVEOXowS05Vb2JJTWFaQmdsamRiUDF5TWdCdHAw?=
 =?utf-8?B?RG96dXZLWTl6ekpWK1lGQldzcGF0bUNoTUdiQ1Q5b1FWME0wL0JCOTl6VklM?=
 =?utf-8?B?RmxxNXBWUE9sQ3Z4end6Q01pV29RaWNJcUxyZFEwNUdEb1pFZE51UkZZZVY1?=
 =?utf-8?B?RXI5Szd6QmxzVnJldXpmdEc5M1hNRVcrNlFyZ1JSanJYUWZON2EyS2ZpOGNn?=
 =?utf-8?B?NHRva2JNQlp2VnJXcWZXSzl2QXIrNDQwYUNOQjhsQlJ4WExqTGJJZDVPT2F4?=
 =?utf-8?B?NTBWelVvUDZoOFVvT1lVYjRmeUoxWEQyUU5aRlZEd0p5cWZ6WW8xdTk3d3k1?=
 =?utf-8?B?eTV3Q3BkWWdIS0owdzJ2bklnV0E2eGFNd1BWRlp1TlZJNnlRY0V1SjRoclBW?=
 =?utf-8?B?RnhxYk9VQ2tGUThZL0tFd1BkbUpKVllOcStZOVpBUmhNT084Q2xzYTRkZWtD?=
 =?utf-8?B?UVZWai96eDZPRUlrVHo1akZUTkVBQ2hGaXhuVkxFakhQaDJmaS9KdnJxSDU0?=
 =?utf-8?B?UlpZZ0ttblV1Vm5ia05FMldyUCsrV3JyQXV5WUxHL3htVjhuOG84Q0JBL0lC?=
 =?utf-8?B?M1NRcXZlaktjVmZNOFgvVnMzbG9rbjZ0VHZRODJtV0Z5UHhOcHQzcmN4bHI3?=
 =?utf-8?B?Y2RwODJXMlBJRzdrR0x5cTc2YTB6bjlnOTJXOHFYenVSeVJvZUtEbkZHREFv?=
 =?utf-8?B?OUpyTWxIOW9YU1JTMGM5czBvY2VyeUxsRFQ0bXpRWUZKZkkrcXU3SWNCUnVm?=
 =?utf-8?B?amptdU9nZGxUL21FQ3VmbFhWNS9XQWRwV0hTWldOcXM4NENyakpKWUNpQVJO?=
 =?utf-8?B?V2tPdVVNQTBEdUJFMFNnbHJHZWlpWHFwaFl4WWFnSmVsM29NdEVzOGRqWTh2?=
 =?utf-8?B?MG9YUE12Q1ZXRnAxdGcxOUt0K0I0TkhrOWIzdDZxZDZ6Vk95cC9wN3diUUlq?=
 =?utf-8?B?YWVERXR4elA2cXZQQVdzWDhNVXZ4UmtrcGlnaEpzRkpCazFQZGNRdDFDcnlI?=
 =?utf-8?B?d3lOV3Q1TnNlU1JSVHJXQ1pQcGJ5S2lKR0hrYjRmWGpBa0RLeksrTUtTNW1Z?=
 =?utf-8?B?bFN1WGRwVEduS2ZKaElML1dTb2JLM3NDMExWMG1hbzgya2ZuNHFRUFNiekU4?=
 =?utf-8?B?ak5COGRqOExxZTc5c2EvOW1QZGtQVnE5WmZ2VGtDMFVqTXgrVWVMTkE0ZC90?=
 =?utf-8?B?aXRrSzMxN3FURldlNitIZk5nTm5CbnNLY2xFWTFBL0dXbkh4MWhCUGFxdHly?=
 =?utf-8?B?MFRvQXpoMGVNTU0xMlRnRHFZa1hySWRYYVhFUU9QaG5TdnZTZHpHWTBRZTVr?=
 =?utf-8?B?dnpXWVhrY2hSVzBCZi9oeXlvWmoxYXo1WDRMN1ZVYzltWlpGQmZ6Zk9hbnZF?=
 =?utf-8?B?OWRIMS9PYzF2S3ltN3BCUk9iQmFJWmJjSFZKYlV0eWZjdVhUZS9Tb2hkVDh6?=
 =?utf-8?B?Qjg5b2k3WDh5M2t2UkxmQ1kzS2ZSNlEzQTVTUXRrTC9QdHg4eFZxUkdoVzJK?=
 =?utf-8?B?WWp4dzVGckpzVzk4eTdENW91ZmVFNXkwNDRSWnV1MXFSeC9OZDl2dS9Hd01I?=
 =?utf-8?B?WWNsUEQvR2FUYTVzVzFpNkNjYVMyMVRFaWU4MEg4S1Q2N2xVbXhickg1bGty?=
 =?utf-8?B?OWpsaTMyd1NLK2F6SmowWDFQaU42VjhKSDhJbEk4TUljdUtSNDdSTXdPVlNV?=
 =?utf-8?B?OFMrQndjMUZtenZXTjI1a24yNzFLQ2lNNStPSVJ3SnNseXN4aWdUcCtFbzJh?=
 =?utf-8?B?bVdzcFowU1h2bWp0MnZaMGRTSFZxTFdBTnFxa05IOGF6MHhUYzhlZEc2Mkcw?=
 =?utf-8?B?WGEwSzRlZ0RiVDRLMVdWL3YwelNjdHV1bVUvMjJyZlZNaU5OYi9VV3BBWTZT?=
 =?utf-8?B?a0EyZVVWVitPRXZrN2VBb2xmZVY1V2VxVEZhM05JallpUk03OEdkT0xhWDlH?=
 =?utf-8?B?dXNUMEVNai92czF1L24zSUdSVmVlWWl4a29XbFJodUszVW5oUE8yMWRzVEp6?=
 =?utf-8?B?Smh4cy9NWG9sZ2M3U1JMaEFqdHBIZ1c2WE52T0JyVHk1Z1pRVndmK3NPdzBD?=
 =?utf-8?B?bEZRYm43R1p1SnBaay9KUjdIODFXR2p1cm42TWRmK2ppdjRuTFVHSWFZSkwv?=
 =?utf-8?B?Y29QdGxrdmVhK1liYXRSaTg4WUQrU2JYQ2hiUGdDMEM2WlNXVXJ2a1dWTitW?=
 =?utf-8?B?RjdmRXpYYjIyait3VkUrTUNGcWhoekoyVjVpZktSQXNTbThOS3NSL0lVa2VH?=
 =?utf-8?Q?qQH6BAAifhuH1Fx4oV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9f0f16-803f-4cf8-6595-08df09705678
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 04:03:40.2683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1nq1EkLNtAn/Vs5QXbr8Ydij0/bCZKM/uZcmOi9el/LSiQOD4Ra/6mNI0gPZEX9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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



On 03-Sep-26 9:32 AM, Lazar, Lijo wrote:
> 
> 
> On 02-Sep-26 10:25 PM, Deucher, Alexander wrote:
>> Public
>>
>>
>> For kernel queues each IB executes with a kernel provided vmid 
>> assigned dynamically by the kernel driver.
>>
> 
> In this case, it's a device level TMA 'kq_tma_bo' for first level. That 
> address is programmed in SQ registers. When a job is submitted, the 
> second level handler is picked from what is programmed in kq_tma_bo. Do 
> you mean to say that driver will change that value dynamically based on 
> what is provided by user?

Do you mean to say that driver will change that value dynamically based 
on what is provided by user for each job submission?

Thanks,
Lijo

> 
> Thanks,
> Lijo
> 
>   > Alex
>>
>> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
>> *Sent:* Wednesday, September 2, 2026 12:12 PM
>> *To:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig, 
>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>
>> *Cc:* amd-gfx@lists.freedesktop.org
>> *Subject:* Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap 
>> handler infrastructure
>>
>> Public
>>
>> I'm not sure how this works, I thought the TMA mapping is per VMID and 
>> kernel queues have static VMIDs.
>>
>> Thanks,
>>
>> Lijo
>>
>> ------------------------------------------------------------------------
>>
>> *From:*SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com 
>> <mailto:SRINIVASAN.SHANMUGAM@amd.com>>
>> *Sent:* Wednesday, 02 September 2026 21:29:38
>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; 
>> Koenig, Christian <Christian.Koenig@amd.com 
>> <mailto:Christian.Koenig@amd.com>>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
>> *Cc:* amd-gfx@lists.freedesktop.org <mailto:amd- 
>> gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org <mailto:amd- 
>> gfx@lists.freedesktop.org>>
>> *Subject:* RE: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap 
>> handler infrastructure
>>
>> Public
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>>> Sent: Wednesday, September 2, 2026 8:59 PM
>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com 
>>> <mailto:SRINIVASAN.SHANMUGAM@amd.com>>;
>>> Koenig, Christian <Christian.Koenig@amd.com 
>>> <mailto:Christian.Koenig@amd.com>>; Deucher, 
>> Alexander
>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
>>> Cc: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>>> Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
>>> infrastructure
>>>
>>>
>>>
>>> On 02-Sep-26 8:36 PM, Srinivasan Shanmugam wrote:
>>> > MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>>> > SQ_SHADER_TBA/TMA registers for them. Add infrastructure to let the
>>> > driver program the first-level CWSR trap handler for these VMIDs
>>> > directly via SRBM select.
>>> >
>>> > Add kq_tma_bo — a pinned GTT BO used as device-level TMA scratch for
>>> > kernel queue VMIDs. Unlike per-process TMA (created in
>>> > amdgpu_trap_alloc), this is device-level and lives for the lifetime of
>>> > the device. It is zero-initialized by the OS: the second-level handler
>>> > address is 0 until userspace calls SET_L2_TRAP.
>>> >
>>> > Add amdgpu_trap_program_kernel_vmids() which dispatches to a per-HW
>>> > vmhub callback, and a new program_kernel_trap_vmids hook in
>>> > amdgpu_vmhub_funcs for per-GFX-generation register writes.
>>> >
>>> > Required for:
>>> >    - RADV graphics debugging on Vega/Navi/Steam Deck (Valve request)
>>> >    - Consistent trap handler behavior when switching between kernel
>>> >      queues and user queues
>>> >
>>> > Suggested-by: Christian König <christian.koenig@amd.com 
>>> <mailto:christian.koenig@amd.com>>
>>> > Cc: Alexander Deucher <alexander.deucher@amd.com 
>>> <mailto:alexander.deucher@amd.com>>
>>> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com 
>>> <mailto:srinivasan.shanmugam@amd.com>>
>>> > Change-Id: I0709e788835b69d3d492864de8d5c2d36d0f08c8
>>> > ---
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 37
>>> ++++++++++++++++++++++++
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  2 ++
>>> >   3 files changed, 40 insertions(+)
>>> >
>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> > index 3ca187f5ade8..5624a5ab5c62 100644
>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> > @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>> >     void (*print_l2_protection_fault_status)(struct amdgpu_device 
>>> *adev,
>>> >                                              uint32_t status);
>>> >     uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t
>>> > flush_type);
>>> > +   void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>>> >   };
>>> >
>>> >   struct amdgpu_vmhub {
>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> > index 31f653ec3fb1..0e0aeea0aa2d 100644
>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> > @@ -256,8 +256,23 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>> >
>>> >     memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
>>> >
>>> > +   /*
>>> > +    * Device-level TMA for kernel queue VMIDs. Pinned GTT — not 
>>> subject
>>> > +    * to eviction. Zero-initialized by OS: second-level handler 
>>> address
>>> > +    * is 0 until userspace calls SET_L2_TRAP.
>>>
>>> How is the exclusivity maintained as a user app doesn't 'own' kernel 
>>> queue? How is
>>> the conflict of different user apps trying to install their own 
>>> second level handler on a
>>> kernel queue handled?
>>
>> As pointed out by Alex:
>>
>>    - Each process gets its own per-VM TMA buffer for kernel queues
>>    - It is allocated and mapped at a fixed VA in the process's GPUVM
>>      when the device is opened, similar to amdgpu_map_static_csa()
>>    - Before each job is dispatched to a kernel queue VMID, the driver
>>      programs SQ_SHADER_TMA to that process's own TMA VA
>>
>> This way:
>>    - App A submits job → TMA = App A's TMA → job runs
>>    - App B submits job → TMA = App B's TMA → job runs
>>    - No conflict — each process has its own TMA buffer
>>
>> Note: SET_L2_TRAP for kernel queue VMIDs is not part of this series.
>> This series only installs the first-level trap handler.
>>
>> For second-level handler support on kernel queues, I think since:
>>
>>    - Each process has its own per-VM TMA buffer (allocated at device
>>      open, mapped at a fixed VA in the process's GPUVM)
>>    - User calls SET_L2_TRAP → writes second-level handler address
>>      into that process's own TMA buffer
>>    - When shader crashes → first-level handler reads from that
>>      process's TMA → jumps to that process's second-level handler
>>    - No conflict — each process has its own TMA with its own
>>      second-level handler address
>>
>> The per-VM TMA design is the foundation for this future series.
>> The device-level kq_tma_bo will be removed in v2.
>>
>> For long term — kernel queues are replaced by user queues entirely
>> , where MES already handles this correctly via ADD_QUEUE.
>>
>> Thanks,
>> Srini
>>
> 


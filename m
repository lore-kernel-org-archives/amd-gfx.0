Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE82606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CqFCXmdI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF2510E2B5;
	Mon, 26 Oct 2026 22:21:24 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9747610E2B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 22:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNyGX9/GzAD88+bD7AodXJu9jC7uAp/YHDooNa9E7rkpT43UjZuRu+zRS6QM1NAbkErPud1Y6f7x2xGHS82a+AgoaNdnhbVEHnpR6fAcfbIuLKH6tjrqfHyIU+dmmQkAmYeWIu7KneuQ31HXEGywVEE/0wsj9+tBim8o4fjDOECGSWZr62e1Gt1a7nZcRTSJd44eI6YVALqF4fir8JOsngQxZRUWq9BTH1lXeVcmmDgON6QWORHo6ZDdT+jLuQ0RxrCt2QdIjMDWwu+j8ztoXOcIyCM5ySuibbyORE0hzBduKWaVJ722YTq76FllDKyCWyLPB6jZVy/Vn8kNzTbnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxFR3fFg11TKR8H6UykOowfu9IHdO7N136X/lxH6PEc=;
 b=EofuiKHoBVAVSXl3EQchNMkgmGT0ypwEeRxfExgloFH9yqcvDsZi74UJqWkmDwmqMPUpnJ8PBaLUEOFRQXgwvoWWdGBBBV2JkZcEBgm57iGBftvsXho1rVdDPnHdnALMVpx/CY2X3J8ghmqp8FVlxmamUDr8ZsgMn/KIidJVqUhpnHTpVYljzYFla6blWI+onKNMWR8XC5qS34Nmd6797eYAHXPZ/6LsCiS3bzap2BSQ4vmGTPKW8sWgFQxNOFFRy1YOxPv+ZhZkhMT4V3RUoN45tkxg9/FyTX3EXgP5Bd8pOd0+s7OeqT672oG+ur4cwnLGnWKnpDUWU0VL4+oHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxFR3fFg11TKR8H6UykOowfu9IHdO7N136X/lxH6PEc=;
 b=CqFCXmdIIrt9Jemo5+dMsU0Bta0c9qh8tPKfmlQvhG1IpwcycZsrIs0EObcpZ+c81+t6lKtM8DZEdnjHiP8k5ushFMAuWdt1jWe9l53KfP2i0OC9ZvOoKBNycW5079JZNUmwgqLv5KDr+7HNx7vDhjKhJgfrnk0G/mHahBQWV+o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ5PPFD525C5379.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:21:07 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:21:05 +0000
Content-Type: multipart/alternative;
 boundary="------------zigTFRG8Iy32SDEp8vR5ABu0"
Message-ID: <f064e15c-7fe0-4e6f-a01f-7b50a6e77a81@amd.com>
Date: Mon, 26 Oct 2026 18:21:03 -0400
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
 <a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com>
 <8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com>
X-ClientProxiedBy: YQBP288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::24) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cf4c6c-502c-410d-8e07-08df33af6d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261026140227099003|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261022115727099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003|261026121527099003|6133799003|3023799007|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: wvjpYvfKp7ye7yo7Lm4q6N+a5Hfjloh1KJSraQJnu78eWFH6CazsRU64xUvxjpGqRwV82HIGbNUkLpZOQchSCgvj8gN2EBIITCJYcAGJcDrDYN6N++YU64i680J3MU39SnhcAkQjvSz1Ar7uCfZdMFCA2NG9wX3QuHh8Jv0UmBbjLCAlPhTiF/5S2IC4ATdDqppBbEC8dGlX5VZmrdz4mMw8LHioKgrM8s4mt4r2DHyIuhIr8rSxZB+Enntj2LeZW+N8f2LDIqdsxtgB71wiuY/9JsLFy+NE0vqZGCj+LWWSKGOBJnklBMBRjoX7reG2nFR0HDXbumGY7qegA0i+2Bz3fcPIzqbRuFTNg0EwNdGHy1041KYITftYqJ/L/DElscQMexNMblyjDERR0tcxziMYsNaNBCbSxL9ztDU3dkqfmVX2fl42FiOcbZZlkR4e6DWoC718q9lx4HQuxHIUq0KIP6YRxspL5z6s+s+fvVBg46IJ/nRXOBgwGwCBsQ1U7nQNnJManC8cQsRIQOC+Cr/G4U4/Q5Bh4TK3mLYo5QjP0Kot4dL8+4HuPkcP14Aqq2cHuKq3AQ2MwLxVygKuZXI4X8IWjjyvKrBA0DoWH3HSeOfnte+rDraSflSRZ5mhT5DkSDmh69okXE4HIUCdzyAmMoqp6/6DaR4PfAk6IFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022115727099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261026121527099003)(6133799003)(3023799007)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZCOC9rSjVsVm5ZSmRvZHgySTRsc29pUDQ4eVBnYXJpU3M0bFdsSm5NWTk4?=
 =?utf-8?B?aUdaY3dDRUphSmZ4Z0xESFJvT1cyV2lJazZTc2VqMjNRRXBKR0ZJMnh1TVI3?=
 =?utf-8?B?cHBjYnhEV1g0QTBEa3FZTEVFbEJ1ajhHL09lSXhBRmI3MVlwbC9KMXVINCtj?=
 =?utf-8?B?TWxMWnU3ZHZuZXQxYXBCaWN6d0UvcEF2MlJRVlBEQmRoN25TaFB5TkwvWWxk?=
 =?utf-8?B?UWtiKzVaYzg1dDljYU5VamU0ZWdNcDlLalk2UWxrY1dBRmxGa1hZZENnbzZD?=
 =?utf-8?B?SVk2RVRPTVlHUEI2MTFhK2dWWVp2NWVHZk4yVkdsNU91UzZFZFlDdEJxV2Ix?=
 =?utf-8?B?dk8wRkJWeXRuR0VSLzlzd25lb1Q1SWNZcXpKUVE4aTNpQ056QWY2SkJnZUc5?=
 =?utf-8?B?RVJYQ2RRMGRCZGFLSG5SYlVleFFpSnhWa0JBN2RRUnBrNHF4ZnV6S1JRYUFa?=
 =?utf-8?B?bjZSMzZrSUxiRVNDdzVNU0YrcHFRUU9FYy9WUytaajhFQ1d4UFdqcldldlR4?=
 =?utf-8?B?V1dQNHZsTDJMT1lzVHlZdVYzcmt3bUFJdmR5djdOaFVKcU0yMHlkc09rT3JU?=
 =?utf-8?B?Rk9PYUMvWWFXZXYzRFVOSFN1N1Rrc2k4WmlXQjl5YnBhWnNwVWZaZ0JrMXk4?=
 =?utf-8?B?Q0hSdERuc3lSdStwbDRtWkdnaUQ2c2F0TURkWkxVT3hCdTFqbG9DMFI1WkFG?=
 =?utf-8?B?VmxvcG5CTUFLSlEya1FlTXhNcExMdGVQN21NaUM1MEsxU1V1alU5eUw4MFdY?=
 =?utf-8?B?VDJEQkJjdWdxT3pnaGNVVGd5dnJJMDhEaDlaTVd1UTdHRjY5WWZCczlMcU1r?=
 =?utf-8?B?RkI0NmRYYnpYOFhqUzZpZ2YvZjlyamlRczYwelAyZklsa2k3U0JFUmt4ZXBH?=
 =?utf-8?B?MnpUUHl1QkJ5LytPNy9JZyswMUp3YUZNN1pkc0hBK0JFMEV2NUVmaUZMZHJr?=
 =?utf-8?B?Nk9xbmlkRW9vKzVGSTIzdnNqL3dvb3ZhSTNXYkJmbWtWZ0pYYkN5OGtGRVcx?=
 =?utf-8?B?Njg1TkprYWZJcnZ3TlRLOGNmTjZkN0ovK3cvUTdUcGFKUzhnTVhWSnRiU2tl?=
 =?utf-8?B?MzArYnQ3eFNPeVpZa0dQVlk3YlMyaU8xUnlmbktQMlF4SUJsVEU4OXlrL1VE?=
 =?utf-8?B?TXU0ajBKY0NLaG5XNkVQRWZUSGo5RUt4ZkRBdzRRWUNUNi9LNnFEKzRQRzF5?=
 =?utf-8?B?Y3hNQnNkWXVvZDBLQUIvQ0FNUVNCTldwWjcvOU0reEp5TllWUUNGUW1sRGpu?=
 =?utf-8?B?UHFqVlo0Z2ZiSlM3RlFLR0ZaVzFINmduWWxpR2JZZG5BdEhBRk1paHp0NjM3?=
 =?utf-8?B?NUJBMUpZZXB3emdaU2tBd0prcDdLbVMvak1yeGJwSHFWVjJHUWFwNy9ZNXVx?=
 =?utf-8?B?dENLcUI0UnlDQmZ4VkpTRm1mcFdSaE5vdGxwb1I2cEJGNmxlVjU1TllsTWVG?=
 =?utf-8?B?ZjR0VWhJZ0g5c2IvSlVpU1RncXBtS2lFUlYwemJCVms4SFFDNGhKNDhMMnRu?=
 =?utf-8?B?bnh3MVg1azJxcGl4aFhXUFJPWXZpenFnWlJIanVVcFNjclBVUW5SWXBYc2lN?=
 =?utf-8?B?eWVoYnlLWXVFb1lUUzgvckJwaDBKdTE1ZExjQ2ZOU1dTenhub3BWTTJEcSt2?=
 =?utf-8?B?eDZoeGZnVWxjUUoxbnZROGJUdzRHNzlkRjArTjNVU2tja3pvZ2xhOWZweVFC?=
 =?utf-8?B?NTZ2U0UyQVppT05ZS0VaNkp2dDZRaGIrYXp6TTZ5aGhOb0Q4WGZSWVpTSnlm?=
 =?utf-8?B?a3FuL3JTV3UxNm9iL3A0WkZuTkZHRmVvRXlJSWZvNmprTVpQdDRkdlkvS3Js?=
 =?utf-8?B?elQvVXpxa2JXcEg5MW1RSnRvWCtVUVRUSE9ZaWhyUkJuZXI4MkJCMml3T3lZ?=
 =?utf-8?B?b1dBeUxmaWRIRStIYXpJWXF5M2xEb0VleWxTS2g0WlUxSWJhS3FnT0w3N0s0?=
 =?utf-8?B?aTFIT0JDMlptZ3ZvYTl6aDVFd2N0MkZSdTQ5bTFvcDZyQWhuRHNQb1VnMTAy?=
 =?utf-8?B?M1E1ZXBSWkNsK3NTZjNVWnI1UGtCUGg0UUc5Q1pFai9XQnl0eVBLYWhuV2tW?=
 =?utf-8?B?c1dkVXVjU2VUZ2ZtVWIyZE5DWGdVbUpzWFVBbzZLK3BLYk5EZkpUZk9aSTg2?=
 =?utf-8?B?ek9QUUxEOXA3ZFloNmxVamZZdnBkRk5qRENaOWV0eXYvTGZHdnNPVjdBeXVU?=
 =?utf-8?B?NEx5OHpGV1A0d0dPTi9IZVVKdkNlUU5nWFVHek9pMThieEJWdFBBdllrc3hq?=
 =?utf-8?B?YXcxVVh5SDhOQzBLQWZJQjcvTlBnak9vVG8yVVFOS1lHQTlhNGlIYkNpYVEw?=
 =?utf-8?B?MTZ3WjI1aTR5Tm0vVUFGbXBxVFM3SnByU1VWbDl4U0RHdTYrOUJkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cf4c6c-502c-410d-8e07-08df33af6d32
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 22:21:05.6838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: floKGK/UbsMAHMqkVuxZQ3o61xwWBXLI30WSGtLGRXwy4OIGuD/7NG9L7k4wbA+xFXu6X3BFONsIIElz0JcFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------zigTFRG8Iy32SDEp8vR5ABu0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-26 14:07, Dhruv Bhogaonkar wrote:
>
>
> On 08/10/26 02:31, Kuehling, Felix wrote:
>> On 2026-10-07 07:14, Dhruv Bhogaonkar wrote:
>>> [Some people who received this message don't often get email from 
>>> dhruvb@linux.ibm.com. Learn why this is important at 
>>> https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On 07/10/26 01:30, Felix Kuehling wrote:
>>>>
>>>> On 2026-10-06 08:51, Dhruv B wrote:
>>>>> In heterogeneous or non-uniform NUMA systems, a NUMA node may be
>>>>> CPU-less, memory-less, or both CPU-less and memory-less.
>>>>>
>>>>> Previously, kfd_create_vcrat_image_cpu() assumed that every online 
>>>>> NUMA
>>>>> node contained both compute units and memory, attempting to create 
>>>>> both
>>>>> CU and memory CRAT entries unconditionally for every online node.
>>>>>
>>>>> Add explicit guards to:
>>>>> 1. Only create Compute Unit CRAT entries if the NUMA node has valid
>>>>>     CPU cores (kfd_numa_node_to_apic_id() != -1).
>>>>> 2. Only create Memory CRAT entries if the NUMA node actually contains
>>>>>     memory (node_state(numa_node_id, N_MEMORY)).
>>>>>
>>>>> This avoids emitting invalid or empty CRAT subtype entries for 
>>>>> CPU-less,
>>>>> memory-less, or both CPU-less and memory-less NUMA nodes in 
>>>>> virtual CRAT
>>>>> generation.
>>>>
>>>> @David Yat Sin, I think we currently support CPU-less and memory-less
>>>> NUMA domains already. I know we have CPU-less NUMA domains on MI300A
>>>> in NPS4/TPX mode. And I remember we've fixed bugs on NUMA CPU systems
>>>> with only one DIMM populated, which would result in a memory-less NUMA
>>>> domain.
>>>>
>>>> Therefore, I'm not sure whether this patch is really needed and I'd be
>>>> concerned about introducing a regression. Is ROCr able to handle the
>>>> changes being proposed here? David, could you take a look at this and
>>>> maybe even test it, or find someone who could help test it on the
>>>> system configurations I described?
>>>
>>> Thank you for the feedback, Felix. Apologies for the bug in v1 —
>>> that was an oversight on our part.
>>>
>>> From the current code, the kfd_numa_node_to_apic_id() == -1
>>> continue causes the entire loop body to be skipped
>>> for a CPU-less NUMA node:
>>>
>>>   for_each_online_node(numa_node_id) {
>>>           if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
>>>                   continue;
>>>
>>>           ret = kfd_fill_cu_for_cpu(...);
>>>           ...
>>>           ret = kfd_fill_mem_info_for_cpu(...);
>>>   }
>>>
>>> When the loop body is skipped, neither a CU entry nor a memory entry is
>>> generated for that node, and no KFD topology device appears to be
>>> registered for it from this code path. From our reading, it appears 
>>> that
>>> CPU-less nodes are effectively absent from the generated VCRAT topology
>>> rather than being represented with an empty or placeholder entry.
>>
>> OK. I'm a bit surprised about that, because MI300A in NPS4 mode 
>> should have three CPU-less NUMA nodes per socket. Maybe we never 
>> depended on them being represented as CPU-less NUMA nodes in the KFD 
>> topology. Then this change should be an improvement because it 
>> removes some ambiguity between NUMA node numbers and KFD proximity 
>> domains.
>>
>>
>>>
>>>>
>>>> @Dhruv B, how much testing have you done on this patch series. Given
>>>> that the bug in patch 2 slipped through in v1, I'm worried that it's
>>>> not very thorough.
>>>
>>> Regarding testing, on the userspace side we ran the RCCL unit tests.
>>>
>>> On the kernel side, we verified that the IO links are created correctly
>>> for both topologies by inspecting the KFD topology sysfs entries after
>>> driver load.
>>>
>>> Here are the RCCL unit test results for both configurations, along with
>>> the corresponding numactl and KFD topology sysfs output observed after
>>> driver load.
>>
>> Sounds good. We still need to test MI300A to make sure the changes 
>> don't confuse ROCr or amdsmi. Applications mostly shouldn't care 
>> because they don't use KFD topology node numbers directly. I'm told 
>> that most of the MI300A systems in production seem to use NPS1, so 
>> this shouldn't affect them.
>
>
> Hi Felix,
>
> I wanted to ask if there have been any updates on the
> patch series and whether anything would be required
> from my side.
>
Thanks for the reminder. We did some testing of these patches and also 
considered what configurations of MI300A are actually deployed. An 
automated AI review caught two other problematic interactions in patch 2/3:

    Phantom domains have a knock-on effect in kfd_topology.c:
    kfd_create_indirect_link_prop() (kfd_topology.c:1421-1440) walks i
    over every CPU-side topology device and does return -ENOMEM when no
    matching cpu_link is found. A device synthesized for an offline node
    has an empty io_link_props, so on an x86 box with a hole in the node
    IDs and >1 GPU, kfd_dev_create_p2p_links() now bails out and all
    indirect/P2P links are silently dropped (the return value at
    kfd_topology.c:2077 is ignored). Worth either skipping link-less CPU
    devices there or confirming this path was evaluated.

And

    Regression: the old loop body started with

    |if (kfd_numa_node_to_apic_id(numa_node_id) == -1) continue;|

    and that guard is gone. For a node that is online but has no CPUs
    (CXL / dax-kmem memory-only nodes, hotplug-added memory nodes, HBM
    nodes), |cpumask_of_node()| is empty, so |kfd_fill_cu_for_cpu()|
    hits the |processor_id_low == -1| check at line 1791 and returns
    -EINVAL. |kfd_create_vcrat_image_cpu()| propagates that at line
    1951, producing exactly the "Error parsing VCRAT" / "Error
    initializing KFD node" failure this patch is fixing — just on a
    different machine.

    Suggest folding the check into the skip condition so such nodes
    still consume a proximity domain (which is what the commit message
    describes):

    |if (!node_online(numa_node_id) ||
    kfd_numa_node_to_apic_id(numa_node_id) == -1) {
    crat_table->num_domains++; continue; }|

I think that last suggestion is wrong though, because it basically 
defeats the purpose of that patch by skipping CPU-less NUMA domains.

And one AI comment on patch 3/3:

    Newly reachable misclassification. With this patch a
    CPU-less-but-has-memory NUMA node (CXL/dax-kmem, generic-initiator)
    now emits a Memory entry. On parse, that node's topology device has
    |cpu_cores_count == 0|, so this branch treats it as a GPU node;
    |kfd_fill_mem_info_for_cpu()| memsets the entry (line 1819) so
    |visibility_type == 0|, and the heap is tagged
    |HSA_MEM_HEAP_TYPE_FB_PRIVATE| instead of |HSA_MEM_HEAP_TYPE_SYSTEM|.

    Result: host CXL/hotplug memory is exported to ROCr/Thunk as private
    framebuffer on a node with no GPU. This path was unreachable before
    because |kfd_fill_cu_for_cpu()| bailed with -EINVAL.

    |cpu_cores_count| is no longer a valid CPU-vs-GPU discriminator.
    Suggest keying off GPU-ness instead, e.g.:

    |if (dev->node_props.simd_count == 0) heap_type =
    HSA_MEM_HEAP_TYPE_SYSTEM; else if (mem->visibility_type == 0)
    heap_type = HSA_MEM_HEAP_TYPE_FB_PRIVATE; else heap_type =
    mem->visibility_type;|

    (GPU VCRAT emits the CU entry before the memory entries, so
    |simd_count| is already populated when this runs.)


Regards,
   Felix


> Thanks,
> Dhruv B
>
>
>>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> ---
>>> Test environment — contiguous NUMA (4 nodes, 0-3)
>>> --------------------------------------------------
>>>
>>> numactl reports 4 contiguous nodes (0-3), all with CPUs and memory:
>>>
>>>   $ numactl -H
>>>   available: 4 nodes (0-3)
>>>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
>>>                22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
>>>                41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
>>>   node 0 size: 881496 MB
>>>   node 0 free: 875909 MB
>>>   node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74
>>>                75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93
>>>                94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 
>>> 109
>>>                110 111
>>>   node 1 size: 885640 MB
>>>   node 1 free: 883815 MB
>>>   node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122 123 124 125
>>>                126 127 128 129 130 131 132 133 134 135 136 137 138 139
>>>                140 141 142 143 144 145 146 147 148 149 150 151 152 153
>>>                154 155 156 157 158 159 160 161 162 163 164 165 166 167
>>>   node 2 size: 885640 MB
>>>   node 2 free: 874248 MB
>>>   node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178 179 180 181
>>>                182 183 184 185 186 187 188 189 190 191 192 193 194 195
>>>                196 197 198 199 200 201 202 203 204 205 206 207 208 209
>>>                210 211 212 213 214 215 216 217 218 219 220 221 222 223
>>>   node 3 size: 885394 MB
>>>   node 3 free: 884033 MB
>>>
>>> The KFD topology sysfs reflects all 4 CPU nodes (0-3) plus 2 GPUs
>>> (nodes 4 and 5), each CPU node with correct core and memory counts:
>>>
>>>   /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
>>>
>>>   0: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>>>   1: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>>>   2: cpu_cores_count 56  mem_banks_count 1 io_links_count 2
>>>   3: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>>>   4: cpu_cores_count  0  simd_count 416  io_links_count 1 (GPU)
>>>   5: cpu_cores_count  0  simd_count 416  io_links_count 1 (GPU)
>>>
>>> RCCL unit tests — 948 cases, all PASS:
>>>
>>> ---
>>> Test environment — discontiguous NUMA (3 nodes: 0, 2-3)
>>> --------------------------------------------------------
>>>
>>> numactl reports 3 nodes with a gap at node 1. Nodes 2 and 3 are
>>> CPU-less and memory-less:
>>>
>>>   $ numactl -H
>>>   available: 3 nodes (0,2-3)
>>>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
>>>                22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
>>>   node 0 size: 519305 MB
>>>   node 0 free: 504963 MB
>>>   node 2 cpus: (none)
>>>   node 2 size: 0 MB
>>>   node 2 free: 0 MB
>>>   node 3 cpus: (none)
>>>   node 3 size: 0 MB
>>>   node 3 free: 0 MB
>>>
>>> After this patch series the KFD topology sysfs correctly preserves the
>>> NUMA node IDs as proximity domains. Node 1 appears as an empty
>>> placeholder, nodes 2 and 3 have no cores or memory banks but carry the
>>> GPU IO links, and both GPUs correctly reference node 2 as their 
>>> attached
>>> CPU-less domain:
>>>
>>>   /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
>>>
>>>   0: cpu_cores_count 40  mem_banks_count 1 io_links_count 0
>>>   1: cpu_cores_count  0  mem_banks_count 0 io_links_count 0 (absent,
>>> placeholder)
>>>   2: cpu_cores_count  0  mem_banks_count 0 io_links_count 2 (CPU-less,
>>> GPUs attached)
>>>   3: cpu_cores_count  0  mem_banks_count 0 io_links_count 0 (CPU-less)
>>>   4: cpu_cores_count  0  simd_count 416  io_links_count 1 (GPU)
>>>   5: cpu_cores_count  0  simd_count 416  io_links_count 1 (GPU)
>>>
>>>   node 4 io_link: node_from 4  node_to 2 type 2  max_bandwidth 10000
>>>   node 5 io_link: node_from 5  node_to 2 type 2  max_bandwidth 10000
>>>
>>> RCCL unit tests — 948 cases, all PASS:
>>>
>>> We fully understand your concern about regressions. We would
>>> greatly appreciate it if someone with access to the systems you 
>>> mentioned
>>> could test this series, and we are very happy to make any adjustments
>>> based on that feedback.
>>>
>>> Regards,
>>> Dhruv
>>>
>>>>
>>>> That said, the patch series looks good to me now, in theory.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>>> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40 
>>>>> +++++++++++++++------------
>>>>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>> index 7dad8f30ff2a..329931b0edc6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>> @@ -1944,28 +1944,32 @@ static int kfd_create_vcrat_image_cpu(void
>>>>> *pcrat_image, size_t *size)
>>>>>           }
>>>>>             /* Fill in Subtype: Compute Unit */
>>>>> -        ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>>> -            crat_table->num_domains,
>>>>> -            (struct crat_subtype_computeunit *)sub_type_hdr);
>>>>> -        if (ret < 0)
>>>>> -            return ret;
>>>>> -        crat_table->length += sub_type_hdr->length;
>>>>> -        crat_table->total_entries++;
>>>>> +        if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
>>>>> +            ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>>> +                          crat_table->num_domains,
>>>>> +                          (struct crat_subtype_computeunit
>>>>> *)sub_type_hdr);
>>>>> +            if (ret < 0)
>>>>> +                return ret;
>>>>> +            crat_table->length += sub_type_hdr->length;
>>>>> +            crat_table->total_entries++;
>>>>>   -        sub_type_hdr = (typeof(sub_type_hdr))((char 
>>>>> *)sub_type_hdr +
>>>>> -            sub_type_hdr->length);
>>>>> +            sub_type_hdr = (typeof(sub_type_hdr))((char
>>>>> *)sub_type_hdr +
>>>>> +                sub_type_hdr->length);
>>>>> +        }
>>>>>             /* Fill in Subtype: Memory */
>>>>> -        ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>>>> -            crat_table->num_domains,
>>>>> -            (struct crat_subtype_memory *)sub_type_hdr);
>>>>> -        if (ret < 0)
>>>>> -            return ret;
>>>>> -        crat_table->length += sub_type_hdr->length;
>>>>> -        crat_table->total_entries++;
>>>>> +        if (node_state(numa_node_id, N_MEMORY)) {
>>>>> +            ret = kfd_fill_mem_info_for_cpu(numa_node_id, 
>>>>> &avail_size,
>>>>> +                            crat_table->num_domains,
>>>>> +                            (struct crat_subtype_memory
>>>>> *)sub_type_hdr);
>>>>> +            if (ret < 0)
>>>>> +                return ret;
>>>>> +            crat_table->length += sub_type_hdr->length;
>>>>> +            crat_table->total_entries++;
>>>>>   -        sub_type_hdr = (typeof(sub_type_hdr))((char 
>>>>> *)sub_type_hdr +
>>>>> -            sub_type_hdr->length);
>>>>> +            sub_type_hdr = (typeof(sub_type_hdr))((char
>>>>> *)sub_type_hdr +
>>>>> +                sub_type_hdr->length);
>>>>> +        }
>>>>>             /* Fill in Subtype: IO Link */
>>>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
--------------zigTFRG8Iy32SDEp8vR5ABu0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-10-26 14:07, Dhruv Bhogaonkar
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 08/10/26 02:31, Kuehling, Felix
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com">On
        2026-10-07 07:14, Dhruv Bhogaonkar wrote: <br>
        <blockquote type="cite">[Some people who received this message
          don't often get email from <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:dhruvb@linux.ibm.com" moz-do-not-send="true">dhruvb@linux.ibm.com</a>.
          Learn why this is important at <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification" moz-do-not-send="true">https://aka.ms/LearnAboutSenderIdentification</a>
          ] <br>
          <br>
          On 07/10/26 01:30, Felix Kuehling wrote: <br>
          <blockquote type="cite"> <br>
            On 2026-10-06 08:51, Dhruv B wrote: <br>
            <blockquote type="cite">In heterogeneous or non-uniform NUMA
              systems, a NUMA node may be <br>
              CPU-less, memory-less, or both CPU-less and memory-less. <br>
              <br>
              Previously, kfd_create_vcrat_image_cpu() assumed that
              every online NUMA <br>
              node contained both compute units and memory, attempting
              to create both <br>
              CU and memory CRAT entries unconditionally for every
              online node. <br>
              <br>
              Add explicit guards to: <br>
              1. Only create Compute Unit CRAT entries if the NUMA node
              has valid <br>
              &nbsp;&nbsp;&nbsp; CPU cores (kfd_numa_node_to_apic_id() != -1). <br>
              2. Only create Memory CRAT entries if the NUMA node
              actually contains <br>
              &nbsp;&nbsp;&nbsp; memory (node_state(numa_node_id, N_MEMORY)). <br>
              <br>
              This avoids emitting invalid or empty CRAT subtype entries
              for CPU-less, <br>
              memory-less, or both CPU-less and memory-less NUMA nodes
              in virtual CRAT <br>
              generation. <br>
            </blockquote>
            <br>
            @David Yat Sin, I think we currently support CPU-less and
            memory-less <br>
            NUMA domains already. I know we have CPU-less NUMA domains
            on MI300A <br>
            in NPS4/TPX mode. And I remember we've fixed bugs on NUMA
            CPU systems <br>
            with only one DIMM populated, which would result in a
            memory-less NUMA <br>
            domain. <br>
            <br>
            Therefore, I'm not sure whether this patch is really needed
            and I'd be <br>
            concerned about introducing a regression. Is ROCr able to
            handle the <br>
            changes being proposed here? David, could you take a look at
            this and <br>
            maybe even test it, or find someone who could help test it
            on the <br>
            system configurations I described? <br>
          </blockquote>
          <br>
          Thank you for the feedback, Felix. Apologies for the bug in v1
          — <br>
          that was an oversight on our part. <br>
          <br>
          From the current code, the kfd_numa_node_to_apic_id() == -1 <br>
          continue causes the entire loop body to be skipped <br>
          for a CPU-less NUMA node: <br>
          <br>
          &nbsp; for_each_online_node(numa_node_id) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_numa_node_to_apic_id(numa_node_id) == -1) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue; <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_fill_cu_for_cpu(...); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ... <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_fill_mem_info_for_cpu(...); <br>
          &nbsp; } <br>
          <br>
          When the loop body is skipped, neither a CU entry nor a memory
          entry is <br>
          generated for that node, and no KFD topology device appears to
          be <br>
          registered for it from this code path. From our reading, it
          appears that <br>
          CPU-less nodes are effectively absent from the generated VCRAT
          topology <br>
          rather than being represented with an empty or placeholder
          entry. <br>
        </blockquote>
        <br>
        OK. I'm a bit surprised about that, because MI300A in NPS4 mode
        should have three CPU-less NUMA nodes per socket. Maybe we never
        depended on them being represented as CPU-less NUMA nodes in the
        KFD topology. Then this change should be an improvement because
        it removes some ambiguity between NUMA node numbers and KFD
        proximity domains. <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite"> <br>
            @Dhruv B, how much testing have you done on this patch
            series. Given <br>
            that the bug in patch 2 slipped through in v1, I'm worried
            that it's <br>
            not very thorough. <br>
          </blockquote>
          <br>
          Regarding testing, on the userspace side we ran the RCCL unit
          tests. <br>
          <br>
          On the kernel side, we verified that the IO links are created
          correctly <br>
          for both topologies by inspecting the KFD topology sysfs
          entries after <br>
          driver load. <br>
          <br>
          Here are the RCCL unit test results for both configurations,
          along with <br>
          the corresponding numactl and KFD topology sysfs output
          observed after <br>
          driver load. <br>
        </blockquote>
        <br>
        Sounds good. We still need to test MI300A to make sure the
        changes don't confuse ROCr or amdsmi. Applications mostly
        shouldn't care because they don't use KFD topology node numbers
        directly. I'm told that most of the MI300A systems in production
        seem to use NPS1, so this shouldn't affect them.</blockquote>
      <p><br>
      </p>
      <p data-pm-slice="1 1 []" style="caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-size: medium; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span>Hi
          Felix,</span></p>
      <p style="caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-size: medium; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span>I
          wanted to ask if there have been any updates on the</span><br>
        <span>patch series and whether anything would be required&nbsp;<br>
          from my</span><span>&nbsp;side.</span></p>
    </blockquote>
    <p>Thanks for the reminder. We did some testing of these patches and
      also considered what configurations of MI300A are actually
      deployed. An automated AI review caught two other problematic
      interactions in patch 2/3:</p>
    <blockquote>
      <p>Phantom domains have a knock-on effect in kfd_topology.c:
        kfd_create_indirect_link_prop() (kfd_<a class="moz-txt-link-freetext" href="topology.c:1421-1440">topology.c:1421-1440</a>) walks
        i over every CPU-side topology device and does return -ENOMEM
        when no matching cpu_link is found. A device synthesized for an
        offline node has an empty io_link_props, so on an x86 box with a
        hole in the node IDs and &gt;1 GPU, kfd_dev_create_p2p_links()
        now bails out and all indirect/P2P links are silently dropped
        (the return value at kfd_<a class="moz-txt-link-freetext" href="topology.c:2077">topology.c:2077</a> is ignored). Worth
        either skipping link-less CPU devices there or confirming this
        path was evaluated.</p>
    </blockquote>
    <p>And</p>
    <blockquote>
      <p>Regression: the old loop body started with</p>
      <pre><code>if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
        continue;</code></pre>
      <p>and that guard is gone. For a node that is online but has no
        CPUs (CXL / dax-kmem memory-only nodes, hotplug-added memory
        nodes, HBM nodes), <code>cpumask_of_node()</code> is empty, so
        <code>kfd_fill_cu_for_cpu()</code> hits the <code>processor_id_low
          == -1</code> check at line 1791 and returns -EINVAL. <code>kfd_create_vcrat_image_cpu()</code>
        propagates that at line 1951, producing exactly the &quot;Error
        parsing VCRAT&quot; / &quot;Error initializing KFD node&quot; failure this
        patch is fixing — just on a different machine.</p>
      <p>Suggest folding the check into the skip condition so such nodes
        still consume a proximity domain (which is what the commit
        message describes):</p>
      <pre><code>if (!node_online(numa_node_id) ||
    kfd_numa_node_to_apic_id(numa_node_id) == -1) {
        crat_table-&gt;num_domains++;
        continue;
}</code></pre>
    </blockquote>
    <p>I think that last suggestion is wrong though, because it
      basically defeats the purpose of that patch by skipping CPU-less
      NUMA domains.</p>
    <p>And one AI comment on patch 3/3:</p>
    <blockquote>
      <p>Newly reachable misclassification. With this patch a
        CPU-less-but-has-memory NUMA node (CXL/dax-kmem,
        generic-initiator) now emits a Memory entry. On parse, that
        node's topology device has <code>cpu_cores_count == 0</code>,
        so this branch treats it as a GPU node; <code>kfd_fill_mem_info_for_cpu()</code>
        memsets the entry (line 1819) so <code>visibility_type == 0</code>,
        and the heap is tagged <code>HSA_MEM_HEAP_TYPE_FB_PRIVATE</code>
        instead of <code>HSA_MEM_HEAP_TYPE_SYSTEM</code>.</p>
      <p>Result: host CXL/hotplug memory is exported to ROCr/Thunk as
        private framebuffer on a node with no GPU. This path was
        unreachable before because <code>kfd_fill_cu_for_cpu()</code>
        bailed with -EINVAL.</p>
      <p><code>cpu_cores_count</code> is no longer a valid CPU-vs-GPU
        discriminator. Suggest keying off GPU-ness instead, e.g.:</p>
      <pre><code>if (dev-&gt;node_props.simd_count == 0)
        heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
else if (mem-&gt;visibility_type == 0)
        heap_type = HSA_MEM_HEAP_TYPE_FB_PRIVATE;
else
        heap_type = mem-&gt;visibility_type;</code></pre>
      <p>(GPU VCRAT emits the CU entry before the memory entries, so <code>simd_count</code>
        is already populated when this runs.)</p>
    </blockquote>
    <p><br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com">
      <p style="caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-size: medium; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span>Thanks,</span><br>
        <span>Dhruv B</span></p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com">&nbsp;<br>
        <br>
        Regards, <br>
        &nbsp; Felix <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          --- <br>
          Test environment — contiguous NUMA (4 nodes, 0-3) <br>
          -------------------------------------------------- <br>
          <br>
          numactl reports 4 contiguous nodes (0-3), all with CPUs and
          memory: <br>
          <br>
          &nbsp; $ numactl -H <br>
          &nbsp; available: 4 nodes (0-3) <br>
          &nbsp; node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
          19 20 21 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
          38 39 40 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 <br>
          &nbsp; node 0 size: 881496 MB <br>
          &nbsp; node 0 free: 875909 MB <br>
          &nbsp; node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
          72 73 74 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90
          91 92 93 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 94 95 96 97 98 99 100 101 102 103 104 105 106
          107 108 109 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 110 111 <br>
          &nbsp; node 1 size: 885640 MB <br>
          &nbsp; node 1 free: 883815 MB <br>
          &nbsp; node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122 123
          124 125 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 126 127 128 129 130 131 132 133 134 135 136 137
          138 139 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 140 141 142 143 144 145 146 147 148 149 150 151
          152 153 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 154 155 156 157 158 159 160 161 162 163 164 165
          166 167 <br>
          &nbsp; node 2 size: 885640 MB <br>
          &nbsp; node 2 free: 874248 MB <br>
          &nbsp; node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178 179
          180 181 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 182 183 184 185 186 187 188 189 190 191 192 193
          194 195 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 196 197 198 199 200 201 202 203 204 205 206 207
          208 209 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 210 211 212 213 214 215 216 217 218 219 220 221
          222 223 <br>
          &nbsp; node 3 size: 885394 MB <br>
          &nbsp; node 3 free: 884033 MB <br>
          <br>
          The KFD topology sysfs reflects all 4 CPU nodes (0-3) plus 2
          GPUs <br>
          (nodes 4 and 5), each CPU node with correct core and memory
          counts: <br>
          <br>
          &nbsp; /sys/class/kfd/kfd/topology/nodes: 0&nbsp; 1&nbsp; 2 3&nbsp; 4&nbsp; 5 <br>
          <br>
          &nbsp; 0: cpu_cores_count 56&nbsp; mem_banks_count 1 io_links_count 0 <br>
          &nbsp; 1: cpu_cores_count 56&nbsp; mem_banks_count 1 io_links_count 0 <br>
          &nbsp; 2: cpu_cores_count 56&nbsp; mem_banks_count 1 io_links_count 2 <br>
          &nbsp; 3: cpu_cores_count 56&nbsp; mem_banks_count 1 io_links_count 0 <br>
          &nbsp; 4: cpu_cores_count&nbsp; 0&nbsp; simd_count 416&nbsp; io_links_count 1&nbsp;
          (GPU) <br>
          &nbsp; 5: cpu_cores_count&nbsp; 0&nbsp; simd_count 416&nbsp; io_links_count 1&nbsp;
          (GPU) <br>
          <br>
          RCCL unit tests — 948 cases, all PASS: <br>
          <br>
          --- <br>
          Test environment — discontiguous NUMA (3 nodes: 0, 2-3) <br>
          -------------------------------------------------------- <br>
          <br>
          numactl reports 3 nodes with a gap at node 1. Nodes 2 and 3
          are <br>
          CPU-less and memory-less: <br>
          <br>
          &nbsp; $ numactl -H <br>
          &nbsp; available: 3 nodes (0,2-3) <br>
          &nbsp; node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
          19 20 21 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
          38 39 <br>
          &nbsp; node 0 size: 519305 MB <br>
          &nbsp; node 0 free: 504963 MB <br>
          &nbsp; node 2 cpus: (none) <br>
          &nbsp; node 2 size: 0 MB <br>
          &nbsp; node 2 free: 0 MB <br>
          &nbsp; node 3 cpus: (none) <br>
          &nbsp; node 3 size: 0 MB <br>
          &nbsp; node 3 free: 0 MB <br>
          <br>
          After this patch series the KFD topology sysfs correctly
          preserves the <br>
          NUMA node IDs as proximity domains. Node 1 appears as an empty
          <br>
          placeholder, nodes 2 and 3 have no cores or memory banks but
          carry the <br>
          GPU IO links, and both GPUs correctly reference node 2 as
          their attached <br>
          CPU-less domain: <br>
          <br>
          &nbsp; /sys/class/kfd/kfd/topology/nodes: 0&nbsp; 1&nbsp; 2 3&nbsp; 4&nbsp; 5 <br>
          <br>
          &nbsp; 0: cpu_cores_count 40&nbsp; mem_banks_count 1 io_links_count 0 <br>
          &nbsp; 1: cpu_cores_count&nbsp; 0&nbsp; mem_banks_count 0 io_links_count 0
          (absent, <br>
          placeholder) <br>
          &nbsp; 2: cpu_cores_count&nbsp; 0&nbsp; mem_banks_count 0 io_links_count 2
          (CPU-less, <br>
          GPUs attached) <br>
          &nbsp; 3: cpu_cores_count&nbsp; 0&nbsp; mem_banks_count 0 io_links_count 0
          (CPU-less) <br>
          &nbsp; 4: cpu_cores_count&nbsp; 0&nbsp; simd_count 416&nbsp; io_links_count 1&nbsp;
          (GPU) <br>
          &nbsp; 5: cpu_cores_count&nbsp; 0&nbsp; simd_count 416&nbsp; io_links_count 1&nbsp;
          (GPU) <br>
          <br>
          &nbsp; node 4 io_link: node_from 4&nbsp; node_to 2 type 2&nbsp; max_bandwidth
          10000 <br>
          &nbsp; node 5 io_link: node_from 5&nbsp; node_to 2 type 2&nbsp; max_bandwidth
          10000 <br>
          <br>
          RCCL unit tests — 948 cases, all PASS: <br>
          <br>
          We fully understand your concern about regressions. We would <br>
          greatly appreciate it if someone with access to the systems
          you mentioned <br>
          could test this series, and we are very happy to make any
          adjustments <br>
          based on that feedback. <br>
          <br>
          Regards, <br>
          Dhruv <br>
          <br>
          <blockquote type="cite"> <br>
            That said, the patch series looks good to me now, in theory.
            <br>
            <br>
            Regards, <br>
            &nbsp; Felix <br>
            <br>
            <br>
            <blockquote type="cite"> <br>
              Co-developed-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com" moz-do-not-send="true">&lt;donettom@linux.ibm.com&gt;</a>
              <br>
              Signed-off-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com" moz-do-not-send="true">&lt;donettom@linux.ibm.com&gt;</a>
              <br>
              Signed-off-by: Dhruv B <a class="moz-txt-link-rfc2396E" href="mailto:dhruv.b@linux.ibm.com" moz-do-not-send="true">&lt;dhruv.b@linux.ibm.com&gt;</a>
              <br>
              --- <br>
              &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40
              +++++++++++++++------------ <br>
              &nbsp; 1 file changed, 22 insertions(+), 18 deletions(-) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
              b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
              index 7dad8f30ff2a..329931b0edc6 100644 <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
              @@ -1944,28 +1944,32 @@ static int
              kfd_create_vcrat_image_cpu(void <br>
              *pcrat_image, size_t *size) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in Subtype: Compute Unit */ <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_fill_cu_for_cpu(numa_node_id,
              &amp;avail_size, <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;num_domains, <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct crat_subtype_computeunit
              *)sub_type_hdr); <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret; <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;length += sub_type_hdr-&gt;length;
              <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;total_entries++; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_numa_node_to_apic_id(numa_node_id) != -1)
              { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_fill_cu_for_cpu(numa_node_id,
              &amp;avail_size, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;num_domains, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct
              crat_subtype_computeunit <br>
              *)sub_type_hdr); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;length +=
              sub_type_hdr-&gt;length; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;total_entries++; <br>
              &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr = (typeof(sub_type_hdr))((char
              *)sub_type_hdr + <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;length); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr = (typeof(sub_type_hdr))((char <br>
              *)sub_type_hdr + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;length); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in Subtype: Memory */ <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_fill_mem_info_for_cpu(numa_node_id,
              &amp;avail_size, <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;num_domains, <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct crat_subtype_memory *)sub_type_hdr);
              <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret; <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;length += sub_type_hdr-&gt;length;
              <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;total_entries++; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node_state(numa_node_id, N_MEMORY)) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kfd_fill_mem_info_for_cpu(numa_node_id,
              &amp;avail_size, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;num_domains, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct crat_subtype_memory <br>
              *)sub_type_hdr); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;length +=
              sub_type_hdr-&gt;length; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crat_table-&gt;total_entries++; <br>
              &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr = (typeof(sub_type_hdr))((char
              *)sub_type_hdr + <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;length); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr = (typeof(sub_type_hdr))((char <br>
              *)sub_type_hdr + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;length); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in Subtype: IO Link */ <br>
              &nbsp; #if defined(CONFIG_X86_64) &amp;&amp;
              !defined(CONFIG_UML) <br>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------zigTFRG8Iy32SDEp8vR5ABu0--

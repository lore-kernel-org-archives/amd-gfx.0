Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9DFC19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C7910E323;
	Thu, 27 Feb 2025 15:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fY0L1Xg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1AB410E396
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxeKR5kR8HfHLbrqY7+SQgHLbED/4K+Rd6iIc6AoMxryXDMgI2Jl18isjRh5zpdfgYPJE4dVeKGXtNG2NLO4Abyj7Z+csKBaaTHKqI9WjKG95e+Ost3shfQFGT/6NdDG9mT/Cb3AlQb8VXmbeWezcof3kneDpAOIGSRYg0Xpa/8uVbVSgsjtAotAuyKHFCNboVxwHzI/1xATCf6M/MXEaKdUTJ1ZkyQhBFuSwQjlqJZ0z2/o+P5ELTJqS7TwrRHdITONowKKUEwCbfajmM8qMz3nIORy6WemfShUEy4cKTtNllkyfwVt82IsGhZiEIiuuFG73rnwCzip4zKICgzAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFguJT5EsEN6Wd2TLp5RRYJK1pAELchDgYmz74DdlS4=;
 b=A3zENkup1Eb3U4/D29LG5I73NcdsI4iGitB9cmrGRPm5h5yxRlvWPGxacuCOcG3n2lYKcYGhg213K+TOjD3BTf0aNgUy31yAppQCaKV6e0kbuXSkKVhCr0QqXRvRl/i/JO+Tj37sGaWgIGtsbOjPflWIFNsnBZnWexea/xVGnQnrfvgrhdXBW2+ESXei2mtbjwLqe3lbWL8uaJ2wpBy050Nhf0YSN/9vWtXKLwYPqIRBvaJP54MEl0/rHIL5ypUIk5toZLbSJicOZFc/RWhA7ZmCw1AQvcbUIhj7iMP1g84vkjobICsZTG8c/v6KBFIUkRqzXV2ht40PTUTwgicfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFguJT5EsEN6Wd2TLp5RRYJK1pAELchDgYmz74DdlS4=;
 b=5fY0L1Xg6jRLs8MuAjsWAPZ61HFBBHKnasb+VQR+7RBXswzAuczJIG03rZCvhHebzq2RmDeL/ZOLJBZeAyvKY3mAVRwb15R1EdIbofWIhrvEf5GScsvAJeScNNj8yaIM4rf+oxesWbmNMEvVF9yjAjiE9lQEQ3l36v73s4vBPxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.21; Thu, 27 Feb 2025 15:42:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 15:42:55 +0000
Message-ID: <b3e0a1ad-eca8-4d3f-bd0f-2a505758627e@amd.com>
Date: Thu, 27 Feb 2025 16:42:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix the memleak caused by fence not
 released
To: "Yadav, Arvind" <arvyadav@amd.com>, Arvind Yadav <Arvind.Yadav@amd.com>,
 shashank.sharma@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 sunil.khatri@amd.com, Le Ma <le.ma@amd.com>
References: <20250218145322.1500-1-Arvind.Yadav@amd.com>
 <b453f96c-ec53-48cc-9179-7dd70012c561@amd.com>
 <def5c837-f2bc-3667-fa18-b755c1392d35@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <def5c837-f2bc-3667-fa18-b755c1392d35@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0893.namprd03.prod.outlook.com
 (2603:10b6:408:13c::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 651ef5f5-3e4a-4e69-9c21-08dd5745672b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDhlYjhhMHl0Mktpbm9GNyt3enk0Z3ZpblRTekZ3K2Z0N0d4UHFPTkpCdmlR?=
 =?utf-8?B?WHdwWWpoQ1FVTkZuQ1ZIbGpvVndsVUFMYjIyVVhaUmNwR0hpZE1JeVBTQlFI?=
 =?utf-8?B?ZXJjejM4cmd5dXhxNExNWmFwS0hqaGVGeG9ublFWZm9Qc3JPK2JHdzFhQlZP?=
 =?utf-8?B?Sm5FTGtKLzRBNVQvK21EWXQvK2NMR21vRThiZXgwTlNQZEEzZ1c4WFdNTUJI?=
 =?utf-8?B?QmVtQ2xna0QzNk1SbjlpZURYbUhUTjdQY2x3WGZpVVZRc1VMbGhtVlJobUkw?=
 =?utf-8?B?UnJiaWREcGlkbjlKUy85QWFaa29WNkFWd0JmSVFkZ3hKL21pMUxVVHRiK1g2?=
 =?utf-8?B?ZFdVV1AzYWpPbmgyQUFQZTRGL1UzK0tPc3dNQzZrZllmaGJtOEU1QTArMGhm?=
 =?utf-8?B?N2hnMHZPY1IydldGa25qSldLQlRNOUdFWERIRVZ2Mk9DUGw4ZkNxWDMycWFp?=
 =?utf-8?B?Q3BFUk1HdlZ1dDFOenNjaHZjNTRQUTFTQzhXVEpWUTNxREhEczNKVGxuRjFX?=
 =?utf-8?B?b1QzVmdPSVJmM0Izay8weStVQ3hBejZYcFJod3ZHcjlJRUt0b3M3ZWV0SW5I?=
 =?utf-8?B?OU1BYnY1WCt0TkJUbzRrcXJYMlRFV0FHSTMrRTJZZm1MRGNtUU12dm0rbDdo?=
 =?utf-8?B?aWtJeDdQZ05SSTB1Rjk5SVREZ0ExVmd0QXZmVmNCdCt5bk55Q0hXOEYyQlQz?=
 =?utf-8?B?RVhrcmlFUTk3UDc5bUUxVXB4VG5GdzRKTVBDRUZVa09BcVc4WHJHVnNEM3A2?=
 =?utf-8?B?WFUxVGxVbXNCazUzRndpMkxHMDFtTnlmWjM0Z1BySjRadDNUMUZxUmRqMElG?=
 =?utf-8?B?M1lkWUI4ZDhwb3hkdkp5MUdldHRheXhRaTFJVDI1bmd3a0dtYVVUT2dCcFBa?=
 =?utf-8?B?dlQwdkJsdXJlZ0pzaDNXRy9kMklTN1JhMGdXc3BYemlQSmM2OXp0V2xLZ0Fo?=
 =?utf-8?B?L3poNHRhV2grb1IyaEwzejlFbGpTdmFvejE0aHNtU1hJSmM4UGRtQytKTUpF?=
 =?utf-8?B?MFlNbi91c2YrdGhIYVZrczFkOGY2bWU5bGFzbXFKRVhaSzUweHdOUGh0UVFQ?=
 =?utf-8?B?VnQweVo0aTRGQklCR3hxV3pJZFNUTEpaVjlFRlVjMXdwU2JaOElsTnI4YU43?=
 =?utf-8?B?cDVPMytiTnh1eVhXZUtYQ0htdFNSV1k2K1RMQVAvMHFDLytHOGU4ZkhBZFg4?=
 =?utf-8?B?Y080SHR3WWxDSFlvWGxpek1QeTNRV2tJS2xVMGQ5TVdtZkRhU0g0cExDSUsx?=
 =?utf-8?B?Q1ZBVTl1MGdZZkRvWXAvYnFwSVhpVUV1WWFaeUZyY1BucHpOeHhSTWRpK0tl?=
 =?utf-8?B?anhPdnB5NUUwOVpzRGRxOW5PRzBrc2hlQUdRamxwSWZNREFQc3MrSU1nbnpI?=
 =?utf-8?B?R1JvUWdpbW0xZ0QyZGRGTTI5bkhveS9FMjFXZjQ4RUJYdnF1YmMwUkJsNnRn?=
 =?utf-8?B?RWVqdzVjRXg3WWdHSzYwenlvUTRMUTc2Z0k3ZGhBV0FRMUFGSUIrMXpHRG4r?=
 =?utf-8?B?VUphOCtNOE5kR0Y2RjJ5L1dyVFVIRjNmaDNyOUhXTGorLzRnU2RMWWptSjlM?=
 =?utf-8?B?WDdQbXQwNTdWZVgrZU9tWXU1UzlxREx3Q1gzNU90UDJyYThIUFgveWZiL295?=
 =?utf-8?B?L0xvNGtWeEtyWlY0QUgyc2ZFQXlJUDdKQTRSbnBJNnorVlhXMTEwMndRU3J6?=
 =?utf-8?B?SHFMNlJCK1k3aitMOXRvRnJPdFpIRld0NUJjbFBVZWJOK2pWUVdYekVReXMz?=
 =?utf-8?B?cnVVR0Y1eXAwRWVzZ1VVN0tHY0pSK2F6cjBaOVhITXZZNjdnWVlCRWozcFJL?=
 =?utf-8?B?SitVOTEyTldxMzJsQjdzQml1MStpb3pRTnhNTlZHYkNsb0ZvREF6dHhHckJs?=
 =?utf-8?Q?xVz2F9Ol5uZjp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdMcW9adXVOaU5wcEN6YklHL0RhUDFmWlhrdVZaZFl0KzZRTHFEMmViRUpU?=
 =?utf-8?B?U3lLbVF6ZUVGSEo2bkd4RzRwdUJRZTg3TkJvZnM3Wk1TR09QZ0ZsQk55bFdV?=
 =?utf-8?B?UmVhVUlEVEV3VFpydzM1Sk00SzVCWVZrUVdTQXd0U2I1TDRFalhzdGlwd2N0?=
 =?utf-8?B?M0VFSnBtWFR5VEtwVnpsTCtic3BHOHpzdGI2L3M1S1VrUHBXTjJMTzZTRUVK?=
 =?utf-8?B?R2NtWXNqUDBvTGJBZ09OS1ZwYldsMmRYR0xqbGdvdWxNTy9kVHU1ck5xYkZk?=
 =?utf-8?B?WnM2YTgzWjI3MmcrTDFTOFFNUk1PS1IzQXJvRHpGSmc0WWoyblhVN2pyQ1hH?=
 =?utf-8?B?THh1L29LQmh4c0RyWlFmRE9vMFgzVFlISmZyUlZYN3R6OXNPMUlNNVc4QUR6?=
 =?utf-8?B?aEhUdGFWcXdmRTc3dE9xcDZ2YVVsVWtaK1lOZ0Evc1czeDg0U0Rkb2NUTmpF?=
 =?utf-8?B?YTRMTVc0ZHhaSVQzUGt1QStzN2tZd2JPc3ZUdUoxT0lPcXhLcGVlMWE5SjAw?=
 =?utf-8?B?blhBWHVRMklWZTRpVkN1L2FWL3JrQkI5aVJ0eVBxdmJrTzMzTUVPZ1NTM2k5?=
 =?utf-8?B?dmNIWUwrWjRsRU1DT29wc0Q4VGx5YlFLNFNma2J6V1o0OHBCOU5KdmwraWtG?=
 =?utf-8?B?aEdjVGxwUzZ6V1VnUjBHb3Frb1RiNE9Ta1JMWEtTdEtma0VZUzZvMXFETk9T?=
 =?utf-8?B?UVFUb1pXcVU1SFlSTE51VVovanRzcksvWFE4cjc2ZUJXMTBVbnhGa3kvYXFY?=
 =?utf-8?B?cUFUbTduaisrSStYZVJ4UjV0czdEUEFvNTZwVkVUYnBBdmFJclI1VHJzUEl3?=
 =?utf-8?B?cXpsaXI4UE04Wk5oR0RmYUpmWWd0dE5JQUpvdmp2cTRveVN2Uzd6VWpVdzN3?=
 =?utf-8?B?TndhRGoyb3orVG5OZzVzY1FRTElxZndreXkzNzBFWDNneXg0RDAraXpidTNJ?=
 =?utf-8?B?ZlVKTGtwdjhzS29nV25ZL3dXWXViVTNTUmxxQkJ5bHZ2QlZqeHhjd0oyb0I3?=
 =?utf-8?B?UTZJdlhJZEI0SXZLNUtjMzZPQ2dIVXRlVlpnRDdHdnV0V251RzE1OThGeW15?=
 =?utf-8?B?S1dHUlpBckVvVm1jUXRidzgxWW1GTXUrbFh4OEFqb0ErT1NaeHdBWWlZRUlG?=
 =?utf-8?B?RjFQK2ZhMkc5NVdudnpTNTREUGxLZDZTNEp5dk0xZU9EWjUwd3JBTC9OSEVs?=
 =?utf-8?B?MGtEc3pHYXdsdG1jY1FzRVZBRnZxVG14b21CN2JFUUFGMnlocG0zZkE0NUJ3?=
 =?utf-8?B?UVVrZS9ub21SWnFsMEU1MTFzSm1COFh0cUZab1hXZTJuZTRNV1UrTi9YRVJv?=
 =?utf-8?B?R2ltc3pZZXJGS3M2YnFaRnVJUFlDZG5vQ1l3WnJoeC9yTXd1aWh3QXMxeGhr?=
 =?utf-8?B?MWE5MXRpUExFdUhIRmVKMXBvdXZ0SmpBSGJzK0NPWlhMN2wrTGFUbW51dGxj?=
 =?utf-8?B?UWcyRGJIblVqTUMwS3hncFZaYlNBK2YxdzlINURoSUQrS0pFVEYybVNWWm1D?=
 =?utf-8?B?emRGQ2UrN2dpUytyeUwyazJweWNPMGdlRWZLUXBxZWJOcm9nbzVDZjVWOG1k?=
 =?utf-8?B?bVFEaWlEMWdabHBENVZFazB1bzhzMWNxellzanpjNDhBQmZTR1Nyb0xJWmJu?=
 =?utf-8?B?T3ZJbFdJVWZGSlNJSFdxTWZiSkVLMnNVcUNEcHNHd1ZDSSs4NWJWV1dYMjlR?=
 =?utf-8?B?T0xkQ3k1MjhsRzdRcnRrbXI5cnZxT3BzK0M5QWJycnQzaEJOWVFnRUFEYXNi?=
 =?utf-8?B?ZzZCN2hXTFcyRmczWWRZVCtRK1A2TU42N2pISENvd240dU1OQ2ZCbWRqcy9a?=
 =?utf-8?B?cDdTNmtVcXNmQitiaVNHbmFwclRzV2JaNU4rbU1GeGo2ZlNyaklEWjNwa1hz?=
 =?utf-8?B?czYwZWhKdE1ZWlFsanVKb01mdHVtcnF0c2RnZWlqZ1QwVlE0ZnVRV1BkbHVu?=
 =?utf-8?B?UkZiVjY3MHd3UmRGWDY0RTJIOFhqUXdpZDRseGg5b0ZsZU1uaFpCVWFkcjMy?=
 =?utf-8?B?azVBb1VNNFBad2FabnQ4MUFFZ2t3bnNiWVB3Wm1IczlGRFdLQnorcktDQTB2?=
 =?utf-8?B?RWtUS3FTY1F5OVdCcityVEtFWVk0cGdkVytQU054TmRDSkU0ZmRmWHhOWDN1?=
 =?utf-8?Q?pSgLegKkavoAlWzbdcXikXnR9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651ef5f5-3e4a-4e69-9c21-08dd5745672b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:42:55.3753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAydhoctdum+iQrFwfPMOsVaIMFG4X+b39XRxyHdPGhveIF5gvk1Pl5Qb57HvaLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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

Am 27.02.25 um 16:08 schrieb Yadav, Arvind:
>
> On 2/27/2025 7:55 PM, Christian König wrote:
>>
>> Am 18.02.25 um 15:53 schrieb Arvind Yadav:
>>> Encountering a taint issue during the unloading of gpu_sched
>>> due to the fence not being released/put. In this context,
>>> amdgpu_vm_clear_freed is responsible for creating a job to
>>> update the page table (PT). It allocates kmem_cache for
>>> drm_sched_fence and returns the finished fence associated
>>> with job->base.s_fence. In case of Usermode queue this finished
>>> fence is added to the timeline sync object through
>>> amdgpu_gem_update_bo_mapping, which is utilized by user
>>> space to ensure the completion of the PT update.
>>>
>>> [  508.900587] =============================================================================
>>> [  508.900605] BUG drm_sched_fence (Tainted: G                 N): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
>>> [  508.900617] -----------------------------------------------------------------------------
>>>
>>> [  508.900627] Slab 0xffffe0cc04548780 objects=32 used=2 fp=0xffff8ea81521f000 flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
>>> [  508.900645] CPU: 3 UID: 0 PID: 2337 Comm: rmmod Tainted: G                 N 6.12.0+ #1
>>> [  508.900651] Tainted: [N]=TEST
>>> [  508.900653] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F34 06/10/2021
>>> [  508.900656] Call Trace:
>>> [  508.900659]  <TASK>
>>> [  508.900665]  dump_stack_lvl+0x70/0x90
>>> [  508.900674]  dump_stack+0x14/0x20
>>> [  508.900678]  slab_err+0xcb/0x110
>>> [  508.900687]  ? srso_return_thunk+0x5/0x5f
>>> [  508.900692]  ? try_to_grab_pending+0xd3/0x1d0
>>> [  508.900697]  ? srso_return_thunk+0x5/0x5f
>>> [  508.900701]  ? mutex_lock+0x17/0x50
>>> [  508.900708]  __kmem_cache_shutdown+0x144/0x2d0
>>> [  508.900713]  ? flush_rcu_work+0x50/0x60
>>> [  508.900719]  kmem_cache_destroy+0x46/0x1f0
>>> [  508.900728]  drm_sched_fence_slab_fini+0x19/0x970 [gpu_sched]
>>> [  508.900736]  __do_sys_delete_module.constprop.0+0x184/0x320
>>> [  508.900744]  ? srso_return_thunk+0x5/0x5f
>>> [  508.900747]  ? debug_smp_processor_id+0x1b/0x30
>>> [  508.900754]  __x64_sys_delete_module+0x16/0x20
>>> [  508.900758]  x64_sys_call+0xdf/0x20d0
>>> [  508.900763]  do_syscall_64+0x51/0x120
>>> [  508.900769]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> v2: call dma_fence_put in amdgpu_gem_va_update_vm
>>> v3: Addressed review comments from Christian.
>>>      - calling amdgpu_gem_update_timeline_node before switch.
>>>      - puting a dma_fence in case of error or !timeline_syncobj.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>> Signed-off-by: Le Ma <le.ma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 33 +++++++++++++------------
>>>   1 file changed, 17 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 8b67aae6c2fe..40522b4f331b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -125,9 +125,6 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>>>       struct amdgpu_vm *vm = &fpriv->vm;
>>>       struct dma_fence *last_update;
>>>   -    if (!syncobj)
>>> -        return;
>>> -
>>>       /* Find the last update fence */
>>>       switch (operation) {
>>>       case AMDGPU_VA_OP_MAP:
>>> @@ -839,6 +836,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>       struct drm_exec exec;
>>>       uint64_t va_flags;
>>>       uint64_t vm_size;
>>> +    int syncobj_status;
>>>       int r = 0;
>>>         if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
>>> @@ -931,6 +929,12 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>           bo_va = NULL;
>>>       }
>>>   +    syncobj_status = amdgpu_gem_update_timeline_node(filp,
>>> +                    args->vm_timeline_syncobj_out,
>>> +                    args->vm_timeline_point,
>>> +                    &timeline_syncobj,
>>> +                    &timeline_chain);
>>> +
>> You don't need syncobj_status here, just assign the return value to r and abort if we can't find any syncobj.
>
> I have not used variable 'r' because below inside switch(args->operation) the 'r' value will be reinitialized and the return value of amdgpu_gem_update_timeline_node will not be used. Here, we cannot abort because syncobj will be NULL for Non-UQ.

No, no that's wrong.

That timeline_syncobj is NULL is not an error. In other words when args->vm_timeline_syncobj_out == 0 then amdgpu_gem_update_timeline_node() should just set timeline_syncobj=NULL and return 0.

The error happens only if either args->vm_timeline_syncobj_out has a handler we can't find or if we fail to allocate memory for the timeline_chain.

In this case the return value should be EINVAl or ENOMEM and then we absolutely should abort the operation.

Regards,
Christian.

> we can use r but it will not do anything. :)
>
>
>>
>>>       switch (args->operation) {
>>>       case AMDGPU_VA_OP_MAP:
>>>           va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
>>> @@ -957,22 +961,19 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>           break;
>>>       }
>>>       if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
>>> -
>>> -        r = amdgpu_gem_update_timeline_node(filp,
>>> -                            args->vm_timeline_syncobj_out,
>>> -                            args->vm_timeline_point,
>>> -                            &timeline_syncobj,
>>> -                            &timeline_chain);
>>> -
>>>           fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>>>                           args->operation);
>>>   -        if (!r)
>>> -            amdgpu_gem_update_bo_mapping(filp, bo_va,
>>> -                             args->operation,
>>> -                             args->vm_timeline_point,
>>> -                             fence, timeline_syncobj,
>>> -                             timeline_chain);
>>> +        if (syncobj_status || !timeline_syncobj) {
>>> +            dma_fence_put(fence);
>>> +            goto error;
>>> +        }
>> That should probably be something like this:
>>
>> if (timeline_syncobj)
>>      amdgpu_gem_update_bo_mapping(..);
>> else
>>      dma_fence_put(fence);
> Noted....
>
> Thanks,
> Arvind
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +        amdgpu_gem_update_bo_mapping(filp, bo_va,
>>> +                         args->operation,
>>> +                         args->vm_timeline_point,
>>> +                         fence, timeline_syncobj,
>>> +                         timeline_chain);
>>>       }
>>>     error:


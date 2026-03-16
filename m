Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64040EFCBD4
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 08:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0428F10E28E;
	Mon, 16 Mar 2026 08:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D/dun94I";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C265B10E28E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 08:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UANPROTroAAlD/xb2iZu6RtVZ6QO+/bzyTRUG7ygKL/gZDuq3XhlF7qrZYjGxv9NgUrY362ZBr0i29zLm8AGYcPQBMue7oUwQ/PB9sSOSVvsE3MF5DRiwazR1IPW7qp1sDhoqTF6gseIFIZ6KaF1vzH7yVkpLQu7tAipU0PAnKnn9pKHbtqCTqDgfJ6N1F6vEsAKcAPYWRGiYTOn1LLvF5Ffo8NKbBP77Gbctz98arbK1q7naOkvM3aMtptUG7D0AgP0mtT0nKx5o1pgN5U4wor/AxKwhpTUOd0HRnOj577uo6Y6gNvq4MhKX8Ahu83UOEdVBNiJPjqurDh3NPBEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OsFxHc7wJWICdJycqFlEBb2/a3ZmpqXZ4sE9uauFQw=;
 b=NepiDxv9mcFYD2JKAJh/VWhWt9TF0XI0ylXKomsrAqtZylg1ARiek8NZ2SsFOanSQ41dPQIJznPPD9XCazkP+S1ld3ZVeJSm9nW8pVQ7q/K9/b6IONd6730qKWHVSdTL4FA3cdLpVjD9MCsHDquBww8jIJxWrNv0IWgvZrkBSmQj2qiv62kU3WoE6rkDmm1eUpVGDnwnh1UeIMtXxY5m/Sb/TcpvIqH22DkIX68Nz9APgvMnSFasP4nD1Zaecdxi9Z8cYbM3I/alOQmPCR2BUu/zqwuPtTtJDgftxmUU2yImh8KRGK7Mp4KO5gpshmx+XVlWNpZ4E0al+vrdZFgoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OsFxHc7wJWICdJycqFlEBb2/a3ZmpqXZ4sE9uauFQw=;
 b=D/dun94IpcTTOLLm28RM+B0TAYM1ZuinS3OE5r4Gi7kAb4KzSl56XTwvI8DLJL7KfI9m71YsuzP+KZKK0a4IHmfNe6kox4KxEvXPDIdQxZiyv+y/w2kTVobAM/nJvrn3p9xGV35aga8kQPOTxNjZVSSsOW+FRfTE4EaGZON0I+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:22:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 08:22:23 +0000
Message-ID: <41627fc7-a0d8-44bf-982d-334f548d9f88@amd.com>
Date: Mon, 16 Mar 2026 09:22:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: oops/null pointer in 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
To: "Dr. David Alan Gilbert" <dave@treblig.org>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <abdVX_LJiNvkm4tW@gallifrey>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <abdVX_LJiNvkm4tW@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0938.namprd03.prod.outlook.com
 (2603:10b6:408:108::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: cb37f69a-6905-44df-a917-08de8335266b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: gO1WL6lGKx+up2Fn5NJdvouoFtmBTa1jMcuhzWGMRlzmOH9A8Rsdwy4MsSdAM0qad+lMEoTYiOUsjVEE/+Htvdp/1VkUxvYRx9kKrDcwfFXCiw8PkuOXD7XOoim8ZhXOxCC7ypobkLoTE4CHke+s5jorxgNtu+vwObgq7VUZZISwspXZJN+TVdC+wRlY+amxgeNlRbtBWlSGHFeoxx0PCLXLtQGvLFGtY1zYv2x5dETyg77QgNQvsAb9uCmDIUgtNn1Sc+K6pmxaFc45Y0TeeCOQ6RzOhtO9mtIUS16zvBvJPCaQTX/lgsUQnh46CUX5PWtSYFtg5u0XL3qkXYdZhvsruNwL2XtX/W3ZUUuVIpcUF4qawpN6CIY9M9tGKWsYtG12BxGGtjpRvb3IfX1eislaep6fasg9webeSZJjDvJz0Tnt1hDsGw7ULqW75mXOORHhzIP3yOn+2fz3svS45KsAvifTTNleAysnpyraVgGZj8jNCG6fjuJjvoLUz/byMI6vUj7++l/M8Se8xTrutWQEITs0IvTqBmGDOGD+Bw8qNYpKn1Su8nfvPepJtwynrlS9BIZ1VwByMswdijCeRAUf5LycsQwR7h956l3u8bA2MuKzj7mbs7RbY8IDGMrpZ8pj6Z2xd/cpF1S8Zo4gz43SIi/Ko9bWMXhBdpI9iAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVkzeEo5TWtKU2g4VVJlU2k5b3hsRzA1dlQ3VnlVdlg4VHNYcEFaWDlWM3dK?=
 =?utf-8?B?U09NYlBPVXRZZHhORmdJRlU0bkV1SXh0WnJSbTJ5YU5DdXJpMVgySFRrYjJn?=
 =?utf-8?B?djJQSUVpeCt1Z3Y4NGxRWGpPOHI1VXRxdWxMRVBPNGl6RG9MV0ZVMitIKzE2?=
 =?utf-8?B?NjBCckpRZnBQLzlpOE4xUjFHdjlFTHJyUG84NW5rZWRiaC9HOXN5UHBGYzVh?=
 =?utf-8?B?QjdWazhtUTlBcFAxczJEYlFnRkk2aGRMb3VZSk9jWXN5OUpyNUJ5SlZOVE1R?=
 =?utf-8?B?TVB3SlIzeTFXU2ZpaXZ0WUcyQi9Ib2V6bVl2bDdkaGM1NlJnM0VXMzhVTFJ4?=
 =?utf-8?B?SFpmNkErSFJ0VHVwTWo4Z1NSRGYzSHYxd3V1OVlDZ2JwSk5jSHBKZTdYeUtX?=
 =?utf-8?B?TDZxN1RNcVZWbG9DdDhjd2VtRUk3YklYWnVzVU5Gd2pJY1cwRjd0eFZNZXB3?=
 =?utf-8?B?cGRydzNxclpuYVJWMlpDTStjUEg5Z1ZjYjFwOGp5Z0J6VHhXaXN5MkhuMHI2?=
 =?utf-8?B?bmNEZHBna3BFUWNXNWtKWHNsNE1NQkxQajJUK0VhRUxWNFJZS0ZtclRIeUNX?=
 =?utf-8?B?L2dNUVNNSnFCd0t6VlBnUWw5R05iTnBZelJycjVaZVdoME5zVGlZVUh1MVFC?=
 =?utf-8?B?RXhpd0FRdyt3VWdOSGt6QkVPNWVMM01BcnBBQVE4a1NObnppTzI5YjdGSGhs?=
 =?utf-8?B?c0s1OXhVNDFRRHdJZ3o4TDljL2NJZE04aU9zSWNaTmlWQ2UzYnFnS2lVWlR6?=
 =?utf-8?B?TFJpQUQxYWtuWTZBem8zK3pZdGozUFNXVDFYbXpkNDR4bHJwenVsc0NmOG52?=
 =?utf-8?B?blF3K0NabVJKZHNzTGxOQWxFdmZrMzJnRjl6UXZBTW85N1loMnZUZVk4bExs?=
 =?utf-8?B?KzIzUTlRVU0rS2xQRHlvM2hnRW81YzMyTDlBaVV4Y3pRL1IvZ09Dem53TXhx?=
 =?utf-8?B?Umk3dzhkdk5oa2laTG45NlZGVGRWakdFQU1RTUNFR0RnM01hSUtVejZXTkRr?=
 =?utf-8?B?N0lud01tSndHeXhjU0lvdzRuczRvVkRzcUpFdVF6WmxwVVZTMk9ZdnlLNjhv?=
 =?utf-8?B?cW1vQ04veWY2NUdxWFJ3Z3RwaHd5M1NyTGp2WU9hYklqY2E0Rmd4Q3NVemRF?=
 =?utf-8?B?QzlKajNEWGJiVVY4aFpVWE5seUdqWnZDQVJ6MllVNVFuSkJmQ29sVCs5Y2Ir?=
 =?utf-8?B?Tm1tWHhMOEVXUUhlMkRRZXJkSkRIa01BS0gyK2tjWHdvR1hNTVRaZC9FZU9N?=
 =?utf-8?B?bURXV0JmVTJWTy81Q08waS9LeW1nVWVBOThIcW8wSFFVdmg5b2dJN3JIZ3Mw?=
 =?utf-8?B?M2gvTVUzVzBCVWZmelRhZGJQNTlsRlBDNW0wd0ZKbkt5aFBtS2lhZDhkZmh0?=
 =?utf-8?B?d3hRbTQrMWR2NjYyOG9ybGtyQUlncU1zSFBYaGU2eEhNRWx1eGVhZWg1U211?=
 =?utf-8?B?K2NnQnF4bExNTHd1NVRjVWZ3SzlBcWo4YmVBVjVVWXZXb3VEN0pManJwb3dz?=
 =?utf-8?B?NElVOG95Ri9acGVOTDJzVnJKUGl0bHFJRWtVT1VZSEpVOFkyVnFaWm1KVTlH?=
 =?utf-8?B?S3JvUUkxekRVTXNCYUZSRnJqUzZET1p6eE1rY2s2aWJJQjY3WHhaK041Y2Zk?=
 =?utf-8?B?ZUt5N3JVNmJKRWlrZ1ltb01NdlY1SDNwaEJuclR2SFNKQlZtUHVVemcvd2Y2?=
 =?utf-8?B?OERaaHJVQ0Z4bUdzUXA0MGVDcENvekxTYmsxQ0VscmlqWjJoMHNPSm9IY292?=
 =?utf-8?B?NC9NNWg0M0NDWHpzeGN5bEErOGYwMmRNZjliS1M2ZnpyUm9MWXhtK1AySGZO?=
 =?utf-8?B?NFAyd2VBY2diTTJVN3Qzc3BKWVE1OWFROU8wcXUrbFg5M1VjK2VnakN3RWVl?=
 =?utf-8?B?TjBHS05YcSsvZkZ1MGNDb3YzR3JRWVlZZm9qbW9GaFBzR1ZWTWFKcGJHMDlk?=
 =?utf-8?B?MXpCTkdpT0J3cEJIbGpOOWk2S01saDVXRjBUSEFYd2FwZ2gxUFNkYXNHbU03?=
 =?utf-8?B?TFhLTUYyVzhVWGw4ck1LWGdacFFVVGZyS3dUb0tUTkx6N1YycnNVcTZLd2t3?=
 =?utf-8?B?ZmVodDJyTkg0eW8vMjMzYitDYiswWkVKV283QTBqS1lwRkNDYTlteUlTSXJM?=
 =?utf-8?B?MVJLdzFqZmQvR1V2YWV4VGlkWmVITlhTT2ovT3BpNFhPa2ZzbjBWVGJCQ2NQ?=
 =?utf-8?B?b1B4WTFoR2RuNkMybExiK2xmQzdNakNRNm84SHo1SXhSdzR1czNYdnJMUzdB?=
 =?utf-8?B?QXMrY3V3akJPbzUwTWRpTW8wQktXeTFZZittd0Z3NmZIVHZiWW5rYk9lSDg4?=
 =?utf-8?Q?6a7udLo1MJb4t5H9Qx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb37f69a-6905-44df-a917-08de8335266b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:22:23.5803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHd1s0oci30lMPN4lUAZKIx95CJ06CyLTcBmTTyGdnp6mdrRQYIyqg/eMzkyfL0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

Hi,

On 3/16/26 01:57, Dr. David Alan Gilbert wrote:
> Hi,
>   I'm not sure if this is repeatable, but I landed with a null
> pointer during a GPU reset, so thought I should probably
> report it:
>    6.19.7-300.fc44.x86_64
> Mar 16 00:24:39 dalek kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
> Mar 16 00:24:39 dalek kernel: #PF: supervisor read access in kernel mode
> ....
> Mar 16 00:24:39 dalek kernel: Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
> Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
> 
> see full oops below;
> 
> 09:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X] (rev c7)
> AMD Ryzen 9 3950X
> 
> I suspect the timeout was real, and caused by a runaway llama, I forgot the
> flag to stop it trying to use the GPU for image encoding; but the null page
> seems unfortunate.  Impressively the audio still kept playing via it:
> 
> I have the devcoredump copied if it's of interest
> (Note for self: ~/amd.core-2026-03-16)


Can you open up a bug report for that and please provide what line of code amdgpu_device_gpu_recover.cold+0x244 decodes to.

Thanks,
Christian.

> 
> Dave
> 
> 
> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State
> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State Completed
> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] AMDGPU device coredump file has been created
> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] Check your /sys/class/drm/card1/device/devcoredump/data
> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: ring gfx timeout, signaled seq=1705630, emitted seq=1705633
> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu:  Process llama-mtmd-cli pid 299886 thread llama-mtmd-cli pid 299886
> Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset begin!. Source:  1
> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: failed to suspend display audio
> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Guilty job already signaled, skipping HW reset
> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset(1) succeeded!
> Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: [drm] device wedged, but recovered through reset
> Mar 16 00:24:34 dalek lightdm[40555]: ATTENTION: default value of option mesa_glthread overridden by environment.
> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State
> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State Completed
> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] AMDGPU device coredump file has been created
> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] Check your /sys/class/drm/card1/device/devcoredump/data
> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: ring gfx timeout, signaled seq=1705632, emitted seq=1705637
> Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset begin!. Source:  1
> Mar 16 00:24:38 dalek kernel: amdgpu 0000:09:00.0: amdgpu: failed to suspend display audio
> Mar 16 00:24:39 dalek kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
> Mar 16 00:24:39 dalek kernel: #PF: supervisor read access in kernel mode
> Mar 16 00:24:39 dalek kernel: #PF: error_code(0x0000) - not-present page
> Mar 16 00:24:39 dalek kernel: PGD 849708067 P4D 849708067 PUD 15d277067 PMD 0
> Mar 16 00:24:39 dalek kernel: Oops: Oops: 0000 [#1] SMP NOPTI
> Mar 16 00:24:39 dalek kernel: CPU: 7 UID: 0 PID: 298062 Comm: kworker/u128:2 Not tainted 6.19.7-300.fc44.x86_64 #1 PREEMPT(lazy)
> Mar 16 00:24:39 dalek kernel: Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X570 Pro4, BIOS P3.10 07/13/2020
> Mar 16 00:24:39 dalek kernel: Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
> Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
> Mar 16 00:24:39 dalek kernel: Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 47 30 48 d1 e8 89 c2 83 e2 01 75 2c 48 8b>
> Mar 16 00:24:39 dalek kernel: RSP: 0018:ffffcf349c553d20 EFLAGS: 00010246
> Mar 16 00:24:39 dalek kernel: RAX: 0000000000000000 RBX: ffffcf349c553da0 RCX: 0000000000000000
> Mar 16 00:24:39 dalek kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8bce4ecd4380
> Mar 16 00:24:39 dalek kernel: RBP: 0000000000000000 R08: 0000000010000020 R09: ffff8bc9c0400b68
> Mar 16 00:24:39 dalek kernel: R10: 0000000000000080 R11: ffffffffa16760a0 R12: ffff8bc9e9100000
> Mar 16 00:24:39 dalek kernel: R13: ffff8bca7ccab200 R14: 0000000000000000 R15: 0000000000000000
> Mar 16 00:24:39 dalek kernel: FS:  0000000000000000(0000) GS:ffff8bd90c066000(0000) knlGS:0000000000000000
> Mar 16 00:24:39 dalek kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018 CR3: 00000001c591f000 CR4: 0000000000350ef0
> Mar 16 00:24:39 dalek kernel: Call Trace:
> Mar 16 00:24:39 dalek kernel:  <TASK>
> Mar 16 00:24:39 dalek kernel:  amdgpu_device_gpu_recover.cold+0x244/0x2ec [amdgpu]
> Mar 16 00:24:39 dalek kernel:  amdgpu_job_timedout.cold+0x218/0x258 [amdgpu]
> Mar 16 00:24:39 dalek kernel:  ? srso_return_thunk+0x5/0x5f
> Mar 16 00:24:39 dalek kernel:  drm_sched_job_timedout+0x8b/0x190 [gpu_sched]
> Mar 16 00:24:39 dalek kernel:  ? srso_return_thunk+0x5/0x5f
> Mar 16 00:24:39 dalek kernel:  process_one_work+0x190/0x350
> Mar 16 00:24:39 dalek kernel:  worker_thread+0x18d/0x2f0
> Mar 16 00:24:39 dalek kernel:  ? __pfx_worker_thread+0x10/0x10
> Mar 16 00:24:39 dalek kernel:  kthread+0xfa/0x240
> Mar 16 00:24:39 dalek kernel:  ? finish_task_switch.isra.0+0x82/0x2a0
> Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
> Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
> Mar 16 00:24:39 dalek kernel:  ret_from_fork+0x130/0x1a0
> Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
> Mar 16 00:24:39 dalek kernel:  ret_from_fork_asm+0x1a/0x30
> Mar 16 00:24:39 dalek kernel:  </TASK>
> Mar 16 00:24:39 dalek kernel: Modules linked in: dm_crypt snd_seq_dummy snd_hrtimer nft_masq nft_reject_ipv4 act_csum cls_u32 sch_htb nf_nat_tftp nf_conntr>
> Mar 16 00:24:39 dalek kernel:  drm_panel_backlight_quirks gpu_sched drm_suballoc_helper video drm_buddy drm_display_helper nvme nvme_core cec ghash_clmulni>
> Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018
> Mar 16 00:24:39 dalek kernel: ---[ end trace 0000000000000000 ]---
> Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
> Mar 16 00:24:39 dalek kernel: Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 47 30 48 d1 e8 89 c2 83 e2 01 75 2c 48 8b>
> Mar 16 00:24:39 dalek kernel: RSP: 0018:ffffcf349c553d20 EFLAGS: 00010246
> Mar 16 00:24:39 dalek kernel: RAX: 0000000000000000 RBX: ffffcf349c553da0 RCX: 0000000000000000
> Mar 16 00:24:39 dalek kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8bce4ecd4380
> Mar 16 00:24:39 dalek kernel: RBP: 0000000000000000 R08: 0000000010000020 R09: ffff8bc9c0400b68
> Mar 16 00:24:39 dalek kernel: R10: 0000000000000080 R11: ffffffffa16760a0 R12: ffff8bc9e9100000
> Mar 16 00:24:39 dalek kernel: R13: ffff8bca7ccab200 R14: 0000000000000000 R15: 0000000000000000
> Mar 16 00:24:39 dalek kernel: FS:  0000000000000000(0000) GS:ffff8bd90c066000(0000) knlGS:0000000000000000
> Mar 16 00:24:39 dalek kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018 CR3: 00000001c591f000 CR4: 0000000000350ef0
> Mar 16 00:24:39 dalek kernel: note: kworker/u128:2[298062] exited with irqs disabled
> 
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/


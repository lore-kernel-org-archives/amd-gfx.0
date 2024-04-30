Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BD9C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 19:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E64112EAD;
	Tue, 30 Apr 2024 19:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1QpUfKQ+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AACD112EAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 19:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNXO6YkSLGg4ZpWi+UvencXxtPR6vnMqCFHO7UaJR+HHmvYTE0PhtDYVrpupUrcXiCrPuvhE3IIlDg1bqXQFrqFElh3joYJekZo8CMHByXZurXlzPm0tV8sjLgI5ThLfmVz/E8rAF037J1gzpZkJ85v8hGEuD71iPHhwK3Hut5AmDND9QoH6eOCs1aLJyx4LxeykQQlNfu3j6tGmnpsjFHZ2ZdiyCUHFiWjU3Jv8unzBFgyQDgKcEjoj4qtrRq71rivojpg96oZCRSXeTjXPP0+ZVuozcjap+4bs9x6pTZWfrqZr0YR7q4VxtRtG+drn4gthGKOOhnmm1yNLh795Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p81EfMcLxojg94liBUlb+xsMcu1xdBEbYOYdCAKvS3I=;
 b=XgMTF0Ch4rs3eT5IjQjjnjulS51SFGl2gPih7a/Da2JVpxKt11Uk2SBj6yEVkWCmta0IGm/MQGMDFQBayeTqOGsqh/bKnbUqj9CJnoAIB6aOmRQC4KBjFOFrgY6wWowlPLSDkKwrC8vyWic5YFhXaNoM0gobLQ8f9kSkFgg+myHhRrSElyBe6BtYdqMudC1Ai9XctXhMxTEOe1Y2SGQPxXrnHh1KEBlQBDWAKLuuCN7/l6LAul06xDAuxEeMmE5lWGq6JQ9dX+sFKnWvcVRzvRlD4RKmw1d76y53QawXWp7RdcManpYqCTJzPPCHbH3aTAn9ULsUhPs6uwmsH/ZX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p81EfMcLxojg94liBUlb+xsMcu1xdBEbYOYdCAKvS3I=;
 b=1QpUfKQ+Eq1oxKUUi/203VR6SBOHIeCABw6Vl+xOPOQmfoKV/aAyJUUUq3y0miA8/DNphhnve+0gJdC+ml05Bx9wapvIj7iq1WcvUd2lOFUZrFPJRpBhRKHn2HaWMnq/jJOLUlQt8RVr2HiTxt0Ji2u63lBFbzC+K8vuL0vktnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 19:56:20 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 19:56:19 +0000
Message-ID: <dc8d2bda-8c8b-4354-83fe-a897cc477312@amd.com>
Date: Tue, 30 Apr 2024 15:56:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Let VRAM allocations go to GTT domain on
 small APUs
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240430100816.1057712-1-Lang.Yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240430100816.1057712-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::24) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0974cc-5e3c-47e6-a990-08dc694f9a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjBucUJrOHMxYUJEOW9KU0t6WGJSb0VwdmtER1E1R2JHOXQrWm04RmsvNjht?=
 =?utf-8?B?eENxTVVFR2s3YmJqbG90MmR3YkVRZ0hDanRXK1BRRnhXMjdERERtcFgvSHAw?=
 =?utf-8?B?ei8wci9EOE9RVHAxVkFBOWNPUFdwdE41WFJ0bDk1WDJ5THlCY2plUnhsaDRG?=
 =?utf-8?B?SE9HbDlZaGdUZzZWVWwxdnZJOUIyNFB1bmtpQ2RWblMzaFl3dGJ0QU1iK0J1?=
 =?utf-8?B?UFZUQy91UUxSbWwyaUJYdDVJL3lEUmtFS0tkenBjaENhelloWVFwQ0JhZW1K?=
 =?utf-8?B?VFRtVFd5Q0FpaUhTUkw2cnFWZDd0TWQ0aHVIdzVvcDRqUkZkYmhIaEZ1TmQ3?=
 =?utf-8?B?aFJxU29icXl6Z1Fqa3kyN0ZRT3h6dExaTDNvRzNRcWhDOTBrL0FYMDIyMHVT?=
 =?utf-8?B?R1cxNmgzTjEyclAvUWtDWlREOUNTWURCZ3JkaHphRXBtRjhnUmRtb2JPN1Qy?=
 =?utf-8?B?MWhpQnF0blk3V1BjYVYzNHNpUXZNUE03Vi9ZdlRFMXJDcEtCU01aT1Npcjlh?=
 =?utf-8?B?bk9TaFJDMmxYaHJXSFRsNWZ2TFpTNjNLbkhHN2xVOTY2eHhheUtVSFVJVjd2?=
 =?utf-8?B?Vnk2dFAzVjNlSVZVYnppc3B6V1FuLzdRVW85UnN2a3ZndG1saDRWRHdRNHd6?=
 =?utf-8?B?VjdKMHhXNjFDOGFHYStzeWN1LzA5TGlLd0U5Z1oyTEZYRk50R3lOeC85SzZX?=
 =?utf-8?B?TmlZV1pEWFp0cm1iZzRndld0cW96NXRVWjFSWTVwWHJvZlRrTGRjYzFtdy96?=
 =?utf-8?B?Z25nS2VHQ2dmT0lEOTBBTnNVRGNJNnZFSXU4TFFCeW9kRS81SGg2enp3YXZm?=
 =?utf-8?B?SmlQKzhIdTVVNEFIYlc4K2J2MXNKSUJSc1lhdExaRlQwUWFQODhtb2hLZTNs?=
 =?utf-8?B?bGN4L0x1RkhIbFA3Vngza1kwMVl1bUhxa0dEMmZyaUtYV3RORmdjazJvU0lp?=
 =?utf-8?B?R2tId1RUWStVRTJDbUw2TUMzUWQ3cHNTUmQvb0FvRkoxcWtEbXU3NjgwU0Zm?=
 =?utf-8?B?ZnYwd3RDK0YzNEJSRWRvbzVHOXhVSnNTdStzd2N0NEZqZ2JYWFJ6eFlwRXFJ?=
 =?utf-8?B?cTcySHFyRU1TRlNONDRpZFNSTW95WmozU1VRa2ZBZlM5Z0R4akxyclhiamQ5?=
 =?utf-8?B?RGNLK1VpZ1dMbXlIbzNXeldkNUN1aFdrdHlNRmhxOGE5eStFY2QxVnRxemVT?=
 =?utf-8?B?NXBVNWlUUmpWZXlvcXZCTWVnVWhxTDNuZmVWQjZIckRnSW5QQVlDLzhjRFZQ?=
 =?utf-8?B?cEh5eGJxZHd6NDdKUXhxQWFibVU0SGhzSjY3L1BBMDZzbjBsdWRBbSt2b2FZ?=
 =?utf-8?B?YXJrWEZsc05GSldhYkFnczAzcWlIK0lWL3hQZmVQTERralhTWlpUa1EvSzdB?=
 =?utf-8?B?OHJEQjlKT3Jnd2ZBOGxhdXdaS1lUczFHTlQ3c2lwREN6LzIxdkhYbG04MGM3?=
 =?utf-8?B?YVBrRU1ubloxbHRvTkdtL2cvZlJ2ZTZmaUJTd09CS1BENVhQTHB1cm9wREtm?=
 =?utf-8?B?cGdOQjUvS1MrV1ZDNXdOeWgvQWxTcGQvTVZZYUkvcUJHbm1hUHVLZzk5UWFm?=
 =?utf-8?B?b3pGaHZxdWx5VGRqOEQ4dUVsSElnV3RmbDE1eTdTVnMxeW1GYVFFY2cxTU5s?=
 =?utf-8?B?UElTa0NZaVE4bytEM1hpMjVWbEJaa1dqRkhNNE9TdERSWGFPZk51b0xyS24r?=
 =?utf-8?B?eVVEU1lMdEZsYVVONXRkT0tURE5DUEVwZlU2ZnNZUWp4TGNRRUN1NVdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2pJSEZ0NVBaTVUySGZrS3FIWWlPQXVNdTBOcWpaa1BrckFmU0FhRHlpL3hH?=
 =?utf-8?B?OEl4VlJvdUFvWVAwenF3ZnNkdUhwNldSVjNYNThyWXJGM3d5Zk1Kalk0eDJr?=
 =?utf-8?B?S1JDRlNnL2NuajNOTzc3djU2ME03V0pFRG1QTHBKVFlGK3VCZTQ0bXNVT3RY?=
 =?utf-8?B?dDdFZjF6MVVjVnlwK2tVTDQ5SGU4Vkg3Um9SUk4rNmNEUlk0M0U2amlBTWNl?=
 =?utf-8?B?RHM3V0d5Q0d0YXNoMmQxRGY2MDN6S1hyZEhDOUdiaDJKeE9hZWo1Wk1oY0tF?=
 =?utf-8?B?T3Y4RHcvRjFqODBEUktSZlBiOFNyRzZ4MW8yZ2htcXdsaUlxdEpyZHY0M3BK?=
 =?utf-8?B?Zkx6WkFYVzhFempuS1JtTVpkQ05JeFkvRHhENXJkSTM0UTQyVTZoVW9UalI0?=
 =?utf-8?B?Rk12VDN4b0VjVEpXcUxGR25iVUhBOFJSWkFmKzhsZElpeE1qNmdlbGQ5Y3B4?=
 =?utf-8?B?Y0FOVUlOMDBUNzRZUk51bG5wWWRzNkVXcnAySTlaVzJjUXlQVXBQMUNpajA1?=
 =?utf-8?B?ZHZKZC9ZTmxiNS9TbHpuR2JxQ1RUTGxrVDNYSFNYSmMyc0lYUDg0Qlp1N01m?=
 =?utf-8?B?RzVNMzJZUjVTcXRRMjdKWHdHSkNPcXJ0WkQvc2Q5aXEzRFVxcVZRcFhUTkl6?=
 =?utf-8?B?anZ0VUZubGd3L1pTeHpBVFVaUkJYck1xVTFNaVhPM2FxWTJBZ0ltc1JTQnlo?=
 =?utf-8?B?aUo0cjBBeEFVclhNalhBeXIyYnUyaXpIaDFOUnpPd1EwSktHTzhXeWpnaXZo?=
 =?utf-8?B?Y2Rwa2l4ekNBcGhhTzRMV1YvdC9obHd3MHdJTHBLNFRTWFRYb1RuSkN0dmFk?=
 =?utf-8?B?b1NVUVUycHNLNG1HRkZsN2RCaVhWYlYwaE1GUGNpMFVncitpek43NWRWV2Vx?=
 =?utf-8?B?V1ZPdWNaTGZYUXlVNUpna3E5TWpIazVmQzdGSmJzeVAzeUtBOXJpeTh6eTRx?=
 =?utf-8?B?VWVFWUhaOEFzQXRPOUE1Qi9oQWdnWjVHK0E5eTV5VjFpbHpJamJXM1BxUmt2?=
 =?utf-8?B?OW4waXdNcmlPa1ZSa0FSK2REc1RNTDVQTlRMNW4vVGt5L0dabVFsdVN5T1dV?=
 =?utf-8?B?SFl3Qy9uai9ieWxBbzZJeEorRXlnRHR1cjdibWlCSUdEUk4xMU5meUh4amxy?=
 =?utf-8?B?b0NZdWhOZ0YwUWRoOWpERzRHNnUzSUNiWkQ3ZmF0VVVMZkZ6b1VRSW5PMVB2?=
 =?utf-8?B?QVZrMkk4b1NCNWVZTmVydzFzdnE5ZVZuMWNTU3YzTUVCb3N5ZU1xL0NvMGRy?=
 =?utf-8?B?eldsVTB3ajFPNmhFYmZuUzBpQ1ZZZHErVnlWSFdUMlpWNVIyaWpxbEM2enZO?=
 =?utf-8?B?RHVTSHppZFlWbmYwczNaMEdQWUIxUGJRQ1R6U1M0VGVkeE91V09EbjZpS1Np?=
 =?utf-8?B?bXhYWDkwRXFoNUVpbGxzM0tKVUx5cGo3RTJPcHpIUThKSVNNMXY5NHZlL3ZK?=
 =?utf-8?B?eEwrd1VoczZzSFpLMEdiUEF4alAwOWZwcCtFV3ljM2tPTnVtV0xxeHNkbml3?=
 =?utf-8?B?YXNENTh2UFRWVWIyZWFMaU1TRTRuaUQ0M0JYTGdsaytQOFhnTVVVYTNFV21r?=
 =?utf-8?B?SUFUYmtWbmhtVWJMUjdubXRtL0JmaWFlQm9UMTJqa1FQem1raDFKMWNFYVdL?=
 =?utf-8?B?VVpCdC9hSGpyVEpVLzJHajIvOS9yUm4xSGZkRlNCM1FaNS9TVnVtUEFoUWdr?=
 =?utf-8?B?aWdmWDhWY2ZuNjhGeXRZYTNyWHM4MUh3bll3VGNCbDgvZzlxMXlMRzlhdVlI?=
 =?utf-8?B?T0M1WkJaYnYyV3ZJSE1RNGpLVG1wcFpWaGxiOHl2K09IbmduTFhTT2JWRGwr?=
 =?utf-8?B?ZmVZS0w3djFzUnFCV3ZEVWZ5Mmt0dTRxejVRQXozSnlYVFFwdTJhSmpNcUhu?=
 =?utf-8?B?VGE2emE0cVJHcjNXbVZmTW9NQ0J6UkRzM0xYaHZ0WC9EY21uQ1dORTBOOWdP?=
 =?utf-8?B?SkV6SlV5WEp4THUzeWVSMUJIMHR4bmQ1WUVRelFLTmNjSzI3RXBUaWp4QkFo?=
 =?utf-8?B?bzdBc0xPU3hCV0l0VkNIUDlzT3g1cXhLNU5IcmRCU3FNVElkNEowQnNKSStw?=
 =?utf-8?B?d3BpZ05TdTJ5TlptN0taVlc1QUNMZUs2VEVlUUVNdlJQOGZMaVViVlVuQVda?=
 =?utf-8?Q?TO9bh18VyZraPJuqgoilZkOBJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0974cc-5e3c-47e6-a990-08dc694f9a8f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 19:56:19.7610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dv8cJyCeNSWg5H5+HHJtcwDcXjIN2uyXOzMCfLUQUGs35FzvJYvHXgH6lve/AqV0NM8ZKWP+fi6Ao4tQ4F6xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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


On 2024-04-30 6:08, Lang Yu wrote:
> Small APUs(i.e., consumer, embedded products) usually have a small
> carveout device memory which can't satisfy most compute workloads
> memory allocation requirements.
> 
> We can't even run a Basic MNIST Example with a default 512MB carveout.
> https://github.com/pytorch/examples/tree/main/mnist.
> Error Log when running mnist:
> "torch.cuda.OutOfMemoryError: HIP out of memory. Tried to allocate
> 84.00 MiB. GPU 0 has a total capacity of 512.00 MiB of which 0 bytes
> is free. Of the allocated memory 103.83 MiB is allocated by PyTorch,
> and 22.17 MiB is reserved by PyTorch but unallocated"
> 
> Though we can change BIOS settings to enlarge carveout size,
> which is inflexible and may bring complaint. On the other hand,
> the memory resource can't be effectively used between host and device.
> 
> The solution is MI300A approach, i.e., let VRAM allocations go to GTT.
> Then device and host can effectively share system memory.
> 
> v2: Report local_mem_size_private as 0. (Felix)
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 +++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 ++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  3 ++-
>   5 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7ba05f030dd1..e3738d417245 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -455,6 +455,9 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>   		else
>   			mem_info->local_mem_size_private =
>   					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
> +	} else if (adev->flags & AMD_IS_APU) {
> +		mem_info->local_mem_size_public = (ttm_tt_pages_limit() << PAGE_SHIFT);
> +		mem_info->local_mem_size_private = 0;
>   	} else {
>   		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
>   		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
> @@ -824,6 +827,8 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
>   		}
>   		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
>   		return ALIGN_DOWN(tmp, PAGE_SIZE);
> +	} else if (adev->flags & AMD_IS_APU) {
> +		return (ttm_tt_pages_limit() << PAGE_SHIFT);
>   	} else {
>   		return adev->gmc.real_vram_size;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4bdf59213384..5843c3d35cb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   			return -EINVAL;
>   
>   		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
> -		if (adev->gmc.is_app_apu) {
> +		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   			system_mem_needed = size;
>   			ttm_mem_needed = size;
>   		}
> @@ -232,7 +232,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		  "adev reference can't be null when vram is used");
>   	if (adev && xcp_id >= 0) {
>   		adev->kfd.vram_used[xcp_id] += vram_needed;
> -		adev->kfd.vram_used_aligned[xcp_id] += adev->gmc.is_app_apu ?
> +		adev->kfd.vram_used_aligned[xcp_id] +=
> +				(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
>   				vram_needed :
>   				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
>   	}
> @@ -260,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   
>   		if (adev) {
>   			adev->kfd.vram_used[xcp_id] -= size;
> -			if (adev->gmc.is_app_apu) {
> +			if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   				adev->kfd.vram_used_aligned[xcp_id] -= size;
>   				kfd_mem_limit.system_mem_used -= size;
>   				kfd_mem_limit.ttm_mem_used -= size;
> @@ -889,7 +890,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	 * if peer device has large BAR. In contrast, access over xGMI is
>   	 * allowed for both small and large BAR configurations of peer device
>   	 */
> -	if ((adev != bo_adev && !adev->gmc.is_app_apu) &&
> +	if ((adev != bo_adev && !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)) &&
>   	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
>   	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
>   	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
> @@ -1674,7 +1675,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>   		- atomic64_read(&adev->vram_pin_size)
>   		- reserved_for_pt;
>   
> -	if (adev->gmc.is_app_apu) {
> +	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   		system_mem_available = no_system_mem_limit ?
>   					kfd_mem_limit.max_system_mem_limit :
>   					kfd_mem_limit.max_system_mem_limit -
> @@ -1722,7 +1723,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
>   
> -		if (adev->gmc.is_app_apu) {
> +		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   			alloc_flags = 0;
> @@ -1973,7 +1974,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	if (size) {
>   		if (!is_imported &&
>   		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
> -		   (adev->gmc.is_app_apu &&
> +		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
>   		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
>   			*size = bo_size;
>   		else
> @@ -2395,8 +2396,9 @@ static int import_obj_create(struct amdgpu_device *adev,
>   	(*mem)->dmabuf = dma_buf;
>   	(*mem)->bo = bo;
>   	(*mem)->va = va;
> -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) && !adev->gmc.is_app_apu ?
> -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> +	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
> +			 !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
> +			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
>   
>   	(*mem)->mapped_to_gpu_memory = 0;
>   	(*mem)->process_info = avm->process_info;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 4bcfbeac48fb..4816fcb9803a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
>   		return -EINVAL;
>   
> -	if (adev->gmc.is_app_apu)
> +	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
>   		return 0;
>   
>   	pgmap = &kfddev->pgmap;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 386875e6eb96..069b81eeea03 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2619,7 +2619,8 @@ svm_range_best_restore_location(struct svm_range *prange,
>   		return -1;
>   	}
>   
> -	if (node->adev->gmc.is_app_apu)
> +	if (node->adev->gmc.is_app_apu ||
> +	    node->adev->flags & AMD_IS_APU)
>   		return 0;
>   
>   	if (prange->preferred_loc == gpuid ||
> @@ -3337,7 +3338,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>   		goto out;
>   	}
>   
> -	if (bo_node->adev->gmc.is_app_apu) {
> +	if (bo_node->adev->gmc.is_app_apu ||
> +	    bo_node->adev->flags & AMD_IS_APU) {
>   		best_loc = 0;
>   		goto out;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 026863a0abcd..9c37bd0567ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -201,7 +201,8 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>    * is initialized to not 0 when page migration register device memory.
>    */
>   #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
> -					(adev)->gmc.is_app_apu)
> +					(adev)->gmc.is_app_apu ||\
> +					((adev)->flags & AMD_IS_APU))
>   
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   

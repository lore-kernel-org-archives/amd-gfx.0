Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEED8C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 19:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61128113638;
	Tue, 23 Apr 2024 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rjDeGuPC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E613113637
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 19:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPQ++6gqlDWSrjgkDTLzbbI1p1QHmnwu4f69f3vWH63MLRl/vmzWQCLN5welJqtuidUQph/cRIMMUixomUAJGevnrwj+3wia695lVfKDHWUvz+q17/xrFKOIqQSiLqAAHh9/8TjsEHMvNHg5KJUxaxIGg6zg/A8NjjBkPtdO89BYvMkMuKjDdcCpCDKtpm+F7E+WJSQZ/KoxCpwK+nRMXYwY4Wj9oDOHntRgPlQgsU32nSj9nW4VsNBE6433f9ddrR8UeahyPUeNpRAfriN1oFHjvkkxYC3ucFEUmPcjB3354LBVuvjdrwp5xxQ8Fl5rzMT+C74MCzRjGrjfgy5XvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeP17EWqePkmepMyjsPJAPoC3e2BrUZSGUszz9HKJNg=;
 b=RFdNraomUsT4/4EgwlYCSf+ImiF9PF04rBPOrBgrUtdrpX6SG89b3XvhaePlPqCrHmy0stUz5P9E0aZfta3IJ0in3DIltw5fQBwSli92Mow0D9qO0jdoqGyqGHMuiTavCFoY/rK/l8ePsi4vwze43Ovq++tS/xLJY37PesfzP0KyfGoXU+hixLLO97AZ20UCx6Jcj1s/OA7MlRSmDUGtCOiHHUQzmihpEXNNNwk4PESb87zwoTKNyitkSQCuriuLdWDreh+I+L/eDjlIGG0hXK3UzDi9K70Vzut8CuzsJw8NUKNKyptf2HbNzMW/+t1ZyyHN/AcgJQHpGwSAMvGgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeP17EWqePkmepMyjsPJAPoC3e2BrUZSGUszz9HKJNg=;
 b=rjDeGuPCnL75KAA9BEEHZ7tSMK808spT1cV42UQ+33PAB2GBNtTzMVIqwyNVs3fxVU9xNR5nuUrT4nbLQQqMIkiZN0rOTbyAaNpTJTH82KBUrXSwpW+jElGsA8oOUYxuhOEsi0W2UT5buiznrJZ2YLNYffKvAl243oXWtIlMnVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:51:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:51:52 +0000
Message-ID: <7539d78e-fa56-4896-a089-6c4a0b8f795e@amd.com>
Date: Tue, 23 Apr 2024 15:51:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
 reserve_bo_and_cond_vms
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>
References: <20240422091001.254640-1-Lang.Yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240422091001.254640-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: b7613c2c-af99-49c1-df0b-08dc63ced286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUE2dlg4RWM5SXdwQU1hSGVzZnAzdmNCcm04L3ZEc29XYkw4aG1YN2NTRDFs?=
 =?utf-8?B?ZzdmZFJsQXRORm0vUSs2SUFmQmdDWXNOS1ZpT1NZRUxuU2Q5WUpUTm9BZC9D?=
 =?utf-8?B?bTBJclJpeUJMKzAwa05oVEVkWHlFTll4bVpnRkM2c1FIeWNUZDZKWWJ2TnQ1?=
 =?utf-8?B?ZUQycUpOVkZReGhKbURldWtDdFBScnZjN0NMbE9jRzFTSk52cDd5SGdGLzBn?=
 =?utf-8?B?MGJyWEJRU1E3THJIZ3A4ZXpYcWxFZ3RhTVR6amw2NExGYlVVd2JyT3ptOFBk?=
 =?utf-8?B?Y3hacElmbWxZMHA5aUg2T2RNWlcwenl2bUk1bCtYV1dpV1Zsc0l5TmNUQytr?=
 =?utf-8?B?QkZXeEd3aU84czg0dTBWSWhMS2dvYXlzcFRFbWl0bnBTS2QzY0g5UXIvMU9M?=
 =?utf-8?B?bjJCRGdEcWg1NmhtT3lCZDY4MzRiVDVFTCtEdjJlbTJtUEVycjBYMEpvN1RT?=
 =?utf-8?B?SzIxK0VVeVczbldMOUtaRWJORlVpdTlQQ1VDRExnSVV2Z3ArSXNua2cxaE9X?=
 =?utf-8?B?R3UzMHRRbnJ1Ty9maTJkelhMRnBaYWdvOXVkQlVOL21HRk0wOUhnNWdJNTk4?=
 =?utf-8?B?NzJhOXpYZmxqeUpmRVlqRUpCamlCTnNpdkgrejdSSmZGeHNGVUVPK1MwMXpK?=
 =?utf-8?B?ZHllQi9kb3NOTjdxUXFRejgwTFJNdFM4emdBSjFlZUIwdWFtUXAxUnZid2hs?=
 =?utf-8?B?azdXVnVjQzNidE9qY0tBZ1UyWlEvb2ZyTFJpd3MyZDFKRDFycno4T3FzOFJW?=
 =?utf-8?B?WDVIbE9iYlU0SS8xdDVsRm8veFNzTGNSQUNtUU9TQk9aOVhuZmJQek1SM1RG?=
 =?utf-8?B?WmladDVpYjFjdHBQTmQrL0xoWGhDNGZBTk5Janc5VVE5VXhsd3VQK2ZpSjlS?=
 =?utf-8?B?QWlDOVhrMjF2dWR4MFB3cnFxY3MzYUYwcGIrQWE4OWlneWFCZkdsQmRJWGxD?=
 =?utf-8?B?cDhDZTROV3RsNnZDR0s0aVZra3BNYXdRQ2xnSGVvajJZWUlZNnJVSFhDOWdq?=
 =?utf-8?B?ODNqU2tibVZkdHkwN3JmeU0xbHUwVy9aeHRubXcrZjJJSzRkUEJsTWZDdTBp?=
 =?utf-8?B?VHdtaWRYSTVQMmpDMERFNHVuOWs1aEZVaE1pQzRwQ25qNHhGME83Zm5hWUJH?=
 =?utf-8?B?bTY5NkRSNUVYTGVhd0NIMThYR2tra2hRam1UQWEraEd4NWFaZk9Va1dzV1pz?=
 =?utf-8?B?SGplbzVjeFBlSHc1TWVRbjZFNVl3dy9HdExtVE5PUzRSYytMK0ZSMGZUQjdG?=
 =?utf-8?B?eFRIcGJkMDlSazBCNnpWQWNHbS8xQ1hOYWhTeTVsQ1YwRlJWTzNwWmE2UXZh?=
 =?utf-8?B?cVFtdDh3SkdpS2RmOUdSOXBadDRwQlZtRXgxTmZBVURXTnNkVVlTa0piMUtu?=
 =?utf-8?B?aGxzNXo1SEZYaExWSVFZOVY4UW5EeTBTbTdVWmJxcEZkM0ZVdVQwbUdNQ2tl?=
 =?utf-8?B?YUxaeHl0MGRyZGUvTlZIdDVjbi90MVJDUmozU1RPQm1Ed1h0VHB3UDFVTlht?=
 =?utf-8?B?ekRzWkYwTlVoQW5wV1R5bFdUdjJ4VnJROVpLdkRadEZCU040Y3h3b3FJOXhE?=
 =?utf-8?B?MDFKeEZ6TFFvSzlOZUVxVklWcndmbHAvcHpaVHVWL0VjNjUzZnp3cmhLaGh1?=
 =?utf-8?B?d3dJbllPMk1RdGczQkV2VkdaMVdWQk4reDhIamRJMnRHYWJCeVJGaFNRSDA4?=
 =?utf-8?B?K0VqSmlFbmY5eXpjcTQzK0dzTDUzVlRyVTNJdXErUkpDYTkyQVhxU25RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFgvUFU3eGswdDd0UU1wVmU0UDFnTE1wUVh1bmMwME40TUZYR0V3N2g1YS81?=
 =?utf-8?B?R3BPWkc2VXowT0U5bEpxV3YvZFA2T3VWcHp1c3UwcDkyYW9VcTFacWdxY2t4?=
 =?utf-8?B?Z0pkRGs0V2srSktwWDdock9EeXdxSTZYVk9JaUY4aEFMbTlBaEhqVW9Qa0Fq?=
 =?utf-8?B?bHR1d1ovRFFVcnBreTJaVjROTmJ4b3R2L3ZYWktmeFJMcVBhcWFpRFFZa0Uz?=
 =?utf-8?B?NDZ0WFgxbFliUzI0SFhGQXZQR2JHcncrUlZXZlZWR3EraG91WWNPL25rY0gv?=
 =?utf-8?B?WjZLUi8ySTNvVkhSWGV1dnBLa1QyR1doZENmY2pNOVF3TzBIT2xZM28xMVIv?=
 =?utf-8?B?NGZQWnEwelhVejBYaE5YU0JwckhNQXBqZ1RkbHdTaGJxL1FnRWM3VmpMd2lx?=
 =?utf-8?B?ejBBUThUbWtLd3ZmUUQ5d0kxWEVKNXhSVFBieXhlblplbVRXKzRkbnl1Uk94?=
 =?utf-8?B?TzZuMHd5R0dGU3FkaU9NVk9pUm5DRXB4UDBWTUZaNWt2TGF1dktvU1d5Q0RN?=
 =?utf-8?B?UnRrMkZkTk90ZnBNNEN4NWo3MVpMMWhPbFFXcUF2cUVFcGREa1hmK1Q0Y3la?=
 =?utf-8?B?SUdaUGxJMXd2QURYQ2YxQk8yNU9MQldqQUY3VTJDQ0IwdjBkVzBUcDI1Q3pk?=
 =?utf-8?B?THo3dDlYS1BoMFJqN29XNzl6R2FudU00amZiQ0pZY3VQNFM3bTdqYnlzd3V6?=
 =?utf-8?B?dlpENUJDbk9xWWhMY1d3ck1uaFZzM052cllGdlVNRTdIdFZNcCtvTi9CVGpK?=
 =?utf-8?B?b25GZ1VNbEd6Y2lkWnZCQ0oxdTRsRDNNTEZsSGU5dFE5bWFlM3M4L1lxenZh?=
 =?utf-8?B?cFNwdmk4MXhQWVQreEkxUGxaTjZScWpCSWI4NjFQNGpDaGh5OFYvYzk4bkpj?=
 =?utf-8?B?bzN2UVNoMmthZTFnYXptVWRnYWdicE9OZldSK3dqSDlaeEpBQ2JIc0FFZnc2?=
 =?utf-8?B?TGhLUm5TOXY4SkJ0MkpPOFpNK2JYRlN1OUtmemJCTFZmb25IWk1mR3U2Y1px?=
 =?utf-8?B?ZUs1V1FRUEdsT0pVaU9XRUFrVUNjQ1V4N05MdjNtYUM3b3dOSCsyV0tpRFZv?=
 =?utf-8?B?MUw5S2xLTmJhU3lJZXhhYUc4RFlRbGJlUkFYbFg3REVPLy9RTmY5MjgySHJJ?=
 =?utf-8?B?T2ZkWmZaQUo4VEV5bmVrc0JiWW1rNStjK3l2bGVOSE1xTmJnRk1CQ3Jld2kv?=
 =?utf-8?B?dUl5MmFwL3pCbGhRbGw3N0lXYzlJcGRPWHR6VGx1MGZSNlA2RkxiWjVQNFVH?=
 =?utf-8?B?aUVoNTh5YjVLS1BUQUVacll3NEpBVHo5RWQ4QjlVUnF1M2h1Zmw1NmNkSG5q?=
 =?utf-8?B?RzdEZmRlTndoclBJeVJWbmNwUmQ4TjRVdWdpc2UzRmpEVk5kM1VIVkw3SjJG?=
 =?utf-8?B?TFZobHBua2liWXdyaGIxSEJWcllRQ1ZrdW9Tck5Nbk5EUzBQWGppbHNkWmFy?=
 =?utf-8?B?cExsNkxUOTVjK1I4cEVaaHNJWjZGWkhVS2xuZkN5akl3SEoxOXZiRlJiemRC?=
 =?utf-8?B?RkY2WTdHMFpNem9PQklXNWFjdk03U3BUL3ZTYnJKUFRrcWxRSWtXQU0rWXFw?=
 =?utf-8?B?a05CZ2NjY2prcGlKZ2FaMWFSVXBLY2JKbkQrTk5TSFNVclhnbzVkQjVoK1Zi?=
 =?utf-8?B?cFpPOVl0cThkU2srVExBVGgwcTd4SkRXaHhaU3JHM2RzaVZHb0xWNzlJeVRJ?=
 =?utf-8?B?RjdUS2JuZnhKT01kS2VFMlhHblI0VXRJM01YSWZCMzlmMFRNVVptZmx1RjdT?=
 =?utf-8?B?TnVLemNOVlU5OUJTeWhQVVRxUnFhZHdqMFM4dVFiQ0VWc0RZbDJFOFk2cmlX?=
 =?utf-8?B?K2k3ZllaZ3ovU3YzVmhpRHd1K3ZpdEptVXUwek5GSTdVeW03WGxWQjA3bjMr?=
 =?utf-8?B?V0NNUXRhcGFWMUtyRDdhajZXdGtXZklJU3RzY1pkT2xNRUUzWHE2cnNJeTZM?=
 =?utf-8?B?cm9sZmh2akZYdzVVWVAxZDF0NlZJYkp6ZFZWTW5OZlpna20wRUszOC90WEJY?=
 =?utf-8?B?aFo4ZTFkMExzYnkwdHhqRVZYeUdYTjQrZEhCU3A3MGFxeXN2S2E3UURZN1ZG?=
 =?utf-8?B?V21nNGhrUjQxaWpXdWNKZWJ3cFppV2s3MkdvODJMci9WLzVVdUdhTWV2UzFv?=
 =?utf-8?Q?szV5GL/xVwmEls+wbR2BSTbJM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7613c2c-af99-49c1-df0b-08dc63ced286
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:51:52.7433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWrDswgWFOz7DIgPCjnRCSaEVmwI5WKxKIWD3TxyVs/E6iXSDfAPX5XJbrtJgWXy4YNi7I+JyvABFAyRcCcW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
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


On 2024-04-22 05:10, Lang Yu wrote:
> Observed on gfx8 ASIC when KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
> Two attachments use the same VM, root PD would be locked twice.
>
> [   57.910418] Call Trace:
> [   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
> [   57.793820]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
> [   57.793923]  ? idr_get_next_ul+0xbe/0x100
> [   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
> [   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
> [   57.794141]  ? process_scheduled_works+0x29c/0x580
> [   57.794147]  process_scheduled_works+0x303/0x580
> [   57.794157]  ? __pfx_worker_thread+0x10/0x10
> [   57.794160]  worker_thread+0x1a2/0x370
> [   57.794165]  ? __pfx_worker_thread+0x10/0x10
> [   57.794167]  kthread+0x11b/0x150
> [   57.794172]  ? __pfx_kthread+0x10/0x10
> [   57.794177]  ret_from_fork+0x3d/0x60
> [   57.794181]  ? __pfx_kthread+0x10/0x10
> [   57.794184]  ret_from_fork_asm+0x1b/0x30
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 101a2836480d..c4aaf9c394e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1188,7 +1188,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
>   	int ret;
>   
>   	ctx->sync = &mem->sync;
> -	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> +	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +		      DRM_EXEC_IGNORE_DUPLICATES);
>   	drm_exec_until_all_locked(&ctx->exec) {
>   		ctx->n_vms = 0;
>   		list_for_each_entry(entry, &mem->attachments, list) {

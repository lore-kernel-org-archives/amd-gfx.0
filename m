Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD960C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B2110E35C;
	Mon, 21 Sep 2026 07:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gcuQqVuh";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1A410E35C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmtdz343nHoOCNpvN/GskO2XH6BilkrlmrvIUwoSmDJZb6/qQhrQy8pQMKae826m2qx5dYs6T+TIHOHfFuiwTd1wkpf84NudcVG3ODpOl27Jo8cH0NLdsCOVKPQBrWnJPSXJbIejRzGvPEbIrBvUtePlyzC/ROtNjDp9gtZmt+N41nEfcJzRVVsCgjiAsWJ6iXMkJ8rICwiTxookqfKE7opGzmC7UYhCvCM8x4Nt7wcmqebOwmDnFILslTihKQr/eY9gfFkq+CIwv6GFdist9+3KfpYc4LvhqCAen097NagOcZuG5D45cqDptZOAwd8eivDqyHe7PxFO1W+mMGRcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KEFMns9+ptuqJYweChcqycNN3hYjsX1BwbpHWPFgkU=;
 b=W0ageT720sHU2JlRcPm3d81kfKOYTlGGQSJ5AhZ+68Km3rWPdikWLjce/h7Vq+MWnwY0nmRlMPhhDIAoYrOEZGEXHdsyI4rcIDvsx5315BiZsFR5KvJG3M/Yd08hIkTHNCP+XpCFHcNUvDVDSxfJXfoM3/KZ+gT82SsWNy1NRcDsFE9snM+QR0264NuiLU3Y//VIisDTFbOp4CQA/3PHFC1/535zutIK4+HhnZbhw34AhCpojHvQnlzQG1lH+tcGREKr4z6s3+vJin6nK5mLkBsjnNs2aVfxqGdnJYDydFV/A7Bd4Z1D0w1fJ8+7Bf9Q6hwjUK1KLzyQ+JH7WBubcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KEFMns9+ptuqJYweChcqycNN3hYjsX1BwbpHWPFgkU=;
 b=gcuQqVuhAR8kEu7CHsvXvX/NhawQc1WSKteIgLEzo+QHo5lSi/T+S7UrywjY6wAzj5OvT1pbebmalziDLeLdfLkFVtD50PZhLO9WplePK4mJj/6oFUE6Fsnx/h1SfIG3a93C1q8os+77/z9bpA2x1o3CABZHUXpB0AWHAt+ga/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by AT6PR12MB717548.namprd12.prod.outlook.com (2603:10b6:170:10f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:43:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 07:43:26 +0000
Message-ID: <abfd8179-4385-4ac1-8d28-aa3e33589062@amd.com>
Date: Mon, 21 Sep 2026 09:43:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Add second-level trap handler
 infrastructure
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Samuel Pitoiset <hakzsam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-2-srinivasan.shanmugam@amd.com>
 <f7edaea8-f172-4573-952f-6a85d1302d8f@amd.com>
 <e25c9ad5-a211-44d5-9b71-9e403dfb7426@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e25c9ad5-a211-44d5-9b71-9e403dfb7426@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|AT6PR12MB717548:EE_
X-MS-Office365-Filtering-Correlation-Id: 066c158d-e824-46cc-4ae1-08df17b40565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|3023799007|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 2pvJANtc3ZdBVOJkr25CeT4HO9OOmrF2D2NUEw16ciL19Z3ExsSEHN8gy39vRWWNfvaYu+NSTbJpEe7d9o+TRb2fqQvO5z+aCa85cszbmf7GzmHnmUVb6Id1zc2fTNSUtgzIScjGAi3MhDWDccSwYyRswzv4Dekk8I8RUgJwVehiMQWVyx5r1y6ZaN6KhIcZnvDp76nemVndzlhXeyiQrOc9wZdnyfnGalVNVpYBNXn/mqVODspLIpvLcKLJlU2RLggGZkdRUAYH3Jn9jouSEcOSYl0kqSsbNlTSR+gNVJHsoS4MnChrqnfLdRTIvNjWyw0acZ6XvAUPJ8h/SiOzsGzA0ZKwNC8D27bAlSEKQIpnGRiFqX7QAwUaDkQ4im3X6ZMd4P0umfnYOIbmhH2f60g4vml4z+tTRoF+DjIR2t/QxjCuuSk+khBclP3I/kUrclOtrxoDU289W0+Vo8s/VL9LBY1nCe8xVKlTvZorvzssOd0XfaGUckJmYMbXt1aC5DZtbqwo4jjRqoSqlWW58PTwUXlDEwzX2Po9Lhk9rD4OPIJLWCy5flRzgCgBZkBMERRhQ80LHrxUomFzsARahdwdD4+3Cb3TgGYAvZl3bwWqYpFcEqXHvKwbz4fe2tXFrcgrT/KdXalq4YANwU6xPGI0J7JkDWAWQLpJ3awwKIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjd5eGgyVSsvVm9IQ0k3UlJJT2QvUmpXNE4wNVZCblp5dkhtdS9mZXRvaUJm?=
 =?utf-8?B?UHQzWkd5U1djMk11amo4WVdYTGpsbGI4eEd0S2hncmdiVXR4UUhGcUtISVk4?=
 =?utf-8?B?TUt0ZFJJY0c2ci9qeGtmaFgrelE0RWp3eGUxMHVqbWErMktPenFZeGVxa1JE?=
 =?utf-8?B?eG40MURYamVsWm1YbDNRbjVST2Yzb2ZQUWV1alZjTmZVQ0dQcm96UHhma3l2?=
 =?utf-8?B?RlBpQXdhSUpNcE9maUNTSzRXN0tIUkpGSVEvY0VjamFCS1kyN29NdG1jM2tE?=
 =?utf-8?B?QWxMc1dWSkg0YWg0THFyZitJcFNHSUNpNENmWktRRHREeFFQakVPQjhYdzha?=
 =?utf-8?B?dDROVGtpekpJeUN2Z0xadXBuT1c5M2ZCUTJyQWtYcEtBeElGOWRjTmRpZml5?=
 =?utf-8?B?SVZBUUhnZjkxYXdESjRnV1ZTNC9rK1IxaXBHSHF3ZXp0WlBVR080T0kvQWlO?=
 =?utf-8?B?YnE2dEl0OEZCaHZ2WXJDWUwwUzlFSkJhN1A2dGpaUWtZdU5TTmhxWHdUN0JH?=
 =?utf-8?B?MUp4MXN6Y3ZSaWtTWUxkbE5vN2ZWYUZZUHUrL1pnaU11cXNyMW5yM29ZaUZL?=
 =?utf-8?B?ajJOYzRSWGtQblUxNTM2WlIvQm9Nbko3Z0QyR0J6c1hyQTNwNWtzV0ZKS0Nk?=
 =?utf-8?B?czJOdXRCZGU2dVgzZVpZMmZwMlZ6UVFJbm5MTklEVDNzb0RQTnJJQk1NUXh3?=
 =?utf-8?B?bWZhVEJkNWwvdVVlM0Vka2QxTGdvMFdsRWR5NllaenZvQnFNa05tUjZzV1h1?=
 =?utf-8?B?dWV6YzZGamoya1ovVzhsU2lGK1l4WHNiQzZKZW53bmFaTi9iT0RnQkFPWEtT?=
 =?utf-8?B?bDA4YWJSYlpVcXFVZG85enNYOHNmMHRhNXBsMjJNZGhYUENOVFF6a0ZiZHhw?=
 =?utf-8?B?azc5TUJuV3pFWG5jY1Z2SEowYUpQWFU1MW43aDZVMEk2L3dxWkRRY2llR1VI?=
 =?utf-8?B?NDltQ2ExNk1aaGVFR2RUTVdZQ2hOcjd0bEM3VXRweVNncm9tWE9CK013ZEg5?=
 =?utf-8?B?R2dKSXhja1g3TCtjMnRBZ3ZpZVBqK0h1cWdKcFpueThEbG93dGF0Yk00SVdw?=
 =?utf-8?B?b1c0UDhWbXlvQzRFRDhKZzN6Vi83STdUQjlPVmhHRHBKcllTdzN6cXp4SmV2?=
 =?utf-8?B?Tm94WFB4MFUvSjI0SEdSTTVEY1Q2WnRBUWorUmNsd2RIazVxNkZ0c1VOYzFi?=
 =?utf-8?B?Q2JEQ1lCdTVwNEF0TEZqclR6Q0V0T054YXFTR21jTThrbjRQT2pFMWlWRWVQ?=
 =?utf-8?B?VndUdG5RaHBiOWdwVVVibzVNeVFDb0VXUE41WUtKOW9HSzZBT1NaYTB2QWZ0?=
 =?utf-8?B?Zm5nSmZFNldhb2dQSldmczlsS0d6NmttUTBDWGxrS2JoWjhKL1E5VEdpYVU5?=
 =?utf-8?B?R1NUd21vK1ZsRDRVZHc2Y1crc1BOdkVjSWxvWUZXQnZONWVJblBwTTB0MVV4?=
 =?utf-8?B?dUZDWTlMYjRZTzFRVlIyWWJrcHYxL21yeStGOFpmRlMwSUJFRmVCVGw1K0N1?=
 =?utf-8?B?YUd4REJ5elZqdDhTU2NwR3hsdnB3bW9QM3dtSG44RXdXb3RyN0VsVVM5WGJ3?=
 =?utf-8?B?b3E3anNuQXhpZFJ5a0szaEErN0o4ZlNLZUphN0Nva1hrdGNWaEcxaDRwQWUy?=
 =?utf-8?B?aENTaHpyYlVDNUZBU240VWNYdmdqeEJEZDhsMHVNbHVpUHozYUZ6c3Njai94?=
 =?utf-8?B?TGhrcC96b01UTTJzdzBPRS9ORDk5TFVINEFDL2c5K1dhU3V1UFNHczRaTjIy?=
 =?utf-8?B?YWYvSFRkOXVZdkhxWGdDNHh4Q2tDQ1RId2gxekltNmJPY0hwLzJ6dG9qR213?=
 =?utf-8?B?em1PREJiNTRWTU13WTZHeGRDaTJtdTBXQURiR3E5L3NzSlZLV0xzd09XQ0t0?=
 =?utf-8?B?Y0VEcGgzMWRnSVJxN1dvMFNEekg2NlpZNWI3YXZxRmNDcUtiQ01BWW5nYSti?=
 =?utf-8?B?Q09aSlYxaFRRcGhOaitsNEtjSUZ4N2YwT3NVOVp1Zm9KcHZMZmxodW9XN2VF?=
 =?utf-8?B?YkhBRHlQMGNpTHNtZHJpelhMNkUyUnJHZ08rT2doQS9ic2h4T0tWNGppTkov?=
 =?utf-8?B?R25zZy9CdE1WSXFuQytOa3FDM09tOWlxMSt3Qjg4YnZZeHpyRmNnOHcvNWc0?=
 =?utf-8?B?c3c3M3VmQWVBcjJ0SDUvWGFqcFJKVjFhSy9MVnNNaWI0bFE5dWRRNmY1US8x?=
 =?utf-8?B?WUtTQ3hmSUlFejlmVm9kMlNtRlc1bTgvSzRNYStkc3VJY28rR2ZUODJuNHV2?=
 =?utf-8?B?Nk16aFpCdjZrYjdIYnQvTG1yeDNtOTNpQ2hwQm94TEMyYUd1bVdCL0lGaThR?=
 =?utf-8?Q?zRH2XXQzxFVWb1EvPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066c158d-e824-46cc-4ae1-08df17b40565
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:43:26.3483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1Az/jK7nXJ2mt5MfKki7t5OoeTxuxh4gVXtTeGPnnjszx6Hp6aFpRHUq8JrgNsa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB717548
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

On 9/18/26 05:43, SRINIVASAN SHANMUGAM wrote:
> 
> On 9/16/2026 8:14 PM, Christian König wrote:
>> Hi Srini,
>>
>> please keep Timur, Natalie and Samuel on CC.
>>
>> On 9/16/26 07:37, Srinivasan Shanmugam wrote:
>>> Render-node user queues had no mechanism to install a userspace
>>> second-level trap handler equivalent to what KFD provides for compute.
>>>
>>> On dGPUs the CWSR TMA buffer is placed in VRAM and accessed via MMIO
>>> (PCI BAR). Raw CPU pointer dereferences are unsafe on platforms that
>>> lack full load/store support for MMIO. Replace void *tma_cpu_addr with
>>> struct iosys_map tma_map and use iosys_map_wr() for all TMA writes.
>>>
>>> Writing TBA and TMA as two separate stores creates a race where a
>>> trapping wave can observe a mismatched pair. For user queues, evict all
>>> queues and flush the GPU TLB before writing, then restore queues after.
>>> For kernel queues, wait for the VM to be idle via amdgpu_vm_wait_idle()
>>> before eviction and the descriptor write.
>>>
>>> Evict user queues in amdgpu_trap_free() at file close. Without eviction
>>> a freed TMA BO can be accessed via a stale TBA, causing a GPU page
>>> fault.
>>>
>>> Export amdgpu_userq_restore_all() for immediate queue restore after
>>> SET/CLEAR without waiting for the eviction fence.
>>>
>>> Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr().
>>> SET_L2_TRAP returns -EINVAL if TBA or TMA BO does not have this flag.
>> Works for me, Timur/Natalie/Samuel any objections to that?
>>
>>> The old TRAP ioctl and its internal handler are removed. The new
>>> SET/CLEAR path is exposed via the VM ioctl in a later patch.
>>>
>>> SET_L2_TRAP is per-VM (per-process). Each process has its own TMA buffer
>>> allocated in amdgpu_trap_alloc(). There is no conflict between processes
>>> on user queue VMIDs.
>>>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 ++++++++++++++++------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>>>  include/uapi/drm/amdgpu_drm.h             |   2 -
>>>  7 files changed, 285 insertions(+), 91 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index a93ee106ab92..6473faf18d71 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>>  	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>>>  	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>  	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> -	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
>>>  	/* KMS */
>>>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 47e4680db797..559c9222fc48 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>  	}
>>>  
>>>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>> -	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>>> +	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
>>>  
>>>  	if (pasid)
>>>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> index 31f653ec3fb1..3313bc099cf4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> @@ -19,12 +19,23 @@
>>>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   */
>>> +#include <linux/iosys-map.h>
>>> +#include <drm/ttm/ttm_bo.h>
>>> +
>>>  #include <drm/drm_exec.h>
>>>  
>>>  #include "amdgpu.h"
>>> +#include "amdgpu_gmc.h"
>>> +#include "amdgpu_userq.h"
>>> +#include "amdgpu_vm.h"
>>>  #include "cwsr_trap_handler.h"
>>>  #include "amdgpu_trap.h"
>>>  
>>> +/* First-level TMA layout shared with second-level trap handler ABI */
>>> +#define AMDGPU_TRAP_L2_TBA_INDEX	0
>>> +#define AMDGPU_TRAP_L2_TMA_INDEX	1
>>> +#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
>>> +
>>>  extern int cwsr_enable;
>>>  
>>>  #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>>> @@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  	struct amdgpu_trap_obj *cwsr;
>>>  	struct amdgpu_bo *bo;
>>>  	struct drm_exec exec;
>>> +	void *cpu_addr;
>>>  	int r;
>>>  
>>>  	if (!amdgpu_trap_is_enabled(adev))
>>> @@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  
>>>  	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
>>>  				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
>>> -				    &cwsr->tma_cpu_addr);
>>> +				    &cpu_addr);
>>>  	if (r)
>>>  		goto err;
>>>  
>>> +	/*
>>> +	 * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
>>> +	 * may be placed in VRAM and accessed via MMIO (PCI BAR). Check
>>> +	 * TTM_BO_MAP_IOMEM_MASK to select the correct write accessor.
>>> +	 */
>>> +	if (cwsr->tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>> +		iosys_map_set_vaddr_iomem(&cwsr->tma_map,
>>> +					  (void __iomem *)cpu_addr);
>>> +	else
>>> +		iosys_map_set_vaddr(&cwsr->tma_map, cpu_addr);
>>> +
>> Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need an iosys_map.
> 
> Hi Christian,
> 
> Thanks. One clarification regarding using |ttm_bo_vmap()| here.
> 
> The per-VM TMA BO is unpinned and can be moved/evicted. Currently |amdgpu_bo_move_notify()| calls |amdgpu_bo_kunmap()|, so the existing |amdgpu_bo_kmap()| mapping is dropped before a move.
> 
> If we replace it with |ttm_bo_vmap()| and keep the returned |iosys_map| in the trap object, should we also handle unmapping/remapping it across BO moves, or would you prefer mapping it only around the TMA accesses?

I already answered that on team but repeating here for everyone on CC: Please map the buffer only temporary while update the values.

The background is that keeping the mapping alive for the trap handler is a really complex task and for temporary mapping it you just need to validate it once.

Regards,
Christian.

> 
> Thanks,
> Srini
> 
> 


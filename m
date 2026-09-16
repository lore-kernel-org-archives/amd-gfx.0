Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA05C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FF210E53E;
	Wed, 16 Sep 2026 15:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dB6fQoDu";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F03E10E53E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3EGdcup2a/XfCezGGJfXOIUxQ/zPzJ2HMK71TSA91cAlezd0EG/YeccO0iVeD1jPEc+yURre1zfV5tHHih/JAikx1qtigrtbkxKwxLdN9Kv0q8MdwraJt4M2p5kDehh4kO2lb+TJHCGypBIoxjMKQegQN719Iv8u7PzZ4AJq3KGf6sYjvmleKRPOaFVKRYeFiPacPklqIbFfW78W/AK34DqfP8V6B6pl1k7K0qy5/CO/qP9m3zqWSAAEzHQ9J/e2sglATkM2XO8utaX9a8TD8N0oZWbV2aoiA46QzXnyTFo03MAZ8Y3xh3nYfHHD6XnB03k310v5f+zp3J4+1cBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqDkOqreM0O0RogaLVPkKA/6TGnsBK1bfmdsvPFAsjA=;
 b=YwcPT2BlPD+V47Rhj1CUYy7a2pb7ekPXoEvs9lYgRSfXYRQtaT2lZErqs1NJDD+lE0ESvRZez4f56RGZW8csfJIPPidUhwJiE/IU5kcz21QN7KBJg9ZfN1JJDED+yGmHofBXZUHNFkJzf8LsuKRu1hYTAdjd3TVh7rUl7KsKbDUu473YRtvFNUuhtnHSRBSzkDxX2ZnIJ4wl7JN2MuAgRv2tb1X6GSov0UFA3c6A/Tqtm0Whrm1XDtT+e7y5N0W5gTKFyKrSRhzCEBYP7hI1iwzCw2PBJzfiisO85Pi5MlJGEWLuZSa1s6wZbwkEsKX4QiBgxlycYmFQ/S8STuHJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqDkOqreM0O0RogaLVPkKA/6TGnsBK1bfmdsvPFAsjA=;
 b=dB6fQoDuijKPt0BPfLhEa1dMdraJQQB3wcavzn/LfFWZwDRLYGGCyMMr7g20/4YbZ8J+2FcWsSbV/S/FQsF5FHT0k02DOT6fmuyWnWxDJWlYaTRyqfSGbfj2b6dVyI03x+PNAyG989CJuXXpOfJFOE+4oteUDke39XgFn4e6Ma4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Wed, 16 Sep
 2026 15:40:05 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 15:40:01 +0000
Message-ID: <1e6af7f4-2c3e-4960-923e-94854391c591@amd.com>
Date: Wed, 16 Sep 2026 21:09:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Add second-level trap handler
 infrastructure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Samuel Pitoiset <hakzsam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-2-srinivasan.shanmugam@amd.com>
 <f7edaea8-f172-4573-952f-6a85d1302d8f@amd.com>
 <55354752-5ef6-44ad-bf31-95503aeefde1@amd.com>
 <e1fcff74-3f93-4e79-93ff-1a9097057cd5@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <e1fcff74-3f93-4e79-93ff-1a9097057cd5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6d1edc-f1cc-4926-fb6e-08df1408c4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|5023799004|4143699003|6133799003|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QCktTE1mvAPJzpcVShjVZDAgF8mvmfcB1moN4Q9diZGBK6C1tgjt7Dxe9eTO6fI671UkpZNn6/+MI0nwiJxL9aWdGuUaRfe2KJSwQ06RenRUcQRyAYrs0kY05iwAipxwXdXPa94io8rSd3/Jy3eE3u2AorDy0Yls9EhqFz5WPn9KYgTKL4kBt6Ji5+NiN4FDWZvulDSl8Uan9BLh6uAGGyp5mHQhP2aJvdNsrnLRvhvYF5L+pHuLrDyJr6l5a0oZZoDp7puDuQzJsYFHHYuD+jGjchudJuxHwwnoOagmvy1MMqzuu6rD/C3CokdRR4nuLIFH5T8UnpB3jaiILIiDiCpaze66l3Bd/w23ROoSNzQWSFhHywbyaFb7nNyRJ1iSUO4skdIbc+EB+biGlZGXalaMRJ1lDIXshmxAlnEnQKRdsLU5ydyMm3COlsu3Zgm4UbmlM4omwOiV48arctQOEWTKrLOA/OPH6drsY4WYasr1PvR8EpqOXKuXoylcKKlyOMk9O9tvKYIJfx0HSy1HiYVfijOsq1xT13wwd8jN91sp7xVTXE1kDAcw9WIobV2zSqmlbWXQ2BolMGDXcsSIKy0vFdOLHEgHbBPMxgJU6MePiL6zt3gZb78WZ0fRA2oXCSIzFVhTjtqqoqfWcvThD5GNfFuDrYnbSF2ypFAzKYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(3023799007)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkQwTkoxUmdEQ0Z2a3ZtR1Z6ZVdtcDRxRktvaC95OWcvRURCMi8zUzBZbFcr?=
 =?utf-8?B?YTl1Q0MxdmdKbVZRMXl4RkQ0cjdwSVhkWmJQMkhuQndYUkJOdHpDR3pKK1BF?=
 =?utf-8?B?Y3JaeEo2eWMwTThJWXY0RUJUaXprVEZaNTZQQlluMlJHaXI5bS95dURLZG1D?=
 =?utf-8?B?UmpGL0JtRk44UURaSlRYaGphdHh3Qmw3TW8zQTMvYi8zOUZSRzJocGtPYlpM?=
 =?utf-8?B?SE9DRytJbUxsNU5vTWdzMmV6SStDVEYxdExhbWZCU0FxT0kwRWQ5VkRJd09u?=
 =?utf-8?B?U3UvejhDWXBYd3VpcjY3ME1NcGlwZHhqYXU4NCtZSGVBRGo1b3JxNkIzMEJa?=
 =?utf-8?B?SEhWUHFsaWEwcFBTSzdWbmM2dXd2TXU1S3lJczllWmE5cHgxS2I3d0FHMWpF?=
 =?utf-8?B?TUhmMGpmL09mTndDeFh0akM5bmRFRDBoSzhkc1E2MFQ0MVZXTXlsY0hZOGN1?=
 =?utf-8?B?SDJlYWlJR3Q3YWNwUXVzNmwraDRld1VGSEVVdW1zWUV6azJwWkk2RWFFaitS?=
 =?utf-8?B?U0N1SjlsdnZNQ1IzQndBQVV1cW9qNnJ5RjZNN2p6anZWdlNQS2hvalo2NlNN?=
 =?utf-8?B?WTNiUlErUU9oam51Ymo2WGRoeUFGTVVnNnFEeEM2Z3dtalYxY3NRZVNMTEE5?=
 =?utf-8?B?bVZDNDNVd2Z4VExrTXZPSjUzNHFQeFgyYlVFQVNhTzltSmxSeGhyK2xnYVVO?=
 =?utf-8?B?UHVJOTc5Mkg1SFc3Unp4K09PVUZveGJOQ2MrYWZsbzRGdVF4czRtbithZDUy?=
 =?utf-8?B?L080TkY4U01zcUd2b2ZxWlB2N1VCN2JLQzN0aTNWeVJ2clhzVzNoM2xCamh3?=
 =?utf-8?B?UjRVbmE4RHJ4QmRON3RpNEhybWZUdU02dk5iMG5vV2pweHdlVUdEdDlnV1p3?=
 =?utf-8?B?dUZQTGxEZnBqTVR2M3dTRnI3V2hjUmdXSDF3TmxzVUtXZC84SG9aaHdJcjA5?=
 =?utf-8?B?S01SNFBpUTQrSGhHL0V4N1BxeitFSmZ6ZlVMS3FpUU9ldU56R1FicWFEZGRF?=
 =?utf-8?B?ZVFHK1ZVYytGVGE0KzBFanRENjU1THZ1SklFTmJNOFM4UjlXS1MyYUlzV2Mv?=
 =?utf-8?B?SlpaOFlaMmZFUmZXdTNJV3VWRkpJZ3lBZzIwb0hoWmd5RWhHeWtqY0g5THN0?=
 =?utf-8?B?WHVZYmpLYVpRUFc2WExNRmtNcytmczRnSWlVT1JoNGR3VG9tajc4eElsdUdm?=
 =?utf-8?B?cXFldGZNWWlNNkZJcXdjUk1uZmFuR05kbWM0ZXc3dkljMkt1RzdleVgyOFRX?=
 =?utf-8?B?a3UvTzZZYWNTeG9HZGlUT0NOUnZjSlN6UEx6alFJWEN3VHBWRGR5VEF4eHc3?=
 =?utf-8?B?bFVVSWM5MnpSQXA3VFRPbzJNcnVPMTlOWUg1THNqVHBKTENYdjZ4T3pYU3pW?=
 =?utf-8?B?eUd5MWZFVXgyb3h2REt4NituVWN6M2x6RXRnZVQyMWFFazRNSlE4S3Y4UG1t?=
 =?utf-8?B?dzQvVFh4YXNibnBYd1I5ekdhNFV1QlhCVWZuVy9VbmlNQmZoL3dmNnRuUG1j?=
 =?utf-8?B?cnVUNDRRemg2MWtwTXRjWjRUWFV4T1FFWnlCa3dLQjlGZnovSkZzTHkvNE9E?=
 =?utf-8?B?aDVkMUlObUsyVHUzYmJsZUhGVjZCd21wbHhXbTA5c01pYSswM05acUpFMlpM?=
 =?utf-8?B?WE5FTDRoMUpiOHZWa0IyQm5wUUI4RHVEeHRtd29KcHBEZ2NDNW1ZekhJbU5s?=
 =?utf-8?B?Z3JKWlhhaDdVTHJKeC83U1FPWmxFZVlrVi9SSHovS25ER25aVlJ6MFJlUElH?=
 =?utf-8?B?R1dDeTNwZEhLYXFYOHlWRTdna0hta2JYOGlDelJObFNqR0l5TDAyQU9PV0tj?=
 =?utf-8?B?elFoZklIb0dTR1NITDVVc3dWUDRDWCtFbGJ0UWRzZ1ZkbXF6a0QzNGpqYkVK?=
 =?utf-8?B?L0JYdTFUVllxRy8xUmlXZHRoRUpBeXRxcUNWR00wTHBLdGg2SGhrOHVIeDQy?=
 =?utf-8?B?ZHZhdzhhd01VVDlCNDJYbkxBUFVlbU45dU03QmZIOHFMTC9yRTFxMGJQWXdl?=
 =?utf-8?B?R285UUpvNDhkWnptMGdMeFJ2Wmh0U2JObHJyWnJXajAvanY2RGpub28wd1pX?=
 =?utf-8?B?M2NnUDEwZnFselFiY0FzelQzYmRqUStGcEZsanR5eFV6MWRFV1hEeXhoYm0r?=
 =?utf-8?B?eEZaZnpZVkFPRkhKZk5ST2RVWWl2d2d3bGRncjZoWkJQbVJ3bkFsRDdPOEFU?=
 =?utf-8?B?Y2xhSmdxMEV4VVUzQjlGdmZQNUVLcWZ4WG5qUlFkQVZReU43YjJWc2U2amRm?=
 =?utf-8?B?ZFdMcGhEUXNUNjJoRURzM05UNHVJOEloTStLdTlvdGtoaEZUa1ZDNGdqVmhG?=
 =?utf-8?Q?szwMuVzZxfjJIr+5Cb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6d1edc-f1cc-4926-fb6e-08df1408c4b7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:40:01.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXu7yfEptMQe6hjH6bUj3pl8oEr9FNKAeVlIw1qBhfCcsxutfu48dnW2uB5mXl4GVQcZMHefnZ166/f8qOdBHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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


On 9/16/2026 8:54 PM, Christian König wrote:
>
> On 9/16/26 17:10, SRINIVASAN SHANMUGAM wrote:
>> On 9/16/2026 8:14 PM, Christian König wrote:
>>> Hi Srini,
>>>
>>> please keep Timur, Natalie and Samuel on CC.
>>>
>>> On 9/16/26 07:37, Srinivasan Shanmugam wrote:
>>>> Render-node user queues had no mechanism to install a userspace
>>>> second-level trap handler equivalent to what KFD provides for compute.
>>>>
>>>> On dGPUs the CWSR TMA buffer is placed in VRAM and accessed via MMIO
>>>> (PCI BAR). Raw CPU pointer dereferences are unsafe on platforms that
>>>> lack full load/store support for MMIO. Replace void *tma_cpu_addr with
>>>> struct iosys_map tma_map and use iosys_map_wr() for all TMA writes.
>>>>
>>>> Writing TBA and TMA as two separate stores creates a race where a
>>>> trapping wave can observe a mismatched pair. For user queues, evict all
>>>> queues and flush the GPU TLB before writing, then restore queues after.
>>>> For kernel queues, wait for the VM to be idle via amdgpu_vm_wait_idle()
>>>> before eviction and the descriptor write.
>>>>
>>>> Evict user queues in amdgpu_trap_free() at file close. Without eviction
>>>> a freed TMA BO can be accessed via a stale TBA, causing a GPU page
>>>> fault.
>>>>
>>>> Export amdgpu_userq_restore_all() for immediate queue restore after
>>>> SET/CLEAR without waiting for the eviction fence.
>>>>
>>>> Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr().
>>>> SET_L2_TRAP returns -EINVAL if TBA or TMA BO does not have this flag.
>>> Works for me, Timur/Natalie/Samuel any objections to that?
>>>
>>>> The old TRAP ioctl and its internal handler are removed. The new
>>>> SET/CLEAR path is exposed via the VM ioctl in a later patch.
>>>>
>>>> SET_L2_TRAP is per-VM (per-process). Each process has its own TMA buffer
>>>> allocated in amdgpu_trap_alloc(). There is no conflict between processes
>>>> on user queue VMIDs.
>>>>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 ++++++++++++++++------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>>>>    include/uapi/drm/amdgpu_drm.h             |   2 -
>>>>    7 files changed, 285 insertions(+), 91 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index a93ee106ab92..6473faf18d71 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> -    DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
>>>>        /* KMS */
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index 47e4680db797..559c9222fc48 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>>        }
>>>>          amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>>> -    amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>>>> +    amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
>>>>          if (pasid)
>>>>            amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> index 31f653ec3fb1..3313bc099cf4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>> @@ -19,12 +19,23 @@
>>>>     * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>>     * OTHER DEALINGS IN THE SOFTWARE.
>>>>     */
>>>> +#include <linux/iosys-map.h>
>>>> +#include <drm/ttm/ttm_bo.h>
>>>> +
>>>>    #include <drm/drm_exec.h>
>>>>      #include "amdgpu.h"
>>>> +#include "amdgpu_gmc.h"
>>>> +#include "amdgpu_userq.h"
>>>> +#include "amdgpu_vm.h"
>>>>    #include "cwsr_trap_handler.h"
>>>>    #include "amdgpu_trap.h"
>>>>    +/* First-level TMA layout shared with second-level trap handler ABI */
>>>> +#define AMDGPU_TRAP_L2_TBA_INDEX    0
>>>> +#define AMDGPU_TRAP_L2_TMA_INDEX    1
>>>> +#define AMDGPU_TRAP_DEBUG_FLAG_INDEX    2
>>>> +
>>>>    extern int cwsr_enable;
>>>>      #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>>>> @@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>        struct amdgpu_trap_obj *cwsr;
>>>>        struct amdgpu_bo *bo;
>>>>        struct drm_exec exec;
>>>> +    void *cpu_addr;
>>>>        int r;
>>>>          if (!amdgpu_trap_is_enabled(adev))
>>>> @@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>          r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
>>>>                        AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
>>>> -                    &cwsr->tma_cpu_addr);
>>>> +                    &cpu_addr);
>>>>        if (r)
>>>>            goto err;
>>>>    +    /*
>>>> +     * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
>>>> +     * may be placed in VRAM and accessed via MMIO (PCI BAR). Check
>>>> +     * TTM_BO_MAP_IOMEM_MASK to select the correct write accessor.
>>>> +     */
>>>> +    if (cwsr->tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>> +        iosys_map_set_vaddr_iomem(&cwsr->tma_map,
>>>> +                      (void __iomem *)cpu_addr);
>>>> +    else
>>>> +        iosys_map_set_vaddr(&cwsr->tma_map, cpu_addr);
>>>> +
>>> Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need an iosys_map.
>>>
>>>
>>>
>>>>        r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>>>>        if (r)
>>>>            goto err;
>>>> @@ -433,6 +456,29 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>        return r;
>>>>    }
>>>>    +void amdgpu_trap_clear_l2_handler(struct amdgpu_vm *vm,
>>>> +                  struct amdgpu_trap_obj *trap_obj)
>>>> +{
>>>> +    if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
>>>> +        return;
>>>> +
>>>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>> +
>>>> +    /*
>>>> +     * Zero TBA first to disable dispatch before clearing TMA.
>>>> +     */
>>>> +    iosys_map_wr(&trap_obj->tma_map,
>>>> +             AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, 0);
>>>> +    dma_wmb();
>>>> +    iosys_map_wr(&trap_obj->tma_map,
>>>> +             AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64), u64, 0);
>>> It's most likely a good idea to grab the reset lock around all iosys_map_wr() as well.
>>
>> Thanks Christian. May I kno pls, do you mean taking the existing reset-domain lock around the complete TMA descriptor update (all iosys_map_wr() calls and the final barrier), or only around each individual write?
> One read side lock around all iosys_map_wr() calls and the barrier should be sufficient.

Thanks Christian, understood. I'll use one read-side reset lock around 
all the iosys_map_wr() calls and the barrier.

Srini

>
> The problem is that during a reset you can't access VRAM for a moment without crashing the system.
>
> So we need to avoid writing to VRAM at the same time as a GPU reset is ongoing.
>
> Regards,
> Christian.

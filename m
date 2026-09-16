Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5111CC982C4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C3C10E27B;
	Wed, 16 Sep 2026 15:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gkB7+6JT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2E810E27B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7/xiOLMzfWVNlu4ANoBcI3f4zigVhSMD9xHZ6F1/0bCDF9fryIVCSqqtQQYSFxOdfE9Ox8/SaJ54LJFWSe5PGd1Y1unf3xbvmHehvl72ufwJRrTEzVst2M7dgjXuFBVUsn6Zlyzf8kMa+oquwk7KvRagE+4HPxm0jcihtC3JGH7qRBaA2Sen9KBHQ+qj0WFCRMX6xaJeKL9EF7C9u4QtWXRe7l++Og7YiQlZb1nHzgJ0JPgnZyV38XMePM4rAWby9hX79pzVLS8Rx2GA1ufQfP2TgYyo5zatAw2Dx+MRIAGQdO7yAnzW7Z6Cwuc45Mznohx/726/HVcxH3QDSG2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YicCD6hU2fnmh1nW6Grw36qtIfqn5Z719soSIrKWS4Y=;
 b=vn3MBzjgvNQnHgwDdPhQ4a4/4u4VArq/HESKNgE+RvZK6J1nmoQwR3wEZyaSGfJKDNemjR4+EIwLmVng8zWtxtqcv8PgQzL4qdlj89MBihgpCl1SJpNXFL4bDAsddLKl1+lClE36xPuBAKrVkM6foBvs/uevmW+5c82D68urLAKWanrKJiD+Lq66m1oz9KPS2JNLmVBOSNnSU+lCCN8utv/M0rlry4qQKd6EeHrZ/4oZe4PBLEf84c0ggegHDpLdyh2XMm9VvG08nWvQsvjYYST4reDMoSOM9JfxK+rE3xzvW22g87hOEehOtB2H+/gNQj3T5BTV7T1Ntrkc09nsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YicCD6hU2fnmh1nW6Grw36qtIfqn5Z719soSIrKWS4Y=;
 b=gkB7+6JTYty42nzCgnduQRD0bmWsCB9DoxcoozoZZZ41KZO8AykCGd+wmVlKkVIRyt8RXtKzt8AVsIrnL0LDzsZYOA4vrrT/TEeJGh03RAt33p1/6TGUCLr/pravanb8bgMosSEb05wUjfqzBcNDxd52WYU4q9Pir7GxKrLedK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:24:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 15:24:25 +0000
Message-ID: <e1fcff74-3f93-4e79-93ff-1a9097057cd5@amd.com>
Date: Wed, 16 Sep 2026 17:24:20 +0200
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
 <55354752-5ef6-44ad-bf31-95503aeefde1@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <55354752-5ef6-44ad-bf31-95503aeefde1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0246.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e549afe-1944-4fe7-19a2-08df14069707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|3023799007|6133799003|56012099006|4143699003|11063799006|5023799004|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: jDyP0AHg8ecFfyoioUgmm8y8BBAlbfjmuwT8cyyoOURhFlxkclBkhtztGeGzQo/rFhPQxDfnRMCk0cwhX0SfkiC6cV5JybzrZ3KwIOlXOW0MpGHFAJ7FYA3X65AjJjeL5OgbPO7pD5wrBhYEW89UW548lyWMZ/I6LV/7vlnawpXCUvNCWDpDl5qPlUBkWCknQkqfNhmQgorZvfp7F4Bh6PL/riYgGn9OrkDLH30EhGnLI+Wl8h6diYbq8UgVczOwQiJm94JvM7np1ras3nK2mU5CI063Q6hHhfQueWqQKsQ1B0Zy9m7zMFCIEPFEDouHVSf0NSjELbB/2NXIH5AOM1XKjacS+8jKA02zlwwFxCsQhf9KZiOCAdophejXNGr9CfDod+7OAgI5wj7S8A3ufUpCM1MiLph7dX/xHrWMAUfGgoSGv8qrQVI9G27nxuxiRUzq898wSDZijCv1MssHsmQYHRPSp9zyNN8iKACe0lTahvBVWMpupftAmMzxaA+YidD6w81Ovc4fRkOBmEESBJJriqmyzZhsBIWIW++iYOWApz2/TCXwHWxcfLRsqjyREEI3Bj8kOycTEJ68ou5oym/lTVxBQ3XrfrWrevVTv6+vSmanQHEyjsAOt48lVydD2Y7BzRmEn3YkDLmlK/1b5L1yBVZazJhnkN0lwNeHWkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(6133799003)(56012099006)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFjRWk1cGhpM3hDZ1V0c2lINW9KanlEVWdaajZCclN2R3BSeVYxNTVLbWcv?=
 =?utf-8?B?L3FLS0lPMnhiSFhiT0FaeE9aQ0cxNG1USmY2SVNQUVEyVys0N3Z4WUdSRXhx?=
 =?utf-8?B?TXk1ZDBWNWQ0SUs2WlRlSzhqOG9rRmhYSEEyOXNlT0ZQQ0wzcE9zUjZiekU1?=
 =?utf-8?B?bW1vMTgyNHdjV0owTytnU1p4VWtlYjJTVVVNVUhucndVTXM4dGFaOUJLdDhl?=
 =?utf-8?B?ellQOXZ2dlMyNkh6UlRrRUNCN1NxbmhnRkYxWGVHK1JhZkV6OUhzOWNsNHRF?=
 =?utf-8?B?bDFKL3Z0Z3FJZWJmUDhoQU55U01Kb0RJblZtcSsyQ2pGcmVFSHZiMjVzMzlT?=
 =?utf-8?B?S3BaTkZVZlFXR3VuR2dnTDNCUVhxeWZCb3RhelRuSUFXNVVWS2RTMVprcmtV?=
 =?utf-8?B?bHhTZ0RqMUhWM2lJVC8ydUpRRlA5aXVLUFNITkRpSTZYc1BlWGxWMjd4N1ZY?=
 =?utf-8?B?cE5vSUNueXNzMjR6R2pKS0NsZW56enRFZjZkaC82Y0FIT2Zwc0l3eDBmNGFy?=
 =?utf-8?B?ejJzdCt4Q2VjVjZzY1c5SitpYnh1N3dLeXJaTnNkWnFIOXlrOUxMRTJRZ29B?=
 =?utf-8?B?aURwUjBJTjdEajJYRHVmc2tZR2Zhalo1bTAwUlpoMmlSL003VFczV0R5eDM4?=
 =?utf-8?B?WHlIWDdoU3hCc2Fmb285cjVOK2k1VHg1UWJwOGpJZWpKWExBQlQvMVpSdzZO?=
 =?utf-8?B?WEpZTFJLdGVUS0o4Y1FKUHhlS2pGUjVHWkREMnZReW93YmprZjNwdTN1aXN3?=
 =?utf-8?B?Rm14UVE1UmVzRlFtdjFrWkpRbmhkNk5XWGtSMGdMNldlM1gyaStFV2dXOGxw?=
 =?utf-8?B?VnhZMjBoMDZZTU9lWDRuaTY3TktxNG5iSVhhM1BPaHp5MjZYUk9VZG5Uc3F5?=
 =?utf-8?B?c0IrM1dPcmFWSC9TOGxIbmZidkJHQms4NXBFbEh1OW1iYlJOTC82WjRPOTBK?=
 =?utf-8?B?YmJrWlAvdTh3MjRkajZyemo1WlUyUjdlSmRnSUdRZmlvQXc5emtNK1RLWFJt?=
 =?utf-8?B?QnVUOVBCSHFaVjdlN0FEWlJJb3dVSFhEMmxzY2Q1Y1htZzlZNE04c05mWlBq?=
 =?utf-8?B?NTJ3S1p4ZUErZ1R4U3JXeFhYdENhbkg5SDY4RjNkMGxUVVZ3eEIrVEJCM1Zl?=
 =?utf-8?B?cWdUWU1laHpXNnZIRWMyaHpnV1AxZklDMkloWUZMc3FXMy9CWVFnVjdLNXVU?=
 =?utf-8?B?SmZPRGwrOUkxeVJYYXdiSTNPSUx0YkRrUGJpNU82eE1Pa1oweDR0SnpMMFNn?=
 =?utf-8?B?dTJ6Um16QmxCbVNmSE12MkswTFFoMWExSlFtUEowUWZTYzZtWFhaRk9INm1I?=
 =?utf-8?B?Zy81TFBzL25GMEtTWWtsSC9ULzRDdUY4MFNHc2YzdzViblJxZG5TM3ZpSFhT?=
 =?utf-8?B?WWh4VVRGT1F1c2N1QXhBNzQxSGpOL0pMTGxPM0IxWENlUEErKzZGTnlueTE1?=
 =?utf-8?B?cjdLNXA4R2F3Zm5yY0o1Zlg4VWN3K0xIZTlEenp3dithWGlrazVWYmlGSGFC?=
 =?utf-8?B?RExOOHhSaUZXWHkxN0YrU0xBQ3dLQ3dxeWpGQ2x6MytiaGZicEVlek1icHI3?=
 =?utf-8?B?VXFFVW45QkNCQzcwaXlLSjRCeFB5dDhQMy9uS2g4bEZRNGlNY3BKaVNXZ3gv?=
 =?utf-8?B?NkZ0YVZpcUpxelIvTG9CUnFKSXV6ak05Vk5HTnlYRVJmNnM4ZTNrQXJWTUVC?=
 =?utf-8?B?SzdpWC9MSkJXQUxhdnJEdHlZT1hGQ01vL2dpOVJUaFoxWmdpMmNsRlFNNWpC?=
 =?utf-8?B?N29iVjc5bXVYQWxzODRValFPaHIreGJTbTBTYm1tL2krUTlwZzg3bEl3UTdQ?=
 =?utf-8?B?aEdJMjFtdHE3ajhPM0N3dE9JbEZvN3Y2em11RnMwY0RqRUQ4VUVGRjQ3eTBS?=
 =?utf-8?B?akhZT2cyNEU0eGQxM0dsL1BlMUJwY3ZJTVR3L0RkT05WZ2RtMVFFU1B3b3ZP?=
 =?utf-8?B?ay9NVzhsQVFuNE1nM0ZXaU5sU3VEb1BjVXc3ZDczS1dleHd6YjF5ell1Tytp?=
 =?utf-8?B?SHNUN1FYYVM4UEhiQVFmcERIeTE5eTUwcFAxeXZaZDZPcjRiK0U4T0wwZ1c3?=
 =?utf-8?B?VEE2ay9UeW00SC9HK3F4dFRoTDZXQjNOUDk0SjkyYWUxdGtWeDh1R2lJd1g0?=
 =?utf-8?B?eWhEQzFQL2xmQ3JNeWFRWEJGd09Pc3hYcWlkdkxrR3FJTy9GbzVJMFJkMXg5?=
 =?utf-8?B?ZnFPSE5uMWdVeEloWDRra0hZUzI1cXZOb0tSU2tWZDhwZU4rVkpRTHNGUHlJ?=
 =?utf-8?B?MW41YjNDSi9pMnhFbS8rMWc3eDlicHYxL2dhdnA3OWdNTEo2Z0ZuYTNIeTZ6?=
 =?utf-8?Q?+8Jtkr38CUAlHZ34r6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e549afe-1944-4fe7-19a2-08df14069707
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:24:25.1771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fW9vYzuoBNBwqEpR0D/tHxcg4pbjlR9+S6LbpVE16WrsiHmxOkDwUYzv9EnCmXY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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



On 9/16/26 17:10, SRINIVASAN SHANMUGAM wrote:
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
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 ++++++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>>>   include/uapi/drm/amdgpu_drm.h             |   2 -
>>>   7 files changed, 285 insertions(+), 91 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index a93ee106ab92..6473faf18d71 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> -    DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
>>>       /* KMS */
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 47e4680db797..559c9222fc48 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>       }
>>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>> -    amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>>> +    amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
>>>         if (pasid)
>>>           amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> index 31f653ec3fb1..3313bc099cf4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> @@ -19,12 +19,23 @@
>>>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>    * OTHER DEALINGS IN THE SOFTWARE.
>>>    */
>>> +#include <linux/iosys-map.h>
>>> +#include <drm/ttm/ttm_bo.h>
>>> +
>>>   #include <drm/drm_exec.h>
>>>     #include "amdgpu.h"
>>> +#include "amdgpu_gmc.h"
>>> +#include "amdgpu_userq.h"
>>> +#include "amdgpu_vm.h"
>>>   #include "cwsr_trap_handler.h"
>>>   #include "amdgpu_trap.h"
>>>   +/* First-level TMA layout shared with second-level trap handler ABI */
>>> +#define AMDGPU_TRAP_L2_TBA_INDEX    0
>>> +#define AMDGPU_TRAP_L2_TMA_INDEX    1
>>> +#define AMDGPU_TRAP_DEBUG_FLAG_INDEX    2
>>> +
>>>   extern int cwsr_enable;
>>>     #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>>> @@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>       struct amdgpu_trap_obj *cwsr;
>>>       struct amdgpu_bo *bo;
>>>       struct drm_exec exec;
>>> +    void *cpu_addr;
>>>       int r;
>>>         if (!amdgpu_trap_is_enabled(adev))
>>> @@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>         r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
>>>                       AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
>>> -                    &cwsr->tma_cpu_addr);
>>> +                    &cpu_addr);
>>>       if (r)
>>>           goto err;
>>>   +    /*
>>> +     * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
>>> +     * may be placed in VRAM and accessed via MMIO (PCI BAR). Check
>>> +     * TTM_BO_MAP_IOMEM_MASK to select the correct write accessor.
>>> +     */
>>> +    if (cwsr->tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>> +        iosys_map_set_vaddr_iomem(&cwsr->tma_map,
>>> +                      (void __iomem *)cpu_addr);
>>> +    else
>>> +        iosys_map_set_vaddr(&cwsr->tma_map, cpu_addr);
>>> +
>> Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need an iosys_map.
>>
>>
>>
>>>       r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>>>       if (r)
>>>           goto err;
>>> @@ -433,6 +456,29 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>       return r;
>>>   }
>>>   +void amdgpu_trap_clear_l2_handler(struct amdgpu_vm *vm,
>>> +                  struct amdgpu_trap_obj *trap_obj)
>>> +{
>>> +    if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
>>> +        return;
>>> +
>>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> +
>>> +    /*
>>> +     * Zero TBA first to disable dispatch before clearing TMA.
>>> +     */
>>> +    iosys_map_wr(&trap_obj->tma_map,
>>> +             AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, 0);
>>> +    dma_wmb();
>>> +    iosys_map_wr(&trap_obj->tma_map,
>>> +             AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64), u64, 0);
>> It's most likely a good idea to grab the reset lock around all iosys_map_wr() as well.
> 
> 
> Thanks Christian. May I kno pls, do you mean taking the existing reset-domain lock around the complete TMA descriptor update (all iosys_map_wr() calls and the final barrier), or only around each individual write?

One read side lock around all iosys_map_wr() calls and the barrier should be sufficient.

The problem is that during a reset you can't access VRAM for a moment without crashing the system.

So we need to avoid writing to VRAM at the same time as a GPU reset is ongoing.

Regards,
Christian.

> 
> 
>>
>>> +
>>> +    trap_obj->l2_tba_addr = 0;
>>> +    trap_obj->l2_tba_size = 0;
>>> +    trap_obj->l2_tma_addr = 0;
>>> +    trap_obj->l2_tma_size = 0;
>>> +}
>>> +
>>>   int amdgpu_trap_validate_params(struct amdgpu_device *adev,
>>>                   struct amdgpu_trap_params *trap_params,
>>>                   int num_xcc)
>>> @@ -464,6 +510,7 @@ int amdgpu_trap_validate_params(struct amdgpu_device *adev,
>>>   }
>>>     void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> +              struct amdgpu_userq_mgr *uq_mgr,
>>>                 struct amdgpu_trap_obj **trap_obj)
>>>   {
>>>       struct amdgpu_bo *tba_bo;
>>> @@ -473,32 +520,41 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>         if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
>>>           return;
>>> +
>>> +    /*
>>> +     * Evict all user queues before freeing. At file-close time waves
>>> +     * may still be active; without eviction a wave can trap into the
>>> +     * handler after the TMA BO is freed, causing a GPU page fault.
>>> +     */
>>> +    if (uq_mgr)
>>> +        amdgpu_userq_evict(uq_mgr);
>>> +
>>>       tba_bo = adev->trap_info->isa_bo;
>>>       tma_bo = (*trap_obj)->tma_bo;
>>>         if (!tba_bo || !tma_bo)
>>>           return;
>>>   -    drm_exec_init(&exec, 0, 0);
>>> -    drm_exec_until_all_locked(&exec)
>>> -    {
>>> +    drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>>> +    drm_exec_until_all_locked(&exec) {
>>>           r = amdgpu_vm_lock_pd(vm, &exec, 0);
>>> -        if (likely(!r))
>>> -            r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
>>> -        drm_exec_retry_on_contention(&exec);
>>>           if (likely(!r))
>>>               r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
>>> +        if (likely(!r))
>>> +            r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
>> Please don't do such hacks. drm_exec_retry_on_contention() should be called after each drm_exec_lock_obj() call and if (r) goto error handling used here.
>>
>>>           drm_exec_retry_on_contention(&exec);
>>>           if (unlikely(r)) {
>>>               dev_err(adev->dev,
>>>                   "failed to reserve CWSR BOs: err=%d\n", r);
>>> -            goto err;
>>> +            goto out;
>>>           }
>>>       }
>>>   +    amdgpu_trap_clear_l2_handler(vm, *trap_obj);
>>> +
>>>       amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
>>>       amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
>>> -err:
>>> +out:
>>>       drm_exec_fini(&exec);
>>>       amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
>>>       kfree(*trap_obj);
>>> @@ -509,120 +565,186 @@ static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
>>>                         struct amdgpu_vm *vm,
>>>                         struct amdgpu_trap_usr_addr *usr_addr)
>>>   {
>>> +    struct amdgpu_bo *bo;
>>>       struct amdgpu_bo_va_mapping *va_map;
>>> -    uint64_t addr;
>>> -    uint32_t size;
>>> -    int r;
>>> +    u64 addr;
>>> +    u32 size;
>>> +
>>> +    /*
>>> +     * Caller holds the VM root BO reservation; assert rather than
>>> +     * taking it again.
>>> +     */
>>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>         addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>>>       size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
>>>   -    r = amdgpu_bo_reserve(vm->root.bo, false);
>>> -    if (r)
>>> -        return r;
>>> -
>>>       va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
>>> -    if (!va_map) {
>>> -        r = -EINVAL;
>>> -        goto err;
>>> -    }
>>> -    /* validate whether resident in the VM mapping range */
>>> -    if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
>>> -        amdgpu_bo_unreserve(vm->root.bo);
>>> -        return 0;
>>> +    if (!va_map)
>>> +        return -EINVAL;
>>> +
>>> +    /*
>>> +     * TBA/TMA BOs must be VM_ALWAYS_VALID. The GPU jumps to TBA on
>>> +     * hardware exception without any software job submission, so the
>>> +     * kernel cannot add TBA/TMA to a job's used-buffer list to keep
>>> +     * page tables current. Without VM_ALWAYS_VALID the BO can be
>>> +     * evicted and the page table entry becomes stale, causing a GPU
>>> +     * page fault or memory corruption on the next shader exception.
>>> +     */
>> That comment is not correct. This would work completely without AMDGPU_GEM_CREATE_VM_ALWAYS_VALID.
>>
>> Please just completely drop it.
>>
>>> +    bo = va_map->bo_va->base.bo;
>>> +    if (!(bo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)) {
>>> +        dev_dbg(adev->dev,
>>> +            "TBA/TMA BO at VA 0x%llx must use VM_ALWAYS_VALID\n",
>>> +            usr_addr->addr);
>>> +        return -EINVAL;
>>>       }
>>>   -    r = -EINVAL;
>>> -err:
>>> -    amdgpu_bo_unreserve(vm->root.bo);
>>> +    if (addr >= va_map->start && va_map->last - addr + 1 >= size)
>>> +        return 0;
>>>   -    return r;
>>> +    return -EINVAL;
>>>   }
>>>   -static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> -                       struct amdgpu_trap_obj *cwsr_obj,
>>> -                       struct amdgpu_trap_usr_addr *tma,
>>> -                       struct amdgpu_trap_usr_addr *tba)
>>> +int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
>>> +                   struct amdgpu_vm *vm,
>>> +                   struct amdgpu_userq_mgr *uq_mgr,
>>> +                   struct amdgpu_trap_obj *trap_obj,
>>> +                   u64 tba_va, uint32_t tba_sz,
>>> +                   u64 tma_va, uint32_t tma_sz)
>>>   {
>>> -    uint64_t *l1tma;
>>> +    struct amdgpu_trap_usr_addr tba = { .addr = tba_va, .size = tba_sz };
>>> +    struct amdgpu_trap_usr_addr tma = { .addr = tma_va, .size = tma_sz };
>>> +    long timeout;
>>>       int r;
>>>         if (!amdgpu_trap_is_enabled(adev))
>>>           return -EOPNOTSUPP;
>>> -
>>> -    if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
>>> +    if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
>>>           return -EINVAL;
>>> -    r = amdgpu_trap_validate_user_addr(adev, vm, tma);
>>> +
>>> +    /*
>>> +     * Wait for any kernel-queue work using this VM to drain before
>>> +     * evicting user queues and writing the new descriptor. Without
>>> +     * this wait a kernel-queue wave can observe a partially-written
>>> +     * TBA/TMA pair during the update window. SET fails if the wait
>>> +     * is interrupted or times out so the caller can retry.
>>> +     */
>>> +    timeout = amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
>>> +    if (timeout <= 0)
>>> +        return timeout < 0 ? timeout : -ETIMEDOUT;
>>> +
>>> +    /*
>>> +     * Evict all user queues before updating TBA/TMA. Writing TBA and
>>> +     * TMA as two separate stores creates a race: a wave that traps
>>> +     * between them reads a mismatched pair. Evicting first ensures no
>>> +     * wave is active during the update.
>>> +     */
>>> +    amdgpu_userq_evict(uq_mgr);
>>> +
>>> +    /* Flush GPU TLB to remove stale cached TBA/TMA values */
>>> +    amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>>> +
>>> +    r = amdgpu_bo_reserve(vm->root.bo, false);
>>>       if (r)
>>>           return r;
>>> -    r = amdgpu_trap_validate_user_addr(adev, vm, tba);
>>> +
>>> +    r = amdgpu_trap_validate_user_addr(adev, vm, &tba);
>>> +    if (r)
>>> +        goto out_unreserve;
>>> +    r = amdgpu_trap_validate_user_addr(adev, vm, &tma);
>>> +    if (r)
>>> +        goto out_unreserve;
>>> +
>>> +    /* Zero TBA first to disable residual handler, then TMA, then TBA */
>> That doesn't seem to make sense. Why should that be necessary.
> 
> I added the initial TBA=0 wrtie defensively to avoid exposing a stale descriptor during the update. Since execution is quiesced before updating the TMA, it isn't necessary, I'll remove it and place the barrier after the final TBA/TMA write.
> 
> Thanks, Srini
> 


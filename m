Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B072BC982CF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F50810EC57;
	Wed, 16 Sep 2026 15:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="beg3qpR5";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BA310EC57
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3hHijzL1nTOOxKwpJ7uM16v7Vut+5q3W6ElTaypMvosQVE1grxX14qb9JIioB8/4G4ZeiSGUUSDAyKoWspDdhDz63PE780FenOuB/MtX2tcR+IJHS+LFzEmXNSkmnN5tSSLlnmU+8SgDOoX4eGy/kiqJ9U1k8MztQEfXhaamZLkbXhLR4yKX/3tUwMqc2MDkhhL3sRiHtkp9xLvTVtQQbeXwKZbYclImwYmUESysjUeF8Tfcni/PAK525VezKWPhONeSDR29t6pzNTSd6uNgVZTeaUS9pBqq1q6V4yZKjJSNWDBs+qm6XM3aCMOjWPo32Ak4R09W592S3cow6oQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DtpSyBA8/q2/ck3waIuNzga6txOHKvqyqCm/XRmIS0=;
 b=Hxz0waKVuQFN5+QfQ0jrl7zacwAcj8kXY18XCkwoVMngAIOAJuKXt4Y8Y6/0BTb5JSdGzF1mUpeV1E9fi8gAXIkCcrPTUt6Po6OOpWBVC6vOQfpoYDAAQd0JdXy3FViph17Hp3cNNwzCczTO2kIlikveE+QdJz8YZqzRonPuDWhlxfNAVRtW+ojt2upC/z9l/RseJ0SFUka24Lv/1gCtcckQBP99U6GOtbiNzvzoWcEAg3g7/U+e4APAfPj5MUmQ1a+VSuini83QCHKdiA4RpUUiCMEK8MW6okGA3kgVuBpYWWaQpcyLn3fZCm0nOjtN+kszQi8k9ZNfraWPnmvtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DtpSyBA8/q2/ck3waIuNzga6txOHKvqyqCm/XRmIS0=;
 b=beg3qpR5dYHhYxchrYwfLLatih9irzvX7AT737SWcJ//TYf7YxfezIrRkg3LfxC5YdoFviAjpnSXfCqrHQGSF0NqVTqxLQywT1wcmp6kb4eH+2cumd8tBKZ02g9IQyrWR5yU262ehRpJOtRcIkS0ISbKRpyx4fsVIF4n4nhOX7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:34:05 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 15:34:03 +0000
Message-ID: <99fc56f4-4288-484c-8ef5-1bb3f6bb2bc4@amd.com>
Date: Wed, 16 Sep 2026 21:03:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Add second-level trap handler
 infrastructure
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Samuel Pitoiset <hakzsam@gmail.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-2-srinivasan.shanmugam@amd.com>
 <f7edaea8-f172-4573-952f-6a85d1302d8f@amd.com>
 <55354752-5ef6-44ad-bf31-95503aeefde1@amd.com>
Content-Language: en-US
In-Reply-To: <55354752-5ef6-44ad-bf31-95503aeefde1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::6) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9756dcc7-2b3a-4976-1944-08df1407eff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|5023799004|11063799006|3023799007|56012099006|6133799003|22082099003|18002099003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: gpHhAPBwzRBvRnG85Z8Zs1ERxq3fOxvA1hVURNkQ3VPKCpcrR6Je34hZRsYahIdjNOBbwbeVi1WPOtjcULGD3/PpIBFE5FY/wcwktxOuDfkqUQaC1aJYba+dHUeQyrYrgVQ6JQrABHjWs5ESZzqrWoDFTb00EuTZbnY+y5fRiY2Uf/POK7UgGl1/OKb9vRrd8iZpE3C7z6aInmLqWbTJX3Gogfe59jhvKEm8C42Z3vkODsWhzcweHN92bxiJeJiOWw5sc2R6WeW9V+XKkAyW+qKLzdfnNqUQnqWYhlL+hFZbv9bWbremPqfbxflVgA3GNviJoM1xWHMHeYek2493280WIaRtHBelTDnkUv1rZBB2YG7PMdzK8TwgVF68OQq8ICFP+v9NLDf04+A6K/A5RVtDn1T2j1vWEQ6W3atX8IydHbU/YOtJ6Ch7gAkjNjdXyMkbs58ctXdvXA4U5TKaZ4lUGd85IoG8MeTULDwSYeageum/S+Pf/0YRqpfEzcH7q1hozxRn6FD7IWdDhKrN8EVktKNraArDzgf4fPQlyRfqohwbmcLTiggl3izrIxxXT/FPcDDW79b6JdSxJtUknYRyXa5Rlosk6IZ3yqdzT5BnkicJ1xNQqmSHhuBHPEDNZaClKDAlanD64QVP/2YMs+vzfjSlzb6YbOrEe0fRP00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Y2Wjh5dGVGODdjRVBqNnBUT3JBSGFjbEkxQnhtcGVUU1N3WWhzRmhTdFc4?=
 =?utf-8?B?c1ZmU1Rsd1dJYnNLVHgwc3dYTytpSVdQRndNQkRYZ1JBSVBIckJEd0JDUDNq?=
 =?utf-8?B?UjJzUEtGSXJ0MGVESUhSalpYQ1A0YWRTWjdZZmF3UzVPb3pRTzhwRUNmODVW?=
 =?utf-8?B?QVdwRDFzUXNac3c2c09qT0laY01mK04xNHN3RC8wcS9ma2MyQ2lQc205VkxP?=
 =?utf-8?B?MGh0aUx1ZmwxbGZVSExnaUFDR0FhRUhIYXBLMTZnS0tUMW9TekU3ZUFGQlBr?=
 =?utf-8?B?eU5DV0MwTG9oa01Ud0luZzZFQ1NUNStoUmJSWnRhdWhlYzJCNk1JYldKbWY4?=
 =?utf-8?B?S0Y0enJ3NWdubXZmaHYyRlo1NTZjaDhTU0dIbHNKaDdYL3BUMTBJL29OTCt3?=
 =?utf-8?B?VndsYWphdjZKQWxZcFlyckwrN21sdWZGWVhka1RFeUpxR3Y2UnlUZkdLMUhO?=
 =?utf-8?B?QzBWemRYNFdJb0Y3ckxmNTVGeEVOUDhqdGV2S2J3VmwzMXpvY3BqdERUazZs?=
 =?utf-8?B?d29sNlQvQlJjZC9GVHZOamc4eFVGbWVTYnFHMXF5aWRUdC8rL0ZlZXBES2w3?=
 =?utf-8?B?TG9FSjdUd0ZteXQvOHU0YkpYc3FCbW5ZSVA3NWk2Kys5SmFxTHBpNjU1cFdZ?=
 =?utf-8?B?ejlacmU4aG1YcW1tRHhsMStFbEtvQWZ4RXpvZ0V0M0dVc3dwNkpzUFMzK2c5?=
 =?utf-8?B?ME45NGk1aU0vYU1Nd1k3MWVxbVRYbTNVZjVONTVTS2pKSWdVWXQzN2UvQ2Z1?=
 =?utf-8?B?RDVTTWNvOEQxUWRNODFuYmFvM2lkdWZvRDlnSFQ3d3E5NWdON1ptbWhYS3Iz?=
 =?utf-8?B?MXRHMEZaaDN1N3JKcHFRTGFQUVgxb0ErbEJ0bmVhVW1YaU14dWFZTXNlMVgr?=
 =?utf-8?B?Y2E1bjR2MmNYUVozSjByeVl2ZHdTaWlPSmJybk55V1M3Yk51OWYxTWJhaWEy?=
 =?utf-8?B?NWdDcXNxcjAvQjNMdXA3ZTI0VXJrMmhuNXAwUzluM2hXQTI4b1dHaUZZYUM5?=
 =?utf-8?B?M3drYUxCSitFdldwUmZYNzhwYXYvSWJSdHJ0UDRlbXZUZXlUZ2hBcXI5RW9s?=
 =?utf-8?B?QkhNMDVWMGhSUGlubW5DSGVCRVNvMUFtWHB5ajRVWE1IL0dTOWV4cFJHNitv?=
 =?utf-8?B?STNUc1ZvZEtWUWNRUDVPK3J1cHNDay9DMHovMDZsWmFNaWJzRnpHU2hKN29v?=
 =?utf-8?B?bGpZY3JPVDRUZTNlN1RpTDRCeVJ0QVdnTXh0ZHlUUnNwM0RvcTJ6ZVlzZXYw?=
 =?utf-8?B?bmVWcm0vTUFsbG9nczMvRGl0YTFwanVpN3Vkek5zRU53UHVXdGpPNkpBc0tK?=
 =?utf-8?B?UUdiZ2pCZjM3Y1lpb0hLWTFUbUx6SHZJaGJqenlaemJWcjdQcklJcVA0azNN?=
 =?utf-8?B?T3RScDFMVVR2WEJjcmVyNk1rTTM5Z2RIQnhxZU4vZmc1OHUzSFZYU0kxWWhn?=
 =?utf-8?B?MXB5ellLbS9vYXdHclJlYnpXNlU4NWZ3VUNvZE5kQzd6M0d6c1lLZDJnckJH?=
 =?utf-8?B?Zy9hZVlBbkxzZVV2YjFNTTVzOEgzM1ltNlFnaUFoK3BmV0lORzlRSEVOVXNm?=
 =?utf-8?B?ZXFFNHJ3N0UzTi9qQXcwKzZZSkxnWnNudTFEQ3hObUdZUWJZcjRWemhxM0U1?=
 =?utf-8?B?WG82M2w0NGZBOXRITlkwZ2ZMdTdKL3liVmx1U2xqcWZmWFN0cWJqRFBodzlp?=
 =?utf-8?B?NGJmelRVRk0yOUtyak9jY0t5ZzN3WGtjbUhTOVRqYUlZYlkvVkNwSkYwTGRs?=
 =?utf-8?B?K2EwY2VIdkZEVlNLQWpMbkQ1Q1A0STRMME94OUJ3MVY1REQ3ZElSL1BobSsx?=
 =?utf-8?B?bFRyYXNKNFM1Q3I4R1dLZmFPWWN3SVlwTlUwUnlpdUk2R1dFK1ZBRnpxdTZr?=
 =?utf-8?B?dHl6cFh2ZFNOTGJVeDNiYnduM0VGY0VDOGo0Yk9hNVYwQzNlTjRtd05QWDhn?=
 =?utf-8?B?TTZmdkZUWWFoR29tci9tTmkvU1RkYjFOVEpuaFpvZmpLdlhibzhSUXNTdjJK?=
 =?utf-8?B?OTRoc2FrTWp2YlU5aXdkZWw2OUxpOTl5Z0QvaUNsMVVqNkkyNlVXMyt0Y1Rs?=
 =?utf-8?B?NEF2VWkvcGpuenJkdUQ2SStkbkIzT2VRcng2cDRZZy9zVkZUelBEekliTW9p?=
 =?utf-8?B?K0dqZkhEbjYrR3ZHREtYZ1hWaUhibk5ndGdTNXVyVWNZYkNIVHVrTmlxSUlS?=
 =?utf-8?B?MVRhV3pKeFNxR2hrWjhFbVNSWXRNNE9vaFlRV1piYkhrZmlLc3RhbGVqZmps?=
 =?utf-8?B?VW41Y2RpMnVnMXBORU15N0JUU1ZkSGRaUExTNmRHUVJ0N2JSQzFNNUU4RkJp?=
 =?utf-8?Q?uvoSTsEOIZ2qMHQPEl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9756dcc7-2b3a-4976-1944-08df1407eff6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:34:03.7524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5jfAkKGIEEE8Lag9RhZGWZN9g5q3hBMt/rwoI2dA7CH4wBH2pvRJ3/hXnaJSWqFJeUQ/nTfHC+czi018jh9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106
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


On 9/16/2026 8:40 PM, SRINIVASAN SHANMUGAM wrote:
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
>>> SET_L2_TRAP is per-VM (per-process). Each process has its own TMA 
>>> buffer
>>> allocated in amdgpu_trap_alloc(). There is no conflict between 
>>> processes
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
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 
>>> ++++++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>>>   include/uapi/drm/amdgpu_drm.h             |   2 -
>>>   7 files changed, 285 insertions(+), 91 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index a93ee106ab92..6473faf18d71 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc 
>>> amdgpu_ioctls_kms[] = {
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, 
>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, 
>>> amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> -    DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | 
>>> DRM_RENDER_ALLOW),
>>>       /* KMS */
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, 
>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, 
>>> amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 47e4680db797..559c9222fc48 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct 
>>> drm_device *dev,
>>>       }
>>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>> -    amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>>> +    amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, 
>>> &fpriv->trap_obj);
>>>         if (pasid)
>>>           amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> index 31f653ec3fb1..3313bc099cf4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> @@ -19,12 +19,23 @@
>>>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
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
>>>   +/* First-level TMA layout shared with second-level trap handler 
>>> ABI */
>>> +#define AMDGPU_TRAP_L2_TBA_INDEX    0
>>> +#define AMDGPU_TRAP_L2_TMA_INDEX    1
>>> +#define AMDGPU_TRAP_DEBUG_FLAG_INDEX    2
>>> +
>>>   extern int cwsr_enable;
>>>     #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>>> @@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>       struct amdgpu_trap_obj *cwsr;
>>>       struct amdgpu_bo *bo;
>>>       struct drm_exec exec;
>>> +    void *cpu_addr;
>>>       int r;
>>>         if (!amdgpu_trap_is_enabled(adev))
>>> @@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>         r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, 
>>> PAGE_SIZE,
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
>> Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need 
>> an iosys_map.
>>
>>
>>
>>>       r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>>>       if (r)
>>>           goto err;
>>> @@ -433,6 +456,29 @@ int amdgpu_trap_alloc(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
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
>> It's most likely a good idea to grab the reset lock around all 
>> iosys_map_wr() as well.
>
>
> Thanks Christian. May I kno pls, do you mean taking the existing 
> reset-domain lock around the complete TMA descriptor update (all 
> iosys_map_wr() calls and the final barrier), or only around each 
> individual write?
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
>>> @@ -464,6 +510,7 @@ int amdgpu_trap_validate_params(struct 
>>> amdgpu_device *adev,
>>>   }
>>>     void amdgpu_trap_free(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> +              struct amdgpu_userq_mgr *uq_mgr,
>>>                 struct amdgpu_trap_obj **trap_obj)
>>>   {
>>>       struct amdgpu_bo *tba_bo;
>>> @@ -473,32 +520,41 @@ void amdgpu_trap_free(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
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
>> Please don't do such hacks. drm_exec_retry_on_contention() should be 
>> called after each drm_exec_lock_obj() call and if (r) goto error 
>> handling used here.
>>
>>> drm_exec_retry_on_contention(&exec);
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
>>> @@ -509,120 +565,186 @@ static int 
>>> amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
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
>>>         addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> 
>>> AMDGPU_GPU_PAGE_SHIFT;
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
>> That comment is not correct. This would work completely without 
>> AMDGPU_GEM_CREATE_VM_ALWAYS_VALID.
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
>>>   -static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
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
>>> +    struct amdgpu_trap_usr_addr tba = { .addr = tba_va, .size = 
>>> tba_sz };
>>> +    struct amdgpu_trap_usr_addr tma = { .addr = tma_va, .size = 
>>> tma_sz };
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

Hi Alex,

For the kernel queue case, which lock should I use to prevent new work 
from using this GPUVM while the TMA is being updated? Is locking the VM 
root BO sufficient, or should I use another existing lock? Also, once 
that lock is held, is amdgpu_vm_wait_idle() the correct way for the 
existing kernel-queue work to finish?

Thanks,

Srini



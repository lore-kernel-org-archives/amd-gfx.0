Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A2C982C3
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14ABE88FAE;
	Wed, 16 Sep 2026 15:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I545ZBF7";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11B988FAE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBZ0m3oDKS+VYHupftUyMMkozuZtKimNBRLYIvTCR1eEBmWSkxg8Vn9Kbe2SVyBsD8nTkmYw3nNgmxtVFB5w5mEbRKhcA1qWdCd/v6nVQgmOFwh+LMqOjabegZjmVFWwGPKog6hsrBb0d5rqKqfkemk7Q0A/Inak5YxkiQCzvO6wVCcDqNvgYQxE2hAsgoaS6ngYcflqlwbiUGQd/A5Pm13PLfxKVyS6a60iWE4PSL3X+JSALnadyBQLGhQ2GOvIO8O/gtX0NtNTVyMYnIam6vcHz5MXf1wfz4pNeHCDnVaHvkcr89sbVtR8bfYNKkuF1ZOqRKzMcmk3CKzl2NfMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvbdjXfIpPtWT7LzUI+8qrvCRFCp79NlXfCNbcGzB24=;
 b=mi+h2LULXjzlt5F/IcBpCsIQ7EwpEtY5OSq8ADV4YgyRhaN4E5312JQlwoEQkQnSZNQlDNkM5819ncsS/KsK0GxUUb38NzFjoUvzZ+FYByq7R9M0qSdmq2DphgNq5T1W/gcVXuJLCEbo6ydEqHpGYbSDDZiqtzSb8e8poYurspmCYI48DJDMKy7lDY3qrFx19JiWLdGgnGRX+dkt/SjlPOs+ezBLSQo4K0533syGAVIYsJY+4/dSp4Ghc+Xg9VTPC5f18/7QzHFTe+vER0Oo5w3CmpnRTzSgx6sg2mCS0ppYg93IGxbqGX9vuYYhukowLnYhesBLt3snNwyysEUmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvbdjXfIpPtWT7LzUI+8qrvCRFCp79NlXfCNbcGzB24=;
 b=I545ZBF7Z9qcKu5zJPl9f5E8IbVTv+wzabVgiF3k93tZo7INmgOZzYMrHzxN3/kvVGRqM56Eh7yOQzIaRN7DAcaWEd+vpU8Pt3eJXEp/aWlEadtSGsEus0cKqKL65CZmCf8dAm4g50ro3hSmnYP1tYa8azUz3AWtfUrpo9Fpxio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:11:07 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 15:11:06 +0000
Message-ID: <55354752-5ef6-44ad-bf31-95503aeefde1@amd.com>
Date: Wed, 16 Sep 2026 20:40:53 +0530
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
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <f7edaea8-f172-4573-952f-6a85d1302d8f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::13) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d50db2-745b-49bf-56e2-08df1404bb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: en6py2q3VMPHdxVc8O0P7hsojtfvXSOdQn7ngvB0YtjBtPjbhBWAPXtVBdkLATugQIm1XYP8TbM3HSQEIq0TE/wGEL8rP3bf0tsGP1C86KNDemYP2VgeLOF1Dp/SUAG/h8ocT6meBh/WGOj0wLmRrr3F40Fg+R7j0Fkd9BQL9ojaS+QWb3gCaVit3Cv+DzsxM0UMYymkDEabRxiXENObQy8iVa5uYILAMv9oeeqvoL6GEI5jMYEjmdnVFxGYcaFhBpmmM4wM6qnelyaiM1fzn/gT8uIEA6i8abAL6LNXD33PyLj+cWdVVYzr75y5iD16pUSC8saE73x5FXnsFUK67qb+Scbv2hD7GDZmeC7HoBwyDEz+fOyHwVL1o5JPojd9VIu8/qI65S5YakE3Nn27fsPCkdRAZkZj+fQnHftIxqB6HEiBUydM2x8/xHItvulK5ck1jAbqL84AT6NfAJvWyvuUpuArPQ+iMrwdvZ1y0sPYMDwh5QVfmn/e0ugQDiWjlIxmJXjXyV5bjupZ0ptEpBlKKvAsQY1/He/wYOjMODKnXZP+o0W3ZM/xUKxWgGvL3cwdkTHavtwTNURox7KrOL2Ab+tjXfa3R2gAIn7nwueFThFGW3NbkGiU93xszLnftT51WRiMdsS5GYKQKZUB2l3Y+o/r7R0XO12J2XDZqNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VNc0NGVVg1WC8vYnJBbVdyQ2hERkRESC84MnJRTEVrTXo3eEc5bVRwbGds?=
 =?utf-8?B?QkxjYUYyMWRJQ0psOW16R2hZalloUEpnclg2MHU2OTdPL0ZkcmljdGlnRkwx?=
 =?utf-8?B?a3lrRzMrVlZ6NWQ5akJRUzBVL1JWamJqZ3dLSkZ4M1BTZ2lINXVNbHl4Y3Fj?=
 =?utf-8?B?U1hUTVowMEgwNmNVcmZ5L0ZLM0lPK0RMYUNvSkVsSUZsWjdvbStab1Y2UVN4?=
 =?utf-8?B?aTg1WTNqK1c1U1V3NnFpNFhhN0xBV3pPNTJVY0tHdHhqWjg3TDIwdFFra2NT?=
 =?utf-8?B?M0MwOTNVbXZ2THZMZ3B5UHhuUjZ3QlZURzB0UlFOak5ERXhHRWRUMU9SUGdq?=
 =?utf-8?B?QWdua2tTd3FwVjZKek4zelp4cnJBYVNicTJWclFPRGE5QjhNdTV4UnR3Ym5i?=
 =?utf-8?B?Q3d4a01sdzVCa245K1BRSFEzMFhOd2hJZlRSb1l4K0RVWjNEenFMNGlnRTF4?=
 =?utf-8?B?c3FWZFNDZEwzSlVyWmpnQWNUK1hPZU9aeXVzY2o3VlA0c0xZeWM3dHRyN2x5?=
 =?utf-8?B?ZHRid3hsTHN2SGFsUlFsaWh3Q1RKSjljb0ZXMzdXUjlCaENzR1gyZCtBM04z?=
 =?utf-8?B?L2VXL0R0UzA2S2NKTnhzN3NFb3pjcUNWZ3lQMXZvK2cxazJ4U012WUxNMHVC?=
 =?utf-8?B?TEplU2E3dGYzQkwzN0JqOWlrUGdOdFpNd2RFUStxTjJQM1l4UW1lckxzRUpR?=
 =?utf-8?B?MmF1Nm5pUkNTQjJZR1hZQ1pGOUY3RkhCRFp5V2Z5eThUNUVjMVRlcHgxQWVE?=
 =?utf-8?B?eHZ1R3BGdlBuaGEzeDRWUVdEcUlUc2RoVkZMNWNCZTd5L2hHV3JVRDNUVnBu?=
 =?utf-8?B?SCtaTmYwdXZmdFNudmtnUnJ2cmU4KzJmRWdYclZpUW0zWkJrblJHYy96bEJa?=
 =?utf-8?B?YmJ6dXJyaU9MQlR3MGJBOGw3TmZVY2w2VEdrcm9KMFBtZCtiODRVc3VQRnM3?=
 =?utf-8?B?QmZHNzFySmZsdDJBRlVLeXhGdndObitKK0RrMTFBQW84WkQ5Z1kvMklJSEhv?=
 =?utf-8?B?SDF6VS9oK1FHRjRjTGUrTksvcWphSTVOSllVWGxjWUZFZkxONVFnTm4vd0RC?=
 =?utf-8?B?R2RieUNQcGhHbkdZcjg4Ny9CL01TcmpkOFlpc21Rb01ZSTZoRUZRNVFZd0Fm?=
 =?utf-8?B?K013NGFWVGJKQU5DNHRhOGpobmpaTjN3c0tjOWpGTDdGelBUZlNTbGZ6aEx2?=
 =?utf-8?B?MXhNM3VacHB1U3ZNMTEzcGF1ajQxTldwMGVaSnNJVlhTdWtuQ3EvcXJaVDVi?=
 =?utf-8?B?TjBMVXlia1BTYThGNDhhUXQ1Z2E4OUZvUzZOZWxqZ3dUVExJSTJRSG9TWWw5?=
 =?utf-8?B?UDR0SEdHNjZMY3dhdUh5QXFxanduTEJ2bTZQYXlsWmxoaG43RmJUS3ZzMVkx?=
 =?utf-8?B?ZEpuY0ZyMGF6a2htU3RsZzAweGYrSlRCMEVKMFhYOXRXVm9kM21lVklxeDFn?=
 =?utf-8?B?MGVsNUh0TWplMTFuOVB6Rk5FZG9BUE1TOVpnelpJOEJoOUliSzgrUEZ2bVdU?=
 =?utf-8?B?L0Q5bGxxSWR2V2QxMG1jalJQUm5tbHB3dHgyUUNZV1dBcWNYVlZpQjlVSGsy?=
 =?utf-8?B?RStPb3BaTjhzUUphQ3FrV01hZHpVb0l4MCtqc0JVUnU0TXFqODFvTHR6SGMz?=
 =?utf-8?B?NGhwVXJiUmFrUE9KNVBYeG1PVXFJTHVQeENCT0JrNzcySkQrRDZRbFRLYTM2?=
 =?utf-8?B?YlFQeEhkcENwSlE4LzRodDQ3cnB2eGZCV1lRbHpNVWpNdEhQYkZOMElSQUlv?=
 =?utf-8?B?QytOS2lOaThGZjh2TUZxdUw3VlBKdVFKSExGRWxjaVc4ckpKYzlFZlRNUVZs?=
 =?utf-8?B?U0xtQ3FZSXhjREQ4YmJzZXlRTThtUjQ1S0N0NXB4dlRXZlJ4WWRteDROa1BI?=
 =?utf-8?B?VElRaU9QV1NzVzcyYjRJRk4xUGQrSGpwWDBYdzE5MXYxWWEzRjBlU0xHeEoz?=
 =?utf-8?B?ZC9TblZLb1k4V1lTbTJmcEZPZzNBa0tOaG5ORXNQRmFmVHpVYVVTQzR3aHJo?=
 =?utf-8?B?R0RWMUdlcCtZRTJpTjhmUXA5SVpRVjdRTUJzWndyK1h3REFoeFV3Mnlqei9z?=
 =?utf-8?B?SU04eW9PNnZqVnRycmJJWmIyZGFmQWZNalVlZ1U4eTJadEtXVUNrR01nMHA0?=
 =?utf-8?B?ZXVXWVk5MnNUNm9IQW0zaHBwU3pvdFlOMDhZd3Y3T0d3WmNSOUE0ZE1MSUNC?=
 =?utf-8?B?d3J3bkkwRmplMy90K0E5MktXcXYzZ05KN2hiTUVNYnZhTjY4QWdCL093eXRo?=
 =?utf-8?B?Y0RnUyt0NWE3WSs2SHdQNmVJNEhEeGwraU1VM2VmTXFNZkFVTzRGSW50MmE5?=
 =?utf-8?Q?sm+COBMFhjwE36rvPI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d50db2-745b-49bf-56e2-08df1404bb69
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:11:06.8340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxoltFIvX+hYzyPT0nIb9gbslPrDDhP6vkSx5+yNktmhNNzzcvuJqF487Dm6V6XEmvPMJkLUbNW3sdp0scSU2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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


On 9/16/2026 8:14 PM, Christian König wrote:
> Hi Srini,
>
> please keep Timur, Natalie and Samuel on CC.
>
> On 9/16/26 07:37, Srinivasan Shanmugam wrote:
>> Render-node user queues had no mechanism to install a userspace
>> second-level trap handler equivalent to what KFD provides for compute.
>>
>> On dGPUs the CWSR TMA buffer is placed in VRAM and accessed via MMIO
>> (PCI BAR). Raw CPU pointer dereferences are unsafe on platforms that
>> lack full load/store support for MMIO. Replace void *tma_cpu_addr with
>> struct iosys_map tma_map and use iosys_map_wr() for all TMA writes.
>>
>> Writing TBA and TMA as two separate stores creates a race where a
>> trapping wave can observe a mismatched pair. For user queues, evict all
>> queues and flush the GPU TLB before writing, then restore queues after.
>> For kernel queues, wait for the VM to be idle via amdgpu_vm_wait_idle()
>> before eviction and the descriptor write.
>>
>> Evict user queues in amdgpu_trap_free() at file close. Without eviction
>> a freed TMA BO can be accessed via a stale TBA, causing a GPU page
>> fault.
>>
>> Export amdgpu_userq_restore_all() for immediate queue restore after
>> SET/CLEAR without waiting for the eviction fence.
>>
>> Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr().
>> SET_L2_TRAP returns -EINVAL if TBA or TMA BO does not have this flag.
> Works for me, Timur/Natalie/Samuel any objections to that?
>
>> The old TRAP ioctl and its internal handler are removed. The new
>> SET/CLEAR path is exposed via the VM ioctl in a later patch.
>>
>> SET_L2_TRAP is per-VM (per-process). Each process has its own TMA buffer
>> allocated in amdgpu_trap_alloc(). There is no conflict between processes
>> on user queue VMIDs.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 ++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>>   include/uapi/drm/amdgpu_drm.h             |   2 -
>>   7 files changed, 285 insertions(+), 91 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index a93ee106ab92..6473faf18d71 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> -	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
>>   	/* KMS */
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 47e4680db797..559c9222fc48 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>   	}
>>   
>>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>> -	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>> +	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
>>   
>>   	if (pasid)
>>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> index 31f653ec3fb1..3313bc099cf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> @@ -19,12 +19,23 @@
>>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>    * OTHER DEALINGS IN THE SOFTWARE.
>>    */
>> +#include <linux/iosys-map.h>
>> +#include <drm/ttm/ttm_bo.h>
>> +
>>   #include <drm/drm_exec.h>
>>   
>>   #include "amdgpu.h"
>> +#include "amdgpu_gmc.h"
>> +#include "amdgpu_userq.h"
>> +#include "amdgpu_vm.h"
>>   #include "cwsr_trap_handler.h"
>>   #include "amdgpu_trap.h"
>>   
>> +/* First-level TMA layout shared with second-level trap handler ABI */
>> +#define AMDGPU_TRAP_L2_TBA_INDEX	0
>> +#define AMDGPU_TRAP_L2_TMA_INDEX	1
>> +#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
>> +
>>   extern int cwsr_enable;
>>   
>>   #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>> @@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	struct amdgpu_trap_obj *cwsr;
>>   	struct amdgpu_bo *bo;
>>   	struct drm_exec exec;
>> +	void *cpu_addr;
>>   	int r;
>>   
>>   	if (!amdgpu_trap_is_enabled(adev))
>> @@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   
>>   	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
>>   				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
>> -				    &cwsr->tma_cpu_addr);
>> +				    &cpu_addr);
>>   	if (r)
>>   		goto err;
>>   
>> +	/*
>> +	 * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
>> +	 * may be placed in VRAM and accessed via MMIO (PCI BAR). Check
>> +	 * TTM_BO_MAP_IOMEM_MASK to select the correct write accessor.
>> +	 */
>> +	if (cwsr->tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>> +		iosys_map_set_vaddr_iomem(&cwsr->tma_map,
>> +					  (void __iomem *)cpu_addr);
>> +	else
>> +		iosys_map_set_vaddr(&cwsr->tma_map, cpu_addr);
>> +
> Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need an iosys_map.
>
>
>
>>   	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>>   	if (r)
>>   		goto err;
>> @@ -433,6 +456,29 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	return r;
>>   }
>>   
>> +void amdgpu_trap_clear_l2_handler(struct amdgpu_vm *vm,
>> +				  struct amdgpu_trap_obj *trap_obj)
>> +{
>> +	if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
>> +		return;
>> +
>> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> +
>> +	/*
>> +	 * Zero TBA first to disable dispatch before clearing TMA.
>> +	 */
>> +	iosys_map_wr(&trap_obj->tma_map,
>> +		     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, 0);
>> +	dma_wmb();
>> +	iosys_map_wr(&trap_obj->tma_map,
>> +		     AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64), u64, 0);
> It's most likely a good idea to grab the reset lock around all iosys_map_wr() as well.


Thanks Christian. May I kno pls, do you mean taking the existing 
reset-domain lock around the complete TMA descriptor update (all 
iosys_map_wr() calls and the final barrier), or only around each 
individual write?


>
>> +
>> +	trap_obj->l2_tba_addr = 0;
>> +	trap_obj->l2_tba_size = 0;
>> +	trap_obj->l2_tma_addr = 0;
>> +	trap_obj->l2_tma_size = 0;
>> +}
>> +
>>   int amdgpu_trap_validate_params(struct amdgpu_device *adev,
>>   				struct amdgpu_trap_params *trap_params,
>>   				int num_xcc)
>> @@ -464,6 +510,7 @@ int amdgpu_trap_validate_params(struct amdgpu_device *adev,
>>   }
>>   
>>   void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +		      struct amdgpu_userq_mgr *uq_mgr,
>>   		      struct amdgpu_trap_obj **trap_obj)
>>   {
>>   	struct amdgpu_bo *tba_bo;
>> @@ -473,32 +520,41 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   
>>   	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
>>   		return;
>> +
>> +	/*
>> +	 * Evict all user queues before freeing. At file-close time waves
>> +	 * may still be active; without eviction a wave can trap into the
>> +	 * handler after the TMA BO is freed, causing a GPU page fault.
>> +	 */
>> +	if (uq_mgr)
>> +		amdgpu_userq_evict(uq_mgr);
>> +
>>   	tba_bo = adev->trap_info->isa_bo;
>>   	tma_bo = (*trap_obj)->tma_bo;
>>   
>>   	if (!tba_bo || !tma_bo)
>>   		return;
>>   
>> -	drm_exec_init(&exec, 0, 0);
>> -	drm_exec_until_all_locked(&exec)
>> -	{
>> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>> +	drm_exec_until_all_locked(&exec) {
>>   		r = amdgpu_vm_lock_pd(vm, &exec, 0);
>> -		if (likely(!r))
>> -			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
>> -		drm_exec_retry_on_contention(&exec);
>>   		if (likely(!r))
>>   			r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
>> +		if (likely(!r))
>> +			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
> Please don't do such hacks. drm_exec_retry_on_contention() should be called after each drm_exec_lock_obj() call and if (r) goto error handling used here.
>
>>   		drm_exec_retry_on_contention(&exec);
>>   		if (unlikely(r)) {
>>   			dev_err(adev->dev,
>>   				"failed to reserve CWSR BOs: err=%d\n", r);
>> -			goto err;
>> +			goto out;
>>   		}
>>   	}
>>   
>> +	amdgpu_trap_clear_l2_handler(vm, *trap_obj);
>> +
>>   	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
>>   	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
>> -err:
>> +out:
>>   	drm_exec_fini(&exec);
>>   	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
>>   	kfree(*trap_obj);
>> @@ -509,120 +565,186 @@ static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
>>   					  struct amdgpu_vm *vm,
>>   					  struct amdgpu_trap_usr_addr *usr_addr)
>>   {
>> +	struct amdgpu_bo *bo;
>>   	struct amdgpu_bo_va_mapping *va_map;
>> -	uint64_t addr;
>> -	uint32_t size;
>> -	int r;
>> +	u64 addr;
>> +	u32 size;
>> +
>> +	/*
>> +	 * Caller holds the VM root BO reservation; assert rather than
>> +	 * taking it again.
>> +	 */
>> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>   
>>   	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>>   	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
>>   
>> -	r = amdgpu_bo_reserve(vm->root.bo, false);
>> -	if (r)
>> -		return r;
>> -
>>   	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
>> -	if (!va_map) {
>> -		r = -EINVAL;
>> -		goto err;
>> -	}
>> -	/* validate whether resident in the VM mapping range */
>> -	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
>> -		amdgpu_bo_unreserve(vm->root.bo);
>> -		return 0;
>> +	if (!va_map)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * TBA/TMA BOs must be VM_ALWAYS_VALID. The GPU jumps to TBA on
>> +	 * hardware exception without any software job submission, so the
>> +	 * kernel cannot add TBA/TMA to a job's used-buffer list to keep
>> +	 * page tables current. Without VM_ALWAYS_VALID the BO can be
>> +	 * evicted and the page table entry becomes stale, causing a GPU
>> +	 * page fault or memory corruption on the next shader exception.
>> +	 */
> That comment is not correct. This would work completely without AMDGPU_GEM_CREATE_VM_ALWAYS_VALID.
>
> Please just completely drop it.
>
>> +	bo = va_map->bo_va->base.bo;
>> +	if (!(bo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)) {
>> +		dev_dbg(adev->dev,
>> +			"TBA/TMA BO at VA 0x%llx must use VM_ALWAYS_VALID\n",
>> +			usr_addr->addr);
>> +		return -EINVAL;
>>   	}
>>   
>> -	r = -EINVAL;
>> -err:
>> -	amdgpu_bo_unreserve(vm->root.bo);
>> +	if (addr >= va_map->start && va_map->last - addr + 1 >= size)
>> +		return 0;
>>   
>> -	return r;
>> +	return -EINVAL;
>>   }
>>   
>> -static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> -					   struct amdgpu_trap_obj *cwsr_obj,
>> -					   struct amdgpu_trap_usr_addr *tma,
>> -					   struct amdgpu_trap_usr_addr *tba)
>> +int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
>> +			       struct amdgpu_vm *vm,
>> +			       struct amdgpu_userq_mgr *uq_mgr,
>> +			       struct amdgpu_trap_obj *trap_obj,
>> +			       u64 tba_va, uint32_t tba_sz,
>> +			       u64 tma_va, uint32_t tma_sz)
>>   {
>> -	uint64_t *l1tma;
>> +	struct amdgpu_trap_usr_addr tba = { .addr = tba_va, .size = tba_sz };
>> +	struct amdgpu_trap_usr_addr tma = { .addr = tma_va, .size = tma_sz };
>> +	long timeout;
>>   	int r;
>>   
>>   	if (!amdgpu_trap_is_enabled(adev))
>>   		return -EOPNOTSUPP;
>> -
>> -	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
>> +	if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
>>   		return -EINVAL;
>> -	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
>> +
>> +	/*
>> +	 * Wait for any kernel-queue work using this VM to drain before
>> +	 * evicting user queues and writing the new descriptor. Without
>> +	 * this wait a kernel-queue wave can observe a partially-written
>> +	 * TBA/TMA pair during the update window. SET fails if the wait
>> +	 * is interrupted or times out so the caller can retry.
>> +	 */
>> +	timeout = amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
>> +	if (timeout <= 0)
>> +		return timeout < 0 ? timeout : -ETIMEDOUT;
>> +
>> +	/*
>> +	 * Evict all user queues before updating TBA/TMA. Writing TBA and
>> +	 * TMA as two separate stores creates a race: a wave that traps
>> +	 * between them reads a mismatched pair. Evicting first ensures no
>> +	 * wave is active during the update.
>> +	 */
>> +	amdgpu_userq_evict(uq_mgr);
>> +
>> +	/* Flush GPU TLB to remove stale cached TBA/TMA values */
>> +	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> +
>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>>   	if (r)
>>   		return r;
>> -	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
>> +
>> +	r = amdgpu_trap_validate_user_addr(adev, vm, &tba);
>> +	if (r)
>> +		goto out_unreserve;
>> +	r = amdgpu_trap_validate_user_addr(adev, vm, &tma);
>> +	if (r)
>> +		goto out_unreserve;
>> +
>> +	/* Zero TBA first to disable residual handler, then TMA, then TBA */
> That doesn't seem to make sense. Why should that be necessary.

I added the initial TBA=0 wrtie defensively to avoid exposing a stale 
descriptor during the update. Since execution is quiesced before 
updating the TMA, it isn't necessary, I'll remove it and place the 
barrier after the final TBA/TMA write.

Thanks, Srini


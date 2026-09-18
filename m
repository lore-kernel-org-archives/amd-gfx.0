Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFEAC982D2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 03:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59C510F15A;
	Fri, 18 Sep 2026 03:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r7NXx43m";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949C510F15A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 03:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5AM2q7VP01kz4jiFJWEqRkLYp1euxzWLeRV1wIKBOk5eD746ouesx4nKp0xK6T4yQMqs3k4NRNcuZLfTZivI/ahg52/vcjQkYvzA5iZQ+iGYu2YfcG3uEI7tdSNiQ9O6busZqg96ETD5Lqs6GXVhbGIn452tvvqog7SH8nbxIZMpWxV88G9SwLFEoi+NLGSQw3/l+vg3U8VuNJQ6H0yy90j8FMkKKgQ8MT1+JX4UYUX3z7yt4L7P67BOtKByZU4He3RCG8wB3e/9mZQtGYopA4y/B8h5AFQL6S3aM/4S1G9MghNVfuKm2+brGRT+Du6m7F6AydJj6y7OKUYsigDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tnl8by51xa6OhS/fXinaak3A/qIC07Iq4uu0HOsiTmo=;
 b=xZotdKvcgXQ3Xo9DwnSDHsrPdrd/37LdxFHC87vROCDidNQVETfwL8R0HRYumYI0Wwkm8aJMIjUxREbDaSMr9OrxIfDxmEGVASZyTCNESYynSZLS0XfENTtaho31nOlK0FGDdJotj2A1lkhbspgbRYz+P//lx2+D5kqyLyX2neOafhqPWsQdflByU8ncC+iGuYe33xAQs9Xyi0DSGIBZX1iR7FdDfzXUsB5Ee6gKh7JA4PmlYDEywSyfToCAADIU3SJ2kLYvVyN8ILbIceJG2UtC+c1zpCOf31o8NoirCKh6Y6O5FJJz9w0cKJeC5VD4QRWmf8dHgHljzFQUe5Sp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tnl8by51xa6OhS/fXinaak3A/qIC07Iq4uu0HOsiTmo=;
 b=r7NXx43mXATOGQfKlkNcOJ7DHeXb+7bzhm/nQhnEfjOaq9a0Ozsnk/UB3A6KGXFGM7L6ZejtLZ1vDlSf+xthkyEd+6cGNeKNqurh9gLcj+50rA0XHLfFfslwEPsPjQ8zJCdnTEiLH+kFVbTBwAWz50YwyhdMTrOz1i7D/08UMB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 03:43:39 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:43:38 +0000
Content-Type: multipart/alternative;
 boundary="------------QvJgYVdP55072Q3JiB0dMLxw"
Message-ID: <e25c9ad5-a211-44d5-9b71-9e403dfb7426@amd.com>
Date: Fri, 18 Sep 2026 09:13:33 +0530
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
X-ClientProxiedBy: MA5P287CA0059.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::10) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f065a99-72a0-47f6-621c-08df15370657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006|3023799007|4143699003|6133799003|8096899003;
X-Microsoft-Antispam-Message-Info: vqWkZvN5s84z/o/2r5qtXlX+3iKSjjMH0c3yq0s+v875ohAKfGhwJF4IYRDL/Fz0sUWN9J79rTVw4pMkrScx4oAJ4a0UC4UpuTkOcTlEe+DOlwIvthKvpVRu0iwArmCG3MYWlPbmYiCmxNXfVHUfcvS6bfAhBnU8HEh8NNkGgXazz6jO5+Pghsot6seLUUVwvwlscL8Di+uZQO6EbdglpApwOZg6IRMi6XYBGP4eniGWQdpMvHsStA6ee0y43CexKKDmPyYWoH6SMKNYI8cKitDk2TR8Br1GMwGeS6FxCn8J+b7bVeBhLiXUZVlFIMe9QB6PLZ6Yf9qylYa80iIMYmVhfQ488BF7PBqh1Oj8e/SSSymH5QsM5n9ta03PeLzEnvf7o1pEMzOlhKBRFOGgaZy+NSy1/i1bq+ZdlbCK2HaOXgKuHiIpQUu4CSpAQTCQhfQ5jUNZmGfEu7JaVYaIAgLI4t8WdgDmW1flW/dEwAHqEopm9aavMjgpIJmFtd9FMfuOIv56iF+AZF4EVKrfJvinFblZ6yVB0PC2qNk3WiYkdD0w8Wg/x3W3rA/RVp8BDqPgrVFZZoWc08B2oZ5oKCYE6C+/7BGUJ8uULF0wMZ4VFVrGQPYCPaj9Gwso0hSGhVEBJRZ7EjkenrfkiaHpyaStSY7edRFd2oqTlwOYOXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(3023799007)(4143699003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnhGR1d2UEpLK3F5N2FuMmFKY0ZiNUZXNUFHTExRSUtESnU5cHpLS2tvaURV?=
 =?utf-8?B?ZThJeU4vL2N6UFdXM2JhMGo2VmxRbHRiTWFOTUFXSzlvR0s4bHlIVGpOZ055?=
 =?utf-8?B?dXZ6SjF2RHY3OGtTWWZHOXFCc1VTeDZlR29VV3pndWpxY2ZaWDZlZG1ia2l1?=
 =?utf-8?B?bFFqeFVTQ1A1cVB5ZVJVZENuQWVPSHpMUXV5Y1NOZUNtK2xpZThjZi9ab21o?=
 =?utf-8?B?K1JrMERocHByZUpLcUxRNFljdncwVTZ6R210K09Gb2lFWDVFOUVxdXREOXRF?=
 =?utf-8?B?R2FUK096Ym5Ic3I5UFF5Wlhyd1MxU25zYmplK2Y2RFh0U3Nmd1lrT2YxenFG?=
 =?utf-8?B?WWtFYncxYUsvOFU4SXpyWHZRQ3VnWElsSmJ0TTFGay9ETkJoTmVXMUdrRTFt?=
 =?utf-8?B?bGZsdVAwT0k4cnRMaFJrYW1xdmtRNXJnano2cDYrTDR1Y3RRVWxNN2d0SUVI?=
 =?utf-8?B?azdFY2tYTWYvRTJhVUtwWnF6SUo3RFpyL2ZxZVpmQTM1cU81QklpSjZMeWxp?=
 =?utf-8?B?Vys3dWVNME9na1U4SFhndHIyZGtFWUNta0E3Z0ZSdHJPUy9PQTdXN013RWZz?=
 =?utf-8?B?ZkJ1RnFwSzZXUit6UEdVSGRVcFlmZnhjQVlDbndWd1gxRGtsVzRHWklGV1lS?=
 =?utf-8?B?dVAzVU1GaWRKWTUydjFqMXBPbnBCeTJXbjY1LyttclFhdm1yOXpaYVAvMXox?=
 =?utf-8?B?M0VaTmhTNWU0U3ZvMUxaUnl2MU9rWjhIdCtjRXFzTE5hblEzUUM5clJlSGVO?=
 =?utf-8?B?b3NNM05MSTZxayt5bGs4UlU0eWVObjh4SG1kR0k1V3EyZjJNbG5jbDcySlY4?=
 =?utf-8?B?WHNpOUQ5ZWZOaEdjbEhScmhmR1ZxMElCUnhHQnY3RUpxUVRENjZMMElEZUtK?=
 =?utf-8?B?VUNUM05tOU43RDNQSnJuZFRKQ0RYRlN4TGxCMmdMWlVFQk5yVjNnRUpUOWRi?=
 =?utf-8?B?eEQvdUNqNVJmdWtwMUxjVGpBRnNTc1J1Uy90c0I1RVkrSlAxWG5wRWV5OEE5?=
 =?utf-8?B?Q3FHN2d2SEgzOUV6SndWOVFLNWg2dy9ieGgrMXMybVBsc1ovNDBUc2dYSmdj?=
 =?utf-8?B?dzYwZjBJSm9ZcVFkcVRVc0JtUjR4b2NHL2RjS0lyMzVoMmc0VlB4c3ZBRVpO?=
 =?utf-8?B?K1Q2L0NFRFRrT05lQUNNTTAzenRuWlBDV2xjUUlkaUwxM0RqUmRPN1A2VmJl?=
 =?utf-8?B?ZXpQRWpSR3RMcGZBTCtvSnB1RlZNZTZRNlp5dmkvdHN6eUxpd3hxa01Ib2E2?=
 =?utf-8?B?SklFV0RpSlNlOXhNMVpoUUcrWUJteUlXNnU3cVR5ZCtsTWl5RGwrZ3lCNzRh?=
 =?utf-8?B?RFVnUk9UUWFJQ011SitHb3k0T1k3TVF4TlJXTWhPQlNaV0lWdkp4TFR1ak54?=
 =?utf-8?B?YkNUVHZTdGJWMGpRWndPTzcyRkpabm9LdDhCdHFERkpBMHJla2s3aENEV1E3?=
 =?utf-8?B?VEZqUWErc1IySk1Da0g3Mjd5cDN2TWVhUU9pTWV3OEhoQWxDVlA2MnNDQjIx?=
 =?utf-8?B?ckM3S0pKOEY1alFBaWZacFdYaVFaZlRENHFibzRmdUp6ZG9MZmI4UkRRM09E?=
 =?utf-8?B?dTNwR05KMWVzZVBNNGFxeG1RYnQwTStvYW9qc3dpUWFTckczRFBIa0FjQjFN?=
 =?utf-8?B?Z0k0b2x4WldXOTkwcFRlbkVjT1M0VFlpWkxwS3I3K0tMOUJib3dkUkw3NGk0?=
 =?utf-8?B?b0t3N1NRYXpYdVM3NytEaGl5Zk9WQjRFdktnYmU5WUF2d0EramxLcFp6Z2tZ?=
 =?utf-8?B?NzBsUnFzL0cxai9hb2R3RHlpajFkNGdhTTFyZHA5OWVBR3FsTkJSSUcyZHhi?=
 =?utf-8?B?a1NZUEg2MktYQmtLQjlBWXN2bE8vNVVGdmFmb0ZSVm0zR24zdmN0Q3FKbEor?=
 =?utf-8?B?WExGT0dveVRSdnQ3UlFzTmFISE9HaVBxTWQ3MFlDQjlnWExrSHh5ejFsMzN2?=
 =?utf-8?B?T3RtbzlYSUJOMis4d0xOTjNXQ2ZiZnRnRW1uODl3Qk1MNjBYODB6UWx4S2RG?=
 =?utf-8?B?ZEpxR0lwYlA3amZNMExzVkhGMTB1ZlFXdFpYdnRmRzYyRmRTVFBXaDVwWEJX?=
 =?utf-8?B?cjUxY0dZQmNiVi9CcWUzbUY4bFZ3UnAvTXo4TlI0ZERjYkpyclF0WXB0Y1U4?=
 =?utf-8?B?andaL243ejl6NHBCMStvQnBsNVprdUVxSjRuRXVxTWx4M3VRWUFrWXYxVkFa?=
 =?utf-8?B?K0htaGZyODVTUllGN1l2eGI3bUY3WTVJTUxEYkdoNVdhdnRJd3htSUM1NzNY?=
 =?utf-8?B?aDA4WGRwYzRPR1N3WHVRMFhiajBPam1qdzdsK3ZUNngvZjVwR2pqQjRMWkp2?=
 =?utf-8?Q?NtpeR93yrVlxL35j/H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f065a99-72a0-47f6-621c-08df15370657
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:43:38.7595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDva5/h+1VMaOPcKU3czf0MLjvH58qz4BTMo0e0JDMN30wUjYpLOM2CSCaANvz86HNIVwMobrMqIWrf3HBd/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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

--------------QvJgYVdP55072Q3JiB0dMLxw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


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
>> Cc: Christian König<christian.koenig@amd.com>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Cc: Felix Kuehling<felix.kuehling@amd.com>
>> Cc: Lijo Lazar<lijo.lazar@amd.com>
>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
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

Hi Christian,

Thanks. One clarification regarding using |ttm_bo_vmap()| here.

The per-VM TMA BO is unpinned and can be moved/evicted. Currently 
|amdgpu_bo_move_notify()| calls |amdgpu_bo_kunmap()|, so the existing 
|amdgpu_bo_kmap()| mapping is dropped before a move.

If we replace it with |ttm_bo_vmap()| and keep the returned |iosys_map| 
in the trap object, should we also handle unmapping/remapping it across 
BO moves, or would you prefer mapping it only around the TMA accesses?

Thanks,
Srini


--------------QvJgYVdP55072Q3JiB0dMLxw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/16/2026 8:14 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f7edaea8-f172-4573-952f-6a85d1302d8f@amd.com">
      <pre wrap="" class="moz-quote-pre">Hi Srini,

please keep Timur, Natalie and Samuel on CC.

On 9/16/26 07:37, Srinivasan Shanmugam wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Render-node user queues had no mechanism to install a userspace
second-level trap handler equivalent to what KFD provides for compute.

On dGPUs the CWSR TMA buffer is placed in VRAM and accessed via MMIO
(PCI BAR). Raw CPU pointer dereferences are unsafe on platforms that
lack full load/store support for MMIO. Replace void *tma_cpu_addr with
struct iosys_map tma_map and use iosys_map_wr() for all TMA writes.

Writing TBA and TMA as two separate stores creates a race where a
trapping wave can observe a mismatched pair. For user queues, evict all
queues and flush the GPU TLB before writing, then restore queues after.
For kernel queues, wait for the VM to be idle via amdgpu_vm_wait_idle()
before eviction and the descriptor write.

Evict user queues in amdgpu_trap_free() at file close. Without eviction
a freed TMA BO can be accessed via a stale TBA, causing a GPU page
fault.

Export amdgpu_userq_restore_all() for immediate queue restore after
SET/CLEAR without waiting for the eviction fence.

Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr().
SET_L2_TRAP returns -EINVAL if TBA or TMA BO does not have this flag.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Works for me, Timur/Natalie/Samuel any objections to that?

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
The old TRAP ioctl and its internal handler are removed. The new
SET/CLEAR path is exposed via the VM ioctl in a later patch.

SET_L2_TRAP is per-VM (per-process). Each process has its own TMA buffer
allocated in amdgpu_trap_alloc(). There is no conflict between processes
on user queue VMIDs.

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Cc: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
 include/uapi/drm/amdgpu_drm.h             |   2 -
 7 files changed, 285 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a93ee106ab92..6473faf18d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 47e4680db797..559c9222fc48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&amp;fpriv-&gt;ctx_mgr);
-	amdgpu_trap_free(adev, &amp;fpriv-&gt;vm, &amp;fpriv-&gt;trap_obj);
+	amdgpu_trap_free(adev, &amp;fpriv-&gt;vm, &amp;fpriv-&gt;userq_mgr, &amp;fpriv-&gt;trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd-&gt;tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 31f653ec3fb1..3313bc099cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -19,12 +19,23 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
+#include &lt;linux/iosys-map.h&gt;
+#include &lt;drm/ttm/ttm_bo.h&gt;
+
 #include &lt;drm/drm_exec.h&gt;
 
 #include &quot;amdgpu.h&quot;
+#include &quot;amdgpu_gmc.h&quot;
+#include &quot;amdgpu_userq.h&quot;
+#include &quot;amdgpu_vm.h&quot;
 #include &quot;cwsr_trap_handler.h&quot;
 #include &quot;amdgpu_trap.h&quot;
 
+/* First-level TMA layout shared with second-level trap handler ABI */
+#define AMDGPU_TRAP_L2_TBA_INDEX	0
+#define AMDGPU_TRAP_L2_TMA_INDEX	1
+#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
+
 extern int cwsr_enable;
 
 #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
@@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_trap_obj *cwsr;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	void *cpu_addr;
 	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
@@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT, &amp;cwsr-&gt;tma_bo, NULL,
-				    &amp;cwsr-&gt;tma_cpu_addr);
+				    &amp;cpu_addr);
 	if (r)
 		goto err;
 
+	/*
+	 * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
+	 * may be placed in VRAM and accessed via MMIO (PCI BAR). Check
+	 * TTM_BO_MAP_IOMEM_MASK to select the correct write accessor.
+	 */
+	if (cwsr-&gt;tma_bo-&gt;kmap.bo_kmap_type &amp; TTM_BO_MAP_IOMEM_MASK)
+		iosys_map_set_vaddr_iomem(&amp;cwsr-&gt;tma_map,
+					  (void __iomem *)cpu_addr);
+	else
+		iosys_map_set_vaddr(&amp;cwsr-&gt;tma_map, cpu_addr);
+
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need an iosys_map.</pre>
    </blockquote>
    <p>Hi Christian,</p>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
        <p>Thanks. One clarification regarding using <code>ttm_bo_vmap()</code>
          here.</p>
        <p>The per-VM TMA BO is unpinned and can be moved/evicted.
          Currently <code>amdgpu_bo_move_notify()</code> calls <code>amdgpu_bo_kunmap()</code>,
          so the existing <code>amdgpu_bo_kmap()</code> mapping is
          dropped before a move.</p>
        <p>If we replace it with <code>ttm_bo_vmap()</code> and keep
          the returned <code>iosys_map</code> in the trap object,
          should we also handle unmapping/remapping it across BO moves,
          or would you prefer mapping it only around the TMA accesses?</p>
        <p>Thanks,<br>
          Srini</p>
      </div>
      <br>
    </p>
  </body>
</html>

--------------QvJgYVdP55072Q3JiB0dMLxw--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92703C982D2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 04:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147DF10E42F;
	Fri, 18 Sep 2026 04:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ux8TOw6A";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B252410E42F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 04:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwwY0SKDBU8ERnORJ7utZ3h0RCE536HgfPJ6zLDIdtABw2and6WS8NrSARQepCaXcK+df42QpZ1+kPDJqMimj98OXelL/lKDkNRPCUISWa+2t1Lw7GdxPxRqkrj9L5zqieoBHYCLtrzfHC+vZT+XF785ntnZQ6HlLPDiA4iTUwhH/x6DEafz5dDVSLzPZcfnvrMRznWUvht+HTXSmJj9vJxy8XQwKgPq35K5fS3KR9xLOKlwG7JEiTD5iNupN+/HF+7jJPu58S0b4HWBL59X/e+hIHESZyGlSpkT3jDHjpkzmC895Pi0f+pRYzhBisrk8I1eHx+L7+2pdvTgUeYL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDYQRYR1ZV7NSjGXZs0dlR4doRVnXtvF6eVp3W06LpM=;
 b=vAj2xQwl997S+E8JJrucV/pb0Jfj5fMiy2rUcRycqFCvK8C9BWmWD8QCEEq5nkvsgCRTvqVjn2cXD7qiOtC0j5fPNH1lyTNz+CNlbavUSnZfvlx3vp9V0xCgbAUUjCMJVatXGFn41emDqtwPFsUbsb44/TT2rvB3LUOFtaDxWATRCUbqctw40W3l1N24DVleJPIPCXxkGy/GL8TATZPnXAFpt+KHSXeXKuM48bAJLUcMRIe+V3bBsAtJGxHq9a7G1vYkeGK5iWA4CEpciSCWXdhAlUU3k6AR9NBvBCYxhvOqRf33ZnptET2qMAJ04WJUuCBiLWXvcAeBQKx8LTDMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDYQRYR1ZV7NSjGXZs0dlR4doRVnXtvF6eVp3W06LpM=;
 b=Ux8TOw6AdDWDPsYuyp0l+biiT/0QIQ29Jvt/ubGWlXZhkOkbIZt8TnP4Ue8uPtFzx/EVL2wQ4TjDFgqEvnQK7/SM+urjbgvT0Hq9E/7ciJnKyuVJyase15pwmhwcA3DwAC4lcj7f0mYBaS3/XqrJrNhHDK21K/UWQyjkBnxgZSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS2PR12MB9800.namprd12.prod.outlook.com (2603:10b6:8:2b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 04:09:07 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 04:09:07 +0000
Content-Type: multipart/alternative;
 boundary="------------vPJC4WfVhbz300jg1YXWWCRe"
Message-ID: <2bff4151-c6c5-493d-9ad7-c7d886cc7dc8@amd.com>
Date: Fri, 18 Sep 2026 09:39:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Add second-level trap handler
 infrastructure
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
In-Reply-To: <e25c9ad5-a211-44d5-9b71-9e403dfb7426@amd.com>
X-ClientProxiedBy: MA5PR01CA0287.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::19) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS2PR12MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: cff9a27a-f0b5-4502-aba9-08df153a9562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003|8096899003|3023799007;
X-Microsoft-Antispam-Message-Info: gj7ZsQ1ZwU8N9cgoIClw+uCITdjP1Iv9sVIe6X0c15DfFGNEjP71bE9/Gh5qJlXuZiHgRoZgql7gQwVaOERZIp1bFyV7DbTQN61QEa32NEYKyeBGWdXzCxDmVhZs8CeNolJtcd4X+p+plfevhwW9o6OQwFWJvn/f994FXigbZHSqouwrywZOnb8J72Vy56aqWCFutYO7ia9QZyNtwDJsBhAnF8n/mNqmGJdnqgG58nD7Z9h2EHXc7LTgvLNKV5pe6WsX/jdXIfQBEpjs2CoZrZ0vaemA5iiltzxrRmesvbiQKY/2rS79VTJQdpIdZ97rsvGr7vlEveAlTM6Mr1NnJ8tviox+48JlWr3JCH2ltxHCJbvDMs1caQTTqM4oKoHx55KdM6ElwIj7kMjDb5MLjg/Ptvi3vhOseW1GlD0SmVLAldcpBW6xiNAYRFFHkO/pmy2VNrjDHx/8zdlrcvUvvHuh9zExxYpV3gmX/9/zzWDkvb42oNpLjAEbatCqO4/q+r9etiZrJ9AOby9O4mbfFlH10muXzq0sbZ3Q1YnIp59pXp5X0zLhSHPBi1tvEt/PxClOcNpVv+hvB/OOD+GErLjwjmtAr++TlYRCmNGVV8A9cfzlcX1KalCDbpn6e9KiJnecA64VL+x4Tgb86JlzR874Gpc1KsW8Hkjg2sidgtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ByenZmekQzeUZWbElqd2hvZ0JCT1Vlcnp1anBQR3pEQS8rbkhNclRDSi90?=
 =?utf-8?B?K3FXSzdXR2x0dnArQzVrSHV5QndBaG0wVnFyMTluZ2pjNTNwRnhFUkpoUFZM?=
 =?utf-8?B?Sk8yb0pHSVMyMlExWDBmbmtsZ3ZCUUcxeEJ2NmR1M1JjUUhNR3dScmtESTVs?=
 =?utf-8?B?M3dpaC9QZ05QWVQ2UlNYa0wxZjc2ajRIWkRnZjI2cDg2bk4rakZkdmt3MTRm?=
 =?utf-8?B?ak1Zc1hvUGpUb2MvaHNHNkttL1l0ekpsSDVhVmNpR0FRZUFqdnVZSk9Lelho?=
 =?utf-8?B?enR1NUZ6QkJXbU8vS1pYWVV0amd1NmhwVDF5Zm5ES200SlBoY3pnU3BkT0lp?=
 =?utf-8?B?SGZGOXpXTXF5dUVNK0JGWmtiQ0JWcHBLNjZSSWRTbHBQelhZOFMyZXZJTXgw?=
 =?utf-8?B?L0dvSWxhc1duUUpLVFBsUW9rdXdST20vNm4zdUZKTFAvRlJNRGluVDRaYlRh?=
 =?utf-8?B?K1d3MFYzSUlTbFhBQzZSbEtUa0JHb296SXNjUGtjZEpjalB6M0h6NTZIR1RX?=
 =?utf-8?B?LzJvQkpxbC9nUEhlQzg1RlFzOTFxWW5PVzZjMFdXVGljdWJBcVFWMHZkQ09w?=
 =?utf-8?B?MGw0QTRBeUhqYURhRllJemlDbG1uQW1pYXRTYVhyU1BqaHNRVjg2VjhKZlhM?=
 =?utf-8?B?Sk5hY3RGaVJBblcwL3Zwa1YvaVBaSzRsdUtNdi9CMUFPRS9EWUJmQW10NVFX?=
 =?utf-8?B?Nlo2UXRnTU5wekNTU25EOWs5QllIS2cvditZV1JiUzVvUnVoQ240NWU0aDc0?=
 =?utf-8?B?T2w1Rmh5SmtnYW5Gb2ZubkQzR1AxbGdUcmNCS0xWTWZwMGFmOU9vRWhYQWts?=
 =?utf-8?B?djZtZTFUbGp1c0U3Mld5aytJNFVBN0NVdSs3Qkxuem13S2dnK1RuMm12WldZ?=
 =?utf-8?B?aFh5UEdQOUlla1lmc0Q0anRZUFFBbTlvODBBRHpCaTF0WXg1TkJ1ellTOVF0?=
 =?utf-8?B?VjFpRmRseGllK2NON0NlYkYyVUJ4SGpwSlBFcGUrdHJ5TkRJeHZmYXpSaWFi?=
 =?utf-8?B?ZW9pVUtxcWY4dFkxaXp3RlNJRE85a3NEUHlWZGxhNkhqVkhIS1lIcDYyMWF2?=
 =?utf-8?B?QjFCdG9FTXN6anBHWjFTUmQ4RzdOeENIQzNnRWZGOC9CL3hQRDU5UVU0L25h?=
 =?utf-8?B?ZGtBRUxHWVk1ZlUrLzJjQXEzNTlNMjNhRnUrdU5nSjNGMDErcmttUjdjbzFV?=
 =?utf-8?B?U0piRWJwcHdudVVKUzY3d1ZobFpCbE9TYXplTkZwVTlqZ2tIclR3MjJEQ3Rk?=
 =?utf-8?B?aUVBY1dESUgrWjduQ1YzYzQ3S01LRXFMVE1waEdtRmZwVnJmQWk4Z2hXdmtE?=
 =?utf-8?B?enljOXcwNGtScWZVUzBOMUFjNjNKaGhUMUpUZ2ovL1BMMGdsZ2VDNnAzeVBh?=
 =?utf-8?B?cjQrL0V4blQzcERBYS93QVo3NGltejhaZUZYbzM0cWRwOER0RTkyVXZCUkJT?=
 =?utf-8?B?dllHOGQ4cnJyQ3hWb053Z1dxc2twbkw3VDkvUjZ0MTVkenRYS0xkTnp4Zmts?=
 =?utf-8?B?di9nSjI4alFXcmYzMnE4R3JUYTdLUzFoS2hmT3NrM2xoNTBKTWV4MU9KTUh5?=
 =?utf-8?B?UUNhc1EwQ0k4Um42V2daMVFrb1hEZEd0dUk2Y2E0cHFXMEJCT2tVcWd5RmRH?=
 =?utf-8?B?VDg1Mmg5RklEWmpaeE4xYys1Sm4ybFQ2NWc1cG5OQlFtdWcwblJlRzlSbE1M?=
 =?utf-8?B?QWtrZVVMOTZMYkF1SlNqVlV2d3F2eDRJZ29jV1VlNW80ZUZNazB1bkozcWI4?=
 =?utf-8?B?aCtGcVh5eUZMY3VRMW5GdXc1TGh2MlVXTm1za0Jscm0zTmJ4cmFRQmZ6QUF2?=
 =?utf-8?B?OW4wZktsSXNNQkVSVVdJRkhpUTFGZHRVeEZ3MTRpMXZCbUpaMDQzcWhobUdL?=
 =?utf-8?B?OWQ2TFZYSmpJU2NJbk9id2x4WDdHZ2paK3FrQ25CbitTMmVnVGp3R3k4am9Z?=
 =?utf-8?B?YVA5Y3VFS2svemc0Z1BTV0hvRXE3dnJ6VUJHbkQra3ZIOW5VMWV5eUNSQU9a?=
 =?utf-8?B?d0lxY2kzUTlZSGxmOXAyUTd3Z2tURzN0QWhpanRjeUNsMjhUcStzbER4NFBj?=
 =?utf-8?B?bXVzOUlOQjM2bXcybzcxdDUxejA5RlFKS1F2V0hXTGVzQlhBYlJXaVN1Y1Va?=
 =?utf-8?B?eTE2U29oZWtrK1VWdCtheTJZVmwyaEJldzFVeGxiMWZFclJ2QjdrMlRLYm0v?=
 =?utf-8?B?M000TCs2M093a0NhcGZTUFYvYnJuWTJKZml1RGxIOHZCbnlVNGFDUTIvR3Qw?=
 =?utf-8?B?VS9ndGROTDdFaEhnUDFwMW5rdlh6VTRtL1JrZ0UzeDg4RExPVlB4TCszV2Ey?=
 =?utf-8?Q?TPVS0TiOxeZ8dKy2++?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff9a27a-f0b5-4502-aba9-08df153a9562
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:09:07.0609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8DWLtppQi6NVOwIRJKf7nt647D6YW9okZrTC2P5ae8n8aM3eUjFWlHdAkG/saqjRAxuCuEPRBMUo/2JPOnnIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9800
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

--------------vPJC4WfVhbz300jg1YXWWCRe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/18/2026 9:13 AM, SRINIVASAN SHANMUGAM wrote:
>
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
>>> Cc: Christian König<christian.koenig@amd.com>
>>> Cc: Alex Deucher<alexander.deucher@amd.com>
>>> Cc: Felix Kuehling<felix.kuehling@amd.com>
>>> Cc: Lijo Lazar<lijo.lazar@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 ++++++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>>>   include/uapi/drm/amdgpu_drm.h             |   2 -
>>>   7 files changed, 285 insertions(+), 91 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index a93ee106ab92..6473faf18d71 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>>   	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>>>   	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>   	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> -	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
>>>   	/* KMS */
>>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 47e4680db797..559c9222fc48 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>   	}
>>>   
>>>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>> -	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>>> +	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
>>>   
>>>   	if (pasid)
>>>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> index 31f653ec3fb1..3313bc099cf4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>> @@ -19,12 +19,23 @@
>>>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>    * OTHER DEALINGS IN THE SOFTWARE.
>>>    */
>>> +#include <linux/iosys-map.h>
>>> +#include <drm/ttm/ttm_bo.h>
>>> +
>>>   #include <drm/drm_exec.h>
>>>   
>>>   #include "amdgpu.h"
>>> +#include "amdgpu_gmc.h"
>>> +#include "amdgpu_userq.h"
>>> +#include "amdgpu_vm.h"
>>>   #include "cwsr_trap_handler.h"
>>>   #include "amdgpu_trap.h"
>>>   
>>> +/* First-level TMA layout shared with second-level trap handler ABI */
>>> +#define AMDGPU_TRAP_L2_TBA_INDEX	0
>>> +#define AMDGPU_TRAP_L2_TMA_INDEX	1
>>> +#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
>>> +
>>>   extern int cwsr_enable;
>>>   
>>>   #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
>>> @@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>   	struct amdgpu_trap_obj *cwsr;
>>>   	struct amdgpu_bo *bo;
>>>   	struct drm_exec exec;
>>> +	void *cpu_addr;
>>>   	int r;
>>>   
>>>   	if (!amdgpu_trap_is_enabled(adev))
>>> @@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>   
>>>   	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
>>>   				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
>>> -				    &cwsr->tma_cpu_addr);
>>> +				    &cpu_addr);
>>>   	if (r)
>>>   		goto err;
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
> The per-VM TMA BO is unpinned and can be moved/evicted. Currently 
> |amdgpu_bo_move_notify()| calls |amdgpu_bo_kunmap()|, so the existing 
> |amdgpu_bo_kmap()| mapping is dropped before a move.
>
> If we replace it with |ttm_bo_vmap()| and keep the returned 
> |iosys_map| in the trap object, should we also handle 
> unmapping/remapping it across BO moves, or would you prefer mapping it 
> only around the TMA accesses?
>
Since the per-VM TMA BO is unpinned and movable, keeping the 
|ttm_bo_vmap()| mapping in the trap object would require us to 
invalidate/remap it whenever the BO moves.

To avoid maintaining a long-lived mapping for an evictable BO, I'm 
thinking of using |ttm_bo_vmap()| only around the TMA CPU accesses while 
the BO is reserved, and calling |ttm_bo_vunmap()| before releasing the 
reservation.

This should also avoid leaving a stale |iosys_map| after BO migration.

Does that sound like the preferred approach?

Thanks,
Srini


--------------vPJC4WfVhbz300jg1YXWWCRe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/18/2026 9:13 AM, SRINIVASAN
      SHANMUGAM wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e25c9ad5-a211-44d5-9b71-9e403dfb7426@amd.com">
      
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
        <pre wrap="" class="moz-quote-pre">Works for me, Timur/Natalie/Samuel any objections to that?

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The old TRAP ioctl and its internal handler are removed. The new
SET/CLEAR path is exposed via the VM ioctl in a later patch.

SET_L2_TRAP is per-VM (per-process). Each process has its own TMA buffer
allocated in amdgpu_trap_alloc(). There is no conflict between processes
on user queue VMIDs.

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a>
Cc: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com" moz-do-not-send="true">&lt;lijo.lazar@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com" moz-do-not-send="true">&lt;srinivasan.shanmugam@amd.com&gt;</a>
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
        <pre wrap="" class="moz-quote-pre">Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need an iosys_map.</pre>
      </blockquote>
      <p>Hi Christian,</p>
      <p>
        <style>@scope { a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
} }</style> </p>
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
      </div>
    </blockquote>
    <p dir="auto" data-start="1203" data-end="1377" class="PDq2pG_selectionAnchorContainer">Since the per-VM TMA BO is
      unpinned and movable, keeping the <code data-start="1272" data-end="1287">ttm_bo_vmap()</code> mapping in the trap object
      would require us to invalidate/remap it whenever the BO moves.<span aria-hidden="true" class="PDq2pG_selectionAnchor"></span></p>
    <p dir="auto" data-start="1382" data-end="1605">To avoid maintaining
      a long-lived mapping for an evictable BO, I'm thinking of using <code data-start="1467" data-end="1482">ttm_bo_vmap()</code> only
      around the TMA CPU accesses while the BO is reserved, and calling
      <code data-start="1554" data-end="1571">ttm_bo_vunmap()</code>
      before releasing the reservation.</p>
    <p dir="auto" data-start="1610" data-end="1680">This should also
      avoid leaving a stale <code data-start="1649" data-end="1660">iosys_map</code>
      after BO migration.</p>
    <p dir="auto" data-start="1685" data-end="1729">Does that sound like
      the preferred approach?</p>
    <p dir="auto" data-start="1734" data-end="1751">Thanks,<br data-start="1741" data-end="1744">
      Srini</p>
    <br>
  </body>
</html>

--------------vPJC4WfVhbz300jg1YXWWCRe--

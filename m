Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8387FC55182
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 07:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2271010E1CA;
	Wed,  5 Aug 2026 07:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVJfJQlh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C4810E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 07:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfYhE544eoWJfhlVsFxJxgk9ZlrtI+NE1YNl2FPKnFaTW5WAU5XhfMROlQKHTKaE8cLZqxilCW/G7ADjpq7jgpIc+EHY4u/V4VMuwmIUQdbF6YGYDKidEC4n/ao7vP080GN45Qen6dtmGpWMLcBEaqDrW8onGIHGh+udB0b5zsBkgiY8FQEDqKLkQArgIfhXtVr46FJ6yk7lPDDrHEBauH43xqgqgbA5jMZJutzL767FDu17sPaA9yKFEPOR8nWTy0Xbr08Gf4MEqpsMHkNLp+eJEBzIqqZkvu1iRuxkIgeu3Nfsexi9BDIoDpadg4tTfLHR5sUklq+zCRI32j3yDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl69IX/7CnWC1OX5YINGYmP96rER+4rrV5tuBE7mYbc=;
 b=JV5HgcBtFkiMtkmsODrnaCeBjmcuXQgjquUpZeUk6vgtnz4Vu/vHafL+GtjrYake1h9yTSgoq01d4nm3dEhoW4gdxdQwmbyPXffWKxlOFFOefS0LQ4ySux8/hq6QUG3f+z2674/OtNAz0W0Fct0O4i979w7g5GMODqRY52lO9DEvMB2/o+ve+AlQn277WbkGKfGkIxn6zOrgSeoUkhsn0MDQ6QBW/C6HJF9iNBWluNFU/HNkfveOrcZcmgqyDByx3oyvbGS8NKRy3c3MRiOD80kojFhH1XmrpeAb4BrJrFix+J7fqblT+yILbMW3BA/W0lZ03s0u1Gt44je3sh1e7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl69IX/7CnWC1OX5YINGYmP96rER+4rrV5tuBE7mYbc=;
 b=uVJfJQlhSIS4nLOZW4vf73YGGq54yrEIjdtH7K8ZbDISO6u4GB8B2QwglI5YqZST+vh35I7Z1dXZiJpRVoqUz6Yv1mFTXYFqUDIbYWcASbWEdQbBGgzJOoJNr+FXtkK4tOM/ySps0b4UMb2axBiCn1S/0aAFNsHkNVeWvLxU+/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 07:53:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 07:53:09 +0000
Message-ID: <d8d7a3e2-0515-453f-b995-2e18d8591712@amd.com>
Date: Wed, 5 Aug 2026 09:53:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260727084238.3396808-1-Jesse.Zhang@amd.com>
 <84e4330b-1ea5-4499-a9a8-672f2a12c70f@amd.com>
 <DM4PR12MB5152FFAFB3DCD06996A45988E3D32@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB5152FFAFB3DCD06996A45988E3D32@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f20b23f-9dc5-46fa-54c0-08def2c6975f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Xg60YIu9yOzIoPVxiP/9vzRHwPTMnFcb2yJH7D0WGWRw9dC/E85Ssqp7uTovOwAglUgKj5vEkzBc0I5MGiUwQkDPoP1fl1WwHiYZswC2mRltRPPPQK4NTW0/1ASoW/+pWCK1TBG0yEudc5Hr5/G3eHScGD6d7hK4tAlAoD+TbuLsHreoXcSr5u3CtBpUQwPENgGwr7xRsbGda4wSbWxPL0zjjbd5pviunOPBEEIm0nvOzcaF4Ol6UVQ9EwiiMrrOo0Y1Zz+MZKTURuSUIBFVtlpw0+4sphEX7mmasphRXIIQROUxtUHi9aW/3E5DhhCbgetWG0yhVX88mz7eCpKnJn3/JdXuE67NCWxw0PVkMoNL6RlMfaPeG0Uv/IhufeXhZOHMO6iIkN88AHDW4fIYIV9c7qNKeqqf0n4xDUsEHgDCmQMvn5AbT4XOrXLJWvwAVxZZmXf9QAlb/trBf0AwPvOwdBW4RyzEdcK0/INM/+/gFlduRkh3mOCTbfvpBvbZDbi1zASgugrOpa3kEgGgx+DqXnjEvq00nomTv/O4M/BbxVCuGQQBv9GH1ZiIlpiFC3ipTPNCuwOY481iNV4ZJ4R9NUQVmqtVtrC7BsnrhhGSBHnYvMDtphephWtkpQ1sOu3+un+kXwP23lUReriIUc31zVWeCeEGJOmQx23UTgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZpWDJFS0ZMVXJ1dXE4algxT1NqR09DZXpRNkg4aTBQZHdZR000Vk1WSmp4?=
 =?utf-8?B?aGdsNENRR2tYZTFXb1Zob0M4UkkrZ1dUSjF6Uko5Q2xuVExRL3JhS2RxL2ow?=
 =?utf-8?B?VXR2Mm8wNlRmNG83V25LU08vY1p1UENwdUdHL1V0ZnBWbEQwS0l0dTc3MmxB?=
 =?utf-8?B?WnVVMlZLbFdsYUx0OEVjcy9IZ2ltOGFselp2d3lMSUQ2djlVUjk4K0c1QkRq?=
 =?utf-8?B?QlBEMXZVaWhWUmVLWnoydEE5SXpVUkxXMEZaaHJzdzNIdDlFOXk0b0tPRERZ?=
 =?utf-8?B?WFZZeHZFbFhTNkQ4TEY4NTJoc2E2SVNYYzJ0bTZCN2xxcHlveURuNmVFMDhZ?=
 =?utf-8?B?c2EvemwyTm9JSnczWHNxSWxWcGY2NUt4ZXp0cFpuMHNEdndWSHBuSGZtYnpR?=
 =?utf-8?B?eFhYK0d0VjJzM2p6Tm1WaFArUHZVS2xnd2NpaUFWQUdsaWE5MHlzWW9Bcll4?=
 =?utf-8?B?aVF1TWVUeDRvckFrUWtKUUFvNHBHSE5FUGdJcUFEWmhtODZhU2RsTTNDYlI0?=
 =?utf-8?B?emdIM05EaVo2WnMydUdkN3lUZktyL05BSUVSMFQ1N3dnSlNLSkJObkZuOWtB?=
 =?utf-8?B?ekQ3ektLS2V1RlRhZFpyQkpISkt2VzhNdU5FWjl3dEJUeWVEdldSSit3OWh3?=
 =?utf-8?B?dFg1T0czbHZSMnpDa0MrZmRUN3JkbFhya1R5SnZwNEluODJidzVkWXJIU3VX?=
 =?utf-8?B?VzJxNGpYSXlLQWU2OS9zNmpkamRpWWVjM3BzVU81eWFNNkNTRVN2cHJXdjg0?=
 =?utf-8?B?ZWY1Yy9pc0FEZWcva25QMFZoRHQxYXc5ai9mSUJKL2JBaC81MVVYWE1CSThH?=
 =?utf-8?B?em05QW1NMFRNYUtHRmpXWExjNlUxcCtYZmFDdUpSaHdJK3JOUGh1eUNvNG93?=
 =?utf-8?B?Q1RtT1VLbEg1azcxRVo3U0FJQ0FyZEpPMXgyczFpdktDMmVkbm9zK3BsSGJD?=
 =?utf-8?B?Um9hSWFzNFdiMDZrSVkxMmVFWVNZYk1POVJBN1I2NzU3VWlrZVlxWmZhRGlF?=
 =?utf-8?B?WmRwRE8zQndmdVQ0bDhodzZWU0JET1E2Y08ra3AzMHFPNnN5dUJTWlM5ZUIw?=
 =?utf-8?B?WkJ0ZkR5QnN1Nm4ySkJqYWtUQmlKNlhiNkNjWXQxdklnYUVxZWg4MVV1U3No?=
 =?utf-8?B?YmdQTTJqTlJMNEN4SnRwZ2RBaXBHN2ZqNDlBOGRhV1RxVnpBZ3FDdjAvRjZL?=
 =?utf-8?B?WWFwbXVBWG9NN3Y1WW1QNHduSDBsM1lNa25JYzdMeU0xeXdMQThSbmtOeHZu?=
 =?utf-8?B?TUtDaDUwNFkwc3M3Z3VkZFRaNFFVNndvYitTam1UbDFOQjRrRjZoQjJsNHZn?=
 =?utf-8?B?T0ZyZUtGd0Z6ZmFyeUlPRWJac1ROd1ppSWorcnRvd1FiZVJRbUpYb3NPUDZQ?=
 =?utf-8?B?eEFtdGpiTUpTdG54ajBXeVk1dmR1VkhSTUdNcWpTUDVIQU51b21mOHo2OS9w?=
 =?utf-8?B?UUdWR3JhMUhLeGNoRDNJZHBXZnp3Y3NnMDRPaDhmK3NML2lFOWsrcXpmSzlX?=
 =?utf-8?B?RXpvbFlDcE5PM0phYUF2cUNsajlUNlU0MUJUZEhMT1ZIdzM2SE1WYUJWcitF?=
 =?utf-8?B?eXl1Rk5Tc2JIdnM2VlFFRGR1cEVuTi9XbVVHR1AyeDExZ2k4OVhHWXZseEZp?=
 =?utf-8?B?OUJkd2V0K2RYaFZmTUNadGNnTDNsUFp5bzlnbVFURnBSZEVhZUdkKzlLZlRo?=
 =?utf-8?B?dDQzbjJNbzBpQjVFZDJTOTdrSDFySnlVaVNadkpTdFRjMWkyTXZNaXd2dEgz?=
 =?utf-8?B?L2YvbkY0RkpFV3dWaTBwWTkvRmgyWThVNVhvNmxvN0YydnYwZnhJc0ttSzFZ?=
 =?utf-8?B?ampxQ0tWVThVS0tQM3pXN0IzK2xsMVpIUnZ1NFBYNWtLTXpxWXM1L092Ykt0?=
 =?utf-8?B?Z25BY2ZuL1hmSGYwSEV0K0c3dlQzU3ZKSnRZZjdjSlh6UHFRQjNISlFpSmUz?=
 =?utf-8?B?Q3pDd0Jrd2dvRzlVdWo3MUFJaUFEVzRCZW5yeTlUVkRwMTQwNk1FMDVQeEg5?=
 =?utf-8?B?NTZJUFJMVlRMNFJOM3hTSmVWdDJzaUJoV0tEU3ZSaWFFTnBHZGVlTGxUa28z?=
 =?utf-8?B?R1BvQnJraC9RdC85U0RsVm92WkhPMUFxTHJ2K0NISWZFQUJrYWo2ZGF0ODZm?=
 =?utf-8?B?a0NxV1czRFdKZ1E1SC9vR0Q1ZW43RE5icjVKN2xsTGdUbzhPOG5DWmlMakUv?=
 =?utf-8?B?N0hzT3o0S0wvaFQzRVFMYUtvVzh0d2hLVjBYWFJobmxjWlJIVVRvRjZMWU05?=
 =?utf-8?B?WldXeStFaHFYSldvUVJoSWlhT2p0eXo5cEV1NlMzbVhKYzJmOEh2cGJqaTlm?=
 =?utf-8?Q?mBAfJ7osL1fkQ/HrtF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f20b23f-9dc5-46fa-54c0-08def2c6975f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:53:09.2370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jit2hw4nvuZBzFf8wlBzsCxcMxKF86rm8K7Oa3hYKk7YbaYCUG9PVEb/fIRm/m8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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

On 8/5/26 05:00, Zhang, Jesse(Jie) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, August 4, 2026 9:58 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer deref in
>> amdgpu_vm_handle_moved for BO-less mappings
>>
>> On 7/27/26 10:40, Jesse Zhang wrote:
>>> The individual.needs_update loop in amdgpu_vm_handle_moved()
>>> unconditionally dereferenced bo_va->base.bo (to read its reservation
>>> object, ttm_tt and to test for a DMABuf import). However
>>> bo_va->base.bo can legitimately be NULL for PRT/sparse mappings -
>>> amdgpu_vm_bo_update() already handles a NULL bo via its "else if
>>> (!bo)" PRT path. When such a bo_va reaches the moved list (e.g. the
>>> userq eviction restore worker running amdgpu_vm_handle_moved() while a user
>> queue is being torn down during a GPU reset), the NULL deref crashes the kernel:
>>>
>>>   BUG: kernel NULL pointer dereference, address: 0000000000000158
>>>   #PF: supervisor read access in kernel mode
>>>   Oops: 0000 [#1] SMP NOPTI
>>>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>>>   RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
>>>   Call Trace:
>>>    <TASK>
>>>    amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
>>>    amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
>>>    process_scheduled_works+0xa6/0x460
>>>    worker_thread+0x13c/0x290
>>>    kthread+0xfb/0x140
>>>    ret_from_fork+0x1b6/0x2b0
>>>    ret_from_fork_asm+0x1a/0x30
>>>    </TASK>
>>>
>>> The faulting instruction is "mov rax,[rdx+0x158]" with rdx (bo) == 0
>>> and
>>> CR2 == 0x158, i.e. reading bo->tbo.base.resv off a NULL bo.
>>>
>>> Guard the BO-less case: skip the reservation dance and the
>>> DMABuf-import check when bo is NULL, and let amdgpu_vm_bo_update() take
>> its existing PRT path.
>>
>> Clear NAK. PRT mappings should *never* be on the moved list in the first place.
> Thanks for the review.
> I tracked the issue to the state-machine path: amdgpu_vm_bo_update() can put a
> NULL-bo bo_va onto individual.idle via amdgpu_vm_bo_idle(), and then
> amdgpu_vm_bo_reset_state_machine() promotes it to individual.needs_update after a VM generation reset.

Something is seriously wrong here. I've fixed amdgpu_vm_bo_reset_state_machine() to not do that weeks ago.

Where do you see that issue? On some release branch?

Regards,
Christian.

> 
> I’ll send v2 that fixes this at the producer side by keeping NULL-bo (PRT)
> mappings off the vm_bo state lists, and I’ll drop the consumer-side NULL guard
> from v1.
> 
> Thanks,
> Jesse
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index aac8ace9d7a6..fbb76c32bff9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1631,11 +1631,17 @@ int amdgpu_vm_handle_moved(struct
>> amdgpu_device *adev,
>>>             bo_va = list_first_entry(&vm->individual.needs_update,
>>>                                      typeof(*bo_va), base.vm_status);
>>>             bo = bo_va->base.bo;
>>> -           resv = bo->tbo.base.resv;
>>> +           resv = bo ? bo->tbo.base.resv : NULL;
>>>             spin_unlock(&vm->individual_lock);
>>>
>>> +           /* PRT/sparse mappings have no BO to reserve; just update the
>>> +            * page tables (amdgpu_vm_bo_update() handles a NULL bo).
>>> +            */
>>> +           if (!bo) {
>>> +                   clear = false;
>>> +                   unlock = false;
>>>             /* Try to reserve the BO to avoid clearing its ptes */
>>> -           if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)
>> &&
>>> +           } else if (!adev->debug_vm &&
>>> +!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
>>>                 dma_resv_trylock(resv)) {
>>>                     clear = false;
>>>                     unlock = true;
>>> @@ -1659,7 +1665,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device
>> *adev,
>>>             /* Remember evicted DMABuf imports in compute VMs for later
>>>              * validation
>>>              */
>>> -           if (vm->is_compute_context &&
>>> +           if (bo && vm->is_compute_context &&
>>>                 drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>>>                 (!bo_va->base.bo->tbo.resource ||
>>>                  bo_va->base.bo->tbo.resource->mem_type ==
>> TTM_PL_SYSTEM))
> 


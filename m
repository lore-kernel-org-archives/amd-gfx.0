Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA5C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 12:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A700110E37B;
	Wed,  1 Jul 2026 12:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="npFrGrbx";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496DB10E37B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 12:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig87qz6LiT2yMkvTna80tuG+KrnhkuWZIwIPFspBWdWUj1DcdQMqNYTq3IYDNS+EZjA10ALRn8vwV7Nx0iWhe78Rz4e065L/qsXLmvSq68gdv90FVT6u5+pE2+92st1LKW0NC0vOpaj6NHt0H6pW8p4UHsec8MPObh9zibxuO/I11QzaiDmue5zqP7O0pxn7EF7bbtzlF4E9nOnbcWy/O7LGSxwxWkgAjhO0fmOcfv6zCWsX1aTazMT2OH0GpiGD8/+OX0W9TIWgCeUH9fVe9x1er2l4dUmtxXTYOCZLg0BWoGT0XZE6Y3EoIebxtr3imszxEolF1qSNMIPk2r6RRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URvhyOD9ig5wkABSOSlm5pNSBh0/4UeWXzqJBsAICGk=;
 b=L7qIsUdc1I4LLF0XMsswia9cgumvRnZmrTGAy2MULWiogDVNiNAJfe5wcc42zFX6k5qVMHs9Ln4NhtgJvpqOY9ctt9dI/9eSwWYPEcRqkrTobXM+U/hWdc4fNr1+IO1XKn5GxK8FcLpfQUOGhu4toWvx1IUoAOY59uFPB2JynV1VtXlenD8cWZR46lzAGD5HQ5eJ7wKsSrC68tkZ37MpYGEqOw+0QTynvcxShu5Kh8G7yH56rZr0AYkVDwIt21So/EiudrkjvKtjd+EhhKRyVaHxLY7MWtO+K4Sfn1zTHVF1kq09N50TghKi5Gb74/kV2/vHhdifZKxCJp/mIsXFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URvhyOD9ig5wkABSOSlm5pNSBh0/4UeWXzqJBsAICGk=;
 b=npFrGrbxrUNoXWI4LV5XJVRYBL7wHLuOytKqAOjuBrpRI0T47Sqk/L1wHQ6laTkx3TTUcA5nD+AWTizMUsAadSYN1fDCVFxo0JskiOaYQ08OkM5pHZYhEVtlLem5003o6+CZHyvhOMG+3t9M3LimmChWEZWdWGeMGMuoBkMKuzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:26:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 12:26:56 +0000
Message-ID: <ef3a15a5-ea21-4ec3-a1b9-2a6a51987e36@amd.com>
Date: Wed, 1 Jul 2026 14:26:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix VM status/vm_bo->moved locking
To: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260701113340.466177-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701113340.466177-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f8e812-6f71-41c1-17e8-08ded76c0a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: RnvDnmXK+C02KxEZ96vsFmiOzq3D4l9rEZHXHjpUwkM2MtF74ENGGafRKBBTHxWSZkc6Hl7WdWwc5fnY+iM+zK8bFWxJqBOyz9Ozxtg4srba+7ts76Hf4urQ6pi09c+IqOfFzBR3b9TLBihUsbk1KAvBgKrstMVbDP1T3etFBO/tvIXbytYwBpDL4yrsF2WpQg4fjy3dyjAuXfrH5soXX3iN/eCIqc/7tUMc2FjtLR1FSLCTJ4vhKriG/zU57le7FBF5wpa/7S1bP/6HDJGDa7fZdDdGGGdNR4q9uSzbh5i3KNSBuYgdR6dSR1UW9/2Yu/SUGFemzcofAsouashygwVRoXE9TllVhBhb7kmOvLRooFJo+Eyqs2O22GLhbOU+VIVFEPJnMMWVJHYA7qv8qwHj1LhNvfw2lBFgYpwZU8XH0zB9AKajJAZEEHeZfnZI/dFdfoaoP8MRO12Pruhl1kjL37QFx02ZM5TAlOwikZUQOW8R43FEARsAhIPeKW2JTmWdFiMnD76k6RnwhgUFf5FS4l2rZ/OfF5lNkvHbfT+VTk4/6GP/y9+36d1zKmc9c8BbWR91U/og/4j6bJQy/cTqBRov81Zn3GuAspRiEeAq8+sJNG8H7Xiv0rWsgilsVJYrRBgNNOnidVoqRiT6peRiUbiBcxXH0jFz2KJDJ+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUg2V0ZPQzdaWEI1czZMNEYwSDJjMUhZRzlZWmpZemdFblYwM3BrVU5kUzFi?=
 =?utf-8?B?V0REN211RnNFWXVyWXpSajNQWHppUVNVMEdjY2QyVlIrRWF5bXAyY0tSOXRZ?=
 =?utf-8?B?MnF2MVZNNkVCVnRtODlCVHJRcnJERThLa043dWlLZFJiVzFJWU9jeXFzL09q?=
 =?utf-8?B?N1ZBWlhudHVGdmY1a2VMdFRpaEdJZXpKMzRhbVFUT0dFcm1ndFZrVTVkb3JU?=
 =?utf-8?B?bzdjbDN1bnBJQXlWaFEvVG9sNVRIWWV2Uis1Sm8reEg2MWRMTGdla3pzU1Zq?=
 =?utf-8?B?S0lNRnpjZHZkSGdqWTNYb2Q1YlRXeTNxemV3bmVvTHRJcW5XUVlmUVBiZ3B1?=
 =?utf-8?B?Sko4dVVWQm9CVHFRN0kvTWcxNDUwb0tlejFrK0w3MDlCQUV1aHAxOTdrVS9M?=
 =?utf-8?B?TWt3M2lPb0x0M1RlWFJWYS9EUWQ4emVGd2FNb3BLQm5CZUJDaDNRQ2F4eThh?=
 =?utf-8?B?V0VHZkJNWWh6Q1djbzhKOTJoZ2ZZT1Y2R2RiMGNZS3dRd0pndnlBOEdIZkdM?=
 =?utf-8?B?TzhOc2lRMktlb2xOU3lIcUlDNjlVbHM4a3k0NzdhSzZadjZNK1dKR1hVenFW?=
 =?utf-8?B?d21YMDF1MzJMMUZyK2NseE9kTkhFcW5tcVg1TytkengrTXN4cFlkL09Pc1lV?=
 =?utf-8?B?OTFnSlpIUnhxbmhNcHloOTFwSWVvQVUxN25ZODJqdm1VSUxWN2EzLzEwYU5p?=
 =?utf-8?B?Z2lHQVcwQUNPTnUwd1ZRSWc5bXA1RHRXMHBIRTBCNkNQdVJybUU3b0R4VzRD?=
 =?utf-8?B?ZzUvMWtqTmVmaGh6WXcxeS9MTm5uWjZxVWdCWTN5dVFESUhrRTZCbFRQUVJu?=
 =?utf-8?B?ODNSTDVMbTljNmpyYUgwTll3M2ZyUS9wbmlkeE9tQWFvUklGc1hHK3AvclBr?=
 =?utf-8?B?Zy8vckpXeUxwSTRlN1ViODJvOXZPUkMzc0puVHZmTHg5Zkd6amJpV2J4Sk5B?=
 =?utf-8?B?dTZlOGlORzJQU0VzY2FJM0pXcUhWME91Nmpvd3JFRERhcVFSZzB6ZkVieWhi?=
 =?utf-8?B?NXJzR1psMTYxcE4zUThyRElCUDZNZVFHcU1QSkZ1WVU4NEY2QWdLaVNmOUpo?=
 =?utf-8?B?RWNFeStxcUFOcHlFQXNnTDJkamJUTVNieVJnQVEyRU43WW5RZmt2TjhtMVVi?=
 =?utf-8?B?R241b1YzTmxFV2JDejRPVnJjV0lPb0g4QUFORkl6ekZ1T1A2VVJmdlRMV1lG?=
 =?utf-8?B?TlpDVVR1eWVsSEMydVA4amQ4YjVXWERBNXcyMi9kWVZ6eEVZU3VDM2o5bzFq?=
 =?utf-8?B?emw2MGhaQnY1a1JuQzkyWFFFcUQwS1NFVUtkSzR2NytpdlhyUEM5bjdHYmpG?=
 =?utf-8?B?dUtvNWlZdWNUbzNPYW9ES2N5bitGdFBDMUFEdEMvODlWVVRDQ1RSVWtic2pa?=
 =?utf-8?B?OUlXK3BiUDViKzZRQ1gvSGRpU24zdVp5MmpjTXJ1UzFMZno5cTlHeWh3OEhk?=
 =?utf-8?B?ZjdqelBkdWV5amc2Y0hCUWZaNHIySDVmMElEOElEaWJPU0lWZDFUbkFHdUd5?=
 =?utf-8?B?MGFaOWVNb294Wm9RcU1FYy9wWkJrZEFRcUlFUStZWWw5Qm9FbFRoemkybkFi?=
 =?utf-8?B?aHdzSDlPby81NUU1Mm1kWlBSU2JLQkNBMWJTL056TE5nVzlIZ1dMZWlxNjZ0?=
 =?utf-8?B?eDdDR2lJV05mYjlibk0wb1JLQWpTNER2bGIwbE5FTkM0T0RjVkhsQVV3Y1FV?=
 =?utf-8?B?NG9ETEZNYk12am8zWEpBNjVjT29tT01VWmdMUERJc3B4bzVSQnJ6S2RvL3dl?=
 =?utf-8?B?ZnVzSWw3VFlEd1JCcUhzbjJiU2lWanJXVUFWY0hKalpZdTM4VnBLbnBPc3M4?=
 =?utf-8?B?Y0MzR0V2ZGdZRmRxcVRaZkVZbS83YjRxZDVkbkNvYVFhSHNYWjBLMlc3RUd5?=
 =?utf-8?B?TGdJazRFSHNYWlNyTTA4cGRiK0s3QmVtNkVaTFh2Ti9MQUpoREVNbVY5Nk5n?=
 =?utf-8?B?NEg1VFRsM1BoZGdvZVp0d2c2aTM0MnQwS3Jad0o1TEd3RzA3YkR5SzlDanRp?=
 =?utf-8?B?RjNFWnFyZTlHR2JrV0MvVzIzVUtPSXlmUU9URGRlTkcvWmc2a3NtSGRLdlFv?=
 =?utf-8?B?SFg1SUxlZ2VWNnBwVTJQQWxRTTBSa3JFaFQ2a1BTMkxWaFl4TzdBTFpKZWJW?=
 =?utf-8?B?NmtTYStBeGUvMHRGS3d4czhObGdKS0swTlpWRXhQRUo1M1ZJVWhwclFzbzc4?=
 =?utf-8?B?SUVEeFZHdnh5MVh3Y3JDVzFHUWxNNTV2TDh6VVZjMk4xbVYrTEt1UHJhdlg2?=
 =?utf-8?B?bUlhL04zdi9qK0VpTU1GRTVkczJ4ZUZFQWVoYnJQa1ppdlcxcU55U0lnamNm?=
 =?utf-8?Q?3+6YXAVbRiJLa7H967?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f8e812-6f71-41c1-17e8-08ded76c0a07
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:26:56.0055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QHDO3KWRn1+/1GBTMKuQSHuZFWyF2XtnIDJlKj+jc/qX4YxR8l6HEAiyzYm/1Xg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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

On 7/1/26 13:33, Natalie Vock wrote:
> We claimed vm_bo->moved was protected by the BO being reserved, but then
> accessed it in a bunch of places without a reservation to the BO anyway.

Can you point out where? That clearly doesn't sound correct to me.

We have some questionable uses for userptrs, but those should be irrelevant.

> 
> It's not sensible to protect this by BO reservation in any case - it's a
> property relating to VM state, just like vm_status. Let's protect this
> by vm->status_lock as well. We usually grab the lock at some point when
> we access the field anyway, so it fits well with the current usage of
> the field.

That won't work. You can't hold the status lock while the moved flag can't be modified.

> We also need to remove some unprotected accesses of the field when
> removing a mapping. Checking for the field there was a microoptimization
> anyway.
> 
> Lastly, and most critically, we also need to handle buffer
> moves/invalidations racing with amdgpu_vm_bo_update. Otherwise we might
> accidentally undo the invalidation without the PTs actually being
> properly updated.

That's not correct as far as I can see the moves/invalidations can perfectly happen in paralell and are handled before the next CS.

Regards,
Christian.

> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
> FWIW, I'm not 100% positive on whether the Fixes tag is correct - I'm
> fairly certain the VM update <-> invalidation race existed ever since
> the driver's inception, but it may have been hidden in the initial
> revision. I suspect backporting it all the way to wherever the race
> started manifesting is roughly similarly painful, though.
> 
> Also, this patchset is based on my previous one to rename the "moved" VM
> state to "needs_update". I think it got reviewed and should've been
> picked up, but I'm not sure I see it in amd-staging-drm-next?
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 108 +++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
>  2 files changed, 75 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 32719f31b6c9e..3451dca7de194 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -214,11 +214,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   * amdgpu_vm_bo_needs_update - vm_bo needs pagetable update
>   *
>   * @vm_bo: vm_bo which is out of date
> + * @moved: whether the vm_bo was moved
>   *
>   * State for vm_bo objects meaning the underlying BO had mapping changes (move, PRT bind/unbind)
>   * but the new location is not yet reflected in the page tables.
>   */
> -static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo, bool moved)
>  {
>  	struct amdgpu_vm_bo_status *lists;
>  	struct amdgpu_bo *bo = vm_bo->bo;
> @@ -232,11 +233,28 @@ static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo)
>  		vm_bo->moved = false;
>  		list_move(&vm_bo->vm_status, &lists->idle);
>  	} else {
> +		if (moved)
> +			vm_bo->moved = true;
>  		list_move(&vm_bo->vm_status, &lists->needs_update);
>  	}
>  	amdgpu_vm_bo_unlock_lists(vm_bo);
>  }
>  
> +/**
> + * amdgpu_vm_bo_idle_locked - vm_bo is idle, already-locked version
> + *
> + * @vm_bo: vm_bo which is now idle
> + *
> + * State for vm_bo objects meaning we are done with the state machine and no
> + * further action is necessary. Needs to supply a locked status list.
> + */
> +static void amdgpu_vm_bo_idle_locked(struct amdgpu_vm_bo_base *vm_bo,
> +			      struct amdgpu_vm_bo_status *lists)
> +{
> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		vm_bo->moved = false;
> +	list_move(&vm_bo->vm_status, &lists->idle);
> +}
>  /**
>   * amdgpu_vm_bo_idle - vm_bo is idle
>   *
> @@ -250,9 +268,7 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>  	struct amdgpu_vm_bo_status *lists;
>  
>  	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> -	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> -		vm_bo->moved = false;
> -	list_move(&vm_bo->vm_status, &lists->idle);
> +	amdgpu_vm_bo_idle_locked(vm_bo, lists);
>  	amdgpu_vm_bo_unlock_lists(vm_bo);
>  }
>  
> @@ -273,9 +289,9 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>  	 */
>  	amdgpu_vm_assert_locked(vm);
>  	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
> -		amdgpu_vm_bo_needs_update(vm_bo);
> +		amdgpu_vm_bo_needs_update(vm_bo, false);
>  	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
> -		amdgpu_vm_bo_needs_update(vm_bo);
> +		amdgpu_vm_bo_needs_update(vm_bo, false);
>  
>  	spin_lock(&vm->individual_lock);
>  	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
> @@ -435,7 +451,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>  	 */
>  	if (bo->preferred_domains &
>  	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
> -		amdgpu_vm_bo_needs_update(base);
> +		amdgpu_vm_bo_needs_update(base, false);
>  	else
>  		amdgpu_vm_bo_evicted(base);
>  }
> @@ -607,8 +623,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			return r;
>  
>  		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> -		bo_base->moved = true;
> -		amdgpu_vm_bo_needs_update(bo_base);
> +		amdgpu_vm_bo_needs_update(bo_base, true);
>  	}
>  
>  	/*
> @@ -625,8 +640,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> -		bo_base->moved = true;
> -		amdgpu_vm_bo_needs_update(bo_base);
> +		amdgpu_vm_bo_needs_update(bo_base, true);
>  	}
>  
>  	if (!ticket)
> @@ -646,8 +660,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> -		bo_base->moved = true;
> -		amdgpu_vm_bo_needs_update(bo_base);
> +		amdgpu_vm_bo_needs_update(bo_base, true);
>  
>  		/* It's a bit inefficient to always jump back to the start, but
>  		 * we would need to re-structure the KFD for properly fixing
> @@ -1266,16 +1279,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  	struct amdgpu_bo *bo = bo_va->base.bo;
>  	struct amdgpu_vm *vm = bo_va->base.vm;
>  	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_vm_bo_status *lists;
>  	struct dma_fence **last_update;
>  	dma_addr_t *pages_addr = NULL;
>  	struct ttm_resource *mem;
>  	struct amdgpu_sync sync;
>  	bool flush_tlb = clear;
> +	bool uncached, moved;
>  	uint64_t vram_base;
>  	uint64_t flags;
> -	bool uncached;
>  	int r;
>  
> +	/* Everything we access in here is protected by the VM PD lock. */
> +	amdgpu_vm_assert_locked(vm);
> +
> +	lists = amdgpu_vm_bo_lock_lists(&bo_va->base);
> +	/*
> +	 * We can't hold the spinlock for the entire VM update, so temporarily remove
> +	 * the BO from the state machine entirely. This does not prevent all types of
> +	 * races: We might not hold the BO's resv here, so TTM is free to move the buffer
> +	 * and thereby invalidate it. However, it allows us to detect if we raced with
> +	 * something that invalidated the BO again and handle that appropriately below.
> +	 */
> +	list_del_init(&bo_va->base.vm_status);
> +
> +	/*
> +	 * The moved flag is also protected by the status lock. It's fine if some buffer
> +	 * update changes bo_va->base.moved while we're updating the PTs after unlocking
> +	 * the status lock, since that also invalidates the BO's VM status again.
> +	 */
> +	moved = bo_va->base.moved;
> +	amdgpu_vm_bo_unlock_lists(&bo_va->base);
> +
>  	amdgpu_sync_create(&sync);
>  	if (clear) {
>  		mem = NULL;
> @@ -1343,7 +1378,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  	else
>  		last_update = &bo_va->last_pt_update;
>  
> -	if (!clear && bo_va->base.moved) {
> +	if (!clear && moved) {
>  		flush_tlb = true;
>  		list_splice_init(&bo_va->valids, &bo_va->invalids);
>  
> @@ -1389,20 +1424,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  		else
>  			amdgpu_vm_bo_idle(&bo_va->base);
>  	} else {
> -		amdgpu_vm_bo_idle(&bo_va->base);
> +		lists = amdgpu_vm_bo_lock_lists(&bo_va->base);
> +		/*
> +		 * Now that we're holding the lock again, check if the
> +		 * buffer got invalidated while we weren't looking.
> +		 * We initialized vm_status to an empty list head above,
> +		 * if that's still the case we can safely mark the BO as
> +		 * done.
> +		 *
> +		 * Note: We only need to do this for BOs that are not
> +		 * VM-always-valid, because we hold the VM's reservation
> +		 * which by definition reserves all VM-always-valid BOs.
> +		 */
> +		if (list_empty(&bo_va->base.vm_status))
> +			amdgpu_vm_bo_idle_locked(&bo_va->base, lists);
> +		amdgpu_vm_bo_unlock_lists(&bo_va->base);
>  	}
>  
>  	list_splice_init(&bo_va->invalids, &bo_va->valids);
>  	bo_va->cleared = clear;
> -	bo_va->base.moved = false;
>  
>  	if (trace_amdgpu_vm_bo_mapping_enabled()) {
>  		list_for_each_entry(mapping, &bo_va->valids, list)
>  			trace_amdgpu_vm_bo_mapping(mapping);
>  	}
>  
> +	amdgpu_sync_free(&sync);
> +	return 0;
> +
>  error_free:
>  	amdgpu_sync_free(&sync);
> +	if (r)
> +		amdgpu_vm_bo_needs_update(&bo_va->base, false);
>  	return r;
>  }
>  
> @@ -1779,7 +1832,6 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>  				    struct amdgpu_bo_va_mapping *mapping)
>  {
>  	struct amdgpu_vm *vm = bo_va->base.vm;
> -	struct amdgpu_bo *bo = bo_va->base.bo;
>  
>  	mapping->bo_va = bo_va;
>  	list_add(&mapping->list, &bo_va->invalids);
> @@ -1788,8 +1840,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>  	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>  		amdgpu_vm_prt_get(adev);
>  
> -	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
> -		amdgpu_vm_bo_needs_update(&bo_va->base);
> +	amdgpu_vm_bo_needs_update(&bo_va->base, false);
>  
>  	trace_amdgpu_vm_bo_map(bo_va, mapping);
>  }
> @@ -2090,30 +2141,22 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  
>  	/* Insert partial mapping before the range */
>  	if (!list_empty(&before->list)) {
> -		struct amdgpu_bo *bo = before->bo_va->base.bo;
> -
>  		amdgpu_vm_it_insert(before, &vm->va);
>  		if (before->flags & AMDGPU_VM_PAGE_PRT)
>  			amdgpu_vm_prt_get(adev);
>  
> -		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
> -		    !before->bo_va->base.moved)
> -			amdgpu_vm_bo_needs_update(&before->bo_va->base);
> +		amdgpu_vm_bo_needs_update(&before->bo_va->base, false);
>  	} else {
>  		kfree(before);
>  	}
>  
>  	/* Insert partial mapping after the range */
>  	if (!list_empty(&after->list)) {
> -		struct amdgpu_bo *bo = after->bo_va->base.bo;
> -
>  		amdgpu_vm_it_insert(after, &vm->va);
>  		if (after->flags & AMDGPU_VM_PAGE_PRT)
>  			amdgpu_vm_prt_get(adev);
>  
> -		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
> -		    !after->bo_va->base.moved)
> -			amdgpu_vm_bo_needs_update(&after->bo_va->base);
> +		amdgpu_vm_bo_needs_update(&after->bo_va->base, false);
>  	} else {
>  		kfree(after);
>  	}
> @@ -2285,10 +2328,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>  			continue;
>  		}
>  
> -		if (bo_base->moved)
> -			continue;
> -		bo_base->moved = true;
> -		amdgpu_vm_bo_needs_update(bo_base);
> +		amdgpu_vm_bo_needs_update(bo_base, true);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index c1bd4d35831e0..0acd889568a38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -212,8 +212,7 @@ struct amdgpu_vm_bo_base {
>  	 * protected by vm BO being reserved */
>  	bool				shared;
>  
> -	/* if the BO was moved and all mappings are invalid
> -	 * protected by the BO being reserved */
> +	/* protected by the vm's status lock */
>  	bool				moved;
>  };
>  


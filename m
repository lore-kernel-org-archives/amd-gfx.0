Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E59FD707B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 11:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1E710E5DD;
	Tue, 17 Mar 2026 11:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jO8/UuTt";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE4C10E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 11:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL4TqgThV9u8O8hXM7hySKwVGKWFy1hkXi736hMArCGNrTGWXQLtfe8yuos8zxmi6gfDJv4DrLH0t4svOLB/usqVWF12oM/78E6+/eWTtdSQa0INdtd2Yc29OM34764TGndiBDtOWlAAE0y2bu4vLiLtV1Ysh8HNQDzRiJoJPX+DabJ2lbV7IBd1UU5J5imetAYbpFtSRcJV5umQFIQ7BHooZcV1ZMXD6kqivuVoQYGYB02Hp/cl4NquVrfs6S9vOdAA4sSojdEU7Rvf8Ju4L+m43mXJOMxjkMbLaViwTQDIB7UKWOrwK/jp25jNnWh9WAijGO0RK++mqtcKp4106w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af3Guj7KNtI5QIEPW/voRtXvcDlIzXcDMUJWFfFHqzU=;
 b=xSL6isBoy89FyPy2K7i5S2BReg+DlchHLNXIYabtPn99xel9UV2PkxfhsQoInfKquODLFA3wQ/3Bixy2nG56Z9fdPrjqHgKBELkfiSTmd2nfAF1ufq+hD+AjLAiSnNTVKwGC9nGxZzGDfp1Pf0iQL53dfUQK4FJLUVQ1RwFYt9XL+OczZl+GKW/FXHZz+RRb1CKQOEBoN/Fu2645HVXtlMR18EZn7yq7ZhfYlhAjGWGVALQpANSDJ622pgqAyh3vw+Az+O2hNaG4UHs05mfHEuq4a5Cdxd8/JmCN+QBgMWjGMcp2PsoScz81MmrKj5w0CDnC6Imh7QZpZ+dTh3b5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af3Guj7KNtI5QIEPW/voRtXvcDlIzXcDMUJWFfFHqzU=;
 b=jO8/UuTt1Zoo8hODIYl3EAvQsijKkj/4VX0HVxYgECat/Le7NYWxdpkxjzZWl3I/AwZ7igaLA3Iwjl6Pq51Rq3DQWO+f2Z8DCvOzrUNj/wrXAdIy7Ld/p/2l9EMwibKe/RrJUNhdl/LLlQC2mKAhrN7V7aPGeTKMbJLCqJsJrUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PHXPR12MB999232.namprd12.prod.outlook.com (2603:10b6:510:3cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 11:08:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 11:08:44 +0000
Message-ID: <c6be4648-d53c-42d1-a625-8e09cba0993a@amd.com>
Date: Tue, 17 Mar 2026 12:08:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/amdgpu: fix some more bug in amdgpu_gem_va_ioctl
To: "Khatri, Sunil" <sukhatri@amd.com>, tursulin@ursulin.net,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-10-christian.koenig@amd.com>
 <b26458f2-d0ad-42e8-a0a1-77d7c5fd15dc@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b26458f2-d0ad-42e8-a0a1-77d7c5fd15dc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:408:f8::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PHXPR12MB999232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b143114-e8ae-4922-ed54-08de84158dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /vQEeBmRELejnx5iwhooGr2efvYTOHY02cEaFZ2F16M4t9m0F2JC+BudTRzmrOyQwrcFtt5oaMBGNZSE/pHVIHSPT6SuQ3FY0IEcMoNT2DMThUEX2FpuI2ooYazSwTVLbEDu7cXc+5OxYv0EZMn0UaNZLZm3hMeYasK/3paj/UJg7yYt5qMmVxf6bhimT2ePu3KQFPZC0AqJYb5EGgoMRbq44FQFI/WS/9YHS26ZHI+/YHVZr4RciB5JuOK4aqziNpspPo871zz+hk+aoTlZ+fq9MsSx9iqc1N2t4p5eWCHZK2NmtaVl1rkWLtKQI4xL9FXKUyP8Pp+2P4wJybd7gmAnPYFwCgUx9pDdbnyEFcZvnxLbt0kEEHGdeJjbb3AwS3afQcSlAp9UZTkMDnAwa7c2dWeGSNlBcCoeMJWXF2J/Jwi0eWtQyzcbtsMuS9FBvU5z8QHjYXJbqenUNqaQxbKGBCPaB07PKsMHSjv28EeyaUb6kvqZGKP0tscCD/CsXrGD/E4eEIUl7yQ6qtmfi0G82JvqQiRWrp8PhmfBsWuRxh8q8rjfy7unquqm5K7UIzFUWtpIL3Vs8NUcf7zqnULBecTRUkLIihBQuUPrbY+ah/Sm1c2+AMLPPloOfon5rzcoreNSISleRss8Nu5SBMWvsEiTMbI+QF8eXgiup+ZFHjQqu2kLV8Ev4ctj0dTOyNOEw5b1pNpDQLRWbhxTjyLbO6sr9sCWU215N6Xr/Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzNKV2RuTWtIYUJhRnVOVDdYeSt0NWF1ZzdPd0Rjbk15SmJFb3dSK2duSEla?=
 =?utf-8?B?cTgwYzFhdDVzbzBjUVEybUlVZzVEUUh1WDdScm1MMElyb2ZDNHRDQ0ZIa0hQ?=
 =?utf-8?B?MmNBcHgzL2dBYUFjSmd4WXJTM3NIZTlPZGN2ajZMdXpJTVVxZzZvZG9uenJT?=
 =?utf-8?B?cmV4WkFFSGU5NGtsUkg3dFg3cXdMdm5WcnAzNnVHUW1VYzJkZzFGaHA4RVpL?=
 =?utf-8?B?anF4dElHKzAxZ2pydmdMcyt1ZmJjcTlVcE8xclJUaUFiWU4wVWVKSmRCbUcv?=
 =?utf-8?B?TGM3N1RWMEVWL2JwUkNLMXBKRUlxeG02RGQrSU5pWkFRNmtxaXVDZ1ppa2d6?=
 =?utf-8?B?Uklud2haNXBiL1ZIUTdwS1F0ODMzbksyeUFqZEdHNmlmaTRkYXZSRzRXTDBJ?=
 =?utf-8?B?elFibktvMitpVGo4MDhNamIzTFJ4QXVMMmxVVzU3aGdGQXVPSHlzcWxKUlMw?=
 =?utf-8?B?RFlnakd3L3k4UWJVMjA5dFFEZ2NqY1g1dmdXVGl1OGovaE8zWC9RSW5jTHFy?=
 =?utf-8?B?RTNSUjZ5Y01BK1BHQjU0bDE1S3pPYW9RTWl1ejg0VEtvY2tTdHlMd2trTjY3?=
 =?utf-8?B?WWJNaVp6TzdweXJQcVcrQmswcGJ4MGFvWFl0cWI5Rnl0akkwaSs1QjladEdK?=
 =?utf-8?B?L1ZWOEFzSzdHcHpSY3BEV2xzT0NYSWFvVy9ieVNZNWt4NTlkSzVNQWd5clRO?=
 =?utf-8?B?c29rQU5wTFN3UnZWQ0l4RzBwMXdIcVlnMTFhUlNVRVJUMmlPUEpVUjgrcDNN?=
 =?utf-8?B?QldpOUU2cDdJUjdQeEZYOXpjZmhWeHZQdXdjZDlFRzVXSkNhaWYvaHRGUCtM?=
 =?utf-8?B?dWlJbG1uendUSU1vWk5tMUdaalg3c01zM3IwZW1WMHlnZyswTDl6YXcwMDRJ?=
 =?utf-8?B?RnVBS2cvc3VCUjdQYm9yMkVFVzBiTU04Z2czTDZXbldJZEQybnJlZ0tqMG83?=
 =?utf-8?B?T0V1eUN0QVVGNDBjQTdjaVFodGE2aDBJcU5TYTNNMnhDdVphTGpVMERFaFMy?=
 =?utf-8?B?OXNWTWlwZVNPNU9rZnN3cjJmWDJhc25lK0tGTm8xTU8zMXhVQWRNK2NFMHpv?=
 =?utf-8?B?M0QzdW42amZ3dURlbVdMOVlVeDE2TlR6RGlqUDZpVVNCcmhHL21ENkpFL2hq?=
 =?utf-8?B?MHJiSjZ4UE0vdmpmMXBGTHg5Rm9uUzVaNHR0VXVBcEtaRC9jQzQwWUdkUEI1?=
 =?utf-8?B?eS9xZk9Pd3J3QUhWSk1CUjQxT2lCMkp2aTQrQVRIQnBnWVZhR2o2aW11d0hx?=
 =?utf-8?B?eXM1aUNCcUlvQk1pN1RpNGliWDBObEorei9TS3hoT3NlUTF4ZC9lWnlnQXB3?=
 =?utf-8?B?bGxUZzJlWG5lNzc5SVZRWEFIaE1KSXcrd2NwQ3pLUFppWUVZaGNIVVZJblpY?=
 =?utf-8?B?QjdoMjV6OVdVeG92eHZZMDM3NnNlWFdlZm1Gb0hneHVjcFJ6WGJrSnpIL1lj?=
 =?utf-8?B?Q2RmTUUwYjFwcjk0ZUE2U2VuMG42ejVWOW0zRzh1ME5CeUlrMXh1bXZOcElj?=
 =?utf-8?B?UW5GdWswT1B3a2JocEZWYVlYL24vemlmYTRXQUJRSW9VblJUTmkvQ0JPcDNw?=
 =?utf-8?B?bmIrQlRzL1N2Y3FWNkJOZ21OTTVyQ0c3dU9IVjFZalI1VXBsM0o1ekZNNlNx?=
 =?utf-8?B?SEE4M0pRbjUrZGFOMW5JeDBOVXBpb0V5WVZaNDExbHJvWFR0amxuQTFCakxm?=
 =?utf-8?B?cnJ3MENzSFJWNTE1cEpOWjM1UVNjZURQTnhmV0lSNnRiUDRKQ1l3WUtJWXdZ?=
 =?utf-8?B?Z3hZNTJva0k4aExjWDcvT3QvMDVGYTVwRkEzVmwraE5TMnQ4dDh4aHVsUjlG?=
 =?utf-8?B?SXFwR1ZxRnZNRkNXQXNLcW1BMGRaMXo4eS9tS29vaE5xSXFGZTVDS1dFK3FH?=
 =?utf-8?B?dG9EVU1hS2pJMVlDc2xVNmJHbnJBNjdaNzRFYnBEbFBRTkl6dE96ZDUrUENU?=
 =?utf-8?B?cTJtd3FjZENrMkJCOHdlTUtKaWFCVXEwNGpoVThwTmk3dkFrMXpraFNyMFNt?=
 =?utf-8?B?MjZaS20rSGFkTVhkWDNMVVI4eWdzdndJcVgvUS9ENlg1MWZFZ0VaUG5PZUVm?=
 =?utf-8?B?aE5VUmczZkNkeXhhZE8za0RKTm4wYzR1TFZzc3E5bmp3VzY0VFdHWFhpa0lL?=
 =?utf-8?B?c1pKeVk2L3AySXI5ZzlvZWRTM3dGbTRiemdJVVZsWXhlM0V0OG1zaGo5K2JC?=
 =?utf-8?B?YkdaSWhsaW5OTi9BVWFYeTdQWXRBZmJRT1JpNG13Sk9pSUlZRmJ1WTcrZTBs?=
 =?utf-8?B?ZzY4U1J2K1FucXhwMmo4bGhwdkNlNWlqWFNDeGtDOVZtVm4zM3BLNEUzMzhp?=
 =?utf-8?Q?BUOEAGolKwLpjwkEvu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b143114-e8ae-4922-ed54-08de84158dd1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:08:44.3886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6GAf6C6qQfj0SZvFDUJ+x2SDru3/1js0egNAmNLpkMiAyAHH8qsSmh9/rrAawuk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999232
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

On 3/17/26 09:44, Khatri, Sunil wrote:
> 
> On 11-03-2026 12:43 am, Christian König wrote:
>> Some illegal combination of input flags were not checked and we need to
>> take the PDEs into account when returning the fence as well.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 76 +++++++++++--------------
>>  1 file changed, 34 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 88a21400ae09..98276b55ad3c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/pci.h>
>>  #include <linux/dma-buf.h>
>> +#include <linux/dma-fence-unwrap.h>
>>  
>>  #include <drm/amdgpu_drm.h>
>>  #include <drm/drm_drv.h>
>> @@ -741,11 +742,10 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>  	struct dma_fence *fence;
>>  	int r = 0;
>>  
>> -	/* Always start from the VM's existing last update fence. */
>> -	fence = dma_fence_get(vm->last_update);
>> -
>> +	/* If the VM is not ready return only a stub. */
>>  	if (!amdgpu_vm_ready(vm))
>> -		return fence;
>> +		return dma_fence_get_stub();
>> +
>>  
>>  	/*
>>  	 * First clean up any freed mappings in the VM.
>> @@ -754,7 +754,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>  	 * schedules GPU work. If nothing needs clearing, @fence can remain as
>>  	 * the original vm->last_update.
>>  	 */
>> -	r = amdgpu_vm_clear_freed(adev, vm, &fence);
>> +	r = amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
>>  	if (r)
>>  		goto error;
>>  
>> @@ -771,47 +771,34 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>  	if (r)
>>  		goto error;
>>  
>> -	/*
>> -	 * Decide which fence best represents the last update:
>> -	 *
>> -	 * MAP/REPLACE:
>> -	 *   - For always-valid mappings, use vm->last_update.
>> -	 *   - Otherwise, export bo_va->last_pt_update.
>> -	 *
>> -	 * UNMAP/CLEAR:
>> -	 *   Keep the fence returned by amdgpu_vm_clear_freed(). If no work was
>> -	 *   needed, it can remain as vm->last_pt_update.
>> -	 *
>> -	 * The VM and BO update fences are always initialized to a valid value.
>> -	 * vm->last_update and bo_va->last_pt_update always start as valid fences.
>> -	 * and are never expected to be NULL.
>> -	 */
>> -	switch (operation) {
>> -	case AMDGPU_VA_OP_MAP:
>> -	case AMDGPU_VA_OP_REPLACE:
>> +	if ((operation == AMDGPU_VA_OP_MAP ||
>> +	     operation == AMDGPU_VA_OP_REPLACE) &&
>> +	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
>> +
>>  		/*
>> -		 * For MAP/REPLACE, return the page table update fence for the
>> -		 * mapping we just modified. bo_va is expected to be valid here.
>> +		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
>> +		 * bo_va->last_pt_update and vm->last_update or otherwise we
>> +		 * potentially miss the PDE updates.
>>  		 */
>> -		dma_fence_put(fence);
>> -
>> -		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
>> -			fence = dma_fence_get(vm->last_update);
>> -		else
>> -			fence = dma_fence_get(bo_va->last_pt_update);
>> -		break;
>> -	case AMDGPU_VA_OP_UNMAP:
>> -	case AMDGPU_VA_OP_CLEAR:
>> -	default:
>> -		/* keep @fence as returned by amdgpu_vm_clear_freed() */
>> -		break;
>> +		fence = dma_fence_unwrap_merge(vm->last_update,
>> +					       bo_va->last_pt_update);
>> +		if (!fence) {
>> +			/* As fallback in OOM situations */
>> +			dma_fence_wait(vm->last_update, false);
>> +			dma_fence_wait(bo_va->last_pt_update, false);
>> +			fence = dma_fence_get_stub();
>> +		}
>> +	} else {
>> +		fence = dma_fence_get(vm->last_update);
>>  	}
>>  
>> +	return fence;
>> +
>>  error:
>>  	if (r && r != -ERESTARTSYS)
>>  		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
>>  
>> -	return fence;
>> +	return dma_fence_get(vm->last_update);
>>  }
>>  
>>  int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>> @@ -832,7 +819,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>  	struct amdgpu_bo_va *bo_va;
>>  	struct drm_syncobj *timeline_syncobj = NULL;
>>  	struct dma_fence_chain *timeline_chain = NULL;
>> -	struct dma_fence *fence;
>>  	struct drm_exec exec;
>>  	uint64_t vm_size;
>>  	int r = 0;
>> @@ -884,6 +870,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (args->flags & AMDGPU_VM_DELAY_UPDATE &&
>> +	    args->vm_timeline_syncobj_out)
>> +		return -EINVAL;
>> +
>>  	if ((args->operation != AMDGPU_VA_OP_CLEAR) &&
>>  	    !(args->flags & AMDGPU_VM_PAGE_PRT)) {
>>  		gobj = drm_gem_object_lookup(filp, args->handle);
>> @@ -973,11 +963,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>  	 * that represents the last relevant update for this mapping. This
>>  	 * fence can then be exported to the user-visible VM timeline.
>>  	 */
>> -	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
>> +	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) &&
>> +	    (!adev->debug_vm || timeline_syncobj)) {
>> +		struct dma_fence *fence;
> why to declare it here within the block. If i am not wrong we should have declaration first thing in the function as it was before? 

Because the problem keeping the variables local reduces the risk that we accidentally mess things up again.

Regards,
Christian.

> 
> Other than that small nitpick looks good to me. 
> 
> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
> 
> Regards
> Sunil khatri
> 
> 
>> +
>>  		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>>  						args->operation);
>> -
>> -		if (timeline_syncobj && fence) {
>> +		if (timeline_syncobj) {
>>  			if (!args->vm_timeline_point) {
>>  				/* Replace the existing fence when no point is given. */
>>  				drm_syncobj_replace_fence(timeline_syncobj,


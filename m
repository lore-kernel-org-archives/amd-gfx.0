Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E89CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F1710E967;
	Tue, 16 Jun 2026 09:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gxE51YTU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2A210E967
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCroMYAoLJkelPazdwrVb/o/8eJKX2/oDpgGdwBEBTccL4DA7gtH7LOwJOrD42LSJWXkyVrTEYZT9vvsc4plz/M2qT3R3zvTZVnaHPRAJ2noYDu6YkyU9ORWSju7DGHtmCXtK2LGcYCzqmuQ4vDRSH5aANBxuTc31Dl2ur1O/rVASf/xGlyxfK2xt3JV9XN83vCSE8YLXLpip4zA+i/XHv483T5ARWxxg1InBjHKfnBYGTWg8vqS9yXNtSRiaOrM8X5Sy8XWlKlUNQsidA6Poc6jCNvzlQ3HSJb+cC0UPfSIZ/csaAf8YtdUNYkwuwXrLU2JhZdhJMlANVwlQQj7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TR6cFC9ERkVOSZqAIApZhWDkob6osy1Q+ahHVWUF+8=;
 b=E92WUp0BsiyJJ6MvPO24v1XQfnlqDRPH7/naPsdXLrIvpQ6Kl/fyDCLgkeHM5Zh0I+DblZe9u69jcFWKWDJQ8b2nGkKWEw3Y2uO6oDAld6B74ebmi0OMb2kAYJKUGfja87tehLl3rrAOWhSOkAXT2L3bZ7aZvVLAgRzRwRNSn1XU2AiyHjY/TNbnYxY04h49MtwpyPhc5hiOzON+qdbWQPAlb6ZVM+Kbiy28I1KTFsNz/dWlJ69Ag8N2GkPReqhqbnpiKiNI6uKScPJN7WqQhGTf+54HHmpyoocW1WE9eDO8f6Rocxpzcl0gASbYHKbzwGz3IdgygYEzGnTSwnd3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TR6cFC9ERkVOSZqAIApZhWDkob6osy1Q+ahHVWUF+8=;
 b=gxE51YTUhhTFV83whlvn1y0EvVbot3QpGlwidHLY/D9AanxuepRktlYMcjA3EGR9uDY2pLQJWT1LEdkkLhpOhq/j0GcE1zh35ZHxuIA7MwXsCMtBORURHRDf4AtZE9TnHpqr7d17s5GQzvLmGr5mhOTDH04astt6BAXSoPKwysg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:07:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 09:07:36 +0000
Message-ID: <2e351390-320d-4e05-b2ee-a83387abd2c3@amd.com>
Date: Tue, 16 Jun 2026 11:07:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu/gmc11: Signal MEMORY_EXCEPTION EVENTFD
 notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612055226.2879270-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LV3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3611039a-67f9-42f6-1878-08decb86b5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: X66oOgD7BX/6GhKwoh1+OS3KJvoM6v2+USOsd7Pzz4sGPHB4DuC7yGqicrTAhsF9FGam7E7qPnMMtMR0NI8ogwXc4uSB8Ve2lAj2wnjk5ZB2tIzFckoNjVFbgTVkcjZwnvWv+AJP6z9Tm34quTCnC1UYKX5aAlK1rsDq0zKTAnE50WjuIDJZVpkfH0VXOtDs/bmiUt0OaF3jaBkHQOVg7NtAVaknWD9XYIRmHX7vvQnSag0gJOwa90fpjXAkYZbys9xcJmAb2h3gPruA8VpF/uDi0dyAWAlPw7W7h0Y7r6eeSB7ShIjGd+PUXUb7IF9ZMMqeKyzRCYbPZxHz5bGMbYTBZXNc8sHhAiIxQHsMgrnuGPj1VYwMD7cR6J0l9yJaj4nUNJ9AKS2egie/BHxE8HhVX20mHyh4z3jFdqTd5MPH1A+wlcu+6uJqPO8Jrei8Eo9xvgvVO5U3bXvBxiqPzpcjx/X5jNepAa1JznRu3B3/NsJuI1IdjcmDPodGbodqOsnLlyVWB9x3Q6H5wvmsh6CNRexz/S2iGNMmA9Lwfk9+BLDxRN328gsmZrlB5abYDiAeDV+jPIFSjw9iFI5ouMHm9Fsno2WuEC3cfnbF82PBAqklLC7Jvz3pwv6FF579OBXe+TGpaBaTbto9ZCr20FC5IehEhTjYwznkW2gUnyCt5+d6FQWQ/j2msB7DV3Ok
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1lTUJpa1lkcEtlTWpPN1RQUDZ3cU9TNHR2L2JVNDlXNXY4RExEWUlEN0dG?=
 =?utf-8?B?c3VRUEJnV1RXa3RjdEJrcHMycnlWdHFtQTErSE5Eb1NlNXY0aVg1cUM4QzJS?=
 =?utf-8?B?VFZGbHpveFpYNEx2RE5pOHZTUm1EQ1BiU3NzSU1uRTUycUY2M1dnM0ZxbjN5?=
 =?utf-8?B?c09Nd0RTRWUyM3JZMWFoYXpBYy9UU2FML3RHdmZPSDJFSFJ2eWo5elA4Q1Iv?=
 =?utf-8?B?d0ozUXM3ckgzeTd3TTVURzZ3S2w3aSsvQ1JKclpOT2ZOZmVMekV0cUxPUUFS?=
 =?utf-8?B?SjFSYUlFWWp6NE14OEtROE9pMzdQZmhsTmpQc2c0ZWk2RWxMTzhaT0Faa3lI?=
 =?utf-8?B?VTR2Z2wzQWF2WE1heEk2bWNpemlnZnpNRWk5VnBtWkVmcGd6RzlQbVlNb3Zz?=
 =?utf-8?B?VTNBS24ramF2eDlTeS82azRCWFh1TVdzNGliTStvTG1pZkdqVXI1djNRTTRn?=
 =?utf-8?B?Z213MHRuY2VWODhuT0hrRUxKVHlBc3RkSHdXejgzZTg1Q000Y2lUTnRMZlB4?=
 =?utf-8?B?M09IejhCZ1l3L2x1ZmVYVTBhLy9Cd0xrOVpldzBLbld6c1N4ZDh4ZkRVejB2?=
 =?utf-8?B?QnlzRGoxVGRmcjBNb0gwTkFvSEdTR3V2a204MGNlMTF5R2tsby9vbm9vOGdr?=
 =?utf-8?B?WFJId0FJT1F2OXE2MGx2eXp1dWpYV1M4M0tqSE5DaFdnZzZlMDYxZWU0K2lm?=
 =?utf-8?B?WVhlT2VaNHplZHJIV0NkMEtUeUNzbEZRQmY1dGxVMEtLWGd6TmJDQ1VaMnZP?=
 =?utf-8?B?NEJWNlB1cks1dFhzRkcvdllBdWJ2blVNSzBJQ2FWbHUvL1ArU3QvcnBIQUNN?=
 =?utf-8?B?anBLbFFHQ3dkTTh2LzVYTElBUlpac0h6SGQwbnJicHVFV2w2Tk4rUVlEaFRq?=
 =?utf-8?B?R3dCYktaRU14OTB6NUl2MCsxdkxGbmpnN3JRWndySXpxTWw4ZndWcTM3YXMw?=
 =?utf-8?B?ZzBnQ1dtZXQ2TGt2ei9VV2U2MnFHbWhkQ2VtdHIrSXVUTkUyeEdKcU1BK3Zl?=
 =?utf-8?B?dC9URDNSMFRycFE5aE85MjBqTERvM2NhWHpSQ3BEOTgzNDBrK0xmbmpjOGpB?=
 =?utf-8?B?NkZPa3VjYVF4NHFYTkNvb2RkZjNQdkIrSkh6NUJCeC92R0ZqT0cwbks3NXFk?=
 =?utf-8?B?YlJSZ1B0aEFmTm0wLzJvSHZwRERiR0xqWG5YdGlPN1ZENzhPNDUvdjdoYlcx?=
 =?utf-8?B?SXZkMTZXNDFZM0hiMzgvZEk2aXlQZ3duMnU2NWprSEcrUUxhT2JST2VVZEZD?=
 =?utf-8?B?OGpOSlRJUnFhNm1Jd0pzUXJHN1lqYnJQaVg2WnYzQmRIV2NkZmxhUDQ3NmMv?=
 =?utf-8?B?dVlXcFY0bC80ei9vYTUwZFQrZStjc0QwTnh3Zm9UeTBTR0J4VVVRQUx5MHpL?=
 =?utf-8?B?ckF6aXRUZ25vcGpKWDA3TW9EdDJLdWNyRjlMd2U3eGdSenFaM0pvb1d6T0xL?=
 =?utf-8?B?WnYzY0lreW5tZWpsY05BeE1UMVRtRG4rNTd3MkxHUUd2MjRmb2VXbEpkbHlZ?=
 =?utf-8?B?R3I0WUZFbEp0M1lyc29oUUgrQm1hMVpiby9PallQNTlyOGZSUjRBSnRVc0Yz?=
 =?utf-8?B?Wit0NnJLQnZVMDcvY2FXK0J4VEUzT2RkSllXR0pISHdQQko2YUVMcEtKMDlR?=
 =?utf-8?B?MEZ0ZXh2OUFkaTVJeTZpcU90aVh1WnpqblRtWjF5U2ZBU2pxNFlSWUVoVnFv?=
 =?utf-8?B?MG5WVUhsUCtvRERpMUlPSGhDZmJLSE9Ic0t6cURBR2pOK3Uwbnp6VEhGREx1?=
 =?utf-8?B?c0R0Q3B3UGtoN0c3NjF0ZWVwK0RzKzRPaE5LcTlnaTZYMzFkQ2dXS1pUSHpu?=
 =?utf-8?B?b2pwT0FaSjllRHVsU1E4K2dXSEtuS1p5SWJOOHVqZ3VTM3RMSzBiTXV0bTlu?=
 =?utf-8?B?UDZFbnpWdXdrTUU5UE1OaGMwWkFtMXdEWTZtSmVQYTlVazMzOU9kYUxhcG9F?=
 =?utf-8?B?WStJdDE0cHB1cnJ4citjUDBuMkNteXQ1T2V6N1B3NE1qcDFXOEp6N0tzWlZJ?=
 =?utf-8?B?ZG1GdzZDKzZ4SWtMRWlBSzVLVGdZWXZ1T1YvOVdXNk9CRjlLaytZRFdJb3dQ?=
 =?utf-8?B?dG05bEpFdWhNZ3J4QkRUWTR2aUY4ZFlZWSswRXRPSEs0L3JGRUMvcjhUeWk4?=
 =?utf-8?B?SFdsSkZaZGFRRllZWWdTQzU4NVE5dGpBYkMvKzM1bDZZdnZQMXF0dzY0K2Er?=
 =?utf-8?B?UWtvekFPeE1mZXdvV1RwdloyaEswbFpTbHRGWjBXNU1PcVBZUlR2YzUzWklV?=
 =?utf-8?B?OEVWNWFrTDZUNGtUdTBzaFk3TGpzRldYMzNvM1JDT3RzWFplblZKQzNxbE1E?=
 =?utf-8?Q?s8UsKPORHszzUo+3md?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3611039a-67f9-42f6-1878-08decb86b5ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:07:36.9215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2XyxeVV6KANAqY9Q7gKl+2j1LWoIa54mlBV9cbH8+wIl/GC7IKeIFxuV6K/Ccja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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



On 6/12/26 07:52, Srinivasan Shanmugam wrote:
> Signal MEMORY_EXCEPTION EVENTFD subscriptions from the VM fault
> interrupt path.
> 
> The VM fault path already detects GPU memory exceptions by decoding the
> fault address and status. Use that point to wake up matching EVENTFD
> subscribers.
> 
> MEMORY_EXCEPTION is GPU-scoped, so no queue object is used.
> 
> EVENTFD remains notification-only.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 8eb9847d9e1e..2635fd308324 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -122,6 +122,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>  	}
>  
>  	if (!amdgpu_sriov_vf(adev)) {
> +		struct drm_device *ddev = adev_to_drm(adev);
> +		struct drm_file *file;
> +
>  		/*
>  		 * Issue a dummy read to wait for the status register to
>  		 * be updated to avoid reading an incorrect value due to
> @@ -135,6 +138,17 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>  
>  		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>  					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
> +
> +		mutex_lock(&ddev->filelist_mutex);

Big no-no, we are in an interrupt handler here.

> +		list_for_each_entry(file, &ddev->filelist, lhead) {
> +			struct amdgpu_fpriv *fpriv = file->driver_priv;
> +
> +			if (fpriv)
> +				amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
> +						      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
> +						      NULL);
> +		}
> +		mutex_unlock(&ddev->filelist_mutex);

This should probably go into amdgpu_vm_update_fault_cache().

We might want to rework the VM faulting code completely. Currently we map pasid to vm, but that means that we can't access the eventfd object.

Now that the KFD doesn't own the pasid any more I think we could change that to pasid to fpriv mapping (which fpriv->vm for the page table handling).

@Alex, Felix and Philip opinions?

Thanks,
Christian.

>  	}
>  
>  	if (printk_ratelimit()) {


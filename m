Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34C1F33804
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6495510E13B;
	Tue, 17 Mar 2026 07:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GDAdvspQ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEC210E13B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAYDGCSsFx8fEZfklV5krRdKsSTiRWWhPbnBCMOY2Zg59eNt4kJ935kuwdVr4fsJyFotWS3EGJKaiT0feTy+i1Ypdy6ejVLcS3ICnxc0hC32qpnXt/ba64iqaDbMgPES0jNV8zUlztxY2dXjbxlyFGsggZKfaV4VzFiyN0fO7t00/U8HL+2FmSXlI8kBkW4x1YpD3w8SF7380Kb31nXJJ+sfxaN1/GEI/rq97iQEmYEEKUh+KdmT8JLKzOSNxuuuGmnW0TI9lKpDGex947cTbkILDiDK6OCESklDSzj6bQqn/1tEcQknK2I3R08eMOMIdx6gu7ntHHyl4DpM0dQ1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBbthJGnrHc8pgeIH04GFN+xDWnnwUlwg3RqGcavV9o=;
 b=VcXUD09lHW5k3UchRTrBz4RYLAtouuzkR4YoqRq+SiBhVbbbobvC/GCUph8ahJkF7DqNPdTUFbYhPnyqSTcZgApd8tN4hec8lfowjhvv84cIwFX4YYYcI+AuQh4nv77HYiRnIm2Sa1gyM9QqnJRfGgpI6ehdyKRfKzFjDaSi+ZP3NvBA3u9DWElBRcvz8N7hGg9JOaACj08geRtr2O5STnJ60lF/fxQumNLJjyhXdamaMp/k49sAcAjW2VW+Vt9sXVTOLIOb4baz1EitZw+hgRWjJbEp9cvpzHK4tOBW31VC/bqSw6LXhE+IK8MlEAdqmwJ8JVJrtrmJzT6Mnz8qEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBbthJGnrHc8pgeIH04GFN+xDWnnwUlwg3RqGcavV9o=;
 b=GDAdvspQtvgBh/O23vTdV+wXpnRBCaY+SqaCxU8gCIfH1gtWz09keI1NPuKK/6iv/dkDyfRdIerJffz+48gU0Q9DliNoJh3E/7U0O1rM68LQN6ncEFbZcTOEUNT6ImObLOPNc2mz6zKCe+dro1I/XUNFVzlRiZBYouFUc/cZPYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 07:15:46 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 07:15:46 +0000
Message-ID: <b7f33988-6de3-4f27-829b-53891886e001@amd.com>
Date: Tue, 17 Mar 2026 12:45:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] drm/amdgpu: make amdgpu_user_wait_ioctl more
 resilent v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-8-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-8-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d212a1-c005-4732-336e-08de83f5020f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: HGeK/S8WVPbbk8RR4wxzSOHZrdhzMmCNHP73jsEYY6W91yEm2IF9llakS/iDSozx21khDVyOF2JEnudy3vIMgsajV9hJbOaC1SZQ5UxPHJIVT/RZRfVq1yRWvYDjjGqa3RjQfzD5au7NJU/2Luo4+JHstYo8LGzJqGRI6uMrRdGP0o6KJSCYP1Hl5Gw5MeYpIsrc1qmrVMQNwdoSp5PVzLsD/lSc4OCdMoQ17tAYflTm2Vd9gN4oBC3nSvu5Iv5MtBoC/Z8HhyqwgZEAcbzRxW2wqeitJiY18qnWycCf9D/Z8Qmymon00srRs3TRsaihnwH72AY9XQQQPGiWclTelpYewV185AtBveXmoyVW8uIQt7YCWSF/YBvdX81Ku80CPCXiD+izZTjRbHt7Tfvdl0dftsMASN+IvJw8AAAaF+BkEB/n1RoWJ4JOIH4wMQ+vOeKI+VdlTmlzK4Zx6TxS7x8YyMXNd7l9U+QyeUiAwwTVjiGPGirSEfsptK8dH/kIPZuyASXUvIiDaEB5+GTWnyPAlaSOapjvzXDwrtEBKLPPR6PKFP+0KyMT2T0VsLRLJdkKM+mG/exqSvdL2me/XNdIoWF9+Gv2jZLIf7VLWJHgy/woSGTECxRXrBo2sJUFAgquBLrO/fzZ5vJQ81aBUllwXrLfRDH+9tyKaIZCBAjPgPYFKOKGG7MABmM/BaQyxd3L0vy2XOPBHuCmvuA7NUXk4unoIMeDRSOKEKtrd5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWk3SXRZbzk5QnpxV0RRb21ROUI2by9HeEN4ZVlvTVNOY2I1SysxK2hKbHdp?=
 =?utf-8?B?M2tNUjlpVGNiQlhaVVhkOVlEZ0VBWG55bEZSVFFEejJ2TS9ZSkVSb0NWTHk2?=
 =?utf-8?B?K0tCcWZ5Tm1CKzIxczFDZnRVY3E2b1Rrc0dCSDNnS1BWcU14cU5xc3lZM1lS?=
 =?utf-8?B?VWVsbUlVeHJTaUU2YVp3Yjhja2ZtOXZrVVg5ajFtSzE0U29Fa1VMZThmU1J2?=
 =?utf-8?B?V1N3VHVBSXI4NHN0ZEhRb3BXYnk5TWQxamoxcnk4YVpYUlRwdHZSYTFNcnRF?=
 =?utf-8?B?TWkwMnV1eVJJOFFsMWNvb0VHUXBCWWtybi8rcFpLMnhQQ0dmN2lDTW5xOHFH?=
 =?utf-8?B?Q3hqSkdpd3l3OFVScXVHNC82d21QV1EvcWROWnFKcVRjOEtRREJQK1A2ZWIr?=
 =?utf-8?B?eWovaEVxZmVRbks0S2JVTTF1REVaZnY3NzRWazZSQ09qam5LRjAwcC9YSjZF?=
 =?utf-8?B?WDY1aUY4TWYxZDZoQmJZWlFBWWNIZDdFVTF6WWIzUm03WW5zSDJYcm45TXIx?=
 =?utf-8?B?N0lSaUxlTDNnTWpFVkxRVXY5bURNd1V2dzFsbjdQeGx2RzRaTXkrZUluOFM0?=
 =?utf-8?B?Myt2clFsRGJ0UFRrTUtnRVhyNjU5Qi9QZUxaQTQwT0poUEpkVlh6K1BhQ01Q?=
 =?utf-8?B?Qzg3MzZ0bHczMmxlVDZwdmc3RU5pakJGMUlTd050bzVlMXAzOVdRcUlyNXNx?=
 =?utf-8?B?YW5YUWZOalBVcjdVcE9XVlNMcFRGUHZxTzNKTFllUHI4ZHhKMXU4Q1M2TnA4?=
 =?utf-8?B?d1ZRcHorZm1wNG5LWUhHZWtRZFVLeEd4aHlSaklHdVhyZUpRUU1QRElUaWFV?=
 =?utf-8?B?RXljcjBJYmxJNDlnUGJRY2pKMEpUOGRHWFpnQTN5ckxTbjNZb0FsN3hvandv?=
 =?utf-8?B?eVFVcFptQnJKS1p1VkprUTBhb1c2WUlKbVF1R1Bxc3FUVDdhZ1FQdUw3Rnli?=
 =?utf-8?B?R2JoYTRLbnljZTdFK0k5bE5wVElKbnp2aXE1NUJCZlNOOHd6elhtNkE3dEY3?=
 =?utf-8?B?R3JVc3hWRDByNjBVVERHc01YOFByRkZDRjYvRXo5cTFEd3NKMFRuRGZockR6?=
 =?utf-8?B?ZFcxQmwwQTNjWStMVWJxYUoyVGR5YStTK0tINnFjb1ViZk5NVW5td0N2R0w2?=
 =?utf-8?B?clFWaTJvZm4vZjVGd2FKNFY2cFAvWGFTaEJrLy9ES09hRGVCSDlrbU43NUx4?=
 =?utf-8?B?MEoyWnJVbUtjNVpVUUtHMDIxRFg1TkNNSVpwWHFTMzU3dU0zUUk3UjhLT3Nu?=
 =?utf-8?B?Y0k1aE14SXBrUzQzOThidXY1WGVOeWVLSmVqUkR3cTZqTmlBWkRzMVZZcGVG?=
 =?utf-8?B?RXhhb0JPNWJQbStsS3FyU2RYMDdOUVdhTHdTdmhUNytidnZNTmplVUNjNHp1?=
 =?utf-8?B?T2ZwUEFFN3dmSDA0ZmFSMlJPaFIxVDBOVWJNVzBkUml5NE9VbzBkTjJJQU1E?=
 =?utf-8?B?R3hPQ2VkR05Zandhb09QNk5SOVBkZ3g0WkZzc3RScTZsempUTGVJVzlwdkZY?=
 =?utf-8?B?WGJKcjJoRGhGbktnd2xPMWcrTnZ4Y3Z2WjEwNitkL2JYOFlpVXRJdWY2MmV4?=
 =?utf-8?B?STRXVEhDUjlBSldXNHFlMnFuTUV4UkxTM1l4cUthelVYekRBOXYreVFUTmRW?=
 =?utf-8?B?UCtsYTJXcVRWYXdyVmRuYU1pNlhDdHdNOStSYm5id1BuZjh0UjZvSDF1SDhI?=
 =?utf-8?B?VkEyTFgvV0JOQlVmR1hEakdqV25rM0xJU3k0UjhyS01KbW1nWnVxZVl5Nlh5?=
 =?utf-8?B?UmlxSk5DZnFxSU1YejdnM1g3OGxEV2ZGNTltYXRUZG1FT1JGaTEwUGhPNHdt?=
 =?utf-8?B?S0RYdVFYcXlkdEw4YUxWaTZnSGVTaWtlOFNQQkxad3JtUXB5Q2dBYlhMK0JT?=
 =?utf-8?B?ckpwSFdjREh6bTJ0MG1qRUZ6VCtUV2NIQjR4ZHBsWWZRNmRvaVR5aXVIRVRk?=
 =?utf-8?B?RWMySXUyeGVsNXhUOVloSituN3VwazJGbU5iY3FWZTVhREVESUtCSml3RFlu?=
 =?utf-8?B?Rlk0S09IMDRURXNQTlNScEVaYjFuaWVybGRBUTMzK3pWL1o4eE5MTk9KM1F6?=
 =?utf-8?B?akFNTFRJQXh6MTdQR2lpaktla3Y2cnRxOWtJNXhqT1dUamlTdUhnME14SWN6?=
 =?utf-8?B?ZzAyU0sxdUZrVzJianI1MHlIRHdwblFOU0ZlMlcrVW5tUzFjN1ZOQTVjQkg5?=
 =?utf-8?B?akJ3T1R3TExhVkhMVUpybHBnejR2VFk2azFDK3hVUk5KTEp5SGh1dzVWM0hJ?=
 =?utf-8?B?VnhpRXVncDBZOXBkcjFoWVd2aTN2Nmwza2NtMlUxcFhaZlIwM09SK0hJM0d0?=
 =?utf-8?B?Rm9KYytxc2ZhL2RXZi9GTjVPSlpCV242cDVrOXNlaXIvVEZiVnhrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d212a1-c005-4732-336e-08de83f5020f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:15:46.1380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ihf3zEcJLCr1gdwnoM4uwxDWr2JpyUq15Cyz3gANmaaC/pamedJ5u07pNQ73J1kGGs8xjfZejSlm8tunPgHsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660
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

Looks great, more cleanup.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11-03-2026 12:43 am, Christian König wrote:
> When the memory allocated by userspace isn't sufficient for all the
> fences then just wait on them instead of returning an error.
>
> v2: use correct variable as pointed out by Sunil
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 49 ++++++++++---------
>   1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 14a289c782ea..4d043708574e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -706,7 +706,7 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>   			num_fences++;
>   	}
>   
> -	wait_info->num_fences = num_fences;
> +	wait_info->num_fences = min(num_fences, USHRT_MAX);
>   	r = 0;
>   
>   error_unlock:
> @@ -715,6 +715,19 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>   	return r;
>   }
>   
> +static int
> +amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
> +			    struct dma_fence **fences, unsigned int *num_fences,
> +			    struct dma_fence *fence)
> +{
> +	/* As fallback shouldn't userspace allocate enough space */
> +	if (*num_fences >= wait_info->num_fences)
> +		return dma_fence_wait(fence, true);
> +
> +	fences[(*num_fences)++] = dma_fence_get(fence);
> +	return 0;
> +}
> +
>   static int
>   amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   				    struct drm_amdgpu_userq_wait *wait_info,
> @@ -758,12 +771,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   			goto free_fences;
>   
>   		dma_fence_unwrap_for_each(f, &iter, fence) {
> -			if (num_fences >= wait_info->num_fences) {
> -				r = -EINVAL;
> +			r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +							&num_fences, f);
> +			if (r)
>   				goto free_fences;
> -			}
> -
> -			fences[num_fences++] = dma_fence_get(f);
>   		}
>   
>   		dma_fence_put(fence);
> @@ -780,14 +791,12 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   		if (r)
>   			goto free_fences;
>   
> -		if (num_fences >= wait_info->num_fences) {
> -			dma_fence_put(fence);
> -			r = -EINVAL;
> +		r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +						&num_fences, fence);
> +		dma_fence_put(fence);
> +		if (r)
>   			goto free_fences;
> -		}
>   
> -		/* Give the reference to the fence array */
> -		fences[num_fences++] = fence;
>   	}
>   
>   	/* Lock all the GEM objects */
> @@ -817,12 +826,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   
>   		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>   					DMA_RESV_USAGE_READ, fence) {
> -			if (num_fences >= wait_info->num_fences) {
> -				r = -EINVAL;
> +			r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +							&num_fences, fence);
> +			if (r)
>   				goto error_unlock;
> -			}
> -
> -			fences[num_fences++] = dma_fence_get(fence);
>   		}
>   	}
>   
> @@ -833,12 +840,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   
>   		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>   					DMA_RESV_USAGE_WRITE, fence) {
> -			if (num_fences >= wait_info->num_fences) {
> -				r = -EINVAL;
> +			r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +							&num_fences, fence);
> +			if (r)
>   				goto error_unlock;
> -			}
> -
> -			fences[num_fences++] = dma_fence_get(fence);
>   		}
>   	}
>   

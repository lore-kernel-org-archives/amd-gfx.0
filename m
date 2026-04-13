Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D51EBFD0A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 07:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C4C10E343;
	Mon, 13 Apr 2026 07:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oaNObbFz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559F310E343
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 07:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWQpN1PefiHSjqvzz1Xeqg1O3tt1rE1mhyGO4EBb9NULETaKoEnqXCL1/CtavRRgpG5uKvVoZ3/FDE7xxfsARvye9ael4BX+Vrt/nnVErYjjiNHQZnp6lXPP2Yb/6iv4YOtCFCsKzD+DgLU2EMRigq8oCIUq7BnD07ruSN8ZZs+6rRfOzmKzC97Z2llEtUQOoAAN4xzlwTkojhcbgqkQL5CWyiJA4X/i4mwFI+tZV67DN3ZMH9j6Q4udxUbQA+3sQRM9f0Q64tUu8r8Xk86PRn3ImiEcxqyElmfJfrjSn/0/zDPk7PFpgLKVhufJlO+MIWx3UT/H3OzZhaSTJPU9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6tR+WEi+6XO5bx3SV/+SvKNTKX19wySCPft7pXRL/U=;
 b=udbUuLK4kDa3f2KZ7nHPOd7ICM+Pskyfh1d5nwc0BkU7rsV8NMI1AY+kDH/XU3uUVG4x0//QhS0aJL7lmDdVfSEOINIf7LXic2L7VZ4TduNjw26C0qo27Z5+c57yxIHAVOydkm6o+e+tJSI+cFYfM8ohjD+ADt8qPLOOaMF0UKjytFyJx5Ir15b0zur2KXAXwUE5lypRZTLiyvx4jlyg7i5rdV3JzP6NulKDryXCLzefx1T6zBhulwvTePZyh+v3Jw/8RMMaEW2abnK0Mkw9DGhQxpsc83SklQKnxJgSDBc+6dn8+FGjDl+jX2sZEjhBj2tj1IO6YwvYp8GLNw0AmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6tR+WEi+6XO5bx3SV/+SvKNTKX19wySCPft7pXRL/U=;
 b=oaNObbFzW0DetpQ2awzpLuSpwhqf9TLeqIDa2dPedqM6MD5F9V5Tx9W01Mvc9J3KtK4EQ+Lka8uG2Xi092EG4aRAIz8E5/Jz90SZXL3V0ciTD1TKst4h2iAdqb1yMYN5L9EuMZlQALpec2oia7Kj0rqyu+5xAdW0thcXA7d75Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Mon, 13 Apr
 2026 07:46:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:46:36 +0000
Message-ID: <316c08e2-ad87-4e04-90a1-65064ec4eeca@amd.com>
Date: Mon, 13 Apr 2026 09:46:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop userq fence driver refs out of fence
 process()
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260413061744.3458370-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413061744.3458370-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 67057921-dea2-4e44-477b-08de9930ca56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: PiDrztOD72zFShI21BsF+pyTnS3VRE+15cXwSE7G13aoOZ5kkIeIsRZiHeDOeqL2FQBHLRrbvFGtcso8+kviZgYctu5q837J8VFw2hVuLFAKhHODqp8Ft45AJiToO+gi8DVQvFHYDKBdNycOnXFP64iXA1cv7Te8/r/CRRwdI4WCn1Bso8PXARvPMt/LfyHoeiYngl8aOZM/9J+Jxcv6QDW6DAYsv0bsvrb89nl7qeyOdTQlrdsgUzo7O/ULThlKKKurk1Af0BAa1R7x4gt/s/jZdirbkQFaJavlWWMAsctSwFR873s3T6eCBxuZpzLL0AP79n7jmM9ouFzmeHQkIMjPjC+JJ5L6loPW4lFUUk9qaYN7//QzWP8hv5grX5I/V6lTR7LfM6uXTc98nZiI/3bZPZJELUSmiApuUuAnt2FuoNZ2xMCAcR3aqcl7zPFvR0XRz4dx/nV3WQspf5SfFBwJ++rQdG4vXMMvR4ezruH1OmxV4loa15Py6exCtXYFRLxtY+/XEheuBhAh1E3PpbF3ngb49VGojvH6g4673rYcxNwWb6Yn7EMI+mS0OvoYNufNoBc66g2/Hy7Gs+avVp3++cWMmz0UIkV7wWiQpODDLspzGp/bySLit3Dtvs0MuBCMqL172TFUtw4YuCoDORQUABupNiKo/1yKohcFPk7aQDcFjIBbweHKOTMfj1qBbKZ+TXzkuwfVsUv5dHLCCDqbfk8KZpvk9AkVbU8BtyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjF0NUQ5eGtudHNsMHZNamlxaUdkVHA3OHZFRzhNalhvZ0VCTThxNmVQWVBa?=
 =?utf-8?B?MU0wWFByY1UxcmIrd1lRRko1T1RuVzdNbmNxVkpXSk9kOW9kYjZUZEYzUFoy?=
 =?utf-8?B?aFZDbjhnWlQ5UlRZa3IrR056bUNjc3c2M2ZzZHNaN2ZKRU9zUXZSb2QzRm5i?=
 =?utf-8?B?aFVHWklQN3Jsbzh4Y3gxZlNyQ2pQR1R1UmFsc1BYVzE4eDB2a0h4YkdXaUsy?=
 =?utf-8?B?anBDZEQ3QSt2WGI4ZzZQeExYZFRxS2F1VDB1S3NWczhNMzZMVGc5czQ4bjdQ?=
 =?utf-8?B?bXNNRnFSSWgvVGgyVVd2ZDFyQlhVM1V0ZVEvL0JCbFVMajBqNEllOHRnUHhS?=
 =?utf-8?B?dzdMaG5tSjA3VUIydFF4ZWZ0OUxUaVliSHhMSG5mUkxhdjU2SnVHdGorWkYw?=
 =?utf-8?B?VGo4SmF5V2ZGT0dEQ3JIZWl0bi9TdnBuU2pVRjdQZ3ZIQWJVNCs2aG0rL3Rh?=
 =?utf-8?B?MWRtWWNEUWh3Z3BoWEdLNkVpb21jZTdoMVFhT2pvcE54dE1XRElXZGc3S1cr?=
 =?utf-8?B?ajl1b3FRcVo1TGFPbEdaWFUrQW56Q2ZDd0p3dzhpcW9acFlLZldsZnd4Skhj?=
 =?utf-8?B?dWxrM251YVlJOFM1V2hQdmgzbHplc0tkS1ovcTVvVE8wRVB0dk9qczBORGtZ?=
 =?utf-8?B?dnp3SlRJaURyTStpU3FzbjA5VFZjSVpJUmRONFJhd3ZBYk1TWnZ3MjlZTVJH?=
 =?utf-8?B?MHVxcHFJNk85R3c4dlZZUy8rREFMTlFsbms2MllRNWVQY0JTU1BKL25GRmpX?=
 =?utf-8?B?NnFWZTJLeXpCVUJOK0VFdnJSdWtVMXJFS1p6UWJRY2F2V3dMaGJWRDh1WDVJ?=
 =?utf-8?B?OCtiT0JVSXNqdU9kTTZOTmxtaWw4eENacHJkTGZ5dXZOd3JSekEycDNWWVRI?=
 =?utf-8?B?YTNNYW5RQXFBMUhzTlpmZ0FEaksvdzdVNDJwTE5HMzd6b29VMGVhUUZQd3No?=
 =?utf-8?B?eTM3eEdOVXRLdXZvVHVSaGpGSmNDa1Q4cXFaSlQxM2dCNlAxcVhieUdRNEZH?=
 =?utf-8?B?ZG1rU3FReHZBYXdCRW96KzlSYVNocmMzZ20rOXZNbFJRQy9ScE11YnVuaWpS?=
 =?utf-8?B?NFNDYTBYN3ZxSFBIZDlWQXNyeFp5K1pHanh3VkthOWp5TE9CcWc2dGYvZzJw?=
 =?utf-8?B?Tm9TYzdMa05rVm9OUzFINHAySjlBMHlCa1gzblo4QW1GT0krV0kveHVSOFZG?=
 =?utf-8?B?bk5OaXZHam14dThQRVRTSGZ4aEVSL3hMMkVWdlRxcXhSRVllNlFQNGx0V0Nx?=
 =?utf-8?B?WjZYcHFCUmpvK2toOWRka09Xc29kMkhnSW1lVzF0UWpET3VDUmhOWG9pY0J6?=
 =?utf-8?B?L2NFU1kwNFVnUzhtMFBQUFVkbW9SeFpKMUN4djg1c0tnMkNrM1Y1Z2xWWS9h?=
 =?utf-8?B?eXZDVnkrNFVRaHVqR3pLVGl6MksyTGlFbFhBeWJNbW8vdDRSWG1lYytUcmxT?=
 =?utf-8?B?U2R5azFra2NiQ2ZpZlRwcjZxaTlwUWhscnIxcmpEODFNQ05lZmFyZ3RRVnFK?=
 =?utf-8?B?dVVzOUt5R3MvdG5oM0Urd1dXWXlicVZ6NVMrTkxRZ1FyUGdNMEs5U2xnMnEz?=
 =?utf-8?B?bUx3RVVtMTloV0tCUkYyWDhvSU9nOUxlZUgvcFUzUUluYkoyYTdpUzVVais0?=
 =?utf-8?B?YUpRNG5ET1lnMThMTUhWbG82SmZEVkRRVjRpcklzTW5BQUVXdTN1QXBrSVFx?=
 =?utf-8?B?U0ZuS2hqMHpjSWltT0pQd2tZdldnM0EvVTBUeXV1QXVxOVhaTHZXaDh4bGcx?=
 =?utf-8?B?Z0pIalBFdDRQZ1JxTCtocmhWMGlBbEhYNTJOa1VlYjQ5RmxHVUpqQ2Q4SUda?=
 =?utf-8?B?cld3SXQ5M3Fvc3o3UXllZHR4MHROZllubXhhRUN5aHFsZUJNa0JJVUUremc4?=
 =?utf-8?B?a3NzSXlPNGNHRnZvSnpUNVpvM3V6dWlDUFNqMTlXL1lNMTdWekVUc0Iwakk4?=
 =?utf-8?B?N1FWM0d4VC9TamxESW1MRkxPZFkyK20zcGlDWWRNVVM0eE9vNTF6Nm54aTBs?=
 =?utf-8?B?U3czN0FGdEM5cUY2MXlOa3RDMk1VS1JTdGFETkwwVkdLNXUwWFMxaVg2cCti?=
 =?utf-8?B?MlV6eUNUWTRKOXMremlKcEFiVjI2Q2VQVWZIajBoSXNKSnJTT29XaVlnU2F5?=
 =?utf-8?B?bTFkRER2TzZFNVZKU2tIdnhMTzlDNE1LU1krRDBia0YvVWVIcndJWlM5OTJ2?=
 =?utf-8?B?UkJDQUMxMzkrRUpzTm9qZjlNcy95bkc3ZUlYL3Y0VFJEeUNiTUQrYWFlSWI5?=
 =?utf-8?B?VlZvYk1jczl0YjZZVHdYaXFrVVBiMnlYVVgxY1dUaWtnSEVvdzN6K3IxdGtN?=
 =?utf-8?Q?zWeHNVH8k/VKy2sewk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67057921-dea2-4e44-477b-08de9930ca56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:46:36.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FUutJJf5WU+ZNmRaqRKxFdIiHE4jXWxSSPBVlaUaZhACJ5/gFhs+hRr85eVkseg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

On 4/13/26 08:17, Prike Liang wrote:
> amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
> drivers and stores them in waitq->fence_drv_xa. When a new userq fence is
> created, those references are transferred into userq_fence->fence_drv_array
> so they can be released when the fence completes.
> 
> However, those inherited references are currently only dropped from
> amdgpu_userq_fence_driver_process(). If a fence never reaches that path,
> such as it is already signaled when created, so we need to explicitly release
> those fences in that case.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 54 +++++++++++++------
>  1 file changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3be80a82788a..f132295890c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -145,35 +145,52 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>  	amdgpu_userq_fence_driver_put(userq->fence_drv);
>  }
>  
> +static void
> +amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
> +{
> +	unsigned long i;
> +	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> +		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +	userq_fence->fence_drv_array_count = 0;
> +}
> +
>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>  {
>  	struct amdgpu_userq_fence *userq_fence, *tmp;
>  	struct dma_fence *fence;
>  	unsigned long flags;
>  	u64 rptr;
> -	int i;
>  
>  	if (!fence_drv)
>  		return;
>  
> -	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	rptr = amdgpu_userq_fence_read(fence_drv);
> -
> -	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
> -		fence = &userq_fence->base;
> +	for (;;) {
> +		spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +		rptr = amdgpu_userq_fence_read(fence_drv);
> +		userq_fence = NULL;
> +		fence = NULL;
>  
> -		if (rptr < fence->seqno)
> -			break;
> +		list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
> +			fence = &userq_fence->base;
>  
> -		dma_fence_signal(fence);
> +			if (rptr < fence->seqno) {
> +				userq_fence = NULL;
> +				fence = NULL;
> +				break;
> +			}
>  
> -		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> -			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +			dma_fence_signal(fence);
> +			list_del(&userq_fence->link);
> +			break;
> +		}
> +		spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> -		list_del(&userq_fence->link);
> +		if (!fence)
> +			break;
> +		/* Drop fence_drv_array outside fence_list_lock to avoid the recursion lock. */

That is a reasonable, but the resulting code looks ugly like hell and very inefficient.

Instead do it this way:

list_head *to_be_signaled;

rptr = amdgpu_userq_fence_read(fence_drv);
spin_lock_irqsave(&fence_drv->fence_list_lock, flags);

list_for_each_entry(userq_fence, tmp, &fence_drv->fences, link) {
	if (reptr < userq_fence->base.seq)
		break;
}

/* Move everything which needs to be signaled to the to_be_signaled list */
list_cut_before(&to_be_signaled, &fence_drv->fences, &userq_fence->link);

spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);

list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
	....
}

regards,
Christian.


> +		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>  		dma_fence_put(fence);
>  	}
> -	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  }
>  
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> @@ -228,6 +245,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  	struct amdgpu_userq_fence_driver *fence_drv;
>  	struct dma_fence *fence;
>  	unsigned long flags;
> +	bool signaled = false;
>  
>  	fence_drv = userq->fence_drv;
>  	if (!fence_drv)
> @@ -275,13 +293,17 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  
>  	/* Check if hardware has already processed the job */
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	if (!dma_fence_is_signaled(fence))
> +	if (!dma_fence_is_signaled(fence)) {
>  		list_add_tail(&userq_fence->link, &fence_drv->fences);
> -	else
> +	} else {
> +		signaled = true;
>  		dma_fence_put(fence);
> -
> +	}
>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> +	if (signaled)
> +		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
> +
>  	*f = fence;
>  
>  	return 0;


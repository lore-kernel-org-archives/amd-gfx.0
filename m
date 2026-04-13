Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C417AEBFD0A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 07:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6418610E34B;
	Mon, 13 Apr 2026 07:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LR2o4TZO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC98610E34B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 07:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l02+w8/0X9/eOARAcXrAjXbItMGnd1+UjS09FZDOQ37qCyiOEBdD8/t9GzXH7lpWyU8mp8KlDfHQ3Z2ChIvmkHH9Ntxp7xGcXuIesKot0jM+Zp+XQs5TBl2akWBb4GuB2LOPxqYr0h7mrOKbVcI4mm1/S7J6/891nQlsU8DbYnen6KtWQdaOJjsiuVQ8jbtt37dd/74QR7cVEiNNVlkOv+6FfBw1jKGj1emY4lWnW9y4dXPNklPXmK8KYPvqpyOYfyQ9L8dMQO+6PiUSByEOZHNCVTo80kbXu82VzN/YEpeuNdS85Upbn9/1vwixEMROfzjbeotkbsklKUoOgKzLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd5NLyp/PAXzljz96qbBOXMUcm47SZboLI6R5YvP4YQ=;
 b=DmwJb/em/FJmSwSx/6f0nLLZt2CygDH7S26ZgVl5RaatSwZCbc6fUqQFnY6B9ZN33yrj9+DGsOmgL707s/reSE3WLhAHvgkgCdXupqG9KelggsIWQTlZawocJwKMM0Xg2utiB9Xo3HpEjupzBFAbDOFTErYRnzRYF5+RUdT3f/tLLT7AivZd5+OxfDLX2ubw2iyFy98sEXyqH74URdaCnc2iFZFih5T9+sQ3teDIAcVa/mCwdPqsd9DoUz+o5Z/S+89UFS/3G8IylFSK6j1BYb6OEMgM/eo7f/9igtBAfB4zqlWvxyHVASYyGYy9Pe9WHEtNYcfiAdvZz8O2lcCihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd5NLyp/PAXzljz96qbBOXMUcm47SZboLI6R5YvP4YQ=;
 b=LR2o4TZO5XjqXAuT0lo3PdmQsj9ju3wsIstk7CWomQqu86IlYX251TpcpilNHSbluE7uanDp1rYs3lmqB8jrdXtEm9RI1QnClSGP8DWiZHHBCN7d6k+zLW08wDmzHiaCUX8Ah6cUlbk8YRBWXQ8TJ0BJQ5i79NL7/7z8GVWUYRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Mon, 13 Apr
 2026 07:54:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:54:42 +0000
Message-ID: <c87774a4-f869-48f8-b109-7682a48a33e4@amd.com>
Date: Mon, 13 Apr 2026 09:54:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] drm/amdgpu/userq: use pm_runtime_resume_and_get
 and fix err handling
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
 <20260413062153.4050981-5-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413062153.4050981-5-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 4634a44e-9de7-4bd4-c8d8-08de9931ebf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: lCwj1iZH8dCAolK+7F69tv6W7xLWyv8HF1ZZj0nbRIv1RuXu70TIc8Mm7RAi4YfO4djJSB3C34B/xdj0JYHMu4p5EMPuy+4xKJkXCNr68SICS4vvHRu9c9YF2NKY4ko8udvR8nEY5Z6dojiquZaNzOykHaU+RvNmudup3yikQPaE0CiOLpax19FWk/nPkNMexE6G2tfM+lxS0xQ6siHV/9FsFw8VjElIa09nvmntvYNPspmIQrGnDjTc5TQA1b9fGyF2l7JTKWbo5A4zs9/2oonmfsDhqjBgDSGVhlt/11ES1/frjCJun9XTDTH85bGUVv7KZ0RsbtZCzjxkYnZKaMIZ1DymZSgDAQvBxoLlevtsPcEgVWGjSOMzt1LUxyQYhkzokPI1HifE68MRZnH0ZdqRUu70Ry8jFdNZhyymzMykcFgTOXNWEyEyWHPVOhnP1WVg5Ktiw8SlDKIKZJqvkM6HIPxH06LqYvuRSYQ3CWP8EiFFMg+d6W4KNEu0cylrfN1AlUFkwJgG49FLFChm55uz/K/jl1UpJcvRXmo8Y7HiIok9rg08t3nQWsKXqBm7y6fcAs+F1p/vRar2WTaFCfgn/rC1YsPYKoRpjO5LZO91YvjibGGZ8SbN7Ax084oKW1Q6q2Ckldhph+b0FcUDBp6t743Xe95Uoi9GtJvUBpU5I6+qe/mVpwZPqdPW3sLyRRAKOLJCBosxRnF5KEa32vV0yXmdJ0rdnBu+KW6TGbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHFDaUFEcGt4WDdvRWtPekpzOTV6S3Z3amg2a3VtNFR0S2dkQitDV2RTNCtj?=
 =?utf-8?B?ZmxTeS9MU1dHL2NHSkJ1VnFUY0U3WWVQOEhkZ2xFK1N1WlQvemZJY3NldFBJ?=
 =?utf-8?B?NzhWZloxeEl4STdobnV2L3B4ZHVEN21vN3RRS21VZnFSUytJVjQwdnEzNkMr?=
 =?utf-8?B?ajM0TFdwTlVCbkRhOCtjWjdnT1UweEcwTkx5SkRXWkhLUDhWQzBiV1d6azZn?=
 =?utf-8?B?MmVzSEhXTTRlWG16QkF6N3VsTkNhb2dTQ1VmRlpqdUxxdDRYUWlaUXpCVWJZ?=
 =?utf-8?B?TGpyczF3S3dqd1VXc1Fyb3JBaVltWlhHWjFiMEdOVjh4Z3JWM1g5UHJnS2c2?=
 =?utf-8?B?Rk5vNHBVNDFZM05SRWhNVXpZTVhpY3dMdmxVQ1owUGdGWFJVVmE2WitueXMz?=
 =?utf-8?B?SW5KV2pGQzVici84SnpWVGJvVmhDNnNkOVFKd3RtN1F4eXpqOXVLQURSNWRO?=
 =?utf-8?B?T2QvQlpQOGoxbSs4aUVDUXd6ZUdSMFZUc3Izb2VkSVMxTnBCU20zN0hCQndu?=
 =?utf-8?B?cHhKLzIwblBCS1l6K3JzeVpHTEZtVnZsMTBwejI3TkdST3A2eFNsRmkwQWxm?=
 =?utf-8?B?alJzcWtMcVpySm02bWpVYWQ2QjgvMnFOTkhHcHZjdkFKUmU1aFhYZWV6OXlS?=
 =?utf-8?B?WmZHS0tzdXRIa09RZkhjOW1NRm5MNEJoOWsrckUzWDFyVnhrNHZrVi9lZnkw?=
 =?utf-8?B?VkdaZmhmQVRCZmIrR1ovYmVGOEIwcm1ocnhFSjlFUFlRZ2RKVXNNTEc3akdj?=
 =?utf-8?B?cCtsQVdGc3huTW51TjdlVFBEUHFESS9xS1Vaa25UZUhzMERpSml5TTJ3UG92?=
 =?utf-8?B?Y3ByaElJdFBkdnMrSzNiU1Zwc2p0ZmNmQlBhNTQxMXcwcGUwdTNzRGlCUndC?=
 =?utf-8?B?dmthMnlUNkdMeE94R1RmOWlPaWdkWjhmMzJJbnVQbWpaenVSeDlkR3pETGhW?=
 =?utf-8?B?K1BiVFdxY1pOYy9YYktXRmR1MVZqWWFOMmZsYlNJZm9CL2JWWk1keC9NUGwz?=
 =?utf-8?B?bTVqekhjd3U2N1dqdkxnZXd3NDZxTURwT3FvOFdrdVpoeUMwY2J0NEdrQmEr?=
 =?utf-8?B?NmR4UWsrVFVJN3d1ZTNFWVk5cWNJSnlBZFZ3YUtIME11Um1ZclN3YkxzSndj?=
 =?utf-8?B?TC9ScWpmMlRLaDJuSXZIK2xCZXo4V0taV3pvSFNRSDhLOGhQZ0d2Uk81eDZW?=
 =?utf-8?B?c2xtUDVEU2RvM3hGQjhuRHdreHRuSHlXRE10UGgxOG1CV1EwR1lTZjkrQWEy?=
 =?utf-8?B?TmZzRnE4NEhsblF2OWRDb3d3VmZVU1dxbDhhdEV3MStzRFJaVmZ2UzFEZWZC?=
 =?utf-8?B?elNOM1RIWFhTQUdBVmdsdkFHaUxSWEhwY3Y5RWRBRU5saitCSFNWU0w5dW5D?=
 =?utf-8?B?OW1HUFBreUN6b3cxVzNrT1JMdU9NUHZhM1ZiOUgvdDRjbVlDaW1OdXdHeHF5?=
 =?utf-8?B?aVhWaThDZ2tMY2E2N0ZDVGZtbFdlNEd4OUtsQUE2a0MzSSs3ZDhXbzFUbEF0?=
 =?utf-8?B?TmhOR1pHRjE3alhjb3FHMHJqMFNaK09ITmYxVG5QNmFPdk5PMG1jcGdwelhz?=
 =?utf-8?B?bzJYRVJ1TVRtNjFUZ0QrOWppbEdVMCtzL0FCMmVSTEl1WDltUGJLYzJyN0w5?=
 =?utf-8?B?cjUvbkxCT1FXWnBWVEM1S3ZZRnB1cG5STjVkVFF6ekhFU0lySmFBSzVyMSs2?=
 =?utf-8?B?WkRra1E1akFZRDE1d0VoQndKelExNFZIUDYyWDl3OVZWWCtHbE1aakh6NjJW?=
 =?utf-8?B?QXVtSU5FYlZHekxaKy8rU1hrZDJ5YitjaW1xLzRmRVFXY2N1dUFHMWtlaTlX?=
 =?utf-8?B?WEZUUVZMNkZ1YlgwVG0zbWFVVHI1K0RSWkg4Mk8vS3lwQ1pSTkk5bk43VGE2?=
 =?utf-8?B?TTJwOTNCUisxNHZuMjg1S2NrdjE3MFREZys3R2c4T1M1UHgzS0dkL08zTzNC?=
 =?utf-8?B?YUdxYjBvS3VQMGtHdFdwOFUwVXJZM3hheERtUk1JYUxLWndTUU1mQzNGSm93?=
 =?utf-8?B?VXBUNVRqL1FuUjFlQmFtNWF1MUJGdEowZ3pQcnhMUjlQNFNsYk1VTlpmMU8v?=
 =?utf-8?B?TW5lWTR3TGFqZ0RkV3FmTzQ2RXhybTJHeDlmTDRPWE9BNW94enZMLzVyV0kx?=
 =?utf-8?B?ckJZcGNkNWJPeXJsSkk1bnNSOXE0Z0xCN0FMbTdidGEzTzlWczlLR2hMWnlL?=
 =?utf-8?B?enMxT3J6RUwxM0FqVjRmZU52Sk9jOE8zdkc4QVRZT2FUK0h6TGEwbTlkSTMw?=
 =?utf-8?B?RG9OejNINFhsa2F5VzhENk9yZnBkejl0WFFsM2hOTDFVNldYVWVBaWR6UXBq?=
 =?utf-8?Q?+jj0t3PPWpToTkjVgQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4634a44e-9de7-4bd4-c8d8-08de9931ebf2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:54:42.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0cTRQRLB+RCTXsf52kPQZlRTc/LaWGF6Nn3URrkbzL6pzfIJhQGTEBWz9NjaG9s
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

On 4/13/26 08:21, Sunil Khatri wrote:
> Use pm_runtime_resume_and_get instead of pm_runtime_get_sync as it
> return error but put the reference in the function itself.
> 
> In goto statements we need to drop the pm reference too.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

But Alex should probably take a look as well since I'm not very familiar with runtime PM functions.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 76badb4d4a81..6a635bb8bb30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -734,10 +734,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (r)
>  		return r;
>  
> -	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	r = pm_runtime_resume_and_get(adev_to_drm(adev)->dev);
>  	if (r < 0) {
> -		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		drm_file_err(uq_mgr->file, "pm_runtime_resume_and_get() failed for userqueue create\n");
>  		return r;
>  	}
>  
> @@ -745,13 +744,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (!uq_funcs) {
>  		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
>  			     args->in.ip_type);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto err_pm_runtime;
>  	}
>  
>  	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>  	if (!queue) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto err_pm_runtime;
>  	}
>  
>  	INIT_LIST_HEAD(&queue->userq_va_list);
> @@ -865,6 +866,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  free_queue:
>  	kfree(queue);
> +err_pm_runtime:
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  	return r;
>  }
>  


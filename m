Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9531BCD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0271711A869;
	Fri,  5 Jun 2026 13:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ps3fe/cQ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F4611A869
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njUjaeNERtDYsvAMU/8uQH18qK/mzh8YhNs3XeLo29GFVWzMYBHtVKdn2mXys60OviSVZ6zUchpkCWGvoEPv2HG/Rv5FB+SzGvStEDNYdXkj6Acy2YI8SFJTWOAAYFJXJs6/vzRKCDG2pNKY2BkW4y8zvOrY06y1PquQBZv+/YYyONppQC8R0RmzVEi6tsCz3VbPo6SY6GQAmwbgxgkMfKIJhMuzBqtrLCUSOIlm1zPc/uxVpJzlLTan+Gf1zIBkGDO8GFknPPq76ITF0A0d/0Eqo5K7I12dsuwUWv6Usl7X1BCuIqzu7V6K3lOjrF9pRG5lnMLWdihCyKPadkPZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M55uxuNHs4Ji87VFukctLAxpJGlWEttzlPwcDhhFZxM=;
 b=CDWOAN8hCj+R9nBe6cwF7SIrF9kQCptIFV1a0LM5l7G4WrC06HzV6wwd8Jiehn2QunNsZ2OJhKjaMU+AyQg33PjRtLBDhLfvirGnImoGJ6gamtF5yClGnLfYBHkxkUmASeQaUpBWDKW9SFkYa1n89LBpHw50Lre+GD706qTmvbHLH8HNNOJtZm6X++OgKYNu2JYjFUwNz30vcUZdCHF6ZNoObGhdJhW+xljcCX7ymZvi/UezKhgpEDclUNuBGvuPYz9tyACgD0uNG4ZPftDX8jMdsRYUEVvpGAADS3yS+jDMkHWg7Qf8atdpppEDPLKaK+A1xAeucCxIvGcwArGbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M55uxuNHs4Ji87VFukctLAxpJGlWEttzlPwcDhhFZxM=;
 b=Ps3fe/cQiJQBP1ivvwcSOQiWETvn6bDh6TnPwvFlYGH6RaMsVtoVLOhBHo+DQR+hj/t9x2Vzk6eA+iGL4hXwi8UCzT5cqWVsu+0XpsahBVLZK/abI070/3VpK2nk28yt93lZfPVWmqelvA6zd+8lH6XYbJfQvZRA9T+G3xckrr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 13:18:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 13:18:51 +0000
Message-ID: <b692a458-c544-4dce-b9ae-cae27fb4532e@amd.com>
Date: Fri, 5 Jun 2026 15:18:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/11] drm/amdgpu/uapi: Add unified EVENTFD ioctl for
 render node
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603163350.2678309-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db8ca92-f403-483c-5bf8-08dec304fc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: cx8ynomCt/uXkH2L2ke5HiCbVLj2uo+oyzw2VFLHORVACFzUw1Dnk8m0EISRLooMKevHjYIwI72J6eg4GsW640GOahBSPEBZLnHpbAfJPLROFpuiLN20JR8yYf9BiFd0YmyiRBZd/mg4mZNekY7E37+FP5y6RYPLFXvPEimon2S6SyTaE6zQR1CV2z/h4LKzrYNz5wJ9OjU1wn/u8XxlO9Z2LS3CvJKSHoAs1in6tTy59bI0bE4hSJ1h15wl2LlebRAEzkwbpxSsPe71KViKTFcqIvhnVezCyg933hI4hBtprmcDA3/mfHFtGH12w207VaEW02lCCkx5N7wG25mat2WVF4Qk4tWgpLSZOCEI/7Hy5it8aJgMSl8NpDAvWF1cMl1tBAgqtzhbxfsznlHm4144/Dpnn0UgIkxA/AQeP64iScpl+zqM1vAvVcLRPu/pZHmxqoV3dewqVOsEfcdfHUJrYSbO5s1cdGa4AJB4u34pQS+LnBDaILqYqHuUVd2gg7f100yTZJagpceCqrHHroHSAZJSFpDWgdQGEt+icInpO+l1oOpTPqUEbhAsbWxlXtln2qXYKkMKgSkzn5QMQ7cWholG8ba7kN5A7OcsQR5P1346jR7GUsKmSb89A2QjKjFhUPXjWvZzhbYBn6zgH09VeQ56y5BWkC8DX0WBMcj6SMfaBfMJqxiM2XziVDMr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGQrOGlZd3NlQ2gvTWJYc1NVcDY4YlhselgyYm92UXdrOE5tYkRjNWNtWVEx?=
 =?utf-8?B?c3V3ZlZUN2l0d3VqY1EvdXE2d1JSTEpMU2NaT2dEMnBXeXQxZDhyTVpMQVIv?=
 =?utf-8?B?MlQvdk92cDVENkw5a1UvNjR1cDE0S3ZibytlaDV3Z0J1dFFKUGcvTnVwZnZE?=
 =?utf-8?B?RVlYc084SElWQmNNNnR4N1pQS1hlczdwVytuYjZmTVJHbmswRFpBWVBsdktC?=
 =?utf-8?B?VDR6WkVicUVoSzQyUkd0ZklKWVJtVTBvK2Qya0V5Q2hCVFdyeVplQUlaY3E4?=
 =?utf-8?B?QU1HUWJQSWpKUTdINmIzRGV2cDliKy9CQlNSVjdzK1h6cGp1SnBKRWlhQmdP?=
 =?utf-8?B?WlpmT3NMNnJHMHBsdGlDaVJZcVQvbmVvUlRhSEp0Y1J1YlpyUjFRS2RPOHlM?=
 =?utf-8?B?YktrcDl2NXA0QWhqUjFwVWZpNDJuYnVxUzRjUjVyNGVqdWZqRm9qVlFvNUlL?=
 =?utf-8?B?ZW43S3NXS081eFZsR0o3K0llcXpaanNIdlUxS0FQVmY2eTFBaG5JRTY5dldn?=
 =?utf-8?B?UGFRQ0NIZy9aWW0rbkdQZmJ5ZmNUdXc1U0Y4Y25FaEFtU1ZNQmJ0SHhFS3BQ?=
 =?utf-8?B?YXNsTWt6bjd0LzByR0JOR1JlSGt2dS9wd0krdUVUVTZvbFBGcm5lL09wVklz?=
 =?utf-8?B?QWNzQzdMbzl5NytQQnpnQ3JtZkxGQnpwcGFiQ0U2VG1UaTVkRWNlVjRVdFNl?=
 =?utf-8?B?U3pIZHdEdS92K3RWQVNpeDE2MkNyRTRRZHgwNVNSd0tFTEJNNTB1cnBEWEhN?=
 =?utf-8?B?dHhSZW4zUUV0WWJ5aS9KV0czY3hNSnhMZ1dTMWJDUjZiRjIxbGQ2MHVvTWZW?=
 =?utf-8?B?TzFtUUhmc1NyWVRrVytLRzBTaWoyRXA3dkhCSnFTRWtnMHJwZ0xRRTdYR3Ra?=
 =?utf-8?B?WFNwQ0R6Y0J0RjZ4MnMzMUJ0K2YrUlNpSmphWk42d3FoZXNPdlk2Q3ZBbmRx?=
 =?utf-8?B?TndpUXU4c1kwckMvTVFiZm1zd3E3SGo5L0Rib1MwYTJHK29EelN6aHZOWVBJ?=
 =?utf-8?B?bDNWY3FJTUxUUk5oUC9RQzdnSXl6MVMzWnV5dkRTamY4ajA0NDVFYmhlQlJz?=
 =?utf-8?B?YXRndjdmdnJVOTl4elR2S3R1WUFFdnhuUmEyL2o3c29vMFFFbXZEMVVoUjNi?=
 =?utf-8?B?LzllQkU3QVEzRWljcFpWTllmVXBsc2VoYXNpeWRLMEVzbXJmZFExdDdVdzdu?=
 =?utf-8?B?dnJUYjdPUnJQZTRpMk1RUnNYcTNGelQrUHdPMnlvNFN3WmhnSGEzS1pXUm5W?=
 =?utf-8?B?WVE4OG1aSy9TYUlRTU1PQmZMZWRHMlBKN01jQUpTenVjcHZsMFY1T3czU0tF?=
 =?utf-8?B?MW5hbks5SGQrSi9JdTFkQmMyLzdmWkx2MEJBMGxTL09XNzArTTFBSjV0VkNY?=
 =?utf-8?B?YWZEOXVTR2Z6cTBoOFRtUzJNSEhnSzRjTUk4eFZ1bWd6eUx6TWFwRnRkSy84?=
 =?utf-8?B?ZEpIMkpKTitpL1V4THROMnlia3dYWHExYXVUYTdJVkhvTVNNc21FeGgvU3lS?=
 =?utf-8?B?bWc4VmhnS2s5a21iVEd0NnduVDJSQ2VQOFZYcVRXYjdjTlRGajlkZjB3ckZq?=
 =?utf-8?B?aXBiTm9qTmsxUW1aeENjc3V4VzNXZ1M3L3gyckQ3SlhtdGgzVGZxaTVlUjRz?=
 =?utf-8?B?bEZaL0J0Q2JRQms0eFdRWWZ1My9RNmlCYmlhNFZQZnMrMlNqdklDdnovVG5N?=
 =?utf-8?B?UkVwNGZIVUpqdFJFajJCdzlqUHdkYjcwZ1hMalptNGw4WW5JanpnR2I0ZWRB?=
 =?utf-8?B?RDRpMCt1MlAyUVpBL3RrK0ZnaEVQZm8zMVFwdDMyWUE2SlhmZVpMYnk1b253?=
 =?utf-8?B?bktKaUIzQmczS244VUtZbnVtVE1EZXdWSDBWcFlhSUhRVG5IZkg5RTlSWDk1?=
 =?utf-8?B?Q1ZCRUxkaE1PQTRDM2FnM2dBYWoveVovVno3cFZEYWpuVitKdjRyK21yRDVt?=
 =?utf-8?B?dXE1bFl4aEtZMFEvOHR5SzNscGlmMnhEajJKU000ZGo5czU1Z1hIWWhTdkVW?=
 =?utf-8?B?aVNGTWtab3RGcmJGZEZpZkViK0tsSkU2NWdYcnEwNDRCVGJQeVgraVVMSDNv?=
 =?utf-8?B?cldPRUpQUjU1dXZYZDlVNVpybVc4cGpjNzlmYS9QdlNRMXpyTW9QUHc4ZG8z?=
 =?utf-8?B?VTRmNHQ5eWJFQWlkSmRXL1hVLzRvQ05kYVoweXZ0dTNzUEM5cll4YWVrY3FW?=
 =?utf-8?B?RGZsb0ZFbGViT0VJZThaMGxpcE9tSTVoc3FPUno4aGM2UjB2N2ZtanpOQm44?=
 =?utf-8?B?bEFURUh2aWM5blArWDlSYXRsYklsTVNXL0hlUGJVT3FHdnNmaUx4MGhoRThl?=
 =?utf-8?Q?iWi7d0qau92UvnBBao?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db8ca92-f403-483c-5bf8-08dec304fc84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:18:51.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8n+gCYHRlQ3y7KB/AoWFB0gDRElcQJldzkUg9Yg74sbXHhWN4+xefB7eVOaZjUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

On 6/3/26 18:33, Srinivasan Shanmugam wrote:
> Introduce two new UAPI ioctls to allow userspace to bind and unbind an
> eventfd to a userspace-defined event_id on the render node.
> 
> The design supports multiple eventfds bound to the same event_id.
> Therefore, unbind includes the eventfd to remove a specific binding.
> 
> v2:
> Replace separate EVENTFD bind/unbind ioctls with a single EVENTFD ioctl
> that carries an operation field.
> 
> Also add a queue_id parameter to the UAPI so subscriptions can become
> queue-specific in a later step. For now, queue_id is reserved for future
> use and must be 0.
> 
> This keeps ioctl number usage smaller and prepares the API for queue-aware
> event routing.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  5 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 33 +++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 30 ++++++++++++++++++++++
>  4 files changed, 69 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a75c68195df9..54bc31ee795a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -460,6 +460,11 @@ struct amdgpu_fpriv {
>  	struct amdgpu_eventfd_mgr	eventfd_mgr;
>  };
>  
> +struct drm_device;
> +struct drm_file;
> +
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..aaa4dd57099f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f5719500527f..cd127a271c19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -634,6 +634,39 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *file_priv)
> +{
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_amdgpu_eventfd *args = data;
> +
> +	if (!fpriv)
> +		return -EINVAL;
> +

Maybe a comment that flags are reserved for now.

Apart from that looks good to me,
Christian.

> +	if (args->flags || !args->event_id || args->eventfd < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * queue_id is reserved for future queue-specific subscriptions.
> +	 * Keep it zero for now.
> +	 */
> +	if (args->queue_id)
> +		return -EINVAL;
> +
> +	switch (args->op) {
> +	case DRM_AMDGPU_EVENTFD_OP_BIND:
> +		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> +					   args->event_id,
> +					   args->eventfd);
> +	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
> +		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> +					     args->event_id,
> +					     args->eventfd);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  /*
>   * Userspace get information ioctl
>   */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..63cde4487c47 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -39,6 +39,7 @@ extern "C" {
>  #endif
>  
>  #define DRM_AMDGPU_GEM_CREATE		0x00
> +#define DRM_AMDGPU_EVENTFD		0x1A
>  #define DRM_AMDGPU_GEM_MMAP		0x01
>  #define DRM_AMDGPU_CTX			0x02
>  #define DRM_AMDGPU_BO_LIST		0x03
> @@ -79,6 +80,8 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_EVENTFD \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
>  
>  /**
>   * DOC: memory domains
> @@ -204,6 +207,33 @@ union drm_amdgpu_gem_create {
>  	struct drm_amdgpu_gem_create_out	out;
>  };
>  
> +enum drm_amdgpu_eventfd_op {
> +	DRM_AMDGPU_EVENTFD_OP_BIND = 0,
> +	DRM_AMDGPU_EVENTFD_OP_UNBIND = 1,
> +};
> +
> +/**
> + * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an event_id
> + * @op: operation type, see &enum drm_amdgpu_eventfd_op
> + * @event_id: userspace-defined event identifier
> + * @eventfd: eventfd file descriptor
> + * @queue_id: queue identifier for future queue-specific subscriptions
> + * @flags: must be 0
> + *
> + * This ioctl lets userspace register or unregister eventfd notifications
> + * for a render-node event.
> + *
> + * For now, @queue_id is reserved for future queue-specific subscriptions
> + * and must be 0.
> + */
> +struct drm_amdgpu_eventfd {
> +	__u32 op;
> +	__u32 event_id;
> +	__s32 eventfd;
> +	__u32 queue_id;
> +	__u32 flags;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE	0
>  /** Opcode to destroy previously created residency list */


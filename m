Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5966DC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 13:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E0C10EE06;
	Fri, 21 Apr 2023 13:21:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15A510E0EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 13:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp2bJAoY4n65+OtWUWE/JpDiqNihFLIm7kjlCdkY7vyWgp4+cNa/6SKBZwddve4xRL56wqcu3BavFmXM65NNUCp7daTh9BcJCyKtd5/FGVZ+QFs/tdMIvgrcIQlHZCl3KXVeLprLa6xZTqwzMT7fFnqGpAkIBnIEZUxdKlkZXPFz7QtQmOm+/QqvlZdGKGTgCCsUoXA+SikydWPmQ18mrS3WNsq+Imq4Y3CCBXW8Wyy/0DwWndDEATPbFVPTjwjONho6CtWY693IFBaik9PSdHd09kxjM/gvS+30jWwM+BunsOLk3+w8JeZdjK98pJT3x4Q7WpxqIk5ydchXovcusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWU/D7+lZr9Q5NumCde5wXHoWa7iJpHjQXf4aXsGKM8=;
 b=ZoEbYK3EiDU4MSsOWCG2hzJubZHo/0VW7YUKordLOcab7yK0GWnxJtHpHK8+HI7hvc2U6JLHEeUqvUA1vl/Bq+5ZbHEOMgMzJaG8V9D16USjMP860He+TkjMCpe/7MoSFm5Gr04l21E55vc4GtcMoAA7t8/qB8zZQ+wSxcv4DxhBQ1O0xBJdveGLk8I+W6Z4ZVlyKabMEauLUQknMHuAQFNOPz+0rsXIJhvZeG/OASGLtN5sLbLRTIFLclReF9AL+R+1cwvNv5AD3ZbpXa45QyDxXbQoz6MnfbqDibO04hBpCz5JhoMsu6O7M0J9X/XuaMJ8cxOboYUpUR6gN9p65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWU/D7+lZr9Q5NumCde5wXHoWa7iJpHjQXf4aXsGKM8=;
 b=NXR8dCHOb0+XhtvM40M1DpwY2NtkMGBfNSY9F4Gf9zNqp6518K+eqkqKYfZgd3wuek+aa6s/7PmKkjLksm8z7xHFweCnXqeaPF0soCM00zYVpcgwFRn6zJLq5EHW8qB73rEqDz39VMKvAvxZIZmOS9eWF/JwtcosJkvpP1nnCzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 21 Apr
 2023 13:21:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:21:01 +0000
Message-ID: <6d1f2872-cae8-4f94-cd39-62b8eda516f8@amd.com>
Date: Fri, 21 Apr 2023 15:20:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
 functions
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
 <20230420144714.124377-6-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230420144714.124377-6-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b315251-fa95-4d47-0d4a-08db426b4048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLnnyfSvhpon749+HMT9d9p9zJHMLFRDzIo6KY2asi/GsaPutjhpRyDkRfgEnaDa7sZRozorK8RDHhpJ3uRR31ZZHik6SxdHEuaNPUgps59MbET98QD6Ql6U/6LCDNuv1UP/bOLdxkHn3V/kkH/JyhpcitJOXzQB3iSalRmBfmfPVOdVsbL17Eg+FoksS60JPSIdGtqk+u06Ym/+0P3AGr15Hrq5BQTGhR8tkQMkcht8F7ez8NMB21hRdgGAC6EStdkMGOMEa0FdBcCdTsRZE7CY1PsT/kufVAWW3st9FoPMLyW0k8XnjcD7plr02mc40ilWe4tCQrwDc3HNz/lmfIYD9oLOYr8bQaKyRq3FjKpK7/F+HC1nJ7MnG3EFuLUZl/0AftNdkUsSM13kU0D69veH55Fhc0dkNsUBk51UXygItszDTd8a2CefEpU2asE3pH2FtTzIb1yzrKmvuyd35u1X3is1/DxBiLbmq0TvEArMNu0CsVMSZAnQGxn2eHG/ZuVqwHa7QO/kQjVmpcWVRDt75g+cQ1YbLX04cJ1Jv+yHt5F68Za/uVQ47oWC1IQDGW+8iEMFJzEEJ28b3BQIH8S4mJNow7wh3f+34jOkzKJNfaA7ha9GQtaLoKWxdhm4WS3rIxRHE7gk2FxDpaOvSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(41300700001)(8936002)(31686004)(2906002)(6506007)(6512007)(2616005)(83380400001)(5660300002)(30864003)(38100700002)(4326008)(8676002)(66946007)(66556008)(66476007)(478600001)(36756003)(6666004)(186003)(6486002)(31696002)(86362001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1JMlo5MG5kR09hSVBRV2hoMm0zY2JIaVFBdmZPL2kzUFo5NHBlZllPSWhY?=
 =?utf-8?B?NkxQMFk3dVd5VjE1SkhqbU9MaHdKZC83V0NUeXVOMVcxN00zcFBIc0gwMGpy?=
 =?utf-8?B?VFdUT25Jak9Ndk02UTNOK01rK1B3VGtxeVlGN1JtQVlwRXZjZURPamVvRlM4?=
 =?utf-8?B?SmFFVExjdmoyWnZQUDhVVkNmNDNYMCs3UlRZUGxpb0pvYUUzcGJIT3k3cmcv?=
 =?utf-8?B?VVhINmJjZEsyN3IyZGVEZjNleStNL0NaMkdUbWpSK2JRSmhwVFJpMHdNOWI1?=
 =?utf-8?B?Y08vajVWdHNWUXlScW51cElwREliNHZyLzNJZmRLdFVWanhQZ1NGRFZGRXZH?=
 =?utf-8?B?SmVEM1NFUjNhMlAvWHJtY0RncUd4SkdSSldMN3RVWUw4V2I0d1N6T2NrOWVQ?=
 =?utf-8?B?UzZXL1lVeXRxTXdKdW9sdkthOS95alplcGpONHI5Ty9ZZFk3QlJTVUx1Z3VY?=
 =?utf-8?B?bkY4M1pkZnhUeWJuT0xOUU1mK3hzUkU1TG5mZGplSGZFU2RpZ3hJTHVkUHB5?=
 =?utf-8?B?cTdmQ0JiNmZOYTI5Wm1hMVJ2c0FDRENTLzBMV2doUkcwbGdLUVhWSVY0V1Rv?=
 =?utf-8?B?bkFNSWI5Sk9OYlBOQU1oU1ZnWWJMOHZ3VFRodk0zQ0Z4QytkTFl4Z2RIc2ln?=
 =?utf-8?B?d0ZIM3kvd3JRV296dG9xM0RVTVZISkcxZHpjaFd1Q3RodnlYQUx2aGpGZ0FD?=
 =?utf-8?B?bll3YVJSeHF5L1M5Zmp4VmU0MlZINWEzY2ZqcjdpZXlzSUNBTFQrdEdnbU83?=
 =?utf-8?B?b1Y1WHhSSGMxNEgwZ2J0RWhGSkhoOHNyMDZMUXRXNXBtZFdXZGNqckZrQXUr?=
 =?utf-8?B?ZDJVSWFQb2lXbzlyeWs0YjdjQnh3bU5CN1gyZEhZMnBDWVlqQzk3L2xNUml6?=
 =?utf-8?B?QkR5emhTME53aEdpdEt0WkY5dWN6Mk5QUXBiY3BHc3B3V05CMEdXWEEyN1VH?=
 =?utf-8?B?QjJlbnVzeDhnUk9OM2xWYmlkaGhJY2FFL0tOcUZUUVZ4REZrdmNNcldPTDc1?=
 =?utf-8?B?YkZMNHMwNHkyL1ZTTXZKT2Uva2UrUkNBeVBzOTVWb2Q1dGtSbWM1NVJ3ZkdN?=
 =?utf-8?B?WW1uQkdTVWd0N29KNTlWU1FzVS9ZLzlJMWVCbHZYTWVucGRUYmxhVUdkczNG?=
 =?utf-8?B?MGdieDV3Q0tpRUdBdFhoRnhLU0ZoZ0NRbS9IWmZwbWk2cU80RU5uZnVlOGFP?=
 =?utf-8?B?a2JCVm5tb2JtUnVCUGZHbVo0RTZJd3VLMWRqUGVjNzlvWWNaT0lnRVBQT0pD?=
 =?utf-8?B?ZmxWaDRQQTcrRHlOODVvVUIvUjMrSVVZd0xtdkxBZmxaSSttcWtoTC9ibENl?=
 =?utf-8?B?enRtb2xQNlpURnVVeHRCaWVjNEVoSHEvMmg5S3dRSUMzRkF4YlB3WTVGcThH?=
 =?utf-8?B?S3FYNU1qRGU3TU5GcC83NjZ3T3ROaE12MXQ3eWVKTTRIN0tpekR4V2I3LzdJ?=
 =?utf-8?B?ODJYa2VaRHFoVkh5S3ZyWGZoZGNFY1pSS1dxcnZISWhybHdsRWVDRld5czEw?=
 =?utf-8?B?UDlLbWh2RkQrOTlRdzFDR2xZYVZ0Z1hTK0RPL0JhL2JYNEJBbitFY1YwMkhF?=
 =?utf-8?B?aHZlVFNNSjg3TVUwbDhhdTdPTS9jZDBQZEEwTEdrb0UrWVFoTldvKzJRbjBM?=
 =?utf-8?B?Mzg3OEpsTFQvNTNqNHF1S1Q3ZjhlQmh3bUNUZlFsckIwZkhxbzQvTVJnU3Aw?=
 =?utf-8?B?ZWZJemhnY3pSUWhHUHhhak9tQjUvNklUVjBBUkFralhBS3hvQVdsMGFBT041?=
 =?utf-8?B?T3pSVldzeUNBVXBlSGVjMm5XN1NOc0dMNGtpLzJYNXVuOVhMQ1AzZXY4b2g5?=
 =?utf-8?B?U3J6eGpvL1pKWmMxYzRZck1heEhTYkxURVZlVENJRjVjaDhBb0NwSGVSbEZ5?=
 =?utf-8?B?RGFWam1NSUNveExNdU1MZ3J0UGwrNkgxZ05Fc0JERmwwMVR0R3ZmeVRqT2VV?=
 =?utf-8?B?NkJkK3R5NExYOEJ6WjRPbnBEN0JPZUFOWG9SNUQrQVR3ekJHZXdzRGFyUTV4?=
 =?utf-8?B?UVRycFZHWkF0WlYyNUVRSjdsRWJvdEY4U2ZLOWV6QmZoaDRBcEdBeFdOajFY?=
 =?utf-8?B?c1k4ai9sbDVVcElnUGY3R3YzZWZ3TzFCaGtwcGUvQnhtYWQwcUMrTER3MXhL?=
 =?utf-8?B?TjdLUWV1SmdRemZadGhaQkh4dmVzSGx1eDJVMHhVNTltOUdtbzhLM0ptV0xu?=
 =?utf-8?Q?QzPleioMMm/c7ESoSZDxI4Z9Go600QXb4++6HqYRh4gi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b315251-fa95-4d47-0d4a-08db426b4048
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 13:21:01.2896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCMmB4DGtFpoa+y/KLqKnpDsAGOTchZyyQQc1y/kuVP4HuQXm7NKng24Zx+D0+tP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.04.23 um 16:47 schrieb Arunpravin Paneer Selvam:
> This patch introduces new IOCTL for userqueue secure semaphore.
>
> The signal IOCTL called from userspace application creates a drm
> syncobj and array of bo GEM handles and passed in as parameter to
> the driver to install the fence into it.
>
> The wait IOCTL gets an array of drm syncobjs, finds the fences
> attached to the drm syncobjs and obtain the array of
> memory_address/fence_value combintion which are returned to
> userspace.
>
> v2: Worked on review comments from Christian for the following
>      modifications
>
>      - Install fence into GEM BO object.
>      - Lock all BO's using the dma resv subsystem
>      - Reorder the sequence in signal IOCTL function.
>      - Get write pointer from the shadow wptr
>      - use userq_fence to fetch the va/value in wait IOCTL.
>
> v3: Worked on review comments from Christian
>      - Use drm_exec helper for the proper BO drm reserve and avoid BO
>        lock/unlock issues.
>      - fence/fence driver reference count logic for signal/wait IOCTLs.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 312 +++++++++++++++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   1 +
>   5 files changed, 315 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3bc8a2d35bb3..1d8a762f43c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -970,6 +970,8 @@ struct amdgpu_device {
>   	struct amdgpu_mes               mes;
>   	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>   
> +	struct amdgpu_userq_mgr         *userq_mgr;
> +
>   	/* df */
>   	struct amdgpu_df                df;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e9c5047087d0..b59e31845568 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2751,6 +2751,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a03d12f83147..1c455b7ebcd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -25,6 +25,7 @@
>   #include <linux/kref.h>
>   #include <linux/slab.h>
>   
> +#include <drm/drm_exec.h>
>   #include <drm/drm_syncobj.h>
>   
>   #include "amdgpu.h"

> @@ -84,7 +85,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   			     &fence_drv->cpu_addr);
>   	if (r)
>   		return -ENOMEM;
> -	
> +
>   	kref_init(&fence_drv->refcount);
>   	INIT_LIST_HEAD(&fence_drv->fences);
>   	spin_lock_init(&fence_drv->fence_list_lock);
> @@ -124,28 +125,27 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   {
>   	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
> -					 struct amdgpu_userq_fence_driver,
> -					 refcount);
> +					struct amdgpu_userq_fence_driver,
> +					refcount);
>   	struct amdgpu_device *adev = fence_drv->adev;
>   	struct amdgpu_userq_fence *fence, *tmp;
>   	struct dma_fence *f;
> -	
> +
>   	spin_lock(&fence_drv->fence_list_lock);
>   	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>   		f = &fence->base;
> -		
> +
>   		if (!dma_fence_is_signaled(f)) {
>   			dma_fence_set_error(f, -ECANCELED);
>   			dma_fence_signal(f);
>   		}
> -		
> +
>   		list_del(&fence->link);
>   		dma_fence_put(f);
>   	}
> -	
> +
>   	WARN_ON_ONCE(!list_empty(&fence_drv->fences));
>   	spin_unlock(&fence_drv->fence_list_lock);
> -	
>   	/* Free seq64 memory */
>   	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
>   	kfree(fence_drv);

This whole block here are just unrelated white space changes. Please 
cleanup.

> @@ -161,6 +161,11 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>   	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>   }
>   
> +static inline bool amdgpu_userq_fence_test_signaled(struct dma_fence *fence)
> +{
> +	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> +}
> +

Oh, that's messing with dma_fence internals and you need a very good 
explanation why this is needed!

>   int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   			      u64 seq, struct dma_fence **f)
>   {
> @@ -251,3 +256,294 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.signaled = amdgpu_userq_fence_signaled,
>   	.release = amdgpu_userq_fence_release,
>   };
> +
> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
> +					struct amdgpu_usermode_queue *queue,
> +					u64 *wptr)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo *bo;
> +	u64 addr, *ptr;
> +	int r;
> +
> +	addr = queue->userq_prop.wptr_gpu_addr >> PAGE_SHIFT;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
> +	if (!mapping)
> +		return -EINVAL;
> +
> +	bo = mapping->bo_va->base.bo;
> +	r = amdgpu_bo_reserve(bo, true);
> +	if (r) {
> +		DRM_ERROR("Failed to reserve userqueue wptr bo");
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_kmap(bo, (void **)&ptr);
> +	if (r) {
> +		DRM_ERROR("Failed mapping the userqueue wptr bo");
> +		goto map_error;
> +	}
> +
> +	*wptr = le64_to_cpu(*ptr);
> +
> +	amdgpu_bo_kunmap(bo);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return 0;
> +
> +map_error:
> +	amdgpu_bo_unreserve(bo);
> +	return r;
> +}
> +
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_userq_signal *args = data;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_userq_mgr *userq_mgr = adev->userq_mgr;
> +	struct amdgpu_usermode_queue *queue;
> +	struct drm_gem_object **gobj = NULL;
> +	struct drm_syncobj *syncobj = NULL;
> +	u32 *bo_handles, num_bo_handles;
> +	struct dma_fence *fence;
> +	struct drm_exec exec;
> +	u64 wptr;
> +	int r, i;
> +
> +	/* Retrieve the user queue */
> +	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
> +	if (!queue)
> +		return -ENOENT;
> +
> +	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
> +	if (r)
> +		return -EINVAL;
> +
> +	/* Find Syncobj if any */
> +	syncobj = drm_syncobj_find(filp, args->syncobj_handle);
> +
> +	/* Array of bo handles */
> +	num_bo_handles = args->num_bo_handles;
> +	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
> +	if (!bo_handles)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(bo_handles, u64_to_user_ptr(args->bo_handles_array),
> +			   sizeof(u32) * num_bo_handles)) {
> +		r = -EFAULT;
> +		goto cleanup_bo_handles;
> +	}
> +
> +	/* Create a new fence */
> +	r = amdgpu_userq_fence_create(queue, wptr, &fence);
> +	if (!fence)
> +		goto cleanup_bo_handles;
> +
> +	if (amdgpu_userq_fence_test_signaled(fence))
> +		goto signaled;
> +
> +	/* Add the created fence to syncobj/BO's */
> +	if (syncobj) {
> +		drm_syncobj_replace_fence(syncobj, fence);
> +		dma_fence_put(fence);
> +	}
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto cleanup_bo_handles;
> +	}
> +
> +	drm_exec_init(&exec, true);
> +	drm_exec_while_not_all_locked(&exec) {
> +		for (i = 0; i < num_bo_handles; i++) {
> +			/* Retrieve GEM object */
> +			gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);

Looks like a step into the right direction, e.g. the drm_exec usage 
looks correct for example.

But it's illegal to lockup some object when you are already holding 
locks of another object.

What you need to do is this:

1. Lockup all BOs (using drm_gem_object_lookup).
2. Lock all BOs (using drm_exec).
3. Add fence to the syncobj and BOs
4. Unlock all BOs.
5. Drop the reference grabbed during lockup.




> +			if (!gobj[i]) {
> +				r = -ENOENT;
> +				goto exec_fini;
> +			}
> +
> +			r = drm_exec_prepare_obj(&exec, gobj[i], 1);
> +			drm_exec_continue_on_contention(&exec);
> +			if (unlikely(r))
> +				goto exec_fini;
> +
> +			dma_resv_add_fence(gobj[i]->resv, fence,
> +					   args->bo_flags & AMDGPU_USERQ_BO_READ ?
> +					   DMA_RESV_USAGE_READ :
> +					   DMA_RESV_USAGE_WRITE);
> +		}
> +	}
> +
> +exec_fini:
> +	drm_exec_fini(&exec);
> +signaled:
> +	dma_fence_put(fence);
> +	kfree(gobj);
> +cleanup_bo_handles:
> +	kfree(bo_handles);
> +
> +	return r;
> +}
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	u32 *syncobj_handles, *bo_handles;
> +	struct dma_resv_iter resv_cursor;
> +	u32 num_syncobj, num_bo_handles;
> +	struct drm_gem_object **gobj;
> +	u64 num_fences = 0;
> +	int i, j, r, cur;
> +	bool bo_flag;
> +
> +	num_bo_handles = wait_info->num_bo_handles;
> +	/* Array of GEM BO handles */
> +	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
> +	if (!bo_handles)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(bo_handles, u64_to_user_ptr(wait_info->bo_handles_array),
> +			   sizeof(u32) * num_bo_handles)) {
> +		r = -EFAULT;
> +		goto err_free_bo_handles;
> +	}
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto err_free_fence_info;
> +	}
> +
> +	if (wait_info->num_fences) {
> +		/* Array of fence gpu address */
> +		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
> +		if (!fence_info) {
> +			r = -ENOMEM;
> +			goto err_free_bo_handles;
> +		}
> +	}
> +
> +	/* Track fence_info index value */
> +	cur = num_fences;
> +
> +	/* Retrieve GEM objects's fence */
> +	bo_flag = wait_info->bo_wait_flags & AMDGPU_USERQ_BO_READ;
> +	for (i = 0; i < num_bo_handles; i++) {
> +		struct dma_fence *bo_fence;
> +
> +		gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
> +		if (!gobj[i]) {
> +			r = -ENOENT;
> +			goto err_put_gobj;
> +		}
> +
> +		dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +					bo_flag ?
> +					DMA_RESV_USAGE_READ :
> +					DMA_RESV_USAGE_WRITE,
> +					bo_fence) {

When you don't lock the BO (and that's ok) you need to use 
dma_resv_for_each_fence_unlock()!

This also requires resetting the fence when dma_resv_iter_is_restarted() 
returns true.

> +			if (!wait_info->num_fences) {
> +				++num_fences;
> +				dma_fence_get(bo_fence);
> +				continue;
> +			}
> +
> +			/* Store drm syncobj's gpu va address and value */
> +			fence_info[num_fences - cur].va =
> +				to_amdgpu_userq_fence(bo_fence)->fence_drv->gpu_addr;
> +			fence_info[num_fences - cur].value = bo_fence->seqno;

You need to double check if that is really an amdgpu_userq_fence, 
otherwise the cast will just return garbage here.

> +
> +			cur--;

Hui? Filling the array from the end won't work. You can't predict how 
many fences you will have when you start.

So you need to some handling which prevents adding to many fences and 
overwriting things in userspace.

Christian.

> +			dma_fence_put(bo_fence);
> +		}
> +
> +		drm_gem_object_put(gobj[i]);
> +	}
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	/* Array of Syncobj handles */
> +	syncobj_handles = kmalloc_array(num_syncobj, sizeof(*syncobj_handles), GFP_KERNEL);
> +	if (!syncobj_handles)
> +		goto err_put_gobj;
> +
> +	if (copy_from_user(syncobj_handles, u64_to_user_ptr(wait_info->syncobj_handles_array),
> +				sizeof(u32) * num_syncobj)) {
> +		r = -EFAULT;
> +		goto err_free_syncobj_handles;
> +	}
> +
> +	/* Retrieve syncobj's fence */
> +	for (j = 0; j < num_syncobj; j++) {
> +		struct dma_fence *fence = NULL;
> +		struct drm_syncobj *syncobj;
> +
> +		syncobj = drm_syncobj_find(filp, syncobj_handles[j]);
> +		fence = drm_syncobj_fence_get(syncobj);
> +		if (!fence)
> +			continue;
> +
> +		if (!wait_info->num_fences) {
> +			++num_fences;
> +			continue;
> +		}
> +
> +		/* Store drm syncobj's gpu va address and value */
> +		fence_info[num_fences - cur].va = to_amdgpu_userq_fence(fence)->fence_drv->gpu_addr;
> +		fence_info[num_fences - cur].value = fence->seqno;
> +		dma_fence_put(fence);
> +
> +		cur--;
> +		dma_fence_put(fence);
> +	}
> +
> +	/*
> +	 * Passing num_fences = 0 means that userspace doen't want to
> +	 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> +	 * userq_fence_info and return the actual number of fences on
> +	 * args->num_fences.
> +	 */
> +
> +	if (!wait_info->num_fences)
> +		goto no_fences;
> +
> +	if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
> +			 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> +		r = -EFAULT;
> +		goto err_free_gobj;
> +	}
> +
> +	/* Free all handles */
> +	kfree(syncobj_handles);
> +	kfree(gobj);
> +	kfree(fence_info);
> +	kfree(bo_handles);
> +
> +	return 0;
> +
> +err_free_syncobj_handles:
> +	kfree(syncobj_handles);
> +err_put_gobj:
> +	while (i-- > 0)
> +		drm_gem_object_put(gobj[i]);
> +no_fences:
> +	if (!wait_info->num_fences)
> +		wait_info->num_fences = num_fences;
> +err_free_gobj:
> +	kfree(gobj);
> +err_free_fence_info:
> +	kfree(fence_info);
> +err_free_bo_handles:
> +	kfree(bo_handles);
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index 7329b4e5dd30..2b2f52296d76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -29,6 +29,8 @@
>   
>   #include "amdgpu_userqueue.h"
>   
> +#define AMDGPU_USERQ_BO_READ	0x1
> +
>   struct amdgpu_userq_fence {
>   	struct dma_fence base;
>   	/* userq fence lock */
> @@ -60,5 +62,9 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>   int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev, struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 8918b176fdcb..7022afc17d8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -305,6 +305,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>       mutex_init(&userq_mgr->userq_mutex);
>       idr_init_base(&userq_mgr->userq_idr, 1);
>       userq_mgr->adev = adev;
> +    adev->userq_mgr = userq_mgr;
>   
>       amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>       return 0;


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4D4FD5F8F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F87F10E3EF;
	Wed,  8 Apr 2026 08:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="45o8mKcR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED4710E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0iQmeJZ6G/uZ6qgn8DrcSDR90QvJIJsUdd2UPdi3QLzNMGLH2USrCbx8bzsLN7iPEirVQitG7J7Hnqx9AmPli7+lDM33XWv+PZ2lTGC8PgS8P14M6pwm3M7LNT/F3Sn+BQhB9dNBeO2HkRuwSItFwegvOQrgTf7tVYZwAX8dta9FHsJ42ETVIsqGTe7eQpxCfivw/r9wgnfCcfMBfj/YfdEndbG36YtWPFgL5u9Z8eTapyxxfMpTAw2qziXY4TJyEVXe862WrDu7QWI2jKCT27maz2uQkebrG2xq8lIoukkqIKbNhYRGiW6/qoziHNqmaujFPiBM9OVh3VCxy5aig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtVYDFOQ/dS4WuWHzvfJ4vmCCzDHlqcDm80BvIrakYY=;
 b=jCHPWecnyYpdsKYFeajxZfWT78FWwV09c9ie/0D02aejSvSXCfX0JcsFcTfbAE40OqVfPz5i7xdY8Hh0NvQNpIAMYcD10j9YdL5qrgBFSpR9H1TpEhu6RfK3RnhsgaxNoi64KdavUGyPwVFaWit2j2TPgxx5G9m8Xb5byeI3hl2RTdRuHziQq0A3irnSPtraD3MgqCXByT86byrAtluU7A9+Xt6JYFwckLAzX24eReYZcf2gGJRv8juvxSJ4CFPvn9ucMGoCeSjsaMXZSGeHuiRAMxeuPAW+AfJ45eFp41ltLAaSqmXlre+oTLb0987tIkZ44b9jQT/Yklfwn9V+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtVYDFOQ/dS4WuWHzvfJ4vmCCzDHlqcDm80BvIrakYY=;
 b=45o8mKcRTqlNcNXY6LLongEmqekj/05P47wh2lC+rtdZa3bCbbiE7SduXSY/ZHREoOe6nhp5ER6z3GrT58GeEonPNMWwTgB6W3vRVMFrRL8a1yq8b5UJeABKLlJhG600AEsTRM5Sdg9/Q6spQBV0VRQ19NyI5VlznHvwOHAU1gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:21:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:21:41 +0000
Message-ID: <5774852a-6711-47bf-9e2f-764b21fe7e6d@amd.com>
Date: Wed, 8 Apr 2026 10:21:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: rework eviction fence suspension lock
 for fixing lockdep
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260408025224.3437723-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408025224.3437723-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cc1c63-f5ee-4119-adb8-08de9547dccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: WSHdWD4yBpcst8n4yimO8XqNgO+vd75fE2STbFtDDnAeB7RU3uBC9pvUtNEUk8q+Ns7c2jC39nAQg+Mj/CktTbtTPX2f2bWQpdODWe3ZsZtAgZg8QdVO0LUwRrNtfdW5M3dR5c0+WQUfJJEyVVSZjshQsv0TgZAIe3CA6gLiZP1HplGB8ix3vUX2nb1J315mK5lt+meqnS8O3+VzIO57JG/7a7c4k4Hv06cTrCZee31wNGEiMBe/WQoo5ma5xL7uBOikSNN5clfv2+eXUeOO2UrM0XjUY52k4hEbhoXKFCcdBy1VDPvgsSLnil5IPsmA4G440Z+d0Vqv5XyJe9H2Kf2tNgTlJ+NBRO5w8m96zy5oRcIWpb6SYM2k9umvncCrrI0LLVVx14GZ4OhNHYhlfP0fgDkxFJcN9Oz3fyi/ma6I5uyzYGnUcbG0Bt0GOk0XtcfUjYWtqvZ9aar93fPnc/FxChJ/m5Oxf/eAlhGoMrA0Zbm3Z/utY5j/T4arpMO1aWQ1bjmaQdM7/dJhyVFZRh3MAzKumS9T0uKL8A4bEjQXrknqm6JaVTBvCNgZRtN2DITwY0/AfyDj8RG+NptVYswI1sCU34DudEQZAZ3D/H3iHU0HqzGE6+cnucU+nMxZxxBoOERiKGx0XkLd7/1TLlEUDXYRBaEcBki8IU13ugl41aUBxDt+qXDWXsR+cOb/R3wLNxxZSBoqDW8ZCMO3ZkVhuhE6L600n5dx3aqHaT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3UxZmszMy9vUWxDc242Q3BjT0QvWmVLaTI5bEk2aFFlVUtxVGY1YzhvL21x?=
 =?utf-8?B?eURRWnNRRjZGRVlPZHRxNmhwRHBSSURIKzNrNXpackhDMmg2VCtOZk1EZEcx?=
 =?utf-8?B?bU9KQ05EZDI3dG9hSU1UelFlOHFZV1pZVjBnVUlKYmFXMkpJeTU2MHNOeVNu?=
 =?utf-8?B?QnJkME45TWNpMGNsSDllbjdwcDZ2Zm5EZEJYS1MzbkZnWERzc1R5Qk1MVThR?=
 =?utf-8?B?UFRGVzNNa0VSRzl3RVExbCtsUWE4OTI2NDJPYUtXeTZ5SXVNbGZtRFJoVDlm?=
 =?utf-8?B?YUltcTVrQyttdThlZzRUK3N0ZkxrOVVoZ3ZoOE53MjhHaVlrLzVEMTlPeGx2?=
 =?utf-8?B?SW13ZXBVcDVPZ2ZCQnRxa3BBRS9RRVBSeHpJZUN3M1ZDa2F5dGNGRnJKcGo4?=
 =?utf-8?B?aER4b3d6bjg1UFNWV3RXenZHM2ROWHFPTm40L0hDSXBzL2hBSnV5dDhlelVR?=
 =?utf-8?B?TzJoeFFBeVQyaFg2UVVtN0Z2NWk0d0d5WkJXbTJrdzJzNUFSYmdGNGRkbmlB?=
 =?utf-8?B?L2pFWHVWNHhDY0lGSWtkTncxWFp6M3FzZW9pRW95SDdvQlh2TVJxdHp1L1NC?=
 =?utf-8?B?QUhoNDFsNi9QUDhaeExudDRnU3B6VmRjL3Q0R2tvN0N3ZVpoQklBUzc4Z05l?=
 =?utf-8?B?Wm4yQk91L1dyaHIyWnJ4QXhLemxJa3ZIRXFpcFVEVEdhL2plbFgxYWdKcC9w?=
 =?utf-8?B?ODVYTkprck14eWF0VWtwOTJVWjhyNU5rOTVPMjQvZlR3SGd2NTJBMnhwaS9O?=
 =?utf-8?B?RGtxS1NTang3MTdwMS9QaTYyeDIxaHFHNUlUR25ZU1BBTGpTdGRsUm5tN3dJ?=
 =?utf-8?B?R3M1cUx0YmtwRVU5YVdNcytDMUFqU3QwS3gyL2tCZnNBWlp5Z01tY1U3clBp?=
 =?utf-8?B?MjBKYXJtYVhNWDdYZG5uVjVrMG5LWGhZcVc3MmdaY2Z6YXVVQThhWXdaQzNW?=
 =?utf-8?B?cTdPeFFiWlZKZS9jL29iM1ZxSnNHSjZ2dnFzSWNxczl6c1U4dmlacWZlRjZo?=
 =?utf-8?B?ay9naFNhZVl1ZWlYMTBSVUR1M2VvSDdpWHVDME0rMFlxeUxYS3pMdFJTdXAv?=
 =?utf-8?B?RkZwSjYwZGhKQmVuVlZwU0Q3ZDJsY2ZzeURudkUvU2tMTUpTSEhJUGlMYkhL?=
 =?utf-8?B?elZlek5IeFNUbUZqRWxCa2t0NUpmWVpTOUQ4TkVtWFJxN203QTA0WWE2UGhi?=
 =?utf-8?B?OG5yREtScVFGazFCYWNoWmVkakF0b00veWJsVEcreXV2N0ZWRUlqSDhaRFR4?=
 =?utf-8?B?elAyL2RJOEFmQ3FPVWJnLzkzbXlYVDZXbDhPQ0dGU0JQV0FUVGFVQXNJVWVw?=
 =?utf-8?B?bGFSaHFOdjEwNDNpNGhra2lsUkx5MHd2a1hESXZ6N2FDejI5dXIya3BEZU5p?=
 =?utf-8?B?eUM2NzNJUXg5REtmcmVKS2xuN1lvaXpIY3MwSXM0MldaN2RpcXhXa1ZKRWc5?=
 =?utf-8?B?bDQ1ck50QlVxNmREeEFjVXVNRXdFcGFYM0dGTWRINGhJb05aR0hLN0pYWmpu?=
 =?utf-8?B?a2JhVzZXd0tBMnR3bjRESXFSZTNLYWdWeEkzVGFPQzFuaFZ5NlE1eFNXSU9S?=
 =?utf-8?B?MkJrSisvU3dxK1QwdWJDYjZTMlo4RHpyWmpMRG1HclZtdkhIMis1VWIyVVFW?=
 =?utf-8?B?VlB2bnNQR01ZNE93R2JBRmZwbDdaYVMxd0hEbkhEbTQvVTVPN29saUM2clJI?=
 =?utf-8?B?REFtZnYvR1JxNHROamZQczNXdTVFdVRML3Zzakh3UmQreEtWMTNVNC85cFlD?=
 =?utf-8?B?YkVrV0haekg2VnpwUE8wSDJWUlFNaWE1aGpQQjNQV0I0dW9Sd1JHNVRQVEZK?=
 =?utf-8?B?dExSRjV5TlYwUU9JVWpCMENhdFhhNklzU1lkUUsvOS9HWGZsWU12dlIxNklS?=
 =?utf-8?B?aFdscHZmWlVDWi9sZm1BaWlFTEtvRHFYWFNpZnB6Tyt3bkJmTWx5YmZmZHVS?=
 =?utf-8?B?R3FwN1VzR2VZNEhnMFA3bzFaMFBKb0ZOanU0MFY3ckpHQUhNRzdWajNnRmF1?=
 =?utf-8?B?Qjg1Q0RjSUw4a1BiMzhkSVNscEFrOTBJdkcvd3JHYVlXM3hqVWdGWGRyK2dt?=
 =?utf-8?B?WHl1NXBxTFpXejRMTEVKcjRYSm9CSERWdVZnbW9FdDdRRitBSG9URlVQOTRl?=
 =?utf-8?B?b0h5T0tmV25tck5QNUQySE15MVRQSmJENjk2MTNWRHRaVjIrUmdMUzhPaFdy?=
 =?utf-8?B?L0NnZzJjZk9kdlNVZ3EwT3cwVWFBVm9UUmNCdEo4SWQwNHkydC9jZ0NvdU9o?=
 =?utf-8?B?b21JaGtaYmQxQ1ZQMmtVTUhjSlBkZUxJeXMrdk1iTFFzVysraVByWXF2aXVV?=
 =?utf-8?Q?3G9QYaQcwUQdHRfyKu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cc1c63-f5ee-4119-adb8-08de9547dccd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:21:41.4700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwHp2sPqBamI/2bL79DBrVujp864uec1kfhEiWZ5izacgMWE+jRnCLL0uu/wRveJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

On 4/8/26 04:52, Prike Liang wrote:
> amdgpu_eviction_fence_suspend_worker() ran amdgpu_userq_wait_for_signal()
> with userq_mutex held. The helper used to walk the xarray and block on
> queue->last_fence while keeping that lock, so the userspace signal path
> could never get the lock while the wait fence sleep waiting, then triggering
> 120s hung task warnings.

And that is perfectly intentional.

> 
> Meanwhile, there also rework the userq lock access in the eviction suspension
> path for resolving the lockdep/lock order issues.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 107 ++++++++++++++----
>  2 files changed, 85 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 5ae477c49a53..00c450e31139 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -73,7 +73,6 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	 * allocate memory while holding this lock, but only after ensuring that
>  	 * the eviction fence is signaled.
>  	 */
> -	cookie = dma_fence_begin_signalling();
>  
>  	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>  	amdgpu_userq_evict(uq_mgr);
> @@ -83,6 +82,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	 * userq_mutex. Otherwise we won't resume the queues before issuing the
>  	 * next fence.
>  	 */
> +	cookie = dma_fence_begin_signalling();

Absolutely clear NAK to that. This only disables the warning but doesn't fix the locking problem.

As far as I can see the patch here is just once more utterly nonsense. What problem are you exactly trying to solve?

Regards,
Christian.

>  	dma_fence_signal(ev_fence);
>  	dma_fence_end_signalling(cookie);
>  	dma_fence_put(ev_fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 9d3c39e96ac1..7691f169415b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
>  #include <drm/drm_drv.h>
> +#include <linux/lockdep.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_reset.h"
> @@ -34,6 +35,23 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  
> +#define AMDGPU_USERQ_FENCE_WAIT_POLL_MS 1000
> +static unsigned long
> +amdgpu_userq_fence_timeout_ms(struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = queue->userq_mgr->adev;
> +	switch (queue->queue_type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +		return adev->gfx_timeout;
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		return adev->compute_timeout;
> +	case AMDGPU_RING_TYPE_SDMA:
> +		return adev->sdma_timeout;
> +	default:
> +		return adev->gfx_timeout;
> +	}
> +}
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>  	int i;
> @@ -176,29 +194,12 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  */
>  void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>  {
> -	struct amdgpu_device *adev;
>  	unsigned long timeout_ms;
>  
>  	if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
>  		return;
>  
> -	adev = queue->userq_mgr->adev;
> -	/* Determine timeout based on queue type */
> -	switch (queue->queue_type) {
> -	case AMDGPU_RING_TYPE_GFX:
> -		timeout_ms = adev->gfx_timeout;
> -		break;
> -	case AMDGPU_RING_TYPE_COMPUTE:
> -		timeout_ms = adev->compute_timeout;
> -		break;
> -	case AMDGPU_RING_TYPE_SDMA:
> -		timeout_ms = adev->sdma_timeout;
> -		break;
> -	default:
> -		timeout_ms = adev->gfx_timeout;
> -		break;
> -	}
> -
> +	timeout_ms = amdgpu_userq_fence_timeout_ms(queue);
>  	/* Store the fence to monitor and schedule hang detection */
>  	WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
>  	schedule_delayed_work(&queue->hang_detect_work,
> @@ -1274,16 +1275,76 @@ void amdgpu_userq_reset_work(struct work_struct *work)
>  static void
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
> -	struct amdgpu_usermode_queue *queue;
> -	unsigned long queue_id;
> +	lockdep_assert_held(&uq_mgr->userq_mutex);
>  
> -	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -		struct dma_fence *f = queue->last_fence;
> +	/* Rescan the userq xarray after each fence poll interval to get
> +	 * newly added queues or fences.
> +	 */
> +	for (;;) {
> +		struct amdgpu_usermode_queue *queue;
> +		unsigned long queue_id = 0;
> +		struct dma_fence *f = NULL;
> +		unsigned long timeout_ms = 0;
> +		u64 context = 0, seqno = 0;
> +		bool signaled = false;
> +
> +		xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +			struct dma_fence *tmp = queue->last_fence;
> +
> +			if (!tmp || dma_fence_is_signaled(tmp))
> +				continue;
> +
> +			f = dma_fence_get(tmp);
> +			timeout_ms = amdgpu_userq_fence_timeout_ms(queue);
> +			context = tmp->context;
> +			seqno = tmp->seqno;
> +			break;
> +		}
>  
>  		if (!f)
> +			return;
> +
> +		if (!timeout_ms)
> +			timeout_ms = 1;
> +
> +		/*
> +		 * We can't use dma_fence_wait() here. Waiting there and then
> +		 * reacquiring userq_mutex creates a lockdep cycle through
> +		 * dma_fence_map:
> +		 *   userq_mutex -> reservation_ww_class_mutex -> dma_fence_map
> +		 * and
> +		 *   dma_fence_map -> userq_mutex
> +		 * Instead, drop the mutex, sleep in bounded intervals, then
> +		 * reacquire and poll the fence signaled bit.
> +		 */
> +		while (timeout_ms) {
> +			unsigned long interval_ms;
> +
> +			if (dma_fence_is_signaled(f)) {
> +				signaled = true;
> +				break;
> +			}
> +
> +			interval_ms = min(timeout_ms,
> +					  (unsigned long)AMDGPU_USERQ_FENCE_WAIT_POLL_MS);
> +			mutex_unlock(&uq_mgr->userq_mutex);
> +			msleep(interval_ms);
> +			mutex_lock(&uq_mgr->userq_mutex);
> +			timeout_ms -= interval_ms;
> +		}
> +
> +		if (!signaled && dma_fence_is_signaled(f))
> +			signaled = true;
> +
> +		dma_fence_put(f);
> +
> +		if (signaled)
>  			continue;
>  
> -		dma_fence_wait(f, false);
> +		drm_dbg(adev_to_drm(uq_mgr->adev),
> +			     "Timed out waiting for fence=%llu:%llu during eviction\n",
> +			     context, seqno);
> +		amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	}
>  }
>  


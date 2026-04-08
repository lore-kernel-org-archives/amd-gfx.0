Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5150FFD5F88
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA81610E572;
	Wed,  8 Apr 2026 08:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAm/zlKp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2959D10E572
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/GlXqptZnjrweqJtxSRN7X1j+EhVZMc63OZwT2qEtEovJVyJ2ZQ9pGhzzXgCFOxxP9LaiGCtigzaoXGtrTid4TaDI52DFMzmUYhiXM48Sdx8YIq91Muns6Q7WUKfAjgu5M/GnojWssOTxzc1eM6wlDh0ilLrYGXvH1CpmEwHpsTYMPtdo7LKWaSCiKvVogI38UBGhLx/SWCkngZb1sTTu3Gt7sYT/wM9KtxGQwJujQ+zrQ2ZFriHX/9KKxr613ojUeVB5GeHEVjKbPOEmWrDA3YHbtoSuIlicg8t1Dac5oKwCE24iZC0X0Hp8JgcLiDXDlXUKvSeLU0gHof8v8eTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro8Ezr/WOLAOGsLR2/0UVNKxldkKoyFasTQCARMfb8U=;
 b=Fz4lJptSQx8FoJ/OqkaR83KrxkRytLtynP0syITttB6bcX67Mlqi9vFKCB3kIXNvZ1rs0I57tvPuOrAxINGk+LgbK9at65gfM/TIm9OLc3i0kEtOU4XRhnQZrkunfleXLn+PcV7IMbTsiMxItsNhNAF56lG0A3VjWJn//o5QLB+M2qatw8QlNL60joMJxsHDYDKZ0UMqVsYEg9KF2NUzwUE2KhtoPqhAs3v/6qMi71Vm556U9zgYGML9KrBZCj5tTvkTji4uXuZnoaDc0LazW9+pyWGWO+wfaSWnWXjkwT6HFbAX+tOORh4CSKDmf6EhOaD/yo3f27ddDhyXlfY/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro8Ezr/WOLAOGsLR2/0UVNKxldkKoyFasTQCARMfb8U=;
 b=bAm/zlKpvLI6HHtJHc+UgYpsZhBKCQP3vqjp8w/59SgA2Ps63N7D2S87KMm0GpxY9/rykNIeJu4UuupdqekLl8cdJt0YV+r1N37kO3WJGobEGCCGdrc7RvU1/4184FBo3fiLXiB6ryrpJYZTHwraCPuL+Qx1XO54cH6+e7rp/+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:27:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:27:13 +0000
Message-ID: <9a52847a-eb80-4008-8d18-9707bd1751ca@amd.com>
Date: Wed, 8 Apr 2026 10:27:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260408074537.3439191-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408074537.3439191-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1947e18f-6dba-43f7-41e2-08de9548a2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: +g1QqVJJFDazTO0scYgXn4WYcKD7EkTgur0o553iZOxJbqZCxJsGD/dSdBiPGXsmKMOfSg1fx+ey1cnPNpiin7X/WFulfpNisMakreBPXpepjV/9mN1VZUwRv+iXGVzXHqULq3ygJyxO9Pm9ePOvR0ROivcibSS4ckXvCwCLes4TsezZIM0IVhzG5UsRXXDP4qkDLGM6BpJVaLUaXZdr/YooxNtuzIS3Tf0RM9ZZhWYG8ss34JXlg8rhYAR2mRZSkMonFiDkd6tvddYm5RJG26vcWVu8jcvlLKjM7xGJmQ/naHwL4lNfe/4OtGCzGmdNiUY7sNbBl3zL0jSOHLd7cefPebhFOAjchMRRYraJNRZGxzi9Lyx0XQdA8IjrKzaFgoj4rE63VWtVGx33vUeOr2eBbhsjNzrSItxKdBXX+xIxrjk6pDvp9qWQ3xjGJegSqMKL/OwNbmWvwARz6fGIBgXlGRR/81DwLoOsoj+vi+X5W5u1zszqxlylQcy9jXSJW3gOCJ7uMK2w1RUn2cXd9QrA6k+wXEzWOodFnnCH0drhn+M46bInSsQyY288XITRl+Q8pdlDDZ6xnFLt0wvEXGyFR1DroFwZ9tt6xAFbx2MsAUjCMij5nUg9/P/kse9EMdJYX/IyvgOkZUYF9+G02890zeRxnBl7Mn9BmFrf6MYB3bJgado9EY46ooMsRka6Q1n2KL8ApvVBCU6BGARK+SlpVM03kCCajzrTxBGMtDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Rna200dkVPenB0RU9ERnNwdFZoYi9zMkRqMFZULzlocnJhMjVQMmZxa0ov?=
 =?utf-8?B?aG5raysvSDk0akVMRkNNTDV5Uk0ydDZhR3BlUzMraXBybGtVWllrTFZ0Q3Zv?=
 =?utf-8?B?eVpuUlNqY1RSMFJ0eG15SGhQeWFBbVpDQlBkZVBUZ2Qxcm0xNk5BMW5xUEJW?=
 =?utf-8?B?dUJrQUFaVVpER1lSM1NVekZ3dXVvME5ZUUx5YU0wT01nUG5UWlUrSnJsVWZP?=
 =?utf-8?B?MVltMktXZVJUNHZkVEhBbDAxNjJuUGtXaHZDeUsrOExFbkR2K1ZaTGVzSUN4?=
 =?utf-8?B?U1Y4UUJzOXg5T3Nhbm9iVlUxSnNwNnJSaXpJNnVvbDZ3K1h3bmVsbmdaQVN5?=
 =?utf-8?B?S3ozMmRObzhEbTNmVlNSVVJVSlFTb2JzM1BoR09xa0p1bWxQUHNsc2g5RWxM?=
 =?utf-8?B?L29HWjhoU3krV3lickc4OGc4QVNzaUc4b0pGTFUveklnMlBwbjRXcGl5bzdJ?=
 =?utf-8?B?ZEtlMnJtOVVaeWZHOVh3eFVIWGlKcDZsYjJRSmJCTC8va1ZEclNHN0s4RkVv?=
 =?utf-8?B?QXowUzZUSk1mdkpIYzIxSk9MK1d0UGp5QVpQOTVXcVpjdmdpcUFoQ29OcXd1?=
 =?utf-8?B?TmZMaFU5TU15OUo3M0owYjl1RGxrdGRBeVdabmtqV21NVUNDY0MzZytFeEFp?=
 =?utf-8?B?ai8zK0JENW9vWnVGUC83TmlTSlhxTUFNSmdRd1Jnd1V6dDhSK2RuanE2ZmdL?=
 =?utf-8?B?M2wxVnFCWERYVm5tZU5zVlp5QmJCaWYyeCtSSFVnWDJrYkt3YW5kbzVZbE01?=
 =?utf-8?B?MzVQdDhQYmczcjN2MGU0YWM4Wm9qeWVPUkZxQzdoYzE0N09ObytHamVnbSt2?=
 =?utf-8?B?ZFZ6Z1V1OFpCdU4xa2hvZ1Yzd3hHK1Nmd2hYSGRLUG1zT0JzUEZPSUVhemVB?=
 =?utf-8?B?T2YxUjRNNWFRSEFKcStlMXlZcENiSDUvY3E5T043Tnhzc1VleGtRVGwwSnhO?=
 =?utf-8?B?bExlTXpDclMyUWVaMGFQTDRGcTNpa0RRN3JWR3lMQXUwQll4YWtraGNiWk5J?=
 =?utf-8?B?ckIzY2EvSUVydDRGSVowMHZ1aTU5R3ZiVU0vYnJDYnlIMVhYVHk4bmpzUGx2?=
 =?utf-8?B?MXVueWU0dzk3UW5sNUUxcWJIYXZYTzYvMWhKU1l5NkgrM0pTZGZtaU8xL0hG?=
 =?utf-8?B?TkF6SlUwazE1RVVGaG5XNUVxNkUxcUZDeWhVQ3FkV2ZnSnJBUFk3U1VRS291?=
 =?utf-8?B?ZWZLdlphZWZqZVNDYTB4aGhSSGxEOUhuN2hlMGw4bFdUOFNMYUZ0RVJVTFpF?=
 =?utf-8?B?K2YzVWpHM0UrMmY3WWJPS1BKU2lpcHg3NC9RTUJjNCtVNElVaG1KTjRUUERO?=
 =?utf-8?B?YjlaSmVrY055d2JxNlJZeWhIbDRHT3RmMjF3dXZ5WHRvTHROM3BNUkR2ZmRt?=
 =?utf-8?B?UzJGdldtTnlDdEZJcFFIb0g0NnRORVk1c1NrZklPRzZ5eFBLWU5Na1I0U2RN?=
 =?utf-8?B?SE5yV0oxR1F0L1RPam9IbEVsbEVhRnJ2a3l3TURudFMyNld4RHA4Y1dOQmRv?=
 =?utf-8?B?L3huZTUxS3ZXNENRaE5rU2p6NjVDR2cwRUNsT1FUa25CQ3ZrUm5QeHVRZWx6?=
 =?utf-8?B?SUdSTHF2MmEvZHRNN29sVVovTGhJblRFZU00K0lOYmtqOWwyTThDenhKN05u?=
 =?utf-8?B?NkVzSWJhOUVleGtwOTlVWGF2UHBuQVNqZXFlV0FtNkdwNjVydFluL0d2Unhj?=
 =?utf-8?B?a3p4M3JSdXdwK1lYaklURjhiL3dSWmxydDlUODhHZXNGWVd6SHhmaVJ3TDNE?=
 =?utf-8?B?TjlLb0hEbDlGZmZObFdCMzZ5MWlWcW9hdDBjVVdZZDgyR1JqVk5yaE40djg0?=
 =?utf-8?B?Q1VJR2JBdWE1ZlJ6QUMzRS9ha1hyeXRKMy9HUXdkR1hXeEVHMkZEblRoeG1w?=
 =?utf-8?B?RFdrbXdUQWdqNE0vUU41WFVGWVpEcFM4d0FSUm1QbWdSRldBbXQvdE5iWjB3?=
 =?utf-8?B?TEtLd05DOWJ6dUhiSlYwK0hMelZXekQ4Ky9YMWVDS0xYMEFWL2x2K2lkdFlU?=
 =?utf-8?B?NDBYNXFxRGpEMHVveUNkZURjaVNoMlZJWGpSSUFRQ0NCU2lSTE9FSVJwaTFN?=
 =?utf-8?B?VXlJUHRpY1FDSTFoZ0FzRUVuZ3IxYysvVXp4cVNzUlhPUkdqZkgzSlhEL0hV?=
 =?utf-8?B?eExRWkRXb3hiWExGQnRaaGladWptV05nMzJRSGlEczZLTUtucWNKZHB4b3hz?=
 =?utf-8?B?aUNZdVltK3VRaHRNSENLcXJVa0lONGtXZUJ6YkdFOUhsZFE2T2dSQWZ0SFJl?=
 =?utf-8?B?bW40NzNYNndIaUh2cnBDRzlMSnE3SkdSb0NNRWkvM2NXRHJwREcyQUNLSFB6?=
 =?utf-8?Q?CX+963ejRPYdbTda1E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1947e18f-6dba-43f7-41e2-08de9548a2a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:27:13.3204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GAqvlCSdpiupTLt3/M6UE+xYsrI6Lm46SRHqOGPKep6SLjX6c/ZlEV87FFxxwNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

On 4/8/26 09:45, Prike Liang wrote:
> amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
> drivers and stores them in waitq->fence_drv_xa. When a new userq fence is
> created, those references are transferred into userq_fence->fence_drv_array
> so they can be released when the fence completes.
> 
> However, those inherited references are currently only dropped from
> amdgpu_userq_fence_driver_process(). If a fence never reaches that path,
> such as it is already signaled when created or it is dropped through
> an error/cleanup path, amdgpu_userq_fence_free() frees fence_drv_array
> without putting the referenced fence drivers.

Clear NAK to that as well.

An userq fence must be signaled at some point and when that happens the reference fence drivers can be put.

What could be is that we have another call to dma_fence_signal() where we forget to do that, but it should *never* be done in amdgpu_userq_fence_free().

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3be80a82788a..bd196599d3d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -145,13 +145,21 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
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
> @@ -166,10 +174,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>  			break;
>  
>  		dma_fence_signal(fence);
> -
> -		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> -			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> -
> +		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>  		list_del(&userq_fence->link);
>  		dma_fence_put(fence);
>  	}
> @@ -320,9 +325,9 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>  	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
>  	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
>  
> +	amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>  	/* Release the fence driver reference */
>  	amdgpu_userq_fence_driver_put(fence_drv);
> -
>  	kvfree(userq_fence->fence_drv_array);
>  	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>  }


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88D2FD5F92
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7812910E56E;
	Wed,  8 Apr 2026 08:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z3XAUqKO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11F310E56E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMm91scvu7DB/C+DnnH0k59A1tSIRNmWCA4K8nu4cwI4zMWHexGu9fZIemCzaMdzvaZ7cOJAHbcx4PCASfKGwmpK9CoWW/LSeb7QIzzIKtywY2okxJUjh1lzNR7I25BTpdaLEbKojIDrWI6VV9EmnKkvmZxejuySEQYhEd3PRdMgkMHa/UYI8JE6tjlZiD/lyJ6lF7arOirXKsh/20kprDNKSBczAZWHT4sC6+HKgVlU+u8iGOQi+AU3pvvbMTBv9GLLWNjpsvpBkUBzb/4LQaFc5SuR0RsoEILDQFtdPX3+gAHu9CyH75gqahgdH9fD6eCGqOs6febgwCHaNGQk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGMO57mQIoFIFj/bH4KQya0FP+utum6WYFkaFcsesnc=;
 b=JW3Yjgcuzk7qpVDxoZAzgaurPxSsEDZlrURU9/qq5E3QzuZPjCm3qXGMmg4y4X/XB4HqALZU6X27f2JgJk3GkuekHdHTxdkTZ9P0OO2awPRiQhQSpkH50KwMDgfSYz1JrdtQbU+bwK6c8KGXCer7YQbzI+XqnpYlNiJ1bPOpKpHZ8TwEEza91cIqhYgmMkeykKtUFePpZpZnfuxbxeFZZBiKMuoV0mOwPgkobx2aibAVnDFhb3n76fmG0iBkAVrCY/88b0qAITD6VtYb1sjNC3W4kJL3ZjirpY1P9/mll5QXuzOlt7h9hL9g2mpIvdTQMSko/CE5XfriZsfXV8PNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGMO57mQIoFIFj/bH4KQya0FP+utum6WYFkaFcsesnc=;
 b=z3XAUqKOS5zG3bP85ag/y2/vRAv9gwzKWRN0/AdgVdXp392/6FheXHd5AzGBCaLYf8YRmalI9dwiFuUS31eFQvqnRkuYNFziTlVCwFX5qe4us3LGA8Hv3xnJ1GNXSLVsX8XT+ROHR83ahlw3DpCkNuV+7ZjeaJJuw1xbwJRiE5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:23:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:23:55 +0000
Message-ID: <6e31b77d-a465-46d8-a299-1dd10c88334c@amd.com>
Date: Wed, 8 Apr 2026 10:23:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/2] drm/amdgpu/userq: avoid uneccessary locking in
 amdgpu_userq_create
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408053603.2894742-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408053603.2894742-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4f41d2-1fbd-44b1-61ad-08de95482caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: xcS7lRZHHWElSbMkgL8cxOLLLlaH+OTX4SY3WNoHPDRWGUQzOPWA2PoW9A4NQ6k3uHiYfPPdH2uDJ2Z7yp1zWi9xK2zc9uK/gXmFx0fl7dVB3h1oAsWe5/3FbqdSsv2G+6IvZIUYOjSww0J05069RpVp8Tl3XW9t8aCXe8AmeqcORW+0VUCPRCX+I8A8uZX5Rr995IPYWw2290fv33aFpO1iTEZx67yAxidOcb2GHBp0W4RskreeFHOt4XTk7ZYkiOrpvOEF9fUdAOtLjFHwjiWndsaBM9fWZ11eww6Lxjr9M2B/QLXomJiZKnISmEmH8wedswltWd8qncs/Seyqyl5GHD9L0n+FxYDEmisFIpvuvWf3CnCXVDqawihtljWuS2LwiFCK18+9mzCfSNWpCTYsgA2emep7DSu6rCCiy7FuxDB7NSHKfhw061oo1MD+o9nnGhQFRtFrvxWXeZAaDZqWne9ccxAkZzdNA6CemD5zxC7Dit2kcRD5y+mGNM6dCp+BuXHMyWqemJjOKMQTllDVf5gdl0hUGwv48hwwp1N+U5bY6kOO4c0ejQZNxeG+sySRqbErUp0RTInSkn3Bt10709isvZkVjmZbMsxZWyzWVXn4lXg21+kMZM7fb0ARVsgnB9N6sdYKhfWgFcBg8VKWx4K/DEQ6LdisAsRGWjExZBmC2o4qJsT6dLJCQpRH9oODKlEwcObMIpujdvxhK8DLpx8QaNXZh5TJ4WEZ4mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzYyaUJpOEo0aWg4RytZa2R4T3JpM3hiSlJuS1FRYmJOcW9RRGljMVFCQXg1?=
 =?utf-8?B?QXRSdHdidUptMDlpTHNUOTZ0eFZSMGJwY3poMmNxdm95KzdydzhFVnJLbEdh?=
 =?utf-8?B?RVc5UDlsbFJhd05lOTUwY29RQ0lyajFyNzBIY21LdGVOZWw5c2tTWWxZRXA1?=
 =?utf-8?B?cGNqdkhCTklvTHl6V2ZSU0JHS0RpMGJuUUZFeXptTkE4cWg5RTRJaWd3RlN4?=
 =?utf-8?B?c3VPNEZFNWE2eHFKbDQzR0ZqRVdOQlVCYW91NnJrNnlxcGYvMGtlZkg2U0M3?=
 =?utf-8?B?VWRYUWVGd2t2ZVpySnREK05oMW54ZzZqMDNqd1RiK0lQRGpLYXlDY3BQMGFT?=
 =?utf-8?B?R0hwMUZwWVZ5QlNTOWthbmJwb3MyVU51blZzUHhyS0FsZWdTN2hSOWt5MHlm?=
 =?utf-8?B?TEp2cmF5Qy9qRzduL1Jxay9xaysyTWp3eCtiVS9KaXZxUGdyK0tMbHJuWXJM?=
 =?utf-8?B?RGdnKzFHcEhTeEV2eDNVQWNNbW1NajdmMVZhUVlvMjJOaWMwZG5vZStEWDZN?=
 =?utf-8?B?MUFKSWI0RC82aTVOMUx3RVBZMXBJc0hoSmkrUU5oUjBqWHE5WmRweHR1Rk9E?=
 =?utf-8?B?OEJmSStlcUJCSkJJUVhmNlFwZlV5WkRLL3UxeU12N2tyeHJ2S0J0S0NsU3FQ?=
 =?utf-8?B?RlNkZEhNbit6V3I4b05xeUhHQzVxaEFLOVZiQ3J4eGw4djR6N1RJbWt6RHZo?=
 =?utf-8?B?RWZVc2N1NnY1aFRpSi8wK1FIRXV3L0ZaTDFobmtsWHMwdCtvbmxmQ2diS3Rm?=
 =?utf-8?B?aEZwdTBzTGptNTdsU0dCZHdXTFErYm1ORStPT2ZoRWZsN0VCMzlpZzBURlNE?=
 =?utf-8?B?dkZSREEzUGQvZGJ3eWtRVnoyVllWajh1RCtrUTRkYmFlR1lTR3laWFhaMXFq?=
 =?utf-8?B?Y1UrVFQrVldEamNkSGkvQ2xkZFFHOFFjdFlVeHpqenllTnI3cFhEZnlUVFdx?=
 =?utf-8?B?YU5YT1NvQlY2TXJZOGFUcG5FVy8vNENkaTdsS1pzaDVYNGpJZVowaVgwWGw0?=
 =?utf-8?B?VTlGM2ozWmlEOEVkQzZtNXRibmdHQm5QRXE0MW8ra3YzaHdOM1pqVlFKSHN4?=
 =?utf-8?B?MjhmVVpxMndIV211MWh6aU15UTdtaFpaZzh0cnEzeEZPMzM2Ryt4c1RRNWRC?=
 =?utf-8?B?NUV3OTF6OURTbFJ3RStHcE1ZdFNLZmZnamxaZ25PSGlpNXZrVFVyY2hUWTNM?=
 =?utf-8?B?Q2dVR3JkK0lKaXNEQmJTcENVSmN1Z2VMZEp2OHdmQ3BUd1htMUxqeEdMZWRH?=
 =?utf-8?B?TzNSSGlqRkpCY1BZZTBqSXZ2SnFzV1FQbXlUeVFTL3FhR21tWEd3UWg0MjZH?=
 =?utf-8?B?TG91eXUrZmF5eGR1Q21JVXBEODNrR1Byb3JTcm5JVXB4T1hlcHpxcFlteWxp?=
 =?utf-8?B?Wkd4cS9YcVhRZmV6cllFZm85eXprbzlMR0MvaDdCUjlheTlTYXBwdmM4eXcz?=
 =?utf-8?B?Y2VKSnJBRzhhcTdoWlMvU0ludU5RVXR0bUMwbEFmajlMYVBZc0ZTdnlJRk1X?=
 =?utf-8?B?TXV1UmsyTU9iRk1NVllCLytCLy9SVzNyYUl5dUlDRHlxVEY1OUkvQkMyVnYr?=
 =?utf-8?B?bGYxbVpHSy9LQTRTODFhZFQ4cGpudGQzM3F2eU1xMmh0ZWFFVVZ5OVlCN3M4?=
 =?utf-8?B?SjRWUDA0Smx4Y0RjOEQ0YXliNm43SDhVMmxPYlR4VmlwMEIwZDhwOFQ0MTJ6?=
 =?utf-8?B?OFZFVzZwalJzWTFSS2NoK1lUY1JrQVRwTGlyM251WEVuV1FwTS8ycG5pSENi?=
 =?utf-8?B?SWNWUGtwaDJLM1djQ1k3RzZCMzNsOEVRQ25KT3NoOGhpYjFHYUVRQmNIdmMv?=
 =?utf-8?B?c2FpcXkvS0ZrVUtKTndrYm9OSHNDaGg2YUlhSnZxU3FtYjhsMHZ1MTBndDQ4?=
 =?utf-8?B?aldremQrUGVFR01MQ29EaExtckU5dkRLUFNDREc0NjlKNk45RlltMGNYNDJC?=
 =?utf-8?B?S0ptQlBpcFRXVnJhcUFaK3RSVU9QMGZtOUZLd2NWaExtZ3VBRXd4WUJIZzd0?=
 =?utf-8?B?WGEwTlRwUHgyQjBrbzdSWHRxL2ZoK3dpYmRaVzRXWDlTRG9HaEJEbVlYbkpB?=
 =?utf-8?B?dTVsY3RJNUc3RkRVK1dHUGNtVklCcWFVTnZqZmJKQkxKK3FNbFFvRk5ORk1m?=
 =?utf-8?B?am1vYkREdktBaUNJbktESnlJK2Q0MFNhQXdnVHRDMkhHemt1U2szUXl5eEFm?=
 =?utf-8?B?ZjZJQ0NQamVycUYyZ29NYjZvaksvSmVOKzczeXRKQkVGSkVLREVaTnZpV1A3?=
 =?utf-8?B?TEUxL0RMVGtnY2lLdjgwZkNxb05iN0YvUlhIOG9LdHZkdzFhOE82NDVqOXh2?=
 =?utf-8?Q?RGWNYPa2y9MtzQbbgg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4f41d2-1fbd-44b1-61ad-08de95482caa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:23:55.4469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8QpWljNVGoNwfNYdxar6HZuxRosEHwt7sPATfBrMqZmWGIEw3CgF0VHaQG55MSg
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

On 4/8/26 07:36, Sunil Khatri wrote:
> Reorganise code to avoid holding mutex userq_mutex while
> also trying to grab exec lock ww_mutex where its not needed
> for function amdgpu_userq_input_va_validate
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3a6e7a569c78..3f502c18879a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -737,28 +737,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		return r;
>  	}
>  
> -	/*
> -	 * There could be a situation that we are creating a new queue while
> -	 * the other queues under this UQ_mgr are suspended. So if there is any
> -	 * resume work pending, wait for it to get done.
> -	 *
> -	 * This will also make sure we have a valid eviction fence ready to be used.
> -	 */
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> -
>  	uq_funcs = adev->userq_funcs[args->in.ip_type];
>  	if (!uq_funcs) {
>  		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
>  			     args->in.ip_type);
> -		r = -EINVAL;
> -		goto unlock;
> +		return -EINVAL;
>  	}
>  
>  	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>  	if (!queue) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
> -		r = -ENOMEM;
> -		goto unlock;
> +		return -ENOMEM;
>  	}
>  
>  	INIT_LIST_HEAD(&queue->userq_va_list);
> @@ -781,12 +770,21 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto free_queue;
>  	}
>  
> +	/*
> +	 * There could be a situation that we are creating a new queue while
> +	 * the other queues under this UQ_mgr are suspended. So if there is any
> +	 * resume work pending, wait for it to get done.
> +	 *
> +	 * This will also make sure we have a valid eviction fence ready to be used.
> +	 */
> +	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);

Even that position is not correct. After grabbing the userq_mutex we can't allocate memory any more.

> +
>  	/* Convert relative doorbell offset into absolute doorbell index */
>  	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>  	if (index == (uint64_t)-EINVAL) {
>  		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>  		r = -EINVAL;
> -		goto free_queue;
> +		goto unlock;
>  	}
>  
>  	queue->doorbell_index = index;
> @@ -794,7 +792,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);

So doing that here is also forbidden.

Regards,
Christian.

>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
> -		goto free_queue;
> +		goto unlock;
>  	}
>  
>  	r = uq_funcs->mqd_create(queue, &args->in);
> @@ -858,11 +856,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	up_read(&adev->reset_domain->sem);
>  clean_fence_driver:
>  	amdgpu_userq_fence_driver_free(queue);
> -free_queue:
> -	kfree(queue);
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
> -
> +free_queue:
> +	kfree(queue);
>  	return r;
>  }
>  


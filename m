Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A87BC79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 03:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 940B110E41F;
	Mon,  7 Sep 2026 03:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iv1AcD8W";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011011.outbound.protection.outlook.com
 [40.93.194.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C33310E41F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 03:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vgtj+SA3WF0ISR770R26xlMZzAHZXBCFthT3faFfKHsSjs4NMnlLIcPbgzErxMPEGzBFfOcJwwV01VGfl0voa8r/MGWgnX0rnBmRGkhIEQWSL6Hgv+jQOuqhoreKH4uW8kn1jJccj+VA2A3WGtF+RcjGUZlO0RgQxk4LEKORrKKhJI8/defOh/oFH9gJsvtZ6fsAHH5hOgXORnAKpV/7ygtTWg3tWe1XmVRW3Do44w6foieBk4W36iHaXgsgcFSzTjj6TZn4wTPxf9X886Tm5yMhqduvCefXlOChSBNmfo1NSp0btw7oQdxdYPxucvVqZ55OC4J34zo2i/fxO2X+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTcgNpsHfe6U94logpf5QJmjTP1P5yh+cHy/Rgdk+54=;
 b=aByyV3phBUq2IIBKz13LXhGUkd5cmTF45mB1LO3+GIFb1FOnzK6NX0Wz0HMOl9E+5Ba/5U6oO3zYkdApjrlF3zCRZBPjzxdhFmp/G5j06gZqGigMV1v1n/gGoU+sJj21YrLxHVsvrZ2msRst7FlFDzUqKGY4l9Wl68ce86Rp2z12Nz/fvkB3Jtm0p0eSDOyafOGyXVeRt3mfsYMo1bzCGgws/yDRC2/ex1vmMDaMaWimHCAXoW5U98xTqP17fqRXmyqcLCUy99UmGhzobw9gRgG1+uudqWhWPQqH6EDZn9IFQ6dEc6GJHVdpg6u2NRlmSv5mf5iUhp+Od+1DowHgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTcgNpsHfe6U94logpf5QJmjTP1P5yh+cHy/Rgdk+54=;
 b=Iv1AcD8WDod/RzGqWz8r64X3XcsW9NHqeISHtIZeY8YujdwLHYt2IUCAA+HnbqYSw3mIP8SH3Lp5jgHy8it05P+aU1Im6Md0wxlq/Va9mwHH6G0bi5dnPQehJ2ARKzxxDjIrd17aenxJgJL6Ac8fS9NfpG0k4vc9qGRHHUfq+NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:44:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:44:06 +0000
Message-ID: <da6a14bb-dd4b-4d1e-b9ac-24f29e905844@amd.com>
Date: Mon, 7 Sep 2026 09:14:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: balance KFD suspend reference on
 partition switch
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Stanley.Yang@amd.com,
 YiPeng.Chai@amd.com
References: <20260905043031.1015676-1-xiang.liu@amd.com>
 <20260905043031.1015676-2-xiang.liu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260905043031.1015676-2-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0309.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 313d1670-f86c-46fe-d72b-08df0c92446d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p4/v1Z7QqYkTapgS+rLoJ6LFXOU4Fts5D0RtX4v5NIvOdvYXqiCngl48W9nEEO77Doh7sSgWXuQpSzuMohoeCB7lD6yBJTbJx6gEgNApAH1QVPmvQKn4v2wFDG0Kht005j5UJ9PC4GLOtMFW+Bh3OEDjhf/KSRTHqKwxUJ6ZnNUB/LooIrelhVb2bG5znPD3OQjofORKFy5n7cpQUONEnddUp0GvagnlZH4/dksEPuLfooV1W7wVNilmEWceqvDyGDW+Mr8FedVo4rQRK9ltFe5TTWGjumvKDyvMCeVdNHi2iFFAfbUE2RtOjPAVwtnqK/WkE72mQUT6/YCQHgLYK9s3A8KdGJ7yQyjetWKnovI9qrs5sVTxXSN1lEEdiGU2gfbDEG8vGm5CVZDub3RWhX3DgW4Sb8yiXH+YuD0Sm5AK4yRmV1Nhx2ZM855k8e1oK/hO10JJh/n/gzs9+apXDAhW1K49OD4O+H/PbTYnVROfHQsVmJ1jACGEexvBmsBMu01JpFOoXMJFPuph88JVXv9GNP2prStREWg2uSf4hqRC3VwUCZ1w/dYiRkLKCfJ1FLQsfXEl3NkbIBa2jc+8HNccBD7S3el4od4JkowuR8QvEZEoV7Ytjls6Jjwe2egQRlWfSuN2og+9sVP0m6+kKthfsKPnTBnW5APtFBxgwUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWMwZUlIZUhSZUJiMUpSSDBvcWowR0N0Z0xWeG1ZYmxWRkROWHJxYklnT0pr?=
 =?utf-8?B?bXRJU21qWW4vKzMzSy9kZStiajlOcitiUXp4d2V2djE2aDBEVDVIek9pMXN5?=
 =?utf-8?B?MFVXeks5TDFaR3pGV0Y0bTNSaGFwRU1qaHhFTWFYWHpzM2QzQ1UyOTl1c1ln?=
 =?utf-8?B?RmlqbytmWEljOGtSUmRUSC82RUtNWFMvNyt3cE0rZDRWNDlLMGUzT3BWdzFR?=
 =?utf-8?B?cnFqT3BHemh3bXlYeUVNZFRGcXVFYUtneXB2di84Uk03WGdHQ3FCMUU0ZkxQ?=
 =?utf-8?B?cjMwQUwrV1VMSVJUVnYvWStjS0cwRnRMV0hveXV1MUQ5V2FGNmhDMmtsa2Vj?=
 =?utf-8?B?T2IxVE5sT25WOHpEM25YcTVjL25obzQveXpCT0IxeTkrck5ValN5WksyZyt1?=
 =?utf-8?B?N28vNkhQbkhXUXdTR2ZYVFR2OHBIS0ZXZHoxYUgycUlyU0ZCNjFVbnUxbUZP?=
 =?utf-8?B?RW5hQlZFcGFtYlgweTJBSTZHbG5GNXg1SkRsZ2V5cGd3ZllUNmpCZjFUbGxa?=
 =?utf-8?B?d0xWVjg4MVlpVVVEUUpPdy9XT3llT0FPSXJ2N3hWOE0rNWpXKzdFMmZqNUhK?=
 =?utf-8?B?T2JYNHpVN3pnVG5nVWRnZHUwc3JCNFhST0Ura2s3S2Z1RWtKV213amlXMXVh?=
 =?utf-8?B?QVV3QVo0Mi92NTlOL1B0VmRjTGQxMGkvVzFDZXQyTWZHSXdOYkU2YmxiZExC?=
 =?utf-8?B?ekVrdDNoamFKVnFCRzJ3QnUwMW5MNjBpZkJDSEUxZW1SNGxQQjBiOGE3U0Zi?=
 =?utf-8?B?bDB5amRiNjF5US90ems1QVdXNFRCNDkyelFPQi9pMmx5ZWlpQURmY1I3bHRa?=
 =?utf-8?B?Y0FiSWRHMjd6NXdYNExlWStMVHp2MmttNVRZelNuQVk1cXp4K2syTkhLQnVv?=
 =?utf-8?B?QlJSMlEyUVphcy9hNEloeGVMZjVkNVo5aGgvNHBlallWZk96aUprc2VKK1RX?=
 =?utf-8?B?a0dmTzNUSnNSTC81VzBVeGM0Nlp5dmxPUXphNlA3WHlyd1EyZVZLbVczL3Br?=
 =?utf-8?B?a0twbTF6c1QyLytyVTM5bWRhRHc3MzlJYzIrVmNRMUplcFk4RkR2M2NRRWtL?=
 =?utf-8?B?TktOWGZibTJTaXZYUDlzZDFiQzdEMTdZL3lJTmt2QWh3VUJlRWVVMWp1dWpk?=
 =?utf-8?B?djRmVlRRb2pZd0lWNnBjemgySUgvTzZ1Z2Q0aGlSbUNVZGJIak0xRCswWTJO?=
 =?utf-8?B?MmhCLzFQelJxcE5lNWFmdnMvQ0RySE10NWtNanExN0ZIVDJ3bVczUlk4SElr?=
 =?utf-8?B?LzBUV3FVVG9YVHZVbzF1aHk2Y1RESks0MUpJdklRZEo3MGIxeUJKTVJiL3lX?=
 =?utf-8?B?QXR1Q0szWHpSWVNURU5uWHkrcDZrbkZQSUVQUnJMS3l5RmhNYmE5enVOclBV?=
 =?utf-8?B?NFlYeGMvQ0hRT0xmbi9hN3Fqc3dkNUJEZ0d6cUR1OTJlRU54ajU4WlQ2TWll?=
 =?utf-8?B?dkpHL3kvMUVIME5jTjFheWhYZVNrRkdFZmJQZ0xvQ1IvblcvTmU5TVZEN255?=
 =?utf-8?B?M1pQczJZenVTUjczMGhjeEZ1aE1WQWFxRUVhNjNWMm8zcFlFR01BWGNJejBn?=
 =?utf-8?B?VTRjNUdBaUFsdXF6VG9NVnRpZllLbnpXUDc4OWd0Y0lMTk85dVFGVlkwaHhs?=
 =?utf-8?B?cXhhbWhkTTRiY09MZys3d2paMmd4N3YydElHRS9oT1p1cjE2Wi9XOVYxUWdT?=
 =?utf-8?B?SGlIbG1HazRHRTBVZDgvWUluUlhxV0hydW44alRQa1NTRkZMVVJaRXp4THFr?=
 =?utf-8?B?UFJ6L012eXUxeG5TM2JVNHNkcTBhNVVqRGNVU1ZkTERTNTcyTmRBZ0lLMmJP?=
 =?utf-8?B?ZXJWVVVpVWo5ZnUwbmFaTi84YytUYnpaVkcwMFNNZHVtY0pzNlA4VnNTeFFh?=
 =?utf-8?B?OWtuVEhwUFVZbE1lOGVnbGw2YTBvSW8xWnJYNVFDQURKaVRYRCtyejlmcllZ?=
 =?utf-8?B?dUZvaUw3WkRJMW9MZkhSZ0lOSGhiRk9BR1NGUjlmdzh0S0t1c095djRQZ094?=
 =?utf-8?B?VitkcmRuQ1dKKysyTTRMTm5GR3JhVWVTQklkMGVaOHprKzhjb3BIVHRrdHhT?=
 =?utf-8?B?d2tMalpVLzZhdW5NcVVRdTBwazV2T1FOeTBQWG90dmQ4bTg5RTNncGgzWG5O?=
 =?utf-8?B?MU1zdk5mL0NLQzcxcWZjaVUzVXg3SkVkR2JTNHlHdSsvUmZIS3pTUG9YNGky?=
 =?utf-8?B?Yk1TYk9EVXp0Q2h6N1cxOXZTT3R3bWp1aU1YRVFvYnlaYTlZRitONTBnaDVO?=
 =?utf-8?B?NXRDWlFmTW1pbWt3YitocXgwMDdCZFpYejluMFRLUElkSkV5ays2TDZESE8r?=
 =?utf-8?Q?CC/EgECTSrBBP9HIMY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313d1670-f86c-46fe-d72b-08df0c92446d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:44:06.3934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4q1I4B9zLjSBmRl8QnMhCTOTwIPkezHFPxzM1yBCfhET9LT1lL3is8c10/cp+/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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



On 05-Sep-26 10:00 AM, Xiang Liu wrote:
> A compute partition switch tears down the KFD device through
> amdgpu_amdkfd_device_fini_sw() without suspending KFD first, while
> kgd2kfd_device_exit() drops a suspend reference. Every switch leaves
> kfd_locked one below zero, so on a hive the counter ends up deeply
> negative.
> 
> kfd_locked gates the eviction sweep on "++kfd_locked == 1". While it is
> negative a GPU reset never evicts user processes, nothing restores them
> afterwards, and page tables torn down with VRAM are never rebuilt, so the
> first queue mapped after the reset takes a VM fault.
> 
> Take the reference in amdgpu_xcp_pre_partition_switch() so it pairs with
> the one kgd2kfd_device_exit() drops, and only drop it for a device that
> finished initialisation, matching the early return in kgd2kfd_suspend().
> 
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 5 ++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index b4ebc157fd06..e2e7d101b3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -698,8 +698,11 @@ int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
>   	 * Stop user queues and threads, and make sure GPU is empty of work.
>   	 */
>   
> -	if (flags & AMDGPU_XCP_OPS_KFD)
> +	/* kgd2kfd_device_exit() drops the suspend reference taken here */
> +	if (flags & AMDGPU_XCP_OPS_KFD) {
> +		amdgpu_amdkfd_suspend(xcp_mgr->adev, true);

Partition switch doesn't force a suspend. It's a prerequisite that user 
has to exit all KFD processes before doing the switch. So before 
partition switch amdgpu_amdkfd_check_and_lock_kfd is called to ensure 
that no processes are running on the device.

If there is an imbalance in lock count, it may need a different way to 
solve it.

Thanks,
Lijo

>   		amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
> +	}
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 729b35841e3b..d76920adc466 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1014,12 +1014,12 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   		kfd_gtt_sa_fini(kfd);
>   		amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
>   		mutex_destroy(&kfd->profiler_lock);
> +
> +		/* pairs with the reference taken in kgd2kfd_suspend() */
> +		kgd2kfd_unlock_kfd(NULL);
>   	}
>   
>   	kfree(kfd);
> -
> -	/* after remove a kfd device unlock kfd driver */
> -	kgd2kfd_unlock_kfd(NULL);
>   }
>   
>   int kgd2kfd_pre_reset(struct kfd_dev *kfd,


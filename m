Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B80CA5FFC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5033A10EBD2;
	Mon,  5 Oct 2026 07:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xs11ts0c";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85ED710EBD2
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 07:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXE/44dPpng5vuep0T4g9AkMzsxuk8l69XK8c0RqI5GwigxF6+d2UJQJ9b9oGYmVKo5tjd+bAdFs0S9V4Oj/I4Akhw1lKPo69nsRjxd5uLf7UYmj1vA6CYhfGqXCVEbjli74z00ncZussvJs5LBO2Z4be/be3XfpToBvYelN3x0z6GGQPp/egBt9VXUIvlyprmyuGuV10p6E3AWWDMmPB4vgrGdh7RZytoVhu9Nj6338VziY01IxqJH/lWJoZcfPLAtqN/CtXyzOxDM/4UacH4lM3TwgvhbRycJtUezeoMCzbrKVjIFWVWDsnJ3oRIboj3fCE47/Ay41Mz25pjzJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXNnvPweGvWkITcaRay1slCjugIhfwShzJMXD8Rc77U=;
 b=WOdgFUaSRrnGpsRrq8CEeAbrwMIlOOXtPJdOWPWYuyPN1xg9SyL33xzP8YDTRd7sOtrvHAlXsoHJRdbUcAgFWfg36zACYS1TdF5xU8qo3npkivdM9FN7eUZ2gJz55TYeizL+J/F67iWNBQWpDeeVkg0lsbmaxxSd6HHZ4lcX/9rN8BvXGgLcySdhC404Tkj3Sjqj9/SqlMor3z4sqpgVUOCCSG7yo0vbTiASgI3mkKXH1FdZM9kplyEuOOFpKVdoqh4WOM5VO5PivVwLzBRTRg4CMeW8NuDcMdOaCumJPLSD/373eptt1qTkR0dFkNKLN9bIH1ldfvwPJMpi06aJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXNnvPweGvWkITcaRay1slCjugIhfwShzJMXD8Rc77U=;
 b=xs11ts0cWHtBtOW6ciMcFiElMeI1PpHj38UekFSKugs6o68R3mQmeE0ze9OGMRhVQN2tLxO/ojPIrjPyTDcksHciVJ4HdlevYcT7nzYWWfuggMjFUlLYBrC7TdkkdQ0btvStqG4JN6syY2M8utPBggmqb+WU8xoy6+rv4Gd2GVc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 07:44:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 07:44:40 +0000
Message-ID: <7de6d58f-6037-45e5-917c-6c62b42e00be@amd.com>
Date: Mon, 5 Oct 2026 09:44:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, felix.kuehling@amd.com, alexander.deucher@amd.com
References: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
 <20261003063817.36606-3-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261003063817.36606-3-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 8942ebe5-ea22-42c1-9709-08df22b48385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: gWSaX82c8QHNEGv1FN8/3z0C7dzerdfN1xiZ49RgvCPEkD3peVzFeU6chIjHevYZAq0oFlPU82MdgxXghrmO4zftyVxn4qsCYfhEn22bQb4+k2aING9c8nHymcbs0JKtfLWvod3IeiRcYKCAAJ1n5PfPyIj+6FHjc4Ay6VjpYKVq0RFJUWYi9MRmwwWCQuTWQJoDno5CoIiBKknVPF+VD0w2ceCZhqnZ5X7THdX7LFQIQSo2Ah3HMGommRs60+wEocekJdpK3Oz9g3Nb/3QXaVpKoSoGb6jQ50uOTLYRbsAKb78h0z/gdw4lEWD67kAvYIyKlZzJ/itxLunqv32eOH8EOevt2wZ+FF3/TFDD/f+d/RGkZ1bRR57jQze89Q3zf0qXYzZQg5JirNMB00PR+mFKTuIrXcp2w5H7UrnRn11nQgZw72tff9kO0CWYOyOaKWbklTOyG41lInJMmmV8HGBNlmn9ppqXABplokx2jOIZqTRE+UKqEtHNAps7VKKPmQWyMkVitNBTnr5IRzkH91H8IP1mcrxnWA6sjdKkYwhr9zPGqtGxQXWQivJGugylZWATb8lFsezmdjIMRWhUMnmdtrwf1FRsVNG6qkRaNyZBA27OFClC7dif8Y1Lu+KWUrKwp4Gax2+3sWBIciLLtj0U4XRXBZ3vF7uTQU/IyQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTd2UTU3djl2amJWWnJ0VkhjWXgrTDNFbEVSY0YvZi8zbUhHNHEwcDlGVEE1?=
 =?utf-8?B?WVRKZDloSXNxcHVhei9WOEMxTVZHNzk5UUlVQkRNNGZjUDFiNjdNZDVrc212?=
 =?utf-8?B?RFR3Znp2TXZGdVExSGczN3RHbmNaczFOK3NYM2NhK3pQczRVTERORk1pclhG?=
 =?utf-8?B?OVhUSjY0dGkyU1BvK0VFTHdjZzZIR1pjd0F3dHl6ZzRNZXFLU2lRNk1MZG5V?=
 =?utf-8?B?NE1TbktuMmlkNnI4VUhiNGhta3pKcERoZXFsaVBZdVFIMk1TR1NHVjJqbEJ5?=
 =?utf-8?B?VlljMGk2ajlrSVNPSG4wMVNnL29TTnBIL2ZsMG5Xa21XWUQvY0VhOWtaR3lx?=
 =?utf-8?B?dm9zdkhDd002WUlTNmxhbTlERUNVNFRua2g2WlYzaFhvUjNyWmV5SkdiVVNX?=
 =?utf-8?B?Ym1DMnQ0RXltWG16TWlUZHdXNWJxNGt0bEVsaExMZHRVRGZhSk0vVEVYT3F5?=
 =?utf-8?B?OVVrTmRQNDN2UkNVQVZXUk5lOWxsNm9tUFBIZ01nendSTDBaczlxaWt5aXF6?=
 =?utf-8?B?TnNRQS9BQ3pwbGVPOHNXajZoUTdQenlIcy9ycVd3eVhJbVduc2N3SWxidFFu?=
 =?utf-8?B?aUcxUXVoTElkR1p4M2xOamxYc2VUMjNETm9KNDZQTTNRNjk4R3dRcDJMYThw?=
 =?utf-8?B?SXk0d05rTFhtdFRHQk9CNHcxWTF5WVlFVmJkMXpNSWUzeFNCbnRTQWJpUjJP?=
 =?utf-8?B?dW9CbktnajQ5ZkloVmJidlFPb1ZWS1ZIaDcva3JpOHVmWldwUjh0cHc3UDMx?=
 =?utf-8?B?Q3JuQUZ1V094bkxuM1pWM1BhNEFQdit1VHBYeWVEdUdpcXRwWm1qTnBvaTR5?=
 =?utf-8?B?REdxVjIreHhGRlRpVmZkNUhqb1JnT3EzMjc1Tm1qYThqblVOUEI4SUFkT2FW?=
 =?utf-8?B?RGJja3BqVklpWUxCdzd1Y0FWTGxOK2J1Nk9TNkhvUGFXamVzeHJoQ0FKQUdI?=
 =?utf-8?B?aXlXU3JLYk9JQ2xPZEJZNHI4N0hWNnVHK2Z5QktZK1FoTVlJYmdac3BrNmNB?=
 =?utf-8?B?L0tPZ2V6dFJiTFhLMFAwTTdwLzY0c1g1cTVlQUhOMm9xY3Jpb1NWTy9RLzI4?=
 =?utf-8?B?SC9wOEhhb2lDT2pzZmoyS2kyZ2Jac1M2UXF1eVU5cm55Y1VSR2F0cTJJQzd3?=
 =?utf-8?B?c01ldjBDNDA0MjRVNnRidFcyM2g3MXhSK2RNWU5zSjZJUWxOT29UTncwbExk?=
 =?utf-8?B?RVVKdkVOZVNIOWNIK2Fjb1dnSjdTaEJBZ0RsbG0rY0FBWjByY2p3T05XM0Fs?=
 =?utf-8?B?ek9SQnZvd3hodmZWYkExZnF4WDBNVVV1WHp3WDYrdFl5WkZGSFVoY1dhY1VH?=
 =?utf-8?B?SjkrbEkzaVBOWW9ENWc4SEd1UzZ5YVMxb0diMUlaT3BJNStkbW90K2lLUnM3?=
 =?utf-8?B?UGt0Z2ljVjY2Smt1dmlZbnh5NFNsNnJpTWN0L3JUeGVLaE1SQldWNW50eGlT?=
 =?utf-8?B?OGdVaXZSRXNhM21maUhnMTVUSkFTZlRQZ3l0Z0ExMFFvQlFvU0s0RFQ3RXlh?=
 =?utf-8?B?WkVzbUdWanpLaFdzd2NjSGdKSWNBeEhlQnRtN0VrN0pseFNmajJheU1wdDEw?=
 =?utf-8?B?bUlkczZqVWRrNEplS2VNVjNQYmV3ZFRxY2VIZEdpT3c5SHJUTjgzb21yeUc1?=
 =?utf-8?B?TytyZ2hzZnZsTkJkeE5Sd0loc2xMMzREdUFWajBhclBOYmNuTU1tMUVzRkpt?=
 =?utf-8?B?bzY5VFJBa3pWL29FdE1MbndvVEtnWU9zM1lrVElta0VWaGRJaTczVDJrMEF1?=
 =?utf-8?B?WHFsTUVrYWo1UFRiNWNMb3Rzakt6L3IrZkNjMDJvYzgwekJWS1c3aFlmK0I4?=
 =?utf-8?B?WlRsclExaFIvL0VnUzI1ZUh3ZldTM3lhdHJzbjZ3THV0enI0elQrZk40VjRK?=
 =?utf-8?B?bnc3aHRQNmhuTmljQUJnZWdiZkFxZFBUbGNGcUdGZk1HM0owblVOaGoxYWNC?=
 =?utf-8?B?bVhvMnhxdElPZ3dKOVhMSVZuYi9qNGVBMlJ4dEZ4dWttVHlMMjF1ekFCOW0w?=
 =?utf-8?B?SlJtRk5FcDVwZk84a1Jxc1MxU0ZVeHVCY0tvREJoOGt3aUY4UTFacUV2cmZq?=
 =?utf-8?B?SlpERFd5a3VXbmNHZEg2bHNrWi9oRjNodTd2VjlFWUVLVHBpc0tHck9RNWpC?=
 =?utf-8?B?YVJ6ZDBQMmMzWXVUQlAxM2tqYUJjbnJkcTd3OXNuVDJvUWVUOFlScEJhb21K?=
 =?utf-8?B?ellzdnROSkkrejdmUDNzRWh0cDcwQXJCSVFoK1JQRVpYTVJQSWlMVURlUllk?=
 =?utf-8?B?clNUd2ZBM1c5ZGc2L0V1bXhKeXJuVU0zNUkvMXdTU2pUQlJWdDcvOGszdEpE?=
 =?utf-8?B?enQvWGtPeWxUY05EZW0ycmdZcklVQjVJUlR0WkQzb0JvNG8vaXdGUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8942ebe5-ea22-42c1-9709-08df22b48385
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:44:40.7646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9IzkAygHvNzN6pCsOlQneL60DmKuPA2FEwhMp2RNl1ujTCeJzlFQyj6Of0u0IG/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

On 10/3/26 08:38, Olivier Kaloudoff wrote:
> amdgpu_amdkfd_restore_userptr_worker() reschedules itself every
> AMDGPU_USERPTR_RESTORE_DELAY_MS whenever validation of invalidated
> userptr BOs fails. On PCIe surprise removal the VM update paths
> already fail fast: amdgpu_vm_update_pdes() and amdgpu_vm_update_range()
> return -ENODEV when drm_dev_enter() fails, which propagates up through
> process_update_pds()/update_gpuvm_pte()/validate_invalid_user_pages().
> The worker ignores the error code and reschedules unconditionally,
> producing an endless retry loop on a device that is permanently gone.
> 
> Observed on MI50 eGPU TB3 surprise removal: ~11k rescheduled restore
> cycles, the worker holding reclaim-related locks until the system
> soft-locked up.
> 
> Stop rescheduling when the validation failure is -ENODEV: the device
> is gone for good and the affected processes are being torn down
> anyway. Other errors keep the existing retry behavior, as they may be
> transient.
> 
> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d668816..6c040ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2827,6 +2827,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>  	struct task_struct *usertask;
>  	struct mm_struct *mm;
>  	uint32_t evicted_bos;
> +	int ret = 0;

Please don't initialize return values when it isn't necessary.

Initialize it before the goto.

>  
>  	mutex_lock(&process_info->notifier_lock);
>  	evicted_bos = process_info->evicted_bos;
> @@ -2846,14 +2847,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>  
>  	mutex_lock(&process_info->lock);
>  
> -	if (update_invalid_user_pages(process_info, mm))
> +	ret = update_invalid_user_pages(process_info, mm);
> +	if (ret)
>  		goto unlock_out;
>  	/* userptr_inval_list can be empty if all evicted userptr BOs
>  	 * have been freed. In that case there is nothing to validate
>  	 * and we can just restart the queues.
>  	 */
>  	if (!list_empty(&process_info->userptr_inval_list)) {
> -		if (validate_invalid_user_pages(process_info))
> +		ret = validate_invalid_user_pages(process_info);
> +		if (ret)
>  			goto unlock_out;
>  	}
>  	/* Final check for concurrent evicton and atomic update. If
> @@ -2886,11 +2889,18 @@ unlock_out:
>  
>  	/* If validation failed, reschedule another attempt */
>  	if (evicted_bos) {
> -		queue_delayed_work(system_freezable_wq,
> -			&process_info->restore_userptr_work,
> -			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +		if (ret == -ENODEV) {
> +			/* Device is gone for good, stop retrying */
> +			pr_warn_once("%s: device unplugged, aborting userptr restore (pid %d, %s)\n",
> +				     __func__, pid_nr(process_info->pid),
> +				     usertask->comm);

That warning is most likely unnecessary and maybe even harmful.

That the device is hot removed should just be a perfectly normal abortion condition for the worker.

Regards,
Christian.

> +		} else {
> +			queue_delayed_work(system_freezable_wq,
> +				&process_info->restore_userptr_work,
> +				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>  
> -		kfd_smi_event_queue_restore_rescheduled(mm);
> +			kfd_smi_event_queue_restore_rescheduled(mm);
> +		}
>  	}
>  	mmput(mm);
>  	put_task_struct(usertask);


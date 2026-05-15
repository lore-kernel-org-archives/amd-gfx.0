Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D14CD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 05:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB6710F3CF;
	Fri, 15 May 2026 05:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qcA/CrCl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3B110F3CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 05:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZWScvGFp9vgrHTimabpVxplumP6kowj+/5MdU3lH6nzi0P0vIu+gCx3mC7IdOteKXZGNt8PieKdLdSH6ob8qsoe2O0/KkEJYcHH9GsG/vZAWwJKkwnIwJNXCQ3Q54Phzyc6ZxSPlydjQyhuHuGYx0iOEGMRXSGU6dkBSS5eRRA7+2r6WPf5kwz4sKvVDjNxBDzNUeYvo6ayAZ/tNKZvWIqqQGD+1Ynh39ePQ124E77dJoQ0gwPt77gP1AKKA/Re/4OMijAYgrHVz9IWEtn7GCVzld/esNsetEM7gmUOqzW87IR1irK52tcu5Z5MjVcSexvJgXy1pVb/cPJy5XgiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r39BC2H4sgSf7Xy0U5eT3JysQ4TJCd1WBNwU2QHCUkA=;
 b=riY+1NBrkKV1dC0X5KZBth/WG5mUoYRJetkK4FCg5/3FmqriFsCKOo2XZ27aqmNqzBgoIqEBCURnLkC2eDHpj3C4y3NxrejeUBeUpu8C1cG0jBXV3zfaR5vE+bovMSX69TY4u5jGIQVKYJ+b7UihosuoIzr6fYrV8uGUjrFmO/vfq2ubGJ7f/5nK7zbxB5l7gaJMxVMGWk0RFZHCJUEYFyeSzZE5FDV11AreW6JfbACU2rLFuEVsXiZIAVmAH9pPr5BODZMyenUFc+0mYdV5SQXBWfWY8W9AwjaDWR/TkbgGi2FnuMtWRbtm/oOHwuYWPSbG2Qo9Yba+qkd43H761Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r39BC2H4sgSf7Xy0U5eT3JysQ4TJCd1WBNwU2QHCUkA=;
 b=qcA/CrClzG4hnPc4RV14hF/2h/ldcK+xxlVBjXF8f3J4DdpKWnE93gIvaQJlEKkw6pjh2KvfpTBMndZMYZhUe0w62hotg5rUMkOW/E3lTnu3JjgsiYjkjJIbQDOii4JRCFhLmuGp2uAFE5qIKhLJRsd31GsF/LdO2SbfdCaOg+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 05:08:20 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 05:08:19 +0000
Content-Type: multipart/alternative;
 boundary="------------zCDHJ6Oe0hzJzBbPTqVg0Gmw"
Message-ID: <36b3d9e6-1600-400e-a509-ea6727569254@amd.com>
Date: Fri, 15 May 2026 10:38:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: clean up userq iVA mapping after removing
 userq from MES
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260514124250.3833711-1-Prike.Liang@amd.com>
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7592c5-7c39-4c20-b642-08deb23ffab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|8096899003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: NSMenYqq3oNjR5q5UCYjs89Pi/aK2tqX5NciuzsufaSdxPZ6yFnwkIJ7v/hBQ3+Sg9PARdqovunh+6kSUPQtmqxub4YGzOB5kh/qr+sHcTj0BCi5ELGP7MGXaYEpc8jdE28CKqH5TsMFzU/LcmUbkmj8uGS4KdkGbb+kvNmLPknIwRGY3CJuNmSoYkAXKAxcQDF5HHyQAiiujv+rw+hqXQkF6yMjb3PVzUe5m6d6Se91ZJphAUL/DsIemm1mD7/CZq2X4Bw76xuznPTlxyEvb2UCoXF1MZ49xL9T61z8kmcxnv4QbC1Phuh3mvDpsuLm4KzTvPuvMAkkjeDeHlCVs1bSvKjpU5fL+/+baV7Fa4818gggeBqrgzt8yjISwejUyyeTy3mfhMuiN7Wu0hLkg8PZvDk+cFhoa8vXYS93GVeAyM+m+8iObtn8a73VXDTn0MmYhbJ/r4A0wrB2SjAmmB4yS7LWUBI8QUkxuWM22s3rfO6VfEXoIWfvxpN8WiZhjzTanaUjeVwsHOFT/vP2ljaqIcIAF4YIhLUEwyBWareACIxi9rjgpyYvUo5TP/oEHqmL3WDGoy9sJt+YcUz6XRavpH5Xkh4z7BlAaxKD/kQmbC2MeX6jbiuQQMREcmYudNguaDGPFbFBLvoA+X+d8wNAfz066VEmbhhN7lrXfW9HifbMbvruFbUpi0ozlfuF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(8096899003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnkxUS9FSUpCMkIvZ2pKcmMxYjlkOXl4YnBHdWdRaXhiQmwvNXZ3TzVaS0tN?=
 =?utf-8?B?eUJlTy83ZWtSY2VjMHJ0RStsWXp3ck82d3l2NGN1bHNtamIrZGFiUXo1bFNu?=
 =?utf-8?B?VmcxMTNBT0ZaTy91SVpTS1B3TmVHVE05cExPbW5JWUZRUk1jR3lmSFB2ZzZr?=
 =?utf-8?B?Ui9yalZ0Qjl3T2ljSUFlZ3JxYzlDNlYwQkRoNEF2UU5CZmx5RjdjdFR6T3pO?=
 =?utf-8?B?aFdTTkJYbm8xN2s5czV1d1RQaTFlNFNTZWUwZVFWc09jQ0xpVmlLL0p2Vnlm?=
 =?utf-8?B?ZGkrazZpVTBJMTMzdHNoYUxhaXh5RXJvYmxtUkMxdExKVkczblJOYWVmMEhz?=
 =?utf-8?B?UGtpKzZoZEMzU3NlWGtMbzFuVW1UNGd5U25yRzJFQ293RklTdjBNam1uMHhi?=
 =?utf-8?B?WS82bXhjVjhCbS80WTkxbTkyb3lYN1doSEkrcng5VGVRd01oZGlHV0JHMS9U?=
 =?utf-8?B?NG1hTTc4Y3F4S1VWeVZYb3lXUm4rLzlwdjhhSTZKVnpjc1kwd0w5eDNSTE1q?=
 =?utf-8?B?NVRha1htUzg2c3hNdmVzMWxOUmJURnRnRFIxOUxHTUYveFp3eTgwLzNrdGZn?=
 =?utf-8?B?L0hTWXI0a2gvOXMyNGIwSEFFTFdxd1dwc1dCeFJtb1VNd0pRZ2c1a25RN2tR?=
 =?utf-8?B?ZlFUbFJmWFlPcjFSOEFCMzdKd0ZFMUk1aGFHQTRtQjQ5V202c0NhaGF3SGxQ?=
 =?utf-8?B?N0wyb0EyNGdudHhTT1YzMndVbTFNbXI0aWF3bk9zaDR0a2lhN0hmZE1LeHFP?=
 =?utf-8?B?alk3U3BFK2IyMUxoRmxVYlFrQ2FzRFBlM3hwOEhnWjBWK1diTTdQTURIeWNq?=
 =?utf-8?B?V1R6Wm1KNlZjUk9vNFY1Tjk4OVplUkdKQzlmay9zMHM4eFdIbmdiWTlackJO?=
 =?utf-8?B?RlZOdW5VK3lkK2IyRUlQdjZnMlcyTkcyUEdvWHMwalhTWHhVdUJ3WWJmWmo5?=
 =?utf-8?B?VnJwcHdORGtwTUZlRzg2akQzRDYwUjVMZzQ5SGpiM3U1ZUY1SkZhTG80VkdV?=
 =?utf-8?B?VHMyaStpYTZGbFhLSkxTWjErbVRINjVMTnFkQ2wxWGhEU0pXc0I1SzVweFl2?=
 =?utf-8?B?emFVeWE0UklpSy85VENGKzlBeVBER1RVNDJzd0hLNGhGcTMwTGxkNDlPYnpI?=
 =?utf-8?B?NmlZSGNkdjlnL3YveDA2UGRIMGxHVlc3amNUWEpwbldneGZFSVVINHlhZ1RW?=
 =?utf-8?B?NlNvbWVQa2s5RmpLNXp2OHNyYjRSSFU2QlZYN1VyUUE0aXFBVG1scjZ3L0ZD?=
 =?utf-8?B?ODdJUUZqdmdtNkFEV2VzTEo5NHY3eEljN0V5SE56SDhNNzdJUm9SMTVGYy9T?=
 =?utf-8?B?YUxjSk44aG9Rd3kwZlJJdmtrRlVoNERONlY5MmxtOVY5QlVNT3FrdExoR3dK?=
 =?utf-8?B?N2hmZ1VWUnp2czE0bUkzcmJpcEpIdHU2VGdtZmo2ZDFTT09uTzJEc0xUa3hz?=
 =?utf-8?B?SUo0NWZzd08rRlJpcHVod3RHK0lDNmtrNWtSSGc2dWNqYnFHemd0R0xBOHZP?=
 =?utf-8?B?emdibjl0RXpEeDIyVE9KV05FTlhKaENsajBqc3Y4RzgzVGhmeFVWUmUvT2Fo?=
 =?utf-8?B?ZVA5QTdZV0tObEE2a2lFQURGWVhqaVNGT3VhUjNrc1YxSWRiazcwZ0tXS2Vy?=
 =?utf-8?B?cHV5VzZENFhnUTIvcU41cGc4eHpodTNRelYvMmpPYnpYVHhoMHVrZHRIU0Jy?=
 =?utf-8?B?NC8yVkdLaWlOVVM2ZDFjckh6a2tHWXlXS0JNQUVKZ0dTdDNjd2hDeUZUUXFW?=
 =?utf-8?B?N1g1YW5FTDVoTWhYNmZNaFdwWFJJRHkwcVZzcjl3ME8rSkhiTGlaV01qbjJF?=
 =?utf-8?B?anU1b1ZNUTJUekJIbXZZL0tsaVB0UEVkTDR3STVrcmg2RDI3S0hVK2pjWWE5?=
 =?utf-8?B?STR4Vm5oREZBUHFSczY2SGFnUloyS1RuNnFLb3BmaEhFT1dhYXdjSTVHekxU?=
 =?utf-8?B?ZE1aR2VXNkpJMzFCNzJ3ZFp6WUpxYnE2SUJJRDF1YkRPZ1E5UGxoRWtvMHRS?=
 =?utf-8?B?anV1U053MHFXdHYydkZWV1VtRm1UMCtPWStzMnl0bXFXRkI3MGlvRXhtRlVx?=
 =?utf-8?B?eUxUSjU4ZUxUZUpROFhqRUVhYk5obllLbksrS0pmMkpsaEFXRXhiMDNjczU0?=
 =?utf-8?B?eXBkUjIzK2dhNnlRcktwZFFGZ01uTDdEQms5ZysxU3pLa2ZISVh2aERwbHA2?=
 =?utf-8?B?dHNjbFRDWHYycmlmTSs3ZW5NNEN5N21nY1pKYTBhMmdpakRBZElzZUNqekV3?=
 =?utf-8?B?Vk9iSnRXaEFEc1VUdXlYZE9xMkJxamdDRlJOd1N4ZFkzTWdqUlB2d3J2OTYx?=
 =?utf-8?B?clhsc2s1cjhhODUrbTlmdlpON011c3IrRFpEeGg5NGdyTFVrVXJBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7592c5-7c39-4c20-b642-08deb23ffab4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:08:19.5653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKhLstnLojsY6oWI+9tug+VYsYZOJs1E7JNSQ5xAVJCNf7SRPtOBJaT27V7fLFYby57/NjuVUj1yoKLlFRLnLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929
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

--------------zCDHJ6Oe0hzJzBbPTqVg0Gmw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14-05-2026 06:12 pm, Prike Liang wrote:
> User queue destroy removed the tracked queue VA mappings before removing
> the HW queue from MES. If the queue still had active waves, HW like as TCP
> could continue accessing queue backing memory after the VM mappings were
> removed, resulting in gfxhub page faults.
>
> So, that needs to move queue VA cleanup after HW queue unmap. Meanwhile,
> if MES fails to remove the queue, then need to run reset recovery before
> freeing queue resources.
>
> Signed-off-by: Prike Liang<Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 43 +++++++++++++++++------
>   1 file changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 83aee0810513..2e3edb6dd506 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -625,8 +625,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>   	struct amdgpu_vm *vm = &fpriv->vm;
> -
> -	int r = 0;
> +	int r = 0, tmp;
>   
>   	trace_amdgpu_userq_destroy_start(queue);
>   
> @@ -635,15 +634,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	/* Cancel any pending hang detection work and cleanup */
>   	cancel_delayed_work_sync(&queue->hang_detect_work);
>   
> -	r = amdgpu_bo_reserve(vm->root.bo, false);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
> -		trace_amdgpu_userq_destroy_end(queue, r);
> -		return r;
> -	}
> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> -	amdgpu_bo_unreserve(vm->root.bo);
> -
>   	mutex_lock(&uq_mgr->userq_mutex);
>   	amdgpu_userq_wait_for_last_fence(queue);
>   
> @@ -651,6 +641,37 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	debugfs_remove_recursive(queue->debugfs_queue);
>   #endif
>   	r = amdgpu_userq_unmap_helper(queue);
> +
> +	if (r) {
> +		drm_file_err(uq_mgr->file,
> +			     "Failed to unmap userqueue during destroy, ret=%d\n",
> +			     r);
> +		amdgpu_userq_fence_driver_force_completion(queue);
We should be calling this before amdgpu_userq_unmap_helper because we 
are in tear down and we want to finish all the work and their 
corresponding fences and if unmap fails or not we should be cleaning up 
the resources.
> +		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
> +					     &uq_mgr->reset_work);

reset at this stage during tear down seems like a bad idea, we are 
infact waiting for if any reset thread if already scheduled.

regards
Sunil khatri

> +		flush_work(&uq_mgr->reset_work);
> +	}
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	/*
> +	 * Drop the queue VA mappings only after the HW queue is removed (or
> +	 * reset recovery has run). Removing the mappings first lets active TCP
> +	 * waves fault on queue backing memory while MES is still trying to
> +	 * process REMOVE_QUEUE.
> +	 */
> +	tmp = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (tmp) {
> +		drm_file_err(uq_mgr->file,
> +			     "Failed to reserve root bo during userqueue destroy\n");
> +		if (!r)
> +			r = tmp;
> +	} else {
> +		tmp = amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +		amdgpu_bo_unreserve(vm->root.bo);
> +		if (tmp && !r)
> +			r = tmp;
> +	}
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
>   	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>   	amdgpu_userq_cleanup(queue);
>   	mutex_unlock(&uq_mgr->userq_mutex);
--------------zCDHJ6Oe0hzJzBbPTqVg0Gmw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 14-05-2026 06:12 pm, Prike Liang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260514124250.3833711-1-Prike.Liang@amd.com">
      <pre wrap="" class="moz-quote-pre">User queue destroy removed the tracked queue VA mappings before removing
the HW queue from MES. If the queue still had active waves, HW like as TCP
could continue accessing queue backing memory after the VM mappings were
removed, resulting in gfxhub page faults.

So, that needs to move queue VA cleanup after HW queue unmap. Meanwhile,
if MES fails to remove the queue, then need to run reset recovery before
freeing queue resources.

Signed-off-by: Prike Liang <a class="moz-txt-link-rfc2396E" href="mailto:Prike.Liang@amd.com">&lt;Prike.Liang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 43 +++++++++++++++++------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 83aee0810513..2e3edb6dd506 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -625,8 +625,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
-
-	int r = 0;
+	int r = 0, tmp;
 
 	trace_amdgpu_userq_destroy_start(queue);
 
@@ -635,15 +634,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	/* Cancel any pending hang detection work and cleanup */
 	cancel_delayed_work_sync(&amp;queue-&gt;hang_detect_work);
 
-	r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
-	if (r) {
-		drm_file_err(uq_mgr-&gt;file, &quot;Failed to reserve root bo during userqueue destroy\n&quot;);
-		trace_amdgpu_userq_destroy_end(queue, r);
-		return r;
-	}
-	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
-	amdgpu_bo_unreserve(vm-&gt;root.bo);
-
 	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
 	amdgpu_userq_wait_for_last_fence(queue);
 
@@ -651,6 +641,37 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	debugfs_remove_recursive(queue-&gt;debugfs_queue);
 #endif
 	r = amdgpu_userq_unmap_helper(queue);
+
+	if (r) {
+		drm_file_err(uq_mgr-&gt;file,
+			     &quot;Failed to unmap userqueue during destroy, ret=%d\n&quot;,
+			     r);
+		amdgpu_userq_fence_driver_force_completion(queue);</pre>
    </blockquote>
    We should be calling this before&nbsp;&nbsp;<span style="white-space: pre-wrap">amdgpu_userq_unmap_helper because we are in tear down and we want to finish all the work and their corresponding fences and if unmap fails or not we should be cleaning up the resources. </span>
    <blockquote type="cite" cite="mid:20260514124250.3833711-1-Prike.Liang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		amdgpu_reset_domain_schedule(uq_mgr-&gt;adev-&gt;reset_domain,
+					     &amp;uq_mgr-&gt;reset_work);</pre>
    </blockquote>
    <p>reset at this stage during tear down seems like a bad idea, we
      are infact waiting for if any reset thread if already scheduled.</p>
    <p>regards<br>
      Sunil khatri</p>
    <blockquote type="cite" cite="mid:20260514124250.3833711-1-Prike.Liang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		flush_work(&amp;uq_mgr-&gt;reset_work);
+	}
+	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
+	/*
+	 * Drop the queue VA mappings only after the HW queue is removed (or
+	 * reset recovery has run). Removing the mappings first lets active TCP
+	 * waves fault on queue backing memory while MES is still trying to
+	 * process REMOVE_QUEUE.
+	 */
+	tmp = amdgpu_bo_reserve(vm-&gt;root.bo, false);
+	if (tmp) {
+		drm_file_err(uq_mgr-&gt;file,
+			     &quot;Failed to reserve root bo during userqueue destroy\n&quot;);
+		if (!r)
+			r = tmp;
+	} else {
+		tmp = amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
+		amdgpu_bo_unreserve(vm-&gt;root.bo);
+		if (tmp &amp;&amp; !r)
+			r = tmp;
+	}
+
+	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
 	atomic_dec(&amp;uq_mgr-&gt;userq_count[queue-&gt;queue_type]);
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
</pre>
    </blockquote>
  </body>
</html>

--------------zCDHJ6Oe0hzJzBbPTqVg0Gmw--

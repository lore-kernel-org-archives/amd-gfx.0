Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A427AF01821
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 11:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396D510ECE8;
	Fri,  6 Mar 2026 11:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e/WgdNTz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960E010ECE8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 11:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk/FxrclVGodvb8Z+evq9z8iw7LOhdbHVY0nf7t/FA4IhmiDnbpFpsgYOaZ1v57LGkJiHkNxKd5eRLJFifph/lpfGR1QfOaVxI99Q08LEwOMk8szWzSpocY4VRZKy1OEKzntOG1JR6+qJaASUSi2tYzMkGW2Jd6inoOn6bJinJAkGTQaOJJ3L5q8dK4nu2w+tf0zwduzjd58ywnIXBmf0YygiBOtFDxsOAfaBr0QGzZCQHzciaGhenD1jvV5SO373JWVyq4X8LOg7imty4xtOv0nMW24an+UXQcIltyiv+kGRTQ5NiD6dPssFr9R6VbcDhz2wiS/HQs1amYTNXTpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuKOPuflXUz0kjYkwfuU3M10xWH5D2fY8SmmpaIbRLA=;
 b=Nd4/7NcJ+v6PBSsBGQ/TSyIcWq/J7KKElddCsz0ew0GmdFXq3M0NXYI696UPnnau4oezl9MPV7YkWhto2vDa+fM8ZodPlatOX1Drzg6WPwzcu2RJQDz6kSDhBa6Zckz9M9z6KpAL/hzRYXq8XAxq129tSLIRjIZob4gU5XCLumw2IZnvCPE5VieQWxEyr2BcNuRUSbqWOOBuNsQ04NlQrLqDdrhiH82Y0AkvLj0FAnvYp6a3hK6L2Ll55x0DbSQcx1SNoUF3ppLpi2oOTRvZfhrQbAh4vRH8+iP3sl9IkZd17fvbS4KtSf6S9njGM6HWpCPXTQA7Pv7+Tx1tCJKDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuKOPuflXUz0kjYkwfuU3M10xWH5D2fY8SmmpaIbRLA=;
 b=e/WgdNTzuDz9AToPfWvW4AVAqS3hmJgK9l2LhjqK+OQvuFXiv8j4nIO+MQx3FCRWifcuWQlUw4WIRloHshTuIZZVSnk2joah1DQz89h4LreUS/+iA1/FTAD+ZMW5jYED2p6dmgevuOJdFefXCGskHBIgdzEgx3NGCDLo2y+AuLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 11:07:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 11:07:22 +0000
Message-ID: <dcd6c950-3d04-42c3-a6f1-8d10a66dc635@amd.com>
Date: Fri, 6 Mar 2026 12:07:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu/userq: declutter the code with goto
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306101453.1940129-1-sunil.khatri@amd.com>
 <20260306101453.1940129-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306101453.1940129-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0346.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c50edf8-d668-4713-d9b4-08de7b708a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: rchV+rqEE+BjUiXqX7bHtAqgTef7k42nzuyD8XR7OfEIhMU/mDchzp/tZOkM781o1X/4XCxhufiUyRseNbo9w3Nk3wK0DTWIJRLF7cSyj89lisff7fGKk1+zaiOoWuARJEsKyYJqs8pqYEWmdMx7xlpVy19XJbCsb8s3aZ+4jOhFi8+aFtxRV5P25+vLCh8mQatNfSpcTgcS04xrP+7i+dYuhws9V1OEN8v5xLxnm65xgIdF7IVhJeu/iXQlrP1G+T21QHxVfgapePrusDzmd3qZiTEJNnPtqc4PARMK7nCkHifwyphuuo+tLoYEcWX//dr3eO6/uJjl8WwWcVcOpR2S0SxyU9/nl3/0RVxNiObL1y5Pb0cqkyODer4b42n0SGq3XsPHYQox6xbnwdej16c9M8yzKAiwMm9+Ld/G93+mx2kApGnyvaqqDCQNYyvSj+2yXI/+DkJurluQ98hUUt9ErfBi6xHvcP3nxCQ15HFiX5QDSpX78JQj/CijhCRQXASrpvtWa3H9YD46UKyPqDFYxMPW1THT7CG93odlMMIzZQq9PnIY8sZvGB8BwaI0q62YA9evYusv/d3XAeEYeUcVnCuFkxQ9MXMxxTuIwgehiiSURU08Y/z+N/wvn3m8VzyegkODY/tN4gfOReKgghqQQX6XxLuyG0qePu+vHjglXA4SwFYnNRGMyotp79d3+ie2Z3kLeaYr2naq+r6F4gETQPm+Kbq+NJpIfBcx7fM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJwVHd6QS80Rzdmd3M1TW9rZHoydFhNeTZxNnZSR3pCVy8vRTExNFFTdFdQ?=
 =?utf-8?B?aG1idVdETjBGVkRoWFZRT3ZLY05FS2VmaDVZa2NCekdNcU00K3AxbERXQm9x?=
 =?utf-8?B?aUc0Q0VRamNITXdxcWkwUW5XbDhpbXhUS2lYaUpvWHhFNDd2TnlyOHBvbDZz?=
 =?utf-8?B?M2FOdnRUdHkzMndHdDk5ZnZJcEx6akpVWnloVTd4dFZBaTdKd2RYcG1kdkZE?=
 =?utf-8?B?Sm1admhWR2dMc3VjZU56aEJrSnZ6ZVc0K0I2T2s1d1ZMN1JhUTBPc0w4ckx6?=
 =?utf-8?B?OFJta0NIMkNGVkFlbWRkWng1MGFNSjV2ZGVBMUtSd1JFMStRV0lxbTU0RStw?=
 =?utf-8?B?REYwaXhaeTV5dEk1bFgweExsWEJHbHhTaktBMzNUa3ZmK29EcjlLczFVU0Y2?=
 =?utf-8?B?OUhvcVF4aEYxYUh6M0dQMTZTNVE1Wml3VHp3VElpZWhEK005YyswQXcrWEEz?=
 =?utf-8?B?ck5OMmUwTGxFUmVKVzVyQ3k0c3ozdjltVzVkaGJKYUw3WE4yTjBKNlFQQ2w2?=
 =?utf-8?B?TThGTEl4cktwUUdqNDFkZjd2WEE0Q2VvNE1CS3JtMDlXcTk2bzVWT1VrL0Iw?=
 =?utf-8?B?dzJxYnYwYUk2S3F1aWJhY2QxTU52alFDN0srM2g4YzA3RHlGdWxpNlhpQ3dX?=
 =?utf-8?B?Ykl1OTBsWnZ1YmQ2Q0s0WWd3TkZ3YXZuMEVCblRqNnNIdkNpMVR3SEZheUJ4?=
 =?utf-8?B?Rmk4TEZRbDBjTXZyVUdEL0NObzF0ME9Vc3Z1TzdhdXpJUlNMaGFGR2NhZy9B?=
 =?utf-8?B?WGJ5RHAxTTBHUiswa09pemdpdmVrUkdvZXdKSGU0OHhrZ0NtYitaQ3pxVnhF?=
 =?utf-8?B?SHBxVVlBT2dDa0Y1dVE3L3Y3Q1VSbGNIeXc4dVBXdi9KM2Z3NXdqM0Zacnp0?=
 =?utf-8?B?cmhKc1VTaW1rRkFaOTlFajBteWtuNENsMmFTRHcwVGtELzl1dWdISHR4RG5X?=
 =?utf-8?B?RWxzY3o2Z05EemdQaG0wUGsvM1JtUUN5WnpKOUVLYTVvclpDMXZpd0gvR0FL?=
 =?utf-8?B?RE5XTnNibEsrMUN4dXNNVzQwSEtuMEc1aHdNQmZYVTJ1dlRqUXM1Y0tWQU9U?=
 =?utf-8?B?Z1ZjcGJjenNXeGovOERJNkduMFRhc3pFSWhYek5IQ1ZLY2lMUUZ1S0U4aGVQ?=
 =?utf-8?B?SFAvemh0UDJQb0pMQVRFY3B0ZU9rRXUwaHpJdStjUWNQNFcveVY2ZWZ0ZXZv?=
 =?utf-8?B?a0dBV1IzMjF6NjZ6RUhUbDdkYkd1Yzl6dDJIS1ZCaTAzRmFNekpuTVhjYm0z?=
 =?utf-8?B?WUppS0FpU1VtdjJpVkI4YndFMTFDbUkwU1lreUFvZ1ZLTFpZWHhiM1l2VEh1?=
 =?utf-8?B?QmlVVCt4Y2RjZkRvOU5kSjNpWmx6TFl3aUR6RllDWFNQVWFJSUpiMFM2Skgw?=
 =?utf-8?B?Qmd6aFhNa2xLZG1QODJvWlNUd1RoRWg0M3huU1JoVzI5QzIyNnlLTHN1M1ha?=
 =?utf-8?B?Uk9XWjBBOGs5R0J4WkpWc2w4eEtoUHFmck16N2RvZTJZZys4MlRHTEs2YjZZ?=
 =?utf-8?B?S3A5eTBIbWo1VjdSdlBlY1QzV3JKZmhtK2tyQXRjd0RmWjVpeXQ3dTBlbGk2?=
 =?utf-8?B?bVQ3UTRoZWZxb2JRL1VpdzhnR0FuTHgvQWtoQ1AxaEJCcmo5SUFud3kxcStW?=
 =?utf-8?B?aWVOakM0MEdIbVlUNmY2UlEyWWxxQXl6VFloOE1kZ1FUeDFlV0pic1lFUDFP?=
 =?utf-8?B?ZmRHYWR2Sis2QXQyWFFGUFBZYlRnWnk3NnVmQlpyVTBjM2phdHV5UTJBc3dy?=
 =?utf-8?B?ZE8ydHRaVFRWMFRVaG9tRE5EVFhKV3N2QTZiVW9jZTBpejB3N2NJN3FXeUlX?=
 =?utf-8?B?emxhR0pweXdXMWorK0gveWlvbkVnVWllUVNMWU9hbHMxYmlERmZNL1AyRjJI?=
 =?utf-8?B?YlFqVU1BQ2hZNlVQdVYxdCtiR1N6NkFhb0trSGVjUnRNeno2V2Y3eGFnaVRv?=
 =?utf-8?B?bTZGNThkSko3ZkZ6WWVMYzFqcWQ0ZkVtQWNMalhCR2RBSllwNDNxSE5KdGl5?=
 =?utf-8?B?cFBYemJiN2FqSzRBMS84WU1nNE82UlZHM2hKbWRGR1FwRzk5SW9JcDVPRTha?=
 =?utf-8?B?ZUNSSTdHUFZkRkJVR0hBeFlnUitPNHdTN3JlakhVL0tvajBFUjdrY1MvTW1r?=
 =?utf-8?B?eHFHcTFyd1F0VUI3azNyL3FsOGJKcldkMjMydHkwb0RyMTFROHlMU3ZVVFdN?=
 =?utf-8?B?MTJlWFJtQi9HRHJQeXJVc1Nld0VUdWV2eWY5dWhLQ3lSVHhkQk80c1BMVUFi?=
 =?utf-8?B?RXE4UCtlYkk5UEN3UEc3WVNudHlqYzQ1bVhZckdYZms1N2JJRXNtZ0tBaWxv?=
 =?utf-8?Q?NA2AehfPdcUlurNK+o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c50edf8-d668-4713-d9b4-08de7b708a79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:07:22.3911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHV9d7iqyjK+WBCSZsvKpP4UZGvO8Pq8gmBBHOD0t1BPLli09FDlBDzt9iRsB0L3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

On 3/6/26 11:14, Sunil Khatri wrote:
> Clean up the amdgpu_userq_create function clean up in
> failure condition using goto method. This avoid replication
> of cleanup for every failure conditon.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 45 ++++++++++-------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a614b01b7eab..aef9b5855812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -758,7 +758,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	const struct amdgpu_userq_funcs *uq_funcs;
>  	struct amdgpu_usermode_queue *queue;
>  	struct amdgpu_db_info db_info;
> -	bool skip_map_queue;
> +	bool skip_map_queue = false, sem_held = false;

Please don't put lock status into a local variable, that is usually a really bad idea.

>  	u32 qid;
>  	uint64_t index;
>  	int r = 0;
> @@ -818,17 +818,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>  		r = -EINVAL;
> -		kfree(queue);
> -		goto unlock;
> +		goto free_queue;
>  	}
>  
>  	/* Convert relative doorbell offset into absolute doorbell index */
>  	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>  	if (index == (uint64_t)-EINVAL) {
>  		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
> -		kfree(queue);
>  		r = -EINVAL;
> -		goto unlock;
> +		goto free_queue;
>  	}
>  
>  	queue->doorbell_index = index;
> @@ -836,15 +834,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
> -		goto unlock;
> +		goto free_queue;
>  	}
>  
>  	r = uq_funcs->mqd_create(queue, &args->in);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> -		amdgpu_userq_fence_driver_free(queue);
> -		kfree(queue);
> -		goto unlock;
> +		goto clean_fence_driver;
>  	}
>  
>  	/* don't map the queue if scheduling is halted */
> @@ -852,16 +848,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>  	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
>  		skip_map_queue = true;
> -	else
> -		skip_map_queue = false;
> +
>  	if (!skip_map_queue) {
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			uq_funcs->mqd_destroy(queue);
> -			amdgpu_userq_fence_driver_free(queue);
> -			kfree(queue);
> -			goto unlock;
> +			goto clean_mqd;
>  		}
>  	}
>  
> @@ -870,18 +862,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	/* Wait for mode-1 reset to complete */
>  	down_read(&adev->reset_domain->sem);
> +	sem_held = true;
>  	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
>  		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>  	if (r) {
>  		if (!skip_map_queue)
>  			amdgpu_userq_unmap_helper(queue);
>  
> -		uq_funcs->mqd_destroy(queue);
> -		amdgpu_userq_fence_driver_free(queue);
> -		kfree(queue);
>  		r = -ENOMEM;
> -		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> +		goto clean_mqd;
>  	}
>  
>  	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> @@ -890,11 +879,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		if (!skip_map_queue)
>  			amdgpu_userq_unmap_helper(queue);
>  
> -		uq_funcs->mqd_destroy(queue);
> -		amdgpu_userq_fence_driver_free(queue);
> -		kfree(queue);
> -		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> +		goto clean_mqd;
>  	}
>  	up_read(&adev->reset_domain->sem);
>  
> @@ -910,7 +895,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return 0;
>  
> +clean_mqd:
> +	uq_funcs->mqd_destroy(queue);
> +	if (sem_held)
> +		up_read(&adev->reset_domain->sem);

To be able to savely call uq_funcs->mqd_destroy() we must hold adev->reset_domain->sem.

So when that is somehow called without holding that then we have a bug here.

Regards,
Christian.

> +clean_fence_driver:
> +	amdgpu_userq_fence_driver_free(queue);
> +free_queue:
> +	kfree(queue);
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  


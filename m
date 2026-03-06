Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D08F01832
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 13:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B0010E1FE;
	Fri,  6 Mar 2026 13:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVD6By3X";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8E110E1FE
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 13:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuQKMkWxRj3b3YiOG9sZjozIIva+yIa4RZf2Ob2SqMOqvDmH7b9BjAnLuEjgYXhIdhR8z6ccL2q+aMJh9QXWcIXNOHUA5kfEtsrXWYd81u2eEoeRWW+1zUj5yyOr94ctCQwbmi4mLVle3VS6YX/tYI33Muoik8ZsDxBXNE+IG6O3FOBT7ZhqLMNMXYoUH25007MWXRYB0h16saSuW7mavOprqiSekCwFDMTxnwXaHSeKhU38jXvTULoEFh/M3JlrjUUL8aP1BXZ6Zmz8SBAB6VNoju/BQ9p4pQYOzj1YRqrvDktfJVoX04kevrMK8EIHJEjpHUyUjH6BQ4A6GbnkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sUF+XdKZZwCvKw5N7EJ8PALLLh6CsOjmMteDNuS+4w=;
 b=N12gOzqmRXm5wd1EXLGuG0tO52a+J/Fhjsfe/XTiJdxeCj8I4wWL6nFL0ZgfrzTJkEHpCTSCBwMMHcqeX/yDo/JrTOHd1aDSxzfcTvx2IXpNHrgdxckYcTiyKT7IK+i0/Fx7dYMjhuCRRjxF4WqmXwYTVmz81PyvaO9w3FjciCQkeHsWNr54EhkncrCkhdTpqhJ7cuRS83fps334ra2zfwmA47g2pYtuQDCss6gHvbawx3Cz/yYG9carSr0skBsiuXn4nkser8PiYtJ8wl+otN8TDFqHTFzD2GgLXSRCYflN0/8zcb4CodtifJXiGfq3hEEvoMwywIkHG4/kHBJ1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sUF+XdKZZwCvKw5N7EJ8PALLLh6CsOjmMteDNuS+4w=;
 b=VVD6By3X1Zvo029SDew+czB23pYJbhRTw9N6UBtNTtI+N957IvcHMBGh7foLN6l1wuOnxtTLcV3/a0sieGtxSDB2gsQ9Z31OlTLECFXv08M+nDqFrphfFr/HhEjuIyp+R/S5sMQ+/5GcK9hM2iGYnkwzxFgGo5DnEdshCUSJNQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 13:01:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 13:01:10 +0000
Message-ID: <7bda3f1d-2780-4208-8f99-6b83eaee9f83@amd.com>
Date: Fri, 6 Mar 2026 14:01:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/amdgpu/userq: declutter the code with goto
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306113344.2412644-1-sunil.khatri@amd.com>
 <20260306113344.2412644-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306113344.2412644-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc41030-79cb-45f1-2d39-08de7b807033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: ziKuyb/0iDw0shqEQnFp2LO8Ij14LrfJlAbbR7VaWc5y7sP1O2MNecsUGuRNqSGwPtxXylHACP919dM4+huITwU5lHDoJYESQ16o5zLO1jqQ7GIsmp15fB92JREFgiHoKpjco74nRVbhLfyot44jZtBymBXZ6+1dX0rEyiAiB9FgJDs+naNPqPjfEpp/vaN6UcwAzNbNHVtGhanPHPfNxHsCZe9kENcWH6iA5NAp6Q8JaOkAO1E43Sv8FSp/nPp5J7HhlUp5S8OMfiX/LZM7bI45wg5N7qEC5xWduu0M7nrhtPi3wv5D09SE/9+ACm99ZNLI5qx1nlkJC0MuxhuvoQ7XgxdEs+EbT28nsD6emweT3MB7K2aE7RFtNGg0mRsQXZssVY5H+/BOqyccnjYMQLO6jjUqLaOsw5cgeevvVz4DNy3d9Edy3qWpiinXlv0wyG8mO71WjbEnNOwXWXhLbtXoRVg2gtnjE4EAyUbYjjAQsxiJq0W/gFBDIxrcnp9PirQB+frZeQ7WNzkexHAd7QImNKwkPvdnTMHHBJqVyNbqOf3UzRNGq7u25YgJ/hYt/jeU8S1R7gZlVVDnea71Iyy93Ws+QUk7vG72tFejfhrCkHfWpJGPLtaJH8Q0o4dr97xWbiIhxYWZxwXCYq3Y4Uvsec4xvGIQSlJiwfSXR9ywQPbC+eHJHKZeebhwzCqOz1RFtKqSz4xya2lWiVC4yYQ1iTzOKRw+rq0ppfz8J7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1QwSit3MHV5TytUaTlrZFZ3bXZENU00am54bG1KS3BpTGw5UFpUMXVVQUtn?=
 =?utf-8?B?WEY3OXZSZmVZM3ZxQzZPRk4xbmZ2MGYyNjNjQk9JSzJrekZNVXVXcXd4Vjc4?=
 =?utf-8?B?VTFuWFZvVElkVS9KaWEvcXBXYlFQRmdSd0ViTDRFZ3o5NlVvOWlDU1Z1dFdM?=
 =?utf-8?B?T1M0Wm1vbk8rbUVGNFNGV24xdE9wMWlKYVpBRzBNeVVxNkJhdGIrUjJncVEy?=
 =?utf-8?B?NHlLc01ZRTBFOU9rV0pzVEVkcEJyUTZGMW1sZHdybCtyY0l6OEk2aGt4eE9v?=
 =?utf-8?B?eW1tSUJDc0lBbzB0Zm1PU1NhUTY3NDdGYkF4bzdIT0o3YW5DT3dmRWdOZ0E3?=
 =?utf-8?B?Rm93TlF2eXlBVTkwMkdxV28rdVQycHh4RXVyRXNwY2I5RGo1RGlxbHcwNk1u?=
 =?utf-8?B?WDlLS3c1OG9IN01pUk9ZUHdFbjM4bkRUb0FuS2J1TDVhK3dJMG9LcEd2R3U1?=
 =?utf-8?B?TnpEek9hTEQ1dysxVzlWank5K2hxNlBTT2w4WmFzZEIwSVdUUFVqMDBWb3h2?=
 =?utf-8?B?Nk12Q1NoT2VwMnFsckdTWDJRTEFIRWpOZGhGNDc0dXJmNVppUE5ta1ZTK096?=
 =?utf-8?B?OXFEVFZpTTI1RnhBRVE3ODRmU0lMOUZuV0x1RTNoNTE5eFdiMkFvZEUvbllP?=
 =?utf-8?B?Q3JZaUd3MDJwbHRQdXdsakpCQkhxb1BRRk11ZkJhTzh0QlZackdXNUNOYUNw?=
 =?utf-8?B?SnNSZXF5dTVlZTZsYkFqRnhnekgraDA3ZGh1eWY5dGYyMnlTTzBjWituVGxD?=
 =?utf-8?B?RTdJUjVnUWJnSnlBLyt0VUpxSG9WdUl0M3NQS1ZKdnQ5YnJ3WjJ4MVNnZEpn?=
 =?utf-8?B?bkRPc1VQK2E1N3J5bXFqb0ovVVRlZE9WQ3ZoMVZ0R29yUkxuYlJ2TEZUK2pr?=
 =?utf-8?B?M3k0M1lXbmgyK2Y4NWNiRmhCdWsrcHFoYzZMVUE4cXpXelVpQ2ZPZEpURHE5?=
 =?utf-8?B?dFhvM3RhQ2UvaUhwTG5QdmhUbk05SzVuQk1NY0pVVVVDeWlLa2xvc3ZOTm9J?=
 =?utf-8?B?VVE5Q0xZbjJiOWhOcExVVVZIWnRZVy9UczFXdTZsWG1pUHo0Y28vVHVod0cr?=
 =?utf-8?B?QVdXbUdxSzlVcnNOdnJzZ3JXVWlTcHRJNWVjcVlmVU5DSXZKZ1NVcnpEaDVj?=
 =?utf-8?B?dnRQOENGQy85dHNLd2VDVkNXZjBwT1lkdVdmT1MvRHh2OGw2SSt5NkdDcVQ5?=
 =?utf-8?B?R0pGbVg0aFhsZnd5WWYzdGZaNGpFdnNxNlhCVWt5N2k1Q3ErUnFpd0lha296?=
 =?utf-8?B?cUJ5TDZQYnRhTWVPa1hvc1hKZVk3d1oxVHh5aHNGYkQrL1pGL0ZZYTQveS9v?=
 =?utf-8?B?bnVsQ3pWR3VrdmdEdmR2RW9LUmtvY2xMNnR6azdKSko2NWQycWVNUDFzbWV2?=
 =?utf-8?B?dVN1d1V1RWoweml2a3I0Szd5d3Rsc1FtUVJEWDdCVEt5YkdsSW5QTjlSQi9R?=
 =?utf-8?B?elRqQXBQcHVKS1JrYnZDRHZtQ2NzT2xPaVVEM0hxbmFFQU80VXo5dzNibzJl?=
 =?utf-8?B?UVhGTGhubktYQk56dDZ1V2NwNzB0eUR6OFRoL2hIOEZYL0hUUnAxZjg3dGhs?=
 =?utf-8?B?MGVXak5kWXlXaGdHYjhnTjZWbUQzQzE3ekliWUtGaDBiNFdmR1pYNTB6YWJJ?=
 =?utf-8?B?aDFqV1Q0OXVudFpzK0VpVm85TmZOMUJIVXRKRW5xbGw4L3JjUW1qT0xCNURT?=
 =?utf-8?B?aHpsUHI0RTlsK1dHS0hPRzU4TFl6NUs0cm1mV3F6d3Rkd1hDZWJPT3hyeDNn?=
 =?utf-8?B?cENZV3BDTlJWNVc5ajRSZjBKbGNreC8zTWV3WWtZS3o4SncwM05VSlFHUFBY?=
 =?utf-8?B?eWFKM2lxYitDR2p0ck16bys4N3U1ZzZvMTF5dFRvUktkK1M2N3h1SGRmS2Y1?=
 =?utf-8?B?ZTIxRHQ0Y2dBbkE5bktNdjJzZzRQNStxNXI4UDBNYjVwbkFhNHB4R1YzNnVS?=
 =?utf-8?B?V2JlWFpSL3RoSmRVSnh3SjNEOTVJcURiMGI1Yld2YVpVUW1halpCZ2hsZ0E2?=
 =?utf-8?B?aisyMUlIRmtGR0M3YTk2cFgrNzB6MkwxVmlaMzRhbWg1WE1FaVE2K2l5VEhE?=
 =?utf-8?B?U1JEZm1icHNqbVJnZTBLQk1DZUx2VWRlYXZ2UVhpUmhyVFk5cDlnOU5udmJD?=
 =?utf-8?B?aTFVVHRUbVY2V25PWk44a3FkY3dLaXA3ZjhZYUJwdzg2bGlmVVY4ay81Nkpu?=
 =?utf-8?B?VTVpMExZQk5YL1RnZksycXdWUVh3SWhYRG1kNkQrYlRSbGpZVmZHVTNkdHV2?=
 =?utf-8?B?RDFKQWIwRWdsOTc5cWNTV2YwNENjdTZhR2k0VUNOQ0h2NEpsdVZHZEdvVndy?=
 =?utf-8?Q?QVjQOE3Hnb8VS3L0KL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc41030-79cb-45f1-2d39-08de7b807033
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:01:10.3984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfFpHRpXBnzokAPzbkuEIDB5CPo8K/KdT3cmgEeo4QwPOla88T86FnPtMnl0n51c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

On 3/6/26 12:33, Sunil Khatri wrote:
> Clean up the amdgpu_userq_create function clean up in
> failure condition using goto method. This avoid replication
> of cleanup for every failure conditon.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 40 ++++++++++-------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a614b01b7eab..1543ca324f43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
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
> @@ -858,10 +854,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			uq_funcs->mqd_destroy(queue);
> -			amdgpu_userq_fence_driver_free(queue);
> -			kfree(queue);
> -			goto unlock;
> +			down_read(&adev->reset_domain->sem);
> +			goto clean_mqd;
>  		}
>  	}
>  
> @@ -870,18 +864,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	/* Wait for mode-1 reset to complete */
>  	down_read(&adev->reset_domain->sem);
> +
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
> @@ -890,11 +881,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
> @@ -910,7 +897,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return 0;
>  
> +clean_mqd:
> +	uq_funcs->mqd_destroy(queue);
> +	up_read(&adev->reset_domain->sem);
> +clean_fence_driver:
> +	amdgpu_userq_fence_driver_free(queue);
> +free_queue:
> +	kfree(queue);
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  


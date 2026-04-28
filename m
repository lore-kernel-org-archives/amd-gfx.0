Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E21FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6BF10EB19;
	Tue, 28 Apr 2026 11:26:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9/1ULfo";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE1B10EB19
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c08wOXY8t49UtcRYfRbG0xsetdkcThFkVXTOC0qJ13iSZsjC7/TYMdq0M6ZVCCo3eLQckw/vIb48tkxK+YrtI1+X0HqDKZ5PY5XCOVgMLomTCDHqsSwfi2tdEYiCORI9T6RWWX2sVaFwtsrBB6jooRs0KR0oQgGSmh4+rCxA2G9LxP0Uc8L0kyRAlSkzxaHLcLYFBCUMViTnhT5mRYts443+mxAVCrM+Lubf7iMQpF3YUc2DhxRr7uLQz0Wau2k8Bz+zWvuO4rTy2+xk4B3QKkEjHePbWOh4pnxwXr7WOTeTvYGslZgTo/OxuT7KWrLxog998E1fbE3zX3rrQrWV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im1kPKWGZ+PimXX34asey6HrwIvOqaQ8TfjEoH6Ne+s=;
 b=jhHgx+y6sef+Q1F8BHVRz7eszwuJwlZdt3FW71QQ1paJR7q72rBq7E585XLbaRrsGk0Pg/4fRXZt9Pa0ATveteOfVMmTpJN5dhmtAyrh5VStjsGmNhJ2q210XhCbfUFdjVJXi+HF1fIoteN5ZVGdxnNK6SO1SwPD0EZhVqW2NLzY9s4fN80Ratrn76wpyCJoZO1wEJhnZk9J7Oa49VtnE+0jCe1vOO4s4P0OGHCg4TOQb4BuNjaWu4PMt8oMI/POuc2JUWoJ4+q4WLxnMDMltQUlqu6v58FJtWBYDJ+eoLnOQQB1gu5oDvb86GkEDmVzAY+NdOOXFToQHEJsj+ANvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im1kPKWGZ+PimXX34asey6HrwIvOqaQ8TfjEoH6Ne+s=;
 b=R9/1ULfo1PT9YO5gJ+qcr2LuPwPeP4tO1Vbazy39XGf4m+VEr/nfY3FVORdodFPmHMePUVnOYJQxuwXT3LGOSXhoSgblXfAIXONlUGO6g9rPlH0di2sxmE1A0RQKZfyWxMbVvbR/vKBOOj4kgPlUQM3pRrvqo3kha4xvH2H36mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 11:26:21 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 11:26:21 +0000
Message-ID: <27cbaef0-0c45-40fa-9f20-63636642eeb9@amd.com>
Date: Tue, 28 Apr 2026 16:56:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu: fix handling in amdgpu_userq_create
To: christian.koenig@amd.com, alexander.deucher@amd.com, Prike.Liang@amd.com, 
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-7-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260427182723.1715-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0128.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1c24e7-307e-4d69-61fe-08dea518f8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: bGhc4QXc8EQqo3WM3crrhZN2TL7THLULc56kLAGv3E1TLMyNpCUfUSNpQs942yiTvyCXytrAggMOoGGK52WF3d++dzhiuK4Fz4PlUarvaqzHrP4tTeRR3AZ+YXyWKkj0qTet2HnBWUFtvy/LS5uaioOQrkGhFMEueFsGrACYoiPSK3SFa5xvDaHylH4i2TuH1JGIOBpD9oaQEd9HJBIsHbe+Cvc9Pa/gkrqxU8ZLth30FtHLsu7A5YCSABy2ssmpOXtJK0tKdwXDoZu+8dI/UtV0bh3CPsV5NrkrUMaJ3pJ9Nr+NpuMBKZiZ1Wnv3WG8aRf7e4xlba8LNePkQ3Gv6kbjxqdMjZiZnTdVvv0nX6XwX51EOzvPBDe/Vmi+y8Bq1/DYkVDsEKDxFE8LUfD+WOvedt9w0bzW3e541fGcVw6aHuisFpRIbqU8DQbl35BhDAaMtg1HJ91o7dB7WELSX6iI0RI0yWj9miyPboIFuFU6l4nevt+Gwew5LavDLLLCB+YgIEb52edmiSWJWGsALmYOdgnR/7hn4qZeJn5oUTdD1coBo6jnRgeJBbZMBxiVOfqCEKM/NWJ+FPmVo+VqZqP2eEvLlKXwJtgqf3z9haOhaSq8CPhjGA13VVw/QREWyOmz0AKInmQwSIR2P8XveY0WPQHmmkvzpw0EWKP+R3iq9/5CJqKEtAzWQCLcyrwX3RbrnZELF6IYny52iJeEdOPI1Z7FPCPv6rI9vmDFqJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sld0WVE5SElvVW9aSFhmNW1CSEl6cXZtUFhBTVh5REh0N0R3b2JXUFcxTjYz?=
 =?utf-8?B?bEpwUFpCWktDVkhUdXNhNlA4dmZQL1IrbUJBd2loTmh2c1FnL216YXBpdkIy?=
 =?utf-8?B?V2ZVZlFQWk8xSitmVlZLRG5jb0FwYUU2MTJEeHdBQjBTdWxYbTk4WjdERnYy?=
 =?utf-8?B?Tk5ZdlZKaTduNXF0UWZodEEzOEN0LzNKa1llSnNYUlRDT3pVU1MrNjV4VXJ1?=
 =?utf-8?B?VXg2TFdaWXloZ2M5K1pLVkZwQmxoRjRJZVB5eHZ6UklEakt5VDZFcjJqOTVa?=
 =?utf-8?B?OXBiOVZhdSsxekNOamVwcDFrYS93MlkzZ2tuMWNtRXQrL1JhNDZCT3ZSdDJL?=
 =?utf-8?B?YldML3ZONFU5VzFuemxGVjVlV2laNEkxME9ZM29Md2NuK01FMDJWU0JlZVli?=
 =?utf-8?B?TkRLeGQ5dlpDM1oxLzVaZmRLbW1IazN0SjRWR05rY29GMjJ0c1NhcU9yOXRW?=
 =?utf-8?B?Y2FERWNJOGJaMzN3VEU2SC9Ia3Z4Z0VvN2dhdDF2NHJMbmxUUXdjQnU3Qmhv?=
 =?utf-8?B?SlArVHNjWFlTNHVmbjBjMlJpZDhWN1JERGYzaEFtWnNkMSs4enYxV3ZPMUNy?=
 =?utf-8?B?N3VKbUFvY0swTEo2K0xPRm9tejh3c0xhRlNFY0dZRGw4ZW5SZE5pd003UzZ4?=
 =?utf-8?B?VWhPL3BtOVNXbTRTUitHNXpQMWtEb1BLWlo3ZzM3M3pQQ1FocDRqSjFXSDdO?=
 =?utf-8?B?bkFqWGVUR1NZa0lBT29oNHdjdy91RmRQTUg2bzd2WHFSSmNzemhRbGY1cTYy?=
 =?utf-8?B?WlJBQmplRzQwMkFvVHpVcWU2VzBwZ3ltRFY1L2dwMkRtSnFhRzZyWkYybFdG?=
 =?utf-8?B?YWtDMzVXV2QwQ2RYMldPRUZHdUpReVhLM0JIVXhLclYyWURpQTBON0lIN00r?=
 =?utf-8?B?L2pLb3Z1cGFJbGRNNzVvaC9FaUNSRWdIQllqQ2hmWUFnVWJuTjc2WUlXZU8z?=
 =?utf-8?B?OUFwYVYxZnNrV2MxbXIycjg5V29CVkxxWmg5MmN0Nkc1bGVNL09yM2swMm5r?=
 =?utf-8?B?VlVSeUlKWE1uMS9kQzN3MXFsckkzQmdYenpmL1lCMGswVjNxUHc5MWtLQnFG?=
 =?utf-8?B?Zk1zMmhLbkt0ek9mdmE2dFRRMnFJYmZtRmtGYXloOHdYaTQxd1dVQ1pYVkpq?=
 =?utf-8?B?YU9pM1F5V2kxKy93ZDV5VlhTV2MxaTREZzVHQ0RrMVdTMmdGcGxlN1UzYkVK?=
 =?utf-8?B?NUF0R3VISXlCVjNUVmFLV0JqbWxGMDllT0RFenY3eC8wSzJKRkFLbS9tbkRU?=
 =?utf-8?B?QUdVZjB0Yzd3ZzhiM3RCQ1dUY3NVa0hsZnFpbUVKUXdqYmRPdzNNOURlV055?=
 =?utf-8?B?UTNCaVAzdk5KbzQ5T3lRcVhQRytjdFF1VUFaeTllN2xiZGM5UTdoRzRNcnlE?=
 =?utf-8?B?TWVXZ1l2bFh4SFh5M1ZKaXJFNHJ5N0I5WCtianNuQTA5SGhod2oxY2k4eEo1?=
 =?utf-8?B?VE0vTVZXWFNjR2pGYWFWLzRTRStYRGt4a2pFWm5CTVd2L2pWNUdJbzU0OW5u?=
 =?utf-8?B?dG1tM2lhVXNxcHNMakVac25HbVFJME5WWFhXUFh4WFlBM1VZTEFwclZxTXpp?=
 =?utf-8?B?R0xuSXF1K24yL042YVkzeXpWanNzbzZjbkN6YjZRSlVBeXl3b1BGRmQrL0Qr?=
 =?utf-8?B?eE5NUm1kc2ZSUDhlVkFrZzlBUHJGVHhBemtSMks4cXRib3dlV3FoZk4rM0lt?=
 =?utf-8?B?QXBabnRZS2h2Q1Y0U3hLQ1h4L0R1d2UxSHd3MFh3dDQrMFBJVFkyQlBWTVJG?=
 =?utf-8?B?RGFqbXJvT2V3Sk1KbXlHSmV2MFBWRXZkcFZvVy9CQjN5NkF1c2x3bHplVnZr?=
 =?utf-8?B?d1IzeE1uazY4SG9aZkdVaEtINmJmS3JHVzF4WGEyK0RCdG9TNUR0L2FNY01F?=
 =?utf-8?B?ekFKZWREWWJ4a055V1BOSVV5dTV3L3NXMGVKeTNhejRaMjBUcnRZL0ZIYjFF?=
 =?utf-8?B?RWs4U2dpUUlaY0pNUWUrK2QzK0pkSXg2TGpSR0ZKVWgxYXo1bStoem1GWHBU?=
 =?utf-8?B?M2xYeGM5YUhzVVFoR0o0M0pFYWxkcmFHRW5EeHFkZC91WVY5UUJnQ0xRdTFm?=
 =?utf-8?B?ZDRJYTVwakxrcFJzc1AvK2l0OGVIaUxFTGllc1U3WlA0UldQM1k0TXZRYk9S?=
 =?utf-8?B?a0gzbjJmeWdQWjVjVUt5UjR1QzNFazlsb2RveUViN2h5UTFscmJ4N1VyWnBn?=
 =?utf-8?B?d0pTTDJmMVAvNnhXcTNRaVNvaXFkN0hvZzdUcm1BS3MvNjlxL2pMQkUzQWlG?=
 =?utf-8?B?SEM5NXZjcnVUZGw5a1Jra3NPQ0J4dzJGR2g1b3NpcU56NlZwb0xlWW9sejZK?=
 =?utf-8?B?UllGRUVrNXhvK0JrZU9uRGg0ZkhBYTMrUWNGdFoyM01aWFpRaUxpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1c24e7-307e-4d69-61fe-08dea518f8d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:26:20.8436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2IjWABcEkmMRbqB5ArsQNaZ5qP7FpuEuU1rqzo81spSfz0BDjNrszNGl+xfaoLfly06t/Wv4p5p6n8hPHkd7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469
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


On 27-04-2026 11:57 pm, Christian König wrote:
> Well mostly the same issues the other code had as well:
>
> 1. Memory allocation while holding the userq_mutex lock is forbidden!
> 2. Things were created/started/published in the wrong order.
> 3. Error messages on invalid input parameters can spam the logs.
> 4. Error messages on memory allocation failures are usually superflous
>     as well.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 118 ++++++++++------------
>   1 file changed, 52 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0374a70b631c..28e0695b53e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -718,14 +718,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	const struct amdgpu_userq_funcs *uq_funcs;
>   	struct amdgpu_usermode_queue *queue;
>   	struct amdgpu_db_info db_info;
> -	bool skip_map_queue;
> -	u32 qid;
>   	uint64_t index;
> -	int r = 0;
> -	int priority =
> -		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
> -		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
> +	int priority;
> +	u32 qid;
> +	int r;
>   
> +	priority =
> +		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK)
> +		>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
>   	r = amdgpu_userq_priority_permit(filp, priority);
>   	if (r)
>   		return r;
> @@ -738,40 +738,43 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   
>   	uq_funcs = adev->userq_funcs[args->in.ip_type];
>   	if (!uq_funcs) {
> -		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
> -			     args->in.ip_type);
>   		r = -EINVAL;
>   		goto err_pm_runtime;
>   	}
>   
>   	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>   	if (!queue) {
> -		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
>   		r = -ENOMEM;
>   		goto err_pm_runtime;
>   	}
>   
> +	kref_init(&queue->refcount);
>   	INIT_LIST_HEAD(&queue->userq_va_list);
>   	queue->doorbell_handle = args->in.doorbell_handle;
>   	queue->queue_type = args->in.ip_type;
>   	queue->vm = &fpriv->vm;
>   	queue->priority = priority;
> -
> -	db_info.queue_type = queue->queue_type;
> -	db_info.doorbell_handle = queue->doorbell_handle;
> -	db_info.db_obj = &queue->db_obj;
> -	db_info.doorbell_offset = args->in.doorbell_offset;
> -
>   	queue->userq_mgr = uq_mgr;
> +	INIT_DELAYED_WORK(&queue->hang_detect_work,
> +			  amdgpu_userq_hang_detect_work);
>   
> -	/* Validate the userq virtual address.*/
> -	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
> +	mutex_init(&queue->fence_drv_lock);
> +	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
> +	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>   	if (r)
>   		goto free_queue;
>   
> -	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
> -	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
> -	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
> +	/* Make sure the queue can actually run with those virtual addresses. */
> +	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
> +	if (r)
> +		goto free_fence_drv;
> +
> +	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
> +					   args->in.queue_size) ||
> +	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va,
> +					   AMDGPU_GPU_PAGE_SIZE) ||
> +	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va,
> +					   AMDGPU_GPU_PAGE_SIZE)) {
>   		r = -EINVAL;
>   		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>   		goto clean_mapping;
> @@ -779,6 +782,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>   
>   	/* Convert relative doorbell offset into absolute doorbell index */
> +	db_info.queue_type = queue->queue_type;
> +	db_info.doorbell_handle = queue->doorbell_handle;
> +	db_info.db_obj = &queue->db_obj;
> +	db_info.doorbell_offset = args->in.doorbell_offset;
>   	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>   	if (index == (uint64_t)-EINVAL) {
>   		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
> @@ -787,82 +794,61 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   
>   	queue->doorbell_index = index;
> -	mutex_init(&queue->fence_drv_lock);
> -	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
> -	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
> -		goto clean_mapping;
> -	}
> -
>   	r = uq_funcs->mqd_create(queue, &args->in);
>   	if (r) {
>   		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> -		goto clean_fence_driver;
> +		goto clean_mapping;
>   	}
>   
> +	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue,
> +				GFP_KERNEL));
> +	if (r)
> +		goto clean_mqd;
> +
>   	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>   
>   	/* don't map the queue if scheduling is halted */
> -	if (adev->userq_halt_for_enforce_isolation &&
> -	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> -	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
> -		skip_map_queue = true;
> -	else
> -		skip_map_queue = false;
> -	if (!skip_map_queue) {
> +	if (!adev->userq_halt_for_enforce_isolation ||
> +	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
> +	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
>   		r = amdgpu_userq_map_helper(queue);
>   		if (r) {
>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			goto clean_mqd;
> +			mutex_unlock(&uq_mgr->userq_mutex);
> +			goto clean_doorbell;
>   		}
>   	}
>   
> -	/* drop this refcount during queue destroy */
> -	kref_init(&queue->refcount);
> -
> -	/* Wait for mode-1 reset to complete */
> -	down_read(&adev->reset_domain->sem);

We dont need this anymore? If not the patch looks good, Reviewed-by: 
Sunil Khatri <sunil.khatri@amd.com>

regards
Sunil

> +	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	mutex_unlock(&uq_mgr->userq_mutex);
>   
>   	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> -		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> -	if (r) {
> -		if (!skip_map_queue)
> -			amdgpu_userq_unmap_helper(queue);
> -		r = -ENOMEM;
> -		goto clean_reset_domain;
> -	}
> -
> -	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> +		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
> +		     GFP_KERNEL);
>   	if (r) {
> -		xa_erase(&uq_mgr->userq_xa, qid);
> -		if (!skip_map_queue)
> -			amdgpu_userq_unmap_helper(queue);
> -		goto clean_reset_domain;
> +		/*
> +		 * This drops the last reference which should take care of
> +		 * all cleanup.
> +		 */
> +		amdgpu_userq_put(queue);
> +		return r;
>   	}
> -	up_read(&adev->reset_domain->sem);
>   
>   	amdgpu_debugfs_userq_init(filp, queue, qid);
> -	INIT_DELAYED_WORK(&queue->hang_detect_work,
> -			  amdgpu_userq_hang_detect_work);
> -
>   	args->out.queue_id = qid;
> -	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> -	mutex_unlock(&uq_mgr->userq_mutex);
>   	return 0;
>   
> -clean_reset_domain:
> -	up_read(&adev->reset_domain->sem);
> +clean_doorbell:
> +	xa_erase_irq(&adev->userq_doorbell_xa, index);
>   clean_mqd:
> -	mutex_unlock(&uq_mgr->userq_mutex);
>   	uq_funcs->mqd_destroy(queue);
> -clean_fence_driver:
> -	amdgpu_userq_fence_driver_free(queue);
>   clean_mapping:
>   	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>   	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>   	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>   	mutex_destroy(&queue->fence_drv_lock);
> +free_fence_drv:
> +	amdgpu_userq_fence_driver_free(queue);
>   free_queue:
>   	kfree(queue);
>   err_pm_runtime:

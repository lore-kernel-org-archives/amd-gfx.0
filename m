Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C1CF01832
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 12:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C81510E1FB;
	Fri,  6 Mar 2026 12:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iOCCAIkC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7C910E1FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 12:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFRr/UDJLFmvUcgIkAXhEH3BNr+OTyxg0IoIobw9S/5SwKd13QMkAATHLLpCT1ST+5hXYG4/2Jw0QaZM9zPKi8AdsNnBF7aoZxE3nQ2Fm+MkBooIQf2IHF/Y52pLbhcSlFZzqnATrc0gV+tCFKSk6v9bGM7iezJ6eqLv90oATJ/i+rCQulx0QqU51mVjYkLMFC99uyAu2wlmJIhpxi224QRL7EsG7PfPdt5LcAYR8mqMzsgnUALRl7OyjnFjpaK5m1tNLUICMpHSlETsgdBbJZoNUT7UtjKkiD9UghA0GwsXcsf3m8/I6OMEaHlpx9iWEOlInOdhmLN5gc+Vugqegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoWJpkkbwPxmRrQ81VrMSyljwRpaoUVhDjeC/mHm2JU=;
 b=SJLTiDS4hTk1uEGvUOT4BQ2gNtPvwgo4qFWUpIkMRCNNFZ42PE+MCLV/2cFSPhgJEjhMVE55HZZtO11h7UTfz6QGUANIZK+hfgt6uu4SpVAiMws3sNeTl3ZGtkVft1XBQiM4x3Y7/A05ohZxFTVZEU5q+6OMBXykQ+3WWsXiqiuaeytgDlj/mVl/VVpGS5RWq1d8ByDYkknBMmarWLpxVcyYDDSRtgohfjgEdL2v8RgHShFZETtkLkgixtj8nQ9Mr+45vC/TMuvnkCaE2gPRFQOrCKEB8XZ4x/tCBiuZl7Zsf845iGiG7Pw6/fUNBmGYkJ+ZiyGvJrzqfRg7Jd8OwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoWJpkkbwPxmRrQ81VrMSyljwRpaoUVhDjeC/mHm2JU=;
 b=iOCCAIkC/NYZw2cdTCSopE0sTsQiw7DbXFBODZMegN2tWrONC4T5Wonj2ke1XsJemhjWxGnoPCQ6OP5Emz86lPtLqr2CoUsgiZthQkYsFIlTUUUe3mjq0LxRZWBELKOkW1V4NeLfzDrCMG1rJ97EmyvChARl3zdAs5X7FxScy4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 12:59:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 12:59:42 +0000
Message-ID: <06b1e1da-fa9b-4ec7-8c1d-d0feb1774fcc@amd.com>
Date: Fri, 6 Mar 2026 13:59:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/amdgpu/userq: defer queue publication until
 create completes
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306113344.2412644-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306113344.2412644-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6ac246-6b11-49b0-6b92-08de7b803c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: V+pbZGZiBNRZHi9VtNVU7H0Pf2wLYZyswBWdM6zPkCNMcRGH1Rq7tT2/MVicMEtwl5GqfN0fuzt+X3aH8EjAYRJNlzyEEBpLhGNEAWm41r0CyQ0Sk5hRKoMgk9MrYGiVhEdnluHx1m9KUfXTCGagcboSSTJoiHHTHnfrSjqs+tDXXwgN1Y3lQgcynaHP29PEK2S50yTi5irGzIocFdXQllE0XqbTFPTkcosXm2ghWtTiXiFZUQclL2ruvgnJ7QvKkRuGJEO/ojPSDZtT81D0dvoDYZEleL16GMuuMgfFrCdoQbhidYBlWmpZSVjRj4KYmmlmH9dNd97BdswxU9zrYGS+Q0Mu1OAIbhSYWdZ3ofhygtbWa+Q09d0UuYzn6EMUUYZ3qhWnz+yTTu3BmZZebvBkvc8A3XUO+Pg2HEZErmLDHu2mF+S9Jb13rxW2nTZ8OgkeZUQST4WdshnPPIQp1iaKaUyCb1gw7hU/IyE5YP62zZs/dRq2WeHjOIn3wL0++SobtQLVhz8Yf4KBJBeVA7W3b0UTkMsnQK6vDgY0bFdN4LyeKl0rHFi+KE1rcVdlpAoDT3kmGuEkXBsXcMemryiYV0kzayCu7KCtxJNomsD5v2L79HORpwcuF5zBZyLJ7m+MD/5v17C9ZhX1dXhFK97rvBjAREpgvECAHYejFSX1TngzvgNXcakeO4bX288oHTq6EB0SVf39qNx630xxMHHpQoDtZ82zHYAz6lWKMFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGJFYVlTMFZobFNTN1FFMHlzK2FVbWFvYW9XWENsRXRNVHhzaVVHWWExaTBj?=
 =?utf-8?B?Q2JES01UcGlOcjFDeTYxd28yck1hdzQxZmtEU1lndmxwSGlFemhnUnpkK2li?=
 =?utf-8?B?QlVuaS9QeHgxV1NqVmtJQ3Jra3JMRVIwczF3c3FvWC9EeXhxYXZ5YlAybm5W?=
 =?utf-8?B?ekNpUFBCdit3WERpUnlxaUhYN04xczlnSWVlejdXRnVSM05JQlExMHNKZnJT?=
 =?utf-8?B?TzZLTlE0Y2Z5WkIrMGUyNGVNR2VhdnIybG1GVGZVelNINzIrSWJ1OGRrVUJD?=
 =?utf-8?B?Q3dTbnBJNjRGNzdVR3BneXVmbURFN09ET0xJY0JydHd3cktRR25ocTVrOVNa?=
 =?utf-8?B?eG44Sm9KY2U0WjErWkh0aXV4bEV6Z05GMkc4SklyTkZJUVpQYTQ4NFgzVlNa?=
 =?utf-8?B?eDZ4TXZ3N0RaUkUwbzlueEJ1clBwbkxxdThnWDBJWVFaUDE2b2V0ZWFTM1JB?=
 =?utf-8?B?cHU5eWs0RGg1dStBVlFBTVBrNE9UTy9BY241UGFhaFVwUnU0UUdTdjV6LytF?=
 =?utf-8?B?WCtUWXFROU5ieVEyWWt2dHllNnFxR3lZNGNvS3kzQXhBZUptUHYzQ0xXeVFB?=
 =?utf-8?B?Y0I3VzRnUXFJOTdxbVpMYlBMMFdJMWlyL1cweUNkenBBckMwQ0F4RytCOFdT?=
 =?utf-8?B?R2JTMG5vWkNxb3pURGRMelNIYVE0b09VMS9uWmd2Y0loSEpuUFZ2MnVYMzV1?=
 =?utf-8?B?ZFFuelhSMEVOaHlIa0ZsNXc0UUwxY0FQYnR1S2JzblNzMmxZSDZRVFBRT3JJ?=
 =?utf-8?B?aDZHTVcrOXJKNGtxWHBCSGVqZlJmUjhqdFErUlhJTHpiYVlPZzVuOEFnSkU2?=
 =?utf-8?B?eEdkSHducWExaGNhaW03Zk1hMTI1aURJTmlzMnFVVm5XS1FuWVV2STZwSDM0?=
 =?utf-8?B?VCt6YldKTkQzem0zS0NZbk5rV2FBTEo2dE5JUHE4a25LZFhCaGxjYXVxUzZU?=
 =?utf-8?B?YlpPVlZSb1FuMEkrZ0ZzRmZiU25RV1RWaFYxUFYvRjVSSlRDMm9wS01iN20v?=
 =?utf-8?B?THN5MHBIK0toUkVaWmFsNlU1SG5WTzE1NHFxeklnUXUyeE8zKzJNZzRQMnM5?=
 =?utf-8?B?dm1jVUNZZ25jWGZqTmJ3Y3lnVmwxc1YvQ3hwZHdNbzYvZFhZVnpFWU5ETXdl?=
 =?utf-8?B?VVBzRkZLdi8yR09zWWlYTThXbjFwMW9NeFZjc3BOWVJwQnhxd0Zvek1KeHdL?=
 =?utf-8?B?TU96LytZUEFIMmxRVW55QldMbnhZQ2NJK0xzaTZadUhxMDViMnd4M1FyQ2pp?=
 =?utf-8?B?L1IxYXdCdndIVlF1TjVnTUc2ZFk5dm1tSmxQUm1qcjV6R3JxNTd2WEF2T2RZ?=
 =?utf-8?B?anlRTUVGUHNIUE1EVitoYjUxcE9MdVdqM0tjazBIWTkvNFZZbURTdEZ2dkd3?=
 =?utf-8?B?TkZMcHlCSUFuU0dzc3NwdlVRcnJzeDN5d0RMLy94T1RYSXRuRk5JWlRCSWRn?=
 =?utf-8?B?dWlwQ216eklWZGlOYlZJMmhKSmRBWTB1Z1FESUZhdStOb3UrSVE1SStNSW51?=
 =?utf-8?B?OG1RQjZsN29nb2ZVL3ZnZTQ0Q241dzJ2d29OZWtmMHVjelc0QmFobmVwWjZq?=
 =?utf-8?B?L2xHYzdESzl3RDZiSHZFUUlCWGNaRXRoZmlKeWQ0ekpXNjBaZ2pPM2JnMmJH?=
 =?utf-8?B?c0NyZGcwT2gxWmJUNXh5UHZRRUpvb0pKN1dvdnRqNlZldmxXU1l4eWl6NS9H?=
 =?utf-8?B?TWlhYkNQNC81RFZxV0w5WGhlZFRWRkRZaTZwaVVhTmpKTWcyeVdYOTF1TXlQ?=
 =?utf-8?B?a0M1aU1idkdUR3htNFFva1Yxdk1YMGtEd3Z4QWNrZW0rN1RUVlFjM1JUZE5o?=
 =?utf-8?B?ZlZzenppaVkyTEpZQzRaWHVadUlzQnU1eG5UaTV6SXMzNnFrUEhMUENTUjVD?=
 =?utf-8?B?WHJBeGNDTWJZMzNYdCs4MGNZRHNPTmlvc1RHN2ZNUXdrODUzR3prRWR5M3BK?=
 =?utf-8?B?L2p1QXpWVk0rSXRoUDErR05ETlBwanNNTXRnSzc2OVpVaGF1WkVJTWVMaTFE?=
 =?utf-8?B?MlhHbG4zdlV3WDJJMHM5Q1p6V09DNFNCSDR4bGFwR0tKdm1UOHF1aytwYlo4?=
 =?utf-8?B?VnZMb1piaGNDUFROMWNmTDFySmN1TkZYUFV1aC9ZOWRLT1d1Y0ZlSFQrb0Ru?=
 =?utf-8?B?OTl4TlZrL25KbldKaFcvZG84dlVSWmJhN28xNnFhVHpic1NpQ0hhVnV5MXZY?=
 =?utf-8?B?ZFVsWENyWnVUVDRNZ1MvQmZBRVRtbmtBRm4rZTd5YUhNSW80SGIxKzNwd1BH?=
 =?utf-8?B?TUtZT0NwVkttVlEvUGFzemMzSnlqNzYxc1R1eE1DZDdIR1NsMW1zNkVuQTNC?=
 =?utf-8?Q?hU89CznzlzsENLrrgx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6ac246-6b11-49b0-6b92-08de7b803c01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:59:42.6890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIYCB1vajQTQs3u9/hdpbPxbSvkbllBMEL8sXHlAGdwAb5xVCDzukoL7TQIZiuf1
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
> The userq create path publishes queues to global xarrays such as
> userq_doorbell_xa and userq_xa before creation was fully complete.
> Later on if create queue fails, teardown could free an already
> visible queue, opening a UAF race with concurrent queue walkers.
> Also calling amdgpu_userq_put in such cases complicates the cleanup.
> 
> Solution is to defer queue publication until create succeeds and no
> partially initialized queue is exposed.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 66 +++++++++++------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 7d2f78899c47..a614b01b7eab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -758,7 +758,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	const struct amdgpu_userq_funcs *uq_funcs;
>  	struct amdgpu_usermode_queue *queue;
>  	struct amdgpu_db_info db_info;
> -	char *queue_name;
>  	bool skip_map_queue;
>  	u32 qid;
>  	uint64_t index;
> @@ -848,32 +847,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> -	/* drop this refcount during queue destroy */
> -	kref_init(&queue->refcount);
> -
> -	/* Wait for mode-1 reset to complete */
> -	down_read(&adev->reset_domain->sem);
> -	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> -	if (r) {
> -		kfree(queue);
> -		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> -	}
> -
> -	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> -		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
> -		amdgpu_userq_fence_driver_free(queue);
> -		xa_erase_irq(&adev->userq_doorbell_xa, index);
> -		uq_funcs->mqd_destroy(queue);
> -		kfree(queue);
> -		r = -ENOMEM;
> -		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> -	}
> -	up_read(&adev->reset_domain->sem);
> -
>  	/* don't map the queue if scheduling is halted */
>  	if (adev->userq_halt_for_enforce_isolation &&
>  	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> @@ -885,28 +858,55 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			xa_erase_irq(&adev->userq_doorbell_xa, index);
> -			xa_erase(&uq_mgr->userq_xa, qid);
> -			amdgpu_userq_fence_driver_free(queue);
>  			uq_funcs->mqd_destroy(queue);
> +			amdgpu_userq_fence_driver_free(queue);
>  			kfree(queue);
>  			goto unlock;
>  		}
>  	}
>  
> -	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
> -	if (!queue_name) {
> +	/* drop this refcount during queue destroy */
> +	kref_init(&queue->refcount);
> +
> +	/* Wait for mode-1 reset to complete */
> +	down_read(&adev->reset_domain->sem);
> +	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> +		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> +	if (r) {
> +		if (!skip_map_queue)
> +			amdgpu_userq_unmap_helper(queue);
> +
> +		uq_funcs->mqd_destroy(queue);
> +		amdgpu_userq_fence_driver_free(queue);
> +		kfree(queue);
>  		r = -ENOMEM;
> +		up_read(&adev->reset_domain->sem);
>  		goto unlock;
>  	}
>  
> +	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> +	if (r) {
> +		xa_erase(&uq_mgr->userq_xa, qid);
> +		if (!skip_map_queue)
> +			amdgpu_userq_unmap_helper(queue);
> +
> +		uq_funcs->mqd_destroy(queue);
> +		amdgpu_userq_fence_driver_free(queue);
> +		kfree(queue);
> +		up_read(&adev->reset_domain->sem);
> +		goto unlock;
> +	}
> +	up_read(&adev->reset_domain->sem);
> +
>  #if defined(CONFIG_DEBUG_FS)
> +	char queue_name[32];
> +
> +	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
>  	/* Queue dentry per client to hold MQD information   */
>  	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
>  	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
>  #endif
>  	amdgpu_userq_init_hang_detect_work(queue);
> -	kfree(queue_name);
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32263CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 13:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA48410F581;
	Wed,  3 Jun 2026 13:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umD24gZe";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CF410F581
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 13:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIW0fpMgG4X+ENxm7WIidnDbXi8j7XCVQBjATCcoI97QC/lqmEQLqSSW2OMnPmdXLlqGTmeXlh5R4ANCtS1pNoRdACZXx6W/7e84Bljj7EetokscRCue4pSkgA9lgOIh1Vu/Hl+/5jNE0D9/iLnq3XkKQex8KrT6GrV6otWFQEibU8kpksazRYPP89UdPDiqFS+T10SxJcSKxIoK//J49r+zmAi10w3c+nOSmdN39aSwsAvqiS4Z/isnc0lCAJjr9FtoGbrZpkpRtOtML2EIpqf/l6zvmMgToRAai8z+AyZtJLNiPLce4F744KfkP5g1ipLxdrTWIOqwGfUSfYvasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGaoEgyesILbVj20AIzgRa5+YdUgpFxahCTyspTk9mk=;
 b=TWY/qAWPPREdJ0TCsK0ydpFKq5oCOmscouRHjRKhaV+FGc9MglbTvmy3Z5M//sU9lGiIIYB6ox9fRPDDrSJ7qcau8UQJpLiWQYObGTLrzrtOHzQ84dqMDtlH5KLhikhNY21tnvQQqS4+1A4CpNsEeXRoQocG+DKVmklYiH8Qxz9Olk3G430sgm1zePudCIrKLiX3yPZqI6883rn0BxBz98DO3pYejzADm+Kzn9rU+/mbHcyx4az0V/c93feq7llPgzXUtJc6YfCzvdTqUAS/CEJHXlN5xD+Ep7reaCe9odkjkRhtKKiWyASi00+SNh7AM5yTFZAZ6gJ6KR/WM7epdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGaoEgyesILbVj20AIzgRa5+YdUgpFxahCTyspTk9mk=;
 b=umD24gZeW+TCuV2qOXTOlP+007lXyHUQiMH4dvPZKVouLR/0UUkcX+h0I6VjbsPx9XD0yiGkcF+UMsw5nquW1qVIBGpy9h+/UgHI1nNJGRxUv4QIfl1obguESrPvkkTe86bvRVLn1mY0cSqO6kX9jhdj1Euw1zdtWZHxra4HRZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:42:00 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:41:59 +0000
Message-ID: <94fcce68-98bc-49c9-ac44-1235644aa309@amd.com>
Date: Wed, 3 Jun 2026 09:41:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add sdma queue counter for gfxv9
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260527175921.192734-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260527175921.192734-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::27) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 80726fcb-c4ea-4842-e03b-08dec175e2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ni7+ncII+FYb5NSzaPmc98pkoLgfhs59cqJ4KUI7/8RWDVRoMIl7KZEicR9013bAhxq9XEwxGNQAtthH+S02+dAiAn3KTkBKZT11uLpQ3zJZenAQIOZ7t/gahtaLAxfBtO3HPJIVHr9KdXTpjQb/Ue7kmEsyEDaHjRox+97cD7F2JcxFLjVWBIP9PPpwHUMf+c+KZJopivGb0wUhtJhQB7FYzRzmcihDTdNgPMs6H47c/K2ZFIUEqYNeV/Gq+IvjvVYJLS3LJJioH8oZi6G3wEgL1ncgw2Qy+GkYGSrXD7cfgJnd7WdWffRMJQ6IJm3WSEl631aP9GAiNYDkErNa8TF8eATXeTs25K5mpARjpyDB4qaJN6HWZrlG1bxS9o7crQTvOnknXhTtw19xKhcom+AETER8Oj9j50wox3ta7d+7lFAdYJdOQvbfJgD+MWQlf3umkrJes4nfRoz+2vEvITqywfar24qYgY/l3JpcvpC3oM04GCIzePNwl9O25twXexIb/fcTrGa0glGn5pDbJV5m3H9nxg+hofWYtsM0qBJh5pKLObNREFUl805K9X+9XoVuiM1MopwUV7csWhUUQUZngoYLk1ZMRY756G8+HDbIrNgTcZaOQQbMAMlXnROusG1YCtBZhsWI2oHCWD6G+bsNnZLHHJClCunw2QEYMSuP3sB8Xo0e97Ieh2+R9wHu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHpCL3drTTFCd1hpTmJDT2FvekRRelRyT0dvOEwvMG1ReHozVDI1d3pHUC9C?=
 =?utf-8?B?SlBOSU96NGcvVHJEWjR0NVBwWHJibk5IOWZ6c1hPcFhYbUxUckhVZmJlR2Iy?=
 =?utf-8?B?TTBqUW5za2J0OTREVlRyaHViSU5KbHNiM1gxRldlNDMySURjNmFuYXl3M1Na?=
 =?utf-8?B?TnY0UUJ3RWp5a3pFQ2VRanZlSnZIeVRVM2YrOENkN1pnOC9KTDJ0b1RQQ00y?=
 =?utf-8?B?VFVTNXFqbmgzT2ZqMUpjMkNZa3pzUGxsczVEVklJNEdWK1lWMmM5NGJTdk4w?=
 =?utf-8?B?TGk0OHpDbXB6UVZZQ3FqRkdqNDVFRzcwZWxjWktzSUtybERYQzBmWklVb2gz?=
 =?utf-8?B?RXF3dVN5V0swQUdwQWs5NisyMDFZSStiV0FVWUN6RTRVVlpBOHhXcjhPZGQx?=
 =?utf-8?B?WmRtQ1Axd28rb1FXZ1NGZnFSUGpqOFcwenhJOU5xcllNMmp4NEc4dXRnOEsy?=
 =?utf-8?B?a0dOckZaTFRXNG4vQ09xYy9YWE4ybTAxcGxCV2pubmxzYXBoQ0s3a0VvcE1i?=
 =?utf-8?B?aHdQeDc3aVd3ZjlJT1R1NXptZ0tDcUpib3R5VXJiRHhzUGNYcDYxdXhYVDRD?=
 =?utf-8?B?T3dxM3Z2ME91b3pBcitERzNDdVROOUNQZmsxdUFkdGtCMFhCamo4Q1B2cGNF?=
 =?utf-8?B?cFRHeG8wOW82a0sxRmpFQnYrVWEzT0o5blFSQVhoZFlRT2w3anR2NTFLUm9P?=
 =?utf-8?B?dUprSW5LREhjNGtJTEc3czlpbU5CZnlIWlVDYmEzc09uUHpveFJxQ1R5K3BK?=
 =?utf-8?B?VENWbVRMT2NvaVdBMDRBVEd5bndHQ041N3pLckJjeUdwTmtWd0tqeFRtTmFn?=
 =?utf-8?B?WXdxRHdFNXo3SjBTbmR1Z05uM3FYRjkvT1h4L1h6M08zNE5KK2xseXdWM3I1?=
 =?utf-8?B?c1lyaXdFN1h4TTk5aWlpcUZLRGN5M21DZDRHRkROUUhiNEZjeUxkSVZmVEE4?=
 =?utf-8?B?ajMvdXAvdHBEVEZudGFSOTJLRjF6NDIyeDBUZGQxdGdwNCtFM0JzM1doWTZ4?=
 =?utf-8?B?R25TcjYyUEZxbUhnT2t3OUFiem5KaEdVbWNITVRUcHNlQ0JodThFUlE3dTFE?=
 =?utf-8?B?U3lNZTZjSGY5ZG11cjR5TU4xU3YxRVpNN0hMOURid0drcWdrY0xOMzAyMG5w?=
 =?utf-8?B?ZlJxaGMxNE1JQ21lRU15L2ZseEh1bHNxZ215T3ZxZDU3a3I1Q3VOREV2WS9O?=
 =?utf-8?B?QklUSmd3eW9aT3d6czU3TE1JQ3k5dnlDOGViRExkU1pheGxlV3B6YzEwM2NK?=
 =?utf-8?B?MGxqL3ROVEFhRFZJMmM5WWpyWjJKL2FEUDNTR1Z1SGJ3bU9jb2dNaUtablNJ?=
 =?utf-8?B?UTlyQ0sweVR6dG5SRXJDbHJ3cjdheDhJWjdXWWtDYlhTMEExNG1vdXNnOWJS?=
 =?utf-8?B?VGtmbjVKaWl4dmMvZU4xUTBDaXhVNTVXS1NYT1pwdXpZUUMxaldIaTJ4bzJZ?=
 =?utf-8?B?QkVGKzlpTEJ6WDRQOC90MlVnenNEMHlKaHBwbHVXdmg5MVdOWGh1Qm1UR3Rm?=
 =?utf-8?B?cWdhSHpMalJtcS9memhuUDVZL0RBVUFLVHhLSU9CRGxoejNucGdIQ3czODly?=
 =?utf-8?B?eWplRmc2dE5haFE1d1lzcDA4ZTdROXdVK2xJUUVCQkVaNTQ0UkVlNGdyTGpJ?=
 =?utf-8?B?dTRNZHI5WkFKYXNjK0E3MzZNNnYvUlA3eWRCN1FKL29QdjFsd0pGUkovZWJV?=
 =?utf-8?B?dUROQ1oyaEVYNnJYV0ZQRTJjcS8vTTdGZE1GbFllSmZmRDZpMXFsVklzVXVP?=
 =?utf-8?B?MGt2YzBnREQ1WUM4aDUxZHNmb0pCWktkbERXWERMeTNDaDN0aFZsbVJXY1cz?=
 =?utf-8?B?aTYzUzBBMmIvNldxVElEQis3b0ZoOFZPcFkySHczSUUwdW9EWUZEK21vWmhF?=
 =?utf-8?B?YnZhdFU3a2FYMWVQMU9Fa2dQMUpKeXEyeHB5M25uZVNOUUpJellpT2RlSHdv?=
 =?utf-8?B?a2tNUE85ck5iNGsyR2tQd3h6R3VmMG9IbzR6TXZ0UDJCL3VFcEd6YTAvUTNC?=
 =?utf-8?B?cW9zeEtBblJuVzNZK212TjVXUEZiMGJjSW5BZUozZE1qM2ErSTFWMElOZ1Fi?=
 =?utf-8?B?c0NnamFIdU0waVhid3Q5M3JsdEZSWU5scHFibU9MZ0t0QTBHNlVVV0Y3SllR?=
 =?utf-8?B?STFGUzhHdENpWkVRTnQrTGxLYVFTWUVtV0lzWVh3azIzQ05BbGdHeC9vQ2Fl?=
 =?utf-8?B?SldDVUVQNkZ6VFR3WTc4Y0g1dkh1eUxXcUhjSFcxWUpHeXNnQVNKRm5iR1Rq?=
 =?utf-8?B?QjRkM3lZQnUwWUZjOC9mT3F1WHdiNkcxRFZLTWZKMXEzU3ovdlkzR3d2TDhw?=
 =?utf-8?B?N0Q1TllqMWpWSit1YmdGUHNIRVFYUmhuL0x5Vm5wUS8rYkFZRzA4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80726fcb-c4ea-4842-e03b-08dec175e2b2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:41:59.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKzTgGDmuQh1+Hdj9LUnvFzZd6o9NC5uDENJVj6pRuZ5D8dvXnR5iLaBg7RzdVfk8TZETHICaJE3Sq0yY8xr+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

Ping ...

On 2026-05-27 13:59, Eric Huang wrote:
> since gfx 9.4.3 HW is calculating accumulated activity counter
> per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
> sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
> will still keep the way to read from memory at rptr+8.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 26 +++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  1 +
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 18 +++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 15 ++++++++++-
>   drivers/gpu/drm/amd/include/v9_structs.h      |  4 +--
>   5 files changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4c2378bbdc95..1a69091aa695 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1064,8 +1064,14 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> +			retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> +							 &sdma_val);
> +		else
> +			retval = mqd_mgr->read_sdma_counter ?
> +				 mqd_mgr->read_sdma_counter(q->mqd, &sdma_val) :
> +				 0;
> +
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
> @@ -2689,7 +2695,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   				struct queue *q)
>   {
>   	int retval;
> -	struct mqd_manager *mqd_mgr;
> +	struct mqd_manager *mqd_mgr =
> +		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>   	uint64_t sdma_val = 0;
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct device *dev = dqm->dev->adev->dev;
> @@ -2697,8 +2704,14 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> +			retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> +					                 &sdma_val);
> +		else
> +			retval = mqd_mgr->read_sdma_counter ?
> +				 mqd_mgr->read_sdma_counter(q->mqd, &sdma_val) :
> +				 0;
> +
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
> @@ -2724,9 +2737,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   
>   	}
>   
> -	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> -			q->properties.type)];
> -
>   	deallocate_doorbell(qpd, q);
>   
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 06ca6235ff1b..7d3b801ea6e3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -123,6 +123,7 @@ struct mqd_manager {
>   	bool (*check_preemption_failed)(struct mqd_manager *mm, void *mqd);
>   	uint64_t (*mqd_stride)(struct mqd_manager *mm,
>   				struct queue_properties *p);
> +	int (*read_sdma_counter)(void *mqd, uint64_t *val);
>   
>   	struct mutex	mqd_mutex;
>   	struct kfd_node	*dev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index a04102fd2fb7..fe3a676d734f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -959,6 +959,23 @@ static int get_wave_state_v9_4_3(struct mqd_manager *mm, void *mqd,
>   	return err;
>   }
>   
> +static int read_sdma_counter(void *mqd, uint64_t *val)
> +{
> +	struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
> +
> +	if (!m)
> +		return -EINVAL;
> +
> +	/* Since GC 9.4.3 sdma queue activity accumulated
> +	 * counter is saved/restored in MQD by CPFW when
> +	 * queue is unmapped/mapped.
> +	 */
> +	*val = ((uint64_t)m->sdmax_rlcx_utilization_hi << 32) |
> +		m->sdmax_rlcx_utilization_lo;
> +
> +	return 0;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   static int debugfs_show_mqd(struct seq_file *m, void *data)
> @@ -1072,6 +1089,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   		mqd->restore_mqd = restore_mqd_sdma;
>   		mqd->mqd_size = sizeof(struct v9_sdma_mqd);
>   		mqd->mqd_stride = kfd_mqd_stride;
> +		mqd->read_sdma_counter = read_sdma_counter;
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 419bb8086ccd..270f253213e4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -91,6 +91,7 @@ struct kfd_sdma_activity_handler_workarea {
>   
>   struct temp_sdma_queue_list {
>   	uint64_t __user *rptr;
> +	void *mqd;
>   	uint64_t sdma_val;
>   	unsigned int queue_id;
>   	struct list_head list;
> @@ -108,6 +109,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   	int ret = 0;
>   	struct temp_sdma_queue_list sdma_q_list;
>   	struct temp_sdma_queue_list *sdma_q, *next;
> +	struct mqd_manager *mqd_mgr;
>   
>   	workarea = container_of(work, struct kfd_sdma_activity_handler_workarea,
>   				sdma_activity_work);
> @@ -119,6 +121,9 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   	qpd = &pdd->qpd;
>   	if (!dqm || !qpd)
>   		return;
> +
> +	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA];
> +
>   	/*
>   	 * Total SDMA activity is current SDMA activity + past SDMA activity
>   	 * Past SDMA count is stored in pdd.
> @@ -161,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   
>   		INIT_LIST_HEAD(&sdma_q->list);
>   		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
> +		sdma_q->mqd = q->mqd;
>   		sdma_q->queue_id = q->properties.queue_id;
>   		list_add_tail(&sdma_q->list, &sdma_q_list.list);
>   	}
> @@ -189,7 +195,14 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   
>   	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>   		val = 0;
> -		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +
> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
> +			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +		else
> +			ret = mqd_mgr->read_sdma_counter ?
> +			      mqd_mgr->read_sdma_counter(sdma_q->mqd, &val) :
> +			      0;
> +
>   		if (ret) {
>   			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
>   				 sdma_q->queue_id);
> diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
> index a2f81b9c38af..e0d387f08576 100644
> --- a/drivers/gpu/drm/amd/include/v9_structs.h
> +++ b/drivers/gpu/drm/amd/include/v9_structs.h
> @@ -69,8 +69,8 @@ struct v9_sdma_mqd {
>   	uint32_t sdmax_rlcx_midcmd_cntl;
>   	uint32_t reserved_42;
>   	uint32_t reserved_43;
> -	uint32_t reserved_44;
> -	uint32_t reserved_45;
> +	uint32_t sdmax_rlcx_utilization_lo;
> +	uint32_t sdmax_rlcx_utilization_hi;
>   	uint32_t reserved_46;
>   	uint32_t reserved_47;
>   	uint32_t reserved_48;


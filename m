Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31861F01823
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 10:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCD310ECC5;
	Fri,  6 Mar 2026 10:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJrZjoOg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF5310ECC5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 10:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omuQ/rzom1Gbfqo/PVUfRCMFxIFvdUcKmdYKH2uk4SUHebD7KKVEsEB3+D09Wa7RlWPlhSp9m1wT/J+RzXcyWu4jshogIzDqPWXnhv8+LXVH7PTu4L8bNfQMYww/3fapwSwSyyRo9ZKXynM6LHLIXb/Go4supluk0MYFc/cJPGu7wAfqA+tsDxgmflw5Bn5InFe6n/t38giJkiLlGYiQXE/epw/y0DNZ84spSkH2qzIGXdjR2q0B+nVSm6BRAeFyq2HiWEKX1Jo7yVwt66f7zLptQVcMXRvEZog0w8hhS/ErKl4RuJxfi/42qbhnp8BmLQuwXmtRAk0KDyMeQhewMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7caEkbsQHgHcMLtxVG8tpxvf3RxOsUaIp0a54jILECk=;
 b=pjwn6FShDwaCGbyMelNR6frWinuYZQ9D+1HVnfiKnhITunhoyHATKPWIkZYBDyAZOrByLl8oGBKor2LW8PPrQkBgECDQZL8LHZFNhS8hlIjLsSZTtjuJgUEEh+yEQ7gia62/nV7AwhGrfTcV/aBhaZCk9uO1ZyAVoSNehUMBZVY+BmxGkQ5i4YBsDAc5F2YODY1fr1rzfeuFfhB15v/CsXzH9831z58R23V+ErZDvdfc/mMQkshMjLxUVxon87P4nVRVHQ9VOvQA2AJY55ns105I74Obvd1ZQi6msfP99Rqyey8f1VUWMWt6pVPFl7SzW/zm2NjZt5YXpmUfrePL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7caEkbsQHgHcMLtxVG8tpxvf3RxOsUaIp0a54jILECk=;
 b=HJrZjoOgmPATlq75Mza5Bp035zyNVSodbKXOiPIwcr820nQ9hBt9EOIzJ/uqQ35qj58r4JCJzL7+bKxKrADkeot57ynVKaMqBV1FenkkwCt0WfgFfdnn95MrjhaWV5Q6dxXwBQhs41zNSDYHVjHM12BWp0+Cp2RAz0wY38yJEnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 10:13:43 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 10:13:43 +0000
Message-ID: <f52c4c60-8b20-490b-8706-c54d610784e1@amd.com>
Date: Fri, 6 Mar 2026 15:43:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] drm/amdgpu/userq: declutter the code with goto
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306080417.1798029-1-sunil.khatri@amd.com>
 <20260306080417.1798029-2-sunil.khatri@amd.com>
 <f7555f2e-4ae1-4127-8d82-393bc6c0205f@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <f7555f2e-4ae1-4127-8d82-393bc6c0205f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0066.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d7b69f-4846-4a16-67d1-08de7b690b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: gwZKmfipeuDBi09NegG51AI0ZdyjFp5N1ShyhiaOnt6SBwcC8b9VWzmAQSAfdyS/g0KbvnVBMXPVqS/8IVWVYd3cPekZBFMw7/hmHpqEgOFAmhX6ifH2jOutoV9t8D2uG7xeUH8LjF/Q+R/KOU7pS55sz6zb7EbGLjkKqAB8UHuIo0j8mLKWEglLvyUlu0gTpsNP0gcNQczCAM6IwJ9E5NuAm6Sf4spoATMIlN9s+O/xNdKxIzOcBQPsAoyUWMMmjyGBBvfOJhiuw76aYUnyvKEH8E/1GBuKvpn9E9AzEIH4PViUrBPfhxFRdSgsNsQNgVHepSstJlsNCxAOJMpZwqJw9h5zMu9N6scVMZr9yLXzzyVLM9uuu47Ni2SS+bmUwCwAU2f56NhKd/xYnxSyNVsYX7O9StStDd8qEusEZbda1z/sNrpfyibirfCjeCVtRRUpN7twbCLiwaK6+ZagKzyLZdHMmbVbVwKUcHJEhCvIJzm7fHbP36VUPC68D487lOBa1X8BUQCXc0yP3ZUsG9m4Kf7ZfDTOZUvs6kRNUkBFEyDH+HAFDOIYySRUHJj+maToJ+Ax28kiijSso32bmRaogMpR8uGrrRTWjRvWW8j+XtZNW0Cfc49IHHuqg1xqx+ShRvzP6U+XAqgA3miJNUWU8FvwgLFBE2PzUiqL/ezAGaFEfbaX8RzM+0ASZy7eaNLH5EUSyoGfcVUB9nS6sUUONb34HPY5QJFURrny4N8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJGOFM4bmEzS2NPb3p6cHdxZmlaaEFUSGowV2VVSTl4b0MvakFkTjR0WnhX?=
 =?utf-8?B?TjVlRHBTODhxa0xxRjZoTCt6c2NwOVFqV25aOU1WR0F2Z1VMMnIwM1NWU3Rx?=
 =?utf-8?B?WCtKZG1VVGFhZS9kTE5JZHpiN3d2RWwxOEhCT0p3MlhxTmM1Uno5UTVwR2Zi?=
 =?utf-8?B?V0FvQlQrSTY5VkZ1UllYQ1AxbEFPM0RjaGp6dEM3UGl5dlBhS3J6a3RwZ3Nm?=
 =?utf-8?B?eEVaY29DbXBVQ20vNllBRitXWW1zWWhJZGlwYWxucUlqUkNKcEY3UEhubkUr?=
 =?utf-8?B?cXl0Y2Zma3pxRDYwemd3cnpQMWdwKzVaekhza2V3Y21NcWgzTDI4TkF3dW1S?=
 =?utf-8?B?c2tWSFd0UkhHMEF1ZURjYUl6UGpNZjJYY3FMcllTY1VNYzJYeE5hUFRaeStC?=
 =?utf-8?B?RGtweDdaUUVHb2xKSkc2UnZOanF3LzNPOEt4QzV5anZXRnRTcW9IS1dLNThQ?=
 =?utf-8?B?Y3k5VUFSdUx1Z2F5N1F6b2ZJbks0T1ZCT2NYWVZGUVpNeHV1QzhpQ0l0bjFV?=
 =?utf-8?B?MVY4VlZwS0xiaXZvZXJEaFNGMEhmTjhhNXc0OWhCQWFSeHZudHE2b1lBYjFy?=
 =?utf-8?B?UXRPVXRFdzBWbmtqVWNFMTNYaHgwZGN4TTVkekxTajhRVWJJL3ZCcDhEZWFH?=
 =?utf-8?B?c3FmUlZXSkc0N3RBeTR0amZVYUFOTnlCQlVjMDNVczdocFRJb3ZPdEJKQjVq?=
 =?utf-8?B?L0M2ZzBYaWZ6Qkl2NndVY2tpYVRoZi9ITmhkNGF2VUFNa241YXFKYlBtdXlt?=
 =?utf-8?B?VHVLQjU3dXlCVGJxc1ZKOEVlQm4wWUMzRjI5bGZCQnFCckhTdmttdUttSE5x?=
 =?utf-8?B?QkdSKy9pdEg3aDQ4eklUQjYxNlpjVTVUU0R1UjNTWm4veVB1eHpvNzY4SGNx?=
 =?utf-8?B?TXVwS05JcUEwTXJsb0lhQTNoajVFbEZ1OGhBQW1Xb2p6eE5LS3dOSmVydTIx?=
 =?utf-8?B?SVp3ZWt3REs1WUVIVitrOVhvUndQYitWMEczbHI1R1k2TXM0cDZOUHEwTkVq?=
 =?utf-8?B?OTZic0JsWVdMdC8wenVQVk15V1hEZ0x4TU9DbXBRMUpkcXVaMVp0YVg5cXVy?=
 =?utf-8?B?SW9zN2RPNGZMUytPR3RXbHQ2cWFnWDE4NTVxVzM3NHNNckNub0ZNaUg2ZENZ?=
 =?utf-8?B?Y1p4alVvNmcrR3lQeXpaYVo1MkZwOTYrL0hTTWFtelNEdkNGM0VNUWFCcjlr?=
 =?utf-8?B?Z3lsTTdYa0NETGpxaDdZVmpycVpGY1hZZTBaRFNuRncrWEsxWWFBTzR5a0Z6?=
 =?utf-8?B?NlA2YXJIODVONnVvYUZoZWlQVElXZ2NUWlJKZ1pFNmFtYlFzT1N6V0FOaFpO?=
 =?utf-8?B?dkgxbGxwZWlFQ0pkSXB0a2Ridk54RUJmK01uZnFwUkR1WEx1bVkveUtMQ3g4?=
 =?utf-8?B?Y2FLT2J1NlB2YW9DS2JwVjR2VEFhOHppaHFPNWIrakNxamtRc1FvTEF2MnJZ?=
 =?utf-8?B?QWJiR3hsTWtoTWRtbmhqZUdlZ3lqRDh6eEZQQ0xjTTM5TDZOZ0JFcDdpa1Qx?=
 =?utf-8?B?N0NYWnRPSUFaL204bTZwV3pVbmViU0Q3ays5eGNIN2pmRmJRbSszTHcyUENR?=
 =?utf-8?B?aGVhUXJVTU12N0hXU3lFcGtCamhDaCtOUUxIOVpJVXZ0NUkrdDFKRzVXaGg2?=
 =?utf-8?B?YXVXNU1COTF3Y2EzUGZlM09oZnBlQklsNnQyZXZkcXNjaUpVcjB4YWRtSzJw?=
 =?utf-8?B?bEdVWnZqS2E1NmJnSGlsMlVhV0lrcnd1RDVqVnhCNnQ0SWdJNC9MN05wRFpW?=
 =?utf-8?B?b0lVNVhrNnY0WkRMRlp5YnlRL1BpTVBWY0l5VU5GWWI2OVNMNTBrSmVzcG0y?=
 =?utf-8?B?VjMyMEo3d2k3andENUxSNkRMZis2ajBFU3ZmN1FXNFRJc2ptOG5uU1Z1dlph?=
 =?utf-8?B?eWJRUUVROTdGaWxEa0x2ckVMVXEvdlpvSFNUNTJBcWJhaWZucHRsYWNlSzRG?=
 =?utf-8?B?cVk1M1hOa1NydXZKMGRJbDRjNm9kbVFLSnhqNGI1dWxkQlhpV0VNQUdEMk9k?=
 =?utf-8?B?Z3o0SHowZGt3d0JIdDZNVFlsVENRdFQ0M1UyTEtSWGt5ZWRJV25qejRmaGZ2?=
 =?utf-8?B?bm03WVQvWDR4dUt2UUxZR20wbnRTVmRNUlJJR2hzWHVoSXVjWHNTZ2FJbUl0?=
 =?utf-8?B?NVVuK1l6SE5kWFVkWEZxelhEdVFCWnNpMS9EWlZSYk0yK212K1VoUkw0cmlJ?=
 =?utf-8?B?WStKdlBNMFVXVWFBekN4cVZIZkFwSk5FaXNoN0k4Qlhva1ppdkxIeHNNc1J3?=
 =?utf-8?B?UThuM2dYNVo2QnJ5bFg4bEpFUHMzYjR1RnRCdC9NdWlJelVXQm1KYk9pVDZt?=
 =?utf-8?B?MDIyVjJxNU9UWHExdUtTTXFYemlteHFHd2pFL2pFU1ZMN0JWdEpvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d7b69f-4846-4a16-67d1-08de7b690b8a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 10:13:43.2448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXxjQPbyNnEe3gV8YKsPE01FJwoeM3MC0barEwd2gSezBdqF9pVDthTZIUd/TedXsy1MNFKuIt4JGhg+iaEOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
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


On 06-03-2026 02:54 pm, Christian König wrote:
>
> On 3/6/26 09:04, Sunil Khatri wrote:
>> Clean up the amdgpu_userq_create function clean up in
>> failure condition using goto method. This avoid replication
>> of cleanup for every failure conditon.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 ++++++++++-------------
>>   1 file changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 937403beacdc..115f294ae8da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -818,17 +818,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>>   		r = -EINVAL;
>> -		kfree(queue);
>> -		goto unlock;
>> +		goto free_queue;
>>   	}
>>   
>>   	/* Convert relative doorbell offset into absolute doorbell index */
>>   	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>>   	if (index == (uint64_t)-EINVAL) {
>>   		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>> -		kfree(queue);
>>   		r = -EINVAL;
>> -		goto unlock;
>> +		goto free_queue;
>>   	}
>>   
>>   	queue->doorbell_index = index;
>> @@ -836,15 +834,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
>> -		goto unlock;
>> +		goto free_queue;
>>   	}
>>   
>>   	r = uq_funcs->mqd_create(queue, &args->in);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
>> -		amdgpu_userq_fence_driver_free(queue);
>> -		kfree(queue);
>> -		goto unlock;
>> +		goto clean_fence_driver;
>>   	}
>>   
>>   	/* don't map the queue if scheduling is halted */
>> @@ -858,10 +854,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		r = amdgpu_userq_map_helper(queue);
>>   		if (r) {
>>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>> -			uq_funcs->mqd_destroy(queue);
>> -			amdgpu_userq_fence_driver_free(queue);
>> -			kfree(queue);
>> -			goto unlock;
>> +			goto clean_mqd;
>>   		}
>>   	}
>>   
>> @@ -877,12 +870,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		if (!skip_map_queue)
>>   			amdgpu_userq_unmap_helper(queue);
>>   
>> -		uq_funcs->mqd_destroy(queue);
>> -		amdgpu_userq_fence_driver_free(queue);
>> -		kfree(queue);
>> -		r = -ENOMEM;
>>   		up_read(&adev->reset_domain->sem);
>> -		goto unlock;
>> +		r = -ENOMEM;
>> +		goto clean_mqd;
>>   	}
>>   
>>   	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>> @@ -891,11 +881,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		if (!skip_map_queue)
>>   			amdgpu_userq_unmap_helper(queue);
>>   
>> -		uq_funcs->mqd_destroy(queue);
>> -		amdgpu_userq_fence_driver_free(queue);
>> -		kfree(queue);
>>   		up_read(&adev->reset_domain->sem);
>> -		goto unlock;
>> +		goto clean_mqd;
>>   	}
>>   	up_read(&adev->reset_domain->sem);
>>   
>> @@ -911,7 +898,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   
>>   	args->out.queue_id = qid;
>>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>> +	mutex_unlock(&uq_mgr->userq_mutex);
>> +	return 0;
>>   
>> +clean_mqd:
>> +	uq_funcs->mqd_destroy(queue);
> Unlocking the reset domain needs to come after that here.

Sure, i thought we dont need to hold that actually during clean up but 
we are doing that.

Regards
Sunil Khatri

>
> Apart from that looks good to me.
>
> Christian.
>
>> +clean_fence_driver:
>> +	amdgpu_userq_fence_driver_free(queue);
>> +free_queue:
>> +	kfree(queue);
>>   unlock:
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>>   

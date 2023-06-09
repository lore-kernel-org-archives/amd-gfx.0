Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B3BC7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 05:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195E910E0D7;
	Fri,  9 Jun 2023 05:47:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100B510E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 05:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYbLwiFr62TcOYBOAzDudFAlMp79TRvSPpjR6wv5wVIjjGbGXHqErIQTTHeWd+dAC7k1fNW8nA/TXCJlMXFS0gij52R69A8+IoE0CveTyX9HOYhNQQnF2TijpyRlu2wTH5xqr3skP6sIkyHSpjV4EKDb/XjmE6GAP+edJNofbGrWAPeOtKa/j34tgJqSvaiVkc+leYQQGpkeB55I9dyhC0scGtaJnMbnZS59vsftMPAolILUNIlMNadVOn/5My8Ghq2o7ti+r0l/64CZlWfuc9Suaifm07tFBVd61FxFjWFBncAzKPQ1UMq4IHsOr7siXbRtIsjLV9Tk7944hF/D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMMGUqyFdL/G4bJbYHgKgF4+FPDN/pZhqhS7egrQzIY=;
 b=TNQ0Y6CFxJrL4DNND+NEVj6JS46YGS/tUZH8BD3qC2pepZoHtJ/zbvzos3jqqvv1svIMdAnA1LWh7UYbXIJMIAIzFOqu3VJfUIkgmLqy3KW8NVvCRoB2FRVsiDIYDgu2gGOEixOWKhhiobKtOBbwNa0cH7UZExqUpDgCtAKzqpHHbZPbkDOAXb2pp6W2gM+UXeTQ6LoNY06wvoRq42Wf8FPSdLFvv1KI2qVvWQDG3wm0xrf92pue6Ore91MYaa8+HZosHup+nwC6cEcdufY80FKHqZtCZ6XtBMrfnse5tj4yaNBY065mmFbED2jjI5T54kvzz27yumsmpJGiMKxRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMMGUqyFdL/G4bJbYHgKgF4+FPDN/pZhqhS7egrQzIY=;
 b=grbo+cpnanNnIhgEBe8Ou/IYY1QRmAU2wSWulUqTuWastqr/uYifsSAfQ/7JhmO+2cv1oXAoV/1C9v7KPqEDw0dGBikIvQVpEL3ruBahiDw7Cs/MM6Idd21sKtZTplQIWtHjwLVvz+Zb5R/N7fKSFRiKzDPOPawZB1CgHyAxZ4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 05:46:59 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff%4]) with mapi id 15.20.6455.024; Fri, 9 Jun 2023
 05:46:58 +0000
Message-ID: <f9173e8b-77ae-9d68-b292-7c3ea52d1ee4@amd.com>
Date: Fri, 9 Jun 2023 07:46:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Raname DRM schedulers in amdgpu TTM
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230607152652.320064-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230607152652.320064-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|CH0PR12MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: c5702e36-4e7f-4aa6-b998-08db68acf07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDVjJvZa5TbACMZO3pOUaD25e4RBaH+7nUVRT0YZNMm/XZ1iWIqJ3DHMeMEK3OcoffKtTZ7hYYR3bwL28FQaPOdGq7b4jhLkCUTfKqVGI3pS78x74DH6JmtUpz9CKN6AyFEG8/F6G7t8v93XDLwDby9Esc9vxLFlHDZobtWYSoaut1aX8zjJxDa+9gpa333T3Z8zsKFtwjB/3EJHFi2UCoSz1uB+dNM8b8ei/QBX/EmdLnO2vuwK23hV1ulOXV/rUyvNZlw346zmIAruV12Dlcwa7Q3bKfeFpmlZ+UEIzfxPtxvcz7IIRa8IScMGHh1HzRQXJSxhkQ8FjAP+Qg1M4vRSympy4z1WYBnsmM6Dz8RaYoCDNWBhrbz7Q+vBrL08W1JkMLt0u3Idgtt7GekdmKwbsMbPINA6mOqSiNk+937fKXVYSjvv5os8mo+YTejzJpJ1Zmb7XtM0naoHK+gDrbIjzyLmCHV3uCey4pNSKi38Y1TgjraRNRRDLI8Knq6Rw6ibyqTQvkhIJrfmmXcqcdfTxp8e84L4veqS3PbXqO2Eg4xGzrhMDf8RMDvxdt0GNdW9+AsXtoBJCM5dYZ31siFg+FYxNqkuGRMggAEgAF/ymWJ0F25/y7TwmxYhmjVSO92cg5LMTUIV0lGOBVBvKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(5660300002)(8676002)(8936002)(316002)(66476007)(4326008)(66946007)(66556008)(41300700001)(31686004)(2906002)(478600001)(38100700002)(86362001)(31696002)(6506007)(6512007)(186003)(36756003)(6486002)(2616005)(83380400001)(6666004)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODVrQXQwaHJHaE9aYXh1TzNDV21QOUQ5VjQ1cVpDYjJUb2ViU1o2RktuVkRl?=
 =?utf-8?B?V2VuYS90dEd0RDUxM3VaUlJ6MTltWlVRbFpWbklIbGhYNDlTZkFSOUtweE5T?=
 =?utf-8?B?MFVENmx3N2dTRnVxRmQyS3M2cE9JQkpoTG1abDNDTlRVaTBGWDBoSDhKK1Ba?=
 =?utf-8?B?T1dOVGs4cDVkRUJoa29GeXN5V1NTUnVwL3IxNjE0SytwV1Z6QnNyZlZmK1Z6?=
 =?utf-8?B?ZUV2dXJrVk10TmRtdEFiSDZDSEJydDFzL0FyUTQ3d0lDYTRYVzNZMVBiOWdn?=
 =?utf-8?B?aXhEUC95ZHRpeVNIaEo2dzExZjhmdFc2enhTa1JuaWVrUlhUWmpTYk8xS0JS?=
 =?utf-8?B?UUl0R3VwMWtWODdxZmRrUzNvL3lGbGUzZVg0VWVWejd4QjIybkg5QkUyMkRm?=
 =?utf-8?B?M3J3NnRwMDZSOUR4enZWUGJWTzQzSU1yU0w0R0NOSTJ2eXBFRTFSNjN5bXFy?=
 =?utf-8?B?TzJPSlprMkpGenVGZFFlczF4bFBZR2M1S1NPclRkTEpra0pIMjc3S1NKbVJa?=
 =?utf-8?B?SDRBdk14V2haeVp6Qm43UzdSN1FheDZuZTU4Y3JUSkR6SEU3RnR2cmNaZHdW?=
 =?utf-8?B?L3creDJuZ1hzOU5VRVhMM2dNbmdGdlE5NS9Iamx3R29XL3JsbWtwOEZ5aERz?=
 =?utf-8?B?Q3NpWkNWdTh3RW43dTRzWk1vNWJGT3BNcEtrOFd5bThGUk1CUSttYjAzMXUr?=
 =?utf-8?B?ZkNPYi96ZUxqR3oycG0raFR1WXdPRFpZSnZGYmJwRlQ4OGZQUjUxa1VTUTdI?=
 =?utf-8?B?SmNCcnBqRDJpMjNYWDVlQ0p6N2w0RFkreUtCZmxVb2ZBTjRqMENjc0R4UHJP?=
 =?utf-8?B?Z1VRTSt4aDZRNzFONGMwbWhKcFNqNmM1RHEvTjhjRmlwNmlTdHJpVDFwYjBw?=
 =?utf-8?B?a0FKWkt3ZnByWi9GZW85RElocHJEVFpnT2VkbUFwMmpLVWpHeTJLdUtKSDN5?=
 =?utf-8?B?RVFKTmRONE42azlmMTBTZ3diQ05hZHpWNVV3VEtidEZzTHhTVUZHQ3ZzcEo5?=
 =?utf-8?B?WktodklPeTBnMXU5WldObHBUTGt3R28vbFhieTJXeUZ5N2JNeTBrSzZzdmpO?=
 =?utf-8?B?d2M4cDJqN1ZDZmVXcExxSUViTmxJRGpzdGlXOEZ4OVBjanNWTHpISHUyTHVk?=
 =?utf-8?B?ODZsZFR3MjZ3WlNHay8rU3Nnb21CUG5PeXNZS1VmSmhtUGJhcWcyWkpnUTRD?=
 =?utf-8?B?RXRPM3N1OWdnK1NEaUxuUU5Gdm9tSmlXM29iQXNPVThLNkVOb2FsTXh5d2ZS?=
 =?utf-8?B?UTM2anVHenN2NVdycGVBOG9Fc3F6QzBPc0V4MjZmTXBhRXM4ZktWSEFMM1JP?=
 =?utf-8?B?YW12alh3SFQrN3hBdWJhREJuOUdMSnV0V2h5WHh3OE82WnBSbUx2ckM5U3hT?=
 =?utf-8?B?REhvVWI5eHc4a2MxZHllcjhkbFVRS2FVV2krNzF1MEFpVERXc3UrQVBTaklL?=
 =?utf-8?B?dmVPNzJROG9RYlNWYUdiMjU5cHVIR1l5dWdRTlYwSWh5V2pFc3NnMnM2c3pk?=
 =?utf-8?B?c1ZhemJvdzRwQnBWclViaDJJeWJPQ0xkUlRDMGlGRTJYL0Q0dTdVWElPTDZq?=
 =?utf-8?B?cGYzdXQ1dXo3dlNoQmFIMmtEaHFUa05wc1NIdEdVMFlZNXNWT2FqUzBhWnBB?=
 =?utf-8?B?TFpmbEVwSUlMY0YyQWl1aFh0d0FxN2VtOHhUNmgrNldRTitxWnlXRUFqbmZ2?=
 =?utf-8?B?cHVKMndWbEtkZTljb1BBNGozN3J4M0xMa0puZnN0dG9ycEc5NGdvOHpUMTlq?=
 =?utf-8?B?czBhSHBIVzRHdFJ2SFdhREdTaU9KdDlPZGR0VTUwbU1vejF5UDkvWDJLUGtx?=
 =?utf-8?B?OGMzRU9waFk1Z3pXUWVBVFdMK3JSM2NpTGZaTnI5a3lnbGFjSkFEaE96Qnpr?=
 =?utf-8?B?VUI0bmIwRW9icnpWM1JubktZNTVWbjFaOWRGcHUvWDJZOXJucWFMTUNIbVlP?=
 =?utf-8?B?L1ZtYzZncTVZTmZjMm9xWXBmNVp6VEg1V29QRGo3eU42WmNZQi9RRE9YLzM2?=
 =?utf-8?B?eHozWkF4OXFFMlV6aUJkWkVVL0Rtb01RSDkzT1lyU1Vvbjl4RDc5aE5MbnU4?=
 =?utf-8?B?Z3V0NHYvRkgyeTZCQjRPblU3bFg0dTRlZUZqMzkySVh6UGlZMVE3enhndHFy?=
 =?utf-8?B?ZkEwbjlraEpwd2VZYzFHTVlJZVR4SDN2UWZ4RG5GSUhqREhlVjJRTnE3enJF?=
 =?utf-8?Q?jzdLrf90a1M5vE4CUUnTbZYJERNSc7sFAiAgcg4PPk+Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5702e36-4e7f-4aa6-b998-08db68acf07a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 05:46:58.4127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhb7ttpglxMDRi6aFk7fUU79L+pQXrZTyVc1KedQJLpK2l9PoTzkOGeSru2bS87k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.06.23 um 17:26 schrieb Mukul Joshi:
> Rename mman.entity to mman.high_pr to make the distinction
> clearer that this is a high priority scheduler. Similarly,
> rename the recently added mman.delayed to mman.low_pr to
> make it clear it is a low priority scheduler.
> No functional change in this patch.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 18 +++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
>   4 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8884c043cf76..8a55554ed69a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -228,7 +228,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>   	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>   	num_bytes = num_pages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   
> -	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
> +	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4 + num_bytes,
>   				     AMDGPU_IB_POOL_DELAYED, &job);
> @@ -1460,7 +1460,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   		memcpy(adev->mman.sdma_access_ptr, buf, len);
>   
>   	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> -	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
> +	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
>   				     &job);
> @@ -2036,7 +2036,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   
>   		ring = adev->mman.buffer_funcs_ring;
>   		sched = &ring->sched;
> -		r = drm_sched_entity_init(&adev->mman.entity,
> +		r = drm_sched_entity_init(&adev->mman.high_pr,
>   					  DRM_SCHED_PRIORITY_KERNEL, &sched,
>   					  1, NULL);
>   		if (r) {
> @@ -2045,7 +2045,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   			return;
>   		}
>   
> -		r = drm_sched_entity_init(&adev->mman.delayed,
> +		r = drm_sched_entity_init(&adev->mman.low_pr,
>   					  DRM_SCHED_PRIORITY_NORMAL, &sched,
>   					  1, NULL);
>   		if (r) {
> @@ -2054,8 +2054,8 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   			goto error_free_entity;
>   		}
>   	} else {
> -		drm_sched_entity_destroy(&adev->mman.entity);
> -		drm_sched_entity_destroy(&adev->mman.delayed);
> +		drm_sched_entity_destroy(&adev->mman.high_pr);
> +		drm_sched_entity_destroy(&adev->mman.low_pr);
>   		dma_fence_put(man->move);
>   		man->move = NULL;
>   	}
> @@ -2071,7 +2071,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   	return;
>   
>   error_free_entity:
> -	drm_sched_entity_destroy(&adev->mman.entity);
> +	drm_sched_entity_destroy(&adev->mman.high_pr);
>   }
>   
>   static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
> @@ -2086,8 +2086,8 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>   		AMDGPU_IB_POOL_DIRECT :
>   		AMDGPU_IB_POOL_DELAYED;
>   	int r;
> -	struct drm_sched_entity *entity = delayed ? &adev->mman.delayed :
> -						    &adev->mman.entity;
> +	struct drm_sched_entity *entity = delayed ? &adev->mman.low_pr :
> +						    &adev->mman.high_pr;
>   	r = amdgpu_job_alloc_with_ib(adev, entity,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4, pool, job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index e82b1edee7a4..6d0d66e40db9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -59,10 +59,10 @@ struct amdgpu_mman {
>   	bool					buffer_funcs_enabled;
>   
>   	struct mutex				gtt_window_lock;
> -	/* Scheduler entity for buffer moves */
> -	struct drm_sched_entity			entity;
> -	/* Scheduler entity for VRAM clearing */
> -	struct drm_sched_entity			delayed;
> +	/* High priority scheduler entity for buffer moves */
> +	struct drm_sched_entity			high_pr;
> +	/* Low priority scheduler entity for VRAM clearing */
> +	struct drm_sched_entity			low_pr;
>   
>   	struct amdgpu_vram_mgr vram_mgr;
>   	struct amdgpu_gtt_mgr gtt_mgr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index b2e42f1b0f12..0c8a47989576 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -382,7 +382,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 * translation. Avoid this by doing the invalidation from the SDMA
>   	 * itself.
>   	 */
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>   				     &job);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 58d95fb99595..709ac885ca6d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -64,7 +64,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t npages,
>   	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>   	num_bytes = npages * 8;
>   
> -	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
> +	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4 + num_bytes,
>   				     AMDGPU_IB_POOL_DELAYED,


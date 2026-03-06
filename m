Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CFAF01814
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 09:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7892010ECC4;
	Fri,  6 Mar 2026 09:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3XhgL5jG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD11A10ECBC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 09:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ont8hrkfF00MUNBfl3ynM4blTjfcTBLCeIAIusaveuRzfFI+2xt/gZRS634MqEofWnA7eWiNEkfRvZn4Uja51ApMSXLGsHN5Tpg0cSD+LiFVR/eTHlBSvDK175xRG+/Pdadsg3wxdzS92LxDDPSNpzCzA4fAbIMcJO9WIQTFTQsKWAZMfPI1zz4/kpbilij9svH1RGxH/Bdpubbd8VVTdtwm4nTm9sOeXi8xkKRs8fhocvaH2n/pDLBkRyfvQnZu/SKRfSP6Na/mrP4SFwYp/5ShwJFXa844ky88/3B3Cl4fIvRuvrdvFJwq+OG+YThfGzIWZdgX+Wg4j2XO33H5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIvX26aR0ljRHgiIzWiprAlCd9rAaArwZ1MQyIrEyGw=;
 b=QbVb4jWJCMKD0OupmfKAmZU3suekp8PGYLEMEvjPjKNvXpCh9DlqxQvXwrNN5nt5bRtsCbSQM+mJ2wyWujDGVqDScQQRvBQe6hS8ZKHQzjqXgIAOIbGMSEZnDpPnFZPWouE1FR0EJTLOLOuxE73yCYbCPaHNo4Zkv8cWSUbV8czdMQHsrBI3bN2TAHzT6pS7MaKvCPZHfbe6KRNu5nD+Q92X+fRIZstK6vdH8fuCXb4gHAy5ZRQQSLAAgIKykgnesxu2R/fpjG6BIlHwSq19g17minLadQWKmgb1+k8gArBS148WJwTChxkN2aovQyvF6JBC8LFtcHJL6Jg8wTpk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIvX26aR0ljRHgiIzWiprAlCd9rAaArwZ1MQyIrEyGw=;
 b=3XhgL5jGqUcIUsuEeW3JGQ8+ncdcD+4DyiReO0N1g8/fwuE2zPb7RUJehpUu+sC1YvlIX89a/wkCqtb8uTngedLN+kRKVv4GBH3qJFH7OYcJeUd5VFm+snocyILGrs+t+/OutA6XIqnhnTTTJEDj7WXLeudT/iDeOSAuMSK5gYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:24:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 09:24:15 +0000
Message-ID: <f7555f2e-4ae1-4127-8d82-393bc6c0205f@amd.com>
Date: Fri, 6 Mar 2026 10:24:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] drm/amdgpu/userq: declutter the code with goto
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306080417.1798029-1-sunil.khatri@amd.com>
 <20260306080417.1798029-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306080417.1798029-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To MW5PR12MB5684.namprd12.prod.outlook.com
 (2603:10b6:303:1a1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: b7526d67-0888-4a76-0590-08de7b62220d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: lA7OacKL1AjsB4pDORcn+RWZqv2Gu9f4IxuWZkmWzkhwSYzKNeqU2yZaDlkXEpZUni/nUhaXd97Dx84ADv+R57Bc6vIb3zuQN0ZAqAeBCA+OI8ACBnR0WCXkaHhusaCZz1pyZn1HesdIO3YCnhLf14KXBH8hsy1RXQN+CL7vgsJ+ydHOejoDphNSyu0UtM6M6p7SnCZd7IX0FDTkHWIhOLGxDfSEqwF8McU+XNHwlRL1KfGDJaMq+vYFQAd4BFWRh21d7tGNXAJ/sr4KlmySEJ11++r3ZsGSH/3pMS0kXmQfnoAM2TP0TxKeGHSEGvfqbwUVHvr3MtYtzk/pSD6ktfvhj55VvKvMw6A0IGxNuoC3AjEQuP+JpTO8HVD3VsJYwqjj7vYFmHgRz86RaDO0ZoczZV6bL5F3Q+aDRiXvdyZlDaElDqIsymmj717e48+RKdEivIWYfPkVEBns22FYSHTzcVAa1ATTnSVUnEJ2Q7BZhPnMMbaZQ1Wi/8XySFNYAgOMDCwuQ2tahYFUQnTGZsk8eiVNthU+0YyUu4Fi4fAXpg2quKcAY08eY/+FgIickkm2k7yuzxbLSrcPpD3G8FOqW+ICYvDYDFDm4ws1u03yNoG1UlkMkRxE0oz+RshGDh1tTZkO6i3OXARTenPIm7apEz154yfFIMdT5sLUAmuB+fhzmldf85hjsXpAC++m/LZkR9k4hqsaTL1Omw7ty2EWRnsnTRpyVrJuHKgAQPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhhbmVGVkZjcUN0WEhQNFZYZnRhaGF3d0JOMkk0VlhmYkg4ZnpTR3dBR0tQ?=
 =?utf-8?B?YnlZS2NOeTRtdGlQd1hjc2E1K3N1ZXdyTjhuZFI4TEIra3NpMm83anF0YjNX?=
 =?utf-8?B?bXF0VEVBNUtHa29QYm1NMUhCQVlLQkhhcGZJUVJBbkMzZEFFYm9VOEdZblZU?=
 =?utf-8?B?anZwdUFBY1YzUjl4cE80TVd4am1JMUdvNkttY21zNzVoTVJxckRuY0FqRUR4?=
 =?utf-8?B?TWFDaXE3WkZyUUc5RE9wOVQxcXRnRjY5b2NmMVpSZk9NcjZ3bVFNVVdOdlJF?=
 =?utf-8?B?blBaUXMyV3pGVVowYjVwbnVhblBVRGErV0djRXVkc2RNVDgvRm5rMUo5c3Bw?=
 =?utf-8?B?YkhyMkp2VFJuenFNNmIzQ2E1UFpDM2E2SnVTMk9PcHFiTE1aczZnZDBwcWlQ?=
 =?utf-8?B?YkdSMEhCM0dMMG1ZaDFhSU9BbzIzc0JOU295Mnd3cUtGaXd6bjZVOGgzQ1lK?=
 =?utf-8?B?aWlLTnVSVFFsdlk0Y0RQUjBHaTBPdmRYNmRFREdxMTI2NnRiWUVDSGM1YTBr?=
 =?utf-8?B?cUNsNVZabmkvVTFFcEJvTVRjSGZ6RTNsK09VNFhPV1cwc1lkdTBWaTBGV2w3?=
 =?utf-8?B?V09sK01wVjBXc2lMOUxiNVl0bnB3cUd5UFRXTUlsTlhxSHgvcXY4OW5LMHMr?=
 =?utf-8?B?eDdKTTlYMHNBUVVDN05KTEg0cDYxQWFLbDJ2RDlPRk15QVNvVlhWb0d5NFFv?=
 =?utf-8?B?dDJiQm1NWVRndCtjM3lBUjdvNThxK1oyQThPZ3B6L0JaL1FBdVpuc291aHM2?=
 =?utf-8?B?dG00SnRIdDJzTUJyLzJ6USs2dWhndmlIYllkOGdDTDlhOEJNMjBKRlk3S1Jl?=
 =?utf-8?B?RjZNRkl5bUxJYjNXeUI1V3VQN3ZlUDJ3QXpXZFJuYU9udWVaOVAyMDY0eEc5?=
 =?utf-8?B?am9CUWVpM1huSFFEdlV5dzk4WVE0T3U0WHVaMVo3aWNxcGI2WTRud1Z2MnRR?=
 =?utf-8?B?VHhBT00yZ1NOYjNzT2FZaXNTT3RMSFp1cndMUEdTelVMNFlLQXpZcFdSR1lK?=
 =?utf-8?B?RG1RVk9BeXJIWWZrQzE3WjF2V2NYMERqcDBhWHJQTVgvYTJuS2k4WW0zdzBY?=
 =?utf-8?B?R0xWcnc4NjZMb2pFT2I4YXloUWJxK2FOb1Jxa2JCT1ZwWVdXYXhKYUhtUGor?=
 =?utf-8?B?bVdhaVJlUEc3cXdjbG1LQS9zU1NKUVE3dHVHZWxySTIvb0kwbWRKNmVqeHVv?=
 =?utf-8?B?cEgzS3NLejZaTWIvR055Tko5V2pOMjdVVVNGRXd4RUprdlFxTUFLVGpPN20x?=
 =?utf-8?B?b2hRSHQ3cmFBaVlsR1RsS1F2bTJSUVArSE9HWDNyYk9Qc2JiT0MzR2NSQ0RW?=
 =?utf-8?B?YkVoeTFUV0p3RjRPeGlqL0J1L21ZZ3ZJbkFsdUJiT3MvQWsyeHhkZ24vY1Jm?=
 =?utf-8?B?Qit2ZkdyYXZoanpxQjFMRTJkZ3hTSldzRjZhdVprMmZDZGlZdUxWTGdVbTRW?=
 =?utf-8?B?U0RZaVh0Znd0ME54cDB2ZitlSDlSbFpybUpacldrdUVWNC9wQStTYmR4cmFD?=
 =?utf-8?B?V1BsTEVjUjdVSkdWaWJVeDAxRnR6aEJyeWN1djc2OXBQbG4wVWtYRXJBVEJz?=
 =?utf-8?B?TFB6S05CRlRxeTNqSEsxdDRlcElrUkxXU2plUHMxR05EdmpOMVZ5bHlYVTQy?=
 =?utf-8?B?aGVQZ2JUSEVOdWVDbytVOENsVHlKallOczg4eC9IZFVzUTZSa2I1OXJEdFFI?=
 =?utf-8?B?d3Jnd3lXREdnVmhaVkJic001R04rRVdxZWZFWEkwVHpINml0ZlVhcXJrczBY?=
 =?utf-8?B?UEVDNllvWTdpb0Z5amlnSHRwaDNEaHNmQzlKaXlPV2xLZENrdWRSWjU3ZTJW?=
 =?utf-8?B?bWZtUHVtamIvRFBzZDRKOXlyRDdnc1hGdE85MDhnWUtkZlFBODhDV1llbGhX?=
 =?utf-8?B?eGJEc1FFaXAvajJCOUFFQWVyZGlnYzEwUXpPdGNNUUUwU0FVenhvcXlLaitv?=
 =?utf-8?B?RkJzbmxnSEo1czJEMHpySFJmVVFTV1FVVXJoYk8rRytIYlhtemVkL2MvbEU2?=
 =?utf-8?B?cGZRQTNKSnd0K2NHanhyem5LdkROMXlSM0tTK3ppdWNuQmR4RGp5dTVKbnk4?=
 =?utf-8?B?RThFcWZ5TEpZcDdYUG9ya0hnTmRQRE85TDA0R1F0cmJ2S3FMRVFNSWpGdG4y?=
 =?utf-8?B?YnozWFREVUtNa3J0T013T0dwa1ZGTWNjckZ1NTcwY2loZUlaaVdaOXJONGww?=
 =?utf-8?B?OVNZbHlvcUJpWGt6S1huTWUwZXF4U29ocGlpUjBmYi93OENqd2x1MkNzOXQy?=
 =?utf-8?B?Z3padUs4dUNUTnN3dFBLeU5kU2ZPdm5xcENTTFpDKzV4Vkl0eStvbzBVNUhv?=
 =?utf-8?Q?cPE/iMPkRNTsdmVK7e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7526d67-0888-4a76-0590-08de7b62220d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:15.5391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mw/UJiVKdr448LS2hMcEaWTjnD3eXUwFJTV+dp/rbm8iSKuC3NLhWE9SEZcb5cDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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



On 3/6/26 09:04, Sunil Khatri wrote:
> Clean up the amdgpu_userq_create function clean up in
> failure condition using goto method. This avoid replication
> of cleanup for every failure conditon.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 ++++++++++-------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 937403beacdc..115f294ae8da 100644
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
> @@ -858,10 +854,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
> @@ -877,12 +870,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		if (!skip_map_queue)
>  			amdgpu_userq_unmap_helper(queue);
>  
> -		uq_funcs->mqd_destroy(queue);
> -		amdgpu_userq_fence_driver_free(queue);
> -		kfree(queue);
> -		r = -ENOMEM;
>  		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> +		r = -ENOMEM;
> +		goto clean_mqd;
>  	}
>  
>  	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> @@ -891,11 +881,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		if (!skip_map_queue)
>  			amdgpu_userq_unmap_helper(queue);
>  
> -		uq_funcs->mqd_destroy(queue);
> -		amdgpu_userq_fence_driver_free(queue);
> -		kfree(queue);
>  		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> +		goto clean_mqd;
>  	}
>  	up_read(&adev->reset_domain->sem);
>  
> @@ -911,7 +898,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return 0;
>  
> +clean_mqd:
> +	uq_funcs->mqd_destroy(queue);

Unlocking the reset domain needs to come after that here.

Apart from that looks good to me.

Christian.

> +clean_fence_driver:
> +	amdgpu_userq_fence_driver_free(queue);
> +free_queue:
> +	kfree(queue);
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  


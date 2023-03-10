Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F4C6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 16:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BF210E051;
	Fri, 10 Mar 2023 16:56:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D91910E051
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 16:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtBYyj9MgmP86YOkYJLmJCsHqeX9H1rTp5560FQ9ZNOeviWZq67KfuPBge1DrZlp5FdiJBrSbBfrAnFQ2UPPXUf+mnFFr8cwLKDwMMDPvljPkJ4sFI+EXJJSu9Uinfc32l2uAk9Z9Aq+WfuLrF0dV/wxECTEuQ1NaiFL+uxQyEpXyURs2BrtxgRBFpfpZT6R7s2y9EHeAdevVS7OqQA6j0xwNAXc/IjlKmQGhs5ZxGlH7tHH68rnLywsIZM0kwAfypVwimkGec3vxC7JBGBVKg/bvpsL0yvD2NM6p4vZcgSuINDOZ/YD0Ih4mSE+YdugVMYQCCHswp8jVC+EhecxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DivHyeuT6O12RFtw2e+3N8js+Q3mdCljQJrciSLjnaU=;
 b=EztpYJNgjIlJJtP5O3JCAFvUF7I/hs2ojyPLJeiIghvkyhE1sdM6Rf891Lo33FX7DMEUaT74ThvmYTUo1eIIanIxvKT+SZZ8tsEoXJMSNhkJfu2UKMJzqbRiEsveoHUw1Vi99tkJb4D+A0OOq4juoBOWsgXLvy+VgtICFN+YmAmRwf2uR9Jc303ULoIEEbDTiTPUEoXrjkRBvj/IRJUV5Y+fCDBsOIXKVwMTKr68kFWGMK1c4tFem+I8c4B0J0FMKdil7gai5Nsy7rLaxKUNteOtPtA4EWXZTtt8uAKiGsb+9X5OGYIs2vi43Fo54vtcigEk25hwIqM74UM4SoTjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DivHyeuT6O12RFtw2e+3N8js+Q3mdCljQJrciSLjnaU=;
 b=2rxQTcw0l4scxUpt6IpJscC2rFiAfAs/XLjmTJCEjBSW2Rp6fTY+7Y+0yEk+1snGlufa0EqekGwaHtogjFH5U9mYF+JgAjmCvBX9Spgweoy3+yiHdpKkjFNsB8eZcdIumGHOJxaghOMwiCk4VBkwtqp9IXYwWwMx00VHXVjD2aI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 16:56:10 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 16:56:09 +0000
Message-ID: <2669032f-5780-6eab-d5a0-c0075109bb2c@amd.com>
Date: Fri, 10 Mar 2023 11:56:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-CA
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230309022707.4141252-1-YuBiao.Wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Force signal hw_fences that are embedded
 in non-sched jobs
In-Reply-To: <20230309022707.4141252-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0066.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::29) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c460fe1-ef96-480b-4378-08db218858dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSupJ+b0faBfegJ7htFSV0vjvu7gb59nksKdEtmkHAnPeQ55yexkSSaSX3KqXOwxlUks0fwkQHmE/YQ2oZnYq/HbroJ5Tz8UXxhKbiOH0YXl68eDoihO3SA1uxKtaSXlzos/iTnkvWHwqWco/omvrirsPzwpLBcyG2D5N+ue8PFAlp1nfbj6/bM1uP6bH7i/U9M/suVrH/T5RUtkSD7N7WgZVoMfFHiYAXW1JhZR+QCHBViKWl0AGUPA1l7t/S6a0dMaPEEn8EFwKDBbojiKF3dI12k7ADCXH7d9Z1x2LS5UJLyGy6FhskeWEZ3/hZNroIGZJHgpVxOE8k6rFqc0hVhJF19KWDcEZR9vpD+emUKeBqZkGGrKghd+9G05L28PlYA4jrRNJz+jbQso+oXKCPjrwqqpvu6NSnk1EWTADVQU5tcWaT9v8MM3EGz8rsbUcOd7j7VHKNsv3BAmz+Udi+V7Yr7bkNEAaQl65PlIAcNQN9L1cM7Xbe4yR/SsX5YfaGXqgL4NO2rgE7GY05+TRAZHq9BTHAH4dYxv6t4jGBEjOh0CAvRSezOFLjOCw/6e/SEAhGmXYuBR5gUNxLvC5On7lxypVl5Hi/Eb6HePWTRI1YO2WtMat/cvpipsmbNLJxTW6iz3SyZ+uu2eD/A5PORpmWgp3WSBkBp0/25Xi9BfZ62ZJ89U1FMnkYkellox64CZ9wc3j+2N7qQoBwGtqFmPGp9z6QQ5eqpk0lNI24Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199018)(31686004)(36756003)(478600001)(38100700002)(54906003)(316002)(6486002)(6512007)(8676002)(8936002)(2616005)(53546011)(6506007)(186003)(6666004)(55236004)(26005)(2906002)(44832011)(41300700001)(66946007)(31696002)(66476007)(4326008)(5660300002)(66556008)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBlUVhka1NleTBCNllzbmhMeW1nQzVob2ZDMzd0OXhYMWlQc1FBUWhMSVRm?=
 =?utf-8?B?SFhBa3RxNlo3ZVZMYnhSOEJhK2JlYUNVSDNhT0hUTkVrS1VibWN0VUgzcnp2?=
 =?utf-8?B?NHlpSTVXN2F1OXg0dVRxN0h4dUtxMDRxYjdCc09FYXJBZ3hDbjRBSEhOVTJa?=
 =?utf-8?B?dGF3YWtuaEtsWnpJNjJpbGhsRU4vbFdqTEhpZ2Q4bjNrV0RnbXBwK09UQ1Zw?=
 =?utf-8?B?WHUxelc4aW1qTUd0Q2x0cUY4VFFoQzdrc3FLN3FMdFhMT0h6d0pPNFBKeDVE?=
 =?utf-8?B?VkJoQ0tnWnZ2VnBTTGp6S2UxbmZ1L2xTc1ZxQVp0SDJQb0FmOXlwR0ZBZU5X?=
 =?utf-8?B?SUZjL0l0c3R0ZWEwTC9rNG90aFd5OURFbEc1TU9TWUlVbnc2QVJwS1AzMjhx?=
 =?utf-8?B?ZUpXRmlxb2orRnpFMXdQUVFyQVlFcCtXcEtpc2tKNGZyY2M0eDNja0tBYWd3?=
 =?utf-8?B?bDdNdUIybjdrakpQd3dQeEVUWDdlbkpOZVFHbnlDbExjaVhvK2c2OEs0cVZH?=
 =?utf-8?B?NWxScDlqNmd1ZWFvNW05N0lnRTFuKzBYbkl0WUVWOXZmZnJ2dGwrS3V1MEYz?=
 =?utf-8?B?MnFzeWJQMTZwZ21SdlBmWjI2a21lS1dyb2U1YmJRa2prcEFOQ1d4ZFY0QWo0?=
 =?utf-8?B?aWdUTXo2cHRja2NJSStDTHUyUjNWeFNEZjdBRHVSUW8va0RyOGVIc1FqQ0h0?=
 =?utf-8?B?dS94MDZJVTdrVklXT1NUVzRRcmNDKytzYm4vcmxobi9FdWs3TFo2SjJIeFdH?=
 =?utf-8?B?R2NEVHhWN2ZtdklnQTV5MFRKODJGd2dSMDRadUJwL2JZNUNnKzJEdVl1ODFs?=
 =?utf-8?B?UHpXQWRnVG55UENVRFZZSjZ6YUtHZGdMczZDdzdMZm1TUVBFaFJHSmRtZmRC?=
 =?utf-8?B?L0JaVzlDeGdXN25rTHJ2REVNY0RWY3A5SkFkM1VRNGFvQTJFRkhWbCs0Y3R6?=
 =?utf-8?B?VHhqREErQzdtM3RvYjJRS3FWbmlMTFQ5TTkzTVE5WnVCczRuR1ZrZTJ0eDNz?=
 =?utf-8?B?ODJyUXhuVDkzUHhGRFRHMnpvbnpJd3dIZXJybU1GSkUzMGwzRnl6RGxJV29i?=
 =?utf-8?B?WWMyT3hwQWx0ekxjQVVTMEVtYXVINFhwZGkzMjQybW9uSEgxM0t0YnlKMDc0?=
 =?utf-8?B?dXlicU1DZFFUQS8xdG1xeVRsMVcyT0tiangxTm5adFBVeXdQZjJiSXlUTkN1?=
 =?utf-8?B?MXJaT0RyckRtdVl6eGI4Z0dQRGI2Q3hrUXBxWVVtUFJkcW0wWUZQeEpqbm5h?=
 =?utf-8?B?SDBxK2ViVytEc2JCaG1OZ3NsYXNFM1pramVXQ2hnUit6SVp1K1QwbnYyck9s?=
 =?utf-8?B?NmlvK2F4T2hQN0lMRUMzNFI4Y0dlSW14eUNybzRWb210bWFlOXlVYllwblJ0?=
 =?utf-8?B?bE9TUU5najIyMmRvV2FDQW5rV1orRHRrZUVtclN6SnB0cEVXSTVxRjJMcUxj?=
 =?utf-8?B?SE5uNmFpRG56OHRFdVBsVXdwaytQeHN2b05Xcm5odjdnc3JhSWJza0c5cFdO?=
 =?utf-8?B?TXZ4VS9wN1QvVXpESkp4Zmc4MFdhSGdZMWplM2dDSUFWYUU3ZDkwdkIrN1Vm?=
 =?utf-8?B?R3Iybm16YkJKclVKNlNkanVvd0NZOGFJVTJjNGptR1k5VE5KUVZMdWpUMjlD?=
 =?utf-8?B?eHVBN04zM25adUFVeVF0RWZlYWY0MTRJUCtKZGdSbjNMMEN3UmlRR1NLRDY5?=
 =?utf-8?B?ZVM4eGJOL29nS1htUk51TWFVODBnSW1xckQraWZidng3UUV1RkV1QVZoRTFQ?=
 =?utf-8?B?blVxR0NrdnNxMlR2M0IxSWEwclRzc245T3JLL1l6MDg3alNPQ3N1d2dvbEFx?=
 =?utf-8?B?OGdWcHVKa29lWlM5VHMybXNBTG4xRmE3WDNPUnRZZ1FDY1U1bStQclJqRHIv?=
 =?utf-8?B?QkdNLzNFTFd6bXlXQzY2SXpQcmk4YndUOFVuakVOa2szWE9STjJuUCttT0xp?=
 =?utf-8?B?SUovSVRsQTJCZ29Dd090eFRuRkNIdTdna1Y4K2JvMFg5dXlTelc2MGFKVkpn?=
 =?utf-8?B?STQ0K3M5Zk9ENXB3MzExZmpIUTJ1WkdUMjlHVW5VMWxLMDYzVll1dlZPVGVu?=
 =?utf-8?B?NkVZSUl2KzZKZFJuMTJnaGVXdUNDUjBEQVhnb25YUTBuUmJlK090MUM3S3Ev?=
 =?utf-8?Q?EVgafsN04QlearSJI0SdaybJS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c460fe1-ef96-480b-4378-08db218858dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:56:09.4940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nlkl8snO1WqLVpLvauAd9gUNRb/GIbu6w/g439YJ+QnHzDZjj/cRRcfs2yife0Rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-08 21:27, YuBiao Wang wrote:
> v2: Add comments to clarify in the code.
> 
> [Why]
> For engines not supporting soft reset, i.e. VCN, there will be a failed
> ib test before mode 1 reset during asic reset. The fences in this case
> are never signaled and next time when we try to free the sa_bo, kernel
> will hang.
> 
> [How]
> During pre_asic_reset, driver will clear job fences and afterwards the
> fences' refcount will be reduced to 1. For drm_sched_jobs it will be
> released in job_free_cb, and for non-sched jobs like ib_test, it's meant
> to be released in sa_bo_free but only when the fences are signaled. So
> we have to force signal the non_sched bad job's fence during
> pre_asic_reset or the clear is not complete.
> 
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index faff4a3f96e6..ad7c5b70c35a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -673,6 +673,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>  {
>  	int i;
>  	struct dma_fence *old, **ptr;
> +	struct amdgpu_job *job;
>  
>  	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>  		ptr = &ring->fence_drv.fences[i];
> @@ -680,6 +681,13 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>  		if (old && old->ops == &amdgpu_job_fence_ops) {
>  			RCU_INIT_POINTER(*ptr, NULL);
>  			dma_fence_put(old);
> +			/* For non-sched bad job, i.e. failed ib test, we need to force
> +			 * signal it right here or we won't be able to track them in fence drv
> +			 * and they will remain unsignaled during sa_bo free.
> +			 */
> +			job = container_of(old, struct amdgpu_job, hw_fence);
> +			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> +				dma_fence_signal(old);

Conceptually, I don't mind this patch for what it does. The only thing which worries me
is this check here, !job->base.s_fence, which is used here to qualify that we
can signal the fence (and of course that the fence is not yet signalled.) We need
to audit this check to make sure that it is not overloaded to mean other things. I'll
take a look.

>  		}
>  	}
>  }

-- 
Regards,
Luben


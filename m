Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BCBC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE2210E172;
	Tue,  7 Feb 2023 07:11:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72D210E172
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfiVd+rzfad2ji5743MGsWn/7DAvSaolCUlBiRgVPhsxITPXNQsLtjFtYc4PAX6AAZD5EDPF6K5DUTXs8GTB/2slNrajuGfHmtz4BSZPFDEVJ04rijJ8u7PaVj7IggJz4aHw2d8xCv44nDELzESV15ycwt0aHK0gnOEmUITWQdIV1UOm0u7/40myWRY7rjAJBxeUT2bGpjqvk7yjSSci6tyScEkaglTdzGAzXSBE7qQmPpyAhDkpvUMORmrtY0OMBs1rGcT+ei0D06QcjR/wkQo4H+m/c26WelTLQsRb1rOcJllUn6HolNqs5XOg02re+6Lh+L3vns/T7SSWQJKE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B703womiavOfmz+U7IrgVPkBl6epM9QaH8DBkOUhSz4=;
 b=OrIbAUjll0JCWoySmBnO5JXh16ackOwJp4jRoBDGAziKMJMhsjxVmfQUGMFnsm6HFYZE8t3fXEup40zSYyc67ths0KMdjM1+d7Snh4rfejA3CLJeWAbA1JBdN/0kFg0hX1Jb+SPceKaPTYrHZbaCLj8lkb1BowgCsL4i+37Jn0szBhkoF2VKOKVQMMp7MMqkiArwQdiskV8s0jrgecx+gbnIx0/olJ4fseOi9ljtIKqH1k092LxjONLptlVbGmSuMqkOfNX3iVFHGrTy4mU/cczpifI7U4BqFMdqav+Ae4v19eiq7fC/xRgt8tyUP+UT9Ff2dqTT745tGEisY2hSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B703womiavOfmz+U7IrgVPkBl6epM9QaH8DBkOUhSz4=;
 b=A/xmTN/9UYLCpiNwlaWqb3Bcl7s0YlG8pxOLOS5O8PkE7ifnV6Z0mXArRscCDvkczBy5rhMjWj06JE6Z9rjKPcvzqR0v7Xp3PJ3uoc+5GRzFakCsM1MQHqoNfgbdjP5o3AjsQ/qUpdiZkS1yvACwFpBpq64AtWIIEYlFqkE4bhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 07:11:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 07:11:51 +0000
Message-ID: <9faed914-9292-c594-1b2d-06d98864d36b@amd.com>
Date: Tue, 7 Feb 2023 08:11:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/8] drm/amdgpu: introduce userqueue MQD handlers
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-4-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203215409.2021-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: d499105f-2186-4da6-2138-08db08da95e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCkQmKoFKL/G0ms1rt2KxWT3ur2PWtUtJy8kKXM7bmDGE8hoHZIvtL4O3nWeWopS6N8khQqWNUIKAQAvUtmTcetnFgPjk51UWD7vuAHOjmkwgu8BCbVrGWADCDdRDwwCfrJP7FHCgdSHECeXEj2mf3ROHT+RyNpLFFWyBr1HZzwc8m9yKCkQsOTJ9xCiNfLfY+2OXmWVekbpOqUe84vbTwP25o2z1w7KsiqGP2E+rQKS17QsFB+JZk7B24v7kkWVsUoIysRSoMKYH6dP8fbNOZBBy9e7citaMgRaCdN8L0dhTqpnDxMZdGRu5jbCy8MXBJawHHyMa043InWHr1DsurMQaokwDTsrqleG0URh4rj+qe4bplERR2Aj827x9FEpc5HbMCTBrQVtmisPLigMYO1jXjqFqdI8R2aDgl7W6F/CxU88F54+lhFuAR/RuFiRqQy57n2i57uu2W34n1w3IjVpj69MPxqf0bMVzl9IdzaXF7eeYSOw4QFvjgX9bIQRDnz9UJRJFihnc1YXFsj7auRq0lB1o2G9IAj6qVBCLtjgg65lYgjGu57ovM7HMsH9lyLBuW3FdhVQS09yBtX68vE1ym2VC4jMrgO8b20pRZDAv/LuprO+t2fTBzovj1gYF+P7GHiM5QVvMUXENCW2VFZ7I8OzGfL8efFXI/u5uNXY6pNoUAMuQGNYHRe/PV1qW1WnvBEUIWgO2Yrm3FPab/lACoasp8kop0OmwGuJfuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(5660300002)(8936002)(41300700001)(83380400001)(31686004)(2906002)(66476007)(66946007)(66556008)(316002)(6512007)(8676002)(26005)(186003)(4326008)(36756003)(31696002)(38100700002)(86362001)(2616005)(478600001)(6486002)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnNCRU45OHJ5Zm9mZFN4L21oRk53dEVCNXFxNTdwSmRVYlE4a0JpUmxZOXdp?=
 =?utf-8?B?K0ZNZGpZV2pyb29yQmYweDc5dG5IK2swZW9XTDNXSkw3L3dwMnJ2S0FNYndS?=
 =?utf-8?B?emkwR3hENnh5NXZheTRQeW55SVJENjh2VWFDcjM2aEJibVpmVFhuN3o3aXpv?=
 =?utf-8?B?cnhWL0M1TlpiRnI3Z2lqMUdWY3c2VTJxQUV4MnUyN0ZmaUdrLzR0V1I0UWdp?=
 =?utf-8?B?WkJKS2NiWGozNDdDZWdrcXNCMEQ5b0NsajZCcXU0bDZtRDBjR25qMnFTNzZ2?=
 =?utf-8?B?WVgzMmExeUdacHlZTjM1Y0ZGQ1YrbVJkdTBOdWtMSVhnNFFuTUswakFmc21C?=
 =?utf-8?B?WDlkRHhSYmdHaVVmNjR5QnYzYUEweFNxQWw1RlV6WVdOcUpkeDNYVkcvWFNo?=
 =?utf-8?B?UnpiclEydjUybkZOV0ZwNWhHQ0M1cWNZTWZRRFZDVTlxWEZoZ1NHTVZyYS9v?=
 =?utf-8?B?cEVUTlNhaU1VYVNOUW8wRnhMQVNBR1V1WXNrS1ExVTkrckM4WmYwenFTSDRW?=
 =?utf-8?B?RjBxakdtWG80S1Rkb2MzOUhaQWluQmhDSDluS2hQaThib0poZHJvMStQSFg2?=
 =?utf-8?B?NllrUng2cEZOZjFZWU43YXJOYnJ4em1lQW5jZlJRS1R3c3IxYk9hSFg2bzFU?=
 =?utf-8?B?S1VQdHNCcnJMT1ArYzE0Rkg0d1BjTndwN3ZLamoyOGRKUldDVUc2d2oxbUlu?=
 =?utf-8?B?ZkdwcDM3bGRNc04vVHhBZ1RndlBHVXUzbTEveUI3UEQ0aXFWQ3loOVdJTFc5?=
 =?utf-8?B?aXQvYm9oVC9kU1orc2YxdDVyNmVzQUxsaEZ2Nkxvbk9WekhpaUNuZ0lnODV1?=
 =?utf-8?B?TiszL0xjT28yWHZadkIyK3BZSjI5d2phMDBEeUxnd0h0OE9EVldtQ3lveGJE?=
 =?utf-8?B?eWFjeUxFVk9pdWVhc2U0UXI2a1Y4NjVvZllOQzQrM2ZUTE1aQktTSWZ3bEIx?=
 =?utf-8?B?clNlTEtsdllJcXdWaW51WHF0QjVyOEp0SHFUWFlyTUcxMlcrSUZ0WXpYY1l2?=
 =?utf-8?B?Skk2U1hkRW5xdjF6eXdnNy9kUUVSRU50aDJqMkZnZ3g2VzgxbzZjKzF3SS9R?=
 =?utf-8?B?dE03Z3NQazZYTmJvek9NdWtEUUtuS0hTTldBOHl3Zk5kN0xMM1VKQllHaUsw?=
 =?utf-8?B?Ykp4WGJacmxXRVJWb29KcmdrR29BWUpjZEpWcXMrZHhYRi9XRExkNGRxQUkv?=
 =?utf-8?B?VnpDK1lJSTZhRzlhL3NkZjlDWC9IcXB6K1dSUEQ1dGNDMy9la1kzcThpZ211?=
 =?utf-8?B?eEQzOXQrSlZkSzdrM0J0VkdZYzc3WFZpT1puS3VJMC93OWFsdHhYSlZ6RG9D?=
 =?utf-8?B?cVBPRGUxUVUwZ2NqZ3ROelgzY2lsNmYxZGxSWkpjQ3JuaWZDWW55eHZyQkRu?=
 =?utf-8?B?QnFZNFZyTGpsbEZnbjVKajdFY3ZWSGwyZzFpemZNU0pLQ2dBaVorbXdQdDlV?=
 =?utf-8?B?bzM2L3NrWFZXMmk4bG1FQktiNGRPYk1SdTZ5aC9LNGgzYWJEaXBkaVlHM29l?=
 =?utf-8?B?T2lCTGMvdzRqZ3Btd1l3SUpsUlpUUlowOFU0SDN0ZGRaRUtLeVkzL29ocTBl?=
 =?utf-8?B?TDBKMlJ3VXZmRHowVDB3ejc2VU9XZmovWlpId0p3NDMwdTBCTlhRSHA4anc2?=
 =?utf-8?B?Z0tINVkyRHU5Ry82WDVLZzMrRHl5eEFJRW9nMUtORnFMTGV0Z2tNRTl6bFdF?=
 =?utf-8?B?SEhuNnQvVmZPQjU0RHVSbkFwVTRvNzV3WTk1Z0MvWk9FK0xTbDhDaWUvVHJq?=
 =?utf-8?B?ckNiYUhxRVA1cldwNUVxVVFmczVvRmFFZjdBVmsxQWlSaWZCcWVBSHJ1V3NI?=
 =?utf-8?B?MHA5QmFIVzNOUTJOM1ZHYjdObGQrdStGWGNxMFRneDdYdzRXMldiZ3ZmT3RZ?=
 =?utf-8?B?bDBrZ3F6aWZjNnBmZ05hWnhkNDB2a1h5dmwwdTVrMmZJYUwzbVMra2h5WFE2?=
 =?utf-8?B?S2lWV0xUUFFPL2g5L3pBc2x5Q0hiT243WTZNZGlKVkRxQ1g5VTlPVC8wT3pw?=
 =?utf-8?B?RnhUVSthbFBuZnphYWhVb0xlNENkNS9aOEE4VHgzRHdoUlQ1Uk1laWhMcFZu?=
 =?utf-8?B?SEY1blBRV1AxVFRZSDRZa3UzamFkeVI5cXhnT0xKTmRqcDU4dk1nbTVSVzh0?=
 =?utf-8?Q?RPwmTZXFIa8AEogk1+IddktmI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d499105f-2186-4da6-2138-08db08da95e0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:11:51.5318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEIOD4IeSOSnRowYMM2+LN7YV+zmvOkHfDO2ch6UjW7RsAty0GIQbmcEjxrkQqb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 22:54 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> A Memory queue descriptor (MQD) of a userqueue defines it in the harware's
> context. As the method of formation of a MQD, and its format can vary between
> different graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD hander functions for the usermode queues
> - A general function to create and destroy MQD for a userqueue.
>
> V1: Worked on review comments from Alex on RFC patches:
>      MQD creation should be gen and IP specific.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 64 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  9 +++
>   2 files changed, 73 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index d5bc7fe81750..625c2fe1e84a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -42,6 +42,60 @@ static struct amdgpu_usermode_queue
>       return idr_find(&uq_mgr->userq_idr, qid);
>   }
>   
> +static int
> +amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    int size;
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +
> +    if (!uq_mgr->userq_mqd_funcs) {
> +        DRM_ERROR("Userqueue not initialized\n");
> +        return -EINVAL;
> +    }
> +
> +    size = uq_mgr->userq_mqd_funcs->mqd_size(uq_mgr);
> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &queue->mqd_obj,
> +                                &queue->mqd_gpu_addr,
> +                                &queue->mqd_cpu_ptr);

We can't use amdgpu_bo_create_kernel() here, this pins the BO.

Instead all BOs of the process must be fenced with some eviction fence.

Christian.

> +    if (r) {
> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
> +        return r;
> +    }
> +
> +    memset(queue->mqd_cpu_ptr, 0, size);
> +    r = amdgpu_bo_reserve(queue->mqd_obj, false);
> +    if (unlikely(r != 0)) {
> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> +        goto free_mqd;
> +    }
> +
> +    r = uq_mgr->userq_mqd_funcs->mqd_create(uq_mgr, queue);
> +    amdgpu_bo_unreserve(queue->mqd_obj);
> +    if (r) {
> +        DRM_ERROR("Failed to create MQD for queue\n");
> +        goto free_mqd;
> +    }
> +    return 0;
> +
> +free_mqd:
> +    amdgpu_bo_free_kernel(&queue->mqd_obj,
> +			   &queue->mqd_gpu_addr,
> +			   &queue->mqd_cpu_ptr);
> +   return r;
> +}
> +
> +static void
> +amdgpu_userqueue_destroy_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    uq_mgr->userq_mqd_funcs->mqd_destroy(uq_mgr, queue);
> +    amdgpu_bo_free_kernel(&queue->mqd_obj,
> +			   &queue->mqd_gpu_addr,
> +			   &queue->mqd_cpu_ptr);
> +}
> +
>   static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   {
>       int r, pasid;
> @@ -82,12 +136,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>           goto free_queue;
>       }
>   
> +    r = amdgpu_userqueue_create_mqd(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create MQD\n");
> +        goto free_qid;
> +    }
> +
>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>       args->out.q_id = queue->queue_id;
>       args->out.flags = 0;
>       mutex_unlock(&uq_mgr->userq_mutex);
>       return 0;
>   
> +free_qid:
> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +
>   free_queue:
>       mutex_unlock(&uq_mgr->userq_mutex);
>       kfree(queue);
> @@ -107,6 +170,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>       }
>   
>       mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>       list_del(&queue->userq_node);
>       mutex_unlock(&uq_mgr->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 9557588fe34f..a6abdfd5cb74 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -26,10 +26,13 @@
>   
>   #define AMDGPU_MAX_USERQ 512
>   
> +struct amdgpu_userq_mqd_funcs;
> +
>   struct amdgpu_userq_mgr {
>   	struct idr userq_idr;
>   	struct mutex userq_mutex;
>   	struct list_head userq_list;
> +	const struct amdgpu_userq_mqd_funcs *userq_mqd_funcs;
>   	struct amdgpu_device *adev;
>   };
>   
> @@ -57,6 +60,12 @@ struct amdgpu_usermode_queue {
>   
>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   
> +struct amdgpu_userq_mqd_funcs {
> +	int (*mqd_size)(struct amdgpu_userq_mgr *);
> +	int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +};
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>   
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);


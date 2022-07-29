Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425F6C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 06:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C712510E6D7;
	Fri, 29 Jul 2022 06:11:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8608F10E128
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 06:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbW1YtXkaSpKFYCDfYXJLt9F9Jq2/QR3nWWqtjYeyXNtVIUcfbJ8U2/9c0Tjv/uCYZc1QhvHcRQ5I1Esp+2Jp6I8ctT1RbfwvyIBV01yh86eMWwfvT6yLHJFb+CMnYEMWPOw9wlTotNmeZM7lwgXoDanJdB9CboU8eoPiBmQ8EHMam3jzRWcSyfaErSBkwqcxhMIVE7QbKwsOyUrMGFw/erHLNPzEyn5rQVUuq512VmFwdtZjAlXPsJp8nqoMcmUIR4nSPI9Jhv9uy+1EaQnM+ffgkPr7VJ/Ri53+9wIU7O0Ro9w4D09Xt0gDqvnU29tXDnE00XzXNfbb6qyDjycOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYbRBHXLE561yc+1d0VFFH4BB2i/hbkrl8T5tQIBs1s=;
 b=FUdvYzW/WlsG61TOmt1Fj4kb040NdaYVIxE+hwQp8cLoyvkolFcfzYv3N3NBYsrHvoi2SQ1G3r5Lxycvm8EB4T4JxrgZ1tFAn2kYQLxssBIp5vUMRwmKyPT2pc5y6IDI5j2WRZ6CW5ZWV7ZLkR9ILAPj90C5llYAEodGqxWmnzCtIcdAPe3coievDVK/DFU/L7qsV6OxhC4pEpPehxUvDDMnKbLAKRs5NPV2uzzEtb9cND3bUx2orayqZr7qcMIz4sQO+80KOfe7wmrsbkBB6+P96DetasZCWYyCEYp6INkLex+uG7hiZ9fFA/MDQ9oYXsJ1sFgcE/2rktoY6N0wIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYbRBHXLE561yc+1d0VFFH4BB2i/hbkrl8T5tQIBs1s=;
 b=Sw8QH2nfUHrtWIf5svbaMHsxY1GnaeW0M2DKXLuH7MCFM/LL2uuzX1Lo62p1qY7A9N4vIQLf1lcX13OBvEk72inEvUw7Qul/fAFwvlBeWj+eeJvqjW4tBbq9CcdeYNcfvq1iqzaEHz2QHJrj1tFm1NuxaGSUOy68OL8obZwJefs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 06:11:20 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0%5]) with mapi id 15.20.5458.025; Fri, 29 Jul 2022
 06:11:20 +0000
Message-ID: <8dd25904-dca5-a9c4-9c8a-567b3d8db7e2@amd.com>
Date: Fri, 29 Jul 2022 11:41:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 6/6] drm/amdgpu: reduce reset time
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
 <20220728103027.27255-6-Victor.Zhao@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220728103027.27255-6-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d9b6a9a-46b4-4744-cc78-08da712927ad
X-MS-TrafficTypeDiagnostic: MN2PR12MB3774:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/UqmtYSncdt29efUNrK8dEwO8aIeS080bM1a4I7mKIIy6v6pXGHJq65f+pVMS18AfbGkQHFWs4WvpTFz0CqJ49nCwTJpEQ9TJ/EfulNFqF+/5ZGM7U+QI73uipjnCg1vzKiTDnRw3Idc64NAuNSQdIsO4Ps9fdEk/rxfglhJAZdNO8bXuIJquvStSsvopiECo0sBuV4AQCNa1Za4l4pOKxv+GobeVPhHs+HhBGp0iBld3BLCxxRZ+i/bMEJddhv4nyLEBM8ccX/PZHx3xGFh1l4hlGWSSsjT+8bet6o06zJGlZi5sv0rZSD6MOoGdDW1CWy1g/zd57RxWwr6ODeonyAxqOc94Hyc4ZUzE43X5WC1H3FnptPm8PBjsjl1IcDr1LbZ2OlK7gNjwPQ7jxvMkCCATBTb/XSC+KZQmw/Cj5JWZIx1i4DtYj/oeLdCTlH7cLolriEZl2ezRV+++mg6yZCLhHTsVnUAjkyJuMFfBE/vAxFEUR393miYQ7oiXHmp0VN1cK3DK9UEuXAgignVWFxL/U3s/xY0Z0OMMuHrQuDsoQJnoOiG6TxI91fbrUnVCxScZZatF28+PjYl+FKqaToF2fj5kyHYktSuBJT0CnxKXwIToTaNQdru+gnDbM4ij+VohFRQga4rC8a82AgWbL7wEgGDktd0YfPF582uefXaKlAtdDqoza/V4RjLdOUlfgRZCDwzGRos1FmCfyflfM41UjKBZkD5voGpdMZDdbL3CYAxQLDau/sUzL/2VdDKJ+fjaphtkEmFczhGnQADZWf6FTrSXdOLnQuACpELsNjVBLWaXmw/6VXOS0X0hSV+Olkqne5AxmqtuukTjMgJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(8936002)(36756003)(5660300002)(478600001)(8676002)(4326008)(31686004)(66946007)(66556008)(66476007)(6486002)(316002)(186003)(2616005)(6666004)(2906002)(41300700001)(6506007)(26005)(6512007)(53546011)(83380400001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTNkWE1FV0RLUVQ2UWt3d1JJZk5zcGxPSWM4SWRxS2pjZXZNWUNKQy9qOEZj?=
 =?utf-8?B?TFBReUplSkNjSVdmcUlPWDB1VGxrVWErZGRBd1VPT25aanVvRm1EaGdEUVRB?=
 =?utf-8?B?WDY2UVVLTXNSTm41cFpYVU9Hb1hpT21LejRGY0hlVWtzSFFocEJyRXBBNnli?=
 =?utf-8?B?T3RtSVBHOE5mTnAyK05xUzNSd2JHd3l1WWVCZkFRSnpRZUdTK2MwR3lnRGg5?=
 =?utf-8?B?ZnJvT3IwL3lBRFArZC9NVUlMeUdOUTZRUUp4M0prQVpId1l5dUNJeXo2WTJa?=
 =?utf-8?B?L3FLOXRjbmMycWpNMDJlM0RndnRNSkF4aURZaG5yQjJaeTVNaWpHZER0dUx0?=
 =?utf-8?B?RWJxb1pNSlYrbEoxQ1NZQlRuM3dxNTJ3RnIvcjBCZEQ2dVZJdUZPQlBQQmZI?=
 =?utf-8?B?QjZIaGhPbUlkTlZyYWc0Y3pKazJHSTNJM2lLd2VmcEpsK0Fsd1VoNnpoR0JH?=
 =?utf-8?B?cWZMSUY5TGVKbC9OODJlVkppdEZFWkFsS2dCcDViUk9WWnVKU2NwZllWSE9r?=
 =?utf-8?B?TlF0b01Ob3lmN2x6TXFxSW8rbnYycGQ4bW1PZSt4Z3E5VDdhZGhKZ0wxSFNJ?=
 =?utf-8?B?cXFPN3RtZy90aTNXOUFGL250OUhlb054eVhlaGhGQTRwQlpHenQ4SGFPN0xU?=
 =?utf-8?B?dkdlOG8vZmg4OFJIOUwzV0ova1d1NDE4SFFEZ2FYdVR5cWVPYm9ueHFKVHlB?=
 =?utf-8?B?cTRoRXpsbUhhOFJ1TXBDRVZPbjZQWmZvMklQMWtMQW1jUFpzcEJadXBnNXZk?=
 =?utf-8?B?ZHR6ZUFWcFYvUHpKVDgyQ201c3JSRzBuMTA5anB5aWxNRVpyN05USGwranNz?=
 =?utf-8?B?VC9lS3RoSU5wYURjODczVWFHTHc3SGk0eE1ZbDU3Y3BESElmTTNBVVBTdS9Q?=
 =?utf-8?B?QXQ0anVFeDJERlRDVW5iNWordHU5ZDFVK1BnNFpaMms4bTBncTNLaU9GZUxn?=
 =?utf-8?B?c25DUDAxYXpicmZma0xlbFlLdVoxazVJV3RSTW9ybjk1OEZpS0tWSFZPQXFR?=
 =?utf-8?B?dHAySWRiZUh4cjBkMUJtWGRHeGRhWjBhOTVocU1ScGFNRFdrZ3VpbC9vdTF4?=
 =?utf-8?B?cVF0cUFkSWFacVdjMEZrSTk4OUdxUkxRa3NiRGE0ejhZd29iWXBWbHBOZW5D?=
 =?utf-8?B?ZjRQWm81cXJJaWRpd2Y2VjJmVWdhUTVhTXFUUzUyS01ZL2puYldEWk0zRW1n?=
 =?utf-8?B?WkFRM256NTRLNVZ1eStFTWdJaG52SHdJeEQxUXdUcDN4bWUwVjZkZmpwWkgy?=
 =?utf-8?B?b1RyNFh2SG4xQU9FUVcxM3FIcEp5NXFhOVR3Smd0SVdnMzVSeFRWcUZraFVy?=
 =?utf-8?B?T3hKQXduNWdFaFJlZzhiREhGa0FlNzExeEZ1K21nR2lvVjNDVm1jZUh2QjZ2?=
 =?utf-8?B?TExQMG9XM3FrZk1aWmNPQVlWRndpQ3p2MndqV1Rid3djYzljVDVIUTV5MzNZ?=
 =?utf-8?B?NTNNQ1FHekFsS3hFTzVoL1ZiaDJobUFRNnVEVVM0SUNGaEQ4bTlZMkVDcUIw?=
 =?utf-8?B?cUw1UFlxQ2k5WVJuTGhwZW5xc08wVGIzd1E2emdZL01zOVVQVzhMRVdBbThS?=
 =?utf-8?B?TXVieU5XdjlkVUcrZ05Dc0pvOXB0OVJiZHJ5cmpCNmlhM3pVWkN2ZmtpSTh4?=
 =?utf-8?B?OGpmdDBsZnlJTEFNN2NMTVdUS2xYbVVQa1lFdlptT3FINkI5YUYzWnJvb0dR?=
 =?utf-8?B?VG5Wcld1SVA2ajZyZTNDN3JrckJHQVNneFpjM3B1RUwyeXljMy9LTldRWlpW?=
 =?utf-8?B?UDRPOUY5ZHpaL3pmYzRJcmRxS0VEcitSS2xKZml0SDBjNGw2ZlQyejBIVm5W?=
 =?utf-8?B?ZW9PeHpXck5KcXRnUmFkWUowL3MwUmZrS3dwVWxVRmNWVENLNEJyUFVoVUFy?=
 =?utf-8?B?MDVodGxoekFNVnVCZVpIS0l3d2Z0R2NJaU9KNUZtMSthLzF4SWw0amRidGNN?=
 =?utf-8?B?WG5qTVdxU1hhcHpQaGpibUpoYldsNXVMcGdMTk1kVCs4WnkyK1JnSW5RTVEv?=
 =?utf-8?B?WTJQclVtNFdLSGdGSjBHZ0daOUFLZFdXeG5yUU1VbENOTGtUSC9xbkJsOEh4?=
 =?utf-8?B?YytaRmwwWXVYVHZnaVdvenRPcXNzN29hZDBONmt3OGNlZzJ2ZUpEOUVMNmxu?=
 =?utf-8?Q?gF6P6lAonz9i5Mthzfw/ndFSZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9b6a9a-46b4-4744-cc78-08da712927ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 06:11:20.3551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofFrw46fZgWKzr2p4LnLdlJx7wYRmvklvDXfy2ShugDkLldXJCM55IR0qWi5Yvzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3774
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
Cc: emily.deng@amd.com, Andrey.Grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/28/2022 4:00 PM, Victor Zhao wrote:
> In multi container use case, reset time is important, so skip ring
> tests and cp halt wait during ip suspending for reset as they are
> going to fail and cost more time on reset
> 
> v2: add a hang flag to indicate the reset comes from a job timeout,
> skip ring test and cp halt wait in this case
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 11 +++++++++--
>   5 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 222d3d7ea076..c735a17c6afb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -27,6 +27,7 @@
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_rlc.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   
>   /* delay 0.1 second to enable gfx off feature */
>   #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
> @@ -477,7 +478,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
>   		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
>   					   RESET_QUEUES, 0, 0);
>   
> -	if (adev->gfx.kiq.ring.sched.ready)
> +	if (adev->gfx.kiq.ring.sched.ready && !(amdgpu_in_reset(adev) && adev->reset_domain->hang))
>   		r = amdgpu_ring_test_helper(kiq_ring);

On a system with multiple GPUs interconnected, this will affect other 
GPUs as well on which job was not really running. I guess your usecase 
here is device specific.

Thanks,
Lijo

>   	spin_unlock(&adev->gfx.kiq.ring_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 6c3e7290153f..bb40880a557f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -49,6 +49,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	}
>   
>   	memset(&ti, 0, sizeof(struct amdgpu_task_info));
> +	adev->reset_domain->hang = true;
>   
>   	if (amdgpu_gpu_recovery &&
>   	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
> @@ -83,6 +84,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	}
>   
>   exit:
> +	adev->reset_domain->hang = false;
>   	drm_dev_exit(idx);
>   	return DRM_GPU_SCHED_STAT_NOMINAL;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 9da5ead50c90..b828fe773f50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -155,6 +155,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>   	atomic_set(&reset_domain->in_gpu_reset, 0);
>   	atomic_set(&reset_domain->reset_res, 0);
>   	init_rwsem(&reset_domain->sem);
> +	reset_domain->hang = false;
>   
>   	return reset_domain;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index cc4b2eeb24cf..29e324add552 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -84,6 +84,7 @@ struct amdgpu_reset_domain {
>   	struct rw_semaphore sem;
>   	atomic_t in_gpu_reset;
>   	atomic_t reset_res;
> +	bool hang;
>   };
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index fafbad3cf08d..a384e04d916c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_psp.h"
> +#include "amdgpu_reset.h"
>   #include "nv.h"
>   #include "nvd.h"
>   
> @@ -5971,6 +5972,9 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
>   	}
>   
> +	if ((amdgpu_in_reset(adev) && adev->reset_domain->hang) && !enable)
> +		return 0;
> +
>   	for (i = 0; i < adev->usec_timeout; i++) {
>   		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
>   			break;
> @@ -7569,8 +7573,10 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
>   					   PREEMPT_QUEUES, 0, 0);
> -
> -	return amdgpu_ring_test_helper(kiq_ring);
> +	if (!(amdgpu_in_reset(adev) && adev->reset_domain->hang))
> +		return amdgpu_ring_test_helper(kiq_ring);
> +	else
> +		return 0;
>   }
>   #endif
>   
> @@ -7610,6 +7616,7 @@ static int gfx_v10_0_hw_fini(void *handle)
>   
>   		return 0;
>   	}
> +
>   	gfx_v10_0_cp_enable(adev, false);
>   	gfx_v10_0_enable_gui_idle_interrupt(adev, false);
>   
> 

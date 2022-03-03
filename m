Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB216C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 20:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F30F10EFE9;
	Thu,  3 Mar 2022 20:25:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B5710EFE8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 20:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZC2UAgykH2D44cY3WBUHD4IIOZ5lpEwZ53rwsPXB+t8X6U3kboB2d6QN/6GmiJfpbBVstx150qOWU0IJTGkr0Z1UkcqlR7I/XtkVwx2tiOxSneGXIiDaEPTnF9KI8qnl3zJMoNLLYHZ8SDIqQz7JzP6jxQ/Ef0V8O8+5bcWuZNriYDH6CmFwJxLfN8yxFpKR95oMxNoeouPr4zBmYs4jSHlm7s9hapCeeCuwRoS0X90kOL8bxSsg88VbA93qSCMpKa6bZXQAC3nP/3JKAAQLDUbKVUWHRGnxAaJAQ3geAxrj7s8DX82l697P6UvY6BK2CENN5TIkm0QZIQkYfjkSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7RYWNp99N2qjEwrQcqk2Y8lBcCA6cwpfuRLRm4CDmE=;
 b=ZPRpCVfPeRAWh0SJjN76gJdh3svAoBedGfSw6znqorzgl20/bM7+J/AQFNvnglthcRTerezGK7RP10f87fenOX/3v7ns74mCU/qKBtvPl4fUDhl9+1rr96m5Ybr5F7lWqv2lCajcko9F8M8/rA1dJh5mWCMte73I1j58/Yu0ZU+M9Yx698drxTcZq2RbrU0holGpzLIYcK6AG3ci5z+P4relqWfhUXIr4zeWycDNCjJM4ZDfk231LtOUpv5LKtPeda2gWsvsjTJg4u9MK6RvCdGiYF9eukOQVqKXoA46KozfCtm4+zv2xypmeALSE87gxdXJ8NyoZ08PPt/zQfyUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7RYWNp99N2qjEwrQcqk2Y8lBcCA6cwpfuRLRm4CDmE=;
 b=riLZWoMFxx6HcOqGTS7w5XN+iAINOv2l35CvmssT8FRqV+3XJ73qOotSG2nhZ69kJiM28mZ7lLyYGBC1QtYPq0AsLy3HkaCVZkPCED0YNfn+rG/OdSvrJVTR1DsVCuy0uhhMbLHMRzPBRW2pp/a/NJY8SaWDFERxbg2q4GCJrV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 3 Mar
 2022 20:25:36 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 20:25:36 +0000
Message-ID: <9ee58322-d842-eca9-6d16-c3efcc525483@amd.com>
Date: Thu, 3 Mar 2022 15:25:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 06/10] drm/amdgpu: properly imbed the IBs into the job
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-7-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220303082308.38217-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5bbb4d0-d0e9-4ee7-dbd7-08d9fd53f97f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1909CE66B3C418E69F97B15AEA049@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOEgkiNSqcCJszTGWq8RhnzI8PS+VVDBn7Ah9GJ2euCY+HjtqIjz7EK4kdOmKLjzoDP7JRSa+zivbl2IbnTX9W6JUpT/KK7bxQjOarWJSFiqG8lpDhZvlLb9BryDrUtDAXHzBmk8TQXEGkHBjeAdt4os+if/XYI7RKz3fTAGeFnoNFKjvnhqhdc6uOrzZs7O45yp9jnsdAeyFvdPt4Yu9tmtpHxLNCXH0jNwCjwfhaVgfjVTI+S4Y4ToJRmga6ragNt3emWAhwCNtfozVtpW80V5k6tg7wXhOuHrxIywJhL7oprmSlFHm7zA7Gce1fZ8p1jHrsYuHSYtT6P6xj4LfPtMyUs16mv9GH0wS0JmW/WzPq416/RANRS8xBtgSsvQOu7SOqnSP8ewxopp2MAMsFskniMzJhbeAyc2sf9relAwFCSsSTMMl3s1ahSKp4PUDtnt8sI/0QxhiHW8dE9S1DGpkEj8ysHQW5DK7cYV1zQGnx/6yT9D3/XTSwHRXhJOAZjl5y8oFdckkDkgyoUZbg4Y+py4HjuFPwBZ0SjeB4fvxAoomLXYxoRJUa/nR8IEZOyzIREKaIigUgsnqVsGPJ6zkXbKa927uDEEeN5x6l6sU10jOkhmLUsCSyMDbmxM46NU0/As8jgz3W11F9pUDxXn6SMJWuhJmmCycJJvm9XchT3dU0ZrPCrbRJfUdqEIZH8tcjHtvpzS0/PSpca8xcv/vYmL2k5gFx9btMgMIziM1QsJhL1RwKfrTnWzV1+u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(6486002)(4326008)(31686004)(8676002)(2906002)(508600001)(66556008)(66946007)(6512007)(8936002)(36756003)(2616005)(53546011)(316002)(6636002)(44832011)(6506007)(5660300002)(186003)(38100700002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWJQMlRoUisrM2RtODdWM1c2enhkOEZodldiZ0g4cno3MlowRlZFdkQrTWQv?=
 =?utf-8?B?TEVaTit2Q0hCNzBBZXU1WGg0eHpOV2JWUU4xNzN6SW0wWmxwQ0NQNWNRcVRs?=
 =?utf-8?B?TGQrODhaM09IZk53MGwya1o2cUlQTTMyK0llTzFTaUY2VzhpcE0vR2JsYmJu?=
 =?utf-8?B?SVJic0FlMm1yM292ZUx3T0V3V1NiTTZUL04wVVRoOE9hdkpjR1FOSjlVcTRE?=
 =?utf-8?B?L2FqamRORHVDRTJZR0NZZWc5VTg4eFB0R0FmTTBqWVVBOW4xNnRpY05DRStt?=
 =?utf-8?B?aU1PNk1IV1ZrVEJLTS96OVNJSWNUQkJiczJuNGFiNERYNDRqaXpPaTc0RHps?=
 =?utf-8?B?aHpmd290Z3U1NlRBejByaXNDa0lKWEUrMzNXNmlLVFBZRGp2RFhYTTVjc1Ra?=
 =?utf-8?B?dDlWbEQyUC9XSWdtUVNkSDIzamcvcThQYlJ1Tlltdi8rc2ZxbUJ6WU12ZFZF?=
 =?utf-8?B?a1BuTlozN1NBZC9ZYWNGa08rb29oOHhsR1JyRjB3ejI1cjBzL0pnYTBSTU8z?=
 =?utf-8?B?bVZhcHl0b0E3QUd2ZzNpRXNxSGdrMzlOTVBLMmZLeEhHL2I3c1lWUy9nTVFZ?=
 =?utf-8?B?WVFhT0tCalZGKytvSVphdklSdC9DUmJDRTVaLy9YR2lmT2FDUlNSV2VZVzdq?=
 =?utf-8?B?Z2Y3SStka3E5YmMxSmNiTFE0VjEwZ0t0OEYvcnRlR25sc05NcnhCUFZiRnkv?=
 =?utf-8?B?SXpRU0tCcHJCTE5BL2pjVUR6NFlnMUlocTZpU3l1cjV3bW1pREdsZU9NdmhH?=
 =?utf-8?B?NDBLMDBpTyt4bk5iblRMekxGYW4rMnAzemJ1cDM1Rk04VldOeU1Ud29DdDhO?=
 =?utf-8?B?bGJ5UFJnUmE3VUZteG5VUGRrN3BVc1ZlMUdLYlFIbFJwcXU0R2h2aUx0bUNS?=
 =?utf-8?B?MCt3bGRGUDFHYzlQQmFxWkVuL2lsSnFPN0FJZWY0Rk1hdjh2MnlhcGltYU5E?=
 =?utf-8?B?LytCNGkrekZjWUs0YWx5T0pBbTJ1MlpySjVvc0N6ZHVGU0pWV09ZV2JaSytp?=
 =?utf-8?B?bTlJQ1R4VlpydHFTQUVVQ1JLZURWZjdveE9hbkxHd3BGY21uUDd4akN5UWd6?=
 =?utf-8?B?Q3JsT0JENG1vMWVpa1JhZkp1SFFtM2pWL0MyKzV3bWZBaVY2b1dZa2p3UVRX?=
 =?utf-8?B?ZldJaGpKc2dTSEp1SUs4RVFUTWkvZFNzQktDYlZ5VmRWcXVVb2NmcXNQVGNy?=
 =?utf-8?B?TmxoeFlFMnlFNXBqRUtOSW5zSk9QMHpvWDRRVklJMU9uQXBlK3pKb1B3U0lS?=
 =?utf-8?B?SFd0TlVZd1h5NzNUa3UxdWY0THNpZDBjZlBJUUZOcmlMZlVQeWxqeENPOWVC?=
 =?utf-8?B?Vy9UWkpQNlFCT2hBVExmQkRJQ002ZkFuY3lGdnV6dHN0ZnFQYjlmRDRsdFhW?=
 =?utf-8?B?cDdVZkFNVXFFbE4yVTFWSGtQbTNWcS8yYUVyZzVwd09ieEJnVEhyczNPa3NN?=
 =?utf-8?B?ZGErMFJlMG5TRldvTVpkZGVRWGZMYlJsVGF2azB1ZzJGalFjaExqbHZQajlQ?=
 =?utf-8?B?WFUzLzNlSzRJZ3Z1SzJqSWdPT0hWSDNOQ0o5UUowSGxvV0pvQzhRMVcrOHFi?=
 =?utf-8?B?SHNSbzVocUcwWnNsTGVPeEJaa0RnZUZmMUwzVm0xbi8zTURxUk1aTWQrckk1?=
 =?utf-8?B?Q21RZU1FV1YySUF6VDFxVXZtajZ5RVlsSklBTC84bHZveWRWYmpodVdUSTlm?=
 =?utf-8?B?UEl2dkVUN1lzOEQxT20yL3ZzUWZXWWFCRVlBVHlTb2V1dFhYUFZ6UUV4UEVa?=
 =?utf-8?B?Rkw2M2FOUkV4YkhkRjN4bUlkbGhycmtzVWx3TFEwV2pyRVZrRUhuT0RmN1Fs?=
 =?utf-8?B?d294RFVnRzZaSzNYNDZDV0lWTDJ1YzBMbUh5TTJ2dW1ITkEvbVRWVU5vOXBR?=
 =?utf-8?B?aTZhQ1Z1ZmpYTGJxOXlzbEhPTHVjbnpUMkhKSlRrV20xRzZuRWRrWkhZWEJr?=
 =?utf-8?B?a2JGVXY5ckFFaXRlTlYvSC9xdHBXMDVQQUJNTGpnbUVRSHVraXV0SHh5eDJv?=
 =?utf-8?B?elVHbTdlWmF6SWwxdHYrTDZmeXk1T1FVS2tCYWxGNDM1VUhheVJhM3lKS2Yw?=
 =?utf-8?B?L2o4TXplaU9SWnBHVUJQQWRzaG0xdHVtMEdiS0ZmR0dUZFNsekJzVUZ4Zkoz?=
 =?utf-8?B?SDV3enFZcWNkWXV1ZENhemM0Q015YmVSdkZLUGc3c1R1Y1Q4a0QrWHY0aDht?=
 =?utf-8?B?VDdXRVdFMnN4VGMzWmk1V0xlRytCNndOOXdDRk55KzZDdDFSWkoyd096YWRp?=
 =?utf-8?Q?gqRIuffse6tUSz/WLf7G5kyhK0Bv0M7bvr/l9JJMgw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bbb4d0-d0e9-4ee7-dbd7-08d9fd53f97f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 20:25:36.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1GP1KUR6mnqyNUNL4J4309TgnUW6YyCRiXBTyz9MknmcSl2QvlQfGZSSYUKdookFVQsyBmVCDGJdFTxHzhREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-03-03 03:23, Christian König wrote:
> We now have standard macros for that.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 6 ++++--
>   2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 38c9fd7b7ad4..e4ca62225996 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -78,14 +78,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>   		     struct amdgpu_job **job, struct amdgpu_vm *vm)
>   {
> -	size_t size = sizeof(struct amdgpu_job);
> -
>   	if (num_ibs == 0)
>   		return -EINVAL;
>   
> -	size += sizeof(struct amdgpu_ib) * num_ibs;
> -
> -	*job = kzalloc(size, GFP_KERNEL);
> +	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
>   	if (!*job)
>   		return -ENOMEM;
>   
> @@ -95,7 +91,6 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>   	 */
>   	(*job)->base.sched = &adev->rings[0]->sched;
>   	(*job)->vm = vm;
> -	(*job)->ibs = (void *)&(*job)[1];
>   	(*job)->num_ibs = num_ibs;
>   
>   	amdgpu_sync_create(&(*job)->sync);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 6d704772ff42..d599c0540b46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -25,6 +25,7 @@
>   
>   #include <drm/gpu_scheduler.h>
>   #include "amdgpu_sync.h"
> +#include "amdgpu_ring.h"
>   
>   /* bit set means command submit involves a preamble IB */
>   #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
> @@ -48,12 +49,10 @@ struct amdgpu_job {
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_sync	sync;
>   	struct amdgpu_sync	sched_sync;
> -	struct amdgpu_ib	*ibs;
>   	struct dma_fence	hw_fence;
>   	struct dma_fence	*external_hw_fence;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
> -	uint32_t		num_ibs;
>   	bool                    vm_needs_flush;
>   	uint64_t		vm_pd_addr;
>   	unsigned		vmid;
> @@ -69,6 +68,9 @@ struct amdgpu_job {
>   
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
> +
> +	uint32_t		num_ibs;
> +	struct amdgpu_ib	ibs[];
>   };
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,

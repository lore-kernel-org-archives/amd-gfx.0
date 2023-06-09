Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8B7C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 11:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4F010E68A;
	Fri,  9 Jun 2023 11:37:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0812A10E68D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 11:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc8UgME+t49JlgrPZ5lixNaUoNj+yGX1JrEqpJN/sqnjWyB2oRsGn3kM3/967LCPVvqmAnobOmmAehOxV8l/2CJs2sWM3Ax4Bh3NLNZaA4qhVQlXupmBHHTd3U2Ao6PMdc34T57cpH6cxzrQv80/YjC3aCZRUOEMAII7ny/xIQFK0e8GjVKP4BQYOzhjPkRlutjLVPrTn6P9CO0287T8oS6Zg95IhHItubmzKF2FesvQpLv9dyQsLd6jBgsOF9US1m6MVfu//UWv7X3wgMURUUyNDr0R+QkLCcfg1OaShi9mtkfErMpO+yXbgC06/76IQm057ulm1lhLPFBJcznmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGkhc4mvAidPDK6oyb7hooKAYHzcxJ60qkC9Sng9R8k=;
 b=OtuCB8cO7CXtOrHActgudKTSSGp5cI2v4KRIfOwT5fmH5bMGp4hAOjPQQfr0ML702RRMzS/gYqCNdhBt12Ha7jsSQ2e0xUioqYqz2ybbk0F6IsAtt62sSKKS5mF0KK+hM0wdc1yiAUGXOOq4mG4LFpAMx+bCoiGR5dS+gjGOFxFKaaiGtDwHmIqljilvbkrqkiMFQqiMcp4g8tuflCxpKhUzZMk8BcEjUDwEqrk1hQkm2rGPcRDUspgMHnEsmKxjQPTjKpYdACUu8OObxk7kmY5evVNPksTxukb0dI0UwvVT+tnZBr+a3hkc+MVGvWX/JxASmXC+1AaMIyTZM/kgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGkhc4mvAidPDK6oyb7hooKAYHzcxJ60qkC9Sng9R8k=;
 b=3NYnNDfDuwmcRyB/A/r5GsD6opr0UNTJJEkKam8AxSs2h7fuykg/jYmFZx/1IzJ7Bkp3h683gJ94SSazit9RvSleIGV4/fOAige9FYKmeH5vAtPIIhB89x9zIp3t1mHqHqPlrAv0xel8zOGEJ/snknnoU/oRBQSS4cW6+n7KS54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 11:37:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::6729:a735:9814:97ea]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::6729:a735:9814:97ea%6]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 11:37:02 +0000
Message-ID: <fc9b8914-52dc-ba12-a485-61e9c61a696c@amd.com>
Date: Fri, 9 Jun 2023 13:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230609100257.900-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230609100257.900-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA0PR12MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: b4531c1a-be27-4c46-ab4f-08db68ddd811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/f7nd8Yi+K+Wf8WBo6ktktKNpAQCPgAV0e1o/ILR6clMZ9Jxja57DCCObkk9AF/Y7HvhUrq2o9oTwmSKotpaLdIqgM84DZ15r7DRcNJsRmzhZR6+cEhBCI4LQ4dV3xyouKTbZJS+IU1zAnrNJ2EjvMiKvIkIB2HPOVqvb9WuWIrNWoNX/GMz+715uBJY2A4vpQeotAx8m+0+cKpyUV/oaBKZcp9bEjjEnPuATuNiMcwMN1HBztgcJgRYsBjyUw/G+u4YKmokI1nBmoZunIllk/mZluNlAamNHpGIJRh4hDzGQ0UE4c6NS3GrI6DHPH4nldarOP+TSxcgO2bs6X8FQJb09d2ayAXPKJneN20GQvKgFRnVM7Kk7ya/oRDmdnc/ck1XDivXelt0cpF339Ekh3obndMMQ4OiFXNWM0iil+Du7GY3jl3hTkBvC3P17ebfGT/QGRPS9Z39dvDn/wYo5r+PhE5viICM+DwA9DC/33cX5JkUOILmR2PVmCbV+HYyeagJ5ARfgt32JJI0B0EWj9FUeZpmIOJDxxQ2a7/l1dLOwJMPQsRqCU5UsGY8n53ivlEPNb1L1ynleTIlSBWApyoEApkSmetVN6MlXrp01epMqyjF4nKRfUYfV3uFjPBRcNgV+ywFwFdNXUYS9W1hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(66556008)(66476007)(66946007)(8676002)(8936002)(36756003)(5660300002)(478600001)(4326008)(31686004)(6666004)(6486002)(316002)(41300700001)(38100700002)(186003)(6512007)(6506007)(83380400001)(2616005)(86362001)(31696002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZMNktQQmxQdkU3RjZnTEhVM3lwS0h3RW1Kd2xFOWxuNUkxd2VjcjQ0UFND?=
 =?utf-8?B?bmJjUmRhdG1EODBteloyeVZXK2JkMzVLc1dTMGhnWENsUXBLVjVRZzhiSGtI?=
 =?utf-8?B?QWRVQ1ZVaGJjbjdLeHU4MXNHSER5SFA2Y3NrY0pIcUN1MHJXckxGNVpleVFy?=
 =?utf-8?B?QkpKN3NQbjZjNmdJb2cyTzBFR095L1hMQnUvZnMva0dMRGFPNU9LakxDdmQy?=
 =?utf-8?B?dGpJdm9PV1NndGlrMWhhUzljQ1A2RWxQckN0MlN6S1dwQ2t6RGFtNU5ad0x1?=
 =?utf-8?B?NEZqNGt2bUJEdlE0NThKNVJ6bmdFR0p1dzlXZEl1QSs0aEtlcmpKOWNhNXNK?=
 =?utf-8?B?R0FJS2RVbDl6MjhzVlR6aHNSQU53YlowN1kzK3ZnOUxPUWpmb1Ezdldwd0tn?=
 =?utf-8?B?NGpMYytWWXVIUHJtUUdmU09nYnl6T2lqUHgrWW9ueDhQMmx6bnJETEI4Ukc1?=
 =?utf-8?B?K2NtcVhUYmc2WUJNaFhHT3hRRzh6RTRMWHVBVW9ISytINXYvUUsyamd3VkNR?=
 =?utf-8?B?dWVwaWlySFEyZUF5TWJlOStvR2UxWlZvVERMTG5rM3hMM3d2b3hkdjV5QXov?=
 =?utf-8?B?eVdTcCt4NytVVjZsTHRndjU0WTZrS21uOUd2L1NHQVhDaW5zZERoNnNnanNt?=
 =?utf-8?B?VFVRZDNEOHFqQ1VVUnR2T2Y0VVRSVHVPOHBRNDVyanJBRDRKc2gxc1cyK2Np?=
 =?utf-8?B?amMzZjFrL3NRelJFY0ZHQ3NycTN5RmdER2pDUEEvSC9VY1htbEV5eG5saU1k?=
 =?utf-8?B?TGRndmFWTEtoUFpnaS9ocUszWWVPTFFSNVpBZ2pHNHFScitLWDRFQmQrNmlD?=
 =?utf-8?B?eWg5R09XSGVQYmY5VUcwdDd4YzhLM2gxQkZVZVVtcHZkQUNMdy9DWjVRWktS?=
 =?utf-8?B?ZkJhTXFzZ3ZGNW5WWXRTY2poTDc2eThpYkx3akVFV1lHVDR6Vll3dXZRa3c4?=
 =?utf-8?B?K0xvVm9YUFNYd0ZVamF1VkphcUNUbVMwcUxNTlZ5VnBEN2ZKaEhaM0ZSYWhO?=
 =?utf-8?B?TzlOeGEyanN2eDZrSk5GdnZ6Njlha3Q5TDhndHpMbFJXZWRGL3NvVlhOTXQ1?=
 =?utf-8?B?Y0RvTUxCNnl6enNYNzA4eUV3SWUweHFYY0M0eCtkaWhXTjYzMTBvT2lRU0tt?=
 =?utf-8?B?TkVMNnlBeURHSXlkSFlMdTlVMlpsYWkxN2VxSEg3WHpHU1pyeU9oeldmVCtS?=
 =?utf-8?B?c0ZybkRUdGpFM2pnRnV3WXNyWjNPTlhzdXMyS1l3Z2VseGtIb1ZBbzBhaDRJ?=
 =?utf-8?B?aWN6M09ENHdLTStBaEFESnZjaENScjFvekFsNzRrZm1PTWhsYk5BRUtxcVNj?=
 =?utf-8?B?SjFDUHlWck9rMUQ0UjM2d1pDa2dZc25LbnJVbkVuRUd5WEFaZjl5Sld2YTJa?=
 =?utf-8?B?YTQzSTVralNOaGEzL2NmRXJDd0VSaWN3M210d09yWFFETTFyVGx6Vi9EdmJB?=
 =?utf-8?B?Z1Uxd3lKVTFHcHBwUzhZcSsvczc1VUR1Q1BDd3JqSmdRSzdhdHY3c0pOaG1U?=
 =?utf-8?B?bGswR0xIcVhMQUpCWkxBY1ZZWFJVeU52ei96ZHlDa01DUjRldkNmcEV3Wlpv?=
 =?utf-8?B?SlZpbTlENERGTG9uNjhReGpMM09MOVMwQW0xR2dDL0FRbVc4bXdVODF6MUlt?=
 =?utf-8?B?b2dBQkxiQjMzb3RJSGdhSUVxa1c4Q3JLN3MrUUZCZFE5ekN2S1pvc1ZKQVZr?=
 =?utf-8?B?WEMyclN5Z2lzVFNOTGhxb0sxUUlUaFZuU3pxelpXSTA4cUlkZloxZCtDMCty?=
 =?utf-8?B?MUJKLzVkNFk4RVdoT0dGTnRDQURDVk56ZDlkSUhONncwcVBQcjd0N1N6S3R2?=
 =?utf-8?B?Vm13eE4xTXBBYlozYXdWUVRsL2pUSkdWM3BFZlJvcnFKa2xpaDhzamdNUXZZ?=
 =?utf-8?B?OFVvWUNjeFFhRU9Oc3BUVmJqQVp6eFgwbFl0VkppeU5tb243ZDd4b1NjdUpJ?=
 =?utf-8?B?Qm1pd0JOdXhzbWxvT2V0ejdhOEd6UFdEYVExbStJWmJybmVnZi9GQnU2eUxI?=
 =?utf-8?B?akUwS0tBU1FYc1JXMjJjbjNubjcyZkdHMTFuWEJyYVNUNWxyNEVsU3BqSGRV?=
 =?utf-8?B?MThHUlRpK0hUcWNKU2xoSG9tajJxSW13Q3JMTHZTSExqaXRLc3QzeURraTJZ?=
 =?utf-8?B?cjcxaTRzd2lJTG1oay9UQzgydldoQnpuU2tqaFJFOFNuTkZMeW9WTmdXRURY?=
 =?utf-8?Q?S16Xuau9R/lAOEFsU8bvAullhA8YEVf9i/xdaFC7b9hz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4531c1a-be27-4c46-ab4f-08db68ddd811
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 11:37:02.7018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNjh9fAsYF3pgz7FNo03Axms0XZOFP/sXsme6c2MocFrmhe7KNm+EU3LVAl2dSXX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
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
Cc: felix.kuehling@amd.com, Amaranath.Somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.06.23 um 12:02 schrieb Shashank Sharma:
> This RFC patch moves the code to flush TLB using SDMA ring to
> a different place like a separate function. The idea is that
> KFD/KGD code should be able to flush GPU TLB using SDMA if they
> want to.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 36 +++++----------------
>   3 files changed, 50 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 231ca06bc9c7..20a5dad32bfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -30,6 +30,47 @@
>   /* SDMA CSA reside in the 3rd page of CSA */
>   #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
>   
> +/**
> + * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
> + *
> + * @adev: amdgpu device pointer
> + *
> + * return: returns dma fence which must be put by caller
> + *
> + * The SDMA on Navi has a bug which can theoretically result in memory
> + * corruption if an invalidation happens at the same time as an VA
> + * translation. Avoid this by doing the invalidation from the SDMA
> + * itself.
> + */
> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev)

That function is actually not really SDMA related. It just happens that 
the SDMA is used for buffer moves and we needed that as workaround for 
HW problems.

Maybe add a function to amdgpu_ttm.c with the implementation to use any 
ring for TLB flush and a wrapper here to use the SDMA for TLB flush.

> +{
> +	int r;
> +	struct dma_fence *fence;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;

Variables like "r" last and longer lines first please.

Apart from those nit picks looks good to me,
Christian.

> +
> +	mutex_lock(&adev->mman.gtt_window_lock);
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
> +				     AMDGPU_FENCE_OWNER_UNDEFINED,
> +				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +				     &job);
> +	if (r)
> +		goto error_alloc;
> +
> +	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
> +	job->vm_needs_flush = true;
> +	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
> +	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +	fence = amdgpu_job_submit(job);
> +
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +	return fence;
> +
> +error_alloc:
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +	return NULL;
> +}
> +
>   /*
>    * GPU SDMA IP block helpers function.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index fc8528812598..c895948f6e82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>           bool duplicate);
>   void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ab2556ca984e..0bfaee00a838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -52,6 +52,7 @@
>   #include "athub_v2_1.h"
>   
>   #include "amdgpu_reset.h"
> +#include "amdgpu_sdma.h"
>   
>   #if 0
>   static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
> @@ -333,9 +334,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   {
>   	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>   	struct dma_fence *fence;
> -	struct amdgpu_job *job;
> -
> -	int r;
>   
>   	/* flush hdp cache */
>   	adev->hdp.funcs->flush_hdp(adev, NULL);
> @@ -378,34 +376,16 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		return;
>   	}
>   
> -	/* The SDMA on Navi has a bug which can theoretically result in memory
> -	 * corruption if an invalidation happens at the same time as an VA
> -	 * translation. Avoid this by doing the invalidation from the SDMA
> -	 * itself.
> -	 */
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED,
> -				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> -				     &job);
> -	if (r)
> -		goto error_alloc;
> -
> -	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
> -	job->vm_needs_flush = true;
> -	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
> -	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> -	fence = amdgpu_job_submit(job);
> -
>   	mutex_unlock(&adev->mman.gtt_window_lock);
>   
> -	dma_fence_wait(fence, false);
> -	dma_fence_put(fence);
> -
> -	return;
> +	fence = amdgpu_sdma_flush_tlb(adev);
> +	if (fence) {
> +		dma_fence_wait(fence, false);
> +		dma_fence_put(fence);
> +		return;
> +	}
>   
> -error_alloc:
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> -	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +	DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
>   }
>   
>   /**


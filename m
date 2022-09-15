Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FF7ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 05:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B5B10EA83;
	Thu, 15 Sep 2022 05:57:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D185510EA82
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 05:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpmp3UVUzlGIYFmPLKkHYjl1cl8O2b9mgMl8mnR+2BwXmgWfjO8EqSwoHayVFDUYIuRh3ilSEbIit5WfqSJrjCfIsBpJ5c51gJdS5BoCNdOY1z5or9MZFnpo29lhg9oF00IvZju0Lnme5tWzMx1kLPRA12fWKm4YtMgI1FANiLFUXmmN3O5w/UuEQMbqQsPKNIrm1RgkXVoPf4g6rhnbX7zVcoR4OERceSqJfzZDRB57X1e5zZW4u+onlmF/30X/+qxHVdTC+/hJibQz8+Vj0WiDZ2MAhxkVC5mdyBmKspovJd8fTiwjcMn5uPx+E0ea9szUJnvdh81Kiw29/ahCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3er4SD2WBu6QB4O+GcDe73l/E7WlF1TIBjgMcQLUXo=;
 b=DGkiuSJmstImAznLYTQ0JnLtdVO8/2iWSZw3+9s1yDl2L3pCg2nFdApEnIh89Kq/cWP8td80Gz6+N75xUZ7I5EztWgabNYr9v04dpj8W/OwJM5y6scPq809vBi7ThBpMSHWEP94OKYxGPhKp9xYuFn/si29HQIHMOyMtpn0CadDgO1zWyA3PrIrIFG5aZfmDVx4bHP5icucV5Jclh8wpKbojY6pq8InkTSDZrDnkiZ+46e7UdlCbeq1/vs9pkJl5y9QNtp2d/GH8JX+9L5HXUEKK0rYkd4ZsloO/0acQvw6eVMgABlJXkeaMELQpa9HeNxvvgGUQP/RSew9CA50Z1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3er4SD2WBu6QB4O+GcDe73l/E7WlF1TIBjgMcQLUXo=;
 b=pf6pcbCpgh8XqXi4MoJ+NnloIVVbv7CKDlYeXoP8qNrhHIV4ifZT6DMyLbXUZ/SahDG30+h/BXD5639nTmr02Agr/5V6dAvV6BV96nrWd3vvsFWpbwqwZ4+guisExCUh8H7ijZRVP+TYboEKE2XUllgbdw1NAGcvQILXs7+jYhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 15 Sep
 2022 05:57:46 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0%6]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 05:57:45 +0000
Message-ID: <6d96d72b-cde6-ad13-ec3a-ef26cd0f068f@amd.com>
Date: Thu, 15 Sep 2022 11:27:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with
 ih resume
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <20220914101025.366954-2-Victor.Zhao@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220914101025.366954-2-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA0PR12MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f189a4-0bc4-4255-f01a-08da96df35fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvZmc+3kAH/99kLe1dMn9XhFPUZmEOAUIDhfd6IZXi30pVbHqHkGA8CQaC0/ABeja0/cDnr9uHPeBQICu/RnxBW0b0e7+qni6PeDCh2o+cJQyWqWcVz6BwKJtYuIK5MBKMB8nkoOzRtxOTqJaDutPlF5/jPGsEYe9F/tkj0ztyn37+85WhyyKAbUiWrrxCbB4d20kPOdLe6VA/7oTmX4s0IglOU1snMJL7uxnyYl2TNPMwKuYQr87CiE6J5PBDQQieweM30Q5lA67yYrAmHwei7TYV6JozC4J10vPxsjwzSKXULWcRzcVa16FuyyS7gFliFcGR6lDCxk72fAbalrH9BPvXqE/OyAl63VZio6FLAcCf0LVerVnngaNmGTRhJwBN9sa4zwdrPQ/FHBXICqs4scCJ0pWVfTNOK0IorheubSmmiRO371MWWRRvDZAJjwwVBKeqVUDqcak39AQq/f4mhIo1EwgbSXzPrS6DzU1UhmEBdmtCmgqOElCP+td76wqPQCPdkGm4eG48IV0wWd/M2YHUhlsAZaNKKEEp9sCpi2uYSCzM2uBcLE8d2quKyY/duVfN2L2LzX7OjZhTfeGXmUgDgMQ74f3pkA1KCoQvz6yeIPv4vfn7+cy7if+DL60IbLugYdDDG/zU1RpNZ8t4shmcgNXoD5gKKhMK08vMis6VTS0ea7LCalGUcTk9m+XrJbZUjRd1oz9yaRWZKihrtDLN9qrQsnSAEgPzlRqrlIU0T1yeI49it7SPdSP+jEUzt6yuP6N6EI0kq7za3KDwsK1mWDC3TLd0LoWjTAqwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(41300700001)(478600001)(2616005)(31686004)(36756003)(38100700002)(6512007)(6666004)(66946007)(6506007)(26005)(6486002)(66556008)(186003)(2906002)(83380400001)(8676002)(5660300002)(4326008)(53546011)(8936002)(316002)(86362001)(66476007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0oramNxdXJocXV0anhlU3BoY1Zudzkycm1tbUF2RXhFNEpHSFp3N3RYb2F2?=
 =?utf-8?B?d0lVQWFoK01JZmN1d1FsZmRGZHA1MUtKVzdDYlNYWVllT29SZ3JLbVdKMG5q?=
 =?utf-8?B?ZjBHbkxQaks4cDlFWGwwQkhJYVNwV3Y1VkxvUExiWTh0Wjd6UHpLbGFpOGdu?=
 =?utf-8?B?bkd1OEI0V3JmcWRVMnVROHpSMVBFYWRueXZGT1Q4MVJIaFNaU1VRdEYzbkov?=
 =?utf-8?B?TUpGdDhEMktJM3dhWUtndFc1MHFxWjVycWhWMUFGYitzcGN3WWtkZ21pSE5M?=
 =?utf-8?B?SkhWU2ZyTm9jNitTaGYva2NrYVVIb1pTYlhRZm1WdG8ybUFPdHUrWmgvd3ZB?=
 =?utf-8?B?R3FVdjV5ZnBTOWJ1Q2g0aHVRWWg0WER1TlBkdGFQaGlqNmpMQ1FRNEdUSDI1?=
 =?utf-8?B?bVFCaHZoS3RNTW5Zc0tDVFFGVXp5c29WcTlYYXRkc01zeDNtSHFMSWVQVU5h?=
 =?utf-8?B?MEo4Tk16ZFArQmJTNGxzVlRoWHYwUENHVXN4WmZNZk00Uk51MCtUelc4SG0r?=
 =?utf-8?B?alZ0ZDlucWZsSkUyMnZYT0FpOUswQzZYRFUxeEhnNmRIZWt6QnZZWVExUUFT?=
 =?utf-8?B?ZXl0ck4yeWFQRGR6NUQzSXExTWVCNW5KM2w5Z080RjNLVWFYWWRQbm1Udnlw?=
 =?utf-8?B?bXhWTlEyOVhnbzlMZkJaYkRYa2JqWHRiR1lTTFd5Y1BpcDVPYzVoOWs5eDEx?=
 =?utf-8?B?d0oxZEVPRUNwRC91bFNhVVNxcTN6bmNWbDk3QjJjSG9JMHYzT292Zyt4RndZ?=
 =?utf-8?B?MWJ0cXgrRFoxNFJ4dTc3MUV4ZmpEcG9tTTVscCtYbHFaaktEeHJRaVJBNnRC?=
 =?utf-8?B?MWpSc29QZWlZK2MyajBocEE2R01UN3NaUmNrZTRxNzdVaVprRXlqU1N5WEkw?=
 =?utf-8?B?UjBrb2t5VERZdE9XaGxnWGdVdlFtNXdzL0R1TzlXMk96alFPTXJrdlRPSFJo?=
 =?utf-8?B?eHN3R2IvTDBNazNwTGdOWkdpcnBnbDNhcWpQazZCMCtOZmFBeldQaXF6NG0r?=
 =?utf-8?B?SjRjWGw0VWJTY0Y0ZnUxZmppRTlFWXErMTA1Tm5mL3ZqNklSNUxjS2sweG00?=
 =?utf-8?B?SXA0Z29LcHZLQWxjdXAxYWFwYzVnK2xCRWdQM0R4blp2MWVHaTZQbHBjZGNL?=
 =?utf-8?B?RUhjREhVZEVCSlhNMnN6WURKRGtpYjdyK1ZmV3liaHU1ekEwaDRpenMyakQw?=
 =?utf-8?B?bUZlSStSNEZ6aWJOaWFSRkRoU2owZ2RPZzJjdjRFK1Z5RXpsSnYxTEVoaWpI?=
 =?utf-8?B?OEV6SldLTmx6bERaWmZtWEhLS2lwcWUrYmFWNjc1OGpDSUE3UTFXZTBERzE1?=
 =?utf-8?B?RXo3WlNXMW01WnlUbkhRYTNacjJ3d0YrOEdwZkpoRytRelFSOVF6dS9uckN1?=
 =?utf-8?B?aiszWXJSTk42L1lhRUdUWFlSQ01OSS9pMWtDVGpzSTUyKzd6SDRrajd2S0Fr?=
 =?utf-8?B?b3BHZjhtby9oaU9mQjlzSG9LeHFKTHprS2drcUdPMEYzWVBWckU3bmZSQnZi?=
 =?utf-8?B?NC9DTW9ZRCtoMnVlS3JBeHpDQ1BoVGRJaE13QkoyTTBRMDE0S2F3NS9haEdR?=
 =?utf-8?B?L05aM2E2VVAwZDV0bWZEbzVOamtWcGtSd0lDMzdFWTVQMnF5WGRNbm9RMUtJ?=
 =?utf-8?B?VnR3OFcwQXpqM1RrQ2FCQm44a3U3Y010aDdpUlp1MTFyRGN4a2J2ajE5ZHgv?=
 =?utf-8?B?SlFaWGdjbHdscWNOUXp0Q283SXJ6dHJZbTdHOUFvVGc5Y3pBVmpCQ3RHeTdt?=
 =?utf-8?B?dWc3Y3R1NGNrNGs2WWx5UXNuVGNSNFdSbmNEUFhVZy9tUVBDSytqaG0ydEdm?=
 =?utf-8?B?UXNKU0d3SFg0OG5pNDBkV2ZZaVBDZUJmK3A0azZGdVhYQy80V0pyRTN0RW9u?=
 =?utf-8?B?ZURqeVpNdldncDdwY3A3bDlrMVZDbXRFeFlsRTFIR09WQ0J6QlRrVHZGR1ph?=
 =?utf-8?B?ZE43WG95a2hLY3pIVXVqVmpFNCthRmg4bVRtVVZFY1hNc3dscjZYSjRTOEJn?=
 =?utf-8?B?TFlxamQ1WTNjQzBDR2cwb1hSUTFKM0NYZnpKNVl1V3FwVkFyOEs1RmVlRWE3?=
 =?utf-8?B?MjdsSU9ObEUrNHZZSTNlZXFlYTR1OWhmWW5PSFpUSG5mNWxrQitYK3M0Tmtm?=
 =?utf-8?Q?4sDwn+tpBQC4nhW4/PRsfedxl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f189a4-0bc4-4255-f01a-08da96df35fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 05:57:45.7426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv49Va/sB2aepjTuApCfEm+SpHZ0BQo9CsRffDRzpmRrD+4oUt30BmcNzHUlG5SM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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



On 9/14/2022 3:40 PM, Victor Zhao wrote:
> [background]
> On current sienna cichlid mode2 reset, on the slow job hang cases,
> since page table context was reverted to completely stop gpu, it
> will generate page fault interrupt.
> 
> Since the irq are open during recovery stage, during ih resume step,
> if this interrupt was in processing, which increased ih ring rptr,
> and ih resume meanwhile will set rptr and wptr to 0. This may cause

AFAIK, only GFX/SDMA are affected by mode-2. IH is not suspended before 
mode-2. Why do you resume IH after mode-2 when it is not suspended? Is 
it a special case for virtualization?

Thanks,
Lijo

> rptr greater than wptr. Such case was not handled in ih process,
> and it will cause rptr continue increasing util reaches the max.
> Such case will make fence fallback situation happen.
> 
> [how]
> Move the enable of irq after ih resumed and before ib test.
> Adjusting the position of enable irq on other reset paths accordingly.
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 1 +
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c0cfae52f12b..0b658225e9ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4625,8 +4625,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
>   
> -	amdgpu_fence_driver_isr_toggle(adev, false);
> -
>   	if (job && job->vm)
>   		drm_sched_increase_karma(&job->base);
>   
> @@ -4758,6 +4756,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
>   	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
>   
> +	list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
> +		amdgpu_fence_driver_isr_toggle(tmp_adev, false);
> +	}
> +
>   	/*
>   	 * ASIC reset has to be done on all XGMI hive nodes ASAP
>   	 * to allow proper links negotiation in FW (within 1 sec)
> @@ -5031,8 +5033,6 @@ static void amdgpu_device_recheck_guilty_jobs(
>   			/* Clear this failed job from fence array */
>   			amdgpu_fence_driver_clear_job_fences(ring);
>   
> -			amdgpu_fence_driver_isr_toggle(adev, false);
> -
>   			/* Since the job won't signal and we go for
>   			 * another resubmit drop this parent pointer
>   			 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 7aa570c1ce4a..953036482d1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -240,6 +240,7 @@ sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
>   	* Add this ASIC as tracked as reset was already
>   	* complete successfully.
>   	*/
> +	amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>   	amdgpu_register_gpu_instance(tmp_adev);
>   
>   	/* Resume RAS */
> 

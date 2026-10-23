Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CE606A33A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q1YrgABX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6010C10E629;
	Fri, 23 Oct 2026 09:30:55 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F04410E629
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R//uNx6zHyUuEBmH6mQfPF+K6cygcUug0difryEUCfiQUoWDffExPP4v2bbAQaLn/zzNS2Fn23sbtPIll7H4s6AL1zFnkHYabc0WrlKgBAYO7eccUOUFNFq023AF/pGRu3F2zj+QettitPo98mFl/gWnKrM7nnTliIPY3nxDPzeBbYAzrSwvTnyM2cX5jtGgLTV0qJZq+oy2CBvzjJRHoKKIoO/SXxEpwB3WMdlaz97ADhVZTm+Jrn0VE+ZcCJ2qxgKxz6Opq0AxIPqA9P1lDjuAw4aiidEsDQXJmSbCH/daU81r1vT97gkRPpGnjcmUX2/uXgWMorZAhtm3fl0Jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDYzKJ6Q9QLxlJYR1BjssN7aYsG+xL2nE+Ibl/bWLRg=;
 b=HnX+R7ouusjPnJ/KDMNUdl9NduotfSy6dnLBhI1TabpbR6VhHaNbVin45eKOd1pPSW4KYXldo6Bi9oepjbBc6dA7Z8o/XWe/gYFQ0m9PiimkrZer4TPRxCE8mBBl4wD6o3d4ElrZokSsUuX7ROoosmJqGRSvcnv+A3gXmozvuzPpdThjBodlMjBNU16W7Ob+cuss44t7Ap00G/I4/WdmG0R3yJD1y4VNw6Oy7riJ0fwQ+7UpmJ5N/kCumWIZ830TO4tbHcCDFooWsCWKWLXFNBaKmIoP6iXIb2KR+LQ835Uu+0q5ZLwH3XDVa6uuFA1iT/qvdregMDSUP7V2nbZdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDYzKJ6Q9QLxlJYR1BjssN7aYsG+xL2nE+Ibl/bWLRg=;
 b=q1YrgABX8EqF52lxEMJMeAYdu13x4LjMXaqdlOzDSUMEeV/OLDuF5SQTL3F3fclWvJ9UzyQ/cpD+fpHmIX8eUrowYGv/llBzYnszgEtqat+P9Dl43fI60DqsnKL5tqeudpnSgv5enJiyBBlwbcv9d1TY0DmgoN5UhE4aDRzehWg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 09:30:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 09:30:10 +0000
Message-ID: <6ed37c0c-eadc-406c-aeba-f86a522cf827@amd.com>
Date: Fri, 23 Oct 2026 15:00:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu: stop the schedulers before preparing the
 GPU reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-7-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261023083422.3049246-7-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 083f612c-1dd3-4a5d-d872-08df30e83bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ngdKfodp2/jRmqsK2N1oriIF9+NCkd0hgB2KnWN6beIb+5Sox5LAxUSoWnvSe33z+w1c14KH1Vzyeo/9U27Kj/i7SGVl1Fe2XhrZU2eFa6LLCRvTIEbHB+l3z6uLMCocJAGJknBe8deCOJyCqD7pUZ9eUNlUownIVc3UPHhmvjPkJQD3v2LyB7hMAvkAgFOhEg6rMNUEQZeC4AHsgmz3E4vj99GDHAudblzu0FG5XCle/IKsILHOG1sif+cLcnFLONKUah0WhZiMoAukX8ILzYzVEyE4Atuoyg0nDxIVe5/kHyqQPogNnm/9xYQTlCa/NZySAxZnuTGjpy0pDkHHl36Ftm5+Hbamtgqj29B4EN1SBpNJF70VbQrmwNj8vr8s2Ynbev5xeotPfL0mZoM0bfqHSKbS03MUB9rDxT9byQHtFEfl4VoV2xBpXUMX4ecTu1TVZhrHaYiEtexuch6tTmkNGwiKlxq5DER2rEODlaotzOedn5Phvtt58vYNxoc/I/xp3u6nLHTDeFrzzW55doWWdrJ27GdkAy/t9IpXoXIP8CR/C+ObC+B8uIceB9lAn+VuyGFFCow9Sv2tV0tb5TuXgCOjAUgYm5kORL0TwvboaFUIb+dwJk9OEvoR5Ryrn+8CdjdzQc/1/vuB6hCBZ2LG8IwYgTKcWX3wu96lZk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXlMdDl5SWdPVDdYSFgvTWRBK1V0Mi92TGxISWNtblk2U0Z3M1l2QjdkeWJS?=
 =?utf-8?B?Y3RzUUtFRnZlN0RPL3hnM0FCci9BL2hhMVdidFpDdm5zL3o3anRyKzZGSkhE?=
 =?utf-8?B?cmRmOWpUdVZRWGM0MlJuNUpYcUFKNWF6aHdWRm9wZzJabXhHdllnQm5Zb010?=
 =?utf-8?B?R1BRbXNKNEpkanMvY3NjRnVMY3ZwMHppUWl1QWZpZlZYQTFHSVppVVM0TG5k?=
 =?utf-8?B?SnpyYXh0OEFIU2NKbThtZ1pzWUc4Vk54VTFjaURIN2RaZWUxaEVUMHF1dStE?=
 =?utf-8?B?SDJqdlliZ0ZjcnQzSWtvZXkzb2hSaVU2UFdPYWlUWHAyUkVESmtYY0ZFckRu?=
 =?utf-8?B?MFhXSzloWDRHWkZrUEcvT2JuNEVYemJEbU9xUWxoMzRZMGVNSFdZNUdqbDdo?=
 =?utf-8?B?RG1QY0p6azl6QXhOUkF3Y1I2cytEUVpkRlVjY2dPR3I0UVdlUXAyWFdBSHpT?=
 =?utf-8?B?L2E2RUlzWFMrQlFGWjNoS1Z6aitwSTRYd09SZkJWRDhWMFhRb2lwY1RxN09F?=
 =?utf-8?B?SGdPSW9TWWRMVEJFLzYrVExIYVQvank0cjhWVEhkU2N1NVcyaFNMemFhWHd4?=
 =?utf-8?B?NXA0VXVMMHRyZG9CZGV6aVhCbXpnUEwrR29PdENueFhzYmJYZlEyY0JuQXZo?=
 =?utf-8?B?NFZNUkpyMGxPUzIrQm5YV09TQjRKWUR3blpZM0NKVWtQYVZIbmdnU012TVIy?=
 =?utf-8?B?Y24veEhReFhCNHF4bnY1RzRnMExGNHRtZTBXRENjVmhFWXBoVHM1YUlUeEJX?=
 =?utf-8?B?Mk1IaDZaaEhKNG1pa3h6WGJUNkdKR2tlVkg2eTFTb1lvS0I3L1d3cHhQVncr?=
 =?utf-8?B?cGZIdkRCTmxTa1FxQStkT2liNDVYWnBoTUtmd2RDWlF4a1I4c2JNeFNIYmZX?=
 =?utf-8?B?OGVVRitLMmlBTm1wUFJRM2lJVEtaTGd0eG9mNitVN3U4cjdYY3gxR0VoNHl0?=
 =?utf-8?B?QzlEUFJkeGxER0FuRFNaZmZwaUxrMENrTnQ0MkpuRDVac0JmU1BQUi9ETStT?=
 =?utf-8?B?VFp4cGh4RXU1Tmt4ak1XZDlQK3BVRWkwQ2RYODBrTHl0bzZaZ3VkblpjWklG?=
 =?utf-8?B?Tm5tYzZXcEZIWlVnN0o4NC9OaklxZVg5NVUxcTdMUTdrTVRPVkIzUVJSVHl5?=
 =?utf-8?B?L1JYb0JaZFhEY2FQRVVqTVFIZVdRVlV1SjRmelgwRG1EeXcrQ1JBdjdlUDFk?=
 =?utf-8?B?NnVhVEhocUNIaENzUU1ZWk9oUWt0MnJRV1FpTDdDTTVxZWJCT3p3bGtIMjZB?=
 =?utf-8?B?QWh2S1lHWmsxRXpsNUhNbUtTUzVMZFRNQkt6dnJVYlU2eFhTbVMwTkdXU3hm?=
 =?utf-8?B?Qkg0dEY2MmR6aURON0Y0c0R5QXRwd0c0VzZrTC9nbm5tYm05VmpTczBnZmJF?=
 =?utf-8?B?a3RPRW9veC9UYkFNV3RyQkk4VFRIZVZ0d2x0RmZEZE1sWnE0TmdhQ3E2M1N3?=
 =?utf-8?B?d1FXNjZrV0kxbFYzWURON2Z3N2dYa0xhNGxaaTBjN0ZhVkF3V1o1SjdRQmFt?=
 =?utf-8?B?bHRxR0NjWm1tcVZza1V5cGFzZFd2UlRiM1RmSVkzTDZwUlJHcUROUWh6WFov?=
 =?utf-8?B?a2VxV3B6TzM5L0Q0YVNjY2ozREE3QWZzek5XVVdtLzFMM1lBbUo4aXZ4d0lY?=
 =?utf-8?B?VHlkaGF1NmFzRG9pSTNvcWRlU0JwNVVMQ1RDYU5hVHhKVGo0MjVLNTFYZzVv?=
 =?utf-8?B?aXJDWjI5QXhnNmEzWnZyTEVhdG16cmJtQzE0ZXFRSFMxODFZbWMvR2t6L3Zk?=
 =?utf-8?B?NjlBWDY1Zy9TbFNFU1VUbDc5ZU1oTlAzWklaNnJpUGdyWnhPemZUTHFWYys3?=
 =?utf-8?B?dTZTNDdiUFAreFFoQjdjbFpma21nN3czZjY5dE8xVUllSU13dlZoaysxNlVj?=
 =?utf-8?B?b0VjRHhMNlZkZW1FZTVIdHlNSHIzTXV0Y0IxaG04aFBFcHhsYktoR0dHcnNn?=
 =?utf-8?B?NzJmY1lNL1RmNWdUWlZMLzIwSHRpTlNhMk1GTmJpRHlWK1F0cjFsSUprQTFM?=
 =?utf-8?B?YjlZWUdNY0ZLclJUby9sN2VnSG14ZEdDeUtJME5HcWI2V2Y2TjIvRVJxamtW?=
 =?utf-8?B?ajR5VDJ1LzdiMjlOYXVBZ01YQmozeU16UFZuWnFEYTRYSnVRZitLRU1mNXlC?=
 =?utf-8?B?U1FCcFpKZ1VoRlB2dENUN2hPTWx3d2ZtbHFEeE9TV0ZEL2JleThYdFhBRDlH?=
 =?utf-8?B?ODMvVUMxQ1krTmNxaVM3dHFTRXNJY0ZCVkxFQ1JMdW1MYWtHcFpsWGFnRkxP?=
 =?utf-8?B?Z1orTzFHcFhVM0VWcEtvdEIrSEFOc0kzMUVlQlgweUhmMEFmc3B6dkRUYnox?=
 =?utf-8?Q?Hhqbcrh3RJgQ1XA5kS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083f612c-1dd3-4a5d-d872-08df30e83bb7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:30:10.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9RWblvIdlKyNSMoR2iCcRhAivBH0nJG3jD8AegcekAvc1Nkss+inw8bkeHf/HwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 23-Oct-26 2:04 PM, Prike Liang wrote:
> amdgpu_device_halt_activities() only stops the ring schedulers after
> amdgpu_amdkfd_pre_reset() and amdgpu_userq_pre_reset(). With a hung MES
> every REMOVE_QUEUE in amdgpu_userq_pre_reset() waits for its timeout, so
> the schedulers keep pushing jobs to the hardware for seconds after the
> reset has started:
> 
>    GPU reset begin!. Source:  6
>    MES failed to respond to msg=REMOVE_QUEUE fence_wait_ret=528494 status=0x0
>    WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
>    Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
>    Call Trace:
>     amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
>     sdma_v6_0_ring_set_wptr+0xa6/0x180 [amdgpu]
>     amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
>     amdgpu_ib_schedule+0x64a/0x8f0 [amdgpu]
>     amdgpu_job_run+0xa2/0x220 [amdgpu]
>     drm_sched_run_job_work+0x10c/0x300 [gpu_sched]
> 
> Stop the schedulers of all devices in the reset list first. None of the
> preparation steps needs them, and jobs submitted meanwhile simply wait
> until amdgpu_device_sched_resume().
> 
> Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Same question as before - should we keep memory management related rings 
running till user queues are stopped?

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 28 ++++++++++++----------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 20f02dd14c41..08395cca18db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5534,7 +5534,21 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>   	struct amdgpu_device *tmp_adev = NULL;
>   	int i;
>   
> -	/* block all schedulers and reset given job's ring */
> +	/* Stop job submission first, the preparation below can take seconds */
> +	list_for_each_entry(tmp_adev, device_list, reset_list) {
> +		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +			struct amdgpu_ring *ring = tmp_adev->rings[i];
> +
> +			if (!amdgpu_ring_sched_ready(ring))
> +				continue;
> +
> +			drm_sched_wqueue_stop(&ring->sched);
> +
> +			if (need_emergency_restart)
> +				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> +		}
> +	}
> +
>   	list_for_each_entry(tmp_adev, device_list, reset_list) {
>   		amdgpu_device_set_mp1_state(tmp_adev);
>   
> @@ -5570,18 +5584,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>   			amdgpu_ras_suspend(tmp_adev);
>   
>   		amdgpu_userq_pre_reset(tmp_adev);
> -
> -		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> -			struct amdgpu_ring *ring = tmp_adev->rings[i];
> -
> -			if (!amdgpu_ring_sched_ready(ring))
> -				continue;
> -
> -			drm_sched_wqueue_stop(&ring->sched);
> -
> -			if (need_emergency_restart)
> -				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> -		}
>   		atomic_inc(&tmp_adev->gpu_reset_counter);
>   	}
>   }


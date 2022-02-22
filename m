Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAABDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 18:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681ED10EC5F;
	Tue, 22 Feb 2022 18:00:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF1F10EC5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 18:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn/Q5SzZZ/YEn4JdP4Doze0X9uD3nKDXk9MPxxXmMkrIJPgHuIZoLpnezMdhJS1h7uwbUygOUBTbhzONrBFhF7uNBBN4QROKQUrrrVZ8U52LW1IR6/USb8quRyDl3D48D4y+W9mqPO5eOoAxRI3rC+4rZrL7KzL4W3L/lxNXJucQYWcFKdyocrwtYR9XUbLcNLawWjC7XiBMBFUpJBwFTmV0w4UjwH3u9NrtITqJlW+1P/YJ9v7h3gE/U2jVnyi3xSMgDaJe5MVZ6/ww5b9oOqvy89KB+N2nYWJhSfLYOLXLevjMgep3uBUogciNBhdSghgO7ymaFqyY/bQWBlG2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MffUtgik94/bqkelT4r2XCstuSSTEOSjSpybpfUn42o=;
 b=CpdqJvofaGYlvMNiYh71zt/Xst2zOF4o62WYK0jHCEAgGDQvxH2enudDhpjkVG2sGjOSGPT5QcwcHI5Lp8NWL9RM4x+W+HRD2R20eaA7OhXll/VUOoHnQHvv5gdsC6gJh1DEiS7ME8KJm55HzXNG0HKeqjflXsyfW79fPsW3vckNETQ3Mlsry6dXRINfc+BwgvnRfhWEEO3322fp3UtPD+8qdRute7HH3fb2BBtekZhFetQgNUXJgw4P1fXldKEQiWvhOw7GgdeW5VF8IfBCJE8l+0r3uV1+E6XcfO+h9MdQAZJOWccXSUtE4d7o+Iu+YH11cW/UJvr0q7cfwIlk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MffUtgik94/bqkelT4r2XCstuSSTEOSjSpybpfUn42o=;
 b=dh1U5VtWlulSMAU9b+6k/w45dK6ZapXnhADQj4ZPMhNpA1b9BKASFz8xpBxmuttl60PpxAAXwsKSZ3lzdjOuRDoG6bZHh+TYOaEjxHZ0o/09f36k44fFWcR8UKBXcW9ogizy2OC1y9pm9hiuF5RYZ1Hfn+hULqTofqQR92DVlVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR12MB1141.namprd12.prod.outlook.com (2603:10b6:903:44::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 18:00:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 18:00:46 +0000
Message-ID: <84966d40-ac5c-5fc1-d098-6a19a1d680ef@amd.com>
Date: Tue, 22 Feb 2022 13:00:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: use ktime rather than jiffies for
 benchmark results
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20220221223030.5672-1-alexander.deucher@amd.com>
 <20220221223030.5672-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220221223030.5672-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70fda67b-7f08-4855-df91-08d9f62d4062
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB114163B28925F7C2D29D3F14923B9@CY4PR12MB1141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wp6trthALNZEMkVl18WNeakEe7SjulLkZZoT78hGVYCKFJXl3qE/IkAlfxxUs49YkGBwD7G2I/C1hNZNQVA6f9+bA9gbaJKkYNwxq+v7P7UbdolCjZEUrmWoJppwqZd/LlOZTVKTtNbNSJU4geKfnLyLsr3TBlZUhjEs6PpnI15oTzbwxO3Jylyx+Be8MDGPboyeL0ZW+sf1YzPM5qzmNbh09/aj/Nh5uJpQ9nDvUkFgRovQyIg6gs5TkkUn2ezlWy0Ftx6DB1SzU/oVJGwxQTdJEYaqeQBhv0OFJIJeMgtqQN70NDzPZhNXdwN7fBPwOyad7htSxXG6LlxjSPV9hNc2i/ol2efpYbAXLN18LfB91RR1QpbtmKVqcgC2lzWrimSm9FTKiT5RxxJkBjU2aZLICLv9kMiU8TJdJxt6vH6qEWQUkrgj3d9w2L3SVnqnUaEIyeIdIvT5wAaZEDYWz4alZjrGH9M6+ujjfUiZghk1OMMp0YKfxUzp7YwMwWG+uuf8seIo54nEi9QKpU/X6+NUMwseikfRq724msp2WyAq2EKRXFU8U940CEfuUiFczizo7Ro44Segjy/gywT86EhbEDhI3zeCjv1GUXrd5vsMKziT8dTB+txDl9gdlEViZNeW6vuUzCvM+dinpm7wUmpcmONlqZel80sL6QILi9vBsuddmBR7fJ1XE28NKzCfEL654ILlT326hwkyjHiVjYao1lftANPZ7VZcGfYf343gcRhwUXeFo9/Ov16qlX8c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(66946007)(66556008)(186003)(26005)(31696002)(86362001)(38100700002)(5660300002)(6862004)(8676002)(2906002)(83380400001)(44832011)(8936002)(6486002)(37006003)(316002)(6636002)(31686004)(6666004)(6512007)(508600001)(6506007)(36756003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFd0TVFIZXg0cUFSTXVlQlB4eTFraVFJM2UrVU1BVVdyQXd4eHRJK2g2UGI4?=
 =?utf-8?B?WGVEb0pBemt1UjB0TVBvKzRDZEkvK050ZWJURktYaDhVNERLdndtN3dBeExB?=
 =?utf-8?B?dEpLbVorcXRLZFpvZXlzTEFZdFJkWlphVnNPNmVvdUt5V0VHZ3hVbFZQSDI0?=
 =?utf-8?B?R1cydSsxNWpLWE53dVczWU5nZis2K29scVpGbGk4dlRBbDFjWklYNnkvdlZ5?=
 =?utf-8?B?ODFQcjM0dGxRR0ZXNnlvTEg0UXhSblpHanJsYlVPRWprMFh0UXMzREtMWnhT?=
 =?utf-8?B?UE52OEFiZnEvaG5wbHQrRlBmQW1sMVh4bE8xUTJHbm85QzlwRllzdUNQUXl6?=
 =?utf-8?B?WmVVR0hkdDRpbFBZeDZmRlpLYzlDR0JKK0lrZjlFcU5tQ3JzWDBQYXNLRlpE?=
 =?utf-8?B?VFpJaXhrMkZROEdVbkZJYXMyemRsbmVvYjdrTjFxcEVrLzVnRVdhVlgvaU9x?=
 =?utf-8?B?YU9zYmlZUUlsWkpZbEFhOXN1eXl6bFJoTGFtcTRuekQ2RTFhcmFaMGo1QVlX?=
 =?utf-8?B?djV6eTJ2TnNXaTVPUUVHNnBPQ25qR284Zk5VZnhuOWZuc05oNVFKTFg4c2c5?=
 =?utf-8?B?U2dzdWpQTmNiRkJ2RTJKT3NiVEgrajl4bGNlNVNOVHJQN1lpMnhGdUM2Qm4y?=
 =?utf-8?B?UFU4aXNPYlluVmxEalZQMmFrQmZQUU1UTGczbFMwN25NdFcrYzY5aGtid3Zl?=
 =?utf-8?B?NHdraFFQbVBQZkhmb3JodjdaMTltU25ETUxSeHdpSWFJNC84aVNmV3VBTkRz?=
 =?utf-8?B?Mm5EY1ROZTlJaGFsNjFQOGJ2RTZhcitPOWZHaUljeGtoMjlhckdSZWxjeFFi?=
 =?utf-8?B?SHRpMThSUkpzVnZuUlU1Y0RBZ1ZOWXNMdVd2OE5qU1c1dER3KzQzd0diTm84?=
 =?utf-8?B?T01SaCtvQVIyYnJzOVZsSEhYNlRoREovTk1ybS8rRENPQlNheVErS3FXNURw?=
 =?utf-8?B?cTVRdGRVMWRMYVRnQWRSZFIwOVQxSnVWL0dRVGhTeHhlZjQwSEs0MUIvUHVU?=
 =?utf-8?B?NnFSR0FIeGF2QTkxNUkxTDJvMVozK0hma3dCaklxelQzNDJYU3Jnc281MzF0?=
 =?utf-8?B?SjFaNFU3NTVLek1MVmcrQTlDTm03Znh3RHZibkJIVzlmbW5vYlh0dHY0RGlw?=
 =?utf-8?B?Sm9FTHN0SmtOdmJuNGZhTC9FS0toaWVLSnpIa29PUlRvaGpKK0Q4a3o4Mklj?=
 =?utf-8?B?cjhVbXVGbXFXYTgyeEhsOGg0SVhHRTdMazNEVHByd0p6SXJNMnNuY1VOcXBM?=
 =?utf-8?B?U2RTZTV3TW1mbEJLSnIwVno4UWdRMDZsUXE0aTNOam5lNEpnWnEzckRPcmlz?=
 =?utf-8?B?M3p1UFloOHZRTVpKdUFtMm9YTXZhUnQxN3VWc0FienEwNHgwc2krWjA3em5z?=
 =?utf-8?B?Qloxbmp6SjdIVlRyQmxaN2x2dktvV0VPTjhhWHJLR0FoWW83WjZlVlkwamhx?=
 =?utf-8?B?WHY5aVlQNjdicUMvTGQxb0hDdUViVlVsYWVGZHp4eEdnOWNYRWhnaW9Od1hZ?=
 =?utf-8?B?WTQva1lBOWx4dlJJeTUrc1lhNDlBN1JkeUpIcVJHUFZjYU1TaXE2NFk0S3Bs?=
 =?utf-8?B?K21xK3VOemx5VFJmeVM0dzlXc2N6dGNIRjY0a0l4K0hacXhDbVhQWEtnZzdw?=
 =?utf-8?B?dmtuemphNjFaYm5NbWVwWi82Qy82SEVDYmRFVWhjNGRrU0lYSnh6WHVrNVp1?=
 =?utf-8?B?bU9ldHNIdHJXMGd0SC9WcmN1MHhVMkZWcnZCUmpiTVJrcFZoTUc3RzRTRStw?=
 =?utf-8?B?SkYwcUdUbGhJRUx4Q09lOTZoT0hzV2luamIwVndzaFBLRU5yMUhVdTVGS2dF?=
 =?utf-8?B?TmVtQ0I4cE5SS0w3L1dBQkhKb0RrSk1hNW1tRFRuTXM3Q01pUkpTVTBseDVs?=
 =?utf-8?B?YTVkTGlmZUZiMHFnNzZ0TGhrQ1pJWjdWeGJ5WWZDek0rdWpDOWtWVGZBRGxC?=
 =?utf-8?B?akEyNCs3N1ZDT0tvajMwaUdELzV2YmhET002d01hZGZPcFRSbUV0ekV1VkdL?=
 =?utf-8?B?WFNJSjBLWmJkaFBRZktTM2hWcmxyY1ZsUGpGSm1ZYytXcnBXcTdzbXZUdkJP?=
 =?utf-8?B?bFdwcWQ4WHNuenl1UHBuT2cwOGZBWEdQeW9yd25xUVlsK2V5ZzZhSVljc1E4?=
 =?utf-8?B?SXFMbFBKSFVCem9hZ1AyNStNM3ZtamM2UkRUa3R1dmpsb1k5ek50cExmWUxz?=
 =?utf-8?Q?G/VLiaA2280Wc2GTcQ1rRC0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fda67b-7f08-4855-df91-08d9f62d4062
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 18:00:46.6630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOdG2QUdm0Wb9Fhp2CArL1sE2gwEd9f6628gASLB1jVFx4CZwe1UezDkrOombYszlKmXTctjG0ofUQJywghyZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
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


Am 2022-02-21 um 17:30 schrieb Alex Deucher:
> To protect against wraparounds.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 31 ++++++++++---------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index 92a2ffefe62e..3136a9ad2d54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -29,14 +29,13 @@
>   #define AMDGPU_BENCHMARK_COMMON_MODES_N 17
>   
>   static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
> -				    uint64_t saddr, uint64_t daddr, int n)
> +				    uint64_t saddr, uint64_t daddr, int n, s64 *time_ms)
>   {
> -	unsigned long start_jiffies;
> -	unsigned long end_jiffies;
> +	ktime_t stime, etime;
>   	struct dma_fence *fence;
>   	int i, r;
>   
> -	start_jiffies = jiffies;
> +	stime = ktime_get();
>   	for (i = 0; i < n; i++) {
>   		struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>   		r = amdgpu_copy_buffer(ring, saddr, daddr, size, NULL, &fence,
> @@ -48,25 +47,28 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
>   		if (r)
>   			goto exit_do_move;
>   	}
> -	end_jiffies = jiffies;
> -	r = jiffies_to_msecs(end_jiffies - start_jiffies);
>   
>   exit_do_move:
> +	etime = ktime_get();
> +	*time_ms = ktime_ms_delta(etime, stime);

Milliseconds are pretty coarse. Would it make sense to use microseconds 
(ktime_us_delta) to get more accurate measurements instead?

Regards,
   Felix


> +
>   	return r;
>   }
>   
>   
>   static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
>   					 int n, unsigned size,
> -					 unsigned int time,
> +					 s64 time_ms,
>   					 unsigned sdomain, unsigned ddomain,
>   					 char *kind)
>   {
> -	unsigned int throughput = (n * (size >> 10)) / time;
> +	s64 throughput = (n * (size >> 10));
> +
> +	throughput = div64_s64(throughput, time_ms);
>   
>   	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
> -		 " %d to %d in %u ms, throughput: %u Mb/s or %u MB/s\n",
> -		 kind, n, size >> 10, sdomain, ddomain, time,
> +		 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
> +		 kind, n, size >> 10, sdomain, ddomain, time_ms,
>   		 throughput * 8, throughput);
>   }
>   
> @@ -76,6 +78,7 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   	struct amdgpu_bo *dobj = NULL;
>   	struct amdgpu_bo *sobj = NULL;
>   	uint64_t saddr, daddr;
> +	s64 time_ms;
>   	int r, n;
>   
>   	n = AMDGPU_BENCHMARK_ITERATIONS;
> @@ -96,11 +99,11 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   		goto out_cleanup;
>   
>   	if (adev->mman.buffer_funcs) {
> -		r = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n);
> -		if (r < 0)
> +		r = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n, &time_ms);
> +		if (r)
>   			goto out_cleanup;
> -		if (r > 0)
> -			amdgpu_benchmark_log_results(adev, n, size, r,
> +		else
> +			amdgpu_benchmark_log_results(adev, n, size, time_ms,
>   						     sdomain, ddomain, "dma");
>   	}
>   

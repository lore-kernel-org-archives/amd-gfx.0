Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37015C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97592112BB4;
	Mon, 22 Apr 2024 15:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZPJpwNJM";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6A2112BB4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:01:14 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-34665dd7610so2226804f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713798073; x=1714402873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXOtpB0ScgUIa9nBqei9jHpbkoYco7gDG+b5uGXDHi0=;
 b=ZPJpwNJMkqTDtWW9nAKp09EXasPO/tN1uwA5OL6NeFMNrHS+K3bVHEcqaMcTrjTf4+
 QYHlhYdk8LzrIahjBLxmvplF2+9hIo7U9hWMM+wY6iGm9C+ekr+tI18ydZxEkACBxopB
 tjtt4MNy8nwrsNzTuEAEsNwVKIUdRkAR5QVOU4c8E/mO4eVkgB76JMwdErutA8/SESIY
 KzYOxdChJ+p8+u/jgoEqEVzt1GiYIF0OtQDSiTK7QJ4J093Ajd1M2cOeuthvkH2KkF92
 6ChLBTJSs9UMSsr4jD+6tfgiuj48j2AadW87z3kIwi2B+Z7gA8ZUKyRNiU1Lp/4h5rTe
 QBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713798073; x=1714402873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXOtpB0ScgUIa9nBqei9jHpbkoYco7gDG+b5uGXDHi0=;
 b=LPBXNZPQXAklvIa96SDhBnFdeoOtq7aHHVIfXLycQgn1W3HdMibfOhKcxDBIbboM02
 mbycdOz32r1tD8xMKpAy/tbF0cKPd+iWi7XzmHRnpwgH5mPc1tGwHvoQwWr0PSTBiRHW
 ZdfjaEwJur2Kd/j+cjGaUnKP9KG1uum4RJtRNqqpYeydQZBNAcZzmUQOeFqk6Wr9RVpp
 nSZwr1QYrsBnvCwqN3yUGba0tQttZY9nHrBXFhIlxugz2v/vbw/DT1NzIM+UgQvDxt/W
 MiEeAzGGGkEf5RPWiB+tepvyKsPqAxfXbLDGOm1qxwBjAQvKtKShc8+92hCCl/Vh1Szl
 P6OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsQ/j2BAcopxQCruVYkR/g6UaQvI2bFwvXivRl7Xnw+iX98Dg438XPVAViqFoMA/JSkKhT8O64Dc1dX7fe8Np/ijFv7c6ZYS7WqUAnYw==
X-Gm-Message-State: AOJu0YwclzkzqzlXrFxeltrouryfSSawaWqiAi+FflM+8SIHGdkSTLGH
 AirmVS3IdND6xOp8/UN0eWLUf9ncoNMP71k7MFlkeAryBCD62m2CicfJPx00
X-Google-Smtp-Source: AGHT+IGiNcupZEwSnJ//XV721tVsp+D+DXMNw0jir9pgBaIDHfOYAvoCUcBUDblONR8D0VJxZZY+rw==
X-Received: by 2002:a05:6000:ac4:b0:34a:4e2:7014 with SMTP id
 di4-20020a0560000ac400b0034a04e27014mr5743969wrb.35.1713798072290; 
 Mon, 22 Apr 2024 08:01:12 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 q4-20020adffec4000000b00347f6b5bb6dsm12241242wrs.30.2024.04.22.08.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 08:01:11 -0700 (PDT)
Message-ID: <e12aa3c7-561d-4651-9a6c-b79c211cfa02@gmail.com>
Date: Mon, 22 Apr 2024 17:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: add the amdgpu buffer object move speed
 metrics
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240416085150.2459820-1-Prike.Liang@amd.com>
 <20240416085150.2459820-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240416085150.2459820-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 16.04.24 um 10:51 schrieb Prike Liang:
> Add the amdgpu buffer object move speed metrics.

What should that be good for? It adds quite a bunch of complexity for a 
feature we actually want to deprecate.

Regards,
Christian.

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 78 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
>   3 files changed, 61 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 163d221b3bbd..2840f1536b51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -502,7 +502,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
>   /*
>    * Benchmarking
>    */
> -int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
> +int amdgpu_benchmark(struct amdgpu_device *adev, int test_number, struct seq_file *m);
>   
>   int amdgpu_benchmark_dump(struct amdgpu_device *adev, struct seq_file *m);
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index f6848b574dea..fcd186ca088a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -65,20 +65,27 @@ static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
>   					 int n, unsigned size,
>   					 s64 time_ms,
>   					 unsigned sdomain, unsigned ddomain,
> -					 char *kind)
> +					 char *kind, struct seq_file *m)
>   {
>   	s64 throughput = (n * (size >> 10));
>   
>   	throughput = div64_s64(throughput, time_ms);
>   
> -	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
> -		 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
> -		 kind, n, size >> 10, sdomain, ddomain, time_ms,
> -		 throughput * 8, throughput);
> +	if (m) {
> +		seq_printf(m, "\tamdgpu: %s %u bo moves of %u kB from"
> +			 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
> +			kind, n, size >> 10, sdomain, ddomain, time_ms,
> +			throughput * 8, throughput);
> +	} else {
> +		dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
> +			 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
> +			kind, n, size >> 10, sdomain, ddomain, time_ms,
> +			throughput * 8, throughput);
> +	}
>   }
>   
>   static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
> -				 unsigned sdomain, unsigned ddomain)
> +				 unsigned sdomain, unsigned ddomain, struct seq_file *m)
>   {
>   	struct amdgpu_bo *dobj = NULL;
>   	struct amdgpu_bo *sobj = NULL;
> @@ -109,7 +116,7 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   			goto out_cleanup;
>   		else
>   			amdgpu_benchmark_log_results(adev, n, size, time_ms,
> -						     sdomain, ddomain, "dma");
> +						     sdomain, ddomain, "dma", m);
>   	}
>   
>   out_cleanup:
> @@ -124,7 +131,7 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   	return r;
>   }
>   
> -int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
> +int amdgpu_benchmark(struct amdgpu_device *adev, int test_number, struct seq_file *m)
>   {
>   	int i, r;
>   	static const int common_modes[AMDGPU_BENCHMARK_COMMON_MODES_N] = {
> @@ -153,13 +160,16 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (simple test, VRAM to GTT and GTT to VRAM)\n",
>   			 test_number);
> +		if (m)
> +			seq_printf(m, "\tbenchmark test: %d (simple test, VRAM to GTT and GTT to VRAM)\n",
> +			 test_number);
>   		/* simple test, VRAM to GTT and GTT to VRAM */
>   		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
> -					  AMDGPU_GEM_DOMAIN_VRAM);
> +					  AMDGPU_GEM_DOMAIN_VRAM, m);
>   		if (r)
>   			goto done;
>   		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
> -					  AMDGPU_GEM_DOMAIN_GTT);
> +					  AMDGPU_GEM_DOMAIN_GTT, m);
>   		if (r)
>   			goto done;
>   		break;
> @@ -167,9 +177,13 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
>   			 test_number);
> +		if (m)
> +			seq_printf(m, "\tbenchmark test: %d (simple test, VRAM to VRAM)\n",
> +			 test_number);
> +
>   		/* simple test, VRAM to VRAM */
>   		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
> -					  AMDGPU_GEM_DOMAIN_VRAM);
> +					  AMDGPU_GEM_DOMAIN_VRAM, m);
>   		if (r)
>   			goto done;
>   		break;
> @@ -177,11 +191,15 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (GTT to VRAM, buffer size sweep, powers of 2)\n",
>   			 test_number);
> +		if (m)
> +			seq_printf(m, "\tbenchmark test: %d (GTT to VRAM, buffer size sweep, powers of 2)\n",
> +				test_number);
> +
>   		/* GTT to VRAM, buffer size sweep, powers of 2 */
>   		for (i = 1; i <= 16384; i <<= 1) {
>   			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
>   						  AMDGPU_GEM_DOMAIN_GTT,
> -						  AMDGPU_GEM_DOMAIN_VRAM);
> +						  AMDGPU_GEM_DOMAIN_VRAM, m);
>   			if (r)
>   				goto done;
>   		}
> @@ -190,11 +208,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (VRAM to GTT, buffer size sweep, powers of 2)\n",
>   			 test_number);
> +		if (m)
> +			seq_printf(m,"\tbenchmark test: %d (VRAM to GTT, buffer size sweep, powers of 2)\n",
> +				test_number);
>   		/* VRAM to GTT, buffer size sweep, powers of 2 */
>   		for (i = 1; i <= 16384; i <<= 1) {
>   			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
>   						  AMDGPU_GEM_DOMAIN_VRAM,
> -						  AMDGPU_GEM_DOMAIN_GTT);
> +						  AMDGPU_GEM_DOMAIN_GTT, m);
>   			if (r)
>   				goto done;
>   		}
> @@ -203,11 +224,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, powers of 2)\n",
>   			 test_number);
> +		if (m)
> +			seq_printf(m, "\tbenchmark test: %d (VRAM to VRAM, buffer size sweep, powers of 2)\n",
> +				 test_number);
>   		/* VRAM to VRAM, buffer size sweep, powers of 2 */
>   		for (i = 1; i <= 16384; i <<= 1) {
>   			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
>   						  AMDGPU_GEM_DOMAIN_VRAM,
> -						  AMDGPU_GEM_DOMAIN_VRAM);
> +						  AMDGPU_GEM_DOMAIN_VRAM, m);
>   			if (r)
>   				goto done;
>   		}
> @@ -216,11 +240,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (GTT to VRAM, buffer size sweep, common modes)\n",
>   			 test_number);
> +		if (m)
> +			seq_printf(m,"\tbenchmark test: %d (GTT to VRAM, buffer size sweep, common modes)\n",
> +				test_number);
>   		/* GTT to VRAM, buffer size sweep, common modes */
>   		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
>   			r = amdgpu_benchmark_move(adev, common_modes[i],
>   						  AMDGPU_GEM_DOMAIN_GTT,
> -						  AMDGPU_GEM_DOMAIN_VRAM);
> +						  AMDGPU_GEM_DOMAIN_VRAM, m);
>   			if (r)
>   				goto done;
>   		}
> @@ -229,11 +256,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (VRAM to GTT, buffer size sweep, common modes)\n",
>   			 test_number);
> +		if (m)
> +			seq_printf(m,"\tbenchmark test: %d (VRAM to GTT, buffer size sweep, common modes)\n",
> +				test_number);
>   		/* VRAM to GTT, buffer size sweep, common modes */
>   		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
>   			r = amdgpu_benchmark_move(adev, common_modes[i],
>   						  AMDGPU_GEM_DOMAIN_VRAM,
> -						  AMDGPU_GEM_DOMAIN_GTT);
> +						  AMDGPU_GEM_DOMAIN_GTT, m);
>   			if (r)
>   				goto done;
>   		}
> @@ -241,12 +271,15 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   	case 8:
>   		dev_info(adev->dev,
>   			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, common modes)\n",
> -			 test_number);
> +			test_number);
> +		if (m)
> +			seq_printf(m,"\tbenchmark test: %d (VRAM to VRAM, buffer size sweep, common modes)\n",
> +				test_number);
>   		/* VRAM to VRAM, buffer size sweep, common modes */
>   		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
>   			r = amdgpu_benchmark_move(adev, common_modes[i],
>   					      AMDGPU_GEM_DOMAIN_VRAM,
> -					      AMDGPU_GEM_DOMAIN_VRAM);
> +					      AMDGPU_GEM_DOMAIN_VRAM, m);
>   			if (r)
>   				goto done;
>   		}
> @@ -449,7 +482,7 @@ static void amdgpu_benchmark_mem_metrics_dump(struct amdgpu_device *adev, struct
>   			&adev->mman.gtt_mgr.manager;
>   	struct ttm_resource_manager *vram_man =
>   			&adev->mman.vram_mgr.manager;
> -	uint32_t l1_cache_size;
> +	uint32_t l1_cache_size, j;
>   
>   	seq_puts(m, "amdgpu benchmark mem metrics dump:\n");
>   
> @@ -483,6 +516,13 @@ static void amdgpu_benchmark_mem_metrics_dump(struct amdgpu_device *adev, struct
>   			atomic64_read(&adev->gart_pin_size));
>   	seq_printf(m, "\tGTT heap usage size:%lld KB\n", ttm_resource_manager_usage(gtt_man));
>   
> +	seq_printf(m, "\t--------amdgpu buffer object move speed test begin--------\n");
> +	for (j = 1; j < 8; j++) {
> +		/*TODO: Add the cases of gfx and CPU move cases.*/
> +		amdgpu_benchmark(adev, j, m);
> +	}
> +	seq_printf(m, "\t--------amdgpu buffer object move speed test end--------\n");
> +
>   	seq_printf(m, "\n");
>   
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 7e935b9736c1..4d710c5f8465 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1760,7 +1760,7 @@ static int amdgpu_debugfs_benchmark(void *data, u64 val)
>   		return r;
>   	}
>   
> -	r = amdgpu_benchmark(adev, val);
> +	r = amdgpu_benchmark(adev, val, NULL);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ADEC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F6910E7F2;
	Thu, 26 Oct 2023 14:05:53 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6FC10E7F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:05:52 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507d7b73b74so1280536e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698329150; x=1698933950; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQJNbzc39VQq782WTD7loHebHkSG6LAuyQuLs379gDU=;
 b=bvb8DP2BV2J656qBY/+5Jey6F2aQJ3fP8vFZqA1UuMW9fcy1RCaLXt2G1qQDMHcfjk
 pCoKeiY/Ju09KE2lK+pCmSf4s6d0zv3VNdMuchs5u5do7nRBIeQM2tS1379o8w7DG1XY
 Pc9X1BdccV8Z/LF9COVcAy58l+q1X1bMvcMQy8Lv75ilQJYcMKJbdXwkEFczmwMjDpN5
 AzkLhQzu84tUnWa5DY3mmw9eA4WpMqOuy+VcITTM7Qd/Z10fvLRfpB3oYnt4km8rG978
 3SYJi0Iy99q3U3Z0SqpPM5QATBKUdsVop+QvXiNgnoM+3al3rcgYAffF6SA9c2L2MNSx
 AOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698329150; x=1698933950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQJNbzc39VQq782WTD7loHebHkSG6LAuyQuLs379gDU=;
 b=rfJDzSS3CwyOloDrPyPQYUGLvX0M506Ys7X0VpI4ZaqiK4t08e6CHhlNnOlIhwuXIn
 bhhgG4ImnLGjN92hwHTSpgkfDJncChjvbO+mNTzzH8QKEBXj9wZI9aoweWJUfVvFighA
 9iMyIow3+IId7z38h3wR39npSCszAu6UGrTUQ5U3cgXS5Ojwa7F4xVdxg9TkRAb5S5oV
 4IpN+T8Um68Pa28SFOGAtmQ2wbP812BHuOzxPKrYCoFe1kwP74Q4I9MGkdFZb57Z9dfT
 C+oU8EVojvbhhxlwC0WyIKXAbHjvfvuVedW+12mUxzTjB/M0RX7j0McbjNbFeNMK/sBz
 gyAA==
X-Gm-Message-State: AOJu0Yx5lH34LP3O1RtCVm7HHsoQlgDGk2qpYIpSmBFn5IxMf9KqqN2L
 gbFr1l2v5m1SML773YY3iQW6DtlV5cMc7w==
X-Google-Smtp-Source: AGHT+IFKbD5hbCSs1I6RtCGhe2qGDC7x4aEg5H04n/+Wv7HzAmejpORa8pM3spwNDRJ6SfqyF8BtFA==
X-Received: by 2002:a05:6512:4db:b0:507:a671:3231 with SMTP id
 w27-20020a05651204db00b00507a6713231mr12653810lfq.52.1698329150278; 
 Thu, 26 Oct 2023 07:05:50 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a5d650c000000b0032d9a1f2ec3sm14274323wru.27.2023.10.26.07.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 07:05:49 -0700 (PDT)
Message-ID: <9ddff9df-ea17-465c-964e-cdfef10e2c6b@gmail.com>
Date: Thu, 26 Oct 2023 16:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove amdgpu_mes_self_test in gpu recover
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231026133436.1716057-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231026133436.1716057-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, christian.koenig@amd.com,
 li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.10.23 um 15:34 schrieb Yifan Zhang:
> gpu tlb flush is skipped if reset sem is held, it makes
> mes_self_test fail since it involves add_hw_queue/remove_hw_queue
> which needs tlb flush functional. Remove mes_self_test in gpu
> recover sequence.

Oh, the TLB issue is actually only the tip of the iceberg. That only 
worked by coincident.

During GPU reset you are not allowed to make any memory allocation or 
otherwise you can run into a deadlock. So doing a MES test is a complete 
no-go in the first place.

>
> This patch is to fix the recover failure in gfx11.
>
> [ 1831.768292] [drm] ring sdma_32769.3.3 was added
> [ 1831.768313] [drm] ring gfx_32769.1.1 ib test pass
> [ 1831.768337] [drm] ring compute_32769.2.2 ib test pass
> [ 1831.768399] amdgpu 0000:c2:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:24 vmid:8 pasid:32769, for process  pid 0 thread  pid 0)
> [ 1831.768434] amdgpu 0000:c2:00.0: amdgpu:   in page starting at address 0x0000aec200000000 from client 10
> [ 1831.768456] amdgpu 0000:c2:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00800A30
> [ 1831.768473] amdgpu 0000:c2:00.0: amdgpu:      Faulty UTCL2 client ID: CPC (0x5)
> [ 1831.768489] amdgpu 0000:c2:00.0: amdgpu:      MORE_FAULTS: 0x0
> [ 1831.768501] amdgpu 0000:c2:00.0: amdgpu:      WALKER_ERROR: 0x0
> [ 1831.768513] amdgpu 0000:c2:00.0: amdgpu:      PERMISSION_FAULTS: 0x3
> [ 1831.768521] amdgpu 0000:c2:00.0: amdgpu:      MAPPING_ERROR: 0x0
> [ 1831.768529] amdgpu 0000:c2:00.0: amdgpu:      RW: 0x0
> [ 1831.931229] amdgpu 0000:c2:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring sdma_32769.3.3 test failed (-110)
> [ 1832.062917] [drm:mes_v11_0_submit_pkt_and_poll_completion.constprop.0 [amdgpu]] *ERROR* MES failed to response msg=3
> [ 1832.063107] [drm:amdgpu_mes_remove_hw_queue [amdgpu]] *ERROR* failed to remove hardware queue, queue id = 3
>
> Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")
> Reported-by: Li Ma <li.ma@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks for looking into this,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7ec32b44df05..5169e55b7fd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5557,10 +5557,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			drm_sched_start(&ring->sched, true);
>   		}
>   
> -		if (adev->enable_mes &&
> -		    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3))
> -			amdgpu_mes_self_test(tmp_adev);
> -
>   		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
>   			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
>   


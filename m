Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B60CC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 07:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66E611283C;
	Mon, 22 Apr 2024 07:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EL+lZWJ7";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1931B11283C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 07:06:39 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-41a7b6f22ebso2130445e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713769597; x=1714374397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSYn52EgcEGn+uOwZ4CfwLjLdajvzu6ZkbAC2lZaAQE=;
 b=EL+lZWJ77/Fkv1kwoeIC+ShWnSFiE67o4SifkWdbNPjRenUHzEXlJd5NLjngsnPe6q
 9omnBf32cvtzMyQGGXFTL9s2zvph8oXiAH9Xm+Fexs3b5OhnPhQmYC6WbIxksybUFDrM
 tLumZjbphru/U8f8zDPHi1lJ47mj4CsNeXhoHM0fzCcVTn4m1QGoZofeymnNeut5vICx
 7XCYCcVECNraRICr96wuAJKIa9+clKZd33Tc2/JcQn1AMiTlWfAJpXwyaTTAG5vn2zMU
 cKyZIAmp04KlHNCSWH3dRWGeRwfoaTMmaqSR2Urxicz4sIljCefxmANiPoHeT5qql4Sa
 sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713769597; x=1714374397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSYn52EgcEGn+uOwZ4CfwLjLdajvzu6ZkbAC2lZaAQE=;
 b=c6Wfycy0WYIrT71yEBaC3TGHk59lyO82MS0ILGh/5B46WsRy6cEjt/QS/BFqDTHZIf
 9q75B3OtWh87BAA8OCE2hzPlZTvELjY1pmkr1mAuBnx50Tv7f0X5k18utJT/X0lx79N5
 wPkpDnul4qsAIglQVIhPoJx2YbEZnNi8Rnr/UaaU6xM21dQ72JKNWx+aIetGyOgSjIP3
 ySnKoShQCYbe6Eww/Sbhd19z9NSJ+X9UgpVbClC7Ramc7p0neiVNDD8JI58PSt8DvyyF
 mVs/zCLHkqJeCy5LmJ/FFmTxt2O8ZrhAX1af0ICplXfE6qBmdHJmodWVooK3QSs1p6ow
 NTTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg1wny9Ur+7n4Gs23QXpW0HF6BtDr71hFu92+W+ykaDK01EDk6Y+u3xuaHlfF/ng832zPY7YPqpxCB4sbtZdHPfZyY5Hn08cb8fifewA==
X-Gm-Message-State: AOJu0YzoCf++a++oCEy/cjhRAiYAswleBGBu6nCGHOmg5ouYvjr0kvct
 auQio19/vGIwi7sbgaYZtbH4VZnl+p7Wg9JWKuhVcDTRZKFc7lI4
X-Google-Smtp-Source: AGHT+IGude0OBxaLcAzXN71+jc2dgP8idDj9F79hqTKNkZEn8dpktTkY9h60c/aL+Q9zqOzPZwxSiw==
X-Received: by 2002:a05:600c:1e11:b0:415:540e:74e3 with SMTP id
 ay17-20020a05600c1e1100b00415540e74e3mr6020848wmb.40.1713769596994; 
 Mon, 22 Apr 2024 00:06:36 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c450d00b00417f700eaeasm15598508wmo.22.2024.04.22.00.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 00:06:36 -0700 (PDT)
Message-ID: <ee5d2c65-4055-4266-8af8-fc2d7a8d2736@gmail.com>
Date: Mon, 22 Apr 2024 09:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] drm/amdgpu: Add interface to reserve bad page
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yipechai@amd.com, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Candice.Li@amd.com, KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.04.24 um 04:58 schrieb YiPeng Chai:
> Add interface to reserve bad page.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>

Yeah, that approach looks valid to me. Just keep in mind that 
amdgpu_vram_mgr_query_page_status() is not the fastest function cause it 
does a linear search.

Apart from that Reviewed-by: Christian König <christian.koenig@amd.com> 
for this patch, but can't really judge the rest of the patch set.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++++
>   2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2c97cb80d79a..05782d68f073 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2782,6 +2782,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>   		}
>   	}
>   
> +	mutex_init(&con->page_rsv_lock);
>   	mutex_init(&con->page_retirement_lock);
>   	init_waitqueue_head(&con->page_retirement_wq);
>   	atomic_set(&con->page_retirement_req_cnt, 0);
> @@ -2835,6 +2836,8 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
>   
>   	atomic_set(&con->page_retirement_req_cnt, 0);
>   
> +	mutex_destroy(&con->page_rsv_lock);
> +
>   	cancel_work_sync(&con->recovery_work);
>   
>   	mutex_lock(&con->recovery_lock);
> @@ -4278,3 +4281,19 @@ void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances)
>   			amdgpu_ras_boot_time_error_reporting(adev, i, boot_error);
>   	}
>   }
> +
> +int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn)
> +{
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
> +	uint64_t start = pfn << AMDGPU_GPU_PAGE_SHIFT;
> +	int ret = 0;
> +
> +	mutex_lock(&con->page_rsv_lock);
> +	ret = amdgpu_vram_mgr_query_page_status(mgr, start);
> +	if (ret == -ENOENT)
> +		ret = amdgpu_vram_mgr_reserve_range(mgr, start, AMDGPU_GPU_PAGE_SIZE);
> +	mutex_unlock(&con->page_rsv_lock);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 8d26989c75c8..ab5bf573378e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -500,6 +500,7 @@ struct amdgpu_ras {
>   	wait_queue_head_t page_retirement_wq;
>   	struct mutex page_retirement_lock;
>   	atomic_t page_retirement_req_cnt;
> +	struct mutex page_rsv_lock;
>   	/* Fatal error detected flag */
>   	atomic_t fed;
>   
> @@ -909,4 +910,7 @@ bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
>   
>   bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id);
>   u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type);
> +
> +int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);
> +
>   #endif


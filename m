Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A593C27C75
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 10:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D387A10EA01;
	Thu, 13 Jun 2024 10:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7BowhuC";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05B910EA01
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 10:19:40 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so820493f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718273979; x=1718878779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=16SseQ7CwH3Z69sMnGmgk42601hnH0JToFRcevDDhiQ=;
 b=j7BowhuCt1+DreVPkeQkftPKu6bwhKKbghh6wqLg+heZt+BubrvzQ06tCnNMr4j/aS
 qoT0zz2YohhgATut7jxdBDxzvOfaT3DyPxVftRYBkYAiYGuzEQoWZzjbKfE9H8ilWq96
 cMQRK0tEQpTJjPIr0IlWLE40hyDBo1VatZmU7e+AsWqrngvmY9kDXBmoROiZhu+6Exxy
 NZIMzwz+qKxLJs09pz2x7siEnUmQQGA52xhS2UZjgH3SdDEQJKElXG6gVpOzuCr0au2O
 SFBjHB9Hoq0OCRrlYDmJBdamdDbIxtiWNNWueG5Oskl59l4j9X7hALq12jgs9ovKDYT1
 /Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718273979; x=1718878779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=16SseQ7CwH3Z69sMnGmgk42601hnH0JToFRcevDDhiQ=;
 b=GX12TPk/L1e2gX69VGuXp2R1FJ1uUiLGeyV4d1+bxIYMyaPw1H3efOjHgKudez2op3
 C3EHjxDPEgw6sTuS1PfaE6Qm2P6XAbDa/L2kqk+HV/wmjHxoPqD5oEQpL07NOEg/nPLv
 hLsD1yYLtFrRRZ9oC7r0ArJMR0tUWlF0hYXUT5zOhyTpx3seQUmVHeNDN/8ZXpPcNLnl
 Itxg2cPXrWtRey1Q8Hhly4LPyJWolsji1U/k+V7OKk1dTxWKki/vRuJA3nVl7hdoVdts
 5Ig7xwLh6DaBnUzMhot3SgArmAJ/fJTrPJuS3IiFXHyZCcc5/2zCruUl0/C3qZ5DVTYC
 lZGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB15imtNhetXVMbJgO2A+PzsS8CQZ/uyEzh1EIpCUTKzt+dKWD7tqEU5HAJODjszEC9SOjydV73PGUM9/mFjr/wAhYZO0Qo6Ii79Pjxw==
X-Gm-Message-State: AOJu0YyDDexhtOqpUSUTGPclcAYfny7EELvXbE0eWntiULABISy+lyoj
 g4vsKn3kmdRlgUUwTRuzQaBDKMyU04yD/Cmd8muh60/TpWSNiZ+F
X-Google-Smtp-Source: AGHT+IEJx+fDkZ2AECve/QB1RN1POEK1E/DK+obqWrsDyPuUL1UpQXy6y3WNFkSWTUBtFamW1ow8Kg==
X-Received: by 2002:a05:6000:228:b0:35f:d57:6e3f with SMTP id
 ffacd0b85a97d-35fe1bfd5d9mr3110779f8f.31.1718273977488; 
 Thu, 13 Jun 2024 03:19:37 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104c66sm1257195f8f.111.2024.06.13.03.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 03:19:37 -0700 (PDT)
Message-ID: <114537d3-364f-46f4-8eb8-81785e461f92@gmail.com>
Date: Thu, 13 Jun 2024 12:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: wait for gpu to complete reset
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240613022504.81787-1-YiPeng.Chai@amd.com>
 <20240613022504.81787-4-YiPeng.Chai@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240613022504.81787-4-YiPeng.Chai@amd.com>
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

Am 13.06.24 um 04:25 schrieb YiPeng Chai:
> Add completion to wait for gpu to complete reset.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>   2 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7dfb2e548d70..341c9bd0d1a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
>   
>   #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
>   
> +#define MAX_GPU_RESET_COMPLETION_TIME  120000 //ms
> +
>   #define RAS_POISON_FIFO_MSG_PENDING_THRESHOLD  (AMDGPU_RAS_POISON_FIFO_SIZE/4)
>   
>   enum amdgpu_ras_retire_page_reservation {
> @@ -2526,6 +2528,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   		atomic_set(&hive->ras_recovery, 0);
>   		amdgpu_put_xgmi_hive(hive);
>   	}
> +
> +	complete(&ras->gpu_reset_completion);
>   }
>   
>   /* alloc/realloc bps array */
> @@ -2946,7 +2950,14 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
>   			con->gpu_reset_flags |= reset;
>   		}
>   
> +		reinit_completion(&con->gpu_reset_completion);
> +
>   		amdgpu_ras_reset_gpu(adev);
> +
> +		if (!wait_for_completion_timeout(&con->gpu_reset_completion,
> +				msecs_to_jiffies(MAX_GPU_RESET_COMPLETION_TIME)))
> +			dev_err(adev->dev, "Waiting for GPU to complete reset timeout! reset:0x%x\n",
> +				reset);

Are there any looks taken here which the GPU reset might need as well?

Regards,
Christian.

>   	}
>   
>   	return 0;
> @@ -3072,6 +3083,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>   		}
>   	}
>   
> +	init_completion(&con->gpu_reset_completion);
>   	mutex_init(&con->page_rsv_lock);
>   	INIT_KFIFO(con->poison_fifo);
>   	mutex_init(&con->page_retirement_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 103436bb650e..d5ddd0ca5de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -537,6 +537,7 @@ struct amdgpu_ras {
>   	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, AMDGPU_RAS_POISON_FIFO_SIZE);
>   	struct ras_ecc_log_info  umc_ecc_log;
>   	struct delayed_work page_retirement_dwork;
> +	struct completion gpu_reset_completion;
>   
>   	/* Fatal error detected flag */
>   	atomic_t fed;


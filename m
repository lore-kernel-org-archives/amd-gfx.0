Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9766BC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3914A61439
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3914A61439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45AB6E856;
	Thu, 13 May 2021 08:00:36 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B106E856
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 08:00:35 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id n2so38657526ejy.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hdsKgEnKATes6zLBVznKXPaRNmnucaEto+lM/WzMoDA=;
 b=A//eZWkjPCnwQoUYtpT5y7i6WB4Cgko1zpWP0w5Mt9Mmu+bOK+04jGQPkSI2IRgQtr
 6YYs9UPVQyNoolJ9XO0M8ABIu9eqZSJ+si3ZMGCvvtFA8uVi1e0D+bohUp5XZLd9iY2N
 3nmAX+36NsSyQntPc4/xcGacVTmrYFOYaQhYT6iA9wL0+QgM0Q3zrTRhv74Sk2kVwgl5
 0s+FJKQQOeTmM0zMAlrmEZL8tCryjnD5TfQkoOeB1ars7jb8pDxh5dDPSNLF+w8HjpVZ
 DGsbXNEbykADrKqFkGyboFOENcRjkYVodTrGHX50vUqSdj6EytDN/eDx2LSSnuffJI8W
 NJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hdsKgEnKATes6zLBVznKXPaRNmnucaEto+lM/WzMoDA=;
 b=qki914RQ2CQZ8+eLnDj6YHfRRAa7DVr7oxpgjeW14luJV6/jG31kBU2DQdd2z7xSA6
 8+HyArH1O9tgCEvxhC6Cxz0WzrC2fJ0YpbFd8mg0hIfzKAS7vtY1ZkK9q6mXJQ16jtHR
 jaqstP6Spi1rPbfAQG6qbu1CCpmzXIy+2D+qfjAa9AvvhIdC+YDEkDfxI3kwj02RNuT3
 GPgE7hgLwiEBp3aJoi9WWTipGBSsi+ZoiabbxZGtrT1AS7eH1f1/3bexBsWOEWgoOebS
 2f4S8fQNaVOqiO9rChuuDncy0qcq3gL1oPZ5R+pQ1Skf3PZtUxw6ioe4uJeQRpDEAi3I
 MjFQ==
X-Gm-Message-State: AOAM533mZ/Bo+yDT4Y51o+nUBjerSHhQIux0L2k7z2UXRMBMIb81bK5K
 pcLzoJBmRp77QUW0UhWNuuA80hgVjKs=
X-Google-Smtp-Source: ABdhPJw0S6Kk6saayA1pQXlZ/uh0G3aOl+xtSG+rKb4+3isbgzmX8qauPfpRJI2XFltgIHeqdZ5sUQ==
X-Received: by 2002:a17:906:b2c1:: with SMTP id
 cf1mr32637191ejb.544.1620892834407; 
 Thu, 13 May 2021 01:00:34 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc?
 ([2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc])
 by smtp.gmail.com with ESMTPSA id f30sm1431631ejl.62.2021.05.13.01.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 01:00:34 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: Poll of RAS errors asynchronously
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512170302.64951-1-luben.tuikov@amd.com>
 <20210512170302.64951-2-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <83e2151b-02aa-a055-2d37-4f74ea025f3d@gmail.com>
Date: Thu, 13 May 2021 10:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512170302.64951-2-luben.tuikov@amd.com>
Content-Language: en-US
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.05.21 um 19:03 schrieb Luben Tuikov:
> When using Vega 20 with RAS support and RAS is
> enabled, the system interactivity is extremely
> slow, to the point of being unusable. After
> debugging, it was determined that this is due to
> the polling loop performed for
> AMDGPU_CTX_OP_QUERY_STATE2 under
> amdgpu_ctx_ioctl(), which seems to be executed on
> every ioctl from X/Mesa.
>
> The latter seems to call amdgpu_ctx_query2() which
> calls amdgpu_ras_query_error_count() twice, once
> for each of ue_count and ce_count. This is
> unnecessarily wasteful since
> amdgpu_ras_query_error_count() calculates both,
> but with the current interface it returns one or
> the other, depending on its Boolean input, when it
> can in fact return both, in a single invocation,
> if it had a better interface.
>
> Further down, the query_ras_error_count() callback
> is called, which could be quite a large polling
> loop, and very time consuming. For instance,
> gfx_v9_0_query_ras_error_count() is at least
> O(n^3). A similar situation is seen with
> umc_v6_1_query_ras_error_count().
>
> This commit implements asynchronous RAS error
> count polling to that of the ioctl. A kernel
> thread polls the RAS error counters once in a
> while. The ioctl reads the values
> asynchronously. The poll frequency is a module
> parameter, with range [500, 10000] milliseconds,
> default 3000.
>
> v2: Enable setting the polling interval to 0,
>      which disables the thread.

Please drop the module parameter, we already have way to many module 
parameters and that doesn't add much value.

Then I would really prefer to implement this as a delayed work item instead.

If you call schedule_delayed_work() from the amdgpu_ctx_query2() the 
work item will only be started every X jiffies when the function is 
actually used.

Regards,
Christian.

>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Reviewed-by: John Clements <john.clements@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 36 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 66 ++++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 +--
>   5 files changed, 93 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3147c1c935c8..a269f778194f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -197,6 +197,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
>   extern int amdgpu_ras_enable;
>   extern uint amdgpu_ras_mask;
>   extern int amdgpu_bad_page_threshold;
> +extern uint amdgpu_ras_thread_poll_ms;
>   extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>   extern int amdgpu_async_gfx_ring;
>   extern int amdgpu_mcbp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index d481a33f4eaf..558e887e99b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -332,12 +332,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>   }
>   
>   static int amdgpu_ctx_query2(struct amdgpu_device *adev,
> -	struct amdgpu_fpriv *fpriv, uint32_t id,
> -	union drm_amdgpu_ctx_out *out)
> +			     struct amdgpu_fpriv *fpriv, uint32_t id,
> +			     union drm_amdgpu_ctx_out *out)
>   {
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct amdgpu_ctx *ctx;
>   	struct amdgpu_ctx_mgr *mgr;
> -	unsigned long ras_counter;
>   
>   	if (!fpriv)
>   		return -EINVAL;
> @@ -362,20 +362,22 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>   	if (atomic_read(&ctx->guilty))
>   		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
>   
> -	/*query ue count*/
> -	/* ras_counter = amdgpu_ras_query_error_count(adev, false); */
> -	/* /\*ras counter is monotonic increasing*\/ */
> -	/* if (ras_counter != ctx->ras_counter_ue) { */
> -	/* 	out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE; */
> -	/* 	ctx->ras_counter_ue = ras_counter; */
> -	/* } */
> -
> -	/* /\*query ce count*\/ */
> -	/* ras_counter = amdgpu_ras_query_error_count(adev, true); */
> -	/* if (ras_counter != ctx->ras_counter_ce) { */
> -	/* 	out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE; */
> -	/* 	ctx->ras_counter_ce = ras_counter; */
> -	/* } */
> +	if (con) {
> +		int ce_count, ue_count;
> +
> +		ce_count = atomic_read(&con->ras_ce_count);
> +		ue_count = atomic_read(&con->ras_ue_count);
> +
> +		if (ce_count != ctx->ras_counter_ce) {
> +			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
> +			ctx->ras_counter_ce = ce_count;
> +		}
> +
> +		if (ue_count != ctx->ras_counter_ue) {
> +			out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
> +			ctx->ras_counter_ue = ue_count;
> +		}
> +	}
>   
>   	mutex_unlock(&mgr->lock);
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 877469d288f8..641c374b8525 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -183,6 +183,7 @@ struct amdgpu_mgpu_info mgpu_info = {
>   int amdgpu_ras_enable = -1;
>   uint amdgpu_ras_mask = 0xffffffff;
>   int amdgpu_bad_page_threshold = -1;
> +uint amdgpu_ras_thread_poll_ms = 3000;
>   struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>   	.timeout_fatal_disable = false,
>   	.period = 0x0, /* default to 0x0 (timeout disable) */
> @@ -534,6 +535,15 @@ module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
>   MODULE_PARM_DESC(ras_enable, "Enable RAS features on the GPU (0 = disable, 1 = enable, -1 = auto (default))");
>   module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
>   
> +/**
> + * DOC: ras_thread_poll (uint)
> + * Number of milliseconds between RAS poll for errors.
> + * Valid range 0 and [500,10000]. Set to 0 to disable the thread.
> + * Default: 3000.
> + */
> +MODULE_PARM_DESC(ras_thread_poll, "Number of milliseconds between RAS poll for errors. Valid range 0 and [500,10000]. Set to 0 to disable the thread. Default: 3000.");
> +module_param_named(ras_thread_poll, amdgpu_ras_thread_poll_ms, uint, 0444);
> +
>   /**
>    * DOC: ras_mask (uint)
>    * Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b1c57a5b6e89..30bec289e9ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1043,15 +1043,17 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
>   }
>   
>   /* get the total error counts on all IPs */
> -unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
> -		bool is_ce)
> +static void amdgpu_ras_query_error_count(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct ras_manager *obj;
> -	struct ras_err_data data = {0, 0};
> +	int ce_count, ue_count;
>   
>   	if (!adev->ras_enabled || !con)
> -		return 0;
> +		return;
> +
> +	ce_count = 0;
> +	ue_count = 0;
>   
>   	list_for_each_entry(obj, &con->head, node) {
>   		struct ras_query_if info = {
> @@ -1059,13 +1061,14 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
>   		};
>   
>   		if (amdgpu_ras_query_error_status(adev, &info))
> -			return 0;
> +			return;
>   
> -		data.ce_count += info.ce_count;
> -		data.ue_count += info.ue_count;
> +		ce_count += info.ce_count;
> +		ue_count += info.ue_count;
>   	}
>   
> -	return is_ce ? data.ce_count : data.ue_count;
> +	atomic_set(&con->ras_ce_count, ce_count);
> +	atomic_set(&con->ras_ue_count, ue_count);
>   }
>   /* query/inject/cure end */
>   
> @@ -2109,6 +2112,49 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
>   		adev->ras_hw_enabled & amdgpu_ras_mask;
>   }
>   
> +static int amdgpu_ras_thread(void *data)
> +{
> +	struct amdgpu_device *adev = data;
> +	struct amdgpu_ras    *con  = amdgpu_ras_get_context(adev);
> +
> +	con->ras_thread_poll_ms = amdgpu_ras_thread_poll_ms;
> +	if (con->ras_thread_poll_ms == 0) {
> +		atomic_set(&con->ras_ce_count, 0);
> +		atomic_set(&con->ras_ue_count, 0);
> +		return 0;
> +	} else if (con->ras_thread_poll_ms < 500 ||
> +		   con->ras_thread_poll_ms > 10000) {
> +		con->ras_thread_poll_ms = 3000;
> +	}
> +
> +	while (1) {
> +		if (kthread_should_stop())
> +			break;
> +		if (kthread_should_park())
> +			kthread_parkme();
> +
> +		amdgpu_ras_query_error_count(adev);
> +		msleep_interruptible(con->ras_thread_poll_ms);
> +	}
> +
> +	return 0;
> +}
> +
> +static int amdgpu_ras_thread_start(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct task_struct *kt;
> +
> +	kt = kthread_run(amdgpu_ras_thread, adev,
> +			 "amdras:%s", pci_name(adev->pdev));
> +	if (IS_ERR(kt))
> +		return PTR_ERR(kt);
> +
> +	con->ras_thread = kt;
> +
> +	return 0;
> +}
> +
>   int amdgpu_ras_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> @@ -2182,6 +2228,10 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   		goto release_con;
>   	}
>   
> +	r = amdgpu_ras_thread_start(adev);
> +	if (r)
> +		goto release_con;
> +
>   	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
>   		 "hardware ability[%x] ras_mask[%x]\n",
>   		 adev->ras_hw_enabled, adev->ras_enabled);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 201fbdee1d09..fb9e4c7ab054 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -340,6 +340,11 @@ struct amdgpu_ras {
>   
>   	/* disable ras error count harvest in recovery */
>   	bool disable_ras_err_cnt_harvest;
> +
> +	struct task_struct *ras_thread;
> +	unsigned int        ras_thread_poll_ms;
> +	atomic_t            ras_ue_count;
> +	atomic_t            ras_ce_count;
>   };
>   
>   struct ras_fs_data {
> @@ -485,9 +490,6 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
>   void amdgpu_ras_resume(struct amdgpu_device *adev);
>   void amdgpu_ras_suspend(struct amdgpu_device *adev);
>   
> -unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
> -		bool is_ce);
> -
>   /* error handling functions */
>   int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   		struct eeprom_table_record *bps, int pages);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

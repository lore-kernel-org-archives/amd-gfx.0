Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EA9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6363C2065C
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1BvlQ58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6363C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B8B89CB5;
	Mon, 27 Jul 2020 09:26:23 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFED989CB5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 09:26:21 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id f14so474847ejb.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JG8JDL6DSmpTNtBdQmSQQJkKEaPjLaL4A8IJKu3Pggw=;
 b=s1BvlQ58n/b55ozUkYxmcoEeNB02gNl8Lh8hDTh9dWaKgzbfabzdoFVawZQuLgZIcS
 Azn83gUCwHzyBaIotzmttlc/PFURXKpaAc6OmWymFWw5tSSWCTyAKU3heJIzXkfdRWEL
 64XvBx3Ur0HTogTByCV+tTJP8eOdjHJJetUVjtWqA+fizhNhVLA0gJ2TgDQvKEoW6tco
 uCDR+W/0c1d34YYN3ltBkOHgUGJXk/itWWgPk8/yJgNVyz4N5GTgwStHOKg7tkwMwrcI
 djIJSol0GAPxZgf8pCLTYmQX2bzKBvNB8AGuBNxZUUCXk6MhbPfkyUH+9Cea+RKOjYU+
 UcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JG8JDL6DSmpTNtBdQmSQQJkKEaPjLaL4A8IJKu3Pggw=;
 b=sRgSnp1XKi+UcExibH8ZrEaYpZb4R9o5y6wOkkIz9b3Eu66qPiqZmu/z3d3xENaWti
 qBVzqSeL2tSurbfapzU0bjdkpTHoGJeR2whHqeZp9Gj6c8hSHOTZ9Br+k48kA9z7oto5
 ORidb0MfrD1ELPsnDK2V+yFYKtliKSidlYWXZdTBMgg1r+oMiN3iWPZx3Y4oUda5GaOg
 rB8H6PXWfBuM+YXeCOzFu+/ZWe84XZ0LtaRDW/KIvC3A988Wu/SUtO4lbyIri8EmhSco
 9Bfllc8tIILqw4itVRShiGZEtNt9EdfhYsWUF/eHur2UC1UR+hsL+99iacMgsQllG3w2
 P34Q==
X-Gm-Message-State: AOAM530w4SDu+Rp0v+IMHpQD/bsfUc5u80DJT1VhHPQVTp47LACumckz
 SvepyTM7UzOc9XbSMqJYNHoRYAze
X-Google-Smtp-Source: ABdhPJx0EzwAaEwuophhS8sLt0KUsNDv1c1wsvicSssnNksBPPOsq52mSv2Q0NjU9/cVLEfHSSDcng==
X-Received: by 2002:a17:906:69d3:: with SMTP id
 g19mr21039703ejs.402.1595841980050; 
 Mon, 27 Jul 2020 02:26:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id dk28sm454347edb.90.2020.07.27.02.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 02:26:17 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: introduce a new parameter to configure how
 many KCQ we want
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1595838099-18627-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4bb8abd5-11ef-079e-d28d-9beafa2a71a4@gmail.com>
Date: Mon, 27 Jul 2020 11:26:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595838099-18627-1-git-send-email-Monk.Liu@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.07.20 um 10:21 schrieb Monk Liu:
> what:
> KCQ cost many clocks during world switch which impacts a lot to multi-VF
> performance
>
> how:
> introduce a paramter to control the number of KCQ to avoid performance
> drop if there is no KQC needed
>
> notes:
> this paramter only affects gfx 8/9/10

Sounds like a good idea to me, but that needs a different name. Outside 
AMD most people don't know what a KCQ is.

Just use compute queue or similar as name for this.

Another comment below.

>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 27 +++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 +++++++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 ++++++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 +++++++++++++++---------------
>   7 files changed, 69 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e97c088..71a3d6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -201,6 +201,7 @@ extern int amdgpu_si_support;
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   extern int amdgpu_cik_support;
>   #endif
> +extern int amdgpu_num_kcq_user_set;
>   
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac9..61c7583 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1199,6 +1199,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   
>   	amdgpu_gmc_tmz_set(adev);
>   
> +	if (amdgpu_num_kcq_user_set > 8 || amdgpu_num_kcq_user_set < 0)
> +		amdgpu_num_kcq_user_set = 8;

This needs a warning or error message if we overwrite invalid user 
provided parameters.

Christian.

> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6291f5f..03a94e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -150,6 +150,7 @@ int amdgpu_noretry;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = 0;
>   int amdgpu_reset_method = -1; /* auto */
> +int amdgpu_num_kcq_user_set = 8;
>   
>   struct amdgpu_mgpu_info mgpu_info = {
>   	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>   MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
>   module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>   
> +MODULE_PARM_DESC(num_kcq, "number of KCQ user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
> +module_param_named(num_kcq, amdgpu_num_kcq_user_set, int, 0444);
> +
>   static const struct pci_device_id pciidlist[] = {
>   #ifdef  CONFIG_DRM_AMDGPU_SI
>   	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8eff017..0b59049 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -202,7 +202,7 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>   
>   void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>   {
> -	int i, queue, pipe, mec;
> +	int i, queue, pipe, mec, j = 0;
>   	bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
>   
>   	/* policy for amdgpu compute queue ownership */
> @@ -219,23 +219,24 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>   
>   		if (multipipe_policy) {
>   			/* policy: amdgpu owns the first two queues of the first MEC */
> -			if (mec == 0 && queue < 2)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> +			if (mec == 0 && queue < 2) {
> +				if (j++ < adev->gfx.num_compute_rings)
> +					set_bit(i, adev->gfx.mec.queue_bitmap);
> +				else
> +					break;
> +			}
>   		} else {
>   			/* policy: amdgpu owns all queues in the first pipe */
> -			if (mec == 0 && pipe == 0)
> -				set_bit(i, adev->gfx.mec.queue_bitmap);
> +			if (mec == 0 && pipe == 0) {
> +				if (j++ < adev->gfx.num_compute_rings)
> +					set_bit(i, adev->gfx.mec.queue_bitmap);
> +				else
> +					break;
> +			}
>   		}
>   	}
>   
> -	/* update the number of active compute rings */
> -	adev->gfx.num_compute_rings =
> -		bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
> -
> -	/* If you hit this case and edited the policy, you probably just
> -	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
> -	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
> -		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	dev_info(adev->dev, "mec queue bitmap weight=%d\n", bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
>   }
>   
>   void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index db9f1e8..2ad8393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
>   	amdgpu_gfx_compute_queue_acquire(adev);
>   	mec_hpd_size = adev->gfx.num_compute_rings * GFX10_MEC_HPD_SIZE;
>   
> -	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &adev->gfx.mec.hpd_eop_obj,
> -				      &adev->gfx.mec.hpd_eop_gpu_addr,
> -				      (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -		gfx_v10_0_mec_fini(adev);
> -		return r;
> -	}
> +	if (mec_hpd_size) {
> +		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +									  AMDGPU_GEM_DOMAIN_GTT,
> +									  &adev->gfx.mec.hpd_eop_obj,
> +									  &adev->gfx.mec.hpd_eop_gpu_addr,
> +									  (void **)&hpd);
> +		if (r) {
> +			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +			gfx_v10_0_mec_fini(adev);
> +			return r;
> +		}
>   
> -	memset(hpd, 0, mec_hpd_size);
> +		memset(hpd, 0, mec_hpd_size);
>   
> -	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +	}
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
>   		mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
> @@ -7159,7 +7161,7 @@ static int gfx_v10_0_early_init(void *handle)
>   		break;
>   	}
>   
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
>   
>   	gfx_v10_0_set_kiq_pm4_funcs(adev);
>   	gfx_v10_0_set_ring_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8d72089..6d95b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
>   	amdgpu_gfx_compute_queue_acquire(adev);
>   
>   	mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
> +	if (mec_hpd_size) {
> +		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +									  AMDGPU_GEM_DOMAIN_VRAM,
> +									  &adev->gfx.mec.hpd_eop_obj,
> +									  &adev->gfx.mec.hpd_eop_gpu_addr,
> +									  (void **)&hpd);
> +		if (r) {
> +			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +			return r;
> +		}
>   
> -	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->gfx.mec.hpd_eop_obj,
> -				      &adev->gfx.mec.hpd_eop_gpu_addr,
> -				      (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -		return r;
> -	}
> -
> -	memset(hpd, 0, mec_hpd_size);
> +		memset(hpd, 0, mec_hpd_size);
>   
> -	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +	}
>   
>   	return 0;
>   }
> @@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
>   	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
>   	gfx_v8_0_set_ring_funcs(adev);
>   	gfx_v8_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e4e751f..43bcfe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
>   	/* take ownership of the relevant compute queues */
>   	amdgpu_gfx_compute_queue_acquire(adev);
>   	mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
> +	if (mec_hpd_size) {
> +		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> +									  AMDGPU_GEM_DOMAIN_VRAM,
> +									  &adev->gfx.mec.hpd_eop_obj,
> +									  &adev->gfx.mec.hpd_eop_gpu_addr,
> +									  (void **)&hpd);
> +		if (r) {
> +			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> +			gfx_v9_0_mec_fini(adev);
> +			return r;
> +		}
>   
> -	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &adev->gfx.mec.hpd_eop_obj,
> -				      &adev->gfx.mec.hpd_eop_gpu_addr,
> -				      (void **)&hpd);
> -	if (r) {
> -		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
> -		gfx_v9_0_mec_fini(adev);
> -		return r;
> -	}
> -
> -	memset(hpd, 0, mec_hpd_size);
> +		memset(hpd, 0, mec_hpd_size);
>   
> -	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> -	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
> +		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
> +	}
>   
>   	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
>   
> @@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)
>   		adev->gfx.num_gfx_rings = 0;
>   	else
>   		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
>   	gfx_v9_0_set_kiq_pm4_funcs(adev);
>   	gfx_v9_0_set_ring_funcs(adev);
>   	gfx_v9_0_set_irq_funcs(adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D44C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CEE610C8
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31CEE610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6613C6E5CF;
	Fri, 22 Oct 2021 11:46:25 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FDB6E5CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 11:46:23 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id r10so1096564wra.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=NXIP8xN/u/30A/DOzeJjvIPxCgaJSWyBn+zfSCJmw7U=;
 b=SYz4lwIzJT+7ziLCvkUT9lM6Oeyagn4eHEWXW6EPs4PkjpMJAnNcTM3Bauvr5WfcFn
 yP/vISJsVan0EK/fgtuUhnM39PNKNhYg36AJ9Nnjp9Z82sSpAFD4oL3u9Ex37FGdr2V9
 YC0n37gxqnsGlMY0hek7KWpcf+5ft0HBh4CrLVMF/FMneicY+Zf2UgdzQGZe1pHVYeRl
 2G9MbAvabncfBBYpDIUEC/qORUsGKHmHYB7GzcfM/VvVvBxVriJWw2xJQ/Fk0YClYk/z
 eNtmTwful4RKC7P4AF3wRWSuMqC59BjQU9BzG8Ax00R4i8N1oX77E7bFInqfaJE7QGNK
 h50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NXIP8xN/u/30A/DOzeJjvIPxCgaJSWyBn+zfSCJmw7U=;
 b=A2svXeLuFqQkDsSknETARc1dYCbnnlk6ldOasOAa7dq3kMBTUZEOiLKREy+4PYQgwn
 IQ7TpsA0qKyUKbw93e6T+iqoCUHADxakKEG7WvBa5PIXW0Q/0e5jMPUMA43FOv+fVy8e
 +xaE+sd0OjVN1AguaJFsQDGENSCEn3wV11C0bR9YCbHJvy/5fnhCniXY0iVE9BeK2AD9
 RuKp39mA/Meu/GcCzHupJoJRBwdz3YUK9kBQuVHh/Hoi8nQjztm88cHm6/UY26n6xwX8
 71/E4otNZKEDe9pcoPuf6f6pWQBkplSh+I/Q4SRGndS0ntX9PWCgapuXkOI7hnlrhalg
 VfDg==
X-Gm-Message-State: AOAM532vFwtjcx6AoR2clbwp1P7Zqm+06gPFD8YTKIhNajI7IgV/4d0O
 z2a50lI2CQ1ExnkMwTI7Gw4=
X-Google-Smtp-Source: ABdhPJwkuO5FZqeDgmCPtTbCUbHOmNwQIzTiMmuggRKuOmoqSGzV0ls910IECivx0W1f+qqPrdb2cQ==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr13828017wru.423.1634903182280; 
 Fri, 22 Oct 2021 04:46:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a39f:d981:e7cb:e6dc?
 ([2a02:908:1252:fb60:a39f:d981:e7cb:e6dc])
 by smtp.gmail.com with ESMTPSA id s3sm9297941wmh.30.2021.10.22.04.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Oct 2021 04:46:21 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com, lijo.lazar@amd.com
References: <20211022105423.69769-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3afc42fd-0062-9e8d-1690-07be82afb9ad@gmail.com>
Date: Fri, 22 Oct 2021 13:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022105423.69769-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
series.

But please keep in mind that this here needs extensive testing.

Thanks,
Christian.

Am 22.10.21 um 12:54 schrieb Nirmoy Das:
> Do not allow exported amdgpu_gtt_mgr_*() to accept
> any ttm_resource_manager pointer. Also there is no need
> to force other module to call a ttm function just to
> eventually call gtt_mgr functions.
>
> v4: remove unused adev.
> v3: upcast mgr from ttm resopurce manager instead of
> getting it from adev.
> v2: pass adev's gtt_mgr instead of adev.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 22 ++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
>   4 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ce86244144..2b53d86aebac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>
>   	amdgpu_virt_init_data_exchange(adev);
>   	/* we need recover gart prior to run SMC/CP/SDMA resume */
> -	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>
>   	r = amdgpu_device_fw_loading(adev);
>   	if (r)
> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					amdgpu_inc_vram_lost(tmp_adev);
>   				}
>
> -				r = amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, TTM_PL_TT));
> +				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
>   				if (r)
>   					goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index c18f16b3be9c..9151950e0cc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -77,10 +77,8 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	struct ttm_resource_manager *man;
>
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
> +	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr));
>   }
>
>   static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
> @@ -206,14 +204,15 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   /**
>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Return how many bytes are used in the GTT domain
>    */
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	s64 result = man->size - atomic64_read(&mgr->available);
> +	s64 result;
> +
> +	result = mgr->manager.size - atomic64_read(&mgr->available);
>
>   	return (result > 0 ? result : 0) * PAGE_SIZE;
>   }
> @@ -221,16 +220,15 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>   /**
>    * amdgpu_gtt_mgr_recover - re-init gart
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Re-init the gart for each known BO in the GTT.
>    */
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	struct amdgpu_device *adev;
>   	struct amdgpu_gtt_node *node;
>   	struct drm_mm_node *mm_node;
> +	struct amdgpu_device *adev;
>   	int r = 0;
>
>   	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> @@ -267,7 +265,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>
>   	drm_printf(printer, "man size:%llu pages, gtt available:%lld pages, usage:%lluMB\n",
>   		   man->size, (u64)atomic64_read(&mgr->available),
> -		   amdgpu_gtt_mgr_usage(man) >> 20);
> +		   amdgpu_gtt_mgr_usage(mgr) >> 20);
>   }
>
>   static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2955ea4a62b..603ce32db5c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GTT_USAGE:
> -		ui64 = amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GDS_CONFIG: {
>   		struct drm_amdgpu_info_gds gds_info;
> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>   			atomic64_read(&adev->gart_pin_size);
>   		mem.gtt.heap_usage =
> -			amdgpu_gtt_mgr_usage(gtt_man);
> +			amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>
>   		return copy_to_user(out, &mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..af1c4e414979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr);
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>
> --
> 2.32.0
>


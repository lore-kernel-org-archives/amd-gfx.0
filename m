Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EADBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 17:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECADA10E19C;
	Thu, 14 Apr 2022 17:46:38 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6575510E19C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 17:46:37 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae92a.dynamic.kabel-deutschland.de
 [95.90.233.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D944261EA1928;
 Thu, 14 Apr 2022 19:46:34 +0200 (CEST)
Message-ID: <e0a1119a-3cb4-4449-142d-a51baa8ad396@molgen.mpg.de>
Date: Thu, 14 Apr 2022 19:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220414081909.796653-1-Lang.Yu@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220414081909.796653-1-Lang.Yu@amd.com>
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Lang,


Thank you for the patch.

Am 14.04.22 um 10:19 schrieb Lang Yu:
> The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
> TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
> heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
> on some ASICs when running SVM applications.

Please list the ASICs, you know of having problems, and even add how to 
reproduce this.


Kind regards,

Paul


> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
>   3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 91f82a9ccdaf..459f59e3d0ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>   	return ret;
>   }
>   
> -static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> -{
> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> -		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> -		dev->adev->sdma.instance[0].fw_version >= 18) ||
> -		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> -}
> -
>   static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   					struct kfd_process *p, void *data)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 8a43def1f638..aff6f598ff2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
>   
>   void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>   
> +static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> +{
> +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> +	       dev->adev->sdma.instance[0].fw_version >= 18) ||
> +	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> +}
> +
>   bool kfd_is_locked(void);
>   
>   /* Compute profile */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 459fa07a3bcc..5afe216cf099 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   			if (r)
>   				break;
>   		}
> -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> +
> +		if (kfd_flush_tlb_after_unmap(pdd->dev))
> +			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
>   	}
>   
>   	return r;

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BF0C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 08:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C4310FB94;
	Tue, 12 Mar 2024 08:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="gTEP+qU+";
	dkim-atps=neutral
X-Greylist: delayed 319 seconds by postgrey-1.36 at gabe;
 Mon, 11 Mar 2024 21:57:31 UTC
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A4F112CAD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 21:57:31 +0000 (UTC)
Message-ID: <03fe26b2-1b6b-49c8-ac34-e90c76562114@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1710193930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3PsOHFrYJtHkNhKadH4zMG3Rkf5nMiw+jz9fku5Ijs=;
 b=gTEP+qU+CrDNEe+UqbIGyHEDITEIH6ZCbnXqkhAaC/NEp/42LkFaVLwHPSvhKmRFh4EXoK
 7wAIXQFNQ8YGzxV+NiKnK3uIzUx+SctMmQPXRsxBs27pV4tQA3PPx+ydlh7ZPc6jVOlLSV
 NKQQ0EZZCwY6ASqyrph/T80T22GVoQ4=
Date: Tue, 12 Mar 2024 05:51:42 +0800
MIME-Version: 1.0
Subject: Re: [09/13] drm/gem: Acquire reservation lock in drm_gem_{pin/unpin}()
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 christian.koenig@amd.com, sumit.semwal@linaro.org,
 dmitry.osipenko@collabora.com, robdclark@gmail.com,
 quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, sean@poorly.run,
 marijn.suijten@somainline.org, kherbst@redhat.com, lyude@redhat.com,
 dakr@redhat.com, airlied@redhat.com, kraxel@redhat.com,
 alexander.deucher@amd.com, Xinhui.Pan@amd.com, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20240227113853.8464-10-tzimmermann@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240227113853.8464-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 12 Mar 2024 08:30:05 +0000
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

Hi,


On 2024/2/27 18:14, Thomas Zimmermann wrote:
> Acquire the buffer object's reservation lock in drm_gem_pin() and
> remove locking the drivers' GEM callbacks where necessary. Same for
> unpin().
>
> DRM drivers and memory managers modified by this patch will now have
> correct dma-buf locking semantics: the caller is responsible for
> holding the reservation lock when calling the pin or unpin callback.
>
> DRM drivers and memory managers that are not modified will now be
> protected against concurent invocation of their pin and unpin callbacks.

'concurent' -> 'concurrent'

> PRIME does not implement struct dma_buf_ops.pin, which requires
> the caller to hold the reservation lock. It does implement struct
> dma_buf_ops.attach, which requires to callee to acquire the
> reservation lock.

which requires 'the' callee to acquire the reservation lock.


> The PRIME code uses drm_gem_pin(), so locks
> are now taken as specified. Same for unpin and detach.
>
> The patch harmonizes GEM pin and unpin to have non-interruptible
> reservation locking across all drivers, as is already the case for
> vmap and vunmap. This affects gem-shmem, gem-vram, loongson, qxl and
> radeon.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>


Tested with drm/loongson, play with a few days.
Switch to virtual terminal, then switch back is fine.
not found problems yet. So,

Tested-by: Sui Jingfeng <sui.jingfeng@linux.dev>


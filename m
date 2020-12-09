Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A28C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 17:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C001523CD3
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 17:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C001523CD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAD36EA6B;
	Wed,  9 Dec 2020 17:30:42 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CCB6EB0E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 17:30:41 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id y24so2140438otk.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Dec 2020 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xCrLrqlgw9ZQwJN5bErorIANNjsemhi3XGANfS8hrQA=;
 b=GsCBBc8DDvYMNbJOyFTWr3hB2jg928EbhbCehQMBflnrXKZyszxEq6J0zI7w34/I80
 M3Wuxhj6q/ER5ppqmkfyN6F62k8n98NfhxSrLKhRAPIfKNDGlhXvtWvVZlc7Y24eW5dq
 0ihJJk95UncX75ocKMKZQa1/V98vzRt+GJCMQmY/74+10iRSD/QAKPUJhMhPTCbP0lb3
 1DtzETBOuc6nAT0vJwRAz10y4RHoTpJZz/ALxn+9h6gWFOd02lCNTn/m0vT8QzmPYtUU
 jpKgnhhLz6Prc70JaunEYmEsgggudx4lSTlFiHnKLnaz8i4PrFoOjoJPJm+mv2tdRmiG
 saaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xCrLrqlgw9ZQwJN5bErorIANNjsemhi3XGANfS8hrQA=;
 b=NUg32cPT+b1WkTrocdKgfVL47Rf4jPov3kcqtxjsSRZd9VhS3q5EpQ7FfThHxYOBhV
 Pzw7fIO4g3WiF4lyEXZv74ZuX7jFZ2GuDnLhZoBfErtW4i3UHMhz8a2EMGdO6hOl8npk
 eVYjz3AI2FyUBLzjnqsl66afNUIddBIV/tK5QuiDqx7shGe6C6vaUJJ+alS/jCZL06mz
 SSXqVSteRc9ZmUZpuqpbxsB8PcepUD771hDc0hSRfrUcFUKD+Vq1n5Ea0gw/XSEij5bi
 3bODafJ79Z3vc+ATnzJhmqtWNCz5+XpW6o0xDwpDM0Gj7dyvMBQqlmbtWvoQ60zfdfIk
 umfw==
X-Gm-Message-State: AOAM533sH9hLLOwSDfbEjUQgH7EoMLiTo4tbwjWs8PqmMFRkaCZnVDpG
 1ebG5tQkYjZayTpcOh9usnq1cFRag53h/0u9mBMswLRH
X-Google-Smtp-Source: ABdhPJxRQAKZ2iyrSZGkmz4tee4nXWzw2DMJ3bktXE/LY78gq9CoK2D20xGvtG1tqWM2YcNgsOtR8jntELvJYnP7rfs=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr2825387ote.132.1607535040037; 
 Wed, 09 Dec 2020 09:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20201204204130.3697-1-alexander.deucher@amd.com>
In-Reply-To: <20201204204130.3697-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Dec 2020 12:30:29 -0500
Message-ID: <CADnq5_PABFEnCdvnZfm832aDHti66ujdzTjUFur3FT-O-+wbKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: take runtime pm reference when we attach a
 buffer
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 4, 2020 at 3:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> And drop it when we detach.  If the shared buffer is in vram,
> we need to make sure we don't put the device into runtime
> suspend.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


Ping?  Any thoughts on this?  We really only need this for p2p since
device memory in involved, but I'm not sure of the best way to handle
that.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 5b465ab774d1..f63f182f37f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -40,6 +40,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-array.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/pm_runtime.h>
>
>  /**
>   * amdgpu_gem_prime_vmap - &dma_buf_ops.vmap implementation
> @@ -187,9 +188,13 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>         if (attach->dev->driver == adev->dev->driver)
>                 return 0;
>
> +       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +       if (r < 0)
> +               goto out;
> +
>         r = amdgpu_bo_reserve(bo, false);
>         if (unlikely(r != 0))
> -               return r;
> +               goto out;
>
>         /*
>          * We only create shared fences for internal use, but importers
> @@ -201,11 +206,15 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>          */
>         r = __dma_resv_make_exclusive(bo->tbo.base.resv);
>         if (r)
> -               return r;
> +               goto out;
>
>         bo->prime_shared_count++;
>         amdgpu_bo_unreserve(bo);
>         return 0;
> +
> +out:
> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +       return r;
>  }
>
>  /**
> @@ -225,6 +234,9 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
>
>         if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
>                 bo->prime_shared_count--;
> +
> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  }
>
>  /**
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067F6C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27ED23D50
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27ED23D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DA46E3F5;
	Thu, 10 Dec 2020 15:54:48 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADE46E3F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 15:54:46 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id y24so5286423otk.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 07:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=37w8GY5sf+U0nAegtPSsI4r7NdHIiprJvayhOvcPJ/s=;
 b=LNg3XMywZ+pkCpOai5rpYfOspHEyQhf30Y0gbFTnSBFzneAvs9AyD3wsmxarCuyyFG
 RdOaAOOJL3C2OtVPEHa26Ge2pKjpDGhNg3YRvYb7Kq1zB3qfbrmynsbNNzryYIezoWpR
 u8seecSJgvhCD58tGMWsoDw/aNSuYlFP4vcjZ1+2/DO1UyWsLz7YxF8PQZLckeM1q7QS
 sCH+n7aTSBihXF4UOQnVgU8NcAbr9m4pNlgEtMwVk5r7cdWPw6klfGAxJp56/hxBAtc7
 +J9Aw9YofFYZMkF6oR6RdNyzNPACypuCPDzAnKNgBpj8jSczFFy+0KA08vl6GG2tB2Fk
 Eoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=37w8GY5sf+U0nAegtPSsI4r7NdHIiprJvayhOvcPJ/s=;
 b=bV4bbpLT68alX0+WjCtvSrn8ja3tEZD2AtEgtATgrq/AH9XygXHRPVZO8OvogpddYW
 b1yMN6ABiqkOVD8F5HK7w9OwfhqEMhKZCO7FyeH0iBxinuXzUrrjsEEBx65o8p3lCYFH
 Mnc0UMV0UaK0Z+P4/Fnf4nQh3aLkYz3EDS7q/KsVy4ZMe6G7o72ImkOaiEAz1PrLoAGj
 BXxzN1+REskR+I0Ks2MmVTll9rk/m6wpFRG7AFyWwijpL7xCNqmnvQ5OzMFZSt1pYMF+
 MlzOSb9dnxl9yZZcxohsQT9QsF7e6g6QRocHsWfUhrlWa92XGaYDwpQfpg972Nf7WYH1
 NnLA==
X-Gm-Message-State: AOAM530C0VP8K14pphy3LNTSQnzMD6QEsNN7YAQ9grdYCbSH5A8Vn4dK
 +vniYQBWFv8nxDxe2iO3FRrjl5bGzLpKmXNQOnI=
X-Google-Smtp-Source: ABdhPJzXDyc5K+OcXLUQhfUAaB/o7+QXhl3ljJqFP0ozEWrG5HmQs5w7T752UWYNkYYbb8Xkjxcr64EiuF1y5SYLYTg=
X-Received: by 2002:a9d:4ce:: with SMTP id 72mr6354439otm.23.1607615685763;
 Thu, 10 Dec 2020 07:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20201204204130.3697-1-alexander.deucher@amd.com>
 <CADnq5_PABFEnCdvnZfm832aDHti66ujdzTjUFur3FT-O-+wbKg@mail.gmail.com>
 <410bc5c9-381b-5e65-5595-ec891f0edae2@amd.com>
In-Reply-To: <410bc5c9-381b-5e65-5595-ec891f0edae2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Dec 2020 10:54:34 -0500
Message-ID: <CADnq5_PkDQjRWk_M4MFW_PoRih_kgD5UBn5aT4LVRN-Si7+o0g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: take runtime pm reference when we attach a
 buffer
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 9, 2020 at 11:49 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
>
> On 09/12/20 11:00 pm, Alex Deucher wrote:
> > On Fri, Dec 4, 2020 at 3:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >> And drop it when we detach.  If the shared buffer is in vram,
> >> we need to make sure we don't put the device into runtime
> >> suspend.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Ping?  Any thoughts on this?  We really only need this for p2p since
> > device memory in involved, but I'm not sure of the best way to handle
> > that.
> >
> > Alex
> >
> >
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >> index 5b465ab774d1..f63f182f37f9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >> @@ -40,6 +40,7 @@
> >>  #include <linux/dma-buf.h>
> >>  #include <linux/dma-fence-array.h>
> >>  #include <linux/pci-p2pdma.h>
> >> +#include <linux/pm_runtime.h>
> >>
> >>  /**
> >>   * amdgpu_gem_prime_vmap - &dma_buf_ops.vmap implementation
> >> @@ -187,9 +188,13 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
> >>         if (attach->dev->driver == adev->dev->driver)
> >>                 return 0;
> >>
> >> +       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> +       if (r < 0)
> >> +               goto out;
> >> +
> I am a bit skeptical if we should fail the BO reserve if we don't get the sync ? I was hoping to continue with it, with a warning maybe, so that it doesn't block the existing functionality ?
> >>         r = amdgpu_bo_reserve(bo, false);
> >>         if (unlikely(r != 0))
> >> -               return r;
> >> +               goto out;
> >>
> >>         /*
> >>          * We only create shared fences for internal use, but importers
> >> @@ -201,11 +206,15 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
> >>          */
> >>         r = __dma_resv_make_exclusive(bo->tbo.base.resv);
> >>         if (r)
> >> -               return r;
> >> +               goto out;
> >>
> >>         bo->prime_shared_count++;
> >>         amdgpu_bo_unreserve(bo);
> >>         return 0;
> >> +
> >> +out:
> >> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>
> Why not just pm_runtime_put_sync ? Why autosuspend ?

Not sure.  I'm just copying what we do in other cases which happens to
work.  I'm not really a runtime pm expert.

Alex

>
> - Shashank
>
> >> +       return r;
> >>  }
> >>
> >>  /**
> >> @@ -225,6 +234,9 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
> >>
> >>         if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
> >>                 bo->prime_shared_count--;
> >> +
> >> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >>  }
> >>
> >>  /**
> >> --
> >> 2.25.4
> >>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cshashank.sharma%40amd.com%7Cd5fccf427c34414ff4e708d89c682898%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637431318483043257%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NpCTY%2FVKd%2FBDi1wsFC79qSUTmNHx3nBp0HUj3m0cFeM%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

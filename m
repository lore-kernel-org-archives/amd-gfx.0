Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA8C48BDF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB4061354
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB4061354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927FE6E5A9;
	Wed,  9 Jun 2021 15:38:39 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39E66E5A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 15:38:38 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so10616551otl.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Jun 2021 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y63t8ZORVhjauDyVyY6Gkgi4pfXliAjfIJjAR0GAYWw=;
 b=KT1JuDwaQ8ptoB5YC8pNo37uF42g88Is8B2x/yiG3C3uOFsqgfbeHj67zoUhLpo9wi
 hU6GM6nDHi3id2X5xUJh5m0l3yp69t22FFNjhLK8/KXV+cVRfD0ihOhmXv4LJk3r4+my
 7dGF7/IuljPR+QYHwlzJALI7sCV1L5wPLo0K0cfxvXdcw3dAj5Jbz3+WcEHtiyRVM/1M
 JAJlX8HCENHYci6QdLcf2aCyBzH/fUCf19TuovVC6JkCzRM/ihkn6kbxfCuM1wWI1OYf
 HOVV7WCVMiKJMF3R4pKPcOPd32qxGSIwJqr4CTfHAUuoMMCs6uCoaP/fA33idxovRg6E
 0WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y63t8ZORVhjauDyVyY6Gkgi4pfXliAjfIJjAR0GAYWw=;
 b=rKp+HbJU0SSrSqaEc17nC9QdBLgmW0C8xAU6otX20Pyckv1QU5ZPt+bNUOBJS+f/xE
 q/rvrvgHMVKHG6Z0L9ffMzZxUGpYafs4flApRlgMqFUdw2gKLI2pYRp5Blv6iP9EF7Dt
 w+pr0A2SZ2DvhwWxSNaVPNEiTxQXdsiix175JUgzzM3Luf8ybzpWlNvzh6iaixB8Jun1
 CkQp78XslnvbBAHxQvdsG2wsOuV79KPyXRDIDLmasQjp6eYJpqnEHmPeUYHm9HFAOoRS
 IbXvFH01fzUL4C3cnbxC1PfGXga04o/nxqag7e1k02IA3g+a0B4aKFZHjsj/veLOvZp6
 6Gsg==
X-Gm-Message-State: AOAM531CaAl0VkOAiUowO4wAPLxOZlCOq5CrRKY3ZakH7CGzYKuIrrin
 7o8kxlvFJvTfaEkY244aOxboDFZ8kcWpSuN56+0=
X-Google-Smtp-Source: ABdhPJyKSZ7CkKYvfnf2XXAumOee/Km5nDUMkGLeGnCu3OeEH25mPnln2i28SPMWYhbE+7yrrAFvBeP++22IYQ/U7Ok=
X-Received: by 2002:a9d:6287:: with SMTP id x7mr49204otk.132.1623253117032;
 Wed, 09 Jun 2021 08:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210609092323.32650-1-guchun.chen@amd.com>
In-Reply-To: <20210609092323.32650-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Jun 2021 11:38:26 -0400
Message-ID: <CADnq5_NAfrOiHwx5D3SHsvvrzCbh_Rwju=AV8DT434oJm5vjUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: "Kuehling, Felix" <felix.kuehling@amd.com>, "Tuikov,
 Luben" <luben.tuikov@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 9, 2021 at 5:23 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Fixes:
> 9faf262c32d3 drm/amdgpu: Add DMA mapping of GTT BOs
> 090f3a60d7e8 drm/amdgpu: Use delayed work to collect RAS error counters
>

drop the fixes lines and say something like use the adev_to_drm()
macro for consistency.  With that,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 016815b7a773..fb6bcc386de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>                 }
>         }
>
> -       gobj = amdgpu_gem_prime_import(&adev->ddev, mem->dmabuf);
> +       gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
>         if (IS_ERR(gobj))
>                 return PTR_ERR(gobj);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ec936cde2726..bfbcb9ff2453 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
>         struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
>                                               ras_counte_delay_work.work);
>         struct amdgpu_device *adev = con->adev;
> -       struct drm_device *dev = &adev->ddev;
> +       struct drm_device *dev = adev_to_drm(adev->ddev);
>         unsigned long ce_count, ue_count;
>         int res;
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

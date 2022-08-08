Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF41EC00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 20:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2D210F7CE;
	Mon,  8 Aug 2022 20:49:45 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E682113720
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 20:49:27 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 j66-20020a9d17c8000000b00636b0377a8cso6298837otj.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Aug 2022 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=gJegF7VoLWtbkExwmRXuZ8EjbsjoXQ5tSwvTAWFdxiI=;
 b=DscoJXZFnguusUfohhvLTQMSsn91ZRt9CLp8oVhrvS2CPE9qr7p4OiFFBabELfNn1Q
 CYE1nASgn88LbqvWicZsRzGl/fq3lqDpzDCgvgDMysWNGjAbSHW37Dyg3GavVy7pHOfl
 CslxSlwv1iFtUGAXYkSoHaHkFUGoufndgwcepymGxL1i1QMRJ9sZ8BBI9qZPgm61AX13
 WsPln1qv+Z13Ec3FMBHEzaVQqjj4ynQEmj6QD/Yq2yBO63TGtj32zYw0yhXMMmKL9XKI
 8LkrEL/1RpC9CF9im8SeO9jPHLMnHB3i2RyQcLHdxGOx4/WE54wTFM6qYsu3ORv5Z57K
 0euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=gJegF7VoLWtbkExwmRXuZ8EjbsjoXQ5tSwvTAWFdxiI=;
 b=E1eDd1oM48gtOpoFDyrre6EW6d3XjJ5QA2Z0sqFz/hatEhkZr6Ihsk7a/e68qwcrY4
 +WODHgEbG002Bxh2NFWbZ0J/7SUUs/2toMUrpRSafbiljCnNXMcu4Gbz7EX4ju6IVfst
 PnJl/vjPEizwbinnd+GfZSrU1f5NtztxnZzUuH7S3BBTDQPx6AjXt4daGsVWCHfMV3Kz
 aNoNJtOOnjnio3E4SqiqMpQahQnqOeIzOnpvJlil7Ajs+FYQFoX8rCl+E/CDbk0JX7iA
 2dQuriP1+eRnk/FIOlwuPUlHKOE4279sSFdxDixbjUMFDMsVGZIWJkGRc+1Mj1MnOG+1
 k6qg==
X-Gm-Message-State: ACgBeo07I80WkNaTVB3SUOTwrl2xEW7e34tx9DBC1GC60vQ3lEtCdkx0
 j9EXQb7fTP5xnNu/b2ObwkZhiD/kGAuIv8RdpweG9mNKGs8=
X-Google-Smtp-Source: AA6agR7zTBMjaXQGSQhviedp9ASNH1U4So9Din7gD1a5G0KASovMO0ZgQ+gqln1HA5EfbmB3b0pfSB5e1piBbCFmdGU=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr2733782otr.12.1659991766690; Mon, 08 Aug
 2022 13:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220803090134.529299-1-dusica.milinkovic@amd.com>
In-Reply-To: <20220803090134.529299-1-dusica.milinkovic@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Aug 2022 16:49:15 -0400
Message-ID: <CADnq5_ODjyTHPpGcsuHpbmaC-_MXvzKq7xXVKY9e5q7bwRBAfw@mail.gmail.com>
Subject: Re: [PATCH] Increase tlb flush timeout for sriov
To: Dusica Milinkovic <dusica.milinkovic@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 3, 2022 at 5:02 AM Dusica Milinkovic
<dusica.milinkovic@amd.com> wrote:
>

Please include a patch description.  Why do you need a longer timeout?
 What problem does it fix?

> Signed-off-by: Dusica Milinkovic <dusica.milinkovic@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 9ae8cdaa033e..6ab7d329916f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
>         struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>
> @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
> +               else
> +                       r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);

What about something like this?
u32 usec_timeout = amdgpu_sriov_vf(adev) ? 6000000 :
adev->usec_timeout;  /* wait for 12 * 500ms for SRIOV */
...
r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);


>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>                         return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 22761a3bb818..941a6b52fa72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
>         struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>
> @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
> +               else
> +                       r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);

Same comment here.

Alex

>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>                         up_read(&adev->reset_domain->sem);
> --
> 2.25.1
>

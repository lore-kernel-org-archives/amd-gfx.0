Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A6DC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDC12073A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHFpqK+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDC12073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431AA6E519;
	Fri, 28 Aug 2020 19:28:18 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE97E6E519
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 19:28:16 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id o21so233851wmc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jFKAYlpAHKbxcf5xCoLjGpARo09sp296iEom9rSMKbg=;
 b=iHFpqK+VIMpujAMJnVIW1LRMartSAP5rWp2KqbUYV8NPY5Ufn6oGGFjwCOe8j3DQ7k
 XzFSyhEPht9jGlsoudYqaGxu5XAAnMECOtLuL20IhJf4oNLKW+TaqYOLftmOj5e99Wph
 nBEUEo6vqAxCMlIiGwsBRfIK3wkvn9hTOYo/zVnu1ZP9+uW1oO+c4rfEWlmQ4rN9xh2U
 pEfCT017YSk5nYZTUiV+9TUF9/PrfeOiyFro7PPnx7f1bwuCx08PmsuNeMuhFq/IRWr/
 HW0ltec0qnzAqlyT+JgSL8cJ5Ybw+ILHQTxOuUpoS/GsMi5cytGR4ix4ulvzU2uzS1Gk
 NkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jFKAYlpAHKbxcf5xCoLjGpARo09sp296iEom9rSMKbg=;
 b=X6dbpNuFE0bQrlxG875g1Kd1Eim/GyYjXTZsEUIQ/zUoMGoyIuVu3dYkh2a3howQmv
 sdfLAINi/68AlAN/Yo/JSRfwhiGGw0EiHb8uvYjG7aNTdupp2lxEDkDNFlQpI/rPmujo
 YJBl/p7i7JHJybKgUypYIlOWGCRpUNyEtOHrtKvPjssP9eSfPpkY4yZyr+LkhlEQ4YgR
 Y8EymaN18nzNVdQ8EVKcL2FWrqM7FpSYdv1V4Y3EnB/kf3hzCYr+Dw4pGwr9jd38Jg5y
 pO1JNV7QwhIojI+wlxo4u60mOlXfns6Mcvbuq7u4/qzeN81Tda6QS0w+awd+V4+vv+Tt
 E4mA==
X-Gm-Message-State: AOAM5308dj5VesczNruYNqAHvXuLWwql9oHueG2VNJR//3tUAmEhSx4G
 MXKszs9uOvS8GN/ogbg2xI+avkxXkXcoUXFWGq9GGmO8
X-Google-Smtp-Source: ABdhPJxRE0EPyly+WTZNicP3sW92saM54L9AgKKivt9e7NBY8ME+woFWS3oxSEvNlEWg3cNr15npUsnEfojmClkS6K0=
X-Received: by 2002:a1c:6155:: with SMTP id v82mr196061wmb.70.1598642895548;
 Fri, 28 Aug 2020 12:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-4-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598630743-21155-4-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 15:28:04 -0400
Message-ID: <CADnq5_PUifk==tNW0NRWU6_qgT7fgoeX-Y_j3Y--Y+706zs7BA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] drm/amdgpu: Block all job scheduling activity
 during DPC recovery
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> DPC recovery involves ASIC reset just as normal GPU recovery so blosk

Typo: "block"

> SW GPU scedulers and wait on all concurent GPU resets.

Typos: "schedulers" and "concurrent"

>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e67cbf2..9a367a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4745,6 +4745,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>         return 0;
>  }
>
> +static void amdgpu_cancel_all_tdr(struct amdgpu_device *adev)
> +{
> +       int i;
> +
> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +               struct amdgpu_ring *ring = adev->rings[i];
> +
> +               if (!ring || !ring->sched.thread)
> +                       continue;
> +
> +               cancel_delayed_work_sync(&ring->sched.work_tdr);
> +       }
> +}
> +
>  /**
>   * amdgpu_pci_error_detected - Called when a PCI error is detected.
>   * @pdev: PCI device struct
> @@ -4758,16 +4772,38 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
>         struct amdgpu_device *adev = drm_to_adev(dev);
> +       int i;
>
>         DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
>
>         switch (state) {
>         case pci_channel_io_normal:
>                 return PCI_ERS_RESULT_CAN_RECOVER;
> -       case pci_channel_io_frozen: {
> -               /* Fatal error, prepare for slot reset */
> +       case pci_channel_io_frozen: { /* Fatal error, prepare for slot reset */
> +
> +               /*
> +                * Cancel and wait for all TDRs in progress if failing to
> +                * set  adev->in_gpu_reset in amdgpu_device_lock_adev
> +                *
> +                * Locking adev->reset_sem will perevent any external access

Typo: "prevent"

> +                * to GPU during PCI error recovery
> +                */
> +               while (!amdgpu_device_lock_adev(adev, NULL))
> +                       amdgpu_cancel_all_tdr(adev);
> +
> +               /*
> +                * Block any work scheduling as we do for regualr GPU reset

Typo: "regular"

> +                * for the duration of the recoveryq

Typo: "recovery"

Overall looks good to me, but you might want to run the scheduling
changes by Christian as well.  With the typos fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>


> +                */
> +               for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +                       struct amdgpu_ring *ring = adev->rings[i];
> +
> +                       if (!ring || !ring->sched.thread)
> +                               continue;
> +
> +                       drm_sched_stop(&ring->sched, NULL);
> +               }
>
> -               amdgpu_device_lock_adev(adev);
>                 return PCI_ERS_RESULT_NEED_RESET;
>         }
>         case pci_channel_io_perm_failure:
> @@ -4900,8 +4936,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
>         struct amdgpu_device *adev = drm_to_adev(dev);
> +       int i;
>
> -       amdgpu_device_unlock_adev(adev);
>
>         DRM_INFO("PCI error: resume callback!!\n");
> +
> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +               struct amdgpu_ring *ring = adev->rings[i];
> +
> +               if (!ring || !ring->sched.thread)
> +                       continue;
> +
> +
> +               drm_sched_resubmit_jobs(&ring->sched);
> +               drm_sched_start(&ring->sched, true);
> +       }
> +
> +       amdgpu_device_unlock_adev(adev);
>  }
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301BEC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 13:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E012070A
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 13:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtB9DHJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E012070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABCB6E83E;
	Wed, 20 May 2020 13:11:40 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813946E83E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 13:11:39 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id e16so3075529wra.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AA7pbRHkCKq1JqVt4u4J1i14lbzsag4Sdkrx6gt11Bw=;
 b=QtB9DHJHTNUtE4s0wvVj92ayERy2m26yo4lB5zLtMWLC1OQnI/dKu7i6FzrDpNb1Vj
 PMNfjzMt4vIPriZbvGTzh6CH75XmX2Y6/VlAjzatPBuRvMOwAF46d7D9iOXXY+oftPVU
 h15g4HX9yd3CrnnPlekHs+lXqP+VQXv4cyMY+wOf+3l91xGVnbqGdcsjVe7Ukx7yoxnW
 ZOZLanJE9u/0/pOEB2eY7lLSLAfOFGBov8+7VOrlZxKnlkbVivZ+/2mjdr1qOTaeH4jC
 uFDQxez73O89KNrDrOS/ceBXAUE9Tnzemb9Rh+eAhM+CHgKyBC3oVrjvuSu3ojTWgn2u
 Rt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AA7pbRHkCKq1JqVt4u4J1i14lbzsag4Sdkrx6gt11Bw=;
 b=dNGVN1gABP9gGyr+qbxXj79whsXfSzthNQn+nYrWljUrEB51a39mgmxRIvCHTbZtU2
 oeQpxTSv39bQOMWA4I/RgwtVT+scZQ3Q6bIWkEvVDPD0qj1TVAU3wiWTIWmZfpe+E/Qm
 lZ/7hL4IuNjQCo+X8oJfcazzlppakMRX9y2ZNwPbEAlG6nZ/hQz/y0q2M5bve4vXHEil
 /Ah7lXu95TXg3vOe7hQg0e+O6WC8gsZarms1SP27qjNVcgI88qW/+K8DvpHipC/pOzTM
 BLThk1EPNjBdXBUKWiG7bjCA2H8efrO1kcaC1TXUuhTe4ITkch7bhEnxaLrexGWyAgcU
 6Bdg==
X-Gm-Message-State: AOAM533tAVOr2lBTX4xwm5H5ANnsVYR6S8jaEywl7dgqo9kxMTsOxqGP
 wY/ciJ7jGi+ya3DrFIXabE77ImHK1MOl37zYXiZxBQ==
X-Google-Smtp-Source: ABdhPJy3XdOZhtrGKxGz+QFNb7LTq/Dk/UJ3CE3O6nSHATsjFKlQ4U46d+6l0tibynnjOZctO1/SSeef1Jxmn8G6wtU=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr4047154wrr.111.1589980298130; 
 Wed, 20 May 2020 06:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200520103948.30993-1-evan.quan@amd.com>
In-Reply-To: <20200520103948.30993-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 May 2020 09:11:26 -0400
Message-ID: <CADnq5_OD0yfr-UGgffm7_CdaBC6KnkzsxYceG9Ho9Gg0HySxNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: unify the prompts on thermal interrupts
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 20, 2020 at 6:40 AM Evan Quan <evan.quan@amd.com> wrote:
>
> The prompts will contain pci address(segment/bus/port/function),
> severity(warn or error) and some keywords(GPU, amdgpu). Also this
> address the issue that pci bus retrieved by PCI_BUS_NUM(adev->pdev->devfn)
> is wrong.
>
> Change-Id: I714d1dffb30a6cf76dcede087cf5d9302f683ed8
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/powerplay/hwmgr/smu_helper.c  | 38 +++++--------------
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 26 ++++---------
>  2 files changed, 17 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
> index 4279f95ba779..60b5ca974356 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
> @@ -597,58 +597,40 @@ int phm_irq_process(struct amdgpu_device *adev,
>
>         if (client_id == AMDGPU_IRQ_CLIENTID_LEGACY) {
>                 if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH) {
> -                       pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
> -                                               PCI_BUS_NUM(adev->pdev->devfn),
> -                                               PCI_SLOT(adev->pdev->devfn),
> -                                               PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
>                         /*
>                          * SW CTF just occurred.
>                          * Try to do a graceful shutdown to prevent further damage.
>                          */
> -                       dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
> +                       dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
>                         orderly_poweroff(true);
>                 } else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
> -                       pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
> -                                       PCI_BUS_NUM(adev->pdev->devfn),
> -                                       PCI_SLOT(adev->pdev->devfn),
> -                                       PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
>                 else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
> -                       pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
> -                                       PCI_BUS_NUM(adev->pdev->devfn),
> -                                       PCI_SLOT(adev->pdev->devfn),
> -                                       PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
>                         /*
>                          * HW CTF just occurred. Shutdown to prevent further damage.
>                          */
> -                       dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
> +                       dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>                         orderly_poweroff(true);
>                 }
>         } else if (client_id == SOC15_IH_CLIENTID_THM) {
>                 if (src_id == 0) {
> -                       pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
> -                                               PCI_BUS_NUM(adev->pdev->devfn),
> -                                               PCI_SLOT(adev->pdev->devfn),
> -                                               PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
>                         /*
>                          * SW CTF just occurred.
>                          * Try to do a graceful shutdown to prevent further damage.
>                          */
> -                       dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
> +                       dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
>                         orderly_poweroff(true);
>                 } else
> -                       pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
> -                                       PCI_BUS_NUM(adev->pdev->devfn),
> -                                       PCI_SLOT(adev->pdev->devfn),
> -                                       PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
>         } else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
> -               pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
> -                               PCI_BUS_NUM(adev->pdev->devfn),
> -                               PCI_SLOT(adev->pdev->devfn),
> -                               PCI_FUNC(adev->pdev->devfn));
> +               dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
>                 /*
>                  * HW CTF just occurred. Shutdown to prevent further damage.
>                  */
> -               dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
> +               dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>                 orderly_poweroff(true);
>         }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index c1ba77344107..f56789f8ec11 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1540,40 +1540,28 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>         if (client_id == SOC15_IH_CLIENTID_THM) {
>                 switch (src_id) {
>                 case THM_11_0__SRCID__THM_DIG_THERM_L2H:
> -                       pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
> -                               PCI_BUS_NUM(adev->pdev->devfn),
> -                               PCI_SLOT(adev->pdev->devfn),
> -                               PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
>                         /*
>                          * SW CTF just occurred.
>                          * Try to do a graceful shutdown to prevent further damage.
>                          */
> -                       dev_emerg(adev->dev, "System is going to shutdown due to SW CTF!\n");
> +                       dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
>                         orderly_poweroff(true);
>                 break;
>                 case THM_11_0__SRCID__THM_DIG_THERM_H2L:
> -                       pr_warn("GPU under temperature range detected on PCIe %d:%d.%d!\n",
> -                               PCI_BUS_NUM(adev->pdev->devfn),
> -                               PCI_SLOT(adev->pdev->devfn),
> -                               PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
>                 break;
>                 default:
> -                       pr_warn("GPU under temperature range unknown src id (%d), detected on PCIe %d:%d.%d!\n",
> -                               src_id,
> -                               PCI_BUS_NUM(adev->pdev->devfn),
> -                               PCI_SLOT(adev->pdev->devfn),
> -                               PCI_FUNC(adev->pdev->devfn));
> +                       dev_emerg(adev->dev, "ERROR: GPU under temperature range unknown src id (%d)\n",
> +                               src_id);
>                 break;
>                 }
>         } else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
> -               pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
> -                               PCI_BUS_NUM(adev->pdev->devfn),
> -                               PCI_SLOT(adev->pdev->devfn),
> -                               PCI_FUNC(adev->pdev->devfn));
> +               dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
>                 /*
>                  * HW CTF just occurred. Shutdown to prevent further damage.
>                  */
> -               dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
> +               dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>                 orderly_poweroff(true);
>         } else if (client_id == SOC15_IH_CLIENTID_MP1) {
>                 if (src_id == 0xfe) {
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40255C47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F7420675
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/l5PXGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F7420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EE96E055;
	Mon, 11 May 2020 19:05:09 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA97B6E055
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 19:05:08 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id m24so9592262wml.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B99a03VMPMn14UKWoId3KsI/+Rgd7HGikndUFBNAca8=;
 b=M/l5PXGXKY/R9bP+Cwec3yKLobfgS/U3JE2RXJxgCpC96GMdfwmN66TQ2Usvr7fnZT
 XKWKspQYdYMagNuCKaKBCKXS8fnDFx8Yk6IpGm+lonK81BTeG57PCeLuIDV7OoiuGB/d
 stjnBO+usOit61uzZjHy9pdLoQAUgMkFKDKu0oGNgofa9IEiOEqO3yxvJFF242Xc7AnN
 2oWLl2+vLjupF3gd4EQEYg+whwXfwb+E66qecCohqo4wao+SAstbha1ZK5Jvz8tiP0OM
 BeZDHcysZeeMzaKFt5BCag3zxMoB3ixaN/46k52torKMjVNxv2Kn53z6wj0mDgm4rkS3
 83YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B99a03VMPMn14UKWoId3KsI/+Rgd7HGikndUFBNAca8=;
 b=kQGtgqdeT4mBL3Wc/hMRqWwp1tk9ZIseOXo5YoRpAUxXt20QfkDr7+uWlrCcSMOcn3
 71lQoeXuSbATG0/F5mgK9brJ5Wig7Q3B5YqtnVmI/+flOOhV+AwHL3HdEn9/pV3KYGXs
 swjZCswDJnVUwubCuZOJTbKcg4jNe02JZW7KqarfsD6EDsgEsglPO9rJAMDDyvz1ZjYP
 L/1V/gCQNCj+aoQdxPA5svN8/e0HX76DPvhKLSYNysG2g4EZuLQou6aF1r5mnpBUzDSD
 x4KLiHO19SlP3q7xISWQLUyPl9+TaPcXiQtgQsdddsdDDrW9tIZAFTsaFefxkFTyOJXG
 XzVA==
X-Gm-Message-State: AGi0PuZU8oeZZDXd3tDWJElzcaSSng5RR9Ijk8LeVqzBAI+W+YBYbraP
 AUe9LspQ1gc2AqADAZgGOZFEWCNgSXx1O0r7h6s=
X-Google-Smtp-Source: APiQypKLQbFxGYRnbTQHmRloPn0pP0UHUhWVUBmPG25XY3gar1KCbFnxUwWLGs2gXd6GXP7MZeCAV3mHSCWvaS81z3U=
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr12589173wmd.79.1589223907591; 
 Mon, 11 May 2020 12:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200509074726.11573-1-evan.quan@amd.com>
 <20200509074726.11573-2-evan.quan@amd.com>
In-Reply-To: <20200509074726.11573-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 May 2020 15:04:56 -0400
Message-ID: <CADnq5_MMpFd6PtT2BOJQa0aTDjC6xbKD0VWf=7WJfyezjPfx2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: shutdown on HW CTF
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

On Sat, May 9, 2020 at 3:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To prevent further damage.
>
> Change-Id: Iae0399001694bb7446bcc6071cd03d8fa47c9d02
> Signed-off-by: Evan Quan <evan.quan@amd.com>


Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/powerplay/hwmgr/smu_helper.c  | 16 +++++++++++++--
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 ++++++++++++++++++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
> index 782f6d295202..4279f95ba779 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
> @@ -612,11 +612,17 @@ int phm_irq_process(struct amdgpu_device *adev,
>                                         PCI_BUS_NUM(adev->pdev->devfn),
>                                         PCI_SLOT(adev->pdev->devfn),
>                                         PCI_FUNC(adev->pdev->devfn));
> -               else if (src_id == VISLANDS30_IV_SRCID_GPIO_19)
> +               else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
>                         pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
>                                         PCI_BUS_NUM(adev->pdev->devfn),
>                                         PCI_SLOT(adev->pdev->devfn),
>                                         PCI_FUNC(adev->pdev->devfn));
> +                       /*
> +                        * HW CTF just occurred. Shutdown to prevent further damage.
> +                        */
> +                       dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
> +                       orderly_poweroff(true);
> +               }
>         } else if (client_id == SOC15_IH_CLIENTID_THM) {
>                 if (src_id == 0) {
>                         pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
> @@ -634,11 +640,17 @@ int phm_irq_process(struct amdgpu_device *adev,
>                                         PCI_BUS_NUM(adev->pdev->devfn),
>                                         PCI_SLOT(adev->pdev->devfn),
>                                         PCI_FUNC(adev->pdev->devfn));
> -       } else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO)
> +       } else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
>                 pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
>                                 PCI_BUS_NUM(adev->pdev->devfn),
>                                 PCI_SLOT(adev->pdev->devfn),
>                                 PCI_FUNC(adev->pdev->devfn));
> +               /*
> +                * HW CTF just occurred. Shutdown to prevent further damage.
> +                */
> +               dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
> +               orderly_poweroff(true);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 5b493f140dda..041aac272a9e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1517,6 +1517,8 @@ static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
>  #define THM_11_0__SRCID__THM_DIG_THERM_L2H             0               /* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
>  #define THM_11_0__SRCID__THM_DIG_THERM_H2L             1               /* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
>
> +#define SMUIO_11_0__SRCID__SMUIO_GPIO19                        83
> +
>  static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                                  struct amdgpu_irq_src *source,
>                                  struct amdgpu_iv_entry *entry)
> @@ -1556,8 +1558,17 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                                 PCI_SLOT(adev->pdev->devfn),
>                                 PCI_FUNC(adev->pdev->devfn));
>                 break;
> -
>                 }
> +       } else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
> +               pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
> +                               PCI_BUS_NUM(adev->pdev->devfn),
> +                               PCI_SLOT(adev->pdev->devfn),
> +                               PCI_FUNC(adev->pdev->devfn));
> +               /*
> +                * HW CTF just occurred. Shutdown to prevent further damage.
> +                */
> +               dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
> +               orderly_poweroff(true);
>         } else if (client_id == SOC15_IH_CLIENTID_MP1) {
>                 if (src_id == 0xfe) {
>                         switch (ctxid) {
> @@ -1610,6 +1621,13 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>         if (ret)
>                 return ret;
>
> +       /* Register CTF(GPIO_19) interrupt */
> +       ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_ROM_SMUIO,
> +                               SMUIO_11_0__SRCID__SMUIO_GPIO19,
> +                               irq_src);
> +       if (ret)
> +               return ret;
> +
>         ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
>                                 0xfe,
>                                 irq_src);
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

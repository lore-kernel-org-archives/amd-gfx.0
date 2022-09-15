Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661A1ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 18:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BCB10EBBA;
	Thu, 15 Sep 2022 18:26:00 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E519A10EBBA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 18:25:55 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-12b542cb1d3so38943853fac.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=7rRpQcvMpAwTlumg5Ts3vvNQdfBOn+qd9nqx7A5U0ro=;
 b=dwgpeO4yj80nb/UWDv38RlEZ13tIQ36+JPKutfbz48RuFs5oB/gvtdG9Bcuk6oRWwB
 VUzkbuh+y24tXLDIo+vST3c0WZhMtFilSB9Z3//krOoJULD8j7vH00HDzjPkhjHK9W6M
 SpbrDqntQ1v3lDy+AP/zEtIjFZvkb497ctqjNKlLfomgdPH3fjZysd3scvNCzttm32Lk
 AMNxKSOBqpANRk79kCVaq546i6mbagR0qtDIvFQhqSMIYgA+2Fpp94PEWO92dI0LZR/U
 c6BCY5BIXA3269Wtyk/lG1/+OwW6qYxExE4oW9wjys1D5ccIW6KEtQKHcm3udQ+hOnY3
 JJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=7rRpQcvMpAwTlumg5Ts3vvNQdfBOn+qd9nqx7A5U0ro=;
 b=z6fbaT1zMYARjXCvSGhZC3mJ9KPy0Fzm8HgXc7TvnKrYcEgZdQdnYLiugJ9Jai3Tz1
 8KYNwIBA5DOYg9uS66MVm/BXStqwa5HVrI/pJwz8lh0PSgqwQHnHy1cAJXFTdtIcFL12
 /h4dCnESphJ3McV2A8xYgDEOd3VDAwsd/4iC1uFRXRUs2xk6oHtzEu3cKwi+0kFSYQOZ
 keE+rW5qBfwLcwdIiiEu0GE1EiJPZC/WBJ2bERUBqPav8Y3gWXXNOMPJFwTTPtgCucCq
 fL0XpYxtyQ+msmyU0NwhJmjtGvqX0wl44sEwOllfgwNOfFBjjQv9ooSmNP1LbVONCdgo
 DApQ==
X-Gm-Message-State: ACrzQf2cVVnAJpNb3jYljjLOjmkbKs0m0R2kbjM49TJ75huVTMkRAdI4
 GKoLuvadkxKajPD+MQhQFuUdJKZgUbfBnrDGxze+ieyG
X-Google-Smtp-Source: AMsMyM6CjUnL31V8Ax/CHez8kBLXiG+p560fJAkD3EFyVFz6/uhmJVujPzvaFX+TnBFzDvtnq3U+o3qHDhqESQSqdkE=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr591874oam.96.1663266355005; Thu, 15 Sep
 2022 11:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220915103435.52137-1-Rui.Ma@amd.com>
In-Reply-To: <20220915103435.52137-1-Rui.Ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Sep 2022 14:25:43 -0400
Message-ID: <CADnq5_PL1wM1uSXX0hn-XC6LsgzSH-zFzcM0+xEO_aHidQUjwA@mail.gmail.com>
Subject: Re: [PATCH] drivers/pci: Decrease VF memory BAR size to Save host
 memory occupied by PTEs:
To: Rui Ma <Rui.Ma@amd.com>
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

On Thu, Sep 15, 2022 at 6:34 AM Rui Ma <Rui.Ma@amd.com> wrote:
>
> The VRAM space is fixed, as the number of VFs increases, the actual BAR
> memory space used by each VF decreases. However, the BAR memory mapping is
> always based on the initial size of the VRAM. So do not map this unneeded
> memory can reduce the amount of PTEs to save host memory.
>
> Signed-off-by: Rui Ma <Rui.Ma@amd.com>
> ---
>  drivers/pci/iov.c    | 11 +++++++++--
>  drivers/pci/pci.h    | 15 +++++++++++++++
>  drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++

Please use scripts/get_maintainer.pl to get the appropriate lists to
send this patch to for review.

Alex

>  3 files changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..d623f46669b6 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -295,6 +295,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>         struct resource *res;
>         struct pci_sriov *iov = dev->sriov;
>         struct pci_bus *bus;
> +    /*
> +     * Some SRIOV device's Bar is too large and occupy too much rmap size.
> +     * Resize the request resource of VF.
> +     */
> +       u16 shift = 1;
>
>         bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>         if (!bus)
> @@ -328,8 +333,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>                 virtfn->resource[i].name = pci_name(virtfn);
>                 virtfn->resource[i].flags = res->flags;
>                 size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> +               shift = 1;
> +               shift = virtfn_get_shift(dev, iov->num_VFs, i);
>                 virtfn->resource[i].start = res->start + size * id;
> -               virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
> +               virtfn->resource[i].end = virtfn->resource[i].start + (size >> (shift - 1)) - 1;
>                 rc = request_resource(res, &virtfn->resource[i]);
>                 BUG_ON(rc);
>         }
> @@ -680,12 +687,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>         msleep(100);
>         pci_cfg_access_unlock(dev);
>
> +       iov->num_VFs = nr_virtfn;
>         rc = sriov_add_vfs(dev, initial);
>         if (rc)
>                 goto err_pcibios;
>
>         kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> -       iov->num_VFs = nr_virtfn;
>
>         return 0;
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..befc67a280eb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -603,6 +603,21 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>  }
>  #endif
>
> +struct virtfn_get_shift_methods {
> +       u16 vendor;
> +       u16 device;
> +       u16 (*get_shift)(struct pci_dev *dev, u16 arg, int arg2);
> +};
> +
> +#ifdef CONFIG_PCI_QUIRKS
> +u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2);
> +#else
> +static inline u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
> +{
> +       return (u16)1;
> +}
> +#endif
> +
>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>  int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>                           struct resource *res);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index da829274fc66..82502c5923e4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4085,6 +4085,44 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>         return -ENOTTY;
>  }
>
> +static u16 divided_by_VF(struct pci_dev *dev, u16 num_VFs, int bar_num)
> +{
> +       u16 shift = 1;
> +
> +       if (bar_num == 0) {
> +               while ((1 << shift) <= num_VFs)
> +                       shift += 1;
> +       }
> +       pci_info(dev, "Bar %d get shift: %d.\n", bar_num, shift);
> +       return shift;
> +}
> +
> +static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
> +       { PCI_VENDOR_ID_ATI, 0x73a1, divided_by_VF},
> +       { 0 }
> +};
> +
> +/*
> + * Get shift num to calculate SRIOV device bar.
> + * Sometimes the bar size for SRIOV device is too large
> + * and we want to calculate the size to define the end
> + * of virtfn.
> + */
> +u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
> +{
> +       const struct virtfn_get_shift_methods *i;
> +
> +       for (i = virtfn_get_shift_methods; i->get_shift; i++) {
> +               if ((i->vendor == dev->vendor ||
> +                    i->vendor == (u16)PCI_ANY_ID) &&
> +                   (i->device == dev->device ||
> +                    i->device == (u16)PCI_ANY_ID))
> +                       return i->get_shift(dev, arg1, arg2);
> +       }
> +
> +       return (u16)1;
> +}
> +
>  static void quirk_dma_func0_alias(struct pci_dev *dev)
>  {
>         if (PCI_FUNC(dev->devfn) != 0)
> --
> 2.25.1
>

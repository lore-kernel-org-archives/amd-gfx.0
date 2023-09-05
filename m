Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633F7C83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 14:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A8C10E547;
	Tue,  5 Sep 2023 14:46:38 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02C310E546
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 14:46:36 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1c4f4d67f5bso1836456fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693925196; x=1694529996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwFNYHYAW//eW1QjsRB/aUFQmJqj+hS7lw8ecCql320=;
 b=IwJ7TrrQ1ROLW+Rxr1ssxV8iGJNUUBrB9l5YpJONUGg0BrsIOpn1D8HU/gZaYxjBQ+
 0vX9VLEuQuz3YmPOJlZsM94qJubuz9dTT93Z/meh0WAU2aJsKmlYQpXbPoYWNU4uHWz5
 dRXa5QVkP1t9KureqIlXYj6sQlpuXXQbCUCzdyMEUDxxj/DQK4xM9tRz/IO9IsGGQ+9C
 Fx+UFgV65gydKMhJAvQAYwMns5zenxe/TOw4zzFZnSjlqbZbD0oKknjN0NG5buhODysw
 AfEAbc4ssQ5/VVA9GZydaKacU5/ZwjHp6XTz4gdlEDkwYQcfq7ETGABPx9VMFm6BdlQ6
 ZPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693925196; x=1694529996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwFNYHYAW//eW1QjsRB/aUFQmJqj+hS7lw8ecCql320=;
 b=YS9pDqQRI1CTb21TqTzoFmbx4csaOhMps+dbiOMEi0/YKUDzSHDTL6nd5VAV54w1e0
 kDrHEMXlzxO8lKkU3LALqwQ8nQLZqZYVwm55/vsjnDrtZhsiYHPW997HWYAVtVEIdoHu
 nIU0V4UByZKWRDEjPzOtxeFA6lDeJw4HAaeGf1snlWoHZLO4li4isOcS6BpIhEcdhxWH
 zNqqbnfHGi/FCubgExEtAFTdorseVW7lfXWvLvJ97MuZjQtixk80tY5ybgtZ9RpT9h6N
 JuvxsMM76lsInLld7x3slAgwGCVRnneFvrX8b4GYtU6P3lrepGWE3hjZAZ3fVxhpu6Ct
 Ym4Q==
X-Gm-Message-State: AOJu0YzALwYnLJfZmWK8dPJ+efID7u2RoU/U7i672bZNGS2Ce4R28Jv2
 Z/19J9kXsf5mhIbYKbkTzI6qO1BTh9al6Kl9k9U=
X-Google-Smtp-Source: AGHT+IE2bFT/tHy0K0uuoa9EuxABjGzmPBDWeHc1WGqx+MFPmhJTFlSk1M4bF8+ast/VK7CpCG7bf1YWUgdYDu6yDqk=
X-Received: by 2002:a05:6870:40d2:b0:1bf:4f42:de91 with SMTP id
 l18-20020a05687040d200b001bf4f42de91mr16646229oal.33.1693925195943; Tue, 05
 Sep 2023 07:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230904060501.2942018-1-Jun.Ma2@amd.com>
In-Reply-To: <20230904060501.2942018-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 10:46:24 -0400
Message-ID: <CADnq5_PbrtHJ436e2kuiu0MrHv_xxiy3DfHqNHqaygej2qaiBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix the flag setting code for interrupt request
To: Ma Jun <Jun.Ma2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 4, 2023 at 2:30=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> [1] Remove the irq flags setting code since pci_alloc_irq_vectors()
> handles these flags.
> [2] Free the msi vectors in case of error.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 43 ++++++++++++++-----------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index fa6d0adcec20..17043a1e37a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -271,28 +271,28 @@ static void amdgpu_restore_msix(struct amdgpu_devic=
e *adev)
>  int amdgpu_irq_init(struct amdgpu_device *adev)
>  {
>         int r =3D 0;
> -       unsigned int irq;
> +       unsigned int irq, flags;
>
>         spin_lock_init(&adev->irq.lock);
>
>         /* Enable MSI if not disabled by module parameter */
>         adev->irq.msi_enabled =3D false;
>
> +       if (amdgpu_msi_ok(adev))
> +               flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;
> +       else
> +               flags =3D PCI_IRQ_LEGACY;

I think this logic could be something like:

if (!amdgpu_msi_ok(adev))
              flags =3D PCI_IRQ_LEGACY;
else
              flags =3D PCI_IRQ_ALL_TYPES

Other than that, looks fine to me.

Alex


> +
> +       /* we only need one vector */
> +       r =3D pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> +       if (r < 0) {
> +               dev_err(adev->dev, "Failed to alloc msi vectors\n");
> +               return r;
> +       }
> +
>         if (amdgpu_msi_ok(adev)) {
> -               int nvec =3D pci_msix_vec_count(adev->pdev);
> -               unsigned int flags;
> -
> -               if (nvec <=3D 0)
> -                       flags =3D PCI_IRQ_MSI;
> -               else
> -                       flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -
> -               /* we only need one vector */
> -               nvec =3D pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> -               if (nvec > 0) {
> -                       adev->irq.msi_enabled =3D true;
> -                       dev_dbg(adev->dev, "using MSI/MSI-X.\n");
> -               }
> +               adev->irq.msi_enabled =3D true;
> +               dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>         }
>
>         INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
> @@ -302,22 +302,29 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>         /* Use vector 0 for MSI-X. */
>         r =3D pci_irq_vector(adev->pdev, 0);
>         if (r < 0)
> -               return r;
> +               goto free_vectors;
>         irq =3D r;
>
>         /* PCI devices require shared interrupts. */
>         r =3D request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_d=
rm(adev)->driver->name,
>                         adev_to_drm(adev));
>         if (r)
> -               return r;
> +               goto free_vectors;
> +
>         adev->irq.installed =3D true;
>         adev->irq.irq =3D irq;
>         adev_to_drm(adev)->max_vblank_count =3D 0x00ffffff;
>
>         DRM_DEBUG("amdgpu: irq initialized.\n");
>         return 0;
> -}
>
> +free_vectors:
> +       if (adev->irq.msi_enabled)
> +               pci_free_irq_vectors(adev->pdev);
> +
> +       adev->irq.msi_enabled =3D false;
> +       return r;
> +}
>
>  void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>  {
> --
> 2.34.1
>

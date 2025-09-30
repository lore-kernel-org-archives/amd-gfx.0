Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE00CAC5B8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 07:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57DE10E517;
	Tue, 30 Sep 2025 07:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E63yJeQW";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCFF10E514
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 07:46:30 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-269640c2d4bso12565725ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759218390; x=1759823190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOtQ+X8ITOwteD6X4bB/ZJO0Empepaz5DLOY3rhwnuM=;
 b=E63yJeQW6DjukAYXR7xhV/ENc3R9y4UNK6RUrbG4TdLfi2gYbSADuUgOBKHK9j5FZ6
 /cMGKEMf7zNPNuO86a31usNe14vcjrvoIOas78Pt4nkPs+J2uS33cLCchJKPSj0zJWnb
 SbaLDDWurkO+QNLyo8jMzB10BzifINGM1F9ypsUrGQ5R0rg+Tij2cYwaygacVxUmJGzO
 M+jvSMurhqLy0WGmxWMMW9V4zz5rcEeHWcoahnt5i9WhYUSfJN4Zu4Gnpef7rI1zsgZE
 wkHH1mV5MLiRAzrhcCAlCeP/vKn7cq52TwB6PgNhNiNomzadOI8bZEjjQ1vL/BLx/8m6
 vA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759218390; x=1759823190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOtQ+X8ITOwteD6X4bB/ZJO0Empepaz5DLOY3rhwnuM=;
 b=A81UYuz6HseyrjMafSVj4RanE6cHIu3u9gSGj10bhotH0rDtAo79dpEsvScfZ5FszZ
 bqgmPlz9GvrfhopKbDdxsZoBQJEdzpmYPlidYt765enbvLNQZ3nacB1v29VXYYYj30nj
 Hzl69fSp9E4LIibAJqISkLYYOlRBYGzs+0HjjmurNTR13R5FG4P79Pfm/hqlMOeSuO7f
 a7vkwyKtS9agrnxwzITGS68UwGmszWM5O2kXim2iBFTwaPM2sK3T7SbjEXBDqTS3wx3M
 /tydzn6xVzI85xooc1FP+wumWMh3zwD1bN5bLXprfpd8qYVnE2H83UzZTjUSk723MOg2
 VdNg==
X-Gm-Message-State: AOJu0YxbpmlCYy88lsTKDVE591FgyaZlMCbKi/7Lfo+Tq950IZ1Y3YwO
 hHLW1xpOaDdWXtJZUDrO/lnab//kDU5IhwhhkAQgmbzaKAvT7ozrcSZwqO/PkIkkhEUBsBoLx1e
 dScftB+l+4sjCB1pwNvDo0UUEfbnhYWk=
X-Gm-Gg: ASbGnctRRLSyC+ix95hyQkD/XnF1ZSGD1RyHiVY4hc1/fanAs/UDxcaUTY5xeAYd5yn
 njZ7E0lVQuEO31K0g0c1viUg1BdCHAUQRFDLaLkSa7JxB8qo5u7z65eiZvw7KKUEFVAfEh4xxIg
 DSFoxYy2l3scQjA29WK19lqTQDMDIi3XP+TSn7dG4PRKnIAzk14nYkR9X2BMXozCKtUMYCtn39Z
 Y9sUBAy6MSEgNNpBFUpo02azZ2SPwBqTdza9Gl1
X-Google-Smtp-Source: AGHT+IHeiZefP/A20zjlisjoodluKaHkdg3qY13zt9Wn3HseaXZdkqSS4uYCZOfM1/i8euvsxmTLMnY+OBZQ0J81oP0=
X-Received: by 2002:a17:902:f551:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-27ed4a36409mr131504055ad.6.1759218390211; Tue, 30 Sep 2025
 00:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250930063632.3270909-1-lijo.lazar@amd.com>
In-Reply-To: <20250930063632.3270909-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Sep 2025 03:46:17 -0400
X-Gm-Features: AS18NWA_b5y0JGeCfNdvM-OTeiNlj6IumepPAuOUovniDLf4tEY0GSldZw-hjx8
Message-ID: <CADnq5_MH=6tzOQQudeAJ1hh8Kk5asfK9bGYBQyGQ4UGjbOLf6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check swus/ds for switch state save
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Roman Elshin <roman.elshin@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 30, 2025 at 3:01=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> For saving switch state, check if the GPU is having SWUS/DS
> architecture. Otherwise, skip saving.
>
> Reported-by: Roman Elshin <roman.elshin@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4602
> Fixes: 1dd2fa0e00f1 ("drm/amdgpu: Save and restore switch state")
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 ++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 58287a006b87..562c5d7b8cfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -7171,28 +7171,35 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>
>  static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
>  {
> -       struct pci_dev *parent =3D pci_upstream_bridge(adev->pdev);
> +       struct pci_dev *swus, *swds;
>         int r;
>
> -       if (!parent || parent->vendor !=3D PCI_VENDOR_ID_ATI)
> +       swds =3D pci_upstream_bridge(adev->pdev);
> +       if (!swds || swds->vendor !=3D PCI_VENDOR_ID_ATI ||
> +           pci_pcie_type(swds) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> +               return;
> +       swus =3D pci_upstream_bridge(swds);
> +       if (!swus ||
> +           (swus->vendor !=3D PCI_VENDOR_ID_ATI &&
> +            swus->vendor !=3D PCI_VENDOR_ID_AMD) ||
> +           pci_pcie_type(swus) !=3D PCI_EXP_TYPE_UPSTREAM)
>                 return;
>
>         /* If already saved, return */
>         if (adev->pcie_reset_ctx.swus)
>                 return;
>         /* Upstream bridge is ATI, assume it's SWUS/DS architecture */
> -       r =3D pci_save_state(parent);
> +       r =3D pci_save_state(swds);
>         if (r)
>                 return;
> -       adev->pcie_reset_ctx.swds_pcistate =3D pci_store_saved_state(pare=
nt);
> +       adev->pcie_reset_ctx.swds_pcistate =3D pci_store_saved_state(swds=
);
>
> -       parent =3D pci_upstream_bridge(parent);
> -       r =3D pci_save_state(parent);
> +       r =3D pci_save_state(swus);
>         if (r)
>                 return;
> -       adev->pcie_reset_ctx.swus_pcistate =3D pci_store_saved_state(pare=
nt);
> +       adev->pcie_reset_ctx.swus_pcistate =3D pci_store_saved_state(swus=
);
>
> -       adev->pcie_reset_ctx.swus =3D parent;
> +       adev->pcie_reset_ctx.swus =3D swus;
>  }
>
>  static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)
> --
> 2.49.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C34E7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 21:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA2510EC2A;
	Wed, 11 Dec 2024 21:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrSJOzKL";
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0E210EC2A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 21:41:46 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ef718cb473so878042a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 13:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733953306; x=1734558106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0UZfHxFdTn7eo6hrfzPl/XiCUIyeoukyt6TCdQe+AY=;
 b=FrSJOzKLMaGcWp5NxjXbHAqrq1wk58KvLVzLb6JuxjanS4SV7j2bWsom5hVwcUF5GF
 HARv9K8DUlqDtZKT+K1TmGBVk2Sok7TH69n8me1+n7XR0u6lCsrZglApzecWTA3FQnIr
 dGJWHCxZGzO3dI+i+Eivm56srtLgh+/217fVZXauskUvjWa0Y22yAKu59zSjpHavplIE
 LnQGCtjL5fKQ0crvER2lNUnV5ycflx5CQ+J2FDFenwxr9ipGU+4PgoQlSY4CY6EzqgfK
 TPH8EptPOdWTMFTEiFOf2BEZerzK4tOxIErMITwCqup/q6qxA0kUGiw5PIzmrk90Lj13
 R+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733953306; x=1734558106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0UZfHxFdTn7eo6hrfzPl/XiCUIyeoukyt6TCdQe+AY=;
 b=qTwuUB/K7khKHvBHqUhOSAyRoexEwZ+oUE3ijgkySMVIcBIW+SQUPrwPnNSJKc+dGE
 V9bYdM7PLzo/JPk0uW+s44mC0AcoDz3LWcZJR9sIu+/oLYmr12XqZ3R51Uye38KeYrY7
 y1M5zxvYNXvj3yMo74qBdEyBxfA7t9K2wixnTwcHr0x7A0CatUgH2nsbh/JgbcqOFQ8F
 SeuVWGBbPke2vnjnb9CuXlV6dwUQ1xReBkRY5uXFCUap9BskR3yBD1ZTwEzdd52PfDhG
 hXIv5h/oGSdQozNr9YzP/y1oS76LjP17e2X3qOGY0QkBHrNn9rPH7IDNr7u6RVtaktif
 EnCw==
X-Gm-Message-State: AOJu0YxQlWP7qjmTLSxuTp3uScCSxP4S3v60rjibD74ZDZaN2iv//ihe
 7pPy1LjnS3OFo2n23Y5uFJxDBpo63NanZps/yKNkaDW19d5+WNmnUBx5Mqwzk6QWiBk+zRS1BlM
 gauIt7i08vXFZFzpfbZx5okqsC4A=
X-Gm-Gg: ASbGncuphpiwEylj6BOCa9nKN9366lHpheolvb+B1PmTqnLMJDAEJE7sMBwlp6ewLNC
 krrajhfyT/KOmXqDcFfonVpJBHewN1FeW3k8=
X-Google-Smtp-Source: AGHT+IEnYn00huFB2DtPcZQiPcWC7TPCdm4yGh71irL972iNjFQDNvzmPxwrgDFRsMfhs452uTYjYWdK5kEjAA/hbZU=
X-Received: by 2002:a17:90b:1b0b:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2f127f7e145mr2662266a91.1.1733953305973; Wed, 11 Dec 2024
 13:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20241211155601.3585256-1-superm1@kernel.org>
 <CADnq5_PxZP4fgMcuD0xD3m2Y3_kbOV_wK4Qq4GzGHJB_9wxepQ@mail.gmail.com>
 <820bc463-80d7-4121-837d-b620bfa67575@kernel.org>
In-Reply-To: <820bc463-80d7-4121-837d-b620bfa67575@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2024 16:41:33 -0500
Message-ID: <CADnq5_ORSYTV1yLXhmWvaxwi_F9QfOWMzjzFHFrNvF5DCjZ_xQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Require CONFIG_HOTPLUG_PCI_PCIE for BOCO
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Gabriel Marcano <gabemarcano@yahoo.com>
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

On Wed, Dec 11, 2024 at 3:19=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 12/11/2024 14:08, Alex Deucher wrote:
> > On Wed, Dec 11, 2024 at 10:56=E2=80=AFAM Mario Limonciello <superm1@ker=
nel.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> If the kernel hasn't been compiled with PCIe hotplug support this
> >> can lead to problems with dGPUs that use BOCO because they effectively
> >> drop off the bus.
> >>
> >> To prevent issues, disable BOCO support when compiled without PCIe hot=
plug.
> >>
> >> Reported-by: Gabriel Marcano <gabemarcano@yahoo.com>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707#note_2696=
862
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Thx.
>
> >
> > Seems like this should affect any device which supports d3cold.  Maybe
> > we want something more general as well?
>
> Any specific ideas?  One of these two hunks I think make sense, leaning
> upon the second one more strongly.

Actually, I wonder if the affected hardware pre-dates d3cold and uses
the old proprietary AMD ATPX interface to control dGPU power.  In that
case, the d3cold is managed by the driver rather than the PCI/ACPI
subsystems.  IIRC, there was a workaround in the PCIe hotplug code to
avoid calling the pci remove function when the driver powered down the
GPU via ATPX (or the nvidia equivalent).  If so, this check should go
in amdgpu_device_supports_px() instead.

Alex

>
>
>
>                                    diff --git a/drivers/pci/pci.c
> b/drivers/pci/pci.c
> index 0b29ec6e8e5e2..01691f1d26fbe 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2751,6 +2751,10 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>          if (target_state =3D=3D PCI_POWER_ERROR)
>                  return -EIO;
>
> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
> +           target_state =3D=3D PCI_D3cold)
> +               return -EBUSY;
> +
>          pci_enable_wake(dev, target_state, wakeup);
>
>          error =3D pci_set_power_state(dev, target_state);
> @@ -2797,6 +2801,10 @@ int pci_finish_runtime_suspend(struct pci_dev *dev=
)
>          if (target_state =3D=3D PCI_POWER_ERROR)
>                  return -EIO;
>
> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
> +            target_state =3D=3D PCI_D3cold)
> +               return -EBUSY;
> +
>          __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>
>          error =3D pci_set_power_state(dev, target_state);
> >
> > Alex
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 764d41434a82f..7db796ebb967e 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -419,6 +419,9 @@ bool amdgpu_device_supports_boco(struct drm_device=
 *dev)
> >>   {
> >>          struct amdgpu_device *adev =3D drm_to_adev(dev);
> >>
> >> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> >> +               return false;
> >> +
> >>          if (adev->has_pr3 ||
> >>              ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
> >>                  return true;
> >> --
> >> 2.43.0
> >>
>

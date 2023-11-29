Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB503C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 16:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1154110E635;
	Wed, 29 Nov 2023 16:40:11 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361F610E635
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 16:40:09 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1f9efd5303cso3668658fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701276008; x=1701880808; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I382rna1+1uS+Ptb3Y/5lNnT4CJc0WJUl1kLoKOBDaY=;
 b=VrhVHv3M3eUplKUvIRg0kvc2nhfKWr+XR+sOpcegDhwuwQY3HSIg5qIzjmxq8Borsg
 MswjrceiqOkvwOY+rDFDwJUR8eh/Mc8XjZGs5vk8yFq0A4aj46odqzHHVBLboMNYyvnZ
 PD7itcoGgK9dvfDqgz9JYbUUoaxDdWJ8uAjDQEMJcvyt2ROkt0WP8PK0kLOPOv+jxJ7n
 PmC/zE1IEH1nSshzvz1rrgywfLtJRX9RlDENa4yEyabBPFRFvCCqEfwtso7nk25QDk2Y
 oGoxF7DYyiuJPg0fD1OboJWBAffeSgXQRciLa06pfzthK6ZCYMvPwr2E1tfO+KY5xN13
 pvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701276008; x=1701880808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I382rna1+1uS+Ptb3Y/5lNnT4CJc0WJUl1kLoKOBDaY=;
 b=NaH4kattPuBKNXAoMhhG67/cF4yCx/EwSWjF9SHDj7xGVQlqMH16mqAPw6obG8wK46
 JSauiMwAxymtdu+RJP7bdK5LiWd9Eq53RUBUQYivFTs88YRgKJ8X3f5ExvMcOlDDty7m
 5NOxPSPVcSFy/EKILry5f25Rh3ZdPY4rhBK/3WtctOAfz+Opds9Ja8rhcMKa9A/I++21
 VrOBuc5yDDGpS6QoEZFTkZSFhE6fbDjIDWseX/ewwd9lWGzuTMc/1tHOZJ26OolN0OH6
 OMFXnM0uKvh7yJgs/u8UvYD1+brFJJXuLdn9cghpNrcezwEpwx732qQSbfF6JOb4bYCJ
 SXuw==
X-Gm-Message-State: AOJu0YyAV4tLAMXFGpDs8bT5LGKlc3410ivYTHvGDQoXkoFHyhm30xkN
 pDRkbjtWj4G3IsZnDxFG7LP4275jQ/HkDF70ppI=
X-Google-Smtp-Source: AGHT+IFsqZEpIvYlgv7hWJ130NDhl6l/6lNQuvqe62Tn5pHRRa+HnjmmFly5uMTBNKj++CPjnWKuTlOgQ8TRhSzf6XM=
X-Received: by 2002:a05:6870:213:b0:1f4:b1d6:573f with SMTP id
 j19-20020a056870021300b001f4b1d6573fmr23005243oad.13.1701276008375; Wed, 29
 Nov 2023 08:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
In-Reply-To: <20231129085156.30698-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Nov 2023 11:39:57 -0500
Message-ID: <CADnq5_NX1hfyq34+HkVirXxS28j69-hFdH-q9jwnfDwmdcBsLA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 29, 2023 at 11:37=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Some platforms can't resume from d3cold state, So add a
> new module parameter to disable d3cold state for debugging
> purpose or workaround.

Doesn't the runpm parameter already handle this?  If you set runpm=3D0,
that should disable d3cold.

Alex

>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a9f54df9d33e..db9f60790267 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_=
PARAM_LENGTH];
>  extern int amdgpu_dpm;
>  extern int amdgpu_fw_load_type;
>  extern int amdgpu_aspm;
> +extern int amdgpu_d3cold;
>  extern int amdgpu_runtime_pm;
>  extern uint amdgpu_ip_block_mask;
>  extern int amdgpu_bapm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 22b6a910b7f2..90501c44e7d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *de=
v)
>  bool amdgpu_device_supports_boco(struct drm_device *dev)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> +       struct pci_dev *parent;
> +
> +       if (!amdgpu_d3cold) {
> +               parent =3D pcie_find_root_port(adev->pdev);
> +               pci_d3cold_disable(parent);
> +               return false;
> +       }
>
>         if (adev->has_pr3 ||
>             ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 5f14f04cb553..c9fbb8bd4169 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_L=
ENGTH];
>  int amdgpu_dpm =3D -1;
>  int amdgpu_fw_load_type =3D -1;
>  int amdgpu_aspm =3D -1;
> +int amdgpu_d3cold =3D -1;
>  int amdgpu_runtime_pm =3D -1;
>  uint amdgpu_ip_block_mask =3D 0xffffffff;
>  int amdgpu_bapm =3D -1;
> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type=
, int, 0444);
>  MODULE_PARM_DESC(aspm, "ASPM support (1 =3D enable, 0 =3D disable, -1 =
=3D auto)");
>  module_param_named(aspm, amdgpu_aspm, int, 0444);
>
> +/**
> + * DOC: d3cold (int)
> + * To disable d3cold (1 =3D enable, 0 =3D disable). The default is -1 (a=
uto, enabled).
> + */
> +MODULE_PARM_DESC(d3cold, "d3cold support (1 =3D enable, 0 =3D disable, -=
1 =3D auto)");
> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
> +
>  /**
>   * DOC: runpm (int)
>   * Override for runtime power management control for dGPUs. The amdgpu d=
river can dynamically power down
> --
> 2.34.1
>

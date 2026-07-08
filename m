Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC95C43602
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B4510E5EE;
	Wed,  8 Jul 2026 13:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWECkuOn";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1609C10E5EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 13:30:31 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2caa0551d8bso2570145ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 06:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783517430; cv=none;
 d=google.com; s=arc-20260327;
 b=SXcASIVu0bOjnqxeaXoSeJ8zAeufMaoTobFJNIuTurVCUIh6N4D5Kbtt0VEHW5O8rQ
 G0FV4j54DGGzHg5GaW7VHnoKSByFQUWUhtZZanfZxj0wNehUgcGLdKUk3YleihJaMmbJ
 mzjrtTLIPXfdlw80JVgm4+h/YZgcMXTMN/TXI975nMKBZjTun+TgZMgca3UFQJ/BjWHT
 Pl5+KALBbqkOLDo4/pvpausD5rMSLSKlWZM2lHTQP5xxem07KgY6v9uJUqI8S8IKC8we
 ReCCP39GK7DJ6oNnI/JZAJSJcfPx9fgL29GEkoOLpyaQFGXTxmDGa6Fx76PhHt6pkEI4
 23TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BSwavkeH+LcVYKCLrB4zma0uyvhD0qqFx3FCZkmYrVw=;
 fh=qWGDbas/IhvIUbgk75S8XrizEO2xTmjjiVSS6c9mV1Q=;
 b=BmjgA5ONMiZYKZyvrjFHldISq2klKRqU+lTQVHhJfhdM8WIwaerUfkytTrllrVovmd
 o8zLfayGqiOCOYgwdhzIEHpGIjuA8V1c47GCa9BZDQtt6HFUXZdXkD3G4Du7hkrB2kAI
 5W3itxG9Z4TpOktE7H8uDY1jZlPAvURYDauWyv1xcdVzy81EZE8VoWlLXul8AjSMxbTV
 PwS26ACCXR0Vm9PTLxhkofF2ecvgjixmrDA5VxcoASlq5A3wAb9LyPuTdULFPAeesnPl
 +3ti25KY0xeyBY6y+/6QgKemruF8bEaaQpOu3XNIekUufxLCO0M5fSHXyUEKYe7ZtBZ6
 mSyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783517430; x=1784122230; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BSwavkeH+LcVYKCLrB4zma0uyvhD0qqFx3FCZkmYrVw=;
 b=iWECkuOnq/Rsse0t/NCtb8O+BS/a2oFDfYoU9ELJjz5iSL13uqixtvb2aVsq96ne/m
 xSUY0tTqSIDc7pqNoI4sURsj92bb+Hv4zCJq/D8qTw+lv3iyRdkP0N+cBbGBx6xl/meV
 0kohFrKYxfPkt7v4mFV9SMzELfppFEEpXs7PIi2TZ6AXDzheUMq21gyiUch2eCCpiUVk
 32LyCAoXDRgOQ2RBeuGW7Xvnw5j/FsaumtTKjl0JFFt7FWoh6AC1sq9nyUtScR19fSMZ
 uzL+rc3HHFCgB1jWS4Pm6nrYOqeuS5BtkdDfNaGVPzIAXALO6g5gla4Fh/00cd5uxbBk
 0aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783517430; x=1784122230;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BSwavkeH+LcVYKCLrB4zma0uyvhD0qqFx3FCZkmYrVw=;
 b=bCKnlV+3gEMbMy5c69euVRZoZZ0KAF4tFRavCroF989GKAOzkbpQv4wA7KIIZ17YZZ
 gSXRiH5lJkxJxeUwzRN9UTfTKJWEDTTmPgFw9C8cl/eg17hiGIdVZSgmfcXr0wCkDaZe
 /p8jLQ41N8y4LFLGqcAOFbTw/5wb/f0JnwyxPJyKB+R+RQnj+i32jNqIKEBIbJbhRfSW
 SKeS8vAIbJvQNcmvo+OmMUCjUP9iCdqvde9wIx9DcL+BfSfsZPXuJwQkyAiobWcyR2qx
 /IKUCpVgM9hPccjV+wgitr/YP3eMyJlDd0mL9EiAmsiePCBrf8Uytl24PFN/hO2cTGi4
 O7ow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpf1pAx8H4YVF3uEkqSkGh6N9XE7KmjQI/Sly27ugpJPAboHTleThRCdzocMTMYOf9MgztogOCt@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4CrWS1Lf4Hna7dX5epIZEMNl1ADi2wA7nHhLc+sKUSMCvUoLg
 yaNRsJuf02vw3HOFX/K+sOcxHwxDZMdnAf6fYiBeQjIazy4r0hUFuWAWfI6w9HjcCk2AuX+FKD9
 p/KgZ6vjRqicZnil2081AoZ4rm9W3viA=
X-Gm-Gg: AfdE7clSoccJlcYCdg8a3CCWmYf6U5vEEVR3kBBxWj6FSOkPoYakwDaZtgwTsXIbDwD
 lKsv+261xDvjpJHShfVcXNdNi3lUXikyB1chauxF9MVTI2TiGrBYOJH4x+S70XXmB42wX5OPIq6
 0hBfM/3U33PtWfgSUDmoJD3GHJg8TT/ctoFysavOnpBAUsB4TmAwP2EU4j5PEwFehDZw9J53acm
 sNAwdfpZiV+B2ENS1B0UzzC0ByDkm+V2T4iLGE68cQ1sCP1VO3McorBpGjFOc+RU7C5V9WFGoas
 Bqw0TqGSOE6hg5k4hD/p3NDb0Xg954H97vq1LGGmh8UERz0ISyxzaDi6zOfzUW5z8d7O+Q==
X-Received: by 2002:a17:903:b85:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2ccea357aa2mr22247225ad.3.1783517430158; Wed, 08 Jul 2026
 06:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260628161719.1598835-1-geoffrey.mcrae@amd.com>
 <20260628163239.1599449-1-geoffrey.mcrae@amd.com>
In-Reply-To: <20260628163239.1599449-1-geoffrey.mcrae@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 09:30:18 -0400
X-Gm-Features: AVVi8Cd9ViZy-1GAajz3vKTBRa5Z47lkuD12EbzKdbMmNQx0jn-1EvfXHb9Gqc4
Message-ID: <CADnq5_NviF+5uO_HQ_H+BTY+M1WNZcf5fynYxNXE_vsDMg0_eQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix DM I2C teardown race
To: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Sun, Jun 28, 2026 at 12:39=E2=80=AFPM Geoffrey McRae <geoffrey.mcrae@amd=
.com> wrote:
>
> DM I2C adapters can remain visible to userspace while DM teardown is
> already in progress. A concurrent i2c-dev transfer may then enter
> amdgpu_dm_i2c_xfer() after the backing DM state has been torn down,
> leading to a NULL pointer dereference.
>
> Create a devres group around the DM I2C adapter lifetime and release it
> at the start of dm_hw_fini(), before HPD, IRQ, and DM state are torn
> down. This removes the I2C adapters first and waits for in-flight users
> to drain before the structures used by amdgpu_dm_i2c_xfer() disappear.
>
> This fixes a teardown ordering race seen during device removal:
>
> BUG: kernel NULL pointer dereference
> RIP: amdgpu_dm_i2c_xfer+0x122/0x1c0 [amdgpu]
> Call Trace:
> __i2c_transfer
> i2c_transfer
> i2cdev_ioctl_rdwr
>
> Fixes: 5b3eca05cfb0 ("drm/amd/display: Use devm_i2c_add_adapter to simpli=
fy i2c cleanup logic")
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++++++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b97ceabe6173..5613dc9903fe 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1496,17 +1496,26 @@ static int dm_hw_init(struct amdgpu_ip_block *ip_=
block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int r;
>
> +       adev->dm.i2c_devres_group =3D devres_open_group(adev->dev, NULL, =
GFP_KERNEL);
> +       if (!adev->dm.i2c_devres_group)
> +               return -ENOMEM;
> +
>         /* Create DAL display manager */
>         r =3D amdgpu_dm_init(adev);
>         if (r)
> -               return r;
> +               goto err_release_i2c;
>         amdgpu_dm_hpd_init(adev);
>
>         r =3D dm_oem_i2c_hw_init(adev);
>         if (r)
>                 drm_info(adev_to_drm(adev), "Failed to add OEM i2c bus\n"=
);
>
> +       devres_close_group(adev->dev, adev->dm.i2c_devres_group);
>         return 0;
> +
> +err_release_i2c:
> +       devres_release_group(adev->dev, adev->dm.i2c_devres_group);
> +       return r;
>  }
>
>  /**
> @@ -1521,6 +1530,9 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_bl=
ock)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> +       if (adev->dm.i2c_devres_group)
> +               devres_release_group(adev->dev, adev->dm.i2c_devres_group=
);
> +
>         amdgpu_dm_hpd_fini(adev);
>
>         amdgpu_dm_irq_fini(adev);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 909ee71d6d59..13a18e1ed576 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -688,6 +688,13 @@ struct amdgpu_display_manager {
>          */
>         void *bb_from_dmub;
>
> +       /**
> +        * @i2c_devres_group:
> +        *
> +        * Devres group for DM i2c adapter lifetime management.
> +        */
> +       void *i2c_devres_group;
> +
>         /**
>          * @oem_i2c:
>          *
> --
> 2.43.0
>

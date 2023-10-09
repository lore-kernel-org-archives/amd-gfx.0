Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DFEE95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5613110E126;
	Mon,  9 Oct 2023 14:35:03 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EE010E280
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:35:00 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c7c2c428c1so1851833a34.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696862100; x=1697466900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rOpY0rmLx7TJUwpFt4Z2K/C9US0Kmol4Yljf93d9Fg=;
 b=hXIfaMsMQQqhSmfP504gQgv4NacYSGnXS06hp2nXbi3j4XehZulMvlcw4IcrtuqEN/
 SaSi27E0rN5X0hjiHGCLuzE0qJOAlx6f+h1J+6iJ3rWmuCug/WDa4GLEM/Z739wvlZTE
 YhFocWJM433yPCA3LDI+rNuvkSLLcC/bhe5yz3LZqZh1M2f0Tdj4nLcuQzAE1w+nMNAX
 rUXLrjEhoRuN53Pz9FQ0GV/A5mPZ8lkKRdwzsSdaR16fyylqQFGZkd+mbs+5wIM3zJzr
 bjBL0s2qNwHWACDaNkXbpJzasMZ9n8ShoUIY8cS47I5AzmuodMKmgICyvFR/usiK1yd4
 FA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862100; x=1697466900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rOpY0rmLx7TJUwpFt4Z2K/C9US0Kmol4Yljf93d9Fg=;
 b=HU5AmRV5He1gBTUCfN897Lqa9ueI2qpjAfSMDBKPSAS6W7fcwx7mKXk3PBzw7GkUJE
 IdJkNNj0nC/Zem1aiHybMoxfUQssOLa2+kh5HZ/sNjU7IGMceT22zCYfiUYAljhhE+tV
 5hEXARismxbcZnEG7QkDoHES12Go3cwBtqxlkFEr28OTCKzB73VYViUlrl2qhWMFfAxA
 eYWpcCBL1CDXrxZl0rFeeIhv+xKQMn3blw+LOMSN5RF/EcuD4wBIT2aRceq+mvnuFCJ+
 rEe+pXSn3E1RK1dYEbkbZIg1v74JMEvNoqgufe95VqQ+2DJf7xRp7yAlvYXbadiY/ZXD
 fnQQ==
X-Gm-Message-State: AOJu0YytQzCcvthcFhvi7dMe1a5+WlRZvTiP8gNQezk3/GdjNPtRVNkk
 WCRRZrUSXKcroUHQM8SHOA4PSgFvlSBCkg7+i9EDC/dc
X-Google-Smtp-Source: AGHT+IGo+XyJ7fuGMDy365exIwljO7qyetjOzJ6Q2UqD1U+CRBWJSIc3UjSBYmvmo6TVcBVXXnWotTQlyfR695LqeXg=
X-Received: by 2002:a05:6870:fba9:b0:1dd:7079:fd1f with SMTP id
 kv41-20020a056870fba900b001dd7079fd1fmr7047850oab.18.1696862099608; Mon, 09
 Oct 2023 07:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-3-mario.limonciello@amd.com>
In-Reply-To: <20231006185026.5536-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 10:34:48 -0400
Message-ID: <CADnq5_PqjBoet490Eo+aqS_1j8s+OdvP_Qcf+U-GhNO1zMdMLA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] drm/amd: Add concept of running prepare() sequence
 for IP blocks
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 6, 2023 at 2:51=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If any IP blocks allocate memory during their sw_fini() sequence
> this can cause the suspend to fail under memory pressure.  Introduce
> a new phase that IP blocks can use to allocate memory before suspend
> starts so that it can potentially be evicted into swap instead.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * New patch
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
>  drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index cb334dc57c59..a362152cd0da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4348,7 +4348,7 @@ static int amdgpu_device_evict_resources(struct amd=
gpu_device *adev)
>  int amdgpu_device_prepare(struct drm_device *dev)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> -       int r;
> +       int i, r;
>
>         if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>                 return 0;
> @@ -4358,6 +4358,16 @@ int amdgpu_device_prepare(struct drm_device *dev)
>         if (r)
>                 return r;
>
> +       for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +               if (!adev->ip_blocks[i].status.valid)
> +                       continue;
> +               if (!adev->ip_blocks[i].version->funcs->prepare)
> +                       continue;
> +               r =3D adev->ip_blocks[i].version->funcs->prepare((void *)=
adev);
> +               if (r)
> +                       return r;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/a=
md/include/amd_shared.h
> index ce75351204bb..1f831cb747e0 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -299,6 +299,7 @@ struct amd_ip_funcs {
>         int (*hw_init)(void *handle);
>         int (*hw_fini)(void *handle);
>         void (*late_fini)(void *handle);
> +       int (*prepare)(void *prepare);

Prepare is a little vague.  How about prepare_suspend()?  Also *handle
for consistency.  Could possibly use this for DC as well if we end up
needing to allocate DML structures.

Alex

>         int (*suspend)(void *handle);
>         int (*resume)(void *handle);
>         bool (*is_idle)(void *handle);
> --
> 2.34.1
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93797CD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 13:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160F410E764;
	Tue, 16 Jun 2026 13:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyfOQyY6";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC4010E764
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 13:43:03 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30bc5fa5a2aso8666eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 06:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781617383; cv=none;
 d=google.com; s=arc-20240605;
 b=UdLY0JYKclzBgYReugnbkZG5ulEfO2eXFhzmuAqojFshiO/u3wI7AhGk4/nHlHwYhg
 3RdkMKY61UE/5VdpSmAI6ra9rth4lgeW1/nntF8r8Q2lMLb05MiwSU/no3dCgt0BsQKr
 Ax5cZitIj+wjxYMml3tHIgeAXwmHDmz6/SEcE6X2y8HAVAzDRHENw2PNHcwAcC40RnXo
 QdRK8EtBKUL+mEZ2VFFF5xKdBFA87QqNFC34Q8XpuT2fl5F0SahO6eHIrS+LMgqJuFum
 50h0/XzY06ixC7+jIlmKUJOUkk/3IPcD7ITKa4CRxR/vSKlS4YEoAykqpYb49fI+CAf+
 Mskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W+TMpqhNDrpSCOhtOJFDgnIMfyVz3H0yI9bEvZGS9fw=;
 fh=yHxlWXEhn0nj8ExjjCZ00lp6iGF4IYVz6T7vzOX3+Hg=;
 b=b1epcFnJi1WZ0nsEFXepOd1zkv/by3LG76XvLN3HOVQQSw4o+gGvLX0gWzaCg+Fa/d
 C3+OzhqRqe8f32WkxaNFIH1E5iIG6UCug8yEEzu5FzCMkkZe3UthYwSKztcerMCM4M29
 pKO5vMGzbMyiU6LRLUuyyIqIX8C+gWyFIf1MeQE8kV5zSwVju+GfhxB3DQ+urylw3GML
 Cg8HgEalt9NpUJA+CEdGA1yrXH4xZSwd9x7c+WvlfxjELpgNA9uinX1e6u1+MzOe89oY
 t57FhkvHR7MRcrgwswWs82B14hmHs5nZOLpH+shxwvTJwgIjxivvDxcB7wEve5R6ABrY
 X3dQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781617383; x=1782222183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+TMpqhNDrpSCOhtOJFDgnIMfyVz3H0yI9bEvZGS9fw=;
 b=CyfOQyY6W9rBsXIoDjINZ5SR5q3f/Ov/oYY7obyM2Vo9k2q2WaGsdD0IiCy57Rupyb
 l//5dZkp9aDFopMfYOxpn57CMjyNMLNl3PJXJ+QbhkNKSLvo0VnHIRUY6rlj6WGlTpO8
 kpUdyFMdAy8NWy1HKcaL/PprIK+3r/oaaRT7V69pQQa3/jLnUSctGRY/L3wmgYXZDo82
 YlP0DvAUcZCiw2quAvwPUbVSHm5JFoD2SoP3J830it8FmScxl4180swblp6vFZgGwcVU
 Pv6Dgv/U12nVZ5gvhUmEFyMnYtsR2UAum/IlTZP0raJiB5vusAJJoJN1H4s7YZICFliI
 PcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781617383; x=1782222183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+TMpqhNDrpSCOhtOJFDgnIMfyVz3H0yI9bEvZGS9fw=;
 b=XuXsK2WsvKdET+pZ1XsOGkNT5r/BnAZhBx2wKCqguTAyoPnC4966VqCuE7mJDIfY9w
 K/Ljj2JHM8IXsUWqzaG65+LLN4l/xKCRxauYovwWhzUJDuSRkInv/yYTB8fYEoa55pb+
 t/KtrK05bJ8ZpiiYljaVYU8qLQUpjjkRjQBdLUZ0nSaO1NAAqXh3dj9CuExv5+W1Ro7E
 3Bfh5fnor9jLZDd/strFHu3wJZVRxJcFiCQMtqS2OtOoAuoIRLPLbTA+xvEoHlfp/shA
 5MQr84G8L13AA7IG1L6ThirndXm0Ta/eoLtNybf+bmiE30fm6n+jB6O/Nd6F+MAMjt+4
 n4BQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cfwrSh2ljy514gHh1luFmnuHVuqr2jbTu1mKC9w5jJYeyX2IrYLnDts6R9a0dgSeBx34EZT/4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvmOtp9HHgNt3OVPc+OQ+ItI6It9wIzSVwz/fW4ZZThejQ1jd2
 GybxDSaxMzK858Ls9vD+3wim59Qb+nrAIZEbNDAkR8j1UBfXTnE9BrBhz4bVElIC6zz0qGZO6PH
 mrdC2B8y2d26HHFkjlfYDMpp0TIh9eFk=
X-Gm-Gg: Acq92OFsj/WPGd26WJYJL3puir9ibyUgNEjQCvzwgB/08JhNJyTCRLCN7tJfcx4+3z2
 LYBalLIu0tugvT6+A52FWoiT7f6dCWF1O6Whv6WYhU13/BWIO3AlKvVQP11R+WJigCF7QA4QfJk
 bkx3oaikEKddicTwI7LBy1psodmh5M8edC7XEXAw/z6a3wT4ZFlKbBxOnTpHyvWf8rjoTk2od/3
 XqFDFIkBBAlYyNlklkiydSl/gH6ImXRcC3HU9x3VuMeam4UKfE13iwDuwrfWTH7u7cQqwa5QdDS
 P+uoQNaeBo7cm634IV7cHUFdW5PcumpuojCMWn3u2rgTCBT1Z1SB6qn99ULJbfVhu0EoYQ==
X-Received: by 2002:a05:7023:a4b:20b0:136:bbe5:395e with SMTP id
 a92af1059eb24-1384bbb1e89mr2789479c88.5.1781617382781; Tue, 16 Jun 2026
 06:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
 <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 09:42:51 -0400
X-Gm-Features: AVVi8CfrK6K4H74bKw2lBz35LtUNNuuxNHtfu6wvLCZb4TbU4zW6J4w_SYn2FJU
Message-ID: <CADnq5_NgGCDKXLRmyu1_TCQkUfEUDnj0n1X2-Gg6Bg1Ya+o37Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/amdgpu: delay ttm buffer func enablement on
 xgmi
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 16, 2026 at 8:51=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> When amdgpu_init_minimal_xgmi is used, SDMA engines init
> is delayed so amdgpu_ttm_enable_buffer_funcs must be
> called later.
>
> Without this, the check for num_buffer_funcs_scheds will
> fail and using ttm buffer funcs later will fail.
>
> Fixes: 3a5da695c8d1 ("drm/amdgpu: only use working sdma schedulers for tt=
m")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 57e10afb4714..2e8954fa5c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2479,7 +2479,8 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
>         if (r)
>                 goto init_failed;
>
> -       amdgpu_ttm_enable_buffer_funcs(adev);
> +       if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
> +               amdgpu_ttm_enable_buffer_funcs(adev);
>
>         /* Don't init kfd if whole hive need to be reset during init */
>         if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index faac80a8a6eb..c0dca209335e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1663,6 +1663,8 @@ static void amdgpu_xgmi_reset_on_init_work(struct w=
ork_struct *work)
>                 if (r && r !=3D -EHWPOISON)
>                         dev_err(tmp_adev->dev,
>                                 "error during bad page data initializatio=
n");
> +
> +               amdgpu_ttm_enable_buffer_funcs(tmp_adev);
>         }
>  }
>
> --
> 2.43.0
>

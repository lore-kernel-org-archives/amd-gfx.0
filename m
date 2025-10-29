Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0406CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 21:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512C310E855;
	Wed, 29 Oct 2025 21:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hc4tRpyn";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC6C10E855
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 21:29:11 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-26987b80720so439465ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761773351; x=1762378151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8uykALMne5uV72bF+evnRvauMP9IO7XpD0DQ1snTwXc=;
 b=Hc4tRpynpluc9JqYEJgFs5PwKh8M+3Os5whezakoQ9yiUmEHMYxV9tYv0hfvLpFhSW
 T1Xi88fjL8yMHF1IfXKMLnPQaK8Ol5IeTEw0VzLQC5p89Rej8lC3fjNliSamiDAppJFL
 ThV79qz0e13BU4/P9WWfXyXwg9ElUKrmXQt1Bm4PHBDeOfiivtFUg1DWSg7duFMQrJ5h
 P0N+Asb7PCqKNEjleN47l7GlmpI7K7BnnUipF7vlDLJMHX+ESX/ks9STe9fmmgviVfGl
 4GRUHlUGt7vuNo/rOAmW+Aq4j1nTB0BNoHx4hJm6f2X+fvA2Tepb7Zifymzng7v0z1Ih
 GCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761773351; x=1762378151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8uykALMne5uV72bF+evnRvauMP9IO7XpD0DQ1snTwXc=;
 b=T5YirCA5KIa01rcR2L6jttMrWNWt1P2/1P6BdiY7xKyGu1AzfPsQxEvB4IkrDkqPTO
 uvZTkR/1OoJOWzaCZZEt8cuaLIIHUppZaQIPbtA2T/o/Vy5kWATqm89eNd2GQ681HqDp
 zpW26VW4hZLT6qD+MDxoVOszv8Pjvp4WYenfPFptPw1w+7iv66Nxx36WJSQ85lfl7V0A
 FjTvQ34z9qC2OPQAMsvGzbqFIHUDY9eV8BE6+3wE4aAuWV6CFS31YFXAONhVdUTw/1n5
 DfMBpB55zIDeocyHBypi+MLjStqeeAMOEhoTGMZFMKLOq7xLOnEIwxaf84i1GpVgD4w7
 MPIA==
X-Gm-Message-State: AOJu0YwX68mQSQEL36BUsoLbqO1VTsfDkVkJl4zuR3bc6cgJKb6UtSRq
 JJCJ7ihgaP1Cf91UtRTOz0kOi6irrFsbSabkXARuIVVe8kX+RwXU3gMaxwUSprV0ovY7NNHUEVr
 5M1yZPQzjPGYu3tBzIhAaFjOvCbYOF+w=
X-Gm-Gg: ASbGncsK8ll3Q+ASskLsEG/q1qgKa1n1E0rumSJWa3layULjT0rWV8YP44EvolrzQ5L
 e8kAH75Hm9D3g8okbQMKmnSA9uD9KakYrRMAcaXCe7C4R+KW+CVDfkNGNN6CGniMDr2bkeqU134
 3TYGTesbBvEsYkQVXeVsAho1VVfpHH8jzPgbrnUA7CEwu3AovnnDR6fJ3YtnxJJ2ua7GvxHwmRp
 20Jgb9IOv/i3jpkYXWyoLUJXjD9UvhzOUMSaJpAJZJkCpguj5isTwOhT8BGZT7j+TTBKe0=
X-Google-Smtp-Source: AGHT+IHhDGeGAb3WPRr6JBfOR4DVrutSIbCWvevTjH05X/sCFj0qURXab/aRv6UJ0vhJb0GJTJ5NGladDTF98ACTdrg=
X-Received: by 2002:a17:903:2445:b0:257:3283:b859 with SMTP id
 d9443c01a7336-294deee3548mr23206725ad.9.1761773350668; Wed, 29 Oct 2025
 14:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251023165243.317153-1-mario.limonciello@amd.com>
 <20251023165243.317153-3-mario.limonciello@amd.com>
In-Reply-To: <20251023165243.317153-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Oct 2025 17:28:57 -0400
X-Gm-Features: AWmQ_bnWqDHWPiQngI6ospOM36WsLF8RxtaybuTVruOCR-j60cYHnbYa0599ZiA
Message-ID: <CADnq5_Nzx4aE0V8bNhcjVfqN3qFJYr14hZM7XvZ_SB_y8EG_JQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/amd: Reset the GPU if pmops failed
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Oct 23, 2025 at 1:01=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If the GPU fails to suspend the return code is passed up to the caller
> but it's left in an inconsistent state.  This could lead to hangs
> if userspace tries to access it.
>
> The last stage of all pmpops calls (success or fail) is the complete()
> callback.  If by the time the PM core reaches this state the GPU is still
> in suspend something went really wrong, so reset it.

What happens at that stage?  Resetting would put the GPU back into a
known state from a hardware perspective (amdgpu_asic_reset() just does
the hardware reset), but software would still think things are
suspended so the sw side would still be broken.  If you want to try
and reset both the hw and sw state, you'd need to do the whole gpu
recovery sequence via a worker thread.  E.g., see
amdgpu_debugfs_reset_work() for reference.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index a36e15beafeb..e2d598dd462d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2590,6 +2590,17 @@ static int amdgpu_pmops_prepare(struct device *dev=
)
>
>  static void amdgpu_pmops_complete(struct device *dev)
>  {
> +       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +
> +       /* sequence failed, use a big =F0=9F=94=A8 try to cleanup */
> +       if (adev->in_suspend) {
> +               adev->in_suspend =3D adev->in_s0ix =3D adev->in_s3 =3D fa=
lse;
> +               dev_crit(adev->dev, "pmpops sequence failed, resetting\n"=
);
> +               amdgpu_asic_reset(adev);
> +               return;
> +       }
> +
>         amdgpu_device_complete(dev_get_drvdata(dev));
>  }
>
> --
> 2.51.1
>

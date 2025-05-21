Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50DCC2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 17:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7ED410E733;
	Wed, 21 May 2025 17:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T2cTnodk";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2A610E733
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 17:47:16 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2322d8316f6so4873205ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747849636; x=1748454436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmUOwGi3fQsmuob9EewCEWEhg0al5MKqSwjaQSeojY0=;
 b=T2cTnodkzqWvRjkKtf9gpF/BTVoZu7TRvPQqzFV/Ywpvf2SYVGeylfCgLYVne5dOXl
 7Yqmtb/an9q2X2EMlqGpTf+RUwBkurfn8zlFutpCXB7GzGxOe2HG6ECWT7d1hAlKs39m
 QBcczcwH8xrYswNwGo/KIBT6gaRgxFDr0gCekSyCwyO/uA1xJ51VPyXq7mIGa5Hcex3H
 b4XbHScptBCct1/zBlYlLxex9i7vtyH2UkcjdP1A1uI8epd9tHReSBkp2p2tSAOsKAac
 0Epnsi252bB+3d0mO9EJ/eoyzVREIFBguxZj2wBwMqfUYfXGmujor/S+PSzBBD42BIFI
 B5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747849636; x=1748454436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmUOwGi3fQsmuob9EewCEWEhg0al5MKqSwjaQSeojY0=;
 b=AHscggJKovdJnEo9QL3D4UwY3365E/LDCrzb5hD9XZO/hV/Lh7OUS5oS9BYSawRpNc
 f0jfr/zqGRebRg7XBA1PViVJvFniwOwZkK9Xk+I/N9920XdkFfhhedehnnFfpNQk9z7F
 EhSiIHDLC6HVAxDKJkkMvA2whxhNzVjuIB2ZKSkxecdBU+Tu1HEu3u6rPuwVazT3S2og
 aDToT0EtBFjXMKI/kieIrdUXcP9D95n/oIU6FXVpMAe7tGa1Oo04TCUUFD7JaUYO6yd1
 jIgbLnf7GbgK+vR+sL0lNLQW0DVVV6/FEPheK/QyvWUYeOXSWybwxy4ITDdd/1HE8O5B
 yiLg==
X-Gm-Message-State: AOJu0Yz9ybGwszrF1Cp9qdM+zfkIFKcLA+aCe1UZtSI3yQv1wV9jmQAB
 EJ2SVu2tXuZad4Bq7A65iFpL15unmtN04/Wh9dxL7tiC1GmuVwHRV67Vosnwjnw1wMzNH5ItE4l
 hoAq9HLlCqLYlaeLNI4ygiqOwCcCRqGI=
X-Gm-Gg: ASbGnct/PbUR/rtc4v/lFgEoXCz5vs/hbbUst9RzF7oPagC6EQ9viB2k18D4XLPpwVp
 K8l1lvXsD65rY133nuOq+2+qcNoX+DkilfkItmNsOhYm4EGFPzn6Rj1pdaPi/7yJNmucZt3M/gp
 u8QBlTUygGmfg0ZZMarNi+3v/TNZIEZI3D0w==
X-Google-Smtp-Source: AGHT+IGXwLyJj5NA6uBQ/zPCjuVCtnuAMfhQ3jv+CuWz6v9sSglsUHXNHbGg3f9h8PiV5gp6ymw94BDCtk22pEDwRnc=
X-Received: by 2002:a17:903:41d0:b0:22f:d4e7:e7ca with SMTP id
 d9443c01a7336-231d43b2377mr115857505ad.6.1747849636024; Wed, 21 May 2025
 10:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250521171203.48711-1-Jerry.Zuo@amd.com>
In-Reply-To: <20250521171203.48711-1-Jerry.Zuo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 May 2025 13:47:04 -0400
X-Gm-Features: AX0GCFvHiVZCrrb0WhHdRhcXMSEBjWe1t89MOlcLrC7TWgb4L0rnNAgg10DQJH8
Message-ID: <CADnq5_PFkqRMHYpVvQQDFXh6dxancwyZMDNWEoM-cK6f0ra7qw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: pause the workload setting in dm"
To: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Kenneth.Feng@amd.com
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

On Wed, May 21, 2025 at 1:12=E2=80=AFPM Fangzhi Zuo <Jerry.Zuo@amd.com> wro=
te:
>
> This reverts commit 243678df7a058f65f5f43e8026b359bcc91e0b69.
>
> Reason for revert: cause corruption on Dell U3224KB DP2 display.

Missing your signed-off-by.  Reverting this could result in higher
power usage because I think the display idle state requires the
default profile.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index e8bdd7f0c460..87058271b00c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -246,8 +246,6 @@ static void amdgpu_dm_crtc_vblank_control_worker(stru=
ct work_struct *work)
>         struct vblank_control_work *vblank_work =3D
>                 container_of(work, struct vblank_control_work, work);
>         struct amdgpu_display_manager *dm =3D vblank_work->dm;
> -       struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
> -       int r;
>
>         mutex_lock(&dm->dc_lock);
>
> @@ -275,15 +273,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(str=
uct work_struct *work)
>                         vblank_work->acrtc->dm_irq_params.allow_sr_entry)=
;
>         }
>
> -       if (dm->active_vblank_irq_count =3D=3D 0) {
> -               r =3D amdgpu_dpm_pause_power_profile(adev, true);
> -               if (r)
> -                       dev_warn(adev->dev, "failed to set default power =
profile mode\n");
> +       if (dm->active_vblank_irq_count =3D=3D 0)
>                 dc_allow_idle_optimizations(dm->dc, true);
> -               r =3D amdgpu_dpm_pause_power_profile(adev, false);
> -               if (r)
> -                       dev_warn(adev->dev, "failed to restore the power =
profile mode\n");
> -       }
>
>         mutex_unlock(&dm->dc_lock);
>
> --
> 2.43.0
>

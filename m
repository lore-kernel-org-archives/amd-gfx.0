Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DD3C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9423B10E58E;
	Mon,  4 Aug 2025 15:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e7iNxEJF";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6678510E58E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:24:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-31ed2c4cfcbso265734a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754321062; x=1754925862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZ6luU0b6lYR+sFXs3QE4ehPFPjoG+xvQZ0O72xXaCg=;
 b=e7iNxEJFxtqgvQFLG/WpMLw5B/37H9iWXqIvLikjpSUVr0G8fpYdZVGQvXEqik7gZt
 1vKvOMA6LCBq1to89T3E8Yd/URFK5Mm94dfdS1KasqgbaLYXf035K/1/A8fvuCyD7G5p
 T2rNaBybwzfDSjlvGutabJBpHoMqrQDNM+yabcekcJVK20axl7xmUjdJJ2C02zRBQ/lY
 2WcQhBPDSyHvOu8BEb3RU1Uzf27oqr5zlnKity/kPeH0xUctNUQURZyHLXvGrb9xfYZm
 4u8v7aMGca0K9GJPDJxmg77cm79iO2xvpbXuXP+epVjbsgFXHVCVxO9YbxcJhYxXGRE+
 zZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321062; x=1754925862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZ6luU0b6lYR+sFXs3QE4ehPFPjoG+xvQZ0O72xXaCg=;
 b=jHhlKhN7+78cavaPdyD5XxuDPJ1e09xKDUfyea2UooUYpntpg0+qz487Mu0rnfgqbu
 8XR934ABXLw/YImGUw+s4iUy2FhJ84ZByJsnngFa2/Z2delRu/MvVAO7lBq6sMbJ1ROy
 snEoaMfaTU5pomp2+ll4jtZ9A9NMdm7oqtC7Tp6r7xBHKX5O/BIic+PbuBSgPenlA1tS
 /BduSZf7OvfN2s0iPgcnU2i11/vlYTm0IeKvztUajLRrh2s8/Ew8BZpYR3xGILHb3xPY
 rgnScGxbWqFUlFhHhhww0lIT2saSm75swLhiD3DBHAi4kxfIZuNijgA+exT9asImgmAg
 2r7w==
X-Gm-Message-State: AOJu0Yz9T30oNqEknWrjE3UzfElYtU7K80jVlMqafqoltvjPXucdoe3G
 qA/ixFXvGcTVc5az0R0yYU8FGc6b05YKtJwujT8I7YfiNyh27TrU2G3JY3e/mxM6U1KMwvrKKp3
 9yHWs9mwa+U+4BWWNqX2+pIK1YtcKm38=
X-Gm-Gg: ASbGncs9k/d6yYtamciUTpiZCox9sKSYnTVj+vkQLeF36JIuwllL+/jON9fsJ27BB25
 KmWU2gR18lyTD3pAdTDMVeozl1YRZtVUBOITkgknKXzz2F/q/JqvnlRuhVT6wIINz8dap/C0u5/
 RxWHngXExVLHN3dMl/zdKgo5xqcZnoA80ULOE6qmJ3rh6hi8S/lvx0XGlx1KFiaH4AZa30cBrv1
 RNUzNuAkMZlaydaxF8=
X-Google-Smtp-Source: AGHT+IFeGvrQgRxeoPM0r4UWjVqdraVK07XRavzpSpBFCQXM/8TIMKAJ4x6IoHSq5fJWpHBbEnXWFla/Vc/KGanQHsA=
X-Received: by 2002:a17:90b:17c4:b0:31c:3871:27ad with SMTP id
 98e67ed59e1d1-3211611ac6cmr5783191a91.0.1754321061669; Mon, 04 Aug 2025
 08:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-3-timur.kristof@gmail.com>
In-Reply-To: <20250804134154.95875-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:24:08 -0400
X-Gm-Features: Ac12FXzMdm6tUkS6_CvVM1YsvCh_qXZ37cNBjdIXgfW-Nl2By5hO4U-F4vHm53Q
Message-ID: <CADnq5_PPfscSbxEhmDXzcgcQNX3RecMzUwZMsXm5Cm+g72uDaA@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Disable ULV even if unsupported
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> This commit fixes some instability on Tahiti.
>
> Sometimes UVD initialization would fail when using DC.
> I suspect this is because DC doesn't immediately turn on the
> display clock, so it changes how DPM behaves.

Is this the right description for this patch?  I thought you had said
this fixed something else.

Alex

>
> Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 52e732be59e3..33b9d4beec84 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -5639,10 +5639,13 @@ static int si_disable_ulv(struct amdgpu_device *a=
dev)
>  {
>         struct si_power_info *si_pi =3D si_get_pi(adev);
>         struct si_ulv_param *ulv =3D &si_pi->ulv;
> +       PPSMC_Result r;
>
> +       r =3D amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV);
> +
> +       /* Only care about SMC reply when ULV is supported. */
>         if (ulv->supported)
> -               return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_Disable=
ULV) =3D=3D PPSMC_Result_OK) ?
> -                       0 : -EINVAL;
> +               return (r =3D=3D PPSMC_Result_OK) ? 0 : -EINVAL;
>
>         return 0;
>  }
> --
> 2.50.1
>

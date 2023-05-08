Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5397C77B75
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 15:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAA910E134;
	Mon,  8 May 2023 15:57:06 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C61B10E134
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 15:57:04 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1929818d7faso32344704fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 May 2023 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683561423; x=1686153423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAUhFu5VG1zkn3bp1VONG2ENSPNEOi6mN1YfeKlZlxw=;
 b=ncYvkxo6k5rFCMM7N9s6uaDJjyAOr2wlm1l9OzEXtrxViBy14H4D0ZvA4IQM3HSx5U
 Ae8VV1CczaR0j0WRATIpg0QkC/JMJD2F62c9D7uqtkk9sAqMLIvB97H3Y346z9CG7kck
 n0d6JWyX3cccumrD0IMvkU0Qz4IdSjnvShZ63ABinUW6jHs3xylKiZ3Zqzt0eSI6Cft/
 KPLifZ6H1SubGTV5jQ3l0t16PQtaAjR/V14grZWx2b50fBvwqJfbZzQ8HuxXvMz4s2lL
 nhRAFz8Uc1una9VOVvvWR7MYhEc0aOiQT9SdwVgj147T411LgRXTpt8Mk7vW/T8wSN0H
 Rsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683561423; x=1686153423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAUhFu5VG1zkn3bp1VONG2ENSPNEOi6mN1YfeKlZlxw=;
 b=E4nlSi+u6wqC4SjPXnhCkoN6L/xtDgMtIKr2t1c/85KUWDfPKAiVgYKFJUkIEsmf9i
 JGdm22dfpnGJWAs6N7UocGAc3kV7U70/n188VYIUkQ8W5HikMG8SqClrchlyC3d0inaj
 bR2yUcM6L40r4Q9H1e4Ey4ZF2pgefSZn4v/dE8gysTm2oZxN153U06uo2IlEDaH328I2
 ZMJGbBzXJrTns1NNqaSQdsJcJXr6xjdbJE8P/Fq3L5x6STI8ZezKpuMmtKvXKQAGG0Mc
 ds6usP1Rtmkh9k/cA46befDz8R/9nTjKCcWLFvAddNMGQduO0fqwDbuH/1+eO/pzy6Vo
 yLbw==
X-Gm-Message-State: AC+VfDyJxT3rkhCxe7IGIFscCZsCRxxIteWTetH2a3UYTDrBAS2XvJOk
 lqqWOMPA/ZYb9t2uqgd5geIvynQgIrsyLXW+plw=
X-Google-Smtp-Source: ACHHUZ5aaA1XYqp3FvK05G1YioDx3NzLlYKdp/2x51Qnx4hLFePlAWkI9Q1pMubyOR+YQw+NoPBeiSD2uAYjr3QXEI8=
X-Received: by 2002:a4a:c117:0:b0:541:87fe:5b75 with SMTP id
 s23-20020a4ac117000000b0054187fe5b75mr5608092oop.1.1683561423011; Mon, 08 May
 2023 08:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230508152929.1114091-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230508152929.1114091-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 May 2023 11:56:51 -0400
Message-ID: <CADnq5_OfvZbUCiiOw1CHs2DkfjnmTwWedvDvnVgZUif7NBtUyg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 8, 2023 at 11:29=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Adhere to Linux kernel coding style.
>
> Reported by checkpatch:
>
> WARNING: else is not generally useful after a break or return
>

What about the else in the previous case statement?

Alex

> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c | 26 ++++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_encoders.c
> index c96e458ed088..049e9976ff34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> @@ -242,19 +242,18 @@ bool amdgpu_dig_monitor_is_duallink(struct drm_enco=
der *encoder,
>                 if ((dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJECT_=
ID_DISPLAYPORT) ||
>                     (dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJECT_=
ID_eDP))
>                         return false;
> -               else {
> -                       /* HDMI 1.3 supports up to 340 Mhz over single li=
nk */
> -                       if (connector->display_info.is_hdmi) {
> -                               if (pixel_clock > 340000)
> -                                       return true;
> -                               else
> -                                       return false;
> -                       } else {
> -                               if (pixel_clock > 165000)
> -                                       return true;
> -                               else
> -                                       return false;
> -                       }
> +
> +               /* HDMI 1.3 supports up to 340 Mhz over single link */
> +               if (connector->display_info.is_hdmi) {
> +                       if (pixel_clock > 340000)
> +                               return true;
> +                       else
> +                               return false;
> +               } else {
> +                       if (pixel_clock > 165000)
> +                               return true;
> +                       else
> +                               return false;
>                 }
>         default:
>                 return false;
> --
> 2.25.1
>

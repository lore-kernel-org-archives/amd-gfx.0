Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDE7C7EE2D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 13:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0536910E15C;
	Thu, 25 May 2023 13:00:23 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816FA10E12B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 13:00:20 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-54fb3ef9c53so150399eaf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685019619; x=1687611619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQYysr7J8NQ+WC2JUcV5XA62CVnkh5WJ2nNNqJGmQOo=;
 b=CYXrYFJ5RkOYA+eby0DHnxpZtFBUSskMUBQgKDitq27VD1J1D5orgsoymwwqlpGbP7
 9eI1UDB6H69CF6SiK2o0OIFgq62frK9yUvHWUBMC+1HNABIFJcIyECI0XnKFEYJDMLZA
 dKeux4Ap7dZ9eg6vu3/Sd1aqK4RGcsY65b1zLjfF6PkGcP8QS25eGyb4E+ruroOcznrc
 Dd1+vMwxybfpQGLZ7yL3tcRFzGWy3q/O3m+cJR/vLIKVzhyXcsm7g3arkQWbPGbkHCv3
 5eQCjGxQwWhrjGnqR3CpcvGpuo4C9jPeEh94fAA6sBOkRP0/dcehiR8zp8+UsWfCfpQV
 q+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019619; x=1687611619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQYysr7J8NQ+WC2JUcV5XA62CVnkh5WJ2nNNqJGmQOo=;
 b=SvB0qZxj7uYNu7bON7p65L1VqirvmydBgv4MtjNx66JUfAVKrYnuQlFaEvBwMgJhDl
 CNIDG5zmi1IbBfTmtj3yzuasI6EZ/jHS9ovxk4QNKDAQOtTHj6k/kSDcIyFyTdNFCVdT
 nYAvQjm6ZrlSqMJZJA3Xr1NlObg+oq7FyTCklHkrIMx+wBGgRXfGO6QfcMm3k1/TuHMk
 DoEY1EaGov7uk7oZNP8ij90cMZvFWC74qfIHtEzn9XHq4QuC5iv/ZjicRASObaLnDZ8s
 fCdE6xY/8h5Z6dlqp/st0bE/NHsc2ZkvvhhJHHQ1XK8EhipDGycuXvSaR5nuNo3ZR4KT
 gLFA==
X-Gm-Message-State: AC+VfDyFH/BCCbJZb2AT4GBHExp817Hf0C0DnBXjWNmG/iEzbkSU3nh7
 w1DbGIoNtcNQtW/d1sL/SaiHprKklDf1SL8IBXc=
X-Google-Smtp-Source: ACHHUZ4Hj0jhn62dVspNcS2gUhn3rNQSjU3X/+szNZ6QJN7ZUqo+PgIN/vPW5TkEIDYNpx9d4fvHcIWeuQt4O9klBTE=
X-Received: by 2002:a4a:921e:0:b0:555:2f29:f3c0 with SMTP id
 f30-20020a4a921e000000b005552f29f3c0mr6581720ooh.8.1685019619206; Thu, 25 May
 2023 06:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230525071617.2758109-1-ikshwaku.chauhan@amd.com>
In-Reply-To: <20230525071617.2758109-1-ikshwaku.chauhan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 May 2023 09:00:07 -0400
Message-ID: <CADnq5_MfjaAEpnwXfzpB1a0E8czFFto9j1Z_uHZ3Jxdm-T+c3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable tmz by default for GC 11.0.1
To: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 25, 2023 at 3:22=E2=80=AFAM Ikshwaku Chauhan
<ikshwaku.chauhan@amd.com> wrote:
>
> Add IP GC 11.0.1 in the list of target to have
> tmz enabled by default.
>
> Signed-off-by: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 3f5dd9e32e08..348d856626c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -591,6 +591,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(9, 3, 0):
>         /* GC 10.3.7 */
>         case IP_VERSION(10, 3, 7):
> +       /* GC 11.0.1 */
> +       case IP_VERSION(11, 0, 1):
>                 if (amdgpu_tmz =3D=3D 0) {
>                         adev->gmc.tmz_enabled =3D false;
>                         dev_info(adev->dev,
> @@ -614,7 +616,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(10, 3, 1):
>         /* YELLOW_CARP*/
>         case IP_VERSION(10, 3, 3):
> -       case IP_VERSION(11, 0, 1):
>         case IP_VERSION(11, 0, 4):
>                 /* Don't enable it by default yet.
>                  */
> --
> 2.25.1
>

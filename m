Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60598CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 21:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D614F10E02F;
	Tue, 17 Oct 2023 21:26:43 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F5210E02F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 21:26:42 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1dcdfeb7e44so3922048fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 14:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697578002; x=1698182802; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7oRudJTZNQ63tfH/j3jOwQZOr/oDmGpk2QUzgSFYa8=;
 b=TGD7vYmuFu/C6zTYbSpGb61zlN0zW2EQdzIYFOvR9vFYEi1Pjd9m35YzEKjZTi9llM
 Bem4fOUnObja7OWCuIAu4NrEDbzqmUtXHZg6zf/qT9TNBwfa2QvyK0L7zkRhKFTu6qQq
 XiWIfOpCoMhP76159KKXkG6E/3B3Qj5bTbQ7N+/TVY8C1iQhfB0ilasEVyRfBHzxZWwj
 YZPPbVo6vTY3iLXCzmYLKtQ5BW/oytJvJhsxx4qdZQuI35NHMXvIb3YP/iUaqZ918nZe
 ln6mTXez8sSGtZCArYsNeVoUP5R9uqMvbQXraarVjFLXJhbqte0R0xiACMcPHo6wN1d7
 OD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697578002; x=1698182802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7oRudJTZNQ63tfH/j3jOwQZOr/oDmGpk2QUzgSFYa8=;
 b=T0IdRBrdPQbIvL0NNv0wfUIN2Jp5AJH8irCeWpgeaF9yXImhqj98oo+cT3167JqHNR
 Sam/T+42PvE16htbuBheCu1aMJSFMc0jTuaTcGIISa5AoDQOp+ZwqgbSSAdPexPZjaPu
 8S+y4bERZNhHl13HhitoOB9fe1esJacnJ8k1bhKjfbSN5hrCpyqjNb/FT8dMFQYBXFHi
 yQMtLhHtoT23ChMFvrpgtz2FL7jTwHNR8wqzmsoLwkgafVmwKI6WdLYtY7O8JsV1RGbE
 laTAi0h9pkNbgILZyL2OULe5UQI9pSjGq/XTxhpi/aGNj3kQ7q4e5RkHCJIQOEhIdW+8
 +3XA==
X-Gm-Message-State: AOJu0YzpqgxZaDJ9KlwtWQG5DTY2jgFGNfBGHLyoGKyI7oVuNA727ElY
 /39JTTAAwxJ+u5cfnflSFMRMs9j+XA35Pw3bd0o=
X-Google-Smtp-Source: AGHT+IFHP3DC+vFE1ZAYUASSi1nwdTzgbABfTYwexiMCgpOeTNU5eenzTLo8MmvJE5ZGboVQ1DHYQ9vTtJLksnkDmLE=
X-Received: by 2002:a05:6870:212:b0:1e9:a770:61eb with SMTP id
 j18-20020a056870021200b001e9a77061ebmr4182248oad.29.1697578001683; Tue, 17
 Oct 2023 14:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231017140135.1122153-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20231017140135.1122153-1-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Oct 2023 17:26:30 -0400
Message-ID: <CADnq5_Mcrd3czO4jxqUCryn-gNCCM_1+8J5vwT=CTJLJys9B6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Handle non-terminated overdrive commands.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, Rex.Zhu@amd.com, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Oct 17, 2023 at 10:01=E2=80=AFAM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> The incoming strings might not be terminated by a newline
> or a 0.
>
> (found while testing a program that just wrote the string
>  itself, causing a crash)
>
> Cc: stable@vger.kernel.org
> Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage s=
upport in sysfs")
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index da0da03569e8..f9c9eba1a815 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       if (count > 127)
> +       if (count > 127 || count =3D=3D 0)
>                 return -EINVAL;
>
>         if (*buf =3D=3D 's')
> @@ -780,7 +780,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>         else
>                 return -EINVAL;
>
> -       memcpy(buf_cpy, buf, count+1);
> +       memcpy(buf_cpy, buf, count);
> +       buf_cpy[count] =3D 0;
>
>         tmp_str =3D buf_cpy;
>
> @@ -797,6 +798,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>                         return -EINVAL;
>                 parameter_size++;
>
> +               if (!tmp_str)
> +                       break;
> +
>                 while (isspace(*tmp_str))
>                         tmp_str++;
>         }
> --
> 2.42.0
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EF8CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 15:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04E710ED61;
	Tue, 19 May 2026 15:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hAnxvX/N";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4159710ED61
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 15:09:57 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f16c892babso194159eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779203396; cv=none;
 d=google.com; s=arc-20240605;
 b=C31aqmgQ0bggmxh2gR/qAosn7zBM1UbmN/AJfY1MR1QSZNKOrzHdHkgnnm4pzjZbdv
 sFpPCd7pSruwC4nexAyv5R7zPYRsioiHQKQFil4UDMmG2vW7O9zrwsMvQd9WYTa7pQKG
 r/6d4wJC3x0e5CZA5eEKd3u8x6ng5NL7zSO4Hh2LIIvxYXJLRA5ojdIjCyqd6YUD3iLH
 NAI3tW89pxGxA79Pky19eNSn950EYUesd5XsQ9wgmWtYxsUJ2qsBy26pITJJ9E63XTC3
 zRGTSr8aa1WiQ0MFP4JwDM6zXDAKb3qmNHKRjLcMEwlRVOjC9O3fTGpVzQvKjAqUAdk4
 Ox4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TWnVTVksITKPAhoRP6Y3qQxe9phY5G7cyxbbpX0qjS0=;
 fh=m85prCGj3H8LnYRWs3jhVM8MIwvQkW3RdEwuSXjbWSM=;
 b=PK30AHUQNyZUbAwRr8f3bwzDIeExMF/7KcFwLH3vLjkBbRq0l8DaYvz44NR5XSuonZ
 fWinHKbhEWrGp+9X5oZTSO24e6L/rtwh2yHrQwqmppV5LPPbQ4BLlfJx0HSZC4Uze7Nu
 g8YqwPO7cNE19WKvKdzcZqwTnBn78jTo24jgB4aq6AG5yWvUdfstqTx8st1AyTpiy2gT
 Vo6eEryrXc8bNLLtQgGJFIgx9FhqRAwAvPc7bFIA/v5+c6XLxrxmXdTZODQF+Ww0UjzC
 8R8WcJXiiqHvf0aeu4RZWDqbxS+7uOfQzj1nvAcW671o9GKpw6/BgKJpVPFSprhBCUCq
 Bx2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779203396; x=1779808196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWnVTVksITKPAhoRP6Y3qQxe9phY5G7cyxbbpX0qjS0=;
 b=hAnxvX/NWPzoQcsThIO4yHVW0GUzHAP5Mxa/TKhUwfek9VJHRgF4kTV0GDYO13yJLt
 7v2Uuo+0H1U6PvtJ7XL6pER2y2iqAG0kRrklfMqDJA18bsDbr5zM9pTYtHbKFycQPzxd
 0xlvBr514vGEcG4ed7JFrbrGzv6G5BFLelKRpSpw67NFL3uAKWC0xHjbdup6wl9SVGmk
 bez0wqFne1DJJAD6GiWJhkugRTcsloFErE9P1Uda1ddxH+nGdyAjo4pypukgjiKOZ3XO
 7arOO8g/ExW5//FAzJ8f2+DnIFW1e7Iy2Wo8RS4ycsotEpC1LzEiAQ0vO95DnIhJC76S
 IdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779203396; x=1779808196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TWnVTVksITKPAhoRP6Y3qQxe9phY5G7cyxbbpX0qjS0=;
 b=oZG50aEm9X3H7bT1nI6B4Lq1OxaeHd1ySzm3tskp0YCx9BzRAA2xcfkNBzXz23Bo+m
 px7I/bcIujI+EL4TP0AOsKAlhU0r3cVle9FLooQYhCavcG1lMuL2JYZukFb++w3Ces3X
 shmZYHF3MER/CUK8aseB6jYBlkHkFvRah359x2B2BhqUMzb6zLaLkH7nUo8MY7jZo+GK
 AdbeMoZxhP1npk6Ht8E38+D9pLCOezJOgfqCbCSUm5TRG+AiX+C4j1NPS8vbaflEPTDE
 Bk55FGuyHu7qx+EtMPlSpha2aaQuAG0E+f8DlE0VEYM9ZsItRxuSYsxGqXMwWhZFvERu
 iHug==
X-Gm-Message-State: AOJu0YyYSRvno+jrsPBWxXpbsT3lpyVsqblQWuuVaNir7MtnMpIITcv2
 +pMHQDyW/S7Oio4rqoeY99CHePaHNAw/uVmHnF0NnZWQvSCQyBfnUyefUSxDwJ+lNyfDSGmvqTB
 EjVgwT5TyXTgWbB0JzhNSWrN3/uiwF2s=
X-Gm-Gg: Acq92OEQ2o3S4/wZwKwHIi6wuOAHrlZJ7uZYJpk82+is0ohpXFq580qb7CMOTbGaDkp
 a0xE2MyTc9EKc3R5cnmIWlvRE6T72tUKA54FSERTz3Vwhqh7bo/7AIoLXtXLUqJ21AfFiJqAY30
 AWlWuFHz7cGvLyFJFias6C4LQyL8slAPnATCr6vtIhedHKtpjvlYoVV9YisDNdd6gPfXiMkA9Fk
 4FQF9WuT0rdr/mR/tKUaby1R4d9lh5xKU6sl/NCNlDyJsGmHV5dsEBQRBUgUUovEFideOUQwV4Q
 L7QQXj/f5iuALQcLD8u2hYkp8tDn8uWdcAt3njlLKLJJdOHxpLyq1iiQijwexl9W1aqkHS8lELB
 O9Y0O
X-Received: by 2002:a05:7022:6620:b0:134:cf44:5fa9 with SMTP id
 a92af1059eb24-13503fe876fmr3573857c88.0.1779203396419; Tue, 19 May 2026
 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260519084158.72960-1-timur.kristof@gmail.com>
 <20260519084158.72960-2-timur.kristof@gmail.com>
In-Reply-To: <20260519084158.72960-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 11:09:43 -0400
X-Gm-Features: AVHnY4JXmiTtLRd_pJx3NfKzkZH5Hq4kPqBX5l1JQBsAlB8Oa2dHRWlf_wy8tzg
Message-ID: <CADnq5_NfMcnXT7JM98dumcam7xBS-QUc0nEP_7Y+r6HFJ1oNYQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amd/pm/si: Disregard vblank time when no displays
 are connected
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>, 
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
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

On Tue, May 19, 2026 at 4:42=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> When no displays are connected, there is no vblank
> happening so the power management code shouldn't
> worry about it.
>
> This fixes a regression that caused the memory clock
> to be stuck at maximum when there were no displays
> connected to a SI GPU.
>
> Fixes: 9003a0746864 ("drm/amd/pm: Treat zero vblank time as too short in =
si_dpm (v3)")
> Fixes: 9d73b107a61b ("drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)")
> Tested-by: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
And applied.

Thanks!

> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index b75a6031c68a..5afe42918497 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3076,6 +3076,10 @@ static bool si_dpm_vblank_too_short(void *handle)
>         /* we never hit the non-gddr5 limit so disable it */
>         u32 switch_limit =3D adev->gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_=
GDDR5 ? 450 : 0;
>
> +       /* Disregard vblank time when there are no displays connected */
> +       if (!adev->pm.pm_display_cfg.num_display)
> +               return false;
> +
>         /* Consider zero vblank time too short and disable MCLK switching=
.
>          * Note that the vblank time is set to maximum when no displays a=
re attached,
>          * so we'll still enable MCLK switching in that case.
> --
> 2.54.0
>

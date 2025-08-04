Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3A6C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0425410E58F;
	Mon,  4 Aug 2025 15:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FLe/hgmL";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A584B10E58F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:24:55 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-31e863a05f4so607537a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754321095; x=1754925895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPAq3DdnL1gXeT505ToDwFKZPO3PafY22wwoeztny00=;
 b=FLe/hgmL5Tzbby5zSWQVmAAdqtyMhx+np5evbjklTqpZUT0h4aG7q6QWISEPz4BmgD
 wCKWdWoEqyp+7WRs/7uT36imZ1xZ/9BLDSSu7MDHORrGSLYRIEV+wd+pry7xMX/v+wjI
 fxux1Sqhzh1CJSbynfLEvz1CliFG24yvBJaEhmjspTvHkmzmyLSJx9xTuXxJjf3d9o78
 gG+c7tLE5ZMhAH/CWZKMrIeVmfz/RtTZfwBjnWFBPj9y1f1CsC5mxgGqAhCpaihBLPMZ
 wk8HICkA+e6A8I4J4+CVYuAmen7qbrdwQWq2wipEn+MSorBemv7ZtWqSe09oDoOamxrV
 AXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321095; x=1754925895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPAq3DdnL1gXeT505ToDwFKZPO3PafY22wwoeztny00=;
 b=blIMNDnJYtheWga2kVnUvTiL+02EaKjEOrKYAf+EzaOHY5buaGIhqLkYqNq/IhbuvD
 rEtVkSkyC6ETEa+fFoOjSuLqukbgTC5euB8eMNm9njFLGH/uoKJU8oDXvFczYeHCL/Gf
 qxhFpoWosGV/K4LT1LM9KwhkdapHxolhhmaYs/jZuHv5RtkBm9b96uZVQT9wfzkCsfTG
 gBKAgwcFstZOQ5/UgXuTI5F+M0eoxgQEKYON/I+rb37V/6N3Yk/KQ3P3vbTJIyab8qkb
 g3j+9tHGEj8iGCx7jSNR0U1Va5FeqM2VLLjEnvu3I9z39Ks+7iwPjiikzSnlSznlSbR/
 YB3w==
X-Gm-Message-State: AOJu0YxC0pyPfR9A1Xe9uzuskpDh4rrnAgB0GBi1V5ooD2wAMBXizMpF
 yGdzcRea9Kd2r5YdHxSXZ2r4Mom9SF6uSiEvjjQuNQ76nGvBpFr9GZy6mKz7H2fFZakiu5t8+FP
 knkungkuLyYyWf8fd0QY7GdLpAbxZYFJzeg==
X-Gm-Gg: ASbGncswUyGeyd6AvTSN7svE6hBQmjB3tGg4JgjD58Zm2HpTtxKXUJHGCyUmLgRQO/F
 g0WX3VXuHSNq5h4Qal3t6CR/r1WR+xc8g70sog9CbgiFyp42FiFuc5vmY3qA3VY0hoBXt5t429S
 PfNT05e9IMVrINKZpqlPOe/WHIV5EG1zcewkZAFwYtnVOVNAs5Xq8qEFdQ6s/kNvK2RLbrq1Lpp
 0bExwjV
X-Google-Smtp-Source: AGHT+IFUX6XMuNsopEjt1PiGEjPPwJMIh9UaayPejcdZEbJaWy3anAXc3HH1YSg3xsOflFxnEBR7PQii6xrwgaXVf+E=
X-Received: by 2002:a17:90b:4c47:b0:31e:ffd4:ecdc with SMTP id
 98e67ed59e1d1-321163044d3mr6027915a91.7.1754321095037; Mon, 04 Aug 2025
 08:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-4-timur.kristof@gmail.com>
In-Reply-To: <20250804134154.95875-4-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:24:42 -0400
X-Gm-Features: Ac12FXwgk-YYS-itdwDNqKgA-5oLoi-Ho0-aL8cKWP-eZy0aSxkRPif0YbymeMs
Message-ID: <CADnq5_NoepbUzAczVq-t2P1jKweq6h2bOfHU9jqyupSszToXZg@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/radeon: Disable ULV even if unsupported
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

On Mon, Aug 4, 2025 at 10:18=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Backport of the same commit to amdgpu.
> This commit fixes some instability on Tahiti.

Have you tested this with radeon?

Alex

>
> Fixes: a9e61410921b ("drm/radeon/kms: add dpm support for SI (v7)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/radeon/si_dpm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index 9deb91970d4d..47fba85436a7 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5073,10 +5073,13 @@ static int si_disable_ulv(struct radeon_device *r=
dev)
>  {
>         struct si_power_info *si_pi =3D si_get_pi(rdev);
>         struct si_ulv_param *ulv =3D &si_pi->ulv;
> +       PPSMC_Result r;
>
> +       r =3D si_send_msg_to_smc(rdev, PPSMC_MSG_DisableULV);
> +
> +       /* Only care about SMC reply when ULV is supported. */
>         if (ulv->supported)
> -               return (si_send_msg_to_smc(rdev, PPSMC_MSG_DisableULV) =
=3D=3D PPSMC_Result_OK) ?
> -                       0 : -EINVAL;
> +               return (r =3D=3D PPSMC_Result_OK) ? 0 : -EINVAL;
>
>         return 0;
>  }
> --
> 2.50.1
>

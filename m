Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24A4C88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 13:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C5E10E047;
	Wed, 16 Sep 2026 13:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rqaXsysu";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5276010E047
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 13:43:23 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39d67a9ae5bso120682a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 06:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789566203; cv=none;
 d=google.com; s=arc-20260327;
 b=c+T9/lsSvq0sIdLQmX1rjNYbVHssx0Q8STOlVkE1x56VVDGmLkQkLV/e+dRTZFWTLi
 lRrYh3lIud60QV70xhtu/q/MWlNJKXFxLno+XwO/eTwVolxyDlyD8c3/H2cNs0LnXVY8
 VyzxgEqfn0pDTTzG9gNsbOnZh79TngzDGeP54QWZJzGImVfAncx0XzuHkpz8z0IY6f0c
 PcezCVzX72s90tjOfAPnF+MYPnFmABe/+wNrNy+mChrYn+UPIOL2aKdfQjdwYBwQkUtd
 GZ9DALRjY+ynMrSPxvoDakTJ7sOAL7jBiOSOdraoGmUjyV2YYZegqOejnP/kuGuXx7bJ
 Rs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vjh1DnpPWqPbpHLga85FABWYuMiu7ASGXtOHEMufVrk=;
 fh=WmyEQsrKOgFkobcaAxSvn2AqDeMXcd+G7obYtOqMQhg=;
 b=qEbmL7uLoe2aog0UzYTgE0T9UDHwqLcP/xLNwJLg027wxg20R0qqciaehmRx8upTKR
 2Hj06ouFp/hisRrM2jvAW8lWN9LXBP6JFhs1RwMUctk2dtLXlaV+NJY4Vhaq18EiR1lZ
 TYKBd4MxZdx2Hualm3oUc6/fFV5W3JuY9iDYfV4xYn4pHA6bcDWmoycStjFpUmaapKO8
 7redS8tRy4Zu4HnD4Uw7fBVfX4oAhU/Tluyz7rM4FL75vYPf7oLM0UP9fPsge5q+5Ifn
 onee/mkfJKew6i454zHr+Cva35rQcxtqOq6DIz4RU1euVwCZfXiNqGnFt8nm2fqJrMfW
 sw1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789566203; x=1790171003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vjh1DnpPWqPbpHLga85FABWYuMiu7ASGXtOHEMufVrk=;
 b=rqaXsysue0wDJoD2RsWIqlIp0rn4AzHo43KXekQQoP7n2oboalKa/AtRHRv55OckLv
 /nypvrfrdrk4YbVvM58lzLNHBpEzViEzCyBfirhTD54ejIQZ7dbbc3mbX09Xijp6Fixc
 2j0vyqLVNf1QFzpuV0UgyjnKCrPfTttF/tKxtlkzZyHRxvkQsMEAos9SbnAEwqfD/FxO
 NwU0HLNOymDqi/JaxESf5Q6IA+10aqnfMIcgCaBllduwLjNl78N/0sQn3n3JOq1yYqh/
 HIpIMHRPu5D/HmFLZpiA7Ibl2gEHBF9giRPENckZIHReGSISeP0/VjULaShVJWEJY1gn
 QRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789566203; x=1790171003;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vjh1DnpPWqPbpHLga85FABWYuMiu7ASGXtOHEMufVrk=;
 b=V6EVBYpJDH4WtUSZAB0H25rqEHJafHVfXw1exsov/h60ov60GzD3H7FYdKNPVPt250
 Rg+JM0Hactk+mEs8aYIMXhleIyM2iPcM3dzMWwLrTwxKK7Ss82r0sopc3ScYdxiC9KRx
 w/GjXvT9+o6FYusWdegGmh+Zn5X/dXSNOSZR6/GJxZHK3g9DObC3KUlcbRtY5BwjIURp
 QpkPflR4/00wWh+xS7vutYqzvc3Po0tFqMIKeNPs6k+71tBMz3yD5nXLc3JfWGCsk3b1
 jOZX4nhvH+I9afrS8BnHUr/6wcvjGeaqd9ojwaLZK5LewUitLfoa4rFsBRtl2bS/8mO2
 kE7g==
X-Gm-Message-State: AFuF++krjY93K2JdQbUFu0SPTqR56onA4gpMYan0r/Rurmw695QO758G
 bVQOosJP+0K4psq1cZa2VbLwYMSLlckPaCt6KbxOfwXKPaRYDNZJzdSqv8t+yEtXDi7Dsa9sMoh
 SKhqH8p16z2NPQm6Ik1QX53pBxe2MfdU=
X-Gm-Gg: AYBFou1FGbtiXtRmj73YXZM0Swn0jw9mFRbp5WxdLR5kw3wVneB5xQ21TkZfsjya1mG
 KiVc2gOIuy0XwsVCiAbroYNx96NB/ebuO7SDDdzEAPGba1rX4FeFF4AXGzxexKjfR10hj2yasaJ
 grtaue/8ndDmrTgKri02HQ5coFnKDbT+9eqE8XoWSard3LubrYItd20gkoyPIIgdz2uADsHLa9w
 JbotX6ecLUG/BAGwYfKqy4mDR4gfTmftqXDCITYtNxj4KmFJk4syBMLfbdA/n9fACCUQGVrPjLK
 xv3st4rpat3qwV8bMSrWyUJoCtp9EPs5nbEak+Natiui/ujocGyeR3O6miK65VFTFV9d/6WDpf/
 mr5FGU2GA8VUZ7wQzQt54D3/COeIoL50I3GZbMCYJew==
X-Received: by 2002:a17:90a:281:b0:39e:2f57:67c0 with SMTP id
 98e67ed59e1d1-39e2f58489bmr602054a91.0.1789566202629; Wed, 16 Sep 2026
 06:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260916045117.1658211-1-lijo.lazar@amd.com>
 <20260916045117.1658211-2-lijo.lazar@amd.com>
In-Reply-To: <20260916045117.1658211-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2026 09:43:08 -0400
X-Gm-Features: AcwNN1WsL8XOotE8yxtimEk38RD7sL95aRAE8IHtW6xXf4tSMKQj3XaVfeC2YVk
Message-ID: <CADnq5_NJWyQdL8wX5hYDyz2A-7vULDUjnLDyDou4LeN9QoUJOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: Drop redundant power_context_size
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com
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

On Wed, Sep 16, 2026 at 1:16=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> The size is stored and cleared in init/fini but never used to for
> anything else like copy. Drop the size and use pointer for init/fini
> checks.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 1 -
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 6 ++----
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 6 ++----
>  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 6 ++----
>  5 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 2586f9fa6589..ab43a5cd0dcd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -487,7 +487,6 @@ struct smu_power_gate {
>
>  struct smu_power_context {
>         void *power_context;
> -       uint32_t power_context_size;
>         struct smu_power_gate power_gate;
>  };
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index f0b2e7da67b1..09e20d5ee044 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -345,7 +345,6 @@ int smu_v11_0_init_power(struct smu_context *smu)
>         smu_power->power_context =3D kzalloc(size, GFP_KERNEL);
>         if (!smu_power->power_context)
>                 return -ENOMEM;
> -       smu_power->power_context_size =3D size;
>
>         return 0;
>  }
> @@ -356,7 +355,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)
>
>         kfree(smu_power->power_context);
>         smu_power->power_context =3D NULL;
> -       smu_power->power_context_size =3D 0;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index c4b2fe60da62..b250c5e41e45 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -427,13 +427,12 @@ int smu_v13_0_init_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>
> -       if (smu_power->power_context || smu_power->power_context_size !=
=3D 0)
> +       if (smu_power->power_context)
>                 return -EINVAL;
>
>         smu_power->power_context =3D kzalloc_obj(struct smu_13_0_power_co=
ntext);
>         if (!smu_power->power_context)
>                 return -ENOMEM;
> -       smu_power->power_context_size =3D sizeof(struct smu_13_0_power_co=
ntext);
>
>         return 0;
>  }
> @@ -442,12 +441,11 @@ int smu_v13_0_fini_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>
> -       if (!smu_power->power_context || smu_power->power_context_size =
=3D=3D 0)
> +       if (!smu_power->power_context)
>                 return -EINVAL;
>
>         kfree(smu_power->power_context);
>         smu_power->power_context =3D NULL;
> -       smu_power->power_context_size =3D 0;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index f2e6105b0d79..5e890b56fd37 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -393,13 +393,12 @@ int smu_v14_0_init_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>
> -       if (smu_power->power_context || smu_power->power_context_size !=
=3D 0)
> +       if (smu_power->power_context)
>                 return -EINVAL;
>
>         smu_power->power_context =3D kzalloc_obj(struct smu_14_0_power_co=
ntext);
>         if (!smu_power->power_context)
>                 return -ENOMEM;
> -       smu_power->power_context_size =3D sizeof(struct smu_14_0_power_co=
ntext);
>
>         return 0;
>  }
> @@ -408,12 +407,11 @@ int smu_v14_0_fini_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>
> -       if (!smu_power->power_context || smu_power->power_context_size =
=3D=3D 0)
> +       if (!smu_power->power_context)
>                 return -EINVAL;
>
>         kfree(smu_power->power_context);
>         smu_power->power_context =3D NULL;
> -       smu_power->power_context_size =3D 0;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index dfc1022112d5..4be864e4f0e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -335,13 +335,12 @@ int smu_v15_0_init_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>
> -       if (smu_power->power_context || smu_power->power_context_size !=
=3D 0)
> +       if (smu_power->power_context)
>                 return -EINVAL;
>
>         smu_power->power_context =3D kzalloc_obj(struct smu_15_0_power_co=
ntext);
>         if (!smu_power->power_context)
>                 return -ENOMEM;
> -       smu_power->power_context_size =3D sizeof(struct smu_15_0_power_co=
ntext);
>
>         return 0;
>  }
> @@ -350,12 +349,11 @@ int smu_v15_0_fini_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>
> -       if (!smu_power->power_context || smu_power->power_context_size =
=3D=3D 0)
> +       if (!smu_power->power_context)
>                 return -EINVAL;
>
>         kfree(smu_power->power_context);
>         smu_power->power_context =3D NULL;
> -       smu_power->power_context_size =3D 0;
>
>         return 0;
>  }
> --
> 2.49.0
>

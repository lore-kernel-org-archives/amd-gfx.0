Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564FAEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 13:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1B210E205;
	Mon, 26 Jun 2023 13:35:53 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7AA10E205
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 13:35:51 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a1a47b33d8so2975305b6e.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687786550; x=1690378550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmPM70/FdWf+dGMdgKVzzNOJEszbSrIl581ReFmnZHo=;
 b=ImoWSyymE8nf8CzpgzwmarT1Q6K0YabirpTfBJbdm1jZ1TtlM1aQetB5fg2xhJsCae
 y2efgd1am+x+zfnuFUv9wyMQ1UURduZLrP0Gxha2WOTW1RUSoRto0SLZCaktPYXRawiv
 1CMS5Zjcoiyts0GT5foWDhz+lNSx+KfywZv6Jv4T14Y6qrQsIHLFwULFS6Gac72Se3V3
 fWxYuLpxOJdBa6eeLWdt5CC/gJTZ0dCA1R/KoYG49ZlULE9l2LGXfdHvoNe2ZYCfTrtJ
 u0y1hSux+BVtuIySJ0NOomY2dxGkoEubd8n1+6Bsb8qBDb5TJu6AgBQe2YvZbzSt+w90
 TELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687786550; x=1690378550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmPM70/FdWf+dGMdgKVzzNOJEszbSrIl581ReFmnZHo=;
 b=G6NGLZlQ+xql1FQmyMhNYsZklsI8zDOi00eBzCAQ/FBfqwDwAdmd5WIhY8fqjvAYMz
 BqItQeE4d1qbe/HDwSobtuQeG+jLMZGC7UCoHJvfta6cgrO0EVbANeRmlzaYNDba/z4K
 oBXICw4de5e5e6bYm+4IT01r5hk17JsVMkDvbunqV62RP17OOvQH/MQeE44368klnUXV
 CxK9Kzg31vx58FiC7WUUxtABWk7DR/Mq1LjY+o74m8cohEjwSquooPYPrIcJ+oGmKmpS
 HrSQjEpU7SifWNHfK83RPs/GUJE+xepyBHgbQ0PaJr9xkJXPK5hQuRVKV244lrGLKKDb
 pJeA==
X-Gm-Message-State: AC+VfDz50x96KqokKtxue1mHzhfoDRKsb3n2bVgEHCDCqgx/YnHZQXs8
 L+b+IpRATM9tRbneBxJY8Jq+0YArVIqZemnHXhU=
X-Google-Smtp-Source: ACHHUZ576DxUKXBqlSbHI19PeFYjl5Yu+i9IqOPM+YmBPMYv8mNqWyj/27Pr0/XEUBWBQzuIwEtrOqk4LYH7Q9DBDho=
X-Received: by 2002:a05:6808:16a7:b0:3a0:4dc3:25ff with SMTP id
 bb39-20020a05680816a700b003a04dc325ffmr20865563oib.7.1687786550072; Mon, 26
 Jun 2023 06:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230626123500.2641677-1-lijo.lazar@amd.com>
In-Reply-To: <20230626123500.2641677-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jun 2023 09:35:39 -0400
Message-ID: <CADnq5_OVJm8-hzS4vrUh4LJSry8ry604UOo4p7ChZ=dRX3+XWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Enable pp_feature attribute
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jun 26, 2023 at 8:35=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> on APUs with GFX v9.4.3
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 9ec51f50fc52..9ef88a0b1b57 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2083,7 +2083,9 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
>                         *states =3D ATTR_STATE_UNSUPPORTED;
>                 }
>         } else if (DEVICE_ATTR_IS(pp_features)) {
> -               if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0,=
 0))
> +               if ((adev->flags & AMD_IS_APU &&
> +                    gc_ver !=3D IP_VERSION(9, 4, 3)) ||
> +                   gc_ver < IP_VERSION(9, 0, 0))
>                         *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(gpu_metrics)) {
>                 if (gc_ver < IP_VERSION(9, 1, 0))
> --
> 2.25.1
>

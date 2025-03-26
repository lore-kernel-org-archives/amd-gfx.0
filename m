Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF1EC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 15:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10A310E728;
	Wed, 26 Mar 2025 15:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g+Q0g4qU";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C1710E728
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:53:23 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2241c95619eso143845ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743004402; x=1743609202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooWCNGMr+ZPyA8HOWEof7Pv4KHsW+D7QCTeak49fwBI=;
 b=g+Q0g4qUPJafCj/CMmCT8i714jxHgprlqF1DaouXHj5Dd/HFDL15zu36QLG1hKdChK
 tJulRFuTXFwjSduFOcgHmQagqzt5mzVr3WtpJhitCRybYl65MW92cJLnfxOW2bYopfHz
 UGxMjwwhFWE1r/wE0GbX66TJff15Q9j6uE3VCHY7aWjb4ioSlQ9CZzaQrgg4ivGE3gg8
 hWVq7Hew3XfUsV7QT5BqU5W4H5SG9YJZGIJ2Pg9lB5idKJF3XMKdgVQWjHVidR9sKpmz
 4jfiQBp/IhRC4vmuh9pH4H+/dkWBonJ8sUhIIwY56UFBvMbk5uOcF7WXFjQk0GHs5p1/
 4w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743004402; x=1743609202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooWCNGMr+ZPyA8HOWEof7Pv4KHsW+D7QCTeak49fwBI=;
 b=ZBjvg9Oeq0Y7RfjCixHoy1KxB5AWn28jl170ngPdsvRNg0KPFLYkn/y7rwpsJ4sv9m
 r786+z2ezXEuhJsw7hKr1YWEw/44pJnnjhctXy8GbwE09wWdn5TT80DHMJx6taWEan3i
 6moGHVMKQo33tHTL4l8yWVS5MSpAkNlpjcf+kR5T1LzmBzbRMIUcnM5o88gATAwlRbUt
 JRo5s9+5XxM9PyyIvEydt2r408TCGZMCvxznTagFM0g8FJlpgf7OUmNbNA7t2zKlV5Vu
 cCmrGlD9AtvXQ3ifQLLLQX4tQrWGqwX8E8/5fOp2ZGQjR0mP+r/zxHdOejTgMDnzh0KX
 As0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkLZPs9p3e7/2a+sIKxa/MjfEG8tOdkJ5etW59LWK3ZPGTF7ZGcvZ7T3QeOPf+LU77LXVahDmW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIwOT6I+8K/TxYOobbLQQt9bD6oK1PM4QjNoYFFr/w9K/SuX5h
 CdhpxWds8Jgsse+xX8DqNVWgHW0jkunhKdC6JHuvz8qu3rAn83iEFp0sH+YzTNMc15tUNdY3wrT
 iWhGTkR9qvgIUhnU2Ma4/bC65M30G9A==
X-Gm-Gg: ASbGncuBT42TwBaCqdwsWHsRBzisSsvMxROAL9e7ez2T+1S3+Kz1KbqHiUKDwXt/7jR
 ifts9fiXI/CdCClPlPz4HAQQnGdl3Uwk0Gj6d7/vJpBLbZbRP+OFpBdLvakzqezg2lqP/HGMf+D
 Pc0CwPebDl1MgKxCQgZFmb8zK/5Q==
X-Google-Smtp-Source: AGHT+IEP5XXWFM9MEofIDJCaoUsn/BA1/z+q8W+5WeCma1ReuW0nmbvC2gOFYXgQwO/DHfVbn82Qt3KF5PAMY/yvCho=
X-Received: by 2002:a17:90b:164a:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-303a917306amr86832a91.4.1743004402369; Wed, 26 Mar 2025
 08:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250326134301.1012270-1-alexander.deucher@amd.com>
 <BL1PR12MB57532C62D07EBAE311ECB23893A62@BL1PR12MB5753.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB57532C62D07EBAE311ECB23893A62@BL1PR12MB5753.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Mar 2025 11:53:10 -0400
X-Gm-Features: AQ5f1Jo_pSQhfrsqu2L6-df9yKGC525AW8sor8mTWBgNpsyOe8TS8tGil5YYbXo
Message-ID: <CADnq5_NO7127h0do+5uBpdanhR1OdfWKbxv4gt0yteQD1qi2gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Mar 26, 2025 at 11:48=E2=80=AFAM Khatri, Sunil <Sunil.Khatri@amd.co=
m> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Gfx11 now we have same values, hence we don't need to differentiate betwe=
en two sets , only one set is needed like below.

For these fixes, I'd like to keep this as is so we can get these
patches to stable and then clean this up as a follow up patch.

Alex

>
> As below
> case IP_VERSION(11, 0, 0):
>         case IP_VERSION(11, 0, 2):
>         case IP_VERSION(11, 0, 3):
>         case IP_VERSION(11, 0, 1):
>         case IP_VERSION(11, 0, 4):
>         case IP_VERSION(11, 5, 0):
>         case IP_VERSION(11, 5, 1):
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>                 adev->gfx.me.num_me =3D 1;
>                 adev->gfx.me.num_pipe_per_me =3D 1;
>                 adev->gfx.me.num_queue_per_pipe =3D 1;
>                 adev->gfx.mec.num_mec =3D 1;
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
> #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>                 adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_funcs;
>                 adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes_fu=
ncs;
> #endif
>                         break;
>
> Regards
> Sunil Khatri
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Wednesday, March 26, 2025 7:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
>
> GC11 only has 1 mec.
>
> Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index e0a9b10d645c6..a9ef33205c541 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1573,7 +1573,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->gfx.me.num_me =3D 1;
>                 adev->gfx.me.num_pipe_per_me =3D 1;
>                 adev->gfx.me.num_queue_per_pipe =3D 1;
> -               adev->gfx.mec.num_mec =3D 2;
> +               adev->gfx.mec.num_mec =3D 1;
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;  #ifdef CONFIG_DR=
M_AMDGPU_NAVI3X_USERQ
> --
> 2.49.0
>

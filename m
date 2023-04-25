Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818BCC6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 19:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE1210E032;
	Tue, 25 Apr 2023 19:03:39 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FEC10E032
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 19:03:37 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-546db536a6bso3289564eaf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682449416; x=1685041416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ig9961WYUcq/2wSfGAxA83Q9l4QpKmV75WkGyGZJOI=;
 b=YPO1lyucYe38fADGJgLL0jOzB5xO2a/5YxbEML/LUEhqJYU+05HlLzNs/BAP6VhKxY
 QSRIi6KnQGW89QWWAT6qfK3aB3c8mGhdDylIFDystacLqKaoZs+FLxQS3M1HqNeSTEU+
 TQNSG+7iJ2pqqKifdZ13QWC2ltqgE3bqXI7zIBvnZs6uTyeANzb8dkLZ4ibaE8iQkWEq
 DflL8OGsNsv+gyUXe3K9aNUXB7P4kR1wvl4GAHtkuWbtOD/yW9vzVkWiFbNbwwdXXete
 Yb4ZpGWyctztgKKVbP3+0KoLh0uYLC6wGVwP3TxPGRd+6QCRae6K4K7VxbMgAqZErMxn
 5mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682449416; x=1685041416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Ig9961WYUcq/2wSfGAxA83Q9l4QpKmV75WkGyGZJOI=;
 b=WbQ/q0IGxOam9k1a4zG87JpELdZAYfmRlxy9Xad2xt71MoRw7Hpzj+w2hv66x9XIKq
 nXkKNtyGXriviahEvGDEjApA595Q00Tdze0h69dGfoEgeAJTFxA6SjVxMXMtL4FlyjSD
 BsnEDIi1A4/FwJrzHVa0XqmJoOBgO23hHePp24r4joZfQIvzW0jGoX9TtsDbx8n7yzlm
 5Bcpb+O3UaqSBAWg39VGFO/47c+v1HAhUi6Cuq/3+crNLK6FuQE5s8aSQdJ/O64S+U9o
 5cUuPpV5TcHKHGPFAEY5WjmquB4G4WM0fbWoWjTj2frv9novFs3u9GpdpHtfp7S2H0Ky
 i5Dw==
X-Gm-Message-State: AAQBX9fNtuUpIPjIC2VfOm+R8wjmRWVZejmzh5kmGNG0Re8aE4GNYsg9
 /fwu1R9bT07KIzFeisKyituK161P25mkRS3O3WXOa2I+
X-Google-Smtp-Source: AKy350ZZHGuce54orG0Eedw9l8g1bKVmvUVidNQueIMHwpTsU/svMdG0wPQ+tTXQTkPVB6g5sF0pu9/wfPei2Z8XveU=
X-Received: by 2002:aca:3bc5:0:b0:386:ea33:7556 with SMTP id
 i188-20020aca3bc5000000b00386ea337556mr8670400oia.49.1682449415891; Tue, 25
 Apr 2023 12:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230425185157.1736681-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230425185157.1736681-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Apr 2023 15:03:24 -0400
Message-ID: <CADnq5_PEYyHbmDvX7xE_GKnfj-dYNyYw1erbjh0W8bQXTh-cHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix style errors in amdgpu_display`.c
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

On Tue, Apr 25, 2023 at 2:52=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix following checkpatch errors in amdgpu_display.c
>
> ERROR: spaces required around that '=3D' (ctx:VxW)
> ERROR: that open brace { should be on the previous line
> ERROR: else should follow close brace '}'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 8632ab695a6c..389396eac222 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -97,7 +97,7 @@ static void amdgpu_display_flip_callback(struct dma_fen=
ce *f,
>  static bool amdgpu_display_flip_handle_fence(struct amdgpu_flip_work *wo=
rk,
>                                              struct dma_fence **f)
>  {
> -       struct dma_fence *fence=3D *f;
> +       struct dma_fence *fence =3D *f;
>
>         if (fence =3D=3D NULL)
>                 return false;
> @@ -1251,21 +1251,21 @@ const struct drm_mode_config_funcs amdgpu_mode_fu=
ncs =3D {
>         .fb_create =3D amdgpu_display_user_framebuffer_create,
>  };
>
> -static const struct drm_prop_enum_list amdgpu_underscan_enum_list[] =3D
> -{      { UNDERSCAN_OFF, "off" },
> +static const struct drm_prop_enum_list amdgpu_underscan_enum_list[] =3D =
{
> +       { UNDERSCAN_OFF, "off" },
>         { UNDERSCAN_ON, "on" },
>         { UNDERSCAN_AUTO, "auto" },
>  };
>
> -static const struct drm_prop_enum_list amdgpu_audio_enum_list[] =3D
> -{      { AMDGPU_AUDIO_DISABLE, "off" },
> +static const struct drm_prop_enum_list amdgpu_audio_enum_list[] =3D {
> +       { AMDGPU_AUDIO_DISABLE, "off" },
>         { AMDGPU_AUDIO_ENABLE, "on" },
>         { AMDGPU_AUDIO_AUTO, "auto" },
>  };
>
>  /* XXX support different dither options? spatial, temporal, both, etc. *=
/
> -static const struct drm_prop_enum_list amdgpu_dither_enum_list[] =3D
> -{      { AMDGPU_FMT_DITHER_DISABLE, "off" },
> +static const struct drm_prop_enum_list amdgpu_dither_enum_list[] =3D {
> +       { AMDGPU_FMT_DITHER_DISABLE, "off" },
>         { AMDGPU_FMT_DITHER_ENABLE, "on" },
>  };
>
> @@ -1495,8 +1495,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_d=
evice *dev,
>                 ret |=3D DRM_SCANOUTPOS_ACCURATE;
>                 vbl_start =3D vbl & 0x1fff;
>                 vbl_end =3D (vbl >> 16) & 0x1fff;
> -       }
> -       else {
> +       } else {
>                 /* No: Fake something reasonable which gives at least ok =
results. */
>                 vbl_start =3D mode->crtc_vdisplay;
>                 vbl_end =3D 0;
> --
> 2.25.1
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3F3C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 18:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 340FE10E05F;
	Wed, 26 Jul 2023 18:28:59 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1542310E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 18:28:57 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-563531a3ad2so97168eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396136; x=1691000936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUXCgeCnHAy7zyC+ckmLy83WnDmeDIT+nJd6zDJdjRs=;
 b=VsSj4UMQzgsz76VTeXQaGbs74a61lUNZYaWruaMVKnrfiVM6lN9SE04f8iC+6LRlWo
 BltWGRo5rwoCU9deTkdgYtD4FejY5yEC0WmmZKROBZwiLwI4rx00OOuAOt7LV26VYHaW
 oF0EJg2sEC8S1/QaIL1MxwWHScHSrCtm3cVM4XEzHHahfa60jJM0NifT0vT1oa7EgIbd
 tRyt++mUNl9GgAhyb9y63Gf0P4k5ozoDZIuTiaoI9G/tjEYxx1Bkrjd6/xbSmf9wxp5Q
 50VTrzrMj20NP4TIunUy0/KOg18G5fxvlNExx+FlgqDA6T+YJaspsHgCeTFrEbbesX0F
 DIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396136; x=1691000936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUXCgeCnHAy7zyC+ckmLy83WnDmeDIT+nJd6zDJdjRs=;
 b=dbNRILsG8KJZdHypTJ5v2QRp7ehjTmsY8S8whL5ZhYWnMxR5QiRAKZAgYH2acoA4+U
 3Mm0ItCk8DwcU89YH6jtkzBFNmL3bc5+eXhyPBqMBkt9k7gn2ixjrgwsZBY0GwrLeY7S
 8Ucnk0x9Y3AYx4xaIAx1OdtjweXDMsTcDl3hbA0T/fRsE6Z7uTN4/LrDNoAdoiW19I/+
 adjXY1RPFghO5jmfYvQ9tfkhnUYYyQkKDe6ufHiAO6ieK5hhbIN2fJJpbxz3Ms/21b9U
 sjTOTClyd1z5bRPL6B2tILBoXNdjEVSQCkSkp1WcENOxYCLcyv4ysNnHgvC8Zbg3+GGz
 8Cjw==
X-Gm-Message-State: ABy/qLa97V9GI9VD3Fc3caTZFTOI/4xtNxfFc4LW5/Onsi4reHfEM70n
 HWstrujlwjcJBysHObTht4SSMT4qT4koDE7SpbkWNwZ+
X-Google-Smtp-Source: APBJJlFTyAT11+hdkilSrie2w9VKzU6mGSS0FgO/ZnFTmFJza6GvdYeytDVkReDdvxqHDAYtGHFBoSLJ6lP7wT03EjU=
X-Received: by 2002:a05:6820:285:b0:566:fa3f:82af with SMTP id
 q5-20020a056820028500b00566fa3f82afmr2081211ood.5.1690396136107; Wed, 26 Jul
 2023 11:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230726145119.2482465-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230726145119.2482465-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 14:28:44 -0400
Message-ID: <CADnq5_M+DA5fu4+J29XtJ4qhs0GceQqNuUpDW=9U+cnCW+A4cg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Prefer strscpy over strlcpy in
 'radeon_combios_get_power_modes'
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 26, 2023 at 10:51=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> strlcpy() reads the entire source buffer first. This read may exceed the
> destination size limit. This is both inefficient and can lead to linear
> read overflows if a source string is not NUL-terminated. The safe
> replacement is strscpy() [1].
>
> cleanup to remove the strlcpy() function entirely from the kernel [2].
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Fixes the following:
>
> WARNING: Prefer strscpy over strlcpy
> +                               strlcpy(info.type, name, sizeof(info.type=
));
>
> WARNING: Prefer strscpy over strlcpy
> +                               strlcpy(info.type, name, sizeof(info.type=
));
>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_combios.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/ra=
deon/radeon_combios.c
> index 783a6b8802d5..795c3667f6d6 100644
> --- a/drivers/gpu/drm/radeon/radeon_combios.c
> +++ b/drivers/gpu/drm/radeon/radeon_combios.c
> @@ -2702,7 +2702,7 @@ void radeon_combios_get_power_modes(struct radeon_d=
evice *rdev)
>                                 struct i2c_board_info info =3D { };
>                                 const char *name =3D thermal_controller_n=
ames[thermal_controller];
>                                 info.addr =3D i2c_addr >> 1;
> -                               strlcpy(info.type, name, sizeof(info.type=
));
> +                               strscpy(info.type, name, sizeof(info.type=
));
>                                 i2c_new_client_device(&rdev->pm.i2c_bus->=
adapter, &info);
>                         }
>                 }
> @@ -2719,7 +2719,7 @@ void radeon_combios_get_power_modes(struct radeon_d=
evice *rdev)
>                                 struct i2c_board_info info =3D { };
>                                 const char *name =3D "f75375";
>                                 info.addr =3D 0x28;
> -                               strlcpy(info.type, name, sizeof(info.type=
));
> +                               strscpy(info.type, name, sizeof(info.type=
));
>                                 i2c_new_client_device(&rdev->pm.i2c_bus->=
adapter, &info);
>                                 DRM_INFO("Possible %s thermal controller =
at 0x%02x\n",
>                                          name, info.addr);
> --
> 2.25.1
>

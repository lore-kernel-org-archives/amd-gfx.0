Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140E5C7EE26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 16:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F12510E35C;
	Fri, 19 May 2023 16:55:04 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF6010E35C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 16:55:02 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5500d15d2f2so2093279eaf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684515301; x=1687107301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZ82SoZ2USi9QnfrbzRUmuAv8V1LnzD0EylnyGWYfDU=;
 b=RRy/TjnH5fMEeTu3Qqzr89bho0nvh3NmpwORWy0TCinQWnr7zUIpgRlRGTdET3I9hB
 R+ZZlORs6wKZ4qrdlVD7fIXLFhZHNwR+Q8Pm47Iw/J917/v2ZpVopqvsLE5AoDPHMA6j
 /y8SDC4px6H7PtX+hMy3jxu5SybdnoRTAxv49GCe1qZW+LEvIlUyM+cKS6aKYUtOi9kH
 YacKyYImx7DOVEZUiTdsz1IbOQQRPgYitFjlOAHWm48xecrKd7NbUJG8d5dzl1Q2AFNG
 RjtWpFDnir9k4qL8wPma3LDmigJDrjwo45+fHHpzmJdg5zJTY1xUVBrLRH73eOZ0CAed
 ZqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515301; x=1687107301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZ82SoZ2USi9QnfrbzRUmuAv8V1LnzD0EylnyGWYfDU=;
 b=Vlk+5/ymtIj9NSL2j6dFwa+M2feLvH4uCIJv4urQk55iZy35TiT7AbDGMEOPaC2rs4
 Ihrw+0WoTgrGDRhjF5N23h9fwv26zdL+EgSHn3wPWs9dcj0wv2nuo+RWlY/RW10Q+aZP
 U1vQCU+9+ZrxVJ5Ww7j4n7uheMP/BMfcc0RdqZGHYmOUAELqSi+dmvz3Oj7vxwGFvb2X
 MIOU+sx1WOpm/7U6xBnUwkEbl4fkOcsA+7EDoRwDC3msfH3ffvxZOVpkotBFYX5JVBgi
 YX4XwWgp06XKdLSJmAu9JQl6z9vQU7dM7sOUm9exlInlJkR8Fq9MAGMF8CRoaYIb+urY
 7U9w==
X-Gm-Message-State: AC+VfDxeVFC9/6it5VeSx2/9CN9Su3GfdDwe88NnanmyP/NvzGMnhrKi
 EkxwqbI8cTcnuFIZZngf5H53MIxKpiMdAAqHqM/uQCx2
X-Google-Smtp-Source: ACHHUZ4jCVrFbO85Lx8PdMRO9eeiMLNF0emdOsV4xLdlhPeWR/XGLjKKB8TDh7ko2ojEik9/dwMDiLxXJLceD65Ev5U=
X-Received: by 2002:a4a:760e:0:b0:550:6c2e:8160 with SMTP id
 t14-20020a4a760e000000b005506c2e8160mr1048852ooc.6.1684515300971; Fri, 19 May
 2023 09:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230519050548.4192535-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230519050548.4192535-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 12:54:49 -0400
Message-ID: <CADnq5_MCeDG8O=KGUPnYOfhLzRBKzb_fvYvyzaoK5h45ROHgsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix uninitalized variable in
 jpeg_v4_0_3_is_idle & jpeg_v4_0_3_wait_for_idle
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
Cc: amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 19, 2023 at 1:06=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:752:4: error: variable 'ret' is =
uninitialized when used here [-Werror,-Wuninitialized]
>                         ret &=3D ((RREG32_SOC15_OFFSET(
>                         ^~~
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:745:10: note: initialize the var=
iable 'ret' to silence this warning
>         bool ret;
>                 ^
>                  =3D 0
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:774:4: error: variable 'ret' is =
uninitialized when used here [-Werror,-Wuninitialized]
>                         ret &=3D SOC15_WAIT_ON_RREG_OFFSET(
>                         ^~~
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:767:9: note: initialize the vari=
able 'ret' to silence this warning
>         int ret;
>                ^
>                 =3D 0
> 2 errors generated.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: James Zhu <James.Zhu@amd.com>
> Cc: Leo Liu <leo.liu@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.c
> index ede15a3a4701..ce2b22f7e4e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -742,7 +742,7 @@ static void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ri=
ng *ring, uint32_t count)
>  static bool jpeg_v4_0_3_is_idle(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       bool ret;
> +       bool ret =3D false;
>         int i, j;
>
>         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> @@ -764,7 +764,7 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
>  static int jpeg_v4_0_3_wait_for_idle(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       int ret;
> +       int ret =3D 0;
>         int i, j;
>
>         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> --
> 2.25.1
>

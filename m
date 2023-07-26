Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D33C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 18:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237B710E121;
	Wed, 26 Jul 2023 18:29:25 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FAB10E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 18:29:23 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1bb575a6ed3so130290fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396163; x=1691000963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ySdnOu5hoyGSjnds2jMu3NvnyWts7wmUDUgtkj4wQg=;
 b=QONBJuAMELADqbM1o/nM990ZL//B3dx3GMR4ezHRxXJInDVEFyRHcNy8bSyBBTHOmE
 2VVpPR/hA47N19aj/71sPocQieV9Q6I6+JMDEwGOJqVCK/8jIOXlwzIN2wUP0VqApfPf
 J3DvDjTaUEAaRghbrBlkafuQEal3n/LLFtLqz956Z/ipLsYn7tlr1YEA6ZHpeoAkQvMJ
 kmHRzsv5P+vkzFKyBsIPJabls+COnLmsjXaBcqvhhE2N5NZGPjVy93pjS8OSsvxjzuWu
 XTeQo9iVqodC2PDQaNX+w+5MZnPZco4DWKHbdLQeqDn3DjDLErAdMiVYwNTGQZFyu6My
 FGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396163; x=1691000963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ySdnOu5hoyGSjnds2jMu3NvnyWts7wmUDUgtkj4wQg=;
 b=Hh3sVeZ//UTbkAIpzoYeob1pUT+0ixF86mRqUwOLZRDUp1Uf7b5lwVHlwHDqyBaePl
 4NeX6vWBaq5Wa5jadSQ8wn6SErnbKp+A1HHSUz0PB92ZDJ5s2BOKuEiZARIg6OM3Nlu3
 n08B1wRTdj0IRBRLBvYEc09w2TGPK/54J4dunfk1kqvHz1YGqUY81G+QrqQLJTRZrPTu
 h9WUQ2FpBRC1Pv8O7ly8Z835k8swS/UON0gIV5RFt6cLLrSwES+7gbvcRcYUieYtr5jQ
 6Ibrcg7IsFo/jTy/immOUo7Ivx80c7Md+l8aYQdIxhtdwwVnnlU3iHVGVbkLvGfZ4jdk
 ozCQ==
X-Gm-Message-State: ABy/qLYjn5SHqHzW7hEB5OFwW5zR9XWEgFtutPbAZuShB6hU5Gk5RunF
 arElGah7hbzBVLpRti34WV5mUnRRX1Lw4gb9HHw=
X-Google-Smtp-Source: APBJJlEURmy09D4k0T7d7nvYUiMgm+3SRSevnS59Kt6HbaSKpAyGxKF+niGGUO5vu04ruB9RnI3nh2mT6MtERxsKo44=
X-Received: by 2002:a05:6870:6122:b0:1b7:3ddb:aa31 with SMTP id
 s34-20020a056870612200b001b73ddbaa31mr373742oae.21.1690396162828; Wed, 26 Jul
 2023 11:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230726150211.2489890-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230726150211.2489890-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 14:29:11 -0400
Message-ID: <CADnq5_NAqZOhRPYRr1T4AJHxSdjYwevN8+KA0vKY-warz2ZRVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Prefer strscpy over strlcpy calls in
 radeon_atombios.c
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

On Wed, Jul 26, 2023 at 11:02=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Use the strscpy method instead of strlcpy method.
>
> Fixes the below:
>
> WARNING: Prefer strscpy over strlcpy
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_atombios.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/r=
adeon/radeon_atombios.c
> index 697a5989c045..85c4bb186203 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -2105,7 +2105,7 @@ static int radeon_atombios_parse_power_table_1_3(st=
ruct radeon_device *rdev)
>                         const char *name =3D thermal_controller_names[pow=
er_info->info.
>                                                                     ucOve=
rdriveThermalController];
>                         info.addr =3D power_info->info.ucOverdriveControl=
lerAddress >> 1;
> -                       strlcpy(info.type, name, sizeof(info.type));
> +                       strscpy(info.type, name, sizeof(info.type));
>                         i2c_new_client_device(&rdev->pm.i2c_bus->adapter,=
 &info);
>                 }
>         }
> @@ -2355,7 +2355,7 @@ static void radeon_atombios_add_pplib_thermal_contr=
oller(struct radeon_device *r
>                                 struct i2c_board_info info =3D { };
>                                 const char *name =3D pp_lib_thermal_contr=
oller_names[controller->ucType];
>                                 info.addr =3D controller->ucI2cAddress >>=
 1;
> -                               strlcpy(info.type, name, sizeof(info.type=
));
> +                               strscpy(info.type, name, sizeof(info.type=
));
>                                 i2c_new_client_device(&rdev->pm.i2c_bus->=
adapter, &info);
>                         }
>                 } else {
> --
> 2.25.1
>

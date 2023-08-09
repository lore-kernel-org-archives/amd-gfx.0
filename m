Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D37DEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2013410E433;
	Wed,  9 Aug 2023 12:40:28 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BA510E433
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 12:40:25 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a74d759be4so5047793b6e.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Aug 2023 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691584825; x=1692189625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbUL3BvMfqdHIuVGd1qzVon0yi9gavvOVwbJdzOYK6U=;
 b=lHj4DZ/EXOmD4gujwyY+UJl+WqB8fygXEGJ+mh4vf6qY6k1xM5fBR99ZGf7uQad+UD
 5QsSJ9U+06og5avwc00TnFnhOuT/K2ox70+mycAutbgDnB8bieC/8ZKUVTgbfDtLJMe/
 d0eF7SDt8Ja7Nm0EZ1l15qpelpVarQDvMjiA8BesotLeDMG+FmAqCQVFvU00hcaMnGSH
 muXhV1w0SLF0xWEAT7OrXRnx31DicbG/MINL0FEqau/fgDYvDUtHO50K7Zt/tW07XwRr
 tPxuVX07Lo5ZxdpHS7J8MNxTZR3otvfKmrHqiTJzG8ZLTiPmlFlJnk6fJl+cC6xHq+7Z
 LnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691584825; x=1692189625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbUL3BvMfqdHIuVGd1qzVon0yi9gavvOVwbJdzOYK6U=;
 b=IyJ/YGmnEujFuI5IJdJtKkTT+1W86EShrT6Y8KdtdgbiChdw4h/I+pQYpW7BaY3fAq
 Kb55t4agd/X0Cg9qaUi3UzVSKsJDjs+Wi+cN9IPV0RGtZaVQLAobz/eDbz1TJ8iqBV4V
 StBnNvTkob8PcHfjc37W+tiSRCQhQ3NniNIo3t38La9h7OKDxkRkcl+lT58+KNR/nIJT
 Q1Fly45cOA+WVWdKtJC9MU6BnAOK46Eb72dubui4wdRhEdcbwiFL2w8o+AuPUygJCNjX
 LnN1PJaMvMITd7eI8Zto/cKtXCaXfKXioOTXs6Xeg4qacm/WfghqX4MtoLd8tUmOZSAw
 px8w==
X-Gm-Message-State: AOJu0YxS4JpjRV6J1+f+o7DfEj4VVe+ZauDlTgdj7lsmvphOI7RqDKQU
 de1Jh86DIAgiC2pBlFidS8MpVIr6Sc87LZOMDec=
X-Google-Smtp-Source: AGHT+IEnlYwg8ZcJxyOqvGaTSxrxciVxM7tqmQ4OgKjahhAC6g98OvOQHR9So/VPYTnrggRbUPOKrokqeH+uhB2CHsI=
X-Received: by 2002:a05:6808:218e:b0:3a7:2efb:cb71 with SMTP id
 be14-20020a056808218e00b003a72efbcb71mr3320227oib.25.1691584825118; Wed, 09
 Aug 2023 05:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230809095006.253119-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230809095006.253119-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Aug 2023 08:40:13 -0400
Message-ID: <CADnq5_OdX=HUfxMhqg9hFSn+VbjNoX+vH8LtcY1KRpZrnRDXfw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix multiple line dereference in
 'atom_iio_execute'
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 9, 2023 at 5:50=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following:
>
> WARNING: Avoid multiple line dereference - prefer 'ctx->io_attr'
> +                           ((ctx->
> +                             io_attr >> CU8(base + 2)) & (0xFFFFFFFF >> =
(32 -
>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/atom.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.=
c
> index 93acb0e42bd6..ceb6d772ef94 100644
> --- a/drivers/gpu/drm/radeon/atom.c
> +++ b/drivers/gpu/drm/radeon/atom.c
> @@ -163,13 +163,9 @@ static uint32_t atom_iio_execute(struct atom_context=
 *ctx, int base,
>                             ~((0xFFFFFFFF >> (32 - CU8(base + 1))) <<
>                               CU8(base + 3));
>                         temp |=3D
> -                           ((ctx->
> -                             io_attr >> CU8(base + 2)) & (0xFFFFFFFF >> =
(32 -
> -                                                                        =
 CU8
> -                                                                        =
 (base
> -                                                                        =
  +
> -                                                                        =
  1))))
> -                           << CU8(base + 3);
> +                           ((ctx->io_attr >> CU8(base + 2)) &
> +                            (0xFFFFFFFF >> (32 - CU8(base + 1)))) <<
> +                            CU8(base + 3);
>                         base +=3D 4;
>                         break;
>                 case ATOM_IIO_END:
> --
> 2.25.1
>

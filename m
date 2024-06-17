Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BBBC27C79
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 20:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363F210E4E2;
	Mon, 17 Jun 2024 20:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WZNkqePv";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC07610E4E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 20:10:42 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-70346ae2c43so2070288a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718655042; x=1719259842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ued9Hjjt2XHPnLpyc9r6l0QLm+ARBsk9poTUKlHfE6E=;
 b=WZNkqePvh2yuCJO4ucO4TL8YBvPDE1MGUtvBYn2HDPuzPOCM5oQGnCvaS0/g9kehm5
 9PGlYS98Zhop+PxiyyfJ7WVh4E6lW/tDAXsGt2cSFH8p2vAj2/gC7lOxhNO6z7lp5qr/
 LOFPn8wVxqDcHg1hh7oSS+PuheoFm9XF0k2CIN1QRaMZA0ijz3egeveFKi+41pZakpb7
 8b5+X9y4Rd6EjlImxBDXiGQlxJ1E0HYlfjRYspedhycKc7lXk/CXlEt/KUSghWYi9NPl
 JwL+7qcgIX13xhdZ9CmWTberwrkVhSBLf4HV6gBDIQcsUV4GhOhIwpkyQy9yDXU7KHt6
 4+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718655042; x=1719259842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ued9Hjjt2XHPnLpyc9r6l0QLm+ARBsk9poTUKlHfE6E=;
 b=XxYvrurPQaZCxhSz95c61l+edQQ1VOo3+NjmEO+EKQue7aK+MP1YvK6gxW4Ht9QjGO
 SeUmDLhd1yVOaKWL7Mkmpk1FLLOrN7DS07FDqDj3DToEV6Cqv07hljKjCjfSmQe/0iKZ
 E5g4tplg6FD5MjE0gI3VjSi2wak3WeXPfMcHOII/TNunIp/Il6P4CSFVTIdA+LVZ9a/x
 hVUD+5Hp5YlyzPjkmWMSqSinIRy7nA4UltdFZtidZDlnTaWOYpujnN2rrG3qxlNO+xnn
 nnU4CQwmK+Vz0Mb4OsojhJBrFbYmXLo2QLrqvROzRSzzBYpnItBuikK09NjE9u9blA+E
 DbVg==
X-Gm-Message-State: AOJu0YxY9DWcF5CZZI9LXmEEB9mh101Bo1X5DJbgV/rgSWVZgzV3IXRm
 pw+uSsl6iljY4FOTKzFv6yksMWlyGNsyCMLHawCk3sQqMWHntBmh3nuuoZ2P5Jso+28MoL6tXiU
 nwxWK8frRqxQMNI8Ee8vx1eUOhOM=
X-Google-Smtp-Source: AGHT+IGHhnKxuf361xbZ2iELJVwcES7K+adPCEKidZakrU9EI9NiLixZ7gcljCZHSMde1/h2VSKWdY6JO6cFGg7eUgs=
X-Received: by 2002:a17:90a:7189:b0:2c2:d6ca:3960 with SMTP id
 98e67ed59e1d1-2c6c9df1e57mr884194a91.17.1718655041898; Mon, 17 Jun 2024
 13:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240617191428.3039656-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240617191428.3039656-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Jun 2024 16:10:30 -0400
Message-ID: <CADnq5_Ojbc27+vBx4yXDhR83911efXTza5aoxKqhAQHy5dpg3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: init TA fw for psp v14
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com, likun.gao@amd.com
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

On Mon, Jun 17, 2024 at 3:14=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> From: Likun Gao <Likun.Gao@amd.com>
>
> Add support to init TA firmware for psp v14.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v14_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v14_0.c
> index cc0248efa6b6..4d33c95a5116 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> @@ -32,7 +32,9 @@
>  #include "mp/mp_14_0_2_sh_mask.h"
>
>  MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
> +MODULE_FIRMWARE("amdgpu/psp_14_0_2_ta.bin");
>  MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
> +MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta.bin");
>
>  /* For large FW files the time to complete can be very long */
>  #define USBC_PD_POLLING_LIMIT_S 240
> @@ -64,6 +66,9 @@ static int psp_v14_0_init_microcode(struct psp_context =
*psp)
>         case IP_VERSION(14, 0, 2):
>         case IP_VERSION(14, 0, 3):
>                 err =3D psp_init_sos_microcode(psp, ucode_prefix);
> +               if (err)
> +                       return err;
> +               err =3D psp_init_ta_microcode(psp, ucode_prefix);
>                 if (err)
>                         return err;
>                 break;
> --
> 2.45.2
>

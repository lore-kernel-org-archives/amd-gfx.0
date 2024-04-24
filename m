Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01666C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 03:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDCB10FAD6;
	Wed, 24 Apr 2024 03:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lGLGnXN1";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D090F10FACB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 03:34:40 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2a78c2e253aso5055228a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713929680; x=1714534480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAERnY2/S8Y6lDVNTsB4y2IXwrULC2sflxt+5Tj/iGI=;
 b=lGLGnXN1LAMZXNBgpsPxukEOWQeA0n9OO51CJODJsyvkFM28RjX8lGuDGc07aBKyqM
 6q2agoWemgUp8OMQvL9mEQMJ/4I/RAsAo9/7WABDatUX9b0HfdXduyD9n8ySrXynraeU
 dWyQ3pie1fQhieekP4GqlZWoY6tTXXiAnT1ZIDgzH+/Bbg0r/Y9+OaQR0oIDPk9ibt81
 PLi+CT4Q02FB8RYeOWppudmghDLoDdilqk9GkGZevNakB7tAPPokgtZimz+YqGYXs4Q4
 cevgyE/ASVL0pfkADdpK4M8TvDU94fLzuAX8d/1usJ6A3/FgKDeBA1YK+L5tORY1+PLV
 pnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713929680; x=1714534480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAERnY2/S8Y6lDVNTsB4y2IXwrULC2sflxt+5Tj/iGI=;
 b=JRawpLnG9Ue1e6crY7Thvm5F6Xh8zbKEjEvFj1K3fV0fmUNnaU8w7O2xcDgqAutSD8
 MbPYhv0CAXExvuMBw/zsFAH4lIU/7WTqjdh+J+fQcZTATtOnNVJkkSdWde1FpJ2DwgTO
 j3utIJxGXUHaJ6OH5b7ScluwQt7EL1u1S+DoGO1FqjMztDpTgvYXtQOa+6FaaerQu6ab
 eg2a/yJAiAiVRH2DN5CJBRH1t8QO/0Al+2P+1bVh3bZjD+he1acmyvh1ESt98ZHAq5J7
 bIXIG/VDC9ZAA2KD7DY1BozaDXeNXI83lqC3PA/cG+giOYXhILBJsi+bBVoqeeJzrlXe
 x52w==
X-Gm-Message-State: AOJu0YxSYzjTi7UmaoQuruaQLSl1+h+gmzjFRX+StP3WpIEm9gTre/D8
 4Ft1e5NC4xFL19tsl7HO15aTkgU5PZx+X8HGecp1Ja52mFs1Poxh7dCYGaIO7k83DBFrDIh4ASg
 YEp3sPB6xLqCcUBrEtR6dkiPUo57pvQ==
X-Google-Smtp-Source: AGHT+IGEO5qp2P60KmiWqkXmiikNTpVw9AVeKRUSDEnnSpzIFoTaFS9GbHxJ7s6hrcZxXLmmwycgEIAnHULqOZC1Rck=
X-Received: by 2002:a17:90b:4c8e:b0:2ac:5a93:636b with SMTP id
 my14-20020a17090b4c8e00b002ac5a93636bmr1125519pjb.2.1713929680156; Tue, 23
 Apr 2024 20:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240424024934.727489-1-jesse.zhang@amd.com>
In-Reply-To: <20240424024934.727489-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Apr 2024 23:34:28 -0400
Message-ID: <CADnq5_PTVB-rB9NiMozTyjoBpHTe-WM29-9nmWoZT_n8ybk8qQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Initialize the last_jump_jiffies in atom_exec_context
 before it used
To: jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, tim.huang@amd.com
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

On Tue, Apr 23, 2024 at 11:07=E2=80=AFPM <jesse.zhang@amd.com> wrote:
>
> From: Jesse Zhang <jesse.zhang@amd.com>
>
> The parameter "last_jump_jiffies" should be initialized before being used=
 in the function atom_op_jump.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 72362df352f6..d552e013354c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1243,6 +1243,7 @@ static int amdgpu_atom_execute_table_locked(struct =
atom_context *ctx, int index,
>         ectx.ps_size =3D params_size;
>         ectx.abort =3D false;
>         ectx.last_jump =3D 0;
> +       ectx.last_jump_jiffies =3D 0;
>         if (ws) {
>                 ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
>                 ectx.ws_size =3D ws;
> --
> 2.25.1
>

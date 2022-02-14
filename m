Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1C2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 18:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4124610E28E;
	Mon, 14 Feb 2022 18:26:08 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE47B10E28C;
 Mon, 14 Feb 2022 18:26:06 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 t75-20020a4a3e4e000000b002e9c0821d78so20382839oot.4; 
 Mon, 14 Feb 2022 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QlSvtvFbST+JRiZy0nw8qsurosZlPyiaBzL4u9A7NPg=;
 b=HXqACW//Zm0115qK79VxKxElAYlr95AzBf3cBr6QuimTb9boq0VaCrFqwmZvXHTKI0
 wKgj5UvN50iY0OiyrcX6/VJPFTxIBdus86P9uDgMpY7COalhtCiMDuUuNkmlHbDOMFVb
 7c/d/mm4z92AXKDl1cngznbb7e/JgfyeqwLfiV4dnWnr9nBwruWYPE1VizPeGLJfYvWI
 7NwGpT7iZsmEYd4jGbrlyV5wgk4jv2b7smJtuJ3GDbWT+eRbKGnewN7kUrlHZD7B1AEI
 Oiq83ESXQFphER2f1zpQGtfPQD7KZuYuCSsMt7OAkw/q8fXEk03RR3RKro0Ww3Cc5fwz
 yx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QlSvtvFbST+JRiZy0nw8qsurosZlPyiaBzL4u9A7NPg=;
 b=zUl4swfZLe69G0mQGxpVOWQ+ad5ccDaUWoOBn6f1vkJI64bGMWFSQZifQzX9t6cuj+
 e44jVhZntz4swulBjGw85CT89uMMW4B6h5GVx/Sxp/gTUSfHzkGMb+3qwNeflsxXO1NB
 Ub0CHEjHZQy+VYBz1NojQU1+ISMzJKgUX+U2RQJBUEyoLpGevrCxP4SnsB/EXL0ERlcJ
 QcxeEgbbj9nuKFPRbq4iU/lmDT752W9grxmJ9ytfQUhrPquVggXKEfO5xZ7WwEAGDQb/
 yITQwUt36yhpHNEDzyy2zkt5AnJGTLCFRa77nAihyk4bASN2Q/XhjQ+9INkBjQ4Yx8eh
 jb1g==
X-Gm-Message-State: AOAM533fgonTO6GbdJSX/i4NLmkPEg7MBN2j/fAAozsyRTBuZejq1PgC
 vVq8oGr+5AsPdNgE613pKVN2ctmvqwItK6V+pWE=
X-Google-Smtp-Source: ABdhPJwwkbSacvGQlLKe3Ok3VHnEV3xZS3SoGcqpH7A0COkvlXN8wexYw97Y95QA9d+schJeyBmufa9z8v8pu+r/cg8=
X-Received: by 2002:a4a:d583:: with SMTP id z3mr20564oos.68.1644863166025;
 Mon, 14 Feb 2022 10:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20220214182224.2906060-1-trix@redhat.com>
In-Reply-To: <20220214182224.2906060-1-trix@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Feb 2022 13:25:55 -0500
Message-ID: <CADnq5_MrrTXmVPv7ukkpq-+WWn7cKbF9CHjhsBnuRzqbriUN1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check return status before using stable_pstate
To: Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: llvm@lists.linux.dev, Roy Sun <Roy.Sun@amd.com>,
 Dave Airlie <airlied@linux.ie>, xinhui pan <Xinhui.Pan@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 "Tuikov, Luben" <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Quan,
 Evan" <evan.quan@amd.com>, Christian Koenig <christian.koenig@amd.com>, "Xue,
 Ken" <Ken.Xue@amd.com>, "Nieto, David M" <david.nieto@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Feb 14, 2022 at 1:22 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this problem
> amdgpu_ctx.c:616:26: warning: Assigned value is garbage
>   or undefined
>   args->out.pstate.flags = stable_pstate;
>                          ^ ~~~~~~~~~~~~~
> amdgpu_ctx_stable_pstate can fail without setting
> stable_pstate.  So check.
>
> Fixes: 8cda7a4f96e4 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 1c72f6095f08..f522b52725e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -613,7 +613,8 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>                 if (args->in.flags)
>                         return -EINVAL;
>                 r = amdgpu_ctx_stable_pstate(adev, fpriv, id, false, &stable_pstate);
> -               args->out.pstate.flags = stable_pstate;
> +               if (!r)
> +                       args->out.pstate.flags = stable_pstate;
>                 break;
>         case AMDGPU_CTX_OP_SET_STABLE_PSTATE:
>                 if (args->in.flags & ~AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK)
> --
> 2.26.3
>

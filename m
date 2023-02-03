Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C360C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C4C10E8B5;
	Fri,  3 Feb 2023 19:29:12 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712BA10E8B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:29:11 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id s124so5054236oif.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Feb 2023 11:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+c2rC4WoITAWTmSebzf+VuW/gWLKWQQ+GJlxiA10cbA=;
 b=I8QW7uqVGR1aQUErleXOSL2jnOPQgMSXW2stfKF5DbDsqCFcIQBtckgM58GlCGUpq/
 7kfHWRV8/78k41gUrG/A0RKgIxV5lZuTYTU/6Op3V/ZRzQZgW/wnmFQanhKa7PdAzsMO
 5RMjlRMM+6XVy8rY6xUFh+R3emZMRkOCutno4vp8w7O4PHiUJs7/g1bBPeZYHyproQKj
 sXzikPMN4Xr5HxRGDEGqLD8+BXRV0Van72Ip1esU8wxTycSFdZuefJtrujXB2nPsfKfB
 zpA+Ios5l6tHjch4IiXM/N4rPaTXZzrjOFwzDDvJDhrHO5RhD3NWoPxJSxIB2NnRk9Xb
 9S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+c2rC4WoITAWTmSebzf+VuW/gWLKWQQ+GJlxiA10cbA=;
 b=zDtZtIpvxPpOYPfZR6YWWfi9Kd7Ho3JtHwZK+whoo0gHS5IvGdvSs4ft0z07/VXGiY
 yjDw5pPfxgG0F3Cs0FAxHc60iL9EWNh+dDmbSAVowO03BDgqanLthO/Gq/p3R5sLbTHu
 Jv9Q5CMXV/XjuxLZ5LMx4/sjtC+Bh2mOT7fpINdE33tCVZARsU5foI8fqYloY3UIeKPD
 WbQbF3/Me3jgofHECIZA/jfn3OVrby23jeAPQrfPMQjaLlek6WmPc7StuUYjI/+6boDA
 d/3SGCMVxzKSfTcnO07XDHVP+znGee2pfHV3fEZgo/VW93zlVtxeB7tu3qe+/u5zUcRc
 gSmA==
X-Gm-Message-State: AO0yUKVmvdviwg8CZwOWtBONPnhfh6gT+2G0MxYCOJim7n/sh1/Cv7kW
 P5z5X9pahUNCRL42JinUBIRCtI2t8vOuSfgQ2opqQPXZ87k=
X-Google-Smtp-Source: AK7set9a4VXnFaGTvfUwzDBo1uxWfTf+T4erdCu1iO4+DAfMYEOhsR0cdkxz0Hnd1c8qpEnqlEDEfK7MMAj3e1kcpEI=
X-Received: by 2002:aca:e1c2:0:b0:35b:d93f:cbc4 with SMTP id
 y185-20020acae1c2000000b0035bd93fcbc4mr463745oig.96.1675452550561; Fri, 03
 Feb 2023 11:29:10 -0800 (PST)
MIME-Version: 1.0
References: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
 <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
 <799644ff4daab0ac75f571870db2950c091300d7.camel@web.de>
In-Reply-To: <799644ff4daab0ac75f571870db2950c091300d7.camel@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Feb 2023 14:28:59 -0500
Message-ID: <CADnq5_Nk4PW6JZzfB10HP8xKqgk_fAwZQKNSEA5TUoEpBUCYhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix memory leak in amdgpu_cs_sync_rings
To: Bert Karwatzki <spasswolf@web.de>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks.  I forgot to add it to the commit when I pushed it,
but for posterity,

Fixes: 3bd68b32c911 ("drm/amdgpu: fix pipeline sync v2:)

Alex

On Fri, Feb 3, 2023 at 11:53 AM Bert Karwatzki <spasswolf@web.de> wrote:
>
> Here is the fix for (send again to test if I can get it right with
> Evolution)
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2360
>
> From 6e064c9565ef0da890f3fcb2a4f6a8cd44a12fdb Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Thu, 2 Feb 2023 19:50:27 +0100
> Subject: [PATCH] Fix memory leak in amdgpu_cs_sync_rings.
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 0f4cb41078c1..08eced097bd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1222,10 +1222,13 @@ static int amdgpu_cs_sync_rings(struct
> amdgpu_cs_parser *p)
>                  * next job actually sees the results from the
> previous one
>                  * before we start executing on the same scheduler
> ring.
>                  */
> -               if (!s_fence || s_fence->sched != sched)
> +               if (!s_fence || s_fence->sched != sched) {
> +                       dma_fence_put(fence);
>                         continue;
> +               }
>
>                 r = amdgpu_sync_fence(&p->gang_leader->explicit_sync,
> fence);
> +               dma_fence_put(fence);
>                 if (r)
>                         return r;
>         }
>

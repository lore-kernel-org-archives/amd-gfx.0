Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD6BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 03:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5668410ED4F;
	Wed, 11 May 2022 03:41:00 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67FB10ED4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 03:40:58 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-ed9a75c453so1347204fac.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DUw9FZ9uB+N92jwzCm+5DrjN+PquHfP0sRx8vo5wLOM=;
 b=cMprRJBtsJz5QrBwyYbAw5Rl3AHdmnDZgY/VHtDZT1FBlNuB+aN+GKONPDFVUulRo4
 EGtW6f5HK7RI6M3Oo5K1el55bbSfHNafxOjd7mOSEHzij3f5B17xs4M68mhQBjZpyqNr
 sWbGOMagGUTEfywiaCxDBQWdV/DsK4iSO86lx2oesI3dkwrmuvlMzUXQdYBe/7PUVzJB
 Qpg+jc3O5pbTWdEtwQWJZZog1ycbZLxzU/lHLp67SI/oeKAkeXdvzEjF0LRw+P46r/Hs
 h73UCOl+O4TwYyRKivPHghN0tKGcG52DnwIb5ysqL7x+l/IRDBiWxGOxUZ5sn/2DSN9Y
 U4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DUw9FZ9uB+N92jwzCm+5DrjN+PquHfP0sRx8vo5wLOM=;
 b=jY9ZXZb0h/Sx7mFtCOkp9EZFN92GVQyEAQClFgvZCdlKhCpkpifL1i16AR18yMR3x1
 jyhjaZJhbElua8VIgvsY3qt4UR733gUSkT3ybzjnXeXamspyumV29JHzZgLEiRgpoCf8
 Wu9sbOzwMVJubtZFP16+t/XHNBDhuuy6KzA0ZFf5KMUcg2qL1wOsuRL3RCIv37kZLzLs
 LOp52bmzdkrwurDEXqYX88Eub+yuqZV+s6rq2r0Wk35lrMzkcTcERxBXhvrSnPYuxELq
 1drUekUDycLww7lwbq3PtUiG4fEwYbdKX6A1rjj49JxfQFY10z2cxK/KibegS5w3Vu1V
 0RPQ==
X-Gm-Message-State: AOAM533cci1h2g5FPdHWdwpuiEqBNO2fHnrLN3CmtKzc58eMJtoXGsfX
 cCmXrAkQACLR06nUDUgltAWl783rwNf3NftdqHA=
X-Google-Smtp-Source: ABdhPJzvlXWdur4ZWg202/AwXVt0+ZiQy9DMvYc8laIL8yk26bXmS7/q1HCmF+3CtH0RlC02uVYB7GqfRbRla3DXKPs=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1671739oaa.200.1652240457915; Tue, 10
 May 2022 20:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220509200335.482514-1-alexander.deucher@amd.com>
 <b6dd6b0d-306f-c84f-af4d-5015030f1aaf@amd.com>
In-Reply-To: <b6dd6b0d-306f-c84f-af4d-5015030f1aaf@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 May 2022 23:40:46 -0400
Message-ID: <CADnq5_M1CUziB6Cbo=MtAy_0aYJteWVEhJb4rvYAQCRGyTv9UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user
 changed it
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 10, 2022 at 6:24 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 5/10/2022 1:33 AM, Alex Deucher wrote:
> > Track whether the user requested a stable pstate via the ctx
> > IOCTL and only reset the pstate on context destroy if the user
> > actually changed it.  This avoids changing the pstate on contex
> > destroy if the user never changed it in the first place via the
> > IOCTL.
> >
> > Fixes: 8cda7a4f96e435 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 +
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > index 5981c7d9bd48..e4b0c6ec227c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -330,6 +330,8 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
> >               adev->pm.stable_pstate_ctx = NULL;
> >       else
> >               adev->pm.stable_pstate_ctx = ctx;
> > +
> > +     ctx->stable_pstate_requested = true;
> >   done:
> >       mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> >
> > @@ -353,7 +355,8 @@ static void amdgpu_ctx_fini(struct kref *ref)
> >       }
> >
> >       if (drm_dev_enter(&adev->ddev, &idx)) {
> > -             amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
> > +             if (ctx->stable_pstate_requested)
> > +                     amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
>
> Why not have the check inside amdgpu_ctx_set_stable_pstate - if current
> stable pstate is not the same as the requested one, then only switch. If
> the user has not made a request, it will be NONE and the call doesn't
> have any effect.

Good idea.  New patch sent out earlier today.

Alex

>
> Thanks,
> Lijo
>
> >               drm_dev_exit(idx);
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > index d0cbfcea90f7..f03e842209b8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > @@ -53,6 +53,7 @@ struct amdgpu_ctx {
> >       unsigned long                   ras_counter_ce;
> >       unsigned long                   ras_counter_ue;
> >       uint32_t                        stable_pstate;
> > +     bool                            stable_pstate_requested;
> >   };
> >
> >   struct amdgpu_ctx_mgr {
> >

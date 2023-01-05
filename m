Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F7BC4708E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 19:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4754910E130;
	Thu,  5 Jan 2023 19:26:58 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B505810E130
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 19:26:56 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id v70so32820339oie.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pp4m0RHxwoXOVFS76KS4NuS9ORz/9jwFGLp7h2kW1Io=;
 b=QYf6PyYxrAe9dTPi4oNYG4mOhfyWs9XZscFrLoXBr4iKY8mIOa3cJwoouLG8jdWEjz
 NlkHpDpRHVhyPX+HmPDGXpOGYuuOTyuaDFEu5qi4mvEixwWbpj60xz2yZx/G12pXOLxA
 gEDKzYoicnD4neNTLDWaPi1TKXh+rLs4+G76oFwVe/HiDsW52qBq3qbqAcDeOqkEyQzL
 KdlFyv6Hu6n2zXSQ591yCcyJzV37KlWOgiVMQTfBWiyX4Y0IvrnhldiOAiA/kMiK21UY
 rOHlTOOlCr+4mjK1GLQ+hlRsfhmrYy7jku8mupygfhKq01EfljFjLQPB2WetOvTSZFOA
 ePQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pp4m0RHxwoXOVFS76KS4NuS9ORz/9jwFGLp7h2kW1Io=;
 b=kpGEwjrZGFcQFLlUOHDa8w2/aHnSLgdpcijdiGawT/W/av19aVUAYgEUE6boCwO722
 cwZekcF+YbewQ9hIgdIGm55KvXJr/nb+ahC+KXLuFLzL+bvt+s5mOfEwuU5tpmKGEaDl
 plzDrvQpz5/6RN0FV7c5YBDWSunr3USs1pVJP+TJ88iMhqPeI2mkiuOm1GCXhB9Ckuuq
 BFDLXaN9CX6zajGBBGaBSCt/ZNkpz1vG1MTrI6lrYU91decC47LUFDGC6JfAO9O4F+Iz
 NhbEg88CJVSKAtA0TMsdJ2iEq9GD+RmjKCvgttG5Rsaw0dBv757NSALAEQPvKfJDZry+
 KWQA==
X-Gm-Message-State: AFqh2koRjBmLSHwZicv4vPM1MeQcWLz2gi+2PU/5IltRv8xcht0YydCs
 fcZDQh9niqXMFG9QxdgFLjBGFPF3QuSmgwKiuoM=
X-Google-Smtp-Source: AMrXdXviLLNoxj/xaOGLhL4NO42UgVKjk0Sx1K5dY7kX3LSASe2FpCVpLeoHvYCk6Nx2D3wEJ04w6hCMAAR1TLPGKVU=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr3480876oib.46.1672946815847; Thu, 05
 Jan 2023 11:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20230105111703.52695-1-christian.koenig@amd.com>
 <20230105111703.52695-2-christian.koenig@amd.com>
 <CADnq5_OdokG3VZxp0FE-zbvBoLiZcWQkxhcHCwa7ZMCvx2FkOw@mail.gmail.com>
 <314b034f-e152-90b4-ce98-f5692f72de79@gmail.com>
In-Reply-To: <314b034f-e152-90b4-ce98-f5692f72de79@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Jan 2023 14:26:44 -0500
Message-ID: <CADnq5_O6+C=FoL-L106t=_fUs53f+XAA7Uyz8p1=c6bctY3Yng@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix missing dma_fence_put in error path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 5, 2023 at 2:11 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 05.01.23 um 17:50 schrieb Alex Deucher:
> > On Thu, Jan 5, 2023 at 6:17 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> When the fence can't be added we need to drop the reference.
> >>
> >> Suggested-by: Bert Karwatzki <spasswolf@web.de>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > please add:
> > Cc: stable@vger.kernel.org # 6.1.x
> > When you push this series.
>
> But none of this is in 6.1? That are pure 6.2 changes or am I missing
> something?

I thought patch 1 fixed an issue in the gang submit code which was in
6.1, or was that fixing an issue in a subsequent change?

Alex

>
> Christian.
>
> >
> > Alex
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sync.c
> >> index bac7976975bd..dcd8c066bc1f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> >> @@ -391,8 +391,10 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *s=
ync, struct amdgpu_job *job)
> >>
> >>                  dma_fence_get(f);
> >>                  r =3D drm_sched_job_add_dependency(&job->base, f);
> >> -               if (r)
> >> +               if (r) {
> >> +                       dma_fence_put(f);
> >>                          return r;
> >> +               }
> >>          }
> >>          return 0;
> >>   }
> >> --
> >> 2.34.1
> >>
>

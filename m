Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D09C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 20:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE7C10E2DD;
	Tue, 14 Jul 2026 20:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jSeR5koq";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4830D10E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 20:41:45 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso12925435ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784061705; cv=none;
 d=google.com; s=arc-20260327;
 b=Fqzr4w8KFgwUQDUaPEt+jnvXw5MapmksxptaUFD62hjA6CvfoKrLKETWpQxV/WB+1Z
 P9fPyCuyewtrTWdowrEGAdEU+l5WINvCNdX9xw0SymEMoT70pRHHiKalLnF4WuYs/c3h
 Twzuj4QKgRmB1GpAEQfFi9SxI3m7FgH0zbDRm84tKY9vHQpUozaKc/wERpF83gcYddj/
 YKbd28yHMpQYrNk9anF/KR5cfSVZNnSFs8TiqbpVApXrMml8SaWA+Xy4hEUriTigf+ai
 ng1zXqzc0rITMKuaz87HZJa72BySAYrvy9e12ifSr19hDOr6n9XICM9H68jCWjaNL7zt
 KXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W+PxbBBZalAYGJKUUzZJsM5a5f98lOvvT3uqUZh6QZ8=;
 fh=h0F5qZHkRZWyQweyZrdNBaW8aebJqCc6h8nbGtBY/ZI=;
 b=GbUTDe5vfZy/6P5lh/KeUZ6H5HtudDual04AktOKv1ywjuRkLzGXyNioT/W83FP+Af
 zc01Zk2A4nWEkRsYKwDMMMCbfKexULy/RWOXgr5dGZnAsYRbqpMC7Gn0HieMhAgJjNhV
 x1fCIjVbUWJFJKFunQfFBjKCeMhNDYav9UjxjyeTZR0lZAI7mm1uf6uPXdSY5FxjXO5G
 zrQusCGJExwCBIUhJUpO255fJiuK8mI41rEISAiyA4Kp+yJAma8ptFSzfNRJxhGPsZg8
 u44JYJPrf7Z9YYEYTVXVl7gfAdd74jXxZ0bZnI0RIvjou0NBOH5AJ8bJuNJb3dJzSyZz
 smcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784061705; x=1784666505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W+PxbBBZalAYGJKUUzZJsM5a5f98lOvvT3uqUZh6QZ8=;
 b=jSeR5koqAfeJEzN3CTEuATl5JriBk7dKNEBf12WkBuWUAt+HfBpDQcZl4cT2in8e/R
 QVpWaC22ClM1kE4Q7rw1l3R+fMqxktOJeW0M/p1R4VUoOhK6VEpspRCcJsQFQw29fB43
 EC5DVbnmmFck5vsG6Sb3JBHMWHOOjU3PcRlgu3IQklY71MA3+xY57zQ1gJfZ8eXGyrK6
 bgzYIu+9Czwkiu7AOKeQ8v0DjCekIALU/Iu6SxzAvQKlkDctnniX8pcNDNCOniM/FrxT
 t/xii3duzUSgc8f/IvOAD3oJejm22a+mXGLYBqUQt0p1RBoojllQxvOkApJzmn2sL17o
 Sstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784061705; x=1784666505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W+PxbBBZalAYGJKUUzZJsM5a5f98lOvvT3uqUZh6QZ8=;
 b=hBFQ5OqKG1fnh0y3zx7gVNsjDIo0CfintqN/mUvcU1t2oeNb701LunPnuM5q1QNRc/
 6c4f2C0zCN/LvMhkNcA9Mzwb5ccISVsKROkOLH7Lc5kzPv9gKSbkzKP3WzuVUdqGr0kY
 J+N+biLy4yKDNOA13fDsjYDvkEvCjDXgqzyy8Atfsf2YXn/Jala/4qF/TPL/YgZJr8YM
 yB6PmevgPSwW8mm9IsUndIAV7SC4AOZ/BhcndMuHJi/bJgxZtv8zRBJSRA3DVvCB9u8u
 QzN+wsfkxrqYG0mbuH14bghXq1cqpMIcdhLRRmmgGaUBp5quqcXoYnlbNuyTzy0lzWuH
 EJVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXqF1bqyceRTjSyzo0qqJJopEhMg21pJJB4fFSeRdVk0fbRPYqwLA3erji+cuMzgTa6KroEn8Z@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8vKGKX1rR9W20ycPCokItgaSQ56xSfWwNyVk3fHky1dLFxP3w
 ogA0Y7UNbNZwjJgx/mdIBArHNGNZo9luZWd2IqklAUgW6fMmDDTIeAxG0+UdMv83DGdDPRRh+14
 Hu7Udk3XNJQNtEd6oEiC2u9gZoAoKoCCYyg==
X-Gm-Gg: AfdE7ckAfS52HFGqi4noO8oW9gkojTUIIVwmCdVzKo61KtLJ5fMRE4NAF/2UgXP3M/H
 QbYwLJB/KtMdHtCtshryuebyNOFnlG0YFzhpr8gc57eGzsAn71GRTrvW6MYBH96bGYaHw/sEU41
 qMYp2M2clm7cDclBtKr3czb3zLMbJjsZ4Q7gQl68QSLxpv87Ee5wquj9rjhkiMGRn4qKC5hxnMm
 bSevmmCnstceOPNjmLYJcCF783CtQUj8hLEpHc3wpHazH9fYLvGzf5seM7QJ2ZocD9ZvaHyMZEW
 sgqP79CZMHh3SWfOfXcLoYq+s7VJ8IsRu/i4RP84LG6EVbAjPX+wQjhM8dA=
X-Received: by 2002:a17:902:ec89:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2ce9e1c7c46mr118841665ad.0.1784061704766; Tue, 14 Jul 2026
 13:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-4-timur.kristof@gmail.com>
 <2c920253-9bbc-4057-b5e0-15414220a52b@ursulin.net>
In-Reply-To: <2c920253-9bbc-4057-b5e0-15414220a52b@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 16:41:33 -0400
X-Gm-Features: AUfX_mwTZI2Dq2FOhHzRkyWmGJCz6A9SK0of1DMgxKwYkDnfVSiNB5yrgo3Lo0Q
Message-ID: <CADnq5_M9hwLQw8YMqEebQ7q_kYLx2KKetZJFrszGOiOSYio_dQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/amdgpu/gfx7: Return error code when compute ring
 tests fail
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>
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

On Tue, Jul 14, 2026 at 4:14=E2=80=AFPM Tvrtko Ursulin <tursulin@ursulin.ne=
t> wrote:
>
>
> On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > The gfx_v7_0_cp_compute_resume() function should only return
> > success when all compute rings are actually functional.
> > This will be especially important for soft reset which needs
> > this to know whether the reset was successful.
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> > index 9c4b3ac27e1f..a1a9f3fc4567 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -3019,12 +3019,14 @@ static int gfx_v7_0_cp_compute_resume(struct am=
dgpu_device *adev)
> >
> >       gfx_v7_0_cp_compute_enable(adev, true);
> >
> > +     r =3D 0;
> > +
> >       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> >               ring =3D &adev->gfx.compute_ring[i];
> > -             amdgpu_ring_test_helper(ring);
> > +             r |=3D amdgpu_ring_test_helper(ring);
> >       }
> >
> > -     return 0;
> > +     return r;
> >   }
> >
> >   static void gfx_v7_0_cp_enable(struct amdgpu_device *adev, bool enabl=
e)
>
> Gfx8 and 9 (did not look further) do not do it like that. Should they?
> Or there is more work there to be done first?
>
> I actually might like this because maybe it gets us closer to removing
> the ring->sched.ready hack but what I am just not sure if the idea was
> to allow driver to function with some non-functional rings after resume.
> Under the premise that if they initialized during init, then after
> resume they must too, or if they don't, it is a transient glitch. I
> don't know.. I am being imaginative here thinking about silly driver
> workarounds for weird hardware glitches. It is much more likely this was
> just an oversight and it is completely fine to to error out.
>
> I have to defer to Alex and Christian on this one.

The reason for not checking the errors was because compute queue
failure was not seen as fatal.  There are a lot of compute queues
(relative to other engines), so if something happened, it seemed
better to just continue in a degraded mode with fewer compute queues
than to fail to resume in general.

Alex

>
> Regards,
>
> Tvrtko
>

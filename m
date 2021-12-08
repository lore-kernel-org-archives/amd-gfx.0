Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F38CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 20:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1CC6E8A9;
	Wed,  8 Dec 2021 20:27:57 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079E06E8A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 20:27:56 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id bj13so5704568oib.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 12:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2ba3Y20RZhb0JjXprtU90Ja+G9hOebr9B3mV4Kk/UfQ=;
 b=VHy4rAJAYJQcGhBdM8H0ON5tcdH/NpNiG0duW/b8HsFQ5WgYanZab/1q0zN/V32aVH
 yg44DABSi5IdkT/EK7S+WITNjTtbxhYgj/+neAPniffM5i+aTK1R0lwQgnHunI7CNTi/
 yloij4Hr3DkEFVqxpt/ekslrdFetrrMO9KClHz+V6R3VKrL1o+SP/oAnIBMsRPPj2jKO
 cSgqxSCLLcy4PhnltCcBz55h67qoojJu9pY7iuQ25CYkam2xLThm8Lk1hXJwF7+jhNUc
 Q74NcUMsCGNjF004LtR/WGlNvwzNixHWFt7ImUFq9pDYmCHmbjdD97GrP4YeGph5TVa1
 qShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ba3Y20RZhb0JjXprtU90Ja+G9hOebr9B3mV4Kk/UfQ=;
 b=cMENp5GH60UnCamXzeMkM1EjU6BKC20p5fwjaIUrT6yBd2McnpL3xWSRNgOsYgJPbl
 kRaG5YEGTFKK6jWjzfrGwxkDZCycy+fz7HhOesFOqj8fTzQcY9Mv13DhvD8rCLRwExKv
 5b0lPgaoW1FZYP7hezF3aKty1u2YblGmTyDYk3pivKdJX34I8Ut/+lDDVlhrDD/N09OF
 Qd9sZ54WynRAXJ6jecynrKRNK+l7PN0flxoWjbJjUW3rhr71uQojiGWFsi7lN2PHgTz9
 vjHL0t+4DRsOwkNY1a6DtNg/HMmlPKT630xZic1wrbI7cTXuqWzdMeUnLZEGhK0LgY5M
 mXFQ==
X-Gm-Message-State: AOAM5321CXu46qCMqhldwLLBvkmKpVBfD+JtmC1AL9AB7g8fkgX5CLtH
 IO6Pisww18mmFWkyLoauHdX8QcYJpqaayfaBFoQ=
X-Google-Smtp-Source: ABdhPJypd9N+OboylzWWkytxWU2rhdrlt+Z/oEoEjZf44I7ju+Jqs71OrHzummTzJ98c8y4PRg+Gh44S4HCEmo8/f/8=
X-Received: by 2002:a05:6808:44:: with SMTP id
 v4mr1608285oic.123.1638995276261; 
 Wed, 08 Dec 2021 12:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20211208201618.10551-1-Philip.Yang@amd.com>
 <CADnq5_NmfbXL9jzBZxZJOjT_+zpatk+M4Zm_czNsG9VMdcweBg@mail.gmail.com>
In-Reply-To: <CADnq5_NmfbXL9jzBZxZJOjT_+zpatk+M4Zm_czNsG9VMdcweBg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 15:27:45 -0500
Message-ID: <CADnq5_O5qsewQatnt7W6n-XHQ9JvZhj=6K=m8mUO-08h6=Jyog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Handle fault with same timestamp
To: Philip Yang <Philip.Yang@amd.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 8, 2021 at 3:25 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Dec 8, 2021 at 3:17 PM Philip Yang <Philip.Yang@amd.com> wrote:
> >
> > Remove not unique timestamp WARNING as same timestamp interrupt happens
> > on some chips,
> >
> > Drain fault need to wait for the processed_timestamp to be truly greater
> > than the checkpoint or the ring to be empty to be sure no stale faults
> > are handled.
> >
> > Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>
> Maybe add the link to the bug when you push this?

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1818

Alex

>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 4 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ---
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> > index 8050f7ba93ad..3df146579ad9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> > @@ -188,8 +188,8 @@ int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
> >         checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
> >
> >         return wait_event_interruptible_timeout(ih->wait_process,
> > -                   !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
> > -                   timeout);
> > +                   amdgpu_ih_ts_after(checkpoint_ts, ih->processed_timestamp) ||
> > +                   ih->rptr == amdgpu_ih_get_wptr(adev, ih), timeout);
> >  }
> >
> >  /**
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > index e031f0cf93a2..571b11117992 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -522,9 +522,6 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
> >         if (!handled)
> >                 amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
> >
> > -       dev_WARN_ONCE(adev->dev, ih->processed_timestamp == entry.timestamp,
> > -                     "IH timestamps are not unique");
> > -
> >         if (amdgpu_ih_ts_after(ih->processed_timestamp, entry.timestamp))
> >                 ih->processed_timestamp = entry.timestamp;
> >  }
> > --
> > 2.17.1
> >

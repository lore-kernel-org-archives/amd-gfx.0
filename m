Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761BCD6D232
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 15:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0275610E966;
	Thu, 18 Dec 2025 15:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XEmBj4E6";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B9610E966
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 15:47:15 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7c78d30649aso459200a34.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766072834; x=1766677634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enIJrsCortz37o/s5IXS1vcUPnMqxbPI6Lv0QkycBbg=;
 b=XEmBj4E6Yu9mrNtnLc4G/qknlwHaWcixBTtRWqrdBjCZgDAnu42p33CioNvL6Qr84s
 WHzc+ybdzjqrqF5ZFu1F60LCzmaHoh0assBNk34Y5W1jjFpKb7AaICo/Q/tXIcEJMist
 uErO9o1x2jpZthGwHaV1fYhfyOaBsmLNMTGSIBz5M2gCO9GM3YdBEQBMv9PNLNJVLi4V
 Wkc1EUp2w3fg9tt3NZTkAS4TJo1FWcidoixI87JFANeOlBM6wNyCabOLegZExD4Zx04y
 U6/nvZuGSTiZs3nEi4Z329wV/7lw482y+Riwyl7YZRiydcdW4es3yEFElMRBxOIH4Sl6
 yA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766072834; x=1766677634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=enIJrsCortz37o/s5IXS1vcUPnMqxbPI6Lv0QkycBbg=;
 b=nmmR2wspUpFe3VqXofhxMCUU3afXGuL+XAu0WXJ4W0lHkwcr0Ucb6CVwYNYW2pnt/+
 IWEnm+W1m+k/m5P3W75TkynaY2lRh4ahPv+jaKbKlc10wJC3n4uhC8d9MfhKA0J4BDVA
 IME9L7c0TiI4RoDOJBS3S7TAei2KrI6qwmeMRSZOS2ywOFxKLoJcgTEFSZOaUWBXx1wd
 1cZMKr8YPNM52oOGN/O2Wd+uD2edFThhSQ5gbTaDDdJiWyCH/J2ESamO4npDtxplqtvO
 g2sHrzCCM19VvQI+S2sA+9dXgdXO+lcK/rnnJAv4rvrJof1n+cr1QRtxDIw66kYJerxG
 VI6w==
X-Gm-Message-State: AOJu0Yxpu6VBYYRl7ReF3+pnE+DafNvxIlkuZY52YO1s4eiXaz2XR5DD
 JPPMn0o3XzxBdsJvQgEVnaKd6Yqv6/l4NiRizAQMJbhGipMVKqXohASO
X-Gm-Gg: AY/fxX7WZFUNmiGW5gyNaeCJLXAiOK0uuyLzq8Ek6Z/RD8ajLRTwTK9dWYWNkwK+tjV
 SzIVs8eKXDPOPQBzifd8nkcSE+ma+5enOE3ZW9dLJMQXmtVgD0Xu4TbFDWEDuioVJyy1izB8hAE
 pzzdpxDGT309rU7T/GAtFySt4OJmpmUFeDIEL0XDvP92iUtP0RXYAgkUSP6EmxDPR2QIxr0quiB
 VNMwuNKhO9ZsKBIYdZxvhDM3wXZ5F1ofWgnZ8e+ZzZtY05NLJvX3rv/MMrG+hUQyczNpEdiegzQ
 a0+LOuRg8XjKQI73IRaTh5dU8B2oQ/2UdG1tzCnDhtT6ADFyrOPaOHa0obLre4AU6Bpw5st8biz
 xdwvxWrkO1nt4HDvemEUHUvaWA0ctka2at8klcE7fJyGMlkQMwKIXRbXRdlsvzrvawaBAdZPHXJ
 FyQa0XoJ4o0waLnYZJMIaeUheJKwb6u5Svoy7m0Q==
X-Google-Smtp-Source: AGHT+IH2SGr0Fhtha5DMqsVzEOnVBDyglnLlnyDvB4opRxYLokhcLOp6LlSN7guT/hQdKwYGuLQTHQ==
X-Received: by 2002:a05:6830:917:b0:7c1:12c5:334e with SMTP id
 46e09a7af769-7cae834e67bmr15015772a34.17.1766072834173; 
 Thu, 18 Dec 2025 07:47:14 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59be838fsm1871787a34.31.2025.12.18.07.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 07:47:13 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: don't reemit ring contents more than once
Date: Thu, 18 Dec 2025 09:47:13 -0600
Message-ID: <2513938.h6RI2rZIcs@timur-max>
In-Reply-To: <CADnq5_MrscrX+4vpNwpzK47+nLvF0ognLrB=56hqfv89y-LA6g@mail.gmail.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <2459360.yiUUSuA9gR@timur-max>
 <CADnq5_MrscrX+4vpNwpzK47+nLvF0ognLrB=56hqfv89y-LA6g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 18., cs=C3=BCt=C3=B6rt=C3=B6k 9:36:57 k=C3=B6z=C3=A9ps=C5=
=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex=20
Deucher wrote:
> On Thu, Dec 18, 2025 at 12:36=E2=80=AFAM Timur Krist=C3=B3f <timur.kristo=
f@gmail.com>=20
wrote:
> > On 2025. december 15., h=C3=A9tf=C5=91 10:07:06 k=C3=B6z=C3=A9ps=C5=91 =
=C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> > Deucher>=20
> > wrote:
> > > If we cancel a bad job and reemit the ring contents, and
> > > we get another timeout, cancel everything rather than reemitting.
> > > The wptr markers are only relevant for the original emit.  If
> > > we reemit, the wptr markers are no longer correct.
> >=20
> > I see the point of not reemitting, considering the wptrs are no longer
> > correct. However, would it be possible to correct the wptrs instead?
>=20
> Yes, that could be done, but it's more complicated.  This is just a
> short term fix until that is implemented.
>=20
> Alex

I see. The patch is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> > As it is, this sounds like it would make the reset less reliable when
> > there is more than one job emitted that can cause hangs.
> >=20
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >=20
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
> > >  2 files changed, 19 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c index
> > > 1fe31d2f27060..334ddd6e48c06 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > @@ -710,6 +710,7 @@ void
> > > amdgpu_fence_driver_guilty_force_completion(struct
> > > amdgpu_fence *af) struct amdgpu_ring *ring =3D af->ring;
> > >=20
> > >       unsigned long flags;
> > >       u32 seq, last_seq;
> > >=20
> > > +     bool reemitted =3D false;
> > >=20
> > >       last_seq =3D amdgpu_fence_read(ring) & ring-
> > >
> > >fence_drv.num_fences_mask;
> > >
> > >       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_m=
ask;
> > >=20
> > > @@ -727,7 +728,9 @@ void
> > > amdgpu_fence_driver_guilty_force_completion(struct
> > > amdgpu_fence *af) if (unprocessed &&
> > > !dma_fence_is_signaled_locked(unprocessed)) { fence =3D
> > > container_of(unprocessed, struct amdgpu_fence, base);
> > >=20
> > > -                     if (fence =3D=3D af)
> > > +                     if (fence->reemitted > 1)
> > > +                             reemitted =3D true;
> > > +                     else if (fence =3D=3D af)
> > >=20
> > >                               dma_fence_set_error(&fence->base,
> >=20
> > -ETIME);
> >=20
> > >                       else if (fence->context =3D=3D af->context)
> > >                      =20
> > >                               dma_fence_set_error(&fence->base,
> >=20
> > -ECANCELED);
> >=20
> > > @@ -735,9 +738,16 @@ void
> > > amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
> > > rcu_read_unlock();
> > >=20
> > >       } while (last_seq !=3D seq);
> > >       spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> > >=20
> > > -     /* signal the guilty fence */
> > > -     amdgpu_fence_write(ring, (u32)af->base.seqno);
> > > -     amdgpu_fence_process(ring);
> > > +
> > > +     if (reemitted) {
> > > +             /* if we've already reemitted once then just cancel
> >=20
> > everything */
> >=20
> > > +             amdgpu_fence_driver_force_completion(af->ring);
> > > +             af->ring->ring_backup_entries_to_copy =3D 0;
> > > +     } else {
> > > +             /* signal the guilty fence */
> > > +             amdgpu_fence_write(ring, (u32)af->base.seqno);
> > > +             amdgpu_fence_process(ring);
> > > +     }
> > >=20
> > >  }
> > > =20
> > >  void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> > >=20
> > > @@ -785,10 +795,12 @@ void
> > > amdgpu_ring_backup_unprocessed_commands(struct
> > > amdgpu_ring *ring, /* save everything if the ring is not guilty,
> > > otherwise
> > >=20
> > >                        * just save the content from other
> >=20
> > contexts.
> >=20
> > >                        */
> > >=20
> > > -                     if (!guilty_fence || (fence->context !=3D
> >=20
> > guilty_fence->context))
> >=20
> > > +                     if (!fence->reemitted &&
> > > +                         (!guilty_fence || (fence->context !=3D
> >=20
> > guilty_fence->context)))
> >=20
> > amdgpu_ring_backup_unprocessed_command(ring, wptr,
> >=20
> >        fence->wptr);
> >       =20
> > >                       wptr =3D fence->wptr;
> > >=20
> > > +                     fence->reemitted++;
> > >=20
> > >               }
> > >               rcu_read_unlock();
> > >      =20
> > >       } while (last_seq !=3D seq);
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index
> > > a1fb0fadb6eab..d881829528976 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > @@ -150,6 +150,8 @@ struct amdgpu_fence {
> > >=20
> > >       u64                             wptr;
> > >       /* fence context for resets */
> > >       u64                             context;
> > >=20
> > > +     /* has this fence been reemitted */
> > > +     unsigned int                    reemitted;
> > >=20
> > >  };
> > > =20
> > >  extern const struct drm_sched_backend_ops amdgpu_sched_ops;





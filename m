Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EE1C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 21:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF5710EB09;
	Mon, 13 Jul 2026 21:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V9Ku562G";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE39C10EB09
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 21:04:41 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cac39b729dso8775695ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 14:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783976681; cv=none;
 d=google.com; s=arc-20260327;
 b=IFvHbC3StVpZcZM62susRQ2PtRDJDlJlEFg0wk/x0iHHLvZkZNq9fHJKlc+1U00j40
 NTdgE9D48E/w7JTFg2bUn9X/NHSvW5f8Da0PWEwzKzelGj9aQGKVKgnuofhXwkS1xBf1
 qe7EV/rkGJGc5/TBRi5jZKa0wnyxOAZ49zSBOyQ1GaJD5aLx83x8CXemcFcDuXkhjUuW
 w+QYTxezLblbicWmBHo1G7fgt5c7GWfmnn0HBWF0JhTm76uXHqh9e7kmsfch/n6q2Crk
 +ySiV1jix5nLquxXVoMR5qHIC/igiJJRytoTPWiytgGAkM6gPBIsg5XUErvPabMC42JW
 VL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4qCg/dd5oAJB4bgBNgXP0glEZ4WdGJ1y/bu3FGY/i0I=;
 fh=VZWGhu5ktZKPIjfQp09PoHZbX6XsASq8Mg4WXNkr//M=;
 b=dPNIRqDhYUyd02+SWHN7bh0Mk2S9LPuGHWUy1N4YOuzslS9OFHewN7Tq/k+f9rKx1y
 bxSfEFOIRxSAvfwImbK7cGpoWKa9TNjEkXdXzKrmuX7ithAChxbXyVUYE8y2d12Ow9FQ
 UoAw/QMsMxYlRaRM9bJgIBr9PP2kFDpRMcv3751e2yJfreapsIOd6fG9HqKdsN86GzLG
 RfZ/YcvtcqkkCUyXOQwR+LxwJ1yOxdVfEUa03tajBdaGuPIL/3UvQUI4v7pl0Rp7qiob
 L5ybnysINHy5d4sQZVPmoyYc6ocBPH/vJlJNdZWuPJd2Wi0UXgeJnEa8Jjg/6ZXlcknS
 ah9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783976681; x=1784581481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4qCg/dd5oAJB4bgBNgXP0glEZ4WdGJ1y/bu3FGY/i0I=;
 b=V9Ku562Gy/wD12OqUJWXLpHN0BS0Q+SADc/tD5qXjFRifytygEpfSUmcY6qTpZptOD
 e9XvwX6eYMh4QP+acih7BCSG00uTtBGyaSd1gklBzogjcld8+gcfPxByCB0FPQyqzSGP
 83i7n8IxqXGfXN4mk1pq2wbtn2dRwOsFhp8iehTEqEgiNKZfEdvEj9qlJTdiS6jfPh0E
 K06Nlbjg/EU9bWuvwPchRqel1Oo+U+b+cK9IW3OGy+hEzDG8ygPYkwxeql4HR/iTEUL3
 BVRmltdXdRemegg0duSji6vXXCv6VpqOOeIzauk1brSPBdR6Jf6tgszHD9c/MshRS9Ag
 oV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976681; x=1784581481;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4qCg/dd5oAJB4bgBNgXP0glEZ4WdGJ1y/bu3FGY/i0I=;
 b=qoAGWYtO5+IcAPWS+gpdaXFbJzUK4r1z9DJOkh0Zyw3EIyUHtpCRIrHCuzzQIlrObz
 VMc6yS8Kogm0YMeV5lEJLU1ZnVHmXNYpcFY4IleIWjjM2ISLKfmOybnqz0Aq9MtGrCo2
 HaBSSbYGGPVV67dqSlAjh+Ga1532cV/9Zi/soBAHODcX4NBmbkk5EB69DJNkQFYadizK
 FDhZ6ipaCXC7adlEGIDga+furx4odJJVOXyN74ulaPPbMm5oECAyMgl53M3Rr03DLfn4
 QKa1cBVqxlmElAroVfZTnfpFb8YyD50NECmPWqlDBzy+tkMDF73pZA10HjV3OttlQ4bO
 WrUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RolEIhDrDo5yWOZJ8w/8IdCfw/tZJ4Iq9Auke2iMEQRJdS+41YR/b3kagAKmDB7Ju2a/qEafx7I@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6v+aLhzpKSK9GpvznY1ZaX8tZy1+rodJe57OhKZIlp9q+uX0O
 NFPbeOY9ssrlwTPqcycpOU9PPzKCcCGrkd4bO+lPDaov51uCsZZq9hzAr1afeOolykm7Cm2n9+2
 y3QsWfScrs3o13KV9dO847Ef5exd2FWLrSg==
X-Gm-Gg: AfdE7ckdCe11UHA44NSt7OcENgen4T18SbyE4T+uhRBuial+AJOE15LQk/QLoQSR9+f
 KHZDBlP7cbBeSsxQyyDvg6R9FxOK/RMdD7+zS6AcHPB4rehXDGucwHlwaslF1swrbCsZQijVayf
 goRsaMMeUX41ML/X1jNq5fKjS8rgZDPCbTU5ud8ScVxozOGfUZ5VqloRCjW9nljx3hbtMBmNg/o
 aGTNSTFY3L1cbX/Z1FixVZGxozapAfsBLGWjtajT3wM1Rf8mERNvUvhQ83nEw3l7qCdU4C9RLmw
 NRMbdp7+Ss/6A3FQ78m71V+PVOr2uY8o7VYzofExQEr1WUW6DAivn7lnAohlfvjo1NgInA==
X-Received: by 2002:a17:90a:7307:b0:38e:bfe:81e6 with SMTP id
 98e67ed59e1d1-38e0bfe9036mr1587418a91.1.1783976681104; Mon, 13 Jul 2026
 14:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
 <20260713164321.3350036-5-srinivasan.shanmugam@amd.com>
 <CADnq5_NMu8eVhhrnkKVui2_cY8yn7Opr7OOqW4V2Svc=fpnhFw@mail.gmail.com>
 <CADnq5_O4NbGu02-+qD2LukX+K9QntboFZFi+R+_jo5GGdu5f7A@mail.gmail.com>
In-Reply-To: <CADnq5_O4NbGu02-+qD2LukX+K9QntboFZFi+R+_jo5GGdu5f7A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 17:04:29 -0400
X-Gm-Features: AVVi8CeR9i8KijO2hWBIxJtmkLNg3jjSGLfA8mCPuC-EAvazoo9kSQUPj2ylK08
Message-ID: <CADnq5_PcUbhWY-av_L3ncAa5gznoGpgO+ZJ6E0gyAvSPMGMAqQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] drm/amdgpu: Remove queue-scoped WAIT_EVENT records
 on queue teardown
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jul 13, 2026 at 5:02=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Jul 13, 2026 at 5:00=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Mon, Jul 13, 2026 at 1:39=E2=80=AFPM Srinivasan Shanmugam
> > <srinivasan.shanmugam@amd.com> wrote:
> > >
> > > Pending WAIT_EVENT records for queue-scoped events store queue pointe=
rs
> > > and own queue references while queued.
> > >
> > > Remove all WAIT_EVENT records associated with a user queue before USE=
RQ
> > > drops its queue reference during queue teardown. This mirrors the
> > > EVENTFD queue cleanup path and prevents pending records from keeping
> > > stale queue state after the queue is removed from USERQ ownership.
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Actually this patch should be applied before the IOCTL is enabled
> otherwise the previous patch will leak events.

Actually nevermind, you don't add any queue events until patch 5.

Alex

>
> Alex
>
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userq.c
> > > index 5bf231d7a630..b3ac1e81c9ca 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -56,6 +56,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *=
userq_mgr)
> > >         return &fpriv->eventfd_mgr;
> > >  }
> > >
> > > +/*
> > > + * Get the per-file wait-event manager associated with this userq ma=
nager.
> > > + */
> > > +struct amdgpu_wait_event_mgr *
> > > +amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr)
> > > +{
> > > +       struct amdgpu_fpriv *fpriv;
> > > +
> > > +       if (WARN_ON(!userq_mgr || !userq_mgr->file))
> > > +               return NULL;
> > > +
> > > +       fpriv =3D userq_mgr->file->driver_priv;
> > > +       if (WARN_ON(!fpriv))
> > > +               return NULL;
> > > +
> > > +       return &fpriv->wait_event_mgr;
> > > +}
> > > +
> > >  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
> > >  {
> > >         int i;
> > > @@ -1040,6 +1058,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, =
void *data,
> > >                         return -ENOENT;
> > >
> > >                 amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queu=
e);
> > > +               amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr=
, queue);
> > >
> > >                 amdgpu_userq_put(queue);
> > >                 break;
> > > @@ -1426,6 +1445,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_=
mgr *userq_mgr)
> > >
> > >                 amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(=
userq_mgr),
> > >                                             queue);
> > > +               amdgpu_wait_event_remove_queue(amdgpu_userq_wait_even=
t_mgr(userq_mgr),
> > > +                                              queue);
> > >
> > >                 amdgpu_userq_put(queue);
> > >         }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userq.h
> > > index 187bfd66eb13..6a53cd3208da 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > @@ -203,4 +203,6 @@ int amdgpu_userq_input_cwsr_params_validate(
> > >         struct amdgpu_cwsr_params *cwsr_params);
> > >  struct amdgpu_eventfd_mgr *
> > >  amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
> > > +struct amdgpu_wait_event_mgr *
> > > +amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
> > >  #endif
> > > --
> > > 2.34.1
> > >

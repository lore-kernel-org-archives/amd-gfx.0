Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D26EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 19:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF54410E0C5;
	Wed, 14 Jun 2023 19:21:02 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79B910E0C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 19:21:00 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-39a3f165ac5so4256713b6e.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686770459; x=1689362459;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hotS8cKvEvnruXrDNY+Qb0UYWuOE25eN7+SVvYsRcbE=;
 b=kBPHCPWmY9gZVP3aPnAmJxUQiiR3Z4STpai6JLGuANBy+7Eb7eWLwj1azZoaVaXS4/
 Gm8g2ICjRKKyQr+Gp0ulHcI8roGDqjzuA44DfYO+TfULhAFM8mG/iC1mG9LBAz332u/F
 TyMouagMv8mYfRg2FHXmtYQFLgR0ItM87f0sEctAlQraCiTUmTsWrro0RzvWvh1zoBFZ
 PDTj7PDUW8Xn2gw8vRbFyBHMwLcsf9LfRdO2DmdkmZ/ydFcSYe4ALkX1piYrcr5+Nvja
 3rO6oLLvMj7hZC55O1IZXdgybAgr8mFKt27EAM9+JeMLcr7FjWz+Q92YENEJZGXAfcKq
 f25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686770459; x=1689362459;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hotS8cKvEvnruXrDNY+Qb0UYWuOE25eN7+SVvYsRcbE=;
 b=QOFsQPWNG0/wIaG7edUuL+xW0zsvXwl7vcYYps+BYnwHh6lbm76SnCdSci8uhYhlVz
 BJhkramAhveir9+kuKIIaFTGn2POuQdWXHQEMLimTV+DFWDnckNu9qEFZLJAgrefESun
 zB+As2p9mb6bBfJTtx9UGGjulnPK2wRFggvm6jjqDvLkef0Ppx71clOxwkPuPRRfVnGZ
 PKgl5g2YRukvD4w5xqBqTOzdj3SMOcdt8iRyUbQhc5Osi7m6BplEHXMATJ1epK4OdZct
 0n/FSAEG87q24wpo78ZbjwMLYEeQZ43yetVlXlZwcylAfVa2TOVzzRHR4x17eGvPjP87
 qwjg==
X-Gm-Message-State: AC+VfDxXGfI8scJ2PVaJBcXoxJzZwUu3TTkPhJRoi2A9gzXAJbOetbDq
 vx+FuYkFvqMeCDK8wjHYESOcqlsT5qHOvbjLIXo=
X-Google-Smtp-Source: ACHHUZ72gKAFIWzlc+nI9ggHbUkfo8XzoJyiUNfK08gi3agMw0AZayG5af4gHAJGDUJce1YzFZ+SflQbjGkOPzPqVM0=
X-Received: by 2002:a05:6358:cd1b:b0:12f:213:b558 with SMTP id
 gv27-20020a056358cd1b00b0012f0213b558mr944244rwb.22.1686770459262; Wed, 14
 Jun 2023 12:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230614112758.120429-1-nicolai.haehnle@amd.com>
 <cca52290-bd13-e9e9-297c-e480acaef782@gmail.com>
 <DM4PR12MB596202BE54818219FEC63746FF5AA@DM4PR12MB5962.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB596202BE54818219FEC63746FF5AA@DM4PR12MB5962.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle@gmail.com>
Date: Wed, 14 Jun 2023 21:20:43 +0200
Message-ID: <CAO4GU+A4rZWfP5VOnx1ubTbm9Jb8z6z1BkUU+mJKNaNj_f9=aQ@mail.gmail.com>
Subject: Re: Fw: [PATCH] drm/amdgpu: add amdgpu_timeout_ring_* file to debugfs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>
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

Hi Christian,

> > Report the per-ring timeout in milliseconds and allow users to adjust
> > the timeout dynamically. This can be useful for debugging, e.g. to more
> > easily test whether a submission genuinely hangs or is just taking very
> > long, and to temporarily disable GPU recovery so that shader problems
> > can be examined in detail, including single-stepping through shader
> > code.
> >
> > It feels a bit questionable to access ring->sched.timeout without any
> > locking -- under a C++ memory model it would technically be undefined
> > behavior. But it's not like a lot can go wrong here in practice, and
> > it's not clear to me what locking or atomics, if any, should be used.
>
> Uh, that's very dangerous what you do here and wouldn't work in a whole
> bunch of cases.

Please elaborate: *what* case doesn't work?


> First of all GPU recovery is part of normal operation and necessary for
> system stability. So disabling GPU recovery is actually not a good idea
> in the first place.

That's a complete non-argument because the whole point of this is that
it is a debugging feature. You're using this when the system as a
whole (most likely a UMD component) is already broken in some way.
Putting this in debugfs is not an accident.


> We already discussed that we probably need to taint the kernel if we do
> so to indicate in crash logs that the system is not considered stable
> any more. The problem was only that there wasn't an agreement on how to
> do this.

I'd be happy to add kernel tainting if you tell me how.


> Since this here now makes it even easier to disable GPU recovery it's
> probably not the right approach.

Again, being able to disable GPU recovery is a crucial debugging
feature. We need to be able to inspect the live state of hung shaders,
and we need to be able to single-step through shaders. All of that
requires disabling GPU recovery.

Forcing people to reboot just to be able to disable GPU recovery for
debugging is developer hostile.

So again, if there really are cases where this "doesn't work" (and
those cases aren't just that your desktop will freeze -- that part is
intentional), then let's talk through it and see how to address them.

Thanks,
Nicolai


>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Nicolai H=C3=A4hnle <nicolai.haehnle@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 32 +++++++++++++++++++++++=
-
> >   1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index dc474b809604..32d223daa789 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -471,35 +471,65 @@ static ssize_t amdgpu_debugfs_ring_read(struct fi=
le *f, char __user *buf,
> >
> >        return result;
> >   }
> >
> >   static const struct file_operations amdgpu_debugfs_ring_fops =3D {
> >        .owner =3D THIS_MODULE,
> >        .read =3D amdgpu_debugfs_ring_read,
> >        .llseek =3D default_llseek
> >   };
> >
> > +static int amdgpu_debugfs_timeout_ring_get(void *data, u64 *val) {
> > +     struct amdgpu_ring *ring =3D data;
> > +
> > +     if (ring->sched.timeout =3D=3D MAX_SCHEDULE_TIMEOUT)
> > +             *val =3D 0;
> > +     else
> > +             *val =3D jiffies_to_msecs(ring->sched.timeout);
> > +
> > +     return 0;
> > +}
> > +
> > +static int amdgpu_debugfs_timeout_ring_set(void *data, u64 val) {
> > +     struct amdgpu_ring *ring =3D data;
> > +
> > +     if (val =3D=3D 0)
> > +             ring->sched.timeout =3D MAX_SCHEDULE_TIMEOUT;
> > +     else
> > +             ring->sched.timeout =3D msecs_to_jiffies(val);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_timeout_ring_fops,
> > +                      amdgpu_debugfs_timeout_ring_get,
> > +                      amdgpu_debugfs_timeout_ring_set,
> > +                      "%llu\n");
> > +
> >   #endif
> >
> >   void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> >                              struct amdgpu_ring *ring)
> >   {
> >   #if defined(CONFIG_DEBUG_FS)
> >        struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> >        struct dentry *root =3D minor->debugfs_root;
> > -     char name[32];
> > +     char name[40];
> >
> >        sprintf(name, "amdgpu_ring_%s", ring->name);
> >        debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
> >                                 &amdgpu_debugfs_ring_fops,
> >                                 ring->ring_size + 12);
> >
> > +     sprintf(name, "amdgpu_timeout_ring_%s", ring->name);
> > +     debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR, root, ring=
,
> > +                         &amdgpu_debugfs_timeout_ring_fops);
> >   #endif
> >   }
> >
> >   /**
> >    * amdgpu_ring_test_helper - tests ring and set sched readiness statu=
s
> >    *
> >    * @ring: ring to try the recovery on
> >    *
> >    * Tests ring and set sched readiness status
> >    *
>


--=20
Lerne, wie die Welt wirklich ist,
aber vergiss niemals, wie sie sein sollte.

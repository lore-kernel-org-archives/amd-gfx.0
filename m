Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A1AEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 08:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0519610E499;
	Thu, 15 Jun 2023 08:55:34 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F36C10E499
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 08:55:32 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-3f9ca59283cso26521511cf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686819331; x=1689411331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW0nkVRHBxYjCD828v5NpO/lyi0FRebyvBopmEi/w4M=;
 b=AR/f5TWmr5PY/IfEAc6tpiWE9VRiZf347RbKePWF73pbgFRt5Akw1l8+iPHvXwpTDy
 ti+ssovGMKzVVd7+q/wEqclSQfCdGQ+rb/Q6i5jnLnzb03UrrRmiMWjVMbpKlTnKiyuR
 bE2+z/8CF5a6W6CSCM7EhWbh3jHVaZl/j9HJWQwGgUe2rHM+MLQIcZuNf8H6M60u1gT+
 qxy006p8S+pYkOM4QKuDnL+0jufFB8M36wFQG1NJMtPH5YficOEsdMAXWH2zeYXr3AJA
 4cpy11fKW8GFZAcPkulqxzPu4qEvwTdrw1MImT8/TuE3b2+JpRhhyTW35+0ofYgZxpPH
 ziBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686819331; x=1689411331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nW0nkVRHBxYjCD828v5NpO/lyi0FRebyvBopmEi/w4M=;
 b=WXBty6condQfI/Gp9k9l0WuA6H2KCM1rZC/xXGMIwXbpgeO4CO0uiuhzcdaL2ybRib
 ZRMAJ6c7edjaTQfMu9oec86kjVAMKq+OB00dFas5UqhrZQUTThD1XNr4w1ENhpEIrqyH
 R0O6SKKAMpqrTXxlbYe13d1+Y/alUizwA6anKWjJhCzHv2suIsploKSJXDmxRXyOn298
 dUDoCaCzcgtTU2IG0/QH05jh8JFKPuzqUBnDYERoetFx/4XE4/q7GLSc7QPN7/l9x4ON
 xIJkzXeCpM+KGNDy3Dr4SEVCuMISkYijtQNwWpJnNUk8sGhEhFvacYY6Jt7VYBKh7t7v
 OnqQ==
X-Gm-Message-State: AC+VfDyL2U9OprVsvin1gQop9zihLObO1A5uhtb2u1V2uEhH5qu/7Dgj
 BYyIomsnN/XJZU3ILAG+6WaHsSwklnH1mXQnCKY=
X-Google-Smtp-Source: ACHHUZ4o7+6qe4mge4+IWcPicc3BKzbOfJiK15o4ml9vH/SX3/BcW0oDbhY8v7D/2M2IkhHRPMFlc9G/l5cRwgDq8WI=
X-Received: by 2002:ac8:5a54:0:b0:3f9:b37c:4ee4 with SMTP id
 o20-20020ac85a54000000b003f9b37c4ee4mr4413954qta.60.1686819330813; Thu, 15
 Jun 2023 01:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230614112758.120429-1-nicolai.haehnle@amd.com>
 <cca52290-bd13-e9e9-297c-e480acaef782@gmail.com>
 <DM4PR12MB596202BE54818219FEC63746FF5AA@DM4PR12MB5962.namprd12.prod.outlook.com>
 <CAO4GU+A4rZWfP5VOnx1ubTbm9Jb8z6z1BkUU+mJKNaNj_f9=aQ@mail.gmail.com>
 <ae3eb473-ba76-1a3a-f063-388a00766164@gmail.com>
In-Reply-To: <ae3eb473-ba76-1a3a-f063-388a00766164@gmail.com>
From: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle@gmail.com>
Date: Thu, 15 Jun 2023 10:55:14 +0200
Message-ID: <CAO4GU+D1SDsRk+Oe0KfGSh3Rivvnb6RTaGO59bByeD3M5Q2qGQ@mail.gmail.com>
Subject: Re: Fw: [PATCH] drm/amdgpu: add amdgpu_timeout_ring_* file to debugfs
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
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>, "Haehnle,
 Nicolai" <Nicolai.Haehnle@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 15, 2023 at 9:47=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> >> Uh, that's very dangerous what you do here and wouldn't work in a whol=
e
> >> bunch of cases.
> > Please elaborate: *what* case doesn't work?
>
> The core memory management can wait at any time for the GPU reset to fini=
sh.
>
> If we set the timeout to infinity we risk just deadlocking the kernel.

Okay, thanks. I may have seen some aspect of this before in cases
where GPU reset failed and left processes in an unkillable state.

I'll be honest, I've seen my fair share of exotic GPU hangs and to put
it mildly I'm not impressed by the kernel's handling of them.
Obviously you know much more about the intricacies of kernel memory
management than I do, but the fact that processes can end up in an
unkillable state for *any* GPU-related reason feels to me like the
result of a bad design decision somewhere.

But anyway, I'm not even asking you to fix those problems. All I'm
asking you is to let me do *my* job, part of which is to help prevent
GPU hangs from happening in the first place. For that, I need useful
debugging facilities -- and so do others.


> > Again, being able to disable GPU recovery is a crucial debugging
> > feature. We need to be able to inspect the live state of hung shaders,
> > and we need to be able to single-step through shaders. All of that
> > requires disabling GPU recovery.
>
> Yeah, I'm perfectly aware of that. The problem is this is just *not*
> supported on Linux for graphics shaders.
>
> What you can do is to run the shader with something like CWSR enabled
> (or an to be invented graphics equivalent). Since we are debugging the
> shader anyway that should be possible I think.
>
> > Forcing people to reboot just to be able to disable GPU recovery for
> > debugging is developer hostile.
>
> Well, I think you misunderstood me. The suggestion was even to force
> them to re-compile the kernel driver to disable GPU recovery.
>
> Disabling GPU recovery is *not* something you can do and expect the
> system to be stable.
>
> The only case we can do that is when we attach a JTAG debugger in an AMD
> lab.

You're being *completely* unreasonable here. Even Windows(!) allows
disabling GPU recovery at runtime from software, and Windows is
usually far more developer hostile than Linux in these things.
Seriously, this level of hostility against developers coming from you
is not okay.

Yes, it's a tool that has sharp edges. That is perfectly well
understood. If we need to add warning labels then so be it. And if the
details of *how* to change the timeout or disable GPU recovery at
runtime should be changed, that too is fine. But it's an important
tool. Can we please just move forward on this in a pragmatic fashion?

Thanks,
Nicolai


>
> Regards,
> Christian.
>
> >
> > So again, if there really are cases where this "doesn't work" (and
> > those cases aren't just that your desktop will freeze -- that part is
> > intentional), then let's talk through it and see how to address them.
> >
> > Thanks,
> > Nicolai
> >
> >
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Nicolai H=C3=A4hnle <nicolai.haehnle@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 32 ++++++++++++++++++++=
+++-
> >>>    1 file changed, 31 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.c
> >>> index dc474b809604..32d223daa789 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>> @@ -471,35 +471,65 @@ static ssize_t amdgpu_debugfs_ring_read(struct =
file *f, char __user *buf,
> >>>
> >>>         return result;
> >>>    }
> >>>
> >>>    static const struct file_operations amdgpu_debugfs_ring_fops =3D {
> >>>         .owner =3D THIS_MODULE,
> >>>         .read =3D amdgpu_debugfs_ring_read,
> >>>         .llseek =3D default_llseek
> >>>    };
> >>>
> >>> +static int amdgpu_debugfs_timeout_ring_get(void *data, u64 *val) {
> >>> +     struct amdgpu_ring *ring =3D data;
> >>> +
> >>> +     if (ring->sched.timeout =3D=3D MAX_SCHEDULE_TIMEOUT)
> >>> +             *val =3D 0;
> >>> +     else
> >>> +             *val =3D jiffies_to_msecs(ring->sched.timeout);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int amdgpu_debugfs_timeout_ring_set(void *data, u64 val) {
> >>> +     struct amdgpu_ring *ring =3D data;
> >>> +
> >>> +     if (val =3D=3D 0)
> >>> +             ring->sched.timeout =3D MAX_SCHEDULE_TIMEOUT;
> >>> +     else
> >>> +             ring->sched.timeout =3D msecs_to_jiffies(val);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_timeout_ring_fops,
> >>> +                      amdgpu_debugfs_timeout_ring_get,
> >>> +                      amdgpu_debugfs_timeout_ring_set,
> >>> +                      "%llu\n");
> >>> +
> >>>    #endif
> >>>
> >>>    void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> >>>                               struct amdgpu_ring *ring)
> >>>    {
> >>>    #if defined(CONFIG_DEBUG_FS)
> >>>         struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> >>>         struct dentry *root =3D minor->debugfs_root;
> >>> -     char name[32];
> >>> +     char name[40];
> >>>
> >>>         sprintf(name, "amdgpu_ring_%s", ring->name);
> >>>         debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
> >>>                                  &amdgpu_debugfs_ring_fops,
> >>>                                  ring->ring_size + 12);
> >>>
> >>> +     sprintf(name, "amdgpu_timeout_ring_%s", ring->name);
> >>> +     debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR, root, ri=
ng,
> >>> +                         &amdgpu_debugfs_timeout_ring_fops);
> >>>    #endif
> >>>    }
> >>>
> >>>    /**
> >>>     * amdgpu_ring_test_helper - tests ring and set sched readiness st=
atus
> >>>     *
> >>>     * @ring: ring to try the recovery on
> >>>     *
> >>>     * Tests ring and set sched readiness status
> >>>     *
> >
>


--=20
Lerne, wie die Welt wirklich ist,
aber vergiss niemals, wie sie sein sollte.

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C322AEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 13:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290D110E4DF;
	Thu, 15 Jun 2023 13:14:43 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF2610E4DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 13:14:41 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1a99f39a387so555915fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686834880; x=1689426880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqo8qvVl+UNe9ViWHJ/+P2WmvR4lYzzwX9aC1s+fshg=;
 b=ChantmjcrCR6MjNP+LZrxTGqTs1kKzdtZizmAf6MOeH2RWM1567UpOklobwylRbMLV
 WFcPRBweKy2XUy+Uxjx6oy1f7sbkkIZYS0CpnBoyTVoRYMq753vIK0VIh7nTctaaAjlB
 3y7rVhVFKnRQ6w1JHL45liV71FQXypmePBz1aw20JnzgJaPXe6J9YiZrwbxKW7wFPjmQ
 cl+EGm6F+ajni4Q6k1JIC81BbPjUHAfP8xMTtiuu89zO5VYdqnFLmy9qnI1X5KZOCxNg
 FvjgfhGMBpRIZhFP3ryRFiDf1kUTOSG3bAOinmrjdOZZaFgnzHylLb3nZc/UcY7q9lRV
 BVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686834880; x=1689426880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqo8qvVl+UNe9ViWHJ/+P2WmvR4lYzzwX9aC1s+fshg=;
 b=UKbqTYL/ufWkxrj318l0W7ZYDCjLfxZLDvekdOi4bRO85w3VUXmAs77pHYqCQz7L6z
 Jy9S1tS+1fLFCfme5rUpCqClvNHe78PWs8KAcxB0Fi84fAWQU0TZvYZu+GvLYU9WiWnc
 rMjbZINThCqtQiLvzDjZbJdneH3qRRDoa61WDHGTpmpC25hYF85C0MBD7fhqMxS70kuu
 guLsV9Bozd89G4DX0uVsg5M6oIVsGCWVrujx7WrUDhqa0jpfDFcy6mrDWx/Wkm9PpF7S
 OehbKcKWQheirboclD3xmhBq9S1VxMO5+L9NXVTqMB5gVmpG5lamsbsLtm6GvjNgqIP/
 tXWA==
X-Gm-Message-State: AC+VfDzPLM6u/vwfihkcilNstwLhG8pbpenWYftcgYhoMWf5Y9ToHkEh
 wkPs0yVNlJ8l6QXv5SWd4YC7AH2euHqWDDuvpbNL/2wM
X-Google-Smtp-Source: ACHHUZ7tneCiPbK2HCC9X6EAOSY3FTiIDNR+SHyrzUQ6UPmdP4/gc+GbS1aSSXEVF9CHRESTkPufS5UVpgwsATpJimA=
X-Received: by 2002:a05:6870:85c4:b0:19f:a340:232 with SMTP id
 g4-20020a05687085c400b0019fa3400232mr12742133oal.10.1686834880539; Thu, 15
 Jun 2023 06:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230614112758.120429-1-nicolai.haehnle@amd.com>
 <cca52290-bd13-e9e9-297c-e480acaef782@gmail.com>
 <DM4PR12MB596202BE54818219FEC63746FF5AA@DM4PR12MB5962.namprd12.prod.outlook.com>
 <CAO4GU+A4rZWfP5VOnx1ubTbm9Jb8z6z1BkUU+mJKNaNj_f9=aQ@mail.gmail.com>
 <ae3eb473-ba76-1a3a-f063-388a00766164@gmail.com>
 <CAO4GU+D1SDsRk+Oe0KfGSh3Rivvnb6RTaGO59bByeD3M5Q2qGQ@mail.gmail.com>
 <9c24612a-d9e7-4319-ce9f-df51fb74a6fe@gmail.com>
In-Reply-To: <9c24612a-d9e7-4319-ce9f-df51fb74a6fe@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jun 2023 09:14:29 -0400
Message-ID: <CADnq5_M27+AtDErXzyAaA82exN51NGWuJXHwWrERL0o_6qe=UQ@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle@gmail.com>, "Haehnle,
 Nicolai" <Nicolai.Haehnle@amd.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>, Daniel Vetter <daniel@ffwll.ch>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 15, 2023 at 5:14=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 15.06.23 um 10:55 schrieb Nicolai H=C3=A4hnle:
> > On Thu, Jun 15, 2023 at 9:47=E2=80=AFAM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >>>> Uh, that's very dangerous what you do here and wouldn't work in a wh=
ole
> >>>> bunch of cases.
> >>> Please elaborate: *what* case doesn't work?
> >> The core memory management can wait at any time for the GPU reset to f=
inish.
> >>
> >> If we set the timeout to infinity we risk just deadlocking the kernel.
> > Okay, thanks. I may have seen some aspect of this before in cases
> > where GPU reset failed and left processes in an unkillable state.
> >
> > I'll be honest, I've seen my fair share of exotic GPU hangs and to put
> > it mildly I'm not impressed by the kernel's handling of them.
>
> Yeah, and I completely agree with you. The whole situation around that
> is just horrible.
>
> > Obviously you know much more about the intricacies of kernel memory
> > management than I do, but the fact that processes can end up in an
> > unkillable state for *any* GPU-related reason feels to me like the
> > result of a bad design decision somewhere.
> >
> > But anyway, I'm not even asking you to fix those problems. All I'm
> > asking you is to let me do *my* job, part of which is to help prevent
> > GPU hangs from happening in the first place. For that, I need useful
> > debugging facilities -- and so do others.
> >
> >
> >>> Again, being able to disable GPU recovery is a crucial debugging
> >>> feature. We need to be able to inspect the live state of hung shaders=
,
> >>> and we need to be able to single-step through shaders. All of that
> >>> requires disabling GPU recovery.
> >> Yeah, I'm perfectly aware of that. The problem is this is just *not*
> >> supported on Linux for graphics shaders.
> >>
> >> What you can do is to run the shader with something like CWSR enabled
> >> (or an to be invented graphics equivalent). Since we are debugging the
> >> shader anyway that should be possible I think.
> >>
> >>> Forcing people to reboot just to be able to disable GPU recovery for
> >>> debugging is developer hostile.
> >> Well, I think you misunderstood me. The suggestion was even to force
> >> them to re-compile the kernel driver to disable GPU recovery.
> >>
> >> Disabling GPU recovery is *not* something you can do and expect the
> >> system to be stable.
> >>
> >> The only case we can do that is when we attach a JTAG debugger in an A=
MD
> >> lab.
> > You're being *completely* unreasonable here. Even Windows(!) allows
> > disabling GPU recovery at runtime from software, and Windows is
> > usually far more developer hostile than Linux in these things.
> > Seriously, this level of hostility against developers coming from you
> > is not okay.
>
> Well, I'm not hostile against developers, but just realistic that this
> will lead to even more problems.
>
> And I rather avoid problems with end-users than with developers because
> the later are usually the more skilled people.
>
> As far as I can see that Windows allowed to disable GPU recovery was
> actually the source of the problem and is absolutely no argument to
> repeat the same mistake on Linux again.
>
> > Yes, it's a tool that has sharp edges. That is perfectly well
> > understood. If we need to add warning labels then so be it. And if the
> > details of *how* to change the timeout or disable GPU recovery at
> > runtime should be changed, that too is fine. But it's an important
> > tool. Can we please just move forward on this in a pragmatic fashion?
>
> Yes and because of this I'm just rejecting this approach here.
>
> Rebooting to disable GPU reset is perfectly fine and reasonable to do
> for a developer.
>
> As I said the requirement I have for the other extreme is to make it a
> compile time only option and I'm trying to avoid that as well.

I have to agree with Nicolai here.  I think it's reasonable to be able
to enable a debugging mode at runtime if you are root.  There are
plenty of other dangerous things you can do via debugfs.  This is the
least of our worries.  Pretty much the first thing anyone one does
when trying to debug a hang is to disable reset.  This seems like a
nice compromise.

Alex

>
> Regards,
> Christian.
>
> >
> > Thanks,
> > Nicolai
> >
> >
> >> Regards,
> >> Christian.
> >>
> >>> So again, if there really are cases where this "doesn't work" (and
> >>> those cases aren't just that your desktop will freeze -- that part is
> >>> intentional), then let's talk through it and see how to address them.
> >>>
> >>> Thanks,
> >>> Nicolai
> >>>
> >>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> Signed-off-by: Nicolai H=C3=A4hnle <nicolai.haehnle@amd.com>
> >>>>> ---
> >>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 32 +++++++++++++++++=
++++++-
> >>>>>     1 file changed, 31 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ring.c
> >>>>> index dc474b809604..32d223daa789 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>>>> @@ -471,35 +471,65 @@ static ssize_t amdgpu_debugfs_ring_read(struc=
t file *f, char __user *buf,
> >>>>>
> >>>>>          return result;
> >>>>>     }
> >>>>>
> >>>>>     static const struct file_operations amdgpu_debugfs_ring_fops =
=3D {
> >>>>>          .owner =3D THIS_MODULE,
> >>>>>          .read =3D amdgpu_debugfs_ring_read,
> >>>>>          .llseek =3D default_llseek
> >>>>>     };
> >>>>>
> >>>>> +static int amdgpu_debugfs_timeout_ring_get(void *data, u64 *val) {
> >>>>> +     struct amdgpu_ring *ring =3D data;
> >>>>> +
> >>>>> +     if (ring->sched.timeout =3D=3D MAX_SCHEDULE_TIMEOUT)
> >>>>> +             *val =3D 0;
> >>>>> +     else
> >>>>> +             *val =3D jiffies_to_msecs(ring->sched.timeout);
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int amdgpu_debugfs_timeout_ring_set(void *data, u64 val) {
> >>>>> +     struct amdgpu_ring *ring =3D data;
> >>>>> +
> >>>>> +     if (val =3D=3D 0)
> >>>>> +             ring->sched.timeout =3D MAX_SCHEDULE_TIMEOUT;
> >>>>> +     else
> >>>>> +             ring->sched.timeout =3D msecs_to_jiffies(val);
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_timeout_ring_fops,
> >>>>> +                      amdgpu_debugfs_timeout_ring_get,
> >>>>> +                      amdgpu_debugfs_timeout_ring_set,
> >>>>> +                      "%llu\n");
> >>>>> +
> >>>>>     #endif
> >>>>>
> >>>>>     void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> >>>>>                                struct amdgpu_ring *ring)
> >>>>>     {
> >>>>>     #if defined(CONFIG_DEBUG_FS)
> >>>>>          struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> >>>>>          struct dentry *root =3D minor->debugfs_root;
> >>>>> -     char name[32];
> >>>>> +     char name[40];
> >>>>>
> >>>>>          sprintf(name, "amdgpu_ring_%s", ring->name);
> >>>>>          debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ri=
ng,
> >>>>>                                   &amdgpu_debugfs_ring_fops,
> >>>>>                                   ring->ring_size + 12);
> >>>>>
> >>>>> +     sprintf(name, "amdgpu_timeout_ring_%s", ring->name);
> >>>>> +     debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR, root, =
ring,
> >>>>> +                         &amdgpu_debugfs_timeout_ring_fops);
> >>>>>     #endif
> >>>>>     }
> >>>>>
> >>>>>     /**
> >>>>>      * amdgpu_ring_test_helper - tests ring and set sched readiness=
 status
> >>>>>      *
> >>>>>      * @ring: ring to try the recovery on
> >>>>>      *
> >>>>>      * Tests ring and set sched readiness status
> >>>>>      *
> >
>

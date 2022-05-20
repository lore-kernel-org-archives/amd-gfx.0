Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8046DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 17:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33CA010F13B;
	Fri, 20 May 2022 17:41:17 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C61710F36F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 17:41:16 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id i11so15354976ybq.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=i2V9nUANa32gCzfCpMyssZ6mYdCt7P6ydnonHd2X+i4=;
 b=RY+W1orO78HkdSrxPO7nRCkFBL8C7crJajJoRhayfmRaxd6M3CYT6hZwQbsP/pJ/ra
 2sQqCHnnvlmKbK8/5e3yZITI1iglS38BY3YUfz5521dejw7mbPSoPZmH1jSyYm96t2fF
 PY514V4VbzQo2xvOSUVuUI7ZxatFObbkDoqtuZKGBpLxOiAS8mDamiHpd/x6KIr0MEwb
 KqXvrWrGegCq6caxmDVXs8cUF4dU0DHxFt7+3mY5iXEyhlJ9kYH+qwWUNOVhXjDG6ZGR
 6RUeiIM5i/foMLwJ84NHbaeS1t8o7sKOC1NOM/WGe98CSCDm38hHs7jhMYYqWjgdQ8Yc
 J/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=i2V9nUANa32gCzfCpMyssZ6mYdCt7P6ydnonHd2X+i4=;
 b=rK/xZ1CRwRR9pqOAs3ujKxZ7TA3m+OX+7AiVhEmrUUpHHVno9tQAu1aeEEkpDc9Wmf
 sxZ00qGvs1jVD7JBdZoQF98Eo2lVL+Gho15BjyK2UlfHFji4r4u+GhQFnUKIjuEv4u9A
 krVb2349QnV9bS60YPd5UmiMR9Mn/8jpSr4WdTxxkGcbfy6P+N+kaSVPsB7grt5Ue2be
 lZRsB5hqR13hBEy9jNSE0btDumMa8QxUrzZ+5NeUedRBaXo0DOEEKzbqoVq0ESh2Ksp5
 nHHVxS8NmCaI2fjdZOYUW6gCEqO97oplf8IpmUJhp9j3yfbEFkwPNc9RT+8ksZBp77td
 lugw==
X-Gm-Message-State: AOAM530UrBFnrTgMHOGhzTiqn4gv7KjJYTRLKrVW7hHfvawmWP3+1kb6
 A+arVSkyWFxNWhTegkoO8FvdW5E1/IQwMPGNbZj0mA==
X-Google-Smtp-Source: ABdhPJzVHoCBGDJLaD0+jz3fsg+iudX6gL4CHEHQpcp8L9zmi3Q/cu1tKLz7Y/Zp5BUac+gbS/9RT3F31qA2vXj/1R8=
X-Received: by 2002:a25:ba91:0:b0:64f:5f75:b6b1 with SMTP id
 s17-20020a25ba91000000b0064f5f75b6b1mr3882280ybg.368.1653068475511; Fri, 20
 May 2022 10:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
 <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
In-Reply-To: <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 20 May 2022 19:41:27 +0200
Message-ID: <CAP+8YyHE79regLR47v29G_qmitR-WOfjOQR-R1nNf5aMVVqFbA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 20, 2022 at 11:42 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> In theory we should allow much more than that. The problem is just that w=
e can't.
>
> We have the following issues:
> 1. For swapping out stuff we need to make sure that we can allocate tempo=
rary pages.
>     Because of this TTM has a fixed 50% limit where it starts to unmap me=
mory from GPUs.
>     So currently even with a higher GTT limit you can't actually use this=
.
>
> 2. Apart from the test case of allocating textures with increasing power =
of two until it fails we also have a bunch of extremely stupid applications=
.
>     E.g. stuff like looking at the amount of memory available and trying =
preallocate everything.

I hear you but we also have an increasing number of games that don't
even start with 3 GiB. At some point (which I'd speculate has already
been reached, I've seen a number of complaints of games that ran on
deck but not on desktop linux because on deck we set amdgpu.gttsize)
we have more games broken due to the low limit than there would be
apps broken due to a high limit.

>
> I'm working on this for years, but there aren't easy solutions to those i=
ssues. Felix has opted out for adding a separate domain for KFD allocations=
, but sooner or later we need to find a solution which works for everybody.
>
> Christian.
>
> Am 20.05.22 um 11:14 schrieb Marek Ol=C5=A1=C3=A1k:
>
> Ignore the silly tests. We only need to make sure games work. The current=
 minimum requirement for running modern games is 8GB of GPU memory. Soon it=
 will be 12GB. APUs will need to support that.
>
> Marek
>
> On Fri., May 20, 2022, 03:52 Christian K=C3=B6nig, <ckoenig.leichtzumerke=
n@gmail.com> wrote:
>>
>> Am 19.05.22 um 16:34 schrieb Alex Deucher:
>> > The current somewhat strange logic is in place because certain
>> > GL unit tests for large textures can cause problems with the
>> > OOM killer since there is no way to link this memory to a
>> > process.  The problem is this limit is often too low for many
>> > modern games on systems with more memory so limit the logic to
>> > systems with less than 8GB of main memory.  For systems with 8
>> > or more GB of system memory, set the GTT size to 3/4 of system
>> > memory.
>>
>> It's unfortunately not only the unit tests, but some games as well.
>>
>> 3/4 of total system memory sounds reasonable to be, but I'm 100% sure
>> that this will break some tests.
>>
>> Christian.
>>
>> >
>> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 ++++++++++++++++++++---=
--
>> >   1 file changed, 20 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c
>> > index 4b9ee6e27f74..daa0babcf869 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> > @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev=
)
>> >       /* Compute GTT size, either bsaed on 3/4th the size of RAM size
>> >        * or whatever the user passed on module init */
>> >       if (amdgpu_gtt_size =3D=3D -1) {
>> > +             const u64 eight_GB =3D 8192ULL * 1024 * 1024;
>> >               struct sysinfo si;
>> > +             u64 total_memory, default_gtt_size;
>> >
>> >               si_meminfo(&si);
>> > -             gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>> > -                            adev->gmc.mc_vram_size),
>> > -                            ((uint64_t)si.totalram * si.mem_unit * 3/=
4));
>> > -     }
>> > -     else
>> > +             total_memory =3D (u64)si.totalram * si.mem_unit;
>> > +             default_gtt_size =3D total_memory * 3 / 4;
>> > +             /* This somewhat strange logic is in place because certa=
in GL unit
>> > +              * tests for large textures can cause problems with the =
OOM killer
>> > +              * since there is no way to link this memory to a proces=
s.
>> > +              * The problem is this limit is often too low for many m=
odern games
>> > +              * on systems with more memory so limit the logic to sys=
tems with
>> > +              * less than 8GB of main memory.
>> > +              */
>> > +             if (total_memory < eight_GB) {
>> > +                     gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB=
 << 20),
>> > +                                        adev->gmc.mc_vram_size),
>> > +                                    default_gtt_size);
>> > +             } else {
>> > +                     gtt_size =3D default_gtt_size;
>> > +             }
>> > +     } else {
>> >               gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
>> > +     }
>> >
>> >       /* Initialize GTT memory pool */
>> >       r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
>>
>

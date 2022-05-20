Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B59FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 10:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70D010EEDB;
	Fri, 20 May 2022 10:15:05 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B306910ED61
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 10:15:04 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id a11so7401071pff.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tER7IhwylpKOsFXSAgvwshpwK5Jsh4a50SR+7a3MTCA=;
 b=ZQmox5u9lOBoV4dtny5bLs4MILT/nrxcdnPOCgJ81VtShFCjBR06ox5H2EjhD6CKVU
 pMmWCpdR2zClTbULGoL+YoUYpuRNcoPYh/AWp1kIDCs9N4bvphDyC5B1y2Pb0eitmUNW
 qkIPFaCKS4qQV/R1eONe4NCd5PAWkbbGfyCkxJVz9jw0KuhRw0+r/2EPArNa1TCiFl1A
 QRmJxgunKCFsLutt/kP6lrTL1dkft12WuSLkJyOqwte98FsEf83ufM2/YjMPida8kHMJ
 Ry0x5m02JunXsIgVcK7E7A2I8CZSwgbebBQG66iiOBfy2b1VVcdeOnepVf3UXjAV+pk2
 jsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tER7IhwylpKOsFXSAgvwshpwK5Jsh4a50SR+7a3MTCA=;
 b=rudUkkKg2NJ0PyhAHjvdhu/01WZtI27CfidSw8GpHW1T/Qi0uE4q8wapK+ufmKlDLf
 D57izZcTyUlDIqN8Cfr5bjAlPYFQNHzkyCt5tpH6isiQZYyr3KFUZxgF4HX6hjd0e9IP
 kAcj3rw+tkmLgZEmD0kBDuAKKXzRlm3JalK5uZPyJbWicLVaPXHrVowaZisAKoRc2kbF
 2SulZCcCv49Qu++hwf/xqF8plwLVSxMVwWIp+AMW9jhpSqyQd+PSKqUXDEffEHASdAv7
 8YwazX78KrePM+kl1Gzs1jHg70LzTbP5FUyJKgKpopQXEOVOxHYv4kVqAX/BviPlzloG
 VRSw==
X-Gm-Message-State: AOAM530ISCztsDxaj6bH9r9j0DfzXyz3JKNUUnauSpDV5E6m6RFyhaAo
 VDUPHo4aecGZS48gujAckQpC7n/DOcb1jphEULg=
X-Google-Smtp-Source: ABdhPJwoCTYDfQ1jhFewnwzW1I02nHzpDVoFlG0zfrdAkxyG7do4pCvQJK/g23iQiD2ftJOml92O1LruvNgAVTBIR7I=
X-Received: by 2002:a05:6a00:c95:b0:517:f266:465 with SMTP id
 a21-20020a056a000c9500b00517f2660465mr9251451pfv.42.1653041704266; Fri, 20
 May 2022 03:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
 <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
In-Reply-To: <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 20 May 2022 06:14:52 -0400
Message-ID: <CAAxE2A7oRFDw5HPaSNSJ24bPzCXQ3-edkV+k=Xo1fG9+5PuFaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000094ee8605df6ec38b"
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
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000094ee8605df6ec38b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1. So make gtt =3D ram/2. There's your 50%.

2. Not our problem.

Marek

On Fri., May 20, 2022, 05:42 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

> In theory we should allow much more than that. The problem is just that w=
e
> can't.
>
> We have the following issues:
> 1. For swapping out stuff we need to make sure that we can allocate
> temporary pages.
>     Because of this TTM has a fixed 50% limit where it starts to unmap
> memory from GPUs.
>     So currently even with a higher GTT limit you can't actually use this=
.
>
> 2. Apart from the test case of allocating textures with increasing power
> of two until it fails we also have a bunch of extremely stupid applicatio=
ns.
>     E.g. stuff like looking at the amount of memory available and trying
> preallocate everything.
>
> I'm working on this for years, but there aren't easy solutions to those
> issues. Felix has opted out for adding a separate domain for KFD
> allocations, but sooner or later we need to find a solution which works f=
or
> everybody.
>
> Christian.
>
> Am 20.05.22 um 11:14 schrieb Marek Ol=C5=A1=C3=A1k:
>
> Ignore the silly tests. We only need to make sure games work. The current
> minimum requirement for running modern games is 8GB of GPU memory. Soon i=
t
> will be 12GB. APUs will need to support that.
>
> Marek
>
> On Fri., May 20, 2022, 03:52 Christian K=C3=B6nig, <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
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
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
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
>> > -                            ((uint64_t)si.totalram * si.mem_unit *
>> 3/4));
>> > -     }
>> > -     else
>> > +             total_memory =3D (u64)si.totalram * si.mem_unit;
>> > +             default_gtt_size =3D total_memory * 3 / 4;
>> > +             /* This somewhat strange logic is in place because
>> certain GL unit
>> > +              * tests for large textures can cause problems with the
>> OOM killer
>> > +              * since there is no way to link this memory to a proces=
s.
>> > +              * The problem is this limit is often too low for many
>> modern games
>> > +              * on systems with more memory so limit the logic to
>> systems with
>> > +              * less than 8GB of main memory.
>> > +              */
>> > +             if (total_memory < eight_GB) {
>> > +                     gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB=
 <<
>> 20),
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
>>
>

--00000000000094ee8605df6ec38b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">1. So make gtt =3D ram/2. There&#39;s your 50%.<div dir=
=3D"auto"><br></div><div dir=3D"auto">2. Not our problem.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Marek</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri., May 20, 2022, 05:42 C=
hristian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com=
">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
 =20
   =20
 =20
  <div>
    In theory we should allow much more than that. The problem is just
    that we can&#39;t.<br>
    <br>
    We have the following issues:<br>
    1. For swapping out stuff we need to make sure that we can allocate
    temporary pages.<br>
    =C2=A0=C2=A0=C2=A0 Because of this TTM has a fixed 50% limit where it s=
tarts to
    unmap memory from GPUs.<br>
    =C2=A0=C2=A0=C2=A0 So currently even with a higher GTT limit you can&#3=
9;t actually use
    this.<br>
    <br>
    2. Apart from the test case of allocating textures with increasing
    power of two until it fails we also have a bunch of extremely stupid
    applications.<br>
    =C2=A0=C2=A0=C2=A0 E.g. stuff like looking at the amount of memory avai=
lable and
    trying preallocate everything.<br>
    <br>
    I&#39;m working on this for years, but there aren&#39;t easy solutions =
to
    those issues. Felix has opted out for adding a separate domain for
    KFD allocations, but sooner or later we need to find a solution
    which works for everybody.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 20.05.22 um 11:14 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">Ignore the silly tests. We only need to make sure
        games work. The current minimum requirement for running modern
        games is 8GB of GPU memory. Soon it will be 12GB. APUs will need
        to support that.
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Fri., May 20, 2022, 03:52
          Christian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerke=
n@gmail.com" target=3D"_blank" rel=3D"noreferrer">ckoenig.leichtzumerken@gm=
ail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Am 19.05.22
          um 16:34 schrieb Alex Deucher:<br>
          &gt; The current somewhat strange logic is in place because
          certain<br>
          &gt; GL unit tests for large textures can cause problems with
          the<br>
          &gt; OOM killer since there is no way to link this memory to a<br=
>
          &gt; process.=C2=A0 The problem is this limit is often too low fo=
r
          many<br>
          &gt; modern games on systems with more memory so limit the
          logic to<br>
          &gt; systems with less than 8GB of main memory.=C2=A0 For systems
          with 8<br>
          &gt; or more GB of system memory, set the GTT size to 3/4 of
          system<br>
          &gt; memory.<br>
          <br>
          It&#39;s unfortunately not only the unit tests, but some games as
          well.<br>
          <br>
          3/4 of total system memory sounds reasonable to be, but I&#39;m
          100% sure <br>
          that this will break some tests.<br>
          <br>
          Christian.<br>
          <br>
          &gt;<br>
          &gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.=
deucher@amd.com" rel=3D"noreferrer noreferrer" target=3D"_blank">alexander.=
deucher@amd.com</a>&gt;<br>
          &gt; ---<br>
          &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25
          ++++++++++++++++++++-----<br>
          &gt;=C2=A0 =C2=A01 file changed, 20 insertions(+), 5 deletions(-)=
<br>
          &gt;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt; index 4b9ee6e27f74..daa0babcf869 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt; @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct
          amdgpu_device *adev)<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Compute GTT size, either bsaed =
on 3/4th the size
          of RAM size<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * or whatever the user passed on =
module init */<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_gtt_size =3D=3D -1) {<b=
r>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const u64 e=
ight_GB =3D 8192ULL * 1024 * 1024;<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 sysinfo si;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 total_m=
emory, default_gtt_size;<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_mem=
info(&amp;si);<br>
          &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtt_size =
=3D
          min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
          &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gmc.mc_vram_size),<br>
          &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint64_t)si.totalram *
          si.mem_unit * 3/4));<br>
          &gt; -=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; -=C2=A0 =C2=A0 =C2=A0else<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_memor=
y =3D (u64)si.totalram *
          si.mem_unit;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default_gtt=
_size =3D total_memory * 3 / 4;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This som=
ewhat strange logic is in place
          because certain GL unit<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * tests fo=
r large textures can cause
          problems with the OOM killer<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * since th=
ere is no way to link this
          memory to a process.<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The prob=
lem is this limit is often too
          low for many modern games<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * on syste=
ms with more memory so limit the
          logic to systems with<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * less tha=
n 8GB of main memory.<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total_m=
emory &lt; eight_GB) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0gtt_size =3D
          min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
          adev-&gt;gmc.mc_vram_size),<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_=
gtt_size);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br=
>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0gtt_size =3D default_gtt_size;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtt_si=
ze =3D (uint64_t)amdgpu_gtt_size
          &lt;&lt; 20;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initialize GTT memory pool */<b=
r>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_gtt_mgr_init(adev, gt=
t_size);<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--00000000000094ee8605df6ec38b--

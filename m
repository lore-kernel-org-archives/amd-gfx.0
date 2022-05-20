Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA405C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 21:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4C710FE08;
	Fri, 20 May 2022 21:36:53 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF78E10EFB6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 21:36:51 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 l7-20020a17090aaa8700b001dd1a5b9965so8857418pjq.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jtzworE6bWtpGbQdHKAgR3c9aOgocyUE8VFkS/uUMDY=;
 b=gn9LIm5gflwm3P0oVuuvGG0yw4ABl8rPAe1dYDZ/O5s7Uo7a2e1yo6bV7g1ZEn41vC
 v7Arym1QhgyXTQQt4iWakFBKU3d+Tkmf0VVnreqU8vKVhSJAuaWtt+MS7wxnZBbRjCYe
 HJ51DGpSp+gQu78WBv9OD8AFBnp31UQxPv/BmWx75QCiWBEwWQTyZVBendyFl+8Q1PDy
 3z0PEhnsqzDjxRK24RDOIgtb5lPDRB7VLotDUfzHLM3sh7+7LEQ3yvAZUqqEotvmbMKA
 imvxuJlpM6QqKWxTkAggUakwrcKnSe8YPEnA5FgXDx0DL8lDYzVr+MdrQeEU1XMp21Hs
 yGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jtzworE6bWtpGbQdHKAgR3c9aOgocyUE8VFkS/uUMDY=;
 b=CHjKmfPcip+j8J6lxPZGQgPkv8l2V5W3AH5HvrwUaV9LqyFT2MWT50NXASytgEptA1
 FPYh9kjWZsxqQj3jUGGDPzk+SfDvqU8rwDl2nKAgahjSR9/WCjiRmWIRoyXORT/XWDDA
 b1RjccFEVLpblPMsezRcr0zAs7PoPzOCO/jhx/fx/d2pz9mtLCigAr3zc5mOblQJPiqS
 scmIbTIjwl19GvfR8urzQwt8FK8x/13yr6KFv7LS7HzAd0zz5cOHcpBgV/2vVsQxVP/e
 LoSMPaGMp74uObNBJL/LZ87VmWE+PqU3YxYwNeTyBYGIOoaFyTasrPB8x/MwCQg9VFA7
 UVGA==
X-Gm-Message-State: AOAM531gGqYFNi1NfgeuuRf7g/wYMGYRnakqxlrU0BXnvCbqb3mhI3Lq
 MzAPRLciqmJhZLdp6y1G3tplaH9A8IULiHe7/Z4=
X-Google-Smtp-Source: ABdhPJyuBg4dgEyMiMD02j/AbYeNejSlFvqvs6jFU/Y4T4cZUaDVUGaVUZY+kJLaoJxoki7OpHAA8FPtaFHTXtyMwwI=
X-Received: by 2002:a17:902:74cc:b0:161:8f4d:17b8 with SMTP id
 f12-20020a17090274cc00b001618f4d17b8mr11701840plt.96.1653082611177; Fri, 20
 May 2022 14:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
 <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
 <CAP+8YyHE79regLR47v29G_qmitR-WOfjOQR-R1nNf5aMVVqFbA@mail.gmail.com>
 <67d39c05-d798-9515-5dec-7a2c4eb534d0@gmail.com>
In-Reply-To: <67d39c05-d798-9515-5dec-7a2c4eb534d0@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 20 May 2022 17:36:38 -0400
Message-ID: <CAAxE2A7opvBLs-VgfyNSSRRctmomZjM7y0C5s8FNuhR2V2Mt5w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d2de2805df784999"
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
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000d2de2805df784999
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We don't have to care about case 2 here. Broken apps will be handled by app
profiles. The problem is that some games don't work with the current limit
on the most powerful consumer APU we've ever made (Rembrandt) with
precisely the games that the APU was made for, and instead of increasing
the limit, we continue arguing about some TTM stuff that doesn't help
anything right now.

Marek

On Fri., May 20, 2022, 14:25 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 20.05.22 um 19:41 schrieb Bas Nieuwenhuizen:
> > On Fri, May 20, 2022 at 11:42 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> In theory we should allow much more than that. The problem is just tha=
t
> we can't.
> >>
> >> We have the following issues:
> >> 1. For swapping out stuff we need to make sure that we can allocate
> temporary pages.
> >>      Because of this TTM has a fixed 50% limit where it starts to unma=
p
> memory from GPUs.
> >>      So currently even with a higher GTT limit you can't actually use
> this.
> >>
> >> 2. Apart from the test case of allocating textures with increasing
> power of two until it fails we also have a bunch of extremely stupid
> applications.
> >>      E.g. stuff like looking at the amount of memory available and
> trying preallocate everything.
> > I hear you but we also have an increasing number of games that don't
> > even start with 3 GiB. At some point (which I'd speculate has already
> > been reached, I've seen a number of complaints of games that ran on
> > deck but not on desktop linux because on deck we set amdgpu.gttsize)
> > we have more games broken due to the low limit than there would be
> > apps broken due to a high limit.
>
> That's a really good argument, but the issue is that it is fixable. It's
> just that nobody had time to look into all the issues.
>
> If started efforts to fix this years ago, but there was always something
> more important going on.
>
> So we are left with the choice of breaking old applications or new
> applications or getting somebody working on fixing this.
>
> Christian.
>
> >
> >> I'm working on this for years, but there aren't easy solutions to thos=
e
> issues. Felix has opted out for adding a separate domain for KFD
> allocations, but sooner or later we need to find a solution which works f=
or
> everybody.
> >>
> >> Christian.
> >>
> >> Am 20.05.22 um 11:14 schrieb Marek Ol=C5=A1=C3=A1k:
> >>
> >> Ignore the silly tests. We only need to make sure games work. The
> current minimum requirement for running modern games is 8GB of GPU memory=
.
> Soon it will be 12GB. APUs will need to support that.
> >>
> >> Marek
> >>
> >> On Fri., May 20, 2022, 03:52 Christian K=C3=B6nig, <
> ckoenig.leichtzumerken@gmail.com> wrote:
> >>> Am 19.05.22 um 16:34 schrieb Alex Deucher:
> >>>> The current somewhat strange logic is in place because certain
> >>>> GL unit tests for large textures can cause problems with the
> >>>> OOM killer since there is no way to link this memory to a
> >>>> process.  The problem is this limit is often too low for many
> >>>> modern games on systems with more memory so limit the logic to
> >>>> systems with less than 8GB of main memory.  For systems with 8
> >>>> or more GB of system memory, set the GTT size to 3/4 of system
> >>>> memory.
> >>> It's unfortunately not only the unit tests, but some games as well.
> >>>
> >>> 3/4 of total system memory sounds reasonable to be, but I'm 100% sure
> >>> that this will break some tests.
> >>>
> >>> Christian.
> >>>
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25
> ++++++++++++++++++++-----
> >>>>    1 file changed, 20 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>> index 4b9ee6e27f74..daa0babcf869 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>> @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device
> *adev)
> >>>>        /* Compute GTT size, either bsaed on 3/4th the size of RAM si=
ze
> >>>>         * or whatever the user passed on module init */
> >>>>        if (amdgpu_gtt_size =3D=3D -1) {
> >>>> +             const u64 eight_GB =3D 8192ULL * 1024 * 1024;
> >>>>                struct sysinfo si;
> >>>> +             u64 total_memory, default_gtt_size;
> >>>>
> >>>>                si_meminfo(&si);
> >>>> -             gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20=
),
> >>>> -                            adev->gmc.mc_vram_size),
> >>>> -                            ((uint64_t)si.totalram * si.mem_unit *
> 3/4));
> >>>> -     }
> >>>> -     else
> >>>> +             total_memory =3D (u64)si.totalram * si.mem_unit;
> >>>> +             default_gtt_size =3D total_memory * 3 / 4;
> >>>> +             /* This somewhat strange logic is in place because
> certain GL unit
> >>>> +              * tests for large textures can cause problems with th=
e
> OOM killer
> >>>> +              * since there is no way to link this memory to a
> process.
> >>>> +              * The problem is this limit is often too low for many
> modern games
> >>>> +              * on systems with more memory so limit the logic to
> systems with
> >>>> +              * less than 8GB of main memory.
> >>>> +              */
> >>>> +             if (total_memory < eight_GB) {
> >>>> +                     gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_=
MB
> << 20),
> >>>> +                                        adev->gmc.mc_vram_size),
> >>>> +                                    default_gtt_size);
> >>>> +             } else {
> >>>> +                     gtt_size =3D default_gtt_size;
> >>>> +             }
> >>>> +     } else {
> >>>>                gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> >>>> +     }
> >>>>
> >>>>        /* Initialize GTT memory pool */
> >>>>        r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
>
>

--000000000000d2de2805df784999
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">We don&#39;t have to care about case 2 here. Broken apps =
will be handled by app profiles. The problem is that some games don&#39;t w=
ork with the current limit on the most powerful consumer APU we&#39;ve ever=
 made (Rembrandt) with precisely the games that the APU was made for, and i=
nstead of increasing the limit, we continue arguing about some TTM stuff th=
at doesn&#39;t help anything right now.<div dir=3D"auto"><div dir=3D"auto">=
<br></div><div dir=3D"auto">Marek</div></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri., May 20, 2022, 14:25 C=
hristian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com=
">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Am 20.05.22 um 19:41 schrieb Bas Nieuwenhuizen:<br>
&gt; On Fri, May 20, 2022 at 11:42 AM Christian K=C3=B6nig<br>
&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_bla=
nk" rel=3D"noreferrer">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;&gt; In theory we should allow much more than that. The problem is just=
 that we can&#39;t.<br>
&gt;&gt;<br>
&gt;&gt; We have the following issues:<br>
&gt;&gt; 1. For swapping out stuff we need to make sure that we can allocat=
e temporary pages.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Because of this TTM has a fixed 50% limit wher=
e it starts to unmap memory from GPUs.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 So currently even with a higher GTT limit you =
can&#39;t actually use this.<br>
&gt;&gt;<br>
&gt;&gt; 2. Apart from the test case of allocating textures with increasing=
 power of two until it fails we also have a bunch of extremely stupid appli=
cations.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 E.g. stuff like looking at the amount of memor=
y available and trying preallocate everything.<br>
&gt; I hear you but we also have an increasing number of games that don&#39=
;t<br>
&gt; even start with 3 GiB. At some point (which I&#39;d speculate has alre=
ady<br>
&gt; been reached, I&#39;ve seen a number of complaints of games that ran o=
n<br>
&gt; deck but not on desktop linux because on deck we set amdgpu.gttsize)<b=
r>
&gt; we have more games broken due to the low limit than there would be<br>
&gt; apps broken due to a high limit.<br>
<br>
That&#39;s a really good argument, but the issue is that it is fixable. It&=
#39;s <br>
just that nobody had time to look into all the issues.<br>
<br>
If started efforts to fix this years ago, but there was always something <b=
r>
more important going on.<br>
<br>
So we are left with the choice of breaking old applications or new <br>
applications or getting somebody working on fixing this.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt;&gt; I&#39;m working on this for years, but there aren&#39;t easy solut=
ions to those issues. Felix has opted out for adding a separate domain for =
KFD allocations, but sooner or later we need to find a solution which works=
 for everybody.<br>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 20.05.22 um 11:14 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt;&gt;<br>
&gt;&gt; Ignore the silly tests. We only need to make sure games work. The =
current minimum requirement for running modern games is 8GB of GPU memory. =
Soon it will be 12GB. APUs will need to support that.<br>
&gt;&gt;<br>
&gt;&gt; Marek<br>
&gt;&gt;<br>
&gt;&gt; On Fri., May 20, 2022, 03:52 Christian K=C3=B6nig, &lt;<a href=3D"=
mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank" rel=3D"noreferre=
r">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; Am 19.05.22 um 16:34 schrieb Alex Deucher:<br>
&gt;&gt;&gt;&gt; The current somewhat strange logic is in place because cer=
tain<br>
&gt;&gt;&gt;&gt; GL unit tests for large textures can cause problems with t=
he<br>
&gt;&gt;&gt;&gt; OOM killer since there is no way to link this memory to a<=
br>
&gt;&gt;&gt;&gt; process.=C2=A0 The problem is this limit is often too low =
for many<br>
&gt;&gt;&gt;&gt; modern games on systems with more memory so limit the logi=
c to<br>
&gt;&gt;&gt;&gt; systems with less than 8GB of main memory.=C2=A0 For syste=
ms with 8<br>
&gt;&gt;&gt;&gt; or more GB of system memory, set the GTT size to 3/4 of sy=
stem<br>
&gt;&gt;&gt;&gt; memory.<br>
&gt;&gt;&gt; It&#39;s unfortunately not only the unit tests, but some games=
 as well.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 3/4 of total system memory sounds reasonable to be, but I&#39;=
m 100% sure<br>
&gt;&gt;&gt; that this will break some tests.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexande=
r.deucher@amd.com" target=3D"_blank" rel=3D"noreferrer">alexander.deucher@a=
md.com</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 =
++++++++++++++++++++-----<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 1 file changed, 20 insertions(+), 5 deletions=
(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt; index 4b9ee6e27f74..daa0babcf869 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt; @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_=
device *adev)<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Compute GTT size, either bsa=
ed on 3/4th the size of RAM size<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or whatever the user pa=
ssed on module init */<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_gtt_size =3D=3D -1) =
{<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const u64=
 eight_GB =3D 8192ULL * 1024 * 1024;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 str=
uct sysinfo si;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 total=
_memory, default_gtt_size;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 si_=
meminfo(&amp;si);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtt_size =
=3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gmc.mc_vram_size),<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint64_t)si.totalram * si.mem_u=
nit * 3/4));<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_mem=
ory =3D (u64)si.totalram * si.mem_unit;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default_g=
tt_size =3D total_memory * 3 / 4;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This s=
omewhat strange logic is in place because certain GL unit<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * tests =
for large textures can cause problems with the OOM killer<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * since =
there is no way to link this memory to a process.<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The pr=
oblem is this limit is often too low for many modern games<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * on sys=
tems with more memory so limit the logic to systems with<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * less t=
han 8GB of main memory.<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total=
_memory &lt; eight_GB) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&l=
t; 20),<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 adev-&gt;gmc.mc_vram_size),<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defau=
lt_gtt_size);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<=
br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0gtt_size =3D default_gtt_size;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gtt=
_size =3D (uint64_t)amdgpu_gtt_size &lt;&lt; 20;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Initialize GTT memory pool *=
/<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_gtt_mgr_init(adev,=
 gtt_size);<br>
<br>
</blockquote></div>

--000000000000d2de2805df784999--

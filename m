Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1F7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 09:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0520810E6D8;
	Fri, 20 May 2022 09:14:18 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A961510E089
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 09:14:16 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id d22so6864860plr.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lw2I2V7vymJJ3CYb+zzyiJOhZ4C1AZh7JuTgRL90pI4=;
 b=acAQGgBwymlJ4+ZF02M0vMAaRP/aDSzy5i8DeiiG/E+y/hUt5NRZ/dUz41Ljgupqww
 R/sJylmr//465sZ1WNjWxJAZdjNr+5l3K+4MuYtzzWTPU1uQf9jhf3KXZz8o86H55q7o
 tJZCw/g5//M0hF8EebH9A/jpj/1MsUSugNcgfOWLyrVK3svOwi5l4172cAoJNAl/QHAW
 X7egKYylV4xbAlPotmODoXYaA6QQjJ+9ir7hlhz5Ulus9Ym4TLtGapdt9fAikygi56N+
 pUqtSUyN42Vszgq6hobjYB5ZmfyRW4GcWtx/TKz+XDtwqfzGm6yTiUBoJASgMmdXzj+n
 N+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lw2I2V7vymJJ3CYb+zzyiJOhZ4C1AZh7JuTgRL90pI4=;
 b=oFkOWXbt+egSFFafs9WUgJ9a4/y9t75n4UV9hiT9JKxJPeXQ0+vvVla+EgSpHNutZE
 PVIaHmu3A4zES7vbwbgwCF0JSr+ol+5EiSI4lD4SKNkjudFu1QvnubsNqNJWqMe3UdX5
 VLY1bARbhUe7tWyjmwGt7sXMbUbX/y3Ul9nf0iY4fH9u6SXpl8ELM29EZ7RoX+S/x11l
 8zZ2RTPOK0LneM9GreQ3CBLvKRsJyw8O6ZkYGidwGJgF1HIUXb09HYTZHEGXrIuS9NV6
 bUPUAxvMP32xmmjobS3BGiJXiYZtCIk98U+u4mUwo+7uJrWqXuOLdyz3D+q15hnloohC
 sJAw==
X-Gm-Message-State: AOAM530ECJ+TpMM23XFodF8l2QN9hOMwvqVvGICf1nf94zLpo2ubkYN6
 n8StoOyijt927L3REzQ8UHv7Br7UKcJqlXAoeL5VtFkh
X-Google-Smtp-Source: ABdhPJzlyYyUxYc/es+rEvlyW5MCnVJGB/Xo/ddxsQ/EdcsTDmGdEMtLTzhss8s7aZ9BM9pEnSwrb8GJD6Ksi8aRO3Q=
X-Received: by 2002:a17:90b:1b49:b0:1e0:12c:3da1 with SMTP id
 nv9-20020a17090b1b4900b001e0012c3da1mr911857pjb.73.1653038056143; Fri, 20 May
 2022 02:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
In-Reply-To: <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 20 May 2022 05:14:04 -0400
Message-ID: <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000022fdd705df6dea7f"
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

--00000000000022fdd705df6dea7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ignore the silly tests. We only need to make sure games work. The current
minimum requirement for running modern games is 8GB of GPU memory. Soon it
will be 12GB. APUs will need to support that.

Marek

On Fri., May 20, 2022, 03:52 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 19.05.22 um 16:34 schrieb Alex Deucher:
> > The current somewhat strange logic is in place because certain
> > GL unit tests for large textures can cause problems with the
> > OOM killer since there is no way to link this memory to a
> > process.  The problem is this limit is often too low for many
> > modern games on systems with more memory so limit the logic to
> > systems with less than 8GB of main memory.  For systems with 8
> > or more GB of system memory, set the GTT size to 3/4 of system
> > memory.
>
> It's unfortunately not only the unit tests, but some games as well.
>
> 3/4 of total system memory sounds reasonable to be, but I'm 100% sure
> that this will break some tests.
>
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 ++++++++++++++++++++----=
-
> >   1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 4b9ee6e27f74..daa0babcf869 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >       /* Compute GTT size, either bsaed on 3/4th the size of RAM size
> >        * or whatever the user passed on module init */
> >       if (amdgpu_gtt_size =3D=3D -1) {
> > +             const u64 eight_GB =3D 8192ULL * 1024 * 1024;
> >               struct sysinfo si;
> > +             u64 total_memory, default_gtt_size;
> >
> >               si_meminfo(&si);
> > -             gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> > -                            adev->gmc.mc_vram_size),
> > -                            ((uint64_t)si.totalram * si.mem_unit *
> 3/4));
> > -     }
> > -     else
> > +             total_memory =3D (u64)si.totalram * si.mem_unit;
> > +             default_gtt_size =3D total_memory * 3 / 4;
> > +             /* This somewhat strange logic is in place because certai=
n
> GL unit
> > +              * tests for large textures can cause problems with the
> OOM killer
> > +              * since there is no way to link this memory to a process=
.
> > +              * The problem is this limit is often too low for many
> modern games
> > +              * on systems with more memory so limit the logic to
> systems with
> > +              * less than 8GB of main memory.
> > +              */
> > +             if (total_memory < eight_GB) {
> > +                     gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB =
<<
> 20),
> > +                                        adev->gmc.mc_vram_size),
> > +                                    default_gtt_size);
> > +             } else {
> > +                     gtt_size =3D default_gtt_size;
> > +             }
> > +     } else {
> >               gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> > +     }
> >
> >       /* Initialize GTT memory pool */
> >       r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
>
>

--00000000000022fdd705df6dea7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ignore the silly tests. We only need to make sure games w=
ork. The current minimum requirement for running modern games is 8GB of GPU=
 memory. Soon it will be 12GB. APUs will need to support that.<div dir=3D"a=
uto"><br></div><div dir=3D"auto">Marek</div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri., May 20, 2022, 03:52 Ch=
ristian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com"=
>ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Am 19.05.22 um 16:34 schrieb Alex Deucher:<br>
&gt; The current somewhat strange logic is in place because certain<br>
&gt; GL unit tests for large textures can cause problems with the<br>
&gt; OOM killer since there is no way to link this memory to a<br>
&gt; process.=C2=A0 The problem is this limit is often too low for many<br>
&gt; modern games on systems with more memory so limit the logic to<br>
&gt; systems with less than 8GB of main memory.=C2=A0 For systems with 8<br=
>
&gt; or more GB of system memory, set the GTT size to 3/4 of system<br>
&gt; memory.<br>
<br>
It&#39;s unfortunately not only the unit tests, but some games as well.<br>
<br>
3/4 of total system memory sounds reasonable to be, but I&#39;m 100% sure <=
br>
that this will break some tests.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com" target=3D"_blank" rel=3D"noreferrer">alexander.deucher@amd.com</a>&g=
t;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 +++++++++++++=
+++++++-----<br>
&gt;=C2=A0 =C2=A01 file changed, 20 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 4b9ee6e27f74..daa0babcf869 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Compute GTT size, either bsaed on 3/4th t=
he size of RAM size<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * or whatever the user passed on module ini=
t */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_gtt_size =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const u64 eight_GB =
=3D 8192ULL * 1024 * 1024;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sysinfo s=
i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 total_memory, def=
ault_gtt_size;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si_meminfo(&amp;=
si);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtt_size =3D min(max(=
(AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gmc.mc_vram_size),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint64_t)si.totalram * si.mem_unit * 3/4));<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_memory =3D (u64=
)si.totalram * si.mem_unit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default_gtt_size =3D =
total_memory * 3 / 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This somewhat stra=
nge logic is in place because certain GL unit<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * tests for large te=
xtures can cause problems with the OOM killer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * since there is no =
way to link this memory to a process.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The problem is thi=
s limit is often too low for many modern games<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * on systems with mo=
re memory so limit the logic to systems with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * less than 8GB of m=
ain memory.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total_memory &lt;=
 eight_GB) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev=
-&gt;gmc.mc_vram_size),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_gtt_size);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gtt_size =3D default_gtt_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtt_size =3D (ui=
nt64_t)amdgpu_gtt_size &lt;&lt; 20;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initialize GTT memory pool */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_gtt_mgr_init(adev, gtt_size);<b=
r>
<br>
</blockquote></div>

--00000000000022fdd705df6dea7f--

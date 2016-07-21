From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH]_drm/amdgpu:_adjust_gtt_me?=
 =?UTF-8?Q?mory_size?=
Date: Thu, 21 Jul 2016 11:48:41 +0200
Message-ID: <cb3c1f87-f14f-dd6b-df69-26c12672c51f@vodafone.de>
References: <1469087199-20802-1-git-send-email-Qingqing.Wang@amd.com>
 <fe341676-48d3-a847-89b4-224f2ba4620e@vodafone.de>
 <SN1PR12MB0511612A271156A2EFC7B449EC090@SN1PR12MB0511.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1389475961=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN1PR12MB0511612A271156A2EFC7B449EC090-z7L1TMIYDg7GFhS5Ttmc/AdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Wang, Qingqing" <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1389475961==
Content-Type: multipart/alternative;
 boundary="------------4AB93E7BA915D248653B1B68"

This is a multi-part message in MIME format.
--------------4AB93E7BA915D248653B1B68
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 21.07.2016 um 11:16 schrieb Wang, Qingqing:
>
> This doesn't work on 32bit systems since totalram is a long (IIRC) and
> so this will certainly overflow.
>
> -- can you be more specific, how could the overflow happen?
>

Both values are 32bit on a 32bit system, so as soon as you have more=20
than 4GB installed this will overflow.

You need to cast the long to a 64bit value to avoid that.

>
> Additional if I remember correctly we didn't ended the discussion on
> what to do here with a conclusion.
>
> -- ok, since it happens in anther mail list, we should stop talking=20
> about it here, you can send out your ideas there.
>

Actually that discussion was held long ago internally but we never got a=20
conclusion on this IIRC. So we should probably continue the discussion=20
on this thread now.

Regards,
Christian.

> -----------------------------------------------------------------------=
-
> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* amd-gfx <amd-gfx-bounces-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org> =E4=BB=A3=E8=A1=A8 Christian=20
> K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8821=E6=97=
=A5 16:53:05
> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Wang, Qingqing; amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org
> *=E4=B8=BB=E9=A2=98:* Re: [PATCH] drm/amdgpu: adjust gtt memory size
> Am 21.07.2016 um 09:46 schrieb Ken Wang:
> > Change-Id: If00d5b97ba9e30f9b7f68fdfc134a0f8b3ad2add
> > Signed-off-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 7 ++++++-
> >   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 7 ++++++-
> >   2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c=20
> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > index a3b6048..0b095d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > @@ -336,6 +336,11 @@ static int gmc_v7_0_mc_init(struct=20
> amdgpu_device *adev)
> >   {
> >        u32 tmp;
> >        int chansize, numchan;
> > +     u64 sysmem_size;
> > +     struct sysinfo si;
> > +
> > +     si_meminfo(&si);
> > +     sysmem_size =3D si.totalram * si.mem_unit;
>
> This doesn't work on 32bit systems since totalram is a long (IIRC) and
> so this will certainly overflow.
>
> Additional if I remember correctly we didn't ended the discussion on
> what to do here with a conclusion.
>
> Regards,
> Christian.
>
> >
> >        /* Get VRAM informations */
> >        tmp =3D RREG32(mmMC_ARB_RAMCFG);
> > @@ -392,7 +397,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device=20
> *adev)
> >         * size equal to the 1024 or vram, whichever is larger.
> >         */
> >        if (amdgpu_gart_size =3D=3D -1)
> > -             adev->mc.gtt_size =3D max((1024ULL << 20),=20
> adev->mc.mc_vram_size);
> > +             adev->mc.gtt_size =3D max((1024ULL << 20),=20
> min(adev->mc.mc_vram_size, sysmem_size/2));
> >        else
> >                adev->mc.gtt_size =3D (uint64_t)amdgpu_gart_size << 20=
;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c=20
> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > index 02b6872..790bf7a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > @@ -413,6 +413,11 @@ static int gmc_v8_0_mc_init(struct=20
> amdgpu_device *adev)
> >   {
> >        u32 tmp;
> >        int chansize, numchan;
> > +     u64 sysmem_size;
> > +     struct sysinfo si;
> > +
> > +     si_meminfo(&si);
> > +     sysmem_size =3D si.totalram * si.mem_unit;
> >
> >        /* Get VRAM informations */
> >        tmp =3D RREG32(mmMC_ARB_RAMCFG);
> > @@ -469,7 +474,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device=20
> *adev)
> >         * size equal to the 1024 or vram, whichever is larger.
> >         */
> >        if (amdgpu_gart_size =3D=3D -1)
> > -             adev->mc.gtt_size =3D max((1024ULL << 20),=20
> adev->mc.mc_vram_size);
> > +             adev->mc.gtt_size =3D max((1024ULL << 20),=20
> min(adev->mc.mc_vram_size, sysmem_size/2));
> >        else
> >                adev->mc.gtt_size =3D (uint64_t)amdgpu_gart_size << 20=
;
> >
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------4AB93E7BA915D248653B1B68
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Am 21.07.2016 um 11:16 schrieb Wang,
      Qingqing:<br>
    </div>
    <blockquote
cite=3D"mid:SN1PR12MB0511612A271156A2EFC7B449EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Du=
tf-8">
      <meta name=3D"Generator" content=3D"Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; bord=
er-left: #800000 2px solid; } --></style>
      <meta content=3D"text/html; charset=3DUTF-8">
      <style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir=3D"ltr">
        <div id=3D"x_divtagdefaultwrapper" style=3D"font-size:12pt;
          color:#000000; background-color:#FFFFFF;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p><font size=3D"2"><span style=3D"font-size:10pt">This doesn't
                work on 32bit systems since totalram is a long (IIRC)
                and
                <br>
                so this will certainly overflow.</span></font></p>
          <p>-- can you be more specific, how could the overflow happen?<=
/p>
        </div>
      </div>
    </blockquote>
    <br>
    Both values are 32bit on a 32bit system, so as soon as you have more
    than 4GB installed this will overflow.<br>
    <br>
    You need to cast the long to a 64bit value to avoid that.<br>
    <br>
    <blockquote
cite=3D"mid:SN1PR12MB0511612A271156A2EFC7B449EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div id=3D"x_divtagdefaultwrapper" style=3D"font-size:12pt;
          color:#000000; background-color:#FFFFFF;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p><br>
          </p>
          <p><font size=3D"2"><span style=3D"font-size:10pt">Additional i=
f I
                remember correctly we didn't ended the discussion on
                <br>
                what to do here with a conclusion.</span></font></p>
          <p>-- ok, since it happens in anther mail list, we should stop
            talking about it here, you can send out your ideas there.<br>
          </p>
        </div>
      </div>
    </blockquote>
    <br>
    Actually that discussion was held long ago internally but we never
    got a conclusion on this IIRC. So we should probably continue the
    discussion on this thread now.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote
cite=3D"mid:SN1PR12MB0511612A271156A2EFC7B449EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div id=3D"x_divtagdefaultwrapper" style=3D"font-size:12pt;
          color:#000000; background-color:#FFFFFF;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p>
          </p>
        </div>
        <hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
        <div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:=
11pt"
            color=3D"#000000" face=3D"Calibri, sans-serif"><b>=E5=8F=91=E4=
=BB=B6=E4=BA=BA:</b>
            amd-gfx <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd=
-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org&gt;</a> =E4=BB=A3=E8=A1=A8
            Christian K=C3=B6nig <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2016=E5=B9=B47=E6=
=9C=8821=E6=97=A5 16:53:05<br>
            <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> Wang, Qingqing; <a class=3D=
"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>=E4=B8=BB=E9=A2=98:</b> Re: [PATCH] drm/amdgpu: adjust gtt=
 memory size</font>
          <div>=C2=A0</div>
        </div>
      </div>
      <font size=3D"2"><span style=3D"font-size:10pt;">
          <div class=3D"PlainText">Am 21.07.2016 um 09:46 schrieb Ken
            Wang:<br>
            &gt; Change-Id: If00d5b97ba9e30f9b7f68fdfc134a0f8b3ad2add<br>
            &gt; Signed-off-by: Ken Wang <a class=3D"moz-txt-link-rfc2396=
E" href=3D"mailto:Qingqing.Wang-5C7GfCeVMHo@public.gmane.org">&lt;Qingqing.Wang-5C7GfCeVMHo@public.gmane.org&gt;</a=
><br>
            &gt; ---<br>
            &gt;=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 7 ++=
++++-<br>
            &gt;=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 7 ++=
++++-<br>
            &gt;=C2=A0=C2=A0 2 files changed, 12 insertions(+), 2 deletio=
ns(-)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
            b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
            &gt; index a3b6048..0b095d5 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
            &gt; @@ -336,6 +336,11 @@ static int gmc_v7_0_mc_init(struct
            amdgpu_device *adev)<br>
            &gt;=C2=A0=C2=A0 {<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 tmp;<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int chansize, =
numchan;<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 u64 sysmem_size;<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 struct sysinfo si;<br>
            &gt; +<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 si_meminfo(&amp;si);<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 sysmem_size =3D si.totalram * =
si.mem_unit;<br>
            <br>
            This doesn't work on 32bit systems since totalram is a long
            (IIRC) and <br>
            so this will certainly overflow.<br>
            <br>
            Additional if I remember correctly we didn't ended the
            discussion on <br>
            what to do here with a conclusion.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt;=C2=A0=C2=A0 <br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Get VRAM in=
formations */<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32=
(mmMC_ARB_RAMCFG);<br>
            &gt; @@ -392,7 +397,7 @@ static int gmc_v7_0_mc_init(struct
            amdgpu_device *adev)<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size e=
qual to the 1024 or vram, whichever is
            larger.<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_gar=
t_size =3D=3D -1)<br>
            &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D max((1024ULL
            &lt;&lt; 20), adev-&gt;mc.mc_vram_size);<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D max((1024ULL
            &lt;&lt; 20), min(adev-&gt;mc.mc_vram_size, sysmem_size/2));<=
br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
            (uint64_t)amdgpu_gart_size &lt;&lt; 20;<br>
            &gt;=C2=A0=C2=A0 <br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
            b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
            &gt; index 02b6872..790bf7a 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
            &gt; @@ -413,6 +413,11 @@ static int gmc_v8_0_mc_init(struct
            amdgpu_device *adev)<br>
            &gt;=C2=A0=C2=A0 {<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 tmp;<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int chansize, =
numchan;<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 u64 sysmem_size;<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 struct sysinfo si;<br>
            &gt; +<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 si_meminfo(&amp;si);<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 sysmem_size =3D si.totalram * =
si.mem_unit;<br>
            &gt;=C2=A0=C2=A0 <br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Get VRAM in=
formations */<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32=
(mmMC_ARB_RAMCFG);<br>
            &gt; @@ -469,7 +474,7 @@ static int gmc_v8_0_mc_init(struct
            amdgpu_device *adev)<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size e=
qual to the 1024 or vram, whichever is
            larger.<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_gar=
t_size =3D=3D -1)<br>
            &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D max((1024ULL
            &lt;&lt; 20), adev-&gt;mc.mc_vram_size);<br>
            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D max((1024ULL
            &lt;&lt; 20), min(adev-&gt;mc.mc_vram_size, sysmem_size/2));<=
br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else<br>
            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
            (uint64_t)amdgpu_gart_size &lt;&lt; 20;<br>
            &gt;=C2=A0=C2=A0 <br>
            <br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@=
lists.freedesktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a moz-do-not-send=3D"true"
              href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------4AB93E7BA915D248653B1B68--

--===============1389475961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1389475961==--

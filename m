From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH drm/amdgpu] Fix indentation in
 dce_v8_0_audio_write_sad_regs()
Date: Mon, 22 Aug 2016 15:01:27 +0000
Message-ID: <CAPEhTTG_9SaV1bXnaqE=O6K-Y+WvQQbYF+Tcs=4aMJ4zwQqpyQ@mail.gmail.com>
References: <20160822003826.16418-1-alexandre.f.demers@gmail.com>
 <MWHPR12MB169478C874EB12F1821F3BD0F7E80@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1151005679=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB169478C874EB12F1821F3BD0F7E80-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1151005679==
Content-Type: multipart/alternative; boundary=94eb2c07ec3c3092db053aaa53e3

--94eb2c07ec3c3092db053aaa53e3
Content-Type: text/plain; charset=UTF-8

Will do, thanks!

I'll make the change for the others already baking for DCE6. I still have a
thing or two to clean up, but  it's almost there.

On Mon, 22 Aug 2016 at 09:19 Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
wrote:

> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of Alexandre Demers
> > Sent: Sunday, August 21, 2016 8:38 PM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Subject: [PATCH drm/amdgpu] Fix indentation in
> > dce_v8_0_audio_write_sad_regs()
>
> For these and future patches, please include drm/amdgpu: in the patch
> title.
>
> Alex
>
> >
> > Fixed indentation for readability.
> >
> > Signed-off-by: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > index 3ff1258..c7e5d5f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > @@ -1501,13 +1501,13 @@ static void
> > dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
> >
> >                       if (sad->format == eld_reg_to_type[i][1]) {
> >                               if (sad->channels > max_channels) {
> > -                             value = (sad->channels <<
> > -
> > AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNEL
> > S__SHIFT) |
> > -                             (sad->byte2 <<
> > -
> > AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BY
> > TE_2__SHIFT) |
> > -                             (sad->freq <<
> > -
> > AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FR
> > EQUENCIES__SHIFT);
> > -                             max_channels = sad->channels;
> > +                                     value = (sad->channels <<
> > +
> > AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNEL
> > S__SHIFT) |
> > +                                             (sad->byte2 <<
> > +
> > AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BY
> > TE_2__SHIFT) |
> > +                                             (sad->freq <<
> > +
> > AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FR
> > EQUENCIES__SHIFT);
> > +                                     max_channels = sad->channels;
> >                               }
> >
> >                               if (sad->format ==
> > HDMI_AUDIO_CODING_TYPE_PCM)
> > --
> > 2.9.3
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--94eb2c07ec3c3092db053aaa53e3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Will do, thanks!<div><br></div><div>I&#39;ll make the chan=
ge for the others already baking for DCE6. I still have a thing or two to c=
lean up, but =C2=A0it&#39;s almost there.</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr">On Mon, 22 Aug 2016 at 09:19 Deucher, Alexander &=
lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; -----Original Me=
ssage-----<br>
&gt; From: amd-gfx [mailto:<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Be=
half<br>
&gt; Of Alexandre Demers<br>
&gt; Sent: Sunday, August 21, 2016 8:38 PM<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank"=
>amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; Subject: [PATCH drm/amdgpu] Fix indentation in<br>
&gt; dce_v8_0_audio_write_sad_regs()<br>
<br>
For these and future patches, please include drm/amdgpu: in the patch title=
.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Fixed indentation for readability.<br>
&gt;<br>
&gt; Signed-off-by: Alexandre Demers &lt;<a href=3D"mailto:alexandre.f.deme=
rs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++++++-------<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; index 3ff1258..c7e5d5f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; @@ -1501,13 +1501,13 @@ static void<br>
&gt; dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (sad-&gt;format =3D=3D eld_reg_to_type[i][1]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sad-&gt;channels &gt; max_chan=
nels) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D (sad-&gt;channels &lt;&lt;<br>
&gt; -<br>
&gt; AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNEL<br>
&gt; S__SHIFT) |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sad-&gt;byte2 &lt;&lt;<br>
&gt; -<br>
&gt; AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BY<br>
&gt; TE_2__SHIFT) |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sad-&gt;freq &lt;&lt;<br>
&gt; -<br>
&gt; AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FR<br>
&gt; EQUENCIES__SHIFT);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_channels =3D sad-&gt;channels;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D (s=
ad-&gt;channels &lt;&lt;<br>
&gt; +<br>
&gt; AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNEL<br>
&gt; S__SHIFT) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(sad-&gt;byte2 &lt;&lt;<br>
&gt; +<br>
&gt; AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BY<br>
&gt; TE_2__SHIFT) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(sad-&gt;freq &lt;&lt;<br>
&gt; +<br>
&gt; AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FR<br>
&gt; EQUENCIES__SHIFT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_channels=
 =3D sad-&gt;channels;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sad-&gt;format =3D=3D<br>
&gt; HDMI_AUDIO_CODING_TYPE_PCM)<br>
&gt; --<br>
&gt; 2.9.3<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--94eb2c07ec3c3092db053aaa53e3--

--===============1151005679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1151005679==--

From: Harinath Reddy <harinath428-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: will xf86-video-amdgpu is capable to drive AMD readeon Pro wx2100
Date: Tue, 12 Mar 2019 19:49:44 +0530
Message-ID: <CAPLU1JiWQAV-pY8-Vw4j4Zw_FAyL3PKC8ii3QrGfO0xDZKLKXw@mail.gmail.com>
References: <CAPLU1JgPzbw4rf5gACmB1muk=aPdP7Dft1C3zvf3oCdk4uVimQ@mail.gmail.com>
 <f4a8e262-ce12-9e73-50c4-4099cd5eeee7@daenzer.net>
 <c19688e9-6da9-cf1b-2a3e-e1b804457b93@gmail.com>
 <CAPLU1JiSujTrdXsRGzZd0c2=icVckZO4Ejg6uMXXaM3LRKp_4Q@mail.gmail.com>
 <CADnq5_OaOcv3Pba0qFsjHE82Ee5Yh97dzgHneOWe4BbRPrLpdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1002311479=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OaOcv3Pba0qFsjHE82Ee5Yh97dzgHneOWe4BbRPrLpdg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1002311479==
Content-Type: multipart/alternative; boundary="0000000000002c78e70583e66209"

--0000000000002c78e70583e66209
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If I am not confused/wrong with your information,    if I want get use of
the  xf86-video-amdgpu (UMD )   which is capable of driving GCN core cards
in hp-ux, I should
write hp-ux compatible  drm based kenel module.


Thanks,
Harinath



On Tue, Mar 12, 2019 at 7:37 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> All drivers for recent hardware require a proper kernel driver.  There
> have not been user mode X drivers for new AMD hardware released in the
> last 7-8 years.
>
> Alex
>
> On Tue, Mar 12, 2019 at 10:02 AM Harinath Reddy <harinath428-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >
> > Hope it is different from xorg-video-radeon/hd  driver which is not
> require any kernel component to drive the FireMV2250 card, except card
> initialization( ATOMBIOS run from the HP-UX kernel on behalf of the xf86
> request ).
> >
> > If it is tightly coupled with amdgpu  kernel module, and it is again
> depend on the linux kernel drm module. HP-UX is not using the drm
> facilities as i am aware , so is that possible to port to hp-ux.
> >
> >
> > Thanks and Regards,
> > Harinath
> >
> > On Tue, Mar 12, 2019 at 2:37 PM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>
> >> Am 12.03.19 um 09:35 schrieb Michel D=C3=A4nzer:
> >> > On 2019-03-12 4:14 a.m., Harinath Reddy wrote:
> >> >> Hi,
> >> >>
> >> >> Present we are using the radeon HD driver from xorg to driver
> AMDFirMV2250
> >> >> card. We would like to replace AMD FireMV2250 with AMD Radeon Pro
> Wx2100
> >> >> card.
> >> >>
> >> >> I saw xf86-video-amdgpu xorg driver is available, but we are not su=
re
> >> >> whether that would be sufficient or not, if not what else require
> to  use
> >> >> that card.  If you can help that  would be great
> >> >> I am naive to the graphics world .
> >> >>
> >> >>
> >> >> We are using HP_UX operating system, Xserver (Xfree86) is  as a
> graphics
> >> >> server.
> >> > xf86-video-amdgpu requires the amdgpu kernel driver. Assuming the
> latter
> >> > is working with your card, the former will work (as well as the
> generic
> >> > modesetting Xorg driver).
> >>
> >> To answer the original question a bit more direct: The amdgpu kernel
> >> driver is NOT available for HP_UX.
> >>
> >> Regards,
> >> Christian.
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000002c78e70583e66209
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If I am not confused/wrong with your information,=C2=A0 =
=C2=A0 if I want get use of the=C2=A0

xf86-video-amdgpu (UMD )=C2=A0 =C2=A0which is capable of driving GCN core c=
ards in hp-ux, I should=C2=A0=C2=A0<div>write hp-ux compatible=C2=A0 drm ba=
sed kenel module.</div><div><br></div><div><br></div><div>Thanks,</div><div=
>Harinath</div><div><br><div><br></div></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 12, 2019 at 7:37 P=
M Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">All drivers for recent hardware require a proper kernel driver.=C2=A0=
 There<br>
have not been user mode X drivers for new AMD hardware released in the<br>
last 7-8 years.<br>
<br>
Alex<br>
<br>
On Tue, Mar 12, 2019 at 10:02 AM Harinath Reddy &lt;<a href=3D"mailto:harin=
ath428-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">harinath428-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br=
>
&gt;<br>
&gt; Hope it is different from xorg-video-radeon/hd=C2=A0 driver which is n=
ot require any kernel component to drive the FireMV2250 card, except card i=
nitialization( ATOMBIOS run from the HP-UX kernel on behalf of the xf86 req=
uest ).<br>
&gt;<br>
&gt; If it is tightly coupled with amdgpu=C2=A0 kernel module, and it is ag=
ain depend on the linux kernel drm module. HP-UX is not using the drm facil=
ities as i am aware , so is that possible to port to hp-ux.<br>
&gt;<br>
&gt;<br>
&gt; Thanks and Regards,<br>
&gt; Harinath<br>
&gt;<br>
&gt; On Tue, Mar 12, 2019 at 2:37 PM Christian K=C3=B6nig &lt;<a href=3D"ma=
ilto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzume=
rken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Am 12.03.19 um 09:35 schrieb Michel D=C3=A4nzer:<br>
&gt;&gt; &gt; On 2019-03-12 4:14 a.m., Harinath Reddy wrote:<br>
&gt;&gt; &gt;&gt; Hi,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Present we are using the radeon HD driver from xorg to dr=
iver AMDFirMV2250<br>
&gt;&gt; &gt;&gt; card. We would like to replace AMD FireMV2250 with AMD Ra=
deon Pro Wx2100<br>
&gt;&gt; &gt;&gt; card.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I saw xf86-video-amdgpu xorg driver is available, but we =
are not sure<br>
&gt;&gt; &gt;&gt; whether that would be sufficient or not, if not what else=
 require to=C2=A0 use<br>
&gt;&gt; &gt;&gt; that card.=C2=A0 If you can help that=C2=A0 would be grea=
t<br>
&gt;&gt; &gt;&gt; I am naive to the graphics world .<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; We are using HP_UX operating system, Xserver (Xfree86) is=
=C2=A0 as a=C2=A0 graphics<br>
&gt;&gt; &gt;&gt; server.<br>
&gt;&gt; &gt; xf86-video-amdgpu requires the amdgpu kernel driver. Assuming=
 the latter<br>
&gt;&gt; &gt; is working with your card, the former will work (as well as t=
he generic<br>
&gt;&gt; &gt; modesetting Xorg driver).<br>
&gt;&gt;<br>
&gt;&gt; To answer the original question a bit more direct: The amdgpu kern=
el<br>
&gt;&gt; driver is NOT available for HP_UX.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--0000000000002c78e70583e66209--

--===============1002311479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1002311479==--

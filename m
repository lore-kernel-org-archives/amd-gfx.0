From: Harinath Reddy <harinath428-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: will xf86-video-amdgpu is capable to drive AMD readeon Pro wx2100
Date: Tue, 12 Mar 2019 19:32:33 +0530
Message-ID: <CAPLU1JiSujTrdXsRGzZd0c2=icVckZO4Ejg6uMXXaM3LRKp_4Q@mail.gmail.com>
References: <CAPLU1JgPzbw4rf5gACmB1muk=aPdP7Dft1C3zvf3oCdk4uVimQ@mail.gmail.com>
 <f4a8e262-ce12-9e73-50c4-4099cd5eeee7@daenzer.net>
 <c19688e9-6da9-cf1b-2a3e-e1b804457b93@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0963466381=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c19688e9-6da9-cf1b-2a3e-e1b804457b93-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0963466381==
Content-Type: multipart/alternative; boundary="000000000000c24c1c0583e6240f"

--000000000000c24c1c0583e6240f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hope it is different from xorg-video-radeon/hd  driver which is not require
any kernel component to drive the FireMV2250 card, except card
initialization( ATOMBIOS run from the HP-UX kernel on behalf of the xf86
request ).

If it is tightly coupled with amdgpu  kernel module, and it is again depend
on the linux kernel drm module. HP-UX is not using the drm facilities as i
am aware , so is that possible to port to hp-ux.


Thanks and Regards,
Harinath

On Tue, Mar 12, 2019 at 2:37 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 12.03.19 um 09:35 schrieb Michel D=C3=A4nzer:
> > On 2019-03-12 4:14 a.m., Harinath Reddy wrote:
> >> Hi,
> >>
> >> Present we are using the radeon HD driver from xorg to driver
> AMDFirMV2250
> >> card. We would like to replace AMD FireMV2250 with AMD Radeon Pro Wx21=
00
> >> card.
> >>
> >> I saw xf86-video-amdgpu xorg driver is available, but we are not sure
> >> whether that would be sufficient or not, if not what else require to
> use
> >> that card.  If you can help that  would be great
> >> I am naive to the graphics world .
> >>
> >>
> >> We are using HP_UX operating system, Xserver (Xfree86) is  as a
> graphics
> >> server.
> > xf86-video-amdgpu requires the amdgpu kernel driver. Assuming the latte=
r
> > is working with your card, the former will work (as well as the generic
> > modesetting Xorg driver).
>
> To answer the original question a bit more direct: The amdgpu kernel
> driver is NOT available for HP_UX.
>
> Regards,
> Christian.
>

--000000000000c24c1c0583e6240f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hope it is different from xorg-video-radeon/hd=C2=A0 drive=
r which is not require any kernel component to drive the FireMV2250 card, e=
xcept card initialization( ATOMBIOS run from the HP-UX kernel on behalf of =
the xf86 request ).=C2=A0<div><br></div><div>If it is tightly coupled with =
amdgpu=C2=A0 kernel module, and it is again depend on the linux kernel drm =
module. HP-UX is not using the drm facilities as i am aware , so is that po=
ssible to port to hp-ux.</div><div><br></div><div><br></div><div>Thanks and=
 Regards,</div><div>Harinath</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 12, 2019 at 2:37 PM Christian=
 K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Am 12.03.19 um 09:35 schrieb Michel D=C3=A4nzer:<b=
r>
&gt; On 2019-03-12 4:14 a.m., Harinath Reddy wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; Present we are using the radeon HD driver from xorg to driver AMDF=
irMV2250<br>
&gt;&gt; card. We would like to replace AMD FireMV2250 with AMD Radeon Pro =
Wx2100<br>
&gt;&gt; card.<br>
&gt;&gt;<br>
&gt;&gt; I saw xf86-video-amdgpu xorg driver is available, but we are not s=
ure<br>
&gt;&gt; whether that would be sufficient or not, if not what else require =
to=C2=A0 use<br>
&gt;&gt; that card.=C2=A0 If you can help that=C2=A0 would be great<br>
&gt;&gt; I am naive to the graphics world .<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; We are using HP_UX operating system, Xserver (Xfree86) is=C2=A0 as=
 a=C2=A0 graphics<br>
&gt;&gt; server.<br>
&gt; xf86-video-amdgpu requires the amdgpu kernel driver. Assuming the latt=
er<br>
&gt; is working with your card, the former will work (as well as the generi=
c<br>
&gt; modesetting Xorg driver).<br>
<br>
To answer the original question a bit more direct: The amdgpu kernel <br>
driver is NOT available for HP_UX.<br>
<br>
Regards,<br>
Christian.<br>
</blockquote></div>

--000000000000c24c1c0583e6240f--

--===============0963466381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0963466381==--

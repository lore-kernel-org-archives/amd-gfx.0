From: Mathieu Malaterre <malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: change function signature to pass full range
Date: Mon, 17 Sep 2018 12:19:18 +0200
Message-ID: <CA+7wUswLVHMeCMz-9-Xtxigu8CjNDS8745G8S7J8F_7U8YXteQ@mail.gmail.com>
References: <20180412193333.4951-1-malat@debian.org>
 <20180413080437.GB10330@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2074823701=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180413080437.GB10330@hr-amur2>
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
To: ray.huang-5C7GfCeVMHo@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============2074823701==
Content-Type: multipart/alternative; boundary="000000000000535acc05760e82fe"

--000000000000535acc05760e82fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 9:59 AM Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org> wrote:

> On Thu, Apr 12, 2018 at 09:33:33PM +0200, Mathieu Malaterre wrote:
> > In function =E2=80=98radeon_process_i2c_ch=E2=80=99 a comparison of a u=
8 value against
> > 255 is done. Since it is always false, change the signature of this
> > function to use an `int` instead, which match the type used in caller:
> > `radeon_atom_hw_i2c_xfer`.
> >
> > Fix the following warning triggered with W=3D1:
> >
> >   CC [M]  drivers/gpu/drm/radeon/atombios_i2c.o
> >   drivers/gpu/drm/radeon/atombios_i2c.c: In function
> =E2=80=98radeon_process_i2c_ch=E2=80=99:
> >   drivers/gpu/drm/radeon/atombios_i2c.c:71:11: warning: comparison is
> always false due to limited range of data type [-Wtype-limits]
> >    if (num > ATOM_MAX_HW_I2C_READ) {
> >            ^
> >
> > Signed-off-by: Mathieu Malaterre <malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
>
> Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
>
>
Any chance to be included in the next pull request ? thanks


> > ---
> >  drivers/gpu/drm/radeon/atombios_i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c
> b/drivers/gpu/drm/radeon/atombios_i2c.c
> > index 4157780585a0..9022e9af11a0 100644
> > --- a/drivers/gpu/drm/radeon/atombios_i2c.c
> > +++ b/drivers/gpu/drm/radeon/atombios_i2c.c
> > @@ -35,7 +35,7 @@
> >
> >  static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
> >                                u8 slave_addr, u8 flags,
> > -                              u8 *buf, u8 num)
> > +                              u8 *buf, int num)
> >  {
> >       struct drm_device *dev =3D chan->dev;
> >       struct radeon_device *rdev =3D dev->dev_private;
> > --
> > 2.11.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000535acc05760e82fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri=
, Apr 13, 2018 at 9:59 AM Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org=
">ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Thu, Apr 12, 2018 at 09:33:33PM +0200, Mathieu Malaterre wrote:<br>
&gt; In function =E2=80=98radeon_process_i2c_ch=E2=80=99 a comparison of a =
u8 value against<br>
&gt; 255 is done. Since it is always false, change the signature of this<br=
>
&gt; function to use an `int` instead, which match the type used in caller:=
<br>
&gt; `radeon_atom_hw_i2c_xfer`.<br>
&gt; <br>
&gt; Fix the following warning triggered with W=3D1:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0CC [M]=C2=A0 drivers/gpu/drm/radeon/atombios_i2c.o<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/radeon/atombios_i2c.c: In function =E2=80=
=98radeon_process_i2c_ch=E2=80=99:<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/radeon/atombios_i2c.c:71:11: warning: comp=
arison is always false due to limited range of data type [-Wtype-limits]<br=
>
&gt;=C2=A0 =C2=A0 if (num &gt; ATOM_MAX_HW_I2C_READ) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
&gt; <br>
&gt; Signed-off-by: Mathieu Malaterre &lt;<a href=3D"mailto:malat-8fiUuRrzOP1QFI55V6+gNQ@public.gmane.org=
g" target=3D"_blank">malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org</a>&gt;<br>
<br>
Reviewed-by: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org" target=3D"_=
blank">ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br></blockquote><div><br></div><div>Any chance to be included in the next =
pull request ? thanks</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/radeon/atombios_i2c.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/r=
adeon/atombios_i2c.c<br>
&gt; index 4157780585a0..9022e9af11a0 100644<br>
&gt; --- a/drivers/gpu/drm/radeon/atombios_i2c.c<br>
&gt; +++ b/drivers/gpu/drm/radeon/atombios_i2c.c<br>
&gt; @@ -35,7 +35,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 slave_addr, u8 flags,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 *buf, u8 num)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 *buf, int num)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_device *dev =3D chan-&gt;dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D dev-&gt;dev_p=
rivate;<br>
&gt; -- <br>
&gt; 2.11.0<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--000000000000535acc05760e82fe--

--===============2074823701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2074823701==--

From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment read
Date: Mon, 10 Oct 2016 13:38:53 +0000
Message-ID: <CAAzXoRJKusZrvv7obpZ-0tR39pVmdc-7Y8prKCsRC6bchmsOcA@mail.gmail.com>
References: <20161010125128.18303-1-tom.stdenis@amd.com>
 <91da2060-e6d4-70c9-2ceb-69218e1058ba@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1014514003=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <91da2060-e6d4-70c9-2ceb-69218e1058ba-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--===============1014514003==
Content-Type: multipart/alternative; boundary=94eb2c000bec1dcefc053e82e28b

--94eb2c000bec1dcefc053e82e28b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

that's kind of the point.  Its for debugging only.  Also reads can already
lock

On Mon, Oct 10, 2016, 09:25 Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> =
wrote:

> Mhm, that userspace controls if the lock is taken or not is a bit
> problematic, on the other hand only root could access that.
>
> Christian.
>
> Am 10.10.2016 um 14:51 schrieb Tom St Denis:
> > Add PG lock support as well as bank selection to
> > the MMIO write function.
> >
> > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43
> ++++++++++++++++++++++++++++++
> >   1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 04c4aee70452..a9d83c1d7a43 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2637,10 +2637,45 @@ static ssize_t amdgpu_debugfs_regs_write(struct
> file *f, const char __user *buf,
> >       struct amdgpu_device *adev =3D f->f_inode->i_private;
> >       ssize_t result =3D 0;
> >       int r;
> > +     bool pm_pg_lock, use_bank;
> > +     unsigned instance_bank, sh_bank, se_bank;
> >
> >       if (size & 0x3 || *pos & 0x3)
> >               return -EINVAL;
> >
> > +     /* are we reading registers for which a PG lock is necessary? */
> > +     pm_pg_lock =3D (*pos >> 23) & 1;
> > +
> > +     if (*pos & (1ULL << 62)) {
> > +             se_bank =3D (*pos >> 24) & 0x3FF;
> > +             sh_bank =3D (*pos >> 34) & 0x3FF;
> > +             instance_bank =3D (*pos >> 44) & 0x3FF;
> > +
> > +             if (se_bank =3D=3D 0x3FF)
> > +                     se_bank =3D 0xFFFFFFFF;
> > +             if (sh_bank =3D=3D 0x3FF)
> > +                     sh_bank =3D 0xFFFFFFFF;
> > +             if (instance_bank =3D=3D 0x3FF)
> > +                     instance_bank =3D 0xFFFFFFFF;
> > +             use_bank =3D 1;
> > +     } else {
> > +             use_bank =3D 0;
> > +     }
> > +
> > +     *pos &=3D 0x3FFFF;
> > +
> > +     if (use_bank) {
> > +             if ((sh_bank !=3D 0xFFFFFFFF && sh_bank >=3D
> adev->gfx.config.max_sh_per_se) ||
> > +                 (se_bank !=3D 0xFFFFFFFF && se_bank >=3D
> adev->gfx.config.max_shader_engines))
> > +                     return -EINVAL;
> > +             mutex_lock(&adev->grbm_idx_mutex);
> > +             amdgpu_gfx_select_se_sh(adev, se_bank,
> > +                                     sh_bank, instance_bank);
> > +     }
> > +
> > +     if (pm_pg_lock)
> > +             mutex_lock(&adev->pm.mutex);
> > +
> >       while (size) {
> >               uint32_t value;
> >
> > @@ -2659,6 +2694,14 @@ static ssize_t amdgpu_debugfs_regs_write(struct
> file *f, const char __user *buf,
> >               size -=3D 4;
> >       }
> >
> > +     if (use_bank) {
> > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,
> 0xffffffff);
> > +             mutex_unlock(&adev->grbm_idx_mutex);
> > +     }
> > +
> > +     if (pm_pg_lock)
> > +             mutex_unlock(&adev->pm.mutex);
> > +
> >       return result;
> >   }
> >
>
>
>

--94eb2c000bec1dcefc053e82e28b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">that&#39;s kind of the point.=C2=A0 Its for debugging only.=
=C2=A0 Also reads can already lock</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Oct 10, 2016, 09:25=
 Christian K=C3=B6nig &lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deaths=
imple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Mh=
m, that userspace controls if the lock is taken or not is a bit<br class=3D=
"gmail_msg">
problematic, on the other hand only root could access that.<br class=3D"gma=
il_msg">
<br class=3D"gmail_msg">
Christian.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Am 10.10.2016 um 14:51 schrieb Tom St Denis:<br class=3D"gmail_msg">
&gt; Add PG lock support as well as bank selection to<br class=3D"gmail_msg=
">
&gt; the MMIO write function.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
 class=3D"gmail_msg" target=3D"_blank">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=
=3D"gmail_msg">
&gt; ---<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43 ++++++++++=
++++++++++++++++++++<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A01 file changed, 43 insertions(+)<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg">
&gt; index 04c4aee70452..a9d83c1d7a43 100644<br class=3D"gmail_msg">
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg=
">
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg=
">
&gt; @@ -2637,10 +2637,45 @@ static ssize_t amdgpu_debugfs_regs_write(struc=
t file *f, const char __user *buf,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D f-&gt;f_inode=
-&gt;i_private;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t result =3D 0;<br class=3D"gmail_msg"=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0bool pm_pg_lock, use_bank;<br class=3D"gmail_msg"=
>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned instance_bank, sh_bank, se_bank;<br clas=
s=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &amp; 0x3 || *pos &amp; 0x3)<br cla=
ss=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0/* are we reading registers for which a PG lock i=
s necessary? */<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0pm_pg_lock =3D (*pos &gt;&gt; 23) &amp; 1;<br cla=
ss=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0if (*pos &amp; (1ULL &lt;&lt; 62)) {<br class=3D"=
gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0se_bank =3D (*pos &gt=
;&gt; 24) &amp; 0x3FF;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sh_bank =3D (*pos &gt=
;&gt; 34) &amp; 0x3FF;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0instance_bank =3D (*p=
os &gt;&gt; 44) &amp; 0x3FF;<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (se_bank =3D=3D 0x=
3FF)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0se_bank =3D 0xFFFFFFFF;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sh_bank =3D=3D 0x=
3FF)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sh_bank =3D 0xFFFFFFFF;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (instance_bank =3D=
=3D 0x3FF)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0instance_bank =3D 0xFFFFFFFF;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_bank =3D 1;<br cl=
ass=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_bank =3D 0;<br cl=
ass=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0*pos &amp;=3D 0x3FFFF;<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0if (use_bank) {<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((sh_bank !=3D 0xF=
FFFFFFF &amp;&amp; sh_bank &gt;=3D adev-&gt;gfx.config.max_sh_per_se) ||<br=
 class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(se_ban=
k !=3D 0xFFFFFFFF &amp;&amp; se_bank &gt;=3D adev-&gt;gfx.config.max_shader=
_engines))<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;adev-=
&gt;grbm_idx_mutex);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_select_se_=
sh(adev, se_bank,<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sh_bank, ins=
tance_bank);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0if (pm_pg_lock)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;adev-=
&gt;pm.mutex);<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0while (size) {<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t value;<=
br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; @@ -2659,6 +2694,14 @@ static ssize_t amdgpu_debugfs_regs_write(struct=
 file *f, const char __user *buf,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size -=3D 4;<br =
class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0if (use_bank) {<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_select_se_=
sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;ade=
v-&gt;grbm_idx_mutex);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0if (pm_pg_lock)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;ade=
v-&gt;pm.mutex);<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return result;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
</blockquote></div>

--94eb2c000bec1dcefc053e82e28b--

--===============1014514003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1014514003==--

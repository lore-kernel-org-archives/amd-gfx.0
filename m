From: Navid Emamdoost <navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix multiple memory leaks
Date: Wed, 18 Sep 2019 14:04:52 -0500
Message-ID: <CAEkB2ERC-mUq+SHkaZiiZnJTTcOvjUebRSnKACVUUckCC59a7Q@mail.gmail.com>
References: <20190918160943.14105-1-navid.emamdoost@gmail.com>
 <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1019409045=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, "kjlu-OJFnDUYgAso@public.gmane.org" <kjlu-OJFnDUYgAso@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "emamd001-OJFnDUYgAso@public.gmane.org" <emamd001-OJFnDUYgAso@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "smccaman-OJFnDUYgAso@public.gmane.org" <smccaman-OJFnDUYgAso@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1019409045==
Content-Type: multipart/alternative; boundary="000000000000b366e40592d8839f"

--000000000000b366e40592d8839f
Content-Type: text/plain; charset="UTF-8"

Thanks Christian for the feedback, I'll send a v2.



On Wed, Sep 18, 2019 at 12:31 PM Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
wrote:

> Am 18.09.19 um 18:09 schrieb Navid Emamdoost:
> > In acp_hw_init there are some allocations that needs to be released in
> > case of failure:
> >
> > 1- adev->acp.acp_genpd should be released if any allocation attemp for
> > adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
> > 2- all of those allocations should be released if pm_genpd_add_device
> > fails.
>
> Good catch, but please use goto error handling instead of adding more
> and more kfree calls.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > index eba42c752bca..dd3fa85b11c5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > @@ -231,17 +231,21 @@ static int acp_hw_init(void *handle)
> >       adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
> >                                                       GFP_KERNEL);
> >
> > -     if (adev->acp.acp_cell == NULL)
> > +     if (adev->acp.acp_cell == NULL) {
> > +             kfree(adev->acp.acp_genpd);
> >               return -ENOMEM;
> > +     }
> >
> >       adev->acp.acp_res = kcalloc(5, sizeof(struct resource),
> GFP_KERNEL);
> >       if (adev->acp.acp_res == NULL) {
> > +             kfree(adev->acp.acp_genpd);
> >               kfree(adev->acp.acp_cell);
> >               return -ENOMEM;
> >       }
> >
> >       i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data),
> GFP_KERNEL);
> >       if (i2s_pdata == NULL) {
> > +             kfree(adev->acp.acp_genpd);
> >               kfree(adev->acp.acp_res);
> >               kfree(adev->acp.acp_cell);
> >               return -ENOMEM;
> > @@ -348,6 +352,10 @@ static int acp_hw_init(void *handle)
> >               r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
> >               if (r) {
> >                       dev_err(dev, "Failed to add dev to genpd\n");
> > +                     kfree(adev->acp.acp_genpd);
> > +                     kfree(adev->acp.acp_res);
> > +                     kfree(adev->acp.acp_cell);
> > +                     kfree(i2s_pdata);
> >                       return r;
> >               }
> >       }
>
>

-- 
Navid.

--000000000000b366e40592d8839f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks=C2=A0Christian for the feedback, I&#39;ll send a v2=
.<div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, Sep 18, 2019 at 12:31 PM Koenig, Chr=
istian &lt;<a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig@amd=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Am 18.09.19 um 18:09 schrieb Navid Emamdoost:<br>
&gt; In acp_hw_init there are some allocations that needs to be released in=
<br>
&gt; case of failure:<br>
&gt;<br>
&gt; 1- adev-&gt;acp.acp_genpd should be released if any allocation attemp =
for<br>
&gt; adev-&gt;acp.acp_cell, adev-&gt;acp.acp_res or i2s_pdata fails.<br>
&gt; 2- all of those allocations should be released if pm_genpd_add_device<=
br>
&gt; fails.<br>
<br>
Good catch, but please use goto error handling instead of adding more <br>
and more kfree calls.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Navid Emamdoost &lt;<a href=3D"mailto:navid.emamdoost@g=
mail.com" target=3D"_blank">navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 10 +++++++++-<br=
>
&gt;=C2=A0 =C2=A01 file changed, 9 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acp.c<br>
&gt; index eba42c752bca..dd3fa85b11c5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c<br>
&gt; @@ -231,17 +231,21 @@ static int acp_hw_init(void *handle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;acp.acp_cell =3D kcalloc(ACP_DEVS, =
sizeof(struct mfd_cell),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (adev-&gt;acp.acp_cell =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (adev-&gt;acp.acp_cell =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;acp.ac=
p_genpd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;acp.acp_res =3D kcalloc(5, sizeof(s=
truct resource), GFP_KERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;acp.acp_res =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;acp.ac=
p_genpd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;a=
cp.acp_cell);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2s_pdata =3D kcalloc(3, sizeof(struct i2s_p=
latform_data), GFP_KERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i2s_pdata =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;acp.ac=
p_genpd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;a=
cp.acp_res);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;a=
cp.acp_cell);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt; @@ -348,6 +352,10 @@ static int acp_hw_init(void *handle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D pm_genpd_a=
dd_device(&amp;adev-&gt;acp.acp_genpd-&gt;gpd, dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dev_err(dev, &quot;Failed to add dev to genpd\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfree(adev-&gt;acp.acp_genpd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfree(adev-&gt;acp.acp_res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfree(adev-&gt;acp.acp_cell);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfree(i2s_pdata);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font col=
or=3D"#666666">Navid.</font></div></div></div></div>

--000000000000b366e40592d8839f--

--===============1019409045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1019409045==--

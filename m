From: Bo YU via dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Error handling issues about CHECKED_RETURN
Date: Thu, 14 Feb 2019 13:27:03 +0800
Message-ID: <CAKq8=3Jy8nYRtA9WsVaoavPbBtd=evPysjMdXi8bcN6OjoASdw@mail.gmail.com>
References: <20190214044628.26759-1-tsu.yubo@gmail.com>
 <DM6PR12MB2908A5B2BD12B9139C5DAB01B4670@DM6PR12MB2908.namprd12.prod.outlook.com>
Reply-To: Bo YU <tsu.yubo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1888902985=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <DM6PR12MB2908A5B2BD12B9139C5DAB01B4670@DM6PR12MB2908.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, Rex" <Rex.Zhu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1888902985==
Content-Type: multipart/alternative; boundary="0000000000003a40980581d3e958"

--0000000000003a40980581d3e958
Content-Type: text/plain; charset="UTF-8"

Ok, drop it.

On Thu, Feb 14, 2019 at 1:09 PM Zhou, David(ChunMing) <David1.Zhou@amd.com>
wrote:

>
>
> > -----Original Message-----
> > From: Bo YU <tsu.yubo@gmail.com>
> > Sent: Thursday, February 14, 2019 12:46 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> > <David1.Zhou@amd.com>; airlied@linux.ie; daniel@ffwll.ch; Zhu, Rex
> > <Rex.Zhu@amd.com>; Grodzovsky, Andrey
> > <Andrey.Grodzovsky@amd.com>; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Cc: Bo Yu <tsu.yubo@gmail.com>; amd-gfx@lists.freedesktop.org
> > Subject: [PATCH] drm/amdgpu: Error handling issues about
> > CHECKED_RETURN
> >
> > From: Bo Yu <tsu.yubo@gmail.com>
> >
> > Calling "amdgpu_ring_test_helper" without checking return value
>
> We could need to continue to ring test even there is one ring test failed.
>
> -David
>
> >
> > Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index 57cb3a51bda7..48465a61516b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -4728,7 +4728,9 @@ static int gfx_v8_0_cp_test_all_rings(struct
> > amdgpu_device *adev)
> >
> >       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> >               ring = &adev->gfx.compute_ring[i];
> > -             amdgpu_ring_test_helper(ring);
> > +             r = amdgpu_ring_test_helper(ring);
> > +             if (r)
> > +                     return r;
> >       }
> >
> >       return 0;
> > --
> > 2.11.0
>
>

--0000000000003a40980581d3e958
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok, drop it.</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Feb 14, 2019 at 1:09 PM Zhou, David(C=
hunMing) &lt;<a href=3D"mailto:David1.Zhou@amd.com">David1.Zhou@amd.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bord=
er-left-style:solid;padding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Bo YU &lt;<a href=3D"mailto:tsu.yubo@gmail.com" target=3D"_blank=
">tsu.yubo@gmail.com</a>&gt;<br>
&gt; Sent: Thursday, February 14, 2019 12:46 PM<br>
&gt; To: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com=
" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian<br=
>
&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com" target=3D"_blank">Chri=
stian.Koenig@amd.com</a>&gt;; Zhou, David(ChunMing)<br>
&gt; &lt;<a href=3D"mailto:David1.Zhou@amd.com" target=3D"_blank">David1.Zh=
ou@amd.com</a>&gt;; <a href=3D"mailto:airlied@linux.ie" target=3D"_blank">a=
irlied@linux.ie</a>; <a href=3D"mailto:daniel@ffwll.ch" target=3D"_blank">d=
aniel@ffwll.ch</a>; Zhu, Rex<br>
&gt; &lt;<a href=3D"mailto:Rex.Zhu@amd.com" target=3D"_blank">Rex.Zhu@amd.c=
om</a>&gt;; Grodzovsky, Andrey<br>
&gt; &lt;<a href=3D"mailto:Andrey.Grodzovsky@amd.com" target=3D"_blank">And=
rey.Grodzovsky@amd.com</a>&gt;; <a href=3D"mailto:dri-devel@lists.freedeskt=
op.org" target=3D"_blank">dri-devel@lists.freedesktop.org</a>; linux-<br>
&gt; <a href=3D"mailto:kernel@vger.kernel.org" target=3D"_blank">kernel@vge=
r.kernel.org</a><br>
&gt; Cc: Bo Yu &lt;<a href=3D"mailto:tsu.yubo@gmail.com" target=3D"_blank">=
tsu.yubo@gmail.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org=
" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
&gt; Subject: [PATCH] drm/amdgpu: Error handling issues about<br>
&gt; CHECKED_RETURN<br>
&gt; <br>
&gt; From: Bo Yu &lt;<a href=3D"mailto:tsu.yubo@gmail.com" target=3D"_blank=
">tsu.yubo@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Calling &quot;amdgpu_ring_test_helper&quot; without checking return va=
lue<br>
<br>
We could need to continue to ring test even there is one ring test failed.<=
br>
<br>
-David<br>
<br>
&gt; <br>
&gt; Signed-off-by: Bo Yu &lt;<a href=3D"mailto:tsu.yubo@gmail.com" target=
=3D"_blank">tsu.yubo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; index 57cb3a51bda7..48465a61516b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -4728,7 +4728,9 @@ static int gfx_v8_0_cp_test_all_rings(struct<br>
&gt; amdgpu_device *adev)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; adev-&gt;gfx.num_comput=
e_rings; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring =3D &amp;ad=
ev-&gt;gfx.compute_ring[i];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_test_help=
er(ring);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ring_tes=
t_helper(ring);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; --<br>
&gt; 2.11.0<br>
<br>
</blockquote></div>

--0000000000003a40980581d3e958--

--===============1888902985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1888902985==--

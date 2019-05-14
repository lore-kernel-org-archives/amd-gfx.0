From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Subject: Re: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU during CS
Date: Tue, 14 May 2019 15:33:25 -0400
Message-ID: <CAAxE2A6Z45NCy7v5fPqmo5o5ZEnmvv_f=qax0uoDS9amMFEB7w@mail.gmail.com>
References: <20190514123127.1650-1-christian.koenig@amd.com>
 <20190514123127.1650-11-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0541364042=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190514123127.1650-11-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Prike.Liang@amd.com, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0541364042==
Content-Type: multipart/alternative; boundary="0000000000006e01d50588de1d61"

--0000000000006e01d50588de1d61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series fixes the OOM errors. However, if I torture the kernel driver
more, I can get it to deadlock and end up with unkillable processes. I can
also get an OOM error. I just ran the test 5 times:

AMD_DEBUG=3Dtestgdsmm glxgears & AMD_DEBUG=3Dtestgdsmm glxgears &
AMD_DEBUG=3Dtestgdsmm glxgears & AMD_DEBUG=3Dtestgdsmm glxgears &
AMD_DEBUG=3Dtestgdsmm glxgears

Marek

On Tue, May 14, 2019 at 8:31 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> This avoids OOM situations when we have lots of threads
> submitting at the same time.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fff558cf385b..f9240a94217b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -648,7 +648,7 @@ static int amdgpu_cs_parser_bos(struct
> amdgpu_cs_parser *p,
>         }
>
>         r =3D ttm_eu_reserve_buffers(&p->ticket, &p->validated, true,
> -                                  &duplicates, true);
> +                                  &duplicates, false);
>         if (unlikely(r !=3D 0)) {
>                 if (r !=3D -ERESTARTSYS)
>                         DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--0000000000006e01d50588de1d61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>This series fixes the OOM errors. Ho=
wever, if I torture the kernel driver more, I can get it to deadlock and en=
d up with unkillable processes. I can also get an OOM error. I just ran the=
 test 5 times:</div><div><br></div><div>AMD_DEBUG=3Dtestgdsmm glxgears &amp=
; AMD_DEBUG=3Dtestgdsmm glxgears &amp; AMD_DEBUG=3Dtestgdsmm glxgears &amp;=
 AMD_DEBUG=3Dtestgdsmm glxgears &amp; AMD_DEBUG=3Dtestgdsmm glxgears</div><=
div></div><br><div>Marek<br></div></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 14, 2019 at 8:31 AM Chr=
istian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">c=
koenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">This avoids OOM situations when we have lo=
ts of threads<br>
submitting at the same time.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index fff558cf385b..f9240a94217b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -648,7 +648,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser=
 *p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D ttm_eu_reserve_buffers(&amp;p-&gt;ticket,=
 &amp;p-&gt;validated, true,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;duplicates, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;duplicates, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(r !=3D 0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r !=3D -ERESTAR=
TSYS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DRM_ERROR(&quot;ttm_eu_reserve_buffers failed.\n&quot;);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div>

--0000000000006e01d50588de1d61--

--===============0541364042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0541364042==--

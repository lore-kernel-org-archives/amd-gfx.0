From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix undue fallthroughs in golden registers
 initialization
Date: Mon, 31 Jul 2017 03:07:29 +0200
Message-ID: <CAAxE2A6=6p_PQqHgiKOTF+jFZt2QGQ7zJqo-nDnFVjHMdb0e1A@mail.gmail.com>
References: <20170730101825.4c025c84@endymion>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1754478462=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170730101825.4c025c84@endymion>
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
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============1754478462==
Content-Type: multipart/alternative; boundary="001a113f390210b451055592aa98"

--001a113f390210b451055592aa98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Marek

On Sun, Jul 30, 2017 at 10:18 AM, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:

> As I was staring at the si_init_golden_registers code, I noticed that
> the Pitcairn initialization silently falls through the Cape Verde
> initialization, and the Oland initialization falls through the Hainan
> initialization. However there is no comment stating that this is
> intentional, and the radeon driver doesn't have any such fallthrough,
> so I suspect this is not supposed to happen.
>
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Fixes: 62a37553414a ("drm/amdgpu: add si implementation v10")
> Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>
> Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: "Marek Ol=C5=A1=C3=A1k" <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: "Christian K=C3=B6nig" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Cc: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
> ---
> If the fallthroughs are really supposed to happen, comments should be
> added that say so. Surprisingly it doesn't seem to make any
> difference on my Oland card.
>
>  drivers/gpu/drm/amd/amdgpu/si.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-4.12.orig/drivers/gpu/drm/amd/amdgpu/si.c     2017-07-30
> 09:25:46.891083334 +0200
> +++ linux-4.12/drivers/gpu/drm/amd/amdgpu/si.c  2017-07-30
> 09:45:24.350188642 +0200
> @@ -1385,6 +1385,7 @@ static void si_init_golden_registers(str
>                 amdgpu_program_register_sequence(adev,
>                                                  pitcairn_mgcg_cgcg_init,
>                                                  (const
> u32)ARRAY_SIZE(pitcairn_mgcg_cgcg_init));
> +               break;
>         case CHIP_VERDE:
>                 amdgpu_program_register_sequence(adev,
>                                                  verde_golden_registers,
> @@ -1409,6 +1410,7 @@ static void si_init_golden_registers(str
>                 amdgpu_program_register_sequence(adev,
>                                                  oland_mgcg_cgcg_init,
>                                                  (const
> u32)ARRAY_SIZE(oland_mgcg_cgcg_init));
> +               break;
>         case CHIP_HAINAN:
>                 amdgpu_program_register_sequence(adev,
>                                                  hainan_golden_registers,
>
>
> --
> Jean Delvare
> SUSE L3 Support
>

--001a113f390210b451055592aa98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak-5C7GfCeVMHo@public.gmane.org">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br><br></div>Marek<br>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, Jul=
 30, 2017 at 10:18 AM, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto=
:jdelvare-l3A5Bk7waGM@public.gmane.org" target=3D"_blank">jdelvare-l3A5Bk7waGM@public.gmane.org</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">As I was staring at the si_init_golden_r=
egisters code, I noticed that<br>
the Pitcairn initialization silently falls through the Cape Verde<br>
initialization, and the Oland initialization falls through the Hainan<br>
initialization. However there is no comment stating that this is<br>
intentional, and the radeon driver doesn&#39;t have any such fallthrough,<b=
r>
so I suspect this is not supposed to happen.<br>
<br>
Signed-off-by: Jean Delvare &lt;<a href=3D"mailto:jdelvare-l3A5Bk7waGM@public.gmane.org">jdelvar=
e@suse.de</a>&gt;<br>
Fixes: 62a37553414a (&quot;drm/amdgpu: add si implementation v10&quot;)<br>
Cc: Ken Wang &lt;<a href=3D"mailto:Qingqing.Wang-5C7GfCeVMHo@public.gmane.org">Qingqing.Wang@amd=
.com</a>&gt;<br>
Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alexander=
.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Cc: &quot;Marek Ol=C5=A1=C3=A1k&quot; &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8@public.gmane.org=
m">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Cc: &quot;Christian K=C3=B6nig&quot; &lt;<a href=3D"mailto:christian.koenig=
@amd.com">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Cc: Flora Cui &lt;<a href=3D"mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org">Flora.Cui-5C7GfCeVMHo@public.gmane.org</a=
>&gt;<br>
---<br>
If the fallthroughs are really supposed to happen, comments should be<br>
added that say so. Surprisingly it doesn&#39;t seem to make any<br>
difference on my Oland card.<br>
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/si.<wbr>c |=C2=A0 =C2=A0 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
--- linux-4.12.orig/drivers/gpu/<wbr>drm/amd/amdgpu/si.c=C2=A0 =C2=A0 =C2=
=A02017-07-30 09:25:46.891083334 +0200<br>
+++ linux-4.12/drivers/gpu/drm/<wbr>amd/amdgpu/si.c=C2=A0 2017-07-30 09:45:=
24.350188642 +0200<br>
@@ -1385,6 +1385,7 @@ static void si_init_golden_registers(str<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_program_regi=
ster_<wbr>sequence(adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pitcairn_mgcg_cgcg_init,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(const u32)ARRAY_SIZE(pitcairn_mgcg_<wbr>cgcg_in=
it));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_VERDE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_program_regi=
ster_<wbr>sequence(adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0verde_golden_registers,<br>
@@ -1409,6 +1410,7 @@ static void si_init_golden_registers(str<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_program_regi=
ster_<wbr>sequence(adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0oland_mgcg_cgcg_init,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(const u32)ARRAY_SIZE(oland_mgcg_<wbr>cgcg_init)=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_HAINAN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_program_regi=
ster_<wbr>sequence(adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0hainan_golden_registers,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Jean Delvare<br>
SUSE L3 Support<br>
</font></span></blockquote></div><br></div>

--001a113f390210b451055592aa98--

--===============1754478462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1754478462==--

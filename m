From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amdgpu/ci: disable mclk switching for high
 refresh rates
Date: Fri, 12 May 2017 09:49:17 +0200
Message-ID: <CA+nq7DtJjexTWohBmnBpsRyjsp70RjvUu5ZWG1hdu11-eHEgag@mail.gmail.com>
References: <1494525521-20864-1-git-send-email-alexander.deucher@amd.com>
 <CA+nq7DsJ=Bd4_yM=0xsv4a3MB2dyyVF_UfJE1h5Y4980cdF2nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0272438054=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CA+nq7DsJ=Bd4_yM=0xsv4a3MB2dyyVF_UfJE1h5Y4980cdF2nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0272438054==
Content-Type: multipart/alternative; boundary="94eb2c1cd1f24caec1054f4ef11a"

--94eb2c1cd1f24caec1054f4ef11a
Content-Type: text/plain; charset="UTF-8"

Hi, Alex

Shouldn't the function return true when the refresh rate > 120? If so, same
comment on patch 2.

BR
Nils


Den 11 maj 2017 7:59 em skrev "Alex Deucher" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

Even if the vblank period would allow it, it still seems to
be problematic on some cards.

bug: https://bugs.freedesktop.org/show_bug.cgi?id=96868

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
index 6dc1410..eb5d03b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
@@ -906,6 +906,12 @@ static bool ci_dpm_vblank_too_short(struct
amdgpu_device *adev)
        u32 vblank_time = amdgpu_dpm_get_vblank_time(adev);
        u32 switch_limit = adev->mc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ?
450 : 300;

+       /* disable mclk switching if the refresh is >120Hz, even if the
+        * blanking period would allow it
+        */
+       if (amdgpu_dpm_get_vrefresh(adev) > 120)
+               return false;
+
        if (vblank_time < switch_limit)
                return true;
        else
--
2.5.5

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--94eb2c1cd1f24caec1054f4ef11a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi, Alex<div dir=3D"auto"><br></div><div dir=3D"auto=
">Shouldn&#39;t the function return true when the refresh rate &gt; 120? If=
 so, same comment on patch 2.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">BR</div><div dir=3D"auto">Nils</div><br><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">Den 11 maj 2017 7:59 em skrev &quot;Alex Deuch=
er&quot; &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
</a>&gt;:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Even if the vbla=
nk period would allow it, it still seems to<br>
be problematic on some cards.<br>
<br>
bug: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D96868" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.freedesktop.org/<wbr>show_bu=
g.cgi?id=3D96868</a><br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/ci_<wbr>dpm.c | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>ci_dpm.c b/drivers/gpu/drm/amd=
/amdgpu/<wbr>ci_dpm.c<br>
index 6dc1410..eb5d03b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>ci_dpm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>ci_dpm.c<br>
@@ -906,6 +906,12 @@ static bool ci_dpm_vblank_too_short(struct amdgpu_devi=
ce *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 vblank_time =3D amdgpu_dpm_get_vblank_time(=
<wbr>adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 switch_limit =3D adev-&gt;mc.vram_type =3D=
=3D AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 300;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* disable mclk switching if the refresh is &gt=
;120Hz, even if the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * blanking period would allow it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_dpm_get_vrefresh(adev) &gt; 120)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vblank_time &lt; switch_limit)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
<font color=3D"#888888">--<br>
2.5.5<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</font></blockquote></div><br></div></div></div>

--94eb2c1cd1f24caec1054f4ef11a--

--===============0272438054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0272438054==--

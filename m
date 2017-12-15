From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amd/amdgpu: set gtt size according to system
 memory size only"
Date: Fri, 15 Dec 2017 19:44:29 +0000
Message-ID: <BN6PR12MB1652C9469B6CB554006FF9AFF70B0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1513364973-18300-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1739508575=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513364973-18300-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1739508575==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652C9469B6CB554006FF9AFF70B0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652C9469B6CB554006FF9AFF70B0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Andrey G=
rodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, December 15, 2017 2:09 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: He, Roger; Daenzer, Michel; Koenig, Christian; Grodzovsky, Andrey
Subject: [PATCH] Revert "drm/amd/amdgpu: set gtt size according to system m=
emory size only"

This reverts commit ba851eed895c76be0eb4260bdbeb7e26f9ccfaa2.
With that change piglit max size tests (running with -t max.*size) are caus=
ing
OOM and hard hang on my CZ with 1GB RAM.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index c307a7d..814a9c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1329,9 +1329,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
                 struct sysinfo si;

                 si_meminfo(&si);
-               gtt_size =3D max(AMDGPU_DEFAULT_GTT_SIZE_MB << 20,
-                       (uint64_t)si.totalram * si.mem_unit * 3/4);
-       } else
+               gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
+                              adev->mc.mc_vram_size),
+                              ((uint64_t)si.totalram * si.mem_unit * 3/4))=
;
+       }
+       else
                 gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
         r =3D ttm_bo_init_mm(&adev->mman.bdev, TTM_PL_TT, gtt_size >> PAGE=
_SHIFT);
         if (r) {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652C9469B6CB554006FF9AFF70B0BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Andrey Grodzovsky &lt;andre=
y.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, December 15, 2017 2:09 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> He, Roger; Daenzer, Michel; Koenig, Christian; Grodzovsky, Andre=
y<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amd/amdgpu: set gtt size according=
 to system memory size only&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">This reverts commit ba851eed895c76be0eb4260bdbeb7e=
26f9ccfaa2.<br>
With that change piglit max size tests (running with -t max.*size) are caus=
ing<br>
OOM and hard hang on my CZ with 1GB RAM.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Acked-by: Alex Deucher &lt;alexander.deucher@amd.c=
om&gt;<br>
</div>
<div class=3D"PlainText"><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 &#43;&#43;&#43;&#43;&#43;=
---<br>
&nbsp;1 file changed, 5 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index c307a7d..814a9c1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1329,9 &#43;1329,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct sysinfo si;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; si_meminfo(&amp;si);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gtt_size =3D max(AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t)si.tot=
alram * si.mem_unit * 3/4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20=
),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mc.mc_vram_size),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)si.totalram * si.mem_unit * 3/4));=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gtt_size =3D (uint64_t)amdgpu_gtt_size &lt;&lt; 20;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_init_mm(&amp;=
adev-&gt;mman.bdev, TTM_PL_TT, gtt_size &gt;&gt; PAGE_SHIFT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk710875" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652C9469B6CB554006FF9AFF70B0BN6PR12MB1652namp_--

--===============1739508575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1739508575==--

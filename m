From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7_smu_fini
Date: Thu, 4 Jan 2018 16:08:48 +0000
Message-ID: <BN6PR12MB1652FC402BB6484951B4B846F71F0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180104160122.22697-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1809204226=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180104160122.22697-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Tao,
 Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>

--===============1809204226==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652FC402BB6484951B4B846F71F0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652FC402BB6484951B4B846F71F0BN6PR12MB1652namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, January 4, 2018 11:01 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Tao, Yintian
Cc: Wentland, Harry
Subject: [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7_smu_fini

This fixes these warnings:

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c: In function =
=91smu7_smu_fini=92:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:653:33: warnin=
g: passing argument 2 of =91smu_free_memory=92 makes pointer from integer w=
ithout a cast [-Wint-conversion]
  smu_free_memory(hwmgr->device, smu_data->header_buffer.handle);
                                 ^~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 =91void *=92 but argument is of type =91long unsigned int=92
 extern int smu_free_memory(void *device, void *handle);
            ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:655:34: warnin=
g: passing argument 2 of =91smu_free_memory=92 makes pointer from integer w=
ithout a cast [-Wint-conversion]
   smu_free_memory(hwmgr->device, smu_data->smu_buffer.handle);
                                  ^~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 =91void *=92 but argument is of type =91long unsigned int=92
 extern int smu_free_memory(void *device, void *handle);
            ^~~~~~~~~~~~~~~

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 25dd7781c9f2..311ff3718618 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -650,9 +650,9 @@ int smu7_smu_fini(struct pp_hwmgr *hwmgr)
 {
         struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->smu=
_backend);

-       smu_free_memory(hwmgr->device, smu_data->header_buffer.handle);
+       smu_free_memory(hwmgr->device, (void *) smu_data->header_buffer.han=
dle);
         if (!cgs_is_virtualization_enabled(hwmgr->device))
-               smu_free_memory(hwmgr->device, smu_data->smu_buffer.handle)=
;
+               smu_free_memory(hwmgr->device, (void *) smu_data->smu_buffe=
r.handle);

         kfree(hwmgr->smu_backend);
         hwmgr->smu_backend =3D NULL;
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652FC402BB6484951B4B846F71F0BN6PR12MB1652namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.we=
ntland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, January 4, 2018 11:01 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Tao, Yintian<br>
<b>Cc:</b> Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7_smu=
_fini</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This fixes these warnings:<br>
<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c: In function =
=91smu7_smu_fini=92:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:653:33: warnin=
g: passing argument 2 of =91smu_free_memory=92 makes pointer from integer w=
ithout a cast [-Wint-conversion]<br>
&nbsp; smu_free_memory(hwmgr-&gt;device, smu_data-&gt;header_buffer.handle)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~<br>
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 =91void *=92 but argument is of type =91long unsigned int=92<br>
&nbsp;extern int smu_free_memory(void *device, void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~=
~~~~~~~<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:655:34: warnin=
g: passing argument 2 of =91smu_free_memory=92 makes pointer from integer w=
ithout a cast [-Wint-conversion]<br>
&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device, smu_data-&gt;smu_buffer.hand=
le);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~<br>
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 =91void *=92 but argument is of type =91long unsigned int=92<br>
&nbsp;extern int smu_free_memory(void *device, void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~=
~~~~~~~<br>
<br>
Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 4 &#43;&#43;--<b=
r>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
index 25dd7781c9f2..311ff3718618 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
@@ -650,9 &#43;650,9 @@ int smu7_smu_fini(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_da=
ta =3D (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device, smu=
_data-&gt;header_buffer.handle);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device,=
 (void *) smu_data-&gt;header_buffer.handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cgs_is_virtualization=
_enabled(hwmgr-&gt;device))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_free_memory(hwmgr-&gt;device, smu_data-&gt;smu_buffer.handle=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device, (void *) smu_data-&gt;smu_=
buffer.handle);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;smu_backen=
d);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;smu_backend =3D =
NULL;<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk110459" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652FC402BB6484951B4B846F71F0BN6PR12MB1652namp_--

--===============1809204226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1809204226==--

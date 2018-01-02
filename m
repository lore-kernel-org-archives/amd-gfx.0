From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix memory leakage when reload
Date: Tue, 2 Jan 2018 15:00:19 +0000
Message-ID: <DM5PR12MB16601E771F35BCEC2A80C555F7190@DM5PR12MB1660.namprd12.prod.outlook.com>
References: <1514776580-17052-1-git-send-email-yttao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1233113003=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1514776580-17052-1-git-send-email-yttao-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>

--===============1233113003==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB16601E771F35BCEC2A80C555F7190DM5PR12MB1660namp_"

--_000_DM5PR12MB16601E771F35BCEC2A80C555F7190DM5PR12MB1660namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yintian =
Tao <yttao-5C7GfCeVMHo@public.gmane.org>
Sent: Sunday, December 31, 2017 10:16 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tao, Yintian
Subject: [PATCH] drm/amd/powerplay: fix memory leakage when reload

add smu_free_memory when smu fini to prevent memory leakage

Change-Id: Id9103d8b54869b63f22a9af53d9fbc3b7a221191
Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Looks like vega10, cz, rv have the same issue can you send patches for them=
 as well?

Thanks,

Alex

---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index c49a6f2..925217e 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -607,6 +607,12 @@ int smu7_init(struct pp_smumgr *smumgr)

 int smu7_smu_fini(struct pp_smumgr *smumgr)
 {
+       struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(smumgr->bac=
kend);
+
+       smu_free_memory(smumgr->device, smu_data->header_buffer.handle);
+       if (!cgs_is_virtualization_enabled(smumgr->device))
+               smu_free_memory(smumgr->device, smu_data->smu_buffer.handle=
);
+
         if (smumgr->backend) {
                 kfree(smumgr->backend);
                 smumgr->backend =3D NULL;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB16601E771F35BCEC2A80C555F7190DM5PR12MB1660namp_
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
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yintian Tao &lt;yttao@amd.c=
om&gt;<br>
<b>Sent:</b> Sunday, December 31, 2017 10:16 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Tao, Yintian<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: fix memory leakage when reload</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">add smu_free_memory when smu fini to prevent memor=
y leakage<br>
<br>
Change-Id: Id9103d8b54869b63f22a9af53d9fbc3b7a221191<br>
Signed-off-by: Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Reviewed-by: Alex Deucher &lt;alexander.deucher@am=
d.com&gt;<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Looks like vega10, cz, rv have the same issue can =
you send patches for them as well?</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Thanks,</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Alex<br>
</div>
<div class=3D"PlainText"><br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 6 &#43;&#43;&#43=
;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
index c49a6f2..925217e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
@@ -607,6 &#43;607,12 @@ int smu7_init(struct pp_smumgr *smumgr)<br>
&nbsp;<br>
&nbsp;int smu7_smu_fini(struct pp_smumgr *smumgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_data =3D =
(struct smu7_smumgr *)(smumgr-&gt;backend);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_free_memory(smumgr-&gt;device=
, smu_data-&gt;header_buffer.handle);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cgs_is_virtualization_enable=
d(smumgr-&gt;device))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_free_memory(smumgr-&gt;device, smu_data-&gt;smu_buffer.h=
andle);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smumgr-&gt;backend) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(smumgr-&gt;backend);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smumgr-&gt;backend =3D NULL;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk576477" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB16601E771F35BCEC2A80C555F7190DM5PR12MB1660namp_--

--===============1233113003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1233113003==--

From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix memory leakage when reload
Date: Wed, 3 Jan 2018 14:32:23 +0000
Message-ID: <BN6PR12MB1652DDD5B775B8D64A2E42E1F71E0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1514776580-17052-1-git-send-email-yttao@amd.com>,
 <DM3PR1201MB1040AD31CDCD1F1ECA34329CE51E0@DM3PR1201MB1040.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684567452=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM3PR1201MB1040AD31CDCD1F1ECA34329CE51E0-BBcFnVpqZhWvVYYlwACKW2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1684567452==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652DDD5B775B8D64A2E42E1F71E0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652DDD5B775B8D64A2E42E1F71E0BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Did you see my reply yesterday?  I reviewed it.  I also think we need to fi=
x up cz, rv, and vg10.

________________________________
From: Tao, Yintian
Sent: Tuesday, January 2, 2018 9:22:23 PM
To: Tao, Yintian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
Subject: RE: [PATCH] drm/amd/powerplay: fix memory leakage when reload

Add Alex

-----Original Message-----
From: Yintian Tao [mailto:yttao-5C7GfCeVMHo@public.gmane.org]
Sent: Monday, January 01, 2018 11:16 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix memory leakage when reload

add smu_free_memory when smu fini to prevent memory leakage

Change-Id: Id9103d8b54869b63f22a9af53d9fbc3b7a221191
Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index c49a6f2..925217e 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -607,6 +607,12 @@ int smu7_init(struct pp_smumgr *smumgr)

 int smu7_smu_fini(struct pp_smumgr *smumgr)  {
+       struct smu7_smumgr *smu_data =3D (struct smu7_smumgr
+*)(smumgr->backend);
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


--_000_BN6PR12MB1652DDD5B775B8D64A2E42E1F71E0BN6PR12MB1652namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Did you see my reply yesterday?&n=
bsp; I reviewed it.&nbsp; I also think we need to fix up cz, rv, and vg10.<=
br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tao, Yintian<br>
<b>Sent:</b> Tuesday, January 2, 2018 9:22:23 PM<br>
<b>To:</b> Tao, Yintian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<=
br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: fix memory leakage when relo=
ad</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add Alex<br>
<br>
-----Original Message-----<br>
From: Yintian Tao [<a href=3D"mailto:yttao-5C7GfCeVMHo@public.gmane.org">mailto:yttao-5C7GfCeVMHo@public.gmane.org</a=
>] <br>
Sent: Monday, January 01, 2018 11:16 AM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Tao, Yintian &lt;Yintian.Tao-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amd/powerplay: fix memory leakage when reload<br>
<br>
add smu_free_memory when smu fini to prevent memory leakage<br>
<br>
Change-Id: Id9103d8b54869b63f22a9af53d9fbc3b7a221191<br>
Signed-off-by: Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&nbsp;int smu7_smu_fini(struct pp_smumgr *smumgr)&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_data =3D =
(struct smu7_smumgr <br>
&#43;*)(smumgr-&gt;backend);<br>
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
--<br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1652DDD5B775B8D64A2E42E1F71E0BN6PR12MB1652namp_--

--===============1684567452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1684567452==--

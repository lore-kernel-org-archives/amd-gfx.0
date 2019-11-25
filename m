From: "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Null check aconnector in
 event_property_validate
Date: Mon, 25 Nov 2019 15:41:53 +0000
Message-ID: <DM6PR12MB346695688D92D386098283019E4A0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191125154024.21218-1-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2127451733=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191125154024.21218-1-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>

--===============2127451733==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_"

--_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Zhan Liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Bhawanpr=
eet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 25, 2019 10:40:24 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Null check aconnector in event_property_v=
alidate

[Why]
previously event_property_validate was only called after we enabled the dis=
play.
But after "Refactor HDCP to handle multiple displays per link" this functio=
n
can be called at any time. In certain cases we don't have a aconnector

[How]
Null check aconnector and exit early. This is ok because we only need to ch=
eck the
ENABLED->DESIRED transition if a connector exists.

Fixes :cc5dae9f6286 drm/amd/display: Refactor HDCP to handle multiple displ=
ays per link
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index f6864a51891a..ae329335dfcc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -225,6 +225,9 @@ static void event_property_validate(struct work_struct =
*work)
         struct mod_hdcp_display_query query;
         struct amdgpu_dm_connector *aconnector =3D hdcp_work->aconnector;

+       if (!aconnector)
+               return;
+
         mutex_lock(&hdcp_work->mutex);

         query.encryption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Czhan.liu=
%40amd.com%7C22996511e2124290c9fc08d771bdd059%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C1%7C637102932411167739&amp;sdata=3DQ0Wlb9vuIRKJgLfiFmpLIJWWsQzm=
j9hFm3dOKBVxutw%3D&amp;reserved=3D0

--_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div>
<div>
<div style=3D"direction: ltr;">Reviewed-by: Zhan Liu &lt;zhan.liu-5C7GfCeVMHo@public.gmane.org&g=
t;</div>
</div>
<div><br>
</div>
<div class=3D"ms-outlook-ios-signature"></div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Bhawanpreet Lakha &lt;Bhawanp=
reet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, November 25, 2019 10:40:24 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Null check aconnector in event_pro=
perty_validate</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
previously event_property_validate was only called after we enabled the dis=
play.<br>
But after &quot;Refactor HDCP to handle multiple displays per link&quot; th=
is function<br>
can be called at any time. In certain cases we don't have a aconnector<br>
<br>
[How]<br>
Null check aconnector and exit early. This is ok because we only need to ch=
eck the<br>
ENABLED-&gt;DESIRED transition if a connector exists.<br>
<br>
Fixes :cc5dae9f6286 drm/amd/display: Refactor HDCP to handle multiple displ=
ays per link<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3 &#43;&#43;=
&#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
index f6864a51891a..ae329335dfcc 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br=
>
@@ -225,6 &#43;225,9 @@ static void event_property_validate(struct work_str=
uct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display_qu=
ery query;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector=
 *aconnector =3D hdcp_work-&gt;aconnector;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aconnector)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_work-=
&gt;mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query.encryption_status =
=3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Czhan.liu%40amd.com%7C22996511e2124290c9fc08d771bdd059%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C1%7C637102932411167739&amp;amp;sdata=3DQ0Wlb9vuI=
RKJgLfiFmpLIJWWsQzmj9hFm3dOKBVxutw%3D&amp;amp;reserved=3D0">https://nam11.s=
afelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%=
2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Czhan.liu%40amd.com%=
7C22996511e2124290c9fc08d771bdd059%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C1%7C637102932411167739&amp;amp;sdata=3DQ0Wlb9vuIRKJgLfiFmpLIJWWsQzmj9hFm3d=
OKBVxutw%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_--

--===============2127451733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2127451733==--

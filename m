From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Get NV14 specific ip params as needed
Date: Tue, 26 Nov 2019 21:57:23 +0000
Message-ID: <BN6PR12MB1809C6D92762CA1ADA8E6046F7450@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20191126213222.17728-1-zhan.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1594095940=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191126213222.17728-1-zhan.liu-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>

--===============1594095940==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_"

--_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhan Liu=
 <zhan.liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, November 26, 2019 4:32 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Wu, Hers=
en <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>; Siqueira, Rodrigo <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Cc: Liu, Zhan <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Get NV14 specific ip params as needed

[Why]
NV14 is using its own ip params that's different from other
DCN2.0 ASICs.

[How]
Add ASIC revision check to make sure NV14 gets correct
ip params.

Signed-off-by: Zhan Liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index dbc0a4a7c284..3dd2b2429ae2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3245,6 +3245,9 @@ static struct _vcs_dpi_soc_bounding_box_st *get_asic_=
rev_soc_bb(
 static struct _vcs_dpi_ip_params_st *get_asic_rev_ip_params(
         uint32_t hw_internal_rev)
 {
+       if (ASICREV_IS_NAVI14_M(hw_internal_rev))
+               return &dcn2_0_nv14_ip;
+
         /* NV12 and NV10 */
         return &dcn2_0_ip;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cbea3a51cb27f4ad9694e08d772b829b4%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637104007649236121&amp;sdata=3Dp72lWgE%2FB63Exu9JF=
i7eQ86mk%2FbBB8%2BE5BkBR0SUwqY%3D&amp;reserved=3D0

--_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhan Liu &lt;zhan.liu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Tuesday, November 26, 2019 4:32 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Wu, Hersen &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;; Siqueira, Rodrigo &lt;Rodrigo.=
Siqueira-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Liu, Zhan &lt;Zhan.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Get NV14 specific ip params as nee=
ded</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
NV14 is using its own ip params that's different from other<br>
DCN2.0 ASICs.<br>
<br>
[How]<br>
Add ASIC revision check to make sure NV14 gets correct<br>
ip params.<br>
<br>
Signed-off-by: Zhan Liu &lt;zhan.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 &#43;&#43;&=
#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
index dbc0a4a7c284..3dd2b2429ae2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
@@ -3245,6 &#43;3245,9 @@ static struct _vcs_dpi_soc_bounding_box_st *get_a=
sic_rev_soc_bb(<br>
&nbsp;static struct _vcs_dpi_ip_params_st *get_asic_rev_ip_params(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hw_internal_rev)<=
br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_NAVI14_M(hw_intern=
al_rev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return &amp;dcn2_0_nv14_ip;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NV12 and NV10 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;dcn2_0_ip;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cbea3a51cb27f4ad9694e08d772b829b4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637104007649236121&amp;amp;sdata=3D=
p72lWgE%2FB63Exu9JFi7eQ86mk%2FbBB8%2BE5BkBR0SUwqY%3D&amp;amp;reserved=3D0">=
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7Cbea3a51cb27f4ad9694e08d772b829b4%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637104007649236121&amp;amp;sdata=3Dp72lWgE%2FB=
63Exu9JFi7eQ86mk%2FbBB8%2BE5BkBR0SUwqY%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809C6D92762CA1ADA8E6046F7450BN6PR12MB1809namp_--

--===============1594095940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1594095940==--

From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: use mlck_table.count for array loop index
 limit
Date: Thu, 22 Mar 2018 15:03:41 +0000
Message-ID: <CY4PR12MB168776DA4105C73E1C979C64FBA90@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180321182653.3150-1-colin.king@canonical.com>,
 <1521658930.7999.25.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2015286484=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521658930.7999.25.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
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
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============2015286484==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168776DA4105C73E1C979C64FBA90CY4PR12MB1687namp_"

--_000_CY4PR12MB168776DA4105C73E1C979C64FBA90CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks.  Will apply the patch to drm-next.


Best Regards

Rex

________________________________
From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sent: Thursday, March 22, 2018 3:02 AM
To: Colin King; Koenig, Christian; Zhou, David(ChunMing); David Airlie; Zhu=
, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH] drm/amd/pp: use mlck_table.count for array loop index =
limit

On Wed, 2018-03-21 at 18:26 +0000, Colin King wrote:
> From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>
> The for-loops process data in the mclk_table but use slck_table.count
> as the loop index limit.  I believe these are cut-n-paste errors from
> the previous almost identical loops as indicated by static analysis.
> Fix these.

Nice tool.

> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
[]
> @@ -855,7 +855,7 @@ static int smu7_odn_initial_default_setting(struct pp=
_hwmgr *hwmgr)
>
>        odn_table->odn_memory_clock_dpm_levels.num_of_pl =3D
>                                                data->golden_dpm_table.mcl=
k_table.count;
> -     for (i=3D0; i<data->golden_dpm_table.sclk_table.count; i++) {
> +     for (i=3D0; i<data->golden_dpm_table.mclk_table.count; i++) {
>                odn_table->odn_memory_clock_dpm_levels.entries[i].clock =
=3D
>                                        data->golden_dpm_table.mclk_table.=
dpm_levels[i].value;
>                odn_table->odn_memory_clock_dpm_levels.entries[i].enabled =
=3D true;

Probably more sensible to use temporaries too.
Maybe something like the below (also trivially reduces object size)
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index df2a312ca6c9..339b897146af 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -834,6 +834,7 @@ static int smu7_odn_initial_default_setting(struct pp_h=
wmgr *hwmgr)

         struct phm_ppt_v1_clock_voltage_dependency_table *dep_sclk_table;
         struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table;
+       struct phm_odn_performance_level *entries;

         if (table_info =3D=3D NULL)
                 return -EINVAL;
@@ -843,11 +844,11 @@ static int smu7_odn_initial_default_setting(struct pp=
_hwmgr *hwmgr)

         odn_table->odn_core_clock_dpm_levels.num_of_pl =3D
                                                 data->golden_dpm_table.scl=
k_table.count;
+       entries =3D odn_table->odn_core_clock_dpm_levels.entries;
         for (i=3D0; i<data->golden_dpm_table.sclk_table.count; i++) {
-               odn_table->odn_core_clock_dpm_levels.entries[i].clock =3D
-                                       data->golden_dpm_table.sclk_table.d=
pm_levels[i].value;
-               odn_table->odn_core_clock_dpm_levels.entries[i].enabled =3D=
 true;
-               odn_table->odn_core_clock_dpm_levels.entries[i].vddc =3D de=
p_sclk_table->entries[i].vddc;
+               entries[i].clock =3D data->golden_dpm_table.sclk_table.dpm_=
levels[i].value;
+               entries[i].enabled =3D true;
+               entries[i].vddc =3D dep_sclk_table->entries[i].vddc;
         }

         smu7_get_voltage_dependency_table(dep_sclk_table,
@@ -855,11 +856,11 @@ static int smu7_odn_initial_default_setting(struct pp=
_hwmgr *hwmgr)

         odn_table->odn_memory_clock_dpm_levels.num_of_pl =3D
                                                 data->golden_dpm_table.mcl=
k_table.count;
-       for (i=3D0; i<data->golden_dpm_table.sclk_table.count; i++) {
-               odn_table->odn_memory_clock_dpm_levels.entries[i].clock =3D
-                                       data->golden_dpm_table.mclk_table.d=
pm_levels[i].value;
-               odn_table->odn_memory_clock_dpm_levels.entries[i].enabled =
=3D true;
-               odn_table->odn_memory_clock_dpm_levels.entries[i].vddc =3D =
dep_mclk_table->entries[i].vddc;
+       entries =3D odn_table->odn_memory_clock_dpm_levels.entries;
+       for (i=3D0; i<data->golden_dpm_table.mclk_table.count; i++) {
+               entries[i].clock =3D data->golden_dpm_table.mclk_table.dpm_=
levels[i].value;
+               entries[i].enabled =3D true;
+               entries[i].vddc =3D dep_mclk_table->entries[i].vddc;
         }

         smu7_get_voltage_dependency_table(dep_mclk_table,

--_000_CY4PR12MB168776DA4105C73E1C979C64FBA90CY4PR12MB1687namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Thanks. &nbsp;Will apply the patc=
h to drm-next.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joe Perches &lt;joe@p=
erches.com&gt;<br>
<b>Sent:</b> Thursday, March 22, 2018 3:02 AM<br>
<b>To:</b> Colin King; Koenig, Christian; Zhou, David(ChunMing); David Airl=
ie; Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g<br>
<b>Cc:</b> kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br=
>
<b>Subject:</b> Re: [PATCH] drm/amd/pp: use mlck_table.count for array loop=
 index limit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, 2018-03-21 at 18:26 &#43;0000, Colin King =
wrote:<br>
&gt; From: Colin Ian King &lt;colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;<br>
&gt; <br>
&gt; The for-loops process data in the mclk_table but use slck_table.count<=
br>
&gt; as the loop index limit.&nbsp; I believe these are cut-n-paste errors =
from<br>
&gt; the previous almost identical loops as indicated by static analysis.<b=
r>
&gt; Fix these.<br>
<br>
Nice tool.<br>
<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
[]<br>
&gt; @@ -855,7 &#43;855,7 @@ static int smu7_odn_initial_default_setting(st=
ruct pp_hwmgr *hwmgr)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_table-&gt;odn_memory_clo=
ck_dpm_levels.num_of_pl =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;gold=
en_dpm_table.mclk_table.count;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;golden_dpm_table.s=
clk_table.count; i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;golden_dpm_tab=
le.mclk_table.count; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].cl=
ock =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; data-&gt;golden_dpm_table.mclk_table.dpm_levels[i].value;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].en=
abled =3D true;<br>
<br>
Probably more sensible to use temporaries too.<br>
Maybe something like the below (also trivially reduces object size)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 19 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;1 file changed, 10 insertions(&#43;), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index df2a312ca6c9..339b897146af 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -834,6 &#43;834,7 @@ static int smu7_odn_initial_default_setting(struct =
pp_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_vo=
ltage_dependency_table *dep_sclk_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_clock_vo=
ltage_dependency_table *dep_mclk_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_odn_performance_level =
*entries;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_info =3D=3D NULL=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -843,11 &#43;844,11 @@ static int smu7_odn_initial_default_setting(struc=
t pp_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_table-&gt;odn_core_clo=
ck_dpm_levels.num_of_pl =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;go=
lden_dpm_table.sclk_table.count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entries =3D odn_table-&gt;odn_cor=
e_clock_dpm_levels.entries;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;=
golden_dpm_table.sclk_table.count; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; odn_table-&gt;odn_core_clock_dpm_levels.entries[i].clock =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; data-&gt;golden_dpm_table.sclk_table.dpm_levels[i].value;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; odn_table-&gt;odn_core_clock_dpm_levels.entries[i].enabled =3D t=
rue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; odn_table-&gt;odn_core_clock_dpm_levels.entries[i].vddc =3D dep_=
sclk_table-&gt;entries[i].vddc;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; entries[i].clock =3D data-&gt;golden_dpm_table.sclk_table.dp=
m_levels[i].value;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; entries[i].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; entries[i].vddc =3D dep_sclk_table-&gt;entries[i].vddc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_get_voltage_dependenc=
y_table(dep_sclk_table,<br>
@@ -855,11 &#43;856,11 @@ static int smu7_odn_initial_default_setting(struc=
t pp_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_table-&gt;odn_memory_c=
lock_dpm_levels.num_of_pl =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;go=
lden_dpm_table.mclk_table.count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;golden_dpm_=
table.sclk_table.count; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].clock =3D<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; data-&gt;golden_dpm_table.mclk_table.dpm_levels[i].value;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].enabled =3D=
 true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; odn_table-&gt;odn_memory_clock_dpm_levels.entries[i].vddc =3D de=
p_mclk_table-&gt;entries[i].vddc;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entries =3D odn_table-&gt;odn_mem=
ory_clock_dpm_levels.entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;data-&gt;golden_=
dpm_table.mclk_table.count; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; entries[i].clock =3D data-&gt;golden_dpm_table.mclk_table.dp=
m_levels[i].value;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; entries[i].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; entries[i].vddc =3D dep_mclk_table-&gt;entries[i].vddc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_get_voltage_dependenc=
y_table(dep_mclk_table,<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB168776DA4105C73E1C979C64FBA90CY4PR12MB1687namp_--

--===============2015286484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2015286484==--

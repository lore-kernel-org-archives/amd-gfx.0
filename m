From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value
Date: Tue, 20 Aug 2019 02:34:31 +0000
Message-ID: <MN2PR12MB32962BEFC242B2D7C5A2FECAA2AB0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190816060807.11922-1-evan.quan@amd.com>,
 <20190816060807.11922-3-evan.quan@amd.com>
 <MN2PR12MB3296E1EFA5B50EBA18CE1841A2AF0@MN2PR12MB3296.namprd12.prod.outlook.com>
 <MN2PR12MB3344896B119B12D504E130C8E4AF0@MN2PR12MB3344.namprd12.prod.outlook.com>,
 <MN2PR12MB33443B0D70F900195F611CD5E4AB0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1686471544=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB33443B0D70F900195F611CD5E4AB0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1686471544==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32962BEFC242B2D7C5A2FECAA2AB0MN2PR12MB3296namp_"

--_000_MN2PR12MB32962BEFC242B2D7C5A2FECAA2AB0MN2PR12MB3296namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, August 20, 2019 10:09 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value


Ping..



From: Quan, Evan
Sent: Friday, August 16, 2019 4:00 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value



Since smu_get_atom_data_table() was already used in smu_v11_0_get_vbios_boo=
tup_values(). We should get all our needed information at once.

Also, what smu_get_atom_data_table() does is to get the data table from vbi=
os. It=92s a time and resource cost job.

I do not think it=92s a good idea to call it again just to get some informa=
tion we should already know.



Regards,

Evan

From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, August 16, 2019 3:10 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value



i think we can use a function to retrieve this information without storing =
it separately.

likes:  ret =3D smu_get_atom_data_table(smu, index, &size, &frev, &crev,
                                      (uint8_t **)&header);

because these information is a generic information from atom_common_table_h=
eader.

and other function don't care it except in smu_v11_0_get_clk_info_from_vbio=
s.



Best Regards,
Kevin

________________________________

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:e=
van.quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, August 16, 2019 2:08 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value



This is available with firmwareinfo table v3.2 or later.

Change-Id: I223edf3c616b9e3e2527c752214fef5ab53d1cea
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
---
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index ca9b9ec39de8..2c16eb412954 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -222,6 +222,9 @@ struct smu_bios_boot_up_values
         uint16_t                        vdd_gfx;
         uint8_t                         cooling_id;
         uint32_t                        pp_table_id;
+       uint32_t                        format_revision;
+       uint32_t                        content_revision;
+       uint32_t                        fclk;
 };

 enum smu_table_id
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 4a51de4ff162..df7b65360ac7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -568,6 +568,9 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_contex=
t *smu)
                 smu->smu_table.boot_values.pp_table_id =3D v_3_3->pplib_pp=
table_id;
         }

+       smu->smu_table.boot_values.format_revision =3D header->format_revis=
ion;
+       smu->smu_table.boot_values.content_revision =3D header->content_rev=
ision;
+
         return 0;
 }

@@ -647,6 +650,24 @@ static int smu_v11_0_get_clk_info_from_vbios(struct sm=
u_context *smu)
         output =3D (struct atom_get_smu_clock_info_output_parameters_v3_1 =
*)&input;
         smu->smu_table.boot_values.dclk =3D le32_to_cpu(output->atom_smu_o=
utputclkfreq.smu_clock_freq_hz) / 10000;

+       if ((smu->smu_table.boot_values.format_revision =3D=3D 3) &&
+           (smu->smu_table.boot_values.content_revision >=3D 2)) {
+               memset(&input, 0, sizeof(input));
+               input.clk_id =3D SMU11_SYSPLL1_0_FCLK_ID;
+               input.syspll_id =3D SMU11_SYSPLL1_2_ID;
+               input.command =3D GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
+               index =3D get_index_into_master_table(atom_master_list_of_c=
ommand_functions_v2_1,
+                                                   getsmuclockinfo);
+
+               ret =3D amdgpu_atom_execute_table(adev->mode_info.atom_cont=
ext, index,
+                                               (uint32_t *)&input);
+               if (ret)
+                       return -EINVAL;
+
+               output =3D (struct atom_get_smu_clock_info_output_parameter=
s_v3_1 *)&input;
+               smu->smu_table.boot_values.fclk =3D le32_to_cpu(output->ato=
m_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+       }
+
         return 0;
 }

--
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB32962BEFC242B2D7C5A2FECAA2AB0MN2PR12MB3296namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, August 20, 2019 10:09 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value</f=
ont>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:SimSun}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.25in 1.0in 1.25in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Ping..</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Quan, Evan <br>
<b>Sent:</b> Friday, August 16, 2019 4:00 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value</p=
>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Since smu_get_atom_data_table() was already used i=
n smu_v11_0_get_vbios_bootup_values(). We should get all our needed informa=
tion at once.</p>
<p class=3D"x_MsoNormal">Also, what smu_get_atom_data_table() does is to ge=
t the data table from vbios. It=92s a time and resource cost job.</p>
<p class=3D"x_MsoNormal">I do not think it=92s a good idea to call it again=
 just to get some information we should already know.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Evan</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;<a href=3D"mail=
to:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Friday, August 16, 2019 3:10 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH 3/4] drm/amd/powerplay: get bootup fclk value</p=
>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">i th=
ink we can use a function to retrieve this information without storing it s=
eparately.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">like=
s:&nbsp;<i>&nbsp;ret =3D smu_get_atom_data_table(smu, index, &amp;size, &am=
p;frev, &amp;crev,&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (uint8_t **)&amp;=
header);&nbsp;&nbsp;</i></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">beca=
use these information is a generic information from atom_common_table_heade=
r.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">and =
other function don't care it except in&nbsp;smu_v11_0_get_clk_info_from_vbi=
os.</span></p>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Best=
 Regards,<br>
Kevin</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lis=
ts.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf=
 of Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan-5C7GfCeVMHo@public.gmane.org</a=
>&gt;<br>
<b>Sent:</b> Friday, August 16, 2019 2:08 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;<br>
<b>Subject:</b> [PATCH 3/4] drm/amd/powerplay: get bootup fclk value</span>=
 </p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">This is available with firmwareinfo table v3.2 or =
later.<br>
<br>
Change-Id: I223edf3c616b9e3e2527c752214fef5ab53d1cea<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 2=
1 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 24 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index ca9b9ec39de8..2c16eb412954 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -222,6 &#43;222,9 @@ struct smu_bios_boot_up_values<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdd_gfx;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cooling_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; format_revision;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; content_revision;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fclk;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum smu_table_id<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 4a51de4ff162..df7b65360ac7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -568,6 &#43;568,9 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_co=
ntext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id =3D v_3_3-&=
gt;pplib_pptable_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.for=
mat_revision =3D header-&gt;format_revision;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.con=
tent_revision =3D header-&gt;content_revision;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -647,6 &#43;650,24 @@ static int smu_v11_0_get_clk_info_from_vbios(struc=
t smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output =3D (struct atom_ge=
t_smu_clock_info_output_parameters_v3_1 *)&amp;input;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_val=
ues.dclk =3D le32_to_cpu(output-&gt;atom_smu_outputclkfreq.smu_clock_freq_h=
z) / 10000;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu-&gt;smu_table.boot_value=
s.format_revision =3D=3D 3) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-&gt;=
smu_table.boot_values.content_revision &gt;=3D 2)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; memset(&amp;input, 0, sizeof(input));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; input.clk_id =3D SMU11_SYSPLL1_0_FCLK_ID;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; input.syspll_id =3D SMU11_SYSPLL1_2_ID;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; input.command =3D GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; index =3D get_index_into_master_table(atom_master_list_of_co=
mmand_functions_v2_1,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; getsmuclockinfo);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D amdgpu_atom_execute_table(adev-&gt;mode_info.atom_co=
ntext, index,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)&amp;i=
nput);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINV=
AL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; output =3D (struct atom_get_smu_clock_info_output_parameters=
_v3_1 *)&amp;input;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.fclk =3D le32_to_cpu(output-&g=
t;atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.22.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB32962BEFC242B2D7C5A2FECAA2AB0MN2PR12MB3296namp_--

--===============1686471544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1686471544==--

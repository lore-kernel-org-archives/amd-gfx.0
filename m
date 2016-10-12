From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)
Date: Wed, 12 Oct 2016 15:39:43 +0000
Message-ID: <CY4PR12MB1768476CAA76C1F8BE2D429FF7DD0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20161009115808.12776-1-tom.stdenis@amd.com>
 <a2035199-429c-d377-b354-bf42148d3820@mailbox.org>
 <CY4PR12MB176836D549B404152F5A1040F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <942ca6f5-fb0b-5f6f-7a87-1ffd6335be5d@vodafone.de>
 <BN6PR12MB1764A6A7F768C662DC5866EBF7DA0@BN6PR12MB1764.namprd12.prod.outlook.com>,
 <d1a48843-4541-1f68-eac1-21821998b735@mailbox.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1618389737=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d1a48843-4541-1f68-eac1-21821998b735-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>, =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1618389737==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768476CAA76C1F8BE2D429FF7DD0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768476CAA76C1F8BE2D429FF7DD0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It comes from amdgpu_query_gpu_info_init()


        for (i =3D 0; i < (int)dev->info.num_shader_engines; i++) {
                unsigned instance =3D (i << AMDGPU_INFO_MMR_SE_INDEX_SHIFT)=
 |
                                    (AMDGPU_INFO_MMR_SH_INDEX_MASK <<
                                     AMDGPU_INFO_MMR_SH_INDEX_SHIFT);

                r =3D amdgpu_read_mm_registers(dev, 0x263d, 1, instance, 0,
                                             &dev->info.backend_disable[i])=
;

This effectively reads from 0/* where the kernel adds the instance of * so =
it's 0/*/*.  That line was last changed  by Alex

0936139536380 (Alex Deucher  2015-04-20 12:04:22 -0400 174)                =
                 (AMDGPU_INFO_MMR_SH_INDEX_MASK <<

I still don't get why this is a reason to hit pause on the patch(es) though=
.  They're root only, you can still not use * if you don't want to and furt=
hermore I'm already using the write debugfs content (to debug waveforms).

Tom


________________________________
From: Michel D=E4nzer <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
Sent: Tuesday, October 11, 2016 20:34
To: StDenis, Tom; Christian K=F6nig
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)

On 11/10/16 09:32 PM, StDenis, Tom wrote:
> It's used by the UMD though they read from 0/*/* when reading the
> RASTER_CONFIG registers (which may be a bug...)

We should probably clarify what userspace is trying to do there, and
whether the hardware actually does that.


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Graphics, Processors and Immersive VR Solutions | AMD <http://www.amd.com/>
www.amd.com
Explore a wide range of innovative next generation computing processors, gr=
aphics, and Immersive VR solutions by Advanced Micro Devices (AMD). Visit A=
MD.com now!



Libre software enthusiast             |             Mesa and X developer

--_000_CY4PR12MB1768476CAA76C1F8BE2D429FF7DD0CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>It comes from&nbsp;<span>amdgpu_query_gpu_info_init()</span></p>
<p><br>
</p>
<p></p>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp=
; &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; (int)dev-&gt;info.num_shader_en=
gines; i&#43;&#43;) {</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned instance =3D (i=
 &lt;&lt; AMDGPU_INFO_MMR_SE_INDEX_SHIFT) |</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (</span><b><span style=3D"fon=
t-family: &quot;Courier New&quot;, monospace;">AMDGPU_INFO_MMR_SH_INDEX_MAS=
K</span></b><span style=3D"font-family: &quot;Courier New&quot;, monospace;=
"> &lt;&lt;</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMDGPU_INFO_MMR_SH_INDE=
X_SHIFT);</span></div>
<div><br>
</div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r =3D amdgpu_read_mm_reg=
isters(dev, 0x263d, 1, instance, 0,</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;&amp;dev-&gt;info.backend_disable[i]);</span></div>
<div><br>
</div>
<div>This effectively reads from 0/* where the kernel adds the instance of =
* so it's 0/*/*. &nbsp;That line was last changed &nbsp;by Alex</div>
<div><br>
</div>
<div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;"><b>0936139536380</b> (Alex Deucher &nbsp;2015-04-20 12:04:22 -0=
400 174) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (AMDGPU_INFO_MMR_SH_INDEX_MAS=
K &lt;&lt;</span></div>
</div>
<div><br>
</div>
<div>I still don't get why this is a reason to hit pause on the patch(es) t=
hough. &nbsp;They're root only, you can still not use * if you don't want t=
o and furthermore I'm already using the write debugfs content (to debug wav=
eforms). &nbsp;</div>
<div><br>
</div>
<div>Tom</div>
<p></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Michel D=E4nzer &lt=
;michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 11, 2016 20:34<br>
<b>To:</b> StDenis, Tom; Christian K=F6nig<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read=
 (v2)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 11/10/16 09:32 PM, StDenis, Tom wrote:<br>
&gt; It's used by the UMD though they read from 0/*/* when reading the<br>
&gt; RASTER_CONFIG registers (which may be a bug...)<br>
<br>
We should probably clarify what userspace is trying to do there, and<br>
whether the hardware actually does that.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
" id=3D"LPlnk115396" previewremoved=3D"true">
http://www.amd.com</a>
<div id=3D"LPBorder_GT_14762864460090.3072699807620518" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14762864460060.8831490190015878" cellspacing=3D"0"=
 style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relat=
ive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 2=
0px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted r=
gb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14762864460070.24216894343271722" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_14762864460070.8888817369809654"></div>
<div id=3D"LPTitle_14762864460070.3011910420489814" style=3D"top: 0px; colo=
r: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_14762864460080.3324236906153566" href=3D"http://www.am=
d.com/" target=3D"_blank" style=3D"text-decoration: none;">Graphics, Proces=
sors and Immersive VR Solutions | AMD
</a></div>
<div id=3D"LPMetadata_14762864460080.08593046515590075" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
www.amd.com</div>
<div id=3D"LPDescription_14762864460080.9804859375779311" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Explore a wide range of innovative next generation computing processors, gr=
aphics, and Immersive VR solutions by Advanced Micro Devices (AMD). Visit A=
MD.com now!</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768476CAA76C1F8BE2D429FF7DD0CY4PR12MB1768namp_--

--===============1618389737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1618389737==--

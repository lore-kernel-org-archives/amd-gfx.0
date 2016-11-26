From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amdgpu support for Polaris11, Radeon Pro 400 series graphics
Date: Sat, 26 Nov 2016 00:02:43 +0000
Message-ID: <CY4PR12MB176823BA821AF6B716F97566F7880@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <CALTeituzRvVW6CNeQJJEHg8_yicB0Jq3EXN3EkD0iauKdaMNmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0076943506=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CALTeituzRvVW6CNeQJJEHg8_yicB0Jq3EXN3EkD0iauKdaMNmg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bernhard Froemel <bfroemel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0076943506==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB176823BA821AF6B716F97566F7880CY4PR12MB1768namp_"

--_000_CY4PR12MB176823BA821AF6B716F97566F7880CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

if PP is being sketchy can you force the performance to low (e.g. manual) i=
nstead of auto and see if keeping at lower clocks helps keep it stable?


Just an idea to try.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Bernhard=
 Froemel <bfroemel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, November 25, 2016 11:15
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: amdgpu support for Polaris11, Radeon Pro 400 series graphics

Hi everyone,

I'd very much appreciate any help to get the open source amdgpu driver work=
ing
for the Radeon Pro 460 [1] found in the recently released
Apple MacBook Pro, Late 2016, 15" (model: MacBookPro13,3).
Note that the Radeon Pro is part of a hybrid graphics setup, paired with an
Intel HD Graphics 530 and an Apple GMUX device. By default/after a system r=
eboot
the GMUX connect the AMD GPU to the available displays. Consequently, the
hybrid setup should not cause any additional issues. For example, the Intel=
 GPU
seems to be not powered, because it is not even enumerated.

lspci tells me:
> 01:00.0 VGA compatible controller: Advanced Micro Devices,
> Inc. [AMD/ATI] Baffin [Radeon RX 460] (rev c0) (prog-if 00 [VGA controlle=
r])
> Subsystem: Apple Inc. Baffin [Radeon RX 460]

The amdgpu driver in linux-4.9-rc6 (+ polaris11 firmware from
the firmware-amd-graphics Debian package) detects the card, but the system
crashes in the later stages of probing/initializing the driver (see attache=
d
dmesg_gpuamd2.txt).

Indeed it seems that there is a divison by zero encountered in:
drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c:1918

> t_diff1 =3D hwmgr->thermal_controller.advanceFanControlParameters.usTMed =
-
> hwmgr->thermal_controller.advanceFanControlParameters.usTMin;
> t_diff2 =3D hwmgr->thermal_controller.advanceFanControlParameters.usTHigh=
 -
> hwmgr->thermal_controller.advanceFanControlParameters.usTMed;
.
.
> slope1 =3D (uint16_t)((50 + ((16 * duty100 * pwm_diff1) / t_diff1)) / 100=
);
> slope2 =3D (uint16_t)((50 + ((16 * duty100 * pwm_diff2) / t_diff2)) / 100=
);

t_diff1 and t_diff2 are zero; probably because active cooling by fans
is realized
quite differently in this embedded/laptop version of the graphics card.

When commenting this simply out, the driver loads and I can run an X
server .. for a while; even glxgears as well as glxinfo seem to run fine.
However after some time or possibly after certain actions (e.g., on one occ=
asion
when I set a terminal window to full-screen) the screen blanks out and the
system becomes sometimes completely unresponsive.

On one of  the more partial system crashes I could still read dmesg
(see attached
dmesg_gpuamd3.txt also detailing the log messages before):
> [  273.877708]
>                 failed to send message 5e ret is 0
> [  286.343630]
>                 failed to send message 5e ret is 0
> [  906.960345] amdgpu 0000:01:00.0: GPU fault detected: 146 0x04121014
> [  906.960348] amdgpu 0000:01:00.0:
> VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010CE82
> [  906.960349] amdgpu 0000:01:00.0:
> VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D010014
> [  906.960350] VM fault (0x14, vmid 6) at page 1101442, write from
>  'CB3' (0x43423300) (16)

Again, any help/advice/pointers highly appreciated!

Greetings,
  Bernhard

[1] http://www.amd.com/en-us/press-releases/Pages/radeon-pro-400-2016oct27.=
aspx
[http://www.amd.com/Style%20Library/Images/logo.png]<http://www.amd.com/en-=
us/press-releases/Pages/radeon-pro-400-2016oct27.aspx>

Radeon Pro 400 Series Graphics: AMD's Most Powerful ...<http://www.amd.com/=
en-us/press-releases/Pages/radeon-pro-400-2016oct27.aspx>
www.amd.com
Today AMD (NASDAQ: AMD) unveiled a new family of power-efficient graphics p=
rocessors, Radeon(tm) Pro 400 Series Graphics. Available first in the all-n=
ew 15-inch ...




--_000_CY4PR12MB176823BA821AF6B716F97566F7880CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>if PP is being sketchy can you force the performance to low (e.g. manual=
) instead of auto and see if keeping at lower clocks helps keep it stable?<=
/p>
<p><br>
</p>
<p>Just an idea to try.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Bernhard Froemel &lt;bfroem=
el-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 25, 2016 11:15<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> amdgpu support for Polaris11, Radeon Pro 400 series graphic=
s</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi everyone,<br>
<br>
I'd very much appreciate any help to get the open source amdgpu driver work=
ing<br>
for the Radeon Pro 460 [1] found in the recently released<br>
Apple MacBook Pro, Late 2016, 15&quot; (model: MacBookPro13,3).<br>
Note that the Radeon Pro is part of a hybrid graphics setup, paired with an=
<br>
Intel HD Graphics 530 and an Apple GMUX device. By default/after a system r=
eboot<br>
the GMUX connect the AMD GPU to the available displays. Consequently, the<b=
r>
hybrid setup should not cause any additional issues. For example, the Intel=
 GPU<br>
seems to be not powered, because it is not even enumerated.<br>
<br>
lspci tells me:<br>
&gt; 01:00.0 VGA compatible controller: Advanced Micro Devices,<br>
&gt; Inc. [AMD/ATI] Baffin [Radeon RX 460] (rev c0) (prog-if 00 [VGA contro=
ller])<br>
&gt; Subsystem: Apple Inc. Baffin [Radeon RX 460]<br>
<br>
The amdgpu driver in linux-4.9-rc6 (&#43; polaris11 firmware from<br>
the firmware-amd-graphics Debian package) detects the card, but the system<=
br>
crashes in the later stages of probing/initializing the driver (see attache=
d<br>
dmesg_gpuamd2.txt).<br>
<br>
Indeed it seems that there is a divison by zero encountered in:<br>
drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c:1918<br>
<br>
&gt; t_diff1 =3D hwmgr-&gt;thermal_controller.advanceFanControlParameters.u=
sTMed -<br>
&gt; hwmgr-&gt;thermal_controller.advanceFanControlParameters.usTMin;<br>
&gt; t_diff2 =3D hwmgr-&gt;thermal_controller.advanceFanControlParameters.u=
sTHigh -<br>
&gt; hwmgr-&gt;thermal_controller.advanceFanControlParameters.usTMed;<br>
.<br>
.<br>
&gt; slope1 =3D (uint16_t)((50 &#43; ((16 * duty100 * pwm_diff1) / t_diff1)=
) / 100);<br>
&gt; slope2 =3D (uint16_t)((50 &#43; ((16 * duty100 * pwm_diff2) / t_diff2)=
) / 100);<br>
<br>
t_diff1 and t_diff2 are zero; probably because active cooling by fans<br>
is realized<br>
quite differently in this embedded/laptop version of the graphics card.<br>
<br>
When commenting this simply out, the driver loads and I can run an X<br>
server .. for a while; even glxgears as well as glxinfo seem to run fine.<b=
r>
However after some time or possibly after certain actions (e.g., on one occ=
asion<br>
when I set a terminal window to full-screen) the screen blanks out and the<=
br>
system becomes sometimes completely unresponsive.<br>
<br>
On one of&nbsp; the more partial system crashes I could still read dmesg<br=
>
(see attached<br>
dmesg_gpuamd3.txt also detailing the log messages before):<br>
&gt; [&nbsp; 273.877708]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; failed to send message 5e ret is 0<br>
&gt; [&nbsp; 286.343630]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; failed to send message 5e ret is 0<br>
&gt; [&nbsp; 906.960345] amdgpu 0000:01:00.0: GPU fault detected: 146 0x041=
21014<br>
&gt; [&nbsp; 906.960348] amdgpu 0000:01:00.0:<br>
&gt; VM_CONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x0010CE82<br>
&gt; [&nbsp; 906.960349] amdgpu 0000:01:00.0:<br>
&gt; VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D010014<br>
&gt; [&nbsp; 906.960350] VM fault (0x14, vmid 6) at page 1101442, write fro=
m<br>
&gt;&nbsp; 'CB3' (0x43423300) (16)<br>
<br>
Again, any help/advice/pointers highly appreciated!<br>
<br>
Greetings,<br>
&nbsp; Bernhard<br>
<br>
[1] <a href=3D"http://www.amd.com/en-us/press-releases/Pages/radeon-pro-400=
-2016oct27.aspx" id=3D"LPlnk475851" previewremoved=3D"true">
http://www.amd.com/en-us/press-releases/Pages/radeon-pro-400-2016oct27.aspx=
</a>
<div id=3D"LPBorder_GT_14801185288400.7274598424829852" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14801185288360.03182244988533389" cellspacing=3D"0=
" style=3D"width: 90%; background-color: rgb(255, 255, 255); position: rela=
tive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: =
20px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted =
rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"ImageCell_14801185288370.7028237433065467" colspan=3D"1" style=3D=
"width: 250px; position: relative; display: table-cell; padding-right: 20px=
;">
<div id=3D"LPImageContainer_14801185288370.5936617779712585" style=3D"backg=
round-color: rgb(255, 255, 255); height: 31px; position: relative; margin: =
auto; display: table; width: 132px;">
<a id=3D"LPImageAnchor_14801185288380.5263715534287636" href=3D"http://www.=
amd.com/en-us/press-releases/Pages/radeon-pro-400-2016oct27.aspx" target=3D=
"_blank" style=3D"display: table-cell; text-align: center;"><img aria-label=
=3D"Preview image with link selected. Double-tap to open the link." id=3D"L=
PThumbnailImageID_14801185288380.7741710346619015" width=3D"132" height=3D"=
31" style=3D"display: inline-block; max-width: 250px; max-height: 250px; he=
ight: 31px; width: 132px; border-width: 0px; vertical-align: bottom;" src=
=3D"http://www.amd.com/Style%20Library/Images/logo.png"></a></div>
</td>
<td id=3D"TextCell_14801185288380.4250686413743503" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14801185288390.5516152344627225"></div>
<div id=3D"LPTitle_14801185288390.01040088545382778" style=3D"top: 0px; col=
or: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_14801185288390.8401743603255296" href=3D"http://www.am=
d.com/en-us/press-releases/Pages/radeon-pro-400-2016oct27.aspx" target=3D"_=
blank" style=3D"text-decoration: none;">Radeon Pro 400 Series Graphics: AMD=
's Most Powerful ...</a></div>
<div id=3D"LPMetadata_14801185288390.3738006553203834" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
www.amd.com</div>
<div id=3D"LPDescription_14801185288400.07619442755776373" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
 hidden;">
Today AMD (NASDAQ: AMD) unveiled a new family of power-efficient graphics p=
rocessors, Radeon&#8482; Pro 400 Series Graphics. Available first in the al=
l-new 15-inch ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB176823BA821AF6B716F97566F7880CY4PR12MB1768namp_--

--===============0076943506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0076943506==--

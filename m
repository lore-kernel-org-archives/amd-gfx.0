From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)
Date: Wed, 19 Oct 2016 10:40:40 +0000
Message-ID: <BN6PR12MB1764ECA0166D38F1FDD2E624F7D20@BN6PR12MB1764.namprd12.prod.outlook.com>
References: <20161009115808.12776-1-tom.stdenis@amd.com>
 <a2035199-429c-d377-b354-bf42148d3820@mailbox.org>
 <CY4PR12MB176836D549B404152F5A1040F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <942ca6f5-fb0b-5f6f-7a87-1ffd6335be5d@vodafone.de>
 <BN6PR12MB1764A6A7F768C662DC5866EBF7DA0@BN6PR12MB1764.namprd12.prod.outlook.com>
 <d1a48843-4541-1f68-eac1-21821998b735@mailbox.org>
 <CY4PR12MB1768476CAA76C1F8BE2D429FF7DD0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <9625361e-271c-ed34-d92a-0ea1ca0ca7a1@daenzer.net>,
 <dbf837f3-d9e6-a618-bd78-54f17c7b7d2c@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0356009502=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dbf837f3-d9e6-a618-bd78-54f17c7b7d2c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0356009502==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1764ECA0166D38F1FDD2E624F7D20BN6PR12MB1764namp_"

--_000_BN6PR12MB1764ECA0166D38F1FDD2E624F7D20BN6PR12MB1764namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The broadcast read was required to attempt to debug a pro-stack problem whi=
ch I believe the "cache gca config" patches are meant to mitigate.  The bro=
adcast write support is required to select CUs for wave readings.  libdrm p=
erforms a broadcast read when reading raster config data so apparently that=
's a thing.

Since it's a debugfs interface any stability problems a broadcast read may =
or may not cause isn't really a concern for day to day operations.  FWIW I'=
ve never yet seen an issue with broadcast reading raster config registers.

But to put it simply, the patch was part of a series that was blocking othe=
r work and there wasn't sufficient cause to NAK it.

Tom

________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Tuesday, October 18, 2016 23:49
To: StDenis, Tom; Christian K=F6nig
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)

On 13/10/16 04:20 PM, Michel D=E4nzer wrote:
> On 13/10/16 12:39 AM, StDenis, Tom wrote:
>> It comes from amdgpu_query_gpu_info_init()
>>
>>
>>         for (i =3D 0; i < (int)dev->info.num_shader_engines; i++) {
>>                 unsigned instance =3D (i << AMDGPU_INFO_MMR_SE_INDEX_SHI=
FT) |
>>                                     (*AMDGPU_INFO_MMR_SH_INDEX_MASK*<<
>>                                      AMDGPU_INFO_MMR_SH_INDEX_SHIFT);
>>
>>                 r =3D amdgpu_read_mm_registers(dev, 0x263d, 1, instance,=
 0,
>>                                              &dev->info.backend_disable[=
i]);
>>
>> This effectively reads from 0/* where the kernel adds the instance of *
>> so it's 0/*/*.  That line was last changed  by Alex
>>
>> *0936139536380* (Alex Deucher  2015-04-20 12:04:22 -0400 174)
>>                       (AMDGPU_INFO_MMR_SH_INDEX_MASK <<
>
> As a side note, following that to the end in the kernel code, I noticed
> an interesting minor difference between the AMDGPU_INFO_READ_MMR_REG
> functionality used by this code and the debugfs interface:
>
> With AMDGPU_INFO_READ_MMR_REG, the effect is that
> amdgpu_asic_read_register() doesn't call amdgpu_gfx_select_se_sh() at
> all before reading the register, so the read is performed from whichever
> SH instance is currently selected.
>
> Whereas with this patch, amdgpu_debugfs_regs_read() calls
> amdgpu_gfx_select_se_sh(adev, se_bank, 0xFFFFFFFF, instance_bank) before
> the register read, which translates to only the SH_BROADCAST_WRITES bit
> being set for the SH instance index.
>
> The end result should be the same though, since
> amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff) is
> normally called after every register read.
>
>
>> I still don't get why this is a reason to hit pause on the patch(es)
>> though.
>
> At the very least, it should be documented in an appropriate place
> (commit log and/or code, or any other place where the debugfs interface
> semantics are documented) what actually happens when passing all ones
> for the SE/SH index. Does the hardware ignore the *_BROADCAST_WRITES bit
> for reads, so they're performed from instance 0, or does it combine the
> values from all instances with logical and/or?

I'm not sure how to interpret the fact that this patch has landed
without any changes or followups.

FWIW, I'm still interested in (pointers to) information about what the
libdrm_amdgpu code above expects and what the hardware does for reads
with the broadcast bit enabled, from anyone.


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Graphics, Processors and Immersive VR Solutions | AMD <http://www.amd.com/>
www.amd.com
Explore a wide range of innovative next generation computing processors, gr=
aphics, and Immersive VR solutions by Advanced Micro Devices (AMD). Visit A=
MD.com now!



Libre software enthusiast             |             Mesa and X developer

--_000_BN6PR12MB1764ECA0166D38F1FDD2E624F7D20BN6PR12MB1764namp_
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
<p>The broadcast read was required to attempt to debug a pro-stack problem =
which I believe the &quot;cache gca config&quot; patches are meant to mitig=
ate. &nbsp;The broadcast write support is required to select CUs for wave r=
eadings. &nbsp;<span style=3D"font-size: 12pt;">libdrm
 performs a broadcast read when reading raster config data so apparently th=
at's a thing.</span></p>
<div><br>
</div>
Since it's a debugfs interface any stability problems a broadcast read may =
or may not cause isn't really a concern for day to day operations. &nbsp;FW=
IW I've never yet seen an issue with broadcast reading raster config&nbsp;r=
egisters.
<div><br>
</div>
<div>But to put it simply, the patch was part of a series that was blocking=
 other work and there wasn't sufficient cause to NAK it.</div>
<div><br>
</div>
<div>Tom<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Michel D=E4nzer &lt=
;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 18, 2016 23:49<br>
<b>To:</b> StDenis, Tom; Christian K=F6nig<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read=
 (v2)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 13/10/16 04:20 PM, Michel D=E4nzer wrote:<br>
&gt; On 13/10/16 12:39 AM, StDenis, Tom wrote:<br>
&gt;&gt; It comes from amdgpu_query_gpu_info_init()<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &l=
t; (int)dev-&gt;info.num_shader_engines; i&#43;&#43;) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned instance =3D (i &lt;&lt; AMDGPU_INFO=
_MMR_SE_INDEX_SHIFT) |<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(*AMDGPU_INFO_MMR_SH_INDEX_MASK*&lt;&lt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; AMDGPU_INFO_MMR_SH_INDEX_SHIFT);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_read_mm_registers(dev, 0x263d, 1=
, instance, 0,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev-&gt;info.bac=
kend_disable[i]);<br>
&gt;&gt;<br>
&gt;&gt; This effectively reads from 0/* where the kernel adds the instance=
 of *<br>
&gt;&gt; so it's 0/*/*.&nbsp; That line was last changed&nbsp; by Alex<br>
&gt;&gt;<br>
&gt;&gt; *0936139536380* (Alex Deucher&nbsp; 2015-04-20 12:04:22 -0400 174)=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (AMDGPU_I=
NFO_MMR_SH_INDEX_MASK &lt;&lt;<br>
&gt; <br>
&gt; As a side note, following that to the end in the kernel code, I notice=
d<br>
&gt; an interesting minor difference between the AMDGPU_INFO_READ_MMR_REG<b=
r>
&gt; functionality used by this code and the debugfs interface:<br>
&gt; <br>
&gt; With AMDGPU_INFO_READ_MMR_REG, the effect is that<br>
&gt; amdgpu_asic_read_register() doesn't call amdgpu_gfx_select_se_sh() at<=
br>
&gt; all before reading the register, so the read is performed from whichev=
er<br>
&gt; SH instance is currently selected.<br>
&gt; <br>
&gt; Whereas with this patch, amdgpu_debugfs_regs_read() calls<br>
&gt; amdgpu_gfx_select_se_sh(adev, se_bank, 0xFFFFFFFF, instance_bank) befo=
re<br>
&gt; the register read, which translates to only the SH_BROADCAST_WRITES bi=
t<br>
&gt; being set for the SH instance index.<br>
&gt; <br>
&gt; The end result should be the same though, since<br>
&gt; amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff) is<b=
r>
&gt; normally called after every register read.<br>
&gt; <br>
&gt; <br>
&gt;&gt; I still don't get why this is a reason to hit pause on the patch(e=
s)<br>
&gt;&gt; though.<br>
&gt; <br>
&gt; At the very least, it should be documented in an appropriate place<br>
&gt; (commit log and/or code, or any other place where the debugfs interfac=
e<br>
&gt; semantics are documented) what actually happens when passing all ones<=
br>
&gt; for the SE/SH index. Does the hardware ignore the *_BROADCAST_WRITES b=
it<br>
&gt; for reads, so they're performed from instance 0, or does it combine th=
e<br>
&gt; values from all instances with logical and/or?<br>
<br>
I'm not sure how to interpret the fact that this patch has landed<br>
without any changes or followups.<br>
<br>
FWIW, I'm still interested in (pointers to) information about what the<br>
libdrm_amdgpu code above expects and what the hardware does for reads<br>
with the broadcast bit enabled, from anyone.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
" id=3D"LPlnk758282" previewremoved=3D"true">
http://www.amd.com</a>
<div id=3D"LPBorder_GT_14768734048770.8775835774995799" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14768734048740.6196712470071157" cellspacing=3D"0"=
 style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relat=
ive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 2=
0px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted r=
gb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14768734048750.8107831176369602" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14768734048760.36270012816875474"></div=
>
<div id=3D"LPTitle_14768734048760.2595286131757666" style=3D"top: 0px; colo=
r: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_14768734048760.7459485059600515" href=3D"http://www.am=
d.com/" target=3D"_blank" style=3D"text-decoration: none;">Graphics, Proces=
sors and Immersive VR Solutions | AMD
</a></div>
<div id=3D"LPMetadata_14768734048760.8916323305065981" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
www.amd.com</div>
<div id=3D"LPDescription_14768734048760.8199608896286328" style=3D"display:=
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
</div>
</body>
</html>

--_000_BN6PR12MB1764ECA0166D38F1FDD2E624F7D20BN6PR12MB1764namp_--

--===============0356009502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0356009502==--

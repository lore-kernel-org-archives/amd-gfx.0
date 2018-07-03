From: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Subject: Re: SOC15 DC support warning
Date: Tue, 3 Jul 2018 16:50:43 +0000
Message-ID: <MWHPR1201MB0142F6762AE620EAA7209447E8420@MWHPR1201MB0142.namprd12.prod.outlook.com>
References: <0334a673-faa5-916a-f62f-d1737d4dad5b@amd.com>
 <36e5a149-9e3b-f6f6-7450-698c6684b47d@amd.com>
 <682afa06-d2a8-7d72-dbbf-1c2cfaf5f842@daenzer.net>,
 <CADnq5_PcxD_1iNf2gnTcoZCasG+MauqvsrTWQkvWjaN=j7-o9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0431311775=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PcxD_1iNf2gnTcoZCasG+MauqvsrTWQkvWjaN=j7-o9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0431311775==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0142F6762AE620EAA7209447E8420MWHPR1201MB0142_"

--_000_MWHPR1201MB0142F6762AE620EAA7209447E8420MWHPR1201MB0142_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have seen a couple of reports that booting Raven desktop parts requires d=
isabling DC, although I'm not sure if that actually makes sense (I didn't t=
hink we implemented non-DC display paths for Vega/Raven).


Might be specific to people with a dGPU plugged in, I guess ?

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: July 3, 2018 12:45 PM
To: Michel D=E4nzer
Cc: StDenis, Tom; Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: SOC15 DC support warning

On Tue, Jul 3, 2018 at 12:36 PM, Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote=
:
> On 2018-07-03 06:13 PM, Felix Kuehling wrote:
>> On 2018-07-03 10:19 AM, Tom St Denis wrote:
>>> Hi all,
>>>
>>> This block
>>>
>>> #if defined(CONFIG_DRM_AMD_DC)
>>>         else if (amdgpu_device_has_dc_support(adev))
>>>             amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>> #else
>>> #    warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
>>> #endif
>>>
>>>
>>> in soc15_set_ip_blocks() should probably be ported to a runtime
>>> drm_warn() no?  This means a kernel with no DC support will just
>>> silently fail to light up on SOC15.
>>>
>>> I can write a patch for this if nobody objects.
>>
>> Maybe do both. So someone building a kernel without DC gets a warning as
>> well as someone running it.
>
> Yep, we already do both for CONFIG_MTRR & CONFIG_X86_PAT.
>
> BTW, the build warning should also be guarded by #ifndef
> CONFIG_COMPILE_TEST, per commit 31bb90f1cd084 "drm/amdgpu: shut up
> #warning for compile testing".
>
>
> OTOH, do we even need the capability to build the driver without DC anymo=
re?

Yeah, we can probably go ahead and remove CONFIG_DRM_AMD_DC.

Alex

>
>
> --
> Earthling Michel D=E4nzer               |               http://www.amd.co=
m
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MWHPR1201MB0142F6762AE620EAA7209447E8420MWHPR1201MB0142_
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
<p style=3D"margin-top:0;margin-bottom:0">I have seen a couple of reports t=
hat booting Raven desktop parts requires disabling DC, although I'm not sur=
e if that actually makes sense (I didn't think we implemented non-DC displa=
y paths for Vega/Raven).
<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Might be specific to people with =
a dGPU plugged in, I guess ?</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> July 3, 2018 12:45 PM<br>
<b>To:</b> Michel D=E4nzer<br>
<b>Cc:</b> StDenis, Tom; Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: SOC15 DC support warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Jul 3, 2018 at 12:36 PM, Michel D=E4nzer &=
lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt; wrote:<br>
&gt; On 2018-07-03 06:13 PM, Felix Kuehling wrote:<br>
&gt;&gt; On 2018-07-03 10:19 AM, Tom St Denis wrote:<br>
&gt;&gt;&gt; Hi all,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This block<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; #if defined(CONFIG_DRM_AMD_DC)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgp=
u_device_has_dc_support(adev))<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;dm_ip_block);<br>
&gt;&gt;&gt; #else<br>
&gt;&gt;&gt; #&nbsp;&nbsp;&nbsp; warning &quot;Enable CONFIG_DRM_AMD_DC for=
 display support on SOC15.&quot;<br>
&gt;&gt;&gt; #endif<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; in soc15_set_ip_blocks() should probably be ported to a runtim=
e<br>
&gt;&gt;&gt; drm_warn() no?&nbsp; This means a kernel with no DC support wi=
ll just<br>
&gt;&gt;&gt; silently fail to light up on SOC15.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I can write a patch for this if nobody objects.<br>
&gt;&gt;<br>
&gt;&gt; Maybe do both. So someone building a kernel without DC gets a warn=
ing as<br>
&gt;&gt; well as someone running it.<br>
&gt;<br>
&gt; Yep, we already do both for CONFIG_MTRR &amp; CONFIG_X86_PAT.<br>
&gt;<br>
&gt; BTW, the build warning should also be guarded by #ifndef<br>
&gt; CONFIG_COMPILE_TEST, per commit 31bb90f1cd084 &quot;drm/amdgpu: shut u=
p<br>
&gt; #warning for compile testing&quot;.<br>
&gt;<br>
&gt;<br>
&gt; OTOH, do we even need the capability to build the driver without DC an=
ymore?<br>
<br>
Yeah, we can probably go ahead and remove CONFIG_DRM_AMD_DC.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.am=
d.com">
http://www.amd.com</a><br>
&gt; Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MWHPR1201MB0142F6762AE620EAA7209447E8420MWHPR1201MB0142_--

--===============0431311775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0431311775==--

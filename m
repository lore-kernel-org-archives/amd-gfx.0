From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Tue, 20 Mar 2018 20:04:49 +0000
Message-ID: <DM5PR12MB18205326885F0857CEC4FAA6F7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <f25ebe1d-0b19-e972-5eba-84570e625456@gmail.com>
 <BY1PR12MB05044A2A50F2580904C8AFB5F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
 <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
 <CAAxE2A7ffe2fkOQG0mFpPfP4uRKZ1BVTKWQ3Q+FhLWQnYU4nww@mail.gmail.com>,
 <f7bce36e-d9c6-dc13-6b1f-0e2bf91aaff0@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0577580339=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f7bce36e-d9c6-dc13-6b1f-0e2bf91aaff0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?Windows-1252?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

--===============0577580339==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18205326885F0857CEC4FAA6F7AB0DM5PR12MB1820namp_"

--_000_DM5PR12MB18205326885F0857CEC4FAA6F7AB0DM5PR12MB1820namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I think we can also have the case of systems with similar amounts of carve =
out and system ram.  E.g., on a system with 4 GB of system memory with 1 GB=
 carved out for vram.  It would be a big waste not to use VRAM.  We'll prob=
ably need a heuristic at some point.


Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, March 20, 2018 2:32:49 PM
To: Marek Ol=9A=E1k; Koenig, Christian
Cc: Alex Deucher; Deucher, Alexander; Michel D=E4nzer; Li, Samuel; amd-gfx =
list
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support

I don't think that is a good idea.

Ideally GTT should now have the same performance as VRAM on APUs and we sho=
uld use VRAM only for things where we absolutely have to and to actually us=
e up the otherwise unused VRAM.

Can you run some tests with all BOs forced to GTT and see if there is any p=
erformance regression?

Christian.

Am 20.03.2018 um 15:51 schrieb Marek Ol=9A=E1k:
On Tue, Mar 20, 2018 at 9:55 AM, Christian K=F6nig <ckoenig.leichtzumerken@=
gmail.com<mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
Yes, exactly. And if I remember correctly Mesa used to always set GTT as fa=
llback on APUs, correct?

"used to" is the key part. Mesa doesn't force GTT on APUs anymore. It expec=
ts that the combination of BO priorities and BO move throttling will result=
 in optimal BO placements over time.

Marek


The problem seems to be that this fallback isn't set for displayable BOs.

So what needs to be done is to just enable this fallback for displayable BO=
s as well if the kernel can handle it.

Christian.


Am 20.03.2018 um 00:01 schrieb Marek Ol=9A=E1k:
In theory, Mesa doesn't have to do anything. It can continue setting VRAM a=
nd if the kernel has to put a display buffer into GTT, it doesn't matter (f=
or Mesa). Whether the VRAM placement is really used is largely determined b=
y BO priorities.

The way I understand scather/gather is that it only allows the GTT placemen=
t. It doesn't force the GTT placement. Mesa also doesn't force the GTT plac=
ement.

Marek

On Mon, Mar 19, 2018 at 5:12 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto=
:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org<mailto:Samue=
l.Li-5C7GfCeVMHo@public.gmane.org>> wrote:
>>to my earlier point, there may be cases where it is advantageous to put
>> display buffers in vram even if s/g display is supported
>
> Agreed. That is also why the patch has the options to let user select whe=
re
> to put display buffers.
>
> As whether to put the option in Mesa or kernel, it seems the difference i=
s
> not much. Also, since amdgpufb can request even without mesa, kernel migh=
t
> be a better choice. In addition, putting in the kernel can save client=92=
s
> duplicate work(mesa, ogl, vulkan, 2d, kernel=85)

Why do we even expose different memory pools to the UMDs in the first
place ;)  Each pool has performance characteristics that may be
relevant for a particular work load.  Only the UMDs really know the
finer points of those workloads. In general, you don't want the kernel
dictating policy if you can avoid it.  The kernel exposes
functionality and userspace sets the policy.  With the location set in
userspace, each app/user can have whatever policy makes sense for
their use case all at the same time without needing to tweak their
kernel for every use case.

Alex



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx






_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_DM5PR12MB18205326885F0857CEC4FAA6F7AB0DM5PR12MB1820namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I think we can also have the case=
 of systems with similar amounts of carve out and system ram.&nbsp; E.g., o=
n a system with 4 GB of system memory with 1 GB carved out for vram.&nbsp; =
It would be a big waste not to use VRAM.&nbsp; We'll
 probably need a heuristic at some point.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, March 20, 2018 2:32:49 PM<br>
<b>To:</b> Marek Ol=9A=E1k; Koenig, Christian<br>
<b>Cc:</b> Alex Deucher; Deucher, Alexander; Michel D=E4nzer; Li, Samuel; a=
md-gfx list<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">I don't think that is a good idea.<br>
<br>
Ideally GTT should now have the same performance as VRAM on APUs and we sho=
uld use VRAM only for things where we absolutely have to and to actually us=
e up the otherwise unused VRAM.<br>
<br>
Can you run some tests with all BOs forced to GTT and see if there is any p=
erformance regression?<br>
<br>
Christian.<br>
<br>
Am 20.03.2018 um 15:51 schrieb Marek Ol=9A=E1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div class=3D"x_gmail_extra">
<div class=3D"x_gmail_quote">On Tue, Mar 20, 2018 at 9:55 AM, Christian K=
=F6nig <span dir=3D"ltr">
&lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">c=
koenig.leichtzumerken@gmail.<wbr>com</a>&gt;</span> wrote:<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0
              .8ex; border-left:1px #ccc solid; padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"x_m_-3838486020630618689m_8572536124089128592moz-cite-prefix"=
>Yes, exactly. And if I remember correctly Mesa used to always set GTT as f=
allback on APUs, correct?<br>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>&quot;used to&quot; is the key part. Mesa doesn't force GTT on APUs an=
ymore. It expects that the combination of BO priorities and BO move throttl=
ing will result in optimal BO placements over time.<br>
<br>
</div>
<div>Marek<br>
</div>
<div>&nbsp;</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0
              .8ex; border-left:1px #ccc solid; padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"x_m_-3838486020630618689m_8572536124089128592moz-cite-prefix"=
><br>
The problem seems to be that this fallback isn't set for displayable BOs.<b=
r>
<br>
So what needs to be done is to just enable this fallback for displayable BO=
s as well if the kernel can handle it.<span class=3D"x_m_-38384860206306186=
89HOEnZb"><font color=3D"#888888"><br>
<br>
Christian.</font></span>
<div>
<div class=3D"x_m_-3838486020630618689h5"><br>
<br>
Am 20.03.2018 um 00:01 schrieb Marek Ol=9A=E1k:<br>
</div>
</div>
</div>
<blockquote type=3D"cite">
<div>
<div class=3D"x_m_-3838486020630618689h5">
<div dir=3D"ltr">
<div class=3D"x_gmail_extra">
<div class=3D"x_gmail_quote">In theory, Mesa doesn't have to do anything. I=
t can continue setting VRAM and if the kernel has to put a display buffer i=
nto GTT, it doesn't matter (for Mesa). Whether the VRAM placement is really=
 used is largely determined by BO
 priorities.<br>
</div>
<div class=3D"x_gmail_quote"><br>
</div>
<div class=3D"x_gmail_quote">The way I understand scather/gather is that it=
 only allows the GTT placement. It doesn't force the GTT placement. Mesa al=
so doesn't force the GTT placement.<br>
</div>
<div class=3D"x_gmail_quote"><br>
</div>
<div class=3D"x_gmail_quote">Marek<br>
</div>
<div class=3D"x_gmail_quote"><br>
</div>
<div class=3D"x_gmail_quote">On Mon, Mar 19, 2018 at 5:12 PM, Alex Deucher =
<span dir=3D"ltr">
&lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher@=
gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px
                              #ccc solid; padding-left:1ex">
<span>On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel &lt;<a href=3D"mailto:Sam=
uel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;to my earlier point, there may be cases where it is advantageous to=
 put<br>
&gt;&gt; display buffers in vram even if s/g display is supported<br>
&gt;<br>
&gt; Agreed. That is also why the patch has the options to let user select =
where<br>
&gt; to put display buffers.<br>
&gt;<br>
&gt; As whether to put the option in Mesa or kernel, it seems the differenc=
e is<br>
&gt; not much. Also, since amdgpufb can request even without mesa, kernel m=
ight<br>
&gt; be a better choice. In addition, putting in the kernel can save client=
=92s<br>
&gt; duplicate work(mesa, ogl, vulkan, 2d, kernel=85)<br>
<br>
</span>Why do we even expose different memory pools to the UMDs in the firs=
t<br>
place ;)&nbsp; Each pool has performance characteristics that may be<br>
relevant for a particular work load.&nbsp; Only the UMDs really know the<br=
>
finer points of those workloads. In general, you don't want the kernel<br>
dictating policy if you can avoid it.&nbsp; The kernel exposes<br>
functionality and userspace sets the policy.&nbsp; With the location set in=
<br>
userspace, each app/user can have whatever policy makes sense for<br>
their use case all at the same time without needing to tweak their<br>
kernel for every use case.<br>
<span class=3D"x_m_-3838486020630618689m_8572536124089128592m_4947926278827=
078055HOEnZb"><font color=3D"#888888"><br>
Alex</font></span><br>
</blockquote>
</div>
</div>
</div>
<br>
<fieldset class=3D"x_m_-3838486020630618689m_8572536124089128592mimeAttachm=
entHeader">
</fieldset> <br>
</div>
</div>
<span>
<pre>______________________________<wbr>_________________
amd-gfx mailing list
<a class=3D"x_m_-3838486020630618689m_8572536124089128592moz-txt-link-abbre=
viated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"x_m_-3838486020630618689m_8572536124089128592moz-txt-link-freet=
ext" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
</span></blockquote>
<br>
</div>
</blockquote>
</div>
<br>
</div>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/am=
d-gfx</a>
</pre>
</blockquote>
<br>
</div>
</body>
</html>

--_000_DM5PR12MB18205326885F0857CEC4FAA6F7AB0DM5PR12MB1820namp_--

--===============0577580339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0577580339==--

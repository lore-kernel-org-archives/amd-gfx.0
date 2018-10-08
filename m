From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC
Date: Mon, 8 Oct 2018 15:47:37 +0000
Message-ID: <BN6PR12MB1809067FCF7BA1E3E6D6CF97F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181008022344.10247-1-issor.oruam@gmail.com>
 <CAHbf0-HK4W4xE-hOJPiwr8zhzuuG2GobCTyHHik3mwe1-9_BmQ@mail.gmail.com>
 <CAEQFVGbWWy7jmcaserbMwANNHei90WX+1AvOfDAY8J=BcsyCrg@mail.gmail.com>
 <7a8b5d6d-82c2-2b98-b2b2-098baf095aef@gmail.com>,
 <CAHbf0-FB2GV18igVo-8MHcVGL89KZoXn+O2B4asoe5R4RbgCVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1906812721=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-FB2GV18igVo-8MHcVGL89KZoXn+O2B4asoe5R4RbgCVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1906812721==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809067FCF7BA1E3E6D6CF97F7E60BN6PR12MB1809namp_"

--_000_BN6PR12MB1809067FCF7BA1E3E6D6CF97F7E60BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It's trivial to add the metadata/version headers to the existing firmware, =
so that is not an issue.  The issue is with the firmware itself.  If we use=
d the existing firmware, we'd have to add a bunch of really ugly hacks in t=
he driver to work around the current limitations.


Alex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Mike Lot=
hian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Sent: Monday, October 8, 2018 8:16:01 AM
To: Koenig, Christian
Cc: Mauro Rossi; Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC

I thought it just required the existing firmware, with padding / extra info=
 put around it?

On Mon, 8 Oct 2018 at 12:29 Christian K=F6nig <ckoenig.leichtzumerken@gmail=
.com<mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
UVD/VCE on SI with amdgpu would need new firmware.

And so far we never had time to actually look into releasing that firmware.

Regards,
Christian.


Am 08.10.2018 um 13:22 schrieb Mauro Rossi:
Hi Mike,
On Mon, Oct 8, 2018 at 1:00 PM Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org<mailto:mik=
e@fireburn.co.uk>> wrote:
Hi Mauro

Do you know if there are any plans to add in UVD support on SI too?

Thanks

Mike

At the moment my focus is on getting a conformant, working and stable
implementation of Atomic Display Framework, with the objective to have it
upstreamed to amd-gfx branch, then staging (drm-next) and maybe merged in l=
inux kernel.

To be honest my attempt is based on code paths inspection and mimicking,
so in this moment I do not even know the state of UVD and what changes are =
needed,
but, based on what I saw for DCE6 support addition on top of DCE8,
covering all compatible HW modules makes a lot of sense and it is an opport=
unity to exploit,
if feasible.

For this to happen in most complete and reliable way the feedback of staff =
who worked on DAL/DC
will be essential, because what I did now was to adapt code for DCE8 to wor=
k for DCE6,
but it was like an "optimistic monkey with a keyboard" approach, with all d=
ue respect for monkeys with keyboards,
:-) I may have missed dozen of changes.

Mauro


On Mon, 8 Oct 2018 at 03:24 Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:issor=
.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
[PATCH 01/10] drm/amd/display: add asics info for SI parts
[PATCH 02/10] drm/amd/display: dc/dce: add DCE6 support
[PATCH 03/10] drm/amd/display: dc/core: add DCE6 support
[PATCH 04/10] drm/amd/display: dc/bios: add support for DCE6
[PATCH 05/10] drm/amd/display: dc/gpio: add support for DCE6
[PATCH 06/10] drm/amd/display: dc/i2caux: add support for DCE6
[PATCH 07/10] drm/amd/display: dc/irq: add support for DCE6
[PATCH 08/10] drm/amd/display: amdgpu_dm: add SI support
[PATCH 09/10] drm/amdgpu: enable DC support for SI parts
[PATCH 10/10] drm/amd/display: enable SI support in the Kconfig

The series adds preliminar SI support as a Proof Of Concept,
based on the idea that DCE6 is similar to DCE8, to be reviewed and refined

Android-x86 need/motivation lies in the following chain of dependencies:
Vulkan radv requires gbm gralloc prime_fd support,
gbm gralloc requires drm hwcomposer,
drm hwcomposer requires Atomic Display Framework,
Atomic Display Framework requires AMD DC, currently not supporting SI.

So the goals are:
1) to get Vulkan radv working on SI parts for android-x86.
2) to remove the gap in SI (GCN 1st gen) not having atomic support.

DCE6 specific code was implemented as a replica of existing DCE8 support
and based on how DCE8 specific code was added on top of DCE10,11 support
by adding dce60* sources, functions, macros for each existing in dce80*

CONFIG_DRM_AMD_DC_SI parameter has been added to control SI support in DC

During this first iteration of review, there are aspects to verify:
- dce60 code has been added mechanically, so there may be redundancies
and space for refactoring part of the code
- dce60_resources was having too many building errors due to missing DCE6 m=
acros
in order to temporarily overcome the problem dce_8_0_{d,sh_mask}.h headers
were used for the PoC
- dc/irq suffered the same problem dce_8_0_{d,sh_mask}.h headers
were used for the PoC
- gfx6 may require some ad hoc initialization, skipped for the moment
- Hainan specific code requires review, as some documentation and code path=
s
seem to point that famility may not have DCE6, please confirm
- video decoding blocks code have not been touched
- dc/dce/dce_clock_source.{c,h} may be missing some SI/DCE6 specifics
- dc/dce/dce_dmcu.{c,h} may be missing some SI/DCE6 specifics
- dc/dce/dce_hwseq.h may be missing some SI/DCE6 specifics
- dc/dce/dce_link_encoder.h may be missing some SI/DCE6 specifics
- dc/dce/dce_stream_encoder.h may be missing some SI/DCE6 specifics
- dc/amdgpu_dm/* changes may be incomplete
- Any other omissis to be reviewed
- Feedback on best testing strategy required

Review from an expert of the DC impacted modules is recommended

    SW Layer
/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\
| DC        Display     Timing          Mode        Asic        |
| Interface Service     Service         Manager     Capability* |
|                                                               |
| Display   Topology    Display         Link        Adapter     |
| Path      Manager     Capability      Service     Service     |
|                       Service                                 |
|---------------------------------------------------------------|
| GPIO*     IRQ         I2cAux          HW          BIOS        |
|           Service**   Manager*        Sequencer*  Parser*     |
|                                                               |
| Connector Encoder     Audio           GPU         Controller  |
|                                                               |
\=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/
    HW Layer

Legend:
*dce60 support was added cleanly with dce_6_0_{d,sh_mask}.h headers
**dce60 support was added using dce_8_0_{d,sh_mask}.h headers

Android-x86 preliminary tests results:

[Boots with drm gralloc]
3DMark Slingshot
GFXbench OpenGLES benchmarks OK
V1 GPU benchmark (OpenGLES) OK
Regression in Google Chrome, Youtube (app does not show up)
Regression in Olympus Rising,  Chicken Invaders (app does not show up)

[Boots with drm hwcomposer + gbm gralloc]
Google Chrome, Youtube are OK
Vulkan radv HAL API becomes available with hwc+gbm gralloc
V1 GPU benchmark (Vulkan API) OK
Sacha Willems examples OK
Some glitch/freeze in 3DMark Slingshot Extreeme and API overhead

Kind regards

Mauro Rossi
android-x86 team

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_BN6PR12MB1809067FCF7BA1E3E6D6CF97F7E60BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span>It's trivial to add the met=
adata/version headers to the existing firmware, so that is not an issue.</s=
pan>&nbsp; The issue is with the firmware itself. &nbsp;If we used the exis=
ting firmware, we'd have to add a bunch of really
 ugly hacks in the driver to work around the current limitations.&nbsp;&nbs=
p;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Mike Lothian &lt;mike@firebur=
n.co.uk&gt;<br>
<b>Sent:</b> Monday, October 8, 2018 8:16:01 AM<br>
<b>To:</b> Koenig, Christian<br>
<b>Cc:</b> Mauro Rossi; Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [RFC] drm/amd/display: add SI support to AMD DC</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Dutf-8">
<div>
<div dir=3D"ltr">I thought it just required the existing firmware, with pad=
ding / extra info put around it?<br>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr">On Mon, 8 Oct 2018 at 12:29 Christian K=F6nig &lt;<a href=
=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken@gmail.c=
om</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"x_m_-1296221763677580797moz-cite-prefix">UVD/VCE on SI with a=
mdgpu would need new firmware.<br>
<br>
And so far we never had time to actually look into releasing that firmware.=
<br>
<br>
Regards,<br>
Christian.</div>
</div>
<div bgcolor=3D"#FFFFFF">
<div class=3D"x_m_-1296221763677580797moz-cite-prefix"><br>
<br>
Am 08.10.2018 um 13:22 schrieb Mauro Rossi:<br>
</div>
</div>
<div bgcolor=3D"#FFFFFF">
<blockquote type=3D"cite">
<div dir=3D"ltr">Hi Mike,<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr">On Mon, Oct 8, 2018 at 1:00 PM Mike Lothian &lt;<a href=3D=
"mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org" target=3D"_blank">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>&gt; =
wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">Hi Mauro
<div><br>
</div>
<div>Do you know if there are any plans to add in UVD support on SI too?</d=
iv>
<div><br>
</div>
<div>Thanks</div>
<div><br>
</div>
<div>Mike</div>
</div>
</blockquote>
<div><br>
</div>
<div>At the moment my focus is on getting a conformant, working and stable<=
/div>
<div>implementation of Atomic Display Framework, with the objective to have=
 it</div>
<div>upstreamed to amd-gfx branch, then staging (drm-next) and maybe merged=
 in linux kernel.</div>
<div><br>
</div>
<div>To be honest my attempt is based on code paths inspection and mimickin=
g,</div>
<div>so in this moment I do not even know the state of UVD and what changes=
 are needed,</div>
<div>but, based on what I saw for DCE6 support addition on top of DCE8,</di=
v>
<div>covering all compatible HW modules makes a lot of sense and it is an o=
pportunity to exploit,</div>
<div>if feasible.</div>
<div><br>
</div>
<div>For this to happen in most complete and reliable way the feedback of s=
taff who worked on DAL/DC</div>
<div>will be essential, because what I did now was to adapt code for DCE8 t=
o work for DCE6,</div>
<div>but it was like an &quot;optimistic monkey with a keyboard&quot; appro=
ach, with all due respect for monkeys with keyboards,</div>
<div>:-) I may have missed dozen of changes.</div>
<div><br>
</div>
<div>Mauro</div>
<div>&nbsp;</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr">On Mon, 8 Oct 2018 at 03:24 Mauro Rossi &lt;<a href=3D"mai=
lto:issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; =
wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
[PATCH 01/10] drm/amd/display: add asics info for SI parts<br>
[PATCH 02/10] drm/amd/display: dc/dce: add DCE6 support<br>
[PATCH 03/10] drm/amd/display: dc/core: add DCE6 support<br>
[PATCH 04/10] drm/amd/display: dc/bios: add support for DCE6<br>
[PATCH 05/10] drm/amd/display: dc/gpio: add support for DCE6<br>
[PATCH 06/10] drm/amd/display: dc/i2caux: add support for DCE6<br>
[PATCH 07/10] drm/amd/display: dc/irq: add support for DCE6<br>
[PATCH 08/10] drm/amd/display: amdgpu_dm: add SI support<br>
[PATCH 09/10] drm/amdgpu: enable DC support for SI parts<br>
[PATCH 10/10] drm/amd/display: enable SI support in the Kconfig<br>
<br>
The series adds preliminar SI support as a Proof Of Concept, <br>
based on the idea that DCE6 is similar to DCE8, to be reviewed and refined<=
br>
<br>
Android-x86 need/motivation lies in the following chain of dependencies: <b=
r>
Vulkan radv requires gbm gralloc prime_fd support,<br>
gbm gralloc requires drm hwcomposer,<br>
drm hwcomposer requires Atomic Display Framework, <br>
Atomic Display Framework requires AMD DC, currently not supporting SI.<br>
<br>
So the goals are:<br>
1) to get Vulkan radv working on SI parts for android-x86.<br>
2) to remove the gap in SI (GCN 1st gen) not having atomic support. <br>
<br>
DCE6 specific code was implemented as a replica of existing DCE8 support<br=
>
and based on how DCE8 specific code was added on top of DCE10,11 support<br=
>
by adding dce60* sources, functions, macros for each existing in dce80*<br>
<br>
CONFIG_DRM_AMD_DC_SI parameter has been added to control SI support in DC<b=
r>
<br>
During this first iteration of review, there are aspects to verify:<br>
- dce60 code has been added mechanically, so there may be redundancies <br>
and space for refactoring part of the code<br>
- dce60_resources was having too many building errors due to missing DCE6 m=
acros<br>
in order to temporarily overcome the problem dce_8_0_{d,sh_mask}.h headers<=
br>
were used for the PoC<br>
- dc/irq suffered the same problem dce_8_0_{d,sh_mask}.h headers<br>
were used for the PoC<br>
- gfx6 may require some ad hoc initialization, skipped for the moment<br>
- Hainan specific code requires review, as some documentation and code path=
s<br>
seem to point that famility may not have DCE6, please confirm<br>
- video decoding blocks code have not been touched<br>
- dc/dce/dce_clock_source.{c,h} may be missing some SI/DCE6 specifics<br>
- dc/dce/dce_dmcu.{c,h} may be missing some SI/DCE6 specifics<br>
- dc/dce/dce_hwseq.h may be missing some SI/DCE6 specifics<br>
- dc/dce/dce_link_encoder.h may be missing some SI/DCE6 specifics<br>
- dc/dce/dce_stream_encoder.h may be missing some SI/DCE6 specifics<br>
- dc/amdgpu_dm/* changes may be incomplete<br>
- Any other omissis to be reviewed<br>
- Feedback on best testing strategy required<br>
<br>
Review from an expert of the DC impacted modules is recommended<br>
<br>
&nbsp; &nbsp; SW Layer<br>
/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\<br>
| DC&nbsp; &nbsp; &nbsp; &nbsp; Display&nbsp; &nbsp; &nbsp;Timing&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; Mode&nbsp; &nbsp; &nbsp; &nbsp; Asic&nbsp; &nbsp; =
&nbsp; &nbsp; |<br>
| Interface Service&nbsp; &nbsp; &nbsp;Service&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;Manager&nbsp; &nbsp; &nbsp;Capability* |<br>
|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|=
<br>
| Display&nbsp; &nbsp;Topology&nbsp; &nbsp; Display&nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;Link&nbsp; &nbsp; &nbsp; &nbsp; Adapter&nbsp; &nbsp; &nbsp;|<br>
| Path&nbsp; &nbsp; &nbsp; Manager&nbsp; &nbsp; &nbsp;Capability&nbsp; &nbs=
p; &nbsp; Service&nbsp; &nbsp; &nbsp;Service&nbsp; &nbsp; &nbsp;|<br>
|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;Service&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
|---------------------------------------------------------------|<br>
| GPIO*&nbsp; &nbsp; &nbsp;IRQ&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;I2cAux&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; HW&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BIOS&nbs=
p; &nbsp; &nbsp; &nbsp; |<br>
|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Service**&nbsp; &nbsp;Manager*&nb=
sp; &nbsp; &nbsp; &nbsp; Sequencer*&nbsp; Parser*&nbsp; &nbsp; &nbsp;|<br>
|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|=
<br>
| Connector Encoder&nbsp; &nbsp; &nbsp;Audio&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;GPU&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Controller&nbsp; |<br>
|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|=
<br>
\=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/<br>
&nbsp; &nbsp; HW Layer<br>
<br>
Legend: <br>
*dce60 support was added cleanly with dce_6_0_{d,sh_mask}.h headers<br>
**dce60 support was added using dce_8_0_{d,sh_mask}.h headers<br>
<br>
Android-x86 preliminary tests results:<br>
<br>
[Boots with drm gralloc]<br>
3DMark Slingshot<br>
GFXbench OpenGLES benchmarks OK<br>
V1 GPU benchmark (OpenGLES) OK<br>
Regression in Google Chrome, Youtube (app does not show up)<br>
Regression in Olympus Rising,&nbsp; Chicken Invaders (app does not show up)=
<br>
<br>
[Boots with drm hwcomposer &#43; gbm gralloc]<br>
Google Chrome, Youtube are OK<br>
Vulkan radv HAL API becomes available with hwc&#43;gbm gralloc<br>
V1 GPU benchmark (Vulkan API) OK<br>
Sacha Willems examples OK<br>
Some glitch/freeze in 3DMark Slingshot Extreeme and API overhead<br>
<br>
Kind regards<br>
<br>
Mauro Rossi<br>
android-x86 team<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote>
</div>
</blockquote>
</div>
</div>
<br>
<fieldset class=3D"x_m_-1296221763677580797mimeAttachmentHeader"></fieldset=
> <br>
<pre>_______________________________________________
amd-gfx mailing list
<a class=3D"x_m_-1296221763677580797moz-txt-link-abbreviated" href=3D"mailt=
o:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org</a>
<a class=3D"x_m_-1296221763677580797moz-txt-link-freetext" href=3D"https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">https://l=
ists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<br>
</div>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1809067FCF7BA1E3E6D6CF97F7E60BN6PR12MB1809namp_--

--===============1906812721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1906812721==--

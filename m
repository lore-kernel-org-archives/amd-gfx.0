From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC
Date: Mon, 8 Oct 2018 12:00:45 +0100
Message-ID: <CAHbf0-HK4W4xE-hOJPiwr8zhzuuG2GobCTyHHik3mwe1-9_BmQ@mail.gmail.com>
References: <20181008022344.10247-1-issor.oruam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0548505459=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181008022344.10247-1-issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: harry.wentland-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0548505459==
Content-Type: multipart/alternative; boundary="0000000000001d013a0577b5891e"

--0000000000001d013a0577b5891e
Content-Type: text/plain; charset="UTF-8"

Hi Mauro

Do you know if there are any plans to add in UVD support on SI too?

Thanks

Mike

On Mon, 8 Oct 2018 at 03:24 Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> [PATCH 01/10] drm/amd/display: add asics info for SI parts
> [PATCH 02/10] drm/amd/display: dc/dce: add DCE6 support
> [PATCH 03/10] drm/amd/display: dc/core: add DCE6 support
> [PATCH 04/10] drm/amd/display: dc/bios: add support for DCE6
> [PATCH 05/10] drm/amd/display: dc/gpio: add support for DCE6
> [PATCH 06/10] drm/amd/display: dc/i2caux: add support for DCE6
> [PATCH 07/10] drm/amd/display: dc/irq: add support for DCE6
> [PATCH 08/10] drm/amd/display: amdgpu_dm: add SI support
> [PATCH 09/10] drm/amdgpu: enable DC support for SI parts
> [PATCH 10/10] drm/amd/display: enable SI support in the Kconfig
>
> The series adds preliminar SI support as a Proof Of Concept,
> based on the idea that DCE6 is similar to DCE8, to be reviewed and refined
>
> Android-x86 need/motivation lies in the following chain of dependencies:
> Vulkan radv requires gbm gralloc prime_fd support,
> gbm gralloc requires drm hwcomposer,
> drm hwcomposer requires Atomic Display Framework,
> Atomic Display Framework requires AMD DC, currently not supporting SI.
>
> So the goals are:
> 1) to get Vulkan radv working on SI parts for android-x86.
> 2) to remove the gap in SI (GCN 1st gen) not having atomic support.
>
> DCE6 specific code was implemented as a replica of existing DCE8 support
> and based on how DCE8 specific code was added on top of DCE10,11 support
> by adding dce60* sources, functions, macros for each existing in dce80*
>
> CONFIG_DRM_AMD_DC_SI parameter has been added to control SI support in DC
>
> During this first iteration of review, there are aspects to verify:
> - dce60 code has been added mechanically, so there may be redundancies
> and space for refactoring part of the code
> - dce60_resources was having too many building errors due to missing DCE6
> macros
> in order to temporarily overcome the problem dce_8_0_{d,sh_mask}.h headers
> were used for the PoC
> - dc/irq suffered the same problem dce_8_0_{d,sh_mask}.h headers
> were used for the PoC
> - gfx6 may require some ad hoc initialization, skipped for the moment
> - Hainan specific code requires review, as some documentation and code
> paths
> seem to point that famility may not have DCE6, please confirm
> - video decoding blocks code have not been touched
> - dc/dce/dce_clock_source.{c,h} may be missing some SI/DCE6 specifics
> - dc/dce/dce_dmcu.{c,h} may be missing some SI/DCE6 specifics
> - dc/dce/dce_hwseq.h may be missing some SI/DCE6 specifics
> - dc/dce/dce_link_encoder.h may be missing some SI/DCE6 specifics
> - dc/dce/dce_stream_encoder.h may be missing some SI/DCE6 specifics
> - dc/amdgpu_dm/* changes may be incomplete
> - Any other omissis to be reviewed
> - Feedback on best testing strategy required
>
> Review from an expert of the DC impacted modules is recommended
>
>     SW Layer
> /===============================================================\
> | DC        Display     Timing          Mode        Asic        |
> | Interface Service     Service         Manager     Capability* |
> |                                                               |
> | Display   Topology    Display         Link        Adapter     |
> | Path      Manager     Capability      Service     Service     |
> |                       Service                                 |
> |---------------------------------------------------------------|
> | GPIO*     IRQ         I2cAux          HW          BIOS        |
> |           Service**   Manager*        Sequencer*  Parser*     |
> |                                                               |
> | Connector Encoder     Audio           GPU         Controller  |
> |                                                               |
> \===============================================================/
>     HW Layer
>
> Legend:
> *dce60 support was added cleanly with dce_6_0_{d,sh_mask}.h headers
> **dce60 support was added using dce_8_0_{d,sh_mask}.h headers
>
> Android-x86 preliminary tests results:
>
> [Boots with drm gralloc]
> 3DMark Slingshot
> GFXbench OpenGLES benchmarks OK
> V1 GPU benchmark (OpenGLES) OK
> Regression in Google Chrome, Youtube (app does not show up)
> Regression in Olympus Rising,  Chicken Invaders (app does not show up)
>
> [Boots with drm hwcomposer + gbm gralloc]
> Google Chrome, Youtube are OK
> Vulkan radv HAL API becomes available with hwc+gbm gralloc
> V1 GPU benchmark (Vulkan API) OK
> Sacha Willems examples OK
> Some glitch/freeze in 3DMark Slingshot Extreeme and API overhead
>
> Kind regards
>
> Mauro Rossi
> android-x86 team
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000001d013a0577b5891e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mauro<div><br></div><div>Do you know if there are any p=
lans to add in UVD support on SI too?</div><div><br></div><div>Thanks</div>=
<div><br></div><div>Mike</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Mon, 8 Oct 2018 at 03:24 Mauro Rossi &lt;<a href=3D"mailto:isso=
r.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">[PATCH 01/10] drm/amd/display: add asics info for SI p=
arts<br>
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
=C2=A0 =C2=A0 SW Layer<br>
/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\<br>
| DC=C2=A0 =C2=A0 =C2=A0 =C2=A0 Display=C2=A0 =C2=A0 =C2=A0Timing=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Mode=C2=A0 =C2=A0 =C2=A0 =C2=A0 Asic=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |<br>
| Interface Service=C2=A0 =C2=A0 =C2=A0Service=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Manager=C2=A0 =C2=A0 =C2=A0Capability* |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>
| Display=C2=A0 =C2=A0Topology=C2=A0 =C2=A0 Display=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Link=C2=A0 =C2=A0 =C2=A0 =C2=A0 Adapter=C2=A0 =C2=A0 =C2=A0|<br>
| Path=C2=A0 =C2=A0 =C2=A0 Manager=C2=A0 =C2=A0 =C2=A0Capability=C2=A0 =C2=
=A0 =C2=A0 Service=C2=A0 =C2=A0 =C2=A0Service=C2=A0 =C2=A0 =C2=A0|<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Service=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
|---------------------------------------------------------------|<br>
| GPIO*=C2=A0 =C2=A0 =C2=A0IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I2cAux=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIOS=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Service**=C2=A0 =C2=A0Manager*=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Sequencer*=C2=A0 Parser*=C2=A0 =C2=A0 =C2=A0|<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>
| Connector Encoder=C2=A0 =C2=A0 =C2=A0Audio=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0GPU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Controller=C2=A0 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>
\=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/<br>
=C2=A0 =C2=A0 HW Layer<br>
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
Regression in Olympus Rising,=C2=A0 Chicken Invaders (app does not show up)=
<br>
<br>
[Boots with drm hwcomposer + gbm gralloc]<br>
Google Chrome, Youtube are OK<br>
Vulkan radv HAL API becomes available with hwc+gbm gralloc<br>
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
</blockquote></div>

--0000000000001d013a0577b5891e--

--===============0548505459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0548505459==--

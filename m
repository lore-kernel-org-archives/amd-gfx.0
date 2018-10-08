From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC
Date: Mon, 8 Oct 2018 13:29:06 +0200
Message-ID: <7a8b5d6d-82c2-2b98-b2b2-098baf095aef@gmail.com>
References: <20181008022344.10247-1-issor.oruam@gmail.com>
 <CAHbf0-HK4W4xE-hOJPiwr8zhzuuG2GobCTyHHik3mwe1-9_BmQ@mail.gmail.com>
 <CAEQFVGbWWy7jmcaserbMwANNHei90WX+1AvOfDAY8J=BcsyCrg@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0851736444=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEQFVGbWWy7jmcaserbMwANNHei90WX+1AvOfDAY8J=BcsyCrg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0851736444==
Content-Type: multipart/alternative;
 boundary="------------280C0070086FCB90B5465FF5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------280C0070086FCB90B5465FF5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

UVD/VCE on SI with amdgpu would need new firmware.

And so far we never had time to actually look into releasing that firmware.

Regards,
Christian.

Am 08.10.2018 um 13:22 schrieb Mauro Rossi:
> Hi Mike,
> On Mon, Oct 8, 2018 at 1:00 PM Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org 
> <mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>> wrote:
>
>     Hi Mauro
>
>     Do you know if there are any plans to add in UVD support on SI too?
>
>     Thanks
>
>     Mike
>
>
> At the moment my focus is on getting a conformant, working and stable
> implementation of Atomic Display Framework, with the objective to have it
> upstreamed to amd-gfx branch, then staging (drm-next) and maybe merged 
> in linux kernel.
>
> To be honest my attempt is based on code paths inspection and mimicking,
> so in this moment I do not even know the state of UVD and what changes 
> are needed,
> but, based on what I saw for DCE6 support addition on top of DCE8,
> covering all compatible HW modules makes a lot of sense and it is an 
> opportunity to exploit,
> if feasible.
>
> For this to happen in most complete and reliable way the feedback of 
> staff who worked on DAL/DC
> will be essential, because what I did now was to adapt code for DCE8 
> to work for DCE6,
> but it was like an "optimistic monkey with a keyboard" approach, with 
> all due respect for monkeys with keyboards,
> :-) I may have missed dozen of changes.
>
> Mauro
>
>
>     On Mon, 8 Oct 2018 at 03:24 Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>     <mailto:issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>         [PATCH 01/10] drm/amd/display: add asics info for SI parts
>         [PATCH 02/10] drm/amd/display: dc/dce: add DCE6 support
>         [PATCH 03/10] drm/amd/display: dc/core: add DCE6 support
>         [PATCH 04/10] drm/amd/display: dc/bios: add support for DCE6
>         [PATCH 05/10] drm/amd/display: dc/gpio: add support for DCE6
>         [PATCH 06/10] drm/amd/display: dc/i2caux: add support for DCE6
>         [PATCH 07/10] drm/amd/display: dc/irq: add support for DCE6
>         [PATCH 08/10] drm/amd/display: amdgpu_dm: add SI support
>         [PATCH 09/10] drm/amdgpu: enable DC support for SI parts
>         [PATCH 10/10] drm/amd/display: enable SI support in the Kconfig
>
>         The series adds preliminar SI support as a Proof Of Concept,
>         based on the idea that DCE6 is similar to DCE8, to be reviewed
>         and refined
>
>         Android-x86 need/motivation lies in the following chain of
>         dependencies:
>         Vulkan radv requires gbm gralloc prime_fd support,
>         gbm gralloc requires drm hwcomposer,
>         drm hwcomposer requires Atomic Display Framework,
>         Atomic Display Framework requires AMD DC, currently not
>         supporting SI.
>
>         So the goals are:
>         1) to get Vulkan radv working on SI parts for android-x86.
>         2) to remove the gap in SI (GCN 1st gen) not having atomic
>         support.
>
>         DCE6 specific code was implemented as a replica of existing
>         DCE8 support
>         and based on how DCE8 specific code was added on top of
>         DCE10,11 support
>         by adding dce60* sources, functions, macros for each existing
>         in dce80*
>
>         CONFIG_DRM_AMD_DC_SI parameter has been added to control SI
>         support in DC
>
>         During this first iteration of review, there are aspects to
>         verify:
>         - dce60 code has been added mechanically, so there may be
>         redundancies
>         and space for refactoring part of the code
>         - dce60_resources was having too many building errors due to
>         missing DCE6 macros
>         in order to temporarily overcome the problem
>         dce_8_0_{d,sh_mask}.h headers
>         were used for the PoC
>         - dc/irq suffered the same problem dce_8_0_{d,sh_mask}.h headers
>         were used for the PoC
>         - gfx6 may require some ad hoc initialization, skipped for the
>         moment
>         - Hainan specific code requires review, as some documentation
>         and code paths
>         seem to point that famility may not have DCE6, please confirm
>         - video decoding blocks code have not been touched
>         - dc/dce/dce_clock_source.{c,h} may be missing some SI/DCE6
>         specifics
>         - dc/dce/dce_dmcu.{c,h} may be missing some SI/DCE6 specifics
>         - dc/dce/dce_hwseq.h may be missing some SI/DCE6 specifics
>         - dc/dce/dce_link_encoder.h may be missing some SI/DCE6 specifics
>         - dc/dce/dce_stream_encoder.h may be missing some SI/DCE6
>         specifics
>         - dc/amdgpu_dm/* changes may be incomplete
>         - Any other omissis to be reviewed
>         - Feedback on best testing strategy required
>
>         Review from an expert of the DC impacted modules is recommended
>
>             SW Layer
>         /===============================================================\
>         | DC        Display     Timing          Mode Asic        |
>         | Interface Service     Service         Manager  Capability* |
>         |        |
>         | Display   Topology    Display         Link Adapter     |
>         | Path      Manager     Capability      Service  Service     |
>         |                       Service        |
>         |---------------------------------------------------------------|
>         | GPIO*     IRQ         I2cAux          HW BIOS        |
>         |           Service**   Manager*        Sequencer* Parser*     |
>         |        |
>         | Connector Encoder     Audio           GPU  Controller  |
>         |        |
>         \===============================================================/
>             HW Layer
>
>         Legend:
>         *dce60 support was added cleanly with dce_6_0_{d,sh_mask}.h
>         headers
>         **dce60 support was added using dce_8_0_{d,sh_mask}.h headers
>
>         Android-x86 preliminary tests results:
>
>         [Boots with drm gralloc]
>         3DMark Slingshot
>         GFXbench OpenGLES benchmarks OK
>         V1 GPU benchmark (OpenGLES) OK
>         Regression in Google Chrome, Youtube (app does not show up)
>         Regression in Olympus Rising,  Chicken Invaders (app does not
>         show up)
>
>         [Boots with drm hwcomposer + gbm gralloc]
>         Google Chrome, Youtube are OK
>         Vulkan radv HAL API becomes available with hwc+gbm gralloc
>         V1 GPU benchmark (Vulkan API) OK
>         Sacha Willems examples OK
>         Some glitch/freeze in 3DMark Slingshot Extreeme and API overhead
>
>         Kind regards
>
>         Mauro Rossi
>         android-x86 team
>
>         _______________________________________________
>         amd-gfx mailing list
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------280C0070086FCB90B5465FF5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">UVD/VCE on SI with amdgpu would need
      new firmware.<br>
      <br>
      And so far we never had time to actually look into releasing that
      firmware.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 08.10.2018 um 13:22 schrieb Mauro Rossi:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEQFVGbWWy7jmcaserbMwANNHei90WX+1AvOfDAY8J=BcsyCrg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">Hi Mike,<br>
        <div class="gmail_quote">
          <div dir="ltr">On Mon, Oct 8, 2018 at 1:00 PM Mike Lothian
            &lt;<a href="mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org"
              moz-do-not-send="true">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>&gt; wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div dir="ltr">Hi Mauro
              <div><br>
              </div>
              <div>Do you know if there are any plans to add in UVD
                support on SI too?</div>
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
          <div>At the moment my focus is on getting a conformant,
            working and stable</div>
          <div>implementation of Atomic Display Framework, with the
            objective to have it</div>
          <div>upstreamed to amd-gfx branch, then staging (drm-next) and
            maybe merged in linux kernel.</div>
          <div><br>
          </div>
          <div>To be honest my attempt is based on code paths inspection
            and mimicking,</div>
          <div>so in this moment I do not even know the state of UVD and
            what changes are needed,</div>
          <div>but, based on what I saw for DCE6 support addition on top
            of DCE8,</div>
          <div>covering all compatible HW modules makes a lot of sense
            and it is an opportunity to exploit,</div>
          <div>if feasible.</div>
          <div><br>
          </div>
          <div>For this to happen in most complete and reliable way the
            feedback of staff who worked on DAL/DC</div>
          <div>will be essential, because what I did now was to adapt
            code for DCE8 to work for DCE6,</div>
          <div>but it was like an "optimistic monkey with a keyboard"
            approach, with all due respect for monkeys with keyboards,</div>
          <div>:-) I may have missed dozen of changes.</div>
          <div><br>
          </div>
          <div>Mauro</div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
            <div class="gmail_quote">
              <div dir="ltr">On Mon, 8 Oct 2018 at 03:24 Mauro Rossi
                &lt;<a href="mailto:issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                  target="_blank" moz-do-not-send="true">issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                wrote:<br>
              </div>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">[PATCH
                01/10] drm/amd/display: add asics info for SI parts<br>
                [PATCH 02/10] drm/amd/display: dc/dce: add DCE6 support<br>
                [PATCH 03/10] drm/amd/display: dc/core: add DCE6 support<br>
                [PATCH 04/10] drm/amd/display: dc/bios: add support for
                DCE6<br>
                [PATCH 05/10] drm/amd/display: dc/gpio: add support for
                DCE6<br>
                [PATCH 06/10] drm/amd/display: dc/i2caux: add support
                for DCE6<br>
                [PATCH 07/10] drm/amd/display: dc/irq: add support for
                DCE6<br>
                [PATCH 08/10] drm/amd/display: amdgpu_dm: add SI support<br>
                [PATCH 09/10] drm/amdgpu: enable DC support for SI parts<br>
                [PATCH 10/10] drm/amd/display: enable SI support in the
                Kconfig<br>
                <br>
                The series adds preliminar SI support as a Proof Of
                Concept, <br>
                based on the idea that DCE6 is similar to DCE8, to be
                reviewed and refined<br>
                <br>
                Android-x86 need/motivation lies in the following chain
                of dependencies: <br>
                Vulkan radv requires gbm gralloc prime_fd support,<br>
                gbm gralloc requires drm hwcomposer,<br>
                drm hwcomposer requires Atomic Display Framework, <br>
                Atomic Display Framework requires AMD DC, currently not
                supporting SI.<br>
                <br>
                So the goals are:<br>
                1) to get Vulkan radv working on SI parts for
                android-x86.<br>
                2) to remove the gap in SI (GCN 1st gen) not having
                atomic support. <br>
                <br>
                DCE6 specific code was implemented as a replica of
                existing DCE8 support<br>
                and based on how DCE8 specific code was added on top of
                DCE10,11 support<br>
                by adding dce60* sources, functions, macros for each
                existing in dce80*<br>
                <br>
                CONFIG_DRM_AMD_DC_SI parameter has been added to control
                SI support in DC<br>
                <br>
                During this first iteration of review, there are aspects
                to verify:<br>
                - dce60 code has been added mechanically, so there may
                be redundancies <br>
                and space for refactoring part of the code<br>
                - dce60_resources was having too many building errors
                due to missing DCE6 macros<br>
                in order to temporarily overcome the problem
                dce_8_0_{d,sh_mask}.h headers<br>
                were used for the PoC<br>
                - dc/irq suffered the same problem dce_8_0_{d,sh_mask}.h
                headers<br>
                were used for the PoC<br>
                - gfx6 may require some ad hoc initialization, skipped
                for the moment<br>
                - Hainan specific code requires review, as some
                documentation and code paths<br>
                seem to point that famility may not have DCE6, please
                confirm<br>
                - video decoding blocks code have not been touched<br>
                - dc/dce/dce_clock_source.{c,h} may be missing some
                SI/DCE6 specifics<br>
                - dc/dce/dce_dmcu.{c,h} may be missing some SI/DCE6
                specifics<br>
                - dc/dce/dce_hwseq.h may be missing some SI/DCE6
                specifics<br>
                - dc/dce/dce_link_encoder.h may be missing some SI/DCE6
                specifics<br>
                - dc/dce/dce_stream_encoder.h may be missing some
                SI/DCE6 specifics<br>
                - dc/amdgpu_dm/* changes may be incomplete<br>
                - Any other omissis to be reviewed<br>
                - Feedback on best testing strategy required<br>
                <br>
                Review from an expert of the DC impacted modules is
                recommended<br>
                <br>
                    SW Layer<br>
/===============================================================\<br>
                | DC        Display     Timing          Mode       
                Asic        |<br>
                | Interface Service     Service         Manager   
                 Capability* |<br>
                |                                                       
                       |<br>
                | Display   Topology    Display         Link       
                Adapter     |<br>
                | Path      Manager     Capability      Service   
                 Service     |<br>
                |                       Service                         
                       |<br>
|---------------------------------------------------------------|<br>
                | GPIO*     IRQ         I2cAux          HW         
                BIOS        |<br>
                |           Service**   Manager*        Sequencer* 
                Parser*     |<br>
                |                                                       
                       |<br>
                | Connector Encoder     Audio           GPU       
                 Controller  |<br>
                |                                                       
                       |<br>
\===============================================================/<br>
                    HW Layer<br>
                <br>
                Legend: <br>
                *dce60 support was added cleanly with
                dce_6_0_{d,sh_mask}.h headers<br>
                **dce60 support was added using dce_8_0_{d,sh_mask}.h
                headers<br>
                <br>
                Android-x86 preliminary tests results:<br>
                <br>
                [Boots with drm gralloc]<br>
                3DMark Slingshot<br>
                GFXbench OpenGLES benchmarks OK<br>
                V1 GPU benchmark (OpenGLES) OK<br>
                Regression in Google Chrome, Youtube (app does not show
                up)<br>
                Regression in Olympus Rising,  Chicken Invaders (app
                does not show up)<br>
                <br>
                [Boots with drm hwcomposer + gbm gralloc]<br>
                Google Chrome, Youtube are OK<br>
                Vulkan radv HAL API becomes available with hwc+gbm
                gralloc<br>
                V1 GPU benchmark (Vulkan API) OK<br>
                Sacha Willems examples OK<br>
                Some glitch/freeze in 3DMark Slingshot Extreeme and API
                overhead<br>
                <br>
                Kind regards<br>
                <br>
                Mauro Rossi<br>
                android-x86 team<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                  target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  rel="noreferrer" target="_blank"
                  moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
              </blockquote>
            </div>
          </blockquote>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------280C0070086FCB90B5465FF5--

--===============0851736444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0851736444==--

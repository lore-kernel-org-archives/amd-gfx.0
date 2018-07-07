From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/display: make function tables const
Date: Sat, 7 Jul 2018 14:30:59 +0200
Message-ID: <d4676482-caba-c691-fe95-9f034e8eb1b9@gmail.com>
References: <20180706122201.34465-1-christian.koenig@amd.com>
 <20180706122201.34465-2-christian.koenig@amd.com>
 <8b1e05c0-3b43-13cd-761c-c7b342d52364@amd.com>
 <CY4PR12MB1687241A8A0FF74C10E93985FB460@CY4PR12MB1687.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0339657317=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687241A8A0FF74C10E93985FB460-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0339657317==
Content-Type: multipart/alternative;
 boundary="------------0C17BF75225698FE681E7138"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0C17BF75225698FE681E7138
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

That's a completely different issue. I'm running into it with just a 
Tonga in my system.

According to my bisecting the problematic patch seems to be:
> commit 3fdadbfe1edf4168b2515083af5651c95aeb299d (refs/bisect/bad)
> Author: Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>
> Date:   Thu Jul 5 19:22:50 2018 +0800
>
>     drm/amd/pp: Implement get_performance_level for legacy dgpu
>
>     display can get clock info through this function.
>     implement this function for vega10 and old asics.
>     from vega12, there is no power state management,
>     so need to add new interface to notify display
>     the clock info
>
>     Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>     Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Please fix and/or revert immediately, cause that is quite a show stopper 
for my testing.

Thanks,
Christian.

Am 07.07.2018 um 03:51 schrieb Zhu, Rex:
>
> Add Michel,
>
>
> seems Michel found a similar issue. Please see the kern.log.
>
>
> Best Regards
>
> Rex
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, July 6, 2018 9:32 PM
> *To:* Christian König; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Lipski, Mikita
> *Subject:* Re: [PATCH 2/2] drm/amd/display: make function tables const
> On 2018-07-06 08:22 AM, Christian König wrote:
> > It is good practice to make global function tables const to avoid
> > accidental override.
> >
> > Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Well, this is embarassing. Can't believe I didn't spot this.
>
> Series is
> Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
>
> Now I wonder where else we might have this issue. Time to review all 
> of our other function pointers.
>
> Harry
>
> > ---
> > drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 6 +++---
> > drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 2 +-
> > drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c 
> b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> > index bae752332a9f..85686d917636 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> > @@ -729,7 +729,7 @@ static bool dce_mi_program_surface_flip_and_addr(
> >        return true;
> >  }
> >
> > -static struct mem_input_funcs dce_mi_funcs = {
> > +static const struct mem_input_funcs dce_mi_funcs = {
> >        .mem_input_program_display_marks = dce_mi_program_display_marks,
> >        .allocate_mem_input = dce_mi_allocate_dmif,
> >        .free_mem_input = dce_mi_free_dmif,
> > @@ -741,7 +741,7 @@ static struct mem_input_funcs dce_mi_funcs = {
> >        .mem_input_is_flip_pending = dce_mi_is_flip_pending
> >  };
> >
> > -static struct mem_input_funcs dce112_mi_funcs = {
> > +static const struct mem_input_funcs dce112_mi_funcs = {
> >        .mem_input_program_display_marks = 
> dce112_mi_program_display_marks,
> >        .allocate_mem_input = dce_mi_allocate_dmif,
> >        .free_mem_input = dce_mi_free_dmif,
> > @@ -753,7 +753,7 @@ static struct mem_input_funcs dce112_mi_funcs = {
> >        .mem_input_is_flip_pending = dce_mi_is_flip_pending
> >  };
> >
> > -static struct mem_input_funcs dce120_mi_funcs = {
> > +static const struct mem_input_funcs dce120_mi_funcs = {
> >        .mem_input_program_display_marks = 
> dce120_mi_program_display_marks,
> >        .allocate_mem_input = dce_mi_allocate_dmif,
> >        .free_mem_input = dce_mi_free_dmif,
> > diff --git 
> a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c 
> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> > index 0564c8e31252..9b9fc3d96c07 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> > @@ -1011,7 +1011,7 @@ void dce110_free_mem_input_v(
> >  {
> >  }
> >
> > -static struct mem_input_funcs dce110_mem_input_v_funcs = {
> > +static const struct mem_input_funcs dce110_mem_input_v_funcs = {
> >        .mem_input_program_display_marks =
> > dce_mem_input_v_program_display_marks,
> >        .mem_input_program_chroma_display_marks =
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h 
> b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
> > index 47f1dc5a43b7..da89c2edb07c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
> > @@ -64,7 +64,7 @@ struct stutter_modes {
> >  };
> >
> >  struct mem_input {
> > -     struct mem_input_funcs *funcs;
> > +     const struct mem_input_funcs *funcs;
> >        struct dc_context *ctx;
> >        struct dc_plane_address request_address;
> >        struct dc_plane_address current_address;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the 
> following form. Use of all freedesktop.org lists is subject to our 
> Code of Conduct.
>
>
>


--------------0C17BF75225698FE681E7138
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That's a completely different issue.
      I'm running into it with just a Tonga in my system.<br>
      <br>
      According to my bisecting the problematic patch seems to be:<br>
      <blockquote type="cite">commit
        3fdadbfe1edf4168b2515083af5651c95aeb299d (refs/bisect/bad)<br>
        Author: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:rex.zhu-5C7GfCeVMHo@public.gmane.org">&lt;rex.zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        Date:   Thu Jul 5 19:22:50 2018 +0800<br>
        <br>
            drm/amd/pp: Implement get_performance_level for legacy dgpu<br>
            <br>
            display can get clock info through this function.<br>
            implement this function for vega10 and old asics.<br>
            from vega12, there is no power state management,<br>
            so need to add new interface to notify display<br>
            the clock info<br>
            <br>
            Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      </blockquote>
      <br>
      Please fix and/or revert immediately, cause that is quite a show
      stopper for my testing.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 07.07.2018 um 03:51 schrieb Zhu, Rex:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1687241A8A0FF74C10E93985FB460-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper" style="font-size: 12pt; color:
        rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif,
        EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
        Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
        &quot;Android Emoji&quot;, EmojiSymbols;" dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Add Michel,</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">seems Michel found a
          similar issue. Please see the kern.log.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Best Regards</p>
        <p style="margin-top:0;margin-bottom:0">Rex</p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">&lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Friday, July 6, 2018 9:32 PM<br>
              <b>To:</b> Christian König; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Lipski, Mikita<br>
              <b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: make
              function tables const</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">On 2018-07-06 08:22 AM, Christian
                  König wrote:<br>
                  &gt; It is good practice to make global function
                  tables const to avoid<br>
                  &gt; accidental override.<br>
                  &gt; <br>
                  &gt; Signed-off-by: Christian König
                  <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <br>
                  Well, this is embarassing. Can't believe I didn't spot
                  this.<br>
                  <br>
                  Series is<br>
                  Reviewed-by: Harry Wentland
                  <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">&lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <br>
                  Now I wonder where else we might have this issue. Time
                  to review all of our other function pointers.<br>
                  <br>
                  Harry<br>
                  <br>
                  &gt; ---<br>
                  &gt; 
                  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c        
                  | 6 +++---<br>
                  &gt; 
                  drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
                  | 2 +-<br>
                  &gt; 
                  drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h         
                  | 2 +-<br>
                  &gt;  3 files changed, 5 insertions(+), 5 deletions(-)<br>
                  &gt; <br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
                  b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c<br>
                  &gt; index bae752332a9f..85686d917636 100644<br>
                  &gt; ---
                  a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c<br>
                  &gt; +++
                  b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c<br>
                  &gt; @@ -729,7 +729,7 @@ static bool
                  dce_mi_program_surface_flip_and_addr(<br>
                  &gt;        return true;<br>
                  &gt;  }<br>
                  &gt;  <br>
                  &gt; -static struct mem_input_funcs dce_mi_funcs = {<br>
                  &gt; +static const struct mem_input_funcs dce_mi_funcs
                  = {<br>
                  &gt;        .mem_input_program_display_marks =
                  dce_mi_program_display_marks,<br>
                  &gt;        .allocate_mem_input =
                  dce_mi_allocate_dmif,<br>
                  &gt;        .free_mem_input = dce_mi_free_dmif,<br>
                  &gt; @@ -741,7 +741,7 @@ static struct mem_input_funcs
                  dce_mi_funcs = {<br>
                  &gt;        .mem_input_is_flip_pending =
                  dce_mi_is_flip_pending<br>
                  &gt;  };<br>
                  &gt;  <br>
                  &gt; -static struct mem_input_funcs dce112_mi_funcs =
                  {<br>
                  &gt; +static const struct mem_input_funcs
                  dce112_mi_funcs = {<br>
                  &gt;        .mem_input_program_display_marks =
                  dce112_mi_program_display_marks,<br>
                  &gt;        .allocate_mem_input =
                  dce_mi_allocate_dmif,<br>
                  &gt;        .free_mem_input = dce_mi_free_dmif,<br>
                  &gt; @@ -753,7 +753,7 @@ static struct mem_input_funcs
                  dce112_mi_funcs = {<br>
                  &gt;        .mem_input_is_flip_pending =
                  dce_mi_is_flip_pending<br>
                  &gt;  };<br>
                  &gt;  <br>
                  &gt; -static struct mem_input_funcs dce120_mi_funcs =
                  {<br>
                  &gt; +static const struct mem_input_funcs
                  dce120_mi_funcs = {<br>
                  &gt;        .mem_input_program_display_marks =
                  dce120_mi_program_display_marks,<br>
                  &gt;        .allocate_mem_input =
                  dce_mi_allocate_dmif,<br>
                  &gt;        .free_mem_input = dce_mi_free_dmif,<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c<br>
                  &gt; index 0564c8e31252..9b9fc3d96c07 100644<br>
                  &gt; ---
                  a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c<br>
                  &gt; +++
                  b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c<br>
                  &gt; @@ -1011,7 +1011,7 @@ void
                  dce110_free_mem_input_v(<br>
                  &gt;  {<br>
                  &gt;  }<br>
                  &gt;  <br>
                  &gt; -static struct mem_input_funcs
                  dce110_mem_input_v_funcs = {<br>
                  &gt; +static const struct mem_input_funcs
                  dce110_mem_input_v_funcs = {<br>
                  &gt;        .mem_input_program_display_marks =<br>
                  &gt;                       
                  dce_mem_input_v_program_display_marks,<br>
                  &gt;        .mem_input_program_chroma_display_marks =<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
                  b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h<br>
                  &gt; index 47f1dc5a43b7..da89c2edb07c 100644<br>
                  &gt; ---
                  a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h<br>
                  &gt; +++
                  b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h<br>
                  &gt; @@ -64,7 +64,7 @@ struct stutter_modes {<br>
                  &gt;  };<br>
                  &gt;  <br>
                  &gt;  struct mem_input {<br>
                  &gt; -     struct mem_input_funcs *funcs;<br>
                  &gt; +     const struct mem_input_funcs *funcs;<br>
                  &gt;        struct dc_context *ctx;<br>
                  &gt;        struct dc_plane_address request_address;<br>
                  &gt;        struct dc_plane_address current_address;<br>
                  &gt; <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk757106" class="OWAAutoLink"
                    previewremoved="true" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                  <div id="LPBorder_GT_15309280054370.5139627939483356"
                    style="margin-bottom: 20px; overflow: auto; width:
                    100%; text-indent: 0px;">
                    <table
                      id="LPContainer_15309280054340.885055010626419"
                      role="presentation" style="width: 90%;
                      background-color: rgb(255, 255, 255); position:
                      relative; overflow: auto; padding-top: 20px;
                      padding-bottom: 20px; margin-top: 20px;
                      border-top: 1px dotted rgb(200, 200, 200);
                      border-bottom: 1px dotted rgb(200, 200, 200);"
                      cellspacing="0">
                      <tbody>
                        <tr style="border-spacing: 0px;" valign="top">
                          <td
                            id="TextCell_15309280054350.09207141975106015"
                            colspan="2" style="vertical-align: top;
                            position: relative; padding: 0px; display:
                            table-cell;">
                            <div
                              id="LPTitle_15309280054360.5322745038679628"
                              style="top: 0px; color: rgb(0, 120, 215);
                              font-weight: normal; font-size: 21px;
                              font-family: wf_segoe-ui_light,
                              &quot;Segoe UI Light&quot;, &quot;Segoe WP
                              Light&quot;, &quot;Segoe UI&quot;,
                              &quot;Segoe WP&quot;, Tahoma, Arial,
                              sans-serif; line-height: 21px;">
                              <a
                                id="LPUrlAnchor_15309280054360.6263051860853015"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                target="_blank" style="text-decoration:
                                none;" moz-do-not-send="true">amd-gfx
                                Info Page - freedesktop.org</a></div>
                            <div
                              id="LPMetadata_15309280054360.6664147003914225"
                              style="margin: 10px 0px 16px; color:
                              rgb(102, 102, 102); font-weight: normal;
                              font-family: wf_segoe-ui_normal,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 14px;">
                              lists.freedesktop.org</div>
                            <div
                              id="LPDescription_15309280054370.5356504301440415"
                              style="display: block; color: rgb(102,
                              102, 102); font-weight: normal;
                              font-family: wf_segoe-ui_normal,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 20px;
                              max-height: 100px; overflow: hidden;">
                              Subscribing to amd-gfx: Subscribe to
                              amd-gfx by filling out the following form.
                              Use of all freedesktop.org lists is
                              subject to our Code of Conduct.</div>
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
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------0C17BF75225698FE681E7138--

--===============0339657317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0339657317==--

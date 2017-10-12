From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: TDR and VRAM lost handling in KMD (v2)
Date: Thu, 12 Oct 2017 13:49:54 +0200
Message-ID: <784b63e5-6dc3-0b22-c57b-3711ae89b6f8@amd.com>
References: <BLUPR12MB0449E6EBA74EC3EB8918F71E844B0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <759a6fe9-e90e-35e9-4c32-4e6a88a72b98@amd.com>
 <9d0f4ba2-da01-1229-106a-ad80822d8056@amd.com>
 <84255db0-bd9f-64ed-1394-3bf72d65adae@amd.com>
 <8c85e72f-a5c7-3c36-0f2d-be61de6f1a06@amd.com>
 <977779df-856e-54ae-6a75-8c48c72a262a@amd.com>
 <778f7851-c464-579b-74c7-dda6b5982244@daenzer.net>
 <cc6c86e7-d828-4376-0360-5c100fbfdd3d@amd.com>
 <5f671cec-0c69-509c-0f31-b4718c448ede@amd.com>
 <BLUPR12MB0449B1E12216845D4B52FC63844B0@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2132751610=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449B1E12216845D4B52FC63844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Cc: "Ramirez, Alejandro" <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Filipas,
 Mario" <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>, "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, "Li,
 Bingley" <Bingley.Li-5C7GfCeVMHo@public.gmane.org>, "Jiang, Jerry (SW)" <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============2132751610==
Content-Type: multipart/alternative;
 boundary="------------2FB8AD1BEB22FE55C5274B99"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2FB8AD1BEB22FE55C5274B99
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.10.2017 um 13:37 schrieb Liu, Monk:
> Hi team
> Very good, many policy and implement are agreed, looks we only have 
> some arguments in amdgpu_ctx_query(), well I also confused with the 
> current implement of it, ☹
> First, I want to know if you guys agree that we*don't update 
> ctx->reset_counter in amdgpu_ctx_query() *? because I want to make the 
> query result always consistent upon a given context,

That sounds like a good idea to me, but I'm not sure if it won't break 
userspace (I don't think so). Nicolai or Marek need to comment.

> Second, I want to say that for KERNEL, it shouldn't use the term from 
> MESA or OGL or VULKAN, e.g. kernel shouldn't use AMDGPU_INNOCENT_RESET 
> to map to GL_INNOCENT_RESET_ARB, etc...
> Because that way kernel will be very limited to certain UMD, so I 
> suggest we totally re-name the context status, and each UMD has its 
> own way to map the kernel context's result to gl-context/vk-context/etc…

Yes, completely agree.

> Kernel should only provide below **FLAG bits** on a given context:
>
>   * Define AMDGPU_CTX_STATE_GUILTY 0x1             //as long as TDR
>     detects a job hang, KMD set the context behind this context as
>     "guilty"
>   * Define AMDGPU_CTX_STATE_VRAMLOST         0x2      //as long as
>     there is a VRAM lost event hit after this context created, we mark
>     this context "VRAM_LOST", so UMD can say that all BO under this
>     context may lost their content, since kernel have no relationship
>     between context and BO so this is UMD's call to judge if a BO
>     considered "VRAM lost" or not.
>   * Define AMDGPU_CTX_STATE_RESET   0x3     //as long as there is a
>     gpu reset occurred after context creation, this flag shall be set
>

That sounds sane, but unfortunately might not be possible with the 
existing IOCTL. Keep in mind that we need to keep backward compatibility 
here.

> Sample code:
> Int amdgpu_ctx_query(struct amdgpu_ctx_query_parm * out, …..) {
>         if (ctx- >vram_lost_counter != adev->vram_lost_counter)
>                 out- >status |= AMDGPU_CTX_STATE_VRAM_LOST;
> if (ctx- >reset_counter != adev→reset_counter){
> out- >status |= AMDGPU_CTX_STATE_RESET;
> if (ctx- >guilty == TRUE)
>                         out- >status |= AMDGPU_CTX_STATE_GUILTY;
> }
> return 0;
> }
> For UMD if it found "out.status == 0" means there is no gpu reset even 
> occurred, the context is totally regular,
>
>   * *A****new IOCTL added for context:*
>
> Void amdgpu_ctx_reinit(){
>         Ctx→vram_lost_counter = adev→vram_lost_counter;
>         Ctx→reset_counter = adev→reset_counter;
> }

Mhm, is there any advantage to just creating a new context?

Regards,
Christian.

> *if**UMD decide *not* to release the "guilty" context but continue 
> using it **after**UMD acknowledged GPU hang **on certain job/context, 
> I suggest **UMD call "amdgpu_ctx_reinit()":*
> That way after you re-init() this context, you can get updated result 
> from "amdgpu_ctx_query", which will probably give you "out.status == 
> 0" as long as no gpu reset/vram lost hit after re-init().
> BR Monk
> -----Original Message-----
> From: Koenig, Christian
> Sent: 2017年10月12日 18:13
> To: Haehnle, Nicolai <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>; Michel Dänzer 
> <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Olsak, Marek 
> <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; 
> Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; Mao, David 
> <David.Mao-5C7GfCeVMHo@public.gmane.org>
> Cc: Ramirez, Alejandro <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Filipas, Mario <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>; 
> Ding, Pixel <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>; Li, Bingley <Bingley.Li-5C7GfCeVMHo@public.gmane.org>; 
> Jiang, Jerry (SW) <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: TDR and VRAM lost handling in KMD (v2)
> Am 12.10.2017 um 11:44 schrieb Nicolai Hähnle:
> > On 12.10.2017 11:35, Michel Dänzer wrote:
> >> On 12/10/17 11:23 AM, Christian König wrote:
> >>> Am 12.10.2017 um 11:10 schrieb Nicolai Hähnle:
> >>>> On 12.10.2017 10:49, Christian König wrote:
> >>>>>> However, !guilty && ctx->reset_counter != adev->reset_counter
> >>>>>> does not imply that the context was lost.
> >>>>>>
> >>>>>> The way I understand it, we should return
> >>>>>> AMDGPU_CTX_INNOCENT_RESET if !guilty && ctx->vram_lost_counter != adev->vram_lost_counter.
> >>>>>>
> >>>>>> As far as I understand it, the case of !guilty &&
> >>>>>> ctx->reset_counter != adev->reset_counter &&
> >>>>>> ctx->vram_lost_counter ==
> >>>>>> adev->vram_lost_counter should return AMDGPU_CTX_NO_RESET,
> >>>>>> adev->because a
> >>>>>> GPU reset occurred, but it didn't affect our context.
> >>>>> I disagree on that.
> >>>>>
> >>>>> AMDGPU_CTX_INNOCENT_RESET just means what it does currently, there
> >>>>> was a reset but we haven't been causing it.
> >>>>>
> >>>>> That the OpenGL extension is specified otherwise is unfortunate,
> >>>>> but I think we shouldn't use that for the kernel interface here.
> >>>> Two counterpoints:
> >>>>
> >>>> 1. Why should any application care that there was a reset while it
> >>>> was idle? The OpenGL behavior is what makes sense.
> >>>
> >>> The application is certainly not interest if a reset happened or
> >>> not, but I though that the driver stack might be.
> >>>
> >>>>
> >>>> 2. AMDGPU_CTX_INNOCENT_RESET doesn't actually mean anything today
> >>>> because we never return it :)
> >>>>
> >>>
> >>> Good point.
> >>>
> >>>> amdgpu_ctx_query only ever returns AMDGPU_CTX_UNKNOWN_RESET, which
> >>>> is in line with the OpenGL spec: we're conservatively returning
> >>>> that a reset happened because we don't know whether the context was
> >>>> affected, and we return UNKNOWN because we also don't know whether
> >>>> the context was guilty or not.
> >>>>
> >>>> Returning AMDGPU_CTX_NO_RESET in the case of !guilty &&
> >>>> ctx->vram_lost_counter == adev->vram_lost_counter is simply a
> >>>> refinement and improvement of the current, overly conservative
> >>>> behavior.
> >>>
> >>> Ok let's reenumerate what I think the different return values should
> >>> mean:
> >>>
> >>> * AMDGPU_CTX_GUILTY_RESET
> >>>
> >>> guilty is set to true for this context.
> >>>
> >>> * AMDGPU_CTX_INNOCENT_RESET
> >>>
> >>> guilty is not set and vram_lost_counter has changed.
> >>>
> >>> * AMDGPU_CTX_UNKNOWN_RESET
> >>>
> >>> guilty is not set and vram_lost_counter has not changed, but
> >>> gpu_reset_counter has changed.
> >>
> >> I don't understand the distinction you're proposing between
> >> AMDGPU_CTX_INNOCENT_RESET and AMDGPU_CTX_UNKNOWN_RESET. I think both
> >> cases you're describing should return either 
> >> AMDGPU_CTX_INNOCENT_RESET, if the value of guilty is reliable, or
> >> AMDGPU_CTX_UNKNOWN_RESET if it's not.
> >
> > I think it'd make more sense if it was called 
> > "AMDGPU_CTX_UNAFFECTED_RESET".
> >
> > So:
> > - AMDGPU_CTX_GUILTY_RESET --> the context was affected by a reset, and
> > we know that it's the context's fault
> > - AMDGPU_CTX_INNOCENT_RESET --> the context was affected by a reset,
> > and we know that it *wasn't* the context's fault (no context job
> > active)
> > - AMDGPU_CTX_UNKNOWN_RESET --> the context was affected by a reset,
> > and we don't know who's responsible (this could be returned in the
> > unlikely case where context A's gfx job has not yet finished, but
> > context B's gfx job has already started; it could be the fault of A,
> > it could be the fault of B -- which somehow manages to hang a part of
> > the hardware that then prevents A's job from finishing -- or it could
> > be both; but it's a bit academic)
> > - AMDGPU_CTX_UNAFFECTED_RESET --> there was a reset, but this context
> > wasn't affected
> >
> > This last value would currently just be discarded by Mesa (because we
> > should only disturb applications when we have to), but perhaps
> > somebody else could find it useful?
> Yes, that's what I had in mind as well.
> Cause otherwise we would return AMDGPU_CTX_NO_RESET while there 
> actually was a reset and that certainly doesn't sound correct to me.
> Regards,
> Christian.
> >
> > Cheers,
> > Nicolai



--------------2FB8AD1BEB22FE55C5274B99
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 12.10.2017 um 13:37 schrieb Liu,
      Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449B1E12216845D4B52FC63844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from rtf -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2" face="Calibri"><span style="font-size:10.5pt;">
          <div>Hi team</div>
          <div><font face="Times New Roman"> </font></div>
          <div>Very good, many policy and implement are agreed, looks we
            only have some arguments in amdgpu_ctx_query(), well I also
            confused with the current implement of it, <font
              face="Segoe UI Emoji">☹</font></div>
          <div><font face="Times New Roman"> </font></div>
          <div>First, I want to know if you guys agree that we<b> don't
              update ctx-&gt;reset_counter in amdgpu_ctx_query() </b>?
            because I want to make the query result always consistent
            upon a given context<font face="Courier New">,</font></div>
        </span></font></blockquote>
    <br>
    That sounds like a good idea to me, but I'm not sure if it won't
    break userspace (I don't think so). Nicolai or Marek need to
    comment.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449B1E12216845D4B52FC63844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"><font
        size="2" face="Calibri"><span style="font-size:10.5pt;">
          <div><font face="Times New Roman"> </font></div>
          <div>Second, I want to say that for KERNEL, it shouldn't use
            the term from MESA or OGL or VULKAN, e.g. kernel shouldn't
            use AMDGPU_INNOCENT_RESET to map to GL_INNOCENT_RESET_ARB,
            etc.<font face="Courier New">..</font></div>
          <div>Because that way kernel will be very limited to certain
            UMD, so I suggest we totally re-name the context status, and
            each UMD has its own way to map the kernel context's result
            to gl-context/vk-context/etc<font face="Courier New">…</font></div>
        </span></font></blockquote>
    <br>
    Yes, completely agree.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449B1E12216845D4B52FC63844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"><font
        size="2" face="Calibri"><span style="font-size:10.5pt;">
          <div><font face="Times New Roman"> </font></div>
          <div>Kernel should only provide below *<b>FLAG bits</b>* on a
            given context:</div>
          <div><font face="Times New Roman"> </font></div>
          <ul style="margin:0;padding-left:21pt;">
            <li>Define AMDGPU_CTX_STATE_GUILTY 0x1             //as long
              as TDR detects a job hang, KMD set the context behind this
              context as "guilty"</li>
            <li>Define AMDGPU_CTX_STATE_VRAMLOST         0x2      //as
              long as there is a VRAM lost event hit after this context
              created, we mark this context "VRAM_LOST", so UMD can say
              that all BO under this context may lost their content, 
              since kernel have no relationship
              between context and BO so this is UMD's call to judge if a
              BO considered "VRAM lost" or not.</li>
            <li>Define AMDGPU_CTX_STATE_RESET   0x3     //as long as
              there is a gpu reset occurred after context creation, this
              flag shall be set</li>
          </ul>
        </span></font></blockquote>
    <br>
    That sounds sane, but unfortunately might not be possible with the
    existing IOCTL. Keep in mind that we need to keep backward
    compatibility here. <br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449B1E12216845D4B52FC63844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"><font
        size="2" face="Calibri"><span style="font-size:10.5pt;">
          <div><font face="Times New Roman"> </font></div>
          <div>Sample code:</div>
          <div> </div>
          <div>Int amdgpu_ctx_query(struct amdgpu_ctx_query_parm * out,
            <font face="Courier New">…</font><font face="Courier New">..</font>)
            {</div>
          <div>        if (ctx- &gt;vram_lost_counter !=
            adev-&gt;vram_lost_counter)</div>
          <div>                out- &gt;status |=
            AMDGPU_CTX_STATE_VRAM_LOST;</div>
          <div><font face="Times New Roman"> </font></div>
          <div><font face="Times New Roman">        <font
                face="Calibri">if (ctx- &gt;reset_counter != adev</font><font
                face="等线">→</font><font face="Calibri">reset_counter)</font><font
                face="Calibri"> {</font></font></div>
          <div><font face="Times New Roman">                <font
                face="Calibri">out- &gt;status |=
                AMDGPU_CTX_STATE_RESET;</font></font></div>
          <div><font face="Times New Roman"> </font></div>
          <div><font face="Times New Roman">                <font
                face="Calibri">if (ctx- &gt;guilty == TRUE)</font></font></div>
          <div>                        out- &gt;status |=
            AMDGPU_CTX_STATE_GUILTY;</div>
          <div><font face="Times New Roman">        <font face="Courier
                New">}</font></font></div>
          <div><font face="Times New Roman"> </font></div>
          <div><font face="Times New Roman">        <font
                face="Calibri">return 0;</font></font></div>
          <div>}</div>
          <div><font face="Times New Roman"> </font></div>
          <div>For UMD if it found "out.status == 0" means there is no
            gpu reset even occurred, the context is totally regular<font
              face="Courier New">,</font></div>
          <div><font face="Times New Roman"> </font></div>
          <ul style="margin:0;padding-left:21pt;">
            <li><b>A</b><b> </b><b>new IOCTL added for context:</b></li>
          </ul>
          <div style="padding-left:21pt;"><font face="Times New Roman"> </font></div>
          <div>Void amdgpu_ctx_reinit(){</div>
          <div>        Ctx<font face="等线">→</font>vram_lost_counter =
            adev<font face="等线">→</font>vram_lost_counter;</div>
          <div>        Ctx<font face="等线">→</font>reset_counter = adev<font
              face="等线">→</font>reset_counter;</div>
          <div><font face="Courier New">}</font></div>
        </span></font></blockquote>
    <br>
    Mhm, is there any advantage to just creating a new context?<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449B1E12216845D4B52FC63844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"><font
        size="2" face="Calibri"><span style="font-size:10.5pt;">
          <div><font face="Times New Roman"> </font></div>
          <div><font face="Times New Roman"> </font></div>
          <div><b>if</b><b> UMD decide *not* to release the "guilty"
              context but continue using it </b><b>after</b><b> UMD
              acknowledged GPU hang </b><b>on certain job/context, I
              suggest </b><b>UMD call "amdgpu_ctx_reinit()":</b></div>
          <div><font face="Times New Roman"> </font></div>
          <div>That way after you re<font face="Courier New">-</font>init()
            this context, you can get updated result from
            "amdgpu_ctx_query", which will probably give you "out.status
            == 0" as long as no gpu reset/vram lost hit after re-init()<font
              face="Courier New">.</font></div>
          <div><font face="Times New Roman"> </font></div>
          <div>BR Monk</div>
          <div><font face="Times New Roman"> </font></div>
          <div><font face="Times New Roman"> </font></div>
          <div>-----Original Message-----<br>
            From: Koenig, Christian <br>
            Sent: 2017<font face="等线">年</font>10<font face="等线">月</font>12<font
              face="等线">日</font> 18:13<br>
            To: Haehnle, Nicolai <a class="moz-txt-link-rfc2396E" href="mailto:Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org">&lt;Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org&gt;</a>; Michel
            D<font face="Courier New">ä</font>nzer
            <a class="moz-txt-link-rfc2396E" href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">&lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;</a>; Liu, Monk
            <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; Olsak, Marek
            <a class="moz-txt-link-rfc2396E" href="mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org">&lt;Marek.Olsak-5C7GfCeVMHo@public.gmane.org&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>; Zhou, David(ChunMing)
            <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>;
            Mao, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org">&lt;David.Mao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            Cc: Ramirez, Alejandro <a class="moz-txt-link-rfc2396E" href="mailto:Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org">&lt;Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Filipas, Mario
            <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Filipas-5C7GfCeVMHo@public.gmane.org">&lt;Mario.Filipas-5C7GfCeVMHo@public.gmane.org&gt;</a>; Ding, Pixel
            <a class="moz-txt-link-rfc2396E" href="mailto:Pixel.Ding-5C7GfCeVMHo@public.gmane.org">&lt;Pixel.Ding-5C7GfCeVMHo@public.gmane.org&gt;</a>; Li, Bingley
            <a class="moz-txt-link-rfc2396E" href="mailto:Bingley.Li-5C7GfCeVMHo@public.gmane.org">&lt;Bingley.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>; Jiang, Jerry (SW)
            <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Jiang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Jiang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            Subject: Re: TDR and VRAM lost handling in KMD (v2)</div>
          <div><font face="Times New Roman"> </font></div>
          <div>Am 12.10.2017 um 11:44 schrieb Nicolai H<font
              face="Courier New">ä</font>hnle:</div>
          <div>&gt; On 12.10.2017 11:35, Michel D<font face="Courier
              New">ä</font>nzer wrote:</div>
          <div>&gt;&gt; On 12/10/17 11:23 AM, Christian K<font
              face="Courier New">ö</font>nig wrote:</div>
          <div>&gt;&gt;&gt; Am 12.10.2017 um 11:10 schrieb Nicolai H<font
              face="Courier New">ä</font>hnle:</div>
          <div>&gt;&gt;&gt;&gt; On 12.10.2017 10:49, Christian K<font
              face="Courier New">ö</font>nig wrote:</div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; However, !guilty &amp;&amp;
            ctx-&gt;reset_counter != adev-&gt;reset_counter </div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; does not imply that the context
            was lost.</div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; The way I understand it, we
            should return </div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; AMDGPU_CTX_INNOCENT_RESET if
            !guilty &amp;&amp; ctx-&gt;vram_lost_counter !=
            adev-&gt;vram_lost_counter.</div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; As far as I understand it, the
            case of !guilty &amp;&amp; </div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; ctx-&gt;reset_counter !=
            adev-&gt;reset_counter &amp;&amp; </div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; ctx-&gt;vram_lost_counter ==</div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; adev-&gt;vram_lost_counter
            should return AMDGPU_CTX_NO_RESET, </div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; adev-&gt;because a</div>
          <div>&gt;&gt;&gt;&gt;&gt;&gt; GPU reset occurred, but it
            didn't affect our context.</div>
          <div>&gt;&gt;&gt;&gt;&gt; I disagree on that.</div>
          <div>&gt;&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt;&gt; AMDGPU_CTX_INNOCENT_RESET just means
            what it does currently, there </div>
          <div>&gt;&gt;&gt;&gt;&gt; was a reset but we haven't been
            causing it.</div>
          <div>&gt;&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt;&gt; That the OpenGL extension is
            specified otherwise is unfortunate, </div>
          <div>&gt;&gt;&gt;&gt;&gt; but I think we shouldn't use that
            for the kernel interface here.</div>
          <div>&gt;&gt;&gt;&gt; Two counterpoints:</div>
          <div>&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt; 1. Why should any application care that
            there was a reset while it </div>
          <div>&gt;&gt;&gt;&gt; was idle? The OpenGL behavior is what
            makes sense.</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; The application is certainly not interest if
            a reset happened or </div>
          <div>&gt;&gt;&gt; not, but I though that the driver stack
            might be.</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt; 2. AMDGPU_CTX_INNOCENT_RESET doesn't
            actually mean anything today </div>
          <div>&gt;&gt;&gt;&gt; because we never return it :)</div>
          <div>&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; Good point.</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt; amdgpu_ctx_query only ever returns
            AMDGPU_CTX_UNKNOWN_RESET, which </div>
          <div>&gt;&gt;&gt;&gt; is in line with the OpenGL spec: we're
            conservatively returning </div>
          <div>&gt;&gt;&gt;&gt; that a reset happened because we don't
            know whether the context was </div>
          <div>&gt;&gt;&gt;&gt; affected, and we return UNKNOWN because
            we also don't know whether </div>
          <div>&gt;&gt;&gt;&gt; the context was guilty or not.</div>
          <div>&gt;&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt;&gt; Returning AMDGPU_CTX_NO_RESET in the
            case of !guilty &amp;&amp;</div>
          <div>&gt;&gt;&gt;&gt; ctx-&gt;vram_lost_counter ==
            adev-&gt;vram_lost_counter is simply a</div>
          <div>&gt;&gt;&gt;&gt; refinement and improvement of the
            current, overly conservative </div>
          <div>&gt;&gt;&gt;&gt; behavior.</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; Ok let's reenumerate what I think the
            different return values should</div>
          <div>&gt;&gt;&gt; mean:</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; * AMDGPU_CTX_GUILTY_RESET</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; guilty is set to true for this context.</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; * AMDGPU_CTX_INNOCENT_RESET</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; guilty is not set and vram_lost_counter has
            changed.</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; * AMDGPU_CTX_UNKNOWN_RESET</div>
          <div>&gt;&gt;&gt;</div>
          <div>&gt;&gt;&gt; guilty is not set and vram_lost_counter has
            not changed, but </div>
          <div>&gt;&gt;&gt; gpu_reset_counter has changed.</div>
          <div>&gt;&gt;</div>
          <div>&gt;&gt; I don't understand the distinction you're
            proposing between </div>
          <div>&gt;&gt; AMDGPU_CTX_INNOCENT_RESET and
            AMDGPU_CTX_UNKNOWN_RESET. I think both </div>
          <div>&gt;&gt; cases you're describing should return either </div>
          <div>&gt;&gt; AMDGPU_CTX_INNOCENT_RESET, if the value of
            guilty is reliable, or </div>
          <div>&gt;&gt; AMDGPU_CTX_UNKNOWN_RESET if it's not.</div>
          <div>&gt;</div>
          <div>&gt; I think it'd make more sense if it was called </div>
          <div>&gt; "AMDGPU_CTX_UNAFFECTED_RESET".</div>
          <div>&gt;</div>
          <div>&gt; So:</div>
          <div>&gt; - AMDGPU_CTX_GUILTY_RESET --&gt; the context was
            affected by a reset, and </div>
          <div>&gt; we know that it's the context's fault</div>
          <div>&gt; - AMDGPU_CTX_INNOCENT_RESET --&gt; the context was
            affected by a reset, </div>
          <div>&gt; and we know that it *wasn't* the context's fault (no
            context job </div>
          <div>&gt; active)</div>
          <div>&gt; - AMDGPU_CTX_UNKNOWN_RESET --&gt; the context was
            affected by a reset, </div>
          <div>&gt; and we don't know who's responsible (this could be
            returned in the </div>
          <div>&gt; unlikely case where context A's gfx job has not yet
            finished, but </div>
          <div>&gt; context B's gfx job has already started; it could be
            the fault of A, </div>
          <div>&gt; it could be the fault of B -- which somehow manages
            to hang a part of </div>
          <div>&gt; the hardware that then prevents A's job from
            finishing -- or it could </div>
          <div>&gt; be both; but it's a bit academic)</div>
          <div>&gt; - AMDGPU_CTX_UNAFFECTED_RESET --&gt; there was a
            reset, but this context </div>
          <div>&gt; wasn't affected</div>
          <div>&gt;</div>
          <div>&gt; This last value would currently just be discarded by
            Mesa (because we </div>
          <div>&gt; should only disturb applications when we have to),
            but perhaps </div>
          <div>&gt; somebody else could find it useful?</div>
          <div> </div>
          <div>Yes, that's what I had in mind as well.</div>
          <div> </div>
          <div>Cause otherwise we would return AMDGPU_CTX_NO_RESET while
            there actually was a reset and that certainly doesn't sound
            correct to me.</div>
          <div> </div>
          <div>Regards,</div>
          <div>Christian.</div>
          <div> </div>
          <div>&gt;</div>
          <div>&gt; Cheers,</div>
          <div>&gt; Nicolai</div>
          <div> </div>
          <div><font face="Times New Roman"> </font></div>
          <div><font face="Times New Roman"> </font></div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------2FB8AD1BEB22FE55C5274B99--

--===============2132751610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2132751610==--

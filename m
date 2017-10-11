From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: TDR and VRAM lost handling in KMD:
Date: Wed, 11 Oct 2017 09:20:44 +0200
Message-ID: <b5c5f6c9-07e2-4688-8ffc-3929bfc59366@amd.com>
References: <BLUPR12MB0449785160E34EA9369C5E23844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0769686821=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Ramirez, Alejandro" <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Filipas,
 Mario" <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>, "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, "Li,
 Bingley" <Bingley.Li-5C7GfCeVMHo@public.gmane.org>, "Jiang, Jerry (SW)" <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0769686821==
Content-Type: multipart/alternative;
 boundary="------------8567224A1A98777C69BFFDB5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8567224A1A98777C69BFFDB5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

See inline:

Am 11.10.2017 um 07:33 schrieb Liu, Monk:
>
> Hi Christian & Nicolai,
>
> We need to achieve some agreements on what should MESA/UMD do and what 
> should KMD do, *please give your comments with “okay” or “No” and your 
> idea on below items,*
>
> lWhen a job timed out (set from lockup_timeout kernel parameter), What 
> KMD should do in TDR routine :
>
> 1.Update adev->*gpu_reset_counter*, and stop scheduler first, 
> (*gpu_reset_counter* is used to force vm flush after GPU reset, out of 
> this thread’s scope so no more discussion on it)
>
Okay.

> 2.Set its fence error status to “*ETIME*”,
>
No, as I already explained ETIME is for synchronous operation.

In other words when we return ETIME from the wait IOCTL it would mean 
that the waiting has somehow timed out, but not the job we waited for.

Please use ECANCELED as well or some other error code when we find that 
we need to distinct the timedout job from the canceled ones (probably a 
good idea, but I'm not sure).

> 3.Find the entity/ctx behind this job, and set this ctx as “*guilty*”
>
Not sure. Do we want to set the whole context as guilty or just the entity?

Setting the whole contexts as guilty sounds racy to me.

BTW: We should use a different name than "guilty", maybe just "bool 
canceled;" ?

> 4.Kick out this job from scheduler’s mirror list, so this job won’t 
> get re-scheduled to ring anymore.
>
Okay.

> 5.Kick out all jobs in this “guilty” ctx’s KFIFO queue, and set all 
> their fence status to “*ECANCELED*”
>
Setting ECANCELED should be ok. But I think we should do this when we 
try to run the jobs and not during GPU reset.

> *6.*Force signal all fences that get kicked out by above two 
> steps,*otherwise UMD will block forever if waiting on those fences*
>
Okay.

> **
>
> 7.Do gpu reset, which is can be some callbacks to let bare-metal and 
> SR-IOV implement with their favor style
>
Okay.

> 8.After reset, KMD need to aware if the VRAM lost happens or not, 
> bare-metal can implement some function to judge, while for SR-IOV I 
> prefer to read it from GIM side (for initial version we consider it’s 
> always VRAM lost, till GIM side change aligned)
>
Okay.

> 9.If VRAM lost not hit, continue, otherwise:
>
> a)Update adev->*vram_lost_counter*,
>
Okay.

> b)Iterate over all living ctx, and set all ctx as “*guilty*” since 
> VRAM lost actually ruins all VRAM contents
>
No, that shouldn't be done by comparing the counters. Iterating over all 
contexts is way to much overhead.

> c)Kick out all jobs in all ctx’s KFIFO queue, and set all their fence 
> status to “*ECANCELDED*”
>
Yes and no, that should be done when we try to run the jobs and not 
during GPU reset.

> 10.Do GTT recovery and VRAM page tables/entries recovery (optional, do 
> we need it ???)
>
Yes, that is still needed. As Nicolai explained we can't be sure that 
VRAM is still 100% correct even when it isn't cleared.

> 11.Re-schedule all JOBs remains in mirror list to ring again and 
> restart scheduler (for VRAM lost case, no JOB will re-scheduled)
>
Okay.

> lFor cs_wait() IOCTL:
>
> After it found fence signaled, it should check with 
> *“dma_fence_get_status” *to see if there is error there,
>
> And return the error status of fence
>
Yes and no, dma_fence_get_status() is some specific handling for 
sync_file debugging (no idea why that made it into the common fence code).

It was replaced by putting the error code directly into the fence, so 
just reading that one after waiting should be ok.

Maybe we should fix dma_fence_get_status() to do the right thing for this?

> lFor cs_wait_fences() IOCTL:
>
> Similar with above approach
>
> lFor cs_submit() IOCTL:
>
> It need to check if current ctx been marked as “*guilty*” and return 
> “*ECANCELED*” if so
>
> lIntroduce a new IOCTL to let UMD query *vram_lost_counter*:
>
> This way, UMD can also block app from submitting, like @Nicolai 
> mentioned, we can cache one copy of *vram_lost_counter* when enumerate 
> physical device, and deny all
>
> gl-context from submitting if the counter queried bigger than that one 
> cached in physical device. (looks a little overkill to me, but easy to 
> implement )
>
> UMD can also return error to APP when creating gl-context if found 
> current queried*vram_lost_counter *bigger than that one cached in 
> physical device.
>
Okay. Already have a patch for this, please review that one if you 
haven't already done so.

Regards,
Christian.

> BTW: I realized that gl-context is a little different with kernel’s 
> context. Because for kernel. BO is not related with context but only 
> with FD, while in UMD, BO have a backend
>
> gl-context, so block submitting in UMD layer is also needed although 
> KMD will do its job as bottom line
>
> lBasically “vram_lost_counter” is exposure by kernel to let UMD take 
> the control of robust extension feature, it will be UMD’s call to 
> move, KMD only deny “guilty” context from submitting
>
> Need your feedback, thx
>
> We’d better make TDR feature landed ASAP
>
> BR Monk
>


--------------8567224A1A98777C69BFFDB5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">See inline:<br>
      <br>
      Am 11.10.2017 um 07:33 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:等线;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:等线;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:等线;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:等线;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:65107788;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l1
	{mso-list-id:697632068;
	mso-list-type:hybrid;
	mso-list-template-ids:448443560 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2
	{mso-list-id:811288099;
	mso-list-type:hybrid;
	mso-list-template-ids:-475358778 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3
	{mso-list-id:2108235941;
	mso-list-type:hybrid;
	mso-list-template-ids:1215617064 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span lang="EN-US">Hi Christian &amp;
            Nicolai,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">We need to achieve some
            agreements on what should MESA/UMD do and what should KMD
            do,
            <b>please give your comments with “okay” or “No” and your
              idea on below items,</b><o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo4">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">When
            a job timed out (set from lockup_timeout kernel parameter),
            What KMD should do in TDR routine :<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Update
            adev-&gt;<b>gpu_reset_counter</b>, and stop scheduler first,
            (<b>gpu_reset_counter</b> is used to force vm flush after
            GPU reset, out of this thread’s scope so no more discussion
            on it)</span></p>
      </div>
    </blockquote>
    Okay.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">2.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Set
            its fence error status to “<b>ETIME</b>”,</span></p>
      </div>
    </blockquote>
    No, as I already explained ETIME is for synchronous operation.<br>
    <br>
    In other words when we return ETIME from the wait IOCTL it would
    mean that the waiting has somehow timed out, but not the job we
    waited for.<br>
    <br>
    Please use ECANCELED as well or some other error code when we find
    that we need to distinct the timedout job from the canceled ones
    (probably a good idea, but I'm not sure).<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">3.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Find
            the entity/ctx behind this job, and set this ctx as “<b>guilty</b>”</span></p>
      </div>
    </blockquote>
    Not sure. Do we want to set the whole context as guilty or just the
    entity?<br>
    <br>
    Setting the whole contexts as guilty sounds racy to me.<br>
    <br>
    BTW: We should use a different name than "guilty", maybe just "bool
    canceled;" ?<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">4.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Kick
            out this job from scheduler’s mirror list, so this job won’t
            get re-scheduled to ring anymore.</span></p>
      </div>
    </blockquote>
    Okay.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">5.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Kick
            out all jobs in this “guilty” ctx’s KFIFO queue, and set all
            their fence status to “<b>ECANCELED</b>”</span></p>
      </div>
    </blockquote>
    Setting ECANCELED should be ok. But I think we should do this when
    we try to run the jobs and not during GPU reset.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><b><span lang="EN-US"><span
                style="mso-list:Ignore">6.<span style="font:7.0pt
                  &quot;Times New Roman&quot;">      
                </span></span></span></b><!--[endif]--><span
            lang="EN-US">Force signal all fences that get kicked out by
            above two steps,<b> otherwise UMD will block forever if
              waiting on those fences</b></span></p>
      </div>
    </blockquote>
    Okay.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><b><o:p></o:p></b></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">7.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Do
            gpu reset, which is can be some callbacks to let bare-metal
            and SR-IOV implement with their favor style
          </span></p>
      </div>
    </blockquote>
    Okay.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">8.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">After
            reset, KMD need to aware if the VRAM lost happens or not,
            bare-metal can implement some function to judge, while for
            SR-IOV I prefer to read it from GIM side (for initial
            version we consider it’s always VRAM lost, till GIM side
            change aligned)</span></p>
      </div>
    </blockquote>
    Okay.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">9.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">If
            VRAM lost not hit, continue, otherwise:<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">a)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">Update
            adev-&gt;<b>vram_lost_counter</b>,</span></p>
      </div>
    </blockquote>
    Okay.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">b)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">Iterate
            over all living ctx, and set all ctx as “<b>guilty</b>”
            since VRAM lost actually ruins all VRAM contents</span></p>
      </div>
    </blockquote>
    No, that shouldn't be done by comparing the counters. Iterating over
    all contexts is way to much overhead.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">c)<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Kick
            out all jobs in all ctx’s KFIFO queue, and set all their
            fence status to “<b>ECANCELDED</b>”</span></p>
      </div>
    </blockquote>
    Yes and no, that should be done when we try to run the jobs and not
    during GPU reset.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">10.<span style="font:7.0pt
                &quot;Times New Roman&quot;">    
              </span></span></span><!--[endif]--><span lang="EN-US">Do
            GTT recovery and VRAM page tables/entries recovery
            (optional, do we need it ???)</span></p>
      </div>
    </blockquote>
    Yes, that is still needed. As Nicolai explained we can't be sure
    that VRAM is still 100% correct even when it isn't cleared.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">11.<span style="font:7.0pt
                &quot;Times New Roman&quot;">    
              </span></span></span><!--[endif]--><span lang="EN-US">Re-schedule
            all JOBs remains in mirror list to ring again and restart
            scheduler (for VRAM lost case, no JOB will re-scheduled)</span></p>
      </div>
    </blockquote>
    Okay.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo3"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo4">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_wait() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">After it found fence
            signaled, it should check with
            <b>“dma_fence_get_status” </b>to see if there is error
            there,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">And return the error
            status of fence</span></p>
      </div>
    </blockquote>
    Yes and no, dma_fence_get_status() is some specific handling for
    sync_file debugging (no idea why that made it into the common fence
    code).<br>
    <br>
    It was replaced by putting the error code directly into the fence,
    so just reading that one after waiting should be ok.<br>
    <br>
    Maybe we should fix dma_fence_get_status() to do the right thing for
    this?<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoNormal"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo4">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_wait_fences() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Similar with above
            approach<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo4">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_submit() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">It need to check if
            current ctx been marked as “<b>guilty</b>” and return “<b>ECANCELED</b>”
            if so<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo4">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Introduce
            a new IOCTL to let UMD query
            <b>vram_lost_counter</b>:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">This way, UMD can also
            block app from submitting, like @Nicolai mentioned, we can
            cache one copy of
            <b>vram_lost_counter</b> when enumerate physical device, and
            deny all <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">gl-context from
            submitting if the counter queried bigger than that one
            cached in physical device. (looks a little overkill to me,
            but easy to implement )
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">UMD can also return
            error to APP when creating gl-context if found current
            queried<b> vram_lost_counter
            </b>bigger than that one cached in physical device.</span></p>
      </div>
    </blockquote>
    Okay. Already have a patch for this, please review that one if you
    haven't already done so.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449785160E34EA9369C5E23844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div class="WordSection1">
        <p class="MsoNormal"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">BTW: I realized that
            gl-context is a little different with kernel’s context.
            Because for kernel. BO is not related with context but only
            with FD, while in UMD, BO have a backend<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">gl-context, so block
            submitting in UMD layer is also needed although KMD will do
            its job as bottom line
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo4">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Basically
            “vram_lost_counter” is exposure by kernel to let UMD take
            the control of robust extension feature, it will be UMD’s
            call to move, KMD only deny “guilty” context from submitting<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Need your feedback, thx<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">We’d better make TDR
            feature landed ASAP<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">BR Monk<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------8567224A1A98777C69BFFDB5--

--===============0769686821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0769686821==--

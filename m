From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: TDR and VRAM lost handling in KMD (v2)
Date: Thu, 12 Oct 2017 10:40:47 +0200
Message-ID: <f8946032-9ce6-9f36-ad03-cc5a3160dda5@amd.com>
References: <BLUPR12MB0449E6EBA74EC3EB8918F71E844B0@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0867225096=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449E6EBA74EC3EB8918F71E844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Cc: "Ramirez, Alejandro" <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Filipas,
 Mario" <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>, "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, "Li,
 Bingley" <Bingley.Li-5C7GfCeVMHo@public.gmane.org>, "Jiang, Jerry (SW)" <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0867225096==
Content-Type: multipart/alternative;
 boundary="------------09BC02B5C0020074A275B462"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------09BC02B5C0020074A275B462
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, that sounds like a plan to me.

Going to commit the patches I've already done in a minute, they still 
seem to implement quite a bit of what we want to do here.

Regards,
Christian.

Am 12.10.2017 um 10:03 schrieb Liu, Monk:
>
> V2 summary
>
> Hi team
>
> *please give your comments*
>
> lWhen a job timed out (set from lockup_timeout kernel parameter), What 
> KMD should do in TDR routine :
>
> 1.Update adev->*gpu_reset_counter*, and stop scheduler first
>
> 2.Set its fence error status to “*ECANCELED*”,
>
> 3.Find the *context* behind this job, and set this *context* as 
> “*guilty*”(will have a new member field in context structure – *bool 
> guilty*)
>
> a)There will be “*bool * guilty*” in entity structure, which points to 
> its father context’s member – “*bool guilty” *when context 
> initialized**, so no matter we get context or entity, we always know 
> if it is “guilty”
>
> b)For kernel entity that used for VM updates, there is no context back 
> it, so kernel entity’s “bool *guilty” always “NULL”.
>
> c)The idea to skip the whole context is for consistence consideration, 
> because we’ll fake signal the hang job in job_run(), so all jobs in 
> its context shall be dropped otherwise either bad drawing/computing 
> results or more GPU hang.
>
> **
>
> 4.Do GPU reset, which is can be some callbacks to let bare-metal and 
> SR-IOV implement with their favor style
>
> 5.After reset, KMD need to aware if the VRAM lost happens or not, 
> bare-metal can implement some function to judge, while for SR-IOV I 
> prefer to read it from GIM side (for initial version we consider it’s 
> always VRAM lost, till GIM side change aligned)
>
> 6.If VRAM lost hit, update adev->*vram_lost_counter*.
>
> 7.Do GTT recovery and shadow buffer recovery.
>
> 8.Re-schedule all JOBs in mirror list and restart scheduler
>
> lFor GPU scheduler function --- job_run()
>
> 1.Before schedule a job to ring, checks if job->*vram_lost_counter* == 
> adev->*vram_lost_counter*, and drop this job if mismatch
>
> 2.Before schedule a job to ring, checks if job->entity->*guilty* is 
> NULL or not, *and drop this job if (guilty!=NULL && *guilty == TRUE)*
>
> 3.if a job is dropped:
>
> a)set job’s sched_fence status to “*ECANCELED*”
>
> b)fake/force signal job’s hw fence (no need to set hw fence’s status)
>
> lFor cs_wait() IOCTL:
>
> After it found fence signaled, it should check if there is error on 
> this fence and return the error status of this fence
>
> lFor cs_wait_fences() IOCTL:
>
> Similar with above approach
>
> lFor cs_submit() IOCTL:
>
> 1.check if current ctx been marked “*guilty*”and return “*ECANCELED*” 
>  if so.
>
> 2.set job->*vram_lost_counter* with adev->*vram_lost_counter*, and 
> return “*ECANCELED*” if ctx->*vram_lost_counter* != 
> job->*vram_lost_counter* (Christian already submitted this patch)
>
> a)discussion: can we return “ENODEV” if vram_lost_counter mismatch ? 
> that way UMD know this context is under “device lost”
>
> lIntroduce a new IOCTL to let UMD query latest adev->*vram_lost_counter*:
>
> lFor amdgpu_ctx_query():
>
> n*Don’t update ctx->reset_counter when querying this function, 
> otherwise the query result is not consistent *
>
> nSet out->state.reset_status to “AMDGPU_CTX_GUILTY_RESET” if the ctx 
> is “*guilty*”, no need to check “ctx->reset_counter”
>
> nSet out->state.reset_status to “AMDGPU_CTX_INNOCENT_RESET” *if the 
> ctx isn’t “guilty” && ctx->reset_counter != adev->reset_counter *
>
> nSet out->state.reset_status to “AMDGPU_CTX_NO_RESET” if 
> ctx->reset_counter == adev->reset_counter
>
> nSet out->state.flags to “AMDGPU_CTX_FLAG_VRAM_LOST” if 
> ctx->vram_lost_counter != adev->vram_lost_counter
>
> udiscussion: can we return “ENODEV” for amdgpu_ctx_query() if 
> ctx->vram_lost_counter != adev->vram_lost_counter ? that way UMD know 
> this context is under “device lost”
>
> nUMD shall release this context if it is AMDGPU_CTX_GUILTY_RESET or 
> its flags is “AMDGPU_CTX_FLAG_VRAM_LOST”
>
> For UMD behavior we still have something need to consider:
>
> If MESA creates a new context from an old context (share list?? I’m 
> not familiar with UMD , David Mao shall have some discuss on it with 
> Nicolai), the new created context’s vram_lost_counter
>
> And reset_counter shall all be ported from that old context , 
> otherwise CS_SUBMIT will not block it which isn’t correct
>
> Need your feedback, thx
>
> *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On 
> Behalf Of *Liu, Monk
> *Sent:* 2017年10月11日13:34
> *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Haehnle, Nicolai 
> <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>; Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>; 
> Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> *Cc:* Ramirez, Alejandro <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Filipas, Mario <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>; 
> Ding, Pixel <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>; Li, Bingley <Bingley.Li-5C7GfCeVMHo@public.gmane.org>; 
> Jiang, Jerry (SW) <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>
> *Subject:* TDR and VRAM lost handling in KMD:
>
> Hi Christian & Nicolai,
>
> We need to achieve some agreements on what should MESA/UMD do and what 
> should KMD do, *please give your comments with **“okay”or “No”and your 
> idea on below items,*
>
> lWhen a job timed out (set from lockup_timeout kernel parameter), What 
> KMD should do in TDR routine :
>
> 1.Update adev->*gpu_reset_counter*, and stop scheduler first, 
> (*gpu_reset_counter* is used to force vm flush after GPU reset, out of 
> this thread’s scope so no more discussion on it)
>
> 2.Set its fence error status to “*ETIME*”,
>
> 3.Find the entity/ctx behind this job, and set this ctx as “*guilty*”
>
> 4.Kick out this job from scheduler’s mirror list, so this job won’t 
> get re-scheduled to ring anymore.
>
> 5.Kick out all jobs in this “guilty”ctx’s KFIFO queue, and set all 
> their fence status to “*ECANCELED*”
>
> *6.*Force signal all fences that get kicked out by above two 
> steps,*otherwise UMD will block forever if waiting on those fences*
>
> 7.Do gpu reset, which is can be some callbacks to let bare-metal and 
> SR-IOV implement with their favor style
>
> 8.After reset, KMD need to aware if the VRAM lost happens or not, 
> bare-metal can implement some function to judge, while for SR-IOV I 
> prefer to read it from GIM side (for initial version we consider it’s 
> always VRAM lost, till GIM side change aligned)
>
> 9.If VRAM lost not hit, continue, otherwise:
>
> a)Update adev->*vram_lost_counter*,
>
> b)Iterate over all living ctx, and set all ctx as “*guilty*”since VRAM 
> lost actually ruins all VRAM contents
>
> c)Kick out all jobs in all ctx’s KFIFO queue, and set all their fence 
> status to “*ECANCELDED*”
>
> 10.Do GTT recovery and VRAM page tables/entries recovery (optional, do 
> we need it ???)
>
> 11.Re-schedule all JOBs remains in mirror list to ring again and 
> restart scheduler (for VRAM lost case, no JOB will re-scheduled)
>
> lFor cs_wait() IOCTL:
>
> After it found fence signaled, it should check with 
> *“dma_fence_get_status” *to see if there is error there,
>
> And return the error status of fence
>
> lFor cs_wait_fences() IOCTL:
>
> Similar with above approach
>
> lFor cs_submit() IOCTL:
>
> It need to check if current ctx been marked as “*guilty*”and return 
> “*ECANCELED*”if so
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
> BTW: I realized that gl-context is a little different with kernel’s 
> context. Because for kernel. BO is not related with context but only 
> with FD, while in UMD, BO have a backend
>
> gl-context, so block submitting in UMD layer is also needed although 
> KMD will do its job as bottom line
>
> lBasically “vram_lost_counter”is exposure by kernel to let UMD take 
> the control of robust extension feature, it will be UMD’s call to 
> move, KMD only deny “guilty”context from submitting
>
> Need your feedback, thx
>
> We’d better make TDR feature landed ASAP
>
> BR Monk
>


--------------09BC02B5C0020074A275B462
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yeah, that sounds like a plan to me.<br>
      <br>
      Going to commit the patches I've already done in a minute, they
      still seem to implement quite a bit of what we want to do here.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 12.10.2017 um 10:03 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449E6EBA74EC3EB8918F71E844B0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@宋体";
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:宋体;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:等线;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:等线;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
	{mso-list-id:236406344;
	mso-list-type:hybrid;
	mso-list-template-ids:-73740254 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l2
	{mso-list-id:423769606;
	mso-list-type:hybrid;
	mso-list-template-ids:-1895020312 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:210.0pt;
	text-indent:-21.0pt;}
@list l3
	{mso-list-id:697632068;
	mso-list-type:hybrid;
	mso-list-template-ids:19056858 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
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
@list l4
	{mso-list-id:1273434182;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l4:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l4:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l4:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l4:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l4:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l4:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l4:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l4:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l4:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
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
        <p class="MsoNormal"><span lang="EN-US">V2 summary<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Hi team<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><b><span lang="EN-US">please give your
              comments</span></b><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">When
            a job timed out (set from lockup_timeout kernel parameter),
            What KMD should do in TDR routine :<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Update
            adev-&gt;<b>gpu_reset_counter</b>, and stop scheduler first<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">2.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Set
            its fence error status to </span>
          “<b><span lang="EN-US">ECANCELED</span></b>”<span lang="EN-US">,<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">3.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Find
            the <b>context</b> behind this job, and set this
            <b>context</b> as </span>“<b><span lang="EN-US">guilty</span></b>”<span
            lang="EN-US"> (will have a new member field in context
            structure –
            <b>bool guilty</b>)<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">a)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">There
            will be “<b>bool * guilty</b>” in entity structure, which
            points to its father context’s member – “<b>bool guilty”
            </b>when context initialized<b> </b>, so no matter we get
            context or entity, we always know if it is “guilty”<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">b)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">For
            kernel entity that used for VM updates, there is no context
            back it, so kernel entity’s “bool *guilty” always “NULL”.<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l0
          level2 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">c)<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">The
            idea to skip the whole context is for consistence
            consideration, because we’ll fake signal the hang job in
            job_run(), so all jobs in its context shall be dropped
            otherwise either bad drawing/computing results or more GPU
            hang.<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:0cm"><b><span
              lang="EN-US"><o:p> </o:p></span></b></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">4.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Do
            GPU reset, which is can be some callbacks to let bare-metal
            and SR-IOV implement with their favor style
            <o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">5.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">After
            reset, KMD need to aware if the VRAM lost happens or not,
            bare-metal can implement some function to judge, while for
            SR-IOV I prefer to read it from GIM side (for initial
            version we consider it</span>’<span lang="EN-US">s always
            VRAM lost, till GIM side change aligned)<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">6.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">If
            VRAM lost hit, update adev-&gt;<b>vram_lost_counter</b>.<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">7.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Do
            GTT recovery and shadow buffer recovery.<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo4">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">8.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Re-schedule
            all JOBs in mirror list and restart scheduler<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            GPU scheduler function --- job_run()<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l2
          level1 lfo6">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Before
            schedule a job to ring, checks if job-&gt;<b>vram_lost_counter</b>
            == adev-&gt;<b>vram_lost_counter</b>, and drop this job if
            mismatch<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l2
          level1 lfo6">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">2.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Before
            schedule a job to ring, checks if job-&gt;entity-&gt;<b>guilty</b>
            is NULL or not,
            <b>and drop this job if (guilty!=NULL &amp;&amp; *guilty ==
              TRUE)</b><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l2
          level1 lfo6">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">3.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">if a
            job is dropped:<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:63.0pt;text-indent:-21.0pt;mso-list:l2
          level2 lfo6">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">a)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">set
            job’s sched_fence status to “<b>ECANCELED</b>”<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:63.0pt;text-indent:-21.0pt;mso-list:l2
          level2 lfo6">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">b)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">fake/force
            signal job’s hw fence (no need to set hw fence’s status)<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_wait() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">After it found fence
            signaled, it should check if there is error on this fence
            and return the error status of this fence<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_wait_fences() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Similar with above
            approach<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_submit() IOCTL:<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo7">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">check
            if current ctx been marked
          </span>“<b><span lang="EN-US">guilty</span></b>”<span
            lang="EN-US"> and return </span>
          “<b><span lang="EN-US">ECANCELED</span></b>” <span
            lang="EN-US"> if so.<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo7">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">2.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">set
            job-&gt;<b>vram_lost_counter</b> with adev-&gt;<b>vram_lost_counter</b>,
            and return “<b>ECANCELED</b>” if ctx-&gt;<b>vram_lost_counter</b>
            != job-&gt;<b>vram_lost_counter</b> (Christian already
            submitted this patch)<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l1
          level2 lfo7">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">a)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">discussion:
            can we return “ENODEV” if vram_lost_counter mismatch ? that
            way UMD know this context is under “device lost”<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Introduce
            a new IOCTL to let UMD query latest adev-&gt;<b>vram_lost_counter</b>:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            amdgpu_ctx_query(): <o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l3
          level2 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">n<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><b><span lang="EN-US">Don’t
              update ctx-&gt;reset_counter when querying this function,
              otherwise the query result is not consistent
              <o:p></o:p></span></b></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l3
          level2 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">n<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Set
            out-&gt;state.reset_status to “AMDGPU_CTX_GUILTY_RESET” if
            the ctx is “<b>guilty</b>”, no need to check
            “ctx-&gt;reset_counter”<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l3
          level2 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">n<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Set
            out-&gt;state.reset_status to “AMDGPU_CTX_INNOCENT_RESET”
            <b>if the ctx isn’t “guilty” &amp;&amp;
              ctx-&gt;reset_counter != adev-&gt;reset_counter </b><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l3
          level2 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">n<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Set
            out-&gt;state.reset_status to “AMDGPU_CTX_NO_RESET” if
            ctx-&gt;reset_counter == adev-&gt;reset_counter<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l3
          level2 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">n<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Set
            out-&gt;state.flags to “AMDGPU_CTX_FLAG_VRAM_LOST” if
            ctx-&gt;vram_lost_counter != adev-&gt;vram_lost_counter<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:63.0pt;text-indent:-21.0pt;mso-list:l3
          level3 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">u<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">discussion:
            can we return “ENODEV” for amdgpu_ctx_query() if
            ctx-&gt;vram_lost_counter != adev-&gt;vram_lost_counter ?
            that way UMD know this context is under “device lost”<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l3
          level2 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">n<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">UMD
            shall release this context if it is AMDGPU_CTX_GUILTY_RESET
            or its flags is “AMDGPU_CTX_FLAG_VRAM_LOST”<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:0cm"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">For UMD behavior we
            still have something need to consider:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">If MESA creates a new
            context from an old context (share list?? I’m not familiar
            with UMD , David Mao shall have some discuss on it with
            Nicolai), the new created context’s vram_lost_counter<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">And reset_counter shall
            all be ported from that old context , otherwise CS_SUBMIT
            will not block it which isn’t correct
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Need your feedback, thx<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal" style="text-align:left" align="left"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">From:</span></b><span
                style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"> amd-gfx
                [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                <b>On Behalf Of </b>Liu, Monk<br>
                <b>Sent:</b> 2017</span><span
                style="font-size:11.0pt;font-family:宋体">年</span><span
                style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">10</span><span
                style="font-size:11.0pt;font-family:宋体">月</span><span
                style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">11</span><span
                style="font-size:11.0pt;font-family:宋体">日</span><span
                style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"> 13:34<br>
                <b>To:</b> Koenig, Christian
                <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>; Haehnle, Nicolai
                <a class="moz-txt-link-rfc2396E" href="mailto:Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org">&lt;Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org&gt;</a>; Olsak, Marek
                <a class="moz-txt-link-rfc2396E" href="mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org">&lt;Marek.Olsak-5C7GfCeVMHo@public.gmane.org&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Cc:</b> Ramirez, Alejandro
                <a class="moz-txt-link-rfc2396E" href="mailto:Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org">&lt;Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Filipas, Mario
                <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Filipas-5C7GfCeVMHo@public.gmane.org">&lt;Mario.Filipas-5C7GfCeVMHo@public.gmane.org&gt;</a>; Ding, Pixel
                <a class="moz-txt-link-rfc2396E" href="mailto:Pixel.Ding-5C7GfCeVMHo@public.gmane.org">&lt;Pixel.Ding-5C7GfCeVMHo@public.gmane.org&gt;</a>; Li, Bingley
                <a class="moz-txt-link-rfc2396E" href="mailto:Bingley.Li-5C7GfCeVMHo@public.gmane.org">&lt;Bingley.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>; Jiang, Jerry (SW)
                <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Jiang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Jiang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Subject:</b> TDR and VRAM lost handling in KMD:<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal" style="text-align:left" align="left"><span
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Hi Christian &amp;
            Nicolai,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">We need to achieve some
            agreements on what should MESA/UMD do and what should KMD
            do,
            <b>please give your comments with </b></span><b>“<span
              lang="EN-US">okay</span>”<span lang="EN-US"> or
            </span>“<span lang="EN-US">No</span>”<span lang="EN-US"> and
              your idea on below items,</span></b><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">When
            a job timed out (set from lockup_timeout kernel parameter),
            What KMD should do in TDR routine :<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Update
            adev-&gt;<b>gpu_reset_counter</b>, and stop scheduler first,
            (<b>gpu_reset_counter</b> is used to force vm flush after
            GPU reset, out of this thread</span>’<span lang="EN-US">s
            scope so no more discussion on it)<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">2.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Set
            its fence error status to </span>
          “<b><span lang="EN-US">ETIME</span></b>”<span lang="EN-US">,<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">3.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Find
            the entity/ctx behind this job, and set this ctx as
          </span>“<b><span lang="EN-US">guilty</span></b>”<span
            lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">4.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Kick
            out this job from scheduler</span>’<span lang="EN-US">s
            mirror list, so this job won</span>’<span lang="EN-US">t get
            re-scheduled to ring anymore.<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">5.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Kick
            out all jobs in this </span>
          “<span lang="EN-US">guilty</span>”<span lang="EN-US"> ctx</span>’<span
            lang="EN-US">s KFIFO queue, and set all their fence status
            to
          </span>“<b><span lang="EN-US">ECANCELED</span></b>”<span
            lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><b><span lang="EN-US"><span
                style="mso-list:Ignore">6.<span style="font:7.0pt
                  &quot;Times New Roman&quot;">      
                </span></span></span></b><!--[endif]--><span
            lang="EN-US">Force signal all fences that get kicked out by
            above two steps,<b> otherwise UMD will block forever if
              waiting on those fences<o:p></o:p></b></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">7.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Do
            gpu reset, which is can be some callbacks to let bare-metal
            and SR-IOV implement with their favor style
            <o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">8.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">After
            reset, KMD need to aware if the VRAM lost happens or not,
            bare-metal can implement some function to judge, while for
            SR-IOV I prefer to read it from GIM side (for initial
            version we consider it</span>’<span lang="EN-US">s always
            VRAM lost, till GIM side change aligned)<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">9.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">If
            VRAM lost not hit, continue, otherwise:<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l4
          level2 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">a)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">Update
            adev-&gt;<b>vram_lost_counter</b>,<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l4
          level2 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">b)<span style="font:7.0pt
                &quot;Times New Roman&quot;">      
              </span></span></span><!--[endif]--><span lang="EN-US">Iterate
            over all living ctx, and set all ctx as
          </span>“<b><span lang="EN-US">guilty</span></b>”<span
            lang="EN-US"> since VRAM lost actually ruins all VRAM
            contents<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l4
          level2 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">c)<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Kick
            out all jobs in all ctx</span>’<span lang="EN-US">s KFIFO
            queue, and set all their fence status to
          </span>“<b><span lang="EN-US">ECANCELDED</span></b>”<span
            lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">10.<span style="font:7.0pt
                &quot;Times New Roman&quot;">    
              </span></span></span><!--[endif]--><span lang="EN-US">Do
            GTT recovery and VRAM page tables/entries recovery
            (optional, do we need it ???)<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
          level1 lfo5">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">11.<span style="font:7.0pt
                &quot;Times New Roman&quot;">    
              </span></span></span><!--[endif]--><span lang="EN-US">Re-schedule
            all JOBs remains in mirror list to ring again and restart
            scheduler (for VRAM lost case, no JOB will re-scheduled)<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_wait() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">After it found fence
            signaled, it should check with
          </span><b>“<span lang="EN-US">dma_fence_get_status</span>” </b><span
            lang="EN-US">to see if there is error there,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">And return the error
            status of fence<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_wait_fences() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Similar with above
            approach<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">For
            cs_submit() IOCTL:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">It need to check if
            current ctx been marked as
          </span>“<b><span lang="EN-US">guilty</span></b>”<span
            lang="EN-US"> and return </span>
          “<b><span lang="EN-US">ECANCELED</span></b>”<span lang="EN-US">
            if so<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
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
            </b>bigger than that one cached in physical device.<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">BTW: I realized that
            gl-context is a little different with kernel</span>’<span
            lang="EN-US">s context. Because for kernel. BO is not
            related with context but only with FD, while in UMD, BO have
            a backend<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">gl-context, so block
            submitting in UMD layer is also needed although KMD will do
            its job as bottom line
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l3
          level1 lfo2">
          <!--[if !supportLists]--><span style="font-family:Wingdings"
            lang="EN-US"><span style="mso-list:Ignore">l<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span lang="EN-US">Basically
          </span>“<span lang="EN-US">vram_lost_counter</span>”<span
            lang="EN-US"> is exposure by kernel to let UMD take the
            control of robust extension feature, it will be UMD</span>’<span
            lang="EN-US">s call to move, KMD only deny </span>“<span
            lang="EN-US">guilty</span>”<span lang="EN-US"> context from
            submitting<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Need your feedback, thx<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">We</span>’<span
            lang="EN-US">d better make TDR feature landed ASAP<o:p></o:p></span></p>
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

--------------09BC02B5C0020074A275B462--

--===============0867225096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0867225096==--

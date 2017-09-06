From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: revert "fix deadlock of reservation between
 cs and gpu reset v2"
Date: Wed, 6 Sep 2017 11:33:07 +0200
Message-ID: <8797925e-0533-846e-2e46-55293b1b05c1@vodafone.de>
References: <1504617263-7210-1-git-send-email-deathsimple@vodafone.de>
 <BLUPR12MB044977C621578CDB0427B52584970@BLUPR12MB0449.namprd12.prod.outlook.com>
 <cd51ddcb-c27b-93fa-a10a-d41c4a0b8014@vodafone.de>
 <BLUPR12MB04494AA6CEDAB5CC5CDF286D84970@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1965175721=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB04494AA6CEDAB5CC5CDF286D84970-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1965175721==
Content-Type: multipart/alternative;
 boundary="------------6E05BAD2401C1C31252A2EAF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6E05BAD2401C1C31252A2EAF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> What’s you plan ? 
Not 100% sure yet. I need to move the fencing around to fix userptrs anyway.

When I'm done with that and when the UVD/VCE stuff is fixed then I'm 
going to tackle this next.

Regards,
Christian.

Am 06.09.2017 um 11:25 schrieb Liu, Monk:
>
> Yeah, you are right, although it has 32 slots (compared with 
> entit_push_job which only waits for two slots in gpu scheduler) but 
> still have chance to wait and meanwhile one job could under processing 
> by gpu reset
>
> What’s you plan ?
>
> Revert this patch is correct since it have potential dirty reference, 
> but how we need another patch to walk around this PD reservation dead 
> lock
>
> BR Monk
>
> *From:*Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
> *Sent:* 2017年9月6日16:20
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; 
> Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> *Subject:* Re: [PATCH] drm/amdgpu: revert "fix deadlock of reservation 
> between cs and gpu reset v2"
>
>     but how to understand 1)
>
>     what do you mean "The CS can still be blocked because of
>     amdgpu_ctx_add_fence()."
>
> See amdgpu_ctx_add_fence(), it can block for previous command 
> submissions just like entity_push_job(). So only moving 
> entity_push_job() out of locking the PD doesn't help at all.
>
>
>     for 2)The order of submission isn't correct any more.
>
>     I think since the pointer "job" is already a dirty pointer,
>     meaningless that  we talking about it if the order is correct ...
>
> The problem isn't parser->job, but rather that the job is referencing 
> the entity which is part of the context and we already called 
> amdgpu_ctx_put() on that one.
>
> Regards,
> Christian.
>
> Am 06.09.2017 um 10:04 schrieb Liu, Monk:
>
>     >The patch doesn't work at all:
>     1. The CS can still be blocked because of amdgpu_ctx_add_fence().
>     2. The order of submission isn't correct any more.
>     3. We could end up using freed up memory because we now drop the
>        ctx reference to early.
>
>     I suddenly found that the parser->job is really a wild pointer:
>
>     amdgpu_cs_parser_fini(p,
>
>     0, true);
>
>     trace_amdgpu_cs_ioctl(job);
>
>     amd_sched_entity_push_job(&job->base);
>
>     so "cs_parser_fini" cannot be called before "entity_push_job",
>     that part is correct
>
>     but how to understand 1)
>
>     what do you mean "The CS can still be blocked because of
>     amdgpu_ctx_add_fence()."
>
>     for 2)The order of submission isn't correct any more.
>
>     I think since the pointer "job" is already a dirty pointer,
>     meaningless that  we talking about it if the order is correct ...
>
>     BR Monk
>
>     ------------------------------------------------------------------------
>
>     *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
>     Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>     <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>     *Sent:* Tuesday, September 5, 2017 9:14:23 PM
>     *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhou, David(ChunMing)
>     *Subject:* [PATCH] drm/amdgpu: revert "fix deadlock of reservation
>     between cs and gpu reset v2"
>
>     From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
>     This reverts commit 10e709cb296c98424c03408d23e3addeddcd4088.
>
>     The patch doesn't work at all:
>     1. The CS can still be blocked because of amdgpu_ctx_add_fence().
>     2. The order of submission isn't correct any more.
>     3. We could end up using freed up memory because we now drop the
>        ctx reference to early.
>
>     This needs to be fixed cleanly by doing the context handling after
>     the BO
>     handling, but this is a larger task just avoid the obvious crashes
>     for now.
>
>     Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ----
>      1 file changed, 4 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     index b96776c..2db4010 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     @@ -1061,7 +1061,6 @@ static int amdgpu_cs_submit(struct
>     amdgpu_cs_parser *p,
>              cs->out.handle = amdgpu_ctx_add_fence(p->ctx, ring,
>     p->fence);
>              job->uf_sequence = cs->out.handle;
>              amdgpu_job_free_resources(job);
>     -       amdgpu_cs_parser_fini(p, 0, true);
>
>              trace_amdgpu_cs_ioctl(job);
>              amd_sched_entity_push_job(&job->base);
>     @@ -1120,10 +1119,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev,
>     void *data, struct drm_file *filp)
>                      goto out;
>
>              r = amdgpu_cs_submit(&parser, cs);
>     -       if (r)
>     -               goto out;
>
>     -       return 0;
>      out:
>              amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
>              return r;
>     -- 
>     2.7.4
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
>     _______________________________________________
>
>     amd-gfx mailing list
>
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------6E05BAD2401C1C31252A2EAF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><span
          style="font-size:10.5pt;font-family:等线;color:windowtext"
          lang="EN-US">What’s you plan ?
        </span></blockquote>
      Not 100% sure yet. I need to move the fencing around to fix
      userptrs anyway.<br>
      <br>
      When I'm done with that and when the UVD/VCE stuff is fixed then
      I'm going to tackle this next.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 06.09.2017 um 11:25 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB04494AA6CEDAB5CC5CDF286D84970-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
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
	{font-family:微软雅黑;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@微软雅黑";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0pt;
	margin-bottom:.0001pt;
	border:none;
	padding:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	color:black;}
span.EmailStyle22
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">Yeah, you are right, although it has 32 slots
            (compared with entit_push_job which only waits for two slots
            in gpu scheduler) but still have chance to wait and
            meanwhile one job could under processing by gpu reset<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">What’s you plan ?
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">Revert this patch is correct since it have
            potential dirty reference, but how we need another patch to
            walk around this PD reservation dead lock  <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">BR Monk<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                  lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                lang="EN-US"> Christian König
                [<a class="moz-txt-link-freetext" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]
                <br>
                <b>Sent:</b> 2017</span><span
style="font-size:11.0pt;font-family:&quot;微软雅黑&quot;,sans-serif;color:windowtext">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                lang="EN-US">9</span><span
style="font-size:11.0pt;font-family:&quot;微软雅黑&quot;,sans-serif;color:windowtext">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                lang="EN-US">6</span><span
style="font-size:11.0pt;font-family:&quot;微软雅黑&quot;,sans-serif;color:windowtext">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                lang="EN-US"> 16:20<br>
                <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Zhou, David(ChunMing)
                <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: revert "fix
                deadlock of reservation between cs and gpu reset v2"<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US">but how to
                understand 1)<br>
                <br>
                what do you mean "The CS can still be blocked because of
                amdgpu_ctx_add_fence()."<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"><span lang="EN-US">See
              amdgpu_ctx_add_fence(), it can block for previous command
              submissions just like entity_push_job(). So only moving
              entity_push_job() out of locking the PD doesn't help at
              all.<br>
              <br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US">for 2)The order of
                submission isn't correct any more.<br>
                <br>
                I think since the pointer "job" is already a dirty
                pointer, meaningless that  we talking about it if the
                order is correct ...<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"><span lang="EN-US">The problem isn't
              parser-&gt;job, but rather that the job is referencing the
              entity which is part of the context and we already called
              amdgpu_ctx_put() on that one.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 06.09.2017 um 10:04 schrieb Liu, Monk:<o:p></o:p></span></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <div>
            <div id="x_divtagdefaultwrapper">
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">&gt;</span><span
                  style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">The patch doesn't work at all:<br>
                  1. The CS can still be blocked because of
                  amdgpu_ctx_add_fence().<br>
                  2. The order of submission isn't correct any more.<br>
                  3. We could end up using freed up memory because we
                  now drop the<br>
                     ctx reference to early.</span><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p> </o:p></span></p>
              <p><span
                  style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">I suddenly found that the parser-&gt;job
                  is really a wild pointer:</span><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p></o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
                <div>
                  <p class="MsoNormal"
                    style="line-height:14.25pt;background:#1E1E1E"><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">    </span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#DCDCAA" lang="EN-US">amdgpu_cs_parser_fini</span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">(p,<o:p></o:p></span></p>
                  <p class="MsoNormal"
                    style="line-height:14.25pt;background:#1E1E1E"><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#B5CEA8" lang="EN-US">0</span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">,
                    </span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#569CD6" lang="EN-US">true</span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">);<o:p></o:p></span></p>
                </div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
                <div>
                  <p class="MsoNormal"
                    style="line-height:14.25pt;background:#1E1E1E"><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">    </span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#DCDCAA" lang="EN-US">trace_amdgpu_cs_ioctl</span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">(job);<o:p></o:p></span></p>
                </div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
                <div>
                  <p class="MsoNormal"
                    style="line-height:14.25pt;background:#1E1E1E"><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">    </span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#DCDCAA" lang="EN-US">amd_sched_entity_push_job</span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">(&amp;job-&gt;</span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#9CDCFE" lang="EN-US">base</span><span
                      style="font-size:10.5pt;font-family:&quot;Courier
                      New&quot;;color:#D4D4D4" lang="EN-US">);<o:p></o:p></span></p>
                </div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              </div>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">so "cs_parser_fini" cannot be called
                  before "entity_push_job", that part is correct<o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p> </o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">but how to understand 1)<o:p></o:p></span></p>
              <p><span
                  style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">what do you mean "The CS can still be
                  blocked because of amdgpu_ctx_add_fence().</span><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">"<o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p> </o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">for 2)</span><span
                  style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">The order of submission isn't correct any
                  more.</span><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">I think since the pointer "job" is
                  already a dirty pointer, meaningless that  we talking
                  about it if the order is correct ...
                  <o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p> </o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">BR Monk<o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p> </o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"><o:p> </o:p></span></p>
            </div>
            <div class="MsoNormal" style="text-align:center"
              align="center"><span lang="EN-US">
                <hr size="3" align="center" width="98%">
              </span></div>
            <div id="x_divRplyFwdMsg">
              <p class="MsoNormal"><b><span
                    style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US">From:</span></b><span
                  style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US"> amd-gfx
                  <a href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                  on behalf of Christian König
                  <a href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
                    moz-do-not-send="true">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                  <b>Sent:</b> Tuesday, September 5, 2017 9:14:23 PM<br>
                  <b>To:</b> <a
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                  Zhou, David(ChunMing)<br>
                  <b>Subject:</b> [PATCH] drm/amdgpu: revert "fix
                  deadlock of reservation between cs and gpu reset v2"</span><span
                  lang="EN-US">
                  <o:p></o:p></span></p>
              <div>
                <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              </div>
            </div>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:10.0pt"
                lang="EN-US">From: Christian König
                <a href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <br>
                This reverts commit
                10e709cb296c98424c03408d23e3addeddcd4088.<br>
                <br>
                The patch doesn't work at all:<br>
                1. The CS can still be blocked because of
                amdgpu_ctx_add_fence().<br>
                2. The order of submission isn't correct any more.<br>
                3. We could end up using freed up memory because we now
                drop the<br>
                   ctx reference to early.<br>
                <br>
                This needs to be fixed cleanly by doing the context
                handling after the BO<br>
                handling, but this is a larger task just avoid the
                obvious crashes for now.<br>
                <br>
                Signed-off-by: Christian König <a
                  href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ----<br>
                 1 file changed, 4 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                index b96776c..2db4010 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                @@ -1061,7 +1061,6 @@ static int amdgpu_cs_submit(struct
                amdgpu_cs_parser *p,<br>
                         cs-&gt;out.handle =
                amdgpu_ctx_add_fence(p-&gt;ctx, ring, p-&gt;fence);<br>
                         job-&gt;uf_sequence = cs-&gt;out.handle;<br>
                         amdgpu_job_free_resources(job);<br>
                -       amdgpu_cs_parser_fini(p, 0, true);<br>
                 <br>
                         trace_amdgpu_cs_ioctl(job);<br>
                         amd_sched_entity_push_job(&amp;job-&gt;base);<br>
                @@ -1120,10 +1119,7 @@ int amdgpu_cs_ioctl(struct
                drm_device *dev, void *data, struct drm_file *filp)<br>
                                 goto out;<br>
                 <br>
                         r = amdgpu_cs_submit(&amp;parser, cs);<br>
                -       if (r)<br>
                -               goto out;<br>
                 <br>
                -       return 0;<br>
                 out:<br>
                         amdgpu_cs_parser_fini(&amp;parser, r,
                reserved_buffers);<br>
                         return r;<br>
                -- <br>
                2.7.4<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                  moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
          </div>
          <p class="MsoNormal"><span lang="EN-US"><br>
              <br>
              <br>
              <o:p></o:p></span></p>
          <pre><span lang="EN-US">_______________________________________________<o:p></o:p></span></pre>
          <pre><span lang="EN-US">amd-gfx mailing list<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></span></pre>
          <pre><span lang="EN-US"><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></pre>
        </blockquote>
        <p><span lang="EN-US"><o:p> </o:p></span></p>
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
    <p><br>
    </p>
  </body>
</html>

--------------6E05BAD2401C1C31252A2EAF--

--===============1965175721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1965175721==--

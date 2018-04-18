From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: force app kill patch
Date: Wed, 18 Apr 2018 10:36:07 +0200
Message-ID: <6f4369eb-6064-3115-b9ae-9d5e0b3440a2@gmail.com>
References: <BLUPR12MB044915BDA633308DF65967BD84B60@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BLUPR12MB0449CE1BE8367DCA8B7AA3BB84B60@BLUPR12MB0449.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1378638062=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449CE1BE8367DCA8B7AA3BB84B60-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1378638062==
Content-Type: multipart/alternative;
 boundary="------------F24EFB9B844990F2E022CEBD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F24EFB9B844990F2E022CEBD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> See that in “sched_entity_fini”, we only call 
> dma_fence_put(entity->last_scheduled”under the condition of “If 
> (entity->fini_status)”, so
>
> This way there is memory leak for the case of “entity->fini_stats ==0”
>
Good catch, we indeed should fix that.

> 1.Drm_sched_entity_fini(): it exit right after entity->job_queue 
> empty, [ but that time scheduler is not fast enough to deal with this 
> entity now ] 
That should never happen.

The last job from the entity->job_queue is only removed after the 
scheduler is done with the entity (at least that was the original idea, 
not sure if that still works as expected).

Regards,
Christian.

Am 18.04.2018 um 09:20 schrieb Liu, Monk:
>
> *Correctio for the scenario *
>
> After we move fence_put(entity->last_sched) out of the fini_status check:
>
> A potential race issue for the scenario:
>
> 1.Drm_sched_entity_fini(): it exit right after entity->job_queue 
> empty, [ but that time scheduler is not fast enough to deal with this 
> entity now ]
>
> 2.Drm_sched_entity_cleanup() : it call 
> dma_fence_put(entity->last_scheduled)  [ but this time 
> entity->last_scheduled  actually points to the fence prior to the real 
> last one ]
>
> 3.Scheduler_main() now dealing with this entity: it call 
> dma_fence_put(entity->last_scheduled)    [   Now this fence get double 
> put !!!  ]
>
> 4.Scheduler_main() now call dma_fence_get() on the *real* last one !
>
> So eventually the real last one fence triggers memory leak and more 
> critical the double put fence cause NULL pointer access
>
> /Monk
>
> *From:*Liu, Monk
> *Sent:* 2018年4月18日15:11
> *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Deng, Emily 
> <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* force app kill patch
>
> Hi Christian & Emily
>
> I think the v4 fix for “fix force app kill hang”is still not good enough:
>
> First:
>
> See that in “sched_entity_fini”, we only call 
> dma_fence_put(entity->last_scheduled”under the condition of “If 
> (entity->fini_status)”, so
>
> This way there is memory leak for the case of “entity->fini_stats ==0”
>
> Second:
>
> If we move dma_fence_put(entity->last_scheduled) out of the condition 
> of “if (entity->fini_status)”, the memory leak issue can be fixed
>
> But there will be kernel NULL pointer access, I think the time you 
> call dma_fence_put(entity->last_scheduled”) may actually executed **not**
>
> On the last scheduled fence of this entity, because it is run without 
> “thread_park/unpark”pair which to make sure scheduler not dealing this 
> entity
>
> So with certain race issue, here is the scenario:
>
> 1.scheduler is doing the dma_fence_put() on the 1^st fence,
>
> 2.scheduler set entity->last_scheduled to 1^st fence
>
> 3.now sched_entity_fini() run, and it call dma_fence_put() on 
> entity->last_scheduled
>
> 4.now this 1^st fence is actually put double time and the real last 
> fence won’t get put by expected
>
> any idea?
>
> /Monk
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------F24EFB9B844990F2E022CEBD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p class="MsoNormal"><span lang="EN-US">See that in </span>“<span
            lang="EN-US">sched_entity_fini</span>”<span lang="EN-US">,
            we only call dma_fence_put(entity-&gt;last_scheduled</span>”<span
            lang="EN-US"> under the condition of
          </span>“<span lang="EN-US">If (entity-&gt;fini_status)</span>”<span
            lang="EN-US">, so
          </span></p>
        <p class="MsoNormal"><span lang="EN-US">This way there is memory
            leak for the case of
          </span>“<span lang="EN-US">entity-&gt;fini_stats ==0</span>”<span
            lang="EN-US"></span></p>
        <span lang="EN-US"></span></blockquote>
      Good catch, we indeed should fix that.<br>
      <br>
      <blockquote type="cite"><span lang="EN-US"><span
            style="mso-list:Ignore">1.<span style="font:7.0pt
              &quot;Times New Roman&quot;">       
            </span></span></span><span lang="EN-US">Drm_sched_entity_fini():
          it exit right after entity-&gt;job_queue empty, [ but that
          time scheduler is not fast enough to deal with this entity now
          ]</span>
        <span lang="EN-US"><span style="mso-list:Ignore"></span></span></blockquote>
      That should never happen.<br>
      <br>
      The last job from the entity-&gt;job_queue is only removed after
      the scheduler is done with the entity (at least that was the
      original idea, not sure if that still works as expected).<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 18.04.2018 um 09:20 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449CE1BE8367DCA8B7AA3BB84B60-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
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
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:微软雅黑;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@微软雅黑";}
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
	{mso-list-id:88358435;
	mso-list-type:hybrid;
	mso-list-template-ids:-9426188 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:26.4pt;
	text-indent:-21.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:47.4pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:68.4pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:89.4pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:110.4pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:131.4pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:152.4pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:173.4pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:194.4pt;
	text-indent:-21.0pt;}
@list l1
	{mso-list-id:1906794582;
	mso-list-type:hybrid;
	mso-list-template-ids:-9426188 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:26.4pt;
	text-indent:-21.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:47.4pt;
	text-indent:-21.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:68.4pt;
	text-indent:-21.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:89.4pt;
	text-indent:-21.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:110.4pt;
	text-indent:-21.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:131.4pt;
	text-indent:-21.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:152.4pt;
	text-indent:-21.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:173.4pt;
	text-indent:-21.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:194.4pt;
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
        <p class="MsoNormal"><span lang="EN-US">*Correctio for the
            scenario *<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">After we move
            fence_put(entity-&gt;last_sched) out of the fini_status
            check:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">A potential race issue
            for the scenario:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo2">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Drm_sched_entity_fini():
            it exit right after entity-&gt;job_queue empty, [ but that
            time scheduler is not fast enough to deal with this entity
            now ]<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo2">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">2.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Drm_sched_entity_cleanup()
            : it call dma_fence_put(entity-&gt;last_scheduled)  [ but
            this time entity-&gt;last_scheduled  actually points to the
            fence prior to the real last one ]<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo2">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">3.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Scheduler_main()
            now dealing with this entity: it call
            dma_fence_put(entity-&gt;last_scheduled)    [   Now this
            fence get double put !!!  ]<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l0
          level1 lfo2">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">4.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">Scheduler_main()
            now call dma_fence_get() on the *real* last one !<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">So eventually the real
            last one fence triggers memory leak and more critical the
            double put fence cause NULL pointer access
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">/Monk<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal" style="text-align:left" align="left"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">From:</span></b><span
                style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"> Liu, Monk
                <br>
                <b>Sent:</b> 2018</span><span
                style="font-size:11.0pt;font-family:&quot;微软雅黑&quot;,sans-serif">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">4</span><span
                style="font-size:11.0pt;font-family:&quot;微软雅黑&quot;,sans-serif">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">18</span><span
                style="font-size:11.0pt;font-family:&quot;微软雅黑&quot;,sans-serif">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"> 15:11<br>
                <b>To:</b> Koenig, Christian
                <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>; Deng, Emily
                <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> force app kill patch<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal" style="text-align:left" align="left"><span
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Hi Christian &amp; Emily<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">I think the v4 fix for </span>“<span
            lang="EN-US">fix force app kill hang</span>”<span
            lang="EN-US"> is still not good enough:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">First:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">See that in </span>“<span
            lang="EN-US">sched_entity_fini</span>”<span lang="EN-US">,
            we only call dma_fence_put(entity-&gt;last_scheduled</span>”<span
            lang="EN-US"> under the condition of
          </span>“<span lang="EN-US">If (entity-&gt;fini_status)</span>”<span
            lang="EN-US">, so
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">This way there is memory
            leak for the case of
          </span>“<span lang="EN-US">entity-&gt;fini_stats ==0</span>”<span
            lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Second:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">If we move
            dma_fence_put(entity-&gt;last_scheduled) out of the
            condition of
          </span>“<span lang="EN-US">if (entity-&gt;fini_status)</span>”<span
            lang="EN-US">, the memory leak issue can be fixed
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">But there will be kernel
            NULL pointer access, I think the time you call
            dma_fence_put(entity-&gt;last_scheduled</span>”<span
            lang="EN-US">) may actually executed *<b>not</b>*<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">On the last scheduled
            fence of this entity, because it is run without
          </span>“<span lang="EN-US">thread_park/unpark</span>”<span
            lang="EN-US"> pair which to make sure scheduler not dealing
            this entity<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">So with certain race
            issue, here is the scenario:<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">scheduler
            is doing the dma_fence_put() on the 1<sup>st</sup> fence,
            <o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">2.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">scheduler
            set entity-&gt;last_scheduled to 1<sup>st</sup> fence<o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">3.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">now
            sched_entity_fini() run, and it call dma_fence_put() on
            entity-&gt;last_scheduled
            <o:p></o:p></span></p>
        <p class="MsoListParagraph"
          style="margin-left:26.4pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo3">
          <!--[if !supportLists]--><span lang="EN-US"><span
              style="mso-list:Ignore">4.<span style="font:7.0pt
                &quot;Times New Roman&quot;">       
              </span></span></span><!--[endif]--><span lang="EN-US">now
            this 1<sup>st</sup> fence is actually put double time and
            the real last fence won</span>’<span lang="EN-US">t get put
            by expected
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">any idea?<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">/Monk<o:p></o:p></span></p>
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

--------------F24EFB9B844990F2E022CEBD--

--===============1378638062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1378638062==--

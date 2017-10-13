From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
Date: Fri, 13 Oct 2017 12:13:58 +0200
Message-ID: <e9d3674e-8ccf-c709-0dd9-b1fa493e086f@amd.com>
References: <BLUPR12MB044941343D6D1A35996C7B4284480@BLUPR12MB0449.namprd12.prod.outlook.com>
 <b0f57d8a-de01-addd-c17d-7af25e15f36d@amd.com>
 <BLUPR12MB04490BB257118A34DE346E0984480@BLUPR12MB0449.namprd12.prod.outlook.com>
 <6cf3017b-d694-1bfd-1f5a-861fd824c014@amd.com>
 <BLUPR12MB044988754711ABD7BF66B19184480@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BLUPR12MB044908B9AECE89D7E942EC7F84480@BLUPR12MB0449.namprd12.prod.outlook.com>
 <53f57508-6669-82ed-1b95-011f30610e05@amd.com>
 <BLUPR12MB0449CD46159EC28E81B823C184480@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------9E3D4D9120897095357E05E5"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449CD46159EC28E81B823C184480-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------9E3D4D9120897095357E05E5
Content-Type: multipart/alternative;
 boundary="------------97498484B1290876880B116A"

--------------97498484B1290876880B116A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Good point as well. How about the attached version?

This time we keep an extra reference in amd_sched_process_job() until we 
are sure that we don't need the s_fence any more.

Regards,
Christian.

Am 13.10.2017 um 11:13 schrieb Liu, Monk:
>
> your patch looks good,  do you think we should also do this:
>
>
>  void amd_sched_fence_scheduled(struct amd_sched_fence *fence)
>  {
> -       int ret = fence_signal(&fence->scheduled);
> +       int ret;
> +
> +       fence_get(&fence->scheduled;)
> +       ret = fence_signal(&fence->scheduled);
>
>         if (!ret)
>                 FENCE_TRACE(&fence->scheduled, "signaled from irq 
> context\n");
>         else
>                 FENCE_TRACE(&fence->scheduled, "was already signaled\n");
> +       fence_put(&fence->scheduled);
>  }
>
>
> ------------------------------------------------------------------------
> *From:* Koenig, Christian
> *Sent:* Friday, October 13, 2017 5:00:27 PM
> *To:* Liu, Monk; Nicolai Hähnle; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
>>
>> There is chance that free_job() called before that 
>> “trace_amd_sched_process_job”, correct?
>>
> Correct, but that is harmless.
>
> Take a look what trace_amd_sched_process_job actually does, it just 
> prints the pointer of the fence structure (but the pointer might be 
> stale at this point).
>
> Nevertheless you are right that this is really ugly.
>
> How about the attached patch to fix the issue?
>
> Regards,
> Christian.
>
> Am 13.10.2017 um 10:51 schrieb Liu, Monk:
>>
>> The free_job() is called in sched_job_finish() which is queued on a 
>> WORK and scheduled from that “amd_sched_fence_finished()”
>>
>> So the finishing timing of free_job() is asynchronized with 
>> sched_process_job()
>>
>> There is chance that free_job() called before that 
>> “trace_amd_sched_process_job”, correct?
>>
>> And if so the s_fence referred by it maybe a wild pointer
>>
>> BR Monk
>>
>> *From:*Liu, Monk
>> *Sent:* 2017年10月13日16:49
>> *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Nicolai Hähnle 
>> <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Subject:* RE: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
>>
>> No that’s not true
>>
>> The free_job() is called in sched_job_finish() which is queued on a 
>> WORK and scheduled from that “amd_sched_fence_finished()”
>>
>> So the finishing timing of free_job() is asynchronized with 
>> sched_process_job()
>>
>> How can you sure free_job() must before “trace_amd_sched_process_job”?
>>
>> *From:*Koenig, Christian
>> *Sent:* 2017年10月13日16:43
>> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>; Nicolai 
>> Hähnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; 
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> *Subject:* Re: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
>>
>> The free_job() callback is called only way after the job has finished.
>>
>> That is one change actually made by you to the code :)
>>
>> Christian.
>>
>> Am 13.10.2017 um 10:39 schrieb Liu, Monk:
>>
>>     I doubt it would always work fine…
>>
>>     First, we have FENCE_TRACE reference s_fence->finished after
>>     “fence_signal(&fence->finished)”
>>
>>     Second, we have trace_amd_sched_proess_job(s_fence) after
>>     “amd_sched_fence_finished()”,
>>
>>     If you put the finished before free_job() and by coincidence the
>>     job_finish() get very soon executed you’ll have odds to hit wild
>>     pointer on above two cases
>>
>>     BR Monk
>>
>>     *From:*Koenig, Christian
>>     *Sent:* 2017年10月13日16:17
>>     *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>;
>>     Nicolai Hähnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>;
>>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>     *Subject:* Re: regression with
>>     d6c650c0a8f6f671e49553725e1db541376d95f2
>>
>>     Yeah, that change is actually incorrect and should be reverted.
>>
>>     What we really need to do is remove dropping sched_job->s_fence
>>     from amd_sched_process_job() into amd_sched_job_finish() directly
>>     before the call to free_job().
>>
>>     Regards,
>>     Christian.
>>
>>     Am 13.10.2017 um 09:24 schrieb Liu, Monk:
>>
>>         commit d6c650c0a8f6f671e49553725e1db541376d95f2
>>         Author: Nicolai Hähnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>>         <mailto:nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>>         @@ -611,6 +611,10 @@ static int amd_sched_main(void *param)
>>
>>                         fence = sched->ops->run_job(sched_job);
>>         amd_sched_fence_scheduled(s_fence);
>>         +
>>         +               /* amd_sched_process_job drops the job's
>>         reference of the fence. */
>>         +               sched_job->s_fence = NULL;
>>         +
>>                         if (fence) {
>>                                 s_fence->parent = dma_fence_get(fence);
>>                                 r = dma_fence_add_callback(fence,
>>         &s_fence->cb,
>>
>>         Hi Nicolai
>>
>>         with this patch, you will break
>>         "amdgpu_sched_hw_job_reset()"routine:
>>
>>         void
>>
>>         amd_sched_hw_job_reset(structamd_gpu_scheduler
>>
>>         *sched)
>>
>>         {
>>
>>         structamd_sched_job
>>
>>         *s_job;
>>
>>         spin_lock(&sched->job_list_lock);
>>
>>         list_for_each_entry_reverse(s_job,
>>
>>         &sched->ring_mirror_list, node) {
>>
>>         if(s_job->s_fence->parent
>>
>>         &&
>>
>>         fence_remove_callback(s_job->s_fence->parent,
>>
>>         &s_job->s_fence->cb))
>>
>>         {
>>
>>         fence_put(s_job->s_fence->parent);
>>
>>                     s_job->s_fence->parent
>>
>>         =
>>
>>         NULL;
>>
>>         atomic_dec(&sched->hw_rq_count);
>>
>>                 }
>>
>>             }
>>
>>         spin_unlock(&sched->job_list_lock);
>>
>>         }
>>
>>         see that without sched_job->s_fence, you cannot remove the
>>         callback from its hw fence,
>>
>>         any idea??
>>
>>         BR Monk
>>
>


--------------97498484B1290876880B116A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Good point as well. How about the
      attached version?<br>
      <br>
      This time we keep an extra reference in amd_sched_process_job()
      until we are sure that we don't need the s_fence any more.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 13.10.2017 um 11:13 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449CD46159EC28E81B823C184480-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p>your patch looks good,  do you think we should also do this:</p>
        <p><br>
        </p>
        <div> void amd_sched_fence_scheduled(struct amd_sched_fence
          *fence)<br>
           {<br>
          -       int ret = fence_signal(&amp;fence-&gt;scheduled);<br>
          +       int ret;<br>
          +<br>
          +       fence_get(&amp;fence-&gt;scheduled;)<br>
          +       ret = fence_signal(&amp;fence-&gt;scheduled);<br>
           <br>
                  if (!ret)<br>
                          FENCE_TRACE(&amp;fence-&gt;scheduled,
          "signaled from irq context\n");<br>
                  else<br>
                          FENCE_TRACE(&amp;fence-&gt;scheduled, "was
          already signaled\n");<br>
          +       fence_put(&amp;fence-&gt;scheduled);<br>
           }</div>
        <br>
        <p><br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Koenig, Christian<br>
          <b>Sent:</b> Friday, October 13, 2017 5:00:27 PM<br>
          <b>To:</b> Liu, Monk; Nicolai Hähnle;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> Re: regression with
          d6c650c0a8f6f671e49553725e1db541376d95f2</font>
        <div> </div>
      </div>
      <div>
        <div class="moz-cite-prefix">
          <blockquote type="cite">
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">There is chance that free_job() called
                before that  </span><span
                style="font-size:10.5pt;font-family:等线;color:windowtext">“<span
                  lang="EN-US">trace_amd_sched_process_job</span>”<span
                  lang="EN-US">, correct?</span></span></p>
            <span
              style="font-size:10.5pt;font-family:等线;color:windowtext"
              lang="EN-US"></span></blockquote>
          Correct, but that is harmless.<br>
          <br>
          Take a look what trace_amd_sched_process_job actually does, it
          just prints the pointer of the fence structure (but the
          pointer might be stale at this point).<br>
          <br>
          Nevertheless you are right that this is really ugly.<br>
          <br>
          How about the attached patch to fix the issue?<br>
          <br>
          Regards,<br>
          Christian. <br>
          <br>
          Am 13.10.2017 um 10:51 schrieb Liu, Monk:<br>
        </div>
        <blockquote type="cite"
cite="mid:BLUPR12MB044908B9AECE89D7E942EC7F84480-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
          <meta name="Generator" content="Microsoft Word 15 (filtered
            medium)">
          <style><!--
/* Font Definitions */
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
@font-face
	{font-family:"Courier New \;color\:\#D4D4D4";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Courier New \;color\:\#569CD6";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Courier New \;color\:\#DCDCAA";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Courier New \;color\:\#9CDCFE";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Courier New \;color\:\#C586C0";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;
	color:black;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:等线;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:等线;
	color:windowtext;}
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
                lang="EN-US">The free_job() is called in
                sched_job_finish() which is queued on a WORK and
                scheduled from that
              </span><span
                style="font-size:10.5pt;font-family:等线;color:windowtext">“<span
                  lang="EN-US">amd_sched_fence_finished()</span>”<span
                  lang="EN-US"><o:p></o:p></span></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">So the finishing timing of free_job() is
                asynchronized with sched_process_job()<o:p></o:p></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US"><o:p> </o:p></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">There is chance that free_job() called
                before that  </span><span
                style="font-size:10.5pt;font-family:等线;color:windowtext">“<span
                  lang="EN-US">trace_amd_sched_process_job</span>”<span
                  lang="EN-US">, correct?<o:p></o:p></span></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">And if so the s_fence referred by it maybe
                a wild pointer
                <o:p></o:p></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US"><o:p> </o:p></span></p>
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
                    lang="EN-US"> Liu, Monk
                    <br>
                    <b>Sent:</b> 2017</span><span
                    style="font-size:11.0pt;color:windowtext">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                    lang="EN-US">10</span><span
                    style="font-size:11.0pt;color:windowtext">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                    lang="EN-US">13</span><span
                    style="font-size:11.0pt;color:windowtext">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                    lang="EN-US"> 16:49<br>
                    <b>To:</b> Koenig, Christian <a
                      class="moz-txt-link-rfc2396E"
                      href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">
                      &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>; Nicolai
                    Hähnle <a class="moz-txt-link-rfc2396E"
                      href="mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                      moz-do-not-send="true">
                      &lt;nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; <a
                      class="moz-txt-link-abbreviated"
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">
                      amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    <b>Subject:</b> RE: regression with
                    d6c650c0a8f6f671e49553725e1db541376d95f2<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">No that</span><span
                style="font-size:10.5pt;font-family:等线;color:windowtext">’<span
                  lang="EN-US">s not true<o:p></o:p></span></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US"><o:p> </o:p></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">The free_job() is called in
                sched_job_finish() which is queued on a WORK and
                scheduled from that
              </span><span
                style="font-size:10.5pt;font-family:等线;color:windowtext">“<span
                  lang="EN-US">amd_sched_fence_finished()</span>”<span
                  lang="EN-US"><o:p></o:p></span></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">So the finishing timing of free_job() is
                asynchronized with sched_process_job()<o:p></o:p></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US"><o:p> </o:p></span></p>
            <p class="MsoNormal"><span
                style="font-size:10.5pt;font-family:等线;color:windowtext"
                lang="EN-US">How can you sure free_job() must before
              </span><span
                style="font-size:10.5pt;font-family:等线;color:windowtext">“<span
                  lang="EN-US">trace_amd_sched_process_job</span>”<span
                  lang="EN-US"> ?<o:p></o:p></span></span></p>
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
                    lang="EN-US"> Koenig, Christian
                    <br>
                    <b>Sent:</b> 2017</span><span
                    style="font-size:11.0pt;color:windowtext">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                    lang="EN-US">10</span><span
                    style="font-size:11.0pt;color:windowtext">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                    lang="EN-US">13</span><span
                    style="font-size:11.0pt;color:windowtext">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                    lang="EN-US"> 16:43<br>
                    <b>To:</b> Liu, Monk &lt;<a
                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    Nicolai Hähnle &lt;<a
                      href="mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                      moz-do-not-send="true">nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;;
                    <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    <b>Subject:</b> Re: regression with
                    d6c650c0a8f6f671e49553725e1db541376d95f2<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
            <div>
              <p class="MsoNormal"><span lang="EN-US">The free_job()
                  callback is called only way after the job has
                  finished.<br>
                  <br>
                  That is one change actually made by you to the code :)<br>
                  <br>
                  Christian.<br>
                  <br>
                  Am 13.10.2017 um 10:39 schrieb Liu, Monk:<o:p></o:p></span></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US">I doubt it would always work fine</span><span
style="font-size:10.5pt;font-family:等线;color:windowtext">…</span><span
                  lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US">First, we have FENCE_TRACE reference
                  s_fence-&gt;finished after
                </span><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext">“<span
                    lang="EN-US">fence_signal(&amp;fence-&gt;finished)</span>”</span><span
                  lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US">Second, we have
                  trace_amd_sched_proess_job(s_fence) after
                </span><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext">“<span
                    lang="EN-US">amd_sched_fence_finished()</span>”<span
                    lang="EN-US">,</span></span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US">If you put the finished before free_job()
                  and by coincidence the job_finish() get very soon
                  executed you</span><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext">’<span
                    lang="EN-US">ll have odds to hit wild pointer on
                    above two cases</span></span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US">BR Monk</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span
                  style="font-size:10.5pt;font-family:等线;color:windowtext"
                  lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0cm 0cm 0cm">
                  <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                        lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                      lang="EN-US"> Koenig, Christian
                      <br>
                      <b>Sent:</b> 2017</span><span
                      style="font-size:11.0pt;color:windowtext">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                      lang="EN-US">10</span><span
                      style="font-size:11.0pt;color:windowtext">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                      lang="EN-US">13</span><span
                      style="font-size:11.0pt;color:windowtext">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                      lang="EN-US"> 16:17<br>
                      <b>To:</b> Liu, Monk <a
                        href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                      Nicolai Hähnle
                      <a href="mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                        moz-do-not-send="true">&lt;nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                      <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <b>Subject:</b> Re: regression with
                      d6c650c0a8f6f671e49553725e1db541376d95f2</span><span
                      lang="EN-US"><o:p></o:p></span></p>
                </div>
              </div>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <div>
                <p class="MsoNormal"><span lang="EN-US">Yeah, that
                    change is actually incorrect and should be reverted.<br>
                    <br>
                    What we really need to do is remove dropping
                    sched_job-&gt;s_fence from amd_sched_process_job()
                    into amd_sched_job_finish() directly before the call
                    to free_job().<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    Am 13.10.2017 um 09:24 schrieb Liu, Monk:<o:p></o:p></span></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <div id="divtagdefaultwrapper">
                  <div>
                    <p class="MsoNormal" style="margin-bottom:12.0pt"><span
style="font-family:&quot;Calibri&quot;,sans-serif" lang="EN-US">commit
                        d6c650c0a8f6f671e49553725e1db541376d95f2<br>
                        Author: Nicolai Hähnle <a
                          href="mailto:nicolai.haehnle-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">
                          &lt;nicolai.haehnle-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                        @@ -611,6 +611,10 @@ static int
                        amd_sched_main(void *param)<br>
                         <br>
                                        fence =
                        sched-&gt;ops-&gt;run_job(sched_job);<br>
                                       
                        amd_sched_fence_scheduled(s_fence);<br>
                        +<br>
                        +               /* amd_sched_process_job drops
                        the job's reference of the fence. */<br>
                        +               sched_job-&gt;s_fence = NULL;<br>
                        +<br>
                                        if (fence) {<br>
                                                s_fence-&gt;parent =
                        dma_fence_get(fence);<br>
                                                r =
                        dma_fence_add_callback(fence,
                        &amp;s_fence-&gt;cb,</span><span lang="EN-US"><o:p></o:p></span></p>
                  </div>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">Hi Nicolai</span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">with this patch, you will break
                      "amdgpu_sched_hw_job_reset()"routine:</span><span
                      lang="EN-US"><o:p></o:p></span></p>
                  <div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#569CD6&quot;,serif" lang="EN-US">void</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">
                        </span><span lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#DCDCAA&quot;,serif" lang="EN-US">amd_sched_hw_job_reset</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">(</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#569CD6&quot;,serif" lang="EN-US">struct</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">
                          amd_gpu_scheduler</span><span lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">*sched)</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">{</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">    </span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#569CD6&quot;,serif" lang="EN-US">struct</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">
                          amd_sched_job</span><span lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">*s_job;</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">    </span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#DCDCAA&quot;,serif" lang="EN-US">spin_lock</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">(&amp;sched-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">job_list_lock</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">);</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">    </span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#DCDCAA&quot;,serif" lang="EN-US">list_for_each_entry_reverse</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">(s_job,</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">&amp;sched-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">ring_mirror_list</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">,
                          node) {</span><span lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">        </span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#C586C0&quot;,serif" lang="EN-US">if</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">
                          (s_job-&gt;</span><span
                          style="font-size:10.5pt;font-family:&quot;Courier
                          New ;color:#9CDCFE&quot;,serif" lang="EN-US">s_fence</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">parent</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">&amp;&amp;</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">        
                        </span><span
                          style="font-size:10.5pt;font-family:&quot;Courier
                          New ;color:#DCDCAA&quot;,serif" lang="EN-US">fence_remove_callback</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">(s_job-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">s_fence</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">parent</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">,</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">                    
                          &amp;s_job-&gt;</span><span
                          style="font-size:10.5pt;font-family:&quot;Courier
                          New ;color:#9CDCFE&quot;,serif" lang="EN-US">s_fence</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">cb</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">))</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">{</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">            </span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#DCDCAA&quot;,serif" lang="EN-US">fence_put</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">(s_job-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">s_fence</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">parent</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">);</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">            s_job-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">s_fence</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">parent</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">=
                        </span><span lang="EN-US"><o:p></o:p></span></p>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#569CD6&quot;,serif" lang="EN-US">NULL</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">;</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">            </span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#DCDCAA&quot;,serif" lang="EN-US">atomic_dec</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">(&amp;sched-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">hw_rq_count</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">);</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">        }</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">    }</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">    </span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#DCDCAA&quot;,serif" lang="EN-US">spin_unlock</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">(&amp;sched-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#9CDCFE&quot;,serif" lang="EN-US">job_list_lock</span><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">);</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"
                        style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                          ;color:#D4D4D4&quot;,serif" lang="EN-US">}</span><span
                          lang="EN-US"><o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"
                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier New
                        ;color:#D4D4D4&quot;,serif" lang="EN-US"> </span><span
                        lang="EN-US"><o:p></o:p></span></p>
                  </div>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">see that without
                      sched_job-&gt;s_fence, you cannot remove the
                      callback from its hw fence,</span><span
                      lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">any idea??</span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">BR Monk</span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                  <p><span
                      style="font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                </div>
              </blockquote>
              <p><span lang="EN-US"> <o:p></o:p></span></p>
            </blockquote>
            <p><span lang="EN-US"><o:p> </o:p></span></p>
          </div>
        </blockquote>
        <p><br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------97498484B1290876880B116A--

--------------9E3D4D9120897095357E05E5
Content-Type: text/x-patch;
 name="0001-drm-amd-sched-fix-job-tear-down-order-v2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-amd-sched-fix-job-tear-down-order-v2.patch"

>From 56079bea614e1239ade60e8d4dd618abb63e06d8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 13 Oct 2017 10:58:15 +0200
Subject: [PATCH] drm/amd/sched: fix job tear down order v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the trace before we signal the scheduler fence and drop the
scheduler fence reference directly before we free the job.

v2: keep extra s_fence reference

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
index 59f1325d975c..e4d3b4ec4e92 100644
--- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
+++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
@@ -406,6 +406,7 @@ static void amd_sched_job_finish(struct work_struct *work)
 			schedule_delayed_work(&next->work_tdr, sched->timeout);
 	}
 	spin_unlock(&sched->job_list_lock);
+	dma_fence_put(&s_job->s_fence->finished);
 	sched->ops->free_job(s_job);
 }
 
@@ -586,6 +587,7 @@ static void amd_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
 		container_of(cb, struct amd_sched_fence, cb);
 	struct amd_gpu_scheduler *sched = s_fence->sched;
 
+	dma_fence_get(&s_fence->finished);
 	atomic_dec(&sched->hw_rq_count);
 	amd_sched_fence_finished(s_fence);
 
@@ -638,9 +640,6 @@ static int amd_sched_main(void *param)
 		fence = sched->ops->run_job(sched_job);
 		amd_sched_fence_scheduled(s_fence);
 
-		/* amd_sched_process_job drops the job's reference of the fence. */
-		sched_job->s_fence = NULL;
-
 		if (fence) {
 			s_fence->parent = dma_fence_get(fence);
 			r = dma_fence_add_callback(fence, &s_fence->cb,
-- 
2.11.0


--------------9E3D4D9120897095357E05E5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------9E3D4D9120897095357E05E5--

From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
Date: Fri, 13 Oct 2017 10:42:40 +0200
Message-ID: <6cf3017b-d694-1bfd-1f5a-861fd824c014@amd.com>
References: <BLUPR12MB044941343D6D1A35996C7B4284480@BLUPR12MB0449.namprd12.prod.outlook.com>
 <b0f57d8a-de01-addd-c17d-7af25e15f36d@amd.com>
 <BLUPR12MB04490BB257118A34DE346E0984480@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1289768010=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB04490BB257118A34DE346E0984480-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============1289768010==
Content-Type: multipart/alternative;
 boundary="------------01CA4D3305D0ACB0EE3D33D1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------01CA4D3305D0ACB0EE3D33D1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The free_job() callback is called only way after the job has finished.

That is one change actually made by you to the code :)

Christian.

Am 13.10.2017 um 10:39 schrieb Liu, Monk:
>
> I doubt it would always work fine…
>
> First, we have FENCE_TRACE reference s_fence->finished after 
> “fence_signal(&fence->finished)”
>
> Second, we have trace_amd_sched_proess_job(s_fence) after 
> “amd_sched_fence_finished()”,
>
> If you put the finished before free_job() and by coincidence the 
> job_finish() get very soon executed you’ll have odds to hit wild 
> pointer on above two cases
>
> BR Monk
>
> *From:*Koenig, Christian
> *Sent:* 2017年10月13日16:17
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Nicolai Hähnle 
> <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
>
> Yeah, that change is actually incorrect and should be reverted.
>
> What we really need to do is remove dropping sched_job->s_fence from 
> amd_sched_process_job() into amd_sched_job_finish() directly before 
> the call to free_job().
>
> Regards,
> Christian.
>
> Am 13.10.2017 um 09:24 schrieb Liu, Monk:
>
>     commit d6c650c0a8f6f671e49553725e1db541376d95f2
>     Author: Nicolai Hähnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>     <mailto:nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
>     @@ -611,6 +611,10 @@ static int amd_sched_main(void *param)
>
>                     fence = sched->ops->run_job(sched_job);
>                     amd_sched_fence_scheduled(s_fence);
>     +
>     +               /* amd_sched_process_job drops the job's reference
>     of the fence. */
>     +               sched_job->s_fence = NULL;
>     +
>                     if (fence) {
>                             s_fence->parent = dma_fence_get(fence);
>                             r = dma_fence_add_callback(fence,
>     &s_fence->cb,
>
>     Hi Nicolai
>
>     with this patch, you will break "amdgpu_sched_hw_job_reset()"routine:
>
>     void
>
>     amd_sched_hw_job_reset(structamd_gpu_scheduler
>
>     *sched)
>
>     {
>
>     structamd_sched_job
>
>     *s_job;
>
>     spin_lock(&sched->job_list_lock);
>
>     list_for_each_entry_reverse(s_job,
>
>     &sched->ring_mirror_list, node) {
>
>     if(s_job->s_fence->parent
>
>     &&
>
>     fence_remove_callback(s_job->s_fence->parent,
>
>     &s_job->s_fence->cb))
>
>     {
>
>     fence_put(s_job->s_fence->parent);
>
>                 s_job->s_fence->parent
>
>     =
>
>     NULL;
>
>     atomic_dec(&sched->hw_rq_count);
>
>             }
>
>         }
>
>     spin_unlock(&sched->job_list_lock);
>
>     }
>
>     see that without sched_job->s_fence, you cannot remove the
>     callback from its hw fence,
>
>     any idea??
>
>     BR Monk
>


--------------01CA4D3305D0ACB0EE3D33D1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">The free_job() callback is called only
      way after the job has finished.<br>
      <br>
      That is one change actually made by you to the code :)<br>
      <br>
      Christian.<br>
      <br>
      Am 13.10.2017 um 10:39 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB04490BB257118A34DE346E0984480-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
span.EmailStyle19
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
            lang="EN-US">I doubt it would always work fine…<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">First, we have FENCE_TRACE reference
            s_fence-&gt;finished after
            “fence_signal(&amp;fence-&gt;finished)”<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">Second, we have
            trace_amd_sched_proess_job(s_fence) after
            “amd_sched_fence_finished()”,<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">If you put the finished before free_job() and
            by coincidence the job_finish() get very soon executed
            you’ll have odds to hit wild pointer on above two cases<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线;color:windowtext"
            lang="EN-US">BR Monk<o:p></o:p></span></p>
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
                lang="EN-US"> 16:17<br>
                <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; Nicolai
                Hähnle <a class="moz-txt-link-rfc2396E" href="mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: regression with
                d6c650c0a8f6f671e49553725e1db541376d95f2<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <p class="MsoNormal"><span lang="EN-US">Yeah, that change is
              actually incorrect and should be reverted.<br>
              <br>
              What we really need to do is remove dropping
              sched_job-&gt;s_fence from amd_sched_process_job() into
              amd_sched_job_finish() directly before the call to
              free_job().<br>
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
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">commit
                  d6c650c0a8f6f671e49553725e1db541376d95f2<br>
                  Author: Nicolai Hähnle <a
                    href="mailto:nicolai.haehnle-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;nicolai.haehnle-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  @@ -611,6 +611,10 @@ static int amd_sched_main(void
                  *param)<br>
                   <br>
                                  fence =
                  sched-&gt;ops-&gt;run_job(sched_job);<br>
                                  amd_sched_fence_scheduled(s_fence);<br>
                  +<br>
                  +               /* amd_sched_process_job drops the
                  job's reference of the fence. */<br>
                  +               sched_job-&gt;s_fence = NULL;<br>
                  +<br>
                                  if (fence) {<br>
                                          s_fence-&gt;parent =
                  dma_fence_get(fence);<br>
                                          r =
                  dma_fence_add_callback(fence, &amp;s_fence-&gt;cb,<o:p></o:p></span></p>
            </div>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">Hi Nicolai<o:p></o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"><o:p> </o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">with this patch, you will break
                "amdgpu_sched_hw_job_reset()"routine:<o:p></o:p></span></p>
            <div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#569CD6" lang="EN-US">void</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">
                    <o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#DCDCAA" lang="EN-US">amd_sched_hw_job_reset</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">(</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#569CD6" lang="EN-US">struct</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">
                    amd_gpu_scheduler<o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">*sched)<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">{<o:p></o:p></span></p>
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
                    New&quot;;color:#569CD6" lang="EN-US">struct</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"> amd_sched_job<o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">*s_job;<o:p></o:p></span></p>
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
                    New&quot;;color:#DCDCAA" lang="EN-US">spin_lock</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">(&amp;sched-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">job_list_lock</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">);<o:p></o:p></span></p>
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
                    New&quot;;color:#DCDCAA" lang="EN-US">list_for_each_entry_reverse</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">(s_job,<o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">&amp;sched-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">ring_mirror_list</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">, node) {<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">        </span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#C586C0" lang="EN-US">if</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"> (s_job-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">s_fence</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">parent</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">&amp;&amp;<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">        
                  </span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#DCDCAA" lang="EN-US">fence_remove_callback</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">(s_job-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">s_fence</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">parent</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">,<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">                    
                    &amp;s_job-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">s_fence</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">cb</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">))<o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">{<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">            </span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#DCDCAA" lang="EN-US">fence_put</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">(s_job-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">s_fence</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">parent</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">);<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">            s_job-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">s_fence</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">parent</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US"><o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">=
                    <o:p></o:p></span></p>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#569CD6" lang="EN-US">NULL</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">;<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">            </span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#DCDCAA" lang="EN-US">atomic_dec</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">(&amp;sched-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">hw_rq_count</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">);<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">        }<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">    }<o:p></o:p></span></p>
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
                    New&quot;;color:#DCDCAA" lang="EN-US">spin_unlock</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">(&amp;sched-&gt;</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#9CDCFE" lang="EN-US">job_list_lock</span><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">);<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
              <div>
                <p class="MsoNormal"
                  style="line-height:14.25pt;background:#1E1E1E"><span
                    style="font-size:10.5pt;font-family:&quot;Courier
                    New&quot;;color:#D4D4D4" lang="EN-US">}<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"
                style="line-height:14.25pt;background:#1E1E1E"><span
                  style="font-size:10.5pt;font-family:&quot;Courier
                  New&quot;;color:#D4D4D4" lang="EN-US"><o:p> </o:p></span></p>
            </div>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"><o:p> </o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">see that without sched_job-&gt;s_fence, you
                cannot remove the callback from its hw fence,<o:p></o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"><o:p> </o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">any idea??<o:p></o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"><o:p> </o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">BR Monk<o:p></o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"><o:p> </o:p></span></p>
            <p><span style="font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"><o:p> </o:p></span></p>
          </div>
        </blockquote>
        <p><span lang="EN-US"><o:p> </o:p></span></p>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------01CA4D3305D0ACB0EE3D33D1--

--===============1289768010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1289768010==--

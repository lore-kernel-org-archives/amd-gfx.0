From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression with d6c650c0a8f6f671e49553725e1db541376d95f2
Date: Fri, 13 Oct 2017 10:16:44 +0200
Message-ID: <b0f57d8a-de01-addd-c17d-7af25e15f36d@amd.com>
References: <BLUPR12MB044941343D6D1A35996C7B4284480@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1249167078=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB044941343D6D1A35996C7B4284480-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============1249167078==
Content-Type: multipart/alternative;
 boundary="------------6B0423601D1DF3775B16DD5B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6B0423601D1DF3775B16DD5B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, that change is actually incorrect and should be reverted.

What we really need to do is remove dropping sched_job->s_fence from 
amd_sched_process_job() into amd_sched_job_finish() directly before the 
call to free_job().

Regards,
Christian.

Am 13.10.2017 um 09:24 schrieb Liu, Monk:
> commit d6c650c0a8f6f671e49553725e1db541376d95f2
> Author: Nicolai Hähnle <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>
> @@ -611,6 +611,10 @@ static int amd_sched_main(void *param)
>
>                 fence = sched->ops->run_job(sched_job);
>                 amd_sched_fence_scheduled(s_fence);
> +
> +               /* amd_sched_process_job drops the job's reference of 
> the fence. */
> +               sched_job->s_fence = NULL;
> +
>                 if (fence) {
>                         s_fence->parent = dma_fence_get(fence);
>                         r = dma_fence_add_callback(fence, &s_fence->cb,
>
> Hi Nicolai
>
>
> with this patch, you will break "amdgpu_sched_hw_job_reset()"routine:
>
> voidamd_sched_hw_job_reset(structamd_gpu_scheduler *sched)
> {
> structamd_sched_job *s_job;
> spin_lock(&sched->job_list_lock);
> list_for_each_entry_reverse(s_job, &sched->ring_mirror_list, node) {
> if(s_job->s_fence->parent&&
> fence_remove_callback(s_job->s_fence->parent,
> &s_job->s_fence->cb)) {
> fence_put(s_job->s_fence->parent);
>             s_job->s_fence->parent=NULL;
> atomic_dec(&sched->hw_rq_count);
>         }
>     }
> spin_unlock(&sched->job_list_lock);
> }
>
>
> see that without sched_job->s_fence, you cannot remove the callback 
> from its hw fence,
>
>
> any idea??
>
>
> BR Monk
>
>
>


--------------6B0423601D1DF3775B16DD5B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yeah, that change is actually incorrect
      and should be reverted.<br>
      <br>
      What we really need to do is remove dropping sched_job-&gt;s_fence
      from amd_sched_process_job() into amd_sched_job_finish() directly
      before the call to free_job().<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 13.10.2017 um 09:24 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB044941343D6D1A35996C7B4284480-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <div>commit d6c650c0a8f6f671e49553725e1db541376d95f2<br>
          Author: Nicolai Hähnle <a class="moz-txt-link-rfc2396E" href="mailto:nicolai.haehnle-5C7GfCeVMHo@public.gmane.org">&lt;nicolai.haehnle-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          @@ -611,6 +611,10 @@ static int amd_sched_main(void *param)<br>
           <br>
                          fence = sched-&gt;ops-&gt;run_job(sched_job);<br>
                          amd_sched_fence_scheduled(s_fence);<br>
          +<br>
          +               /* amd_sched_process_job drops the job's
          reference of the fence. */<br>
          +               sched_job-&gt;s_fence = NULL;<br>
          +<br>
                          if (fence) {<br>
                                  s_fence-&gt;parent =
          dma_fence_get(fence);<br>
                                  r = dma_fence_add_callback(fence,
          &amp;s_fence-&gt;cb,<br>
          <br>
        </div>
        <p>Hi Nicolai</p>
        <p><br>
        </p>
        <p>with this patch, you will break
          "amdgpu_sched_hw_job_reset()"routine:</p>
        <div style="color: #d4d4d4;background-color: #1e1e1e;font-family: 'Droid Sans Mono', 'Courier New', monospace, 'Droid Sans Fallback';font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;">
<div><span style="color: #569cd6;">void</span><span style="color: #d4d4d4;"> </span>
<span style="color: #dcdcaa;">amd_sched_hw_job_reset</span><span style="color: #d4d4d4;">(</span><span style="color: #569cd6;">struct</span><span style="color: #d4d4d4;"> amd_gpu_scheduler
</span><span style="color: #d4d4d4;">*</span><span style="color: #d4d4d4;">sched)</span></div>
<div><span style="color: #d4d4d4;">{</span></div>
<div><span style="color: #d4d4d4;">    </span><span style="color: #569cd6;">struct</span><span style="color: #d4d4d4;"> amd_sched_job
</span><span style="color: #d4d4d4;">*</span><span style="color: #d4d4d4;">s_job;</span></div>


<div><span style="color: #d4d4d4;">    </span><span style="color: #dcdcaa;">spin_lock</span><span style="color: #d4d4d4;">(</span><span style="color: #d4d4d4;">&amp;</span><span style="color: #d4d4d4;">sched-&gt;</span><span style="color: #9cdcfe;">job_list_lock</span><span style="color: #d4d4d4;">);</span></div>
<div><span style="color: #d4d4d4;">    </span><span style="color: #dcdcaa;">list_for_each_entry_reverse</span><span style="color: #d4d4d4;">(s_job,
</span><span style="color: #d4d4d4;">&amp;</span><span style="color: #d4d4d4;">sched-&gt;</span><span style="color: #9cdcfe;">ring_mirror_list</span><span style="color: #d4d4d4;">, node) {</span></div>
<div><span style="color: #d4d4d4;">        </span><span style="color: #c586c0;">if</span><span style="color: #d4d4d4;"> (s_job-&gt;</span><span style="color: #9cdcfe;">s_fence</span><span style="color: #d4d4d4;">-&gt;</span><span style="color: #9cdcfe;">parent</span><span style="color: #d4d4d4;">
</span><span style="color: #d4d4d4;">&amp;&amp;</span></div>
<div><span style="color: #d4d4d4;">         </span><span style="color: #dcdcaa;">fence_remove_callback</span><span style="color: #d4d4d4;">(s_job-&gt;</span><span style="color: #9cdcfe;">s_fence</span><span style="color: #d4d4d4;">-&gt;</span><span style="color: #9cdcfe;">parent</span><span style="color: #d4d4d4;">,</span></div>
<div><span style="color: #d4d4d4;">                     </span><span style="color: #d4d4d4;">&amp;</span><span style="color: #d4d4d4;">s_job-&gt;</span><span style="color: #9cdcfe;">s_fence</span><span style="color: #d4d4d4;">-&gt;</span><span style="color: #9cdcfe;">cb</span><span style="color: #d4d4d4;">))
 {</span></div>
<div><span style="color: #d4d4d4;">            </span><span style="color: #dcdcaa;">fence_put</span><span style="color: #d4d4d4;">(s_job-&gt;</span><span style="color: #9cdcfe;">s_fence</span><span style="color: #d4d4d4;">-&gt;</span><span style="color: #9cdcfe;">parent</span><span style="color: #d4d4d4;">);</span></div>
<div><span style="color: #d4d4d4;">            s_job-&gt;</span><span style="color: #9cdcfe;">s_fence</span><span style="color: #d4d4d4;">-&gt;</span><span style="color: #9cdcfe;">parent</span><span style="color: #d4d4d4;">
</span><span style="color: #d4d4d4;">=</span><span style="color: #d4d4d4;"> </span>
<span style="color: #569cd6;">NULL</span><span style="color: #d4d4d4;">;</span></div>
<div><span style="color: #d4d4d4;">            </span><span style="color: #dcdcaa;">atomic_dec</span><span style="color: #d4d4d4;">(</span><span style="color: #d4d4d4;">&amp;</span><span style="color: #d4d4d4;">sched-&gt;</span><span style="color: #9cdcfe;">hw_rq_count</span><span style="color: #d4d4d4;">);</span></div>
<div><span style="color: #d4d4d4;">        }</span></div>
<div><span style="color: #d4d4d4;">    }</span></div>
<div><span style="color: #d4d4d4;">    </span><span style="color: #dcdcaa;">spin_unlock</span><span style="color: #d4d4d4;">(</span><span style="color: #d4d4d4;">&amp;</span><span style="color: #d4d4d4;">sched-&gt;</span><span style="color: #9cdcfe;">job_list_lock</span><span style="color: #d4d4d4;">);</span></div>
<div><span style="color: #d4d4d4;">}</span></div>
</div>
        <p><br>
        </p>
        <p>see that without sched_job-&gt;s_fence, you cannot remove the
          callback from its hw fence,</p>
        <p><br>
        </p>
        <p>any idea??</p>
        <p><br>
        </p>
        <p>BR Monk<br>
        </p>
        <p><br>
        </p>
        <p><br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------6B0423601D1DF3775B16DD5B--

--===============1249167078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1249167078==--

From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: revert "fix deadlock of reservation between
 cs and gpu reset v2"
Date: Wed, 6 Sep 2017 10:20:14 +0200
Message-ID: <cd51ddcb-c27b-93fa-a10a-d41c4a0b8014@vodafone.de>
References: <1504617263-7210-1-git-send-email-deathsimple@vodafone.de>
 <BLUPR12MB044977C621578CDB0427B52584970@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0677167253=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB044977C621578CDB0427B52584970-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============0677167253==
Content-Type: multipart/alternative;
 boundary="------------C5487E432560FFE331745CCF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C5487E432560FFE331745CCF
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

> but how to understand 1)
>
> what do you mean "The CS can still be blocked because of 
> amdgpu_ctx_add_fence()."
See amdgpu_ctx_add_fence(), it can block for previous command 
submissions just like entity_push_job(). So only moving 
entity_push_job() out of locking the PD doesn't help at all.

> for 2)The order of submission isn't correct any more.
>
> I think since the pointer "job" is already a dirty pointer, 
> meaningless that  we talking about it if the order is correct ...
The problem isn't parser->job, but rather that the job is referencing 
the entity which is part of the context and we already called 
amdgpu_ctx_put() on that one.

Regards,
Christian.

Am 06.09.2017 um 10:04 schrieb Liu, Monk:
>
> >The patch doesn't work at all:
> 1. The CS can still be blocked because of amdgpu_ctx_add_fence().
> 2. The order of submission isn't correct any more.
> 3. We could end up using freed up memory because we now drop the
>    ctx reference to early.
>
>
> I suddenly found that the parser->job is really a wild pointer:
>
> amdgpu_cs_parser_fini(p, 0, true);
> trace_amdgpu_cs_ioctl(job);
> amd_sched_entity_push_job(&job->base);
>
> so "cs_parser_fini" cannot be called before "entity_push_job", that 
> part is correct
>
>
> but how to understand 1)
>
> what do you mean "The CS can still be blocked because of 
> amdgpu_ctx_add_fence()."
>
>
> for 2)The order of submission isn't correct any more.
>
> I think since the pointer "job" is already a dirty pointer, 
> meaningless that  we talking about it if the order is correct ...
>
>
> BR Monk
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Tuesday, September 5, 2017 9:14:23 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhou, David(ChunMing)
> *Subject:* [PATCH] drm/amdgpu: revert "fix deadlock of reservation 
> between cs and gpu reset v2"
> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> This reverts commit 10e709cb296c98424c03408d23e3addeddcd4088.
>
> The patch doesn't work at all:
> 1. The CS can still be blocked because of amdgpu_ctx_add_fence().
> 2. The order of submission isn't correct any more.
> 3. We could end up using freed up memory because we now drop the
>    ctx reference to early.
>
> This needs to be fixed cleanly by doing the context handling after the BO
> handling, but this is a larger task just avoid the obvious crashes for 
> now.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b96776c..2db4010 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1061,7 +1061,6 @@ static int amdgpu_cs_submit(struct 
> amdgpu_cs_parser *p,
>          cs->out.handle = amdgpu_ctx_add_fence(p->ctx, ring, p->fence);
>          job->uf_sequence = cs->out.handle;
>          amdgpu_job_free_resources(job);
> -       amdgpu_cs_parser_fini(p, 0, true);
>
>          trace_amdgpu_cs_ioctl(job);
>          amd_sched_entity_push_job(&job->base);
> @@ -1120,10 +1119,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, 
> void *data, struct drm_file *filp)
>                  goto out;
>
>          r = amdgpu_cs_submit(&parser, cs);
> -       if (r)
> -               goto out;
>
> -       return 0;
>  out:
>          amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
>          return r;
> -- 
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------C5487E432560FFE331745CCF
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">but how to understand 1)<br>
        <br>
        what do you mean "The CS can still be blocked because of
        amdgpu_ctx_add_fence()."<br>
      </blockquote>
      See amdgpu_ctx_add_fence(), it can block for previous command
      submissions just like entity_push_job(). So only moving
      entity_push_job() out of locking the PD doesn't help at all.<br>
      <br>
      <blockquote type="cite">for 2)The order of submission isn't
        correct any more.<br>
        <br>
        I think since the pointer "job" is already a dirty pointer,
        meaningless that  we talking about it if the order is correct
        ...<br>
      </blockquote>
      The problem isn't parser-&gt;job, but rather that the job is
      referencing the entity which is part of the context and we already
      called amdgpu_ctx_put() on that one.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 06.09.2017 um 10:04 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB044977C621578CDB0427B52584970-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <meta content="text/html; charset=UTF-8">
      <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Helvetica,sans-serif">
          <p>&gt;<font size="2"><span style="font-size:10pt">The patch
                doesn't work at all:<br>
                1. The CS can still be blocked because of
                amdgpu_ctx_add_fence().<br>
                2. The order of submission isn't correct any more.<br>
                3. We could end up using freed up memory because we now
                drop the<br>
                   ctx reference to early.</span></font></p>
          <p><font size="2"><span style="font-size:10pt"><br>
              </span></font></p>
          <p><font size="2"><span style="font-size:10pt">I suddenly
                found that the parser-&gt;job is really a wild pointer:</span></font></p>
          <p><font size="2"><span style="font-size:10pt"></span></font></p>
          <div style="color:#d4d4d4; background-color:#1e1e1e; font-family:'Droid Sans Mono','Courier New',monospace,'Droid Sans Fallback'; font-weight:normal; font-size:14px; line-height:19px; white-space:pre">
<div><span style="color:#d4d4d4">    </span><span style="color:#dcdcaa">amdgpu_cs_parser_fini</span><span style="color:#d4d4d4">(p,
</span><span style="color:#b5cea8">0</span><span style="color:#d4d4d4">, </span><span style="color:#569cd6">true</span><span style="color:#d4d4d4">);</span></div>


<div><span style="color:#d4d4d4">    </span><span style="color:#dcdcaa">trace_amdgpu_cs_ioctl</span><span style="color:#d4d4d4">(job);</span></div>
<div><span style="color:#d4d4d4">    </span><span style="color:#dcdcaa">amd_sched_entity_push_job</span><span style="color:#d4d4d4">(</span><span style="color:#d4d4d4">&amp;</span><span style="color:#d4d4d4">job-&gt;</span><span style="color:#9cdcfe">base</span><span style="color:#d4d4d4">);</span></div>
</div>
          <p>so "cs_parser_fini" cannot be called before
            "entity_push_job", that part is correct</p>
          <p><br>
          </p>
          <p>but how to understand 1)<br>
          </p>
          <p><font size="2"><span style="font-size:10pt">what do you
                mean "The CS can still be blocked because of
                amdgpu_ctx_add_fence().</span></font>"</p>
          <p><br>
          </p>
          <p>for 2)<font size="2"><span style="font-size:10pt">The order
                of submission isn't correct any more.</span></font></p>
          <p>I think since the pointer "job" is already a dirty pointer,
            meaningless that  we talking about it if the order is
            correct ...
            <br>
          </p>
          <p><br>
          </p>
          <p>BR Monk<br>
          </p>
          <p><br>
          </p>
          <p><br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
            behalf of Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>Sent:</b> Tuesday, September 5, 2017 9:14:23 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Zhou,
            David(ChunMing)<br>
            <b>Subject:</b> [PATCH] drm/amdgpu: revert "fix deadlock of
            reservation between cs and gpu reset v2"</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">From: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            This reverts commit
            10e709cb296c98424c03408d23e3addeddcd4088.<br>
            <br>
            The patch doesn't work at all:<br>
            1. The CS can still be blocked because of
            amdgpu_ctx_add_fence().<br>
            2. The order of submission isn't correct any more.<br>
            3. We could end up using freed up memory because we now drop
            the<br>
               ctx reference to early.<br>
            <br>
            This needs to be fixed cleanly by doing the context handling
            after the BO<br>
            handling, but this is a larger task just avoid the obvious
            crashes for now.<br>
            <br>
            Signed-off-by: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
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
                     cs-&gt;out.handle = amdgpu_ctx_add_fence(p-&gt;ctx,
            ring, p-&gt;fence);<br>
                     job-&gt;uf_sequence = cs-&gt;out.handle;<br>
                     amdgpu_job_free_resources(job);<br>
            -       amdgpu_cs_parser_fini(p, 0, true);<br>
             <br>
                     trace_amdgpu_cs_ioctl(job);<br>
                     amd_sched_entity_push_job(&amp;job-&gt;base);<br>
            @@ -1120,10 +1119,7 @@ int amdgpu_cs_ioctl(struct drm_device
            *dev, void *data, struct drm_file *filp)<br>
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
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
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

--------------C5487E432560FFE331745CCF--

--===============0677167253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0677167253==--

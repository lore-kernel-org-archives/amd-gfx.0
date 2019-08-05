From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]] *ERROR* ctx
 00000000189dec14 is still alive
Date: Mon, 5 Aug 2019 16:27:24 +0200
Message-ID: <057fc7ff-2b22-970b-992f-cfc818aadf7a@gmail.com>
References: <tencent_03E0C311B11B64CA539D74F7174F5059E008@qq.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1473584011=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <tencent_03E0C311B11B64CA539D74F7174F5059E008-9uewiaClKEY@public.gmane.org>
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
To: =?UTF-8?B?5a2Z5Y2X5YuH?= <497141801-9uewiaClKEY@public.gmane.org>, amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1473584011==
Content-Type: multipart/alternative;
 boundary="------------EF078863894CBD0E26679AC7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EF078863894CBD0E26679AC7
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.08.19 um 14:53 schrieb 孙南勇:
> Hi All,
>     Sometime dmesg show this log:
> [10407.720988] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]] *ERROR* ctx 
> 00000000189dec14 is still alive
> [10407.721054] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]] *ERROR* ctx 
> 00000000189dec14 is still alive
> [10407.721120] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]] *ERROR* ctx 
> 00000000189dec14 is still alive
> [10407.721187] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]] *ERROR* ctx 
> 00000000189dec14 is still alive
> [10407.721418] [drm:amdgpu_ctx_mgr_fini [amdgpu]] *ERROR* ctx 
> 00000000189dec14 is still alive
>
> What are the side effects?
> Does this error will occur GPU hung(such as gfx timeout)?
> How to fix this?
>
> My kernel : 4.19.36

That is hopelessly outdated code, please try to switch something newer 
and re-test.

Christian.

> Mesa: 18.3.6
>
> And I find that in amdgpu_ctx.c, the 
> function:amdgpu_ctx_mgr_entity_flush doesn't check the
> ctx->refcount(the check is stopped in this patch: 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=48ad368a8a3ab2fd3c2bc2ccccc6e29b1acda1bb) 
> ,
>  why amdgpu_ctx_mgr_entity_fini still need check ctx->refcount?
> Can i stop check ctx->refcount in amdgpu_ctx_mgr_entity_fini ?
>
> Thanks!
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------EF078863894CBD0E26679AC7
Content-Type: text/html; charset=gb18030
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb18030">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 05.08.19 um 14:53 schrieb 孙南勇:<br>
    </div>
    <blockquote type="cite"
      cite="mid:tencent_03E0C311B11B64CA539D74F7174F5059E008-9uewiaClKEY@public.gmane.org">
      <meta http-equiv="content-type" content="text/html;
        charset=gb18030">
      <div>Hi All,</div>
      <div>    Sometime dmesg show this log:</div>
      <div>
        <div>[10407.720988] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]]
          *ERROR* ctx 00000000189dec14 is still alive</div>
        <div>[10407.721054] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]]
          *ERROR* ctx 00000000189dec14 is still alive</div>
        <div>[10407.721120] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]]
          *ERROR* ctx 00000000189dec14 is still alive</div>
        <div>[10407.721187] [drm:amdgpu_ctx_mgr_entity_fini [amdgpu]]
          *ERROR* ctx 00000000189dec14 is still alive</div>
        <div>[10407.721418] [drm:amdgpu_ctx_mgr_fini [amdgpu]] *ERROR*
          ctx 00000000189dec14 is still alive</div>
      </div>
      <div><br>
      </div>
      <div>What are the side effects?</div>
      <div>Does this error will occur GPU hung(such as gfx timeout)?</div>
      <div>How to fix this?</div>
      <div><br>
      </div>
      <div>
        <div>My kernel : 4.19.36</div>
      </div>
    </blockquote>
    <br>
    That is hopelessly outdated code, please try to switch something
    newer and re-test.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:tencent_03E0C311B11B64CA539D74F7174F5059E008-9uewiaClKEY@public.gmane.org">
      <div>
        <div>Mesa: 18.3.6</div>
        <div><br>
        </div>
        <div>And I find that in amdgpu_ctx.c, the
          function:amdgpu_ctx_mgr_entity_flush doesn't check the </div>
        <div>ctx-&gt;refcount(the check is stopped in this patch:
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=48ad368a8a3ab2fd3c2bc2ccccc6e29b1acda1bb">https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=48ad368a8a3ab2fd3c2bc2ccccc6e29b1acda1bb</a>)
          , </div>
        <div> why amdgpu_ctx_mgr_entity_fini still need
          check ctx-&gt;refcount?</div>
        <div>Can i stop check ctx-&gt;refcount in 
          amdgpu_ctx_mgr_entity_fini ?</div>
        <div>
          <div><br>
          </div>
          <div>Thanks!</div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------EF078863894CBD0E26679AC7--

--===============1473584011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1473584011==--

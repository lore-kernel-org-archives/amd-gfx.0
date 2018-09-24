From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Deactivate SW interrupt fallback in
 amdgpu_fence_process v2
Date: Mon, 24 Sep 2018 11:13:01 -0400
Message-ID: <4ca8e57b-6927-e6a0-b063-9dc5a4d26952@amd.com>
References: <20180924121022.2071-1-christian.koenig@amd.com>
 <BN6PR12MB18097AA77D7E8948DE462823F7170@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1270423560=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18097AA77D7E8948DE462823F7170-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1270423560==
Content-Type: multipart/alternative;
 boundary="------------8DC62688479242DF99389AD4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8DC62688479242DF99389AD4
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-and-Tested-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>


Andrey


On 09/24/2018 10:31 AM, Deucher, Alexander wrote:
>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Monday, September 24, 2018 8:10:22 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* [PATCH] drm/amdgpu: Deactivate SW interrupt fallback in 
> amdgpu_fence_process v2
> From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>
> Deactivate SW interrupt fallback when all emited fences are completed.
> Also switch interrupt SW fallback message from INFO to WARN.
>
> v2: shorten the warnign message a bit and only re-activate the timer 
> during
> processing if it was already activated before.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> Suggested-by: Christian Konig <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 1ae25835cad1..4e6e9c9654dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -229,7 +229,8 @@ void amdgpu_fence_process(struct amdgpu_ring *ring)
>
>          } while (atomic_cmpxchg(&drv->last_seq, last_seq, seq) != 
> last_seq);
>
> -       if (seq != ring->fence_drv.sync_seq)
> +       if (del_timer(&ring->fence_drv.fallback_timer) &&
> +           seq != ring->fence_drv.sync_seq)
>                  amdgpu_fence_schedule_fallback(ring);
>
>          if (unlikely(seq == last_seq))
> @@ -274,7 +275,7 @@ static void amdgpu_fence_fallback(struct 
> timer_list *t)
>          struct amdgpu_ring *ring = from_timer(ring, t,
> fence_drv.fallback_timer);
>
> -       DRM_INFO("Fallback to SW interrupt on ring %s due to HW 
> interrupt time out", ring->name);
> +       DRM_WARN("Fence fallback timer expired on ring %s\n", ring->name);
>          amdgpu_fence_process(ring);
>  }
>
> -- 
> 2.14.1
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


--------------8DC62688479242DF99389AD4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Reviewed-and-Tested-by: Andrey Grodzovsky
      <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    </p>
    <p><br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 09/24/2018 10:31 AM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB18097AA77D7E8948DE462823F7170-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Acked-by: Alex Deucher
          <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Christian König
          <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Monday, September 24, 2018 8:10:22 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> [PATCH] drm/amdgpu: Deactivate SW interrupt
          fallback in amdgpu_fence_process v2</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">From: Andrey Grodzovsky
              <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <br>
              Deactivate SW interrupt fallback when all emited fences
              are completed.<br>
              Also switch interrupt SW fallback message from INFO to
              WARN.<br>
              <br>
              v2: shorten the warnign message a bit and only re-activate
              the timer during<br>
              processing if it was already activated before.<br>
              <br>
              Signed-off-by: Andrey Grodzovsky
              <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              Suggested-by: Christian Konig
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 +++--<br>
               1 file changed, 3 insertions(+), 2 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
              index 1ae25835cad1..4e6e9c9654dd 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
              @@ -229,7 +229,8 @@ void amdgpu_fence_process(struct
              amdgpu_ring *ring)<br>
               <br>
                       } while (atomic_cmpxchg(&amp;drv-&gt;last_seq,
              last_seq, seq) != last_seq);<br>
               <br>
              -       if (seq != ring-&gt;fence_drv.sync_seq)<br>
              +       if
              (del_timer(&amp;ring-&gt;fence_drv.fallback_timer)
              &amp;&amp;<br>
              +           seq != ring-&gt;fence_drv.sync_seq)<br>
                               amdgpu_fence_schedule_fallback(ring);<br>
               <br>
                       if (unlikely(seq == last_seq))<br>
              @@ -274,7 +275,7 @@ static void
              amdgpu_fence_fallback(struct timer_list *t)<br>
                       struct amdgpu_ring *ring = from_timer(ring, t,<br>
                                                            
              fence_drv.fallback_timer);<br>
               <br>
              -       DRM_INFO("Fallback to SW interrupt on ring %s due
              to HW interrupt time out", ring-&gt;name);<br>
              +       DRM_WARN("Fence fallback timer expired on ring
              %s\n", ring-&gt;name);<br>
                       amdgpu_fence_process(ring);<br>
               }<br>
               <br>
              -- <br>
              2.14.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font></div>
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

--------------8DC62688479242DF99389AD4--

--===============1270423560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1270423560==--

From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: allocate GTT space for shadow VM page tables
Date: Fri, 16 Sep 2016 12:03:06 +0200
Message-ID: <2d8ffb0d-df79-040c-2f1c-14c028c69840@vodafone.de>
References: <1474019288-5770-1-git-send-email-deathsimple@vodafone.de>
 <CAHbf0-EBxKZqwWstQxTYt_=2yy_0e0CGMtnnoZiQ_wFs-0itMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0097092835=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-EBxKZqwWstQxTYt_=2yy_0e0CGMtnnoZiQ_wFs-0itMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0097092835==
Content-Type: multipart/alternative;
 boundary="------------4F78173C316C2E7339B5A67F"

This is a multi-part message in MIME format.
--------------4F78173C316C2E7339B5A67F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Could be, but possible that I've missed a few other places where GTT is 
used as well.

What issues where you seeing and are there any backtraces logged? I have 
a WARN_ON() in the code path which should trigger whenever I missed 
something.

Christian.

Am 16.09.2016 um 11:55 schrieb Mike Lothian:
>
> Does this fix the issue I was seeing since the new memory manager went 
> into thr 4.9-wip branch?
>
>
> On Fri, 16 Sep 2016, 10:48 am Christian König, 
> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>
>     From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>
>
>     We need to access those with the system domain.
>
>     Fixes fallout from only allocating GTT space on demand.
>
>     Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
>      1 file changed, 17 insertions(+)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     index a6a48ed..8928a2a 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     @@ -552,6 +552,10 @@ static int amdgpu_vm_clear_bo(struct
>     amdgpu_device *adev,
>             if (r)
>                     goto error;
>
>     +       r = amdgpu_ttm_bind(&bo->tbo, &bo->tbo.mem);
>     +       if (r)
>     +               goto error;
>     +
>             addr = amdgpu_bo_gpu_offset(bo);
>             entries = amdgpu_bo_size(bo) / 8;
>
>     @@ -625,6 +629,11 @@ static int
>     amdgpu_vm_update_pd_or_shadow(struct amdgpu_device *adev,
>
>             if (!pd)
>                     return 0;
>     +
>     +       r = amdgpu_ttm_bind(&pd->tbo, &pd->tbo.mem);
>     +       if (r)
>     +               return r;
>     +
>             pd_addr = amdgpu_bo_gpu_offset(pd);
>             ring = container_of(vm->entity.sched, struct amdgpu_ring,
>     sched);
>
>     @@ -650,6 +659,14 @@ static int
>     amdgpu_vm_update_pd_or_shadow(struct amdgpu_device *adev,
>                     if (bo == NULL)
>                             continue;
>
>     +               if (bo->shadow) {
>     +                       struct amdgpu_bo *shadow = bo->shadow;
>     +
>     +                       r = amdgpu_ttm_bind(&shadow->tbo,
>     &shadow->tbo.mem);
>     +                       if (r)
>     +                               return r;
>     +               }
>     +
>                     pt = amdgpu_bo_gpu_offset(bo);
>                     if (!shadow) {
>                             if (vm->page_tables[pt_idx].addr == pt)
>     --
>     2.5.0
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------4F78173C316C2E7339B5A67F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Could be, but possible that I've missed
      a few other places where GTT is used as well.<br>
      <br>
      What issues where you seeing and are there any backtraces logged?
      I have a WARN_ON() in the code path which should trigger whenever
      I missed something.<br>
      <br>
      Christian.<br>
      <br>
      Am 16.09.2016 um 11:55 schrieb Mike Lothian:<br>
    </div>
    <blockquote
cite="mid:CAHbf0-EBxKZqwWstQxTYt_=2yy_0e0CGMtnnoZiQ_wFs-0itMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <p dir="ltr">Does this fix the issue I was seeing since the new
        memory manager went into thr 4.9-wip branch?</p>
      <br>
      <div class="gmail_quote">
        <div dir="ltr">On Fri, 16 Sep 2016, 10:48 am Christian König,
          &lt;<a moz-do-not-send="true"
            href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">From:
          Christian König &lt;<a moz-do-not-send="true"
            href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target="_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
          <br>
          We need to access those with the system domain.<br>
          <br>
          Fixes fallout from only allocating GTT space on demand.<br>
          <br>
          Signed-off-by: Christian König &lt;<a moz-do-not-send="true"
            href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target="_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
          ---<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++<br>
           1 file changed, 17 insertions(+)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          index a6a48ed..8928a2a 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          @@ -552,6 +552,10 @@ static int amdgpu_vm_clear_bo(struct
          amdgpu_device *adev,<br>
                  if (r)<br>
                          goto error;<br>
          <br>
          +       r = amdgpu_ttm_bind(&amp;bo-&gt;tbo,
          &amp;bo-&gt;tbo.mem);<br>
          +       if (r)<br>
          +               goto error;<br>
          +<br>
                  addr = amdgpu_bo_gpu_offset(bo);<br>
                  entries = amdgpu_bo_size(bo) / 8;<br>
          <br>
          @@ -625,6 +629,11 @@ static int
          amdgpu_vm_update_pd_or_shadow(struct amdgpu_device *adev,<br>
          <br>
                  if (!pd)<br>
                          return 0;<br>
          +<br>
          +       r = amdgpu_ttm_bind(&amp;pd-&gt;tbo,
          &amp;pd-&gt;tbo.mem);<br>
          +       if (r)<br>
          +               return r;<br>
          +<br>
                  pd_addr = amdgpu_bo_gpu_offset(pd);<br>
                  ring = container_of(vm-&gt;entity.sched, struct
          amdgpu_ring, sched);<br>
          <br>
          @@ -650,6 +659,14 @@ static int
          amdgpu_vm_update_pd_or_shadow(struct amdgpu_device *adev,<br>
                          if (bo == NULL)<br>
                                  continue;<br>
          <br>
          +               if (bo-&gt;shadow) {<br>
          +                       struct amdgpu_bo *shadow =
          bo-&gt;shadow;<br>
          +<br>
          +                       r =
          amdgpu_ttm_bind(&amp;shadow-&gt;tbo, &amp;shadow-&gt;tbo.mem);<br>
          +                       if (r)<br>
          +                               return r;<br>
          +               }<br>
          +<br>
                          pt = amdgpu_bo_gpu_offset(bo);<br>
                          if (!shadow) {<br>
                                  if (vm-&gt;page_tables[pt_idx].addr ==
          pt)<br>
          --<br>
          2.5.0<br>
          <br>
          _______________________________________________<br>
          amd-gfx mailing list<br>
          <a moz-do-not-send="true"
            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <a moz-do-not-send="true"
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
            rel="noreferrer" target="_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
        </blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------4F78173C316C2E7339B5A67F--

--===============0097092835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0097092835==--

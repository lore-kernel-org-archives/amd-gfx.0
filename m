From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: cast mem->num_pages to 64-bits when
 shifting
Date: Mon, 17 Jun 2019 21:25:43 +0200
Message-ID: <82551bf2-c88d-d1fe-652f-535562154d0d@gmail.com>
References: <20190614165108.23011-1-tom.stdenis@amd.com>
 <CAAzXoRK9vy-qC36mSzJ3aJr6YB8kuWMujxfuNFAqAzbWEk+gTA@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0473789738=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAzXoRK9vy-qC36mSzJ3aJr6YB8kuWMujxfuNFAqAzbWEk+gTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0473789738==
Content-Type: multipart/alternative;
 boundary="------------28542C742B8D47BEA3B84677"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------28542C742B8D47BEA3B84677
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Am 17.06.19 um 20:21 schrieb Tom St Denis:
> ping?
>
> On Fri, Jun 14, 2019 at 12:51 PM StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org 
> <mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     On 32-bit hosts mem->num_pages is 32-bits and can overflow
>     when shifted.  Add a cast to avoid this.
>
>     Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org
>     <mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org>>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 8 +++++---
>      1 file changed, 5 insertions(+), 3 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>     index c963ad86072e..31895d3c33de 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>     @@ -279,14 +279,16 @@ static int amdgpu_vram_mgr_new(struct
>     ttm_mem_type_manager *man,
>             uint64_t vis_usage = 0;
>             unsigned i;
>             int r;
>     +       uint64_t mem_bytes;
>
>             lpfn = place->lpfn;
>             if (!lpfn)
>                     lpfn = man->size;
>
>             /* bail out quickly if there's likely not enough VRAM for
>     this BO */
>     -       if (atomic64_add_return(mem->num_pages << PAGE_SHIFT,
>     &mgr->usage) > adev->gmc.mc_vram_size) {
>     -               atomic64_sub(mem->num_pages << PAGE_SHIFT,
>     &mgr->usage);
>     +       mem_bytes = (u64)mem->num_pages << PAGE_SHIFT;
>     +       if (atomic64_add_return(mem_bytes, &mgr->usage) >
>     adev->gmc.mc_vram_size) {
>     +               atomic64_sub(mem_bytes, &mgr->usage);
>                     mem->mm_node = NULL;
>                     return 0;
>             }
>     @@ -308,7 +310,7 @@ static int amdgpu_vram_mgr_new(struct
>     ttm_mem_type_manager *man,
>             nodes = kvmalloc_array((uint32_t)num_nodes, sizeof(*nodes),
>                                    GFP_KERNEL | __GFP_ZERO);
>             if (!nodes) {
>     -               atomic64_sub(mem->num_pages << PAGE_SHIFT,
>     &mgr->usage);
>     +               atomic64_sub(mem_bytes, &mgr->usage);
>                     return -ENOMEM;
>             }
>
>     -- 
>     2.21.0
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------28542C742B8D47BEA3B84677
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      <br>
      Am 17.06.19 um 20:21 schrieb Tom St Denis:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAzXoRK9vy-qC36mSzJ3aJr6YB8kuWMujxfuNFAqAzbWEk+gTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">ping?</div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, Jun 14, 2019 at 12:51
          PM StDenis, Tom &lt;<a href="mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org"
            moz-do-not-send="true">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On
          32-bit hosts mem-&gt;num_pages is 32-bits and can overflow<br>
          when shifted.  Add a cast to avoid this.<br>
          <br>
          Signed-off-by: Tom St Denis &lt;<a
            href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org" target="_blank"
            moz-do-not-send="true">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
          ---<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 8 +++++---<br>
           1 file changed, 5 insertions(+), 3 deletions(-)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c<br>
          index c963ad86072e..31895d3c33de 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c<br>
          @@ -279,14 +279,16 @@ static int amdgpu_vram_mgr_new(struct
          ttm_mem_type_manager *man,<br>
                  uint64_t vis_usage = 0;<br>
                  unsigned i;<br>
                  int r;<br>
          +       uint64_t mem_bytes;<br>
          <br>
                  lpfn = place-&gt;lpfn;<br>
                  if (!lpfn)<br>
                          lpfn = man-&gt;size;<br>
          <br>
                  /* bail out quickly if there's likely not enough VRAM
          for this BO */<br>
          -       if (atomic64_add_return(mem-&gt;num_pages &lt;&lt;
          PAGE_SHIFT, &amp;mgr-&gt;usage) &gt;
          adev-&gt;gmc.mc_vram_size) {<br>
          -               atomic64_sub(mem-&gt;num_pages &lt;&lt;
          PAGE_SHIFT, &amp;mgr-&gt;usage);<br>
          +       mem_bytes = (u64)mem-&gt;num_pages &lt;&lt;
          PAGE_SHIFT;<br>
          +       if (atomic64_add_return(mem_bytes, &amp;mgr-&gt;usage)
          &gt; adev-&gt;gmc.mc_vram_size) {<br>
          +               atomic64_sub(mem_bytes, &amp;mgr-&gt;usage);<br>
                          mem-&gt;mm_node = NULL;<br>
                          return 0;<br>
                  }<br>
          @@ -308,7 +310,7 @@ static int amdgpu_vram_mgr_new(struct
          ttm_mem_type_manager *man,<br>
                  nodes = kvmalloc_array((uint32_t)num_nodes,
          sizeof(*nodes),<br>
                                         GFP_KERNEL | __GFP_ZERO);<br>
                  if (!nodes) {<br>
          -               atomic64_sub(mem-&gt;num_pages &lt;&lt;
          PAGE_SHIFT, &amp;mgr-&gt;usage);<br>
          +               atomic64_sub(mem_bytes, &amp;mgr-&gt;usage);<br>
                          return -ENOMEM;<br>
                  }<br>
          <br>
          -- <br>
          2.21.0<br>
          <br>
          _______________________________________________<br>
          amd-gfx mailing list<br>
          <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"
            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <a
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
            rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></blockquote>
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

--------------28542C742B8D47BEA3B84677--

--===============0473789738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0473789738==--

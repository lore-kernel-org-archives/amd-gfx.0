From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: free up the first paging queue
Date: Wed, 13 Mar 2019 14:38:58 +0100
Message-ID: <6e12454a-6ee8-1c10-6ec9-13e71576259c@gmail.com>
References: <20190312123749.6249-1-christian.koenig@amd.com>
 <20190312123749.6249-2-christian.koenig@amd.com>
 <BYAPR12MB317644D82ADEF3CA55530A2B92490@BYAPR12MB3176.namprd12.prod.outlook.com>
 <BN6PR12MB18095A3704551015894223D1F7490@BN6PR12MB1809.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1951266405=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18095A3704551015894223D1F7490-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1951266405==
Content-Type: multipart/alternative;
 boundary="------------436E23763737BFF6759B33DD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------436E23763737BFF6759B33DD
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

To be on the safe side I've adjusted the code to work with any number of 
SDMA instances.

Christian.

Am 12.03.19 um 16:33 schrieb Deucher, Alexander:
> I don't think Raven has a paging queue in the first place.
>
> Alex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Tuesday, March 12, 2019 11:29 AM
> *To:* Christian König; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* RE: [PATCH 2/3] drm/amdgpu: free up the first paging queue
> I think this would break Raven, which only has one SDMA engine.
>
> Regards,
>   Felix
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of 
> Christian König
> Sent: Tuesday, March 12, 2019 8:38 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: [PATCH 2/3] drm/amdgpu: free up the first paging queue
>
> We need the first paging queue to handle page faults.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 3ac5abe937f4..bed18e7bbc36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2266,7 +2266,7 @@ static void sdma_v4_0_set_buffer_funcs(struct 
> amdgpu_device *adev)  {
>          adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
>          if (adev->sdma.has_page_queue)
> -               adev->mman.buffer_funcs_ring = 
> &adev->sdma.instance[0].page;
> +               adev->mman.buffer_funcs_ring = 
> &adev->sdma.instance[1].page;
>          else
>                  adev->mman.buffer_funcs_ring = 
> &adev->sdma.instance[0].ring;  } @@ -2285,15 +2285,19 @@ static void 
> sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev)
>          unsigned i;
>
>          adev->vm_manager.vm_pte_funcs = &sdma_v4_0_vm_pte_funcs;
> -       for (i = 0; i < adev->sdma.num_instances; i++) {
> -               if (adev->sdma.has_page_queue)
> -                       sched = &adev->sdma.instance[i].page.sched;
> -               else
> -                       sched = &adev->sdma.instance[i].ring.sched;
> -               adev->vm_manager.vm_pte_rqs[i] =
> +       if (adev->sdma.has_page_queue) {
> +               sched = &adev->sdma.instance[1].page.sched;
> +               adev->vm_manager.vm_pte_rqs[0] =
> &sched->sched_rq[DRM_SCHED_PRIORITY_KERNEL];
> +               adev->vm_manager.vm_pte_num_rqs = 1;
> +       } else {
> +               for (i = 0; i < adev->sdma.num_instances; i++) {
> +                       sched = &adev->sdma.instance[i].ring.sched;
> +                       adev->vm_manager.vm_pte_rqs[i] =
> + &sched->sched_rq[DRM_SCHED_PRIORITY_KERNEL];
> +               }
> +               adev->vm_manager.vm_pte_num_rqs = 
> adev->sdma.num_instances;
>          }
> -       adev->vm_manager.vm_pte_num_rqs = adev->sdma.num_instances;
>  }
>
>  const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------436E23763737BFF6759B33DD
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">To be on the safe side I've adjusted
      the code to work with any number of SDMA instances.<br>
      <br>
      Christian.<br>
      <br>
      Am 12.03.19 um 16:33 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB18095A3704551015894223D1F7490-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        I don't think Raven has a paging queue in the first place.</div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Alex<br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Tuesday, March 12, 2019 11:29 AM<br>
          <b>To:</b> Christian König; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> RE: [PATCH 2/3] drm/amdgpu: free up the first
          paging queue</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">I think this would break Raven, which
              only has one SDMA engine.<br>
              <br>
              Regards,<br>
                Felix<br>
              <br>
              -----Original Message-----<br>
              From: amd-gfx
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> On Behalf Of
              Christian König<br>
              Sent: Tuesday, March 12, 2019 8:38 AM<br>
              To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              Subject: [PATCH 2/3] drm/amdgpu: free up the first paging
              queue<br>
              <br>
              We need the first paging queue to handle page faults.<br>
              <br>
              Signed-off-by: Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 20
              ++++++++++++--------<br>
               1 file changed, 12 insertions(+), 8 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
              b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
              index 3ac5abe937f4..bed18e7bbc36 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
              @@ -2266,7 +2266,7 @@ static void
              sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)  {<br>
                       adev-&gt;mman.buffer_funcs =
              &amp;sdma_v4_0_buffer_funcs;<br>
                       if (adev-&gt;sdma.has_page_queue)<br>
              -               adev-&gt;mman.buffer_funcs_ring =
              &amp;adev-&gt;sdma.instance[0].page;<br>
              +               adev-&gt;mman.buffer_funcs_ring =
              &amp;adev-&gt;sdma.instance[1].page;<br>
                       else<br>
                               adev-&gt;mman.buffer_funcs_ring =
              &amp;adev-&gt;sdma.instance[0].ring;  } @@ -2285,15
              +2285,19 @@ static void sdma_v4_0_set_vm_pte_funcs(struct
              amdgpu_device *adev)<br>
                       unsigned i;<br>
               <br>
                       adev-&gt;vm_manager.vm_pte_funcs =
              &amp;sdma_v4_0_vm_pte_funcs;<br>
              -       for (i = 0; i &lt; adev-&gt;sdma.num_instances;
              i++) {<br>
              -               if (adev-&gt;sdma.has_page_queue)<br>
              -                       sched =
              &amp;adev-&gt;sdma.instance[i].page.sched;<br>
              -               else<br>
              -                       sched =
              &amp;adev-&gt;sdma.instance[i].ring.sched;<br>
              -               adev-&gt;vm_manager.vm_pte_rqs[i] =<br>
              +       if (adev-&gt;sdma.has_page_queue) {<br>
              +               sched =
              &amp;adev-&gt;sdma.instance[1].page.sched;<br>
              +               adev-&gt;vm_manager.vm_pte_rqs[0] =<br>
                                      
              &amp;sched-&gt;sched_rq[DRM_SCHED_PRIORITY_KERNEL];<br>
              +               adev-&gt;vm_manager.vm_pte_num_rqs = 1;<br>
              +       } else {<br>
              +               for (i = 0; i &lt;
              adev-&gt;sdma.num_instances; i++) {<br>
              +                       sched =
              &amp;adev-&gt;sdma.instance[i].ring.sched;<br>
              +                       adev-&gt;vm_manager.vm_pte_rqs[i]
              =<br>
              +                              
              &amp;sched-&gt;sched_rq[DRM_SCHED_PRIORITY_KERNEL];<br>
              +               }<br>
              +               adev-&gt;vm_manager.vm_pte_num_rqs =
              adev-&gt;sdma.num_instances;<br>
                       }<br>
              -       adev-&gt;vm_manager.vm_pte_num_rqs =
              adev-&gt;sdma.num_instances;<br>
               }<br>
               <br>
               const struct amdgpu_ip_block_version sdma_v4_0_ip_block =
              {<br>
              --<br>
              2.17.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------436E23763737BFF6759B33DD--

--===============1951266405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1951266405==--

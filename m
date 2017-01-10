From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH_2/7]_drm/amdgpu:new_field_?=
 =?UTF-8?Q?members_for_SRIOV?=
Date: Tue, 10 Jan 2017 10:51:46 +0100
Message-ID: <aec66a0f-0fd7-1e02-f160-999fc76de4a6@vodafone.de>
References: <1483948982-27056-1-git-send-email-Monk.Liu@amd.com>
 <1483948982-27056-3-git-send-email-Monk.Liu@amd.com>
 <9f6b9ab8-3bb1-7a57-75d9-70d23d5dd74b@vodafone.de>
 <BY2PR1201MB11106E7ABC5FF87AF1F6F67A84670@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1809154821=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB11106E7ABC5FF87AF1F6F67A84670-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1809154821==
Content-Type: multipart/alternative;
 boundary="------------9C3BAE0757D969E4ACFAED39"

This is a multi-part message in MIME format.
--------------9C3BAE0757D969E4ACFAED39
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.01.2017 um 04:03 schrieb Liu, Monk:
>
> > +     /* virtual MC address of CSA & GDS for each VM */
> > +     uint64_t vm_csa_addr;
> > +     uint64_t vm_gds_addr;
>
> That should be constant, shouldn't it?
>
>
>
> [ML] do you mean "const uint64_t vm_csa_addr" ? of cause not if that's 
> your point ... compiling error on that
>
> and strictly speaking that's not constant, the address is calculated ...
>

No that wasn't what I meant. The address is constant for all VM's in the 
system, isn't it?

Just add a define similar to AMDGPU_VA_RESERVED_SIZE and stop 
calculating it all together (BTW: AMDGPU_VA_RESERVED_SIZE should 
probably be moved to amdgpu_vm.h).

Regards,
Christian.

> ------------------------------------------------------------------------
> *发件人:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *发送时间:* 2017年1月9日 18:57:06
> *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: [PATCH 2/7] drm/amdgpu:new field members for SRIOV
> Am 09.01.2017 um 09:02 schrieb Monk Liu:
> > Change-Id: Ife0eff7b13b8b5946f005a39f6ecb8db1cb72c38
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 19 +++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  2 ++
> >   2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > index 0d821d9..5aa7f0c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > @@ -28,9 +28,28 @@
> >   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
> enabled on this GPU */
> >   #define AMDGPU_SRIOV_CAPS_IS_VF        (1 << 2) /* this GPU is a 
> virtual function */
> >   #define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU 
> is pass through for VM */
> > +
> > +struct amdgpu_vm;
> >   /* GPU virtualization */
> >   struct amdgpu_virt {
> >        uint32_t caps;
> > +     uint32_t csa_size;
> > +     struct amdgpu_bo *csa_obj;
> > +     uint64_t csa_vmid0_addr;
> > +     uint64_t gds_vmid0_addr;
> > +     int (*allocate_csa)(struct amdgpu_device *adev);
> > +     void (*deallocate_csa)(struct amdgpu_device *adev);
> > +     int (*map_csa)(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> > +     void (*unmap_csa)(struct amdgpu_device *adev, struct amdgpu_vm 
> *vm);
>
> Why callbacks for this?
>
> > +};
> > +
> > +struct amdgpu_vm_virt {
> > +     /* each VM will map on CSA */
> > +     struct ttm_validate_buffer csa_tv;
> > +     struct amdgpu_bo_va *csa_bo_va;
>
> Please put that directly into the amdgpu_vm structure.
>
> > +     /* virtual MC address of CSA & GDS for each VM */
> > +     uint64_t vm_csa_addr;
> > +     uint64_t vm_gds_addr;
>
> That should be constant, shouldn't it?
>
> Regards,
> Christian.
>
> >   };
> >
> >   #define amdgpu_sriov_enabled(adev) \
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > index 42a629b..27cbcbc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -29,6 +29,7 @@
> >   #include "gpu_scheduler.h"
> >   #include "amdgpu_sync.h"
> >   #include "amdgpu_ring.h"
> > +#include "amdgpu_virt.h"
> >
> >   struct amdgpu_bo_va;
> >   struct amdgpu_job;
> > @@ -111,6 +112,7 @@ struct amdgpu_vm {
> >
> >        /* client id */
> >        u64                     client_id;
> > +     struct amdgpu_vm_virt   vm_virt;
> >   };
> >
> >   struct amdgpu_vm_id {
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------9C3BAE0757D969E4ACFAED39
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 10.01.2017 um 04:03 schrieb Liu,
      Monk:<br>
    </div>
    <blockquote
cite="mid:BY2PR1201MB11106E7ABC5FF87AF1F6F67A84670-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p><font size="2"><span style="font-size:10pt">&gt; +     /*
                virtual MC address of CSA &amp; GDS for each VM */<br>
                &gt; +     uint64_t vm_csa_addr;<br>
                &gt; +     uint64_t vm_gds_addr;<br>
                <br>
                That should be constant, shouldn't it?</span></font></p>
          <p><br>
          </p>
          <p><br>
          </p>
          <p>[ML] do you mean "const uint64_t vm_csa_addr" ? of cause
            not if that's your point ... compiling error on that
            <br>
          </p>
          <p>and strictly speaking that's not constant, the address is
            calculated ...<br>
          </p>
        </div>
      </div>
    </blockquote>
    <br>
    No that wasn't what I meant. The address is constant for all VM's in
    the system, isn't it?<br>
    <br>
    Just add a define similar to AMDGPU_VA_RESERVED_SIZE and stop
    calculating it all together (BTW: AMDGPU_VA_RESERVED_SIZE should
    probably be moved to amdgpu_vm.h).<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote
cite="mid:BY2PR1201MB11106E7ABC5FF87AF1F6F67A84670-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年1月9日 18:57:06<br>
            <b>收件人:</b> Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> Re: [PATCH 2/7] drm/amdgpu:new field members for
            SRIOV</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Am 09.01.2017 um 09:02 schrieb Monk
            Liu:<br>
            &gt; Change-Id: Ife0eff7b13b8b5946f005a39f6ecb8db1cb72c38<br>
            &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; ---<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 19
            +++++++++++++++++++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  2 ++<br>
            &gt;   2 files changed, 21 insertions(+)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
            &gt; index 0d821d9..5aa7f0c 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
            &gt; @@ -28,9 +28,28 @@<br>
            &gt;   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 &lt;&lt; 1)
            /* sr-iov is enabled on this GPU */<br>
            &gt;   #define AMDGPU_SRIOV_CAPS_IS_VF        (1 &lt;&lt; 2)
            /* this GPU is a virtual function */<br>
            &gt;   #define AMDGPU_PASSTHROUGH_MODE        (1 &lt;&lt; 3)
            /* thw whole GPU is pass through for VM */<br>
            &gt; +<br>
            &gt; +struct amdgpu_vm;<br>
            &gt;   /* GPU virtualization */<br>
            &gt;   struct amdgpu_virt {<br>
            &gt;        uint32_t caps;<br>
            &gt; +     uint32_t csa_size;<br>
            &gt; +     struct amdgpu_bo *csa_obj;<br>
            &gt; +     uint64_t csa_vmid0_addr;<br>
            &gt; +     uint64_t gds_vmid0_addr;<br>
            &gt; +     int (*allocate_csa)(struct amdgpu_device *adev);<br>
            &gt; +     void (*deallocate_csa)(struct amdgpu_device
            *adev);<br>
            &gt; +     int (*map_csa)(struct amdgpu_device *adev, struct
            amdgpu_vm *vm);<br>
            &gt; +     void (*unmap_csa)(struct amdgpu_device *adev,
            struct amdgpu_vm *vm);<br>
            <br>
            Why callbacks for this?<br>
            <br>
            &gt; +};<br>
            &gt; +<br>
            &gt; +struct amdgpu_vm_virt {<br>
            &gt; +     /* each VM will map on CSA */<br>
            &gt; +     struct ttm_validate_buffer csa_tv;<br>
            &gt; +     struct amdgpu_bo_va *csa_bo_va;<br>
            <br>
            Please put that directly into the amdgpu_vm structure.<br>
            <br>
            &gt; +     /* virtual MC address of CSA &amp; GDS for each
            VM */<br>
            &gt; +     uint64_t vm_csa_addr;<br>
            &gt; +     uint64_t vm_gds_addr;<br>
            <br>
            That should be constant, shouldn't it?<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt;   };<br>
            &gt;   <br>
            &gt;   #define amdgpu_sriov_enabled(adev) \<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
            &gt; index 42a629b..27cbcbc 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
            &gt; @@ -29,6 +29,7 @@<br>
            &gt;   #include "gpu_scheduler.h"<br>
            &gt;   #include "amdgpu_sync.h"<br>
            &gt;   #include "amdgpu_ring.h"<br>
            &gt; +#include "amdgpu_virt.h"<br>
            &gt;   <br>
            &gt;   struct amdgpu_bo_va;<br>
            &gt;   struct amdgpu_job;<br>
            &gt; @@ -111,6 +112,7 @@ struct amdgpu_vm {<br>
            &gt;   <br>
            &gt;        /* client id */<br>
            &gt;        u64                     client_id;<br>
            &gt; +     struct amdgpu_vm_virt   vm_virt;<br>
            &gt;   };<br>
            &gt;   <br>
            &gt;   struct amdgpu_vm_id {<br>
            <br>
            <br>
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

--------------9C3BAE0757D969E4ACFAED39--

--===============1809154821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1809154821==--

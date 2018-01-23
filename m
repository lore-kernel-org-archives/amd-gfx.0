From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top of address
 space
Date: Tue, 23 Jan 2018 09:26:21 +0100
Message-ID: <99bd1b34-e10e-800d-fd35-8166a452fd3e@gmail.com>
References: <20180122104404.1239-1-christian.koenig@amd.com>
 <20180122104404.1239-3-christian.koenig@amd.com>
 <MWHPR1201MB0127D1F3C71A0C2D99A64603FDE30@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <BLUPR12MB04494E357187195CC3C90B0584E30@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BLUPR12MB0449A76D5FB31F4C46AD8BB384E30@BLUPR12MB0449.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1696765583=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449A76D5FB31F4C46AD8BB384E30-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1696765583==
Content-Type: multipart/alternative;
 boundary="------------0258CFB2EA33C7CF6EFDAB9E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0258CFB2EA33C7CF6EFDAB9E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

> Any bug introduced by original design ? I don't see why 8MB- 8KB as 
> the start vm address of CSA has any trouble compared with top range ?
On gfx9 we need the lower address range (0x0-0x7fffffffffff) for 
HMM/ATC/SVM. If we map the 8k CSA in there and hit it by accident then 
the GPU will not do what it is supposed to do :)

I could limit the change to only gfx9, but I think the code will be 
simpler if we change both gfx8 and gfx9.

> Besides, please note that you also need modify gfx8/9 source to align 
> emit_cs/de_meta with your change
That was the design flaw I was talking about. In other words I couldn't 
find the code where that address was actually used.

We should use the macro define in those functions as well. Going to send 
fixed for this in a minute.

Thanks,
Christian.

Am 23.01.2018 um 04:23 schrieb Liu, Monk:
>
> anyway I prefer no change on that part unless there issues or bug need 
> to fix by the change.
>
> the CSA address is for use by CPG h/w not s/w, and since 8MB is a 
> reserved range for each VM I don't see
>
> it's a design flaw with it
>
> ------------------------------------------------------------------------
> *From:* Liu, Monk
> *Sent:* Tuesday, January 23, 2018 11:20:35 AM
> *To:* He, Roger; Christian König; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top 
> of address space
>
> Any bug introduced by original design ? I don't see why 8MB- 8KB as 
> the start vm address of CSA has any trouble compared with top range ? 
> Besides, please note that you also need modify gfx8/9 source to align 
> emit_cs/de_meta with your change
>
>
>
> ------------------------------------------------------------------------
> *From:* He, Roger
> *Sent:* Tuesday, January 23, 2018 10:36:31 AM
> *To:* Christian König; Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* RE: [PATCH 3/3] drm/amdgpu: move static CSA address to top 
> of address space
>
>
> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf 
> Of Christian K?nig
> Sent: Monday, January 22, 2018 6:44 PM
> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: [PATCH 3/3] drm/amdgpu: move static CSA address to top of 
> address space
>
> There seems to be a design flaw with this since the address of the 
> static CSA is never exported anywhere.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 15 +++++++-------- 
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  6 ++++--
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e7dfb7b44b4b..c7d24af03e3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -55,11 +55,10 @@ void amdgpu_free_static_csa(struct amdgpu_device 
> *adev) {
>
>  /*
>   * amdgpu_map_static_csa should be called during amdgpu_vm_init
> - * it maps virtual address "AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE"
> - * to this VM, and each command submission of GFX should use this virtual
> - * address within META_DATA init package to support SRIOV gfx preemption.
> + * it maps virtual address "AMDGPU_CSA_VADDR" to this VM, and each
> + command
> + * submission of GFX should use this virtual address within META_DATA
> + init
> + * package to support SRIOV gfx preemption.
>   */
> -
>  int amdgpu_map_static_csa(struct amdgpu_device *adev, struct 
> amdgpu_vm *vm,
>                            struct amdgpu_bo_va **bo_va)
>  {
> @@ -90,7 +89,7 @@ int amdgpu_map_static_csa(struct amdgpu_device 
> *adev, struct amdgpu_vm *vm,
>                  return -ENOMEM;
>          }
>
> -       r = amdgpu_vm_alloc_pts(adev, (*bo_va)->base.vm, AMDGPU_CSA_VADDR,
> +       r = amdgpu_vm_alloc_pts(adev, (*bo_va)->base.vm,
> +AMDGPU_CSA_VADDR(adev),
>                                  AMDGPU_CSA_SIZE);
>          if (r) {
>                  DRM_ERROR("failed to allocate pts for static CSA, 
> err=%d\n", r); @@ -99,9 +98,9 @@ int amdgpu_map_static_csa(struct 
> amdgpu_device *adev, struct amdgpu_vm *vm,
>                  return r;
>          }
>
> -       r = amdgpu_vm_bo_map(adev, *bo_va, AMDGPU_CSA_VADDR, 0, 
> AMDGPU_CSA_SIZE,
> -                            AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
> -                            AMDGPU_PTE_EXECUTABLE);
> +       r = amdgpu_vm_bo_map(adev, *bo_va, AMDGPU_CSA_VADDR(adev), 0,
> +                            AMDGPU_CSA_SIZE, AMDGPU_PTE_READABLE |
> +                            AMDGPU_PTE_WRITEABLE | 
> AMDGPU_PTE_EXECUTABLE);
>
>          if (r) {
>                  DRM_ERROR("failed to do bo_map on static CSA, 
> err=%d\n", r); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 6a83425aa9ed..499362b55e45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -251,8 +251,10 @@ struct amdgpu_virt {
>          uint32_t gim_feature;
>  };
>
> -#define AMDGPU_CSA_SIZE    (8 * 1024)
> -#define AMDGPU_CSA_VADDR   (AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE)
> +#define AMDGPU_CSA_SIZE                (8 * 1024)
> +#define AMDGPU_CSA_VADDR(adev) \
>         +       (((adev)->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) + \
>         +        AMDGPU_VA_RESERVED_SIZE)
>
> If I  understand your intention correctly, it should be that:
> +       (((adev)->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT)  - \
> +        AMDGPU_VA_RESERVED_SIZE)
>
> Thanks
> Roger(Hongbo.He)
>
>  #define amdgpu_sriov_enabled(adev) \
>  ((adev)->virt.caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)
> --
> 2.14.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------0258CFB2EA33C7CF6EFDAB9E
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">Any bug introduced by original design ? I
        don't see why 8MB- 8KB as the start vm address of CSA has any
        trouble compared with top range ?</blockquote>
      On gfx9 we need the lower address range (0x0-0x7fffffffffff) for
      HMM/ATC/SVM. If we map the 8k CSA in there and hit it by accident
      then the GPU will not do what it is supposed to do :)<br>
      <br>
      I could limit the change to only gfx9, but I think the code will
      be simpler if we change both gfx8 and gfx9.<br>
      <br>
      <blockquote type="cite">Besides, please note that you also need
        modify gfx8/9 source to align emit_cs/de_meta with your change</blockquote>
      That was the design flaw I was talking about. In other words I
      couldn't find the code where that address was actually used.<br>
      <br>
      We should use the macro define in those functions as well. Going
      to send fixed for this in a minute.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 23.01.2018 um 04:23 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449A76D5FB31F4C46AD8BB384E30-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">anyway I prefer no
          change on that part unless there issues or bug need to fix by
          the change.</p>
        <p style="margin-top:0;margin-bottom:0">the CSA address is for
          use by CPG h/w not s/w, and since 8MB is a reserved range for
          each VM I don't see</p>
        <p style="margin-top:0;margin-bottom:0">it's a design flaw with
          it<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b> Liu,
          Monk<br>
          <b>Sent:</b> Tuesday, January 23, 2018 11:20:35 AM<br>
          <b>To:</b> He, Roger; Christian König;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: move static CSA
          address to top of address space</font>
        <div> </div>
      </div>
      <style type="text/css" style="display:none">
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
          <p style="margin-top:0; margin-bottom:0">Any bug introduced by
            original design ? I don't see why 8MB- 8KB as the start vm
            address of CSA has any trouble compared with top range ?
            Besides, please note that you also need modify gfx8/9 source
            to align emit_cs/de_meta with your change</p>
          <p style="margin-top:0; margin-bottom:0"><br>
          </p>
          <p style="margin-top:0; margin-bottom:0"><br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b> He,
            Roger<br>
            <b>Sent:</b> Tuesday, January 23, 2018 10:36:31 AM<br>
            <b>To:</b> Christian König; Liu, Monk;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>Subject:</b> RE: [PATCH 3/3] drm/amdgpu: move static CSA
            address to top of address space</font>
          <div> </div>
        </div>
        <div class="x_BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="x_PlainText"><br>
                <br>
                -----Original Message-----<br>
                From: amd-gfx [<a
                  href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                  moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                On Behalf Of Christian K?nig<br>
                Sent: Monday, January 22, 2018 6:44 PM<br>
                To: Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                Subject: [PATCH 3/3] drm/amdgpu: move static CSA address
                to top of address space<br>
                <br>
                There seems to be a design flaw with this since the
                address of the static CSA is never exported anywhere.<br>
                <br>
                Signed-off-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 15
                +++++++-------- 
                drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  6 ++++--<br>
                 2 files changed, 11 insertions(+), 10 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
                index e7dfb7b44b4b..c7d24af03e3e 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
                @@ -55,11 +55,10 @@ void amdgpu_free_static_csa(struct
                amdgpu_device *adev) {<br>
                 <br>
                 /*<br>
                  * amdgpu_map_static_csa should be called during
                amdgpu_vm_init<br>
                - * it maps virtual address "AMDGPU_VA_RESERVED_SIZE -
                AMDGPU_CSA_SIZE"<br>
                - * to this VM, and each command submission of GFX
                should use this virtual<br>
                - * address within META_DATA init package to support
                SRIOV gfx preemption.<br>
                + * it maps virtual address "AMDGPU_CSA_VADDR" to this
                VM, and each <br>
                + command<br>
                + * submission of GFX should use this virtual address
                within META_DATA <br>
                + init<br>
                + * package to support SRIOV gfx preemption.<br>
                  */<br>
                -<br>
                 int amdgpu_map_static_csa(struct amdgpu_device *adev,
                struct amdgpu_vm *vm,<br>
                                           struct amdgpu_bo_va **bo_va)<br>
                 {<br>
                @@ -90,7 +89,7 @@ int amdgpu_map_static_csa(struct
                amdgpu_device *adev, struct amdgpu_vm *vm,<br>
                                 return -ENOMEM;<br>
                         }<br>
                 <br>
                -       r = amdgpu_vm_alloc_pts(adev,
                (*bo_va)-&gt;base.vm, AMDGPU_CSA_VADDR,<br>
                +       r = amdgpu_vm_alloc_pts(adev,
                (*bo_va)-&gt;base.vm, <br>
                +AMDGPU_CSA_VADDR(adev),<br>
                                                 AMDGPU_CSA_SIZE);<br>
                         if (r) {<br>
                                 DRM_ERROR("failed to allocate pts for
                static CSA, err=%d\n", r); @@ -99,9 +98,9 @@ int
                amdgpu_map_static_csa(struct amdgpu_device *adev, struct
                amdgpu_vm *vm,<br>
                                 return r;<br>
                         }<br>
                 <br>
                -       r = amdgpu_vm_bo_map(adev, *bo_va,
                AMDGPU_CSA_VADDR, 0, AMDGPU_CSA_SIZE,<br>
                -                            AMDGPU_PTE_READABLE |
                AMDGPU_PTE_WRITEABLE |<br>
                -                            AMDGPU_PTE_EXECUTABLE);<br>
                +       r = amdgpu_vm_bo_map(adev, *bo_va,
                AMDGPU_CSA_VADDR(adev), 0,<br>
                +                            AMDGPU_CSA_SIZE,
                AMDGPU_PTE_READABLE |<br>
                +                            AMDGPU_PTE_WRITEABLE |
                AMDGPU_PTE_EXECUTABLE);<br>
                 <br>
                         if (r) {<br>
                                 DRM_ERROR("failed to do bo_map on
                static CSA, err=%d\n", r); diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                index 6a83425aa9ed..499362b55e45 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                @@ -251,8 +251,10 @@ struct amdgpu_virt {<br>
                         uint32_t gim_feature;<br>
                 };<br>
                 <br>
                -#define AMDGPU_CSA_SIZE    (8 * 1024)<br>
                -#define AMDGPU_CSA_VADDR   (AMDGPU_VA_RESERVED_SIZE -
                AMDGPU_CSA_SIZE)<br>
                +#define AMDGPU_CSA_SIZE                (8 * 1024)<br>
                +#define AMDGPU_CSA_VADDR(adev) \<br>
                        +       (((adev)-&gt;vm_manager.max_pfn &lt;&lt;
                AMDGPU_GPU_PAGE_SHIFT) + \<br>
                        +        AMDGPU_VA_RESERVED_SIZE)<br>
                 <br>
                If I  understand your intention correctly, it should be
                that: <br>
                +       (((adev)-&gt;vm_manager.max_pfn &lt;&lt;
                AMDGPU_GPU_PAGE_SHIFT)  - \<br>
                +        AMDGPU_VA_RESERVED_SIZE)<br>
                <br>
                Thanks<br>
                Roger(Hongbo.He)<br>
                <br>
                 #define amdgpu_sriov_enabled(adev) \<br>
                 ((adev)-&gt;virt.caps &amp;
                AMDGPU_SRIOV_CAPS_ENABLE_IOV)<br>
                --<br>
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
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------0258CFB2EA33C7CF6EFDAB9E--

--===============1696765583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1696765583==--

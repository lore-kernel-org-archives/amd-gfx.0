From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: XGMI pstate switch initial support
Date: Tue, 26 Mar 2019 17:55:38 +0100
Message-ID: <31050083-2914-0238-14fd-488fb9bb8a06@gmail.com>
References: <1553282911-11125-1-git-send-email-shaoyun.liu@amd.com>
 <0baa3321-72d1-f7bf-b09b-39a380971dca@amd.com>
 <DM6PR12MB3241D607634C7D7A58742D3BF45F0@DM6PR12MB3241.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1313141181=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB3241D607634C7D7A58742D3BF45F0-lmeGfMZKVrEShx2hYn8pVQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1313141181==
Content-Type: multipart/alternative;
 boundary="------------5CD103F3D3E211268113E66C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5CD103F3D3E211268113E66C
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

The problem is that userspace could add it first and then change the domain.

Pretty unlikely thought,
Christian.

Am 26.03.19 um 14:15 schrieb Liu, Shaoyun:
> I think in a real usage  ( tensorflow ex),  it's rarely only the 
> system memory (no vram) will be mapped for peer access.
> Anyway, how about add preferred_domain check for xgmi ? I think even 
> user use ioctl to change the preferred_domain,  bo_add should still be 
> called before the real mapping.
>
> Regards
> Shaoyun.liu
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> *Sent:* March 25, 2019 6:28:32 PM
> *To:* Liu, Shaoyun; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amdgpu: XGMI pstate switch initial support
> I don't see any check for the memory type. As far as I can tell you'll
> power up XGMI even for system memory mappings. See inline.
>
> On 2019-03-22 3:28 p.m., Liu, Shaoyun wrote:
> > Driver vote low to high pstate switch whenever there is an outstanding
> > XGMI mapping request. Driver vote high to low pstate when all the
> > outstanding XGMI mapping is terminated.
> >
> > Change-Id: I197501f853c47f844055c0e28c0ac00a1ff06607
> > Signed-off-by: shaoyunl <shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 21 +++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 ++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 16 +++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   | 10 ++++++++++
> >   6 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index ec9562d..c4c61e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2018,6 +2018,10 @@ static void 
> amdgpu_device_ip_late_init_func_handler(struct work_struct *work)
> >        r = amdgpu_device_enable_mgpu_fan_boost();
> >        if (r)
> >                DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
> > +
> > +     /*set to low pstate by default */
> > +     amdgpu_xgmi_set_pstate(adev, 0);
> > +
> >   }
> >
> >   static void amdgpu_device_delay_enable_gfx_off(struct work_struct 
> *work)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > index 220a6a7..c430e82 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -72,6 +72,8 @@ struct amdgpu_bo_va {
> >
> >        /* If the mappings are cleared or filled */
> >        bool                            cleared;
> > +
> > +     bool                            is_xgmi;
> >   };
> >
> >   struct amdgpu_bo {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 729da1c..a7247d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -34,6 +34,7 @@
> >   #include "amdgpu_trace.h"
> >   #include "amdgpu_amdkfd.h"
> >   #include "amdgpu_gmc.h"
> > +#include "amdgpu_xgmi.h"
> >
> >   /**
> >    * DOC: GPUVM
> > @@ -2072,6 +2073,15 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct 
> amdgpu_device *adev,
> >        INIT_LIST_HEAD(&bo_va->valids);
> >        INIT_LIST_HEAD(&bo_va->invalids);
> >
> > +     if (bo && amdgpu_xgmi_same_hive(adev, 
> amdgpu_ttm_adev(bo->tbo.bdev))) {
> > +             bo_va->is_xgmi = true;
>
> You're setting this to true even for system memory BOs that don't
> involve XGMI mappings. That means you'll power up XGMI unnecessarily in
> many cases because KFD processes always have system memory mappings that
> are mapped to all GPUs (e.g. the signal page).
>
> Regards,
>    Felix
>
>
> > + mutex_lock(&adev->vm_manager.lock_pstate);
> > +             /* Power up XGMI if it can be potentially used */
> > +             if (++adev->vm_manager.xgmi_map_counter == 1)
> > +                     amdgpu_xgmi_set_pstate(adev, 1);
> > + mutex_unlock(&adev->vm_manager.lock_pstate);
> > +     }
> > +
> >        return bo_va;
> >   }
> >
> > @@ -2490,6 +2500,14 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
> >        }
> >
> >        dma_fence_put(bo_va->last_pt_update);
> > +
> > +     if (bo && bo_va->is_xgmi) {
> > + mutex_lock(&adev->vm_manager.lock_pstate);
> > +             if (--adev->vm_manager.xgmi_map_counter == 0)
> > +                     amdgpu_xgmi_set_pstate(adev, 0);
> > + mutex_unlock(&adev->vm_manager.lock_pstate);
> > +     }
> > +
> >        kfree(bo_va);
> >   }
> >
> > @@ -2997,6 +3015,9 @@ void amdgpu_vm_manager_init(struct 
> amdgpu_device *adev)
> >
> >        idr_init(&adev->vm_manager.pasid_idr);
> > spin_lock_init(&adev->vm_manager.pasid_lock);
> > +
> > +     adev->vm_manager.xgmi_map_counter = 0;
> > + mutex_init(&adev->vm_manager.lock_pstate);
> >   }
> >
> >   /**
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > index 520122b..f586b38 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -324,6 +324,10 @@ struct amdgpu_vm_manager {
> >         */
> >        struct idr pasid_idr;
> >        spinlock_t pasid_lock;
> > +
> > +     /* counter of mapped memory through xgmi */
> > +     uint32_t xgmi_map_counter;
> > +     struct mutex lock_pstate;
> >   };
> >
> >   #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) 
> ((adev)->vm_manager.vm_pte_funcs->copy_pte((ib), (pe), (src), (count)))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > index fcc4b05..3368347 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > @@ -200,12 +200,26 @@ struct amdgpu_hive_info 
> *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo
> >
> >        if (lock)
> >                mutex_lock(&tmp->hive_lock);
> > -
> > +     tmp->pstate = -1;
> >        mutex_unlock(&xgmi_mutex);
> >
> >        return tmp;
> >   }
> >
> > +int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
> > +{
> > +     int ret = 0;
> > +     struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
> > +
> > +     if (!hive)
> > +             return 0;
> > +
> > +     if (hive->pstate == pstate)
> > +             return 0;
> > +     /* Todo : sent the message to SMU for pstate change */
> > +     return ret;
> > +}
> > +
> >   int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, 
> struct amdgpu_device *adev)
> >   {
> >        int ret = -EINVAL;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > index 24a3b03..3e9c91e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > @@ -33,11 +33,21 @@ struct amdgpu_hive_info {
> >        struct kobject *kobj;
> >        struct device_attribute dev_attr;
> >        struct amdgpu_device *adev;
> > +     int pstate; /*0 -- low , 1 -- high , -1 unknown*/
> >   };
> >
> >   struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device 
> *adev, int lock);
> >   int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, 
> struct amdgpu_device *adev);
> >   int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
> >   void amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
> > +int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
> > +
> > +static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> > +             struct amdgpu_device *bo_adev)
> > +{
> > +     return (adev != bo_adev &&
> > +             adev->gmc.xgmi.hive_id &&
> > +             adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
> > +}
> >
> >   #endif
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------5CD103F3D3E211268113E66C
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">The problem is that userspace could add
      it first and then change the domain.<br>
      <br>
      Pretty unlikely thought,<br>
      Christian.<br>
      <br>
      Am 26.03.19 um 14:15 schrieb Liu, Shaoyun:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM6PR12MB3241D607634C7D7A58742D3BF45F0-lmeGfMZKVrEShx2hYn8pVQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      I think in a real usage  ( tensorflow ex),  it's rarely only the
      system memory (no vram) will be mapped for peer access.
      <br>
      Anyway, how about add preferred_domain check for xgmi ? I think
      even user use ioctl to change the preferred_domain,  bo_add should
      still be called before the real mapping.
      <br>
      <br>
      Regards<br>
      Shaoyun.liu
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> March 25, 2019 6:28:32 PM<br>
          <b>To:</b> Liu, Shaoyun; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> Re: [PATCH] drm/amdgpu: XGMI pstate switch
          initial support</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">I don't see any check for the memory
              type. As far as I can tell you'll
              <br>
              power up XGMI even for system memory mappings. See inline.<br>
              <br>
              On 2019-03-22 3:28 p.m., Liu, Shaoyun wrote:<br>
              &gt; Driver vote low to high pstate switch whenever there
              is an outstanding<br>
              &gt; XGMI mapping request. Driver vote high to low pstate
              when all the<br>
              &gt; outstanding XGMI mapping is terminated.<br>
              &gt;<br>
              &gt; Change-Id: I197501f853c47f844055c0e28c0ac00a1ff06607<br>
              &gt; Signed-off-by: shaoyunl <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu-5C7GfCeVMHo@public.gmane.org">&lt;shaoyun.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; ---<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4
              ++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 21
              +++++++++++++++++++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4
              ++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 16
              +++++++++++++++-<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   | 10
              ++++++++++<br>
              &gt;   6 files changed, 56 insertions(+), 1 deletion(-)<br>
              &gt;<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt; index ec9562d..c4c61e9 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt; @@ -2018,6 +2018,10 @@ static void
              amdgpu_device_ip_late_init_func_handler(struct work_struct
              *work)<br>
              &gt;        r = amdgpu_device_enable_mgpu_fan_boost();<br>
              &gt;        if (r)<br>
              &gt;                DRM_ERROR("enable mgpu fan boost
              failed (%d).\n", r);<br>
              &gt; +<br>
              &gt; +     /*set to low pstate by default */<br>
              &gt; +     amdgpu_xgmi_set_pstate(adev, 0);<br>
              &gt; +<br>
              &gt;   }<br>
              &gt;   <br>
              &gt;   static void
              amdgpu_device_delay_enable_gfx_off(struct work_struct
              *work)<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
              &gt; index 220a6a7..c430e82 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
              &gt; @@ -72,6 +72,8 @@ struct amdgpu_bo_va {<br>
              &gt;   <br>
              &gt;        /* If the mappings are cleared or filled */<br>
              &gt;        bool                            cleared;<br>
              &gt; +<br>
              &gt; +     bool                            is_xgmi;<br>
              &gt;   };<br>
              &gt;   <br>
              &gt;   struct amdgpu_bo {<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
              &gt; index 729da1c..a7247d5 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
              &gt; @@ -34,6 +34,7 @@<br>
              &gt;   #include "amdgpu_trace.h"<br>
              &gt;   #include "amdgpu_amdkfd.h"<br>
              &gt;   #include "amdgpu_gmc.h"<br>
              &gt; +#include "amdgpu_xgmi.h"<br>
              &gt;   <br>
              &gt;   /**<br>
              &gt;    * DOC: GPUVM<br>
              &gt; @@ -2072,6 +2073,15 @@ struct amdgpu_bo_va
              *amdgpu_vm_bo_add(struct amdgpu_device *adev,<br>
              &gt;        INIT_LIST_HEAD(&amp;bo_va-&gt;valids);<br>
              &gt;        INIT_LIST_HEAD(&amp;bo_va-&gt;invalids);<br>
              &gt;   <br>
              &gt; +     if (bo &amp;&amp; amdgpu_xgmi_same_hive(adev,
              amdgpu_ttm_adev(bo-&gt;tbo.bdev))) {<br>
              &gt; +             bo_va-&gt;is_xgmi = true;<br>
              <br>
              You're setting this to true even for system memory BOs
              that don't <br>
              involve XGMI mappings. That means you'll power up XGMI
              unnecessarily in <br>
              many cases because KFD processes always have system memory
              mappings that <br>
              are mapped to all GPUs (e.g. the signal page).<br>
              <br>
              Regards,<br>
                 Felix<br>
              <br>
              <br>
              &gt; +            
              mutex_lock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
              &gt; +             /* Power up XGMI if it can be
              potentially used */<br>
              &gt; +             if
              (++adev-&gt;vm_manager.xgmi_map_counter == 1)<br>
              &gt; +                     amdgpu_xgmi_set_pstate(adev,
              1);<br>
              &gt; +            
              mutex_unlock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt;        return bo_va;<br>
              &gt;   }<br>
              &gt;   <br>
              &gt; @@ -2490,6 +2500,14 @@ void amdgpu_vm_bo_rmv(struct
              amdgpu_device *adev,<br>
              &gt;        }<br>
              &gt;   <br>
              &gt;        dma_fence_put(bo_va-&gt;last_pt_update);<br>
              &gt; +<br>
              &gt; +     if (bo &amp;&amp; bo_va-&gt;is_xgmi) {<br>
              &gt; +            
              mutex_lock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
              &gt; +             if
              (--adev-&gt;vm_manager.xgmi_map_counter == 0)<br>
              &gt; +                     amdgpu_xgmi_set_pstate(adev,
              0);<br>
              &gt; +            
              mutex_unlock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt;        kfree(bo_va);<br>
              &gt;   }<br>
              &gt;   <br>
              &gt; @@ -2997,6 +3015,9 @@ void
              amdgpu_vm_manager_init(struct amdgpu_device *adev)<br>
              &gt;   <br>
              &gt;        idr_init(&amp;adev-&gt;vm_manager.pasid_idr);<br>
              &gt;       
              spin_lock_init(&amp;adev-&gt;vm_manager.pasid_lock);<br>
              &gt; +<br>
              &gt; +     adev-&gt;vm_manager.xgmi_map_counter = 0;<br>
              &gt; +    
              mutex_init(&amp;adev-&gt;vm_manager.lock_pstate);<br>
              &gt;   }<br>
              &gt;   <br>
              &gt;   /**<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
              &gt; index 520122b..f586b38 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
              &gt; @@ -324,6 +324,10 @@ struct amdgpu_vm_manager {<br>
              &gt;         */<br>
              &gt;        struct idr                             
              pasid_idr;<br>
              &gt;        spinlock_t                             
              pasid_lock;<br>
              &gt; +<br>
              &gt; +     /* counter of mapped memory through xgmi */<br>
              &gt; +     uint32_t                               
              xgmi_map_counter;<br>
              &gt; +     struct mutex                           
              lock_pstate;<br>
              &gt;   };<br>
              &gt;   <br>
              &gt;   #define amdgpu_vm_copy_pte(adev, ib, pe, src,
              count)
              ((adev)-&gt;vm_manager.vm_pte_funcs-&gt;copy_pte((ib),
              (pe), (src), (count)))<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
              &gt; index fcc4b05..3368347 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
              &gt; @@ -200,12 +200,26 @@ struct amdgpu_hive_info
              *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo<br>
              &gt;   <br>
              &gt;        if (lock)<br>
              &gt;                mutex_lock(&amp;tmp-&gt;hive_lock);<br>
              &gt; -<br>
              &gt; +     tmp-&gt;pstate = -1;<br>
              &gt;        mutex_unlock(&amp;xgmi_mutex);<br>
              &gt;   <br>
              &gt;        return tmp;<br>
              &gt;   }<br>
              &gt;   <br>
              &gt; +int amdgpu_xgmi_set_pstate(struct amdgpu_device
              *adev, int pstate)<br>
              &gt; +{<br>
              &gt; +     int ret = 0;<br>
              &gt; +     struct amdgpu_hive_info *hive =
              amdgpu_get_xgmi_hive(adev, 0);<br>
              &gt; +<br>
              &gt; +     if (!hive)<br>
              &gt; +             return 0;<br>
              &gt; +<br>
              &gt; +     if (hive-&gt;pstate == pstate)<br>
              &gt; +             return 0;<br>
              &gt; +     /* Todo : sent the message to SMU for pstate
              change */<br>
              &gt; +     return ret;<br>
              &gt; +}<br>
              &gt; +<br>
              &gt;   int amdgpu_xgmi_update_topology(struct
              amdgpu_hive_info *hive, struct amdgpu_device *adev)<br>
              &gt;   {<br>
              &gt;        int ret = -EINVAL;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
              &gt; index 24a3b03..3e9c91e 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
              &gt; @@ -33,11 +33,21 @@ struct amdgpu_hive_info {<br>
              &gt;        struct kobject *kobj;<br>
              &gt;        struct device_attribute dev_attr;<br>
              &gt;        struct amdgpu_device *adev;<br>
              &gt; +     int pstate; /*0 -- low , 1 -- high , -1
              unknown*/<br>
              &gt;   };<br>
              &gt;   <br>
              &gt;   struct amdgpu_hive_info
              *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int
              lock);<br>
              &gt;   int amdgpu_xgmi_update_topology(struct
              amdgpu_hive_info *hive, struct amdgpu_device *adev);<br>
              &gt;   int amdgpu_xgmi_add_device(struct amdgpu_device
              *adev);<br>
              &gt;   void amdgpu_xgmi_remove_device(struct amdgpu_device
              *adev);<br>
              &gt; +int amdgpu_xgmi_set_pstate(struct amdgpu_device
              *adev, int pstate);<br>
              &gt; +<br>
              &gt; +static inline bool amdgpu_xgmi_same_hive(struct
              amdgpu_device *adev,<br>
              &gt; +             struct amdgpu_device *bo_adev)<br>
              &gt; +{<br>
              &gt; +     return (adev != bo_adev &amp;&amp;<br>
              &gt; +             adev-&gt;gmc.xgmi.hive_id &amp;&amp;<br>
              &gt; +             adev-&gt;gmc.xgmi.hive_id ==
              bo_adev-&gt;gmc.xgmi.hive_id);<br>
              &gt; +}<br>
              &gt;   <br>
              &gt;   #endif<br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
          </span></font></div>
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

--------------5CD103F3D3E211268113E66C--

--===============1313141181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1313141181==--

From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: XGMI pstate switch initial support
Date: Tue, 26 Mar 2019 13:15:49 +0000
Message-ID: <DM6PR12MB3241D607634C7D7A58742D3BF45F0@DM6PR12MB3241.namprd12.prod.outlook.com>
References: <1553282911-11125-1-git-send-email-shaoyun.liu@amd.com>,
 <0baa3321-72d1-f7bf-b09b-39a380971dca@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1761861554=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0baa3321-72d1-f7bf-b09b-39a380971dca-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1761861554==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3241D607634C7D7A58742D3BF45F0DM6PR12MB3241namp_"

--_000_DM6PR12MB3241D607634C7D7A58742D3BF45F0DM6PR12MB3241namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think in a real usage  ( tensorflow ex),  it's rarely only the system mem=
ory (no vram) will be mapped for peer access.
Anyway, how about add preferred_domain check for xgmi ? I think even user u=
se ioctl to change the preferred_domain,  bo_add should still be called bef=
ore the real mapping.

Regards
Shaoyun.liu
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kuehling=
, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: March 25, 2019 6:28:32 PM
To: Liu, Shaoyun; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: XGMI pstate switch initial support

I don't see any check for the memory type. As far as I can tell you'll
power up XGMI even for system memory mappings. See inline.

On 2019-03-22 3:28 p.m., Liu, Shaoyun wrote:
> Driver vote low to high pstate switch whenever there is an outstanding
> XGMI mapping request. Driver vote high to low pstate when all the
> outstanding XGMI mapping is terminated.
>
> Change-Id: I197501f853c47f844055c0e28c0ac00a1ff06607
> Signed-off-by: shaoyunl <shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 21 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 16 +++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   | 10 ++++++++++
>   6 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index ec9562d..c4c61e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2018,6 +2018,10 @@ static void amdgpu_device_ip_late_init_func_handle=
r(struct work_struct *work)
>        r =3D amdgpu_device_enable_mgpu_fan_boost();
>        if (r)
>                DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
> +
> +     /*set to low pstate by default */
> +     amdgpu_xgmi_set_pstate(adev, 0);
> +
>   }
>
>   static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work=
)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index 220a6a7..c430e82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -72,6 +72,8 @@ struct amdgpu_bo_va {
>
>        /* If the mappings are cleared or filled */
>        bool                            cleared;
> +
> +     bool                            is_xgmi;
>   };
>
>   struct amdgpu_bo {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 729da1c..a7247d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -34,6 +34,7 @@
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_gmc.h"
> +#include "amdgpu_xgmi.h"
>
>   /**
>    * DOC: GPUVM
> @@ -2072,6 +2073,15 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgp=
u_device *adev,
>        INIT_LIST_HEAD(&bo_va->valids);
>        INIT_LIST_HEAD(&bo_va->invalids);
>
> +     if (bo && amdgpu_xgmi_same_hive(adev, amdgpu_ttm_adev(bo->tbo.bdev)=
)) {
> +             bo_va->is_xgmi =3D true;

You're setting this to true even for system memory BOs that don't
involve XGMI mappings. That means you'll power up XGMI unnecessarily in
many cases because KFD processes always have system memory mappings that
are mapped to all GPUs (e.g. the signal page).

Regards,
   Felix


> +             mutex_lock(&adev->vm_manager.lock_pstate);
> +             /* Power up XGMI if it can be potentially used */
> +             if (++adev->vm_manager.xgmi_map_counter =3D=3D 1)
> +                     amdgpu_xgmi_set_pstate(adev, 1);
> +             mutex_unlock(&adev->vm_manager.lock_pstate);
> +     }
> +
>        return bo_va;
>   }
>
> @@ -2490,6 +2500,14 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
>        }
>
>        dma_fence_put(bo_va->last_pt_update);
> +
> +     if (bo && bo_va->is_xgmi) {
> +             mutex_lock(&adev->vm_manager.lock_pstate);
> +             if (--adev->vm_manager.xgmi_map_counter =3D=3D 0)
> +                     amdgpu_xgmi_set_pstate(adev, 0);
> +             mutex_unlock(&adev->vm_manager.lock_pstate);
> +     }
> +
>        kfree(bo_va);
>   }
>
> @@ -2997,6 +3015,9 @@ void amdgpu_vm_manager_init(struct amdgpu_device *a=
dev)
>
>        idr_init(&adev->vm_manager.pasid_idr);
>        spin_lock_init(&adev->vm_manager.pasid_lock);
> +
> +     adev->vm_manager.xgmi_map_counter =3D 0;
> +     mutex_init(&adev->vm_manager.lock_pstate);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 520122b..f586b38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -324,6 +324,10 @@ struct amdgpu_vm_manager {
>         */
>        struct idr                              pasid_idr;
>        spinlock_t                              pasid_lock;
> +
> +     /* counter of mapped memory through xgmi */
> +     uint32_t                                xgmi_map_counter;
> +     struct mutex                            lock_pstate;
>   };
>
>   #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) ((adev)->vm_manage=
r.vm_pte_funcs->copy_pte((ib), (pe), (src), (count)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index fcc4b05..3368347 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -200,12 +200,26 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struc=
t amdgpu_device *adev, int lo
>
>        if (lock)
>                mutex_lock(&tmp->hive_lock);
> -
> +     tmp->pstate =3D -1;
>        mutex_unlock(&xgmi_mutex);
>
>        return tmp;
>   }
>
> +int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
> +{
> +     int ret =3D 0;
> +     struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev, 0);
> +
> +     if (!hive)
> +             return 0;
> +
> +     if (hive->pstate =3D=3D pstate)
> +             return 0;
> +     /* Todo : sent the message to SMU for pstate change */
> +     return ret;
> +}
> +
>   int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct a=
mdgpu_device *adev)
>   {
>        int ret =3D -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.h
> index 24a3b03..3e9c91e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -33,11 +33,21 @@ struct amdgpu_hive_info {
>        struct kobject *kobj;
>        struct device_attribute dev_attr;
>        struct amdgpu_device *adev;
> +     int pstate; /*0 -- low , 1 -- high , -1 unknown*/
>   };
>
>   struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *ade=
v, int lock);
>   int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct a=
mdgpu_device *adev);
>   int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
>   void amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
> +int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
> +
> +static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> +             struct amdgpu_device *bo_adev)
> +{
> +     return (adev !=3D bo_adev &&
> +             adev->gmc.xgmi.hive_id &&
> +             adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id);
> +}
>
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB3241D607634C7D7A58742D3BF45F0DM6PR12MB3241namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
I think in a real usage&nbsp; ( tensorflow ex),&nbsp; it's rarely only the =
system memory (no vram) will be mapped for peer access.
<br>
Anyway, how about add preferred_domain check for xgmi ? I think even user u=
se ioctl to change the preferred_domain,&nbsp; bo_add should still be calle=
d before the real mapping.
<br>
<br>
Regards<br>
Shaoyun.liu
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kuehling, Felix &lt;Felix.Kue=
hling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> March 25, 2019 6:28:32 PM<br>
<b>To:</b> Liu, Shaoyun; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: XGMI pstate switch initial support<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I don't see any check for the memory type. As far =
as I can tell you'll
<br>
power up XGMI even for system memory mappings. See inline.<br>
<br>
On 2019-03-22 3:28 p.m., Liu, Shaoyun wrote:<br>
&gt; Driver vote low to high pstate switch whenever there is an outstanding=
<br>
&gt; XGMI mapping request. Driver vote high to low pstate when all the<br>
&gt; outstanding XGMI mapping is terminated.<br>
&gt;<br>
&gt; Change-Id: I197501f853c47f844055c0e28c0ac00a1ff06607<br>
&gt; Signed-off-by: shaoyunl &lt;shaoyun.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 4 &#43;=
&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 2 &#43;=
&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 21 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 4 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp; | 16 =
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; | 10 =
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 6 files changed, 56 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index ec9562d..c4c61e9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2018,6 &#43;2018,10 @@ static void amdgpu_device_ip_late_init_func=
_handler(struct work_struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_enable_m=
gpu_fan_boost();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&qu=
ot;, r);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /*set to low pstate by default */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_set_pstate(adev, 0);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void amdgpu_device_delay_enable_gfx_off(struct work=
_struct *work)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.h<br>
&gt; index 220a6a7..c430e82 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; @@ -72,6 &#43;72,8 @@ struct amdgpu_bo_va {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If the mappings are clear=
ed or filled */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cleared;<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_xgmi;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_bo {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 729da1c..a7247d5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -34,6 &#43;34,7 @@<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_gmc.h&quot;<br>
&gt; &#43;#include &quot;amdgpu_xgmi.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * DOC: GPUVM<br>
&gt; @@ -2072,6 &#43;2073,15 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struc=
t amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;bo_va-&g=
t;valids);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;bo_va-&g=
t;invalids);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (bo &amp;&amp; amdgpu_xgmi_same_hive(=
adev, amdgpu_ttm_adev(bo-&gt;tbo.bdev))) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; bo_va-&gt;is_xgmi =3D true;<br>
<br>
You're setting this to true even for system memory BOs that don't <br>
involve XGMI mappings. That means you'll power up XGMI unnecessarily in <br=
>
many cases because KFD processes always have system memory mappings that <b=
r>
are mapped to all GPUs (e.g. the signal page).<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mutex_lock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Power up XGMI if it can be potentially used */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (&#43;&#43;adev-&gt;vm_manager.xgmi_map_counter =3D=3D 1)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_set_pst=
ate(adev, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mutex_unlock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bo_va;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -2490,6 &#43;2500,14 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device =
*adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(bo_va-&gt;last=
_pt_update);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (bo &amp;&amp; bo_va-&gt;is_xgmi) {<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mutex_lock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (--adev-&gt;vm_manager.xgmi_map_counter =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_set_pst=
ate(adev, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mutex_unlock(&amp;adev-&gt;vm_manager.lock_pstate);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(bo_va);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -2997,6 &#43;3015,9 @@ void amdgpu_vm_manager_init(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_init(&amp;adev-&gt;vm_ma=
nager.pasid_idr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;adev-&gt=
;vm_manager.pasid_lock);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.xgmi_map_counter =3D=
 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;vm_manager.lock=
_pstate);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index 520122b..f586b38 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -324,6 &#43;324,10 @@ struct amdgpu_vm_manager {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idr&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; pasid_idr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; pasid_lock;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* counter of mapped memory through xgmi=
 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; xgmi_map_counter;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_pstate;<br=
>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) ((ade=
v)-&gt;vm_manager.vm_pte_funcs-&gt;copy_pte((ib), (pe), (src), (count)))<br=
>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; index fcc4b05..3368347 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; @@ -200,12 &#43;200,26 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hiv=
e(struct amdgpu_device *adev, int lo<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (lock)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;tmp-&gt;hive_lock);<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp-&gt;pstate =3D -1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;xgmi_mutex=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return tmp;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate=
)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =3D amdgpu=
_get_xgmi_hive(adev, 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (hive-&gt;pstate =3D=3D pstate)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Todo : sent the message to SMU for ps=
tate change */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *h=
ive, struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; index 24a3b03..3e9c91e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; @@ -33,11 &#43;33,21 @@ struct amdgpu_hive_info {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute dev_=
attr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int pstate; /*0 -- low , 1 -- high , -1 =
unknown*/<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgp=
u_device *adev, int lock);<br>
&gt;&nbsp;&nbsp; int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *h=
ive, struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; int amdgpu_xgmi_add_device(struct amdgpu_device *adev);<br=
>
&gt;&nbsp;&nbsp; void amdgpu_xgmi_remove_device(struct amdgpu_device *adev)=
;<br>
&gt; &#43;int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate=
);<br>
&gt; &#43;<br>
&gt; &#43;static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *ad=
ev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_device *bo_adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return (adev !=3D bo_adev &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;gmc.xgmi.hive_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;gmc.xgmi.hive_id =3D=3D bo_adev-&gt;gmc.xgmi.hive_id);<br>
&gt; &#43;}<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #endif<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB3241D607634C7D7A58742D3BF45F0DM6PR12MB3241namp_--

--===============1761861554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1761861554==--

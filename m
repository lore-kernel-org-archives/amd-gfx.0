From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Optimize a function called by every IB
 sheduling
Date: Wed, 31 May 2017 12:53:06 +0000
Message-ID: <MWHPR1201MB0045FC6C00CA6008273C385BF2F10@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <1496180868-2617-1-git-send-email-AlexBin.Xie@amd.com>,
 <966bbfa3-488d-2a12-7ebd-cf59812928d6@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1475088129=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <966bbfa3-488d-2a12-7ebd-cf59812928d6-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1475088129==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0045FC6C00CA6008273C385BF2F10MWHPR1201MB0045_"

--_000_MWHPR1201MB0045FC6C00CA6008273C385BF2F10MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI Christian,


Too late. The code has been committed.


I don't have strong opinion about where the code should be. But if we put t=
his code in VM, there will be one extra array index operation because the V=
M bug is ring related. VM manager need to maintain an array to manage this =
information.


In the amdgpu_ring structure, there is already information like vm_inv_eng =
and vmhub. Those are VM related information too. So this one extra informat=
ion is not new.


Thanks,

Alex Bin

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Wednesday, May 31, 2017 2:57 AM
To: Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/3] drm/amdgpu: Optimize a function called by every IB=
 sheduling

Am 30.05.2017 um 23:47 schrieb Alex Xie:
>    Move several if statements and a loop statment from
>    run time to initialization time.

Yeah, that's exactly what I've suggested before as well.

Just keep the code inside amdgpu_vm.c (and the variable inside
amdgpu_vm_manager), since this isn't related to ring management at all.

Regards,
Christian.

>
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 33 +++++++++++++++++++++++++=
+++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28 +------------------------=
--
>   3 files changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 6a85db0..7d95435 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -153,6 +153,36 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>   }
>
>   /**
> + * amdgpu_ring_check_compute_vm_bug - check whether this ring has comput=
e vm bug
> + *
> + * @adev: amdgpu_device pointer
> + * @ring: amdgpu_ring structure holding ring information
> + */
> +static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device *adev,
> +                                     struct amdgpu_ring *ring)
> +{
> +     const struct amdgpu_ip_block *ip_block;
> +
> +     ring->has_compute_vm_bug =3D false;
> +
> +     if (ring->funcs->type !=3D AMDGPU_RING_TYPE_COMPUTE)
> +             /* only compute rings */
> +             return;
> +
> +     ip_block =3D amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> +     if (!ip_block)
> +             return;
> +
> +     /* Compute ring has a VM bug for GFX version < 7.
> +           And compute ring has a VM bug for GFX 8 MEC firmware version =
< 673.*/
> +     if (ip_block->version->major <=3D 7) {
> +             ring->has_compute_vm_bug =3D true;
> +     } else if (ip_block->version->major =3D=3D 8)
> +             if (adev->gfx.mec_fw_version < 673)
> +                     ring->has_compute_vm_bug =3D true;
> +}
> +
> +/**
>    * amdgpu_ring_init - init driver ring struct.
>    *
>    * @adev: amdgpu_device pointer
> @@ -257,6 +287,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, stru=
ct amdgpu_ring *ring,
>        if (amdgpu_debugfs_ring_init(adev, ring)) {
>                DRM_ERROR("Failed to register debugfs file for rings !\n")=
;
>        }
> +
> +     amdgpu_ring_check_compute_vm_bug(adev, ring);
> +
>        return 0;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index a9223a8..334307e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -185,6 +185,7 @@ struct amdgpu_ring {
>        u64                     cond_exe_gpu_addr;
>        volatile u32            *cond_exe_cpu_addr;
>        unsigned                vm_inv_eng;
> +     bool                    has_compute_vm_bug;
>   #if defined(CONFIG_DEBUG_FS)
>        struct dentry *ent;
>   #endif
> @@ -207,4 +208,9 @@ static inline void amdgpu_ring_clear_ring(struct amdg=
pu_ring *ring)
>
>   }
>
> +static inline bool amdgpu_ring_has_compute_vm_bug(struct amdgpu_ring *ri=
ng)
> +{
> +     return ring->has_compute_vm_bug;
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index b2384b8..7a323f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -656,32 +656,6 @@ static int amdgpu_vm_alloc_reserved_vmid(struct amdg=
pu_device *adev,
>        return r;
>   }
>
> -static bool amdgpu_vm_ring_has_compute_vm_bug(struct amdgpu_ring *ring)
> -{
> -     struct amdgpu_device *adev =3D ring->adev;
> -     const struct amdgpu_ip_block *ip_block;
> -
> -     if (ring->funcs->type !=3D AMDGPU_RING_TYPE_COMPUTE)
> -             /* only compute rings */
> -             return false;
> -
> -     ip_block =3D amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> -     if (!ip_block)
> -             return false;
> -
> -     if (ip_block->version->major <=3D 7) {
> -             /* gfx7 has no workaround */
> -             return true;
> -     } else if (ip_block->version->major =3D=3D 8) {
> -             if (adev->gfx.mec_fw_version >=3D 673)
> -                     /* gfx8 is fixed in MEC firmware 673 */
> -                     return false;
> -             else
> -                     return true;
> -     }
> -     return false;
> -}
> -
>   bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>                                  struct amdgpu_job *job)
>   {
> @@ -691,7 +665,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring =
*ring,
>        struct amdgpu_vm_id *id;
>        bool gds_switch_needed;
>        bool vm_flush_needed =3D job->vm_needs_flush ||
> -             amdgpu_vm_ring_has_compute_vm_bug(ring);
> +             amdgpu_ring_has_compute_vm_bug(ring);
>
>        if (job->vm_id =3D=3D 0)
>                return false;



--_000_MWHPR1201MB0045FC6C00CA6008273C385BF2F10MWHPR1201MB0045_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>HI Christian,</p>
<p><br>
</p>
<p>Too late. The code has been committed.</p>
<p><br>
</p>
<p>I don't have strong opinion about where the code should be. But if we pu=
t this code in VM, there will be one extra array index operation because th=
e VM bug is ring related. VM manager need to maintain an array to manage th=
is information.</p>
<p><br>
</p>
<p>In the <span>amdgpu_ring</span> structure, there is already information =
like <span>
vm_inv_eng</span> and <span>vmhub</span>. Those are VM related information =
too. So this one extra information is not new.
<br>
</p>
<p><br>
</p>
Thanks,
<p>Alex Bin<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &=
lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, May 31, 2017 2:57 AM<br>
<b>To:</b> Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: Optimize a function called by e=
very IB sheduling</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 30.05.2017 um 23:47 schrieb Alex Xie:<br>
&gt;&nbsp;&nbsp;&nbsp; Move several if statements and a loop statment from<=
br>
&gt;&nbsp;&nbsp;&nbsp; run time to initialization time.<br>
<br>
Yeah, that's exactly what I've suggested before as well.<br>
<br>
Just keep the code inside amdgpu_vm.c (and the variable inside <br>
amdgpu_vm_manager), since this isn't related to ring management at all.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 33 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<b=
r>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |&nbsp; 6 &#43;&#=
43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp; | 28 &#=
43;--------------------------<br>
&gt;&nbsp;&nbsp; 3 files changed, 40 insertions(&#43;), 27 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.c<br>
&gt; index 6a85db0..7d95435 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt; @@ -153,6 &#43;153,36 @@ void amdgpu_ring_undo(struct amdgpu_ring *rin=
g)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; &#43; * amdgpu_ring_check_compute_vm_bug - check whether this ring has=
 compute vm bug<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; * @ring: amdgpu_ring structure holding ring information<br>
&gt; &#43; */<br>
&gt; &#43;static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device=
 *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_ring *ring)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_ip_block *ip_block;<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_compute_vm_bug =3D false;<b=
r>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;type !=3D AMDGPU_=
RING_TYPE_COMPUTE)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* only compute rings */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ip_block =3D amdgpu_get_ip_block(adev, A=
MD_IP_BLOCK_TYPE_GFX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_block)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Compute ring has a VM bug for GFX ver=
sion &lt; 7.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; And =
compute ring has a VM bug for GFX 8 MEC firmware version &lt; 673.*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ip_block-&gt;version-&gt;major &lt;=
=3D 7) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ring-&gt;has_compute_vm_bug =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ip_block-&gt;version-&gt;majo=
r =3D=3D 8)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;gfx.mec_fw_version &lt; 673)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_comput=
e_vm_bug =3D true;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_ring_init - init driver ring struct.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt; @@ -257,6 &#43;287,9 @@ int amdgpu_ring_init(struct amdgpu_device *ade=
v, struct amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_debugfs_ring_init=
(adev, ring)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to register debugfs file for rin=
gs !\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_check_compute_vm_bug(adev, r=
ing);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.h<br>
&gt; index a9223a8..334307e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; @@ -185,6 &#43;185,7 @@ struct amdgpu_ring {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cond_exe_gpu_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile u32&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *cond_exe_cpu_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_i=
nv_eng;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; has_compute_vm_bug;<br>
&gt;&nbsp;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *ent;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; @@ -207,4 &#43;208,9 @@ static inline void amdgpu_ring_clear_ring(stru=
ct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static inline bool amdgpu_ring_has_compute_vm_bug(struct amdgpu_r=
ing *ring)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ring-&gt;has_compute_vm_bug;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index b2384b8..7a323f9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -656,32 &#43;656,6 @@ static int amdgpu_vm_alloc_reserved_vmid(stru=
ct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static bool amdgpu_vm_ring_has_compute_vm_bug(struct amdgpu_ring *rin=
g)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ring-&gt;adev=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_ip_block *ip_block;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;type !=3D AMDGPU_RING=
_TYPE_COMPUTE)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* only compute rings */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ip_block =3D amdgpu_get_ip_block(adev, AMD_I=
P_BLOCK_TYPE_GFX);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_block)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ip_block-&gt;version-&gt;major &lt;=3D 7=
) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* gfx7 has no workaround */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (ip_block-&gt;version-&gt;major =
=3D=3D 8) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gfx.mec_fw_version &gt;=3D 673)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfx8 is fixed in MEC=
 firmware 673 */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job=
)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -691,7 &#43;665,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgp=
u_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_id *id;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gds_switch_needed;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_flush_needed =3D job=
-&gt;vm_needs_flush ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_vm_ring_has_compute_vm_bug(ring);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_ring_has_compute_vm_bug(ring);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;vm_id =3D=3D 0)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB0045FC6C00CA6008273C385BF2F10MWHPR1201MB0045_--

--===============1475088129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1475088129==--

From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Move compute vm bug logic to amdgpu_vm.c
Date: Thu, 1 Jun 2017 13:40:16 +0000
Message-ID: <MWHPR1201MB0045729996FF89B47DCD29A3F2F60@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <1496272081-21584-1-git-send-email-AlexBin.Xie@amd.com>,
 <183887cb-17a0-e457-0c92-c04cc4b7fb53@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1367496318=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <183887cb-17a0-e457-0c92-c04cc4b7fb53-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

--===============1367496318==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0045729996FF89B47DCD29A3F2F60MWHPR1201MB0045_"

--_000_MWHPR1201MB0045729996FF89B47DCD29A3F2F60MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok. I will add the v2 next time. I did not add the v2 in case this email li=
st does not put the two patches under same thread...


-Alex Bin

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Thursday, June 1, 2017 9:26 AM
To: Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Move compute vm bug logic to amdgpu_vm.c

Am 01.06.2017 um 01:08 schrieb Alex Xie:
>    In review, Christian would like to keep the logic
>    inside amdgpu_vm.c with a cost of slightly slower.
>    The loop is still optimized out with this patch.
>
> v2: remove the if statement. Now it is not slower.
>
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

When you create a v2 of a patch please note that in the subject line as
well.

Either by using the "-v2" option with "git send-email" or by adding the
v2 manually on the subject line.

I sometimes get mails twice because they are send to multiple lists I'm
registered on and that helps allot seeing that a patch changed and is
not just a duplicated mail.

Anyway this version is Reviewed-by: Christian K=F6nig
<christian.koeng-5C7GfCeVMHo@public.gmane.org> as well.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 32 -----------------------=
--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  5 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 38 +++++++++++++++++++++++=
+++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
>   5 files changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 89bc34a..2f1a4e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2227,6 +2227,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>        adev->accel_working =3D true;
>
> +     amdgpu_vm_check_compute_bug(adev);
> +
>        /* Initialize the buffer migration limit. */
>        if (amdgpu_moverate >=3D 0)
>                max_MBps =3D amdgpu_moverate;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 7d95435..31aa51d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -153,36 +153,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>   }
>
>   /**
> - * amdgpu_ring_check_compute_vm_bug - check whether this ring has comput=
e vm bug
> - *
> - * @adev: amdgpu_device pointer
> - * @ring: amdgpu_ring structure holding ring information
> - */
> -static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device *adev,
> -                                     struct amdgpu_ring *ring)
> -{
> -     const struct amdgpu_ip_block *ip_block;
> -
> -     ring->has_compute_vm_bug =3D false;
> -
> -     if (ring->funcs->type !=3D AMDGPU_RING_TYPE_COMPUTE)
> -             /* only compute rings */
> -             return;
> -
> -     ip_block =3D amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> -     if (!ip_block)
> -             return;
> -
> -     /* Compute ring has a VM bug for GFX version < 7.
> -           And compute ring has a VM bug for GFX 8 MEC firmware version =
< 673.*/
> -     if (ip_block->version->major <=3D 7) {
> -             ring->has_compute_vm_bug =3D true;
> -     } else if (ip_block->version->major =3D=3D 8)
> -             if (adev->gfx.mec_fw_version < 673)
> -                     ring->has_compute_vm_bug =3D true;
> -}
> -
> -/**
>    * amdgpu_ring_init - init driver ring struct.
>    *
>    * @adev: amdgpu_device pointer
> @@ -288,8 +258,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, stru=
ct amdgpu_ring *ring,
>                DRM_ERROR("Failed to register debugfs file for rings !\n")=
;
>        }
>
> -     amdgpu_ring_check_compute_vm_bug(adev, ring);
> -
>        return 0;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 334307e..ad399c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -208,9 +208,4 @@ static inline void amdgpu_ring_clear_ring(struct amdg=
pu_ring *ring)
>
>   }
>
> -static inline bool amdgpu_ring_has_compute_vm_bug(struct amdgpu_ring *ri=
ng)
> -{
> -     return ring->has_compute_vm_bug;
> -}
> -
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index d4d05a8..6e32748 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -656,6 +656,41 @@ static int amdgpu_vm_alloc_reserved_vmid(struct amdg=
pu_device *adev,
>        return r;
>   }
>
> +/**
> + * amdgpu_vm_check_compute_bug - check whether asic has compute vm bug
> + *
> + * @adev: amdgpu_device pointer
> + */
> +void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
> +{
> +     const struct amdgpu_ip_block *ip_block;
> +     bool has_compute_vm_bug;
> +     struct amdgpu_ring *ring;
> +     int i;
> +
> +     has_compute_vm_bug =3D false;
> +
> +     ip_block =3D amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> +     if (ip_block) {
> +             /* Compute has a VM bug for GFX version < 7.
> +                Compute has a VM bug for GFX 8 MEC firmware version < 67=
3.*/
> +             if (ip_block->version->major <=3D 7)
> +                     has_compute_vm_bug =3D true;
> +             else if (ip_block->version->major =3D=3D 8)
> +                     if (adev->gfx.mec_fw_version < 673)
> +                             has_compute_vm_bug =3D true;
> +     }
> +
> +     for (i =3D 0; i < adev->num_rings; i++) {
> +             ring =3D adev->rings[i];
> +             if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE)
> +                     /* only compute rings */
> +                     ring->has_compute_vm_bug =3D has_compute_vm_bug;
> +             else
> +                     ring->has_compute_vm_bug =3D false;
> +     }
> +}
> +
>   bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>                                  struct amdgpu_job *job)
>   {
> @@ -664,8 +699,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring =
*ring,
>        struct amdgpu_vm_id_manager *id_mgr =3D &adev->vm_manager.id_mgr[v=
mhub];
>        struct amdgpu_vm_id *id;
>        bool gds_switch_needed;
> -     bool vm_flush_needed =3D job->vm_needs_flush ||
> -             amdgpu_ring_has_compute_vm_bug(ring);
> +     bool vm_flush_needed =3D job->vm_needs_flush || ring->has_compute_v=
m_bug;
>
>        if (job->vm_id =3D=3D 0)
>                return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 8309bc7..f5dba9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -245,5 +245,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev=
, uint64_t vm_size);
>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file=
 *filp);
>   bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>                                  struct amdgpu_job *job);
> +void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>
>   #endif



--_000_MWHPR1201MB0045729996FF89B47DCD29A3F2F60MWHPR1201MB0045_
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
<p>Ok. I will add the v2 next time. I did not add the v2 in case this email=
 list does not put the two patches under same thread...<br>
</p>
<br>
<p>-Alex Bin<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &=
lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 1, 2017 9:26 AM<br>
<b>To:</b> Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Move compute vm bug logic to amdgpu=
_vm.c</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 01.06.2017 um 01:08 schrieb Alex Xie:<br>
&gt;&nbsp;&nbsp;&nbsp; In review, Christian would like to keep the logic<br=
>
&gt;&nbsp;&nbsp;&nbsp; inside amdgpu_vm.c with a cost of slightly slower.<b=
r>
&gt;&nbsp;&nbsp;&nbsp; The loop is still optimized out with this patch.<br>
&gt;<br>
&gt; v2: remove the if statement. Now it is not slower.<br>
&gt;<br>
&gt; Signed-off-by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
When you create a v2 of a patch please note that in the subject line as <br=
>
well.<br>
<br>
Either by using the &quot;-v2&quot; option with &quot;git send-email&quot; =
or by adding the <br>
v2 manually on the subject line.<br>
<br>
I sometimes get mails twice because they are send to multiple lists I'm <br=
>
registered on and that helps allot seeing that a patch changed and is <br>
not just a duplicated mail.<br>
<br>
Anyway this version is Reviewed-by: Christian K=F6nig <br>
&lt;christian.koeng-5C7GfCeVMHo@public.gmane.org&gt; as well.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 2 &#43;=
&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c&nbsp;&nbsp; | 32 =
-------------------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h&nbsp;&nbsp; |&nbs=
p; 5 ----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 38 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; 5 files changed, 39 insertions(&#43;), 39 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 89bc34a..2f1a4e9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2227,6 &#43;2227,8 @@ int amdgpu_device_init(struct amdgpu_device =
*adev,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D t=
rue;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_check_compute_bug(adev);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize the buffer mig=
ration limit. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_moverate &gt;=3D =
0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; max_MBps =3D amdgpu_moverate;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.c<br>
&gt; index 7d95435..31aa51d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt; @@ -153,36 &#43;153,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *rin=
g)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * amdgpu_ring_check_compute_vm_bug - check whether this ring has com=
pute vm bug<br>
&gt; - *<br>
&gt; - * @adev: amdgpu_device pointer<br>
&gt; - * @ring: amdgpu_ring structure holding ring information<br>
&gt; - */<br>
&gt; -static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device *ad=
ev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct amdgpu_ring *ring)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_ip_block *ip_block;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_compute_vm_bug =3D false;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;type !=3D AMDGPU_RING=
_TYPE_COMPUTE)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* only compute rings */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ip_block =3D amdgpu_get_ip_block(adev, AMD_I=
P_BLOCK_TYPE_GFX);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_block)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Compute ring has a VM bug for GFX version=
 &lt; 7.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; And comp=
ute ring has a VM bug for GFX 8 MEC firmware version &lt; 673.*/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ip_block-&gt;version-&gt;major &lt;=3D 7=
) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ring-&gt;has_compute_vm_bug =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (ip_block-&gt;version-&gt;major =
=3D=3D 8)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gfx.mec_fw_version &lt; 673)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_compute_vm=
_bug =3D true;<br>
&gt; -}<br>
&gt; -<br>
&gt; -/**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_ring_init - init driver ring struct.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt; @@ -288,8 &#43;258,6 @@ int amdgpu_ring_init(struct amdgpu_device *ade=
v, struct amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to register debugfs file for rin=
gs !\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_check_compute_vm_bug(adev, ring)=
;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.h<br>
&gt; index 334307e..ad399c8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; @@ -208,9 &#43;208,4 @@ static inline void amdgpu_ring_clear_ring(stru=
ct amdgpu_ring *ring)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static inline bool amdgpu_ring_has_compute_vm_bug(struct amdgpu_ring =
*ring)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ring-&gt;has_compute_vm_bug;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index d4d05a8..6e32748 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -656,6 &#43;656,41 @@ static int amdgpu_vm_alloc_reserved_vmid(stru=
ct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;/**<br>
&gt; &#43; * amdgpu_vm_check_compute_bug - check whether asic has compute v=
m bug<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; */<br>
&gt; &#43;void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_ip_block *ip_block;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool has_compute_vm_bug;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; has_compute_vm_bug =3D false;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ip_block =3D amdgpu_get_ip_block(adev, A=
MD_IP_BLOCK_TYPE_GFX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ip_block) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Compute has a VM bug for GFX version &lt; 7.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Compute has a VM bug for GFX 8 MEC firmware versi=
on &lt; 673.*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ip_block-&gt;version-&gt;major &lt;=3D 7)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_compute_vm_bug =
=3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else if (ip_block-&gt;version-&gt;major =3D=3D 8)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.me=
c_fw_version &lt; 673)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; has_compute_vm_bug =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_rings;=
 i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ring =3D adev-&gt;rings[i];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_COMPUTE)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only compute rin=
gs */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_comput=
e_vm_bug =3D has_compute_vm_bug;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_comput=
e_vm_bug =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job=
)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -664,8 &#43;699,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgp=
u_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_id_manager =
*id_mgr =3D &amp;adev-&gt;vm_manager.id_mgr[vmhub];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_id *id;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gds_switch_needed;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bool vm_flush_needed =3D job-&gt;vm_needs_fl=
ush ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ring_has_compute_vm_bug(ring);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_flush_needed =3D job-&gt;vm_need=
s_flush || ring-&gt;has_compute_vm_bug;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;vm_id =3D=3D 0)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index 8309bc7..f5dba9c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -245,5 &#43;245,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_devic=
e *adev, uint64_t vm_size);<br>
&gt;&nbsp;&nbsp; int amdgpu_vm_ioctl(struct drm_device *dev, void *data, st=
ruct drm_file *filp);<br>
&gt;&nbsp;&nbsp; bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job=
);<br>
&gt; &#43;void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #endif<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB0045729996FF89B47DCD29A3F2F60MWHPR1201MB0045_--

--===============1367496318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1367496318==--

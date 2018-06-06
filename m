From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Make gfx_off control by GFX ip
Date: Wed, 6 Jun 2018 03:27:09 +0000
Message-ID: <CY4PR12MB16873A413B3CDD929C00C2C3FB650@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1528199477-7467-1-git-send-email-Rex.Zhu@amd.com>
 <1528199477-7467-2-git-send-email-Rex.Zhu@amd.com>,
 <20180606023348.GA750@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0248062060=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180606023348.GA750@hr-amur2>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0248062060==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16873A413B3CDD929C00C2C3FB650CY4PR12MB1687namp_"

--_000_CY4PR12MB16873A413B3CDD929C00C2C3FB650CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>Still has risk for s3, we would better not put PG disabling (gfxoff) behin=
d of CG
>disabling, even here is SMC clockgating. It is to avoid any MMU using when
>gfx is in "off" state.


I think logically we need to power on/off GFX ip through SMU, so first unga=
te SMU block first.


Currently, it is not a big deal, because SMU don't support CG/PG on all leg=
acy asics.


Best Regards

Rex


________________________________
From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, June 6, 2018 10:33 AM
To: Zhu, Rex
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/2] drm/amdgpu: Make gfx_off control by GFX ip

On Tue, Jun 05, 2018 at 07:51:17PM +0800, Rex Zhu wrote:
> v3: 1. Delete the dead gfx off code in powerplay late_init.
>     2. Revert v2.
>     3. call smu to power on gfx at the begin of ip_suspend/device_fini
>     4. only power off gfx ip in the end of gfx power gate function
> v2: Delete the dead gfx off code in ip_suspend.
>
> gfx off should be controlled by GFX IP.
> Powerplay only export interface to gfx ip.
> This logic is same as uvd/vce cg/pg.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  4 ++++
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c     |  8 --------
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  4 ++--
>  4 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index df6ef9c..ee87fea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1830,6 +1830,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_devi=
ce *adev)
>                                          adev->ip_blocks[i].version->func=
s->name, r);
>                                return r;
>                        }
> +                     if (adev->powerplay.pp_funcs->set_powergating_by_sm=
u)
> +                             amdgpu_dpm_set_powergating_by_smu(adev, AMD=
_IP_BLOCK_TYPE_GFX, false);
>                        r =3D adev->ip_blocks[i].version->funcs->hw_fini((=
void *)adev);
>                        /* XXX handle errors */
>                        if (r) {
> @@ -1940,12 +1942,6 @@ int amdgpu_device_ip_suspend(struct amdgpu_device =
*adev)
>        if (amdgpu_sriov_vf(adev))
>                amdgpu_virt_request_full_gpu(adev, false);
>
> -     /* ungate SMC block powergating */
> -     if (adev->powerplay.pp_feature & PP_GFXOFF_MASK)
> -             amdgpu_device_ip_set_powergating_state(adev,
> -                                                    AMD_IP_BLOCK_TYPE_SM=
C,
> -                                                    AMD_CG_STATE_UNGATE)=
;
> -
>        /* ungate SMC block first */
>        r =3D amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TY=
PE_SMC,
>                                                   AMD_CG_STATE_UNGATE);
> @@ -1953,6 +1949,10 @@ int amdgpu_device_ip_suspend(struct amdgpu_device =
*adev)
>                DRM_ERROR("set_clockgating_state(ungate) SMC failed %d\n",=
 r);
>        }
>
> +     /* call smu to disable gfx off feature first when suspend */
> +     if (adev->powerplay.pp_funcs->set_powergating_by_smu)
> +             amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_G=
FX, false);
> +

Still has risk for s3, we would better not put PG disabling (gfxoff) behind=
 of CG
disabling, even here is SMC clockgating. It is to avoid any MMU using when
gfx is in "off" state.

Thanks,
Ray


>        for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
>                if (!adev->ip_blocks[i].status.valid)
>                        continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index c382969..43c8023 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3712,6 +3712,10 @@ static int gfx_v9_0_set_powergating_state(void *ha=
ndle,
>
>                /* update mgcg state */
>                gfx_v9_0_update_gfx_mg_power_gating(adev, enable);
> +
> +             /* set gfx off through smu */
> +             if (enable && adev->powerplay.pp_funcs->set_powergating_by_=
smu)
> +                     amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOC=
K_TYPE_GFX, true);
>                break;
>        default:
>                break;
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/=
drm/amd/powerplay/amd_powerplay.c
> index fe3ed8c..8bb3a9a 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -180,7 +180,6 @@ static int pp_late_init(void *handle)
>  {
>        struct amdgpu_device *adev =3D handle;
>        struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
> -     int ret;
>
>        if (hwmgr && hwmgr->pm_en) {
>                mutex_lock(&hwmgr->smu_lock);
> @@ -191,13 +190,6 @@ static int pp_late_init(void *handle)
>        if (adev->pm.smu_prv_buffer_size !=3D 0)
>                pp_reserve_vram_for_smu(adev);
>
> -     if (hwmgr->hwmgr_func->gfx_off_control &&
> -         (hwmgr->feature_mask & PP_GFXOFF_MASK)) {
> -             ret =3D hwmgr->hwmgr_func->gfx_off_control(hwmgr, true);
> -             if (ret)
> -                     pr_err("gfx off enabling failed!\n");
> -     }
> -
>        return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index b9e6dfb..5abae28 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -314,7 +314,7 @@ static int smu10_disable_gfx_off(struct pp_hwmgr *hwm=
gr)
>
>  static int smu10_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
>  {
> -     return smu10_disable_gfx_off(hwmgr);
> +     return 0;
>  }
>
>  static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
> @@ -329,7 +329,7 @@ static int smu10_enable_gfx_off(struct pp_hwmgr *hwmg=
r)
>
>  static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
>  {
> -     return smu10_enable_gfx_off(hwmgr);
> +     return 0;
>  }
>
>  static int smu10_gfx_off_control(struct pp_hwmgr *hwmgr, bool enable)
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.



--_000_CY4PR12MB16873A413B3CDD929C00C2C3FB650CY4PR12MB1687namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">&gt;Still has risk for s3, we would better not put PG disab=
ling (gfxoff) behind of CG<br>
&gt;disabling, even here is SMC clockgating. It is to avoid any MMU using w=
hen<br>
&gt;gfx is in &quot;off&quot; state.</span></font><br>
</p>
<br>
<p style=3D"margin-top:0;margin-bottom:0">I think logically we need to powe=
r on/off GFX ip through SMU, so first ungate SMU block first.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Currently, it is not a big deal, =
because SMU don't support CG/PG on all legacy asics.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Huang Rui &lt;ray.hu=
ang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, June 6, 2018 10:33 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Make gfx_off control by GFX ip<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Jun 05, 2018 at 07:51:17PM &#43;0800, Rex =
Zhu wrote:<br>
&gt; v3: 1. Delete the dead gfx off code in powerplay late_init.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 2. Revert v2.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 3. call smu to power on gfx at the begin of ip=
_suspend/device_fini<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 4. only power off gfx ip in the end of gfx pow=
er gate function<br>
&gt; v2: Delete the dead gfx off code in ip_suspend.<br>
&gt; <br>
&gt; gfx off should be controlled by GFX IP.<br>
&gt; Powerplay only export interface to gfx ip.<br>
&gt; This logic is same as uvd/vce cg/pg.<br>
&gt; <br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; | 12 &#43;&#43;&#43;&#43;&#43;&#43;------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;&#43;&#43=
;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 8 --------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |&nbsp; 4 &#43=
;&#43;--<br>
&gt;&nbsp; 4 files changed, 12 insertions(&#43;), 16 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index df6ef9c..ee87fea 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -1830,6 &#43;1830,8 @@ static int amdgpu_device_ip_fini(struct amdg=
pu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name,=
 r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerp=
lay.pp_funcs-&gt;set_powergating_by_smu)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP=
_BLOCK_TYPE_GFX, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D a=
dev-&gt;ip_blocks[i].version-&gt;funcs-&gt;hw_fini((void *)adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XXX =
handle errors */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) =
{<br>
&gt; @@ -1940,12 &#43;1942,6 @@ int amdgpu_device_ip_suspend(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_virt_request_full_gpu(adev, false);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* ungate SMC block powergating */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_feature &amp; PP_G=
FXOFF_MASK)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_ip_set_powergating_state(adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SMC,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; AMD_CG_STATE_UNGATE);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ungate SMC block first */=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_set_c=
lockgating_state(adev, AMD_IP_BLOCK_TYPE_SMC,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMD_CG_STATE_UNGATE);<br>
&gt; @@ -1953,6 &#43;1949,10 @@ int amdgpu_device_ip_suspend(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;set_clockgating_state(ungate) SMC faile=
d %d\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* call smu to disable gfx off feature f=
irst when suspend */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;set_=
powergating_by_smu)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, fals=
e);<br>
&gt; &#43;<br>
<br>
Still has risk for s3, we would better not put PG disabling (gfxoff) behind=
 of CG<br>
disabling, even here is SMC clockgating. It is to avoid any MMU using when<=
br>
gfx is in &quot;off&quot; state.<br>
<br>
Thanks,<br>
Ray<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip_b=
locks - 1; i &gt;=3D 0; i--) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.valid)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index c382969..43c8023 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -3712,6 &#43;3712,10 @@ static int gfx_v9_0_set_powergating_state(v=
oid *handle,<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* update mgcg state */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gfx_v9_0_update_gfx_mg_power_gating(adev, enable);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* set gfx off through smu */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (enable &amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;set_powergati=
ng_by_smu)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_powe=
rgating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; index fe3ed8c..8bb3a9a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; @@ -180,7 &#43;180,6 @@ static int pp_late_init(void *handle)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D handle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D a=
dev-&gt;powerplay.pp_handle;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &amp;&amp; hwmgr-&=
gt;pm_en) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_lock);<br>
&gt; @@ -191,13 &#43;190,6 @@ static int pp_late_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.smu_prv_buff=
er_size !=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pp_reserve_vram_for_smu(adev);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;gfx_off_control=
 &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (hwmgr-&gt;feature_m=
ask &amp; PP_GFXOFF_MASK)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D hwmgr-&gt;hwmgr_func-&gt;gfx_off_control(hwmgr, true);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;gfx off en=
abling failed!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&gt; index b9e6dfb..5abae28 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br=
>
&gt; @@ -314,7 &#43;314,7 @@ static int smu10_disable_gfx_off(struct pp_hwm=
gr *hwmgr)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int smu10_disable_dpm_tasks(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return smu10_disable_gfx_off(hwmgr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)<br>
&gt; @@ -329,7 &#43;329,7 @@ static int smu10_enable_gfx_off(struct pp_hwmg=
r *hwmgr)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return smu10_enable_gfx_off(hwmgr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int smu10_gfx_off_control(struct pp_hwmgr *hwmgr, bool en=
able)<br>
&gt; -- <br>
&gt; 1.9.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk850295" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15282551139680.24578071702098847" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15282551139660.08193335755167419" style=3D"width: =
90%; background-color: rgb(255, 255, 255); position: relative; overflow: au=
to; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: =
1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200)=
;" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15282551139660.6451629222547607" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15282551139660.23860263831547934"></div=
>
<div id=3D"LPTitle_15282551139660.24812846614496475" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot=
;wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&=
quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-seri=
f; line-height: 21px;">
<a id=3D"LPUrlAnchor_15282551139660.0021238385388475667" style=3D"text-deco=
ration: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-g=
fx" target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15282551139660.31688669868279207" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quo=
t;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tah=
oma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15282551139680.39901652585399017" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma,=
 Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; =
overflow: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16873A413B3CDD929C00C2C3FB650CY4PR12MB1687namp_--

--===============0248062060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0248062060==--

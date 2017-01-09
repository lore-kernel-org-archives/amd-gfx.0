From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_state method
 for uvd v5&v6
Date: Mon, 9 Jan 2017 11:29:00 +0000
Message-ID: <CY4PR12MB176846FDA72EF232B6825609F7640@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1483930814-23529-1-git-send-email-ray.huang@amd.com>
 <1483930814-23529-2-git-send-email-ray.huang@amd.com>,
 <364cc068-e347-5f77-b4ff-414f8e8b4fdb@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1431866472=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <364cc068-e347-5f77-b4ff-414f8e8b4fdb-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Fu, Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>

--===============1431866472==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB176846FDA72EF232B6825609F7640CY4PR12MB1768namp_"

--_000_CY4PR12MB176846FDA72EF232B6825609F7640CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yup it's held by both amdgpu_dpm_enable_uvd() and amdgpu_dpm_enable_vce()


Tom


________________________________
From: Koenig, Christian
Sent: Monday, January 9, 2017 05:32
To: Huang, Ray; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; StDenis,=
 Tom
Cc: Zhu, Rex; Mao, David; Fu, Ping; Zhang, Hawking; Kuehling, Felix
Subject: Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_state met=
hod for uvd v5&v6

Am 09.01.2017 um 04:00 schrieb Huang Rui:
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>
> Changes from V3 -> V4:
> - use pm mutex to protect UVD clock gating status
>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 37 ++++++++++++++++++++++++++++=
+++++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 37 ++++++++++++++++++++++++++++=
+++++--
>   3 files changed, 71 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 530549b..31054c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1183,6 +1183,7 @@ struct amdgpu_uvd {
>        bool                    use_ctx_buf;
>        struct amd_sched_entity entity;
>        uint32_t                srbm_soft_reset;
> +     bool                    is_powergated;
>   };
>
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index 03a35d9..e647d3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -781,16 +781,48 @@ static int uvd_v5_0_set_powergating_state(void *han=
dle,
>         * the smc and the hw blocks
>         */
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     int ret =3D 0;
>
>        if (!(adev->pg_flags & AMD_PG_SUPPORT_UVD))
>                return 0;
>
> +     mutex_lock(&adev->pm.mutex);

Might be that I'm wrong, but didn't Tom said the mutex is taken anyway
when this function is called?

If that's true we would certainly run into problem when we try to
acquire it again.

Christian.

> +
>        if (state =3D=3D AMD_PG_STATE_GATE) {
> +             adev->uvd.is_powergated =3D true;
>                uvd_v5_0_stop(adev);
> -             return 0;
>        } else {
> -             return uvd_v5_0_start(adev);
> +             ret =3D uvd_v5_0_start(adev);
> +             if (ret)
> +                     goto out;
> +             adev->uvd.is_powergated =3D false;
> +     }
> +
> +out:
> +     mutex_unlock(&adev->pm.mutex);
> +
> +     return ret;
> +}
> +
> +static void uvd_v5_0_get_clockgating_state(void *handle, u32 *flags)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     int data;
> +
> +     mutex_lock(&adev->pm.mutex);
> +
> +     if (adev->uvd.is_powergated) {
> +             DRM_INFO("Cannot get clockgating state when UVD is powergat=
ed.\n");
> +             goto out;
>        }
> +
> +     /* AMD_CG_SUPPORT_UVD_MGCG */
> +     data =3D RREG32(mmUVD_CGC_CTRL);
> +     if (data & UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK)
> +             *flags |=3D AMD_CG_SUPPORT_UVD_MGCG;
> +
> +out:
> +     mutex_unlock(&adev->pm.mutex);
>   }
>
>   static const struct amd_ip_funcs uvd_v5_0_ip_funcs =3D {
> @@ -808,6 +840,7 @@ static const struct amd_ip_funcs uvd_v5_0_ip_funcs =
=3D {
>        .soft_reset =3D uvd_v5_0_soft_reset,
>        .set_clockgating_state =3D uvd_v5_0_set_clockgating_state,
>        .set_powergating_state =3D uvd_v5_0_set_powergating_state,
> +     .get_clockgating_state =3D uvd_v5_0_get_clockgating_state,
>   };
>
>   static const struct amdgpu_ring_funcs uvd_v5_0_ring_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index 8779d4b..2585ae9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -987,18 +987,50 @@ static int uvd_v6_0_set_powergating_state(void *han=
dle,
>         * the smc and the hw blocks
>         */
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     int ret =3D 0;
>
>        if (!(adev->pg_flags & AMD_PG_SUPPORT_UVD))
>                return 0;
>
>        WREG32(mmUVD_POWER_STATUS, UVD_POWER_STATUS__UVD_PG_EN_MASK);
>
> +     mutex_lock(&adev->pm.mutex);
> +
>        if (state =3D=3D AMD_PG_STATE_GATE) {
> +             adev->uvd.is_powergated =3D true;
>                uvd_v6_0_stop(adev);
> -             return 0;
>        } else {
> -             return uvd_v6_0_start(adev);
> +             ret =3D uvd_v6_0_start(adev);
> +             if (ret)
> +                     goto out;
> +             adev->uvd.is_powergated =3D false;
> +     }
> +
> +out:
> +     mutex_unlock(&adev->pm.mutex);
> +
> +     return ret;
> +}
> +
> +static void uvd_v6_0_get_clockgating_state(void *handle, u32 *flags)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     int data;
> +
> +     mutex_lock(&adev->pm.mutex);
> +
> +     if (adev->uvd.is_powergated) {
> +             DRM_INFO("Cannot get clockgating state when UVD is powergat=
ed.\n");
> +             goto out;
>        }
> +
> +     /* AMD_CG_SUPPORT_UVD_MGCG */
> +     data =3D RREG32(mmUVD_CGC_CTRL);
> +     if (data & UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK)
> +             *flags |=3D AMD_CG_SUPPORT_UVD_MGCG;
> +
> +out:
> +     mutex_unlock(&adev->pm.mutex);
>   }
>
>   static const struct amd_ip_funcs uvd_v6_0_ip_funcs =3D {
> @@ -1019,6 +1051,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs =
=3D {
>        .post_soft_reset =3D uvd_v6_0_post_soft_reset,
>        .set_clockgating_state =3D uvd_v6_0_set_clockgating_state,
>        .set_powergating_state =3D uvd_v6_0_set_powergating_state,
> +     .get_clockgating_state =3D uvd_v6_0_get_clockgating_state,
>   };
>
>   static const struct amdgpu_ring_funcs uvd_v6_0_ring_phys_funcs =3D {



--_000_CY4PR12MB176846FDA72EF232B6825609F7640CY4PR12MB1768namp_
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
<p>Yup it's held by both&nbsp;<span>amdgpu_dpm_enable_uvd() and&nbsp;<span>=
amdgpu_dpm_enable_vce()</span></span></p>
<p><span><span><br>
</span></span></p>
<p><span><span>Tom</span></span></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian<b=
r>
<b>Sent:</b> Monday, January 9, 2017 05:32<br>
<b>To:</b> Huang, Ray; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; S=
tDenis, Tom<br>
<b>Cc:</b> Zhu, Rex; Mao, David; Fu, Ping; Zhang, Hawking; Kuehling, Felix<=
br>
<b>Subject:</b> Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_st=
ate method for uvd v5&amp;v6</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 09.01.2017 um 04:00 schrieb Huang Rui:<br>
&gt; Signed-off-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; Changes from V3 -&gt; V4:<br>
&gt; - use pm mutex to protect UVD clock gating status<br>
&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp; |&nbsp; 1 =
&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 37 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 37 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
--<br>
&gt;&nbsp;&nbsp; 3 files changed, 71 insertions(&#43;), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 530549b..31054c7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1183,6 &#43;1183,7 @@ struct amdgpu_uvd {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; use_ctx_buf;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sched_entity enti=
ty;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srbm=
_soft_reset;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; is_powergated;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /*<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v5_0.c<br>
&gt; index 03a35d9..e647d3e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt; @@ -781,16 &#43;781,48 @@ static int uvd_v5_0_set_powergating_state(vo=
id *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the smc and the hw b=
locks<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pg_flags &amp=
; AMD_PG_SUPPORT_UVD))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
<br>
Might be that I'm wrong, but didn't Tom said the mutex is taken anyway <br>
when this function is called?<br>
<br>
If that's true we would certainly run into problem when we try to <br>
acquire it again.<br>
<br>
Christian.<br>
<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state =3D=3D AMD_PG_STAT=
E_GATE) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;uvd.is_powergated =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uvd_v5_0_stop(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return uvd_v5_0_start(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D uvd_v5_0_start(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;uvd.is_powergated =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;out:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void uvd_v5_0_get_clockgating_state(void *handle, u32 *fla=
gs)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;uvd.is_powergated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_INFO(&quot;Cannot get clockgating state when UVD is powergated.=
\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* AMD_CG_SUPPORT_UVD_MGCG */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32(mmUVD_CGC_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (data &amp; UVD_CGC_CTRL__DYN_CLOCK_M=
ODE_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *flags |=3D AMD_CG_SUPPORT_UVD_MGCG;<br>
&gt; &#43;<br>
&gt; &#43;out:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br=
>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct amd_ip_funcs uvd_v5_0_ip_funcs =3D {<b=
r>
&gt; @@ -808,6 &#43;840,7 @@ static const struct amd_ip_funcs uvd_v5_0_ip_f=
uncs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_reset =3D uvd_v5_0_sof=
t_reset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_clockgating_state =3D u=
vd_v5_0_set_clockgating_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =3D u=
vd_v5_0_set_powergating_state,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .get_clockgating_state =3D uvd_v5_0_get_=
clockgating_state,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct amdgpu_ring_funcs uvd_v5_0_ring_funcs =
=3D {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v6_0.c<br>
&gt; index 8779d4b..2585ae9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; @@ -987,18 &#43;987,50 @@ static int uvd_v6_0_set_powergating_state(vo=
id *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the smc and the hw b=
locks<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pg_flags &amp=
; AMD_PG_SUPPORT_UVD))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_POWER_STATUS, U=
VD_POWER_STATUS__UVD_PG_EN_MASK);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state =3D=3D AMD_PG_STAT=
E_GATE) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;uvd.is_powergated =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uvd_v6_0_stop(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return uvd_v6_0_start(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D uvd_v6_0_start(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;uvd.is_powergated =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;out:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void uvd_v6_0_get_clockgating_state(void *handle, u32 *fla=
gs)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mutex);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;uvd.is_powergated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_INFO(&quot;Cannot get clockgating state when UVD is powergated.=
\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* AMD_CG_SUPPORT_UVD_MGCG */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32(mmUVD_CGC_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (data &amp; UVD_CGC_CTRL__DYN_CLOCK_M=
ODE_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *flags |=3D AMD_CG_SUPPORT_UVD_MGCG;<br>
&gt; &#43;<br>
&gt; &#43;out:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br=
>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct amd_ip_funcs uvd_v6_0_ip_funcs =3D {<b=
r>
&gt; @@ -1019,6 &#43;1051,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip=
_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .post_soft_reset =3D uvd_v6_=
0_post_soft_reset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_clockgating_state =3D u=
vd_v6_0_set_clockgating_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =3D u=
vd_v6_0_set_powergating_state,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .get_clockgating_state =3D uvd_v6_0_get_=
clockgating_state,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct amdgpu_ring_funcs uvd_v6_0_ring_phys_f=
uncs =3D {<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB176846FDA72EF232B6825609F7640CY4PR12MB1768namp_--

--===============1431866472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1431866472==--

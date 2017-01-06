From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH v3 7/8] drm/amdgpu: add get clockgating_state method
 for uvd v5&v6
Date: Fri, 6 Jan 2017 13:48:33 +0000
Message-ID: <CY4PR12MB176840D39A2545BE80DC57B0F7630@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1483699875-27734-1-git-send-email-ray.huang@amd.com>
 <e2d8d323-1ee0-6f76-74c4-18a19fb2b0da@amd.com>
 <CY4PR12MB1768DCF4453B731FDD726447F7630@CY4PR12MB1768.namprd12.prod.outlook.com>,
 <1e6d1ea8-00b4-2af2-bedd-c1abaa5d24a6@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0628243437=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1e6d1ea8-00b4-2af2-bedd-c1abaa5d24a6-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Fu,
 Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0628243437==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB176840D39A2545BE80DC57B0F7630CY4PR12MB1768namp_"

--_000_CY4PR12MB176840D39A2545BE80DC57B0F7630CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It was added late last year so that debugfs mmio could read vce/uvd registe=
rs without triggering a race condition between transitions.


Cheers,

Tom


________________________________
From: Koenig, Christian
Sent: Friday, January 6, 2017 08:45
To: StDenis, Tom; Huang, Ray; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org
Cc: Kuehling, Felix; Zhang, Hawking; Zhu, Rex; Fu, Ping; Mao, David
Subject: Re: [PART1 PATCH v3 7/8] drm/amdgpu: add get clockgating_state met=
hod for uvd v5&v6

Good point, I wasn't ware that the pm mutex still existed and is taken unde=
r all code flows.

Christian.

Am 06.01.2017 um 14:42 schrieb StDenis, Tom:

There's already the adev->pm.mutex which is held while gating/ungating bloc=
ks.  There's no need for a second mutex right?


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Christian K=F6nig <christian.koenig@a=
md.com><mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, January 6, 2017 07:52
To: Huang, Ray; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Kuehling, Felix; Zhang, Hawking; Zhu, Rex; Fu, Ping; Mao, David
Subject: Re: [PART1 PATCH v3 7/8] drm/amdgpu: add get clockgating_state met=
hod for uvd v5&v6

Am 06.01.2017 um 11:51 schrieb Huang Rui:
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org><mailto:ray.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>
> Changes from V2 -> V3:
> - add mutex to protect the is_powergated flag.
>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  2 ++
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 37 ++++++++++++++++++++++++++++=
+++++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 37 ++++++++++++++++++++++++++++=
+++++--
>   3 files changed, 72 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 530549b..afb3ded 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1183,6 +1183,8 @@ struct amdgpu_uvd {
>        bool                    use_ctx_buf;
>        struct amd_sched_entity entity;
>        uint32_t                srbm_soft_reset;
> +     bool                    is_powergated;
> +     struct mutex            pg_mutex;

You are missing a mutex_init for pg_mutex, probably best to put this
into amdgpu_uvd_sw_init().

Apart from that the patch looks good to me now.

Regards,
Christian.

>   };
>
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index 03a35d9..bf797b8 100644
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
> +     mutex_lock(&adev->uvd.pg_mutex);
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
> +     mutex_unlock(&adev->uvd.pg_mutex);
> +
> +     return ret;
> +}
> +
> +static void uvd_v5_0_get_clockgating_state(void *handle, u32 *flags)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     int data;
> +
> +     mutex_lock(&adev->uvd.pg_mutex);
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
> +     mutex_unlock(&adev->uvd.pg_mutex);
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
> index 8779d4b..0ec692d 100644
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
> +     mutex_lock(&adev->uvd.pg_mutex);
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
> +     mutex_unlock(&adev->uvd.pg_mutex);
> +
> +     return ret;
> +}
> +
> +static void uvd_v6_0_get_clockgating_state(void *handle, u32 *flags)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     int data;
> +
> +     mutex_lock(&adev->uvd.pg_mutex);
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
> +     mutex_unlock(&adev->uvd.pg_mutex);
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


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...





--_000_CY4PR12MB176840D39A2545BE80DC57B0F7630CY4PR12MB1768namp_
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
<p>It was added late last year so that debugfs mmio could read vce/uvd regi=
sters without triggering a race condition between transitions. &nbsp;</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian<br>
<b>Sent:</b> Friday, January 6, 2017 08:45<br>
<b>To:</b> StDenis, Tom; Huang, Ray; Deucher, Alexander; amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org<br>
<b>Cc:</b> Kuehling, Felix; Zhang, Hawking; Zhu, Rex; Fu, Ping; Mao, David<=
br>
<b>Subject:</b> Re: [PART1 PATCH v3 7/8] drm/amdgpu: add get clockgating_st=
ate method for uvd v5&amp;v6</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">Good point, I wasn't ware that the pm mutex =
still existed and is taken under all code flows.<br>
<br>
Christian.<br>
<br>
Am 06.01.2017 um 14:42 schrieb StDenis, Tom:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>There's already the adev-&gt;pm.mutex which is held while gating/ungatin=
g blocks. &nbsp;There's no need for a second mutex right?</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri,=0A=
                sans-serif" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Christian K=
=F6nig <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:christian.koenig@a=
md.com">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Friday, January 6, 2017 07:52<br>
<b>To:</b> Huang, Ray; Deucher, Alexander; <a class=3D"moz-txt-link-abbrevi=
ated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Kuehling, Felix; Zhang, Hawking; Zhu, Rex; Fu, Ping; Mao, David<=
br>
<b>Subject:</b> Re: [PART1 PATCH v3 7/8] drm/amdgpu: add get clockgating_st=
ate method for uvd v5&amp;v6</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">Am 06.01.2017 um 11:51 schrieb Huang Rui:<br>
&gt; Signed-off-by: Huang Rui <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:ray.huang-5C7GfCeVMHo@public.gmane.org">
&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt; ---<br>
&gt;<br>
&gt; Changes from V2 -&gt; V3:<br>
&gt; - add mutex to protect the is_powergated flag.<br>
&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp; |&nbsp; 2 =
&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 37 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 37 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
--<br>
&gt;&nbsp;&nbsp; 3 files changed, 72 insertions(&#43;), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 530549b..afb3ded 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1183,6 &#43;1183,8 @@ struct amdgpu_uvd {<br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pg_mutex;<br>
<br>
You are missing a mutex_init for pg_mutex, probably best to put this <br>
into amdgpu_uvd_sw_init().<br>
<br>
Apart from that the patch looks good to me now.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /*<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v5_0.c<br>
&gt; index 03a35d9..bf797b8 100644<br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<=
br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;uvd.pg_mutex)=
;<br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<=
br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;uvd.pg_mutex)=
;<br>
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
&gt; index 8779d4b..0ec692d 100644<br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<=
br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;uvd.pg_mutex)=
;<br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<=
br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;uvd.pg_mutex)=
;<br>
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
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk851602" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14837099174670.7732004508767665" style=3D"margin-bot=
tom:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"fa=
lse">
<table id=3D"LPContainer_14837099174620.9257069430170277" cellspacing=3D"0"=
 style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto; padd=
ing-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dotted r=
gb(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"TextCell_14837099174640.8034805271988259" colspan=3D"2" style=3D"=
vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_14837099174640.500860546474154" style=3D""><a id=3D"LPUr=
lAnchor_14837099174650.4952875786439821" href=3D"https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-decoration:no=
ne">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14837099174650.6970539461685066" style=3D"">lists.fre=
edesktop.org</div>
<div id=3D"LPDescription_14837099174660.9659595296758496" style=3D"display:=
block; color:rgb(102,102,102); font-weight:normal; font-family:wf_segoe-ui_=
normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; f=
ont-size:14px; line-height:20px; max-height:100px; overflow:hidden">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
<p><br>
</p>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB176840D39A2545BE80DC57B0F7630CY4PR12MB1768namp_--

--===============0628243437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0628243437==--

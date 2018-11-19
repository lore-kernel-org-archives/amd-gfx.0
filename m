From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix oops when pp_funcs->switch_power_profile
 is unset
Date: Mon, 19 Nov 2018 20:26:17 +0000
Message-ID: <BN6PR12MB1809FF355A404034F416D304F7D80@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1542318992-12464-1-git-send-email-Felix.Kuehling@amd.com>
 <BN6PR12MB180900E62C3F2EB8C61C1FAFF7DC0@BN6PR12MB1809.namprd12.prod.outlook.com>,
 <f1108e8c-d330-bff3-b04b-4e79aaeabb9a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0777635485=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f1108e8c-d330-bff3-b04b-4e79aaeabb9a-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

--===============0777635485==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809FF355A404034F416D304F7D80BN6PR12MB1809namp_"

--_000_BN6PR12MB1809FF355A404034F416D304F7D80BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'll grab it for my -fixes pull this week.


Alex

________________________________
From: Kuehling, Felix
Sent: Monday, November 19, 2018 3:02:27 PM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Joerg Roedel
Subject: Re: [PATCH] drm/amdgpu: Fix oops when pp_funcs->switch_power_profi=
le is unset

I pushed the change to amd-staging-drm-next. I'd also like to get it
into drm-fixes. Should I cherry-pick it to your drm-fixes-4.20 branch on
fd.o?


Thanks,
  Felix


On 2018-11-15 4:59 p.m., Deucher, Alexander wrote:
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, November 15, 2018 4:56:51 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Kuehling, Felix; Joerg Roedel
> *Subject:* [PATCH] drm/amdgpu: Fix oops when
> pp_funcs->switch_power_profile is unset
>
> On Vega20 and other pre-production GPUs, powerplay is not enabled yet.
> Check for NULL pointers before calling pp_funcs function pointers.
>
> Also affects Kaveri.
>
> CC: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a9c7597..1c1fed6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -503,8 +503,11 @@ void amdgpu_amdkfd_set_compute_idle(struct
> kgd_dev *kgd, bool idle)
>  {
>          struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
>
> -       amdgpu_dpm_switch_power_profile(adev,
> -                                       PP_SMC_POWER_PROFILE_COMPUTE,
> !idle);
> +       if (adev->powerplay.pp_funcs &&
> +           adev->powerplay.pp_funcs->switch_power_profile)
> +               amdgpu_dpm_switch_power_profile(adev,
> +
> PP_SMC_POWER_PROFILE_COMPUTE,
> +                                               !idle);
>  }
>
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809FF355A404034F416D304F7D80BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I'll grab it for my -fixes pull t=
his week.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Monday, November 19, 2018 3:02:27 PM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Joerg Roedel<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix oops when pp_funcs-&gt;switch_p=
ower_profile is unset</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I pushed the change to amd-staging-drm-next. I'd a=
lso like to get it<br>
into drm-fixes. Should I cherry-pick it to your drm-fixes-4.20 branch on<br=
>
fd.o?<br>
<br>
<br>
Thanks,<br>
&nbsp; Felix<br>
<br>
<br>
On 2018-11-15 4:59 p.m., Deucher, Alexander wrote:<br>
&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behal=
f of<br>
&gt; Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; *Sent:* Thursday, November 15, 2018 4:56:51 PM<br>
&gt; *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; *Cc:* Kuehling, Felix; Joerg Roedel<br>
&gt; *Subject:* [PATCH] drm/amdgpu: Fix oops when<br>
&gt; pp_funcs-&gt;switch_power_profile is unset<br>
&gt; &nbsp;<br>
&gt; On Vega20 and other pre-production GPUs, powerplay is not enabled yet.=
<br>
&gt; Check for NULL pointers before calling pp_funcs function pointers.<br>
&gt;<br>
&gt; Also affects Kaveri.<br>
&gt;<br>
&gt; CC: Joerg Roedel &lt;jroedel-l3A5Bk7waGM@public.gmane.org&gt;<br>
&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 &#43;&#43;&#43;&#=
43;&#43;--<br>
&gt; &nbsp;1 file changed, 5 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; index a9c7597..1c1fed6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; @@ -503,8 &#43;503,11 @@ void amdgpu_amdkfd_set_compute_idle(struct<br=
>
&gt; kgd_dev *kgd, bool idle)<br>
&gt; &nbsp;{<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device =
*adev =3D (struct amdgpu_device *)kgd;<br>
&gt; &nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_switch_power_profile(=
adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; PP_SMC_POWER_PROFILE_COMPUTE,<br>
&gt; !idle);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_fu=
ncs &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;powerplay.pp_funcs-&gt;switch_power_profile)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dpm_switch_power_profile(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; PP_SMC_POWER_PROFILE_COMPUTE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !idle);<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 v=
mid)<br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809FF355A404034F416D304F7D80BN6PR12MB1809namp_--

--===============0777635485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0777635485==--

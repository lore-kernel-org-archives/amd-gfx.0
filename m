From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct the bit mask for checking VCN
 power status
Date: Fri, 19 Jul 2019 13:16:09 +0000
Message-ID: <BN6PR12MB1809DF29C0B6DC3D9C34900DF7CB0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190719085145.27515-1-evan.quan@amd.com>
 <MN2PR12MB3309184F93F4EF2E0353AE82ECCB0@MN2PR12MB3309.namprd12.prod.outlook.com>,
 <MN2PR12MB3344010A9F4F9108DD54ED7EE4CB0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0131504660=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344010A9F4F9108DD54ED7EE4CB0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0131504660==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DF29C0B6DC3D9C34900DF7CB0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DF29C0B6DC3D9C34900DF7CB0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sure.  That makes more sense.  We should switch raven to use it as well.

Alex
________________________________
From: Quan, Evan
Sent: Friday, July 19, 2019 5:47 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
Subject: RE: [PATCH] drm/amd/powerplay: correct the bit mask for checking V=
CN power status

Considering this is actually different from traditional UVD, maybe it's bet=
ter to add a new flag like AMDGPU_PP_SENSOR_VCN_POWER.
@Deucher, Alexander any comment?

Regards,
Evan
> -----Original Message-----
> From: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
> Sent: Friday, July 19, 2019 5:21 PM
> To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Subject: RE: [PATCH] drm/amd/powerplay: correct the bit mask for checking
> VCN power status
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> > Evan Quan
> > Sent: Friday, July 19, 2019 4:52 PM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> > Subject: [PATCH] drm/amd/powerplay: correct the bit mask for checking
> > VCN power status
> >
> > For Navi10 or later ASICs, a different bit mask is used for checking
> > VCN power status.
> >
> > Change-Id: Iaa49e5a339c38f46e3e7124d21aeb65f6633325e
> > Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > index 6e2f7df826f0..887577c47568 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > @@ -271,6 +271,8 @@ int smu_get_power_num_states(struct
> smu_context
> > *smu,  int smu_common_read_sensor(struct smu_context *smu, enum
> > amd_pp_sensors sensor,
> >                         void *data, uint32_t *size)
> >  {
> > +   struct amdgpu_device *adev =3D smu->adev;
> > +   uint32_t uvd_bit_mask =3D 0xFFFFFFFF;
> >      int ret =3D 0;
> >
> >      switch (sensor) {
> > @@ -287,7 +289,11 @@ int smu_common_read_sensor(struct
> smu_context
> > *smu, enum amd_pp_sensors sensor,
> >              *size =3D 8;
> >              break;
> >      case AMDGPU_PP_SENSOR_UVD_POWER:
> > -           *(uint32_t *)data =3D smu_feature_is_enabled(smu,
> > SMU_FEATURE_DPM_UVD_BIT) ? 1 : 0;
> > +           if (adev->asic_type =3D=3D CHIP_VEGA20)
> > +                   uvd_bit_mask =3D SMU_FEATURE_DPM_UVD_BIT;
> > +           else
> > +                   uvd_bit_mask =3D SMU_FEATURE_VCN_PG_BIT;
>
> After vega20, we actually will use VCN instead of UVD. Below indicates th=
e
> design for this.
>
> uvd_bit_mask =3D (adev->asic_type > CHIP_VEGA20) ?
> SMU_FEATURE_VCN_PG_BIT : SMU_FEATURE_DPM_UVD_BIT
>
> Anyway, patch looks good for me.
> Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
>
>
> Thanks,
> Ray
>
> > +   *(uint32_t *)data =3D smu_feature_is_enabled(smu,
> > uvd_bit_mask) ? 1 :
> > +0;
> >              *size =3D 4;
> >              break;
> >      case AMDGPU_PP_SENSOR_VCE_POWER:
> > --
> > 2.22.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809DF29C0B6DC3D9C34900DF7CB0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Sure.&nbsp; That makes more sense.&nbsp; We should switch raven to use it a=
s well.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Friday, July 19, 2019 5:47 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: correct the bit mask for che=
cking VCN power status</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Considering this is actually different from tradit=
ional UVD, maybe it's better to add a new flag like AMDGPU_PP_SENSOR_VCN_PO=
WER.<br>
@Deucher, Alexander any comment?<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Friday, July 19, 2019 5:21 PM<br>
&gt; To: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g<br>
&gt; Cc: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: RE: [PATCH] drm/amd/powerplay: correct the bit mask for check=
ing<br>
&gt; VCN power status<br>
&gt; <br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Be=
half Of<br>
&gt; &gt; Evan Quan<br>
&gt; &gt; Sent: Friday, July 19, 2019 4:52 PM<br>
&gt; &gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; Cc: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; Subject: [PATCH] drm/amd/powerplay: correct the bit mask for chec=
king<br>
&gt; &gt; VCN power status<br>
&gt; &gt;<br>
&gt; &gt; For Navi10 or later ASICs, a different bit mask is used for check=
ing<br>
&gt; &gt; VCN power status.<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: Iaa49e5a339c38f46e3e7124d21aeb65f6633325e<br>
&gt; &gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 8 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;-<br>
&gt; &gt;&nbsp; 1 file changed, 7 insertions(&#43;), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &gt; index 6e2f7df826f0..887577c47568 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &gt; @@ -271,6 &#43;271,8 @@ int smu_get_power_num_states(struct<br>
&gt; smu_context<br>
&gt; &gt; *smu,&nbsp; int smu_common_read_sensor(struct smu_context *smu, e=
num<br>
&gt; &gt; amd_pp_sensors sensor,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; void *data, uint32_t *size)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt; &#43;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp; uint32_t uvd_bit_mask =3D 0xFFFFFFFF;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&gt; &gt; @@ -287,7 &#43;289,11 @@ int smu_common_read_sensor(struct<br>
&gt; smu_context<br>
&gt; &gt; *smu, enum amd_pp_sensors sensor,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; *size =3D 8;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_UVD_POWER:<br=
>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(u=
int32_t *)data =3D smu_feature_is_enabled(smu,<br>
&gt; &gt; SMU_FEATURE_DPM_UVD_BIT) ? 1 : 0;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (adev-&gt;asic_type =3D=3D CHIP_VEGA20)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_bit_mask =3D SMU_FEATU=
RE_DPM_UVD_BIT;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 else<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_bit_mask =3D SMU_FEATU=
RE_VCN_PG_BIT;<br>
&gt; <br>
&gt; After vega20, we actually will use VCN instead of UVD. Below indicates=
 the<br>
&gt; design for this.<br>
&gt; <br>
&gt; uvd_bit_mask =3D (adev-&gt;asic_type &gt; CHIP_VEGA20) ?<br>
&gt; SMU_FEATURE_VCN_PG_BIT : SMU_FEATURE_DPM_UVD_BIT<br>
&gt; <br>
&gt; Anyway, patch looks good for me.<br>
&gt; Reviewed-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; Ray<br>
&gt; <br>
&gt; &gt; &#43;&nbsp;&nbsp; *(uint32_t *)data =3D smu_feature_is_enabled(sm=
u,<br>
&gt; &gt; uvd_bit_mask) ? 1 :<br>
&gt; &gt; &#43;0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; *size =3D 4;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VCE_POWER:<br=
>
&gt; &gt; --<br>
&gt; &gt; 2.22.0<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809DF29C0B6DC3D9C34900DF7CB0BN6PR12MB1809namp_--

--===============0131504660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0131504660==--

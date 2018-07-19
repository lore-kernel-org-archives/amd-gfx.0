From: "Zhang, Boyuan" <Boyuan.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/5] drm/amdgpu: enable system interrupt for jrbc
Date: Thu, 19 Jul 2018 18:46:21 +0000
Message-ID: <DM5PR12MB1658600E82B005B7B8FC3ACF87520@DM5PR12MB1658.namprd12.prod.outlook.com>
References: <1531946355-17488-1-git-send-email-boyuan.zhang@amd.com>
 <1531946355-17488-3-git-send-email-boyuan.zhang@amd.com>,
 <7ff97103-bd17-3011-103d-a4e2e77099a6@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1572116523=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7ff97103-bd17-3011-103d-a4e2e77099a6-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1572116523==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1658600E82B005B7B8FC3ACF87520DM5PR12MB1658namp_"

--_000_DM5PR12MB1658600E82B005B7B8FC3ACF87520DM5PR12MB1658namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes, agree! It's better to use that existing function. Will change it accor=
dingly.


Thanks,

Boyuan

________________________________
From: Liu, Leo
Sent: July 19, 2018 2:13:50 PM
To: Zhang, Boyuan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 3/5] drm/amdgpu: enable system interrupt for jrbc



On 07/18/2018 04:39 PM, boyuan.zhang-5C7GfCeVMHo@public.gmane.org wrote:
> From: Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
>
> Enable system interrupt for jrbc during engine starting time.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 4fccb21..22c1588 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -595,6 +595,7 @@ static int vcn_v1_0_start(struct amdgpu_device *adev)
>        struct amdgpu_ring *ring =3D &adev->vcn.ring_dec;
>        uint32_t rb_bufsz, tmp;
>        uint32_t lmi_swap_cntl;
> +     uint32_t reg_temp;
>        int i, j, r;
>
>        /* disable byte swapping */
> @@ -700,6 +701,11 @@ static int vcn_v1_0_start(struct amdgpu_device *adev=
)
>                (UVD_MASTINT_EN__VCPU_EN_MASK|UVD_MASTINT_EN__SYS_EN_MASK)=
,
>                ~(UVD_MASTINT_EN__VCPU_EN_MASK|UVD_MASTINT_EN__SYS_EN_MASK=
));
>
> +     /* enable system interrupt for JRBC*/
> +     reg_temp =3D RREG32(SOC15_REG_OFFSET(UVD, 0, mmUVD_SYS_INT_EN));
> +     reg_temp |=3D UVD_SYS_INT_EN__UVD_JRBC_EN_MASK;
> +     WREG32(SOC15_REG_OFFSET(UVD, 0, mmUVD_SYS_INT_EN), reg_temp);

Here you could use below instead.
WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SYS_INT_EN), UVD_SYS_INT_EN__UVD_JR=
BC_EN_MASK,
        ~UVD_SYS_INT_EN__UVD_JRBC_EN_MASK);

Ether way, the whole series are
Acked-by: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>



> +
>        /* clear the bit 4 of VCN_STATUS */
>        WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_STATUS), 0,
>                        ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> @@ -1754,7 +1760,7 @@ static const struct amdgpu_irq_src_funcs vcn_v1_0_i=
rq_funcs =3D {
>
>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -     adev->vcn.irq.num_types =3D adev->vcn.num_enc_rings + 1;
> +     adev->vcn.irq.num_types =3D adev->vcn.num_enc_rings + 2;
>        adev->vcn.irq.funcs =3D &vcn_v1_0_irq_funcs;
>   }
>


--_000_DM5PR12MB1658600E82B005B7B8FC3ACF87520DM5PR12MB1658namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Yes, agree! It's better to use th=
at existing function. Will change it accordingly.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0">Boyuan</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Leo<br>
<b>Sent:</b> July 19, 2018 2:13:50 PM<br>
<b>To:</b> Zhang, Boyuan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 3/5] drm/amdgpu: enable system interrupt for jrb=
c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 07/18/2018 04:39 PM, boyuan.zhang-5C7GfCeVMHo@public.gmane.org wrote:<br>
&gt; From: Boyuan Zhang &lt;boyuan.zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Enable system interrupt for jrbc during engine starting time.<br>
&gt;<br>
&gt; Signed-off-by: Boyuan Zhang &lt;boyuan.zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 8 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 1 file changed, 7 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v1_0.c<br>
&gt; index 4fccb21..22c1588 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; @@ -595,6 &#43;595,7 @@ static int vcn_v1_0_start(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D=
 &amp;adev-&gt;vcn.ring_dec;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rb_bufsz, tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t lmi_swap_cntl;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_temp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable byte swapping */<=
br>
&gt; @@ -700,6 &#43;701,11 @@ static int vcn_v1_0_start(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (UVD_MASTINT_EN__VCPU_EN_MASK|UVD_MASTINT_EN__SYS_EN_MA=
SK),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ~(UVD_MASTINT_EN__VCPU_EN_MASK|UVD_MASTINT_EN__SYS_EN_M=
ASK));<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* enable system interrupt for JRBC*/<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; reg_temp =3D RREG32(SOC15_REG_OFFSET(UVD=
, 0, mmUVD_SYS_INT_EN));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; reg_temp |=3D UVD_SYS_INT_EN__UVD_JRBC_E=
N_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(UVD, 0, mmUVD_SY=
S_INT_EN), reg_temp);<br>
<br>
Here you could use below instead.<br>
WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SYS_INT_EN), UVD_SYS_INT_EN__UVD_JR=
BC_EN_MASK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~UVD_SYS_INT_EN__UVD_JRBC_EN_MAS=
K);<br>
<br>
Ether way, the whole series are<br>
Acked-by: Leo Liu &lt;leo.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
<br>
<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear the bit 4 of VCN_ST=
ATUS */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(SOC15_REG_OFFSET(UV=
D, 0, mmUVD_STATUS), 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~(2 &lt=
;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));<br>
&gt; @@ -1754,7 &#43;1760,7 @@ static const struct amdgpu_irq_src_funcs vcn=
_v1_0_irq_funcs =3D {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.irq.num_types =3D adev-&gt;vcn.=
num_enc_rings &#43; 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.irq.num_types =3D adev-&gt;=
vcn.num_enc_rings &#43; 2;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.irq.funcs =3D &=
amp;vcn_v1_0_irq_funcs;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1658600E82B005B7B8FC3ACF87520DM5PR12MB1658namp_--

--===============1572116523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1572116523==--

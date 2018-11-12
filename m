From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix CSA buffer alloc failed on Vega
Date: Mon, 12 Nov 2018 11:16:00 +0000
Message-ID: <BYAPR12MB277536E13BA51356E3D9AD1FFBC10@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1542018800-998-1-git-send-email-Rex.Zhu@amd.com>,
 <e7909a29-fddd-9c65-d748-49f51e72afa9@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0816452098=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e7909a29-fddd-9c65-d748-49f51e72afa9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0816452098==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB277536E13BA51356E3D9AD1FFBC10BYAPR12MB2775namp_"

--_000_BYAPR12MB277536E13BA51356E3D9AD1FFBC10BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Got it .

Thanks.


Best Regards

Rex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, November 12, 2018 6:42 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Fix CSA buffer alloc failed on Vega

Am 12.11.18 um 11:33 schrieb Rex Zhu:
> Alloc_pte failed when the VA address located in
> the higher arrange of 256T.
>
> so reserve the csa buffer under 128T as a work around.
>
> [  122.979425] amdgpu 0000:03:00.0: va above limit (0xFFFFFFFFFFF1F >=3D =
0x1000000000)
> [  122.987080] BUG: unable to handle kernel paging request at ffff880e1a7=
9fff8
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Well NAK, userspace wants to use the full address space below 128T for SVM.

The problem is rather that you incorrectly use amdgpu_csa_vaddr(). See
the code in amdgpu_driver_open_kms() how to do it correctly:

>                 uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) &
> AMDGPU_GMC_HOLE_MASK;
>
>                 r =3D amdgpu_map_static_csa(adev, &fpriv->vm,
> adev->virt.csa_obj,
> &fpriv->csa_va, csa_addr, AMDGPU_CSA_SIZE);
>                 if (r)
>                         goto error_vm;

Christian.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_csa.c
> index fea4555..e2f325b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -36,9 +36,9 @@ uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev, u=
int32_t id)
>   {
>        uint64_t addr =3D adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIF=
T;
>
> -     addr -=3D AMDGPU_VA_RESERVED_SIZE * id;
> +     addr =3D min(addr, AMDGPU_GMC_HOLE_START);
>
> -     addr =3D amdgpu_gmc_sign_extend(addr);
> +     addr -=3D (uint64_t)AMDGPU_VA_RESERVED_SIZE * id;
>
>        return addr;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 338a091..ea6a12a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -711,7 +711,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, =
void *data, struct drm_file
>
>                dev_info.virtual_address_offset =3D AMDGPU_VA_RESERVED_SIZ=
E;
>                dev_info.virtual_address_max =3D
> -                     min(vm_size, AMDGPU_GMC_HOLE_START);
> +                     min(vm_size, AMDGPU_GMC_HOLE_START - adev->vm_manag=
er.reserved_vm_size);
>
>                if (vm_size > AMDGPU_GMC_HOLE_START) {
>                        dev_info.high_va_offset =3D AMDGPU_GMC_HOLE_END;


--_000_BYAPR12MB277536E13BA51356E3D9AD1FFBC10BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Got it .</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &l=
t;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, November 12, 2018 6:42 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix CSA buffer alloc failed on Vega=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 12.11.18 um 11:33 schrieb Rex Zhu:<br>
&gt; Alloc_pte failed when the VA address located in<br>
&gt; the higher arrange of 256T.<br>
&gt;<br>
&gt; so reserve the csa buffer under 128T as a work around.<br>
&gt;<br>
&gt; [&nbsp; 122.979425] amdgpu 0000:03:00.0: va above limit (0xFFFFFFFFFFF=
1F &gt;=3D 0x1000000000)<br>
&gt; [&nbsp; 122.987080] BUG: unable to handle kernel paging request at fff=
f880e1a79fff8<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Well NAK, userspace wants to use the full address space below 128T for SVM.=
<br>
<br>
The problem is rather that you incorrectly use amdgpu_csa_vaddr(). See <br>
the code in amdgpu_driver_open_kms() how to do it correctly:<br>
<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) &amp; <br=
>
&gt; AMDGPU_GMC_HOLE_MASK;<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_map_static_csa(adev, &amp;fpriv-&gt;vm, <=
br>
&gt; adev-&gt;virt.csa_obj,<br>
&gt; &amp;fpriv-&gt;csa_va, csa_addr, AMDGPU_CSA_SIZE);<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto e=
rror_vm;<br>
<br>
Christian.<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 4 &#43;&#43;--<b=
r>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 &#43;-<br>
&gt;&nbsp;&nbsp; 2 files changed, 3 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_csa.c<br>
&gt; index fea4555..e2f325b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<br>
&gt; @@ -36,9 &#43;36,9 @@ uint64_t amdgpu_csa_vaddr(struct amdgpu_device *=
adev, uint32_t id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr =3D adev-&gt;v=
m_manager.max_pfn &lt;&lt; AMDGPU_GPU_PAGE_SHIFT;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; addr -=3D AMDGPU_VA_RESERVED_SIZE * id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D min(addr, AMDGPU_GMC_HOLE_START=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; addr =3D amdgpu_gmc_sign_extend(addr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; addr -=3D (uint64_t)AMDGPU_VA_RESERVED_S=
IZE * id;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return addr;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c<br>
&gt; index 338a091..ea6a12a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -711,7 &#43;711,7 @@ static int amdgpu_info_ioctl(struct drm_device=
 *dev, void *data, struct drm_file<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info.virtual_address_offset =3D AMDGPU_VA_RESERVED_=
SIZE;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info.virtual_address_max =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min(vm_size, AMDGPU_GMC=
_HOLE_START);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min(vm_size, AMDGPU=
_GMC_HOLE_START - adev-&gt;vm_manager.reserved_vm_size);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (vm_size &gt; AMDGPU_GMC_HOLE_START) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o.high_va_offset =3D AMDGPU_GMC_HOLE_END;<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB277536E13BA51356E3D9AD1FFBC10BYAPR12MB2775namp_--

--===============0816452098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0816452098==--

From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: keep the stolen memory in visible vram
 region
Date: Thu, 29 Aug 2019 07:20:02 +0000
Message-ID: <DM5PR12MB2535A0267ACFB40B0CECBE1895A20@DM5PR12MB2535.namprd12.prod.outlook.com>
References: <1567047930-11912-1-git-send-email-tianci.yin@amd.com>
 <1567047930-11912-2-git-send-email-tianci.yin@amd.com>,
 <5e5b0214-0e50-1a6d-f7f2-54317e5767c4@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1446724196=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5e5b0214-0e50-1a6d-f7f2-54317e5767c4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Ma, Le" <Le.Ma-5C7GfCeVMHo@public.gmane.org>

--===============1446724196==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2535A0267ACFB40B0CECBE1895A20DM5PR12MB2535namp_"

--_000_DM5PR12MB2535A0267ACFB40B0CECBE1895A20DM5PR12MB2535namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok, I'll fix that, thanks!
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, August 29, 2019 15:13
To: Yin, Tianci (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Xu, Feifei <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>; Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>; Xiao, Jack <Jac=
k.Xiao-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: keep the stolen memory in visible vram=
 region

Am 29.08.19 um 05:05 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>
>
> stolen memory should be fixed in visible region.
>
> Change-Id: Icbbbd39fd113e93423aad8d2555f4073c08020e5
> Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 3 ++-
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 801f912..dcd32d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1733,6 +1733,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>        uint64_t gtt_size;
>        int r;
>        u64 vis_vram_limit;
> +     void *stolen_vga_buf;
>
>        mutex_init(&adev->mman.gtt_window_lock);
>
> @@ -1787,7 +1788,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>        r =3D amdgpu_bo_create_kernel(adev, adev->gmc.stolen_size, PAGE_SI=
ZE,
>                                    AMDGPU_GEM_DOMAIN_VRAM,
>                                    &adev->stolen_vga_memory,
> -                                 NULL, NULL);
> +                                 NULL, &stolen_vga_buf);
>        if (r)
>                return r;
>        DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
> @@ -1851,8 +1852,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ttm_late_init(struct amdgpu_device *adev)
>   {
> +     void *stolen_vga_buf;

Coding style says we should add a new line between declaration and code.

Apart from that the series is Reviewed-by: Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

>        /* return the VGA stolen memory (if any) back to VRAM */
> -     amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, NULL);
> +     amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_b=
uf);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index f77138b..ab43ae2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1248,6 +1248,7 @@ static int gmc_v9_0_sw_init(void *handle)
>   static int gmc_v9_0_sw_fini(void *handle)
>   {
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     void *stolen_vga_buf;
>
>        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
>                        adev->gmc.umc_ras_if) {
> @@ -1280,7 +1281,7 @@ static int gmc_v9_0_sw_fini(void *handle)
>        amdgpu_vm_manager_fini(adev);
>
>        if (gmc_v9_0_keep_stolen_memory(adev))
> -             amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, NULL)=
;
> +             amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stol=
en_vga_buf);
>
>        amdgpu_gart_table_vram_free(adev);
>        amdgpu_bo_fini(adev);


--_000_DM5PR12MB2535A0267ACFB40B0CECBE1895A20DM5PR12MB2535namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ok, I'll fix that, thanks!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 29, 2019 15:13<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&g=
t;; Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: keep the stolen memory in visib=
le vram region</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 29.08.19 um 05:05 schrieb Tianci Yin:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; stolen memory should be fixed in visible region.<br>
&gt;<br>
&gt; Change-Id: Icbbbd39fd113e93423aad8d2555f4073c08020e5<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 &#43;&#43;&#43=
;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp; | 3 &#43=
;&#43;-<br>
&gt;&nbsp;&nbsp; 2 files changed, 6 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 801f912..dcd32d0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1733,6 &#43;1733,7 @@ int amdgpu_ttm_init(struct amdgpu_device *ad=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gtt_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vis_vram_limit;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void *stolen_vga_buf;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;mma=
n.gtt_window_lock);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -1787,7 &#43;1788,7 @@ int amdgpu_ttm_init(struct amdgpu_device *ad=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_kerne=
l(adev, adev-&gt;gmc.stolen_size, PAGE_SIZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM=
_DOMAIN_VRAM,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-=
&gt;stolen_vga_memory,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, &amp;stolen_vga_=
buf);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;amdgpu: %uM o=
f VRAM memory ready\n&quot;,<br>
&gt; @@ -1851,8 &#43;1852,9 @@ int amdgpu_ttm_init(struct amdgpu_device *ad=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void amdgpu_ttm_late_init(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void *stolen_vga_buf;<br>
<br>
Coding style says we should add a new line between declaration and code.<br=
>
<br>
Apart from that the series is Reviewed-by: Christian K=F6nig <br>
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* return the VGA stolen mem=
ory (if any) back to VRAM */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;stolen_v=
ga_memory, NULL, NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;stol=
en_vga_memory, NULL, &amp;stolen_vga_buf);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index f77138b..ab43ae2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -1248,6 &#43;1248,7 @@ static int gmc_v9_0_sw_init(void *handle)<br=
>
&gt;&nbsp;&nbsp; static int gmc_v9_0_sw_fini(void *handle)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void *stolen_vga_buf;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_supported(=
adev, AMDGPU_RAS_BLOCK__UMC) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;gmc.umc_ras_if) {<br>
&gt; @@ -1280,7 &#43;1281,7 @@ static int gmc_v9_0_sw_fini(void *handle)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_manager_fini(adev)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gmc_v9_0_keep_stolen_mem=
ory(adev))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_bo_free_kernel(&amp;adev-&gt;stolen_vga_memory, NULL, NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;stolen_vga_memory, NULL, &amp;s=
tolen_vga_buf);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gart_table_vram_free(=
adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_fini(adev);<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB2535A0267ACFB40B0CECBE1895A20DM5PR12MB2535namp_--

--===============1446724196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1446724196==--

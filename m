From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/8] drm/amdgpu: update amdgpu_discovery to handle revision
Date: Wed, 16 Oct 2019 02:24:40 +0000
Message-ID: <DM5PR12MB25351094FEEF76BE2325FB1895920@DM5PR12MB2535.namprd12.prod.outlook.com>
References: <20191014032118.14020-1-tianci.yin@amd.com>,
 <e4b046e5-b91a-997c-e47c-dae0360d3a27@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1017752991=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e4b046e5-b91a-997c-e47c-dae0360d3a27-5C7GfCeVMHo@public.gmane.org>
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
To: "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1017752991==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB25351094FEEF76BE2325FB1895920DM5PR12MB2535namp_"

--_000_DM5PR12MB25351094FEEF76BE2325FB1895920DM5PR12MB2535namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Luben!
Patch 8 v2 has sent out, please review again.
________________________________
From: Tuikov, Luben <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 16, 2019 2:01
To: Yin, Tianci (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Chri=
stian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/8] drm/amdgpu: update amdgpu_discovery to handle revi=
sion

Patches 1-7: Looks good.
Reviewed-by: Luben Tuikov <luben.tuikov-5C7GfCeVMHo@public.gmane.org>

Patch 8: NAK! for the same exact reason as the previous review. No changes =
to NAK reasoning from previous review.

Regards,
Luben

On 2019-10-13 11:21 p.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>
>
> update amdgpu_discovery to get IP revision.
>
> Change-Id: If8152103d03b58e1dc0f32db63625e290f5f08a0
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 71198c5318e1..ddd8364102a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -333,7 +333,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>  }
>
>  int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_i=
d,
> -                                 int *major, int *minor)
> +                                 int *major, int *minor, int *revision)
>  {
>        struct binary_header *bhdr;
>        struct ip_discovery_header *ihdr;
> @@ -369,6 +369,8 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_dev=
ice *adev, int hw_id,
>                                        *major =3D ip->major;
>                                if (minor)
>                                        *minor =3D ip->minor;
> +                             if (revision)
> +                                     *revision =3D ip->revision;
>                                return 0;
>                        }
>                        ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_add=
ress - 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h
> index 5a6693d7d269..ba78e15d9b05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -30,7 +30,7 @@ int amdgpu_discovery_init(struct amdgpu_device *adev);
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
>  int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_i=
d,
> -                                    int *major, int *minor);
> +                                    int *major, int *minor, int *revisio=
n);
>  int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
>
>  #endif /* __AMDGPU_DISCOVERY__ */
>


--_000_DM5PR12MB25351094FEEF76BE2325FB1895920DM5PR12MB2535namp_
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
Thanks Luben!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Patch 8 v2 has sent out, please review again.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 16, 2019 2:01<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/8] drm/amdgpu: update amdgpu_discovery to hand=
le revision</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Patches 1-7: Looks good.<br>
Reviewed-by: Luben Tuikov &lt;luben.tuikov-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Patch 8: NAK! for the same exact reason as the previous review. No changes =
to NAK reasoning from previous review.<br>
<br>
Regards,<br>
Luben<br>
<br>
On 2019-10-13 11:21 p.m., Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; <br>
&gt; update amdgpu_discovery to get IP revision.<br>
&gt; <br>
&gt; Change-Id: If8152103d03b58e1dc0f32db63625e290f5f08a0<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 &#43;&#43;&#43=
;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 &#43;-<br>
&gt;&nbsp; 2 files changed, 4 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index 71198c5318e1..ddd8364102a2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -333,7 &#43;333,7 @@ int amdgpu_discovery_reg_base_init(struct amdg=
pu_device *adev)<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, =
int hw_id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *major, int *minor)<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *major, int *minor=
, int *revision)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_discovery_header *=
ihdr;<br>
&gt; @@ -369,6 &#43;369,8 @@ int amdgpu_discovery_get_ip_version(struct amd=
gpu_device *adev, int hw_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *major =3D ip-&gt;major;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (minor)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *minor =3D ip-&gt;minor;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (revision)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; *revision =3D ip-&gt;revision;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_offs=
et &#43;=3D sizeof(*ip) &#43; 4 * (ip-&gt;num_base_address - 1);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.h<br>
&gt; index 5a6693d7d269..ba78e15d9b05 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h<br>
&gt; @@ -30,7 &#43;30,7 @@ int amdgpu_discovery_init(struct amdgpu_device *=
adev);<br>
&gt;&nbsp; void amdgpu_discovery_fini(struct amdgpu_device *adev);<br>
&gt;&nbsp; int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);<=
br>
&gt;&nbsp; int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, =
int hw_id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *maj=
or, int *minor);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
*major, int *minor, int *revision);<br>
&gt;&nbsp; int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);<b=
r>
&gt;&nbsp; <br>
&gt;&nbsp; #endif /* __AMDGPU_DISCOVERY__ */<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB25351094FEEF76BE2325FB1895920DM5PR12MB2535namp_--

--===============1017752991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1017752991==--

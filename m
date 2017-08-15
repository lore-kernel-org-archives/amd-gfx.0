From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 14/19] drm/amdkfd: Add more error printing to help bringup
Date: Tue, 15 Aug 2017 03:50:33 +0000
Message-ID: <CY1PR1201MB109725CE39D52B9E482824FAF08D0@CY1PR1201MB1097.namprd12.prod.outlook.com>
References: <1502488589-30272-1-git-send-email-Felix.Kuehling@amd.com>
 <1502488589-30272-15-git-send-email-Felix.Kuehling@amd.com>,
 <CAFCwf12LtX8Me-DSVvnf72eZr=UQm6sWnBoSuB2DM8jbqk3nOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1298105732=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf12LtX8Me-DSVvnf72eZr=UQm6sWnBoSuB2DM8jbqk3nOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1298105732==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR1201MB109725CE39D52B9E482824FAF08D0CY1PR1201MB1097_"

--_000_CY1PR1201MB109725CE39D52B9E482824FAF08D0CY1PR1201MB1097_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Oded, I agree with you. When I made the change, there was WARN_ON already i=
n the same function lookup_device_info(), so I followed the suit and used W=
ARN again. It is indeed a bit overkill.


Felix, do I need to fix it or can you fix it directly?


Yong

________________________________
From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Saturday, August 12, 2017 10:54:41 AM
To: Kuehling, Felix
Cc: amd-gfx list; Zhao, Yong
Subject: Re: [PATCH 14/19] drm/amdkfd: Add more error printing to help brin=
gup

On Sat, Aug 12, 2017 at 12:56 AM, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> w=
rote:
> From: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
>
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index f628ac3..e1c2ad2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -103,6 +103,8 @@ static const struct kfd_device_info *lookup_device_in=
fo(unsigned short did)
>                 }
>         }
>
> +       WARN(1, "device is not added to supported_devices\n");
> +
I think WARN is a bit excessive here. Its not actually a warning - an
AMD gpu device is present but not supported in amdkfd.
Maybe a dev_info is more appropriate here.

Oded

>         return NULL;
>  }
>
> @@ -114,8 +116,10 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>         const struct kfd_device_info *device_info =3D
>                                         lookup_device_info(pdev->device);
>
> -       if (!device_info)
> +       if (!device_info) {
> +               dev_err(kfd_device, "kgd2kfd_probe failed\n");
>                 return NULL;
> +       }
>
>         kfd =3D kzalloc(sizeof(*kfd), GFP_KERNEL);
>         if (!kfd)
> @@ -364,8 +368,11 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
>
>         if (kfd->init_complete) {
>                 err =3D amd_iommu_init_device(kfd->pdev, pasid_limit);
> -               if (err < 0)
> +               if (err < 0) {
> +                       dev_err(kfd_device, "failed to initialize iommu\n=
");
>                         return -ENXIO;
> +               }
> +
>                 amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
>                                                 iommu_pasid_shutdown_call=
back);
>                 amd_iommu_set_invalid_ppr_cb(kfd->pdev, iommu_invalid_ppr=
_cb);
> --
> 2.7.4
>
With the above fixed, this patch is:
Reviewed-by: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--_000_CY1PR1201MB109725CE39D52B9E482824FAF08D0CY1PR1201MB1097_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Oded, I agree with you. When I made the change, there was WARN_ON alread=
y in the same function lookup_device_info(), so I followed the suit and use=
d WARN again. It is indeed a bit overkill.&nbsp;</p>
<p><br>
</p>
<p>Felix, do I need to fix it or can you fix it directly?</p>
<p><br>
</p>
<p>Yong<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Oded Gabbay &lt;ode=
d.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, August 12, 2017 10:54:41 AM<br>
<b>To:</b> Kuehling, Felix<br>
<b>Cc:</b> amd-gfx list; Zhao, Yong<br>
<b>Subject:</b> Re: [PATCH 14/19] drm/amdkfd: Add more error printing to he=
lp bringup</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Sat, Aug 12, 2017 at 12:56 AM, Felix Kuehling &=
lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; From: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp; 1 file changed, 9 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_device.c<br>
&gt; index f628ac3..e1c2ad2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; @@ -103,6 &#43;103,8 @@ static const struct kfd_device_info *lookup_de=
vice_info(unsigned short did)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(1, &quot;device is not =
added to supported_devices\n&quot;);<br>
&gt; &#43;<br>
I think WARN is a bit excessive here. Its not actually a warning - an<br>
AMD gpu device is present but not supported in amdkfd.<br>
Maybe a dev_info is more appropriate here.<br>
<br>
Oded<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; @@ -114,8 &#43;116,10 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev =
*kgd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd_devic=
e_info *device_info =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lookup_device_info(pdev-&gt;device);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!device_info)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!device_info) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(kfd_device, &quot;kgd2kfd_probe failed\n&quot;)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd =3D kzalloc(sizeof=
(*kfd), GFP_KERNEL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd)<br>
&gt; @@ -364,8 &#43;368,11 @@ int kgd2kfd_resume(struct kfd_dev *kfd)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd-&gt;init_compl=
ete) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; err =3D amd_iommu_init_device(kfd-&gt;pdev, pasid=
_limit);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (err &lt; 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err=
(kfd_device, &quot;failed to initialize iommu\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn -ENXIO;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amd_iommu_set_invalidate_ctx_cb(kfd-&gt;pdev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iommu_p=
asid_shutdown_callback);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amd_iommu_set_invalid_ppr_cb(kfd-&gt;pdev, iommu_=
invalid_ppr_cb);<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
With the above fixed, this patch is:<br>
Reviewed-by: Oded Gabbay &lt;oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
</div>
</span></font>
</body>
</html>

--_000_CY1PR1201MB109725CE39D52B9E482824FAF08D0CY1PR1201MB1097_--

--===============1298105732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1298105732==--

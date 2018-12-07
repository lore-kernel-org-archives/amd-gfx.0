From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: add some additional vega10 pci ids
Date: Fri, 7 Dec 2018 21:16:01 +0000
Message-ID: <BN6PR12MB1809D26AB85CB852B36B355CF7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181207210325.24656-1-alexander.deucher@amd.com>,
 <f61b8451-51bf-cb8f-eb07-f01e3c5361ee@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1666666010=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f61b8451-51bf-cb8f-eb07-f01e3c5361ee-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1666666010==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809D26AB85CB852B36B355CF7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809D26AB85CB852B36B355CF7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Will do.


Alex

________________________________
From: Kuehling, Felix
Sent: Friday, December 7, 2018 4:14:39 PM
To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amdgpu: add some additional vega10 pci ids

Can you add them amdkfd/kfd_device.c as well while you're at it.

Thanks,
  Felix

On 2018-12-07 4:03 p.m., Alex Deucher wrote:
> New vega ids.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 90f474f98b6e..e32f6f43a46b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -873,7 +873,13 @@ static const struct pci_device_id pciidlist[] =3D {
>        {0x1002, 0x6864, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
>        {0x1002, 0x6867, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
>        {0x1002, 0x6868, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
> +     {0x1002, 0x6869, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
> +     {0x1002, 0x686a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
> +     {0x1002, 0x686b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
>        {0x1002, 0x686c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
> +     {0x1002, 0x686d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
> +     {0x1002, 0x686e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
> +     {0x1002, 0x686f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
>        {0x1002, 0x687f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
>        /* Vega 12 */
>        {0x1002, 0x69A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA12},

--_000_BN6PR12MB1809D26AB85CB852B36B355CF7AA0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Will do.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Friday, December 7, 2018 4:14:39 PM<br>
<b>To:</b> Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: add some additional vega10 pci =
ids</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Can you add them amdkfd/kfd_device.c as well while=
 you're at it.<br>
<br>
Thanks,<br>
&nbsp; Felix<br>
<br>
On 2018-12-07 4:03 p.m., Alex Deucher wrote:<br>
&gt; New vega ids.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 &#43;&#43;&#43;&#43;=
&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 6 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 90f474f98b6e..e32f6f43a46b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -873,7 &#43;873,13 @@ static const struct pci_device_id pciidlist[]=
 =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x6864, PCI_ANY_ID,=
 PCI_ANY_ID, 0, 0, CHIP_VEGA10},<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x6867, PCI_ANY_ID,=
 PCI_ANY_ID, 0, 0, CHIP_VEGA10},<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x6868, PCI_ANY_ID,=
 PCI_ANY_ID, 0, 0, CHIP_VEGA10},<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x6869, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, CHIP_VEGA10},<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x686a, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, CHIP_VEGA10},<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x686b, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, CHIP_VEGA10},<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x686c, PCI_ANY_ID,=
 PCI_ANY_ID, 0, 0, CHIP_VEGA10},<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x686d, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, CHIP_VEGA10},<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x686e, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, CHIP_VEGA10},<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x686f, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, CHIP_VEGA10},<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x687f, PCI_ANY_ID,=
 PCI_ANY_ID, 0, 0, CHIP_VEGA10},<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega 12 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x69A0, PCI_ANY_ID,=
 PCI_ANY_ID, 0, 0, CHIP_VEGA12},<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809D26AB85CB852B36B355CF7AA0BN6PR12MB1809namp_--

--===============1666666010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1666666010==--

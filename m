From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/6] kexec fixes
Date: Wed, 9 Jan 2019 01:19:26 +0000
Message-ID: <BN6PR12MB1809E14ADD46C8E974A4E94EF78B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190108221156.24388-1-alexander.deucher@amd.com>,
 <139d62ef-e36c-23ba-785d-914d5383f8d7@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0074291665=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <139d62ef-e36c-23ba-785d-914d5383f8d7-5C7GfCeVMHo@public.gmane.org>
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

--===============0074291665==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809E14ADD46C8E974A4E94EF78B0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809E14ADD46C8E974A4E94EF78B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes, the checks are taken from the existing SMU and PSP code.


Alex

________________________________
From: Kuehling, Felix
Sent: Tuesday, January 8, 2019 6:22:48 PM
To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: Re: [PATCH 0/6] kexec fixes

Thanks for this. I trust that your method for detecting that SMU or PSP
are running is correct. With that caveat the series is Reviewed-by:
Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

Regards,
  Felix

On 2019-01-08 5:11 p.m., Alex Deucher wrote:
> Fixes for kexec.  The GPU needs to be reset before the driver
> can be loaded again reliably.  Needed for kexec for booting some
> ppc platforms.  See:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D108585
>
> Alex Deucher (6):
>   drm/amdgpu: add need_reset_on_init asic callback (v2)
>   drm/amdgpu/si: add need_reset_on_init asic callback for SI (v2)
>   drm/amdgpu/cik: add need_reset_on_init asic callback for CIK (v2)
>   drm/amdgpu/vi: add need_reset_on_init asic callback for VI (v2)
>   drm/amdgpu/soc15: add need_reset_on_init asic callback for SOC15 (v2)
>   drm/amdgpu: check if we need to reset at init time (v2)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/cik.c           | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/si.c            |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 20 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/vi.c            | 18 ++++++++++++++++++
>  6 files changed, 76 insertions(+)
>

--_000_BN6PR12MB1809E14ADD46C8E974A4E94EF78B0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Yes, the checks are taken from th=
e existing SMU and PSP code.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Tuesday, January 8, 2019 6:22:48 PM<br>
<b>To:</b> Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 0/6] kexec fixes</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Thanks for this. I trust that your method for dete=
cting that SMU or PSP<br>
are running is correct. With that caveat the series is Reviewed-by:<br>
Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
On 2019-01-08 5:11 p.m., Alex Deucher wrote:<br>
&gt; Fixes for kexec.&nbsp; The GPU needs to be reset before the driver<br>
&gt; can be loaded again reliably.&nbsp; Needed for kexec for booting some<=
br>
&gt; ppc platforms.&nbsp; See:<br>
&gt; <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D108585">http=
s://bugs.freedesktop.org/show_bug.cgi?id=3D108585</a><br>
&gt;<br>
&gt; Alex Deucher (6):<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add need_reset_on_init asic callback (v2)<br>
&gt;&nbsp;&nbsp; drm/amdgpu/si: add need_reset_on_init asic callback for SI=
 (v2)<br>
&gt;&nbsp;&nbsp; drm/amdgpu/cik: add need_reset_on_init asic callback for C=
IK (v2)<br>
&gt;&nbsp;&nbsp; drm/amdgpu/vi: add need_reset_on_init asic callback for VI=
 (v2)<br>
&gt;&nbsp;&nbsp; drm/amdgpu/soc15: add need_reset_on_init asic callback for=
 SOC15 (v2)<br>
&gt;&nbsp;&nbsp; drm/amdgpu: check if we need to reset at init time (v2)<br=
>
&gt;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/cik.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 18 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/si.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;&#43;&#43;&#43;<=
br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; | 20 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 18 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 6 files changed, 76 insertions(&#43;)<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809E14ADD46C8E974A4E94EF78B0BN6PR12MB1809namp_--

--===============0074291665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0074291665==--

From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdkfd: add new vega10 pci ids
Date: Fri, 7 Dec 2018 22:10:58 +0000
Message-ID: <BN6PR12MB1809A1EB60355186A3FE076AF7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181207212610.3680-1-alexander.deucher@amd.com>,
 <1f03be2a-fc64-6b92-7c69-3d816c914a7b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0606714531=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1f03be2a-fc64-6b92-7c69-3d816c914a7b-5C7GfCeVMHo@public.gmane.org>
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
Cc: "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============0606714531==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A1EB60355186A3FE076AF7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A1EB60355186A3FE076AF7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Care to review the amdgpu series as well?

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kuehling=
, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, December 7, 2018 4:38:20 PM
To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amdkfd: add new vega10 pci ids

On 2018-12-07 4:26 p.m., Alex Deucher wrote:
> New vega10 ids.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

The series is Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>


> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 9ed14a11afa2..b78b3c2fa9d8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -378,7 +378,13 @@ static const struct kfd_deviceid supported_devices[]=
 =3D {
>        { 0x6864, &vega10_device_info },        /* Vega10 */
>        { 0x6867, &vega10_device_info },        /* Vega10 */
>        { 0x6868, &vega10_device_info },        /* Vega10 */
> +     { 0x6869, &vega10_device_info },        /* Vega10 */
> +     { 0x686A, &vega10_device_info },        /* Vega10 */
> +     { 0x686B, &vega10_device_info },        /* Vega10 */
>        { 0x686C, &vega10_vf_device_info },     /* Vega10  vf*/
> +     { 0x686D, &vega10_device_info },        /* Vega10 */
> +     { 0x686E, &vega10_device_info },        /* Vega10 */
> +     { 0x686F, &vega10_device_info },        /* Vega10 */
>        { 0x687F, &vega10_device_info },        /* Vega10 */
>        { 0x69A0, &vega12_device_info },        /* Vega12 */
>        { 0x69A1, &vega12_device_info },        /* Vega12 */
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809A1EB60355186A3FE076AF7AA0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Care to review the amdgpu series =
as well?<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kuehling, Felix &lt;Felix.Kue=
hling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, December 7, 2018 4:38:20 PM<br>
<b>To:</b> Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdkfd: add new vega10 pci ids</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-12-07 4:26 p.m., Alex Deucher wrote:<br>
&gt; New vega10 ids.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
The series is Reviewed-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br=
>
<br>
<br>
&gt; Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 &#43;&#43;&#43;&#43;=
&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 6 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_device.c<br>
&gt; index 9ed14a11afa2..b78b3c2fa9d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; @@ -378,7 &#43;378,13 @@ static const struct kfd_deviceid supported_de=
vices[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x6864, &amp;vega10_device=
_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x6867, &amp;vega10_device=
_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x6868, &amp;vega10_device=
_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { 0x6869, &amp;vega10_device_info },&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { 0x686A, &amp;vega10_device_info },&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { 0x686B, &amp;vega10_device_info },&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x686C, &amp;vega10_vf_dev=
ice_info },&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10&nbsp; vf*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { 0x686D, &amp;vega10_device_info },&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { 0x686E, &amp;vega10_device_info },&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { 0x686F, &amp;vega10_device_info },&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x687F, &amp;vega10_device=
_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega10 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x69A0, &amp;vega12_device=
_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega12 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x69A1, &amp;vega12_device=
_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vega12 */<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809A1EB60355186A3FE076AF7AA0BN6PR12MB1809namp_--

--===============0606714531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0606714531==--

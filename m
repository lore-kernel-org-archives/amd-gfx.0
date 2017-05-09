From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix errors in comments.
Date: Tue, 9 May 2017 01:29:19 +0000
Message-ID: <MWHPR1201MB00452DA14DCC62C768910D38F2EF0@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <1494257533-11422-1-git-send-email-AlexBin.Xie@amd.com>,
 <042fa611-ad61-db65-2266-db9c6b6061b9@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1816580166=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <042fa611-ad61-db65-2266-db9c6b6061b9-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1816580166==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB00452DA14DCC62C768910D38F2EF0MWHPR1201MB0045_"

--_000_MWHPR1201MB00452DA14DCC62C768910D38F2EF0MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Michel,


The code change has been submitted into our internal git server.

I have a follow up commit in another email thread.

The commit fixes more errors in comments.


Thanks,

Alex Bin

________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Monday, May 8, 2017 9:13 PM
To: Xie, AlexBin
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: fix errors in comments.

On 09/05/17 12:32 AM, Alex Xie wrote:
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 66bb60e..aab3206 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -479,9 +479,8 @@ void amdgpu_doorbell_get_kfd_info(struct amdgpu_devic=
e *adev,
>
>  /*
>   * amdgpu_wb_*()
> - * Writeback is the the method by which the the GPU updates special page=
s
> - * in memory with the status of certain GPU events (fences, ring pointer=
s,
> - * etc.).
> + * Writeback is the method by which GPU updates special pages in memory

This should still say "the GPU".


> + * with the status of certain GPU events (fences, ring pointers,etc.).
>   */
>
>  /**
> @@ -507,7 +506,7 @@ static void amdgpu_wb_fini(struct amdgpu_device *adev=
)
>   *
>   * @adev: amdgpu_device pointer
>   *
> - * Disables Writeback and frees the Writeback memory (all asics).
> + * Initialize writeback and allocates writeback memory (all asics).

For consistency, this should say either "Initialize writeback and
allocate writeback memory" or "Initializes writeback and allocates
writeback memory".


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--_000_MWHPR1201MB00452DA14DCC62C768910D38F2EF0MWHPR1201MB0045_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Michel,</p>
<p><br>
</p>
<p>The code change has been submitted into our internal git server.</p>
<p>I have a follow up commit in another email thread.</p>
<p>The commit fixes more <span>errors</span> in comments.<br>
</p>
<p><br>
</p>
<p>Thanks,</p>
<p>Alex Bin<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Michel D=E4nzer &lt=
;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, May 8, 2017 9:13 PM<br>
<b>To:</b> Xie, AlexBin<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix errors in comments.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 09/05/17 12:32 AM, Alex Xie wrote:<br>
&gt; Signed-off-by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 &#43;&#43;&#43;--=
--<br>
&gt;&nbsp; 1 file changed, 3 insertions(&#43;), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 66bb60e..aab3206 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -479,9 &#43;479,8 @@ void amdgpu_doorbell_get_kfd_info(struct amdgp=
u_device *adev,<br>
&gt;&nbsp; <br>
&gt;&nbsp; /*<br>
&gt;&nbsp;&nbsp; * amdgpu_wb_*()<br>
&gt; - * Writeback is the the method by which the the GPU updates special p=
ages<br>
&gt; - * in memory with the status of certain GPU events (fences, ring poin=
ters,<br>
&gt; - * etc.).<br>
&gt; &#43; * Writeback is the method by which GPU updates special pages in =
memory<br>
<br>
This should still say &quot;the GPU&quot;.<br>
<br>
<br>
&gt; &#43; * with the status of certain GPU events (fences, ring pointers,e=
tc.).<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; <br>
&gt;&nbsp; /**<br>
&gt; @@ -507,7 &#43;506,7 @@ static void amdgpu_wb_fini(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt;&nbsp;&nbsp; *<br>
&gt; - * Disables Writeback and frees the Writeback memory (all asics).<br>
&gt; &#43; * Initialize writeback and allocates writeback memory (all asics=
).<br>
<br>
For consistency, this should say either &quot;Initialize writeback and<br>
allocate writeback memory&quot; or &quot;Initializes writeback and allocate=
s<br>
writeback memory&quot;.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
" id=3D"LPlnk618937" previewremoved=3D"true">
http://www.amd.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB00452DA14DCC62C768910D38F2EF0MWHPR1201MB0045_--

--===============1816580166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1816580166==--

From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Update VM function point when VM state changed.
Date: Wed, 14 Aug 2019 15:08:30 +0000
Message-ID: <BN6PR12MB1809DCC56C3DC599C9317270F7AD0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1565794853-25275-1-git-send-email-gaba@amd.com>,
 <d21d6399-fe1d-72b1-167a-c117c2a34a6b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0378470546=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d21d6399-fe1d-72b1-167a-c117c2a34a6b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Ba, Gang" <Gang.Ba-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0378470546==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DCC56C3DC599C9317270F7AD0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DCC56C3DC599C9317270F7AD0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please also include a patch description so we understand why this change is=
 needed.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, August 14, 2019 11:06 AM
To: Ba, Gang <Gang.Ba-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@list=
s.freedesktop.org>
Cc: Ba, Gang <Gang.Ba-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Update VM function point when VM state changed.

Am 14.08.19 um 17:01 schrieb Gang Ba:
> Change-Id: Ibcfada560a00c9aeebfd922ae48de920e44a5866
> Signed-off-by: Gang Ba <gaba-5C7GfCeVMHo@public.gmane.org>

Good catch, but there is a problem below.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index c1baf3d..72dd434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2862,6 +2862,12 @@ int amdgpu_vm_make_compute(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm, uns
>        WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visible=
(&adev->gmc)),
>                  "CPU update of VM recommended only for large BAR system\=
n");
>
> +     if (vm->use_cpu_for_update)
> +             vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> +     else
> +             vm->update_funcs =3D &amdgpu_vm_sdma_funcs;
> +     vm->last_update =3D NULL;

You can't just set last_update to NULL or your would leak the memory the
fence occupies. So this needs to be:

dma_fence_put(vm->last_update);
vm->last_update =3D NULL;

Regards,
Christian.

> +
>        if (vm->pasid) {
>                unsigned long flags;
>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809DCC56C3DC599C9317270F7AD0BN6PR12MB1809namp_
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
Please also include a patch description so we understand why this change is=
 needed.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K&ouml;nig &lt;ckoe=
nig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 14, 2019 11:06 AM<br>
<b>To:</b> Ba, Gang &lt;Gang.Ba-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Ba, Gang &lt;Gang.Ba-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] Update VM function point when VM state changed.=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 14.08.19 um 17:01 schrieb Gang Ba:<br>
&gt; Change-Id: Ibcfada560a00c9aeebfd922ae48de920e44a5866<br>
&gt; Signed-off-by: Gang Ba &lt;gaba-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Good catch, but there is a problem below.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 &#43;&#43;&#43;=
&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 6 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index c1baf3d..72dd434 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -2862,6 &#43;2862,12 @@ int amdgpu_vm_make_compute(struct amdgpu_de=
vice *adev, struct amdgpu_vm *vm, uns<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_fo=
r_update &amp;&amp; !amdgpu_gmc_vram_full_visible(&amp;adev-&gt;gmc)),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;CPU update of VM recommended only for=
 large BAR system\n&quot;);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vm-&gt;update_funcs =3D &amp;amdgpu_vm_cpu_funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vm-&gt;update_funcs =3D &amp;amdgpu_vm_sdma_funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;last_update =3D NULL;<br>
<br>
You can't just set last_update to NULL or your would leak the memory the <b=
r>
fence occupies. So this needs to be:<br>
<br>
dma_fence_put(vm-&gt;last_update);<br>
vm-&gt;last_update =3D NULL;<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt;&nbsp;&nbsp; <br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809DCC56C3DC599C9317270F7AD0BN6PR12MB1809namp_--

--===============0378470546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0378470546==--

From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: release allocated memory
Date: Mon, 23 Sep 2019 12:35:40 +0000
Message-ID: <BN6PR12MB1809C096DD42018B33EDFC4FF7850@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190920224915.2788-1-navid.emamdoost@gmail.com>,
 <06d1d086-0628-829b-766f-e1f614fab909@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0138931614=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <06d1d086-0628-829b-766f-e1f614fab909-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Navid Emamdoost <navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "kjlu-OJFnDUYgAso@public.gmane.org" <kjlu-OJFnDUYgAso@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "emamd001-OJFnDUYgAso@public.gmane.org" <emamd001-OJFnDUYgAso@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "smccaman-OJFnDUYgAso@public.gmane.org" <smccaman-OJFnDUYgAso@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>

--===============0138931614==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809C096DD42018B33EDFC4FF7850BN6PR12MB1809namp_"

--_000_BN6PR12MB1809C096DD42018B33EDFC4FF7850BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Maybe add a comment here in the code to avoid confusion in the future.

Alex
________________________________
From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Sent: Saturday, September 21, 2019 7:32 AM
To: Navid Emamdoost <navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: emamd001-OJFnDUYgAso@public.gmane.org <emamd001-OJFnDUYgAso@public.gmane.org>; smccaman-OJFnDUYgAso@public.gmane.org <smccaman-OJFnDUYgAso@public.gmane.org=
>; kjlu-OJFnDUYgAso@public.gmane.org <kjlu-OJFnDUYgAso@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@amd.c=
om>; Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; David Airlie <airlied@lin=
ux.ie>; Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>; Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>; R=
ex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org>; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: release allocated memory

Am 21.09.19 um 00:49 schrieb Navid Emamdoost:
> In amdgpu_vmid_grab_idle, fences is being leaked in one execution path.
> The missing kfree was added.

NAK, the array is freed by the dma_fence_array.  This is a double free.

Regards,
Christian.

>
> Signed-off-by: Navid Emamdoost <navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index 57b3d8a9bef3..9063cd36fa94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -244,6 +244,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm=
,
>                r =3D amdgpu_sync_fence(adev, sync, &array->base, false);
>                dma_fence_put(ring->vmid_wait);
>                ring->vmid_wait =3D &array->base;
> +             kfree(fences);
>                return r;
>        }
>        kfree(fences);


--_000_BN6PR12MB1809C096DD42018B33EDFC4FF7850BN6PR12MB1809namp_
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
Maybe add a comment here in the code to avoid confusion in the future.</div=
>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, September 21, 2019 7:32 AM<br>
<b>To:</b> Navid Emamdoost &lt;navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Cc:</b> emamd001-OJFnDUYgAso@public.gmane.org &lt;emamd001-OJFnDUYgAso@public.gmane.org&gt;; smccaman-OJFnDUYgAso@public.gmane.org &lt;=
smccaman-OJFnDUYgAso@public.gmane.org&gt;; kjlu-OJFnDUYgAso@public.gmane.org &lt;kjlu-OJFnDUYgAso@public.gmane.org&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Zhou, David(ChunMing) &lt;David1.Zhou@a=
md.com&gt;; David Airlie &lt;airlied-cv59FeDIM0c@public.gmane.org&gt;; Daniel Vetter &lt;daniel=
@ffwll.ch&gt;;
 Sam Ravnborg &lt;sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org&gt;; Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; dri-deve=
l@lists.freedesktop.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; linux-kern=
el-u79uwXL29TY76Z2rM5mHXA@public.gmane.org &lt;linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: release allocated memory</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 21.09.19 um 00:49 schrieb Navid Emamdoost:<br>
&gt; In amdgpu_vmid_grab_idle, fences is being leaked in one execution path=
.<br>
&gt; The missing kfree was added.<br>
<br>
NAK, the array is freed by the dma_fence_array.&nbsp; This is a double free=
.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Navid Emamdoost &lt;navid.emamdoost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 1 &#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ids.c<br>
&gt; index 57b3d8a9bef3..9063cd36fa94 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c<br>
&gt; @@ -244,6 &#43;244,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu=
_vm *vm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_sync_fence(adev, sync, &amp;array-&gt;base=
, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dma_fence_put(ring-&gt;vmid_wait);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ring-&gt;vmid_wait =3D &amp;array-&gt;base;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kfree(fences);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(fences);<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809C096DD42018B33EDFC4FF7850BN6PR12MB1809namp_--

--===============0138931614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0138931614==--

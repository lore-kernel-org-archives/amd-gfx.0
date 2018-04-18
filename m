From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: print DMA-buf status in debugfs
Date: Wed, 18 Apr 2018 14:15:10 +0000
Message-ID: <BN6PR12MB1809586926B9FB9D43B8F004F7B60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180411130959.1690-1-christian.koenig@amd.com>,
 <1aa486ab-5c15-5f56-9465-0d4bef5d2290@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1221382921=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1aa486ab-5c15-5f56-9465-0d4bef5d2290-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1221382921==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809586926B9FB9D43B8F004F7B60BN6PR12MB1809namp_"

--_000_BN6PR12MB1809586926B9FB9D43B8F004F7B60BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, April 18, 2018 6:13:09 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: print DMA-buf status in debugfs

Ping? Could anybody review that?

Thanks,
Christian.

Am 11.04.2018 um 15:09 schrieb Christian K=F6nig:
> Just note if a BO was imported/exported.
>
> Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 28c2706e48d7..93d3f333444b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -765,6 +765,8 @@ static int amdgpu_debugfs_gem_bo_info(int id, void *p=
tr, void *data)
>        struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(gobj);
>        struct seq_file *m =3D data;
>
> +     struct dma_buf_attachment *attachment;
> +     struct dma_buf *dma_buf;
>        unsigned domain;
>        const char *placement;
>        unsigned pin_count;
> @@ -793,6 +795,15 @@ static int amdgpu_debugfs_gem_bo_info(int id, void *=
ptr, void *data)
>        pin_count =3D READ_ONCE(bo->pin_count);
>        if (pin_count)
>                seq_printf(m, " pin count %d", pin_count);
> +
> +     dma_buf =3D READ_ONCE(bo->gem_base.dma_buf);
> +     attachment =3D READ_ONCE(bo->gem_base.import_attach);
> +
> +     if (attachment)
> +             seq_printf(m, " imported from %p", dma_buf);
> +     else if (dma_buf)
> +             seq_printf(m, " exported as %p", dma_buf);
> +
>        seq_printf(m, "\n");
>
>        return 0;

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809586926B9FB9D43B8F004F7B60BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, April 18, 2018 6:13:09 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: print DMA-buf status in debugfs</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping? Could anybody review that?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 11.04.2018 um 15:09 schrieb Christian K=F6nig:<br>
&gt; Just note if a BO was imported/exported.<br>
&gt;<br>
&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 11 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gem.c<br>
&gt; index 28c2706e48d7..93d3f333444b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt; @@ -765,6 &#43;765,8 @@ static int amdgpu_debugfs_gem_bo_info(int id, =
void *ptr, void *data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D gem=
_to_amdgpu_bo(gobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct seq_file *m =3D data;=
<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attachment;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf *dma_buf;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned domain;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *placement;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned pin_count;<br>
&gt; @@ -793,6 &#43;795,15 @@ static int amdgpu_debugfs_gem_bo_info(int id,=
 void *ptr, void *data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pin_count =3D READ_ONCE(bo-&=
gt;pin_count);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pin_count)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot; pin count %d&quot;, pin_count);<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dma_buf =3D READ_ONCE(bo-&gt;gem_base.dm=
a_buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; attachment =3D READ_ONCE(bo-&gt;gem_base=
.import_attach);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (attachment)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; seq_printf(m, &quot; imported from %p&quot;, dma_buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (dma_buf)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; seq_printf(m, &quot; exported as %p&quot;, dma_buf);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\n&quot;=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809586926B9FB9D43B8F004F7B60BN6PR12MB1809namp_--

--===============1221382921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1221382921==--

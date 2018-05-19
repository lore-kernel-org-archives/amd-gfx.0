From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/7] drm/amdgpu: init zfb start address and size
Date: Sat, 19 May 2018 18:32:11 +0200
Message-ID: <CA+nq7DsP5kUbe90qXyFxD10zq_NVU34qETG6t_YxNPEfxU3UFQ@mail.gmail.com>
References: <20180515145008.11937-1-alexander.deucher@amd.com>
 <20180515145008.11937-4-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1649897343=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180515145008.11937-4-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1649897343==
Content-Type: multipart/alternative; boundary="0000000000000139c6056c919d2d"

--0000000000000139c6056c919d2d
Content-Type: text/plain; charset="UTF-8"

Den tis 15 maj 2018 16:50Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> skrev:

> From: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
>
> Use module parameter passed from user to initialize zfb start address
> and size.
>
> Signed-off-by: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> Acked-by: John Bridgman <john.bridgman-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 887f7c9e84e0..b175178345aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1010,6 +1010,15 @@ static void amdgpu_device_check_arguments(struct
> amdgpu_device *adev)
>         }
>
>         adev->firmware.load_type = amdgpu_ucode_get_load_type(adev,
> amdgpu_fw_load_type);
> +
> +       if (amdgpu_zfb[0] > 0) {
> +               dev_warn(adev->dev, "Zero Fram Buffer is enabled\n");
>

s/Fram/Frame/

BR
Nils

+               adev->gmc.zfb_phys_addr = amdgpu_zfb[1] << 20;
> +               adev->gmc.zfb_size = amdgpu_zfb[0] << 20;
> +       } else {
> +               adev->gmc.zfb_phys_addr = 0;
> +               adev->gmc.zfb_size = 0;
> +       }
>  }
>
>  /**
> --
> 2.13.6
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000000139c6056c919d2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
Den tis 15 maj 2018 16:50Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gma=
il.com">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; skrev:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">From: Feifei Xu &lt;<a href=3D"mailto:Feifei.Xu-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank" rel=3D"noreferrer">Feifei.Xu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Use module parameter passed from user to initialize zfb start address<br>
and size.<br>
<br>
Signed-off-by: Feifei Xu &lt;<a href=3D"mailto:Feifei.Xu-5C7GfCeVMHo@public.gmane.org" target=3D=
"_blank" rel=3D"noreferrer">Feifei.Xu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Signed-off-by: Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org" t=
arget=3D"_blank" rel=3D"noreferrer">Hawking.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Acked-by: John Bridgman &lt;<a href=3D"mailto:john.bridgman-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank" rel=3D"noreferrer">john.bridgman-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank" rel=3D"noreferrer">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
" target=3D"_blank" rel=3D"noreferrer">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br=
>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 887f7c9e84e0..b175178345aa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1010,6 +1010,15 @@ static void amdgpu_device_check_arguments(struct amd=
gpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;firmware.load_type =3D amdgpu_ucode_ge=
t_load_type(adev, amdgpu_fw_load_type);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_zfb[0] &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(adev-&gt;d=
ev, &quot;Zero Fram Buffer is enabled\n&quot;);<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">s/Fram/Frame/</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">BR</div><div dir=3D"auto">Nils</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gmc.zfb_ph=
ys_addr =3D amdgpu_zfb[1] &lt;&lt; 20;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gmc.zfb_si=
ze =3D amdgpu_zfb[0] &lt;&lt; 20;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gmc.zfb_ph=
ys_addr =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gmc.zfb_si=
ze =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div></div></div>

--0000000000000139c6056c919d2d--

--===============1649897343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1649897343==--
